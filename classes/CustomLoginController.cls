/**
 * An apex page controller that exposes the site login functionality
 */
global without sharing class CustomLoginController {
    
    global String urlVal{get; set;}
    global String username{get;set;}
    global String password{get;set;}
   
    global String ida{get; set;}
    global String error{get; set;}
    
    global CustomLoginController () {}
    
    global PageReference forwardToCustomAuthPage() {
        return new PageReference( '/CustomLogin');
    }
    global PageReference login() {
        username = username.trim();
        error='';
       List<user> usr = [SELECT Id,IsSignup__c from User where userName=:username ];
       if(usr.size()>0){  
         if(usr[0].IsSignup__c ==true){       
        PageReference pf = Site.login(username, password, '/CustomLanding');
        If(pf == null){
            error = 'Username or password incorrect';
            return null;
        }else{
            return pf;
        }
        }else{
           error='This ID is not signed up. Please Sign Up.';
            return null;
        }    
      }else{
         error='User does not exist.';
          return null;
      }
    
    }
    
    global PageReference signup() {
        return new PageReference('/CommunitiesSelfReg');
    }

}