@isTest
public class Test_GenericEvent{

public static testMethod void testrest(){


contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'testq3pq', email='test123pq@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123pq@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c customProfileBooth= new Profile__c (PR_Name__c='Attendee',PR_Version__c='4.0');        
       insert  customProfileBooth; 
   
   Event__c eve = new Event__c(EV_Title__c='Generic Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      
      
      
      Event__c eve2 = new Event__c(EV_Title__c='Generic Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve2;
      
      
      Id EventId=eve.Id;
      
      Booth__c booth1 = new Booth__c(BT_Name__c='TestBooth1',BT_BoothUserCount__c=100);
      insert booth1;
      
      //User_Profile_Event__c upebooth = new User_Profile_Event__c(BT_id__c=booth1.Id,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      //insert upebooth; 
   
   AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='test',AS_LastName__c='boothadmin',AS_Email__c='test123@noemail.com');
   insert attSummarybp;
   
   string name='sri,global';
   
    string attendeeEvent= string.valueOf(attSummarybp.Id)+string.valueOf(EventId);   
   
    Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummarybp.Id,Attendee_Event_IDs__c=attendeeEvent);
    insert event_att_map ;
    update event_att_map;
    
   /* AttendeeSummary__c attSummarybp2 = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='test',AS_LastName__c='boothadmin',AS_Email__c='test123@noemail.com');
   insert attSummarybp2;
   
    string attendeeEvent2= string.valueOf(attSummarybp2.Id)+string.valueOf(EventId);
    
    Event_Attendee_Mapping__c event_att_map1 = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummarybp2.Id,Attendee_Event_IDs__c=attendeeEvent2);
    update event_att_map1 ;
   */
   
    BoothVisitSummary__c boothVisitSummary= new BoothVisitSummary__c(BVS_LeadRating__c=4.4,Follow_Update__c=datetime.valueOf('2012-05-15 00:00:00'),ScanTime__c=datetime.valueOf('2012-05-15 00:00:00'),BVS_FirstName__c='Scan',BVS_LastName__c='Me',BVS_Email__c='test123@noemail.com',EA_AttendeeBarcode__c=event_att_map.Id,User_id__c=u.Id);
    insert boothVisitSummary;
   
    //User_Event_BVS__c  use_Eve_BVS = new User_Event_BVS__c(BVS_id__c=boothVisitSummary.Id,EV_id__c=EventId,UPE_id__c=upebooth.Id);
     //insert use_Eve_BVS;
      
     // Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummarybp.Id,Attendee_Event_IDs__c=attendeeEvent,EA_AttendeeBarcode__c='');
   // insert eam ;
      
      system.runas(u){
      System.RestContext.request = new RestRequest();
      RestContext.request.requestURI = '/GlobalnestEM/GenericEvent';
     // RestContext.request.addParameter('EventId',EventId);
      //RestContext.request.addParameter('Assid',attSummarybp.id);
      
      RestContext.request.addParameter('adminEid','test123pq@noemail.com');
      RestContext.request.addParameter('leadEid','abcpq@xtrx.vom');
      RestContext.request.addParameter('leadName','ablc,xyz');
      GenericEvent.doGet();
        
     AttendeeSummary__c attSummarybp1 = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='test',AS_LastName__c='boothadmin',AS_Email__c='abc1@xtrx.vom');
   insert attSummarybp1;
   
     RestContext.request.addParameter('adminEid','test123pq@noemail.com');
      RestContext.request.addParameter('leadEid','abc1pq@xtrx.vom');
      RestContext.request.addParameter('leadName','ablc,xyz');
      GenericEvent.doGet();
        
        
}

}

}