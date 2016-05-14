public without sharing class SA_SignUpController {

//------------------------------------------------- Variable Declaration Start -------------------------------------------------------------------
public User U{get;set;}
public List<User> EventAdminUser{get;set;}
public User_Profile_Event__c UPE{get;set;}
public String errormessage{get;set;}
public Boolean signupbool{get;set;}
public String ASFirstName{get;set;}
public String ASLastName{get;set;}
public String ASUserEmail{get;set;}
public String ASCompanyName{get;set;}
public LIST<User_Profile_Event__c> upelist{get;set;}
public Contact Con{get;set;}
public AttendeeSummary__c AttendeeSummary{get;set;}
public Boolean Successbool{get;set;}
//------------------------------------------------- Variable Declaration End -------------------------------------------------------------------

    Public String Loginname{get;set;}
    Public String Password{get;set;}
    Public User userid{get; set;}
    
    /*
    public PageReference Login() {
        system.debug('$$$$');
        errorMessage ='';
        Password = Password.trim();
        Loginname = Loginname.trim(); 
        try{
            userid =[SELECT Name,Profile.Name FROM User WHERE Username=: Loginname AND ScanAttendee_User__c =: TRUE]; 
            System.debug('UserName is'+userid ); // AND ScanAttendee_User__c =: TRUE
            return Site.login(Loginname, Password , '/SA_ManageEvents');                
        }        
        catch(QueryException ex){        
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Your login attempt has failed. Make sure the username and password are correct.'));
            return null;        
        }      
        return Site.login(Loginname, Password , '/SA_ManageEvents');         
    }
    */
    
     public PageReference Login() {
        system.debug('$$$$');
        errorMessage ='';
        Password = Password.trim();
        Loginname = Loginname.trim(); 
        try{
            userid=[SELECT ID, Name, Profile.Name, ScanAttendee_User__c, isActive FROM User WHERE Username=: Loginname];
            System.debug(userid.ScanAttendee_User__c+'  UserName is  '+Loginname); 
                 
            if(userid.ScanAttendee_User__c == FALSE){
                userid.ScanAttendee_User__c= TRUE;
                Database.Update(userid, FALSE);
            }
            //AND Attendee_Summary__r.AS_Email__c =: Loginname
            LIST<User_Profile_Event__c> UPEList= new LIST<User_Profile_Event__c>();
            UPEList= [SELECT ID FROM User_Profile_Event__c WHERE User_id__c =: userid.ID AND UEP_isActive__c =: TRUE ];
            if(UPEList.size() >0){
                return Site.login(Loginname, password, '/SA_ManageEvents');     
            }
        
        }catch(QueryException ex){        
           
            System.debug( ' exception eeeeeeeeeee  '+ex);        
        
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Your login attempt has failed. Make sure the username and password are correct.'));
            return null;        
        }      
        
        
        return null;
            
    }
    
//------------------------------------------------- Constructor Start -------------------------------------------------------------------
    public SA_SignUpController(){
        U = new User();
    }
//------------------------------------------------- Constructor End -------------------------------------------------------------------

//------------------------------------------------ Sign Up Method Start -----------------------------------------------------------------
    public void BLS_SignUpUser(){
     //  try
    //   {      
        system.debug('$$$$ '+ASUserEmail);  
        List<User> EventAdminUser = [SELECT Username,Email,ScanAttendee_User__c FROM User WHERE Username=:ASUserEmail];

        if(EventAdminUser.size()>0  && EventAdminUser[0].ScanAttendee_User__c == TRUE){
            signupbool = true;
            errormessage = 'User already exists';                
        }
        else if(EventAdminUser.size()>0 && EventAdminUser[0].ScanAttendee_User__c == FALSE){
            for(User uc:EventAdminUser){
                uc.IsActive= TRUE;
                uc.ScanAttendee_User__c = TRUE;
            }
            database.update(EventAdminUser);
            //updateUser(EventAdminUser[0].Id, password);
            Successbool = true;
        }
        else{
        signupbool = false;

            String EmailNote = 'Welcome to Scan Attendee Event Administration Portal.\n\nYour login details are provided at the end of this email.\n\n\nYou will be asked to set a password when you first login.Passwords are case sensitive.\nIf you forget the password, please use the forgot password link in the login page.\n\n\nTo login, go to http://www.boothleads.com and click on Login.\n\n\nFor assistance, contact us at support@boothleads.com\n\n\nOnce again Welcome to BoothLeads.com\n\n Please note that your Scan Attendee portal access is valid only for 30 days from the end of your event.\nPlease remember to export all your leads.\nIf you need access beyond this, please contact support.\n\n\nThank you,\n Scan Attendee Customer Support\nsupport@boothleads.com';
            
            String EmailSubject = 'Welcome to Scan Attendee - Your registration was successful';
            
            user uname=[SELECT Id,CreatedById,isActive FROM User WHERE profile.Name =: 'System Administrator' AND isActive=: true LIMIT 1];
            Account acc = new Account();
            acc.name='Scan Attendee';     
            acc.ownerid = uname.id;         
            insert acc; 
            
            system.debug('!!!! '+acc);
            Con = new Contact();
            Con.Lastname = ASLastName;
            Con.Firstname = ASFirstName; 
            Con.AccountID = acc.id;
            Con.Email_Notes__c = EmailNote; 
            Con.Email_Subject__c = EmailSubject;
            insert Con;
            system.debug('@@@@ '+acc);
            List<AttendeeSummary__c> AttendeeDetails = [SELECT Id,Name,AS_Email__c FROM AttendeeSummary__c WHERE AS_Email__c=: ASUserEmail];
            AttendeeSummary = new AttendeeSummary__c(); 
            if(AttendeeDetails.size() > 0){   
            }
            else{
               AttendeeSummary.AS_Email__c = ASUserEmail;
               AttendeeSummary.AS_FirstName__c = ASFirstName;
               AttendeeSummary.AS_LastName__c = ASLastName;
               AttendeeSummary.AS_uniqueField__c=(ASFirstName + ASLastName + ASUserEmail).tolowercase();
               insert AttendeeSummary;               
            }   

            Profile P = [SELECT Id,Name FROM Profile WHERE Name = 'Event Admin'];
            system.debug('$$$$ '+ASFirstName+' '+ASLastName+' '+ASUserEmail);
            U = new User();        
            U.ContactID = Con.id;
            U.FirstName = ASFirstName;
            U.LastName = ASLastName;
            U.Username = ASUserEmail;
            U.Email = ASUserEmail;
            U.CompanyName= ASCompanyName;
            U.Alias = 'SAUser';
            U.ProfileID = P.id;
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'America/Los_Angeles';
            U.EmailEncodingKey='UTF-8';
            U.ScanAttendee_User__c=TRUE;
            U.isSignup__c=true;
            U.password__c = password;
            Database.insert(U);

            updateUser(U.Id, password);
            insertUpe(U.id,AttendeeSummary.Id);
            //close();
            Successbool = true;
          }
   //    }
    //   catch(Exception e){
     //        ApexPages.addMessages(e);
     //  }  
    }

    @future
    public static void updateUser(Id UserId, String pwd){
           User U1 = new User();
           U1 =[SELECT Id,password__c FROM User WHERE Id =: UserId];
           System.setPassword(U1.Id, U1.Password__c);
           //System.ResetPasswordResult rt= system.ResetPassword(U1.id,true);
           //U1.password__c = pwd;
           //update U1;
    }
    
    @future
    public static void insertUpe(Id UserId1, Id attid1){
    
        Profile__c ASProfile = [SELECT Id FROM Profile__c WHERE PR_Name__c = 'EventAdmin'];
        
        BL_Pricing__c PricingTableList = [SELECT Id,BLP_AccountType__c,BLP_UserLimit__c,BLP_EventLimit__c,BLP_AttendeeLimit__c,BLP_Amount__c,BLP_SignUp__c,PR_Type__c,App_Access__c FROM BL_Pricing__c WHERE BLP_AccountType__c=:'Free' LIMIT 1];
        
        User_Profile_Event__c UPE = new User_Profile_Event__c();
        UPE.EventAdmin_Id__c = UserInfo.getUserId();
        UPE.BLP_id__c = PricingTableList.Id;
        upe.Attendee_Summary__c = attid1;
        UPE.UEP_isActive__c = True;
        UPE.Profile_id__c = ASProfile.id;
        UPE.User_id__c = UserId1; 
        insert UPE;    
        
        
        User_Pricing__c UP = new User_Pricing__c();
        UP.User__c = UserId1;
        UP.Pricing__c = PricingTableList.id;
        UP.AttendeeLimit__c = PricingTableList.BLP_AttendeeLimit__c;
        insert UP;      
    }
//------------------------------------------------- Sign Up Method End -------------------------------------------------------------------

//------------------------------------------------ Cancel Sign Up Method Start -----------------------------------------------------------
public Pagereference BLS_CancelSignUpUser(){
    pagereference pg = new Pagereference('/apex/SA_Signup');
    pg.setredirect(true);    
    return pg;
}

    
public PageReference forgotPassword() {
    pagereference pg = new Pagereference('/SA_ForgotPassword');
    pg.setredirect(true);    
    return pg;
}
    
//------------------------------------------------- Cancel Sign Up Method End ------------------------------------------------------------

//--------------------------------------------- Succesful Sign Up PopUp Method Start -------------------------------------------------------
public PageReference close() {
    Successbool = false;
    errorMessage ='';
    system.debug('&&&& '+u+'$$$$ '+U.Email+'%%%% '+U.password__c);
    Password = U.password__c.trim();
    Loginname = U.Email.trim(); 
    try{
        userid =[SELECT Name,Profile.Name FROM User WHERE Username=: Loginname]; 
        System.debug('UserName is'+userid );        
    }        
    catch(QueryException ex){        
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Your login attempt has failed. Make sure the username and password are correct.'));
        return null;        
    }      
    return Site.login(Loginname, password, '/SA_ManageEvents');
}
//--------------------------------------------- Succesful Sign Up PopUp Method End ----------------------------------------------------------
}