@istest

public class Test_BL_Eventadmin_EventsCon 
{
  static testmethod void Testmethod_BL_Eventadmin_EventsCon ()
  {
  contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
       
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'test123', email='test123111@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123111@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  EventAdminProfile;
   
DiversityType__c d1= new DiversityType__c();
d1.name='Diversity Type1';
d1.IsValidDiversityType__c= true;
insert d1;

DiversityType__c d2= new DiversityType__c();
d2.name='Diversity Type2';
d2.IsValidDiversityType__c= true;
insert d2;   



DiversityType__c dv = new DiversityType__c(Name = 'Test Diversity 1', IsValidDiversityType__c =TRUE);
        DiversityType__c dv1 = new DiversityType__c(Name = 'Test Diversity 2', IsValidDiversityType__c =FALSE);
       LIST<DiversityType__c> ldiv = new LIST<DiversityType__c>();
       ldiv.add(dv);
       ldiv.add(dv1);







Attendee_Type__c AT1= new Attendee_Type__c (Name= 'Attendee type1');
insert AT1;

Attendee_Type__c AT2= new Attendee_Type__c (Name= 'Attendee type2');
insert AT2;




   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,EV_Publish__c =true,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;


TicketTypes__c TT1= new TicketTypes__c();
TT1.TT_Name__c=' ticket type1';
TT1.EV_id__c=eve.Id;
TT1.TT_TicketType__c='Free';
TT1.Ticket_Category__c='Non – Attendee';
insert TT1;

TicketTypes__c TT2= new TicketTypes__c();
TT2.TT_Name__c=' ticket type2';
TT2.EV_id__c=eve.Id;
TT2.TT_TicketType__c='Free';
TT2.Ticket_Category__c='Non – Attendee';
insert TT2;
    
  User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA; 



TicketTypes__c tic2 = new TicketTypes__c(TT_Name__c='Test Tic', TT_TicketType__c='Free',TT_Amount__c=50,   TT_Available__c=1000,EV_id__c=eve.id); 
       insert tic2;


SecurityControls__c secControl = new 

SecurityControls__c(EV_id__c=EventId,EV_Req_Fields__c='AS_FirstName__c',EV_Fields__c='AS_FirstName__c,AS_Company__c,AS_Title__c,AS_CellPhone__c,AS_Age__c,AS_Gender__c,AS_BirthDate__c,AS_HomeAddress1__c,AS_ShippingAddress1__c,AS_WorkAddress1__c,AS_NAICSCode1__c,AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,AS_PrimaryBusinessCategory__c,AS_SecondaryBusinessCategory__c,AS_NumberOfEmployees__c,AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_BusinessDunsNumber__c,AS_WebsiteUrl__c,AS_BlogUrl__c,AS_BusinessDescription__c,AttendeePic'); 
    insert  secControl ;  
     EventSchedule__c es = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', ES_EndDate__c = Date.Parse('01/18/2014'),
                                                ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                ES_Description__c='Hello Test Desc', ES_EndTime__c='09:30 AM', ES_Location__c='Hello Loc', 
                                                ES_Presenter__c ='Arjun', EV_id__c =eve.id );
    
