public with sharing class BLN_ItemPool_DAO {
    
    
        public LIST<Item_Pool__c> getPoolsOfevent(string eventid){
        
          if(eventid!=null && eventid!=''){
            LIST<Item_Pool__c> itemPools = [SELECT (SELECT id,item_type__c,Item_status__c,item_name__c,Event__c,item_type__r.Name,Item_Pool__r.Item_Type__r.name FROM Items__r limit 1),Item_Type__r.Name,ID, NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                             Addon_Parent__c,Addon_Count__c
                                                      FROM Item_Pool__c 
                                                      WHERE Event__c=:eventid and Item_Type__r.Name!='Scan Attendee'];
            
            return itemPools;
         }
         return null;
        }

     //This is For Insert ItemPool to dataBase
        public LIST<Item_Pool__c> getPoolsBlongthatevent(string eventid){
        
          if(eventid!=null && eventid!=''){
            LIST<Item_Pool__c> itemPools = [SELECT Item_Type__r.Name,ID, NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                             Addon_Parent__c,Addon_Count__c
                                                      FROM Item_Pool__c 
                                                      WHERE Event__c=:eventid];
            
            return itemPools;
         }
         return null;
        }
    
    
    //This is For Insert ItemPool to dataBase
        public LIST<Database.UpsertResult> createItemPools(LIST<Item_Pool__c> itemPool){
            
             LIST<Database.UpsertResult> itemPoolRes = DataBase.upsert(itemPool, FALSE);
 
            return itemPoolres;
        }
        
        
        //Fetching List of Item Pools
        public LIST<Item_Pool__c> givesItemPools(List<String> itemPool){
            
            LIST<Item_Pool__c> itemPoolAfterUpdate = [SELECT Item_Type__r.Name,ID,Badgable__c, NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                             Addon_Parent__c,Addon_Count__c
                                                      FROM Item_Pool__c 
                                                      WHERE ID IN: itemPool];
            
            return itemPoolAfterUpdate;
        }
        
        //Fetching List of Package Item Pools
        public LIST<Item_Pool__c> getPackageItemPools(List<String> itemPool){
            
            LIST<Item_Pool__c> itemPoolList = [SELECT ID, NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                             Addon_Parent__c,Addon_Count__c
                                                      FROM Item_Pool__c 
                                                      WHERE Addon_Parent__c IN: itemPool];
            
            return itemPoolList;
        }
        
        
        public Item_Pool__c getItempool(String wherecondition)
        {
        Item_Pool__c ip=new Item_Pool__c();
         String queryString='select Id,Name,Item_Pool_Name__c,Event__c,Item_Count__c,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,Package_Flag__c,Item_Type__c,Badge_Label__c,Badgable__c,Addon_Parent__c,uniqueNumber__c,Addon_Count__c from  Item_Pool__c '+wherecondition;   
         try{
         ip = dataBase.query(queryString);
         }catch(Exception e){}
         return ip;
        }
        
        public list<Item_Pool__c> getitempoollist(String eventid,datetime lsmdate){
        
        list<Item_Pool__c> ip=new list<Item_Pool__c>();
        
        ip=[select id,Badgable__c,Event__c,lastmodifieddate from Item_Pool__c where Event__c=:eventid AND Badgable__c='N - No Badge' AND lastmodifieddate > :lsmdate];
       
        return ip;
        }
        
    }