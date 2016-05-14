/******************************************************
*   Author                  : Vidyasagar Adapa
*   Date                    : 21/08/2015 
*   Purpose                 : This is Web Service class for Update Payment Details.
********************************************************/

@RestResource(urlMapping='/BLN_ASC_PaymentUpdate')
global class BLN_ASC_PaymentUpdate{
  
    @HttpPost  
  global static Payment doPost(){ //Post Mthod
  Payment res_up;
   RestRequest req = RestContext.Request;
  
      String JsonString = req.requestBody.toString(); 
      system.debug('######'+JsonString);   
     paykeys pay_vars=new  paykeys();
    pay_vars = parse(JsonString);
      system.debug('@@@@@@@@@@@@'+pay_vars);
      string sts_f='Fail';
      If(pay_vars.orderId!=Null && pay_vars.eventId !=Null){
      //try{
      Order__c order=new Order__c();
      order.id=pay_vars.orderId;
     
      
              BLN_Payment_DAO paymentDao =new  BLN_Payment_DAO();
                Payment__c payments=new Payment__c();
                payments =paymentDao.paymentdetails(pay_vars.orderId);
                system.debug('%%%%%'+payments);
                
                Payment__c pay_details=new Payment__c();
                BLN_Payments_BAL Pay_detail =new BLN_Payments_BAL();
                 system.debug('%%%%%%%%%%%%%%%%%% '+pay_vars.Payment_Mode);
               String paygateway_id ;  
       if(pay_vars.Payment_Mode != 'Credit Card' && (pay_vars.PaymentType == null || pay_vars.PaymentType == '') ){
                /****************************************************/
                         String Module='ScanAttendee';
                         Event_Pay_Gateway__c  PGateway = new Event_Pay_Gateway__c  ();
                   try{
                       PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(pay_vars.eventId,pay_vars.Payment_Mode,Module);
                    }catch(exception er){}
           
           if(PGateway.Pay_Gateway__c !=null){
                  system.debug('@@ss'+PGateway.Pay_Gateway__c);
            }else{
                    if(pay_vars.Payment_Mode=='Free'){
                                 BLN_Event_DAO evDao = new BLN_Event_DAO(); 
                                 BLN_Event__c  eves = new BLN_Event__c (); 
                                 eves=evDao.getEventDetails(pay_vars.eventId)[0];
                                 Pay_Gateway__c pgGate = new Pay_Gateway__c();
                                  try{
                                    pgGate = [select id,PGateway_Type__c,Company__c from Pay_Gateway__c where Company__r.Name='EventdexLive' and  PGateway_Type__r.name=:pay_vars.Payment_Mode limit 1];
                                  }catch(exception e){}
                                if(null != pgGate ){
                                    Pay_Gateway__c FreepgGate = new Pay_Gateway__c();
                                    FreepgGate = pgGate.clone(false,false,false,false);
                                    FreepgGate.Company__c =eves.organizer_id__c; 
                                    FreepgGate.id=null;
                                    DataBase.SaveResult svRest = Database.insert(FreepgGate,false); 
                                    //System.debug(' FreepgGate   res'+svRest );
                                        if(svRest.Issuccess()){
                                           Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c(); 
                                           epg.Registration_Type__c  =Module ;
                                           epg.Events__c= pay_vars.eventId;
                                           epg.Pay_Gateway__c = svRest.getId();
                                           Database.SaveResult Sv = Database.insert(epg,false);
                                           //System.debug(' Event Pay gateway res'+Sv );
                                                   if(Sv.isSuccess()){
                                                    // System.debug('BHBHBHBBHHBHHBHBHBBHHBHBBHHBHB '+eventId+'  '+PGatewayMode+'  '+Module);
                                                      try{
                                                       PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(pay_vars.eventId,pay_vars.Payment_Mode,Module);
                                                       System.debug(' PaymentGateway id  '+PGateway );
                                                      }catch(exception er){}
                                                   }
                                         }
                                   }
                          }
               }                              
                
                /*****************************************************/
                 //order.Order_Status__c ='Fully Paid';
                // BLN_Order_DAO ordupd =new BLN_Order_DAO();
                // ordupd.updateOrder(order);
              paygateway_id =  PGateway.Pay_Gateway__c ;
           }else{
           
           paygateway_id = pay_vars.paygatewayid;
           
           }                                               
                pay_details =  Pay_detail.upsertpaymentdetails(payments.id,pay_vars.Payment_Mode,pay_vars.RegType,payments.Payment_Amount__c,payments.Pay_Address__c,pay_vars.orderId,payments.Currency_Code__c,pay_vars.cardType,pay_vars.transactionId,pay_vars.cardLastDigits,paygateway_id);
               system.debug('@@@@@$$'+pay_details);
                string sts='Booked';
                

                BLN_SuccessController suscontroller=new BLN_SuccessController();
                if(pay_vars.OrderStatus!=null && pay_vars.OrderStatus!='')
                 suscontroller.orderStatus = pay_vars.OrderStatus;
                suscontroller.sendMail(pay_vars.orderId,pay_vars.eventId);
               order = [SELECT id,Order_Status__c from Order__c where Id=:pay_vars.orderId];
               res_up = new Payment(pay_details,sts,order.Order_Status__c);
              // res_up = new Payment(pay_details,order.Order_Status__c);
           
                system.debug('##text'+pay_vars.PaymentType);
                return res_up;
        // }catch(Exception e){
           //  res_up = new Payment(null,sts_f);
           //  return res_up;
          //   }
               
      }else{
          res_up = new Payment(null,sts_f,'');
          return res_up;
                
           }
}
    public class paykeys{
    public String transactionId;
    public String orderId;  //a1gM0000002yjR4IAI
    public String  isTransactionSuccess;
    public String  errorMessage;
    public String  cardType;
    public String  cardLastDigits;
    public String Payment_Mode;  //Cash
    public String RegType;  //ScanAttendee
    public string eventId;
    public string paygatewayid;
    public string PaymentType;
    public String OrderStatus{get;set;}
   }
   public static paykeys parse(String json){
        return (paykeys) System.JSON.deserialize(json, paykeys.class);
    }

  global class Payment{
       public Payment__c Paymentinfo{get;set;}
       Public string status{get;set;}
       Public string orderStatus{get;set;}
       public Payment(Payment__c paym,string tstaus,String rStatus){
       Paymentinfo = new Payment__c();
       Paymentinfo =  paym;
       status = tstaus;
       orderStatus =rStatus; 
         }
      }


}