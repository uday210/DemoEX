/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public with sharing class CommunitiesSelfRegController {

    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public string ASCompanyName{get;set;}
    public string successMSG {get;set;}
  //  public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    //public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    
    public CommunitiesSelfRegController(){}
    
    

    public PageReference registerUser() {
    
           // it's okay if password is null - we'll send the user a random password in that case
        /*if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }    
   */
        String profileId = null; // To be filled in by customer.
        String roleEnum = null; // To be filled in by customer.
        String accountId = ''; // To be filled in by customer.
        
        String userName = email;
         BLN_User_SignUP_BAL BLNuserSignupbal = new BLN_User_SignUP_BAL();
       successMSG = BLNuserSignupbal.CheckUserEmailExists( firstName ,lastName , email , ASCompanyName, password );
       addgnuser(email);
         if( successMSG != null){
            if(successMSG.toLowerCase()  == 'success'){
             sendEmail();
            return Site.login(email , password, ApexPages.currentPage().getParameters().get('startURL'));
            }else{
            system.debug('WWWWWWWWWW ' +successMSG );
               return null;
            }
       } else{
          return null;
       }   
    }
   public pagereference redirect()
    {           
        pagereference pr=new pagereference('/apex/ASC_CustomLogin?uname='+email);     
        //pagereference pr=page.ASC_CustomLogin;
        return pr;
    }
      /*  User u = new User();
        u.Username = userName;
        u.Email = email;
        u.FirstName = firstName;
        u.LastName = lastName;
        u.CommunityNickname = communityNickname;
        u.ProfileId = profileId;
        
        String userId = Site.createPortalUser(u, accountId, password);
      
        if (userId != null) { 
            if (password != null && password.length() > 1) {
                return Site.login(userName, password, ApexPages.currentPage().getParameters().get('startURL'));
            }
            else {
                PageReference page = System.Page.CommunitiesSelfRegConfirm;
                page.setRedirect(true);
                return page;
            }
        }
       
        
        return null;*/ 
        
         @Future 
    public static void addgnuser( string emailid){
    AttendeeSummary_Dao attDao = new AttendeeSummary_Dao();  
    AttendeeSummary_BAL attBal = new AttendeeSummary_BAL();
    attBal.AssignValToGnu(attDao.attSum(emailid));
    
    } 
    
    public void sendEmail(){

        Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
        email1.setSubject('Welcome to eventdex- Your registration was successful');
        
        
         List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
   
          
            LIST<String> toAddresses = new LIST<String>();  
             toAddresses.add(email);
             email1.setToAddresses(toAddresses);
             
               EmailTemplate E = new EmailTemplate();
            
                try{ 
                  E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'EventDex Signup']; 
                }catch(exception fr){}
               
             
             
              String ReplaceContactName = E.HtmlValue;
              String replacedname ;
              
              
              try{
              replacedname = ReplaceContactName.Replace('{!userName}',firstName  +' '+lastName );
             }catch(exception ed){}  
             
             String orderemail='';
  
 /* App_Setting__c app=[select id,name,event_id__c,field_code__c,event_id__r.name,field_value__c from App_Setting__c where event_id__r.name='Default Event(Boothleads)' and field_code__c='supportemail'];
  orderemail=app.field_value__c; */
  
    ///////////////////////////////////
    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'supporteventdex'];

    if ( owea.size() > 0 ) {
        email1.setOrgWideEmailAddressId(owea.get(0).Id);
    }
   
  
 system.debug('orderemail=================================================='+owea.get(0).Id);
              //email.setReplyTo(orderemail);
              //email.setSenderDisplayName(orderemail); 
              email1.setHtmlBody(replacedname);            
              EmailsList.add(email1); 
             if(EmailsList.size()>0){
                try{
                    Messaging.sendEmail(EmailsList);
                }catch(exception ecd){
                
                }
             }
    
    }
        
    }