@istest

public class Test_BL_EA_renderdashboardcon
{
  static testmethod void BL_EA_renderdashboardcon_testmethod()
  {
    Profile p = [select id from profile where name='Standard User'];   
    User u = new User(alias = 'test123', email='test123@noemail.com',
                      emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
                      localesidkey='en_US',country='United States',
                      timezonesidkey='America/Los_Angeles', username='te633@noemail.com');
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
   string attendeeEvent= string.valueOf(att.Id)+string.valueOf(ev1.id);   
   Event_Attendee_Mapping__c eam=new Event_Attendee_Mapping__c(EV_id__c=ev.id,AS_id__c=att.id,Attendee_Event_IDs__c=attendeeEvent,DiversityType__c='xxxxxxx',TicketTypes__c='Reception',Update_With_CreatedDate__c =Date.Parse('01/18/2014') );
   insert eam;
  
   BoothVisitSummary__c bvs=new BoothVisitSummary__c(User_id__c=bAdmin.id,BVS_LeadRating__c=2,Follow_Update__c=system.today(),ScanTime__c=system.today(),BVS_FirstName__c='manasa1',BVS_LastName__c='G1',BVS_Email__c='testboothadmin1@noemail.com',EA_AttendeeBarcode__c=eam.id);
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
   

   Reports__c r = new Reports__c(RE_Name__c='Report By Geography',RE_Description__c='Test Description',UPE_id__c=upe.id); 
   insert r;  

   
   list<Reports__c> lr = new list<Reports__c>();
   lr.add(r);
  
   
    PageReference pageRef = Page.BL_EA_reports;
Test.setCurrentPage(pageRef);



   system.runAs(u)
     {     
      BL_EA_renderdashboardcon rench=new BL_EA_renderdashboardcon();
     rench.events=lupe;
   //rench.evntReports=lr;  
   rench.getBoothAdminScanData();
   rench.gotoRegistration();
   rench.gotoregistrationattendees();
   rench.getBoothadminslist();
   rench.getevents();
   rench.getvalues();
   rench.EventString = ev.id;
   rench.ChooseReport();  
   
    rench.ReportAssinged='Report By Industry';
    rench.ChooseReport();  
    rench.BackAction(); 
    rench.seltoexport();
     rench.gotoregistration();
     rench.getBoothadminsList();
    // rench.First();
   // rench.Previous();
   // rench.Next();
   // rench.Last();
    ApexPages.currentPage().getParameters().put('ReportName', 'Report By Industry');
   
      rench.PageAction();  
       
       
   rench.ReportAssinged ='Report By Geography';
   rench.ChooseReport(); 
    rench.PageAction();     
   rench.BackAction(); 
    rench.seltoexport();
   // rench.First();
   // rench.Previous();
   // rench.Next();
   // rench.Last();
   ApexPages.currentPage().getParameters().put('ReportName', 'Report By Geography');
    
      rench.PageAction();  
   
   rench.ReportAssinged ='Report By Business Revenue';
   rench.ChooseReport(); 
    rench.BackAction(); 
    rench.seltoexport();
   // rench.First();
   // rench.Previous();
   // rench.Next();
   // rench.Last();
   ApexPages.currentPage().getParameters().put('ReportName', 'Report By Business Revenue');
    rench.PageAction();  
   
   
   
   rench.ReportAssinged ='Report By Ticket Types';
   rench.ChooseReport(); 
   rench.BackAction(); 
    rench.seltoexport();
   // rench.First();
   // rench.Previous();
   // rench.Next();
   // rench.Last();
    ApexPages.currentPage().getParameters().put('ReportName', 'Report By Ticket Types');
    rench.PageAction();  
   
   
   rench.ReportAssinged ='Report By Diversity Certification';
   rench.ChooseReport(); 
   rench.BackAction(); 
    rench.seltoexport();
  //  rench.First();
//rench.Previous();
   // rench.Next();
   // rench.Last();
    ApexPages.currentPage().getParameters().put('ReportName', 'Report By Diversity Certification');
    rench.PageAction();  
    
   rench.ReportAssinged ='Report By Registartions by Date';
   rench.ChooseReport();
   rench.BackAction(); 
    rench.seltoexport();
    //rench.First();
//rench.Previous();
//rench.Next();
   // rench.Last();
   ApexPages.currentPage().getParameters().put('ReportName', 'Report By Registartions by Date');
    rench.PageAction();  
    
   
   
   rench.ReportAssinged ='Report By Booth Admin Scans';
   rench.ChooseReport();
   
   pageReference pg = Page.BL_EA_Reports;
   Test.setCurrentPage(pg);
   rench.paramname=r.id;
   pg.getParameters().put('EditReport',r.id);
   rench.ReportName=r.id;
   rench.EditReport();
   
   rench.UpdateReport();
   rench.BackAction();
   rench.cancel();
   rench.seltoexport();
   rench.gotoRegistration();
   rench.getBoothadminslist();
   rench.exportBoothScans();
   rench.login();
  // rench.First();
  // rench.Previous();
  // rench.Next();
  // rench.Last();
   rench.escape('te,st');
  // rench.escape1('te,st');
   rench.escapeSpecialCharacters('te"s<t');
   ApexPages.currentPage().getParameters().put('ReportName', 'Report By Booth Admin Scans');
   rench.PageAction();  
    
 }
 

} 
      
}