@istest(SeeAllData= true)

public class Test_SA_AddAttendeeController
{
  static testmethod void Testmethod_SA_AddAttendeeController(){
 
  contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
      
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'test123', email='manasa@gmail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test12445711@noemail.com');
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
      att2.AS_FirstName__c='soum';
      att2.AS_LastName__c='madam';
      att2.AS_Email__c='soum@gmail.com';
     
      insert att2;
     
      
     
     
      Event_Attendee_Mapping__c eam2= new Event_Attendee_Mapping__c();
      eam2.AS_id__c= att2.id;
      eam2.Boothleads_Profile__c= 'Attendee';
      eam2.EV_id__c= eve.id;
      eam2.IsBoothLeadsAttendee__c= TRUE;
      insert eam2;
     
      Constomer__c trans= new Constomer__c();
      trans.Email__c= 'manasa@gmail.com';
      trans.Ticket_Types__c= TT1.Id;
      trans.Total_Amount__c=4500;
      insert trans;
     
      Dummay__c regInfo1= new Dummay__c();
      regInfo1.Event__c= eve.id;
      //regInfo1.Event_Attendee_Mapping__c= eam.Id;
      regInfo1.First_Name__c= 'rohit';
      regInfo1.Last_Name__c= 'aith';
      regInfo1.Email__c= 'rohit@gmail.com';
      regInfo1.customer_key__c= trans.Id;
      regInfo1.TicketTypes__c= TT1.Id;
      regInfo1.TicketAmount__c= 1000;
      regInfo1.Tickets_Quantty__c= 22;
      regInfo1.Item_Quantity__c= 30;
      regInfo1.Payment_Type__c= 'Credit Card';
                         
      insert regInfo1;
     
      
     
     
       AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_FirstName__c='rohit';
      att.AS_LastName__c='aith';
      att.AS_Email__c='rohit@gmail.com';
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
     
     
     
     
      Item__c item= new Item__c();
     
      item.Item_name__c='item1';
       item.Item_Quantity__c =100;
       item.Sold_Quantity__c = 0;
       item.Event__c =eve.id;
      insert item;
     
       /*Item__c item1= new Item__c();
     
      item1.Item_name__c='item2';
       item1.Item_Quantity__c =100;
       item1.Sold_Quantity__c = 0;
        item1.Event__c =eve.id;
      
      insert item1;*/
     
     
     
      Dummay__c regInfo2= new Dummay__c();
      regInfo2.Event__c= eve.id;
      //regInfo2.Event_Attendee_Mapping__c= eam.Id;
      regInfo2.First_Name__c= 'chand';
      regInfo2.Last_Name__c= 'akva';
      regInfo2.Email__c= 'chand@gmail.com';
      regInfo2.customer_key__c= trans.Id;
      regInfo2.item__c= item.Id;
      regInfo2.TicketAmount__c= 1000;
      regInfo2.Tickets_Quantty__c= 22;
      regInfo2.Item_Quantity__c= 0;
      regInfo2.Payment_Type__c= 'Credit Card';
                              
      insert regInfo2;
     
    
     
     
     
      AttendeeSummary__c  att1= new AttendeeSummary__c ();
      att1.AS_FirstName__c='chand';
      att1.AS_LastName__c='akva';
      att1.AS_Email__c='chand@gmail.com';
     att1.AS_Company__c = 'Globalnest';
     att1.AS_Title__c ='mr';
     att1.AS_WorkPhone__c ='9087654321';
     att1.AS_WorkAddress1__c = 'sdasdf';
     att1.AS_WorkCity__c ='Hyderabad';
     att1.AS_Work_Country__c = 'India';
     att1.AS_Work_States__c ='Andhra Pradesh';
     att1.AS_WorkZip__c ='500072';
     
     
      insert att1;
     
       Event_Attendee_Mapping__c eam1= new Event_Attendee_Mapping__c();
      eam1.AS_id__c= att1.id;
      eam1.Boothleads_Profile__c= 'Attendee';
      eam1.EV_id__c= eve.id;
      eam1.IsBoothLeadsAttendee__c= TRUE;
      insert eam1;
     
     
     //user uu = new user();
     //u.id=att1.id;
    /* uu.FirstName='chand';
     uu.LastName='akva';
     uu .Email='chand@gmail.com';
     uu.CompanyName= 'Globalnest';
     uu.Title='mr';
      uu.Companyphone__c='9087654321';
      uu.CompanyAddr1__c='sdasdf';
      uu.CompanyCity__c ='Hyderabad';
      uu.Country__c =  'India';
     uu.States__c ='Andhra Pradesh';
      uu.Zipcode__c='500072';*/
      
     // update u;
      
        regInfo2.Event_Attendee_Mapping__c= eam.Id;
                          
       upsert regInfo2;
            
      Individual_Ticket_Info__c ind2= new Individual_Ticket_Info__c();
      ind2.Event_Attendee_Mapping__c=eam1.id;
      ind2.IsCheckedIn__c= FALSE;
      ind2.Is_Primary__c= FALSE;
      ind2.Registration_Info__c= regInfo2.Id;
      ind2.Scanned_by__c= UserInfo.getUserId();
      ind2.Seat__c= 'SEAT-0002';
      ind2.Is_Input__c = TRUE ;
       ind2.IsCancelled__c = FALSE ;
       ind1.IsItem__c = FALSE;
      insert ind2;      
     
     
     
     
     
     
      MatchLeads_Days__c Daysl=  new MatchLeads_Days__c(Event__c = eve.id,MatchLeads_Date__c = system.today(),End_Time__c='06:00 PM',Start_time__c='09:00 AM',Session_Name__c = 'aaa');
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
   
