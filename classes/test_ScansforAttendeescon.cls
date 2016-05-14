@istest
public class test_ScansforAttendeescon  {
static testMethod void test_ScansforAttendeescon() {
    
    user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
           
             account acc=new account();
            acc.name='Booth Leads';  
            
            acc.ownerid=uname.createdby.id;          
            insert acc;
           contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;

            Profile p = [select id from profile where name='system Administrator'];

            User u = new User(alias = 'test123', email='test123890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123890@noemail.com');
                  insert u;

                  Id eventAdminId=u.id; 
                  
                  User u1 = new User(alias = 't12345', email='test1238950@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test1238950@noemail.com');
                  insert u1;

                  Id eventAdminId2=u1.id;   

              Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
               insert  customProfileBooth;
    
          Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('12/18/2015'),
                             EV_StartDate__c = Date.Parse('12/18/2015'),
                             MM_Start_Date__c =  Date.Parse('12/18/2015'),
                             MM_End_Date__c=  Date.Parse('12/18/2015'),
                             MM_Firstaday_startTime__c ='09:00 AM',
                             MM_Firstaday_EndTime__c ='11:00 AM',
                             MM_Slot_Timeperiod__c = '30',
                             BreakTime_Between_Appointments__c = '10',
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM',
                             Is_MatchMaking_Event__c = TRUE);
              insert eve;
              Id EventId=eve.Id;
        
        
              AttendeeSummary__c attSummary1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                             AS_Email__c = 'test123890@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
             insert attSummary1 ;
             
             AttendeeSummary__c attSummary2 = new AttendeeSummary__c(AS_FirstName__c = 'unni', AS_LastName__c = 'krishna',
                                             AS_Email__c = 'test1238950@noemail.com', AS_Company__c = 'Global NestLLC', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
             insert attSummary2 ;
             
          Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = eve.id, AS_id__c = attSummary1.id,IsMatchMakingAttendee__c=True,Boothleads_Profile__c='Attendee',checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
             insert EAM1;
             
              Event_Attendee_Mapping__c EAM2 = new Event_Attendee_Mapping__c(EV_id__c = eve.id, AS_id__c = attSummary2.id,Boothleads_Profile__c='Attendee',IsMatchMakingAttendee__c=True,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
             insert EAM2;
             
             
    BoothVisitSummary__c boothVisitSummary= new BoothVisitSummary__c(BVS_LeadRating__c=4.4,Follow_Update__c=datetime.valueOf('2012-05-15 00:00:00'),ScanTime__c=datetime.valueOf('2012-05-15 00:00:00'),BVS_FirstName__c='Scan',BVS_LastName__c='Me',BVS_Email__c='testboothadmin@noemail.com',EA_AttendeeBarcode__c=EAM2.Id,User_id__c=u.Id);
     insert boothVisitSummary;

             ScansforAttendeescon  sfac= new ScansforAttendeescon();

}
}