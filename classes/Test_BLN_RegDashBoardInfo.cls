@isTest (SeeAllData = true) 
public class Test_BLN_RegDashBoardInfo{
    static testmethod void Testmethod_BLN_RegDashBoardInfo(){
        
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
            //eventInfo.ownerid=userForGN.Id;
            //eventInfo.organizer_email__c = 'saikumar@noemail.com';
            //update eventInfo;
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id,userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);

            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Name ='Admissions'; 
            update itemType; 
            
            Item_Type__c itemType1= new Item_Type__c();
            itemType1= globalTest.createItemType();
            itemType1.Name ='Package'; 
            update itemType1; 
            
            Item_Type__c itemType11= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Name ='Exhibitor'; 
            update itemType; 
            
            Item_Type__c itemType22= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Name ='Sponsor'; 
            update itemType; 
            
            Item_Type__c itemType33= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Name ='Speaker'; 
            update itemType; 
            
            Item_Type__c itemType44= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Name ='MatchLeads Buyer'; 
            update itemType; 
            
            Item_Type__c itemType55= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Name ='MatchLeads Seller'; 
            update itemType; 
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            Item_Pool__c ItemPool3= new Item_Pool__c();
            ItemPool3= globalTest.createItemPool(eventInfo.id, itemType1.Id, ItemPool.Id,trck.id);
            
            Item_Pool__c ItemPool4= new Item_Pool__c();
            ItemPool4= globalTest.createItemPool(eventInfo.id, itemType11.Id, ItemPool.Id,trck.id);
            Item_Pool__c ItemPool5= new Item_Pool__c();
            ItemPool5= globalTest.createItemPool(eventInfo.id, itemType22.Id, ItemPool.Id,trck.id);
            Item_Pool__c ItemPool6= new Item_Pool__c();
            ItemPool6= globalTest.createItemPool(eventInfo.id, itemType33.Id, ItemPool.Id,trck.id);
            Item_Pool__c ItemPool7= new Item_Pool__c();
            ItemPool7= globalTest.createItemPool(eventInfo.id, itemType44.Id, ItemPool.Id,trck.id);
            Item_Pool__c ItemPool8= new Item_Pool__c();
            ItemPool8= globalTest.createItemPool(eventInfo.id, itemType55.Id, ItemPool.Id,trck.id); 
            
            
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
               
            list<Item_Pool__c> liiipdd = new list<Item_Pool__c>();
            
            liiipdd.add(ItemPool);  liiipdd.add(ItemPool2);
            
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
           // promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
          //  promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
           // promotion1.T_Used_Count__c=2;
           

            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            Order_Item__c orderItem1= new Order_Item__c();
            orderItem1= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            list<Order_Item__c> lifif =  new list<Order_Item__c>();
            lifif.add(orderItem);lifif.add(orderItem1);
            
            try{
            promotion1.Order_Items__r[0].id  =  orderItem.id;
            }catch(exception e){}
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
            
             Order_Item__c orderItem2= new Order_Item__c();
            orderItem2= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            
            Item_Promotion__c ItemPromotion= new Item_Promotion__c();
            ItemPromotion= globalTest.createItemPromotion(item.Id, Promotion1.Id, 'Amount');
            
            list<Promotion__c> liiip = new list<Promotion__c>();
            liiip.add(promotion1); 
            
            
            list<Item_Promotion__c> liip = new list<Item_Promotion__c>();
            liip.add(ItemPromotion);
            
           
            
             BLN_Scanusr_item__c bsc = new BLN_Scanusr_item__c();
            bsc.BLN_Event__c =  eventInfo.id;
            bsc.BLN_GN_User__c = gnUser.id;
            bsc.BLN_Item_Pool__c = ItemPool3.id;
            bsc.Status__c = 'Active';
            insert bsc;

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
            ticket.Ticket_Status__c= 'Cancelled';
            ticket.Parent_ID__c = null;
            update ticket;

            tstatus__c tstat=new tstatus__c ();
            tstat = globalTest.createTstatus(ticket.id);
            
            Badge__c  Badge=new Badge__c ();
            Badge= globalTest.createBadge(ticket.Id);
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType1.Id, insertOrder1.Id, tktprof.Id);
            ticket1.Tstatus_Id__c=tstat.id;
            ticket1.Badge_ID__c = Badge.id; 
            update ticket1;
            
            list<Ticket__c> tilist =  new list<Ticket__c>();
           
            tilist.add(ticket);
            tilist.add(ticket1);
            
            BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Credit Card',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
        
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
            
            Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c(Events__c=eventInfo.id,Pay_Gateway__c=paygateway.id,Registration_Type__c='Online');
            insert epg;
            
            Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id,BLN_Pay_Gateway__c = paygateway.id);
            insert payobj;

            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
             
             BLN_Scanusr_item__c bsc1 = new BLN_Scanusr_item__c();
            bsc1.BLN_Event__c =  eventInfo.id;
            bsc1.BLN_GN_User__c = gnUser.id;
            bsc1.BLN_Item_Pool__c = ItemPool2.id;
           
            bsc1.Status__c = 'Cancel';
            insert bsc1;
            
             BLN_Scanusr_item__c bsc2 = new BLN_Scanusr_item__c();
            bsc2.BLN_Event__c =  eventInfo.id;
            bsc2.BLN_GN_User__c = gnUser.id;
            bsc2.BLN_Item_Pool__c = ItemPool2.id;
            bsc2.Status__c = 'Resume';
            insert bsc2;
            
            list<BLN_Scanusr_item__c>  liii = new list<BLN_Scanusr_item__c>();
            liii.add(bsc); liii.add(bsc1); liii.add(bsc2);
            
            MAp<id,Integer> mici = new MAp<id,Integer>();
            mici.put(item.id,1);
            BLN_RegDashBoardInfo.MapItemWithChInQuantity = mici;
            
            BLN_RegDashBoardInfo brdb = new BLN_RegDashBoardInfo(eventInfo.id);
            
             BLN_RegDashBoardInfo.InnForPgateways brdb1 = new BLN_RegDashBoardInfo.InnForPgateways('test', 24.5);
            BLN_RegDashBoardInfo.InnForItemPrice brdb2 = new BLN_RegDashBoardInfo.InnForItemPrice(item,24.5,24,liiipdd,6.6);
            BLN_RegDashBoardInfo.PackageItems brdb24 = new BLN_RegDashBoardInfo.PackageItems(ItemPool,24,24);
            
                  //item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id 
                    Order_Item__c insertOrderItem= new Order_Item__c(); 
        insertOrderItem.Item__c= item.Id;
        insertOrderItem.Order__c= insertOrder1.Id;
        insertOrderItem.Promotion__c= promotion1.id;
        insertOrderItem.Item_Discount__c= 10;
        insertOrderItem.Item_Price__c= 20;
        insertOrderItem.Item_Quantity__c= 2;
        insertOrderItem.Item_Total__c= 2;
        insertOrderItem.Status__c= 'Cancelled';
        insertOrderItem.Currency__c= currenyInfo.Id;
        
        insert insertOrderItem;
            
            BLN_RegDashBoardInfo brdbTemp1 = new BLN_RegDashBoardInfo(eventInfo.id); 
            
         
        } 
    }
}