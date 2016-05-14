@isTest

public class Test_Copy_Event{

    public static TestMethod Void test(){
    user uname=[select createdby.id from user where profile.Name = 'system Administrator' Limit 1];
        account acc=new account();
        acc.name='Booth Leads';
        acc.ownerid=uname.createdby.id;
        insert acc;
        Profile__c p1 = new Profile__c(PR_Name__c='Attendee');
        insert p1;
       
           
        AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='prabhu@noemail.com';
        att.AS_Company__c ='global';
        insert att;  
        
        AttendeeSummary__c att2 = new AttendeeSummary__c();
        att2.AS_FirstName__c='re';
        att2.AS_LastName__c ='lo';
        att2.AS_Email__c ='prabhu2@noemail.com';
        att2.AS_Company__c ='global';
        insert att2; 
        
        
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
      
      
      
      // Event Inserting 
       Event__c eve2 = new Event__c(EV_Title__c='Global Event2',EV_HostingTimeZone__c='Eastern Time(USA)',
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
      insert eve2;
      Id EventId2=eve2.Id;
        
        
         Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam; 
        
         Event_Attendee_Mapping__c eam2 = new Event_Attendee_Mapping__c(AS_id__c=att2.id,EV_id__c=eve.id); 
         insert eam2; 
        
       // Login user 
       contact  con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con;  
        
        Profile__c attendeeProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
        insert  attendeeProfile;  
        
        Profile p = [select id from Profile where name='attendee'];
        
        user u = new User(alias = 'test123', email='Evevt@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles', username='Evevt@noemail.com');
                  insert u;
         contact  con2 = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con2;  
        
        
         user u2 = new User(alias = 'test123', email=' prabhu2@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con2.id,
                  timezonesidkey='America/Los_Angeles', username= 'prabhu2@noemail.com');
                  insert u2;
        
        
      
        
        
      // Insert upe for login user  
     User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=u.id,UEP_isActive__c=true);         
     insert upeEA;   
     
      User_Profile_Event__c upeEA2= new User_Profile_Event__c (EV_id__c=EventId2,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=u.id,UEP_isActive__c=true);         
      insert upeEA2;
        
      system.runAs(u){  
         Copy_EventCon copyeve = new Copy_EventCon();   
         copyeve.selectedToEvent =EventId2;
         copyeve.selectedFromEvent =EventId;
         copyeve.saveCopyAttendee();
         }
    }

}