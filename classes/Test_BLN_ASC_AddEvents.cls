@istest
public class Test_BLN_ASC_AddEvents {
    public static BLN_Event__c eventInfo{get;set;}
    public static Hash_Tag__c hashT{get;set;}
    public static Ticket__c ticket{get;set;}
    public static BLN_Item__c item{get;set;}
    public static Item_Pool__c ItemPool2{get;set;}
    public static User U{get;set;}
    public static User userForGN{get;set;}
    public static GN_User__c gnUser{get;set;}
    
    
    public static testmethod void Test_BLN_ASC_AddEvents (){
        U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        system.runas(U){
            //userForGN= new User();
            //userForGN= globalTest.createUserForGNUser();
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
            
            gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userInfo,countryInfo.Id, Stateinfo.Id);
            
            eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);
            
            List<BLN_Event__c>  EventsList = new List<BLN_Event__c>();
            eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userInfo);
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            item= new BLN_Item__c();
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
            
            hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);
            
            PGateway_Type__c pgt = new PGateway_Type__c(Name='cash');
            insert pgt;
            
            Pay_Gateway__c pw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='cash',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Parallel');
            insert pw;
            
            //ItemPool_Tag_Junction__c itemPJ = new ItemPool_Tag_Junction__c ();
            //itemPJ=globalTest.createtagjunction(itemPool.Id, hashT.Id);
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'thirumala', 'globalnest');
            
            //ticket= new Ticket__c();
            //ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id);
            
            ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            ticket.Custom_Barcode__c ='123455';
            update ticket;
            
             Tstatus__c tc= new Tstatus__c();
         tc.Device_Name__c='mobile';
         tc.Ticket__c=ticket.id;
         tc.Tstatus_name__c=true;
        insert tc;
        
        ticket.Tstatus_Id__c=tc.id;
        update ticket;
            
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestRequest req = new RestRequest(); 
            string currentdate='11/21/2014 9:00 PM';
            string Enddate='11/28/2014 9:00 PM';
            string ticopt='test';
            string feeopt='test1';
            /*req.addParameter('Event_id',eventInfo.id);
            req.addParameter('Start_date',currentdate);
            req.addParameter('End_date',Enddate);
            req.addParameter('ticketopt',ticopt);
            req.addParameter('feeopt',feeopt);*/
            req.addParameter('Userid',userInfo.id);
            req.addParameter('CompanyId',companyInfo.id);
            
            req.requestURI = sfbaseURL+'/services/apexrest/BLN_ASC_EditTickets';  
            req.httpMethod = 'POST';
            //string bodys= '[{"tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "a0tc0000002coCMAAY","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}]';
           
            string bodys = '{"AttendeeReg":"", "CurrencySetting":"USD", "EventCategory":"", "EventCity":"", "EventCountry":"'+countryInfo.id+'", "EventDesc":"", "EventEDate":"02/27/2016 10:45 PM", "EventHashTag":"", "EventID":null, "EventLocation":"taj", "EventName":"for debug", "EventOrgEmail":"hegotthelogic@gfcforce.com", "EventSDate":"02/27/2016 01:45 PM", "EventState":"", "EventStatus":"Live", "FacebookUrl":"", "HostingAddress1":"", "HostingAddress2":"", "HostingTimeZone":"America/New_York", "Image":"", "LanguageSetting":"en_US", "OrgName":"test", "PhoneNo":"1234567890", "TwitterUrl":"", "WebUrl":"", "ZipCode":"12333"}';
            //'{"poolid" : "","trowid":"1", "tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
            blob b = blob.valueOf(bodys);
           req.requestBody  = b;
            RestContext.request = req;
             /*
             blob b = blob.valueOf(bodys);
            string bodd = EncodingUtil.base64encode(b);
            blob b1 = blob.valueOf(bodd);
            req.requestBody= b1;*/
            
             //try{
                BLN_ASC_AddEvents.dopost();    
          //}catch(exception e){}
            
            
           BLN_ASC_AddEvents.maincontainer wrap = new BLN_ASC_AddEvents.maincontainer();
           wrap.Events=eventInfo;
           wrap.roles='testrole';
           wrap.company='testcompany';
           wrap.image='testimage';
           wrap.RegistrationLink='testRegistrationLink';
           wrap.StripeEventdexClientID='testStripeEventdexClientID';
           wrap.StripeEventdexSecretKey='testStripeEventdexSecretKey';
     
           
           String sType='{"tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "a0tc0000002coCMAAY","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
           //String sType='[0]';
           blob bType = blob.valueOf(sType);
           String sTemp = EncodingUtil.base64Encode(bType);
           System.debug('#########'+sTemp );
           BLN_ASC_AddEvents.EventInfo eventInfoObj = new BLN_ASC_AddEvents.EventInfo(sTemp,'test','12/12/2014 10:00 PM','12/12/2014 11:00 PM','hyd','thiru@gmail.com',eventInfo.id,'test','rupee','test','sec','india','6','test','ap','process','test','test','test','test','test','test','test','test','test','test'); 
           
           //BLN_ASC_AddEvents.EventsList.add(new BLN_Event__c(eventInfo));
           
           BLN_ASC_AddEvents BLNObj = new BLN_ASC_AddEvents();
           
           BLN_ASC_AddEvents.MC = new BLN_ASC_AddEvents.maincontainer();
           BLN_ASC_AddEvents.EventsList = new List<BLN_Event__c>();
           BLN_ASC_AddEvents.Event = new BLN_Event__c();
           BLN_ASC_AddEvents.Eventclass = new BLN_Events_BAL();
           BLN_ASC_AddEvents.Eventsbal = new BLN_Events_BAL();
           BLN_ASC_AddEvents.companyName = 'test11';
           
           eventInfoObj.EventStatus = 'tst123';

           //BLN_ASC_AddEvents.EventInfo eveaddeve= new BLN_ASC_AddEvents.EventInfo();
            
        
        }
    }
}