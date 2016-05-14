@RestResource(urlMapping='/BLN_ASC_AddPayGatewayKey/*')
global class BLN_ASC_AddPayGatewayKey {

  @HttpPost  
  global static Response doPost(){  
        
        RestRequest req = RestContext.Request;
        String EventId =req.params.get('Event_Id'); 
        String Module=req.params.get('Module'); 
        String paygatewaykeyname=req.params.get('Paygatewaykeyname'); 
        String paygatewayid=req.params.get('Paygatewayid'); 
        string payjsonInput = req.requestBody.tostring();
        BLN_ReUse_EventsEditCon.PaymentOpt pinfo=BLN_ReUse_EventsEditCon.new_savesPaymentGateways(payjsonInput,EventId,paygatewaykeyname,paygatewayid,Module);
        Response response=new Response();
        if(pinfo.firstparam=='Success'){
            response.status=pinfo.firstparam;
            response.message=pinfo.secondparam;
            response.pg=new Pay_Gateway__c();
        response.pg=[SELECT Id,BLN_GN_User__r.User__c,Name,Company__c,Paygateway_name__c,PGateway_Type__c,PGateway_Type__r.Name,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c FROM Pay_Gateway__c where id=:pinfo.secondparam order by Company__c];
        return response;
        }
        else
        {
         response.status=pinfo.firstparam;
            response.message=pinfo.secondparam;
        response.pg=new Pay_Gateway__c();
        return response;
        }
  }
  
  
  
  global class Response
  {
    public String status{get;set;}
    public String message{get;set;}
    public Pay_Gateway__c pg{get;set;}
  }
 

}