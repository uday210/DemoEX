@RestResource(urlMapping='/FORGOTPASSWORD/*')


global with sharing class ForgotPassword {
    
    global static String username;
    global static User userDetails;
    
@HttpGet
global static PasswordReset doGet(){
RestRequest req = RestContext.request;
RestResponse res = RestContext.response;
System.debug('@@@@@req'+req);
username = req.params.get('Username').tolowercase();
 try{
 userDetails = [Select id,Username,Password__c,IsActive,email,firstname,lastname from User Us where Username=:username];
  if(userDetails.IsActive =false){
     PasswordReset passwo = new PasswordReset('The User is not active, Please contact your Administrator!');
      return passwo;
      System.debug('@@@@@passwo'+passwo);
    }
    
    try{
    String[] toaddress = new String[]{};
    toaddress.add(userDetails.email);
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    OrgWideEmailAddress Org = [select id from OrgWideEmailAddress Limit 1];
    mail.setOrgWideEmailAddressId(Org.id); 
    mail.setToAddresses(toaddress);
    mail.setsubject('Your BoothLeads Account Password');
    mail.setHtmlBody('Dear '+userDetails.firstname+' '+userDetails.lastname+'<BR/>'+'<P> YOUR BOOTHLEADS ACCOUNT INFORMATION IS BELOW</P>'+'<P> username :'+userDetails.email+'</br></p>'+'<p> password:'+userDetails.Password__c+'</p>');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    PasswordReset passwo = new PasswordReset('The password is sent to registered email address');
        
        return passwo;
        
        System.debug('@@@@@passwo'+passwo);
    
    }
    
    catch(Exception ex){
        
        System.debug('Exception Message'+ex.getMessage());
       
    }
    
    
    
    }
    
    Catch(System.QueryException ex){
        
        PasswordReset passwo = new PasswordReset('Please check the username or Contact Booth Admin once for the Account Activation Information');
        
        return passwo;
        
        System.debug('@@@@@passwo'+passwo);
        
    }
    
    
    return null;
}


global Class PasswordReset{
    
String Message;


public PasswordReset(String message1){
    
    Message = message1;
        
}
    
}
static testMethod void testRest() {
contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
       insert m;
       Profile w = [select id from profile where name='Standard User'];
       user u= new User(alias = 'busers', email='boothadmin@boothleads.com',
       emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
       localesidkey='en_US',country='United States',
       timezonesidkey='America/Los_Angeles', username='boothadmin@boothleads.com',CompanyName='Nest',Title='dev');
       insert u;
       System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
       u.password__c =rt.getPassword();
   
       update u;
       string pwd =rt.getPassword();
      
       System.RestContext.request = new RestRequest();
       RestContext.request.addParameter('Username', 'boothadmin@boothleads.com');
       ForgotPassword.doGet(); 
        RestContext.request.addParameter('Username', 'boothadmin123@boothleads.com');
       ForgotPassword.doGet(); 
       
       
}


}