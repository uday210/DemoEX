public with sharing class BL_Eventadmin_ProfileCon { 

public PageReference Profileupdatepage(){
 PageReference  pg = new PageReference ('/apex/BL_EventAdmin_ResetPassword?id='+EventId );
 pg.setredirect(true);  
 return pg;     
}

public PageReference checkUserId(){
 if(userInfo.getUserType()=='guest'){
   Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
   pg.setredirect(true);
   return pg;
 }
 else{
  return null;
 }         
}

public User EventUser{get;set;} 
public String LoginUserId {get;set;}
public string EventId{get;set;}
 
public BL_Eventadmin_ProfileCon(){
 
 EventId = apexpages.currentpage().getparameters().get('id');
 
 LoginUserId = Userinfo.getUserId();
 EventUser = [select Id,States__c,Country__c,FirstName,LastName,Email,CompanyAddr2__c,CompanyCity__c,companyName,CompanyAddr1__c ,
            CompanyCountry__c,Companyphone__c,CompanyState__c,Company_website__c,Zipcode__c,CompanyFaxNumber__c,
            PoBox__c From User Where id =:LoginUserId];           
}
    
public PageReference ProfileSave(){
    try{
     EventUser.FirstName = EventUser.FirstName;
     EventUser.LastName= EventUser.LastName;
     EventUser.Email = EventUser.Email;
     EventUser.CompanyAddr2__c = EventUser.CompanyAddr2__c;
     EventUser.CompanyAddr1__c = EventUser.CompanyAddr1__c ;   
     EventUser.Companyphone__c = EventUser.Companyphone__c;    
     EventUser.Country__c = EventUser.Country__c;
     EventUser.States__c = EventUser.States__c;
     EventUser.Company_website__c = EventUser.Company_website__c;
     EventUser.Zipcode__c = EventUser.Zipcode__c;
     EventUser.CompanyFaxNumber__c = EventUser.CompanyFaxNumber__c;
     EventUser.PoBox__c = EventUser.PoBox__c ;
     EventUser.CompanyName = EventUser.CompanyName  ;
    
     update EventUser; 
 
    AttendeeSummary__c UpdatingAttendee = [select As_FirstName__c,AS_LastName__c from AttendeeSummary__c where AS_Email__c=:EventUser.Email];
    
    UpdatingAttendee.AS_FirstName__c = EventUser.FirstName; 
    UpdatingAttendee.AS_LastName__c = EventUser.LastName;
    UpdatingAttendee.AS_Company__c  = EventUser.CompanyName;
    UpdatingAttendee.AS_CellPhone__c  = EventUser.Companyphone__c;
    UpdatingAttendee.AS_uniqueField__c=(EventUser.FirstName+EventUser.LastName+EventUser.Email).tolowercase();
    
    Update UpdatingAttendee;
 
  }catch(Exception ex){
 
 } 
 PageReference pg=new PageReference('/apex/BL_EA_Dashboard?id='+EventId );
 pg.setRedirect(true);
 return pg;

 
 
}    






}