public without sharing class BLN_SignUpCon{
/***********************************************************************************************
*   Controller Name : BLN_SignUpCon 
*   Date            : 07/05/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is for Login And Sign Up for User
*   Change History  : 07/05/2014 

*   Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   07/05/2014         Phani Kumar Ch                  To Create Page 
**************************************************************************************************/
   
    public String ASUserEmail { get; set; } // user Email
    public String ASLastName { get; set; } // User Last Name
    public String ASFirstName { get; set; } // User First Name
    public String ASCompanyName { get; set; } // User Company
    public string password {get;set;} // Password

    public string loginName{get;set;} // login user name
    public string loginPassword{get;set;} // login user 
   
   
    public boolean Successbool { get; set; } // To display Success message after sign up
    public string error{get;set;} // Error Message
    public boolean forDisplayError{get;set;} // boolean to render error
    public string successMSG{get;set;}
    
    public void BLN_SignUpCon(){
    
    }
   
   
    public pageReference BLS_SignUpUser(){
    
         BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
         IF((ASCompanyName!=NULL && ASCompanyName !='')){
            
         }
        successMSG = BLNuserSignupbal.CheckUserEmailExists( ASFirstName ,ASLastName , ASUserEmail , ASCompanyName, password  );
        addgnuser(ASUserEmail);
        
        Successbool = false;
       
       if( successMSG != null){
            if(successMSG.toLowerCase()  == 'success'){
                Successbool = true;
                sendEmail();
                forDisplayError =false;
            }else{
                Successbool = false;
                forDisplayError =true;
                error = successMSG ;
            }
       }   
       
       return null;
    }
    
   
    
    
    
    public PageReference signUpLogin(){
        ASUserEmail = ASUserEmail.trim();
        password= password.trim();
        addgnuser(ASUserEmail);
        
        list<BLN_Event__c> ListOfEvents= new  list<BLN_Event__c>();
       
        BLN_Events_DAO eventsdao = new BLN_Events_DAO();
        BLN_Gnuser_DAO GNDAO = new BLN_Gnuser_DAO ();
        GN_User__c GNUSER = GNDAO.existingGnuser(ASUserEmail);
        
        LIST<Ticket__c> tics = [SELECT id,Event__c FROM Ticket__c WHERE (TKT_Profile__r.BLN_GN_User__c =: GNUSER.id  OR Order__r.BLN_TKT_profile__r.BLN_GN_User__c =: GNUSER.id) AND Ticket_Status__c = 'Booked'];
        LIST<id> ids = new LIST<id> ();
        SET<id> idset = new SET<id>();
       for(Ticket__c GNTICS : tics){
         if(idset.add(GNTICS.Event__c)){
              ids.add(GNTICS.Event__c);}
        }
        
        ListOfEvents = eventsdao.getBuyerEventDetails(ids);
        
       if(ListOfEvents.size() != 0){
       system.debug('uservents==');
        return  Site.login(ASUserEmail , password, '/apex/BLN_UserEvents');
        }
        else{
        system.debug('BLN_SignupSuccess==');
        return  Site.login(ASUserEmail , password, '/apex/BLN_SignupSuccess'); 
    }
    }
    
    @Future 
    public static void addgnuser( string emailid){
    AttendeeSummary_Dao attDao = new AttendeeSummary_Dao();  
    AttendeeSummary_BAL attBal = new AttendeeSummary_BAL();
    attBal.AssignValToGnu(attDao.attSum(emailid));
    
    } 
    
    public pageReference login(){
        forDisplayError = false;
        error='';
        loginName = loginName.trim();
        loginPassword = loginPassword.trim();
        system.debug(' gggggg '+loginName);
        List<user> usr = [SELECT Id,IsSignup__c from User where userName=:loginName];
       
       if(usr.size()>0){ 
        system.debug(' HHHHHHHHHHHHHHH '+usr);
        if(usr[0].IsSignup__c ==true){
        pageReference pg =Site.login(loginName,loginPassword ,'/apex/BLN_UserEvents');
         if(pg !=null){
            AttendeeSummary_BAL  AttBal = new AttendeeSummary_BAL ();
            AttendeeSummary_Dao  attDao = new AttendeeSummary_Dao ();
            AttBal.AssignValToGnu(attDao.attSum(loginName)) ;
            return   pg;
        }
        else{
            error='Your login attempt has failed. Make sure the username and password are correct.';
            forDisplayError = true;
            return null;
        }
       }else{
         error='This ID is not signed up. Please Sign Up.';
         forDisplayError = true;
          system.debug(' Error '+error);
         return null;
       } 
      }else{
        error='User does not exist.';
        forDisplayError = true;
         system.debug(' Error '+error);
        return null;
      }
    }
    
    
    public PageReference redirectIfLoggedIn() {
    if (UserInfo.getUserType() != 'Guest') {
        PageReference loggedInPage = new PageReference('/secur/logout.jsp');
        return loggedInPage;
    }
    // Guest user so just display as usual.
    return null;
    }


    public void sendEmail(){

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject('Welcome to eventdex- Your registration was successful');
        
        
         List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
   
          
            LIST<String> toAddresses = new LIST<String>();  
             toAddresses.add(ASUserEmail);
             email.setToAddresses(toAddresses);
             
               EmailTemplate E = new EmailTemplate();
            
                try{ 
                  E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'EventDex Signup']; 
                }catch(exception fr){}
               
             
             
              String ReplaceContactName = E.HtmlValue;
              String replacedname ;
              
              
              try{
              replacedname = ReplaceContactName.Replace('{!userName}',ASFirstName  +' '+ASLastName );
             }catch(exception ed){}  
             
             String orderemail='';
  
 /* App_Setting__c app=[select id,name,event_id__c,field_code__c,event_id__r.name,field_value__c from App_Setting__c where event_id__r.name='Default Event(Boothleads)' and field_code__c='supportemail'];
  orderemail=app.field_value__c; */
  
    ///////////////////////////////////
    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

    if ( owea.size() > 0 ) {
        email.setOrgWideEmailAddressId(owea.get(0).Id);
    }
   
  
 system.debug('orderemail=================================================='+owea.get(0).Id);
              //email.setReplyTo(orderemail);
              //email.setSenderDisplayName(orderemail); 
              email.setHtmlBody(replacedname);            
              EmailsList.add(email); 
             if(EmailsList.size()>0){
                try{
                    Messaging.sendEmail(EmailsList);
                }catch(exception ecd){
                
                }
             }
    
    }

}