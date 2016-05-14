global without sharing class BLN_ExportTicketSalesBatch implements Database.batchable<sObject>, Database.Stateful{
     global final String Query;
     global string currencySymbol{get;set;}
     public BLN_ExportTicketSalesBatch(String q,string currencySymbol1){
        Query=q;
        currencySymbol=currencySymbol1;
     }
     global Iterable<sObject> start(Database.batchableContext batchableContext)
     { 
         return Database.getQueryLocator(query);
     }
     
     global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
     {
        String temp1='Ticket Name,Tag,Payment Type,Quantity,Price('+currencySymbol+'),Tax('+currencySymbol+'),Fee('+currencySymbol+'),Discount('+currencySymbol+'),Amount('+currencySymbol+')\n';
        
        BLN_TicketSalesReportCon_BAL balToGetTickets= new BLN_TicketSalesReportCon_BAL();
        LIST<BLN_TicketSalesReportCon_BAL.Item> TicketsInnerList= new LIST<BLN_TicketSalesReportCon_BAL.Item>();
        TicketsInnerList= balToGetTickets.getTicketSalesReport(scope);
        
        for(BLN_TicketSalesReportCon_BAL.Item ticket:TicketsInnerList){
            if(ticket.ItemName!='' && ticket.ItemName!= null){
                 temp1+='"'+ticket.ItemName+'",';
            }else{
                temp1+='"Total Sales",';
            }
            temp1+='"'+ticket.ItemType+'",';
            temp1+='"",';
            temp1+='"'+ticket.SoldQuantity+'",';
            decimal price=ticket.Price;
            price=price.setScale(2);
            temp1+='"'+price+'",';
            temp1+='"'+ticket.Tax+'",';
            temp1+='"'+ticket.Fee+'",';
            decimal Discount=ticket.Discount;
            Discount=Discount.setScale(2);
            temp1+='"'+Discount+'",';
            decimal Amount=ticket.Amount;
            Amount=Amount.setScale(2);
            temp1+='"'+Amount+'",\n';
            
            
            for(BLN_TicketSalesReportCon_BAL.PaymentClass payment:ticket.Payment){
                temp1+='"",';
                temp1+='"",';
                temp1+='"'+payment.PaymentType+'",';
                temp1+='"'+payment.Quantity+'",';
                temp1+='"",';
                temp1+='"'+payment.Tax+'",';
                temp1+='"'+payment.Fee+'",';
                temp1+='"'+payment.Discount+'",';
                decimal Amount1=payment.Amount;
                Amount1=Amount1.setScale(2);
                temp1+='"'+Amount1+'",\n';
                
            }
            
            
        }
        
        
        
        try{
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportTicketSales.csv');
            attachment.setBody(Blob.valueOf(temp1));
            attachment.setContentType('text/csv');          
              
            String emailMessage = 'Please find attached your exported data as an attachment';                      
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];
            
            if ( owea.size() > 0 ) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
            }
            
            String[] toAddresses = new String[] {userinfo.getusername()};
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('support@eventdex.com');
            mail.setSubject('Ticket Sales');
            mail.setHtmlBody(emailMessage);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }catch(Exception e){} 
    }
      
    global void finish(Database.BatchableContext batchableContext){}
 
}