@isTest
public class Test_BL_addattendeecon{

public static testMethod void testdoget(){

Event__c eve = new Event__c(EV_Title__c='TestEvent',EV_WebsiteURL__c='https://www.globalnest.com');
  insert eve;

TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Event',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  
   Constomer__c cus = new  Constomer__c();
   cus.Uniq_Number__c ='test';
   insert cus;
   Dummay__c com = new Dummay__c(Attendees_Available__c=20,TicketTypes__c=tic.id,Profile__c='BoothAdmin',Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test@salesforce.com',First_Name__c='FName',Event__c=eve.id,Email__c='test@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus.id);
    insert com;
    
     PageReference pg = Page.BL_addattendees;
   Test.setCurrentPage(pg); 
   ApexPages.currentPage().getParameters().put('id', com.id);
       
    BL_addattendeecon con = new BL_addattendeecon();
    ApexPages.currentPage().getParameters().put('fileldName', '0');
    con.deleteRow();
       
    AttendeeSummary__c  art = new AttendeeSummary__c ();
     art.AS_Email__c='test@gmail.com';
     art.AS_FirstName__c='cpk';
     art.AS_LastName__c='lname';
     BL_addattendeecon.inncls fr= new BL_addattendeecon.inncls(0,art);
    con.listofattendees.add(fr); 
    con.saveAttandee();
}

}