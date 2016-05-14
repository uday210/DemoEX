@RestResource(urlMapping='/EVENTSCHEDULE/*')

/*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : EVENTSCHEDULE is for  getting EventSchedule Information
 */

    global with sharing class EventSchedule {
    
    global static String EventId;
        
    global static String UserID;    
    
    global static List<EventSchedule__c> EventSchedule1 = new List<EventSchedule__c>();
    
    global static List<EventSchedule2> EventSchedule3 = new List<EventSchedule2>();
      
    @HttpGet
    
    global static List<EventSchedule2> doGet(){
    
    
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    System.debug('@@@@@req'+req);
    
    EventId = req.params.get('EventId');
    
    System.debug('@@@@@EventId'+EventId);
    
    UserID  = req.params.get('UserID');
        
        
        try{
         User u = [select Email,username from User where id =:UserID];
            System.debug('@@@@@u'+u);
          Event_Attendee_Mapping__c Emap = [select id from  Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c=:u.Email];        
               System.debug('@@@@@Emap'+Emap);
        }
        
        catch(Exception ex) {
            
   EventSchedule2 ES2 = new EventSchedule2('You are not registered to this event');
            
    System.debug('@@@@@ES2'+ES2);
        EventSchedule3.add(ES2);
            
            return EventSchedule3;
        }
        
        
    
    EventSchedule1 = [Select id,ES_Description__c,ES_EndDate__c,ES_EndTime__c,ES_Location__c,ES_Presenter__c,ES_ProgramName__c,ES_StartDate__c,ES_StartTime__c
    
                       From EventSchedule__c where EV_id__r.id =:EventId order by ES_StartDate__c];
    
    
    System.debug('@@@@@EventSchedule1'+EventSchedule1);
    
        if(EventSchedule1.size() == 0){
            
          EventSchedule2 ES2 = new EventSchedule2('The Schdule is in Progress!');
            
    System.debug('@@@@@ES2'+ES2);
        EventSchedule3.add(ES2);
            
        }
    
        
    For(EventSchedule__c ES:EventSchedule1){
        
        EventSchedule2 ES2 = new EventSchedule2(ES.ES_ProgramName__c,ES.ES_Description__c,ES.ES_Location__c,ES.ES_Presenter__c,ES.ES_StartDate__c,ES.ES_EndDate__c,ES.ES_StartTime__c,ES.ES_EndTime__c);
        
        System.debug('@@@@@ES2'+ES2);
        
        EventSchedule3.add(ES2);
        
    }
    
    
    return EventSchedule3;
    
    
    }
    
    
    global class EventSchedule2{
        
        
        global string Message;
        global String ProgramName;
        
        global String Description;
        
        global  String Location;
        
        global String Presenter;
        
        global Date StartDate;
        
        global Date EndDate;
    
       global String StartTime;
       
       global String EndTime;
       
        
        global EventSchedule2(String Message1){
            Message= Message1;
        }
        
        
        global EventSchedule2(String ProgramName1,String Description1,String Location1,String Presenter1,Date StartDate1,Date EndDate1,String StartTime1,String EndTime1){
            
            ProgramName = ProgramName1;
            
            Description = Description1;
            
            Location  = Location1;
            
            Presenter = Presenter1; 
            
            StartDate = StartDate1;
            
            EndDate  =   EndDate1;
            
            StartTime =  StartTime1;
            
            EndTime   =  EndTime1;
        
            
        }
        
        
    }
    
    
     static testMethod void testRest(){
 
 contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
       insert m;
       Profile w = [select id from profile where name='Standard User'];
       user u= new User(alias = 'busers', email='boothadmin@boothleads.com',
       emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
       localesidkey='en_US',country='United States',
       timezonesidkey='America/Los_Angeles', username='boothadmin@boothleads.com',CompanyName='Nest',Title='dev');
       insert u;
       System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
       u.password__c =rt.getPassword();
   
       update u;
       string pwd =rt.getPassword();
      
            
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
      
    
      EventSchedule__c es = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', ES_EndDate__c = Date.Parse('01/18/2014'),
                                                ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                ES_Description__c='Hello Test Desc', ES_EndTime__c='09:30 AM', ES_Location__c='Hello Loc', 
                                                ES_Presenter__c ='Arjun', EV_id__c =eve.id );
    
    insert es;
      
       Booth__c booth2 = new Booth__c(EV_id__c=eve.id,BT_Name__c='TestBoothup2',BT_BoothUserCount__c=100);
    insert booth2;
      
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/EVENTSCHEDULE';
       RestContext.request.addParameter('UserID', u.Id);
       RestContext.request.addParameter('EventId',eve.Id);
            
       EVENTSCHEDULE.doGet();
      EventSchedule2 esd=new EventSchedule2('Message1');
 }
 
    
    
    
    
    
    }