@istest

public class Test_StripeCharge{
  static testmethod void unittest(){
    StripeCharge str = new StripeCharge('');
    str.CreateCharge('4242424242424242','2020','12','123','1000','usd','tets'); 
    str.retrieveCharge('12');
    str.CreateCharge('','1000','usd', '');
    str.refundCharge('','1000');
  }
}