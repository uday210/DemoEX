public with sharing class BLN_Session_DAO {
    public List<BLN_Session__c> getUsrActSessions(String uId,String appName,String dId){
       return [SELECT DeviceType__c,PusunotificationId__c,id,Application__c,Device_Id__c,Status__c,Token__c,User__c,LastmodifiedDate FROM BLN_Session__c WHERE Status__c='Active' AND User__c=:uId AND Application__c=:appName AND Device_Id__c=:dId ORDER BY lastmodifiedDate DESC ];
    }
    public List<BLN_Session__c> getUsrActSessions(String uId,String appName,String dId,String eId){
       return [SELECT DeviceType__c,PusunotificationId__c,id,Application__c,Device_Id__c,Status__c,Token__c,User__c,LastmodifiedDate FROM BLN_Session__c WHERE Status__c='Active' AND User__c=:uId AND Application__c=:appName AND Device_Id__c=:dId AND BLN_Events__c=:eId ORDER BY lastmodifiedDate DESC];
    }
   public List<BLN_Session__c> getUsrAct(String uId,String appName,String eId){
       return [SELECT DeviceType__c,PusunotificationId__c,id,Application__c,Device_Id__c,Status__c,Token__c,User__c,LastmodifiedDate FROM BLN_Session__c WHERE Status__c='Active' AND User__c=:uId AND Application__c=:appName AND BLN_Events__c=:eId ORDER BY lastmodifiedDate DESC];
    }

    public BLN_Session__c getSession(String sid){
    	try{
         return [SELECT DeviceType__c,PusunotificationId__c,id,Application__c,Device_Id__c,Status__c,Token__c,User__c,LastmodifiedDate FROM BLN_Session__c WHERE id=:sid];
    	}catch(exception ty){
    		return null;
    	}
    }
}