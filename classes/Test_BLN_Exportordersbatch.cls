@isTest
public class Test_BLN_Exportordersbatch{

    static testmethod void Testmethod_BLN_Exportordersbatch(){
        
            // User U= new User();
            globalForTestClass globalTest= new globalForTestClass();
            // U= globalTest.createUser();
            
            Profile p = [select id from profile where name='System Administrator'];
            userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
            
            User u = new User(alias = 'Test', email='testcodec123d@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
            localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
            timezonesidkey='America/Los_Angeles', username='testcodec123d@noemail.com');
            Database.insert(u);
            
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
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Order__c insertOrder1= new Order__c();
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof =globalTest.createTktprofile(userForGN);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.name = 'Admissions';
            update itemType;
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            Ticket__c ticket2= new Ticket__c();
            ticket2= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket2.Parent_ID__c = ticket.id;
            update ticket2;
            
            test.starttest();
            Database.BatchableContext BC;
            Database.QueryLocator QL;
            
            string query = 'Select (Select Item__r.Event__r.End_Date__c,Each_Ticket_Price__c,item__r.event__r.Name ,Promotion__c,Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c,order__r.BLN_TKT_profile__r.BLN_GN_User__c, order__r.BLN_TKT_profile__r.Email__c,Item_Quantity__c, Item_Price__c, Item_Discount__c, Id,item__r.item_name__c,Status__c,Promotion__r.Promo_Code__c,Currency__c,Item_Fee__c,Tax__c,item__r.item_type__r.Name,lastmodifieddate,Order__r.Events__r.BLN_Country__r.Currency__r.Currency_Symbol__c  From Order_Items__r ), (select id,name,Payment_Mode__c from Payments__r),EVent_Admin_Comments__c,createdDate,Events__r.Time_Zone__c,Events__r.Name,Events__r.Start_Date__c,Events__r.Venue_Name__c,Events__r.End_Date__c,Events__c, o.Fee_Amount__c, o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__r.BLN_Company__c, BLN_TKT_profile__r.Mobile__c,o.Amount_Paid__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.BLN_GN_User__r.User__r.id,BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName, BLN_TKT_profile__r.TKT_Company__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Last_Name__c From Order__c o LIMIT 1' ;            
            system.debug('yyyyyyy'+query.length());
            BLN_Exportordersbatch beo = new BLN_Exportordersbatch(query,'America/New_York','$');            
            beo.start(BC);            
            Database.executeBatch(beo);
            test.stoptest();
          
        }  
  
   }
  
}