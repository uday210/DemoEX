@isTest
private class Test_MMscheduleReq {

    static testMethod void myUnitTest() {
        System.RestContext.request = new RestRequest();
         Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_Publish__c =true,
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_StartDate__c=date.valueOf('2013-09-24'),
                             EV_EndDate__c=date.valueOf('2013-09-25'),
                             MM_Start_Date__c =date.valueOf('2013-09-24'),
                             MM_Firstaday_startTime__c='2:00 PM',
                             MM_Firstaday_EndTime__c='6:00 PM',
                             MM_Slot_Timeperiod__c='10'
                             );
      insert eve;
      Id EventId=eve.Id;
      
      AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='test123t@noemail.com';
        att.AS_Company__c ='global';
        insert att;  
        
       MatchLeads_Days__c ed = new MatchLeads_Days__c(); 
        ed.MatchLeads_Date__c=date.valueOf('2013-09-25');
        ed.Slot_Time_period__c='10'; 
        ed.MAX_noOf_appontments__c=12;
        ed.Event__c =eve.id;
        insert ed;
        
      Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam;
        Profile p = [select id from Profile where name='attendee'];
       user uname=[select createdby.id from user where profile.Name = 'system Administrator' Limit 1];
       account acc=new account();
       acc.name='Booth Leads';
       acc.ownerid=uname.createdby.id;
       insert acc;
       // Login user 
       contact  con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con;
      
      // Booth admin 
      
         user bu2 =  new User(alias = 'busers', email='buser3@badmin.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing',isSignup__c=false, languagelocalekey='en_US', password__c = 'global281',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles', username='buser3@badmin.com',CompanyName='Nest',Title='dev');
                  
        insert bu2;
        
        AttendeeSummary__c att2 = new AttendeeSummary__c();
        att2.AS_FirstName__c='re';
        att2.AS_LastName__c ='lo';
        att2.AS_Email__c ='buser3@badmin.com';
        att2.AS_Company__c ='global';
        insert att2;  
        profile__c profilesvalue = new profile__c();
        profilesvalue.PR_Name__c='Booth Admin';
        insert profilesvalue;
      
        Event_Attendee_Mapping__c eam2 = new Event_Attendee_Mapping__c(AS_id__c=att2.id,EV_id__c=eve.id); 
        insert eam2;
        
        User_Profile_Event__c upe = new User_Profile_Event__c(User_id__c=bu2.id,IsMatchMakingUser__c = true,EV_id__c=eve.id,Profile_id__c=profilesvalue.id,Attendee_Summary__c=att2.id);
       insert upe;
      
      //  EventSchedule__c EventScheduleCancelled = new EventSchedule__c(EV_id__c=eventId,MM_To_EAM__c=eam.id,Is_Matchmaking__c=true,MM_Slot_End_Time__c='2:10 PM',MM_slot_StartTime__c='2:00 PM',MM_To_UPE__c=upe.id,MM_Slot_Status__c='Pending');
       // insert EventScheduleCancelled ; 
       MatchLeads_Days__c md = new MatchLeads_Days__c(Slot_Time_period__c='10',Event__c=eve.id,MatchLeads_Date__c=Date.valueOf('2013-09-24'));
       insert md;
      
       RestContext.request.requestURI = '/MMScheduleReq';
       
       RestContext.request.addParameter('eveid', eve.id);
       RestContext.request.addParameter('exhid', bu2.id);
       RestContext.request.addParameter('attid', eam.id);
       RestContext.request.addParameter('dateval', '2013-09-24');
       RestContext.request.addParameter('timeval','03:00 PM-03:15 PM');  
       RestContext.request.addParameter('status','Pending');  
       RestContext.request.addParameter('comments', 'Hi');
       RestContext.request.addParameter('loginid',bu2.id);  
       MMScheduleReq.doPost();

    }
}