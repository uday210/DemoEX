@istest
public class Test_paymentsettingsCon{
    static testmethod void Testmethod_paymentsettingsCon(){
    
    User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();        
        
        system.runas(U){
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();      
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);    
             
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
             User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
        	tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
           
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
                       
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool2.Id, item.Id, companyInfo.Id, NULL, 'Regular', 'AS_Last_Name__c');
    
    PGateway_Type__c pgt= new PGateway_Type__c(Name='Authorize.Net');
    insert pgt;
    
     Pay_Gateway__c pw= new Pay_Gateway__c(PGateway_Type__c=pgt.id,Company__c=companyinfo.id);
      //insert pw;
    
    Event_Pay_Gateway__c epg= new Event_Pay_Gateway__c(Events__c =eventInfo.id,Pay_Gateway__c=pw.id,Registration_Type__c='Online');
    insert epg;
    
    PageReference pageRef = Page.BLN_Mytickets;
    Test.setCurrentPage(pageRef);
    
    cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
    ApexPages.currentPage().setCookies(new Cookie[]{counter});
    
    paymentsettingsCon pscon= new paymentsettingsCon();
    
    pscon.getoptionsCountry();
    pscon.getoptionsStates();
    pscon.firstMethod();    
    pscon.save();      
    pscon.companyId=companyInfo.id;
   pscon.insertPway(pw);
    pscon.saveOnsite();
    pscon.insertEventPay(pw.id,'test'); 
    
    LIST<Pay_Gateway__c> pgLst=new LIST<Pay_Gateway__c>();
    pgLst.add(pw);
    BLN_PGateway_Type_DAO pgtDAO=new BLN_PGateway_Type_DAO();
            try{
            pgtDAO.getGatewayType('Paypal');
            }catch(exception excep){}
    pgtDAO.pgateWaySaves(pgLst);      
  

    }
    
    }
}