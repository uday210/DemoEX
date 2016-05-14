@RestResource(urlMapping='/RegisterAttendee/*')

 global without sharing class RegisterAttendee{
 
  
  
  @HttpGet
  global static inncls doGet(){
//  try{
  RestRequest req = RestContext.request;
  RestResponse res = RestContext.response;
  system.debug('22222222 5555555555555555'+res  );
   
  string fName= req.params.get('FirstName');
  string lName=req.params.get('LastName');
  string email=req.params.get('Email');
  string company=req.params.get('Company');
  string phone=req.Headers.get('Phone');
  string title=req.params.get('Title');
  string actionType=req.params.get('Action');
  
  system.debug('22222222 44444444444444444'+title);
   
  string eventId =req.params.get('EventId').trim();
     
  AttendeeSummary__c myatt = new AttendeeSummary__c();
  myatt.AS_FirstName__c =fName;
  myatt.AS_LastName__c =lName;
  myatt.AS_Email__c =email;
  myatt.AS_Company__c =company;
  myatt.AS_WorkPhone__c =phone;
  myatt.AS_Title__c =title;
  
  Database.UpsertResult myAttendeeSaveResult = Database.upsert(myatt,AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);
  system.debug('1111111111 '+myAttendeeSaveResult);
  
  Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
  Event_Attendee_Mapping__c eam1= new Event_Attendee_Mapping__c();
 
 id eamid;
  if(myAttendeeSaveResult.isSuccess() )
     {
     if(myAttendeeSaveResult.iscreated())
     {
      eam.AS_id__c = myAttendeeSaveResult.getId(); 
      eam.Ev_id__c = eventId;   
      eam.Attendee_Source__c = 'Walk Ins';   
       system.debug('22222222 '+myAttendeeSaveResult+'33333333333 '+eventId);
       Database.SaveResult myAttendeeJunction = Database.Insert(eam,false);  
       
      Event_Attendee_Mapping__c eamvalue = new Event_Attendee_Mapping__c();
      eamvalue =[select Attendee_Event_IDs__c,EA_AttendeeBarcode__c  from Event_Attendee_Mapping__c where id=:myAttendeeJunction.getId()];      
          
                 
        eamvalue.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ eventId;
        eamvalue.EA_AttendeeBarcode__c = myAttendeeJunction.getId()+'-'+eventId;
        dataBase.saveResult resresult = dataBase.update(eamvalue,false);
       
       system.debug('-------------------------resresult ------------------' + resresult );
      if(resresult.isSuccess()){
         eamid=resresult.getId();
      }
      system.debug('--------------junction ----------------'+myAttendeeJunction.getId());
         
      }else{
      system.debug('============================');
      integer ev_att_Jun=[select count() from  Event_Attendee_Mapping__c 
                                             where  AS_id__r.id =: myAttendeeSaveResult.getId() and
                                             Ev_id__c   =: eventId];
     system.debug('============================'+ev_att_Jun);
    
     if(ev_att_Jun==0){
      eam = new Event_Attendee_Mapping__c();
      eam.AS_id__c = myAttendeeSaveResult.getId(); 
      eam.Ev_id__c = eventId;
      eam.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ eventId;
      Database.SaveResult myAttendeeJunction = Database.Insert(eam,false);
      system.debug('-------------------------myAttendeeJunction------------------' + myAttendeeJunction);
      
      Event_Attendee_Mapping__c eamvalue = new Event_Attendee_Mapping__c();
      eamvalue =[select Attendee_Event_IDs__c,EA_AttendeeBarcode__c  from Event_Attendee_Mapping__c where id=:myAttendeeJunction.getId()];      
            
      eamvalue.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ eventId;
      eamvalue.EA_AttendeeBarcode__c = myAttendeeJunction .getId()+'-'+eventId;
      dataBase.saveResult resresult =  dataBase.update(eamvalue,false);
      system.debug('-------------------------resresult ------------------' + resresult );
      
      
      if(resresult.isSuccess()){
         eamid=resresult.getId();
      }
      
      user use = new user();
             try {
                 use = [select id from User where Username = : myatt.AS_Email__c];
             } catch (exception e) {}
           
             system.debug('-------------------------new attendee------------------' + use.id);
             Profile__c profil = [select id, Name from Profile__c where PR_Name__c = : 'Attendee'];
             User_Profile_Event__c uperec = new User_Profile_Event__c();
             if (use.id != null) {
                 uperec.EV_id__c = eventId;
                 uperec.UEP_isActive__c = true;
                 uperec.User_id__c = use.id;
                 uperec.Profile_id__c = profil.id;
                 uperec.EventAdmin_Id__c=UserInfo.getUserId();
                 insert uperec;
             }
      }  else{
      
      Event_Attendee_Mapping__c  ev_att_Jun1=[select EA_AttendeeBarcode__c from  Event_Attendee_Mapping__c 
                                             where  AS_id__r.id =: myAttendeeSaveResult.getId() and
                                             Ev_id__c   =: eventId];
      
       eamid=ev_att_Jun1.id;
          
      
      }
    
   }
   
 }  
   
   
    system.debug('-------------------------phani ------------------' + eamid);
  inncls inn;
  //if(actionType=='Save'){ 
   eam1=[select AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Email__c,AS_id__r.AS_Title__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,EA_isBadgePrinted__c,TicketTypes__c, EA_AttendeeBarcode__c from Event_Attendee_Mapping__c
                                 where id =: eamid];
    inn = new inncls(eam1); 
  //} else if(actionType=='Print'){
       
   inn = new inncls(eam1); 
 
 
//  }   
  return inn ;  
 // }catch(exception e){return null;}
 }
 
 global class inncls{
  string Badgebarcode ;
  string FirstName;
  string LastName;
  string Email;
  string Phone;
  string Title;
  string Company;
  
  public inncls(Event_Attendee_Mapping__c evalue){
  FirstName =evalue.AS_id__r.AS_FirstName__c;
  LastName=evalue.AS_id__r.AS_LastName__c;
  Email=evalue.AS_id__r.AS_Email__c;
  Phone=evalue.AS_id__r.AS_WorkPhone__c;
  Title=evalue.AS_id__r.AS_Title__c;
  Company =evalue.AS_id__r.AS_Company__c;
  Badgebarcode =evalue.EA_AttendeeBarcode__c;
 
 
  }
 }
 
 
}