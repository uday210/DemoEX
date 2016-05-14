public with sharing class BLN_Payments_BAL{

/*********************************************************************************************************************************************
*   Controller Name         : BLN_Payments_BAL
*   Date                    : Modified Date 19/08/2015(DDMMYY)
*   Author                  : Phani 
*   Purpose                 : This class is for routing payments from registrants to the event payment gateways.
**********************************************************************************************************************************************/

// ---------------------------------------------------------------- Variables Declaration Start ----------------------------------------------------------------------------
 BLN_globalCardType cardTypeStr = new BLN_globalCardType();
 public BLN_TrasactionStatus tStatus{get;set;}
 public String cardType{get;set;}   
//For stripe Direct
  public BLN_TrasactionStatus stripeDirectCall(BLN_VariablesCls vcls){
    tStatus = new BLN_TrasactionStatus();
   try{  
     cardType =cardTypeChk(vcls.CreditCardNumber); //Getting card type
     tStatus.errorMessage =BLN_ValidateCreditcard.ValidateCreditcard(vcls.CreditCardNumber, cardType, vcls.Selectedyear, vcls.SelectedMonth, vcls.CVVNumber);
        if(tStatus.errorMessage!='Valid'){
          return tStatus;
        }else{
          BLN_stripeDirectCls authCls = new BLN_stripeDirectCls();
          tStatus = authCls.apiCall(vcls);
          tStatus.cardType = cardType;
         return tStatus;
               }
    }catch(exception rt){
       tStatus.errorMessage = rt.getMessage();
        return tStatus;
            }
        }
 
        
//For stripe adaptive
  public BLN_TrasactionStatus stripeAdaptiveCall(BLN_VariablesCls vcls){
    BLN_stripeAdaptiveCls stripeAdv = new BLN_stripeAdaptiveCls();
      tStatus = new BLN_TrasactionStatus();
    tStatus = stripeAdv.apiCall(vcls);
    return tStatus;
               }
//For Authorization.Net  
  public BLN_TrasactionStatus authoriZationCall(BLN_VariablesCls vcls){
    tStatus = new BLN_TrasactionStatus();
    cardType =cardTypeChk(vcls.CreditCardNumber); //Getting card type
    tStatus.errorMessage =BLN_ValidateCreditcard.ValidateCreditcard(vcls.CreditCardNumber, cardType, vcls.Selectedyear, vcls.SelectedMonth, vcls.CVVNumber);
        if(tStatus.errorMessage!='Valid'){
          return tStatus;
        }else{
          BLN_Authorizationpaycls authCls = new BLN_Authorizationpaycls();
          tStatus = authCls.apiCall(vcls);
          tStatus.cardType = cardType;
          return tStatus;
            }

            }
            
 //For paypal Direct
  public BLN_TrasactionStatus paypalDirectCall(BLN_VariablesCls vcls){
    tStatus = new BLN_TrasactionStatus();
    cardType =cardTypeChk(vcls.CreditCardNumber); //Getting card type
    tStatus.errorMessage =BLN_ValidateCreditcard.ValidateCreditcard(vcls.CreditCardNumber, cardType, vcls.Selectedyear, vcls.SelectedMonth, vcls.CVVNumber);
        if(tStatus.errorMessage!='Valid'){
          return tStatus;
        }else{
          BLN_PaypalDirectCls authCls = new BLN_PaypalDirectCls();
          tStatus = authCls.apiCall(vcls);
          tStatus.cardType = cardType;
         return tStatus;
            }
            }
            
//For paypal adaptive
  public BLN_TrasactionStatus paypalAdaptive(BLN_VariablesCls vcls){
    BLN_paypalAdaptiveCls paypalAdv = new BLN_paypalAdaptiveCls();
    tStatus = paypalAdv.apiCall(vcls);
    return tStatus;
            }  

 //For trust commerce
   public BLN_TrasactionStatus trustCommerce(BLN_VariablesCls vcls){
    BLN_TrustCommerceCls  tComm = new BLN_TrustCommerceCls();
    tStatus = tComm.apiCall(vcls);
    System.debug('tStatus '+tStatus );
    return tStatus;
                }
            
  //For trust commerce without hostpage
   public BLN_TrasactionStatus trustCommercewithoutHost(BLN_VariablesCls vcls){
    tStatus = new BLN_TrasactionStatus();
    cardType =cardTypeChk(vcls.CreditCardNumber); //Getting card type
    tStatus.errorMessage =BLN_ValidateCreditcard.ValidateCreditcard(vcls.CreditCardNumber, cardType, vcls.Selectedyear, vcls.SelectedMonth, vcls.CVVNumber);
        if(tStatus.errorMessage!='Valid'){
          return tStatus;
        }else{
          BLN_TrustCommerceClsWithoutHost tCommwithouthost = new BLN_TrustCommerceClsWithoutHost();
    tStatus = tCommwithouthost.apiCall(vcls);
    tStatus.cardType = cardType;
    System.debug('tStatus '+tStatus );
         return tStatus;
            }
    }
    
  public BLN_TrasactionStatus freePayment(){
       tStatus = new BLN_TrasactionStatus();
       tStatus.transactionId='Free';
      return tStatus;
   }  
    
  public BLN_TrasactionStatus checkPayment(BLN_VariablesCls vcls){
    tStatus = new BLN_TrasactionStatus();
     tStatus.errorMessage =BLN_ValidateCreditcard.ValidateCheck(vcls.CheckNumber);
      if(tStatus.errorMessage!='Valid'){
          return tStatus;
        }else{
          BLN_PaypalDirectCls authCls = new BLN_PaypalDirectCls();
          tStatus.transactionId =vcls.CheckNumber;
          return tStatus;
    }
    }
    
    public BLN_TrasactionStatus cashPayment(BLN_VariablesCls vcls){
    tStatus = new BLN_TrasactionStatus();
    tStatus.transactionId='Cash';
     return tStatus;
    }
    
     public BLN_TrasactionStatus externalPayGatewayPayment(BLN_VariablesCls vcls){
    tStatus = new BLN_TrasactionStatus();
    tStatus.transactionId='External Pay Gateway';
     return tStatus;
  }
    
        
   public String cardTypeChk(String cardNo){
     if(cardNo!=null && cardNo!=''){
        return cardTypeStr.GetCreditCardType(cardNo); //Assign card type 
     }else{
        return '';
    }
    }
    public Payment__c upsertpaymentdetails(string pid,string paymodeTemp,string Registraiontype,Decimal AmountPaid,string billaddressid,string ord_id,string curency_id,string cardtype,string payrefnumb,string cardlast4dig,string paygatewayid ){
    /********************************/
    /*  string paymodeTemp='';
    
      string paygatewayType = '';
       //Get PGateway Type
        BLN_PGateway_Type_DAO PGatewayDAO = new BLN_PGateway_Type_DAO();
        Event_Pay_Gateway__c  PGateway = new Event_Pay_Gateway__c  ();
         try{
           PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(eventId,PGatewayMode,Module);
        }catch(exception er){}
        

        if(PGatewayType!='Cash' && PGatewayType!='Check' &&  PGatewayType!='External Pay Gateway' ){
          if(PGatewayType==''){ 
          paymodeTemp = 'Credit Card';
         }else if(PGatewayType == 'TrustCommerce' || PGatewayType == 'CreditCardPayPalDirect' || PGatewayType=='Authorize.Net'){
               paymodeTemp = 'Credit Card';
          }else{
            paymodeTemp =  PGatewayType;
         }
        }else if(PGatewayType=='External Pay Gateway'){
             paymodeTemp='External Pay Gateway';
        }else{
          paymodeTemp =  PGatewayType;
        }
        */
        //Insert Payment
        BLN_payment_DAO PaymentDAO = new BLN_payment_DAO();
        system.debug('-------------Pyament Mode----'+paymodeTemp);
        Payment__c Payment = new Payment__c();
        Payment.id=pid;
        Payment.Payment_Mode__c=paymodeTemp;
         Payment.Registration_Type__c=Registraiontype;
         Payment.Payment_Amount__c=AmountPaid;
         Payment.Order__c=ord_id;
         Payment.Currency_Code__c=curency_id;
         Payment.credit_card_type__c=cardtype;
         Payment.BLN_Pay_Gateway__c=paygatewayid;
         Payment.Pay_Address__c=billaddressid;
         Payment.Payment_Ref_Number__c=payrefnumb;
         Payment.credit_card_last_4digits__c=cardlast4dig;
         system.debug('&&&&&&&&&&&&&&&&&& Payment '+Payment);
        // Database.saveresult deb = DAtaBase.update(Payment,false);
        // system.debug('SSSSSSS Payment '+deb );
        BLN_StatusMessage PaymentMessage = PaymentDAO.upsrtpayment(Payment);
        return Payment;
    /*******************************/
    }
}