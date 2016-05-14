public with sharing class MBEMassemailcon {

public Event_Attendee_Mapping__c eamdetails{get;set;}
public EVent__c eventtimedetails {get;set;}
public string attendeealias {get ; set ;}
public string exhibitoralias {get ; set ;}
public string SelectEvent{get;set;}
public List<EventSchedule__c> attendeeschedule{get;set;} 
 public list<Event_Breaks__c> blokslistexist {get ; set ;}

public MBEMassemailcon(){
      String eamid = Apexpages.currentPage().getParameters().get('id');
       System.debug('OOOOOOOOOOO '+eamid);
        eventtimedetails = new EVent__c(); 
        attendeeschedule = new List<EventSchedule__c>();
        
       eamdetails= new Event_Attendee_Mapping__c();
      if(eamid != null && eamid != ''){ 
       
      eamdetails=[SELECT ev_id__c,(select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                                  MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                  MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                  MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                               from EventSchedule__r
                           where MM_To_EAM__c =: eamid
                           AND MM_Slot_Status__c = 'Accepted'
                           AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                           AND MM_Slot_Status__c != null
                           AND MM_slot_StartTime__c != null
                           AND MM_slot_Date__c != null
                          
                   ORDER BY starttimein24hrs__c), AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c from Event_Attendee_Mapping__c where id=:eamId  limit 1];
                              
                         easlist =  eamdetails.EventSchedule__r ;    
                              
                              
                    eventtimedetails = new Event__c ();
                    SelectEvent = eamdetails.ev_id__c;
                    eventtimedetails =[SELECT ID,EV_EventLogo__c ,EV_HostingZipcode__c ,EV_HistingAddr1__c ,EV_HostingState__c,AS_HostingCity__c , EV_HostingLocation__c , MatchMaking_Type__c, EV_Title__c,Match_Making_Schedules__c,Email_Notifications_flag__c
                       FROM Event__c 
                       WHERE id =:SelectEvent  ];  
                       
         
       for(Tags__c tt: [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : SelectEvent]){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
        }  
       }         
     }                         
  }
  //---------------------------------------------------------------------
   //public list<innerschedule> innerschedule{get;set;}
        public boolean viewschedulepopup{get;set;}
        public list<EventSchedule__c> easlist{get;set;}
        public EventSchedule__c dummylist{get;set;}
        //public map<string, innerschedule> mapDummys= new map<string, innerschedule>();
        public LIST<MatchLeads_Days__c> allEventDates{get; set;}
       // public Event_Attendee_Mapping__c eamdetails{get;set;}
        public MAP<Date , LIST<String>> getDataFromUtility{get; set;}
        public LIST<SelectOption> eventDatesList{get; set;}
        public boolean ShowDatePicklist{get; set;}
        public String selectedEventDate{get; set;}
        public LIST<String> timeSlotsForDate{get; set;}
        public String eamid {get; set;}
        public List<SelectOption> statusOptions {get; set;}
        public List<String> selectedStatusList{get; set;}
        public integer statusSize{get; set;}
        public boolean CheckboxBool {get; set;}
        //public list<Event_Breaks__c> blokslistexist {get ; set ;}
        public void viewschedule(){
        try{
        viewschedulepopup = true;
        // norecordsalert = false;
        //innerschedule = new list<innerschedule>();
        eventDatesList= new LIST<Selectoption>();
         statusOptions= new List<SelectOption>();
            this.selectedStatusList= new List<String>();
         //eamid = Apexpages.currentpage().getparameters().get('MMattendee');

        /* START CODE FOR ADDING DATE PICKLIST */
         allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: SelectEvent  ORDER BY MatchLeads_Date__c ASC]);
          if(allEventDates.size() >1){
             ShowDatePicklist= true;
             for(MatchLeads_Days__c matchDate: allEventDates){

                 //String eventDate= String.valueOf(matchDate.MatchLeads_Date__c) ;
                 String dateFormat= matchDate.MatchLeads_Date__c.format();

                 eventDatesList.add(new selectoption(dateFormat,dateFormat));

                  }

             }

           selectedEventDate= allEventDates[0].MatchLeads_Date__c.format();

         //Status Picklist Code Starts
            selectedStatusList.add('Accepted');

            Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
            List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
            statusOptions.add(new SelectOption('All','All'));
            statusSize= AllValues.size();
            system.debug(' PICK LIST SIZE '+statusSize);
            for(Schema.PicklistEntry str: AllValues){
                statusOptions.add(new SelectOption(Str.getValue(), Str.getValue()));
            }

            statusOptions.add(new SelectOption('Open','Open'));

            schedulesForEvent();
         }catch(exception e){}

      }

      public SET<String> selectedStatusSET{get; set;}

      public pagereference schedulesOnStatus(){

            easlist = new list<EventSchedule__c>();
            selectedStatusSET= new SET<String>();
            selectedStatusSET.addAll(selectedStatusList);

            try{
                if(selectedEventDate != null || selectedEventDate != '') {

                    LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                    Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));

                    if(selectedStatusSET.contains('All')){

                        system.debug('       eamid      '+eamid+'    '+selectedEventDate );
                        CheckboxBool = true;

                     eamdetails = new Event_Attendee_Mapping__c();
             easlist = [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                          MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                          MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                          MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                       from EventSchedule__c
                   where MM_To_EAM__c =: eamid
                   AND MM_Slot_Status__c = 'Accepted'
                   AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                   AND MM_Slot_Status__c != null
                   AND MM_slot_StartTime__c != null
                   AND MM_slot_Date__c != null
                   AND MM_slot_Date__c =: selectedDate
                   ORDER BY starttimein24hrs__c];
                               system.debug('   SCHUDULE LIST SIZE    '+easlist.size()+'    '+easlist );

         Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
            List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
            system.debug(' PICK LIST SIZE '+statusSize);
            for(Schema.PicklistEntry str: AllValues){
                selectedStatusList.add(Str.getValue());
            }

          }else if(selectedStatusSet.contains('Open')){
                        // && selectedStatusSet.size() ==1
                        CheckboxBool = false;
                        selectedStatusList = new LIST<String>();
                        selectedStatusList.add('Open');

                        system.debug('Open Appointments  '+openSlotsList.size()+'    '+openSlotsList);
                    }else{
           if(! selectedStatusSet.contains('All') && selectedStatusList.size() == statusSize){
            selectedStatusList= new List<String>();
            }else{
                                CheckboxBool = true;

          eamdetails = new Event_Attendee_Mapping__c();
             easlist = [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                          MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                          MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                          MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                       from EventSchedule__c
                   where MM_To_EAM__c =: eamid
                   AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                   AND MM_Slot_Status__c = 'Accepted'
                   AND (MM_Slot_Status__c != null AND MM_Slot_Status__c IN : selectedStatusList)
                   AND MM_slot_StartTime__c != null
                   AND MM_slot_Date__c != null
                   AND MM_slot_Date__c =: selectedDate
                    ORDER BY starttimein24hrs__c];

          }
          }
          }
         eamdetails=[select AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c from Event_Attendee_Mapping__c where id =: eamid ];
          if(easlist.size() != 0){
           dummylist = easlist[0];
          // norecordsalert = true;
          }
     }catch(exception e){}
          return null;
      }

        public LIST<EventSchedule__c> schedulesList{get; set;}
        public SET<String> openSlotsList{get; set;}
        public LIST<String> startTimeList{get; set;}

        public pagereference schedulesForEvent(){
          system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
            getDataFromUtility= new MAP<Date , LIST<String>>();
            timeSlotsForDate= new LIST<String>();
            openSlotsList= new SET<String>();

            try{
            system.debug('  EVENT DATE SELECTED  '+selectedEventDate );
                if(selectedEventDate != null || selectedEventDate != ''){

                system.debug('       eamid      '+eamid);
               //Date selectedDate= date.valueOf(selectedEventDate);
               LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
               Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));

               getDataFromUtility= MM_Utility.giveEventTimingsWithDates(SelectEvent, selectedDate);

             timeSlotsForDate= getDataFromUtility.get(selectedDate);

             eamdetails = new Event_Attendee_Mapping__c();
             schedulesList= [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                          MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                          MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                          MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                       from EventSchedule__c
                   where MM_To_EAM__c =: eamid
                   AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                   AND (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')
                   AND MM_slot_StartTime__c != null
                   AND MM_slot_Date__c != null
                   AND MM_slot_Date__c =: selectedDate
                    ORDER BY starttimein24hrs__c];
                system.debug('  SCH LIST   '+schedulesList);
                system.debug('  SLOT LIST  '+timeSlotsForDate);

          //timeSlotsForDate.sort();
          slotsInner= new LIST<timeSlotInnerClass> ();
          startTimeList= new LIST<String>();
          openSlotsList.addAll(timeSlotsForDate);
                      system.debug('  SLOT SET '+openSlotsList.size()+'    '+openSlotsList);
          SET<String> slotsList= new SET<String>();
          for(String timeSlot: timeSlotsForDate){
                LIST<String> slotStartTime= new LIST<String>(timeSlot.split(':'));
              system.debug(' SLOT START TIME  '+slotStartTime[0]+'    '+slotStartTime);

              if(! slotsList.contains(slotStartTime[0])){
                        system.debug('IF  SLOT START TIME  '+slotStartTime[0]+'    '+slotsList);
                  slotsList.add(slotStartTime[0]);
                  startTimeList.add(slotStartTime[0]);
                  system.debug(' ELSE SLOT START TIME  '+slotStartTime[0]+'    '+slotsList);
              }

              for(EventSchedule__c esch: schedulesList){
                  string scheduleSlot= esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c;
                  if(scheduleSlot == timeSlot && (esch.MM_Slot_Status__c == 'Accepted' || esch.MM_Slot_Status__c == 'Pending')){

                      openSlotsList.remove(timeslot);
                  }
              }
              blokslistexist = new list<Event_Breaks__c> ();
           blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__c =: eamid ];
           for(Event_Breaks__c  berk: blokslistexist  ){
           string scheduleSlot= berk.Break_Start_Time__c+'-'+berk.Break_End_Time__c;
            if(scheduleSlot == timeSlot){
            openSlotsList.remove(timeslot);
              }

           }
          }
          system.debug(' AFTER SLOT SET '+openSlotsList.size()+'    '+openSlotsList);
           for(String slotInt: startTimeList){

              system.debug('FOR SLOT START TIME '+slotInt);
              LIST<String> slotsListForStartTime= new LIST<String>();
              for(String slotStr: openSlotsList){

                  LIST<String> slotStartTimeStr= new LIST<String>(slotStr.split(':'));
                  system.debug('INNER FOR SLOT START TIME  '+slotStartTimeStr[0]+'    '+slotStartTimeStr);

                  if(slotInt == slotStartTimeStr[0]){

                      slotsListForStartTime.add(slotStr);
                  }

              }
              slotsListForStartTime.sort();
               slotsInner.add(new timeSlotInnerClass(slotInt, slotsListForStartTime));
          }
          system.debug(' SLOTS LIST FOR TIME  '+slotsInner.size()+'    '+slotsInner);
          schedulesOnStatus();
          }
     }catch(exception e){}

          return null;
      }
       public LIST<timeSlotInnerClass> slotsInner{get; set;}
      public class timeSlotInnerClass{

          public String slotStartTime{get; set;}
          public LIST<String> slotsForTime{get; set;}

          public timeSlotInnerClass(String sTime, LIST<String> sForTime){

              slotsForTime= new LIST<String>();

              slotStartTime= sTime;
              slotsForTime= sForTime;
          }

      }
    /**
      public class innerschedule{
      public list<EventSchedule__c> lislots {get;set;}
            public string slot{get;set;}

            public innerschedule(EventSchedule__c comp)
            {
                slot= string.valueOf(comp.MM_slot_Date__c);
                lislots = new list<EventSchedule__c>{comp};

      }
      }
      */

      public pagereference printschedule(){
       eventDetailsInPrint();
      pagereference pg=page.mm_eventadmin_printattendeeschedule;
      return pg;
      }

      public String eventDatesString {get; set;}
      public Event__c eventDetails{get;set;}

      public void eventDetailsInPrint(){

            eventDetails= new Event__c();
               system.debug('EVENT ID  '+SelectEvent);

            if(SelectEvent != null || SelectEvent != ''){
                eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, EV_EventLogo__c,
                              EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,Match_Making_Schedules__c
                              FROM Event__c
                              WHERE ID =: SelectEvent];
            system.debug('EVENT DATES STRING  '+eventDetails);

            if(eventDetails.EV_StartDate__c == eventDetails.EV_EndDate__c){
                eventDatesString = string.valueof(eventDetails.EV_StartDate__c);
            } else if(eventDetails.EV_StartDate__c != eventDetails.EV_EndDate__c){
                eventDatesString = string.valueof(eventDetails.EV_StartDate__c)+' TO '+string.valueof(eventDetails.EV_EndDate__c);
            }
            }


        }
  
  
  
  
  

}