global without sharing class SendMailBatch implements Database.batchable<String>, Database.Stateful
{
   LIST<String> records;
   
   public SendMailBatch(LIST<String> records){
    this.records=records;
      
    }
   global Iterable<String> start(Database.batchableContext batchableContext)
   { 
       return new ListIterator(records);
   }
   global void execute(Database.BatchableContext batchableContext, List<String> scope)  
   {
       //TODO: Create a map with the column name and the position.
       
       string eventQuery ='select EV_id__c,EV_id__r.OrganizerId__c,EV_id__r.EV_EventLogo__c,UniqNo__c,CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,GuestType__c,BadgeQty__c,TicketTypes__c,TicketTypesBP__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_HomeCity__c,AS_id__r.AS_ShippingCity__c,AS_id__r.AS_WorkState__c,AS_id__r.AS_Work_States__c,AS_id__r.As_Home_State__c,AS_id__r.AS_shippingState__c, AS_id__r.Registration_type__c,AS_id__r.FetchStatus__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id=:scope';
         
   List<Event_Attendee_Mapping__c> eamaplist=new List<Event_Attendee_Mapping__c>(); 
   eamaplist=dataBase.Query(eventQuery ); 
         User u=[select id,username,name,email from user where username='noreply@boothleads.com' limit 1];
         EmailTemplate templateId = [Select id,name from EmailTemplate where name = 'Sweden Template'];
         for(Event_Attendee_Mapping__c eamap:eamaplist)
         {
          try{
          sendmultiplebadges(eamap.id,u.id,templateId.id,eamap.AS_id__r.AS_Email__c,eamap.EV_id__r.OrganizerId__c);
          }Catch(Exception e){System.debug(e);}
        }
   }
   global void finish(Database.BatchableContext batchableContext){}
  
  public void sendmultiplebadges(String eamid,String uid,String templateId,String email,String organizerid)
{
            
   Messaging.SingleEmailMessage mail = 
            new Messaging.SingleEmailMessage();        
     
// Who you are sending the email to
   mail.setTargetObjectId(uid);

   // The email template ID used for the email
   
   mail.setTemplateId(templateId);
          
   mail.setWhatId(eamid);    
   mail.setBccSender(false);
   mail.setUseSignature(false);
   
   OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = :organizerid];
if ( owea.size() > 0 ) {
    mail.setOrgWideEmailAddressId(owea.get(0).Id);
}
else
{
 mail.setReplyTo('orders@boothleads.com');
 mail.setSenderDisplayName('Boothleads');
}
   mail.setSaveAsActivity(false); 
   mail.setToAddresses( new List<String>{ email} );
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  try{
   Event_Attendee_Mapping__c eamap=new Event_Attendee_Mapping__c(id=eamid,EA_isBadgeSent__c=true);
         update eamap; 
         }catch(Exception e){}   
}
 
}