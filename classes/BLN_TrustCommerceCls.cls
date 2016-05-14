public with sharing class BLN_TrustCommerceCls {
    public BLN_TrasactionStatus apiCall(BLN_VariablesCls vCls){
      BLN_TrasactionStatus tStatus = new BLN_TrasactionStatus();
         Http h = new Http();
         HttpRequest req = new HttpRequest();
         String url = 'https://vault.trustcommerce.com/trustee/token.php?custid='+vCls.ANLoginId+'&password='+vCls.ANTransactionKey;
         req.setEndpoint(url);
         req.setMethod('POST');
         HttpResponse res = h.send(req);
         String xml = res.getBody();
         tStatus.payKey = xml; 
          tStatus.payGatewayName = 'trustcommerce';
           PageReference pg = new PageReference('/apex/TRUSTCOMMERCEPROCESS');
           pg.getParameters().put('token', xml);
           pg.getParameters().put('amount', String.valueOf(vCls.TotalAmount.setScale(2, RoundingMode.HALF_UP)));
           //newPage.getParameters().put('name', 'TESTPERSON');
           pg.getParameters().put('desc', 'Boothleads');
          //newPage.getParameters().put('ticket', ticket);
          pg.setRedirect(true);
          tStatus.pgRef =pg;
          tStatus.payGatewayName = 'trustcommerce';
          System.debug('tStatus.pgRef '+tStatus.pgRef);
       return tStatus;    
    }
}