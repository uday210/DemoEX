@isTest
public class Test_KSK_EventExhibitors {


static testMethod void test_KSK_EventExhibitors() {

    Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
    insert eve;
    
    

    Booth__c b = new Booth__c(BT_Name__c='Both1',BT_Description__c='test',BT_ContactName__c='BoothAdmin',BT_ContactEmail__c='admin@boothleads.com',
    BT_ContactPhone__c='9898989898',BT_WebsiteURL__c='www.boothleads.com', BT_Location__c='100', BT_PDFLocation__c='',
    BT_RegistrationLink__c='www.test.com',BT_Phone__c='9898989898');
    insert b;
           
            
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/KSK_EventExhibitors';
       RestContext.request.addParameter('eveid', 'a00Z000000IzIjxIAF');
       
       KSK_EventExhibitors.doPost();
}

}