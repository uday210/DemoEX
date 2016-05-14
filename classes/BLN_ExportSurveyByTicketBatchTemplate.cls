global without sharing class BLN_ExportSurveyByTicketBatchTemplate implements Database.batchable<sObject> , Database.Stateful{
   global final String Query;
   global string selectedQuestion{get;set;}
   global string selectedItemName{get;set;}
   global integer totalOrders{get;set;}
   global LIST<BLN_SurveyByTicketTabReportCon.responsesInner> responsesInnerList{get;set;}
   global string itemAnswerType{get;set;} 
  
   public BLN_ExportSurveyByTicketBatchTemplate (String q,string selectedQuestion1 ) {
       Query = q; 
       selectedQuestion=selectedQuestion1; 
   }
   global Iterable < sObject > start(Database.batchableContext batchableContext) {
       system.debug('query' + query);
       return Database.getQueryLocator(query);
   }
   global void execute(Database.BatchableContext batchableContext, List<sObject> scope){

        BLN_SurveyQuestionsReportCon_BAL surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        LIST<user_answer__c> surveyAttendeeInnerList1= new LIST<user_answer__c>();
        //surveyAttendeeInnerList1=surveyQuestionBAL.gnUsersForSurvey1(selectedQuestion,scope);
        surveyAttendeeInnerList1=surveyQuestionBAL.exportPrintQueAns(scope);
        //exportPrintQueAns(selectedEvent
       
        
        String temp1='Ticket Name,Email,Order Id,Ticket Id, Question, Answer, Answer Type, Level, Name\n';
        //for(item_question__c answer:surveyAttendeeInnerList1){
            string ansNo='';
            for(User_Answer__c  usrAnswers : surveyAttendeeInnerList1){
                //if(usrAnswers.Item_Question__r.Question__r.Answer_Type__c!='Checkboxes'){
                    if(usrAnswers.item_question__r.question_level__c=='Event Level'){
                    temp1+='"Event Level",';
                    }else if(usrAnswers.item_question__r.question_level__c=='Ticket Level'){
                        if(usrAnswers.item_question__r.item__c!=null)
                        temp1+='"'+usrAnswers.item_question__r.item__r.item_name__c+'",';
                        else if(usrAnswers.item_question__r.item_pool__c!=null)
                        temp1+='"'+usrAnswers.item_question__r.item_pool__r.item_pool_name__c+'",';
                    }
                    
                    temp1+='"'+usrAnswers.ticket__r.tkt_profile__r.email__c+'",';
                    temp1+='"'+usrAnswers.ticket__r.order__r.name+'",';
                    temp1+='"'+usrAnswers.ticket__r.Name+'",';
                    
                    temp1+='"'+usrAnswers.item_question__r.question__r.Question_Text__c+'",';                    
                    temp1+='"'+usrAnswers.UAnswer_Text__c+'",';
                    temp1+='"'+usrAnswers.item_question__r.question__r.answer_type__c+'",';
                    temp1+='"'+usrAnswers.item_question__r.question_level__c+'",';
                    temp1+='"'+usrAnswers.ticket__r.tkt_profile__r.First_Name__c+' '+usrAnswers.ticket__r.tkt_profile__r.Last_Name__c+'",\n';
               // }
               
            }
        //}

       
       
       
       try {
           Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
           attachment.setFileName('SurveybyTicketExport.csv');
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

           String[] toAddresses = new String[] {userinfo.getuserid()};//userinfo.getuserid()
           mail.setToAddresses(toAddresses);
           mail.setReplyTo('support@eventdex.com');
           mail.setSubject('Survey by Ticket Export');
           mail.setHtmlBody(emailMessage);


           Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
               mail
           });
           

       } catch (Exception e) {}
   }


   global void finish(Database.BatchableContext batchableContext) {}

}