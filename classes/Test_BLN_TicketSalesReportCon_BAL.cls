@isTest
public class Test_BLN_TicketSalesReportCon_BAL {
    
    public static testMethod void Test_BLN_TicketSalesReportCon_BAL(){
        
            User U= new User();
            globalForTestClass globalTest= new globalForTestClass();
            U= globalTest.createUser();
        System.runAs(U){
            
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
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
             
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            list<BLN_Item__c> li = new list<BLN_Item__c>();
            li.add(item);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);

             Tkt_profile__c  tktprof = new Tkt_profile__c();
             tktprof =globalTest.createTktprofile(userForGN);
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
           // insertOrder1.Client_GN_User__c = gnUser.Id;
           // insertOrder1.Client_Company__c= companyInfo.Id;
            //insertOrder.Client_User__c= userId;
            insertOrder1.Events__c= eventInfo.Id;
            insertOrder1.Order_Total__c= 2;
            insertOrder1.Amount_Paid__c= 25.12;
            insertOrder1.Fee_Amount__c= 23.29;
            insertOrder1.Currency_Code__c= currenyInfo.Id;
            insertOrder1.Order_Status__c='Fully Paid';
            insert insertOrder1;
            
             Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            orderItem.Status__c = 'Active';
            orderItem.Item_Fee__c=1;
            update orderItem;
            
            Ticket__c ticket= new Ticket__c();
           ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id,tktprof.id);
            ticket.order_item__c=orderItem.id;
            update ticket;

            PGateway_Type__c pgt = new PGateway_Type__c(Name='cash',Adaptive_Type__c='Direct');
            insert pgt;

            Pay_Gateway__c pgw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='cash',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Parallel');
            insert pgw;
            
            Payment__c pp= new Payment__c();
            pp.BLN_Pay_Gateway__c=pgw.id;
            pp.credit_card_last_4digits__c='1245';
            pp.credit_card_type__c='vasa';
            pp.Currency_Code__c=currenyInfo.id;
            pp.Order__c=insertOrder1.id;
            pp.Payment_Amount__c=100;
            pp.Payment_Mode__c='cash';
            insert pp;
            
        LIST<Payment__c> PaymentsList= new LIST<Payment__c>{pp};

            BLN_TicketSalesReportCon_BAL ticsalesbal = new BLN_TicketSalesReportCon_BAL();          
            
             MAP<String, Decimal> itemCountMAP= new MAP<String, Decimal>{ 'cash(Direct)'=>5.0 }; 
             /*         
        MAP<String, Decimal> itemDiscountMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        MAP<String, Decimal> itemFeeMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        MAP<String, Decimal> itemTaxMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        MAP<String, Decimal> itemAmountMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        
        MAP<String, Decimal> TotalItemFeeAmountMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };              
        MAP<String, Decimal> TotalItemTaxAmountMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };         
        MAP<String, Decimal> itemTotalDiscountMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        MAP<String, Decimal> itemTotalFeeMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };     
        MAP<String, Decimal> itemTotalTaxMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };         
        MAP<String, Decimal> itemTotalAmountMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        MAP<String, Decimal> itemTotalCountMAP= new MAP<String, Decimal>{ 'Jon'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        */
        
        MAP<String, Decimal> paymentTypeCountMAP= new MAP<String, Decimal>{'cash(Direct)'=>5.0};  
        /*MAP<String, Decimal> paymentTypeDiscountMAP= new MAP<String, Decimal>{ 'cash(Direct)'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
        MAP<String, Decimal> paymentTypeFeeMAP= new MAP<String, Decimal>{ 'cash(Direct)'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };     
        MAP<String, Decimal> paymentTypeTaxMAP= new MAP<String, Decimal>{ 'cash(Direct)'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };          
        MAP<String, Decimal> paymentTypeAmountMAP= new MAP<String, Decimal>{ 'cash(Direct)'=>5.0, 'Quinton'=> 6  , 'Reid'=> 1 };  
                  */
               ticsalesbal.getTicketSalesReport(li);
                      }
    }

}