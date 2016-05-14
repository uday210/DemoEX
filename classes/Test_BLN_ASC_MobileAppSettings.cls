@isTest

public class Test_BLN_ASC_MobileAppSettings {
    
    static testMethod void testMethod_Test_BLN_ASC_MobileAppSettings(){
        
        //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUser();
        Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
        
        
        User U = new User(alias = 'Test1', email='testcode12333@noemail.com',
                          emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting1', Firstname='codeTesting1', languagelocalekey='en_US',
                          localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                          timezonesidkey='America/Los_Angeles', username='testcode12333@noemail.com');
        
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
            ItemPool.Item_Type__r.Name = 'MatchLeads Buyer';
            update ItemPool;
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
             ItemPool2.Item_Type__r.Name = 'MatchLeads Buyer';
            update ItemPool2;
            
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
            usrAns=globalTest.createUserAnswer(tktprof.id,itemQue.Id, ans.Id);
            
            Ticket__c ticket= new Ticket__c();
            // ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id);
            
            ticket.Event__c = eventInfo.id;
            ticket.Item__c = item.Id;
            ticket.Item_Pool__c = itemPool.Id;
            ticket.Item_Type__c = itemType.Id;                    
            ticket.Badge_Label__c =  'badgeLabel';
            ticket.Order__c= insertOrder1.Id;
            ticket.Ticket_Status__c= 'Available';
            //ticket.Client_GN_User__c = gnUser.Id;
            insert ticket;
            
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
            
            Reg_Setting__c rsett = new Reg_Setting__c();
            rsett.Column_Name__c = Null;
            rsett.Defaullt_Label__c ='Speakers';
            rsett.Event__c = eventInfo.id;
            rsett.Label_Name__c = 'Speakers';
            rsett.Included__c =true;
            rsett.Setting_Type__c='Eventdexapp';
            insert rsett;
            
            Reg_Setting__c rsett1 = new Reg_Setting__c();
            rsett1.Column_Name__c = Null;
            rsett1.Defaullt_Label__c ='Attendees';
            rsett1.Event__c = eventInfo.id;
            rsett1.Label_Name__c = 'Attendees';
            rsett1.Included__c =true;
            rsett1.Setting_Type__c='Eventdexapp';
            insert rsett1;
            
           Item_Type__c Itemtype1= new Item_Type__c();
            Itemtype1.Name= 'Seminars';
            Itemtype1.Badge_Label__c= 'BadgeLabel';
            Itemtype1.Order__c= 22.12;
            Itemtype1.Add_On__c= TRUE;
            Itemtype1.Unlimited__c=false;
            insert Itemtype1;
        
            Ticket__c insertTicket= new Ticket__c();
            insertTicket.Event__c = eventInfo.id;
            insertTicket.Item__c = item.id;
            insertTicket.Item_Pool__c = ItemPool2.id;
            insertTicket.Item_Type__c = Itemtype1.id;                    
            insertTicket.Badge_Label__c =  'badgeLabel';
            insertTicket.Order__c= insertOrder1.id;
            insertTicket.Ticket_Status__c= 'Booked';
           // insertTicket.Client_GN_User__c = gnUser.id;
            insert insertTicket;
            
            Item_Type__c Itemtype2= new Item_Type__c();
            Itemtype2.Name= 'Exhibitor';
            Itemtype2.Badge_Label__c= 'BadgeLabel';
            Itemtype2.Order__c= 22.12;
            Itemtype2.Add_On__c= TRUE;
            Itemtype2.Unlimited__c=false;
            insert Itemtype2;
        
            Ticket__c insertTicket1= new Ticket__c();
            insertTicket1.Event__c = eventInfo.id;
            insertTicket1.Item__c = item.id;
            insertTicket1.Item_Pool__c = ItemPool2.id;
            insertTicket1.Item_Type__c = Itemtype2.id;                    
            insertTicket1.Badge_Label__c =  'badgeLabel';
            insertTicket1.Order__c= insertOrder1.id;
            insertTicket1.Ticket_Status__c= 'Booked';
            //insertTicket1.Client_GN_User__c = gnUser.id;
            insert insertTicket1;
            
            Item_Type__c Itemtype3= new Item_Type__c();
            Itemtype3.Name= 'Sponsor';
            Itemtype3.Badge_Label__c= 'BadgeLabel';
            Itemtype3.Order__c= 22.12;
            Itemtype3.Add_On__c= TRUE;
            Itemtype3.Unlimited__c=false;
            insert Itemtype3;
            
            Ticket__c insertTicket2= new Ticket__c();
            insertTicket2.Event__c = eventInfo.id;
            insertTicket2.Item__c = item.id;
            insertTicket2.Item_Pool__c = ItemPool2.id;
            insertTicket2.Item_Type__c = Itemtype3.id;                    
            insertTicket2.Badge_Label__c =  'badgeLabel';
            insertTicket2.Order__c= insertOrder1.id;
            insertTicket2.Ticket_Status__c= 'Booked';
            //insertTicket2.Client_GN_User__c = gnUser.id;
            insert insertTicket2;
            
            Item_Type__c Itemtype4= new Item_Type__c();
            Itemtype4.Name= 'Speaker';
            Itemtype4.Badge_Label__c= 'BadgeLabel';
            Itemtype4.Order__c= 22.12;
            Itemtype4.Add_On__c= TRUE;
            Itemtype4.Unlimited__c=false;
            insert Itemtype4;
            
            Ticket__c insertTicket3= new Ticket__c();
            insertTicket3.Event__c = eventInfo.id;
            insertTicket3.Item__c = item.id;
            insertTicket3.Item_Pool__c = ItemPool2.id;
            insertTicket3.Item_Type__c = Itemtype4.id;                    
            insertTicket3.Badge_Label__c =  'badgeLabel';
            insertTicket3.Order__c= insertOrder1.id;
            insertTicket3.Ticket_Status__c= 'Booked';
           // insertTicket3.Client_GN_User__c = gnUser.id;
            insert insertTicket3;

            System.RestContext.request = new RestRequest();
            //RestRequest req = new RestRequest(); 
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestContext.request.addParameter('Event_Id',eventInfo.id);
            RestContext.request.requestURI =  sfbaseURL+'/services/apexrest/BLN_ASC_MobileAppSettings';  
            RestContext.request.httpMethod = 'POST';

            BLN_ASC_MobileAppSettings blnmas = new BLN_ASC_MobileAppSettings();
            BLN_ASC_MobileAppSettings.Container blnappcon = new BLN_ASC_MobileAppSettings.Container();
            blnappcon.EventID = eventInfo.id;
            blnappcon.ColumnName = 'test2';
            blnappcon.Columnlabel = 'test3';
            blnappcon.Include = true;
            blnappcon.id = 'test4';
            
            BLN_ASC_MobileAppSettings.doPost(eventInfo.id,u.id);
          
            

             
        
        
        
    }

}
    
}