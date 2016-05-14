public with sharing class BLN_Scanids {
  // This method will return all existing scanids belongs to event
  public Static SET<integer> existingTcScanIds(String eveId) { 
    SET<integer> uniqNums = new  SET<integer>();
    for (Ticket__c tc : [SELECT Id, Scan_Id__c from Ticket__c where Event__c = :eveId]) {
      if ('' != tc.Scan_Id__c) {
        try {
          uniqNums.add(integer.valueOf(tc.Scan_Id__c));
        } catch (exception ed) {}
      }
    }
    return uniqNums;
  }
}