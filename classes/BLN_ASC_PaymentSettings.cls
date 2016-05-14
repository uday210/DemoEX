@RestResource(urlMapping='/BLN_ASC_PaymentSettings/*')
global class BLN_ASC_PaymentSettings {

@HttpPost  
  global static List<Event_Pay_Gateway__c> doPost(){  
        
        RestRequest req = RestContext.Request;
        String EventId =req.params.get('Event_Id'); 
        String Check =req.params.get('Check'); 
        String Cash =req.params.get('Cash'); 
        String External =req.params.get('External');
        String cashcheckexternalcardcustomerid=req.params.get('cashcheckexternalcardcustomerid')==null?'':req.params.get('cashcheckexternalcardcustomerid'); 
        String cashcheckexternalcarddetails=req.params.get('cashcheckexternalcarddetails')==null?'':req.params.get('cashcheckexternalcarddetails'); 
        String Module=req.params.get('Module'); 
        String RequestFrom=req.params.get('RequestFrom'); 
        string payjsonInput = req.requestBody.tostring();
        
        String AcceptCheckRange=req.params.get('AcceptCheckRange');
        String AcceptCheckRangeMinValue=req.params.get('AcceptCheckRangeMinValue'); 
        String AcceptGatewayRange=req.params.get('AcceptGatewayRange');
        String AcceptGatewayRangeMinValue=req.params.get('AcceptGatewayRangeMinValue'); 
        
        
        
        BLN_ReUse_EventsEditCon.new_savesPaymentOption(payjsonInput,EventId,Check,Cash,External,cashcheckexternalcardcustomerid,cashcheckexternalcarddetails,'','',Module,RequestFrom,AcceptGatewayRange,AcceptGatewayRangeMinValue,AcceptCheckRange,AcceptCheckRangeMinValue);
        
        
        return [select id,name,Events__c,Registration_Type__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PG_User_Key__c,Events__r.organizer_id__c,Events__r.organizer_id__r.Name,Events__r.organizer_id__r.PG_Authorization_Card_Type__c,Events__r.organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,Events__r.organizer_id__r.PG_Authorization_Key__c,Events__r.organizer_id__r.PG_Credit_Card_Overwrite__c from Event_Pay_Gateway__c where Events__c=:EventId and Registration_Type__c=:Module];
  }


}