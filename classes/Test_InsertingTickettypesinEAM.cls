@istest

public class Test_InsertingTickettypesinEAM
{
  static testmethod void Testmethod_InsertingTickettypesinEAM()
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
   
   Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=eve.Id,AS_id__c=attsum.Id);
       insert event_att_map ;
   
   TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  Constomer__c cus2 = new  Constomer__c();
   cus2.Uniq_Number__c ='test';
   insert cus2;
  
  Dummay__c com2 = new Dummay__c(TicketTypes__c=tic.id,Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test123@noemail.com',First_Name__c='FName',Event__c=eve.id,Email__c='test@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id);
  insert com2;
  
  Ticket_Eam__c team = new Ticket_Eam__c(Event_Attendee_Mapping__c=event_att_map.id,TicketTypes__c=tic.id );
  insert team; 
  
  update team;
  
  }
}