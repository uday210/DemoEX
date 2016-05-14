global without sharing class BLN_ExportTicketSummaryBatch implements Database.batchable<sObject>
{
    global final String QueryString;
    global final DateTime FromDate;
    global final DateTime ToDate;
    global final String SelectedEventId;
    global final String SearchString;
    global final String Eventcurrency;
    
    private static final Integer SCOPE_SIZE = 100;
    
    public BLN_ExportTicketSummaryBatch(String query, Date fDate, Date tDate, String eventId, String searchKey, String eventcurrency){
        this.QueryString = query;
        this.FromDate = fDate;
        this.ToDate = tDate;
        this.SelectedEventId = eventId;
        this.SearchString = searchKey;
        this.Eventcurrency = eventcurrency;
    }
    
    global Iterable<sObject> start(Database.batchableContext batchableContext){ 
        return Database.getQueryLocator(QueryString);
    }
    
    global void execute(Database.BatchableContext batchableContext, List<sObject> scope){
        
        LIST<BLN_PromoCodeReportCon_BAL.promocodebyticket> promoCodeInnerListbyticket = new LIST<BLN_PromoCodeReportCon_BAL.promocodebyticket>();            
        BLN_PromoCodeReportCon_BAL balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerListbyticket = balToGetPromocodes.promobyticket(SelectedEventId, FromDate, ToDate, SearchString, (List<Promotion__c>)scope); 
        
        String temp='Promotion Name, Promo Code No, Promo Code Type, Ticket Name, Ticket Type, Discount Amount, Used/Available,Total Discount Amount\n';
        for(BLN_PromoCodeReportCon_BAL.promocodebyticket ticket:promoCodeInnerListbyticket){
        
            for(BLN_PromoCodeReportCon_BAL.byticketstotaldiscounamount itemPromo :ticket.prolistforticketinner){
                temp+='"'+itemPromo.prolistforticket.Name +' ",';
                temp+='"'+itemPromo.prolistforticket.Promo_Code__c +' ",';
                temp+='"'+ itemPromo.prolistforticket.Promotion_Type__c +' ",';
                if(itemPromo.prolistforticket.Item_Promotions__r[0].Item_Discount_Type__c == 'Amount'){
                    temp+='"'+ eventcurrency +' ",';
                }
                temp+='"'+ itemPromo.prolistforticket.Item_Promotions__r[0].Item_Discount_Value__c +' ",';
                if(itemPromo.prolistforticket.Item_Promotions__r[0].Item_Discount_Type__c == 'Percent'){
                    temp+='%,';
                }
                temp+='"'+ itemPromo.usedbyticket+'/' + itemPromo.prolistforticket.T_Max_Count__c+ '",';
                temp+= itemPromo.totaldiscountbyticket;
            }
            temp+='"';
            temp+='\n';
        }
        
        try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportTicketSummary.csv');
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