trigger copyEventPricingAndInsertDefaultTags on BLN_Event__c (after insert) {
    List<Event_Price__c>  evpricedefault = new List<Event_Price__c>();
    List<Event_Price__c>  evpricenewnew = new List<Event_Price__c>();
    //insert default tags for everyevent
    List<Hash_Tag__c>  evdefaulttags = new List<Hash_Tag__c>();
    evdefaulttags =[select id,name,Tag_Text__c,Event__c,IsDefault__c from Hash_Tag__c where Event__r.Name='Default Event(Boothleads)'];
    List<Hash_Tag__c> ht=new List<Hash_Tag__c>();
    evpricedefault =[select Active_Flag__c,Eventdex_Product__c,Event__c,BL_Fee_Amount__c,BL_Fee_Level__c,BL_Fee_Percentage__c,Item_Count__c,Item_type__c from Event_Price__c where Event__r.Name='Default Event(Boothleads)'];
    for(BLN_Event__c eve : trigger.new){
        for(Event_Price__c ep:evpricedefault){
            Event_Price__c eps= new Event_Price__c();
            eps= ep.clone();
            eps.event__c = eve.id;
            evpricenewnew.add(eps);
        }
        
        
        for(Hash_Tag__c evt:evdefaulttags){
         ht.add(new Hash_Tag__c(Event__c=eve.id,Tag_Text__c=evt.Tag_Text__c,IsDefault__c=evt.IsDefault__c));
         }
    }
    DataBase.insert(evpricenewnew,false);
    
    DataBase.insert(ht,false);
    
    
   
}