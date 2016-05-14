@isTest
public class Test_KSK_EventDetails {


    static testMethod void test_KSK_EventDetails() {
    
      Profile w1 = [select id from profile where name='System Administrator'];
    
    User u = new User(alias = 'test1234', email='test1234@noemail.com',
                 emailencodingkey='UTF-8',profileid = w1.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',password__c='cpkn1234',
                  timezonesidkey='America/Los_Angeles', username='global123@noemail.com');
                  insert u;
    
       Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      
      Floor_Map__c fm = new Floor_Map__c(Name='KSK-001', 
                                      Parameters__c='{"type":"circle","params":{"x":500.5,"y":67.5,"radius":{"x":15.5,"y":13.5}}}', 
                                      Type__c='Kiosk', Booth_Area__c='20');
      insert fm;
      
     Profile__c customProfileBooth= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
     insert  customProfileBooth;
      
     User_Profile_Event__c upebu1 = new User_Profile_Event__c(EV_id__c=eve.Id,Profile_id__c=customProfileBooth.Id,Status__c='Active',User_id__c=u.Id,UEP_isActive__c=true);         
     insert upebu1; 
     
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
      
      Seminar__c sem = new Seminar__c( Cost__c=Decimal.valueOf('100.00'), Date__c=Date.Parse('01/30/2015'), Description__c='Test desc', 
                                        End_Time__c='09:00 AM', Max_no_of_people__c=Decimal.valueOf('20'), Speaker__c='Test Speaker', 
                                        Start_Time__c='08:00 AM', Spk_DesigAndDept__c='Test dept', 
                                        Spk_SeminarRole__c='Mailrole', Spk_Company__c='glbl');
     insert sem;
     
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/KSK_EventDetails';
       RestContext.request.addParameter('eveid', 'a00Z000000IzIjxIAF');
       
       KSK_EventDetails.doPost();  
   
    }
    
}