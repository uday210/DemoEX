@isTest
public class Test_BLN_ItemPool_BAL {

    static testMethod void testmethod_BLN_ItemPool_BAL(){
    
    User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
             Tkt_profile__c  tktprof = new Tkt_profile__c();
             tktprof=globalTest.createTktprofile(userForGN);
            
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Hash_Tag__c tagInfo1= new Hash_Tag__c();
	        tagInfo1= globalTest.createTag(eventInfo.Id);
            
            list<Hash_Tag__c> taglst= new list<Hash_Tag__c>();
            taglst.add(tagInfo1);
    
            LIST<BLN_Item__c> itemlst=new LIST<BLN_Item__c>();
            itemlst.add(item);
            
            LIST<Item_Pool__c> Poollist=new LIST<Item_Pool__c>();
            poollist.add(itempool);
    
   BLN_ItemPool_DAO im = new BLN_ItemPool_DAO();
   
     BLN_Hash_Tag_BAL bbb = new BLN_Hash_Tag_BAL();
       LIST<Item_Pool__c> np = new LIST<Item_Pool__c>();
         MAP<integer, LIST<Hash_Tag__c>> hb = new MAP<Integer, LIST<Hash_Tag__c>>();
         
            BLN_ItemType_BAL.ticketsinnerClass ticls=new BLN_ItemType_BAL.ticketsinnerClass(itemPool, Item , 1, itemType, poollist, itemlst,taglst);
         LIST<BLN_ItemType_BAL.ticketsinnerClass> ii = new LIST<BLN_ItemType_BAL.ticketsinnerClass>();
            ii.add(ticls);
   LIST<Database.UpsertResult> ll = new LIST<Database.UpsertResult>();
 
     string s = 'eventh';

            //********* ITEM POOL BAL ***************//
            
            BLN_ItemPool_BAL bl = new BLN_ItemPool_BAL();
            
    bl.createItemPool(ii,s);
            bl.createItemPool(ii,'');
 
    
    Item_Type__c ic = new Item_Type__c();
    MAP<Decimal, Item_Pool__c> hc = new MAP<Decimal, Item_Pool__c>();
            bl.createPackageItemPool(ii,eventInfo.Id,ic,hc );
    
    
    
    
       }
    }
    }