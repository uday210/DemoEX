public without sharing class BL_MatchMakingApproveCon {

  public MAP<id,User_Profile_Event__c> mapUpeandItsId{get;set;}
   public MAP<id,User_Profile_Event__c> mapUpeandItsIdstatus{get;set;}
  public List<User_Profile_Event__c> upes{get;set;}
  public string selectedEvent{get;set;}
 


    public PageReference ChangeStatus() {
    string changevalue=Apexpages.currentPage().getPArameters().get('changevalue');
    dataBase.update(mapUpeandItsIdstatus.get(changevalue),false);
    return null;
   }


 public BL_MatchMakingApproveCon(){
   firstMethod();
 
 }
 
 public List<User_Profile_Event__c> usersListforchangeStatus {get;set;} 
 
 
  public void firstMethod(){
   selectedEvent =Apexpages.currentPage().getPArameters().get('id');
   mapUpeandItsIdstatus = new MAP<id,User_Profile_Event__c>();
   usersListforchangeStatus =new List<User_Profile_Event__c>();
   usersListforchangeStatus =[select id,Status__c,IsMatchMakingUser__c,MAtchMakingProfile__c,EV_id__c,User_id__c,BoothAdmin_id__c,User_id__r.id,Request_for_upgrade_profile__c,User_id__r.Name,User_id__r.UserName,User_id__r.email,Attendee_Summary__r.AS_Company__c from User_Profile_Event__c where EV_id__c=:selectedEvent and IsMatchMakingUser__c=true];
     for(User_Profile_Event__c upstatus :usersListforchangeStatus ){
      mapUpeandItsIdstatus.put(upstatus.id,upstatus);
    } 
    
    
   
    upes = new List<User_Profile_Event__c>();
    mapUpeandItsId = new MAP<id,User_Profile_Event__c>();
    upes =[select id,IsMatchMakingUser__c,MAtchMakingProfile__c,EV_id__c,User_id__c,BoothAdmin_id__c,User_id__r.id,Request_for_upgrade_profile__c,User_id__r.Name,User_id__r.UserName,User_id__r.email,Attendee_Summary__r.AS_Company__c from User_Profile_Event__c where EV_id__c=:selectedEvent and Request_for_upgrade_profile__c=true];
    for(User_Profile_Event__c up :upes){
      mapUpeandItsId.put(up.id,up);
    }
  }
 
 
    public PageReference acceptRequest() {
     
     string req =ApexPages.currentpage().getParameters().get('accept');
     
     if(req.contains('acc')){
          string[] str=req.split('-');
          system.debug('22222222222222 '+str);
          
          
         
          User_Profile_Event__c getUpe = new User_Profile_Event__c();
         
          getUpe= mapUpeandItsId.get(str[0]);
          getUpe.Request_for_upgrade_profile__c =false;
          getUpe.BoothAdmin_id__c =getUpe.User_id__r.id;
          dataBase.update(getUpe,false);
          
         /* Event_Attendee_Mapping__c Eam = new Event_Attendee_Mapping__c();
          Eam =[select id,Boothleads_Profile__c from Event_Attendee_Mapping__c  where EV_id__c=:selectedEvent and AS_id__r.AS_Email__C=:getUpe.User_id__r.userName];
          Eam.Boothleads_Profile__c ='Booth Admin'; 
          dataBase.update(eam,false);*/
          
           EmailTemplate E = new EmailTemplate(); 
           E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Corporate Signup Approval Email'];     
                             list <Messaging.SingleEmailMessage> emails = new List < Messaging.SingleEmailMessage > ();
                             Messaging.SingleEmailMessage emailsend = new Messaging.SingleEmailMessage();
                             OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Jerilynn Clarke'];
                                 if(owea.size() > 0 ) {
                                          emailsend.setOrgWideEmailAddressId(owea.get(0).Id);
                                 } 
                          String[] toaddress = new String[] {
                          getUpe.User_id__r.Email
                          };
                          emailsend.setToAddresses(toaddress);   
                          String subject = E.Subject;
                          String ReplaceContactName = E.HtmlValue;
                          String replacedname = ReplaceContactName.Replace('{!Name}',getUpe.User_id__r.name);          
                          String replacedname1 = replacedname.Replace('{!Email}',getUpe.User_id__r.UserName);                  
                          emailsend.setSubject(subject);    
                          emailsend.setHtmlBody(replacedname1); 
                          emails.add(emailsend);     
                          Messaging.SendEmailResult[] r = Messaging.sendEmail(emails);
          
          
        /**  
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         String[] toAddresses = new String[] {getUpe.User_id__r.userName};
         mail.setToAddresses(toAddresses);
         mail.setHtmlBody('Hi');
         mail.setSubject('Congratulations your request is accepted');
         mail.setUseSignature(false);
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
          */
          
     }else if(req.contains('rej')){
          string[] str=req.split('-');
         User_Profile_Event__c getUpe = new User_Profile_Event__c();
          getUpe= mapUpeandItsId.get(str[0]);
          getUpe.MAtchMakingProfile__c='MBE';
          getUpe.Request_for_upgrade_profile__c =false;
          dataBase.update(getUpe,false);
          
           
            EmailTemplate E = new EmailTemplate(); 
           E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Corporate Reject Signup Email'];     
                             list <Messaging.SingleEmailMessage> emails = new List < Messaging.SingleEmailMessage > ();
                             Messaging.SingleEmailMessage emailsend = new Messaging.SingleEmailMessage();
                             OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Jerilynn Clarke'];
                                 if(owea.size() > 0 ) {
                                          emailsend.setOrgWideEmailAddressId(owea.get(0).Id);
                                 } 
                          String[] toaddress = new String[] {
                          getUpe.User_id__r.Email
                          };
                          emailsend.setToAddresses(toaddress);   
                          String subject = E.Subject;
                          String ReplaceContactName = E.HtmlValue;
                          String replacedname = ReplaceContactName.Replace('{!Name}',getUpe.User_id__r.name);          
                          String replacedname1 = replacedname.Replace('{!Email}',getUpe.User_id__r.UserName);                         
                          emailsend.setSubject(subject);    
                          emailsend.setHtmlBody(replacedname1); 
                          emails.add(emailsend);     
                          Messaging.SendEmailResult[] r = Messaging.sendEmail(emails);
          
          
           
           /**
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         String[] toAddresses = new String[] {getUpe.User_id__r.userName};
         mail.setToAddresses(toAddresses);
         mail.setHtmlBody('Hi');
         mail.setSubject('your request is Rejected');
         mail.setUseSignature(false);
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                   
          */
          
          
     }
     firstMethod();
     return null;
   }


}