@RestResource(urlMapping='/RESETPASSWORD/*')


global with sharing class ResetPassword {
    
    
    global static String username;
    
    global static String oldPassword;
    
    global static String newPassword;
    
   global static User userDetails;
    
    
    
@HttpGet

global static PasswordReset doGet(){
    


RestRequest req = RestContext.request;
RestResponse res = RestContext.response;


    System.debug('@@@@@req'+req);
    
    username = req.params.get('Username');
    
    oldPassword = req.params.get('OldPassword');
    
    newPassword = req.params.get('newPassword');
    
    
    
    
    
    try{
    userDetails = [Select id,Username,Password__c from User Us where Username=:username AND IsActive=True];
    system.debug(';;;;;;;;;;;;;;;'+userdetails);
    
    if(!((userDetails.Password__c).Equals(oldPassword))){
        
        
        PasswordReset passwo = new PasswordReset('The old passwords does not match, Please check once!');
        
        return passwo;
        
        System.debug('@@@@@passwo'+passwo);
        
    }
    
    userDetails.Password__c = newPassword;
    
    try{
    System.setPassword(userDetails.id, newPassword);
    Update userDetails;
    
    PasswordReset passwo = new PasswordReset('The password is updated!');
        
        return passwo;
        
        System.debug('@@@@@passwo'+passwo);
    
    }
    
    catch(Exception ex){
        
        System.debug('Exception Message'+ex.getMessage());
        
        PasswordReset passwo = new PasswordReset('Please check the new password and the last three passwords are remembered and cannot be reused!');
        
        return passwo;
        
        System.debug('@@@@@passwo'+passwo);
    }
    
    
    
    }
    
    Catch(System.QueryException ex){
        
        PasswordReset passwo = new PasswordReset('Please check the credentials or Contact Booth Admin once for the Account Activation Information');
        
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
 
}