public class BLN_InvoiceComponentController {
    
    public ID orderId {get;set;}
    
    public BLN_Event__c event;
    
    public Order__c order;
    
   public BLN_Event__c senderevent;
    public String orgid;
    
    public List<Order_Item__c>  orditem;
    
    public Order__c getOrder() {
    order=new Order__c();
       try{
     order= [SELECT Currency_Code__r.Currency_Symbol__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Last_Name__c,BLN_TKT_profile__r.name,BLN_TKT_profile__r.Billing_Address__r.Address1__c,BLN_TKT_profile__r.Billing_Address__r.Address2__c,BLN_TKT_profile__r.Billing_Address__r.City__c,BLN_TKT_profile__r.Billing_Address__r.State__r.long_name__c,BLN_TKT_profile__r.Billing_Address__r.State__r.short_name__c,BLN_TKT_profile__r.Billing_Address__r.ZipCode__c,Events__r.name,createddate,(select id,name,Payment_Mode__c,credit_card_last_4digits__c,credit_card_type__c from Payments__r),(select id,Item__r.item_name__c,Item_Quantity__c,Each_Ticket_Price__c,Item_Total__c from Order_Items__r),id,name,Currency_Code__c,BLN_TKT_profile__c,BLN_TKT_profile__r.BLN_GN_User__r.User__c,BLN_TKT_profile__r.BLN_Company__c,Events__c,Fee_Amount__c,Order_Discount__c,Order_Status__c,Order_Sub_Total__c,Order_Taxes__c,Order_Total__c,order_type__c,Amount_Paid__c FROM Order__c WHERE id=:orderId order by lastmodifieddate desc limit 1];
     }catch(Exception e){}  
        return order;
    }
    
    public List<Order_Item__c> getOrditem()
    {
    try{
     orditem=[select id,Item__c,Item__r.item_name__c,Item_Quantity__c,Each_Ticket_Price__c,Item_Total__c,Item_Discount__c,Item_Fee__c,Order__r.Fee_Amount__c,Order__r.Order_Taxes__c,Order__c,Order__r.Events__c,Item__r.service_fee__c from Order_Item__c where Order__c=: orderId order by Item__c];
     }catch(Exception e){}  
        return orditem;
    
     
    }
    
    
    public BLN_Event__c getEvent() {
         Order__c ordnew=[select id,name,(select id,name,Item__r.Event__c from Order_Items__r),Order_Status__c from Order__c where id=:orderId]; 
   
             event= [SELECT owner.name,City__c,BLN_State__r.long_name__c,ZipCode__c,Street1__c,Street2__c,id,name,Start_Date__c,venue_name__c,BLN_Country__r.Currency__r.Currency_Symbol__c,organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,Event_Status__c from BLN_Event__c where id=:ordnew.Order_Items__r[0].Item__r.Event__c];
          
        return event;
    }
    
    
    public BLN_Event__c getSenderevent() {
         Order__c ordnew=[select id,name,events__c from Order__c where id=:orderId]; 
   
             senderevent= [SELECT owner.name,City__c,BLN_State__r.short_name__c,BLN_State__r.long_name__c,ZipCode__c,Street1__c,Street2__c,id,name,Logo_URL__c,Start_Date__c,venue_name__c,organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,organizer_id__r.PG_Authorization_Key__c,ownerid,BLN_Country__r.Currency__c,Organizer_Email__c,organizer_id__c ,Event_Status__c from BLN_Event__c where id=:ordnew.events__c];
          
        return senderevent;
    }
   
   public String getOrgid()
   { 
    return UserInfo.getOrganizationId();
   }
  
    
}