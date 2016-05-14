@istest

public class Test_BL_EA_apexdashboardcon
{
  static testmethod void BL_EA_apexdashboardcon_testmethod()
  {
    Profile p = [select id from profile where name='Standard User'];   
    User u = new User(alias = 'test123', email='tes98h673@noemail.com',
                      emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
                      localesidkey='en_US',country='United States',
                      timezonesidkey='America/Los_Angeles', username='tes9h8673@noemail.com');
    insert u;  
    
     user EAdmin =  new User(alias = 'testboot', email='testeventadmin@noemail.com',
                             emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                             localesidkey='en_US',country='United States',
                             timezonesidkey='America/Los_Angeles', username='testeventadmin@noemail.com');
                  
    insert EAdmin ;
    
    
    user bAdmin =  new User(alias = 'testboot', email='testboothadmin@noemail.com',
                            emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                            localesidkey='en_US',country='United States',
                            timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com');
                  
    insert bAdmin ;
   
    
      Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
        insert  customProfile;
       
    Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
      insert  customProfileBooth;  
    
    Profile__c customprofilebpl = new Profile__c (PR_Name__c='BoothPersonnel',PR_Version__c='1.5');
      insert customProfilebpl;
    
   
    
    Event__c ev = new Event__c(EV_Title__c='TestEvent',
                               EV_HostingTimeZone__c='Eastern Time(USA)',
                               EV_EndDate__c =  Date.Parse('01/18/2014'),
                               EV_StartDate__c = Date.Parse('01/16/2014'),
                               EV_EndTime__c='09:00 PM',
                               StartTime__c='09:00 AM');
    insert ev;
   
   Event__c ev1 = new Event__c(EV_Title__c='TestEvent1',
                               EV_HostingTimeZone__c='Eastern Time(USA)',
                               EV_EndDate__c =  Date.Parse('01/18/2014'),
                               EV_StartDate__c = Date.Parse('01/18/2014'),
                               EV_EndTime__c='09:00 AM',
                               StartTime__c='11:00 AM');
   insert ev1;  
   
   User_Profile_Event__c upe=new User_Profile_Event__c(EV_id__c=ev.id,BoothAdmin_id__c=u.id,EventAdmin_Id__c=u.id,User_id__c=u.id,Profile_id__c=customProfile.id);
   insert upe;  
   
   User_Profile_Event__c upe1=new User_Profile_Event__c(EV_id__c=ev.id,BoothAdmin_id__c=u.id,EventAdmin_Id__c=u.id,User_id__c=u.id,Profile_id__c=customProfileBooth.id);
   insert upe1;
   
   User_Profile_Event__c upe2=new User_Profile_Event__c(EV_id__c=ev.id,BoothAdmin_id__c=u.id,EventAdmin_Id__c=u.id,User_id__c=u.id,Profile_id__c=customprofilebpl.id);
   insert upe2;
   
   AttendeeSummary__c att = new AttendeeSummary__c(AS_FirstName__c='testattendeesummaryfirstname',
                                                 AS_LastName__c='testattendeelastname',
                                                 AS_Email__c='test123@noemail.com',
                                                 AS_Company__c='testattendeecompany',
                                                 AS_Work_States__c='Alabama',
                                                 AS_PrimaryBusinessCategory1__c='Accounting',
                                                 AS_CellPhone__c='9705036486');    
   insert att; 
   
   DeviceUsage__c du=new DeviceUsage__c(OsVersion__c='Android',EV_id__c=ev.id,User__c=u.id);   
   insert du;
   
   Event_Attendee_Mapping__c eam=new Event_Attendee_Mapping__c(EV_id__c=ev.id,AS_id__c=att.id,DiversityType__c='xxxxxxx',TicketTypes__c='Reception');
   insert eam;
  
   BoothVisitSummary__c bvs=new BoothVisitSummary__c(ScanTime__c=datetime.valueOf('2013-05-15 00:00:00'));
   insert bvs;
  
   User_Event_BVS__c ueb=new User_Event_BVS__c(BVS_id__c=bvs.id,EV_id__c=ev.id,UPE_id__c=upe.id);
   insert ueb;
   
   User_Event_BVS__c ueb1=new User_Event_BVS__c(BVS_id__c=bvs.id,EV_id__c=ev.id,UPE_id__c=upe1.id);
   insert ueb1;
   
   User_Event_BVS__c ueb2=new User_Event_BVS__c(BVS_id__c=bvs.id,EV_id__c=ev.id,UPE_id__c=upe2.id);
   insert ueb2;
   
   List<Event_Attendee_Mapping__c> listOfEvent = new List<Event_Attendee_Mapping__c>();
   listOfEvent.add(eam);
      
   list<Event__c> lev = new list<Event__c>();
   lev.add(ev);
   
   list<User_Profile_Event__c> lupe = new list<User_Profile_Event__c>();
   lupe.add(upe);
   
   List<id> listid =new List<id>();
   listid.add(eam.id);
   TicketTypes__c tckt=new TicketTypes__c(TT_Name__c='Test Ticket',EV_id__c=Ev.ID,TT_Available__c=100,TT_Amount__c=200,TT_TicketType__c='Paid');
insert tckt;
Constomer__c cust=new Constomer__c(Isinserted__c=true,Customer_Name__c=att.AS_FirstName__c,Email__c=att.AS_Email__c,Total_Amount__c=1000);
insert cust;
  Dummay__c dm=new Dummay__c(First_Name__c=att.AS_FirstName__c,Last_Name__c=att.AS_LastName__c,Email__c=att.AS_Email__c,TicketTypes__c=tckt.id,Event__c=Ev.ID,
TicketAmount__c=200,Payment_Status__c='Paid',Payment_Type__c='Cash',Tickets_Quantty__c=2,Check_number__c='1',Seat_Number__c='1',Promocode__c='1',customer_key__c=cust.id,AttendeeSummary__c=att.id,Event_Attendee_Mapping__c=eam.id);
insert dm;
    
     system.runAs(u)
     {     
      BL_EA_apexdashboardcon db=new BL_EA_apexdashboardcon();
      
        db.Events2=lupe;   
        db.eventids=listid;
        db.allEventsIds=listid;
        db.EventString=ev.id;        
        db.EventDates='2013-06-19';      
        db.EventString=ev1.id;
        db.getCurrentevent();
        db.getdashboard();
        db.Attendeecount();
        db.walkinsAttendeeCount(); 
        BL_EA_apexdashboardcon.innerSalesProductivity incq = new BL_EA_apexdashboardcon.innerSalesProductivity('test',3);
        db.registeredAttendeeCount() ;
        db.Visitedattendeecount() ;
        db.getBoothcount();
        db.Mobileusers(); 
        db.Totalscans(); 
        //db.getIndustryAdminChart();
        db.IndustryReport();
        db.getPieData();
        db.GeoReport();
        //db.getregChart();
        BL_EA_apexdashboardcon.revInner regr = new BL_EA_apexdashboardcon.revInner('test4',6);
        db.RegReport();
        db.getrevChart();
        db.RevenueReport();
        BL_EA_apexdashboardcon.divInner divI = new BL_EA_apexdashboardcon.divInner('test3',5);
        db.getdivChart();
        db.diversityrep();
        db.gettktChart();
        BL_EA_apexdashboardcon.PieDataForScans pied = new BL_EA_apexdashboardcon.PieDataForScans('test1',4);
        test.starttest();
        db.tickdb();
        db.getcapacityChart();
        db.BackToChart();
        db.BackTodb();
        db.BackTodashboard();
        db.BackTorevdb();
        db.URLEvent();
        db.ShowScans();
        db.metrics();
        test.stoptest();
        
    }    
  }



}