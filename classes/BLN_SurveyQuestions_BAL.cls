Public  without sharing class BLN_SurveyQuestions_BAL{

/***********************************************************************************************
    *   Controller Name         : BLN_SurveyQuestions_BAL
    *   Date                    : 30/06/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for executing business Logic on Questions , Answers and Item Questions.
    **************************************************************************************************/


Public Decimal uniqueNo {get;set;}
Public Set<String> failuremessageset {get;set;}
Public  BLN_Answer__c answerrecord {get;set;}
Public  Item_Question__c Itemquerecord {get;set;}

 //-------------- This method is to retrieve QuestionsList for the event------------.
    
    Public LIST<Question__c> questionslist(String selectedeventid , LIST<Question__c> questionslist )
     
     {

        BLN_SurveyQuestions_DAO blnquestionsdao= NEW BLN_SurveyQuestions_DAO();
        return questionslist = blnquestionsdao.questionslist(selectedeventid,questionslist);
     }

   //-------------- This method is to retrieve ItemQuestionsList for the event------------.
    Public LIST<Item_Question__c> itemquestionslist(String selectedeventid , LIST<Item_Question__c> itemquestionslist )
     
     {
        BLN_Item_Question_DAO blnitmquesdao= NEW BLN_Item_Question_DAO();
         return itemquestionslist = blnitmquesdao.itmquestionslist(selectedeventid,itemquestionslist);
     }  
     
                              




     //------------------------------This method is to Delete an answer option From a Question----------------------------------------------
 
     Public MAP<Decimal,BLN_Answer__c> deleteanswerline(String Del , MAP<Decimal,BLN_Answer__c> answerMAP){
     
     
          Decimal deletedId;
          
          if( null != del){
              deletedId = Decimal.valueOf(del);
          }
          
           if(deletedId != null){ 
              
              answerMAP.remove(deletedId);
             
              
              uniqueNo = -1;
              MAP<Decimal,BLN_Answer__c> ansremovelineitemMAP = new MAP<Decimal,BLN_Answer__c> ();
              Decimal count = 0;
            
               if(answerMAP.values().size()>0){
               System.debug('11111111111 3223 ' + answerMAP);
               
                  
               for(BLN_Answer__c pl : answerMAP.values()){
                     uniqueNo++;
                     
                     if(answerMAP.containskey(uniqueNo)){
                      if(count == 1){
                            ansremovelineitemMAP.put(uniqueNo-1,answerMAP.get(uniqueNo));
                      }
                      else{
                          ansremovelineitemMAP.put(uniqueNo ,answerMAP.get(uniqueNo));
                      }
                     }
                     
                     else{
                     
                     ansremovelineitemMAP.put(uniqueNo,answerMAP.get(uniqueNo+1));
                      uniqueNo++;
                      count  = 1;
                     }
                     
               } 
             } 
            
           System.debug('fsfgergerg3223 ' + ansremovelineitemMAP ); 
           answerMAP=  new MAP<Decimal,BLN_Answer__c> ();
           answerMAP= ansremovelineitemMAP.clone();
           
           }
     
     
         return answerMAP;
     
     
     
     }


    // Method For Constructing answeroptions for create and edit--------------------------------------------

    
    Public List<BLN_Answer__c> answeroptions(String selectedtype, String selctdminscale,string selctdmaxscale, Boolean editbool,List<BLN_Answer__C> answerslist, MAP<String,BLN_Answer__C> AnswerDupMAP )
    {
   

             
                      uniqueNo=1; 
                      if(selectedtype == 'Scale'){
                      
                         if(editbool == FALSE){
                          for(Integer i=Integer.valueof(selctdminscale) ; i<=Integer.valueof(selctdmaxscale) ; i++ ){
                              
                                    answerrecord = new BLN_Answer__c();
                                    answerrecord.Answer_Text__c =  String.valueof(i);
                                    answerrecord.Answer_Order__c=uniqueNo;
                                    answerslist.add(answerrecord);
                                    uniqueNo++;
                                    
                          }
                          
                          }  
                          
                         else{
                         
                         for(Integer i=Integer.valueof(selctdminscale) ; i<=Integer.valueof(selctdmaxscale) ; i++ )
                         {
                           if(AnswerDupMAP.ContainsKey(String.valueof(i))){
                                  answerrecord = AnswerDupMAP.get(String.valueof(i));
                                  answerrecord.Answer_Text__c =  String.valueof(i);
                                    answerrecord.Answer_Order__c=uniqueNo;                              
                                    answerslist.add(answerrecord);
                                   
                             
                             }
                            else{
                            
                                    answerrecord = new BLN_Answer__c();
                                    answerrecord.Answer_Text__c =  String.valueof(i);
                                    answerrecord.Answer_Order__c=uniqueNo;
                                    answerslist.add(answerrecord);
                                   
                            } 
                             
                              uniqueNo++;
                          }
                         
                         } 
                          
                    }
                    
                     
                      if(selectedtype == 'Single Selection' || selectedtype  == 'Checkboxes' || selectedtype  == 'Choose from a list')
                      {
                           if(selectedtype ==   'Choose from a list'){
                              answerslist[0].Answer_Default__c = True;
                            }
                            else{
                            
                            answerslist[0].Answer_Default__c = False;
                            }
                          
                      if(editbool == FALSE){   
                            for(BLN_Answer__c ans : answerslist){
                                ans.Answer_Order__c=uniqueNo;
                                uniqueNo++;
                             }
                       }  
                    
                    
                        else{
                          list<BLN_Answer__C > answereditlist = new List<BLN_Answer__c>();
                        for(BLN_Answer__c ans : answerslist){
                        
                          if(AnswerDupMAP.ContainsKey(ans.Answer_Text__c)){
                                  
                                  answerrecord = AnswerDupMAP.get(ans.Answer_Text__c);
                                  answerrecord.Answer_Text__c =  ans.Answer_Text__c;
                                   answerrecord.Answer_Order__c=uniqueNo;                              
                                   answereditlist.add(answerrecord);
                          
                          }
                          else{
                            
                                    answerrecord = new BLN_Answer__c();
                                    answerrecord.Answer_Text__c =  ans.Answer_Text__c;
                                    answerrecord.Answer_Order__c=uniqueNo;
                                    answereditlist.add(answerrecord);
                                   
                            } 
                             
                              uniqueNo++;
                        
                        }    
                    
                    answerslist = new List<BLN_Answer__c>();
                    answerslist.addAll(answereditlist);
                    }  
                  }    
                    
            return answerslist;


    }

   //-------------------------------------Method to Delete answeroptions on editing .
   
   
   
   Public Set<String> deleteansmethod(String selectedtype,List<BLN_Answer__c> answerslist, MAP<String,BLN_Answer__c> AnswerDupMAP ,List<BLN_Answer__c> delansoplist){
     system.debug('=============AnswerDupMAP-===== ' + AnswerDupMAP.values());
      system.debug('=============answerslist-===== ' + answerslist);
              failuremessageset = new SET<STRING>();
            
             // if(selectedtype == 'SCALE'){
              
                  MAP<String,BLN_Answer__c> AnsweropMAP = new MAP<String,BLN_Answer__c>();
               
                   for(BLN_Answer__c ipl :answerslist){
                        AnsweropMAP.PUT(ipl.Answer_Text__c,ipl);
                   }
                    system.debug('=============AnsweropMAP-===== ' + AnsweropMAP.keyset());
    system.debug('=============AnswerDupMAP-===== ' + AnswerDupMAP.values());
                delansoplist = new  List<BLN_Answer__c>();
                   for(String ipl :AnswerDupMAP.keyset()){
                       if(!AnsweropMAP.containskey(ipl))
                       {
                           delansoplist.add(AnswerDupMAP.get(ipl));
                       }
                   }
               
            //   }
            
             system.debug('=============delansoplist-===== ' + delansoplist);
              if(delansoplist.size()>0){
              
                 BLN_SurveyAnswers_DAO blnansoptdao= NEW BLN_SurveyAnswers_DAO();
                  List<Database.DeleteResult> DR_Dels= blnansoptdao.deleteansoptions(delansoplist);
                   
                   for(Database.DeleteResult s: DR_Dels){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
                   }
                    RETURN failuremessageset;   

               } 
   
           RETURN failuremessageset;   
   
    }
   
   
   
   
   
   
   
   
   
   
   // This Method is to construct Itemquestions  from the selected checkbox values.----------------
   
   
     Public List<Item_Question__C> itemquestions(String itemid,String requiredid,String visibleitmid, Boolean editbool, List<Item_Question__C> Itemquelist, MAP<String,Item_Question__C> ItemQuestionDupMAP){
   
        SYSTEM.DEBUG('editbool' + editbool);
        SYSTEM.DEBUG('ItemQuestionDupMAP' + ItemQuestionDupMAP);
       
       
       // Creating Item Question.
           List<String> itemques = new List<String>();
          if(itemques.size()<=0){
             if(itemid!= ''){
              itemques = itemid.split('-');          
              }
            }
            
           List<String> itemSETreqques = new List<String>();
           //if(itemques.size()>0)
           if(requiredid!=''){
              itemSETreqques = requiredid.split('-');
           }
           Set<String> itemreqques= new Set<String>();
          // if(itemreqques.size()>0)
           itemreqques.addAll(itemSETreqques);
           
           List<String> itemvisbleques = new List<String>();
           //if(itemvisbleques.size()>0)
           if(visibleitmid!=''){
             itemvisbleques = visibleitmid.split('-');
           }
           Set<String> itemsetvisques= new Set<String>();
           //if(itemsetvisques.size()>0)
           itemsetvisques.addAll(itemvisbleques);
            
         //   MAP<id,BLN_Item__c> itemMap = new MAP<id,BLN_Item__c>([select id from BLN_Item__c where id in :itemques]);
          Map<ID, BLN_Item__c > itemMap  = new Map<ID, BLN_Item__c >([select id from BLN_Item__c where id in :itemques]);
          
            MAP<id,Item_Pool__c> itempoolMap = new MAP<id,Item_Pool__c>([select id from Item_Pool__c where id in :itemques]);
           
            
            
         Integer itm = 0;
               if(editbool== FALSE){
                   
                   for(String iq: itemques ){
                         Itemquerecord = new Item_Question__c();
                        // If it is Item level 
                        if(null!=itemMap){ 
                         if(itemMap.keySET().contains(iq)){
                         Itemquerecord.Item__c = iq;
                         }
                        } 
                         
                        // If it is Item Pool level   
                       if(null!=itempoolMap){ 
                         if(itempoolMap.keySET().contains(iq)){
                            Itemquerecord.Item_Pool__c= iq;
                         }
                        }
                         
                         
                         
                         Itemquerecord.Question_Level__c ='Ticket Level';
                           if(itemreqques.Contains(iq)){
                             Itemquerecord.isRequired__c = TRUE;
                           }
                           if(itemsetvisques.Contains(iq)){
                           Itemquerecord.Visibility__c = TRUE;
                           }
                          
                           
                        Itemquelist.add(Itemquerecord);
                      }
                                      
                }
              
              // Editing Item Questions -----------------------------------------
              else{
              
              SYSTEM.DEBUG('13213234324 ');
                  for(String iq: itemques){
                  
                    if(ItemQuestionDupMAP.containsKey(iq)){
                  
                       Itemquerecord  = ItemQuestionDupMAP.get(iq);
                       try{
                       Itemquerecord.Item__r.id = iq;
                       }catch(Exception e){}
                       if(itemreqques.Contains(iq)){
                             Itemquerecord.isRequired__c = TRUE;
                        }
                       else{
                           Itemquerecord.isRequired__c = FALSE;
                         }
                      
                        if(itemsetvisques.Contains(iq)){
                           Itemquerecord.Visibility__c = TRUE;
                        } 
                        else{
                           Itemquerecord.Visibility__c = FALSE;
                         }
                        
                           
                         
                        Itemquelist.add(Itemquerecord);
                     }
                     else{
                    
                         Itemquerecord = new Item_Question__c();
                         // If it is Item level 
                        if(null!=itemMap){ 
                         if(itemMap.keySET().contains(iq)){
                         Itemquerecord.Item__c = iq;
                         }
                        } 
                         
                        // If it is Item Pool level   
                       if(null!=itempoolMap){ 
                         if(itempoolMap.keySET().contains(iq)){
                            Itemquerecord.Item_Pool__c= iq;
                         }
                        }
                          
                       
                           if(itemreqques.Contains(iq)){
                             Itemquerecord.isRequired__c = TRUE;
                           }
                           else{
                             Itemquerecord.isRequired__c = FALSE;
                           }
                           
                           if(itemsetvisques.Contains(iq)){
                           Itemquerecord.Visibility__c = TRUE;
                          } 
                          else{
                           Itemquerecord.Visibility__c = FALSE;
                         }
                         
                         Itemquelist.add(Itemquerecord);
                      }
                           
                    }
              
                 }
              SYSTEM.dEBUG('Itemquelist:::: ' + Itemquelist);
              
                  return Itemquelist;     
       
       }
       
       
   //-------------------------------------Method to Delete ItemQuestions on editing .
   
    Public Set<String> deletemethod(List<Item_Question__C> Itemquelist, MAP<String,Item_Question__C> ItemQuestionDupMAP){
    
              failuremessageset = new SET<STRING>();
            MAP<String,Item_Question__C> ItemquestionMAP = new MAP<String,Item_Question__C>();
           
               for(Item_Question__C ipl :Itemquelist){
                  if(ipl.Item__c!=null){
                    ItemquestionMAP.PUT(ipl.Item__c,ipl);
                   
                   }else if(ipl.Item_pool__c!=null){
                      ItemquestionMAP.PUT(ipl.Item_pool__c,ipl);
                   } 

               }
                system.debug('=============ItemquestionMAP -===== ' + ItemquestionMAP );

            List<Item_Question__C>   delitemquelist = new List<Item_Question__C>();
               for(Item_Question__C ipl :ItemQuestionDupMAP.values()){
                 //)
                   if(!ItemquestionMAP.containskey(ipl.Item__c) && (!ItemquestionMAP.containskey(ipl.Item_pool__c)) )
                   {
                       delitemquelist.add(ipl);
                   }
               }
            
              if(delitemquelist.size()>0){
              
                 BLN_Item_Question_DAO blnitemquestdao= NEW BLN_Item_Question_DAO();
                  List<Database.DeleteResult> DR_Dels= blnitemquestdao.deleteitmque(delitemquelist);
                   
                   for(Database.DeleteResult s: DR_Dels){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
                   }
                    RETURN failuremessageset;   

               } 
            
            else{
            
              RETURN failuremessageset;
            
            }
            
            
    
    }
   
   
   
   
   
   
   
   
   //--------------------------- This Method is to save Question along with Answer Options and Item Question------------------------------------ 
    
    
    Public Set<String> upsertquestiosave(List<Question__c> questionslist,List<BLN_Answer__c> answerslist ,List<Item_Question__c> Itemquelist ){
    
    // questionslist[0].Answer_Type__c = selectedtype;  

   
     BLN_SurveyQuestions_DAO blnsurveydao= NEW BLN_SurveyQuestions_DAO();
            List<Database.upsertResult> saveres = blnsurveydao.UpsertQuestion(questionslist);
            system.debug('========STATUS MESSAGE= ===============' +saveres );
              failuremessageset = new SET<STRING>();
               for(Database.UpsertResult s : saveres ){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);                  
                    }
          
                 }
              system.debug('  STATUS OF QUESTIONS   ' +failuremessageset);    
             if(failuremessageset.size()==0)
                 {
                       
               
                   if(answerslist.size()>0){   
                   
                       List<BLN_Answer__c> dupansoplist = new  List<BLN_Answer__c>();
                         
                         for(BLN_Answer__c answerrecord : answerslist){
                            
                             try{
                             answerrecord.BLN_Question__c = saveres[0].id;
                             }catch(Exception e){}
                             dupansoplist.add(answerrecord);
                         }
                   
                   
                         if(dupansoplist.size()>0){   
                   
                              BLN_SurveyAnswers_DAO blnsurveyansdao= NEW BLN_SurveyAnswers_DAO();
                              List<Database.upsertResult> saveans = blnsurveyansdao.Upsertanswers(dupansoplist);
                                 system.debug('========STATUS MESSAGE= ===============' +saveans );
                                   failuremessageset = new SET<STRING>();
                                       for(Database.UpsertResult s : saveans ){
                                            if(!s.isSuccess()){
                                              Database.Error error = s.getErrors().get(0);
                                              String failedDML =Error.getMessage();             
                                              failuremessageset.add(failedDML);
                                  
                                             }
                          
                                         }
                          }
                   
                         }  
                          if(failuremessageset.size()==0)
                         
                         {
                 
                        system.debug('ItemquelistItemquelistItemquelist' + Itemquelist);          
                                    List<Item_Question__C> dupItemquelist = new List<Item_Question__C>();
                                     for(Item_Question__C Itemquerecord : Itemquelist){
                                        
                                         try{
                                         Itemquerecord.Question__c = saveres[0].id;
                                         }catch(Exception e){}
                                         dupItemquelist.add(Itemquerecord);
                                     }
                               if(dupItemquelist.size()>0){         
                                 system.debug('dupItemquelistdupItemquelistdupItemquelist' + dupItemquelist);            
                                    BLN_Item_Question_DAO blnitmquedao= NEW BLN_Item_Question_DAO();
                                    List<Database.upsertResult> saveitemque = blnitmquedao.UpsertItemQuestion(dupItemquelist);
                                     system.debug('  ITEM QUESTION STATUS  ' +saveitemque );
                                       failuremessageset = new SET<STRING>();
                                       for(Database.UpsertResult s : saveitemque){
                                            if(!s.isSuccess()){
                                              Database.Error error = s.getErrors().get(0);
                                              String failedDML =Error.getMessage();             
                                              failuremessageset.add(failedDML);
                                  
                                             }
                          
                                         }
                                    
                               }       
                            
                           Return  failuremessageset;
                            
                 
                         }
                         
                         else{
               
                               RETURN failuremessageset;
                           }
                         
                         
                         
                 
                 }       
    
               else{
               
                   RETURN failuremessageset;
               }
    
        
    
    
    }
    
    
    
    
   //------------------ This Method is to delete Question record along with item_questions, answers options..---------------------------- 
    
    
    Public Set<String> deletemethod(List<Question__c> questionslist){
    
      failuremessageset = new SET<STRING>();
      
       if(questionslist.size()>0){
                 BLN_SurveyQuestions_DAO blnsurvyquedao= NEW BLN_SurveyQuestions_DAO();
                  List<Database.DeleteResult> DR_Dels= blnsurvyquedao.deleteque(questionslist);
                   for(Database.DeleteResult s: DR_Dels){
                    if(!s.isSuccess()){
                        Database.Error error = s.getErrors().get(0);
                        String failedDML =Error.getMessage();             
                        failuremessageset.add(failedDML);
                  
                    }
                   } 
        }
               RETURN failuremessageset; 
      
    
    } 
    
