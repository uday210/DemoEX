@istest

public class Test_metricscon
{
  static testmethod void metricscon_testmethod()
  {
  
    Profile p = [select id from profile where name='Standard User'];   
    User u = new User(alias = 'test123', email='test123@noemail.com',
                      emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
                      localesidkey='en_US',country='United States',
                      timezonesidkey='America/Los_Angeles', username='tes98673@noemail.com');
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
   
   TicketTypes__c tic = new TicketTypes__c(EV_id__c=ev.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  Constomer__c cus2 = new  Constomer__c();
   cus2.Uniq_Number__c ='test';
   cus2.Isinserted__c=true;
   insert cus2;
  
  Dummay__c com2 = new Dummay__c(TicketTypes__c=tic.id,Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',TicketAmount__c=12,InvoiceEmail__c='test123@noemail.com',First_Name__c='FName',Event__c=ev.id,Email__c='test@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id);
  insert com2;
   
    system.runAs(u)
     {
     metricscon met = new metricscon();
     met.getdashboard(); 
     met.getpayData();
     met.registrationreport();
     met.getregChart();
     met.URLEvent();
     }
  }
}