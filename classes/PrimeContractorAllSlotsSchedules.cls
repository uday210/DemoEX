public with sharing class PrimeContractorAllSlotsSchedules {
        
        
        public LIST<CorporateSchedules> MatchLeadsschedules{get; set;}
        public String eventSelected{get;set;} 
        public list<Tags__c> tagslist {get; set ;}
        public string attendeealias {get ; set ;}
        public string exhibitoralias {get ; set ;}
        public Event__c attach{get;set;}
        
        public  PrimeContractorAllSlotsSchedules(){
           attendeealias ='';
           exhibitoralias ='';      
                LIST<User_Profile_Event__c> corporateUsers = new LIST<User_Profile_Event__c>();
               Cookie k = ApexPages.currentPage().getCookies().get('counter');
               eventSelected = k.getValue();
                
                attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c,EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c from Event__c where id = : eventSelected];
                          
                corporateUsers = [Select u.isFirstBoothAdmin__c, u.User_id__c, u.UEP_isActive__c, u.Status__c, 
                                u.Slot_Time_Interval__c, u.Request_for_upgrade_profile__c, u.Profile_id__c, u.OwnerId, u.Name, u.MM_TableNo__c, 
                                u.MAtchMakingProfile__c, u.IsMatchMakingUser__c, u.IsBoothPersonnel__c,u.Id, 
                                u.BT_id__r.BT_Name__c, u.EventAdmin_Id__c, u.EV_id__c, u.BoothAdmin_id__c,
                                u.EV_id__r.EV_Title__c,  u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HistingAddr1__c,u.EV_id__r.Is_Webank_event__c,
                                u.EV_id__r.AS_HostingCity__c, u.EV_id__r.EV_HostingState__c, u.EV_id__r.EV_HostingZipcode__c ,u.EV_id__r.EV_EventLogo__c,
                                u.Attendee_Summary__r.Exhibitor_company_imageUrl__c, u.Attendee_Summary__r.AS_Company__c, u.Attendee_Summary__r.FullName__c,
                                u.Attendee_Summary__r.AS_WorkPhone__c,u.BT_id__r.Table_Room_No__c, u.BT_id__r.MM_TableNo__c,u.BT_id__r.BT_Location__c,
                                (Select e.starttimein24hrs__c, e.SystemModstamp, e.OwnerId, e.Name, e.MM_slot_StartTime__c, e.MM_slot_Date__c, e.MM_To_UPE__c, 
                                e.MM_To_EAM__c, e.MM_Slot_Time__c, e.MM_Slot_Status__c, e.MM_Slot_End_Time__c, e.MM_Slot_EndTime__c, e.Is_Matchmaking__c, 
                                e.IsDeleted, e.Id, e.EV_id__c,e.EV_id__r.Is_Webank_event__c, e.ES_StartTime__c, e.ES_StartDate__c, e.ES_ProgramName__c, e.ES_Presenter__c, e.ES_Location__c, 
                                e.ES_EndTime__c, e.ES_EndDate__c, e.ES_Description__c, e.CreatedDate, e.CreatedById, e.Comments__c,e.MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,e.MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,e.MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,e.MM_To_EAM__r.MBE_Profile__r.FullName__c,
                                e.MM_To_EAM__r.MBE_Profile__r.AS_Email__c,e.MM_To_EAM__r.MBE_Profile__r.AS_Company__c,e.MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c, 
                                e.MM_To_EAM__r.AS_id__r.AS_Company__c,e.MM_To_EAM__r.AS_id__r.FullName__c,e.MM_To_EAM__r.AS_id__r.AS_Email__c, e.MM_To_EAM__r.AS_id__r.AS_CellPhone__c From EventSchedule__r e WHERE e.MM_Slot_Status__c='Accepted' ORDER BY e.MM_slot_Date__c, e.MM_slot_StartTime__c )
                  FROM User_Profile_Event__c u WHERE MAtchMakingProfile__c ='Corporate'  AND Ev_id__c =: eventSelected   ];
                        
                 
                MAP<Date , LIST<String>> getSlotsFromUtility = MM_Utility.giveEventTimingsWithDates(eventSelected ,null);
                LIST<String> eventSchedules = new LIST<String>();
                for(Date d: getSlotsFromUtility.keySet()){
                   eventSchedules.addAll(getSlotsFromUtility.get(d));
                }
                
                
                
                MatchLeadsschedules = new  LIST<CorporateSchedules>();  
                
                 for(User_Profile_Event__c u: corporateUsers){
                        
                        LIST<displayUPESchedules> upeBasedSchedules = new LIST<displayUPESchedules>();
                        
                        
                        MAP<String, EventSchedule__c> upeEventScheduleMap = new MAP<String, EventSchedule__c>();
                        
                        for(EventSchedule__c es: u.EventSchedule__r){
                                upeEventScheduleMap.put( es.MM_slot_StartTime__c+'-'+  es.MM_Slot_End_Time__c , es  );
                        }
                        
                        for(String s: eventSchedules){
                                
                                if(upeEventScheduleMap.containsKey(s)){
                                        upeBasedSchedules.add(new displayUPESchedules(s, upeEventScheduleMap.get(s)));
                                }else{
                                        EventSchedule__c emptySchedule = new EventSchedule__c();
                                        upeBasedSchedules.add(new displayUPESchedules(s, emptySchedule));
                                }
                                
                        }
                        
                        
                        MatchLeadsschedules.add(new CorporateSchedules(u, upeBasedSchedules));
                        
                        
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
        
        
        public class displayUPESchedules{
                
                public String slotTime{get; set;}
        //      public User_Profile_Event__c corporate{get; set;}
                public EventSchedule__c schedule{get; set;}
                
                
                public displayUPESchedules(String scheduleTime, EventSchedule__c sch  ){
                        
                        slotTime = scheduleTime;
                         
                        schedule = sch;
                        
                        
                }
        }
        
        public class CorporateSchedules{
                public User_Profile_Event__c corporate{get; set;}
                public LIST<displayUPESchedules> displaySchedules{get; set;}
                
                public CorporateSchedules( User_Profile_Event__c upp, LIST<displayUPESchedules> sch ){
                        
                        corporate = upp;
                        displaySchedules = new LIST<displayUPESchedules>();
                        displaySchedules = sch;
                        
                }
                
                
                
        }
        
        
        

}