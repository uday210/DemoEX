global class BLN_ClrDataAfEvBatch implements Database.Batchable<sObject> {
    /* *******************************************************************************************
     Written By : Phani
     Date       : 02/18/2016(MM/DD/YYYY)
    ********************************************************************************************* */
    String query,deleteObjectName,senderEmail;
    
    global BLN_ClrDataAfEvBatch(String qry,String objName) {
        this.query = qry;
        this.deleteObjectName =objName;
    }
    global BLN_ClrDataAfEvBatch(String qry,String objName,String email) {
        this.query = qry;
        this.deleteObjectName =objName;
        this.senderEmail = email;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        Database.delete(scope, false);
    }

    global void finish(Database.BatchableContext BC) {
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        if(senderEmail==null || senderEmail=='')
          senderEmail = 'sfadmin@globalnest.com';
        String[] toAddresses = new String[] {senderEmail};
        mail.setToAddresses(toAddresses);
        mail.setSubject(deleteObjectName+' Deletion Batch Result ' + a.Status);
        mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with ' + a.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

}