@isTest
public class Test_BLN_PromoCodeReportCon{
    static testmethod void Testmethod_BLN_PromoCodeReportCon(){
        
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
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id,userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
               
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            promotion1.T_Used_Count__c=2;
            promotion1.Promotion_Type__c = 'Basic Promo codes';
            update promotion1;
            
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
            
            list<Promotion__c> liiip = new list<Promotion__c>();
            liiip.add(promotion1); liiip.add(promotion2); liiip.add(promotion3); liiip.add(promotion4); 
            
             Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            
            Item_Promotion__c ItemPromotion= new Item_Promotion__c();
            ItemPromotion= globalTest.createItemPromotion(item.Id, Promotion1.Id, 'Amount');
            

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
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
              
            BLN_PromoCodeReportCon proCodeRepTest= new BLN_PromoCodeReportCon();
           
            proCodeRepTest.hideEventsTab();          
            
            BLN_PromoCodeReportCon_BAL pcBAL=new BLN_PromoCodeReportCon_BAL();
           ApexPages.currentPage().getParameters().put('fdate','2/19/2016');
         ApexPages.currentPage().getParameters().put('tdate', '3/19/2016');
       ApexPages.currentPage().getParameters().put('searchKey','test');
        ApexPages.currentPage().getParameters().put('start','4');
        ApexPages.currentPage().getParameters().put('length','5');
        proCodeRepTest.processTicketSummary();
        proCodeRepTest.processPromoCodeSummary();  
          proCodeRepTest.processPromoCodeDetails(); 
         // proCodeRepTest.processTicketDetails();  
           proCodeRepTest.exportPCSummary();   
           proCodeRepTest.exportPromocodeSummary();   
             proCodeRepTest.exportPCDetails();  
            proCodeRepTest.exportPromocodeDetails();    
             proCodeRepTest.exportTSummary();  
              proCodeRepTest.exportTicketSummary();   
              //  proCodeRepTest.exportTDetails();  
                 proCodeRepTest.exportTicketDetails();
             
              list<BLN_PromoCodeReportCon_BAL.promoCodeInner12> pppmdli1 = new list<BLN_PromoCodeReportCon_BAL.promoCodeInner12>();
              BLN_PromoCodeReportCon.TicketDetailsWrapper ppt = new BLN_PromoCodeReportCon.TicketDetailsWrapper(10,20,21,pppmdli1);
              
           pcBAL.promotionsListForEvent(liiip);
           pcBAL.promobyticket(eventInfo.id,eventInfo.start_date__c,eventInfo.end_date__c,'',liiip);
            
            BLN_Event_DAO eveDAO=new BLN_Event_DAO();
            set<id> ids=new set<id>();
            ids.add(eventinfo.id);
            eveDAO.getevents(ids);
            eveDAO.updateEve(eventinfo);
                
            
          
            proCodeRepTest.byticketdetailmethod();
            Apexpages.currentPage().getParameters().put('bypromodetail',promotion1.id);
            proCodeRepTest.bypromodetailmethod();
            
        } 
    }
}