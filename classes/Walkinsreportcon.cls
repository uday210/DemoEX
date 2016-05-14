public without sharing class Walkinsreportcon {

 
 public list< Event_Attendee_Mapping__c> lieam{get;set;}
 public list< Event_Attendee_Mapping__c> eamexp{get;set;}
 public string selectedEvent{get;set;}
 
 public Walkinsreportcon()
 {
  selectedEvent =Apexpages.CurrentPage().getParameters().get('id'); 
  lieam= new list< Event_Attendee_Mapping__c>();
  lieam=[SELECT id,AS_id__r.id,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_FirstName__c,Createddate,AS_id__r.AS_LastName__c from Event_Attendee_Mapping__c 
         WHERE EV_id__c =:selectedEvent AND Attendee_Source__c='Walk Ins'];
  
 }

 public pagereference export()
 {
  eamexp= new list< Event_Attendee_Mapping__c>();
  eamexp=[SELECT id,AS_id__r.id,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_FirstName__c,Createddate,AS_id__r.AS_LastName__c from Event_Attendee_Mapping__c 
         WHERE EV_id__c =:selectedEvent AND Attendee_Source__c='Walk Ins'];
         
    PageReference pageRef= new PageReference('/apex/Exportwalkins');
    pageRef.setredirect(false);
    return pageRef;   
         
 }


}