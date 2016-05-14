@RestResource(urlMapping='/UpdateUserWithFCID/*')
 /**
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * Phone : 9550710718
 * AIM   : Map user with his FaceBook Id
 */
 global without sharing class UpdateUserWithFCID{
 static string faceBookId;
 static string userid ;
 
 @httpGET
 global static inncls doGet(){
 
 RestRequest req = RestContext.request;
 RestResponse res = RestContext.response;
 faceBookId =req.params.get('fbId');
 system.debug('ffffffbbbbbbbb'+ userid );
 userid =req.params.get('uId');
 system.debug('uuuuusssssssssseerrrrrrrr'+ userid );
 try{
 user users =new user();
 users =[select id,email,username,FaceBookId__c from user where userName=:userid limit 1];
   if(faceBookId!=null & faceBookId!=''){
   users.FaceBookId__c =faceBookId ;
   update users;
   inncls inn = new inncls('Insert Success'); 
   return  inn;
   }else{
   inncls inn = new inncls('Insert Fail'); return  inn;
   }
  
  }catch(exception e) { inncls inn = new inncls('Insert Fail'); return  inn; }
 }
 
 
 global class inncls{
 public string StatusMsg {get;set;}
 public inncls(string err){StatusMsg =err;}
 
 }
 
 
 
}