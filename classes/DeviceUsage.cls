@RestResource(urlMapping='/DeviceUsage/*')

/*
 * AUTHOR: Venkatesh 
 * Email : venkatesh@globalnest.com
 * Phone : 9989522656 
 * AIM   : DeviceUsage is for saving device usage information in the server
 */

 global class DeviceUsage{
    
    global static String EventId;
    global static String UserID;  
    global static String IMEI;
    global static String OSversion;   
    @HttpGet
    global static EventDetails1 doGet(){
    //Request Context
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    System.debug('@@@@@req'+req);
    EventId = req.params.get('EventId');
    System.debug('@@@@@EventId'+EventId);
    UserID  = req.params.get('UserID');
    System.debug('@@@@@UserID'+UserID);
    IMEI = req.params.get('IMEI');
    System.debug('@@@@@UserID'+UserID);
    OSversion = req.params.get('OSversion');
    System.debug('@@@@@UserID'+UserID);
    list<DeviceUsage__c> deviceUsageexist = new list<DeviceUsage__c>();
    try{
         User u = [select Email,username from User where id =:UserID];
         System.debug('@@@@@u'+u);
         Event_Attendee_Mapping__c Emap = [select id from  Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c=:u.Email AND  EV_id__r.id =:EventId limit 1];        
         System.debug('@@@@@Emap'+Emap);
         deviceUsageexist =[select id from DeviceUsage__c where EV_id__c=:EventId  AND  User__c=:UserID AND IMEI__c=:IMEI  AND OsVersion__c=:OSversion];
         if(deviceUsageexist.size() > 0 ){
         
          System.debug('This is already existed');         
         }
         
         else{
         DeviceUsage__c deviceUse = new DeviceUsage__c();
         deviceUse.EV_id__c =EventId;
         deviceUse.User__c =UserID;
         deviceUse.IMEI__c =IMEI;
         deviceUse.OsVersion__c =OSversion;   
         insert deviceUse;    
         }      
     EventDetails1 ES2 = new EventDetails1('Suceesfully updated');
     System.debug('@@@@@ES2'+ES2);
     //EventDetails2 .add(ES2);
     return ES2;
       }
   catch(Exception ex) {
   EventDetails1 ES2 = new EventDetails1('You are not registered to this event');
   System.debug('@@@@@ES2'+ES2);
   //EventDetails2 .add(ES2);
   return ES2;
    }
        
     }
            
            
       global  class EventDetails1{
              String Message;
              global EventDetails1(String Message1){
              Message = Message1;
              }
              }
              
}