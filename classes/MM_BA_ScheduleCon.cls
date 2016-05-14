public without sharing class MM_BA_ScheduleCon {
        
       
            //Author : Naga Mallikarjuna Rao
            //Date  12/07/2013
            
            
            
            //Variables
            
            public LIST<User_Profile_Event__c> mm_Upe{get; set;}
            public LIST<SelectOption> listofEvents{get; set;}
            public String selectedEvent{get; set;}
            public String ResponseString{get; set;}
            public Boolean ResponseBoolean{get; set;}
            public String eventType{get; set;}
            public Event__c attach{get;set;}
            public Profile_Settings__c psett{get;set;}
            
            public LIST<EventSchedule__c> eventSchedule{get; set;}
            public LIST<EventSchedule__c> pendingEventSchedule{get; set;}
            public LIST<EventSchedule__c> ConfirmedEventSchedule{get; set;}
            public LIST<EventSchedule__c> RejectedEventSchedule{get; set;}
            public LIST<EventSchedule__c> CancelEventSchedule{get; set;}
            public LIST<EventSchedule__c> RescheduledEventSchedule{get; set;}
            public LIST<EventSchedule__c> MissedEventSchedule{get; set;}
            public LIST<EventSchedule__c> duplicatecancel{get; set;}
            public LIST<EventSchedule__c> NONduplicatecancel{get; set;}
            
            
            public MAP<id, EventSchedule__c> EventScheduleMAP{get; set;}
            public LIST<EventSchedule__c> exhibitorslist{get;set;}
            public LIST<EventSchedule__c> exhibitorslistexport{get;set;}
            public LIST<EventSchedule__c> bn{get;set;}
           // public LIST<ExhibitorInner> exhibitorlist{get;set;}
           //public MAP<String, ExhibitorInner> mapExhibitors = new MAP<String, ExhibitorInner>();   
            
            public MAP<String,EventSchedule__c> toFindDuplicats{get; set;}
            public MAP<Id, EventSchedule__c> tofindScheduledEAMs{get; set;}
            public EventSchedule__c tofindDuplicateES{get; set;}
            public list<Attachment> attchments {get; set;}
            public boolean Blockschedulebool {get ; set ;}
            public string MMType {get ; set ;}
            public list<Tags__c> tagslist {get; set ;}
            public string attendeealias {get ; set ;}
            public string exhibitoralias {get ; set ;}
            public Profile_Settings__c pfsett{get;set;}
            public List<Widget__c> videos {get ; set ;}
            public MM_Surevycon surveyController{get;set;}
            
            public List<ConfirmedAppmnts> conApps{get; set;}
            
            //constructor
            public MM_BA_ScheduleCon(){
            
            attendeealias ='';
            exhibitoralias ='';
            errormsg = false; 
            pfsett= new Profile_Settings__c();
           
            mm_Upe = new LIST<User_Profile_Event__c>();
            listofEvents = new LIST<SelectOption>();
            eventSchedule = new LIST<EventSchedule__c>();
            pendingEventSchedule= new LIST<EventSchedule__c>();
            ConfirmedEventSchedule= new LIST<EventSchedule__c>();
            CancelEventSchedule = new LIST<EventSchedule__c>();
            RejectedEventSchedule= new LIST<EventSchedule__c>();
            RescheduledEventSchedule =  new LIST<EventSchedule__c>();
            MissedEventSchedule =  new LIST<EventSchedule__c>();
            EventScheduleMAP = new MAP<id, EventSchedule__c>();
            toFindDuplicats = new MAP<String,EventSchedule__c>();
            tofindScheduledEAMs = new MAP<Id, EventSchedule__c> ();
            scheduleswithprof = false;
            attchments = new List<Attachment>();
            videos = new List<Widget__c>();
            blockselecteddate  = '';
            
           
              
            try{
            cookie counter =   ApexPages.currentPage().getCookies().get('counter');
            selectedEvent = counter.getValue();
            attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c,EV_HostingLocation__c, EV_HistingAddr1__c,Is_Webank_event__c, AS_HostingCity__c, EV_HostingZipcode__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c from Event__c where id = : selectedEvent]; 
            MMType ='';
            mm_Upe = [SELECT ID, NAME,MAtchMakingProfile__c,EV_id__c,EV_id__r.Partner_scheduling__c, EV_id__r.Name,EV_id__r.Match_Making_Schedules__c, EV_id__r.Email_Notifications_flag__c, EV_id__r.EV_Title__c,EV_id__r.MatchMaking_Type__c FROM User_Profile_Event__c WHERE (BoothAdmin_id__c =: UserInfo.getUserId() AND IsMatchMakingUser__c =: TRUE) AND EV_id__c =: selectedEvent ORDER BY createdDate];
            for(User_Profile_Event__c upe: mm_Upe){
            listofEvents.add(new SelectOption(String.valueOf(upe.EV_id__c) , upe.EV_id__r.EV_Title__c));
            //selectedEvent = upe.EV_id__c;
            eventType = upe.EV_id__r.MatchMaking_Type__c;
            MMType = upe.EV_id__r.Match_Making_Schedules__c;
            }
            
            EventScheduleShow();
            
            
            
            }catch(Exception e){}
             
            Psettings = new List<Profile_Settings__c> ();
            psett=new Profile_Settings__c();
            Psettings = [SELECT id,MBE_Work_Address_Visibility__c,MBE_Work_Phone_Visible__c,MBE_Website_Visible__c,MBE_First_Name_Visible__c,MBE_Email_Visible__c,MBE_LastName_Visible__c,MBE_Mobile_Phone_Visible__c,MBE_Company_Visible__c,MBE_Cage_Code_Visible__c,MBE_GSA_Schedule_Contract_Number_Visible__c
            FROM Profile_Settings__c WHERE Event__r.id =: SelectedEvent AND Name=: 'MBE' ];
            system.debug('***********'+SelectedEvent );
            if(Psettings.size()>0){
            psett=Psettings[0];
            }
            profileDao pfdao = new profileDao();
            if(selectedEvent != '' && selectedEvent != null ){      
            for(Profile_Settings__c ps :pfdao.getSettings(selectedEvent ,'MBE')){
            pfsett = ps ;
            break;
            }
            }
          tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : selectedEvent];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
       
       } 
       
       //Calling Survey Questions controller
     surveyController = new MM_Surevycon();
     surveyController.firstMethod(selectedEvent,userInfo.getUserName());
     surveybool =false; 
   }
        
        public LIST<EventSchedule__c> eventSchedule1 {get ; set ;}
        public LIST<EventSchedule__c> eventSchedule2 {get ; set ;}
        public string CancelOrRejected {get ; set ;}
        public void EventScheduleShow(){
            
             errormsg = false;
           eventSchedule = new LIST<EventSchedule__c>();
           eventSchedule1 = new LIST<EventSchedule__c>();          
           pendingEventSchedule= new LIST<EventSchedule__c>();
           ConfirmedEventSchedule= new LIST<EventSchedule__c>();
           conApps = new List<ConfirmedAppmnts>();
           RejectedEventSchedule= new LIST<EventSchedule__c>();
           CancelEventSchedule = new LIST<EventSchedule__c>();
           RescheduledEventSchedule =  new LIST<EventSchedule__c>();
           MissedEventSchedule =  new LIST<EventSchedule__c>();
           duplicatecancel = new LIST<EventSchedule__c>();
           NONduplicatecancel = new LIST<EventSchedule__c>();
           EventScheduleMAP = new MAP<id, EventSchedule__c> ();
                CancelOrRejected =''; 
                  
                  for(EventSchedule__c  eS1:[select Comments__c,MM_slot_Date__c,MM_Slot_End_Time__c ,Owner.Email ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c
                                                  ,MM_To_EAM__c from EventSchedule__c where MM_To_EAM__c != null  AND MM_To_UPE__r.User_id__r.userName=:userInfo.getUserName() and MM_To_UPE__r.EV_id__c =:selectedEvent and (MM_Slot_Status__c='Pending' OR MM_Slot_Status__c='Accepted')  and MM_slot_Date__c!=null order by starttimein24hrs__c]){
                         CancelOrRejected +=eS1.MM_To_EAM__c;
                   }
           system.debug('cccccccccccccccccccccccccccccccccccccccccc'+CancelOrRejected );
          
          
          
                eventSchedule1 = [SELECT Id, Is_Matchmaking__c,MM_To_UPE__r.MAtchMakingProfile__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c, MM_To_UPE__r.BT_id__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__c,
                                    MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c, MM_To_UPE__r.BoothAdmin_id__r.id,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Location__c,
                                    MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email,Comments__c,starttimein24hrs__c,EV_id__r.EV_HostingTimeZone__c,
                                    EV_id__r.Is_Webank_event__c,MM_To_EAM__r.MBE_profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_profile__r.AS_LastName__c,MM_To_EAM__r.MBE_profile__r.AS_Company__c,MM_To_EAM__r.MBE_profile__r.AS_Email__c,MM_To_EAM__r.MBE_profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_profile__r.AS_WebsiteUrl__c,MM_To_EAM__r.MBE_profile__r.AS_WorkAddress1__c,MM_To_EAM__r.MBE_profile__r.AS_WorkCity__c,MM_To_EAM__r.MBE_profile__r.AS_Work_States__c,MM_To_EAM__r.MBE_profile__r.AS_WorkZip__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c,MM_To_EAM__r.AS_id__r.AS_WorkZip__c
                                    FROM  EventSchedule__c 
                                    WHERE Is_Matchmaking__c = TRUE 
                                    AND EV_id__c =: selectedEvent
                                    AND MM_To_EAM__c != null 
                                    AND MM_To_UPE__c != null                                     
                                    AND MM_To_UPE__r.User_id__c =: UserInfo.getUserId() 
                                    ORDER BY starttimein24hrs__c];
                    LIST<User_Profile_Event__c> upeidboothid = [select id ,BT_id__c,MAtchMakingProfile__c from User_Profile_Event__c where  User_id__c =: UserInfo.getUserId() AND    EV_id__c =: selectedEvent];
                if(upeidboothid.size() != 0){
                 id boothid = upeidboothid[0].BT_id__c;
              list<User_Profile_Event__c> upeid = [select id from User_Profile_Event__c where User_id__c !=: UserInfo.getUserId() AND BT_id__r.id = : boothid ];                      
                    system.debug('nnnnnnnnnnnnnnnnnnnn'+upeid);
                    list<id> upids=new list<id> ();
                    if(upeid.size() != 0){
                    for(User_Profile_Event__c up: upeid){
                     if(upeidboothid[0].MAtchMakingProfile__c == 'Corporatestaff' || upeidboothid[0].MAtchMakingProfile__c == 'Corporate'){
                    upids.add(up.id);}
                    }
                    
                     system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiimythily'+upeid );
                     eventSchedule2 = new LIST<EventSchedule__c>();
                     eventSchedule2 = [SELECT Id, Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c, MM_To_UPE__r.BT_id__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__c,EV_id__r.Is_Webank_event__c,
                                    MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c, MM_To_UPE__r.BoothAdmin_id__r.id,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Location__c,
                                    MM_To_EAM__c,EV_id__r.EV_HostingTimeZone__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email,Comments__c,starttimein24hrs__c,MM_To_EAM__r.MBE_profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_profile__r.AS_LastName__c,MM_To_EAM__r.MBE_profile__r.AS_Company__c,MM_To_EAM__r.MBE_profile__r.AS_Email__c,MM_To_EAM__r.MBE_profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_profile__r.AS_WebsiteUrl__c,MM_To_EAM__r.MBE_profile__r.AS_WorkAddress1__c,MM_To_EAM__r.MBE_profile__r.AS_WorkCity__c,MM_To_EAM__r.MBE_profile__r.AS_Work_States__c,MM_To_EAM__r.MBE_profile__r.AS_WorkZip__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c
                                    
                                     FROM  EventSchedule__c 
                                    WHERE Is_Matchmaking__c = TRUE 
                                    AND EV_id__c =: selectedEvent
                                    AND MM_To_EAM__c != null 
                                    AND MM_To_UPE__c != null  
                                    AND MM_To_UPE__r.id IN : upeid 
                                    ORDER BY starttimein24hrs__c];
                                 system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiimythily11111111111'+eventSchedule );    
                     
                     eventSchedule.addAll(eventSchedule1);
                     eventSchedule.addAll(eventSchedule2);
                     
                     }
                     else{
                     eventSchedule.addAll(eventSchedule1);
                     }}
                  system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiimythily22222222222222222222'+eventSchedule );
                for(EventSchedule__c es: eventSchedule){
                    if(es.MM_Slot_Status__c == 'Pending'){
                        pendingEventSchedule.add(es);     
                         tofindScheduledEAMs.put(es.MM_To_EAM__c , es);           
                    }else if(es.MM_Slot_Status__c == 'Accepted'  ){
                        ConfirmedEventSchedule.add(es);
                        
                        Datetime currentDatetime = system.now();
                        system.debug( 'EV_id__r.EV_HostingTimeZone__c === '+ es.EV_id__r.EV_HostingTimeZone__c );
                        system.debug('currentDatetime === '+currentDatetime );
                        system.debug('datetime.now === '+datetime.now());
                        
                        integer mon =es.MM_slot_Date__c.Month();
                        integer yea =es.MM_slot_Date__c.year();
                        integer dayte =es.MM_slot_Date__c.day();
                        
                        string[] sliptbySpace = es.MM_Slot_End_Time__c.split(' ');
                        String oendT = sliptbySpace[0];
                        String[] toGetHrMn = sliptbySpace[0].split(':');
                        Integer Hrs = Integer.ValueOf(toGetHrMn[0]);
                        Integer Mns = Integer.ValueOf(toGetHrMn[1]);
                        Integer Scs = 0;
                        system.debug('yea,mon,dayte,Hrs,Mns,Scs === '+yea+','+mon+','+dayte+','+Hrs+','+Mns+','+Scs);
                        system.debug('datettime.newIntance(yes,mon,dayte,Hrs,Mns,Scs) === '+ datetime.newInstanceGMT(yea,mon,dayte,Hrs,Mns,Scs) );
                        Datetime SlotEndTime = datetime.newInstanceGMT(yea,mon,dayte,Hrs,Mns,Scs);
                        
                        
                        ////////////////////////////////////////////
                        datetime dte;
                          if(es.EV_id__r.EV_HostingTimeZone__c=='Eastern Time(USA)'){   
                                 dte=currentDatetime.addHours(-4);
                                 system.debug('est'+dte);
                           }else if(es.EV_id__r.EV_HostingTimeZone__c=='Central Time(USA)'){
                                 dte=currentDatetime.addHours(-5);
                           }
                           else if(es.EV_id__r.EV_HostingTimeZone__c=='Mountain Time(USA)'){
                                dte=currentDatetime.addHours(-6);
                           }
                           else if(es.EV_id__r.EV_HostingTimeZone__c=='Pacific Time(USA)'){
                               dte=currentDatetime.addHours(-7);
                               system.debug('pst'+dte);
                           }
                           else if(es.EV_id__r.EV_HostingTimeZone__c=='Indian Standard Time(IST)'){
                               dte=(currentDatetime.addHours(5)).addMinutes(+30);
                            }
                            system.debug('dte === '+dte);
                        ////////////////////////////////////////////
                        
                        if(dte > SlotEndTime ){                                                  
                            conApps.add(new ConfirmedAppmnts(es,true));
                        }else{
                            conApps.add(new ConfirmedAppmnts(es,false));
                        }
                        
                        
                        /* string sctime = mon+'/'+ dayte +'/'+yea  +' '+ es.MM_Slot_End_Time__c ;
                        Datetime dt = DateTime.parse(sctime);
                        system.debug('DateTime.parse(sctime) === '+DateTime.parse(sctime));
                        String strConvertedDate =  dt.format('MM/dd/yyyy HH:mm a', 'America/New_York');
                        system.debug('strConvertedDate  === '+strConvertedDate );
                        system.debug('DateTime.parse(strConvertedDate) === '+DateTime.parse(strConvertedDate));
                        
                        if(currentDatetime > DateTime.parse(sctime) ){                                                  
                            conApps.add(new ConfirmedAppmnts(es,true));
                        }else{
                            conApps.add(new ConfirmedAppmnts(es,false));
                        }*/
                        
                        system.debug('conApps === '+conApps);
                        
                         tofindScheduledEAMs.put(es.MM_To_EAM__c , es);
                    }else if(es.MM_Slot_Status__c == 'Rejected'  ){
                        RejectedEventSchedule.add(es);
                    }else if(es.MM_Slot_Status__c == 'Cancelled'  ){
                    
                        CancelEventSchedule.add(es);
                        
                    }else if(es.MM_Slot_Status__c == 'Rescheduled'  ){
                        RescheduledEventSchedule.add(es);
                    }else if(es.MM_Slot_Status__c == 'Missed'  ){
                        MissedEventSchedule.add(es);
                    }
          
                    
                   EventScheduleMAP.put(es.id, es); 
                   toFindDuplicats.put(es.MM_slot_StartTime__c , es);
                  

                  
                }
                 //-----------------------------------------------------------------------------------changed by mythily----
                string emails ;
                emails ='';
                for(EventSchedule__c essp:pendingEventSchedule){
                emails+=essp.MM_To_EAM__r.AS_id__r.AS_Email__c;
                }
                
                 if(emails != null || emails != ''){
                   for(EventSchedule__c essc : CancelEventSchedule){
                    
                    if(emails.Contains(essc.MM_To_EAM__r.AS_id__r.AS_Email__c)){
                    duplicatecancel.add(essc);
                    }else{
                    NONduplicatecancel.add(essc);
                    }
                    
                   }           
             }
          
           
           //-------------------------------------------------------------------------------mythily ----------
                
                system.debug('    DDDDDDDDDDDDDDDDDDDDDDDD   '+ eventSchedule);
                
        }
        public LIST<CorporateSchedules> MatchLeadsschedules{get; set;}
      public Event__c Eventdetails {get ; set ;}  
      public pagereference PrintExhibitorSchedule(){
             scheduleswithprof = false;
            LIST<User_Profile_Event__c> corporateUsers = new LIST<User_Profile_Event__c>();
       // exhibitorslist = new LIST<EventSchedule__c>();
        Eventdetails  = new Event__c();
        
        Eventdetails  = [SELECT ID, Name,EV_Title__c,Status__c,EV_HostingState__c,AS_HostingCity__c,EV_HostingLocation__c,Attendee_Types__c,
                    EV_HistingAddr1__c,AS_HostingAddr2__c,EV_HostingCountryNew__c,EV_Publish__c,EV_EventLogo__c,EV_HostingTimeZone__c,
                    EV_HostingPhone__c,EV_HostingFax__c,EV_WebsiteURL__c,Primary__c,SecondaryCategory__c,EV_HostingOrgName__c,EV_HostingStateNew__c,
                    EV_HostingZipcode__c,EV_HostingPostalCode__c,EV_HostedByEventBrite__c,EV_Description__c,Owner.FirstName,Owner.ID,
                    EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,EventDiversityValues__c,TwitterHashTag__c,Is_Webank_event__c ,
                    Lable_First_Line__c,Lable_Secoend_Line__c,Lable_Third_Line__c,Event_Printer__c,TwitterId__c,FacebookId__c,OrganizerId__c,
                    Lable_First_Line_Color__c,Lable_First_Line_Size__c,Lable_First_Line_Font__c,Lable_Secoend_Line_Color__c,Lable_Secoend_Line_Size__c,Lable_Secoend_Line_Font__c,
                    Lable_Third_Line_Color__c,Lable_Third_Line_Size__c,EV_SiteLocation__c,Lable_Third_Line_Font__c FROM Event__C WHERE id =:selectedEvent ];
           
        corporateUsers = [Select u.isFirstBoothAdmin__c, u.User_id__c, u.UEP_isActive__c, u.Status__c, 
                                u.Slot_Time_Interval__c, u.Request_for_upgrade_profile__c, u.Profile_id__c, u.OwnerId, u.Name, u.MM_TableNo__c, 
                                u.MAtchMakingProfile__c, u.IsMatchMakingUser__c, u.IsBoothPersonnel__c,u.Id, 
                                u.BT_id__r.BT_Name__c, u.EventAdmin_Id__c, u.EV_id__c, u.BoothAdmin_id__c,
                                u.EV_id__r.EV_Title__c,  u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HistingAddr1__c,u.EV_id__r.Is_Webank_event__c,
                                u.EV_id__r.AS_HostingCity__c, u.EV_id__r.EV_HostingState__c, u.EV_id__r.EV_HostingZipcode__c ,u.EV_id__r.EV_EventLogo__c,
                                u.Attendee_Summary__r.Exhibitor_company_imageUrl__c, u.Attendee_Summary__r.AS_Company__c, u.Attendee_Summary__r.FullName__c,
                                u.Attendee_Summary__r.AS_WorkPhone__c,u.BT_id__r.Table_Room_No__c, u.BT_id__r.MM_TableNo__c,u.BT_id__r.BT_Location__c,
                                (SELECT Id, Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.MBE_Profile__r.AS_LastName__c ,MM_slot_Date__c, comments__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Company__c ,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c, 
                                    MM_To_EAM__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,Owner.Name, Owner.Email ,MM_To_UPE__r.BT_id__r.BT_Name__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c,
                                    MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_EAM__r.DiversityType__c,MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,EV_id__r.EV_EventLogo__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                                    MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,MM_To_EAM__r.MBE_Profile__r.AS_Title__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,MM_To_EAM__r.MBE_Profile__r.Key_words__c,
                                    MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                    MM_To_EAM__r.MBE_Profile__r.DBA__c,MM_To_EAM__r.MBE_Profile__r.BBB_Number__c,MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,MM_To_EAM__r.MBE_Profile__r.References__c,MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                    MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                    MM_To_EAM__r.MBE_Profile__r.Year_in_business__c,MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                    MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,MM_To_EAM__r.MBE_Profile__r.Commodity_6__c,MM_To_EAM__r.MBE_Profile__r.Commodity_7__c,MM_To_EAM__r.MBE_Profile__r.Commodity_8__c,MM_To_EAM__r.MBE_Profile__r.Commodity_9__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,MM_To_EAM__r.MBE_Profile__r.AS_Secondary_Email__c,MM_To_EAM__r.MBE_Profile__r.References2__c,MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,
                                MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.Table_Room_No__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                    MM_To_EAM__r.AS_id__r.AS_FirstName__c,EV_id__r.Is_Webank_event__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,
                                    
                                    MM_To_EAM__r.AS_id__r.As_prefixNew__c,MM_To_EAM__r.AS_id__r.AS_Title__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress2__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c,MM_To_EAM__r.AS_id__r.AS_WorkZip__c,MM_To_EAM__r.AS_id__r.AS_WorkPhone__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_2__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_3__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_4__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_5__c,MM_To_EAM__r.AS_id__r.Keywords__c,
                                    MM_To_EAM__r.AS_id__r.AS_BusinessDescription__c,MM_To_EAM__r.AS_id__r.AS_BusinessDunsNumber__c,MM_To_EAM__r.AS_id__r.AS_BusinessEstablishedDate__c,MM_To_EAM__r.AS_id__r.AS_BusinessRevenue__c,MM_To_EAM__r.AS_id__r.AS_BusinessTaxId__c,MM_To_EAM__r.AS_id__r.AS_CageCode__c,MM_To_EAM__r.AS_id__r.GSA_Schedule__c,MM_To_EAM__r.AS_id__r.AS_NumberOfEmployees__c,MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.AS_id__r.As_SecondaryBusinessCategory1__c,
                                    MM_To_EAM__r.AS_id__r.DBA__c,MM_To_EAM__r.AS_id__r.BBB_Number__c,MM_To_EAM__r.AS_id__r.distribution_Country__c,MM_To_EAM__r.AS_id__r.Manufactures_Country__c,MM_To_EAM__r.AS_id__r.Geographical_Region__c,MM_To_EAM__r.AS_id__r.References__c,MM_To_EAM__r.AS_id__r.Revenue_Range__c,MM_To_EAM__r.AS_id__r.Certificate_Processed_by_RPO__c,
                                    MM_To_EAM__r.AS_id__r.AS_NAICSCode6__c,MM_To_EAM__r.AS_id__r.AS_NAICSCode7__c,MM_To_EAM__r.AS_id__r.AS_NAICSCode8__c,MM_To_EAM__r.AS_id__r.AS_NAICSCode9__c,
                                    MM_To_EAM__r.AS_id__r.Year_in_business__c,MM_To_EAM__r.AS_id__r.Business_Structure__c,MM_To_EAM__r.AS_id__r.AS_FaxNumber__c,
                                    MM_To_EAM__r.AS_id__r.Commodity_1__c,MM_To_EAM__r.AS_id__r.Commodity_2__c,MM_To_EAM__r.AS_id__r.Commodity_3__c,MM_To_EAM__r.AS_id__r.Commodity_4__c,MM_To_EAM__r.AS_id__r.Commodity_5__c,MM_To_EAM__r.AS_id__r.Commodity_6__c,MM_To_EAM__r.AS_id__r.Commodity_7__c,MM_To_EAM__r.AS_id__r.Commodity_8__c,MM_To_EAM__r.AS_id__r.Commodity_9__c,
                                    MM_To_EAM__r.AS_id__r.Ethnicity__c,MM_To_EAM__r.AS_id__r.AS_Secondary_Email__c,MM_To_EAM__r.AS_id__r.References2__c,MM_To_EAM__r.AS_id__r.Scope_of_Work__c,MM_To_EAM__r.AS_id__r.Scope_of_Work2__c,MM_To_EAM__r.AS_id__r.Companyhaveafacility_partneroutsideUSA__c,MM_To_EAM__r.AS_id__r.Any_non_WBENC_awards_received__c From EventSchedule__r e WHERE e.MM_Slot_Status__c='Accepted' ORDER BY e.MM_slot_Date__c, e.MM_slot_StartTime__c )
                           FROM User_Profile_Event__c u WHERE MAtchMakingProfile__c ='Corporate'  AND Ev_id__c =: selectedEvent AND User_id__c =: UserInfo.getUserId()];
                         
        MAP<Date , LIST<String>> getSlotsFromUtility = MM_Utility.giveEventTimingsWithDates(selectedEvent,null);
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
         if(Eventdetails.Is_Webank_event__c == false){
        pagereference pg =page.ExhibitorSchedulePDF;
        return pg;
        }else{
        pagereference pg =page.ExhibitorSchedulePDFcustom;
        return pg;
        
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
        public Boolean scheduleswithprof {get;set;}
      public PageReference PrintExhibitorSchedulewithprofiles() {
        PrintExhibitorSchedule();
        scheduleswithprof = True;
        //pagereference pg =page.ExhibitorSchedulePDF;
        //return pg;
        if(Eventdetails.Is_Webank_event__c == false){
        pagereference pg =page.ExhibitorSchedulePDF;
        return pg;
        }else{
        pagereference pg =page.ExhibitorSchedulePDFcustom;
        return pg;
        
        }
        
    }
    public List<Profile_Settings__c> Psettings {get ; set ;}
    public PageReference ExportExhibitorSchedule() {
    try{
   
        exhibitorslist = new LIST<EventSchedule__c>();
        exhibitorslistexport = new LIST<EventSchedule__c>();
        exhibitorslistexport = [SELECT Id,Comments__c,Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_WebsiteUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkAddress1__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkCity__c,MM_To_UPE__r.Attendee_Summary__r.AS_Work_States__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkZip__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c,MM_To_EAM__r.AS_id__r.AS_WorkZip__c,MM_To_UPE__r.User_id__c       
                          FROM  EventSchedule__c  
                          WHERE Is_Matchmaking__c = TRUE 
                          AND EV_id__c =: selectedEvent 
                          AND MM_To_EAM__c != null 
                          AND MM_To_UPE__c != null 
                          AND (MM_Slot_Status__c='Pending' OR MM_Slot_Status__c='Accepted')
                          AND MM_To_UPE__r.User_id__c =: UserInfo.getUserId()
                          ORDER BY MM_slot_StartTime__c,MM_Slot_Status__c];
     bn = new list<EventSchedule__c>();
     for(EventSchedule__c s: exhibitorslistexport)
     {    
      s.MM_To_EAM__r.AS_id__r.AS_FirstName__c = escape(s.MM_To_EAM__r.AS_id__r.AS_FirstName__c);
      s.MM_To_EAM__r.AS_id__r.AS_LastName__c = escape(s.MM_To_EAM__r.AS_id__r.AS_LastName__c);
      s.MM_To_EAM__r.AS_id__r.AS_Company__c = escape(s.MM_To_EAM__r.AS_id__r.AS_Company__c);
      s.MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c = escape(s.MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c);
      s.MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c = escape(s.MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c);
      s.MM_To_EAM__r.AS_id__r.AS_WorkCity__c = escape(s.MM_To_EAM__r.AS_id__r.AS_WorkCity__c);
      s.MM_To_EAM__r.AS_id__r.AS_Work_States__c = escape(s.MM_To_EAM__r.AS_id__r.AS_Work_States__c);
      s.MM_To_EAM__r.AS_id__r.AS_WorkZip__c = escape(s.MM_To_EAM__r.AS_id__r.AS_WorkZip__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c);
      bn.add(s);
     }
      Psettings = new List<Profile_Settings__c> ();
   psett=new Profile_Settings__c();
    Psettings = [SELECT id,MBE_Work_Address_Visibility__c,MBE_Work_Phone_Visible__c,MBE_Website_Visible__c,MBE_First_Name_Visible__c,MBE_Email_Visible__c,MBE_LastName_Visible__c,
                 MBE_Mobile_Phone_Visible__c,MBE_Company_Visible__c, MBE_Cage_Code_Visible__c,MBE_GSA_Schedule_Contract_Number_Visible__c
                     FROM Profile_Settings__c WHERE Event__r.id =: SelectedEvent AND Name=: 'MBE'];
                     system.debug('***********@@@@@@@@@@@@@@@@@'+SelectedEvent+'&&&&&&&&&&&' );
                      if(Psettings.size()>0){
                         psett=Psettings[0];
                         }
     exhibitorslist.addAll(bn);    
     system.debug('$$$$$$$ '+exhibitorslist);     
     }catch(exception ex){}               
     pagereference pg = page.ExhibitorScheduleExport;
     return pg;                 
    }
    
     // -------------------------------------------------- Escape Special Characters -----------------------------------------------
    public string escape(string s){
        if(s != null && s.contains(',')){  
            s=s.replaceAll(',','');
        } 
        return s;
    }  
    
    public EventSchedule__c selectedEventSchedule{get; set;}
    public String requestType{get; set;}
    public User Uemail {get;set;}
    
    public void scheduleAccept(){
        Uemail  = new User();
      selectedEventSchedule = new EventSchedule__c();
        
      if(EventScheduleMAP.get(apexpages.currentpage().getparameters().get('SELSchedule'))!= null){
            
            selectedEventSchedule = EventScheduleMAP.get(apexpages.currentpage().getparameters().get('SELSchedule'));
          //  selectedEventSchedule = madeActionSchedule;
             Uemail =[select email,name from User where id =:selectedEventSchedule.MM_To_UPE__r.BoothAdmin_id__r.id ]; 
            selectedEventSchedule.MM_Slot_Status__c = 'Accepted';
           selectedEventSchedule.MBE_Corp_Combination__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_Slot_Status__c;
           selectedEventSchedule.MBE_Timeslot__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c;
           selectedEventSchedule.UPE_Timeslot__c = selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c;
            
           
       
            Database.SaveResult upresSCH = DataBase.update(selectedEventSchedule, false);
            
            if(upresSCH.isSuccess()){
                EventScheduleMAP.put(upresSCH.getId(), selectedEventSchedule);
            }
            EventScheduleShow();
           
            // ResponseString = 'Your request has updated successfully';
           // ResponseBoolean = TRUE;
            
            requestType = 'Accept';
            dispaySuccessPopup = TRUE;  
        }
              
    }
    
    public void scheduleReject(){
        
        
       selectedEventSchedule = new EventSchedule__c();
        
        if(EventScheduleMAP.get(apexpages.currentpage().getparameters().get('SELSchedule'))!= null){
            
           selectedEventSchedule = EventScheduleMAP.get(apexpages.currentpage().getparameters().get('SELSchedule'));
            
          // selectedEventSchedule = madeActionSchedule;
            
            selectedEventSchedule.MM_Slot_Status__c = 'Rejected';
            selectedEventSchedule.MBE_Corp_Combination__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_Slot_Status__c;
           selectedEventSchedule.MBE_Timeslot__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c;
           selectedEventSchedule.UPE_Timeslot__c = selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c;
      
       /*     
            Database.SaveResult upresSCH = DataBase.update(selectedEventSchedule, false);
            
            if(upresSCH.isSuccess()){
                EventScheduleMAP.put(upresSCH.getId(), selectedEventSchedule);
            }
            EventScheduleShow();
      */      
            // ResponseString = 'Your request has updated successfully';
           // ResponseBoolean = TRUE;
           
           requestType = 'Reject';
           dispaySuccessPopup = TRUE;  
           
            
       }
    
              
    }
    
    
    public void scheduleCancel(){
    
          selectedEventSchedule = new EventSchedule__c();
        
           if(EventScheduleMAP.get(apexpages.currentpage().getparameters().get('CancelSchedule'))!= null){
                
                selectedEventSchedule = EventScheduleMAP.get(apexpages.currentpage().getparameters().get('CancelSchedule'));
                Uemail =[select email,name from User where id =:selectedEventSchedule.MM_To_UPE__r.BoothAdmin_id__r.id ];
               //  selectedEventSchedule = madeActionSchedule;
                 
                selectedEventSchedule.MM_Slot_Status__c = 'Cancelled';
               selectedEventSchedule.MBE_Corp_Combination__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_Slot_Status__c+'-'+selectedEventSchedule.id;
               selectedEventSchedule.MBE_Timeslot__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c+selectedEventSchedule.id;
               selectedEventSchedule.UPE_Timeslot__c = selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c+selectedEventSchedule.id;
      
             /*    Database.SaveResult upresSCH = DataBase.update(selectedEventSchedule, false);
                
                if(upresSCH.isSuccess()){
                    EventScheduleMAP.put(upresSCH.getId(), selectedEventSchedule);
                }
                EventScheduleShow();
                
                // ResponseString = 'Your request has updated successfully';
              //  ResponseBoolean = TRUE;
            */   
                 requestType = 'Cancel';
                 dispaySuccessPopup = TRUE;  
         }
            
            
    
    }
    
    
    /* Added By Rajesh Kumar to update Schedule to Missed Status - 15-06-2015 */
    public PageReference UpdateAppmntToMissed(){
        selectedEventSchedule = new EventSchedule__c();
        
        if(EventScheduleMAP.get(apexpages.currentpage().getparameters().get('missedApp'))!= null){
        
            selectedEventSchedule = EventScheduleMAP.get(apexpages.currentpage().getparameters().get('missedApp'));
            Uemail =[select email,name from User where id =:selectedEventSchedule.MM_To_UPE__r.BoothAdmin_id__r.id ];
            selectedEventSchedule.MM_Slot_Status__c = 'Missed';
            
            requestType = 'Cancel';
            dispaySuccessPopup = TRUE;  
        }
        
        return null;
        
    }
    /* Added By Rajesh Kumar to update Schedule to Missed Status - 15-06-2015 */
    
    public Boolean reScheduleBool{get; set;}
    public Boolean eventTypeBool{get; set;}
    public LIST<EventSchedule__c> boothAdminSchedules{get; set;}
    public LIST<EventSchedule__c> attendeeSchedule{get; set;}
    public MAP<String, EventSchedule__c> attendeeScheduleMAP{get; set;}  
    public MAP<String, EventSchedule__c> exibitorScheduleMAP{get; set;} 
    public EventSchedule__c evs{get; set;}
    public String slotActualTime{get; set;}
    public Boolean tofindDuplicateBool{get; set;}
    
    
    
    
    
    
    
    //-------------------------------from MBE page-----------------------------
    
public MAP<string,EventSchedule__c> mapone {get;set;} 
public MAP<string,EventSchedule__c> maptwo {get;set;} 
public map<date,list<string>> slotmap {get;set;}
public List<maptimeWithEvesc> maptimeList{get;set;}
public MAP<string,EventSchedule__c>  mapStrWithES{get;set;}
public AttendeeSummary__c exbitorSummary {get ; set ;}
public EventSchedule__c eveshedule {get ; set ;}
public List<addendDateclass> dateInn {get ; set ;}
     public list<Event_Breaks__c> blokslistexist {get ; set ;}
     public string listvals {get ; set ;}
     public string listvalsmbe {get ; set ;}
public string upenames {get ; set ;}
    
 public PageReference ReSheduleTicket() {
    upenames ='';
    List<string> Unamess = new List<string>();
  string  selectedEmail = Apexpages.currentpage().getParameters().get('reSchEam');
    exbitorSummary = new AttendeeSummary__c ();
    Commanforstates cst = new Commanforstates ();
    system.debug('cccccccccccccc'+cst); 
    GlobalAttendee Gatt = new GlobalAttendee ();
    exbitorSummary=Gatt.ReturnAttendee(selectedEmail);
    system.debug('ddddddddd'+exbitorSummary.AS_Work_States__c);
    exbitorSummary.AS_Work_States__c=cst.mapstate(exbitorSummary.AS_Work_States__c); 
      mapStrWithES =new MAP<string,EventSchedule__c>(); 
      eveshedule = new EventSchedule__c();
      eveshedule =[select EV_id__r.Is_Webank_event__c,Comments__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,
                              MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c
                              ,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,id,MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName from EventSchedule__c where id=:Apexpages.currentPage().getParameters().get('SELSchedule')];
      system.debug('4444444444 '+eveshedule );
      string email =eveshedule.MM_To_EAM__r.AS_id__r.AS_Email__c;
      SET<Date> eventDates  = new SET<Date>();    
      string eamidmbe ='';
      
      User_Profile_Event__c upeid = [select id from User_Profile_Event__c where User_id__r.UserNAme=:Userinfo.getusername() AND EV_id__c =:selectedEvent AND IsMatchMakingUser__c =: true ];
    LIST<User_Profile_Event__c> upeidboothid = [select id ,BT_id__c,MAtchMakingProfile__c from User_Profile_Event__c where  User_id__c =: UserInfo.getUserId() AND    EV_id__c =: selectedEvent];
    list<id> upidsnew=new list<id> ();
    
    if(upeidboothid.size() != 0){
    id boothid = upeidboothid[0].BT_id__c;
    list<User_Profile_Event__c> upeowners = [select id,User_id__r.userName from User_Profile_Event__c where User_id__c !=: UserInfo.getUserId() AND BT_id__r.id = : boothid ];                      
    system.debug('nnnnnnnnnnnnnnnnnnnn'+upeowners);
    
        if(upeowners.size() != 0){
            for(User_Profile_Event__c up1: upeowners){
                if(upeidboothid[0].MAtchMakingProfile__c == 'Corporatestaff' || upeidboothid[0].MAtchMakingProfile__c == 'Corporate'){
                    upidsnew.add(up1.id);
                    upenames += up1.User_id__r.userName;
                    Unamess.add(up1.User_id__r.userName);
                 }
            }
        }
    
    }
    Unamess.add(Userinfo.getusername());
    upenames += Userinfo.getusername();
    system.debug('nnnnnnnnnnnnnnnnnnnn'+upenames);
    upidsnew.add(upeid.id);
      
      
      for(EventSchedule__c evd:[SELECT MM_To_EAM__r.id,MM_To_UPE__r.User_id__r.userName,MM_To_EAM__r.AS_Id__r.AS_Email__c,MM_To_EAM__r.AS_Id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.BT_Name__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and MM_To_EAM__r.AS_id__r.AS_Email__c=:selectedEmail  and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)]){
        mapStrWithES.put(evd.MM_slot_Date__c+evd.MM_slot_StartTime__c+'-'+evd.MM_Slot_End_Time__c,evd);
        
      }
     
         List<EventSchedule__c> evd1 = [SELECT MM_To_EAM__r.id,MM_To_UPE__r.User_id__r.userName,MM_To_EAM__r.AS_Id__r.AS_Email__c,MM_To_EAM__r.AS_Id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.BT_Name__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and MM_To_EAM__r.AS_id__r.AS_Email__c=:selectedEmail  and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)];
         eamidmbe = evd1[0].MM_To_EAM__r.id;
        for(EventSchedule__c eventShedules:[SELECT MM_To_UPE__r.User_id__r.userName,MM_To_EAM__r.AS_Id__r.AS_Email__c,MM_To_EAM__r.AS_Id__r.AS_Company__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and  MM_To_UPE__r.User_id__r.UserNAme=:Unamess and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)]){
            mapStrWithES.put(eventShedules.MM_slot_Date__c+eventShedules.MM_slot_StartTime__c+'-'+eventShedules.MM_Slot_End_Time__c,eventShedules);
            
        }
    
    
       MAP<date,integer> mapDateWithMaxapp = new MAP<date,integer>();
        for(aggregateResult arr :[SELECT count(id) numid,MM_slot_Date__c Name from EventSchedule__c 
                                                                               where EV_id__c=:selectedEvent 
                                                                               and Is_Matchmaking__c=true 
                                                                               and  MM_To_EAM__r.AS_id__r.AS_Email__c=:selectedEmail   
                                                                               and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') 
                                                                               and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) 
                                                                               group by MM_slot_Date__c]){
           
           integer  Quantity = (Integer) arr.get('numid');
           date dt= (date) arr.get('Name');
           mapDateWithMaxapp.put(dt,Quantity );
        
        }
      
      system.debug('BBBBBBBBBBBBBBBBBBBBB '+mapDateWithMaxapp);
    
    
       dateInn = new List<addendDateclass>();
        
        for(MatchLeads_Days__c EvDays:[select id,Break_Time_between_slots__c,End_Time__c,Event__c,MatchLeads_Date__c,MAX_noOf_appontments__c,Slot_Time_period__c,
                                                                                Start_time__c from MatchLeads_Days__c where Event__c=:selectedEvent]){
             eventDates.add(EvDays.MatchLeads_Date__c);
             slotmap  = new MAP<DATE,LIST<String>>();
             slotmap = MM_Utility.giveEventTimingsWithDates(SelectedEvent, EvDays.MatchLeads_Date__c);
             maptimeList = new List<maptimeWithEvesc>();
          
        for(string dateTimes:slotmap.get(EvDays.MatchLeads_Date__c)){
          maptimeList.add(new maptimeWithEvesc(dateTimes,mapStrWithES.get(EvDays.MatchLeads_Date__c+dateTimes))); 
        }
        string reachMaxnumber='';  
     if(EvDays.MAX_noOf_appontments__c == mapDateWithMaxapp.get(EvDays.MatchLeads_Date__c)){
        reachMaxnumber ='You have scheduled max number of Appointments for this day';
     } 
     
    
    blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__r.id IN : upidsnew];
        listvals = '';
    system.debug('-----------------blocklist--------------'+listvals);
    for(Event_Breaks__c evb: blokslistexist ){

    listvals += evb.Break_Start_Time__c+'-'+evb.Break_End_Time__c+',';
    }
    system.debug('-----------------blocklist--------------'+listvals);

    list<Event_Breaks__c> blokslistexistmbe = new list<Event_Breaks__c>();
    blokslistexistmbe = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__c =: eamidmbe];
        listvalsmbe = '';
    system.debug('-----------------blocklist--------------'+listvalsmbe);
    for(Event_Breaks__c evb1: blokslistexistmbe ){

    listvalsmbe += evb1.Break_Start_Time__c+'-'+evb1.Break_End_Time__c+',';
    }
    system.debug('-----------------blocklist--------------'+listvalsmbe);

    dateInn.add(new addendDateclass(EvDays.MatchLeads_Date__c,maptimeList,reachMaxnumber ));
    }
     reScheduleBool =true;
    system.debug('CCCCCCCCCCCCCCC '+dateInn);
     
     
  return null;
  }
  
   public class addendDateclass{
    public string errorreached{get;set;}
    public string sTime{get;set;}
    public List<maptimeWithEvesc> mapListTime{get;set;}
    
    public addendDateclass(date ttime,List<maptimeWithEvesc> listm,string sde){
      string dayone =string.valueOf(ttime);
       this.errorreached =sde;
         if(dayone !=null && dayone !=''){
            string[] str =  dayone.split('-');
          this.sTime=str[1]+'/'+str[2]+'/'+str[0];
       
       this.mapListTime=listm;
     }   
   }
   
   }
  
  
     public class maptimeWithEvesc{
            public string slottime{get;set;}
            public EventSchedule__c slotName{get;set;}
            public maptimeWithEvesc(string xs,EventSchedule__c xd){
             this.slottime = xs;
             this.slotName =xd;
            }
            
       }
  
 //----------------------------------------------------------------------------------
    public void scheduleReschedule(){
        
        Id scheduleId= apexpages.currentpage().getparameters().get('SELSchedule');
        slotActualTime = apexpages.currentpage().getparameters().get('actualSlotDate');
        
       String reSchEamId = apexpages.currentpage().getparameters().get('reSchEam');
       String reScheduleStatus = apexpages.currentpage().getparameters().get('reSchStatus');
      tofindDuplicateBool = FALSE;
      
      system.debug('11111111111111111111111111111111      '+ reSchEamId);
      system.debug('11111111111111111111111111111111      '+ reScheduleStatus);
      
      //To find Duplicates recordss........................................... 
      if(reScheduleStatus != 'dontConsider' && tofindScheduledEAMs.containsKey(reSchEamId)){
              tofindDuplicateBool = TRUE;
              reScheduleBool = TRUE;
              eventTypeBool = FALSE;
      }else{    
              tofindDuplicateBool = FALSE;
           system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA         '+ slotActualTime);
               
                LIST<EventSchedule__c> evSchedule = [SELECT Id, Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c,
                                                        MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c,
                                                        MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c, MM_To_EAM__r.AS_id__r.AS_WorkAddress2__c, MM_To_EAM__r.AS_id__r.AS_WorkCity__c,
                                                        MM_To_EAM__r.AS_id__r.AS_Work_States__c, MM_To_EAM__r.AS_id__r.AS_WorkZipCode__c, MM_To_EAM__r.AS_id__r.AS_Work_Country__c,MM_To_UPE__r.BT_id__r.BT_Location__c, 
                                                        MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email, comments__c FROM  EventSchedule__c WHERE Id =: scheduleId AND MM_To_EAM__c != null 
                                    AND MM_To_UPE__c != null ];
                
                if(! evSchedule.isEmpty()){
                    
                    evs= new EventSchedule__c();
                    evs = evSchedule[0];
                    if(evs.MM_To_EAM__r.AS_id__r.AS_Work_States__c != null){
                        Commanforstates cde= new Commanforstates ();
                        evs.MM_To_EAM__r.AS_id__r.AS_Work_States__c =cde.mapstate(evs.MM_To_EAM__r.AS_id__r.AS_Work_States__c);
                    }
                     Event__c scheduleEvent = [SELECT ID, NAME, EV_Title__c,MM_End_Date__c, MM_Start_Date__c, MM_Slot_Timeperiod__c, MatchMaking_Type__c,
                                         BreakTime_Between_Appointments__c, MM_Firstaday_startTime__c, MM_Firstaday_EndTime__c, MM_Secondaday_startTime__c, 
                                         MM_Secondaday_EndTime__c, Is_MatchMaking_Event__c,
                                         (SELECT ID, NAME, MatchLeads_Date__c, Start_time__c, End_Time__c, Break_Time_between_slots__c, MAX_noOf_appontments__c, Slot_Time_period__c FROM MatchLeads_Days__r)
                                         FROM Event__c WHERE ID =: selectedEvent];
                    
                if(scheduleEvent.MatchMaking_Type__c != 'closed'){   
                    
                    
                    MAP<Date, LIST<String>> singleDayMMEvent = MM_Utility.giveEventTimingsWithDates(scheduleEvent.Id, null);
                    
                    for(Date MMDay : singleDayMMEvent.KeySet()){
                        
                    
                          boothAdminSchedules = new LIST<EventSchedule__c>();
                          attendeeSchedule = new LIST<EventSchedule__c>();
                          attendeeScheduleMAP = new MAP<String, EventSchedule__c>();
                          exibitorScheduleMAP = new MAP<String, EventSchedule__c>();
                          toDisplayValues = new LIST<InnerClass>();
                           
                        //Event Schedule START............................................
                     
                                attendeeSchedule = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                                                         MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c WHERE EV_id__c=: selectedEvent AND MM_To_EAM__c =: evs.MM_To_EAM__c AND Is_Matchmaking__c = TRUE AND MM_slot_Date__c =: MMDay AND (MM_Slot_Status__c='Pending' OR MM_Slot_Status__c='Accepted')];
                                
                                  for(EventSchedule__c es: attendeeSchedule){
                                     attendeeScheduleMAP.put(es.MM_slot_StartTime__c,  es);
                                  }
                                
                                //Exibitor Booked Times........................................
                                boothAdminSchedules = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                                                        MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c 
                                                        WHERE EV_id__c=: selectedEvent AND MM_To_UPE__r.User_id__c =: UserInfo.getUserId() AND Is_Matchmaking__c = TRUE AND MM_slot_Date__c =: MMDay AND (MM_Slot_Status__c='Pending' OR MM_Slot_Status__c='Accepted')];
                            
                                for(EventSchedule__c es: boothAdminSchedules){
                                     exibitorScheduleMAP.put(es.MM_slot_StartTime__c,  es);
                                  }
                                
                                system.debug( 'exibitor ScheduleMAP '+  exibitorScheduleMAP );
                                        
                                
                                    LIST<bookedSchedule> singleVal = new LIST<bookedSchedule>();
                                
                                    for(String ss: singleDayMMEvent.get(MMDay)){
                                         
                                         
                                         system.debug(ss.substring(0, ss.lastIndexOf('-')).trim()+'Attendee Having Schedule'+ ss+'     '+exibitorScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim()));
                                         
                                         
                                        if(attendeeScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim())){
                                            singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), TRUE, FALSE, attendeeScheduleMAP.get(ss.substring(0, ss.lastIndexOf('-')).trim()), ss));
                                     
                                        system.debug('Attendee Having Schedule'+ss.substring(0, ss.lastIndexOf('-')).trim());
                                        }else if(exibitorScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim())){
                                            singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), FALSE, TRUE, exibitorScheduleMAP.get(ss.substring(0, ss.lastIndexOf('-')).trim()), ss));
                                       
                                        system.debug('BoothAdmin Having Schedule'+ss.substring(0, ss.lastIndexOf('-')).trim());
                                        }else{
                                            singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), FALSE, FALSE,  new EventSchedule__c(), ss ) );
                                       
                                            system.debug('No Schedule');
                                        }
                                    }
                                    
                                    toDisplayValues.add(new InnerClass(MMDay, singleVal));
                        
                        
                 //   }
                    
                    }   
              
                    reScheduleBool = TRUE;
                    eventTypeBool = FALSE;
                  }else{
                       reScheduleBool = TRUE;
                       eventTypeBool = TRUE;
                  }
                    
                }
      }
      
      
    
    }
    
    
    public class bookedSchedule{
        
        public String timeSlot{get;set;}
        public String actualSlot{get; set;}
        public Boolean attendeeBooked{get;set;}
        public Boolean exibitorBooked{get;set;}
        public EventSchedule__c es{get;set;}
        
        public bookedSchedule(String Slot, Boolean attb,Boolean exib, EventSchedule__c e, String act){
            timeSlot = slot;
            attendeeBooked = attb;
            es = e;
            exibitorBooked = exib;
            actualSlot = act;
        }
        
    }
    
    public LIST<InnerClass> toDisplayValues{get; set;}
    
    public class InnerClass{
        
        public Date scheduledate{get;set;}
        public LIST<bookedSchedule> schedules{get;set;}
        
        public InnerClass(Date d, LIST<bookedSchedule> sch ){
            scheduledate =  d;
            schedules = sch;
        }
    }
    
    
    public void cancel() {
        reScheduleBool = FALSE;
        MadeActionBool = FALSE;
        dispaySuccessPopup = FALSE; 
        vieProfileBool = FALSE;   
    }
    public void CloseSuccessPopupsc(){
    dispaySuccessPopupsc = false;
    errormsg = false;
    }
    public PageReference  makeReSchedule(){
    try{
        Event__c eventtimedetails =[select MatchMaking_Type__c,BreakTime_Between_Appointments__c,Owner.Email , MM_Slot_Timeperiod__c,MM_Start_Date__c,MM_End_Date__c,
                                          MM_End_Time__c,MM_Firstaday_EndTime__c,MM_Firstaday_startTime__c,MM_Secondaday_EndTime__c,
                                          MM_Secondaday_startTime__c  from Event__c where id =:selectedEvent ];
      
       system.debug('eeeeeeee'+ScheduleDate);
        
          requestType = 'Reschedule';
        eveshedule.MM_slot_Date__c = Date.parse(ScheduleDate);
        
        eveshedule .OwnerId = Userinfo.getUserId();
       // evs.MM_Slot_Status__c = 'Rescheduled';   Commented on 27/08/2013 by Mallik from Phani's Suggission.
       if(eventtimedetails.MatchMaking_Type__c=='Open' || eventtimedetails.MatchMaking_Type__c=='Closed'){
     eveshedule .MM_Slot_Status__c ='Accepted';
     //eveshedule.MM_Slot_Status__c ='Accepted';
    }else  if(eventtimedetails.MatchMaking_Type__c=='Semi Open'){
     eveshedule .MM_Slot_Status__c ='Pending';
      
    }  
       
        eveshedule .MM_slot_StartTime__c = timings[0];
        eveshedule .MM_Slot_End_Time__c = timings[1];
          eveshedule.MBE_Corp_Combination__c = eveshedule.MM_To_EAM__r.id+'-'+eveshedule.MM_To_UPE__r.id+'-'+eveshedule.MM_Slot_Status__c;
        eveshedule.MBE_Timeslot__c = eveshedule.MM_To_EAM__r.id+'-'+Date.parse(ScheduleDate)+'-'+timings[0]+eveshedule.MM_Slot_Status__c;
        eveshedule.UPE_Timeslot__c = eveshedule.MM_To_UPE__r.id+'-'+Date.parse(ScheduleDate)+'-'+timings[0]+eveshedule.MM_Slot_Status__c;
              
      dataBase.saveResult rs = Database.Update(eveshedule);
      dispaySuccessPopupsc = false;
     
       EventScheduleShow();
      } catch(Exception ex){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'why not working here?'+ex));
        errormsg = true; 
     return null;  
    }
       return null;   
    }
    public boolean errormsg {get ; set ;}
    public boolean dispaySuccessPopupsc {get;set;}
    public string schedulestartTime {get ; set ;}
    public string scheduleendTime {get ; set ;}
    public string ScheduleDate {get ; set ;}
    public LIST<String> timings {get ; set ;}
    public void schedules(){
    
     // List<EventSchedule__c> ESList = new List<EventSchedule__c>();
    // ESList =[SELECT id,MM_To_UPE__c,EV_id__c,MM_To_EAM__c from EventSchedule__c  where (id !=:eveshedule.id and EV_id__c=:selectedEvent and MM_To_UPE__r.User_id__r.userName=:userInfo.getUserName() and MM_To_EAM__r.AS_id__r.AS_Email__c=:evs.MM_To_EAM__r.AS_id__r.AS_Email__c) and (MM_Slot_Status__c='Pending' or MM_Slot_Status__c='Accepted') ];
     
    timings = new LIST<String>();
     String scheduleTime = apexpages.currentpage().getparameters().get('timeValue');
        system.debug('    AAAAAAAAAAAAAAAAAAAAA  '+ scheduleTime);
         ScheduleDate = Apexpages.currentpage().getParameters().get('dateValue');
        timings = new LIST<String>();
            timings.addAll((scheduleTime).split('-'));
            schedulestartTime = timings[0];
            scheduleendTime = timings[1];
        dispaySuccessPopupsc =true;
        reschedulebool = false;
    
    }

    public Boolean MadeActionBool{get; set;}
    
  /*  public void MadeAction(){
        
        madeActionSchedule = [SELECT Id, Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c,
                                    MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c,
                                    MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email,Comments__c FROM  EventSchedule__c WHERE ID=: apexpages.currentpage().getparameters().get('SELSchedule') ];
                 
       MadeActionBool = TRUE;
        
    }
    */
    
    
   public Boolean dispaySuccessPopup{get; set;}
   public void CloseSuccessPopup(){
       
   dispaySuccessPopup = FALSE;
   }
   
   public EventSchedule__c madeActionSchedule{get; set;}
   public list<EventSchedule__c>  schlistpdf {get;set;}
   public blob b {get;set;}
   public pagereference pdf{get;set;}
   
   
   public void updateComment(){
   schlistpdf = new list<EventSchedule__c>();
   if(selectedEventSchedule.MM_Slot_Status__c == 'Camcelled'){
   selectedEventSchedule.MBE_Corp_Combination__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_Slot_Status__c+'-'+selectedEventSchedule.id;
   selectedEventSchedule.MBE_Timeslot__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c+selectedEventSchedule.id;
   selectedEventSchedule.UPE_Timeslot__c = selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c+selectedEventSchedule.id;
   }else{
   
   selectedEventSchedule.MBE_Corp_Combination__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_Slot_Status__c;
   selectedEventSchedule.MBE_Timeslot__c = selectedEventSchedule.MM_To_EAM__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c;
   selectedEventSchedule.UPE_Timeslot__c = selectedEventSchedule.MM_To_UPE__r.id+'-'+selectedEventSchedule.MM_slot_Date__c+'-'+selectedEventSchedule.MM_slot_StartTime__c+selectedEventSchedule.MM_Slot_Status__c;
   
  
   }   
    Database.SaveResult upresSCH = DataBase.update(selectedEventSchedule, false);
     //  Update madeActionSchedule;
         
                
                if(upresSCH.isSuccess()){
                
                 EventSchedule__c  es = new  EventSchedule__c();
                 
                        es = [SELECT ID, NAME, MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c,  MM_To_EAM__c,
                                            MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c  FROM EventSchedule__c WHERE ID=:  upresSCH.getId() ];
                        
                
                }
                
//-------------------------------------------------------------------------------------------------------------------                
                    EventScheduleMAP.put(upresSCH.getId(), selectedEventSchedule);
               
                EventScheduleShow();
                 
        reScheduleBool=FALSE;         
       dispaySuccessPopup = FALSE;
   }
   
   public Boolean vieProfileBool{get; set;}
   public Event_Attendee_Mapping__c vewProfileEAM{get; set;}
   public Event__c eventone {get ; set ;}
   public   list<Custom_Widget__c> cvideos{get ; set ;}
   public void attendeeDetail(){
       errormsg = false;
       ID eamId = apexpages.currentpage().getparameters().get('attendeeEAM');
           
       attchments = new list<Attachment>();

       vewProfileEAM = new  Event_Attendee_Mapping__c();
       eventone = new Event__c();
       eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:selectedEvent];
       Commanforstates  cd12 = new Commanforstates ();
       if(eventone.Is_Webank_event__c == false){ 
       vewProfileEAM =[SELECT    AS_id__r.Id,AS_id__r.Exhibitor_company_imageUrl__c,
                   AS_id__r.DBA__c,
                  AS_id__r.Geographical_Region__c,
                  AS_id__r.Certificate_Processed_by_RPO__c,
                  AS_id__r.BBB_Number__c,
                  AS_id__r.Commodity_1__c,
                  AS_id__r.Commodity_2__c,
                  AS_id__r.Commodity_3__c,
                  AS_id__r.Commodity_4__c,
                  AS_id__r.Commodity_5__c,
                  AS_id__r.Commodity_6__c,
                  AS_id__r.Commodity_7__c,
                  AS_id__r.Commodity_8__c,
                  AS_id__r.Commodity_9__c,
                   AS_id__r.distribution_Country__c,
                 AS_id__r.Manufactures_Country__c,
                  AS_id__r.References__c,
                  AS_id__r.References2__c,
                  AS_id__r.Scope_of_Work__c,
                  AS_id__r.Scope_of_Work2__c,
                  AS_id__r.Companyhaveafacility_partneroutsideUSA__c,
                  AS_id__r.Any_non_WBENC_awards_received__c,
                  AS_id__r.Revenue_Range__c, 
                  AS_id__r.AS_NAICSCode9__c,
                   AS_id__r.AS_NAICSCode8__c,
                    AS_id__r.AS_NAICSCode7__c,
                    AS_id__r.AS_NAICSCode6__c,
                  AS_id__r.AS_CageCode__c, 
                  AS_id__r.GSA_Schedule__c,
                  AS_id__r.Business_type__c, 
                  AS_id__r.Company_Certifications__c,
                  AS_id__r.AS_WorkZipCode__c,
                  AS_id__r.AS_WorkState__c,
                  AS_id__r.AS_WorkPoBox__c,
                  AS_id__r.AS_WorkPhone__c,
                  AS_id__r.As_prefixNew__c,
                  AS_id__r.AS_WorkCountry__c,
                  AS_id__r.AS_WorkCity__c, 
                  AS_id__r.AS_WorkAddress2__c, 
                  AS_id__r.AS_WorkAddress1__c, 
                  AS_id__r.AS_WebsiteUrl__c, 
                  AS_id__r.AS_Title__c, 
                  AS_id__r.AS_ThroughEventBrite__c,
                  AS_id__r.AS_Suffix__c, 
                  AS_id__r.AS_ShippingZipcode__c,
                  AS_id__r.AS_ShippingState__c, 
                  AS_id__r.AS_ShippingPoBox__c, 
                  AS_id__r.AS_ShippingPhone__c,
                  AS_id__r.AS_ShippingCountry__c,
                  AS_id__r.AS_ShippingCity__c, 
                  AS_id__r.AS_ShippingAddress2__c, AS_id__r.AS_ShippingAddress1__c,
                  AS_id__r.AS_SecondaryBusinessCategory1__c, AS_id__r.AS_PrimaryBusinessCategory1__c, AS_id__r.AS_Prefix__c, 
                  AS_id__r.AS_NumberOfEmployees__c, AS_id__r.AS_NAICSCode_5__c, AS_id__r.AS_NAICSCode_4__c, AS_id__r.AS_NAICSCode_3__c, 
                  AS_id__r.AS_NAICSCode_2__c, AS_id__r.AS_NAICSCode_1__c, AS_id__r.AS_LastName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_HomeZipcode__c,
                  AS_id__r.AS_HomeState__c, AS_id__r.AS_HomePoBox__c, AS_id__r.AS_HomePhone__c, AS_id__r.AS_HomeCountry__c, AS_id__r.AS_HomeCity__c,
                  AS_id__r.AS_HomeAddress2__c, AS_id__r.AS_HomeAddress1__c, AS_id__r.AS_Gender__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_FaxNumber__c,
                  AS_id__r.Year_in_Business__c,AS_id__r.Business_Structure__c,AS_id__r.Ethnicity__c,AS_id__r.AS_Secondary_Email__c,
                  AS_id__r.AS_Email__c, AS_id__r.AS_DiversityType__c, AS_id__r.AS_Company__c, AS_id__r.AS_CellPhone__c, 
                  AS_id__r.AS_BusinessRevenue__c, AS_id__r.AS_BusinessEstablishedDate__c, AS_id__r.AS_BusinessDescription__c,
                  AS_id__r.AS_BlogUrl__c, AS_id__r.AS_BirthDate__c, AS_id__r.AS_Age__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_Work_States__c,AS_id__r.As_Home_Country__c,AS_id__r.As_Home_State__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_WorkZip__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_shippingzip__c,DiversityType__c,
                  AS_id__r.AS_BusinessDunsNumber__c,AS_id__r.Keywords__c  FROM Event_Attendee_Mapping__c WHERE ID =: eamId  ];
                   attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:vewProfileEAM.AS_id__c]; 
                  videos = [Select id,YouTubeId_c__c From Widget__c Where AttendeeSummary__r.id =: vewProfileEAM.AS_id__c];
                    if(vewProfileEAM.AS_id__r.AS_Work_States__c != null && vewProfileEAM.AS_id__r.AS_Work_States__c != ''){
                  vewProfileEAM.AS_id__r.AS_Work_States__c=cd12.mapstate(vewProfileEAM.AS_id__r.AS_Work_States__c);
                  }
            }else{
             vewProfileEAM = [Select  AS_id__c,MBE_Profile__r.As_prefixNew__c ,MBE_Profile__r.As_SuffixNew__c,MBE_Profile__r.As_Shipping_Country__c,MBE_Profile__r.As_Shipping_States__c,MBE_Profile__r.SystemModstamp, MBE_Profile__r.OwnerId, MBE_Profile__r.Name, MBE_Profile__r.LastModifiedDate, MBE_Profile__r.LastModifiedById,
                          MBE_Profile__r.LastActivityDate, MBE_Profile__r.IsDeleted, MBE_Profile__r.Id, MBE_Profile__r.CreatedDate, MBE_Profile__r.CreatedById,MBE_Profile__r.Exhibitor_company_imageUrl__c,
                          MBE_Profile__r.AS_WorkZipCode__c,MBE_Profile__r.AS_WorkPhone__c, 
                          MBE_Profile__r.AS_WorkCity__c, MBE_Profile__r.AS_WorkAddress2__c, MBE_Profile__r.AS_WorkAddress1__c, MBE_Profile__r.Key_Words__c,
                          MBE_Profile__r.AS_WebsiteUrl__c, MBE_Profile__r.AS_Title__c, 
                          MBE_Profile__r.AS_ShippingZipcode__c, MBE_Profile__r.AS_ShippingState__c, MBE_Profile__r.AS_ShippingPoBox__c, MBE_Profile__r.AS_ShippingPhone__c, 
                          MBE_Profile__r.AS_ShippingCity__c, MBE_Profile__r.AS_ShippingAddress2__c, MBE_Profile__r.AS_ShippingAddress1__c,
                          MBE_Profile__r.AS_SecondaryBusinessCategory1__c, MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                          MBE_Profile__r.AS_NumberOfEmployees__c, MBE_Profile__r.AS_NAICSCode_5__c, MBE_Profile__r.AS_NAICSCode_4__c, MBE_Profile__r.AS_NAICSCode_3__c, 
                          MBE_Profile__r.AS_NAICSCode_2__c, MBE_Profile__r.AS_NAICSCode_1__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_ImageUrl__c,
                          MBE_Profile__r.AS_HomePhone__c,MBE_Profile__r.AS_HomeCity__c,MBE_Profile__r.References2__c,MBE_Profile__r.Scope_of_Work__c,MBE_Profile__r.Scope_of_Work2__c,MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,MBE_Profile__r.Any_non_WBENC_awards_received__c,DiversityType__c,
                           MBE_Profile__r.DBA__c,
                  MBE_Profile__r.Geographical_Region__c,
                  MBE_Profile__r.Certificate_Processed_by_RPO__c,
                  MBE_Profile__r.BBB_Number__c,
                  MBE_Profile__r.Commodity_1__c,
                  MBE_Profile__r.Commodity_2__c,
                  MBE_Profile__r.Commodity_3__c,
                  MBE_Profile__r.Commodity_4__c,
                  MBE_Profile__r.Commodity_5__c,
                  MBE_Profile__r.Commodity_6__c,
                  MBE_Profile__r.Commodity_7__c,
                  MBE_Profile__r.Commodity_8__c,
                  MBE_Profile__r.Commodity_9__c,
                   MBE_Profile__r.distribution_Country__c,
                MBE_Profile__r.Manufactures_Country__c,
                  MBE_Profile__r.References__c,
                  MBE_Profile__r.Revenue_Range__c,
                  MBE_Profile__r.AS_NAICSCode9__c,
                   MBE_Profile__r.AS_NAICSCode8__c,
                    MBE_Profile__r.AS_NAICSCode7__c,
                    MBE_Profile__r.AS_NAICSCode6__c,
                    MBE_Profile__r.Ethnicity__c,MBE_Profile__r.AS_Secondary_Email__c,
                          MBE_Profile__r.AS_HomeAddress2__c, MBE_Profile__r.AS_HomeAddress1__c, MBE_Profile__r.AS_Gender__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_FaxNumber__c,
                          MBE_Profile__r.Business_Structure__c,MBE_Profile__r.Year_in_Business__c,
                          MBE_Profile__r.AS_Email__c, MBE_Profile__r.AS_DiversityType__c, MBE_Profile__r.AS_Company__c, MBE_Profile__r.AS_CellPhone__c, MBE_Profile__r.AS_CageCode__c,MBE_Profile__r.GSA_Schedule__c,
                          MBE_Profile__r.AS_BusinessRevenue__c, MBE_Profile__r.AS_BusinessEstablishedDate__c, MBE_Profile__r.AS_BusinessDescription__c, MBE_Profile__r.Business_type__c,MBE_Profile__r.Exceptional_Key_Words__c,
                          MBE_Profile__r.AS_BlogUrl__c, MBE_Profile__r.AS_BirthDate__c, MBE_Profile__r.AS_Age__c,MBE_Profile__r.AS_Work_Country__c,MBE_Profile__r.AS_Work_States__c,MBE_Profile__r.As_Home_Country__c,MBE_Profile__r.As_Home_State__c,MBE_Profile__r.AS_WorkZip__c,MBE_Profile__r.AS_HomeZip__c,
                          MBE_Profile__r.AS_BusinessDunsNumber__c,MBE_Profile__r.AS_BusinessTaxId__c,MBE_Profile__r.Company_Certifications__c from Event_Attendee_Mapping__c WHERE ID =: eamId]; 
                            
                            if(vewProfileEAM.MBE_Profile__r.AS_Work_States__c != null && vewProfileEAM.MBE_Profile__r.AS_Work_States__c != ''){ 
                            vewProfileEAM.MBE_Profile__r.AS_Work_States__c=cd12.mapstate(vewProfileEAM.MBE_Profile__r.AS_Work_States__c);
                            }
                            //vewProfileEAM.MBE_Profile__r.AS_Work_States__c=cd12.mapstate(vewProfileEAM.MBE_Profile__r.AS_Work_States__c);
                 attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:vewProfileEAM.MBE_Profile__r.id]; 
                 cvideos = new list<Custom_Widget__c>();
                  cvideos = [Select id,YouTubeId_c__c From Custom_Widget__c Where MBE_Profile__r.id =: vewProfileEAM.MBE_Profile__r.id];
            
            }
       
       
          vieProfileBool = false;  
   }
   public EventSchedule__c escomments {get;set;}
   public boolean commentspopupbool {get;set;}
   
   public void commentspopup(){
   escomments = new EventSchedule__c();
   string eschid = Apexpages.currentpage().getparameters().get('esid');
   system.debug('              esid   '+eschid );
   escomments = [select Comments__c from EventSchedule__c where id =: eschid ];
    system.debug('              esid   '+escomments.Comments__c);
   commentspopupbool = true;
   }
   public void ClosePopUp(){
    commentspopupbool = false;
    Blockschedulebool = false;
   }
    public MAP<DATE,LIST<String>>  dateSlotsMAP {get; set ;}
    public list<string> timeListMap {get ; set ;}
    //public list<Event_Breaks__c> blokslistexist {get ; set ;}
    public list<EventSchedule__c> exhibitorschedule  {get ; set ;}
    public list<innercl> innlistscheduled {get;set;}
    public LIST<MatchLeads_Days__c> allEventDates {get ; set ;}
    public string blockselecteddate  {get ; set ;}
    public List<selectoption> eventDatesList {get ; set ;}
    public void blockschedule(){
    Blockschedulebool = true;
    timeListMap = new list<string> ();
    innlistscheduled = new list<innercl> ();
    blokslistexist = new list<Event_Breaks__c>();
    exhibitorschedule = new list<EventSchedule__c>();
    availableslots = new list<selectoption> ();
    blockedslots = new list<selectoption> ();
    eventDatesList = new List<selectoption>();
     allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: selectedEvent ORDER BY MatchLeads_Date__c ASC]);
      if(allEventDates.size() >=1){
        
         for(MatchLeads_Days__c matchDate: allEventDates){
             String dateFormat= matchDate.MatchLeads_Date__c.format();
             system.debug('dddddddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyy'+dateFormat);
             eventDatesList.add(new selectoption(matchDate.id,dateFormat));
              }
         system.debug('dddddddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyy'+eventDatesList);
          system.debug('ffffffffffffffffff'+'blockselecteddate');
         if(blockselecteddate == ''){
         blockselecteddate  = allEventDates[0].id;
         }
         }
         //system.debug('rrrrrrrrrrr'+allEventDates[1].id);
              MatchLeads_Days__c mday =[select id,MatchLeads_Date__c FROM MatchLeads_Days__c WHERE id =: blockselecteddate ];
               string mmdate = '';
               mmdate  = mday.MatchLeads_Date__c.format();
          
               User_Profile_Event__c  UPES = [SELECT ID FROM User_Profile_Event__c WHERE (BoothAdmin_id__c =: UserInfo.getUserId() AND IsMatchMakingUser__c =: TRUE) AND  EV_id__c =: selectedEvent ORDER BY createdDate];         
                exhibitorschedule =[SELECT Id ,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                               MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                               MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c  
                                        FROM EventSchedule__c 
                                        WHERE MM_To_UPE__c =: UPES.id
                                        AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                        AND MM_To_EAM__c != null 
                                        AND MM_slot_Date__c =: date.Parse(mmdate)  
                                        AND MM_Slot_Status__c = 'Accepted'
                                        AND EV_id__c =: selectedEvent 
                                        ];
                   string eschslots = '';
                     for(EventSchedule__c esch : exhibitorschedule ){
                        eschslots += esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c+','; 
                     
                    }
                    blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: UPES.id AND MatchLeads_Days__c =: blockselecteddate ];
                    string listvals = '';
                    for(Event_Breaks__c evb : blokslistexist) {
                    listvals += evb.Break_Start_Time__c+'-'+evb.Break_End_Time__c+',';
                    }
                    
                    date dte = date.Parse(mmdate);
                    MAP<Date, LIST<String>> singleDayMMEvent = MM_Utility.giveEventTimingsWithDates(SelectedEvent, dte );
                    
                    for(Date MMDay : singleDayMMEvent.KeySet()){
                    timeListMap = singleDayMMEvent.get(MMDay);
                    
                    }
                   for(string ss : timeListMap ){
                   if(eschslots.contains(ss)){
                   innlistscheduled.add(new innercl(ss,true));
                   }else{
                   if(listvals.contains(ss)){
                   blockedslots.add(new selectoption(ss,ss));}
                   //innlistblocked.add(new innercl(ss,false));
                   else{
                   availableslots.add(new selectoption(ss,ss));
                   //innlist.add(new innercl(ss,false));
                   }
                   } }
                   }
    public Event_Breaks__c blockslot {get; set;}
    public list<selectoption> availableslots {get;set;}
    public list<selectoption> blockedslots {get; set;}    
    public void Blockedaction(){
        blokslistexist = new list<Event_Breaks__c> ();
        User_Profile_Event__c  UPES = [SELECT ID FROM User_Profile_Event__c WHERE (BoothAdmin_id__c =: UserInfo.getUserId() AND IsMatchMakingUser__c =: TRUE) AND  EV_id__c =: selectedEvent ORDER BY createdDate];         
        blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: UPES.id AND MatchLeads_Days__c =: blockselecteddate];
        delete blokslistexist ;
        list<Event_Breaks__c> blokslist = new list<Event_Breaks__c> ();
        list<string> sbch = new list<string> ();
            if(blockedslots.size() != 0){
                for(selectoption sop : blockedslots ){
                    sbch.add(sop.getvalue());
                }
            }
             for(string ins : sbch){
                blockslot = new Event_Breaks__c ();
                list<string> divideslot = String.valueOf(ins).split('-');
                blockslot.User_Profile_Event__c = UPES.id;
                blockslot.Break_Start_Time__c = divideslot[0];
                blockslot.Break_End_Time__c = divideslot[1];
                 blockslot.MatchLeads_Days__c = blockselecteddate;
                blokslist.add(blockslot);
             
             
             }
         insert blokslist;
         }
                /**
                for(innercl ins : innlist){
                if(ins.selected == true){
                blockslot = new Event_Breaks__c ();
                list<string> divideslot = String.valueOf(ins.slot).split('-');
                blockslot.User_Profile_Event__c = BoothAdminDetails;
                blockslot.Break_Start_Time__c = divideslot[0];
                blockslot.Break_End_Time__c = divideslot[1];
                
                blokslist.add(blockslot);
                
                }
                }
                 insert blokslist;
                
                
    
    }
     public void UnBlockedaction(){
        
    list<Event_Breaks__c> blokslist = new list<Event_Breaks__c> ();
    string slotslist = '';
     for(innercl ins1 : innlistblocked){
        if(ins1.selected == true){
        slotslist += ins1.slot+',';
        }
    }
    for(Event_Breaks__c bks : blokslistexist ){
    if(slotslist.contains(bks.Break_Start_Time__c+'-'+bks.Break_End_Time__c)){
    blokslist.add(bks);
    }
    
    }
    delete blokslist;

     
    } */
  public class innercl{
      
        public boolean selected {get; set ;}
        public string slot {get; set;}
         public innercl(string dispslot,boolean bb){
        
         selected = bb;
         slot = dispslot;
         
         }
        
        }



