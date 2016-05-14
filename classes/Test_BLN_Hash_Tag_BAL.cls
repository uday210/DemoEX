@istest
public class Test_BLN_Hash_Tag_BAL{
    static testmethod void Test_BLN_Hash_Tag_BAL(){
    
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
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
    BLN_Hash_Tag_BAL hstag =new BLN_Hash_Tag_BAL();
   try{
    hstag.gethashtags('Name');
    }catch(Exception e){}
    try{
    hstag.getEventTags(string.valueof(eventInfo.id));
    }catch(Exception e){}
    }
    }
    }