@istest

public class Test_badgeLabelAndColorUpdate
{
  static testmethod void Testmethod_badgeLabelAndColorUpdate()
  {
   contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
   Profile p = [select id from profile where name='Standard User'];
   
   AttendeeSummary__c attsum = new AttendeeSummary__c(AS_FirstName__c='phani',AS_LastName__c='Testing',AS_Email__c='boothadmin@boothleads.com');
       insert attsum ;
  
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
       EV_EndDate__c = Date.Parse('01/18/2014'),
       EV_StartDate__c = Date.Parse('01/18/2014'),
       EV_EndTime__c='09:00 AM',
       StartTime__c='11:00 AM');
       insert eve;
   
   Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=eve.Id,AS_id__c=attsum.Id,Attendee_Types__c= 'Attendee',TicketTypes__c='Full Conference');
   insert event_att_map ;
  
  update event_att_map;
  }
}