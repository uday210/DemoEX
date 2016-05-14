public without sharing class BLN_CreateEventstaff_BAL{
    public contact con {get ; set ;}
    public User Us {get ; set ;}
    public UC_Role__c Ucrole {get ; set ;}
    
    
    public User creatingUser(User newu,Company__c comp){
    BLN_User_DAO blnUserInfo = new BLN_User_DAO();
    Us = blnUserInfo.checkUser(newu.Email);
    
    if(Us.id == null){
    system.debug(':::::::::::::::::NEW USER ::::::::::::::::::::::::');
    USER U = new User();
    con = new contact();
    con.LastName = newu.LastName;
    con.FirstName = newu.FirstName;
    con.Email = newu.Email;
    string conta = blnUserInfo.account_Contact(con);
     system.debug(':::::::::::::::::NEW USER ::::::::::::::::::::::::'+conta);
    u.UserName = newu.Email;
    Profile P = [SELECT Id,Name FROM Profile WHERE Name = 'Attendee'];
    
    U.ContactID =conta;    
    U.Username = newu.email;  
    U.Email = newu.email;
    U.LastName = newu.LastName;
    U.FirstName = newu.FirstName;
    U.CompanyName = comp.Name;
    U.Phone= newu.Phone;
    U.Alias = 'EAdmin';
    U.ProfileID = P.id;
    U.Eff_Date__c=system.today();
    U.LocaleSidKey = 'en_US';
    U.LanguageLocaleKey = 'en_US';
    U.TimeZoneSidKey = 'America/Los_Angeles';
    U.EmailEncodingKey='UTF-8';
    U.CommunityNickname = String.valueOf(math.random());
    BLN_StatusMessage Ustatus = blnUserInfo.createUser(u);
    //User uin=[SELECT id,name,UserName from User where id =: Ustatus.successId];
    US=u;
    system.debug('======================New user============='+Ustatus );
    }
    return Us; 
    }
    public string creategnuser(User Gu){
    GN_User__c GNUS = new GN_User__c ();
    GNUS.First_Name__c = Gu.FirstName;
    GNUS.Last_Name__c = Gu.LastName;
    GNUS.Email__c = Gu.Email;
    //GNUS.Phone__c = Gu.Phone;
    GNUS.User__c =Gu.id;
    //GNUS.Company_Name__c =Gu.CompanyName ;    
    BLN_Gnuser_DAO GnDao = new BLN_Gnuser_DAO ();
     string gid = GnDao.InsertGNUser(GNUS); 
    return gid;
    }
    public Company__c companyinsert(Company__c comp){
    system.debug('ssssssssssssssssssssssssssssssss-----status'+comp);
    BLN_Company_DAO compdao = new BLN_Company_DAO();
    Company__c compexist = compDao.checkCompany(comp.Name);
    system.debug('ssssssssssssssssssssssssssssssss-----compexist '+compexist );
    BLN_StatusMessage status = new BLN_StatusMessage();
        IF(compexist.id == null){
           status   = compdao.insertCompany(comp);
           system.debug('ssssssssssssssssssssssssssssssss-----status'+status);
          return comp;
          }else{
          Company__c compan = [SELECT Id,Name from Company__c where id =:compexist.id];
          return compan ; 
          }
    }
    public UC_Role__c UcerRole(User U,string gnid ,String rolename,Company__c com,string eveid){
         BLN_UCRole_DAO createUcRole= new  BLN_UCRole_DAO();
         Ucrole = new UC_Role__c();
         //Ucrole.GN_User__c = gnid;
         Ucrole.Company__c = com.id;
         Ucrole.Event__c = eveid;
         system.debug('====================:::::successId::::======='+Ucrole);
         BLN_StatusMessage statusUCRole = createUcRole.insertUCRole(Ucrole,rolename);         
         system.debug('====================:::::successId::::======='+statusUCRole);
         //LIST<UC_Role__c> UCRoleList = [SELECT id FROM UC_Role__c WHERE id =: statusUCRole.successId];
         if(statusUCRole.successId != null){
         LIST<UC_Role__c> UCRoleList  = [SELECT id FROM UC_Role__c WHERE id =: statusUCRole.successId];
         return UCRoleList[0]; 
         }else{
         return null;
         }
     }
    //To collet the event staff details of a selected Event
    public LIST<UC_Role__c> eventstaff(string eventid){
    BLN_UCRole_DAO staff = new BLN_UCRole_DAO();
    LIST<UC_Role__c> evestaff = staff.eventstaffvals(eventid);
    return evestaff;
    }
     public UC_Role__c editUC(id UCid){
    BLN_UCRole_DAO editUcrole = new BLN_UCRole_DAO ();
    UC_Role__c UCR = editUcrole.getUCRole(UCid);
    return UCR;
    
    }
    public USER editUser (id UId){
    BLN_User_DAO Userdao = new BLN_User_DAO();
    USER EUS = Userdao.getUser(UId);
    return EUS;
    }
    public Company__c editcomp(id compid){
    BLN_Company_DAO Editcompdao = new BLN_Company_DAO();
    Company__c cmp = Editcompdao.queryCompany(compid);
    return cmp;
    }
}