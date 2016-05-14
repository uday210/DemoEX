@istest

public class Test_InsertIndividualTickets{

  static testmethod void Testmethod_InsertIndividualTickets(){
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
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin Staff',PR_Version__c='1.5');        
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
      
      TT1.TT_Name__c=' ticket typ,e1';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Free';
      TT1.Ticket_Category__c='Non – Attendee';
      insert TT1;

      TicketTypes__c TT2= new TicketTypes__c();
      
      TT2.TT_Name__c=' Attendee Staff';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Free';
      TT2.Ticket_Category__c='Non – Atten,dee';
      insert TT2;
            
      Constomer__c trans= new Constomer__c();
      trans.Email__c= 'manasa@gmail.com';
      trans.Ticket_Types__c= TT1.Id;
      trans.Total_Amount__c=4500;
      insert trans;
      
       
      Dummay__c regInfo1= new Dummay__c();
      regInfo1.Event__c= eve.id;
      
      regInfo1.First_Name__c= 'manu';
      regInfo1.Last_Name__c= 'Sa';
      regInfo1.Email__c= 'manu@gmail.com';
      regInfo1.customer_key__c= trans.Id;
      regInfo1.TicketTypes__c= TT1.Id;
      regInfo1.TicketAmount__c= 1000;
      regInfo1.Tickets_Quantty__c= 22;
      regInfo1.Item_Quantity__c= 30;
      regInfo1.Payment_Type__c= 'Cash';
      regInfo1.Seat_Number__c = 'a1,a2';             
      insert regInfo1;
      
      
      Item__c item= new Item__c();
     
      item.Item_name__c='item1';
       item.Item_Quantity__c =100;
       item.Sold_Quantity__c = 0;
       item.Event__c =eve.id;
      insert item;
       
        Dummay__c regInfo2= new Dummay__c();
      regInfo2.Event__c= eve.id;
      
      regInfo2.First_Name__c= 'manu1';
      regInfo2.Last_Name__c= 'Sa1';
      regInfo2.Email__c= 'manu1@gmail.com';
      regInfo2.customer_key__c= trans.Id;
       regInfo2.item__c= item.Id;
      //regInfo2.TicketTypes__c= TT2.Id;
      regInfo2.TicketAmount__c= 1000;
      regInfo2.Tickets_Quantty__c= 22;
      regInfo2.Item_Quantity__c= 30;
      regInfo2.Payment_Type__c= 'Cash';
      regInfo2.Seat_Number__c = 'b1,b2';                               
      insert regInfo2;
       
       
       
      
      
      
     AttendeeSummary__c  att1= new AttendeeSummary__c ();
      att1.AS_Email__c='manu@gmail.com';
      att1.AS_FirstName__c='manu';
      att1.AS_LastName__c='Sa';
      
      insert att1;
      
      Event_Attendee_Mapping__c eam1= new Event_Attendee_Mapping__c();
      eam1.AS_id__c= att1.id;
      eam1.Boothleads_Profile__c= 'Attendee';
      eam1.EV_id__c= eve.id;
      eam1.IsBoothLeadsAttendee__c= TRUE;
      eam1.checkbox_dataTable__c= TRUE;
      insert eam1;
         
      AttendeeSummary__c  att2= new AttendeeSummary__c ();
      att2.AS_Email__c='manu1@gmail.com';
      att2.AS_FirstName__c='manu1';
      att2.AS_LastName__c='Sa1';
      
      insert att2;     
      
      Event_Attendee_Mapping__c eam2= new Event_Attendee_Mapping__c();
      eam2.AS_id__c= att2.id;
      eam2.Boothleads_Profile__c= 'Attendee';
      eam2.EV_id__c= eve.id;
      eam2.IsBoothLeadsAttendee__c= TRUE;
      eam2.checkbox_dataTable__c= TRUE;
      insert eam2;
     
    
       
      
      regInfo1.Event_Attendee_Mapping__c= eam1.Id;
       upsert regInfo1;
       
         regInfo2.Event_Attendee_Mapping__c= eam2.Id;
       upsert regInfo2;
       
      
      
    
  }
}