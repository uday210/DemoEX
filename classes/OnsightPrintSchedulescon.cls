public with sharing class OnsightPrintSchedulescon {
Public string Emailid {get ; set ;}
public Event_Attendee_Mapping__c eamdetails {get ; set ;}
//public EventSchedule__c easlist {get ; set ;}
public List<EventSchedule__c> easlist {get ; set ;}
public List<User_Profile_Event__c> upeid {get ; set ;}
public string Eventid {get ; set ;}
public string typename {get ; set ;}
public string attendeealias {get ; set ;}
public string exhibitoralias {get ; set ;}
public List<selectoption> emailids {get ; set ;} 
public List<selectoption> emailids1 {get ; set ;} 
public List<string> Listofemails {get ; set ;}      
public Event__c attach {get ; set ;}
public MAP<Date , LIST<String>> getDataFromUtility{get; set;}
//__________________________CONSTRUCTOR-------------------------

public OnsightPrintSchedulescon (){
    try{
    Eventid = Apexpages.Currentpage().getparameters().get('eventid');
    List<Event_Attendee_Mapping__c> eams = new List<Event_Attendee_Mapping__c>();
    emailids = new List<selectoption>();
    emailids1 = new List<selectoption>();
    Listofemails = new List<string>();
    system.debug('                               '+eams+'           '+eams.size());
    easlist = new List<EventSchedule__c>();
    eams = [select id,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c where EV_id__c =: Eventid AND IsMatchMakingAttendee__c =: true];
    for(Event_Attendee_Mapping__c evm: eams){
    emailids1.add(new selectoption(evm.AS_id__r.AS_Email__c,evm.AS_id__r.AS_Email__c));
    }
    easlist = [select id,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c 
                          from EventSchedule__c
                   where EV_id__c =: Eventid 
                   AND MM_Slot_Status__c != null
                   AND MM_slot_StartTime__c != null
                   ];
     SET<string> ss = new SET<string>();
     
    for(EventSchedule__c em: easlist ){
    string E1 = em.MM_To_EAM__r.AS_id__r.AS_Email__c;
    String E2= em.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c;
        If(ss.add(E1)){
        Listofemails.add(E1);
        emailids.add(new selectoption(E1,E1));}
        if(ss.add(E2)){
        Listofemails.add(E2);
        emailids.add(new selectoption(E2,E2));}
    }
    }catch(exception e){}
    }
//----------------END OF CONSTRUCTOR---------------


//---------------------------------------------------Open Slots MEthod---------------------------------
public LIST<String> timeSlotsForDate {get ; set ;}
public SET<String> openSlotsList {get ; set ;}
public void Openslots(string SelectEvent,date selectedDate,List<EventSchedule__c> schedulesList){

    timeSlotsForDate= new LIST<String>();
    openSlotsList= new SET<String>();
    getDataFromUtility= new MAP<Date , LIST<String>>();
    getDataFromUtility= MM_Utility.giveEventTimingsWithDates(SelectEvent, selectedDate);
    timeSlotsForDate= getDataFromUtility.get(selectedDate);
    openSlotsList.addall(timeSlotsForDate);
    system.debug('  SLOT SET '+openSlotsList.size()+'    '+openSlotsList);
      SET<String> slotsList= new SET<String>();
      
      for(String timeSlot: timeSlotsForDate){
          
          LIST<String> slotStartTime= new LIST<String>(timeSlot.split(':'));
          system.debug(' SLOT START TIME  '+slotStartTime[0]+'    '+slotStartTime);
          
         
          for(EventSchedule__c esch: schedulesList){
              string scheduleSlot= esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c;
              system.debug(' SLOT TIME '+scheduleSlot+'   '+timeSlot +'   '+esch.MM_Slot_Status__c);
              if(scheduleSlot == timeSlot && (esch.MM_Slot_Status__c == 'Accepted' || esch.MM_Slot_Status__c == 'Pending')){
                  
                  openSlotsList.remove(timeslot);
              }
          }
          
      }

}
//--------------------------------------------------------END OF TIMESLOTS------------------------------------
public pagereference GO(){
        eamdetails = new Event_Attendee_Mapping__c();
        attach = [select EV_EventLogo__c,EV_HostingLocation__c,EV_HistingAddr1__c,AS_HostingCity__c,EV_HostingState__c,EV_HostingZipcode__c,MatchMaking_Type__c, EV_Title__c,Is_Webank_event__c from Event__c where id = : Eventid ];
        List<Tags__c> tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : Eventid ];
           for(Tags__c tt: tagslist ){
           if(tt.Default_Name__c == 'Attendee'){
           attendeealias = tt.Alias_Name__c;
           }else if(tt.Default_Name__c == 'Exhibitor'){
           exhibitoralias = tt.Alias_Name__c;
           }

           }
        eamdetails = [select id,AS_id__r.AS_ImageUrl__c,AS_id__r.Exhibitor_company_imageUrl__c,AS_id__r.AS_Company__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_CellPhone__c from Event_Attendee_Mapping__c Where EV_id__c =: Eventid AND  AS_id__r.AS_Email__c =: Emailid];
        upeid = new List<User_Profile_Event__c>();
        upeid = [select id from User_Profile_Event__c where EV_id__c =: Eventid AND     Attendee_Summary__r.AS_Email__c =: Emailid];
        easlist =  [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                    MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                    MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                    MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                    from EventSchedule__c
                    where MM_To_EAM__c =: eamdetails.id
                    AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                    AND MM_Slot_Status__c != null
                    AND MM_slot_StartTime__c != null
                    AND MM_slot_Date__c != null];
                    
                 if(easlist.size() == 0 && upeid.size() != 0){
                     easlist = [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                                MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                                from EventSchedule__c
                                where MM_To_UPE__c  =: upeid[0].id
                                AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                AND MM_Slot_Status__c != null
                                AND MM_slot_StartTime__c != null
                                AND MM_slot_Date__c != null];
                          Openslots(Eventid,easlist[0].MM_slot_Date__c,easlist );      
                       pagereference pg1 = page.MM_OnsightPrintSchedulespdfcorp;
                       return pg1;
                  
                 }else{
                     Openslots(Eventid,easlist[0].MM_slot_Date__c,easlist );
                      pagereference pg = page.MM_OnsightPrintSchedulespdf;
                      return pg;
                    
                 }
                 
                   
          return null;        

    }

}