// Edit by Mahesh Sakunala Start
// ---------------------------------------------------------Method to Retrieve Item Questions List based on EventId & Items Start ---------------------------------------------------------------------    
    public MAP<Id,LIST<Question__c>> getItemQuestions(SET<Id> ItemIds, String EventId){
        
        // Get Questions List from Survey Questions DAO
        BLN_SurveyQuestions_DAO SQ_DAO = new BLN_SurveyQuestions_DAO(); 
        MAP<Id,LIST<Question__c>> QMapList = SQ_DAO.getItemQuestions(ItemIds,EventId);
        return QMapList;
    }
// ---------------------------------------------------------Method to Retrieve Item Questions List based on EventId & Items End ---------------------------------------------------------------------        


//------------------------------------------------------------- Method to insert User Answer Start ------------------------------------------------------------------------------------------------
     //inserting other than text and para
     public BLN_StatusMessage insertUserAnswer(String AnswerId, Id ItemQuestionId,id tid){

         BLN_UserAnswers_DAO UAnswerDAO = new BLN_UserAnswers_DAO();
         BLN_StatusMessage UAnswerMsg = UAnswerDAO.insertUserAnswer(AnswerId,ItemQuestionId,tid);
         return UAnswerMsg;
     }

     //inserting text and para
     public BLN_StatusMessage insertUserAnswerTxtPara(String AnswerId, Id ItemQuestionId,id tid){

         BLN_UserAnswers_DAO UAnswerDAO = new BLN_UserAnswers_DAO();
         BLN_StatusMessage UAnswerMsg = UAnswerDAO.insertUserAnswerTxtPara(AnswerId,ItemQuestionId,tid);
         return UAnswerMsg;
     }
