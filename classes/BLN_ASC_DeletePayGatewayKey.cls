@RestResource(urlMapping='/BLN_ASC_DeletePayGatewayKey/*')
global class BLN_ASC_DeletePayGatewayKey {


  @HttpPost  
  global static String doPost(){  
        
        RestRequest req = RestContext.Request;
        String paygatewayid=req.params.get('Paygatewayid'); 
        try{
        BLN_ReUse_EventsEditCon.deletePaymentGateways(paygatewayid);
        return 'Success';
        }
        catch(Exception e)
        {
        	return 'Error';
        }
      
  }

}