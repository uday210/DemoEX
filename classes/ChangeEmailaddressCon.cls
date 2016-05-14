public without sharing class ChangeEmailaddressCon {
 
 //public List<AttendeeSummary__c> attsims{get;set;}
   /* public PageReference searchEmail() {
      attsims = new List<AttendeeSummary__c>();
      if(email.length()>1){
      attsims =[select AS_Email__c from AttendeeSummary__c where AS_Email__c like :email+'%'];
      }
        return null;
    }*/


   public string firstName{get;set;}
   public string lastName{get;set;}
   public String saveNameEmailId{get; set;}
   public string message{get;set;}
   public String password { get; set; }
    public String email { get; set; }
    public string oldemail{get;set;}
    public string newemail{get;set;}

   
    public pageReference saveName() {
    message ='';
    try{
    
     List<AttendeeSummary__c> allL = new List<AttendeeSummary__c>();
     allL  = [select as_email__c,id,AS_FirstName__c,AS_LastName__c from AttendeeSummary__c where as_email__c=:saveNameEmailId];
     if(allL.size()<=0){
        message = 'User does not exists';
       return null;
     }
       for(AttendeeSummary__c att:allL){
      // att.as_email__c =  saveNameEmailId;
       att.AS_FirstName__c  = firstName;
       att.AS_LastName__c  = lastName;
       database.saveresult saveatt=  dataBase.update(att);
         if(saveatt.isSuccess()){ 
           updateUser1(saveNameEmailId,firstName,lastName);
           firstName ='';
           lastName ='';
           saveNameEmailId='';
           message ='Success';
           return null;     
       }else{
          for (Database.Error err : saveatt.getErrors()){
            message = err.getMessage() ;
            break;
          }
         return null;      
        }
      }
     }catch(exception py ){
    message  =py.getMessage() ;
    return null;     
   } 
   
 return null;     
 }

    public PageReference changepassword() {
    message   ='';
    try{
    List<user> users = new List<user>();
    users=[select id,password__c,userName,email,IsActive from user where userName=:email limit 1 ];
    
    if(users.size()>0){
        if(users[0].isActive==false){
         message = 'Please active user before update password';
         return null;
      }
  
   try{
     system.setPassword(users[0].id,password);
     users[0].password__c =password ;
     dataBase.saveResult dbresult = dataBase.update(users[0],false); 
      if(dbresult.isSuccess()){
       message = 'Success';
       email ='';
       password ='';
       return null;     
     }else{
         for(Database.Error err : dbresult.getErrors()){
            message = err.getMessage() ;
            break;
           }
           return null;     
      }
    }catch(exception er){
      message  =er.getMessage() ;
      return null;     
    }
   }else{
         message = 'No user is in db with this Email';
         return null;     
   }
  } catch(exception pyt ){
    message  =pyt.getMessage() ;
    return null;     
 }  
   
   return null;
  }


   

  public PageReference changeEmail() {
   message  ='';
   try{  
    List<user> users = new List<user>();
    users =[select id,email,userName,IsActive from user where userName=:oldemail];
    
     List<user> users1 = new List<user>();
     users1 =[select id,email,userName,IsActive from user where userName=:newemail];
        
     List<AttendeeSummary__c> attSum= new List<AttendeeSummary__c>();
     attSum = [select as_email__c,id from AttendeeSummary__c where as_email__c=:newemail];
     
     List<AttendeeSummary__c> attoldSum= new List<AttendeeSummary__c>();
     attoldSum = [select as_email__c,id from AttendeeSummary__c where as_email__c=:oldemail];
    
     if(attoldSum.size()<=0){
       message = 'User does not exists';
       return null;
     }
    
    if(attSum.size()<=0 && users1.size()<=0){
    
      for(AttendeeSummary__c att:attoldSum){
        att.as_email__c =  newemail;
        database.saveresult de =  dataBase.update(att);
        if(de.isSuccess()){
           updateUser(oldemail,newemail);
           email ='';
           oldEmail ='';
           newEmail='';
           
           message = 'Success';
           return null;     
        }else{
          for(Database.Error err : de.getErrors()){
             message = err.getMessage() ;
             break;
           }
           return null;     
        }
      }
   }else{
      message = 'User already Exists';
      return null;     
   }
 }catch(exception rt ){
    message  =rt.getMessage() ;
    return null;     
 }  
   
   return null;
  }



@future 
public static void updateUser(string oldemail,string newemail){
 List<user> users12 = new List<user>();
 users12 =[select id,email,userName,IsActive from user where userName=:oldemail];
 if(users12.size()>0){
       for(user u:users12){
         u.email =newemail;
         u.userName=newemail;
         dataBase.update(u);
       }
          
     }
}


@future 
public static void updateUser1(string email,string fn,string ln){
 List<user> users12 = new List<user>();
 users12 =[select id,email,userName,isSignup__c,isactive from user where userName=:email];
 if(users12.size()>0){
       for(user u:users12){
        u.firstName=fn;
         u.lastName=ln;
        dataBase.update(u);
         system.debug('PPPPPPPPPPPPPPPP '+u);
       }
          
     }
  }

}