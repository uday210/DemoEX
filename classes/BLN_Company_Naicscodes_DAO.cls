/***********************************************************************************************
*   Controller Name : BLN_Company_Naicscodes_DAO
*   Date            : 08/10/2015
*   Author          : Thirupathi Pattipaka
*   Purpose         : This class is to get the Naics code 
*   Change History  : 10/31/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*    10/31/2014            Thirupathi Pattipaka           To get the list of naics codes where ever it requires
*  
**************************************************************************************************/
public without sharing class BLN_Company_Naicscodes_DAO{
	//Method to get list of company naics code related to company
	public LIST<Company_Naicscodes__c> naicsCodesForCompanyIds(SET<Id> CompanyIds){
        LIST<Company_Naicscodes__c> naicsCodesList= new LIST<Company_Naicscodes__c>();
        naicsCodesList= [SELECT id,name,BLN_Company__c,BLN_GN_User__c,BLN_NAICS_Code__c,BLN_NAICS_Code__r.Description__c,BLN_NAICS_Code__r.name 
        FROM 
        Company_Naicscodes__c 
        WHERE 
        BLN_Company__c IN : CompanyIds];
        return naicsCodesList;
    }
   public List<Company_Naicscodes__c> getCnsWithtktPid(String tktProfileId){
     return  [SELECT id,BLN_Company__c,BLN_NAICS_Code__c,BLN_NAICS_Code__r.Description__c,BLN_NAICS_Code__r.name,BLN_TKT_profile__c from Company_Naicscodes__c where BLN_TKT_profile__c=:tktProfileId];
   }
   
   public List<Company_Naicscodes__c> companyNAICSWithTKTPro(set<Id> tktProfileId){
     return  [SELECT id,Name,BLN_Company__c,BLN_NAICS_Code__c,BLN_NAICS_Code__r.Description__c,BLN_NAICS_Code__r.name,BLN_TKT_profile__c from Company_Naicscodes__c where BLN_TKT_profile__c in :tktProfileId];
   }


}