@isTest
private class Test_MMuserLogin {

    static testMethod void myUnitTest() {
          System.RestContext.request = new RestRequest();
         
         Profile__c profilep =new Profile__c();
         profilep.PR_Name__c ='Attendee' ;
         insert profilep;
         
         // Event Inserting 
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
       Profile p = [Select id, name FROM Profile limit 1];
         user bu2 =  new User(alias = 'busers', email='buser3@badmin.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing',isSignup__c=true, languagelocalekey='en_US', password__c = 'global281',
                  localesidkey='en_US',country='United States',
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
        
        User_Profile_Event__c upe = new User_Profile_Event__c(User_id__c=bu2.id,EV_id__c=eve.id,Profile_id__c=profilesvalue.id,Attendee_Summary__c=att2.id,MAtchMakingProfile__c='Corporate',IsMatchMakingUser__c=TRUE);
       insert upe;
      
        RestContext.request.requestURI = '/MMUserLogin';
       RestContext.request.addParameter('userName', 'buser3@badmin.com');
       RestContext.request.addParameter('passWord','global281');  
       RestContext.request.addParameter('isMM','TRUE');  
       MMUserLogin.doPost();
       
       upe.IsMatchMakingUser__c=FALSE;
       update upe;
      
       
        RestContext.request.requestURI = '/MMUserLogin';
       RestContext.request.addParameter('userName', 'buser3@badmin.com');
       RestContext.request.addParameter('passWord','global281');  
       RestContext.request.addParameter('isMM','TRUE');  
       MMUserLogin.doPost();
       
         
    }
}