@isTest
public class Test_BLN_Address_DAO {

    public static testMethod void testMethod_BLN_Address_DAO() {
        
        
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        System.runAs(U){
        
         Currency__c insertCurrency= new Currency__c();
        insertCurrency.Name= 'USD';
        insertCurrency.Currency_Name__c= 'US Dollar';
        insertCurrency.Currency_Symbol__c= '$';
        
        insert insertCurrency;
        
         Country__c insertCountry= new Country__c();
        insertCountry.Long_Name__c = 'United States Of America';
        insertCountry.Short_Name__c= 'US';
        insertCountry.Currency__c= insertCurrency.id;
        insertCountry.Order__c= 123;
        insert insertCountry;
        
        State__c insertState= new State__c();
        insertState.Country__c= insertCountry.id;
        insertState.Long_Name__c= 'Andhra Pradesh';
        insertState.Order__c= 123;
        insertState.Short_Name__c= 'AP';
        
        insert insertState;
        
        
         BLN_Address__c bc = new BLN_Address__c();
         bc.Address1__c = 'sssss';
         bc.Address2__c = 'ddde';
         bc.City__c = 'ddddd';
         bc.Country__c = insertCountry.id;   
         bc.State__c = insertState.id;
         bc.PoBox__c = 'ddedd';
        
         bc.ZipCode__c = '33333';
         insert bc;
           
           BLN_Address_DAO  bd = new BLN_Address_DAO();
           bd.getAddress(bc.id); 
           bd.insertadd('hydff','viz','vij',insertCountry.id,insertState.id,'gpppp','1588');
        }
    }
    
}