//------------------------------------------------------------- Method to insert User Answer End -------------------------------------------------------------------------------------------------

//------------------------------------------------------------- Method to upsert survey User Answer Start ------------------------------------------------------------------------------------------------     
     //upserting other than txt,para and checkboxes
     public BLN_StatusMessage upsertSurveyUserAnswer(String AnswerId, Id ItemQuestionId,id tid,id usransID,string oldValue ){         
         BLN_UserAnswers_DAO UAnswerDAO = new BLN_UserAnswers_DAO();
         BLN_StatusMessage UAnswerMsg =new BLN_StatusMessage(); 
         UAnswerMsg = UAnswerDAO.upsertSurveyUserAnswer(AnswerId,ItemQuestionId,tid,usransID,oldValue);
         return UAnswerMsg; 
     }
     
     //upserting  txt,para 
     public BLN_StatusMessage upsertSurveyUserAnswerTxtPara(String AnswerId, Id ItemQuestionId,id tid,id usransID,string oldValue ){         
         BLN_UserAnswers_DAO UAnswerDAO = new BLN_UserAnswers_DAO();
         BLN_StatusMessage UAnswerMsg =new BLN_StatusMessage(); 
         UAnswerMsg = UAnswerDAO.upsertSurveyUserAnswerTxtPara(AnswerId,ItemQuestionId,tid,usransID,oldValue);
         return UAnswerMsg; 
     }
     
     //upserting checkboxes
     public BLN_StatusMessage upsertCheckboxSurveyUserAnswer(String[] AnswerId, Id ItemQuestionId,id tid,set<id> chbxId, string oldValue ){
        
         BLN_UserAnswers_DAO UAnswerDAO = new BLN_UserAnswers_DAO();
         BLN_StatusMessage UAnswerMsg =new BLN_StatusMessage(); 
         UAnswerMsg = UAnswerDAO.upsertCheckboxSurveyUserAnswer(AnswerId,ItemQuestionId,tid,chbxId,oldValue);
         return UAnswerMsg; 
     }
