@istest

public class Test_BL_BA_ChartsCon
{
  static testmethod void Testmethod_BL_BA_ChartsCon()
  {
  contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u = new User(alias = 'test123', email='test19123@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test19123@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  EventAdminProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
      
     
     Booth__c booth1 = new Booth__c(BT_Name__c='TestBooth1',BT_BoothUserCount__c=100);
      insert booth1;
      
      User_Profile_Event__c upebooth = new User_Profile_Event__c(BT_id__c=booth1.Id,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upebooth; 
      
 //----------------------------- Booth Amin ----------------------------------
  user bAdmin =  new User(alias = 'testboot', email='testboothadmin@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com',CompanyName='Nest',Title='dev');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
                  
                  
 Profile__c BoothAdminProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
       insert  BoothAdminProfile;
  Id  profileId=BoothAdminProfile.Id;     
      
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
     
      BoothVisitSummary__c bvs=new BoothVisitSummary__c(ScanTime__c=datetime.valueOf('2013-05-05 00:00:00'),User_id__c=bAdmin.id,BVS_Email__c='manasa@gmail.com',EA_AttendeeBarcode__c=event_att_map.id);
      insert bvs;
             
     
     Event_Attendee_Mapping__c getEvent_att_map = new Event_Attendee_Mapping__c ();
     getEvent_att_map  =[select id,Attendee_Event_IDs__c,EV_id__c,AS_id__c from Event_Attendee_Mapping__c  where Id=:event_att_map.Id];
     
     getEvent_att_map.EA_AttendeeBarcode__c =string.valueOf(event_att_map.Id)+'-'+string.valueOf(EventId);            
     update getEvent_att_map  ;          
     system.debug('----------------------- '+event_att_map);
      
      User_Event_BVS__c ueb=new User_Event_BVS__c(BVS_id__c=bvs.id,EV_id__c=EventId,UPE_id__c=upe.id);
      insert ueb;
     
   //------------------------------ booth personnel -------------------------------
   
   user bu1 =  new User(alias = 'buser', email='buser@badmin.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='buser@badmin.com',CompanyName='Nest',Title='dev');
                  insert bu1;
                                
                  
 Profile__c customProfilebu1= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
  insert  customProfilebu1;
       
       Profile__c BoothPersonnelProfile= new Profile__c (PR_Name__c='BoothPersonnel',PR_Version__c='3.0');        
  insert  BoothPersonnelProfile;
     
    Event__c evebu1 = new Event__c(EV_Title__c='Global evebu1 ',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert evebu1 ;
      
    User_Profile_Event__c upebu1 = new User_Profile_Event__c(EV_id__c=evebu1.Id,Profile_id__c=BoothPersonnelProfile.Id,Status__c='Active',User_id__c=bu1.Id,UEP_isActive__c=true);         
      insert upebu1 ; 
   
    AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='buser@badmin.com');
     insert attSummarybp;
  
  
  //User_Event_BVS__c UEBVS= new User_Event_BVS__c (BVS_id__c=);
  
  system.runas(bAdmin)
  {
  BL_BA_ChartsCon dashboard = new BL_BA_ChartsCon();
  dashboard.ChartDisplay();
  dashboard.login();
  dashboard.getEvents();
  dashboard.GeographyReport();
  dashboard.IndustryReport();
  dashboard.LeadRatingReport();
  dashboard.BoothAdminScanReport();
  dashboard.pickdate();
  dashboard.HourlyScanReport();
  dashboard.getBoothusers();
  dashboard.getInactiveboothusers();
  dashboard.getMobileboothusers();
  dashboard.getMpboothusers();
  dashboard.getScannedusers(); 
  dashboard.getMobileusers(); 
  dashboard.getBlackberryMobileusers(); 
  dashboard.getApplemobileusers();
  
  pageReference pg = Page.bl_eventadmin_events;
  Test.setCurrentPage(pg);
   
  List<BL_BA_ChartsCon.PieData> InnerClassInstance = dashboard.grpy;
  List<BL_BA_ChartsCon.PieDataForLeadRating> InnerClass = dashboard.LeadRating;
  List<BL_BA_ChartsCon.PieDataForScans > InnerInstance = dashboard.Scans;
  }
  }
  }