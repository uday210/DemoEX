@istest
public class Test_AuthorizeDotNet {
    static testmethod void Test_AuthorizeDotNet(){
        AuthorizeDotNet auth = new AuthorizeDotNet(true, 'test', 'tKey');
        auth.transaction('111222333111222', '0103', '10', '123', 'yes', 'no');
        auth.setParameter('hi','hi');
        auth.setTransactionType('xtype');
        auth.isApproved();
        auth.isDeclined();
        auth.isError();
        
    }
  }