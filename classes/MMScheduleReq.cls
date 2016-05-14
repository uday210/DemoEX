@RestResource(urlMapping='/MMScheduleReq/*')


global without Sharing class MMScheduleReq{

@httpPost
global static AllDetails doPost(){
 
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string eveid;     
     string exhid;
     String attid;
     Date dateval;
     String CompDate;
     String timeval;
     String comments;
     String status;
     String loginid;
     
     
     eveid =req.params.get('eveid');
     exhid = req.params.get('exhid');
     attid = req.params.get('attid');
     CompDate = req.params.get('dateval');
     dateval = Date.Valueof(req.params.get('dateval'));     
     timeval = req.params.get('timeval');
     comments = req.params.get('comments');
     status = req.params.get('status');
     loginid = req.params.get('loginid');
     
     List<string> timesplit =timeval.split('-');
     
  system.debug('eveid------'+eveid);
   system.debug('exhibitorid------'+exhid );
    system.debug('dateval ------'+dateval );
     system.debug('attid------'+attid); // this is Event Attendee Mapping ID
      system.debug('timeval------'+timeval); 
       system.debug('status------'+status);
        system.debug('loginid ------'+loginid );
      
      AllDetails alDetail = new AllDetails();
      alDetail.eventscheduleStatus ='Live';
        FetchEventdetails evedetails= new FetchEventdetails();
        Event__c EventDet = new Event__c();
       
        if(eveid!=null && eveid!=''){  
          try{
            if(null !=evedetails.evedetails(eveid)){
                 EventDet = evedetails.evedetails(eveid);
                 alDetail.eventscheduleStatus = evedetails.evedetails(eveid).Match_Making_Schedules__c;
                 if(alDetail.eventscheduleStatus=='Closed'){
                   return alDetail;
                 }
            }
           }catch(exception er){} 
          } 
      
      
     
      //Eent_Attendee_Mapping__c eam = [SELECT Id FROM Event_Attendee_Mapping__c WHERE AS_id__r.Id =:attid AND EV_id__r.Id =: eveid];
      
     /* 
     // DateTime dt1 = DateTime.newInstance(2014,m,d,h,m,s,a);
     LIST<String> splitdt = CompDate.split('-');
     Integer cony = integer.valueOf(splitdt[0]);
     Integer conm = integer.valueOf(splitdt[1]);
     Integer cond = integer.valueOf(splitdt[2]);
     //Datetime dt1 = datetime.valueOf(splitdt[0]+'-'+splitdt[1]+'-'+splitdt[2]+' '+'00:00:00');
     
      system.debug('System.now()================='+System.now());
      //system.debug('Date()================='+ date());
      Integer ssplit;
      List<string> splitTm = timeval.split(':');
      system.debug('splitTm[0]========='+splitTm[0]);
      system.debug('splitTm[1]========='+splitTm[1]);
      if(timeval.Contains('PM' )){
          Integer sh = integer.valueOf(splitTm[0]);
          Integer sh1 = sh + 12;
          if(sh1==24){
                  ssplit = 00;
          }else{
              ssplit = sh1;
          }
      }else{
          Integer sh1 = integer.valueOf(splitTm[0]);
          ssplit = sh1;
      }
      
      Integer smsplit = Integer.Valueof(splitTm[1].subString(0, splitTm[1].IndexOf(' ')));
      system.debug('splittime=========    hrs=='+ssplit+'        minuts=='+smsplit);
      //Datetime dt1 = datetime.valueOf(splitdt[0]+'-'+splitdt[1]+'-'+splitdt[2]+' '+ssplit+':'+smsplit+':00');
       //system.debug('dt1================='+dt1);
      
      datetime cdt = datetime.newInstance(cony,conm,cond, ssplit, smsplit, 00);
      datetime cdtGmt = datetime.newInstanceGmt(cony,conm,cond, ssplit, smsplit, 00);
      datetime cdtlocal = datetime.valueOf(cony+'-'+conm+'-'+cond+' '+ssplit+':'+smsplit+':'+00);
       system.debug('condt================='+cdt);
       system.debug('condtGmt================='+cdtGmt);
       system.debug('cdtlocal ================='+cdtlocal );
       if(cdt<System.now()){
            system.debug('req time is less than current time');
            GlobalUtillClass.globalMessage mssge = new GlobalUtillClass.globalMessage('Invalid Date or time');
            alDetail.globalMessage.add(mssge);
            return alDetail;
       }else{
           
           system.debug('reqtime is greater than current time');
       }
       */
       
       
      
      /* This code works only for "Shelly" Event - "Connecticut Business Advantage 2014 Training and Matchmaker Event", This should be deleted after the event. */ 
      if((EventDet.Match_Making_Schedules__c == 'Closed' || EventDet.Stop_Schedule_for_Mobile__c) && status!='cancelled'){
          GlobalUtillClass.globalMessage mssge = new GlobalUtillClass.globalMessage('You are not authorized to schedule for this event. Please down load the latest version of app.');
          alDetail.globalMessage.add(mssge);
          return alDetail;
      }
      /* This code works only for "Shelly" Event - "Connecticut Business Advantage 2014 Training and Matchmaker Event", This should be deleted after the event. */ 
       
       
       
      List<MatchLeads_Days__c> checkEveDate = [SELECT Id, MAX_noOf_appontments__c FROM MatchLeads_Days__c WHERE Event__r.Id =:eveid AND MatchLeads_Date__c =:dateval ];
      if(checkEveDate.size()>0){     
          
      Integer appnmntsPerDay = Integer.Valueof(checkEveDate[0].MAX_noOf_appontments__c);
      system.debug('appnmntsPerDay======'+appnmntsPerDay);
      
      List<EventSchedule__c> eamAppntmnts = [SELECT Id, EV_id__c,MM_To_UPE__c,MM_slot_Date__c, MM_slot_StartTime__c 
                             FROM EventSchedule__c 
                             WHERE EV_id__c=:eveid 
                             AND MM_To_EAM__r.Id=:attid
                             AND MM_slot_Date__c =: dateval 
                             AND Is_Matchmaking__c =: TRUE 
                             AND (MM_Slot_Status__c = 'Accepted' or MM_Slot_Status__c = 'Pending') ];
      
       system.debug('eamAppntmnts======'+eamAppntmnts.size());          
       //totalExeAppntmnts = upeAppntmnts.size();
       //system.debug('upeAppntmnts======'+totalExeAppntmnts);                     
       if(eamAppntmnts.size()>=appnmntsPerDay){
           system.debug('You have reached maximum number of Appointments for that day');
           GlobalUtillClass.globalMessage mssge = new GlobalUtillClass.globalMessage('You have reached maximum number of Appointments for the day');
           alDetail.globalMessage.add(mssge);
           return alDetail;
       }                     
      
      User_Profile_Event__c upe = [SELECT Id,MAtchMakingProfile__c, EV_id__r.MM_Slot_Timeperiod__c, EV_id__r.MM_Start_Date__c,EV_id__r.MM_End_Date__c  FROM User_Profile_Event__c WHERE IsMatchMakingUser__c = true AND User_id__r.Id =:exhid AND EV_id__r.Id =: eveid];
      
      Date checkeveate = Date.ValueOf(dateval);
      
      List<EventSchedule__c> checkattslot = [SELECT Id, EV_id__c,MM_To_UPE__c,MM_slot_Date__c, MM_slot_StartTime__c 
                             FROM EventSchedule__c 
                             WHERE EV_id__c=:eveid 
                             AND MM_To_EAM__r.Id =: attid /* AND MM_To_UPE__r.User_id__r.Id=:exhid */ 
                             AND MM_slot_StartTime__c =: timeval AND MM_slot_Date__c =: dateval 
                             AND Is_Matchmaking__c =: TRUE 
                             AND (MM_Slot_Status__c = 'Accepted' or MM_Slot_Status__c = 'Pending') ];
                             
      if(checkattslot.size()>0){
      system.debug('slot is booked');
      GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(checkattslot[0].Id, 'You already have an appointment at this time');
      alDetail.globalSuccess.add(mssge);
      return alDetail;
      }else {      
     
      List<EventSchedule__c> checkslot = [SELECT Id, EV_id__c,MM_To_UPE__c,MM_slot_Date__c, MM_slot_StartTime__c 
                             FROM EventSchedule__c 
                             WHERE EV_id__c=:eveid 
                             AND MM_To_EAM__r.Id =: attid 
                             AND MM_To_UPE__r.User_id__r.Id=:exhid 
                             AND /* MM_slot_StartTime__c =: timeval AND*/ MM_slot_Date__c =: dateval 
                             AND Is_Matchmaking__c =: TRUE 
                             AND (MM_Slot_Status__c = 'Accepted' or MM_Slot_Status__c = 'Pending') ];
      if(checkslot.size()>0){
      system.debug('slot is booked');
      GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(checkslot[0].Id, 'You have reached the maximum appointment limit with '); /* You cannot schedule more than one appointment with a Exhibitor */ 
      alDetail.globalSuccess.add(mssge);
      return alDetail;
      }else{
      system.debug('slot is not booked yet');
      system.debug('--------------Event Id------: '+eveid);
      Event__c E = new Event__c ();
      E = [select id,MatchMaking_Type__c from Event__c Where id =: eveid ];
      
      MatchLeads_Days__c ed = new MatchLeads_Days__c();
      ed = [SELECT Id,MatchLeads_Date__c,Slot_Time_period__c, MAX_noOf_appontments__c FROM MatchLeads_Days__c WHERE Event__c =:eveid AND MatchLeads_Date__c=:dateval];
      system.debug('--------------Match Making Type------: '+E.MatchMaking_Type__c);
      EventSchedule__c ESCH= new  EventSchedule__c();
      ESCH.EV_id__c  = eveid;
      ESCH.MM_To_UPE__c = upe.id ;
      ESCH.MM_slot_Date__c = dateval ;
      //ESCH.MM_slot_StartTime__c = timeval;
      ESCH.MM_slot_StartTime__c = timesplit[0];
      ESCH.Is_Matchmaking__c = TRUE;
      ESCH.Comments__c = comments;
      if(E.MatchMaking_Type__c == 'Semi Open'){
      ESCH.MM_Slot_Status__c = 'Pending';
      }else if(E.MatchMaking_Type__c == 'Open'){
      ESCH.MM_Slot_Status__c = 'accepted';
      }
      else if(E.MatchMaking_Type__c == 'Closed'){
      ESCH.MM_Slot_Status__c = 'accepted';
      }
      ESCH.OwnerId = loginid;
      //ESCH.LastModifiedBy.Id = loginid;      
      ESCH.MM_To_EAM__c = attid;
      
      /*List<string> sthour =new List<string>();
      sthour =timeval.split(':'); 
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
                 if(hh<=9){
                  scheduleEndTime = string.valueOf('0'+hh+':'+mm +' AM');
              }else{
                  scheduleEndTime = string.valueOf(hh+':'+mm +' AM');
              }
      }else{
       if(hh<=9){
                   scheduleEndTime = string.valueOf('0'+hh+':'+mm +' PM');
               }else{
                   scheduleEndTime = string.valueOf(hh+':'+mm +' PM');
               }
      }
     
     
      Time mmstartTime = Time.newInstance(hh, mm, 00, 00);
      //Time scheduleEndTime = Time.newInstance(hh, mm, 00, 00);
       system.debug('   333333333333333333333   '+ scheduleEndTime );
       
      //time endtime = mmstartTime.addMinutes(integer.valueOf(upe.EV_id__r.MM_Slot_Timeperiod__c));
      //ESCH.MM_Slot_End_Time__c = string.valueof(endtime);
      
      */
      //ESCH.MM_Slot_End_Time__c = scheduleEndTime;
      ESCH.MM_Slot_End_Time__c = timesplit[1];
      insert ESCH;
      system.debug(' esid '+ESCH.id);
      Id resultid = ESCH.id;
      
      
      if(resultid != NULL){
      
      GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(ESCH.id, 'Succesfully Scheduled');
      alDetail.globalSuccess.add(mssge);
      
      if(upe.MAtchMakingProfile__c == 'MBE'){
      
              EventSchedule__c newSlotDet = [SELECT Id, MM_slot_Date__c, MM_slot_StartTime__c, MM_Slot_End_Time__c, 
                  MM_Slot_Status__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, MM_To_UPE__r.Attendee_Summary__r.Id, 
                  MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, OwnerId 
                  FROM EventSchedule__c WHERE Id =: ESCH.id ];
         
          GlobalUtillClass.NewSlotDetils nsd = new GlobalUtillClass.NewSlotDetils(newSlotDet, 'Corporate');
          alDetail.NewSlotDetils.add(nsd);
      }else  if(upe.MAtchMakingProfile__c == 'Corporate'){
      
              EventSchedule__c newSlotDet = [SELECT Id, MM_slot_Date__c, MM_slot_StartTime__c, MM_Slot_End_Time__c, 
                  MM_Slot_Status__c, MM_To_UPE__r.BT_id__r.MM_TableNo__c, MM_To_UPE__r.Attendee_Summary__r.Id, 
                  MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c, OwnerId 
                  FROM EventSchedule__c WHERE Id =: ESCH.id ];
         
          GlobalUtillClass.NewSlotDetils nsd = new GlobalUtillClass.NewSlotDetils(newSlotDet, 'MBE');
          alDetail.NewSlotDetils.add(nsd);
      }
      
      
      return alDetail;
      }else{
      GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess(ESCH.id, 'Scheduling Failed');
     alDetail.globalSuccess.add(mssge);
     return alDetail;
      }
      }
      }
      
      
    }else{
      GlobalUtillClass.globalSuccess mssge = new GlobalUtillClass.globalSuccess('', 'Invalid Date for this event');
      alDetail.globalSuccess.add(mssge);
      return alDetail;
    }
      
 return null;

 }
 
 
 
global class AllDetails{
List<GlobalUtillClass.globalMessage> globalMessage = new List<GlobalUtillClass.globalMessage>();
List<GlobalUtillClass.globalSuccess> globalSuccess = new List<GlobalUtillClass.globalSuccess>();
List<GlobalUtillClass.NewSlotDetils> NewSlotDetils = new List<GlobalUtillClass.NewSlotDetils>();
string eventscheduleStatus = '';
}
  

 }