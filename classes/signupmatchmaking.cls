public without sharing class signupmatchmaking {


    public Event_Attendee_Mapping__c Attendee {get; set;}
    public string attendeeEmail {get;set;}
    public User Usercheck {get;set;}
    public String EventId{get; set;}
    public AttendeeSummary__c att  {get;set;}
    public AttendeeSummary__c myatt  {get;set;}
    public  Event__c  evv {get;set;}
    public User U {get;set;}
    public List<selectoption> MBE{get;set;}
    public List<selectoption> Corporate{get;set;}
    public list<SelectOption> options {get;set;}
    public string selectedType{get;set;}
    public string pname{get;set;}
    public string newpassword{get;set;}
    public Profile p {get;set;}
    public User_Profile_Event__c UPE {get;set;}
    Public string message{get;set;}
    public boolean successbool {get;set;}
    public boolean errorbool{get;set;}
    public boolean existbool{get;set;}
    public boolean successboolMBE {get;set;}
    public Booth__c Booth {get;set;}
    public boolean passwordalert {get;set;}
    
    public signupmatchmaking ()
    {
    corporatealert = false;
   mbealert = false;
    attendeeEmail = null;
    Booth  = new Booth__c();
    att  = new AttendeeSummary__c();
    UPE  = new User_Profile_Event__c();
    Attendee = new  Event_Attendee_Mapping__c ();
    p = new Profile ();
    u = new User();
    pname ='';
    //selectedType = 'MBE';
       options = new list<SelectOption>();
       options.add(new SelectOption('MBE','MBE'));
       options.add(new SelectOption('Corporate','Corporate'));
        EventId= Apexpages.currentPage().getParameters().get('Id');
           evv=[select EV_Title__c,EV_EventLogo__c,Owner.id  from Event__c where id =:EventId];    
    }
    
    public boolean typeerror{get;set;}
     public pagereference saveUser(){
    if(newpassword.length()< 4){
    passwordalert = true;
    }else{
   
    if(selectedtype == null){
    
    typeerror = true;
    }else{
     if(selectedType == 'MBE' ){
                                     pname = 'Attendee';
                                      p = [select Id,Name from Profile where Name = 'Attendee' Limit 1];
                                     
                                 }else{
                                     pname = 'BoothAdmin';
                                      p = [select Id,Name from Profile where Name = 'Booth Admin' Limit 1];
                                 
                                 }
                               
    try{
            att  =[select id,AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Title__c,AS_WorkPhone__c from AttendeeSummary__c where AS_Email__c =: attendeeEmail ];
           }catch(exception e){}
            if(att.id == null){
            errorbool = true;
          

            }else{
                system.debug('        att '+att.id);
                    try{                 
                            Attendee =[select id,IsMatchMakingAttendee__c from Event_Attendee_Mapping__c where EV_id__c=: EventId AND AS_id__r.id =: att.id];
                       }catch(exception e){}
                        if(Attendee.id == null){
                        errorbool = true;
                           
                                    
                        }else{
                                if(Attendee.IsMatchMakingAttendee__c == false){
                                forupdateEAM(Attendee.id);
                                }
                               
                                try{
                                     U =[select id,profile.Name,isSignup__c from User where Email =: attendeeEmail ];
                                    } catch(exception e){}
                                     
         //-------------------------------------------------------------------------------------User,UPE insertion------------                             
                                     system.debug('PPPPPPPPPPPPPPPP '+u+'RRRRRRRRRRRRRR '+attendeeEmail );
                                     if( u.id==null){
                                     
                                         p = [select Id,Name from Profile where Name = 'Attendee' Limit 1];
                                         user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
                                         account acc=new account();
                                         acc.name='Booth Leads';  
                                         acc.ownerid=uname.createdby.id;          
                                         insert acc; 
                   
                                        Contact Contact = new Contact();
                                        Contact.Lastname = att.AS_LastName__c;
                                        Contact.Firstname = att.AS_FirstName__c;
                                        Contact.AccountID = acc.id;
                                        //Contact.Email_Notes__c =EmailNote; 
                                        //Contact.Email_Subject__c = EmailSubject;
                                        insert Contact;
                    
                                        U.ContactID = Contact.id;
                                        U.FirstName = att.AS_FirstName__c;
                                        system.debug('--------Contact Insertion-------'+U.FirstName);
                                        U.LastName = att.AS_LastName__c;
                                        U.Username = attendeeEmail;
                                        U.Email = attendeeEmail;
                                        U.Alias = 'EventAdm';
                                        u.isSignup__c = true;
                                        u.IsActive = true;
                                        U.ProfileID = P.id;
                                        U.LocaleSidKey = 'en_US';
                                        U.LanguageLocaleKey = 'en_US';
                                        U.TimeZoneSidKey = 'America/Los_Angeles';
                                        U.EmailEncodingKey='UTF-8';
                                        Database.insert(u);
                                 
                                       forupdateuser(u.id,newpassword);                                   
                                      forUPEBOOTH(u.id,selectedtype,EventId,attendeeEmail);                                     
         //------------------------------------------------User, UPe edit----------------------------------------------------------------                                     
                                     successbool = true;       
                                    }else
                                    {
                                    if(u.isSignup__c == True){
                                    existbool = true;
                                    system.debug('              exit            '+existbool );
                                    }else{
                                     u.isSignup__c = true;
                                        u.IsActive = true;
                                        Database.update(u);
                                         system.setPassword(u.id,newpassword);
                                         u.password__c =newpassword;
                                          update u;
                                    string userprofile = u.Profile.Name;
                                    system.debug('     uuuuuuuu22222    '+ u.Profile.Name);
                                    try{
                                     UPE = [select id,IsMatchMakingUser__c,Profile_id__r.PR_Name__c from  User_Profile_Event__c where EV_id__c =: EventId AND User_id__c =: u.id];
                                    }catch(exception e){}
                                     if( null== UPE ){  
                                      
                                      forUPEBOOTH(u.id,selectedtype,EventId,attendeeEmail);             
                                    
                                       if(selectedType == 'Corporate' && UPE.Profile_id__r.PR_Name__c == 'BoothAdmin'){
                                     
                                     successboolMBE  = true;
                                     
                                     }else if(selectedType == 'Corporate' && UPE.Profile_id__r.PR_Name__c == 'Attendee'){
                                             successbool = true;
                                     
                                     }
                                       
                                     }
         //-------------------------------------------------------------------------                            
                                     else{
                                     
                                     forupdateupe(UPE.id,selectedtype,EventId,attendeeEmail,u.id);
                                     
                                        if(selectedType == 'Corporate' && UPE.Profile_id__r.PR_Name__c == 'BoothAdmin'){
                                     
                                     successboolMBE  = true;
                                     
                                     }else 
                                     if(selectedType == 'Corporate' && UPE.Profile_id__r.PR_Name__c == 'Attendee'){
                                             successbool = true;
                                     
                                     }
                                     
                                  
                                  
                            }
                         }
                       }
                  }
                }   
            }
            }
            return null;
  
    }
     @future   
    public static void forupdateuser(id uid,string pwd){
    User U = new User();
    
    U =[select id,password__c from User where id =: uid];
     system.setPassword(uid,pwd);
                                       u.password__c =pwd;
                                       system.debug('22222222222222 '+u.password__c);
                                       system.debug('3333333333333333 '+u.id);
                                       system.debug('444444444444444444 '+u);
                                       update u;
    }
     
     @future   
    public static void forUPEBOOTH(id rr,string s,string evid,string emailid ){
    AttendeeSummary__c att1 = new AttendeeSummary__c();
    Booth__c booth1= new Booth__c();
    string Pname;
    Event__c evv = new Event__c();
     evv=[select EV_Title__c,EV_EventLogo__c,Owner.id  from Event__c where id =:evid];
    att1  =[select id,AS_FirstName__c,AS_LastName__c,AS_Company__c,AS_Title__c,AS_WorkPhone__c from AttendeeSummary__c where AS_Email__c =: emailid];
     
                                      try{
                                      Booth1=[select id, BT_Name__c from Booth__c where BT_Name__c =:att1.AS_Company__c AND EV_id__c =: evid];
                                      }catch(exception e){}
                                      if(Booth1.id == null){
                                      Booth1.BT_Name__c = att1.AS_Company__c;
                                      Booth1.EV_id__c = evid;
                                      insert Booth1;
                                       }
                                        if(s ==  'MBE'){
                                        pname = 'Attendee';
                                        }else if(s == 'Corporate'){
                                        pname = 'Booth Admin';
                                        }
                                       
                                       Profile__c EventAdmCustProfile1 = [Select Id from Profile__c where PR_Name__c =: pname ];
                                       User_Profile_Event__c UPE = new User_Profile_Event__c();
                                       UPE.EventAdmin_Id__c = evv.Owner.id;
                                       UPE.UEP_isActive__c = True;
                                       UPE.IsMatchMakingUser__c = true;
                                       UPE.EV_id__c        =evid;
                                       UPE.Profile_id__c = EventAdmCustProfile1.id;
                                       UPE.User_id__c = rr; 
                                       UPE.Attendee_Summary__c = att1.id;
                                       UPE.MAtchMakingProfile__c = s;
                                       if(s== 'Corporate'){
                                       
                                       UPE.Request_for_upgrade_profile__c = true;
                                       }
                                       Insert UPE;
                                        system.debug('     uuuuuuuu111111   '+ upe.id);
    
    
    
    
    }
      @future

         
    public static void forupdateEAM(id rr){
    Event_Attendee_Mapping__c Attendee =new  Event_Attendee_Mapping__c();
    Attendee =[select id,IsMatchMakingAttendee__c from Event_Attendee_Mapping__c where id =: rr];
    Attendee.IsMatchMakingAttendee__c = true;
    update Attendee; 
    }
    
     @future

         
    public static void forupdateupe(id rr,string s,string evid,string emailid,id uid ){
    
    Booth__c Booth  = new Booth__c();
    User_Profile_Event__c  UPE = new User_Profile_Event__c();
    User u = new User();
    
    try{
    UPE = [select id,IsMatchMakingUser__c,Profile_id__r.PR_Name__c,MAtchMakingProfile__c from  User_Profile_Event__c where id =: rr];
    } catch(exception e){}
                        
    if(UPE.Profile_id__r.PR_Name__c == 'Attendee' && s== 'Corporate'){
    system.debug('           request     '+UPE.MAtchMakingProfile__c +'         requst 1    '+s);
    
                                     UPE.MAtchMakingProfile__c = 'Corporate';
                                     UPE.Request_for_upgrade_profile__c = true;
                                     
                                     }else if(UPE.Profile_id__r.PR_Name__c == 'BoothAdmin' && s == 'Corporate'){
                                     system.debug('            profile           '+UPE.Profile_id__r.PR_Name__c +'     s '+s);
                                       UPE.MAtchMakingProfile__c = 'Corporate';
                                           UPE.Request_for_upgrade_profile__c = false;
                                       } 
                                       else if(UPE.Profile_id__r.PR_Name__c == 'Attendee' && s== 'MBE'){
                                       UPE.MAtchMakingProfile__c = 'MBE';
                                        UPE.Request_for_upgrade_profile__c = false;
                                         system.debug('           request     '+ UPE.Request_for_upgrade_profile__c +'         requst 1    '+s);
                                       }

                                     UPE.IsMatchMakingUser__c = true;
                                     
                                     update UPE;
                                     
                                    
 
    

   }
   

  public pagereference redirecttologin(){

       /**
           newpassword = newpassword.trim();
           attendeeEmail = attendeeEmail.trim(); 
                          
          try{
        u =[select Name,Profile.Name from user where Username=: attendeeEmail];       
        System.debug('UserName is'+u);        
        }        
        catch(QueryException ex){        
     //  errorMessage ='Your login attempt has filed. Make sure the username and password are correct.';
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Your login attempt has failed. Make sure the username and password are correct.'));
        return null;        
        }         
       
       if(u.Profile.Name =='Event Admin'){
         return Site.login(attendeeEmail , newpassword, '/apex/MM_Eventadmin_Events');        
         }
         else{
         
         List<User_Profile_Event__c> upes = new List<User_Profile_Event__c>();
         upes =[select id,Request_for_upgrade_profile__c,MAtchMakingProfile__c from User_Profile_Event__c where User_id__r.userName=:attendeeEmail and Request_for_upgrade_profile__c=false];
         SET<string> profilesMatchmaking = new SET<string>();
         for(User_Profile_Event__c up:upes){
           profilesMatchmaking.add(up.MAtchMakingProfile__c);
         }
         system.debug('tttttttttttttttttt '+profilesMatchmaking);
         
         if(profilesMatchmaking.contains('Corporate')){
           return Site.login(attendeeEmail , newpassword, '/apex/MM_events');
         }else if(profilesMatchmaking.contains('MBE')){
          return Site.login(attendeeEmail , newpassword, '/apex/MM_events');
         } else{
         // errorMessage ='User has no Privileges to access';
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'User has no Privileges to access'));
          return null;
          }
         
         
         
         
       }*/
   pagereference pf=new pagereference('/apex/mm_eventadmin_Login');
   return pf;
 
   }
   public pagereference refresh(){
   errorbool=false;
    pagereference pf=new pagereference('/apex/mm_signup?id=' + EventId);
    pf.setredirect(true);
   return pf;
   
   }
   public boolean mbealert{get;set;}
   public boolean corporatealert {get;set;}
   public void detailalerts(){
   if(selectedtype == 'MBE'){
   
   corporatealert = false;
   mbealert = true;
   newpassword=newpassword;
   }else if('Corporate' == selectedtype ){
    mbealert = false;
   corporatealert = true;
   newpassword=newpassword;
   
   }
   
   
   }
   public void resend(){
   typeerror = false;
   
   }
   
}