      insert es;
      Survey_Questions__c SQ = new Survey_Questions__c(Question__c ='what is your name?',
                                                       Options__c = 'mythily',Type__c = 'CheckBox');
      insert SQ;
      Ticket_Mapswith_Survey__c TMS = new Ticket_Mapswith_Survey__c(Survey_Questions__c = SQ.id,TicketTypes__c = tic2.id);
      insert TMS;
      Promocodes__c pro = new Promocodes__c(Name = 'CP-123',Discount_Type__c ='%',Discount_Value__c=10);
      insert pro;
      Tickets_Mapswith_Promocode__c TMP = new Tickets_Mapswith_Promocode__c(Promocodes__c = pro.id,Tickets__c = tic2.id);
       insert TMP;                                                
      PageReference pageRef = Page.BL_Eventadmin_Events ;
      Test.setCurrentPage(pageRef);
      ApexPages.currentPage().getParameters().put('deleteTicketTypeid', tic2.id);
      ApexPages.currentPage().getParameters().put('deleteTicketType', '0');   
   
system.runas(u)
{

BL_Eventadmin_EventsCon Events= new BL_Eventadmin_EventsCon();


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
Events.getEventbrite();
Events.callBadgeSettings();
Events.selectedbadgesettings();
     
      Events.saveBadgeSettings();
     Event__c ev2 = new Event__c(EV_Title__c = 'Test Event', EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/16/2014'),
                                        EV_HostingState__c ='Test State', EV_HostingLocation__c='281 Test Location', 
                                        EV_HostingTimeZone__c = 'Eastern Time(USA)', Status__c = 'Event Progres', EV_Publish__c = TRUE,
                                        Event_Printer__c = 'Avery 22806 easy peal square Badges');
  
       insert ev2;
       Events.selectedbadgesettings();
       Events.saveBadgeSettings();
        Event__c ev1 = new Event__c(EV_Title__c = 'Test Event', EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/16/2014'),
                                        EV_HostingState__c ='Test State', EV_HostingLocation__c='281 Test Location', 
                                        EV_HostingTimeZone__c = 'Eastern Time(USA)', Status__c = 'Event Progres', EV_Publish__c = TRUE,
                                        Event_Printer__c = 'Avery 5392 Name badges');
  
         insert ev1;
         Event e =new event();
     
      
      
      
      
      
      
       Events.EventDetail =ev2;
       Events.selectedbadgesettings();
       Events.saveBadgeSettings();
        Events.EventDetail =ev1;
       Events.selectedbadgesettings();
       Events.saveBadgeSettings();
        Events.EventDetail =eve;
       Events.selectedbadgesettings();
      Events.cancelEvent();
      Events.SelectedEventId=ev1.id;
      Events.editEvent();
Events.AttendeeSettings();
Events.viewEventSchedule();
Events.getScheduleforEvent();
Events.First();
Events.Last();
Events.Previous();
Events.Next();

Events.UpdateAttendeeSetting();
//ApexPages.currentPage().getParameters().put('deleteTicketTypeid',TT1.id );
//Events.delTicketType();
Events.moreTickets();
//Events.sendValues();

Events.AddSchedule();
Events.EventStartDate = '2014-08-01';
Events.EventEndDate= '2014-08-01';
Events.AttendeeRegistration();
Events.AddEvent();
//events.eventname=es.id;
//Events.deleteSchedule();
//Events.deleteDataImportHistory();
Events.SaveSchedule();
Events.Cancel();
Events.disableHelpDivs();
Events.Event = new Event__c();
      Events.Event.EV_Title__c ='Test Event new';
      Events.Event.EV_EndDate__c = Date.Parse('01/18/2014'); 
      Events.Event.EV_StartDate__c = Date.Parse('01/16/2014');
      Events.Event.EV_HostingState__c ='Test State';
      Events.Event.EV_HostingLocation__c ='281 Test Location';
      Events.Event.EV_HostingTimeZone__c = 'Eastern Time(USA)';
      Events.Event.Status__c ='Event Progres';
      Events.Event.EV_Publish__c = FALSE;
      Events.Event.Event_Printer__c =  'Dymo Label(30856,Single Label)';

     
      Events.createEvent();
       upeEA.Ev_Id__c=null;
       update upeEA;
      Events.createEvent();
     Events.showPopup();
     Events.EBEpop();
     Events.getEventDetails1();
       Events.EventClose();
       Events.closePopup();
       Events.EBApop();
       Events.EventClose1();
       //Events.EventBriteEvents.add(upeEA);
       //Events.getSelectEventId();
       Events.statustest();
       Events.getAttendees();
       Events.EventClose2();
       Events.eventname=es.id; 
       Events.editsch =es;
       Events.getEventDetails();
       Events.editSchedule();
       Events.CancelSchedule();
       Events.ShowPreviousList();
       Events.dontShow();
      
       Events.EventToBoothLeads();
       BL_Eventadmin_EventsCon.Event innerevent= new BL_Eventadmin_EventsCon.Event ();
       BL_Eventadmin_EventsCon.attendee1 evatt = new BL_Eventadmin_EventsCon.attendee1('www.boothleads.com','myth','yenki','home','Jr','Globalnest','01452oklu','Miss','myblog.com','work','ticket',10,'0kj2365su','45oiuyhj586','ghjkk','mkiujhy','25');
        //evatt.attendeedetail();
   
   PageReference pageRef11 = Page.BL_Eventadmin_Events ;
      Test.setCurrentPage(pageRef11);
      
     BL_Eventadmin_EventsCon.innerForTicketTypes innerinnerForTicketTypes= new BL_Eventadmin_EventsCon.innerForTicketTypes(tt1,1,tt1.id);  
     innerinnerForTicketTypes.ticket =tt1;
     innerinnerForTicketTypes.tno=1;
     innerinnerForTicketTypes.ticId=tt1.id;
   
   BL_Eventadmin_EventsCon.innerForTicketTypes innerinnerForTicketTypes2= new BL_Eventadmin_EventsCon.innerForTicketTypes(tt1,1,tt1.id);  
     innerinnerForTicketTypes2.ticket =tt1;
     innerinnerForTicketTypes2.tno=1;
     innerinnerForTicketTypes2.ticId=tt1.id;
    List< BL_Eventadmin_EventsCon.innerForTicketTypes> listOfinners = new List< BL_Eventadmin_EventsCon.innerForTicketTypes>(); 
      listOfinners.add(innerinnerForTicketTypes2);
      Events.innerTickets =listOfinners;
   
      
     ApexPages.currentPage().getParameters().put('deleteTicketTypeid',TT1.id );
    ApexPages.currentPage().getParameters().put('deleteTicketType','0');

    Events.delTicketType();

   MAp<string,string> mapstrings = new MAp<string,string>();
   mapstrings.put('MINORITY OWNED BUSINESS ENTERPRISE','MINORITY OWNED BUSINESS ENTERPRISE');
   Events.DiversityMap=mapstrings;
   Events.extraDiv='MINORITY OWNED BUSINESS ENTERPRISE';
   Events.sendValues();
   
   MAp<string,string> mapstrings1 = new MAp<string,string>();
   mapstrings1.put('MINORITY OWNED BUSINESS ENTERPRISE','MINORITY OWNED BUSINESS ENTERPRISE');
    Events.attendeetypeMap=mapstrings1;
   Events.extraattendee='MINORITY OWNED BUSINESS ENTERPRISE';
   Events.newatttype();
   
  User_Profile_Event__c upeEA12= new User_Profile_Event__c (EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA12; 
 Events.createEvent();
 AttendeeSummary__c  newatt= new AttendeeSummary__c();
  
  newatt.AS_FirstName__c=evatt.first_name='myth';
  NewAtt.AS_LastName__c=evatt.last_name='Yenki';
  NewAtt.AS_Email__c=evatt.email='mythilyn@globalnest.com';
   NewAtt.AS_Gender__c=evatt.gender='male';
     NewAtt.AS_Company__c=evatt.company='globalnest';
    NewAtt.AS_Suffix__c=evatt.suffix='Sr';
     NewAtt.AS_Prefix__c=evatt.prefix='Miss';
      NewAtt.AS_Title__c=evatt.job_title='developer';
       NewAtt.AS_CellPhone__c=evatt.cell_phone='8521478963';
        NewAtt.AS_CellPhone__c=evatt.cell_phone='8523697412';
         NewAtt.AS_CellPhone__c=evatt.cell_phone='9874123658';
           NewAtt.AS_WorkAddress1__c=evatt.work_address='hyd';
           NewAtt.AS_WorkAddress2__c=evatt.work_address_2='hyd';
            NewAtt.AS_WorkState__c =evatt.work_region='north';
              NewAtt.AS_WorkPhone__c=evatt.work_phone='5632147896';
              NewAtt.AS_WorkCity__c =evatt.work_city='Hyd';
               NewAtt.AS_WorkCountry__c =evatt.work_country='India';
                evatt.ship_address='Hyd';
                 evatt.ship_address_2='Hyd';
                  evatt.ship_city='Hyd';
                   evatt.ship_region='south';
                    evatt.ship_country='India';
                     evatt.ship_phone='4563214782';
                      evatt.home_address='Hyd';
                       evatt.home_address_2='Hyd';
                        evatt.home_city='Hyd';
                         evatt.home_region='India';
                          evatt.home_country='India';
                          evatt.home_phone='9705567247';
                          evatt.blog='www.blog';
                          evatt.website='www.boothleads.com';
                 list<BL_Eventadmin_EventsCon.attendee1> evattlist=new list<BL_Eventadmin_EventsCon.attendee1>();
                 evattlist.add(evatt);
                 
                 Events.EventbriteAtt=evattlist;
                 
                 List<AttendeeSummary__c> atlist=new List<AttendeeSummary__c>();

                 atlist.add(newatt);
                 Events.savedAttendees=atlist;
            //  Events.deleteSchedule();

            // Events.updateLogo();
               Events.deleteDataImportHistory();
              
             //Events.getSelectEventId();
              //Events.attendeedetail();
              ApexPages.currentPage().getParameters().put('evStartDate','2014-08-01');
               Events.getEventStartTime();
                Events.getEventStartTime();
            Events.Logo = Blob.valueOf('Hello Arjun');
            Events.LogoName ='Test Name';
            test.starttest();
             Events.updateLogo();
             Events.TicketTypes();
             
             
          //  Events.surveyquestions();
           // Events.Squestions  SQ1=new Survey_Questions__c();
        //     Events.Squestions.Question__c ='what is your name?';
          //    Events.Squestions.Options__c = 'mythily';
             // Events.Squestions.Type__c = 'CheckBox';
          
                          
          //  Events.savequestions();

         //   ApexPages.currentPage().getParameters().put('mycheck',TMS.id);
           // Events.editSurvey();
           ApexPages.currentPage().getParameters().put('promoid',TMP.id);
           //Events.editpromo();
           //Events.updatepromo();
           ApexPages.currentPage().getParameters().put('promoid',TMP.id);
           //Events.deletepromo();
          Events.testdum() ; 
          test.stoptest();
             
}
}
}