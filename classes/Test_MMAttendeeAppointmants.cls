@isTest
private class Test_MMAttendeeAppointmants {

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
                             MM_Slot_Timeperiod__c='10',
                             MatchMaking_Type__c='Semi Open'
                             );
      insert eve;
      Id EventId=eve.Id;
       
        AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='test123t@noemail.com';
        att.AS_Company__c ='global';
        att.AS_Company__c ='global';
        att.AS_NAICSCode_1__c='054321';
        att.AS_NAICSCode_2__c='054321';
        att.AS_NAICSCode_3__c='054321';
        att.AS_NAICSCode_4__c='054321';
        att.AS_PrimaryBusinessCategory__c='cpf';
        att.AS_ImageUrl__c='';
        att.Keywords__c='global';
        insert att;  
        
        Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam;
        
      user uname=[select createdby.id from user where profile.Name = 'system Administrator' Limit 1];
        account acc=new account();
        acc.name='Booth Leads';
       acc.ownerid=uname.createdby.id;
       insert acc;
       
        contact  con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con;
          
        Profile p = [select id from Profile where name='Attendee'];
          
         user bu2 =  new User(alias = 'busers', email='test123t@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing',isSignup__c=true, languagelocalekey='en_US', password__c = 'global281',
                  localesidkey='en_US',country='United States', contactId=con.id,
                  timezonesidkey='America/Los_Angeles', username='test123t@noemail.com',CompanyName='Nest',Title='dev');
                  
        insert bu2;
        
        system.debug('hiiiiiiiiiiiiiiii '+bu2);
        // inserting profile Cus    
       Profile__c attendeeProfile= new Profile__c (PR_Name__c='attendee',PR_Version__c='1.5');        
       insert  attendeeProfile;  
       
     // Insert upe for login user  
     User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=eve.id,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=bu2.id,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='Corporate');         
     insert upeEA;   
     
     // for attendee
      AttendeeSummary__c att2 = new AttendeeSummary__c();
        att2.AS_FirstName__c='re';
        att2.AS_LastName__c ='lo';
        att2.AS_Email__c ='test123@noemail.com';
        att2.AS_Company__c ='global';
        insert att2;  
        
        Event_Attendee_Mapping__c eam2 = new Event_Attendee_Mapping__c(AS_id__c=att2.id,EV_id__c=eve.id); 
        insert eam2;
        
      contact  con2 = new contact(firstname='testcontactfn2',lastname='testcontactln2',accountId=acc.id);
       insert con2;
          
        //Profile p = [select id from Profile where name='Attendee'];
          
         user bu3 =  new User(alias = 'busers', email='test123@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing',isSignup__c=true, languagelocalekey='en_US', password__c = 'global281',
                  localesidkey='en_US',country='United States', contactId=con2.id,
                  timezonesidkey='America/Los_Angeles', username='test123@noemail.com',CompanyName='Nest',Title='dev');
                  
        insert bu3;
        
        
         // inserting profile Cus    
       Profile__c attendeeProfile11= new Profile__c (PR_Name__c='attendee',PR_Version__c='1.5');        
       insert  attendeeProfile11;  
       
     // Insert upe for login user  
     User_Profile_Event__c upeEA12= new User_Profile_Event__c (EV_id__c=eve.id,Profile_id__c=attendeeProfile11.id,Status__c='Active',User_id__c=bu3.id,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE');         
     insert upeEA12;  
        
     
      EventSchedule__c EventScheduleCancelled = new EventSchedule__c(EV_id__c=eve.id,MM_To_EAM__c=eam2.id,Is_Matchmaking__c=true,MM_Slot_End_Time__c='2:10 PM',MM_slot_StartTime__c='2:00 PM',MM_To_UPE__c=upeEA.id,MM_Slot_Status__c='Pending');
      insert EventScheduleCancelled ; 
      
     
        
        
       RestContext.request.requestURI = '/MMAttendeeAppointmants';
       RestContext.request.addParameter('exhibitorid', att2.id);
       RestContext.request.addParameter('eveid',eve.id);  
         RestContext.request.addParameter('isMM','TRUE');  
       MMAttendeeAppointmants.doPost();
       
    }
}