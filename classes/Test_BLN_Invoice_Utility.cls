@istest
public class Test_BLN_Invoice_Utility{
    static testmethod void Test_BLN_Invoice_Utility(){
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
            Role__c rl=new Role__c(Name = 'Company Admin');
            insert rl;
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);
            UC_Role__c ucrole = new UC_Role__c();
            ucrole  =globalTest.createUCRole(companyInfo.id,null,gnUser.id, null, rl.id);
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);
            eventInfo.User_Company__c = ucrole.id;
            eventInfo.Organizer_Email__c = u.email;
           eventInfo.Name = 'Default Event(Boothleads)';
            update  eventInfo;
            
        Item_Type__c itemType= new Item_Type__c();
        itemType= globalTest.createItemType();
        itemType.BL_Fee_Amt_per_res__c = 0.75;
        update itemType;
        BLN_Track__c trackInfo= new BLN_Track__c();
        trackInfo= globalTest.createTrack(eventInfo.Id);
        
        Item_Pool__c ItemPool= new Item_Pool__c();
        ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
        
        Item_Pool__c ItemPool2= new Item_Pool__c();
        ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
        
        BLN_Item__c item= new BLN_Item__c();
        item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
        
        Promotion__c promotion1= new Promotion__c();
        promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
        
      
           
    BLN_Invoice_Utility Invoiceutility=new BLN_Invoice_Utility();
   string  ordid= Invoiceutility.InsertOrder(eventInfo.id,10.0);
     Order_Item__c orderItem= new Order_Item__c();
     orderItem= globalTest.createOrderItem(item.Id, ordid, promotion1.id, currenyInfo.Id);
    Invoiceutility.CreateOrder(eventInfo.id);
     Test.startTest();
    BLN_Invoice_Utility.BillCustomer(ordid);
    BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
        PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
        insert pggatewaytype;
        
        Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
        insert paygateway;
        Payment__c payobj=new Payment__c(Order__c = ordid,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id,BLN_Pay_Gateway__c = paygateway.id);
        insert payobj;
           List<Payment__c> directpaylist=[select id,name,Order__c,Payment_Amount__c,BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,BLN_Pay_Gateway__r.PGateway_Type__r.Name from Payment__c where Order__r.Events__c=:eventInfo.id ];
       system.debug('@@@@@$'+directpaylist);
        Order__c ordd=new Order__c();
        ordd.Order_Status__c = 'Fully Paid';
        ordd.Amount_Paid__c = 20.0;
        ordd.id = ordid;
        update ordd;
        Invoiceutility.CreateOrder(eventInfo.id);
    Test.stopTest();
    }
    }
    }