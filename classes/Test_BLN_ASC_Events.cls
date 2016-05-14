@istest(SeeAllData=true)
public class Test_BLN_ASC_Events {
    static testmethod void Test_BLN_ASC_Events (){
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
            
            Role__c Role= new Role__c();
            Role= globalTest.createRole();
            
            UC_Role__c ucr=new UC_Role__c();
            ucr = globalTest.createUCRole(companyInfo.Id,eventInfo.Id, gnUser.Id, userForGN.Id, Role.Id);
            
           // Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
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
            
            //ItemPool_Tag_Junction__c itemPJ = new ItemPool_Tag_Junction__c ();
            //itemPJ=globalTest.createtagjunction(itemPool.Id, hashT.Id);
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'Display', 'Time Out');
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            string sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            
            RestRequest req = new RestRequest(); 
            string currentdate='11/21/2014 9:00 PM';
            string Enddate='11/28/2014 9:00 PM';
            string ticopt='test';
            string feeopt='test1';
            req.addParameter('Event_id',eventInfo.id);
            req.addParameter('Start_date',currentdate);
            req.addParameter('End_date',Enddate);
            req.addParameter('ticketopt',ticopt);
            req.addParameter('feeopt',feeopt);
            req.addParameter('User_id',userForGN.Id);
            req.requestURI = sfbaseURL+'/services/apexrest/BLN_ASC_EditTickets';  
            req.httpMethod = 'POST';
            //string bodys= '[{"tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "a0tc0000002coCMAAY","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}]';
           
            string bodys = '{"poolid" : "","trowid":"1", "tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
            blob b = blob.valueOf(bodys);
            req.requestBody  = b;
            RestContext.request = req;
            
            PGateway_Type__c pgt = new PGateway_Type__c(Name='cash');
            insert pgt;
            
            Pay_Gateway__c pw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='cash',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Parallel');
            insert pw;
            
             list<BLN_Event__c> EventsList = new list<BLN_Event__c>();
             list<Id> Ids = new list<Id>();
            BLN_Events_BAL evntsBal = new BLN_Events_BAL();
           
            for(BLN_Event__c evn :EventsList  ) { Ids.add(evn.Id); }
            
            
            system.debug('---listOfEvents----> '+EventsList);
            
           //BLN_ASC_EditTickets.subpackagegroup subpackagegroup = new BLN_ASC_EditTickets.subpackagegroup ('Test','Test','Test','Test','Test');  
           //BLN_ASC_EditTickets.grouptickets grouptickets  = new BLN_ASC_EditTickets.grouptickets('Test','Test','Test','Test','Test','Test','Test','Test'); 
           //BLN_ASC_EditTickets.tags tags = new BLN_ASC_EditTickets.tags ('Test');           
           
           //list<BLN_ASC_EditTickets.grouptickets> lstGroup = new list<BLN_ASC_EditTickets.grouptickets>();
           //lstGroup.add(grouptickets);
           
           //list<BLN_ASC_EditTickets.subpackagegroup> lstSubPAckage = new list<BLN_ASC_EditTickets.subpackagegroup>();
           //lstSubPAckage.add(subpackagegroup );
           
           //list<BLN_ASC_EditTickets.tags> lstTags = new list<BLN_ASC_EditTickets.tags>();
           //lstTags.add(tags);
           
           String sType='[{"tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "a0tc0000002coCMAAY","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}]';
           blob bType = blob.valueOf(sType);
           String sTemp = EncodingUtil.base64Encode(bType);
           System.debug('#########'+sTemp );
           MAP<id,Integer> mapEvIdWithSessionTime1 =NEW MAP<id,Integer>();
           mapEvIdWithSessionTime1.put(eventInfo.id,10);
           system.debug('map@@'+mapEvIdWithSessionTime1);
           BLN_ASC_Events.mapEvIdWithSessionTime = mapEvIdWithSessionTime1;
           system.debug('#####@@@@'+BLN_ASC_Events.mapEvIdWithSessionTime);
          
