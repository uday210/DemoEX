public  without sharing class BL_AttendeesCon{
public String searchString { get; set; }
public blob b{get;set;}   
public string transfer{get;set;}   
public String body { get; set; }
public String subject { get; set; }
public String EmailTo { get; set; }
public boolean email{get;set;}
public string[] strAlfhabets{get;set;}
public boolean BVSDetail{get;set;}
public BoothVisitSummary__c attendeeSummary{get;set;}
public string strNamesmult{get;set;}   
public string eventName{get;set;}
public   List<List<BoothVisitSummary__c>> bvsList{get;set;}
public string defaultEvent{get;set;}
public String eventSelected { get; set; }
public List<Event__c> EvntsForPicklist{get;set;}
public List<BoothVisitSummary__c> BVSListsel{get;set;} 
  
  
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

  
  
public BL_AttendeesCon(){
    try{
String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
searchString ='';

 strAlfhabets = new string[]{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
 booleanforDisplayBoothadminTab = false;
 List<User_Profile_Event__c>  forDisplayBoothdmintab= [Select u.User_id__c,u.Profile_id__r.PR_Name__c,u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where u.User_id__r.Email=:userInfo.getUserName() and (Status__c!='Mobile only access' And Status__c!='InActive') ];
    for(User_Profile_Event__c tt:forDisplayBoothdmintab){
      if(tt.Profile_id__r.PR_Name__c !='Attendee' && tt.Profile_id__r.PR_Name__c !='BoothPersonnel' ){
       booleanforDisplayBoothadminTab = true;
      }   
    }
getEvents();
    }catch(exception e){}   
}

   

 public PageReference search() 
 {   
    try{
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
  set<id> setofboothpersonnelIds = new  set<id>();
   bvsList = new List<List<BoothVisitSummary__c>>();
   List<BoothVisitSummary__c> bvsListbefore = new List<BoothVisitSummary__c>(); 
   
    List<BoothVisitSummary__c> bvsvaluesbefore1= new List<BoothVisitSummary__c>(); 
    
   List<User_Event_BVS__c> bvsvalues = new  List<User_Event_BVS__c>(); 
   if(eventSelected =='All'){
         bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') or (u.UPE_id__r.User_id__c=:userInfo.getUserId()  and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') ];  
        system.debug('searchhhhhhhhhhhhhhhhhhhhhhh '+bvsvalues );
       } else{
       bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') OR (u.UPE_id__r.User_id__c=:userInfo.getUserId() and u.UPE_id__r.UEP_isActive__c=true and u.EV_id__c=:eventSelected and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive')];  
      }  
          
       for(User_Event_BVS__c h:bvsvalues)
       {
        setofboothpersonnelIds.add(h.BVS_id__c);
       }
      
      
      
        List<attachment> att = new List<attachment>();
         att =[select id,parentid  from attachment where parentid in:setofboothpersonnelIds];
         for(attachment ar:att){
         mapImage.put(ar.parentid,ar.id);  
         }
      integer recCount=0;
      
      
       
         bvsListbefore = [Select b.Dummy__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c From BoothVisitSummary__c b where id in :setofboothpersonnelIds and (BVS_FirstName__c like :searchString+'%'  or BVS_LastName__c like :searchString+'%') and EA_AttendeeBarcode__c!=null ORDER BY ScanTime__c];
          system.debug('searchhhhhhhhhhhhhhhhhhhhhhh 333333333'+bvsList );
          for(BoothVisitSummary__c yt:bvsListbefore)
            {
            yt.BVS_FirstName__c =escapeSpecialCharacters(yt.BVS_FirstName__c); 
            
            system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ after '+yt.BVS_FirstName__c);
            yt.BVS_LastName__c =escapeSpecialCharacters( yt.BVS_LastName__c);
            yt.BVS_Company__c =escapeSpecialCharacters(yt.BVS_Company__c);
            yt.BVS_LeadCategory__c=escapeSpecialCharacters(yt.BVS_LeadCategory__c);
            yt.BVS_FollowUps__c=escapeSpecialCharacters(yt.BVS_FollowUps__c);
            try{ 
             yt.ScanTime__c= getLocalDateTime( yt.ScanTime__c);
            }catch(exception e){}
            if(mapImage.get(yt.id) != null){
           
            yt.Dummy__c =mapImage.get(yt.id);
              
            }
            yt.BVS_Notes__c=escapeSpecialCharacters(yt.BVS_Notes__c);    
            recCount++;
            bvsvaluesbefore1.add(yt);
            
              if(recCount==1000)
                  {
                        bvsList.add(bvsvaluesbefore1);
                        bvsvaluesbefore1 = new LIST<BoothVisitSummary__c>();
                        recCount=0;
                  }
            
            }
            
       
