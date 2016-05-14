@istest

public class Test_SendAnEmail
{
  static testmethod void Testmethod_SendAnEmail()
  {
  
  
 contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u = new User(alias = 'test123', email='test123send@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123send@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  EventAdminProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',EV_HostingLocation__c='Hitex',EV_HostingStateNew__c='Ap',AS_HostingAddr2__c='Add2',
EV_HistingAddr1__c ='Add1',AS_HostingCity__c='Hyd',EV_EventLogo__c='www.globalnest.com'
);
      insert eve;
      Id EventId=eve.Id;

 Event__c eve1 = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM'
);
      insert eve1;
      Id EventId1=eve1.Id;
      
     
     Booth__c booth1 = new Booth__c(BT_Name__c='TestBooth1',BT_BoothUserCount__c=100);
      insert booth1;
      
      User_Profile_Event__c upebooth = new User_Profile_Event__c(BT_id__c=booth1.Id,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upebooth; 

Profile__c BoothAdminProfile2= new Profile__c (PR_Name__c='Attendee',PR_Version__c='3.0');        
       insert  BoothAdminProfile2;
  Id  profileId2=BoothAdminProfile2.Id;   

  User_Profile_Event__c upebooth2 = new User_Profile_Event__c(BT_id__c=booth1.Id,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=profileId2,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upebooth2; 


      
 //----------------------------- Booth Amin ----------------------------------
  user bAdmin =  new User(alias = 'testboot', email='testboothadmin12@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testboothadmin12@noemail.com',CompanyName='Nest',Title='dev');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
                  
                  
 Profile__c BoothAdminProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
       insert  BoothAdminProfile;
  Id  profileId=BoothAdminProfile.Id;    

Profile__c BoothAdminProfile1= new Profile__c (PR_Name__c='Attendee',PR_Version__c='3.0');        
       insert  BoothAdminProfile1;
  Id  profileId1=BoothAdminProfile1.Id;   
      
      Booth__c booth = new Booth__c(BT_Name__c='TestBooth',BT_BoothUserCount__c=100);
      insert booth;                  
      Id  boothId =booth.id;    
               
      User_Profile_Event__c upe = new User_Profile_Event__c(BT_id__c=boothId,BoothAdmin_id__c=boothAdminId,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,IsBoothPersonnel__c=true,Profile_id__c=profileId,Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true);         
      insert upe;         
          
User_Profile_Event__c upe1 = new User_Profile_Event__c(BT_id__c=boothId,BoothAdmin_id__c=boothAdminId,EV_id__c=EventId1,EventAdmin_Id__c=eventAdminId,IsBoothPersonnel__c=true,Profile_id__c=profileId,Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true);         
      insert upe1;   
      
 User_Profile_Event__c upe2 = new User_Profile_Event__c(BT_id__c=boothId,BoothAdmin_id__c=boothAdminId,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,IsBoothPersonnel__c=true,Profile_id__c=profileId1,Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true);         
      insert upe2;     
     
   //------------------------------ booth personnel -------------------------------
   
   user bu1 =  new User(alias = 'buser', email='busersend@badmin.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='busersend@badmin.com',CompanyName='Nest',Title='dev');
                  insert bu1;
                                
                  
 Profile__c customProfilebu1= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
  insert  customProfilebu1;
       
       Profile__c BoothPersonnelProfile= new Profile__c (PR_Name__c='BoothPersonnel',PR_Version__c='3.0');        
  insert  BoothPersonnelProfile;
     
    Event__c evebu1 = new Event__c(EV_Title__c='Global evebu1 ',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM',EV_HostingLocation__c='Hitex',EV_HostingStateNew__c='Ap',AS_HostingAddr2__c='Add2',
EV_HistingAddr1__c ='Add1',AS_HostingCity__c='Hyd',EV_EventLogo__c='www.globalnest.com');
      insert evebu1 ;

Event__c evebu2 = new Event__c(EV_Title__c='Global evebu1 ',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert evebu2 ;
      
    User_Profile_Event__c upebu1 = new User_Profile_Event__c(EV_id__c=evebu1.Id,Profile_id__c=BoothPersonnelProfile.Id,Status__c='Active',User_id__c=bu1.Id,UEP_isActive__c=true);         
      insert upebu1 ; 

User_Profile_Event__c upebu2 = new User_Profile_Event__c(EV_id__c=evebu2.Id,Profile_id__c=BoothPersonnelProfile.Id,Status__c='Active',User_id__c=bu1.Id,UEP_isActive__c=true);         
      insert upebu2 ; 
   
    AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='busersend@badmin.com');
     insert attSummarybp;
   
   
  system.runAs(bAdmin){
  } 
   system.runAs(u){
  }
  system.runAs(bu1){
  }

   
  }
  }