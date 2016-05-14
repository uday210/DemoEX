@RestResource(urlMapping='/BLN_ASC_ChangePassword/*')

  global without sharing class BLN_ASC_ChangePassword{
        global static string Message;
      @HttpGet
      global static string doGet(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string UserId= req.params.get('UserId');
        string Password= req.params.get('Password');
        List<user> users = new List<user>();
        
         
        users =[select id,password__c,profile.name,IsActive from user where id=:UserId];
        If(users.size()>0){
        users[0].password__c =Password;
        users[0].IsActive =true;
         users[0].IsSignup__c=true;
        dataBase.saveResult saveres = dataBase.update(users[0],false);
        
        try{
            system.setPassword(UserId,Password);
            Message = 'Success';
          }catch(exception er){
             user u = new user();
             u =users[0];
             u.IsSignup__c=false;
             u.IsActive=false;
             update(u);
             Message  ='A password cannot contain your User Name and cannot match your first or last name'; 
          }    
         
            
             
        } else{
          Message  ='No user found';
        }       
        Return Message;
      }
   }