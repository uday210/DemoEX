public with sharing class BLN_PaypalDirectCls {

public BLN_TrasactionStatus apiCall(BLN_VariablesCls vCls){
       BLN_TrasactionStatus  tStatus = new BLN_TrasactionStatus();     
        try{
          BLN_PaypalProccessorDirect pro = new BLN_PaypalProccessorDirect();
          pro.username = vCls.receiverEventdex;
          pro.passWord = vCls.ANLoginId;
          pro.Signature = vCls.ANTransactionKey;
           pro.city = 'ajm';
           pro.state = 'CA';
           pro.zip = '4534';
           pro.CVV = vCls.CVVNumber;
           pro.expYe = vCls.Selectedyear;
           pro.expMo = vCls.SelectedMonth;
           pro.CardNo = vCls.CreditCardNumber;
           pro.CardType = '';
           pro.FirstName = vCls.buyerFirstname;
           pro.LastName = vCls.buyerlastname;
           pro.Country = 'US';
           pro.Addy1 = '44';
           pro.Addy2 = '433';
            pro.amount = String.valueOf((vCls.TotalAmount).setScale(2, RoundingMode.HALF_UP));
           pro.PaymentAction='Sale';
           pro.pay();
           if(pro.message== 'Success'){
                tStatus.transactionId = pro.transid;
                if(vCls.CreditCardNumber.length()>5)
                  tStatus.cardLastDigits = vCls.CreditCardNumber.substring(vCls.CreditCardNumber.length()-4, vCls.CreditCardNumber.length());
             }else{ 
              tStatus.errorMessage = pro.message;
            }
          }catch(exception er){
            tStatus.errorMessage = er.getMessage();
          } 
        return tStatus;
     }  

}