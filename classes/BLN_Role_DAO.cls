public with sharing class BLN_Role_DAO {
    
     
    
      //BY Mallik
        public Role__c userRole(String roles){
            
              Role__c role = [SELECT ID, NAME FROM Role__c WHERE Role_ShortName__c =: roles limit 1];
            
            return role;
        }
        
        
     //BY Phani
        public List<Role__c> userRole(){
            
              List<Role__c> role = [SELECT ID, NAME FROM Role__c ];
            
            return role;
        }   
     
}