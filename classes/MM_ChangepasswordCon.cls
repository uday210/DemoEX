public class MM_ChangepasswordCon {

    public String oldPassword{get; set;}
    public String newPassword{get; set;}
    public String VerifyNewPassword{get; set;}
    //public User userIn{get; set;}
    public User_Profile_Event__c userIn{get; set;}
    public String urlReturn{get; set;}
    
    public Boolean boothBool{get; set;}
    public Boolean eventBool{get; set;}
    public Boolean attBool{get; set;}
    
    Public String SelectEvent{get;set;}
   
    
   public MM_ChangepasswordCon(){
       //userIn = new User();
       userIn = new User_Profile_Event__c();
       
       Cookie k = ApexPages.currentPage().getCookies().get('counter');
            
            SelectEvent = k.getValue();
            
            system.debug('sssssssssselectedevent'+SelectEvent);
            system.debug('uuuuuuuuuuuuuuuuuuu'+UserInfo.getUserId());
            
          // userIn = [SELECT ID, NAME, password__c,Profile.Name FROM User Where ID=: UserInfo.getUserId()];
           userIn = [SELECT ID, NAME, User_id__r.password__c, Profile_id__r.PR_Name__c FROM User_Profile_Event__c Where EV_id__r.id=:SelectEvent  AND User_id__r.ID =: UserInfo.getUserId()];
       
          system.debug('xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'+userIn.User_id__r.password__c);
          system.debug('PPPPPPPPPPPPPPPPPPPPPPPProfile     '+userIn.Profile_id__r.PR_Name__c);
          
          attBool = FALSE;
          boothBool = FALSE;
          eventBool = FALSE;
          
      
        /* if(userIn.Profile.Name.containsIgnoreCase('event')){
              eventBool = TRUE;
          }else if(userIn.Profile.Name.containsIgnoreCase('booth')){
              boothBool = TRUE;
          }else if(userIn.Profile.Name.containsIgnoreCase('attende'))
              attBool = TRUE;*/
         if(userIn.Profile_id__r.PR_Name__c.containsIgnoreCase('event')){
              eventBool = TRUE;
          }else if(userIn.Profile_id__r.PR_Name__c.containsIgnoreCase('booth')){
              boothBool = TRUE;
          }else if(userIn.Profile_id__r.PR_Name__c.containsIgnoreCase('attende'))
              attBool = TRUE;     
       
       urlReturn = '';
       try{
           urlReturn = apexpages.currentpage().getparameters().get('urlreturn');
       }catch(Exception e){ }
       
   } 
    
    public Pagereference changePassword(){
        try{
    pageReference success ;
      // return Site.changePassword(newPassword, verifyNewPassword, oldpassword);    
     success  = Site.changePassword(newPassword, verifyNewPassword, oldpassword);  
     
     
     if(success!=null ){    
      Id loggedid = UserInfo.getUserId();
       User Us =[select id,password__c from User where id=:loggedid];
       Us.password__c = newPassword;
       Update Us;
      
        Profile p = [SELECT id, NAME FROM Profile WHERE NAME =:'Event Admin' ];
      
      system.debug('hiiiiiiiiiiiiiiiiiiiiiiiii '+p ); 
      
       if(userInfo.getProfileId()== p.id){
             
       Pagereference pg = new Pagereference('/apex/Matchleads_Eventspage');
       pg.setredirect(True); 
       return pg;
      }else {
        system.debug('22222222222222222222222222 ' ); 
       Pagereference pg = new Pagereference('/apex/Matchleads_Eventspage');
       pg.setredirect(True); 
       return pg;
      
      } 
      
           
 }else{
 return null;
 }
 
        
   }catch(exception ex){
    
      
    
    
    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
    Apexpages.addMessage(myMsg);
     return null;
    
   
    }  
   
       
    }
    
    public Pagereference CheckUser(){
       
       Pagereference pg = MM_Utility.checkLogInservice();
       
       return pg;
       
   }
    
}