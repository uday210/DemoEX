@istest
private class Test_CustomizeTabsTrigger {
 static testMethod void testCustomizeTabsTrigger() {
 
 Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass');
        insert event;
 Tags__c tg1 = new Tags__c(Default_Name__c = 'Attendee',Alias_Name__c = 'Attendee Directory',Event__c = Event.id);
 insert tg1;
 Tags__c tg2 = new Tags__c(Default_Name__c = 'Exhibitor',Alias_Name__c = 'Exhibitor Directory',Event__c = Event.id);
 insert tg2;
}
}