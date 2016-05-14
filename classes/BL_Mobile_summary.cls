public with sharing class BL_Mobile_summary {

  // Pleasse see "Test_MM_MatchesCon" for test class i used same class for both 

  public LIST<EventSchedule__c> eventscheduleDB{get;set;}
  public List<selectOption> linkOptions{get;set;}
  public string selectedValue{get;set;}
  public string selectedEvent {get;set;}
  public LIST<MatchLeads_Days__c> allEventDates{get; set;} 
  public Event__c scheduleEvent{get; set;}
  public MAP<Date , LIST<String>> getDataFromUtility{get; set;}
  public LIST<String> eventTimeSlots{get; set;}
  public List<incls> inn{get;set;}  
  public List<User_Profile_Event__c> boothsInevents{get;set;}
  
  
  public BL_Mobile_summary(){
     linkOptions = new List<selectOption>();
     eventTimeSlots= new LIST<String>();
     eventscheduleDB =new LIST<EventSchedule__c>();
     getDataFromUtility= new MAP<Date, LIST<String>>();
     inn =new List<incls>();
     boothsInevents =new List<User_Profile_Event__c>();
     
     linkOptions.add(new selectOption('Event Schedule','Event Schedule'));
     linkOptions.add(new selectOption('Match Making Corporates','Match Making Corporates'));
     linkOptions.add(new selectOption('Trade Show Directory','Trade Show Directory'));
     selectedValue ='Event Schedule';
     selectedEvent =Apexpages.currentPage().getParameters().get('id');
     allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: selectedEvent ORDER BY MatchLeads_Date__c ASC]);
     
     LIst<User_Profile_Event__c> upes  = new List<User_Profile_Event__c>();
     upes =[select Attendee_Summary__r.Keywords__c,id,Attendee_Summary__c,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Email__c,user_id__r.NAme,
     Attendee_Summary__r.AS_Company__c,BT_id__r.BT_Name__c,BT_id__r.MM_TableNo__c,BT_id__r.BT_ContactEmail__c,BT_id__r.BT_ContactName__c,
     (SELECT ES_StartDate__c,MM_slot_Date__c ,MM_slot_StartTime__c ,MM_Slot_End_Time__c,name,ES_StartTime__c,id, ES_Description__c, ES_EndTime__c, ES_Location__c, ES_Presenter__c,ES_ProgramName__c FROM EventSchedule__r where MM_Slot_Status__c='Pending' OR MM_Slot_Status__c='Accepted')      
     from  User_Profile_Event__c where EV_id__c=:selectedEvent  and MAtchMakingProfile__c='Corporate' order By BT_id__r.MM_TableNo__c nulls last];
     
    // MAP<User_Profile_Event__c,MAP<date,List<string>>> mapUpeWithDt = new MAP<User_Profile_Event__c,MAP<date,List<string>>>(); 
     
     if(allEventDates.size() >0){
        for(MatchLeads_Days__c matchDate: allEventDates){
          getDataFromUtility= MM_Utility.giveEventTimingsWithDates(selectedEvent, matchDate.MatchLeads_Date__c);   
          eventTimeSlots= getDataFromUtility.get(matchDate.MatchLeads_Date__c);      
        }                 
     }  
     
     
       List<Event_Breaks__c> evebreak =[select User_Profile_Event__r.id,MatchLeads_Days__r.MatchLeads_Date__c,id,Break_Start_Time__c,Break_End_Time__c,Break_Title__c,MatchLeads_Days__c,User_Profile_Event__c,name from Event_Breaks__c  where User_Profile_Event__c!=null  and User_Profile_Event__r.Ev_id__C=:selectedEvent ];       
      
       SET<string>  upeIds12 = new SET<string>();
        for(Event_Breaks__c ebm :evebreak ){
                upeIds12.add(ebm.User_Profile_Event__r.id);
        }
        
      MAP<id,SET<string>>  mapupeWithDateAndtime = new MAP<id,SET<string>>();
       
       system.debug('FFFFFFFFFFFFFFFFF '+allEventDates);
       
       for(string upId : upeIds12){
         SET<string> badminBreak = new SET<string>();
            for(Event_Breaks__c eb :evebreak ){
              if(eb.User_Profile_Event__c ==upId ){
                 badminBreak.add(eb.Break_Start_Time__c+'-'+eb.Break_End_Time__c);
               }       
            }
        mapupeWithDateAndtime.put(upId,badminBreak); 
        /*  MAP<date,SET<string>> mapdateWithTimes  = new MAP<date,SET<string>>();
          for(MatchLeads_Days__c matchDate: allEventDates){
            SET<string> badminBreak = new SET<string>();
           
            for(Event_Breaks__c eb :evebreak ){
             system.debug('EEEEEEEEEEEEEEEEEEEE '+matchDate+' RRRRRRRRRRRRRRRRRR '+eb.MatchLeads_Days__r.MatchLeads_Date__c);
             if(eb.MatchLeads_Days__r.MatchLeads_Date__c==matchDate.MatchLeads_Date__c){
                badminBreak.add(eb.Break_Start_Time__c+'-'+eb.Break_End_Time__c);
             }
            }
            mapdateWithTimes.put(matchDate.MatchLeads_Date__c,badminBreak);
         }
         mapupeWithDateAndtime.put(upid,mapdateWithTimes);*/
         
         
       }   
        
    
     
     
     for(User_Profile_Event__c upe : upes){
      if(upe.IsMatchMakingUser__c=true){ 
       MAP<date,List<string>> mapDtWithTm = new MAP<date,List<string>>();
         for(MatchLeads_Days__c Mdate: allEventDates){
           system.debug('PPPPPPPPPPPPPPPPPpp '+Mdate);
           List<string> strs = new List<string>();
            for(EventSchedule__c eves : upe.EventSchedule__r){
             system.debug('QQQQQQQQQQQQQQQQQQQQ '+eves.MM_Slot_End_Time__c);
               if(Mdate.MatchLeads_Date__c ==eves.MM_slot_Date__c){
                 strs.add(eves.MM_slot_StartTime__c +'-'+eves.MM_Slot_End_Time__c); 
              }
            }
           mapDtWithTm.put(Mdate.MatchLeads_Date__c ,strs);   
          }  
          
          if(null!=mapupeWithDateAndtime.get(upe.id)){
             inn.add(new incls(upe,getDataFromUtility,mapDtWithTm,mapupeWithDateAndtime.get(upe.id)));
          }else{
             inn.add(new incls(upe,getDataFromUtility,mapDtWithTm,new  SET<string>()));
          }
          
             
       }
      boothsInevents.add(upe);  
    }    
       
     
     onchange();
    }
   
   
   public boolean schedules{get;set;}
   public boolean Corpoartes{get;set;}
   public boolean BoothsBool{get;set;}
   
   public void onchange(){
   Corpoartes =false;
   schedules =false;
   BoothsBool =false;
    if(selectedValue=='Event Schedule'){
      schedules  =true;
       if(eventscheduleDB.size()==0){ 
         eventscheduleDB = [SELECT ES_StartDate__c,ES_EndDate__c,name,ES_StartTime__c,id, ES_Description__c, ES_EndTime__c, ES_Location__c, ES_Presenter__c,ES_ProgramName__c FROM EventSchedule__c WHERE EV_id__c =:selectedEvent and MM_To_UPE__c=null and MM_To_EAM__c=null order by ES_StartDate__c,ES_StartTime__c];
       }
     }else if(selectedValue=='Match Making Corporates'){
        Corpoartes =true;
     }else if(selectedValue=='Trade Show Directory'){
        BoothsBool =true;
     }
   
  }
   

 public class incls{
   public User_Profile_Event__c  upeInn{get;set;}
   public List<inc> incInn {get;set;}
    public incls(User_Profile_Event__c upi,MAP<Date , LIST<String>> getData, MAP<date,List<string>> mapDtWithTmin,SET<string> badminBreaksinn){
    system.debug('WWWWWWWWWWWWWWWWWW '+mapDtWithTmin);
    
      upeInn = new User_Profile_Event__c();
      incInn = new List<inc>();
      upeInn =upi;
      
      
       for(date d:getData.keySet()){
         LIST<String> EveDateList = new LIST<String>();
          EveDateList  = getData.get(d);
        
            SET<String> strE = new SET<String>();
           strE.addAll(EveDateList);
          
          if(badminBreaksinn!=null){
              strE.removeAll(badminBreaksinn);
          } 
        
                 
          SET<String> strR = new SET<String>();
          strR.addAll(mapDtWithTmin.get(d));
          strE.REmoveAll(strR); 
          
          LIST<String> EveDateListAfterSort = new LIST<String>();
          
            for(string strd :EveDateList){
               if(strE.contains(strd)){
                 EveDateListAfterSort.add(strd);
               }
            }         
          incInn.add(new inc(d,EveDateListAfterSort));
       }
    }
 
 }
 
 public class inc{
   public date dt{get;set;}
   public List<string> strList{get;set;}
   public inc(date d,List<string> strListin){
      strList = new List<string>();
      this.strList  = strListin;
      this.dt = d;
   }
 
 }
 

}