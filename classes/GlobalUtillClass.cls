global with sharing class GlobalUtillClass {


global class UserDetails{
      Id UserID;
      String FirstName;
      String LastName;
      String Company;
      String City;
      String State;
      String PhoneNo;
      String Email;
      String message;
      String error;
      string  dtime;
      String ImageUrl;
      String Country;
      string attendeeID;
      String Title;
      
         global UserDetails( String error1){
        error = error1;
     
        }
        
     
      global UserDetails(AttendeeSummary__c mbepro,string idOfattendee,string uid){
          attendeeID =idOfattendee;
           UserID =uid;
           FirstName = mbepro.AS_FirstName__c;
            LastName = mbepro.AS_LastName__c;
            Company = mbepro.AS_Company__c;
            Title = mbepro.AS_Title__c;
            City = mbepro.AS_WorkCity__c;
            State= mbepro.AS_Work_States__c;
            PhoneNo = mbepro.AS_WorkPhone__c;
            Email = mbepro.AS_Email__c;
            Country = mbepro.AS_Work_Country__c;
            dtime=string.valueOf(system.now());
         
          
         String orgId = UserInfo.getOrganizationId();
          String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
          if(mbepro.AS_ImageUrl__c!=''){
            ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+mbepro.AS_ImageUrl__c;   
         }
      }   
        
        
        
        
  global UserDetails(user u,string imgurl,string idOfattendee){
      String orgId = UserInfo.getOrganizationId();
       // UserID =uid;
      String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
      if(imgurl!=''){
      ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+imgurl;   
     }
        attendeeID =idOfattendee;
        UserID =u.id;
        FirstName = u.FirstName;
        LastName = u.LastName;
        Company = u.CompanyName;        
        City = u.City;
        State= u.States__c;
        PhoneNo = u.phone;
        Email = u.Email;
        Country = u.Country__c;
        dtime=string.valueOf(system.now());
        Title = u.Title;
        system.debug('9999999999999999999999 '+dtime);
        }
        
        
    global UserDetails(user u,string imgurl,string idOfattendee, string title){
      String orgId = UserInfo.getOrganizationId();
      String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
      if(imgurl!=''){
      ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+imgurl;   
     }
        attendeeID =idOfattendee;
        UserID =u.id;
        FirstName = u.FirstName;
        LastName = u.LastName;
        Company = u.CompanyName;        
        City = u.City;
        State= u.States__c;
        PhoneNo = u.phone;
        Email = u.Email;
        Country = u.Country__c;
        dtime=string.valueOf(system.now());
        this.Title =title;
        system.debug('9999999999999999999999 '+Title );
        } 
        
        
        
    global UserDetails(MBE_Profile__c mbepro){
      String orgId = UserInfo.getOrganizationId();
      String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
      
        if(mbepro.AS_ImageUrl__c!=''){
           ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+mbepro.AS_ImageUrl__c;   
         }
            attendeeID =mbepro.AttendeeSummary__c;
            FirstName = mbepro.AS_FirstName__c;
            LastName = mbepro.AS_LastName__c;
            Company = mbepro.AS_Company__c;
            Title = mbepro.AS_Title__c;
            City = mbepro.AS_WorkCity__c;
            State= mbepro.AS_Work_States__c;
            PhoneNo = mbepro.AS_WorkPhone__c;
            Email = mbepro.AS_Email__c;
            Country = mbepro.AS_Work_Country__c;
            dtime=string.valueOf(system.now());
            system.debug('9999999999999999999999 '+dtime);
        }
        
        
   

}

//------------------------------- Event details ----------------------------------------

    global  class EventDetails{
       Id Event_ID;
       String Event_Name;
       Date Event_StartDate;
       String Event_StartHour;
       String Event_EndHour;
       String Event_Location;
       String EventLogoImageURL;
        String WebsiteUrl;
       String Status;
       Date Event_Date;
       String Event_Description;
       String HostingAddr1;
       String HostingAddr2;
       String HostingCity;
       String HostingState;
       String HostingCountry;
       String HostingZipcode;
       String HostingPhone;
       String TwitterHashTag;
           
       
       
       
      global EventDetails(event__c eve)
      {
       
       Event_ID = eve.Id;
       Event_Name =eve.EV_Title__c;
       Event_StartDate = eve.EV_StartDate__c;
       Event_StartHour = eve.StartTime__c;
       Event_EndHour =eve.EV_EndTime__c;
       Event_Location = eve.EV_HostingLocation__c;
       Event_Date = eve.EV_EndDate__c;
       WebsiteUrl =eve.EV_WebsiteURL__c;
       
             
      String orgId = UserInfo.getOrganizationId();
      String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
      EventLogoImageURL=sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+eve.EV_EventLogo__c;  
       Status = eve.Status__c;
       Event_Description = eve.EV_Description__c;       
       HostingAddr1 = eve.EV_HistingAddr1__c;                    
       HostingAddr2 = eve.AS_HostingAddr2__c;                    
       HostingCity = eve.AS_HostingCity__c;                    
       HostingState = eve.EV_HostingStateNew__c;                    
       HostingCountry = eve.EV_HostingCountryNew__c ;                   
       HostingZipcode = eve.EV_HostingZipcode__c;
       HostingPhone = eve.EV_HostingPhone__c;
       TwitterHashTag =eve.TwitterHashTag__c;

                 
   }
 }  
 




/* KIOSK WEB SERVICES  */


  global  class KSKEventList{
       Id Event_ID;
       String Event_Name;
       Date Event_StartDate;
       Date Event_EndDate;
       String errMssg;
       
    global KSKEventList(event__c eve)
    {       
       Event_ID = eve.Id;
       Event_Name =eve.EV_Title__c;
       Event_StartDate = eve.EV_StartDate__c;       
       Event_EndDate = eve.EV_EndDate__c;               
     }
   
     global KSKEventList(String error)
     {       
       errMssg = error;           
     }
 } 
 
 
 
  global  class KSKEventDetails{
       Id Event_ID;
       String Event_Name;
       String Event_StartDate;
       String Event_StartHour;
       String Event_EndHour;
       String Event_Location;
       String EventLogoImageURL;
       String WebsiteUrl;
       String Status;
       String Event_Date;
       String Event_Description;
       String HostingAddr1;
       String HostingAddr2;
       String HostingCity;
       String HostingState;
       String HostingCountry;
       String HostingZipcode;
       String HostingPhone;
       String TwitterHashTag;      
       String FloorMap;
       String errMsg;
       
      global KSKEventDetails(event__c eve)
      {
       
       Event_ID = eve.Id;
       Event_Name =eve.EV_Title__c;       
       Event_StartDate = Datetime.newInstanceGmt(eve.EV_StartDate__c.year(), eve.EV_StartDate__c.Month(), eve.EV_StartDate__c.Day() ).format('MMMM dd, yyyy');
       
       Event_StartHour = eve.StartTime__c;
       Event_EndHour =eve.EV_EndTime__c;
       Event_Location = eve.EV_HostingLocation__c;      
       Event_Date = Datetime.newInstanceGmt(eve.EV_EndDate__c.year(), eve.EV_EndDate__c.Month(), eve.EV_EndDate__c.Day() ).format('MMMM dd, yyyy');
       WebsiteUrl =eve.EV_WebsiteURL__c;
        
        String orgId = UserInfo.getOrganizationId();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
       EventLogoImageURL=sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+eve.EV_EventLogo__c;  
       Status = eve.Status__c;
       Event_Description = eve.EV_Description__c;       
       HostingAddr1 = eve.EV_HistingAddr1__c;                    
       HostingAddr2 = eve.AS_HostingAddr2__c;                    
       HostingCity = eve.AS_HostingCity__c;                    
       HostingState = eve.EV_HostingStateNew__c;                    
       HostingCountry = eve.EV_HostingCountryNew__c ;                   
       HostingZipcode = eve.EV_HostingZipcode__c;
       HostingPhone = eve.EV_HostingPhone__c;
       TwitterHashTag =eve.TwitterHashTag__c;
       FloorMap = sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+eve.Floor_Map_Image__c;     
   }
   
   global KSKEventDetails(String err)
      {
          errMsg = err;
      } 
 } 


global class KSKKiosksList{
    String KisoskId;
    //String x;
    //String y;
    //String Width;
    //String Hieght;
    String coordinates;
    //String Area;
    
    global KSKKiosksList(Floor_Map__c fm){
        KisoskId = fm.Name;
        coordinates = fm.Parameters__c;
        //Area = fm.Booth_Area__c;
    }

}

global class KSKEventModules{
    String EventModule;
    
    global KSKEventModules(String moduls){
        EventModule = moduls;
    }

}

global class KSKEventSchedule{
        global string Message;
        global String ProgramName;
        global String Description;
        global  String Location;
        global String Presenter;
        global Date StartDate;
        global Date EndDate;
        global String StartTime;
        global String EndTime;
        global string eventName;
        global id id;
        global id eventId; 
        String FormatedStartDate;
        String FormatedEndDate;
              
        global KSKEventSchedule(EventSchedule__c eventSc){
        id =eventSc.id;
        eventId =eventSc.EV_id__c;
        ProgramName = eventSc.ES_ProgramName__c;
        Description = eventSc.ES_Description__c;
        Location  = eventSc.ES_Location__c;
        Presenter = eventSc.ES_Presenter__c; 
        StartDate = eventSc.ES_StartDate__c;
        EndDate  =   eventSc.ES_EndDate__c;
        StartTime =  eventSc.ES_StartTime__c;
        EndTime   =  eventSc.ES_EndTime__c;
        eventName = eventSc.EV_id__r.EV_Title__c;
        FormatedStartDate = Datetime.newInstanceGmt(eventSc.ES_StartDate__c.year(), eventSc.ES_StartDate__c.Month(), eventSc.ES_StartDate__c.Day() ).format('MMMM dd, yyyy');
        FormatedEndDate = Datetime.newInstanceGmt(eventSc.ES_EndDate__c.year(), eventSc.ES_EndDate__c.Month(), eventSc.ES_EndDate__c.Day() ).format('MMMM dd, yyyy');
       
            } 
         }


 global class KSKBoothDetails{
    Id Booth_ID;
    String Booth_Name;
    String Booth_Description;
    String Booth_ContactName;
    String Booth_ContactPhoneNo;
    String Booth_ContactEmail;
    String Booth_Website;
    String Message;
    String Booth_Location;
    String Booth_Phone;
    String coordinates;    
    
    global KSKBoothDetails(booth__c booth){
        Booth_ID = booth.Id;
        Booth_Name = booth.BT_Name__c;
        Booth_Description = booth.BT_Description__c;
        Booth_ContactName = booth.BT_ContactName__c;
        Booth_ContactPhoneNo = booth.BT_ContactPhone__c;
        Booth_ContactEmail = booth.BT_ContactEmail__c;
        Booth_Website = booth.BT_WebsiteURL__c;
        Booth_Location= booth.BT_Location__c;
        Booth_Phone = booth.BT_Phone__c;
    
        for(Floor_Map__c fmp: booth.Floor_Map__r){        
           coordinates = fmp.Parameters__c;
        }
   }
  }
  
  
  global class KSKSpeakers{
    Id sid;
    String Title;
    String Room;
    String Speaker;
    String StartTime;
    String EndTime;
    String SDate;
    String Description;
    Decimal MaxNoOfPeople;
    Decimal Cost;
    String SpkDesigAndDept;     
    String SpkCompany;  
    String SpkSeminarRole;  
    String SpkImage;  
    
    
    global KSKSpeakers(Seminar__c sm){
        sid = sm.id;
        Title = sm.Name;
        Room = sm.Track__r.Name;
        Speaker = sm.Speaker__c;
        StartTime = sm.Start_Time__c;
        EndTime = sm.End_Time__c;          
        SDate = Datetime.newInstanceGmt(sm.Date__c.year(), sm.Date__c.Month(), sm.Date__c.Day() ).format('MMMM dd, yyyy');
        Description = sm.Description__c;
        MaxNoOfPeople = sm.Max_no_of_people__c;
        Cost= sm.Cost__c;
        SpkDesigAndDept = sm.Spk_DesigAndDept__c;
        SpkCompany = sm.Spk_Company__c;
        SpkSeminarRole = sm.Spk_SeminarRole__c;
        
        if(sm.Spk_image__c!=null){
          String orgId = UserInfo.getOrganizationId();
          String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
          SpkImage=sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+sm.Spk_image__c;
        }
        
     }
  }

/* KIOSK WEB SERVICES */

//-------------------------------MM Event details ----------------------------------------
    
    global class EveDates{
        Date MMDay;
        String MMStartTime;
        String MMEndTime;
        
        global EveDates(Date D, String st, String et){
            MMDay = D;
            MMStartTime = st;
            MMEndTime = et;
        
        }
    }
    
    global class MMEventDetails{
       Id Event_ID;
       String Event_Name;
       Date Event_StartDate;
       String Event_StartHour;
       String Event_EndHour;
       String Event_Location;
       String EventLogoImageURL;
       String Status;
       Date Event_Date;
       String Event_Description;
       String HostingAddr1;
       String HostingAddr2;
       String HostingCity;
       String HostingState;
       String HostingCountry;
       String HostingZipcode;
       String HostingPhone;
       String TwitterHashTag;
       String UserRole;
       String MMType;
       String MatchMakingStartTime;
       String MatchMakingEndTime;
       Date MatchMakingStartDate;
       Date MatchMakingEndDate;
       boolean IsprivateAttendee ;
       String error;
       LIST<EveDates> edates;
       List<MatchLeadTabs> MatchLeadTabs;
        String MatchMakingSchedulesStatus; 
       List<Profile_Settings__c> profileSettings{get;set;}

      global MMEventDetails(String noEvents)
      {
          error = noEvents;
      }
             
      global MMEventDetails(event__c eve, String userr )
      {
       profileSettings = new List<Profile_Settings__c>();
       profileSettings.addALL(eve.Profile_Settings__r);
       Event_ID = eve.Id;
       IsprivateAttendee  =eve.Is_Webank_event__c;
       Event_Name =eve.EV_Title__c;
       Event_StartDate = eve.EV_StartDate__c;
       Event_StartHour = eve.StartTime__c;
       Event_EndHour =eve.EV_EndTime__c;
       Event_Location = eve.EV_HostingLocation__c;
       Event_Date = eve.EV_EndDate__c;
       UserRole = userr;
       String orgId = UserInfo.getOrganizationId();
       String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
       EventLogoImageURL=sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+eve.EV_EventLogo__c;  
       Status = eve.Status__c;
       MMType = eve.MatchMaking_Type__c;
       Event_Description = eve.EV_Description__c;       
       HostingAddr1 = eve.EV_HistingAddr1__c;                    
       HostingAddr2 = eve.AS_HostingAddr2__c;                    
       HostingCity = eve.AS_HostingCity__c;                    
       HostingState = eve.EV_HostingStateNew__c;                    
       HostingCountry = eve.EV_HostingCountryNew__c ;                   
       HostingZipcode = eve.EV_HostingZipcode__c;
       HostingPhone = eve.EV_HostingPhone__c;
       TwitterHashTag =eve.TwitterHashTag__c;
       MatchMakingStartTime=eve.MM_Firstaday_startTime__c;
       MatchMakingEndTime=eve.MM_Firstaday_EndTime__c;  
       MatchMakingStartDate=eve.MM_Start_Date__c;
       MatchMakingEndDate=eve.MM_End_Date__c; 
       MatchMakingSchedulesStatus = eve.Match_Making_Schedules__c;
       edates = new LIST<EveDates>();
       
       for(MatchLeads_Days__c md: eve.MatchLeads_Days__r){
           edates.add(new EveDates (md.MatchLeads_Date__c, md.Start_time__c, md.End_Time__c));
       
       } 
       
       MatchLeadTabs=new List<MatchLeadTabs>();
       for(Tags__c tg: eve.Tags__r){
           MatchLeadTabs.add(new MatchLeadTabs(tg.Default_Name__c,tg.Alias_Name__c ));
       
       } 
   }
 } 


 global class MatchLeadTabs
 {
   public String Default_Name{get;set;}
   public String Alias_Name{get;set;}
   
   public MatchLeadTabs(String Default_Name,String Alias_Name)
   {
   this.Default_Name=Default_Name;
   this.Alias_Name=Alias_Name;
   }
 }
  
  
//-------------------------------MM Attendees Search of Exhibitor Results----------------------------------------

global  class MMSearchRes{
String FirstName;
String LastName;
String Email;
String Company;
String NAICSCode1;
String PrimaryBusinessCategory;
String ImageUrl;
String Exhibitorid;
String Exkeywords;
    global MMSearchRes(AttendeeSummary__c atnd, String exId)
      {
        FirstName = atnd.AS_FirstName__c;
        LastName = atnd.AS_LastName__c;
        Email = atnd.AS_Email__c;
        Company = atnd.AS_Company__c;
        NAICSCode1 = atnd.AS_NAICSCode_1__c;
        PrimaryBusinessCategory = atnd.AS_PrimaryBusinessCategory__c;
        String orgId = UserInfo.getOrganizationId();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(atnd.AS_ImageUrl__c!=''){
        ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+atnd.AS_ImageUrl__c;   
        Exhibitorid = exId;
        Exkeywords = atnd.Keywords__c;
          }
        //ImageUrl = atnd.AS_ImageUrl__c;
      }
}

//-------------------------------MM Attendees Search of Exhibitor Results----------------------------------------

global  class MMATTSearchRes{
String FirstName;
String LastName;
String Email;
String Company;
String Title;
String CellPhone;
String WebsiteUrl;
String AState;
String ACity;
String Workzip;
String NAICSCode1;
String NAICSCode2;
String NAICSCode3;
String NAICSCode4;
String NAICSCode5;
String PrimaryBusinessCategory;
String SecondaryBusinessCategory;
String ImageUrl;
String Attendeeid;
String CompanyCertifications;
String BusinessType;
String GSASchedule;
//Decimal BusinessRevenue;
string BusinessRevenue;
Decimal NumberOfEmployees;
Integer NumberOfYears;
String Address1;
String Address2;
String ATTKeywords;

//
String Commodity_1;
String Commodity_2;
String Commodity_3;
String Commodity_4;
String Commodity_5;
String Business_Desc;



    global MMATTSearchRes(AttendeeSummary__c atnd, String exId)
      {
        FirstName = atnd.AS_FirstName__c;
        LastName = atnd.AS_LastName__c;
        Email = atnd.AS_Email__c;
        Company = atnd.AS_Company__c;
        
        Commodity_1 = atnd.Commodity_1__c;
        Commodity_2 = atnd.Commodity_2__c;
        Commodity_3=atnd.Commodity_3__c ;
        Commodity_4= atnd.Commodity_4__c;
        Commodity_5= atnd.Commodity_5__c;
        Business_Desc=  atnd.AS_BusinessDescription__c;
        
        
        NAICSCode1 = atnd.AS_NAICSCode_1__c;
        NAICSCode2 = atnd.AS_NAICSCode_2__c;
        NAICSCode3 = atnd.AS_NAICSCode_3__c;
        NAICSCode4 = atnd.AS_NAICSCode_4__c;
        NAICSCode5 = atnd.AS_NAICSCode_5__c;
        Address1 = atnd.AS_WorkAddress1__c;
        Address2 = atnd.AS_WorkAddress2__c;
        Workzip = atnd.AS_WorkZip__c;
        Title = atnd.AS_Title__c;
        WebsiteUrl = atnd.AS_WebsiteUrl__c;
        CellPhone = atnd.AS_WorkPhone__c;
        
        PrimaryBusinessCategory = atnd.AS_PrimaryBusinessCategory__c;
        SecondaryBusinessCategory = atnd.As_SecondaryBusinessCategory1__c;
        String orgId = UserInfo.getOrganizationId();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(atnd.AS_ImageUrl__c!=''){
        ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+atnd.AS_ImageUrl__c;   
        Attendeeid = atnd.Id;
        CompanyCertifications = atnd.Company_Certifications__c;
        ACity = atnd.AS_WorkCity__c;
        AState = atnd.AS_WorkState__c;
        BusinessType = atnd.AS_DiversityType__c;
        GSASchedule = atnd.GSA_Schedule__c;
       //BusinessRevenue = atnd.AS_BusinessRevenue__c;
        BusinessRevenue = atnd.Revenue_Range__c;
        NumberOfEmployees = atnd.AS_NumberOfEmployees__c;
        ATTKeywords = atnd.Keywords__c;
        
        List<String> estbdate = new List<String>();
        Integer estbdatey;
        if(atnd.AS_BusinessEstablishedDate__c!=null){
        estbdate = String.ValueOf(atnd.AS_BusinessEstablishedDate__c).split('-');
        estbdatey = Integer.valueOf(estbdate[estbdate.size()-3]);
        system.debug(' estbdate'+estbdatey+estbdate);        
        
        List<String> todaydate = String.ValueOf(Date.Today()).split('-');
        Integer todaydy = Integer.valueOf(todaydate[todaydate.size()-3]);
        system.debug('todaydy'+todaydy+todaydate);
        
        NumberOfYears = todaydy - estbdatey;
        system.debug('NumberOfYears----------------- '+NumberOfYears );
          }else{
           NumberOfYears = 0;
           system.debug('NumberOfYears000000000000000000000 '+NumberOfYears );
          }

        
        
          }
       
      }
      
      
      global MMATTSearchRes(MBE_Profile__c atnd, String exId)
      {
        FirstName = atnd.AS_FirstName__c;
        LastName = atnd.AS_LastName__c;
        Email = atnd.AS_Email__c;
        Company = atnd.AS_Company__c;
        
        Commodity_1 = atnd.Commodity_1__c;
        Commodity_2 = atnd.Commodity_2__c;
        Commodity_3=atnd.Commodity_3__c ;
        Commodity_4= atnd.Commodity_4__c;
        Commodity_5= atnd.Commodity_5__c;
        Business_Desc=  atnd.AS_BusinessDescription__c;
        
        
        
        NAICSCode1 = atnd.AS_NAICSCode_1__c;
        NAICSCode2 = atnd.AS_NAICSCode_2__c;
        NAICSCode3 = atnd.AS_NAICSCode_3__c;
        NAICSCode4 = atnd.AS_NAICSCode_4__c;
        NAICSCode5 = atnd.AS_NAICSCode_5__c;
        Address1 = atnd.AS_WorkAddress1__c;
        Address2 = atnd.AS_WorkAddress2__c;
        Workzip = atnd.AS_WorkZip__c;
        Title = atnd.AS_Title__c;
        WebsiteUrl = atnd.AS_WebsiteUrl__c;
        CellPhone = atnd.AS_WorkPhone__c;
        
        PrimaryBusinessCategory = atnd.AS_PrimaryBusinessCategory1__c;
        SecondaryBusinessCategory = atnd.As_SecondaryBusinessCategory1__c;
        String orgId = UserInfo.getOrganizationId();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(atnd.AS_ImageUrl__c!=''){
        ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+atnd.AS_ImageUrl__c;   
        Attendeeid = atnd.Id;
        CompanyCertifications = atnd.Company_Certifications__c;
        ACity = atnd.AS_WorkCity__c;
        AState = atnd.AS_Work_States__c;
        BusinessType = atnd.AS_DiversityType__c;
        GSASchedule = atnd.GSA_Schedule__c;
       // BusinessRevenue = atnd.AS_BusinessRevenue__c;
       BusinessRevenue = atnd.Revenue_Range__c;
        NumberOfEmployees = atnd.AS_NumberOfEmployees__c;
        ATTKeywords = atnd.Key_Words__c;
        
        List<String> estbdate = new List<String>();
        Integer estbdatey;
        if(atnd.AS_BusinessEstablishedDate__c!=null){
        estbdate = String.ValueOf(atnd.AS_BusinessEstablishedDate__c).split('-');
        estbdatey = Integer.valueOf(estbdate[estbdate.size()-3]);
        system.debug(' estbdate'+estbdatey+estbdate);        
        
        List<String> todaydate = String.ValueOf(Date.Today()).split('-');
        Integer todaydy = Integer.valueOf(todaydate[todaydate.size()-3]);
        system.debug('todaydy'+todaydy+todaydate);
        
        NumberOfYears = todaydy - estbdatey;
        system.debug('NumberOfYears----------------- '+NumberOfYears );
          }else{
           NumberOfYears = 0;
           system.debug('NumberOfYears000000000000000000000 '+NumberOfYears );
          }

        
        
          }
       
      }
}
//-------------------------------MM Attendees  - Exhibitor Schedules----------------------------------------

global  class MMEXSchedules{
String EventId;
String EventName;
String FirstName;
String LastName;
String Company;
String Email;
Id id;
Id Evscid;
String SlotStartTime;
String SlotEndTime;
Date SlotDate;
String SlotStatus;
String TableNo;
String Location;
Id evscOwnerId;

    global MMEXSchedules(EventSchedule__c evids, String First_Name, String Last_Name, String Company_Name, String EmailId, Id schid)
      { 
        Evscid = evids.Id;
        evscOwnerId = evids.OwnerId;
        EventId = evids.EV_id__r.Id;
        EventName = evids.EV_id__r.EV_Title__c;
        FirstName = First_Name;
        LastName = Last_Name;       
        Company = Company_Name;
        Email = EmailId;
        Id = schid;
        SlotStartTime = evids.MM_slot_StartTime__c;        
        SlotDate = evids.MM_slot_Date__c;
        SlotEndTime = evids.MM_Slot_End_Time__c;
        SlotDate = evids.MM_slot_Date__c;
        SlotStatus = evids.MM_Slot_Status__c;
        TableNo = evids.MM_To_UPE__r.BT_id__r.MM_TableNo__c;
        Location = evids.MM_To_UPE__r.BT_id__r.BT_Location__c;
      }
}

/* , String BoothNum, String Location */
//-------------------------------MM Attendees  - Exhibitor Appointment----------------------------------------

global  class MMEXAppointmentlist{
String SlotStartTime;
String SlotEndTime;
Date SlotDate;
String SlotStatus;
String TableNo;
Id evscOwnerId;
ID eventScheduleId;

    global MMEXAppointmentlist(EventSchedule__c evids)
      { 
        SlotStartTime = evids.MM_slot_StartTime__c;        
        SlotDate = evids.MM_slot_Date__c;
        SlotEndTime = evids.MM_Slot_End_Time__c;
        SlotDate = evids.MM_slot_Date__c;
        SlotStatus = evids.MM_Slot_Status__c;
        TableNo = evids.MM_To_UPE__r.BT_id__r.MM_TableNo__c;
        evscOwnerId = evids.OwnerId;
        eventScheduleId = evids.id;
      }
}

// Service for new match leads 3.0 - EX appointment //  
/*global class MMExScheduledApts{
    
    //Date SlotDate;
    LIST<MMEXAppointmentlist> schappts;
      
        global MMExScheduledApts(LIST<MMEXAppointmentlist> appts){
           // SlotDate = scheduedDate;
            schappts = appts;
            
        }
}*/
// Service for new match leads 3.0 - EX appointment - END //  

//-------------------------------MM Attendees  - Exhibitor Fixed Appointments/Slots----------------------------------------

global  class MMEXOpenslots{
String SlotStartTime;
String SlotEndTime;
string SlotDate;
String SlotStatus;
String TableNo;

    global MMEXOpenslots(String slots,string dat)
      { 
        SlotStartTime = slots;        
        SlotDate = dat;
        /*SlotEndTime = evids.MM_Slot_End_Time__c;
        SlotDate = evids.MM_slot_Date__c;
        SlotStatus = evids.MM_Slot_Status__c;
        TableNo = evids.MM_To_UPE__r.BT_id__r.MM_TableNo__c;*/
      }
}


global  class MMBlockedslots{
    String SlotStartTime;
    String SlotEndTime;
    string SlotDate;
    String SlotStatus;
    String TableNo;

    global MMBlockedslots(Event_Breaks__c eb)
      { 
        SlotStartTime = eb.Break_Start_Time__c;    
        //SlotDate = eb.MatchLeads_Days__r.;
        SlotEndTime = eb.Break_End_Time__c;
        SlotDate = string.valueOf(eb.MatchLeads_Days__r.MatchLeads_Date__c);
        SlotStatus ='Blocked';
        //TableNo = evids.MM_To_UPE__r.BT_id__r.MM_TableNo__c;*/
      }
}


//-------------------------------MM Attendees  - Exhibitor Deatils----------------------------------------

global  class MMEXHDetails{

Id exid;
String FirstName;
String LastName;
String Email;
String CompanyCertifications;
String CellPhone;
String Company;
String Title;
String ImageUrl; 
String companyimageUrl;
String PrimaryBusinessCategory;
String SecondaryBusinessCategory;
String WebsiteUrl;
String WorkAddress1; 
String WorkAddress2;
String WorkCity;
String WorkCountry;
String WorkState;
String WorkZip;
String NAICSCode1;
String NAICSCode2; 
String NAICSCode3;
String NAICSCode4;
String NAICSCode5;
String TableRoomNo;
String Location;
String Exkeywords;
String Commodity_1;
String Commodity_2;
String Commodity_3;
String Commodity_4;
String Commodity_5;
String Business_Desc;
String exceptional_keywords;
    global MMEXHDetails(User_Profile_Event__c exdts)
      { 
        exid = exdts.User_id__r.Id;
        FirstName = exdts.Attendee_Summary__r.AS_FirstName__c;
        LastName = exdts.Attendee_Summary__r.AS_LastName__c;
        Email = exdts.Attendee_Summary__r.AS_Email__c;
        CompanyCertifications = exdts.Attendee_Summary__r.Company_Certifications__c;
        CellPhone = exdts.Attendee_Summary__r.AS_WorkPhone__c;
        Company = exdts.Attendee_Summary__r.AS_Company__c;
        Title = exdts.Attendee_Summary__r.AS_Title__c;
        String orgId = UserInfo.getOrganizationId();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(exdts.Attendee_Summary__r.AS_ImageUrl__c!=''){
        ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+exdts.Attendee_Summary__r.AS_ImageUrl__c; 
        }
        if(exdts.Attendee_Summary__r.Exhibitor_company_imageUrl__c!=''){
        companyimageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+exdts.Attendee_Summary__r.Exhibitor_company_imageUrl__c; 
        }       
       
        
        PrimaryBusinessCategory = exdts.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c ;
        SecondaryBusinessCategory = exdts.Attendee_Summary__r.As_SecondaryBusinessCategory1__c ;
        WebsiteUrl = exdts.Attendee_Summary__r.AS_WebsiteUrl__c ;
        WorkAddress1 = exdts.Attendee_Summary__r.AS_WorkAddress1__c ;
        WorkAddress2 = exdts.Attendee_Summary__r.AS_WorkAddress2__c ;
        WorkCity = exdts.Attendee_Summary__r.AS_WorkCity__c ;
        WorkCountry = exdts.Attendee_Summary__r.AS_Work_Country__c;
        WorkState = exdts.Attendee_Summary__r.AS_Work_States__c;
        WorkZip = exdts.Attendee_Summary__r.AS_WorkZip__c ;
        NAICSCode1 = exdts.Attendee_Summary__r.AS_NAICSCode_1__c ;
        NAICSCode2 = exdts.Attendee_Summary__r.AS_NAICSCode_2__c;
        NAICSCode3 = exdts.Attendee_Summary__r.AS_NAICSCode_3__c ;
        NAICSCode4 = exdts.Attendee_Summary__r.AS_NAICSCode_4__c ;
        NAICSCode5 = exdts.Attendee_Summary__r.AS_NAICSCode_5__c ;
        TableRoomNo = exdts.BT_id__r.MM_TableNo__c;
        Location = exdts.BT_id__r.BT_Location__c;
        Exkeywords = exdts.Attendee_Summary__r.Keywords__c;
       
        Commodity_1 = exdts.Attendee_Summary__r.Commodity_1__c;
        Commodity_2 = exdts.Attendee_Summary__r.Commodity_2__c;
        Commodity_3 = exdts.Attendee_Summary__r.Commodity_3__c;
        Commodity_4 = exdts.Attendee_Summary__r.Commodity_4__c;
        Commodity_5 = exdts.Attendee_Summary__r.Commodity_5__c;    
        Business_Desc = exdts.Attendee_Summary__r.AS_BusinessDescription__c;
        exceptional_keywords = exdts.Attendee_Summary__r.Exceptional_Key_Words__c;
      }
      
     global MMEXHDetails(AttendeeSummary__c asum)
      { 
        
        FirstName = asum.AS_FirstName__c;
        LastName = asum.AS_LastName__c;
        Email = asum.AS_Email__c;
        CompanyCertifications = asum.Company_Certifications__c;
        CellPhone = asum.AS_WorkPhone__c;
        Company = asum.AS_Company__c;
        Title = asum.AS_Title__c;
        String orgId = UserInfo.getOrganizationId();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(asum.AS_ImageUrl__c!=''){
        ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+asum.AS_ImageUrl__c; 
        }
        if(asum.Exhibitor_company_imageUrl__c!=''){
        companyimageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+asum.Exhibitor_company_imageUrl__c; 
        }       
       
        PrimaryBusinessCategory = asum.AS_PrimaryBusinessCategory1__c ;
        SecondaryBusinessCategory = asum.As_SecondaryBusinessCategory1__c ;
        WebsiteUrl = asum.AS_WebsiteUrl__c ;
        WorkAddress1 = asum.AS_WorkAddress1__c ;
        WorkAddress2 = asum.AS_WorkAddress2__c ;
        WorkCity = asum.AS_WorkCity__c ;
        WorkCountry = asum.AS_Work_Country__c;
        WorkState = asum.AS_Work_States__c;
        WorkZip = asum.AS_WorkZip__c ;
        NAICSCode1 = asum.AS_NAICSCode_1__c ;
        NAICSCode2 = asum.AS_NAICSCode_2__c;
        NAICSCode3 = asum.AS_NAICSCode_3__c ;
        NAICSCode4 = asum.AS_NAICSCode_4__c ;
        NAICSCode5 = asum.AS_NAICSCode_5__c ;
        TableRoomNo = '';
        Location = '';
        Exkeywords = asum.Keywords__c;
       
      } 
      
     global MMEXHDetails(MBE_Profile__c asum)
      { 
        FirstName = asum.AS_FirstName__c;
        LastName = asum.AS_LastName__c;
        Email = asum.AS_Email__c;
        CompanyCertifications = asum.Company_Certifications__c;
        CellPhone = asum.AS_WorkPhone__c;
        Company = asum.AS_Company__c;
        Title = asum.AS_Title__c;
        String orgId = UserInfo.getOrganizationId();
        String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(asum.AS_ImageUrl__c!=''){
        ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+asum.AS_ImageUrl__c; 
        }
        if(asum.Exhibitor_company_imageUrl__c!=''){
        companyimageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+asum.Exhibitor_company_imageUrl__c; 
        }       
       
        PrimaryBusinessCategory = asum.AS_PrimaryBusinessCategory1__c ;
        SecondaryBusinessCategory = asum.As_SecondaryBusinessCategory1__c ;
        WebsiteUrl = asum.AS_WebsiteUrl__c ;
        WorkAddress1 = asum.AS_WorkAddress1__c ;
        WorkAddress2 = asum.AS_WorkAddress2__c ;
        WorkCity = asum.AS_WorkCity__c ;
        WorkCountry = asum.AS_Work_Country__c;
        WorkState = asum.AS_Work_States__c;
        WorkZip = asum.AS_WorkZip__c ;
        NAICSCode1 = asum.AS_NAICSCode_1__c ;
        NAICSCode2 = asum.AS_NAICSCode_2__c;
        NAICSCode3 = asum.AS_NAICSCode_3__c ;
        NAICSCode4 = asum.AS_NAICSCode_4__c ;
        NAICSCode5 = asum.AS_NAICSCode_5__c ;
        TableRoomNo = '';
        Location = '';
         Exkeywords =  asum.Key_Words__c;
         Commodity_1 = asum.Commodity_1__c;
        Commodity_2 = asum.Commodity_2__c;
        Commodity_3 = asum.Commodity_3__c;
        Commodity_4 = asum.Commodity_4__c;
        Commodity_5 = asum.Commodity_5__c;    
        Business_Desc = asum.AS_BusinessDescription__c;
     }  
      
      
}


//-------------------------------MM Attendees  - Exhibitor Deatils----------------------------------------

global  class globalSuccess{
Id scheduledId;
String message;

    global globalSuccess(Id schedId, String msg)
      { 
        scheduledId = schedId;
        message = msg;
      }
}

//-------------------------------Message----------------------------------------

global  class globalMessage{
String message;

    global globalMessage(String msg)
      {         
        message = msg;
      }
}

// --------------------------------------------- event schedule -----------------------------------

 global class EventSchedule{
        global string Message;
        global String ProgramName;
        global String Description;
        global  String Location;
        global String Presenter;
        global Date StartDate;
        global Date EndDate;
        global String StartTime;
        global String EndTime;
        global string eventName;
        global id id;
        global id eventId; 
              
        global EventSchedule(EventSchedule__c eventSc){
        id =eventSc.id;
        eventId =eventSc.EV_id__c;
        ProgramName = eventSc.ES_ProgramName__c;
        Description = eventSc.ES_Description__c;
        Location  = eventSc.ES_Location__c;
        Presenter = eventSc.ES_Presenter__c; 
        StartDate = eventSc.ES_StartDate__c;
        EndDate  =   eventSc.ES_EndDate__c;
        StartTime =  eventSc.ES_StartTime__c;
        EndTime   =  eventSc.ES_EndTime__c;
        eventName = eventSc.EV_id__r.EV_Title__c;
            } 
         }
   
   
// --------------------------------------------- EX - New Slot schedule Detais-----------------------------------

 global class NewSlotDetils{
    String FirstName;
    String LastName;
    Date StartDate;        
    String StartTime;
    String EndTime;
    String Status;
    String TableNo;
    Id evscOwnerId;
       
        global NewSlotDetils(EventSchedule__c df){
        
        }
             
        global NewSlotDetils(EventSchedule__c nscd, String lurole){
        if(lurole=='MBE'){
        FirstName = nscd.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c;
        LastName  = nscd.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c;
        }else if(lurole=='Corporate'){
        FirstName = nscd.MM_To_EAM__r.AS_id__r.AS_FirstName__c;
        LastName  = nscd.MM_To_EAM__r.AS_id__r.AS_LastName__c;
        }
        StartDate = nscd.MM_slot_Date__c;        
        StartTime =  nscd.MM_slot_StartTime__c;
        EndTime   =  nscd.MM_Slot_End_Time__c;
        Status = nscd.MM_Slot_Status__c;
        TableNo = nscd.MM_To_UPE__r.BT_id__r.MM_TableNo__c;
        evscOwnerId = nscd.OwnerId;
            } 
         }
      
  // ---------------------------------------- Exhibitors --------------------------------------       
         
         
    global class BoothDetails{
    Id Booth_ID;
    String Booth_Name;
    String Booth_Description;
    String Booth_ContactName;
    String Booth_ContactPhoneNo;
    String Booth_ContactEmail;
    String Booth_Website;
    String Message;
    String Booth_Location;
    String Booth_Phone;
    Id eventId;
    String eventName;    
    
    global BoothDetails(booth__c booth){
    eventId=booth.EV_id__c;
    eventName=booth.EV_id__r.EV_Title__c;
    Booth_ID = booth.Id;
    Booth_Name = booth.BT_Name__c;
    Booth_Description = booth.BT_Description__c;
    Booth_ContactName = booth.BT_ContactName__c;
    Booth_ContactPhoneNo = booth.BT_ContactPhone__c;
    Booth_ContactEmail = booth.BT_ContactEmail__c;
    Booth_Website = booth.BT_WebsiteURL__c;
    Booth_Location= booth.BT_Location__c;
    Booth_Phone = booth.BT_Phone__c;
   }
  }
 // ----------------------------------------- Leads -----------------------------------
 
 global class leads{

 string lastRequestedOn= string.valueOf(dateTime.now()); 
 global  id UserId;
 global  id EventId;
  global string AttnedeeBarcodeId;
 global  string NextFollowUpdate ;
 global  String Event;
 global string FollowupTypes ;
 global string leadRating ;
 global string notes;
 global string scannedTime;
 global string tzone;
 global string tZoneShortForm;
 global String FirstName;
 global String LastName;
 global String Company;
 global String City;
 global String State;
 global String PhoneNo;
 global String Email;
 global String message;
 global string leadid{get;set;}
 //global String error;
 global String ImageUrl;
 global String RecordId;
 global string Designation;
global string Barcodeid;
 global string SurveyQuestion1;
 global string SurveyQuestion2;
 global string SurveyQuestion3;
 global string SurveyQuestion4;
 global string SurveyAnswer1;
 global string SurveyAnswer2;
 global string SurveyAnswer3;
 global string SurveyAnswer4;
 global string SalesForceStatus;
 global String UniqueCode{get;set;} 
  
 public leads(BoothVisitSummary__c innBVS){
    String orgId = UserInfo.getOrganizationId();
    String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    if(innBVS.AS_ImageUrl__c!=null & innBVS.AS_ImageUrl__c!=''){
    ImageUrl =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id='+innBVS.AS_ImageUrl__c;  
    }
    
  UserId =innBVS.User_id__c;  
  AttnedeeBarcodeId =innBVS.EA_AttendeeBarcode__c;
   if(null != innBVS.EA_AttendeeBarcode__r.UniqNo__c ){
     UniqueCode=innBVS.EA_AttendeeBarcode__r.UniqNo__c;
   }
  Barcodeid=innBVS.EA_AttendeeBarcode__c;
  PhoneNo =innBVS.BVS_PhoneNumber__c;
  Email =innBVS.BVS_Email__c;
  if(innBVS.Follow_Update__c!=null){
  NextFollowUpdate =String.ValueOF((innBVS.Follow_Update__c).format('yyyy-MM-dd hh:mm:ss a'));
  }else{
  NextFollowUpdate =string.valueOf(innBVS.Follow_Update__c);
  
  }
  Designation =innBVS.BVS_Title__c;
  FollowupTypes =innBVS.BVS_FollowUps__c;
  try{
  if(innBVS.BVS_LeadRating__c !=null ){
  leadRating =string.valueOf(innBVS.BVS_LeadRating__c);
  }
  }catch (exception e){
  }
  notes =innBVS.BVS_Notes__c;
  if(innBVS.ScannedTime__c!=null){
  scannedTime =String.ValueOF(innBVS.ScannedTime__c);
  
  }
  leadid =innBVS.id;
  FirstName=innBVS.BVS_FirstName__c;
  LastName=innBVS.BVS_LastName__c;
  Company=innBVS.BVS_Company__c;
  City=innBVS.BVS_City__c;
  State=innBVS.BVS_State__c;
  RecordId = innBVS.Mrecordid__c;
  Event=innBVS.EA_AttendeeBarcode__r.EV_id__r.EV_Title__c;
  EventId=innBVS.EA_AttendeeBarcode__r.EV_id__c;
  
  SurveyQuestion1=innBVS.BVS_SurveyQuestion1__c;
  SurveyQuestion2=innBVS.BVS_SurveyQuestion2__c;
  SurveyQuestion3=innBVS.BVS_SurveyQuestion3__c;
  SurveyQuestion4=innBVS.BVS_SurveyQuestion4__c;
  
  SurveyAnswer1=innBVS.BVS_SurveyAnswer1__c;
  SurveyAnswer2=innBVS.BVS_SurveyAnswer2__c;
  SurveyAnswer3=innBVS.BVS_SurveyAnswer3__c;
  SurveyAnswer4=innBVS.BVS_SurveyAnswer4__c;
  //SalesForceStatus=innBVS.SalesForceStatus__c;
 }
}        
         
//Global method to get controlling and its dependent picklist values in a map
public List<Countries> getDependentOptionsImpl(String objName, String contrfieldName, String depfieldName){
        List<Countries> cnt=new List<Countries>();
        String objectName = objName.toLowerCase();
        String controllingField = contrfieldName.toLowerCase();
        String dependentField = depfieldName.toLowerCase();        
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        //get the string to sobject global map
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
        if (!Schema.getGlobalDescribe().containsKey(objectName)){
            System.debug('OBJNAME NOT FOUND --.> ' + objectName);
            return null;
        }
        
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        if (objType==null){
            return cnt;
        }
        Bitset bitSetObj = new Bitset();
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        //Check if picklist values exist
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            System.debug('FIELD NOT FOUND --.> ' + controllingField + ' OR ' + dependentField);
            return cnt;     
        }
        List<Schema.PicklistEntry> contrEntries = objFieldMap.get(controllingField).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> depEntries = objFieldMap.get(dependentField).getDescribe().getPicklistValues();
        objFieldMap = null;
        List<Integer> controllingIndexes = new List<Integer>();
        for(Integer contrIndex=0; contrIndex<contrEntries.size(); contrIndex++){            
            Schema.PicklistEntry ctrlentry = contrEntries[contrIndex];
            String label = ctrlentry.getLabel();
            objResults.put(label,new List<String>());
            controllingIndexes.add(contrIndex);
        }
        List<Schema.PicklistEntry> objEntries = new List<Schema.PicklistEntry>();
        List<PicklistEntryWrapper> objJsonEntries = new List<PicklistEntryWrapper>();
        for(Integer dependentIndex=0; dependentIndex<depEntries.size(); dependentIndex++){            
               Schema.PicklistEntry depentry = depEntries[dependentIndex];
               objEntries.add(depentry);
        } 
        objJsonEntries = (List<PicklistEntryWrapper>)JSON.deserialize(JSON.serialize(objEntries), List<PicklistEntryWrapper>.class);
        List<Integer> indexes;
        for (PicklistEntryWrapper objJson : objJsonEntries){
            if (objJson.validFor==null || objJson.validFor==''){
                continue;
            }
            indexes = bitSetObj.testBits(objJson.validFor,controllingIndexes);
            for (Integer idx : indexes){                
                String contrLabel = contrEntries[idx].getLabel();
                objResults.get(contrLabel).add(objJson.label);
            }
        }
        objEntries = null;
        objJsonEntries = null;
        
        for(String cnty:objResults.keySet())
        {
        Countries cntnew=new Countries();
        cntnew.countryname=cnty;
        cntnew.states=new List<String>();
        if(cnty=='United States of America')
        {
         cntnew.states.add('Alabama'); 
cntnew.states.add('Alaska'); 
cntnew.states.add('Arizona'); 
cntnew.states.add('Arkansas'); 
cntnew.states.add('California'); 
cntnew.states.add('Colorado');
cntnew.states.add('Connecticut');
cntnew.states.add('Delaware'); 
cntnew.states.add('Florida'); 
cntnew.states.add('Georgia'); 
cntnew.states.add('Hawaii'); 
cntnew.states.add('Idaho'); 
cntnew.states.add('Illinois Indiana'); 
cntnew.states.add('Iowa'); 
cntnew.states.add('Kansas'); 
cntnew.states.add('Kentucky'); 
cntnew.states.add('Louisiana'); 
cntnew.states.add('Maine'); 
cntnew.states.add('Maryland'); 
cntnew.states.add('Massachusetts'); 
cntnew.states.add('Michigan'); 
cntnew.states.add('Minnesota'); 
cntnew.states.add('Mississippi'); 
cntnew.states.add('Missouri'); 
cntnew.states.add('Montana Nebraska'); 
cntnew.states.add('Nevada'); 
cntnew.states.add('New Hampshire'); 
cntnew.states.add('New Jersey'); 
cntnew.states.add('New Mexico'); 
cntnew.states.add('New York'); 
cntnew.states.add('North Carolina'); 
cntnew.states.add('North Dakota'); 
cntnew.states.add('Ohio'); 
cntnew.states.add('Oklahoma'); 
cntnew.states.add('Oregon'); 
cntnew.states.add('Pennsylvania');
cntnew.states.add('South Carolina'); 
cntnew.states.add('South Dakota'); 
cntnew.states.add('Tennessee'); 
cntnew.states.add('Texas'); 
cntnew.states.add('Utah'); 
cntnew.states.add('Vermont'); 
cntnew.states.add('Virginia'); 
cntnew.states.add('Washington'); 
cntnew.states.add('West Virginia'); 
cntnew.states.add('Wisconsin'); 
cntnew.states.add('Wyoming');
        }
        //cntnew.states=objResults.get(cnty);
        cnt.add(cntnew);
        }
        return cnt;
    }

global class Countries{
    String countryname;
    List<String> states;
    }
}