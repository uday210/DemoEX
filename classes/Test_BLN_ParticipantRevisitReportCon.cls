@isTest
public class Test_BLN_ParticipantRevisitReportCon{
    
    static testMethod void Testmethod_BLN_ParticipantRevisitReportCon() {
        
        globalForTestClass globalTest= new globalForTestClass();
        
        Profile p = [select id from profile where name='Event Admin1'];
        
        Account acc= new Account(Name='GlobalNestLLC');
        insert acc;
        
        contact con = new contact(firstname='gnusered',lastname='edx',AccountId=acc.id);
        insert con;
        
        User U= new User(alias = 'gn', email='gnusered@noemail.com', firstname= 'Vine', Phone= '7323334808',ContactId= con.Id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='edx', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNestLLC',
                                  timezonesidkey='America/Los_Angeles', username='gnusered@noemail.com', Title= 'SF Developer');
        insert U;
        
        Currency__c currencyInfo= new Currency__c();
        currencyInfo= globalTest.createCurrency();
        
        Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currencyInfo.Id); 
        
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
        
        Company__c companyInfo= new Company__c();
        companyInfo= globalTest.createCompany(U.Companyname);
        companyInfo = [select id, description__c from Company__c where id=:companyInfo.id]; 
        CompanyInfo.Description__c = 'test';
        //Update CompanyInfo;
        
        User userInfo= new User();
            userInfo= globalTest.createUserForGNUser();
        
        BLN_Event__c eventInfo= new  BLN_Event__c();
        eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);  
         eventInfo.ownerid = userInfo.id;
         eventInfo.organizer_email__c='test@noemail.com';
         update eventInfo;
        
        
                        
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(userInfo, countryInfo.Id, stateInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u,countryInfo.Id, stateInfo.Id);
            
            BLN_Room__c roomInfo= new BLN_Room__c();
            roomInfo= globalTest.createRoom(eventInfo.Id);
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userInfo);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currencyInfo.Id);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency(); 
            
            Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id);
            insert payobj;
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            tstatus__c tstat=new tstatus__c ();
            tstat = globalTest.createTstatus(ticket.id);
            tstat.scan_time__c = system.now();
            update tstat;

        
        cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
        
        BLN_ParticipantRevisitReportCon blnchkh1 = new BLN_ParticipantRevisitReportCon();
        blnchkh1.displayPermissions();
        Apexpages.currentpage().getparameters().put('ttype',string.valueof(eventInfo.start_date__c));
        apexpages.currentpage().getparameters().put('seldates','');
        blnchkh1.fncall();
        blnchkh1.exportRevisit();
        blnchkh1.expmethod();
        
        BLN_ParticipantRevisitReportCon.getDateFilters(eventInfo.id);
    }
}