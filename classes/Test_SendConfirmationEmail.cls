@isTest
public with sharing class Test_SendConfirmationEmail{
    static testMethod void Testmethod_SendConfirmationEmail(){
    
       Profile__c baProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
       insert  baProfile;
       
    user uname=[select createdby.id from user where profile.Name = 'system Administrator' And IsActive = True  Limit 1];
       account acc=new account();
       acc.name='Booth Leads';
       acc.ownerid=uname.id;
       insert acc;
   
     
       
        contact  con11 = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con11;
    
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
                             MM_Slot_Timeperiod__c='10',
                             MatchMaking_Type__c='Semi Open'
                             );
      insert eve;
      Id EventId=eve.Id;
      AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='test123t@noemail.com';
        att.AS_Company__c ='global';
        insert att; 
      
       Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam;
        
        MatchLeads_Days__c mdays2 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('01/19/2014'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = eve.id,
                                                         MAX_noOf_appontments__c=5);  
      Profile pBa = [select id from Profile where name='Booth Admin'];
        
        user uba = new User(alias = 'test123', email='test123Ba@noemail.com',
                  emailencodingkey='UTF-8',profileid = pBa.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con11.id,
                  timezonesidkey='America/Los_Angeles', username='test123Ba@noemail.com');
                  insert uba ;
        Id BoothAdminId =uba.id;                                                      
                                                         
    User_Profile_Event__c upeBA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=baProfile.id,Status__c='Active',User_id__c=BoothAdminId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='Corporate');         
      insert upeBA; 
      
      EventSchedule__c EventScheduleCancelled = new EventSchedule__c(EV_id__c=eventId,MM_To_EAM__c=eam.id,Is_Matchmaking__c=true,MM_Slot_End_Time__c='2:10 PM',MM_slot_StartTime__c='2:00 PM',MM_To_UPE__c=upeBA.id,MM_Slot_Status__c='cancelled');
      insert EventScheduleCancelled ; 
      
      EventSchedule__c EventSchedulePending = new EventSchedule__c(EV_id__c=eventId,MM_To_EAM__c=eam.id,Is_Matchmaking__c=true,MM_Slot_End_Time__c='2:10 PM',MM_slot_StartTime__c='2:00 PM',MM_To_UPE__c=upeBA.id,MM_Slot_Status__c='Pending');
      insert EventSchedulePending ; 
      
      EventSchedule__c EventScheduleRejected = new EventSchedule__c(EV_id__c=eventId,MM_To_EAM__c=eam.id,Is_Matchmaking__c=true,MM_Slot_End_Time__c='2:10 PM',MM_slot_StartTime__c='2:00 PM',MM_To_UPE__c=upeBA.id,MM_Slot_Status__c='Rejected');
      insert EventScheduleRejected ; 
      
      EventSchedule__c EventScheduleAccepted = new EventSchedule__c(EV_id__c=eventId,MM_To_EAM__c=eam.id,Is_Matchmaking__c=true,MM_Slot_End_Time__c='2:10 PM',MM_slot_StartTime__c='2:00 PM',MM_To_UPE__c=upeBA.id,MM_Slot_Status__c='Accepted');
      insert EventScheduleAccepted ; 
        
      EventSchedule__c EventScheduleMissed = new EventSchedule__c(EV_id__c=eventId,MM_To_EAM__c=eam.id,Is_Matchmaking__c=true,MM_Slot_End_Time__c='2:10 PM',MM_slot_StartTime__c='2:00 PM',MM_To_UPE__c=upeBA.id,MM_Slot_Status__c='Missed');
      insert EventScheduleMissed ;
    
    }
  }