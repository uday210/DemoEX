@isTest(seeAllData=true)
public class Test_BLN_RegistrationnewCon{

  string fullUrl =  Site.getBaseUrl();
   
    
    static testmethod void Testmethod_BLN_RegistrationnewCon(){
       
    
    //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
     //   U= globalTest.createUser();        
        
            Profile p = [select id from profile where name='System Administrator'];
            userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

            User u = new User(alias = 'TestAb', email='testcodehh5689@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcodehh5689@noemail.com');
            Database.insert(u);
        
        
        
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
            
            Reg_Setting__c regSettingsInfo4= new Reg_Setting__c();
            regSettingsInfo4= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            list<Reg_Setting__c> regsettinginfo3 = new list<Reg_Setting__c>();
            regsettinginfo3.add(regSettingsInfo1);
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
           
            
              Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof=globalTest.createTktprofile(userForGN);
            
              Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
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
             
            
         
         
        //ApexPages.currentPage().putUrl('apex/Bln_Dashboard');  
        PageReference pageRef = Page.Bln_Dashboard;
      Test.setCurrentPage(pageRef);
       BLN_RegistrationnewCon  br = new  BLN_RegistrationnewCon();
       br.SelectedPaymentGateway='Free';
       try{
        br.onloadmethod(eventInfo.id);
       }catch(exception e){}
        //br.countryStates();
        //br.statesBasedOnCountry();
        br.fetchNAICSCodes();
        br.applyPromocode();    
        br.applyPromocodenew();
        br.orderNow();
        br.callingPaymentMethod();
        br.PaymentCall();
        br.validatePayment();
        br.cpmdetails();
        
        br.completeRegistration();
        br.checkCompany(companyInfo.id);
       BLN_RegistrationnewCon.getCompaniesext(companyInfo.id);
      // BLN_RegistrationnewCon.statesBasedOnCountry(countryInfo.id);

       
      
            
       BLN_RegistrationnewCon  br1 = new  BLN_RegistrationnewCon();
     BLN_RegistrationnewCon.ItemInnerClass  bb1 = new BLN_RegistrationnewCon.ItemInnerClass(item,null,'2',10.0,'test');
     List<BLN_RegistrationnewCon.ItemInnerClass> bblist = new list< BLN_RegistrationnewCon.ItemInnerClass>();
     
    bblist.add(bb1);
    BLN_RegistrationnewCon.RegItemInnerClass breg = new BLN_RegistrationnewCon.RegItemInnerClass('thghh',100.23,bblist);
   try{        
       br1.SelectedPaymentGateway='Check';
            br.onloadmethod(eventInfo.id);
       // br1.countryStates();
       // br1.statesBasedOnCountry();
        br1.fetchNAICSCodes();
        br1.applyPromocode();    
        br1.applyPromocodenew();
        br1.orderNow();
        br1.callingPaymentMethod();
        br1.PaymentCall();
        br1.validatePayment();
        br1.cpmdetails();
        
             
               BLN_RegistrationnewCon  br2 = new  BLN_RegistrationnewCon();
     
       br2.SelectedPaymentGateway='Cash';
          br2.onloadmethod(eventInfo.id);
       // br2.countryStates();
       // br2.statesBasedOnCountry();
        br2.fetchNAICSCodes();
        br2.applyPromocode();    
        br2.applyPromocodenew();
        br2.orderNow();
        br2.callingPaymentMethod();
        br2.PaymentCall();
        br2.validatePayment();
        br2.cpmdetails();
        }catch(exception e){}
              br.logout();
            
            
            }}}