@isTest
public class Test_BL_TransactionDetailsCon{

 public static TestMethod void BL_TransactionDetailsContest(){
  Account Acc = new Account();
  Acc.Name = 'Booth Leads';
 insert Acc;

 Contact C = new Contact();
 C.LastName = 'Test';
 C.Accountid = Acc.id;
 insert C;
     Profile p = [select id from profile where name='Standard User'];

User u = new User(alias = 'tlest', email='tlest123@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='tlest123@noemail.com');
                  insert u;

                  Id eventAdminId=u.id;   

Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  customProfileBooth;
   
 
       
    
  Event__c eve = new Event__c(EV_Title__c='TestEvent',EV_WebsiteURL__c='https://www.globalnest.com');
  insert eve;
  
   User_Profile_Event__c upeEA = new User_Profile_Event__c(EV_id__c=eve.id,EventAdmin_Id__c=eventAdminId,
Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId);         
      insert upeEA;   
      
       
  
  
  
   Profile__c profileBA = new Profile__c(PR_Name__c='BoothAdmin');
   insert profileBA;
   
  TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  TicketTypes__c tic2 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Non – Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic2;
  
  Constomer__c cus2 = new  Constomer__c();
   cus2.Uniq_Number__c ='test';
   insert cus2;
  
    MatchLeads_Days__c Days=  new MatchLeads_Days__c(Event__c =eve.id,MatchLeads_Date__c = system.today(),End_Time__c='06:00 PM',Start_time__c='09:00 AM',Session_Name__c = 'a34434');
       insert Days; 
 
 Ticket_Session_Mapping__c tikse = new Ticket_Session_Mapping__c(Is_Input__c = TRUE,Session__c =Days.ID,Ticket__c=tic2.id,Unique_Ids__c ='5'); 
          insert tikse ;
          
          
  Dummay__c com2 = new Dummay__c(TicketTypes__c=tic2.id,Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test123@noemail.com',First_Name__c='sName',Event__c=eve.id,Email__c='test567@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id);
  insert com2;
  
  
  
  AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_Email__c='test567@salesforce.com';
      att.AS_FirstName__c='sName';
      att.AS_LastName__c='Sag';
      
      insert att;
      
      
       
      
      
      
      Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c= att.id;
      eam.Boothleads_Profile__c= 'Attendee';
      eam.EV_id__c= eve.id;
      eam.IsBoothLeadsAttendee__c= TRUE;
      eam.checkbox_dataTable__c= TRUE;
      insert eam;
 
    com2.Event_Attendee_Mapping__c=eam.ID;
       upsert com2; 
 
    Individual_Ticket_Info__c itf = new Individual_Ticket_Info__c();
      itf .IsCancelled__c = FALSE;
      itf .Event_Attendee_Mapping__c=eam.ID;
       itf .Registration_Info__c=com2.ID;
         itf .Is_Input__c = true;
      insert itf ;
  
  
  
  
  
  
  
  
  
   Constomer__c cus = new  Constomer__c();
   cus.Uniq_Number__c ='test';
   insert cus;
   
    MatchLeads_Days__c Daysl=  new MatchLeads_Days__c(Event__c =eve.id,MatchLeads_Date__c = system.today(),End_Time__c='06:00 PM',Start_time__c='09:00 AM',Session_Name__c = 'aa34');
       insert Daysl; 
 
     Ticket_Session_Mapping__c tiksess = new Ticket_Session_Mapping__c(Is_Input__c = TRUE,Session__c =Daysl.ID,Ticket__c=tic.id,Unique_Ids__c ='1'); 
          insert tiksess ;
 
  Dummay__c com = new Dummay__c(TicketTypes__c=tic.id,Tickets_Quantty__c =100,Seat_Number__c = 'Seat-1',Profile__c='BoothAdmin',Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test@salesforce.com',First_Name__c='FNnName',Event__c=eve.id,Email__c='manu12er@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus.id);
  insert com;
 
 
 
  AttendeeSummary__c  att2= new AttendeeSummary__c ();
      att2.AS_Email__c='manu12er@salesforce.com';
      att2.AS_FirstName__c='FNnName';
      att2.AS_LastName__c='Sa1';
      
      insert att2;
      
      
       
      
      
      
      Event_Attendee_Mapping__c eam2= new Event_Attendee_Mapping__c();
      eam2.AS_id__c= att2.id;
      eam2.Boothleads_Profile__c= 'Attendee';
      eam2.EV_id__c= eve.id;
      eam2.IsBoothLeadsAttendee__c= TRUE;
      eam2.checkbox_dataTable__c= TRUE;
      insert eam2;
 
  com .Event_Attendee_Mapping__c=eam2.ID;
       upsert com ; 
 
    Individual_Ticket_Info__c itf2 = new Individual_Ticket_Info__c();
      itf2 .IsCancelled__c = FALSE;
      itf2 .Event_Attendee_Mapping__c=eam2.ID;
       itf2 .Registration_Info__c=com.ID;
         itf2 .Is_Input__c = true;
      insert itf2 ;
  ApexPages.currentPage().getParameters().put('id', eve.id);
 BL_TransactionDetailsCon testcon = new BL_TransactionDetailsCon();
 testcon.showReport();
 
 
 }
 
 }