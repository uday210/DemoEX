public without sharing class BLN_Device_Usage_DAO{
   
     
    //Getting Leads for an Event
   public List<Device_Usage__c> getDeviceUsage(String eventId){
     List<Device_Usage__c> device=[SELECT Name,Device_OS__c,BLN_TKT_profile__c FROM Device_Usage__c WHERE Event__c = :eventId];
     if(device.size() > 0){
          return device;
     }else{
         return new LIST<Device_Usage__c>();
     }
   
   } 
}