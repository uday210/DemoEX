public class matchleadschedulesforMBEcon {

        public LIST<MBESchedules> MatchLeadsschedules{get; set;}
        public String eventSelected{get;set;} 
        public list<Tags__c> tagslist {get; set ;}
        public string attendeealias {get ; set ;}
        public string exhibitoralias {get ; set ;}
        public Event__c attach{get;set;}



     public matchleadschedulesforMBEcon ()
     {
       attendeealias ='';
           exhibitoralias ='';      
                LIST<Event_Attendee_Mapping__c> MBEUsers = new LIST<Event_Attendee_Mapping__c>();
               Cookie k = ApexPages.currentPage().getCookies().get('counter');
               eventSelected = k.getValue();
                
                attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c,EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,Is_Webank_event__c from Event__c where id = : eventSelected];
                          
       
         MBEUsers=[Select u.AS_id__r.FullName__c,u.AS_id__r.Exhibitor_company_imageUrl__c, u.AS_id__r.AS_Company__c,u.AS_id__r.AS_WorkPhone__c,u.EV_id__c,u.MBE_Profile__r.FullName__c,u.MBE_Profile__r.AS_Email__c,u.MBE_Profile__r.AS_Company__c,
                   u.EV_id__r.EV_Title__c,  u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HistingAddr1__c,u.MBE_Profile__r.AS_FirstName__c,u.MBE_Profile__r.AS_LastName__c,u.MBE_Profile__r.AS_WorkPhone__c,
                   u.EV_id__r.AS_HostingCity__c, u.EV_id__r.EV_HostingState__c, u.EV_id__r.EV_HostingZipcode__c ,u.EV_id__r.EV_EventLogo__c,u.EV_id__r.Is_Webank_event__c,u.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                  (Select e.starttimein24hrs__c, e.SystemModstamp, e.OwnerId, e.Name, e.MM_slot_StartTime__c, e.MM_slot_Date__c, e.MM_To_UPE__c, 
                                    e.MM_To_EAM__c, e.MM_Slot_Time__c, e.MM_Slot_Status__c, e.MM_Slot_End_Time__c, e.MM_Slot_EndTime__c, e.Is_Matchmaking__c, 
                                    e.IsDeleted, e.Id, e.EV_id__c, e.ES_StartTime__c, e.ES_StartDate__c, e.ES_ProgramName__c, e.ES_Presenter__c, e.ES_Location__c, 
                                    e.ES_EndTime__c, e.ES_EndDate__c, e.ES_Description__c, e.CreatedDate, e.CreatedById, e.Comments__c, 
                                    e.MM_To_EAM__r.AS_id__r.AS_Company__c,e.MM_To_EAM__r.AS_id__r.FullName__c,e.MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_WorkPhone__c,e.MM_To_EAM__r.AS_id__r.AS_CellPhone__c, 
                                    e.EV_id__r.Is_Webank_event__c,
                                    e.MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,
                                    e.MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,
                                    e.MM_To_EAM__r.MBE_Profile__r.FullName__c,
                                    e.MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,
                                    e.MM_To_EAM__r.MBE_Profile__r.AS_Company__c,
                                    e.MM_To_EAM__r.MBE_Profile__r.AS_Email__c,
                                    e.MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                    e.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,
                                    e.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,
                                    e.MM_To_UPE__r.Attendee_Summary__r.FullName__c,
                                    e.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                    e.MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                    e.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,
                                    e.MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c                                    
                                    From EventSchedule__r e WHERE e.MM_Slot_Status__c='Accepted' ORDER BY e.MM_slot_Date__c, e.MM_slot_StartTime__c )
                                    From Event_Attendee_Mapping__c u WHERE Boothleads_Profile__c=:'Attendee' AND IsMatchMakingAttendee__c=:True AND Ev_id__c =: eventSelected ];
                                    
                            
                            MAP<Date , LIST<String>> getSlotsFromUtility = MM_Utility.giveEventTimingsWithDates(eventSelected ,null);
                            LIST<String> eventSchedules = new LIST<String>();
                           for(Date d: getSlotsFromUtility.keySet()){
                                eventSchedules.addAll(getSlotsFromUtility.get(d));        
                            }        
                             
                             
                   MatchLeadsschedules = new  LIST<MBESchedules>();  
                
                 for(Event_Attendee_Mapping__c u: mbeUsers){
                        
                        LIST<displaymbeSchedules> mbeBasedSchedules = new LIST<displaymbeSchedules>();
                        
                        
                        MAP<String, EventSchedule__c> mbeEventScheduleMap = new MAP<String, EventSchedule__c>();
                        
                        for(EventSchedule__c es: u.EventSchedule__r){
                                mbeEventScheduleMap.put( es.MM_slot_StartTime__c+'-'+  es.MM_Slot_End_Time__c , es  );
                        }
                        
                        for(String s: eventSchedules){
                                
                                if(mbeEventScheduleMap.containsKey(s)){
                                        mbeBasedSchedules.add(new displaymbeSchedules(s, mbeEventScheduleMap.get(s)));
                                }else{
                                        EventSchedule__c emptySchedule = new EventSchedule__c();
                                        mbeBasedSchedules.add(new displaymbeSchedules(s, emptySchedule));
                                }
                                
                        }
                        
                        
                        MatchLeadsschedules.add(new MBESchedules(u, mbeBasedSchedules));
                        
                        
                 }
                             
      tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventSelected];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
       
       }        
                                    
                         }




             public class displaymbeSchedules{
                
                public String slotTime{get; set;}
        //      public User_Profile_Event__c corporate{get; set;}
                public EventSchedule__c schedule{get; set;}
                public displaymbeSchedules(String scheduleTime, EventSchedule__c sch  ){
                slotTime = scheduleTime;
                schedule = sch;
                        
                        
                }
        }
        

    public class MBESchedules{
                public Event_Attendee_Mapping__c MBE{get; set;}
                public LIST<displaymbeSchedules> displaySchedules{get; set;}
                public MBESchedules( Event_Attendee_Mapping__c upp, LIST<displaymbeSchedules> sch ){
                MBE = upp;
                displaySchedules = new LIST<displaymbeSchedules>();
                displaySchedules = sch;
                        
                }
                
                
                
        }
        


}