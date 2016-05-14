public with sharing class BL_Eventadmin_SignupCon {

       
    Public string Loginname{get;set;}
    Public string Password{get;set;}
    Public Boolean Signuppopup{get;set;}
    Public User U{get;set;}
    Public string DisplayError{get;set;}
    Public String EvEmail{get;set;}
    Public BL_Pricing__c PricingTable{get;set;}
    Public Boolean SucessPopUp{get;set;}
    public User userid{get; set;}
    Public String Email {get;set;}
    public string errorMessage{get;set;}
    
   Public BL_Eventadmin_SignupCon(){//Constructor   
   
   } 
   
   Public Pagereference login(){ 
          
        errorMessage ='';
           password = password.trim();
           Loginname = Loginname.trim(); 
                          
          try{
        userid =[select Name,Profile.Name,userName,isActive,isSignup__c from user where Username=: Loginname];  
        
        if(userid.isSignup__c==true || userid.profile.Name=='Event Admin'){
             if(!userid.isActive){
                userid.isActive =true;
                dataBAse.update(userid,false);
             }
           }
        
        
        
             
        System.debug('UserName is'+userid );        
        }        
        catch(QueryException ex){        
     //  errorMessage ='Your login attempt has filed. Make sure the username and password are correct.';
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Your login attempt has failed. Make sure the username and password are correct.'));
        return null;        
        }         
         //if(userid.Profile.Name !='NJ Admin')
         
         if(userid.Profile.Name =='Event Admin'){
         return Site.login(Loginname, password, '/apex/BL_EA_Dashboard');        
         }else if(userid.Profile.Name =='Booth Admin'){
          System.debug('userid.Profile.Name'+userid.Profile.Name);  
        List<User_Profile_Event__c>  listOfupe = new List<User_Profile_Event__c>();
        listOfupe =[select id from User_Profile_Event__c where User_id__r.Email =:Loginname and (status__c !='Inactive' and status__c!='Mobile only access')];
          System.debug('ooooooooooo '+password);  
        if(listOfupe.size()>0){                            
         return   Site.login(loginname, password, '/apex/BL_BA_Dashboard');
                    
         }else{
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'User has no Privileges to access'));
         return null;
         }
         }
         else{
         // errorMessage ='User has no Privileges to access';
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'User has no Privileges to access'));
          return null;
       }     
      
    } 
   
    Public Pagereference forgotpassword(){  
        pagereference pg = new Pagereference('/apex/QRCode_NeedPassword');
        pg.setredirect(true);    
            return pg;  
    
    }
    
    
    Public void Signuppop(){
    Signuppopup = True; 
     U = new User();   
    }
    //-------------------------------------mythily----------------
   // public string errormessage{get;set;}
    public boolean error{get;set;}
    Public Pagereference EventAdminReg(){
    
    List<Account> accList = new List<Account>();
    accList = [select id from Account where Name='BoothleadsPhani'];
   
    Id accoutId;
    if(accList.size()>0){
    accoutId = accList[0].Id;   
    
    }else{
     Account acc = new account(Name='BoothleadsPhani');
     insert acc;
     accoutId =acc.Id;
    }
    
   
    
    system.debug('_____________'+evemail);
    List<User> EventAdminUserBA = [Select Username,Email From User where Username=:EvEmail];
    if(EventAdminUserBA.size() != 0){
    error=true;
    errormessage='This User is already exist';
    
    }
    //------------------------------------------------------------------------
    else{
    try{
    system.debug('_____________'+evemail);
            List<User> EventAdminUser = [Select Username,Email From User where Username=:EvEmail];
         system.debug('cccccccccccccccccccccccccccccc'+EventAdminUser );   
          system.debug('cccccccccccccccccccccccccccccc'+EventAdminUser.size());     
            if(EventAdminUser.size()>0){
            
            List<User_Profile_Event__c> FindingDuplicates = [select User_id__r.Email,User_id__r.UserName From User_Profile_Event__c where User_id__r.UserName=:EvEmail AND Profile_id__r.PR_Name__c = 'EventAdmin'];
            
            if(FindingDuplicates.size()>0){            
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Your already Registerd as Event Admin with this Email'));
            }
            else{
              //  BL_Pricing__c PricingTable = [Select Id From BL_Pricing__c Where BLP_Applicable__c = 'Event Admin' AND PR_Type__c= 'Monthly' AND  PackageName__c='Basic'];
            
              //  system.debug('======@@@@@@@ Getting Pricing Record @@@@@@ ============='+PricingTable);
            
                Profile__c EventAdmCustProfile = [Select Id from Profile__c where PR_Name__c = 'EventAdmin'];
            
                User_Profile_Event__c UPE = new User_Profile_Event__c();
                UPE.EventAdmin_Id__c = EventAdminUser[0].id;
                UPE.UEP_isActive__c = True;
                UPE.Profile_id__c = EventAdmCustProfile.id;
                UPE.User_id__c = EventAdminUser[0].id; 
                //UPE.BLP_id__c = PricingTable.Id;
                
              /**  Database.DMLOptions dmo = new Database.DMLOptions();
                dmo.EmailHeader.triggerUserEmail = true;
                UPE.setOptions(dmo); */
                
                Insert UPE; 
                
                system.debug('===========Inserting Duplicate Record in to Junction object ======='+UPE); 
                
               
            
            }
          }
           else{
    
            Profile p = [select Id,Name from Profile where Name = 'Event Admin'];
            
            system.debug('===========Getting Profile ID ======='+p); 
           
            String EmailNote = 'Welcome to BoothLeads.com Event Administration Portal.\n\nYour login details are provided at the end of this email.\n\n\nYou will be asked to set a password when you first login.Passwords are case sensitive.\nIf you forget the password, please use the forgot password link in the login page.\n\n\nTo login, go to http://www.boothleads.com and click on Login.\n\n\nFor assistance, contact us at support@boothleads.com\n\n\nOnce again Welcome to BoothLeads.com\n\n Please note that your Booth Leads portal access is valid only for 30 days from the end of your event.\nPlease remember to export all your leads.\nIf you need access beyond this, please contact support.\n\n\nThank you,\nBooth Leads Customer Support\nSupport@boothleads.com';
   
            Contact Contact = new Contact();
            Contact.Lastname = U.LastName;
            Contact.Firstname = U.firstName;
            Contact.AccountID = '001O0000007AN41';  
           // Contact.AccountID=accoutId;
            Contact.email_Notes__c =EmailNote; 
            insert Contact;
            
            system.debug('--------Contact Insertion-------'+Contact);
    
            
            //U.Contact = Contact.Id;
            system.debug('--------Contact Insertion-------'+U.Contact);
            U.ContactID = Contact.id;
            U.FirstName = U.FirstName;
            system.debug('--------Contact Insertion-------'+U.FirstName);
            U.LastName = U.LastName;
            U.Username = EvEmail;
            U.Email = EvEmail;
            U.Alias = 'EventAdm';
            U.ProfileID = P.id;
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'America/Los_Angeles';
            U.EmailEncodingKey='UTF-8';
            
           // Database.DMLOptions dmo = new Database.DMLOptions();
            //dmo.EmailHeader.triggerUserEmail = true;
            
        
            System.debug('=======:::::::::::: Inserting User into U     '+U);
           Database.insert(u);
           System.ResetPasswordResult rt= system.ResetPassword(u.id,true);
           system.debug('45454545454545454545454   '+rt);
           u.password__c =rt.getPassword();
           update u;
           System.debug('=======:::::::::::: Inserting User into U     '+U.firstname);
          Database.DMLOptions dmo = new Database.DMLOptions();
          dmo.EmailHeader.triggerUserEmail = true;
           U.setOptions(dmo);
           System.debug('=======:::::::::::: Inserting User into User Object :::::::::::========'+u);
            
           // BL_Pricing__c PricingTable1 = [Select Id From BL_Pricing__c Where BLP_Applicable__c = 'Event Admin' AND PR_Type__c= 'Monthly' AND  PackageName__c='Basic'];
            
            system.debug('======@@@@@@@ Getting Pricing Record @@@@@@ ============='+PricingTable);
            
            Profile__c EventAdmCustProfile1 = [Select Id from Profile__c where PR_Name__c = 'EventAdmin'];
            
           
            
            User_Profile_Event__c UPE = new User_Profile_Event__c();
            UPE.EventAdmin_Id__c = U.id;
            UPE.UEP_isActive__c = True;
            UPE.Profile_id__c = EventAdmCustProfile1.id;
            UPE.User_id__c = U.id; 
           // UPE.BLP_id__c = PricingTable1.Id;
            
            Insert UPE; 
           system.debug('======@@@@@@@ Inserting in to Junction Object @@@@@@ ============='+UPE);
           
          
           
           
           
     }         
                List<AttendeeSummary__c> AttendeeDetails = [select  id,Name,AS_Email__c from AttendeeSummary__c Where AS_uniqueField__c =:(U.FirstName+ U.LastName+EvEmail).tolowercase()];
                
                system.debug(' ===== Alredy Existed Attendee Email Id ===='+AttendeeDetails);
                
                if(AttendeeDetails.size() > 0){
                /**
                List<Event_Attendee_Mapping__c> EventAttendeeJun = [select id,EV_id__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c =: EvEmail];
                system.debug('========================= Attendee is inserted in Junction Object Or not ==========='+EventAttendeeJun );
                
                if(EventAttendeeJun.size()>0){}
                else{
                
                    Event_Attendee_Mapping__c InsertinginJun = new Event_Attendee_Mapping__c();
                    InsertinginJun.AS_id__c = AttendeeDetails[0].id;
                    //InsertinginJun.EV_id__c = selectEvent;
                   // InsertinginJun.Attendee_Event_IDs__c  = AttendeeDetails[0].Name + EventAttendeeJun[0].EV_id__r.Name;
                    insert InsertinginJun; 
                
                
                }*/
            }else {
                       AttendeeSummary__c AttendeeSummary = new AttendeeSummary__c();
                       AttendeeSummary.AS_Email__c = EvEmail;
                       AttendeeSummary.AS_FirstName__c = U.FirstName;
                       AttendeeSummary.AS_LastName__c = U.LastName;
                       AttendeeSummary.AS_uniqueField__c=(U.FirstName + U.LastName + EvEmail).tolowercase();
                       insert AttendeeSummary ;
                }    
           
           SucessPopUp = true;
           Signuppopup = false;
           EvEmail='';
   }
   catch(Exception e){
   ApexPages.addMessages(e);
   }  
   } 
      return null;
  }
  
  Public void CancelSignUp(){
  Signuppopup = False;
  errormessage = '';
  EvEmail='';
  error = FALSE;
  }
  
  Public Void SuccesPopUpClose(){
   SucessPopUp = False;
  }
  
 //----------------------------------------------Test Classes-------------- 
  public Pagereference checkuserName(){

     
       
       if(userInfo.getUserType()=='guest'){
         System.debug('AAAAAAAAAAAAAAAAAAAAAAA    ');  
            return null;
       } else {
           
               userid =[select Name,Profile.Name from user where ID=: userInfo.getUserId()]; 
               
             if(userid.Profile.Name =='Event Admin'){
             
                 pagereference pg = new Pagereference('/BL_EA_Dashboard');
                pg.setredirect(true);    
                return pg;  
                     
             }else if(userid.Profile.Name =='Booth Admin'){
                
                 List<User_Profile_Event__c>  listOfupe = new List<User_Profile_Event__c>();
                listOfupe =[select id from User_Profile_Event__c where User_id__r.ID =: userInfo.getUserId() and (status__c !='Inactive' and status__c!='Mobile only access')];
                  if(listOfupe.size()>0){   
                    pagereference pg = new Pagereference('/BL_BA_Dashboard');
                    pg.setredirect(true);    
                    return pg;
             }     
             
           }else if(userid.Profile.Name =='BoothPersonnel'){
                
                 List<User_Profile_Event__c>  listOfupe = new List<User_Profile_Event__c>();
                listOfupe =[select id from User_Profile_Event__c where User_id__r.ID =: userInfo.getUserId() and (status__c !='Inactive' and status__c!='Mobile only access')];
                  if(listOfupe.size()>0){   
                    pagereference pg = new Pagereference('/BL_EventAdmin_Events');
                    pg.setredirect(true);    
                    return pg;
             }     
             
           }
          return null;
    }
    
  }
   


  
}