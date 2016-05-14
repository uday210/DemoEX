@istest

public class Test_BL_Add_ExhibitorStaff
{
  static testmethod void Test()
  {
  
  // Inserting booth admin 
 Profile__c pro = new Profile__c(PR_Name__c='BoothPersonnel');
 insert  pro ;
  
  
       Profile w = [select id from profile where name='Standard User'];
  
   user bAdmin =  new User(alias = 'testboot', email='testboothadmin@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com',CompanyName='Nest',Title='dev');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
              
              
            Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;
          
              
              
                  
                  
     Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
       insert  customProfile;
     Id  profileId=customProfile.Id;     
      
      Booth__c booth = new Booth__c(BT_Name__c='TestBooth',BT_BoothUserCount__c=100,BT_ContactName__c='cpk');
      insert booth;                  
      Id  boothId =booth.id;    
               
      User_Profile_Event__c upe = new User_Profile_Event__c(BT_id__c=boothId,BoothAdmin_id__c=boothAdminId,EV_id__c=EventId,IsBoothPersonnel__c=true,Profile_id__c=profileId,Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true);         
      insert upe;         
     
     AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
     insert attSummary;
     string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(EventId);   
     
     Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
     insert event_att_map ;           
  
  
  
   
     TicketTypes__c tic = new TicketTypes__c(EV_id__c=eve.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Exhibitor Staff',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
     insert tic;
  
  // Exhibitore insert 
      AttendeeSummary__c attSummary1 = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin12cv@noemail.com',AS_Company__c='TestBooth');
     insert attSummary1;
     string attendeeEvent1= string.valueOf(attSummary1.Id)+string.valueOf(EventId);   
     
     Event_Attendee_Mapping__c event_att_map1 = new Event_Attendee_Mapping__c(EV_id__c=EventId,AS_id__c=attSummary1.Id,Attendee_Event_IDs__c=attendeeEvent1);
     insert event_att_map1 ;  
  
  
      Ticket_Eam__c ticEam = new Ticket_Eam__c(Event_Attendee_Mapping__c=event_att_map1.id,  TicketTypes__c=tic.id);
     insert ticEam ;
     
     PageReference pageRef = Page.BL_Add_ExhibitorStaff;
     Test.setCurrentPage(pageRef);
     
     Apexpages.Currentpage().getParameters().put('Id',eve.id);
      BL_Add_ExhibitorStaffCon Exb = new BL_Add_ExhibitorStaffCon();
      
     Exb.save();
     
  
  }
  
  
 }