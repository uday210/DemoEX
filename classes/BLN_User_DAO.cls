public without sharing class BLN_User_DAO{
   
    //Inserting contact when inserting an User
    public string account_Contact(contact con){
        Account acc = [select id from account where owner.userRoleId !=null limit 1];
        con.AccountID = acc.id;
        dataBase.saveresult savereq = DataBase.insert(con,false);
        system.debug('cccccccccccccccccccccccccccccccccccccc'+savereq );
        if(savereq.isSuccess()){
        system.debug('111111111111111111111111');
            return savereq.getId();
        }else{
        system.debug('2222222222222222222222222222222');
            return null;
        }
    
    }
    
    // Return contacts
    public List<contact> conList(List<id> conids){
        return [select id,firstname,lastName,Email from contact where id in :conids];
        
    }
    
    
    public List<user> getusers(List<id> ids){
         return [select id,email,userName from user where id In :ids];
    }
    
    
    
     //Inserting contact when inserting an User
    public List<id> account_Contact(List<contact> con){
        Account acc = [select id from account where owner.userRoleId !=null limit 1];
      for(contact c :con){
         c.AccountID = acc.id;
      }
        dataBase.saveresult[] savereqList = DataBase.insert(con,false);
        
        List<id> successConids = new List<id>();
        for(dataBase.saveresult savereq : savereqList){
         if(savereq.isSuccess()){
          successConids.add(savereq.getId());
        }
      }
      return successConids;    
    }
    
    
    // To know users Exists Or Not 
    public List<user>  checkUsersWExists(SET<string> emails){
        return [select id,username,firstname,lastname,email,companyName,MobilePhone,Title from user where userName In :emails];
    }
    
    
    //Inserting User
    public BLN_StatusMessage createUser(user u){
    system.debug('Deeeebbbuuggggggggg'+u.firstname);
        dataBase.saveResult saveRes = dataBase.insert(u,false); 
        system.debug('Deeeebbb--------'+saveRes );
        return new BLN_StatusMessage(saveRes);
    
    }
    
    
    // This method is used for fetching User Details, Input Parameter is Email
    public user checkUser(String Email){
        LIST<User> Users = [SELECT id,Username,Title,phone,CompanyName,Firstname,Lastname,Email,isActive,IsSignUp__c,Password__c
                            FROM User 
                            WHERE Username =: Email 
                             ];
        if(users.size()>0){
            return users[0];
        }else{
            return new user();
        }
    }
    
    // This method is used for fetching User Details, Input Parameter is Email
    public user checkLoggedInUser(String Email,String Password){
       PageReference pgr = site.login(Email,Password,'/apex/phanisample');
       System.debug('OOOOOOOOOOOOOOOOOOo '+pgr);
    
        LIST<User> Users = new List<user>();
         if(null!=pgr){ 
                 users =  [SELECT id,Username,Firstname,Lastname,Email,isActive,IsSignUp__c,Password__c
                            FROM User 
                            WHERE Username =: Email 
                            AND isActive = TRUE 
                            AND IsSignUp__c = TRUE];
          }
        if(users.size()>0){
            return users[0];
        }else{
            return new user();
        }
    }
    
    // This method is used for fetching User Details, Input Parameter is userId
    public user getUser(String UserId){
        LIST<User> Users = [SELECT id,Username,Firstname,Lastname,Email,isActive,IsSignUp__c FROM User 
                            WHERE Id =: UserId
                            AND isActive = TRUE];
        if(users.size()>0){
            return users[0];
        }else{
            return new user();
        }
    }
    
    
    // This method is for updating user
    public string updateUser(user u){
    
        //Update user
        user updateuser = [SELECT id,Username,Firstname,Lastname,Email,isActive,IsSignUp__c 
                            FROM User 
                            WHERE Username =: u.Email 
                            AND isActive = TRUE];
                            
        updateuser.FirstName=u.FirstName;
        updateuser.LastName=u.LastName ;
        updateuser.title=u.title;
        updateuser.phone=u.phone;
        
        database.update(updateuser);    
        
        return updateuser.id;
    }

    public BLN_StatusMessage insertUserBulk(List<user> users){
        DataBase.Saveresult[] savedRes = database.insert(users,false);
        return new BLN_StatusMessage(savedRes);
    }
    
    public BLN_StatusMessage  updateuserBulk(List<user> ulistforupdate){
        dataBase.saveResult[] userUpresult = DataBase.update(ulistforupdate,false);
        return new BLN_StatusMessage(userUpresult);
    }
    
    public BLN_StatusMessage insertGNUser(GN_User__c GNUser){
        DataBase.Saveresult Response = database.insert(GNUser,false);
        return new BLN_StatusMessage(Response);
    }
    
    public BLN_StatusMessage cloneGNUser(String UserId){
        GN_User__c User = [SELECT id,First_name__c,Last_name__c,Email__c,Home_Phone__c,User__c
                                   FROM GN_User__c 
                                   WHERE Id =: UserId];
        GN_User__c GN_User = User.clone(false, true);                          
        DataBase.Saveresult Response = database.insert(GN_User,false);
        return new BLN_StatusMessage(Response);
    }
    
    // This method is used for fetching User Details, Input Parameter is userId
    public GN_User__c getGNUser(String UserId){
        LIST<GN_User__c> Users = [SELECT id,First_name__c,Last_name__c,Email__c,Home_Phone__c,User__c
                                   FROM GN_User__c 
                                   WHERE Id =: UserId];
        if(users.size()>0){
            return users[0];
        }else{
            return new GN_User__c();
        }
    }

}