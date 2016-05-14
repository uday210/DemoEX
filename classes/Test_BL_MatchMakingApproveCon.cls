@isTest
public class Test_BL_MatchMakingApproveCon{

    public static testMethod void testdoget(){
      user uname=[select createdby.id from user where profile.Name = 'system Administrator' Limit 1];
       account acc=new account();
       acc.name='Booth Leads';
       acc.ownerid=uname.createdby.id;
       insert acc;
    
     // Event Inserting 
       Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_Publish__c =true,
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_StartDate__c=date.valueOf('2013-09-24'),
                             EV_EndDate__c=date.valueOf('2013-09-25'),
                             MM_Start_Date__c =date.valueOf('2013-09-24'),
                             MM_Firstaday_startTime__c='2:00 PM',
                             MM_Firstaday_EndTime__c='6:00 PM',
                             MM_Slot_Timeperiod__c='10'
                             );
      insert eve;
      Id EventId=eve.Id;
     
       // Login user 
       contact  con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con;
           
       AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='test123t@noemail.com';
        att.AS_Company__c ='global';
        insert att;  
        
        Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam;
        
        Profile p = [select id from Profile where name='attendee'];
        
        user u = new User(alias = 'test123', email='test123t@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles', username='test123t@noemail.com');
                  insert u;
        Id attendeeId =u.id;  
      // inserting profile Cus    
      Profile__c attendeeProfile= new Profile__c (PR_Name__c='attendee',PR_Version__c='1.5');        
       insert  attendeeProfile;  
       
     // Insert upe for login user  
     User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true,Request_for_upgrade_profile__c=true);         
     insert upeEA;   
     
     User_Profile_Event__c upeEA1= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true,Request_for_upgrade_profile__c=true);         
     insert upeEA1;  
     
     
     PageReference pg = page.BL_MatchMakingApprove;
     Test.setCurrentPage(pg);
     ApexPages.currentPage().getParameters().put('id', EventId);
     
     BL_MatchMakingApproveCon  BLMM = new BL_MatchMakingApproveCon();
     BLMM.firstMethod();
         
     ApexPages.currentPage().getParameters().put('accept', upeEA.id+'-acc');
     BLMM.acceptRequest();
   
   ApexPages.currentPage().getParameters().put('accept', upeEA1.id+'-rej');
      system.debug('PPPPPPP '+upeEA1.id);
     BLMM.acceptRequest();
  
     
     
    }
    
  }