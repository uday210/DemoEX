@isTest

public class Test_BLN_Utill_BAL {
    
    static testMethod void testMethod_Test_BLN_Utill_BAL(){
        
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
            //User userForGN= new User();
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
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userInfo,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 

            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userInfo);

            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
  
             BLN_Room__c roomInfo = new BLN_Room__c();
            roomInfo = globalTest.createRoom(eventInfo.Id);

            BLN_Track__c trackInfo = new BLN_Track__c();
            trackInfo = globalTest.createTrack(eventInfo.Id);

            Agenda__c agendaInfo = new Agenda__c();
            agendaInfo = globalTest.createAgenda(eventInfo.Id, trackInfo.Id);

            Agenda__c agendaInfo2 = new Agenda__c();
            agendaInfo2 = globalTest.createAgenda(eventInfo.Id, trackInfo.Id);

            Agenda__c agendaInfo3 = new Agenda__c();
            agendaInfo3 = globalTest.createAgenda(eventInfo.Id, trackInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();

            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
              Time_Slots__c timeSlotInfo = new Time_Slots__c();
            timeSlotInfo = globalTest.createTimeSlot(agendaInfo.Id, roomInfo.Id);

            Time_Slots__c timeSlotInfo2 = new Time_Slots__c();
            timeSlotInfo = globalTest.createTimeSlot(agendaInfo2.Id, roomInfo.Id);

            Time_Slots__c timeSlotInfo3 = new Time_Slots__c();
            timeSlotInfo = globalTest.createTimeSlot(agendaInfo3.Id, roomInfo.Id);
            
            
            Participant__c participantInfo = new Participant__c();
            participantInfo = globalTest.createParticipant(gnUser.Id, timeSlotInfo.Id);
            
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
        
            PGateway_Type__c pgt = new PGateway_Type__c(Name='Cash');
            insert pgt;
            
            Pay_Gateway__c pw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='Cash',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Parallel');
            insert pw;
            
            Payment__c pp= new Payment__c();
            pp.BLN_Pay_Gateway__c=pw.id;
            pp.credit_card_last_4digits__c='1245';
            pp.credit_card_type__c='Visa';
            pp.Currency_Code__c=currenyInfo.id;
            pp.Order__c=insertOrder1.id;
            pp.Payment_Amount__c=100;
            pp.Payment_Mode__c='Credit Card';
            pp.Payment_Ref_Number__c = '12345';
            pp.Registration_Type__c = 'Online';
            insert pp;
        
            DateTime dt = datetime.now().adddays(-30);
            BLN_Utill_BAL.getMytickets(eventInfo.id, userInfo.Id, dt);
            BLN_Utill_BAL.getEventschedule(eventInfo.id, dt);  
            BLN_Utill_BAL.getSeminars(eventInfo.id, userInfo.Id, dt); 
            BLN_Utill_BAL.getBooths(eventInfo.id, dt);
            BLN_Utill_BAL.getSpeakers(eventInfo.id, dt);
            BLN_Utill_BAL.getSponsors(eventInfo.id, dt);
            BLN_Utill_BAL.getAttendees(eventInfo.id, null, 1, dt);
            BLN_Utill_BAL.getDocs(eventInfo.id, dt);
            
            BLN_Utill_BAL.getMytickets(eventInfo.id, userInfo.Id, null);
            BLN_Utill_BAL.getEventschedule(eventInfo.id, null);  
            BLN_Utill_BAL.getSeminars(eventInfo.id, userInfo.Id, null); 
            BLN_Utill_BAL.getBooths(eventInfo.id, null);
            BLN_Utill_BAL.getSpeakers(eventInfo.id, null);
            BLN_Utill_BAL.getSponsors(eventInfo.id, null);
            BLN_Utill_BAL.getAttendees(eventInfo.id, null,1,null);
            BLN_Utill_BAL.getDocs(eventInfo.id, null);
    }

}
    
}