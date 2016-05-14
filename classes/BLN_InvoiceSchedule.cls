global class BLN_InvoiceSchedule implements Schedulable {

    public Id eventId{get;set;}

    public BLN_InvoiceSchedule (Id eventId) {
        this.eventId = eventId;
    }

    global void execute(SchedulableContext sc)
    {
    BLN_Event__c eve=[select id,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,name,Event_Status__c from BLN_Event__c where id=:eventId];
    if(eve.Event_Status__c=='Completed')
    {
    BLN_Invoice_Utility bln=new BLN_Invoice_Utility();
    String orderId=bln.createOrder(eventId);
     }
   
    }
    

  
}