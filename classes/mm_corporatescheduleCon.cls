public class mm_corporatescheduleCon {

    public EventSchedule__c selectedEventSchedule{get;set;}
    public LIST<EventSchedule__c> ConfirmedEventSchedule{get;set;}

    public mm_corporatescheduleCon(){
        
        string selectedEvent =ApexPages.currentpage().getParameters().get('Eventid');
        string justAddedId =ApexPages.currentpage().getParameters().get('NextId');
        String AttendeeId = ApexPages.currentpage().getParameters().get('AttendeeId'); 
        
        
        ConfirmedEventSchedule = new LIST<EventSchedule__c>();
        selectedEventSchedule = new EventSchedule__c ();
       // string sc=ApexPages.currentpage().getParameters().get('sc');
       
       system.debug('AAAAAAAAAAAAAA      BBBBBB   CCCCC   DDDDD  '+ selectedEvent+ ' ' +selectedEvent);
        system.debug('AAAAAAAAAAAAAA      BBBBBB   CCCCC   DDDDD  '+ selectedEvent+ ' ' +UserInfo.getUserId());
       
       
      // selectedEvent = 'a00Z000000GDPgS';
      // String ss= UserInfo.getUserId();
     // String ss = '005Z0000001JSIa';
       ConfirmedEventSchedule = [SELECT Id, Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__c,
                                    MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,
                                    MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c, MM_To_UPE__r.BoothAdmin_id__r.id,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BoothAdmin_id__r.Name,
                                    MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email,Comments__c FROM  EventSchedule__c WHERE Is_Matchmaking__c = TRUE AND EV_id__c =: selectedEvent AND  MM_To_EAM__c =: AttendeeId  AND MM_Slot_Status__c = 'Accepted' ];
       
       
       try{
           selectedEventSchedule = [SELECT Id,Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__c,
                                    MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,
                                    MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c, MM_To_UPE__r.BoothAdmin_id__r.id,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BoothAdmin_id__r.Name,
                                    MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email,Comments__c FROM  EventSchedule__c WHERE ID=: justAddedId ];
       }catch(Exception e){}
       
          
         
             ConfirmedEventSchedule.add(selectedEventSchedule);
       
        
          
    }




}