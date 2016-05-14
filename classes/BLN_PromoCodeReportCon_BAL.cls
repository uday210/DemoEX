/***********************************************************************************************
*   Controller Name : BLN_PromoCodeReportCon_BAL
*   Date            : 10/27/2014
*   Author          : Manasa Gandham
*   Purpose         : This class is to display the PromoCode Report
*   Change History  : 10/27/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*    10/27/2014              Manasa Gandham                 To Create Page
*  
**************************************************************************************************/

public without sharing class BLN_PromoCodeReportCon_BAL{
  public integer finaausedtital;
  public id selectedEvent;
  public integer ordeitemsize;
    public BLN_PromoCodeReportCon_BAL(){
   
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){ 
      selectedEvent = k.getValue();
       }
       system.debug('ssssssss'+selectedEvent);
       
    }  
    
   
    public BLN_Promotion_DAO promotionsDAOClass{get; set;}
    public integer sr{get;set;}
    public LIST<promoCodeInner> promoCodeInnerList;
    public LIST<itemPromotionInner> itemPromotionInnerList;
    public map<id,list<Order_Item__c>> pois{get;set;}
    public Map<Id, totaldiscount> userAppCountMap{get;set;}
    public Map<Id, totaldiscount> userAppCountMapcancl{get;set;}
    Map<String, totaldiscount> userAppCountMap1{get;set;}
    Map<String, totaldiscount> userAppCountMapcancl1{get;set;}
    public Decimal totaldiscountoneachticketbyticket{get;set;}
    public integer totalusedtbyticket{get;set;}
    public list<Item_Promotion__c> itemss;
  
    public List<Promotion__c> queryPromotions(String EventId, Datetime FromDate, Datetime ToDate, String SearchString){
        
        promotionsDAOClass= new BLN_Promotion_DAO();
        LIST<Promotion__c> promosList= new LIST<Promotion__c>();
        String queryString= '';
        queryString= ' Event__c = \''+EventId+'\'';
        //queryString += ' AND Status__c != \''+'inActive'+'\'';
        system.debug('  000000000000  '+queryString);
        if(FromDate != NULL){
            FromDate= FromDate.addDays(1);            
            dateTime d1 = FromDate;
            string FromDateStr= d1.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
            queryString += ' AND CreatedDate >= '+FromDateStr;
        } 
        system.debug('  111111111  '+queryString);
        if(ToDate != NULL){
            ToDate= ToDate.addDays(1);
            dateTime d1 = ToDate;
            string ToDateStr= d1.format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');

            queryString += ' AND CreatedDate <='+ToDateStr;            
        }
        if(SearchString != NULL){
            queryString += ' AND (Name Like \'%'+SearchString+'%\''+' OR Promo_Code__c Like \'%'+SearchString+'%\''+' OR Promotion_Type__c Like \'%'+SearchString+'%\''+' OR Discount_Type__c Like \'%'+SearchString+'%\''+')'; 
         
        }
        
        promosList= promotionsDAOClass.promotionslist(queryString);
        
        return promosList;
        
    }
     public list<Order_Item__c> orderitemquery(){
      list<Order_Item__c> orderquerylist = new list<Order_Item__c>();
          orderquerylist=[SELECT ID, Promotion__r.Promo_Code__c, Item_Discount__c, Item_Price__c, Item_Quantity__c, Item_Total__c, Order__c,Order__r.Name,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.Order_Discount__c,Promotion__r.Discount_Type__c,Item__r.item_type__r.Name,Item__r.item_name__c ,Promotion__r.Name,Status__c,Order__r.Order_Status__c from Order_Item__c where Item__r.Event__c=:selectedEvent AND Promotion__c!=null AND Item_Discount__c !=0 AND Status__c!='Cancelled'AND Order__r.Order_Status__c!='Cancelled' AND Order__r.Order_Status__c!='Abandoned'];
         return orderquerylist;
     }
      public list<Item_Promotion__c> queryitem(String EventId, Datetime FromDate, Datetime ToDate, String SearchString){
          list<Item_Promotion__c> queryitem=new  list<Item_Promotion__c>();
          queryitem=[select id,Promotion__r.id,Promotion__r.T_Used_Count__c,Promotion__r.T_Max_Count__c,Buy_Item__r.id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Name,Promotion__r.Status__c,Promotion__r.Event__c from Item_Promotion__c where CreatedDate >= :FromDate AND CreatedDate <= :ToDate AND Promotion__r.Event__c=:EventId AND Promotion__c!=null];
          system.debug('queryitem======'+queryitem.size());
          return queryitem;
      }
     

    public LIST<promoCodeInner> promotionsListForEvent(LIST<Promotion__c> promosList){
        
        //Retrieving Promotions
        //LIST<Promotion__c> promosList = queryPromotions(EventId,FromDate,ToDate,SearchString);
                
        userAppCountMap1 = new Map<String, totaldiscount>();
        userAppCountMapcancl1 = new Map<String, totaldiscount>();
        
        system.debug(promosList.size()+'  PROMO CODES SIZE '+promosList);
        LIST<promoCodeInner> promoCodeInnerList= new LIST<promoCodeInner>();
        Set<Id> promotionIds = new Set<Id>();
        Map<Id,List<AggregateResult>> orderItemAggr = new Map<Id,List<AggregateResult>>();
        for(Promotion__c promotion: promosList){
            promotionIds.add(promotion.id);
        }
        for(AggregateResult aggRes : [SELECT count(Item__r.id) tid,SUM(Item_Quantity__c) iqsum,Item__c ti,sum(Item_Discount__c) itmdiscount,Promotion__c prm,Status__c stat  FROM Order_Item__c  where  Promotion__c  IN:promotionIds AND Item_Discount__c!=0 AND Status__c!='Cancelled' AND Order__r.Order_Status__c!='Abandoned' AND Order__r.Order_Status__c!='Cancelled'GROUP BY Item__r.item_name__c,Item__c,Promotion__c,Status__c ]){
            if(orderItemAggr.containsKey((Id)aggRes.get('prm'))){
                List<AggregateResult> aggRess = orderItemAggr.get((Id)aggRes.get('prm'));
                aggRess.add(aggRes);
                orderItemAggr.put((Id)aggRes.get('prm'),aggRess);
            }else{
                List<AggregateResult> aggRess = new List<AggregateResult>();
                aggRess.add(aggRes);
                orderItemAggr.put((Id)aggRes.get('prm'),aggRess);
            }
        }
        
      /* LIST<AggregateResult> OrdItemAggforCnt= new LIST<AggregateResult>();
        OrdItemAggforCnt = [select promotion__c p,SUM(Item_Quantity__c) iq,count(id)cnt  from Order_Item__c where promotion__c in :promotionIds AND Item_Discount__c!=0 AND Status__c!='Cancelled' AND Order__r.Order_Status__c!='Abandoned' AND Order__r.Order_Status__c!='Cancelled' group by Promotion__c];
        MAP<id,integer> OrdItmCntMap=new MAP<id,integer>();
        for(AggregateResult ag :OrdItemAggforCnt){
        OrdItmCntMap.put((Id)ag.get('p'),integer.valueof(ag.get('cnt')));
        }*/
        
        for(Promotion__c promotion: promosList){
            if(promotion.Order_Items__r.size()>0){
                finaausedtital=0;
                userAppCountMap = new Map<Id, totaldiscount>();
                userAppCountMapcancl = new Map<Id, totaldiscount>();
                try{
                    if(orderItemAggr.containsKey(promotion.id)){
                        for(AggregateResult agr : orderItemAggr.get(promotion.id)){
                            integer count= integer.valueof(agr.get('iqsum'));
                            id ticetid=(id) agr.get('ti');
                            Decimal Tdiscountamount=(Decimal)(agr.get('itmdiscount'));
                            totaldiscount totdis=new totaldiscount(count,Tdiscountamount);
                           // if(String.valueOf(agr.get('stat'))!='Cancelled'){
                                userAppCountMap.put(ticetid, totdis);
                                String PromoAndItem = ticetid+''+promotion.id;
                                userAppCountMap1.put(PromoAndItem,totdis);
                            /*}else if(String.valueOf(agr.get('stat'))=='Cancelled'){
                                userAppCountMapcancl.put(ticetid, totdis);
                                String PromoAndItemcanl = ticetid+''+promotion.id;
                                userAppCountMapcancl1.put(PromoAndItemcanl,totdis);
                            }*/
                        }
                        //system.debug('userAppCountMap1=======bis'+userAppCountMap1);
                    }
                }catch(Exception e){}
                    LIST<itemPromotionInner> itemPromotionInnerList= new LIST<itemPromotionInner>();
                    for(Item_Promotion__c itemPromotion: promotion.Item_Promotions__r){
                        integer tickcont;
                        Decimal totaldiscountoneachticket;
                        try{
                            if(itemPromotion.Buy_Item__r.id !=NULL){
                                decimal aftercanclamount =0;
                                integer contofpromo=0;
                               /* if(userAppCountMapcancl.size()>0 && userAppCountMapcancl.get(itemPromotion.Buy_Item__r.id) != null){
                                    aftercanclamount =  userAppCountMapcancl.get(itemPromotion.Buy_Item__r.id).totaldiscountforeachticket;
                                    contofpromo=userAppCountMapcancl.get(itemPromotion.Buy_Item__r.id).eachticketcount; 
                                }*/
                                tickcont = userAppCountMap.get(itemPromotion.Buy_Item__r.id).eachticketcount;
                                finaausedtital=tickcont+finaausedtital;
                                totaldiscountoneachticket = userAppCountMap.get(itemPromotion.Buy_Item__r.id).totaldiscountforeachticket; 
                            }
                        }catch(Exception e){ 
                            tickcont=0;
                            totaldiscountoneachticket=0;
                        }
                        if(totaldiscountoneachticket!= 0){
                            itemPromotionInnerList.add(new itemPromotionInner(itemPromotion,tickcont,totaldiscountoneachticket));
                        }
                        tickcont=0;
                    }
                    integer itemtick=itemPromotionInnerList.size();
                    if(itemPromotionInnerList.size() >0){
                        promoCodeInnerList.add(new promoCodeInner(promotion, itemPromotionInnerList,itemtick,finaausedtital));
                    }
            }
        }
        return promoCodeInnerList;
    }
        
    public LIST<promoCodeInner1> promotionsListForEventbypromocode(LIST<Promotion__c> promosList){
        
        //Retrieving Promotions
        //LIST<Promotion__c> promosList = queryPromotions(EventId,FromDate,ToDate,SearchString);
        
        
        //system.debug(promosList.size()+'  PROMO CODES SIZE '+promosList);
        LIST<promoCodeInner1> promoCodeInnerList1= new LIST<promoCodeInner1>();
        
        for(Promotion__c promotion: promosList){
           if(promotion.Order_Items__r.size()>0){
          
               // BLN_Item__c itemss = new BLN_Item__c();
                LIST<itemPromotionInner1> itemPromotionInnerList1= new LIST<itemPromotionInner1>();
                map<id,Order_Item__c> tiketcanmap=new map<id,Order_Item__c>();
               /* for(Order_Item__c itemPromotion: promotion.Order_Items__r){
                    if(itemPromotion.Status__c=='Cancelled' && itemPromotion.Item_Discount__c!=0){
                        // system.debug(itemPromotion.Order__c+'itemiddddd'+itemPromotion.Item__c);
                        tiketcanmap.put(itemPromotion.Order__c,itemPromotion);
                    }
                }*/
                // system.debug('tiketcanmap===='+tiketcanmap);
                for(Order_Item__c itemPromotion1: promotion.Order_Items__r){
                    
                    if(itemPromotion1.Status__c!='Cancelled' && itemPromotion1.Item_Discount__c!=0){
                        if(tiketcanmap.get(itemPromotion1.Order__c) !=null && tiketcanmap.get(itemPromotion1.Order__c).Item__c==itemPromotion1.Item__c){
                            itemPromotion1.Item_Discount__c= itemPromotion1.Item_Discount__c ;
                        }
                        decimal discountAmount =0;
                        // system.debug('discountAmount====1234'+itemPromotion1);
                        if(itemPromotion1.Item_Discount__c!=0){
                            itemPromotionInnerList1.add(new itemPromotionInner1(itemPromotion1, discountAmount));
                        }
                    }
                }
                   
                list<Item_Promotion__c> itemsslist =new list<Item_Promotion__c>();
                for(Item_Promotion__c itemPromotionitems: promotion.Item_Promotions__r){
                    //system.debug('itemPromotionitems===='+itemPromotionitems);
                    itemsslist.add(itemPromotionitems);
                    // system.debug('itemss======='+itemss);
                }
                // system.debug('itemss123======='+itemss);
                if(itemPromotionInnerList1.size()!=null && itemPromotionInnerList1.size() > 0 ){
                    // system.debug('itemPromotionInnerList1122333'+itemPromotionInnerList1);
                    promoCodeInnerList1.add(new promoCodeInner1(promotion,itemsslist, itemPromotionInnerList1));
                    //system.debug(promoCodeInnerList1.size()+'  PROMO CODES INNER  '+promoCodeInnerList1);
                }                                           
            }
        }
        
        return promoCodeInnerList1;
    }

 
 
 public LIST<promoCodeInner12> promotionsListForEventbyticketdetail(String EventId, Datetime FromDate, Datetime ToDate, String SearchString, List<Item_Promotion__c> itemPromotions){
        
        //Retrieving Promotions
        //LIST<Promotion__c> promosList = queryPromotions(EventId,FromDate,ToDate,SearchString);
        LIST<promoCodeInner12> promoCodeInnerList12= new LIST<promoCodeInner12>();
        //Retrieving Order Items
        List<Order_Item__c> orderItemsLst = orderitemquery();
        
        //Retrieving Item Promotions
        //List<Item_Promotion__c> itemPromotions = queryitem(EventId, FromDate, ToDate, SearchString);
        set<id> dupid2=new set<id>();
        for(Item_Promotion__c itemPromotionitems: itemPromotions){
         if(!dupid2.contains(itemPromotionitems.Buy_Item__r.id)){

            LIST<itemPromotionInner1> itemPromotionInnerList12= new LIST<itemPromotionInner1>();
            map<id,Order_Item__c> tiketcanmap=new map<id,Order_Item__c>();
          /*  for(Order_Item__c itemPromotion2: orderItemsLst){
               if(itemPromotion2.Status__c=='Cancelled' && itemPromotion2.Item_Discount__c!=0){
                system.debug(itemPromotion2.Order__c+'itemiddddd'+itemPromotion2.Item__c);
                tiketcanmap.put(itemPromotion2.Order__c,itemPromotion2);
               }
            } */
          // system.debug('tiketcanmap===='+tiketcanmap);
            for(Order_Item__c itemPromotion1: orderItemsLst){
            
                if(itemPromotion1.Status__c!='Cancelled' && itemPromotion1.Item_Discount__c!=0){
                    // system.debug('notCancelled'+ itemPromotion1);
                    if(tiketcanmap.get(itemPromotion1.Order__c) !=null && tiketcanmap.get(itemPromotion1.Order__c).Item__c == itemPromotion1.Item__c){
                      itemPromotion1.Item_Discount__c= itemPromotion1.Item_Discount__c;
                    }
                    decimal discountAmount =0;
                    // system.debug('discountAmount===='+ itemPromotion1);
                    if(itemPromotion1.Item_Discount__c!=0 &&  itemPromotionitems.Buy_Item__r.id == itemPromotion1.Item__r.id){
                        itemPromotionInnerList12.add(new itemPromotionInner1(itemPromotion1, discountAmount));
                    }
                }
            }
            //system.debug('itemPromotionitemsrajj'+itemPromotionInnerList12.size());
            if(itemPromotionInnerList12.size()!=null && itemPromotionInnerList12.size() > 0 ){
                
                 
            promoCodeInnerList12.add(new promoCodeInner12(itemPromotionitems, itemPromotionInnerList12));
            }
             dupid2.add(itemPromotionitems.Buy_Item__r.id);
        }
       
        }
        return promoCodeInnerList12;
    }
    

    public LIST<promocodebyticket> promobyticket(String EventId, Datetime FromDate, Datetime ToDate, String SearchString, LIST<Promotion__c> promosListbyticket){
   
        list<byticketstotaldiscounamount> pro;
        set<String> dupid;
        LIST<promocodebyticket> promobyticketinnerlist= new LIST<promocodebyticket>();
        //Retrieving Promotions
        //LIST<Promotion__c> promosListbyticket = queryPromotions(EventId,FromDate,ToDate,SearchString);
        
        
        map<id,Promotion__c> prommap= new map<id,Promotion__c>(promosListbyticket); 
        
       //LIST<Promotion__c> promosList = queryPromotions(EventId,FromDate,ToDate,SearchString);
        LIST<promoCodeInner12> promoCodeInnerList12= new LIST<promoCodeInner12>();
        //Retrieving Order Items
        List<Order_Item__c> orderItemsLst = orderitemquery();
        
        //Retrieving Item Promotions
        List<Item_Promotion__c> itemPromotions = queryitem(EventId,FromDate,ToDate,SearchString);
        set<id> dupid1=new set<id>();
       
       for(Item_Promotion__c itempromo:itemPromotions){
      
            if(!dupid1.contains(itempromo.Buy_Item__r.id)){
           
                pro= new list<byticketstotaldiscounamount>();
                if(itempromo.Promotion__r.id!=null){
                    
                    dupid=new set<String>();
                    for(Order_Item__c promotionticket:orderItemsLst){
               
                        string conct = promotionticket.Item__c+''+promotionticket.Promotion__c;
                 
                       // userAppCountMap1= new Map<String, totaldiscount>();
                       
                        if(!dupid.contains(conct)){
                 
                                if(itempromo.Buy_Item__r.id == promotionticket.Item__r.id){
                                    decimal aftercanclamount=0;
                                    Integer aftercanclusedcount=0;
                                    // system.debug('sagar');
                                   /* if(null!=userAppCountMapcancl1.get(conct)){
                                        aftercanclamount=  userAppCountMapcancl1.get(conct).totaldiscountforeachticket;
                                        aftercanclusedcount = userAppCountMapcancl1.get(conct).eachticketcount;
                                    }*/
                                        //system.debug('userAppCountMapcancl1=='+userAppCountMapcancl1.get(conct));
                                   try{
                                        totaldiscountoneachticketbyticket = userAppCountMap1.get(conct).totaldiscountforeachticket;// - aftercanclamount;
                                        totalusedtbyticket = userAppCountMap1.get(conct).eachticketcount;// -aftercanclusedcount ;
                                        
                                
                                   }
                                   catch(Exception e){
                                        totaldiscountoneachticketbyticket=0;
                                        totalusedtbyticket=0;
                                   } 
                                    
                                     
                                    byticketstotaldiscounamount btda = new byticketstotaldiscounamount(prommap.get(promotionticket.Promotion__c),totalusedtbyticket ,totaldiscountoneachticketbyticket );
                                    pro.add(btda);
                       
                                }
                        }
                        dupid.add(conct);
                    }
                    
                   if(totaldiscountoneachticketbyticket!=0){
        
                    //system.debug('pro======================='+pro);
                    //system.debug('lllllllllllllll'+itempromo.Buy_Item__r.item_name__c);
                    promobyticketinnerlist.add(new promocodebyticket(itempromo.Buy_Item__r.item_name__c,itempromo.Buy_Item__r.item_type__r.Name,itempromo.Buy_Item__r.id,pro));
                   }
                   
                }
                 dupid1.add(itempromo.Buy_Item__r.id);
            }
         // dupid1.add(itempromo.Buy_Item__r.id);
         
        }
       
       //system.debug(promobyticketinnerlist+'%%%%%%%'+promobyticketinnerlist.size());
        //............................................................................
        
        return promobyticketinnerlist;
    
    }
    
    
    public class promoCodeInner{
        
        public Promotion__c promotionData{get; set;}
        public LIST<itemPromotionInner> itemPromotionList{get; set;}
      
        public integer itemsize{get;set;}
         public Decimal inntotalusedcont{get;set;}
        public promoCodeInner(Promotion__c promotionData, LIST<itemPromotionInner> itemPromotionList,integer itemsize,Decimal inntotalusedcont){
            this.promotionData= promotionData;
            this.itemPromotionList= itemPromotionList;
            this.itemsize=itemsize;
             this.inntotalusedcont=inntotalusedcont;
        }
    }
    
    public class itemPromotionInner{
        
        public Item_Promotion__c itemPromotionData{get; set;}
       // public Decimal discountedPrice{get; set;}
        public integer itemcount{get;set;}
        public Decimal totdiscount{get;set;}
        
        public itemPromotionInner(Item_Promotion__c itemPromotionData,integer itemcount,Decimal totdiscount){
            
            this.itemPromotionData= itemPromotionData;
           // this.discountedPrice= discountedPrice;
            this.itemcount=itemcount;
            this.totdiscount=totdiscount;
           
        }
    
    }
    
    public class totaldiscount{
    public integer eachticketcount{get;set;}
    
    public Decimal totaldiscountforeachticket{get;set;}
    
    public totaldiscount(integer eachticketcount, Decimal totaldiscountforeachticket){
    this.eachticketcount=eachticketcount;
    this.totaldiscountforeachticket=totaldiscountforeachticket;
    
    }
    
    }
    
    public class promocodebyticket{
    
    public string ticketname{get;set;}
    public string tickettype{get;set;}
    public id itemid{get;set;}
    public list<byticketstotaldiscounamount> prolistforticketinner{get;set;}
    
    public promocodebyticket(string ticketname,string tickettype,id itemid,list<byticketstotaldiscounamount> prolistforticket1){
    
    this.ticketname=ticketname;
    this.tickettype=tickettype;
    this.itemid=itemid;
    this.prolistforticketinner=prolistforticket1;
    
    }
  
    }
    public class byticketstotaldiscounamount{
      public Promotion__c prolistforticket{get;set;}
      public integer usedbyticket{get;set;}
    public Decimal totaldiscountbyticket{get;set;}
     public byticketstotaldiscounamount(Promotion__c prolistforticket,integer usedbyticket,Decimal totaldiscountbyticket){
    
  
    this.prolistforticket=prolistforticket;
    this.usedbyticket=usedbyticket;
    this.totaldiscountbyticket=totaldiscountbyticket;
    }
    }
    public class mapinner{
    public list<Ticket__c> ticketlist{get;set;}
    public integer t_size{get;set;}
    public mapinner(list<Ticket__c> tlst,integer tsize){
    this.ticketlist = tlst;
    this.t_size = tsize;
    }
    }
     public class promoCodeInner1{
        
        public Promotion__c promotionData{get; set;}
         public list<Item_Promotion__c> blnitems{get;set;}
        public LIST<itemPromotionInner1> itemPromotionList1{get; set;}
       
        
        public promoCodeInner1(Promotion__c promotionData, list<Item_Promotion__c> blnitems,LIST<itemPromotionInner1> itemPromotionList1){
            this.promotionData= promotionData;
            this.blnitems= blnitems;
            this.itemPromotionList1= itemPromotionList1;
            
        }
    }
    
    
    
     public class promoCodeInner12{
        
      //  public Promotion__c promotionData{get; set;}
         public Item_Promotion__c blnitems{get;set;}
        public LIST<itemPromotionInner1> itemPromotionList1{get; set;}
       
        
        public promoCodeInner12(Item_Promotion__c blnitems,LIST<itemPromotionInner1> itemPromotionList1){
           // this.promotionData= promotionData;
            this.blnitems= blnitems;
            this.itemPromotionList1= itemPromotionList1;
            
        }
    }
    
    public class itemPromotionInner1{
        
        public Order_Item__c itemPromotionData{get; set;}
        public Decimal discountedPrice{get; set;}
        //Decimal discountedPrice
        public itemPromotionInner1(Order_Item__c itemPromotionData,Decimal discountedPrice){
            
            this.itemPromotionData= itemPromotionData;
            this.discountedPrice= discountedPrice;
        }
    
    }
    
    
}