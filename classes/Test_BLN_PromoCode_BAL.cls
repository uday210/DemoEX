@istest
public class Test_BLN_PromoCode_BAL {
   
    public static BLN_Event__c eventInfo{get;set;}
    public static Hash_Tag__c hashT{get;set;}
    public static Ticket__c ticket{get;set;}
    public static BLN_Item__c item{get;set;}
    public static Item_Pool__c ItemPool2{get;set;}
    public static User U{get;set;}
    public static User userForGN{get;set;}
    public static GN_User__c gnUser{get;set;}

public static testmethod void Test_BLN_PromoCode_BAL(){

   globalForTestClass globalTest= new globalForTestClass();
 BLN_PromoCode_BAL promotion_bal =new  BLN_PromoCode_BAL();
 
         U= new User();
        
        U= globalTest.createUser();
        system.runas(U){
 
         userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
           gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
             tktprof=globalTest.createTktprofile(userForGN);

            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            map<string , string > myp=new   map<string , string >();
                myp.put(string.valueof(item.id),string.valueof(item.id));
                 promotion_bal.findDupitems=myp;
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            list<Promotion__c > promotion_l= new list<Promotion__c >();
            promotion_l.add(promotion1);
            Item_Promotion__c itpormotion = new Item_Promotion__c();
            itpormotion =  globalTest.createItemPromotion(item.id,promotion1.id ,'Percent');
            itpormotion.free_item__c=null;
            update itpormotion;

            
            list<Item_Promotion__c> Dummy_itpormotion_l = new list<Item_Promotion__c>();
            list<Item_Promotion__c> itpormotion_l = new list<Item_Promotion__c>();
            itpormotion_l.add(itpormotion);
              Order_Item__c inorderitem= new Order_Item__c();
             inorderitem =   globalTest.createOrderItem(item.id,insertOrder1.id,promotion1.id,currenyInfo.id);
             MAP<Id,Item_Promotion__c> itpormotion_map=new MAP<Id,Item_Promotion__c>(itpormotion_l);
             MAP<Decimal,Item_Promotion__c> itmd=new MAP<Decimal,Item_Promotion__c>();
             itmd.put(10.0,itpormotion);
             MAP<Decimal,Promotion__c> itpromotion_map=new MAP<Decimal,Promotion__c>();
             itpromotion_map.put(10.0,promotion1);
              promotion_bal.basicitempromotions(promotion1.id+'-',true,itpormotion_l,itpormotion_map);
              promotion_bal.ItempromotionDupMAP = itpormotion_map;
              promotion_bal.delitempromolist =  itpormotion_l;
             promotion_bal.eventdetails(eventInfo.id);
             promotion_bal.itemslist(eventInfo.id);
             promotion_bal.itemPoollist(eventInfo.id);
             promotion_bal.getcurrencydetails(currenyInfo.id);
             promotion_bal.promotionslist(eventInfo.id);
             promotion_bal.getPromotionDetails(eventInfo.id,'Basic Promo1');
                promotion_bal.getItemPromotions(promotion1.id);
                promotion_bal.additem(itpormotion_l );
                promotion_bal.upsertpromotion(promotion_l,itpormotion_l );
                list<Item_Promotion__c> itpormotion_l_l =new list<Item_Promotion__c>();
                promotion_bal.savebuyxgetypromotion(promotion_l,itpormotion_l_l,itpormotion_l);
                promotion_bal.saveorderpromotion(promotion_l); 
                promotion_bal.deletemethod(itpormotion_l,itpormotion_map,itpormotion_l,itpormotion_map);
                promotion_bal.deletepromotionandip(promotion_l,itpormotion_l);
               
                promotion_bal.basicitempromotions(promotion1.id+'-',false,itpormotion_l,itpormotion_map);
               promotion_bal.deleteitempromoline('10',itmd);
               promotion_bal.deletepromoline('10',itpromotion_map);
               
               
                
                promotion_bal.itemslist(eventInfo.id);
                promotion_bal.itemPoollist(eventInfo.id);
                promotion_bal.getcurrencydetails(currenyInfo.Id);
                promotion_bal.promotionslist(eventInfo.id);
                promotion_bal.getPromotionDetails(eventInfo.id,'Promo');
                
                
               list<Item_Promotion__c> itempromotionlist = new list<Item_Promotion__c>();
               Item_Promotion__c itempromotion = new Item_Promotion__c();
                promotion_bal.upsertpromotion(promotion_l,itempromotionlist );
}


}

