public without sharing class BLN_Payment_DAO
{
/**
* @author :Arindam Sarkar
* @date 05/15/2014
* @ This class is used for DML operations on Payment object
*/ 

 // This will return payments of particular order 
  public List<Payment__c> paymentInfo(SET<id> ids)
  {
    return [select id,Currency_Code__c,credit_card_last_4digits__c,Order__c,Payment_Amount__c,Payment_Ref_Number__c,Name,Payment_Mode__c,Registration_Type__c,BLN_Pay_Gateway__r.PGateway_Type__r.Name,credit_card_type__c,lastmodifieddate from Payment__c where Order__c In :ids];
  }
  
  //PAYMENTDetails
  public Payment__c paymentdetails(string ordid){
  
  return [select id,Order__c,Payment_Amount__c,Pay_Address__c,Payment_Mode__c,Payment_Ref_Number__c,Registration_Type__c,BLN_Pay_Gateway__c,credit_card_last_4digits__c,credit_card_type__c,Currency_Code__c from Payment__c where Order__c =:ordid];
  }
   //Insering Order  
   public BLN_StatusMessage insertPayment(Payment__c pay){
       dataBase.saveResult saveRes = dataBase.insert(pay,false); 
       return new BLN_StatusMessage(saveRes);
    }
    
 //Inserting or updating Payment object
     public BLN_StatusMessage upsrtpayment(Payment__c pay){
      system.debug('********************** pay '+pay);
           dataBase.UpsertResult saveRes = dataBase.Upsert(pay,false); 
           system.debug('^^^^^^^^^^^^ SaveRES '+saveRes);
           return new BLN_StatusMessage(saveRes);
        }   
    
    //To Get All the Payments Belongs to An Event written By Manasa Gandham
    
    public List<AggregateResult> paymentsForEvent(String EventId){
        LIST<AggregateResult> paymentAggregateResult= new LIST<AggregateResult>(); 
        paymentAggregateResult= [SELECT SUM(Order__r.Amount_Paid__c) amt, BLN_Pay_Gateway__r.PGateway_Type__r.Name mode
                                 FROM Payment__c 
                                 WHERE Order__r.Events__c =: EventId
                                // AND Order__r.Transaction_Status__c  =: 'Completed'
                                 AND Order__r.Order_Status__c !=: 'Cancelled'
                                 AND Order__r.Order_Status__c !=: 'Abandoned'
                                 AND Order__r.Order_Status__c !=: 'Not Paid'
                                 AND BLN_Pay_Gateway__c != NULL
                                 GROUP BY  BLN_Pay_Gateway__r.PGateway_Type__r.Name];
        return paymentAggregateResult;
    }
  
     public LIST<Payment__c> allpaymentsForEvent(String EventId){
        LIST<Payment__c> payments=[SELECT Order__c,Registration_Type__c from Payment__c 
                                    WHERE Order__r.Order_Status__c !=: 'Cancelled'
                                      AND Order__r.Order_Status__c !=: 'Abandoned'
                                      AND Order__r.Order_Status__c !=: 'Not Paid'
                                      AND Order__r.Events__c =: EventId];
        return payments;
    }
  
}