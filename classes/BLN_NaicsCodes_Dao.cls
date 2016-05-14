public with sharing class BLN_NaicsCodes_Dao {
	public Static List<List<NAICS_Code__c>> getNaicscodes(){
       LIST<LIST<NAICS_Code__c>> listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
        List<NAICS_Code__c> naicscodeslist = new List<NAICS_Code__c>();
        for(NAICS_Code__c naics : [SELECT id,Name,Description__c FROM NAICS_Code__c]){
            naicscodeslist.add(naics); 
            if(naicscodeslist.size() == 999){
                listOfnaicscodes.add(naicscodeslist);                
                naicscodeslist= new LIST<NAICS_Code__c>();
            }
     }
   
       if(naicscodeslist.size() != 0){
            listOfnaicscodes.add(naicscodeslist);
        } 
     return listOfnaicscodes; 
   }  
 }