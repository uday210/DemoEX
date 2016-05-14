@isTest
public with sharing class Test_AS_EventDetails{

static testMethod void TestMethod_AS_EventDetails(){
Profile p = [select id FROM profile where name = 'System Administrator'];

account a=new account(name='govtnm');
insert a;

contact c=new contact(lastname='n',accountid = a.id);
insert c;

Profile p1 = [select Id,Name FROM profile where name='Event Admin'];

/*
string pwd;
try{
System.ResetPasswordResult rt= system.ResetPassword(us.id,true);
us.password__c =rt.getPassword();
pwd = rt.getPassword();
update us;
}catch(exception e){}

*/

Profile__c profilec= new Profile__c(PR_Name__c ='Attendee');
insert profilec;

Profile__c profilecus = new Profile__c(PR_Name__c ='EventAdmin');
insert profilecus;


User u = new User(ScanAttendee_User__c = TRUE, alias = 'test123', email = 'testmyth@gmail.com',emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'Testing', languagelocalekey = 'en_US',localesidkey = 'en_US', country = 'United States',timezonesidkey = 'America/Los_Angeles', username = 'testmyth@gmail.com',Password__c='1',isactive=true);
insert u;


Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',ownerid=u.id,isActive__c=true);
insert event;

Event__c event1 = new Event__c(EV_Title__c = 'testEvent1', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 5392 Name badges', EventDiversityValues__c = 'Reception;monday pass',isActive__c=true);
insert event1;




test.StartTest();
AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
AS_Email__c = 'testmyth@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_ImageUrl__c='testurl');
insert attendee;

User_Profile_Event__c upe= new User_Profile_Event__c();
      
      upe.Attendee_Summary__c= attendee.id;
      upe.EV_id__c= event.id;
      upe.EventAdmin_Id__c = U.Id;
      upe.UEP_isActive__c= TRUE;
      upe.Profile_id__c=profilecus.Id;
      upe.User_id__c= U.Id;
      
      insert upe;
      
AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',AS_Email__c = 'testscan456@noemail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode_1__c = '524621',AS_NAICSCode_2__c = '524421', AS_NAICSCode_3__c = '524671', AS_NAICSCode_4__c = '523621', AS_NAICSCode_5__c = '528921', AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',Registration_type__c = 'kdsmkas');
insert att;

AttendeeSummary__c atte = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',AS_Email__c = 'testscan123963@noemail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode_1__c = '524621',AS_NAICSCode_2__c = '524421', AS_NAICSCode_3__c = '524671', AS_NAICSCode_4__c = '523621', AS_NAICSCode_5__c = '528921', AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',Registration_type__c = 'kdsmkas');
insert atte;


Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = event.id, AS_id__c = attendee.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer', GuestType__c= 'Attendee');
insert EAM1;

Event_Attendee_Mapping__c EAM2 = new Event_Attendee_Mapping__c(EV_id__c = event.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer', GuestType__c= 'Attendee');
insert EAM2;

SecurityControls__c sc = new SecurityControls__c(EV_Req_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_id__c = event.id);
insert sc;

//Adding Ticket
TicketTypes__c tckt=new TicketTypes__c(TT_Name__c='Test Ticket',EV_id__c=Event.ID,TT_Available__c=100,TT_Amount__c=200,TT_TicketType__c='Paid');
insert tckt;


//Adding Item
Item__c itm=new Item__c();
itm.Event__c=Event.ID ;
itm.Item_name__c='Test Item';
itm.Cost__c=50;
itm.Item_Quantity__c=2;
itm.isTaxable__c=true;
itm.Sales_Tax__c=2.0;
itm.Sold_Quantity__c=1;
insert itm;

//Adding PaymentInfo
Constomer__c cust=new Constomer__c(Customer_Name__c=att.AS_FirstName__c,Email__c=att.AS_Email__c,Total_Amount__c=1000);
insert cust;
system.debug(' CUSTOMER IDSSSSSS  '+ cust);
Dummay__c dm=new Dummay__c(First_Name__c=att.AS_FirstName__c,Last_Name__c=att.AS_LastName__c,Email__c=att.AS_Email__c,TicketTypes__c=tckt.id,Event__c=Event.ID,
TicketAmount__c=200,Payment_Status__c='Paid',Payment_Type__c='Cash',Tickets_Quantty__c=2,Check_number__c='1',Seat_Number__c='1',Promocode__c='1',customer_key__c=cust.id,AttendeeSummary__c=att.id,Event_Attendee_Mapping__c=EAM2.id);
insert dm;

Dummay__c dm1=new Dummay__c(First_Name__c=att.AS_FirstName__c,Last_Name__c=att.AS_LastName__c,Email__c=att.AS_Email__c,Item__c=itm.id,Event__c=Event.ID,
TicketAmount__c=200,Payment_Status__c='Paid',Payment_Type__c='Cash',Item_Quantity__c=1,Check_number__c='1',Seat_Number__c='1',Promocode__c='1',customer_key__c=cust.id,AttendeeSummary__c=att.id,Event_Attendee_Mapping__c=EAM2.id);
insert dm1;

test.StopTest();

Individual_Ticket_Info__c iti = new Individual_Ticket_Info__c(Registration_Info__c=dm.id,Seat__c='A1',IsCheckedIn__c=true,Scanned_by__c=u.id);
insert iti;

Individual_Ticket_Info__c iti1 = new Individual_Ticket_Info__c(Registration_Info__c=dm.id,Seat__c='B1',IsCheckedIn__c=true,Scanned_by__c=u.id,isCancelled__c=true);
insert iti1;

Individual_Ticket_Info__c iti2 = new Individual_Ticket_Info__c(Registration_Info__c=dm1.id,isItem__c=true);
insert iti2;


system.runAs(u) {

RestRequest req = new RestRequest();
RestResponse res = new RestResponse();

//calling AS_EventDetails Service
req.requestURI = '/services/apexrest/AS_EventDetails';
req.addParameter('EventID', event.id);
req.addParameter('LoginUserId', u.id);
req.addParameter('EventID', event.id);
req.addParameter('DeviceType', 'Iphone');
req.httpMethod = 'GET';
RestContext.request = req;
RestContext.response = res;
AS_EventDetails.doGet();
req.addParameter('EventID', event1.id);
req.httpMethod = 'GET';
RestContext.request = req;
RestContext.response = res;
AS_EventDetails.doGet();

}
}
}