/***********************************************************************************************
*   Controller Name : BLN_Question_DAO
*   Date            : 01/12/2015
*   Author          : Manasa Gandham
*   Purpose         : This class is to get the list of Survey Questions
*   Change History  : 01/12/2015
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*    01/12/2015             Manasa Gandham                 To Create Page
*  
**************************************************************************************************/

public without sharing class BLN_Question_DAO{

    // To get the list of questions belongs to a particular Event
    public LIST<Question__c> questionsForEvent(String eventId){
        LIST<Question__c> questionsList= new LIST<Question__c>();
        questionsList= [SELECT Id, Answer_Type__c, Event__c, Question_Order__c, Question_Text__c, 
                        (SELECT Id, Answer_Default__c, Answer_Text__c FROM BLN_Answers__r) 
                        FROM Question__c 
                        WHERE Event__c =: eventId];
        // (SELECT Id FROM User_Answers__r) 
        return questionsList;
    }
}