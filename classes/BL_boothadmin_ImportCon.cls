public without sharing class BL_boothadmin_ImportCon {

public boolean Successbool { get; set; }

    public PageReference movetoBoothpage() {
    pageReference pg = new pageReference('/apex/BL_eventadmin_samplebooth');
     return pg;
    }

    public PageReference Attendees() {
     Successbool =false; 
        return null;
    }

    public PageReference exportToCSV() {
     PageReference pageRef= new PageReference('/apex/QRCode_boothamin_Template');
                pageRef.setredirect(false);
                return pageRef;
        return null;
    }


    public PageReference closePopup() {
    showselectCSV = false;
        return null;
    }

public boolean showselectCSV{get;set;}


    public PageReference importValues() {
      string eventId=ApexPages.currentpage().getParameters().get('Id');
      string eventName;
      List<event__c> forEventName =[select Id,  EV_Title__c from event__c where id=:eventId];
      if(forEventName.size()>0){
       eventName=forEventName [0].EV_Title__c;
      }     
      
      List<user> UploadedUserWithAllFields= new List<user>();
      List<user> FailesRecordsuploaded= new List<user>();
      LIST<string> failedRecordEmails  = new LIST<string>();
      SET<id>  insertedRecordIds = new SET<id>(); 
      set<string> AllfailedRecords = new  set<string>(); 
      
      List<contact> conList = new List<contact>();
      MAP<string,id> mapContact = new MAP<string,id>();
      List<booth__c> booths = new List<booth__c>();
      Profile__c profileCustom = new Profile__c();
      profileCustom =[select id,PR_Name__c from Profile__c where PR_Name__c='BoothAdmin' limit 1];
      booths = new List<booth__c>(); 
      system.debug('44444444444444444444444444 '+Inn);
      system.debug('77777777777777777777       '+parsedCSV);
      
   // ------------------------- Insert Contacts --------------------------------
      String EmailBody = 'We are working with BoothLeads to help you with your event '+ eventName +'. All badges will now have a QR code specific to your name and company. You will be able to scan the QR code on-site, make notes about that individual and follow up with them.'+'\n\n'+'You have been added to the BoothLeads database for '+ eventName +'\n\n\n'+'Now what?'
+'\n\n\n'+'• Go to http://www.boothleads.com to login into your Booth Admin Portal as well as your mobile app.USERNAME AND PASSWORD ARE PROVIDED AT THE BOTTOM OF THIS EMAIL.'
+'\n\n\n'+'• Here are some youtube videos to give you an idea of what will happen:'+'\n\n'+' o What is a QR code: http://www.youtube.com/watch?v=b8EpazIwFys'+'\n\n'+' o How to generate a QR code so that attendees can view your brochures or '+'\n'+' flyers: http://www.youtube.com/watch?v=jcg2qbS_TaM&feature=youtu.be'
+'\n\n\n'+'• Next step….Download the appropriate app to your phone either from Google'+'\n'+'Play Store or AppStore or BlackBerry World.'
+'\n\n\n\n'+' Then you are ready to scan the badges on-site!'+'\n\n'+' Please note that your Booth Leads portal access is valid only for 30 days from the end of your event'
+'\n\n'+ ' We will be available on-site at the show (across from the registration desk) to assist you throughout the event.'+'\n\n'+' If you need assistance before that time, contact us at support@boothleads.com.'+'\n\n\n'+' Thank you!'+'\n'+' BoothLeads Customer Support'+'\n'+' Phone: 1-(800)-492-1289' ;
      
    
      
      String EmailSubject = 'Booth Leads and '+eventName;

     system.debug('666666668888888889999999 '+parsedCSV.size());
      for(Integer i=1;i<parsedCSV.size();i++){
      
      system.debug('4444444455555555555551111111'+parsedCSV[i]);
        contact con =new contact();
        for(innclas innIterator:inn){ 
         if(innIterator.selectedValue!='NONE'){
         String[] inputvalues = new String[]{};
          inputvalues = parsedCSV[i].split(';;;:::');
          if(DBField.get(innIterator.dbFieldvalue)=='FirstName'){
          try{
            con.FirstName =inputvalues[integer.valueOf(innIterator.selectedValue)];
            }catch(exception e){}
           }else if(DBField.get(innIterator.dbFieldvalue)=='LastName'){
          try{
            con.lastName =inputvalues[integer.valueOf(innIterator.selectedValue)];
            }catch(exception e){}
           }else if(DBField.get(innIterator.dbFieldvalue)=='Email'){
              try{
               con.Email =inputvalues[integer.valueOf(innIterator.selectedValue)];
            }catch(exception e){}
           } 
         //  Con.AccountId = '001O0000007AN41'; 
             Con.AccountId='001F000000rVD6z';
            Con.Email_Subject__c = EmailSubject;
            Con.Email_Notes__c = EmailBody;
      }            
         }
        conList.add(con);
      }
     system.debug('hhhhhhhhhhhhhhhh '+conList);
     dataBase.insert(conList,false);
     
  // ------------------------- add contact values to Map-------------------------------- 
     for(contact co:conList){
        mapContact.put(co.email,co.id);
     } 
     system.debug('hhhhhhhhhhhhhhhh111111111 '+mapContact); 
     
    // ----------------------------------- user insert -----------------------  
   
     MAP<string,user> mapEmailWithUsetUpload = new MAP<string,user>();
     
     for(Integer i=1;i<parsedCSV.size();i++){
       system.debug('344343434343434343 '+parsedCSV.size()); 
       user u = new user();
       booth__c boothinsert = new booth__c();
      // AttendeeSummary__c att = new AttendeeSummary__c();
      u.TwitterId__c =string.valueOf(i);
      String[] inputvalues = new String[]{};
      inputvalues = parsedCSV[i].split(';;;:::');
              
         for(innclas innIterator:inn){
           if(innIterator.selectedValue!='NONE'){
              // u.put(DBField.get(innIterator.dbFieldvalue),inputvalues[integer.valueOf(innIterator.selectedValue)]);
                if(DBField.get(innIterator.dbFieldvalue)=='firstName'){
               try{
               u.FirstName =inputvalues[integer.valueOf(innIterator.selectedValue)];
                //  att.AS_FirstName__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                // att.AS_LastName__c=inputvalues[integer.valueOf(innIterator.selectedValue)];
                  }catch(exception e){}
                }else                
               if(DBField.get(innIterator.dbFieldvalue)=='LastName'){
               try{
             
                u.LastNAme=inputvalues[integer.valueOf(innIterator.selectedValue)];
              //  att.AS_FirstName__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                // att.AS_LastName__c=inputvalues[integer.valueOf(innIterator.selectedValue)];
                  }catch(exception e){}
                }else if(DBField.get(innIterator.dbFieldvalue)=='CompanyName'){
                  try{
                 u.CompanyName=inputvalues[integer.valueOf(innIterator.selectedValue)];
                 boothinsert.BT_Name__c=inputvalues[integer.valueOf(innIterator.selectedValue)];
                 boothinsert.EV_id__c = eventId;    
                  }catch(exception e){}
                }else if(DBField.get(innIterator.dbFieldvalue)=='Email'){
                  try{
                mapEmailWithUsetUpload.put(inputvalues[integer.valueOf(innIterator.selectedValue)],u);  
                u.email =inputvalues[integer.valueOf(innIterator.selectedValue)];
                u.userName=inputvalues[integer.valueOf(innIterator.selectedValue)];
               // att.AS_Email__c =u.userName;
                 }catch(exception e){}
                }else if(DBField.get(innIterator.dbFieldvalue)=='Company_website__c'){
                  try{
                u.Company_website__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
               // att.AS_WebsiteUrl__c =inputvalues[integer.valueOf(innIterator.selectedValue)]; 
                }catch(exception e){}        
               }else if(DBField.get(innIterator.dbFieldvalue)=='CompanyAddr1__c'){
                  try{
                u.CompanyAddr1__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
               // att.AS_WorkAddress1__c =inputvalues[integer.valueOf(innIterator.selectedValue)];                   
               }catch(exception e){}
               }else if(DBField.get(innIterator.dbFieldvalue)=='CompanyAddr2__c'){
                  try{
                u.CompanyAddr2__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                //att.AS_WorkAddress2__c =inputvalues[integer.valueOf(innIterator.selectedValue)];    
                  }catch(exception e){}
               }else if(DBField.get(innIterator.dbFieldvalue)=='CompanyCity__c'){
               try{ u.CompanyCity__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
               // att.AS_WorkCity__c =inputvalues[integer.valueOf(innIterator.selectedValue)];                  
                }catch(exception e){}
               }else if(DBField.get(innIterator.dbFieldvalue)=='Country__c'){
               try{
                u.Country__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                //att.AS_Work_Country__c =inputvalues[integer.valueOf(innIterator.selectedValue)];                  
                }catch(exception e){}
               }
               else if(DBField.get(innIterator.dbFieldvalue)=='CompanyFaxNumber__c'){
              try{ u.CompanyFaxNumber__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
               // att.AS_FaxNumber__c =inputvalues[integer.valueOf(innIterator.selectedValue)]; 
             }catch(exception e){}
               }
               else if(DBField.get(innIterator.dbFieldvalue)=='Companyphone__c'){
               try{ u.Companyphone__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                //att.AS_WorkPhone__c =inputvalues[integer.valueOf(innIterator.selectedValue)];               
                }catch(exception e){}
               }
               else if(DBField.get(innIterator.dbFieldvalue)=='States__c'){
               try{ u.States__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
              //  att.AS_Work_States__c =inputvalues[integer.valueOf(innIterator.selectedValue)];                    
                }catch(exception e){}
               } else if(DBField.get(innIterator.dbFieldvalue)=='Zipcode__c'){
                try{
                u.Zipcode__c =inputvalues[integer.valueOf(innIterator.selectedValue)];
                //att.AS_WorkZip__c =inputvalues[integer.valueOf(innIterator.selectedValue)];     
                }catch(exception e){}
               }
               
          u.contactId=mapContact.get(u.email);
          u.Alias ='BAdmin';
        u.ProfileID ='00eF0000000FYkG';
          //  u.ProfileID ='00eO0000000Dkqz';
          u.LocaleSidKey ='en_US';
          u.LanguageLocaleKey ='en_US';
          u.TimeZoneSidKey ='America/Los_Angeles';
          u.EmailEncodingKey='UTF-8';
        }  
      }  
      booths.add(boothinsert); 
      //def.add(att); 
   if((u.FirstName!=null && u.LastName!=null && U.Email!=null && U.CompanyName!=null) && (u.FirstName!=''&& u.LastName!=''&& U.Email!=''&& U.CompanyName!='') ){                 
      system.debug('FFFFFFFFFFFFFFFFF');
      UploadedUserWithAllFields.add(u);
      }else{
         if(u.userName!=null && u.userName!=''){
           failedRecordEmails.add(u.userName);
         }
         AllfailedRecords.add(u.TwitterId__c);
          system.debug('DDDDDDDDDDDDDDDD '+AllfailedRecords);
        FailesRecordsuploaded.add(u);
      } 
   }  
   system.debug('PPPPPPPPPPPPPPPPPPPP '+mapEmailWithUsetUpload );  
   system.debug('RRRRRRRRRRRRRRRRRRRR '+UploadedUserWithAllFields);
   system.debug('SSSSSSSSSSSSSSSSSSSS '+AllfailedRecords);
   
   
// -------------------------------- start update,insert records and find failed Records-------------------------------------------------

  Database.SaveResult[] MySaveResultBooth =dataBase.insert(booths,false); 
  Database.saveResult[] MySaveResultUser =dataBase.insert(UploadedUserWithAllFields,false); 
  system.debug('WWWWWWWWWWWWWWWWWW '+MySaveResultUser );
      system.debug('###############  '+MySaveResultBooth);
  for(Database.saveResult SaveRes:MySaveResultUser  ){
   if(SaveRes.issuccess()){
    insertedRecordIds.add(SaveRes.getId());
   }
  } 
    
   system.debug('TTTTTTTTTTTTTTTTTT  '+mapEmailWithUsetUpload.keyset());  
   system.debug('UUUUUUUUUUUUUUUUUU'+failedRecordEmails);
   system.debug('VVVVVVVVVVVVVVVVVV'+insertedRecordIds);
     
         
   List<user> emailPasswords = new List<user>();  
    
  try{
  for(user BoothAdminUser:[select id,userName,Email from user where Id IN:insertedRecordIds]){
    System.ResetPasswordResult rt= system.ResetPassword(BoothAdminUser.id,true);
    BoothAdminUser.password__c =rt.getPassword();
     
    emailPasswords.add(BoothAdminUser);   
   
   }
      dataBase.Saveresult[] rty= dataBase.update(emailPasswords,false) ;
  }catch(exception e){
  	
  
  }  
     
   
    
    
  LIST<user> usersalredyExitsinSys = new LIST<user>();
  usersalredyExitsinSys=[SELECT id,Email,UserName from user where (userName IN :mapEmailWithUsetUpload.keyset()) AND (userName NOT IN :failedRecordEmails) and (Id NOT IN :insertedRecordIds)];
   LIST<user> updatedList = new LIST<user>();
   List<id> sendEmailToUploaded = new List<Id>(); 
   
   
  for(user updateU:usersalredyExitsinSys){
  try{
    if(mapEmailWithUsetUpload.get(updateU.userName)!=null){
       user supportUser = new user();
       supportUser=mapEmailWithUsetUpload.get(updateU.userName);
       system.debug('XXXXXXXXXXXXXXXXXX '+supportUser);
       updateU.firstName=supportUser.FirstName;
       updateU.LastName=supportUser.lastName;   
      
      if(supportUser.CompanyName!=null && supportUser.CompanyName!=''){
       updateU.CompanyName=supportUser.CompanyName;
       }
       
      if(supportUser.Company_website__c!=null && supportUser.Company_website__c!=''){
       updateU.Company_website__c=supportUser.Company_website__c;
       }
       
       if(supportUser.CompanyAddr1__c!=null && supportUser.CompanyAddr1__c!=''){
       updateU.CompanyAddr1__c=supportUser.CompanyAddr1__c;
       }
       
       if(supportUser.CompanyAddr2__c!=null && supportUser.CompanyAddr2__c!=''){
       updateU.CompanyAddr2__c=supportUser.CompanyAddr2__c;
       }
       
       if(supportUser.CompanyCity__c!=null && supportUser.CompanyCity__c!=''){
       updateU.CompanyCity__c=supportUser.CompanyCity__c;
       }
       
         if(supportUser.Country__c!=null && supportUser.Country__c!=''){
       updateU.Country__c=supportUser.Country__c;
       }
       
         if(supportUser.CompanyFaxNumber__c!=null && supportUser.CompanyFaxNumber__c!=''){
         updateU.CompanyFaxNumber__c=supportUser.CompanyFaxNumber__c;
       }
       
         if(supportUser.Companyphone__c!=null && supportUser.Companyphone__c!=''){
       updateU.Companyphone__c=supportUser.Companyphone__c;
       }
       
         if(supportUser.States__c!=null && supportUser.States__c!=''){
       updateU.States__c=supportUser.States__c;
       }
       
       
         if(supportUser.Zipcode__c!=null && supportUser.Zipcode__c!=''){
       updateU.Zipcode__c=supportUser.Zipcode__c;
       }
       
       
       updatedList.add(updateU);
    }
   Database.saveResult[] updatedRec =dataBase.update(updatedList,false);
   
  system.debug('LLLLLLLLLLLLLLLLLLL '+updatedRec );   
   
   for(Database.saveResult res:updatedRec){
   if(res.isSuccess()){
   sendEmailToUploaded.add(res.getId());
   insertedRecordIds.add(res.getId());
  }
 }
  }catch(exception e){}
  }
  
  system.debug('MMMMMMMMMMMMMMMMMM '+insertedRecordIds); 
  
  try{
     List<Messaging.SingleEmailMessage> mails= new List<Messaging.SingleEmailMessage>();
  for(user sendEmail:[select id,firstname,Name,LastName,email,userName from user where id IN :sendEmailToUploaded ]){
    string email =sendEmail.Email;
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[] { email });
    mail.setSubject('Welcome to '+eventName+' – Your registration was successful!');
    mail.setHtmlBody('Dear '+sendEmail.Name+','+'<br /><br />Congratulations!!<br />Your login for your Booth Admin Portal for Event "'
    +eventName  +'" was successfully created.<br /><br />Please visit http://www.boothleads.com to login to your Booth Admin Portal.<br /><br />If you have any questions, please contact your Event Administrator.<br /><br />Please note that your Booth Leads portal access is valid only for 30 days from the end of your event.<br />Please remember to export all your leads.<br />If you need access beyond this, please contact support.<br /><br />'
    +'Thank you!<br />BoothLeads Customer Support<br />support@boothleads.com');
    mails.add(mail);
   }
     Messaging.sendEmail(mails);
  }catch(exception e){}
  
  
  try{
  Set<string> failedrecINinsert = new Set<string>();
  LIST<user> findfailedRecords = new LIST<user>();
  findfailedRecords =[SELECT id,Email,UserName from user where id IN :insertedRecordIds];
  for(user ud:findfailedRecords){
   failedrecINinsert.add(ud.UserNAme);
  }
 
 
  boolean b =(mapEmailWithUsetUpload.keyset()).removeAll(failedrecINinsert);
   for(string gr :mapEmailWithUsetUpload.keyset()){
    AllfailedRecords.add((mapEmailWithUsetUpload.get(gr)).TwitterId__c);
  } 
system.debug('YYYYYYYYYYYYYYYYYYYYY '+AllfailedRecords);   

// -------------------------------- End update,insert records and find failed Records-------------------------------------------------
                   
  // ----------------------------------------- sending failed Records Start--------------------------    
  
   
   string failedList ;
   string defaultval =parsedCSV[0];
   defaultval =defaultval.replaceAll(';;;:::',',');
   defaultval =defaultval +'\r';
   failedList =defaultval;     
   for(string us:AllfailedRecords){
        string  s =parsedCSV[integer.valueOf(us)];
         failedList+=s+'\r';
     
     }
     
     integer csvSize = parsedCSV.size();
     
     integer  successedRecords =(csvSize-1) - AllfailedRecords.size();     
     
     String success1 =  'Number of records imported: '+(csvSize-1) + '<br/>'+
                                 'Number of records created successfully: '+successedRecords +'<br/>'+
                                 'Number of records failed: '+ AllfailedRecords.size()+'<br/><br/>';
                                 
               String emailMessage1 =  'BoothLeads.com has just completed your booth admin import process!'+'<br/><br/>'+
                                       success1 +
                                       'We strongly recommend that you check a few of your imported records to verify that your information was imported as expected.'+'<br/><br/>'+
                                       'If you encounter any problems or have any questions, please contact Boothleads Customer Support.<br/><br/>'+
                                       'Thank you! <br/> BoothLeads Customer Support <br/> support@boothleads.com' ;
                
  
   
    failedList=failedList.replaceAll(';;;:::',',');
    system.debug('66666666666666666 7777777777777777 88888888888888 '+failedList);
    blob b1=blob.valueOf(failedList);
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setFileName('Failed Records.csv');
    attach.setInline(false);
    attach.Body = b1;
     string vgf= userInfo.getUserName();
     // string vgf='phani.chimata@gmail.com';
    Messaging.singleEmailMessage  Mail = new Messaging.singleEmailMessage();
    system.debug(' 9999999999999 88888888888888 '+ vgf);
    mail.setToAddresses(new String[] {vgf});
    mail.setSubject('Import Booth Admins Summary');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
    mail.setHtmlBody(emailMessage1 );
   Messaging.SendEmailResult[] msResult= Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 


                
  
  
  
// ----------------------------------------- sent failed Records end --------------------------  
// ------------------------------------ map booth -----------------------------------

  SET<Id> setOFboothIds = new SET<Id>();
   for(Database.SaveResult BoothIds:MySaveResultBooth){
     if(BoothIds.issuccess()){
       setOFboothIds.add(BoothIds.getId()); 
     }
   }
   
   system.debug('NNNNNNNNNNNNNNNNNNNNN '+setOFboothIds); 
  List<booth__c> boothsset = new List<booth__c>([select id,BT_Name__c from booth__c where id IN:setOFboothIds]);
  system.debug('OOOOOOOOOOOOOOOOOOOOOO '+boothsset ); 
  MAP<string,id> mapBoothWithUser = new  MAP<string,id>();
  for(booth__c boothiterator:boothsset){
   mapBoothWithUser.put(boothiterator.BT_Name__c,boothiterator.id);
  }
     system.debug('PPPPPPPPPPPPPPPPPPPPPp '+mapBoothWithUser); 
  
  
  
  
   myMethod(insertedRecordIds,eventId,mapBoothWithUser);
   showselectCSV = false;
    Successbool =true; 
    
  }catch(exception e){
  	
  
  }
   return null;
 }
 
 
 
 
  @future 
  static void myMethod(SET<Id> insertedUsers,string eventidtoInsert,MAP<string,id> boothNapping) {
  try{
  system.debug('ZZZZZZZZZZZZZZZZZZZZ '+insertedUsers);
  system.debug('AAAAAAAAAAAAAAAAAAAAAA '+eventidtoInsert);
  
  MAP<string,id> mapBoothWithUser1 = new  MAP<string,id>();
  
  mapBoothWithUser1=boothNapping;
  
  List<AttendeeSummary__c> insertAttendees = new List<AttendeeSummary__c>();
  List<user> usersForattendees = new List<user>(); 
  List<id> attIds = new List<id>(); 
  usersForattendees =[SELECT id,userName,Email,firstName,LastName,companyName,Company_website__c,CompanyAddr1__c,CompanyAddr2__c,CompanyCity__c,
  CompanyCountry__c,CompanyFaxNumber__c,States__c,Country__c,Companyphone__c,CompanyState__c,Zipcode__c FROM user where id IN :insertedUsers];  
  
  for(user featureUser:usersForattendees){
   AttendeeSummary__c att = new AttendeeSummary__c();
      att.AS_FirstName__c =featureUser.firstName;
      att.AS_LastName__c=featureUser.LastName;
      att.AS_Email__c =featureUser.Email;
      att.AS_Company__c =featureUser.companyName;
      att.AS_WebsiteUrl__c =featureUser.Company_website__c;
      att.AS_WorkAddress1__c=featureUser.CompanyAddr1__c;
      att.AS_WorkAddress2__c=featureUser.CompanyAddr2__c;
      att.AS_WorkCity__c=featureUser.CompanyCity__c;
      att.AS_Work_States__c =featureUser.States__c;
      att.AS_Work_Country__c =featureUser.Country__c;
      att.AS_FaxNumber__c=featureUser.CompanyFaxNumber__c;
      att.AS_WorkPhone__c=featureUser.Companyphone__c;
      att.AS_WorkZip__c =featureUser.Zipcode__c;
      insertAttendees.add(att);
  }    
Database.UpsertResult[] MySaveResultAtt =dataBase.upsert(insertAttendees,AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(),false);
  
   for(Database.UpsertResult USR:MySaveResultAtt){
    if(USR.isSuccess()){
     attIds.add(USR.getId());
     }
   } 
    
    
   List<Event_Attendee_Mapping__c> EAMList = new List<Event_Attendee_Mapping__c>(); 
   List<Event_Attendee_Mapping__c> EAMList2 = new List<Event_Attendee_Mapping__c>(); 
 
  for(AttendeeSummary__c EAM:[select id,AS_email__c from AttendeeSummary__c where id IN:attIds]){
    Event_Attendee_Mapping__c eamInsert= new Event_Attendee_Mapping__c();
    eamInsert.AS_id__c =EAM.id;
    eamInsert.EV_id__c=eventidtoInsert;
    eamInsert.EA_AttendeeBarcode__c = EAM.id+'-'+eventidtoInsert;
    eamInsert.Attendee_Event_IDs__c=EAM.id+eventidtoInsert;
    EAMList.add(eamInsert); 
 }
 
 Database.UpsertResult[] DBUpsertEAm= dataBase.upsert(EAMList,Event_Attendee_Mapping__c.Attendee_Event_IDs__c.getDescribe().getSObjectField(),false);
 system.debug('CCCCCCCCCCCCC '+DBUpsertEAm);
 for(Event_Attendee_Mapping__c EAMValue:EAMList){
 EAMValue.EA_AttendeeBarcode__c =EAMValue.id+'-'+eventidtoInsert;
 EAMList2.add(EAMValue); 
 }
  Database.UpsertResult[] DBUpsertEAm1=database.upsert(EAMList2,Event_Attendee_Mapping__c.Attendee_Event_IDs__c.getDescribe().getSObjectField(),false);
  system.debug('DDDDDDDDDDDDDDDDDD '+DBUpsertEAm1); 
  // -------------------------------------- inserting UPE ---------------------------------------
  List<User_Profile_Event__c> AllUPEs = new List<User_Profile_Event__c>(); 
   List<User_Profile_Event__c> UPEList = new List<User_Profile_Event__c>();
   
   AllUPEs =[SELECT id,User_id__c,EV_id__c,User_id__r.id from User_Profile_Event__c where EV_id__c=:eventidtoInsert];
   set<Id> UPEUsers = new set<Id>();
   
   
   for(User_Profile_Event__c userIdsInUPE:AllUPEs){
       UPEUsers.add(userIdsInUPE.User_id__r.id);
     }
     
   Profile__c profileCustom = new Profile__c();
      profileCustom =[select id,PR_Name__c from Profile__c where PR_Name__c='BoothAdmin' limit 1];  
     
  for(user saveResultOfUser:[select id,email,companyName from user where id IN:insertedUsers]){
   if(UPEUsers.contains(saveResultOfUser.id)){
   
    } else{
     User_Profile_Event__c upe = new User_Profile_Event__c();
     upe.BT_id__c =mapBoothWithUser1.get(saveResultOfUser.companyName);
     upe.EV_id__c =eventidtoInsert;
     upe.User_id__c=saveResultOfUser.id;
     upe.BoothAdmin_id__c=saveResultOfUser.id;
     upe.status__c ='Active';
     upe.EventAdmin_Id__c=userInfo.getuserId();
     upe.UEP_isActive__c=TRUE;
     upe.Profile_id__c =profileCustom.id;
     UPEList.add(upe);
    } 
  }
  database.saveResult[] upeInsert=dataBase.insert(UPEList);
   // ------------------------------ end -------------------------------------------
   
    // ----------------------------- insert Reports ----------------------------
  List<Reports__c> rpList = new List<Reports__c>();
  List<id> upeIds = new List<Id>();
  
  for(database.saveResult saveRes:upeInsert){
    upeIds.add(saveRes.getId()); 
  }
  
  
  for(User_Profile_Event__c  uList:[select id from User_Profile_Event__c where  id IN:upeIds]){
   Reports__c rp =new Reports__c();
    rp.RE_Name__c='Report By Industry';
    rp.UPE_id__c =uList.id;
    rpList.add(rp);
    Reports__c rp2 =new Reports__c();
    rp2.RE_Name__c='Report By Geography';
    rp2.UPE_id__c =uList.id;
    rpList.add(rp2);
  }
   database.insert(rpList);
  }catch(exception e){}  
    
}

 
 






