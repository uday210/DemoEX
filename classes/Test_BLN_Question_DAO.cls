@istest
public class Test_BLN_Question_DAO{
    static testmethod void Testmethod_BLN_Question_DAO(){
    BLN_Question_DAO dd = new BLN_Question_DAO();
   Event_Pay_Gateway__c eww=new Event_Pay_Gateway__c();
   string eventID = eww.Events__c;
   dd.questionsForEvent(eventID);
    }
    }