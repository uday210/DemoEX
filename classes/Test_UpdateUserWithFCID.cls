@isTest
public class Test_UpdateUserWithFCID{
static testMethod void testDoGet() {
contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'test123', email='test12377@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test12377@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
 
  system.runas(u){
    System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/UpdateUserWithFCID';
       RestContext.request.addParameter('fbId','596207599');
       RestContext.request.addParameter('uId', 'test12377@noemail.com');
       UpdateUserWithFCID.doget();
  }
  
  

 }


}