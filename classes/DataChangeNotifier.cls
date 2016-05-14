@RestResource(urlMapping='/DataChangeNotifier3/*')

 global without sharing class DataChangeNotifier{
  global static String userName;
  global static String eventId;
  global static String requestedDate;
  global static dateTime LastmodiFieddateFromMobile;
  
  @HttpGet
  global static AllDetails doGet(){
  
  RestRequest req = RestContext.request;
  RestResponse res = RestContext.response;
  system.debug('5555555555 '+res);  
  userName= req.params.get('UserId');
 // eventId =req.params.get('eventId');
  system.debug('666666666  '+eventId+'2222222 '+userName);
  if(userName ==''){
 // inncls.add(new innerclass('UserId is not valid'));
  }
  
  
  system.debug('88888888888888888888 '+req.headers.get('requestedDate'));
  
 LastmodiFieddateFromMobile = dateTime.valueOf(req.headers.get('requestedDate'));
 Date currDate = LastmodiFieddateFromMobile.date();
 Time currTime = LastmodiFieddateFromMobile.time();
 
LastmodiFieddateFromMobile = datetime.newinstance(currDate,currTime); 
  system.debug('9999999999999   '+LastmodiFieddateFromMobile);
  
   AllDetails alDetail = new AllDetails();
  List<Id> listOfEvents = new List<Id>();
     for(User_Profile_Event__c upes:[Select u.User_id__c, u.Profile_id__c, u.EV_id__c From User_Profile_Event__c u where User_id__r.userName =:userName and ((EV_id__r.Enable_Scan_To_ATT__c=TRUE and Profile_id__r.PR_Name__c='Attendee') OR (EV_id__r.Enable_Scan_To_BA__c=TRUE and (Profile_id__r.PR_Name__c='BoothAdmin' OR Profile_id__r.PR_Name__c='BoothPersonnel')))]){
        listOfEvents.add(upes.EV_id__c);
     } 
     
      List<Id> listOfEvents1 = new List<Id>();
     
     for(User_Profile_Event__c upes1:[Select u.User_id__c, u.Profile_id__c, u.EV_id__c From User_Profile_Event__c u where User_id__r.userName =:userName and LastModifiedDate>:LastmodiFieddateFromMobile and ((EV_id__r.Enable_Scan_To_ATT__c=TRUE and Profile_id__r.PR_Name__c='Attendee') OR (EV_id__r.Enable_Scan_To_BA__c=TRUE and (Profile_id__r.PR_Name__c='BoothAdmin' OR Profile_id__r.PR_Name__c='BoothPersonnel')))]){
        listOfEvents1.add(upes1.EV_id__c);
     } 
    
    for(Event__c ev:[Select e.EV_HostingZipcode__c,e.Status__c,  e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c,e.StartTime__c, e.EV_HostingStateNew__c, e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingCountryNew__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c,TwitterHashTag__c   From Event__c e where ( Id In : listOfEvents and LastModifiedDate>:LastmodiFieddateFromMobile) OR (Id IN :listOfEvents1)]){
     GlobalUtillClass.EventDetails Gevents = new GlobalUtillClass.EventDetails(ev); 
     alDetail.eventDetails.add(Gevents);
    }
    
      system.debug('444444444444444 '+alDetail);
    
    
    List<AttendeeSummary__c> attSummary = new List<AttendeeSummary__c>();
    string imageUrl;
    attSummary =[select AS_ImageUrl__c from AttendeeSummary__c where AS_Email__c=:userName limit 1];
    if(attSummary.size()>0){
     if(attSummary[0].AS_ImageUrl__c!=null && attSummary[0].AS_ImageUrl__c!=''){
      imageUrl =attSummary[0].AS_ImageUrl__c;
     }
    }  
    
    
      for(user ev:[Select CompanyName,title,city,userName,firstName,lastName,states__c,country__c,phone,Email from user where lastModifieddate>:LastmodiFieddateFromMobile and userName=:userName]){
      GlobalUtillClass.UserDetails Guserss = new GlobalUtillClass.UserDetails(ev,imageUrl,'' ); 
     alDetail.userProfile.add(Guserss);
    }
    
    for(EventSchedule__c eveSc :[Select e.Name, isdeleted,lastmodifiedDate,e.Id, e.EV_id__c,e.EV_id__r.EV_Title__c, e.ES_StartTime__c, e.ES_StartDate__c, e.ES_ProgramName__c, e.ES_Presenter__c, e.ES_Location__c, e.ES_EndTime__c, e.ES_EndDate__c, e.ES_Description__c From EventSchedule__c e where EV_id__c IN :listOfEvents and LastModifiedDate>:LastmodiFieddateFromMobile All rows]){
   
     if(eveSc.isdeleted==true){
     GlobalUtillClass.EventSchedule Geventscdulesdeleted = new GlobalUtillClass.EventSchedule(eveSc); 
        alDetail.EventScheduleDeleted.add(Geventscdulesdeleted);
     } else if(eveSc.lastmodifiedDate>=LastmodiFieddateFromMobile){
     GlobalUtillClass.EventSchedule Geventscdulesupdated = new GlobalUtillClass.EventSchedule(eveSc);   
       alDetail.EventScheduleUpdated.add(Geventscdulesupdated);
     }
    }
  
    
    
    for(Booth__c booths :[Select id,BT_Name__c,BT_Description__c,BT_ContactName__c,BT_ContactEmail__c,BT_ContactPhone__c,BT_WebsiteURL__c,BT_Location__c, BT_PDFLocation__c,BT_RegistrationLink__c,BT_Phone__c,EV_id__c,EV_id__r.EV_Title__c from Booth__c where EV_id__c IN :listOfEvents and LastModifiedDate>:LastmodiFieddateFromMobile]){
     GlobalUtillClass.BoothDetails Gbooths = new GlobalUtillClass.BoothDetails(booths); 
     alDetail.Exhibitors.add(Gbooths);
     }
    
    
    for(BoothVisitSummary__c leadsval :[Select  EA_AttendeeBarcode__r.UniqNo__c, b.User_id__c, b.ScannedTime__c, b.ScanTime__c, b.OwnerId,
   b.Name, b.Mrecordid__c, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.ImageData__c,
   b.Id, b.Follow_Update__c, b.EA_AttendeeBarcode__c, b.Dummy__c, b.CreatedDate, 
    b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c,
   b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c,
   b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c,
   b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c,
   b.BVS_City__c, b.BVS_Budget__c, b.AttachmentId__c, b.AS_ImageUrl__c,EA_AttendeeBarcode__r.EV_id__c,EA_AttendeeBarcode__r.EV_id__r.EV_Title__c From BoothVisitSummary__c b where User_id__r.userName=:userName and LastModifiedDate>:LastmodiFieddateFromMobile ]){
   GlobalUtillClass.Leads Gleads = new GlobalUtillClass.Leads(leadsval);    
   alDetail.leads.add(Gleads);
   }
   return alDetail;
  }
  
  global class AllDetails{
 string lastModifieddate = string.valueOf(system.now());    
List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.EventDetails> eventDetails = new List<GlobalUtillClass.EventDetails>();
List<GlobalUtillClass.EventSchedule> EventScheduleUpdated = new List<GlobalUtillClass.EventSchedule>();
List<GlobalUtillClass.EventSchedule> EventScheduleDeleted = new List<GlobalUtillClass.EventSchedule>();

List<GlobalUtillClass.BoothDetails> Exhibitors = new List<GlobalUtillClass.BoothDetails>();
List<GlobalUtillClass.leads> Leads = new List<GlobalUtillClass.leads>();
}
  
  
}