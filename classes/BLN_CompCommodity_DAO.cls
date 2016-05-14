public with sharing class BLN_CompCommodity_DAO {
    public void CommoditiesHandle(Id tktId,String CommString){
          Savepoint sp = Database.setSavepoint();
            List<BLN_Company_Commoditie__c> comList = new List<BLN_Company_Commoditie__c>();
            List<BLN_Company_Commoditie__c>  naicsListToinsert = new List<BLN_Company_Commoditie__c>();

            for(String ncs : CommString.split('-')){
             if(ncs=='' ){

            }else{
                 comList = [SELECT id from BLN_Company_Commoditie__c Where BLN_tkt_profile__c=:tktId];
                 Database.Delete(comList,false);
                BLN_Company_Commoditie__c nind = new BLN_Company_Commoditie__c();
                   nind.BLN_tkt_profile__c = tktId;
                   system.debug('dddddddddddddddddddddddddd'+ncs);
                   nind.BLN_Commodities__c = ncs;
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
    
     /********This method is to insert companies commodities,written by Purna *******************************/
         public void CommoditiesHandle(Id compId,Id uId,String compCmmsString){
              Savepoint sp = Database.setSavepoint();
                List<BLN_Company_Commoditie__c> comList = new List<BLN_Company_Commoditie__c>();
                List<BLN_Company_Commoditie__c>  comsListToinsert = new List<BLN_Company_Commoditie__c>();

                for(String comms : compCmmsString.split('-')){
                 if(comms=='' ){

                }else{
                     comList = [SELECT id from BLN_Company_Commoditie__c  Where BLN_Company__c=:compId AND BLN_GN_User__c=:uId];
                     Database.Delete(comList,false);


                    BLN_Company_Commoditie__c nind = new BLN_Company_Commoditie__c();
                       nind.BLN_GN_User__c = uId;
                       nind.BLN_Company__c = compId;
                       system.debug('dddddddddddddddddddddddddd'+comms);
                       nind.BLN_Commodities__c = comms;
                       comsListToinsert.add(nind);
                }
                   
                }
                
                Database.SaveResult[] sRes = Database.insert(comsListToinsert,false);
                   for(Database.SaveResult sR :sRes){
                      if(sR.isSuccess()){
                         
                      }else{
                        Database.RollBack(sp);
                      }
                   }
           }

    public Static List<BLN_Commodities__c> getCommodities(){
     List<BLN_Commodities__c> commList = new List<BLN_Commodities__c>();
      commList =[SELECT id,Name,Description__c from BLN_Commodities__c  ];  
      return commList;
    }     
    
    
    /********This method is to get gnuser company commodities,written by Purna *******************************/
        
    public List<BLN_Company_Commoditie__c> getCompGNUserComs(String compid,Id gnuid ){
        return  [SELECT id,BLN_Company__c,BLN_GN_User__c,BLN_Commodities__r.Description__c from BLN_Company_Commoditie__c where BLN_Company__c=:compid and BLN_GN_User__c = : gnuid]; 
    }      
    public List<BLN_Company_Commoditie__c> getComs(String tktId ){
        return  [SELECT id,BLN_Company__c,BLN_GN_User__c,BLN_Commodities__c from BLN_Company_Commoditie__c where BLN_TKT_Profile__c=:tktId]; 
    }
}