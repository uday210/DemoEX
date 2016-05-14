@istest

public class Test_updateScheduleStatus{

    static testmethod void Testmethod_updateScheduleStatus(){
    
    contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
        insert con;
        
        contact con1 = new contact(firstname='testcontactfn',lastname='testcontactln');
        insert con1;
        Profile p = [select id from profile where name='Standard User'];
        
        // ------------------ Eventadmin Insert ---------------------
        User u = new User(alias = 'test123', email='testboothadmin678@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='testboothadmin678@noemail.com');
        insert u;
        Id eventAdminId=u.id;   
        
        User u1 = new User(alias = 'test123', email='testboothadmin789@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='testboothadmin789@noemail.com');
        insert u1;
        Id eventAdminId1=u1.id;    

        Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
        EV_EndDate__c = system.today()+10,
        EV_StartDate__c = system.today(),
        EV_EndTime__c='06:00 PM',
        StartTime__c='09:00 AM');
        insert eve;
        Id EventId=eve.Id;
        
        AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='buser2@badmin.com';
        att.AS_Company__c ='global';
        insert att;  
        
        Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam;
        
        User_Profile_Event__c upe = new User_Profile_Event__c(Attendee_Summary__c=att.id,EV_id__c=EventId,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true,IsMatchMakingUser__c=true,MAtchMakingProfile__c='Corporate');         
        insert upe; 
        
        EventSchedule__c es= new EventSchedule__c(MM_To_UPE__c= upe.id,MM_Slot_Status__c='Cancelled');
        insert es;
        
        User_Profile_Event__c upe1 = new User_Profile_Event__c(Attendee_Summary__c=att.id,EV_id__c=EventId,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE');         
        insert upe1; 
        EventSchedule__c es1= new EventSchedule__c(MM_To_EAM__c= eam.id,MM_Slot_Status__c='Cancelled');
        insert es1;
    
    }
    }