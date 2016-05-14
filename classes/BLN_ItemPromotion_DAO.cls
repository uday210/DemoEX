Public without sharing class BLN_ItemPromotion_DAO{


  /***********************************************************************************************
    *   Controller Name         : BLN_ItemPromotion_DAO
    *   Date                    : 19/05/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for Insert/Update/Delete and Retrieve Item Promotions.
    **************************************************************************************************/
  
    
  
  Public   List<Database.upsertResult> srList{get;set;} 
    
    //---------------------- This method is Insert/Update Item_Promotion-------------------------
    
       Public List<Database.upsertResult>  upsertitemPromotion(List<Item_Promotion__c> itmpromo){
        
             system.debug('========promotionslist ' +itmpromo);
             srList = new List<Database.upsertResult> ();
             return  srList = Database.upsert(itmpromo, false);
             
        }
        
     // ---------------------------------------- Method to retrieve list of Item Promotions ----------------- Start ----------------------------------------------
       
       public LIST<Item_Promotion__c> getItemPromotions(String PromotionId){
        return [SELECT Id,Name,Buy_Item__c,Buy_Item_Quantity__c,Free_Item__c,Free_Item_Quantity__c,Item_Discount_Type__c,Item_Discount_Value__c,Promotion__c,Promotion__r.Status__c,Promotion__r.Type__c,Promotion__r.Promotion_Type__c,Promotion__r.Exp_TimeStamp__c FROM Item_Promotion__c WHERE Promotion__c=:PromotionId];
       }
       
    // ---------------------------------------- Method to retrieve list of Item Promotions ------------------ End -----------------------------------------------



     //----------------------------Method to delete Itempromotions-------------------------------------------
        
        public LIST<Database.DeleteResult> deleteitmprom(LIST<Item_Promotion__c> delitempromolist ){
        
            Database.DeleteResult[] DR_Dels = Database.Delete(delitempromolist,false);
            return  DR_Dels ;
        
        }
        
        
        






}