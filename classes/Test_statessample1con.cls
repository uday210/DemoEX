@istest

public class Test_statessample1con
{
  static testmethod void statessample1con_testmethod()
  {
    Profile p = [select id from profile where name='Standard User'];   
    User u = new User(alias = 'test123', email='test123@noemail.com',
                      emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
                      localesidkey='en_US',country='United States',
                      timezonesidkey='America/Los_Angeles', username='tes98673@noemail.com');
    insert u;  
    
     user EAdmin =  new User(alias = 'testboot', email='testeventadmin@noemail.com',
                             emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US',country='United States',
                             timezonesidkey='America/Los_Angeles', username='testeventadmin@noemail.com');
                  
    insert EAdmin ;
    
    
    user bAdmin =  new User(alias = 'testboot', email='testboothadmin@noemail.com',
                            emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                            localesidkey='en_US',country='United States',
                            timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com');
                  
    insert bAdmin ;
   
    
      Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
        insert  customProfile;
       
    Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
      insert  customProfileBooth;  
    
    Profile__c customprofilebpl = new Profile__c (PR_Name__c='BoothPersonnel',PR_Version__c='1.5');
      insert customProfilebpl;
    
   
    
    Event__c ev = new Event__c(EV_Title__c='TestEvent',
                               EV_HostingTimeZone__c='Eastern Time(USA)',
                               EV_EndDate__c =  Date.Parse('01/18/2014'),
                               EV_StartDate__c = Date.Parse('01/16/2014'),
                               EV_EndTime__c='09:00 PM',
                               StartTime__c='09:00 AM');
    insert ev;
   
   Event__c ev1 = new Event__c(EV_Title__c='TestEvent1',
                               EV_HostingTimeZone__c='Eastern Time(USA)',
                               EV_EndDate__c =  Date.Parse('01/18/2014'),
                               EV_StartDate__c = Date.Parse('01/18/2014'),
                               EV_EndTime__c='09:00 AM',
                               StartTime__c='11:00 AM');
   insert ev1;  
   
   AttendeeSummary__c att = new AttendeeSummary__c(AS_FirstName__c='testattendeesummaryfirstname',
                                                 AS_LastName__c='testattendeelastname',
                                                 AS_Email__c='test123@noemail.com',
                                                 AS_Company__c='testattendeecompany',
                                                 AS_Work_States__c='Alabama',
                                                 AS_PrimaryBusinessCategory1__c='Accounting',
                                                 AS_CellPhone__c='9705036486');    
   insert att; 
   
   }
   }