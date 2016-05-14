@istest

public class Test_StripeGetResponseValues{
  static testmethod void unittest(){
    StripeGetResponseValues str = new StripeGetResponseValues();
    str.getValue('','');
    str.getNumValue('','');
    str.getLastValue('','');
  }
}