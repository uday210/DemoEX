public without sharing class BL_BoothPersonnelsCon {



public Boolean AdminUserBool{get;set;} 
public  List<User_Profile_Event__c> listOfEvents{get;set;} 
public String errormsg{ get; set; }
public String country { get; set; }
public boolean displayPopUpForAddcheck{get;set;}
public String email { get; set; }
public boolean errorMessage { get; set; }
public string message{ get; set; }
public List<Event__c> EvntsForPicklist{get;set;}
public string defaultEvent{get;set;}
public User editOfBoothPersonnel{get;set;}
public boolean displayPopUpForAdd{get;set;}
public List<User_Profile_Event__c> detailsOfBoothPersonnel{get;set;}
public string statusValue {get;set;}
public string  eventName{get;set;}
public String eventSelected { get; set; }
public boolean displayPopUp {get;set;}
public transient List<User_Profile_Event__c> Boothpersonnels{get;set;}
public List<innerForDisplayStatus> boothPersonnelWithStatus{get;set;}
public Boolean  displayPopUpForAddBooth{get;set;}
public User CreateUser{get;set;}
 public  List<innerForDisplayStatus> ForPagination {get;set;}
  
  
 //----------------variables for pagination of new design in salesforce
    public Boolean hasLast{get;set;}
    public Boolean hasFirst{get;set;}
    public Integer PgNo{get;set;}
    Public Boolean conlst{get;set;}
    Public Boolean hasPrevious {get;set;}
    Public Boolean hasNext {get;set;}
    Public Integer pageno {get;set;}
    Public Integer count {get;set;}
  //-----------------------------------------------------------------------
   

    public PageReference Last() {
     try{
        
         hasLast = False;
        System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
        hasPrevious=true;
     
        hasFirst = true;
       
        ForPagination.clear();
         hasNext=false;
                 if( math.mod(boothPersonnelWithStatus.size(),50)==0){
          System.debug('---------44444444444444444----'+pageno );
             pageno =boothPersonnelWithStatus.size()/50;
             System.debug('-----------------pageno ----'+pageno );
           } else {
           System.debug('---------44444444444444444----'+pageno );
            pageno =(boothPersonnelWithStatus.size()/50) +1; 
            }
         for(integer i=(pageno -1)*50;i<boothPersonnelWithStatus.size();i++)
          {
              ForPagination.add(boothPersonnelWithStatus[i]);  
          }
     }catch(Exception ex){}
        return null;
    }


    public PageReference Next() {
     try{
        
         pageno  = pageno +1;
        // integer pgno;
         ForPagination.clear();
         if(math.mod(boothPersonnelWithStatus.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=boothPersonnelWithStatus.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(boothPersonnelWithStatus.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            if(pageno==pgno)
             { 
                  hasNext=false;
                  hasLast = False;
                   for(integer i=(pageno -1)*50;i<boothPersonnelWithStatus.size();i++ )
                    {
                     
                     ForPagination.add(boothPersonnelWithStatus[i]);
                     
                    }
             }
           else            
            for(integer i=(pageno -1)*50;i<(pageno*50);i++ )
              {
                  ForPagination.add(boothPersonnelWithStatus[i]);
                   
             }
            hasPrevious=true;
            hasFirst = True;
     
     
     }catch(Exception Ex){
     
     }
        return null;
    }


    public PageReference Prev() {
       
       try{ 
               
          hasLast=True;
          hasNext=true;  
          ForPagination.clear();
          if(pageno  !=1)
             {     
                  pageno  = pageno  - 1;
                  If(pageno  ==1 ){
                  hasPrevious=false;
                  hasFirst = False;
              }  
                   for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                       ForPagination.add(boothPersonnelWithStatus[i]);
                     }
             }                           
             else
              {   
              
                  hasPrevious=false;
                  hasFirst = False;
                      
                  for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                        
                     ForPagination.add(boothPersonnelWithStatus[i]);
                     } 
                  }
       }
       catch(Exception ex){
     
     }
     return null;
    }


    public PageReference First() {
     try{
          
         hasNext=true;
         hasFirst = false;
         hasPrevious=false;
         hasLast = True;
        
         
         ForPagination.clear();
         //hasPrevious=false;
         pageno =1;
         for(integer i=0;i<50;i++)
          {
          ForPagination.add(boothPersonnelWithStatus[i]);
          
         }
         if(math.mod(boothPersonnelWithStatus.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=boothPersonnelWithStatus.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(boothPersonnelWithStatus.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            }catch(Exception ex){
     
     }
        return null;
    }





public PageReference login() {
   if(userInfo.getUserType()=='guest'){
    Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
    pg.setredirect(true);
        return pg;
   
   } 
   List<User_Profile_Event__c> ty =new  List<User_Profile_Event__c>();
      ty=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() and Profile_id__r.PR_Name__c='eventadmin'];
       if(ty.size()>0){
       Pagereference pg = new pagereference('/apex/BL_EventAdmin_Dashboard');
       pg.setredirect(true);
        return pg;
       
       }else{
       return null;
       } 
      
  }


    public PageReference closePopupSelect() {
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
    if(browserType != null && browserType.contains('MSIE')){
    Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
    }
    getBoothPersonnels(); 
    displayPopUpForAddcheck =false;
        return null;
    }


public boolean booleanforDisplayBoothadminTab{get;set;}
    public PageReference saveLicenceValues() {
  try{      
    message  ='';
    errormsg ='';
   if(PreviousStingValue !=countrySelect || countrySelect !=null ||  countrySelect !=''){
 
    booth__c booth =[select id,BT_BoothUserCount__c from booth__c where id=:upeFordisplayStatus.BT_id__c];
     if(countrySelect !='InActive'){
     
       if(upeFordisplayStatus.UEP_isActive__c ==true){
        upeFordisplayStatus.status__c = countrySelect;
       update upeFordisplayStatus;
      displayPopUpForAddcheck =false;
      }else{
        if(booth.BT_BoothUserCount__c>0){
   
      upeFordisplayStatus.status__c = countrySelect;
       upeFordisplayStatus.UEP_isActive__c =true;
      update upeFordisplayStatus;
      
      
      system.debug('countrySelect 4444444444444444444444444 ' +upeFordisplayStatus.status__c);
      booth.BT_BoothUserCount__c =booth.BT_BoothUserCount__c-1;
      update booth; 
      displayPopUpForAddcheck =false;    
     system.debug('countrySelect 5555555555555555555555555' +booth.BT_BoothUserCount__c);
     }  else{
      system.debug('countrySelect 8888888888888888888 ' );
       errormsg ='You dont have licences';
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You dont have licences'));
     }
   
  } 
    
    
    
    }else{
    
     upeFordisplayStatus.status__c = countrySelect;
     upeFordisplayStatus.UEP_isActive__c =false;
     update upeFordisplayStatus;
      system.debug('countrySelect 66666666666666666666666' +upeFordisplayStatus.UEP_isActive__c);
      booth.BT_BoothUserCount__c =booth.BT_BoothUserCount__c+1;
      update booth;  
      displayPopUpForAddcheck =false;
     system.debug('countrySelect 77777777777777777777777' +booth.BT_BoothUserCount__c);
    }
    }
    
    getBoothPersonnels();
  }catch(exception e){}   
        return null;
    }


    public String countrySelect { get; set; }

    public List<SelectOption> getSeletOptions() { 
    
    List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Mobile only access','Mobile only access')); 
        options.add(new SelectOption('Mobile and Portal Access','Mobile and Portal Access')); 
        return options;
  }



public PageReference closePopup2() {
String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
    if(browserType != null && browserType.contains('MSIE')){
    Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
    }
country ='';
firstnaerror ='';
   Emailerror='';
   accessTypeerror=''; 
    displayPopUpForAddBooth =false;
    
        return null;
    }


public BL_BoothPersonnelsCon(){
URLEvent();
try{    
String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
country='';
ShowUserError=false;
//List<user> hghg =[select FirstName,LastName From User ];
//system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii '+hghg);
 List<user> uuuee =new List<user>();
 
 

 listOfEvents = new List<User_Profile_Event__c>();
listOfEvents =[select u.EV_id__r.Status__c,u.EV_id__r.StartTime__c, u.EV_id__r.SecondaryCategory__c,
u.EV_id__r.Primary__c, u.EV_id__r.Name, u.EV_id__r.Id, u.EV_id__r.EV_Title__c, u.EV_id__r.EV_StartDate__c, u.EV_id__r.EV_HostingZipcode__c, 
u.EV_id__r.EV_HostingTimeZone__c, u.EV_id__r.EV_HostingState__c,u.EV_id__r.EV_HostingPostalCode__c,
u.EV_id__r.EV_HostingPhone__c, u.EV_id__r.EV_HostingLocation__c, u.EV_id__r.EV_HostingCountry__c,
u.EV_id__r.EV_HostedByEventBrite__c, u.EV_id__r.EV_HistingAddr1__c, u.EV_id__r.EV_EventLogo__c, 
u.EV_id__r.EV_EndTime__c,u.EV_id__r.EV_EndDate__c, u.EV_id__r.EV_Description__c, u.Profile_id__r.PR_Name__c,
u.EV_id__r.CreatedDate, u.EV_id__r.Attendee_Tags__c,u.EV_id__r.EV_HostingOrgName__c, u.EV_id__r.AS_HostingCity__c,u.EV_id__r.AS_HostingAddr2__c from User_Profile_Event__c u where u.User_id__r.Email=:UserInfo.getUserName() limit 999 ];
  
  set<Id> setOfEvents = new set<Id>();
   
 booleanforDisplayBoothadminTab =false; 
 system.debug('rrrrrrrrrrrrrrrrrrrrrr  '+listOfEvents);
for(User_Profile_Event__c upe:listOfEvents){
 if(upe.Profile_id__r.PR_Name__c !='Attendee' && upe.Profile_id__r.PR_Name__c !='BoothPersonnel' ){
 booleanforDisplayBoothadminTab = true;
 break;
}
  setofEvents.add(upe.EV_id__c); 
  
}


errorMessage =false;
 List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
 EvntsForPicklist = new List<Event__c>();
 upeForEvents = [Select u.User_id__c, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where u.User_id__r.Email=:UserInfo.getUserName()];
 set<Id> setOfEventIds = new set<Id>();
 
 for(User_Profile_Event__c rotatinnFor:upeForEvents){
 setOfEventIds.add(rotatinnFor.EV_id__c);
 }
 
 EvntsForPicklist =[select  id,EV_Title__c from Event__c where id in :setOfEventIds order by EV_StartDate__c];
 if(EvntsForPicklist.size()>0){
 defaultEvent =EvntsForPicklist[0].id;
 system.debug('4444444444444444444444444444444444444444444  '+defaultEvent );
 
 }
 
 
 List<User_Profile_Event__c> 
  rr= [Select Id,User_id__r.Name,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,BoothAdmin_id__r.LastName,
                          BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName from User_Profile_Event__c 
                          where BoothAdmin_id__c=:UserInfo.getUserId() AND EV_id__c =:defaultEvent AND Profile_id__r.PR_Name__c ='BoothPersonnel' ];
  
  
getBoothPersonnels();
}catch(exception e){}
}

  public string firstnaerror {get;set;}
  public string Emailerror {get;set;}
  public string accessTypeerror {get;set;}
  public boolean emailbool{get;set;}
  public boolean ShowUserError{get; set;}
  
  public Void savePopUpValues(){
  ShowUserError = False;
   system.debug('@@@@@@@@@@*******************$$$$$'+email);
   system.debug('BBBBBBBBBBBBBBAAAAAAAAAAAWWWWWWWWWWWWWW '+eventSelected);
    List<User_Profile_Event__c>  boothadminProfile  = new  List<User_Profile_Event__c>();
 boothadminProfile = [Select Id,BT_id__c from  User_Profile_Event__c where BoothAdmin_id__c=:UserInfo.getUserId() AND EV_id__c =:eventSelected];
  
      
    if((country !='' && country!=null) && (Createuser.LastName !='' && Createuser.LastName!=null) && (Createuser.FirstName!='' && Createuser.FirstName!=null) &&  (email !='' && email !=null) ){
      
       
     List<AttendeeSummary__c> attvalues=new List< AttendeeSummary__c>();
        attvalues=[Select a.Id, a.AS_Title__c, a.AS_LastName__c,  a.AS_FirstName__c, a.AS_Email__c,  AS_Company__c From AttendeeSummary__c a where a.AS_Email__c=:email limit 1];
      
        AttendeeSummary__c attnew = new AttendeeSummary__c();
            if(attvalues.size() > 0){
                attnew=attvalues[0];
            }
          
        attnew.AS_Email__c =email;
        attnew.AS_LastName__c=Createuser.LastName;
        attnew.AS_Title__c=Createuser.title;
        attnew.AS_FirstName__c=Createuser.FirstName;
        attnew.AS_uniqueField__c = (Createuser.FirstName+Createuser.LastName+email).tolowercase();
         
        Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
        Database.UpsertResult upResult = DataBase.upsert(attnew,f,false);
        
        system.debug('BBBBBBBBBBBB AAAAAAAAAAAAAAAA'+email);
        
        List<user> Allusers =[select Name,id,Email,profileId,profile.Name from user where userName=:email limit 1];
        
         List<User> BoothAdmin = [select companyName from user where userName=:userInfo.getUserName()];
        
         system.debug('BBBBBBBBBBBB '+Allusers );
        
        Event_Attendee_Mapping__c tr= new Event_Attendee_Mapping__c();
        tr.EV_id__c =eventSelected;
        tr.AS_id__c =attnew.id;
        tr.Attendee_Event_IDs__c =attnew.id+eventSelected;
        dataBase.insert(tr,false);
        
        tr.EA_AttendeeBarcode__c =tr.id+'-'+eventSelected;
        dataBase.update(tr,false);
        
        
        profile__c pro = [select id from profile__c where PR_Name__c='BoothPersonnel'];
         
         if(Allusers.size()>0){
          system.debug('AAAAAAAAAAAAAAAAAAAAAA ');
                              
                List<User_Profile_Event__c> checkLicenses = new List<User_Profile_Event__c>(); 
                   checkLicenses =[select id,BT_id__c,Status__c,BoothAdmin_id__r.id, EV_id__r.id,Profile_id__c from User_Profile_Event__c where EV_id__r.id=:eventselected and User_id__r.userName=:email ];  
                    
                     if(checkLicenses.size()>0){
                              Allusers[0].isActive =true;
                              database.update(Allusers[0],false);
                                                  
                         if(checkLicenses[0].BoothAdmin_id__r.id!=NULL){  
                                                    
                             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'User already Exist'));
                          
                        }else{
                       
                            checkLicenses[0].Profile_id__c=pro.id;
                            checkLicenses[0].Status__c =country;
                             checkLicenses[0].BoothAdmin_id__c =userInfo.getUserId();
                            dataBase.upsert(checkLicenses[0],false);                
                           displayPopUpForAddBooth =false; 
                          getBoothPersonnels();  
                        }  
                        
                        
                        
                    }else {
                      User_Profile_Event__c uu = new  User_Profile_Event__c();
                      uu.User_id__c =Allusers[0].id;
                      uu.EV_id__c =eventSelected;
                      uu.BoothAdmin_id__c =userInfo.getUserId();
                      uu.Profile_id__c=pro.Id;
                      uu.UEP_isActive__c =true;
                     uu.BT_id__c=boothadminProfile[0].BT_id__c;
                      uu.status__c =country;
                      dataBase.insert(uu,false);
                     system.debug(' FRRRRRRRRRRRRRRRRRrFFFFFFFFFFFFFFf');
                     displayPopUpForAddBooth =false; 
                      getBoothPersonnels();  
                    }
                    
                    
                    
                
            }else{
                system.debug('BBBBBBBBBBBBBBAAAAAAAAAAA'+BoothAdmin[0].companyName);
                Account Acc= [select id from Account where Name =: 'Booth Leads' LIMIT 1];
                
                
                contact cont = new Contact(AccountId =Acc.id,
                LastName = Createuser.LastName,
                FirstName = Createuser.FirstName);
                insert cont;
                
                string df = string.valueOf(Email);
                integer i = df.indexOf('@');
                    if(i>3){
                     string ght = df.substring(0,3);
                    }else{
                     string ght = df.substring(0,1);
                    }
                    
              
                User user = new User(
                    Username = email,Email =email,contactId =cont.id,
                    firstname = Createuser.FirstName,
                    LastName = Createuser.LastName, Alias ='BAdmin',
                    ProfileID =userInfo.getProfileId() ,LocaleSidKey ='en_US',
                    LanguageLocaleKey ='en_US',TimeZoneSidKey ='America/Los_Angeles', 
                    EmailEncodingKey='UTF-8',Title=Createuser.title,
                    isactive=false,companyName= BoothAdmin[0].companyName);
                    
                    dataBase.saveResult saveResult = dataBase.insert(user,false);
                    
                      System.debug('saveResult    '+saveResult );
                     if(saveResult.isSuccess()){
                     User_Profile_Event__c uu = new  User_Profile_Event__c();
                     uu.User_id__c =user.id;
                     uu.EV_id__c =eventSelected;
                     uu.BoothAdmin_id__c =userInfo.getUserId();
                     uu.Profile_id__c=pro.Id;
                     uu.UEP_isActive__c =true;
                     uu.BT_id__c=boothadminProfile[0].BT_id__c;
                     uu.status__c =country;
                     dataBase.insert(uu,false);
                     system.debug(' FFFFFFFFFFFFFFFF FFFFFFFFFFFFFFFFFFFFFf');
                    }
                    displayPopUpForAddBooth =false; 
                      getBoothPersonnels();
                       
            } 
      }else{
      
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Required Fields are missing!')); 
      
      }  
    
      
    
 }

   



    public PageReference addPersonnels() {
              
  try{               
      if(eventSelected ==null && eventSelected ==''){
      if(defaultEvent != '' && defaultEvent !=null){
          if(Id == null || Id == '')
         eventSelected =defaultEvent;
       }
    } 
          system.debug('999999999999999999999999  '+eventSelected);
        
        message ='';
    List<User_Profile_Event__c> checkLicenses = new  List<User_Profile_Event__c>();
  checkLicenses = [Select u.BT_id__r.BT_RegistrationLink__c, u.BT_id__r.BT_Description__c, u.BT_id__r.blp_id__c, u.BT_id__r.EV_id__c, u.BT_id__r.BT_PDFLocation__c, u.BT_id__r.BT_WebsiteURL__c, u.BT_id__r.BT_ContactEmail__c, u.BT_id__r.BT_ContactPhone__c, u.BT_id__r.BT_ContactName__c, u.BT_id__r.BT_BoothUserCount__c, u.BT_id__r.BT_isBoothActive__c, u.BT_id__r.BT_Phone__c, u.BT_id__r.BT_Location__c, u.BT_id__r.BT_Name__c, u.BT_id__r.LastActivityDate, u.BT_id__r.SystemModstamp, u.BT_id__r.LastModifiedById, u.BT_id__r.LastModifiedDate, u.BT_id__r.CreatedById, u.BT_id__r.CreatedDate, u.BT_id__r.Name, u.BT_id__r.IsDeleted, u.BT_id__r.OwnerId, u.BT_id__r.Id, u.BT_id__c From User_Profile_Event__c u where u.User_id__r.Email=:UserInfo.getUserName() and u.EV_id__c=:eventSelected  and u.Profile_id__r.PR_Name__c='BoothAdmin' ];
    system.debug('Bosssssssssssssssssssssssssssssss     '+checkLicenses);
    
    if(checkLicenses.size()>0){
    
   for(User_Profile_Event__c rrr : checkLicenses){
       
           if(rrr.BT_id__r.BT_isBoothActive__c){
                if(rrr.BT_id__r.BT_BoothUserCount__c > 0){
                        CreateUser = new User();
                        email ='';
                        displayPopUpForAddBooth =true;
                }
             else{
            message ='You dont have licences';
            
          //  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'You dont have licenses'));

       errorMessage =true;
        system.debug('helooooooooooooooooooo Phani111111111111111    '+message);
                                
        } 
        
        }else{
            message ='Your Booth is in Inactive For this event';
           // ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'your Booth is in Inactive For this event'));

              errorMessage =true;
              system.debug('helooooooooooooooooooo Phani2222222222222222222222    '+message );
        }
        
        
   }     
      }  
  }catch(exception e){}      
        return null;
    }

    public PageReference deleteAdminRecord() {
  try{      
    message ='';
    system.debug('rrrrrrrrrrrrrrrrrrrrrrrrrrr'+eventName);  
    List<User_Profile_Event__c> tt=new List<User_Profile_Event__c>();
    tt=[select UEP_isActive__c,BT_id__r.id from User_Profile_Event__c where id=:eventName];
    booth__c booth =[select id,BT_BoothUserCount__c from booth__c where id=:tt[0].BT_id__r.id];
   
   
    for(User_Profile_Event__c y:tt){
       y.UEP_isActive__c =false;
      update y;
       booth.BT_BoothUserCount__c =booth.BT_BoothUserCount__c+1;
       update booth;
    }
    
  
      /** pagereference pg = new pagereference('/apex/BL_BoothPersonnels');
        pg.setRedirect(true);
        return pg; **/
         getBoothPersonnels();
  }catch(exception e){}
       return null; 
    }

 
    public PageReference closePopup1() {
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
    if(browserType != null && browserType.contains('MSIE')){
    Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
    }
    displayPopUpForAdd =false;
        return null;
    }


    public PageReference EditPopUpValues() {
   try{     
     system.debug('gtgtgtgtgttttttttttttttttttt '+editOfBoothPersonnel.FirstName );
     
    if((editOfBoothPersonnel.FirstName != null && editOfBoothPersonnel.FirstName !='') && (editOfBoothPersonnel.LastName != null && editOfBoothPersonnel.LastName!='') ){
    editOfBoothPersonnel.FirstName = editOfBoothPersonnel.FirstName;
    editOfBoothPersonnel.LastName = editOfBoothPersonnel.LastName ;
    editOfBoothPersonnel.Title =editOfBoothPersonnel.Title;
    update editOfBoothPersonnel;
    
    List<AttendeeSummary__c> attsumedit = new List<AttendeeSummary__c>();

 List<AttendeeSummary__c> attsumedit1 = new List<AttendeeSummary__c>();    
    attsumedit =[select id,AS_FirstName__c,AS_LastName__c,AS_Title__c from AttendeeSummary__c where AS_Email__c=:editOfBoothPersonnel.Email];
     
     for(AttendeeSummary__c a:attsumedit){
     a.AS_FirstName__c =editOfBoothPersonnel.FirstName;
     a.AS_LastName__c =editOfBoothPersonnel.LastName ;
     a.AS_Title__c =editOfBoothPersonnel.Title;
     attsumedit1.add(a);
            
     }
    update attsumedit1;
    
     displayPopUpForAdd =false;
    
   /**  pageREference pg = new pageReference('/apex/BL_BoothPersonnels');
     pg.setRedirect(true);
     return pg;**/
      getBoothPersonnels();
  }else{
  
  ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Please Enter Name');
   ApexPages.addMessage(myMsg);
  
  
  }
   }catch(exception e){}
       return null; 
    }



 
    public PageReference editAttendees() {
  try{      
       message ='';
       
     eventName =ApexPages.currentpage().getParameters().get('mycheck');  
       
    if(eventName!=null && eventName!=''){
    
   List<User_Profile_Event__c> yyy = new List<User_Profile_Event__c>();
   
    yyy = [select id,User_id__c,User_id__r.FirstName,User_id__r.LastName,User_id__r.Email,User_id__r.CompanyName,User_id__r.Title from User_Profile_Event__c where id=:eventName limit 1]; 
   
   if(yyy.size()>0){
   
   editOfBoothPersonnel =[select FirstName,LastName,companyName,Title,Email from user where id=:yyy[0].User_id__c];
   
   }
    }
    displayPopUpForAdd=true;
  }catch(exception e){}  
      return null;
 }


    public PageReference closePopup() {
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
    if(browserType != null && browserType.contains('MSIE')){
    Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
    }
       displayPopUp =false;
        return null;
    }


    public PageReference getEventDetails() {
        system.debug('444444444444444444444444444 '+Apexpages.currentpage().getParameters().get('mycheck'));
      detailsOfBoothPersonnel = [select id,User_id__r.Name,User_id__r.FirstName,User_id__r.LastName,User_id__r.Email,User_id__r.CompanyName,User_id__r.Title from User_Profile_Event__c where id=:Apexpages.currentpage().getParameters().get('mycheck') limit 1]; 
     
      displayPopUp =true;
      return null;
    }
    
    
    
    
    
    
    
    
   
    public string eventnameforGried{get;set;} 
    
    public PageReference getBoothPersonnels() {
     system.debug('6666666666666666666666666 '+eventSelected );
      message ='';      
    boothPersonnelWithStatus = new List<innerForDisplayStatus>();
    if(eventSelected ==null || eventSelected ==''){
      if(defaultEvent != '' && defaultEvent !=null){
       eventSelected =defaultEvent;
       }
    }    
    ForPagination = new List<innerForDisplayStatus>();
      List<event__c> evegrid =new List<event__c>();
     evegrid =[select id,EV_Title__c from Event__c where id=:eventselected limit 1];
     if(evegrid.size()>0){
     eventnameforGried =evegrid[0].EV_Title__c;
     }
  
     Boothpersonnels = new List<User_Profile_Event__c>();
    // Boothpersonnels =[select Status__c,BoothAdmin_id__c,id,User_id__r.Name,User_id__r.FaceBookId__c,User_id__c,User_id__r.FirstName,UEP_isActive__c ,User_id__r.LastName,User_id__r.Email,User_id__r.CompanyName,User_id__r.Title from User_Profile_Event__c where (EV_id__c=:eventSelected and Profile_id__r.PR_Name__c='BoothPersonnel' and BoothAdmin_id__c=:UserInfo.getUserId())  OR  (EV_id__c=:eventSelected and IsBoothPersonnel__c =true and BoothAdmin_id__c=:UserInfo.getUserId()) ]; 
   Boothpersonnels =[select Status__c,BoothAdmin_id__c,id,User_id__r.Name,User_id__r.FaceBookId__c,User_id__c,User_id__r.FirstName,UEP_isActive__c ,User_id__r.LastName,User_id__r.Email,User_id__r.CompanyName,User_id__r.Title from User_Profile_Event__c where (EV_id__c=:eventSelected and BoothAdmin_id__c=:UserInfo.getUserId()) ]; 
    system.debug('Booth personnels count '+Boothpersonnels);
    
    if(Boothpersonnels.size()>0){
    for(User_Profile_Event__c upe:Boothpersonnels){
    if(upe.User_id__r.CompanyName != null){
    upe.User_id__r.CompanyName =escapeSpecialCharacters(upe.User_id__r.CompanyName);
    }
     if(upe.User_id__r.Title !=NULL )
    upe.User_id__r.Title =escapeSpecialCharacters(upe.User_id__r.Title);
    if(upe.UEP_isActive__c ==true){
    statusValue = 'Active';
    } else{
    statusValue ='InActive';
    }
   boothPersonnelWithStatus.add(new innerForDisplayStatus(upe,statusValue));
   } 
   
   
    try{
       if(boothPersonnelWithStatus.size()>0)
        {
        system.debug('==================='+boothPersonnelWithStatus);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=boothPersonnelWithStatus.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(boothPersonnelWithStatus.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=boothPersonnelWithStatus.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(boothPersonnelWithStatus.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<50;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+boothPersonnelWithStatus[i]);
        
        ForPagination.add(boothPersonnelWithStatus[i]);
        
        if(boothPersonnelWithStatus.size() <=50){
        hasLast = false;
        hasNext=false;
       
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       
       hasNext=true;
       }
        
        }
        }}catch(exception e) {}  
   
   
   
   
     }
      
        return null;
   }



 public class innerForDisplayStatus
 {    
  public User_Profile_Event__c upevalue{get;set;}
  public string strForDisplayStatus{get;set;}   
  public  innerForDisplayStatus(User_Profile_Event__c valueOfupe,string strForDisplay)
  {
   this.upevalue =valueOfupe;
   this.strForDisplayStatus =strForDisplay;
  }
 }






public String escapeSpecialCharacters(String input){
  if(input!= null && input != '' && (input.contains('"') )){
           input = input.replace('"','');
         }
        if(input!= null && input != '' && (input.contains('<') )){
        input = input.replace('<','');
        
        }

         if(input!= null && input != '' && (input.contains('\\') )){
          input = input.replace('\\','');
        }
      
      
     /* 
        if(input!= null && input != '' && (input.contains('"') )){
           input = input.replace('"','\\\"');
         }
        if(input!= null && input != '' && (input.contains('<') )){
        input = input.replace('<','');
        
        }
        system.debug('vachindhaaaaaaaaaaaaaaaaaaaaaaaaa  ttttttttttt'+input);
         if(input!= null && input != '' && (input.contains('\\') )){
           system.debug('vachindhaaaaaaaaaaaaaaaaaaaaaaaaa after '+input);
          input = input.replace('\\','\\\\');
        }
     */
   return input;
  }



 
 



public List<SelectOption> getItems() {
try{
 List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
 EvntsForPicklist = new List<Event__c>();
 upeForEvents = [Select u.User_id__c, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where u.User_id__r.Email=:UserInfo.getUserName() and (Status__c!='Mobile only access' And Status__c!='InActive')];
 set<Id> setOfEventIds = new set<Id>();
 
 for(User_Profile_Event__c rotatinnFor:upeForEvents){
 setOfEventIds.add(rotatinnFor.EV_id__c);
 }
 
 EvntsForPicklist =[select  id,EV_Title__c from Event__c where id in :setOfEventIds order by EV_StartDate__c];
 if(EvntsForPicklist.size()>0){
 defaultEvent =EvntsForPicklist[0].id;
 system.debug('4444444444444444444444444444444444444444444  '+defaultEvent );
 
 }
 List<SelectOption> options = new List<SelectOption>();
 for(Event__c Event:EvntsForPicklist ){
  options.add(new SelectOption(Event.id,Event.EV_Title__c));
  }
  return options;
}catch(exception e){return null;}
 }

public List<SelectOption> SeletSelect{get;set;}
public User_Profile_Event__c upeFordisplayStatus {get;set;}
public String PreviousStingValue{get;set;}

 public PageReference deleteAdminRecord1() 
 {
 try{   
  errormsg ='';
  eventName =Apexpages.currentPage().getParameters().get('mycheck');
  displayPopUpForAddcheck  =true;
  upeFordisplayStatus =[select Status__c,BT_id__c,BT_id__r.BT_BoothUserCount__c,UEP_isActive__c from User_Profile_Event__c where id =:eventName];
  
  countrySelect=upeFordisplayStatus.Status__c;    
  PreviousStingValue =countrySelect;
    
  SeletSelect = new List<SelectOption>(); 
   SeletSelect.add(new SelectOption('Mobile only access','Mobile only access')); 
   SeletSelect.add(new SelectOption('Mobile and Portal Access','Mobile and Portal Access')); 
   
   if(countrySelect.trim() != 'InActive'){
    SeletSelect.add(new SelectOption('InActive','InActive')); 
   } 
 }catch(exception e){
    
 
 }  
  return null; 
 }
 
 
public List<User_Profile_Event__c> checkedstatus{get;set;}
public Id boothadminid{get;set;}
public string boothadminiderror{get;set;}

 public void boothuserstatus()
 {  
  try{  
  system.debug('++++++++++++='+eventname);
  string[] ss=eventname.split(',');
  system.debug('status is'+ss);
  string bustatus=ss[1];
  system.debug('status is '+bustatus);
  boothadminid=ss[0];
  
  checkedstatus=new List<User_Profile_Event__c>();
  checkedstatus=[select Status__c,BT_id__c,BT_id__r.BT_BoothUserCount__c,Profile_id__r.Pr_Name__c,UEP_isActive__c from User_Profile_Event__c where id =:ss[0]];
  if(checkedstatus[0].Profile_id__r.Pr_Name__c=='BoothAdmin')
  { 
  system.debug('Booth admin Yes'+checkedstatus[0].Profile_id__r.Pr_Name__c);
   boothadminiderror='You can not change status of Booth Admin';
  }
  else{
  system.debug('Booth admin No'+checkedstatus[0].Profile_id__r.Pr_Name__c);
   SeletSelect = new List<SelectOption>(); 
   SeletSelect.add(new SelectOption('Mobile only access','Mobile only access')); 
   SeletSelect.add(new SelectOption('Mobile and Portal Access','Mobile and Portal Access')); 
 
  List<User_Profile_Event__c> changedstatus=new List<User_Profile_Event__c>();
  for(User_Profile_Event__c dd:checkedstatus)
  {
   if(bustatus== 'Mobile only access'){ 
    dd.Status__c='Mobile only access';
   }
   else{
    dd.Status__c='Mobile and Portal Access';
   }
   changedstatus.add(dd);
  }  
  update changedstatus;  
  }  
  }catch(exception e){}
 }
 
 // Added by Shruthi to maintian same Event through out tabs
 
     public String Id {get;set;}
 
     public void URLEvent(){
     
     Id = apexpages.currentpage().getparameters().get('id');
         if(Id != null){
             eventSelected = id;
         }
     
     }
 
 
 
 

}