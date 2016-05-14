@isTest
public class Test_matchLeadsupdateTrigger{


static testMethod void Test_matchLeadsupdateTrigger() {
  Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event;
        AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'test1237777@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
     insert attendee;
      Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = attendee.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM;

  
}
}