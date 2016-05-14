public without sharing class MM_Eventadmin_EventssampleCon {

    public Boolean AddEventPopup { get; set; }

    /***********************************************************************************************
    *   Controller Name : MM_Eventadmin_EventssampleCon
    *   Date            : 26/06/2013 
    *   Author          : Mythily Nagandla
    *   Purpose         : This class is for managing Events, event schedule,  portal and ore.......
    *   Change History  : 26/06/2013 
    *       Date                 Programmer                     Reason
    *   --------------      -------------------           -------------------------
    *   26/06/2013          Mythily Nagandla      Changes on event schedule time in vf page.
    *   
    **************************************************************************************************/
    public List<selectoption>  Open{get;set;}
    public string selectedtb{get;set;}
    public List<selectoption> SemiOpen{get;set;}
    public List<selectoption> Custom{get;set;}
    public List<selectoption> Closed{get;set;}
    public boolean MMsettings{get;set;}
    public string selectedType{get;set;}
    public String AssignToId{get;set;}
    public boolean Zebrabool{get;set;}
    public  string helptext1 {get;set;}
    public  string helptext2 {get;set;}
    public  string helptext3 {get;set;}
    public Boolean AddEventBtn{get; set;}
    public Event__c Event{get; set;}
    public Event__c EventDetail{get; set;}
    public Document DocumentImage{get; set;}
    public String LogoName{get; set;}
    Public transient Blob LOGO{get; set;}
    public String selectedEventbrite{get; set;}
    public id selectedId{get; set;}
    public Boolean recordPermissions{get; set;} //----
    public Boolean eventAdminBoole{get; set;}
    public LIST<User_Profile_Event__c> listOfEvents{get; set;}
    public USER uu{get; set;}
    public ID SelectedEventId{get; set;}
    public Boolean NoEventCreatedBool{get; set;}
    Public Document mydoc;//Document 
    public Boolean myDocBool{get; set;}
    public String eventheading{get; set;}
    public String eventErrorString{get; set;}
    public String eventLogoErrorString{get; set;}
    public MAP<String, String> eventsCheckMap{get; set;}
    
    public Boolean changeEventLogoBool{get; set;}
    public Boolean eventTypeBool{get;set;}
    
    // Attendee Settings Variables
    public BL_SecuritySettingsCon attendeesetting{get; set;}
    public Boolean updateAttendeeSettingBool{get; set;}
    public List<Selectoption> SelectedDiversity{get; set;}
    
    // Ticket Types
   
    
    
  
   //attendee types
   
   public List<Selectoption> attendeetype{get; set;}
    public List<Selectoption> Selectedattendeetype{get; set;}
   public String extraattendee{get; set;}
   public Boolean attendeetypeStringErrorBool{get; set;}
   public String attendeetypeStringError{get; set;}
   public MAP<String, String> attendeetypeMap{get; set;}
   public MAP<String, String> attendeetypeCustomMap{get; set;}

         
    // Event Schedule
    public EventSchedule__c addSch{get; set;}
    public Boolean eventScheduleBool{get; set;}
    public LIST<EventSchedule__c> eventscheduleDB{get; set;} 
    public LIST<EventSchedule__c> ForPagination{get; set;} 
    public LIST<EventSchedule__c> an{get; set;} 
    public LIST<SelectOption> StartTimings {get; set;} 
    public LIST<SelectOption> EndTimings{get; set;} 
    public LIST<SelectOption> EventDate{get; set;} 
    public Boolean detailScheduleBool{get; set;} 
    public Boolean addScheduleBool{get; set;}   
    public String ScheduleHeading{get; set;}
    public String eventname{get; set;}
    public EventSchedule__c editsch{get; set;}
    public String EventStartDate{get; set;}
    public String EventEndDate{get; set;}
    
    
    //For Pagination
    public Boolean hasLast{get;set;}
    public Boolean hasFirst{get;set;}
    public Integer PgNo{get;set;}
    Public Boolean conlst{get;set;}
    Public Boolean hasPrevious {get;set;}
    Public Boolean hasNext {get;set;}
    Public Integer pageno {get;set;}
    Public Integer count {get;set;}
    public boolean page1{get;set;}
    public Boolean Disabled_First_Icon{get;set;}
    public Boolean Disabled_Last_Icon{get;set;}
    public Boolean Disabled_Previous_Icon{get;set;}
    public Boolean Disabled_Next_Icon{get;set;}
    public Boolean NoRecordsFound{get; set;}
    public Integer ForPagesize{get; set;}
    public Boolean DisplayPages{get; set;}
    
    
    // Badge Settings Boolean
    public Boolean BadgeSettingsBool{get; set;}
    public LIST<selectoption> BadgeType{get; set;}
    public String SelectedBadgeType{get; set;}
    public BL_BadgeSettingsClass badgeSet{get; set;}
    public LIST<selectOption> fieldnames{get; set;}
    public LIST<selectOption> fieldnames22806{get; set;}
    public LIST<selectOption> colors{get; set;}
    public LIST<selectOption> font{get; set;}
    public LIST<selectOption> font1{get; set;}
    public LIST<selectOption> font2{get; set;}
    public LIST<selectOption> font22806{get; set;}
    public LIST<selectOption> fontface{get; set;}
    
    
    //DataBase Save Point
    public LIST<DataImport_SavePoint__c> dataBaseSaveResult{get; set;}
    public Boolean dataImportHistoryBool{get; set;}
    public Date todaysDate{get; set;}
    public boolean booleanforDisplayBoothadminTab{get;set;}
    
    // Stats Start
    public Integer signedupmbes{get;set;}
    public Integer signedupcorporates{get;set;}    
    public Integer corporateswaiting{get;set;}
    public Integer totalmatchesmade{get;set;}
    public Integer pendingmatches{get;set;}
    public LIST<User_Profile_Event__c> corporateslist{get;set;}
    public LIST<Event_Attendee_Mapping__c> mbeslist{get;set;}
    public LIST<User_Profile_Event__c> waitinglist{get;set;}
    public LIST<EventSchedule__c> totalmatcheslist{get;set;}
    public LIST<EventSchedule__c> pendingmatcheslist{get;set;}
    // Stats End
     
    
    public MM_Eventadmin_EventssampleCon(){
     selectedType ='';
    AddEventBtn = false;
   
     open = new List<SelectOption>();
     open.add(new SelectOption('Open','Open'));
     open.add(new SelectOption('Semi Open','Semi Open'));
     open.add(new SelectOption('Closed','Closed'));      
     open.add(new SelectOption('Custom','Custom'));
    
      selectedtab='Event Type';
     
     
    helptext1='You have the option to either go with the registration system provided by Globalnest or Eventbrite or any other system of your choice.If you use Eventbrite, you can automatically import event and attendee information from Eventbrite.';
    helptext2='This logo is printed on the badges of the event';
    helptext3='This field provides the status of the event.The behavior or the application is not enforced based on these values';
    // callBadgeSettings();
       
    //---------------------------- Hide Buttons to Boothpersonnel and attendees  ---------------------
              
    List<User_Profile_Event__c> listOfEvents = new List<User_Profile_Event__c>();
    listOfEvents =[select u.EV_id__r.Status__c,u.EV_id__r.StartTime__c, u.EV_id__r.SecondaryCategory__c,
    u.EV_id__r.Primary__c, u.EV_id__r.Name, u.EV_id__r.Id, u.EV_id__r.EV_Title__c, u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_HostingZipcode__c, 
    u.EV_id__r.EV_HostingTimeZone__c, u.EV_id__r.EV_HostingState__c,u.EV_id__r.EV_HostingPostalCode__c,
    u.EV_id__r.EV_HostingPhone__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HostingCountry__c,
    u.EV_id__r.EV_HostedByEventBrite__c, u.EV_id__r.EV_HistingAddr1__c, u.EV_id__r.EV_EventLogo__c,u.EV_id__r.CCRDetails_Required__c, 
    u.EV_id__r.EV_EndTime__c,u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_Description__c, u.Profile_id__r.PR_Name__c,
    u.EV_id__r.CreatedDate, u.EV_id__r.Attendee_Tags__c,u.EV_id__r.EV_HostingOrgName__c, u.EV_id__r.AS_HostingCity__c,u.EV_id__r.AS_HostingAddr2__c from User_Profile_Event__c u 
    where  u.User_id__r.Email=:UserInfo.getUserName() limit 999 ];
      
     //u.IsMatchMakingUser__c=true
          EventsList();
          EventValues();
          
    }
    
    public Pagereference CheckUserId(){
        if(userInfo.getUserType()=='guest'){
        Pagereference pg = new pagereference('/apex/mm_eventadmin_login');
        pg.setredirect(true);
        return pg;
   
   } else{return null;}
   
   
    }
    
   
    
    
    public void EventsList(){
    
 AddEventBtn = false;
        listOfEvents = [select Id,EV_id__c,EV_id__r.id,EV_id__r.EV_Title__c,EV_id__r.Status__c,EV_id__r.EV_HostingState__c,EV_id__r.AS_HostingCity__c, 
                            EV_id__r.Owner.ID, EV_id__r.MM_Start_Date__c ,  EV_id__r.MM_End_Date__c, EV_id__r.MM_Firstaday_startTime__c, EV_id__r.MM_Firstaday_EndTime__c,
                            EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HostingOrgName__c from User_Profile_Event__c where   EV_id__c != NULL AND User_id__c=: UserInfo.getUserId() 
                            ORDER BY CreatedDate DESC  ];               
           if(listOfEvents.size()>=1){
               SelectedEventId = listOfEvents[0].EV_id__c ;
              NoEventCreatedBool = TRUE;  
           }else{ 
               NoEventCreatedBool = FALSE;   
           }
      LIST<User_Profile_Event__c> corporateslist = [SELECT id
                                                 FROM User_Profile_Event__c
                                                 WHERE Ev_id__r.id =: SelectedEventId 
                                                 AND MAtchMakingProfile__c = 'Corporate' 
                                                 AND User_id__r.isSignup__c = TRUE
                                                 AND Request_for_upgrade_profile__c = FALSE
                                                 AND Ev_id__c != NULL];
      signedupcorporates = corporateslist.size();
     
      LIST<Event_Attendee_Mapping__c> mbeslist = [SELECT id
                                                 from Event_Attendee_Mapping__c 
                                                 where IsMatchMakingAttendee__c = true 
                                                 AND EV_id__r.id = : SelectedEventId 
                                                 AND Boothleads_Profile__c =: 'Attendee'];
      signedupmbes = mbeslist.size();
     
      LIST<User_Profile_Event__c> waitinglist = [SELECT id
                                                 FROM User_Profile_Event__c
                                                 WHERE Ev_id__r.id =: SelectedEventId  
                                                 AND Request_for_upgrade_profile__c = TRUE 
                                                 AND Ev_id__c != NULL];
      corporateswaiting = waitinglist.size();
      
      LIST<EventSchedule__c> totalmatcheslist = [SELECT ID
                                                 FROM EventSchedule__c 
                                                 WHERE EV_id__r.id =: SelectedEventId 
                                                 AND Is_Matchmaking__c = true
                                                 AND MM_To_EAM__c != null
                                                 AND MM_To_UPE__c != null
                                                 AND MM_Slot_Status__c = 'Accepted'];
      totalmatchesmade = totalmatcheslist.size(); 
      
      LIST<EventSchedule__c> pendingmatcheslist = [SELECT ID
                                                   FROM EventSchedule__c 
                                                   WHERE EV_id__r.id =: SelectedEventId 
                                                   AND Is_Matchmaking__c = true 
                                                   AND MM_To_EAM__c != null
                                                   AND MM_To_UPE__c != null 
                                                   AND MM_Slot_Status__c = 'Pending'];
      pendingmatches= pendingmatcheslist.size();
      
    }
    
    public boolean displayAttendeeRegistrationLink{get;set;}
    
    public void EventValues(){ 
    AddEventBtn = false;
    displayAttendeeRegistrationLink  = false; 
         if(listOfEvents.size()>0){
        EventDetail = [SELECT ID,Name,EV_Title__c,Status__c,EV_HostingState__c,AS_HostingCity__c,EV_HostingLocation__c,Attendee_Types__c,
                    EV_HistingAddr1__c,AS_HostingAddr2__c,EV_HostingCountryNew__c,EV_Publish__c,EV_EventLogo__c,EV_HostingTimeZone__c,
                    EV_HostingPhone__c,EV_HostingFax__c,EV_WebsiteURL__c,Primary__c,SecondaryCategory__c,EV_HostingOrgName__c,EV_HostingStateNew__c,
                    EV_HostingZipcode__c,EV_HostingPostalCode__c,EV_HostedByEventBrite__c,EV_Description__c,Owner.FirstName,Owner.ID,
                    EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,EventDiversityValues__c,TwitterHashTag__c,
                    Lable_First_Line__c,Lable_Secoend_Line__c,Lable_Third_Line__c,Event_Printer__c,
                    Lable_First_Line_Color__c,Lable_First_Line_Size__c,Lable_First_Line_Font__c,Lable_Secoend_Line_Color__c,Lable_Secoend_Line_Size__c,Lable_Secoend_Line_Font__c,
                    Lable_Third_Line_Color__c,Lable_Third_Line_Size__c,EV_SiteLocation__c,Lable_Third_Line_Font__c, 
                    MM_Firstaday_startTime__c ,MM_Start_Date__c,MM_End_Date__c,MatchMaking_Type__c
                    FROM Event__C WHERE id =:SelectedEventId ];
          
          
       } 
        
     system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'); 
    } 
    
    
    public void editEvent(){
        eventsCheckMap=new map<string,string>{};
        SelectedEventId = ApexPages.currentpage().getparameters().get('eventName');
        system.debug('!!!!!!!!!!!!!!!!!!!     '+ SelectedEventId);
        eventheading = 'Edit Event';
        if(SelectedEventId != null){
           Event=[SELECT e.Status__c, e.StartTime__c, e.SecondaryCategory__c, e.Primary__c, Attendee_can_send_request__c ,Is_Approval_Required__c ,Exhibitor_can_send_request__c,         
                                e.Name,e.Id, e.Event_ZipCode__c, e.Event_PostalCode__c, e.EventDiversityValues__c,Attendee_Types__c,e.No_Appointments_Per_Attendee__c, 
                                e.Ev_RequiredFields__c, e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c, 
                                e.EV_RedirectURI__c, e.EV_Publish__c, e.EV_IncludedFields__c, e.EV_HostingZipcode__c, e.EV_HostingTimeZone__c, 
                                e.EV_HostingState__c, e.EV_HostingStateNew__c, e.EV_HostingPostalCode__c, e.EV_HostingPhone__c, 
                                e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingFax__c, e.EV_HostingCountry__c, e.EV_HostingCountryNew__c, 
                                e.EV_HostedByEventBrite__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c,e.Owner.ID, 
                                e.EV_Description__c, e.EV_CustomReg__c, e.EV_ContactURL__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c,e.TwitterHashTag__c
                                ,MM_End_Date__c,MM_Firstaday_EndTime__c,MM_Firstaday_startTime__c,MM_Secondaday_EndTime__c,MM_Secondaday_startTime__c,MM_Start_Date__c
                                ,MM_Slot_Timeperiod__c,MatchMaking_Type__c,BreakTime_Between_Appointments__c
                                From Event__c e WHERE ID =: SelectedEventId]; 
                               
               AddEventBtn = TRUE;                 
               selectedType= Event.MatchMaking_Type__c;                
               
          
          
          
        
                                
       }                     
    }
    
    public void changeEvent(){
    
        SelectedEventId = ApexPages.currentpage().getparameters().get('eventName');
        
        if(SelectedEventId != NULL)
        {
            EventValues();
        }
        
    
    }
    
    public void changeEventLogo(){
    
        changeEventLogoBool = TRUE;
        selectedtb='name1';
    }
    
    public void updateLogo(){
        eventLogoErrorString = '';
        myDocBool = TRUE;
        
        if(Logo != null && ( LogoName != '' || LogoName != NULL )){
        if(Logo.size()!= null){
         
        if(Logo.size() < 102400 ){
             system.debug('2222222222222222222222    ');
        eventLogoErrorString = '';
        
        mydoc =new document();
        mydoc.body = Logo;
        mydoc.folderid = '00lF0000001VI7Y';
        
        mydoc.IsPublic = True;
        mydoc.Name = LogoName;
        DataBase.saveResult docSaveResult = DataBase.insert(mydoc, false);
       
        system.debug('33333333333333333333333    '+ docSaveResult.isSuccess() +'       '+docSaveResult.getId());
        String eventold;
        if(EventDetail.EV_EventLogo__c != null){
            eventold = EventDetail.EV_EventLogo__c;
        }
        
        if(docSaveResult.isSuccess()){
            EventDetail.EV_EventLogo__c = docSaveResult.getId();
            update EventDetail;
            changeEventLogoBool = FALSE;
            
            if(eventold != null){
            try{
                document dd = [SELECT ID, NAME FROM document WHERE id=: eventold];
                Database.delete(dd);
              }Catch(Exception e){}  
            }
            
        }else{
            myDocBool = FALSE;
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, String.valueOf(docSaveResult.getErrors()))); 
        }
        
        
       }else{
           myDocBool = FALSE; 
           eventLogoErrorString = 'Please make sure the  file is not more than 100 kb';
       }
       
      }
     }else{
         eventLogoErrorString = 'Please Select Valid Image file.';
     }   
    }
    
   
    
    
    
    
    
    

