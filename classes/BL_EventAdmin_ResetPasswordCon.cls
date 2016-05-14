public with sharing class BL_EventAdmin_ResetPasswordCon {
  public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}        
    public pageReference success{get;set;}
    public boolean booleanforDisplayBoothadminTab {get;set;}
    Public user LoginUser {get;set;}
    public string EventId{get;set;}


public BL_EventAdmin_ResetPasswordCon()
{
 EventId = apexpages.currentpage().getparameters().get('id');
 LoginUser = [select id,Password__c from User where id=:userinfo.getuserid()];
//
/**
List<User_Profile_Event__c> BoolforDisplayBoothadminTab = new List<User_Profile_Event__c>();

BoolforDisplayBoothadminTab = [select Profile_id__c,Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:UserInfo.getUserNAme()];
for(User_Profile_Event__c ty:BoolforDisplayBoothadminTab ){
if(ty.Profile_id__r.PR_Name__c =='BoothAdmin'){
booleanforDisplayBoothadminTab =true;
}
}
*/
}

public PageReference changePassword() {
   system.debug('@@@@@'+newPassword+'  '+verifyNewPassword+'   '+oldpassword);    
 success =Site.changePassword(newPassword, verifyNewPassword, oldpassword);       
system.debug('++++++'+success);       
 if(success != null){         
  Id loggedid = UserInfo.getUserId();
          
  User Us =[select id,password__c from User where id=:loggedid];
  Us.password__c = newPassword;
  Update Us;
     
  Pagereference pg = new Pagereference('/apex/BL_Eventadmin_Profile?id='+EventId);  
  pg.setredirect(true);
  return pg;  
 }       
 return null;
}
 
public PageReference Back() {
 Pagereference pg = new pagereference('/apex/BL_Eventadmin_Profile?id='+EventId);
 pg.setredirect(true);
 return pg;
}

    
public PageReference checkUserId() {       
 if(userInfo.getUserType()=='guest'){
  Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
  pg.setredirect(true);
  return pg;
 }
 else{
  return null;
 }           
}


}