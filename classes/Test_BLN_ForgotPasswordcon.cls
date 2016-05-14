@istest (seeAllData=true)
public class Test_BLN_ForgotPasswordcon {

    static testmethod void Test_BLN_ForgotPasswordcon  (){
    
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
        
        OrgWideEmailAddress orgw=new OrgWideEmailAddress(Address=u.Email, DisplayName='Test', IsAllowAllProfiles=true);

         Messaging.SingleEmailMessage objEmail = new Messaging.SingleEmailMessage();
 
            //Address
            objEmail.setToAddresses(new String[] {'email@somewhere.com'});
 
            // Subject
            objEmail.setSubject('Test email');           
 
            //Content
            objEmail.setPlainTextBody('This is a test email');
        
         BLN_ForgotPasswordcon bfpc= new  BLN_ForgotPasswordcon();
        bfpc.tablabel='test';
        u.isSignup__c=true;
        u.isActive=true;
        update u;
        bfpc.username =u.username;
         bfpc.redirect();
         //bfpc.forgotPassword();
        bfpc.forgotPassword1();
        bfpc.AscForgotPassword();
        bfpc.EveForgotPassword();
        
        u.isSignup__c=false;
        update u;
        //bfpc.forgotPassword();
        bfpc.forgotPassword1();
        bfpc.AscForgotPassword();
        bfpc.EveForgotPassword();
        
        }
    
}    
}