if(recCount !=0)
   bvsList.add(bvsvaluesbefore1);     
     
    }catch(exception e){}   
            
          return null;
    
    }










  public PageReference cancel() {
   String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
     email=false;
        return null;
    }


     public PageReference sendEmail() {
   try{     
     system.debug('Value Of eventNAme     '+eventname);
    if(EmailTo!=''){ 
    if(eventname != '' && eventname != null){
    BVSListsel = checkBVSList(eventname);
    transfer = 'Prefix::::::::;;;;;;;;First Name::::::::;;;;;;;;Last Name::::::::;;;;;;;;Suffix::::::::;;;;;;;;Email Id::::::::;;;;;;;;Company::::::::;;;;;;;;Designation::::::::;;;;;;;;Mobile Number::::::::;;;;;;;;Age::::::::;;;;;;;;Gender::::::::;;;;;;;;Date Of Birth::::::::;;;;;;;;Home Phone Number::::::::;;;;;;;;Home Address1::::::::;;;;;;;;Home Address2::::::::;;;;;;;;Home City::::::::;;;;;;;;Home State::::::::;;;;;;;;Home Country::::::::;;;;;;;;Home Zip Code::::::::;;;;;;;;Primary Business Category::::::::;;;;;;;;Secondary Business Category::::::::;;;;;;;;No.Of Employees::::::::;;;;;;;;Businees Established Date::::::::;;;;;;;;Business Duns Number::::::::;;;;;;;;Business Revenue::::::::;;;;;;;;Business Tax Id::::::::;;;;;;;;Blog URL::::::::;;;;;;;;Website URL::::::::;;;;;;;;Diversity Type::::::::;;;;;;;;Businees Description::::::::;;;;;;;;Work Phone::::::::;;;;;;;;Work Address1::::::::;;;;;;;;Work Address2::::::::;;;;;;;;Work city::::::::;;;;;;;;Work State::::::::;;;;;;;;Work Country::::::::;;;;;;;;Work Zip Code::::::::;;;;;;;;Shipping Phone::::::::;;;;;;;;Shipping Address1::::::::;;;;;;;;Shipping Address2::::::::;;;;;;;;Shipping City::::::::;;;;;;;;Shipping State::::::::;;;;;;;;Shipping country::::::::;;;;;;;;Shipping Zip Code::::::::;;;;;;;;NAICS Code1::::::::;;;;;;;;NAICS Code2::::::::;;;;;;;;NAICS Code3::::::::;;;;;;;;NAICS Code4::::::::;;;;;;;;NAICS Code5::::::::;;;;;;;;Follow-up Date::::::::;;;;;;;;Scanned By::::::::;;;;;;;;Notes::::::::;;;;;;;;follow-up type::::::::;;;;;;;;Survey Question1::::::::;;;;;;;;Survey Question2::::::::;;;;;;;;Survey Question3::::::::;;;;;;;;Survey Answer1::::::::;;;;;;;;Survey Answer2::::::::;;;;;;;;SurveyAnswer3'+'\r';
    for(BoothVisitSummary__c ss:BVSListsel) {
    
    string asb = string.valueOf(ss.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c);
    if(ss.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c != null){
     
     transfer += ss.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c+'::::::::;;;;;;;;'+asb+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c+'::::::::;;;;;;;;'+ss.Follow_Update__c+'::::::::;;;;;;;;'+ss.User_id__r.Name+'::::::::;;;;;;;;'+ss.BVS_Notes__c+'::::::::;;;;;;;;'+ss.BVS_FollowUps__c+'::::::::;;;;;;;;'+ss.BVS_SurveyQuestion1__c+'::::::::;;;;;;;;'+ss.BVS_SurveyQuestion2__c+'::::::::;;;;;;;;'+ss.BVS_SurveyQuestion3__c+'::::::::;;;;;;;;'+ss.BVS_SurveyAnswer1__c+'::::::::;;;;;;;;'+ss.BVS_SurveyAnswer2__c+'::::::::;;;;;;;;'+ss.BVS_SurveyAnswer3__c+'\r'; 
    }else{
    transfer +=''+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c+'::::::::;;;;;;;;'+asb +'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c+'::::::::;;;;;;;;'+ss.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c+'::::::::;;;;;;;;'+ss.Follow_Update__c+'::::::::;;;;;;;;'+ss.User_id__r.Name+'::::::::;;;;;;;;'+ss.BVS_Notes__c+'\r'; 
    
    }
 }
      
    transfer = transfer.ReplaceAll(',', ' ').ReplaceAll('::::::::;;;;;;;;', ',').ReplaceAll('null','');
    system.debug('hi iiiiiiii ooooooooo    '+transfer); 
    b = blob.valueOf(transfer); 
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>(); 
    List<String> emailList = new LIST<String>();
    emailList = EmailTo.split(',');
    for(String singlemail: emailList)
    {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject(subject);
            String [] toAddresses = new String[] {singlemail};
            email.setToAddresses(toAddresses);
            String emailBody = body;
            email.setPlainTextBody(emailBody);
            email.setHtmlBody(emailBody);
            email.setInReplyTo(userInfo.getUserName());
                   
                 Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                 efa.setFileName('Attendee Leads.Csv');                                                        
                 efa.setBody(b);                                                                          
                 email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); 
                 
            mails.add(email);
    } 
          
     Messaging.SendEmailResult [] msgResult =Messaging.sendEmail(mails);   
     
     EmailTo ='';
     BVSListsel.clear();
     body='';
     subject='';
     email=false;
      
      system.debug('##################'+ email );
   }
 }  
   }catch(exception e){}  
     return null;
 }


     public void EmailCsv(){
    try{
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
     subject ='Leads From Booth Leads';
      system.debug('909090909099090909090909   '+eventname); 
      if(eventname != '' && eventname != null){
      email=true;
     }else{
     system.debug('44444444444444444444444 ');
     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Select at least one lead'));
     }
    }catch(exception e){} 
   }

