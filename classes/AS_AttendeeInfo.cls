@RestResource(urlMapping='/AS_AttendeeInfo/*')

 global with sharing class AS_AttendeeInfo{
     
    global static LIST<AttendeeSummary__c> attlist{get;set;}
    global static id atteid{get;set;}
 
    @HttpPost
    global static Container doPost(){
    
    RestRequest req = RestContext.request;
    String AttendeeFirstName = req.params.get('Attendee_FirstName');
    String AttendeeLastName = req.params.get('Attendee_LastName');
    String AttendeeID = req.params.get('Attendee_Id');
    String EventID = req.params.get('Event_Id');
    String AttendeeEmail=req.params.get('Attendee_Email');
    String AttendeePhone=req.params.get('Attendee_Phone');
    String AttendeeCity=req.params.get('Attendee_City');
    String AttendeeState=req.params.get('Attendee_State');
    system.debug('State Long Code: '+AttendeeState);
    String AttendeeCountry=req.params.get('Attendee_Country');
    String Attendee_Company=req.params.get('Attendee_Company');
    String Attendee_Zip=req.params.get('Attendee_Zip');
    String Address1=req.params.get('Address1');
    String Address2=req.params.get('Address2');
    String MobileAttendeeID = req.params.get('MobileAttendee_Id');
    String JobTitle= req.params.get('JobTitle'); 
    String AttendeeCategory= req.params.get('AttendeeCategory');    
    String CustomBarcode= req.params.get('CustomBarcode');     
    String Status=req.params.get('Status'); 
    
    RestResponse response = RestContext.response;  
    String jSONRequestBody=req.requestBody.toString().trim(); 
    // String jSONRequestBody='[{"TicketId":"T-5801","SeatNo":"P1"},{"TicketId":"T-5802","SeatNo":"G02"},{"TicketId":"T-6739","SeatNo":"L03"},{"TicketId":"T-6741","SeatNo":"H41"},{"TicketId":"T-5803","SeatNo":"S03"},{"TicketId":"T-5804","SeatNo":"F41"},{"TicketId":"T-6742","SeatNo":"S42"},{"TicketId":"T-6743","SeatNo":"S43"},{"TicketId":"T-6744","SeatNo":""},{"TicketId":"T-6745","SeatNo":"S45"}]'; 
    System.debug('JsonBody '+jSONRequestBody);
    JSONParser jsonParser = JSON.createParser(jSONRequestBody); 
    List<String> TicketId=new List<String>();
    List<String> SeatNo=new List<String>();
    
    while(jsonParser.nextToken() != null){
        if(jsonParser.getCurrentToken() == JSONToken.START_ARRAY){
        
            while(jsonParser.nextToken() != JSONToken.END_ARRAY){
            
                if(jsonParser.getText()=='TicketId'){
                    jsonParser.nextToken();
                    TicketId.add(jsonParser.getText());                          
                }
                
                if(jsonParser.getText()=='SeatNo'){
                    jsonParser.nextToken();
                    SeatNo.add(jsonParser.getText());                          
                }
            }
        }
    }
    
    system.debug(SeatNo.size()+'  SEAT NUMBERS '+SeatNo);
    
    Container ct=new Container();
    Commanforstates con = new Commanforstates();
      
    if(Status=='CREATE'){
        if(AttendeeState != NULL || AttendeeState != ''){
            AttendeeState = AttendeeState.trim();
        }
        system.debug('State Long Code in Create : '+AttendeeState);
        
        try{
            AttendeeSummary__c attsum=new AttendeeSummary__c();
            attlist = [SELECT Id,AS_Email__c FROM AttendeeSummary__c WHERE AS_Email__c=:AttendeeEmail];
            if(attlist.size()>0){
                atteid= attlist[0].id;
            }else{
                system.debug('Attendee Values are '+AttendeeFirstName+AttendeeLastName+AttendeeEmail+AttendeeCity+Attendee_Company);
                attsum.AS_Company__c=Attendee_Company;
                attsum.AS_WorkZip__c=Attendee_Zip;
                attsum.AS_WorkAddress1__c=Address1;
                attsum.AS_WorkAddress2__c=Address2;
                attsum.AS_FirstName__c=AttendeeFirstName;
                attsum.AS_LastName__c=AttendeeLastName;
                attsum.AS_Email__c=AttendeeEmail;
                attsum.AS_WorkPhone__c=AttendeePhone;
                attsum.AS_WorkCity__c=AttendeeCity;
                attsum.AS_Work_States__c=AttendeeState;
                attsum.AS_Work_Country__c=AttendeeCountry;
                attsum.AS_Title__c= JobTitle;   
                
                Database.UpsertResult AttendeeToUpsert= Database.upsert(attsum, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);                     
                //insert attsum;
                atteid= attsum.id;
            }
            
            Event_Attendee_Mapping__c evatmap=new Event_Attendee_Mapping__c(AS_id__c=atteid,EV_id__c=EventID, Attendee_Event_IDs__c= atteid+'-'+EventID, GuestType__c= AttendeeCategory, IsCancelled__c= FALSE);
            //Database.UpsertResult EAMToUpsert= Database.upsert(attsum, Event_Attendee_Mapping__c.EA_AttendeeBarcode__c.getDescribe().getSObjectField(), false);                                 
            insert evatmap;

            ct.Attendee_FirstName=attsum.AS_FirstName__c;
            ct.Attendee_LastName=attsum.AS_LastName__c;
            ct.Attendee_Email=attsum.AS_Email__c;
            ct.Attendee_Phone=attsum.AS_WorkPhone__c;
            ct.Attendee_Company=attsum.AS_Company__c;
            ct.Attendee_Zip=attsum.AS_WorkZip__c;
            ct.Address1=attsum.AS_WorkAddress1__c;
            ct.Address2=attsum.AS_WorkAddress2__c;
            ct.State=con.mapstate(attsum.AS_Work_States__c);
            ct.State_LongCode=attsum.AS_Work_States__c;
            ct.Country=con.mapstate(attsum.AS_Work_Country__c);
            ct.Country_LongCode=attsum.AS_Work_Country__c;
            ct.Zipcode=attsum.AS_WorkZip__c;
            ct.JobTitle= attsum.AS_Title__c; 
            ct.AttendeeCategory= evatmap.GuestType__c;
              
            Success sc=new Success();
            sc.Attendee_Id=evatmap.AS_id__c;
            sc.Event_Id=evatmap.EV_id__c;
            ct.Success=sc;
        }
        catch(Exception e){
            ct.error=e.getMessage();
        }
    }
     
    if(Status=='EDIT'){
        if(AttendeeState != NULL || AttendeeState != ''){
            AttendeeState = AttendeeState.trim();
        }
        system.debug('State Long Code in Edit : '+AttendeeState);
        //Get Attendee Info
        List<AttendeeSummary__c> attmap=[select AS_Title__c, AS_Company__c,AS_WorkZip__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_FirstName__c,AS_LastName__c,Id,AS_Email__c,AS_WorkPhone__c,AS_WorkCity__c,AS_Work_States__c,AS_Work_Country__c from AttendeeSummary__c where id=:AttendeeID];     
        
        if(attmap.size()==0)
            ct.error='No Such Attendee Information Exists';
        else{
            attmap[0].AS_FirstName__c=AttendeeFirstName ;
            attmap[0].AS_LastName__c=AttendeeLastName;
            attmap[0].AS_Email__c=AttendeeEmail;
            attmap[0].AS_WorkPhone__c=AttendeePhone;
            attmap[0].AS_WorkCity__c=AttendeeCity;
            attmap[0].AS_Work_States__c=AttendeeState;
            attmap[0].AS_Work_Country__c=AttendeeCountry;
            attmap[0].AS_Company__c=Attendee_Company;
            attmap[0].AS_WorkZip__c=Attendee_Zip;
            attmap[0].AS_WorkAddress1__c=Address1;
            attmap[0].AS_WorkAddress2__c=Address2;
            attmap[0].AS_Title__c= JobTitle;   
            
            //Database.UpsertResult[] AttendeeToUpdate= Database.upsert(attmap, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);                     
            update attmap;
            updateUserInfo(AttendeeEmail, AttendeeFirstName, AttendeeLastName, AttendeePhone, Attendee_Company, JobTitle, Address1, AttendeeCity, AttendeeState, AttendeeCountry, Attendee_Zip); 
            
            LIST<Event_Attendee_Mapping__c> EAMList= new LIST<Event_Attendee_Mapping__c>();
            EAMList= [SELECT ID, GuestType__c,Custom_Barcode__c 
                      FROM Event_Attendee_Mapping__c 
                      WHERE AS_Id__c =: attmap[0].Id 
                      AND EV_Id__c =: EventID];
            if(EAMList.size() >0){
                EAMList[0].GuestType__c= AttendeeCategory;
                EAMList[0].IsCancelled__c = FALSE;
                if(CustomBarcode!=null&&CustomBarcode!='')
                EAMList[0].Custom_Barcode__c=CustomBarcode;
                Update(EAMList);
            }            
            List<Each_Ticket_Details> etd=new List<Each_Ticket_Details>();

            system.debug('%%%%%% '+TicketId);
            system.debug('^^^^^^ '+SeatNo);
            if(TicketId.size()>0){      
                LIST<Individual_Ticket_Info__c> itilist = [SELECT Name,isCheckedIn__c,Seat__c,Registration_Info__c,Registration_Info__r.TicketTypes__c, Registration_Info__r.Seat_Number__c FROM Individual_Ticket_Info__c WHERE Name In:TicketId ORDER BY Name]; 
                system.debug('######  '+itilist);
                for(integer i=0;i<itilist.size();i++){
                    itilist[i].Seat__c = SeatNo[i];
                    Each_Ticket_Details et = new Each_Ticket_Details();
                    et.TicketId = itilist[i].Registration_Info__r.TicketTypes__c;
                    et.TicketNumber = itilist[i].Name; 
                    et.SeatNo = itilist[i].Seat__c; 
                    etd.add(et);   
                }

                update itilist;
            }
        
            ct.Attendee_FirstName=attmap[0].AS_FirstName__c;
            ct.Attendee_LastName=attmap[0].AS_LastName__c;
            ct.Attendee_Email=attmap[0].AS_Email__c;
            ct.Attendee_Phone=attmap[0].AS_WorkPhone__c;
            ct.Attendee_Company=attmap[0].AS_Company__c;
            ct.Attendee_Zip=attmap[0].AS_WorkZip__c;
            ct.Address1=attmap[0].AS_WorkAddress1__c;
            ct.Address2=attmap[0].AS_WorkAddress2__c;
            ct.State=con.mapstate(attmap[0].AS_Work_States__c);
            ct.State_LongCode=attmap[0].AS_Work_States__c;
            ct.Country=con.mapstate(attmap[0].AS_Work_Country__c);
            ct.Country_LongCode=attmap[0].AS_Work_Country__c;
            ct.Zipcode=attmap[0].AS_WorkZip__c;
            ct.JobTitle=attmap[0].AS_Title__c;
            if(EAMList.size() >0){
                ct.AttendeeCategory= EAMList[0].GuestType__c;
            }
            LIST<User> EventAdminUser= new LIST<User>();
            EventAdminUser= [SELECT Id, ProfileId, Username, FirstName, LastName, Email, Companyphone__c, CompanyName, States__c, Country__c, CompanyCity__c FROM User WHERE UserName =: attmap[0].AS_Email__c];
            UserDetails EventAdminDetails= new UserDetails();
            system.debug('  EVENT ADMIN DETAILS '+EventAdminUser);
            if(EventAdminUser.size() >0){
            
                EventAdminDetails.FirstName= attmap[0].AS_FirstName__c; 
                EventAdminDetails.LastName= attmap[0].AS_LastName__c; 
                EventAdminDetails.Company= attmap[0].AS_Company__c; 
                EventAdminDetails.PhoneNo= attmap[0].AS_WorkPhone__c;
                EventAdminDetails.City= AttendeeCity;
                EventAdminDetails.State= attmap[0].AS_Work_States__c;
                EventAdminDetails.Country= attmap[0].AS_Work_Country__c;
                EventAdminDetails.StateShortForm= con.mapstate(attmap[0].AS_Work_States__c);

            }
                ct.usrDetails= EventAdminDetails;            
            
            system.debug(EventAdminDetails+'  ADDED ADMIN DETAILS '+ct.usrDetails);
            Success sc=new Success();
            sc.Attendee_Id=attmap[0].id;
            sc.Event_Id=EventID;
            sc.Each_Ticket_Details=etd;
            ct.Success=sc;
            system.debug('&&&& '+ct);
        }
    }  
      
    if(Status=='DELETE'){
        List<Event_Attendee_Mapping__c> evatmap=[SELECT id,AS_id__c,EV_id__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c 
                                                 FROM Event_Attendee_Mapping__c 
                                                 WHERE AS_id__c=:AttendeeID 
                                                 AND EV_id__c=:EventID];     
        
        if(evatmap.size()==0)    
            ct.error='No Such Attendee Information Exists';
        else{ 
            Event_Attendee_Mapping__c eam=[SELECT id,AS_id__c,IsCancelled__c,EV_id__c from Event_Attendee_Mapping__c WHERE id=:evatmap[0].id AND EV_id__c=:EventID ];
            eam.IsCancelled__c = true;
            database.update(eam);
            system.debug('  DELETE ATTENDEE  '+eam.IsCancelled__c);
            LIST<Individual_Ticket_Info__c> indInfoList= new LIST<Individual_Ticket_Info__c>();
            LIST<Individual_Ticket_Info__c> updateIndInfoList= new LIST<Individual_Ticket_Info__c>();
            indInfoList= [SELECT ID, IsCancelled__c, Registration_Info__r.Available_Quantity__c, Registration_Info__r.Payment_Type__c, Registration_Info__r.TicketTypes__c  FROM Individual_Ticket_Info__c WHERE Registration_Info__r.Event__c =: EventID AND Event_Attendee_Mapping__c =: eam.Id AND (Registration_Info__r.Payment_Type__c =: 'Guest' OR Registration_Info__r.Payment_Type__c =: 'Free') AND IsCancelled__c =: FALSE];

            MAP<Id, Integer> SoldTicketsMAP= new MAP<Id, Integer>();
            for(Individual_Ticket_Info__c ind: indInfoList){
                ind.IsCancelled__c = TRUE;
                ind.Refund_Amount__c = 0;
                ind.Refund_Date__c = Datetime.now();
                ind.Refund_Mode__c = ind.Registration_Info__r.Payment_Type__c;
                updateIndInfoList.add(ind);
                if(SoldTicketsMAP.containsKey(ind.Registration_Info__r.TicketTypes__c)){
                    Integer SoldTicketQuantity= SoldTicketsMAP.get(ind.Registration_Info__r.TicketTypes__c);
                    SoldTicketQuantity= SoldTicketQuantity+1;
                    SoldTicketsMAP.put(ind.Registration_Info__r.TicketTypes__c, SoldTicketQuantity);
                }else if(! SoldTicketsMAP.containsKey(ind.Registration_Info__r.TicketTypes__c)){
                    SoldTicketsMAP.put(ind.Registration_Info__r.TicketTypes__c, 1);
                }
            }
            LIST<TicketTypes__c> ticketsList= new LIST<TicketTypes__c>();
            LIST<TicketTypes__c> updateTicketsList= new LIST<TicketTypes__c>();
            ticketsList= [SELECT ID, TT_Sold__c FROM TicketTypes__c WHERE EV_id__c =:EventID AND Id IN: SoldTicketsMAP.keySet()];  
            if(ticketsList.size() >0){
                for(TicketTypes__c ticket: ticketsList){
                    ticket.TT_Sold__c= ticket.TT_Sold__c -SoldTicketsMAP.get(ticket.Id);
                    updateTicketsList.add(ticket);            
                }

            } 
            Database.Update(updateIndInfoList, FALSE);
            Database.Update(updateTicketsList, FALSE);                
            
            LIST<User_Profile_Event__c> UPEList= new LIST<User_Profile_Event__c>();
            UPEList= [SELECT ID, UEP_isActive__c, EventAdmin_Id__r.UserName,
                      User_id__r.UserName 
                      FROM User_Profile_Event__c 
                      WHERE EV_id__c =: EventID
                      AND Attendee_Summary__c =: AttendeeID
                      AND UEP_isActive__c =: TRUE
                      AND Profile_id__r.PR_Name__c =: 'EventAdmin Staff'];
            if(UPEList.size() >0){
                for(User_Profile_Event__c UPE: UPEList){
                    UPE.UEP_isActive__c = FALSE;                
                }
                Database.Update(UPEList, FALSE);            
            }
            
            Success sc=new Success();
            sc.Attendee_Id=evatmap[0].AS_Id__r.id;
            sc.Event_Id=EventID;
            ct.Success=sc;
        } 
    }   
    return ct;
}

     @future
     global static void updateUserInfo(String Email, String FirstName, String LastName,String Phone,String Company, String JobTitle, string Address, String City,String State, String Country, string zipCode) {
        system.debug('$$$$ '+Email);
        LIST<User> users= new LIST<User>();
        users =[select Id, CompanyAddr1__c, Title, ProfileId,Username,FirstName,LastName,Email,Companyphone__c,CompanyName,States__c,Country__c,CompanyCity__c, Zipcode__c from User where Username=:Email]; 
        if(users.size() > 0){
            users[0].firstname = FirstName;
            users[0].LastName = LastName;
            users[0].Companyphone__c =Phone;
            users[0].companyName=Company;
            users[0].CompanyAddr1__c= Address;  
            users[0].CompanyCity__c=City;
            users[0].States__c=State;
            users[0].Country__c=Country;
            users[0].Zipcode__c= zipCode;
            users[0].Title= JobTitle;
            update users[0];
        }
    }
    
    global class Container{
        public Success Success{get;set;}
        public String Attendee_FirstName{get;set;}
        public String Attendee_LastName{get;set;}
        public String Attendee_Email{get;set;}
        public String Attendee_Phone{get;set;}
        public String Attendee_Company{get;set;}
        public String Attendee_Zip{get;set;}
        public String Address1{get;set;}
        public String Address2{get;set;}
        public String State{get;set;}
        public String State_LongCode{get;set;}
        public String Country{get;set;}
        public String Country_LongCode{get;set;}
        public String Zipcode{get;set;}
        public String JobTitle{get;set;}
        public String AttendeeCategory{get;set;}
                
        public String error{get;set;}
        
        global UserDetails UsrDetails;
        
        public Container(){
        
        }
    }
    
    global class UserDetails{
    
        String FirstName;
        String LastName;
        String Company;
        String PhoneNo;
        String City;
        String State;
        String Country;
        string StateShortForm;
                                
        global UserDetails(){}
        
        global UserDetails(String FirstName, String LastName, String Company, String PhoneNo, String City, String State, String Country, string StateShortForm){
            
            FirstName= FirstName;
            LastName= LastName;
            Company= Company;
            PhoneNo= PhoneNo;
            City= City;
            State= State;                        
            Country= Country;
            StateShortForm= StateShortForm;
        }
    }

    global class Success{    
        public String Attendee_Id{get;set;}
        public Id Event_Id{get;set;}
        public List<Each_Ticket_Details> Each_Ticket_Details{get;set;}
    }   
    
    global class Each_Ticket_Details{
        public String TicketId{get;set;} 
        public String TicketNumber{get;set;}    
        public String SeatNo{get;set;} 
    }
    
}