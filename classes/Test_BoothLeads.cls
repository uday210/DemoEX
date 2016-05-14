@istest

public class Test_BoothLeads
{
  static testmethod void Testmethod_BoothLeads()
  {
      Profile w = [select id from profile where name='Standard User'];
      
       User u = new User(alias = 'tes523ki', email='test12345k@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test12345k@noemail.com');
                  insert u;
       Id eventAdminId=u.id;    
                  
       Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                                   EV_EndDate__c =  Date.Parse('01/18/2014'),
                                   EV_StartDate__c = Date.Parse('01/18/2014'),
                                   EV_EndTime__c='09:00 AM',
                                   StartTime__c='11:00 AM');
       insert eve;
       Id EventId=eve.Id;               
    
       AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
       insert attSummary;
       string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(EventId);   
     
       Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
       insert event_att_map ;   
    
                  
       BoothVisitSummary__c boothVisitSummary= new BoothVisitSummary__c(BVS_LeadRating__c=4.4,Follow_Update__c=datetime.valueOf('2012-05-15 00:00:00'),ScanTime__c=datetime.valueOf('2012-05-15 00:00:00'),BVS_FirstName__c='Scan',BVS_LastName__c='Me',BVS_Email__c='testboothadmin@noemail.com',EA_AttendeeBarcode__c=event_att_map.Id,User_id__c=u.Id);
       insert boothVisitSummary;
     
     
       User_Event_BVS__c  use_Eve_BVS = new User_Event_BVS__c(BVS_id__c=boothVisitSummary.Id,EV_id__c=EventId);
       insert use_Eve_BVS;                 

       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/BoothLeads';
       RestContext.request.addParameter('UserId', u.Id);
       RestContext.request.addParameter('EventId',eve.id);
       BoothLeads.doPost();
   
  }
}