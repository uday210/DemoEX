@isTest
public class Test_BLN_Order_DAO {

    static testMethod void BLN_Order_DAO(){
    
    User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
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
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN); 
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
            
          
            
            BLN_Order_DAO ord= new BLN_Order_DAO();
              
            ord.insertOrder(insertOrder1);
            list<Order__c> ordList = new list<Order__c>([select id from Order__c]);
            SET<Id> ordId=new SET<id>();
            for(order__c o:ordList ){
                ordId.add(o.id);
            }
           ord.orderQuery(ordId);
           //string str = insertOrder1.Order_Status__c;
           try{
            String queryString= '';
        queryString= ' Order_Status__c = \''+insertOrder1.Order_Status__c+'\'';
           ord.orderQuery(queryString);
           }catch(exception e){}
           
           ord.orderQueryBadgableChildTicket(ordId);
           ord.orderQueryChildTicket(ordId);
           ord.orderQuery(ordId);
           ord.orderQueryChild('status',eventInfo.id);
           ord.orderQueryChildOrditem(ordId);
           ord.order(ordId);
           ord.orderListForEvent(eventinfo.id,system.today()-1,system.today());
           ord.orderListForEventSearch(string.valueof(eventinfo.id),system.today()-1,system.today(),'raje',ordId,'All');
           ord.orderListForEventSearch(string.valueof(eventinfo.id),system.today()-1,system.today(),'raje',ordId,'Successed');
           ord.orderListForEventSearch(string.valueof(eventinfo.id),system.today()-1,system.today(),'raje',ordId,'Cancelled');
           try{
           ord.orderListForEvent(string.valueof(eventinfo.id));
           }
           catch(Exception e){}
            //ord.orderQueryChild('raj',eventInfo.id);
           // ord.orderListForEventSearch(eventInfo.id,System.Today(),system.today()+2,null,SET<insertOrder1.id>,All);
            }
            }
            }