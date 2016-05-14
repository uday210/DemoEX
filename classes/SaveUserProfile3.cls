@RestResource(urlMapping='/SaveUserProfile3/*')

/*
 * AUTHOR : Phani
 * Email :  phani@globalnest.com
 * AIM :    To update the User information from the mobile  clients
 ***/  
 
            global without Sharing class SaveUserProfile3{
    
            global static List<UserInfo> UserInfos = new List<UserInfo>();
            global static UserInfo UserInfoDetails = new UserInfo();
            global Static list<String> userInfostr =  new list<String>();
            global static User LoginUser  = new User();
            global static AttendeeSummary__c  AttSummary= new AttendeeSummary__c();
            
            global static Attachment attachOne= new  Attachment();
            @HttpPost
            global static UserInfo doPost(){
               RestRequest req = RestContext.request;
               RestResponse res = RestContext.response;
               
                system.debug('Request Recevied From mobile App'+req);
               
               String UserId= req.params.get('UserID');
               Blob reqbody = req.requestBody;
               
               String UserProfile= reqbody.toString();
               //String UserProfile= req.requestBody.tostring();
               system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+UserProfile);
   
               // String UserProfile= req.headers.get('UserProfile');
                String Firstname;
                String Lastname;
                String Email;
                
                //String UserProfile ='[{"FirstName":"Ap","LastName":"S","Company":"James","City":"soi.venkatesh@gmail.com","State":"India","Phoneno":"Hyd"}]';
                
                JSONParser Parser = JSON.createParser(UserProfile);
                 While(parser.nextToken()!= null){
                   if(Parser.getCurrenttoken() == JSONToken.START_ARRAY){
                     while(parser.nextToken() != null){
                       if(parser.getCurrenttoken() == JSONToken.START_OBJECT){
                     UserInfoDetails  = (SaveUserProfile3.UserInfo)parser.readValueAs(SaveUserProfile3.UserInfo.class);}     
               //system.debug('1111111111111 '+UserInfoDetails  );
            }}}

                LoginUser = [select Username,id,firstName,LastName,Email,CompanyName,Phone,City,State from User where id=:UserId];
                AttSummary =[Select id,AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_CellPhone__c,AS_WorkPhone__c,AS_HomeCity__c,AS_HomeState__c from AttendeeSummary__c where   AS_Email__c=:LoginUser.Email];
                 
                Firstname = LoginUser.firstName;
                Lastname  = LoginUser.LastName; 
               email= LoginUser.userName;
                if(!(String.isEmpty(UserInfoDetails.firstName))){
                 LoginUser.firstName= UserInfoDetails.firstName;
                 AttSummary.AS_FirstName__c =UserInfoDetails.firstName;
                 Firstname  =  UserInfoDetails.firstName;
                 }
               
               if(!(String.isEmpty(UserInfoDetails.LastName))){
                  LoginUser.Lastname = UserInfoDetails.LastName;
                  AttSummary.AS_LastName__c =UserInfoDetails.LastName;
                  Lastname = UserInfoDetails.LastName;
                  } 
                 
                 if(!(String.isEmpty(UserInfoDetails.Company))){
                 
                  LoginUser.CompanyName=UserInfoDetails.Company;
                  AttSummary.AS_Company__c = UserInfoDetails.Company;
                  }
                 
                 if(!(String.isEmpty(UserInfoDetails.City))){
                 
                  LoginUser.City = UserInfoDetails.City;
                  AttSummary.AS_WorkCity__c= UserInfoDetails.City;                
                 }
                 
                 system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+UserInfoDetails.Title);
                 if(!(String.isEmpty(UserInfoDetails.Title))){
                    AttSummary.AS_Title__c= UserInfoDetails.Title;                
                 }
                 
                 
             if(!(String.isEmpty(UserInfoDetails.State))){    
                 
                 LoginUser.States__c= UserInfoDetails.State;
                 AttSummary.AS_Work_States__c= UserInfoDetails.State;
                 
                 }
                 
                 if(!(String.isEmpty(UserInfoDetails.Phoneno))){  
                  LoginUser.Phone= UserInfoDetails.Phoneno;
                  AttSummary.AS_WorkPhone__c= UserInfoDetails.Phoneno;
                  }
                
                if(!(String.isEmpty(UserInfoDetails.Country))){
                
                LoginUser.Country__c = UserInfoDetails.Country;
                AttSummary.AS_Work_Country__c= UserInfoDetails.Country;
               }   
               AttSummary.AS_uniqueField__c = String.valueOf(FirstName+LastName+LoginUser.email).toLowerCase();
                try{
                
                System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@beforeUpdate'+LoginUser);
                 //update LoginUser;
                 Database.saveResult  updateLoginUser = Database.update(LoginUser);
                  System.debug('DDDDDDDDDDDDDDDDDDDD'+updateLoginUser );
                 Database.saveResult  updateAttSummary = Database.update(AttSummary);
                  System.debug('FFFFFFFFFFFFFFFFFFFFFFFFFFFFF '+updateAttSummary );
                //update AttSummary;
                 
                 System.debug('FFFFFFFFFFFFFFFFFFFFFFFFFFFFF 1111111111111'+UserInfoDetails.ImageUrl);
                 
                 //if(updateAttSummary.isSuccess() == true && !(String.isEmpty(UserInfoDetails.ImageUrl))){
               if(!(String.isEmpty(UserInfoDetails.ImageUrl))){       
                 Id filderId;
                 List<Folder> docs =[Select f.Type, f.SystemModstamp, f.NamespacePrefix, f.Name, f.LastModifiedDate, f.LastModifiedById, f.IsReadonly, f.Id, f.DeveloperName, f.CreatedDate, f.CreatedById, f.AccessType From Folder f where Name='shared documents'limit 1];
                 if(docs.size()>0){
                   filderId=docs[0].id;
                  }
                      
                   Document UserImageDoc = new Document();
                   UserImageDoc.Body = EncodingUtil.base64Decode(UserInfoDetails.ImageUrl);
                   UserImageDoc.FolderId =filderId;
                   
                   if(UserInfoDetails.ImageUrl!=null && UserInfoDetails.ImageUrl!=''){
                   List<document> docs12 =[select id from document where name =:email+'.jpeg'];
                   delete docs12;
                    UserImageDoc.Name = email+'.jpeg'; 
                  }
                  
                   UserImageDoc.IsPublic =true;
                   Database.SaveResult UseImageSaveresult =  Database.insert(UserImageDoc);
                  System.debug('FFFFFFFFFFFFFFFFFFFFFFFFFFFFF 122222222222'+UseImageSaveresult.getId());
                 
                   
                   if (UseImageSaveresult.isSuccess()== True){                
                    AttSummary.AS_ImageUrl__c = UseImageSaveresult.getId();
                    Database.update(AttSummary);
              }
                    
            }
               
                if(updateAttSummary.isSuccess()){        
                 UserInfo Uin = new UserInfo();
                 Uin.Message ='Updated Successfully';
                 return Uin; 
               }    
          //}
                   
   }
                 
                 
                 
                
                catch(Exception ex){
                
                system.debug('@@@@@@@@@@@@@@@@'+ex.getmessage());
                UserInfo Uin = new UserInfo();
                 Uin.Message ='Update Failed';
                 return Uin; 
                
                }
                 return null; 
                
                }
                
                
                global class UserInfo{
                global String Message;
                global string Title;
                global String FirstName;
                
                global String LastName;
                
                global String Company;
                
                global String City;
                global string email;
                global String State;
                
               global  String Phoneno;
                
               global  String UserImage;
                
               global  String ImageUrl;
                
               global  String Country;
              
                                
                }
                
  }