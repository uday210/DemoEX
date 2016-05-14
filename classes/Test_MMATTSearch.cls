@isTest
private class Test_MMATTSearch {

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
        att.AS_Email__c ='buser2@badmin.com';
        att.AS_Company__c ='global';
        insert att;  
        
        Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id,Boothleads_Profile__c = 'Attendee',IsMatchMakingAttendee__c = TRUE); 
        insert eam;
        
        
        
        AttendeeSummary__c att2 = new AttendeeSummary__c();
        att2.AS_FirstName__c='re';
        att2.AS_LastName__c ='lo';
        att2.AS_Email__c ='buser3@badmin.com';
        att2.AS_Company__c ='global';
        insert att2;  
        
        Event_Attendee_Mapping__c eam2 = new Event_Attendee_Mapping__c(AS_id__c=att2.id,EV_id__c=eve.id,Boothleads_Profile__c = 'Attendee',IsMatchMakingAttendee__c = TRUE); 
        insert eam2;  
        
       RestContext.request.requestURI = '/MMATTSerach';
       RestContext.request.addParameter('eveid', eve.id);
       RestContext.request.addParameter('keyword','123456');  
       RestContext.request.addParameter('isMM','True');  
       MMATTSerach.doPost();
        
         RestContext.request.requestURI = '/MMATTSerach';
       RestContext.request.addParameter('eveid', eve.id);
       RestContext.request.addParameter('keyword','pch');  
       RestContext.request.addParameter('isMM','True');  
       MMATTSerach.doPost();
        
          
         RestContext.request.requestURI = '/MMATTSerach';
       RestContext.request.addParameter('eveid', eve.id);
       RestContext.request.addParameter('keyword','');  
       RestContext.request.addParameter('isMM','True');  
       MMATTSerach.doPost();
       
         
         RestContext.request.requestURI = '/MMATTSerach';
       RestContext.request.addParameter('eveid', '');
       RestContext.request.addParameter('keyword','pch');  
       RestContext.request.addParameter('isMM','True');  
       MMATTSerach.doPost();
         
    }
}