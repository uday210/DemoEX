public without sharing class BLN_Promotion_DAO{

    /***********************************************************************************************
    *   Controller Name         : BLN_Promotion_DAO
    *   Date                    : 19/05/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for Insert/Update/Delete and Retrieve  Promotions.
    **************************************************************************************************/
   
   
   //-------------- This method is to retrieve promotionslist for the event------------.
    
    
     Public LIST<Promotion__c> promotionslist(String Condition)
     {
       SYSTEM.DEBUG('----------------EVENTID-------------------' + Condition);
       LIST<Promotion__c> promotionlist  = new LIST<Promotion__c>();
       RETURN promotionlist = database.query('SELECT ID,Name,Promo_Code__c,Promotion_Type__c,Exp_TimeStamp__c,Eff_TimeStamp__c,Discount_Value__c,Discount_Type__c,Event__c,Exclusive__c,I_Max_Count__c,T_Max_Count__c,T_Used_Count__c,Status__c,Type__C,Condition_Min_No__c ,Condition_Max_No__c,Daily_Start_Time__c,Daily_End_Time__c,(select id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Promotion__r.Event__c  from Item_Promotions__r), (SELECT ID, Item_Discount__c, Item_Price__c, Item_Quantity__c, Item_Total__c, Order__c,Order__r.Name,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.Order_Discount__c,Promotion__r.Discount_Type__c,Item__r.item_type__r.Name,Item__r.item_name__c ,Promotion__r.Name,Status__c,Order__r.Order_Status__c FROM Order_Items__r where Order__r.Order_Status__c!=\'Abandoned\' AND Order__r.Order_Status__c!=\'Cancelled\') FROM  Promotion__c WHERE '+condition);
     
     
     }
   
  
   
    //---------------------- This method is Insert/Update Promotion -------------------------  

   
   
   Public  List<Database.upsertResult> srList{get;set;}
   
    Public List<Database.upsertResult> UpsertPromotion(List<Promotion__c> promo)
     {
    
         system.debug('========promotionslist ' +promo);
         srList = new List<Database.upsertResult>();
         return  srList = Database.upsert(promo, false);
         
     }
     
      //---------------------- This method is Delete Promotion -------------------------  

    
  public LIST<Database.DeleteResult> deleteprom(LIST<Promotion__c> delpromolist ){
        system.debug('=========delpromolist================ ' + delpromolist );
            Database.DeleteResult[] DR_Dels = Database.Delete(delpromolist,false);
            return  DR_Dels ;
        
        }
        
      

}