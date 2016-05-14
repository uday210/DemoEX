trigger updateScheduleStatus on User_Profile_Event__c (after Update) {
   boolean isMatchmakingEvent=false;
     if (Trigger.isAfter) {
      if(trigger.new.size()>0){
          isMatchmakingEvent = (trigger.new)[0].IsMatchMakingUser__c;
        }
    }
    
  List<id> corporates = new List<id>();  
  List<id> attendees= new List<id>();  
    
  if(isMatchmakingEvent){
     for(User_Profile_Event__c upe : trigger.new){
         if(upe.MAtchMakingProfile__c != Trigger.oldMap.get(upe.ID).MAtchMakingProfile__c ){
             if(upe.MAtchMakingProfile__c=='MBE'){
               corporates.add(upe.id); 
             }else{
               attendees.add(upe.Attendee_Summary__c); 
             }
         }
     }    
   
  
  if(corporates.size()>0){
     List<EventSchedule__c> eveschedule = new List<EventSchedule__c>();
     for(EventSchedule__c es :[select id,MM_Slot_Status__c from EventSchedule__c where MM_To_UPE__c  in :corporates]){
        es.MM_Slot_Status__c ='Cancelled';
        eveschedule.add(es); 
     }
    dataBAse.update(eveschedule);
  }
  
  if(attendees.size()>0){
   List<EventSchedule__c> eveschedule1 = new List<EventSchedule__c>();
     for(EventSchedule__c es :[select id,MM_Slot_Status__c,MM_To_EAM__r.As_Id__c from EventSchedule__c where MM_To_EAM__r.As_Id__c in :attendees]){
        es.MM_Slot_Status__c ='Cancelled';
        eveschedule1.add(es); 
     }
      dataBAse.update(eveschedule1);
   }
 }  
    
/**
 System.debug('********Trigger values***********');    
        System.debug('***SFDC: Trigger.old is: ' + Trigger.old);
        System.debug('***SFDC: Trigger.new is: ' + Trigger.new);
       
      **/ 
}