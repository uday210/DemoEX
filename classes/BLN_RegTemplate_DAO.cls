public with sharing class BLN_RegTemplate_DAO{
/**********************************************************************************************************************************************************************************************
*   Author                  : Mahesh Sakunala
*   Date                    : 03/06/2014 
*   Purpose                 : This class is for all DML and SQl operations on registration template object
*************************************************************************************************************************************************************************************************/


    // This method is for getting Registration Template Details by giving registration template id as parameter
    public Registration_Template__c getRegTempDetails(String RegTemplateId){
        Registration_Template__c  RegTempDetails = [SELECT Name,Order__c,Template_Image_URL__c,Styles__c,Header_Image_URL__c 
                                                    FROM Registration_Template__c 
                                                    WHERE ID =: RegTemplateId];
        return RegTempDetails;
    }


}