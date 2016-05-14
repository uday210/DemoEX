public without sharing class BLN_OrderItem_DAO{
/**
* @author :Arindam Sarkar
* @date 05/15/2014
* @ This class is used for DML operations on OrderItem object
*/    
   //Inserting OrderItems  
   public BLN_StatusMessage insertOrder(Order_Item__c orditem)
   {
       dataBase.saveResult saveRes = dataBase.insert(orditem,false); 
       return new BLN_StatusMessage(saveRes);
        
   }
   
   //insert bulk orderItems OrderItems   // By Phani 
   public BLN_StatusMessage updateOrder(List<Order_Item__c> orditem)
   {
       dataBase.saveResult[] saveRes = dataBase.update(orditem,false); 
       system.debug('ZZZZZZZZZZZZZZZZZZz '+saveRes );
       return new BLN_StatusMessage(saveRes);
        
   }
   
   
   //insert bulk orderItems OrderItems   // By Phani 
   public BLN_StatusMessage insertOrderitem1(List<Order_Item__c> orditem)
   {
       dataBase.saveResult[] saveRes = dataBase.insert(orditem,false); 
       system.debug('ZZZZZZZZZZZZZZZZZZz '+saveRes );
       return new BLN_StatusMessage(saveRes);
        
   }
   
 // this will return iteams of orders   
  public List<Order_Item__c> ordeIteam(string uid){
    return [Select Currency__c,Each_Ticket_Price__c,Item_Fee__c,item__r.event__r.Name ,o.Promotion__c, o.Order__c, o.Name, o.Item__c, o.Item_Total__c, o.Item_Quantity__c, o.Item_Price__c, o.Item_Discount__c, o.Id,Item__r.Event__r.End_Date__c,item__r.item_name__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c,Status__c From Order_Item__c o where order__r.bln_tkt_profile__r.bln_gn_user__r.user__c =:uid and status__c!='Cancelled'];
  }  
  
   // To return Order Item based on the order and item 
  public Order_Item__c getOrderItem(string orderid, string itemid){
    return [Select Currency__c,Each_Ticket_Price__c,Item_Fee__c,item__r.event__r.Name ,o.Promotion__c, o.Order__c, o.Name, o.Item__c, o.Item_Total__c, o.Item_Quantity__c, o.Item_Price__c, o.Item_Discount__c, o.Id,Item__r.Event__r.End_Date__c,item__r.item_name__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c,Status__c From Order_Item__c o WHERE order__c =:orderid AND item__c =: itemid  and  status__c!='Cancelled' LIMIT 1];
  }    
    
 //Getting tickets of orders 
   public List<Order_Item__c> orderQueryTicketCh(SET<id> orids){
     return [SELECT Tax__c,Currency__c,Each_Ticket_Price__c,Item_Fee__c,id,Item__c,Item_Discount__c,Item_Price__c,Item_Quantity__c,Item_Total__c,Order__c,Promotion__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c,(select id,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,tkt_profile__r.bln_gn_user__r.user__r.userName,tkt_profile__r.bln_gn_user__r.user__r.CompanyName,Ticket_Status__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c, tkt_profile__r.tkt_company__c,tkt_profile__r.bln_company__c,Event__c,Hide_Desc__c,Item__c,Item_Pool__c,Item_Type__c,Order__c,Order_Item__c,Parent_ID__c,RSVP__c,Tag_No__c,item__r.item_type__r.Name from Tickets__r where Ticket_Status__c!='Cancelled'),Status__c,item__r.Item_Pool__r.Item_Pool_Name__c,item__r.item_type__r.Name From Order_Item__c where order__c In :orids and status__c!='Cancelled'];
   }
   
   
     
   
   //Getting tickets of orders 
   public List<Order_Item__c> getTicketsOfperticularOItem(string orids){
     return [SELECT Tax__c,Currency__c,Each_Ticket_Price__c,Item_Fee__c,id,Item__c,Item_Discount__c,Item_Price__c,Item_Quantity__c,Item_Total__c,Order__c,Promotion__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c,(select id,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,tkt_profile__r.bln_gn_user__r.user__r.userName,tkt_profile__r.bln_gn_user__r.user__r.CompanyName,Ticket_Status__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c, tkt_profile__r.tkt_company__c,tkt_profile__r.bln_company__c,Event__c,Hide_Desc__c,Item__c,Item_Pool__c,Item_Type__c,Order__c,Order_Item__c,Parent_ID__c,RSVP__c,Tag_No__c,item__r.item_type__r.Name from Tickets__r where Ticket_Status__c!='Cancelled'),Status__c,item__r.Item_Pool__r.Item_Pool_Name__c,item__r.item_type__r.Name From Order_Item__c where id  = :orids and status__c!='Cancelled'];
   }
   
  //Getting tickets of orders 
   public List<Order_Item__c> getTicketsOfperticularOItem(List<id> orids){
     return [SELECT Tax__c,Currency__c,Each_Ticket_Price__c,Item_Fee__c,id,Item__c,Item_Discount__c,Item_Price__c,Item_Quantity__c,Item_Total__c,Order__c,Promotion__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c,(select id,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,tkt_profile__r.bln_gn_user__r.user__r.userName,tkt_profile__r.bln_gn_user__r.user__r.CompanyName,Ticket_Status__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c, tkt_profile__r.tkt_company__c,tkt_profile__r.bln_company__c,Event__c,Hide_Desc__c,Item__c,Item_Pool__c,Item_Type__c,Order__c,Order_Item__c,Parent_ID__c,RSVP__c,Tag_No__c,item__r.item_type__r.Name from Tickets__r where Ticket_Status__c='Booked'),Status__c,item__r.Item_Pool__r.Item_Pool_Name__c,item__r.item_type__r.Name From Order_Item__c where id  In :orids and status__c!='Cancelled'];
   }
  
  
   //Getting tickets of orders 
   public List<Order_Item__c> getTicketsOfperticularOItemList(SET<id> orids){
     return [SELECT Tax__c,Currency__c,Each_Ticket_Price__c,Item_Fee__c,id,Item__c,Item_Discount__c,Item_Price__c,Item_Quantity__c,Item_Total__c,Order__c,Promotion__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c,(select id,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,tkt_profile__r.bln_gn_user__r.user__r.userName,tkt_profile__r.bln_gn_user__r.user__r.CompanyName,Ticket_Status__c,order__r.bln_tkt_profile__r.bln_gn_user__r.user__c, tkt_profile__r.tkt_company__c,tkt_profile__r.bln_company__c,Event__c,Hide_Desc__c,Item__c,Item_Pool__c,Item_Type__c,Order__c,Order_Item__c,Parent_ID__c,RSVP__c,Tag_No__c,item__r.item_type__r.Name from Tickets__r where Ticket_Status__c!='Cancelled'),Status__c,item__r.Item_Pool__r.Item_Pool_Name__c,item__r.item_type__r.Name From Order_Item__c where id In :orids and status__c!='Cancelled'];
   }
   
   // To get valid Order Items belongs to an Event
   public SET<Id> validOrderItemList(String EventId){
       LIST<Ticket__c> orderItemsList= new LIST<Ticket__c>();
       orderItemsList= [SELECT ID, Order_Item__c FROM Ticket__c WHERE Event__c =: eventId AND Ticket_Status__c =: 'Booked'];
       SET<Id> orderItemIds= new SET<Id>();
       for(Ticket__c tic: orderItemsList){
           orderItemIds.add(tic.Order_Item__c);       
       }
       return orderItemIds;
   }
   public integer soldtickets(string EventId){
   
   LIST<Ticket__c> orderItemsList= new LIST<Ticket__c>();
       orderItemsList= [SELECT ID, Order_Item__c FROM Ticket__c WHERE Event__c =: EventId AND Ticket_Status__c =: 'Booked' AND Parent_ID__c = NULL   AND Item_Type__r.Add_On__c = FALSE AND  (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' ) ];
   return orderItemsList.SIZE();
   }
    
}