public with sharing class BLN_CompNaics_DAO {
    public void NaicsHandle(Id compId,Id uId,String naicsCodesString){
          Savepoint sp = Database.setSavepoint();
            List<Company_Naicscodes__c> comList = new List<Company_Naicscodes__c>();
            List<Company_Naicscodes__c>  naicsListToinsert = new List<Company_Naicscodes__c>();

            for(String ncs : naicsCodesString.split('-')){
             if(ncs=='' ){

            }else{
                 comList = [SELECT id from Company_Naicscodes__c Where BLN_Company__c=:compId AND BLN_GN_User__c=:uId];
                 Database.Delete(comList,false);
           

                Company_Naicscodes__c nind = new Company_Naicscodes__c();
                   nind.BLN_GN_User__c = uId;
                   nind.BLN_Company__c = compId;
                   system.debug('dddddddddddddddddddddddddd'+ncs);
                   nind.BLN_NAICS_Code__c = ncs;
                   naicsListToinsert.add(nind);
            }
               
            }
            
            Database.SaveResult[] sRes = Database.insert(naicsListToinsert,false);
               for(Database.SaveResult sR :sRes){
                  if(sR.isSuccess()){
                     
                  }else{
                    Database.RollBack(sp);
                  }
               }
       }
 public void NaicsHandle(Id tktId,String naicsCodesString){
          Savepoint sp = Database.setSavepoint();
            List<Company_Naicscodes__c> comList = new List<Company_Naicscodes__c>();
            List<Company_Naicscodes__c>  naicsListToinsert = new List<Company_Naicscodes__c>();

            for(String ncs : naicsCodesString.split('-')){
             if(ncs=='' ){

            }else{
                 comList = [SELECT id from Company_Naicscodes__c Where BLN_tkt_profile__c=:tktId];
                 Database.Delete(comList,false);
                Company_Naicscodes__c nind = new Company_Naicscodes__c();
                   nind.BLN_tkt_profile__c = tktId;
                   system.debug('dddddddddddddddddddddddddd'+ncs);
                   nind.BLN_NAICS_Code__c = ncs;
                   naicsListToinsert.add(nind);
            }
               
            }
            
            Database.SaveResult[] sRes = Database.insert(naicsListToinsert,false);
               for(Database.SaveResult sR :sRes){
                  if(sR.isSuccess()){
                     
                  }else{
                    Database.RollBack(sp);
                  }
               }
       }


        /********This method is to get gnuser company NAICS codes,written by Purna *******************************/
        
         public List<Company_Naicscodes__c> getCompGNUserNaics(String compid ,Id gnuid){
        return  [SELECT id,BLN_Company__c,BLN_GN_User__c,BLN_NAICS_Code__r.Description__c from Company_Naicscodes__c where BLN_Company__c=:compid and BLN_GN_User__c = : gnuid]; 
}

}