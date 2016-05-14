public without sharing class MM_NewSignupCon {

   

    public boolean regerror {get ; set ;}
    public list<Event_Attendee_Mapping__c> eamlist {get ; set ;}
    public List<user> users{get ; set ;} 
    public boolean userpwderror{get;set;}
    public String userpwderrormsg{get;set;}
    public PageReference gtDetails() {
    lastName = '';
           firstName  = '';
           company = '';
     existbool =false;
    errorboolexist =false;
    forDisplayError =false;
    userpwderror=false;
    userpwderrormsg='';
       regerror = false;
       List<AttendeeSummary__c> attget = [select id,AS_Firstname__C,AS_LastNAme__c,AS_company__c from AttendeeSummary__c where AS_Email__c=:Apexpages.currentPage().getPArameters().get('emailvalue')];  
        if(attget.size()>0){
        list<Event_Attendee_Mapping__c> eamlist = [select id from Event_Attendee_Mapping__c where EV_id__c != null AND AS_id__r.id IN: attget];
         if(eamlist.size()>0){
           lastName = attget[0].AS_LastNAme__c;
           firstName  = attget[0].AS_firstNAme__c;
           company = attget[0].AS_company__c;
        }else{
        lastName = '';
           firstName  = '';
           company = '';
        }
        }else{
        regerror = true;
        }
        return null;
    }




    public String loginuserpassword { get; set; }
    public String loginuserName { get; set; }
    public String company { get; set; }
    public boolean errorboolexist {get;set;}
    public String lastName { get; set; }
    public boolean forDisplayError {get;set;}
    public String firstName { get; set; }
     public boolean forDisplayError1 {get ; set ;}
    public String selectedvalue { get; set; }
    public string message{get;set;}
    public string EventId{get;set;}
     public String password { get; set; }
    public String email { get; set; }
    
    public pagereference loginaction(){
    pagereference pf= page.MM_Eventadmin_Login;
    return pf;
    
    }
    public boolean existbool{get;set;}
    public MM_NewSignupCon (){
    eamlist =new list<Event_Attendee_Mapping__c>();
    users=new list<user>();
    
   }


 public PageReference redirectIfLoggedIn() {
    if (UserInfo.getUserType() != 'Guest') {
        PageReference loggedInPage = new PageReference('/secur/logout.jsp');
        return loggedInPage;
    }
    return null;
    }



   public PageReference loginPortal() {
    existbool =false;
    errorboolexist =false;
    forDisplayError =false;
    userpwderror=false;
    userpwderrormsg='';
    
     loginuserName  =loginuserName.trim();
     loginuserpassword =loginuserpassword.trim();
     
      List<user> userL = new List<user>();
       userL  =[select id,isactive,isSignup__c,profile.Name from user where userNAme=:loginuserName];
       if(userL.size()>0){
           if(userL[0].isSignup__c==true || userL[0].profile.Name=='Event Admin'){
             if(!userL[0].isActive){
                userL[0].isActive =true;
                dataBAse.update(userL[0],false);
             }
           }
                
       }
      pageReference pg =site.login(loginuserName ,loginuserpassword ,'/apex/Matchleads_eventspage');
     
     if(pg !=null){
        forDisplayError1 = false;
        pg.setRedirect(true);
        return   pg;       
  
         }else{
          forDisplayError1 = false;
           //error='Your login attempt has failed. Make sure the username and password are correct.';
           forDisplayError = true;
           return null;
        }
       
    }

    public PageReference close() {
     existbool =false;
     return null;
    }

   public PageReference Loginpage() {
    pageREference pg = new pageREference('http://boothleads.force.com/MatchMaking/');
    pg.setRedirect(true);
     return pg;
    }

   public user u {get;set;}
    
    public PageReference save() {
    Savepoint sp = Database.setSavepoint();
    existbool =false;
    errorboolexist =false;
    forDisplayError =false;
    u = new user ();
    
    system.debug('mmmmmmmm'+lastName);
      if(firstName  ==null || firstName  ==''){
      message = 'First Name is required';
        existbool =true;
        return null;
    }
    if(lastName ==null || lastName ==''){
      message = 'Last Name is required';
        existbool =true;
       return null;
    }
     if(company ==null || company ==''){
      message = 'company Name is required';
        existbool =true;
        return null;
    }
    
     if(email==null || email==''){
        message = 'Email id required';
        existbool =true;
        return null;
     }
     if( password.length()<=4 ){
      message = 'Password should contain atleast 4 characters';
      existbool =true;
      return null;
     }else{
         eamlist = [select id from Event_Attendee_Mapping__c where EV_id__c != null AND AS_id__r.AS_Email__c =: email ];
         system.debug('--------Email-------'+eamlist);
         if(eamlist.size()>0){
        users = new List<user>([select id,isSignup__c,userName,Email,Name,CompanyName from user where userName=:email]);
         
         if(users.size()>0){
             
            if( users[0].isSignup__c != true){
              users[0].IsActive = true;
               users[0].isSignup__c = true;
               users[0].Password__c =password;
               users[0].CompanyName =company;
                                        Database.update(users[0]);
                                        try{
                                        system.setPassword(users[0].id,password);
                                        }
                                        catch(Exception e)
                                        {
                                          userpwderror=true;
                                           userpwderrormsg=e.getMessage();
                                           Database.rollback( sp );
                                           return null;
                                        }
                                        u.id=users[0].id;
                                       // forupdateEAM(firstName,lastName,company,email,u.id);
                                         //forupdateEAM1(users[0].id);
                                         gotologin = true;
                                          EmailTemplate Email_Template= new EmailTemplate();
                                    Email_Template= [SELECT Name, Body,Subject,HtmlValue,Markup from EmailTemplate Where Name =: 'Welcome Template for Match Leads'];
                                    OrgWideEmailAddress Org = [select id from OrgWideEmailAddress Limit 1];
                                    
                                        //if (saveupe[0].iscreated()) {
                                            User UES = new User();
                                            UES = [Select FirstName,LastName,Email,UserName From User Where id =: u.id];
                                            String EmailTem = Email_Template.HtmlValue;
                                            String EmailTem1= EmailTem .Replace('{!Name}',UES.FirstName+' '+UES.LastName);
                                            
                                            system.debug('6666 666666 666666'+UES.UserName);
                                            
                                            Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();
                                            
                                            string [] toAddresses = new string[]
                                                             {
                                                                 UES.UserName
                                                             };
                                            singleEmail.setHtmlBody(EmailTem1);
                                            singleEmail.setToAddresses(toAddresses);
                                            singleEmail.setSubject(Email_Template .Subject);
                                            singleEmail.setOrgWideEmailAddressId(Org.id);
                                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { singleEmail }); 
                                    
                                          loginuserName  = users[0].Username ;
                                 loginuserpassword =users[0].Password__c;
                                 Cookie viewprofile= new Cookie('viewprofile','MM_Profile',null,-1,false);
                                  ApexPages.currentPage().setCookies(new Cookie[]{viewprofile});  
                                 return loginPortal();
                                        
                                        }else{
                                        
                                         errorboolexist = true;
                                         return null;
                                        }
                                        
                                        
           }else{
                   
                               profile p = [select Id,Name from Profile where Name = 'Attendee' Limit 1];
                                        user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
                                        account acc=new account();
                                        try{
                                           acc =[select id from account where ownerid!=null and name like 'booth%' limit 1]; 
                                          }catch(exception r){
                                              
                                               acc.name='Booth Leads';  
                                               acc.ownerid=uname.createdby.id;          
                                              insert acc; 
                                          }
                                        Contact Contact = new Contact();
                                        Contact.Lastname = lastName;
                                        Contact.Firstname = firstName;
                                        Contact.AccountID = acc.id;
                                        insert Contact;
                                        u = new user();
                                        
                                        U.ContactID = Contact.id;
                                        U.FirstName = FirstName;
                                        U.CompanyName =company;
                                        system.debug('--------Contact Insertion-------'+U.FirstName);
                                        U.LastName = LastName;
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
                                        try{
                                        system.setPassword(u.id,password);
                                        }
                                        catch(Exception e)
                                        {
                                          userpwderror=true;
                                           userpwderrormsg=e.getMessage();
                                           Database.rollback( sp );
                                           return null;
                                        }
                                  
                                 forupdateEAM(firstName,lastName,company,email,u.id);
                                     EmailTemplate Email_Template= new EmailTemplate();
                                    Email_Template= [SELECT Name, Body,Subject,HtmlValue,Markup from EmailTemplate Where Name =: 'Welcome Template for Match Leads'];
                                    OrgWideEmailAddress Org = [select id from OrgWideEmailAddress Limit 1];
                                    
                                        //if (saveupe[0].iscreated()) {
                                            User UES = new User();
                                            UES = [Select FirstName,LastName,Email,UserName From User Where id =: u.id];
                                            String EmailTem = Email_Template.HtmlValue;
                                            String EmailTem1= EmailTem .Replace('{!Name}',UES.FirstName+' '+UES.LastName);
                                            
                                            system.debug('6666 666666 666666'+UES.UserName);
                                            
                                            Messaging.SingleEmailMessage singleEmail = new Messaging.SingleEmailMessage();
                                            
                                            string [] toAddresses = new string[]
                                                             {
                                                                 UES.UserName
                                                             };
                                            singleEmail.setHtmlBody(EmailTem1);
                                            singleEmail.setToAddresses(toAddresses);
                                            singleEmail.setSubject(Email_Template .Subject);
                                            singleEmail.setOrgWideEmailAddressId(Org.id);
                                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { singleEmail }); 
                                    
                                    //system.debug('+++++++++++++++++++++'+saveupe);
                                   
                                 loginuserName  = U.Username ;
                                 loginuserpassword =U.Password__c;
                                  Cookie viewprofile= new Cookie('viewprofile','MM_Profile',null,-1,false);
                                  ApexPages.currentPage().setCookies(new Cookie[]{viewprofile});  
                                 return loginPortal();
                                
       
                  }
                  }    else{
                  forDisplayError1 = true;
                  return null;
                  }            
                                  
        }
              
                                    //}
                                   
               // pagereference pg = new pagereference('http://boothleads-boothleads.cs11.force.com/MatchMaking');
                return null;
          }



        public boolean gotologin {get;set;}
   


 //Only for GNEMSDC 

  /* @future 
    public static void forupdateEAM1(id userid){

     User_Profile_Event__c upecheck = [select id from User_Profile_Event__c WHERE EV_id__r.id= 'a00F000000BNGQi' AND User_id__r.id =: userid] ;
                                      upecheck.IsMatchMakingUser__c = TRUE;
                                      Update upecheck ;


     }*/
