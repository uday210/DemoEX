@RestResource(urlMapping='/DATAREADY/*')
   
   
   /*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : DataRready Service is used for Server continuous Polling
 *         to be servival from pushNotifications   
 */  
   
   
   global with sharing class DATAREADY{
   global static String EventId;
   global static String UserId;
   global static Integer AttCount;
   global static Integer ExtCount;
   global static DataReadyRes Datares1;
   global static List<Booth> Booth1 = new List<Booth>();  
   global static List<EventSchedule2> EventSchedule3;
   global static List<Event_Attendee_Mapping__c> EM;
   global static List<Booth__c> Booth6;
   global static List<EventSchedule__c> EventSchedule1;
   global static List<Event_Attendee_Mapping__c>  EAmapping;
   global static List<AttendeeDetails1> AD1 = new List<AttendeeDetails1>(); 
   
   global static String orgId = UserInfo.getOrganizationId();
    global static String sfdcBaseURL = URL.getSalesforceBaseUrl().toExternalForm();
    
   global static String  imageUrlStr =sfdcBaseURL +'/servlet/servlet.ImageServer?oid='+orgId+'&id=';
    
   //global static String  imageUrlStr = 'https://c.cs5.content.force.com/servlet/servlet.ImageServer?oid=00DO000000097JW&id='; 
     
   @HttpGet
    
    global static DataReadyRes  doGet(){
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    EventId = req.params.get('EventId');
    UserId= req.params.get('UserId');
    system.debug('11111111111111 '+EventId+' '+UserId);
    AttCount= Integer.ValueOf(req.params.get('AttCount'));
    ExtCount= Integer.ValueOf(req.params.get('ExtCount'));
    Datares1= new DataReadyRes();
    EventSchedule1 = [Select id,ES_Description__c,ES_EndDate__c,ES_EndTime__c,ES_Location__c,ES_Presenter__c,ES_ProgramName__c,ES_StartDate__c,ES_StartTime__c
                                   From EventSchedule__c where EV_id__r.id =:EventId order by id];
   if(EventSchedule1.size() == 0){
            EventSchedule2 ES2 = new EventSchedule2('The Schdule is in Progress!');
            Datares1.Esc.add(ES2);
         }
    
        
    For(EventSchedule__c ES:EventSchedule1){
        EventSchedule2 ES2 = new EventSchedule2(ES.ES_ProgramName__c,ES.ES_Description__c,ES.ES_Location__c,ES.ES_Presenter__c,ES.ES_StartDate__c,ES.ES_EndDate__c,ES.ES_StartTime__c,ES.ES_EndTime__c,ES.id);
        Datares1.Esc.add(ES2);
       }
     
    List<User_Profile_Event__c> ListOfusers = new List<User_Profile_Event__c>(); 
     SET<id> setOfbooths = new SET<id>();
     ListOfusers =[select BT_id__c,BT_id__r.id from User_Profile_Event__c where EV_id__c=:EventId ];
     for(User_Profile_Event__c UPES:ListOfusers){
     setOfbooths.add(UPES.BT_id__r.id); 
     }
     
     
  List<Booth__c> booth2 =[Select id,BT_Name__c,BT_Description__c,BT_ContactName__c,BT_ContactEmail__c,BT_ContactPhone__c,BT_WebsiteURL__c,BT_Location__c, BT_PDFLocation__c,BT_RegistrationLink__c,BT_Phone__c from Booth__c where ID IN :setOfbooths and  BT_isBoothActive__c=true Order by id OFFSET :ExtCount];
    
     
  //  List<Booth__c> booth2 =[Select id,BT_Name__c,BT_Description__c,BT_ContactName__c,BT_ContactEmail__c,BT_ContactPhone__c,BT_WebsiteURL__c,BT_Location__c, BT_PDFLocation__c,BT_RegistrationLink__c,BT_Phone__c from Booth__c where EV_id__r.id=:EventId AND BT_isBoothActive__c=true Order by id OFFSET :ExtCount];
 
    system.debug('2222222222222  '+booth2);
   For(Booth__c Bo :booth2){
    Booth b2 = new Booth(BO.id,Bo.BT_Name__c,Bo.BT_Description__c,Bo.BT_ContactName__c,Bo.BT_ContactPhone__c,Bo.BT_ContactEmail__c,BO.BT_WebsiteURL__c,Bo.BT_Location__c,Bo.BT_PDFLocation__c,Bo.BT_RegistrationLink__c,Bo.BT_Phone__c);
    Datares1.booth5.add(b2);        
   }
  EAmapping = [Select AS_id__r.AS_Work_States__c,AS_id__r.AS_Work_Country__c,AS_id__r.id,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_Email__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_WorkState__c,AS_id__r.AS_Title__c,EA_AttendeeBarcode__c from Event_Attendee_Mapping__c where EV_id__r.id=:EventId Order by AS_id__r.id OFFSET :AttCount];
  
    system.debug('33333333333333333   '+EAmapping);
   For(Event_Attendee_Mapping__c EAM :EAmapping  ){
   AttendeeDetails1 at1 = new AttendeeDetails1(EAM.AS_id__r.id,imageUrlStr+EAM.AS_id__r.AS_ImageUrl__c,EAM.AS_id__r.AS_FirstName__c,EAM.AS_id__r.AS_LastName__c,EAM.AS_id__r.AS_Company__c,EAM.AS_id__r.AS_Email__c,EAM.AS_id__r.AS_WorkPhone__c,EAM.AS_id__r.AS_WorkCity__c,EAM.AS_id__r.AS_Work_States__c,EAM.EA_AttendeeBarcode__c,EAM.id,EAM.AS_id__r.AS_Title__c,EAM.AS_id__r.AS_Work_Country__c);
   Datares1.Atd1.add(at1); }
   return Datares1; 
 }
    
   global class  DataReadyRes{
   List<EventSchedule2>  Esc;
   List<AttendeeDetails1> Atd1;
   List<Booth> booth5;
   string serviceRequestedOn {get;set;}
   global DataReadyRes(){
   Esc = new List<EventSchedule2>();
   Atd1 = new List<AttendeeDetails1>();
   booth5 = new List<Booth>();
   serviceRequestedOn =string.valueOf(system.Now());
   }
   
   
   } 
   
   global class AttendeeDetails1{
    
    ID Attendee_QR_ID;
    String Image_URL;
    String FirstName;
    String LastName;
    String Company;
    String Email;
    String PhoneNo;
    String City;
    String State;
    String Country;
    String message;
   String barcode;
   String barcodeId;
   String Title;
   
   global AttendeeDetails1( ID Attendee_QR_ID1,String Image_URL1, String  FirstName1, String  LastName1,String Company1,String Email1, String PhoneNo1,String City1,String State1,String barcode1,String barcodeId1,String Title1,String Country1){
   
   Attendee_QR_ID = Attendee_QR_ID1;
   Image_URL = Image_URL1;
   FirstName = FirstName1;
   LastName = LastName1;
   Company = Company1;
   Email = Email1;
   PhoneNo = PhoneNo1;
   City = City1;
   State = State1;
   barcode = barcode1;
   barcodeId = barcodeId1;
   Title = Title1;
   Country = Country1;
   }
   
   
   global AttendeeDetails1(String message1){
   message = message1;}}
    
    
    global class Booth{
    Id Booth_ID;
    String Booth_Name;
    String Booth_Description;
    String Booth_ContactName;
    String Booth_ContactPhoneNo;
    String Booth_ContactEmail;
    String Booth_Website;
    String Message;
    String Booth_Location;
    String Booth_PdfLocationLink; 
    String Booth_RegistrationLink;
    String Booth_Phone;
    global Booth(String Message1){
    Message = Message1;
    }
    
    
    global Booth(Id Booth_ID1, String Booth_Name1, String Booth_Description1, String Booth_ContactName1,String Booth_ContactPhoneNo1,String Booth_ContactEmail1,String Booth_Website1,String Booth_Location1,String Booth_PdfLocationLink1,String Booth_RegistrationLink1,String Booth_Phone1){
    Booth_ID = Booth_ID1;
    Booth_Name = Booth_Name1;
    Booth_Description = Booth_Description1;
    Booth_ContactName = Booth_ContactName1;
    Booth_ContactPhoneNo = Booth_ContactPhoneNo1;
    Booth_ContactEmail = Booth_ContactEmail1;
    Booth_Website = Booth_Website1;
    Booth_Location= Booth_Location1;
    Booth_PdfLocationLink = Booth_PdfLocationLink1;
    Booth_RegistrationLink =  Booth_RegistrationLink1;
    Booth_Phone = Booth_Phone1;
   }}
 
 
  global class EventSchedule2{
        global string Message;
        global String ProgramName;
        global String Description;
        global  String Location;
        global String Presenter;
        global Date StartDate;
        global Date EndDate;
        global String StartTime;
        global String EndTime;
        global id scheduleId;
        global EventSchedule2(String Message1){
            Message= Message1;
        }
        
        
        global EventSchedule2(String ProgramName1,String Description1,String Location1,String Presenter1,Date StartDate1,Date EndDate1,String StartTime1,String EndTime1,id scheduleId1){
            
            ProgramName = ProgramName1;
            Description = Description1;
            Location  = Location1;
            Presenter = Presenter1; 
            StartDate = StartDate1;
            EndDate  =   EndDate1;
            StartTime =  StartTime1;
            EndTime   =  EndTime1;
            scheduleId = scheduleId1;
            } }
            
            
            
          static testMethod void testrest(){
          Profile w = [select id from profile where name='Standard User'];
   user bu2 =  new User(alias = 'busers', email='buser2@badmin.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='buser2@badmin.com',CompanyName='Nest',Title='dev');
                  insert bu2;
           Event__c evebu1 = new Event__c(EV_Title__c='Global evebu1 ',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert evebu1 ;
      AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='buser@badmin.com');
     insert attSummarybp;
     Event_Attendee_Mapping__c eam =new Event_Attendee_Mapping__c(AS_id__c=attSummarybp.id,EV_id__c=evebu1.id);
      insert eam;
          EventSchedule__c ESh =new EventSchedule__c(EV_id__c=evebu1.id);
          insert ESh;
          Booth__c booth =new Booth__c(BT_Name__c='globalnest',BT_ContactName__c='phani',BT_ContactEmail__c='phani@globalnest.com',EV_id__c=evebu1.id,BT_isBoothActive__c=true);
          insert booth;
          System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/DATAREADY';
     
       RestContext.request.addParameter('EventId',evebu1.id);
       RestContext.request.addParameter('UserId', bu2.Id);
       RestContext.request.addParameter('AttCount', '0');
       RestContext.request.addParameter('ExtCount', '0');
          DATAREADY.doGet();
          
          }  
            
            
            
            }