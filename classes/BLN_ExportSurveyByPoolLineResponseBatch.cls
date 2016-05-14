global without sharing class BLN_ExportSurveyByPoolLineResponseBatch implements Database.batchable < sObject > , Database.Stateful {
   global final String Query;
   global string selectedQuestion{get;set;}
   global string selectedItemName{get;set;}
   global integer totalOrders{get;set;}
   global LIST<user_answer__c> responsesInnerList{get;set;}
   global string itemAnswerType{get;set;}
   global integer responded{get;set;}
   global string ques{get;set;}
   global LIST<BLN_SurveyByTicketTabReportCon.responsesItemPoolInner> responsesItemPoolInnerList{get;set;}

   private static final Integer SCOPE_SIZE = 100;
   public BLN_ExportSurveyByPoolLineResponseBatch (String q,string selectedQuestion1, string selectedItemName1,integer totalOrders1,LIST<user_answer__c> responsesInnerList1,string itemAnswerType1,integer responded1,string ques1,LIST<BLN_SurveyByTicketTabReportCon.responsesItemPoolInner> responsesItemPoolInnerList1) {//,responsesInnerList
       Query = q;
       selectedItemName = selectedItemName1;
       selectedQuestion=selectedQuestion1;
       totalOrders=totalOrders1;
       responsesInnerList=responsesInnerList1;
       itemAnswerType=itemAnswerType1;
       responded =responded1;
       ques=ques1;
       responsesItemPoolInnerList = new LIST<BLN_SurveyByTicketTabReportCon.responsesItemPoolInner>();
       responsesItemPoolInnerList = responsesItemPoolInnerList1;
   }
   global Iterable < sObject > start(Database.batchableContext batchableContext) {
       system.debug('query' + query);
       return Database.getQueryLocator(query);

   }
   global void execute(Database.BatchableContext batchableContext, List <sObject> scope) { 
        BLN_SurveyQuestionsReportCon_BAL surveyQuestionBAL=new BLN_SurveyQuestionsReportCon_BAL ();  
        LIST<user_answer__c> surveyAttendeeInnerList1= new LIST<user_answer__c>();
        surveyAttendeeInnerList1=surveyQuestionBAL.gnUsersForSurvey2(selectedQuestion,scope);
       
        String temp1 = 'Ticket,Question,Answer,Total Count,Response Count,Response Percentage,Skip,Skip Percentage\n';
        /*
        integer responded=0;
        integer respondedforallattendees=0;
        for(BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1 answer11:surveyAttendeeInnerList1){
            responded++;
        }*/
       
       temp1+='"';
       if(selectedItemName==null){
           temp1+='Event Level';
       }else{
           temp1+=selectedItemName;
       }
       temp1+='",';
        
       temp1+='"';
        
      /* for(User_Answer__c  usrAnswers:answer.answer:surveyAttendeeInnerList1){ 
           temp1+=usrAnswers.item_question__r.question__r.Question_Text__c; 
       }*/
           
       temp1+=ques+'",'; 

        temp1+='"",';
        temp1+='"'+totalOrders+'",';
        temp1+='"'+responded+'",';
        decimal respPrcnt=(responded)*100/(totalOrders);
        respPrcnt=respPrcnt.setScale(2);
        temp1+='"'+respPrcnt+'",';
        integer skip = totalOrders-responded;
        temp1+='"'+skip+'",';
        decimal skipPrcnt=(totalOrders-responded)*100/(totalOrders);
        skipPrcnt=skipPrcnt.setScale(2);
        temp1+='"'+skipPrcnt+'",\n';
       
       for(BLN_SurveyByTicketTabReportCon.responsesItemPoolInner summary:responsesItemPoolInnerList){
            if(itemAnswerType != 'Text' && itemAnswerType != 'Paragraph text'){
                temp1+='"",';
                temp1+='"';
                integer loop3=0;
                /*for(BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1 answer:surveyAttendeeInnerList1){
                   loop3++;
                   integer loop4=0;
                   for(User_Answer__c  usrAnswers:answer.TicketsData1){
                       loop4++;
                       if(loop3==1 && loop4==1){
                           temp1+=usrAnswers.item_question__r.question__r.Question_Text__c;
                       }
                   }
               }*/
                temp1+=ques+'",';
                temp1+='"'+summary.itemPoolanswerType+'",';
                temp1+='"",';
                temp1+='"'+summary.itemPoolanswerCount+'",';
                decimal respPercnt=(summary.itemPoolanswerCount)*100/(responded);
                respPercnt=respPercnt.setScale(2);
                temp1+='"'+respPercnt+'",';
                temp1+='"",';
                temp1+='"",\n';
            }
        }  
          
        temp1+='\n\n\n';
        temp1+='Detail\n\n';
       
       
        temp1+= 'Ticket Name,Attendee Name,Email,Order Id,Ticket Id,Question,Answer\n';
        
            string ansNo='';
            for(User_Answer__c  usrAnswers : surveyAttendeeInnerList1){ 
                if(usrAnswers.item_question__r.question_level__c=='Event Level'){
                temp1+='"Event Level",';
                }else if(usrAnswers.item_question__r.question_level__c=='Ticket Level'){
                    if(usrAnswers.item_question__r.item__c!=null)
                    temp1+='"'+usrAnswers.item_question__r.item__r.item_name__c+'",';
                    
                    if(usrAnswers.item_question__r.item_pool__c!=null)
                    temp1+='"'+usrAnswers.item_question__r.item_pool__r.item_pool_name__c+'",'; 
                }
                temp1+='"'+usrAnswers.ticket__r.tkt_profile__r.First_Name__c+' '+usrAnswers.ticket__r.tkt_profile__r.Last_Name__c+'",';
                
                temp1+='"'+usrAnswers.ticket__r.tkt_profile__r.email__c+'",';
                temp1+='"'+usrAnswers.ticket__r.order__r.name+'",';
                temp1+='"'+usrAnswers.ticket__r.name+'",';
                
                temp1+='"'+usrAnswers.item_question__r.question__r.Question_Text__c+'",';
                temp1+='"'+usrAnswers.UAnswer_Text__c+'",\n'; 
            }
       
       
       
       try {
           Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
           attachment.setFileName('SurveybyTicketLineitemCurrentview.csv');
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
           mail.setSubject('Survey by Ticket Line item Current view');
           mail.setHtmlBody(emailMessage);


           Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
               mail
           });
           

       } catch (Exception e) {}
   }


   global void finish(Database.BatchableContext batchableContext) {}

}