//------------------------------------------------------------- Event Schedule Methods Start --------------------------------------------

// ------------------------------------------------------------- Event Schedule Methods End --------------------------------------------
    
//------------------------------------------------------- Pagination Methods Start ------------------------------------------------------ 


//------------------------------------------------------- Pagination Methods End ------------------------------------------------------      
    
    
     
    public String escapeSpecialCharacters(String s)
    {
        if(s!= null && s!= '' && (s.contains('"') )){
            s = s.replace('"','');
        }

        if(s!= null && s!= '' && (s.contains('<') )){
            s= s.replace('<','');
        }

        if(s!= null && s!= '' && (s.contains('\\') )){
           
        }

        if(s!= null && s!= '' && (s.contains('\'') )){
            
        }
        return s;
    }  
      
      
   
   

    Public Void AddEvent(){
    errortype = '';
    AddEventBtn = true;
    
    Event = new Event__c();
    selectedType ='Semi Open';
    DocumentImage = new Document();
    eventheading = 'Add Event';
    }
    
      
      
      
    Public Void Cancel(){
   selectedtab='Event Type';
        eventLogoErrorString ='';
    AddEventBtn = FALSE;
    addScheduleBool = FALSE;
    updateAttendeeSettingBool = FALSE;
    detailScheduleBool = FALSE;
    dataImportHistoryBool = FALSE;
    changeEventLogoBool = FALSE;
    BadgeSettingsBool = FALSE;
    eventTypeBool=false;
    MMsettings=false;
    }
    
    
    public void createEvent(){
    
   //system.debug('111111111111111111111   '+eventsCheckMap.containsKey((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ','')));   
    eventErrorString = '';
     
     system.debug('22222222222222222222222222222222'+Event.EV_Title__c);
     
    //if(! eventsCheckMap.containsKey(((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ','')).toLowerCase())){   
            
       myDocBool = TRUE;
      
        if(Logo != null && ( LogoName != '' || LogoName != NULL )){
        if(Logo.size()!= null){
         
        if(Logo.size() < 102400 ){
             system.debug('2222222222222222222222    ');
        eventLogoErrorString = '';
        
        mydoc =new document();
        mydoc.body = Logo;
        mydoc.folderid = '00lF0000001VI7Y';
        
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
            if(SelectedEventbrite == 'By Eventbrite')
        {
        Event.EV_HostedByEventBrite__c = True;
        Event.EV_Publish__c = FALSE;
        }else if(SelectedEventbrite == 'By Global Nest')
        {
        Event.EV_Publish__c = TRUE;
        Event.EV_HostedByEventBrite__c = FALSE;
        }else {
            Event.EV_HostedByEventBrite__c = FALSE;
            Event.EV_Publish__c = FALSE;
        }
        
        Event.Is_MatchMaking_Event__c=true;
        Event.MatchMaking_Type__c=selectedtype;
        event.MM_Start_Date__c =date.valueOf(EventStartDate);
        event.MM_End_Date__c=date.valueOf(EventEndDate);
        
       Database.UpsertResult EventupsertResult = DataBase.Upsert(Event, false);
           
           if(EventupsertResult.isSuccess()){
           
              // eventsCheckMap.put((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ',''), (Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c));
           
          //system.debug('22222222222222222222222222222222'+EventupsertResult.isCreated());
           
               if(EventupsertResult.isCreated()){
               // ----------------------- CODE FOR Attendee Settings ------------------------------------
         
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
        
                   
                    Profile__c EventAdminProfile = [select Id from Profile__c where PR_Name__c = 'EventAdmin'];
                  
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
               }
            AddEventBtn = False; 
            displayAttendeeRegistrationLink=true;
            EventsList(); 
            EventValues();
        }
       
       }
    //}
     // else{
        //  eventErrorString = 'This Event is already Registered.';

     //}
    }
    
    public MAP<ID, DataImport_SavePoint__c> dataSavePointMap{get; set;}
    
    
      
     
     public boolean error{get;set;}
     public string errormsg{get;set;}
    
 public List<User_Profile_Event__c> EventBriteEvents{get;set;}
/**    
    public boolean messagebool{get;set;}
    public List<SelectOption> getSelectEventId(){
    
    List<selectoption> Options = new List<selectoption>();
    EventBriteEvents = [Select EV_id__r.id,EV_id__r.EV_Title__c from User_Profile_Event__c where User_id__r.id=:UserInfo.getUserId()];
    system.debug('::::::::::::::::::;;;;;;;'+EventBriteEvents);
    if (EventBriteEvents.size()==0)
    {
      messagebool=true;
      
    }else
       system.debug('::::::::::else :::::::::::');
  
    {
    for(User_Profile_Event__c EV:EventBriteEvents){
    System.debug('@@@@@Options'+ev);
     Options.add(new SelectOption(EV.EV_id__r.id,EV.EV_id__r.EV_Title__c));
   System.debug('@@@@@Options'+Options);
    }
    
  System.debug('@@@@@Options'+Options);   
  
    } 

  return Options;

}
  */
//----------------------------------------------------TABS---------------------------------------
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
     return selectedTab <> 'MatchMaking Schedule';     
    }
    
    
        public void previous2() {
    selectedTab ='Event Type';
    }

     public void previous3() {
    selectedTab ='Event details';
    }
     public void previous4() {
    selectedTab ='Event Schedule';
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
    }
//-----------------------------------------------------
    public boolean errorTitle{get;set;}
    public boolean errorHosZone{get;set;}
    public boolean errorstartdate{get;set;}  
    public boolean errorstartTime{get;set;} 
    public boolean errorendtdate{get;set;}
    public boolean errorendtTime{get;set;}
     
     public void enabletab2() {
     
     if(Event.EV_Title__c == null || Event.EV_Title__c ==''){
     system.debug('         event title        '+Event.EV_Title__c);
     errorTitle=true;
     errortype='Please enter Event Name';
     
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
     
     }else{
     errorTitle=false;
     errorHosZone=false;
     errorstartdate=false;
     errorstartTime=false;
     errorendtdate=false;
     errorendtTime=false;
     Boolean check=FALSE;
     List<Schema.PicklistEntry> EventStartTime = Event__c.StartTime__c.getDescribe().getPicklistValues();
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
         
    selectedTab ='MatchMaking Schedule';

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
         selectedTab ='MatchMaking Schedule';
             
             system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA        '+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c);
         
         
    }
    public boolean MMstartdate{get;set;}
    public boolean mmenddate{get;set;}
    public boolean mmstartTime{get;set;}
    public boolean mmendtime{get;set;}
   public void savemmevent(){
   
   createevent();
  
   }
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

    public User_Profile_Event__c needtoProvidedata{get; set;}
    public Boolean needtoProvidedataBool{get; set;}
    public void checkEvents(){
        
        needtoProvidedataBool = FALSE;
        needtoProvidedata = new User_Profile_Event__c();
        
        system.debug('       AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA         '+ listOfEvents);
           // EV_id__r.MM_Start_Date__c ,  EV_id__r.MM_End_Date__c, EV_id__r.MM_Firstaday_startTime__c, EV_id__r.MM_Firstaday_EndTime__c,
        
        for(User_Profile_Event__c up: listOfEvents){
            
            if(up.EV_id__r.MM_Start_Date__c == null || up.EV_id__r.MM_Firstaday_startTime__c == null || up.EV_id__r.MM_Firstaday_EndTime__c == null){
                needtoProvidedata = up;
                SelectedEventId = ApexPages.currentpage().getparameters().put('eventName', up.EV_id__c);
                needtoProvidedataBool = TRUE;
                editEvent();
                selectedtype='Semi Open';
                selectedtab='MatchMaking Schedule';
            }
            
            
        }
        
        
        
    }





}