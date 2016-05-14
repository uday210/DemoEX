public with sharing class StripeConnectController {

    public String authCode{get;set;}
    public String authorizationCodeURI{get;set;}
    public String body{get;set;}
    
    public stripeconnectcontroller (){
    
        authCode = ApexPages.currentPage().getParameters().get('code');
        authorizationCodeURI = 'https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_3jL4mUKJtvfExOYL8WrumSxkX7yh8P5m&scope=read_write';
        HttpResponse resToken;
        if(authCode != NULL){
        
            Http hToken = new Http();
            HttpRequest reqToken = new HttpRequest();
            reqToken.setEndpoint('https://connect.stripe.com/oauth/token?grant_type=authorization_code&code='+authCode+'&client_secret=sk_test_SEppbKiXBACmm9tRsJZkpB8l');
            reqToken.setMethod('POST');
            resToken = hToken.send(reqToken);
            body = resToken.getBody();
           
            JSONWrapper jsonWrapObj = (JSONWrapper)JSON.deserialize(body, JSONWrapper.class);
            
            system.debug('********* '+jsonWrapObj.access_token);
        }
    }
    
    public class JSONWrapper{    
        public Integer expires_in;
        public String access_token;  
        public String refresh_token;
    }

}