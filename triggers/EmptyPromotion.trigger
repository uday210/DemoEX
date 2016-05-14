trigger EmptyPromotion on Order_Item__c (before insert, after insert) {
 SET<id> ordItemIds = new SET<id>();
  for(Order_Item__c ord : trigger.new){
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                if(ord.Item_Discount__c<=0 ){
                    ord.Promotion__c=null;
                }
            }
        }
     ordItemIds.add(ord.id);     
  }
   
   List<Order_Item__c> orderItems = new List<Order_Item__c>();
   for( Order_Item__c ord : [select Tax__c,Status__c,id,Item__r.Taxable__c,Item__r.Event__r.Accept_Tax_Rate__c,Item_Total__c,Item_Discount__c,Item__r.Event__r.Tax_Rate__c,Order__r.Fee_Amount__c  from  Order_Item__c where id In :ordItemIds ]){
   system.debug('$$$$$$'+ord.Tax__c);
    /* TO Update Ta field based on the formula given */
        if(Trigger.isAfter){
            if(ord.Status__c!='Cancelled'){
              System.debug('rrrrrrrrrrrrrrrrrr '+ ord.Status__c);
                if(ord.Item__r.Taxable__c == true  && ord.Item__r.Event__r.Accept_Tax_Rate__c == true && ord.Order__r.Fee_Amount__c >0){
                     Double tax = ( ord.Item_Total__c  -  ord.Item_Discount__c  ) *  ord.Item__r.Event__r.Tax_Rate__c  / 100;
                     ord.Tax__c= tax;
                 }else{
                     ord.Tax__c= 0.0;
                 }
             }
             ord.Tax__c =  ord.Tax__c.setScale(2,RoundingMode.HALF_UP);
             orderItems.add(ord); 
           }            
         }
      
        if(orderItems.size()>0){
         Database.update(orderItems,false);
        }
     /* TO Update Ta field based on the formula given */

  
}