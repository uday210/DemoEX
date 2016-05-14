trigger matchLeadsupdate on Event_Attendee_Mapping__c (after insert) {
   try{
    list<id> eamlist=new list<id>{};
    list<Event_Attendee_Mapping__c> eamlist1 =new list<Event_Attendee_Mapping__c>{};
    list<Event_Attendee_Mapping__c> eamlist2 =new list<Event_Attendee_Mapping__c>{};
    for(Event_Attendee_Mapping__c eamnew : trigger.new){  
    eamlist.add(eamnew.id);
    
    }
    
    eamlist1 = [select id,EV_id__r.Is_MatchMaking_Event__c from Event_Attendee_Mapping__c where id IN :eamlist];
    for(Event_Attendee_Mapping__c eamnew1 : eamlist1 ){
    if(eamnew1.EV_id__r.Is_MatchMaking_Event__c == true){
    Event_Attendee_Mapping__c EAM=new Event_Attendee_Mapping__c(id = eamnew1.id, IsMatchMakingAttendee__c = true);
    eamlist2.add(EAM);
    
    }
    }
    
    Update eamlist2;
    }catch(Exception e){}
    
    }