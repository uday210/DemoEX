@istest

public class Test_SignUpEmail
{
  static testmethod void Testmethod_SignUpEmail()
  {
 
  contact con = new contact(firstname='emailtest',lastname='emailln');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u1 = new User(alias = 'temp', email='testemail@temp.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Test1', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',isSignup__c=true,
                  timezonesidkey='America/Los_Angeles', username='testemail1@temp.com');
                  insert u1;

              



 User u = new User(alias = 'Etemp', email='testemail@temp.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Test', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',isSignup__c=false,
                  timezonesidkey='America/Los_Angeles', username='testemail@temp.com');
                  insert u;

                  Id eventAdminId=u.id;    

u.isSignup__c=true;
update u;
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  EventAdminProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Email Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
      
     
User_Profile_Event__c upebooth = new User_Profile_Event__c(EV_id__c=EventId,
EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,
Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upebooth; 
  
  
  system.runAs(u){
  }
  }
  }