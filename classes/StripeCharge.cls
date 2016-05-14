public class StripeCharge{

/*************************************************************************************************************************************
*   Controller Name         : StripeCharge
*   Date                    : 19/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This class is for charging,retrieving charge and refunding user through Stripe gateway using REST API.
**************************************************************************************************************************************/

    public StripeGetResponseValues stripeGetResponseValue{get;set;}
    public StripeResponseModel StripeResponseModel{get;set;}
    
    Integer statusCode;
    string response;
    
    private string CHARGE_URL = 'https://api.stripe.com/v1/charges';
    private string API_KEY = '';   
    
// --------------------------------------------------------------- Constructor Start ------------------------------------------------------------------------------------     
    public StripeCharge(String apikey){
        API_KEY = apiKey;
        StripeResponseModel=new StripeResponseModel();   
        stripeGetResponseValue=new StripeGetResponseValues();     
    }
// ---------------------------------------------------------------- Constructor End -------------------------------------------------------------------------------------   

// This method is for creating charge using Credit card details
    public StripeResponseModel CreateCharge(string cnumber, string exp_year, string exp_month, string cvc, string amount, string curncy, string description){
         system.debug('SSSSSSSSSSSSSSSS UUUUUUUUUUUUUu  '+cnumber+exp_year+exp_month+cvc+amount+description+curncy);
        HttpRequest http = new HttpRequest();
        http.setEndpoint(CHARGE_URL);
        http.setMethod('POST');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
        http.setBody('card[number]='+cnumber+'&card[exp_year]='+exp_year+'&card[exp_month]='+exp_month+'&card[cvc]='+cvc+'&amount='+amount + '&currency='+curncy+'&description='+description);
        
        if(!Test.isRunningTest()){
            Http con = new Http();
        
            HttpResponse hs = con.send(http);
          system.debug('RRRRRRRRRRRRRRR '+hs );
            response = hs.getBody();
            statusCode=hs.getStatusCode();
        }else{
            statusCode=200;
            response='"amount": 200,';
            response+='"currency": "usd",';
            response+='"description": "description",';
            response+='"fee": 36,';
            response+='"id": "ch_23H2LL6nPNNL0Z",';
            response+='"livemode": false,';
            response+='"object": "charge",';
            response+='"paid": true,';
            response+='"refunded": false,';
            response+='"card": {';
            response+='"country": "US",';
            response+='"cvc_check": "pass",';
            response+='"exp_month": 12,';
            response+='"exp_year": 2013,';
            response+='"last4": "4242",';
            response+='"object": "card",';
            response+='"type": "Visa"';
            response+='}';
            response+='}';

        }
        
        if(statusCode!=200){
         
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=stripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =stripeGetResponseValue.getValue(response,'"param":');
            StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
            
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=stripeGetResponseValue.getValue(response,'"id":');
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":');
            StripeResponseModel.paid=stripeGetResponseValue.getNumValue(response,'"paid":');
            StripeResponseModel.fee=stripeGetResponseValue.getNumValue(response,'"fee":');
            StripeResponseModel.refunded=stripeGetResponseValue.getNumValue(response,'"refunded":');
            StripeResponseModel.rObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":'); 
            StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"created":'); 
            
            //StripeResponseModel.card.ctype=stripeGetResponseValue.getValue(response,'"type":');
            StripeResponseModel.card.ctype=stripeGetResponseValue.getLastValue(response,'"type":');
            
            StripeResponseModel.card.cvc_check=stripeGetResponseValue.getValue(response,'"cvc_check":');
            StripeResponseModel.card.cObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.card.country =stripeGetResponseValue.getValue(response,'"country":');
            StripeResponseModel.card.exp_month=stripeGetResponseValue.getNumValue(response,'"exp_month":'); 
            StripeResponseModel.card.last4 =stripeGetResponseValue.getValue(response,'"last4":');
            StripeResponseModel.card.exp_year=stripeGetResponseValue.getNumValue(response,'"exp_year":');        
                                         
        }                                                    
        return StripeResponseModel;    
    }

// This method is for refund charge using chargeid    
    public StripeResponseModel refundCharge(String chargeId,String amount){
        String chargeUrl=CHARGE_URL +'/'+chargeId+'/refund'; 
        HttpRequest http = new HttpRequest();
        http.setEndpoint(chargeUrl);
        http.setMethod('GET');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
        http.setBody('amount='+amount);
        
        if(!Test.isRunningTest()){
            Http con = new Http();
            HttpResponse hs = con.send(http);

            response = hs.getBody();
            statusCode=hs.getStatusCode();
        }
        else{
            statusCode=200;
            response='"amount": 200,';
            response+='"currency": "usd",';
            response+='"description": "description",';
            response+='"fee": 36,';
            response+='"id": "ch_23H2LL6nPNNL0Z",';
            response+='"livemode": false,';
            response+='"object": "charge",';
            response+='"paid": true,';
            response+='"refunded": false,';
            response+='"card": {';
            response+='"country": "US",';
            response+='"cvc_check": "pass",';
            response+='"exp_month": 12,';
            response+='"exp_year": 2013,';
            response+='"last4": "4242",';
            response+='"object": "card",';
            response+='"type": "Visa"';
            response+='}';
            response+='}';
        }
        
        if(statusCode!=200){
         
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=stripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =stripeGetResponseValue.getValue(response,'"param":');
            StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
            
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=stripeGetResponseValue.getValue(response,'"id":');
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":');
            StripeResponseModel.paid=stripeGetResponseValue.getNumValue(response,'"paid":');
            StripeResponseModel.fee=stripeGetResponseValue.getNumValue(response,'"fee":');
            StripeResponseModel.refunded=stripeGetResponseValue.getNumValue(response,'"refunded":');
            StripeResponseModel.rObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":'); 
            StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"created":'); 
            
            //StripeResponseModel.card.ctype=stripeGetResponseValue.getValue(response,'"type":');
            StripeResponseModel.card.ctype=stripeGetResponseValue.getLastValue(response,'"type":');
            
            StripeResponseModel.card.cvc_check=stripeGetResponseValue.getValue(response,'"cvc_check":');
            StripeResponseModel.card.cObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.card.country =stripeGetResponseValue.getValue(response,'"country":');
            StripeResponseModel.card.exp_month=stripeGetResponseValue.getNumValue(response,'"exp_month":'); 
            StripeResponseModel.card.last4 =stripeGetResponseValue.getValue(response,'"last4":');
            StripeResponseModel.card.exp_year=stripeGetResponseValue.getNumValue(response,'"exp_year":');        
                                         
        }                                                    
        return StripeResponseModel;
        
    }
    
// This method is for retrieving charge using ChargeId    
    public StripeResponseModel retrieveCharge(String chargeId){
        String mainUrl=CHARGE_URL +'/'+chargeId;        
        HttpRequest http = new HttpRequest();
        http.setEndpoint(mainUrl);
        http.setMethod('GET');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);

        if(!Test.isRunningTest()){
            Http con = new Http();
            HttpResponse hs = con.send(http);

            response = hs.getBody();
            statusCode=hs.getStatusCode();
        }else{
            statusCode=200;
            response='"amount": 200,';
            response+='"currency": "usd",';
            response+='"description": "description",';
            response+='"fee": 36,';
            response+='"id": "ch_23H2LL6nPNNL0Z",';
            response+='"livemode": false,';
            response+='"object": "charge",';
            response+='"paid": true,';
            response+='"refunded": false,';
            response+='"card": {';
            response+='"country": "US",';
            response+='"cvc_check": "pass",';
            response+='"exp_month": 12,';
            response+='"exp_year": 2013,';
            response+='"last4": "4242",';
            response+='"object": "card",';
            response+='"type": "Visa"';
            response+='}';
            response+='}';

        }
        
         if(statusCode!=200){
         
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=stripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =stripeGetResponseValue.getValue(response,'"param":');
            //StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getLastValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
            
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=stripeGetResponseValue.getValue(response,'"id":');
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":');
            StripeResponseModel.paid=stripeGetResponseValue.getNumValue(response,'"paid":');
            StripeResponseModel.fee=stripeGetResponseValue.getNumValue(response,'"fee":');
            StripeResponseModel.refunded=stripeGetResponseValue.getNumValue(response,'"refunded":');
            StripeResponseModel.rObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":'); 
            StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"created":'); 
            
            //StripeResponseModel.card.ctype=stripeGetResponseValue.getValue(response,'"type":');
            StripeResponseModel.card.ctype=stripeGetResponseValue.getLastValue(response,'"type":');         
              
            StripeResponseModel.card.cvc_check=stripeGetResponseValue.getValue(response,'"cvc_check":');
            StripeResponseModel.card.cObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.card.country =stripeGetResponseValue.getValue(response,'"country":');
            StripeResponseModel.card.exp_month=stripeGetResponseValue.getNumValue(response,'"exp_month":'); 
            StripeResponseModel.card.last4 =stripeGetResponseValue.getValue(response,'"last4":');
            StripeResponseModel.card.exp_year=stripeGetResponseValue.getNumValue(response,'"exp_year":');        
                                         
        }                                                    
        return StripeResponseModel;

    }
    
