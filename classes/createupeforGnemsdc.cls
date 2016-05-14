@RestResource(urlMapping='/createupeforGnemsdc/*')
 /**
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * Phone : 9550710718
 * AIM   : Create UPE for SignedUp people
 */
 global without sharing class createupeforGnemsdc{
   
   @HttpPost
   global static string doPost(){
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string userid;string userType;string EventId;string Error;string Message;
       
        userid=req.params.get('userid');
        userType=req.params.get('userType');
       
        List<BL_Pricing__c> BlPrice = new List<BL_Pricing__c>();
      BlPrice  =[select id,PackageName__c from BL_Pricing__c];
        if(BlPrice.size()>0){
           EventId =BlPrice[0].PackageName__c;  
        }
       
       
        
      List<AttendeeSummary__c>  attSumeList = new List<AttendeeSummary__c>();
      attSumeList =[select id,AS_Company__c,AS_Email__c from AttendeeSummary__c where AS_Email__c =:[select id,userName from user Where id=:userid limit 1].userName];
       
       system.debug('PPPPPPPPPPPPPP '+attSumeList );
      system.debug('PPPPPPPPPPPPPP WWWWWWWWWWW'+userid +' UUUUUUUUUUUUUUU '+EventId );
       
     List<User_Profile_Event__c>  upeList = new List<User_Profile_Event__c>();
     upeList =[select BoothAdmin_id__c ,id,IsMatchMakingUser__c,Request_for_upgrade_profile__c,Profile_id__c,Profile_id__r.PR_Name__c,User_id__c,User_id__r.id   from User_Profile_Event__c where User_id__c=:userid and EV_id__c=:EventId];
      if(upeList.size()>0){
         upeList[0].IsMatchMakingUser__c = true;
         if(upeList[0].Profile_id__r.PR_Name__c!='BoothAdmin' && userType=='Corporate'){
          
          if( upeList[0].BoothAdmin_id__c==null ){
           upeList[0].BoothAdmin_id__c =upeList[0].User_id__r.id;
          }
         
         upeList[0].MAtchMakingProfile__c =userType;
         
           upeList[0].Request_for_upgrade_profile__c = true;
           
            if(upeList[0].BT_id__c==null){
              Booth__c Booth  = new Booth__c();
               booth.EV_id__c =EventId;
               booth.BT_Name__c =attSumeList[0].AS_Company__c;
               insert booth;
               upeList[0].BT_id__c =Booth.id;
                   
               
          }
         dataBase.saveResult saaver = dataBase.Update(upeList[0],false); 
         system.debug('**************** '+saaver );
           if(saaver.isSuccess()){
            Message ='Event Admin needs to approve your Matchmaking registration as a Corporate';
           }else{
            error ='Unknown error occur please contact Event administrator';
           }
          
         } else{
             upeList[0].IsMatchMakingUser__c = true;
               upeList[0].MAtchMakingProfile__c =userType;
               dataBase.update(upeList[0],false);
                 Message ='Success';
         }
       
         
        
      }else{
                      
          Profile__c procus = new Profile__c();
          procus = [select id from Profile__c where PR_Name__c='Attendee']; 
          User_Profile_Event__c UPE = new User_Profile_Event__c();
          UPE.UEP_isActive__c = True;
          UPE.IsMatchMakingUser__c = true;
          UPE.EV_id__c =EventId;
          if(attSumeList.size()>0){
          UPE.Attendee_Summary__c =attSumeList[0].id; 
          }
          UPE.Profile_id__c = procus.id;
          UPE.User_id__c = userid; 
          UPE.MAtchMakingProfile__c = userType;
          if(userType== 'Corporate'){
          UPE.BoothAdmin_id__c =userid;
          UPE.Request_for_upgrade_profile__c = true;
           Message ='Event Admin needs to approve your Matchmaking registration as a Corporate';
          }
           
           Booth__c Booth  = new Booth__c();
           if(UPE.BT_id__c==null){
               booth.EV_id__c =EventId;
               booth.BT_Name__c =attSumeList[0].AS_Company__c;
               insert booth;
               UPE.BT_id__c =Booth.id;
          }
         dataBase.saveResult saveRest = dataBase.insert(UPE,false);
          if(saveRest.IsSuccess()){
          if(Message ==''){
           Message ='Success';
         }
         }else{
           error ='Unknown error occur please contact Event administrator';
         }
        
      
      }
   
     if(Error !='' && Error !=null){
      return error;
     }else if(Message!=null && Message!=''){
      return Message;
     } 
   
   
   return null;
  } 
   
}