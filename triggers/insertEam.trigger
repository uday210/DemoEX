trigger insertEam on Dummay__c(before insert, before update){
   // try{
    SET<string> attendeeEmails= new SET<string>();

    id EventId;

        for(Dummay__c reg: trigger.new){
            system.debug('  REG INFO '+reg);       
            attendeeEmails.add(reg.Email__c);
            EventId= reg.Event__c;
        }
        system.debug(EventId+'  ATTENEDEE EMAILS '+attendeeEmails);
        LIST<Event_Attendee_Mapping__c> EAMsList= new LIST<Event_Attendee_Mapping__c>();        
        EAMsList= [SELECT ID, AS_id__c, AS_id__r.AS_Email__c FROM Event_Attendee_Mapping__c WHERE EV_id__c =: EventId AND AS_id__r.AS_Email__c IN: attendeeEmails];      
        MAP<String, Event_Attendee_Mapping__c> EAMsListMAP= new MAP<String, Event_Attendee_Mapping__c>();
        
        for(Event_Attendee_Mapping__c eam: EAMsList){
            EAMsListMAP.put(eam.AS_Id__r.AS_Email__c, eam);        
        }
        
        if(EAMsListMAP.size() >0){
            for(Dummay__c reg: trigger.new){
            
              if(EAMsListMAP.keySet().contains(reg.Email__c)){
                if(reg.Payment_Type__c == 'Free'){
                    reg.Payment_Status__c= 'Paid';
                }
                if(EAMsListMAP.get(reg.Email__c).AS_Id__c != NULL && reg.AttendeeSummary__c == NULL){
                    reg.AttendeeSummary__c= EAMsListMAP.get(reg.Email__c).AS_Id__c;
                }
                if(EAMsListMAP.get(reg.Email__c).Id != NULL && reg.Event_Attendee_Mapping__c == NULL){
                    reg.Event_Attendee_Mapping__c= EAMsListMAP.get(reg.Email__c).Id;
                }
              }
    
          }
        }
    
     
}