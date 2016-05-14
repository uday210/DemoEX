global with sharing class BLN_RegDashBoardInfo {

    //Order Info
    public Integer totalcompOrders=0;
    public Integer totalcanOrders=0;
    public Integer totalOrders=0;
    public Integer totalNoncompOrds=0;
    // For item info
    public Integer totalTickets=0;
    public Integer totalSoldTickets=0;
    public Integer totalcanTiccnt=0;
    //Revenue  Info
    public Decimal totalrevenue=0.0;
    public Decimal onlineRevenue=0.0;
    public Decimal onsiteRevenue=0.0;
    public Decimal mobileRevenue=0.0;
    // This list has all paygateways and its revenue
    public List<innForPgateways> innRevList{get;set;}
    public List<InnForItemPrice> ItemRevList{get;set;}
    public Integer totalAttendee=0;

    public Integer attendeesCount=0;
    public Integer ExhibitorCount=0;
    public Integer sponsorCount=0;
    public Integer speakerCount=0;
    /****Added By Unni Start*******/
    public Integer MLbuyerCount=0;
    public Integer MLsellerCount=0;
    /****Added By Unni End*******/

    //checking history
    public Integer chekinCont=0;
    public Integer checloutCnt =0;
    public Integer notCheckdin =0;

    //Badge printed/Not printed
    public Integer badgePrinted=0;
    public Integer badgeNotPrinted=0;
    public Integer noBadges=0;

    global Static MAp<id,Integer> MapItemWithChInQuantity {get;set;}
    global Static MAp<id,Integer> MapItemWithChOutQuantity {get;set;}



    public BLN_RegDashBoardInfo(String eventId){
      MAP<id,Decimal> mapItemCancelqty = new MAP<id,Decimal>();
       MAP<id,Decimal> mapItemItsPrice = new MAP<id,Decimal>();
       MAP<id,Integer> mapItemWithQuan = new MAP<id,Integer>();
       ItemRevList = new List<InnForItemPrice>();
       innRevList = new List<innForPgateways>();

        Map<Id,Order__c> ordsmapcancelled = new Map<ID, Order__c>([SELECT id,BLN_TKT_profile__r.BLN_Company__c,BLN_TKT_profile__r.BLN_GN_User__c,Currency_Code__c,EVent_Admin_Comments__c,Events__c,Fee_Amount__c,Order_Discount__c,Order_Status__c,Order_Sub_Total__c,Order_Taxes__c,Order_Total__c,order_type__c,Amount_Paid__c FROM Order__c WHERE Events__r.id=:eventId and order_type__c!='EVENT PRODUCER' and Order_Status__c!='Abandoned' and Order_Status__c !='Not Paid' and Order_Status__c='Cancelled']);
        Map<Id,Order__c> ordsmapnotcancelled = new Map<ID, Order__c>([SELECT id,BLN_TKT_profile__r.BLN_Company__c,BLN_TKT_profile__r.BLN_GN_User__c,Currency_Code__c,EVent_Admin_Comments__c,Events__c,Fee_Amount__c,Order_Discount__c,Order_Status__c,Order_Sub_Total__c,Order_Taxes__c,Order_Total__c,order_type__c,Amount_Paid__c FROM Order__c WHERE Events__r.id=:eventId and order_type__c!='EVENT PRODUCER' and Order_Status__c!='Abandoned' and Order_Status__c !='Not Paid' and Order_Status__c!='Cancelled']);
       Map<Id,Order__c> ordsmapabnotpaid = new Map<ID, Order__c>([SELECT id,BLN_TKT_profile__r.BLN_Company__c,BLN_TKT_profile__r.BLN_GN_User__c,Currency_Code__c,EVent_Admin_Comments__c,Events__c,Fee_Amount__c,Order_Discount__c,Order_Status__c,Order_Sub_Total__c,Order_Taxes__c,Order_Total__c,order_type__c,Amount_Paid__c FROM Order__c WHERE Events__r.id=:eventId and order_type__c!='EVENT PRODUCER' and (Order_Status__c='Abandoned' or Order_Status__c ='Not Paid')]);
       
       totalcanOrders=ordsmapcancelled.size();
       totalcompOrders=ordsmapnotcancelled.size();
       totalNoncompOrds=ordsmapabnotpaid.size();
       
       AggregateResult[] results =[select item__c,count(id) from Ticket__c where Parent_ID__c=null and Ticket_Status__c='Cancelled' and event__r.id=:eventId group by item__c];
       for (AggregateResult ar : results) {
       mapItemCancelqty.put((Id)ar.get('item__c'),(Decimal)ar.get('expr0'));
        }
      Map<Id,String> paygatewaynamemap=new Map<Id,String>();
      SET<String> paymentModes = new SET<String>();
 MAP<String,Decimal> mapNameWithId= new MAP<String,Decimal>();
      
     AggregateResult[] results1 =[SELECT SUM(Item_Discount__c),SUM(Item_Fee__c),SUM(Item_Price__c),SUM(Item_Quantity__c),SUM(Item_Total__c),SUM(Tax__c),Item__c FROM Order_Item__c  where Order__r.id in:ordsmapnotcancelled.keyset() group by item__c];
         
                   for (AggregateResult ar : results1) {
                   Decimal totitemdiscount=(Decimal)ar.get('expr0')==null?0:(Decimal)ar.get('expr0');
                   Decimal totitemfee=(Decimal)ar.get('expr1')==null?0:(Decimal)ar.get('expr1');
                   Decimal totitemprice=(Decimal)ar.get('expr2')==null?0:(Decimal)ar.get('expr2');
                   Decimal totitemqty=(Decimal)ar.get('expr3')==null?0:(Decimal)ar.get('expr3');
                   Decimal totitemtotal=(Decimal)ar.get('expr4')==null?0:(Decimal)ar.get('expr4');
                   Decimal totitemtax=(Decimal)ar.get('expr5')==null?0:(Decimal)ar.get('expr5');
                    totalSoldTickets+=Integer.ValueOf(totitemqty);
             
       mapItemItsPrice.put((Id)ar.get('Item__c'),totitemtotal+totitemfee+totitemtax-totitemdiscount);
       mapItemWithQuan.put((Id)ar.get('Item__c'),Integer.valueOf(totitemqty));
       totalrevenue+=totitemtotal+totitemfee+totitemtax-totitemdiscount;
      
        }
        
        
        // getting tickets cancelled at ticket level
        AggregateResult[] results2 =[SELECT SUM(Item_Quantity__c) FROM Order_Item__c  where Order__r.id in:ordsmapnotcancelled.keyset() and Status__c='Cancelled' group by item__c];
         
                   for (AggregateResult ar : results2) {
                   totalcanTiccnt+=integer.valueOf((Decimal)ar.get('expr0'));
                   }
        
         
       
        MAP<id,List<Item_Pool__c>> mapPidWithcids = new MAP<id,List<Item_Pool__c>>();
        for(Item_Pool__c itemPools : [select id,Addon_Parent__c,Item_Pool_Name__c,(SELECT id,Item_Pool_Name__c from Item_Pools__r) from Item_Pool__c where Event__r.id=:eventId]){
             if(itemPools.Item_Pools__r.size()>0){
                 mapPidWithcids.put(itemPools.id,itemPools.Item_Pools__r);
             }
        }


          MapItemWithChInQuantity = new MAp<id,Integer>();
          MapItemWithChOutQuantity = new MAp<id,Integer>();

         //scan attendee session user
          BLN_Event__c se = new BLN_Event__c();
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        Map<Id,Ticket__c> ticslist=new Map<Id,Ticket__c>();
        try{
           se = blneventdetailbal.eventdetails(eventId );
            }catch(Exception e){}
           if(se.ownerid!=userInfo.getUserId()&&se.organizer_email__c!=userInfo.getUserEmail()){
           
            List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:eventId and BLN_Item_Pool__c!=null];
        if(sc.size()>0)
        {
          List<String> poolids=new List<String>();
          for(BLN_Scanusr_item__c s:sc)
          poolids.add(s.BLN_Item_Pool__c);
         ticslist=new Map<ID, Ticket__c>([SELECT name,item_pool__c,badge_id__c,badge_id__r.print_status__c, Item_Type__r.Name,Item_Pool__r.Badgable__c,Item_Pool__r.id,Item__r.id,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,id,Item_Pool__r.Item_Type__r.Name from Ticket__c where Event__c=:eventId And Ticket_Status__c='Booked' And (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' ) and item_pool__c in:poolids]);
              
        }
            }
            else
            
            ticslist= new Map<ID, Ticket__c>([SELECT name,badge_id__c,badge_id__r.print_status__c,Ticket_Status__c,Item_Pool__r.Badgable__c, Item_Type__r.Name,Item_Pool__r.id,Item__r.id,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c,id,Item_Pool__r.Item_Type__r.Name from Ticket__c where Event__r.id=:eventId AND Item_Pool__r.Badgable__c!='N - No Badge' and  Ticket_Status__c != 'Cancelled' and  Ticket_Status__c != 'Available' and  Ticket_Status__c != 'Reserved' and  Ticket_Status__c != 'Deleted' and  Ticket_Status__c != 'Abandoned' ]);
          //
          
    AggregateResult[] badgeresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Item_Pool__r.Badgable__c!='N - No Badge'];
       for (AggregateResult ar : badgeresult ) {
       totalAttendee=(Integer)ar.get('expr0');
        }  
        
        AggregateResult[] admresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Item_Pool__r.Badgable__c!='N - No Badge' and Item_Pool__r.Item_Type__r.Name='Admissions'];
       for (AggregateResult ar : admresult ) {
       attendeesCount=(Integer)ar.get('expr0');
        } 
        
        AggregateResult[] exbresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Item_Pool__r.Badgable__c!='N - No Badge' and Item_Pool__r.Item_Type__r.Name='Exhibitor'];
       for (AggregateResult ar : exbresult ) {
       exhibitorCount=(Integer)ar.get('expr0');
        }
        
        AggregateResult[] spresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Item_Pool__r.Badgable__c!='N - No Badge' and Item_Pool__r.Item_Type__r.Name='Sponsor'];
       for (AggregateResult ar : spresult ) {
       sponsorCount=(Integer)ar.get('expr0');
        }
        
        AggregateResult[] spearesult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Item_Pool__r.Badgable__c!='N - No Badge' and Item_Pool__r.Item_Type__r.Name='Speaker'];
       for (AggregateResult ar : spearesult ) {
       speakerCount=(Integer)ar.get('expr0');
        }
        
        AggregateResult[] mbresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Item_Pool__r.Badgable__c!='N - No Badge' and Item_Pool__r.Item_Type__r.Name='MatchLeads Buyer'];
       for (AggregateResult ar : mbresult ) {
       MLbuyerCount=(Integer)ar.get('expr0');
        }
        
        AggregateResult[] msresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Item_Pool__r.Badgable__c!='N - No Badge' and Item_Pool__r.Item_Type__r.Name='MatchLeads Seller'];
       for (AggregateResult ar : msresult ) {
       MLsellerCount=(Integer)ar.get('expr0');
        }      

       AggregateResult[] itemchkinresult =[select Item__c,count(id) from Ticket__c where id in:ticslist.keyset() and Tstatus_Id__r.Tstatus_name__c=true and Item_Type__r.Name!='Package' and Tstatus_Id__c!=null group by Item__c];
       for (AggregateResult ar : itemchkinresult ) {
      MapItemWithChInQuantity.put((Id)ar.get('Item__c'),(Integer)ar.get('expr0'));
        }  
        
        AggregateResult[] pkgchkinresult =[select Item_Pool__c,count(id) from Ticket__c where id in:ticslist.keyset() and Tstatus_Id__r.Tstatus_name__c=true and Item_Type__r.Name='Package' and Tstatus_Id__c!=null group by Item_Pool__c];
       for (AggregateResult ar : pkgchkinresult ) {
      MapItemWithChInQuantity.put((Id)ar.get('Item_Pool__c'),(Integer)ar.get('expr0'));
        } 
        
        AggregateResult[] itemnotchkinresult =[select Item__c,count(id) from Ticket__c where id in:ticslist.keyset() and Tstatus_Id__r.Tstatus_name__c=false and Item_Type__r.Name!='Package' and Tstatus_Id__c!=null group by Item__c];
       for (AggregateResult ar : itemnotchkinresult ) {
      MapItemWithChOutQuantity.put((Id)ar.get('Item__c'),(Integer)ar.get('expr0'));
        }  
        
              
        AggregateResult[] pkgnotchkinresult =[select Item_Pool__c,count(id) from Ticket__c where id in:ticslist.keyset() and Tstatus_Id__r.Tstatus_name__c=false and Item_Type__r.Name='Package' and Tstatus_Id__c!=null group by Item_Pool__c];
       for (AggregateResult ar : pkgnotchkinresult ) {
      MapItemWithChOutQuantity.put((Id)ar.get('Item_Pool__c'),(Integer)ar.get('expr0'));
        }
        
        AggregateResult[] chkinresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Tstatus_Id__r.Tstatus_name__c=true and Tstatus_Id__c!=null];
       for (AggregateResult ar : chkinresult ) {
      chekinCont=(Integer)ar.get('expr0');
        }
        AggregateResult[] notchkinresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Tstatus_Id__r.Tstatus_name__c=false and Tstatus_Id__c!=null];
       for (AggregateResult ar : notchkinresult ) {
      checloutCnt=(Integer)ar.get('expr0');
        }
        
        AggregateResult[] nullchkinresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Tstatus_Id__c=null];
       for (AggregateResult ar : nullchkinresult ) {
      notCheckdin=(Integer)ar.get('expr0');
        }
        
        
        AggregateResult[] bdginresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Badge_ID__r.Print_status__c='Printed' and Badge_ID__c!=null];
       for (AggregateResult ar : bdginresult ) {
      badgePrinted=(Integer)ar.get('expr0');
        }
        AggregateResult[] notbdginresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Badge_ID__r.Print_status__c!='Printed' and Badge_ID__c!=null];
       for (AggregateResult ar : notbdginresult ) {
      badgenotPrinted=(Integer)ar.get('expr0');
        }
        
        AggregateResult[] nullbdginresult =[select count(id) from Ticket__c where id in:ticslist.keyset() and Badge_ID__c=null];
       for (AggregateResult ar : nullbdginresult ) {
      noBadges=(Integer)ar.get('expr0');
        }
        
         
        totalcanTiccnt=(-1)*totalcanTiccnt;
       totalOrders=totalcanOrders+totalcompOrders;
       SET<id> evPaygateways = new SET<id>();
       //Items
        for(BLN_Item__c items :[SELECT id,Available_Tickets__c,item_name__c,item_count__c,price__c,Item_Pool__r.id,item_type__r.Name FROM BLN_Item__c WHERE Event__c=:eventId]){
            totalTickets+=integer.valueOf(items.item_count__c);
            ItemRevList.add(new InnForItemPrice(items,mapItemItsPrice.get(items.id),mapItemWithQuan.get(items.id),mapPidWithcids.get(items.Item_Pool__r.id),mapItemCancelqty.get(items.id)==null?0:mapItemCancelqty.get(items.id) ));
          }
 AggregateResult[] results4 =[select sum(Order__r.Amount_Paid__c),Payment_Mode__c from Payment__c where Order__r.id in:ordsmapnotcancelled.keyset() group by Payment_Mode__c];
         
                   for (AggregateResult ar : results4) {
                  
                   mapNameWithId.put((String)ar.get('Payment_Mode__c'),(Decimal)ar.get('expr0'));
                   paymentModes.add((String)ar.get('Payment_Mode__c'));
                   
                   }

       

        // Getiing Event Paygateways
        for(Event_Pay_Gateway__c epg : [SELECT id,Pay_Gateway__c,Registration_Type__c,Pay_Gateway__r.PGateway_Type__r.Name FROM Event_Pay_Gateway__c Where Events__c=:eventId]){
            if(epg.Pay_Gateway__r.PGateway_Type__r.Name!='Check' || epg.Pay_Gateway__r.PGateway_Type__r.Name!='Cash' || epg.Pay_Gateway__r.PGateway_Type__r.Name!='External Pay Gateway'){
              paymentModes.add('Credit Card');
            }else{
               paymentModes.add(epg.Pay_Gateway__r.PGateway_Type__r.Name);
            }

        }

         System.debug('KKKKKKKKKKKK '+mapNameWithId);
         for(String gtways : paymentModes){
             if(null!=mapNameWithId.get(gtways)){
                innRevList.add(new innForPgateways(gtways,mapNameWithId.get(gtways)));
              }else{
                // innRevList.add(new innForPgateways(gtways,0.0));
              }
        }


