public with sharing class BLN_CheckInHistoryDetails {
       public Ticket__c GuestName{get;set;}
       public LIST<Ticket__c> tcinn {get;set;}
       //public LIST<BLN_CheckinCheckoutDetails> cico{get;set;}
   
        // Constructor Loads the chekin checkout details for each ticket  for the given guest.
       public BLN_CheckInHistoryDetails(Ticket__c GuestName1,LIST<Ticket__c> ticdet1){
          GuestName=GuestName1;
          tcinn = ticdet1;
          /*tcinn  = new Ticket__c();
          tcinn =GuestName1;
          cico=new LIST<BLN_CheckinCheckoutDetails>();
          for(Ticket__c tic:ticdet1){
              cico.add(new BLN_CheckinCheckoutDetails(tic));
          }*/
          }
}