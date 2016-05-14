@istest (SeeAllData=true) 

public class Test_MM_EventAdmin_ReportsCon
{
  static testmethod void Testmethod_MM_EventAdmin_ReportsCon(){
   
     user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];         

     Profile p = [select id from profile where name='system Administrator'];

     User u = new User(alias = 'test123', email='test123890@noemail.com',
                       emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                       localesidkey='en_US',country='United States',
                       timezonesidkey='America/Los_Angeles', username='test123890@noemail.com');
     insert u;

      Id eventAdminId=u.id;   

      Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
      insert  customProfileBooth;
   
      Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                                  EV_EndDate__c =  Date.Parse('01/18/2014'),
                                  EV_StartDate__c = Date.Parse('01/19/2014'),
                                  EV_EndTime__c='09:00 AM',
                                  StartTime__c='11:00 AM',Is_MatchMaking_Event__c=true);
      insert eve;
      Id EventId=eve.Id;    
        
      AttendeeSummary__c attSummary = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',AS_Email__c = 'test123890@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None',
                                                             As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', As_NAICSCode_1__c = '987654', As_NAICSCode_2__c = '123456', As_NAICSCode_3__c = '898765');
      insert attSummary;
     
      User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA; 
      
      Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = EventId,checkbox_dataTable__c=True, AS_id__c = attSummary .id);
      insert EAM;
      
      EventSchedule__c es= new EventSchedule__c(EV_id__c = EventId,Is_Matchmaking__c = True, MM_To_EAM__c = EAM.id,   MM_To_UPE__c = upeEA.id, MM_Slot_Status__c = 'Accepted');
      insert es;

      EventSchedule__c es1= new EventSchedule__c(EV_id__c = EventId,Is_Matchmaking__c = True, MM_To_EAM__c = EAM.id,   MM_To_UPE__c = upeEA.id, MM_Slot_Status__c = 'Pending');
      insert es1;
      
      EventSchedule__c es2= new EventSchedule__c(EV_id__c = EventId,Is_Matchmaking__c = True, MM_To_EAM__c = EAM.id,   MM_To_UPE__c = upeEA.id, MM_Slot_Status__c = 'Missed');
      insert es2;
      
      EventSchedule__c es3= new EventSchedule__c(EV_id__c = EventId,Is_Matchmaking__c = True, MM_To_EAM__c = EAM.id,   MM_To_UPE__c = upeEA.id, MM_Slot_Status__c = 'Rejected');
      insert es3;
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
        cookie  counter = new Cookie('counter',EventId,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
      system.runAs(u){
      try{
      
        MM_EventAdmin_ReportsCon ReportsCon = new MM_EventAdmin_ReportsCon();
        ReportsCon.eventSelected = counter.getvalue();
        ReportsCon.checkuser();
        ReportsCon.getevents();
       
        
        ReportsCon.exhibitorschedules();
        ReportsCon.attendeeschedules();
        ReportsCon.totalmatches();
        ReportsCon.pendingappointments();
        ReportsCon.changependingstatus();
        ReportsCon.cancelledappointments();
        ReportsCon.missedappointments();
        ReportsCon.PercentUtilizationChart();
        ReportsCon.totalmatchesbool = true;
        ReportsCon.printschedule();
        ReportsCon.pendingbool = true;
        ReportsCon.totalmatchesbool = false;
        ReportsCon.printschedule();       
        ReportsCon.missedbool = true;
        ReportsCon.pendingbool = false;
        ReportsCon.totalmatchesbool = false;
        ReportsCon.printschedule();
        ReportsCon.missedbool = false;
        ReportsCon.pendingbool = false;
        ReportsCon.totalmatchesbool = false;
        ReportsCon.printschedule();
        ReportsCon.totalmatchesbool = true;
        ReportsCon.exportschedule();
        ReportsCon.pendingbool = true;
        ReportsCon.totalmatchesbool = false;
        ReportsCon.exportschedule();       
        ReportsCon.missedbool = true;
        ReportsCon.pendingbool = false;
        ReportsCon.totalmatchesbool = false;
        ReportsCon.exportschedule();
        ReportsCon.missedbool = false;
        ReportsCon.pendingbool = false;
        ReportsCon.totalmatchesbool = false;
        ReportsCon.exportschedule();
        ReportsCon.eventscheduleid = es1.id;
        ReportsCon.sendRemainderEmail();
        ReportsCon.sendRemainderEmailtoAll();
       
        ReportsCon.exhibitorscheduleswithprofilesbycompany();
        ReportsCon.exhibitorscheduleswithprofilesbyTableNo();
         ReportsCon.assignAppointment();
         ReportsCon.printpendingschedule();
         ReportsCon.Openappointments();
         ReportsCon.printopen();
         ReportsCon.exportopen();
         ReportsCon.schedulerecords();
        system.debug('mmmmmmmmmmmmmmmmmmmmmm 1');
        ReportsCon.appointmentsByTime();
        system.debug('mmmmmmmmmmmmmmmmmmmmmm 2');
        ReportsCon.timesList();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 3');
        ReportsCon.schedulerecords();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 4');
        ReportsCon.exportscheduletime();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 5');
        ReportsCon.printscheduletime();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 6');
        ReportsCon.boothadminslist();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 7');
        ReportsCon.printboothslist();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 8');
        ReportsCon.exportboothslist();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 9');
        ReportsCon.appointmentsbytime2();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 10');
        ReportsCon.exportschedulegroup();
         system.debug('mmmmmmmmmmmmmmmmmmmmmm 11');
        ReportsCon.printschedulegroup();
       ReportsCon.signups();
       ReportsCon.exportignup();
       ReportsCon.printsignup();
       ReportsCon.smallschedulescount();
       ReportsCon.countappexpo();
       ReportsCon.countappprint();
        ReportsCon.cancel();
        ReportsCon.CheckUser();
        ReportsCon.printscheduleGroup();
        
   }catch(Exception Ex){}
   }
  }
}