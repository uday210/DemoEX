@istest(SeeAllData= true)

public class Test_SA_ImportAttendeesController{
    
    static testmethod void Testmethod_SA_ImportAttendeesController(){
        contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
       
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'test123', email='test123111@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123111@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  EventAdminProfile;
       
      Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones');
      insert eve;
      Id EventId=eve.Id;     
        
        TicketTypes__c TT1= new TicketTypes__c();
      
      TT1.TT_Name__c='Full Conference';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Free';
      TT1.Ticket_Category__c='Non – Attendee';
      TT1.TT_Available__c =100;
      TT1.TT_Amount__c =0;
      insert TT1;
      
      TicketTypes__c TT2= new TicketTypes__c();
      
      TT2.TT_Name__c='VIP Pass';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Donation';
      TT2.Ticket_Category__c='Non – Attendee';
            TT2.TT_Available__c =100;
              TT2.TT_Amount__c =10;
      insert TT2;
      
   
      
      
     AttendeeSummary__c  att1= new AttendeeSummary__c ();
      att1.AS_FirstName__c='avanthi';
      att1.AS_LastName__c='k';
      att1.AS_Email__c='manuimport@gmail.com';
      
      insert att1;
      

     
      
       Event_Attendee_Mapping__c eam1= new Event_Attendee_Mapping__c();
      eam1.AS_id__c= att1.id;
      eam1.Boothleads_Profile__c= 'Attendee';
      eam1.EV_id__c= eve.id;
      eam1.IsBoothLeadsAttendee__c= TRUE;
      insert eam1;
      
       Constomer__c trans= new Constomer__c();
      trans.Email__c= 'manasa@gmail.com';
      trans.Ticket_Types__c= TT1.Id;
      trans.Total_Amount__c=4500;
      insert trans;
      
      Dummay__c regInfo1= new Dummay__c();
      regInfo1.Event__c= eve.id;
     // regInfo1.Event_Attendee_Mapping__c= eam.Id;
      regInfo1.First_Name__c= 'manu';
      regInfo1.Last_Name__c= 'Sa';
      regInfo1.Email__c= 'manu111@gmail.com';
      regInfo1.customer_key__c= trans.Id;
      regInfo1.TicketTypes__c= TT1.Id;
      regInfo1.TicketAmount__c= 1000;
      regInfo1.Tickets_Quantty__c= 22;
      regInfo1.Item_Quantity__c= 30;
      regInfo1.Payment_Type__c= 'Cash';
                          
      insert regInfo1;
       
       
       
       
     AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_FirstName__c='cpk1';
      att.AS_LastName__c='lname1';
      att.AS_Email__c='manasa1@gmail.com';
      
      insert att;
      
       Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c= att.id;
      eam.Boothleads_Profile__c= 'Attendee';
      eam.EV_id__c= eve.id;
      eam.IsBoothLeadsAttendee__c= TRUE;
      insert eam;
      
      regInfo1.Event_Attendee_Mapping__c= eam.Id;
       upsert regInfo1;
       
      Individual_Ticket_Info__c ind1= new Individual_Ticket_Info__c();
      ind1.Event_Attendee_Mapping__c=eam.id;
      ind1.IsCheckedIn__c= FALSE;
      ind1.Is_Primary__c= FALSE;
      ind1.Registration_Info__c= regInfo1.Id;
      ind1.Scanned_by__c= UserInfo.getUserId();
      ind1.Seat__c= 'SEAT-0001';
      ind1.Is_Input__c =TRUE ;
      ind1.IsCancelled__c = FALSE ;
      ind1.IsItem__c = FALSE;
      insert ind1;
      
                           
     cookie  counter = new Cookie('counter',eve.id,null,-1,false);
     ApexPages.currentPage().setCookies(new Cookie[]{counter});
    system.runas(u){    
    SA_ImportAttendeesController importAttendees= new SA_ImportAttendeesController();
     
     string AttendeeFields= 'AS_FirstName__c, AS_LastName__c, AS_Email__c,AS_WorkPhone__c,AS_Company__c,AS_WorkAddress1__c,AS_Work_City__c,AS_Work_States__c,AS_WorkZip__c,AS_Title__c,GuestType__c,TT_Name__c,TT_Amount__c,TT_Available__c,Payment_Status__c,Tickets_Quantty__c,Payment_Type__c,Seat_Number__c';
     //importTickets.dataFromJavaScript= String.valueOf('Ticket Name,Ticket Price,Quantity,Ticket Type(Paid;Free;Donation) \r ticket1, 150.00, 50, Paid????:::::******&&&&&&%%%%;;;;'); 
     importAttendees.importedFile= blob.valueOf('First Name,Last Name,Email Id,Phone,Company,Job Title,Attendee Category,Address,City,State,Zip Code,Ticket Name,Ticket Price,Ticket Quantity,Payment Status,Sold Quantity,Payment Type,Seat Numbers'); 
   ApexPages.currentPage().getparameters().put('one','First Name,Last Name,Email Id,Phone,Company,job title,Address,City,State,Zip Code,attendee category,Ticket Name,Ticket Price,Ticket Quantity,Payment Status,Sold Quantity,Payment Type,Seat Numbersaazz11ttt222gggcpk1,lname1,manasa123456@gmail.com,8978456789,Acme Corp,hr,105 Vanderbilt Ave.,Central Islip,NY,11722,attendee,Half Conference,100,250,not paid,2,Credit Card,"A1,B1"aazz11ttt222gggavanthi,gone,sruthi12345@gmail.com,8934456789,Acm Corp,hr,105 Vanderbilt Ave.,Central Islip,NY,11722,attendee,Attendee Pass,100,250,not paid,2,Credit Card,"A1,B1"aazz11ttt222gggavanthi,k,"manu12321@gmail.com",8897845698,Globalnest",","127 West 135 Street,New York,NY,10030,attendee,VIP Pass,2500,500,not paid,3,Check,"B2,C3"aazz11ttt222ggg????:::::******&&&&&&%%%%;;;;Attendees1Sample134.csv');
     importAttendees.showAttendeeMapping();
     importAttendees.selectedEventId=eve.id;
     //importAttendees.SelectedTicketName='Test Ticket';
     importAttendees.importAttendeeValues();
     
     importAttendees.closeAttendee();
     importAttendees.exportAttendeeToCSV();
     importAttendees.close();
     importAttendees.checkUserId();
     
    }
    }
    }