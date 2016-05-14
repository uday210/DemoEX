@istest
public class Test_webservicetesthittophpfoldercheck{
static testmethod void Test_webservicetesthittophpfoldercheck(){

webservicetesthittophpfoldercheck con = new webservicetesthittophpfoldercheck();

 Test.setMock(HttpCalloutMock.class, new MockHttpRespphp());
 Test.startTest() ;
  string res = con.webhitfoldercheck('testfolder');
Test.stopTest()  ;  


}
}