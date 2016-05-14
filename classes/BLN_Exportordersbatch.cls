global without sharing class BLN_Exportordersbatch implements Database.batchable<sObject>, Database.Stateful
{
   global final String Query;
  // global string filterKey{get;set;}
   global string timezone{get;set;}
  // global string selectedEvent{get;set;}
  // global date FromDate{get;set;}
   //global date ToDate{get;set;}
     global string currencysymbl{get;set;}
   
   private static final Integer SCOPE_SIZE = 100;
    public BLN_Exportordersbatch(String q,string tzone,string cursymbel){
    Query=q;
    timezone = tzone;
    currencysymbl=cursymbel;
   // selectedEvent=selEvent;
   // FromDate=FrmDate;
    //ToDate=TDate;
    
   }
   global Iterable<sObject> start(Database.batchableContext batchableContext)
   { 
   system.debug('query'+query);
      return Database.getQueryLocator(query);

   }
   global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
   {
   system.debug('currencysymbl====='+currencysymbl);
        String temp1='Order No,Ordered By,Email,Company,Phone,Order Date,Order Status,Amount('+currencysymbl+')\n';
        Integer OrderNumber=1;
        for(sObject orders:scope)
          {
          Order__c order = (Order__c)orders;
           temp1+='"'+OrderNumber+'",';
            if (order.BLN_TKT_profile__r.First_Name__c != null && order.BLN_TKT_profile__r.First_Name__c !='' && order.BLN_TKT_profile__r.Last_Name__c != null && order.BLN_TKT_profile__r.Last_Name__c !='') { 
            
           temp1+='"'+order.BLN_TKT_profile__r.First_Name__c+' '+order.BLN_TKT_profile__r.Last_Name__c+'",';
          
           }
           else if(order.BLN_TKT_profile__r.First_Name__c != null && order.BLN_TKT_profile__r.First_Name__c !=''){
           temp1+='"'+order.BLN_TKT_profile__r.First_Name__c+'",';
           } 
           else if(order.BLN_TKT_profile__r.Last_Name__c != null && order.BLN_TKT_profile__r.Last_Name__c !=''){
           
           temp1+='"'+order.BLN_TKT_profile__r.Last_Name__c+'",';
           }else {
           temp1+='"",';
           } 
          
           if (order.BLN_TKT_profile__r.Email__c!= null && order.BLN_TKT_profile__r.Email__c !='') { 
          temp1+='"'+order.BLN_TKT_profile__r.Email__c+'",';
           } else {
           temp1+='"",';
           } 
           if (order.BLN_TKT_profile__r.TKT_Company__c!= null && order.BLN_TKT_profile__r.TKT_Company__c !='') { 
          temp1+='"'+order.BLN_TKT_profile__r.TKT_Company__c+'",';
           } else {
           temp1+='"",';
           } 
           
           if (order.BLN_TKT_profile__r.Mobile__c!= null && order.BLN_TKT_profile__r.Mobile__c !='') { 
          temp1+='"'+order.BLN_TKT_profile__r.Email__c+'",';
           } else {
           temp1+='"",';
           } 
           if (order.createdDate!= null ) { 
            BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                        tz.tZone=timezone;
                        tz.format='MM/dd/yyyy hh:mm a';
                        tz.dateTimeValue=order.createdDate;
                        string hosttzonetime=tz.getTimeZoneValue();
          temp1+='"'+hosttzonetime+'",';
           } else {
           temp1+='"",';
           }  
           if (order.Order_Status__c!= null && order.Order_Status__c !='') { 
          temp1+='"'+order.Order_Status__c+'",';
           } else {
           temp1+='"",';
           } 
           if (order.Amount_Paid__c!= null) { 
          temp1+='"'+order.Amount_Paid__c+'",';
           } else {
           temp1+='"",';
           } 
          temp1+='\n';
          OrderNumber++;
      }
      
      try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportOrder.csv');
            attachment.setBody(Blob.valueOf(temp1));
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
                 mail.setSubject('Orders');
                 //mail.setPlainTextBody(emailMessage);
                 mail.setHtmlBody(emailMessage);
                
                 
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                 }catch(Exception e){} 
   }
      
      
       global void finish(Database.BatchableContext batchableContext){}
 
}