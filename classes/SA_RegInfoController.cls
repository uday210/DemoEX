public class SA_RegInfoController {

    public SA_RegInfoController(){
        
        EventId= Apexpages.currentPage().getparameters().get('id');
        displayEAMs();       
        
    }
    
    
    public Pagereference displayEAMs(){
    
       
        
        EAMsList= new LIST<LIST<Event_Attendee_Mapping__c>>();
        LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
        EAMList= [SELECT ID, AS_id__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_LastName__c, AS_id__r.AS_Email__c, AS_id__r.AS_Company__c, TicketTypesBP__c, GuestType__c,
                  (SELECT ID FROM Registration_Info__r) 
                  FROM Event_Attendee_Mapping__c WHERE EV_id__c =: EventId];
        
        LIST<Event_Attendee_Mapping__c> EAMList999= new LIST<Event_Attendee_Mapping__c>();       
        for(Event_Attendee_Mapping__c eam: EAMList){
            LIST<Dummay__c>  RegInfoList= new LIST<Dummay__c>();
            RegInfoList= eam.Registration_Info__r;
            if(RegInfoList.size() == 0){
                EAMList999.add(eam);
                if(EAMList999.size() == 999){
                   EAMsList.add(EAMList999); 
                   EAMList999= new LIST<Event_Attendee_Mapping__c>();
                }
            }
        }
        
        if(EAMList999.size() != 0){
            EAMsList.add(EAMList999); 
        }
        
    
    return null;
    }
    
   
    public String EventId{get; set;}
    public LIST<LIST<Event_Attendee_Mapping__c>> EAMsList{get; set;}
    public String SelectedEAMId{get; set;}
    public String SelectedTicketName{get; set;}
    public MAP<String, TicketTypes__c> TicketNamesListMAP{get; set;}
    
    public PageReference createRegInfo() {
        
        SelectedEAMId= Apexpages.currentPage().getparameters().get('EAMId');
        SelectedTicketName= Apexpages.currentPage().getparameters().get('TicketName'); 
        TicketTypes__c decreaseTicketQuantity= new TicketTypes__c();
        system.debug('  SELECTED TICKET NAME  '+SelectedTicketName);
        
        Event_Attendee_Mapping__c EAMDetails= new Event_Attendee_Mapping__c();
        EAMDetails= [SELECT ID, AS_id__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_LastName__c, AS_id__r.AS_Email__c, AS_id__r.AS_Company__c, TicketTypesBP__c, GuestType__c 
                     FROM Event_Attendee_Mapping__c WHERE ID =: SelectedEAMId];       
      
        TicketNamesListMAP= new MAP<String, TicketTypes__c>();
        LIST<TicketTypes__c>  TicketNamesList= new LIST<TicketTypes__c>();
        TicketNamesList= [SELECT Id,TT_Name__c,EV_id__c,TT_Amount__c,TT_Available__c, TT_TicketType__c, Ticket_Category__c, Available__c, TT_Sold__c 
                          FROM TicketTypes__c 
                          WHERE EV_id__c =: EventId
                          AND (TT_Name__c =: '2 Day Registration(Sponsor)' OR TT_Name__c =: 'Wednesday Only Registration(Sponsor)' OR TT_Name__c =: 'Tuesday Only Registration(Sponsor)')];         
        
        for(TicketTypes__c tic: TicketNamesList){
            TicketNamesListMAP.put(tic.TT_Name__c, tic);
        }
                        
        Constomer__c cus  = new Constomer__c();
        cus.Email__c= EAMDetails.AS_id__r.AS_Email__c;
        cus.Customer_Name__c= EAMDetails.AS_id__r.AS_FirstName__c+' '+EAMDetails.AS_id__r.AS_LastName__c;
        cus.Isinserted__c = true;
        cus.Total_Amount__c= 0;
        cus.ScanAttendee_Fee__c= 0;
        Database.Insert(cus,False);
                        
            
        Dummay__c insertRegInfo= new Dummay__c();
        insertRegInfo.First_Name__c= EAMDetails.AS_id__r.AS_FirstName__c;
        insertRegInfo.Last_Name__c= EAMDetails.AS_id__r.AS_LastName__c;
        insertRegInfo.Company__c= EAMDetails.AS_id__r.AS_Company__c;
        insertRegInfo.Email__c= EAMDetails.AS_id__r.AS_Email__c;
        insertRegInfo.Event__c= EventId;
        insertRegInfo.temp__c= EAMDetails.AS_id__r.AS_Email__c;
        insertRegInfo.Tickets_Quantty__c= 1;
        insertRegInfo.AttendeeSummary__c= EAMDetails.AS_id__c;
        insertRegInfo.Event_Attendee_Mapping__c= EAMDetails.Id;
        insertRegInfo.customer_key__c= cus.Id;
        insertRegInfo.ScanAttendee_Fee__c= 0;
        insertRegInfo.TicketAmount__c=0;        
        
        if(EAMDetails.TicketTypesBP__c == '2 Day Registration'){
            insertRegInfo.TicketTypes__c= TicketNamesListMAP.get('2 Day Registration(Sponsor)').Id;
            decreaseTicketQuantity= TicketNamesListMAP.get('2 Day Registration(Sponsor)');
        }else if(EAMDetails.TicketTypesBP__c == 'Wednesday Only Registration'){
            insertRegInfo.TicketTypes__c= TicketNamesListMAP.get('Wednesday Only Registration(Sponsor)').Id;
            decreaseTicketQuantity= TicketNamesListMAP.get('Wednesday Only Registration(Sponsor)');
        }else if(EAMDetails.TicketTypesBP__c == 'Tuesday Only Registration'){
            insertRegInfo.TicketTypes__c= TicketNamesListMAP.get('Tuesday Only Registration(Sponsor)').Id;
            decreaseTicketQuantity= TicketNamesListMAP.get('Tuesday Only Registration(Sponsor)');
        }
        
        insertRegInfo.TicketAmount__c= 0;            
        
        insertRegInfo.temp3__c= SelectedTicketName;
        insertRegInfo.Payment_Status__c= 'Free';
        insertRegInfo.Payment_Type__c= 'Free';
        


        decreaseTicketQuantity.TT_Sold__c +=1;
        
        Database.Insert(insertRegInfo, FALSE);
        Database.Update(decreaseTicketQuantity, FALSE);
        displayEAMs();        
        return null;
    }



}