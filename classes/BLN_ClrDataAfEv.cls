global class BLN_ClrDataAfEv implements Schedulable {
    global void execute(SchedulableContext sc) {
        DateTime dateAfterEvent = System.now().addDays(-7) ;
        DateTime dateAfterEventEnd = System.now().addDays(-8).addSeconds(-1);
        //Ticket Deletion Batch
        String queryTc = 'SELECT id from Ticket__c WHERE Event__r.End_Date__c>=:dateAfterEvent AND Event__r.End_Date__c<:dateAfterEventEnd AND Ticket_Status__c=\'Available\'';
        BLN_ClrDataAfEvBatch tcBatch = new  BLN_ClrDataAfEvBatch(queryTc,'Tickets');
        database.executebatch(tcBatch, 200);
        // Sessions Deletion Batch 
        DateTime datesFordelete = System.now().addDays(-3) ;
        String querySs = 'SELECT id FROM BLN_Session__c Where BLN_Events__r.End_Date__c<:datesFordelete';
        BLN_ClrDataAfEvBatch ssBatch = new  BLN_ClrDataAfEvBatch(querySs,'Sessions');
        database.executebatch(ssBatch, 200);
    }
}