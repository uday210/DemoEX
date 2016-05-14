@RestResource(urlMapping='/BLN_ASC_EditCheckno/*')
/******************************************************
*   Author                  : Phani Kumar Chimata
*   Date                    :  21-05-2015
*   Purpose                 : This is Web Service class for editing Check Number and Update Status.
*   Static Values           : NO Static Values


********************************************************/
global with sharing class BLN_ASC_EditCheckno {
  @HttpPost  
    global static String  doPost(){  
         RestRequest req = RestContext.Request;
         String orderId =req.params.get('orderId');
         String chkno =req.params.get('chkNo');
         String chkStatus =req.params.get('chkStatus');
         String msg ='Fail';
         System.debug('orderId '+orderId +' chkNo '+chkNo +' chkStatus '+chkStatus);  

             if(orderId!=null && orderId!=''){
               for(Payment__c py : [select id,Payment_Ref_Number__c from Payment__c where Order__c=:orderId]){
              	// Updating Check number
                if(chkno!=null && chkno!=''){ 
                   py.Payment_Ref_Number__c =chkno ;
                   Database.SaveResult svres = Database.update(py,false);
                    if(svres.isSuccess()){
                       msg ='Success';
                    }
                 Break; 
                } 
              } 
           
              //Updating Order Status
                if(chkStatus!=null && chkStatus!=''){
                    for(Order__c ord :[SELECT id,Order_Status__c from Order__c where id =:orderId]){
                        ord.Order_Status__c = chkStatus;
                        Database.SaveResult svres1 = Database.update(ord,false);
                          If(svres1.isSuccess()){
                             msg ='Success';
                           }
                           Break; 
                        }
                    } 


           }
         return  msg; 
    }
}