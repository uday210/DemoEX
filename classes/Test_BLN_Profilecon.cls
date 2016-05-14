@istest
public class Test_BLN_Profilecon{
    static testmethod void Testmethod_BLN_Profilecon(){
        
        //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUserForGNUser();
          Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];  
         User U = new User(alias = 'Test', email='testcode@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='testlast', Firstname='testname', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode@noemail.com');
         insert U;        
          
          
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
            
                 
           
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(U, countryInfo.Id, stateInfo.Id);
        
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);        
            
                        
            //User userForGNInfo= new User();
            //userForGNInfo= globalTest.createUserForGNUser();
            
            Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
            
            UC_Role__c ucRoleInfo= new UC_Role__c();
            ucRoleInfo= globalTest.createUCRole(companyInfo.Id, eventInfo.Id, gnUserInfo.Id, U.Id, roleInfo.Id);
            
            UC_Role__c ucRoleInfo2= new UC_Role__c();
            ucRoleInfo2= globalTest.createUCRole(companyInfo.Id, NULL, gnUserInfo.Id, U.Id, roleInfo.Id);
           
            
            Pay_Address__c payAddressInfo= new Pay_Address__c();
            payAddressInfo= globalTest.createPayAddress(companyInfo.Id, eventInfo.Id, countryInfo.Id);
            
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            list<NAICS_Code__c> lstNais = new list<NAICS_Code__c>();
            for(integer i = 0 ; i < 1000 ; i ++){
                lstNais.add(new NAICS_Code__c(name = 'Test'));
            }
            insert lstNais;
            BLN_Profilecon profileCon= new BLN_Profilecon();
            Currency__c CurrObj = globalTest.createCurrency();
            Country__c CntryObj = globalTest.createCountry(CurrObj.id);
            State__c steObj = globalTest.createState(CntryObj.id);
            Company__c ComObj2 = globalTest.createCompany('Test Company');
            NAICS_Code__c prim = new NAICS_Code__c(Name = 'Primary');
            insert prim;
            NAICS_Code__c second = new NAICS_Code__c(Name = 'secondary');
            insert second;
            Company_Ext__c ComPExi = globalTest.createCompanyExt(ComObj2.id,prim.id,second.id,CntryObj.id,steObj.id);
            profileCon.selectedcompany = ComObj2.id;
            profileCon.cpmdetails();
            profileCon.countryStates();
            profileCon.statesBasedOnCountry();
            profileCon.HomestatesBasedOnCountry();
            ApexPages.CurrentPage().getParameters().put('billid',payAddressInfo.Id);
            profileCon.BillstatesBasedOnCountry();
            ApexPages.CurrentPage().getParameters().put('naicsCodes',naicsCodeInfo1.Id+'-'+naicsCodeInfo2.Id);            
            profileCon.sendNaicsCodes();
            Company__c ComObj = globalTest.createCompany('Test Company');
            profileCon.Currentcompany = ComObj.id;
            profileCon.companyImageName ='Test Image Name';
            profileCon.companyImage = blob.valueOf('Test');   
            try{
            profileCon.updatedetails();
            }catch(exception e){}
            profileCon.cancel();
            
            BLN_Profile_BAL profileBAL = new BLN_Profile_BAL();
            profileBAL.compdetails(companyInfo.name);
            profileBAL.billingadd(companyInfo.id);
            
            
            
        }
    }
}