@istest

public class Test_MM_Eventadmin_EventssampleCon
{
  static testmethod void Testmethod_MM_Eventadmin_EventssampleCon ()
  {
    user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
           
             account acc=new account();
            acc.name='Booth Leads';  
            
            acc.ownerid=uname.createdby.id;          
            insert acc;
   contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
    Profile p = [select id from profile where name='System Administrator'];
    User u1 = new User(alias = 'test1236', email='test12367@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test12367@noemail.com');
                  insert u1;
                  Id eventAdminId=u1.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  EventAdminProfile;
       Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,EV_Publish__c =true,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
         AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'test12367@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode1__c = 987654, AS_NAICSCode2__c = 123456, AS_NAICSCode3__c = 898765);
     insert attendee;
     
      User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA; 
    SecurityControls__c secControl = new 

SecurityControls__c(EV_id__c=EventId,EV_Req_Fields__c='AS_FirstName__c',EV_Fields__c='AS_FirstName__c,AS_Company__c,AS_Title__c,AS_CellPhone__c,AS_Age__c,AS_Gender__c,AS_BirthDate__c,AS_HomeAddress1__c,AS_ShippingAddress1__c,AS_WorkAddress1__c,AS_NAICSCode1__c,AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,AS_PrimaryBusinessCategory__c,AS_SecondaryBusinessCategory__c,AS_NumberOfEmployees__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_BusinessDunsNumber__c,AS_WebsiteUrl__c,AS_BlogUrl__c,AS_BusinessDescription__c,AttendeePic'); 
    insert  secControl ;  
     EventSchedule__c es = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', ES_EndDate__c = Date.Parse('01/18/2014'),
                                                ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                ES_Description__c='Hello Test Desc', ES_EndTime__c='09:30 AM', ES_Location__c='Hello Loc', 
                                                ES_Presenter__c ='Arjun', EV_id__c =eve.id );
    
      insert es;
   
     
       PageReference pageRef = Page.mm_Eventadmin_Events ;
      Test.setCurrentPage(pageRef);
      system.runas(u1)
    {
    mm_Eventadmin_EventssampleCon Events= new mm_Eventadmin_EventssampleCon ();
    apexPages.currentPage().getParameters().put('eventName',eve.id);
Events.escapeSpecialCharacters('my>th#ly/');
Events.escapeSpecialCharacters('my"thly/');
Events.escapeSpecialCharacters('my<thly/');
Events.escapeSpecialCharacters('my.thly/');
Events.CheckUserId();
Events.EventsList();
Events.EventValues();
Events.SelectedEventId=eve.id;

Events.changeEvent();
Events.Logo =blob.valueOf('phani');
      Events.EventDetail=eve;
      Events.LogoName='phani Name';
 
Events.changeEventLogo();
Event__c ev2 = new Event__c(EV_Title__c = 'Test Event', EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/16/2014'),
                                        EV_HostingState__c ='Test State', EV_HostingLocation__c='281 Test Location', 
                                        EV_HostingTimeZone__c = 'Eastern Time(USA)', Status__c = 'Event Progres', EV_Publish__c = TRUE,
                                        Event_Printer__c = 'Avery 22806 easy peal square Badges');
  
       insert ev2;
          Event__c ev1 = new Event__c(EV_Title__c = 'Test Event', EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/16/2014'),
                                        EV_HostingState__c ='Test State', EV_HostingLocation__c='281 Test Location', 
                                        EV_HostingTimeZone__c = 'Eastern Time(USA)', Status__c = 'Event Progres', EV_Publish__c = TRUE,
                                        Event_Printer__c = 'Avery 5392 Name badges');
  
         insert ev1;
         Events.eventname=ev1.id; 
        //Events.getEventDetails();
       Events.EventDetail =ev2;
    
        Events.SelectedEventId=ev1.id;
      Events.editEvent();
     
Events.AddEvent();
Events.Event = new Event__c();
      Events.Event.EV_Title__c ='Test Event new';
      Events.EventEndDate = '2013-09-24'; 
       Events.EventStartDate = '2013-09-24';
      Events.Event.EV_HostingState__c ='Test State';
      Events.Event.EV_HostingLocation__c ='281 Test Location';
      Events.Event.EV_HostingTimeZone__c = 'Eastern Time(USA)';
      Events.Event.Status__c ='Event Progres';
      Events.Event.EV_Publish__c = FALSE;
      Events.Event.Event_Printer__c =  'Dymo Label(30856,Single Label)';
      Events.Event.MM_Start_Date__c =date.valueof(Events.EventStartDate) ; 
       Events.Event.MM_End_Date__c = date.valueof(Events.EventEndDate); 
       Events.Event.MatchMaking_Type__c = 'Semi open';
      
    
      Events.createEvent();
      upeEA.Ev_Id__c=null;
       update upeEA;
      Events.createEvent();
      events.selectedtab = 'Event Type';
      Events.enabletab1();
      Events.st_end_dates = 1;
      Events.Event.EV_StartDate__c = date.valueof('2013-09-24');
       Events.Event.EV_EndDate__c =date.valueof('2013-09-24');
      Events.enabletab2();
      Events.enabletab3();
      Events.savemmevent();
      Events.checkEvents();
      Events.customeventtype();
      
       Events.event.EV_StartDate__c=null;
       Events.enabletab2();
       
       Events.event.StartTime__c = null;
       Events.enabletab2();
       Events.event.EV_EndDate__c= null;
       Events.enabletab2();
       Events.event.EV_EndTime__c = null ;
       Events.event.EV_EndTime__c = null;
       Events.enabletab2();
       
       
      Events.previous4();
      Events.previous3();
      Events.previous2();
      Events.getistab3disabled();
      Events.getistab2disabled();
      Events.getistab1disabled();
      Events.getistab0disabled();
      events.selectedtab = 'Event Type';
      Events.getselectedtab();
       Events.Logo = Blob.valueOf('Hello Arjun');
            Events.LogoName ='Test Name';
             Events.updateLogo();
     Events.Cancel();
     

    }
  }
  
  }