@isTest
public class Test_BL_Eventadmin_privateSignupCon{

static testMethod void test_EventAdminSignin (){
        
        
         account a=new account(name='govtnm');
        insert a;
        
         contact c=new contact(lastname='n',accountid = a.id);
        insert c;
        
        Profile p = [select id,name FROM profile where name='Event Admin'];
        
        User us = new User(alias = 'test123', email='test123@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='test123@noemail.com', ContactID = c.id);
        insert us;
         string pwd ;
         try{
         System.ResetPasswordResult rt= system.ResetPassword(us.id,true);
         us.password__c =rt.getPassword();
         pwd = rt.getPassword();
         update us;
        }catch(exception e){}
        
        
         account a1=new account(name='govtnm1');
        insert a1;
        
         contact c1=new contact(lastname='n1',accountid = a1.id,firstname='phani' );
        insert c1;
        
         Profile pbAdmin = [select id,name FROM profile where name='Booth Admin'];
        
        User bAdmin = new User(alias = 'test1234', email='test1234@noemail.com',
        emailencodingkey='UTF-8',profileid = pbAdmin.Id, lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='test1234@noemail.com',ContactID = c1.id);
        insert bAdmin ;
       string pwdad;
      try{  
         System.ResetPasswordResult rtad= system.ResetPassword(bAdmin .id,true);
         bAdmin .password__c =rtad.getPassword();
         pwdad = rtad.getPassword();
         update bAdmin ;
      }catch(exception e){}
        Profile__c EventAdmCustProfile = new Profile__c(PR_Name__c = 'EventAdmin');
        insert EventAdmCustProfile;  
           
        
        User_Profile_Event__c upe=new User_Profile_Event__c(User_id__c=us.id,Profile_id__c=EventAdmCustProfile.id, status__c='Active');
        insert upe;
        
       
       BL_Eventadmin_privateSignupCon  testsignin=new BL_Eventadmin_privateSignupCon ();
       testsignin.Loginname  =us.Email;
       testsignin.password =pwd ;      
       
       testsignin.EvEmail='test1234@noemail.com';
       testsignin.EventAdminReg();
       testsignin.EvEmail='phani@noemail.com';
       testsignin.EvEmail='phani@noemail.com';
       
      
       testsignin.EventAdminReg();
      
     
       testsignin.CancelSignUp();
       testsignin.SuccesPopUpClose();
       system.runas(us){
       testsignin.checkuserName();
      }

      system.runas(bAdmin){
       testsignin.checkuserName();
   }


}
}