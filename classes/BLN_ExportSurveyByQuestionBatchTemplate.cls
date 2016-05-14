global without sharing class BLN_ExportSurveyByQuestionBatchTemplate implements Database.batchable < sObject > , Database.Stateful {
   global final String Query;
   global string selectedQuestion{get;set;}
   global string selectedItemName{get;set;}
   global integer totalOrders{get;set;}
   global LIST<BLN_SurveyByTicketTabReportCon.responsesInner> responsesInnerList{get;set;}
   global string itemAnswerType{get;set;} 
  
   public BLN_ExportSurveyByQuestionBatchTemplate (String q,string selectedQuestion1 ) {
       Query = q; 
       selectedQuestion=selectedQuestion1; 
   }
   global Iterable < sObject > start(Database.batchableContext batchableContext) {
       system.debug('query' + query);
       return Database.getQueryLocator(query);
   }
   global void execute(Database.BatchableContext batchableContext, List < sObject > scope) {

        BLN_SurveyQuestionsReportCon_BAL surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        LIST<user_answer__c> surveyAttendeeInnerList1= new LIST<user_answer__c>();
        //surveyAttendeeInnerList1=surveyQuestionBAL.gnUsersForSurvey1(selectedQuestion,scope);
        surveyAttendeeInnerList1=surveyQuestionBAL.exportPrintQueAns(scope);
        //exportPrintQueAns(selectedEvent
       
       String temp1='';
      Integer sNo=0;
      Set<Id> questionId=new Set<Id>(); 
      for(sObject iq1 : scope){
            user_answer__c iq = (user_answer__c)iq1;
            if(questionId.contains(iq.item_question__r.question__r.id)==false){
                questionId.add(iq.item_question__r.question__c);
                sNo=sNo+1;
            temp1+='Q'+string.valueOf(sNo)+':'+' ';
            if(iq.item_question__r.question__r.Question_Text__c!= null && iq.item_question__r.question__r.Question_Text__c!=''){ 
                temp1+= iq.item_question__r.question__r.Question_Text__c ;
            }else{
                temp1+='"",';
            }
            temp1+='\n'; 
       
        

           //Getting list of attendees who answered
            temp1+='Name,Ticket Name,Email,Order Id,Ticket Id,Answer\n';
            Set<Id> ticketName=new Set<Id>();
            
                    for(user_answer__c u : surveyAttendeeInnerList1){
                        if(u.item_question__r.question__r.id==iq.item_question__r.question__r.id){
                            
                            if(u.item_question__r.question__r.answer_type__c!='Checkboxes'){
                                if (u.ticket__r.tkt_profile__r.First_Name__c!= null && u.ticket__r.tkt_profile__r.First_Name__c!='') { 
                                    temp1+='"'+u.ticket__r.tkt_profile__r.First_Name__c+' '+u.ticket__r.tkt_profile__r.Last_Name__c+'",';
                                } else {
                                    temp1+='"",';
                                }
                                
                                if(u.item_question__r.item__c!= null) { 
                                    temp1+='"'+u.item_question__r.item__r.item_name__c+'",';
                                } else if(u.item_question__r.item_pool__c!=null){
                                    temp1+='"'+u.item_question__r.item_pool__r.Item_Pool_Name__c+'",';    
                                }else{
                                    temp1+='"",';
                                }
                                
                                if(u.ticket__r.tkt_profile__r.email__c!= null && u.ticket__r.tkt_profile__r.email__c!='') { 
                                    temp1+='"'+u.ticket__r.tkt_profile__r.email__c+'",';
                                }else{
                                    temp1+='"",';
                                }
                                
                                if(u.ticket__r.order__r.name!= null && u.ticket__r.order__r.name!='') { 
                                    temp1+='"'+u.ticket__r.order__r.name+'",';
                                }else{
                                    temp1+='"",';
                                }
                                
                                if(u.ticket__r.name!= null && u.ticket__r.name!='') { 
                                    temp1+='"'+u.ticket__r.name+'",';
                                }else{
                                    temp1+='"",';
                                }
                                
                                if(u.UAnswer_Text__c!= null && u.UAnswer_Text__c!='') { 
                                    temp1+='"'+u.UAnswer_Text__c+'",';
                                }else{
                                    temp1+='"",';
                                }
                                temp1+='\n';
                            }
                            
                            if(u.item_question__r.question__r.answer_type__c=='Checkboxes'){
                                if(ticketName.contains(u.ticket__r.id)==false){
                                    ticketName.add(u.ticket__r.id);
                                    if (u.ticket__r.tkt_profile__r.First_Name__c!= null && u.ticket__r.tkt_profile__r.First_Name__c!='') { 
                                        temp1+='"'+u.ticket__r.tkt_profile__r.First_Name__c+' '+u.ticket__r.tkt_profile__r.Last_Name__c+'",';
                                    } else {
                                        temp1+='"",';
                                    }
                                    
                                    if(u.item_question__r.item__c!= null) { 
                                        temp1+='"'+u.item_question__r.item__r.item_name__c+'",';
                                    } else if(u.item_question__r.item_pool__c!=null){
                                        temp1+='"'+u.item_question__r.item_pool__r.Item_Pool_Name__c+'",';    
                                    }else{
                                        temp1+='"",';
                                    }
                                    
                                    if(u.ticket__r.tkt_profile__r.email__c!= null && u.ticket__r.tkt_profile__r.email__c!='') { 
                                        temp1+='"'+u.ticket__r.tkt_profile__r.email__c+'",';
                                    }else{
                                        temp1+='"",';
                                    }
                                    
                                    if(u.ticket__r.order__r.name!= null && u.ticket__r.order__r.name!='') { 
                                        temp1+='"'+u.ticket__r.order__r.name+'",';
                                    }else{
                                        temp1+='"",';
                                    }
                                    
                                    if(u.ticket__r.name!= null && u.ticket__r.name!='') { 
                                        temp1+='"'+u.ticket__r.name+'",';
                                    }else{
                                        temp1+='"",';
                                    }
                                        
                                    for(user_answer__c u1 : surveyAttendeeInnerList1){
                                        if(u1.item_question__r.question__r.answer_type__c=='Checkboxes'){
                                            if(u1.item_question__r.question__r.id==u.item_question__r.question__r.id)
                                            temp1+='"'+u.UAnswer_Text__c+'",';    
                                        }
                                    }
                                    
                                    
                                    temp1+='\n'; 
                                }
                                   
                            }
                            
                        } 
                    }
                
                }
            }
       
       
       try {
           Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
           attachment.setFileName('SurveybyQuestionExport.csv');
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
           mail.setSubject('Survey by Question Export');
           mail.setHtmlBody(emailMessage);


           Messaging.sendEmail(new Messaging.SingleEmailMessage[] {
               mail
           });
           

       } catch (Exception e) {}
   }


   global void finish(Database.BatchableContext batchableContext) {}

}