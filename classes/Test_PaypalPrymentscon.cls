@istest
public class Test_PaypalPrymentscon{

Static testMethod void getMethod(){

PaypalPrymentscon con = new PaypalPrymentscon();

 Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
 Test.startTest() ;
  boolean res = con.doDirectPayment('2018','05','4955817800043311','40','20','Ph33333ani','ch');
Test.stopTest()  ;     
  //  con.doDirectPayment('2018','05','4955817800043311','40','20','Ph33333ani','ch');
}



}