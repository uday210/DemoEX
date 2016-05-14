@istest(SeeAllData= true)

public class Test_DoNotDeleteRegInfo{

    static testmethod void Testmethod_DoNotDeleteRegInfo(){
 
        contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
      
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'reg', email='regdelete@gmail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='regdelete@gmail.com');
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
     
     
      TicketTypes__c TT1= new TicketTypes__c();
     
      TT1.TT_Name__c='Attendee';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Free';
      TT1.Ticket_Category__c='Non – Attendee';
      TT1.TT_Available__c =100;
       TT1.TT_Sold__c =0;
    TT1.TT_Amount__c =1;

      insert TT1;

      TicketTypes__c TT2= new TicketTypes__c();
     
      TT2.TT_Name__c='Guest';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Donation';
      TT2.Ticket_Category__c='Non – Attendee';
       TT2.TT_Available__c =100;
       TT2.TT_Sold__c =0;
           TT2.TT_Amount__c =1;
      insert TT2;
     
     
      TicketTypes__c TT3= new TicketTypes__c();
     
      TT3.TT_Name__c='Donation1';
      TT3.EV_id__c=eve.Id;
      TT3.TT_TicketType__c='Donation';
      TT3.Ticket_Category__c='Attendee';
      TT3.TT_Available__c =100;
       TT3.TT_Sold__c =0;
        TT3.TT_Amount__c =1;
      insert TT3;
     
    
     
     
     
      AttendeeSummary__c  att2= new AttendeeSummary__c ();
      att2.AS_FirstName__c='reg';
      att2.AS_LastName__c='delete';
      att2.AS_Email__c='regdelete@gmail.com';
     
      insert att2;
     
      
     
     
      Event_Attendee_Mapping__c eam2= new Event_Attendee_Mapping__c();
      eam2.AS_id__c= att2.id;
      eam2.Boothleads_Profile__c= 'Attendee';
      eam2.EV_id__c= eve.id;
      eam2.IsBoothLeadsAttendee__c= TRUE;
      insert eam2;
     
      Constomer__c trans= new Constomer__c();
      trans.Email__c= 'regdelete@gmail.com';
      trans.Ticket_Types__c= TT1.Id;
      trans.Total_Amount__c=4500;
      insert trans;
     
      Dummay__c regInfo1= new Dummay__c();
      regInfo1.Event__c= eve.id;
      //regInfo1.Event_Attendee_Mapping__c= eam.Id;
      regInfo1.First_Name__c= 'rohit';
      regInfo1.Last_Name__c= 'aith';
      regInfo1.Email__c= 'regdelete@gmail.com';
      regInfo1.customer_key__c= trans.Id;
      regInfo1.TicketTypes__c= TT1.Id;
      regInfo1.TicketAmount__c= 1000;
      regInfo1.Tickets_Quantty__c= 22;
      regInfo1.Item_Quantity__c= 30;
      regInfo1.Payment_Type__c= 'Credit Card';
                         
      insert regInfo1;
     // try{      
          Database.Delete(regInfo1, FALSE);
     // }catch(Exception Ex){}
     
     }
     
     }