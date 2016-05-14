@isTest
public class Test_BLN_ItemPromotion_DAO {

    public static testMethod void test_BLN_ItemPromotion_DAO(){
        
        
       
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
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            promotion1.T_Used_Count__c=2;
            update promotion1;
            
            Item_Promotion__c ItemPromotion= new Item_Promotion__c();
            ItemPromotion= globalTest.createItemPromotion(item.Id, Promotion1.Id, 'Amount');
            
            BLN_ItemPromotion_DAO itmprodao = new BLN_ItemPromotion_DAO();
            
            List<Item_Promotion__c> lstitmprom = new List<Item_Promotion__c>();
            lstitmprom.add(ItemPromotion);
            
                itmprodao.upsertitemPromotion(lstitmprom);
                itmprodao.getItemPromotions(ItemPromotion.Id);
                itmprodao.deleteitmprom(lstitmprom);
            
        }
        
    }
}