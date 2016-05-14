@istest

public class Test_StripeInvoice{
  static testmethod void unittest(){
    StripeInvoice str = new StripeInvoice('');
    str.createInvoice('4242424242424242','1000','usd','description');
    str.retreiveInvoice('');
    
  }
}