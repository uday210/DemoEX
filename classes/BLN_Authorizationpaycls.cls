public with sharing class BLN_Authorizationpaycls {
    
    public BLN_TrasactionStatus apiCall(BLN_VariablesCls vCls){
       BLN_TrasactionStatus tStatus = new BLN_TrasactionStatus();
        try{ 
          AuthorizeDotNet ath = new AuthorizeDotNet(true,vCls.ANLoginId,vCls.ANTransactionKey);
          ath.transaction(vCls.CreditCardNumber, vCls.selectedMonth+vCls.selectedyear, String.valueOf(vCls.TotalAmount), vCls.CVVNumber,'','');  
          ath.setParameter('x_device_type','1');  
          ath.setParameter('x_first_name',vCls.buyerFirstname);  
          ath.setParameter('x_last_name',vCls.buyerLastname); 
          System.debug('vCls.Company '+vCls.Company);
          System.debug('vCls.State '+vCls.State);
          System.debug('vCls.street1 '+vCls.street1);
          System.debug('vCls.Zip '+vCls.Zip);
           
             if(vCls.Company!=null && vCls.Company!='')  
                ath.setParameter('x_company',vCls.Company);
             if(vCls.phone !=null && vCls.phone!='')  
                ath.setParameter('x_phone',vCls.phone);
             if(vCls.street1!=null){
                ath.setParameter('x_address',vCls.street1);  
             }else{
                ath.setParameter('x_address','');
             }
             if(vCls.City!=null){
                ath.setParameter('x_city',vCls.City);  
             }else{
                ath.setParameter('x_city','');
             }
             if(vCls.State!=null){
             try{
                State__c s=[SELECT ID, NAME, Short_Name__c,Long_Name__c, Country__c, Order__c FROM State__c WHERE id =: vCls.State limit 1];
                ath.setParameter('x_state',s.Short_Name__c);
                }catch(Exception e){}
             }else{
                ath.setParameter('x_state','');  
             }
             if(vCls.Country!=null){
                try{
                Country__c c=[SELECT ID, NAME, Short_Name__c, Long_Name__c, Order__c FROM Country__c WHERE id =: vCls.Country limit 1];
                ath.setParameter('x_country',c.Short_Name__c);
                }catch(Exception e){}
             }else{
                ath.setParameter('x_country','');  
             }
             ath.setParameter('x_response_format','1');  
             if(vCls.Zip!=null){
                ath.setParameter('x_zip',vCls.Zip);
             }else{
                ath.setParameter('x_zip','');
             }
             try{
                ath.process(3);
                }catch(Exception ex){
                 System.debug('ex.getMessage() '+ex.getMessage());
                  tStatus.errorMessage =ex.getMessage();
              }
                        
             if(ath.isApproved()){
                //tStatus.errorMessage= ath.getResponseText();
                tStatus.transactionId = ath.getTransactionID();
                tStatus.cardLastDigits =ath.getlast4();
                tStatus.cardType =ath.getSelectedCardType();
              }
              else if(ath.isDeclined()){
                 tStatus.errorMessage =ath.getResponseText();
               }
               else{
                 tStatus.errorMessage =ath.getResponseText();
                }
           }catch(exception er){
              tStatus.errorMessage =er.getMessage();
           }     
           return tStatus;
     }
}