/*************************************************************************
 * Developer: Vineel 
 * Date: 10 Sep' 2015
 * Purpose: New Test Class

**************************************************************************/
@isTest
public class Test_BLN_ItemType_BAL {

    public static testMethod void test_BLN_ItemType_BAL() {
        
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        System.runAs(U){
            
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
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            GN_User__c  gnUser1= new GN_User__c();
            gnUser1= globalTest.createGNUser(U,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Type__c itemTypelr= new Item_Type__c();
            itemTypelr= globalTest.createItemType13();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            Item_Pool__c ItemPoollr= new Item_Pool__c();
            ItemPoollr= globalTest.createItemPool(eventInfo.id, itemTypelr.Id, NULL,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            BLN_Item__c itemlr= new BLN_Item__c();
            itemlr= globalTest.createItem(ItemPoollr.Id, itemTypelr.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket.note__c = 'abcd';
            update ticket; 
            
            Event_Price__c evntpr = new Event_Price__c();
            evntpr= globalTest.createEventPrice(eventInfo.Id, itemTypelr.Id);

            Hash_Tag__c hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);

            BLN_ItemType_BAL blnitembal = new BLN_ItemType_BAL();
            
            LIST<Event_Price__c> lsteve = new LIST<Event_Price__c>();
            lsteve.add(evntpr);

               // BLN_ItemType_BAL.itemTypeSelectOptions(lsteve);
                        
            BLN_ItemType_BAL.boothleadsFeesStructure();
            BLN_ItemType_BAL.ticketOptions();
            
            LIST<Item_Pool__c> lsttmpool = new LIST<Item_Pool__c>();
            lsttmpool.add(ItemPool);
            
            LIST<BLN_Item__c> lstitm = new LIST<BLN_Item__c>();
            lstitm.add(item);
            
            LIST<Hash_Tag__c> lsthasgtg = new LIST<Hash_Tag__c>();
            lsthasgtg.add(hashT);
            
            item.price__c=11;
            item.item_count__c=1;
            update item;
            
            BLN_ItemType_BAL.addOnemoreTicket(ItemPool, item, 1234, itemType, lsttmpool, lstitm, lsthasgtg);
            
            LIST<Item_Type__c> lstitemtype = new LIST<Item_Type__c>();
            lstitemtype.add(itemType);
            try{
            blnitembal.eventOptiuonsTosave(lstitemtype ,eventInfo,gnUser,companyInfo,true, currenyInfo);
            }catch(exception ee){}
            LIST<Event_Price__c> epr=new LIST<Event_Price__c>();
            epr.add(evntpr);
            try{
            BLN_ItemType_BAL.itemTypeSelectOptions(epr);
             }catch(exception ee11){}
            BLN_ItemType_BAL.ticketsinnerClass tics=new BLN_ItemType_BAL.ticketsinnerClass();
            LIST<String> ipht=new LIST<String>{'test1','test2'};
            
            BLN_ItemType_BAL.ItemPoolTags ipt=new BLN_ItemType_BAL.ItemPoolTags(ItemPool,ipht);
            
    }
          
        
        
    }

}