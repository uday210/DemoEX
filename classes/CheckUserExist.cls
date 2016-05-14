@RestResource(urlMapping='/CheckUserExist/*')
   global with sharing class CheckUserExist{
      
    @HttpPost
    global static List<GlobalUtillClass.UserDetails> doPost(){
       RestRequest req = RestContext.request;
       RestResponse res = RestContext.response;
       string userName= req.params.get('Email');
       system.debug('HHHHHHHHHHHHHHHHHH '+userName);
      
      AttendeeSummary__c att;
      try{
       att = [select AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Title__c,AS_WorkPhone__c,id,AS_ImageUrl__c,AS_Email__c from AttendeeSummary__c where AS_Email__c=:userName limit 1];
       }catch(exception ew){}
     
      string imgurl;
      if(att!=null){
       imgurl =att.AS_ImageUrl__c;
       }
       string attvalues='';
    
    List<GlobalUtillClass.UserDetails> alDetail = new List<GlobalUtillClass.UserDetails>();
    
          
     for(user Us :[Select IsSignup__c,Id,FirstName,LastName,Email,UserName,Phone,CompanyName,states__c,Country__c,City  from user where UserName=:userName limit 1]){
           if(us.isSignup__c==true){
            GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails('User already signup');
            alDetail.add(Guser);
            return alDetail;
            }
           }
        
        if(att!=null){
         system.debug('DDDDDDDDDDDDDDDd '+userName); 
          user u = new user();
          U.FirstName = att.AS_FirstName__c;
          U.LastName = att.AS_LastName__c;
          u.CompanyName = att.AS_Company__c;
          u.userName =att.AS_Email__c;
          u.Phone =att.AS_WorkPhone__c;
          String title = att.AS_Title__c;
          
           GlobalUtillClass.UserDetails Guser = new GlobalUtillClass.UserDetails(u,imgurl,attvalues, title );
            alDetail.add(Guser);
            return alDetail;
       }else{
         return null;
       }
    } 
  
  }