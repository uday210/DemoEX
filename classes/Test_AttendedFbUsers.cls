@isTest
public class Test_AttendedFbUsers{

public static testMethod void testdoget(){

contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
  
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'test123', email='test100@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test100@noemail.com', FaceBookId__c='596207599');
                  insert u;
                  Id eventAdminId=u.id;    
 
 
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;

 DeviceUsage__c device=new DeviceUsage__c(EV_id__c=eve.id,IMEI__c='12365',OsVersion__c='safari 6',User__c=u.id);
     insert device;
     
     system.runAs(u){
     
      System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/AttendedFbUsers';
       RestContext.request.addParameter('eventIDForFB',eve.id);
       RestContext.request.addParameter('userid', u.Id);
       string JSONMsg='[{"id":"596207598","Name":"Mk Chakravarthy"},{"id":"596207599","Name":"Chpk"}]';
       RestContext.request.requestBody = Blob.valueof(JSONMsg );
         AttendedFbUsers.doPost();
     }
     
     

}


}