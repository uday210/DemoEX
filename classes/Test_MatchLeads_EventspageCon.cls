@istest (SeeAllData=true) 

public class Test_MatchLeads_EventspageCon
{
  static testmethod void Testmethod_MatchLeads_eventspage(){
  user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];         

     Profile p = [select id from profile where name='system Administrator'];

     User u = new User(alias = 'test123', email='tests123890@noemail.com',
                       emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                       localesidkey='en_US',country='United States',
                       timezonesidkey='America/Los_Angeles', username='tests123890@noemail.com');
     insert u;
        
      Id eventAdminId=u.id;   
       Event__c eve = new Event__c(EV_Title__c='Globalnest Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                                  EV_EndDate__c =  Date.Parse('01/18/2014'),
                                  EV_StartDate__c = Date.Parse('01/19/2014'),
                                  EV_EndTime__c='09:00 AM',
                                  StartTime__c='11:00 AM',Is_MatchMaking_Event__c=true);
      insert eve;
      Id EventId=eve.Id;  
      AttendeeSummary__c attSummary = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',AS_Email__c = 'tests123890@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None',
                                                             As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', As_NAICSCode_1__c = '987654', As_NAICSCode_2__c = '123456', As_NAICSCode_3__c = '898765');
      insert attSummary;
       Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = EventId,checkbox_dataTable__c=True, AS_id__c = attSummary .id);
      insert EAM;
      Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
      insert  customProfileBooth;
   
       
       SecurityControls__c secControl = new SecurityControls__c(EV_id__c=EventId,EV_Req_Fields__c='AS_FirstName__c',EV_Fields__c='AS_FirstName__c,AS_Company__c,AS_Title__c,AS_CellPhone__c,AS_Age__c,AS_Gender__c,AS_BirthDate__c,AS_HomeAddress1__c,AS_ShippingAddress1__c,AS_WorkAddress1__c,AS_NAICSCode_1__c,AS_NAICSCode_2__c,AS_NAICSCode_3__c,AS_NAICSCode_4__c,AS_NAICSCode_5__c,AS_PrimaryBusinessCategory__c,AS_SecondaryBusinessCategory__c,AS_NumberOfEmployees__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_BusinessDunsNumber__c,AS_WebsiteUrl__c,AS_BlogUrl__c,AS_BusinessDescription__c,AttendeePic'); 
    insert  secControl ; 
        MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('01/18/2014'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = EventId,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('01/19/2014'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = EventId,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays1;
           Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks; 
            User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false,IsMatchMakingUser__c = true);         
      insert upeEA; 
      
      Tags__c tg= new Tags__c(Default_Name__c='Attendee',Event__c=EventId,Alias_Name__c='MBE');
      insert tg;
      Tags__c tg2= new Tags__c(Default_Name__c='Exhibitor',Event__c=EventId,Alias_Name__c='Corporate');
      insert tg2;
           
        cookie  counter = new Cookie('counter',EventId,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
      system.runAs(u){
      
      Matchleads_eventsPageCon Events = new Matchleads_eventsPageCon();
          
        Events.SelectedEventId=counter.getvalue();
        Events.CheckUser();
     
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
      
    test.starttest();
      Events.createEvent();

         ApexPages.currentPage().getParameters().put('eveId',eve.id);
        Events.editEvent();
        ApexPages.currentPage().getParameters().put('eveId',eve.id);
        Events.vieweventDetails();
        Events.manageevent();
        Events.VcalForevent(eve.id);
        Events.savebreaks();
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
     // Events.checkEvents();
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
            // Events.updateLogo();
     Events.Cancel();
      Events.matchtabs();
      Events.EventsList();
       Events.changeProfile(); 
       Events.getistab4disabled();
     // Events.getperutil();
      Events.getCount();
      Events.getEventbrite();
      Events.dummy1();
       //
      ApexPages.Currentpage().getparameters().put('eveid1',eve.id);
      Events.stopschedules();
       ApexPages.Currentpage().getparameters().put('eveid2',eve.id);
     // Events.startschedules();
     // Events.stopEmails();
       //test.stoptest();
      //test.starttest();
      ApexPages.Currentpage().getparameters().put('eveid1',eve.id);
       //Events.startemails();
       Events.logo=blob.valueof('good boy');
       Events.createEvent();
       ApexPages.currentPage().getParameters().put('eveId',eve.id);
       Events.selectedEventId=eve.id;
       //Events.getperutil();
       test.stoptest();
      }
  
  }
  
  
  }