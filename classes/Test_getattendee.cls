@isTest
public without sharing  class Test_getattendee{

public static TestMethod Void testDoGet(){

  
  contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
   insert m;
       Profile w = [select id from profile where name='Event Admin'];
  
  Profile w1 = [select id from profile where name='System Administrator'];
  
  User u = new User(alias = 'test1234', email='test1234@noemail.com',
                 emailencodingkey='UTF-8',profileid = w1.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com');
                  insert u;
                
  
    //system.runas(u1){      
  
   // ------------------ Eventadmin Insert ---------------------
     /**   User u = new User(alias = 'test123', email='test123@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=m.id,
                  timezonesidkey='America/Los_Angeles', username='test123@noemail.com');
                  insert u;**/
                  
                  Id eventAdminId=u.id;    
 
 
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
     
      Id EventId=eve.Id;


     AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
     insert attSummary;
     
     
     string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(EventId);   
     
     Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
     insert event_att_map ;           
     
     string idvalue =event_att_map.id;
     
     Event_Attendee_Mapping__c getEvent_att_map = new Event_Attendee_Mapping__c ();
     getEvent_att_map  =[select id,Attendee_Event_IDs__c,EV_id__c,AS_id__c from Event_Attendee_Mapping__c  where Id=:event_att_map.Id];
     
     getEvent_att_map .EA_AttendeeBarcode__c =string.valueOf(event_att_map.Id)+'-'+string.valueOf(EventId);            
     update getEvent_att_map  ;          
     system.debug('----------------------- '+event_att_map);
      
    
      System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/getattendeeforRegistration';
       RestContext.request.addParameter('EventId', eve.Id);
       RestContext.request.addParameter('UserName',u.UserName);
             
       getattendee.doGet();
      // }
    }
}