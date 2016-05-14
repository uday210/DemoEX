@Restresource(urlMapping='/SYNCHLEADS/*')

   /*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : Synch Leads in the connection from offline mobile clients to server
 */  


global with sharing class SynchLeads {


global static list<BoothVisitSummary__c> BoothSummaryNew = new List<BoothVisitSummary__c>();
//global static list<BoothVisitSummary__c> BSVtoUpdate = new List<BoothVisitSummary__c>();
global static List<Boothlead> bleads = new List<Boothlead>();
global static User_Profile_Event__c UPE;
global static List<User_Event_BVS__c> UserBVS = new List<User_Event_BVS__c>(); 
global static List<ImageAttachmentInner> ImageAttachmentInnerList = new List<ImageAttachmentInner>();
global static List<Attachment> Attachments = new List<Attachment>();
global static List<Attachment> AttachmentsTodelete = new List<Attachment>(); 
global static set<id> BvsId = new set<id>();
global static set<id> AttachUp = new set<id>();
global static Map<id,id> AttachBsvMap = new Map<id,id>();
global static User  checkUserActive = new User();


@HttpPost


global static ResponseMessage doPost(){
    
    
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    String userId = req.params.get('UserId');
    String eventId = req.params.get('EventId');
    
     system.debug('222222222222 '+userId +'   '+eventId);
    Blob reqbody =req.requestBody;
       
    String ImageBlob = req.params.get('ImageBlob');
    string blackberry= req.params.get('BlackBerry');
     system.debug('55555555555 '+blackberry);
    string  Reqblobbody ;
    
   if(blackberry!=null && blackberry!=''){
     Reqblobbody = req.headers.get('LeadData');
    system.debug('9999999999999 '+Reqblobbody);
    }else{
    Reqblobbody = reqbody.toString();
    
      system.debug('3333333333344444444444'+Reqblobbody  );
    }
   
   
  checkUserActive = [Select id,IsActive from User where id =:userId];
   if(checkUserActive.IsActive  == FALSE){
       responseMessage resMessage = new ResponseMessage('Synching is not possible, User is Inactive in the Protal, Please contact Administrator');
       return resMessage; 
       }
  
     JSONParser Parser = JSON.createParser(Reqblobbody);
     
     
     While(parser.nextToken()!= null){
        
        if(Parser.getCurrenttoken() == JSONToken.START_ARRAY){
            while(parser.nextToken() != null){
                
                if(parser.getCurrenttoken() == JSONToken.START_OBJECT){
                    
                      SynchLeads.Boothlead bl = (SynchLeads.BoothLead)parser.readValueAs(SynchLeads.Boothlead.class);
                      
                       system.debug('44444444444 '+bl);
                      bleads.add(bl);}}}}

     for(Boothlead bal2:bleads){
      BoothVisitSummary__c Bs = new BoothVisitSummary__c();
              Bs.User_id__c =  bal2.UserId;
              system.debug('hiiiiiiiiiiii '+bal2.BarcodeId);
              Bs.EA_AttendeeBarcode__c = bal2.BarcodeId;
              Bs.BVS_Title__c =  bal2.Designation;
                Bs.BVS_State__c = bal2.state;
                
                Bs.BVS_PhoneNumber__c = bal2.Phone;
                
                Bs.BVS_Notes__c = bal2.Notes;
                IF(bal2.leadRating!='' && bal2.leadRating!=null){
                 Bs.BVS_LeadRating__c = decimal.valueOf(bal2.leadRating);
                }
                Bs.BVS_LeadCategory__c = bal2.LeadCategory;
                Bs.BVS_LastName__c =bal2.Lastname;
                Bs.BVS_FirstName__c = bal2.Firstname;
                Bs.BVS_Email__c = bal2.Email;
                Bs.BVS_Company__c =bal2.Company;
                Bs.BVS_City__c = bal2.City;
                Bs.Mrecordid__c = bal2.RecordId+'-'+bal2.UserId;
                Bs.BVS_SurveyAnswer1__c = bal2.SurveyAnswer1;
                Bs.BVS_SurveyAnswer2__c = bal2.SurveyAnswer2;
                Bs.BVS_SurveyAnswer3__c = bal2.SurveyAnswer3;
                Bs.BVS_SurveyAnswer4__c = bal2.SurveyAnswer4;
             
               // Bs.BVS_SurveyQuestion1__c = bal2.SurveyQuestion1; 
               // Bs.BVS_SurveyQuestion2__c = bal2.SurveyQuestion2;
               // Bs.BVS_SurveyQuestion3__c = bal2.SurveyQuestion3;
               // Bs.BVS_SurveyQuestion4__c = bal2.SurveyQuestion4;
                system.debug('FollowUpsssssssssssssssss '+bal2.FollowupTypes);
                 Bs.BVS_FollowUps__c = bal2.FollowupTypes; 
               
                system.debug('444444444444444 '+bal2.NextFollowUpdate);
                
             if(bal2.NextFollowUpdate!='' && bal2.NextFollowUpdate!=null){  
                  if(!(bal2.NextFollowUpdate.equals('')) ){
              
                 Bs.Follow_Update__c = DateTime.ValueOf(bal2.NextFollowUpdate);
                
                  }
             }     
                
             try{
              if(!(bal2.ScannedTime.equals('')) ){
              system.debug('0000000000000000000 '+bal2.ScannedTime);
                  Bs.ScanTime__c= DateTime.ValueOf(bal2.ScannedTime); 
                  }
                  }catch(exception e){
                  
                  }
                system.debug('999999999999999999 '+bal2.ScannedTime);  
                  
                  Bs.AS_ImageUrl__c=bal2.imageUrl;
                  Bs.Temp__c = bal2.eventId;
                  system.debug('488888888888888999999999 '+bal2.eventId);
                  if(Bs.BVS_LeadRating__c!=null && Bs.BVS_LeadRating__c!=0){
                  Bs.BVS_LeadRating__c = decimal.valueOf(bal2.leadRating);
                  }
                // BoothSummaryNew.add(Bs); 
                ImageAttachmentInner ImageAttachmentInnerOne = new ImageAttachmentInner(Bs,bal2.ImageBlob);
                ImageAttachmentInnerList.add(ImageAttachmentInnerOne);
               
     }
     system.debug('666666666666666  '+BoothSummaryNew.size());
     set<id> setOfIds = new set<id>();
     set<id> setOfEventIds = new set<id>();
     
     try{
     
     MAP<string,ImageAttachmentInner> mapidandobjectinner = new MAP<string,ImageAttachmentInner>();
    
     List<BoothVisitSummary__c> listOfinners = new List<BoothVisitSummary__c>();
     for(ImageAttachmentInner BvsNew: ImageAttachmentInnerList){
     
     mapidandobjectinner.put(BvsNew.imageBvs.BVS_Email__c,BvsNew);
     system.debug('77777777777777 '+mapidandobjectinner);
     listOfinners.add(BvsNew.imageBvs);
    }
     
      Schema.SObjectField f = BoothVisitSummary__c.Fields.Mrecordid__c;
      Database.UpsertResult[] Dbbvs = DataBase.upsert(listOfinners,f,false);
      
      List<BoothVisitSummary__c> listOfupsertBoothvisits = new List<BoothVisitSummary__c>();    
      set<id> idsofupsert = new  set<id>();
     
      for(Database.UpsertResult IterateResult:Dbbvs){
      idsofupsert.add(IterateResult.getId()); 
      }
    
    listOfupsertBoothvisits =[select id,BVS_Email__c from BoothVisitSummary__c where id IN :idsofupsert];
    system.debug('FFFFFFFFFFFFF '+listOfupsertBoothvisits );
    
    for(BoothVisitSummary__c bvsits:listOfupsertBoothvisits){
      BvsId.add(bvsits.Id);
      ImageAttachmentInner getmapvalues = new ImageAttachmentInner();
      system.debug('F1F1F1F1F1F1F '+bvsits.BVS_Email__c);
      
      getmapvalues = mapidandobjectinner.get(bvsits.BVS_Email__c); 
        system.debug('F2F2F2F2F2F2F '+getmapvalues );
        
     if(!String.isEmpty(getmapvalues.encryptedStr)) {
       AttachUp.add(bvsits.Id);
       Attachment attachOne = new Attachment();
       attachOne.Name =getmapvalues.imageBvs.Mrecordid__c;
       attachOne.Body = EncodingUtil.base64Decode(getmapvalues.encryptedStr);
       attachOne.ParentId =bvsits.Id;
       Attachments.add(attachOne);
           
    }
    
     setOfEventIds.add(getmapvalues.imageBvs.Temp__c);       
       setOfIds.add(getmapvalues.imageBvs.User_id__c);
       BoothSummaryNew.add(getmapvalues.imageBvs);
   } 
    
       
       
      
 /**
       BvsId.add(Dbbvs.getId());
       
      if(Dbbvs.isSuccess()==True && (!String.isEmpty(BvsNew.encryptedStr)) ){
       AttachUp.add(Dbbvs.getId());
       Attachment attachOne = new Attachment();
       attachOne.Name =BvsNew.imageBvs.Mrecordid__c;
       attachOne.Body = EncodingUtil.base64Decode(BvsNew.encryptedStr);
       attachOne.ParentId =Dbbvs.getId();
       Attachments.add(attachOne);
       BoothSummaryNew.add(BvsNew.imageBvs);  
       } } 
       **/
     
       
       }
       
 catch(Exception ex){
     
    //  System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@exMessage'+ex.getMessage());
     
     }
     
     system.debug('2222222222222 '+setOfIds);
       system.debug('3333333333333'+setOfEventIds);
       
     if(setOfeventIds.size()>0 && setOfIds.size()>0){
     List<User_Profile_Event__c> listofUPES = new List<User_Profile_Event__c>();
     listofUPES =[select id, EV_id__r.id from User_Profile_Event__c  where EV_id__r.id IN :setOfeventIds and User_id__r.id IN :setOfIds and EV_id__r.id!=null and User_id__r.id!=null]; 
     MAP<id,User_Profile_Event__c> mapboothUPE = new MAP<id,User_Profile_Event__c>();
      system.debug('101010010101010 '+listofUPES );
     
    for(User_Profile_Event__c IterateUPE:listofUPES){
    if(IterateUPE.EV_id__r.id!=null){
    mapboothUPE.put(IterateUPE.EV_id__r.id,IterateUPE);
    }
    }
  
      
      for(BoothVisitSummary__c BSVC:BoothSummaryNew){
       User_Event_BVS__c UEB = new User_Event_BVS__c();
       // User_Profile_Event__c assgnValues = new User_Profile_Event__c();
      system.debug('888888888888 '+BSVC.Temp__c);
      if(BSVC.Temp__c!=null){
       UPE =mapboothUPE.get(BSVC.Temp__c);
       }
       
       if(UPE.EV_id__r.id!=null){
       UEB.EV_id__c = UPE.EV_id__r.id; 
       UEB.BVS_id__c = BSVC.id;  
       UEB.UPE_id__c = UPE.id;
       UEB.Mrecordid__c=BSVC.Mrecordid__c;
       UserBVS.add(UEB); 
      }
      }
   }   
      
      
      
      
    try{
       Schema.SObjectField f = User_Event_BVS__c.Fields.Mrecordid__c;
       Database.UpsertResult[] upsertResults= DataBase.upsert(UserBVS,f,false);
       system.debug('9999999999999999 '+upsertResults);
      } 

  catch(Exception ex){
  System.debug('@@@@@exMesssage'+ex.getMessage());
  }
  
  
  try{
  AttachmentsTodelete  = [select id from Attachment where parentId IN:BvsId ];
 if(AttachmentsTodelete.size() > 0){
   Delete AttachmentsTodelete;
   }  
  for(Attachment AttOne:Attachments){
   Schema.SObjectField f = Attachment.Fields.Name;
   Database.UpsertResult upsertResult= DataBase.upsert(AttOne,f,false);
   if(upsertResult.isSuccess()==TRUE){
   AttachBsvMap.put(AttOne.ParentId,AttOne.id);
   }
   
  }
 

  }
  
  catch(Exception ex){
  }
    list<BoothVisitSummary__c> BSVtoUpdate = new List<BoothVisitSummary__c>();
     for(BoothVisitSummary__c BSVC:BoothSummaryNew){
     if(AttachBsvMap.containskey(BSVC.id)){
     BSVC.AttachmentId__c = AttachBsvMap.get(BSVC.id);
     BSVtoUpdate.add(BSVC);
     } }

 Schema.SObjectField f = BoothVisitSummary__c.Fields.Mrecordid__c;
 responseMessage resMessage = new ResponseMessage('Success');
     
    return resMessage; 
    
}


global class SynchLeadRes{





  global SynchLeadRes(){
  
  }


}




global class LeadDetailsRes{


String  recordId;

String serverId;


global LeadDetailsRes(String recordId1, String serverId1){

  recordId = recordId1;
  
  serverId = serverId1;
  

}

}


global class UpadtedDetails{



String recordId;

String serverId;



global UpadtedDetails(String recordId1, String serverId1){



  recordId = recordId1;
  
  serverId = serverId1;
  

}

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
    
    String BarcodeId;
    
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
    
    String UserId;
    
    String RecordId;
    
    String ScannedTime;
    String ImageBlob;
    
    String eventId;
    
   global BoothLead(){
        
    }
    
    
}


global class ImageAttachmentInner{

 BoothVisitSummary__c imageBvs;
 String encryptedStr;
 global ImageAttachmentInner(BoothVisitSummary__c imageBvs1,String encryptedStr1){
  this.imageBvs = imageBvs1;
  this.encryptedStr = encryptedStr1;
 
 }
 global ImageAttachmentInner(){}
 

}


 global class ResponseMessage{
 
 
 String message;
 
 global ResponseMessage(String message1){
 
 message = message1;
 
 }
 
 }
 }