public with sharing class BL_EventSheduleCon {

public string eventId{get;set;}
public List<EventSchedule__c> eventSchedule{get;set;}
public List<EventSchedule__c> eventSchedule1{get;set;}
public List<EventSchedule__c> eventSchedule2{get;set;}


public BL_EventSheduleCon (){
eventId =Apexpages.currentPage().getParameters().get('id');
eventSchedule = new List<EventSchedule__c>();
eventSchedule1 = new List<EventSchedule__c>();
eventSchedule2 = new List<EventSchedule__c>();
try{
 for(EventSchedule__c es:[select ES_Description__c,ES_EndDate__c,ES_EndTime__c,EV_id__c,ES_Location__c,
ES_Presenter__c,ES_ProgramName__c,ES_StartDate__c,ES_StartTime__c from EventSchedule__c where EV_id__c=:eventId and ES_StartDate__c!=null and ES_StartTime__c != null order by ES_StartTime__c ]){
   
   if(es.ES_StartDate__c.day()==24){
      eventSchedule1.add(es);
    }else{
     eventSchedule2.add(es);
   }
  }
  }catch(exception e){}
  
  List<EventSchedule__c> list1 = new List<EventSchedule__c>();
  List<EventSchedule__c> list2 = new List<EventSchedule__c>();
  
  
 // day 1 schedule sorting   
  for(EventSchedule__c d1:eventSchedule1){
   if((d1.ES_StartTime__c).contains('AM')){
    list1.add(d1);
    }else{
    list2.add(d1); 
   }
  }
  
  eventSchedule1 = new List<EventSchedule__c>();
  eventSchedule1.addAll(list1);
  eventSchedule1.addAll(list2);
  system.debug('11111111111111 '+eventSchedule1);
  // day 2 schedule sorting   
   List<EventSchedule__c> list3 = new List<EventSchedule__c>();
  List<EventSchedule__c> list4 = new List<EventSchedule__c>();
  for(EventSchedule__c d1:eventSchedule2){
   if((d1.ES_StartTime__c).contains('AM')){
    list3.add(d1);
    }else{
    list4.add(d1); 
   }
  }
  
  eventSchedule2 = new List<EventSchedule__c>();
  eventSchedule2.addAll(list3);
  eventSchedule2.addAll(list4);
  
  
 }

}