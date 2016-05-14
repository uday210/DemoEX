trigger insertSettingsPool on Item_Pool__c (after insert,before insert) {
 List<Reg_Setting__c>  defaultEventSettings = new List<Reg_Setting__c>();
  List<Reg_Setting__c>  defaultEventSettingsnew = new List<Reg_Setting__c>();
  SET<id> eventIds = new SET<id>(); 
  SET<id> tickettypeIds= new SET<id>();
  
  //to get event setting type
  MAP<id,string> mapidwithName = new MAP<id,string>();
  
  if(Trigger.isBefore){
   //to get events
   for(Item_Pool__c item:trigger.new){
     eventIds.add(item.Event__c);
     tickettypeIds.add(item.item_type__c);
   }
   
    for(BLN_Event__c itr : [select id,Name,Event_Ticket_Options__c from BLN_Event__c where id IN :eventIds]){
      mapidwithName.put(itr.id,itr.Event_Ticket_Options__c);
   }
     for(Item_Pool__c item:trigger.new){
         item.Ticket_Settings__c = 'Do not collect Attendee info';
         //mapidwithName.get(item.Event__c);
    }
   
  }
    
  /*if(Trigger.isafter){ 
 SET<id> eventIds1 = new SET<id>(); 
 List<Item_Pool__c> poolList = new List<Item_Pool__c>();
 SET<id> poolIds= new SET<id>(); 
    for(Item_Pool__c item:trigger.new){
       eventIds1.add(item.Event__c);
       poolIds.add(item.id); 
        
   }
   
   poolList =[select id,item_Type__r.Name,Addon_Parent__c from Item_Pool__c where ID IN :poolIds];
   
 system.debug('XXXXXXXXXXXXXXXX '+eventIds1);
   defaultEventSettings =[select Group_Order__c,Sales_Message__c,Defaullt_Label__c,Column_Name__c,Event__c,Group_Name__c,Included__c,Item__c,Item_Pool__c,Order__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c from Reg_Setting__c where Event__c IN :eventids1 and item_pool__c=null and item__c=null and Setting_Type__c ='Regular'];
   system.debug('AAAAAAAAAAAAAAAAAAA '+eventIds1);
    for(Item_Pool__c item:poolList){
       if(item.Addon_Parent__c!=null){
        for(Reg_Setting__c regs:defaultEventSettings){
          Reg_Setting__c  reg = new Reg_Setting__c ();
          reg =regs.clone();
          reg.item_pool__c= item.id;
          defaultEventSettingsnew.add(reg);
           if(defaultEventSettingsnew.size()==999){
              DataBase.insert(defaultEventSettingsnew,false);
              defaultEventSettingsnew = new List<Reg_Setting__c>();
          }
        }
     } 
   }
    if(defaultEventSettingsnew.size()>0){
       DataBase.insert(defaultEventSettingsnew,false);
   }
 } */
}