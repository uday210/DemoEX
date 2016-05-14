@RestResource(urlMapping='/VERIFYLEAD/*')

   /*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : VERIFYLEAD is used to online Lead verification from the server 
 */  

   
   global without sharing class VERIFYLEAD{
    
   global static String EventId;
   global static String UserId;
   global static String QRcode;
   global static Event_Attendee_Mapping__c AtSummary; 
   global static Leads VerifiedLead;
   global static string uniqCode;
  
  @HttpPost
  
  global static Leads doPost(){
  RestRequest req = RestContext.request;
  RestResponse res = RestContext.response;
  
  uniqCode = req.params.get('uniqCode');
  EventId = req.params.get('EventId');
  UserId  = req.params.get('UserId');
  System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@uniqCode  '+uniqCode +' Event Id '+EventId +'     '+UserId);
  
  if( null!=uniqCode  && uniqCode  != ''){ 
       uniqCode = uniqCode.toUpperCase();
    for(Event_Attendee_Mapping__c em : [select id,EA_AttendeeBarcode__c from Event_Attendee_Mapping__c where Ev_id__c=:EventId and UniqNo__c=:uniqCode  ]){
      QRcode  = em.id;
    }
    
   } else{
    System.debug('@@@@@req'+req);
   
    QRcode = req.params.get('QRcode');
    
   }
    
   
    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@QRcode'+QRcode);
    
  try{
  
  List<User_Profile_Event__c> listOfUpe = new  List<User_Profile_Event__c>();
  listOfUpe =[select id, EV_id__r.Event_Type__c from User_Profile_Event__c where EV_id__c=:EventId and User_id__c=:UserId ];
  
   string phone='';
  string city='';
  string state='';
  string country='';
  string homeadd1='';
  string homeadd2='';
  string zip='';
  
  
  if(listOfUpe.size()>0){
  AtSummary = 
  [Select  AS_id__r.AS_FirstName__c,
  AS_id__r.AS_LastName__c,
  AS_id__r.AS_Email__c,
  AS_id__r.AS_Company__c,
  AS_id__r.AS_WorkPhone__c,
  AS_id__r.AS_Title__c,
  AS_id__r.AS_WorkCity__c,
  AS_id__r.AS_Work_States__c,
  id,AS_id__r.AS_ImageUrl__c,
  AS_id__r.AS_Work_Country__c,
  EV_id__r.EV_Title__c ,
  EV_id__r.Event_Type__c,
  AS_id__r.As_Home_Country__c,
  AS_id__r.As_Home_State__c,
  AS_id__r.AS_HomePhone__c,
  AS_id__r.AS_CellPhone__c,
  AS_id__r.AS_HomeZip__c,
  AS_id__r.AS_HomeCity__c,
  AS_id__r.AS_HomeAddress1__c,
  AS_id__r.AS_HomeAddress2__c,
  AS_id__r.AS_WorkZip__c,
  Boothleads_Profile__c,
  EV_id__c, UniqNo__c
  from  Event_Attendee_Mapping__c where  id=:QRcode];
 
   string userProfile ='';
 
   List<User_Profile_Event__c> upes = new List<User_Profile_Event__c>();
   upes =[select id,Profile_id__r.PR_Name__c,User_id__r.Email from User_Profile_Event__c where User_id__r.Email=:AtSummary.AS_Id__r.AS_Email__c and EV_id__c=:AtSummary.EV_id__c];
   if(upes.size()>0){
   userProfile = upes[0].Profile_id__r.PR_Name__c;
   }else{
    userProfile = AtSummary.Boothleads_Profile__c;
   }
 
 
  if(AtSummary.EV_id__r.Event_Type__c=='Consumer Event' && userProfile=='Attendee'){
  
  if(AtSummary.AS_id__r.AS_CellPhone__c!=null){
    phone=AtSummary.AS_id__r.AS_CellPhone__c;
   }else{
     phone=AtSummary.AS_id__r.AS_HomePhone__c;
   }
   
  city=AtSummary.AS_id__r.AS_HomeCity__c;
  state=AtSummary.AS_id__r.As_Home_State__c;
  country=AtSummary.AS_id__r.As_Home_Country__c;
  homeadd1=AtSummary.AS_id__r.AS_HomeAddress1__c;
  homeadd2=AtSummary.AS_id__r.AS_HomeAddress2__c;
  zip=AtSummary.AS_id__r.AS_HomeZip__c;
   
  }else{
    phone=AtSummary.AS_id__r.AS_WorkPhone__c;
   city=AtSummary.AS_id__r.AS_WorkCity__c;
   state=AtSummary.AS_id__r.AS_Work_States__c;
   country=AtSummary.AS_id__r.AS_Work_Country__c;
  
   zip=AtSummary.AS_id__r.AS_WorkZip__c;
 }
  
  
  
  VerifiedLead = new Leads(AtSummary.AS_id__r.AS_FirstName__c,AtSummary.AS_id__r.AS_LastName__c,AtSummary.AS_id__r.AS_Email__c,AtSummary.AS_id__r.AS_Company__c,city,state,phone,AtSummary.AS_id__r.AS_Title__c,AtSummary.id,AtSummary.AS_id__r.AS_ImageUrl__c,country,AtSummary.EV_id__r.EV_Title__c, AtSummary.UniqNo__c);
  system.debug('PPPPPPPPPPPPPPPPPPPPP '+VerifiedLead );
  return VerifiedLead;
  }else{  
    VerifiedLead = new Leads('You are not Registered to this Event');
        return  VerifiedLead; 
 } 
  }
    
 catch(exception ex){
        VerifiedLead = new Leads('Attendee information not found in DB');
        return  VerifiedLead;   
      }
    
   System.debug('Attend Summary'+AtSummary);
   return null;
  }
  
  
  global class Leads{
  
  
  global String Firstname;
  global String LastName;
  global String Email;
  global String  Company;
  global String  City;
  global String State;
  global String PhoneNo;
  global String Title;
  global String  error;
  global String BarcodeId;
  global String ImageUrl;
  global string country;
  global string eventName;
  global string UniqueCode;
  global Leads(String error1){
  if(error1==''){
   error ='null';
   }else{
  error = error1;

  }
  
  }
  
  
  global Leads(String Firstname1,String LastName1,String Email1,String Company1,String City1, String State1,String PhoneNo1,String Title1,String BarcodeId1,String ImageUrl1,String Country1,string eventn, string uc){
  Firstname = Firstname1;
  LastName = LastName1;
  Email = Email1;
  Company = Company1;
  City = City1;
  State = State1;
  PhoneNo = PhoneNo1;
  Title = Title1;
  eventName =eventn;
  UniqueCode = uc;
  string urlbase =URL.getSalesforceBaseUrl().getHost();
  string orgId = UserInfo.getOrganizationId();
  
  BarcodeId = BarcodeId1;
  ImageUrl = 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+ImageUrl1;
  country = country1;
  }
  
  }
  
  /**
  static testMethod void resttest(){
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
       System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/VERIFYLEAD';
       RestContext.request.addParameter('QRcode',eam.id);
       RestContext.request.addParameter('EventId',evebu1.id);
       RestContext.request.addParameter('UserId', bu2.Id);
       VERIFYLEAD.doPost();
  }
 */
 }