public class getEamsForEvent{
  public SET<integer> eams(String eventId){
    SET<integer> uniqNums = new  SET<integer>();
     for(Event_Attendee_Mapping__c em :[SELECT id,UniqNo__c from Event_Attendee_Mapping__c where EV_id__c = :eventId ]){
       if(null != em.UniqNo__c ){
         try{
          uniqNums.add(integer.valueOf(em.UniqNo__c));
         }catch(exception ed){}
       } 
     }
     return uniqNums;
  }  
}