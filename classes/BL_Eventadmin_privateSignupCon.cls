public without sharing class BL_Eventadmin_privateSignupCon {

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
    
    
    Public BL_Eventadmin_privateSignupCon(){//Constructor   
        U = new User();
    } 
    
    
    
    /**
    Public void Signuppop(){
    Signuppopup = True; 
    U = new User();   
    }
    */
    //-------------------------------------mythily----------------
    public string errormessage{get;set;}
    public boolean error{get;set;}
    
    Public Pagereference EventAdminReg(){
        system.debug('_____________'+evemail);
        try{
            List<User> EventAdminUser = [Select Username,Email From User where Username=:EvEmail];
            if(EventAdminUser.size()>0){
                error=true;
                errormessage='User already exist';                
            }
            else{
            
                Profile p = [select Id,Name from Profile where Name = 'Event Admin'];
                
                system.debug('===========Getting Profile ID ======='+p); 
                
                String EmailNote = 'Welcome to BoothLeads.com Event Administration Portal.\n\nYour login details are provided at the end of this email.\n\n\nYou will be asked to set a password when you first login.Passwords are case sensitive.\nIf you forget the password, please use the forgot password link in the login page.\n\n\nTo login, go to http://www.boothleads.com and click on Login.\n\n\nFor assistance, contact us at support@boothleads.com\n\n\nOnce again Welcome to BoothLeads.com\n\n Please note that your Booth Leads portal access is valid only for 30 days from the end of your event.\nPlease remember to export all your leads.\nIf you need access beyond this, please contact support.\n\n\nThank you,\nBooth Leads Customer Support\nSupport@boothleads.com';
                
                String EmailSubject = 'Welcome to Booth Leads - Your registration was successful';
                //--------Mythily for giving id dynemically------------
                user uname=[select createdby.id from user where profile.Name Like 'System Administrator' Limit 1];
                
                account acc=new account();
                acc.name='Booth Leads';  
                
                acc.ownerid=uname.createdby.id;          
                insert acc; 
                
                
                //account acct=[SELECT Owner.Name FROM account WHERE Id =: acc.id].Owner.Name;          
                System.debug([SELECT Owner.Name FROM account WHERE Id =: acc.id].Owner.Name);
                
                Contact Contact = new Contact();
                Contact.Lastname = U.LastName;
                Contact.Firstname = U.firstName;
                // Contact.AccountID = '001F000000qdOJp';  
                Contact.AccountID = acc.id;
                //Contact.AccountID = '001O0000007AN41';
                
                Contact.Email_Notes__c =EmailNote; 
                Contact.Email_Subject__c = EmailSubject;
                insert Contact;
                
                system.debug('--------Contact Insertion-------'+Contact);
                
                
                //U.Contact = Contact.Id;
                
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
                Database.insert(u);

                Profile__c EventAdmCustProfile1 = [Select Id from Profile__c where PR_Name__c = 'EventAdmin'];
                
                User_Profile_Event__c UPE = new User_Profile_Event__c();
                UPE.EventAdmin_Id__c = U.id;
                UPE.UEP_isActive__c = True;
                UPE.Profile_id__c = EventAdmCustProfile1.id;
                UPE.User_id__c = U.id; 
                // UPE.BLP_id__c = PricingTable1.Id;
                Insert UPE; 
                system.debug('======@@@@@@@ Inserting in to Junction Object @@@@@@ ============='+UPE);
                
                List<AttendeeSummary__c> AttendeeDetails = [select  id,Name,AS_Email__c from AttendeeSummary__c Where AS_Email__c=:EvEmail];
                
                system.debug(' ===== Alredy Existed Attendee Email Id ===='+AttendeeDetails);
                
                if(AttendeeDetails.size() > 0){
                
                }else {
                AttendeeSummary__c AttendeeSummary = new AttendeeSummary__c();
                AttendeeSummary.AS_Email__c = EvEmail;
                AttendeeSummary.AS_FirstName__c = U.FirstName;
                AttendeeSummary.AS_LastName__c = U.LastName;
                AttendeeSummary.AS_Company__c = U.CompanyName;
                AttendeeSummary.AS_uniqueField__c=(U.FirstName + U.LastName + EvEmail).tolowercase();
                insert AttendeeSummary ;
                }    
                
                SucessPopUp = true;
                Signuppopup = false;
                EvEmail='';
                updateUser(U.Id);
            }         

        }
        catch(Exception e){
            ApexPages.addMessages(e);
        } 
        
        return null;
    }
    
    @future
    public static void updateUser(Id UserId){
           User U1 = new User();
           U1 =[SELECT Id,Email,password__c FROM User WHERE Id =: UserId];
           System.ResetPasswordResult rt= system.ResetPassword(U1.id,true);
           U1.password__c =rt.getPassword();
           update U1;
    }
    
    
    Public void CancelSignUp(){
        Signuppopup = False;
        errormessage = '';
        EvEmail='';
        error = FALSE;
    }
    
    Public pagereference SuccesPopUpClose(){
        SucessPopUp = False;
        pagereference pg= new pagereference('/apex/BL_Eventadmin_Signup');
        pg.setRedirect(true);
        return pg;
    }
    
    //----------------------------------------------Test Classes-------------- 
    public Pagereference checkuserName(){
    
        if(userInfo.getUserType()=='guest'){
            System.debug('AAAAAAAAAAAAAAAAAAAAAAA    ');  
            return null;
        } else {
        
            userid =[select Name,Profile.Name from user where ID=: userInfo.getUserId()]; 
            
            if(userid.Profile.Name =='Event Admin'){
            
                pagereference pg = new Pagereference('/BL_EventAdmin_Dashboard');
                pg.setredirect(true);    
                return pg;  
            
            }else if(userid.Profile.Name =='Booth Admin'){
            
                List<User_Profile_Event__c>  listOfupe = new List<User_Profile_Event__c>();
                listOfupe =[select id from User_Profile_Event__c where User_id__r.ID =: userInfo.getUserId() and (status__c !='Inactive' and status__c!='Mobile only access')];
                if(listOfupe.size()>0){   
                    pagereference pg = new Pagereference('/BL_BoothAdmin_Dashboard');
                    pg.setredirect(true);    
                    return pg;
                }     
            
            }
            return null;
        }
    
    }

}