// This method is for creating charge using Customerid 
     public StripeResponseModel CreateCharge(string customerId,string amount,string curncy, string description){
        
        HttpRequest http = new HttpRequest();
        http.setEndpoint(CHARGE_URL);
        http.setMethod('POST');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
       // http.setBody('customer='+customerId+'&amount='+amount+'&currency='+curncy+'&description='+description+'&application_fee='+appfee);
        http.setBody('customer='+customerId+'&amount='+amount+'&currency='+curncy+'&description='+description);
        if(!Test.isRunningTest()){
            Http con = new Http();
            HttpResponse hs = con.send(http);

            response = hs.getBody();
            statusCode=hs.getStatusCode();
        }else{
            statusCode=200;
            response='"amount": 200,';
            response+='"currency": "usd",';
            response+='"description": "description",';
            response+='"fee": 36,';
            response+='"id": "ch_23H2LL6nPNNL0Z",';
            response+='"livemode": false,';
            response+='"object": "charge",';
            response+='"paid": true,';
            response+='"refunded": false,';
            response+='"card": {';
            response+='"country": "US",';
            response+='"cvc_check": "pass",';
            response+='"exp_month": 12,';
            response+='"exp_year": 2013,';
            response+='"last4": "4242",';
            response+='"object": "card",';
            response+='"type": "Visa"';
            response+='}';
            response+='}';
        }
        
         if(statusCode!=200){
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=stripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =stripeGetResponseValue.getValue(response,'"param":');
            //StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getLastValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
               
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=stripeGetResponseValue.getValue(response,'"id":');
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":');
            StripeResponseModel.paid=stripeGetResponseValue.getNumValue(response,'"paid":');
            StripeResponseModel.fee=stripeGetResponseValue.getNumValue(response,'"fee":');
            StripeResponseModel.refunded=stripeGetResponseValue.getNumValue(response,'"refunded":');
            StripeResponseModel.rObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":'); 
            StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"created":'); 
            
            //StripeResponseModel.card.ctype=stripeGetResponseValue.getValue(response,'"type":');
            StripeResponseModel.card.ctype=stripeGetResponseValue.getLastValue(response,'"type":');
            
            StripeResponseModel.card.cvc_check=stripeGetResponseValue.getValue(response,'"cvc_check":');
            StripeResponseModel.card.cObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.card.country =stripeGetResponseValue.getValue(response,'"country":');
            StripeResponseModel.card.exp_month=stripeGetResponseValue.getNumValue(response,'"exp_month":'); 
            StripeResponseModel.card.last4 =stripeGetResponseValue.getValue(response,'"last4":');
            StripeResponseModel.card.exp_year=stripeGetResponseValue.getNumValue(response,'"exp_year":');        
                                         
        }                                                   
        return StripeResponseModel;
    }
}