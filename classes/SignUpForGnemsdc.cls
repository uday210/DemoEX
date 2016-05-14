@RestResource(urlMapping='/SignUpForGnemsdc/*')
 /**
 * AUTHOR: Phani
 * Email : phani@globalnest.com
 * Phone : 9550710718
 * AIM   : sending facabook friends attend status to user
 */
  global with sharing class SignUpForGnemsdc{  
   
   @HttpPost
   global static string doPost(){
      RestRequest req = RestContext.request;
      RestResponse res = RestContext.response;
      string email ;string selectedvalue ;
      string passWord;string EventId;string error; string Message;
      email =req.params.get('userName');
      passWord=req.params.get('passWord');
      selectedvalue = req.params.get('userType');
     
     
     List<Booth_Product__c> BlPrice = new List<Booth_Product__c>();
      BlPrice  =[select id,BP_ProductName__c,isMobile__c from Booth_Product__c where isMobile__c=true];
        if(BlPrice.size()>0){
           EventId =BlPrice[0].BP_ProductName__c;  
        }
         email = email.tolowercase().trim();
         
            List<Event_Attendee_Mapping__c> evenAtt = new List<Event_Attendee_Mapping__c>();
              evenAtt =[select id,AS_id__r.AS_Email__c,AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.id,AS_id__r.AS_Company__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:email and EV_id__c=:EventId];
                if(evenAtt.size()>0){
                  List<user> users = new List<user>();                 
                  users =[select id,userName,email,isSignup__c from user where userName=:email];
                    if(users.size()>0){
                       List<User_Profile_Event__c> upeList = new List<User_Profile_Event__c>();     
                       upeList =[select id from User_Profile_Event__c where EV_id__c=:EventId and User_id__r.UserName=:email]; 
                         if(upeList.size()>0){
                              if(users[0].isSignup__c!=true){
                              upeList[0].UEP_isActive__c = True;
                              upeList[0].IsMatchMakingUser__c = true;
                              if(selectedvalue=='Corporate'){
                                 upeList[0].Request_for_upgrade_profile__c = true;
                                 upeList[0].MAtchMakingProfile__c =selectedvalue;
                                  Message ='Sign Up is Successful! The Event Admin needs to approve your Matchmaking registration as a Corporate';
                              }else{
                                 upeList[0].MAtchMakingProfile__c =selectedvalue;
                                 Message ='Success';
                              }
                                                            
                              DataBase.saveResult savres = dataBase.update(upeList[0],false);
                              forupdateEAM(email,password);
                              if(savres.isSuccess()){
                                
                             }
                              
                             }else{
                              Message ='You have already signed up!';
                             
                             } 
                         }else{
                         
                         } 
                                              
                     
                    }else{
                         profile p = [select Id,Name from Profile where Name = 'Attendee' Limit 1];
                                        user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
                                        account acc=new account();
                                        acc.name='Booth Leads';  
                                        acc.ownerid=uname.createdby.id;          
                                        insert acc; 
                   
                                        Contact Contact = new Contact();
                                        Contact.Lastname = evenAtt[0].AS_id__r.AS_LastName__c;
                                        Contact.Firstname = evenAtt[0].AS_id__r.AS_FirstName__c;
                                        Contact.AccountID = acc.id;
                                        insert Contact;
                                        user u = new user();
                                        
                                        U.ContactID = Contact.id;
                                        U.FirstName = evenAtt[0].AS_id__r.AS_FirstName__c;
                                        system.debug('--------Contact Insertion-------'+U.FirstName);
                                        U.LastName = evenAtt[0].AS_id__r.AS_LastName__c;
                                        U.Username = email;
                                        U.Email = email;
                                        U.Alias = 'EventAdm';
                                        u.isSignup__c = true;
                                        u.IsActive = true;
                                        U.ProfileID = P.id;
                                        U.LocaleSidKey = 'en_US';
                                        U.LanguageLocaleKey = 'en_US';
                                        U.TimeZoneSidKey = 'America/Los_Angeles';
                                        U.EmailEncodingKey='UTF-8';
                                        u.Password__c =password;
                                        Database.insert(u);
                                        system.setPassword(u.id,password);
                                        
                                // user profile event insert
                                       Profile__c attendeeProfile= [Select Id from Profile__c where PR_Name__c ='Attendee' ];
                                       User_Profile_Event__c UPE = new User_Profile_Event__c();
                                       UPE.UEP_isActive__c = True;
                                       UPE.IsMatchMakingUser__c = true;
                                       UPE.EV_id__c   =eventId;
                                       UPE.Profile_id__c = attendeeProfile.id;
                                       UPE.User_id__c = u.id; 
                                       UPE.Attendee_Summary__c = evenAtt[0].AS_id__r.id;
                                       if(selectedvalue == 'Corporate'){
                                         UPE.Request_for_upgrade_profile__c = true;
                                            if(UPE.BT_id__c==null){
                                                   Booth__c Booth  = new Booth__c();
                                                   booth.EV_id__c =EventId;
                                                   booth.BT_Name__c =evenAtt[0].AS_id__r.AS_Company__c;
                                                   insert booth;
                                                   UPE.BT_id__c =Booth.id;
                                                   UPE.BoothAdmin_id__c =u.id;
                                               }
                                         Message ='Sign Up is Successful! The Event Admin needs to approve your Matchmaking registration as a Corporate';
                                         
                                       }
                                       
                                       UPE.MAtchMakingProfile__c=selectedvalue;
                                       dataBase.saveResult saveres = dataBase.Insert(UPE,false);        
                                      if(saveres.isSuccess()){
                                        if(Message!='Sign Up is Successful! The Event Admin needs to approve your Matchmaking registration as a Corporate'){
                                          Message ='Success';
                                         
                                        } 
                                        if(selectedvalue == 'MBE'){
//------------------------------------------------------------------------------------------------------------                                        
                                        EmailTemplate E = new EmailTemplate();    
                             E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking MBE Welcome Email'];     
                             
                             list < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
                             Messaging.SingleEmailMessage emailsend = new Messaging.SingleEmailMessage();
                             OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Jerilynn Clarke'];
                                 if(owea.size() > 0 ) {
                                          emailsend.setOrgWideEmailAddressId(owea.get(0).Id);
                                 } 
                          String[] toaddress = new String[] {
                          email
                          };
                          emailsend.setToAddresses(toaddress);   
                          String subject = E.Subject;
                          String ReplaceContactName = E.HtmlValue;
                          String replacedname1 = ReplaceContactName.Replace('{!Name}',evenAtt[0].AS_id__r.AS_FirstName__c + ' ' + evenAtt[0].AS_id__r.AS_LastName__c);                          
                          emailsend.setSubject(subject);    
                          emailsend.setHtmlBody(replacedname1); 
                          emails.add(emailsend);     
                          Messaging.SendEmailResult[] r = Messaging.sendEmail(emails);
//---------------------------------------------------------------------------------------------------------------------                                        
                                        }                                  
                                     } 
                             }
                
                
                 }else{
                  message = 'You must be registered for the GNEMSDC event prior to the Matchmaking sign up.';
                 
               }
               return MEssage;
           
           }
      @future
   
    public static void forupdateEAM(string emails,string passs){
     user u = new user ();
     u=[select id,isactive,isSignup__c,username from user where userName=:emails];
     
     u.isActive =true;
     u.isSignup__c =true;
     u.password__c =passs;
     dataBase.update(u,false);
     system.setPassword(u.id,passs);
    }   
 }