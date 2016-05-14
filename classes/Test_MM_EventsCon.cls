@isTest
public class Test_MM_EventsCon{



    public static testMethod void testdoget(){
    
               
    user uname=[select createdby.id from user where profile.Name = 'system Administrator' Limit 1];

   account acc=new account();
   acc.name='Booth Leads';

   acc.ownerid=uname.createdby.id;
   insert acc;

   contact  con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
     insert con;
    
    Profile p = [select id from Profile where name='attendee'];
       
     // ------------------ Eventadmin Insert ---------------------



AttendeeSummary__c att = new AttendeeSummary__c();
att.AS_FirstName__c='re';
att.AS_LastName__c ='lo';
att.AS_Email__c ='test123t@noemail.com';
att.AS_Company__c ='global';
insert att;  

   user u = new User(alias = 'test123', email='test123t@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles', username='test123t@noemail.com');
                  insert u;
    Id attendeeId =u.id;    
 
       Profile__c attendeeProfile= new Profile__c (PR_Name__c='attendee',PR_Version__c='1.5');        
       insert  attendeeProfile;

        Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,EV_Publish__c =true,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
    
    
    EventSchedule__c esc = new EventSchedule__c(EV_id__c=EventId,ES_ProgramName__c='myName',ES_EndTime__c='7 PM',ES_StartTime__c='8 PM');
    insert esc ;
    
     User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true);         
     insert upeEA; 
   
     system.runAs(u){
     MM_eventsCon evecon = new MM_eventsCon();
     evecon.viewSchedule();
     evecon.CancelSchedule();
     
    } 

  }
}