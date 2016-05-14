trigger DeletePoolSettings on Item_Pool__c (before delete) {

      if(Trigger.isDelete) {
          SET<id> lstId = new SET<id>();
          for(Item_Pool__c opp: Trigger.old) {            
                lstId.add(opp.Id);
          }
          system.debug('WEEEEEEEEEEEEEEEEE '+lstId);
         List<Reg_Setting__c>   regList =[select id from Reg_Setting__c where item_Pool__c IN :lstId];   
         dataBase.Delete(regList,false); 
   }   

}