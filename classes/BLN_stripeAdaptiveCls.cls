public with sharing class BLN_stripeAdaptiveCls {



public BLN_TrasactionStatus tStatus{get;set;}


  public BLN_TrasactionStatus apiCall(BLN_VariablesCls vCls) {
  tStatus = new BLN_TrasactionStatus();
   System.debug('vCls.eventAdminAmount '+vCls.eventAdminAmount+'vCls.blFeeAmount '+vCls.blFeeAmount+' vCls.Stripe_API_Key '+vCls.Stripe_API_Key+' vCls.StripeRefreshToken '+vCls.StripeRefreshToken);
    try{
        List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
          boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='Stripe'];
            if(boothleadspaygate.size()>0){
                vCls.Stripe_API_Key= boothleadspaygate[0].PG_Pass_Secret__c;
                 // Stripe_API_Key = epg.Pay_Gateway__r.PGateway_Type__r.BoothLeads_Stripe_Secret__c;
               }else{
                  tStatus.errorMessage = 'Gateway is not valid!'; 
                  return tStatus;
               }
        
     Decimal TotalChargeAmount = vCls.eventAdminAmount*100;
        String Amount = String.valueOf(Integer.Valueof(TotalChargeAmount));
        tStatus = new BLN_TrasactionStatus();
        Decimal FeeChargeAmount = vCls.blFeeAmount *100;
        String FeesAmount = String.valueOf(Integer.Valueof(FeeChargeAmount));
          System.debug('vCls.eventAdminAmount '+vCls.eventAdminAmount+'vCls.blFeeAmount '+vCls.blFeeAmount+' vCls.Stripe_API_Key '+vCls.Stripe_API_Key+' vCls.StripeRefreshToken '+vCls.StripeRefreshToken);
  
      
            // Getting Card Token using Access Token
            Http CToken = new Http();
            
            HttpRequest reqCToken = new HttpRequest();
            reqCToken.setEndpoint('https://api.stripe.com/v1/tokens');
            String authorizationHeader = 'BEARER ' + vCls.StripeAccessToken;
            String TBodyParameters = 'card[number]='+vCls.CreditCardNumber+'&card[exp_month]='+vCls.SelectedMonth+'&card[exp_year]='+vCls.Selectedyear+'&card[cvc]='+vCls.CVVNumber;
            reqCToken.setHeader('Authorization', authorizationHeader);
            reqCToken.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            reqCToken.setBody(TBodyParameters);
            reqCToken.setMethod('POST');
            
            HttpResponse resCToken;
            resCToken = CToken.send(reqCToken);
            tStatus.errorMessage  =resCToken.getStatus();
            JSONTokenWrapper CTokenObj = (JSONTokenWrapper)JSON.deserialize(resCToken.getBody(), JSONTokenWrapper.class);
            
            
            // Creating Charge using token
            Http ChargeToken = new Http();
            
            System.debug(' Fee Amount '+FeesAmount +'  '+Amount);
            HttpRequest reqChargeToken = new HttpRequest();
            reqChargeToken.setEndpoint('https://api.stripe.com/v1/charges');
            String ChargeAuthorizationHeader = 'BEARER ' + vCls.StripeAccessToken;
            String ChargeBodyParameters = 'amount='+Amount+'&application_fee='+FeesAmount+'&currency=usd&card='+CTokenObj.id; 
            reqChargeToken.setHeader('Authorization', ChargeAuthorizationHeader);
            reqChargeToken.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            reqChargeToken.setBody(ChargeBodyParameters);
            reqChargeToken.setMethod('POST');
            
            HttpResponse resChargeToken;
            resChargeToken = ChargeToken.send(reqChargeToken);
             //StripeResponseMessage = resChargeToken.getStatus();
             tStatus.errorMessage =resChargeToken.getStatus();
             System.debug('PPPPPPPPPPPPP '+resChargeToken.getBody());  
               
             JSONChargeWrapper ChargeTokenObj = (JSONChargeWrapper)JSON.deserialize(resChargeToken.getBody(), JSONChargeWrapper.class);

            system.debug('Charge ID: ' + ChargeTokenObj.id);
            tStatus.transactionId = ChargeTokenObj.id;
            tStatus.cardLastDigits = ChargeTokenObj.source.last4;
            tStatus.cardType = ChargeTokenObj.source.brand; 
            
                        
           
         }catch(exception er){
            tStatus.errorMessage = er.getMessage();     
         }   
           return tStatus;
  }

  public class JSONRTokenWrapper{    
        public String access_token; 
        public string refresh_token;       
    }
    
    public class JSONTokenWrapper{    
        public String id;     
    }
    
    public class JSONChargeWrapper{    
        public String id;     
        public CardDetails source = new CardDetails();
        
    }
  
    public class CardDetails{
      public String last4;
      public String brand; 
        
    }
}