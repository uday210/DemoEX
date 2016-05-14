@isTest
public class Test_SendEmailAfterReg_SucessCon {
  public static TestMethod void testMe(){
  
      Event__c eve = new Event__c(OrganizerId__c='phani@globalnest.com',EV_Title__c='TestEvent',EV_WebsiteURL__c='https://www.globalnest.com',EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/18/2014'),EV_EndTime__c='09:00 PM',StartTime__c='11:00 AM');
      insert eve;
      
      TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
      insert tic;
     
       Constomer__c cus2 = new  Constomer__c();
       cus2.Uniq_Number__c ='test';
       insert cus2;
  
       Dummay__c com2 = new Dummay__c(TicketTypes__c=tic.id,Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test123@noemail.com',First_Name__c='FName',Event__c=eve.id,Email__c='test@salesforce.com',TicketAmount__c=60,Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id);
       insert com2;
  
      SendEmailAfterReg_SucessCon pg = new SendEmailAfterReg_SucessCon();
      pg.sendemail(cus2.id);
  
  }



}