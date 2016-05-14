public with sharing class BLN_PayGateway_DAO{

/***********************************************************************************************
*   Controller Name         : BLN_PayGateway_DAO
*   Date                    : 17/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This class is for Retrieving Pay Gateways.
**************************************************************************************************/

    
    public LIST<Pay_Gateway__c> getPayGateWays(){
        LIST<Pay_Gateway__c> PayGateWays = new LIST<Pay_Gateway__c>();
        return PayGateWays = [SELECT PGateway_Type__r.Name,Id,Name,Company__c,PGateway_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,Service_Fee__c,PGateway_Type__r.Display_Type__c, PGateway_Type__r.Help_Text__c, PGateway_Type__r.Image_URL__c,(select id,name,Registration_Type__c from Event_Pay_Gateway__r)  FROM Pay_Gateway__c];
    }
    
    //Fetching Pay Gateways based on ID
    public LIST<Pay_Gateway__c> getPayGateWays(SET<id> ids){
        LIST<Pay_Gateway__c> PayGateWays = new LIST<Pay_Gateway__c>();
        return PayGateWays = [SELECT Id,PGateway_Type__r.Name,Name,Company__c,PGateway_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,Service_Fee__c,PGateway_Type__r.Display_Type__c, PGateway_Type__r.Help_Text__c, PGateway_Type__r.Image_URL__c,(select id,name,Registration_Type__c from Event_Pay_Gateway__r) FROM Pay_Gateway__c where id in :ids];
    }
    
    //Updating Pay Gateway
    public BLN_StatusMessage updatePayGateway(Pay_Gateway__c PGateway){
        dataBase.SaveResult updateRes = dataBase.update(PGateway,false); 
        return new BLN_StatusMessage(updateRes);
    }
    

}