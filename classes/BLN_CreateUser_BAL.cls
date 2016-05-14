public without sharing class BLN_CreateUser_BAL{
 
  public string CheckUserEmailExists(user u,Company__c comp,Company_Ext__c comext){
     boolean checKuserExistsbool =false;
     
     BLN_User_DAO blnuserDao = new BLN_User_DAO();
      user user = new user();
      user = blnuserDao.CheckUser(u.email);
      
    
      if(user.id!=null){
           
              return 'Your username already exists in the system!';
           
        }else{
            contact Con = new Contact();
            Con.Lastname = u.FirstName;
            Con.Firstname =u.LastName; 
            con.email = u.email;
            string contactId = blnuserDao.account_Contact(con);            
            Profile P = [SELECT Id,Name FROM Profile WHERE Name = 'Attendee'];
            U.Alias = 'EAdmin';
            U.ProfileID = P.id;
            U.ContactID = contactId ;
            U.CommunityNickname = String.valueOf(math.random());
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'America/Los_Angeles';
            U.EmailEncodingKey='UTF-8';
            U.Username = u.email;
            U.Email = u.Email;
           // string msg = blnuserDao.createUser(u);       
            BLN_StatusMessage userMsg = blnuserDAO.createUser(u);
            
            //BLN_Debug.log('BLN_User_SignUP_BAL','createUser ','User Created',userMsg.errors);
            if(userMsg.successBool){                  
               if(u.companyName != null && u.companyName !=''){
                  comp.Name = u.companyName;
                }else{
                   comp.Name = u.FirstName+u.LastName;
                }       
            BLN_Company_DAO blnCompanyDAO = new BLN_Company_DAO();//----REference of DAO class                
            String comId = blnCompanyDAO.insertCompany(comp).successid;//---To insert Company calling DAO class
 
            blnCompanyDAO.insertcompdetails(comId,comext);//---------To insert company details in company extention calling DAO class
            BLN_UCRole_DAO companyRole = new BLN_UCRole_DAO();
            UC_Role__c uRole = new UC_Role__c();
            uRole.Company__c = comId;
            //uRole.User__c =userMsg.successId;
            String ucRoleId = companyRole.insertUCRole(uRole, 'Company Admin').successid;

           return ucRoleId;
                
          }else{
              return userMsg.errors ;
          }
          
          
          // blnuserDao.createUser(u);
             
       }  
      
   }
   
     
   @future
     public static void updateUserStatus(string userId,string pass){
        User user = [SELECT id,IsSignUp__c,isActive,password__c FROM User WHERE id=:userId];
        user.IsSignUp__c =true;
            if(pass!=null && pass!=''){
              user.password__c = pass;
            }
        user.isActive = true;
        update user;
     } 
  
   
}