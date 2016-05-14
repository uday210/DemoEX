@istest
 public class Test_PaypalIPNController {

 
 static testMethod void testpaypalipn() {
 PaypalIPNController pipn=new PaypalIPNController();
 pipn.digestMessage();
pipn.dummy1();
 }
 }