     ApexPages.CurrentPage().getParameters().put('Id',att.id); 
     ApexPages.CurrentPage().getParameters().put('eam',eam.id);     
   
     SA_AddAttendeeController addatt2= new SA_AddAttendeeController();
    
     addatt2.TogetSelectedEvent();
     addatt2.ShowSelectedTickets();
   
     ApexPages.CurrentPage().getParameters().put('STick',TT1.id);   
    
     addatt2.ShowTicketDetails();
      addatt2.ShowItemDetails();
     addatt2.addingMultipleTickets();
     ApexPages.CurrentPage().getParameters().put('index','0');   
     addatt2.calculateAmount();
     ApexPages.CurrentPage().getParameters().put('index','0');
     addatt2.DeleteTickets();
    
     ApexPages.CurrentPage().getParameters().put('itemIndex','0');
     addatt2.DeleteItems();
        
       addatt2.ChargeId = '12345';
       addatt2.ChargeNumber= '105';
       addatt2.FeeValue= 15;
       addatt2.calculateAmount();
       addatt2.SaveAttendee();  
       addatt2.PaymentForm(); 
      
       addatt2.SelectedEAMId=eam.id;  
        addatt2.SelectedRegInfoId=regInfo1.Id;
       addatt2.GuestDetails();
    
    
    
    
      addatt2.SelectedRegInfoId =regInfo1.Id;
      addatt2.SelectedEAMId=eam.id;
      addatt2.addGuestForm(); 
    
      addatt2.SelectedEAMId=eam1.id;
      addatt2.SelectedRegInfoId=regInfo1.Id;
      addatt2.SaveGuests();
     
      addatt2.insertCustomerkey();
       addatt2.updateUser();
       addatt2.validatePayment();
      
       addatt2.SelectedPaymentType = 'Credit Card';
     addatt2.CreditCardNumber= '';
   
     addatt2.insertCustomerkey();
     addatt2.updateUser();
       addatt2.TotalAmount = 5.00;
      addatt2.validatePayment();
 
      
      addatt2.SelectedPaymentType = 'Credit Card';
     addatt2.CreditCardNumber= '12a';
     addatt2.insertCustomerkey();
     addatt2.updateUser();
      addatt2.validatePayment();
     
       addatt2.SelectedPaymentType = 'Credit Card';
     addatt2.CreditCardNumber= '';
     addatt2.insertCustomerkey();
     addatt2.updateUser();
      addatt2.validatePayment();
     
      addatt2.SelectedPaymentType = 'Credit Card';
     addatt2.CreditCardNumber= '121111';
     addatt2.insertCustomerkey();
     addatt2.updateUser();
      addatt2.validatePayment();
   
     addatt2.CreditCardNumber= '1211111211111211';
     addatt2.CVVNumber = '12AA';
     addatt2.selectedyear = string.valueof(system.today().year());
     addatt2.selectedMonth = string.valueof(system.today().month());
      addatt2.insertCustomerkey();
     addatt2.updateUser();
      addatt2.validatePayment();
     
       addatt2.CreditCardNumber= '1211111211111211';
     addatt2.CVVNumber = '';
     addatt2.selectedyear = string.valueof(system.today().year());
     addatt2.selectedMonth = string.valueof(system.today().month());
      addatt2.insertCustomerkey();
     addatt2.updateUser();
      addatt2.validatePayment();
     
     
       addatt2.CreditCardNumber= '1211111211111211';
     addatt2.CVVNumber = '12aa';
     addatt2.selectedyear = string.valueof(system.today().year());
     addatt2.selectedMonth = string.valueof(system.today().month());
      addatt2.insertCustomerkey();
     addatt2.updateUser();
      addatt2.validatePayment();
     
      addatt2.CreditCardNumber= '1211111211111211';
       addatt2.CVVNumber = '1211';
     addatt2.selectedyear = string.valueof(system.today().year());
     addatt2.selectedMonth = string.valueof(system.today().month());
     addatt2.insertCustomerkey();
     addatt2.updateUser();
      addatt2.validatePayment();
     
      addatt2.SelectedPaymentType = 'Credit Card';
     addatt2.CreditCardNumber= '1211111211111211';
     addatt2.CVVNumber = '124';
     addatt2.selectedyear = string.valueof(system.today().year());
     addatt2.selectedMonth = string.valueof(system.today().month());
   
    
      addatt2.insertCustomerkey();
     addatt2.updateUser();
       addatt2.TotalAmount = 5.00;
     // addatt2.validatePayment();
     
       //ApexPages.CurrentPage().getParameters().put('guestindex','0');  
        //addatt2.DeleteGuests();
      
       addatt2.CloseGuests();
    
       addatt2.Cancel();
       addatt2.checkUserId();
       ApexPages.CurrentPage().getParameters().put('index','0');  
     
     addatt2.dummyclassforcode();
     addatt2.dummyclass2forcode();
     addatt2.dummyclass3forcode();
    
    
   
    }               
   
      
   }
}