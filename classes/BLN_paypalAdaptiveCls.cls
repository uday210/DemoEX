public with sharing class BLN_paypalAdaptiveCls {


public string ApiUserName{get;set;}
public string Apipassword{get;set;}
public string Apisignature{get;set;}
public string ApiapplicationId{get;set;}
public string Apiipaddress{get;set;}
public BLN_TrasactionStatus tStatus{get;set;}
public  string paypalUrl{get;set;}

    public BLN_TrasactionStatus apiCall(BLN_VariablesCls vCls) {
            tStatus = new BLN_TrasactionStatus();
           String FeesPayer ='';
           String CommonParametersObjName='MyRequestParams';
           String APICredentialObjName ='SandboxCert';
           string encodedCipherText='';
           string eventidAfterEncoding='';
           String ActionType='PAY';
           Boolean FundingTypeEcheck = false;
           Boolean FundingTypeBalance = false;
           Boolean FundingTypeCreditCard = false;
           PPPayRequest request;
           PPResponseEnvelope RespEnvp;
           PPPayResponse PayResponse;
          try{
              request = new PPPayRequest(CommonParametersObjName, '',vCls.currencyCode);   
              request.ActionType = ActionType;  
            }catch(exception ed){
                request = new PPPayRequest();
            }
            blob eveuyE = Blob.valueOf(vCls.EventId);
            eventidAfterEncoding = EncodingUtil.base64Encode(eveuyE );
            request.CancelUrl = vCls.CancelUrl;
            request.ReturnUrl = vCls.ReturnUrl;
            request.Memo = vCls.Memo; 
            request.payKeyDuration =vCls.payKeyDuration;
            List<PPReceiver> receiverList = new List<PPReceiver>();
            request.FeesPayer = vCls.FeesPayer;
           System.debug('vCls.eventAdminAmount  '+vCls.eventAdminAmount +' vCls.receiverEventdex '+ vCls.receiverEventAdm +'vCls.receiverEventdex  '+vCls.receiverEventdex+'vCls.blFeeAmount '+ vCls.blFeeAmount);  
            try{
              PPReceiver rv = new PPReceiver();
              rv.Email =vCls.receiverEventAdm;
              if(vCls.PaymentType!='Simple'){
                rv.Amount = vCls.TotalAmount;
                rv.primary = TRUE;
              }else{
                rv.Amount = vCls.TotalAmount;
              }
              ActionType ='PAY';
              receiverList.add(rv); 
               if(vCls.PaymentType!='Simple'){
                    PPReceiver rv1 = new PPReceiver();
                    rv1.Email = vCls.receiverEventdex;
                    ActionType ='PAY'; 
                    rv1.Amount = vCls.blFeeAmount;
                    //FeeAmount+eventdexamount;
                    receiverList.add(rv1);
                }
            
            }catch(exception e){}
            request.receiverList = receiverList;
            // set FeesPayer
            request.FeesPayer = FeesPayer;
            if (FundingTypeEcheck) {
                PPFundingTypeInfo info = new PPFundingTypeInfo();
                info.FundingType = 'ECHECK';
                request.FundingTypeList.add(info);
            }
            if (FundingTypeBalance) {
                PPFundingTypeInfo info = new PPFundingTypeInfo();
                info.FundingType = 'BALANCE';
                request.FundingTypeList.add(info);
            }
            
            if (FundingTypeCreditCard) {
                PPFundingTypeInfo info = new PPFundingTypeInfo();
                info.FundingType = 'CREDITCARD';
                request.FundingTypeList.add(info);
            }
             PPAdaptiveToolkit toolkit;
            toolkit = new PPAdaptiveToolkit(APICredentialObjName);
             try {
                 PayResponse = toolkit.Pay(request);
                 RespEnvp = PayResponse.ResponseEnvelope;
                 if(PayResponse.PaymentExecStatus.equalsIgnoreCase('Created')){
                    ApiUserName= toolkit.BaseAPIProfile.APIUsername;
                    Apipassword =toolkit.BaseAPIProfile.APIPassword;
                    Apisignature =toolkit.BaseAPIProfile.APISignature;
                    ApiapplicationId = toolkit.BaseAPIProfile.ApplicationID;
                    Apiipaddress =request.ClientDetails.IpAddress;
                    paypalUrl= toolkit.BaseAPIProfile.getPayPalLoginPage(); 
                    try{
                      setPaymentOptions(PayResponse.payKey,vCls.EventName);
                      tStatus.payKey=PayResponse.payKey;
                      tStatus.pgRef = new pageReference(toolkit.BaseAPIProfile.getPayPalLoginPage()+'_ap-payment&paykey='+PayResponse.payKey);
                    }catch(exception ex){  }
                 }
                else if(PayResponse.PaymentExecStatus.equalsIgnoreCase('Completed')){
                   // SuccessMessage = 'Payment Completed - payKey - ' + PayResponse.payKey; 
                }
                else{
                    RespEnvp = PayResponse.getResponseEnvelope();
                    tStatus.errorMessage = 'Payment Execution Status returned from server is - ' + PayResponse.PaymentExecStatus;
                }
            
            }catch(PPFaultMessageException ex) {
               RespEnvp = ex.ResponseEnvelope;
               List<PPErrorData> errList = ex.ErrorList;
                for(PPErrorData err: errList ){
                    tStatus.errorMessage += err.ErrorId + ' : ' + err.Message ;
                }

            }catch(System.Exception e){
                System.debug('System.Exception =>' + e);
                tStatus.errorMessage = e.getMessage();
            } 
          tStatus.payGatewayName = 'paypaladaptive';

         return tStatus;
    }

  public void setPaymentOptions(string payval,string eventName){
    System.debug('PPPPPPPP:'+payval);
    try{
        Http h = new Http();
        HttpRequest req = new HttpRequest();   
         string NameofCompany  = eventName;
       if(string.isNotEmpty(NameofCompany)){ 
            NameofCompany = NameofCompany.ReplaceAll(' ','+');
        }

        req.setHeader('X-PAYPAL-SECURITY-USERID',ApiUserName);
        req.setHeader('X-PAYPAL-SECURITY-PASSWORD',Apipassword );      
        req.setHeader('X-PAYPAL-SECURITY-SIGNATURE',Apisignature );      
        req.setHeader('X-PAYPAL-DEVICE-IPADDRESS',Apiipaddress);
        req.setHeader('X-PAYPAL-REQUEST-DATA-FORMAT','NV');
        req.setHeader('X-PAYPAL-RESPONSE-DATA-FORMAT','NV');
        req.setHeader('X-PAYPAL-APPLICATION-ID',ApiapplicationId );
        string sandboxvalue='';
        if(paypalUrl.contains('sandbox')){
            sandboxvalue='sandbox.';
        }

        string endpoint = 'https://svcs.'+sandboxvalue+'paypal.com/AdaptivePayments/SetPaymentOptions?method=SetPaymentOptions&requestEnvelope.errorLanguage=en_US&payKey='+payval+'&displayOptions.businessName='+NameofCompany;

        req.setEndpoint(endpoint);
        req.setMethod('GET'); 
            HTTPResponse res = h.send(req);
            system.debug('Name on PayPal Login '+ res.getBody());
       
    }catch(exception ex){

    }        
}

}