@isTest
public class Test_getExibitors{

public static testMethod void testrest(){

contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'test123', email='test1236@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test1236@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  customProfileBooth;
       
       
       
       
       
       
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;
      
      
      
      
      
     
     Booth__c booth1 = new Booth__c(BT_Name__c='TestBooth1',BT_BoothUserCount__c=100,EV_id__c=EventId);
      insert booth1;
      
  EventSchedule__c eveschedule = new EventSchedule__c(ES_ProgramName__c='demo salesforce', EV_id__c=EventId);
 insert eveschedule;

system.runas(u){
System.RestContext.request = new RestRequest();
      RestContext.request.requestURI = '/GlobalnestEM/getExibitors';
       RestContext.request.addParameter('EventId',EventId);
         getExibitors.doPost();
        // getExibitors.doPost123();
}

}
}