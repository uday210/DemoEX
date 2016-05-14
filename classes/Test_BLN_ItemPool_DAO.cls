/*************************************
 * New Test Class 
 * 9 Sep'15 
 * Vineel
**************************************/

@isTest
public class Test_BLN_ItemPool_DAO {

    public static testMethod void Test_BLN_ItemPool_DAO() {
        
        
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        System.runAs(U){
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();     
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
            
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
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, itemlr.Id, itemPoollr.Id, itemTypelr.Id, insertOrder1.Id, tktprof.Id);
            
            
            BLN_ItemPool_DAO itemdao = new BLN_ItemPool_DAO();
            
            
            itemdao.getPoolsBlongthatevent(eventInfo.Id);
            
            LIST<Item_Pool__c> lstpoo = new LIST<Item_Pool__c>();
            lstpoo.add(ItemPool);
            itemdao.createItemPools(lstpoo);
            
            List<String> lststg = new List<String>();
            lststg.add('ItemPool');
            itemdao.givesItemPools(lststg);
            
            itemdao.getPackageItemPools(lststg);
            itemdao.getItempool(ItemPool.Id);
            
        }
    }
    
}