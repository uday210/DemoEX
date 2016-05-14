public without sharing class SA_AddUsersController{
 
    public SA_AddUsersController(){   
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){
            selectedEventId= counter.getValue();
            SelectedEvent= new Event__c();
            SelectedEvent= [SELECT  ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, 
                            EV_HostingZipcode__c, EV_EventLogo__c, EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,
                            (SELECT ID FROM MatchLeads_Days__r) 
                            FROM Event__c 
                            Where Id=:SelectedEventId];

            isPastEvent= FALSE;
            if(SelectedEvent.EV_EndDate__c < system.today()){
                isPastEvent= TRUE;                
            }
            List<User_Profile_Event__c> loginUserProfile= new LIST<User_Profile_Event__c>();
            loginUserProfile= [SELECT ID, Profile_id__r.PR_Name__c 
                               FROM User_Profile_Event__c 
                               WHERE EV_id__c =: SelectedEventId AND 
                               UEP_isActive__c =: TRUE AND
                               User_id__c =: UserInfo.getUserId()];
            
            isEventAdminStaffUser= FALSE;                               
            if(loginUserProfile.size() >0){
                for(User_Profile_Event__c prof: loginUserProfile){
                    if(prof.Profile_id__r.PR_Name__c == 'EventAdmin Staff'){
                        isEventAdminStaffUser= TRUE;
                    }
                }
            }  
        }

        displayEventAdminStaff();
        password='';
        
    }
    public Boolean isPastEvent{get; set;}     
    public Boolean isEventAdminStaffUser{get; set;}  
     public void displayEventAdminStaff(){
        
        ShowEventAdminStaffList= TRUE;
        showAddEventAdminStaff=FALSE;
        selectedUserEditId=NULL;
        errorbool= FALSE;
        /*
        LIST<Event_Attendee_Mapping__c> AttendeesList= new LIST<Event_Attendee_Mapping__c>();
        AttendeesList=[SELECT ID, AS_Id__c FROM Event_Attendee_Mapping__c WHERE EV_id__c =: selectedEventId AND IsCancelled__c =: FALSE];
        SET<Id> AttendeeIds= new SET<Id>();
        for(Event_Attendee_Mapping__c EAM: AttendeesList){
            AttendeeIds.add(EAM.AS_Id__c);
        }
                                      Attendee_Summary__c IN : AttendeeIds AND
        */
        EventAdminStaffList= new LIST<User_Profile_Event__c> ();
        EventAdminStaffList= [SELECT ID, Attendee_Summary__c, Attendee_Summary__r.AS_FirstName__c, 
                              Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Email__c,
                              Attendee_Summary__r.AS_Company__c, Attendee_Summary__r.AS_Title__c,Attendee_Summary__r.AS_CellPhone__c 
                              FROM User_Profile_Event__c
                              WHERE EV_id__c =: selectedEventId AND
                              EventAdmin_Id__c =: UserInfo.getUserId() AND 
                              Profile_id__r.PR_Name__c =: 'EventAdmin Staff' AND
                              UEP_isActive__c =: TRUE
                              AND User_Id__r.ScanAttendee_User__c =: TRUE];
            
    }
    
    public Event__c SelectedEvent{get; set;}
    public String selectedEventId{get; set;}
    public LIST<User_Profile_Event__c> EventAdminStaffList{get; set;}
    public AttendeeSummary__c AttendeeSummary {get; set;}
    public Event_Attendee_Mapping__c EAMForEventAdminStaff{get; set;}
    public User_Profile_Event__c UPEForEventAdminStaff{get; set;}
    public boolean showAddEventAdminStaff{get; set;}
    public boolean ShowEventAdminStaffList{get; set;}
    public User userForEventAdminStaff{get;set;}  
    public  AttendeeSummary__c AttendeeForEventAdminStaff{get; set;}
    public String selectedUserEditId{get; set;}
    public String selectedUserDeleteId{get; set;}
    
    public void addEventStaff(){     
        showAddEventAdminStaff=TRUE;
        ShowEventAdminStaffList= FALSE;
        errorbool= FALSE;
        userForEventAdminStaff= new User();
        AttendeeSummary= new AttendeeSummary__c();
        AttendeeForEventAdminStaff= new AttendeeSummary__c();
        EAMForEventAdminStaff= new Event_Attendee_Mapping__c();
        SelectedUserEditId= '';
        password='';
    
    }
    
    public void editEventStaff(){
        
        showAddEventAdminStaff=TRUE;
        ShowEventAdminStaffList= FALSE;
        AttendeeForEventAdminStaff= new AttendeeSummary__c();
        errorbool= FALSE;
        system.debug(' USER EDIT ID  '+SelectedUserEditId);
        User_Profile_Event__c upe= new User_Profile_Event__c();
        if(SelectedUserEditId != NULL){
            upe= [SELECT ID, User_id__c, Attendee_Summary__c
                  FROM User_Profile_Event__c
                  WHERE ID =: SelectedUserEditId];
        }      
        if(upe != NULL){      
            AttendeeForEventAdminStaff= [SELECT ID, AS_FirstName__c, AS_LastName__c, AS_Email__c, AS_Company__c, 
                                         AS_Title__c, AS_CellPhone__c 
                                         FROM AttendeeSummary__c 
                                         WHERE ID =: upe.Attendee_Summary__c];
            system.debug(' ATTENDEE DETAILS '+AttendeeForEventAdminStaff.AS_Company__c);
        }
        userForEventAdminStaff= new User();
        password='';
        userForEventAdminStaff= [SELECT ID, FirstName, LastName, Phone, UserName, CompanyName, password__c
                                 FROM User
                                 WHERE ID =: upe.User_id__c];
        password= userForEventAdminStaff.password__c;
        system.debug(userForEventAdminStaff.password__c+' EDIT PASSWORD '+password);
        AttendeeSummary = new AttendeeSummary__c();
        EAMForEventAdminStaff= new Event_Attendee_Mapping__c();
    
    }
    
     public void deleteUser(){
    
         system.debug(' USER EDIT ID  '+SelectedUserDeleteId);
        User_Profile_Event__c upe= new User_Profile_Event__c();
        upe= [SELECT ID, Attendee_Summary__c, User_id__c,UEP_isActive__c
              FROM User_Profile_Event__c
              WHERE ID =: SelectedUserDeleteId];
        
        upe.UEP_isActive__c= FALSE;
        Database.Update(upe, FALSE);
        Event_Attendee_Mapping__c UpdateEAM= new Event_Attendee_Mapping__c();
        
        UpdateEAM= [SELECT ID, IsCancelled__c FROM Event_Attendee_Mapping__c WHERE AS_Id__c =: upe.Attendee_Summary__c AND EV_id__c =:SelectedEventId LIMIT 1];
        UpdateEAM.IsCancelled__c= TRUE;
        Database.update(UpdateEAM, FALSE);
        displayEventAdminStaff();
    }
    
    public Boolean errorBool{get; set;}
    public void saveEventAdminStaff(){
    
         //showAddEventAdminStaff= false;
        //try{
            Profile__c EAStaffProfile= [SELECT Id FROM Profile__c WHERE PR_Name__c = 'EventAdmin Staff' LIMIT 1];
           
            List<User> EventAdminStaffUser= [SELECT Username,Email FROM User WHERE Username=: AttendeeForEventAdminStaff.AS_Email__c AND ScanAttendee_User__c =: TRUE];
            LIST<User_Profile_Event__c> upeslist= [SELECT Id,EV_id__c,User_id__c, Attendee_Summary__c FROM User_Profile_Event__c WHERE EV_id__c=: SelectedEventId AND User_id__r.Username=: AttendeeForEventAdminStaff.AS_Email__c AND UEP_isActive__c =: TRUE AND Attendee_Summary__r.AS_Email__c =: AttendeeForEventAdminStaff.AS_Email__c AND EventAdmin_Id__c =: UserInfo.getUserId()];
            system.debug(EventAdminStaffUser.size()+'  EXISTING DATA FOR USER  '+EventAdminStaffUser);
            system.debug(upeslist.size()+'  EXISTING DATA FOR UPE '+upeslist);
            //upe = new User_Profile_Event__c();
            UPEForEventAdminStaff= new User_Profile_Event__c(); 

           system.debug(EventAdminStaffUser.size()+' ERROR BOOLEAN000000  '+upeslist.size());
           if(EventAdminStaffUser.size()>0 && upeslist.size()>0){
               system.debug(EventAdminStaffUser.size()+' ERROR BOOLEAN1111111 '+selectedUserEditId );
               
               if(selectedUserEditId == NULL || selectedUserEditId ==''){
                    errorbool= true;                     
                   /*
                   Database.upsert(AttendeeForEventAdminStaff, AttendeeSummary__c.AS_Email__c, FALSE);
                   LIST<Event_Attendee_Mapping__c> ExistingStaff= new LIST<Event_Attendee_Mapping__c>();
                   ExistingStaff= [SELECT ID, AS_Id__c, IsCancelled__c 
                                   FROM Event_Attendee_Mapping__c 
                                   WHERE EV_id__c =: selectedEventId 
                                   AND IsCancelled__c =: TRUE 
                                   AND AS_Id__r.AS_Email__c =: AttendeeForEventAdminStaff.AS_Email__c];
                   if(ExistingStaff.size()>0){
                       for(Event_Attendee_Mapping__c EAM: ExistingStaff){
                           if(ExistingStaff[0].IsCancelled__c == TRUE){
                               ExistingStaff[0].IsCancelled__c= FALSE;                       
                           }
                       }
                       Database.update(ExistingStaff, FALSE);
                       userForEventAdminStaff= new User();
                       userForEventAdminStaff= [SELECT ID, firstName, lastName, phone, CompanyName, password__c
                                            FROM User
                                            WHERE UserName =: AttendeeForEventAdminStaff.AS_Email__c];
                   
                       userForEventAdminStaff.firstName= AttendeeForEventAdminStaff.AS_FirstName__c; 
                       userForEventAdminStaff.lastName= AttendeeForEventAdminStaff.AS_LastName__c;                   
                       userForEventAdminStaff.phone= AttendeeForEventAdminStaff.AS_CellPhone__c;
                       userForEventAdminStaff.CompanyName= AttendeeForEventAdminStaff.AS_Company__c;
                       userForEventAdminStaff.password__c= password;         
                             
                       Database.update(userForEventAdminStaff, FALSE);
                       updateUser(userForEventAdminStaff.Id, password);
                       displayEventAdminStaff();
                   }else{
                       errorbool= true;                     
                   }   
                   */
               }else{
                   system.debug('  UPDATE ATTANDEE11111111  '+AttendeeForEventAdminStaff);
                   Database.upsert(AttendeeForEventAdminStaff, AttendeeSummary__c.AS_Email__c, FALSE);
                   system.debug('  UPDATE ATTANDEE2222222222  '+AttendeeForEventAdminStaff);
                   saveEam();
                   Database.Update(upeslist, FALSE);
                   userForEventAdminStaff= new User();
                   userForEventAdminStaff= [SELECT ID, firstName, lastName, phone, CompanyName, password__c
                                            FROM User
                                            WHERE UserName =: AttendeeForEventAdminStaff.AS_Email__c];
                   
                   userForEventAdminStaff.firstName= AttendeeForEventAdminStaff.AS_FirstName__c; 
                   userForEventAdminStaff.lastName= AttendeeForEventAdminStaff.AS_LastName__c;                   
                   userForEventAdminStaff.phone= AttendeeForEventAdminStaff.AS_CellPhone__c;
                   userForEventAdminStaff.CompanyName= AttendeeForEventAdminStaff.AS_Company__c;
                   userForEventAdminStaff.password__c= password;         
                   userForEventAdminStaff.IsActive= TRUE;                                      
                                                
                   Database.update(userForEventAdminStaff, FALSE);
                   updateUser(userForEventAdminStaff.Id, password);
                   displayEventAdminStaff();
               }


            }else if((EventAdminStaffUser.size()>0) && (upeslist.size() <= 0)){
                system.debug(upeslist.size()+'  EXISTING ELSE '+upeslist);
                User User1 = [SELECT Id,Username FROM User WHERE Username=: AttendeeForEventAdminStaff.AS_Email__c AND ScanAttendee_User__c =: TRUE];
                Database.upsert(AttendeeForEventAdminStaff, AttendeeSummary__c.AS_Email__c, FALSE);
                saveEam();
                showAddEventAdminStaff= false;
                
                userForEventAdminStaff= new User();
                   userForEventAdminStaff= [SELECT ID, firstName, lastName, phone, CompanyName, password__c
                                            FROM User
                                            WHERE UserName =: AttendeeForEventAdminStaff.AS_Email__c];
                   
                   userForEventAdminStaff.firstName= AttendeeForEventAdminStaff.AS_FirstName__c; 
                   userForEventAdminStaff.lastName= AttendeeForEventAdminStaff.AS_LastName__c;                   
                   userForEventAdminStaff.phone= AttendeeForEventAdminStaff.AS_CellPhone__c;
                   userForEventAdminStaff.CompanyName= AttendeeForEventAdminStaff.AS_Company__c;
                   userForEventAdminStaff.password__c= password;         
                   userForEventAdminStaff.IsActive= TRUE;      
                                                   
                   Database.update(userForEventAdminStaff, FALSE);
                   updateUser(userForEventAdminStaff.Id, password);
                   
                LIST<User_Profile_Event__c> existingUPE= [SELECT Id,EV_id__c,User_id__c, Attendee_Summary__c,
                                                          UEP_isActive__c 
                                                          FROM User_Profile_Event__c 
                                                          WHERE EV_id__c=: SelectedEventId AND 
                                                          EventAdmin_Id__c =: UserInfo.getUserId() AND
                                                          User_id__r.Username=: AttendeeForEventAdminStaff.AS_Email__c AND
                                                          Attendee_Summary__r.As_Email__c =: AttendeeForEventAdminStaff.AS_Email__c  
                                                          AND UEP_isActive__c =: FALSE];
                
                if(existingUPE.size() == 0){
                
                User_Profile_Event__c UPE = new User_Profile_Event__c();
                
                UPE.EventAdmin_Id__c = UserInfo.getUserId();
                upe.EV_id__c = SelectedEventId;
                upe.Attendee_Summary__c = AttendeeForEventAdminStaff.id;
                UPE.UEP_isActive__c = True;
                UPE.Profile_id__c = EAStaffProfile.id;
                UPE.User_id__c = EventAdminStaffUser[0].ID;
                Database.Insert(UPE, FALSE);
                system.debug('  CREATE ONLY UPE  '+UPE);
                displayEventAdminStaff();
            }else{
                existingUPE[0].UEP_isActive__c= TRUE;
                Database.Update(existingUPE[0], FALSE);
                displayEventAdminStaff();
            }
            saveEam();
            }else{

                String EmailNote= 'Welcome to Scan Attendee Event Administration Portal.\n\nYour login details are provided at the end of this email.\n\n\nYou will be asked to set a password when you first login.Passwords are case sensitive.\nIf you forget the password, please use the forgot password link in the login page.\n\n\nTo login, go to http://www.boothleads.com and click on Login.\n\n\nFor assistance, contact us at support@boothleads.com\n\n\nOnce again Welcome to Scan Attendee \n\n Please note that your Scan Attendee portal access is valid only for 30 days from the end of your event.\nPlease remember to export all your leads.\nIf you need access beyond this, please contact support.\n\n\nThank you,\nScan Attendee Customer Support\nsupport@boothleads.com';
                
                String EmailSubject= 'Welcome to Scan Attendee - Your registration was successful';
                Profile pr = [select Id from Profile where Name = 'System Administrator'];
                user uname=[SELECT CreatedById FROM User WHERE ProfileId=:Pr.Id LIMIT 1];
                Account acc = new Account();
                acc.name='Scan Attendee';     
                //acc.ownerid = userinfo.getuserid();         
                acc.ownerid = uname.CreatedById;         
                insert acc; 
                system.debug('  CREATE ACCOUNT  '+acc);
                  
                Contact Con = new Contact();
                Con.Lastname = AttendeeForEventAdminStaff.AS_LastName__c;
                Con.Firstname = AttendeeForEventAdminStaff.AS_FirstName__c; 
                Con.AccountID = acc.id;
                Con.Email_Notes__c = EmailNote; 
                Con.Email_Subject__c = EmailSubject;
                insert Con;
                system.debug('  CREATE CONTACT '+Con); 

                Database.upsert(AttendeeForEventAdminStaff, AttendeeSummary__c.AS_Email__c, FALSE);
                saveEam();                

                Profile p = [SELECT Id,Name FROM Profile WHERE Name = 'Event Admin'];
                
                List<User> ScanAttendeeUser= [SELECT Username,Email, ScanAttendee_User__c FROM User WHERE Username=: AttendeeForEventAdminStaff.AS_Email__c AND ScanAttendee_User__c =: FALSE];
                system.debug(ScanAttendeeUser.size()+' SCAN ATTENDEE '+ScanAttendeeUser);
                User U = new User();        
                if(ScanAttendeeUser.size() >0){
                   // ScanAttendeeUser[0]=U;
                    for(User uc:ScanAttendeeUser){
                        uc.ScanAttendee_User__c= TRUE;
                    }    
                    Database.update(ScanAttendeeUser, FALSE);
                    //updateUser(U.Id);
                    system.debug(ScanAttendeeUser[0].ScanAttendee_User__c+' SCAN ATTENDE  USER '+U);
                }
                else{

                    U.ContactID = Con.id;
                    U.FirstName = AttendeeForEventAdminStaff.AS_FirstName__c;
                    U.LastName = AttendeeForEventAdminStaff.AS_LastName__c;
                    U.Username = AttendeeForEventAdminStaff.AS_Email__c;
                    U.Email = AttendeeForEventAdminStaff.AS_Email__c;
                    U.Phone = userForEventAdminStaff.phone;
                    U.Alias = 'EAStaff';
                    U.ProfileID = P.id;
                    U.LocaleSidKey = 'en_US';
                    U.LanguageLocaleKey = 'en_US';
                    U.TimeZoneSidKey = 'America/Los_Angeles';
                    U.EmailEncodingKey='UTF-8';
                    U.ScanAttendee_User__c = TRUE;
                    U.is_Event_Admin_Staff_User__c = TRUE;
                    U.password__c = password;
                    Database.insert(U);
                    system.debug(' INSERT USER '+U);                 
                    updateUser(U.Id, password);
                }
                
                
                LIST<User_Profile_Event__c> existingUPE= [SELECT Id,EV_id__c,User_id__c, Attendee_Summary__c,
                                                          UEP_isActive__c 
                                                          FROM User_Profile_Event__c 
                                                          WHERE EV_id__c=: SelectedEventId AND 
                                                          EventAdmin_Id__c =: UserInfo.getUserId() AND
                                                          User_id__r.Username=: AttendeeForEventAdminStaff.AS_Email__c 
                                                          AND UEP_isActive__c =: FALSE
                                                          AND Profile_id__r.PR_Name__c =: 'EventAdmin Staff'];
                
                if(existingUPE.size() == 0){
                
                User_Profile_Event__c UPE = new User_Profile_Event__c();
                
                UPE.EventAdmin_Id__c = UserInfo.getUserId();
                upe.EV_id__c = SelectedEventId;
                upe.Attendee_Summary__c = AttendeeForEventAdminStaff.id;
                UPE.UEP_isActive__c = True;
                UPE.Profile_id__c = EAStaffProfile.id;
                UPE.User_id__c = U.ID;
                Database.Insert(UPE, FALSE);                
                //UpdateUser(U.Id, password);
                system.debug('  CREATE ONLY UPE  '+UPE);
                
            }else{
                existingUPE[0].UEP_isActive__c= TRUE;
                Database.Update(existingUPE[0], FALSE);
            }
              
                showAddEventAdminStaff= false;
                displayEventAdminStaff();
          }
       //}catch(Exception e){
             //ApexPages.addMessages(e);
       //} 
    
    }
    
    Public String Password{get;set;}
    public void saveEam(){
    
        Event_Attendee_Mapping__c insertEAM= new Event_Attendee_Mapping__c();
        insertEAM.Attendee_Event_IDs__c= AttendeeForEventAdminStaff.id+'-'+SelectedEventId;
        insertEAM.AS_id__c= AttendeeForEventAdminStaff.id;
        insertEAM.EV_id__c= SelectedEventId; 
        insertEAM.Boothleads_Profile__c= 'Attendee';
        insertEAM.IsCancelled__c = FALSE;
        insertEAM.GuestType__c= 'Attendee Staff';
        Database.upsert(insertEAM, Event_Attendee_Mapping__c.Attendee_Event_IDs__c, FALSE);
        

        LIST<Dummay__c> RegInfoList= new LIST<Dummay__c>();
        LIST<TicketTypes__c> attendeeStaffTicket= new LIST<TicketTypes__c>([SELECT ID, TT_Sold__c FROM TicketTypes__c WHERE TT_Name__c =: 'Attendee Staff' AND EV_id__c =: SelectedEventId]);
        RegInfoList= [SELECT ID FROM Dummay__c WHERE Event_Attendee_Mapping__c =: insertEAM.Id AND TicketTypes__c =: attendeeStaffTicket[0].Id AND Event__c =: SelectedEventId];
        system.debug(RegInfoList.size()+' REG INFO IDS '+RegInfoList);
        if(RegInfoList.size() <=0) {
            Constomer__c TransactionInfo = new Constomer__c();
                                    
            TransactionInfo.Email__c= AttendeeForEventAdminStaff.AS_Email__c;
            TransactionInfo.Customer_Name__c= AttendeeForEventAdminStaff.AS_FirstName__c+' '+AttendeeForEventAdminStaff.AS_LastName__c;
            TransactionInfo.Isinserted__c = TRUE;
            
            Database.Insert(TransactionInfo,False);
            
            Dummay__c  RegistrationNewInfoForTicket= new Dummay__c();        
                                
    
            RegistrationNewInfoForTicket.AttendeeSummary__c = AttendeeForEventAdminStaff.Id;
            RegistrationNewInfoForTicket.Company__c = AttendeeForEventAdminStaff.AS_Company__c;
            RegistrationNewInfoForTicket.Email__c = AttendeeForEventAdminStaff.AS_Email__c;
            RegistrationNewInfoForTicket.Last_Name__c = AttendeeForEventAdminStaff.AS_LastName__c;
            RegistrationNewInfoForTicket.First_Name__c = AttendeeForEventAdminStaff.AS_FirstName__c;
            RegistrationNewInfoForTicket.Event__c = SelectedEventId ;
            RegistrationNewInfoForTicket.customer_key__c = TransactionInfo.Id;
            RegistrationNewInfoForTicket.Update_with_created_date__c = Date.Today();
            RegistrationNewInfoForTicket.Payment_Status__c =  'Paid';
            RegistrationNewInfoForTicket.Payment_Type__c = 'Guest';
            RegistrationNewInfoForTicket.Event_Attendee_Mapping__c =  insertEAM.id;
            RegistrationNewInfoForTicket.Tickets_Quantty__c = 1;
            RegistrationNewInfoForTicket.TicketAmount__c= 0;
            
            if(attendeeStaffTicket.size() >0){
                RegistrationNewInfoForTicket.TicketTypes__c = attendeeStaffTicket[0].Id;
                attendeeStaffTicket[0].TT_Sold__c += 1;
            }            
            
            Database.Insert(RegistrationNewInfoForTicket, FALSE);
            Database.Update(attendeeStaffTicket, FALSE);
        }                                   
    }
    
     @future
    public static void updateUser(Id UserId, String pwd){
           User U1 = new User();
           U1 =[SELECT Id,password__c FROM User WHERE Id =: UserId];
           system.debug(' USER DETAILS '+U1);
           System.setPassword(U1.Id, U1.Password__c);
           //U1.password__c = pwd;
        //   system.debug(' PASSWORD '+U1.password__c);
       //    update U1;
    }
    
    public void cancelStaff(){
    
         ShowEventAdminStaffList= TRUE;
         showAddEventAdminStaff=FALSE;
        
    
    }
    
    public PageReference checkUserId() {
        if (userInfo.getUserType() == 'guest') {
            Pagereference pg = new pagereference('/SA_Signup');
            pg.setredirect(true);
            return pg;
        }else {
            return null;
        }
    }
 
}