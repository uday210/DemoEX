public with sharing class BLN_Order_BAL {
	
  public BLN_StatusMessage ProcessOrder(Id GNUser, Id eveid, Id CmpId, String PaymentType, String PayKey, String OrderTotal, String AfterDiscountPrice, String DiscountedPrice, String FeeAmount, String OrderTaxes, String AmountPayable, String OrderStatus, String CurrencyCode ){
		Order__c ord = new Order__c();
		//ord.order_type__c = PaymentType;
		//ord.Amount_Paid__c = ;
		ord.Currency_Code__c = CurrencyCode;
		//ord.Client_User__c = uid;
        ord.bln_tkt_profile__r.bln_gn_user__c= GNUser;
        ord.bln_tkt_profile__r.bln_company__c= CmpId;
		if(OrderTotal != null)
			ord.Order_Total__c = Decimal.valueOf(OrderTotal);
		if(AfterDiscountPrice != null)
			ord.Order_Sub_Total__c = Decimal.valueOf(AfterDiscountPrice);
		if(FeeAmount != null)
			ord.Fee_Amount__c = Decimal.valueOf(FeeAmount);
		if(DiscountedPrice != null)
			ord.Order_Discount__c = Decimal.valueOf(DiscountedPrice);
		if(AmountPayable != null)
			ord.Amount_Paid__c  = Decimal.valueOf(AmountPayable);
		if(OrderTaxes != null)	
			ord.Order_Taxes__c = Decimal.valueOf(OrderTaxes);
		ord.Order_Status__c = OrderStatus;
		ord.Events__c = eveid;
   // ord.Transaction_Status__c = TransactionStatus;
		
		BLN_Order_DAO insertOrder = new BLN_Order_DAO();
		BLN_StatusMessage OrderMsg = new BLN_StatusMessage();
		OrderMsg = insertOrder.insertOrder(ord);		
		
		return OrderMsg;
	
	}
 
}