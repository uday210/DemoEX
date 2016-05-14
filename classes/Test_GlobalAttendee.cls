@isTest
public class Test_GlobalAttendee {

    public static testMethod void GlobalAttendee(){
    
     AttendeeSummary__c attforBa = new AttendeeSummary__c();
        attforBa.AS_FirstName__c='re';
        attforBa.AS_LastName__c ='lo';
        attforBa.AS_Email__c ='test123Ba@noemail.com';
        attforBa.AS_Company__c ='global';
        insert attforBa;  
     
    
    GlobalAttendee GA = new GlobalAttendee();
    GA.ReturnAttendee('test123Ba@noemail.com');
     GA.ReturnAttendee('');
    }
    
 }