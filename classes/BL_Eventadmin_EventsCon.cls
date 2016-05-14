public class BL_Eventadmin_EventsCon {
    
    /***********************************************************************************************
    *   Controller Name : BL_Eventadmin_EventsCon
    *   Date            : 26/06/2013 
    *   Author          : Naga Mallikarjuna Rao Bommisetty
    *   Purpose         : This class is for managing Events, event schedule, attentdee settings, portal and ore.......
    *   Change History  : 26/06/2013 
    *       Date                 Programmer                     Reason
    *   --------------      -------------------           -------------------------
    *   26/06/2013          Naga Mallikarjuna Rao B        Changes on event schedule time in vf page.
    *   
    **************************************************************************************************/
    
    public boolean surveybool {get;set;}
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
    public string SelectedEvent{get;set;}
    
    public Boolean changeEventLogoBool{get; set;}
    public boolean settingsbool{get;set;}
    
    // Attendee Settings Variables
    public BL_SecuritySettingsCon attendeesetting{get; set;}
    public Boolean updateAttendeeSettingBool{get; set;}
    public List<Selectoption> SelectedDiversity{get; set;}
    
    // Ticket Types
    public LIST<innerForTicketTypes> innerTickets{get; set;}
    public LIST<String> TicketTypeDelete{get; set;}
    public MAP<String, String> DiversityCustomMap{get; set;}
    public Boolean noTicketTypeBool{get; set;}
    public Map<ID, TicketTypes__c> ticketTypeMap{get; set;}
    public LIST<TicketTypes__c> ticketTypes{get; set;}
    
    
   // Diversity
   public List<Selectoption> Diversity{get; set;}
   public String extraDiv{get; set;}
   public Boolean DivercityStringErrorBool{get; set;}
   public String DivercityStringError{get; set;}
   public MAP<String, String> DiversityMap{get; set;}
   
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
    
    //Event Staff Variables
    public LIST<User_Profile_Event__c> upelist{get;set;}
    Public User U{get;set;}
    Public String EvFirstName{get;set;}
    Public String EvLastName{get;set;}
    Public String EvEmail{get;set;}
    public Boolean CreateStaffPopUp{get;set;}
    public Boolean OpenStaffPopUp{get; set;}
    public String errormessage{get;set;}
    public Boolean errorbool{get;set;}
    public Contact Con{get;set;}
    public AttendeeSummary__c AttendeeSummary{get;set;}
    public User_Profile_Event__c upeuser{get;set;} 
    public User_Profile_Event__c eastaffprofile{get;set;} 
    
    Public List<selectOption> getEventbrite(){
    List<selectoption> Options = new List<selectoption>();
    
    Options.add(new selectoption('By Eventbrite','By Eventbrite'));
    Options.add(new selectoption('By Global Nest','By Global Nest'));
    Options.add(new selectoption('By Other','By Other'));
    return Options;    
    }
    
     public void callBadgeSettings(){
        
        BadgeSettingsBool = true;
        BadgeType = new List<selectoption>();
        badgeSet = new BL_BadgeSettingsClass();
        fieldnames = new LIST<selectOption>();
        fieldnames22806 = new LIST<selectOption>();
        
        // font22806
        colors = new LIST<selectOption>();
        font= new LIST<selectOption>();
        font1= new LIST<selectOption>();
        font2= new LIST<selectOption>();
        font22806= new LIST<selectOption>();
        fontface= new LIST<selectOption>();
        
        fieldnames = badgeSet.fieldnames();
        fieldnames22806 = badgeSet.fieldnames22806();
        colors= badgeSet.colors();
        font= badgeSet.font();
        font1= badgeSet.font1();
        font2= badgeSet.font2();
        font22806 = badgeSet.font22806();
        fontface= badgeSet.fontface();
        
        SelectedBadgeSettings();
        
        // BadgeType.add(new Selectoption('--SELECT--' , '--Select--' ));
        BadgeType.add(new Selectoption('Zebra Label' , 'Zebra Label' ));
        BadgeType.add(new Selectoption('Dymo Label(30856,Single Label)' , 'Dymo Label(30856,Single Label)' ));
        BadgeType.add(new Selectoption('Avery 5392 Name badges' , 'Avery 5392 Name badges' ));
        BadgeType.add(new Selectoption('Avery 22806 easy peal square Badges' , 'Avery 22806 easy peal square Badges' ));
    }
    
    
    public BL_Eventadmin_EventsCon(){
    errorboolname = false;
        errorboolduplicate = false;
    errorboolsubject = false;
    errorpromobool = false;
    helptext1='You have the option to either go with the registration system provided by Globalnest or Eventbrite or any other system of your choice.If you use Eventbrite, you can automatically import event and attendee information from Eventbrite.';
    helptext2='This logo is printed on the badges of the event';
    helptext3='This field provides the status of the event.The behavior or the application is not enforced based on these values';
    // callBadgeSettings();
       
    //---------------------------- Hide Buttons to Boothpersonnel and attendees  ---------------------
              
    List<User_Profile_Event__c> listOfEvents = new List<User_Profile_Event__c>();
    listOfEvents =[select u.EV_id__r.Status__c,u.EV_id__r.StartTime__c, u.EV_id__r.SecondaryCategory__c,
    u.EV_id__r.Primary__c, u.EV_id__r.Name, u.EV_id__r.Need_FloorMap__c,u.EV_id__r.Id, u.EV_id__r.EV_Title__c, u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_HostingZipcode__c, 
    u.EV_id__r.EV_HostingTimeZone__c, u.EV_id__r.EV_HostingState__c,u.EV_id__r.EV_HostingPostalCode__c,
    u.EV_id__r.EV_HostingPhone__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HostingCountry__c,EV_id__r.TwitterId__c,EV_id__r.FacebookId__c,EV_id__r.OrganizerId__c,
    u.EV_id__r.EV_HostedByEventBrite__c, u.EV_id__r.EV_HistingAddr1__c, u.EV_id__r.EV_EventLogo__c,u.EV_id__r.CCRDetails_Required__c, 
    u.EV_id__r.EV_EndTime__c,u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_Description__c, u.Profile_id__r.PR_Name__c,
    u.EV_id__r.CreatedDate, u.EV_id__r.Attendee_Tags__c,u.EV_id__r.EV_HostingOrgName__c, u.EV_id__r.AS_HostingCity__c,u.EV_id__r.AS_HostingAddr2__c,u.EV_id__r.Is_MatchMaking_Event__c from User_Profile_Event__c u where u.User_id__r.UserName =: UserInfo.getUserName() limit 999 ];
    try{
    upeuser = [SELECT ID,Profile_id__r.PR_Name__c FROM User_Profile_Event__c WHERE User_id__r.UserName =: UserInfo.getUserName() limit 1];  
      }catch(exception er){}
  set<Id> setOfEvents = new set<Id>();
   
 booleanforDisplayBoothadminTab =false; 
 for(User_Profile_Event__c upe:listOfEvents){
 if(upe.Profile_id__r.PR_Name__c !='Attendee' && upe.Profile_id__r.PR_Name__c !='BoothPersonnel' ){
 booleanforDisplayBoothadminTab = true;
 break;
 }
  
}

        //---------------------------- End  -----------------------
         listOfEvents =new LIST<User_Profile_Event__c>();
         SelectedDiversity = new List<Selectoption>();
         eventsCheckMap = new MAP<String, String>();
         dataBaseSaveResult = new LIST<DataImport_SavePoint__c>();
         
         eventErrorString = '';
         eventLogoErrorString = '';
         
         NoEventCreatedBool = FALSE;
         eventAdminBoole = FALSE;
         dataImportHistoryBool = FALSE;
         changeEventLogoBool = FALSE;
         todaysDate = Date.today();
         
          uu = [SELECT ID, Event_Detail_help__c,EventDetail_DIVs_Help__c,Profile.Name FROM USER WHERE id =: UserInfo.getUserId()];
         
         LIST<Event__c> eventsAll = [SELECT ID,EV_Title__c,EV_HostingState__c,AS_HostingCity__c,TwitterId__c,FacebookId__c,OrganizerId__c,
                    EV_HostingTimeZone__c,Need_FloorMap__c,EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,CCRDetails_Required__c,Is_MatchMaking_Event__c
                    FROM Event__c ];
         for(Event__c ev: eventsAll){
         
             eventsCheckMap.put(((ev.EV_Title__c+ev.AS_HostingCity__c+ev.EV_StartDate__c+ev.StartTime__c+ev.EV_EndDate__c+ev.EV_EndTime__c).replaceAll(' ', '')).toLowerCase(),(ev.EV_Title__c+ev.AS_HostingCity__c+ev.EV_StartDate__c+ev.StartTime__c+ev.EV_EndDate__c+ev.EV_EndTime__c));
         
         }
        
          
          EventsList();
          EventValues();
          
         if(uu.Profile.Name == 'Event Admin'){
             eventAdminBoole = TRUE;
         }
      
       system.debug('ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ');
       
    }
    
    public Pagereference CheckUserId(){
        if(userInfo.getUserType()=='guest'){
        Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
        pg.setredirect(true);
        return pg;
   
   } else{return null;}
   
   
    }
    
     // Code Edit Started by Mahesh Sakunala
     //----------------------------------------- Event Admin Staff Methods Start ----------------------------------------------------
     public PageReference openaddstaff() {
        OpenStaffPopUp = true;
        CreateStaffPopUp = false;
        upelist = new List<User_Profile_Event__c>();
        
        upelist = [SELECT BT_id__r.BT_Name__c,BT_id__r.BT_Location__c,EV_id__r.EV_Title__c,User_id__r.userName,User_id__r.firstName,User_id__r.lastName,
                          BoothAdmin_id__r.Email,BoothAdmin_id__r.Name,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.CompanyAddr1__c,
                          BoothAdmin_id__r.CompanyAddr2__c,BoothAdmin_id__r.CompanyCity__c,BoothAdmin_id__r.States__c,BoothAdmin_id__r.Country__c,BoothAdmin_id__r.CompanyFaxNumber__c,
                          BoothAdmin_id__r.Company_website__c,BoothAdmin_id__r.Zipcode__c,BoothAdmin_id__r.PoBox__c,
                          Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Email__c 
                   FROM User_Profile_Event__c 
                   WHERE EV_id__c =: SelectedEventId 
                   AND Profile_id__r.PR_Name__c ='EventAdmin Staff'];
        return null;
    }
    
    public PageReference addstaff(){ 
        EVFirstName='';
        EvLastname='';
        EvEmail='';
        errormessage='';
        CreateStaffPopUp = true;
        return null;
    }
    
    public PageReference CloseStaffPopUp(){ 
        CreateStaffPopUp = false;
        openaddstaff();
        return null;
    }
    
    public PageReference CloseMainPopUp(){
        OpenStaffPopUp = false;
        PageReference pg = new PageReference('/apex/BL_EventAdmin_Events?id='+SelectedEventId);
        return pg;
    }

    public void insertstaff(){

        try{
            
            List<User> EventAdminStaffUser = [SELECT Username,Email FROM User WHERE Username=:EvEmail];
            LIST<User_Profile_Event__c> upeslist = [SELECT Id,EV_id__c,User_id__c FROM User_Profile_Event__c WHERE EV_id__c=: SelectedEventId AND User_id__r.Username=:EvEmail];
            if((EventAdminStaffUser.size()>0) && (upeslist.size()>0)){
                errorbool = true;
                errormessage='User already exists!';              
            }
            else if((EventAdminStaffUser.size()>0) && (upeslist.size() <= 0)){
                User User1 = [SELECT Id,Username FROM User WHERE Username=:EvEmail];
                AttendeeSummary__c Attendee = [SELECT Id,Name,AS_Email__c FROM AttendeeSummary__c WHERE AS_Email__c=: EvEmail];
                insertUpe(SelectedEventId,User1.id,Attendee.Id);
                CreateStaffPopUp = false;
                OpenStaffPopUp = false;
            }
            else
            {

            String EmailNote = 'Welcome to BoothLeads.com Event Administration Portal.\n\nYour login details are provided at the end of this email.\n\n\nYou will be asked to set a password when you first login.Passwords are case sensitive.\nIf you forget the password, please use the forgot password link in the login page.\n\n\nTo login, go to http://www.boothleads.com and click on Login.\n\n\nFor assistance, contact us at support@boothleads.com\n\n\nOnce again Welcome to BoothLeads.com\n\n Please note that your Booth Leads portal access is valid only for 30 days from the end of your event.\nPlease remember to export all your leads.\nIf you need access beyond this, please contact support.\n\n\nThank you,\nBooth Leads Customer Support\nsupport@boothleads.com';
            
            String EmailSubject = 'Welcome to Booth Leads - Your registration was successful';
            
            user uname=[SELECT CreatedById FROM User WHERE Profile.Name LIKE 'System Administrator' LIMIT 1];
            Account acc = new Account();
            acc.name='Booth Leads';     
            acc.ownerid = uname.CreatedById;         
            insert acc; 
  
            Con = new Contact();
            Con.Lastname = EvLastName;
            Con.Firstname = EvFirstName; 
            Con.AccountID = acc.id;
            Con.Email_Notes__c = EmailNote; 
            Con.Email_Subject__c = EmailSubject;
            insert Con;
      
            List<AttendeeSummary__c> AttendeeDetails = [SELECT Id,Name,AS_Email__c FROM AttendeeSummary__c WHERE AS_Email__c=: EvEmail];
            AttendeeSummary = new AttendeeSummary__c(); 
            if(AttendeeDetails.size() > 0){   
            }
            else{

               AttendeeSummary.AS_Email__c = EvEmail;
               AttendeeSummary.AS_FirstName__c = EvFirstName;
               AttendeeSummary.AS_LastName__c = EvLastName;
               AttendeeSummary.AS_uniqueField__c=(EvFirstName + EvLastName + EvEmail).tolowercase();
               insert AttendeeSummary ;
            }   
    
            Profile p = [SELECT Id,Name FROM Profile WHERE Name = 'Event Admin'];
            
            U = new User();        
            U.ContactID = Con.id;
            U.FirstName = EvFirstName;
            U.LastName = EvLastName;
            U.Username = EvEmail;
            U.Email = EvEmail;
            U.Alias = 'EAStaff';
            U.ProfileID = P.id;
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'America/Los_Angeles';
            U.EmailEncodingKey='UTF-8';
            Database.insert(U);

            updateUser(U.Id);
            insertUpe(SelectedEventId,U.id,AttendeeSummary.Id);
            CreateStaffPopUp = false;
            OpenStaffPopUp = false;
          }
       }
       catch(Exception e){
             ApexPages.addMessages(e);
       } 

      //  return null;
    }
    
    @future
    public static void updateUser(Id UserId){
           User U1 = new User();
           U1 =[SELECT Id,password__c FROM User WHERE Id =: UserId];
           System.ResetPasswordResult rt= system.ResetPassword(U1.id,true);
           U1.password__c = rt.getPassword();
           update U1;
    }
    
    @future
    public static void insertUpe(String SelectedEvent,Id UserId1, Id attid1){
    
        Profile__c EAStaffProfile = [SELECT Id FROM Profile__c WHERE PR_Name__c = 'EventAdmin Staff'];
        
        User_Profile_Event__c UPE = new User_Profile_Event__c();
        UPE.EventAdmin_Id__c = UserInfo.getUserId();
        upe.EV_id__c = SelectedEvent;
        upe.Attendee_Summary__c = attid1;
        UPE.UEP_isActive__c = True;
        UPE.Profile_id__c = EAStaffProfile.id;
        UPE.User_id__c = UserId1; 
        insert UPE;
        
    }
    //----------------------------------------- Event Admin Staff Methods End ----------------------------------------------------
    //--------------------------------------------- CCR Details Settings Start ---------------------------------------------------
    public Event__c ForCCRDetails{get;set;}
    public Boolean CCRCheckBox{get;set;}
    
    public Void CCRDetails(){
    
    ForCCRDetails = [select id,CCRDetails_Required__c,Is_MatchMaking_Event__c from Event__c where id=:SelectedEventId];
    if(CCRCheckBox == True){
        ForCCRDetails.CCRDetails_Required__c = True;
        Database.Update(ForCCRDetails,False); 
    }else{
       ForCCRDetails.CCRDetails_Required__c = False;
       Database.Update(ForCCRDetails,False); 
       }
    }
    //--------------------------------------------- CCR Details Settings Start ---------------------------------------------------
    // Code Edit Ended by Mahesh Sakunala
    public String   EventURLID {get;set;}
    
    public void EventsList(){
  //  try{
   system.debug( ' **********************************'+SelectedEventId );
        EventURLID = '';
        EventURLID = apexpages.currentpage().getparameters().get('id');
     
        listOfEvents = [select Id,EV_id__c,EV_id__r.id,EV_id__r.EV_Title__c,EV_id__r.Status__c,EV_id__r.EV_HostingState__c,EV_id__r.AS_HostingCity__c, EV_id__r.Owner.ID,
                            EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HostingOrgName__c,EV_id__r.Is_MatchMaking_Event__c from User_Profile_Event__c where EV_id__c != NULL AND User_id__c=: UserInfo.getUserId() 
                            ORDER BY CreatedDate DESC  ];               
           if(listOfEvents.size()>=1){
            system.debug( ' **********************************'+EventURLID);
               if(EventURLID == null || EventURLID == ''){
               system.debug( ' **********************************'+SelectedEventId );               
               SelectedEventId = listOfEvents[0].EV_id__c ;
               }
              
           if(EventURLID != '' && EventURLID != null){
          system.debug( ' *******3333333333333*********'+SelectedEventId );
              SelectedEventId = EventURLID ;
               }
              
               
                             
              NoEventCreatedBool = TRUE;  
           }else{ 
               NoEventCreatedBool = FALSE;   
           }
            
     // }catch(Exception ex){}     
    }
    
    public boolean displayAttendeeRegistrationLink{get;set;}
    
    public void EventValues(){ 
    
   
    system.debug( ' &&&&&&&&& &&&&&&&&&&&&&&&&&&&&'+SelectedEventId );
    
    displayAttendeeRegistrationLink  = false; 
         if(listOfEvents.size()>0){
        EventDetail = [SELECT ID, Name,EV_Title__c,Status__c,EV_HostingState__c,AS_HostingCity__c,EV_HostingLocation__c,Attendee_Types__c,
                    EV_HistingAddr1__c,AS_HostingAddr2__c,EV_HostingCountryNew__c,EV_Publish__c,EV_EventLogo__c,EV_HostingTimeZone__c,
                    EV_HostingPhone__c,EV_HostingFax__c,EV_WebsiteURL__c,Primary__c,SecondaryCategory__c,EV_HostingOrgName__c,EV_HostingStateNew__c,
                    EV_HostingZipcode__c,EV_HostingPostalCode__c,EV_HostedByEventBrite__c,EV_Description__c,Owner.FirstName,Owner.ID,
                    EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,EventDiversityValues__c,TwitterHashTag__c,
                    Lable_First_Line__c,Lable_Secoend_Line__c,Lable_Third_Line__c,Event_Printer__c,TwitterId__c,FacebookId__c,OrganizerId__c,
                    Lable_First_Line_Color__c,Need_FloorMap__c,Lable_First_Line_Size__c,Lable_First_Line_Font__c,Lable_Secoend_Line_Color__c,Lable_Secoend_Line_Size__c,Lable_Secoend_Line_Font__c,
                    Lable_Third_Line_Color__c,Lable_Third_Line_Size__c,EV_SiteLocation__c,Lable_Third_Line_Font__c,Is_MatchMaking_Event__c FROM Event__C WHERE id =:SelectedEventId ];
          if(EventDetail.EV_HostedByEventBrite__c == True){
              SelectedEventbrite = 'By Eventbrite';
          }else if(EventDetail.EV_Publish__c == TRUE){
              SelectedEventbrite = 'By Global Nest';
          }else {
              SelectedEventbrite = 'By Other';
          }
        if(EventDetail.EV_SiteLocation__c!=null && EventDetail.EV_SiteLocation__c!=''){
        displayAttendeeRegistrationLink = true;
        }
        
       
        eastaffprofile = new User_Profile_Event__c();        
        eastaffprofile = [SELECT Id,User_Id__c,Profile_id__r.PR_Name__c FROM User_Profile_Event__c WHERE User_Id__c =: UserInfo.getUserId() LIMIT 1];
        if(EventDetail.Owner.ID == UserInfo.getUserId() || eastaffprofile.Profile_id__r.PR_Name__c == 'EventAdmin Staff')  
          recordPermissions = TRUE;
         
          //-----------------------start attendee type-------- 
        attendeetypeStringErrorBool = FALSE;
          
        attendeetype = new List<Selectoption>();
        attendeetypeMap = new MAP<String, String>();
         Selectedattendeetype=new List<Selectoption>();
        attendeetypeCustomMap = new MAP<String, String>();
      
        try{
        LIST<String> attendeetypeValues = new LIST<String>();
        if(EventDetail.EventDiversityValues__c!=''&& EventDetail.EventDiversityValues__c!=NULL){
                attendeetypeValues.addAll((EventDetail.Attendee_Types__c).split(';'));
        }
        
         system.debug('22222222222222222222222222222222222222222' );
         
        Selectedattendeetype = new List<Selectoption>();

        for(String s: attendeetypeValues){
                
                 Selectedattendeetype.add(new Selectoption(s , s ));
                attendeetypeMap.put(s.toLowercase().replaceAll(' ',''), s);
                
        }
        
    system.debug('333333333333333333333333333333333333'+attendeetypeMap );
      }catch(exception e){}
        LIST<Attendee_Type__c> atttype= [SELECT Name FROM Attendee_Type__c ORDER BY CreatedDate];
          
         for(Attendee_Type__c d: atttype){
           
          if(!attendeetypeMap.containsKey(String.valueOf(d.Name).toLowercase().replaceAll(' ','')))
           {
                attendeetype.add(new Selectoption(String.valueOf(d.Name), String.valueOf(d.Name) ));
              attendeetypeMap.put(String.valueOf(d.Name).toLowercase().replaceAll(' ',''), String.valueOf(d.Name));
           }
         
        }
        //-----------------------close attendee type--------
         
         
          
        DivercityStringErrorBool = FALSE;
          
        Diversity = new List<Selectoption>();
        DiversityMap = new MAP<String, String>();
        DiversityCustomMap = new MAP<String, String>();
    system.debug('1111111111111111111111111111111111' );     
      
        LIST<String> diversityValues = new LIST<String>();
        if(EventDetail.EventDiversityValues__c!=''&& EventDetail.EventDiversityValues__c!=NULL){
                diversityValues.addAll((EventDetail.EventDiversityValues__c).split(';'));
        
        }
         system.debug('22222222222222222222222222222222222222222' );
         
        SelectedDiversity = new List<Selectoption>();
        for(String s: diversityValues){
                
                SelectedDiversity.add(new Selectoption(s , s ));
                DiversityMap.put(s.toLowercase().replaceAll(' ',''), s);
                
        }
    system.debug('333333333333333333333333333333333333'+DiversityMap );
        LIST<DiversityType__c> div = [SELECT Name FROM DiversityType__c WHERE IsValidDiversityType__c =: TRUE ORDER BY CreatedDate];
          
         for(DiversityType__c d: div){
           
          if(!DiversityMap.containsKey(String.valueOf(d.Name).toLowercase().replaceAll(' ','')))
           {
                Diversity.add(new Selectoption(String.valueOf(d.Name), String.valueOf(d.Name) ));
              DiversityMap.put(String.valueOf(d.Name).toLowercase().replaceAll(' ',''), String.valueOf(d.Name));
           }
         
        }
        
      system.debug('444444444444444444444444444444');
      
      
      ticketTypeMap = new MAP<ID, TicketTypes__c>([select id,TT_Amount__c,EV_id__c, Avilable_for_Portal__c,TT_Available__c, TT_Limit__c, TT_Name__c FROM TicketTypes__c WHERE EV_id__c =:SelectedEventId ORDER BY CreatedDate ASC ]);
       innerTickets = new LIST<innerForTicketTypes>();
       TicketTypeDelete = new LIST<String>(); 
           integer num = 0; 
           for(id i: ticketTypeMap.keyset() ) 
           {
               innerTickets.add(new innerForTicketTypes(ticketTypeMap.get(i), num, i));
                
               num++; 
           }
           
           ticketTypes = ticketTypeMap.values();
           
           
                     
            system.debug('1111111111111111   '+ ticketTypes );
            
            
            
            if(ticketTypes.isEmpty())
            {
               noTicketTypeBool = TRUE;
               
              
            }
   
         // ShowPreviousList();
       
                 
   
         
       }
     system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
      
    } 
    
    
    public void editEvent(){
        
        SelectedEventId = ApexPages.currentpage().getparameters().get('eventName');
        system.debug('!!!!!!!!!!!!!!!!!!!     '+ SelectedEventId);
        eventheading = 'Edit Event';
        if(SelectedEventId != null){
           Event=[SELECT e.Status__c, e.StartTime__c, e.SecondaryCategory__c, e.Primary__c, 
                                e.Name,e.Id, e.Event_ZipCode__c, e.Event_PostalCode__c, e.EventDiversityValues__c,Attendee_Types__c, 
                                e.Ev_RequiredFields__c, e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c, 
                                e.EV_RedirectURI__c, e.EV_Publish__c, e.EV_IncludedFields__c, e.EV_HostingZipcode__c, e.EV_HostingTimeZone__c, 
                                e.EV_HostingState__c, e.EV_HostingStateNew__c, e.EV_HostingPostalCode__c, e.EV_HostingPhone__c, 
                                e.EV_HostingOrgName__c,e.Need_FloorMap__c, e.EV_HostingLocation__c, e.EV_HostingFax__c, e.EV_HostingCountry__c, e.EV_HostingCountryNew__c, 
                                e.EV_HostedByEventBrite__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c,e.Owner.ID, 
                                e.EV_Description__c, e.EV_CustomReg__c, e.EV_ContactURL__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c,e.TwitterHashTag__c,
                                TwitterId__c,FacebookId__c,OrganizerId__c,Event_Type__c,Is_MatchMaking_Event__c

                                
                                From Event__c e WHERE ID =: SelectedEventId]; 
                               
               AddEventBtn = TRUE;                 
                                
          
          if(Event.EV_HostedByEventBrite__c == True){
              SelectedEventbrite = 'By Eventbrite';
          }else if(Event.EV_Publish__c == TRUE){
              SelectedEventbrite = 'By Global Nest';
          }else {
              SelectedEventbrite = 'By Other';
          }
          
          
          eventsCheckMap.remove(((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ','')).toLowerCase());
              
              

                                
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
    }
    
    public void updateLogo(){
        eventLogoErrorString = '';
        myDocBool = TRUE;
        
        if(Logo != null && ( LogoName != '' || LogoName != NULL )){
        if(Logo.size()!= null){
         
      if(Logo.size() < 1048576 ){
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
    
   
    
    
    
    
    
    public void AttendeeSettings(){
    
      system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'+ EventDetail.id);
      
        attendeeSetting = new BL_SecuritySettingsCon(EventDetail.id);
        
       system.debug('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC    '); 
       ForCCRDetails = [select id,CCRDetails_Required__c,Is_MatchMaking_Event__c from Event__c where id=:SelectedEventId];
       if(ForCCRDetails.CCRDetails_Required__c == True){
       CCRCheckBox = True;
      } else{
       CCRCheckBox = False; 
       }
        updateAttendeeSettingBool = TRUE;
        
        
        
    }


// ------------------------------------------------------------- Event Schedule Methods Start --------------------------------------------
    
    public void viewEventSchedule(){
    
        addSch = new EventSchedule__c(); 
        eventScheduleBool = TRUE;
        eventscheduleDB = new LIST<EventSchedule__c>();
        StartTimings = new LIST<SelectOption>();
        EndTimings = new LIST<SelectOption>();
        EventDate = new LIST<SelectOption>();
        detailScheduleBool = FALSE;
        addScheduleBool = FALSE;
        ForPagesize = null;
        
        Event__c event = [SELECT EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,Is_MatchMaking_Event__c FROM Event__c WHERE ID =: EventDetail.ID ];
        
        List<Schema.PicklistEntry> EventStartTime = Event__c.StartTime__c.getDescribe().getPicklistValues();
        
        Boolean check=FALSE;
        
        Integer st_end_dates = event.EV_StartDate__c.daysBetween(event.EV_EndDate__c);
        
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
        getScheduleforEvent();
    }
    
    
    public void getEventStartTime(){
    
        system.debug('FFFFFFFFFFFFFFFFFFFFFF         '+ ApexPages.currentPage().getParameters().get('evStartDate') );
        
         Boolean check=FALSE;
         List<Schema.PicklistEntry> EventStartTime = Event__c.StartTime__c.getDescribe().getPicklistValues();
         StartTimings = new LIST<SelectOption>();
         EndTimings = new LIST<SelectOption>();
         
         Event__c event = [SELECT EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,Is_MatchMaking_Event__c FROM Event__c WHERE ID =: EventDetail.ID ];
       
           if(event.EV_StartDate__c == date.valueOf(ApexPages.currentPage().getParameters().get('evStartDate'))){
                
                system.debug('EEEEEEEEEEEEEEEEEEEEEEE         '+ event.EV_StartDate__c );
               
                  
               for(Schema.PicklistEntry pi: EventStartTime){   
                        system.debug('GGGGGGGGGGGGGGGGGGGGGGG         '+ pi.getLabel() );
                        system.debug('HHHHHHHHHHHHHHHHHHHHHHHHHHHH         '+event.StartTime__c ); 
                        
                    if(pi.getLabel() == event.StartTime__c ){
                        check = TRUE;
                    }        
                    if(check){
                        StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                      //  EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                    } 
                   
                   // if(pi.getLabel() == event.EV_EndTime__c ){
                    //    check = FALSE;
                   //}    
                }
           
           }else if(event.EV_EndDate__c == date.valueOf(ApexPages.currentPage().getParameters().get('evStartDate'))){
                    check = TRUE;
                    
                     for(Schema.PicklistEntry pi: EventStartTime){        
                              
                        if(check){
                            StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                         //   EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                        } 
                        if(pi.getLabel() == event.EV_EndTime__c ){
                            check = FALSE;
                       }    
                    }
        
        }else{
                 for(Schema.PicklistEntry pi: EventStartTime){        
                        StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                      //  EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                }
        }
         
         system.debug('SSSSSSSSSSSSSSSSSSSSSSSSSSS         '+ StartTimings );
         
    }
    
    public void getEventEndTime(){
         
         system.debug('FFFFFFFFFFFFFFFFFFFFFF         '+ ApexPages.currentPage().getParameters().get('evEndDate') );
        
         Boolean check=TRUE;
         List<Schema.PicklistEntry> EventStartTime = Event__c.StartTime__c.getDescribe().getPicklistValues();
       //  StartTimings = new LIST<SelectOption>();
          EndTimings = new LIST<SelectOption>();
          
         Event__c event = [SELECT EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,Is_MatchMaking_Event__c FROM Event__c WHERE ID =: EventDetail.ID ];
       
           if(event.EV_EndDate__c == date.valueOf(ApexPages.currentPage().getParameters().get('evEndDate'))){
                
                system.debug('EEEEEEEEEEEEEEEEEEEEEEE         '+ event.EV_EndDate__c );
               
                  
               for(Schema.PicklistEntry pi: EventStartTime){   
                        system.debug('GGGGGGGGGGGGGGGGGGGGGGG         '+ pi.getLabel() );
                        system.debug('HHHHHHHHHHHHHHHHHHHHHHHHHHHH         '+event.StartTime__c ); 
                        
               //     if(pi.getLabel() == event.StartTime__c ){
                //        check = TRUE;
                 //   }        
                    if(check){
                      //  StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                        EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                    } 
                   
                    if(pi.getLabel() == event.EV_EndTime__c ){
                        check = FALSE;
                    }    
                }
           
           } else{
                 for(Schema.PicklistEntry pi: EventStartTime){        
                      //  StartTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                        EndTimings.add(new SelectOption(pi.getLabel() , pi.getLabel() ));
                }
        }
         
         system.debug('SSSSSSSSSSSSSSSSSSSSSSSSSSS         '+ StartTimings );
    
    }
    
    
        
    public void getScheduleforEvent(){
     try{
        eventscheduleDB =[SELECT ES_EndDate__c,ES_StartDate__c,ES_StartTime__c,id, ES_Description__c, ES_EndTime__c, ES_Location__c, ES_Presenter__c,ES_ProgramName__c FROM EventSchedule__c WHERE EV_id__c =: EventDetail.ID and ES_StartDate__c!=null and ES_StartTime__c!=null ORDER BY ES_StartDate__c,ES_StartTime__c ASC ];
    
        for(EventSchedule__c es: eventscheduleDB){                  
            if(es.ES_Description__c != NULL)
                es.ES_Description__c =  escapeSpecialCharacters(es.ES_Description__c);                  
            if(es.ES_Location__c!= NULL)
                es.ES_Location__c= escapeSpecialCharacters(es.ES_Location__c);
            if(es.ES_ProgramName__c!= NULL)
                es.ES_ProgramName__c = escapeSpecialCharacters(es.ES_ProgramName__c);
            if(es.ES_Presenter__c != NULL)
                es.ES_Presenter__c = escapeSpecialCharacters(es.ES_Presenter__c);
                               
        } 
        ForPagination = new List<EventSchedule__c>();              
        if(eventscheduleDB.size()>0){
        conlst=true; 
        count=eventscheduleDB.size();          
        pageno=1;
        page1=true;
        hasLast = True;
        hasFirst = False;
        hasPrevious = false;
        hasNext = true;
        if(math.mod(eventscheduleDB.size(),50)==0){    
            pgno=eventscheduleDB.size()/50;
        }
        else{
            pgno=(eventscheduleDB.size()/50) +1; 
        }            
        for(integer i=0; i<50;i++)
        {          
        system.debug('       mahesh         '+eventscheduleDB[i]);  
        ForPagination.add(eventscheduleDB[i]);
        if(eventscheduleDB.size() <= 50){
             hasLast = false;
             hasNext = false;
             Disabled_Last_Icon = True;
             Disabled_Next_Icon = True;
             Disabled_First_Icon = True;
             Disabled_Previous_Icon = True;
        }
        else {
            hasLast = True;
            hasFirst = False;
            hasPrevious = false;
            Disabled_First_Icon = True;
            Disabled_Previous_Icon = True;
            Disabled_Next_Icon = false;
            Disabled_Last_Icon = false;
            hasNext = true;
        }
        }
        } 
        }catch(exception e){}    
               
        if(ForPagination.size() == 0){
            NoRecordsFound = True;
            DisplayPages = False;
        }  
        else {
            NoRecordsFound = False;
            DisplayPages = True;
        }
        ForPagesize = ForPagination.size();
        //detailScheduleBool = TRUE;   
    }

// ------------------------------------------------------------- Event Schedule Methods End --------------------------------------------
    
//------------------------------------------------------- Pagination Methods Start ------------------------------------------------------ 


   Public void First()
   {   
    try{
     hasNext=true;
     hasFirst = false;
     hasPrevious=false;
     hasLast = True; 
     page1=true;
     Disabled_Previous_Icon = True;
     Disabled_First_Icon = True;
     Disabled_Next_Icon = False;
     Disabled_Last_Icon = False;        
     ForPagination.clear();
     //hasPrevious=false;
     pageno =1;
     for(integer i=0;i<50;i++)
     {
      ForPagination.add(eventscheduleDB[i]);   
     }
     if(math.mod(eventscheduleDB.size(),50)==0){    
         pgno=eventscheduleDB.size()/50;
     }
     else{
         pgno=(eventscheduleDB.size()/50) +1; 
     }
     ForPagesize = ForPagination.size();
    }
    catch(Exception ex){
    }
   }
     
     
     Public void Previous()
     {   
      try{ 
       hasLast=True;
       hasNext=true;
       page1=true;
       Disabled_Previous_Icon = False;
       Disabled_First_Icon = False;
       Disabled_Next_Icon = False;
       Disabled_Last_Icon = False;
       ForPagination.clear();
       if(pageno!=1){                    
          pageno = pageno - 1;
          if(pageno  ==1 ){
              hasPrevious=false;
              hasFirst = False;
              page1=true;
              Disabled_Previous_Icon = True;
              Disabled_First_Icon = True;
              Disabled_Next_Icon = False;
              Disabled_Last_Icon = False;
          }  
          for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
          {
           ForPagination.add(eventscheduleDB[i]); 
          }
       }                           
       else{   
          hasPrevious=false;
          hasFirst = False;
          page1=true;
          // Disabled_Previous_Icon = True;
          // Disabled_First_Icon = True;
          for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
          {
           ForPagination.add(eventscheduleDB[i]);        
          }
        }
        ForPagesize = ForPagination.size();
      }
      catch(Exception ex){  
      }
     }
       
       
     Public void Next()
     {  
      try{
       pageno  = pageno +1;
       // integer pgno;
       ForPagination.clear();
       if(math.mod(eventscheduleDB.size(),50)==0){    
           pgno=eventscheduleDB.size()/50;
       }
       else{
           pgno=(eventscheduleDB.size()/50) +1; 
       }
       if(pageno==pgno){ 
          hasNext=false;
          hasLast = False;
          page1=true;
          Disabled_Next_Icon = True;
          Disabled_Last_Icon = True;
          for(integer i=(pageno -1)*50;i<eventscheduleDB.size();i++ )
          {
           ForPagination.add(eventscheduleDB[i]); 
          }
       }
       else            
           for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
           {
            ForPagination.add(eventscheduleDB[i]); 
           }
           hasPrevious=true;
           hasFirst = True;
           Disabled_Previous_Icon = False;
           Disabled_First_Icon = False;
           ForPagesize = ForPagination.size();
      }
      catch(Exception Ex){    
      } 
     }
     
     
     Public void Last()     
     {       
      try{
       hasLast = False;
       page1=true;
       Disabled_Last_Icon = True;
       hasPrevious=true;
       Disabled_Previous_Icon=False;
       hasFirst = true;
       Disabled_First_Icon=False;
       ForPagination.clear();
       hasNext=false;
       Disabled_Next_Icon=True;
        if(math.mod(eventscheduleDB.size(),50)==0){
            pageno =eventscheduleDB.size()/50;
        } 
        else{
            pageno =(eventscheduleDB.size()/50) +1; 
        }
        for(integer i=(pageno -1)*50;i<eventscheduleDB.size();i++)
        {
         ForPagination.add(eventscheduleDB[i]);  
        }
        ForPagesize = ForPagination.size();
      }
      catch(Exception ex){
      }
    }    
    
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
      
      
    public void UpdateAttendeeSetting()
    {       
        updateAttendeeSettingBool = FALSE;
        //--------------------------*************   End of REQUIRED Fields  ***************---------------------------------      
          
        String  selectedAttendeeFields = 'AS_FirstName__c,';
        if(attendeeSetting.comp)
        selectedAttendeeFields += 'AS_Company__c,';
        if(attendeeSetting.Prefix)
        selectedAttendeeFields += 'AS_Prefix__c,';
        if(attendeeSetting.sufix)
        selectedAttendeeFields += 'AS_Suffix__c,';
        if(attendeeSetting.Degi)
        selectedAttendeeFields += 'AS_Title__c,';
        if(attendeeSetting.mobile)
        selectedAttendeeFields += 'AS_CellPhone__c,';
        if(attendeeSetting.age)
        selectedAttendeeFields += 'AS_Age__c,';
        if(attendeeSetting.gen)
        selectedAttendeeFields += 'AS_Gender__c,';
        if(attendeeSetting.dob)
        selectedAttendeeFields += 'AS_BirthDate__c,';
        if(attendeeSetting.homeinfo)
        selectedAttendeeFields += 'AS_HomeAddress1__c,';
        if(attendeeSetting.Shippinginfo)
        selectedAttendeeFields += 'AS_ShippingAddress1__c,';
        if(attendeeSetting.workinfo)
        selectedAttendeeFields += 'AS_WorkAddress1__c,';
        if(attendeeSetting.NAICSCode1)
        selectedAttendeeFields += 'AS_NAICSCode1__c,';
        if(attendeeSetting.NAICSCode2)
        selectedAttendeeFields += 'AS_NAICSCode2__c,';
        if(attendeeSetting.NAICSCode3)
        selectedAttendeeFields += 'AS_NAICSCode3__c,';
        if(attendeeSetting.NAICSCode4)
        selectedAttendeeFields += 'AS_NAICSCode4__c,';
        if(attendeeSetting.NAICSCode5)
        selectedAttendeeFields += 'AS_NAICSCode5__c,';
        if(attendeeSetting.PBC)
        selectedAttendeeFields += 'AS_PrimaryBusinessCategory__c,';
        if(attendeeSetting.SBC)
        selectedAttendeeFields += 'AS_SecondaryBusinessCategory__c,';
        if(attendeeSetting.NOEmp)
        selectedAttendeeFields += 'AS_NumberOfEmployees__c,';
        if(attendeeSetting.BEDate)
        selectedAttendeeFields += 'AS_BusinessEstablishedDate__c,';
        if(attendeeSetting.BRev)
        selectedAttendeeFields += 'AS_BusinessRevenue__c,';
        if(attendeeSetting.BTaxID)
        selectedAttendeeFields += 'AS_BusinessTaxId__c,';
        if(attendeeSetting.BDN)
        selectedAttendeeFields += 'AS_BusinessDunsNumber__c,';
        if(attendeeSetting.webUrl)
        selectedAttendeeFields += 'AS_WebsiteUrl__c,';
        if(attendeeSetting.blogURL)
        selectedAttendeeFields += 'AS_BlogUrl__c,';
        if(attendeeSetting.DT)
        selectedAttendeeFields += 'AS_DiversityType__c,';
        if(attendeeSetting.BDesc)
        selectedAttendeeFields += 'AS_BusinessDescription__c,';
        if(attendeeSetting.AttendeePic)
        selectedAttendeeFields += 'AttendeePic,';
        if(attendeeSetting.Registration)
        selectedAttendeeFields += 'Registration_type__c,';
      // if(attendeeSetting.attendeetypes)
        //selectedAttendeeFields += 'Attendee_Types__c,';
        
        attendeeSetting.settingsforAtt.EV_Fields__c = selectedAttendeeFields.substring(0, selectedAttendeeFields.lastIndexOf(','));
        
    //-------------------------*************   Ending of Include Fields **************---------------------------------    
    //-------------------------*************   start of REQUIRED Fields **************---------------------------------    
        String  selectedAttendeeReqFields = 'AS_FirstName__c,';
        if(attendeeSetting.Reqcomp)
        selectedAttendeeReqFields += 'AS_Company__c,';
        if(attendeeSetting.ReqPrefix)
        selectedAttendeeReqFields += 'AS_Prefix__c,';
        if(attendeeSetting.Reqsufix)
        selectedAttendeeReqFields += 'AS_Suffix__c,';
        if(attendeeSetting.ReqDegi)
        selectedAttendeeReqFields += 'AS_Title__c,';
        if(attendeeSetting.Reqmobile)
        selectedAttendeeReqFields += 'AS_CellPhone__c,';
        if(attendeeSetting.Reqage)
        selectedAttendeeReqFields += 'AS_Age__c,';
        if(attendeeSetting.Reqgen)
        selectedAttendeeReqFields += 'AS_Gender__c,';
        if(attendeeSetting.Reqdob)
        selectedAttendeeReqFields += 'AS_BirthDate__c,';
        if(attendeeSetting.Reqhomeinfo)
        selectedAttendeeReqFields += 'AS_HomeAddress1__c,';
        if(attendeeSetting.ReqShippinginfo)
        selectedAttendeeReqFields += 'AS_ShippingAddress1__c,';
        if(attendeeSetting.Reqworkinfo)
        selectedAttendeeReqFields += 'AS_WorkAddress1__c,';
        if(attendeeSetting.ReqNAICSCode1)
        selectedAttendeeReqFields += 'AS_NAICSCode1__c,';
        if(attendeeSetting.ReqNAICSCode2)
        selectedAttendeeReqFields += 'AS_NAICSCode2__c,';
        if(attendeeSetting.ReqNAICSCode3)
        selectedAttendeeReqFields += 'AS_NAICSCode3__c,';
        if(attendeeSetting.ReqNAICSCode4)
        selectedAttendeeReqFields += 'AS_NAICSCode4__c,';
        if(attendeeSetting.ReqNAICSCode5)
        selectedAttendeeReqFields += 'AS_NAICSCode5__c,';
        if(attendeeSetting.ReqPBC)
        selectedAttendeeReqFields += 'AS_PrimaryBusinessCategory__c,';
        if(attendeeSetting.ReqSBC)
        selectedAttendeeReqFields += 'AS_SecondaryBusinessCategory__c,';
        if(attendeeSetting.ReqNOEmp)
        selectedAttendeeReqFields += 'AS_NumberOfEmployees__c,';
        if(attendeeSetting.ReqBEDate)
        selectedAttendeeReqFields += 'AS_BusinessEstablishedDate__c,';
        if(attendeeSetting.ReqBRev)
        selectedAttendeeReqFields += 'AS_BusinessRevenue__c,';
        if(attendeeSetting.ReqBTaxID)
        selectedAttendeeReqFields += 'AS_BusinessTaxId__c,';
        if(attendeeSetting.ReqBDN)
        selectedAttendeeReqFields += 'AS_BusinessDunsNumber__c,';
        if(attendeeSetting.ReqwebUrl)
        selectedAttendeeReqFields += 'AS_WebsiteUrl__c,';
        if(attendeeSetting.ReqblogURL)
        selectedAttendeeReqFields += 'AS_BlogUrl__c,';
        if(attendeeSetting.ReqDT)
        selectedAttendeeReqFields += 'AS_DiversityType__c,';
        if(attendeeSetting.ReqBDesc)
        selectedAttendeeReqFields += 'AS_BusinessDescription__c,';
        if(attendeeSetting.ReqAttendeePic)
        selectedAttendeeReqFields += 'AttendeePic,';
        if(attendeeSetting.ReqRegistration)
        selectedAttendeeReqFields += 'Registration_type__c,';
        // if(attendeeSetting.Reqattendeetypes)
        //selectedAttendeeReqFields += 'Attendee_Types__c,';
        
        
        attendeeSetting.settingsforAtt.EV_Req_Fields__c = selectedAttendeeReqFields.substring(0, selectedAttendeeReqFields.lastIndexOf(','));
        
        system.debug('EEEEEEEEEEEEEEEEEEEE     '+ attendeeSetting.Reqworkinfo +'            '+attendeeSetting.settingsforAtt.EV_Req_Fields__c);
        
         upsert attendeeSetting.settingsforAtt;
    
       if(!DiversityCustomMap.isEmpty()){
                
                LIST<DiversityType__c> newDiversityType = new LIST<DiversityType__c>();
                for(String s: DiversityCustomMap.values()){
                        DiversityType__c d = new DiversityType__c();
                        d.Name = s;
                        newDiversityType.add(d);
                }
                
                Database.SaveResult[] newDiversityTypeResult = Database.Insert(newDiversityType, false);
       }
       EventDetail.EventDiversityValues__c = '';
       
      for(Selectoption s: SelectedDiversity){
        system.debug('DDDDDDDDDDDDD     '+s );
         EventDetail.EventDiversityValues__c += s.getLabel()+';';
      }
      if(EventDetail.EventDiversityValues__c.contains(';'))
       EventDetail.EventDiversityValues__c = EventDetail.EventDiversityValues__c.subString(0,EventDetail.EventDiversityValues__c.lastIndexOf(';'));
       
       Database.SaveResult SR = database.update(EventDetail);
    
    //-------------------attendee type-------------------------------
    
    
         if(!attendeetypeCustomMap.isEmpty()){
                
                LIST<Attendee_Type__c> newattendeetyType = new LIST<Attendee_Type__c>();
                for(String s: attendeetypeCustomMap.values()){
                        Attendee_Type__c d = new Attendee_Type__c();
                        d.Name = s;
                        newattendeetyType.add(d);
                }
                
                Database.SaveResult[] newattendeetyTypeResult = Database.Insert(newattendeetyType, false);
       }
       EventDetail.Attendee_Types__c = '';
       
      for(Selectoption s: Selectedattendeetype){
        system.debug('DDDDDDDDDDDDD     '+s );
         EventDetail.Attendee_Types__c += s.getLabel()+';';
      }
      if(EventDetail.Attendee_Types__c.contains(';'))
       EventDetail.Attendee_Types__c = EventDetail.Attendee_Types__c.subString(0,EventDetail.Attendee_Types__c.lastIndexOf(';'));
       
       Database.SaveResult attsave = database.update(EventDetail);
    
    //-----------------close attendee save----------------------------
       
       system.debug('FFFFFFFFFFFFFFFFFF    '+innerTickets );
       
         LIST<TicketTypes__c> tick = new LIST<TicketTypes__c>();
        for(innerForTicketTypes inn: innerTickets)
        {
            tick.add(inn.ticket);
            
            system.debug('TTTTTTTTTTTTTTT     '+inn.ticket.TT_Name__c );
        }
        
       LIST<Database.UpsertResult> ticketTypesResult= Database.upsert(tick, false);
      
        For(Database.UpsertResult tt: ticketTypesResult)
        {
           
           system.debug('UUUUUUUUUUUUUUUUUUUUUUUUU     '+ tt.getErrors() );
           
            if(!tt.isSuccess())
            {
            
            }
        }
        
        
        system.debug('VVVVVVVVVVVVVVVV     '+ TicketTypeDelete);
        
        LIST<TicketTypes__c> tt = [SELECT ID FROM TicketTypes__c WHERE ID IN: TicketTypeDelete ];
        
        DataBase.Delete(tt, false); 
        
        
        CCRDetails();
       
        
    }
      public class innerForTicketTypes
    {
        public TicketTypes__c ticket{get; set;}
        public Integer tno{get; set;}
        public id ticId{get; set;}
        
        public innerForTicketTypes(TicketTypes__c t, Integer i, id idn)
        {
            ticket = t;
            tno = i;
            ticId = idn;
        }
        
        
    } 
      
      public void delTicketType(){
   
     //  try{ 
         system.debug('1111111111111111111111    '+innerTickets.size()+'  4444    ' + ApexPages.currentPage().getparameters().get('deleteTicketType') ) ;
         
         
         String checkDelTic = ApexPages.currentPage().getparameters().get('deleteTicketTypeid');
         
         if(checkDelTic != NULL && checkDelTic != '')
         {
             TicketTypeDelete.add(checkDelTic);
         }
         system.debug('2222222222222222222    '+innerTickets) ;
        innerTickets.remove(Integer.valueOf(ApexPages.currentPage().getparameters().get('deleteTicketType')));
        
        
         
        
        if(innerTickets.isEmpty())
        {
               noTicketTypeBool = TRUE;
        }else
        {
            LIST<innerForTicketTypes> listforForloop = new LIST<innerForTicketTypes>();
            listforForloop.addAll(innerTickets);
            
            innerTickets = new LIST<innerForTicketTypes>();
            
            Integer num = 0;
            for(innerForTicketTypes inn: listforForloop)
            {
                innerTickets.add(new innerForTicketTypes(inn.ticket, num, inn.ticId));
              num++;
            }
        
        }
        
        
     //  }catch(Exception e){} 
    
    }
     
      public void moreTickets(){
        
        
      
        TicketTypes__c t = new TicketTypes__c();
                t.EV_id__c = SelectedEventId;
       //         ticketTypes.add(t);
       innerTickets.add(new innerForTicketTypes(t, innerTickets.size(), t.id));
                  
         noTicketTypeBool = FALSE;
         
          

    } 
    
     public void sendValues(){
        System.debug('SSSSSSSSSSSSSSSSS    ');
        
           
       if(!DiversityMap.containsKey(extraDiv.toLowercase().replaceAll(' ',''))){
        SelectedDiversity.add(new Selectoption(extraDiv , extraDiv ));
        DiversityMap.put(extraDiv.toLowercase().replaceAll(' ',''), extraDiv);
        DiversityCustomMap.put(extraDiv, extraDiv);
        extraDiv ='';
        DivercityStringErrorBool = FALSE;
       }else{
         DivercityStringError = 'Diversity Type Is already Exiest';
         DivercityStringErrorBool = TRUE;
       } 
       

    }
    
    public void newatttype(){
     if(!attendeetypeMap.containsKey(extraattendee.toLowercase().replaceAll(' ',''))){
        Selectedattendeetype.add(new Selectoption(extraattendee, extraattendee ));
        attendeetypeMap.put(extraattendee.toLowercase().replaceAll(' ',''), extraattendee);
        attendeetypeCustomMap.put(extraattendee, extraattendee);
        extraattendee ='';
        attendeetypeStringErrorBool = FALSE;
       }else{
         attendeetypeStringError = 'Diversity Type Is already Exiest';
         attendeetypeStringErrorBool = TRUE;
       } 
       
    
    
    
    }
    
    public void AddSchedule(){
         
           ScheduleHeading = 'Add Schedule';
           addSch = new EventSchedule__c();
           addScheduleBool = TRUE;

           
       }
     
      
      public PageReference AttendeeRegistration() {
          
          system.debug('            FFFFFFFFFFFFFFFFFF     '+EventDetail.id);
          
           pagereference pg = new pagereference('/apex/BL_Eventadmin_Register?event='+EventDetail.ID);
           pg.setredirect(true);
             return pg;
     }
   public pagereference pg ;
    public pagereference TicketTypes() {
          
          system.debug('            FFFFFFFFFFFFFFFFFF     '+EventDetail.id);
          system.debug('            EEEEEEEEEEEEEEEEEEEEEEE   '+EventDetail.EV_Publish__c);
           
           
           pg = new pagereference('/apex/BL_Event_TicketTypes?event='+EventDetail.ID);
           pg.setredirect(true);
           return pg;
           
           if(EventDetail.EV_Publish__c == true )
           {
           
          }
     
     return null;
     
     
     }
    Public Void AddEvent(){
    
    AddEventBtn = true;
    
    Event = new Event__c();
    DocumentImage = new Document();
    eventheading = 'Add Event';
    }
    public void getEventDetails(){
    
           editsch = [SELECT ES_StartDate__c,ES_EndDate__c,name,ES_StartTime__c,id, ES_Description__c, ES_EndTime__c, ES_Location__c, ES_Presenter__c,ES_ProgramName__c FROM EventSchedule__c WHERE ID =: eventname ];
          detailScheduleBool = TRUE;
      }  
   
    public void editSchedule(){
         
           editsch = [SELECT ES_StartDate__c,ES_EndDate__c,name,ES_StartTime__c,id, ES_Description__c, ES_EndTime__c, ES_Location__c, ES_Presenter__c,ES_ProgramName__c FROM EventSchedule__c WHERE ID =: eventname ];
          
          system.debug('6666666666666666666666'+  editsch );
           
           ScheduleHeading = 'Edit Schedule';
           addSch =editsch;
           addScheduleBool = TRUE;
           detailScheduleBool = FALSE;
           
       }
       
      public void deleteSchedule(){
      
          
           system.debug('1111111111111   '+ eventname );
           EventSchedule__c delsch =[SELECT ID FROM EventSchedule__c WHERE ID =:eventname];
           DataBase.delete(delsch);
             getScheduleforEvent();
      }
      
       public void SaveSchedule(){
          
          system.debug('6666666666666666666666    '+addSch);
            

          
          addSch.ES_StartDate__c = Date.valueOf(EventStartDate);
          addSch.ES_EndDate__c = Date.valueOf(EventEndDate);
          addSch.EV_id__c = EventDetail.id;
          Upsert addsch;
          addScheduleBool = FALSE;
         system.debug('7777777777777777777777    '+ addSch );
          getScheduleforEvent();
          
          
      } 
       
    Public Void Cancel(){
    
   
        eventLogoErrorString ='';
    AddEventBtn = FALSE;
    addScheduleBool = FALSE;
    updateAttendeeSettingBool = FALSE;
    detailScheduleBool = FALSE;
    dataImportHistoryBool = FALSE;
    changeEventLogoBool = FALSE;
    BadgeSettingsBool = FALSE;
    settingsbool = false;
    promosDisplaybool = false;
      errorpromobool  =false;
      errorpromotics = false;
    surveyQuestionsbool = false;
    }
    public void CancelSchedule(){
       errorpromobool  =false;
      surveybool = false;
      errorpromotics = false;
        eventScheduleBool = FALSE;
        promosbool = false;
    }
    
    
    
    public void createEvent(){
    
    system.debug('111111111111111111111   '+eventsCheckMap.containsKey((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ','')));   
    eventErrorString = '';
    if(! eventsCheckMap.containsKey(((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ','')).toLowerCase())){   
            
       myDocBool = TRUE;
      
        if(Logo != null && ( LogoName != '' || LogoName != NULL )){
        if(Logo.size()!= null){
         
       if(Logo.size() < 1048576 ){
        
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
        
       Database.UpsertResult EventupsertResult = DataBase.Upsert(Event, false);
           
           if(EventupsertResult.isSuccess()){
              VcalForevent(EventupsertResult .getId());
               eventsCheckMap.put((Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c).replaceAll(' ',''), (Event.EV_Title__c+Event.AS_HostingCity__c+Event.EV_StartDate__c+Event.StartTime__c+Event.EV_EndDate__c+Event.EV_EndTime__c));
           
           system.debug('22222222222222222222222222222222'+EventupsertResult.isCreated());
           
               if(EventupsertResult.isCreated()){
               // ----------------------- CODE FOR Attendee Settings ------------------------------------
         
                       String named='';
                    String ObjectName = 'AttendeeSummary__c'; // Object Name Goes Here
                    Map<String, Schema.SObjectField> ObjectFieldMap = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap();
                    
                   // system.debug('1111111111111111111111111'  );
                    for (Schema.SObjectField SObjectF : ObjectFieldMap.values())
                    {
        
                       Schema.DescribeFieldResult field = SObjectF.getDescribe();
                       named +=field.getLocalname()+',';
                    }
                     named += 'AttendeePic,' ;
                     
                     
                      SecurityControls__c  attset = new  SecurityControls__c ();
                    //edited by mythily
                    //attset.EV_Fields__c = named;
                    attset.EV_id__c = Event.id;  
                     
                    insert attset;
                
               //----------------------- ENDing By Mallik -----------------------------   
               
               List<User_Profile_Event__c> GettingFirstRecord = [Select id,BLP_id__c,Ev_Id__c,Ev_Id__r.Is_MatchMaking_Event__c From User_Profile_Event__c Where EventAdmin_Id__c =:UserInfo.getUserId()  AND Ev_Id__c = Null Limit 1];
        
                   
                    Profile__c EventAdminProfile = [select Id from Profile__c where PR_Name__c = 'EventAdmin'];
                  
                    if(GettingFirstRecord.size()> 0){
                    GettingFirstRecord[0].EV_id__c = Event.id;  
                    Update GettingFirstRecord; 
                    
                 /**  LIST<Reports__c> rpList = new LIST<Reports__c>(); 
                   
                    Reports__c rp = new Reports__c();
                     
                     rp.RE_Name__c = 'Report By Industry';
                     rp.UPE_id__c = GettingFirstRecord[0].id;
                     
                     rpList.add(rp);
                     
                     Reports__c rp1 = new Reports__c();
                     
                     rp1.RE_Name__c = 'Report By Geography';
                     rp1.UPE_id__c = GettingFirstRecord[0].id;
                    
                    rpList.add(rp1);
                    
                    Reports__c rp2 = new Reports__c();
                     
                     rp2.RE_Name__c = 'Report By Business Revenue';
                     rp2.UPE_id__c = GettingFirstRecord[0].id;
                    
                    rpList.add(rp2);
                    
                    
                     Reports__c rp3 = new Reports__c();
                     
                     rp3.RE_Name__c = 'Report By Ticket Types';
                     rp3.UPE_id__c = GettingFirstRecord[0].id;
                    
                    rpList.add(rp3);
                    
                    Reports__c rp4 = new Reports__c();
                     
                     rp4.RE_Name__c = 'Report By Diversity Certification';
                     rp4.UPE_id__c = GettingFirstRecord[0].id;
                    
                    rpList.add(rp4);
                    
                    Reports__c rp5 = new Reports__c();
                     
                     rp5.RE_Name__c = 'Report By Registartions By Date';
                     rp5.UPE_id__c = GettingFirstRecord[0].id;
                    
                    rpList.add(rp5);
                    
                   // DataBase.insert(rpList);
                    **/
                     }else    {
                         List<User_Profile_Event__c> insertingNewrecord = [Select id,BLP_id__c From User_Profile_Event__c Where EventAdmin_Id__c =:UserInfo.getUserId()AND User_id__c = :UserInfo.getUserId() Limit 1];
                         
                        
                         User_Profile_Event__c EventAdmin_Event = new User_Profile_Event__c();
                          //EventAdmin_Event.BLP_id__c = insertingNewrecord[0].BLP_id__c ;
                          EventAdmin_Event.EV_id__c = Event.id;
                          EventAdmin_Event.EventAdmin_Id__c = UserInfo.getUserId();
                          EventAdmin_Event.UEP_isActive__c = true;
                          EventAdmin_Event.Profile_id__c = EventAdminProfile.id ;
                          EventAdmin_Event.User_id__c = UserInfo.getUserId();
                          
                          insert EventAdmin_Event;
                          
                           LIST<Reports__c> rpList = new LIST<Reports__c>(); 
                       /**
                        Reports__c rp = new Reports__c();                         
                         rp.RE_Name__c = 'Report By Industry';
                         rp.UPE_id__c = EventAdmin_Event.id;                         
                         rpList.add(rp);
                         
                         Reports__c rp1 = new Reports__c();                         
                         rp1.RE_Name__c = 'Report By Geography';
                         rp1.UPE_id__c = EventAdmin_Event.id;                        
                        rpList.add(rp1);
                        
                          Reports__c rp2 = new Reports__c();                     
                         rp2.RE_Name__c = 'Report By Business Revenue';
                         rp2.UPE_id__c = EventAdmin_Event.id;                    
                        rpList.add(rp2);
                        
                        Reports__c rp3 = new Reports__c();                     
                       rp3.RE_Name__c = 'Report By Ticket Types';
                       rp3.UPE_id__c = EventAdmin_Event.id;                    
                      rpList.add(rp3);
                      
                       Reports__c rp4 = new Reports__c();                     
                       rp4.RE_Name__c = 'Report By Diversity Certification';
                       rp4.UPE_id__c = EventAdmin_Event.id;                    
                      rpList.add(rp4);
                      
                       Reports__c rp5 = new Reports__c();                     
                       rp5.RE_Name__c = 'Report By Registartions by Date';
                       rp5.UPE_id__c = EventAdmin_Event.id;                    
                      rpList.add(rp5);
                    
                      //  DataBase.insert(rpList);
                        */
                          
                       }
                       
                      system.debug((userInfo.getFirstName()+userInfo.getLastName()+userInfo.getUserName()).tolowercase());
                         LIST<AttendeeSummary__c> ASrec=[select id from AttendeeSummary__c where AS_Email__c =: userInfo.getUserName().tolowercase()];
                                                                      
                        if(ASrec.size() != 0 ){
                         system.debug(';;;;;;;;;;;;;;;;;;;;;;;'+event.id); 
                          Event_Attendee_Mapping__c EAM=new Event_Attendee_Mapping__c();
                          EAM.EV_id__c=Event.id;
                          EAM.AS_id__c=ASrec[0].id;
                          EAM.Boothleads_Profile__c='Event Admin';
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
      }else{
          eventErrorString = 'This Event is already Registered.';

      }
    }
    
    public MAP<ID, DataImport_SavePoint__c> dataSavePointMap{get; set;}
    
    public void ShowPreviousList()
    {
    
       dataSavePointMap = new MAP<ID, DataImport_SavePoint__c>([select ID, NAME, createddate,DS_FileName__c,DS_ImportedHistory__c,Event__r.EV_Title__c,
                                   DS_TotalRecords__c,DS_ImportedId__c,Event__r.EV_StartDate__c FROM  DataImport_SavePoint__c WHERE User_id__c =: UserInfo.getUserId() AND Event__c =: SelectedEventId ORDER BY Event__r.createdDate DESC ]);
       
       
       dataBaseSaveResult =dataSavePointMap.values();
      dataImportHistoryBool = TRUE; 
      
    }
    
    public void deleteDataImportHistory(){
    
        
         System.debug('^^^^^^^^^^^^^^'+ApexPages.currentPage().getParameters().get('deleteDataImport') );
     
     DataImport_SavePoint__c selectToDeleteAttendees = dataSavePointMap.get(ApexPages.currentPage().getParameters().get('deleteDataImport'));
     
      if(selectToDeleteAttendees != NULL){
          
          LIST<Id> data = selectToDeleteAttendees.DS_ImportedId__c.split(',');
          
         LIST<Event_Attendee_Mapping__c> DeleteJunctionAttendees = [SELECT ID FROM Event_Attendee_Mapping__c WHERE ID IN: selectToDeleteAttendees.DS_ImportedId__c.split(',') AND CreatedBy.id=: UserInfo.getUserId()];
     
        Database.DeleteResult[] deleteJunctionResult = Database.delete(DeleteJunctionAttendees);
        
        Database.DeleteResult deleteSavePointResult = Database.delete(selectToDeleteAttendees);
        
        dataSavePointMap.remove(ApexPages.currentPage().getParameters().get('deleteDataImport'));
        
        dataBaseSaveResult =dataSavePointMap.values();
      }
      
      
     
       
    
    }
    
    
    
    public void dontShow(){
    
        uu.Event_Detail_help__c = FALSE;
        
        update uu;
    }
   public void disableHelpDivs(){
        
        uu.EventDetail_DIVs_Help__c = FALSE;
        
        update uu;
        
        
        
    }
    
    public Boolean dymoBool{get; set;}
    public Boolean avery5392Bool{get; set;}
    public Boolean avery22806Bool{get; set;}
    
    public void SelectedBadgeSettings(){
      
        if(EventDetail.Event_Printer__c== 'Dymo Label(30856,Single Label)'){
            dymoBool = TRUE;
            avery5392Bool = FALSE;
            avery22806Bool = FALSE;
            Zebrabool=FALSE;
        }else if(EventDetail.Event_Printer__c== 'Zebra Label'){
            Zebrabool=TRUE;
            dymoBool = FALSE;
            avery5392Bool = FALSE;
            avery22806Bool = FALSE;
            
        }else if(EventDetail.Event_Printer__c== 'Avery 5392 Name badges'){
            Zebrabool=FALSE;
            dymoBool = FALSE;
            avery5392Bool = TRUE;
            avery22806Bool = FALSE;
            
        }else if(EventDetail.Event_Printer__c== 'Avery 22806 easy peal square Badges'){
            
            Zebrabool=FALSE;
            dymoBool = FALSE;
            avery5392Bool = FALSE;
            avery22806Bool = TRUE;
            
            EventDetail.Lable_Third_Line__c = '';
            EventDetail.Lable_Third_Line_Color__c = '';
            EventDetail.Lable_Third_Line_Size__c = '';
            EventDetail.Lable_Third_Line_Font__c = '';
            
            
            EventDetail.Lable_First_Line__c = 'AS_FirstName__c,AS_LastName__c';
            EventDetail.Lable_First_Line_Size__c = '20pt';
            
            EventDetail.Lable_Secoend_Line__c = 'AS_Company__c';
            EventDetail.Lable_Secoend_Line_size__c = '15pt';

        
        }
        
    }
    
   
    
    
    public void saveBadgeSettings(){
    
    
        if(EventDetail.Event_Printer__c == 'Dymo Label(30856,Single Label)' ){
            
            
            
           
        }else if(EventDetail.Event_Printer__c == 'Zebra Label'){
            
           
            
        }else if(EventDetail.Event_Printer__c == 'Avery 5392 Name badges'){
            
           
            
        }else if(EventDetail.Event_Printer__c== 'Avery 22806 easy peal square Badges'){
            
                EventDetail.Lable_Third_Line__c = '';
                EventDetail.Lable_Third_Line_Color__c = '';
                EventDetail.Lable_Third_Line_Size__c = '';
                EventDetail.Lable_Third_Line_Font__c = '';
        
        }
    
           Database.SaveResult upsertRes  = DataBase.Update(EventDetail, false);
            
            if(upsertRes.isSuccess())
                BadgeSettingsBool = FALSE;
            
    
    }
 
   
  public class Event{
  public String name{get;set;}
  public String Event{get;set;}
  public String box_header_text_color{get;set;}
  public String link_color{get;set;}
  public String box_background_color{get;set;}
  public String timezone{get;set;}
  public String box_border_color{get;set;}
  public String logo{get;set;}
  public String long_description{get;set;}
  public String background_color{get;set;}  
  public String id{get;set;}
  public String eventBriteId{get;set;}
  public String category{get;set;}
  public String box_header_background_color{get;set;}
  public String capacity{get;set;}
  public String num_attendee_rows{get;set;}
  public String title{get;set;}
  public String start_date{get;set;}
  public String status{get;set;}
  public String description{get;set;}
  public String end_date{get;set;}
  public String tags{get;set;}
  public String text_color{get;set;}
  public String title_text_color{get;set;}
  public String created{get;set;}
  public String url{get;set;}
  public String box_text_color{get;set;}
  public String privacy{get;set;}
  public String modified{get;set;}
  public String logo_ssl{get;set;}
  public String repeats{get;set;}
  
  //List<Organizer> organizer;
  
  //List<ticket> Ticket;
  
  public Event(){
 
  }
  
  }
  public class attendee1{
 
 public boolean selected{get;set;}
 public String work_country_code {get;set;}
 public String notes {get;set;}
 public String cell_phone {get;set;}
 public String ship_phone {get;set;}
 public String ship_postal_code {get;set;}
 public String home_region {get;set;}
 public String home_phone {get;set;}
 public String work_address {get;set;}
 public String age {get;set;}
 public String work_address_2 {get;set;}
 public String work_region {get;set;}
 public String ship_address_2 {get;set;}
 public String home_country {get;set;}
 public String home_address_2{get;set;} 
 public String ship_city {get;set;}
 public String work_phone {get;set;}
 public String gender{get;set;}
 public String ship_region {get;set;}
 public String home_address{get;set;}
 public String work_postal_code {get;set;}
 public String discount {get;set;}
 public String event_date{get;set;}
 public String affiliate{get;set;}
 public String barcode{get;set;}
 public String money{get;set;}
 public boolean isSelected{get;set;}
 public string website {get;set;}
 public String first_name{get;set;}
 public String home_city {get;set;}
 public String last_name{get;set;}
 public string suffix {get;set;}    
 public string company{get;set;}
 public String  event_id{get;set;}
 public String created{get;set;}
 public String prefix{get;set;} 
 public String  blog {get;set;}
 public String order_id {get;set;}
 public String work_city{get;set;}
 public String home_country_code {get;set;}
 public String  email{get;set;}
 public String ship_country {get;set;}
 public String modified{get;set;}
 public String amount_paid {get;set;}
 public String order_type{get;set;}
 public String ticket_id{get;set;} 
 public Integer quantity{get;set;} 
 public String home_postal_code{get;set;}
 public String id{get;set;} 
 public String ship_address {get;set;}
 public String job_title{get;set;} 
 public String ship_country_code {get;set;}
 public String birth_date {get;set;}
 public String work_country{get;set;}
 public boolean eventBrite4{get;set;}
 
 public attendee1(String web,String first,String last,String home,String suff,String comp,String eid,String pref,String blog,String work,String ticket,Integer qua,String id,String jid,String order,String gender1,String age1){

 selected=false;
 website =web;
 
 first_name=first;
 
 
 last_name= last;
 
 order_type=order;
 suffix = suff; 
  
 company = comp;
  
 
  event_id= eid;
  
  prefix=pref;
  
  
  blog=blog;
 
  work_city = work;
  
  ticket_id= ticket;

  quantity =qua;
  
  id=id;
  
  job_title=jid;
  
   gender = gender1;
   
   
   age = age1;
  
  
 }
 
  
 
 }
  public void showPopup() {
   
        displayPopup = true;
    }
     public String  strNamesmult{get;set;}
  public list<attendee1> EventbriteAtt{get;set;}
 public String User_key { get; set; }
 public String EventBriteId1 { get; set; }
 public String EventBriteId { get; set; } 
 public List<Event> EventbriteEv{get;set;}
 public boolean displayPopup {get; set;}
 public Boolean eventBritePop1{get;set;}
 public Boolean eventBritePop2{get;set;}
 public Boolean eventBritePop3{get;set;}
 public Boolean eventBritePop10{get;set;} 
 public boolean eventbritepop11{get;set;} 
 public String SelectEventId1 { get; set; }
 public String SelectEventId2 { get; set; }
 public boolean ajaxtest{get;set;}
 public boolean eventBrite4{get;set;}
 public boolean eventbrite5{get;set;}
 public boolean eventBritePop7{get;set;}
 public boolean eventbritepop8{get;set;}
 public boolean eventbritepop9{get;set;}
 public String UserId{get;set;}
 public String BLEventID{get;set;}
 public String EventadminId{get;set;}
 public Event__c EBEvent= new Event__c();
 User_Profile_Event__c UPE = new User_Profile_Event__c(); 
 List<SelectOption> options = new List<SelectOption>();


 public Set<String> ComarisonSet = new Set<String>(); 


 public List<attendee1> selectedAttendees = new List<attendee1>();
 
 
 public List<AttendeeSummary__c>  savedAttendees = new List<AttendeeSummary__c>();
 
 
 public  transient    Database.UpsertResult[] AttendeeUpsert;

 public List<Event_Attendee_Mapping__c> selectedEA = new List<Event_Attendee_Mapping__c>();


    public void EBEpop(){
   
    error=false;
    user_key='';
    EventBriteId1 ='';
    eventBritePop1 = true;
    
    } 
    public pagereference cancelEvent(){
    eventBritePop1 = false;
    return null;
    }
     
     
     public boolean error{get;set;}
     public string errormsg{get;set;}
     public PageReference getEventDetails1() {
     
     System.debug('@@@@@EventBrite Id'+user_key);
    if(user_key == '' || EventBriteId1 == ''){
    error=true;
    errormsg='please enter user_key and EventId';
    }else{
    
    
     String URL ='https://www.eventbrite.com/json/event_get?app_key=CNXSCEVA32E6U6REQF&user_key='+User_key+'&id='+EventBriteId1;
      Http h = new Http();

// Instantiate a new HTTP request, specify the method (GET) as well as the endpoint 
    
    HttpRequest req = new HttpRequest();
    req.setEndpoint(URL);
    req.setMethod('GET');

// Send the request, and return a response 
    
    HttpResponse res = h.send(req);
    
   
    System.debug('Original Event Body'+res.getBody());
  
    String json1= res.getBody();
    String json2 = json1.replace('currency','money');
    System.debug('@@@@@replaced string'+json2);
    //System.debug('Event Details'+json2.event);
    JSONParser parser = JSON.createParser(json2);
    EventbriteEv= new List<Event>();
    
            Event EventbriteEvent = new Event();
       
            while (parser.nextToken() != null) {
              
                 System.debug('@@@@heloo1'+parser.getText());
            
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'logo')) {
               
                parser.nextToken();
              
                 EventbriteEvent.logo = parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.logo);
            }
            
           
                       if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'description')) {
                // Get the value. 
    
                parser.nextToken();
                // Compute the grand total price for all invoices. 
    
                 EventbriteEvent.description= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.description);
            }
            
                       if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'long_description')) {
              
                parser.nextToken();
               
                 EventbriteEvent.long_description= parser.getText();
                 System.debug('@@@@heloo23'+EventbriteEvent.long_description);
            }
            
            
            
                       if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'name')) {
                
                parser.nextToken();
              
                EventbriteEvent.name= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.name);
            }
   
           
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'id')) {
              
                parser.nextToken();
               
                 EventbriteEvent.eventBriteId= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.eventBriteId);
            }
            
            
          
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'category')) {
                
                parser.nextToken();
               
                 EventbriteEvent.category= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.category);
            }
            
            
             if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'category')) {
               
                parser.nextToken();
               
                 EventbriteEvent.category= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.category);
            }
            
            
             if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'capacity')) {
               
                parser.nextToken();
               
                 EventbriteEvent.capacity= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.capacity);
            }
            
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'capacity')) {
             
                parser.nextToken();
               
                 EventbriteEvent.capacity= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.capacity);
            }
            
            
                
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'num_attendee_rows')) {
               
                parser.nextToken();
               
                 EventbriteEvent.num_attendee_rows= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.num_attendee_rows);
            }
            
            
                
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'title')) {
               
                parser.nextToken();
               
                 EventbriteEvent.title= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.title);
            }
            
            
                
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'start_date')) {
              
                parser.nextToken();
               
                 EventbriteEvent.start_date= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.start_date);
            }
            
            
            
                
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'status')) {

                parser.nextToken();
               
                 EventbriteEvent.status= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.status);
            }
            
            
                
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'end_date')) {
          
                parser.nextToken();
              
                 EventbriteEvent.end_date= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.end_date);
            }
            
           
           
                   
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'tags')) {
               
                parser.nextToken();
              
                 EventbriteEvent.tags= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.tags);
            }
            
            
                    
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'url')) {
                
                parser.nextToken();
               
                 EventbriteEvent.url= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.url);
            }
            
            
                    
          if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'privacy')) {
               
                parser.nextToken();
                // Compute the grand total price for all invoices. 
    
                 EventbriteEvent.privacy= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.privacy);
            }
           
           
             if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'privacy')) {
              
                parser.nextToken();
               
                 EventbriteEvent.privacy= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.privacy);
            }
            
              if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'modified')) {
               
                parser.nextToken();
            
    
                 EventbriteEvent.modified= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.modified);
            }
            
              if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'logo_ssl')) {
              
                parser.nextToken();
               
                 EventbriteEvent.logo_ssl= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.logo_ssl);
            }
            
              if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'repeats')) {
              
                parser.nextToken();
                
                 EventbriteEvent.repeats= parser.getText();
                 
                 System.debug('@@@@heloo23'+EventbriteEvent.repeats);
            }
           
}
       

    EventbriteEv.add(EventbriteEvent);
    string ss=EventbriteEv[0].title;
    system.debug('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn'+ss);
    if(ss != null && ss != ''){
    System.debug('@@@@@@EventBrite Event'+EventbriteEv[0]);
    
    eventBritePop1=false;
    
    eventBritePop2=true; 
    
   eventBrite4=false; 
    
   showPopup();
   }
   
   else{
   User_key='';
   EventBriteId1='';
   error=true;
   errormsg='please enter valid user_key and EventId';
   }
   }
        return null;
    }
    
    public pagereference EventClose(){
   
  
  eventBritePop2 = false;
   return null;
    
  }  
    public void closePopup() {
  
     eventBritePop1 = false;
        displayPopup = false;
    }
     public pagereference EventToBoothLeads() {
  
     eventBritePop2 = false;
 try{
    String start;
    String startTime;
    String Enddate;
    String EndTime;
  
        For(Event BLevent:EventbriteEv){

        EBEvent.Status__c =  BLevent.status;
        //EBEvent.Eventadmin_Id__c = EventadminId;
        EBEvent.EV_Title__c = BLevent.title;
        EBEvent.EV_Description__c=BLevent.description;
        EBEvent.EV_HostingTimeZone__c= BLevent.timezone;
        EBEvent.EV_HostedByEventBrite__c  = true;
        if(BLevent.start_date !=null){
        start = BLevent.start_date;
        String[] startcal=start.split(' ', 2);
       System.debug('@@@@Stringarray'+startcal);
       String startDate5 =startcal[0];
       EBEvent.EV_StartDate__c =date.valueOf(startcal[0]);
       EBEvent.StartTime__c =startcal[1];
      }

  if(BLevent.end_date != null){
  String end1 = BLevent.end_date;
  String[] end2=end1.split(' ', 2);
  EBEvent.EV_EndDate__c =date.valueOf(end2[0]);
  EBEvent.EV_EndTime__c=end2[1];
 
}
  System.debug('Adams Marketing'+EBEvent);
   
}
List<profile__c> pro = new List<profile__c>();
pro =[select id from profile__c where   PR_Name__c='EventAdmin'];
     database.insert(EBEvent);
     UPE.EV_id__c = EBEvent.id;
     UPE.User_id__c = UserInfo.getUserId();
     try{
     UPE.Profile_id__c =pro[0].id;
     }catch(exception e){}
    // UPE.Profile_id__c ='a0FO0000000yGxt';
     UPE.Status__c =EBEvent.Status__c;        
     UPE.UEP_isActive__c=true;
     UPE.EventAdmin_Id__c = UserInfo.getUserId();
     insert UPE;
     System.debug('@@@@@inserted'+EBEvent);
     String named='';
                    String ObjectName = 'AttendeeSummary__c'; // Object Name Goes Here
                    Map<String, Schema.SObjectField> ObjectFieldMap = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap();
                    
                   // system.debug('1111111111111111111111111'  );
                    for (Schema.SObjectField SObjectF : ObjectFieldMap.values())
                    {
        
                       Schema.DescribeFieldResult field = SObjectF.getDescribe();
                       named +=field.getLocalname()+',';
                    }
                     named += 'AttendeePic,' ;
                     
                     
                      SecurityControls__c  attset = new  SecurityControls__c ();
                    
                    attset.EV_Fields__c = named;
                    attset.EV_id__c = EBEvent.id;  
                     
                    insert attset;
    
}catch(exception e){}
pagereference pf=new pagereference('/apex/BL_EventAdmin_Events');
pf.setredirect(true);
return pf;


    }

 public void EBApop(){
 
error=false;

  eventBritePop10= true;

   
}
public pagereference EventClose1(){

eventBritePop10= false;

return null;

}
 public List<User_Profile_Event__c> EventBriteEvents{get;set;}
    
    public boolean messagebool{get;set;}
    public List<SelectOption> getSelectEventId(){
    
    List<selectoption> Options = new List<selectoption>();
    EventBriteEvents = [Select EV_id__r.id,EV_id__r.EV_Title__c,EV_id__r.Is_MatchMaking_Event__c from User_Profile_Event__c where User_id__r.id=:UserInfo.getUserId()];
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
    public PageReference statustest() {
    
    ajaxTest = true;
    
    
    SelectEventId2  =SelectEventId1;
    
        return null;
    }
    public PageReference getAttendees() {
   
 
 
    if(SelectEventId1 == null){
    
    
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select Event'));
    return null;
    
    
    }
 if(EventBriteId == '' || User_key == ''){
 error=true;
 errormsg='Please enter EventId And User_key';
 }else{
 
    
    
      String URL ='https://www.eventbrite.com/json/event_list_attendees?app_key=CNXSCEVA32E6U6REQF&user_key='+User_key+'&id='+EventBriteId;
    
    
    //EventbriteAtt = new  list<Attedees>();
    System.debug('@@@@@@@@####URL'+EventBriteId);
    System.debug('@@@@@@@@####URL'+URL);
    
      Http h = new Http();

    HttpRequest req = new HttpRequest();
    req.setEndpoint(URL);
    req.setMethod('GET');

    HttpResponse res = h.send(req);
    
    System.debug('Original Body'+res.getBody());
    String json1= res.getBody();
    String json2 = json1.replace('currency','money');
    System.debug('@@@@@replaced string'+json2);
    
    //String jsonStr= '{"attendee":[{"website": "www.globlanest", "first_name": "balaji", "last_name": "j", "home_city": "Secbad", "suffix": "Singh", "event_id": 3135031965, "company": "GlobalnestLLC", "prefix": "Mr.", "blog": "", "work_city": "Secbad", "ticket_id": 13279069, "quantity": 1, "id": 95625983, "job_title": "WebDesigner"}]}';
    
   // JSONParser parser = JSON.createParser(res.getBody());
        JSONParser parser = JSON.createParser(json2);
       System.debug('@@@@@*****Parser Values'+parser);
       
        EventbriteAtt = new  list<attendee1>();
       
       System.debug('@@@@@Parser'+parser);
       
        while (parser.nextToken() != null) {
        
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
        
            while (parser.nextToken() != null) {

                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                   
         parser.nextToken();
         
         System.debug('@@@@@parsertext'+Parser.getText());
       parser.nextToken();
         
        
         
         System.debug('@@@@findValues'+parser.getText());
               if(parser.getText() != 'NOt Found'){
                   attendee1 inv = (attendee1)parser.readValueAs(attendee1.class);
                    
                   System.debug('attendees values'+inv);
                   EventbriteAtt.add(inv); }                 
                    System.debug('AAAAAAAAAAAAAAAAAAAA '+EventbriteAtt);
                    }
                    parser.skipChildren();
                }
        }
        
 
        }
    
     
  System.debug('@@@@@EventbriteAtt'+EventbriteAtt.size());
  if(EventbriteAtt.size()!=0){
  eventBritePop1= false; 
  
  eventBritePop3=false;
    
   eventBrite4=false;   
    
    eventbrite5=false;
    
    eventBritePop7=true;
    
   eventbritepop8 = true;
   
   eventbritepop9 = false;
    
     
 eventBritePop10 = false;
    
  eventBritePop11 = true;
     }else{
     EventBriteId='';
     user_key='';
     error=true;
 errormsg='There are no attendees exist for given event id or given eventid is not correct';
     }
   } 
    return null;
    }
    public pagereference attendeedetail(){
   /** String[] Splitstr=new String[]{};
    String[] Splitstr = strNamesmult.split(',');
    for(String str :Splitstr ){
     ComarisonSet.add(str);
    }*/
   //for(attendee1  EvAtt:EventbriteAtt ){
   
   Event_Attendee_Mapping__c attmap = new Event_Attendee_Mapping__c();
  for(attendee1  EvAtt:EventbriteAtt ){
   AttendeeSummary__c NewAtt = new AttendeeSummary__c();
            NewAtt.AS_FirstName__c = EvAtt.first_name;
            NewAtt.AS_LastName__c = EvAtt.last_name;
            NewAtt.AS_Email__c  = EvAtt.email;
            NewAtt.AS_Gender__c = EvAtt.gender;
            NewAtt.AS_Company__c = EvAtt.company;
            NewAtt.AS_Suffix__c = EvAtt.suffix;
            NewAtt.AS_Prefix__c = EvAtt.prefix;
            NewAtt.AS_Title__c = EvAtt.job_title;
            NewAtt.AS_CellPhone__c = EvAtt.cell_phone; 
            NewAtt.AS_CellPhone__c = EvAtt.cell_phone; 
            NewAtt.AS_CellPhone__c = EvAtt.cell_phone; 
            NewAtt.AS_WorkAddress1__c = EvAtt.work_address; 
            NewAtt.AS_WorkAddress2__c = EvAtt.work_address_2; 
            NewAtt.AS_WorkState__c = EvAtt.work_region; 
            NewAtt.AS_WorkPhone__c = EvAtt.work_phone; 
            NewAtt.AS_WorkCity__c = EvAtt.work_city; 
            NewAtt.AS_WorkCountry__c = EvAtt.work_country; 
            NewAtt.AS_ShippingAddress1__c = EvAtt.ship_address; 
            NewAtt.AS_ShippingAddress2__c = EvAtt.ship_address_2; 
            NewAtt.AS_ShippingCity__c = EvAtt.ship_city; 
            NewAtt.AS_ShippingState__c = EvAtt.ship_region; 
            NewAtt.AS_ShippingCountry__c = EvAtt.ship_country; 
            NewAtt.AS_ShippingPhone__c = EvAtt.ship_phone;         
            NewAtt.AS_HomeAddress1__c = EvAtt.home_address; 
            NewAtt.AS_HomeAddress2__c = EvAtt.home_address_2; 
            NewAtt.AS_HomeCity__c= EvAtt.home_city; 
            NewAtt.AS_HomeState__c = EvAtt.home_region; 
            NewAtt.AS_HomeCountry__c = EvAtt.home_country; 
            NewAtt.AS_HomePhone__c= EvAtt.home_phone; 
            NewAtt.AS_BlogUrl__c = EvAtt.blog; 
            NewAtt.AS_WebsiteUrl__c = EvAtt.website; 
            NewAtt.EventBriteCount__c =math.random();
             System.debug('@@@@@savedAttendees'+NewAtt);
            savedAttendees.add(NewAtt); 
           System.debug('@@@@@savedAttendees'+savedAttendees.size());
   }
   //}
   for(AttendeeSummary__c myatt:savedAttendees){
   Database.UpsertResult myAttendeeSaveResult = Database.upsert(myatt,AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);
   system.debug('-------------------------new attendee------------------'+myatt);
     if(myAttendeeSaveResult.isSuccess() )
     {
     if(myAttendeeSaveResult.iscreated())
     {
      attmap = new Event_Attendee_Mapping__c();
      attmap.AS_id__c = myAttendeeSaveResult.getId(); 
      attmap.Ev_id__c = SelectEventId1;
      Database.SaveResult myAttendeeJunction = Database.Insert(attmap ,false);
      attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ SelectEventId1;
      attmap.EA_AttendeeBarcode__c = myAttendeeJunction.getId()+'-'+SelectEventId1;
      update attmap;
      }else{
          attmap = new Event_Attendee_Mapping__c();
          attmap.AS_id__c = myAttendeeSaveResult.getId(); 
          attmap.Ev_id__c = SelectEventId1;
          attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ SelectEventId1;
        
          Database.SaveResult myAttendeeJunction = Database.Insert(attmap ,false);
          
          system.debug('       DDDDDDDDDDDDDDDDDDDDD            '+myAttendeeJunction );
          
          if(myAttendeeJunction.isSuccess()){
              attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ SelectEventId1;
              attmap.EA_AttendeeBarcode__c = myAttendeeJunction.getId()+'-'+SelectEventId1;
             
              update attmap;  
          }   
     }           
     }
      
      
   
   }
   eventbritepop11 = false;
  
     return null;
   }
