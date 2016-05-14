@isTest
public class Test_BLN_RegistrationLinks{
    static testmethod void Testmethod_BLN_RegistrationLinks(){
    
    User U= new User();
    globalForTestClass globalTest= new globalForTestClass();
    U= globalTest.createUser();
 
    system.runas(U){

        Test_BLN_ReUse_EventsEditCon tcon = new Test_BLN_ReUse_EventsEditCon();
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
        
         //Order__c insertOrder1= new Order__c();
           // insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
         Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Type__c itemTypelr= new Item_Type__c();
            itemTypelr= globalTest.createItemType13();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            Item_Pool__c ItemPoollr= new Item_Pool__c();
            ItemPoollr= globalTest.createItemPool(eventInfo.id, itemTypelr.Id, NULL,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            BLN_Item__c itemlr= new BLN_Item__c();
            itemlr= globalTest.createItem(ItemPoollr.Id, itemTypelr.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
        Hash_Tag__c hash=new Hash_Tag__c();
         hash = globalTest.createTag(eventInfo.id);
        
        Reg_Setting__c RegSet= new Reg_Setting__c();
        RegSet=globalTest.createRegSettings(eventInfo.id, ItemPool.Id, item.Id, companyInfo.Id,hash.id,'Registration Tab', 'testcol');
        
        cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
        ApexPages.currentPage().getHeaders().put('referer', 'test');
        BLN_RegistrationLinks regcon = new BLN_RegistrationLinks ();
       
       regcon.refreshpage();
       regcon.editshorturl();
        Test.setMock(HttpCalloutMock.class, new MockHttpRespphp());
         Test.startTest() ;
         //id stid =Id.valueOf('123345');
         try{
        BLN_RegistrationLinks.getshorturl('testevent','a2Qf0000000q1Ux','http://google.com');
        }catch(Exception e){}
        Test.stopTest()  ;
    }
}}