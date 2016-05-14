@isTest
public class Test_KSK_EventSchedule {


    static testMethod void test_KSK_EventSchedule() {
      
      
      Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      
      EventSchedule__c es = new EventSchedule__c( EV_id__c=eve.Id, 
                                                  ES_StartTime__c='09:00 AM', 
                                                  ES_StartDate__c=Date.Parse('01/30/2015'), 
                                                  ES_ProgramName__c='test pro', 
                                                  ES_Presenter__c='Test', 
                                                  ES_Location__c='100', 
                                                  ES_EndTime__c='11:00 AM', 
                                                  ES_EndDate__c=Date.Parse('01/30/2015'), 
                                                  ES_Description__c='ttest desc');
      insert es;
      
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/KSK_EventSchedule';
       RestContext.request.addParameter('eveid', 'a00Z000000IzIjxIAF');
       
       KSK_EventSchedule.doPost();  
        
    }

}