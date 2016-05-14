@isTest
public class Test_BLN_Hash_Tag_DAO {

    public static testMethod void TestCase_BLN_Hash_Tag_DAO(){
        
        
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
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Hash_Tag__c hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);
            
            BLN_Hash_Tag_DAO hashdao = new BLN_Hash_Tag_DAO();
            
            hashdao.getTags('Id', ' Id=\''+hashT.Id+'\'');
            hashdao.getEventTags(eventInfo.Id);
            
            LIst<id> lstid = new LIst<id>();
            lstid.add(hashT.Id);
            hashdao.getTags(lstid);
        
            
            
        }
    }
}