//------
   @future 
    public static void forupdateEAM(string firstName,string lastName,string company, string email,id uid){
    string EventId='';
    user u = [ select id,isSignup__c,userName,Email,Name from user where id =:uid];
     AttendeeSummary__c att = new AttendeeSummary__c();
         att.AS_Email__c = email;
         att.AS_FirstName__c = firstName;
         att.AS_LastName__c = lastName;
         att.AS_Company__c = company;
         Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
        dataBase.upsertResult upResult = dataBase.upsert(att,f,false);                               
          
                                   Profile__c attendeeProfile= [Select Id from Profile__c where PR_Name__c ='Attendee' ];
                                   Profile__c boothAdminProfile= [Select Id from Profile__c where PR_Name__c ='BoothAdmin' ];
                                  
                                    List<Event_Attendee_Mapping__c> evenAtt = new List<Event_Attendee_Mapping__c>();
                                    evenAtt =[select id,AS_id__r.AS_Email__c,EV_id__r.id,Boothleads_Profile__c,AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.id,AS_id__r.AS_Company__c from Event_Attendee_Mapping__c where AS_id__r.AS_Email__c=:email];
                                      
                                      SET<string> boothNames = new SET<string>();
                                       SET<string> boothNamesemail = new SET<string>();
                                     
                                      List<Booth__c> booths = new List<Booth__c>();
                                      
                                      for(Event_Attendee_Mapping__c eam:evenAtt) {
                                       if(eam.AS_id__r.AS_Company__c!=null){
                                            if(boothNames.contains(eam.AS_id__r.AS_Company__c)){
                                             
                                             }else{
                                                   Booth__c Booth  = new Booth__c();
                                                   booth.EV_id__c =eam.EV_id__r.id;
                                                   booth.BT_ContactEmail__c = eam.AS_id__c;
                                                   boothNamesemail.add( eam.AS_id__r.AS_email__c); 
                                                   booth.BT_Name__c =eam.AS_id__r.AS_Company__c;
                                                   booth.BT_ContactName__c =eam.AS_id__r.AS_LastName__c+' '+eam.AS_id__r.AS_FirstName__c;
                                                   booths.add(booth); 
                                                   boothNames.add(eam.AS_id__r.AS_Company__c);
                                            }
                                        }
                                        
                                      }
                                      
                                       DataBase.saveResult[] savres = dataBase.insert(booths,false);
                                      
                                      Set<Id> boothIds = new Set<Id>();
                                      
                                      for(DataBase.saveResult dsavres :savres ){
                                        if(dsavres.isSuccess()){
                                          boothIds.add(dsavres.getId());
                                        }
                                      
                                      }
                                      
                                      system.debug('FFFFFFFFF '+boothIds +'FFFFFFFFFFFFFFFFFFFF '+boothNamesemail);
                                      MAP<string,Id> MapIdwithEmailBooth = new MAP<string,Id>();
                                      
                                      for(Booth__c bo :[Select Id,BT_ContactEmail__c from Booth__c where (id In :boothIds OR BT_ContactEmail__c IN :boothNamesemail)]){
                                         MapIdwithEmailBooth.put(bo.BT_ContactEmail__c,bo.id); 
                                      }
                                      
                                      List<User_Profile_Event__c> upes = new List<User_Profile_Event__c>();
                                      
                                      for(Event_Attendee_Mapping__c eam:evenAtt) {
                                      Eventid ='';
                                      if(eam.EV_id__r.id != null){
                                      Eventid = eam.EV_id__r.id;
                                      }
                                            if(eam.Boothleads_Profile__c=='Booth Admin'){
                                                   User_Profile_Event__c UPE = new User_Profile_Event__c();
                                                   UPE.UEP_isActive__c = True;
                                                   UPE.IsMatchMakingUser__c = true;
                                                   UPE.EV_id__c =eventId;
                                                   UPE.MAtchMakingProfile__c='Corporate';
                                                   UPE.Profile_id__c = boothAdminProfile.id;
                                                   UPE.User_id__c = uid; 
                                                   UPE.Attendee_Summary__c = eam.AS_id__r.id;
                                                   try{
                                                   upe.BT_id__c = MapIdwithEmailBooth.get(u.userName);
                                                    }catch(exception re){}
                                                   UPE.BoothAdmin_id__c =uid;
                                                   upes.add(upe); 
                                            }else if(eam.Boothleads_Profile__c=='Attendee'){
                                              
                                                   User_Profile_Event__c UPE1 = new User_Profile_Event__c();
                                                   UPE1.UEP_isActive__c = True;
                                                   UPE1.IsMatchMakingUser__c = true;
                                                   UPE1.EV_id__c =eventId;
                                                   UPE1.Profile_id__c = attendeeProfile.id;
                                                   UPE1.User_id__c = uid; 
                                                   UPE1.MAtchMakingProfile__c='MBE';
                                                   UPE1.Attendee_Summary__c = eam.AS_id__r.id;
                                                   try{
                                                   upe1.BT_id__c = MapIdwithEmailBooth.get(u.userName);
                                                   }catch(exception re){}
                                                   UPE1.BoothAdmin_id__c =uid;
                                                   upes.add(upe1);
                                                  
                                            }
                                            system.debug('+++++++++++++++++++++'+upes);
                                       }   
                                       DataBase.saveResult[] saveupe= dataBase.insert(upes,false);        
                                      // Database.UpsertResult[] saveupe= database.upsert(upes,false);  
                                          
                                   
                            
                      }
    
    
   /** 
    
     user u = new user ();
     u=[select id,isactive,isSignup__c,username from user where userName=:emails];
     
     u.isActive =true;
     u.isSignup__c =true;
     u.password__c =passs;
     dataBase.update(u,false);
     system.setPassword(u.id,passs);
    
    
    
    @future 
    public static void forupdateEAM2(string emails){
     user u = new user ();
     u=[select id,isactive,isSignup__c,username from user where userName=:emails];
      u.isActive =true;
     u.isSignup__c =true;
     dataBase.update(u,false);
  }
    
*/
  
}