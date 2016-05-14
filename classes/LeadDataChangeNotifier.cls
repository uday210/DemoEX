@RestResource(urlMapping='/LeadDataChangeNotifier/*')

 global with sharing class LeadDataChangeNotifier{
  global static String UserId;
  global static String eventId;
  global static String requestedDate;
  global static dateTime LastmodiFieddateFromMobile;
  
  @HttpGet
  global static List<innerclass> doGet(){
  
  RestRequest req = RestContext.request;
  RestResponse res = RestContext.response;
  system.debug('5555555555 '+res);  
  UserId= req.params.get('UserId');
  eventId =req.params.get('eventId');
  system.debug('666666666  '+eventId+'2222222 '+UserId);
  LIST<innerclass> inncls = new LIST<innerclass>();
  if(UserId ==''){
  inncls.add(new innerclass('UserId is not valid'));
  }
  
 LastmodiFieddateFromMobile = dateTime.valueOf(string.valueOf(req.headers.get('requestedDate')));
 Date currDate = LastmodiFieddateFromMobile.date();
 Time currTime = LastmodiFieddateFromMobile.time();
 
LastmodiFieddateFromMobile = datetime.newinstance(currDate,currTime); 
  system.debug('9999999999999   '+LastmodiFieddateFromMobile);
 
  List<BoothVisitSummary__c> bvssummary = new List<BoothVisitSummary__c>();

if(eventId !=''){
 system.debug('77777777777   '+LastmodiFieddateFromMobile);
  bvssummary = [Select b.User_id__c, b.ScannedTime__c, b.ScanTime__c, b.OwnerId,
   b.Name, b.Mrecordid__c, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.ImageData__c,
   b.Id, b.Follow_Update__c, b.EA_AttendeeBarcode__c, b.Dummy__c, b.CreatedDate,  
    b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c,
   b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c,
   b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c,
   b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c,
   b.BVS_City__c, b.BVS_Budget__c, b.AttachmentId__c, b.AS_ImageUrl__c,EA_AttendeeBarcode__r.EV_id__c From BoothVisitSummary__c b where User_id__c=:UserId and EA_AttendeeBarcode__r.EV_id__c=:eventId and (createdDate >:LastmodiFieddateFromMobile OR  LastModifiedDate>:LastmodiFieddateFromMobile) ALL ROWS];
     
  } else{
  system.debug('8888888888   '+LastmodiFieddateFromMobile);
   bvssummary = [Select b.User_id__c, b.ScannedTime__c, b.ScanTime__c, b.OwnerId,
   b.Name, b.Mrecordid__c, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.ImageData__c,
   b.Id, b.Follow_Update__c, b.EA_AttendeeBarcode__c, b.Dummy__c, b.CreatedDate, 
    b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c,
   b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c,
   b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c,
   b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c,
   b.BVS_City__c, b.BVS_Budget__c, b.AttachmentId__c, b.AS_ImageUrl__c,EA_AttendeeBarcode__r.EV_id__c From BoothVisitSummary__c b where User_id__c=:UserId  and (createdDate >:LastmodiFieddateFromMobile OR  LastModifiedDate>:LastmodiFieddateFromMobile) ALL ROWS];
   system.debug('000000000000000   '+bvssummary);
  }
 
  set<Id> setOfBVS = new set<Id>(); 
 for(BoothVisitSummary__c bvsList23:bvssummary ){
  setOfBVS.add(bvsList23.id);
 }
 
  List<attachment> lAttach = new  List<attachment>();
  lAttach =[select id,body,parentId  from attachment where parentId IN :setOfBVS];
  map<id,Blob>  mapatt = new map<id,Blob>();
  for(attachment auy:lAttach){
  mapatt.put(auy.ParentId,auy.body);
  }
  
 if(bvssummary.size()<=0){
  inncls.add(new innerclass(null,false,false,false,''));	
 }
 
  for(BoothVisitSummary__c bvsList:bvssummary ){
    boolean deltedvalue=false;
    boolean updatedvalue =false; 
    boolean createdvalue =false; 
     blob bo = mapatt.get(bvsList.id);
    string tre ;
  
     if(bo!=null){
     tre = EncodingUtil.base64Encode(bo); 
    }  
    if(bvsList.isDeleted == true){ 
    deltedvalue =true;
   
    inncls.add(new innerclass(bvsList,deltedvalue,createdvalue,updatedvalue,tre));
   }else  if(bvsList.createdDate>LastmodiFieddateFromMobile){
      createdvalue=true;
    inncls.add(new innerclass(bvsList,deltedvalue,createdvalue,updatedvalue,tre ));
   }else  if(bvsList.lastmodifiedDate>LastmodiFieddateFromMobile){
      updatedvalue =true;
    inncls.add(new innerclass(bvsList,deltedvalue,createdvalue,updatedvalue,tre ));
   }
  
 }
 
 return inncls;
} 



 global class innerclass{
 boolean isDeleted;
 boolean isInserted;
 boolean isUpdated;
 string Barcodeid;
 string lastRequestedOn= string.valueOf(dateTime.now()); 
  
 string NextFollowUpdate ;
  String Event;
 string FollowupTypes ;
 Decimal leadRating ;
 string notes;
 string scannedTime;
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
 String RecordId;
 string Designation;
 
 string SurveyQuestion1;
 string SurveyQuestion2;
 string SurveyQuestion3;
 string SurveyQuestion4;
 string SurveyAnswer1;
 string SurveyAnswer2;
 string SurveyAnswer3;
 string SurveyAnswer4;
 public innerclass(string st){
 error =st;
 }
 
 
 public innerclass(BoothVisitSummary__c innBVS,boolean db,boolean cd,boolean ud,string image){
  isDeleted =db;
  isInserted =cd;
  isUpdated = ud;
  Barcodeid=innBVS.EA_AttendeeBarcode__c;
  PhoneNo =innBVS.BVS_PhoneNumber__c;
  Email =innBVS.BVS_Email__c;
  imageurl =image;
  if(innBVS.Follow_Update__c!=null){
  NextFollowUpdate =String.ValueOF((innBVS.Follow_Update__c).format('yyyy-MM-dd hh:mm:ss a'));
  }else{
  NextFollowUpdate =string.valueOf(innBVS.Follow_Update__c);
  
  }
  
  
  Designation =innBVS.BVS_Title__c;
  FollowupTypes =innBVS.BVS_FollowUps__c;
  leadRating =innBVS.BVS_LeadRating__c;
  notes =innBVS.BVS_Notes__c;
  if(innBVS.ScannedTime__c!=null){
  scannedTime =String.ValueOF(innBVS.ScannedTime__c);
  }
  FirstName=innBVS.BVS_FirstName__c;
  
  LastName=innBVS.BVS_LastName__c;
  Company=innBVS.BVS_Company__c;
  City=innBVS.BVS_City__c;
  State=innBVS.BVS_State__c;
  RecordId = innBVS.Mrecordid__c;
  Event=innBVS.EA_AttendeeBarcode__r.EV_id__c;
  SurveyQuestion1=innBVS.BVS_SurveyQuestion1__c;
  SurveyQuestion2=innBVS.BVS_SurveyQuestion2__c;
  SurveyQuestion3=innBVS.BVS_SurveyQuestion3__c;
  SurveyQuestion4=innBVS.BVS_SurveyQuestion4__c;
  
  SurveyAnswer1=innBVS.BVS_SurveyAnswer1__c;
  SurveyAnswer2=innBVS.BVS_SurveyAnswer2__c;
  SurveyAnswer3=innBVS.BVS_SurveyAnswer3__c;
  SurveyAnswer4=innBVS.BVS_SurveyAnswer4__c;
  
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
       
       
       BoothVisitSummary__c bvssummarytest = new BoothVisitSummary__c (BVS_LastName__c='booth',BVS_FirstName__c='admin',BVS_Email__c='boothadmin@boothleads.com',EA_AttendeeBarcode__c=event_att_map.id,User_id__c=u.id);
      insert bvssummarytest ;
      
      
         System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/LeadDataChangeNotifier';
       RestContext.request.addParameter('UserId', u.Id);
       RestContext.request.addParameter('eventId',eve.Id);
       string datevalue = string.valueOf(system.now()-1);
       system.debug('22222222 '+datevalue );
       RestContext.request.addheader('requestedDate',datevalue );
      
       LeadDataChangeNotifier.doGet();
   

}


}