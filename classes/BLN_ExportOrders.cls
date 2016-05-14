global without sharing class BLN_ExportOrders implements Database.batchable<sObject>
{
   global final String Query;

   
   private static final Integer SCOPE_SIZE = 100;
    public BLN_ExportOrders (String q){
    Query=q;
   }
   global Iterable<sObject> start(Database.batchableContext batchableContext)
   { 
      return Database.getQueryLocator(query);

   }
   global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
   {
      String temp='S.No,Order Id,Amount Paid,Ordered By,Email,Ordered Date,Promo Code,Payment Type,Payment Status,Transaction Key,Attendee Name,Email Id,Company,Ticket,Status,Price\n';
Integer OrderNumber=1;
for(sObject orders:scope)
      {
      Order__c order = (Order__c)orders;
      String shwpackg='';
      for(Ticket__c attendee:order.Tickets__r){
      if(attendee.item_type__r.name=='Package'&&attendee.Parent_ID__c==null)
      {
      }
      else
      {
       temp+='"'+OrderNumber+'",';
        temp+='"'+order.Name+'",';
        temp+='"'+order.Amount_Paid__c+'",';
        temp+='"'+order.BLN_TKT_profile__r.First_Name__c+' '+order.BLN_TKT_profile__r.Last_Name__c+'",';
        temp+='"'+order.BLN_TKT_profile__r.Email__c+'",';
        temp+='"'+order.CreatedDate+'",';
        
        temp+='"';
        String promo='';
        for(Order_Item__c OrderTic:order.Order_Items__r)
        {
          promo=OrderTic.Promotion__r.Promo_Code__c==null?'':OrderTic.Promotion__r.Promo_Code__c;
        }
        temp+=promo+'",';
        
        
        temp+='"';
        String pmode='';
        for(Payment__c payment:order.Payments__r)
        {
          pmode+=payment.Payment_Mode__c + ' ';
        }
        temp+=pmode+'",';
        
        temp+='"'+order.Order_Status__c+'",';
        temp+='"';
        String prefno='';
        for(Payment__c payment:order.Payments__r)
        {
          if(payment.Payment_Mode__c == 'Credit Card')
          prefno=payment.Payment_Mode__c + ' ';
        }
        temp+=prefno+'",';
        temp+='"'+attendee.Tkt_profile__r.First_Name__c+' '+attendee.Tkt_profile__r.Last_Name__c+'",';
        temp+='"'+attendee.Tkt_profile__r.Email__c+'",';
        if(attendee.tkt_profile__r.TKT_Company__c !=null && attendee.tkt_profile__r.TKT_Company__c!=''){
        temp+='"'+attendee.tkt_profile__r.TKT_Company__c+'",';
        }else{
        temp+='"",';
        }
        temp+='"'+attendee.Item_Pool__r.Item_Pool_Name__c;
        if(attendee.Item_Pool__r.Item_Pool_Name__c!=attendee.Item__r.item_name__c)
        temp+='('+attendee.Item__r.item_name__c+')';
        temp+='",';
        temp+='"'+attendee.Ticket_Status__c+'",';
        Decimal orderAmountat=0;
        temp+='"';
        if(attendee.Parent_ID__c==Null )
        {
          
         if(attendee.Order_Item__r.Item_Fee__c != NULL&&attendee.Order_Item__r.Item_Discount__c == NULL&&attendee.Ticket_Status__c=='Booked') 
         orderAmountat=attendee.Order_Item__r.Each_Ticket_Price__c+(attendee.Order_Item__r.Tax__c/attendee.Order_Item__r.Item_Quantity__c)+(attendee.Order_Item__r.Item_Fee__c/ attendee.Order_Item__r.Item_Quantity__c);
         
        if(attendee.Order_Item__r.Item_Fee__c == NULL&&attendee.Order_Item__r.Item_Discount__c != NULL&&attendee.Ticket_Status__c=='Booked')  
        orderAmountat=attendee.Order_Item__r.Each_Ticket_Price__c+(attendee.Order_Item__r.Tax__c/attendee.Order_Item__r.Item_Quantity__c)-(attendee.Order_Item__r.Item_Discount__c/ attendee.Order_Item__r.Item_Quantity__c);
        
        if(attendee.Order_Item__r.Item_Fee__c != NULL&&attendee.Order_Item__r.Item_Discount__c != NULL&&attendee.Ticket_Status__c=='Booked')     
        orderAmountat=attendee.Order_Item__r.Each_Ticket_Price__c+(attendee.Order_Item__r.Tax__c/attendee.Order_Item__r.Item_Quantity__c)+(attendee.Order_Item__r.Item_Fee__c/ attendee.Order_Item__r.Item_Quantity__c)-(attendee.Order_Item__r.Item_Discount__c/ attendee.Order_Item__r.Item_Quantity__c);
        temp+=orderAmountat;
        }
        
        if(attendee.Parent_ID__c!=Null)
        {
          if(!shwpackg.contains(String.valueOf(attendee.item_pool__r.addon_parent__r.id)+String.valueOf(attendee.Parent_ID__c)))
          {
          shwpackg=shwpackg+String.valueOf(attendee.item_pool__r.addon_parent__r.id)+String.valueOf(attendee.Parent_ID__c);
         if(attendee.Order_Item__r.Item_Fee__c != NULL&&attendee.Order_Item__r.Item_Discount__c == NULL&&attendee.Ticket_Status__c=='Booked') 
         orderAmountat=attendee.Order_Item__r.Each_Ticket_Price__c+(attendee.Order_Item__r.Tax__c/attendee.Order_Item__r.Item_Quantity__c)+(attendee.Order_Item__r.Item_Fee__c/ attendee.Order_Item__r.Item_Quantity__c);
         
        if(attendee.Order_Item__r.Item_Fee__c == NULL&&attendee.Order_Item__r.Item_Discount__c != NULL&&attendee.Ticket_Status__c=='Booked')  
        orderAmountat=attendee.Order_Item__r.Each_Ticket_Price__c+(attendee.Order_Item__r.Tax__c/attendee.Order_Item__r.Item_Quantity__c)-(attendee.Order_Item__r.Item_Discount__c/ attendee.Order_Item__r.Item_Quantity__c);
        
        if(attendee.Order_Item__r.Item_Fee__c != NULL&&attendee.Order_Item__r.Item_Discount__c != NULL&&attendee.Ticket_Status__c=='Booked')     
        orderAmountat=attendee.Order_Item__r.Each_Ticket_Price__c+(attendee.Order_Item__r.Tax__c/attendee.Order_Item__r.Item_Quantity__c)+(attendee.Order_Item__r.Item_Fee__c/ attendee.Order_Item__r.Item_Quantity__c)-(attendee.Order_Item__r.Item_Discount__c/ attendee.Order_Item__r.Item_Quantity__c);
        temp+=orderAmountat;
        }
        }
        temp+='"';
        
        
        temp+='\n';
        OrderNumber++;
        }
      }
      }
      
      try{
     Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
attachment.setFileName('ExportOrder.csv');
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
                 mail.setSubject('Export Attendees');
                 //mail.setPlainTextBody(emailMessage);
                 mail.setHtmlBody(emailMessage);
                
                 
                 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                 }catch(Exception e){}
   }
      
      
       global void finish(Database.BatchableContext batchableContext){
       
       }
 
}