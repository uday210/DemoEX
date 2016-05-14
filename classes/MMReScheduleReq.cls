@RestResource(urlMapping='/MMReScheduleReq/*')


global without Sharing class MMReScheduleReq{

@httpPost
global static AllDetails doPost(){
 
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string evscid;
     Date dateval;
     String timeval;
     String comments;
     String status;
     String loginid;
     String userRole;
     
     evscid =req.params.get('evscid');
     dateval = Date.Valueof(req.params.get('dateval'));
     timeval = req.params.get('timeval');
     status = req.params.get('status');
     comments = req.params.get('comments');
     loginid = req.params.get('loginid');
     userRole = req.params.get('userRole');
     
     system.debug('evscid------'+evscid);   
     system.debug('dateval ------'+dateval );    
     system.debug('timeval------'+timeval);
     system.debug('comments------'+comments); 
     system.debug('status------'+status);
     system.debug('loginid------'+loginid);
     system.debug('userRole ------'+userRole);
     
     List<string> timesplit =timeval.split('-');
     
   
     AllDetails alDetail = new AllDetails();
     
     
      
      
      /*  User_Profile_Event__c upe = [SELECT Id, EV_id__r.MM_Slot_Timeperiod__c, EV_id__r.MM_Start_Date__c,EV_id__r.MM_End_Date__c  FROM User_Profile_Event__c WHERE User_id__r.Id =:exhid AND EV_id__r.Id =: eveid];
      
    Date checkeveate = Date.ValueOf(dateval);
      if(checkeveate < upe.EV_id__r.MM_Start_Date__c && checkeveate > upe.EV_id__r.MM_End_Date__c){
      GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(NULL, 'Start or end Date is not correct');
      alDetail.globalSuccess.add(mssge);
      return alDetail;
      system.debug('date not mached');
      }else{*/
      
      
      EventSchedule__c ESCH = [SELECT MM_Slot_Status__c,Id, MM_slot_StartTime__c, MM_Slot_End_Time__c, MM_slot_Date__c,EV_id__r.Id, EV_id__r.MM_Slot_Timeperiod__c, 
                               EV_id__r.MM_Start_Date__c,EV_id__r.MM_End_Date__c, MM_To_UPE__r.User_id__r.Id, MM_To_EAM__r.Id ,EV_id__c ,EV_id__r.Match_Making_Schedules__c,EV_id__r.Stop_Schedule_for_Mobile__c                             
                               FROM EventSchedule__c WHERE Id =: evscid];
                               
                               system.debug('444444444444444444'+ESCH);
        
      MatchLeads_Days__c ed = new MatchLeads_Days__c();
      ed = [SELECT Id,MatchLeads_Date__c,Slot_Time_period__c, MAX_noOf_appontments__c FROM MatchLeads_Days__c WHERE Event__c =:ESCH.EV_id__r.id AND MatchLeads_Date__c=:dateval];
      system.debug('666666666666666666666'+ed);
    
    if(ESCH.MM_Slot_Status__c=='cancelled')  {
       List<User_Profile_Event__c> UcProfile = new List<User_Profile_Event__c>();
       UcProfile = [select id,MAtchMakingProfile__c from User_Profile_Event__c where User_id__c =:loginid and EV_Id__c=:ESCH.EV_id__r.Id ];
     
     system.debug('0000000000000000000000'+UcProfile);
     
      if(UcProfile!=null ){
          if(UcProfile[0].MAtchMakingProfile__c!= 'MBE'){
          system.debug('222222222222222222'+UcProfile[0].MAtchMakingProfile__c);
          
          }else{
            Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c();
            eam =[SELECT Id,(SELECT Id,MM_To_EAM__c,MM_Slot_Status__c FROM EventSchedule__r WHERE (MM_Slot_Status__c  = 'Accepted' OR MM_Slot_Status__c  ='Pending' ) and EV_Id__c=:ESCH.EV_id__r.Id) FROM Event_Attendee_Mapping__c where id =:ESCH.MM_To_EAM__c];   
             system.debug('QQQQQQQQQQQQQ'+eam.EventSchedule__r.size() );
             if(eam.EventSchedule__r.size()>=ed.MAX_noOf_appontments__c){   
              system.debug('QWWWWWWWWWWW  '+ed.MAX_noOf_appontments__c );  
              GlobalUtillClass.globalMessage mssge = new GlobalUtillClass.globalMessage('You have reached Maximum number of Appointments!');
              alDetail.globalMessage.add(mssge);
                      
               string eveid = ESCH.EV_id__c;
               FetchEventdetails evedetails= new FetchEventdetails();
               alDetail.eventscheduleStatus='Live';
                if(eveid!=null && eveid!=''){  
                  try{
                    if(null !=evedetails.evedetails(eveid)){
                         alDetail.eventscheduleStatus = evedetails.evedetails(eveid).Match_Making_Schedules__c;
                     }
                   }catch(exception er){} 
                  } 
              return alDetail;
              }
           }   
      }
    
  }    
    
     
      string eveid = ESCH.EV_id__c;
       FetchEventdetails evedetails= new FetchEventdetails();
       alDetail.eventscheduleStatus='Live';
        if(eveid!=null && eveid!='' && status!='cancelled'){  
          try{
            if(null !=evedetails.evedetails(eveid)){
                 alDetail.eventscheduleStatus = evedetails.evedetails(eveid).Match_Making_Schedules__c;
                 if(alDetail.eventscheduleStatus=='Closed'){
                   return alDetail;
                 }
            }
           }catch(exception er){} 
          } 
      
        
       //EV_id__r.Match_Making_Schedules__c,EV_id__r.Stop_Schedule_for_Mobile__c
     
      /* This code is for stop schedules  */ 
      if((ESCH.EV_id__r.Match_Making_Schedules__c == 'Closed' || ESCH.EV_id__r.Stop_Schedule_for_Mobile__c) && status!='cancelled'){
          GlobalUtillClass.globalMessage mssge = new GlobalUtillClass.globalMessage('You are not authorized to schedule for this event. Please down load the latest version of app.');
          alDetail.globalMessage.add(mssge);
          return alDetail;
      }
      /* This code works only for "Shelly" Event - "Connecticut Business Advantage 2014 Training and Matchmaker Event", This should be deleted after the event. */ 
      
      
      List<MatchLeads_Days__c> checkEveDate = [SELECT Id, MAX_noOf_appontments__c FROM MatchLeads_Days__c WHERE Event__r.Id =:ESCH.EV_id__r.id AND MatchLeads_Date__c =:dateval ];
      if(checkEveDate.size()>0){ 
          system.debug('There is date');
      }else{
          GlobalUtillClass.globalMessage mssge = new GlobalUtillClass.globalMessage('Invalid Date for this event');
          alDetail.globalMessage.add(mssge);
          return alDetail;
      }
     
        
      
      
      
      if(status=='Pending'){
      
      List<EventSchedule__c> checkslot = new List<EventSchedule__c>();
         system.debug('status'+status);
      
      if(userRole=='MBE'){      
                      
      checkslot = [SELECT Id, MM_slot_StartTime__c, EV_id__r.MM_Start_Date__c,  MM_To_EAM__r.Id 
                                         FROM EventSchedule__c 
                                         WHERE MM_To_EAM__r.Id =: ESCH.MM_To_EAM__r.Id 
                                         AND MM_slot_StartTime__c =: timesplit[0] AND MM_slot_Date__c =:dateval 
                                         AND EV_id__r.Id=: ESCH.EV_id__r.Id 
                                         AND Is_Matchmaking__c =: TRUE 
                                         AND (MM_Slot_Status__c = 'Accepted' or MM_Slot_Status__c = 'Pending') 
                                         AND Id !=: evscid ];
      }else if(userRole=='Corporate'){
           
            checkslot = [SELECT Id, MM_slot_StartTime__c, EV_id__r.MM_Start_Date__c,  MM_To_EAM__r.Id 
                                         FROM EventSchedule__c 
                                         WHERE MM_To_UPE__r.User_id__r.Id =: ESCH.MM_To_UPE__r.User_id__r.Id 
                                         AND MM_slot_StartTime__c =: timesplit[0] 
                                         AND MM_slot_Date__c =:dateval 
                                         AND EV_id__r.Id=: ESCH.EV_id__r.Id 
                                         AND Is_Matchmaking__c =: TRUE 
                                         AND (MM_Slot_Status__c = 'Accepted' or MM_Slot_Status__c = 'Pending') 
                                         AND Id !=: evscid ];
           
       }                              
          
          if(checkslot.size()>0 ){
              system.debug('this time not available');
              //if(userRole=='MBE'){
              GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(checkslot[0].Id, 'You already have an appointment at this time');
              alDetail.globalSuccess.add(mssge);
              //}else if( userRole=='Corporate' ){
              //GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(checkslot[0].Id, 'This MBE already has an appointment at this time');
              //alDetail.globalSuccess.add(mssge);
              //}
              return alDetail;
          }else{     
     
      List<EventSchedule__c> checkslot1 = [SELECT Id, EV_id__c,MM_To_UPE__c,MM_slot_Date__c, MM_slot_StartTime__c 
                                          FROM EventSchedule__c 
                                          WHERE EV_id__c=:ESCH.EV_id__r.Id 
                                          AND MM_To_EAM__r.Id =: ESCH.MM_To_EAM__r.Id 
                                          AND MM_To_UPE__r.User_id__r.Id=:ESCH.MM_To_UPE__r.User_id__r.Id 
                                          AND Is_Matchmaking__c =: TRUE 
                                          AND (MM_Slot_Status__c = 'Accepted' or MM_Slot_Status__c = 'Pending') 
                                          AND Id !=: evscid ];  /* MM_slot_StartTime__c =: timeval AND MM_slot_Date__c =: dateval AND*/
      if(checkslot1.size()>0){
      system.debug('slot is booked');
      GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(checkslot1[0].Id, 'You have reached the maximum appointment limit with '); /* You cannot schedule more than one appointment with a Exhibitor */
      alDetail.globalSuccess.add(mssge);
      return alDetail;
      }else{
      
          
          
          
          ESCH.MM_slot_Date__c = dateval ;
          ESCH.MM_slot_StartTime__c = timesplit[0];
          ESCH.Comments__c = comments;
          ESCH.MM_Slot_Status__c = status;
          ESCH.OwnerId = loginid;
          ESCH.Is_Matchmaking__c = TRUE;
          //ESCH.MM_To_EAM__c = ESCH.MM_To_EAM__r.Id;
          //ESCH.EV_id__c  = ESCH.EV_id__r.Id;
          //ESCH.MM_To_UPE__c = ESCH.MM_To_UPE__r.User_id__r.Id;
          //ESCH.LastModifiedBy.Id = loginid;
           
          //integer hh = integer.valueof(sthour[0]);
          //integer mm =  integer.valueof(sthour[1].subString(0, sthour[1].IndexOf(' ')));
          
          system.debug('   timesplit[0] - start time----- '+  timesplit[0]);
         //  system.debug('   timesplit[1] - end time----- '+  timesplit[1]);
         // system.debug('ed.Slot_Time_period__c---------'+ed.Slot_Time_period__c);
              /*if(mm+integer.valueOf(ed.Slot_Time_period__c) >= 60){
                  hh+=1;
                  mm = mm+integer.valueOf(ed.Slot_Time_period__c);
                  mm-= 60;
                   
              }else{
                  mm = mm+integer.valueOf(ed.Slot_Time_period__c);
              
              }
          String scheduleEndTime='';
              if(hh < 12 && timeval.Contains('AM' )){
                      scheduleEndTime = string.valueOf(hh+':'+mm +' AM');
              }else{
                       scheduleEndTime = string.valueOf(hh+':'+mm +' PM');
              }
              system.debug('   333333333333333333333   '+ scheduleEndTime );
              Time mmstartTime = Time.newInstance(hh, mm, 00, 00);
              time endtime = mmstartTime.addMinutes(integer.valueOf(ed.Slot_Time_period__c));
              
              */
              try{
              ESCH.MM_Slot_End_Time__c = timesplit[1];
              }catch(exception es){
              
              }
              Database.upsert(ESCH,False);
              
              system.debug(' esid '+ESCH.id);
              Id resultid = ESCH.id;
          
          
              if(resultid != NULL ){
              GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(ESCH.id, 'Succesfully Rescheduled');
              alDetail.globalSuccess.add(mssge);
              
           if(userRole=='Corporate'){
               EventSchedule__c newSlotDet = [SELECT Id, MM_slot_Date__c, MM_slot_StartTime__c, MM_Slot_End_Time__c, 
               MM_Slot_Status__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, MM_To_UPE__r.Attendee_Summary__r.Id, 
               MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, OwnerId 
               FROM EventSchedule__c WHERE Id =: ESCH.id ];
                   
               GlobalUtillClass.NewSlotDetils nsd = new GlobalUtillClass.NewSlotDetils(newSlotDet, userRole);
               alDetail.NewSlotDetils.add(nsd);
           }else if(userRole=='MBE'){
               EventSchedule__c newSlotDet = [SELECT Id, MM_slot_Date__c, MM_slot_StartTime__c, MM_Slot_End_Time__c, 
               MM_Slot_Status__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, MM_To_UPE__r.Attendee_Summary__r.Id, 
               MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c, OwnerId 
               FROM EventSchedule__c WHERE Id =: ESCH.id ];
                   
               GlobalUtillClass.NewSlotDetils nsd = new GlobalUtillClass.NewSlotDetils(newSlotDet, userRole);
               alDetail.NewSlotDetils.add(nsd);
           
           }
               
               
               return alDetail;
              }else{
              GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(ESCH.id, 'Rescheduling Failed');
              alDetail.globalSuccess.add(mssge);
              return alDetail;
              }
          }
          }
      }else{
          system.debug('status========================'+status);
          //List<string> timesplit =timeval.split('-');
          ESCH.MM_slot_Date__c = dateval ;
          ESCH.MM_slot_StartTime__c = timesplit[0];
          ESCH.Comments__c = comments;
          ESCH.MM_Slot_Status__c = status;
          ESCH.Is_Matchmaking__c = TRUE;
          ESCH.OwnerId = loginid;    
          //ESCH.MM_To_EAM__c = ESCH.MM_To_EAM__r.Id;
          //ESCH.EV_id__c  = ESCH.EV_id__r.Id;
          //ESCH.MM_To_UPE__c = ESCH.MM_To_UPE__r.User_id__r.Id;
          //ESCH.LastModifiedBy = loginid;
          /*List<string> sthour =timeval.split(':'); 
          integer hh = integer.valueof(sthour[0]);
          integer mm =  integer.valueof(sthour[1].subString(0, sthour[1].IndexOf(' ')));
          
          system.debug(hh+'    11111111111111111     '+ mm);
          
              if(mm+integer.valueOf(ed.Slot_Time_period__c) >= 60){
                  hh+=1;
                  mm = mm+integer.valueOf(ed.Slot_Time_period__c);
                  mm-= 60;
                   
              }else{
                  mm = mm+integer.valueOf(ed.Slot_Time_period__c);
              
              }
          String scheduleEndTime='';
              if(hh < 12 && timeval.Contains('AM' )){
                      scheduleEndTime = string.valueOf(hh+':'+mm +' AM');
              }else{
                       scheduleEndTime = string.valueOf(hh+':'+mm +' PM');
              }
              system.debug('   333333333333333333333   '+ scheduleEndTime );
              Time mmstartTime = Time.newInstance(hh, mm, 00, 00);
              time endtime = mmstartTime.addMinutes(integer.valueOf(ed.Slot_Time_period__c));
             */
             system.debug('   timesplit[0] - start time----- '+  timesplit[0]);
          // system.debug('   timesplit[1] - end time----- '+  timesplit[1]);
            try{
              ESCH.MM_Slot_End_Time__c = timesplit[1];
              }catch(exception er){}
              Database.upsert(ESCH,False);
              
              system.debug(' esid '+ESCH.id);
              system.debug(' MM_Slot_Status__c --------------- '+ed.Slot_Time_period__c);
              Id resultid = ESCH.id;
          
          
              if(resultid != NULL && (ESCH.MM_Slot_Status__c == 'Rejected' || ESCH.MM_Slot_Status__c == 'Accepted' || ESCH.MM_Slot_Status__c == 'Missed'  || ESCH.MM_Slot_Status__c == 'Cancelled')){
              GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(ESCH.id, 'Appointment '+ESCH.MM_Slot_Status__c);
              alDetail.globalSuccess.add(mssge);
              
             
              if(userRole=='Corporate'){
               EventSchedule__c newSlotDet = [SELECT Id, MM_slot_Date__c, MM_slot_StartTime__c, MM_Slot_End_Time__c, 
               MM_Slot_Status__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, MM_To_UPE__r.Attendee_Summary__r.Id, 
               MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, OwnerId 
               FROM EventSchedule__c WHERE Id =: ESCH.id ];
                   
               GlobalUtillClass.NewSlotDetils nsd = new GlobalUtillClass.NewSlotDetils(newSlotDet, userRole);
               alDetail.NewSlotDetils.add(nsd);
           }else if(userRole=='MBE'){
               EventSchedule__c newSlotDet = [SELECT Id, MM_slot_Date__c, MM_slot_StartTime__c, MM_Slot_End_Time__c, 
               MM_Slot_Status__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, MM_To_UPE__r.Attendee_Summary__r.Id, 
               MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c, OwnerId 
               FROM EventSchedule__c WHERE Id =: ESCH.id ];
                   
               GlobalUtillClass.NewSlotDetils nsd = new GlobalUtillClass.NewSlotDetils(newSlotDet, userRole);
               alDetail.NewSlotDetils.add(nsd);
           
           }
                   
               
               
               return alDetail;
              }else{
              GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(ESCH.id, 'Rescheduling Failed');
              alDetail.globalSuccess.add(mssge);
              return alDetail;
              }
          
      } 
      
      
 
// return alDetail;
 }
 
 
 
global class AllDetails{

List<GlobalUtillClass.globalSuccess> globalSuccess = new List<GlobalUtillClass.globalSuccess>();
List<GlobalUtillClass.NewSlotDetils> NewSlotDetils = new List<GlobalUtillClass.NewSlotDetils>();
List<GlobalUtillClass.globalMessage> globalMessage = new List<GlobalUtillClass.globalMessage>();
string eventscheduleStatus = '';
}
  

 }