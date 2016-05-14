global without sharing class BLN_ExportTicketDetailsBatch implements Database.batchable<sObject>
{
    global final String QueryString;
    global final DateTime FromDate;
    global final DateTime ToDate;
    global final String SelectedEventId;
    global final String SearchString;
    
    private static final Integer SCOPE_SIZE = 100;
    
    public BLN_ExportTicketDetailsBatch(String query, Date fDate, Date tDate, String eventId, String searchKey){
        QueryString = query;
        FromDate = fDate;
        ToDate = tDate;
        SelectedEventId = eventId;
        SearchString = searchKey;
    }
    
    global Iterable<sObject> start(Database.batchableContext batchableContext){ 
        return Database.getQueryLocator(QueryString);
    }
    
    global void execute(Database.BatchableContext batchableContext, List<sObject> scope){
        
        LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner12> promoCodeInnerListbyticketdetail = new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner12>();            
        BLN_PromoCodeReportCon_BAL balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerListbyticketdetail = balToGetPromocodes.promotionsListForEventbyticketdetail(SelectedEventId, FromDate, ToDate, SearchString, (List<Item_Promotion__c>)scope); 
        
        String temp='Order No, Promo Code Name, Attendee Name, Ticket Name, Ticket Type, Discount Amount\n';
        for(BLN_PromoCodeReportCon_BAL.promoCodeInner12 ticket:promoCodeInnerListbyticketdetail){
        
            for(BLN_PromoCodeReportCon_BAL.itemPromotionInner1 itemPromo :ticket.itemPromotionList1){
                temp+='"'+itemPromo.itemPromotionData.Order__r.Name +' ",';
                temp+='"'+itemPromo.itemPromotionData.Promotion__r.Name +' ",';
                temp+='"'+ itemPromo.itemPromotionData.Order__r.BLN_TKT_profile__r.First_Name__c +' ' + itemPromo.itemPromotionData.Order__r.BLN_TKT_profile__r.Last_Name__c + '",';
                temp+= itemPromo.itemPromotionData.Item_Discount__c;
            }
            temp+='"';
            temp+='\n';
        }
        
        try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportTicketDetails.csv');
            attachment.setBody(Blob.valueOf(temp));
            attachment.setContentType('text/csv');          
            
            
            String emailMessage = 'Please find attached your exported data as an attachment';                      
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];
            
            if ( owea.size() > 0 ) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
            }
            
            String[] toAddresses = new String[] {UserInfo.getUserName()};
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('support@eventdex.com');
            mail.setSubject('Export Attendees');
            mail.setHtmlBody(emailMessage);          
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }catch(Exception e){}
    }
    
    global void finish(Database.BatchableContext batchableContext){
    
    }
}