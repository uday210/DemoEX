@RestResource(urlMapping='/BLN_ASC_ItemsList/*')

global class BLN_ASC_ItemsList{
global static List<Itemscls_info> ct1 {get ; set ;}
global static BLN_Item_DAO itemsDao {get; set ;}
global static DateTime moddate{get; set ;}
    @HttpPost  
    global static List<Itemscls_info> doPost(){ 
      String siteurl=Label.SiteURL;
      string orgid = UserInfo.getOrganizationId();
        RestRequest req = RestContext.request;
        //system.debug('PPPPPP '+req.params.get('Event_id'));
        
        string eventid = req.params.get('Event_id');
        
        
        system.debug('@@eventid'+eventid );
        ct1 = new List<Itemscls_info>();
        itemsDao = new BLN_Item_DAO ();
        LIST<BLN_Item__c> itemsofEvent = itemsDao.getEventItemsForMobile(eventid);
        BLN_Event__c  ble=[select id,name,Time_Zone__c from BLN_Event__c where id=:eventid limit 1];
       system.debug('@@ble'+ble);
        BLN_ASC_GlobalItemLineit globalcls = new BLN_ASC_GlobalItemLineit();
        Map<Id,List<Item_Pool__c>> mapitemWithpools = new Map<Id,List<Item_Pool__c>>();
        mapitemWithpools = globalcls.sendItemsWithpools(itemsofEvent);
            for(BLN_Item__c BLT : itemsofEvent  ){
            string Sdate ='';
            string Edate ='';
               if(ble.Time_Zone__c != null){
               Sdate = BLT.sale_start__c.format('yyyy-MM-dd hh:mm a',ble.Time_Zone__c);
               Edate = BLT.sale_end__c.format('yyyy-MM-dd hh:mm a',ble.Time_Zone__c);
               
               }
               System.debug('BLT.lastmodifieddate '+BLT.lastmodifieddate);
                System.debug('BLT####'+BLT );
               System.debug('moddate '+moddate);
               system.debug('image_url'+BLT.image_url__c);
               if(moddate!=null){
               if(BLT.lastmodifieddate>=moddate)
               ct1.add(new Itemscls_info(BLT,Sdate,Edate,mapitemWithpools.get(BLT.Id),siteurl+'/servlet/servlet.ImageServer?oid='+orgid+'&id=')); }
               else
                ct1.add(new Itemscls_info(BLT,Sdate,Edate,mapitemWithpools.get(BLT.Id),siteurl+'/servlet/servlet.ImageServer?oid='+orgid+'&id='));       
        }
        


        return ct1;

    }
    
   global class Itemscls_info{
     public String siteurl{get;set;}
   public BLN_Item__c Items {get ; set ;}
   public List<Item_Pool__c> Itempool {get ; set ;}
   public string Startdate {get ; set ;}
   public string Enddate {get ; set ;}
   public Itemscls_info(BLN_Item__c Item1 ,string sdate,string edate, List<Item_Pool__c> Itempool1,String siteurls){
   Items =Item1;
   Startdate= sdate;
   Enddate = edate;
   Itempool = ItemPool1;
   siteurl=siteurls;
   
   }
     public Itemscls_info(){}
   }
    

}