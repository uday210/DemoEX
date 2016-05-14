@RestResource(urlMapping='/SaveUserProfile/*')

/*
 * AUTHOR : Venkatesh 
 * Email :  venkatesh@globalnest.com
 * AIM :    To update the User information from the mobile  clients
 ***/  
 
            global class SaveUserProfile{
    
            global static List<UserInfo> UserInfos = new List<UserInfo>();
            
            global static UserInfo UserInfoDetails = new UserInfo();
            
            global Static list<String> userInfostr =  new list<String>();
            global static User LoginUser  = new User();
            global static AttendeeSummary__c  AttSummary= new AttendeeSummary__c();
            
            global static Attachment attachOne= new  Attachment();
            
            
            
        
            @HttpPost
            global static UserInfo doPost(){
                
               //Request Context
               
             
                RestRequest req = RestContext.request;
                RestResponse res = RestContext.response;
                String UserId= req.params.get('UserID');
    Blob reqbody =req.requestBody;
    String UserProfile= reqbody.toString();
          
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
                     UserInfoDetails  = (SaveUserProfile.UserInfo)parser.readValueAs(SaveUserProfile.UserInfo.class);}     
            }}}

                LoginUser = [select id,firstName,LastName,Email,CompanyName,Phone,City,State from User where id=:UserId];
                AttSummary =[Select id,AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_CellPhone__c,AS_HomeCity__c,AS_HomeState__c from AttendeeSummary__c where   AS_Email__c=:LoginUser.Email];
                 
                Firstname = LoginUser.firstName;
                Lastname  = LoginUser.LastName; 
     
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
                 
             if(!(String.isEmpty(UserInfoDetails.State))){    
                 
                 LoginUser.States__c  = UserInfoDetails.State;
                 AttSummary.AS_Work_States__c= UserInfoDetails.State;
                 
                 }
                 
                 if(!(String.isEmpty(UserInfoDetails.Phoneno))){  
                  LoginUser.Phone= UserInfoDetails.Phoneno;
                  AttSummary.AS_CellPhone__c = UserInfoDetails.Phoneno;
                  }
                
                if(!(String.isEmpty(UserInfoDetails.Country))){
                
                LoginUser.Country__c = UserInfoDetails.Country;
                AttSummary.AS_Work_Country__c= UserInfoDetails.Country;
               }                
                
                  
             
             
             
                 AttSummary.AS_uniqueField__c = String.valueOf(FirstName+LastName+LoginUser.email).toLowerCase();
                 
              
                   
                   /**
                   Document UserImageDoc = new Document();
                   UserImageDoc.Body = EncodingUtil.base64Decode(UserInfoDetails.ImageBlob);
                   UserImageDoc.FolderId ='00l90000001APdg';
                   UserImageDoc.Name = Firstname +' '+Lastname+' Image'; 
                   UserImageDoc.IsPublic =true;
                   Database.SaveResult UseImageSaveresult =  Database.insert(UserImageDoc);
                   
                   if (UseImageSaveresult.isSuccess()== True){                
                    AttSummary.AS_ImageUrl__c = UseImageSaveresult.getId();
                    }
                    **/

                 
                 
                      
                try{
                
                System.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@beforeUpdate'+LoginUser);
                 //update LoginUser;
                 Database.saveResult  updateLoginUser = Database.update(LoginUser);
                  System.debug('DDDDDDDDDDDDDDDDDDDD'+updateLoginUser );
                 Database.saveResult  updateAttSummary = Database.update(AttSummary);
                  System.debug('FFFFFFFFFFFFFFFFFFFFFFFFFFFFF '+updateAttSummary );
                //update AttSummary;
                 
                 if(updateAttSummary.isSuccess() == true && !(String.isEmpty(UserInfoDetails.ImageBlob))){
                      attachOne.Name = LoginUser.id+'Image';
                      attachOne.Body = EncodingUtil.base64Decode(UserInfoDetails.ImageBlob);
                
                      attachOne.ParentId =updateAttSummary.getId();
                      
                      Schema.SObjectField f = Attachment.Fields.Name;
                      
                      Database.upsertResult attachmentUpsert = Database.upsert(attachOne,f,false);
                   
                      
                UserInfo Uin = new UserInfo();
                 Uin.Message ='Update successFully';
                 return Uin; 
                   
                   }
                   
                 }
                 
                 
                 
                
                catch(Exception ex){
                
                system.debug('@@@@@@@@@@@@@@@@'+ex.getmessage());
                UserInfo Uin = new UserInfo();
                 Uin.Message ='Update unsuccessFully';
                 return Uin; 
                
                }
                
                
                
                
                 return null; 
                
                }
                
                
                global class UserInfo{
                String Message;
                
                String FirstName;
                
                String LastName;
                
                String Company;
                
                String City;
                
                String State;
                
                String Phoneno;
                
                String UserImage;
                
                String ImageBlob;
                String Country;
              
                                
                }
                
                
           
                
                 
                
                }