global without sharing class BLN_ExportScansforAttendeesBatch implements Database.batchable<sObject>, Database.Stateful
{
    global final String Query;
    global string timezone{get;set;}
    
    public BLN_ExportScansforAttendeesBatch(String q,string tzone){
        Query=q;
        timezone = tzone;
    }
    
    global Iterable<sObject> start(Database.batchableContext batchableContext)
    { 
      return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
    {
        String temp1='Name,Title,Attendee Company,Phone,Email,Exhibitor Company,Scanned By,Scan Time\n';

        for(sObject leads:scope)
        {
          Lead_Scan__c lead = (Lead_Scan__c)leads;
          temp1+='"'+lead.First_Name__c+' '+lead.Last_Name__c+'",';
          if(lead.Title__c != null)
          temp1+='"'+lead.Title__c+'",';
          else
          temp1+='"",';
          
          if(lead.Company__c != null)
          temp1+='"'+lead.Company__c+'",';
          else
          temp1+='"",';
          
          if(lead.Cell_Phone__c != null)
          temp1+='"'+lead.Cell_Phone__c+'",';
          else
          temp1+='"",';
          
          temp1+='"'+lead.Lead_Email__c+'",';
          
          if(lead.Scanner_Company__r.Name != null)
          temp1+='"'+lead.Scanner_Company__r.Name+'",';
          else
          temp1+='"",';
          
          temp1+='"'+lead.Scanner_User__r.First_Name__c+' '+lead.Scanner_User__r.Last_Name__c+'",';
          BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
          tz.tZone=timezone;
          tz.format='MM/dd/yyyy hh:mm a';
          tz.dateTimeValue=lead.Scan_Time__c;
          string hosttzonetime=tz.getTimeZoneValue();
          temp1+='"'+hosttzonetime+'"\n';
        }
        try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportAllAttendeeScans.csv');
            attachment.setBody(Blob.valueOf(temp1));
            attachment.setContentType('text/csv');          
  
            String emailMessage = 'Please find attached your exported data as an attachment';                      
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

            if(owea.size() > 0) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
            }
            
             String[] toAddresses = new String[] {UserInfo.getUserName()};
             mail.setToAddresses(toAddresses);
             mail.setReplyTo('support@eventdex.com');
             mail.setSubject('Export All Attendee Scans');
             mail.setHtmlBody(emailMessage);
             Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
         }catch(Exception e){} 
   }
   
   global void finish(Database.BatchableContext batchableContext){}    
}