/**
* @author :Sai Kumar.D
* @date 07/04/2016
* @ This class is used for DML operations on App_Setting__c object
*/ 
public with sharing class BLN_App_Settings_DAO {

 // This method returns a string to know either to send email from PostMarkApp or Salesforce
    public String Sendemailfrom(){
    App_Setting__c appset = new App_Setting__c();
    appset = [select id,field_code__c,FromEmail__c from App_Setting__c where field_code__c = 'SendEmailFrom' ];
    String sendfromemailname =  appset.FromEmail__c;
    return sendfromemailname;
    }
  
}