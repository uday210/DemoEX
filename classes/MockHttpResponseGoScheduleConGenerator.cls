@isTest
global class MockHttpResponseGoScheduleConGenerator implements HttpCalloutMock {
      
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
       
       /******************************************************/
      
                   string pwd1='jRhX:6x$Wz*V&X';

            Blob beforeblob = Blob.valueOf(pwd1);
    
                // base64 encode the blob that contains our url param value
                string paramvalue = EncodingUtil.base64Encode(beforeblob);
            List<Integer> pwd= BLN_GoScheduleCon.stringToCodePoint(paramvalue);
             String preSharedkey1='1a3FJpDlZt6R87Uj2q78';
             List<Integer> preSharedkey= BLN_GoScheduleCon.stringToCodePoint(preSharedkey1);
             
             
            for (integer i = 0; i < pwd.size(); i++)
            {
            pwd[i]=pwd[i]^preSharedkey[i];
            }
            String p=String.fromCharArray(pwd);
            String encodedString = EncodingUtil.urlEncode(p,'UTF-8');
       /*****************************************************/
        System.assertEquals('https://b-comapi1.mci-group.com/API/Authenticate?ApplicationId=BOOTHLEADS&UserName=boothleads-apiuser1&Password='+encodedString+'&EventCodeList=EBMT2016', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        //String str = JSON.serialize('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX'); 
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX');
        
        res.setStatusCode(200);
        return res;
    }
}