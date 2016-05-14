public with sharing class BLN_TKTProfile_DAO {
    public TKT_profile__c getTktpFormTkt(String tcId){
      return [SELECT 
              //TKT_Profile Fields
                Age__c,Biography__c,Blogger__c,Blog_URL__c,Company_Description__c,Company_Logo__c,
                Company_Website_URL__c,DOB__c,Duns_Number__c,Email__c,Established_Date__c,FaceBookId__c,
                First_Name__c,FourSquareId__c,Gender__c,Home_Address__c,Home_Phone__c,Keywords__c,
                Last_Name__c,LinkedInId__c,Mobile__c,Number_Of_Employees__c,Prefix__c,Primary_Business_Category__c,
                Revenue__c,Secondary_Business_Category__c,Shipping_Address__c,Suffix__c,Tax_Id__c,
                TKT_Company__c,TKT_Job_Title__c,TwitterId__c,User_Pic__c,Video__c,Exceptional_Keywords__c,
                Work_Address__c,Work_Phone__c,
                //Home Address Fields
                Home_Address__r.Address1__c,Home_Address__r.Address2__c,Home_Address__r.City__c,
                Home_Address__r.Country__r.Long_Name__c,Home_Address__r.PoBox__c,Home_Address__r.State__r.Long_Name__c,Home_Address__r.ZipCode__c,
                //Work Address Fields
                Work_Address__r.Address1__c,Work_Address__r.Address2__c,Work_Address__r.City__c,
                Work_Address__r.Country__r.Long_Name__c,Work_Address__r.PoBox__c,Work_Address__r.State__r.Long_Name__c,Work_Address__r.ZipCode__c,
                //Shipping Address Fields
                Shipping_Address__r.Address1__c,Shipping_Address__r.Address2__c,Shipping_Address__r.City__c,
                Shipping_Address__r.Country__r.Long_Name__c,Shipping_Address__r.PoBox__c,Shipping_Address__r.State__r.Long_Name__c,Shipping_Address__r.ZipCode__c,
                //Billing Address Fields
                Billing_Address__r.Address1__c,Billing_Address__r.Address2__c,Billing_Address__r.City__c,
                Billing_Address__r.Country__r.Long_Name__c,Billing_Address__r.PoBox__c,Billing_Address__r.State__r.Long_Name__c,Billing_Address__r.ZipCode__c
                FROM 
                Tkt_profile__c 
                WHERE
                id=:tcId];
    }
    public List<TKT_profile__c> getTktpFormTkt(List<String> tcId){
      return [SELECT 
              //TKT_Profile Fields
                Age__c,Biography__c,Blogger__c,Blog_URL__c,Company_Description__c,Company_Logo__c,
                Company_Website_URL__c,DOB__c,Duns_Number__c,Email__c,Established_Date__c,FaceBookId__c,
                First_Name__c,FourSquareId__c,Gender__c,Home_Address__c,Home_Phone__c,Keywords__c,
                Last_Name__c,LinkedInId__c,Mobile__c,Number_Of_Employees__c,Prefix__c,Primary_Business_Category__c,
                Revenue__c,Secondary_Business_Category__c,Shipping_Address__c,Suffix__c,Tax_Id__c,
                TKT_Company__c,TKT_Job_Title__c,TwitterId__c,User_Pic__c,Video__c,Exceptional_Keywords__c,
                Work_Address__c,Work_Phone__c,
                //Home Address Fields
                Home_Address__r.Address1__c,Home_Address__r.Address2__c,Home_Address__r.City__c,
                Home_Address__r.Country__r.Long_Name__c,Home_Address__r.PoBox__c,Home_Address__r.State__r.Long_Name__c,Home_Address__r.ZipCode__c,
                //Work Address Fields
                Work_Address__r.Address1__c,Work_Address__r.Address2__c,Work_Address__r.City__c,
                Work_Address__r.Country__r.Long_Name__c,Work_Address__r.PoBox__c,Work_Address__r.State__r.Long_Name__c,Work_Address__r.ZipCode__c,
                //Shipping Address Fields
                Shipping_Address__r.Address1__c,Shipping_Address__r.Address2__c,Shipping_Address__r.City__c,
                Shipping_Address__r.Country__r.Long_Name__c,Shipping_Address__r.PoBox__c,Shipping_Address__r.State__r.Long_Name__c,Shipping_Address__r.ZipCode__c,
                //Billing Address Fields
                Billing_Address__r.Address1__c,Billing_Address__r.Address2__c,Billing_Address__r.City__c,
                Billing_Address__r.Country__r.Long_Name__c,Billing_Address__r.PoBox__c,Billing_Address__r.State__r.Long_Name__c,Billing_Address__r.ZipCode__c,
                //Child Records
                (SELECT Id,BLN_Commodities__c,BLN_Commodities__r.Name,BLN_Commodities__r.Description__c from BLN_Company_Commodities__r),
                (SELECT Id,Diversity__r.Name,Diversity__r.Order__c from BLN_Company_Diversity__r),
                (SELECT Id,BLN_NAICS_Code__r.Name,BLN_NAICS_Code__r.Description__c from BLN_Company_Naicscodes__r)
                FROM 
                Tkt_profile__c 
                WHERE
                id In :tcId];
    }
}