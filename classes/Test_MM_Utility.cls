@istest
public class Test_MM_Utility
{
      static testmethod void Testmethod_MM_Utility(){
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
        MatchMaking_Type__c = 'SemiOpen',
        MM_End_Date__c = system.Today(),
        MM_Secondaday_startTime__c = '06:00 AM',
        MM_Secondaday_EndTime__c = '06:00 PM',
        Is_MatchMaking_Event__c=true
        );
        insert eve;
         MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('01/18/2014'),
                                                         Slot_Time_period__c = '10',
                                                       Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = eve.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('01/19/2014'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = eve.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays1;
           Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks; 
          AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='testing';
        att.AS_LastName__c ='lastName Testing';
        att.AS_Email__c ='test123t@noemail.com';
        att.AS_Company__c ='global';
        att.Keywords__c = 'Spacecenter, SpaceMaster';
        att.AS_NAICSCode_1__c = '123456';
        att.AS_NAICSCode_2__c = '123455';
        att.AS_NAICSCode_3__c = '123454';
        att.AS_NAICSCode_4__c = '123453';
        att.AS_NAICSCode_5__c = '123452';
        att.GSA_Schedule__c = 'Yes We have';
        att.Business_type__c = 'MBE';
        att.AS_BusinessRevenue__c = 750000;
        att.AS_NumberOfEmployees__c = 75;
        att.AS_Work_States__c = 'Bihar';
        att.Company_Certifications__c = 'MBE';
        att.AS_PrimaryBusinessCategory1__c = 'Accounting';
        att.AS_WorkZip__c = '521478';
        att.AS_CellPhone__c = '7323331589';
         
       insert att;
       
       Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id, isMatchMakingAttendee__c= TRUE, Boothleads_Profile__c='Attendee'); 
         
        insert eam; 
         
       LIST<STring> timigs =  MM_Utility.givesSlotTimings('09:00 AM','09:00 PM', '10', '10');
        
       LIST<EventSchedule__c> eas = MM_Utility.AttshowTimings(eve.Id,eam.ID );
          
        Profile p = [select id from Profile where name='attendee'];
       
        user uname=[select createdby.id from user where profile.Name = 'system Administrator' AND Isactive = true Limit 1];
       
        account acc=new account();
        acc.name='Booth Leads';
        acc.ownerid=uname.id;
        insert acc;
       
        contact con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
        insert con;
       
        user u = new User(alias = 'test123', email='test123t@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',contactId=con.id,
        timezonesidkey='America/Los_Angeles', username='test123t@noemail.com');
        insert u;
        Id attendeeId =u.id; 
        // inserting profile Cus 
        Profile__c attendeeProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='2.0'); 
        insert attendeeProfile; 
        
        // Insert upe for login user 
        User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=Eve.id,Profile_id__c=attendeeProfile.id,Status__c='Active',  User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE'); 
        insert upeEA; 
          
          
        //   MAP<String, EventSchedule__c> eamMap =  MM_Utility.BAshowTimings(eve.Id,upeEA.Id); 
           MM_Utility MM_U =new MM_Utility();    
           MM_Utility.checkLogInservice();
           MM_Utility.checkTime();
           MM_Utility.giveEventTimingsWithDates(eve.id,mdays.MatchLeads_Date__c);
           MM_Utility.attendeeScheduleTimings(eve.id,eam.id);
           MM_Utility.exhibitorScheduleTimings(eve.id,upeEa.id);
           MM_Utility.exhibitorTimings(eve.id,upeEa.id);
           MM_Utility.upeforEventID = upeEa.id;
      }
      
      
      
}