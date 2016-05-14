@istest

public class Test_VERIFYLEAD{


 static testMethod void resttest(){
   Profile w = [select id from profile where name='Standard User'];
   user bu2 =  new User(alias = 'busers', email='buser2@badmin.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='buser2@badmin.com',CompanyName='Nest',Title='dev');
                  insert bu2;
                  
  Event__c evebu1 = new Event__c(EV_Title__c='Global evebu1 ',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert evebu1 ;
      AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='buser@badmin.com');
     insert attSummarybp;
     Event_Attendee_Mapping__c eam =new Event_Attendee_Mapping__c(AS_id__c=attSummarybp.id,EV_id__c=evebu1.id);
      insert eam;
      User_Profile_Event__c upee=new User_Profile_Event__c(EV_id__c = evebu1.id,User_id__c = bu2.id ,Attendee_Summary__c = attSummarybp.id );
      insert upee;
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/VERIFYLEAD';
       RestContext.request.addParameter('QRcode',eam.id);
       RestContext.request.addParameter('EventId',evebu1.id);
       RestContext.request.addParameter('UserId', bu2.Id);
       VERIFYLEAD.doPost();
  }




}