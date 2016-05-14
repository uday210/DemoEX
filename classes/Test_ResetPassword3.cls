@isTest
public class Test_ResetPassword3{
 static testMethod void  testrest(){
   
    Profile w = [select id from profile where name='Standard User'];
  User u = new User(alias = 'test123e', email='test123e@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',IsActive=True,
                  timezonesidkey='America/Los_Angeles', username='test123e@noemail.com',password__c='phani123');
                  insert u;
             
            
      user abc = [select userName from user where id=:u.id]; 
       
        
       
       System.RestContext.request = new RestRequest();  
       RestContext.request.requestURI = '/GlobalnestEM/RESETPASSWORD3';
       RestContext.request.addParameter('Username','test123e@noemail.com');
       RestContext.request.addParameter('OldPassword','phani123');
       RestContext.request.addParameter('newPassword', 'durga281');
        ResetPassword3.doGet();
        
      
      
       
       }
 }