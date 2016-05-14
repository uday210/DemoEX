@isTest
public with sharing class Test_AS_SendImportEmail{
    static testMethod void Test_AS_SendImportEmail(){
        System.RestContext.request = new RestRequest();
        RestContext.request.addParameter('Recipients_EmailID', 'mahesh@globalnest.com');
        RestContext.request.addParameter('TotalRecords', '50');
        RestContext.request.addParameter('TotalFailedRecords', '5');
        RestContext.request.addParameter('TotalSuccessRecords', '45');
        RestContext.request.addParameter('CSVName', 'Fail.csv');
        
        AS_SendImportEmail.doPost(); 
    }
}