public with sharing class BLN_Scanusr_Settings_BAL {

    public BLN_Item_DAO itemDao {get; set;}
    public BLN_Ticket_DAO tcDao=new BLN_Ticket_DAO();
    public BLN_Gnuser_DAO gnuserDao =new BLN_Gnuser_DAO();
    public BLN_Scanusr_item_DAO scanusrDao =new BLN_Scanusr_item_DAO();
    public BLN_ItemPool_DAO itemPoolDao =new BLN_ItemPool_DAO();
    public String eventId {get; set;}
    public MAP<id, BLN_Item__c> mapPidWithItem {get; set;}
    public MAP<id, Integer> buyerMails {get; set;}
    public List<ItemWithChk> usrDisinn {get; set;}
    public Integer usrMaxselcnt {get; set;}
    public MAP<id,Item_Pool__c> mapItpWithItpool{get;set;}  
    public List<itemWithbuyquan> itemBQuan{get;set;}

    public BLN_Scanusr_Settings_BAL() {
    }

    public BLN_Scanusr_Settings_BAL(String eveId) {
        evItpoolsWtItems(eveId);
        usrMaxselcnt = 0;
    }

    public List<BLN_Item__c>  getEventItems(String eventId) {
        return itemDao.getEventItems(eventId);
    }

    public List<itemWithbuyquan> getScanattBuyers(String eventId) {
        itemBQuan = new List<itemWithbuyquan>();
        MAP<id, Integer> buyerIds = new MAP<id, Integer>();
        buyerIds = geTotalTcbought(eventId);
        for( Gn_user__c gnu: gnuserDao.getGnuserList(buyerIds.keySet())){
          itemBQuan.add(new itemWithbuyquan(buyerIds.get(gnu.id),gnu)); 
        }       
         return itemBQuan;
    }

    public MAP<id, Integer> geTotalTcbought(String eventId) {
        buyerMails = new MAP<id, Integer>();
        for (Ticket__c tcs : tcDao.getScanAttendeeBuyer(eventId)) {
            Integer buyQuan = 0;
            If (buyerMails.containsKey(tcs.tkt_profile__r.BLN_GN_User__c)) {
                buyQuan =  buyerMails.get(tcs.tkt_profile__r.BLN_GN_User__c);
            }
            buyQuan = buyQuan + 1;
            buyerMails.put(tcs.tkt_profile__r.BLN_GN_User__c, buyQuan);
          }
      return buyerMails;
    }

    public MAP<id, BLN_Scanusr_item__c> getUsrScanedItems(String uId, String eventId) {
        MAP<id, BLN_Scanusr_item__c> mapScanidWithItem = new MAP<id, BLN_Scanusr_item__c>();
        for (BLN_Scanusr_item__c scanObj : scanusrDao.getUserScanItems(uId, eventId)) {
            mapScanidWithItem.put(scanObj.BLN_Item_Pool__c, scanObj);
        }
        return mapScanidWithItem;
    }

    // This will return Event pool with Items
    public MAP<id, BLN_Item__c> evItpoolsWtItems(String eveId) {
        mapPidWithItem = new MAP<id, BLN_Item__c>();
        mapItpWithItpool =new MAP<id,Item_Pool__c>();
        map<id,BLN_Item__c> pidWithItem = new map<id,BLN_Item__c>();

        System.debug(' eveId   s   '+eveId);
        List<Item_Pool__c> chItpoolsaparate = new List<Item_Pool__c>();
        itemPoolDao = new BLN_ItemPool_DAO();
        for (Item_Pool__c itps : itemPoolDao.getPoolsOfevent(eveId)) {
            System.debug(' Item Pools   '+itps);
             mapItpWithItpool.put(itps.id,itps);
            if (itps.Addon_Parent__c != null) {
                chItpoolsaparate.add(itps);
            } else {
                for (BLN_Item__c itm : itps.Items__r ) {
                   if(itm.item_type__r.Name!='Package')
                     mapPidWithItem.put(itps.id, itm);
                   else
                    pidWithItem.put(itps.id, itm);
                } 
            }
        }
        for (Item_Pool__c itch : chItpoolsaparate) {
            BLN_Item__c blnIt = new BLN_Item__c();
                blnIt = pidWithItem.get(itch.Addon_Parent__c);
                 mapItpWithItpool.put(itch.id,itch);
                 if(null!=blnIt)
                   mapPidWithItem.put(itch.id,blnIt);
            }
        System.debug('HHHHHHHHHHHHH '+mapPidWithItem);
        return mapPidWithItem;
    }

    public List<ItemWithChk> showItemsToEa(String uId, String Eid) {
    system.debug(Eid +'uId================='+uId);
        MAP<id, BLN_Scanusr_item__c> mapScanidWithItem = new MAP<id, BLN_Scanusr_item__c>();
        BLN_TStatus_DAO tstas = new BLN_TStatus_DAO();
        list<AggregateResult> groupedResults = new list<AggregateResult>();
        groupedResults=tstas.gettstatusitems(uId,Eid);
        map<String,integer> countitem= new map<String,integer>();
        
        for(AggregateResult agrr:groupedResults){
        
         integer eachitemcount =integer.valueof(agrr.get('cn'));
         String itemid=String.valueof(agrr.get('tiemid'));
         system.debug(itemid+'eachitemcount==='+eachitemcount);
         countitem.put(itemid,eachitemcount);
        }
        mapScanidWithItem = getUsrScanedItems(uId, Eid);
        usrDisinn = new List<ItemWithChk>();
        usrMaxselcnt = buyerMails.get(uId);
        System.debug(' User Name '+uId +' Event Id  '+Eid);
        for (id itpId : mapPidWithItem.keySet()) {
            BLN_Item__c item = new BLN_Item__c();
            item =mapPidWithItem.get(itpId);
            
            integer mapofitemcount=countitem.get(itpId);
            
            if(mapofitemcount== null){
            mapofitemcount=0;
            }
           
          if (null != mapScanidWithItem.get(itpId)){
         
                usrDisinn.add(new ItemWithChk(mapScanidWithItem.get(itpId),item , mapItpWithItpool.get(itpId),mapofitemcount));
            }else{
            
                usrDisinn.add(new ItemWithChk(null, item,mapItpWithItpool.get(itpId),mapofitemcount));
                }
        }
        return usrDisinn;
    }
    
    // Saving settings 
 public String saveSettings(String selectedGnId,String selectedeventid,List<ItemWithChk> itemsWithset){
      List<BLN_Scanusr_item__c> scanItemsForUpsert = new List<BLN_Scanusr_item__c>();
      String error='Success';
      integer totalselTicks =0;
      for(BLN_Scanusr_Settings_BAL.ItemWithChk itemInn:itemsWithset){
         System.debug('UUUUUUUUUUUUU '+itemInn.isSelected);
         System.debug('itemInn.scanItem.id   '+itemInn.scanItem.id);
         if(itemInn.isSelected==true){
          if(usrMaxselcnt>totalselTicks){ 
           itemInn.scanItem.BLN_Event__c = selectedeventid;
           itemInn.scanItem.BLN_GN_User__c = selectedGnId;
           itemInn.scanItem.BLN_Item_Pool__c = itemInn.itemPool.id;
           itemInn.scanItem.Status__c = 'Active'; 
           scanItemsForUpsert.add(itemInn.scanItem);  
           totalselTicks++;
           }else{
             error ='You should not select more than buy quantity!';
            return error;
           }
         }else if(null!=itemInn.scanItem.id){
           itemInn.scanItem.Status__c = 'Cancel'; 
          scanItemsForUpsert.add(itemInn.scanItem);
         } 
         System.debug('AAAAAAAA  '+scanItemsForUpsert.size());
        }
        if(scanItemsForUpsert.size()>0){ 
           DataBase.upsert(scanItemsForUpsert,false);
        } 
     return error;
 }

 public class itemWithbuyquan{
   public Integer buyQuan{get;set;}
   public Gn_user__c gnuser{get;set;}
   public itemWithbuyquan(Integer buyQuan,Gn_user__c gnuser){
    this.gnuser = new Gn_user__c();
    this.gnuser = gnuser;
     if(null!=buyQuan)
      this.buyQuan =buyQuan;
     else
       this.buyQuan=0;
   }
 }


    public class ItemWithChk {
        public Boolean isSelected {get; set;}
        public BLN_Item__c item {get; set;}
        public BLN_Scanusr_item__c scanItem{get;set;}
        public Item_Pool__c itemPool{get;set;}
        public integer scancountitem{get;set;}
        public ItemWithChk(BLN_Scanusr_item__c scanit, BLN_Item__c item, Item_Pool__c itpId,integer scancountitem) {
            this.scanItem = new BLN_Scanusr_item__c();
            this.item = new BLN_Item__c();
            this.itemPool = new Item_Pool__c();
            if(null!=itpId)
                this.itemPool = itpId;
           if(null!=scanit){
               this.isSelected = true;
               this.scanItem = scanit;
            }else{
               this.isSelected = false;
            }   
            this.item = item;
            System.debug('Item Name '+item);
            this.scancountitem=scancountitem;
        }
    }
}