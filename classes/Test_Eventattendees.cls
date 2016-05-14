@isTest
public class Test_Eventattendees{ 

static testMethod void myUnitTest() {

Profile p = [select id FROM profile where name='System Administrator'];
User u = new User(alias = 'yyess3je', email='yests2e3je@noemail.com',
emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
localesidkey='en_US',country='United States',
timezonesidkey='America/Los_Angeles', username='yests2e3je@noemail.com');
insert u;


Event__c event = new Event__c(EV_Title__c='testEvent',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-05-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-05-11 00:00:00'),Event_Printer__c ='Avery 22806 easy peal square Badges',EventDiversityValues__c='Reception;monday pass');
insert event;

Event__c event1 = new Event__c(EV_Title__c='testEvent1',EV_HostingTimeZone__c='Eastern Time(USA)',EV_EndDate__c=date.valueOf('2012-05-15 00:00:00'),EV_StartDate__c=date.valueOf('2012-05-11 00:00:00'),Event_Printer__c ='Avery 5392 Name badges',EventDiversityValues__c='Reception;monday pass');
insert event1;


AttendeeSummary__c attendee= new AttendeeSummary__c(AS_FirstName__c='mythily',AS_LastName__c='Nagandla',  
                                             AS_Email__c='mythili2.nagandlae@gmail.com',AS_Company__c='Global Nest', As_Home_Country__c='None',As_Home_State__c='None',As_Shipping_Country__c='None',As_Shipping_States__c='None',AS_NAICSCode1__c=987654,AS_NAICSCode2__c=123456,AS_NAICSCode3__c=898765);
insert attendee;


AttendeeSummary__c attendeefordelete= new AttendeeSummary__c(AS_FirstName__c='mythily',AS_LastName__c='Nagandla',  
                                             AS_Email__c='mythili3.nagandlae@gmail.com',AS_Company__c='Global Nest');
insert attendeefordelete;


AttendeeSummary__c attendeedummy= new AttendeeSummary__c(AS_FirstName__c='myt>hily',AS_LastName__c='Nag,andla',  
                                             AS_Email__c='mythili245.nagandlae@gmail.com',AS_Company__c='Glo"bal Nest');
insert attendeedummy;

AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c=20,AS_BirthDate__c=date.valueOf('1995-05-05'),AS_BlogUrl__c='www.globalnest.com',AS_BusinessDescription__c='fgsdamnabfbhsd',AS_BusinessDunsNumber__c='2450153',
               AS_BusinessEstablishedDate__c=date.valueOf('1995-05-06'),AS_BusinessRevenue__c=324533,AS_BusinessTaxId__c='hngsdvdvf',AS_CellPhone__c='9858590231',
               AS_Company__c='testattendeecompany',AS_DiversityType__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
               AS_Email__c='test12356789@noemail.com',AS_FaxNumber__c='9858985032',AS_FirstName__c='testattendeesummaryfirstname',AS_Gender__c='Male',
               AS_HomeAddress1__c='mjbfnmf',AS_HomeAddress2__c='nbdfhj',AS_HomeCity__c='mhsdfgfd',As_Home_Country__c='India',AS_HomePhone__c='6998878422',
               AS_HomePoBox__c=22125,AS_HomePoboxNo__c='84367',As_Home_State__c='Goa',AS_HomeZipcode__c=32121,AS_ImageUrl__c='www.globalnest.com',AS_LastName__c='testattendeelastname',AS_NAICSCode1__c=524621,
               AS_NAICSCode2__c=524421,AS_NAICSCode3__c=524671,AS_NAICSCode4__c=523621,AS_NAICSCode5__c=528921,AS_NumberOfEmployees__c=200,AS_prefixNew__c='mr',
               AS_PrimaryBusinessCategory1__c='Accounting',AS_SecondaryBusinessCategory1__c='Animation',AS_ShippingAddress1__c='dfdf',AS_ShippingAddress2__c='dsyhg',
               AS_ShippingCity__c='asfdsf',As_Shipping_Country__c='India',AS_ShippingPhone__c='3554353132',AS_ShippingPoBox__c=32224,AS_Shippingpoboxno__c='35521',As_Shipping_States__c='Goa',
               AS_shippingzip__c='32122',AS_ShippingZipcode__c=89524,AS_SuffixNew__c='dr',AS_ThroughEventBrite__c=true,AS_Title__c='hmjnhgh',AS_WebsiteUrl__c='hasdas.com',AS_WorkAddress1__c='dsag',
               AS_WorkAddress2__c='fdwe',AS_WorkCity__c='ewqrwd',AS_Work_Country__c='India',AS_WorkPhone__c='3554353132',AS_WorkPoBox__c=52346,AS_Workpoboxno__c='85231',AS_Work_States__c='Goa',AS_WorkZipCode__c=85246,AS_WorkZip__c='89523',
               Registration_type__c='kdsmkas');
   insert att; 

Event_Attendee_Mapping__c EAM=new Event_Attendee_Mapping__c(EV_id__c=event.id,AS_id__c=attendee.id,DiversityType__c='xxxxxxx',TicketTypes__c='Reception',EA_AttendeeBarcode__c='a0nvwsdwkde',EA_isBadgePrinted__c=true,IsPrifileUpdate__c=true);
insert EAM;

Event_Attendee_Mapping__c EAM1=new Event_Attendee_Mapping__c(EV_id__c=event1.id,AS_id__c=att.id,DiversityType__c='xxxxxxx',TicketTypes__c='Reception',EA_AttendeeBarcode__c='a0nvwsdwkde',EA_isBadgePrinted__c=true,IsPrifileUpdate__c=true);
insert EAM1;
List<Event_Attendee_Mapping__c> listOfEvent = new List<Event_Attendee_Mapping__c>();
listOfEvent.add(EAM);
List<Event_Attendee_Mapping__c> listOfEvent1 = new List<Event_Attendee_Mapping__c>();
listOfEvent1.add(EAM1);

SecurityControls__c sc = new SecurityControls__c(EV_Req_Fields__c= 'AS_FirstName__c,AS_LastName__c',EV_Fields__c='AS_FirstName__c,AS_LastName__c' , EV_id__c=event.id);

insert sc;

List<id> listid =new List<id>();
listid.add(EAM.id);

List<id> listid1 =new List<id>();
listid.add(EAM1.id);
system.runAs(u){

Eventattendees testCon = new Eventattendees();
testCon.userId =u.id;
//string[] ss1 =listid;

testCon.eventName1=EAM.id;
testCon.eventName1=EAM1.id;
testcon.eventSelected=event.id;



testCon.escapeSpecialCharacters('my>th#ly/');
testCon.escapeSpecialCharacters('my"thly/');
testCon.escapeSpecialCharacters('my<thly/');
testCon.escapeSpecialCharacters('my.thly/');

testCon.CreateAttendee();
testCon.backaction();
testCon.getfields();
 


ApexPages.currentPage().getParameters().put('alphabit', 'T');
testCon.alphasorting();
testcon.changingprintstatus();

testcon.changeemailstatus();
testcon.changingemailstatus();
testcon.changestatus();
testcon.getemailstatus();
testcon.getprintingstatus();
testCon.popup();
testCon.getvalues();
testcon.saveandprint();
testCon.attid=listid;

testCon.checkUserId();

testCon.attendeedetail();

testCon.ImportAttendee();

testCon.ImportAttendee();
testCon.ProfileSettings();
testCon.escapeSpecialCharacters('phani"kumar<c.,\\h');
testCon.attid=listid;
testCon.genpdf();



testCon.editAttendee();


testCon.eventIdVar=attendee.id;
testcon.saveandprintforedit();

testCon.UpdateAttendee();
AttendeeSummary__c  UpdateAttendee = new AttendeeSummary__c();

testCon.getselect();
//testCon.selectedvalues ='Avery 22806 easy peal square Badges';
testCon.genpdf();
testCon.deleteAdminRecord();
testCon.deleteallattendees();
//testCon.attbadge();
testCon.escape('mythi,ly');
testcon.exportAll();
testCon.cancel();
testCon.serarchstringvalue ='mythily';
testCon.search();

//testCon.CheckDuplicate(attendee.id);
testCon.ShowPreviousList();
//testCon.singledymobadge();

PageReference pp = page.qrcode_eventadmin_attendees;
Test.setCurrentPage(pp);





AttendeeSummary__c  newAttendee = new AttendeeSummary__c();

 newAttendee.AS_Email__c='adminteste@gmail.com';
 newAttendee.AS_LastName__c='Admin';
 newAttendee.AS_FirstName__c='BoothLeads';
 testCon.newAttendee = newAttendee;
  
 testCon.SaveAttendee();
 testcon.getcolors();
 testcon.getface();
 testcon.printfromsaveandprint();
 


newAttendee = new AttendeeSummary__c();
 newAttendee.AS_Email__c='mythili.nagandlae@gmail.com';
 newAttendee.AS_LastName__c='mythily';
 newAttendee.AS_FirstName__c='Nagandla';
 testCon.newAttendee =newAttendee;
 
 testCon.SaveAttendee();
 testcon.emailbadge();
 testcon.selectedprint();
 testcon.profileUpdateNotification();
 testcon.desiredTemplate(); 
 testcon.PrintBadge1();
 testCon.allrecords=true;
 //testcon.PrintBadge();
 
 testcon.eventSelected=event1.id;

 
 testCon.SaveAttendee();
 testcon.emailbadge();
 testcon.selectedprint();
 testcon.profileUpdateNotification();
 
 testcon.PrintBadge1();
 testCon.allrecords=true;
 
 testcon.eventselected =event1.id;
 testcon.selectedvalues = 'Avery 5392 Name badges';
 
 testcon.desiredTemplate(); 
 
 
 testcon.eventselected =event.id;
 testcon.selectedvalues = 'Avery 5392 Name badges';
  testcon.desiredTemplate(); 
  
  testcon.eventselected =event1.id;
  testcon.selectedvalues = 'Avery 22806 easy peal square Badges';
  testcon.desiredTemplate(); 
  
    testcon.eventselected =event1.id;
  testcon.selectedvalues = 'Dymo Label(30856,Single Label)';
  testcon.desiredTemplate(); 
  
  testcon.eventselected =event1.id;
  testcon.selectedvalues = 'Zebra Label';
  testcon.desiredTemplate(); 
  
  Test.startTest();
  testcon.eventname1 =EAM.Id+','+'Not Printed';
   testcon.pristatus();
   //testcon.status();
   
    testcon.eventname1 =EAM.Id+','+'Not Sent';
 //  testcon.prostatus();
 //testcon.PrintBadge();
 Test.stopTest();
}

}
}