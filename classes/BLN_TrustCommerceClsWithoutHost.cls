public with sharing class BLN_TrustCommerceClsWithoutHost {

public BLN_TrasactionStatus apiCall(BLN_VariablesCls vCls){
       BLN_TrasactionStatus  tStatus = new BLN_TrasactionStatus();
       String[] arrayt;
       Map<String,String> results; 
        Decimal TotalChargeAmount = vCls.TotalAmount*100;
        String Amount = String.valueOf(Integer.Valueof(TotalChargeAmount));  
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         String url = 'https://vault.trustcommerce.com/trans/?custid='+vCls.ANLoginId+'&password='+vCls.ANTransactionKey+'&action=sale&amount='+Amount+'&cc='+vCls.CreditCardNumber+'&exp='+vCls.SelectedMonth+vCls.Selectedyear.substring(2)+'&cvv='+vCls.CVVNumber+'&name='+vCls.buyerFirstname+vCls.buyerlastname;
         req.setEndpoint(url);
          req.setMethod('POST');
         HttpResponse res = h.send(req);
         arrayt=res.getBody().split('\n');
         results=new Map<String,String>();
           for(integer i=0;i<arrayt.size();i++)
           {
           String []temp= arrayt[i].split('=');
          results.put(temp[0],temp[1]);
           }
           if(results.get('status')== 'approved'){
                tStatus.transactionId = results.get('transid');
                if(vCls.CreditCardNumber.length()>5)
                  tStatus.cardLastDigits = vCls.CreditCardNumber.substring(vCls.CreditCardNumber.length()-4, vCls.CreditCardNumber.length());
            }else{ 
              //tStatus.errorMessage = results.get('status');
              tStatus.errorMessage = 'Please make sure that your credit card information is correct and resubmit this registration.';
           }
        return tStatus;
     }  

}