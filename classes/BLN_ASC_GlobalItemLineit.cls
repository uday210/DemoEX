public class BLN_ASC_GlobalItemLineit {

   public Map<Id,List<Item_Pool__c>> sendItemsWithpools(LIst<BLN_Item__c> items){
     MAP<Id,List<Item_Pool__c>>  itemWithPools = new Map<Id,List<Item_Pool__c>>();
     List<Id>  pools= new List<Id>();
    // Getting pools witch are in items 
       for(BLN_Item__c iy :items){
         pools.add(iy.Item_Pool__c);
       }

     // Getting all values of itempolls with Query
      BLN_ItemPool_DAO pooldao = new BLN_ItemPool_DAO ();
      MAP<id,Item_Pool__c> poolsList = new MAP<id,Item_Pool__c> ();
       
       for(Item_Pool__c itp : pooldao.givesItemPools(pools)){
           poolsList.put(itp.id,itp); // Adding values to map
       }


       for(BLN_Item__c it : items){
          List<Item_Pool__c>  itemPools= new List<Item_Pool__c>();
          if(it.item_type__r.Name!='Package'){
               itemPools.add(poolsList.get(it.Item_Pool__c)); 
          }else{
              itemPools.add(poolsList.get(it.Item_Pool__c)); 
              itemPools.addAll([SELECT ID,Badgable__c,Package_Flag__c,Badge_Label__c,NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                            Addon_Parent__c,Addon_Count__c,Ticket_Settings__c
                                                     FROM Item_Pool__c 
                                                     WHERE Addon_Parent__c=:it.Item_Pool__c]);
           }
           itemWithPools.put(it.id,itemPools);
          System.debug('PPPPPPPPPPpppp '+itemPools); 
        }
        return itemWithPools; 
   }
   
  
}