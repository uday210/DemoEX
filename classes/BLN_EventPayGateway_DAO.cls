public with sharing class BLN_EventPayGateway_DAO{

/***********************************************************************************************
*   Controller Name         : BLN_EventPayGateway_DAO
*   Date                    : 17/06/2014 
*   Author                  : Mahesh Sakunala
*   Purpose                 : This class is for Retrieving Pay Gateways of Events.
**************************************************************************************************/

    
    public LIST<Event_Pay_Gateway__c> getEventPayGateWays(String EventId){
        LIST<Event_Pay_Gateway__c> EventPayGateWays = new LIST<Event_Pay_Gateway__c>();
        return EventPayGateWays = [SELECT Accept_Min_Max_Range__c,Min_amount_to_accept__c,Registration_Type__c,Pay_Gateway__r.Use_Host_Page__c,Id,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.Company__c,Pay_Gateway__r.PP_Fee_Payer__c,Pay_Gateway__r.PP_Payment_Type__c,Pay_Gateway__r.PGateway_Type__c,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PG_User_Key__c,Pay_Gateway__r.Service_Fee__c,Pay_Gateway__r.Min_amount_to_accept__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.PGateway_Type__r.Display_Type__c, Pay_Gateway__r.PGateway_Type__r.Help_Text__c, Pay_Gateway__r.PGateway_Type__r.Image_URL__c FROM Event_Pay_Gateway__c WHERE Events__c=: EventId];
    }
    
    public LIST<Event_Pay_Gateway__c> getEventPayGateWaysbasedonmodule(String EventId,String Module){
        LIST<Event_Pay_Gateway__c> EventPayGateWays = new LIST<Event_Pay_Gateway__c>();
        return EventPayGateWays = [SELECT Accept_Min_Max_Range__c,Min_amount_to_accept__c,Registration_Type__c,Pay_Gateway__r.Use_Host_Page__c,Id,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.Company__c,Pay_Gateway__r.PP_Fee_Payer__c,Pay_Gateway__r.PP_Payment_Type__c,Pay_Gateway__r.PGateway_Type__c,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PG_User_Key__c,Pay_Gateway__r.Service_Fee__c,Pay_Gateway__r.Min_amount_to_accept__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.PGateway_Type__r.Display_Type__c, Pay_Gateway__r.PGateway_Type__r.Help_Text__c, Pay_Gateway__r.PGateway_Type__r.Image_URL__c FROM Event_Pay_Gateway__c WHERE Events__c=: EventId and Registration_Type__c=:Module];
    }
    
     public static Event_Pay_Gateway__c getEventPayGateWay(String EventId,String Name,String Module){
         Event_Pay_Gateway__c  EGateway = new Event_Pay_Gateway__c ();
        return EGateway =[SELECT Accept_Min_Max_Range__c,Min_amount_to_accept__c,Registration_Type__c,Pay_Gateway__r.Use_Host_Page__c,Id,Name,Pay_Gateway__r.PGateway_Type__r.name,Events__c,Pay_Gateway__c,Pay_Gateway__r.Id,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.Name FROM Event_Pay_Gateway__c WHERE Events__c=:EventId and Registration_Type__c=:Module and Pay_Gateway__r.PGateway_Type__r.name=:Name limit 1];
    }

}