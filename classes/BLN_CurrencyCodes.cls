public with sharing class BLN_CurrencyCodes {
	
	
	public LIST<Currency__c> currencycodes(){
		LIST<Currency__c> curren = new LIST<Currency__c>();
		 curren = [SELECT id, Name, Currency_Name__c, Currency_Symbol__c FROM Currency__c WHERE Name ='USD'] ; 
		 
		return curren;                          
	}
	
	
	
	
	
	

}