//------------------------------------------------------------- Method to upsert survey User Answer End -------------------------------------------------------------------------------------------------   


//--------------------------------------------------------------- Method to fetch Item Question Start -------------------------------------------------------------------------------------------          
    public Id getItemQuestion(String ItemId, String QuestionId){
        BLN_SurveyQuestions_DAO SQuestionDAO = new BLN_SurveyQuestions_DAO();
        Id ItemQuestionId = SQuestionDAO.getItemQuestion(ItemId,QuestionId);
        return ItemQuestionId;
    }
//--------------------------------------------------------------- Method to fetch Item Question End ---------------------------------------------------------------------------------------------- 

//--------------------------------------------------------------- Method to fetch Event Level Questions Start -------------------------------------------------------------------------------------------          
    public LIST<Question__c> getEventQuestions(String EventId){
        BLN_SurveyQuestions_DAO SQuestionDAO = new BLN_SurveyQuestions_DAO();
        LIST<Question__c> QuestionList = SQuestionDAO.getEventQuestions(EventId);
        return QuestionList;
    }
//--------------------------------------------------------------- Method to fetch  Event Level Questions End ---------------------------------------------------------------------------------------------- 


//--------------------------------------------------------------- Method to fetch Item Question Start -------------------------------------------------------------------------------------------          
    public Id geteventQuestion(String eventid, String QuestionId){
        BLN_SurveyQuestions_DAO SQuestionDAO = new BLN_SurveyQuestions_DAO();
        Id ItemQuestionId = SQuestionDAO.geteventQuestion(eventid,QuestionId);
        return ItemQuestionId;
    }
//--------------------------------------------------------------- Method to fetch Item Question End ---------------------------------------------------------------------------------------------- 



// Edit by Mahesh Sakunala End    

}