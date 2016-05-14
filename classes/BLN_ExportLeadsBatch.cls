global without sharing class BLN_ExportLeadsBatch implements Database.batchable<sObject>, Database.Stateful
{
    global final String Query;
    global string selectedeventid;
    public BLN_ExportLeadsBatch(String q,string selectedeventid1){
        Query=q;
        selectedeventid=selectedeventid1;
    }
    
    global Iterable<sObject> start(Database.batchableContext batchableContext)
    { 
      return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
    {
        String temp='Prefix,Name,Suffix,Company,Title,Email,Cell Phone,Rating,Scanned By,Scanned Time,Notes,Followup Date,Work Address1,Work Address2,Work City,Work State,Work Country,Work Zip,Work phone,Home Phone,Question,Answer\n';
        
        BLN_LeadRetrieval_BAL lrBAL = new BLN_LeadRetrieval_BAL();
        lrBAL.maintableVals(selectedeventid,scope);
        list<BLN_LeadRetrieval_BAL.leaddetails> leaddetailscls= new list<BLN_LeadRetrieval_BAL.leaddetails>();
        leaddetailscls=lrBAL.leaddetailscls;
        
        for(BLN_LeadRetrieval_BAL.leaddetails ll:leaddetailscls){
            if(ll.ls.Prefix__c !=null){
            temp+='"'+ll.ls.Prefix__c+' ",';
            }else{
            temp+='"",';
            }
            temp+='"'+ll.ls.First_Name__c+' '+ll.ls.Last_Name__c+' ",';
            if(ll.ls.Suffix__c !=null){
            temp+='"'+ll.ls.Suffix__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Company__c !=null){
            temp+='"'+ll.ls.Company__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Title__c !=null){
            temp+='"'+ll.ls.Title__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Lead_Email__c !=null){
            temp+='"'+ll.ls.Lead_Email__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Cell_Phone__c !=null){
            temp+='"'+ll.ls.Cell_Phone__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Rating__c !=null){
            temp+='"'+ll.ls.Rating__c+' ",';
            }else{
            temp+='"",';
            }
            
            temp+='"'+ll.ls.Scanner_User__r.First_Name__c+' '+ll.ls.Scanner_User__r.Last_Name__c+' ",';
            temp+='"'+ll.scantime+' ",';
            
            if(ll.ls.notes__c !=null){
            temp+='"'+ll.ls.notes__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.fdate !=null){
            temp+='"'+ll.fdate+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Street1__c !=null){
            temp+='"'+ll.ls.Street1__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Street2__c !=null){
            temp+='"'+ll.ls.Street2__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.City__c !=null){
            temp+='"'+ll.ls.City__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.BLN_State__r.Long_Name__c !=null){
            temp+='"'+ll.ls.BLN_State__r.Long_Name__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.BLN_Country__r.Long_Name__c !=null){
            temp+='"'+ll.ls.BLN_Country__r.Long_Name__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.zip__c !=null){
            temp+='"'+ll.ls.zip__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Work_Phone__c !=null){
            temp+='"'+ll.ls.Work_Phone__c+' ",';
            }else{
            temp+='"",';
            }
            if(ll.ls.Home_Phone__c !=null){
            temp+='"'+ll.ls.Home_Phone__c+' ",';
            }else{
            temp+='"",';
            }
            
            for(integer i=0;i<ll.qc.size();i++){
            temp+='"'+i+'. '+ll.qc[i].que+' ",';
            temp+='"'+i+'. '+ll.qc[i].ans+' ",';
            }
            temp+='\n';
        }
        
        try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportAllAttendeeScans.csv');
            attachment.setBody(Blob.valueOf(temp));
            attachment.setContentType('text/csv');          
  
            String emailMessage = 'Please find attached your exported data as an attachment';                      
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

            if(owea.size() > 0) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
            }
            
             String[] toAddresses = new String[] {UserInfo.getUserName()};//UserInfo.getUserName()
             mail.setToAddresses(toAddresses);
             mail.setReplyTo('support@eventdex.com');
             mail.setSubject('My Leads Export');
             mail.setHtmlBody(emailMessage);
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
         }catch(Exception e){} 
    }
    
    global void finish(Database.BatchableContext batchableContext){} 
}