   public static testmethod void Test_BLN_PromoCode_BAL2()
    {
        globalForTestClass globalTest= new globalForTestClass();
        BLN_PromoCode_BAL promotion_bal =new  BLN_PromoCode_BAL();
        U= new User();
        U= globalTest.createUser();
        system.runas(U)
        {            
            userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
                       
            companyInfo= globalTest.createCompany(u.Companyname);
                        
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
                        
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
                        
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
                        
            gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
                        
            eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
                        
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
             tktprof=globalTest.createTktprofile(userForGN);

            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
                        
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
                        
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
                        
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
                        
            ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
                        
            item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            map<string , string > myp=new   map<string , string >();
            myp.put(string.valueof(item.id),string.valueof(item.id));
            
            
            promotion_bal.findDupitems=myp;
                        
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
             Promotion__c promotion3= new Promotion__c();
            promotion3= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');

            list<Promotion__c > promotion_l= new list<Promotion__c >();
            promotion_l.add(promotion1);
            Item_Promotion__c itpormotion = new Item_Promotion__c();
            itpormotion =  globalTest.createItemPromotion(item.id,promotion1.id ,'Percent');
            itpormotion.free_item__c=null;
            update itpormotion;
            
                        
            list<Item_Promotion__c> Dummy_itpormotion_l = new list<Item_Promotion__c>();
            list<Item_Promotion__c> itpormotion_l = new list<Item_Promotion__c>();
            
            Order_Item__c inorderitem= new Order_Item__c();
            inorderitem =   globalTest.createOrderItem(item.id,insertOrder1.id,promotion1.id,currenyInfo.id);
            MAP<Id,Item_Promotion__c> itpormotion_map=new MAP<Id,Item_Promotion__c>(itpormotion_l);
            MAP<Decimal,Item_Promotion__c> itmd=new MAP<Decimal,Item_Promotion__c>();
            itmd.put(10.0,itpormotion);
            MAP<Decimal,Promotion__c> itpromotion_map=new MAP<Decimal,Promotion__c>();
            itpromotion_map.put(10.0,promotion1);
            promotion_bal.ItempromotionDupMAP = itpormotion_map;
            promotion_bal.delitempromolist =  itpormotion_l;
            promotion_bal.eventdetails(eventInfo.id);
            promotion_bal.itemslist(eventInfo.id);
            promotion_bal.itemPoollist(eventInfo.id);
            promotion_bal.getcurrencydetails(currenyInfo.id);
            promotion_bal.promotionslist(eventInfo.id);
            //promotion_bal.getPromotionDetails(eventInfo.id,'Basic Promo1');
            promotion_bal.getItemPromotions(promotion1.id);
           
            promotion_bal.upsertpromotion(promotion_l,itpormotion_l );
            list<Item_Promotion__c> itpormotion_l_l =new list<Item_Promotion__c>();
            promotion_bal.savebuyxgetypromotion(promotion_l,itpormotion_l_l,itpormotion_l);
            promotion_bal.saveorderpromotion(promotion_l); 
            promotion_bal.deletemethod(itpormotion_l,itpormotion_map,itpormotion_l,itpormotion_map);
            //promotion_bal.deletepromotionandip(promotion_l,itpormotion_l);
            //promotion_bal.basicitempromotions(promotion1.id+'-',true,itpormotion_l,itpormotion_map);
            //promotion_bal.basicitempromotions(promotion1.id+'-',false,itpormotion_l,itpormotion_map);
            //promotion_bal.deleteitempromoline('10',itmd);
            //promotion_bal.deletepromoline('10',itpromotion_map);
                                                                                
            promotion_bal.itemslist(eventInfo.id);
            promotion_bal.itemPoollist(eventInfo.id);
            promotion_bal.getcurrencydetails(currenyInfo.Id);
            promotion_bal.promotionslist(eventInfo.id);
            promotion_bal.getPromotionDetails(eventInfo.id,'Promo');                           
                            
            list<Item_Promotion__c> itempromotionlist = new list<Item_Promotion__c>();
            Item_Promotion__c itempromotion = new Item_Promotion__c();
            promotion_bal.upsertpromotion(promotion_l,itempromotionlist );
            
            
            Promotion__c promotion2= new Promotion__c();
            
            promotion2= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Percent');
            set<string> str=new set<string>();
            LIST<Item_Promotion__c> ip=new LIST<Item_Promotion__c>();
            itpormotion_l.add(itpormotion);
            Item_Promotion__c i1=new Item_Promotion__c(Promotion__c=promotion1.id,Buy_Item__c='a089000000Mg123456');
            Item_Promotion__c i2=new Item_Promotion__c(Promotion__c=promotion1.id,Free_Item__c=item.id); 
            Item_Promotion__c i3=new Item_Promotion__c(Promotion__c=promotion1.id,Free_Item__c=item.id);
            Item_Promotion__c i4=new Item_Promotion__c(Promotion__c=promotion2.id,Free_Item__c='a089000000Mg123456');                       
            itpormotion_l.add(i1);
            itpormotion_l.add(i2);
            itpormotion_l.add(i3); 
            itpormotion_l.add(i4);           
            str= promotion_bal.additem(itpormotion_l);
            
            
            
            
        }
    }
    


}
