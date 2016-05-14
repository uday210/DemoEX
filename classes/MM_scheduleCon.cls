public without sharing class MM_scheduleCon {

    
public EventSchedule__c viewCommentsobj{get;set;}
public boolean viewcommentsbool{get;set;}
public pagereference pdfpage{get;set;}
public blob b{get;set;}
public integer mx_numberapp{get;set;}
public string comments{get;set;}
public string schedulestartTime{get;set;}
public string scheduleendTime{get;set;}
public string scheduledate{get;set;}
public boolean dispaySuccessPopup21 {get;set;}
public string textMessage {get;set;}
public EventSchedule__c shedule{get;set;}
public  List<EventSchedule__c> listes{get;set;}
public boolean dispaySuccessPopup {get;set;}
public boolean vieProfileBool { get; set; }
public List<selectOption> options {get;set;}
public string selectedEvent{get;set;}
public EventSchedule__c eveshedule {get;set;}
public boolean displaySchedule {get;set;}
public List<string> FinalDaytwoTimings {get;set;}
public List<string> FinalDayoneTimings{get;set;}
public string dayone{get;set;}
public string daytwo{get;set;}
public Event__c eventtimedetails {get;set;}
public string scheduleddays1{get;set;} 
public string scheduleddays2{get;set;} 
public AttendeeSummary__c vewProfileEAM { get; set; }
public AttendeeSummary__c exbitorSummary{get;set;}
public List<addendDateclass> dateInn{get;set;}
public List<addendDateclass> dateInn2{get;set;}
public List<EventSchedule__c> exibitors {get;set;}    
public string CancelOrRejected{get;set;}


public List<EventSchedule__c> exibitorsPendingAppointments {get;set;}    
public List<EventSchedule__c> exibitorsRejected {get;set;}  
public List<EventSchedule__c>  exibitorscancelled {get;set;}
public List<EventSchedule__c>  exibitorMissedapp {get;set;}
public EventSchedule__c esc{get;set;}
public LIST<EventSchedule__c> attendeeslist{get;set;}
public LIST<EventSchedule__c> attendeeslistexport{get;set;}
public SET<EventSchedule__c> attendeesset{get;set;}
//public LIST<AttendeeInner> attendeelist{get;set;}
public LIST<EventSchedule__c> bn{get;set;}
//public MAP<String, AttendeeInner> mapAttendees = new MAP<String, AttendeeInner>();   
public MAP<string,User_Profile_Event__c> mapEmailwithUpeId1{get;set;}        
 public list<Attachment> attchments {get; set;}
 public Event__c evdetails {get ; set ;}       
 public list<Tags__c> tagslist {get; set ;}
 public string attendeealias {get ; set ;}
 public string exhibitoralias {get ; set ;}
  public Event__c attach{get;set;}
public Profile_Settings__c psett{get;set;}
public Profile_Settings__c esetting{set;get;}
// Survey Questions Variable
public MM_Surevycon surveyController{get;set;}

public List<ConfirmedAppmnts> conApps{get; set;}



public MM_scheduleCon(){
      attendeealias ='';
      exhibitoralias ='';
options = new List<selectOption>();
 List<id> events = new List<id>();
   attchments = new List<Attachment>();
   mapEmailwithUpeId1 = new MAP<string,User_Profile_Event__c>();
    cookie counter =   ApexPages.currentPage().getCookies().get('counter');
  selectedEvent=counter.getValue();
  evdetails = new Event__c();
  evdetails = [Select id,Email_Notifications_flag__c,(SELECT MAX_noOf_appontments__c FROM MatchLeads_Days__r ) from Event__c Where id =: selectedEvent];  
  for(User_Profile_Event__c upe:[select EV_id__c,EV_id__r.EV_Title__c,EV_id__r.id from User_Profile_Event__c where User_id__c=:userInfo.getUserid() and IsMatchMakingUser__c=true order by createddate desc]){
    options.add(new selectOption(upe.EV_id__r.id ,upe.EV_id__r.EV_Title__c));
    events.add(upe.EV_id__r.id);
  }
  mx_numberapp=integer.valueof(evdetails.MatchLeads_Days__r[0].MAX_noOf_appontments__c);

  
 Psettings = new List<Profile_Settings__c> ();
   
    Psettings = [SELECT id,DBA__c,Website__c,exceptional_keywords__c,BBB_Number__c,Contact_Image__c,Company_Logo__c,Additional_Company_videos__c,Additional_Company_Brouchers__c,
                        Location__c,Country__c,Primary_Business_Category__c,Secondary_Business_Category__c,Distributors_Country__c,Commodities__c,
                        Manufatures_Country__c,Geographical_Region__c,Certificate_Processed_by_RPO__c,Business_Description__c,Company_Name__c,References__c,Corporate_Table_Room_No_Visible__c,
                        Title__c,Mobile__c,Email_Id__c,First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,Work_Address__c,Work_phone__c,Business_Established_Date__c,Corporate_Company_Visible__c,Corporate_First_Name_Visible__c,Corporate_Work_Address_Visible__c,Corporate_Website_Registration_Link_Vi__c


                     FROM Profile_Settings__c WHERE Event__r.id =: SelectedEvent AND Name=: 'Corporate'];
                     
     attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c,EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c from Event__c where id = : selectedEvent];   
                          
                         esetting= new Profile_Settings__c ();             
 esetting= [select MBE_Company_Visible__c,MBE_First_Name_Visible__c,Event__r.id,Small_Business_IMAGE__c from Profile_Settings__c where Event__r.id =: SelectedEvent AND Name=: 'MBE'];
 try{
 showShedules();
 }catch(exception e){}
 
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


MAP<Id,EventSchedule__c> MAPidandEschedule {get;set;}


public void showShedules(){
MAPidandEschedule  = new MAP<Id,EventSchedule__c>();
eventtimedetails = new Event__c();
exibitors = new List<EventSchedule__c>();
exibitorsPendingAppointments = new List<EventSchedule__c>();
exibitorsRejected = new List<EventSchedule__c>();
exibitorscancelled = new List<EventSchedule__c>();
exibitorMissedapp = new List<EventSchedule__c>();

conApps = new List<ConfirmedAppmnts>();

 for(User_Profile_Event__c UPE : [Select BT_id__r.BT_Location__c,BT_id__r.MM_TableNo__c,User_id__r.userName,id,EV_id__c,User_id__c,Profile_id__c,Status__c,IsMatchMakingUser__c from User_Profile_Event__c  where IsMatchMakingUser__c=true and EV_id__r.id=:selectedEvent ]){
    mapEmailwithUpeId1.put(UPE.User_id__r.userName,UPE);
  }
 

exibitors =[select MM_To_EAM__r.AS_id__r.As_Email__c,MM_To_EAM__c,Comments__c,MM_slot_Date__c,MM_Slot_End_Time__c , EV_id__r.EV_HostingTimeZone__c, Owner.Email ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c 
from EventSchedule__c where MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName() AND MM_To_UPE__c != null and MM_To_UPE__r.EV_id__c =:selectedEvent and MM_Slot_Status__c='Accepted' and MM_slot_Date__c!=null order by starttimein24hrs__c];
system.debug('exibitors === '+exibitors );
/* */
for(EventSchedule__c es: exibitors ){
     /* */
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
    /* */
    system.debug('conApps === '+conApps);
}
/* */




exibitorsPendingAppointments =[select MM_To_EAM__r.AS_id__r.As_Email__c,Comments__c,MM_slot_Date__c,Owner.Email ,MM_Slot_End_Time__c ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c
from EventSchedule__c where MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName() AND MM_To_UPE__c != null and MM_To_UPE__r.EV_id__c =:selectedEvent and MM_Slot_Status__c='Pending' and MM_slot_Date__c!=null order by starttimein24hrs__c];
 
  
exibitorsRejected =[select  MM_To_EAM__r.AS_id__r.As_Email__c,MM_To_EAM__c,Comments__c,MM_slot_Date__c,MM_Slot_End_Time__c ,Owner.Email ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c
from EventSchedule__c where MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName() AND MM_To_UPE__c != null and MM_To_UPE__r.EV_id__c =:selectedEvent and MM_Slot_Status__c='Rejected' and MM_slot_Date__c!=null order by starttimein24hrs__c];
 
 
exibitorscancelled =[select  MM_To_EAM__r.AS_id__r.As_Email__c,MM_To_EAM__c,Comments__c,MM_slot_Date__c,MM_Slot_End_Time__c ,Owner.Email ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c 
from EventSchedule__c where MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName() AND MM_To_UPE__c != null and MM_To_UPE__r.EV_id__c =:selectedEvent and MM_Slot_Status__c='Cancelled' and MM_slot_Date__c!=null order by starttimein24hrs__c];
 
 
 
 
exibitorMissedapp = [select MM_To_EAM__r.AS_id__r.As_Email__c,MM_To_EAM__c,Comments__c,MM_slot_Date__c,MM_Slot_End_Time__c ,Owner.Email ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c
from EventSchedule__c where MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName() AND MM_To_UPE__c != null and MM_To_UPE__r.EV_id__c =:selectedEvent and MM_Slot_Status__c='Missed' and MM_slot_Date__c!=null order by starttimein24hrs__c];
 
 
 eventtimedetails =[select MatchMaking_Type__c,BreakTime_Between_Appointments__c,Owner.Email , MM_Slot_Timeperiod__c,MM_Start_Date__c,MM_End_Date__c,
                                          MM_End_Time__c,MM_Firstaday_EndTime__c,MM_Firstaday_startTime__c,MM_Secondaday_EndTime__c,
                                          MM_Secondaday_startTime__c,Match_Making_Schedules__c  from Event__c where id =:selectedEvent ];
  
  
  
 
  CancelOrRejected =''; 
  
  for(EventSchedule__c  eS:[select Comments__c,MM_slot_Date__c,MM_Slot_End_Time__c ,Owner.Email ,MM_slot_StartTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,starttimein24hrs__c
   from EventSchedule__c where MM_To_EAM__r.AS_id__r.As_Email__c =:userInfo.getUserName() AND MM_To_UPE__c != null and MM_To_UPE__r.EV_id__c =:selectedEvent and (MM_Slot_Status__c='Pending' OR MM_Slot_Status__c='Accepted')  and MM_slot_Date__c!=null order by starttimein24hrs__c]){
     CancelOrRejected +=eS.MM_To_UPE__c;
   }
    
  
  
  
 SET<EventSchedule__c> setOfevents = new  SET<EventSchedule__c>();
 setOfevents.addAll(exibitors);
 setOfevents.addAll(exibitorsPendingAppointments );
 
 setOfevents.addAll(exibitorsRejected );
 setOfevents.addAll(exibitorscancelled );
 setOfevents.addAll(exibitorMissedapp );
 // For displaying reshedule button in cancelled or rejected appointments
  
  
  for(EventSchedule__c ede :setOfevents){
    MAPidandEschedule.put(ede.id,ede);  
  } 
}

    public Boolean scheduleswithprof {get;set;}
    public Event__c Eventdetails {get ; set ;}
    public LIST<MBESchedules> MatchLeadsschedules{get; set;}
    public void commonmethod(){
    try{
       // attendeeslist = new LIST<Event_Attendee_Mapping__c>();
        LIST<Event_Attendee_Mapping__c> MBEUsers = new LIST<Event_Attendee_Mapping__c>();
        Eventdetails  = new Event__c();
        Eventdetails  = [SELECT ID, Name,EV_Title__c,Status__c,EV_HostingState__c,AS_HostingCity__c,EV_HostingLocation__c,Attendee_Types__c,
                    EV_HistingAddr1__c,AS_HostingAddr2__c,EV_HostingCountryNew__c,EV_Publish__c,EV_EventLogo__c,EV_HostingTimeZone__c,
                    EV_HostingPhone__c,EV_HostingFax__c,EV_WebsiteURL__c,Primary__c,SecondaryCategory__c,EV_HostingOrgName__c,EV_HostingStateNew__c,
                    EV_HostingZipcode__c,EV_HostingPostalCode__c,EV_HostedByEventBrite__c,EV_Description__c,Owner.FirstName,Owner.ID,
                    EV_EndTime__c, StartTime__c, EV_EndDate__c, EV_StartDate__c,EventDiversityValues__c,TwitterHashTag__c,
                    Lable_First_Line__c,Lable_Secoend_Line__c,Lable_Third_Line__c,Event_Printer__c,TwitterId__c,FacebookId__c,OrganizerId__c,
                    Lable_First_Line_Color__c,Lable_First_Line_Size__c,Lable_First_Line_Font__c,Lable_Secoend_Line_Color__c,Lable_Secoend_Line_Size__c,Lable_Secoend_Line_Font__c,
                    Lable_Third_Line_Color__c,Lable_Third_Line_Size__c,EV_SiteLocation__c,Lable_Third_Line_Font__c FROM Event__C WHERE id =:selectedEvent ];
           
       MBEUsers = [Select u.AS_id__r.As_Email__c,u.AS_id__r.FullName__c,u.AS_id__r.Exhibitor_company_imageUrl__c, u.AS_id__r.AS_Company__c,u.AS_id__r.AS_WorkPhone__c,u.EV_id__c,u.MBE_Profile__r.FullName__c,u.MBE_Profile__r.AS_Email__c,u.MBE_Profile__r.AS_Company__c,
                          u.EV_id__r.EV_Title__c,  u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HistingAddr1__c,u.MBE_Profile__r.AS_FirstName__c,u.MBE_Profile__r.AS_LastName__c,u.MBE_Profile__r.AS_WorkPhone__c,
                         u.EV_id__r.AS_HostingCity__c, u.EV_id__r.EV_HostingState__c, u.EV_id__r.EV_HostingZipcode__c ,u.EV_id__r.EV_EventLogo__c,u.EV_id__r.Is_Webank_event__c,u.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                    (SELECT Id,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,Comments__c,Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.BT_Name__c,
                                    MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,
                                    MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email ,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c ,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,
                                    MM_To_EAM__r.DiversityType__c,MM_To_EAM__r.AS_id__r.Exhibitor_company_imageUrl__c,EV_id__r.EV_EventLogo__c,MM_To_UPE__r.BT_id__r.BT_Location__c,MM_To_UPE__r.Attendee_Summary__r.FullName__c,
                                     MM_To_UPE__r.Attendee_Summary__r.As_prefixNew__c,MM_To_UPE__r.Attendee_Summary__r.AS_Title__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkAddress1__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkAddress2__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkCity__c,MM_To_UPE__r.Attendee_Summary__r.AS_Work_States__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkZip__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_WebsiteUrl__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_1__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_2__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_3__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_4__c,MM_To_UPE__r.Attendee_Summary__r.As_NAICSCode_5__c,MM_To_UPE__r.Attendee_Summary__r.Keywords__c,
                                    MM_To_UPE__r.Attendee_Summary__r.AS_BusinessDescription__c,MM_To_UPE__r.Attendee_Summary__r.AS_BusinessDunsNumber__c,MM_To_UPE__r.Attendee_Summary__r.AS_BusinessEstablishedDate__c,MM_To_UPE__r.Attendee_Summary__r.AS_BusinessRevenue__c,MM_To_UPE__r.Attendee_Summary__r.AS_BusinessTaxId__c,MM_To_UPE__r.Attendee_Summary__r.AS_CageCode__c,MM_To_UPE__r.Attendee_Summary__r.AS_NumberOfEmployees__c,MM_To_UPE__r.Attendee_Summary__r.Company_Certifications__c,MM_To_UPE__r.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,MM_To_UPE__r.Attendee_Summary__r.As_SecondaryBusinessCategory1__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exceptional_Key_Words__c,
                                    MM_To_UPE__r.Attendee_Summary__r.DBA__c,MM_To_UPE__r.Attendee_Summary__r.BBB_Number__c,MM_To_UPE__r.Attendee_Summary__r.distribution_Country__c,MM_To_UPE__r.Attendee_Summary__r.Manufactures_Country__c,MM_To_UPE__r.Attendee_Summary__r.Geographical_Region__c,MM_To_UPE__r.Attendee_Summary__r.References__c,
                                    MM_To_UPE__r.Attendee_Summary__r.AS_NAICSCode6__c,MM_To_UPE__r.Attendee_Summary__r.AS_NAICSCode7__c,MM_To_UPE__r.Attendee_Summary__r.AS_NAICSCode8__c,MM_To_UPE__r.Attendee_Summary__r.AS_NAICSCode9__c,
                                    MM_To_UPE__r.Attendee_Summary__r.Commodity_1__c,MM_To_UPE__r.Attendee_Summary__r.Commodity_2__c,MM_To_UPE__r.Attendee_Summary__r.Commodity_3__c,MM_To_UPE__r.Attendee_Summary__r.Commodity_4__c,MM_To_UPE__r.Attendee_Summary__r.Commodity_5__c,MM_To_UPE__r.Attendee_Summary__r.Certificate_Processed_by_RPO__c
                                    FROM  EventSchedule__r e WHERE e.MM_Slot_Status__c='Accepted' ORDER BY e.MM_slot_Date__c, e.MM_slot_StartTime__c )
                                    From Event_Attendee_Mapping__c u WHERE Boothleads_Profile__c=:'Attendee' AND IsMatchMakingAttendee__c=:True AND Ev_id__c =: selectedEvent 
                                    AND AS_id__r.As_Email__c =:userInfo.getUserName()];
                                      
                            system.debug('11111111111111111111111'+ MBEUsers[0].AS_id__r.As_Email__c);
       
       MAP<Date , LIST<String>> getSlotsFromUtility = MM_Utility.giveEventTimingsWithDates(selectedEvent ,null);
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
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Schedule.pdf');
        }catch(exception ex){}
    
    }
    
    
    public pagereference PrintAttendeeSchedule(){
    
    commonmethod();
    //scheduleswithprof = false; 
        pagereference pg =page.AttendeeSchedulePDF;
        return pg;
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
    
    
    public PageReference PrintattendeeSchedulewithprofiles() {
    system.debug('llllllll');
    
        commonmethod();
        
        
        // system.debug('jjjjjjjjjjjjjjjjj '+ attendeelist.size()); 
        //scheduleswithprof = True;
       //system.debug('ggggggggggggggg '+ scheduleswithprof);
      
        pagereference pg =page.AttendeeSchedulePDF2;
        system.debug('hhhhhhhhhhhhhhhhh '+ pg);
        return pg;
        
    }
    
    
    public PageReference ExportAttendeeSchedule() {
    try{
        attendeeslistexport = new LIST<EventSchedule__c>();
        attendeeslist = new LIST<EventSchedule__c>();
        attendeesset  = new SET<EventSchedule__c>();
        attendeeslistexport = [SELECT Id,Comments__c,Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_WebsiteUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkAddress1__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkCity__c,MM_To_UPE__r.Attendee_Summary__r.AS_Work_States__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkZip__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,MM_To_EAM__r.AS_id__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c,MM_To_EAM__r.AS_id__r.AS_WorkZip__c      
                          FROM  EventSchedule__c 
                          WHERE Is_Matchmaking__c = TRUE 
                          AND EV_id__c =: selectedEvent 
                          AND MM_To_EAM__r.AS_id__r.As_Email__c =: userInfo.getUserName() 
                          AND MM_To_UPE__c != null 
                          AND MM_slot_StartTime__c!=null 
                          AND (MM_Slot_Status__c='Pending' OR MM_Slot_Status__c='Accepted')
                          ORDER BY MM_slot_StartTime__c,MM_Slot_Status__c];
    
     bn = new list<EventSchedule__c>();
     for(EventSchedule__c s: attendeeslistexport)
     {   
      s.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_WebsiteUrl__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_WebsiteUrl__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_WorkAddress1__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_WorkAddress1__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_WorkCity__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_WorkCity__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_Work_States__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_Work_States__c);
      s.MM_To_UPE__r.Attendee_Summary__r.AS_WorkZip__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_WorkZip__c);
      s.MM_To_EAM__r.AS_id__r.AS_FirstName__c = escape(s.MM_To_EAM__r.AS_id__r.AS_FirstName__c);
      s.MM_To_EAM__r.AS_id__r.AS_LastName__c = escape(s.MM_To_EAM__r.AS_id__r.AS_LastName__c);
      s.MM_To_EAM__r.AS_id__r.AS_Company__c = escape(s.MM_To_EAM__r.AS_id__r.AS_Company__c); 
      bn.add(s);      
     }   
     attendeeslist.addAll(bn);    
     system.debug('&&&&&& '+ attendeeslist.size());    
      }catch(exception ex){}             
     pagereference pg = page.AttendeeScheduleExport;
     return pg;                    
    }
    
     // -------------------------------------------------- Escape Special Characters -----------------------------------------------
    public string escape(string s){
        if(s != null && s.contains(',')){  
            s=s.replaceAll(',','');
        } 
        return s;
    }  



