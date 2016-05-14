@isTest
public class Test_SA_TicketTemplateController {

    public static TestMethod void testMe(){
        Event__c eve = new Event__c(EV_Title__c = 'Test Event', EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/16/2014'),
                                        EV_HostingState__c ='Test State', EV_HostingLocation__c='281 Test Location', 
                                        EV_HostingTimeZone__c = 'Eastern Time(USA)', Status__c = 'Event Progres', EV_Publish__c = TRUE,
                                        Event_Printer__c = 'Avery 22806 easy peal square Badges');
        insert eve;
        
        TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
        insert tic;
        
        TicketTypes__c tic1 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent1',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
        insert tic1;
        
        Constomer__c cus2 = new  Constomer__c();
        cus2.Uniq_Number__c ='test';
        insert cus2;
        
        AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='test123@noemail.com';
        att.AS_Company__c ='global';
        insert att;  
        
        Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam;
 
        Dummay__c com1 = new Dummay__c(Event_Attendee_Mapping__c=eam.id,TicketTypes__c=tic.id,Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test123@noemail.com',First_Name__c='FName',Event__c=eve.id,Email__c='test123@noemail.com',TicketAmount__c=60,Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id, ScanAttendee_Fee__c=0);
        insert com1;
        
        Dummay__c com2 = new Dummay__c(Event_Attendee_Mapping__c=eam.id,TicketTypes__c=tic1.id,Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test123@noemail.com',First_Name__c='FName',Event__c=eve.id,Email__c='test123@noemail.com',TicketAmount__c=60,Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id, ScanAttendee_Fee__c=0);
        insert com2;

        PageReference pd= page.SA_TicketTemplate;
        Test.setCurrentPage(pd);
        String ParameterizedId = String.valueOf(com1.id) + ','+String.valueOf(com2.id);
        
        ApexPages.currentPage().getParameters().put('id',ParameterizedId);
        SA_TicketTemplateController TT = new SA_TicketTemplateController();

        //TT.selectedEvent= ParameterizedId;
        TT.dummyclassforcode();    
        TT.dummyclass2forcode();      

   }
  }