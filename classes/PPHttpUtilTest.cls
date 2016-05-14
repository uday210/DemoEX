@isTest 
public class PPHttpUtilTest {

    static testmethod void testmethod_PPHttpUtil() {
        PPHttpUtil hh = new PPHttpUtil();
        Map<String, String> headers = new Map<String, String>();
        headers.put('key1', 'value1');
        headers.put('key2', 'value2');
        headers.put('HEADER1', 'VALUE');
        hh.createHttpRequest('http://google.com', 'POST', headers , 'body');
        hh.setCertificate('', '');
        
        // Asserttion
        System.assert(hh.getEndPoint() == 'http://google.com');
        System.assert(hh.getMethod() == 'POST');
        System.assert(hh.getHeader('key1') == 'value1');
        System.assert(hh.getHeader('key2') == 'value2');
        System.assert(hh.getBody() == 'body');
      
        //hh.execute();
    } 
}