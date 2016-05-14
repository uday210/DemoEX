public without sharing class ConverBoothAdmin {
    
   public void boothadminConversion(set<Id> setOfatts,id eventName){
    List<string> AllattendeeEmail = new  List<string>();
    MAP<string,sobject> mapEmailwithatt = new  MAP<string,sobject>();
    MAP<string,id> mapContact = new MAP<string,id>();
    LIST<USER> updatedRequiredUsers = new LIST<USER>();
    LIst<string> insertedRequiredUsers = new LIst<string>(); 
    List<contact> conList = new List<contact>(); 
    List<profile> profileList = new  List<profile>(); 
    List<id> IdssendToFuture =new List<id>();
    List<id> IdssendToFutureReal =new List<id>();
    LIST<USER> InserteduserList =new  LIST<USER>();
    integer i=0; 
    
    Map<string,AttendeeSummary__c> mapEmailwithatt2 = new Map<string,AttendeeSummary__c>();
    event__c eve = new event__c();
    
    //Profiles
    Profile__c profileCustom = new Profile__c();
    profileCustom =[select id,PR_Name__c from Profile__c where PR_Name__c='BoothAdmin' limit 1]; 
    profileList =[select id from profile where name='Booth Admin'];
    
   // Event     
    eve =[select  EV_Title__c from event__c where id=:eventName limit 1];
    string eventName1 =eve.EV_Title__c; 
     
     
     for(AttendeeSummary__c att:[select  AS_FirstName__c ,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,  AS_Work_States__c ,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_WorkZip__c from AttendeeSummary__c where Id IN :setOfatts]){
     AllattendeeEmail.add(att.AS_Email__c);   
     mapEmailwithatt.put(att.AS_Email__c,att); 
         
    } 
   
     
     
     
     
     // ------------------------------------ setup objects  -----------------------------------------
     // Inserting contacts  
     for(AttendeeSummary__c attsum : [select AS_FirstName__c ,AS_Company__c,AS_LastName__c,AS_Email__c from   AttendeeSummary__c  where AS_Email__c NOT IN :insertedRequiredUsers and id IN :setOfatts]){
     contact con = new contact();
      con.FirstName =attsum.AS_FirstName__c;
      con.lastName= attsum.AS_LastName__c;
      con.Email =attsum.AS_Email__c;
     // Con.AccountId='001F000000rVD6z';
     Con.AccountId='001F000001DhQdr';
      conList.add(Con);
    }
     database.Saveresult[] conSaveres = database.insert(conList,false);
     
    for(contact co:conList){
     mapContact.put(co.email,co.id);
    } 
  
     
     // Inserting users 
    for(AttendeeSummary__c atts : [select  AS_FirstName__c ,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,  AS_Work_States__c ,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_WorkZip__c from AttendeeSummary__c  where AS_Email__c NOT IN :insertedRequiredUsers and AS_Email__c IN :AllattendeeEmail]){
    user u = new user(); 
    u.FirstName =atts.AS_FirstName__c;
    u.LastNAme =atts.AS_LastName__c;
    u.CompanyName =atts.AS_Company__c;
    u.email =atts.AS_Email__c;
    u.userName=atts.AS_Email__c;
    u.Company_website__c=atts.AS_WebsiteUrl__c;
    u.CompanyAddr1__c=atts.AS_WorkAddress1__c;
    u.CompanyAddr2__c=atts.AS_WorkAddress2__c;
    u.CompanyCity__c=atts.AS_WorkCity__c;
    u.Country__c =atts.AS_Work_Country__c;
    u.CompanyFaxNumber__c=atts.AS_FaxNumber__c;
    u.Companyphone__c =atts.AS_WorkPhone__c;
    u.States__c  =atts.AS_Work_States__c;
    u.contactId=mapContact.get(u.email);
    u.Alias ='BAdmin';
    u.ProfileID =profileList[0].id;
    u.isActive =false;
    u.LocaleSidKey ='en_US';
    u.LanguageLocaleKey ='en_US';
    u.TimeZoneSidKey ='America/Los_Angeles';
    u.EmailEncodingKey='UTF-8';
    InserteduserList.add(u);
    }
    Database.saveResult[] MySaveResultUser =dataBase.insert(InserteduserList,false); 
    system.debug('boooooooooooooooooth admin '+MySaveResultUser);
    
    for(AttendeeSummary__c att:[select  AS_FirstName__c ,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,  AS_Work_States__c ,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_WorkZip__c from   AttendeeSummary__c where Id IN :setOfatts]){
    mapEmailwithatt2.put(att.AS_Email__c,att);     
    }      
    
    updatedRequiredUsers =[SELECT id,userName,Email,CompanyName,FirstName,LastName,Company_website__c,CompanyAddr1__c,CompanyAddr2__c,CompanyCity__c,Country__c,CompanyFaxNumber__c,Companyphone__c,States__c,Zipcode__c from USER where userName IN :AllattendeeEmail and Profile.Name!='Event Admin'];
    // update feture method is called
       
   
    for(user u :updatedRequiredUsers){
    insertedRequiredUsers.add(u.userName);
   }
    
   List<user> InserteduserList2 = new List<user>();  
   for(user u :[SELECT id,userName,Email,CompanyName,FirstName,LastName,Company_website__c,CompanyAddr1__c,CompanyAddr2__c,CompanyCity__c,Country__c,CompanyFaxNumber__c,Companyphone__c,States__c,Zipcode__c,issignup__c from user where userName IN :insertedRequiredUsers]){
      
   InserteduserList2.add(u);
  } 
  
 
    List<id> sendEmailToUploaded = new List<id>();
    
    for(user res:InserteduserList2){
        sendEmailToUploaded.add(res.id);
     
    }   
    
    
   
    updateUser(setOfatts,insertedRequiredUsers);
    
      system.debug('0000000 '+IdssendToFuture );
    
    system.debug('@@@@@@@@@@@@@@ '+eve.id);
    
    
    
    MymethodForUpsate(IdssendToFuture,eve.id,sendEmailToUploaded,setOfatts);
    
    
    }
    
    
    
    @future
    
    public static void updateUser(set<Id> setOfatts,List<string> insertedRequiredUsers){
     
 List<profile> profileList1 = new   List<profile> ();
profileList1=[select id from profile where name='Booth Admin'];
 List<user> InserteduserList3 = new List<user>();
    Map<string,AttendeeSummary__c> mapEmailwithatt3 = new Map<string,AttendeeSummary__c>();
    
     for(AttendeeSummary__c att:[select  AS_FirstName__c,
AS_LastName__c,
AS_Email__c,
AS_Company__c,
AS_WebsiteUrl__c,
AS_WorkAddress1__c,
AS_WorkAddress2__c,
AS_Work_States__c ,
AS_Work_Country__c,
AS_FaxNumber__c,
AS_WorkPhone__c,
AS_WorkCity__c,
AS_WorkZip__c  from   AttendeeSummary__c where Id IN :setOfatts]){
      mapEmailwithatt3.put(att.AS_Email__c,att);     
    }    
    
  for(user u :[SELECT id,userName,Email,CompanyName,FirstName,LastName,Company_website__c,CompanyAddr1__c,CompanyAddr2__c,CompanyCity__c,Country__c,CompanyFaxNumber__c,Companyphone__c,States__c,Zipcode__c,issignup__c from user where userName IN :insertedRequiredUsers]){
AttendeeSummary__c atts = new AttendeeSummary__c();
   atts=mapEmailwithatt3.get(u.userName);
   u.ProfileID =profileList1[0].id;
   u.FirstName =atts.AS_FirstName__c;
   u.LastNAme =atts.AS_LastName__c;
   u.CompanyName =atts.AS_Company__c;
   u.email =atts.AS_Email__c;
   u.userName=atts.AS_Email__c;
   u.Company_website__c=atts.AS_WebsiteUrl__c;
   u.CompanyAddr1__c=atts.AS_WorkAddress1__c;
   u.CompanyAddr2__c=atts.AS_WorkAddress2__c;
   u.CompanyCity__c=atts.AS_WorkCity__c;
   u.Country__c =atts.AS_Work_Country__c;
   u.CompanyFaxNumber__c=atts.AS_FaxNumber__c;
   u.Companyphone__c =atts.AS_WorkPhone__c;
   u.States__c  =atts.AS_Work_States__c;
   if(u.issignup__c){
    u.isActive =true;
   }
   InserteduserList3.add(u);
  } 


 Database.saveResult[] MyupdateResultUser =dataBase.update(InserteduserList3,false);
system.debug('55555555555555555 PPPPPPPPPPPPPPPPPPPPPPp  '+MyupdateResultUser );
}
    
        
   @future
  public static void MymethodForUpsate(List<id> IdssendToFuture,id eventName,List<id> sendEmailToUploaded,set<id> setOfatts){
   List<booth__c> booths = new List<booth__c>(); 
   MAP<string,id> mapBooth = new MAP<string,id>();

  MAP<string,id> userMapping = new  MAP<string,id>();

 for(user u :[select id,userName from user]){
userMapping.put(u.userName,u.id);
}

   // Insert booths 

    for(AttendeeSummary__c att:[select  AS_FirstName__c ,AS_LastName__c,AS_Email__c,AS_Company__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,  AS_Work_States__c ,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_WorkZip__c from AttendeeSummary__c where Id IN :setOfatts]){
    booth__c boothinsert = new booth__c();   
     boothinsert.BT_Name__c=att.AS_Company__c;
     boothinsert.EV_id__c = eventName;   
     boothinsert.BT_ContactName__c = att.AS_FirstName__c +' '+att.AS_LastName__c ;   
     boothinsert.BT_ContactEmail__c = att.AS_Email__c;   
     boothinsert.BT_ContactPhone__c = att.AS_WorkPhone__c;    
     booths.add(boothinsert); 
     
    }  
   Database.SaveResult[] MySaveResultBooth =dataBase.insert(booths,false);       
   for(booth__c bo:booths){
    mapBooth.put(bo.BT_Name__c,bo.id);
   }
  
  system.debug('4444444444444 RRRRRRRRRRRRRRR '+mapBooth);
  
      Profile__c profileCustomFuture = new Profile__c();
     profileCustomFuture =[select id,PR_Name__c from Profile__c where PR_Name__c='BoothAdmin' limit 1]; 
  
  // Before Not On Future 
    List<User_Profile_Event__c> UPEList = new List<User_Profile_Event__c>();
   

    for(user uf :[select id,companyName from user where id IN :IdssendToFuture]){

    User_Profile_Event__c upe = new User_Profile_Event__c();
     upe.BT_id__c =mapBooth.get(uf.companyName);
  
   system.debug('666666666666666 SSSSSSSSSSSSSSSSSSSSS '+uf.companyName);
  system.debug('666666666666666 TTTTTTTTTTTT '+mapBooth.get(uf.companyName));
  
     upe.EV_id__c =eventName;
     upe.User_id__c=uf.id;
     upe.BoothAdmin_id__c=uf.id;
     upe.status__c ='Active';
     upe.EventAdmin_Id__c=userInfo.getuserId();
     upe.UEP_isActive__c=TRUE;
     upe.Profile_id__c =profileCustomFuture .id;
     UPEList.add(upe);
  
  }
    database.saveResult[] upeInsert=dataBase.insert(UPEList);
   system.debug('11111111111111111111111 '+upeInsert);
  
  List<Event_Attendee_Mapping__c> attupdate =new List<Event_Attendee_Mapping__c> ();
   for(Event_Attendee_Mapping__c UA : [SELECT id,AS_id__c,Boothleads_Profile__c,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c IN :IdssendToFuture and EV_id__r.id=:eventName]){
    UA.Boothleads_Profile__c='BoothAdmin';
    attupdate.add(UA);
   }
 database.saveResult[] res =  dataBase.update(attupdate,false);
 system.debug('222222222222222222 '+res);
 //=================================== 
 
 
 // Before In Future 
 List<User_Profile_Event__c> UPEList1 = new List<User_Profile_Event__c>();
 List<User_Profile_Event__c> AllUPEs = new List<User_Profile_Event__c>(); 
 
 AllUPEs =[SELECT id,User_id__c,EV_id__c,User_id__r.id from User_Profile_Event__c where EV_id__r.id=:eventName];
 
 MAP<id,User_Profile_Event__c>  mapUserAndUpe = new MAP<id,User_Profile_Event__c> ();
 List<User_Profile_Event__c> forUpdateProfile = new List<User_Profile_Event__c>();
  set<Id> UPEUsers = new set<Id>();
  
  for(User_Profile_Event__c userIdsInUPE:AllUPEs){
   UPEUsers.add(userIdsInUPE.User_id__r.id);
   mapUserAndUpe.put(userIdsInUPE.User_id__r.id,userIdsInUPE);
   }
 
 
 for(user saveResultOfUser:[select id,email,companyName from user where id IN:sendEmailToUploaded]){
   if(UPEUsers.contains(saveResultOfUser.id)){
   User_Profile_Event__c upe = new User_Profile_Event__c();
   try{
     upe = mapUserAndUpe.get(saveResultOfUser.id);
  upe.BT_id__c =mapBooth.get(saveResultOfUser.companyName);
   upe.BoothAdmin_id__c=saveResultOfUser.id;
    upe.Profile_id__c =profileCustomFuture .id;
      upe.EventAdmin_Id__c=userInfo.getuserId();
       upe.MAtchMakingProfile__c='Corporate';
    forUpdateProfile.add(upe);
     system.debug('33333333333333333 '+forUpdateProfile);
   }catch(exception ex){}
    } else{
     User_Profile_Event__c upe = new User_Profile_Event__c();
     upe.BT_id__c =mapBooth.get(saveResultOfUser.companyName);
     upe.EV_id__c =eventName;
     upe.User_id__c=saveResultOfUser.id;
     upe.BoothAdmin_id__c=saveResultOfUser.id;
     upe.status__c ='Active';
     upe.EventAdmin_Id__c=userInfo.getuserId();
     upe.UEP_isActive__c=TRUE;
     upe.Profile_id__c =profileCustomFuture.id;
     //Added by Unni 
     upe.MAtchMakingProfile__c='Corporate';
     UPEList1.add(upe);
     system.debug('444444444444444444444 '+UPEList1);
    } 
  }
 
dataBase.saveResult[] abc12 = dataBase.insert(UPEList1,false);

 List<string> forattjunupdate = new List<string>();
   for(user uy:[select id,userName from user where id IN :sendEmailToUploaded]){
    forattjunupdate.add(uy.userName);   
   }
  system.debug('555555555555555555555 '+forattjunupdate);
 
   List<Event_Attendee_Mapping__c> attupdate1 =new List<Event_Attendee_Mapping__c> ();
   for(Event_Attendee_Mapping__c UA : [SELECT id,AS_id__c,Boothleads_Profile__c,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c IN :forattjunupdate]){
    UA.Boothleads_Profile__c='Booth Admin';
    attupdate1.add(UA);
   }
   dataBase.saveResult[] abc = dataBase.update(attupdate1,false);
 dataBase.saveResult[] abc1 = dataBase.update(forUpdateProfile,false);




 system.debug('66666666666666666666 '+abc );
 
  }
      
}