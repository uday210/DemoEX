@istest
public class Test_BL_Special_Needs_Expos_Con
{

  static testmethod void Testmethod_BL_BoothPersonnelsCon()
  {
  
    Event__c eve = new Event__c(EV_Title__c='TestEvent',EV_HostingStateNew__c='New Jersey');
  insert eve;
  
   
   Pay_Pal_Account__c pAcc = new Pay_Pal_Account__c(Accept_check__c=true,Check_Address__c='Phani',check_amount_Minimum__c=0,Email_Id__c='test@globalnest.com',Event__c=eve.id,Payment_Type__c='Chained',Fee_Payer__c='EACHRECEIVER',ourEmail__c='laxman@globalnest.com');
  insert pAcc ;
  
 
  
  TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  TicketTypes__c tic2 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='Diamond',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500);
  insert tic2;
  
    
  Promocodes__c ptor = new Promocodes__c(Discount_Type__c='%',Discount_Value__c=15,Name='1234567');
  insert ptor; 
   
  
  Tickets_Mapswith_Promocode__c ticmappro = new  Tickets_Mapswith_Promocode__c( Promocodes__c=ptor.id ,Tickets__c=tic2.id);
  insert ticmappro; 
  
  
  Survey_Questions__c surQue = new Survey_Questions__c(Question__c='What is your name?',Type__c='Checkbox',Options__c='HiMY#hello' );
  insert surQue ;
  
  Ticket_Mapswith_Survey__c tmapsur = new Ticket_Mapswith_Survey__c(Survey_Questions__c=surQue.id,TicketTypes__c=tic2.id);
  insert tmapsur;
  
  
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
  
  
  
   
   
 
  /* PPAPICredential__c apicredit = new PPAPICredential__c();
  apicredit.Name='SandboxCert';
  apicredit.ApplicationID__c ='APP-80W284485P519543T';
  apicredit.APIUserName__c ='laxman_api1.globalnest.com';
  apicredit.APIUserpassword__c ='1367821778';
  apicredit.APIProfile__c ='3_TOKEN';
   apicredit.Environment__c ='Sandbox';
   apicredit.APISignature__c ='A7EBmp3YAffU74zdPkXxuzDRZFC9A4yWrpkqoW1vC86mpXUAqelE99Jq';
  
  insert apicredit;
  
  
  PPCommonRequestParameters__c ppcom = new PPCommonRequestParameters__c();
  ppcom.Name ='MyRequestParams';
  ppcom.ApplicationName__c='Boothleads';
  ppcom.CurrencyCode__c='USD';
  ppcom.DetailLevel__c='ReturnAll';
  ppcom.FeePayer__c='SENDER';
   ppcom.Language__c='en_US';
   insert ppcom;
   */
   
   List<selectOption> opt= new List<selectOption>();
  
  
    BL_Special_Needs_Expos_Con nynjcon = new BL_Special_Needs_Expos_Con();
    
    PageReference pg = Page.BL_Special_Needs_Expos;
    Test.setCurrentPage(pg); 
     ApexPages.currentPage().getParameters().put('id', eve.id);
    
     ApexPages.currentPage().getParameters().put('pid', '');
     nynjcon.selectedEvent =eve.id;
     nynjcon.DisplayTab2Values(); 
         
      BL_Special_Needs_Expos_Con.innerClass  inc = new BL_Special_Needs_Expos_Con.innerClass(tic,opt);
      inc.tt =tic;
      inc.quantity =1;
      nynjcon.inn.add(inc);
      nynjcon.enabletab1();
      nynjcon.onchangeAct();
      nynjcon.promocode = '1234567';
       nynjcon.applayPromocode();
       
       nynjcon.eventAdminAmount=0 ;
       nynjcon.boothleadsAmount=0;
      nynjcon.Pay();
       
      // nynjcon.istestMethod =false;
      // nynjcon.eventAdminAmount=20 ;
      // nynjcon.boothleadsAmount=10;
     // nynjcon.Pay();
       nynjcon.testdum();
        nynjcon.testdum1();
       nynjcon.testdum2();
         nynjcon.testdum3();
         }
 }