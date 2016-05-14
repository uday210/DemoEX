public  without sharing class BLN_Item_Question_DAO{

    //Query for surver side pagination on survey report(Survey By Question)
    public list<item_question__c> querySuveyByQuestions(string str){         
         String st='select id,question__r.event__c,event__c,item__r.item_type__r.name,question__r.Question_Text__c,name,item__c,item_pool__c,question__c,item__r.id,item_pool__r.id,item__r.item_name__c,item_pool__r.item_pool_name__c,question__r.id,question_level__c,question__r.answer_type__c,question__r.question_order__c,(select id,name,ticket__r.parent_id__c,uanswer_text__c,ticket__c,ticket__r.id,ticket__r.tkt_profile__c,ticket__r.tkt_profile__r.id,ticket__r.tkt_profile__r.first_name__c,ticket__r.tkt_profile__r.last_name__c,item_question__r.item__r.item_name__c,Ticket__r.Name,item_question__r.item_pool__r.item_pool_Name__c,item_question__r.question_level__c,item_question__r.question__r.answer_type__c,ticket__r.item__r.item_name__c,ticket__r.item_pool__r.item_pool_name__c,item_question__r.question__r.id  from user_answers__r) from item_question__c '+str;
         /*
         set<id> bookedid=new set<id>();
         for(item_question__c iq : database.query(st)){
             for(user_answer__c u : iq.user_answers__r){
                 bookedid.add(iq.id);
             }
         }
         
         List<item_question__c> itemquestionlist2=[select id,question__r.event__c,item__r.item_type__r.name,question__r.Question_Text__c,name,item__c,item_pool__c,question__c,item__r.id,item_pool__r.id,item__r.item_name__c,item_pool__r.item_pool_name__c,question__r.id,question_level__c,question__r.answer_type__c,question__r.question_order__c,(select id,name,ticket__r.parent_id__c,uanswer_text__c,ticket__c,ticket__r.id,ticket__r.tkt_profile__c,ticket__r.tkt_profile__r.id,ticket__r.tkt_profile__r.first_name__c,ticket__r.tkt_profile__r.last_name__c,item_question__r.item__r.item_name__c,Ticket__r.Name,item_question__r.item_pool__r.item_pool_Name__c,item_question__r.question_level__c,item_question__r.question__r.answer_type__c,ticket__r.item__r.item_name__c,ticket__r.item_pool__r.item_pool_name__c,item_question__r.question__r.id  from user_answers__r) from item_question__c where id in : bookedid order by question__r.Question_Order__c ASC];
         system.debug('SQDSQWSQS:::'+itemquestionlist2.size());*/
         list<item_question__c> iqlist= database.query(st);
         return iqlist; 
      }

 
 //method to get list of item questions per event
 public LIST<Item_Question__c> eventItemQueAns(String selectedeventid, String itemQuestionId){
     return [Select Id, Question_Level__c, item__c, item__r.item_name__c,IQ_Order__c,Question__c, Question__r.Event__c, Question__r.Id, Question__r.Name, Question__r.Answer_Type__c, Question__r.Question_Order__c, Question__r.Question_Text__c, (SELECT ID,Item_Question__r.Question__r.Answer_Type__c,NAME,Item_Question__c,BLN_Answer__c,UAnswer_Text__c FROM User_Answers__r) FROM Item_Question__c WHERE Question__r.Event__c =: selectedeventid AND id =: itemQuestionId];
 }
 
 
   //-------------- This method is to retrieve ItemQuestionsList for the event------------.
    
    Public LIST<Item_Question__c> itmquestionslist(String selectedeventid ,LIST<Item_Question__c> itmquestionslist )
     
     {
         //LIST<Item_Question__c> itmquestionslistTemp=new LIST<Item_Question__c> ();
        return itmquestionslist = [Select Id, Question_Level__c, item__c, item__r.item_name__c,IQ_Order__c,Question__c, Question__r.Event__c, Question__r.Id, Question__r.Name, Question__r.Answer_Type__c, Question__r.Question_Order__c, Question__r.Question_Text__c, (SELECT ID,NAME,Item_Question__c,BLN_Answer__c,UAnswer_Text__c FROM User_Answers__r ) FROM Item_Question__c WHERE Question__r.Event__c =: selectedeventid];
     }
     
     // Item Questions Belongs to an Item
    Public LIST<Item_Question__c> questionsForAnItem(String itemId){//,String itemPoolId
        return [Select Id,item__r.item_type__r.name, Question_Level__c, item__c, item__r.item_name__c,IQ_Order__c,Question__c, Question__r.Event__c, Question__r.Id, Question__r.Name, Question__r.Answer_Type__c, Question__r.Question_Order__c, Question__r.Question_Text__c, (SELECT ID,NAME,Item_Question__c,BLN_Answer__c,UAnswer_Text_Update__c,UAnswer_Text__c,Item_Question__r.Question__r.Name FROM User_Answers__r where ticket__r.ticket_status__c='Booked' limit 100) FROM Item_Question__c WHERE (item__c =: itemId) order by question__r.question_order__c ASC];// OR item__c =: itemPoolId
    }
    
    //Item Questions belonging to item pool
     // Item Questions Belongs to an Item or itempool
    Public LIST<Item_Question__c> questionsForAnItemPool(String itemPoolId){//,
        return [Select Id,item_Pool__r.item_pool_name__c,item__r.item_type__r.name,  Question_Level__c, item__c, item__r.item_name__c,IQ_Order__c,Question__c, Question__r.Event__c, Question__r.Id, Question__r.Name, Question__r.Answer_Type__c, Question__r.Question_Order__c, Question__r.Question_Text__c, (SELECT ID,NAME,Item_Question__r.Question__r.Name,Item_Question__c,BLN_Answer__c,UAnswer_Text__c FROM User_Answers__r ) FROM Item_Question__c WHERE (item_pool__c =: itemPoolId)  order by question__r.question_order__c ASC];// OR item__c =: itemPoolId
    }
    
     // Item Questions Belongs to an Event with Ticket Level
    Public LIST<Item_Question__c> questionsForTicketLevelEvent(String eventId){
        system.debug('  EVENT ID IN DAO '+eventId);
        return [Select Id, Question_Level__c, item__c, item__r.item_name__c,IQ_Order__c,Question__c, Question__r.Event__c, Question__r.Id, Question__r.Name, Question__r.Answer_Type__c, Question__r.Question_Order__c, Question__r.Question_Text__c, (SELECT ID,NAME,Item_Question__c,BLN_Answer__c,UAnswer_Text__c FROM User_Answers__r ) FROM Item_Question__c WHERE Question_Level__c =: 'Ticket Level'];
    }
    
      // Item Questions Belongs to an Event with Event Level
    Public LIST<Item_Question__c> questionsForEvent(String eventId){
        system.debug('  EVENT ID IN DAO '+eventId);
        return [Select Id, Question_Level__c, item__c, item__r.item_type__r.name,item__r.item_name__c,IQ_Order__c,Question__c, Question__r.Event__c, Question__r.Id, Question__r.Name, Question__r.Answer_Type__c, Question__r.Question_Order__c, Question__r.Question_Text__c, (SELECT ID,NAME,Item_Question__c,BLN_Answer__c,UAnswer_Text__c,Item_Question__r.Question__r.Name FROM User_Answers__r where ticket__r.ticket_status__c='Booked' ) FROM Item_Question__c WHERE Event__c =: eventId AND Question_Level__c =: 'Event Level' Order By Question_Level__c,question__r.question_order__c ASC];// AND Item__c =: NULL
    }

 
 //---------------------- This method is Insert/Update Question-------------------------  

 Public  List<Database.upsertResult> srList{get;set;}
   
    Public List<Database.upsertResult> UpsertItemQuestion(List<Item_Question__c> itmque)
     {
    
         system.debug('========ItemQuestionlist' +itmque);
         srList = new List<Database.upsertResult>();
         return  srList = Database.upsert(itmque, false);
         
     }
     
    


     //----------------------------Method to delete ItemQuestions-------------------------------------------
        
        public LIST<Database.DeleteResult> deleteitmque(LIST<Item_Question__c> delitemquelist ){
        
            Database.DeleteResult[] DR_Dels = Database.Delete(delitemquelist,false);
            return  DR_Dels ;
        
        }
        
        
      //for lead qualifiers
      public LIST<Item_Question__c> questionsforLeads(string eventid){
      
          LIST<Item_Question__c> questions=[SELECT IQ_Order__c,Question__r.Question_Text__c,Question__r.ownerID,Question__r.owner.Email,(select UAnswer_Text__c,ticket__r.TKT_profile__c from User_Answers__r) from Item_Question__c where Question_Level__c='Lead Retrieval' AND Event__c = :eventid order by IQ_Order__c ASC];
          if(questions.size() > 0){
              return questions;
          }else{
             return new LIST<Item_Question__c>();
          }
      }      

      //method to get answered item questions
      public list<item_question__c> itemQuestionswithuseranswers(string eventid){
          list<user_answer__c> ualist=[select id,name,ticket__r.id,item_question__r.id from user_answer__c where ticket__r.Event__c= :eventid and ticket__r.ticket_status__c= 'Booked' and ticket__r.order__r.order_status__c!='Abandoned' and ticket__r.order__r.order_status__c!='Cancelled' and Item_Question__r.question_level__c != 'Lead Retrieval'];
         
         set<id> bookedid=new set<id>();
    
             for(user_answer__c u : ualist){
                 bookedid.add(u.item_question__r.id);
         }
         
         List<item_question__c> itemquestionlist1=[select id,item__r.item_type__r.name,question__r.Question_Text__c,name,item__c,item_pool__c,question__c,item__r.id,item_pool__r.id,item__r.item_name__c,item_pool__r.item_pool_name__c,question__r.id,question_level__c,question__r.answer_type__c,question__r.question_order__c,question__r.event__c from item_question__c where question__r.event__c= : eventid and id in : bookedid order by question__r.Question_Order__c ASC];
         //(select id,name,ticket__r.parent_id__c,uanswer_text__c,ticket__c,ticket__r.id,ticket__r.tkt_profile__c,ticket__r.tkt_profile__r.id,ticket__r.tkt_profile__r.first_name__c,ticket__r.tkt_profile__r.last_name__c,item_question__r.item__r.item_name__c,Ticket__r.Name,item_question__r.item_pool__r.item_pool_Name__c,item_question__r.question_level__c,item_question__r.question__r.answer_type__c,ticket__r.item__r.item_name__c,ticket__r.item_pool__r.item_pool_name__c,item_question__r.question__r.id  from user_answers__r)
         system.debug('SQDSQWSQS:::'+itemquestionlist1.size());
         return itemquestionlist1; 
      }
      
      //method to get list of item questions on particular event and wrt to item or item pool
      public LIST<item_question__c> itemQuestionsForTickets(SET<Id> itemIds, String EventId){
        LIST<item_question__c> itemQuestionsList= new LIST<item_question__c>();
        itemQuestionsList= [SELECT Id,Item__r.item_name__c,item_pool__r.item_pool_name__c,question__r.answer_type__c,Question_Level__c, Item__c,  Question__r.Question_Text__c, 
                          Item_Pool__c,question__r.id,
                          (select id,name,uanswer_text__c,ticket__c,ticket__r.id,item_question__r.question__r.name,item_question__r.question__r.id,item_question__r.question__r.answer_type__c from user_answers__r where item_question__r.question_level__c='Ticket Level')
                          FROM item_question__c
                          WHERE
                          (Item__c IN: itemIds OR Item_Pool__c IN: itemIds)  
                          AND (Item__r.Event__c =: EventId OR Item_Pool__r.Event__c =: EventId)
                          ORDER BY question__r.question_order__c ASC];
        return itemQuestionsList;
    }
    
    
}