@isTest
public class Test_BLN_ExportOrders{

    static testmethod void Testmethod_BLN_ExportOrders(){
        
       // User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
       // U= globalTest.createUser();
        
          Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User u = new User(alias = 'Test', email='testcode123d@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode123d@noemail.com');
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
           string query = 'select id,name,Order_Status__c,CreatedDate,Amount_Paid__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Last_Name__c,BLN_TKT_profile__r.Email__c,BLN_tkt_profile__r.TKT_Company__c,(SELECT Id,name,Ticket_Status__c,ticket__c.item_type__r.name,Parent_ID__c,Ticket__c.Tkt_profile__r.Last_Name__c,Ticket__c.Tkt_profile__r.First_Name__c,Ticket__c.tkt_profile__r.email__c,Ticket__c.tkt_profile__r.TKT_Company__c,Ticket__c.Item_Pool__r.Item_Pool_Name__c,Ticket__c.Item__r.item_name__c,Ticket__c.Order_Item__r.Item_Fee__c,Ticket__c.Order_Item__r.Item_Discount__c,Ticket__c.item_pool__r.addon_parent__r.id FROM Tickets__r) from order__c limit 100';
           
           BLN_ExportOrders beo = new BLN_ExportOrders(query);
           beo.start(BC);
           Database.executeBatch(beo);
           test.stoptest();
            
           
           
            
             
          
        }  
  
   }
  
}