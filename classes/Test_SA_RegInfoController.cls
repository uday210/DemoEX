@istest(SeeAllData= true)

public class Test_SA_RegInfoController
{
  static testmethod void Testmethod_SA_RegInfoController(){
 
  contact con = new contact(firstname='reg',lastname='info');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
      
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'reg', email='reginfo@gmail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='info', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='reginfo@gmail.com');
                  insert u;
                  Id eventAdminId=u.id;   
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='4.5');       
       insert  EventAdminProfile;
      
      Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',Fee_Type__c = 'Charge the fee to the customer',
                             EV_HostingCountryNew__c='United States of America',
                             EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones');
      insert eve;
      Id EventId=eve.Id;
     
      App_Settings__c apse = new App_Settings__c();
      apse.Fee__c = 10;
      apse.User_Type__c = 'ScanAttendee User';
      insert apse ;
     
     
      TicketTypes__c TT1= new TicketTypes__c();
     
      TT1.TT_Name__c='Tuesday Only Registration(Sponsor)';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Free';
      TT1.Ticket_Category__c='MBE';
      TT1.TT_Available__c =100;
       TT1.TT_Sold__c =0;
     TT1.TT_Amount__c =0;

      insert TT1;
      
       TicketTypes__c TT2= new TicketTypes__c();
     
      TT2.TT_Name__c='Wednesday Only Registration(Sponsor)';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Free';
      TT2.Ticket_Category__c='MBE';
      TT2.TT_Available__c =100;
       TT2.TT_Sold__c =0;
     TT2.TT_Amount__c =0;

      insert TT2;

     TicketTypes__c TT3= new TicketTypes__c();
     
      TT3.TT_Name__c='2 Day Registration(Sponsor)';
      TT3.EV_id__c=eve.Id;
      TT3.TT_TicketType__c='Free';
      TT3.Ticket_Category__c='MBE';
      TT3.TT_Available__c =100;
       TT3.TT_Sold__c =0;
     TT3.TT_Amount__c =0;

      insert TT3;

     
     
      AttendeeSummary__c  att2= new AttendeeSummary__c ();
      att2.AS_FirstName__c='reg';
      att2.AS_LastName__c='info';
      att2.AS_Email__c='reg@gmail.com';
     
      insert att2;
     
      AttendeeSummary__c  att3= new AttendeeSummary__c ();
      att3.AS_FirstName__c='reg';
      att3.AS_LastName__c='info';
      att3.AS_Email__c='reg3@gmail.com';
     
      insert att3;
     
      AttendeeSummary__c  att4= new AttendeeSummary__c ();
      att4.AS_FirstName__c='reg';
      att4.AS_LastName__c='info';
      att4.AS_Email__c='reg4@gmail.com';
     
      insert att4;
     
     
      Event_Attendee_Mapping__c eam2= new Event_Attendee_Mapping__c();
      eam2.AS_id__c= att2.id;
      eam2.Boothleads_Profile__c= 'Attendee';
      eam2.EV_id__c= eve.id;
      eam2.IsBoothLeadsAttendee__c= TRUE;
      eam2.TicketTypesBP__c= 'Tuesday Only Registration';
      insert eam2;                               
     
      Event_Attendee_Mapping__c eam3= new Event_Attendee_Mapping__c();
      eam3.AS_id__c= att3.id;
      eam3.Boothleads_Profile__c= 'Attendee';
      eam3.EV_id__c= eve.id;
      eam3.IsBoothLeadsAttendee__c= TRUE;
      eam3.TicketTypesBP__c= 'Wednesday Only Registration';
      insert eam3;                               
     
      Event_Attendee_Mapping__c eam4= new Event_Attendee_Mapping__c();
      eam4.AS_id__c= att4.id;
      eam4.Boothleads_Profile__c= 'Attendee';
      eam4.EV_id__c= eve.id;
      eam4.IsBoothLeadsAttendee__c= TRUE;
      eam4.TicketTypesBP__c= '2 Day Registration';
      insert eam4;                               
     
      system.runas(u){
   
     ApexPages.CurrentPage().getParameters().put('Id',eve.id); 
   
     SA_RegInfoController reginfo= new SA_RegInfoController();
     ApexPages.CurrentPage().getParameters().put('EAMId',eam2.id); 
     ApexPages.CurrentPage().getParameters().put('TicketName','Tuesday Only Registration'); 
          
     reginfo.createRegInfo();
     ApexPages.CurrentPage().getParameters().put('EAMId',eam3.id); 
     ApexPages.CurrentPage().getParameters().put('TicketName','Wednesday Only Registration'); 
          
     reginfo.createRegInfo();
     ApexPages.CurrentPage().getParameters().put('EAMId',eam4.id); 
     ApexPages.CurrentPage().getParameters().put('TicketName','2 Day Registration'); 
          
     reginfo.createRegInfo();

     
    }               
   
      
   }
}