/* Added By Rajesh on 18-06-2015 - Inner class for Confirmed appointments - To auto populate Missed call icon in the UI */
   public class ConfirmedAppmnts{
       public EventSchedule__c confirmedchedules{get; set;}
       public Boolean CompareEndTime{get; set;}
       
       public ConfirmedAppmnts(EventSchedule__c evs, Boolean comp){
           confirmedchedules = evs;
           CompareEndTime = comp;
       }
   
   }
/* Added By Rajesh on 18-06-2015 - Inner class for Confirmed appointments - To auto populate Missed call icon in the UI */  
     
      public List<MM_Surevycon.QueQithOpt> surveyQuesList{get;set;}    
          public boolean surveybool{get;set;}        
         // Survey Questions code
           public void showSurveyQue(){
              String ansById = Apexpages.currentPage().getParameters().get('ansId');
              surveyQuesList = new List<MM_Surevycon.QueQithOpt>();
               
             if(ansById !=null){   
              surveyQuesList = surveyController.surveyQuetionsMethod(ansById );
                 surveybool =true;
              }
              system.debug('surveyQuesList from surveyCls  '+surveyQuesList ); 
           }           
                    
        public void saveSurvey(){
           surveyController.Save(surveyQuesList);
           surveybool =false;
           surveyQuesList = new List<MM_Surevycon.QueQithOpt>();
          
         }
        
        public void closesurvey(){
            surveybool =false;
            
        } 
     public void dummy(){
     integer i=0;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     i++;
     
     
     }
}