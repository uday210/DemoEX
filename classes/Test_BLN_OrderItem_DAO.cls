@istest(seealldata=true)
public class Test_BLN_OrderItem_DAO{
 static testmethod void Test_BLN_OrderItem_DAO(){
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
             list<Order__c> order_l=new list<Order__c>();
             order_l.add(insertOrder1);
             set<id> oid = new set<id>();
             oid.add(insertOrder1.id);
             list<id> oid_l = new list<id>();
             oid_l.add(insertOrder1.id);
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
            
            
            
             Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            
            Order_Item__c  oritem = new Order_Item__c (Order__c = insertOrder1.Id,Item__c = item.Id,Currency__c = currenyInfo.Id,Item_Quantity__c = 2,Item_Total__c =40);
            BLN_OrderItem_DAO orditem = new BLN_OrderItem_DAO();
                  orditem .insertOrder(oritem);
                  list<Order_Item__c> oritem_li = new list<Order_Item__c>();
                  oritem_li.add(oritem);
                  orditem.updateOrder(oritem_li);
                  orditem.ordeIteam(userForGN.id);
                   orditem.getOrderItem(insertOrder1.Id,item.Id);
                   orditem.orderQueryTicketCh(oid);
                   orditem.getTicketsOfperticularOItem(string.valueof(insertOrder1.Id));
                   orditem.getTicketsOfperticularOItem(oid_l);
                   orditem.getTicketsOfperticularOItemList(oid);
                   orditem.validOrderItemList(eventInfo.id);
                   orditem.soldtickets(eventInfo.id);
                   
}
}
}