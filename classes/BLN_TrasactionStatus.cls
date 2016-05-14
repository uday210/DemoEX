global with sharing class BLN_TrasactionStatus {
  public String errorMessage{get;set;}
  public String payKey{get;set;}
  public String cardLastDigits{get;set;}
  public String cardType{get;set;}
  public String transactionId{get;set;}
  public boolean isTransactionSuccess{get;set;}
  public String orderId{get;set;}
  public PageReference pgRef {get;set;}
  public String payGatewayName{get;set;}

}