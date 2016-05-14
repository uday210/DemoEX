@istest
public class Test_BLN_SignUpCon {
    
    static testmethod void TestBLN_SignUpCon  (){
    
        BLN_SignUpCon scon = new BLN_SignUpCon();
        Account acc = new Account();
        acc.Name='ph';
        insert acc;
        scon.ASUserEmail ='testsds@gmail.com';
        scon.ASLastName='raj';
        scon.ASFirstName ='r';
        scon.ASCompanyName ='global';
        scon.password ='dasd@wqw32';
       // scon.signUpLogin();
        //scon.forDisplayError = false;
        
        try {
        scon.BLS_SignUpUser();
        } catch (Exception ee) {}
      
        try {
        scon.login();
         } catch (Exception ex) {}
       
        try {
        scon.sendEmail();
     	} catch (Exception ec) {}
        
        scon.loginName = 'scon3  ';
        scon.loginPassword = '*****  ';
        scon.error = 'scon1';
    
         globalForTestClass globalTest= new globalForTestClass();
    
        User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(userForGN.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
        
        BLN_User_SignUP_BAL usuBAL=new BLN_User_SignUP_BAL();
        usuBAL.checkPersonalAccount(gnUser.Email__c);
    }
}