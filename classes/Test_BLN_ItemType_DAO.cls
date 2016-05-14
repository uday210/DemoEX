@isTest
public class Test_BLN_ItemType_DAO {
 public static testMethod void Test_BLN_ItemType_DAO() {
        
        
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
            
            Item_Type__c itemType1= new Item_Type__c();
            itemType1= globalTest.createItemType();
            
            
            Item_Type__c itemType2= new Item_Type__c();
            itemType2= globalTest.createItemType();
            
            Item_Type__c itemType3= new Item_Type__c();
            itemType3= globalTest.createItemType();
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            ItemType.Item_Type_Number__c='test';
            update ItemType;
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            Item_Pool__c ItemPoollr= new Item_Pool__c();
            ItemPoollr= globalTest.createItemPool(eventInfo.id, itemType1.Id, NULL,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            BLN_Item__c itemlr= new BLN_Item__c();
            itemlr= globalTest.createItem(ItemPoollr.Id, itemType1.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket.note__c = 'abcd';
            update ticket; 
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, itemlr.Id, itemPoollr.Id, itemType1.Id, insertOrder1.Id, tktprof.Id);
        
            Event_Price__c eventPriceInfo= new Event_Price__c();
            eventPriceInfo= globalTest.createEventPrice(eventInfo.Id, itemType1.Id);
            
             Event_Price__c eventPriceInfo2= new Event_Price__c();
            eventPriceInfo2= globalTest.createEventPrice(eventInfo.Id, itemType2.Id);
           
            Event_Price__c eventPriceInfo3= new Event_Price__c();
            eventPriceInfo3= globalTest.createEventPrice(eventInfo.Id, itemType3.Id);
            
            BLN_ItemType_DAO itDAO=new BLN_ItemType_DAO();
            list<String> itnlist=new list<String> ();
            itnlist.add(itemtype.Item_Type_Number__c);
                BLN_ItemType_DAO.AllItemTypes(itnlist);
            BLN_ItemType_DAO.eventOptionItemTypes(itnlist,eventinfo.id);
            BLN_ItemType_DAO.AdmissionItemTypes(ItemType.Item_Type_Number__c);
            BLN_ItemType_DAO.PackageItemTypes(ItemType.Item_Type_Number__c);
            
            SET<String> sset=new SET<String> ();
            sset.add(itemtype.Item_Type_Number__c);
            BLN_ItemType_DAO.itemTypesforTickets(sset);
            BLN_ItemType_DAO.itemTypesforIndividualTickets(sset,eventinfo.id);
            
        }
 }
            
}