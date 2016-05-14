public  without sharing class BLN_SurveyAnswers_DAO {

 //---------------------- This method is Insert/Update Question-------------------------  

   
   
   Public  List<Database.upsertResult> srList{get;set;}
   
   Public List<Database.upsertResult> Upsertanswers(List<BLN_Answer__c> answ)
     {
    
         system.debug('========answerslist' +answ);
         srList = new List<Database.upsertResult>();
         return  srList = Database.upsert(answ, false);
         
     }
     

     //----------------------------Method to delete Answersoptions on edit-------------------------------------------
        
        public LIST<Database.DeleteResult> deleteansoptions(LIST<BLN_Answer__C> delanswoplist ){
        
            Database.DeleteResult[] DR_Dels = Database.Delete(delanswoplist,false);
            return  DR_Dels ;
        
        }

}