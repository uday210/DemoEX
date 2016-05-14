public with sharing class BLN_ItemType_DAO {

/***********************************************************************************************
*   Controller Name : BLN_ItemType_DAO
*   Date            : 19/05/2014
*   Author          : Naga Mallikarjuna Rao B
*   Purpose         : This class is for Item Types Business Application Layer
*   Change History  : 19/05/2014 
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   19/05/2014          Naga Mallikarjuna Rao B           To Create Page
**************************************************************************************************/
     
     
     //This methode gives all the item types, if user pass empty list as parameaters it will send all Item Types.
     // If User pass any parameater it will skip those list and send remaining Item Types.
    public static LIST<Item_Type__c> AllItemTypes(LIST<String> unUsedItemTypes){
        
        LIST<Item_Type__c> itemTypes = new LIST<Item_Type__c>();
        
        if(unUsedItemTypes.size() >= 1 ){
            itemTypes = [SELECT ID, NAME, Add_On__c, BL_Fee_Amt_per_res__c, BL_Fee_Pct_per_res__c, Invoice_Seq__c,Item_Type_Number__c, Unlimited__c , 
                            Event_Option_Desc__c , Event_Option_Sort_Order__c, Event_Options_Image_URL__c,  Badge_Label__c
                            FROM Item_Type__c WHERE Item_Type_Number__c NOT IN: unUsedItemTypes ORDER BY Event_Option_Sort_Order__c];
        }else{
            itemTypes = [SELECT ID, NAME, Add_On__c, BL_Fee_Amt_per_res__c, BL_Fee_Pct_per_res__c, Invoice_Seq__c,Item_Type_Number__c, Unlimited__c, 
                            Event_Option_Desc__c , Event_Option_Sort_Order__c, Event_Options_Image_URL__c,  Badge_Label__c
                            FROM Item_Type__c ORDER BY Event_Option_Sort_Order__c];
        }
         
        return itemTypes;
    }
    
     //This methode gives Event Option item types, if user pass empty list as parameaters it will give all values greater than 1 in (Event_Option_Sort_Order__c).
     // If User pass any parameater it will gives that list of Item Types.
    public static LIST<Event_Price__c> eventOptionItemTypes(LIST<String> usedItemTypes,String eventid){
        
        LIST<Event_Price__c> itemTypes = new LIST<Event_Price__c>();
        
        if(usedItemTypes.size() >= 1 ){
            itemTypes = [SELECT ID, NAME,Event__c,Active_Flag__c,BL_Fee_Amount__c, Item_type__r.Add_On__c,Item_type__r.Event_Option_Sort_Order__c,Item_type__r.Event_Options_Image_URL__c,
                          Item_type__r.Id,Item_type__r.Event_Option_Desc__c,Item_type__r.Item_Type_Number__c
                            FROM Event_Price__c WHERE Item_type__r.Item_Type_Number__c IN: usedItemTypes AND Item_type__r.Event_Option_Sort_Order__c >= 1 and Active_Flag__c=true and Event__c=:eventid ORDER BY Item_type__r.Order__c];
        }else{
            itemTypes = [SELECT ID, NAME,Event__c,Active_Flag__c,BL_Fee_Amount__c, Item_type__r.Add_On__c,Item_type__r.Event_Option_Sort_Order__c,Item_type__r.Event_Options_Image_URL__c,
                          Item_type__r.Id,Item_type__r.Event_Option_Desc__c,Item_type__r.Item_Type_Number__c
                            FROM Event_Price__c WHERE Item_type__r.Event_Option_Sort_Order__c >= 1 and Active_Flag__c=true and Event__c=:eventid ORDER BY Item_type__r.Order__c];
   }
         
        return itemTypes;
        
    }  
    
    // This is For to get Admission Ticket Type from DataBase
    public static Item_Type__c AdmissionItemTypes( String  adminItemTypes){
        
         Item_Type__c  itemTypes = new  Item_Type__c ();
        
        if(adminItemTypes != null && adminItemTypes != '' ){
            itemTypes = [SELECT ID, NAME, Add_On__c, BL_Fee_Amt_per_res__c, BL_Fee_Pct_per_res__c, Invoice_Seq__c,Item_Type_Number__c, Unlimited__c ,Badge_Label__c
                            FROM Item_Type__c WHERE Item_Type_Number__c =: adminItemTypes];
            return itemTypes;
        } 
         
        return null;
    }
    
    // This is For to get Package Ticket Type from DataBase
    public static Item_Type__c PackageItemTypes( String  PackageItemTypes){
        
         Item_Type__c itemTypes = new  Item_Type__c ();
        
        if(PackageItemTypes != null && PackageItemTypes != '' ){
            itemTypes = [SELECT ID, NAME, Add_On__c, BL_Fee_Amt_per_res__c, BL_Fee_Pct_per_res__c, Invoice_Seq__c,Item_Type_Number__c, Unlimited__c , Badge_Label__c
                            FROM Item_Type__c WHERE Item_Type_Number__c =: PackageItemTypes];
            return itemTypes;
        } 
         
        return null;
    }
    
    
    public static LIST<Item_Type__c> itemTypesforTickets(SET<String> eventOptionsItemTypes){
        
        LIST<Item_Type__c> itemTypes = new LIST<Item_Type__c>();
        
        itemTypes = [SELECT ID, NAME, Add_On__c, BL_Fee_Amt_per_res__c, BL_Fee_Pct_per_res__c, Invoice_Seq__c,Item_Type_Number__c, Unlimited__c, 
                            Event_Option_Desc__c , Event_Option_Sort_Order__c, Event_Options_Image_URL__c
                            FROM Item_Type__c WHERE Item_Type_Number__c =: eventOptionsItemTypes OR  Add_On__c = TRUE ORDER BY Order__c];
        //
        return itemTypes;
        
    }
     
     public static LIST<Event_Price__c> itemTypesforIndividualTickets(SET<String> eventOptionsItemTypes,String eventid){
        
        LIST<Event_Price__c> itemTypes = new LIST<Event_Price__c>();
        
        /*itemTypes = [SELECT ID, NAME, Add_On__c, BL_Fee_Amt_per_res__c, BL_Fee_Pct_per_res__c, Invoice_Seq__c,Item_Type_Number__c, Unlimited__c, 
                            Event_Option_Desc__c , Event_Option_Sort_Order__c, Event_Options_Image_URL__c
                            FROM Item_Type__c WHERE Item_Type_Number__c =: eventOptionsItemTypes  ORDER BY Order__c];*/
        itemTypes = [SELECT ID, NAME,Event__c,Active_Flag__c,BL_Fee_Amount__c, Item_type__r.Add_On__c,Item_type__r.Event_Option_Sort_Order__c,Item_type__r.Event_Options_Image_URL__c,
                          Item_type__r.Id,Item_type__r.Name,Item_type__r.Event_Option_Desc__c,Item_type__r.Item_Type_Number__c
                            FROM Event_Price__c WHERE Item_type__r.Item_Type_Number__c IN: eventOptionsItemTypes and Active_Flag__c=true and Event__c=:eventid ORDER BY Item_type__r.Order__c];                    
        //
        return itemTypes;
        
    }
    
    public Item_Type__c getItemtype(String typeName){
       return [SELECT id,Name from Item_Type__c Where Name=:typeName limit 1];
    }
    

}