@isTest(seeAllData=True)
public class Test_BLN_PaypalDirectCls{

static testmethod void Test_BLN_PaypalDirectCls(){
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
    blnvar.currencyCode = 
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
    

BLN_PaypalDirectCls paydirect =new BLN_PaypalDirectCls();
paydirect.apiCall(blnvar);
    
 BLN_PaypalProccessorDirect ppd=new BLN_PaypalProccessorDirect();   
     
    ppd.result ='Test Result';
    ppd.transid = 'Testresult1';
    ppd.rawResponse = 'testresult2';
    ppd.apiResult = 'testresult3';
   
 
    ppd.getBalanceRequest();
    
    try{

        
    XmlStreamReader xm =new XmlStreamReader('xmlInput');
    xm.getEventType();
    xm.getLocalName();
    ppd.readXMLResponse(xm,'test');
    
    
    }catch(exception e11){}
    
    
    
}

static testmethod void Test_BLN_PaypalDirectCls1(){

try{
 BLN_PaypalProccessorDirect ppd1= new BLN_PaypalProccessorDirect();   
     
   ppd1.FirstName = '';
   ppd1.LastName = '';
   ppd1.Addy1 = '';
   ppd1.city = '';
   ppd1.state = '';
   ppd1.zip = '';
   ppd1.CardNo = '';
   ppd1.expMo = '';
   ppd1.expYe = '';
   ppd1.amount = '0';
   
   
   
   ppd1.pay();
 }catch(exception e12){}
 
}



}