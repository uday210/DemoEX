public with sharing class BLN_UserAnswers_DAO{

/***************************************************************************************************************************************************************************************************
*   Author                  : Mahesh Sakunala
*   Date                    : 28/07/2014 
*   Purpose                 : This class is for inserting and fetching User Answers for Survey Questions.
*   Last Modified           : Mahesh Sakunala - 28/07/2014
*****************************************************************************************************************************************************************************************************/

//------------------------------------------------------------- Method to insert User Answer Start --------------------------------------------------------------------------------     
     //Inserting other than text and paragraph
     public BLN_StatusMessage insertUserAnswer(String AnswerId, Id ItemQuestionId,id tid){         
         // Fetching Answer Details using Answer Id
         Item_Question__c itmQue=[select id,name,question_level__c,question__r.answer_type__c from Item_Question__c where id= : ItemQuestionId limit 1];
         User_Answer__c UAnswer;
         if(itmQue.question__r.answer_type__c!='Text' && itmQue.question__r.answer_type__c!='Paragraph text'){
             LIST<BLN_Answer__c> Answer = new LIST<BLN_Answer__c>();
             Answer = [SELECT ID,NAME,Answer_Order__c,Answer_Text__c,Answer_Default__c,BLN_Question__r.answer_type__c 
                       FROM BLN_Answer__c 
                       WHERE ID =: AnswerId];         
             
             UAnswer = new User_Answer__c();
             UAnswer.Ticket__c = tid;
             UAnswer.Item_Question__c = ItemQuestionId;
             if(Answer.size() > 0){
                 UAnswer.BLN_Answer__c =  Answer[0].Id;
                 UAnswer.UAnswer_Text__c = Answer[0].Answer_Text__c;
             }             
         } 
         Database.Saveresult Response = Database.Insert(UAnswer,false);
         return new BLN_StatusMessage(Response);        
     }
     
      //Inserting text and paragraph
     public BLN_StatusMessage insertUserAnswerTxtPara(String AnswerId, Id ItemQuestionId,id tid){
         // Fetching Answer Details using Answer Id
         Item_Question__c itmQue=[select id,name,question_level__c,question__r.answer_type__c from Item_Question__c where id= : ItemQuestionId limit 1];
         User_Answer__c UAnswer;
         if(itmQue.question__r.answer_type__c=='Text' || itmQue.question__r.answer_type__c=='Paragraph text'){
             UAnswer = new User_Answer__c();
             UAnswer.Ticket__c = tid; 
             UAnswer.Item_Question__c = ItemQuestionId;
             UAnswer.UAnswer_Text__c = AnswerId;           
         } 
         Database.Saveresult Response = Database.Insert(UAnswer,false);
         return new BLN_StatusMessage(Response);        
     }
//------------------------------------------------------------- Method to insert User Answer End --------------------------------------------------------------------------------  
  
//------------------------------------------------------------- Method to upsert surey User Answer omn attendeenfo popup Start --------------------------------------------------------------------------------     
     //upserting other than txt,para and checkboxes
         
     public BLN_StatusMessage upsertSurveyUserAnswer(String AnswerId, Id ItemQuestionId,id tid, id usransID,string oldValue){ 
        //deleting old child answers
        if(oldValue!=null && oldValue!=''){
        //Deleting old child values of parent question start
            Set<id> oldQuestionId=new Set<id>();
            for(question__c qq : [select id,name from Question__c where BLN_Parent_Answer__c= : oldValue and Answer_Type__c!='Checkboxes' and Answer_Type__c!='Text' and Answer_Type__c!='Paragraph text']){
                oldQuestionId.add(qq.id);
            }
            
            Set<id> oldItemsQuestionId=new Set<id>();
            for(item_question__c iq : [select id,name from Item_question__c where question__c in : oldQuestionId]){
                oldItemsQuestionId.add(iq.id);
            }
            
            List<user_answer__c> oldUAnsList=new List<user_answer__c>();
            for(user_answer__c ua : [select id,name from user_answer__c where item_question__c in : oldItemsQuestionId and ticket__c = : tid]){
                oldUAnsList.add(ua);
            }
            
            if(oldUAnsList.size()>0)        
            database.delete(oldUAnsList,false);
        //Deleting old child values of parent question end
        }
         
         Item_Question__c itmQue=[select id,name,question__r.answer_type__c from item_question__c where id= : ItemQuestionId limit 1];
         
         Database.Upsertresult Response;
          
         if(itmQue.question__r.answer_type__c!='Text' && AnswerId!='' && AnswerId!=null && itmQue.question__r.answer_type__c!='Paragraph text' && itmQue.question__r.answer_type__c!='Checkboxes'){
             // Fetching Answer Details using Answer Id
             LIST<BLN_Answer__c> Answer = new LIST<BLN_Answer__c>();
             Answer = [SELECT ID,NAME,Answer_Text__c,Answer_Order__c,Answer_Default__c,BLN_Question__r.BLN_Parent_Answer__c 
                       FROM BLN_Answer__c 
                       WHERE ID =: AnswerId];
             
             User_Answer__c UAnswer=new User_Answer__c();
             UAnswer.id=usransID;
             if(AnswerId!=null){
                 UAnswer.Ticket__c = tid; 
                 UAnswer.Item_Question__c = ItemQuestionId;
                 if(Answer.size() > 0){
                     UAnswer.BLN_Answer__c =  Answer[0].Id;
                     UAnswer.UAnswer_Text__c = Answer[0].Answer_Text__c;
                 }
                 Response =Database.upsert(UAnswer,false); 
             } 
         }else if(itmQue.question__r.answer_type__c!='Text' && itmQue.question__r.answer_type__c!='Paragraph text' && itmQue.question__r.answer_type__c!='Checkboxes'){
            /* list<Database.deleteresult> response1;
             list<User_Answer__c> listuserans = new list<User_Answer__c>();
             listuserans = [SELECT id,name from user_answer__c where item_question__c =: ItemQuestionId];
            response1 = database.delete(listuserans,false);*/
            User_Answer__c UAnswer=new User_Answer__c();
             UAnswer.id=usransID;
                 UAnswer.Ticket__c = tid; 
                 UAnswer.Item_Question__c = ItemQuestionId;
                     UAnswer.BLN_Answer__c =  null;
                     UAnswer.UAnswer_Text__c = '';
                 Response =Database.upsert(UAnswer,false); 
         }
         return new BLN_StatusMessage(Response);
        
     }
     
     //upserting  txt,para 
     public BLN_StatusMessage upsertSurveyUserAnswerTxtPara(String AnswerId, Id ItemQuestionId,id tid, id usransID,string oldValue){
        //deleting old child answers 
        if(oldValue!=null && oldValue!=''){
        //Deleting old child values of parent question start
            Set<id> oldQuestionId=new Set<id>();
            for(question__c qq : [select id,name from Question__c where BLN_Parent_Answer__c= : oldValue and (Answer_Type__c='Text' OR Answer_Type__c='Paragraph text')]){
                oldQuestionId.add(qq.id);
            }
            
            Set<id> oldItemsQuestionId=new Set<id>();
            for(item_question__c iq : [select id,name from Item_question__c where question__c in : oldQuestionId]){
                oldItemsQuestionId.add(iq.id);
            }
            
            List<user_answer__c> oldUAnsList=new List<user_answer__c>();
            for(user_answer__c ua : [select id,name from user_answer__c where item_question__c in : oldItemsQuestionId and ticket__c = : tid]){
                oldUAnsList.add(ua);
            }
            System.debug(oldUAnsList.size()+':::DDDDDLLLL:::'+oldUAnsList);
            if(oldUAnsList.size()>0)        
            database.delete(oldUAnsList,false);
        //Deleting old child values of parent question end
        }
         
         Item_Question__c itmQue=[select id,name,question__r.answer_type__c from item_question__c where id= : ItemQuestionId limit 1];
         
         Database.Upsertresult Response;
         if(itmQue.question__r.answer_type__c=='Text' || itmQue.question__r.answer_type__c=='Paragraph text'){
             User_Answer__c UAnswer=new User_Answer__c();
             UAnswer.id=usransID;
             if(AnswerId!=null && AnswerId!=''){
                 UAnswer.Ticket__c = tid; 
                 UAnswer.Item_Question__c = ItemQuestionId;
                 UAnswer.UAnswer_Text__c = AnswerId;
                 Response =Database.upsert(UAnswer,false); 
             } else{
            /* list<Database.deleteresult> response1;
             list<User_Answer__c> listuserans = new list<User_Answer__c>();
             listuserans = [SELECT id,name from user_answer__c where item_question__c =: ItemQuestionId];
            response1 = database.delete(listuserans,false);*/
            //User_Answer__c UAnswer=new User_Answer__c();
            // UAnswer.id=usransID;
                 UAnswer.Ticket__c = tid; 
                 UAnswer.Item_Question__c = ItemQuestionId;
                     UAnswer.UAnswer_Text__c = '';
                 Response =Database.upsert(UAnswer,false); 
         }
         }
         return new BLN_StatusMessage(Response);        
     }
     
     //method to save checkbox type survey Question
     public BLN_StatusMessage upsertCheckboxSurveyUserAnswer(String[] checkboxAnsList, Id ItemQuestionId,id tid,set<id> chbxId,string oldValue){
        //deleting old child answers
        if(oldValue!=null){
        //Deleting old child values of parent question start 
            Set<id> oldQuestionId=new Set<id>();
            for(question__c qq : [select id,name from Question__c where BLN_Parent_Answer__c= : oldValue and Answer_Type__c='Checkboxes']){
                oldQuestionId.add(qq.id);
            }
            
            Set<id> oldItemsQuestionId=new Set<id>();
            for(item_question__c iq : [select id,name from Item_question__c where question__c in : oldQuestionId]){
                oldItemsQuestionId.add(iq.id);
            }
         
            List<user_answer__c> oldUAnsList=new List<user_answer__c>();
            for(user_answer__c ua : [select id,name from user_answer__c where item_question__c in : oldItemsQuestionId and ticket__c = : tid ]){//and item_question__r.question_level__c!='Ticket Level'
                oldUAnsList.add(ua);
     }
     
            if(oldUAnsList.size()>0)        
            database.delete(oldUAnsList,false);
        //Deleting old child values of parent question end
        }
         
         // Fetching Answer Details using Answer Id
         Set<ID> chID=new Set<ID>();
         for(string s : checkboxAnsList){
             chID.add(s);
         }
         System.debug('SZSZZZZZZZZZZZZZ:'+checkboxAnsList);
         
         LIST<BLN_Answer__c> Answer = new LIST<BLN_Answer__c>();
         Answer = [SELECT ID,NAME,Answer_Text__c,Answer_Order__c,Answer_Default__c,BLN_Question__r.BLN_Parent_Answer__c 
                   FROM BLN_Answer__c 
                   WHERE ID in : chID and bln_question__r.answer_type__c='Checkboxes'];
         System.debug('ANSANSSSSSS:::'+Answer );
          
         Database.saveresult Response;
         
         List<User_Answer__c> usransSaved=new List<User_Answer__c>();
         List<User_Answer__c> usransToBeInsert=new List<User_Answer__c>();
         
         usransSaved=[select id,name,uanswer_text__c from User_Answer__c Where id in : chbxId ];
         database.delete(usransSaved,false);
         
         for(integer k=0; k<checkboxAnsList.size();k++){
             User_Answer__c u=new User_Answer__c();
             u.Ticket__c = tid; 
             u.Item_Question__c = ItemQuestionId;
             u.BLN_Answer__c =  Answer[k].Id;
             u.UAnswer_Text__c = Answer[k].Answer_Text__c;
             response=Database.insert(u,false);
         }
         return new BLN_StatusMessage(Response);    
     }
     
     //deleting  txt,para 
     public void deleteSurveyUserAnswerTxtPara(String AnswerId, Id ItemQuestionId,id tid, id usransID ){
         
         List<user_answer__c> uaList=[select id,name,Uanswer_text__c,Uanswer_text_Update__c from User_Answer__c where
                                     item_question__c= : ItemQuestionId and ticket__c= : tid and (item_question__r.question__r.answer_type__c='Text' or item_question__r.question__r.answer_type__c='Paragraph text')];
          
         database.delete(uaList,false);      
     }
//------------------------------------------------------------- Method to upsert surey User Answer End --------------------------------------------------------------------------------    


//------------------------------------------------------------- Method to Fetch User Answer Start --------------------------------------------------------------------------------     
     public LIST<User_Answer__c> fetchUserAnswer(Id ticketId){
         
         // Fetching User Answer Details using User Id
         LIST<User_Answer__c> UserAnswer = [SELECT ID,NAME,Item_Question__c,BLN_Answer__c,BLN_Answer__r.Answer_Text__c,UAnswer_Text__c 
                                            FROM User_Answer__c
                                            WHERE Ticket__c =: ticketId];
         return UserAnswer;
     }
//------------------------------------------------------------- Method to Fetch User Answer End --------------------------------------------------------------------------------  
    
    // To fetch the User Answers based on the users and items written by Manasa Gandham 
    public LIST<User_Answer__c> userAnswersForTickets(SET<Id> tid,SET<Id> itemIds, String EventId){
        LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
        userAnswersList= [SELECT Id,Item_question__r.Item__r.item_name__c,Item_question__r.item_pool__r.item_pool_name__c,Item_question__r.question__r.answer_type__c,Ticket__r.Parent_ID__c,Ticket__r.Item__c,Ticket__r.Item_Pool__c,Item_Question__r.Question_Level__c, Item_Question__r.Item__c, Item_Question__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Ticket__r.tkt_profile__r.Id,
                          Item_Question__r.Item_Pool__c,ticket__r.tkt_profile__r.email__c
                          FROM User_Answer__c 
                          WHERE 
                          ticket__c IN : tid
                          AND (Item_Question__r.Item__c IN: itemIds OR Item_Question__r.Item_Pool__c IN: itemIds)  
                          AND (Item_Question__r.Item__r.Event__c =: EventId OR Item_Question__r.Item_Pool__r.Event__c =: EventId)
                          AND ticket__r.ticket_status__c='Booked' ORDER BY Item_Question__r.question__r.question_order__c ASC];
        return userAnswersList;
    }
    
    //To get event level survey questions
    public LIST<User_Answer__c> userAnswersForEventLevelSurveyQuestions(SET<Id> tid,String EventId){
        LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
        userAnswersList= [SELECT Id,item_question__r.question__r.answer_type__c,item_question__r.item__r.id,item_question__r.item_pool__r.id,Ticket__r.Parent_ID__c,Ticket__r.Item__c,Ticket__r.Item_Pool__c,Item_Question__r.Question_Level__c, Item_Question__r.Item__c, Item_Question__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, 
                          Item_Question__r.Item_Pool__c,ticket__r.tkt_profile__r.email__c
                          FROM User_Answer__c 
                          WHERE 
                          ticket__c IN : tid
                          AND Item_Question__r.Question_Level__c='Event Level'  
                          AND Item_Question__r.Question__r.Event__c =: EventId
                          AND ticket__r.ticket_status__c='Booked'
                          ORDER BY Item_Question__r.question__r.question_order__c ASC];
        System.debug('EEEEEEEE:::::EEEE::'+userAnswersList);
        return userAnswersList;
        
    }
    
    //Method to get question wise responses
    public LIST<AggregateResult> questionWiseResp(String questionID){
        LIST<AggregateResult> answersAggregateResult= new LIST<AggregateResult>();
        answersAggregateResult= [SELECT COUNT(Id) selCount,UAnswer_Text_Update__c ansType
                                 FROM User_Answer__c 
                                 WHERE Item_Question__r.question__c= : questionID AND  ticket__r.ticket_status__c='Booked'
                                 GROUP BY UAnswer_Text_Update__c ];
        return answersAggregateResult;
    }
    
    //Method to get question wise responses forXport
    public LIST<AggregateResult> questionWiseRespXprint(set<id> questionID){
        LIST<AggregateResult> answersAggregateResult= new LIST<AggregateResult>();
        answersAggregateResult= [SELECT COUNT(Id) selCount,UAnswer_Text_Update__c ansType,item_question__r.question__r.id quetype
                                 FROM User_Answer__c 
                                 WHERE Item_Question__r.question__c in : questionID 
                                 AND ticket__r.ticket_status__c='Booked'
                                 GROUP BY UAnswer_Text_Update__c ,item_question__r.question__r.id];
        return answersAggregateResult;
    }
    
    //Method to get count of item answrs
    public LIST<AggregateResult> userAnswersForItemQuestion(String itemQuestionId){
        LIST<AggregateResult> answersAggregateResult= new LIST<AggregateResult>();
        answersAggregateResult= [SELECT COUNT(Id) selCount,UAnswer_Text_Update__c ansType
                                 FROM User_Answer__c 
                                 WHERE Item_Question__c=: itemQuestionId 
                                 AND ticket__r.ticket_status__c='Booked'
                                 AND Ticket__r.Order__r.Order_Status__c != 'Abandoned' 
                                 AND Ticket__r.Order__r.Order_Status__c != 'Cancelled'
                                 GROUP BY UAnswer_Text_Update__c ]; 
        return answersAggregateResult;
    }
    
    //Method to get count of item pool answrs
    public LIST<AggregateResult> userAnswersForItemPoolQuestion(String SelectedItempoolQuestion){
        LIST<AggregateResult> answersAggregateResult= new LIST<AggregateResult>();
        answersAggregateResult= [SELECT COUNT(Id) selCount,UAnswer_Text_Update__c ansType
                                 FROM User_Answer__c 
                                 WHERE Item_Question__c=: SelectedItempoolQuestion
                                 AND ticket__r.ticket_status__c='Booked'
                                 GROUP BY UAnswer_Text_Update__c ];//UAnswer_Text__c ansType,GROUP BY UAnswer_Text__c 
        return answersAggregateResult;
    }
    
    public Integer allUserAnswersForItemQuestion(String itemQuestionId){
        LIST<AggregateResult> answersAggregateResult= new LIST<AggregateResult>();
        Integer allResponses= 0;
        answersAggregateResult= [SELECT COUNT(Id)
                               FROM User_Answer__c 
                               WHERE Item_Question__c =: itemQuestionId
                               AND ticket__r.ticket_status__c='Booked'];
        allResponses= Integer.valueOf(answersAggregateResult[0].get('expr0'));
        return allResponses;
    }
    //For print and xporot
    public Integer allUserAnswersForItemQuestionPrintXport(String eventID){
        LIST<AggregateResult> answersAggregateResult= new LIST<AggregateResult>();
        Integer allResponses= 0;
        answersAggregateResult= [SELECT COUNT(Id)
                               FROM User_Answer__c 
                               WHERE Item_Question__r.Question__r.Event__c =: eventID
                               AND ticket__r.ticket_status__c='Booked'];
        allResponses= Integer.valueOf(answersAggregateResult[0].get('expr0'));
        return allResponses;
    }
    
    //For item question
    public LIST<User_Answer__c> userAnswersList(String itemQuestionId){
        LIST<User_Answer__c> answersList= new LIST<User_Answer__c>();
        answersList= [SELECT Id,Uanswer_text_update__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c
                      FROM User_Answer__c 
                      WHERE Item_Question__c =: itemQuestionId 
                      AND ticket__r.ticket_status__c='Booked'
                      ORDER BY ticket__r.order__r.createdDate ASC];
        return answersList;
    }
    
    //For item question with searchKey
    public LIST<User_Answer__c> userAnswersList(String itemQuestionId,String searchKey){
        LIST<User_Answer__c> answersList= new LIST<User_Answer__c>();
        answersList= [SELECT Id,Uanswer_text_update__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c
                      FROM User_Answer__c 
                      WHERE Item_Question__c= : itemQuestionId 
                      AND ticket__r.ticket_status__c='Booked'
                      AND (ticket__r.tkt_profile__r.first_name__c like : '%'+searchkey+'%' OR ticket__r.tkt_profile__r.last_name__c like : '%'+searchkey+'%' OR ticket__r.item__r.item_name__c like : '%'+searchkey+'%' OR ticket__r.item_pool__r.item_pool_name__c like : '%'+searchkey+'%')
                      ORDER BY ticket__r.order__r.createdDate ASC];
        return answersList;
    }
    
    //For item question for print and export
    public LIST<User_Answer__c> userAnswersListForPrint(String eventId){
        LIST<User_Answer__c> answersList= new LIST<User_Answer__c>();
        answersList= [SELECT Id,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question__r.Question_Text__c,Item_Question__r.Question_Level__c,  UAnswer_Text_Update__c , Item_Question__r.Question__r.id,Ticket__r.name
                      FROM User_Answer__c 
                      WHERE Item_Question__r.Question__r.Event__c =: eventId
                      AND ticket__r.ticket_status__c='Booked'
                      ORDER BY UAnswer_Text_Update__c ];
        return answersList;
    }
    
    //For item pool question
    public LIST<User_Answer__c> userAnswersListForItemPool(String SelectedItempoolQuestion){
        LIST<User_Answer__c> answersListForItemPool= new LIST<User_Answer__c>();
        answersListForItemPool= [SELECT Id, UAnswer_Text__c,UAnswer_Text_Update__c
                      FROM User_Answer__c 
                      WHERE Item_Question__c =: SelectedItempoolQuestion
                      AND ticket__r.ticket_status__c='Booked'
                      ORDER BY UAnswer_Text_Update__c];
        return answersListForItemPool;
    }
}