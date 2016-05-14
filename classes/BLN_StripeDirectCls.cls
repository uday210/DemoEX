public with sharing class BLN_StripeDirectCls {

public BLN_TrasactionStatus apiCall(BLN_VariablesCls vCls){
       BLN_TrasactionStatus tStatus = new BLN_TrasactionStatus();
      
    try{    
     //Get Currency
        BLN_Currency_DAO CurDAO =new BLN_Currency_DAO();
        Currency__c cur = CurDAO.getCurrencyDetails('id,name','name=\'USD\' LIMIT 1');
   
       Decimal TotalChargeAmount = vCls.eventAdminAmount*100;
        String Amount = String.valueOf(Integer.Valueof(TotalChargeAmount));
        
        Decimal FeeChargeAmount = vCls.blFeeAmount *100;
        String FeesAmount = String.valueOf(Integer.Valueof(FeeChargeAmount));
        
              Stripe StripeRequest = new Stripe(vCls.passsecret);
            StripeResponseModel StripeResponse = StripeRequest.createCharge(vCls.CreditCardNumber, vCls.Selectedyear, vCls.SelectedMonth, vCls.CVVNumber, String.valueOf(Integer.Valueof(Amount)+Integer.Valueof(FeesAmount)),cur.name,vCls.buyerFirstname+' '+vCls.buyerLastname);

            if(!StripeResponse.isError){
                system.debug('Charge ID: ' + StripeResponse.id);
                tStatus.transactionId = StripeResponse.id;
            }
            else{
                system.debug('Error Message :' + StripeResponse.errorResponse.message);
                 tStatus.errorMessage = 'Error';
            }
          return tStatus;
        }catch(exception er){
           tStatus.errorMessage = er.getMessage();
            return tStatus;
        }
     }  

}