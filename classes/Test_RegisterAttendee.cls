@isTest
public without sharing  class Test_RegisterAttendee{

public static TestMethod Void testDoGet(){
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
                
  
    //system.runas(u1){      
  
   // ------------------ Eventadmin Insert ---------------------
       User u1 = new User(alias = 'test123', email='test123@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=m.id,password__c='cpkn1234',
                  timezonesidkey='America/Los_Angeles', username='test123@noemail.com');
                  insert u1;
                  
                  Id eventAdminId=u.id;    
 
 
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
     
      Id EventId=eve.Id;


     AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='test123@noemail.com');
     insert attSummary;
     
     
     string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(EventId);   
  //   Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
     //insert event_att_map ;           
    //  string idvalue =event_att_map.id;
     
    // Event_Attendee_Mapping__c getEvent_att_map = new Event_Attendee_Mapping__c ();
   //  getEvent_att_map  =[select id,Attendee_Event_IDs__c,EV_id__c,AS_id__c from Event_Attendee_Mapping__c  where Id=:event_att_map.Id];
     
   //  getEvent_att_map .EA_AttendeeBarcode__c =string.valueOf(event_att_map.Id)+'-'+string.valueOf(EventId);            
   //  update getEvent_att_map  ;          
    // system.debug('----------------------- '+event_att_map);
      
    Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
    insert  customProfileBooth;
   
   Profile__c pro= new Profile__c (PR_Name__c='Attendee',PR_Version__c='1.5');        
    insert  pro;
   
      //  Profile__c pro =[select id from Profile__c where PR_Name__c='EventAdmin'];
      
       User_Profile_Event__c upebu1 = new User_Profile_Event__c(EV_id__c=EventId,Profile_id__c=customProfileBooth.Id,Status__c='Active',User_id__c=u1.Id,UEP_isActive__c=true);         
       insert upebu1 ; 
      
      
      
    
      System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/RegisterAttendee';
       RestContext.request.addParameter('FirstName', 'fName');
       RestContext.request.addParameter('LastName','lName');
       RestContext.request.addParameter('Email', 'fname@gmail.com');
       RestContext.request.addParameter('Company','bleads');
       RestContext.request.addParameter('Phone', '666-555-1234');
       RestContext.request.addParameter('Title','developer');
       RestContext.request.addParameter('Action', 'Save');
       RestContext.request.addParameter('EventId', EventId); 
       RegisterAttendee.doGet();
       System.RestContext.request = new RestRequest();
      RestContext.request.requestURI = '/RegisterAttendee';
       RestContext.request.addParameter('FirstName', 'fName');
       RestContext.request.addParameter('LastName','lName');
       RestContext.request.addParameter('Email', 'test123@noemail.com');
       RestContext.request.addParameter('Company','bleads');
       RestContext.request.addParameter('Phone', '666-555-1234');
       RestContext.request.addParameter('Title','developer');
       RestContext.request.addParameter('Action', 'Save');
       RestContext.request.addParameter('EventId', EventId); 
         RegisterAttendee.doGet();
      // }
    }
}