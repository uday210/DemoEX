@istest

public class Test_signupcon
{
  static testmethod void signupcon_testmethod()
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
   
   User_Profile_Event__c upe=new User_Profile_Event__c(EV_id__c=ev.id,BoothAdmin_id__c=u.id,EventAdmin_Id__c=u.id,User_id__c=u.id,Profile_id__c=customProfile.id);
   insert upe;  
   
   User_Profile_Event__c upe1=new User_Profile_Event__c(EV_id__c=ev.id,BoothAdmin_id__c=u.id,EventAdmin_Id__c=u.id,User_id__c=u.id,Profile_id__c=customProfileBooth.id);
   insert upe1;
   
   User_Profile_Event__c upe2=new User_Profile_Event__c(EV_id__c=ev.id,BoothAdmin_id__c=u.id,EventAdmin_Id__c=u.id,User_id__c=u.id,Profile_id__c=customprofilebpl.id);
   insert upe2;
   
   signupcon db=new signupcon();
  }
}