/*
         for(Pay_Gateway__c pgateWays : [SELECT (SELECT id,Order__c,Pay_Address__c,Payment_Amount__c,Payment_Mode__c,Payment_Ref_Number__c,Registration_Type__c,Credit_card_last_4digits__c,BLN_Pay_Gateway__c FROM BLN_Payments__r WHERE Order__r.Events__c=:eventId and Order__r.Order_Status__c !='Abandoned' and Order__r.Order_Status__c!='Cancelled' and Order__r.Order_Status__c !='Not Paid'),id,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PGateway_Type__r.Display_Type__c,PGateway_Type__r.Help_Text__c,PGateway_Type__r.Image_URL__c,PGateway_Type__r.Online_Flag__c,PGateway_Type__r.Onsite_Flag__c,PGateway_Type__r.paytype_id__c,PGateway_Type__r.ScanAttendee_Flag__c FROM Pay_Gateway__c where Id IN :evPaygateways]){
            Decimal tempRev = 0.0;
            for(Payment__c payment : pgateWays.BLN_Payments__r){
                if(payment.Registration_Type__c=='Online'){
                  if(null!=mapordWithPri.get(payment.Order__c))
                    onlineRevenue+=mapordWithPri.get(payment.Order__c);
                }else if(payment.Registration_Type__c=='Onsite'){
                   if(null!=mapordWithPri.get(payment.Order__c))
                    onsiteRevenue+=mapordWithPri.get(payment.Order__c);
                }else{
                   if(null!=mapordWithPri.get(payment.Order__c))
                     mobileRevenue+=mapordWithPri.get(payment.Order__c);
                 }
                if(null!=mapordWithPri.get(payment.Order__c))
                  tempRev +=mapordWithPri.get(payment.Order__c);
             }
                innRevList.add(new innForPgateways(pgateWays,tempRev));
            }
          */
          System.debug(' totalcompOrders '+totalcompOrders);
          System.debug(' totalcanOrders '+totalcanOrders);
          System.debug(' totalOrders '+totalOrders);
          System.debug(' totalNoncompOrds '+totalNoncompOrds);
          System.debug(' totalTickets '+totalTickets);
          System.debug(' totalSoldTickets '+totalSoldTickets);
          System.debug(' totalcanTiccnt '+totalcanTiccnt);
          System.debug(' totalrevenue '+totalrevenue);
          System.debug(' onlineRevenue '+onlineRevenue);
          System.debug(' onsiteRevenue '+onsiteRevenue);
          System.debug(' mobileRevenue '+mobileRevenue);
          System.debug(' innRevList '+innRevList);
          System.debug(' ItemRevList '+ItemRevList);
          System.debug(' totalAttendee '+totalAttendee);
          System.debug(' MapItemWithChInQuantity '+MapItemWithChInQuantity);
          System.debug(' MapItemWithChOutQuantity  '+MapItemWithChOutQuantity );
        }

    public Class InnForPgateways{
       public String paygatey{get;set;}
       public Decimal revenue{get;set;}
       public innForPgateways(String pType,Decimal rev){
         //paygatey = new Pay_Gateway__c();
         paygatey =pType;
          if(null!=rev){
         revenue=rev;
          }else{
            revenue=0;
          }
       }
    }

   public Class InnForItemPrice{
      public BLN_Item__c item{get;set;}
      public Decimal itrevenue {get;set;}
      public Integer ItemQuantity{get;set;}
      public List<PackageItems> pitems{get;set;}
      public Integer chekinCont{get;set;}
      public Integer checloutCnt{get;set;}
      public decimal cancelledqty{get;set;}

      public InnForItemPrice(BLN_Item__c itm,Decimal irev,Integer Quan,List<Item_Pool__c> pLids,Decimal cancelledqty){
          item = new BLN_Item__c();
          this.cancelledqty=cancelledqty;
          item = itm;
           if(null!=irev){
          itrevenue = irev;
           }else{
            itrevenue =0.0;
           }
           if(null!=Quan){
          ItemQuantity = Quan;
           }else{
           ItemQuantity = 0;
           }
         pitems = new List<PackageItems>();
         chekinCont =0;
         checloutCnt=0;

          if(null!=pLids && pLids.size()>0){
            for(Item_Pool__c itpl : pLids){
             System.debug('KKKKKKKKKKK '+itpl);
             System.debug('AAAAAAAAAA  '+BLN_RegDashBoardInfo.MapItemWithChInQuantity);
             System.debug('BBBBBBBBBBB  '+BLN_RegDashBoardInfo.MapItemWithChOutQuantity);
             pitems.add(new PackageItems(itpl,BLN_RegDashBoardInfo.MapItemWithChInQuantity.get(itpl.id),BLN_RegDashBoardInfo.MapItemWithChOutQuantity.get(itpl.id)));
            }
          }else{
             if(null != BLN_RegDashBoardInfo.MapItemWithChInQuantity.get(item.id))
             chekinCont = BLN_RegDashBoardInfo.MapItemWithChInQuantity.get(item.id);
             if(null!=BLN_RegDashBoardInfo.MapItemWithChOutQuantity.get(item.id))
             checloutCnt = BLN_RegDashBoardInfo.MapItemWithChOutQuantity.get(item.id);

          }
      }
      }

 public class PackageItems{
   public Integer chekinCont {get;set;}
   public Integer checloutCnt {get;set;}
   public Item_Pool__c itempool{get;set;}

   public PackageItems(Item_Pool__c ip ,Integer pchQ,Integer pChoutQ){
     if(null == pchQ)
      chekinCont=0;
     else
     chekinCont =pchQ;

     if(null == pChoutQ)
      checloutCnt=0;
     else
     checloutCnt =pChoutQ;

     itempool = new Item_Pool__c();
     itempool = ip;
   }

   }

}