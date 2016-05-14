public class profileDao{

public LIST<Profile_Settings__c> getSettings(string eventSelected,string type){
 LIST<Profile_Settings__c> Psettings = new LIST<Profile_Settings__c>();
             Psettings = [SELECT id,Business_Description__c,Company_Name__c,Title__c,Mobile__c,Email_Id__c,
             First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,MBE_Work_Address_Visibility__c,
             Work_Address__c,Work_phone__c,Additional_Company_Brouchers__c,Additional_Company_videos__c,BBB_Number__c,
             Business_Duns_Number__c,Business_Established_Date__c,Business_Revenue__c,Business_Tax_ID__c,Business_Type__c,Cage_Code__c,
             Certificate_Processed_by_RPO__c,Certifications__c,Commodities__c,Country__c,DBA__c,Distributors_Country__c,Geographical_Region__c,
             GSA_Schedule_Contract_Number__c,Job_Title__c,Manufatures_Country__c,Number_Of_Employees__c,Primary_Business_Category__c,Products_Services__c,
             References__c,Revenue_Range__c,Salutation__c,Secondary_Business_Category__c,Small_Business_IMAGE__c,State__c,Uploaded_Company_Brochures__c,Uploaded_Video__c,
             Website__c,Zip_Code__c,Company_Logo__c,MBE_Products_Services_Visible__c,MBE_LastName_Visible__c,MBE_Email_Visible__c,
             MBE_Job_Title_Visible__c,MBE_First_Name_Visible__c,MBE_Work_Phone_Visible__c,MBE_Procurement_Needs_Visible__c,MBE_Business_Description_Visible__c,
             MBE_NAICS_CODES_Visible__c,MBE_Small_Business_Image_Visible__c,MBE_Title_Visible__c,MBE_Mobile_Phone_Visible__c,
             MBE_Salutation_Visible__c,MBE_Company_Visible__c,MBE_DBA_Visible__c,MBE_Website_Visible__c,MBE_Address_1_Visible__c,MBE_Address_2_Visible__c,
             MBE_City_Visible__c,MBE_Country_Visible__c,MBE_Zip_Code_Visible__c,MBE_State_Visible__c,MBE_Additional_Company_Brouchers_Visible__c,
             MBE_Manufatures_Country_Visible__c,MBE_Distributors_Country_Visible__c,MBE_Uploaded_Company_Brochures_Visible__c,MBE_Company_Logo_Visible__c,
             MBE_Business_Duns_Number_Visible__c,MBE_Business_Established_Date_Visible__c,MBE_BBB_Number_Visible__c,MBE_Additional_Company_videos_Visible__c,
             MBE_Business_Revenue_Visible__c,MBE_Revenue_Range_Visible__c,MBE_Business_Tax_ID_Visible__c,MBE_Cage_Code_Visible__c,
             MBE_GSA_Schedule_Contract_Number_Visible__c,MBE_Number_Of_Employees_Visible__c,MBE_Primary_Business_Category_Visible__c,MBE_Certifications_Visible__c,
             MBE_Secondary_Business_Category_Visible__c,MBE_Certificate_Processed_by_RPO_Visible__c,MBE_Geographical_Region_Visible__c,MBE_References_Visible__c,
             MBE_Business_Type_Visible__c,MBE_Commodities_Visible__c,MBE_Uploaded_Video_Visible__c ,
             Year_in_Business__c,
             MBE_Year_in_Business_Visible__c,
             Business_Structure__c,
             Business_Structure_Visible__c,
             FaxNumber__c,
             FaxNumber_Visible__c,
             Ethnicity__c,
            MBE_Ethnicity_Visible__c,
            MBEAny_non_WBENC_awards_received_visible__c,
            MBECompanyhavefacility_partneroutsideUSA__c,
            Secondary_Email__c,
            MBE_Secondary_Email_Visible__c,
            Reference2__c,
            MBE_References2_Visible__c,
            Scope_of_Work__c,
            MBEScope_of_Work__c,
            MBEScope_of_Work2_Visible__c,
            Scope_of_Work2__c
             FROM Profile_Settings__c WHERE Event__r.id =: eventSelected AND Name=:type ];
        
     return Psettings;
}



}