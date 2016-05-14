public with sharing class BLN_OrderItem_BAL {
	
	
	
	public BLN_StatusMessage processOrderItems(Id GNUser, Id eveid, Id CmpId, Id OrderId, Id CurrencyCode, List<BLN_ASC_WS_SellTickets.Orders> AllOrderItems ){
		
		Order_Item__c aoitms = new Order_Item__c();
		
		for(BLN_ASC_WS_SellTickets.Orders oli : AllOrderItems){
			aoitms.Currency__c = CurrencyCode;
			aoitms.Order__c = OrderId;
			aoitms.Item__c = oli.ItemId;
			system.debug('ItemId in bal=== '+oli.ItemId);
			
			
			
		}
		
		
		
		return null;
		
	}
	

}