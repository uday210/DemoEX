global without sharing class BLN_ExportPromocodeDetailsBatch implements Database.batchable<sObject>
{
    global final String QueryString;
    
    private static final Integer SCOPE_SIZE = 100;
    
    public BLN_ExportPromocodeDetailsBatch(String query){
        QueryString = query;
    }
    
    global Iterable<sObject> start(Database.batchableContext batchableContext){ 
        return Database.getQueryLocator(QueryString);
    }
    
    global void execute(Database.BatchableContext batchableContext, List<sObject> scope){
        
        LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner1> promoCodeInnerListbypromdetail = new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner1>();
        BLN_PromoCodeReportCon_BAL balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerListbypromdetail = balToGetPromocodes.promotionsListForEventbypromocode((List<Promotion__c>)scope); 
        
        String temp = 'Ticket Name,Ticket Type,Promotion Name,Promotion Code,Promotion Code Type,Used/Available,Discount Amount,Total Discount Amount\n';
        for(BLN_PromoCodeReportCon_BAL.promoCodeInner1 promocodeInnerdetail:promoCodeInnerListbypromdetail){
        
            for(BLN_PromoCodeReportCon_BAL.itemPromotionInner1 itemPromo :promocodeInnerdetail.itemPromotionList1){
                temp+='"'+itemPromo.itemPromotionData.Order__r.Name +' ",';
                temp+='"'+itemPromo.itemPromotionData.Item__r.item_name__c +'",';
                temp+='"'+ itemPromo.itemPromotionData.Order__r.BLN_TKT_profile__r.First_Name__c+' ' + itemPromo.itemPromotionData.Order__r.BLN_TKT_profile__r.Last_Name__c + '",';
                temp+= itemPromo.itemPromotionData.Item_Discount__c;
            }
            temp+='"';
            temp+='\n';
        }
        
        try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportPromocodeSummary.csv');
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