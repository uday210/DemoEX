global without sharing class BLN_ExportPromocodeSummaryBatch implements Database.batchable<sObject>
{
    global final String QueryString;
    global final String Eventcurrency;
    
    private static final Integer SCOPE_SIZE = 100;
    
    public BLN_ExportPromocodeSummaryBatch(String query, String eventcurrency){
        this.QueryString = query;
        this.Eventcurrency = eventcurrency;
    }
    
    global Iterable<sObject> start(Database.batchableContext batchableContext){ 
        return Database.getQueryLocator(QueryString);
    }
    
    global void execute(Database.BatchableContext batchableContext, List<sObject> scope){
        
        LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner> promoCodeInnerList = new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner>();            
        BLN_PromoCodeReportCon_BAL balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerList = balToGetPromocodes.promotionsListForEvent((List<Promotion__c>)scope); 
        
        String temp='Ticket Name,Ticket Type,Promotion Name,Promotion Code,Promotion Code Type,Used/Available,Discount Amount,Total Discount Amount\n';
        for(BLN_PromoCodeReportCon_BAL.promoCodeInner promocodeInner:promoCodeInnerList){
        
            for(BLN_PromoCodeReportCon_BAL.itemPromotionInner itemPromo :promocodeInner.itemPromotionList){
                temp+='"'+itemPromo.itemPromotionData.Buy_Item__r.item_name__c +' ' + itemPromo.itemPromotionData.Free_Item__r.item_name__c +' ",';
                temp+='"'+itemPromo.itemPromotionData.Buy_Item__r.item_type__r.Name +' ' + itemPromo.itemPromotionData.Free_Item__r.item_type__r.Name +' ",';
                temp+='"'+ promocodeInner.promotionData.Name +' ",';
                temp+='"'+ promocodeInner.promotionData.Promo_Code__c +' ",';
                temp+='"'+ promocodeInner.promotionData.Promotion_Type__c +' ",';
                temp+='"'+ promocodeInner.inntotalusedcont+' out of '+ promocodeInner.promotionData.T_Max_Count__c + '",';
                if(itemPromo.itemPromotionData.Item_Discount_Type__c == 'Amount'){
                    temp+='"'+ eventcurrency +' ",';
                }
                temp+='"'+ itemPromo.itemPromotionData.Item_Discount_Value__c +' ",';
                if(itemPromo.itemPromotionData.Item_Discount_Type__c == 'Percent'){
                    temp+='%,';
                }
                temp+= itemPromo.totdiscount;
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