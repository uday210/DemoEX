@istest(SeeAllData= true)

public class Test_SA_ReportsController 
{
  static testmethod void Testmethod_SA_ReportsController(){
  
  contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
       
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'satt', email='scanatt@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='scanatt', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',ScanAttendee_User__c = true,
                  timezonesidkey='America/Los_Angeles', username='scanatt@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='4.5');        
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
      
      TT1.TT_Name__c=' ticket type1';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Paid';
      TT1.Ticket_Category__c='Attendee';
      insert TT1;

      TicketTypes__c TT2= new TicketTypes__c();
      
      TT2.TT_Name__c=' ticket type2';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Paid';
      TT2.Ticket_Category__c='Non – Attendee';
      insert TT2;
      
     
      Item__c item1= new Item__c();
      item1.Event__c=eve.Id;
      item1.Item_name__c='item1';
      item1.Cost__c= 35.50;
      item1.isTaxable__c= TRUE;
      item1.Item_Quantity__c= 50;
      insert item1;
      
      Item__c item2= new Item__c();
      item2.Event__c=eve.Id;      
      item2.Item_name__c='item2';
      item2.Cost__c= 45.50;
      item2.isTaxable__c= FALSE;
      item2.Item_Quantity__c= 35;
      insert item2;
      
      Constomer__c trans= new Constomer__c();
      trans.Email__c= 'manasa@gmail.com';
      trans.Ticket_Types__c= TT1.Id;
      trans.Total_Amount__c=4500;
      trans.Isinserted__c = TRUE;  
      insert trans;
      
      Dummay__c regInfo1= new Dummay__c();
      regInfo1.Event__c= eve.id;
      //regInfo1.Event_Attendee_Mapping__c= eam.Id;
      regInfo1.First_Name__c= 'sru';
      regInfo1.Last_Name__c= 'reddy';
      regInfo1.Email__c= 'sru@gmail.com';
      regInfo1.customer_key__c= trans.Id;
      regInfo1.TicketTypes__c= TT1.Id;
      regInfo1.TicketAmount__c= 1000;
      regInfo1.Tickets_Quantty__c= 2;
      regInfo1.Payment_Type__c= 'Cash';
      insert regInfo1;
      
      AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_Email__c='sru@gmail.com';
      att.AS_FirstName__c='sru';
      att.AS_LastName__c='reddy';
      att.AS_Company__c='TCS';
      insert att;
      
    
      
      Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c= att.id;
      eam.Boothleads_Profile__c= 'Attendee';
      eam.EV_id__c= eve.id;
      eam.IsBoothLeadsAttendee__c= TRUE;
      eam.Is_CheckedIn__c= TRUE;
      insert eam;
      
      
      User_Profile_Event__c upe= new User_Profile_Event__c();
      
      upe.Attendee_Summary__c= att.id;
      upe.EV_id__c= eve.id;
      upe.EventAdmin_Id__c = UserInfo.getUserId();
      upe.UEP_isActive__c= TRUE;
      upe.Profile_id__c=EventAdminProfile.Id;
      upe.User_id__c= U.Id;
      
      insert upe;
      
      
      regInfo1.Event_Attendee_Mapping__c= eam.Id;
      upsert regInfo1;
      
      
      Dummay__c regInfo2= new Dummay__c();
      regInfo2.Event__c= eve.id;
     // regInfo2.Event_Attendee_Mapping__c= eam.Id;
      regInfo2.First_Name__c= 'sru';
      regInfo2.Last_Name__c= 'reddy';
      regInfo2.Email__c= 'sru@gmail.com';
      regInfo2.customer_key__c= trans.Id;
      regInfo2.item__c= item1.Id;
      regInfo2.TicketAmount__c= 1000;
      regInfo2.Tickets_Quantty__c= 2;
      regInfo2.Item_Quantity__c= 3;
      regInfo2.Payment_Type__c= 'Credit Card';
                               
      insert regInfo2;
      
       regInfo2.Event_Attendee_Mapping__c= eam.Id;
      upsert regInfo2;
      
      
      Dummay__c regInfo3= new Dummay__c();
      regInfo3.Event__c= eve.id;
     // regInfo3.Event_Attendee_Mapping__c= eam2.Id;
      regInfo3.First_Name__c= 'san';
      regInfo3.Last_Name__c= 'reddy';
      regInfo3.Email__c= 'san@gmail.com';
      regInfo3.customer_key__c= trans.Id;
      regInfo3.TicketTypes__c= TT1.Id;
      regInfo3.TicketAmount__c= 1000;
      regInfo3.Tickets_Quantty__c= 2;
      regInfo3.Payment_Type__c= 'Cash';
      insert regInfo3;
      
     
      AttendeeSummary__c  att2= new AttendeeSummary__c ();
      att2.AS_Email__c='san@gmail.com';
      att2.AS_FirstName__c='san';
      att2.AS_LastName__c='reddy';
      insert att2;   
      
      Event_Attendee_Mapping__c eam2= new Event_Attendee_Mapping__c();
      eam2.AS_id__c= att2.id;
      eam2.Boothleads_Profile__c= 'Attendee';
      eam2.EV_id__c= eve.id;
      eam2.IsBoothLeadsAttendee__c= TRUE;
      eam2.Is_CheckedIn__c= TRUE;
      insert eam2;
      
      
       regInfo3.Event_Attendee_Mapping__c= eam2.Id;
       upsert regInfo3;
      
      
      Dummay__c regInfo4= new Dummay__c();
      regInfo4.Event__c= eve.id;
     // regInfo4.Event_Attendee_Mapping__c= eam2.Id;
      regInfo4.First_Name__c= 'san';
      regInfo4.Last_Name__c= 'reddy';
      regInfo4.Email__c= 'san@gmail.com';
      regInfo4.customer_key__c= trans.Id;
      regInfo4.item__c= item1.Id;
      regInfo4.TicketAmount__c= 1000;
      regInfo4.Tickets_Quantty__c= 2;
      regInfo4.Item_Quantity__c= 3;
      regInfo4.Payment_Type__c= 'Credit Card';
                               
      insert regInfo4;
      
      
       regInfo4.Event_Attendee_Mapping__c= eam2.Id;
       upsert regInfo4;
      
      
      
      MatchLeads_Days__c Daysl=  new MatchLeads_Days__c(Event__c =eve.id,MatchLeads_Date__c = system.today(),End_Time__c='06:00 PM',Start_time__c='09:00 AM',Session_Name__c = 'aaa');
       insert Daysl; 
       
        Ticket_Session_Mapping__c tsm = new Ticket_Session_Mapping__c();
       tsm .Is_Input__c = True;
       tsm .Session__c = Daysl.Id;
       tsm .Ticket__c=TT1.id;
        tsm .Unique_Ids__c = '1';
       insert tsm ;
       
       Ticket_Session_Mapping__c tsm1 = new Ticket_Session_Mapping__c();
       tsm1 .Is_Input__c = True;
       tsm1.Session__c = Daysl.Id;
       tsm1 .Ticket__c=TT2.id;
        tsm1 .Unique_Ids__c = '2';
       insert tsm1 ;       
                           
       cookie  counter = new Cookie('counter',eve.id,null,-1,false);
       ApexPages.currentPage().setCookies(new Cookie[]{counter});
       
       system.runas(u){
       
       Individual_Ticket_Info__c ind1= new Individual_Ticket_Info__c();
      ind1.Event_Attendee_Mapping__c=eam.id;
      ind1.IsCheckedIn__c= TRUE;
      ind1.Is_Primary__c= TRUE;
      ind1.IsCancelled__c = FALSE;
      ind1.Registration_Info__c= regInfo1.Id;
      ind1.Scanned_by__c= UserInfo.getUserId();
      ind1.Seat__c= 'SEAT-0001';
      ind1.Is_Input__c = true;
      insert ind1;
      
      Individual_Ticket_Info__c ind2= new Individual_Ticket_Info__c();
      ind2.Event_Attendee_Mapping__c=eam.id;
      ind2.IsCheckedIn__c= TRUE;
      ind2.Is_Primary__c= TRUE;
      ind2.IsCancelled__c = FALSE;
      ind2.Registration_Info__c= regInfo1.Id;
      ind2.Scanned_by__c= UserInfo.getUserId();
      ind2.Seat__c= 'SEAT-0001';
      ind2.Is_Input__c = true;
      insert ind2;  
      
            
      Individual_Ticket_Info__c ind3= new Individual_Ticket_Info__c();
      ind3.Event_Attendee_Mapping__c=eam.id;
      ind3.IsCheckedIn__c= FALSE;
      ind3.Is_Primary__c= FALSE;
      ind3.IsCancelled__c = TRUE;
      ind3.Registration_Info__c= regInfo2.Id;
      ind3.Scanned_by__c= UserInfo.getUserId();
      ind3.Seat__c= 'SEAT-0001';
      ind3.Is_Input__c = true;
      insert ind3;       
      
      User_CheckinHistory__c uch1= new User_CheckinHistory__c();
      uch1.Individual_Ticket_Info__c=ind1.id;
      uch1.UC_CheckinTime__c= String.valueof(system.now());
      uch1.CheckoutTime__c= String.valueof(system.now()+1);
      insert uch1;
      
      User_CheckinHistory__c uch2= new User_CheckinHistory__c();
      uch2.Individual_Ticket_Info__c=ind2.id;
      uch2.UC_CheckinTime__c= String.valueof(system.now());
      uch2.CheckoutTime__c= String.valueof(system.now()+1);
      insert uch2;
      
      User_CheckinHistory__c uch3= new User_CheckinHistory__c();
      uch3.Individual_Ticket_Info__c=ind3.id;
      uch3.UC_CheckinTime__c= String.valueof(system.now());
      uch3.CheckoutTime__c= String.valueof(system.now()+1);
      insert uch3;
       test.starttest();
      SA_ReportsController rep1= new SA_ReportsController();
      rep1.ticketRevenueStatistics();
      rep1.itemRevenueStatistics();
      rep1.RevenueStatistics();
      rep1.ticketSales();   
      rep1.itemSales();
      rep1.checkinStatus();       
      rep1.orderSales();
      rep1.ticketSalesReport();
     // rep1.checkInStatusReport();
     // rep1.CheckInHistoryReport();
      
      

      rep1.refundsList();
      rep1.showRefundPopUp();
      rep1.checkUserId();
      rep1.PrintReport();
      rep1.exportIntoCSV();
      
      rep1.ReportName = 'Report On Ticket Sales';
      rep1.selectedFilterType = 'Company';
      rep1.ticketSales(); 
      rep1.selectedFilterType = 'Payment Type';
      rep1.ticketSales(); 
      rep1.selectedFilterType = 'Ticket';
      rep1.ticketSales();  
      
      rep1.ReportName = 'Report On Item Sales';
      rep1.selectedFilterType = 'Company';
      rep1.ticketSales(); 
      rep1.selectedFilterType = 'Payment Type';
      rep1.ticketSales(); 
      rep1.selectedFilterType = 'Item';
      rep1.ticketSales(); 
      
      test.stoptest();      
       } 
   }
}