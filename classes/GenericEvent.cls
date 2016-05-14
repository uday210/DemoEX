@RestResource(urlMapping='/GenericEvent/*')

/*
 * AUTHOR: Phani    
 * Email : phani@globalnest.com
 * Phone : 9550710718 
 * AIM   : 
 */


  global with sharing class GenericEvent{
      
    @HttpPost
       global static string doGet(){
          RestRequest req = RestContext.request;
          RestResponse res = RestContext.response;
         
         string adminEid  = req.params.get('adminEid');
         string  leadEid  = req.params.get('leadEid');
         string  leadName = req.params.get('leadName');
         
         system.debug('AAAAAAAA '+adminEid+'VVVVVVVVV '+leadEid  +'GGGGGGGGGG '+leadName );
          
          string  barcode ='';
         
         
         //string isGeneric= req.params.get('isGeneric');
         List<event__c> events = [select id from event__c where EV_Title__c='Generic Event' limit 1];
         List<Profile__c> profile = [select id,PR_Name__c from profile__c where PR_Name__c='Attendee'];
         
         
         try{
         List<User_Profile_Event__c> upesList = [select id,user_id__r.userName from User_Profile_Event__c where EV_id__r.EV_Title__c='Generic Event' and user_id__r.userName=:adminEid];
          if(upesList.size()<=0){
             List<user> usersList = [select id from user where userName=:adminEid];
             List<AttendeeSummary__c> attList =[select id from AttendeeSummary__c where AS_Email__c =:adminEid];
             
             if(events.size()>0 && usersList.size()>0){
               User_Profile_Event__c upe = new User_Profile_Event__c();
               upe.EV_id__c = events[0].id;
               upe.User_id__c = usersList[0].id;
               upe.Status__c ='Active';
               upe.Profile_id__c =profile[0].id; 
               upe.UEP_isActive__c = true;
               dataBase.insert(upe,false);                 
              
               if(attList.size()>0){
                  Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c();
                  eam.EV_id__c =events[0].id;
                  eam.AS_id__c = attList[0].id;
                  database.saveResult res0 = DataBase.insert(eam,false);
                 if(res0.isSuccess()){
                   eam.EA_AttendeeBarcode__c = res0.getId() + '-' + events[0].id;
                   update eam;
                 } 
               }
             }
         }
         
       // Inserting Attendee Details  
         
         List<AttendeeSummary__c> leadList =[select id from AttendeeSummary__c where AS_Email__c =:leadEid];
         if(leadList.size()>0){
             List<Event_Attendee_Mapping__c> eams =[select id, EA_AttendeeBarcode__c from Event_Attendee_Mapping__c  where As_id__c= :leadList[0].id and EV_id__c=:events[0].id]; 
              system.debug(eams .size()+'  EAM SIZE '+eams );
              if(eams.size()>0){
                
              }else{
                 Event_Attendee_Mapping__c eam2 = new Event_Attendee_Mapping__c();
                     eam2.EV_id__c =events[0].id;
                     eam2.AS_id__c = leadList[0].id;
                     database.saveResult res1 =    dataBase.insert(eam2);
                      system.debug(res1.isSuccess()+' UPDATE RESULT '+res1);
                     if(res1.isSuccess()){
                       eam2.EA_AttendeeBarcode__c = res1.getId() + '-' + events[0].id;
                       update eam2;
                     } 
              }
             
          }else{
             AttendeeSummary__c attSum =new AttendeeSummary__c();
             attSum.AS_FirstName__c = leadName.split(',')[0];
             attSum.AS_LastName__c = leadName.split(',')[1];
             attSum.AS_Email__c  = leadEid;
             database.saveResult saveres = dataBase.insert(attSum,false);
             system.debug(saveres.isSuccess()+'  SAVE RESULT '+saveres );
                 if(saveres.isSuccess()){
                     Event_Attendee_Mapping__c eam1 = new Event_Attendee_Mapping__c();
                     eam1.EV_id__c =events[0].id;
                     eam1.AS_id__c = saveres.getid();
                    
                     database.saveResult res3 =   dataBase.insert(eam1);
                     system.debug(res3.isSuccess()+'  EAM RESULT '+res3);
                     if(res3.isSuccess()){
                       eam1.EA_AttendeeBarcode__c = res3.getId() + '-' + events[0].id;
                       update eam1;
                     } 
               }
            }
         barcode  = [select id,EA_AttendeeBarcode__c  from Event_Attendee_Mapping__c  where As_id__r.As_email__c= :leadEid and EV_id__c=:events[0].id].EA_AttendeeBarcode__c ; 
         system.debug('VVVVVVVVVVVVVVVVVVVVV '+barcode);
      }catch(exception er){
           barcode  = er.getMessage();
       }  
           return barcode;
        }
    }