//Added by Arindam
//Use:Update ItemType and badge labels for all tickets if the itemtype changes in pool
//Created Date:12/02/2015
//Modified Date:12/02/2015

trigger updateTicketTypeandLabel on Item_Pool__c (after update) {
SET<id> poolIds= new SET<id>(); 
    for(Item_Pool__c itempool:trigger.new){
   
      Item_Pool__c olditempool = Trigger.oldMap.get(itempool.Id);
    // Check that the field was changed
    if (olditempool.Item_Type__c!=itempool.Item_Type__c||olditempool.Badge_Label__c!=itempool.Badge_Label__c) {
      poolIds.add(itempool.id); 
    }
   
   }
   List<Ticket__c> tckList = new List<Ticket__c>();
   tckList =[select id,name,Item_Type__c,Parent_ID__c,Item_Pool__c,Item_Pool__r.Badge_Label__c,Item_Pool__r.Item_Type__c,Badge_Label__c from Ticket__c where Item_Pool__r.id IN :poolIds];
  
  for(integer i=0;i<tcklist.size();i++)
  {
    System.debug('tcklist[i].Item_Pool__r.Item_Type__c'+tcklist[i].Item_Pool__r.Item_Type__c);
    if(tcklist[i].Parent_ID__c==null){
     tcklist[i].Item_Type__c=tcklist[i].Item_Pool__r.Item_Type__c;
     
     }
     tcklist[i].Badge_Label__c=tcklist[i].Item_Pool__r.Badge_Label__c;
    }
    
     if(tcklist.size()>0){
        if(tcklist.size()<=9000)
              DataBase.update(tcklist,false);
              else{
              Database.executeBatch(new BLN_Batch_InsertTickets(poolids), 2000);
              }
              
            }
}