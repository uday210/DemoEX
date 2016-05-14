public with sharing class mm_eventadmin_printscheduleMassCon {
  public User_Profile_Event__c upedetails{get;set;}
  public EVent__c eventtimedetails {get;set;}
  
    public string attendeealias {get ; set ;}
    public string exhibitoralias {get ; set ;}
    public string SelectEvent{get;set;}
    public List<EventSchedule__c> exhibitorschedule{get;set;} 
    
  public mm_eventadmin_printscheduleMassCon(){
      String upeId = Apexpages.currentPage().getParameters().get('id');
       System.debug('OOOOOOOOOOO '+upeId);
        eventtimedetails = new EVent__c(); 
        exhibitorschedule = new List<EventSchedule__c>();
        
       upedetails = new User_Profile_Event__c();
      if(upeId != null && upeId != ''){ 
       
      upedetails=[SELECT ev_id__c,(SELECT Id ,EV_id__c ,EV_id__r.id,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                               MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,
                                               MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_EAM__r.Ev_Id__r.Is_Webank_event__c  
                                        FROM EventSchedule__r 
                                        WHERE MM_To_UPE__r.IsMatchMakingUser__c =: TRUE  AND MM_To_EAM__c != null AND MM_Slot_Status__c = 'Accepted'
                                        AND MM_Slot_Status__c != null
                                         ORDER BY starttimein24hrs__c),Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Company__c,
                                     Attendee_Summary__r.AS_CellPhone__c,Attendee_Summary__r.AS_Email__c,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Name,
                                     BT_id__r.MM_TableNo__c,BT_id__r.BT_Name__c,BT_id__r.BT_Location__c,Attendee_Summary__r.AS_ImageUrl__c,Attendee_Summary__r.Exhibitor_company_imageUrl__c 
                              FROM User_Profile_Event__c where id=:upeId  limit 1];
                              
                         exhibitorschedule =  upedetails.EventSchedule__r ;    
                              
                              
                    eventtimedetails = new Event__c ();
                    SelectEvent = upedetails.ev_id__c;
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
  
  
  public list<Event_Breaks__c> blokslistexist {get ; set ;}
  public boolean viewschedulepopup{get;set;}
  public boolean viewStatusPopup{get;set;}
  //public Event__c eventtimedetails{get;set;}
 
 // public List<EventSchedule__c> exhibitorschedule {get;set;}
 
  
  public boolean slot{get;set;}
  public Time startTimeMM{get;set;}
    public Time ENdTimeMM{get;set;}
    public string selecteddate{get;set;}
    public string Errormessagesch{get;set;}
    public boolean errorbool{get;set;}
    
    public EventSchedule__c dummylist{get;set;}
    
   public string BoothAdminDetails{get;set;}
 // public User_Profile_Event__c upedetails{get;set;}
  public List<SelectOption> statusOptions {get; set;}
  public List<String> selectedStatusList{get; set;}
  public integer statusSize{get; set;}
  public MAP<Date , LIST<String>> getDataFromUtility{get; set;}
  public LIST<SelectOption> eventDatesList{get; set;}
  public boolean ShowDatePicklist{get; set;}
  public String selectedEventDate{get; set;}
  public LIST<String> timeSlotsForDate{get; set;}
  public LIST<MatchLeads_Days__c> allEventDates{get; set;}
    
  public Pagereference statusValueSchedule(){
      
        
        statusOptions= new List<SelectOption>();
        this.selectedStatusList= new List<String>();
        eventDatesList= new LIST<Selectoption>();
        selectedStatusList.add('Accepted');
        
        
        //Time slote code starts here
        /* START CODE FOR ADDING DATE PICKLIST */
     allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: SelectEvent ORDER BY MatchLeads_Date__c ASC]);
      if(allEventDates.size() >1){
         ShowDatePicklist= true;
         for(MatchLeads_Days__c matchDate: allEventDates){
             
             String dateFormat= matchDate.MatchLeads_Date__c.format();
             eventDatesList.add(new selectoption(dateFormat,dateFormat));
             
              }
         
         }
            selectedEventDate= allEventDates[0].MatchLeads_Date__c.format();

        //Status Picklisycode starts here
        Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
        List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
        statusOptions.add(new SelectOption('All','All'));
        statusSize= AllValues.size();
        system.debug(' PICK LIST SIZE '+statusSize);
        for(Schema.PicklistEntry str: AllValues){
            statusOptions.add(new SelectOption(Str.getValue(), Str.getValue()));
        } 
        statusOptions.add(new SelectOption('Open','Open'));
        
        splitTimeSlots();
        
      return null;
  }
  
  
  
  public SET<String> openSlotsList{get; set;}
    public SET<String> openSlotsList1{get; set;}
    public LIST<EventSchedule__c> schedulesList{get; set;}
    public LIST<String> startTimeList{get; set;}

public pagereference splitTimeSlots(){
      try{
      //showExccededError = False;
      getDataFromUtility= new MAP<Date , LIST<String>>();
        timeSlotsForDate= new LIST<String>();
        openSlotsList= new SET<String>();
        schedulesList= new LIST<EventSchedule__c>();
        system.debug('  EVENT DATE SELECTED  '+selectedEventDate );
        slotsInner= new LIST<timeSlotInnerClass> ();
        startTimeList= new LIST<String>();
            if(selectedEventDate != null || selectedEventDate != ''){
         system.debug(BoothAdminDetails +'   tttttttttttttttttttttttttttttttttttttttttttttttt'+selectedEventDate );
                LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                
                Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
           getDataFromUtility= MM_Utility.giveEventTimingsWithDates(SelectEvent, selectedDate);
         
         timeSlotsForDate= getDataFromUtility.get(selectedDate);
    
         schedulesList= [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                      MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c, 
                      MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                      MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                   from EventSchedule__c 
               where (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')
               AND MM_slot_StartTime__c != null 
               AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
               AND MM_To_UPE__c =: BoothAdminDetails 
               AND MM_slot_Date__c != null  
               AND MM_slot_Date__c =: selectedDate  
               AND EV_id__c =: SelectEvent]; 
               //ORDER BY MM_slot_StartTime__c];
            system.debug('  SCH LIST   '+schedulesList);
            system.debug('  SLOT LIST  '+timeSlotsForDate);

      //timeSlotsForDate.sort();


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
                      system.debug(' START TIME  LIST '+slotStartTime[0]+'    '+startTimeList);                        
          }
          for(EventSchedule__c esch: schedulesList){
              string scheduleSlot= esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c;
              system.debug(' SLOT TIME '+scheduleSlot+'   '+timeSlot +'   '+esch.MM_Slot_Status__c);
              if(scheduleSlot == timeSlot && (esch.MM_Slot_Status__c == 'Accepted' || esch.MM_Slot_Status__c == 'Pending')){
                  
                  openSlotsList.remove(timeslot);
              }
          }
           blokslistexist = new list<Event_Breaks__c> ();
           blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: BoothAdminDetails];
           for(Event_Breaks__c  berk: blokslistexist  ){
           string scheduleSlot= berk.Break_Start_Time__c+'-'+berk.Break_End_Time__c;
            if(scheduleSlot == timeSlot){
            openSlotsList.remove(timeslot);
              }
           
           }
      }
      system.debug(' AFTER SLOT SET '+openSlotsList.size()+'    '+slotsList.size() +'  '+openSlotsList+'  '+slotsList);
            
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
      }


      forSchedule();}catch(exception e){}
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

