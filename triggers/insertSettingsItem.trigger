trigger insertSettingsItem  on BLN_Item__c (after insert,before insert) {
  List<Reg_Setting__c>  defaultEventSettings = new List<Reg_Setting__c>();
  List<Reg_Setting__c>  defaultEventSettingsnew = new List<Reg_Setting__c>();
  SET<id> eventIds = new SET<id>(); 
  SET<id> tickettypeIds= new SET<id>();
  // to get item Names
   MAP<id,string> mapidwithName = new MAP<id,string>();
    MAP<id,string> mapidwithName1 = new MAP<id,string>();
     
  if(Trigger.isBefore){ 
   //to get events
   for(BLN_Item__c  item:trigger.new){
     eventIds.add(item.Event__c);
   }
   
      for(BLN_Event__c itr : [select id,Name,Event_Ticket_Options__c from BLN_Event__c where id IN :eventIds]){
         mapidwithName1.put(itr.id,itr.Event_Ticket_Options__c);
      }
      
      for(BLN_Item__c item:trigger.new){
         item.Ticket_Settings__c =mapidwithName1.get(item.Event__c);
       }  
      
  }
  
  /*if(Trigger.isafter){ 
  SET<id> eventIds1 = new SET<id>();
   //to get events
   for(BLN_Item__c  item:trigger.new){
     eventIds1.add(item.Event__c);
     tickettypeIds.add(item.item_type__c);
   }
  
     for(item_type__c itr : [select id,Name from item_type__c  where id IN :tickettypeIds]){
        mapidwithName.put(itr.id,itr.Name);
      }
    system.debug('ZZZZZZZZZZZZZZZZZZZZ '+eventIds1);
  
   defaultEventSettings =[select Group_Order__c,Sales_Message__c,Defaullt_Label__c,Column_Name__c,Event__c,Group_Name__c,Included__c,Item__c,Item_Pool__c,Order__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c from Reg_Setting__c where Event__c IN :eventids1 and item_pool__c=null and item__c=null and Setting_Type__c ='Regular'];
    for(BLN_Item__c  item:trigger.new){
     //if(mapidwithName.get(item.item_type__c)!='Package'){
      for(Reg_Setting__c regs:defaultEventSettings){
         Reg_Setting__c  reg = new Reg_Setting__c ();
         reg =regs.clone();
         reg.item__c= item.id;
         if(mapidwithName.get(item.item_type__c) == 'Speaker' && regs.Group_Name__c == 'Speaker Information'){
             reg.Included__c=true;
         }
         defaultEventSettingsnew.add(reg);
       // }
      //}
     } 
   }
  if(defaultEventSettingsnew.size()>0){
   DataBase.insert(defaultEventSettingsnew,false);
  }
 } */ 
}