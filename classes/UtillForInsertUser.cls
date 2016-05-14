public without sharing class UtillForInsertUser{

    public string error{get;set;}
    
    public string insertUsers(List<Event_Attendee_Mapping__c> epList,boolean isSignup,string eventid,boolean isMatchmaking,string password){
    
         MAP<string,id> conatctwithId = new MAP<string,id>();
         profile p = [select Id,Name from Profile where Name = 'Attendee' Limit 1];
         user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
         SET<string> emails = new SET<string>();
         MAP<string,Event_Attendee_Mapping__c>  maiemailWithEam  = new MAP<string,Event_Attendee_Mapping__c>();
         List<Event_Attendee_Mapping__c> eams = new List<Event_Attendee_Mapping__c>();
         system.debug('EEEEEEEEEEEEEE '+epList);
         
          for(Event_Attendee_Mapping__c ep :epList){
               emails.add(ep.as_id__r.AS_Email__c);
               maiemailWithEam.put(ep.as_id__r.AS_Email__c,ep);
          }
          system.debug('3333333333333333  '+emails);
          SET<string> emailsuserExists = new SET<string>();
          
          for(user ty :[select id,userName from user where userName In :emails ]){
               emailsuserExists.add(ty.userNAme);
          }
          
          emails.removeAll(emailsuserExists);
          SET<string> removeUsersWhohasUpe = new SET<string>();
           
          for(string se:emails){
           eams.add(maiemailWithEam.get(se));          
          }
          
          
          
         account acc=new account();
         try{
          acc =[select id from account where ownerid!=null and name like 'booth%' limit 1]; 
          }catch(exception r){
             acc.name='Booth Leads';  
             acc.ownerid=uname.createdby.id;          
             insert acc; 
            }
            
          LIst<contact> conlist = new List<contact>();  
          for( Event_Attendee_Mapping__c eam :eams ){
              Contact Contact = new Contact();
              Contact.Lastname = eam.AS_id__r.AS_LastName__c;
              Contact.Firstname = eam.AS_id__r.AS_firstName__c;
              Contact.AccountID = acc.id;
              contact.Title = eam.AS_id__r.AS_company__c;
              Contact.Email=eam.AS_id__r.AS_Email__c;
              conlist.add(Contact);
          }  
       
        dataBase.saveResult[] res = dataBase.insert(conlist,false);
        List<Id> conatcts = new List<Id>();
          for(dataBase.saveResult rt:res ){
             if(rt.Issuccess()){
             conatcts.add(rt.getid());
           }
        }
 
     List<contact> contactList = new List<contact>();
     contactList  =  [select id,email,lastname,Title,firstname from contact where id In :conatcts];
     for(contact ctt :contactList  ){
       conatctwithId.put(ctt.email,ctt.id);
       
     }   
     
     // inserting users
     LIst<user> usersForInsert = new List<user>(); 
     for(contact c : contactList  ){
     user u = new user();
      U.ContactID = c.id; U.FirstName = c.FirstName;U.CompanyName =c.title;
      U.LastName = c.LastName; U.Username = c.email; U.Email = c.email;
      U.Alias = 'EventAdm';
      U.ProfileID = P.id;U.LocaleSidKey = 'en_US';U.LanguageLocaleKey = 'en_US';
      U.TimeZoneSidKey = 'America/Los_Angeles'; U.EmailEncodingKey='UTF-8'; 
       u.IsActive = false;
       if(isSignup){ 
         u.Password__c =password;
         u.IsActive = true;
         u.isSignup__c=true;
       }
      usersForInsert.add(u);
     }
     
     
     dataBase.saveResult[] resUsers =new dataBase.saveResult[]{};
     if(usersForInsert.size()>0){
       resUsers  = dataBase.insert(usersForInsert,false); 
     }
     SET<id> insertedUserIds = new SET<id>();
       for(dataBase.saveResult saverep : resUsers ){
          if(saverep.isSuccess()){
            insertedUserIds.add(saverep.getId()); 
            if(isSignup){
                system.debug(saverep.getId());
                try{
                 system.setPassword(saverep.getId(),password); 
                }catch(exception es){
                    error =es.getMessage();
                    return error;
                 }
              break;
            }
          }else{
             for(dataBase.saveResult sav : resUsers ){
                for (Database.Error err : sav.getErrors()){
                     error = err.getMessage() ;
                     return error ; 
                  } 
             }
          }
       }
       
     //  MAP<string,Event_Attendee_Mapping__c>  ListOfuserNoupes = new MAP<string,Event_Attendee_Mapping__c>();
      // MAP<string,id> mapuserEmailEithId = new MAP<string,id>(); 
      SET<string> strListForInsert = new SET<string>();
       
      forupdateEAM (maiemailWithEam.keySet(),eventId,isMatchmaking); 
      return 'You have successfully signed up';  
   }


   

@future 
    public static void forupdateEAM(SET<string>  e1,string eventId,boolean isMatchMaking){
       
           for(User_Profile_Event__c uyr :[select id,User_id__r.userName from User_Profile_Event__c where User_id__r.userName in :e1 and EV_id__c=:eventid]){
                e1.remove(uyr.User_id__r.userName);
            }
          
            List<Event_Attendee_Mapping__c> evenAtt =[select AS_id__r.id,Boothleads_Profile__c,id,AS_Id__r.AS_FirstNAme__c,AS_Id__r.AS_LastNAme__c,AS_Id__r.AS_Email__c,AS_Id__r.AS_Company__c from Event_Attendee_Mapping__c where AS_Id__r.AS_Email__C IN : e1 and EV_Id__c =:eventId];
            MAP<string,id> mapuserEmailEithId = new MAP<string,id>(); 
           
           
            for(user uyu : [select id,email,userNAme,companyNAme from user where userNAme in :e1]){
                mapuserEmailEithId.put(uyu.userNAme,uyu.id);
            }
            
            
           
          
            
                                   Profile__c attendeeProfile= [Select Id from Profile__c where PR_Name__c ='Attendee' ];
                                   Profile__c boothAdminProfile= [Select Id from Profile__c where PR_Name__c ='BoothAdmin' ];
                                  
                                   SET<string> boothNames = new SET<string>();
                                    SET<string> boothNamesemail = new SET<string>();
                                    List<Booth__c> booths = new List<Booth__c>();
                                      
                                      for(Event_Attendee_Mapping__c eam:evenAtt) {
                                      system.debug('CCCCCCCCCCCCCCC '+eam.AS_id__r.AS_Company__c);
                                       if(eam.AS_id__r.AS_Company__c!=null){
                                            if(boothNames.contains(eam.AS_id__r.AS_Company__c)){
                                             
                                             }else{
                                                   Booth__c Booth  = new Booth__c();
                                                   booth.EV_id__c =eventid;
                                                   booth.BT_ContactEmail__c = eam.AS_id__r.AS_email__C;
                                                   boothNamesemail.add( eam.AS_id__r.AS_email__c); 
                                                   booth.BT_Name__c =eam.AS_id__r.AS_Company__c;
                                                   booth.BT_ContactName__c =eam.AS_id__r.AS_LastName__c+' '+eam.AS_id__r.AS_FirstName__c;
                                                   booths.add(booth); 
                                                   boothNames.add(eam.AS_id__r.AS_Company__c);
                                                    system.debug('WWWWWWWWWWWWWWQQQQQQQQQQQQQQQQAAAAAAAAAAAAA '+boothNames);
                                            }
                                        }
                                        
                                      }
                                     
                                       DataBase.saveResult[] savres = dataBase.insert(booths,false);
                                      system.debug('XXXXXXXXXXXXXXXXXXXx '+savres );
                                      Set<Id> boothIds = new Set<Id>();
                                      
                                      for(DataBase.saveResult dsavres :savres ){
                                        if(dsavres.isSuccess()){
                                          boothIds.add(dsavres.getId());
                                        }
                                      
                                      }
                                      
                                      system.debug('FFFFFFFFF '+savres +'FFFFFFFFFFFFFFFFFFFF '+boothNamesemail);
                                      MAP<string,Id> MapIdwithEmailBooth = new MAP<string,Id>();
                                      
                                      for(Booth__c bo :[Select Id,BT_ContactEmail__c from Booth__c where (id In :boothIds OR BT_ContactEmail__c IN :boothNamesemail)]){
                                         MapIdwithEmailBooth.put(bo.BT_ContactEmail__c,bo.id); 
                                      }
                                      
                                      List<User_Profile_Event__c> upes = new List<User_Profile_Event__c>();
                                      
                                      for(Event_Attendee_Mapping__c eam:evenAtt) {
                                      
                                             if(eam.Boothleads_Profile__c=='Attendee'){
                                              
                                                   User_Profile_Event__c UPE1 = new User_Profile_Event__c();
                                                   UPE1.UEP_isActive__c = True;
                                                   if(isMatchMAking){
                                                     UPE1.IsMatchMakingUser__c = true;
                                                   } 
                                                   UPE1.EV_id__c =eventId;
                                                   UPE1.Profile_id__c = attendeeProfile.id;
                                                   UPE1.User_id__c = mapuserEmailEithId.get(eam.AS_id__r.AS_Email__c); 
                                                   UPE1.MAtchMakingProfile__c='MBE';
                                                   UPE1.Attendee_Summary__c = eam.AS_id__r.id;
                                                   try{
                                                   upe1.BT_id__c = MapIdwithEmailBooth.get(eam.AS_id__r.AS_Email__c);
                                                   }catch(exception re){}
                                                   UPE1.BoothAdmin_id__c =mapuserEmailEithId.get(eam.AS_id__r.AS_Email__c);
                                                   upes.add(upe1);
                                                  
                                            }else{
                                            
                                                   User_Profile_Event__c UPE = new User_Profile_Event__c();
                                                   UPE.UEP_isActive__c = True;
                                                  
                                                   UPE.EV_id__c =eventId;
                                                   if(isMatchMAking){
                                                      UPE.IsMatchMakingUser__c = true;
                                                   }
                                                    UPE.MAtchMakingProfile__c='Corporate';
                                                   UPE.Profile_id__c = boothAdminProfile.id;
                                                   UPE.User_id__c = mapuserEmailEithId.get(eam.AS_id__r.AS_Email__c); 
                                                   UPE.Attendee_Summary__c = eam.AS_id__r.id;
                                                   try{
                                                   upe.BT_id__c = MapIdwithEmailBooth.get(eam.AS_id__r.AS_Email__c);
                                                    }catch(exception re){}
                                                   UPE.BoothAdmin_id__c =mapuserEmailEithId.get(eam.AS_id__r.AS_Email__c);
                                                   upes.add(upe); 
                                           
                                            }
                                            system.debug('+++++++++++++++++++++'+upes);
                                       }           
                                      // Database.UpsertResult[] saveupe= database.upsert(upes,false);  
                                          
                                    DataBase.saveResult[] saveupe= dataBase.insert(upes,false);  
                                    system.debug('+++++++++++++++++++++'+saveupe);
                                    
                                
                            
                      }




}