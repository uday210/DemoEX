@istest

public class Test_BL_BoothPersonnelsCon
{
  static testmethod void Testmethod_BL_BoothPersonnelsCon()
  {
Account Acc=new  Account(Name = 'Booth Leads' );
insert Acc;

contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
           insert m;
       Profile w = [select id from profile where name='Standard User'];
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'test123', email='test123@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test1761@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  customProfileBooth;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;
      
     
     Booth__c booth1 = new Booth__c(BT_Name__c='TestBooth1',BT_BoothUserCount__c=100);
      insert booth1;
      
      User_Profile_Event__c upebooth = new User_Profile_Event__c(BT_id__c=booth1.Id,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upebooth; 
      
 //----------------------------- Booth Amin ----------------------------------
  user bAdmin =  new User(alias = 'testboot', email='testboothadmin@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com',CompanyName='Nest',Title='dev');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
                  
                  
 Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
       insert  customProfile;
  Id  profileId=customProfile.Id;     
      
      Booth__c booth = new Booth__c(BT_Name__c='TestBooth',BT_BoothUserCount__c=100);
      insert booth;                  
      Id  boothId =booth.id;    
               
      User_Profile_Event__c upe = new User_Profile_Event__c(BT_id__c=boothId,BoothAdmin_id__c=boothAdminId,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,IsBoothPersonnel__c=true,Profile_id__c=profileId,Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true);         
      insert upe;         
     
     AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
     insert attSummary;
     string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(EventId);   
     
     Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
     insert event_att_map ;           
     
     Event_Attendee_Mapping__c getEvent_att_map = new Event_Attendee_Mapping__c ();
     getEvent_att_map  =[select id,Attendee_Event_IDs__c,EV_id__c,AS_id__c from Event_Attendee_Mapping__c  where Id=:event_att_map.Id];
     
     getEvent_att_map.EA_AttendeeBarcode__c =string.valueOf(event_att_map.Id)+'-'+string.valueOf(EventId);            
     update getEvent_att_map  ;          
     system.debug('----------------------- '+event_att_map);
      
      
      
     
     BoothVisitSummary__c boothVisitSummary= new BoothVisitSummary__c(BVS_LeadRating__c=4.4,Follow_Update__c=datetime.valueOf('2012-05-15 00:00:00'),ScanTime__c=datetime.valueOf('2012-05-15 00:00:00'),BVS_FirstName__c='Scan',BVS_LastName__c='Me',BVS_Email__c='testboothadmin@noemail.com',EA_AttendeeBarcode__c=getEvent_att_map.Id,User_id__c=bAdmin.Id);
     insert boothVisitSummary;
     
     
     User_Event_BVS__c  use_Eve_BVS = new User_Event_BVS__c(BVS_id__c=boothVisitSummary.Id,EV_id__c=EventId,UPE_id__c=upe.Id);
     insert use_Eve_BVS;
     
     
    SecurityControls__c secControl = new SecurityControls__c(EV_id__c=EventId,EV_Req_Fields__c='AS_FirstName__c',EV_Fields__c='AS_FirstName__c,AS_Company__c,AS_Title__c,AS_CellPhone__c,AS_Age__c,AS_Gender__c,AS_BirthDate__c,AS_HomeAddress1__c,AS_ShippingAddress1__c,AS_WorkAddress1__c,AS_NAICSCode1__c,AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,AS_PrimaryBusinessCategory__c,AS_SecondaryBusinessCategory__c,AS_NumberOfEmployees__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_BusinessDunsNumber__c,AS_WebsiteUrl__c,AS_BlogUrl__c,AS_BusinessDescription__c,AttendeePic'); 
    insert  secControl ;         
   
   //------------------------------ booth personnel -------------------------------
   
   user bu1 =  new User(alias = 'buser', email='buser@badmin.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='buser@badmin.com',CompanyName='Nest',Title='dev');
                  insert bu1;
                                
                  
 Profile__c customProfilebu1= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
  insert  customProfilebu1;
       
       Profile__c customProfilepersonnel= new Profile__c (PR_Name__c='BoothPersonnel',PR_Version__c='1.5');        
  insert  customProfilepersonnel;
     
    Event__c evebu1 = new Event__c(EV_Title__c='Global evebu1 ',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert evebu1 ;
      
    User_Profile_Event__c upebu1 = new User_Profile_Event__c(EV_id__c=evebu1.Id,Profile_id__c=customProfilebu1.Id,Status__c='Active',User_id__c=bu1.Id,UEP_isActive__c=true);         
      insert upebu1 ; 
   
    AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='buser@badmin.com');
     insert attSummarybp;
   
   
   
   
   // --------------------------------  bp ------------------------
   
   user bu2 =  new User(alias = 'busers', email='buser2@badmin.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='buser2@badmin.com',CompanyName='Nest',Title='dev');
                  insert bu2;
                                
                  
 Profile__c customProfilebu2= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
  insert  customProfilebu2;

     
    Event__c evebu2 = new Event__c(EV_Title__c='Global evebu2 ',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert evebu2 ;
     
    Booth__c booth2 = new Booth__c(BT_Name__c='TestBoothup2',BT_BoothUserCount__c=100);
      insert booth2;            
     
      
    User_Profile_Event__c upebu2 = new User_Profile_Event__c(BT_id__c=booth2.Id,EV_id__c=evebu2.Id,Profile_id__c=customProfilebu2.Id,Status__c='Active',User_id__c=bu2.Id,UEP_isActive__c=true);         
      insert upebu2 ; 
   
  
   
   
   
 // ------------------------------- controller Test -----------------   
   
    system.runAs(bAdmin){ 

    BL_BoothPersonnelsCon blattendee = new BL_BoothPersonnelsCon ();
     blattendee.login();
    blattendee.addPersonnels();
    blattendee.getSeletOptions();
    blattendee.closePopup2();
    blattendee.closePopupSelect();
    blattendee.upeFordisplayStatus =upe;
    blattendee.saveLicenceValues();
      
    blattendee.CreateUser.FirstName ='Booth';
     blattendee.CreateUser.LastName ='User';
    blattendee.email ='boothuser@noemail.com';
    blattendee.country ='Active';
    blattendee.eventSelected =EventId;
     blattendee.savePopUpValues();

    blattendee.CreateUser.FirstName ='Booth';
     blattendee.CreateUser.LastName ='User';
    blattendee.email ='boothuser@noemail.com';
    blattendee.country ='Active';
    blattendee.eventSelected =EventId;
     blattendee.savePopUpValues();
      
     blattendee.eventSelected =EventId;
     blattendee.email ='buser@badmin.com';
     blattendee.country ='Active';
     blattendee.savePopUpValues();
   
     blattendee.Last();
    blattendee.Next();
   blattendee.Prev();
   blattendee.First();
   
   
     blattendee.closePopup1();
  
     blattendee.editAttendees();
   
   blattendee.closePopup(); 
     blattendee.getEventDetails();
     blattendee.getItems();
     blattendee.eventName =upebu2.Id;
     blattendee.deleteAdminRecord();
   
  
     blattendee.boothuserstatus();
    blattendee.deleteAdminRecord1();
//blattendee.countrySelect= 'InActive';

  }
 
 
  test.starttest();
   system.runas(u){
    BL_BoothPersonnelsCon blattendee = new BL_BoothPersonnelsCon ();
   
    blattendee.login();
    blattendee.upeFordisplayStatus =upebooth;
    //blattendee.saveLicenceValues();
    blattendee.EditPopUpValues();
     blattendee.closePopup(); 
     blattendee.getEventDetails();
      
    blattendee.Last();
     blattendee.Next();
     blattendee.Prev();
     blattendee.First(); 
     blattendee.boothuserstatus();
    blattendee.deleteAdminRecord1();
     test.stoptest();
   }
 
 }

}