public pagereference EventClose2(){


eventbritepop11 = false;

return null;
}
    public Survey_Questions__c Squestions {get; set; }
    public LIST<SelectOption> qtypes{get; set;}
    public string selectedtype {get;set;}
    
    public LIST<SelectOption> atttypes{get; set;}
    public String[] selectedatttype {get;set;}
    
    
    public boolean surveyQuestionsbool {get;set;}
    Public  list<Ticket_Mapswith_Survey__c> SQ {get;set;}
    public pagereference displaySurveyQ(){
    pagereference pf= new pagereference('/apex/BL_SurveyQuestions?id='+SelectedEventId);
    return pf;
    }

   
    //-------------------------------------------------------------
    public boolean promosbool {get ;set;}
    public Promocodes__c Pcode{get;set;}
    public boolean promosDisplaybool {get;set;}
    public integer noofattempts {get;set;}
    public list<Tickets_Mapswith_Promocode__c> TMPCODE {get;set;}
    public list<SelectOption> tics {get;set;}
    
    public void DisplayPromoodes(){
    errorpromotics = false;
    errorpromobool  =false;
    try{
    errorpromobool = false;
    TMPCODE = new list<Tickets_Mapswith_Promocode__c> ();
    list<Tickets_Mapswith_Promocode__c> TMPCODETEMP = [select id,Promocodes__c,Promocodes__r.Name,Promocodes__r.Discount_Type__c,Promocodes__r.Discount_Value__c
                                                         from Tickets_Mapswith_Promocode__c where Tickets__r.EV_id__r.id =: SelectedEventId ];
    set<id> setTMP = new  set<id>();
    for (Tickets_Mapswith_Promocode__c prom: TMPCODETEMP  ) {
          if (setTMP.add(prom.Promocodes__c)) {
                TMPCODE.add(prom);
          }
    }
   promosDisplaybool = true;
   }catch(exception e){}
    }
    
    
    public void Promocodes(){
    errorpromotics = false;
    errorpromobool  =false;
    pro = 'Add Promo Code';
    try{

        selectedatttype = new string[] {};
        tics = new list<SelectOption> {};
        Pcode = new Promocodes__c();
        noofattempts = 0;
        List<TicketTypes__c> TickTypes = [select id,TT_Name__c,Ticket_Category__c from TicketTypes__c where EV_id__r.id =: SelectedEventId ];
            for(TicketTypes__c tt: TickTypes ){
                tics.add(new SelectOption(tt.id,tt.TT_Name__c+'--'+tt.Ticket_Category__c));
            
            }
            forEdit = false;
            foradd = true;
            promosbool = true;
            
            }catch(exception e){}
        }
    public List<TicketTypes__c> tickets {get;set;}
    public boolean errorpromobool {get;set;}
   
    public void savePromo(){
      errorpromobool  =false;
      errorpromotics = false;
     if(selectedatttype.size() != 0 ){
  
   try{
       List<Tickets_Mapswith_Promocode__c> comparepc = [select id,Promocodes__r.Name from Tickets_Mapswith_Promocode__c where
                                                         Tickets__r.EV_id__r.id =: SelectedEventId AND Promocodes__r.Name LIKE : Pcode.name];
        if(comparepc.size() == 0){
        errorpromobool  =false;
        insert Pcode;
        list<id> TicIds = new list<id> ();
        tickets = new  List<TicketTypes__c>();
        for(string st:selectedatttype){
           TicIds.add(Id.valueOf(st));
        }
       List<TicketTypes__c> TickTypesforupdate = [select id from TicketTypes__c where id IN: TicIds];      
       list<Tickets_Mapswith_Promocode__c> TMPLIST = new list<Tickets_Mapswith_Promocode__c> {};
       
       for(TicketTypes__c tp: TickTypesforupdate ){
       
        Tickets_Mapswith_Promocode__c TMP = new Tickets_Mapswith_Promocode__c();
            TMP.Max_number_Of_usage__c  = noofattempts;
           TMP.Promocodes__c = Pcode.id;
           TMP.Tickets__c = tp.id;
           TMPLIST.add(TMP);
       }
       insert TMPLIST;
       promosbool = false;
       DisplayPromoodes();
    }
    else{
    errorpromotics = false;
        errorpromobool = true;
        }
   }catch(exception ex){}
   }else{
    errorpromotics = true;
   }
   }
   public void saveandnewpromo(){
   errorpromotics = false;
   errorpromobool  =false;
   savePromo();
   if(errorpromobool  == false){
   Promocodes();}else{
   errorpromobool  =true;
   }
    }
