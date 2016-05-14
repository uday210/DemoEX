@RestResource(urlMapping='/AS_TicketItemInfo/*')
  
 global with sharing class AS_TicketItemInfo{
    
   @HttpPost  
   global static JsonResponses doPost() {  
    RestRequest request = RestContext.request;  
    RestResponse response = RestContext.response;  
    String Status=request.params.get('Status');  
    JsonResponses jss=new JsonResponses();
    
    if(Status=='CREATE'){
        String jSONRequestBody=request.requestBody.toString().trim(); 
        System.debug('JsonBody '+jSONRequestBody);
        JSONParser jsonParser = JSON.createParser(jSONRequestBody); 
        List<TicketTypes__c> tckt=new List<TicketTypes__c>();
        
        List<String> tname=new List<String>();
        List<String> eventid=new List<String>();
        List<String> tqty=new List<String>();
        List<String> tpr=new List<String>();
        List<String> owner=new List<String>();
        List<String> mobileid=new List<String>();
        List<String> TicketType=new List<String>();
        List<Blob> TicketImage=new List<Blob>();
        
        while(jsonParser.nextToken() != null){
        
            if(jsonParser.getCurrentToken() == JSONToken.START_ARRAY){
            
                while(jsonParser.nextToken() != JSONToken.END_ARRAY){
                
                    if(jsonParser.getText()=='Ticket_Name'){
                        jsonParser.nextToken();
                        tname.add(jsonParser.getText());                          
                    }
                    
                    if(jsonParser.getText()=='Event_Id'){
                        jsonParser.nextToken();
                        eventid.add(jsonParser.getText());                          
                    }
                    
                    if(jsonParser.getText()=='MobileTicket_Id'){
                        jsonParser.nextToken();
                        mobileid.add(jsonParser.getText());                          
                    }
                    
                    if(jsonParser.getText()=='Ticket_Qty'){
                        jsonParser.nextToken();
                        tqty.add(jsonParser.getText());                          
                    } 
                    
                    if(jsonParser.getText()=='Ticket_Price'){
                        jsonParser.nextToken();
                        tpr.add(jsonParser.getText());                          
                    }
                    
                    if(jsonParser.getText()=='TicketType'){
                        jsonParser.nextToken();
                        TicketType.add(jsonParser.getText());                          
                    }
                    
                    if(jsonParser.getText()=='TicketImage'){
                        jsonParser.nextToken();
                        TicketImage.add(jsonParser.getBlobValue());                          
                    }
                    
                    if(jsonParser.getText()=='OwnerEmailID'){
                        jsonParser.nextToken();
                        owner.add(jsonParser.getText());                          
                    }
                
                }
            }
        }
        
        
        try{
            for(integer i=0;i<tname.size();i++)
            {
                List<User> LoginUser = [SELECT Id,Username,FirstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City 
                                        FROM User 
                                        WHERE UserName=:owner[i]];

               Document document = new document();
               String imageurl ='';
               try{
                    document.Name=tname[i];
                    
                    document.isPublic=true;
                    document.ContentType='image/png';
                    document.type='png';
                    document.IsInternalUseOnly =false;
                    document.body=TicketImage[i];
                    document.folderId=UserInfo.getUserId();
                    DataBase.saveResult docSaveResult = DataBase.insert(document, false);
                    if(docSaveResult.isSuccess()){
                        imageurl = docSaveResult.getId();
                    }
                }
                catch(Exception e){}
                
                tckt.add(new TicketTypes__c(TT_Name__c=tname[i],EV_id__c=eventid[i],
                TT_Available__c=Integer.valueOf(tqty[i]),TT_Amount__c=Decimal.valueOf(tpr[i]),
                OwnerId =LoginUser[0].ID,TT_TicketType__c=TicketType[i],
                Ticket_Image_URL__c=imageurl));
            }
 
            insert tckt;
            for(integer i=0;i<tckt.size();i++){
                Container inn=new Container();
                string urlbase =URL.getSalesforceBaseUrl().getHost();
                string orgId = UserInfo.getOrganizationId();
                String ticketimageURL ='';
                ticketimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+tckt[i].Ticket_Image_URL__c;
                inn.Success=new Success(mobileid[i],tckt[i].Id,tckt[i].TT_Name__c,tckt[i].TT_Available__c,0,tckt[i].TT_TicketType__c,ticketimageURL,tckt[i].TT_Amount__c);
                jss.TicketTypes.add(inn);
            }
        }
        catch(Exception e)
        {
        Container inn=new Container();
        inn.error=e.getMessage();
        
        jss.TicketTypes.add(inn);
        }
        
        } 
        
     //ticket image edit
    if(Status=='EDIT'){
        Container ct=new Container();
        
        
        Blob jSONRequestBody=request.requestBody;
        String TicketName = request.params.get('Ticket_Name');
        String TicketID = request.params.get('Ticket_Id');
        String EventID = request.params.get('Event_Id');
        String Ticket_Type = request.params.get('TicketType');
        Integer TicketQty;
        Decimal TicketPrice;
        try{
            TicketQty=Integer.valueOf(request.params.get('Ticket_Qty'));
            TicketPrice = Decimal.valueOf(request.params.get('Ticket_Price'));
        }
        catch(Exception e){}
        String MobileTicketID = request.params.get('MobileTicket_Id');
        String OwnerEmailID = request.params.get('OwnerEmailID');
        List<User> LoginUser = [SELECT Id,Username,FirstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City FROM User WHERE UserName=:OwnerEmailID ];

        List<TicketTypes__c> tckt=[select TT_TicketType__c,Ticket_Image_URL__c,Id,TT_Sold__c,OwnerId,EV_id__r.EV_StartDate__c,EV_id__r.EV_EndDate__c,EV_id__r.EV_Title__c,TT_Name__c,EV_id__c,TT_Available__c,TT_Amount__c,Ticket_Category__c from TicketTypes__c where id=:TicketID];
        if(tckt.size()==0)
            ct.error='No Such Ticket Information Exists';
        else{
            if(TicketQty<tckt[0].TT_Sold__c){
                ct.error='Ticket Quantity cannot be less that Sold Quantity';
            }
            else{
        
                tckt[0].TT_Name__c=TicketName;
                tckt[0].EV_id__c=EventID;
                tckt[0].TT_Available__c=TicketQty;
                tckt[0].TT_Amount__c=TicketPrice;
                tckt[0].TT_TicketType__c=Ticket_Type;
                tckt[0].OwnerId =LoginUser[0].ID;
                String imageurl='';
                //update image
                try{
                    Document d=[select id,name from Document where name=:tckt[0].TT_Name__c];
                    delete d;
                }
                catch(Exception e){}
                try{
                    Document document = new document();
                    document.Name=tckt[0].TT_Name__c ;
                    
                    document.isPublic=true;
                    document.ContentType='image/png';
                    document.type='png';
                    document.IsInternalUseOnly =false;
                    document.body=jSONRequestBody;
                    document.folderId=UserInfo.getUserId();
                    DataBase.saveResult docSaveResult = DataBase.insert(document, false);
                    if(docSaveResult.isSuccess()){
                        imageurl = docSaveResult.getId();
                    }
                    tckt[0].Ticket_Image_URL__c=imageurl; 
                }
                catch(Exception e){}

                update tckt;
                
                string urlbase =URL.getSalesforceBaseUrl().getHost();
                string orgId = UserInfo.getOrganizationId();
                String ticketimageURL ='';
                ticketimageURL = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+tckt[0].Ticket_Image_URL__c;
                ct.Success=new Success(MobileTicketID,tckt[0].Id,tckt[0].TT_Name__c,tckt[0].TT_Available__c,tckt[0].TT_Sold__c,tckt[0].TT_TicketType__c,ticketimageURL,tckt[0].TT_Amount__c);
            } 
        }
        jss.TicketTypes.add(ct);
    }
    return jss;
   }
    
    
    @HttpGet
    global static Container doGet(){
        RestRequest req = RestContext.request;
        String TicketName = req.params.get('Ticket_Name');
        String TicketID = req.params.get('Ticket_Id');
        system.debug('!!!!! '+TicketID);
        String EventID = req.params.get('Event_Id');
        String Ticket_Type = req.params.get('TicketType');
        Integer TicketQty,TicketPrice;
        try{
        TicketQty=Integer.valueOf( req.params.get('Ticket_Qty'));
        TicketPrice = Integer.valueOf(req.params.get('Ticket_Price'));
        }catch(Exception e){}
        String MobileTicketID = req.params.get('MobileTicket_Id');
        String Status=req.params.get('Status');  
        String OwnerEmailID = req.params.get('OwnerEmailID');
        List<User> LoginUser = [SELECT Id,Username,FirstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City FROM User WHERE UserName=:OwnerEmailID ];
        
        Container ct=new Container();
        
        if(Status=='CREATE'){
            TicketTypes__c tckt=new TicketTypes__c(TT_Name__c=TicketName ,EV_id__c=EventID,TT_Available__c=TicketQty,TT_Amount__c=TicketPrice,OwnerId =LoginUser[0].ID,TT_TicketType__c=Ticket_Type);      
            try{
                insert tckt;
                ct.Success=new Success(MobileTicketID,tckt.Id,tckt.TT_Name__c,tckt.TT_Available__c,0,tckt.TT_TicketType__c,null,tckt.TT_Amount__c);
            }
            catch(Exception e){
                ct.error=e.getMessage();
            }
        }
        
        if(Status=='EDIT'){
            //Get Event Details from Ticket Object
            List<TicketTypes__c> tckt=[select Id,TT_TicketType__c,TT_Sold__c,OwnerId,EV_id__r.EV_StartDate__c,EV_id__r.EV_EndDate__c,EV_id__r.EV_Title__c,TT_Name__c,EV_id__c,TT_Available__c,TT_Amount__c from TicketTypes__c where id=:TicketID];
            if(tckt.size()==0)
                ct.error='No Such Ticket Information Exists';
            else{
                if(TicketQty<tckt[0].TT_Sold__c){
                    ct.error='Ticket Quantity cannot be less that Sold Quantity';
                }
                else{
                    tckt[0].TT_Name__c=TicketName;
                    tckt[0].EV_id__c=EventID;
                    tckt[0].TT_Available__c=TicketQty;
                    tckt[0].TT_Amount__c=TicketPrice;
                    tckt[0].TT_TicketType__c=Ticket_Type;
                    tckt[0].OwnerId =LoginUser[0].ID;
                    update tckt;
                    system.debug('  EDIT TICKET1111 '+tckt[0].TT_Amount__c);                    
                    ct.Success=new Success(MobileTicketID,tckt[0].Id,tckt[0].TT_Name__c,tckt[0].TT_Available__c,tckt[0].TT_Sold__c,tckt[0].TT_TicketType__c,null,tckt[0].TT_Amount__c);
                    system.debug('  EDIT TICKET22222 '+ct.Success.TicketPrice);
                } 
            }
        }
        
        if(Status=='DELETE'){
            List<TicketTypes__c> tckt=[select Id,EV_id__r.EV_StartDate__c,EV_id__r.EV_EndDate__c,EV_id__r.EV_Title__c,TT_Name__c,EV_id__c,TT_Available__c,TT_Amount__c from TicketTypes__c where id=:TicketID];
            system.debug('!!!!! '+tckt);
            if(tckt.size()==0)
                ct.error='No Such Ticket Exists';
            else{
                ct.Success=new Success(MobileTicketID,tckt[0].Id,null,0,0,null,null,null);
                delete tckt;
            } 
        }     
        return ct;
    }
    
    global class JsonResponses{
        public List<Container> TicketTypes=new List<Container>();  
    }
    
    global class Container{
       public Success Success{get;set;}
       public String error{get;set;}
       
        public Container(){       
        }
    }
    
    
    global class Success{    
        public String MobileTicket_Id{get;set;}
        public Id Ticket_Id{get;set;}
        public Decimal Ticket_QuantitySold{get;set;}
        public String TicketType{get;set;}
        public String TicketImage{get;set;}
        public Decimal TicketPrice{get;set;}
        public String TicketName{get;set;}
        public Decimal TicketQuantity{get;set;}
        
        public Success(String mobileid,Id ticketid,String TicketName,Decimal TicketQuantity,Decimal Ticket_QuantitySold,String TicketType,String TicketImage,Decimal TicketPrice){
            MobileTicket_Id=mobileid;
            Ticket_Id=ticketid;
            this.TicketName=TicketName;
            this.TicketQuantity=TicketQuantity;
            this.Ticket_QuantitySold=Ticket_QuantitySold;
            this.TicketType=TicketType;
            this.TicketImage=TicketImage;
            this.TicketPrice=TicketPrice;
        }
    }
    
    }