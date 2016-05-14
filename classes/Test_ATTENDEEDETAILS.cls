@isTest
public class Test_ATTENDEEDETAILS{

 static testMethod void testRest(){
  contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
       insert m;
       Profile w = [select id from profile where name='Standard User'];
       user u= new User(alias = 'busers', email='boothadmin@boothleads.com',
       emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
       localesidkey='en_US',country='United States',
       timezonesidkey='America/Los_Angeles', username='boothadmin@boothleads.com',CompanyName='Nest',Title='dev');
       insert u;
       try{
       System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
       u.password__c =rt.getPassword();
     
       update u;
     
       string pwd =rt.getPassword();
        }catch(exception e){}
       AttendeeSummary__c attsum = new AttendeeSummary__c(AS_FirstName__c='phani',AS_LastName__c='Testing',AS_Email__c='boothadmin@boothleads.com');
       insert attsum ;
  
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
       EV_EndDate__c = Date.Parse('01/18/2014'),
       EV_StartDate__c = Date.Parse('01/18/2014'),
       EV_EndTime__c='09:00 AM',
       StartTime__c='11:00 AM');
       insert eve;
      
       string attendeeEvent= string.valueOf(attsum.Id)+string.valueOf(eve);
      
       Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=eve.Id,AS_id__c=attsum.Id);
       insert event_att_map ;
       
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/ATTENDEEDETAILS';
       RestContext.request.addParameter('EventId', eve.Id);
       RestContext.request.addParameter('UserID',u.Id);
       ATTENDEEDETAILS.doGet();
       //AttendeeDetails1 ad = new AttendeeDetails1('message');
      
       delete event_att_map;
       ATTENDEEDETAILS.doGet();
       
  
  }
}