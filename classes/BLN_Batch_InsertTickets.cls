global without sharing class BLN_Batch_InsertTickets implements Database.Batchable<sObject>{
//map of contactid - contact
public Set<Id> poolids{get;set;}

global BLN_Batch_InsertTickets(Set<Id> poolidstemp) {
this.poolids=poolidstemp;
}
global Database.QueryLocator start(Database.BatchableContext BC) {
return DataBase.getQueryLocator([select id,name,Item_Type__c,Parent_ID__c,Item_Pool__c,Item_Pool__r.Badge_Label__c,Item_Pool__r.Item_Type__c,Badge_Label__c from Ticket__c where Item_Pool__r.id IN :poolIds]);
}
global void execute(Database.BatchableContext BC,List<Ticket__c> tcklist) {
      for(integer i=0;i<tcklist.size();i++)
  {
    System.debug('tcklist[i].Item_Pool__r.Item_Type__c'+tcklist[i].Item_Pool__r.Item_Type__c);
    if(tcklist[i].Parent_ID__c==null){
     tcklist[i].Item_Type__c=tcklist[i].Item_Pool__r.Item_Type__c;
     
     }
     tcklist[i].Badge_Label__c=tcklist[i].Item_Pool__r.Badge_Label__c;
    }
    
     if(tcklist.size()>0)
              DataBase.update(tcklist,false);
       
}
global void finish(Database.BatchableContext BC) {
}
}