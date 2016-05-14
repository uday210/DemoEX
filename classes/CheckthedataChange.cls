@RestResource(urlMapping='/DataChangeNotifier/*')
   /*
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * AIM   : This service is used to send modified,deleted record information  
 */  
 
global with sharing class CheckthedataChange{
  global static String UserId;
  global static String eventId;
  global static String requestedDate;
  global static dateTime LastmodiFieddateFromMobile;
  
  
  global static List<AllObjects> b1= new List<AllObjects>();
  
  global static List<Event_Attendee_Mapping__c>  EAmapping;
  global static List<EventSchedule__c> eventSchedues;
  global static List<Booth__c> Booths;
  global static List<Event__c> Events;
   
  global static String  imageUrlStr = 'https://c.na10.content.force.com/servlet/servlet.ImageServer?oid=00DF0000000BpyH&id=';
  //'https://c.cs5.content.force.com/servlet/servlet.ImageServer?oid=00DO000000097JW&id=';   
  global static List<EventAttendeeClass> td = new List<EventAttendeeClass>();
  global static List<eventschedule> eventSchedulesList =new List<eventschedule>();
  global static List<Boothslist> boothlistedited=new List<Boothslist>();
  global static List<EventsList> Eventslistedited=new List<EventsList>();
   
   
   
@HttpGet
    
global static  List<AllObjects> doGet(){
 RestRequest req = RestContext.request;
 system.debug('444444444 '+req.headers.get('requestedDate'));
 RestResponse res = RestContext.response;
 system.debug('5555555555 '+res);  
 UserId= req.params.get('UserId');
 eventId =req.params.get('eventId');
 
 LastmodiFieddateFromMobile = dateTime.valueOf(string.valueOf(req.headers.get('requestedDate')));
 Date currDate = LastmodiFieddateFromMobile.date();
 Time currTime = LastmodiFieddateFromMobile.time();
 
LastmodiFieddateFromMobile = datetime.newinstance(currDate,currTime); 
 // getLocalDateTime(dateTime.valueOf(string.valueOf(req.headers.get('requestedDate'))));
 system.debug('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'+LastmodiFieddateFromMobile);
 set<Id> setofeventIds =new set<Id>();
  set<Id> setofeventIdsFromUPE =new set<Id>();
// LastmodiFieddateFromMobile =datetime.valueOf(req.headers.get('requestedDate'));


List<user> user = new List<User>();
user =[select id from user where id=:UserId];
if(user.size()<=0){
List<AllObjects> yt = new List<AllObjects>();
string err ='Please verify userId';
AllObjects tre = new AllObjects (err);
yt.add(tre); 
return yt;
}




 if(eventId !=null && eventId !=''){
  setofeventIds.add(eventId);
}else{
  List<User_Profile_Event__c> userevents =new List<User_Profile_Event__c>();
  userevents =[select EV_id__c,CreatedDate from User_Profile_Event__c where User_id__c=:UserId];
    system.debug('zzzzzzzzzzzzzzzzz '+userevents );
   
  for (User_Profile_Event__c ut:userevents ){
   setofeventIds.add(ut.EV_id__c);
   if(ut.createdDate >LastmodiFieddateFromMobile){
   setofeventIdsFromUPE.add(ut.EV_id__c);
   system.debug('uuuuuuuuuuuuuuu  '+setofeventIdsFromUPE);
   }
   
  }
}

   Events =[Select e.SystemModstamp, e.Status__c, e.StartTime__c, e.SecondaryCategory__c, e.Primary__c, e.OwnerId, e.Name, e.LastModifiedDate, e.LastModifiedById, e.LastActivityDate, e.Lable_Third_Line__c, e.Lable_Third_Line_Size__c, e.Lable_Third_Line_Font__c, e.Lable_Third_Line_Color__c, e.Lable_Secoend_Line__c, e.Lable_Secoend_Line_Size__c, e.Lable_Secoend_Line_Font__c, e.Lable_Secoend_Line_Color__c, e.Lable_First_Line__c, e.Lable_First_Line_Size__c, e.Lable_First_Line_Font__c, e.Lable_First_Line_Color__c, e.IsDeleted, e.Id, e.Event_ZipCode__c, e.Event_Printer__c, e.Event_PostalCode__c, e.EventDiversityValues__c, e.Ev_RequiredFields__c, e.EV_WebsiteURL__c, e.EV_Title__c, e.EV_StartDate__c, e.EV_SiteLocation__c, e.EV_RedirectURI__c, e.EV_QuickReg__c, e.EV_Publish__c, e.EV_IncludedFields__c, e.EV_HostingZipcode__c, e.EV_HostingTimeZone__c, e.EV_HostingState__c, e.EV_HostingStateNew__c, e.EV_HostingPostalCode__c, e.EV_HostingPhone__c, e.EV_HostingOrgName__c, e.EV_HostingLocation__c, e.EV_HostingFax__c, e.EV_HostingCountry__c, e.EV_HostingCountryNew__c, e.EV_HostedByEventBrite__c, e.EV_HistingAddr1__c, e.EV_EventLogo__c, e.EV_EndTime__c, e.EV_EndDate__c, e.EV_Description__c, e.EV_CustomReg__c, e.EV_ContactURL__c, e.CreatedDate, e.CreatedById, e.Attendee_Tags__c, e.AS_HostingCity__c, e.AS_HostingAddr2__c From Event__c e where id In :setofeventIds and (createdDate>:LastmodiFieddateFromMobile OR  LastModifiedDate>:LastmodiFieddateFromMobile OR id In :setofeventIdsFromUPE) ALL ROWS];
  system.debug('uuuuuuuuuuuuuuu1111111  '+Events );
   for(Event__c even :Events){
   boolean x=false;
   boolean z =false;
   
   if(even.isdeleted==true){
  z=true;
  }else  if(even.createdDate>LastmodiFieddateFromMobile){
  system.debug('222222222222222  '+LastmodiFieddateFromMobile);
  x=true;
  
   system.debug('666666666666666666666b'+x);
  }else if(even.LastModifiedDate>LastmodiFieddateFromMobile){
  x=true;
  system.debug('222222222222222  '+x);
  }
  
   EventsList eventsedi = new EventsList (even,x,z);
   Eventslistedited.add(eventsedi);
   }


if(eventId !=null && eventId !=''){
EAmapping = [Select createdDate,LastModifiedDate,isdeleted,AS_id__r.LastModifiedDate,AS_id__r.createdDate, AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c,AS_id__r.id,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_WorkState__c,AS_id__r.AS_Title__c,EA_AttendeeBarcode__c from Event_Attendee_Mapping__c where EV_id__c IN :setofeventIds  and (createdDate>:LastmodiFieddateFromMobile OR  AS_id__r.LastModifiedDate>:LastmodiFieddateFromMobile) ALL ROWS];
system.debug('333333333333344444444 '+EAmapping );
for(Event_Attendee_Mapping__c t:EAmapping ){
  // b1 = new UtilljsonParse(t);
  boolean x=false;
  boolean z =false;
  system.debug('rrrrrrrrrrrrrr'+t.createdDate);
  system.debug('tttttttttttttt '+t.LastModifiedDate);
  if(t.isdeleted==true){
  z=true;
  }else  if(t.createdDate>LastmodiFieddateFromMobile){
   system.debug('222222222222222  '+LastmodiFieddateFromMobile);
   x=true;
   system.debug('666666666666666666666b'+x);
  }else if(t.AS_id__r.LastModifiedDate>LastmodiFieddateFromMobile){
  x=true;
  
  }
      
  EventAttendeeClass fd = new EventAttendeeClass(t,x,z);
  // listOfattendees.add(b1);
  td.add(fd);
   }
   

   eventSchedues =[Select  e.Name, e.LastModifiedDate,e.IsDeleted, e.Id, e.EV_id__c, e.ES_StartTime__c, e.ES_StartDate__c, e.ES_ProgramName__c, e.ES_Presenter__c, e.ES_Location__c, e.ES_EndTime__c, e.ES_EndDate__c, e.ES_Description__c, e.CreatedDate, e.CreatedById From EventSchedule__c e where EV_id__c IN :setofeventIds AND (createdDate>:LastmodiFieddateFromMobile OR  LastModifiedDate>:LastmodiFieddateFromMobile) ALL ROWS];  
   for(EventSchedule__c  tr :eventSchedues ){
   boolean x=false;
   boolean z =false;
  
  if(tr.isdeleted==true){
  z=true;
  }else  if(tr.createdDate>LastmodiFieddateFromMobile){
  system.debug('222222222222222  '+LastmodiFieddateFromMobile);
  x=true;
   
  }else if(tr.LastModifiedDate>LastmodiFieddateFromMobile){
 x=true;
 
  }
   eventschedule sfc= new eventschedule(tr,x,z);
   eventSchedulesList.add(sfc);
   }
   
   
   Booths =[Select b.createddate,b.isdeleted,b.Name, b.LastModifiedDate, b.Id, b.EV_id__c, b.BT_isBoothActive__c, b.BT_WebsiteURL__c, b.BT_RegistrationLink__c, b.BT_Phone__c, b.BT_PDFLocation__c, b.BT_Name__c, b.BT_Location__c, b.BT_Description__c, b.BT_ContactPhone__c, b.BT_ContactName__c, b.BT_ContactEmail__c, b.BT_BoothUserCount__c, b.BLP_id__c From Booth__c b where EV_id__c IN :setofeventIds and (createdDate>:LastmodiFieddateFromMobile OR  LastModifiedDate>:LastmodiFieddateFromMobile) ALL ROWS];
   for(booth__c bo :Booths){
    boolean x=false;
    boolean z =false;
   if(bo.isdeleted==true){
  z=true;
  }else  if(bo.createdDate>LastmodiFieddateFromMobile){
  system.debug('222222222222222  '+LastmodiFieddateFromMobile);
 //y=true;
 x=true;
   system.debug('666666666666666666666b'+x);
  }else if(bo.LastModifiedDate>LastmodiFieddateFromMobile){
 x=true;
 
  }
   Boothslist boothValue = new Boothslist(bo,x,z);
   boothlistedited.add(boothValue);
   
   }
    }
  
      
   b1.add(new AllObjects(td,eventSchedulesList,boothlistedited,Eventslistedited)) ;
   system.debug('geeeeeeeeeeeeeeeeeeeeeeeeeeeee '+b1);
  return b1;

 
 }
 
 
 
 
 global class AllObjects{
  List<EventAttendeeClass> allEventAttendees;
   List<EventsList> listOfEvents;
   List<Boothslist> listOfbooths;
   List<eventschedule> eventschedule ;
   string Error;
   string dtime;
   
   public AllObjects(List<EventAttendeeClass> v,List<eventschedule> sc,List<Boothslist> boo,List<EventsList> eve){
   allEventAttendees = v;
   listOfbooths =boo;
   eventschedule =sc;
   listOfEvents = eve;
  dtime =string.valueOf(dateTime.now());
   system.debug('9999999999999 Phani '+dateTime.now());
  }
  
  public AllObjects(string err){
  error=err; 
  }
  }
  
  
global class EventsList{
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

boolean  isInserted;
boolean isdeleted ;


public EventsList(Event__c ev,boolean tt,boolean pp){
Event_ID =ev.Id;
Event_Name=ev.EV_Title__c;
Event_StartDate=ev.EV_StartDate__c;
Event_StartHour=ev.StartTime__c;
Event_EndHour=ev.EV_EndTime__c;
Event_Location=ev.EV_HostingLocation__c;
EventLogoImageURL='https://c.cs5.content.force.com/servlet/servlet.ImageServer?oid=00DO000000097JW&id='+ev.EV_EventLogo__c;
Status=ev.Status__c;
Event_Date=ev.EV_EndDate__c;
Event_Description=ev.EV_Description__c;
HostingAddr1=ev.EV_HistingAddr1__c;
HostingAddr2=ev.AS_HostingAddr2__c;
HostingCity=ev.AS_HostingCity__c;
HostingState=ev.EV_HostingStateNew__c;
HostingCountry=ev.EV_HostingCountryNew__c;
HostingZipcode=ev.EV_HostingZipcode__c;
HostingPhone=ev.EV_HostingPhone__c;
isInserted =tt;
 isdeleted =pp;

}

}  
 
global class Boothslist{
string Booth_ContactEmail;
string Booth_ContactName;
string Booth_ContactPhone;
string Booth_Description;
string Booth_Location;
string Booth_Name;
string Booth_Phone;
Id Booth_BLP_id;
string Booth_RegistrationLink;
string Booth_WebsiteURL;

boolean  isInserted;
boolean isdeleted ;
Id boothId;
 public Boothslist(Booth__c b,boolean tt,boolean pp){
 boothId=b.Id;
Booth_ContactEmail =b.BT_ContactEmail__c;
Booth_ContactName =b.BT_ContactName__c;
Booth_ContactPhone=b.BT_ContactPhone__c;
Booth_Description=b.BT_Description__c;
Booth_Location=b.BT_Location__c;

Booth_Name=b.BT_Name__c;
Booth_Phone=b.BT_Phone__c;
Booth_BLP_id=b.BLP_id__c;
Booth_RegistrationLink=b.BT_RegistrationLink__c;
Booth_WebsiteURL=b.BT_WebsiteURL__c;
 isInserted =tt;
 isdeleted =pp;
 }
 
 }
 
 
 
 global class eventschedule{
  string Eventschedule_Description;
  Date Eventschedule_EndDate;
  string Eventschedule_EndTime;
  string Eventschedule_Location;
  string Eventschedule_Presenter;
  string Eventschedule_ProgramName;
  Date Eventschedule_StartDate;
  string Eventschedule_StartTime;
  Id ScheduleID;
  
     boolean  isInserted;
     boolean isdeleted ;     
   public eventschedule(EventSchedule__c ES,boolean tt,boolean pp){  
   ScheduleID= ES.Id;
    Eventschedule_Description =ES.ES_Description__c;
    Eventschedule_EndDate =ES.ES_EndDate__c;
    Eventschedule_EndTime =ES.ES_EndTime__c;
    Eventschedule_Location =ES.ES_Location__c;
    Eventschedule_Presenter =ES.ES_Presenter__c;
    Eventschedule_ProgramName =ES.ES_ProgramName__c;
    Eventschedule_StartDate =ES.ES_StartDate__c;
    Eventschedule_StartTime =ES.ES_StartTime__c;
    isInserted =tt;
    isdeleted =pp;
  }
 
 }
 
 
 
 global class EventAttendeeClass {
     Id AttendeeId;
     string attbarcode;
     String FirstName;
     String LastName;
     String Company;
     String City;
     String State;
     String PhoneNo;
     String Email;
     String message;
     String error;
     String ImageUrl;
     String Country;
     string statusofrecord;
     boolean  isInserted;
     boolean isdeleted ;
     string designation; 
      
      
  public EventAttendeeClass(Event_Attendee_Mapping__c EATM,boolean tt,boolean pp){
  AttendeeId=EATM.Id;
  designation =EATM.AS_id__r.AS_Title__c;
  attbarcode =EATM.EA_AttendeeBarcode__c;
  FirstName=EATM.AS_id__r.AS_FirstName__c;
  LastName =  EATM.AS_id__r.AS_LastName__c;
  Company =EATM.AS_id__r.AS_Company__c;
  City = EATM.AS_id__r.AS_WorkCity__c;
  State =EATM.AS_id__r.AS_WorkState__c;
  PhoneNo=EATM.AS_id__r.AS_WorkPhone__c;
  Email=EATM.AS_id__r.AS_Email__c;
  String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
  String orgId = UserInfo.getOrganizationId();
  String  Imageheader =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id=';
  ImageUrl=Imageheader+EATM.AS_id__r.AS_ImageUrl__c; 
  Country=EATM.AS_id__r.AS_Work_Country__c;
  isInserted =tt;
  isdeleted =pp;
  }
 
 }
 
 
 static testMethod void testRest(){
 
 contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
       insert m;
       Profile w = [select id from profile where name='Standard User'];
       user u= new User(alias = 'busers', email='boothadmin@boothleads.com',
       emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
       localesidkey='en_US',country='United States',
       timezonesidkey='America/Los_Angeles', username='boothadmin@boothleads.com',CompanyName='Nest',Title='dev');
       insert u;
       System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
       u.password__c =rt.getPassword();
   
       update u;
       string pwd =rt.getPassword();
      
            
       AttendeeSummary__c attsum = new AttendeeSummary__c(AS_FirstName__c='phani',AS_LastName__c='Testing',AS_Email__c='boothadmin@boothleads.com');
       insert attsum ;
      
       Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
       EV_EndDate__c = Date.Parse('01/18/2014'),
       EV_StartDate__c = Date.Parse('01/18/2014'),
       EV_EndTime__c='09:00 AM',
       StartTime__c='11:00 AM');
       insert eve;
      
       string attendeeEvent= string.valueOf(attsum.Id)+string.valueOf(eve);
      
       Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=eve.Id,AS_id__c=attsum.Id);
       insert event_att_map ;
      
    
      EventSchedule__c es = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', ES_EndDate__c = Date.Parse('01/18/2014'),
                                                ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                ES_Description__c='Hello Test Desc', ES_EndTime__c='09:30 AM', ES_Location__c='Hello Loc', 
                                                ES_Presenter__c ='Arjun', EV_id__c =eve.id );
    
    insert es;
      
       Booth__c booth2 = new Booth__c(EV_id__c=eve.id,BT_Name__c='TestBoothup2',BT_BoothUserCount__c=100);
    insert booth2;
      
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/DataChangeNotifier';
       RestContext.request.addParameter('UserId', u.Id);
       RestContext.request.addParameter('eventId',eve.Id);
       string datevalue = string.valueOf(system.now()-1);
       system.debug('22222222 '+datevalue );
       RestContext.request.addheader('requestedDate',datevalue );
      
       CheckthedataChange.doGet();
   
    delete eve;
    delete es;
    delete event_att_map;
    delete booth2;
 CheckthedataChange.doGet();
 }
 
 
 
 
}