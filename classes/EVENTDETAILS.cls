@RestResource(urlMapping='/EVENTDETAILS/*')

   /*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : EVENTDETAILS is for getting Event Info and Event Schedule Information  
 */  

   


    global with sharing class EVENTDETAILS {
    
    global static String EventId;
        
    global static String UserID;   
    
    global static String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    
   global static String orgId = UserInfo.getOrganizationId();
    global static String  Imageheader =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id=';
    
    global static Event__c EventInfo;    
    
    //global static List<EventDetails1> EventDetails2 = new List<EventDetails1>();

        
    @HttpGet
    
    global static EventDetails1 doGet(){
    
    
    
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
            
   EventDetails1 ES2 = new EventDetails1('You are not registered to this event');
            
    System.debug('@@@@@ES2'+ES2);
        //EventDetails2 .add(ES2);
            
            return ES2;
        }
        
     EventInfo = [Select e.SystemModstamp, e.Status__c, e.StartTime__c, e.SecondaryCategory__c, e.Primary__c, e.OwnerId, e.Name, e.LastModifiedDate, e.LastModifiedById, e.LastActivityDate, e.Lable_Third_Line__c, e.Lable_Secoend_Line__c, e.Lable_First_Line__c, e.IsDeleted, e.Id, e.Event_ZipCode__c, e.Event_Printer__c, e.Event_PostalCode__c, e.EventDiversityValues__c, e.Ev_RequiredFields__c, e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c, e.EV_RedirectURI__c, e.EV_QuickReg__c, e.EV_Publish__c, e.EV_IncludedFields__c, e.EV_HostingZipcode__c, e.EV_HostingTimeZone__c, e.EV_HostingState__c, e.EV_HostingStateNew__c, e.EV_HostingPostalCode__c, e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingFax__c, e.EV_HostingCountry__c, e.EV_HostingCountryNew__c, e.EV_HostedByEventBrite__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.EV_CustomReg__c, e.EV_ContactURL__c, e.CreatedDate, e.CreatedById, e.Attendee_Tags__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c From Event__c e where id=:EventId];   
        
        String Event_Type2;
        
        if(EventInfo.Status__c =='Event Closed' ){
            
            Event_Type2 = 'Past Event';
            
        }
        
        
        else{
              Event_Type2 = 'Upcoming Event';
            
        }
        
        EventInfo.EV_EventLogo__c= Imageheader+EventInfo.EV_EventLogo__c;
       
     EventDetails1  ES2 = new EventDetails1(EventInfo.id,EventInfo.EV_Title__c,EventInfo.EV_StartDate__c,EventInfo.EV_EndDate__c,EventInfo.StartTime__c,EventInfo.EV_EndTime__c,EventInfo.EV_HostingLocation__c,EventInfo.EV_EventLogo__c,EventInfo.Status__c,Event_Type2,EventInfo.EV_HostingZipcode__c,EventInfo.EV_HostingStateNew__c,EventInfo.EV_HostingPhone__c,EventInfo.EV_HostingCountry__c,EventInfo.AS_HostingCity__c,EventInfo.AS_HostingAddr2__c,EventInfo.EV_HistingAddr1__c,EventInfo.EV_Description__c);
      
    System.debug('@@@@@ES2'+ES2);
        //EventDetails2 .add(ES2);
            
            return ES2;
      
        }
        
        
        
        
       global  class EventDetails1{
            
                Id Event_ID;
                String Event_Name;
                Date Event_StartDate;
                Date Event_EndDate;
                String Event_StartHour;
                String Event_EndHour;
                String Event_Location;
                String EventLogoImageURL;
                String Event_Type;
                String Message;
                String Event_ZipCode;
                string status;
                
               
                string Event_HostingState;
                string Event_HostingPhone;
                string Event_HostingCountry;
                string Event_HostingCity;
                string Event_HostingAddr2;
                string Event_HostingAddr1;
                string Event_Description;
                
                
           
                global EventDetails1(){
                    
                }
                
                global EventDetails1(String Message1){
            Message= Message1;
        }
        
                
                global EventDetails1(Id Event_ID1,String Event_Name1,Date Event_StartDate1,Date Event_EndDate1,String Event_StartHour1,String Event_EndHour1,String Event_Location1,String EventLogoImageURL1,String Status1,String Event_Type1,String Event_ZipCode1,string EV_HostingStateNew1,string EV_HostingPhone1,string EV_HostingCountryNew1,string AS_HostingCity1,string AS_HostingAddr21,string EV_HistingAddr11,string Event_Description1){
                    
                    
                    Event_ID = Event_ID1;
                    Event_StartDate = Event_StartDate1;
                    Event_StartHour = Event_StartHour1;
                    Event_EndHour =Event_EndHour1;
                    Event_Location = Event_Location1;
                    EventLogoImageURL = EventLogoImageURL1;
                    Status = Status1;
                    Event_Type = Event_Type1;
                    Event_EndDate = Event_EndDate1;
                    
                    
                    Event_ZipCode=Event_ZipCode1;
                    Event_HostingState=EV_HostingStateNew1;
                    Event_HostingPhone=EV_HostingPhone1;
                    Event_HostingCountry=EV_HostingCountryNew1;
                    Event_HostingCity=AS_HostingCity1;
                    Event_HostingAddr2=AS_HostingAddr21;
                    Event_HostingAddr1=EV_HistingAddr11;
                    Event_Description=Event_Description1;
                    
                    
                }
                                
            }
            
            
            static testMethod void testRest() {
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
      
      
      
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/EVENTDETAILS';
       RestContext.request.addParameter('EventId', eve.Id);
       RestContext.request.addParameter('UserID',u.Id);
       EVENTDETAILS.doGet();
      
       }          
           
            
     
        
        }