public with sharing class MM_Utility {
    
    public  static Id upeforEventID{get; set;}
    public static LIST<String> givesSlotTimings(String stTime, String edTime, String slotTime, String slotgap){
       
        system.debug('           services          '+stTime +'      ' +edTime +'   ' +slotTime   + '      '+slotgap);
      
        integer starthh;
        integer startMM;
        
        if(slotgap == null){
            slotgap = '0';
        }
        
        LIST<String> slotTimings = new LIST<String>();
        List<string> sthour = stTime.split(':');
        system.debug(' value after splitting '+sthour[0]);
        
        starthh=integer.valueOf(sthour [0]);
        List<string> Startmints = sthour [1].split(' ');
        startMM=integer.valueOf(Startmints [0]);
       
        if(Startmints [1] == 'PM' && starthh != 12){
            starthh = starthh+12;
        }
        
        Time mmstartTime = Time.newInstance(starthh, startMM, 00, 00);
        globalTimeConvertion glob = new globalTimeConvertion();
        
        system.debug(' TIME '+mmstartTime );
        
        integer Endhh;
        integer EndMM;
        decimal Endtimeval;
        List<string> Endhour = edTime.split(':');
        system.debug(' value after splitting '+Endhour[0]);
        Endhh=integer.valueOf(Endhour[0]);
        List<string> ENDmints = Endhour [1].split(' ');
        EndMM=integer.valueOf(ENDmints [0]);
        if(ENDmints [1] == 'PM' && Endhh != 12){
        Endhh= Endhh+12;
        }
        Time mmEndTime = Time.newInstance(Endhh, EndMM, 00, 00);
        system.debug(' TIME END  '+mmEndTime );
        system.debug(' START TIME '+mmstartTime +'    '+mmEndTime );

        for (integer i=0;mmstartTime < mmEndTime ;i++){
        
        Time startTimeMM=mmstartTime;
        Time ENdTimeMM=mmstartTime.addMinutes(integer.valueOf(slotTime)).addMinutes(integer.valueOf(slotgap));
        Time MMEdTime =mmstartTime.addMinutes(integer.valueOf(slotTime));
        //   ENdTimeMM=mmstartTime.addMinutes(integer.valueOf(slotgap));
             
        mmstartTime = ENdTimeMM;
         
        String ss = glob.timeTostring(startTimeMM);
         
        String EE = glob.timeTostring(MMEdTime);
        system.debug('    START TIME '+ss); 
        system.debug('    END TIME '+EE); 
        slotTimings.add(ss+'-'+EE);
        
        system.debug('   BOTH  '+slotTimings); 

        
        } 
         
          system.debug('   Return Valuessssssss.................... '+slotTimings); 
         
         return slotTimings;
         
    }
    
    public static String checkTime(){
        
        dateTime dt = system.now();
        
    //  Time 
        
        return null;
    }
    
    
    public static Pagereference checkLogInservice(){
        
        User U = [Select Id, Alias FROM USER WHERE ID =: UserInfo.getUserId()];
        
            PageReference pg = new PageReference('/MM_newsignup');
            pg.setRedirect(true);
            
         
        if(u.Alias == 'guest'){
            return pg;
        }else{
            return null;
        }
        
        
    }
    
    
    public static LIST<EventSchedule__c> AttshowTimings(id eventId,id eamID /*, Date evDate */){
        
        // Event__c scheduleEvent = [SELECT ID, NAME FROM Event__c];
       
        LIST<EventSchedule__c> attendeeSchedule = new LIST<EventSchedule__c>();
        MAP<String, EventSchedule__c> attendeeScheduleMAP = new MAP<String, EventSchedule__c>();
            
        attendeeSchedule = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                               MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c 
                               WHERE EV_id__c=: eventId AND MM_To_EAM__c =: eamID AND Is_Matchmaking__c = TRUE /* AND MM_slot_Date__c =: evDate */ AND MM_Slot_Status__c !='Cancelled'];
                    
          for(EventSchedule__c es: attendeeSchedule){
             attendeeScheduleMAP.put(es.MM_slot_StartTime__c,  es);
          }
          
         return attendeeSchedule;
    }
   /*  Deprecated FROM Match Leads 2.0
    public static MAP<String, EventSchedule__c> BAshowTimings(id eventId,id upeID ){
        
         
        LIST<EventSchedule__c> boothAdminSchedules = new LIST<EventSchedule__c>();
        MAP<String, EventSchedule__c> exibitorScheduleMAP = new MAP<String, EventSchedule__c>();
           
            
          
        boothAdminSchedules = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                                    MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c 
                                    WHERE EV_id__c=: eventId AND MM_To_UPE__r.User_id__c =: upeID AND Is_Matchmaking__c = TRUE AND MM_Slot_Status__c !='Cancelled'
                                    ORDER BY MM_slot_Date__c];
                
        for(EventSchedule__c es: boothAdminSchedules){
             exibitorScheduleMAP.put(es.MM_slot_StartTime__c,  es);
        }
          
         return exibitorScheduleMAP;
    }
    */
    
     public static MAP<Date, MAP<String, EventSchedule__c>> attendeeScheduleTimings(id eventId, id eamID){
          
          MAP<Date, MAP<String, EventSchedule__c>> exibitorScheduleMAP = new MAP<Date, MAP<String, EventSchedule__c>>();
        LIST<EventSchedule__c> attendeeSchedules = new LIST<EventSchedule__c>();
       
       attendeeSchedules = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                                    MM_Slot_End_Time__c, MM_To_UPE__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, OwnerID FROM EventSchedule__c 
                                    WHERE EV_id__c=: eventId AND MM_To_EAM__c =: eamID AND Is_Matchmaking__c = TRUE AND MM_Slot_Status__c !='Cancelled' AND MM_Slot_Status__c !='Rejected'
                                    ORDER BY MM_slot_Date__c, MM_slot_StartTime__c ];
       
       system.debug('TO INTEGRATION...........................    '+ attendeeSchedules );
         
         Date eventDate;
         MAP<String, EventSchedule__c> dayWiseSlots = new MAP<String, EventSchedule__c>();
         
        for(EventSchedule__c es: attendeeSchedules){
          
          system.debug('TO INTEGRATION...........................    '+ eventDate );
          
            if(eventDate == null){
                eventDate = es.MM_slot_Date__c;
            }
            
            if(eventDate != es.MM_slot_Date__c){
                exibitorScheduleMAP.put(eventDate ,  dayWiseSlots);
                dayWiseSlots = new MAP<String, EventSchedule__c>();
                eventDate = es.MM_slot_Date__c;
            }
                 
             dayWiseSlots.put(es.MM_slot_StartTime__c,  es);
        }
        
        exibitorScheduleMAP.put(eventDate ,  dayWiseSlots);
        
             system.debug('INTEGRATION @@@@@@@@@@@@@@@@@@@@@@@@@@@@    '+ exibitorScheduleMAP);
             
        return exibitorScheduleMAP;
    }
    
    
    
    
    
    
    
    
    
    public static MAP<Date, MAP<String, EventSchedule__c>> exhibitorScheduleTimings(id eventId,id upeID){
          
          MAP<Date, MAP<String, EventSchedule__c>> exibitorScheduleMAP = new MAP<Date, MAP<String, EventSchedule__c>>();
        LIST<EventSchedule__c> boothAdminSchedules = new LIST<EventSchedule__c>();
       
       
       List<User_Profile_Event__c> upes = [select id from User_Profile_Event__c where Ev_id__c=:eventId and user_id__c=:upeID ];  
        
        string upevalue ='';
         if(upes.size()>0){
           upeforEventID =upes[0].id;
        }
       
       
       boothAdminSchedules = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                                    MM_Slot_End_Time__c, MM_To_UPE__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, OwnerID FROM EventSchedule__c 
                                    WHERE EV_id__c=: eventId AND MM_To_UPE__r.User_id__c =: upeID AND Is_Matchmaking__c = TRUE AND MM_Slot_Status__c !='Cancelled' AND MM_Slot_Status__c !='Rejected'
                                    ORDER BY MM_slot_Date__c, MM_slot_StartTime__c ];
      
       
       system.debug('TO INTEGRATION...........................    '+ upeforEventID );
         
         Date eventDate;
         MAP<String, EventSchedule__c> dayWiseSlots = new MAP<String, EventSchedule__c>();
         
        for(EventSchedule__c es: boothAdminSchedules){
          
          system.debug('TO INTEGRATION...........................    '+ eventDate );
          
            if(eventDate == null){
                eventDate = es.MM_slot_Date__c;
            }
            
            if(eventDate != es.MM_slot_Date__c){
                exibitorScheduleMAP.put(eventDate ,  dayWiseSlots);
                dayWiseSlots = new MAP<String, EventSchedule__c>();
                eventDate = es.MM_slot_Date__c;
            }
                 
             dayWiseSlots.put(es.MM_slot_StartTime__c,  es);
        }
        
        exibitorScheduleMAP.put(eventDate ,  dayWiseSlots);
        
             system.debug('INTEGRATION @@@@@@@@@@@@@@@@@@@@@@@@@@@@    '+ exibitorScheduleMAP);
             
        return exibitorScheduleMAP;
    }
    
    
    
    public static MAP<Date, LIST<String>> exhibitorTimings(id eventId,id upeID ){
        
        
        
        MAP<Date, LIST<String>>  eventTimings = new MAP<Date, LIST<String>>();
        eventTimings = giveEventTimingsWithDates(EventId, null );
        integer totalfreeSlots=0;
       
        
        system.debug('****************************************** '+ eventTimings);
        
        MAP<Date, LIST<String>> eventFreeSlots = new MAP<Date, LIST<String>>();
        
        
        MAP<Date, MAP<String, EventSchedule__c>> exibitorScheduleMAP = new MAP<Date, MAP<String, EventSchedule__c>>();
           
            
        exibitorScheduleMAP = exhibitorScheduleTimings(eventId, upeId);
        
        for(Date d :eventTimings.keySet()){
            
            LIST<String> originalDateWiseSlots = new LIST<String>();
            LIST<String> freeTimings = new LIST<String>();
            MAP<String, EventSchedule__c> bookedTimeSlotsByDate = new MAP<String, EventSchedule__c>();
            
            originalDateWiseSlots.addAll(eventTimings.get(d));
            
            if(exibitorScheduleMAP.containsKey(d)){
                bookedTimeSlotsByDate = exibitorScheduleMAP.get(d);
            }
             
             system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$     '+ originalDateWiseSlots.size() );
            
             system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     '+ totalfreeSlots +'    '+bookedTimeSlotsByDate );
            
            for(String s: originalDateWiseSlots){
                
                system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    '+ s );
            
                if(!bookedTimeSlotsByDate.containsKey(s.subString(0,s.lastIndexOf('-')))){
                    freeTimings.add(s);
                }
                
            }
            totalfreeSlots += freeTimings.size();
            
            eventFreeSlots.put(d, freeTimings);
            
            system.debug('##############################      '+ totalfreeSlots +'    '+freeTimings.size() );
        }
        
         
         system.debug('##############################@@@@      '+ totalfreeSlots );
        
         return eventFreeSlots;
        
    }
    
    
    public static MAP<Date, LIST<String>> giveEventTimingsWithDates(ID EventId, Date MLDate){
        system.debug('33333333333333333 ...........................    '+ upeforEventID );
        LIST<String> eventDateTimers = new LIST<String>();
        LIST<Event__c> selectedEvent = new LIST<Event__c>();
        MAP<Date, LIST<String>> dateWiseTimings = new MAP<Date, LIST<String>>(); 
        MAP<ID, MatchLeads_Days__c> MatchLeadsDays = new MAP<ID, MatchLeads_Days__c>();
          if(MLDate ==null){
            selectedEvent = [SELECT ID, NAME, 
                                    (SELECT ID, NAME,Start_time__c, End_Time__c, MatchLeads_Date__c, MAX_noOf_appontments__c, Slot_Time_period__c, Break_Time_between_slots__c
                                    FROM MatchLeads_Days__r)
                                    FROM Event__c WHERE ID=: EventId AND Is_MatchMaking_Event__c=: TRUE ];
        
        }else{
            selectedEvent = [SELECT ID, NAME, 
                                    (SELECT ID, NAME,Start_time__c, End_Time__c, MatchLeads_Date__c, MAX_noOf_appontments__c, Slot_Time_period__c, Break_Time_between_slots__c
                                    FROM MatchLeads_Days__r WHERE MatchLeads_Date__c =: MLDate )
                                    FROM Event__c WHERE ID=: EventId AND Is_MatchMaking_Event__c=: TRUE ];
        
        }
        
        for(Event__c ev: selectedEvent){
            for(MatchLeads_Days__c md: ev.MatchLeads_Days__r){
                MatchLeadsDays.put(md.Id, md);
            }
        }
        
        
       // string upe = '';
        
        
        
        //upeforEventID 
        
        MAP<ID, MatchLeads_Days__c> MatchLeadsDaysBreaks = new MAP<ID, MatchLeads_Days__c>([SELECT ID, NAME,Start_time__c, End_Time__c, MatchLeads_Date__c, 
                                    MAX_noOf_appontments__c, Slot_Time_period__c,Break_Time_between_slots__c,
                                    (SELECT ID, NAME, Break_Start_Time__c, Break_End_Time__c, Break_Title__c FROM Event_Breaks__r Where ( Break_Title__c != null ) ORDER BY Break_Start_Time__c)
                                    FROM MatchLeads_Days__c WHERE ID IN: MatchLeadsDays.KeySet() ]);
        
       
                                    
                                    
                  system.debug('BBBBBBBBBBBBBBBBB ................... '+upeforEventID );                  
                                    
                                    
         for(Event__c ev: selectedEvent){
            
            for(MatchLeads_Days__c md: ev.MatchLeads_Days__r){
              
                eventDateTimers = new LIST<String>();
                LIST<Event_Breaks__c> eventBreaks = new LIST<Event_Breaks__c>();
               system.debug('AAAAAAAAAAAAAAAAAa ................... '+ev );
                                  
                eventBreaks.addAll(MatchLeadsDaysBreaks.get(md.id).Event_Breaks__r );
               // eventBreaks.sort();
                
                system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEvents................... '+ eventBreaks);
                
                if(!eventBreaks.isEmpty()){  //Not Empty means having Breaks...................
                    
                //  if(md.Start_time__c < eventBreaks[0].Break_Start_Time__c ){
                        
                        String endTime = '';
                        String startTime = md.Start_time__c;
                        String slotTime = md.Slot_Time_period__c;
                        String slotGap = md.Break_Time_between_slots__c;
                        
                        for(Event_Breaks__c eb: eventBreaks){
                            endTime = eb.Break_Start_Time__c;
                             eventDateTimers.addAll(givesSlotTimings(startTime, endTime, slotTime, slotGap));
                            startTime = eb.Break_End_Time__c;
                        }
                         globalTimeConvertion tcon = new globalTimeConvertion();
                         System.debug('md.End_Time__c   '+md.End_Time__c +'  '+startTime); 
                         if(tcon.stringTotime(md.End_Time__c) > tcon.stringTotime(startTime)){
                            System.debug('XXXXXXXXXXXXXXXXXXXXXXX  ');
                            endTime = md.End_Time__c;
                            eventDateTimers.addAll(givesSlotTimings(startTime, endTime, slotTime, slotGap));
                         } 
                         
                      /*  if(md.End_Time__c > startTime){
                            endTime = md.End_Time__c;
                            eventDateTimers.addAll(givesSlotTimings(startTime, endTime, slotTime, slotGap));
                        }*/
                        
                //  }
                }else{                       //Empty means No Breaks so we will take Event Starting and Ending Timings...................
                    eventDateTimers.addAll(givesSlotTimings(md.Start_time__c, md.End_Time__c,md.Slot_Time_period__c, md.Break_Time_between_slots__c));
                }
                
                
                dateWiseTimings.put(md.MatchLeads_Date__c, eventDateTimers);
                
                
                system.debug('##############################@@@@123      '+ eventDateTimers.size() );
        
            }
        }
            //   (SELECT ID, NAME, Break_Start_Time__c, Break_End_Time__c, Break_Title__c FROM Event_Breaks__r)
        
        
        return dateWiseTimings;
        
    }
    

}