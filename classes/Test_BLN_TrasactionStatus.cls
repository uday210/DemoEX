@isTest(seeAllData=True)
public class Test_BLN_TrasactionStatus{

static testmethod void Test_BLN_TrasactionStatus(){
BLN_TrasactionStatus tstatus=new BLN_TrasactionStatus();
 tstatus.errorMessage = 'none';
 tstatus.payKey = 'AP 51255';
 tstatus.cardLastDigits = '4458';
 tstatus.cardType = 'visa';
 tstatus.transactionId = '84841545488';
 tstatus.isTransactionSuccess = true;
 tstatus.orderId = 'orderid';
 tstatus.pgRef  = null;
 tstatus.payGatewayName = 'paypal';

}
}