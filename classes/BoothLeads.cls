@Restresource(urlMapping='/BoothLeads/*')

global with sharing class BoothLeads{


global static list<BoothVisitSummary__c> BoothSummaryNew = new List<BoothVisitSummary__c>();
 
global static List<Boothlead> bleads = new List<Boothlead>();

global static User_Profile_Event__c UPE;

global static List<User_Event_BVS__c> UserBVS = new List<User_Event_BVS__c>(); 

@HttpPost


global static List<Boothlead> doPost(){
    
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    
    System.debug('@@@@@req'+req);
    
    String userId = req.params.get('UserId');
   
    System.debug('@@@@@userId'+userId );
   
    String eventId = req.params.get('EventId');
    
    System.debug('@@@@@eventId '+eventId);
   
  
    
    UserBVS  = [Select BVS_id__r.BVS_FollowUps__c ,BVS_id__r.EA_AttendeeBarcode__c,BVS_id__r.BVS_Budget__c,BVS_id__r.BVS_City__c,BVS_id__r.BVS_Company__c,BVS_id__r.BVS_Email__c,BVS_id__r.BVS_FirstName__c,BVS_id__r.BVS_LastName__c,BVS_id__r.BVS_LeadCategory__c,BVS_id__r.BVS_LeadRating__c,BVS_id__r.BVS_LeadType__c,BVS_id__r.Mrecordid__c,
    
                BVS_id__r.BVS_Notes__c,BVS_id__r.BVS_PhoneNumber__c,BVS_id__r.ScanTime__c,BVS_id__r.BVS_State__c,BVS_id__r.BVS_SurveyAnswer1__c,BVS_id__r.BVS_SurveyAnswer2__c,BVS_id__r.BVS_SurveyAnswer3__c,BVS_id__r.BVS_SurveyAnswer4__c,BVS_id__r.BVS_SurveyQuestion1__c,BVS_id__r.BVS_SurveyQuestion2__c,BVS_id__r.BVS_SurveyQuestion3__c,
                
                BVS_id__r.BVS_SurveyQuestion4__c,BVS_id__r.BVS_Tags__c,BVS_id__r.BVS_Title__c  from User_Event_BVS__c where EV_id__c=:eventId  and BVS_id__r.User_id__r.id=:userId]; 
    
   
     System.debug('@@@@@@@UserBVS'+UserBVS);
   
   
   for(User_Event_BVS__c UEBC:UserBVS){
   
   
   Boothlead Blead = new Boothlead();
  
   //Blead.Barcode = UEBC.BVS_id__r.EA_AttendeeBarcode__c;
   
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
   
   Blead.SurveyAnswer1 = UEBC.BVS_id__r.BVS_SurveyAnswer1__c;
    
   Blead.SurveyAnswer2 = UEBC.BVS_id__r.BVS_SurveyAnswer2__c;
    
   Blead.SurveyAnswer3 = UEBC.BVS_id__r.BVS_SurveyAnswer3__c;
     
      Blead.SurveyAnswer4 = UEBC.BVS_id__r.BVS_SurveyAnswer4__c;
      
      
      Blead.SurveyQuestion1= UEBC.BVS_id__r.BVS_SurveyQuestion1__c ;   
       
      Blead.SurveyQuestion2= UEBC.BVS_id__r.BVS_SurveyQuestion2__c ;
        
      Blead.SurveyQuestion3 = UEBC.BVS_id__r.BVS_SurveyQuestion3__c;
        
        Blead.SurveyQuestion4= UEBC.BVS_id__r.BVS_SurveyQuestion4__c;
          
           Blead.FollowupTypes = UEBC.BVS_id__r.BVS_FollowUps__c;
           
            System.debug('@@@@@bleads'+Blead);
        
        bleads.add(Blead);
        
          
  
   }
   
   
   System.debug('@@@@@bleads'+bleads);
  
    // ResponseMessage resMessage = new ResponseMessage('Success');
     
    // return resMessage; 
    
   return bleads;
    
}













global class Boothlead{
    
    
   // String EventId;
    
    String Barcode;
    

    
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
    
    String rating;
    
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
    
    
    String RecordId;
    
    
   global BoothLead(){
        
    }
    
    
}
}