@isTest
private class Test_testCon {

    static testMethod void testmethod_testCon() {
        Http h = new Http();
        //do request
        HttpRequest req = new HttpRequest();
        //RestRequest req = new RestRequest(); 
        //RestResponse res = new RestResponse();

        req.setHeader('Accept','application/json');
        req.setHeader('Accept-Language','en_US');
        req.setHeader('AYstUhDl1YyXAckwuOnNY5YI_nQ3zgAYGxVdDD84EHWMpr3ZB6bUe6VzsNx_','EAYwaBCNO0ODXW1tGxIFDaNTU5b0TwF_2GD1uHhiP6XLNk3H1vbbjmo5ZPkB' );
        req.setHeader('grant_type','client_credentials');
        req.setHeader('content-type','application/x-www-form-urlencoded');
    
     string endpoint = 'https://api.sandbox.paypal.com/v1/oauth2/token';
     req.setEndpoint(endpoint);
    
        //req.setMethod('POST');
        //HttpRequest.request = req;
       // HTTPResponse res = h.send(req);
        //RestContext.response = res;
       testCon tc = new testCon();
       testCon.istest  =true;
        tc.setPaymentOptions();

    }
}