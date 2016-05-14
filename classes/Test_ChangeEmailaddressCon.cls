@istest

public class Test_ChangeEmailaddressCon 
{
  static testmethod void doTestChangeEmailaddressCon()
  {
  
  Profile p = [select id from profile where name='Standard User'];
   User u = new User(alias = 'test123', email='test567@salesforce.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test567@salesforce.com');
  insert u;
   
     AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='test123@noemail.com');
     insert attSummary;
     
     ChangeEmailaddressCon Cea = new ChangeEmailaddressCon();
     Cea.oldemail='test123@noemail.com';
     Cea.newemail='test43@gmail.com';
     Cea.saveName();
      Cea.changepassword();
     Cea.changeEmail();
     
  
  }
  
}