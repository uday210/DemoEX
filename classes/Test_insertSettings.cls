@isTest
private class Test_insertSettings{
  static testMethod void Test_Infor(){

 Event__c eve = new Event__c(EV_Title__c='Global Event',Enable_Scan_To_ATT__c=true,EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',Session_Time__c='10',OrganizerId__c='phani@globalnest.com');
      insert eve;
      Id EventId=eve.Id;
      
      
      
      
   }
}