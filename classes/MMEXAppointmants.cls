@RestResource(urlMapping='/MMEXAppointmants/*')

global without sharing class MMEXAppointmants{

@httpPost
 global static AllDetails doPost(){
  
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     string eveid;     
     string exhibitorid;
     String isMM;
     eveid =req.params.get('eveid');
     exhibitorid = req.params.get('exhibitorid');
     isMM = req.params.get('isMM');
     system.debug('eveid---'+eveid);
     system.debug('exhibitorid---'+exhibitorid);
    
     
     
         AllDetails alDetail = new AllDetails();
         User_Profile_Event__c exdtls = new User_Profile_Event__c();
         system.debug('        exid      ');
         
          FetchEventdetails evedetails= new FetchEventdetails();
        if(eveid!=null && eveid!=''){  
          try{
            if(null !=evedetails.evedetails(eveid)){
                 alDetail.eventscheduleStatus = evedetails.evedetails(eveid).Match_Making_Schedules__c;
            }
           }catch(exception er){} 
          } 
     
         
     
         map<string, EventSchedule__c> mapappointments=new  map<string, EventSchedule__c>();
         exdtls = [SELECT Attendee_Summary__r.AS_WorkPhone__c,Attendee_Summary__r.Id, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Email__c, 
         Attendee_Summary__r.Company_Certifications__c, Attendee_Summary__r.AS_CellPhone__c, Attendee_Summary__r.AS_ImageUrl__c, 
         Attendee_Summary__r.Exhibitor_company_imageUrl__c,  Attendee_Summary__r.AS_PrimaryBusinessCategory1__c, Attendee_Summary__r.As_SecondaryBusinessCategory1__c, 
         Attendee_Summary__r.AS_WebsiteUrl__c, Attendee_Summary__r.AS_WorkAddress1__c, 
         Attendee_Summary__r.AS_WorkAddress2__c, Attendee_Summary__r.AS_WorkCity__c, 
         Attendee_Summary__r.AS_Work_Country__c, Attendee_Summary__r.AS_Work_States__c, 
         Attendee_Summary__r.AS_WorkZip__c, Attendee_Summary__r.AS_Company__c, Attendee_Summary__r.AS_Title__c,
         Attendee_Summary__r.AS_NAICSCode_1__c, Attendee_Summary__r.AS_NAICSCode_2__c, 
         Attendee_Summary__r.AS_NAICSCode_3__c, Attendee_Summary__r.AS_NAICSCode_4__c, 
         Attendee_Summary__r.AS_NAICSCode_5__c, Attendee_Summary__r.Keywords__c,
         Attendee_Summary__r.AS_BusinessDescription__c,Attendee_Summary__r.Commodity_1__c,Attendee_Summary__r.Commodity_2__c,
         Attendee_Summary__r.Commodity_3__c,Attendee_Summary__r.Commodity_4__c,Attendee_Summary__r.Commodity_5__c, Attendee_Summary__r.Exceptional_Key_Words__c, 
         BT_id__r.Table_Room_No__c, BT_id__r.BT_Location__c, BT_id__r.MM_TableNo__c, User_id__r.Id,(select id,Break_End_Time__c,Break_Start_Time__c,Break_Title__c,Event_Attendee_Mapping__c,MatchLeads_Days__c,MatchLeads_Days__r.MatchLeads_Date__c from Event_Breaks__r where User_Profile_Event__c!=null)
         FROM User_Profile_Event__c WHERE IsMatchMakingUser__c = true AND MAtchMakingProfile__c = 'Corporate' AND User_id__r.Id =:exhibitorid AND EV_id__r.Id =: eveid];         
         
          if(null != exdtls){
            for(Event_Breaks__c Ebc:exdtls.Event_Breaks__r){
              GlobalUtillClass.MMBlockedslots gn = new GlobalUtillClass.MMBlockedslots(Ebc);
              alDetail.BlockedSchedules.add(gn);
           }
          
          }
         
         
         GlobalUtillClass.MMEXHDetails mmexdtls = new GlobalUtillClass.MMEXHDetails(exdtls);
         alDetail.MMEXHDetails.add(mmexdtls);
         system.debug('exdtls.AS_Email__c----------'+exdtls.Attendee_Summary__r.AS_Email__c);
       
        
         /* This code works only for "Shelly" Event - "Connecticut Business Advantage 2014 Training and Matchmaker Event", This should be deleted after the event. */ 
      if(eveid == 'a00F0000009tZ6dIAE'){
      
      GlobalUtillClass.MMEXAppointmentlist reslt = new GlobalUtillClass.MMEXAppointmentlist(new EventSchedule__c()); 
      return alDetail;
      }else{
      /* This code works only for "Shelly" Event - "Connecticut Business Advantage 2014 Training and Matchmaker Event", This should be deleted after the event. */ 
     
         
         List<EventSchedule__c> ess = [SELECT ID, MM_slot_StartTime__c, NAME, MM_slot_Date__c, MM_Slot_End_Time__c, MM_Slot_Status__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_Company__c, MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_EAM__r.AS_id__r.Id, MM_To_UPE__r.BT_id__r.MM_TableNo__c, EV_id__r.EV_Title__c, EV_id__r.Id, OwnerId 
                                     FROM EventSchedule__c 
                                     WHERE EV_id__r.Id =: eveid 
                                     AND Is_Matchmaking__c = true
                                     AND MM_To_UPE__r.User_id__r.Id =:exhibitorid 
                                     AND Is_Matchmaking__c = TRUE ];
         for(EventSchedule__c es: ess){
            mapappointments.put(es.MM_slot_Date__c+es.MM_slot_StartTime__c,es);
            GlobalUtillClass.MMEXAppointmentlist reslt = new GlobalUtillClass.MMEXAppointmentlist(es); 
       
       //  alDetail.MMEXAppointmentlist.add(reslt); 
         }
     
         Event__c Evdetails=[select MM_Start_Date__c,MM_End_Date__c,MM_Slot_Timeperiod__c,BreakTime_Between_Appointments__c,MM_Firstaday_startTime__c,
                                     MM_Firstaday_EndTime__c,MM_Secondaday_startTime__c,MM_Secondaday_EndTime__c from Event__c where id =: eveid];
         
        /* 
                if(Evdetails.MM_Slot_Timeperiod__c == null)
             Evdetails.MM_Slot_Timeperiod__c = '0';
             if(Evdetails.BreakTime_Between_Appointments__c == null)
             Evdetails.BreakTime_Between_Appointments__c = '0';
         */
         
         
         //------------------------------------------------------SCHEDULE---------------
          list<string> appointments=new list<string> ();
          list<string> scheduled=new list<string>();
          list<string> nonscheduled = new list<string>();
          MAP<Date,MAP<String,EventSchedule__c>> exapts = new MAP<Date,MAP<String,EventSchedule__c>>();
          
          
          system.debug( '      service0000       '+Evdetails.MM_Firstaday_startTime__c + '      '+Evdetails.MM_Firstaday_EndTime__c+'     '+Evdetails.MM_Slot_Timeperiod__c+'        '+Evdetails.BreakTime_Between_Appointments__c);
          
          //appointments=MM_Utility.givesSlotTimings(Evdetails.MM_Firstaday_startTime__c,Evdetails.MM_Firstaday_EndTime__c,Evdetails.MM_Slot_Timeperiod__c,Evdetails.BreakTime_Between_Appointments__c);
         //
         exapts =MM_Utility.exhibitorScheduleTimings(eveid, exhibitorid);
        
         system.debug( '     MALLIKKKKKKKKKK      '+exapts.size() +'     '+ exapts.keySet() );         
         
         system.debug( '     MALLIKKKKKKKKKK      '+exapts.size() +'     '+ exapts);       
         
         for(Date schDat:exapts.keySet()){
            
             system.debug( '     JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ   '+alDetail.MMEXAppointmentlist.size());      
            
             system.debug( '     MALLIKKKKKKKKKK   2222222222222222   '+exapts.get(schDat).size() + '      '+ exapts.get(schDat));       
            
             MAP<String,EventSchedule__c> Exschdules = new MAP<String,EventSchedule__c>();
             Exschdules = exapts.get(schDat);
             // alDetail.MMEXAppointmentlist = null;
             LIST<GlobalUtillClass.MMEXAppointmentlist> dateWiseSchedules = new LIST<GlobalUtillClass.MMEXAppointmentlist>();
            
             for(EventSchedule__c es: Exschdules.values()){
                 mapappointments.put(es.MM_slot_Date__c+es.MM_slot_StartTime__c,es);
                 GlobalUtillClass.MMEXAppointmentlist reslt = new GlobalUtillClass.MMEXAppointmentlist(es); 
                 alDetail.MMEXAppointmentlist.add(reslt);
                 //dateWiseSchedules.add(reslt);
             }
           }
         }
         
          MAP<Date, LIST<String>> ExFreeSlots = new MAP<Date, LIST<String>> ();
          ExFreeSlots = MM_Utility.exhibitorTimings(eveid, exhibitorid);
       
         for(Date d: ExFreeSlots.keySet()){
            LIST<String> dateSlots = ExFreeSlots.get(d);
              
               for(String s: dateSlots ){
                  string datevalue=string.valueof(d);
                  GlobalUtillClass.MMEXOpenslots reslt = new GlobalUtillClass.MMEXOpenslots(s,datevalue); 
                  alDetail.MMEXOpenslotslist.add(reslt);
              }
            
            system.debug('WWWWWWWWWWWWWWWWWW33333333333      '+ alDetail.MMEXOpenslotslist.size());
            
         }
         
       
        /*  for(string ss:appointments){
              LIST<String> timings = new LIST<String>();
              timings.addAll(ss.split('-'));
              if(mapappointments.ContainsKey(timings[0])){
                   scheduled.add(ss);
              }else{
               string datevalue=string.valueof(Evdetails.MM_Start_Date__c);
               nonscheduled.add(ss); 
               GlobalUtillClass.MMEXOpenslots reslt = new GlobalUtillClass.MMEXOpenslots(ss,datevalue); 
               alDetail.MMEXOpenslotslist.add(reslt);
              }
               
        
          /**
           for(EventSchedule__c es: ess){  
            if(ss.startswith(es.MM_slot_StartTime__c)){
            scheduled.add(ss);
            }
            else
            {
            nonscheduled.add(ss);
           }}
            ****************************************
           // GlobalUtillClass.MMEXFixedAppntsslots reslt = new GlobalUtillClass.MMEXFixedAppntsslots(ss); 
           // alDetail.MMEXFixedAppntsslots.add(reslt);
          system.debug('        nonschedule       '+nonscheduled);                
          }
          */
        

         //------------------------------------------------------------------------------
        //GlobalUtillClass.MMEXAppointmentlist reslt = new GlobalUtillClass.MMEXAppointmentlist(ess); 
        //alDetail.MMEXAppointmentlist.add(reslt);
        //system.debug('reslt---'+reslt);
        return alDetail;  
    

}
//--------------------------------inner class--------------------------
     class InnerForTimeslots{
       public String Stime{get;set;}
       public String ETime{get;set;}
       public InnerForTimeslots(string Stime  , string ETime ){
           this.Stime = Stime  ;
           this.ETime = ETime ;
       }
   }
   //----------------------------------------------------------------
         
         

global class AllDetails{
List<GlobalUtillClass.UserDetails> userProfile = new List<GlobalUtillClass.UserDetails>();
List<GlobalUtillClass.MMEXHDetails> MMEXHDetails = new List<GlobalUtillClass.MMEXHDetails>();
List<GlobalUtillClass.MMEXAppointmentlist> MMEXAppointmentlist = new List<GlobalUtillClass.MMEXAppointmentlist>();
List<GlobalUtillClass.MMEXOpenslots> MMEXOpenslotslist = new List<GlobalUtillClass.MMEXOpenslots>();
List<GlobalUtillClass.globalMessage> globalMessage = new List<GlobalUtillClass.globalMessage>();
 List<GlobalUtillClass.MMBlockedslots> BlockedSchedules= new List<GlobalUtillClass.MMBlockedslots>();
//List<GlobalUtillClass.MMExScheduledApts> newMMEXShedulesSlotslist = new List<GlobalUtillClass.MMExScheduledApts>();
string eventscheduleStatus = '';
}
}