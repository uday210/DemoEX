public with sharing class BLN_EventDocuments_Dao {
    public List<BLN_Event_Document__c> getDocs(String eventId) {
     return [SELECT type__c,lastmodifiedDate,id,Address__c,Name,BLN_Events__c,Image__c,Url__c,(SELECT lastmodifiedDate,isDeleted,id from Attachments) from BLN_Event_Document__c Where BLN_Events__c=:eventId];        
    }
}