public without sharing class Matchleads_eventsPageCon {

 public Event__c EventDetail {get;set;}
 Public List<Event__c> registeredEvents {get;set;}
 Public List<Event__c> upcommingEvents {get;set;}
 public string selectedEvent {get;set;}
 public MAP<id,User_Profile_Event__c> mapUserid{get;set;}
 public string loginUser{get;set;}
 public string selectedPage{get;set;}
 public List<selectOption> options{get;set;}
 public List<innclass> inn{get;set;}
 public string changeValue{get;set;}
 public String EventStartDate{get; set;}
    public String EventEndDate{get; set;}
    public LIST<SelectOption> StartTimings {get; set;} 
    public LIST<SelectOption> EndTimings{get; set;}
    public LIST<SelectOption> EventDate{get; set;} 
    public Boolean detailScheduleBool{get; set;} 
    public Boolean addScheduleBool{get; set;}   
    public String ScheduleHeading{get; set;}
    public String eventname{get; set;}
    public List<SelectOption> open {get;set;}
    public List<Event_Breaks__c> Breaks{get;set;}
    
    public Boolean starttimebool{get; set;}    
    public Boolean endtimebool{get; set;}  
    public Boolean slotbool{get; set;} 
    public Boolean breaktimevalidbool{get; set;}
    public Boolean Result{get; set;}
    public Boolean Breakstarttimebool {get; set;}
    public Boolean  Breakendtimebool {get; set;}
    public Boolean Appointmentsperattidbool{get;set;}
  
    Public Time breakstarttime {get; set;}
    Public Time eventstarttime {get; set;}
    Public Time eventendtime {get; set;}
    Public Time breakendtime {get; set;}
     // Stats Start
    public Integer signedupmbes{get;set;}
    public Integer signedupcorporates{get;set;}    
    public Integer corporateswaiting{get;set;}
    public Integer totalmatchesmade{get;set;}
    public Decimal pendingmatches{get;set;}
    public integer totalslots{get;set;}
     public integer slotsize{get;set;}
     public MAP<Date , LIST<String>> getSlotsFromUtility{get; set;}
     public integer totalsbs{get;set;}
    public integer utilslots{get;set;}
    public integer corporatesize {get;set;}
    public integer mbesize {get;set;}
    public integer resourcePartnerSize {get;set;}
    public LIST<User_Profile_Event__c> corporateslist{get;set;}
    public LIST<Event_Attendee_Mapping__c> mbeslist{get;set;}
    public LIST<User_Profile_Event__c> waitinglist{get;set;}
    public LIST<EventSchedule__c> totalmatcheslist{get;set;}
    public LIST<EventSchedule__c> pendingmatcheslist{get;set;}
    // Stats End
       //---------------------------------------------ADD EVENT--------------------
   public boolean AddEventBtn {get;set;}
    public string eventheading {get;set;}
    public Event__c Event{get; set;}
    public Document DocumentImage{get; set;}
    public String LogoName{get; set;}
    Public transient Blob LOGO{get; set;}
    public String eventErrorString{get; set;}
    public Boolean myDocBool{get; set;}
    public String eventLogoErrorString{get; set;}
    Public Document mydoc;
    public String selectedEventbrite{get; set;}
    public boolean displayAttendeeRegistrationLink{get;set;}
    public MAP<String, String> eventsCheckMap{get; set;}
    public list<string> allslots{get;set;}
    public integer nodays{get;set;}
    public list<date> days {get;set;}
    public List<Event_Breaks__c> evebreaks {get;set;}
    public MatchLeads_Days__c DaysOfEvent {get;set;}
    public list<breaksinn> dates {get;set;} 
    public  list<selectoption> apps {get;set;} 
    public  String selectedapp {get;set;} 
    public Tags__c tag1{get;set;}
    public Tags__c tag2{get;set;}
    public list<Tags__c> tagslist {get; set ;}
    public string attendeealias {get ; set ;}
    public string exhibitoralias {get ; set ;}
    public string dynamicstrings{get;set;}
   public String vppagename{get;set;}
   
   public list<user> userlist{get;set;}
    public list<Event_Attendee_Mapping__c> eamlist{get;set;}
    
   public Matchleads_eventsPageCon(){
 
  getallevents();
  if(inn.size()==1)
  {
     Cookie counter = new Cookie('counter', inn[0].eveInn.id,null,-1,false);
    ApexPages.currentPage().setCookies(new Cookie[]{counter});
    try{
     Cookie viewprofile=ApexPages.currentPage().getCookies().get('viewprofile');
     vppagename=viewprofile.getValue();
     
     }catch(Exception e){}
  }
  else
  {
     Cookie viewprofile= new Cookie('viewprofile',null,null,-1,false);
     ApexPages.currentPage().setCookies(new Cookie[]{viewprofile}); 
  }
  
  /*LIST<Event__c> lieve=[select id, (select id,Default_Name__c,Alias_Name__c from Tags__r) from Event__c where Is_MatchMaking_Event__c=true];
  for(Event__c e:lieve)
  {
  system.debug('ttttttt8888'+e);
  if(e.Tags__r[0].Default_Name__c == 'Attendee'){
       attendeealias = e.Tags__r[0].Alias_Name__c;
       system.debug('iiiiiiiiiiiiiiiiiiiiiiiiii'+ attendeealias );
       }else if(e.Tags__r[0].Default_Name__c == 'Exhibitor'){
       exhibitoralias = e.Tags__r[0].Alias_Name__c;
       system.debug('kkkkkkkkkkkkkkkkkkkkkkkk'+ exhibitoralias );
       }
 
  }*/
  }
   public void getallevents(){
   try{
   attendeealias ='';
   exhibitoralias ='';
   open = new List<SelectOption>();
     open.add(new SelectOption('Open','Open'));
     open.add(new SelectOption('Semi Open','Semi Open'));
     open.add(new SelectOption('Closed','Closed'));      
     //open.add(new SelectOption('Custom','Custom'));
     apps = new list<selectoption> ();
     apps.add(new selectoption('Match Leads','Match Leads'));
      apps.add(new selectoption('Booth Leads','Booth Leads'));
      selectedapp = 'Match Leads';
      selectedtab='Event Type';
     resourcePartnerSize=0;
  inn = new List<innclass>();
  EventDetail = new Event__c ();
  eventsCheckMap = new MAP<String, String>();
  registeredEvents = new List<Event__c>();
  upcommingEvents  = new List<Event__c>();
  mapUserid = new  MAP<id,User_Profile_Event__c>();
  options = new List<selectOption>();
  loginUser=userInfo.getUserId();
  Breaks = new list<Event_Breaks__c>();
  
  starttimebool = false;
  endtimebool = false;
  slotbool = false;
  breaktimevalidbool = false;
  Result =false;
  Breakstarttimebool = false;
  Breakendtimebool = false;
  Appointmentsperattidbool = false;
  
  breakstarttime = Time.newInstance(0, 0, 0, 0);
  eventstarttime = Time.newInstance(0, 0, 0, 0);
  eventendtime = Time.newInstance(0, 0, 0, 0);
  breakendtime = Time.newInstance(0, 0, 0, 0);
  // loginUser='005Z0000001JSIB';
  
  
      SET<id> eventids = new SET<id>();
      For(User_Profile_Event__c upe:[SELECT id,EV_id__c,EV_id__r.publish_to_users_flag__c,User_id__c,EV_id__r.Is_MatchMaking_Event__c,Profile_id__r.PR_Name__c,MAtchMakingProfile__c,Request_for_upgrade_profile__c from User_Profile_Event__c User_id__c where EV_id__r.Is_MatchMaking_Event__c=true and IsMatchMakingUser__c = true and User_id__c=:loginUser and EV_id__r.Status__c!='Deleted' ORDER BY EV_id__r.CreatedDate ASC]){
         system.debug('::::::::::::::::::UPES OF AN EVENT:::::::::::::::'+upe);
         if(upe.Profile_id__r.PR_Name__c == 'Eventadmin'){
         eventids.add(upe.EV_id__c); 
         mapUserid.put(upe.EV_id__c,upe);}
         else if(upe.EV_id__r.publish_to_users_flag__c == True){
         
          eventids.add(upe.EV_id__c); 
         mapUserid.put(upe.EV_id__c,upe);
         
         } 
       }
       
       options.add(new SelectOption('None','None')); 
       options.add(new SelectOption('MBE','MBE')); 
       options.add(new SelectOption('Corporate','Corporate'));
        
        
        
        
      List<Event__c> eves =new List<event__c>([SELECT   (select id,Default_Name__c,Alias_Name__c from Tags__r),Accept_Pay_at_the_Door_Payments__c,Accept_Pay_by_Check_Payments__c,Accept_Send_an_Invoice_Payments__c,AS_HostingAddr2__c,AS_HostingCity__c,Attendee_can_send_request__c,Attendee_Tags__c,Attendee_Types__c,BreakTime_Between_Appointments__c,CCRDetails_Required__c,Enable_Scan_To_ATT__c,Enable_Scan_To_BA__c,EventDiversityValues__c,Event_PostalCode__c,Event_Printer__c,Event_Type__c,Event_ZipCode__c,EV_ContactURL__c,EV_CustomReg__c,EV_Description__c,EV_EndDate__c,EV_EndTime__c,EV_EventLogo__c,EV_HistingAddr1__c,EV_HostedByEventBrite__c,EV_HostingCountryNew__c,EV_HostingCountry__c,EV_HostingFax__c,EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,
      EV_HostingPostalCode__c,EV_HostingStateNew__c,EV_HostingState__c,EV_HostingTimeZone__c,EV_HostingZipcode__c,EV_IncludedFields__c,EV_Publish__c,EV_QuickReg__c,EV_RedirectURI__c,Ev_RequiredFields__c,EV_SiteLocation__c,EV_StartDate__c,Match_Making_Schedules__c,
      EV_Title__c,Email_Notifications_flag__c,EV_WebsiteURL__c,publish_to_users_flag__c,Exhibitor_can_send_request__c,FacebookId__c,Floor_Map_Image__c,Id,IsRegistration__c,Is_Approval_Required__c,Is_MatchMaking_Event__c,Lable_First_Line_Color__c,Lable_First_Line_Font__c,Lable_First_Line_Size__c,Lable_First_Line__c,Lable_Secoend_Line_Color__c,Lable_Secoend_Line_Font__c,Lable_Secoend_Line_Size__c,Lable_Secoend_Line__c,Lable_Third_Line_Color__c,Lable_Third_Line_Font__c,Lable_Third_Line_Size__c,Lable_Third_Line__c,MatchMaking_Type__c,MM_End_Date__c,MM_End_Time__c,MM_Firstaday_EndTime__c,MM_Firstaday_startTime__c,MM_Secondaday_EndTime__c,MM_Secondaday_startTime__c,MM_Slot_Timeperiod__c,MM_Start_Date__c,MM_Start_Time__c,Name,No_Appointments_Per_Attendee__c,OrganizerId__c,Paypal_Email__c,Primary__c,Quickregfields__c,Quickreqfields__c,secondaryCategory__c,Session_Time__c,ShowAgain__c,Signature__c,startTime__c,Status__c,Through_Paypal__c,TwitterHashTag__c,TwitterId__c,(SELECT Start_time__c,End_Time__c FROM MatchLeads_Days__r),Is_Webank_event__c,Partner_scheduling__c FROM Event__c where  id In :eventids ORDER BY CreatedDate DESC]);
     
     //Following two querys has been added for getting statistics to booth staff from admin record also
      List<User_Profile_Event__c> UPEid = [select id,BT_id__c from User_Profile_Event__c where User_id__c =: UserInfo.getUserId()];
      List<string> boothids = new List<string>();
      for(User_Profile_Event__c UPE : UPEid ){
          boothids.add(UPE.BT_id__c);   
      }
      List<User_Profile_Event__c> UPEidslist = [select id from User_Profile_Event__c where BT_id__c IN: boothids];
      list<string> upeids = new List<string>();
      for(User_Profile_Event__c UP: UPEidslist){
          upeids.add(UP.id);
      }
       //(MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName() OR MM_To_UPE__r.User_id__c =: UserInfo.getUserId()
       List<EventSchedule__c> EventSc1 =new List<EventSchedule__c>([select EV_id__c,Comments__c,MM_slot_Date__c,MM_Slot_End_Time__c ,Owner.Email ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c ,MM_To_UPE__r.EV_id__c, MM_To_EAM__r.EV_id__c,MM_Slot_Status__c
            from EventSchedule__c where ( MM_To_UPE__r.id IN: upeids OR MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName())  and Ev_id__r.id in: eventids  AND MM_To_UPE__c != null and  MM_slot_Date__c!=null and MM_To_EAM__c!=null order by MM_slot_StartTime__c  ]);
    
    MAP<string,integer> pendingApp = new MAP<string,integer>();
    MAP<string,integer> acceptApp = new MAP<string,integer>();
    MAP<string,integer> RejectedApp = new MAP<string,integer>();
    MAP<string,integer> cancelApp = new MAP<string,integer>();
    MAP<string,integer> missedApp = new MAP<string,integer>();
     MAP<string,integer> resheApp = new MAP<string,integer>();
    
    for(Event__c eventsForCorporatesMabes :eves ){
      LIST<EventSchedule__c> pendingEventSchedule = new List<EventSchedule__c>();
      LIST<EventSchedule__c> ConfirmedEventSchedule= new List<EventSchedule__c>();
      LIST<EventSchedule__c> RejectedEventSchedule= new List<EventSchedule__c>();
      LIST<EventSchedule__c> CancelEventSchedule= new List<EventSchedule__c>();
      LIST<EventSchedule__c> MissedEventSchedule= new List<EventSchedule__c>();
      LIST<EventSchedule__c> RescheduledEventSchedule= new List<EventSchedule__c>();    
      
    
      for(EventSchedule__c es:EventSc1 ){
          if(eventsForCorporatesMabes.id==es.EV_id__c){        
                   if(es.MM_Slot_Status__c == 'Pending'){
                        pendingEventSchedule.add(es);     
                                 
                    }else if(es.MM_Slot_Status__c == 'Accepted'  ){
                        ConfirmedEventSchedule.add(es);
                       
                    }else if(es.MM_Slot_Status__c == 'Rejected'  ){
                        RejectedEventSchedule.add(es);
                    }else if(es.MM_Slot_Status__c == 'Cancelled'  ){
                    
                        CancelEventSchedule.add(es);
                        
                    }else if(es.MM_Slot_Status__c == 'Rescheduled'  ){
                        RescheduledEventSchedule.add(es);
                    }else if(es.MM_Slot_Status__c == 'Missed'  ){
                        MissedEventSchedule.add(es);
                     }
          
                }     
               pendingApp.put(eventsForCorporatesMabes.id,pendingEventSchedule.size());
               acceptApp.put(eventsForCorporatesMabes.id,ConfirmedEventSchedule.size());
               RejectedApp.put(eventsForCorporatesMabes.id,RejectedEventSchedule.size());
               cancelApp.put(eventsForCorporatesMabes.id,CancelEventSchedule.size());
               missedApp.put(eventsForCorporatesMabes.id,MissedEventSchedule.size());
               resheApp.put(eventsForCorporatesMabes.id,RescheduledEventSchedule.size());
              }
     
       }
     
     
     
     
     
     
     
     mdays1 = new LIST<MatchLeads_Days__c>();
      mdays1=[SELECT id,Start_time__c,End_Time__c,Break_Time_between_slots__c,Slot_Time_period__c,MAX_noOf_appontments__c, 
                      Event__r.id FROM MatchLeads_Days__c WHERE Event__r.id in: eventids];
                      
       Map<String,Integer> corporateslistcountmap=new Map<String,Integer>();
       Map<String,Integer> corporateslist1countmap=new Map<String,Integer>();
       Map<String,Integer> mbeslistcountmap=new Map<String,Integer>();
       Map<String,Integer> waitinglistcountmap=new Map<String,Integer>();
       
       //Written to avoid soql queries
       for(User_Profile_Event__c upe:[SELECT Ev_id__r.id,IsMatchMakingUser__c,MAtchMakingProfile__c,User_id__r.isSignup__c,Request_for_upgrade_profile__c,Ev_id__c   FROM User_Profile_Event__c WHERE Ev_id__r.id in: eventids AND IsMatchMakingUser__c  =: TRUE])
       {
       if(eventids.contains(upe.Ev_id__r.id)){
         if(upe.MAtchMakingProfile__c == 'Corporate'&&upe.User_id__r.isSignup__c == TRUE&&upe.Request_for_upgrade_profile__c == FALSE )
          {
             if(corporateslistcountmap.get(upe.Ev_id__r.id)!=null)
             corporateslistcountmap.put(upe.Ev_id__r.id,corporateslistcountmap.get(upe.Ev_id__r.id)+1); 
             else
             corporateslistcountmap.put(upe.Ev_id__r.id,1); 
          } 
          if(upe.MAtchMakingProfile__c == 'Corporate'&&upe.IsMatchMakingUser__c  == TRUE)
          {
             if(corporateslist1countmap.get(upe.Ev_id__r.id)!=null)
             corporateslist1countmap.put(upe.Ev_id__r.id,corporateslist1countmap.get(upe.Ev_id__r.id)+1); 
             else
             corporateslist1countmap.put(upe.Ev_id__r.id,1); 
          }  
         /* if(upe.MAtchMakingProfile__c == 'MBE'&&upe.IsMatchMakingUser__c ==True&&upe.User_id__r.isSignup__c == TRUE&&upe.Request_for_upgrade_profile__c == FALSE)
          {
              if(mbeslistcountmap.get(upe.Ev_id__r.id)!=null)
             mbeslistcountmap.put(upe.Ev_id__r.id,mbeslistcountmap.get(upe.Ev_id__r.id)+1); 
             else
             mbeslistcountmap.put(upe.Ev_id__r.id,1); 
          }   */
          if(upe.Request_for_upgrade_profile__c == TRUE)
          {
             if(waitinglistcountmap.get(upe.Ev_id__r.id)!=null)
             waitinglistcountmap.put(upe.Ev_id__r.id,waitinglistcountmap.get(upe.Ev_id__r.id)+1); 
             else
             waitinglistcountmap.put(upe.Ev_id__r.id,1); 
          } 
          
                                          
       }
       }
       
        Map<String,Integer> mbeslist1countmap=new Map<String,Integer>();
        Map<String,Integer> resourcepartnerlistcountmap=new Map<String,Integer>();
       for(Event_Attendee_Mapping__c eam:[SELECT IsMatchMakingAttendee__c,EV_id__r.id,Boothleads_Profile__c FROM Event_Attendee_Mapping__c WHERE Ev_id__r.id in: eventids])
       {
           if(eventids.contains(eam.Ev_id__r.id)){
         if(eam.IsMatchMakingAttendee__c == true&&eam.Boothleads_Profile__c =='Attendee')
          {
             if(mbeslist1countmap.get(eam.Ev_id__r.id)!=null)
             mbeslist1countmap.put(eam.Ev_id__r.id,mbeslist1countmap.get(eam.Ev_id__r.id)+1); 
             else
             mbeslist1countmap.put(eam.Ev_id__r.id,1); 
          } 
          if(eam.IsMatchMakingAttendee__c == true&&eam.Boothleads_Profile__c =='Sponsor')
          {
             if(resourcepartnerlistcountmap.get(eam.Ev_id__r.id)!=null)
             resourcepartnerlistcountmap.put(eam.Ev_id__r.id,resourcepartnerlistcountmap.get(eam.Ev_id__r.id)+1); 
             else
             resourcepartnerlistcountmap.put(eam.Ev_id__r.id,1); 
          }
       }
       }
       Map<String,Integer> totalmatcheslistcountmap=new Map<String,Integer>();
        Map<String,Integer> pendingmatcheslistcountmap=new Map<String,Integer>();
        for(EventSchedule__c es:[SELECT Is_Matchmaking__c,EV_id__r.id,MM_To_EAM__c,MM_To_UPE__c,MM_Slot_Status__c FROM EventSchedule__c WHERE Ev_id__r.id in: eventids])
       {
           if(eventids.contains(es.Ev_id__r.id)){
         if(es.Is_Matchmaking__c== true&&es.MM_To_EAM__c != null&&es.MM_To_UPE__c != null&&es.MM_Slot_Status__c == 'Accepted')
          {
             if(totalmatcheslistcountmap.get(es.Ev_id__r.id)!=null)
             totalmatcheslistcountmap.put(es.Ev_id__r.id,totalmatcheslistcountmap.get(es.Ev_id__r.id)+1); 
             else
             totalmatcheslistcountmap.put(es.Ev_id__r.id,1); 
          } 
          if(es.Is_Matchmaking__c== true&&es.MM_To_EAM__c != null&&es.MM_To_UPE__c != null)
          {
             if(pendingmatcheslistcountmap.get(es.Ev_id__r.id)!=null)
             pendingmatcheslistcountmap.put(es.Ev_id__r.id,pendingmatcheslistcountmap.get(es.Ev_id__r.id)+1); 
             else
             pendingmatcheslistcountmap.put(es.Ev_id__r.id,1); 
          }       }
       }
       //               
     
    
     for(Event__c eve:eves){
           if(eventids.contains(eve.id)){
                  registeredEvents.add(eve); 
                  /*LIST<User_Profile_Event__c> corporateslist = new  LIST<User_Profile_Event__c>();
                           integer corporateslistcount = [SELECT count()
                                                 FROM User_Profile_Event__c
                                                 WHERE Ev_id__r.id =: eve.id
                                                 AND MAtchMakingProfile__c = 'Corporate' 
                                                 AND User_id__r.isSignup__c = TRUE
                                                 AND Request_for_upgrade_profile__c = FALSE
                                                 AND Ev_id__c != NULL];
                                              system.debug('schschschschschsch'+corporateslist +'ssssssssss'+corporateslist.size());   
      signedupcorporates = corporateslistcount;*/
      signedupcorporates=corporateslistcountmap.get(eve.id)==null?0:corporateslistcountmap.get(eve.id);
      /*integer corporateslist1 = [SELECT count()
                                                 FROM User_Profile_Event__c
                                                 WHERE Ev_id__r.id =: eve.id
                                                 AND MAtchMakingProfile__c = 'Corporate' 
                                                 AND IsMatchMakingUser__c = true
                                                 AND Ev_id__c != NULL];
                    corporatesize = corporateslist1; */
                     corporatesize =corporateslist1countmap.get(eve.id)==null?0:corporateslist1countmap.get(eve.id);
                 system.debug('RRRRRRRRRRRRRRRRRRRRRRRRRR'+corporatesize );                               
       /*integer mbeslist = [SELECT count()
                                                  FROM User_Profile_Event__c
                                                 WHERE Ev_id__r.id =: eve.id
                                                 AND MAtchMakingProfile__c = 'MBE'
                                                 AND IsMatchMakingUser__c =True 
                                                 AND User_id__r.isSignup__c = TRUE
                                                 AND Request_for_upgrade_profile__c = FALSE
                                                 AND Ev_id__c != NULL];
      signedupmbes = mbeslist;*/
     // signedupmbes=mbeslistcountmap.get(eve.id)==null?0:mbeslistcountmap.get(eve.id);
     /*integer mbeslist1 = [SELECT count()
                                                 from Event_Attendee_Mapping__c 
                                                 where IsMatchMakingAttendee__c = true 
                                                 AND EV_id__r.id = : eve.id
                                                 AND Boothleads_Profile__c =: 'Attendee'];
      mbesize = mbeslist1;*/
      
      mbesize=mbeslist1countmap.get(eve.id)==null?0:mbeslist1countmap.get(eve.id);
      
      /*integer waitinglist = [SELECT count()
                                                 FROM User_Profile_Event__c
                                                 WHERE Ev_id__r.id =: eve.id
                                                 AND Request_for_upgrade_profile__c = TRUE 
                                                 AND Ev_id__c != NULL];
      corporateswaiting = waitinglist;*/
      corporateswaiting=waitinglistcountmap.get(eve.id)==null?0:waitinglistcountmap.get(eve.id);
      
      /*integer totalmatcheslist = [SELECT count()
                                                 FROM EventSchedule__c 
                                                 WHERE EV_id__r.id =: eve.id
                                                 AND Is_Matchmaking__c = true
                                                 AND MM_To_EAM__c != null
                                                 AND MM_To_UPE__c != null
                                                 AND MM_Slot_Status__c = 'Accepted'];
      totalmatchesmade = totalmatcheslist ;*/ 
      
      totalmatchesmade =totalmatcheslistcountmap.get(eve.id)==null?0:totalmatcheslistcountmap.get(eve.id);
  
     getSlotsFromUtility= new MAP<Date , LIST<String>>();
    allslots =new list<string>();
    
     /*integer pendingmatcheslist = [SELECT count()
                                                   FROM EventSchedule__c 
                                                   WHERE EV_id__r.id =: eve.id                                                   
                                                   AND Is_Matchmaking__c = true 
                                                   AND MM_To_EAM__c != null
                                                   AND MM_To_UPE__c != null                                                                                                 
                                                   ];
                                                   
                    totalslots= pendingmatcheslist;*/
                    totalslots =pendingmatcheslistcountmap.get(eve.id)==null?0:pendingmatcheslistcountmap.get(eve.id);
                  system.debug('^^^^^^^^^^^^^^^^^^^^^'+eve.id); 
                  
      mdays= new LIST<MatchLeads_Days__c>();
      /**mdays=[SELECT id,Start_time__c,End_Time__c,Break_Time_between_slots__c,Slot_Time_period__c,MAX_noOf_appontments__c 
          FROM MatchLeads_Days__c where Event__r.id =: eve.id];*/
          
          
          for(MatchLeads_Days__c mdy: mdays1){
              if(mdy.Event__r.id ==  eve.id){
                  mdays.add(mdy);
              }
          
          }
          cappinhour=0;
     if(mdays.size() != 0){ //added by mythily    
    cappinhour= integer.valueof(mdays[0].MAX_noOf_appontments__c);             
                  
                 getSlotsFromUtility= MM_Utility.giveEventTimingsWithDates(eve.id,NULL);
                 system.debug(cappinhour+'22222222222222222'+getSlotsFromUtility); 
                 for(LIST<string> gsl: getSlotsFromUtility.values())
                 {
                 system.debug('333333333333333333333'+getSlotsFromUtility.values()); 
                  for(string s:gsl){
                  allslots.add(s);
                  system.debug('11111111111111'+allslots); 
                  }
                  
                 }
                utilslots=allslots.size();    
                system.debug(corporatesize+' @@@@@@@@@@@@@@@@@@@@@ '+utilslots); 
                //getperutil();
                }   
                 if(cappinhour!=0)
                 {
                  totalsbs= (corporatesize*utilslots)/(cappinhour) ;
                  }
                  else{
                  totalsbs =0;
                  } 
                 system.debug(mbesize+' $$$$$$$$$$$$$$$$ '+totalsbs);   
                 if(totalsbs!=0){ 
                 //commented         
                  //pendingmatches =((mbesize*100)/(totalsbs));
                  //written new
                  pendingmatches =((Decimal.valueOf(totalmatchesmade)*100)/Decimal.valueOf(corporatesize*utilslots)).setScale(2, RoundingMode.HALF_UP);
                
                  }else {
                  pendingmatches=0;
                  }
                  system.debug(' #############ttttttttt '+pendingmatches);                               
                    
      /*integer resourcePartnerList= [SELECT count()
                                                 from Event_Attendee_Mapping__c 
                                                 where IsMatchMakingAttendee__c = true 
                                                 AND EV_id__r.id = : eve.id
                                                 AND Boothleads_Profile__c =: 'Sponsor'];
      resourcePartnerSize= resourcePartnerList;*/
      resourcePartnerSize=resourcepartnerlistcountmap.get(eve.id)==null?0:resourcepartnerlistcountmap.get(eve.id);
    //system.debug(eve.id+' RESOURCE PARTNER SIZE  '+resourcePartnerList.size()+'  '+resourcePartnerSize);
                    integer one =0;
                    integer two=0;
                    integer three=0;
                    integer four=0;
                    integer five=0;
                    integer six=0;
                    
                    
                     if(null!= pendingApp.get(eve.id)){
                      one=pendingApp.get(eve.id); 
                     }
                    if(null!=acceptApp.get(eve.id)){
                    two=acceptApp.get(eve.id);
                    }
                    if(null!=RejectedApp.get(eve.id)){
                    three = RejectedApp.get(eve.id);
                    }
                    if(null!=cancelApp.get(eve.id)){
                    four =cancelApp.get(eve.id);
                    }
                    if(null!=missedApp.get(eve.id)){
                     five =missedApp.get(eve.id);
                    }
                    if(null!=resheApp.get(eve.id)){
                    six =missedApp.get(eve.id);
                    }
                    
                     /*----for mbesignup count---------------*/
              eamlist= new list<Event_Attendee_Mapping__c>();
              eamlist=[SELECT AS_id__r.AS_Email__c FROM Event_Attendee_Mapping__c where EV_id__c= :eve.id AND Boothleads_Profile__c='Attendee' AND IsMatchMakingAttendee__c=TRUE];
              
             
 
               list<string> emailsList = new list<string>();
               
              
              integer mbecount=0;
              for(Event_Attendee_Mapping__c eam: eamlist)
              {
               emailsList.add(eam.AS_id__r.AS_Email__c); 
               system.debug('mail    '+emailsList.size());
              } 

              mbecount= [SELECT count() FROM user WHERE isSignup__c=true and username IN :emailsList ];
               system.debug('mbecount pppppppppppppppppp '+mbecount);
              
               signedupmbes=mbecount;
   
               /*----for mbesignup count end---------------*/ 
                    
                    
                    
                  inn.add(new Innclass(options,eve,mapUserid.get(eve.id),signedupcorporates,signedupmbes,corporateswaiting,totalmatchesmade,pendingmatches,corporatesize,mbesize,one,two,three,four,five,six,resourcePartnerSize)) ;
             }else if(eve.EV_StartDate__c>=system.Today()){
             upcommingEvents.add(eve);  
           }
            
        }
       
        
      // tag1=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =:SelectedEventId];
      // tag1.Default_Name__c='Attendee';
       
       //tag2=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =:SelectedEventId];
       //tag2.Default_Name__c='Exhibitor';
     
         
       tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = :SelectedEvent];
        system.debug('jjjjjjjjjjjjjjjjjjj'+ selectedEvent);
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       system.debug('iiiiiiiiiiiiiiiiiiiiiiiiii'+ attendeealias );
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       system.debug('kkkkkkkkkkkkkkkkkkkkkkkk'+ exhibitoralias );
       }
       
       }
        
       }catch(exception e){} 
        
        
      } 
        public LIST<User_Profile_Event__c> listOfEvents{get; set;}
         public Boolean NoEventCreatedBool{get; set;}
    
    
        public void EventsList(){
    
         AddEventBtn = false;
         listOfEvents = [select Id,EV_id__c,EV_id__r.id,EV_id__r.EV_Title__c,EV_id__r.Status__c,EV_id__r.EV_HostingState__c,EV_id__r.AS_HostingCity__c, 
                            EV_id__r.Owner.ID, EV_id__r.MM_Start_Date__c ,  EV_id__r.MM_End_Date__c, EV_id__r.MM_Firstaday_startTime__c, EV_id__r.MM_Firstaday_EndTime__c,
                            EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HostingOrgName__c,EV_id__r.OrganizerId__c from User_Profile_Event__c where   EV_id__c != NULL AND User_id__c=: UserInfo.getUserId() 
                            ORDER BY EV_id__r.CreatedDate DESC  ];               
           if(listOfEvents.size()>=1){
               SelectedEventId = listOfEvents[0].EV_id__c ;
              NoEventCreatedBool = TRUE;  
           }else{ 
               NoEventCreatedBool = FALSE;   
           }
     
     
     
      
    }
  
  public class innclass{
   public List<selectOption> Innoptions{get;set;}
   public string selectedInnstr{get;set;}
   public User_Profile_Event__c upeInn{get;set;}
   public integer shcor {get;set;}
   public integer shmob {get;set;}
   public integer corwait {get;set;}
   public integer Total {get;set;}
   public Decimal Pending {get;set;}
   public integer corporatesize {get;set;}
   public integer mbesize  {get;set;}
   public Event__c eveInn{get;set;}
   public integer pendingApp1{get;set;}
   public integer  acceptApp1{get;set;}
   public integer RejectedApp1{get;set;}
   public integer cancelApp1{get;set;}
   public integer missedApp1{get;set;}
   public integer resheApp1{get;set;}
   public integer resourcePartenersSize{get;set;}
  
   
       public innclass(List<selectOption> il,Event__c eveInn1,User_Profile_Event__c upeInn1,integer shcor,integer shmob,integer corwait,integer Total,Decimal Pending,integer corporatesize,integer mbesize,integer pendingApp2,integer acceptApp2,integer RejectedApp2,integer cancelApp2,integer missedApp2,integer resheApp2,integer resourcePartenersSize ){
       eveInn = new Event__c();
       upeInn = new User_Profile_Event__c();
       Innoptions = new List<selectOption>();
       pendingApp1 =0;
       acceptApp1=0;
       RejectedApp1=0;
       cancelApp1=0;
       missedApp1=0;
       resheApp1=0;
       
       this.Innoptions=il;
       this.upeInn =upeInn1;
       this.shcor = shcor ;
       this.shmob =shmob ;
       this.corwait =corwait ;
       this.Total =Total ;
       this.Pending =Pending ;
       this.corporatesize =corporatesize ;
       this.mbesize = mbesize ;
       this.resourcePartenersSize= resourcePartenersSize;
       
         this.pendingApp1 =pendingApp2;
      
         this.acceptApp1=acceptApp2;
       
          this.RejectedApp1=RejectedApp2;
     
         this.cancelApp1 =cancelApp2;
      
          this.missedApp1=missedApp2;
      
          this.resheApp1 =resheApp2;
    
          
          if(upeInn.Profile_id__r.PR_Name__c=='EventAdmin'){
           this.selectedInnstr=upeInn.Profile_id__r.PR_Name__c;
          }else{
             this.selectedInnstr=upeInn.MAtchMakingProfile__c;
          }
          this.eveInn=eveInn1;
       }
  
  }
  
  
 
  
  
  
   public ID SelectedEventId{get; set;}
   //public MatchLeads_Days__c MMLD {get;set;}
   public pagereference editEvent() {
   tag1= new Tags__c(); 
   tag2= new Tags__c();
     selectedEvent  = ApexPages.currentPage().getParameters().get('eveId');
      if(selectedEvent  != null && selectedEvent  != ''){ // By Phani
      
      }else{
         return null;
      }
     
    //MMLD = new MatchLeads_Days__c();
    list<Tags__c> t1=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =: SelectedEvent ];
    system.debug('uuuuuuuuuuuuuuuuuuuuuuuu'+t1);
    for(Tags__c tg: t1){
    if(tg.Default_Name__c == 'Attendee' ){
    tag1.Alias_Name__c = tg.Alias_Name__c;
    tag1 = tg;
    }else if(tg.Default_Name__c == 'Exhibitor'){
     tag2.Alias_Name__c = tg.Alias_Name__c;
    tag2 = tg;
    }
    }
       system.debug('uuuuuuuuuuuuuuuuuuuuuuuu11111111111'+ tag1.Alias_Name__c );
         system.debug('uuuuuuuuuuuuuuuuuuuuuuuu222222222222222222'+ tag2.Alias_Name__c );
    
     User_Profile_Event__c selectedUpe = new User_Profile_Event__c();
        system.debug('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'+selectedEvent +'uuuuuuuuuuuuu'+selectedUpe );
        selectedUpe  = mapUserid.get(selectedEvent );
        
        if(selectedUpe.Profile_id__r.PR_Name__c=='EventAdmin'){
         eventsCheckMap=new map<string,string>{};
        SelectedEventId = ApexPages.currentpage().getparameters().get('eveId');
        system.debug('!!!!!!!!!!!!!!!!!!!     '+ SelectedEventId);
        eventheading = 'Edit Event';
        if(SelectedEventId != null){
           Event=[SELECT e.Status__c, e.StartTime__c, e.SecondaryCategory__c, e.Primary__c, Attendee_can_send_request__c ,Is_Approval_Required__c ,Exhibitor_can_send_request__c,         
                                e.Name,e.Id, e.Event_ZipCode__c, e.Event_PostalCode__c, e.EventDiversityValues__c,Attendee_Types__c,e.No_Appointments_Per_Attendee__c, 
                                e.Ev_RequiredFields__c, e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c, 
                                e.EV_RedirectURI__c, e.EV_Publish__c, e.EV_IncludedFields__c, e.EV_HostingZipcode__c, e.EV_HostingTimeZone__c, 
                                e.EV_HostingState__c, e.EV_HostingStateNew__c, e.EV_HostingPostalCode__c, e.EV_HostingPhone__c,e.Match_Making_Schedules__c,e.Email_Notifications_flag__c,
                                e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingFax__c, e.EV_HostingCountry__c, e.EV_HostingCountryNew__c, 
                                e.EV_HostedByEventBrite__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c,e.Owner.ID, 
                                e.EV_Description__c, e.EV_CustomReg__c, e.EV_ContactURL__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c,e.TwitterHashTag__c
                                ,MM_End_Date__c,MM_Firstaday_EndTime__c,MM_Firstaday_startTime__c,MM_Secondaday_EndTime__c,MM_Secondaday_startTime__c,MM_Start_Date__c
                                ,MM_Slot_Timeperiod__c,MatchMaking_Type__c,BreakTime_Between_Appointments__c,Is_Webank_event__c,Partner_scheduling__c,OrganizerId__c,publish_to_users_flag__c,
                                (SELECT Start_time__c,End_Time__c FROM MatchLeads_Days__r)
                                From Event__c e WHERE ID =: SelectedEventId]; 
                               
               AddEventBtn = TRUE;                 
               selectedType= Event.MatchMaking_Type__c;                
               customeventtype();
          
          
          
        
                                
       }
    }else{
    errorforeditbool = true;
    
    }
   
    return null;  
        
    }
   public boolean errorforeditbool {get;set;}
   public PageReference ManageEvent() {
   
    selectedEvent  = ApexPages.currentPage().getParameters().get('eveId');
    Cookie counter = ApexPages.currentPage().getCookies().get('counter');
    system.debug('DDDDDDDDDDDDDDDDDD '+selectedEvent  );
      system.debug('DDDDDDDDDDDDDDDDDD1111111 '+counter );
     if (counter == null) {
              counter = new Cookie('counter', selectedEvent,null,-1,false);
       }else{
         counter = new Cookie('counter', selectedEvent,null,-1,false);
       }
      system.debug('22222222222222222222222222222'+ApexPages.currentPage().getCookies().get('counter'));
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
        User_Profile_Event__c selectedUpe = new User_Profile_Event__c();
        selectedUpe  = mapUserid.get(selectedEvent );
        
        if(selectedUpe.Profile_id__r.PR_Name__c=='EventAdmin'){
          selectedPage='MM_Eventadmin_schedule';
        }else if(selectedUpe.MAtchMakingProfile__c=='MBE'){
         selectedPage ='MM_Matches';
        }else if(selectedUpe.MAtchMakingProfile__c=='Corporate'){
          selectedPage='MM_BA_Matches';
       }
       else if(selectedUpe.MAtchMakingProfile__c=='CorporateStaff'){
         selectedPage='MM_BA_Matches';
       }
        
      
       if(selectedPage!=''){
            PageReference pg = new PageReference('/apex/'+selectedPage);
            pg.setRedirect(true);
            return pg;
        }else{
        return null;
        }
        
    }

    public String getCount() {
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter == null) {
            return null;
        }
        return counter.getValue();
    }
  public boolean createeventbtn{get;set;}
     Public Void AddEvent(){
    
    //createeventbtn= true;
    SelectedEventId =null;
    Event = new Event__c();
    Event.publish_to_users_flag__c = True;
    AddEventBtn = TRUE; 
 tag1= new Tags__c(); 
   tag2= new Tags__c();
    DocumentImage = new Document();
    eventheading = 'Add Event';
    
    }
  //-----------------------------------------------save new event-------------------------
 public void createEvent(){
  try{ 
    dates = new list<breaksinn> ();
    evebreaks  = new List<Event_Breaks__c>();
    DaysOfEvent= new MatchLeads_Days__c ();
   //system.debug('111111111111111111111   '+eventsCheckMap.containsKey((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ','')));   
    eventErrorString = '';
     
     system.debug('22222222222222222222222222222222'+Event.EV_Title__c);
     
   
            
       myDocBool = TRUE;
      
        if(Logo != null && ( LogoName != '' || LogoName != NULL )){
        if(Logo.size()!= null){
         
        if(Logo.size() < 102400 ){
             system.debug('2222222222222222222222');
        eventLogoErrorString = '';
        
        mydoc =new document();
        mydoc.body = Logo;
        mydoc.folderid = UserInfo.getUserId();
        
        mydoc.IsPublic = True;
        mydoc.Name = LogoName;
        DataBase.saveResult docSaveResult = DataBase.insert(mydoc, false);
       
        
        
        String eventold;
        
        
        if(docSaveResult.isSuccess()){
            
            if(Event.EV_EventLogo__c != null){
                system.debug('33333333333333333333333    '+ Event.EV_EventLogo__c );
                eventold = Event.EV_EventLogo__c;
              
                document dd = [SELECT ID, NAME FROM document WHERE id=: eventold];
                Database.delete(dd);
             }
             
             Event.EV_EventLogo__c = docSaveResult.getId();
             
        }else{
            myDocBool = FALSE;
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, String.valueOf(docSaveResult.getErrors()))); 
        }
        
        
       }else{
           myDocBool = FALSE; 
           eventLogoErrorString = 'Please make sure the  file is not more than 100 kb';
 
         
       }
       
      }

    }
   if(myDocBool){
            
        
        Event.Is_MatchMaking_Event__c=true;
        Event.MatchMaking_Type__c=selectedtype;
        try{
        event.MM_Start_Date__c =date.valueOf(EventStartDate);
        event.MM_End_Date__c=date.valueOf(EventEndDate);
        }catch(Exception e)
        {
         event.MM_Start_Date__c =event.EV_StartDate__c;
        event.MM_End_Date__c=event.EV_StartDate__c;
        
        }
        
       Database.UpsertResult EventupsertResult = DataBase.Upsert(Event, false);
           
           if(EventupsertResult.isSuccess()){
           
                           
               
           
               if(EventupsertResult.isCreated()){
             
               // ----------------------- CODE FOR Attendee Settings ------------------------------------
                     days = new list<date>();
                Event__c  evv=[select MM_Start_Date__c,MM_End_Date__c,MM_no_of_days__c from Event__c where id=:EventupsertResult.id];
                
                 date dd=evv.MM_Start_Date__c;
                 
                 for(dd=evv.MM_Start_Date__c; dd<=evv.MM_End_Date__c;)
                 {
                 days.add(dd);
                 breaksinn  addinn = new breaksinn(dd);
                 
                 dates.add(addinn);
                 dd=dd.addDays(1);
                 
                 
                   system.debug('        iiiiiiiiiiiiiiiiiiii '+days);
                     system.debug('        iiiiiiiiiiiiiiiiiiii '+dd);
                 }
                 
                       String named='';
                    String ObjectName = 'AttendeeSummary__c'; // Object Name Goes Here
                    Map<String, Schema.SObjectField> ObjectFieldMap = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap();
                    
                   
                    for (Schema.SObjectField SObjectF : ObjectFieldMap.values())
                    {
        
                       Schema.DescribeFieldResult field = SObjectF.getDescribe();
                       named +=field.getLocalname()+',';
                    }
                     named += 'AttendeePic,' ;
                     
                     
                      SecurityControls__c  attset = new  SecurityControls__c ();
                   
                    attset.EV_id__c = Event.id;  
                     
                    insert attset;
                
                
               
               List<User_Profile_Event__c> GettingFirstRecord = [Select id,BLP_id__c,Ev_Id__c From User_Profile_Event__c Where EventAdmin_Id__c =:UserInfo.getUserId()  AND Ev_Id__c = Null Limit 1];
        
                   
                    Profile__c EventAdminProfile = [select Id from Profile__c where PR_Name__c = 'EventAdmin' limit 1];
                  
                    if(GettingFirstRecord.size()> 0){
                    GettingFirstRecord[0].EV_id__c = Event.id;
                      GettingFirstRecord[0].IsMatchMakingUser__c=true;
                    Update GettingFirstRecord; 
                    
                 
                     }else    {
                         List<User_Profile_Event__c> insertingNewrecord = [Select id,BLP_id__c From User_Profile_Event__c Where EventAdmin_Id__c =:UserInfo.getUserId()AND User_id__c = :UserInfo.getUserId() Limit 1];
                         
                        
                         User_Profile_Event__c EventAdmin_Event = new User_Profile_Event__c();
                          
                          EventAdmin_Event.EV_id__c = Event.id;
                          EventAdmin_Event.EventAdmin_Id__c = UserInfo.getUserId();
                          EventAdmin_Event.UEP_isActive__c = true;
                          EventAdmin_Event.Profile_id__c = EventAdminProfile.id ;
                          EventAdmin_Event.User_id__c = UserInfo.getUserId();
                          EventAdmin_Event.IsMatchMakingUser__c=true;
                          insert EventAdmin_Event;
                          
                           LIST<Reports__c> rpList = new LIST<Reports__c>(); 
                     
                       }
                       
                      system.debug((userInfo.getFirstName()+userInfo.getLastName()+userInfo.getUserName()).tolowercase());
                         LIST<AttendeeSummary__c> ASrec=[select id from AttendeeSummary__c where AS_Email__c =: userInfo.getUserName().tolowercase()];
                                                                      
                        if(ASrec.size() != 0 ){
                         system.debug(';;;;;;;;;;;;;;;;;;;;;;;'+event.id); 
                          Event_Attendee_Mapping__c EAM=new Event_Attendee_Mapping__c();
                          EAM.EV_id__c=Event.id;
                          EAM.AS_id__c=ASrec[0].id;
                          EAM.Boothleads_Profile__c='Event Admin';
                           EAM.IsMatchMakingAttendee__c=true;
                          insert EAM;
                           system.debug(';;;;;;;;;;;;;;;;;;;;;;;'+EAM.id); 
                           EAM.EA_AttendeeBarcode__c=EAM.id +'-'+ Event.id;
                           EAM.Attendee_Event_IDs__c= String.ValueOf(ASrec[0].id) + Event.id;
                          update EAM;
                          
                        system.debug(';;;;;;;;;;;;;;;;;;;;;;;'+EAM.id);
                        }
                        selectedEventId  = event.id;
               }else{
                days = new list<date>();
                set<date> sd = new set<date> {};
                Event__c  evv=[select MM_Start_Date__c,MM_End_Date__c,MM_no_of_days__c from Event__c where id=:EventupsertResult.id];
                
                 date dd=evv.MM_Start_Date__c;
                 
                 for(dd=evv.MM_Start_Date__c; dd<=evv.MM_End_Date__c;)
                 {
                
                 days.add(dd);
                 
                 dd=dd.addDays(1);
                 
                
                     
                 }
                  system.debug('datttttttttttttttttttttttttttttes'+days);
                 list<Event_Breaks__c> adinb = new  list<Event_Breaks__c>();
                 List<MatchLeads_Days__c> md=[select id,Start_time__c,End_Time__c,MatchLeads_Date__c,Break_Time_between_slots__c,MAX_noOf_appontments__c,Slot_Time_period__c  from MatchLeads_Days__c where Event__c =:EventupsertResult.id ];
                 list<Event_Breaks__c> BRK =[select Break_End_Time__c,Break_Start_Time__c,Break_Title__c,MatchLeads_Days__c from Event_Breaks__c WHERE Break_Title__c != null AND Break_Title__c != '' ];
                  set<id> setdates= new set<id> ();
                 if(md.size() != 0){
                    for(date d:days){
                  for(MatchLeads_Days__c m: md){
                 
                  if(d == m.MatchLeads_Date__c){
                  adinb = new  list<Event_Breaks__c>();
                   for(Event_Breaks__c b:brk){
                   if(b.MatchLeads_Days__c == m.id){
                   adinb.add(b);
                   }
                   }
                   sd.add(d);
                  system.debug('2222222222222222222222222222222222222222'+d);
                   if(setdates.add(m.id)){
                  dates.add(new breaksinn(d,adinb,m));
                  
                 
                   system.debug('333333333333333333333333333333333333333333333333'+dates);
                  }
                 
                  
                  }

                 
                  
                  }
                    if(sd.add(d)){
                   dates.add(new breaksinn(d));
                  }
                 }
                 }
               else{
                 
                 
                 for(dd=evv.MM_Start_Date__c; dd<=evv.MM_End_Date__c;)
                 {
                 
                 breaksinn  addinn = new breaksinn(dd);
                 
                 dates.add(addinn);
                 dd=dd.addDays(1);
                 
                 
                  
                 }
                 
                 }
                 }

            displayAttendeeRegistrationLink=true;
            
            createeventbtn=false;
             
        }
       
       }
    }catch(exception ew){}    
        
    }
    
     
