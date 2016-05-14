public with sharing class BLN_EventOptions_DAO {
    
    
    
    public MAP<ID, Event_Price__c> queryEventOptions(String eventid){
        
         MAP<ID, Event_Price__c> itemTypeEventPrice = new MAP<ID, Event_Price__c>();
        
        for(Event_Price__c ep: [SELECT ID,Event__c, Name,Item_Count__c, BL_Fee_Amount__c, BL_Fee_Level__c, BL_Fee_Percentage__c, Item_type__c, Item_type__r.Event_Option_Desc__c FROM Event_Price__c WHERE BL_Fee_Level__c ='E - Event' and Event__c=:eventid ]){
            itemTypeEventPrice.put(ep.Id, ep);
        }
        
        return itemTypeEventPrice;
    }
    
    

}