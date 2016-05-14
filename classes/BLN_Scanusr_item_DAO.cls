public with sharing class BLN_Scanusr_item_DAO {
  public List<BLN_Scanusr_item__c> getUserScanItems(String uId,String eventId){
     return [SELECT id,BLN_Event__c,BLN_GN_User__c,BLN_Item_Pool__c,Status__c FROM BLN_Scanusr_item__c WHERE BLN_Event__c=:eventId and BLN_GN_User__c=:uId and Status__c!='Cancel'];
  }	

  public List<BLN_Scanusr_item__c> getUsrScanItms(String uId,String eventId){
     return [SELECT id,BLN_Event__c,BLN_GN_User__c,BLN_Item_Pool__c,Status__c FROM BLN_Scanusr_item__c WHERE BLN_Event__c=:eventId and BLN_GN_User__r.User__c=:uId and Status__c!='Cancel'];
  }	
}