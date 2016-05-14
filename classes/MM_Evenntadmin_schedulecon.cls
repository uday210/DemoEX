public without sharing class MM_Evenntadmin_schedulecon{
 

 // Code Using JAVASCRIPT To Overcome from 1000 Picklist Limitation
 
  
  public LIST<LIST<Event_Attendee_Mapping__c>> listOfMBEsForEvent{get; set;}
  public LIST<LIST<User_Profile_Event__c >> listOfExhibitorsForEvent{get; set;}
  
 
  public String selectedEvent{get; set;}
  public String selectedCorporateId{get; set;}
  public String selectedMBEId{get; set;} 
  public boolean displayCommentsPopup1{get; set;}       
  public  String selectedapp {get;set;}
  public Boolean showScheduleByTime{get; set;}
  public Boolean showScheduleByName{get; set;}
  public Boolean showTimePicklist {get; set;}
  public Boolean showTimeList {get; set;}
   
  public Event__c eventTimeDetails{get; set;}
  
  public String selectedDate{get; set;}
  public String selectedTimeSlot{get; set;}
  public Boolean showGeneralSchedulesBool {get; set;}    

  public boolean showMatches{get; set;}
  public boolean showButtons{get; set;}
  public list<selectoption> apps{get; set;}
  public list<Tags__c> tagslist {get; set ;}
  public string attendeealias {get ; set ;}
  public string exhibitoralias {get ; set ;}
  public MM_Evenntadmin_schedulecon(){
      ShowScheduleError=FALSE;
     // MaxSlotError=FALSE;
      attendeealias ='';
      exhibitoralias ='';
      eventTimeDetails= new Event__c();
      apps = new list<selectoption> ();
     apps.add(new selectoption('Match Leads','Match Leads'));
      apps.add(new selectoption('Booth Leads','Booth Leads'));
      selectedapp = 'Match Leads';
      
         
  try{
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
      selectedEvent= k.getValue();
    //selectedEvent ='a00Z000000HXEDe';
    eventtimedetails =[SELECT ID, MatchMaking_Type__c, EV_Title__c,Match_Making_Schedules__c,Is_Webank_event__c
                       FROM Event__c 
                       WHERE id =: selectedEvent];
       tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : selectedEvent];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
       
       }
    //showButtons= TRUE;
    showScheduleByTime= FALSE;
    showScheduleByName= FALSE;
      showTimePicklist=FALSE;
      scheduleByTime();
    }Catch(Exception e){}
     
     
     
 }
 
 public void typeButtons(){
 
     if(showScheduleByTime){
     
         showScheduleByTime= FALSE;
         showTimeList=FALSE;
         showTimePicklist=FALSE;
         scheduleByName();
         
     }else if(showScheduleByName){
         showScheduleByName= FALSE;
         showCorporateSchedulesBool= FALSE;
         showMBESchedulesBool= FALSE;
         scheduleByTime();
     }
     
     
     
 
 }
 
  
    // Schedules By Time code Starts here
    public List<string> matchDatesList{get; set;}
    public LIST<MatchLeads_Days__c> matchLeadsDatesList{get; set;}
    public String selectedMatchDate{get; set;}
    public MAP<Date , LIST<String>> getSlotsFromUtility{get; set;}
    public LIST<String> timeSlotsForMatchDate{get; set;}
    public String selectedMatchSlotTime{get;set;}
      
    public void scheduleByTime(){
      
      showCorporateSchedulesBool= FALSE;
      showMBESchedulesBool= FALSE;
      
      showScheduleByTime= TRUE;
      showTimePicklist=TRUE;
      showTimeList=TRUE;
      ShowScheduleError=FALSE;
      showButtons= FALSE;
      matchLeadsDates();
       
 
    }
  
    public void matchLeadsDates(){
  
        matchDatesList= new list<string>();
        matchLeadsDatesList= new LIST<MatchLeads_Days__c>();
        
        matchLeadsDatesList=[SELECT id,Start_time__c,End_Time__c,MatchLeads_Date__c,Slot_Time_period__c,MAX_noOf_appontments__c,Break_Time_between_slots__c 
                             FROM MatchLeads_Days__c
                             WHERE Event__c=: selectedEvent ];//Limit 1000]; //pls remove 1000 limit
            
            if(matchLeadsDatesList.size() >0){
                 
                 for(MatchLeads_Days__c matchDate: matchLeadsDatesList){
                     matchDatesList.add(string.valueOf(matchDate.MatchLeads_Date__c.format()));                
                 }
                 timeSlotsForPickedDate();   
            }  
    
    }
    
    public Date selectedSplitDate{get; set;}
    public void timeSlotsForPickedDate(){
        
        getSlotsFromUtility= new MAP<Date , LIST<String>>();
        timeSlotsForMatchDate= new LIST<String>();
      
        string pickedDate=ApexPages.currentPage().getParameters().get('MatchmakingDate');
        if(pickedDate != null ){
            selectedMatchDate = ApexPages.currentPage().getParameters().get('MatchmakingDate');
        }else{
            selectedMatchDate= string.valueOf(matchLeadsDatesList[0].MatchLeads_Date__c.format());
        }
        if(selectedMatchDate != null){
            system.debug(' PICKED DATE  '+selectedMatchDate );
            LIST<String> splitDate= new LIST<String>(selectedMatchDate.split('/'));
                
            selectedSplitDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
            system.debug(' SELECTED DATE  '+selectedMatchDate );

            getSlotsFromUtility= MM_Utility.giveEventTimingsWithDates(selectedEvent, selectedSplitDate);
            system.debug(' SLOTS UTILITY  '+getSlotsFromUtility);
  
            timeSlotsForMatchDate= getSlotsFromUtility.get(selectedSplitDate);
            system.debug(' SLOTS LIST '+timeSlotsForMatchDate);

            if(timeSlotsForMatchDate.size() >0){
                selectedMatchSlotTime= timeSlotsForMatchDate[0];
            }
            matchSchedule();
            calcopenslots();
        }
    
    }
    
    
    public Map<String,Integer> timeslotmap{get;set;}
    public List<User_Profile_Event__c>  unsecheduledlist{get;set;}
      public void calcopenslots()
    {
      List<EventSchedule__c> scheduleForExhibitors= new List<EventSchedule__c>(); 
      timeslotmap=new Map<String,Integer>();
      scheduleForExhibitors=[SELECT id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,
                                      MM_slot_StartTime__c, MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                      MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,
                                      MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c  
                                      FROM EventSchedule__c 
                                      WHERE MM_To_EAM__r.IsMatchMakingAttendee__c = true AND 
                                      Is_Matchmaking__c = true AND  
                                      MM_slot_Date__c =: selectedSplitDate AND 
                                      EV_id__c =: SelectedEvent 
                                      AND MM_To_UPE__r.IsMatchMakingUser__c = true AND 
                                      (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')
                                      ORDER BY CreatedDate DESC ];//Limit 1000];//pls remove limit 1000 
                                      
          for(EventSchedule__c evsh:scheduleForExhibitors)
          {
          
            if(timeslotmap.containsKey(evsh.MM_slot_StartTime__c))
            {
            /*List<Id> schid=new List<Id>();
            schid=timeslotmap.get(evsh.MM_slot_StartTime__c);
            schid.add(evsh.MM_To_UPE__r.Id);*/
            Integer count=timeslotmap.get(evsh.MM_slot_StartTime__c);
            count++;
            timeslotmap.put(evsh.MM_slot_StartTime__c,count);
            }
            else
            {
            //List<Id> schid=new List<Id>();
            //schid.add(evsh.MM_To_UPE__r.Id);
            timeslotmap.put(evsh.MM_slot_StartTime__c,1);
            } 
          }                            
          
          unsecheduledlist =new List<User_Profile_Event__c>();                          
          unsecheduledlist =[select id,BoothAdmin_id__c,BoothAdmin_id__r.name,BoothAdmin_id__r.email,BT_id__r.MM_TableNo__c, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Company__c,BT_id__r.BT_Name__c,MAtchMakingProfile__c
                        from User_Profile_Event__c 
                        where MAtchMakingProfile__c = 'Corporate' AND 
                        Request_for_upgrade_profile__c = false AND  
                        EV_id__c =: SelectedEvent  AND
                        BoothAdmin_id__c != null AND 
                        IsMatchMakingUser__c = true ORDER BY Attendee_Summary__r.AS_Company__c];// Limit 1000]; //Pls remove limit 
                        
                        
                                                  
                                      
    }
    
   public LIST<LIST<User_Profile_Event__c>> listOfExhibitorsForEventTime{get; set;}
   public LIST<LIST<Event_Attendee_Mapping__c>> listOfMBEsForEventTime{get; set;}
   public List<EventSchedule__c> scheduleForExhibitors{get;set;}
   public List<EventSchedule__c> schedulesForMBEs{get;set;}
   public Boolean errorbool {get; set;}
   public Boolean errorbool1{get; set;}
   public String errormessage{get; set;}
   public list<User_Profile_Event__c> unsecheduledAdmins{get;set;}
   public list<Event_Attendee_Mapping__c> unscheduledMBEs{get;set;}
   public integer opensize{get;set;}
   public list<ID> scheduledids{get;set;}
   public LIST<String> slotsTimeList{get;set;}
   
   public void scheduleTimeSlotSelect(){
       string pickedSlot=ApexPages.currentPage().getParameters().get('SelectedSlotTime');
       if(pickedSlot != null ){
               selectedMatchSlotTime= ApexPages.currentPage().getParameters().get('SelectedSlotTime');
       }else{
               selectedMatchSlotTime= timeSlotsForMatchDate[0];   
       }
              system.debug('  PICK SLOT  '+pickedSlot);
       matchSchedule();
   }
   
   public void matchSchedule(){
   
       opensize= 0;
       ShowScheduleError=FALSE;
       //try{
           
           system.debug('FINAL SLOT TIME  '+selectedMatchSlotTime);
  
           if(selectedMatchSlotTime != null){
           
               slotsTimeList= new LIST<String>(selectedMatchSlotTime.split('-'));
               scheduleForExhibitors= new List<EventSchedule__c>(); 
               schedulesForMBEs= new List<EventSchedule__c>(); 
               system.debug('GGGGGGGGGGGGGGGG       '+slotsTimeList[0]+'      '+selectedSplitDate +'    ');
               
               scheduleForExhibitors=[SELECT id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,
                                      MM_slot_StartTime__c, MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                      MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,
                                      MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c   
                                      FROM EventSchedule__c 
                                      WHERE MM_To_EAM__r.IsMatchMakingAttendee__c = true AND 
                                      Is_Matchmaking__c = true AND  
                                      MM_slot_StartTime__c =: slotsTimeList[0] AND  
                                      MM_slot_Date__c =: selectedSplitDate AND 
                                      EV_id__c =: SelectedEvent 
                                      AND MM_To_UPE__r.IsMatchMakingUser__c = true AND 
                                      (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')
                                      ORDER BY CreatedDate DESC ];//Limit 1000];//pls remove limit 1000
   
               system.debug('  MMMMMMM11111111111  '+scheduleForExhibitors.size()+'  '+SelectedEvent );
               schedulesForMBEs=[SELECT id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_EAM__r.id,
                                 MM_slot_StartTime__c, MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                 MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c 
                                 FROM EventSchedule__c 
                                 WHERE Is_Matchmaking__c = true AND  
                                 MM_To_EAM__r.IsMatchMakingAttendee__c = true AND 
                                 MM_slot_Date__c =: selectedSplitDate AND 
                                 MM_slot_StartTime__c =: slotsTimeList[0] AND
                                 EV_id__c =: SelectedEvent 
                                 AND (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')];// Limit 1000]; //pls remove limit 1000
                                 //MM_To_EAM__r.IsMatchMakingAttendee__c = true AND MM_slot_StartTime__c =: slotsTimeList[0] AND
   system.debug('  MMMMMMM2222222222222  '+schedulesForMBEs.size()+'  '+schedulesForMBEs);

   LIST<String> scheduledMBEIds= new LIST<String>();
   scheduledids= new LIST<String>();
    system.debug('       SelectedstartTime '+scheduleForExhibitors);
    errorbool=false;
       if(scheduleForExhibitors.size() == 0){
       errorbool = true;
       errormessage = 'No Appointments found for this time slot     ';
       }
  for (EventSchedule__c aa: scheduleForExhibitors) {
                 scheduledids.add(aa.MM_To_UPE__r.Id);
             } 
  for (EventSchedule__c mbe: schedulesForMBEs) {
                 scheduledMBEIds.add(mbe.MM_To_EAM__r.Id);
             } 
   
   unsecheduledAdmins= new list<User_Profile_Event__c>();
   unscheduledMBEs= new LIST<Event_Attendee_Mapping__c> ();
   list<Event_Breaks__c> blokslist = new list<Event_Breaks__c> ();
    list<Event_Breaks__c> blokslistmbe = new list<Event_Breaks__c> ();
   blokslist = [select id,User_Profile_Event__r.id from Event_Breaks__c where User_Profile_Event__c != null AND User_Profile_Event__c != '' AND Break_Start_Time__c =: slotsTimeList[0]];
   
   list<Id> upeids = new list<Id> ();
   for(Event_Breaks__c bid : blokslist){
   upeids.add(bid.User_Profile_Event__r.id);
   }
   
   unsecheduledAdmins =[select id,BoothAdmin_id__c,BoothAdmin_id__r.name,BoothAdmin_id__r.email,BT_id__r.MM_TableNo__c, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Company__c,BT_id__r.BT_Name__c,MAtchMakingProfile__c
                        from User_Profile_Event__c 
                        where id NOT IN :upeids AND
                        MAtchMakingProfile__c = 'Corporate' AND 
                        Request_for_upgrade_profile__c = false AND  
                        EV_id__c =: SelectedEvent  AND  
                        ID not IN : scheduledids AND 
                        BoothAdmin_id__c != null AND 
                        IsMatchMakingUser__c = true ORDER BY Attendee_Summary__r.AS_Company__c];// Limit 1000];//pls remove limit 1000
   
      system.debug('  MMMMMMM3333333333333  '+unsecheduledAdmins.size()+'  '+unsecheduledAdmins);
      
   opensize = unsecheduledAdmins.size();
   blokslistmbe = [select id,Event_Attendee_Mapping__r.id from Event_Breaks__c where Event_Attendee_Mapping__c  != null AND Event_Attendee_Mapping__c   != '' AND Break_Start_Time__c =: slotsTimeList[0]];
   list<Id> mbeids = new list<Id> ();
   for(Event_Breaks__c bid1 : blokslistmbe){
   mbeids.add(bid1.Event_Attendee_Mapping__r.id);
   }
   unscheduledMBEs=[SELECT ID, AS_id__r.AS_FirstName__c, AS_id__r.AS_LastName__c
                    FROM Event_Attendee_Mapping__c 
                    WHERE id NOT IN :mbeids AND
                    IsMatchMakingAttendee__c =: TRUE 
                    AND EV_id__c =: SelectedEvent  
                    AND Boothleads_Profile__c =: 'Attendee'
                    AND ID NOT IN :scheduledMBEIds];// Limit 1000];//Pls remove limit
                    
          system.debug('  MMMMMMM4444444  '+unscheduledMBEs.size()+'  '+unscheduledMBEs);
  
   listOfExhibitorsForEventTime= new LIST<LIST<User_Profile_Event__c >>();
      
      LIST<User_Profile_Event__c > upeListFor999= new LIST<User_Profile_Event__c >();
         
         for(User_Profile_Event__c  upe: unsecheduledAdmins){
             
                 upeListFor999.add(upe);
             
             if(upeListFor999.size() == 999){
                 listOfExhibitorsForEventTime.add(upeListFor999);
                 upeListFor999= new LIST<User_Profile_Event__c >();
             }
             system.debug('  MBES LIST  '+upeListFor999.size()+'  '+listOfExhibitorsForEventTime.size());
         }
         
         if(upeListFor999.size() != 0){
              listOfExhibitorsForEventTime.add(upeListFor999);
         }
   
   system.debug('  MMMMMMM5555555555555  '+listOfExhibitorsForEventTime.size()+'  '+listOfExhibitorsForEventTime);
   SET<ID> unscheduledMBEIds= new SET<ID>();
   for (Event_Attendee_Mapping__c mbe: unscheduledMBEs) {
                 unscheduledMBEIds.add(mbe.Id);
             } 
             
             system.debug('KKKKKKKKKKKKk'+unscheduledMBEIds.size());
   LIST<MatchLeads_Days__c> MLDAYS = new LIST<MatchLeads_Days__c>();
   MLDAYS =[select id,Start_time__c,End_Time__c,Slot_Time_period__c,MAX_noOf_appontments__c,Break_Time_between_slots__c from MatchLeads_Days__c   where MatchLeads_Date__c =: selectedSplitDate AND  Event__c=: SelectedEvent ];                                
   integer maxValue=integer.valueof(MLDAYS[0].MAX_noOf_appontments__c);
    system.debug(' MAX VALUE '+maxValue);
      list<AggregateResult>  countofapp = [SELECT count(id) i,MM_To_EAM__c e 
                                           FROM EventSchedule__c 
                                           WHERE MM_To_EAM__c IN: unscheduledMBEIds AND
                                           EV_id__c =: SelectedEvent  AND
                                           MM_slot_Date__c =: selectedSplitDate AND
                                           (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')
                                           Group By MM_To_EAM__c ];//Limit 1000];//pls remove limit 1000
                                          
          system.debug(' EXISTING SCHEDULES FOR TIME   '+countofapp.size()+'     '+countofapp);                                
                                          
            for (AggregateResult ar : countofapp){
            
            System.debug(ar.get('i')+' ID TO REMOVE '+ar.get('e'));
            if(integer.valueof(ar.get('i')) >= maxValue){
                system.debug(' LIMIT IDS  '+integer.valueof(ar.get('i')));
                unscheduledMBEIds.remove((String)ar.get('e'));
            
            }
            } 
            system.debug(' UNSCHEDULED IDS '+unscheduledMBEIds.size());
            unscheduledMBEs= new LIST<Event_Attendee_Mapping__c>();       
    unscheduledMBEs=[SELECT ID, AS_id__r.AS_FirstName__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_LastName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c
                    FROM Event_Attendee_Mapping__c 
                    WHERE IsMatchMakingAttendee__c =: TRUE 
                    AND EV_id__c =: SelectedEvent  
                    AND Boothleads_Profile__c =: 'Attendee'
                    AND ID IN :unscheduledMBEIds];// Limit 1000];//pls remove limit 1000
                    
    listOfMBEsForEventTime= new LIST<LIST<Event_Attendee_Mapping__c>>();
      
      LIST<Event_Attendee_Mapping__c> eamListFor999= new LIST<Event_Attendee_Mapping__c>();
         
         for(Event_Attendee_Mapping__c eam: unscheduledMBEs){
             
             if(eam.AS_id__r.AS_FirstName__c != null || eam.AS_id__r.AS_LastName__c != null){
                 eamListFor999.add(eam);
             }
             if(eamListFor999.size() == 999){
                 listOfMBEsForEventTime.add(eamListFor999);
                 eamListFor999= new LIST<Event_Attendee_Mapping__c>();
             }
             system.debug('  MBES LIST  '+eamListFor999.size()+'  '+listOfMBEsForEventTime.size());
         }
         
         if(eamListFor999.size() != 0){
              listOfMBEsForEventTime.add(eamListFor999);
         }
  
      errorbool1=false;
      if(listOfExhibitorsForEventTime.size() == 0){
       errorbool1 = true;
       errormessage = 'Prime Contractor Busy at This Time Slot        ';
       }
    }
  // }catch(Exception Ex){}
   }
   
   public String selectedMBETimeId{get; set;}
   public String selectedUPETimeId{get; set;}
   public Boolean showErrorForScheduleTime {get; set;}
   public String selectedMBETimeName{get; set;}
   public String selectedExhibitorTimeName{get; set;}
   
    public void mbeScheduleTimeId(){
       
        system.debug('    HELLO 000000000000000000  '+ Apexpages.CurrentPage().getParameters().get('mbeTimeId')+'     '+selectedMBETimeId);
       ShowScheduleError=FALSE;
       if(selectedMBETimeId == NULL){
           selectedMBETimeId= Apexpages.CurrentPage().getParameters().get('mbeTimeId');
           
           system.debug('    HELLO 11111111111111   '+ selectedMBETimeId);
           
       }
       
       system.debug(' GET MBE ID  '+selectedMBETimeId+'  '+selectedUPETimeId );
       
   }
   
   public void corporateScheduleTimeId(){
         ShowScheduleError=FALSE;
         system.debug('    HELLO 222222222222222222222222222222  '+ Apexpages.CurrentPage().getParameters().get('exhibitorTimeId')+'     '+selectedUPETimeId);
          system.debug('    HELLO 000000000000000000  '+ Apexpages.CurrentPage().getParameters().get('mbeTimeId')+'     '+selectedMBETimeId);
       
       if(selectedUPETimeId == NULL){
           selectedUPETimeId= Apexpages.CurrentPage().getParameters().get('exhibitorTimeId');
           
           system.debug('    HELLO 33333333333333333333333   '+ selectedMBETimeId);
           
       }
       system.debug(' GET EXHIBITOR ID  '+selectedUPETimeId+'   '+selectedMBETimeId );
       
   }
   
   
   public void makeTimeScheduleFromJS(){
          ShowScheduleError=FALSE;
          system.debug('    HELLO 5555555555555  '+ Apexpages.CurrentPage().getParameters().get('exhibitorTimeId2')+'     '+selectedUPETimeId);
          system.debug('    HELLO 66666666666666  '+ Apexpages.CurrentPage().getParameters().get('mbeTimeId2')+'     '+selectedMBETimeId);
       
       selectedMBETimeId  = Apexpages.CurrentPage().getParameters().get('mbeTimeId2');
       selectedUPETimeId  = Apexpages.CurrentPage().getParameters().get('exhibitorTimeId2');
       
       
       makeTimeSchedule();
   }
   
   public Boolean ShowScheduleError{get; set;}
  // public Boolean MaxSlotError{get; set;}
   public void makeTimeSchedule(){
        
      //   system.debug('    HELLO 222222222222222222222222222222  '+ Apexpages.CurrentPage().getParameters().get('exhibitorTimeId')+'     '+selectedUPETimeId);
        system.debug(' SCHEDULE EXHIBITOR ID  '+selectedUPETimeId+'   '+selectedMBETimeId );

      /* Integer countOfSlots = [SELECT COUNT() FROM EventSchedule__c WHERE EV_id__c=: selectedEvent AND MM_Slot_Status__c = 'Accepted'];
       Event__c MaxSlotsAllowed =[SELECT Maximum_slots_allowed__c FROM Event__c WHERE ID =: selectedEvent];
       system.debug('countOfSlots :'+countOfSlots +'      '+'MaxSlotsAllowed :'+MaxSlotsAllowed.Maximum_slots_allowed__c );
       MaxSlotError=FALSE;
       IF(countOfSlots < MaxSlotsAllowed.Maximum_slots_allowed__c){*/
            if(selectedMBETimeId != null && selectedUPETimeId != null ){
               
               LIST<EventSchedule__c> checkExistingSchedule= new LIST<EventSchedule__c> (); 
               checkExistingSchedule=[SELECT ID 
                                      FROM EventSchedule__c
                                      WHERE EV_id__c=: selectedEvent AND
                                      MM_To_EAM__c != NULL AND 
                                      MM_To_UPE__c != NULL AND
                                      ((MM_To_EAM__c=: selectedMBETimeId AND MM_To_UPE__c=: selectedUPETimeId) OR
                                      ((MM_To_EAM__c=: selectedMBETimeId OR MM_To_UPE__c=: selectedUPETimeId) AND
                                      MM_slot_Date__c=: selectedSplitDate AND
                                      MM_slot_StartTime__c=: slotsTimeList[0] AND
                                      MM_Slot_End_Time__c=: slotsTimeList[1])) AND
                                      (MM_Slot_Status__c =: 'Accepted' OR MM_Slot_Status__c =: 'Pending')
                                      ];       
               
                   
                            if(checkExistingSchedule.size() <=0){                       
                   LIST<EventSchedule__c> existingSchedule= new LIST<EventSchedule__c> ();
                              
                   EventSchedule__c insertSchedule= new EventSchedule__c();
                
                   insertSchedule.EV_id__c= selectedEvent ;
                   insertSchedule.MM_To_EAM__c= selectedMBETimeId ;
                   insertSchedule.MM_To_UPE__c= selectedUPETimeId ;
                   insertSchedule.MM_slot_Date__c= selectedSplitDate ;
                   insertSchedule.MM_slot_StartTime__c=slotsTimeList[0]; 
                   insertSchedule.MM_Slot_End_Time__c= slotsTimeList[1];
                   insertSchedule.Comments__c= commentsnew;
                   insertSchedule.Is_Matchmaking__c= TRUE;
                   displayCommentsPopup1 = false;
                   if(eventtimedetails.MatchMaking_Type__c =='Open' || eventtimedetails.MatchMaking_Type__c =='Closed'){
                       insertSchedule.MM_Slot_Status__c ='Accepted';
                   }else {
                       insertSchedule.MM_Slot_Status__c ='Pending';
                   }  
                   dataBase.saveResult createSchedule= dataBase.Insert(insertSchedule);
                   system.debug('INSERT SSCHEDULE  '+createSchedule);
                   
                   selectedMBETimeId  = null;
                   selectedUPETimeId  = null;
                   
                   matchSchedule();
                   ShowScheduleError= FALSE;
                    
               }else{
                   displayCommentsPopup1 = false;
                   ShowScheduleError= TRUE;
                                      system.debug(' BOOLEAN SCHEDULE ERROR  '+ShowScheduleError );
               }
    
              
           }
      /* }
       else{
           MaxSlotError= TRUE;
       }
       system.debug('MaxSlotError:'+MaxSlotError);*/
   }
   
     public void closeTimeErrorPopup(){
         showErrorForScheduleTime= FALSE;
     }
  //Schedules By Name code Starts here
 
  public void scheduleByName(){
  
      showScheduleByTime= FALSE;
      showTimePicklist=FALSE;
      LisofCorporates();
      LisofMBEs();
      showScheduleByName= TRUE;
      showButtons= FALSE;
     system.debug(showScheduleByTime+'  BOOLEAN '+showTimePicklist);
  }
   
  public void LisofMBEs(){
     
      listOfMBEsForEvent= new LIST<LIST<Event_Attendee_Mapping__c>>();
      
      LIST<Event_Attendee_Mapping__c> eamListFor999= new LIST<Event_Attendee_Mapping__c>();
         
         for(Event_Attendee_Mapping__c eam: [SELECT ID,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_LastName__c, AS_id__r.AS_Company__c FROM Event_Attendee_Mapping__c WHERE EV_id__c =: selectedEvent AND IsMatchMakingAttendee__c =: TRUE AND Boothleads_Profile__c =: 'Attendee']){
             
             eamListFor999.add(eam);
             if(eamListFor999.size() == 999){
                 listOfMBEsForEvent.add(eamListFor999);
                 eamListFor999= new LIST<Event_Attendee_Mapping__c>();
             }
             system.debug('  MBES LIST  '+eamListFor999.size()+'  '+listOfMBEsForEvent.size());
         }
         
         if(eamListFor999.size() != 0){
              listOfMBEsForEvent.add(eamListFor999);
         }
         
                      system.debug(' ALL MBES LIST  '+eamListFor999.size()+'  '+listOfMBEsForEvent.size());

        
    
     }
     
     public void LisofCorporates(){
     
     listOfExhibitorsForEvent= new LIST<LIST<User_Profile_Event__c >>();
      
      LIST<User_Profile_Event__c > upeListFor999= new LIST<User_Profile_Event__c >();
         
         for(User_Profile_Event__c  upe: [SELECT ID, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Company__c, BT_id__r.BT_Name__c, BT_id__r.MM_TableNo__c  FROM User_Profile_Event__c WHERE EV_id__c =: selectedEvent AND Request_for_upgrade_profile__c = false AND MAtchMakingProfile__c = 'Corporate' AND IsMatchMakingUser__c = true AND BoothAdmin_id__c != null]){
             
             upeListFor999.add(upe);

             if(upeListFor999.size() == 999){
                 listOfExhibitorsForEvent.add(upeListFor999);
                 upeListFor999= new LIST<User_Profile_Event__c >();
             }
             system.debug('  MBES LIST  '+upeListFor999.size()+'  '+listOfExhibitorsForEvent.size());
         }
         
         if(upeListFor999.size() != 0){
              listOfExhibitorsForEvent.add(upeListFor999);
         }
         
                      system.debug(' ALL MBES LIST  '+upeListFor999.size()+'  '+listOfExhibitorsForEvent.size());

    
     }
     
     
    
    
    public MAP<string,EventSchedule__c>  eventScheduleMAP{get;set;}
    public MAP<DATE,LIST<String>> dateSlotsMAP{get;set;}
    public List<timeInnerToMap> timeListMap{get;set;}
    public LIST<matchesInner> matchesInnList{get; set;} 
    public String selectedMBEName{get; set;}
    public String selectedCorporateName{get; set;}
    
    public void MBEScheduleID(){
       system.debug(' MBE RECORDS  '+selectedMBEId );
        if(selectedMBEId != null && selectedMBEId !=''){
        system.debug(' MBE ID  '+selectedMBEId );
                MBEBookedSchedulesMAP = new MAP<id, EventSchedule__c>([SELECT MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c, id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_Slot_Status__c from EventSchedule__c where EV_id__c =: selectedEvent and Is_Matchmaking__c= TRUE AND MM_To_EAM__c =: selectedMBEId and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) AND MM_To_UPE__r.BT_id__r.BT_Name__c != null AND (MM_Slot_Status__c =: 'Accepted' OR MM_Slot_Status__c =: 'Pending')]);
                MBEBookedSchedules = MBEBookedSchedulesMAP.values();
                selectedMBEName='';
                
                Event_Attendee_Mapping__c  selectedAttendeeName= [SELECT ID,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_LastName__c FROM Event_Attendee_Mapping__c 
                                               WHERE Id =: selectedMBEId ];
                 if(eventtimedetails.Is_Webank_event__c == false){                              
                selectedMBEName= selectedAttendeeName.AS_id__r.AS_FirstName__c+' '+ selectedAttendeeName.AS_id__r.AS_LastName__c;
                }else{
                selectedMBEName= selectedAttendeeName.MBE_Profile__r.AS_FirstName__c+' '+ selectedAttendeeName.MBE_Profile__r.AS_LastName__c;
                }
        system.debug(' MBE RECORDS  '+MBEBookedSchedules);
  
        }
    }
    
    public void CorporateScheculed(){
          system.debug(' CORP ID  '+selectedCorporateId );
        if(selectedCorporateId != null && selectedCorporateId !='') {
                system.debug(' CORP ID  '+selectedCorporateId );

                CoroprateBookedSchedulesMAP = new MAP<id, EventSchedule__c>([SELECT id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c, MM_To_EAM__r.MBE_Profile__r.AS_LastName__c, MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_slot_Date__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c ,MM_Slot_Status__c  FROM EventSchedule__c where EV_id__c =: selectedEvent  and Is_Matchmaking__c=true and  MM_To_UPE__c =: selectedCorporateId and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) AND MM_To_UPE__r.BT_id__r.BT_Name__c != null AND (MM_Slot_Status__c =: 'Accepted' OR MM_Slot_Status__c =: 'Pending')]);
                CoroprateBookedSchedules = CoroprateBookedSchedulesMAP.Values();
                            system.debug(' CORP RECORDS'+CoroprateBookedSchedules );
                selectedCorporateName='';
                
                User_Profile_Event__c  selectedExhibitorName= [SELECT ID, BT_id__r.BT_Name__c, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Company__c
                                                        FROM User_Profile_Event__c 
                                                        WHERE Id =: selectedCorporateId ];
         
                
                    selectedCorporateName= selectedExhibitorName.BT_id__r.BT_Name__c;
                
        }
    
    }
    
    
    public pagereference exstingAppointmentsForMBE(){
    
        if(selectedMBEId != null && selectedMBEId !=''){
            
        MBEBookedSchedules = new LIST<EventSchedule__c>();
        MBEBookedSchedulesMAP = new MAP<id, EventSchedule__c>();
        system.debug(' BOOLEAN FOR MBE '+showMBESchedulesBool);
        MBEScheduleID();
       // if(selectedCorporateId!=null && selectedCorporateId!=''){
         showMBESchedulesBool= TRUE;
       //  }
        system.debug('AFTER  BOOLEAN FOR MBE '+showMBESchedulesBool);
        matchProfiles();
        } 
        return null;
    }
    
    public pagereference exstingAppointmentsForCorporate(){
    
        if(selectedCorporateId != null && selectedCorporateId!='' ){
            CoroprateBookedSchedules = new LIST<EventSchedule__c>();
             
            CoroprateBookedSchedulesMAP = new MAP<id, EventSchedule__c>();
            CorporateScheculed();
            showCorporateSchedulesBool= TRUE;
           
            matchProfiles();
        }
        return null;
    }
    
    public LIST<MatchLeads_Days__c> allEventDates{get; set;}
    public Boolean ShowDatePicklist{get; set;}
    public LIST<SelectOption> eventDatesList{get; set;}
    public String selectedEventDate{get; set;}
    
    public pagereference matchProfiles(){
    
        system.debug(' IDS '+selectedMBEId+'   '+selectedCorporateId);
        eventDatesList= new LIST<SelectOption>();

       if(selectedMBEId != null && selectedCorporateId != null){
        
        allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: selectedEvent ORDER BY MatchLeads_Date__c ASC]);
      if(allEventDates.size() >1){
         ShowDatePicklist= true;
         for(MatchLeads_Days__c matchDate: allEventDates){
             
             String dateFormat= matchDate.MatchLeads_Date__c.format();
             eventDatesList.add(new selectoption(dateFormat,dateFormat));
             
              }
         
         }
            selectedEventDate= allEventDates[0].MatchLeads_Date__c.format();
            
                
            timeSlotsForDate();
                    system.debug('  MATCHES LIST   '+matchesInnList.size()+'   '+matchesInnList);

        }
        return null;
    }
    public list<Event_Breaks__c> blokslistexist {get ; set ;}
    public string listvals {get ; set ;}
    public string listvalsmbe {get ; set ;}
    public void timeSlotsForDate(){
        
        System.debug('PPPPPPPp  '+selectedMBEId+'   '+selectedCorporateId);
        eventScheduleMAP= new MAP<string,EventSchedule__c>();
        matchesInnList= new LIST<matchesInner>();
        if((selectedMBEId!=null && selectedMBEId!='' ) && (selectedCorporateId!=null && selectedCorporateId!='')){
          showMatches= TRUE;
        }else{
           showMatches= FALSE;
        }
        showSchedulesList();
        if(selectedEventDate != null){
        
        LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                
                Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
           
        for(EventSchedule__c mbe: [SELECT MM_To_EAM__c,MM_To_UPE__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.BT_Name__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c from EventSchedule__c where EV_id__c =: selectedEvent and Is_Matchmaking__c=true and MM_To_EAM__c =: selectedMBEId and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) and MM_To_UPE__r.BT_id__r.BT_Name__c != null AND MM_slot_Date__c =: selectedDate]){
            eventScheduleMAP.put(mbe.MM_slot_Date__c+mbe.MM_slot_StartTime__c+'-'+mbe.MM_Slot_End_Time__c,mbe);
        }
     
     
    
        for(EventSchedule__c corp: [SELECT id,MM_To_EAM__c,MM_To_UPE__c, MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c from EventSchedule__c where EV_id__c =: selectedEvent  and Is_Matchmaking__c=true and  MM_To_UPE__c =: selectedCorporateId and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) AND MM_slot_Date__c =: selectedDate and MM_To_UPE__r.BT_id__r.BT_Name__c != null]){
            eventScheduleMAP.put(corp.MM_slot_Date__c+corp.MM_slot_StartTime__c+'-'+corp.MM_Slot_End_Time__c,corp);
            
        }
        
        MAP<Date, Integer> maxAppointmentsMAP= new MAP<Date, Integer>();
         for(AggregateResult agg :[SELECT count(id) c,MM_slot_Date__c d from EventSchedule__c where EV_id__c =: selectedEvent  and Is_Matchmaking__c=true and  MM_To_EAM__c =: selectedMBEId  and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) AND MM_slot_Date__c =: selectedDate group by MM_slot_Date__c]){
                                                                                                                                                               //MM_To_UPE__c =: selectedCorporateId
           integer  app = (Integer) agg.get('c');
            date dt= (date) agg.get('d');
            maxAppointmentsMAP.put(dt,app);
        
        }
        system.debug('    MAX NUMBER LIMIT '+maxAppointmentsMAP.size()+'   '+maxAppointmentsMAP);

         
         for(MatchLeads_Days__c match: [select id,Break_Time_between_slots__c,End_Time__c,Event__c,MatchLeads_Date__c,MAX_noOf_appontments__c,Slot_Time_period__c,Start_time__c from MatchLeads_Days__c where Event__c =: selectedEvent AND MatchLeads_Date__c =: selectedDate]){
        
             dateSlotsMAP= new MAP<DATE,LIST<String>>();
             dateSlotsMAP= MM_Utility.giveEventTimingsWithDates(selectedEvent , match.MatchLeads_Date__c);
             timeListMap= new List<timeInnerToMap>();
        system.debug('   SLOT MAP  '+dateSlotsMAP.size()+'   '+dateSlotsMAP);          
          if(dateSlotsMAP.size() >0){
            for(string dtime:dateSlotsMAP.get(match.MatchLeads_Date__c)){
              timeListMap.add(new timeInnerToMap(dtime,eventScheduleMAP.get(match.MatchLeads_Date__c+dtime))); 
            }
                    system.debug('   TIME LIST INNER   '+timeListMap.size()+'   '+timeListMap);          
            }
             string maxnumber=''; 
             system.debug(maxAppointmentsMAP.get(match.MatchLeads_Date__c)+'  MAXIMUM LIMIT   '+match.MAX_noOf_appontments__c); 
          if(match.MAX_noOf_appontments__c <= maxAppointmentsMAP.get(match.MatchLeads_Date__c)){
            maxnumber='You have scheduled max number of Appointments for this day';
          }     
                blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: selectedCorporateId];
                    listvals = '';
               system.debug('-----------------blocklist--------------'+listvals);
               for(Event_Breaks__c evb: blokslistexist ){
               
               listvals += evb.Break_Start_Time__c+'-'+evb.Break_End_Time__c+',';
               }
               list<Event_Breaks__c> blokslistexistmbe = new list<Event_Breaks__c>();
                blokslistexistmbe = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__c =: selectedMBEId ];
                    listvalsmbe = '';
               system.debug('-----------------blocklist--------------'+listvalsmbe);
               for(Event_Breaks__c evb1: blokslistexistmbe ){
               
               listvalsmbe += evb1.Break_Start_Time__c+'-'+evb1.Break_End_Time__c+',';
               }
               
                system.debug('-----------------blocklist--------------'+listvals); 
            matchesInnList.add(new matchesInner(match.MatchLeads_Date__c,timeListMap,maxnumber));
         }
        }
        
    }
    
    public LIST<EventSchedule__c> MBEBookedSchedules{get; set;}
    public LIST<EventSchedule__c> CoroprateBookedSchedules{get; set;}
    public MAP<id,EventSchedule__c> MBEBookedSchedulesMAP{get; set;}
    public MAP<id, EventSchedule__c> CoroprateBookedSchedulesMAP{get; set;}
    public LIST<EventSchedule__c> allBookedSchedules{get; set;}
    public MAP<id, EventSchedule__c> allBookedSchedulesMAP{get; set;}
    public Boolean showMBESchedulesBool{get; set;}
    public Boolean showCorporateSchedulesBool{get; set;}
    
    public void showSchedulesList(){
        
         allBookedSchedules = new LIST<EventSchedule__c>();
         allBookedSchedulesMAP = new MAP<id, EventSchedule__c>();
         
         LIST<ID> CorpId = new LIST<ID>();
         LIST<ID> MBEId = new LIST<ID>();
         MBEId.addAll(MBEBookedSchedulesMAP.keySet());
         CorpId.addAll(CoroprateBookedSchedulesMAP.keySet());

        allBookedSchedulesMAP = new MAP<id, EventSchedule__c>([SELECT id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_Slot_Status__c, MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c from EventSchedule__c 
                                                                                                                                WHERE ID NOT IN: CorpId AND ID NOT IN: MBEId AND EV_id__c =: selectedEvent AND Is_Matchmaking__c=TRUE  AND (MM_slot_StartTime__c!=null AND MM_Slot_End_Time__c!=null)]);
        allBookedSchedules = allBookedSchedulesMAP.Values();
    
    }
    
    
    
    public String Comments{get; set;}
    public boolean displayCommentsPopup{get; set;}
    public boolean displayErrorPopup{get; set;}    
    public pagereference addCommentsToSchedule(){
    comments='';
         List<EventSchedule__c> existingSchedule= new List<EventSchedule__c>();
         LIST<String> dateList= new LIST<String>(selectedDate.split('/'));
         //Date dd= date.newinstance(integer.valueOf(dateList[2]),integer.valueOf(dateList[0]),integer.valueOf(dateList[1]));
         existingSchedule=[select id,MM_To_EAM__c,MM_To_UPE__c from EventSchedule__c where (MM_To_UPE__c =: selectedCorporateId AND MM_To_EAM__c =:selectedMBEId) and EV_id__c =: selectedEvent  and (MM_Slot_Status__c  =: 'Accepted' OR MM_Slot_Status__c =: 'Pending') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)];// and MM_slot_Date__c =: dd
        system.debug('  NAME EXISTING SCHEDULE'+existingSchedule);
        if(existingSchedule.size() <=0){
            displayCommentsPopup= TRUE;
        }else{
            displayErrorPopup= TRUE;
        }
            
        return null;
    
    }
   
    public void makeSchedule(){
    
        system.debug(' INFORMATION '+selectedDate+'   '+selectedTimeSlot+'  '+selectedMBEId+'   '+selectedCorporateId);
        EventSchedule__c insertSchedule= new EventSchedule__c();
        
        LIST<String> timeSlots= new LIST<String>(selectedTimeSlot.split('-'));
        LIST<String> dateList= new LIST<String>(selectedDate.split('/'));
        
        
        insertSchedule.EV_id__c= selectedEvent ;
        insertSchedule.MM_To_EAM__c= selectedMBEId;
        insertSchedule.MM_To_UPE__c= selectedCorporateId;
        insertSchedule.MM_slot_Date__c= date.newinstance(integer.valueOf(dateList[2]),integer.valueOf(dateList[0]),integer.valueOf(dateList[1]));
        insertSchedule.MM_slot_StartTime__c=timeSlots[0]; 
        insertSchedule.MM_Slot_End_Time__c= timeSlots[1];
        insertSchedule.Comments__c= comments;
        insertSchedule.Is_Matchmaking__c= TRUE;
        
        if(eventtimedetails.MatchMaking_Type__c =='Open' || eventtimedetails.MatchMaking_Type__c =='Closed'){
            insertSchedule.MM_Slot_Status__c ='Accepted';
        }else {
            insertSchedule.MM_Slot_Status__c ='Pending';
        }  
        dataBase.saveResult createSchedule= dataBase.Insert(insertSchedule);
   system.debug('INSERT SSCHEDULE  '+createSchedule);
        displayCommentsPopup= false;
        showMatches= False;
        //matchProfiles();
       selectedMBEId ='';
selectedCorporateId   ='';      
        MBEScheduleID();
        CorporateScheculed();
    }
    
    public void closeSlotPopup(){
    
        showMatches= False;
        
    }
    public void closeCommentsPopup(){
    
        displayCommentsPopup= false;
        displayCommentsPopup1= false;
        displayErrorPopup= False;
       
    }
    
    public void closeErrorPopup(){
    
        displayCommentsPopup= false;
        displayErrorPopup= False;
        showMatches= False;
        showScheduleError= False;       
    }
    
    public class matchesInner{
    public string errorreached{get;set;}
    public string sTime{get;set;}
    public List<timeInnerToMap> mapListTime{get;set;}
    
    public matchesInner(date ttime,List<timeInnerToMap> listm,string sde){
      string dayone =string.valueOf(ttime);
       this.errorreached =sde;
         if(dayone !=null && dayone !=''){
            string[] str =  dayone.split('-');
          this.sTime=str[1]+'/'+str[2]+'/'+str[0];
       
       this.mapListTime=listm;
     }   
   }
   
   }
    
   
    public class timeInnerToMap{
            public string slottime{get;set;}
            public EventSchedule__c slotName{get;set;}
            public timeInnerToMap(string xs,EventSchedule__c xd){
             this.slottime = xs;
             this.slotName =xd;
            }
            
       }
       
     public void cancelschedule(){
       string eid =apexpages.currentpage().getparameters().get('esid');
       system.debug('       esid       '+eid);
       EventSchedule__c esch = [select MM_Slot_Status__c from EventSchedule__c where id =: eid];
       esch.MM_Slot_Status__c = 'Cancelled';
       update esch;
       
       matchSchedule();   
   }
   
   /* Added By Rajesh Kumar to update Schedule to Missed Status - 15-06-2015 */
   public void UpdateAppmntToMissed(){
       string missedAppId =apexpages.currentpage().getparameters().get('missedAppId');
       system.debug('       missedAppId  '+missedAppId );
       EventSchedule__c esch = [select MM_Slot_Status__c from EventSchedule__c where id =: missedAppId];
       esch.MM_Slot_Status__c = 'Missed';
       update esch;
       
       matchSchedule();   
   }
   /* Added By Rajesh Kumar to update Schedule to Missed Status - 15-06-2015 */
   
    public Pagereference CheckUser(){
       
      
       
       Pagereference pg = MM_Utility.checkLogInservice();
       
       system.debug('******************************    '+ pg);
       
       return pg;
       
   }
   //For doing multiple schedules created a new page for page direction we used this method
   /* public pagereference multischedules(){
     pagereference pg = page.MM_multipleschedules;
     return pg;
    
    }*/
    public String selectedMBETimeIdformulti {get; set;}
   //For getting all free slots of selected Mbe and corporates of perticular slot 
   public void GoToSchedule(){
   //system.debug('----------------------------------------------multiple schedule method----------------------'+selectedMBETimeIdformulti );
   
   }
   public string commentsnew {get ; set ;}
   public void opencoomentbox(){
   Commentsnew='';
   displayCommentsPopup1 = true;
   
   }
    
}