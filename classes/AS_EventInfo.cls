@RestResource(urlMapping='/AS_EventInfo/*')
  
    global with sharing class AS_EventInfo{
    
    @HttpPost
    global static Container doGet(){
        RestRequest req= RestContext.request;
        Blob jSONRequestBody=req.requestBody; 
        system.debug('$$$$$ '+jSONRequestBody);
        String EventName = req.params.get('Event_Name');
        String EventID = req.params.get('Event_Id');
        String MobileEventID = req.params.get('MobileEvent_Id');
        Date EventStartDate,EventEndDate;
        try{
            EventStartDate=Date.valueOf( req.params.get('Start_Date'));
            EventEndDate = Date.valueOf(req.params.get('End_Date'));
        }
        catch(Exception e){}
        String EventCity = req.params.get('City');
        String EventState = req.params.get('State');
        String Address1=req.params.get('Address1');
        String Address2=req.params.get('Address2');
        String location=req.params.get('Location');
        String EventCountry = req.params.get('Country');
        String EventZipcode = req.params.get('Zipcode'); 
        system.debug('Event Zipcode: '+EventZipcode);  
        String Status=req.params.get('Status');
        String description=req.params.get('Desc');
        String stime=req.params.get('STime');
        String etime=req.params.get('ETime'); 
        String OwnerEmailID = req.params.get('OwnerEmailID');
        String SalesTax= req.params.get('SalesTax');
        system.debug('  FEE APPL '+req.params.get('FeeApplicable'));        
        String FeeApplicable= req.params.get('FeeApplicable');
        String BadgeName= req.params.get('BadgeName');
        system.debug(BadgeName+'  BADGE NAME00000000000 '+req.params.get('BadgeName'));        
        system.debug('  SALES TAX '+SalesTax);
        system.debug('!!! '+EventStartDate+'@@@ '+EventEndDate+'### '+stime+'###'+etime);
        system.debug(req.params.get('OwnerEmailID')+'  USER EMAIL ID '+OwnerEmailID );
        User LoginUser = [SELECT Id,ProfileId,Username,FirstName,LastName,Email,Phone,CompanyName,states__c,Country__c,City,isActive FROM User WHERE UserName=:OwnerEmailID AND isActive=true];
        Profile__c p=[SELECT Id,PR_Name__c from Profile__c WHERE PR_Name__c='EventAdmin' LIMIT 1];
        
        Container ct=new Container();
        LIST<ticketInner> TTList= new LIST<ticketInner>();
        Commanforstates con = new Commanforstates();
        
        if(Status=='CREATE'){    
              
            Event__c eve=new Event__c(EV_Description__c=description,EV_EndTime__c=etime,StartTime__c=stime,EV_HistingAddr1__c=Address1,AS_HostingAddr2__c=Address2,EV_HostingLocation__c=location,EV_Title__c=EventName,EV_StartDate__c=EventStartDate,EV_EndDate__c=EventEndDate,EV_HostingCountryNew__c=EventCountry,EV_HostingZipcode__c=EventZipcode,EV_HostingStateNew__c=EventState,AS_HostingCity__c=EventCity,OwnerId =LoginUser.ID,OrganizerId__c=LoginUser.UserName);
                       
            eve.Sales_Tax__c=0;
            eve.isActive__c= TRUE;
            if(FeeApplicable == String.valueof(TRUE)){
                eve.Fee_Type__c= 'Include the fee in the ticket price';
            }else if(FeeApplicable == String.valueof(FALSE)){
                eve.Fee_Type__c= 'Charge the fee to the customer';            
            }
            try{
                insert eve;
                
                Document document = new document();
                String imageurl ='';
                document.Name=eve.id;
                document.isPublic=true;
                document.ContentType='image/png';
                document.type='png';
                document.IsInternalUseOnly =false;
                document.body=jSONRequestBody;
                document.folderId='00lF0000001VI7Y';
                DataBase.saveResult docSaveResult = DataBase.insert(document, false);
                if(docSaveResult.isSuccess()){
                    system.debug('#### '+docSaveResult.getId());
                    eve.EV_EventLogo__c= docSaveResult.getId();
                } 
                Database.update(eve);
                SecurityControls__c attset= new  SecurityControls__c();
                attset.EV_id__c = eve.id;  
                insert attset;
                
                TicketTypes__c TT = new TicketTypes__c(TT_Name__c ='Guest',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=eve.id,TT_Available__c=1,TT_Sold__c=0,OwnerId=Loginuser.Id,Avilable_for_Portal__c=false);
                insert TT;
                TicketTypes__c TT2 = new TicketTypes__c(TT_Name__c ='Attendee Staff',TT_Amount__c=0,TT_TicketType__c='Free',EV_id__c=eve.id,TT_Available__c=1,TT_Sold__c=0,OwnerId=Loginuser.Id,Avilable_for_Portal__c=false);
                insert TT2;              
               
                
                // Inserting EAM
                LIST<AttendeeSummary__c> AttendeesList= new LIST<AttendeeSummary__c>();
                AttendeesList=[SELECT ID, AS_Company__c, AS_Email__c, AS_LastName__c, AS_FirstName__c FROM AttendeeSummary__c WHERE AS_Email__c =: OwnerEmailID]; 
                
                if(AttendeesList.size() >0){
                    LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
                    EAMList= [SELECT ID FROM Event_Attendee_Mapping__c WHERE AS_Id__c =: AttendeesList[0].Id AND EV_Id__c =: eve.id];
                    String EAMId;
                    if(EAMList.size() >0){
                        EAMId= EAMList[0].Id;
                    }else{
                        Event_Attendee_Mapping__c insertEAM= new Event_Attendee_Mapping__c();            
                        insertEAM.Attendee_Event_IDs__c= AttendeesList[0].Id+'-'+eve.Id;
                        insertEAM.AS_id__c= AttendeesList[0].Id;
                        insertEAM.EV_id__c= eve.Id; 
                        insertEAM.Boothleads_Profile__c= 'Event Admin';
                        insertEAM.IsCancelled__c = FALSE;
                        insertEAM.GuestType__c= 'Event Admin';
                        Database.SaveResult createEAMResult= Database.insert(insertEAM, false);
                        //Database.upsert(insertEAM, Event_Attendee_Mapping__c.EA_AttendeeBarcode__c, FALSE);
                        EAMId= insertEAM.Id;
                    }
                        LIST<TicketTypes__c> guestTicket= new LIST<TicketTypes__c>([SELECT ID, TT_Sold__c, TT_Available__c, Available__c FROM TicketTypes__c WHERE TT_Name__c =: 'Guest' AND EV_id__c =: eve.Id]);
                        LIST<Dummay__c> existingGuestTickets= new LIST<Dummay__c>();
                        existingGuestTickets= [SELECT ID FROM Dummay__c WHERE Event_Attendee_Mapping__c =: EAMId AND Event__c =: eve.Id AND TicketTypes__c =: guestTicket[0].Id];
                        if(existingGuestTickets.size() ==0){
                            Constomer__c TransactionInfo = new Constomer__c();
                                    
                            TransactionInfo.Email__c= AttendeesList[0].AS_Email__c;
                            TransactionInfo.Customer_Name__c= AttendeesList[0].AS_FirstName__c+' '+AttendeesList[0].AS_LastName__c;
                            TransactionInfo.Isinserted__c = TRUE;        
                            Database.Insert(TransactionInfo,False);
                            
                            Dummay__c  RegistrationNewInfoForTicket= new Dummay__c();        
                            
                            RegistrationNewInfoForTicket.AttendeeSummary__c = AttendeesList[0].Id;
                            RegistrationNewInfoForTicket.Company__c = AttendeesList[0].AS_Company__c;
                            RegistrationNewInfoForTicket.Email__c = AttendeesList[0].AS_Email__c;
                            RegistrationNewInfoForTicket.Last_Name__c = AttendeesList[0].AS_LastName__c;
                            RegistrationNewInfoForTicket.First_Name__c = AttendeesList[0].AS_FirstName__c;
                            RegistrationNewInfoForTicket.Event__c = eve.Id;
                            RegistrationNewInfoForTicket.TicketTypes__c = guestTicket[0].Id;
                            RegistrationNewInfoForTicket.customer_key__c = TransactionInfo.Id;
                            RegistrationNewInfoForTicket.Update_with_created_date__c = Date.Today();
                            RegistrationNewInfoForTicket.Payment_Status__c =  'Paid';
                            RegistrationNewInfoForTicket.Payment_Type__c = 'Guest';
                            RegistrationNewInfoForTicket.Event_Attendee_Mapping__c =  EAMId;
                            RegistrationNewInfoForTicket.Tickets_Quantty__c = 1;
                            //RegistrationNewInfoForTicket.Event_Attendee_Mapping__c = Event_Attendee.Id;
                            RegistrationNewInfoForTicket.TicketAmount__c= 0;
                            
                            Database.Insert(RegistrationNewInfoForTicket, FALSE);
                             if(guestTicket[0].Available__c <=0){
                                guestTicket[0].TT_Available__c += 1;
                            }
                            guestTicket[0].TT_Sold__c += 1;
                            Database.Update(guestTicket, FALSE);
                        }
                    
                }                
                
                //insert UserProfileEvent
                LIST<User_Profile_Event__c> upeLIST=[select Profile_id__c,User_id__c,EV_id__c,Attendee_Summary__c from User_Profile_Event__c where User_id__c=:LoginUser.id and EV_id__c=null limit 1];
                if(upeLIST.size()==0){
                    User_Profile_Event__c upe=new User_Profile_Event__c();
                    upe.Profile_id__c=p.id;
                    upe.User_id__c=LoginUser.id;
                    LIST<AttendeeSummary__c> attsum=[select id,AS_Email__c from AttendeeSummary__c where AS_Email__c=:Loginuser.username];
                    if(attsum.size()!=0)
                        upe.Attendee_Summary__c=attsum[0].id;
                        upe.EV_id__c=eve.id;
                        upe.EventAdmin_Id__c=LoginUser.id;
                        upe.UEP_isActive__c= TRUE;
                        insert upe;
                }
                else{
                    upeLIST[0].UEP_isActive__c= TRUE;
                    upeLIST[0].EV_id__c=eve.id;
                    update upeLIST[0];
                }
                
                ct.Event_Name=eve.EV_Title__c;
                ct.Start_Date=eve.EV_StartDate__c;
                ct.End_Date=eve.EV_EndDate__c;
                ct.Event_Address=eve.EV_HistingAddr1__c;
                ct.Event_Location=eve.EV_HostingLocation__c;
                ct.Event_City=eve.AS_HostingCity__c;
                ct.Event_State = con.mapstate(eve.EV_HostingStateNew__c);
                ct.Event_State_LongCode =eve.EV_HostingStateNew__c;
                ct.Event_Country = con.mapstate(eve.EV_HostingCountryNew__c);
                ct.Event_Country_LongCode = eve.EV_HostingCountryNew__c;    
                ct.Event_ZipCode=eve.EV_HostingZipcode__c;
                ct.Event_Description= eve.EV_Description__c;
                ct.SalesTax= String.valueof(eve.Sales_Tax__c);
                ct.BadgeName= eve.Badge_Name__c;
                if(eve.Fee_Type__c == 'Include the fee in the ticket price'){
                    ct.FeeApplicable= TRUE;
                }else if(eve.Fee_Type__c== 'Charge the fee to the customer'){
                    ct.FeeApplicable= FALSE;            
                }
                
                string urlbase =URL.getSalesforceBaseUrl().getHost();
                string orgId = UserInfo.getOrganizationId();
                system.debug('%%%%% '+eve.EV_EventLogo__c+'&&&'+eve.id);
                ct.EventLogoURL= 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+eve.EV_EventLogo__c;
                
                
                TTList.add(new ticketInner(TT.Id, TT.TT_Name__c, TT.TT_Amount__c, TT.TT_TicketType__c, TT.TT_Available__c));
                TTList.add(new ticketInner(TT2.Id, TT2.TT_Name__c, TT2.TT_Amount__c, TT2.TT_TicketType__c, TT2.TT_Available__c));
                ct.TTL= TTList;
                ct.Success=new Success(MobileEventID,eve.Id);
            }
            catch(Exception e){
                ct.error=e.getMessage();
            }
        }
        if(Status=='EDIT'){
            LIST<Event__c> eve=[select Id, Badge_Name__c, Sales_Tax__c, OrganizerId__c,EV_HostingCountryNew__c,EV_HostingZipcode__c,EV_EndTime__c,StartTime__c,EV_HostingStateNew__c,EV_StartDate__c,EV_EndDate__c,EV_Title__c,EV_Description__c,AS_HostingCity__c,EV_HistingAddr1__c,EV_HostingLocation__c  from Event__c where id=:EventID];
            if(eve.size()==0)
                ct.error='No Such Event Exists';
            else{
                eve[0].EV_HostingStateNew__c=EventState;
                eve[0].EV_StartDate__c=EventStartDate;
                eve[0].EV_EndDate__c=EventEndDate ;
                eve[0].EV_Title__c=EventName;
                eve[0].AS_HostingCity__c=EventCity ;
                eve[0].EV_HistingAddr1__c=Address1;
                eve[0].AS_HostingAddr2__c=Address2;
                eve[0].EV_HostingCountryNew__c=EventCountry;
                eve[0].EV_HostingZipcode__c=EventZipcode;
                eve[0].EV_HostingLocation__c=location;
                eve[0].EV_Description__c=description;
                eve[0].EV_EndTime__c=etime;
                eve[0].StartTime__c=stime;
                eve[0].OwnerId =LoginUser.ID;
                eve[0].OrganizerId__c=LoginUser.UserName;
                eve[0].Sales_Tax__c= Decimal.valueOf(SalesTax);
                eve[0].isActive__c= TRUE;
                eve[0].Badge_Name__c= BadgeName;
                system.debug(' EDIT BADGE NAME '+eve[0].Badge_Name__c);
                if(FeeApplicable == String.ValueOf(TRUE)){
                    eve[0].Fee_Type__c= 'Include the fee in the ticket price';
                }else if(FeeApplicable == String.ValueOf(FALSE)){
                    eve[0].Fee_Type__c= 'Charge the fee to the customer';            
                }
                system.debug(EventStartDate+'  '+EventEndDate +' '+' EDIT FEEAPPL  '+eve[0].Fee_Type__c);
               
                String imageURL='';
                
                try{
                    Document d=[SELECT id,name FROM Document WHERE name=: EventID];
                    system.debug('  DOCUMENT0000000000 '+d);
                    if(d!= NULL){
                        database.delete(d,false);
                    }
               }catch(exception e){}
               try{
                   Document document = new document();
                   document.Name=EventID;
                   document.isPublic=true;
                   document.ContentType='image/png';
                   document.type='png';
                   document.IsInternalUseOnly =false;
                   document.body=jSONRequestBody;
                   document.folderId='00lF0000001VI7Y';
                   system.debug(document+'  DOCUMENT55555555555 '+document);
                   DataBase.saveResult docSaveResult = DataBase.insert(document, false);
                   if(docSaveResult.isSuccess()){
                       imageurl = docSaveResult.getId();
                   }
                   system.debug(imageurl +'  DOCUMENT22222222222 '+docSaveResult);
                   eve[0].EV_EventLogo__c=imageurl; 
                   }catch(Exception e){}
               
                if(EventStartDate != NULL && EventEndDate != NULL){
                    update eve;
                    if(eve[0].Sales_Tax__c != NULL || eve[0].Sales_Tax__c != 0){
                        LIST<Item__c> ItemsList= new LIST<Item__c>();
                        LIST<Item__c> updateItemsList= new LIST<Item__c>();                
                        ItemsList= [SELECT ID, Sales_Tax__c FROM Item__c WHERE Event__c =: eve[0].Id AND isTaxable__c =: TRUE];
                        if(ItemsList.size() >0){
                            for(Item__c item: ItemsList){
                               item.Sales_Tax__c= eve[0].Sales_Tax__c;
                               updateItemsList.add(item);     
                            }
                            Database.Update(updateItemsList, FALSE);
                        }
        
                    }    
                }
                system.debug('Event Details are: '+eve);
                system.debug('Event Zip: '+eve[0].EV_HostingZipcode__c);
                ct.Event_Name=eve[0].EV_Title__c;
                ct.Start_Date=eve[0].EV_StartDate__c;
                ct.End_Date=eve[0].EV_EndDate__c;
                ct.Event_Address=eve[0].EV_HistingAddr1__c;
                ct.Event_Location=eve[0].EV_HostingLocation__c;
                ct.Event_City=eve[0].AS_HostingCity__c;
                ct.Event_State = con.mapstate(eve[0].EV_HostingStateNew__c);
                ct.Event_State_LongCode =eve[0].EV_HostingStateNew__c;
                ct.Event_Country = con.mapstate(eve[0].EV_HostingCountryNew__c);
                ct.Event_Country_LongCode = eve[0].EV_HostingCountryNew__c;
                ct.Event_ZipCode=eve[0].EV_HostingZipcode__c;
                ct.Event_Description= eve[0].EV_Description__c;
                ct.SalesTax= String.valueof(eve[0].Sales_Tax__c);
                ct.BadgeName= eve[0].Badge_Name__c;
                system.debug(' SEND BADGE NAME '+ct.BadgeName);
                if(eve[0].Fee_Type__c == 'Include the fee in the ticket price'){
                    ct.FeeApplicable= TRUE;
                }else if(eve[0].Fee_Type__c== 'Charge the fee to the customer'){
                    ct.FeeApplicable= FALSE;            
                }
                
                string urlbase =URL.getSalesforceBaseUrl().getHost();
                string orgId = UserInfo.getOrganizationId();
                system.debug('%%%%% '+eve[0].EV_EventLogo__c+'&&&'+eve[0].id);
                ct.EventLogoURL= 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+eve[0].EV_EventLogo__c;
                
                system.debug('  EVENT LOGO URL  '+ct.EventLogoURL);
                
                ct.Success=new Success(MobileEventID,eve[0].Id);
            }
        }
        if(Status=='DELETE')
        {
            LIST<Event__c> eve=[select Id,EV_HostingStateNew__c,EV_StartDate__c,EV_EndDate__c,EV_Title__c,EV_Description__c,AS_HostingCity__c,EV_HistingAddr1__c,EV_HostingLocation__c,isActive__c  from Event__c where id=:EventID];
            if(eve.size()==0)
                ct.error='No Such Event Exists';
            else{
                
                includeSADetailsToBLEvent EventDelete= new includeSADetailsToBLEvent();        
                Boolean isDelete= EventDelete.deleteEvent(EventID);
                if(isDelete){
                    ct.Success=new Success(MobileEventID,eve[0].Id);
                    eve[0].isActive__c =false;
                    update eve;
                }else{
                    ct.error='This '+eve[0].EV_Title__c+' can not be deleted as it is associated with active tickets or attendees or items';                
                }
                
            } 
        }
        return ct; 
    }
    
    global class Container{
        public Success Success{get;set;}
        public String Event_Name{get;set;}
        public Date Start_Date{get;set;}
        public Date End_Date{get;set;}
        public String Event_Location{get;set;}
        public String Event_Address{get;set;}
        public String Event_City{get;set;}
        public String Event_State{get;set;}
        public String Event_State_LongCode{get;set;}
        public String Event_Country{get;set;}
        public String Event_Country_LongCode{get;set;}
        public String Event_ZipCode{get;set;}       
        public String Event_Description{get;set;}       
        public String error{get;set;}
        public String SalesTax{get; set;}
        public Boolean FeeApplicable{get; set;}
        public String BadgeName{get; set;}
        public String EventLogoURL{get; set;}
        public LIST<ticketInner> TTL{get; set;}
        
        public Container(){ 
        }
    }
    
    global class ticketInner{
        
        public Id Ticket_Id{get;set;}
        public String Ticket_Name{get;set;}
        public Decimal Ticket_Amount{get;set;}
        public String Ticket_Type{get;set;}
        public Decimal Ticket_Quantity{get;set;}
        
        public ticketInner(Id TicketId, String TicketName, Decimal TicketAmount, String TicketType, Decimal TicketQuantity){
            Ticket_Id= TicketId;
            Ticket_Name= TicketName;
            Ticket_Amount= TicketAmount;
            Ticket_Type= TicketType;
            Ticket_Quantity= TicketQuantity;
        }
    }
    
    global class Success{    
        public String MobileEvent_Id{get;set;}
        public Id Event_Id{get;set;}
        
        public Success(String mobileid,Id eventid){
            MobileEvent_Id=mobileid;
            Event_Id=eventid;
        }
    }

}