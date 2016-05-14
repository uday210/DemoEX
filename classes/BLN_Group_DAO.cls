public without sharing class BLN_Group_DAO {
    public BLN_Group_DAO() {
    }
  public List<BLN_Group__c> geteventGroups(String eve){
    return [SELECT Owner.Username,Id, Name, (SELECT Id, GN_User__c, GN_User__r.First_Name__c, GN_User__r.Last_Name__c, GN_User__r.Email__c, Company__c, Company__r.Name, RoleId__r.Name, RoleId__c from BLN_UC_Role__r Where (RoleId__r.Name = 'BoothLeads Staff' OR RoleId__r.Name = 'BoothLeads Admin')) FROM BLN_Group__c WHERE Event__c = :eve];
  }
  public List<BLN_Group__c> geteventGroups(SET<id> grsids){
    return [SELECT Owner.Username,Id, Name, (SELECT Id, GN_User__c, GN_User__r.First_Name__c, GN_User__r.Last_Name__c, GN_User__r.Email__c, Company__c, Company__r.Name, RoleId__r.Name, RoleId__c from BLN_UC_Role__r Where (RoleId__r.Name = 'BoothLeads Staff' OR RoleId__r.Name = 'BoothLeads Admin')) FROM BLN_Group__c WHERE Id IN :grsids];
  }
  public BLN_Group__c getGroup(String gpId){
    return [SELECT Id, Name FROM BLN_Group__c WHERE Id = :gpId];
  }

 public BLN_Group__c getGroupWithucrole(String gpId){ 
  return [SELECT Id, (SELECT Id FROM BLN_UC_Role__r) from BLN_Group__c where Id = :gpId];
 }
}