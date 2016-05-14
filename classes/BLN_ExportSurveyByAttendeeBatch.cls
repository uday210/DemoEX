global without sharing class BLN_ExportSurveyByAttendeeBatch implements Database.batchable <sObject> , Database.Stateful {
    global final String Query;
    global List <Ticket__c> ticCountList{get;set;}
    global string selectedEvent{get;set;}

    private static final Integer SCOPE_SIZE = 100;
    public BLN_ExportSurveyByAttendeeBatch(String q, string selEvent) {
        Query=q;
        //ticCountList= new list<ticket__c>();
        //ticCountList=ticCountList1;
        selectedEvent=selEvent;

    }
    global Iterable < sObject > start(Database.batchableContext batchableContext) {
        system.debug('query' + query);
        return Database.getQueryLocator(query);

    }
    global void execute(Database.BatchableContext batchableContext, List < sObject > scope) {

        String temp1 = 'Attendee Name,Email,Mobile No.,Level,Ticket Name,Question,Answer'; 
        temp1+='\n'; 
        list<user_answer__c> ulist=new list<user_answer__c>();
         BLN_SurveyQuestionsReportCon_BAL  surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
         ulist=surveyQuestionBAL.gnUsersForSurveyTemp(selectedEvent,scope);   
       for(user_answer__c attendee: ulist){ 
            temp1+='"'+attendee.ticket__r.tkt_profile__r.First_Name__c+' '+attendee.ticket__r.tkt_profile__r.Last_Name__c+'",';
            temp1+='"'+attendee.ticket__r.tkt_profile__r.Email__c+'",';
            temp1+='"'+attendee.ticket__r.tkt_profile__r.Mobile__c+'",';
            temp1+='"'+attendee.item_question__r.question_level__c+'",';
            if(attendee.item_question__r.question_level__c=='Ticket Level'){
                temp1+='"'+attendee.ticket__r.item_pool__r.item_pool_name__c+'",'; 
            }else{
                temp1+='"",';
            }
            temp1+='"'+attendee.Item_Question__r.Question__r.Question_Text__c+'",';
            temp1+='"'+attendee.UAnswer_Text_Update__c+'",'; 
            temp1+='\n';     
       } 

        try {
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ExportSurveybyAttendee.csv');
            attachment.setBody(Blob.valueOf(temp1));
            attachment.setContentType('text/csv');


            String emailMessage = 'Please find attached your exported data as an attachment';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {
                attachment
            });

            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

            if (owea.size() > 0) {
                mail.setOrgWideEmailAddressId(owea.get(0).Id); 
            }

            String[] toAddresses = new String[] {userinfo.getuserid()};//
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('support@eventdex.com');
            mail.setSubject('SurveybyAttendee'); 
            mail.setHtmlBody(emailMessage);


            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                mail
            });
        } catch (Exception e) {}
    }


    global void finish(Database.BatchableContext batchableContext) {}

}