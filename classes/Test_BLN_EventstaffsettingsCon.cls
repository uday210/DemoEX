@istest
public class Test_BLN_EventstaffsettingsCon{
    static testmethod void Testmethod_BLN_EventstaffsettingsCon(){
    
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
            
          // Order__c insertOrder1= new Order__c();
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
    
            BLN_Track__c trck=new BLN_Track__c();
        trck=globalTest.createTrack(eventInfo.Id);
        
        Item_Pool__c ItemPool= new Item_Pool__c();
        ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
        
        Item_Pool__c ItemPool2= new Item_Pool__c();
        ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
        
        BLN_Item__c item= new BLN_Item__c();
        item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
    
    PGateway_Type__c pgt= new PGateway_Type__c(Name='Authorize.Net');
    insert pgt;
    
    Pay_Gateway__c pw= new Pay_Gateway__c(PGateway_Type__c=pgt.id,Company__c=companyInfo.id);
    insert pw;
    
    Reg_Setting__c reg = new Reg_Setting__c(Column_Name__c='Full Admin');
    insert reg;
    
    PageReference pageRef = Page.BLN_Mytickets;
    Test.setCurrentPage(pageRef);
    
    cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
    ApexPages.currentPage().setCookies(new Cookie[]{counter});
    
    BLN_EventstaffsettingsCon besc= new BLN_EventstaffsettingsCon();
    besc.getsettings();
    besc.Savesettings();
    
    
    
    }
    
    }
}