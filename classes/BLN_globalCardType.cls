public with sharing class BLN_globalCardType {
    public string GetCreditCardType(string CreditCardNumber){
        Pattern regVisa =Pattern.compile('^4[0-9]{12}(?:[0-9]{3})?$');
        Pattern regMaster =Pattern.compile('^5[1-5][0-9]{14}$');
        Pattern regExpress =Pattern.compile('^3[47][0-9]{13}$');
        Pattern regDiners = Pattern.compile('^3(?:0[0-5]|[68][0-9])[0-9]{11}$');
        Pattern regDiscover =Pattern.compile('^6(?:011|5[0-9]{2})[0-9]{12}$');
        Pattern regJCB= Pattern.compile('^(?:2131|1800|35\\d{3})\\d{11}$');
       
       
         if(regVisa.matcher(CreditCardNumber).matches())
            return 'VISA';
          else if (regMaster.matcher(CreditCardNumber).matches())
            return 'MASTER';  
         else  if (regExpress.matcher(CreditCardNumber).matches())
            return 'AMEX';
         else if (regDiners.matcher(CreditCardNumber).matches())
            return 'DINERS';
         else if (regDiscover.matcher(CreditCardNumber).matches())
            return 'DISCOVERS';
         else   if (regJCB.matcher(CreditCardNumber).matches())
            return 'JCB';
         else
           return '';
    }
}