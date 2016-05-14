global without sharing class BLN_ExportSurveyByQuestionResponseBatch implements Database.batchable < sObject > , Database.Stateful {
    global final String Query;
    global final List<Ticket__c> Tlist{get;set;}
    global string questionID{get;set;}
    global string selectedEvent{get;set;}
    global string queName{get;set;}
    global integer totalQueWiseCountEvent{get;set;}
    global LIST<BLN_SurveyByQuestionTabReportCon.responsesInner> responsesInnerListForQuestions{get;set;}
    global string answerOption{get;set;}
    //global list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> showeachQueSurveList{get;set;}
    global integer responseSurveyByQuestion{get;set;}

    private static final Integer SCOPE_SIZE = 100;
    public BLN_ExportSurveyByQuestionResponseBatch(String q,string questionID1, integer totalQueWiseCountEvent1,LIST<BLN_SurveyByQuestionTabReportCon.responsesInner> responsesInnerListForQuestions1,string queName1,integer responseSurveyByQuestion1) {
        Query = q;  
        questionID=questionID1;
        //selectedEvent=selectedEvent1; 
        totalQueWiseCountEvent=totalQueWiseCountEvent1;
        responsesInnerListForQuestions=new LIST<BLN_SurveyByQuestionTabReportCon.responsesInner>();
        responsesInnerListForQuestions=responsesInnerListForQuestions1; 
        //showeachQueSurveList=new list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner>();
        //showeachQueSurveList = showeachQueSurveList1;
        queName = queName1;
        responseSurveyByQuestion = responseSurveyByQuestion1;
        system.debug('aaaaaaaaaaaaa'+responseSurveyByQuestion1 +'  ddd  '+totalQueWiseCountEvent1);
    }
    global Iterable < sObject > start(Database.batchableContext batchableContext) {
        system.debug('query' + query);
        return Database.getQueryLocator(query);

    }
    global void execute(Database.BatchableContext batchableContext, List <sObject> scope) {
        
        BLN_SurveyQuestionsReportCon_BAL surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        LIST<user_answer__c> ulistRec= new LIST<user_answer__c>(); 
        ulistRec=surveyQuestionBAL.exportPrintQueAns(scope); 
        
       String temp1 = 'Question,Answer,Total Count,Response Count,Response Percentage,Skip,Skip Percentage\n';
       integer respForQue=0;
       integer checkboxRespEvent=0;
       /*for(BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner item:showeachQueSurveList){
           checkboxRespEvent++;
           integer usrNOTemp=0;
           string usrch1='';
           for(Ticket__c answrValue:item.TicketsData){
               for(User_Answer__c  ua:answrValue.User_answers__r){
                   usrNOTemp++;
                   respForQue++;
               }
           }
       }
       
       integer cbbb=0;
       for(BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner itemsss:showeachQueSurveList){
           for(Ticket__c answrValuesss:itemsss.TicketsData){
               integer usrNOsss=0;
               for(User_Answer__c  uasss:answrValuesss.User_answers__r){
                   usrNOsss++;
                   if(usrNOsss==1){
                       cbbb++;
                   }
               
               }
           }
       }*/
       
       temp1+='"'+queName+'",';
       temp1+='"",';
       temp1+='"'+totalQueWiseCountEvent+'",';
       temp1+='"';
       integer respCountQueWise=0;
       respCountQueWise=responseSurveyByQuestion;
       /*for(BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner item:showeachQueSurveList){
           for(Ticket__c answrValue:item.TicketsData){
               respCountQueWise++;
           }
       }*/
       temp1+=respCountQueWise+'",';
       decimal respprcnt=respCountQueWise*100/totalQueWiseCountEvent;
       respprcnt=respprcnt.setScale(2);
       temp1+='"'+respprcnt+'",';
       integer skip=totalQueWiseCountEvent-respCountQueWise;
       temp1+='"'+skip+'",';
       decimal skipPrcnt=(totalQueWiseCountEvent-respCountQueWise)*100/totalQueWiseCountEvent;
       skipPrcnt=skipPrcnt.setScale(2);
       temp1+='"'+skipPrcnt+'",\n';
       
       /*for(BLN_SurveyByQuestionTabReportCon.responsesInner queSummry:responsesInnerListForQuestions){
           if(answerOption!= 'Text' && answerOption!= 'Paragraph text'){
               temp1+='"'+queName+'",';
               temp1+='"'+queSummry.answerType+'",';
               temp1+='"",';
               temp1+='"'+queSummry.answerCount+'",';
               decimal respprcnt1=queSummry.answerCount*100/respCountQueWise;
               respprcnt1=respprcnt1.setScale(2);
               temp1+='"'+respprcnt1+'",';
               temp1+='"",';
               temp1+='"",\n';
           }
       }*/
       
       
       temp1+='\n\n\n';
       temp1+='Detail\n';
        /*
       integer level1=0;
       for(BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner item:showeachQueSurveList){
           for(Ticket__c answrValue:item.TicketsData){
               for(User_Answer__c  ua:answrValue.User_answers__r){
                   if(ua.item_question__r.Question_Level__c=='Event Level'){
                       level1++;
                   }
               }
           }
       }
       */
 
               
               temp1+='Question,Answer,Ticket Name,Email,Order Id,Ticket Id,Attendee Name\n';
                string ansNo='';
            for(User_Answer__c  usrAnswers : ulistRec){
                //if(usrAnswers.Item_Question__r.Question__r.Answer_Type__c!='Checkboxes'){
                    
                    
                    temp1+='"'+usrAnswers.item_question__r.question__r.Question_Text__c+'",';                    
                    temp1+='"'+usrAnswers.UAnswer_Text__c+'",';
                    if(usrAnswers.item_question__r.question_level__c=='Event Level'){
                    temp1+='"Event Level",';
                    }else if(usrAnswers.item_question__r.question_level__c=='Ticket Level'){
                        if(usrAnswers.item_question__r.item__c!=null)
                        temp1+='"'+usrAnswers.item_question__r.item__r.item_name__c+'",';
                        else if(usrAnswers.item_question__r.item_pool__c!=null)
                        temp1+='"'+usrAnswers.item_question__r.item_pool__r.item_pool_name__c+'",';
                    }
                    temp1+='"'+usrAnswers.ticket__r.tkt_profile__r.Email__c+'",';
                    temp1+='"'+usrAnswers.Ticket__r.Order__r.name+'",';
                    temp1+='"'+usrAnswers.ticket__r.name+'",';
                    temp1+='"'+usrAnswers.ticket__r.tkt_profile__r.First_Name__c+' '+usrAnswers.ticket__r.tkt_profile__r.Last_Name__c+'",\n';
               // }
               
            }
       

        try {
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('SurveybyQuestionCurrentViewExport.csv');
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
                //emailTOea.setOrgWideEmailAddressId(owea.get(0).Id);
            }

            String[] toAddresses = new String[]{userinfo.getuserid()};//UserInfo.getUserName()
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('support@eventdex.com');
            mail.setSubject('Survey by Question Current View Export');
            //mail.setPlainTextBody(emailMessage);
            mail.setHtmlBody(emailMessage);


            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
                mail
            });
        } catch (Exception e) {}
    }


    global void finish(Database.BatchableContext batchableContext) {}

}