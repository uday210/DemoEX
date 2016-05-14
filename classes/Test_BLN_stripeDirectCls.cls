@isTest(seeAllData=True)
public class Test_BLN_stripeDirectCls{

static testmethod void Test_BLN_stripeDirectCls(){
BLN_VariablesCls blnvar=new BLN_VariablesCls();
blnvar.CreditCardNumber =  '4111111111111111';
    blnvar.CVVNumber = '123';
    blnvar.Selectedyear = '2016';
    blnvar.SelectedMonth = '05';
    blnvar.SelectedCardType = 'visa';
    blnvar.EventId = '';
    blnvar.EventName = '';
    blnvar.BoothleadsFee = true;
    blnvar.Module = 'Cash';
    blnvar.currencyCode = 'USD';
    blnvar.PaymentType = 'online';
    

    //Authorization Keys 
    blnvar.ANLoginId ='testid';    
    blnvar.ANTransactionKey ='1233';
    blnvar.authBool ='true';
    blnvar.payKeyDuration ='120' ;
    blnvar.Memo ='memo';
    blnvar.CheckNumber ='12345' ;
  /*  blnvar.passsecret ;
    blnvar.StripePaymentId ;
    blnvar.Stripe_API_Key ;
    blnvar.StripeRefreshToken ;*/
    blnvar.CancelUrl ='www.google.com';
    blnvar.ReturnUrl ='www.google.com'; 
    //Payment related
    blnvar.TotalAmount=0.0; // Actual amount of ticket
    blnvar.blFeeAmount=0.0;
    blnvar.eventAdminAmount=0.0;
    //payee Info
    blnvar.buyerFirstname  = 'test';
    blnvar.buyerLastname  = 'glst';
    blnvar.Company  = 'glst';
    blnvar.phone = '9875892826';
    blnvar.receiverEventdex = 'test adm';
    blnvar.receiverEventAdm = 'test admin';
    blnvar.FeesPayer = 'test payer';
    blnvar.street1 = 'ind test';
    blnvar.street2 = 'ind test2';
    blnvar.City = 'hyd';
    blnvar.State = 'TS';
    blnvar.Country = 'INDIA';
    blnvar.Zip = '50072';
    blnvar.Description = 'Test good';
    BLN_StripeDirectCls  strdirect = new BLN_StripeDirectCls();
    strdirect.apiCall(blnvar);

}
}