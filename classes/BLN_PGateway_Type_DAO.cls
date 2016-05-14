public with sharing class BLN_PGateway_Type_DAO{

/***********************************************************************************************
*   Controller Name         : BLN_PGateway_Type_DAO
*   Date                    : 16/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This class is for Retrieving Gateway Type.
*  Mallikarjuna Rao         :  Placed To Save Pay_Gateway__c object to an Event (19/06/2013)
**************************************************************************************************/

    public PGateway_Type__c getGatewayType(String GatewayType){
        PGateway_Type__c PGatewaytype = new PGateway_Type__c();
        return PGatewaytype = [SELECT Id,Name FROM PGateway_Type__c WHERE Name=: GatewayType];
    }
    
    
    //By Mallik
    //Return All PGateWays Records will return 
    //Used in Events page .......................
    public LIST<PGateway_Type__c> pGateWayTypes(){
        
        LIST<PGateway_Type__c> PGatewaytypes = new LIST<PGateway_Type__c>();
        return PGatewaytypes = [SELECT Id,Name,Display_Type__c, Help_Text__c, Image_URL__c,Online_Flag__c,Onsite_Flag__c,ScanAttendee_Flag__c,Adaptive_Type__c FROM PGateway_Type__c];
    }
    
    
    public LIST<dataBase.Upsertresult> pgateWaySaves(LIST<Pay_Gateway__c> payGateWays){
        
        LIST<DataBase.Upsertresult> gateWayRes = dataBase.upsert(payGateWays);
        
        return gateWayRes;
    }
    
    
}