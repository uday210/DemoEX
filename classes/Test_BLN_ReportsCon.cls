@isTest(SeeAllData=true)
public class Test_BLN_ReportsCon{

    static testmethod void Testmethod_BLN_ReportsCon(){
        
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
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
         
         
            PGateway_Type__c pgt = new PGateway_Type__c(Name='cash');
            insert pgt;
            
            
            Pay_Gateway__c pw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='cash',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Parallel');
            insert pw;
            
            Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c(Events__c=eventInfo.id,Pay_Gateway__c=pw.id,Registration_Type__c='Online');
            insert epg;
             Payment__c pp= new Payment__c();
            pp.BLN_Pay_Gateway__c=pw.id;
            pp.credit_card_last_4digits__c='1245';
            pp.credit_card_type__c='vasa';
            pp.Currency_Code__c=currenyInfo.id;
            pp.Order__c=insertOrder1.id;
            pp.Payment_Amount__c=100;
            pp.Payment_Mode__c='cash';
            insert pp;
            
              PageReference pageRef = Page.BLN_Mytickets;
          Test.setCurrentPage(pageRef);
            String nextPage =  ApexPages.currentPage().getUrl();
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
           // BLN_MyticketsCon bl = new BLN_MyticketsCon();
       
           // ApexPages.currentPage().setUrl(bl);
            
            BLN_ReportsCon reportTest= new BLN_ReportsCon();
            reportTest.AmountThroughCheck=10.0;
            reportTest.AmountThroughCredit=10.0;
            reportTest.AmountThroughCash=10.0;
            reportTest.displayOrders();
           // reportTest.loadstatictics();
            ApexPages.currentPage().getParameters().put('start','1'); 
            ApexPages.currentPage().getParameters().put('length','5'); 
            //reportTest.processData();
            ApexPages.currentPage().getParameters().put('selectorder','Successed'); 
            ApexPages.currentPage().getParameters().put('searchKey','test'); 
            ApexPages.currentPage().getParameters().put('fdate','01/05/2015'); 
            ApexPages.currentPage().getParameters().put('tdate','06/18/2015'); 
           // reportTest.processData();
            reportTest.printOrders();
            reportTest.hideEventsTab();
            reportTest.userSelectPerticularToExport();
            ApexPages.currentPage().getParameters().put('searchKey','test'); 
            ApexPages.currentPage().getParameters().put('fdate','01/05/2015'); 
            ApexPages.currentPage().getParameters().put('tdate','06/18/2015');
            reportTest.exportselected();
            
            List<Order__c> testOrderList = new List<Order__c>();
            for(integer i=0; i<1000; i++) {
               
                testOrderList.add( new Order__c(Order_Total__c=2,Amount_Paid__c=30.6,Fee_Amount__c=6.7,Currency_Code__c=currenyInfo.id));
            }
            insert testOrderList; 
            
            BLN_ReportsCon.paymentTypeInner pr = new  BLN_ReportsCon.paymentTypeInner('check',10.0);
            test.starttest();
            reportTest.selectedEvent=eventInfo.id;
         
            reportTest.displayOrders();
             reportTest.isEventAdmin=true;
              reportTest.isBoothadmin =true;
   reportTest.hideEventsTab();
   test.stoptest();
            /*BLN_ReportsCon reportTest2= new BLN_ReportsCon();
            
            reportTest2.displayOrders();
            
            reportTest2.SelectedEvent='';
            reportTest2.hideEventsTab();*/
            
             BLN_ReportsCon_BAL newbalrep = new BLN_ReportsCon_BAL();
            
            try{
            newbalrep.ordersListForSta('eventInfo.Id');
            } catch(exception ex){}
            
             
          
        }  
  
   }
  
}