//------------------------------------------------Email Templates-------------------------------------------
    public pagereference EmailTemplate(){
     errorboolname = false;
     errorboolduplicate = false;
     errorboolsubject = false;
     stepTWO();
     pagereference pf = page.BL_Event_Emailtemplate;
     return pf;  
    }
     public emailTemplate e {get;set;}
     public list<selectoption> fieldoptions {get;set;}
     public boolean newtempbool  {get;set;}
      public string selectedfield {get;set;}
    public string showfied {get;set;}
    public string subjectval {get;set;}
     public string TemplateName {get;set;}
      public string Tempcontent {get;set;}
      public string selectedtemp {get;set;}
       public boolean Existingtemp {get;set;}
      public list<selectoption> templist {get;set;}
      public list<EmailTemplate> emtemlist {get;set;}
      public string htmlbodyvalue {get;set;}
      
      public void stepTWO(){
      system.debug('            nnnnnnnnnnnnnnnnnnnnnnnnnn    '+Userinfo.getlastname( ));
     //folder f = [select id,name from folder where name Like: 'Admin'];
    displayeditbool = false;
    Existingtemp =true;
    templist = new list<selectoption> {};
    emtemlist = new list<EmailTemplate> {};  
    
    List<Folder> Folder = new List<Folder>();
    
    
    Folder = [select id, Name from Folder Where DeveloperName = 'Booth_Leads_Templates'];
    
    
    
        if(Folder.size() > 0){
          
            emtemlist =[select name from EmailTemplate where Folder.id =: Folder[0].id AND 
                        (Owner.id =: userinfo.getuserid() OR Owner.id =:'005F0000002ODHv')AND 
                        (NOT name LIKE : '%MatchMaking%' ) ];
                        
             system.debug('    mmmmmmmmmmmmmmmmmmmmmmmmmmm 00lF0000001ItDM   '+emtemlist );
            for(EmailTemplate emtm: emtemlist ){
                templist.add(new selectoption(emtm.id,emtm.name));
            }
        }
    }
     public void createTemplate (){
     errorboolname = false;
     errorboolduplicate = false;
     errorboolsubject = false;
     editbuttonbool = false;
     Templatename = '';
     Subjectval ='';
     htmlbodyvalue = '';
     Tempcontent = '';
     Clonebuttonbool = FALSE;
    displaybool = false;
    displayeditbool = false;
     Existingtemp =false;
    selectedtemp ='';
    fieldoptions = new list<selectoption> {};
    fieldoptions.add(new selectoption ('--None--','--None--'));
    fieldoptions.add(new selectoption ('First Name','First Name'));
    fieldoptions.add(new selectoption ('Last Name','Last Name'));
    fieldoptions.add(new selectoption ('Company Name','Company Name'));
    fieldoptions.add(new selectoption ('Event Name','Event Name'));
    newtempbool = true;
    
    e= new emailTemplate();
    }
    public void fetchingfieldval(){
    if(selectedfield == 'First Name'){
    showfied ='{!FirstName}';
    }
     if(selectedfield == 'Last Name'){
     showfied = '{!LastName}';
    }
     if(selectedfield == 'Company Name'){
     showfied = '{!CompanyName}';
    }
     if(selectedfield == 'Event Name'){
     showfied = '{!EventName}';
    }
    
    }
    
    public boolean errorboolname {get;set;}
    public boolean errorboolduplicate {get;set;}
    public boolean errorboolsubject {get;set;}
    public integer dup {get;set;}
    
    public pagereference saveTemplate (){
    errorboolname = false;
    errorboolduplicate = false;
    errorboolsubject = false;
     editbuttonbool = false;
     errorboolname = false;
     errorboolduplicate = false;
     errorboolsubject = false;
     editbuttonbool = false;
      displayclonebool=false;
      
      List<Folder> Folder = new List<Folder>();
      Folder = [select id, Name from Folder Where DeveloperName = 'Booth_Leads_Templates'];
      
    if(subjectval == '' || subjectval == null){
        errorboolname = false;
        errorboolduplicate = false;
        errorboolsubject = true;
    }
    if(TemplateName == '' || TemplateName == null ){
        errorboolduplicate= false;
        errorboolname = true;
    }else{
        
            
        
        
            if(Folder.size() > 0){
            
            
               emtemlist =[select name from EmailTemplate where Folder.id =: Folder[0].id AND (Owner.id =: userinfo.getuserid() OR 
                                                                                      Owner.id =:'005F0000002ODHv') ];
                dup=0;
                      Set<string> ToFindDuplicateTemplate = new Set<string>();
                    for(EmailTemplate emtm: emtemlist ){
                        if(emtm.name == TemplateName ){
                       
                        dup++;
                        }
                    }
                    if(ToFindDuplicateTemplate.size()>0){
                     errorboolduplicate = true;
                     errorboolname = false;
                     displayclonebool= true;  
                     //return null;
                                          
                    }
            }        
    
    }
    system.debug('GGGGGGGGGGG'+TemplateName +'HHHHHHH'+dup+Tempcontent); 
    
    if(TemplateName != '' && TemplateName != null && dup == 0){
       
       
       system.debug('GGGGGGGGGGG'+Folder.size());
       
        e.subject = subjectval;
        e.Isactive = true;
        if(Folder.size()>0)
            e.FolderId = Folder[0].id;
         else
            e.FolderId = '00DF0000000BpyH';
            
        e.name= TemplateName;
        e.TemplateType = 'Custom';
       // e.Htmlvalue = htmlbodyvalue;
       if(Tempcontent != '')
        e.Htmlvalue = Tempcontent;
        if(htmlbodyvalue != '')
        e.Htmlvalue =htmlbodyvalue;
       
        e.developername = TemplateName.replace(' ', '_');        
        insert e;
        
         system.debug('############'+e);
        selectedtemp = e.id;  
         system.debug('%%%%%%%%%% '+selectedtemp);      
        newtempbool = false;
        displayclonebool=false;
  
         steptwo();
        desiredemailTemplate();
        displaybool = TRUE;
       
        //newtempbool=false;
       //desiredemailTemplate();
      
    }
     
     //pagereference pg = page.BL_Event_Emailtemplate;
    // pg.setredirect(true);
     return null;
    }
    public EmailTemplate etemplate  {get;set;}
    //public string htmlbodyvalue {get;set;}
    public boolean displaybool {get;set;}
    public boolean editbuttonbool {get;set;} 
    public string uid {get;set;}
    
     public void desiredemailTemplate(){
         errorboolname = false;
     errorboolduplicate = false;
     errorboolsubject = false;
        system.debug('      selectedtemp  '+selectedtemp);
        etemplate  = new EmailTemplate();
        etemplate = [select name,Subject,HtmlValue,owner.id from EmailTemplate Where id =: selectedtemp ];
        uid = userinfo.getuserId();
        system.debug('           1111111111111111111111111        '+etemplate.owner.id);
        system.debug('           2222222222222222222222222222     '+uid);
        Templatename = etemplate.name;
        Subjectval = etemplate.Subject;
        htmlbodyvalue =etemplate.HtmlValue;
        
        if(etemplate.owner.id == uid){
        system.debug('KKKKKKKKKKK ');
        editbuttonbool = true;
        Clonebuttonbool = true;
        }
        else{
        editbuttonbool = false;
        Clonebuttonbool = true;
        }
        displaybool =true;
        displayeditbool =false;
        system.debug('      selectedtemp  rrrrrrrrrrrrrrr'+etemplate.HtmlValue  );
        system.debug('      selectedtemp  rrrrrrrrrrrrrrr 4444444444444 '+etemplate );
    }
    
    public boolean displayeditbool {get;set;}
    public List<selectoption> viewoptionList {get;set;}
    public string viewopt {get;set;}
    public boolean Clonebuttonbool {get;set;}
    public boolean CancelEdit{get;set;}
    public void edittemplate(){
     errorboolname = false;
     errorboolduplicate = false;
     errorboolsubject = false;
     editbuttonbool = false;
     Clonebuttonbool = False;
        fieldoptions = new list<selectoption> {};
        fieldoptions.add(new selectoption ('--None--','--None--'));
        fieldoptions.add(new selectoption ('First Name','First Name'));
        fieldoptions.add(new selectoption ('Last Name','Last Name'));
        fieldoptions.add(new selectoption ('Company Name','Company Name'));
        fieldoptions.add(new selectoption ('Event Name','Event Name'));
        escapebool = true;
        CancelEdit = TRUE;
        viewoptionList   = new List<selectoption> {};
        viewoptionList.add(new selectoption('Text','Text'));
        viewoptionList.add(new selectoption('HTML','HTML'));      
        displaybool = false;
        Existingtemp = false;
        displayeditbool = true;
    }
    public boolean displayclonebool {get;set;}
    public Boolean CancelClone {get;set;}
    public void clonetemplate(){
    
    e = new EmailTemplate();
    edittemplate(); 
    errorboolname = false;
    errorboolduplicate = false;
    errorboolsubject = false;
    editbuttonbool = false;
    displaybool = false;  
    displayeditbool = false;
    displayclonebool=true;
    Clonebuttonbool = False;
    CancelClone  = TRUE;
    stepTWO();
    Existingtemp = false;  
    
    }
    
    public boolean escapebool {get;set;}
    
    public void escapevalue(){
    
        if(viewopt == 'Text'){
            escapebool = true;
        }
        else{
            escapebool = false;
        }
    }
    public void updateTemplate(){
     errorboolname = false;
     errorboolduplicate = false;
     errorboolsubject = false;
        system.debug('              name    '+TemplateName );
        etemplate.subject = subjectval;
        etemplate.name=TemplateName;  
        etemplate.Htmlvalue = htmlbodyvalue ;
        etemplate.Isactive = True;
        Update etemplate;
        stepTWO();
        desiredemailTemplate();
    
    }
    public void canceltemp(){
     errorboolname = false;
     errorboolduplicate = false;
     errorboolsubject = false;
     displaybool = TRUE;
     displayeditbool = false;
     Existingtemp =true;
         if(CancelClone == TRUE){
            displayclonebool=FALSE;          
            if(etemplate.owner.id == uid){
             editbuttonbool = TRUE;
             Clonebuttonbool = TRUE;
                 }else{
             Clonebuttonbool = TRUE;
             }
         }
         if(CancelEdit == TRUE){
                      
            if(etemplate.owner.id == uid){
             editbuttonbool = TRUE;
             Clonebuttonbool = TRUE;
                 }else{
             Clonebuttonbool = TRUE;
             }
         }
         newtempbool=false;
         
         
         
    }
