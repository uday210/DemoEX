@RestResource(urlMapping='/EVENTEXHIBITORS/*')

   /*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : EVENTEXHIBITORS is for Ehibitors(Booth Admin) Information 
 */  


    global with sharing class EVENTEXHIBITORS {
    
      
   global static String EventId;
        
   global static String UserID; 
   
   
   
    
   global static List<Booth> Booth1 = new List<Booth>();   
   
      @HttpGet
    
    global static List<Booth>  doGet(){
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    System.debug('@@@@@req'+req);
    
    EventId = req.params.get('EventId');
    
    System.debug('@@@@@EventId'+EventId);
    
    UserID  = req.params.get('UserID');
   System.debug('@@@@@UserID'+UserID);
    
    try{
         User u = [select Email,username from User where id =:UserID];
            System.debug('@@@@@u'+u);
          Event_Attendee_Mapping__c Emap = [select id from  Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c=:u.Email AND  EV_id__r.id =:EventId limit 1];        
               System.debug('@@@@@Emap'+Emap);
        }
        
      catch(Exception ex) {
     
     Booth b1 = new Booth('You are not registered to this event');
            
    System.debug('@@@@@b1'+b1 );
  
    Booth1.add(b1);         
          
     return Booth1;
        }  
    
    
    try{
    
    List<Booth__c> booth2 =[Select id,BT_Name__c,BT_Description__c,BT_ContactName__c,BT_ContactEmail__c,BT_ContactPhone__c,BT_WebsiteURL__c from Booth__c where EV_id__r.id=:EventId];
     
    System.debug('@@@@@booth2'+booth2);
    
    For(Booth__c Bo :booth2){
    
    Booth b2 = new Booth(BO.id,Bo.BT_Name__c,Bo.BT_Description__c,Bo.BT_ContactName__c,Bo.BT_ContactPhone__c,Bo.BT_ContactEmail__c,BO.BT_WebsiteURL__c);
    
    System.debug('@@@@@b1'+b2);
  
    Booth1.add(b2);         
          
     
    
    }
    return Booth1;
    }
    catch(Exception ex){
    
      
    Booth b1 = new Booth('No boths available!');
            
    System.debug('@@@@@b1'+b1 );
  
    Booth1.add(b1);         
          
     return Booth1;
    
    
    }
    
     return null;
    
    }
    
    
    global class Booth{
    
    Id Booth_ID;
    //Id Booth_Product_ID;
    String Booth_Name;
    String Booth_Description;
    String Booth_ContactName;
    String Booth_ContactPhoneNo;
    String Booth_ContactEmail;
    String Booth_Website;
    String Message;
    
    
    global Booth(String Message1){
    
      Message = Message1;
    }
    
    
    global Booth(Id Booth_ID1, String Booth_Name1, String Booth_Description1, String Booth_ContactName1,String Booth_ContactPhoneNo1,String Booth_ContactEmail1,String Booth_Website1){
    
    
    Booth_ID = Booth_ID1;
    
    //Booth_Product_ID = Booth_Product_ID1;
    
    Booth_Name = Booth_Name1;
    
    Booth_Description = Booth_Description1;
    
    Booth_ContactName = Booth_ContactName1;
    
    Booth_ContactPhoneNo = Booth_ContactPhoneNo1;
    
    Booth_ContactEmail = Booth_ContactEmail1;
    
    Booth_Website = Booth_Website1;
    
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
       RestContext.request.requestURI = '/GlobalnestEM/EVENTEXHIBITORS';
       RestContext.request.addParameter('UserID', u.Id);
       RestContext.request.addParameter('EventId',eve.Id);
       
       EVENTEXHIBITORS.doGet();
       Booth bo = new Booth('Message1');
       delete event_att_map ;
       EVENTEXHIBITORS.doGet();
 }
  
  
   
   
    
    }