@isTest
public class Test_LOGINUSER {


static testMethod void testDoGet() {
      
    
      
      System.RestContext.request = new RestRequest();
    
       RestContext.request.requestURI = '/GlobalnestEM/LoginUser';
       RestContext.request.addParameter('userName', 'buser2@badmin.com');
       RestContext.request.addParameter('passWord','global281');  
        
       // Profile p = new profile(Name = 'Event Admin', UserType = 'High Volume Portal');
       
        Profile p = [Select id, name FROM Profile limit 1];
    
    test.startTest();    
       // DataBase.insert (p,false);
        
        LOGINUSER.doPost();
        
         user bu2 =  new User(alias = 'busers', email='buser2@badmin.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US', password__c = 'global281',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='buser2@badmin.com',CompanyName='Nest',Title='dev');
                  
        insert bu2;
        
         
        LOGINUSER.doPost();
     test.stopTest();
     
      
}

}