public MAP<string,EventSchedule__c> mapone {get;set;} 
public MAP<string,EventSchedule__c> maptwo {get;set;} 
public map<date,list<string>> slotmap {get;set;}
public List<maptimeWithEvesc> maptimeList{get;set;}
public MAP<string,EventSchedule__c>  mapStrWithES{get;set;}
public list<Event_Breaks__c> blokslistexist {get ; set ;}
public string listvals {get ; set ;}
public string listvalsmbe {get ; set ;}
 public PageReference ReSheduleTicket() {
  
  string  selectedEmail = Apexpages.currentpage().getParameters().get('selectedEmail');
    exbitorSummary = new AttendeeSummary__c ();
    Commanforstates cst = new Commanforstates ();
    GlobalAttendee Gatt = new GlobalAttendee ();
    exbitorSummary=Gatt.ReturnAttendee(selectedEmail);
    exbitorSummary.AS_Work_States__c=cst.mapstate(exbitorSummary.AS_Work_States__c);
     
  mapStrWithES =new MAP<string,EventSchedule__c>(); 
  eveshedule = new EventSchedule__c();
  eveshedule =[select Comments__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,id,MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName from EventSchedule__c where id=:Apexpages.currentPage().getParameters().get('reshedule')];
  system.debug('4444444444 '+eveshedule );
  
  string email =eveshedule.MM_To_UPE__r.User_id__r.userName;
  
  SET<Date> eventDates  = new SET<Date>();
      
         string eamidmbe ='';
      for(EventSchedule__c evd:[SELECT MM_To_EAM__r.id,MM_To_EAM__r.AS_Id__r.AS_Email__c,MM_To_EAM__r.AS_Id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.BT_Name__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and MM_To_EAM__r.AS_id__r.AS_Email__c=:userInfo.getUserName() and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)]){
        mapStrWithES.put(evd.MM_slot_Date__c+evd.MM_slot_StartTime__c+'-'+evd.MM_Slot_End_Time__c,evd);
               }
     List<EventSchedule__c> evd1 = [SELECT MM_To_EAM__r.id,MM_To_EAM__r.AS_Id__r.AS_Email__c,MM_To_EAM__r.AS_Id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.BT_id__r.BT_Name__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and MM_To_EAM__r.AS_id__r.AS_Email__c=:userInfo.getUserName() and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)];
     eamidmbe = evd1[0].MM_To_EAM__r.id;

    
        for(EventSchedule__c eventShedules:[SELECT MM_To_EAM__r.AS_Id__r.AS_Email__c,MM_To_EAM__r.AS_Id__r.AS_Company__c,id,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and  MM_To_UPE__r.User_id__r.UserNAme=:selectedEmail and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null)]){
            mapStrWithES.put(eventShedules.MM_slot_Date__c+eventShedules.MM_slot_StartTime__c+'-'+eventShedules.MM_Slot_End_Time__c,eventShedules);
            
        }
    
    
       MAP<date,integer> mapDateWithMaxapp = new MAP<date,integer>();
         for(aggregateResult arr :[SELECT count(id) numid,MM_slot_Date__c Name from EventSchedule__c where EV_id__c=:selectedEvent and Is_Matchmaking__c=true and  MM_To_EAM__r.AS_id__r.AS_Email__c=:userInfo.getUserName() and (MM_Slot_Status__c ='Pending' OR MM_Slot_Status__c ='Accepted') and (MM_slot_StartTime__c!=null and MM_Slot_End_Time__c!=null) group by MM_slot_Date__c]){
           
           integer  Quantity = (Integer) arr.get('numid');
            date dt= (date) arr.get('Name');
            mapDateWithMaxapp.put(dt,Quantity );
        
        }
      
      system.debug('BBBBBBBBBBBBBBBBBBBBB '+mapDateWithMaxapp);
    
    
       dateInn = new List<addendDateclass>();
        
       for(MatchLeads_Days__c EvDays:[select id,Break_Time_between_slots__c,End_Time__c,Event__c,MatchLeads_Date__c,MAX_noOf_appontments__c,Slot_Time_period__c,Start_time__c from MatchLeads_Days__c where Event__c=:selectedEvent]){
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
                User_Profile_Event__c upeid = [select id from User_Profile_Event__c where User_id__r.UserNAme=:email AND EV_id__c =:selectedEvent AND IsMatchMakingUser__c =: true ];
                blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: upeid.id];
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
     displaySchedule  =true;
    system.debug('CCCCCCCCCCCCCCC '+dateInn);
     
     
  return null;
  }




    /* Added By Rajesh Kumar to update Schedule to Missed Status - 15-06-2015 */
    public PageReference UpdateAppmntToMissed(){
        textMessage = '';
        string cancelTicket = ApexPages.currentPage().getPArameters().get('cancel');
        shedule = new EventSchedule__c();
        textMessage = 'Cancel';
        shedule=[select MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_Slot_Time__c,comments__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_Slot_EndTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name 
                 from EventSchedule__c 
                 where id =:Apexpages.currentPage().getParameters().get('missedApp')];   
        
        system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiiii '+shedule.MM_Slot_EndTime__c);
        
        
        shedule.MM_Slot_Status__c='Missed';
        dispaySuccessPopup =true;
        return null;
    }
    /* Added By Rajesh Kumar to update Schedule to Missed Status - 15-06-2015 */

     public class maptimeWithEvesc{
            public string slottime{get;set;}
            public EventSchedule__c slotName{get;set;}
            public maptimeWithEvesc(string xs,EventSchedule__c xd){
             this.slottime = xs;
             this.slotName =xd;
            }
            
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


   


    public PageReference cancelTicket() {
     textMessage = '';
    string cancelTicket = ApexPages.currentPage().getPArameters().get('cancel');
    shedule = new EventSchedule__c();
    textMessage = 'Cancel';
    shedule=[select MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_Slot_Time__c,comments__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_Slot_EndTime__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name 
             from EventSchedule__c 
             where id =: cancelTicket];   
    system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiiii '+shedule.MM_Slot_EndTime__c);
     
     
     shedule.MM_Slot_Status__c='Cancelled';
     dispaySuccessPopup =true;
     return null;
    }

    
    public PageReference acceptTicket() {
    textMessage = '';
    string cancelTicket = ApexPages.currentPage().getPArameters().get('cancel');
    shedule = new EventSchedule__c();
    shedule=[select MM_slot_Date__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_Slot_Time__c,MM_Slot_EndTime__c,comments__c , MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name from EventSchedule__c where id=:cancelTicket];
     
    shedule.MM_Slot_Status__c='Accepted';
    textMessage = 'Accept';
    dispaySuccessPopup =true;
   

     return null; 
    }


   public PageReference rejectTicket() {
   textMessage = '';
    string cancelTicket = ApexPages.currentPage().getPArameters().get('cancel');
    shedule = new EventSchedule__c();
    shedule=[select MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_Slot_Time__c,MM_Slot_EndTime__c,comments__c ,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_To_UPE__c,MM_To_UPE__r.User_id__r.userName,MM_To_UPE__r.User_id__r.Name from EventSchedule__c where id=:cancelTicket];
    shedule.MM_Slot_Status__c='Rejected';
        textMessage = 'Reject';
     dispaySuccessPopup =true;
   
    return null;
    }




   public PageReference ClosePopup() {
   displaySchedule =false;
   blockschedulebool = false;
   return null;
  }

public boolean dispaySuccessPopupsc {get;set;}
 public PageReference Schedules() {
     
     List<EventSchedule__c> ESList = new List<EventSchedule__c>();
     ESList =[SELECT id,MM_To_UPE__c,EV_id__c,MM_To_EAM__c from EventSchedule__c  where (id !=:eveshedule.id and EV_id__c=:selectedEvent and MM_To_UPE__r.User_id__r.userName=:eveshedule.MM_To_UPE__r.User_id__r.userName and MM_To_EAM__r.AS_id__r.AS_Email__c=:userInfo.getUserName()) and (MM_Slot_Status__c='Pending' or MM_Slot_Status__c='Accepted') ];
     
      string[] strtimeValue = new string[]{};
      strtimeValue  = (Apexpages.currentpage().getParameters().get('timeValue')).split('-');
      schedulestartTime =strtimeValue[0];
      scheduleendTime =strtimeValue[1];
      scheduledate=Apexpages.currentpage().getParameters().get('dateValue');
      system.debug('3333333333333333333 '+Apexpages.currentpage().getParameters().get('timeValue'));
      
      
     comments=eveshedule.comments__c;
      if(ESList.size()<=0 ){
      dispaySuccessPopupsc =true;
      }else{
       dispaySuccessPopup21=true;
      }
       return null;
    }
    
  public PageReference updateCommentsc() {
    
     EventSchedule__c eveshedule1 = new EventSchedule__c();
     eveshedule1 =eveshedule;
     
      eveshedule1.MM_slot_Date__c =date.parse(scheduledate);
     eveshedule1.MM_slot_StartTime__c =schedulestartTime;
            
    if(eventtimedetails.MatchMaking_Type__c=='Open' || eventtimedetails.MatchMaking_Type__c=='Closed'){
     eveshedule1.MM_Slot_Status__c ='Accepted';
    }else  if(eventtimedetails.MatchMaking_Type__c=='Semi Open'){
     eveshedule1.MM_Slot_Status__c ='Pending';
      eveshedule1.ownerId=userInfo.getuserId();
    }  
      
    eveshedule1.MM_Slot_End_Time__c =scheduleendTime;
    dataBase.saveResult res = dataBase.update(eveshedule1,false);
     displaySchedule  =false;
     dispaySuccessPopupsc =false;
      showShedules();
        return null;
    }


    public PageReference CloseSuccessPopupsc() {
    dispaySuccessPopupsc =false;
        return null;
    }
   
    
     public PageReference updateComment() {
      dataBase.saveResult sc=dataBase.update(shedule);
     try{
      OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Jerilynn Clarke'];
      if(shedule.MM_Slot_Status__c == 'Accepted'){ 
        listes = new List<EventSchedule__c>();
        listes = [select Id,Comments__c,Is_Matchmaking__c, MM_slot_StartTime__c,MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_LastName__c ,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exceptional_Key_Words__c,
                                    MM_To_EAM__r.AS_id__r.AS_Company__c ,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,
                                    MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,                                   
                                    MM_To_EAM__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,Owner.Name, Owner.Email ,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c
                          FROM  EventSchedule__c 
                          WHERE Is_Matchmaking__c = TRUE 
                          AND EV_id__c =: selectedEvent 
                          AND MM_To_UPE__r.Attendee_Summary__r.AS_Email__c =: shedule.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c
                          AND MM_Slot_Status__c = 'Accepted'
                          ORDER BY MM_slot_StartTime__c,MM_Slot_Status__c];
                          system.debug('^^^^^^^ '+listes);
           
           
          pdfpage = page.MM_NEWMBESchedule;
          pdfpage.getParameters().put('Eventid',selectedEvent );       
          pdfpage.getParameters().put('sc',shedule.id); 
       // pdfpage = page.MM_MBESchedule;
        b = pdfpage.getContent(); 
        system.debug('&&&&&&&& '+b);
        
        Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
         if(owea.size() > 0 ) {
              email1.setOrgWideEmailAddressId(owea.get(0).Id);
         } 
         EmailTemplate E1 = new EmailTemplate();    
         E1 = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking MBE Schedule Confirmation Email'];                      
         String[] toAddresses1 = new String[]{shedule.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c}; 
         //String[] toAddresses1 = new String[]{'phani@globalnest.com'}; 
         email1.setToAddresses(toAddresses1);    
         String subject1 = E1.Subject;
         String ReplaceContactName1 = E1.HtmlValue;
         String replacedname1 = ReplaceContactName1.Replace('{!Name}',shedule.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + shedule.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c);
         email1.setSubject(subject1);    
         email1.setHtmlBody(replacedname1);     
          Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
         efa.setFileName('GNEMSDC Business Opportunity Expo Schedule.pdf');
         efa.setBody(b);
         email1.setFileAttachments(new Messaging.EmailFileAttachment[]{efa}); 
         if(evdetails.Email_Notifications_flag__c == True){ 
         Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email1});
         }
    }
    /**
    if(shedule.MM_Slot_Status__c == 'Cancelled'){ 
     Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
     if(owea.size() > 0 ) {
          email.setOrgWideEmailAddressId(owea.get(0).Id);
     } 
     EmailTemplate E = new EmailTemplate();    
     E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Cancellation Email to MBE'];                      
     String[] toAddresses = new String[]{shedule.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c};
     //String[] toAddresses = new String[]{'phani@globalnest.com'}; 
     email.setToAddresses(toAddresses);   
          
     String subject = E.Subject;
     String ReplaceCompanyName = E.HtmlValue;
     String ReplacedCompanyname = ReplaceCompanyName.Replace('{!CompanyName1}',shedule.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + shedule.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c);
     String ReplacedCompanyname1 = ReplacedCompanyname.Replace('{!CompanyName2}',shedule.MM_To_EAM__r.AS_id__r.AS_Company__c);
    
     email.setSubject(subject);    
     email.setHtmlBody(ReplacedCompanyname1);      
     Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
   */
    dispaySuccessPopup =false;
    displaySchedule  =false;
    showShedules();
   }catch(exception e){} 
    return null;
    }
      

  public PageReference CloseSuccessPopup() {
    dispaySuccessPopup =false;
    displaySchedule  =false;
        return null;
    }

   
    