public boolean booleanforDisplayBoothadminTab{get;set;}

    public PageReference valuesOfeventswithselectedvalue() {
 try{       
   string xx = ApexPages.currentPage().getParameters().get('valu');
   integer recCount = 0;
   set<Id>  setofboothpersonnelIds = new set<Id>();
       bvsList = new List<List<BoothVisitSummary__c>>(); 
       List<User_Event_BVS__c> bvsvalues = new  List<User_Event_BVS__c>(); 
       List<BoothVisitSummary__c> bvsvaluesbefore1 = new List<BoothVisitSummary__c>();
       List<BoothVisitSummary__c> bvsvaluesbe = new List<BoothVisitSummary__c>();
       
       if(eventSelected =='All'){
       bvsvalues =[select BVS_id__c from User_Event_BVS__c u where 
             
       (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' ) OR 
       (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' )];  
       
       }
       else{
       bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' ) OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and  u.UPE_id__r.UEP_isActive__c=true and u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive' )];  
      }
           for(User_Event_BVS__c h:bvsvalues){
                 setofboothpersonnelIds.add(h.BVS_id__c);
           }
           system.debug('valueeeeeeeeeeeeeeeeeeeeeee OF XXXXXXXXXXXXXXXXXXXXXXXXX'+xx);
            system.debug('valueeeeeeeeeeeeeeeeeeeeeee OF yyyyyyyyyyyyyyyyyyyyyyyy'+eventSelected );
           
          if(xx!='All')
           bvsvaluesbe = [Select b.ScanTime__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c From BoothVisitSummary__c b where id in :setofboothpersonnelIds and  b.BVS_LastName__c like :xx+'%'  and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC  ];
          else
          bvsvaluesbe = [Select b.ScanTime__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c From BoothVisitSummary__c b where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
          
          
         
          system.debug('valueeeeeeeeeeeeeeeeeeeeeee OF zzzzzzzzzzzzzzzzzzzzz'+bvsList);
            for(BoothVisitSummary__c yt: bvsvaluesbe ){
            yt.BVS_FirstName__c =escapeSpecialCharacters(yt.BVS_FirstName__c);
            yt.BVS_LastName__c =escapeSpecialCharacters( yt.BVS_LastName__c);
            yt.BVS_Company__c =escapeSpecialCharacters(yt.BVS_Company__c);
            yt.BVS_LeadCategory__c=escapeSpecialCharacters(yt.BVS_LeadCategory__c);
            yt.BVS_FollowUps__c=escapeSpecialCharacters(yt.BVS_FollowUps__c);
            yt.BVS_Notes__c=escapeSpecialCharacters(yt.BVS_Notes__c);
           try{
            yt.ScanTime__c= getLocalDateTime( yt.ScanTime__c);
           }catch(exception e){}
            recCount++;
            bvsvaluesbefore1.add(yt);
            if(recCount==1000)
      {
            bvsList.add(bvsvaluesbefore1);
            bvsvaluesbefore1 = new LIST<BoothVisitSummary__c>();
            recCount=0;
      }
           
            }
        
if(recCount !=0)
   bvsList.add(bvsvaluesbefore1);    
       
 }catch(exception e){}          
            return null;
   
 }



 public List<BoothVisitSummary__c> checkBVSList(String listOfBVS){
 try{
  integer ph;
  List<BoothVisitSummary__c>  localBVSListSelected = new List<BoothVisitSummary__c> ();
  List<ID> selectedBVSList = new List<ID>();
  
  system.debug('value of listOfBVS '+listOfBVS);
  
  selectedBVSList = listOfBVS.split(',');
    if(selectedBVSList.size()>0){
       localBVSListSelected =  [Select  b.EA_AttendeeBarcode__r.DiversityType__c,b.User_id__r.Name,b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,b.EA_AttendeeBarcode__r.AS_id__r.Id, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ThroughEventBrite__c, b.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c,b.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c,Follow_Update__c From BoothVisitSummary__c b where id in :selectedBVSList and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
          if(localBVSListSelected.size()>0){
              for(BoothVisitSummary__c rt : localBVSListSelected ){
              if(rt.Follow_Update__c !=null){
              rt.Follow_Update__c =getLocalDateTime(rt.Follow_Update__c);
              }
              if(rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c != null && rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c!=''){
         rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c);
        }
       if(rt.BVS_FirstName__c != null && rt.BVS_FirstName__c!=''){
         system.debug('777777777777777777 '+rt.BVS_FirstName__c);
          rt.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =escape(rt.BVS_FirstName__c); 
         }else{
         rt.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c); 
         }
       
                  
         
       
        if(rt.BVS_lastName__c != null && rt.BVS_LastName__c!=''){
        rt.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =escape(rt.BVS_LastName__c); 
       }   else{
       rt.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c); 
       }    
          
           if(rt.BVS_Title__c != null && rt.BVS_Title__c!=''){
        rt.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.BVS_Title__c); 
       } else{
       rt.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c); 
       }
       
       if(rt.BVS_Email__c!= null && rt.BVS_Email__c!=''){
        rt.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c=escape(rt.BVS_Email__c); 
       } else{
       rt.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c); 
       }
       
       
                  
           if(rt.BVS_Company__c != null && rt.BVS_Company__c !=''){
           rt.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =escape(rt.BVS_Company__c); 
         } else{
          rt.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =escape( rt.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c); 
         }
     
     
      if(rt.BVS_PhoneNumber__c != null && rt.BVS_PhoneNumber__c !=''){
        rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =escape(rt.BVS_PhoneNumber__c); 
       }  else{
        rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c); 
       }
                 
                  rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c);
                 
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c);
                  
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c);
                  
                  rt.EA_AttendeeBarcode__r.DiversityType__c =escape(rt.EA_AttendeeBarcode__r.DiversityType__c);
                  
                  
                  
                  
                  if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c!=null && string.ValueOf(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c).startswith('0')){
                   rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c ='"=TEXT('+rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c+','+'\""00000\"")"';
               }else if(rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c !=null){
               
               rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c =rt.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c;
               }
                  
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c);
                 
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c);
                  rt.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c=escape(rt.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c);
                  rt.BVS_FollowUps__c =escape(rt.BVS_FollowUps__c);
                  rt.BVS_Notes__c =escape(rt.BVS_Notes__c);
             }
           } 
       }
       return localBVSListSelected;
 }catch(exception e){return null;}       
       
  }






   
     public  List<BoothVisitSummary__c> supportList{get;set;} 
    public string displayerrorForNoselection{get;set;}
    
    public PageReference seltoexport() {
        try{
        String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
     supportList = new List<BoothVisitSummary__c>(); 
    supportList = checkBVSList(Eventname);
    if(supportList.size()>0){
    BVSList = new List<List<BoothVisitSummary__c>>(); 
    BVSList.add(supportList);  
    PageReference pageRef= new PageReference('/apex/BL_ExportToCsv');
    pageRef.setredirect(false);
    return pageRef;
  
    
   }else{
 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Select at least one lead'));
    return null;
  } 
    }catch(exception e){return null;}    
   
   }

  public Id attachmentIdOfImage {get;set;}
 public Id urlIdOfImage {get;set;}

    public void  getEventDetails() {
 try{       
    attendeeSummary = new BoothVisitSummary__c();
    attachmentIdOfImage =null;
    urlIdOfImage =null;
   // Commanforstates utillCommanforstates = new Commanforstates();
    
      if(eventName!=null && eventName!=''){
       attendeeSummary = [Select  b.ScanTime__c,b.Dummy__c,b.EA_AttendeeBarcode__r.DiversityType__c,  b.BVS_Email__c,b.BVS_State__c,b.BVS_City__c,b.Follow_Update__c,b.BVS_LeadRating__c,b.BVS_SurveyQuestion4__c,b.BVS_SurveyQuestion3__c,b.BVS_SurveyQuestion2__c,b.BVS_SurveyQuestion1__c,b.BVS_SurveyAnswer4__c,b.BVS_SurveyAnswer3__c,b.BVS_SurveyAnswer2__c,b.BVS_SurveyAnswer1__c,b.EA_AttendeeBarcode__r.EV_id__c,b.BVS_PhoneNumber__c,b.BVS_Company__c,b.BVS_Title__c,b.BVS_LastName__c,b.BVS_FirstName__c,b.User_id__r.Name,b.BVS_FollowUps__c,b.BVS_Notes__c , b.EA_AttendeeBarcode__r.AS_id__r.Id, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkZip__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WorkAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_WebsiteUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ThroughEventBrite__c, b.EA_AttendeeBarcode__r.AS_id__r.As_SuffixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_shippingzip__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingCity__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ShippingAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_SecondaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, b.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NumberOfEmployees__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode5__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode4__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode3__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_NAICSCode1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c,b.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePoBox__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomePhone__c, b.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeCity__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress2__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_HomeAddress1__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Gender__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_FaxNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_DiversityType__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessTaxId__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessRevenue__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessEstablishedDate__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDunsNumber__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BusinessDescription__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BlogUrl__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_BirthDate__c, b.EA_AttendeeBarcode__r.AS_id__r.AS_Age__c From BoothVisitSummary__c b where id=:eventName and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
      
      
      
      gg = new BL_SecuritySettingsCon(attendeeSummary.EA_AttendeeBarcode__r.EV_id__c);


       if(attendeeSummary.EA_AttendeeBarcode__c !=null){
       BVSDetail =true;
       if(attendeeSummary.BVS_FirstName__c != null && attendeeSummary.BVS_FirstName__c!=''){
          
            attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =attendeeSummary.BVS_FirstName__c; 
           system.debug('hi        this is after '+attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c);
       }
       
        if(attendeeSummary.BVS_lastName__c != null && attendeeSummary.BVS_LastName__c!=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =attendeeSummary.BVS_LastName__c; 
       } 
       if(attendeeSummary.Follow_Update__c!=null){      
         attendeeSummary.Follow_Update__c= getLocalDateTime(attendeeSummary.Follow_Update__c);
         }
         if(attendeeSummary.BVS_Email__c!= null && attendeeSummary.BVS_Email__c!=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c=attendeeSummary.BVS_Email__c; 
       }     
     
      if(attendeeSummary.BVS_Title__c != null && attendeeSummary.BVS_Title__c!=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =attendeeSummary.BVS_Title__c; 
       } 
     
     
     if(attendeeSummary.BVS_Company__c != null && attendeeSummary.BVS_Company__c !=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =attendeeSummary.BVS_Company__c; 
       } 
     
     
      if(attendeeSummary.BVS_PhoneNumber__c != null && attendeeSummary.BVS_PhoneNumber__c !=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =attendeeSummary.BVS_PhoneNumber__c; 
       } 
       
       
      if(attendeeSummary.BVS_City__c != null && attendeeSummary.BVS_City__c !=''){
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_WorkCity__c =attendeeSummary.BVS_City__c; 
       } 
       
     
     system.debug('555555555555555  '+attendeeSummary.BVS_State__c);
       if(attendeeSummary.BVS_State__c != null && attendeeSummary.BVS_State__c !=''){
      
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c =attendeeSummary.BVS_State__c; 
      
       } else{
        attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c =attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c; 
       
       }
       
       
     /**  if(mapImage.get(attendeeSummary.id) != null){
       attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c  =  mapImage.get(attendeeSummary.id);     
      }**/
      // attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c=utillCommanforstates.mapstate(attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_Work_Country__c);
       //attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c =utillCommanforstates.mapstate(attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_States__c);
       //attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c =utillCommanforstates.mapstate(attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Shipping_Country__c);
       
       
       
      // attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c =utillCommanforstates.mapstate( attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Home_State__c);
      // attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c =utillCommanforstates.mapstate(attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.As_Home_Country__c);
       
       
       List<attachment> attendeeattachment = new List<attachment>();
       
       attendeeattachment = [select parentid,id from attachment where parentid=:attendeeSummary.Id];
       
       
       if(attendeeattachment.size()>0){
       attachmentIdOfImage =attendeeattachment[0].id;
      }else if(attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c !=null){
       urlIdOfImage =attendeeSummary.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c;
      }
       
       
       
      }
      
      
      listOfintegers = new  List<String>();
     integer i =5;
     integer intege = math.round(attendeeSummary.BVS_LeadRating__c);
     string strofimageurl1 ;
     for (Integer z = 1; z <= 5; z++) { 
              strofimageurl1 ='/resource/'; 
              strofimageurl1  += (z <= intege) ? '1346313847000/FilledStar' : '1346313847000/EmptyStars'; 
               listOfintegers.add(strofimageurl1);
            }
      
      }
 }catch(exception e){}     
    }
   
  public List<String> listOfintegers{get;set;}

  public  BL_SecuritySettingsCon gg{get;set;}
  public map<string,string> mapImage {get;set;}
  
    public PageReference getEvents() {
    try{
     system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ eventSelected '+eventSelected );
    mapImage  = new map<string,string>();
    if(eventSelected == NULL || eventSelected =='ALL' ){
       eventSelected ='All';
       set<id> setofboothpersonnelIds = new  set<id>();
       bvsList = new List<List<BoothVisitSummary__c>>(); 
       List<BoothVisitSummary__c > bvsvaluesbefore1 = new  List<BoothVisitSummary__c >(); 
       List<BoothVisitSummary__c > bvsListBefore = new  List<BoothVisitSummary__c >();
       List<User_Event_BVS__c> bvsvalues = new List<User_Event_BVS__c>();
       
       bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName()  and u.UPE_id__r.UEP_isActive__c=true and  (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') ) OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and  u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' and u.UPE_id__r.UEP_isActive__c=true and  (u.UPE_id__r.Status__c='Mobile and Portal Access' OR u.UPE_id__r.Status__c='Active') ) Or (UPE_id__r.User_id__c=:userInfo.getUserId()  and u.UPE_id__r.UEP_isActive__c=true and  (u.UPE_id__r.Status__c='Mobile and Portal Access' OR u.UPE_id__r.Status__c!='Active')) ];  
      
      system.debug('YYYYYYYYYYYYYYYYYYYYYYY '+bvsvalues );
      integer recCount =0;
       
      for(User_Event_BVS__c valuesofbvs: bvsvalues ){
       setofboothpersonnelIds.add(valuesofbvs.BVS_id__c);
            
   }
   
   

    
       List<attachment> att = new List<attachment>();
       att =[select id,parentid  from attachment where parentid in:setofboothpersonnelIds];
       
       for(attachment ar:att){
       mapImage.put(ar.parentid,ar.id); 
       }
         
       bvsListBefore = [Select b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c From BoothVisitSummary__c b where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
          
            for(BoothVisitSummary__c yt:bvsListBefore ){
            yt.BVS_FirstName__c =escapeSpecialCharacters(yt.BVS_FirstName__c);
            yt.BVS_LastName__c =escapeSpecialCharacters( yt.BVS_LastName__c);
            yt.BVS_Company__c =escapeSpecialCharacters(yt.BVS_Company__c);
            yt.BVS_LeadCategory__c=escapeSpecialCharacters(yt.BVS_LeadCategory__c);
            yt.BVS_FollowUps__c=escapeSpecialCharacters(yt.BVS_FollowUps__c);
            yt.BVS_Notes__c=escapeSpecialCharacters(yt.BVS_Notes__c);
            try{
            string abd = string.valueOf(yt.ScanTime__c);
           
             yt.ScanTime__c= getLocalDateTime( yt.ScanTime__c);
            }catch (exception e){}
             
           /** if(mapImage.get(yt.id) != null){
            system.debug('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii '+ mapImage); 
            yt.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c  =  mapImage.get(yt.id);     
            } **/
            
            
            if(mapImage.get(yt.id) != null){
             yt.Dummy__c  =  mapImage.get(yt.id);     
            }
       recCount++;
     
       bvsvaluesbefore1.add(yt);
       if(recCount==1000)
      {
            bvsList.add(bvsvaluesbefore1);
            bvsvaluesbefore1 = new LIST<BoothVisitSummary__c >();
            recCount=0;
      } 
      
      
   }
  if(recCount !=0) {       
  bvsList.add(bvsvaluesbefore1);      
     system.debug('11111111111 55555555555555 gg '+bvsList);        
 }
 } 
         else{
         
      set<Id>  setofboothpersonnelIds = new set<Id>();
       bvsList = new List<List<BoothVisitSummary__c>>(); 
       List<User_Event_BVS__c> bvsvalues = new  List<User_Event_BVS__c>(); 
       gg = new BL_SecuritySettingsCon(eventSelected);
         system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  gg'+ gg );  
        
       List<BoothVisitSummary__c > bvsvaluesbefore1 = new  List<BoothVisitSummary__c >(); 
       List<BoothVisitSummary__c > bvsListBefore = new  List<BoothVisitSummary__c >();  
       integer recCount =0;  
      
      bvsvalues =[select BVS_id__c from User_Event_BVS__c u where (u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and  (u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive')) OR (u.UPE_id__r.User_id__r.Email=:userInfo.getUserName() and u.EV_id__c=:eventSelected and u.UPE_id__r.Profile_id__r.PR_Name__c='BoothAdmin' and u.UPE_id__r.UEP_isActive__c=true and  u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') Or (UPE_id__r.User_id__c=:userInfo.getUserId() and u.EV_id__c=:eventSelected and u.UPE_id__r.UEP_isActive__c=true and  u.UPE_id__r.Status__c!='Mobile only access' And u.UPE_id__r.Status__c!='InActive') ];  
       for(User_Event_BVS__c h:bvsvalues){
               setofboothpersonnelIds.add(h.BVS_id__c);
           }
           
            
         List<attachment> att = new List<attachment>();
         
         
         
         att =[select id,parentid  from attachment where parentid in:setofboothpersonnelIds];
         for(attachment ar:att){
         mapImage.put(ar.parentid,ar.id);  
         
         }
         

       bvsListBefore = [Select b.Dummy__c,b.EA_AttendeeBarcode__r.AS_id__r.AS_ImageUrl__c, b.User_id__c, b.User_id__r.Name,b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.LastActivityDate, b.IsDeleted, b.Id, b.EA_AttendeeBarcode__c, b.CreatedDate, b.CreatedById, b.BVS_Title__c, b.BVS_Tags__c, b.BVS_SurveyQuestion4__c, b.BVS_SurveyQuestion3__c, b.BVS_SurveyQuestion2__c, b.BVS_SurveyQuestion1__c, b.BVS_SurveyAnswer4__c, b.BVS_SurveyAnswer3__c, b.BVS_SurveyAnswer2__c, b.BVS_SurveyAnswer1__c, b.BVS_State__c, b.BVS_PhoneNumber__c, b.BVS_Notes__c, b.BVS_LeadType__c, b.BVS_LeadRating__c, b.BVS_LeadCategory__c, b.BVS_LastName__c, b.BVS_FollowUps__c, b.BVS_FirstName__c, b.BVS_Email__c, b.BVS_Company__c, b.BVS_City__c, b.BVS_Budget__c,b.ScanTime__c From BoothVisitSummary__c b where id in :setofboothpersonnelIds and EA_AttendeeBarcode__c!=null order by ScanTime__c DESC ];
   
            for(BoothVisitSummary__c yt:bvsListBefore ){
            yt.BVS_FirstName__c =escapeSpecialCharacters(yt.BVS_FirstName__c);
            yt.BVS_LastName__c =escapeSpecialCharacters( yt.BVS_LastName__c);
            yt.BVS_Company__c =escapeSpecialCharacters(yt.BVS_Company__c);
            yt.BVS_LeadCategory__c=escapeSpecialCharacters(yt.BVS_LeadCategory__c);
            yt.BVS_FollowUps__c=escapeSpecialCharacters(yt.BVS_FollowUps__c);  
            yt.BVS_Notes__c=escapeSpecialCharacters(yt.BVS_Notes__c);   
           
             if(mapImage.get(yt.id) != null){
             yt.Dummy__c  =  mapImage.get(yt.id);     
            }
            
             recCount++;
     
       bvsvaluesbefore1.add(yt);
       if(recCount==1000)
      {
            bvsList.add(bvsvaluesbefore1);
            bvsvaluesbefore1 = new LIST<BoothVisitSummary__c >();
            recCount=0;
      } 
                 
         }  
         if(recCount !=0) {       
  bvsList.add(bvsvaluesbefore1);      
     system.debug('11111111111 55555555555555 gg '+bvsList);        
 }
        }   
    }catch (exception e){}      
      return null;
    }



 


 public List<selectOption> getselectEvents() {
    try{
       List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
       EvntsForPicklist = new List<Event__c>();
       upeForEvents = [Select u.User_id__c,u.Profile_id__r.PR_Name__c,u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where (u.User_id__r.Email=:userInfo.getUserName() ) and (Status__c!='Mobile only access' And Status__c!='InActive') ];
       set<Id> setOfEventIds = new set<Id>();
           for(User_Profile_Event__c rotatinnFor:upeForEvents){
           setOfEventIds.add(rotatinnFor.EV_id__c);
           }
 
       EvntsForPicklist =[select  id,EV_Title__c from Event__c where id in :setOfEventIds order by EV_StartDate__c];
           if(EvntsForPicklist.size()>0){
           defaultEvent =EvntsForPicklist[0].id;
           }
      List<SelectOption> options = new List<SelectOption>();
           options.add(new SelectOption('All','All'));
           for(Event__c Event:EvntsForPicklist ){
           options.add(new SelectOption(Event.id,Event.EV_Title__c));
           }
           return options;
    }catch(exception e){return null;}   
     }
     
     
   
 public PageReference closePopup() {
        BVSDetail =false;
        return null;
    }
  
  
   public static Datetime getLocalDateTime(Datetime z)
    {    
        Datetime l = z.Date();
        l = l.addHours(z.hour());
        l = l.addMinutes(z.minute());
        l = l.addSeconds(z.second());
        
        return l;
    }

   
    
    
public String escapeSpecialCharacters(String input){
    if(input!= null && input != '' && (input.contains('\\') )){
       input = input.replace('\\','\\\\');
       }
       if(input!= null && input != '' && (input.contains('"') )){
       input = input.replace('"','\\\"');
       }
       if(input!= null && input != '' && (input.contains('<') )){
       input = input.replace('<','');
       }
      return input;
    }
    
public string escape(string s){
  if(s != null && s.contains(',')){
     s=s.replaceAll('"','');
     s='"'+s+'"';
   } 
    return s;
 }
    }