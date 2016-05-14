public without sharing class BL_Add_ExhibitorStaffCon {


public MAP<string,id> mapEmailUpe{get;set;}
public MAP<string,Id> mapboothwithId{get;set;}
public List<inncls> inn{get;set;}
public MAP<string,AttendeeSummary__c> attendeeEmails{get;set;}
public MAP<string,id> mapEmailUser{get;set;}



  public PageReference save() {
  mapEmailUser = new MAP<string,id>();
  
  Profile__c pro = new Profile__c();
  pro =[SELECT id from Profile__c where PR_Name__c='BoothPersonnel'];
  SET<string> existedUsers = new SET<string>();
  
  
  for(inncls insertUpe:inn){
   if(insertUpe.selectedvalue!='Select'){
    existedUsers.add(insertUpe.attInn.AS_Email__c);
    }
  }
  
  
  system.debug('AAAAAAAAAAAAAAAA '+existedUsers);
  
  for(user u:[SELECT userName from user where userNAme in :attendeeEmails.keySet() ]){
   existedUsers.Remove(u.userName); 
  }
   system.debug('BBBBBBBBBBBBBBBBBBBBB '+existedUsers);
  
   MAP<string,id> mapContact = new MAP<string,id>();
   List<contact> conList = new List<contact>(); 
   
   
  for(string Emails:existedUsers ){
     AttendeeSummary__c attsum = new AttendeeSummary__c();
     attsum = attendeeEmails.get(Emails);
     
       contact con = new contact();
      con.FirstName =attsum.AS_FirstName__c;
      con.lastName= attsum.AS_LastName__c;
      con.Email =attsum.AS_Email__c;
     Con.AccountId='001F000000rVD6z';
       //Con.AccountId='001Z000000envo4';
      conList.add(Con);
  }
  
  database.Saveresult[] conSaveres = database.insert(conList,false);
     
    for(contact co:conList){
     mapContact.put(co.email,co.id);
    } 
  
  //Profile
  
  List<profile> profileList = new  List<profile>(); 
  profileList =[select id from profile where name='Attendee'];
  
  
  LIST<USER> InserteduserList =new  LIST<USER>();
  for(string Emails1:existedUsers ){
     AttendeeSummary__c atts= new AttendeeSummary__c();
     atts= attendeeEmails.get(Emails1);
    
    user u = new user(); 
    u.FirstName =atts.AS_FirstName__c;
    u.LastNAme =atts.AS_LastName__c;
    u.CompanyName =atts.AS_Company__c;
    u.email =atts.AS_Email__c;
    u.userName=atts.AS_Email__c;
    u.Company_website__c=atts.AS_WebsiteUrl__c;
    u.CompanyAddr1__c=atts.AS_WorkAddress1__c;
    u.CompanyAddr2__c=atts.AS_WorkAddress2__c;
    u.CompanyCity__c=atts.AS_WorkCity__c;
    u.Country__c =atts.AS_Work_Country__c;
    u.CompanyFaxNumber__c=atts.AS_FaxNumber__c;
    u.Companyphone__c =atts.AS_WorkPhone__c;
    u.States__c  =atts.AS_Work_States__c;
    u.contactId=mapContact.get(u.email);
    u.Alias ='BAdmin';
    u.ProfileID =profileList[0].id;
    u.isActive =false;
    u.LocaleSidKey ='en_US';
    u.LanguageLocaleKey ='en_US';
    u.TimeZoneSidKey ='America/Los_Angeles';
    u.EmailEncodingKey='UTF-8';
    InserteduserList.add(u);
  }
  Database.saveResult[] MySaveResultUser =dataBase.insert(InserteduserList,false);  
  
  for(user u1:[SELECT userName,id from user where userNAme in :attendeeEmails.keySet() ]){
   mapEmailUser.put(u1.userName,u1.id); 
  }
     

List<User_Profile_Event__c> UPEList = new List<User_Profile_Event__c>();
 for(inncls insertUpe:inn){
   if(insertUpe.selectedvalue!='Select'){
    User_Profile_Event__c upe = new User_Profile_Event__c();
     
     upe.BT_id__c =mapboothwithId.get(insertUpe.selectedvalue);
     upe.EV_id__c =eventId;
     upe.User_id__c= mapEmailUser.get(insertUpe.attInn.AS_Email__c);
     upe.BoothAdmin_id__c =mapEmailUpe.get(insertUpe.selectedvalue);
     upe.status__c ='Active';
     upe.EventAdmin_Id__c=userInfo.getuserId();
     upe.UEP_isActive__c=TRUE;
     upe.Profile_id__c =pro.id;
     UPEList.add(upe);
   
   }
 

 }
  dataBase.saveREsult[] saveres = dataBase.insert(UPEList,false);
   system.debug('GGGGGGGGGGGGGGGGGGGG '+saveres );

  
  
  firstMethod();
  
   return null;
 }




public string eventId{get;set;}
public BL_Add_ExhibitorStaffCon(){
eventid =Apexpages.Currentpage().getParameters().get('id');
firstMethod();
}
   
   
   public void firstMethod(){
   
inn = new List<inncls>();
mapboothwithId = new MAP<string,Id>();
mapEmailUpe = new MAP<string,id>();
attendeeEmails = new MAP<string,AttendeeSummary__c>();

 
   SET<Id> Exhibitorstaff = new SET<id>();
   SET<Id> Attendees= new SET<id>();
   
   
    for(Ticket_Eam__c ticEam:[SELECT TicketTypes__r.TT_Name__c ,TicketTypes__r.Ticket_Category__c,id,Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__c,Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,Event_Attendee_Mapping__r.AS_id__r.AS_Company__c,Event_Attendee_Mapping__r.AS_id__r.AS_FirstName__c,Event_Attendee_Mapping__r.AS_id__r.AS_LastName__c from Ticket_Eam__c where (TicketTypes__r.Ticket_Category__c='Exhibitor Staff' OR TicketTypes__r.TT_name__c='Exhibitor Staff') and Event_Attendee_Mapping__r.EV_id__c=:eventid]){
     if(ticEam.TicketTypes__r.Ticket_Category__c=='Exhibitor Staff' || ticEam.TicketTypes__r.TT_name__c=='Exhibitor Staff'){
         Exhibitorstaff.add(ticEam.Event_Attendee_Mapping__r.AS_id__c); 
       }else{
    //  Attendees.add(ticEam.Event_Attendee_Mapping__r.AS_id__c);   
      }
    }
     
     for(Event_Attendee_Mapping__c EAM :[SELECT id,Attendee_Types__c,AS_id__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c from Event_Attendee_Mapping__c where EV_id__c=:eventid ]){
          if(EAM.Attendee_Types__c!='Sponsor' && EAM.Attendee_Types__c!='Exhibitor'){  
          if(EAM.Attendee_Types__c=='Exhibitor Staff'){
            Exhibitorstaff.add(EAM.AS_id__c); 
           }else{
            // Attendees.add(EAM.AS_id__c); 
            }
          }
      }
    
    SET<id> totalAtt = new SET<id>();
    totalAtt.addALL(Exhibitorstaff); 
    totalAtt.addALL(Attendees);  
   
    SET<String> Inupe= new SET<string>();
    LIst<SelectOption> selections = new  LIst<SelectOption>();
    selections.add(new SelectOption('Select','Select'));
    
    
   
    for(User_Profile_Event__c UPE :[SELECT id,BT_id__c,BT_id__r.BT_Name__c, User_id__r.id,User_id__r.userName,Profile_id__r.PR_Name__c from User_Profile_Event__c where EV_id__c=:eventid and BT_id__r.BT_ContactEmail__c!=null order By BT_id__r.BT_Name__c ]){
      Inupe.add(UPE.User_id__r.userName);
    
       if(UPE.Profile_id__r.PR_Name__c=='BoothAdmin'){ 
         selections.add(new SelectOption(UPE.BT_id__r.BT_Name__c,UPE.BT_id__r.BT_Name__c));
         mapboothwithId.put(UPE.BT_id__r.BT_Name__c,UPE.BT_id__c);
         mapEmailUpe.put(UPE.BT_id__r.BT_Name__c,UPE.User_id__r.id); 
       }
    }
  
  
  
    for(AttendeeSummary__c att :[SELECT id,AS_Email__c,AS_Company__c,AS_FirstName__c,AS_LastName__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_Work_Country__c,AS_FaxNumber__c,AS_WorkPhone__c,AS_Work_States__c from AttendeeSummary__c where Id IN:totalAtt And AS_Email__c NOT In :Inupe]){
      inn.add(new inncls(att,selections)); 
      attendeeEmails.put(att.AS_Email__c,att);
     }
   
   }
   
   
   
   
   
  
     public class inncls{
         public string selectedvalue{get;set;}
         public  AttendeeSummary__c attInn{get;set;}
         public LIst<SelectOption> options{get;set;}
             public inncls(AttendeeSummary__c a,LIst<SelectOption> opt){
             this.attInn =a;
             this.options =opt;
             
             this.selectedvalue =a.AS_Company__c;
            
             } 
     }
  
  
  
  

}