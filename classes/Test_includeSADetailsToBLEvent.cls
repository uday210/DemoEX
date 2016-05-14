@istest(SeeAllData= true)

public class Test_includeSADetailsToBLEvent
{
  static testmethod void Testmethod_includeSADetailsToBLEvent(){
 
  contact con= new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
      
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'tic', email='manasatic@gmail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='include', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='manasatic@gmail.com');
                  insert u;
                  Id eventAdminId=u.id;   
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');       
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
      
      AttendeeSummary__c  att2= new AttendeeSummary__c ();
      att2.AS_FirstName__c='manu';
      att2.AS_LastName__c='include';
      att2.AS_Email__c='manasatic@gmail.com';
     
      insert att2;
      
      Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c= att2.id;
      eam.Boothleads_Profile__c= 'Attendee';
      eam.EV_id__c= eve.id;
      eam.IsBoothLeadsAttendee__c= TRUE;
      insert eam;
      
      AttendeeSummary__c  att3= new AttendeeSummary__c ();
      att3.AS_FirstName__c='ishu';
      att3.AS_LastName__c='gandham';
      att3.AS_Email__c='ishu@gmail.com';
     
      insert att3;
      
      Event_Attendee_Mapping__c eam3= new Event_Attendee_Mapping__c();
      eam3.AS_id__c= att3.id;
      eam3.Boothleads_Profile__c= 'Attendee';
      eam3.EV_id__c= eve.id;
      eam3.IsBoothLeadsAttendee__c= TRUE;
      insert eam3;
     
     
      includeSADetailsToBLEvent includeTickets= new includeSADetailsToBLEvent();
      includeTickets.insertTicketsForEvent(eventAdminId, EventId);
      includeTickets.insertGuestToAttendee(EventId);
      includeTickets.deleteEvent(EventId);
      
      }
      
      }