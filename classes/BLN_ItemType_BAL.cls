public with sharing class BLN_ItemType_BAL {

/***********************************************************************************************
*   Controller Name : BLN_ItemType_BAL
*   Date            : 19/05/2014
*   Author          : Naga Mallikarjuna Rao B
*   Purpose         : This class is for Item Types Business Application Layer
*   Change History  : 19/05/2014 
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   19/05/2014          Naga Mallikarjuna Rao B           To Create Page
**************************************************************************************************/
    
    
    public static LIST<SelectOption> itemTypeSelectOptions(LIST<Event_Price__c> itemTypes){
        
        LIST<SelectOption> ItemTypesOptions = new LIST<SelectOption>();
        
        for(Event_Price__c itt : itemTypes ){

            ItemTypesOptions.add(new SelectOption(itt.item_type__r.id, itt.item_type__r.Name));
        }
        
        return ItemTypesOptions;
        
    }
     
     //Used in Events page
     public static LIST<SelectOption> boothleadsFeesStructure(){
        
        LIST<SelectOption> ticketServiceFee  = new LIST<SelectOption>();
        
        ticketServiceFee.add(new SelectOption('AddFee' , 'Add Eventdex fee on top of the total ticket price' )); 
        ticketServiceFee.add(new SelectOption('IncludeFee' , 'Include the Eventdex fee in to the total ticket price' )); 
        
        return ticketServiceFee;
        
     }
     
     
     //Used in Events page
     public static LIST<SelectOption> ticketOptions(){
        
        LIST<SelectOption> ticketServiceFee  = new LIST<SelectOption>();
        
        ticketServiceFee.add(new SelectOption('AddFee' , 'Add Eventdex fee on top of the total ticket price' )); 
        ticketServiceFee.add(new SelectOption('IncludeFee' , 'Include the Eventdex fee in to the total ticket price' )); 
        
        return ticketServiceFee;
        
     }
     
     
     
     // Create New Ticket In Events Page..........................................
    
     public static ticketsinnerClass addOnemoreTicket(Item_Pool__c  itemPoolForInnerClass,  BLN_Item__c blnItems, integer counteruniqueNo, Item_Type__c admissionItemType, LIST<Item_Pool__c> itemPools, LIST<BLN_Item__c> itemsList, LIST<Hash_Tag__c> itemHashTags /*, LIST<ItemPoolTags> itpTags*/){
          
      //  insertTickets.add(new ticketsinnerClass( itemPoolForInnerClass , blnItems, counteruniqueNo, admissionItemType, itemPools) );
        
         return (new ticketsinnerClass( itemPoolForInnerClass , blnItems, counteruniqueNo, admissionItemType, itemPools, itemsList, itemHashTags /*, itpTags*/));
        
    }
      
    
    
     public Decimal eventPriceToCharge{get;set;}
     public void eventOptiuonsTosave(LIST<Item_Type__c> itemTypes, BLN_Event__c event, GN_User__c gnUser, Company__c comp, Boolean saveOrder, Currency__c cur ){
        
        LIST<Item_Pool__c> eventadminItemPools = new LIST<Item_Pool__c>();
        LIST<BLN_Item__c> eventAdminItems = new LIST<BLN_Item__c>();
         
        eventPriceToCharge=0.0;
        system.debug('LLLLLLLLLLLLLLLLLL KKKKKKKKKKKKKKKKKKKKKKKKK '+event);
        BLN_EventOptions_DAO togetEventOptions = new BLN_EventOptions_DAO();
        MAP<id, Event_Price__c> eventOptionsPrice = new MAP<id, Event_Price__c>();
        //commented
         eventOptionsPrice = togetEventOptions.queryEventOptions(event.id);
         
         
        for(Item_Type__c itp: itemTypes){
            
            Item_Pool__c itemPools = new Item_Pool__c();
            
            if(eventOptionsPrice.containsKey(itp.id)){
                Event_Price__c eventPrice = new Event_Price__c();
                eventPrice = eventOptionsPrice.get(itp.id);
                
                if(eventPrice.Item_Count__c  != NULL)
                    itemPools.Item_Count__c  = eventPrice.Item_Count__c;
                else
                    itemPools.Item_Count__c =1;
            }else{
                itemPools.Item_Count__c = 1;
            }
            
            
            itemPools.Item_Pool_Name__c = itp.Event_Option_Desc__c;
            itemPools.Event__c = event.Id;
            itemPools.Item_Type__c = itp.id;
            itemPools.Package_Flag__c = 'I - Individual Item pool';
            itemPools.Badgable__c = 'N - No Badge';
             
              eventadminItemPools.add(itemPools);
        }
        //Here insert all ItemTypes Byselecting the values
        BLN_ItemPool_DAO itemPoolDAO = new BLN_ItemPool_DAO();
        itemPoolDAO.createItemPools(eventadminItemPools);
        
        
        system.debug('Item_Pool_Name__c Item_Pool_Name__c Item_Pool_Name__c Item_Pool_Name__c Item_Pool_Name__c '+eventadminItemPools );
        
        // get Event options price from Event_Price Object 
         
        
        for(Item_Pool__c ipool: eventadminItemPools){
            
            BLN_Item__c blnItem = new BLN_Item__c();
            
            Event_Price__c eventPrice = new Event_Price__c();
            if(eventOptionsPrice.containsKey(ipool.Item_Type__c)){
                
                eventPrice = eventOptionsPrice.get(ipool.Item_Type__c);
                if(eventPrice.BL_Fee_Amount__c != NULL)
                    eventPriceToCharge += eventPrice.BL_Fee_Amount__c;
            }
            

            blnItem.item_type__c = eventPrice.Item_type__c; 
            blnItem.Event__c = ipool.Event__c;
            blnItem.item_name__c = eventPrice.Item_type__r.Event_Option_Desc__c; 
            blnItem.item_count__c = ipool.Item_Count__c;
            blnItem.Payment__c = 'Paid';
            blnItem.price__c = eventPrice.BL_Fee_Amount__c;
            
            integer sthrs=0;
            integer stmin=0;
            //To find Sale Start DateTime................................................
           /* if(event.Start_Time__c != null){
                if(event.Start_Time__c.contains(':')){
                     LIST<String> splitTimes = new LIST<String>();
                     
                     splitTimes = event.Start_Time__c.split(':');
                     
                     if(splitTimes.size() == 2){
                        
                        //Assign Hrs....................
                        if(splitTimes[1].containsIgnoreCase('PM')){
                            sthrs = integer.valueOf(splitTimes[0]+12);
                        }else{
                            sthrs = integer.valueOf(splitTimes[0]);
                        }
                        //Assign Minuts....................
                        if(splitTimes[1].containsIgnoreCase(' ')){
                            if(splitTimes[1].split(' ')[0].isNumeric()     ){
                                stmin = integer.valueOf(splitTimes[1].split(' ')[0]);  
                            }
                        }
                     }
                     
                }
            }
            if(stmin != 0 && sthrs != 0){
                blnItem.sale_start__c =  DateTime.newInstance(event.Start_Date__c.year() , event.Start_Date__c.month(), event.Start_Date__c.day(), sthrs, stmin, 0);
            }
            
            sthrs=0;
            stmin=0;
            
            // To find Sale End dateTime.................................................................
            if(event.End_Time__c != null){
                if(event.End_Time__c.contains(':')){
                     LIST<String> splitTimes = new LIST<String>();
                     
                     splitTimes = event.End_Time__c.split(':');
                     
                     if(splitTimes.size() == 2){
                        
                        //Assign Hrs....................
                        if(splitTimes[1].containsIgnoreCase('PM')){
                            sthrs = integer.valueOf(splitTimes[0]+12);
                        }else{
                            sthrs = integer.valueOf(splitTimes[0]);
                        }
                        //Assign Minuts....................
                        if(splitTimes[1].containsIgnoreCase(' ')){
                            if(splitTimes[1].split(' ')[0].isNumeric()){
                                stmin = integer.valueOf(splitTimes[1].split(' ')[0]);  
                            }
                        }
                     }
                     
                }
            }
            
            if(stmin != 0 && sthrs != 0){
                blnItem.sale_end__c = DateTime.newInstance(event.Start_Date__c.year() , event.Start_Date__c.month(), event.Start_Date__c.day(), sthrs, stmin, 0);
            }*/
            
            //added instead of above commented code
            blnItem.sale_start__c = event.Start_Date__c;
            blnItem.sale_end__c = event.End_Date__c;
            //end of added instead of above commented code
            
            
            blnItem.Item_Pool__c = ipool.id;
            blnItem.Visibility__c = 'public';
            
            
            eventAdminItems.add(blnItem);
        }
        
        BLN_Item_DAO itemDAO = new BLN_Item_DAO();
        LIST<Database.Upsertresult> itemSuccessBool = itemDAO.upsertItems(eventAdminItems);
        
        system.debug('UUUUUUUUUUUUUUUUUUUUUUUU @@@@@@@@@@@@@@@@ '+itemSuccessBool);
        
        LIST<ID> successIds = new LIST<ID>();
        
        for(Database.Upsertresult item: itemSuccessBool){
            if(item.isSuccess())
                successIds.add(item.getId());
        }
        
        LIST<Ticket__c> itemtickets = new LIST<Ticket__c>();
        BLN_Ticket_DAO blnTicket = new BLN_Ticket_DAO();
        itemtickets = blnTicket.getSelectedTickets(successIds);
        
        
        
        system.debug('Item_Pool_Name__c Item_Pool_Name__c Item_Pool_Name__c Item_Pool_Name__c Item_Pool_Name__c 22222222222222      '+itemtickets.size() );
        
        
        LIST<Ticket__c> eventOptionTickets = new LIST<Ticket__c>();
        
        for(BLN_Item__c ite: eventAdminItems){
            Ticket__c t = new Ticket__c();
            
            t.Event__c = event.id;
            t.tkt_profile__r.bln_company__c=  comp.id;
            t.Item__c = ite.id;
            t.tkt_profile__r.bln_gn_user__c = gnUser.id;
            t.Ticket_Status__c = 'Available';
            t.Item_Pool__c = ite.Item_Pool__c;
            t.Item_Type__c = ite.item_type__c;
            
            
             eventOptionTickets.add(t);
        }
        
        BLN_Ticket_DAO toUpsertTickets = new BLN_Ticket_DAO();
     // toUpsertTickets.updteTickets(eventOptionTickets);
        
        //system.debug('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFinal Tickets   111111111111111111   '+ ite);
        
        
        if(saveOrder){
            Order__c o = new Order__c();
            
             o.Events__c = event.id;
             o.bln_tkt_profile__r.bln_company__c= comp.Id;
             o.bln_tkt_profile__r.bln_gn_user__c=  gnUser.id;
             o.Currency_Code__c = cur.id;
             o.Order_Status__c = 'Not Paid';
             o.Order_Total__c = eventPriceToCharge;
              
            DataBase.Saveresult orderSaveRes = DataBase.insert(o);
            
            LIST<Order_Item__c> orderLineItems = new LIST<Order_Item__c>();
            if(orderSaveRes.isSuccess()){
                for(BLN_Item__c ite: eventAdminItems){
                        system.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD   22222222222222222222222   '+ ite);
                    Order_Item__c l = new Order_Item__c();
                    l.Item__c = ite.id;
                    l.Order__c = orderSaveRes.getId();
                    l.Currency__c = cur.id;
                    l.Item_Quantity__c = ite.item_count__c;
                    l.Item_Price__c = ite.price__c;
                    l.Item_Total__c =  (ite.item_count__c * ite.price__c);
                    l.Status__c = 'Active';
                    
                    //orderLineItems.
                }
                
            }
            
            
            
        }
        
        
        
        
     }
     
     
     
     
      
    // wrapper Class for All Tickets and packages  
    public class ticketsinnerClass{
        
        public Item_Pool__c itemPool{get; set;}
        public BLN_Item__c items{get; set;}
        public integer count{get; set;}
        public LIST<BLN_Item__c> itemsList{get; set;}
        public LIST<Item_Pool__c> packageItemPools{get; set;}
        public Item_Type__c itemTypes{get; set;}
        public LIST<Hash_Tag__c> hashTagsForPool{get; set;}
        public LIST<String> hashTagsToshow{get; set;}
        public LIST<ItemPoolTags> itemPoolTags{get; set;}
        public Boolean displayInPage{get; set;}
        public Boolean displayWaterMark{get; set;}
        public decimal waterMarkAmount{get; set;}
        
        public ticketsinnerClass(){
            
             itemsList = new LIST<BLN_Item__c>();
             packageItemPools = new LIST<Item_Pool__c>();
             hashTagsForPool = new LIST<Hash_Tag__c>();
               hashTagsToshow = new LIST<String>();
               itemPoolTags = new LIST<ItemPoolTags>();
        }
        
        
        public ticketsinnerClass(Item_Pool__c itemPoolFromMain, BLN_Item__c BLNItems , integer counter, Item_Type__c itType, LIST<Item_Pool__c> pakItemPool, LIST<BLN_Item__c> ItemsForBird, LIST<Hash_Tag__c> itemHashTags /* , LIST<ItemPoolTags> itpTags*/){
               itemPool = new Item_Pool__c();
               items = new BLN_Item__c ();
               itemsList = new LIST<BLN_Item__c>();
               packageItemPools = new LIST<Item_Pool__c>();
               itemTypes = new Item_Type__c(); 
               hashTagsForPool = new LIST<Hash_Tag__c>();
               hashTagsToshow = new LIST<String>();
               itemPoolTags = new LIST<ItemPoolTags>();
               displayInPage = TRUE;
               displayWaterMark = FALSE;
               waterMarkAmount =0.00;
               
             system.debug('%%%%%%%%%%%%%%%%%%%%%%%      '+itemPool);  
               //admissionItemType
              if(ItemsForBird.size() > 0){
                itemsList.addAll(ItemsForBird);
              } else{
                 itemsList.add(BLNItems );
              } 
              
               itemPool = itemPoolFromMain;
               
               system.debug(' ITEM_Type_BAL    itemPool.Item_Type__c    itType.id  '+itType.id+'     '+ itemPool.Item_Type__c);  
               
               if(itemPool.Item_Type__c == null || itemPool.Item_Type__c != itType.id){
                 itemPool.Item_Type__c = itType.id;
               }  
               
               if(BLNItems.Payment__c == null){
                    BLNItems.Payment__c = 'Paid';
               }
                        
               items  = BLNItems ;
               count = counter;
               itemTypes = itType;
               packageItemPools = pakItemPool;
               hashTagsForPool = itemHashTags;
              // itemPoolTags = itpTags;
               
               for(Hash_Tag__c ht: itemHashTags){
                hashTagsToshow.add(ht.Tag_Text__c);
               }
                    
                 
              
               
         }    
    
    
    }
    
    
    
    
    public class ItemPoolTags{
        
        public LIST<String> itemPoolTags{get; set;}
        public Item_Pool__c itemPool{get; set;}
        
        public ItemPoolTags(Item_Pool__c ipool, LIST<String> ipht){
            itemPoolTags = new LIST<String>();
            itemPool = new Item_Pool__c();
            
            itemPoolTags.addAll(ipht);
            itemPool = ipool;
                        
        }
        
    }
    
    
    
    
}