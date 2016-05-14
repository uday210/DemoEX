@RestResource(urlMapping='/getExibitors/*')

global without sharing class getExibitors{
  

  global static string eventId{get;set;}
  
  
 @httpPost
  global static AllDetails doPost(){
   RestRequest req =Restcontext.request;
   RestResponse res =Restcontext.response;
     
     eventId = req.params.get('EventId');
     AllDetails alDetail = new AllDetails();
     
     for(EventSchedule__c eveSc :[Select e.Name, e.Id, e.EV_id__c,e.EV_id__r.EV_Title__c, e.ES_StartTime__c, e.ES_StartDate__c, e.ES_ProgramName__c, e.ES_Presenter__c, e.ES_Location__c, e.ES_EndTime__c, e.ES_EndDate__c, e.ES_Description__c From EventSchedule__c e where EV_id__c =:eventId and ES_StartDate__c!=null  order by ES_StartDate__c,ES_StartTime__c ASC]){
     GlobalUtillClass.EventSchedule Geventscdules = new GlobalUtillClass.EventSchedule(eveSc);  
     alDetail.EventSchedule.add(Geventscdules);
    }
    
    
    Set<id> setids = new SET<id>();
    for(User_Profile_Event__c upes:[Select u.User_id__c, u.Profile_id__c, u.EV_id__c,EV_id__r.owner.name,BT_id__c From User_Profile_Event__c u where EV_id__c=:eventId and BT_id__c !=null AND Profile_id__r.PR_Name__c='BoothAdmin']){
       setids.add(upes.BT_id__c);
    
    }
    
    List<Booth__c> boo = new List<Booth__c>();
    boo = [Select id,BT_Name__c,BT_Description__c,BT_ContactName__c,BT_ContactEmail__c,BT_ContactPhone__c,BT_WebsiteURL__c,BT_Location__c, BT_PDFLocation__c,BT_RegistrationLink__c,BT_Phone__c,EV_id__c,EV_id__r.EV_Title__c from Booth__c where ID IN :setids and BT_ContactName__c!=null and BT_ContactName__c!='' order by createddate];
     Set<Booth__c> setboo = new SET<Booth__c>();
     setboo.addAll(boo);
   
     List<Booth__c> booo = new List<Booth__c>();
   booo.addAll(setboo);
    for(Booth__c booths :booo){
     GlobalUtillClass.BoothDetails Gbooths = new GlobalUtillClass.BoothDetails(booths); 
     alDetail.Exhibitors.add(Gbooths);
     
    }
    
   return alDetail ; 
     }
     
     
global class AllDetails{
List<GlobalUtillClass.EventSchedule> EventSchedule = new List<GlobalUtillClass.EventSchedule>();
List<GlobalUtillClass.BoothDetails> Exhibitors = new List<GlobalUtillClass.BoothDetails>();
 }   
 }