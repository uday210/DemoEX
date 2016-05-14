@isTest
public with sharing class Test_AS_SendEmail{
    static testMethod void Test_AS_SendEmail(){
        System.RestContext.request = new RestRequest();
        RestContext.request.addParameter('Sender_EmailID', 'mahesh@globalnest.com');
        RestContext.request.addParameter('Recipients_EmailID', 'mahesh23390@gmail.com');
        AS_SendEmail.doGet(); 
    }
}