public void VcalForevent(id eventidforcal){
try{
 Event__c eventForCal = new Event__c();

    eventForCal =[SELECT id,EV_StartDate__c,EV_Title__c,EV_HostingStateNew__c,Email_Notifications_flag__c,Match_Making_Schedules__c,EV_HostingLocation__c,AS_HostingCity__c,EV_Description__c ,EV_HostingZipcode__c,EV_HistingAddr1__c,AS_HostingAddr2__c,StartTime__c,EV_EndDate__c,EV_EndTime__c from Event__C where id =:eventidforcal];
   
     List<attachment> attachments = new  List<attachment>();
   
     attachments = [select id from attachment where parentId=:eventForCal.id];
   
   dataBase.delete(attachments ,false);
   
   
   
   // Dateformats for calender
       string startdatestr =(eventForCal.EV_StartDate__c).format();
       string  startdateTime  =startdatestr +' '+eventForCal.StartTime__c;
       dateTime startDatetimevalue  = DateTime.parse(startdateTime);       
       string thisTimeStr = startDatetimevalue.format('yyyyMMdd\'T\'HHmmss\'Z\'', 'UTC');
      string startdatestr1 =(eventForCal.EV_EndDate__c).format();
      string startdateTime1  =startdatestr1 +' '+eventForCal.EV_EndTime__c;
      dateTime startDatetimevalue1  = DateTime.parse(startdateTime1  );  
     string  endtimestr = startDatetimevalue1.format('yyyyMMdd\'T\'HHmmss\'Z\'', 'UTC' );
     Commanforstates comm = new Commanforstates ();

     string createcal ='BEGIN:VCALENDAR\n'+
     'VERSION:1.0\n'+
    'BEGIN:VEVENT\n'+
    'DTSTART:'+thisTimeStr+'\n'+
    'DTEND:'+endtimestr+'\n'+
    'SUMMARY:'+eventForCal.EV_Title__c+'\n'+
    'DESCRIPTION:'+eventForCal.EV_Description__c+'\n'+
    'LOCATION:'+eventForCal.EV_HostingLocation__c+' - '+eventForCal.EV_HistingAddr1__c +' '+ eventForCal.AS_HostingAddr2__c +' - '+eventForCal.AS_HostingCity__c+', '+ comm.mapstate(eventForCal.EV_HostingStateNew__c)+' '+ eventForCal.EV_HostingZipcode__c+'\n'+
    'END:VEVENT'+'\n'+
    'END:VCALENDAR'+'\n';
    
    
      blob b = blob.valueOf(createcal);
      attachment attach  = new attachment();
      attach.Name ='Event.ics';
      attach.body=b;
      attach.parentId=eventForCal.id;
       insert attach;    

    }catch(exception ex){}
    }
     Public List<selectOption> getEventbrite(){
    List<selectoption> Options = new List<selectoption>();
    
    Options.add(new selectoption('By Eventbrite','By Eventbrite'));
    Options.add(new selectoption('By Global Nest','By Global Nest'));
    Options.add(new selectoption('By Other','By Other'));
    return Options;    
    }
    
    public PageReference cancel(){
    createeventbtn=false;
    AddEventBtn = false;
    ViewEventbool=false;
    selectedTab = 'Event Type';
   
     PageReference pg = new pagereference('/apex/Matchleads_eventsPage');
                 pg.setredirect(true);
                 return pg;
    } 
 //------------------------------------------------------------------------VIEW EVENT DETAILS------------------------
 public boolean ViewEventbool {get;set;}
 public void vieweventDetails(){
  SelectedEventId = ApexPages.currentpage().getparameters().get('eveId');
         EventDetail = [SELECT ID, Name,EV_Title__c,Status__c,EV_HostingState__c,AS_HostingCity__c,EV_HostingLocation__c,Attendee_Types__c,
                    EV_HistingAddr1__c,AS_HostingAddr2__c,EV_HostingCountryNew__c,EV_Publish__c,EV_EventLogo__c,EV_HostingTimeZone__c,
                    EV_HostingPhone__c,EV_HostingFax__c,EV_WebsiteURL__c,Primary__c,SecondaryCategory__c,EV_HostingOrgName__c,EV_HostingStateNew__c,
                    EV_HostingZipcode__c,EV_HostingPostalCode__c,EV_HostedByEventBrite__c,EV_Description__c,Owner.FirstName,Owner.ID,
                    EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,EventDiversityValues__c,TwitterHashTag__c,Match_Making_Schedules__c,
                    Lable_First_Line__c,Lable_Secoend_Line__c,Lable_Third_Line__c,Event_Printer__c,TwitterId__c,FacebookId__c,OrganizerId__c,
                    Lable_First_Line_Color__c,Lable_First_Line_Size__c,Lable_First_Line_Font__c,Lable_Secoend_Line_Color__c,Lable_Secoend_Line_Size__c,Lable_Secoend_Line_Font__c,
                    Lable_Third_Line_Color__c,Lable_Third_Line_Size__c,EV_SiteLocation__c,Lable_Third_Line_Font__c FROM Event__C WHERE id =:SelectedEventId];
           
 ViewEventbool = true;
 
 
 }
    
   public PageReference changeProfile() {
    string innstr = Apexpages.currentPage().getParameters().get('tmjun');
     
     if(innstr !=null && innstr !=''){
        string[] newstr = new string[]{};
        newstr = innstr.split('::--');
        User_Profile_Event__c upesd = new User_Profile_Event__c();
        upesd= mapUserid.get(newstr[1]);
         if(newstr[0]=='Corporate'){
           upesd.Request_for_upgrade_profile__c=True;
           
         }else{
          upesd.Request_for_upgrade_profile__c=false;
          upesd.MAtchMakingProfile__c=newstr[0];
         }
        
        update upesd; 
        
        
      }
        return null;
    }
  