public PageReference CloseviewPopup() {
    vieProfileBool =false;
        return null;
    }

 public   List<Widget__c> videos {get ; set ;}
  public User_Profile_Event__c upeforTable{get;set;}
  public List<Profile_Settings__c> Psettings {get ; set ;}
    public PageReference viewProfile() {
    Psettings = new List<Profile_Settings__c> ();
   psett=new Profile_Settings__c();
    Psettings = [SELECT id,DBA__c,Website__c,exceptional_keywords__c,BBB_Number__c,Contact_Image__c,Company_Logo__c,Additional_Company_videos__c,Additional_Company_Brouchers__c,
                        Location__c,Country__c,Primary_Business_Category__c,Secondary_Business_Category__c,Distributors_Country__c,Commodities__c,
                        Manufatures_Country__c,Geographical_Region__c,Certificate_Processed_by_RPO__c,Business_Description__c,Company_Name__c,
                        Title__c,Mobile__c,Email_Id__c,First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,Work_Address__c,Work_phone__c,Corporate_Company_Visible__c,Corporate_Table_Room_No_Visible__c
                     FROM Profile_Settings__c WHERE Event__r.id =: SelectedEvent AND Name=: 'Corporate'];
                      if(Psettings.size()>0){
                         psett=Psettings[0];
                         }
                     
    system.debug('pppppppppppppppppppppppppppppppppppppppppppppppppppppp'+Psettings[0]);
  
     string viewEmail = Apexpages.currentpage().getParameters().get('viewEmail');
     upeforTable = new User_Profile_Event__c();
     Commanforstates  gts = new Commanforstates ();
     
     upeforTable=mapEmailwithUpeId1.get(viewEmail );
     system.debug('33333333333333333333 '+upeforTable);
     vewProfileEAM = new AttendeeSummary__c ();
     
     GlobalAttendee Gatt = new GlobalAttendee ();
     
     vewProfileEAM=Gatt.ReturnAttendee(viewEmail);
     if(vewProfileEAM.AS_Work_States__c!=null){
        vewProfileEAM.AS_Work_States__c =gts.mapstate(vewProfileEAM.AS_Work_States__c);
     }
     attchments = new list<Attachment>();
     videos = new List<Widget__c>();
    attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:vewProfileEAM.Id];
    videos = [select id,YouTubeId_c__c From Widget__c WHERE AttendeeSummary__r.id =: vewProfileEAM.id ];
        system.debug('4444444444444444444 '+vewProfileEAM);
    vieProfileBool  =false;
    
        return null;
    }
    
  public PageReference viewcomments() {
      string  escid= Apexpages.currentpage().getParameters().get('escid');
      viewCommentsobj=new EventSchedule__c();
      viewCommentsobj=MAPidandEschedule.get(escid); 
      viewcommentsbool=true;
     return null;
    }

    public PageReference CloseSuccessPopupcomments() {
    viewcommentsbool=false;
    return null;
    }

  

    public PageReference CloseSuccessPopup21() {
    dispaySuccessPopup21 =false;
        return null;
    }
    
    public Pagereference CheckUser(){
       
       Pagereference pg = MM_Utility.checkLogInservice();
       
       return pg;
       
   }
  //------------------------------BLOCKING SCHEDULES
  
  public MAP<DATE,LIST<String>>  dateSlotsMAP {get; set ;}
    public list<string> timeListMap {get ; set ;}
    //public list<Event_Breaks__c> blokslistexist {get ; set ;}
    public list<EventSchedule__c> exhibitorschedule  {get ; set ;}
    public list<innercl> innlistscheduled {get;set;}
    public LIST<MatchLeads_Days__c> allEventDates {get ; set ;}
    public string blockselecteddate  {get ; set ;}
    public List<selectoption> eventDatesList {get ; set ;}
    public Event_Attendee_Mapping__c EAMS {get ; set ;}
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
         if(blockselecteddate == '' || blockselecteddate == null){
         blockselecteddate  = allEventDates[0].id;
         }
         }
         //system.debug('rrrrrrrrrrr::::::'+allEventDates[0].id);
              MatchLeads_Days__c mday =[select id,MatchLeads_Date__c FROM MatchLeads_Days__c WHERE id =: blockselecteddate ];
               string mmdate = '';
               mmdate  = mday.MatchLeads_Date__c.format();
          
                EAMS = [SELECT ID FROM Event_Attendee_Mapping__c WHERE (AS_id__r.AS_Email__c =: UserInfo.getUserName()) AND  EV_id__c =: selectedEvent ORDER BY createdDate];         
                exhibitorschedule =[SELECT Id ,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                               MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                               MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c  
                                        FROM EventSchedule__c 
                                        WHERE MM_To_UPE__c != null
                                        AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                        AND MM_To_EAM__c =: EAMS.id 
                                        AND MM_slot_Date__c =: date.Parse(mmdate)  
                                        AND MM_Slot_Status__c = 'Accepted'
                                        AND EV_id__c =: selectedEvent 
                                        ];
                   string eschslots = '';
                     for(EventSchedule__c esch : exhibitorschedule ){
                        eschslots += esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c+','; 
                     
                    }

                    blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__r.id =: EAMS.id AND MatchLeads_Days__c =: blockselecteddate ];
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
                    public boolean Blockschedulebool {get ; set ;}
                   public class innercl{
      
                        public boolean selected {get; set ;}
                        public string slot {get; set;}
                         public innercl(string dispslot,boolean bb){
                        
                                     selected = bb;
                                     slot = dispslot;
         
                             }
        
                    }
                    
                    public void Blockedaction(){
                    
                    blokslistexist = new list<Event_Breaks__c> ();
                    blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__r.id =: EAMS.id AND MatchLeads_Days__c =: blockselecteddate];
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
                    blockslot.Event_Attendee_Mapping__c  = EAMS.id;
                    blockslot.Break_Start_Time__c = divideslot[0];
                    blockslot.Break_End_Time__c = divideslot[1];
                    blockslot.MatchLeads_Days__c = blockselecteddate; 
                    blokslist.add(blockslot);
                 
                 system.debug('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbblock'+blokslist);
                 }
             insert blokslist;
 
                    }
                    
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
        
}