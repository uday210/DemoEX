@RestResource(urlMapping='/KSK_EventSpeakers/*')

global without sharing class KSK_EventSpeakers{

  global static string eventId{get;set;}  
  
  @httpPost
  global static AllDetails doPost(){
     RestRequest req =Restcontext.request;
     RestResponse res =Restcontext.response;
     
     eventId = req.params.get('eveid');
     system.debug('eventId ================= '+eventId );
     AllDetails alDetail = new AllDetails();

      
     List<Seminar__c> sems = new List<Seminar__c>();
     sems = [Select id, Name, Cost__c, Date__c, Description__c, End_Time__c, Max_no_of_people__c, Speaker__c, Start_Time__c, 
             Track__r.Name, Spk_DesigAndDept__c, Spk_SeminarRole__c, Spk_Company__c, Spk_image__c
             from Seminar__c where Track__r.Event__c =:eventId ];
      system.debug(sems.size());     

    for(Seminar__c sem :sems){
     GlobalUtillClass.KSKSpeakers seminors = new GlobalUtillClass.KSKSpeakers(sem); 
     alDetail.Speakers.add(seminors);     
    }  
      
      
    
   return alDetail ; 
     }
     
     
  global class AllDetails{
     List<GlobalUtillClass.KSKSpeakers> Speakers = new List<GlobalUtillClass.KSKSpeakers>();
  }   
 }