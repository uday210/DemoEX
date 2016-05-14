public without sharing class BLN_User_SignUP_BAL{
 
  public string CheckUserEmailExists(string fn,string ln,string email,string com,string pass){
     boolean checKuserExistsbool =false;
     
      BLN_User_DAO blnuserDao = new BLN_User_DAO();
      user user = new user();
      user = blnuserDao.CheckUser(email);
      
    
      if(user.id!=null){
           if(user.isSignup__c==true){
            return 'Your username already exists in the system!';
             
           }else{
              try{
               user.isActive=true;
               user.IsSignUp__c =true;
               DataBase.update(user,false);                system.setPassword(user.id,pass);
                //updateUserStatus(user.id,pass); 
                 return 'Success';
               }catch(exception ex){
                 return ex.getMessage();
                   //'Password should not contain your partial name or email address';
              }       
           }  
        }else{
        Savepoint sp = Database.setSavepoint();

            contact Con = new Contact();
            Con.Lastname = fn;
            Con.Firstname =ln; 
            con.email = email;
           
            string contactId = blnuserDao.account_Contact(con);
            
            Profile P = [SELECT Id,Name FROM Profile WHERE Name = 'Attendee'];
            user u = new user();
            U.ContactID =contactId;    
            U.Username = email;  
            U.Email = email;
            U.LastName = fn;
            U.FirstName = ln;
            U.CompanyName = com;
            U.Alias = 'EAdmin';
            U.ProfileID = P.id;
            U.CommunityNickname = String.valueOf(math.random());
             U.Eff_Date__c=system.today();
           U.isActive =true;
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'GMT';
            U.EmailEncodingKey='UTF-8';
            u.isSignup__c =true;
           // string msg = blnuserDao.createUser(u);
            BLN_StatusMessage userMsg = blnuserDAO.createUser(u);
               
             system.debug('KKKKKKKKKKKKKKKKKKKKKK '+userMsg );
               system.debug('SSSSSSSSSSSS '+pass);
              try{
                 system.setPassword(userMsg.successId ,pass);
                system.debug('Site Login Status'+ Site.login(email , pass, '/apex/BLN_UserEvents'));
                 // updateUserStatus(userMsg.successId,pass); 
                }catch(exception ex){
                  Database.rollback(sp);
                  return ex.getMessage(); //'Password should not contains name and username';
              }  
              
                BLN_UCRole_DAO companyRole = new BLN_UCRole_DAO();
                BLN_Gnuser_DAO gnDao = new BLN_Gnuser_DAO();
                GN_User__c gnUser = new GN_User__c();
                gnUser.first_Name__c = fn;
                gnUser.Last_Name__c = ln;
                gnUser.Email__c = email;
                gnUser.user__c = userMsg.successId;
                string gnid = gnDao.InsertGNUser(gnUser);
                
                BLN_Company_DAO blnCompanyDAO = new BLN_Company_DAO();
                 
               string comId='';
               Company__c comp = new Company__c();
               
              if(userMsg.successBool){
                  if(com !=null && com!=''){
                     comp.Name = com;
                     string iscompexist = '';
                     iscompexist  = checkCompany(com,email);
                    if(iscompexist  !=''){
                       comId  = iscompexist ;
                    }else{
                        
                      //BLN_StatusMessage comId1 = blnCompanyDAO.insertCompany(comp);
                      // comId = comId1.successId;
                      comId = createBtypeCompanyAndUcrole(comp,gnid);
                     } 
                     
                      /*UC_Role__c uRole = new UC_Role__c();
                        uRole.Company__c = comId;
                        uRole.GN_User__c =gnid;
                        uRole.user_Type__c = 'Business';
                        BLN_StatusMessage ucRoleId1 = companyRole.insertUCRole(uRole, 'Company Admin');
                        String ucRoleId = ucRoleId1.successId;
                        system.debug('222222222Company CReated Successs       '+ ucRoleId);
                     */
                     
                     
                  } else{
                   string isperaccexist ='';
                   isperaccexist = checkPersonalAccount(email) ;
                   system.debug('222222222Company CReated Successs      333333333 '+isperaccexist );
                     if(isperaccexist =='' ){
                        //comp.name =fn+ln;
                        //BLN_StatusMessage comId1 = blnCompanyDAO.insertCompany(comp);
                        //comId = comId1.successId;
                        comId=createPtypeCompanyAndUcrole(gnid,fn,ln); //calling for creating personal type company
                       }else{
                        comId =isperaccexist ;
                     }
                     
                     
                      /* UC_Role__c uRole = new UC_Role__c();
                        uRole.Company__c = comId;
                        uRole.GN_User__c =gnid;
                        uRole.user_Type__c = 'Personal';
                        BLN_StatusMessage ucRoleId1 = companyRole.insertUCRole(uRole, 'Company Admin');
                        String ucRoleId = ucRoleId1.successId;
                        system.debug('222222222Company CReated Successs       '+ ucRoleId);
                     */
                  }      
                 
                List<GN_User__c> GnUserforupdateComp = new List<GN_User__c>();
                 for(GN_User__c gc : [select id,Default_Company_ID__c from  GN_User__c  where id=:gnid ]){
                    gc.Default_Company_ID__c = comId; 
                    GnUserforupdateComp.add(gc);
                 }
                database.update(GnUserforupdateComp,false);
                return 'success';
                    
              }else{
                  Database.rollback(sp);
                  return userMsg.errors ;
              }
              
              
              // blnuserDao.createUser(u);
             
       }  
      
   }
   
   /********This method is Used for creating "P" type company for GNUser,written by Purna *******************************/
   
     public static string createPtypeCompanyAndUcrole(string gnid,string fn,string ln) {   
           
            Company__c  compnme = new Company__c();
            string comId='';
            compnme.name = fn + ln ;
            BLN_Company_DAO blnCompanyDAO = new BLN_Company_DAO();
            BLN_UCRole_DAO companyRole = new BLN_UCRole_DAO();
            BLN_StatusMessage comId1 = blnCompanyDAO.insertCompany(compnme); 
            comId = comId1.successId;
            UC_Role__c uRole = new UC_Role__c();
            uRole.Company__c = comId;
            uRole.GN_User__c = gnid;
            uRole.user_Type__c = 'Personal';
            BLN_StatusMessage ucRoleId1 = companyRole.insertUCRole(uRole, 'Company Admin');
            String ucRoleId = ucRoleId1.successId;
            system.debug('222222222Company CReated Successs       ' + ucRoleId);
            return comId;
         
     }
     
     
    /********This method is Used for creating "B" type company for GNUser,written by Purna ********************/  
     
     public static  string createBtypeCompanyAndUcrole(Company__c compdetails,String gnid) {  
     
            string comId='';           
            BLN_Company_DAO blnCompanyDAO = new BLN_Company_DAO();
            BLN_UCRole_DAO companyRole = new BLN_UCRole_DAO();
            BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();            
            BLN_StatusMessage comId1 = blnCompanyDAO.insertCompany(compdetails); 
            comId = comId1.successId;         
            UC_Role__c uRole = new UC_Role__c();
            uRole.Company__c = comId;
            uRole.GN_User__c = gnid;
            uRole.user_Type__c = 'Business';            
            BLN_StatusMessage ucRoleId1 = companyRole.insertUCRole(uRole, 'Company Admin');
            String ucRoleId = ucRoleId1.successId;
            system.debug('222222222Company CReated Successs       ' + ucRoleId);
            return comId;
         
     }

   @future
     public static void updateUserStatus(string userId,string pass){
      system.debug('GGGGGGGGGGGGGGGGGGGGGG   '+userId);
        User user = [SELECT id,IsSignUp__c,isActive,password__c FROM User WHERE id=:userId];
        system.debug('AAAAAAAAAAAAAAAAA '+user );
        
        try{
           user.IsSignUp__c =true;
            
        user.isSignup__c =true;    
        user.isActive = true;
        database.update(user,false);
        }catch(exception er){
             
        }
        
     } 
  
    public string checkCompany(string cname,string uEmail){
              LIST<UC_Role__c> UCRoleList = [SELECT id,Company__c,Company__r.id FROM UC_Role__c WHERE GN_User__r.Email__c =:uEmail and Company__r.Name=:cname and RoleId__r.Name='Company Name'];
              system.debug('PPPPPPPPPPPPPp '+UCRoleList +'PPPPPPPPPPPP '+cname+'PPPPPPPPPPP '+uEmail );
              if(UCRoleList.size()>0){
                return UCRoleList[0].Company__r.id;
              }else{
                 return '';
              }
        
            }
      public string checkPersonalAccount(string uEmail){
            LIST<UC_Role__c> UCRoleList = [SELECT id,Company__c,Company__r.id FROM UC_Role__c WHERE GN_User__r.Email__c =:uEmail and User_Type__c='Personal'];
            if(UCRoleList.size()>0){
                return UCRoleList[0].Company__r.id;
              }else{
                 return '';
              }
          }      
    
}