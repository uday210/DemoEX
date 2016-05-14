@isTest
public class Test_GNESMSDC_RegistrationReportCon
{
  static testmethod void Testmethod_GNESMSDC_RegistrationReportCon()
  {
   Profile p = [select id from profile where name='Standard User'];
   User u = new User(alias = 'test123', email='test12sd3@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing',firstname='FirstTesting', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test12sd3@noemail.com');
   insert u;
  
   Event__c ev = new Event__c(EV_Title__c='TestEvent',
                             EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/16/2014'),
                             EV_EndTime__c='09:00 PM',
                             StartTime__c='09:00 AM',
                             EventDiversityValues__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ');
   insert ev;
    
   TicketTypes__c tic = new TicketTypes__c(EV_id__c=ev.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
   insert tic;
   
   Constomer__c con = new Constomer__c(Isinserted__c=true);
   insert con;
   
   Dummay__c dum= new Dummay__c(Event__c=ev.id,TicketTypes__c=tic.id,customer_key__c=con.id,Payment_Type__c='Check',Payment_Status__c='Paid',First_Name__c='TestName1',Last_Name__c='TestName2',Email__c='test@test.com',Company__c='Test Company');
   insert dum;
   
   Dummay__c dum1= new Dummay__c(Event__c=ev.id,TicketTypes__c=tic.id,customer_key__c=con.id,Payment_Type__c='Check',Payment_Status__c='Not Paid',First_Name__c='TestName3',Last_Name__c='TestName1',Email__c='test1@test.com',Company__c='Test Company1');
   insert dum1;
    
  system.runAs(u)
  {  
   GNESMSDC_RegistrationReportCon gne=new GNESMSDC_RegistrationReportCon();
   gne.customerreport();
   gne.changestatus();
   gne.dummyid = dum.id;
   gne.statusvalue='Paid';      
   gne.getpaymentstatus();
   gne.changingpaymentstatus();
   gne.dummyid = dum1.id;
   gne.statusvalue='Not Paid';
   gne.getpaymentstatus();
   gne.changingpaymentstatus();
   gne.cancel();  
  }
  }
}