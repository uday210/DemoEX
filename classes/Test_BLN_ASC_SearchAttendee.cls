@isTest(SeeAllData=true)

public class Test_BLN_ASC_SearchAttendee {
    
    static testMethod void testMethod_Test_BLN_ASC_SearchAttendee(){
        
         
        globalForTestClass globalTest= new globalForTestClass();
        
        Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
        
        
        User U = new User(alias = 'Test1', email='testcode12333@noemail.com',
                          emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting1', Firstname='codeTesting1', languagelocalekey='en_US',
                          localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                          timezonesidkey='America/Los_Angeles', username='testcode12333@noemail.com');
        
        system.runas(U){
            
            User userInfo= new User();
            userInfo= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userInfo,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();      
            tktprof .First_Name__c= 'testnullfname';
            tktprof .Last_Name__c= 'testnnulllname';
            tktprof .Email__c= '';
            tktprof .TKT_Job_Title__c= userInfo.Title;       
            insert tktprof;
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             
            
            
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
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            Promotion__c promotion2= new Promotion__c();
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo1', 'Multi-Items Discount', 'Percent');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo2', 'Multi-Items Discount', 'Amount');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo3', 'Multi-Items Discount', 'Quantity');
            
            Promotion__c promotion3= new Promotion__c();
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo1', 'Buy Something Get Something', 'Percent');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo2', 'Buy Something Get Something', 'Amount');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo3', 'Buy Something Get Something', 'Quantity');
            
            Promotion__c promotion4= new Promotion__c();
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo1', 'Spend More Save More', 'Percent');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo2', 'Spend More Save More', 'Amount');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo3', 'Spend More Save More', 'Quantity');
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
            
            BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
            
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            
            Hash_Tag__c hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);
            
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'thirumala', 'globalnest');
            
        

            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            
            Order_Item__c  orderiteminfo =new Order_Item__c ();
            orderiteminfo = globalTest.createOrderItem(item.id, insertOrder1.id, promotion1.id, currenyInfo.id);
            
            System.RestContext.request = new RestRequest();
            
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestContext.request.addParameter('search_string', 'testnnulllname');
            RestContext.request.addParameter('Event_id',eventInfo.id);
            RestContext.request.addParameter('userId',Null);
             RestContext.request.addParameter('filterType',Null);
            
            RestContext.request.requestURI =  sfbaseURL+'/services/apexrest/BLN_ASC_SearchAttendee';  
            RestContext.request.httpMethod = 'POST';
            
            BLN_ASC_SearchAttendee blnascsrc = new BLN_ASC_SearchAttendee();
            BLN_ASC_SearchAttendee.ordersList = new BLN_Mytickets_BAL();
            BLN_ASC_SearchAttendee.ordersList.searchstring = 'testnnulllname';
            LIST<BLN_Mytickets_BAL.inncls>  inlists = new LIST<BLN_Mytickets_BAL.inncls>();
            inlists  = BLN_ASC_SearchAttendee.ordersList.userTickets('',eventInfo.id,'BLN_ASC_SearchAttendee','');
            
            List<BLN_ASC_Checkin.maincontainer> Mc = new List<BLN_ASC_Checkin.maincontainer> ();
                        
            BLN_ASC_Checkin.maincontainer wrap = new BLN_ASC_Checkin.maincontainer();
            BLN_ASC_Checkin.Ordersonly wrap1 = new BLN_ASC_Checkin.Ordersonly();
            wrap1.OrdersList_info = insertOrder1;
            BLN_ASC_Checkin.TotalList wrap2 = new BLN_ASC_Checkin.TotalList();
            wrap2.siteurl = 'wrap21';
            wrap2.isorder = true;

            BLN_ASC_SearchAttendee.doPost();
            
            
        
    }

}
    
    
}