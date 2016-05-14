public with sharing class BLN_Currency_DAO {

   /***********************************************************************************************
    *   Controller Name         : BLN_Currency_DAO
    *   Date                    : 07/06/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for Retrieving Currency details.
    **************************************************************************************************/




     
    public Currency__c getCurrencyDetails(String fields,String Condition)
    {
       Currency__c currencydetails = new Currency__c();
       
        RETURN currencydetails =database.query('SELECT '+fields+' FROM Currency__c WHERE '+condition);
        
    }

}