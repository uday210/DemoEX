@RestResource(urlMapping='/KSK_EventSchedule/*')

global without sharing class KSK_EventSchedule{
  

  global static string eventId{get;set;}
  
  
 @httpPost
  global static AllDetails doPost(){
   RestRequest req =Restcontext.request;
   RestResponse res =Restcontext.response;
     
     eventId = req.params.get('eveid');
     system.debug('eventId ================= '+eventId );
     AllDetails alDetail = new AllDetails();

     LIST<EventSchedule__c > eveSc = new LIST<EventSchedule__c >();
     eveSc = [Select e.Name, e.Id, e.EV_id__c,e.EV_id__r.EV_Title__c, e.ES_StartTime__c, e.ES_StartDate__c, 
                                 e.ES_ProgramName__c, e.ES_Presenter__c, e.ES_Location__c, e.ES_EndTime__c, e.ES_EndDate__c, 
                                 e.ES_Description__c From EventSchedule__c e 
                                 where EV_id__c =:eventId and ES_StartDate__c!=null AND Is_Matchmaking__c = FALSE
                                 order by ES_StartDate__c,ES_StartTime__c ASC];
     for(EventSchedule__c evschs : eveSc ){
       if(evschs.ES_ProgramName__c != null){
           GlobalUtillClass.KSKEventSchedule Geventscdules = new GlobalUtillClass.KSKEventSchedule(evschs);  
           alDetail.EventSchedule.add(Geventscdules);
       }         
     }
    
   return alDetail ; 
     }
     
     
global class AllDetails{
List<GlobalUtillClass.KSKEventSchedule> EventSchedule = new List<GlobalUtillClass.KSKEventSchedule>();
 }   
 }