public with sharing class BL_ResetPasswordCon {
  public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}        
    public pageReference success{get;set;}
    public boolean booleanforDisplayBoothadminTab {get;set;}
    public user loginuser{get;set;}
    public string EventId{get;set;}

public PageReference login() {
   if(userInfo.getUserType()=='guest'){
    Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
    pg.setredirect(true);
        return pg;
   
   }
   
   List<User_Profile_Event__c> ty =new  List<User_Profile_Event__c>();
      ty=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() and Profile_id__r.PR_Name__c='eventadmin'];
       if(ty.size()>0){
       Pagereference pg = new pagereference('/apex/BL_EventAdmin_Dashboard?id='+EventId );
       pg.setredirect(true);
        return pg;
       
       }else{
       return null;
       }   
      
  }

public BL_ResetPasswordCon(){

EventId = apexpages.currentpage().getparameters().get('id');

LoginUser = [select id,Password__c from User where id=:userinfo.getuserid()];
//userinfo.getuserid()
List<User_Profile_Event__c> BoolforDisplayBoothadminTab = new List<User_Profile_Event__c>();

BoolforDisplayBoothadminTab = [select Profile_id__c,Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:UserInfo.getUserNAme()];
for(User_Profile_Event__c ty:BoolforDisplayBoothadminTab ){
if(ty.Profile_id__r.PR_Name__c =='BoothAdmin'){
booleanforDisplayBoothadminTab =true;
}
}
}

 public PageReference changePassword() {
  system.debug('6666666666666 '+newPassword+verifyNewPassword+oldpassword);
        success =Site.changePassword(newPassword, verifyNewPassword, oldpassword);
       
       system.debug('777777777777777777 '+success );
      if(success != null){
       
        user u =[select password__c from user where id=:userInfo.getUserId() limit 1];
        u.password__c =newPassword;
       update u;
        Pagereference pg = new Pagereference('/apex/BL_Profile?id='+EventId );  
        pg.setredirect(true);
        return pg;  
       }else{
        
        return null;
   }
    } 
    

}