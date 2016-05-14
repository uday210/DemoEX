@istest
public class Test_BLN_Promotion_DAO {
 public static BLN_Event__c eventInfo{get;set;}
    public static Hash_Tag__c hashT{get;set;}
    public static Ticket__c ticket{get;set;}
    public static BLN_Item__c item{get;set;}
    public static Item_Pool__c ItemPool2{get;set;}
    public static User U{get;set;}
    public static User userForGN{get;set;}
    public static GN_User__c gnUser{get;set;}





 public static testmethod void Test_BLN_Promotion_DAO(){
 
 
    globalForTestClass globalTest= new globalForTestClass();
 BLN_Promotion_DAO promotion =new BLN_Promotion_DAO();
 
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
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            list<Promotion__c > promotion_l= new list<Promotion__c >();
            promotion_l.add(promotion1);
            Item_Promotion__c itpormotion = new Item_Promotion__c();
            itpormotion =  globalTest.createItemPromotion(item.id,promotion1.id ,'Percent');
          
              Order_Item__c inorderitem= new Order_Item__c();
             inorderitem =   globalTest.createOrderItem(item.id,insertOrder1.id,promotion1.id,currenyInfo.id);
              
            string condi = ' Event__c=:'+eventInfo.id;
            string ss='SELECT ID,Name,Promo_Code__c,Promotion_Type__c,Exp_TimeStamp__c,Eff_TimeStamp__c,Discount_Value__c,Discount_Type__c,Event__c,Exclusive__c,I_Max_Count__c,T_Max_Count__c,T_Used_Count__c,Status__c,Type__C,Condition_Min_No__c ,Condition_Max_No__c,Daily_Start_Time__c,Daily_End_Time__c,(select id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Promotion__r.Event__c  from Item_Promotions__r), (SELECT ID, Item_Discount__c, Item_Price__c, Item_Quantity__c, Item_Total__c, Order__c,Order__r.Name,Order__r.Client_GN_User__r.First_Name__c,Order__r.Client_GN_User__r.Last_Name__c,Order__r.Order_Discount__c,Promotion__r.Discount_Type__c,Item__r.item_type__r.Name,Item__r.item_name__c ,Promotion__r.Name,Status__c FROM Order_Items__r) FROM  Promotion__c WHERE '+condi ;
           system.debug('###########'+ss);
           try{
            promotion.promotionslist(condi);
           } catch(Exception e){}
           promotion.UpsertPromotion(promotion_l);
            promotion.deleteprom(promotion_l);
        } 
 }
 }