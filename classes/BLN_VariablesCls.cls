global with sharing class BLN_VariablesCls {
    //Credit card related
    public String CreditCardNumber{get;set;} 
    public String CVVNumber{get;set;}
    public String Selectedyear{get;set;}
    public String SelectedMonth{get;set;}
    public String SelectedCardType{get;set;}
    public string EventId{get;set;}
    public string EventName{get;set;}
    public boolean BoothleadsFee{get;set;}
    public String Module{get;set;}
    public String currencyCode{get;set;}
    public String PaymentType{get;set;}
    

    //Authorization Keys 
    public String ANLoginId{get;set;}
    public String ANTransactionKey{get;set;}
    public String authBool{get;set;}
    public String payKeyDuration{get;set;}
    public String Memo{get;set;}
    public String CheckNumber{get;set;}
    public String passsecret{get;set;}
    public String StripePaymentId{get;set;}
    public String Stripe_API_Key{get;set;}
    public String StripeRefreshToken{get;set;}
    public String StripeAccessToken{get;set;}
    public String CancelUrl{get;set;}
    public String ReturnUrl{get;set;}
    //Payment related
    public Decimal TotalAmount=0.0; // Actual amount of ticket
    public Decimal blFeeAmount=0.0;
    public Decimal eventAdminAmount=0.0;
    //payee Info
    public String buyerFirstname {get;set;}
    public String buyerLastname {get;set;}
    public String Company {get;set;}
    public String phone{get;set;}
    public String receiverEventdex{get;set;}
    public String receiverEventAdm{get;set;}
    public String FeesPayer{get;set;}
    public String street1{get;set;}
    public String street2{get;set;}
    public String City{get;set;}
    public String State{get;set;}
    public String Country{get;set;}
    public String Zip{get;set;}
    public String Description{get;set;}
    

}