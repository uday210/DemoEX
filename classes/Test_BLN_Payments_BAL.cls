@isTest(seeAllData=True)
public class Test_BLN_Payments_BAL{

static testmethod void Test_BLN_Payments_BAL(){
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
    
     User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            Order__c insertOrder1= new Order__c();
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
            
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
            Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id);
            insert payobj;
    
    
    
    BLN_Payments_BAL paybal = new BLN_Payments_BAL();
    paybal.stripeDirectCall(blnvar);
    try{
      paybal.stripeAdaptiveCall(blnvar);
       }catch(Exception e){}
     try{
    paybal.authoriZationCall(blnvar);
     }catch(Exception e){}
     paybal.paypalDirectCall(blnvar);
     try{
      paybal.paypalAdaptive(blnvar);
       }catch(Exception e){}
    try{
       paybal.trustCommerce(blnvar);
       }catch(Exception e){}
     try{
        paybal.trustCommercewithoutHost(blnvar);
        }catch(Exception e){}
        paybal.freePayment();
        paybal.checkPayment(blnvar);
         paybal.cardTypeChk('4111111111111111');
         paybal.cashPayment(blnvar);
          paybal.externalPayGatewayPayment(blnvar);
           paybal.upsertpaymentdetails(string.valueof(payobj.id),'Credit Card','Online',10.0,null,string.valueof(insertOrder1.id),string.valueof(currenyInfo.id),'visa','123456','2563',string.valueof(paygateway.id));
         try{
          paybal.trustCommercewithoutHost(blnvar);
          }catch(Exception e){}
}
    

}

}