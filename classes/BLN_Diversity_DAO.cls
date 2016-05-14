public with sharing class BLN_Diversity_DAO {
	public Static List<Diversity__c> getDiversities(){
	 List<Diversity__c> diversityList = new List<Diversity__c>();
		diversityList =[SELECT id,Name,Order__c from Diversity__c order by order__c ];  
       return diversityList;
	}
}