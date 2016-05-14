@istest(SeeAllData= true)
public class Test_SA_EventDashboardController 
{
  static testmethod void Testmethod_SA_EventDashboardController(){
  
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
       
        Profile__c EventAdminProfilestaff= new Profile__c (PR_Name__c='EventAdmin Staff',PR_Version__c='1.5');        
       insert  EventAdminProfilestaff;
       
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
      TT1.TT_Available__c=100;
      insert TT1;

      TicketTypes__c TT2= new TicketTypes__c();
      
      TT2.TT_Name__c=' ticket type2';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Free';
      TT2.Ticket_Category__c='Non – Attendee';
       
      insert TT2;
     
      
      
      
      
      Constomer__c trans= new Constomer__c();
      trans.Email__c= 'manasa@gmail.com';
      trans.Ticket_Types__c= TT1.Id;
      trans.Total_Amount__c=4500;
      insert trans;
      
      Dummay__c regInfo1= new Dummay__c();
      regInfo1.Event__c= eve.id;
      //regInfo1.Event_Attendee_Mapping__c= eam.Id;
      regInfo1.First_Name__c= 'manu';
      regInfo1.Last_Name__c= 'Sa';
      regInfo1.Email__c= 'manu@gmail.com';
      regInfo1.customer_key__c= trans.Id;
      regInfo1.TicketTypes__c= TT1.Id;
      regInfo1.TicketAmount__c= 1000;
      regInfo1.Tickets_Quantty__c= 22;
      regInfo1.Item_Quantity__c= 30;
      regInfo1.Payment_Type__c= 'Cash';
                          
      insert regInfo1;
      
      
       
      AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_Email__c= 'manu@gmail.com';
      att.AS_FirstName__c='manu';
      att.AS_LastName__c='Sa';
      
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
      upe.Profile_id__c=EventAdminProfilestaff.Id;
      upe.User_id__c= u.Id;
      
      insert upe;
      
       regInfo1.Event_Attendee_Mapping__c= eam.Id;
       upsert regInfo1;
      
      Item__c item= new Item__c();
      
      item.Item_name__c='item1';
      item.Item_Quantity__c=10;
      insert item;
      
      Dummay__c regInfo2= new Dummay__c();
      regInfo2.Event__c= eve.id;
      regInfo2.Event_Attendee_Mapping__c= eam.Id;
      regInfo2.First_Name__c= 'manu';
      regInfo2.Last_Name__c= 'Sa';
      regInfo2.Email__c= 'manu@gmail.com';
      regInfo2.customer_key__c= trans.Id;
      regInfo2.item__c= item.Id;
      regInfo2.TicketAmount__c= 1000;
      regInfo2.Tickets_Quantty__c= 22;
      regInfo2.Item_Quantity__c= 30;
      regInfo2.Payment_Type__c= 'Credit Card';
                               
      insert regInfo2;
      
      Individual_Ticket_Info__c ind1= new Individual_Ticket_Info__c();
      ind1.Event_Attendee_Mapping__c=eam.id;
      ind1.IsCheckedIn__c= TRUE;
      ind1.Is_Primary__c= TRUE;
      ind1.Registration_Info__c= regInfo1.Id;
      ind1.Scanned_by__c= UserInfo.getUserId();
      ind1.Seat__c= 'SEAT-0001';
      insert ind1;
      
            
      Individual_Ticket_Info__c ind2= new Individual_Ticket_Info__c();
      ind2.Event_Attendee_Mapping__c=eam.id;
      ind2.IsCheckedIn__c= FALSE;
      ind2.Is_Primary__c= FALSE;
      ind2.Registration_Info__c= regInfo2.Id;
      ind2.Scanned_by__c= UserInfo.getUserId();
      ind2.Seat__c= 'SEAT-0001';
      insert ind2;       
      
                           
        cookie  counter = new Cookie('counter',eve.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
      system.runas(u){
     SA_EventDashboardController dashboard= new SA_EventDashboardController();
     dashboard.checkuserId();
     }  
   }
}