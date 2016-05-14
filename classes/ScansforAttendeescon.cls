public without sharing class ScansforAttendeescon {
/**********************************
Author: Unni Krishna
Purpose: to show the count of scans for Each attendee in an event
Date created: 5 Aug,2015
**********************************/


//****************Variable Declaration starts****************
public List<Event_Attendee_Mapping__c> eamlist{get;set;}
public List<BoothVisitSummary__c> bvslist{get;set;}
public string eventid{get;set;}
//****************Variable Declaration starts****************


  //************Constructor starts*********
  public ScansforAttendeescon()
  {
  eventid=Apexpages.CurrentPage().getParameters().get('id'); 
   eamlist=[SELECT id,AS_id__c,AS_id__r.AS_Company__c,AS_id__r.As_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkPhone__c,(SELECT id,BVS_FirstName__c,BVS_Email__c,BVS_Company__c, BVS_LastName__c,ScanTime__c,BVS_Title__c,BVS_PhoneNumber__c from BoothVisitSummary__r) from Event_Attendee_Mapping__c where EV_id__r.id=: eventid ];
  
  }
  
  //************Constructor Ends*********
  
  //public AggregateResult[] countofvisits{
       //get {
       //    return [SELECT id,AS_id__c,AS_id__r.AS_Company__c,AS_id__r.As_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkPhone__c,(SELECT count(id) c,MAX(BVS_FirstName__c) f,MAX(BVS_Email__c) e,MAX(BVS_Company__c) c, MAX(BVS_LastName__c) l,MAX(ScanTime__c) s,MAX(BVS_Title__c) t,MAX(BVS_PhoneNumber__c) p from BoothVisitSummary__r) from Event_Attendee_Mapping__c where EV_id__r.id=: eventid ];
          // count(id) c,MAX(Scanee_User__r.Phone__c) p,MAX(Scanee_User__r.Default_Company_ID__r.Name) co,MAX(Scanee_User__r.First_Name__c) f,MAX(Scanee_User__r.Last_Name__c) l,MAX(Scanee_User__r.Email__c) e from Lead_Scan__c where Event__c =:selectedeventid group by Scanee_User__c ORDER BY count(id) DESC];
      // }
   //}
}