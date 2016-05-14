@RestResource(urlMapping='/LoadMoreData/*')

global without sharing class LoadMoreData {
  
  global static string userName{get;set;}
  global static string eventId{get;set;}
  
  
 @httpPost
  global static AllDetails doPost(){
   RestRequest req =Restcontext.request;
   RestResponse res =Restcontext.response;
   integer recordIndex=0;
    string lastRecordId;
   
     userName =req.params.get('UserName');
     eventId = req.params.get('EventId');
     lastRecordId = req.params.get('lastRecordId');
      AllDetails alDetail = new AllDetails();
   //MAP<string,integer> mapValueWithInt = new MAP<string,integer>();
    integer i =1;
    
    List<BoothVisitSummary__c> bvsValues = new List<BoothVisitSummary__c>();
  
    Set<id> bvsids = new Set<id>();
    
  if(eventId !='' && eventId !=null){
    for(User_Event_BVS__c bvslist:[Select Id,BVS_id__r.id,EV_id__c,   UPE_id__c,UPE_id__r.User_id__r.userName  from User_Event_BVS__c where  UPE_id__r.User_id__r.userName=:userName and UPE_id__r.EV_id__c=:eventId]){
      bvsids.add(bvslist.BVS_id__r.id); 
    }
  }  else{
   for(User_Event_BVS__c bvslist:[Select Id,BVS_id__r.id,EV_id__c,   UPE_id__c,UPE_id__r.User_id__r.userName  from User_Event_BVS__c where  UPE_id__r.User_id__r.userName=:userName ]){
      bvsids.add(bvslist.BVS_id__r.id); 
    }
  }
    
    
   
    bvsValues = [Select   b.User_id__c, b.ScannedTime__c, b.ScanTime__c, b.OwnerId,
    b.Name, b.Mrecordid__c, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.ImageData__c,
    b.Id, b.Follow_Update__c, b.EA_AttendeeBarcode__c, b.Dummy__c, b.CreatedDate, 
    b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c,
    b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c,
    b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c,
    b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c,
    b.BVS_City__c, b.BVS_Budget__c, b.AttachmentId__c,EA_AttendeeBarcode__r.UniqNo__c, b.AS_ImageUrl__c,EA_AttendeeBarcode__r.EV_id__c,EA_AttendeeBarcode__r.EV_id__r.EV_Title__c From BoothVisitSummary__c b where Id IN:bvsids and EA_AttendeeBarcode__c!=null  order by createdDate];
   
   
   
    for(BoothVisitSummary__c leadsval :bvsValues ){
     if(leadsval.Mrecordid__c==lastRecordId){
        recordIndex =i;
      }
    i++;
   
 }
  
  integer countValue=0;
  
   if(recordIndex+20 < bvsValues.size()){
    countValue =recordIndex+20;
   }else{
     if(bvsValues.size()>1){
     countValue =bvsValues.size()-1;
     }
   }
  
  system.debug('1111111111 '+recordIndex  +'33333333333 '+countValue );
  
   for(integer a=recordIndex;a<=countValue ;a++){
    if(bvsValues.size()>0){
    GlobalUtillClass.Leads Gleads = new GlobalUtillClass.Leads(bvsValues[a]);    
      alDetail.leads.add(Gleads); 
       system.debug('5555555555555555555555 '+ Gleads); 
    }
   }
   
   if(bvsValues.size()>0){
    alDetail.lastRecordId = bvsValues[countValue].Mrecordid__c;
    }
  
    
  return alDetail;  
  }
   
   
   
global class AllDetails{
string lastRecordId ;
List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.EventDetails> eventDetails = new List<GlobalUtillClass.EventDetails>();
List<GlobalUtillClass.EventSchedule> EventSchedule = new List<GlobalUtillClass.EventSchedule>();
List<GlobalUtillClass.BoothDetails> Exhibitors = new List<GlobalUtillClass.BoothDetails>();
List<GlobalUtillClass.leads> Leads = new List<GlobalUtillClass.leads>();
}  
   

}