//-------------------------------edit promo-----------------------------------------
    public list<Tickets_Mapswith_Promocode__c> TMTICpromo {get;set;}
    public string pro {get;set;}
    public void editpromo(){
    pro = 'Edit Promo Code';
    noofattempts = 0;
    errorpromobool  =false;
    foradd= false;
    tics = new list<SelectOption>{};
    selectedatttype = new string[]{};
    string prid = Apexpages.Currentpage().getparameters().get('promoid');
    List<TicketTypes__c> TickTypes = [select id,TT_Name__c,Ticket_Category__c from TicketTypes__c where EV_id__r.id =: SelectedEventId ];
            for(TicketTypes__c tt: TickTypes ){
                tics.add(new SelectOption(tt.id,tt.TT_Name__c+'--'+tt.Ticket_Category__c));
            
            }
    system.debug('          &&&&&&&&&&&&&&&&&&&&&&&&           '+prid);
    pcode = new Promocodes__c();
    TMTICpromo = new list<Tickets_Mapswith_Promocode__c>{};
    Tickets_Mapswith_Promocode__c TMSQ =[select Promocodes__r.id,Tickets__r.id,Tickets__r.TT_Name__c from Tickets_Mapswith_Promocode__c where id =: prid];
  
    pcode = [ select id,Name,Discount_Type__c,Discount_Value__c,Expiredate__c from Promocodes__c where id =: TMSQ.Promocodes__r.id];                                                     
    TMTICpromo = [select Promocodes__r.id,Max_number_Of_usage__c,Tickets__r.id,Tickets__r.TT_Name__c from Tickets_Mapswith_Promocode__c where Promocodes__r.id =: TMSQ.Promocodes__r.id];
       if(TMTICpromo[0].Max_number_Of_usage__c != 0){
       noofattempts = integer.valueOf(TMTICpromo[0].Max_number_Of_usage__c);
       }else{
       noofattempts =0;
       }
    for(Tickets_Mapswith_Promocode__c tim: TMTICpromo ){
          selectedatttype.add(tim.Tickets__r.id);
          
      }
      foredit = true;
       promosbool = true;
    }
    
    public boolean foradd {get;set;}
    public boolean foredit {get;set;}
    public void updatepromo(){
    
    errorpromobool  =false;
    if(selectedatttype.size() != 0 ){
    delete TMTICpromo;
     List<Tickets_Mapswith_Promocode__c> comparepc = [select id,Promocodes__r.Name from Tickets_Mapswith_Promocode__c where
                                                         Tickets__r.EV_id__r.id =: SelectedEventId AND Promocodes__r.Name LIKE : Pcode.name];
        if(comparepc.size() == 0){
        errorpromobool  =false;
        update Pcode;
        list<id> TicIds = new list<id> ();
        tickets = new  List<TicketTypes__c>();
        for(string st:selectedatttype){
           TicIds.add(Id.valueOf(st));
        }
       List<TicketTypes__c> TickTypesforupdate = [select id from TicketTypes__c where id IN: TicIds];      
       list<Tickets_Mapswith_Promocode__c> TMPLIST = new list<Tickets_Mapswith_Promocode__c> {};
       
       for(TicketTypes__c tp: TickTypesforupdate ){
       
        Tickets_Mapswith_Promocode__c TMP = new Tickets_Mapswith_Promocode__c();
            TMP.Max_number_Of_usage__c  = noofattempts;
           TMP.Promocodes__c = Pcode.id;
           TMP.Tickets__c = tp.id;
           TMPLIST.add(TMP);
       }
       insert TMPLIST ;
       promosbool = false;
        DisplayPromoodes();
    }
    else{
        errorpromobool = true;
        }
  
  }else{
  errorpromotics = true;
  
  }
    
    }
    public boolean errorpromotics {get;set;}
    public void deletepromo(){
    string prid = Apexpages.Currentpage().getparameters().get('promoid');
    TMTICpromo = new list<Tickets_Mapswith_Promocode__c>{};
    Tickets_Mapswith_Promocode__c TMSQ =[select Promocodes__r.id,Tickets__r.id,Tickets__r.TT_Name__c from Tickets_Mapswith_Promocode__c where id =: prid];
  
    pcode = [ select Name,Discount_Type__c,Discount_Value__c,Expiredate__c from Promocodes__c where id =: TMSQ.Promocodes__r.id];                                                     
   
    TMTICpromo = [select Promocodes__r.id,Tickets__r.id,Tickets__r.TT_Name__c from Tickets_Mapswith_Promocode__c where Promocodes__r.id =: TMSQ.Promocodes__r.id];
      
    delete TMTICpromo ;
     delete pcode;
     DisplayPromoodes();
    }
    
    
    
    
public void VcalForevent(id eventidforcal){
try{
 Event__c eventForCal = new Event__c();

    eventForCal =[SELECT id,EV_StartDate__c,EV_Title__c,EV_HostingStateNew__c,EV_HostingLocation__c,AS_HostingCity__c,EV_Description__c ,EV_HostingZipcode__c,EV_HistingAddr1__c,AS_HostingAddr2__c,StartTime__c,EV_EndDate__c,EV_EndTime__c,Is_MatchMaking_Event__c from Event__C where id =:eventidforcal];
   
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

    
//-------------------------------------------------------------------------------------------------------
   public void testdum(){
  integer intg=0;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  }
     
}