global without sharing class BLN_ExportCheckins implements Database.batchable<sObject>, Database.Stateful
{
   global final String Query;
   global string filterKey{get;set;}
   global string timezone{get;set;}
   global string regtype{get;set;}
   global string selectedEvent{get;set;}
   global string scannedby{get;set;}
   
   private static final Integer SCOPE_SIZE = 100;
    public BLN_ExportCheckins(String q,string filter,string tzone,string regtype1,string selectedEvent1,string scannedby1){
    Query=q;
    filterKey = filter;
    timezone = tzone;
    regtype= regtype1;
    selectedEvent=selectedEvent1;
    scannedby=scannedby1;
   }
   global Iterable<sObject> start(Database.batchableContext batchableContext)
   { 

      return Database.getQueryLocator(query);

   }
   global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
   {
        String temp='Attendee/Ticket Name,Ticket Number,Email,Company,Checkin-out Date/Time,Scanned By,Device Name\n';
        BLN_CheckinHistoryReportService chrService = new BLN_CheckinHistoryReportService();
        //LIST<BLN_CheckInHistoryDetails> ticClas=new LIST<BLN_CheckInHistoryDetails>();
        List<BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails> ticClas=new List<BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails>();
        ticClas = chrService.TicketCheckInHistory(scope,filterKey,regtype,selectedEvent,scannedby);
      
      for(BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails CheckInHistory:ticClas){
          if(filterKey=='Attendee'){
          temp+='"Attendee Name:'+CheckInHistory.GuestName.Tkt_profile__r.First_Name__c+' '+CheckInHistory.GuestName.Tkt_profile__r.Last_Name__c+'",\n';
              for(BLN_CheckinHistoryReportService.grouptics Check:CheckInHistory.tcinn){
                  temp+='"'+Check.tic.Item_Pool__r.Item_Pool_Name__c+'",';
                  temp+='"'+Check.tic.Name+'",';
                  temp+='"'+Check.tic.tkt_profile__r.Email__c+'",';
                  temp+='"'+Check.tic.tkt_profile__r.TKT_Company__c+'",';
                  string temp1 = '';
                  integer i=0;
                  for(Tstatus__c tsat:Check.tic.tstatus__r){
                      BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                        tz.tZone=timezone;
                        tz.format='MM/dd/yyyy hh:mm a';
                        tz.dateTimeValue=tsat.LastModifiedDate;
                        string hosttzonetime=tz.getTimeZoneValue();
                      if(tsat.Tstatus_name__c == true){
                      temp1+='"'+hosttzonetime+' (in)",';
                      }else{
                      temp1+='"'+hosttzonetime+' (out)",';
                      }
                      if(tsat.Owner.Name != null && tsat.Owner.Name != ''){
                      temp1+='"'+tsat.Owner.Name+'",';
                      }else{
                      temp1+='"",';
                      }
                      if(tsat.Device_Name__c != null && tsat.Device_Name__c != ''){
                      temp1+='"'+tsat.Device_Name__c+'"\n';
                      }else{
                      temp1+='""\n';
                      }
                      i++;
                      if(Check.tic.tstatus__r.size() != i){
                      temp1+=',';
                      temp1+=',';
                      }
                  }
                 temp+= temp1;
              }
         }else{
              temp+='"Ticket Name:'+CheckInHistory.GuestName.Item_Pool__r.Item_Pool_Name__c+'",\n';
              for(BLN_CheckinHistoryReportService.grouptics Check:CheckInHistory.tcinn){
                  temp+='"'+Check.tic.Tkt_profile__r.First_Name__c+' '+Check.tic.Tkt_profile__r.Last_Name__c+'",';
                  temp+='"'+Check.tic.Name+'",';
                  temp+='"'+Check.tic.tkt_profile__r.Email__c+'",';
                  temp+='"'+Check.tic.tkt_profile__r.TKT_Company__c+'",';
                  string temp1 = '';
                  integer i=0;
                  for(Tstatus__c tsat:Check.tic.tstatus__r){
                      BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                        tz.tZone=timezone;
                        tz.format='MM/dd/yyyy hh:mm a';
                        tz.dateTimeValue=tsat.LastModifiedDate;
                        string hosttzonetime=tz.getTimeZoneValue();
                      if(tsat.Tstatus_name__c == true){
                      temp1+='"'+hosttzonetime+' (in)",';
                      }else{
                      temp1+='"'+hosttzonetime+' (out)",';
                      }
                      if(tsat.Owner.Name != null && tsat.Owner.Name != ''){
                      temp1+='"'+tsat.Owner.Name+'",';
                      }else{
                      temp1+='"",';
                      }
                      if(tsat.Device_Name__c != null && tsat.Device_Name__c != ''){
                      temp1+='"'+tsat.Device_Name__c+'"\n';
                      }else{
                      temp1+='""\n';
                      }
                      i++;
                      if(Check.tic.tstatus__r.size() != i){
                      temp1+=',';
                      temp1+=',';
                      }
                  }
                 temp+= temp1;
              }
         }
         temp+='\n';
      }
      
      try{
      Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
attachment.setFileName('ExportCheckins.csv');
attachment.setBody(Blob.valueOf(temp));
attachment.setContentType('text/csv');          
         
                
               String emailMessage = 'Please find attached your exported data as an attachment';                      
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
                
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

                    if ( owea.size() > 0 ) {
                        mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        //emailTOea.setOrgWideEmailAddressId(owea.get(0).Id);
                    }
                
                 String[] toAddresses = new String[] {UserInfo.getUserName()};
                 mail.setToAddresses(toAddresses);
                 mail.setReplyTo('support@eventdex.com');
                 mail.setSubject('Checkin History Report');
                 //mail.setPlainTextBody(emailMessage);
                 mail.setHtmlBody(emailMessage);
                
                 
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                 }catch(Exception e){}
   }
      
      
       global void finish(Database.BatchableContext batchableContext){}
 
}