           BLN_ASC_Events.Container wrap = new BLN_ASC_Events.Container(eventInfo,'test','test','test','test','test','test','test','test','test');
           BLN_ASC_Events.ct2 = new List<BLN_ASC_Events.ItemType_info>();
           BLN_ASC_Events.moddate = system.today();
           BLN_ASC_Events.Container wrapTemp = new BLN_ASC_Events.Container();
           BLN_ASC_Events.profile_info wrap1=new BLN_ASC_Events.profile_info(); 
          // BLN_ASC_Events.Countries_info wrap2=new BLN_ASC_Events.Countries_info();
          // BLN_ASC_Events.Countries_info wrap22=new BLN_ASC_Events.Countries_info(countryInfo , Null, Null);  
           BLN_ASC_Events.ItemType_info wrap3=new BLN_ASC_Events.ItemType_info(); 
           BLN_ASC_Events.ItemType_info wrap33=new BLN_ASC_Events.ItemType_info('test','test',0.00,0.00);//
           BLN_ASC_Events.UpcomingEvents wrap4=new BLN_ASC_Events.UpcomingEvents();
           BLN_ASC_Events.UpcomingEvents wrap44=new BLN_ASC_Events.UpcomingEvents(eventinfo,'test','test',sTemp,'');
           BLN_ASC_Events.maincontainer wrap5=new BLN_ASC_Events.maincontainer();
           
           wrapTemp.lastRefreshDate='test';
          // wrapTemp.Profile=new GN_User__c();
           wrapTemp.ListofEvents=new List<BLN_Event__c>();
                     
            BLN_ASC_Events BLNObj = new BLN_ASC_Events();
            BLN_ASC_Events.uemailid='gnuser@noemail.com';
            BLN_ASC_Events.ct1=wrap1;
           /* wrap.profileimage = 'pfimg';
            wrap.profilestate = 'pfstat';
            wrap.profilecountry = 'pfcoun';
            */
            
            
            
            wrap1.designation= 'gnUser';
            wrap1.Profile = gnUser;
            wrap1.Userid='usrids';
            wrap1.profileimage = 'upfimg';
            wrap1.profilestate = 'upfstt';
            wrap1.profilecountry = 'upfcou';
           // wrap2.currencym = currenyInfo;
            //wrap2.States =stateInfo;
            wrap4.Events=eventInfo;
            
            wrap4.roles='wrols';
            wrap4.company = 'wcomp';
            wrap5.Profile=wrap1;
            wrap5.StripeEventdexClientID='Bobjsti';
            wrap5.StripeEventdexSecretKey='Bobjsec';
             wrap5.PGatewaytypes=new LIST<PGateway_Type__c>();
              wrap5.PayGateways=new LIST<Pay_Gateway__c>();
            
            /*wrap5.PGatewaytypes[0] = pgt;
			wrap5.PayGateways[0] = pw;*/
            
            //BLN_ASC_Events.ct2=wrap33;
            
            System.RestContext.request = new RestRequest();
            string Eventid = eventInfo.id;
            RestContext.request.requestURI ='/GlobalnestEM/BLN_ASC_Events';
            RestContext.request.addParameter('appname','Test' );
            RestContext.request.addParameter('User_id',userForGN.Id); 
            //ticket.Client_GN_User__r.id= gnUser.Id;
            try{
             EventsList = evntsBal.listOfEvents(userForGN.Id);
             //   BLN_ASC_Events.dopost();    
            }catch(Exception Ex){ } 
            //BLN_ASC_Events blnevns = new BLN_ASC_Events(); 
           // BLN_ASC_Events.moddate= null;
            //BLN_ASC_Events.Container wrapTemp2 = new BLN_ASC_Events.Container();
            //wrapTemp2.ListofEvents=new List<BLN_Event__c>();
           // wrapTemp2.Profile=null;
           
          
            RestContext.request.addParameter('appname','eventdex' );
            EventsList = evntsBal.listOfEvents(userForGN.Id);
            try{
             
            //    BLN_ASC_Events.dopost();    
            }catch(Exception Exc){ } 
            
            
        
        }
    }
}