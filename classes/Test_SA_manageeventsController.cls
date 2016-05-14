@istest(SeeAllData= true)

public class Test_SA_manageeventsController{
  static testmethod void Testmethod_SA_manageeventsController(){

  
 contact con = new contact(firstname='gandham',lastname='manasa');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u = new User(alias = 'sa', email='samanasa@sa.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='manasa', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States', 
                  timezonesidkey='America/Los_Angeles', username='samuel+123@gmail.com',ScanAttendee_User__c = TRUE);
                  insert u;


                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='4.0');        
       insert  EventAdminProfile;

   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',isActive__c = true,
                             EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones');
      insert eve;
      Id EventId=eve.Id;
      
     
      
      
      
      TicketTypes__c TT1= new TicketTypes__c();
      
      TT1.TT_Name__c=' ticket type1';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Free';
      TT1.Ticket_Category__c='Non – Attendee';
      TT1.TT_Available__c= 1;
      TT1.TT_Sold__c= 0;
      insert TT1;

      TicketTypes__c TT2= new TicketTypes__c();
      
      TT2.TT_Name__c=' ticket type2';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Free';
      TT2.TT_Available__c= 1;
      TT2.TT_Sold__c= 0;
      TT2.Ticket_Category__c='Non – Attendee';
      insert TT2;
      
      TicketTypes__c TT3= new TicketTypes__c();
      
      TT3.TT_Name__c=' Guest ';
      TT3.EV_id__c=eve.Id;
      TT3.TT_TicketType__c='Free';
      TT3.TT_Available__c= 1;
      TT3.TT_Sold__c= 0;
      TT3.Ticket_Category__c='Non – Attendee';
      insert TT3;
      
     
      
      AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_Email__c='durga_RJ@boothleads.com';
      att.AS_FirstName__c='cpk';
      att.AS_LastName__c='lname';
      
      insert att;
      
      AttendeeSummary__c  att1= new AttendeeSummary__c ();
      att1.AS_Email__c='samuel+123@gmail.com';
      att1.AS_FirstName__c='cpkk';
      att1.AS_LastName__c='lnname';
      
      insert att1;
      
      Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c= att.id;
      eam.Boothleads_Profile__c= 'Attendee';
      eam.EV_id__c= eve.id;
      eam.IsBoothLeadsAttendee__c= TRUE;
      eam.IsCancelled__c = FALSE;
      insert eam;
      
      Constomer__c trans= new Constomer__c();
      trans.Email__c= 'manasa@gmail.com';
      trans.Ticket_Types__c= TT1.Id;
      trans.Total_Amount__c=4500;
      insert trans;
      
      Dummay__c regInfo= new Dummay__c();
      regInfo.Event__c= eve.id;
      regInfo.Event_Attendee_Mapping__c= eam.Id;
      regInfo.First_Name__c= 'manu';
      regInfo.Last_Name__c= 'Sa';
      regInfo.Email__c= 'manu@gmail.com';
      regInfo.customer_key__c= trans.Id;
      regInfo.TicketTypes__c= TT1.Id;
      regInfo.TicketAmount__c= 1000;
      regInfo.Tickets_Quantty__c= 22;
      regInfo.Item_Quantity__c= 30;

      insert regInfo;
      
      User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA; 
      
      User_Profile_Event__c UPEData= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true);         
      insert UPEData; 

      MatchLeads_Days__c Daysl=  new MatchLeads_Days__c(Event__c =EventId ,MatchLeads_Date__c = system.today(),End_Time__c='06:00 PM',Start_time__c='09:00 AM',Session_Name__c = 'aaa');
       insert Daysl; 
      
      system.runas(u){
      ApexPages.StandardController controller= new ApexPages.StandardController(eve); 
      SA_manageeventsController eventsCon= new SA_manageeventsController(controller);
      
      eventsCon.LogoName='Unit Test Attachment';
      eventsCon.Logo=Blob.valueOf('Unit Test Attachment Body');
      ApexPages.currentPage().getParameters().put('EventName', eve.Id);
      eventsCon.ShowEventDetails();
      eventsCon.EventId();      
      eventsCon.Cancel();      
      eventsCon.CreateEvent();
      eventsCon.EventDetails[0]= eve;
      eventsCon.SaveEvent();      
      eventsCon.ManageEvent();
      eventsCon.DeleteEvent();
      eventsCon.previous();
      ApexPages.currentPage().getParameters().put('index', '0');
     
      eventsCon.DeleteSessions();
      eventsCon.addingMultipleSessions();
      eventsCon.getistab1disabled();
      eventsCon.getselectedtab();
      eventsCon.getistab2disabled();
      eventsCon.getistab3disabled();
      eventsCon.enableSessionsTab(eve.Id);
      eventsCon.SaveSessions();
      eventsCon.previousSessions();
      eventsCon.InsertTicketsToEvent();
      eventsCon.saveSalesTax();
      eventsCon.checkUserId() ;
      }
      
      }
      }