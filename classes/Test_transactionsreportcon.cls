@istest (SeeAllData = true)
public without sharing class  Test_transactionsreportcon
{

   static testmethod void Testmethod_transactionsreportcon(){
  
  Profile w = [select id from profile where name='Standard User'];
      
      User u = new User(alias = 'test123', email='test12345@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test12345@noemail.com');
      insert u;
  
  
  Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  customProfileBooth;
       
       Event__c eve = new Event__c(OrganizerId__c='phani@globalnest.com',EV_Title__c='TestEvent',EV_WebsiteURL__c='https://www.globalnest.com',EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/18/2014'),EV_EndTime__c='09:00 PM',StartTime__c='11:00 AM');
      insert eve;
      system.debug('ffffffffffffff'+eve.id);
      
     Constomer__c cus2 = new  Constomer__c();
       cus2.Uniq_Number__c ='test';
       cus2.IsInserted__c=true;
       insert cus2;
  
       Dummay__c d = new Dummay__c(Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test123@noemail.com',First_Name__c='FName',Event__c=eve.id,Email__c='test12345@noemail.com',TicketAmount__c=60,Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id);
       insert d;
        system.debug('mmmmmmmmmmmmmc'+d.id);
       
      Emailtemplate em= new Emailtemplate();
      em.Name= 'Failed Transaction';
       em.Subject='hi';
      // insert em;
       
      
      
       transactionsreportcon tr= new transactionsreportcon();
       tr.email =d.id;
       tr.eventid=eve.id;
       tr.sendemail();
       tr.chkpay();
       
       }
       }