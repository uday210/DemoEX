@istest
public class Test_BL_Registration_Attendee_StripeCon{
  static testmethod void unittest(){
    
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

  
  
  
    Pay_Pal_Account__c pAcc = new Pay_Pal_Account__c(Accept_check__c=true,Check_Address__c='Phani',check_amount_Minimum__c=0,Email_Id__c='test@globalnest.com',Event__c=eve.id,Payment_Type__c='Chained',Fee_Payer__c='EACHRECEIVER',ourEmail__c='laxman@globalnest.com');
    insert pAcc ;
  
    TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Free',Ticket_Category__c='Attendee',TT_Available__c=20,Max_Tickets_per_Order__c=5,Min_Tickets_per_Order__c=1,TT_Amount__c=0,Sales_Start_Date__c=date.valueOf('2011-01-01 09:09:09'),Sales_End_Date__c=date.valueOf('2080-01-01 09:09:09'),Avilable_for_Portal__c=true,Service_Fee__c='Include the Booth Leads fee in to the total ticket fee');
    insert tic;
  
  
    Event_Registration_jun__c eam = new Event_Registration_jun__c(Event__c=eve.id,Setting_Type__c='Collect information below for each attendee');
    insert eam;
    
    Registration_Settings__c ressetting = new Registration_Settings__c(TicketTypes__c=tic.id,EventRegistration__c=eam.id);
    insert ressetting ;
  
      
    Promocodes__c ptor = new Promocodes__c(Discount_Type__c='%',Discount_Value__c=15,Name='1234567',ExpireDate__c=Date.valueOf('2080-01-01 01:01:01'));
    insert ptor; 
   
  
     Tickets_Mapswith_Promocode__c ticmappro = new  Tickets_Mapswith_Promocode__c( Promocodes__c=ptor.id ,Tickets__c=tic.id,Max_number_Of_usage__c=100);
     insert ticmappro; 
  
  
  Survey_Questions__c surQue = new Survey_Questions__c(Question__c='What is your name?',Type__c='Checkbox',Options__c='HiMY#hello' );
  insert surQue ;
  
  Ticket_Mapswith_Survey__c tmapsur = new Ticket_Mapswith_Survey__c(Survey_Questions__c=surQue.id,TicketTypes__c=tic.id);
  insert tmapsur;
    
    
     PageReference pg = Page.BL_Registration_attendee;
     Test.setCurrentPage(pg); 
      ApexPages.currentPage().getParameters().put('id', eve.id);
      ApexPages.currentPage().getParameters().put('tcat', 'Attendee');
      
      BL_Registration_Attendee_StripeCon ticTest = new BL_Registration_Attendee_StripeCon();
       ticTest.promocode='1234567';
       ticTest.enableInformationpopup();
       ticTest.DisplayTab2Values();
       ticTest.applayPromocode();
       ticTest.callpayByCheck();
       ticTest.closepop() ;
       ticTest.sendMail();
       ticTest.displaypopup();
       ticTest.Pay();
       ticTest.dummy1();
       ticTest.dummy2();
      
     
      
   }
}