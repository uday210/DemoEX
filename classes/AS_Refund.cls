@RestResource(urlMapping='/AS_Refund/*')
global with sharing class AS_Refund{

    @HttpPost
    global static Container doPost(){
        RestRequest request = RestContext.request;
        RestResponse response  = RestContext.response;
        String TransactionId = request.params.get('TransactionId');
        system.debug('%%% '+TransactionId);
        String RefundMode = request.params.get('RefundMode');  
        LIST<String> RegTicketNumber = new LIST<String>();
        LIST<String> Amount = new LIST<String>();
        LIST<Individual_Ticket_Info__c> ITIList = new LIST<Individual_Ticket_Info__c>();
        LIST<TicketTypes__c> TicketList = new  LIST<TicketTypes__c>();
        LIST<Item__c> ItemList = new LIST<Item__c>();
        String jSONRequestBody=request.requestBody.toString().trim(); 
        System.debug('JsonBody '+jSONRequestBody);
        JSONParser jsonParser = JSON.createParser(jSONRequestBody); 
        
        while(jsonParser.nextToken() != null){
        
            if(jsonParser.getCurrentToken() == JSONToken.START_ARRAY){
            
                while(jsonParser.nextToken() != JSONToken.END_ARRAY){
                
                    if(jsonParser.getText()=='RegTicketNumber'){
                        jsonParser.nextToken();
                        RegTicketNumber.add(jsonParser.getText());                          
                    }
                    
                    if(jsonParser.getText()=='Amount'){
                        jsonParser.nextToken();
                        Amount.add(jsonParser.getText());                          
                    }
                }
            }
        }
        system.debug(RegTicketNumber.size()+'   REG TICKET NUMBER SIZE  '+RegTicketNumber);
        // Response
        Container ct = new Container();
        List<Ticket_Details> tt=new List<Ticket_Details>();  
        List<Item_Details> it=new List<Item_Details>(); 
        SET<TicketTypes__c> SetTicketList = new SET<TicketTypes__c>();
        LIST<TicketTypes__c> ListTicketList = new LIST<TicketTypes__c>();
        SET<Item__c> SetItemList = new SET<Item__c>();
        LIST<Item__c> ListItemList = new LIST<Item__c>();
        
        system.debug(RegTicketNumber.size()+'    IND INFO IDS   '+RegTicketNumber);
        MAP<ID, TicketTypes__c> UpdateTicketTypesMAP= new MAP<ID, TicketTypes__c>();
        MAP<ID, Item__c> UpdateItemsMAP= new MAP<ID, Item__c>();
        try{
            for(integer i=0;i<RegTicketNumber.size();i++){
               Individual_Ticket_Info__c ITI = new Individual_Ticket_Info__c();
               ITI = [SELECT Id,isItem__c,isCancelled__c,isCheckedin__c,Refund_Amount__c,Refund_Date__c,Refund_Mode__c,Registration_Info__r.Item__c,Registration_Info__r.TicketTypes__r.Id,Registration_Info__r.Item__r.Id,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c FROM Individual_Ticket_Info__c WHERE Name =: RegTicketNumber[i] LIMIT 1];
               ITI.isCancelled__c = TRUE;
               ITI.Refund_Amount__c = Decimal.valueOf(Amount[i]);
               ITI.Refund_Date__c = Datetime.now();
               ITI.Refund_Mode__c = RefundMode;
               ITIList.add(ITI);
               system.debug('****** '+ITI);
                   
               if(ITI.Registration_Info__r.Item__c != NULL){
                   system.debug('%%%%% '+ITI);
                   Item__c Item = new Item__c();
                   if(! UpdateItemsMAP.containsKey(ITI.Registration_Info__r.Item__r.Id)){
                       Item = [SELECT Id,Item_name__c,Sold_Quantity__c FROM Item__c WHERE Id =: ITI.Registration_Info__r.Item__r.Id LIMIT 1];
                       Item.Sold_Quantity__c = Item.Sold_Quantity__c -1;  
                       UpdateItemsMAP.put(Item.Id, Item);                                 
                       //ItemList.add(Item); 
                   }else if(UpdateItemsMAP.containsKey(ITI.Registration_Info__r.Item__r.Id)){
                       Item=UpdateItemsMAP.get(ITI.Registration_Info__r.Item__r.Id);
                       Item.Sold_Quantity__c = Item.Sold_Quantity__c -1;  
                       UpdateItemsMAP.put(Item.Id, Item); 
                   }
               }
               else{
                   system.debug('$$$$$ '+ITI);
                   TicketTypes__c TType = new TicketTypes__c();
                   system.debug(' TICKET TYPE ID '+ITI.Registration_Info__r.TicketTypes__r.Id);
                   if(! UpdateTicketTypesMAP.containsKey(ITI.Registration_Info__r.TicketTypes__r.Id)){
                       TType = [SELECT Id,TT_Sold__c FROM TicketTypes__c WHERE Id =: ITI.Registration_Info__r.TicketTypes__r.Id LIMIT 1];
                       system.debug(TType.TT_Sold__c+'  TICKET COST BEFORE PURCHASE');                   
                       TType.TT_Sold__c = TType.TT_Sold__c-1;
                       system.debug(TType.TT_Sold__c+'  TICKET COST AFTER PURCHASE');
                       UpdateTicketTypesMAP.put(TType.Id, TType);
                       //Database.Update(TType, FALSE);
                       //TicketList.add(TType);  
                   }else if(UpdateTicketTypesMAP.containsKey(ITI.Registration_Info__r.TicketTypes__r.Id)){
                       TType= UpdateTicketTypesMAP.get(ITI.Registration_Info__r.TicketTypes__r.Id);
                        TType.TT_Sold__c = TType.TT_Sold__c-1;
                        UpdateTicketTypesMAP.put(TType.Id, TType);                  
                   }
               }
            }
            database.update(ITIList);
            system.debug(ITIList.size()+' IND INFO AFTER UPDATE '+ITIList);
            Database.Update(UpdateTicketTypesMAP.Values(), FALSE);
            TicketList.addAll(UpdateTicketTypesMAP.Values());
            SetTicketList.addAll(TicketList);
            ListTicketList.addAll(SetTicketList);
            //database.update(ListTicketList);
            
            Database.Update(UpdateItemsMAP.Values());
            ItemList.addAll(UpdateItemsMAP.Values());
            SetItemList.addAll(ItemList);
            ListItemList.addAll(SetItemList);
            //database.update(ListItemList);
            
            for(TicketTypes__c t:TicketList){
                Ticket_Details td = new Ticket_Details();
                td.SoldQty = t.TT_Sold__c;
                td.TicketID = t.id;
                tt.add(td);
            }
            
            for(Item__c i:ItemList){
                Item_Details id = new Item_Details ();
                id.SoldQty = i.Sold_Quantity__c;
                id.ItemID = i.id;
                it.add(id);
            }
            
            ct.Message='Success';
            String DateTimeStr;
            try{
                DateTimeStr = ITIList[0].Refund_Date__c.format('MMMM d, yyyy HH:mm a');
            }
            catch(Exception e){} 
            ct.RefundDate = DateTimeStr;
            ct.AttendeeName = ITIList[0].Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c+ ' '+ ITIList[0].Registration_Info__r.Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c;
            ct.Ticket_Details=tt;
            ct.Item_Details=it;
        }
        catch(exception ex){
           ct.Error = ex.getMessage();
        }
        return ct; 
    }
    
    global class Container{
        public String Message{get;set;}
        public String Error{get;set;}
        public String RefundDate{get;set;}
        public String AttendeeName{get;set;}
        public List<Ticket_Details> Ticket_Details{get;set;}
        public List<Item_Details> Item_Details{get;set;}
    }  
    
    global class Ticket_Details{
        public Decimal SoldQty{get;set;}
        public String TicketID{get;set;} 
    }
    global class Item_Details{
        public Decimal SoldQty{get;set;}
        public String ItemID{get;set;} 
    }
    
}