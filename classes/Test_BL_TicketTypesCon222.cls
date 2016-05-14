@istest

public class Test_BL_TicketTypesCon222
{
  static testmethod void Testmethod_BL_TicketTypesCon()
  {
  
  contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u = new User(alias = 'test1236', email='test1236@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test1236@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  EventAdminProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             Attendee_Types__c='Attendee;Exhibitor');
      insert eve;
      Id EventId=eve.Id;
      
     
     User_Profile_Event__c upebooth = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true);         
      insert upebooth; 
      
      TicketTypes__c tic = new TicketTypes__c(TT_Name__c='Test Tic', TT_TicketType__c='Free',TT_Amount__c=50,  TT_Available__c=1000,EV_id__c=eve.id,User_Type__c='Attendee');
       insert tic;
       TicketTypes__c tic2 = new TicketTypes__c(TT_Name__c='Test Tic', TT_TicketType__c='Free',TT_Amount__c=50,   TT_Available__c=1000,EV_id__c=eve.id,User_Type__c='Exhibitor'); 
       insert tic2;
      
      Pay_Pal_Account__c paypalAcc1 = new Pay_Pal_Account__c(Email_Id__c='laxman@globalnest.com',Event__c =eve.id,Account_Types__c = 'PayPal Account');
      insert paypalAcc1;
      
      
        Pay_Pal_Account__c paypalAcc2 = new Pay_Pal_Account__c(Email_Id__c='laxman@globalnest.com',Event__c =eve.id,Account_Types__c = 'Authorize.Net');
      insert paypalAcc2;
      Survey_Questions__c sur = new Survey_Questions__c(Question__c = 'what is your name?',order__c= 2);
      insert sur;
      Promocodes__c prom = new Promocodes__c(Discount_Type__c='%',Discount_Value__c = 50,Name = 'OFF50%' );
      insert prom;
      Ticket_Mapswith_Survey__c ticsur = new Ticket_Mapswith_Survey__c(TicketTypes__c = tic.id,Survey_Questions__c=sur.id,Order__c=2 );
      insert ticsur;
      Tickets_Mapswith_Promocode__c tprom = new Tickets_Mapswith_Promocode__c(Tickets__c=tic.id,Promocodes__c=prom.id);
      insert tprom;
      
   PageReference pageRef = Page.BL_Event_TicketTypes;
    Test.setCurrentPage(pageRef);
 
system.runAs(u){
 ApexPages.currentPage().getParameters().put('event', eve.id);
  BL_Event_TicketTypesCon bb = new BL_Event_TicketTypesCon();
 
 ApexPages.currentPage().getParameters().put('upPhani', tic.id);
   bb.up();
  
  bb.down(); 
  
  bb.getValues();
  bb.getTicketTypeValues();
  bb.getTicketServiceFee();
  bb.ForSelectedTicketTypes();
  bb.getAccountTypeValues();
  bb.TicketTypeID=tic.id;
  bb.EditTicket();
  bb.SelectedEvent=eve.id;
   bb.save();
  bb.AddTicket();
 bb.TicketTypes.TT_Name__c ='tic123';
 bb.TicketTypes.Ticket_Category__c ='Paid';
 
 Blob b = blob.valueOf('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
 bb.TicketImage = b;
 bb.TicketFileName ='nikolas';
 
  bb.save();
  bb.cancel();
  bb.TicketDetails();
  bb.TicketsDiv();
  bb.Paymentsdiv();
   bb.SavePaypal();
  bb.paypalAccount.Account_Types__c = 'PayPal Account';
  bb.paypalAccount.PuserName__c ='phani@globalnest.com';
  bb.SavePaypal();
  
    bb.paypalAccount.Account_Types__c = 'Authorize.Net';
     bb.SavePaypal();
    bb.TocheckPaypalAccount();
    bb.Cancelpopup();
    bb.ShowMEthod();
    bb.TicketList();
    bb.Paymentsett();
    ApexPages.currentPage().getParameters().put('AccountTypes','Authorize.Net');
    bb.SelectedAccounttype();
    bb.SaveReg();
    bb.DeleteTicket();
  //  bb.Deleterec();
      bb.dummyMeth();
      //bb.cloneId = tic.id;
      //bb.cloneTicket();
      //bb.saveCloneTicket();
 } 
  }
  
  
}