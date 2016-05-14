@isTest
private class Test_CreateUPECon {

static testMethod void TestMethod_CreateUPECon() {
     Profile p = [select id FROM profile where name = 'System Administrator'];
     
     User u = new User(alias = 'test123', email = 'testmanasa@gmail.com',
         emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'Testing', languagelocalekey = 'en_US',
         localesidkey = 'en_US', country = 'United States',
         timezonesidkey = 'America/Los_Angeles', username = 'testmanasa@gmail.com');
     insert u;
     
     Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass');
     insert event;
     
     AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
         AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',
         AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
         AS_Email__c = 'testmanasa@gmail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
         AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',
         AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode1__c = 524621,
         AS_NAICSCode2__c = 524421, AS_NAICSCode3__c = 524671, AS_NAICSCode4__c = 523621, AS_NAICSCode5__c = 528921, AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',
         AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',
         AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
         AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',
         AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',
         Registration_type__c = 'kdsmkas');
     insert att;
     
     Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = att.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM;
     
     Profile__c ProfileId=new Profile__c();
     ProfileId.PR_Name__c='BoothAdmin';
     ProfileId.PR_Version__c='3.0';
                                        
     insert ProfileId;
     
     Booth__c CreateBooth= new Booth__c ();
     CreateBooth.BT_Name__c=EAM.AS_id__r.AS_Company__c;
     CreateBooth.EV_id__c=event.id;
     CreateBooth.BT_BoothUserCount__c=100;
     CreateBooth.BT_isBoothActive__c=true;
     
     insert CreateBooth;  
     
     User_Profile_Event__c CreateUPE1= new User_Profile_Event__c ();
    /* 
     //CreateUPE1.BT_id__c=CreateBooth.id;
     CreateUPE1.EV_id__c=event.id;
     CreateUPE1.UEP_isActive__c=true;
     CreateUPE1.Status__c='Active';
     CreateUPE1.IsBoothPersonnel__c=true;
     CreateUPE1.Profile_id__c=ProfileId.id;
     CreateUPE1.Attendee_Summary__c=EAM.AS_id__c;
     CreateUPE1.EventAdmin_Id__c=event.ownerid ;
     CreateUPE1.OwnerId=event.ownerid;
     Database.insert(CreateUPE1);
       */            
     ApexPages.currentPage().getParameters().put('id', event.Id);
     CreateUPECon upe= new CreateUPECon();
     upe.DisplayBoothAdmins();
     upe.EAMId=EAM.id;
     upe.UPECreation();
     //upe.UPEBoothId=CreateUPE1.id;
     //upe.BoothCreation();
     }
     }