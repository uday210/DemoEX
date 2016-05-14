trigger copyEventLevelFeeOptionToItems on BLN_Event__c (after update) {

BLN_Event__c eve=[select id,name,Event_Status__c,Service_Fee__c,Event_Ticket_Options__c from BLN_Event__c where id=:Trigger.newmap.keyset() limit 1];
if(Trigger.oldMap.get(eve.id).Service_Fee__c!= Trigger.newMap.get(eve.id).Service_Fee__c||Trigger.oldMap.get(eve.id).Event_Ticket_Options__c != Trigger.newMap.get(eve.id).Event_Ticket_Options__c){
List<BLN_Item__c> items=[select id,name,service_fee__c,Ticket_Settings__c,Event__c from BLN_Item__c where Event__c=:eve.id];

for(integer i=0;i<items.size();i++)
{
  if(Trigger.oldMap.get(eve.id).Service_Fee__c!= Trigger.newMap.get(eve.id).Service_Fee__c)
  items[i].service_fee__c =eve.Service_Fee__c ;
  if(Trigger.oldMap.get(eve.id).Event_Ticket_Options__c != Trigger.newMap.get(eve.id).Event_Ticket_Options__c)
  items[i].Ticket_Settings__c=eve.Event_Ticket_Options__c;
}

if(items.size()>0)
update items;

}

//For Invoice List
if(eve.Event_Status__c =='Completed'&&Trigger.oldMap.get(eve.id).Event_Status__c != Trigger.newMap.get(eve.id).Event_Status__c )
{
  Datetime executeTime = (System.now()).addMinutes(Integer.valueOf(BLN_Event__c.Invoice_Trigger_Duration__c.getDescribe().getDefaultValueFormula()));
String cronExpression = '' + executeTime .second() + ' ' + executeTime .minute() + ' ' + executeTime .hour() + ' ' + executeTime .day() + ' ' + executeTime .month() + ' ? ' + executeTime.year();
            
//System.debug('***Cron Expression: ' + cronExpression);
            
// Instantiate a new Scheduled Apex class
BLN_InvoiceSchedule scheduledJob = new BLN_InvoiceSchedule (eve.Id);
            
// Schedule our class to run at our given execute time, 
// naming executeTime so that the the Schedule name will be Unique  
System.schedule('ScheduledJob ' + executeTime.getTime(),cronExpression,scheduledJob);
}
//

}