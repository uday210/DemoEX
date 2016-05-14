@isTest
public class Test_BL_Special_Needs_Expos_Success_Con{

 public static TestMethod void testMe(){
 Account Acc = new Account();
  Acc.Name = 'Booth Leads';
  insert Acc;

 Contact C = new Contact();
 C.LastName = 'Test';
 C.Accountid = Acc.id;
 insert C;
     Profile p = [select id from profile where name='Standard User'];

User u = new User(alias = 'test123', email='test123huh@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123huh@noemail.com');
                  insert u;

                  Id eventAdminId=u.id;   

Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  customProfileBooth;
   
 
       
    
  Event__c eve = new Event__c(EV_Title__c='TestEvent',EV_WebsiteURL__c='https://www.globalnest.com',Is_MatchMaking_Event__c=True);
  insert eve;
  
   User_Profile_Event__c upeEA = new User_Profile_Event__c(EV_id__c=eve.id,EventAdmin_Id__c=eventAdminId,
    Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId);         
      insert upeEA;   
      
       
  //Event__c eve = new Event__c(EV_Title__c='Aged Care 2014',EV_WebsiteURL__c='http://AgedCare2014.com',Is_MatchMaking_Event__c='true');
  //insert eve;
  
  
   Profile__c profileBA = new Profile__c(PR_Name__c='BoothAdmin');
   insert profileBA;
   
  TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  TicketTypes__c tic2 = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Non – Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic2;
  
   Constomer__c cus2 = new  Constomer__c();
   cus2.Uniq_Number__c ='test';
   insert cus2;
  
   
  
  Dummay__c com2 = new Dummay__c(TicketTypes__c=tic.id,Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test123@noemail.com',First_Name__c='FName',Event__c=eve.id,Email__c='test@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id);
  insert com2;
  
  
   AttendeeSummary__c att = new AttendeeSummary__c(AS_firstNAme__c='FName',AS_LastName__c='Lame',AS_Email__C='test@salesforce.com',AS_Company__c='Com');
   insert att;
  
   Constomer__c cus = new  Constomer__c();
   cus.Uniq_Number__c ='test';
   insert cus;
   
  Dummay__c com = new Dummay__c(TicketTypes__c=tic.id,Profile__c='BoothAdmin',Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test@salesforce.com',First_Name__c='FName',Event__c=eve.id,Email__c='test1@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus.id);
  insert com;
 

  AttendeeSummary__c att1 = new AttendeeSummary__c(AS_firstNAme__c='FName',AS_LastName__c='Lame',AS_Email__C='test1@salesforce.com',AS_Company__c='Com');
   insert att1;
  
 
  PageReference pg = Page.BL_RegistrationSuccess;
   Test.setCurrentPage(pg); 
       ApexPages.currentPage().getParameters().put('paykey', cus.id);
   
   BL_Special_Needs_Expos_Success_Con con = new BL_Special_Needs_Expos_Success_Con();
   con.MainMethod();
   con.redirectPage();
   Test.startTest();
   ApexPages.currentPage().getParameters().put('paykey', cus2.id);
   con.MainMethod();
   Test.stopTest();
     
 }


}