public without sharing class MM_NEWMBESchedulecon {

    public EventSchedule__c shedule { get; set; }

public List<EventSchedule__c> listes {get;set;}
public MM_NEWMBESchedulecon(){

string selectedEvent =ApexPages.currentpage().getParameters().get('Eventid');
string sc=ApexPages.currentpage().getParameters().get('sc');
system.debug('****** '+sc);
shedule=new EventSchedule__c();
shedule=[select Id,Comments__c,
            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,
            Is_Matchmaking__c,
            MM_slot_StartTime__c,MM_Slot_End_Time__c,
            MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,
            MM_slot_Date__c,MM_To_UPE__r.BT_id__r.BT_Name__c,
            MM_To_EAM__r.AS_id__r.AS_Company__c ,
            
            
             MM_To_UPE__r.MM_TableNo__c,
             MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,
             MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
             MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,
             MM_To_UPE__r.Attendee_Summary__r.AS_lastName__c,
             MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,
             Owner.Name, 
             Owner.Email ,
             MM_To_UPE__r.Attendee_Summary__r.AS_Company__c ,
             MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,
             MM_To_UPE__r.BoothAdmin_id__r.Name,
             MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
             MM_To_UPE__r.BT_id__r.MM_TableNo__c,
             MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
             MM_Slot_Time__c,
             MM_Slot_EndTime__c, 
             MM_To_UPE__c,
             MM_To_UPE__r.User_id__r.userName,
             MM_To_EAM__r.AS_id__r.AS_Email__c,
             MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,
             MM_To_UPE__r.User_id__r.Name  from EventSchedule__c   where id =: sc];

        listes = new List<EventSchedule__c>();
        listes = [select Id,Comments__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
             MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,
                                   MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c, MM_To_UPE__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,
                                    MM_To_UPE__r.Attendee_Summary__r.AS_lastName__c,MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email ,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c ,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c
                          FROM  EventSchedule__c 
                          WHERE Is_Matchmaking__c = TRUE 
                          AND EV_id__c =: selectedEvent 
                          AND MM_To_UPE__r.Attendee_Summary__r.AS_Email__c =:shedule.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c
                          AND MM_Slot_Status__c = 'Accepted'
                          ORDER BY MM_slot_StartTime__c,MM_Slot_Status__c];
                          system.debug('22222222222222222 '+listes );
                          listes.add(shedule);
}





}