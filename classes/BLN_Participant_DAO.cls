public with sharing class BLN_Participant_DAO {
	
	
	public LIST<Participant__c> allParticipants(id eventID){
		/*  We are GN Users related this Event by query on UCRole object and gather all GN Users in MAP
		*/
		LIST<UC_Role__c> ucRoles = [SELECT ID, GN_User__c FROM UC_Role__c WHERE Event__c =: eventID];
		MAP<Id, ID> ucRolesGNUsers = new MAP<ID, ID>();
		
		
		for(UC_Role__c r: [SELECT ID, GN_User__c FROM UC_Role__c WHERE Event__c =: eventID]){
			ucRolesGNUsers.put(r.ID,  r.GN_User__c);
		}
		
        return [SELECT ID, NAME, BLN_TKT_profile__c, BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Last_Name__c, Participant_Role__c, Time_Slot__c,  
                        BLN_TKT_profile__r.TKT_Job_Title__c, BLN_TKT_profile__r.User_Pic__c
                                            FROM Participant__c WHERE BLN_TKT_profile__r.BLN_GN_User__c =: ucRolesGNUsers.values() ];
 
	}
	
	public LIST<Participant__c> freeParticipants(id eventID){
		/*  We are GN Users related this Event by query on UCRole object and gather all GN Users in MAP
		*/
		LIST<UC_Role__c> ucRoles = [SELECT ID, GN_User__c FROM UC_Role__c WHERE Event__c =: eventID];
		MAP<Id, ID> ucRolesGNUsers = new MAP<ID, ID>();
		
		
		for(UC_Role__c r: [SELECT ID, GN_User__c FROM UC_Role__c WHERE Event__c =: eventID]){
			ucRolesGNUsers.put(r.ID,  r.GN_User__c);
		}
		
        return [SELECT ID, NAME, BLN_TKT_profile__c, BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Last_Name__c, Participant_Role__c, Time_Slot__c,  
                        BLN_TKT_profile__r.TKT_Job_Title__c, BLN_TKT_profile__r.User_Pic__c
                                            FROM Participant__c WHERE BLN_TKT_profile__r.BLN_GN_User__c=: ucRolesGNUsers.values() AND Time_Slot__c = null ];
 
	}
	
	
	
	
	public LIST<databAse.upsertResult> insertParticipants(LIST<Participant__c> part ){
			
			LIST<databAse.upsertResult> saveRes = DataBase.upsert(part,false);
			
			return saveRes;
			
	}

}