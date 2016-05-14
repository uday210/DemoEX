@isTest
private class Test_batchEmailsSending{

    static testMethod void Testmethod_batchEmailsSending() {
    user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
           
             account acc=new account();
            acc.name='Booth Leads';  
            
            acc.ownerid=uname.createdby.id;          
            insert acc;
   contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;

 Profile p = [select id from profile where name='system Administrator'];

User u = new User(alias = 'test123', email='test123890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123890@noemail.com');
                  insert u;

                  Id eventAdminId=u.id;   

  Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  customProfileBooth;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             MM_Start_Date__c =  Date.Parse('01/18/2014'),
                             MM_End_Date__c=  Date.Parse('01/18/2014'),
                             MM_Firstaday_startTime__c ='09:00 AM',
                             MM_Firstaday_EndTime__c ='11:00 AM',
                             MM_Slot_Timeperiod__c = '30',
                             BreakTime_Between_Appointments__c = '10',
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM',
                             Is_MatchMaking_Event__c = TRUE);
      insert eve;
      Id EventId=eve.Id;
      
         AttendeeSummary__c attSummary1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                             AS_Email__c = 'test123890@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
             insert attSummary1 ;
      Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = eve.id, AS_id__c = attSummary1.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
     
    
      User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false,MAtchMakingProfile__c ='Corporate');         
      insert upeEA; 
        
    EventSchedule__c Esch = new EventSchedule__c(EV_id__c = EventId , MM_To_EAM__c = EAM1.id ,MM_To_UPE__c = upeEA.id,
                                MM_slot_Date__c =  Date.Parse('06/18/2015'),
                                MM_Slot_End_Time__c = ('07:30 AM'),
                                MM_slot_StartTime__c = ('07:00 PM'),
                                MM_Slot_Status__c = 'Accepted');
                insert Esch ;
       MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('01/18/2014'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = EventId,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
           Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks;      
        cookie  counter = new Cookie('counter',EventId,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
    
    string strv ='Corporate';
    //BatchClass bc = new BatchClass();
    //query = 'SELECT EV_id__r.EV_HostingZipcode__c,EV_id__r.EV_HostingState__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HistingAddr1__c,EV_id__r.EV_Title__c ,EV_id__r.EV_StartDate__c,id,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_Email__c FROM User_Profile_Event__c where EV_id__c ='+EventId+' AND MAtchMakingProfile__c ='+strv+' Limit 200';
    List<User_Profile_Event__c> l1 = new List<User_Profile_Event__c>();
    l1.add(upeEA);
    Database.QueryLocator QL;
        Database.BatchableContext BC;
    //String query='SELECT (select id from EventSchedule__r),EV_id__r.EV_HostingZipcode__c,EV_id__r.EV_HostingState__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HistingAddr1__c,EV_id__r.EV_Title__c ,EV_id__r.EV_StartDate__c,id,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_Email__c FROM User_Profile_Event__c where EV_id__c =EventId AND MAtchMakingProfile__c ='+'\'Corporate\'';
    // Test.startTest();
    
List<User_Profile_Event__c> up= new List<User_Profile_Event__c>();
         
         
          batchEmailsSending bes= new batchEmailsSending();
          bes.SelectEvent =EventId;
          bes.url = URL.getSalesforceBaseUrl().toExternalForm();
          
          database.executebatch(bes,90);
    
    
    
    
    
    
    
    
    }
    
    
}