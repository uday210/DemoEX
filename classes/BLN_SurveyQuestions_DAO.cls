public  without sharing class BLN_SurveyQuestions_DAO {

  
   //-------------- This method is to retrieve QuestionsList for the event------------.
    
    public LIST<Question__c> questionslist(String selectedeventid ,LIST<Question__c> questionslist ){  
        //LIST<Question__c> questionslistTemp=new LIST<Question__c>();
        set<ID> queId=new set<Id>();
        for(Item_Question__c iq : [select id,name,question__c from Item_question__c where question__r.event__c = : selectedeventid and question_level__c!='Lead Retrieval']){
            queId.add(iq.question__c);
        }
        
        return questionslist= [SELECT ID,NAME,Event__c,Max_Answer_count__c,Answer_Type__c,BLN_Parent_Answer__c,Question_Text__c ,Question_Order__c, (SELECT ID,NAME,Answer_Text__c,Answer_Order__c,Answer_Default__c FROM BLN_Answers__r ORDER BY Answer_Order__c ),(SELECT ID,Item__r.item_name__c,Item__r.item_type__r.name,Item__r.Item_Pool__r.Item_Pool_Name__c,Item__r.Id,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Item_Pool__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Addon_Parent__r.Item_Pool_Name__c From Item_Question__r ORDER BY Item__r.item_name__c) FROM Question__c WHERE Event__c =:selectedeventid and id in : queId  ORDER BY  Question_Order__c ASC];//and id in : queId
    }
 
    //---------------------- This method is Insert/Update Question-------------------------  
  
    Public  List<Database.upsertResult> srList{get;set;}
   
    public List<Database.upsertResult> UpsertQuestion(List<Question__c> ques){
         system.debug('========questionslist ' +ques);
         srList = new List<Database.upsertResult>();
         return  srList = Database.upsert(ques, false);
         
     }
     
 //---------------------- This method is Delete Question-------------------------  

    public LIST<Database.DeleteResult> deleteque(LIST<Question__c> delquelist ){
        system.debug('=========delquelist ================ ' + delquelist );
        Database.DeleteResult[] DR_Dels = Database.Delete(delquelist,false);
        return  DR_Dels;
    }
   
   
// Edit by Mahesh Sakunala Start
//------------------------------------------- Method to retrieve QuestionsLists for the event based on Item Id Start ---------------------------------------------------------------

     public MAP<Id,LIST<Question__c>> getItemQuestions(SET<Id> ItemIds, String selectedeventid){ 
        
        MAP<Id,Question__c> QMap = new  MAP<Id,Question__c>();
        LIST<Question__c> Qlist = new LIST<Question__c>();
        
        Qlist = [SELECT BLN_Parent_Answer__c,ID,NAME,Event__c,Answer_Type__c,Question_Text__c ,Question_Order__c,(SELECT ID,NAME,Answer_Text__c,Answer_Order__c,Answer_Default__c FROM BLN_Answers__r ORDER BY Answer_Order__c ),
                 (SELECT ID,Item__r.item_name__c,Item__r.Id,isRequired__c,Visibility__c,IQ_Order__c,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c,Event__c,Question_Level__c,Item_Pool__c,Item_Pool__r.id From Item_Question__r WHERE Visibility__c=: TRUE AND Question_Level__c ='Ticket Level' ORDER BY Item__r.item_name__c) 
                 FROM Question__c 
                 WHERE Event__c =: selectedeventid 
                 ORDER BY Question_Order__c ASC];
                 
        for(Question__c q: Qlist){
            QMap.put(q.id,q);
        }

        MAP<Id,LIST<Question__c>> QuestionsMap = new  MAP<Id,LIST<Question__c>>();
        
        for(Id ItemId: ItemIds){
            LIST<Question__c> QuestionList = new LIST<Question__c>();
            for(Item_Question__c Iq: [SELECT Item_Pool__r.id,Item_Pool__c,ID,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__c,Question__r.Event__c,Question__r.BLN_Parent_Answer__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                                      FROM Item_Question__c 
                                      WHERE Visibility__c=: TRUE 
                                      AND (Item__r.id =: ItemId OR Item_Pool__r.id = :ItemId)
                                      ORDER BY Item__r.id,Question__r.Question_Order__c ASC]){
                
                QuestionList.add(QMap.get(iq.Question__c));                       
            }
            QuestionsMap.put(ItemId,QuestionList);
        } 
        return QuestionsMap;
     }

// Edited By Phani 
public MAP<Id,LIST<Item_Question__c>> getItemQ(SET<Id> ItemIds, id selectedeventid){ 
        MAP<Id,LIST<Item_Question__c>> QuestionItemListMAp = new  MAP<Id,LIST<Item_Question__c>>();
         for(Id ItemId: ItemIds){
            LIst<Item_Question__c> Iq = New List<Item_Question__c>();
              Iq = [SELECT Question__r.BLN_Parent_Answer__c,Item_Pool__r.id,Item_Pool__c,ID,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                                      FROM Item_Question__c 
                                      WHERE Visibility__c=: TRUE 
                                      AND (Item__r.id =: ItemId OR Item_Pool__r.id = :ItemId)
                                      ORDER BY Item__r.id,Question__r.Question_Order__c ASC];
            QuestionItemListMAp.put(ItemId,Iq);
        } 
        return QuestionItemListMAp;
     }

public Static MAP<Id,Question__c> mapQidWitQue = new MAP<Id,Question__c>();

public Static Void getQueIdWithQue(String selectedeventid){
     // QMap = new  MAP<Id,Question__c>();
        LIST<Question__c> Qlist = new LIST<Question__c>();
        Qlist = [SELECT BLN_Parent_Answer__c,Max_Answer_count__c,ID,NAME,Event__c,Answer_Type__c,Question_Text__c ,Question_Order__c,(SELECT ID,NAME,Answer_Text__c,Answer_Order__c,Answer_Default__c FROM BLN_Answers__r ORDER BY Answer_Order__c ),
                 (SELECT ID,Item__r.item_name__c,Item__r.Id,isRequired__c,Visibility__c,IQ_Order__c,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c,Event__c,Question_Level__c,Item_Pool__c,Item_Pool__r.id From Item_Question__r WHERE Visibility__c=: TRUE AND Question_Level__c ='Ticket Level' ORDER BY Item__r.item_name__c) 
                 FROM Question__c 
                 WHERE Event__c =: selectedeventid 
                 ORDER BY Question_Order__c ASC];
                 
        for(Question__c q: Qlist){
            mapQidWitQue.put(q.id,q);
        }
    // return  mapQidWitQue;  
}






//------------------------------------------- Method to retrieve QuestionsLists for the event based on Item Id End ---------------------------------------------------------------

//------------------------------------------------------------- Method to fetch Item Question Start --------------------------------------------------------------------------------          
public Id getItemQuestion(String ItemId, String QuestionId){
    Item_Question__c IQuestion = new Item_Question__c();
    system.debug('Item Questions '+ItemId +' Questions '+QuestionId);
    IQuestion = [SELECT Question__r.BLN_Parent_Answer__c,ID,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__r.id,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                 FROM Item_Question__c  
                 WHERE (Item__r.id =: ItemId OR Item_pool__r.id = :ItemId )
                 AND Question__r.id =: QuestionId];
    if(IQuestion != NULL){
        return IQuestion.Id;
    }else{
        return null;
    }
}
    
public Id getItemQuestion(String ItemId, String QuestionId,String pid){
    
 System.debug('QQQQQQQQQQQ  '+pid);
   try{ 
    Item_Question__c IQuestion = new Item_Question__c();
    system.debug('Item Questions '+ItemId +' Questions '+QuestionId);
   try{ 
    IQuestion = [SELECT Question__r.BLN_Parent_Answer__c,ID,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__r.id,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                 FROM Item_Question__c  
                 WHERE (Item__r.id =: ItemId OR Item_pool__r.id = :ItemId )
                 AND Question__r.id =: QuestionId];

   }catch(exception rt){
      SET<id> chIds = new SET<id>();
      for(Ticket__c ty : [select id,Item_Pool__c from Ticket__c where Parent_ID__c=:ItemId]){
        chIds.add(ty.Item_Pool__c);
      }

       try{
         IQuestion = [SELECT Question__r.BLN_Parent_Answer__c,ID,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__r.id,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                 FROM Item_Question__c  
                 WHERE (Item_pool__r.id IN :chIds  OR Item__r.id = :pid)
                 AND Question__r.id =: QuestionId limit 1];
       }catch(exception er){}
 
   }
System.debug('QQQQQQQQQQQ  '+IQuestion);
    if(IQuestion != NULL){
        return IQuestion.Id;
    }else{
        return null;
    }
  }catch(exception er){
    return null;    
  }  
}
//------------------------------------------------------------- Method to fetch Item Question End --------------------------------------------------------------------------------          


public Id geteventQuestion(String eveid, String QuestionId){
    Item_Question__c IQuestion = new Item_Question__c();
    IQuestion = [SELECT ID,Question__r.BLN_Parent_Answer__c,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__r.id,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                 FROM Item_Question__c  
                 WHERE Event__c =: eveid
                 AND Question__r.id =: QuestionId AND Item__c =null];
    if(IQuestion != NULL){
        return IQuestion.Id;
    }else{
        return null;
    }
}





//------------------------------------------------------------- Method to fetch Event Question Start --------------------------------------------------------------------------------          
public Id getEventQuestion(String QuestionId){
    Item_Question__c IQuestion = new Item_Question__c();
    IQuestion = [SELECT ID,Question__r.BLN_Parent_Answer__c,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__r.id,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                 FROM Item_Question__c  
                 WHERE Question__r.id =: QuestionId LIMIT 1];
    if(IQuestion != NULL){
        return IQuestion.Id;
    }else{
        return null;
    }
}
//------------------------------------------------------------- Method to fetch Event Question End -------------------------------------------------------------------------------- 

//------------------------------------------------------------- Method to Event Level Questions Start --------------------------------------------------------------------------------          
public LIST<Question__c> getEventQuestions(String EventId){
    LIST<Question__c> Questionlist = new LIST<Question__c>();
    LIST<Item_Question__c> ItemQuestionlist = new LIST<Item_Question__c>();
    LIST<Id> QIds = new  LIST<Id>();    
    ItemQuestionlist =[SELECT ID,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__r.BLN_Parent_Answer__c,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                                              FROM Item_Question__c 
                                              WHERE Visibility__c=: TRUE 
                                              AND Event__r.id =: EventId
                                              AND Question_Level__c = 'Event Level' 
                                              ORDER BY Item__r.id,Question__r.Question_Order__c ASC];  
    for(Item_Question__c iq: ItemQuestionlist){
        QIds.add(iq.Question__r.Id);
    }    
        
    Questionlist = [SELECT ID,NAME,Event__c,BLN_Parent_Answer__c,Answer_Type__c,Question_Text__c ,Question_Order__c,(SELECT ID,NAME,Answer_Text__c,Answer_Order__c,Answer_Default__c FROM BLN_Answers__r ORDER BY Answer_Order__c ),
                   (SELECT ID,Item__r.item_name__c,Item__r.Id,isRequired__c,Visibility__c,IQ_Order__c,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c,Event__c,Question_Level__c From Item_Question__r WHERE Visibility__c=: TRUE ORDER BY Item__r.item_name__c) 
                    FROM Question__c 
                    WHERE Id IN: QIds
                    ORDER BY Question_Order__c ASC];
                    
                    
    system.debug('DAO Event Level Questions'+Questionlist);
    return Questionlist;
}

// Written By Phani 
public LIST<Item_Question__c> getEveQuestions(String EventId){
   
    LIST<Item_Question__c> ItemQuestionlist = new LIST<Item_Question__c>();
    
    ItemQuestionlist =[SELECT Question__r.BLN_Parent_Answer__c,ID,Item__r.id,Item__r.item_name__c,isRequired__c,Visibility__c,IQ_Order__c,Event__c,Question_Level__c,Question__c,Question__r.Event__c,Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Question_Order__c
                                              FROM Item_Question__c 
                                              WHERE Visibility__c=: TRUE 
                                              AND Event__r.id =: EventId
                                              AND Question_Level__c = 'Event Level'
                                              ORDER BY Item__r.id,Question__r.Question_Order__c ASC];  
     return ItemQuestionlist;
}

//------------------------------------------------------------- Method to Event Level Questions End --------------------------------------------------------------------------------   
   
// Edit by Mahesh Sakunala End

}