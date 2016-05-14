@istest

public class Test_BL_TicketTypesCon
{
  static testmethod void Testmethod_BL_TicketTypesCon()
  {
  
  
 contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u = new User(alias = 'tems', email='temst123@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='temst123@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  EventAdminProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
      
     
     User_Profile_Event__c upebooth = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true);         
      insert upebooth; 

PageReference pageRef = Page.BL_TicketTypes;
Test.setCurrentPage(pageRef);

system.runAs(u){


BL_TicketTypesCon ticket= new BL_TicketTypesCon();
system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$'+EventId);
Blob b ;
ApexPages.currentPage().getParameters().put('event', EventId);
ticket.SelectedEvent = ApexPages.currentPage().getParameters().put('event', EventId);
ticket.getTicketTypeValues();
ticket.getTicketcategoryValues();
ticket.getTicketServiceFee();
ticket.getAccountTypeValues();
ticket.TicketTypes.TT_TicketType__c = 'Free';
ticket.ForSelectedTicketTypes();
ticket.TicketTypes.TT_TicketType__c = 'Paid';
ticket.ForSelectedTicketTypes();
ticket.AddTicket();
ticket.cancel();
ticket.Paymentsdiv();
ticket.PayPalAccount.Account_types__c = 'PayPal Account';
ticket.SavePaypal();
ticket.Cancelpopup();
ticket.TicketTypes = new TicketTypes__c();
ticket.TicketTypes.TT_Name__c = 'FullConf';
ticket.TicketTypes.EV_id__c = ticket.SelectedEvent ;
ticket.TicketTypes.TT_Sold__c = 0;
ticket.TicketTypes.TT_TicketType__c = 'Free';
Database.upsert(ticket.TicketTypes); 
ticket.save();
ticket.TicketTypeID = ticket.TicketTypes.id;
ticket.EditTicket();
ticket.TicketDetails();
ticket.DeleteTicket();
ticket.TicketList();
ticket.Paymentsett();


ticket.Accountype = ApexPages.currentPage().getParameters().put('AccountTypes',ticket.PayPalAccount.Account_types__c);

if(ticket.Accountype  == 'PayPal Account'){
ticket.PayPalAccountre = False;
ticket.DotNetre = True;
}
ticket.SelectedAccounttype();

ticket.PayPalAccount.Account_types__c = 'Authorize.Net';

ticket.Accountype = ApexPages.currentPage().getParameters().put('AccountTypes',ticket.PayPalAccount.Account_types__c);

if(ticket.Accountype  == 'Authorize.Net') {
ticket.PayPalAccountre = True;
ticket.DotNetre = False;
}
ticket.SelectedAccounttype();
}
}
}