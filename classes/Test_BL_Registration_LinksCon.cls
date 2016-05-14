@isTest
public class Test_BL_Registration_LinksCon{

 static testMethod void testRest(){
    Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
       Attendee_Types__c ='Attendee;Exhibitor;Sponsor;Exhibitor Staff',
       EV_EndDate__c = Date.Parse('01/18/2014'),
       EV_StartDate__c = Date.Parse('01/18/2014'),
       EV_EndTime__c='09:00 AM',
       StartTime__c='11:00 AM');
       insert eve;
      BL_Registration_LinksCon reg = new BL_Registration_LinksCon(); 
     
 }
 }