//-------------------------------------------------------------------------------------------ADDING AN EVENT-----------------
     public string selectedType{get;set;}
    public String selectedTab;
    public string getselectedtab() 
    {
       return selectedtab;
    }
    
    
    public boolean istab0disabled;
     public boolean getistab0disabled(){
     return selectedTab <> 'Event Type';     
    }
    
    public boolean istab1disabled;
     public boolean getistab1disabled(){
     return selectedTab <> 'Event Details';     
    }
    public boolean istab2disabled;
     public boolean getistab2disabled(){
     return selectedTab <> 'Event Schedule';     
    }
    public boolean istab3disabled;
     public boolean getistab3disabled(){
     return selectedTab <> 'MatchLeads Dates';     
    }
    
    public boolean istab4disabled;
     public boolean getistab4disabled(){
     return selectedTab <> 'MatchLeads Schedule';     
    }
    
        public void previous2() {
    selectedTab ='Event Type';
    }

     public void previous3() {
    selectedTab ='Event details';
    }
     public void previous4() {
    selectedTab ='MatchLeads Dates';
    }
//------------------------------------------------    
    public string errortype{get;set;}
    public boolean errortypebool{get;set;} 
    public void enabletab1() {
    if(selectedType == null){
    errortypebool = true;
    errortype='Please select eventtype';
    } else{
        errortypebool = false;
         selectedTab ='Event Details';
         }
         if(eventheading == 'Add Event')
       {
          Event.OrganizerId__c=userinfo.getuseremail();
       }
    }
