@istest

public class Test_Report_Registration_attendess_con
{
  static testmethod void Report_Registration_attendess_con_testmethod()
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
   
   TicketTypes__c tic = new TicketTypes__c(EV_id__c=ev.id,  TT_Name__c='TestEvent',TT_TicketType__c='Paid',Ticket_Category__c='Attendee',TT_Available__c=20,User_Type__c='MSDC Member Corporation',Max_Tickets_per_Order__c=5,TT_Amount__c=500,Section_Name__c ='ONE DAY CONFERENCE ATTENDEE');
  insert tic;
  
  Constomer__c con = new Constomer__c(Isinserted__c=true);
   insert con;
   
   Dummay__c dum= new Dummay__c(Event__c=ev.id,TicketTypes__c=tic.id,customer_key__c=con.id,Payment_Type__c='Check',Payment_Status__c='Paid',First_Name__c='TestName1',Last_Name__c='TestName2',Email__c='test@test.com',Company__c='Test Company');
   insert dum;
   
   Dummay__c dum1= new Dummay__c(Event__c=ev.id,TicketTypes__c=tic.id,customer_key__c=con.id,Payment_Type__c='Check',Payment_Status__c='Not Paid',First_Name__c='TestName3',Last_Name__c='TestName1',Email__c='test1@test.com',Company__c='Test Company1');
   insert dum1;
   Report_Registration_attendess_con reg= new Report_Registration_attendess_con();
   reg.TablesCount();
   reg.ExhibitorstaffCount();
   
  }
}