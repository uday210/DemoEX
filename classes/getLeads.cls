@Restresource(urlMapping='/getLeads/*')

   /*
   * 
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : getLeads is for getting Gathered Leads Information 
 */  

global with sharing class getLeads{


global static list<BoothVisitSummary__c> BoothSummaryNew = new List<BoothVisitSummary__c>();
 
global static List<Boothlead> bleads = new List<Boothlead>();

global static User_Profile_Event__c UPE;

global static List<User_Event_BVS__c> UserBVS = new List<User_Event_BVS__c>(); 

global static Map<Id,String> BlobMap = new  Map<Id,String>();

global static Set<Id> BvsIds = new  Set<Id>();

//global static List<Attachment> retrivalAttachs = new  List<Attachment>();
global static Attachment retrivalAttach = new  Attachment();

@HttpPost


global static List<Boothlead> doPost(){
    
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    
    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@req'+req);
    
    String userId = req.params.get('UserId');
   
    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@userId'+userId );
   
    String eventId = req.params.get('EventId');
    
    System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@eventId '+eventId);
   
  if(EventId !=''){
    
    
      UserBVS  = [Select BVS_id__r.EA_AttendeeBarcode__c,BVS_id__r.BVS_Budget__c,BVS_id__r.BVS_City__c,BVS_id__r.BVS_Company__c,BVS_id__r.BVS_Email__c,BVS_id__r.BVS_FirstName__c,BVS_id__r.BVS_LastName__c,BVS_id__r.BVS_LeadCategory__c,BVS_id__r.BVS_LeadRating__c,BVS_id__r.BVS_LeadType__c,BVS_id__r.Mrecordid__c,
    
                BVS_id__r.BVS_Notes__c, BVS_id__r.BVS_FollowUps__c,BVS_id__r.BVS_PhoneNumber__c,BVS_id__r.BVS_State__c,BVS_id__r.BVS_SurveyAnswer1__c,BVS_id__r.BVS_SurveyAnswer2__c,BVS_id__r.BVS_SurveyAnswer3__c,BVS_id__r.BVS_SurveyAnswer4__c,BVS_id__r.BVS_SurveyQuestion1__c,BVS_id__r.BVS_SurveyQuestion2__c,BVS_id__r.BVS_SurveyQuestion3__c,
                
                BVS_id__r.ScanTime__c,EV_id__c,BVS_id__r.AS_ImageUrl__c,BVS_id__r.BVS_SurveyQuestion4__c,BVS_id__r.Follow_Update__c,BVS_id__r.BVS_Tags__c,BVS_id__r.BVS_Title__c,BVS_id__r.EA_AttendeeBarcode__r.EA_AttendeeBarcode__c,EV_id__r.EV_Title__c from User_Event_BVS__c where EV_id__c=:eventId  and BVS_id__r.User_id__r.id=:userId and BVS_id__r.EA_AttendeeBarcode__c!=null]; 
    
    
  }
    
    else{
        
        
          UserBVS  = [Select BVS_id__r.EA_AttendeeBarcode__c,BVS_id__r.BVS_Budget__c,BVS_id__r.BVS_City__c,BVS_id__r.BVS_Company__c,BVS_id__r.BVS_Email__c,BVS_id__r.BVS_FirstName__c,BVS_id__r.BVS_LastName__c,BVS_id__r.BVS_LeadCategory__c,BVS_id__r.BVS_LeadRating__c,BVS_id__r.BVS_LeadType__c,BVS_id__r.Mrecordid__c,
    
                    BVS_id__r.BVS_Notes__c, BVS_id__r.BVS_FollowUps__c,BVS_id__r.BVS_PhoneNumber__c,BVS_id__r.ScanTime__c,BVS_id__r.BVS_State__c,BVS_id__r.BVS_SurveyAnswer1__c,BVS_id__r.BVS_SurveyAnswer2__c,BVS_id__r.BVS_SurveyAnswer3__c,BVS_id__r.BVS_SurveyAnswer4__c,BVS_id__r.BVS_SurveyQuestion1__c,BVS_id__r.BVS_SurveyQuestion2__c,BVS_id__r.BVS_SurveyQuestion3__c,
                
                   EV_id__c,BVS_id__r.AS_ImageUrl__c,BVS_id__r.BVS_SurveyQuestion4__c,BVS_id__r.Follow_Update__c,BVS_id__r.BVS_Tags__c,BVS_id__r.BVS_Title__c,BVS_id__r.EA_AttendeeBarcode__r.EA_AttendeeBarcode__c,EV_id__r.EV_Title__c from User_Event_BVS__c where  BVS_id__r.User_id__r.id=:userId and BVS_id__r.EA_AttendeeBarcode__c!=null]; 
    
      for(User_Event_BVS__c  UserBVS1:UserBVS){
       BvsIds.add(UserBVS1.BVS_id__r.id); 
      
      }
        System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@BvsIds'+BvsIds);
    
       // retrivalAttach  = [Select id,Body, ParentId from Attachment where ID in BvsIds];
        
        For (Attachment retrivalAttach1 : [Select id,Body, ParentId from Attachment where ParentId IN:BvsIds]){
                   
                  BlobMap.put(retrivalAttach1.ParentId,EncodingUtil.base64Encode(retrivalAttach1.Body));
    
      }
   
      System.debug('@@@@@@@@@@@@@@@@@@@@@@@@BlobMap'+BlobMap);
   
    }
  
   
     System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@UserBVS'+UserBVS);
   

     
   for(User_Event_BVS__c UEBC:UserBVS){
   
   
   Boothlead Blead = new Boothlead();
   Blead.eventTile =UEBC.EV_id__r.EV_Title__c;
   
   Blead.leadRating = String.ValueOf(UEBC.BVS_id__r.BVS_LeadRating__c);
  
   Blead.Barcodeid = UEBC.BVS_id__r.EA_AttendeeBarcode__c;
   
   Blead.Barcode = UEBC.BVS_id__r.EA_AttendeeBarcode__r.EA_AttendeeBarcode__c; 
   
   Blead.Designation = UEBC.BVS_id__r.BVS_Title__c;
   
   Blead.state= UEBC.BVS_id__r.BVS_State__c;
   
   Blead.Phone = UEBC.BVS_id__r.BVS_PhoneNumber__c;
   
   Blead.Notes = UEBC.BVS_id__r.BVS_Notes__c ;
   
   Blead.LeadCategory = UEBC.BVS_id__r.BVS_LeadCategory__c;
   
   Blead.Lastname = UEBC.BVS_id__r.BVS_LastName__c;
   
   Blead.Firstname= UEBC.BVS_id__r.BVS_FirstName__c;
   
   Blead.Email = UEBC.BVS_id__r.BVS_Email__c;
   
   Blead.City = UEBC.BVS_id__r.BVS_City__c;
   
   Blead.RecordId = UEBC.BVS_id__r.Mrecordid__c;
   
   Blead.Company = UEBC.BVS_id__r.BVS_Company__c;
   if(UEBC.BVS_id__r.Follow_Update__c!=null){
   system.debug('33333333333333 '+UEBC.BVS_id__r.Follow_Update__c);
   Blead.NextFollowUpdate = String.ValueOF((UEBC.BVS_id__r.Follow_Update__c).format('yyyy-MM-dd hh:mm:ss a'));
   system.debug('4444444444444444444 '+Blead.NextFollowUpdate);
   }else{
    Blead.NextFollowUpdate = String.ValueOF((UEBC.BVS_id__r.Follow_Update__c));
   
   }
   
   
   
   Blead.SurveyAnswer1 = UEBC.BVS_id__r.BVS_SurveyAnswer1__c;
    
   Blead.SurveyAnswer2 = UEBC.BVS_id__r.BVS_SurveyAnswer2__c;
    
   Blead.SurveyAnswer3 = UEBC.BVS_id__r.BVS_SurveyAnswer3__c;
     
   Blead.SurveyAnswer4 = UEBC.BVS_id__r.BVS_SurveyAnswer4__c;
      
      
      Blead.SurveyQuestion1= UEBC.BVS_id__r.BVS_SurveyQuestion1__c ;   
       
      Blead.SurveyQuestion2= UEBC.BVS_id__r.BVS_SurveyQuestion2__c ;
        
      Blead.SurveyQuestion3 = UEBC.BVS_id__r.BVS_SurveyQuestion3__c;
        
        Blead.SurveyQuestion4= UEBC.BVS_id__r.BVS_SurveyQuestion4__c;
          
           Blead.FollowupTypes = UEBC.BVS_id__r.BVS_FollowUps__c;
           
           Blead.imageUrl= UEBC.BVS_id__r.AS_ImageUrl__c;
           
           Blead.EventId =  UEBC.EV_id__c;
           Blead.lastRequestedOn =string.valueOf(dateTime.now());
              Blead.ScanTime = String.ValueOf(UEBC.BVS_id__r.ScanTime__c);      
              if(! (String.isEmpty(BlobMap.get(UEBC.BVS_id__r.id)))){
              Blead.ImageBlob=  BlobMap.get(UEBC.BVS_id__r.id);
           }
            System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@bleads'+Blead);
        
        bleads.add(Blead);
        
          
  
   }
   
   
   System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@bleads'+bleads);
   
      System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@bleads'+bleads.size());
  
    // ResponseMessage resMessage = new ResponseMessage('Success');
     
    // return resMessage; 
    
   return bleads;
    
}

global class Boothlead{
    
    
   String lastRequestedOn;
    
    String Barcodeid;
    string eventTile ;

    
    String BoothPersonnelId;
    
    //String Userid;

    String imageUrl;
   
    String AttendeeId;
    
    String Firstname;
    
    String Lastname;
    
    String Email;
    
    String Company;
    
    String Designation;
    
    String Phone;
    
    String Notes;
    
    String City;
    
    String state;
    
    String leadRating;
    
    String leadId;
    
    String NumberOfVisits;
    
    String FollowupTypes;
    
    String NextFollowUpdate;
    
    //String rating;
    
   // String notes;
    
    String LeadCategory;
    
    String SurveyQuestion1;
    
    String SurveyQuestion2;
    
    String SurveyQuestion3;
    
    String SurveyQuestion4;
    
    String SurveyAnswer1;
    
    String SurveyAnswer2;
    
    String SurveyAnswer3;
    
    String SurveyAnswer4;   
    
    String Barcode;
    
    String RecordId;
    
    String EventId;
    
    String ImageBlob;
    
  // DateTime ScanTime;
    
    String ScanTime;
    
   global BoothLead(){
        
    }
    
    
}
}