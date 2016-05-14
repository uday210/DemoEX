public without sharing class BLN_UCRole_DAO{

/**
* @author :Phani Chimata
* @date 05/11/2014
* @ This class is used for DML operations on UCROLE object
*/ 
  
  //-----------------Variables Declaration---------  
  public String Message{get;set;}
  
  // -------------------------------- Insert UC Role -----------------------------------------------
    public BLN_StatusMessage insertUCRole(UC_Role__c UCRole, String Role){
    
        dataBase.saveResult saveRes;
         LIST<UC_Role__c> UCRoleList=new  LIST<UC_Role__c>();
        if(UCRole.Event__c==null)
        UCRoleList = [SELECT id,event__c,roleid__r.name,company__c FROM UC_Role__c WHERE GN_User__c =: UCRole.GN_User__c and Company__c=: UCRole.Company__c and RoleId__r.name='Company Admin' and Event__c=null limit 1];
        else
        UCRoleList = [SELECT id,event__c,roleid__r.name,company__c FROM UC_Role__c WHERE GN_User__c =: UCRole.GN_User__c and Company__c=: UCRole.Company__c and Event__c=:UCRole.Event__c limit 1];
        if(UCRoleList.size() > 0){
            Role__c rl=[select id,name from Role__c where name=:Role limit 1];
            system.debug('RRRRRRRRRRRRRRRRRRRRRRRunning   '+ UCRoleList[0]);
            UCRoleList[0].RoleId__c = rl.id;
            saveRes = dataBase.update(UCRoleList[0],false); 
            system.debug('Inserted UC Role Id in DAO1: '+new BLN_StatusMessage(saveRes));
        }
        else{
            LIST<Role__c> roles =[SELECT ID, NAME FROM Role__c WHERE NAME=: Role];
            
            system.debug('RRRRRRRRRRRRRRRRRRRRRRRunning11111111111111111   '+ UCRole);
           //GN_User__c loginUser = new GN_User__c();
           
           // loginUser = [SELECT ID, NAME, FirstName, LastName, Email, userName FROM USER WHERE ID=: UCRole.User__c LIMIT 1];
            
            //system.debug('RRRRRRRRRRRRRRRRRRRRRRRunning222222222222222222222            '+ loginUser);
            
            
            LIST<GN_User__c> GNUserList = [SELECT ID, NAME,First_Name__c ,Last_Name__c , Email__c  FROM GN_User__c WHERE ID =:UCRole.GN_User__c ];
            
            system.debug('RRRRRRRRRRRRRRRRRRRRRRRunning            '+ GNUserList.size() +'      '+  roles.size());
            
            if(roles.size() > 0){
                UCRole.RoleId__c = roles[0].id;
                UCRole.GN_User__c= GNUserList[0].id;
            }
            
            saveRes = dataBase.insert(UCRole,false); 
            system.debug('Inserted UC Role Id in DAO2: '+new BLN_StatusMessage(saveRes));
        }
        return new BLN_StatusMessage(saveRes);
    }
    
    
   
    
  
  // -------------------------------- Update UC Role -----------------------------------------------
  public String updateUCRole(UC_Role__c UCRole, String Role){
     LIST<UC_Role__c> UCRoleList = [SELECT id FROM UC_Role__c WHERE Id =: UCRole.Id];
     if(UCRoleList.size() > 0){
         UC_Role__c UCRoleObj = new UC_Role__c();
         
         //UCRoleObj.Role__c = Role;
         database.update(UCRoleObj);
         Message = 'Success';
     }
     return Message;
  }

  // -------------------------------- Update UC Role -----------------------------------------------
  public String updateUCRole1(string uid,string compId){
    system.debug('HHHHHHHHHHHHHHHH '+uid+'AAAAAAAAAAAA '+compId);
     LIST<UC_Role__c> UCRoleList = new LIST<UC_Role__c>([SELECT id,GN_User__c FROM UC_Role__c WHERE GN_User__c =:uid]);
     if(UCRoleList.size() > 0){
       UCRoleList[0].Company__c =compId;
       database.update(UCRoleList[0],false);
       Message = 'Success';
     }
     return Message;
  }

 
 // This method is for updating user Company 

  public void updateUC_roleCompany(string email,string cId){
   UC_Role__c updaterole=[select GN_User__c,GN_User__r.Email__c,Company__c from UC_Role__c  where GN_User__r.Email__c=:email limit 1];
     updaterole.Company__c = cId;
     update updaterole;
         
  }

// By Phani-------- getting user company role for perticular event----------------
   public List<UC_Role__c> userComapnyRoles(List<id> uids,string eventId){
       return [select Company__c,RoleId__r.name,GN_User__r.User__r.firstName,GN_User__r.User__r.lastName,GN_User__r.User__r.email,GN_User__r.User__r.userName,GN_User__r.User__r.CompanyName from UC_Role__c  where GN_User__r.User__c In :uids and Event__c=:eventId];
   }
   
   //Added By Anil regarding EventStaff, To fetch BLN Role of Gn_User based on GNuser and Company ID
   
    public List<UC_Role__c> UserRoleBasedOnGnUserAndCompany(List<id> uids,string CompanyId){
       return [select Company__c,RoleId__r.name,GN_User__r.User__r.firstName,GN_User__r.User__r.lastName,GN_User__r.User__r.email,GN_User__r.User__r.userName,GN_User__r.User__r.CompanyName from UC_Role__c  where GN_User__r.User__c In :uids ];
   }
   public BLN_StatusMessage  updateuserCompanyRole(List<UC_Role__c> ucrList){
      DataBase.saveresult[] ucroleUpdate = dataBase.update(ucrList,false);
      return new BLN_StatusMessage(ucroleUpdate);
   }

   public BLN_StatusMessage  saveUserCompanyRole(List<UC_Role__c> ucrList){
      DataBase.saveresult[] ucroleUpdate = dataBase.insert(ucrList,false);
      return new BLN_StatusMessage(ucroleUpdate);
   }
   
   
   // To get Login User 
   public UC_Role__c queryCompanyInformation(){
    
        LIST<UC_Role__c> userRolls = [SELECT ID, NAME, Company__c, Company__r.Name, GN_User__r.User__c FROM UC_Role__c WHERE GN_User__r.User__c =: userinfo.getUserId() AND  Event__c = null ];
        
        if(userRolls.size() > 0){
            return userRolls[0];
        }else{
            return new UC_Role__c();
        }
    return null;
   }
   
   // To get UCRole Information
   public UC_Role__c getUCRole(Id UCRoleId){ 
        LIST<UC_Role__c> UserRoleList = [SELECT ID, NAME, Company__c, Company__r.Name,GN_User__c,GN_User__r.User__c,RoleId__r.Name    
                                         FROM UC_Role__c 
                                         WHERE Id =: UCRoleId];
        
        if(UserRoleList.size() > 0){
            return UserRoleList[0];
        }else{
            return new UC_Role__c();
        }
        return null;
   }
   //For getting Event staff records.
   //Which will have specific Roles.
   public LIST<UC_Role__c> eventstaffvals(string eveid){
   return [select Company__c, Company__r.Name,RoleId__r.Name,GN_User__r.First_Name__c,GN_User__r.Last_Name__c,
                  GN_User__r.Email__c from UC_Role__c  where Event__c=:eveId];// AND (RoleId__r.Name =: 'Full Admin' OR RoleId__r.Name =: 'Onsite Staff' OR RoleId__r.Name =: 'Registration User')
   
   
   }
   
   public UC_Role__c fetchEventAdmin(string eveid){
   return [select Company__c,RoleId__r.Name,GN_User__r.First_Name__c,GN_User__r.Last_Name__c,
                  GN_User__r.Email__c from UC_Role__c where Event__c=:eveId AND RoleId__r.Name =: 'Event Admin' LIMIT 1];
   
   
   }
   
   //method to get list of uc roles under gn user
   public LIST<UC_Role__c> ucRoleForGNUser(set<id> GNUserID){
   return [select Company__c, Company__r.Name,RoleId__r.Name,GN_User__r.First_Name__c,GN_User__r.Last_Name__c,                  GN_User__r.Email__c from UC_Role__c  where GN_User__c in : GNUserID] ;  
   
   }
   public LIST<UC_Role__c> allucroles(){
   return [select id,User_Type__c,Company__c  from UC_Role__c ];
   }
    public List<UC_Role__c> getRolesOfuser(String email,String compId){
       return [select Company__c, Company__r.Name,RoleId__r.Name,GN_User__r.First_Name__c,GN_User__r.Last_Name__c,
                  GN_User__r.Email__c from UC_Role__c Where GN_User__r.Email__c=:email AND Company__c=:compId];
   }
   public List<UC_Role__c> getUcrolesWithgrps(String eventId){
     return [SELECT Id, BLN_Group__c, GN_User__r.Email__c FROM UC_Role__c Where Event__c = :eventId AND (BLN_Group__r.Owner.Username = :UserInfo.getUserName() OR GN_User__r.Email__c = :userInfo.getUserName())];
   }
   
  public List<UC_Role__c> getUcroles(String eventId){
    return [SELECT BLN_Group__c from UC_Role__c WHERE Event__c=:eventId AND BLN_Group__c!=null AND RoleId__r.Name='BoothLeads Admin' AND GN_User__r.Email__c=:UserInfo.getUserName()];
  }
  public List<UC_Role__c> getUcroles(String eventId,SET<String> gpIds){
    return [SELECT GN_User__r.User__c  from UC_Role__c WHERE Event__c=:eventId AND BLN_Group__c IN :gpIds];
  }
   
}