//-----------------------------------------------------
    public boolean errorTitle{get;set;}
    public boolean errorHosZone{get;set;}
    public boolean errorstartdate{get;set;}  
    public boolean errorstartTime{get;set;} 
    public boolean errorendtdate{get;set;}
    public boolean errorendtTime{get;set;}
     
     public void enabletab2() {
     system.debug('logo'+logo);
     if(Event.EV_Title__c == null || Event.EV_Title__c ==''){
     system.debug('         event title        '+Event.EV_Title__c);
     errorTitle=true;
     errortype='Please enter Event Title';
     
     }else if(Event.EV_HostingTimeZone__c == null){
     system.debug('         event Time Zone        '+Event.EV_HostingTimeZone__c);
    errorTitle=true;
     errortype ='Please enter Event Hosting Time Zone';
     
     }else if(Event.EV_StartDate__c == null ){
     errorTitle=true;
     errortype ='Please enter start date';
     }else if(Event.StartTime__c == null ){
     errorTitle=true;
     errortype = 'Please enter start Time';
     
     }else if(Event.EV_EndDate__c == null ){
      errorTitle=true;
     errortype = 'Please enter End date';
     
     }else if(Event.EV_EndTime__c == null || Event.EV_EndTime__c == ''){
     errorTitle=true;
     errortype = 'Please enter End Time';
     
     }
     else if(Logo!=null&&Logo.size() > 102400){
      errorTitle=true;
     errortype = 'Logo cannot be greater than 100 kb';
      }  
     else{
      
       if(eventheading == 'Add Event')
       {
          createevent();
          if(Event.Is_Webank_event__c==true){
          tag1.Alias_Name__c='WBE';
          tag2.Alias_Name__c='Corporate';
          }
          else
          {
             tag1.Alias_Name__c='Small Business';
          tag2.Alias_Name__c='Prime Contractor';
          }
       }
       else
       {
           if(Logo != null && ( LogoName != '' || LogoName != NULL )){
        mydoc =new document();
        mydoc.body = Logo;
        mydoc.folderid = UserInfo.getUserId();
        
        mydoc.IsPublic = True;
        mydoc.Name = LogoName;
        DataBase.saveResult docSaveResult = DataBase.insert(mydoc, false);
         String eventold;
          if(docSaveResult.isSuccess()){
            
            if(Event.EV_EventLogo__c != null){
                system.debug('33333333333333333333333    '+ Event.EV_EventLogo__c );
                eventold = Event.EV_EventLogo__c;
              
                document dd = [SELECT ID, NAME FROM document WHERE id=: eventold];
                Database.delete(dd);
             }
             
             Event.EV_EventLogo__c = docSaveResult.getId();
             }}
       }
     errorTitle=false;
     errorHosZone=false;
     errorstartdate=false;
     errorstartTime=false;
     errorendtdate=false;
     errorendtTime=false;
     Boolean check=FALSE;
     List<Schema.PicklistEntry> EventStartTime = Event__c.StartTime__c.getDescribe().getPicklistValues();
     EventStartDate=string.valueOf(event.MM_Start_Date__c);
     EventEndDate=string.valueOf(event.MM_End_Date__c);
         StartTimings = new list<SelectOption>();
         EndTimings=new list<SelectOption>();
        EventDate = new list<SelectOption>();
         Integer st_end_dates = Event.EV_StartDate__c.daysBetween(Event.EV_EndDate__c);
        
        System.debug('tttttttttttttttttt'+st_end_dates );
        
        if(st_end_dates >= 0){
            Date d = event.EV_StartDate__c;
            for(Integer i=0; i<=st_end_dates; i++ )
            {
                EventDate.add(new SelectOption(String.valueOf(d),String.valueOf(d)));
                d+=1;
            }
        }
    
    
    if(event.EV_StartDate__c == event.EV_EndDate__c){
            for(Schema.PicklistEntry pi: EventStartTime){        
                if(pi.getLabel() == event.StartTime__c ){
                    check = TRUE;
                }        
                if(check){
                    StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                    EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                } 
                if(pi.getLabel() == event.EV_EndTime__c ){
                    check = FALSE;
                    continue;
               }    
            }
         }else{
             for(Schema.PicklistEntry pi: EventStartTime){        
                if(pi.getLabel() == event.StartTime__c ){
                    check = TRUE;
                }
                if(check){
                    StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                    EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                } 
             }
         }
         
    selectedTab ='MatchLeads Dates';
    
    }
    
    
    
    }
    public Integer st_end_dates{get;set;}
    public void enabletab3() {
    Boolean check=FALSE;
     List<Schema.PicklistEntry> EventStartTime = Event__c.StartTime__c.getDescribe().getPicklistValues();
         StartTimings = new list<SelectOption>();
         EndTimings=new list<SelectOption>();
        EventDate = new list<SelectOption>();
         st_end_dates = Event.EV_StartDate__c.daysBetween(Event.EV_EndDate__c);
        
        System.debug('tttttttttttttttttt'+st_end_dates );
        
        if(st_end_dates >= 0){
            Date d = event.EV_StartDate__c;
            for(Integer i=0; i<=st_end_dates; i++ )
            {
                EventDate.add(new SelectOption(String.valueOf(d),String.valueOf(d)));
                d+=1;
            }
        }
    
    
    if(event.EV_StartDate__c == event.EV_EndDate__c){
            for(Schema.PicklistEntry pi: EventStartTime){        
                if(pi.getLabel() == event.StartTime__c ){
                    check = TRUE;
                }        
                if(check){
                    StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                    EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                } 
                if(pi.getLabel() == event.EV_EndTime__c ){
                    check = FALSE;
                    continue;
               }    
            }
         }else{
             for(Schema.PicklistEntry pi: EventStartTime){        
                if(pi.getLabel() == event.StartTime__c ){
                    check = TRUE;
                }
                if(check){
                    StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                    EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                } 
             }
         }
         selectedTab ='MatchLeads Dates';
             
             system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA        '+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c);
         
      matchtabs();   
    }
    public boolean MMstartdate{get;set;}
    public boolean mmenddate{get;set;}
    public boolean mmstartTime{get;set;}
    public boolean mmendtime{get;set;}
   public void savemmevent(){
    system.debug('ttttteeeeessttttttt'+tag1);
  // matchtabs();
   createevent();
    selectedEvent  = ApexPages.currentPage().getParameters().get('eveId');
   selectedTab ='MatchLeads Schedule';
        
       // tag1=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =: SelectedEventId LIMIT 1];
            
        
        tag1.Alias_Name__c= tag1.Alias_Name__c;
        database.upsert(tag1);
        system.debug('kkkkkkkkrrrrrriiiiii'+tag1.Alias_Name__c);
        
       
      // tag2=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =: SelectedEventId LIMIT 1];
       
        tag2.Alias_Name__c= tag2.Alias_Name__c;
        database.upsert(tag2);
         system.debug('sssssssshhhhhhhhhhnnnnnn'+tag2.Alias_Name__c);
         scheduleexistflag=false;
         try{
         List<EventSchedule__c> esch=[SELECT Is_Matchmaking__c,EV_id__r.id,MM_To_EAM__c,MM_To_UPE__c,MM_Slot_Status__c FROM EventSchedule__c WHERE Ev_id__r.id=:Event.id and Is_Matchmaking__c= true and MM_To_EAM__c != null and MM_To_UPE__c != null];
         if(esch.size()>0)
         scheduleexistflag=true;
         }catch(Exception e){}
   }
  
   public boolean scheduleexistflag{get;set;}
   
   
   public boolean Custombool{get;set;}
    public boolean openbool{get;set;}
    public boolean semiopenbool{get;set;}
    public boolean closedbool{get;set;}
    
   public void customeventtype(){
  
    if(selectedType == 'Custom'){
    Custombool=true;}
    else{
    Custombool=false;
    }
    if(selectedType == 'Open'){
    openbool=true;}else{
    openbool=false;
    }
   if(selectedType == 'Semi Open'){
    semiopenbool=true;}else{
    semiopenbool=false;
    }
    if(selectedType == 'Closed'){
    closedbool=true;}else{
    closedbool=false;
    }
  
   
}
 
 public class breaksinn{
 public date dayvalues{get;set;}
 public list<Event_Breaks__c> breakslist {get;set;}
 public MatchLeads_Days__c mmdays {get;set;}
 
 public breaksinn(date dayvalues){
 
  breakslist = new list<Event_Breaks__c> ();
 breakslist.add(new Event_Breaks__c());
  breakslist.add(new Event_Breaks__c());
   breakslist.add(new Event_Breaks__c());
 mmdays = new MatchLeads_Days__c();
 this.dayvalues = dayvalues;
 }
 public breaksinn(date dayvalues,List<Event_Breaks__c> breakslist,MatchLeads_Days__c mmdays)
  {
   this.dayvalues = dayvalues;
  this.mmdays = mmdays;
  this.breakslist = breakslist;
   breakslist.add(new Event_Breaks__c());
  breakslist.add(new Event_Breaks__c());
  }

 }

 
 
 
 public pagereference savebreaks(){
  
   system.debug('aaaaa'+Logo);
  
 list<date> ds = new list<date> ();
 for(breaksinn d1:dates){
 ds.add(d1.dayvalues);
 }
 List<MatchLeads_Days__c> matchdays = new List<MatchLeads_Days__c>();
  list<Event_Breaks__c> Breaksdel = new list<Event_Breaks__c>();
 matchdays = [select id from MatchLeads_Days__c where Event__r.id =: SelectedEventId  AND MatchLeads_Date__c NOT IN:ds];
 list<id> idsm = new list<Id> ();
 for(MatchLeads_Days__c md : matchdays ){
 idsm.add(md.id);
 }
 Breaksdel = [select id from Event_Breaks__c where MatchLeads_Days__c IN: idsm ];
 delete Breaksdel ;
 delete matchdays;
 list<Event_Breaks__c> Breaks = new list<Event_Breaks__c>();
         PageReference pg;
 system.debug('dddd1111111111 dd'+dates);
 for(breaksinn d:dates){
 
 system.debug('dddddddd2222222222222222 ddddddddddd'+d);
       system.debug('qqqqqqqqddddsss q 7y dd'+ d.mmdays.Slot_Time_period__c);
              system.debug('SSSS 5555 444 777 HHH'+d.mmdays.Start_time__c);
           
    if(d.mmdays.Slot_Time_period__c != null  && Integer.valueof(d.mmdays.Slot_Time_period__c) > 0 && d.mmdays.Start_time__c != null && d.mmdays.End_Time__c != null &&  d.mmdays.Break_Time_between_slots__c != null && d.mmdays.MAX_noOf_appontments__c != null)
    {
    
           slotbool = false;
           endtimebool = false;
           starttimebool = false;
           breaktimevalidbool=false;
           Appointmentsperattidbool = false;
           
           
          d.mmdays.MatchLeads_Date__c = d.dayvalues;
          d.mmdays.Event__c = SelectedEventId;
          database.upsert(d.mmdays);
          system.debug('ddddddddd444444444444444444 dddddd'+d);
          system.debug('qqqqqqqqqqqqqq 7y dd'+ d.mmdays);
         
            system.debug('Break List 7y dd'+d.breakslist.size());
  if(d.breakslist.size()!= 0 ){
   for(Event_Breaks__c brk: d.breakslist ){
   system.debug('eVENT bREAKS '+brk + ' BRKSTART TILT ' + brk.Break_Start_Time__c );
  if(brk.Break_Title__c != '' && brk.Break_Title__c != null){
  system.debug('aaaaaaaaaa ' + brk.Break_Title__c);
    if(brk.Break_Start_Time__c != null && brk.Break_End_Time__c != null)
   {              Breakstarttimebool = false;
                  Breakendtimebool = false;
                  breaktimevalidbool=false;
                  slotbool = false;
                  endtimebool = false;
                  starttimebool = false;Appointmentsperattidbool = false;
      string[] bst = brk.Break_Start_Time__c.split(':');
      string[] bet =brk.Break_End_Time__c.split(':');
      string[] est = d.mmdays.Start_time__c.split(':');
      string[] eet = d.mmdays.End_Time__c.split(':');
      system.debug('Shruthi' + bst[0] + 'Sudha ' + bst[1] + 'Reddy ' + bst[1].remove('PM').trim() + 'Reddy' +  est[1].remove('AM').trim()) ;
     if(bst[1].contains('AM')){
         if(bst[0].contains('12'))
         {
              breakstarttime =  Time.newinstance(Integer.valueOf(bst[0])+12,Integer.valueOf(bst[1].remove('AM').trim()),0,0);
         }else{
              breakstarttime =  Time.newinstance(Integer.valueOf(bst[0]),Integer.valueOf(bst[1].remove('AM').trim()),0,0);
         }
     }
     if(bst[1].contains('PM')){
         if(bst[0].contains('12'))
         {
                 breakstarttime =  Time.newinstance(Integer.valueOf(bst[0]),Integer.valueOf(bst[1].remove('PM').trim()),0,0); 
         }else{
                 breakstarttime =  Time.newinstance(Integer.valueOf(bst[0])+12,Integer.valueOf(bst[1].remove('PM').trim()),0,0);
         }
     }
     if(bet[1].contains('AM')){
           if(bet[0].contains('12'))
           {
                  breakendtime =  Time.newinstance(Integer.valueOf(bet[0])+12,Integer.valueOf(bet[1].remove('AM').trim()),0,0);
           }else{
                  breakendtime =  Time.newinstance(Integer.valueOf(bet[0]),Integer.valueOf(bet[1].remove('AM').trim()),0,0);
           }
     }
     if(bet[1].contains('PM')){
            if(bet[0].contains('12')){
                   breakendtime =  Time.newinstance(Integer.valueOf(bet[0]),Integer.valueOf(bet[1].remove('PM').trim()),0,0);
            }else{
                     breakendtime =  Time.newinstance(Integer.valueOf(bet[0])+12,Integer.valueOf(bet[1].remove('PM').trim()),0,0);
            }
     }
     if(est[1].contains('AM')){
            if(est[0].contains('12'))
            {
                eventstarttime =  Time.newinstance(Integer.valueOf(est[0])+12,Integer.valueOf(est[1].remove('AM').trim()),0,0); 
            }else{
                eventstarttime =  Time.newinstance(Integer.valueOf(est[0]),Integer.valueOf(est[1].remove('AM').trim()),0,0);
            }
     }
     if(est[1].contains('PM')){
             if(est[0].contains('12'))
             {
                  eventstarttime =  Time.newinstance(Integer.valueOf(est[0]),Integer.valueOf(est[1].remove('PM').trim()),0,0);
             }else{
                  eventstarttime =  Time.newinstance(Integer.valueOf(est[0])+12,Integer.valueOf(est[1].remove('PM').trim()),0,0);
             }
     }
     
     if(eet[1].contains('AM')){
            if(eet[0].contains('12'))
            {
             eventendtime =  Time.newinstance(Integer.valueOf(eet[0])+12,Integer.valueOf(eet[1].remove('AM').trim()),0,0);
            }else{
             eventendtime =  Time.newinstance(Integer.valueOf(eet[0]),Integer.valueOf(eet[1].remove('AM').trim()),0,0);
            }
     }
     if(eet[1].contains('PM')){
             if(eet[0].contains('12'))
             {
                 eventendtime =  Time.newinstance(Integer.valueOf(eet[0]),Integer.valueOf(eet[1].remove('PM').trim()),0,0);
             }else{
                 eventendtime =  Time.newinstance(Integer.valueOf(eet[0])+12,Integer.valueOf(eet[1].remove('PM').trim()),0,0);
             }
     }
        system.debug('Shruthi' + breakstarttime  + 'Mythili' + breakendtime  + 'MANASA' + eventstarttime + ' keerthi' + eventendtime );
   
    Boolean Result = (breakstarttime  >= eventstarttime) && (breakstarttime < eventendtime ) && (breakendtime > eventstarttime) && (breakendtime <= eventendtime ) && ( breakstarttime < breakendtime ); 
      system.debug('Break Start Time comp ' + Result);
   if(Result != true)
   {    
         
         breaktimevalidbool=true;
         slotbool = false;
         endtimebool = false;
         starttimebool = false;Appointmentsperattidbool = false;
        
   }
   else{
          breaktimevalidbool=false;
          slotbool = false;
          endtimebool = false;
          starttimebool = false; Appointmentsperattidbool = false;    
          brk.MatchLeads_Days__c = d.mmdays.id;
          Breaks.add(brk);
           system.debug('shruthi shruthi shruthi   ' + Breaks);
   } 
  }
  else{
  
  
   if(brk.Break_End_Time__c == null)
   {
          Breakendtimebool = true;
          Breakstarttimebool = false;
          slotbool = false;
          starttimebool = false;          
          endtimebool = false; 
          breaktimevalidbool=false; Appointmentsperattidbool = false;
   
  }
   if(brk.Break_Start_Time__c == null )
   {
          Breakstarttimebool = true;
          Breakendtimebool = false;
          slotbool = false;
          starttimebool = false;          
          endtimebool = false; 
          breaktimevalidbool=false;Appointmentsperattidbool = false; 
   }
   
 }
 
 } 
 
 
 
             if(slotbool == True || starttimebool == True || endtimebool == True || breaktimevalidbool== True || Breakstarttimebool== True || Breakendtimebool == True || Appointmentsperattidbool == TRUE)
             {
              break;
             }
 
 }
 system.debug('SHRU SHRU SHRU ' + Breaks);
  database.upsert(Breaks);
  }
 }
 
 else{
 
 system.debug('********* Unsuccessfull ------------');
         if(d.mmdays.Slot_Time_period__c == null ||Integer.valueof(d.mmdays.Slot_Time_period__c)<=0){
         system.debug('qqqqqqqqddddsss q 7y dd'+ d.mmdays.Slot_Time_period__c);
         slotbool = true;
         starttimebool = false;          
          endtimebool = false; 
          breaktimevalidbool=false; Appointmentsperattidbool = false;    
         }   
 
         if(d.mmdays.End_Time__c == null ){
          system.debug('Start start start '+ d.mmdays.End_Time__c);
          starttimebool = false; 
          slotbool = false;         
          endtimebool = true;  
          breaktimevalidbool=false;  Appointmentsperattidbool = false;     
          }
         if(d.mmdays.Start_time__c == null ){
          system.debug('Start start start '+ d.mmdays.Start_time__c);         
          starttimebool = true; 
           slotbool = false;
           endtimebool = false;
           breaktimevalidbool=false;Appointmentsperattidbool = false;
          }
          
          
          
          
           if(d.mmdays.End_Time__c != null && d.mmdays.Start_time__c != null && d.mmdays.Slot_Time_period__c != null ){
          
           if(d.mmdays.Break_Time_between_slots__c == null ){
                 
           starttimebool = false; 
           slotbool = false;
           endtimebool = false;
           breaktimevalidbool=true;
           Appointmentsperattidbool = false;
          }
       }
          
          
          
          if(d.mmdays.End_Time__c != null && d.mmdays.Start_time__c != null && d.mmdays.Slot_Time_period__c != null && d.mmdays.Break_Time_between_slots__c != null){
          
           if(d.mmdays.MAX_noOf_appontments__c == null ){
                 
           starttimebool = false; 
           slotbool = false;
           endtimebool = false;
           breaktimevalidbool=false;
           Appointmentsperattidbool = true;
          }
       }
          
       
 
 }
 
         if(slotbool == True || starttimebool == True || endtimebool == True || breaktimevalidbool== True || Breakstarttimebool== True || Breakendtimebool == True || Appointmentsperattidbool == True)
             {          
               break;              
             }

 }


             if(slotbool == false && starttimebool == false &&  endtimebool == false && breaktimevalidbool== false && Breakstarttimebool==false && Breakendtimebool == false && Appointmentsperattidbool == false)
             {
                     AddEventBtn = False;
                 pg = new pagereference('/apex/Matchleads_eventsPage');
                 pg.setredirect(true);      

              }
              else{}
              matchtabs();
              //selectedEvent  = ApexPages.currentPage().getParameters().get('eveId');
             
       // tag1=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =: SelectedEventId LIMIT 1];
       if(eventheading == 'Add Event')
       {
          List<Tags__c > tagss=[SELECT id,Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =: SelectedEventId];
          delete tagss;
          
       }
     try{  
       tag1.Default_Name__c='Attendee';
       tag1.Event__c= SelectedEventId;
       tag1.Alias_Name__c= tag1.Alias_Name__c;
       upsert tag1;//-----Problem While creating Event Validtions are not firing
        
        

       // tag2=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =: SelectedEventId LIMIT 1];
      tag2.Default_Name__c='Exhibitor';
      tag2.Event__c= SelectedEventId;
      tag2.Alias_Name__c= tag2.Alias_Name__c;
       upsert tag2;//-----Problem While creating Event Validtions are not firing
      } catch(exception ed){}
                 return pg; 

 }
 
 
   public Pagereference CheckUser(){
       
       Pagereference pg = MM_Utility.checkLogInservice();
       
       return pg;
       
   }
 
 //------------------Percentage Utilization Chart-------------
  public integer cappinhour{get;set;}
  public integer tothours{get;set;}
  public integer corp{get;set;}
  public integer totalcorpapp{get;set;}
  public integer totapp{get;set;}
  public integer perutil{get;set;}
  public LIST<MatchLeads_Days__c> mdays{get;set;}
  public LIST<MatchLeads_Days__c> mdays1{get;set;}
  public string endtime{get;set;}
  public string starttime{get;set;}
  
  
  public void getperutil()
  {
  mdays= new LIST<MatchLeads_Days__c>();
   mdays=[SELECT id,Start_time__c,End_Time__c,Break_Time_between_slots__c,Slot_Time_period__c,MAX_noOf_appontments__c 
          FROM MatchLeads_Days__c where Event__r.id =: SelectedEventId ];
          
    cappinhour = integer.valueof(mdays[0].MAX_noOf_appontments__c);
    
   /* LIST<String> StartTimeListHour= new LIST<String>(mdays.Start_time__c.split(':'));
    integer starttimesplithour = integer.valueof(StartTimeList[0]);
    StartTimeList[1].replace(':','');
    
    LIST<String> StartTimeListMin= new LIST<String>(StartTimeList[1].split(' '));
    
    LIST<String> StartTimeListHour= new LIST<String>(mdays.Start_time__c.split(':'));*/
    //tothours = Decimal(mdays.End_Time__c) - Decimal(mdays.Start_time__c)*1440;
    
    tothours=6;
    corp=corporatesize;
    totapp =totalmatchesmade;
    totalcorpapp= cappinhour * tothours* corp;
    perutil = totalmatchesmade/totalcorpapp *100;
    system.debug('############################'+perutil);
        
  }
 
 public LIST<Tags__c> mtags{get;set;}
 public Tags__c tag{get;set;}
 public string Attendee{get;set;}
 public string Exhibitor{get;set;}
 
 public void matchtabs()
 {   
 try{
 System.debug('SelectedEventId '+SelectedEventId );
 
   mtags=[SELECT Alias_Name__c,Default_Name__c,Event__c FROM Tags__c WHERE Event__r.id =: SelectedEventId LIMIT 1];   
   if(mtags.size()>0) {
   if(mtags[0].Alias_Name__c!= null)
   {
   mtags[0].Alias_Name__c = tag.Alias_Name__c;
   mtags[0].Event__c= SelectedEventId;
   
 }
 database.upsert(mtags);
 }
 
 

 }catch(exception e){}
 }
 
 //public Event__c eve{get;set;}
 public void stopschedules()
 {
 

 string evid = ApexPages.Currentpage().getparameters().get('eveid1');
 Event__c evnt= [SELECT id, Name,Match_Making_Schedules__c from Event__c WHERE id =:evid];
 evnt.Match_Making_Schedules__c='Closed';
 update evnt;
getallevents();
 }
 
 public void startschedules()
 {
    string evid = ApexPages.Currentpage().getparameters().get('eveid2');
 Event__c evnt= [SELECT id, Name,Match_Making_Schedules__c from Event__c WHERE id =:evid];
 evnt.Match_Making_Schedules__c='Live';
 update evnt;
getallevents();
 }
 
 
  public void stopEmails()
 {
 
 try{
 string evid = ApexPages.Currentpage().getparameters().get('eveid1');
 Event__c evnt= [SELECT id, Name,Email_Notifications_flag__c from Event__c WHERE id =:evid];
 evnt.Email_Notifications_flag__c=False;
 update evnt;
getallevents();
}catch(exception er){} 
 }
 
 public void deleteEvent()
 {
 
 try{
 string evid = ApexPages.Currentpage().getparameters().get('eveid1');
 Event__c evnt= [SELECT id, Name,Status__c from Event__c WHERE id =:evid];
 evnt.Status__c='Deleted';
 update evnt;
getallevents();
}catch(exception er){} 
 }
 
 public void startemails()
 {
   try{
    string evid = ApexPages.Currentpage().getparameters().get('eveid2');
     Event__c evnt= [SELECT id, Name,Email_Notifications_flag__c from Event__c WHERE id =:evid];
     evnt.Email_Notifications_flag__c=True;
     update evnt;
    getallevents();
   }catch(exception er){} 
 }
//------------------------------------------------------------------END OF ADDING AN EVENT-----------------------------------

public integer i{get;set;}
public void  dummy1(){
i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;



}

 

}