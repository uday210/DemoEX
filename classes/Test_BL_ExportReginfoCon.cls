@istest
public class Test_BL_ExportReginfoCon
{
  static testmethod void unitTest(){
    Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
      
      
        TicketTypes__c TT2= new TicketTypes__c();
        TT2.TT_Name__c=' ticket type2';
        TT2.EV_id__c=EventId;
        TT2.TT_TicketType__c='Paid';
        TT2.Ticket_Category__c='Attendee';
        TT2.Service_Fee__c='Include the Booth Leads fee in to the total ticket fee';
        TT2.TT_Limit__c=34;
        TT2.TT_Sold__c=4;
        TT2.Min_Tickets_per_Order__c=10;
        TT2.Max_Tickets_per_Order__c =20;
        TT2.TT_Amount__c=500;
        TT2.Sales_End_Date__c =system.today()+5;
        TT2.TT_Amount__c=500;
        TT2.TT_Available__c=500;
        insert TT2;
        
        AttendeeSummary__c attsum = new AttendeeSummary__c(AS_FirstName__c='phani',AS_LastName__c='Testing',AS_Email__c='boothadmin@boothleads.com',AS_WorkAddress1__c='cpk',AS_WorkAddress2__c='gf',AS_BusinessDescription__c='yu',AS_Company__c='Global,Nest<hup');                               
       insert attsum ;
       
       Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=eve.Id,AS_id__c=attsum.Id);
       insert event_att_map ;
        
      Constomer__c cus = new Constomer__c(isinserted__c=true);
      insert cus;
      
      Dummay__c dup = new Dummay__c();
      dup.Event_Attendee_Mapping__c = event_att_map.id;
      dup.First_Name__c ='phani';
      dup.last_Name__c ='phani';
      dup.email__c ='boothadmin@boothleads.com';
      dup.TicketTypes__c =  TT2.id;
      dup.customer_key__c =cus.id;
      dup.Event__c =eve.id;
      insert dup;
      ExportReginfoCon expo = new ExportReginfoCon();
      string[] stree = new string[]{};
      stree.add('Attendee');
      expo.str =stree;
      expo.export();   
  }
 }