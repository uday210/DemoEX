@istest
public class Test_webservicetesthittophp{
static testmethod void Test_webservicetesthittophp(){

webservicetesthittophp con = new webservicetesthittophp();

 Test.setMock(HttpCalloutMock.class, new MockHttpRespphp());
 Test.startTest() ;
 date stdt = system.today();
 date enddt = system.today();
  string res = con.webhitphp('google.com','testfolder','test event',stdt,enddt ,'123');
Test.stopTest()  ;  


}
}