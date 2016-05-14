global class BLN_ChangeTicketStatusSc implements Schedulable{
   global List<id> tcids {get;set;}
 
  global BLN_ChangeTicketStatusSc(List<id> tids){
    System.debug('YYYYYYYYYYYYY '+tids);
    tcids = new List<id>();
    tcids = tids;
  }
 
  global void execute(SchedulableContext SC) {
    List<Ticket__c> tickets =new List<Ticket__c>();
    for(Ticket__c tf : [select id,Ticket_Status__c from Ticket__c where id in :tcids ]){
     if(tf.Ticket_Status__c=='Reserved'){
       tf.Ticket_Status__c ='Available';
     }
       tickets.add(tf);
     }
    if(tickets.size()>0){ 
     DataBase.update(tickets,false);
   }
  } 
}