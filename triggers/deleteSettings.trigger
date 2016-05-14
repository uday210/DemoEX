trigger deleteSettings on BLN_Item__c (before delete) {
      if(Trigger.isDelete) {
         SET<id> lstId = new SET<id>();
         for(BLN_Item__c  opp: Trigger.old) {            
                lstId.add(opp.Id);
        }
        system.debug('QQQQQQQQQQQQ '+lstId);
      List<Reg_Setting__c>   regList =[select id from Reg_Setting__c where item__c IN :lstId];   
      dataBase.Delete(regList,false); 
   }   
}