@isTest
public class Test_MM_NewSignupCon{
 static testMethod void Test_MM_NewSignupCon(){

        
        Profile p = [select id,name FROM profile where name='System Administrator'];
        
        User us = new User(alias = 'test1002', email='testmyth@gmail.com',
        emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='testmyth@gmail.com' /*ContactID = c.id*/,CompanyName='gp');
        insert us;
                
        Id eventAdminId=us.id;
        
           Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
      insert  customProfileBooth;

    Profile__c customProfileBooth1= new Profile__c (PR_Name__c='Attendee',PR_Version__c='1.5');        
      insert  customProfileBooth1;
      
Profile__c customProfileBooth2= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
 insert  customProfileBooth2;
         
      Event__c event = new Event__c(EV_Title__c='testEvent',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-05-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-05-11 00:00:00'),Event_Printer__c ='Avery 22806 easy peal square Badges',EventDiversityValues__c='Reception;monday pass');
      
       insert event;
       
       AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
        AS_Email__c = 'testmyth11@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_ImageUrl__c='testurl');
        insert attendee;

          
         
           Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = event.id, AS_id__c = attendee.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer', GuestType__c= 'Attendee',IsMatchMakingAttendee__c=true);
            insert EAM1;
        
             Booth__c booth1 = new Booth__c(BT_Name__c='TestBooth1',BT_BoothUserCount__c=100);
      insert booth1;
      
      User_Profile_Event__c upebooth = new User_Profile_Event__c(BT_id__c=booth1.Id,EV_id__c=event.id,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=us.id,UEP_isActive__c=false,IsMatchMakingUser__c=true,Attendee_Summary__c=attendee.id,BoothAdmin_id__c=us.id) ;         
      insert upebooth; 

      
       
       MM_NewSignupCon testsignin=new MM_NewSignupCon();
       
       Apexpages.currentPage().getPArameters().put('emailvalue',attendee.AS_Email__c);
       testsignin.gtDetails();
       testsignin.loginaction();
     list<Event_Attendee_Mapping__c> emmil = new list<Event_Attendee_Mapping__c>();
      
 
       MM_NewSignupCon.forupdateEAM('mythily','Nagandla','Global Nest','testmyth11@gmail.com',us.id);
      
      Event_Attendee_Mapping__c EAM11 = new Event_Attendee_Mapping__c(EV_id__c = event.id, AS_id__c = attendee.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer', GuestType__c= 'Attendee',IsMatchMakingAttendee__c=true,Boothleads_Profile__c='Booth Admin');
            insert EAM11;
       MM_NewSignupCon.forupdateEAM('mythily','Nagandla','Global Nest','testmyth11@gmail.com',us.id);
       
        Profile p1 = [select id,name FROM profile where name='standard user'];
        
         account a=new account(name='govtnm');
        insert a;
        
         contact c=new contact(lastname='n',accountid = a.id);
        insert c;
        Profile p11 = [select Id,Name FROM profile where name='Event Admin'];
        
        User us1 = new User(alias = 'test12', email='testmyth12@gmail.com',
        emailencodingkey='UTF-8',profileid = p11.Id, lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US',country='United States',
        timezonesidkey='America/Los_Angeles', username='testmyth12@gmail.com' ,ContactID = c.id,isactive=true,isSignup__c=true);
        insert us1;
       Event__c event1 = new Event__c(EV_Title__c='testEvent1',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-06-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-06-11 00:00:00'),Event_Printer__c ='Avery 22806 easy peal square Badges',EventDiversityValues__c='Reception;monday pass');
      
       insert event1;
       
       AttendeeSummary__c attendee1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily11', AS_LastName__c = 'Nagandla11',
        AS_Email__c = 'testmyth111@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_ImageUrl__c='testurl');
        insert attendee1;

          
         
           Event_Attendee_Mapping__c EAM12 = new Event_Attendee_Mapping__c(EV_id__c = event1.id, AS_id__c = attendee.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer', GuestType__c= 'Attendee',IsMatchMakingAttendee__c=true);
            insert EAM12;
        
             Booth__c booth11 = new Booth__c(BT_Name__c='TestBooth11',BT_BoothUserCount__c=100);
      insert booth11;
      
      User_Profile_Event__c upebooth1 = new User_Profile_Event__c(BT_id__c=booth1.Id,EV_id__c=event1.id,EventAdmin_Id__c=us1.id,Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=us.id,UEP_isActive__c=false,IsMatchMakingUser__c=true,Attendee_Summary__c=attendee.id,BoothAdmin_id__c=us1.id) ;         
      insert upebooth1;  
      Profile p3 = [select id,name FROM profile where name='Attendee'];
       account a3=new account(name='booth');
        insert a3;
       
       testsignin.loginuserName=us1.username;
         testsignin.loginuserpassword='12345678';
         testsignin.selectedvalue='jj';
       testsignin.loginPortal();
       upebooth1.EV_id__c='a00F000000BNGQi';
      //MM_NewSignupCon.forupdateEAM1(us1.id);
      testsignin.save();
       testsignin.close();
       testsignin.Loginpage();
       testsignin.gotologin=true;
        testsignin.gtDetails();
       testsignin.existbool=true;
     testsignin.firstName = null;
    
        testsignin.save(); 
    
     testsignin.lastName = null;
       testsignin.save(); 
         testsignin.password = 'ggfffff';
          testsignin.save(); 
      testsignin.gtDetails();
      
      
      }
      
}