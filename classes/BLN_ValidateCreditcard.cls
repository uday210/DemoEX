public with sharing class BLN_ValidateCreditcard {
    public Static String ValidateCreditcard(String CreditCardNumber,String SelectedCardType,String selectedyear,String selectedMonth,String CVVNumber) {
         String PaymentErrorString='';
        if(string.isBlank(CreditCardNumber)){
                 PaymentErrorString='Please Enter Credit Card Number';
                 return PaymentErrorString;
             }else if(!string.isBlank(CreditCardNumber) && ! CreditCardNumber.isNumeric()){
                 PaymentErrorString='Please Enter Numbers only';
                 return PaymentErrorString;
             }else if(CreditCardNumber.length() != 16 && SelectedCardType != 'AMEX'){
                 PaymentErrorString='Please Enter 16 digit Number';
                 return PaymentErrorString;
             }
             else if(CreditCardNumber.length() != 15 && SelectedCardType == 'AMEX'){
                 PaymentErrorString='Please Enter 15 digit Number';
                 return PaymentErrorString;
             }
             else if(integer.valueof(selectedyear) == system.today().year() && integer.valueof(selectedMonth) < system.today().month()){
                 PaymentErrorString='Please Select Valid Expiry Date';
                 return PaymentErrorString;
             }else if(string.isBlank(CVVNumber)){
                 PaymentErrorString='Please Enter CVV Number';
                 return PaymentErrorString;
             }else if(!string.isBlank(CVVNumber) && ! CVVNumber.isNumeric()){
                 PaymentErrorString='Please Enter Numbers only';
                 return PaymentErrorString;
             }else if((CVVNumber != NULL || CVVNumber != '') && CVVNumber.length() < 3 && SelectedCardType != 'AMEX'){
                 PaymentErrorString='Please Enter 3 Digit Number';
                 return PaymentErrorString; 
             }
             else if((CVVNumber != NULL || CVVNumber != '') && CVVNumber.length() != 4 && SelectedCardType == 'AMEX'){
                 PaymentErrorString='Please Enter 4 Digit Number';
                 return PaymentErrorString; 
             }
             else{
               return 'Valid'; 
            }
    }

    public Static String ValidateCheck(String CheckNumber) {
        
      if(string.isBlank(CheckNumber)){
         return 'Please Enter Check Number';
       }else{
          //Pattern patternq = Pattern.compile('^[a-zA-Z0-9]*$');
          //Matcher matcher = patternq.matcher(CheckNumber);
          //if(!matcher.matches()){
          //    return ' Please enter the valid check number';    
        // }else{
            return 'Valid';
         //}
         
       }
     }

  public Static string validateEmail(string emailvalid){
    Pattern p = Pattern.compile( '([a-zA-Z0-9_\\-\\.]+)@(((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3}))');
    Matcher m = p.matcher(emailvalid);
      if (m.matches()) {
        return 'Valid';
     } else {
       return 'Invalid email address!';
    }
  }



}