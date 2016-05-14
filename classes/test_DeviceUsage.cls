@istest
public class test_DeviceUsage {
static testMethod void testrest(){
   Profile w = [select id from profile where name='Standard User'];
  User u = new User(alias = 'teggg', email='tes253@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='tes253@noemail.com');
                  insert u;
                  Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
       AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='test123@noemail.com');
     insert attSummarybp;
     Event_Attendee_Mapping__c eam =new Event_Attendee_Mapping__c(AS_id__c=attSummarybp.id,EV_id__c=eve.id);
      insert eam;
      DeviceUsage__c device=new DeviceUsage__c(EV_id__c=eve.id,IMEI__c='12365',OsVersion__c='safari 6',User__c=u.id);
     insert device;
     System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/DeviceUsage';
       RestContext.request.addParameter('QRcode',eam.id);
       RestContext.request.addParameter('EventId',eve.id);
       RestContext.request.addParameter('UserID', u.Id);
       RestContext.request.addParameter('OSversion', 'safari 6');
       RestContext.request.addParameter('IMEI', '12365');
       DeviceUsage.doGet();
        device.IMEI__c=null;
        update device;
         DeviceUsage.doGet();
  
  }
  }