public Blob importedFile{ get; set; }
    public String fileName { get; set; }
    public user Adduser{get;set;} 
    public List<selectOption> CSVHeaders {get;set;}
    public MAP<string,string> DBField {get;set;}
    public string nameFile{get;set;}
    public List<String> allFields {get;set;} 
    public MAP<String, String> CSVHeaderMapping{get; set;}
    public LIST<String> CSVHeaderToStore{get; set;}
    public List<String> parsedCSV{get;set;}
    public List<string> dbvalue{get;set;}
    
    
   public BL_boothadmin_ImportCon(){
   DBField = new MAP<String, String>();
   dbvalue =new List<string>{'FirstName','LastName','Email','Company Name','Company Phone','Company FaxNumber','Company Website','Company Address 1','Company Address 2','Company City','Company State','Company Country','Company Zipcode'};   
           DBField.put('FirstName','FirstName');
           DBField.put('LastName','LastName');
           DBField.put('Email','Email'); 
           DBField.put('Company Name','CompanyName'); 
           DBField.put('Company Website','Company_website__c'); 
           DBField.put('Company Address 1','CompanyAddr1__c'); 
           DBField.put('Company Address 2','CompanyAddr2__c'); 
           DBField.put('Company City','CompanyCity__c'); 
           DBField.put('Company Country','Country__c'); 
           DBField.put('Company FaxNumber','CompanyFaxNumber__c'); 
           DBField.put('Company Phone','Companyphone__c'); 
           DBField.put('Company State','States__c'); 
           DBField.put('Company Zipcode','Zipcode__c'); 
      
        } 
   
   
   public string dataFromJavaScript {get;set;}

   public PageReference MapWindow() {
    parsedCSV = new List<String>();
     dataFromJavaScript =ApexPages.currentPage().getparameters().get('one');
     system.debug('hiiiiiiiiiiiii '+dataFromJavaScript );
          try{
             dataFromJavaScript = dataFromJavaScript.replaceAll('&amp;', '&');
          }catch(Exception e){
          
          }
           
    //  String fileString = dataFromJavaScript;
    
   if(dataFromJavaScript !=''){
        nameFile =dataFromJavaScript;
     
         parsedCSV = parseCSV(nameFile);
          system.debug('QQQQQQQQQQQQQQQQQQQQQQQQQQ  '+ parsedCSV[0].split(';;;:::'));
          CSVHeaders = new List<SelectOption>();
                CSVHeaderMapping = new MAP<String, String>();
                CSVHeaderToStore = new LIST<String>();
                 integer columncount = 0;
                CSVHeaders.add(new SelectOption('NONE','NONE'));
                
                 for(String ss: parsedCSV[0].split(';;;:::'))
                  {
                      CSVHeaders.add(new SelectOption(String.valueOf(columncount),ss));
                      CSVHeaderMapping.put(ss.toLowerCase(), String.valueOf(columncount));
                      CSVHeaderToStore.add(ss);
                      columncount ++;
                  }
                  
              }
              showselectCSV = true;
     passValuesToInnser();       
    system.debug('5555555555555555 '+parsedCSV );          
     return null;
 }


