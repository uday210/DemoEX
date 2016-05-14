@isTest
public class Test_KSK_EventSpeakers {


    static testMethod void test_KSK_EventSpeakers() {
       
     
       Seminar__c sem = new Seminar__c( Cost__c=Decimal.valueOf('100.00'), Date__c=Date.Parse('01/30/2015'), Description__c='Test desc', 
                                        End_Time__c='09:00 AM', Max_no_of_people__c=Decimal.valueOf('20'), Speaker__c='Test Speaker', 
                                        Start_Time__c='08:00 AM', Spk_DesigAndDept__c='Test dept', 
                                        Spk_SeminarRole__c='Mailrole', Spk_Company__c='glbl');
        insert sem;
        
        
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/KSK_EventSpeakers';
       RestContext.request.addParameter('eveid', 'a00Z000000IzIjxIAF');
       
       KSK_EventSpeakers.doPost();  
    }
    
}