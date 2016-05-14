@RestResource(urlMapping='/MMEXUpdatedAppnts/*')

/**
 * AUTHOR: Rajesh
 * Email : rajeshc@globalnest.com
 * Phone : 9985445095
 * AIM   : MM User Login Service
 */
global without Sharing class MMEXUpdatedAppnts{

 @httpPost
 global static AllDetails doPost(){

     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string eveid;     
     string exeid;
     Date dtime;
     String isMM;
     eveid = req.params.get('eveid');
     exeid = req.params.get('exeid');
     //dtime = Date.valueOf(req.params.get('dtime'));
     isMM = req.params.get('isMM');
     system.debug('eveid '+eveid );
     system.debug('exeid '+exeid);
     
  
     AllDetails alDetail = new AllDetails();
      User_Profile_Event__c upes =new User_Profile_Event__c();
       upes = [SELECT MAtchMakingProfile__c,User_id__c,Id,Attendee_Summary__r.AS_ImageUrl__c, Attendee_Summary__r.AS_FirstName__c,
              Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Company__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.Id, 
              u.Profile_id__c,u.Profile_id__r.PR_Name__c, u.EV_id__c ,(select id,Break_End_Time__c,Break_Start_Time__c,Break_Title__c,Event_Attendee_Mapping__c,MatchLeads_Days__c,MatchLeads_Days__r.MatchLeads_Date__c from Event_Breaks__r where User_Profile_Event__c!=null)
              FROM User_Profile_Event__c u 
              WHERE EV_id__r.Id =:eveid AND User_id__r.userName =: exeid AND IsMatchMakingUser__c = TRUE limit 1];
              
      user up = new user();
      up =[select title,id,city,companyName,userName,email,States__c,phone,Country__c,FirstName,LastName from user where id=:upes.User_id__c]; 
      
    /*  
     if(null != up){ 
     
         List<AttendeeSummary__c> att =new List<AttendeeSummary__c>();
           att = [select AS_Work_Country__c,id,AS_ImageUrl__c,AS_Email__c, AS_CellPhone__c,AS_WorkPhone__c,AS_Work_States__c,AS_WorkCity__c,AS_Title__c,AS_Company__c,AS_FirstName__c,AS_LastName__c from AttendeeSummary__c where AS_Email__c=:up.userName];
            string imgurl;
             if(att.size()>0){
               imgurl =att[0].AS_ImageUrl__c;
            }
            
            if(att.size()>0){   
              GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(att[0] ,'',up.id);
              alDetail.userProfile.add(Guser);
             }
    }
      */
      /*if(upes!=null){
            GlobalUtillClass.UserDetails userProfileq = new GlobalUtillClass.UserDetails(up,upes.Attendee_Summary__r.AS_ImageUrl__c,'');
             alDetail.userProfile.add(userProfileq);
      }*/
      
       List<EventSchedule__c> eSchedules = new List<EventSchedule__c>();
        
        if(upes.MAtchMakingProfile__c=='Corporate'){
        
           for(Event_Breaks__c Ebc:upes.Event_Breaks__r){
              GlobalUtillClass.MMBlockedslots gn = new GlobalUtillClass.MMBlockedslots(Ebc);
              alDetail.BlockedSchedules.add(gn);
           }
          
            
        
            for(EventSchedule__c sche:[select EV_id__r.Is_Webank_event__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,EV_id__r.Id,EV_id__r.EV_Title__c,
                  MM_Slot_Status__c,MM_To_UPE__c,EV_id__c,MM_To_EAM__c,MM_slot_Date__c,MM_Slot_End_Time__c,MM_slot_StartTime__c,
                  Comments__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,
                  MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.Id,
                  MM_To_UPE__r.BT_id__r.Table_Room_No__c, MM_To_UPE__r.BT_id__r.BT_Location__c, OwnerId,
                  MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c, MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,  MM_To_EAM__r.MBE_Profile__r.AS_Company__c, MM_To_EAM__r.MBE_Profile__r.AS_Email__c,  MM_To_EAM__r.MBE_Profile__r.Id
                  from EventSchedule__c 
                  where MM_To_UPE__r.User_id__r.userName=:exeid 
                  and EV_id__c=:eveid 
                  and MM_To_UPE__r.Attendee_Summary__c!=null 
                  AND MM_To_EAM__r.IsMatchMakingAttendee__c = TRUE]){
                  
            if(sche.EV_id__r.Is_Webank_event__c){    
                GlobalUtillClass.MMEXSchedules mmexsc = new GlobalUtillClass.MMEXSchedules(sche, sche.MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c, sche.MM_To_EAM__r.MBE_Profile__r.AS_LastName__c, sche.MM_To_EAM__r.MBE_Profile__r.AS_Company__c, sche.MM_To_EAM__r.MBE_Profile__r.AS_Email__c, sche.MM_To_EAM__r.AS_id__r.Id);
               alDetail.MMEXSchedules.add(mmexsc);
           }else{
               GlobalUtillClass.MMEXSchedules mmexsc = new GlobalUtillClass.MMEXSchedules(sche, sche.MM_To_EAM__r.AS_id__r.AS_FirstName__c, sche.MM_To_EAM__r.AS_id__r.AS_LastName__c, sche.MM_To_EAM__r.AS_id__r.AS_Company__c, sche.MM_To_EAM__r.AS_id__r.AS_Email__c, sche.MM_To_EAM__r.AS_id__r.Id);
              alDetail.MMEXSchedules.add(mmexsc);
            }
           
          }   
                    
        }else{
          for(Event_Attendee_Mapping__c em : [select id,(select id,Break_End_Time__c,Break_Start_Time__c,Break_Title__c,Event_Attendee_Mapping__c,MatchLeads_Days__c,MatchLeads_Days__r.MatchLeads_Date__c from Event_Breaks__r where Event_Attendee_Mapping__c!=null) from Event_Attendee_Mapping__c WHERE EV_id__r.Id =:eveid AND AS_id__r.AS_Email__C=: exeid AND IsMatchMakingAttendee__c = TRUE limit 1]){
            for(Event_Breaks__c Ebc:em.Event_Breaks__r){
              GlobalUtillClass.MMBlockedslots gn = new GlobalUtillClass.MMBlockedslots(Ebc);
              alDetail.BlockedSchedules.add(gn);
            }
          }
          
           
          
        
             for(EventSchedule__c sche:[select MM_To_UPE__r.User_id__r.Id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c, 
                 EV_id__r.Id,EV_id__r.EV_Title__c,MM_To_UPE__c,EV_id__c,MM_To_EAM__c,MM_slot_Date__c,MM_Slot_End_Time__c,
                 MM_slot_StartTime__c, Comments__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,
                 MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c, MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                 MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, MM_To_UPE__r.Attendee_Summary__r.Id, 
                 MM_To_UPE__r.BT_id__r.Table_Room_No__c, MM_To_UPE__r.BT_id__r.BT_Location__c, OwnerId 
                 from EventSchedule__c 
                 where MM_To_EAM__r.AS_id__r.AS_Email__c=:exeid 
                 and EV_id__c=:eveid 
                 and Is_Matchmaking__c=true 
                 and MM_To_UPE__r.Attendee_Summary__c!=null
                 AND MM_To_UPE__r.IsMatchMakingUser__c = TRUE]){
               
               GlobalUtillClass.MMEXSchedules mmexsc = new GlobalUtillClass.MMEXSchedules(sche, sche.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, sche.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c, sche.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, sche.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, sche.MM_To_UPE__r.User_id__r.Id);
               alDetail.MMEXSchedules.add(mmexsc);
          }
        } 
      return alDetail;
   
   }


global class AllDetails{
List<GlobalUtillClass.MMEXSchedules> MMEXSchedules = new List<GlobalUtillClass.MMEXSchedules>();
//List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.MMBlockedslots> BlockedSchedules= new List<GlobalUtillClass.MMBlockedslots>();

}
  


}