@isTest
public class Test_GlobalUtillClass{
    static testMethod void testRest(){
       contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
       insert m;
       Profile w = [select id from profile where name='Standard User'];
   // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'test123', email='test123vf@noemail.com',
                 emailencodingkey='UTF-8',profileid = w.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123vf@noemail.com');
                  insert u;
                  Id eventAdminId=u.id; 
    
     
     Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      string EventId=eve.Id;
      
      Booth__c booth = new Booth__c();
      booth.BT_Name__c ='My booth';
      booth.BT_Description__c='Hi';
      booth.BT_ContactName__c='cpk';
      booth.BT_ContactPhone__c='99999999999';
      booth.BT_ContactEmail__c='test@gmail.com';
      booth.BT_WebsiteURL__c='www.ggg.com';
      booth.BT_Location__c='global';
      booth.BT_Phone__c='9999999999';
      insert booth;
      
      Track__c tr = new Track__c();
      tr.Event__c = EventId;
      tr.Name = 'Room 3';
      insert tr;
      
      Seminar__c sm = new Seminar__c();
      //sm.Name ='My Name';
      sm.Track__c= tr.id;
      sm.Speaker__c='speaker';
      sm.Start_Time__c='12:45 PM';
      sm.End_Time__c='01 PM';          
      sm.Date__c =Date.Parse('01/18/2014');
      sm.Description__c='hi';
      sm.Max_no_of_people__c=32;
      sm.Cost__c=23;
      sm.Spk_DesigAndDept__c='';
      sm.Spk_Company__c='global';
      sm.Spk_SeminarRole__c='role';
      insert sm;  
      
      Floor_Map__c fm = new Floor_Map__c();
      fm.name= 'we ';
      fm.Parameters__c='{"type":"rectangle","params":{"x":378,"y":378,"width":47,"height":44}}';
      insert fm;
      
       AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='test123vf@noemail.com'
       ,AS_NAICSCode_1__c='054321',AS_NAICSCode_2__c='054321',AS_NAICSCode_3__c='054321',AS_NAICSCode_4__c='054321',AS_PrimaryBusinessCategory__c='cpf',AS_ImageUrl__c='',Keywords__c='global');
        insert attSummary;
      
      EventSchedule__c eventSc = new  EventSchedule__c();
       eventSc.ES_ProgramName__c ='Programe';
       eventSc.ES_Description__c='des';
       eventSc.ES_Location__c='loca';
       eventSc.ES_Presenter__c='Ram'; 
       eventSc.ES_StartDate__c=Date.Parse('01/18/2014');
       eventSc.ES_EndDate__c=Date.Parse('01/18/2014');
       eventSc.ES_StartTime__c='12:30 PM';
       eventSc.ES_EndTime__c='12:45 PM';
       eventSc.EV_id__c =eve.id;
       insert eventSc;
      
      User_Profile_Event__c  upe = new User_Profile_Event__c ();
      upe.EV_id__c =eve.id;
      upe.User_id__c =u.id;
      upe.BT_id__c =booth.id;
      upe.Attendee_Summary__c =attSummary.id;
      insert upe;
      
      Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c();
      eam.AS_ID__c =attSummary.id;
      eam.EV_id__c =eve.id;
      insert eam;
      
      BoothVisitSummary__c bvs = new BoothVisitSummary__c();
      bvs.BVS_FirstName__c ='test';
      bvs.BVS_LastName__c ='Name';
      bvs.BVS_Email__c ='test@gmail.com';
      bvs.Mrecordid__c =eve.id;
      bvs.BVS_LeadRating__c =5;
       bvs.ScannedTime__c =system.now();
       bvs.BVS_SurveyQuestion1__c ='Hi';
       bvs.BVS_SurveyAnswer1__c ='gt';
      insert bvs;
          
         GlobalUtillClass glo = new GlobalUtillClass();
         GlobalUtillClass.UserDetails gu = new GlobalUtillClass.UserDetails(u,'',EventId);
         
         GlobalUtillClass.EventDetails ge = new GlobalUtillClass.EventDetails(eve);
         GlobalUtillClass.KSKEventList gk = new GlobalUtillClass.KSKEventList(eve);
         GlobalUtillClass.KSKBoothDetails gks =new GlobalUtillClass.KSKBoothDetails(booth);
         GlobalUtillClass.KSKSpeakers gsp = new GlobalUtillClass.KSKSpeakers(sm);
         GlobalUtillClass.KSKKiosksList gkk = new GlobalUtillClass.KSKKiosksList(fm);
         GlobalUtillClass.KSKEventModules gmm = new GlobalUtillClass.KSKEventModules('');
         GlobalUtillClass.MMEventDetails evedetails = new GlobalUtillClass.MMEventDetails(eve,u.id);
         GlobalUtillClass.MMSearchRes gmmSearch = new GlobalUtillClass.MMSearchRes(attSummary,u.id);
         GlobalUtillClass.MMATTSearchRes MMATTSearchRes= new GlobalUtillClass.MMATTSearchRes(attSummary,u.id);
         GlobalUtillClass.MMEXSchedules msc = new GlobalUtillClass.MMEXSchedules(eventSc,'cpk','ch','global','test@gmail.com',eventSc.id);
         GlobalUtillClass.MMEXAppointmentlist gex  = new GlobalUtillClass.MMEXAppointmentlist(eventSc);
         GlobalUtillClass.MMEXOpenslots  gslots = new GlobalUtillClass.MMEXOpenslots('','');
         GlobalUtillClass.MMEXHDetails glexm = new GlobalUtillClass.MMEXHDetails(upe);
         GlobalUtillClass.globalSuccess glsuc = new GlobalUtillClass.globalSuccess(u.id,'');
         GlobalUtillClass.globalMessage err = new GlobalUtillClass.globalMessage('');
         GlobalUtillClass.EventSchedule glSchedule = new GlobalUtillClass.EventSchedule(eventSc);
         GlobalUtillClass.NewSlotDetils glnewslot = new GlobalUtillClass.NewSlotDetils(eventSc,'');
         GlobalUtillClass.BoothDetails bdetails = new GlobalUtillClass.BoothDetails(booth);
         GlobalUtillClass.leads bdv = new GlobalUtillClass.leads(bvs);
         
    }
 }