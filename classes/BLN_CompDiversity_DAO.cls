public with sharing class BLN_CompDiversity_DAO {

     /********This method is to insert GNUser companies Diversitis,written by Purna *******************************/
    
    public void DiversityHandle(Id compId,Id uId,String diversitiesCodesString){
          Savepoint sp = Database.setSavepoint();
            List<Company_Diversity__c> comList = new List<Company_Diversity__c>();
           List<Company_Diversity__c>  naicsListToinsert = new List<Company_Diversity__c>();

            for(String ncs : diversitiesCodesString.split('-')){
             if(ncs=='' ){

            }else{
               comList = [SELECT id from Company_Diversity__c Where Company__c=:compId AND BLN_GN_User__c=:uId];
               Database.Delete(comList,false);
             
             Company_Diversity__c nind = new Company_Diversity__c();
                   nind.BLN_GN_User__c = uId;
                   nind.Company__c = compId;
                   system.debug('dddddddddddddddddddddddddd'+ncs);
                   nind.Diversity__c = ncs;
                   //nind.Uniqncu__c= uId+''+compId+''+ncs;
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
       
       
      public void DiversityHandle(Id tktId,String diversitiesCodesString){
          Savepoint sp = Database.setSavepoint();
            List<Company_Diversity__c> comList = new List<Company_Diversity__c>();
           List<Company_Diversity__c>  naicsListToinsert = new List<Company_Diversity__c>();

            for(String ncs : diversitiesCodesString.split('-')){
             if(ncs=='' ){

            }else{
              comList = [SELECT id from Company_Diversity__c Where BLN_TKT_profile__c=:tktId];
               Database.Delete(comList,false);
             
             Company_Diversity__c nind = new Company_Diversity__c();
                   nind.BLN_TKT_profile__c= tktId;
                   nind.Diversity__c = ncs;
                   //nind.Uniqncu__c= uId+''+compId+''+ncs;
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
     
        /********This method is to get gnuser company diversities,written by Purna *******************************/
        public List<Company_Diversity__c> getComGNUserDivs(String compid,Id gnuid){
        return  [SELECT id,Company__c,BLN_GN_User__c,Diversity__r.Name from Company_Diversity__c where Company__c=:compid and BLN_GN_User__c = : gnuid ]; 
    }
       
       
       
       
       public List<Company_Diversity__c> getComDivs(String tktId ){
        return  [SELECT id,Company__c,BLN_GN_User__c,Diversity__c from Company_Diversity__c where BLN_TKT_Profile__c=:tktId]; 
    }
}