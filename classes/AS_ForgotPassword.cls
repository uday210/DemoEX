@RestResource(urlMapping='/AS_ForgotPassword/*')
 
 /**
 * Author : Mahesh Sakunala
 * Email  : mahesh@globalnest.com
 * Phone  : 9666308210
 * AIM    : To retrieve user password.
 */
 
 global without sharing class AS_ForgotPassword{
    global static String username;
    global static User userDetails;
    
    @HttpGet
    global static PasswordReset doGet(){
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    username = req.params.get('Username').tolowercase();
    try{
        userDetails = [SELECT id,Username,Password__c,IsActive,email,firstname,lastname FROM User Us WHERE Username=:username];
        if(userDetails.IsActive =false){
            PasswordReset passwo = new PasswordReset('The User is not active, Please contact Scan Attendee !');
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
            mail.setsubject('Your Scan Attendee Account Password');
            mail.setHtmlBody('Dear '+userDetails.firstname+' '+userDetails.lastname+'<BR/>'+'<P> Your SCAN ATTENDEE Account information is below.</P>'+'<P> Username :'+userDetails.email+'</br></p>'+'<p> Password:'+userDetails.Password__c+'</p>');
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
        PasswordReset passwo = new PasswordReset('Please check the Username or Contact Scan Attendee once for the Account Activation Information');
        return passwo;   
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