@isTest
public class Test_MM_BA_MatchesCon {

    public static testMethod void testdoget(){
        user uname=[select createdby.id from user where IsActive = True And profile.Name = 'system Administrator' Limit 1];
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
        MatchMaking_Type__c = 'Closed'
        );
        insert eve;
        Id EventId=eve.Id;
        
        // Login user 
        contact con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
        insert con;
        
        AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='testing';
        att.AS_LastName__c ='lastName Testing';
        att.AS_Email__c ='test123t@noemail.com';
        att.AS_Company__c ='global';
        att.Keywords__c = 'Spacecenter, SpaceMaster';
        att.AS_FirstName__c = 'test';
        att.AS_LastName__c = 'Testing';
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
        
        Profile p = [select id from Profile where name='attendee'];
        
        user u= new User(alias = 'test123', email='test123t@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',contactId=con.id,
        timezonesidkey='America/Los_Angeles', username='test123t@noemail.com');
        insert u;
        Id attendeeId =u.id; 
        // inserting profile Cus 
        Profile__c attendeeProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='2.0'); 
        insert attendeeProfile; 
        
        // Insert upe for login user 
        User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=attendeeProfile.id,Status__c='Active',  User_id__c=attendeeId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE'); 
        insert upeEA; 
        
        
        
        
        // Inserting booth admin 
        contact con11 = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
        insert con11;
        
        AttendeeSummary__c attforBa = new AttendeeSummary__c();
        attforBa.AS_FirstName__c='re';
        attforBa.AS_LastName__c ='lo';
        attforBa.AS_Email__c ='test123Ba@noemail.com';
        attforBa.AS_Company__c ='global';
        attforBa.AS_NAICSCode_1__c = '123456';
        attforBa.AS_NAICSCode_2__c = '123455';
        attforBa.AS_NAICSCode_3__c = '123454';
        attforBa.AS_NAICSCode_4__c = '123453';
        attforBa.AS_NAICSCode_5__c = '123452';
        
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
        insert baProfile; 
        
        // Insert upe for login user 
        User_Profile_Event__c upeBA= new User_Profile_Event__c (EV_id__c=EventId,Profile_id__c=baProfile.id,Status__c='Active',BoothAdmin_id__c=BoothAdminId, User_id__c=BoothAdminId,UEP_isActive__c=false,IsMatchMakingUser__c=true,MAtchMakingProfile__c='Corporate'); 
        insert upeBA;
        
        cookie  counter = new Cookie('counter',EventId,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter});
     
        system.runAs(uba){
            MM_BA_Matches mmM = new MM_BA_Matches();
            mmm.selectedEvent= counter.getValue();
            mmm.checkuser();
            mmm.BAkeywords = 'Spacecenter';
            mmm.attName = 'test';
            mmm.companyName = 'las';
            mmm.NaicsCode1 = '123456';
            mmm.NaicsCode2 = '123454';
            mmm.NaicsCode3 = '123452';
            mmm.GSASchedule = 'YES';
            mmm.SelectedBusinessTypes.add('MBE');
            mmm.SelectedRevenueAmount.add('(AS_BusinessRevenue__c > 500000 AND AS_BusinessRevenue__c <= 1000000)');
            mmm.SelectednoOfEmployees.add('(AS_NumberOfEmployees__c > 50 AND AS_NumberOfEmployees__c <= 100)');
            mmm.Selectedstatess.add('Bihar');
            mmm.SelectedcompanyCertificationss.add('CMM');
            mmm.SelectedprimaryBusinesscategories.add('Accounting');
           // mmm.SelectedmatchedPeers.add(
            mmm.zipCode = 521478;
            mmm.phoneArea = '732';   
            
            mmm.SearchAttendees();
            LIST<ID> AttIds = new LIST<ID>();
            mmm.EventScheduleShow(AttIds);
            
            
            apexpages.currentpage().getparameters().put('viewProfileId', eam.id);
            mmm.viewProfile();
               apexpages.currentpage().getparameters().Put('viewScheduleId', eam.id); 
               mmm.viewSchedule();
              // mmm.bookedSchedule();
               mmm.cancelAll();
                   apexpages.currentpage().getparameters().put('scheduleTime', '09:00 AM - 09-20 AM');
                   apexpages.currentpage().getparameters().put('scheduleDate', String.valueOf(system.Today()));
               mmm.schedules();
               mmm.makeSchedule();
               mmm.cancel();
               mmm.dummy();
               
        }    
        
        
        
    
    
    
    }
    
}