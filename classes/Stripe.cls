public class Stripe{

/****************************************************************************************************
*   Controller Name         : Stripe
*   Date                    : 19/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This class is for constructing Stripe requests with API Key.
*****************************************************************************************************/
    
    String API_KEY=''; // API Key of Stripe Account Owner to which all payments will be credited
    
    // Constructor
    public Stripe(string apiKey){
        API_KEY = apiKey;
    }
    
    // This Method is for creating charge using Credit card details
    public StripeResponseModel createCharge(string cnumber, string exp_year, string exp_month, string cvc, string amount,string curncy, string description){
        StripeCharge strChr=new StripeCharge(API_KEY);
        return strChr.CreateCharge(cnumber,exp_year,exp_month,cvc,amount,curncy,description);
    }
    
    // This Method is for creating charge using CustomerId
    public StripeResponseModel createCharge(string customerId,string amount, string curncy, string description){
        StripeCharge strChr=new StripeCharge(API_KEY);
        return strChr.CreateCharge(customerId,amount,curncy,description);
    }
    
    // This Method is for retrieving charge using Chargeid
    public StripeResponseModel retrieveCharge(String chargeId){
        StripeCharge strChr=new StripeCharge(API_KEY);
        return strChr.retrieveCharge(chargeId);
    }
    
    // This Method is for refunding charge using Chargeid
    public StripeResponseModel refundCharge(String chargeId,String amount){
        StripeCharge strChr=new StripeCharge(API_KEY);
        return strChr.refundCharge(chargeId,amount);
    }
    
    // This Method is for creating customer using cerdit card details and billing information
    public StripeResponseModel createCustomer(String cnumber,String exp_month,String exp_year,String cvc,String name,String addressLine1,String addressLine2,String zip,String state,String country,String email,String description){
        StripeCustomer strCust=new StripeCustomer(API_KEY); 
        return strCust.createCustomer(cnumber,exp_month,exp_year,cvc,name,addressLine1,addressLine2,zip,state,country,email,description);
        
    }
    
    // This Method is for retrieving customer using CustomerId
    public StripeResponseModel retrieveCustomer(String customerId){
        StripeCustomer strCust=new StripeCustomer(API_KEY);
        return strCust.retrieveCustomer(customerId);
    }    
}