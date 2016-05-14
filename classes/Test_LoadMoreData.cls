@isTest
public class Test_LoadMoreData{

public static testMethod void testdoget(){

contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
  
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 't123ye', email='test123ye@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123ye@noemail.com', FaceBookId__c='596207599');
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
 
 
  AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
     insert attSummary;
     string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(EventId);   
     
     Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
     insert event_att_map ;           
     
     Event_Attendee_Mapping__c getEvent_att_map = new Event_Attendee_Mapping__c ();
     getEvent_att_map  =[select id,Attendee_Event_IDs__c,EV_id__c,AS_id__c from Event_Attendee_Mapping__c  where Id=:event_att_map.Id];
     
     getEvent_att_map  .EA_AttendeeBarcode__c =string.valueOf(event_att_map.Id)+'-'+string.valueOf(EventId);            
     update getEvent_att_map  ;          
     system.debug('----------------------- '+event_att_map);
                
     BoothVisitSummary__c boothVisitSummary= new BoothVisitSummary__c(BVS_LeadRating__c=4.4,Follow_Update__c=datetime.valueOf('2012-05-15 00:00:00'),ScanTime__c=datetime.valueOf('2012-05-15 00:00:00'),BVS_FirstName__c='Scan',BVS_LastName__c='Me',BVS_Email__c='testboothadmin@noemail.com',EA_AttendeeBarcode__c=getEvent_att_map.Id,User_id__c=eventAdminId);
     insert boothVisitSummary;
 
    system.runas(u){
    
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/LoadMoreData';
       RestContext.request.addParameter('UserName', 'test123ye@noemail.com');
       RestContext.request.addParameter('EventId',eve.id);
       RestContext.request.addParameter('lastRecordId','');
       LoadMoreData.doPost();
    
    }
   
 
 
 }
 
 
 }