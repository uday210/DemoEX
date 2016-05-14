@RestResource(urlMapping='/RESETPASSWORD3/*')
global with sharing class ResetPassword3 {
global static String username;
global static String oldPassword;
global static String newPassword;
global static User userDetails;
    
@HttpGet
global static PasswordReset doGet(){

RestRequest req = RestContext.request;
RestResponse res = RestContext.response;
System.debug('@@@@@req'+req);
username = req.params.get('Username');
oldPassword = req.params.get('OldPassword');
newPassword = req.params.get('newPassword');



List<user> listOfuser = new List<user>();
listOfuser =[select firstName,LastName,Email,userName,Id,password__c,isActive from user where userName=:username ];
 
 if(listOfuser.size()>0){
 
 System.debug('2222222222222222222222 '+listOfuser[0].password__c);
  System.debug('333333333333333 '+oldPassword );
   if(listOfuser[0].password__c == oldPassword ){
     System.debug('55555555555555555555 ');
     
     if(listOfuser[0].isActive==false){
     System.debug('666666666666666666666666666 ');
       listOfuser[0].isActive=true;   
       database.update(listOfuser[0],false);
      System.setPassword(listOfuser[0].id, newPassword);
      listOfuser[0].isActive=false; 
      listOfuser[0].password__c=newPassword; 
      database.update(listOfuser[0],false);
      
      PasswordReset passwo = new PasswordReset('The password is updated!');
       return passwo; 
      }else{
      System.debug('7777777777777777');
      dataBase.saveResult att;
      try{
       System.setPassword(listOfuser[0].id, newPassword);
       listOfuser[0].password__c=newPassword; 
      
       att = database.update(listOfuser[0],false);
      }catch(exception e){}
      PasswordReset passwo ;
      if(att.isSuccess()){
      System.debug('88888888888888888888 ');
        passwo = new PasswordReset('The password is updated!');
      }else{
        System.debug('999999999999999999999999999 ');
       
       passwo = new PasswordReset(string.valueOf(att.getErrors()[0]));
   
       }
       
      return passwo; 
      }     
    }else{
      PasswordReset passwo = new PasswordReset('The old passwords does not match, Please check once!');
      return passwo;
     }
 }



 return null;  
}   

global Class PasswordReset{
    
String Message;
public PasswordReset(String message1){
 Message = message1;
}  
}
}