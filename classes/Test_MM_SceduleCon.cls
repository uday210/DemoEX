@isTest(SeeAlldata=true)
public class Test_MM_SceduleCon {

    public static testMethod void testdoget(){
    
    try{
    PageReference pageRef = new PageReference('partialURL');
    
    
     List<EventSchedule__c> exibitors = new List<EventSchedule__c>();
     Boolean scheduleswithprof = true;
       user uname=[select createdby.id from user where profile.Name = 'system Administrator' AND Isactive= true Limit 1];
       account acc=new account();
       acc.name='Booth Leads';
       acc.ownerid=uname.id;
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
                             MM_Slot_Timeperiod__c='10',
                             MatchMaking_Type__c='Closed'
                            
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
     User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE');         
     insert upeEA;   
     
    
     
     
   // Inserting booth admin 
     contact  con11 = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
       insert con11;
           
       AttendeeSummary__c attforBa = new AttendeeSummary__c();
        attforBa.AS_FirstName__c='re';
        attforBa.AS_LastName__c ='lo';
        attforBa.AS_Email__c ='test123Ba@noemail.com';
        attforBa.AS_Company__c ='global';
        insert attforBa;  
        
        Profile pBa = [select id from Profile where name='Booth Admin'];
        
        user uba = new User(alias = 'test123', email='test123Ba@noemail.com',
                  emailencodingkey='UTF-8',profileid = pBa.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con11.id,
                  timezonesidkey='America/Los_Angeles', username='test123Ba@noemail.com');
                  insert uba ;
        Id BoothAdminId =uba.id;  
      // inserting profile Cus    
      Profile__c baProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
       insert  baProfile;  
       
     // Insert upe for login user  
      User_Profile_Event__c upeBA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=baProfile.id,Status__c='Active',User_id__c=BoothAdminId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='Corporate');         
      insert upeBA; 
      
     // Inserting Event Schedules 
      
      
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
        
          list<Event_Breaks__c>  blokslistexist1 = new list<Event_Breaks__c>();
      
 MatchLeads_Days__c mdays2 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('01/19/2014'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = eve.id,
                                                         MAX_noOf_appontments__c=5);  
       
      

       Event_Breaks__c breaks = new Event_Breaks__c();
       breaks.Name='Thirupathi';
       breaks.Break_End_Time__c='11:20 AM';
       breaks.Break_End_Time__c='12:20 PM';
       breaks.MatchLeads_Days__c=mdays2.Id;
       breaks.Event_Attendee_Mapping__c=eam.Id;
       breaks.User_Profile_Event__c=upeEA.Id;
       insert breaks;
        
        
      cookie  counter = new Cookie('counter',EventId,null,-1,false);
      ApexPages.currentPage().setCookies(new Cookie[]{counter});
     //integer mx_numberapp =integer.valueof(eve.MatchLeads_Days__r[0].MAX_noOf_appontments__c);
      MM_scheduleCon  MMSchedule = new MM_scheduleCon();
       
        
      System.runAS(u){
      
              //-----
        MM_scheduleCon.maptimeWithEvesc m =new MM_scheduleCon.maptimeWithEvesc(null,null);
        
        MM_scheduleCon.addendDateclass ms = new MM_scheduleCon.addendDateclass(null,null,null);
      date dd =  system.today();
      MM_scheduleCon.addendDateclass ms1 = new MM_scheduleCon.addendDateclass(dd,null,null);
        
        PageReference pg = page.MM_Schedule;
          MMSchedule.pdfpage = pg;
          String myString = 'StringToBlob';
          Blob myBlob = Blob.valueof(myString);
          MMSchedule.b = myBlob;
          MMSchedule.scheduleddays1 = 'one';
          MMSchedule.scheduleddays2 = 'two';
          list<string> FinalDaytwoTimings = new  list<string>();
          string sai = 'sai';
          string hello = 'hello';
          FinalDaytwoTimings.add(sai);
          MMSchedule.scheduleswithprof = true;
          MMSchedule.listvals ='sai';
          MMSchedule.listvalsmbe ='heh';
        Test.setCurrentpage(pg);
        Apexpages.currentpage().getParameters().put('selectedEmail','test123Ba@noemail.com');
        
        Apexpages.currentpage().getParameters().put('reshedule',EventSchedulePending.id);
        MMSchedule.ReSheduleTicket();
                
        Apexpages.currentpage().getParameters().put('cancel',EventSchedulePending.id);
        MMSchedule.acceptTicket();
        
        Apexpages.currentpage().getParameters().put('cancel',EventSchedulePending.id);
        MMSchedule.cancelTicket();
        
        Apexpages.currentpage().getParameters().put('cancel',EventSchedulePending.id);
        MMSchedule.rejectTicket();
        
        MMSchedule.checkuser();
        MMSchedule.ClosePopup();
        MMSchedule.PrintAttendeeSchedule();
        MMSchedule.PrintattendeeSchedulewithprofiles();
        MMSchedule.ExportAttendeeSchedule();
       
       MMSchedule.eveshedule=EventSchedulePending;
       Apexpages.currentpage().getParameters().put('timeValue','3:00 PM-3:30 PM');
       Apexpages.currentpage().getParameters().put('dateValue','09/24/2013');  
       MMSchedule.Schedules(); 
       MMSchedule.updateCommentsc();
      
      //   folder f = [select id from folder where name='Booth Leads Templates'];
         
         
        
        
        EmailTemplate e = new EmailTemplate (developerName = 'test', FolderId = userInfo.getUserId(), TemplateType= 'Text', Name = 'MatchMaking MBE Schedule Confirmation Email'); // plus any other fields that you want to set
         insert e;
        
       MMSchedule.updateComment();
       
       
       MMSchedule.CloseviewPopup();
       
       Apexpages.currentpage().getParameters().put('viewEmail','test123Ba@noemail.com');
       MMSchedule.viewProfile();
       MMSchedule.viewcomments();
        MMSchedule.CloseSuccessPopupcomments(); 
       MMSchedule.CloseSuccessPopupsc();
       MMSchedule.CloseSuccessPopup();
       MMSchedule.CloseSuccessPopup21();
       MMSchedule.CheckUser();
       //MMSchedule.Blockedaction();
      //MMSchedule.blockselecteddate = 'a0hZ000000AMLgV';
      
       //MMSchedule.Blockedaction();
        }
      
     
      
  }
   catch(exception e){
  }
  }
 
  
}