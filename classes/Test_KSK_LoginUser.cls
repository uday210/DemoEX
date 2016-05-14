@isTest
public class Test_KSK_LoginUser {


static testMethod void test_KSK_LoginUser() {
    account a = new account();
    a.name ='accName';
    insert a;
  
   contact m = new contact(accountId=a.id,firstname='testcontactname',lastname='testcontactlastname');
   insert m;
       Profile w = [select id from profile where name='Event Admin'];
  
  Profile w1 = [select id from profile where name='System Administrator'];
  
  User u = new User(alias = 'test1234', email='test1234@noemail.com',
                 emailencodingkey='UTF-8',profileid = w1.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',password__c='cpkn1234',
                  timezonesidkey='America/Los_Angeles', username='global123@noemail.com');
                  insert u;
                  
                  
    Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
     
      Id EventId=eve.Id;


     AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='test123@noemail.com');
     insert attSummary;
     
     Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
     insert  customProfileBooth;
   
     Profile__c pro= new Profile__c (PR_Name__c='Attendee',PR_Version__c='1.5');        
     insert  pro;
     
     User_Profile_Event__c upebu1 = new User_Profile_Event__c(EV_id__c=EventId,Profile_id__c=customProfileBooth.Id,Status__c='Active',User_id__c=u.Id,UEP_isActive__c=true);         
     insert upebu1 ; 
       
       
     
     
     
       
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/KSK_LoginUser';
       RestContext.request.addParameter('userName', 'global123@noemail.com');
       RestContext.request.addParameter('passWord', 'cpkn1234');
       KSK_LoginUser.doPost();

}

}