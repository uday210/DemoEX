@isTest
public class Test_SIGNUPUSER{


static testMethod void testDoGet() {
      
    
      System.RestContext.request = new RestRequest();
    
       RestContext.request.requestURI = '/GlobalnestEM/SIGNUPUSER';
       RestContext.request.addParameter('fName', 'Test FName');
       RestContext.request.addParameter('lName','Test LName');  
        RestContext.request.addParameter('EmailId','test760@email.com');
       RestContext.request.addParameter('Company','test Company');  
        RestContext.request.addParameter('pw','HelPass@123');
          RestContext.request.addheader('phone','9550710718');
          
        
    
          user u =new user();
          u=[select id from user where profile.Name='System Administrator' limit 1];
          
        
        SIGNUPUSER.doGet();
       // SIGNUPUSER.myMethod2(userIdvalue,'testvalues');
        
      
        

      
        
        
}
}