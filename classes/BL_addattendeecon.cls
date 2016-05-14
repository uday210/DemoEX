public with sharing class BL_addattendeecon {

public List<AttendeeSummary__c> listOfattForInsertList {get;set;}
public string error{get;set;}
public event__c event{get;set;}
public id ticketId {get;set;}
public id eventId{get;set;}
public boolean displayadd { get; set; }
public String selectedValue { get; set; }
public List<selectOption> options{get;set;}
public decimal availableAttendees{get;set;}
public decimal availableAdmins{get;set;}
public List<Dummay__c> dummay {get;set;}
public List<inncls> listofattendees {get;set;}
public integer inte{get;set;}
public decimal remainingAttendees{get;set;}
PUBLIC string dummyid{get;set;}
 public List<AttendeeSummary__c> alreadyInsertedAttendeeList{get;set;}
 

   

public BL_addattendeecon(){
dummyid=Apexpages.currentpage().getParameters().get('id');
values();
}


public decimal totalatt{get;set;}
public void values(){

options = new List<selectOption>();
 dummay = new List<Dummay__c>();
 dummay = [select id,First_Name__c,TicketTypes__c,TicketTypes__r.No_of_Attendees_allowed__c,TicketTypes__r.TT_Name__c,Event__c,Event__r.id,TicketTypes__r.id,Last_Name__c,Attendees_Available__c,Booth_admins_available__c,email__c from Dummay__c where id=:dummyid limit 1];

 totalatt =dummay[0].TicketTypes__r.No_of_Attendees_allowed__c;
  system.debug('YYYYYYYYYYYYYYYYYYYY '+totalatt );
 listofattendees  = new List<inncls>();
 
  if(dummay.size()>0){
  ticketId =dummay[0].TicketTypes__r.id;
  eventId =dummay[0].Event__r.id;
  
  alreadyInsertedAttendeeList = new List<AttendeeSummary__c>();
  alreadyInsertedAttendeeList  =[select AS_Email__c,AS_FirstName__c,AS_LastName__c, AS_Company__c,AS_ShippingPhone__c from AttendeeSummary__c where AddedBy__c=:dummay[0].email__c OR AS_Email__c=:dummay[0].email__c];
  
  
  
   event = [SELECT id,EV_Description__c,EV_EndDate__c,EV_EndTime__c,EV_HistingAddr1__c,EventDiversityValues__c,
                        EV_HostedByEventBrite__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingCountryNew__c,EV_HostingFax__c,
                        EV_HostingLocation__c,EV_HostingOrgName__c,EV_HostingPhone__c,EV_HostingPostalCode__c,EV_HostingStateNew__c,
                        EV_HostingTimeZone__c,EV_HostingZipcode__c,Primary__c,SecondaryCategory__c,EV_StartDate__c,StartTime__c,Status__c,
                        EV_Title__c,EV_WebsiteURL__c,EV_EventLogo__c,EV_ContactURL__c,EV_HostingCountry__c , 
                        EV_Publish__c,EV_SiteLocation__c, EV_IncludedFields__c, EV_QuickReg__c, EV_RedirectURI__c, Ev_RequiredFields__c,
                        Paypal_Email__c,Paypal_Username__c,Paypal_Password__c,Signature__c
                           FROM Event__c WHERE id =: eventId ];
       
  
   availableAttendees =dummay[0].Attendees_Available__c;
   remainingAttendees =availableAttendees;
   availableAdmins=dummay[0].Booth_admins_available__c;
  
   if(dummay[0].Attendees_Available__c>0){
     inte =0;
     DisplayAttendees();
   }
 }
 
}

MAP<integer,inncls> innMap = new MAP<integer,inncls>();




public PageReference DisplayAttendees() {
 displayadd =true;
AttendeeSummary__c att = new AttendeeSummary__c();
   innMap.put(inte,(new inncls(inte,att)));   
  //system.debug(' 11111111111 '+fieldvalue +' 222222222222 '+innMap.get(fieldvalue)+' 555555555555555 '+innMap.size()); 
  listofattendees = new List<inncls>();
   listofattendees.addAll(innMap.values());
   
   inte++;
    remainingAttendees =remainingAttendees-1;
   
   if(remainingAttendees ==0){
       displayadd =false;
   }  
  
   return null;
    }


public PageReference deleteRow() {

    integer fieldvalue =integer.valueOf(Apexpages.currentpage().getParameters().get('fileldName'));
    system.debug(' 11111111111 '+fieldvalue +' 222222222222 '+innMap.get(fieldvalue)+' 555555555555555 '+innMap.size()); 
    innMap.Remove(fieldvalue);
    system.debug(' 3333333333333333 '+fieldvalue +' 44444444444'+innMap.size()); 
    //listofattendees.addAll(innMap.values());     
   listofattendees = new List<inncls>();
   listofattendees.addAll(innMap.values());
   remainingAttendees =remainingAttendees +1;
    if(remainingAttendees !=0){
       displayadd =true;
   }  
   
   
     return null;
    }

 public PageReference saveAttandee() {
    try{
     MAP<string,id> mapEamAndEmail = new MAP<string,id>();
     SET<AttendeeSummary__c> listOfattForInsert = new  SET<AttendeeSummary__c>();
      listOfattForInsertList = new List<AttendeeSummary__c>();
      Set<string> setofEmails= new Set<string>();
      MAP<string,id> mapBoothwithName = new MAP<string,id>();
      LIST<User_Profile_Event__c> newUPEtoInsert = new LIST<User_Profile_Event__c>();
      LIST<Profile__c> profileAtt = new LIST<Profile__c>();
      error ='';
      SET<Booth__c>  booths = new SET<Booth__c >();
      //  MAP<string,id> mapBoothwithName = new MAP<string,id>();
      
     for(inncls inn:listofattendees){
       inn.innAtt.AddedBy__c= dummay[0].email__c;
        if(setofEmails.contains(inn.innAtt.AS_Email__c)){
           error ='Duplicate found';
           return null;
        }else{
          setofEmails.add(inn.innAtt.AS_Email__c) ;
          listOfattForInsertList.add(inn.innAtt);
          
         Booth__c b =new Booth__c();
         b.BT_Name__c =inn.innAtt.AS_Company__c;
         b.EV_id__c =EventId;
         b.BT_ContactEmail__c = inn.innAtt.AS_Email__c;
         booths.add(b);
                   
         }
     }
      
      
      
    for(Ticket_Eam__c tic :[select id,Event_Attendee_Mapping__c,Event_Attendee_Mapping__r.AS_id__r.AS_Email__c,TicketTypes__c from Ticket_Eam__c where TicketTypes__c=:ticketId and Event_Attendee_Mapping__r.EV_id__c=:eventId ]){
      if(setofEmails.contains(tic.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c)){
        error = 'We already have this '+tic.Event_Attendee_Mapping__r.AS_id__r.AS_Email__c + 'email registered with this ticket type';
        return null;       
      }    
    }   
    
       Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
       dataBase.upsertResult[] upResult = dataBase.upsert(listOfattForInsertList,f,false);  // inserting attendee
  
      
      set<Id> insertedRecords = new set<Id>();
      for(dataBase.upsertResult up:upResult ){
        if(up.isSuccess()){
        insertedRecords.add(up.getId()); 
        }
      }
      
     // inserting attendees
     
      List<Event_Attendee_Mapping__c> EAMListforInsert12 = new List<Event_Attendee_Mapping__c>();
      
        for(AttendeeSummary__c singleatt :[select id,AS_Email__c from AttendeeSummary__c where id In :insertedRecords]){
        Event_Attendee_Mapping__c  EAM = new Event_Attendee_Mapping__c();      
        EAM.AS_id__c =singleatt.id;
        EAM.EV_id__c =eventId ;
         EAM.paid__c = true;
        EAM.Attendee_Event_IDs__c =singleatt.id+''+eventId ;
        EAMListforInsert12.add(EAM);
       }
       
       dataBase.Insert(EAMListforInsert12,false); 
     
      
       for(Event_Attendee_Mapping__c eam:[Select id,AS_id__r.AS_Email__c from Event_Attendee_Mapping__c  where AS_id__r.AS_Email__c IN : setofEmails and EV_id__c=:eventId]){
       mapEamAndEmail.put(eam.AS_id__r.AS_Email__c,eam.id);       
     }
      
      
      
       // INSERT   booth 
      List<Id> boothIds = new List<Id>();
        List<Booth__c>  booths1 = new List<Booth__c >();
        booths1.addAll(booths);
       dataBase.saveResult[] saveResult = dataBase.insert(booths1);
       
     for( dataBase.saveResult sresult:saveResult){
      if(sresult.isSuccess()){
        boothIds.add(sresult.getId());
      }  
    }
    
  
    for(Booth__c boothvalues :[SELECT id,BT_Name__c,BT_ContactEmail__c from Booth__c where Id IN :boothIds]){
    mapBoothwithName.put(boothvalues.BT_ContactEmail__c,boothvalues.id);
    }
    // ----------------------------------- end ---------------------------------------------
      
       
       // Inserting EAM for created attendees     
        List<Ticket_Eam__c> EAMListforInsert = new List<Ticket_Eam__c>();
        for(string dumiterate:setofEmails){
        Ticket_Eam__c tEam = new Ticket_Eam__c();
        tEam.Event_Attendee_Mapping__c =mapEamAndEmail.get(dumiterate);
         tEam.TicketTypes__c =ticketId;
         EAMListforInsert.add(tEam);
       }
      dataBase.Insert(EAMListforInsert,false);
      
       // INSERT  UPE For attandees  Start
      
       List<user> userList=[select id,userName from user where userName IN :setofEmails];
       
      List<User_Profile_Event__c> lupe=[Select id,User_id__c  from User_Profile_Event__c 
                                     Where User_id__r.userName IN: setofEmails
                                     And EV_id__c=:eventid]; 
   
     MAP<Id, User_Profile_Event__c> upeMap = new MAP<id, User_Profile_Event__c>();
     for(User_Profile_Event__c u: lupe){
       upeMap.put(u.User_id__c , u);
    }
          
   
   profileAtt =[select id from Profile__c where PR_Name__c='Attendee'];
   
    for(USER uu:userList)  {                               
      User_Profile_Event__c singleUPE = new User_Profile_Event__c();
       if(upeMap.containsKey(uu.id)){
       
         }else{
             singleUPE.User_id__c = uu.id;
             singleUPE.EV_id__c = eventid;
             singleUPE.BT_id__c    = mapBoothwithName.get(uu.userName); 
             singleUPE.Profile_id__c   =profileAtt[0].id;   
             singleUPE.status__c ='Active';               
             newUPEtoInsert.add(singleUPE); 
        }                                   
   
    }     
     dataBase.insert(newUPEtoInsert,false);
     // INSERT  UPE For attandees    End
     
    dummay[0].Attendees_Available__c =dummay[0].Attendees_Available__c-inte;
    
    dataBase.update(dummay,false);
          
    pageReference pg = new PageReference('/apex/BL_addattendees?id='+dummyid);
    pg.setRedirect(true); 
    return pg;
    }catch(exception e){return null;}
    }



// Inner class

public class inncls{
public integer innInt{get;set;}
public AttendeeSummary__c innAtt{get;set;}
public inncls(integer e,AttendeeSummary__c ar){
this.innInt =e;
this.innAtt =ar;
}

}






}