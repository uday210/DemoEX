global without sharing class BLN_ExportAttendeesBatch implements Database.batchable<sObject>
{
   global final String Query;
    global final List<Reg_Setting__c> RegListBatch;
    global final Map<Id,String> tagsmapBatch;
    global final Map<Id,String> tickettagsmapBatch;
    global final Set<Id> checkrcds;
    global Map<String,String> ColmnvsLabel;
   
   private static final Integer SCOPE_SIZE = 100;
    public BLN_ExportAttendeesBatch (String q,List<Reg_Setting__c> RegList1,Map<Id,String> tagsmap1, Map<Id,String> tickettagsmap1){
    system.debug('DBDBDBD::'+q);
    Query=q;
    RegListBatch=RegList1;
    tagsmapBatch=tagsmap1;
    tickettagsmapBatch=tickettagsmap1;
    ColmnvsLabel = new Map<String,String>();
    
    for( Reg_Setting__c rgset : RegListBatch ){
        
        ColmnvsLabel.put(rgset.Column_Name__c, rgset.Label_Name__c);
    }
    ColmnvsLabel.put('admissions', 'Attendee');
    
    
   }
   
    public BLN_ExportAttendeesBatch(String q,List<Reg_Setting__c> RegList1,Map<Id,String> tagsmap1, Map<Id,String> tickettagsmap1,set<id> idset){
        
    checkrcds = idset;
   
    q = q+' and id in : checkrcds';
    system.debug('DBDBDBD::'+q);
    Query=q;
    RegListBatch=RegList1;
    tagsmapBatch=tagsmap1;
    tickettagsmapBatch=tickettagsmap1;
    
        ColmnvsLabel = new Map<String,String>();
    
    for( Reg_Setting__c rgset : RegListBatch ){
        
        ColmnvsLabel.put(rgset.Column_Name__c, rgset.Label_Name__c);
    }
    ColmnvsLabel.put('admissions', 'Attendee');

   }
   
   
   global Iterable<sObject> start(Database.batchableContext batchableContext)
   { 
       return Database.getQueryLocator(query);
      

   }
   global void execute(Database.BatchableContext batchableContext, List<sObject> scope)  
   {
      system.debug('DBDBDBD::'+scope);
      String temp='Attendee Name,Email,Phone,Company,Designation,Ticket Type,Ticket Name,Badge Label,Seat No.,Badge Status,Checkin Status,Buyer Name,Tag,Order Date,Order Id,Ticket Id,Custom Barcode\n';
 
for(sObject tickets:scope)
      {
      Ticket__c tkt = (Ticket__c)tickets;
      String shwpackg='';
       System.debug('EEEEMMMMLLL::'+tkt.tkt_profile__r.email__c);
       temp+='"'+tkt.tkt_profile__r.first_name__c+' '+tkt.tkt_profile__r.last_name__c +'",';
        temp+='"'+tkt.tkt_profile__r.email__c+'",';
        temp+='"'+tkt.tkt_profile__r.Mobile__c+'",';
        temp+='"'+tkt.tkt_profile__r.TKT_Company__c+'",';
        temp+='"'+tkt.tkt_profile__r.TKT_Job_Title__c+'",';

        String ticketType='';
        if(tkt.Item_Pool__r.Item_Type__r.Name=='Admissions'){
                
            ticketType=ColmnvsLabel.get(tkt.Item_Pool__r.Item_Type__r.Name.toLowercase());
            }
        
        if(tkt.Item_Pool__r.Item_Type__r.Name=='Exhibitor'){

            ticketType=ColmnvsLabel.get(tkt.Item_Pool__r.Item_Type__r.Name);
            }
        
        if(tkt.Item_Pool__r.Item_Type__r.Name=='Sponsor'){

            ticketType=ColmnvsLabel.get(tkt.Item_Pool__r.Item_Type__r.Name);
        }
        
        if(tkt.Item_Pool__r.Item_Type__r.Name=='Speaker'){

            ticketType=ColmnvsLabel.get(tkt.Item_Pool__r.Item_Type__r.Name);
        }
        temp+='"'+ticketType+'",'; 
        
        temp+='"'+tkt.Item_Pool__r.Item_Pool_Name__c+'",';
        temp+='"'+tkt.Badge_Label__c+'",';
        temp+='"'+tkt.Tag_No__c+'",';
        temp+='"'+tkt.Badge_ID__r.Print_status__c+'",';
        
        if(tkt.Tstatus_Id__r.Tstatus_name__c==true){
            temp+='"'+'Checked In'+'",';
        }else if(tkt.Tstatus_Id__r.Tstatus_name__c==false){
            temp+='"'+'Checked Out'+'",';
        }
        temp+='"'+tkt.Order__r.BLN_TKT_profile__r.First_Name__c+' '+tkt.Order__r.BLN_TKT_profile__r.Last_Name__c+'",';
        //temp+='"'+' '+'",';
        
        String tagNameBatch='';
        

        
        if(tagsmapBatch.ContainsKey(tkt.item_pool__c)){
            
            tagNameBatch+=tagsmapBatch.get(tkt.item_pool__c);
            }
        
        tagNameBatch+=' ';
        
        
        if(tickettagsmapBatch.containsKey(tkt.id)){
            
            tagNameBatch+=tickettagsmapBatch.get(tkt.id);
            
            }
        
        temp+='"'+tagNameBatch+'",';
        if(tkt.Order__r.createdDate !=NULL && tkt.Event__r.Time_Zone__c !=NULL){
        temp+='"'+tkt.Order__r.createdDate.format('MMMM d,  yyyy h:mm a', tkt.Event__r.Time_Zone__c)+'",';
        }else{
        temp+='"'+' '+'",';
        }
        temp+='"'+tkt.Order__r.Name+'",';
        temp+='"'+tkt.name+'",'; 
        temp+='"'+tkt.Custom_Barcode__c+'",';  
        temp+='\n';
        
      }
      
      try{
     Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
attachment.setFileName('ExportAttendees.csv');
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