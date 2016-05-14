@istest
public without sharing class  Test_BL_Registration_Attendee
{

   static testmethod void Testmethod_Registration_Attendee(){
  
  Profile w = [select id from profile where name='Standard User'];
      
      User u = new User(alias = 'test123', email='test12345@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test12345@noemail.com');
      insert u;
  
    Event__c eve = new Event__c(EV_Title__c='Global Event',Enable_Scan_To_ATT__c=true,EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',Session_Time__c='10',OrganizerId__c='phani@globalnest.com');
      insert eve;
      Id EventId=eve.Id;
  
  Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  customProfileBooth;
   
  
  User_Profile_Event__c upe = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=u.id,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=u.id,UEP_isActive__c=true);         
  insert upe;

   AttendeeSummary__c attsum = new AttendeeSummary__c(AS_FirstName__c='phani',AS_LastName__c='Testing',AS_Email__c='boothadmin@boothleads.com');
       insert attsum ;
  
   Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attsum.Id);
       insert event_att_map ;
  
    Pay_Pal_Account__c pAcc = new Pay_Pal_Account__c(Enable_Paypal__c=true,Min_Amount_for_Paypal__c=50,Max_Amount_for_Paypal__c=500,Accept_check__c=true,Check_Address__c='Phani',check_amount_Minimum__c=0,Email_Id__c='test@globalnest.com',Event__c=eve.id,Payment_Type__c='Chained',Fee_Payer__c='EACHRECEIVER',ourEmail__c='laxman@globalnest.com');
    insert pAcc ;
  
    TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Free',Ticket_Category__c='Attendee',TT_Available__c=20,Max_Tickets_per_Order__c=5,Min_Tickets_per_Order__c=1,TT_Amount__c=0,Sales_Start_Date__c=date.valueOf('2011-01-01 09:09:09'),Sales_End_Date__c=date.valueOf('2080-01-01 09:09:09'),Avilable_for_Portal__c=true,Service_Fee__c='Include the Booth Leads fee in to the total ticket fee');
    insert tic;
  
  
    Event_Registration_jun__c eam = new Event_Registration_jun__c(Event__c=eve.id,Setting_Type__c='Collect information below for each attendee');
    insert eam;
    
    Event_Registration_jun__c erj= new Event_Registration_jun__c(Event__c=eve.id,Setting_Type__c='Collect information below for the ticket buyer only');
    insert erj;
    
    Registration_Settings__c ressetting = new Registration_Settings__c(TicketTypes__c=tic.id,EventRegistration__c=eam.id);
    insert ressetting ;
  
      
    Promocodes__c ptor = new Promocodes__c(Discount_Type__c='%',Discount_Value__c=15,Name='1234567',ExpireDate__c=Date.valueOf('2080-01-01 01:01:01'));
    insert ptor; 
   
  
     Tickets_Mapswith_Promocode__c ticmappro = new  Tickets_Mapswith_Promocode__c( Promocodes__c=ptor.id ,Tickets__c=tic.id,Max_number_Of_usage__c=100);
     insert ticmappro; 
   
   Constomer__c trinf= new Constomer__c(Customer_Name__c='c-123',Email__c='unni@gmail.com',Isinserted__c=true);
    insert trinf;
      
    Dummay__c dum= new Dummay__c(First_Name__c='unni',Last_Name__c='krishna',Email__c='unni@gmail.com',Event_Attendee_Mapping__c=event_att_map.id,TicketTypes__c=tic.id,AttendeeSummary__c=attsum.id,Event__c= eve.id,customer_key__c=trinf.id);
    insert dum; 
    
    
  
  
  Survey_Questions__c surQue = new Survey_Questions__c(Question__c='What is your name?',Type__c='Checkbox',Options__c='HiMY#hello' );
  insert surQue ;
  
  Survey__c sur = new Survey__c(Answers__c='unni',Event__c = eve.id,Survey_Questions__c=surque.id,AttendeeSummary__c=attsum.id,customer_key__c=trinf.id);
     insert sur;
  
  Ticket_Mapswith_Survey__c tmapsur = new Ticket_Mapswith_Survey__c(Survey_Questions__c=surQue.id,TicketTypes__c=tic.id);
  insert tmapsur;
    
   //NAICS_Code__c naics = new NAICS_Code__c(Name= '12345',Description__c='Telecom');
    //insert naics;
    
     PageReference pg = Page.BL_Registration_attendee;
     Test.setCurrentPage(pg); 
      ApexPages.currentPage().getParameters().put('id', eve.id);
      ApexPages.currentPage().getParameters().put('tcat', 'Attendee');
      ApexPages.currentPage().getParameters().put('call', '3');
      Apexpages.currentPage().getPArameters().put('emailvalue','unni@gmail.com');
      
       BL_Registration_AttendeeCon ticTest = new BL_Registration_AttendeeCon();
       ticTest.promocode='1234567';
       ticTest.applayPromocode1(ticTest.promocode='1234567');
       ticTest.enableInformationpopup();
       ticTest.callpayByCheck();
       ticTest.closepop() ;
       ticTest.sendMail();
       ticTest.displaypopup();
       ticTest.Pay();
       ticTest.coptyTicket();
       ticTest.DisplayTab2Values();
       ticTest.gtDetails();
       
       
      tic.TT_Amount__c=20;
      update tic;
      ticTest.applayPromocode();
      
     erj.Setting_Type__c='Collect information below for the ticket buyer only';
     update erj;
     ticTest.enableInformationpopup();
      ticTest.istestmethod = false;
      ticTest.Pay();
     ticTest.setPaymentOptions('');
     
       eam.Setting_Type__c='Collect information below for each attendee';
       update eam;
      
      ticTest.enableInformationpopup();
      ticTest.istestmethod = false;
      ticTest.Pay();
     ticTest.setPaymentOptions('');
     
    /*  eam.Setting_Type__c='Collect information below for each attendee';
       update eam;
      ticTest.enableInformationpopup();
      ticTest.istestmethod = false;
      ticTest.Pay();
     ticTest.setPaymentOptions('');*/
      
   }
 }