@istest(SeeAllData= true)

public class Test_SA_AddUsersController{
  static testmethod void Testmethod_SA_AddUsersController(){
  
  Account acc = new Account(Name ='Scan Attendee');
  insert acc; 
  
  AttendeeSummary__c AttendeeForEventAdminStaff= new AttendeeSummary__c(AS_FirstName__c='neehl', AS_LastName__c='Reddy', AS_Email__c = 'neehl@global.com', AS_Company__c= 'Globalnest', 
                                         AS_Title__c = 'Miss', AS_CellPhone__c = '90000000000' );
  insert AttendeeForEventAdminStaff; 
  
  
 contact con = new contact(AccountID =acc.Id ,Firstname =AttendeeForEventAdminStaff.AS_FirstName__c,Lastname =AttendeeForEventAdminStaff.AS_LastName__c,Email_Notes__c = 'test' ,Email_Subject__c = 'subject');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u = new User(alias = 'sa', email='samanasa@sa.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='manasa', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',password__c = 'Tetste12',
                  timezonesidkey='America/Los_Angeles', username='testi789@global.com',ScanAttendee_User__c = TRUE);
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminStaffProfile= new Profile__c (PR_Name__c='EventAdmin Staff',PR_Version__c='4.0');        
       insert  EventAdminStaffProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones');
      insert eve;
      Id EventId=eve.Id;
      
      TicketTypes__c TT1= new TicketTypes__c();
      
      TT1.TT_Name__c=' ticket type1';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Free';
      TT1.Ticket_Category__c='Non – Attendee';
      insert TT1;

      TicketTypes__c TT2= new TicketTypes__c();
      
      TT2.TT_Name__c=' Attendee Staff';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Free';
      TT2.Ticket_Category__c='Non – Attendee';
      insert TT2;
      
      AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_Email__c='gky@global.com';
      att.AS_FirstName__c='gky';
      att.AS_LastName__c='rao';
      
      insert att;
      
      Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c= att.id;
      eam.Boothleads_Profile__c= 'Attendee';
      eam.EV_id__c= eve.id;
      eam.IsBoothLeadsAttendee__c= TRUE;
      insert eam;
      
      
      User_Profile_Event__c upe= new User_Profile_Event__c();
      
      upe.Attendee_Summary__c= att.id;
      upe.EV_id__c= eve.id;
      upe.EventAdmin_Id__c = UserInfo.getUserId();
      upe.UEP_isActive__c= TRUE;
      upe.Profile_id__c=EventAdminStaffProfile.Id;
      upe.User_id__c= U.Id;
      
      insert upe;
                 
      Cookie  counter = new Cookie('counter',eve.id,null,-1,false);
      ApexPages.currentPage().setCookies(new Cookie[]{counter});
       system.runas(u){
      SA_AddUsersController eventadminstaff= new SA_AddUsersController();
      
      eventadminstaff.addEventStaff();
      Test.startTest();
      eventadminstaff.AttendeeForEventAdminStaff.AS_FirstName__c='Manasa';
      eventadminstaff.AttendeeForEventAdminStaff.AS_LastName__c='g';
      eventadminstaff.AttendeeForEventAdminStaff.AS_Email__c='eventstaff@gmail.com';
      eventadminstaff.AttendeeForEventAdminStaff.AS_CellPhone__c= '98567456342';
      eventadminstaff.password= 'global123';
      eventadminstaff.saveEventAdminStaff();
        
      eventadminstaff.SelectedUserEditId= upe.id;
      eventadminstaff.editEventStaff();
      eventadminstaff.saveEventAdminStaff();
      
      eventadminstaff.SelectedUserDeleteId= upe.id; 
      eventadminstaff.deleteUser(); 
      
      /*
          eventadminstaff.SelectedUserEditId= '';
          eventadminstaff.userForEventAdminStaff.LastName='Manasa';
          eventadminstaff.userForEventAdminStaff.firstname='g';
          eventadminstaff.userForEventAdminStaff.UserName='eventstaff@gmail.com';
          eventadminstaff.userForEventAdminStaff.phone= '98567456342';
          eventadminstaff.saveEventAdminStaff();
          eventadminstaff.saveEam();
          eventadminstaff.checkUserId() ;
          eventadminstaff.cancelStaff();
      */
      
      eventadminstaff.AttendeeForEventAdminStaff.AS_FirstName__c='jhansi';
      eventadminstaff.AttendeeForEventAdminStaff.AS_LastName__c='gandham';
      eventadminstaff.AttendeeForEventAdminStaff.AS_Email__c='jhansistaff@gmail.com';
      eventadminstaff.AttendeeForEventAdminStaff.AS_CellPhone__c= '9876786543';
      eventadminstaff.password= 'global456';
      eventadminstaff.saveEventAdminStaff();
      
      eventadminstaff.checkUserId();
Test.stopTest();
      }   
      }
      
      }