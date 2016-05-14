@istest(Seealldata=true)
public class Test_BLN_OrderItem_BAL{
 public static testmethod void Test_BLN_OrderItem_BAL(){
  //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUser();
        Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User U = new User(alias = 'Test11', email='testcode3@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting11', Firstname='codeTesting12', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode3@noemail.com');
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
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
             Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            BLN_ASC_WS_SellTickets.OrderLineItem  or_item =new BLN_ASC_WS_SellTickets.OrderLineItem();
          
             or_item.TicketId = ticket.id;
             or_item.FirstName = 'test';
             or_item.LastName = 'tlast'; 
             or_item.EmailId = 'test@test.com';
             or_item.Company= 'mycomp';
             or_item.Phoneno ='9700772440';
             or_item.BadgeLabel = 'Blable';
             or_item.Tag ='xyx';
             or_item.Seatno ='10';
             or_item.Designation ='ceo';
             or_item.Note = 'sseew';
            list<BLN_ASC_WS_SellTickets.OrderLineItem> nlis=new list<BLN_ASC_WS_SellTickets.OrderLineItem>();
            nlis.add(or_item);
            
            BLN_ASC_WS_SellTickets.Orders ordee =new BLN_ASC_WS_SellTickets.Orders('10',item.id, 'itname', 'ittype', 'itempl', '2', '1', '1', '1', nlis);
           list<BLN_ASC_WS_SellTickets.Orders> lse =new list<BLN_ASC_WS_SellTickets.Orders>();
             lse.add(ordee);
             BLN_OrderItem_BAL Orditem= new BLN_OrderItem_BAL();
            Orditem.processOrderItems(gnUser.Id, eventInfo.id,companyInfo.id,insertOrder1.Id,countryInfo.id, lse);
            
          
 
            
 }
 
 
 }



}