public SET<String> selectedStatusSet{get; set;}
  
  public pagereference forSchedule(){
       // showExccededError = False;
        system.debug('   Hello for Test   '+selectedStatusList);
        selectedStatusSet= new SET<String>();
        selectedStatusSet.addAll(selectedStatusList);
        system.debug(' SET  Hello for Test   '+selectedStatusSet);
        
        try{
           // norecordsalert = false;
            viewschedulepopup=true;
            slot=true;
            //DISP=new list<InnerForTimeslots>();
            
            
            exhibitorschedule = new List<EventSchedule__c>();
            
            system.debug('             schedule          '+BoothAdminDetails);
            if(selectedEventDate != null || selectedEventDate != ''){
            LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
                
                if(selectedStatusSet.contains('All')){
                    //CheckboxBool = true;
                   // CheckboxBool1 = false;
                    exhibitorschedule =[SELECT Id ,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                               MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,
                                               MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_EAM__r.Ev_Id__r.Is_Webank_event__c  
                                        FROM EventSchedule__c 
                                        WHERE MM_To_UPE__c =: BoothAdminDetails 
                                        AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                        AND MM_To_EAM__c != null 
                                        AND MM_slot_Date__c =: selectedDate  
                                        AND MM_Slot_Status__c != null
                                        AND EV_id__c =: SelectEvent 
                                        ORDER BY starttimein24hrs__c];
                    system.debug(' IF STATUS LIST QUERY  '+exhibitorschedule.size()+'    '+exhibitorschedule );
                    Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
                    List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
                    
                    for(Schema.PicklistEntry str: AllValues){
                        selectedStatusList.add(Str.getValue());
                    } 
                }
                else if(selectedStatusSet.contains('Open')){
                    // && selectedStatusSet.size() ==1
                    //CheckboxBool = false;
                    selectedStatusList = new LIST<String>();
                    selectedStatusList.add('Open');
                 
                    system.debug('Open Appointments  '+openSlotsList.size()+'    '+openSlotsList);
                }
                else{
                   // CheckboxBool = true;
                    //CheckboxBool1 = false;
                    //selectedStatusSet.remove('Open');
                    system.debug('SET VALUES  '+selectedStatusSet);
                    if(!selectedStatusSet.contains('All') && selectedStatusList.size() == statusSize){
                        selectedStatusList= new List<String>();
                    }
                    else{
                    
                        system.debug('SET VALUES  '+selectedStatusSet);
                        
                        exhibitorschedule =[SELECT Id,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                                   MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                                   MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_EAM__r.Ev_Id__r.Is_Webank_event__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c 
                                            FROM EventSchedule__c 
                                            WHERE MM_To_UPE__c =: BoothAdminDetails
                                            AND MM_Slot_Status__c = 'Accepted'
                                            AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                            AND MM_To_EAM__c != null 
                                            AND MM_Slot_Status__c IN : selectedStatusSet
                                            AND MM_slot_Date__c =: selectedDate  
                                            ORDER BY starttimein24hrs__c];
                        
                        system.debug(' ELSE  STATUS LIST QUERY  '+exhibitorschedule.size()+'    '+exhibitorschedule );
                        selectedStatusSet.remove('All');
                        selectedStatusList.addAll(selectedStatusSet);
                    }     
                
                }                         
                upedetails = [SELECT Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Company__c,
                                     Attendee_Summary__r.AS_CellPhone__c,Attendee_Summary__r.AS_Email__c,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Name,
                                     BT_id__r.MM_TableNo__c,BT_id__r.BT_Name__c,BT_id__r.BT_Location__c,Attendee_Summary__r.AS_ImageUrl__c,Attendee_Summary__r.Exhibitor_company_imageUrl__c 
                              FROM User_Profile_Event__c 
                              WHERE id =:BoothAdminDetails];
                              system.debug('uuuuuuuuuu'+upedetails);
                           
                if(exhibitorschedule.size() != 0){
                    dummylist = exhibitorschedule[0];
                   // norecordsalert = true;
                }
            }
        }catch(exception e){}
        
        return null;
  }
  

 
}