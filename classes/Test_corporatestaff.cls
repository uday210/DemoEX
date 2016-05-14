@isTest
public class Test_corporatestaff {

public static testMethod void corporatestaff(){
user uname=[select createdby.id from user where profile.Name Like 'system Administrator' Limit 1];
           
             account acc=new account();
            acc.name='Booth Leads';  
            
            acc.ownerid=uname.createdby.id;          
            insert acc;
   contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;

 Profile p = [select id from profile where name='system Administrator'];

    User u = new User(alias = 'test123', email='testt12389011@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testt12389011@noemail.com');
                  insert u;

                  Id eventAdminId=u.id;   

    Profile__c customProfileBooth= new Profile__c (PR_Name__c='corporatestaff',PR_Version__c='3.0');        
       insert  customProfileBooth;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/19/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM',Is_MatchMaking_Event__c=true);
      insert eve;
      Id EventId=eve.Id;
        
        
          AttendeeSummary__c attSummary1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                             AS_Email__c = 'testt12389011@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
             insert attSummary1 ;
      Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = eve.id, AS_id__c = attSummary1.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
     
    
      User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA; 
        cookie  counter = new Cookie('counter',EventId,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
        system.runAs(u){
      corporatestaff corpstaff = new corporatestaff ();
      corpstaff.selectEvent=counter.getvalue();
      
      }
  
  }
  }