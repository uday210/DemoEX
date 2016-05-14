public without sharing class BLN_Company_Ext_DAO{
  /**
* @author :Manasa Gandham
* @date 10/31/2014
* @ This class is used for DML operations on Company Ext object
*/ 

    public LIST<Company_Ext__c> companyExtsForCompanyIds(SET<Id> CompanyIds){
        LIST<Company_Ext__c> companyExtsList= new LIST<Company_Ext__c>();
        //companyExtsList= [SELECT Blog_URL__c, Business_Address1__c, Business_Address2__c, Business_City__c, BLN_Business_Country__r.Long_Name__c, BLN_Business_State__r.Long_Name__c, Business_Zipcode__c, Company__c, Duns_Number__c, Established_Date__c, Keywords__c, Number_Of_Employees__c, Primary_Business_Category__c, Primary_NAICS_Code__r.Description__c, Secondary_NAICS_Code__r.Description__c, Revenue__c, Secondary_Business_Category__c, Tax_Id__c, Work_Phone__c  FROM Company_Ext__c WHERE Company__c IN : CompanyIds];
        companyExtsList= [SELECT Blog_URL__c, Business_Address1__c, Business_Address2__c, Business_City__c, BLN_Business_Country__r.Long_Name__c, BLN_Business_State__r.Long_Name__c, Business_Zipcode__c, Company__c, Duns_Number__c, Established_Date__c, Keywords__c, Number_Of_Employees__c, Primary_Business_Category__c, Primary_NAICS_Code__r.Description__c, Secondary_NAICS_Code__r.Description__c, Revenue__c, Secondary_Business_Category__c, Tax_Id__c, Work_Phone__c,
                                 id,BLN_Business_State__c,company__r.Website_URL__c,company__r.Description__c,Primary_NAICS_Code__r.Name,Secondary_NAICS_Code__r.Name 
                            FROM Company_Ext__c WHERE Company__c IN : CompanyIds];
        return companyExtsList;
    }
    
      /********This method is to get companyExts information,written by Purna *******************************/
      
    public List<Company_Ext__c> companyExtsForCompanyId(String selectedcompany){
           List<Company_Ext__c> companyExtsInfo= new List<Company_Ext__c>();
        
        companyExtsInfo = [SELECT ID, NAME, Business_Address1__c, Business_Address2__c, Business_City__c, BLN_Business_Country__c, BLN_Business_Country__r.Short_Name__c, BLN_Business_State__c,BLN_Business_State__r.Short_Name__c, Business_Zipcode__c, Work_Phone__c,Company__c,Duns_Number__c,
                  Established_Date__c,Keywords__c,Number_Of_Employees__c,Revenue__c,Tax_Id__c,Primary_Business_Category__c,Secondary_Business_Category__c,Blog_URL__c,                
                  BLN_Business_Country__r.Long_Name__c,Billing_Address__c,Billing_Address__r.Address1__c,Billing_Address__r.Address2__c,Billing_Address__r.City__c,Billing_Address__r.State__c ,Billing_Address__r.Country__c ,Billing_Address__r.Zipcode__c,Billing_Address__r.Country__r.Long_Name__c FROM Company_Ext__c where Company__r.id =: selectedcompany  limit 1];
    
        return companyExtsInfo;
        
    }
    
    public BLN_StatusMessage insertingComexts(List<Company_Ext__c> comext){
    	system.debug('QQQQQQQQQQQQQQQQQQQQQQQ '+comext);
        dataBase.saveresult[] sav = dataBase.insert(comext,false);
       
        return new BLN_StatusMessage(sav);
    }
    
}