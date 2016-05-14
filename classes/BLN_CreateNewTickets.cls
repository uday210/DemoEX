global class BLN_CreateNewTickets implements Schedulable{
   global String orderId {get;set;}
 
  global BLN_CreateNewTickets(String ordId){
    System.debug('YYYYYYYYYYYYY '+ordId);
    this.orderId = ordId;
  }
 
  global void execute(SchedulableContext SC) {
     BLN_CalloutCls blncallout = new BLN_CalloutCls(orderId);
  } 
}