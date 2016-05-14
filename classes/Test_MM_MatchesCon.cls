@isTest
public class Test_MM_MatchesCon {

    public static testMethod void testdoget(){
       user uname=[select createdby.id from user where profile.Name = 'system Administrator' Limit 1];
       account acc=new account();
       acc.name='Booth Leads';
       //acc.ownerid=uname.createdby.id;
       acc.owner=uname.createdby;
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
     User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE');         
     insert upeEA;   
     
     MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = date.valueOf('2013-09-24'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '09:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = eve.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = date.valueOf('2013-09-25'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '10:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = eve.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays1;
             Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks;      
     
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
     
       cookie  counter = new Cookie('counter',EventId,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
     
     
    system.runAs(u){
    
    MM_MatchesCon MMM = new MM_MatchesCon();
    MMM.checkuser();
    MMM.Name='test123';
    List<string> str = new List<string>();
    str.add('Accounting');
    MMM.PrimaryIndustry=str;
    MMM.NAICSCodes1='123456';
    MMM.NAICSCodes2='123456';
    MMM.NAICSCodes3='123456';
    MMM.searchUpe();
   
    PageReference acctPage = page.MM_Matches; 
    Test.setCurrentPage(acctPage );
    
    ApexPages.currentPage().getParameters().put('viewEmail', 'test123Ba@noemail.com');
    try{
    MMM.viewProfile();
    }catch(exception e){}
    ApexPages.currentPage().getParameters().put('selectedEmail', 'test123Ba@noemail.com');
    MMM.eventtimedetails =eve;
    try{
    MMM.showSchedule();
    }catch(exception e){}
     ApexPages.currentPage().getParameters().put('timeValue', '2:00 PM-2:40 PM');
     ApexPages.currentPage().getParameters().put('dateValue', '09/24/2013');
     MMM.Schedules();
    
    MMM.ClosePopup();
    MMM.CloseviewPopup();
    MMM.CloseSuccessPopup21();
    MMM.CloseSuccessPopup();
    MMM.updateComment();
    MMM.ClearAll();
    
     pageReference pg =page.BL_Mobile_summary;
     test.SetCurrentPage(pg);
    Apexpages.currentPage().getParameters().put('id',EventId);     
    BL_Mobile_summary blm = new BL_Mobile_summary();
    
    
    } 
     
        
    
    }
    
    
}