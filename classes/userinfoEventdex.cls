@RestResource(urlMapping='/userinfoEventdex/*')

global without Sharing class userinfoEventdex{


 @httpPost
 global static tktprofilecls doPost(){
    
         RestRequest req = RestContext.request;
         RestResponse res = RestContext.response;
         string userid;     
         userid=req.params.get('userid');
         tktprofilecls tktprofileDetails= new tktprofilecls();
         
          Tkt_profile__c userDetails = new Tkt_profile__c ();
          try{
             userDetails =  [select id,First_Name__c,Last_Name__c,BLN_GN_User__r.User__c,Home_Address__r.Address1__c,Home_Address__r.Address2__c,Age__c,Home_Address__r.City__c,Home_Address__r.Country__c,DOB__c,Established_Date__c,Email__c,Gender__c,Home_Phone__c,BLN_GN_User__r.Is_Active__c,Mobile__c,Home_Address__r.ZipCode__c,User_Pic__c,Home_Address__r.State__c,Suffix__c,Prefix__c from Tkt_profile__c where BLN_GN_User__r.user__c=:userid];
             tktprofileDetails.tktprofile =  userDetails ;
             return tktprofileDetails;
            
          }catch(exception e){
             tktprofileDetails.error =  e.getMessage();
             return tktprofileDetails;
          } 
           
       }
       
       
       
    global class tktprofilecls{
      Tkt_profile__c  tktprofile{get;set;}
      string error{get;set;}
     }   
       
 }