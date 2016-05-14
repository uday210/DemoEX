public with sharing class BLN_ItemPool_BAL {
    
    
    public BLN_ItemPool_DAO itemPoolDAO{get; set;} 
    
    public BLN_ItemPool_BAL(){
        itemPoolDAO = new BLN_ItemPool_DAO();
    }
    
    public LIST<Database.UpsertResult> createItemPool(LIST<BLN_ItemType_BAL.ticketsinnerClass> itemPools, String event){
        
         LIST<Item_Pool__c> newItemPools = new LIST<Item_Pool__c>();
         MAP<integer, LIST<Hash_Tag__c>> hashTagsMAPBefore = new MAP<Integer, LIST<Hash_Tag__c>>();
        
        
        for(BLN_ItemType_BAL.ticketsinnerClass tic: itemPools){
        	
        	system.debug('Package Main Ticket ADDDDDDDDDDDDDDDDDD   '+ tic.itemPool);
            
           tic.itemPool.uniqueNumber__c = tic.count;
           
          //If This Ticket having any Hashtags this will be executed.
           if(tic.hashTagsForPool.size() > 0)
                hashTagsMAPBefore.put(tic.count, tic.hashTagsForPool);
           
           if(tic.itemPool.Event__c == null)
              tic.itemPool.Event__c = event;
           
           if(tic.itemPool.Item_Type__c == null)
                tic.itemPool.Item_Type__c = tic.itemTypes.Id;
           
           newItemPools.add(tic.itemPool);
        }
        
        
        
                                                                    //createItemPools
        LIST<Database.UpsertResult> itemPoolRes = itemPoolDAO.createItemPools(newItemPools);
        //Gather Saved Record IDs for Query through "itemPoolSavedIds"
        SET<ID> itemPoolSavedIds = new SET<ID>();
        for(DataBase.Upsertresult res: itemPoolRes){
                if(res.isSuccess())
                    itemPoolSavedIds.add(res.getId());
        }
        
        MAP<integer, String> hashTagsMAPAfter = new MAP<Integer, String>();
        
        for(Item_Pool__c ipl: [SELECT Id, NAME, uniqueNumber__c FROM Item_Pool__c WHERE ID IN: itemPoolSavedIds]){
            if( ipl.uniqueNumber__c != null)
                hashTagsMAPAfter.put(integer.valueOf(ipl.uniqueNumber__c), ipl.Name);
        }
        
        LIST<Hash_Tag__c> allHashTags = new LIST<Hash_Tag__c>();
        
         for(BLN_ItemType_BAL.ticketsinnerClass tic: itemPools){
            
            if(hashTagsMAPBefore.containsKey(tic.count)){
                
                for(Hash_Tag__c h: tic.hashTagsForPool){
                    h.Table_Name__c = 'BLN_Item__c';
                    h.RowId__c = hashTagsMAPAfter.get(tic.count);
                    
                    allHashTags.add(h);
                }
                
            }
            
         }
        
        LIST<DataBase.Saveresult> hashResult = dataBase.insert(allHashTags, FALSE);
        
        return itemPoolRes;
    }
    
    
        
    public LIST<Database.UpsertResult> createPackageItemPool(LIST<BLN_ItemType_BAL.ticketsinnerClass> insertTickets, id eventId  , Item_Type__c admissionItemType, MAP<Decimal, Item_Pool__c> itemPoolAfterUpdateMAP){
        
        LIST<Item_Pool__c> packageLineItemPools = new LIST<Item_Pool__c>();
         
        for(BLN_ItemType_BAL.ticketsinnerClass tic: insertTickets){
            
            Item_Pool__c itp = itemPoolAfterUpdateMAP.get(tic.count);
            system.debug('$$$$$$$$$$$$$$$$$$$$$$    '+ itp);
            
            
            //Insert Package Line Items by taking package line Items...............................
             
            for(BLN_ItemType_BAL.ItemPoolTags  blnEve: tic.itemPoolTags ){
            	
            	if(blnEve.itemPool.Event__c == null){
                    blnEve.itemPool.Event__c = eventId;
                    blnEve.itemPool.Addon_Parent__c = itp.Id;
                }
                if(blnEve.itemPool.Item_Type__c == null){
                    blnEve.itemPool.Item_Type__c = admissionItemType.id;
                }
                
              //  blnEve.itemPool.Addon_Count__c =  blnEve.itemPool.Item_Count__c;   //  we will Take input directly from VF Pages...............
               system.debug('PPPPPPPPPPPPPPPPPPPPPPPPPPP     '+ itp.Item_Count__c +'          '+ blnEve.itemPool.Addon_Count__c);
               
               blnEve.itemPool.Item_Count__c = itp.Item_Count__c * blnEve.itemPool.Addon_Count__c;
                
                 packageLineItemPools.add(blnEve.itemPool);
            }
            
            
            /*
            for(Item_Pool__c pacPool: tic.packageItemPools){
                
                if(pacPool.Event__c == null){
                    pacPool.Event__c = eventId;
                    pacPool.Addon_Parent__c = itp.Id;
                }
                if(pacPool.Item_Type__c == null){
                    pacPool.Item_Type__c = admissionItemType.id;
                }
                
                pacPool.Addon_Count__c =  pacPool.Item_Count__c;
                pacPool.Item_Count__c = itp.Item_Count__c * pacPool.Item_Count__c;
                
                 packageLineItemPools.add(pacPool);
            }
 			*/
 			
        }
        
        LIST<Database.UpsertResult> packageLineItemPoolsResl = itemPoolDAO.createItemPools(packageLineItemPools);
          
         
        return packageLineItemPoolsResl;
        
    }
    
    
    

}