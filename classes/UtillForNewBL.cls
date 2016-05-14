public without sharing class UtillForNewBL{
/***********************************************************************************************
*   Controller Name : UtillForNewBL 
*   Date            : 07/05/2014
*   Author          : Phani Kumar Ch
*   Purpose         : Utill class
*   Change History  : 07/05/2014 

*   Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   07/05/2014         Phani Kumar Ch                  To Create Page
**************************************************************************************************/
   
// This method is for inserting user
 public string InsertUser(user u,string pass){
 
 user uname=[SELECT Id,CreatedById,isActive FROM User WHERE profile.Name =: 'System Administrator' AND isActive=: true LIMIT 1];
 
            Account acc = new Account();
            acc.name='Booth Leads';    
            acc.ownerId=uname.id; 
            insert acc; 
            
            system.debug('!!!! '+u);
            contact Con = new Contact();
            Con.Lastname = u.firstname;
            Con.Firstname = u.lastname; 
            con.email = u.email;
            Con.AccountID = acc.id;
            insert Con;
            
           Profile P = [SELECT Id,Name FROM Profile WHERE Name = 'Event Admin'];
           U.ContactID = Con.id;    
           U.Username = u.email;  
           U.Alias = 'EAdmin';
           U.ProfileID = P.id;
           U.CommunityNickname = String.valueOf(math.random());
           
            if(pass!=null && pass!=''){
            u.password__c =pass;
            u.isSignup__c =true;
            }
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'America/Los_Angeles';
            U.EmailEncodingKey='UTF-8';
            Database.insert(U);
            return u.id;
 }
 
 // This  Method is for Inserting Comany 
  public string insertCompany(Company__c  com){
   insert  com;
   return com.id;
  }
 
 // This method is for inserting user Company role

  public void insertUC_role(string uId,string cId){
     UC_Role__c uRole = new UC_Role__c();
     uRole.Company__c = cId;
     //uRole.Role__c = 'Company Admin';
    //uRole.User__c =uId;
     insert uRole;
          
  }


/////ADDED BY ARINDAM///////
// This method is for updated user
 public string UpdateUser(user u){
 
 //update user
 user updateuser=[SELECT FirstName,LastName,Email FROM User WHERE Username =: u.Email LIMIT 1];
 updateuser.FirstName=u.FirstName;
 updateuser.LastName=u.LastName ;
 update updateuser;
 
 //update contact
 try
 {
 contact Con = [Select FirstName,LastName,email from contact where email=:u.email]; 
            Con.Lastname = u.firstname;
            Con.Firstname = u.lastname; 
            update con;          
    }catch( Exception e){}        
 
 return updateuser.id;
 }
 
 
 
 // This method is for updating user Company 

  public void updateUC_role(string email,string cId){
  User use=[select id,email from User where email=:email];
  //UC_Role__c updaterole=[select User__c,Company__c from UC_Role__c  where User__c=:use.id limit 1];
     //updaterole.Company__c = cId;
     //update updaterole;
   
          
  }

}