public void passValuesToInnser(){
  inn = new List<innclas>();
  system.debug('phaniiiiiiiiiii 11111222222222223333333 '+dbvalue+'  5555555 666666666 '+CSVHeaderMapping);
   for(string dd:dbvalue){
    inn.add(new innclas(dd,CSVHeaderMapping.get(dd.toLowerCase())));
  }
}



public List<innclas> inn{get;set;}
public class innclas{
public string selectedValue{get;set;}
public string dbFieldvalue{get;set;}
public List<selectOption> options {get;set;}

public innclas(string sd,string opt){
dbFieldvalue =sd;
selectedValue=opt;
}

}





 public List<String> parseCSV(String contents) {
         
                List<String> allFields = new List<String>();
                List<String> lines = new List<String>();
               
               system.debug('11111111111111 '+contents);
               
               string nameFile1 = contents.subString(contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
               nameFile1 = nameFile1.replace('????:::::******&&&&&&%%%%;;;;','');
               
                contents = contents.subString(0,contents.indexOf('????:::::******&&&&&&%%%%;;;;'));
                try {
                    lines = contents.split('aazz11ttt222ggg'); //correction: this only accomodates windows files
                     
                } catch (System.ListException e) {
                    System.debug('Limits exceeded?' + e.getMessage());
                }
                Integer num = 0;
                  system.debug('22222222222222TTTTTTTTT '+lines);
                  system.debug('2222222222222UUUUUUUU '+lines.size());
                  
                for(String line: lines) {
                if (line.replaceAll(',','').trim().length() == 0) break;
                   
                    List<String> fields = line.split(','); 
                   
                    String cleanFields='';
                    String compositeField;
                    Boolean makeCompositeField = false;
                    
                    for(String field: fields) {
                     field = field.trim();
                     
                       if(field == '"'){ 
             
                            compositeField += ',' + field;
                            cleanFields+=(compositeField.replaceAll('DBLQT','"')+';;;:::');
                              makeCompositeField = FALSE;
                        }else if (field.startsWith('"') && field.endsWith('"')) {
                            cleanFields+=(field.replaceAll('DBLQT','"')+';;;:::' );
           
                        } else if (field.startsWith('"')) {
          
                            makeCompositeField = true;
                            compositeField = field;
                        }else if (field.endsWith('"')) {
            
                            compositeField += ',' + field;
                            cleanFields+=(compositeField.replaceAll('DBLQT','"')+';;;:::');
                            makeCompositeField = false;
                        } else if (makeCompositeField) {
           
                            compositeField +=  ',' + field;
                        } else {
           
                            cleanFields+=(field.replaceAll('DBLQT','"')+';;;:::');
                        }
                        
                       
                     }
             
                    allFields.add(cleanFields);
                }
             
                return allFields;      
            }

   
   static testMethod void myUnitTest(){
    
    Profile__c pro = new profile__c(PR_Name__c='BoothAdmin');
   insert pro;
          
          Event__c event = new Event__c(EV_Title__c = 'Test Event', StartTime__c = '09:00 AM', EV_EndTime__c='09:00 PM',EV_StartDate__c = Date.newInstance(2012,05,01),EV_EndDate__c = Date.newInstance(2012,05,01) );
          insert event;
          
           Event__c event2 = new Event__c(EV_Title__c = 'Test Event 2', StartTime__c = '09:00 AM', EV_EndTime__c='09:00 PM',EV_StartDate__c = Date.newInstance(2012,05,01),EV_EndDate__c = Date.newInstance(2012,05,01) );
          insert event2;
          
          SecurityControls__c sc = new SecurityControls__c(EV_id__c = event.id, EV_Req_Fields__c= 'AS_FirstName__c' );
          insert sc;
          
         PageReference pageRef = Page.BL_boothadmin_Import;
          Test.setCurrentPage(pageRef);
          Apexpages.currentPage().getParameters().put('id', event.id);
          
          BL_BoothAdmin_ImportCon imp= new BL_BoothAdmin_ImportCon();
           Apexpages.currentPage().getParameters().put('id', event.id);
           
          string dataFromJavaScript = String.valueOf('FirstName,LastName,Email,CompanyName,Company Website,Company Address 1,Company Address 2,Company City,Company Country,Company FaxNumber,Company Phone,Company State,Company Zipcode \r Phani,Chimata,phanifrt@globalnest.com,"Globalnest Technologie,s","""Patrika Nagar""",Madhapur,Hyderabad,Andra Pradesh,India,500082,9550710718,9550710718,www.google.com, ????:::::******&&&&&&%%%%;;;;TestfileName'); 
           Apexpages.currentPage().getParameters().put('one', dataFromJavaScript );
          string srtr = String.valueOf('FirstName,LastName,Email,CompanyName,Company Website,Company Address 1,Company Address 2,Company City,Company Country,Company FaxNumber,Company Phone,Company State,Company Zipcode \r Phani,Chimata,phani123@globalnest.com,"Globalnest Technologie,s","""Patrika Nagar""",Madhapur,Hyderabad,Andra Pradesh,India,500082,9550710718,9550710718,www.google.com'); 
           List<string> abcd = new List<string>();
           abcd=srtr.split('\r');
           imp.MapWindow();
           imp.parsedCSV=abcd;
           imp.importValues();
             Apexpages.currentPage().getParameters().put('id', event2.id);
             string srtr2 = String.valueOf('FirstName,LastName,Email,CompanyName,Company Website,Company Address 1,Company Address 2,Company City,Company Country,Company FaxNumber,Company Phone,Company State,Company Zipcode \r Phani,Chimata,phani123@globalnest.com,"Globalnest Technologie,s","""Patrika Nagar""",Madhapur,Hyderabad,Andra Pradesh,India,500082,9550710718,9550710718,www.google.com'); 
           List<string> abcd2 = new List<string>();
             abcd2=srtr2.split('\r');
             imp.parsedCSV=abcd2;
           imp.importValues();
           
           imp.movetoBoothpage();
           imp.Attendees();
           imp.exportToCSV();
           imp.closePopup();
           
           }
   
   

}