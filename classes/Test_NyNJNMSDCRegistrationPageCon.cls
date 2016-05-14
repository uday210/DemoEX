@istest
public class Test_NyNJNMSDCRegistrationPageCon
{

  static testmethod void Testmethod_BL_BoothPersonnelsCon()
  {
  
  Event__c eve = new Event__c(EV_Title__c='TestEvent');
  insert eve;
  
  TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  TicketTypes__c tic2 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Diamond',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic2;
  
  
   TicketTypes__c tic3 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Platinum',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic3;
  
  
   TicketTypes__c tic4 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Gold',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic4;
  
  
   TicketTypes__c tic5 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Tuesday Breakfast',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic5;
  
  
   TicketTypes__c tic6 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Tuesday Lunch',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic6;
  
  
   TicketTypes__c tic7 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Shining Star Reception',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic7;
  
     TicketTypes__c tic8 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Wednesday Breakfast',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic8;
    
     TicketTypes__c tic9 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Wednesday Lunch',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic9;
    
     TicketTypes__c tic10 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Booth at Expo',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic10;
  
  
   TicketTypes__c tic11 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Additional Booth',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic11;
  
  Pay_Pal_Account__c pAcc = new Pay_Pal_Account__c(Email_Id__c='test@globalnest.com',Event__c=eve.id,Payment_Type__c='Chained',Fee_Payer__c='EACHRECEIVER');
  insert pAcc ;
   List<selectOption> opt= new List<selectOption>();
  
  
    NyNJNMSDCRegistrationPageCon nynjcon = new NyNJNMSDCRegistrationPageCon();
    PageReference pg = Page.BL_Registration;
    Test.setCurrentPage(pg); 
     ApexPages.currentPage().getParameters().put('id', eve.id);
     nynjcon.getItems();
     ApexPages.currentPage().getParameters().put('pid', '');
     nynjcon.cancelTickets();
     nynjcon.selectedEvent =eve.id;
      nynjcon.userType='MSDC Member Corporation';
      nynjcon.DisplayTab2Values(); 
      nynjcon.previous1(); 
      nynjcon.previous2(); 
      nynjcon.previous3(); 
      nynjcon.enabletab4();
      nynjcon.enabletab3();
      nynjcon.enabletab2();
    
      NyNJNMSDCRegistrationPageCon.innerClass  inc = new NyNJNMSDCRegistrationPageCon.innerClass(tic,opt);
      inc.tt =tic;
      inc.quantity =1;
      nynjcon.inn.add(inc);
      nynjcon.enabletab1();
      nynjcon.onchangeAct();
      
        nynjcon.getistab0disabled();
        nynjcon.getistab1disabled();
        nynjcon.getistab2disabled();
        nynjcon.getistab3disabled();
        nynjcon.getistab4disabled();
        nynjcon.getselectedtab();
        nynjcon.paymenttypeIteam='Invoice'; 
        nynjcon.displaycheckNo();
        
        nynjcon.invoiceEmail ='test@gmail.com';
         nynjcon.Pay();
        nynjcon.testdum(); 
  }
 }