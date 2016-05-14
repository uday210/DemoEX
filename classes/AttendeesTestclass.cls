@isTest
private class AttendeesTestclass {

static testMethod void myUnitTest() {
     Profile p = [select id FROM profile where name = 'System Administrator'];
     
     
     
     Profile__c profilec= new Profile__c(PR_Name__c ='Attendee');
     insert profilec;
     
     Profile__c profilecus = new Profile__c(PR_Name__c ='BoothAdmin');
     insert profilecus;
     test.startTest();
     User u = new User(alias = 'test123', email = 'testmyth@gmail.com',
         emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'Testing', languagelocalekey = 'en_US',
         localesidkey = 'en_US', country = 'United States',
         timezonesidkey = 'America/Los_Angeles', username = 'testmyth@gmail.com');
     insert u;
     
     Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass');
     insert event;
     
     //insert badge style
     BadgeTemplate_Styles__c btstyle=new BadgeTemplate_Styles__c();
     btstyle.name='badge1';
     btstyle.BadgeName__c='{"name":"badge1","width":360,"height":288,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCAEqAXIDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC1LIsSbmzj2qH7bF/tflS33/HufqKgtbeOWIs2c5xwaAJvtsX+1+VH22L/AGvyo+xw+/50fY4ff86AD7bF/tflUsUyzAlM8etVri1jjhZlzke9O0//AFb/AFoAsu4jQs3QU2KZZgSmePWm3R/0d/pVCGd4gQmOfUUAXmu4lYqd2QcdKfFMk2dmePWs6MebcDf/ABHnFaEMKRZ2Z59TQA17uJHKnOR7U37bF/tflVV1D3pU9C2KtfYof9r86AD7bF/tflR9ti/2vyo+xw+/50fYof8Aa/OgBReRMwA3ZPHSrFZboI7ravQMK1KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoo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C7ccetWKKAIVjYW3l8Z24plrbvCzFiOR2qzRQBTktXa58wEYyDVyiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigCs/32+tFD/fb60UAWaKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigCs/wB9vrRQ/wB9vrRQBZooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAGPKkZ+YkfgaQzIBk7gB/sH/CmXf+qH+8Kf5sZIUMrE8YBzQA8HIzS1EzlJETaNrcA5pTIRMqFRhhwc0AAmQy+WDlh19qBMhl8sHLDr7Uw/8AH6v+5/Wg/wDH6v8Auf1oAmJwM01JUdiqn5h1BGKfVaWNjI0kf31xj39qAJ3dUGWzj2BNKrBhkZx7jFReaJbZmHocj0p8kmwDjJY4AoAfRUSykyFHXDAZ4Ocimi4LhtkTEg4weKAJ6Kg+0ExB0jLDvzjH+NSeYCqsOd3QUAPoqISnzPLdQpIyMHIP8qloAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAKz/fb60UP99vrRQBZooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAILs4iX/AHhUxAOPbmkaNGOWRSfUilVQowoAHoBQBDcELJCzHADdfwpskqfaYiDkcjI5qwyhhhgCPQ0BQMYA44FAEJ/4/V/3P60H/j9X/c/rUhjQtuKLn1xQY0Lbii59cUAPpin94/4U+mCONTlUUH1AoAr3CNEWkjHysMMP61LM2GjUAZY8MR0/+vUpGRg9KGVWGGAI9CKAKwKre4LZOzHJ70+D/WTf79ShFGMKOBgcUgijHSNRn2oAig/49W/4FUZwIIHYbkH3hjNWfKjwRsXB7YpVRVBCqAD2AoAjTySw8tUJ9VA4qamqqoMKoUewp1ABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBWf77fWih/vt9aKALNFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBWf77fWih/vt9aKALNFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFMZn3YVQRjqTj+hpiSyPuwi/Kcfe/8ArUATUVHuc7CFGD97PapKACio53aOIsoBx608cgGgBaKKKACikUhlBHQ0juqKWY4AoAdRUYeQjIjGPQtz/LH606N965wRzjBoAdRRSbhuK9wM0ALRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBWf77fWih/vt9aKALNFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFQ23/LT/AHzUpzjgAn3qKFJELbguGJPB/wDrUAEu4TRYY4JwR2pV/eu4JICnAAOP5USo7OhULhTnk/8A1qa0ciyM8LL83UN0oASVXW0cO24jofalXE2CGYBeCASM0skbvCy5Us3UngD+dIY5A6ugUNjDDPB/SgBWYtIyBXIUD7px/UGmbXMMqyBtoGVyef0NPeOTeJIyoYjDA9DTgjFGDkbmGOOgoAS3UCFcZ5A6nNMueZIQehapIlZUCtjgY4pZYxKm08dwfSgB9RyAiM7GCnuTQPNAwQje+SP0x/WkljZ48BhuyDz0oAYG2zxhC+1s53E8/nRGg+0y9eMHqacySNIj/INueMn+f/1qUIyzM4xhgM+oxQBGGaVC22TnOCrAAfr/ADpWaQRR7/lJOGIpRHLGxETLsJzhu1LKrbVRSpYnJDDg0AIu4XBQO2wDOM5/nzRH+/QuWYZJAwcYojEsZAZYgpP8GRSpG8RITaUJyATjFAEbSO1q5LEMhwSOM1J5TMCTK2WHY4waR4T5BjTBLdSeP8alXO0bgAfY0AQo262xlt+dp5Oc/wCeanAwAOePWolj/wBIZgeMZx7/AP6qmoAKKKKACiiigAooooAKKKKACiiigAooooArP99vrRQ/32+tFAFmiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigApjxhyDkhh0Ip9FADVUg5LM31x/TFOoooAKa671K5Iz3BwadRQA1FCLgZPuTyadRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBWf77fWih/vt9aKALNFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBWf77fWih/vt9aKALNFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAVFcj9yzAsCBxg4qWobggwSAEEgdKAHphIwST9Sc0LIrNtBOfQjB/WopSVeDP3c8/XHFLOCZISv3t36d6AEj2xzy8nt6k/41Mjq65U5FRx/8fMp+lEQ/fSkfdyPz70ASOu7AyQM84OKh2/6Ts3Pt2ZxvPr9asVD/AMvn/AP60AEgRImEjkK3qcmh5gjIgDEHvgniluf+Pd/pTX/1tv8Aj/KgAIH2tCM8qetSNKi5yTx1wCcUxv8Aj6T/AHTTIAXQjzGBBO4cf4UAWAQRkcilpkKqsYVSSB0Jp9ABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAVn++31oof77fWigCzRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFM8pN+/b8x689afRQAjKrqVYZB7Uioq8jOfUnP86dRQAxokZtxBDeoJH8qcAFGAMClooAKj8lN+/DbvXcf8akooAa6LIu1skfXFIYkKgEH5enJyPx60+igBnlJvD4O4f7RpHgidtzICakooATpS0UUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBWf77fWih/vt9aKALNFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEtFRZPqaMn1NAEb/AH2+tFRsTuPPeigD/9k="},';
     btstyle.Event__c=event.id;
     btstyle.FirstRowElement__c='[{"id":"cqrcd","height":125,"width":125,"positionTop":0,"positionLeft":0,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","qrUrlResult":"url(https://boothleads-boothleads.cs11.force.com/resource/1403783597000/qrcodelogoimage)"}]';
     btstyle.SecondElement__c='[{"id":"cfulln","height":31,"width":349,"line-height":31,"position":"absolute","positionTop":144,"positionLeft":13,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"28px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Full Name","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
     btstyle.ThirdElement__c='[{"id":"cticketn","height":40,"width":224,"line-height":40,"position":"absolute","positionTop":36,"positionLeft":138,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"37px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Ticket Name","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
     btstyle.FourthElement__c='[{"id":"cticketCategory","height":42,"width":352,"line-height":42,"position":"absolute","positionTop":192,"positionLeft":5,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"26px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Ticket Category","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
     btstyle.FifthElement__c='[{"id":"cjobTitle","height":42,"width":352,"line-height":42,"position":"absolute","positionTop":245,"positionLeft":5,"marginTop":"0px","marginRight":"0px","marginBottom":"0px","marginLeft":"0px","paddingTop":"0px","paddingRight":"0px","paddingBottom":"0px","paddingLeft":"1px","textAlign":"center","fontSize":"26px","fontFamily":"\'Times New Roman\'","textTransform":"none","contentText":"Job Title","backgroundColor":"rgb(255,255,255)","opacity":"1","textColor":"rgb(0,0,0)","white-space":"nowrap"}]';
     insert btstyle;
     Event__c event1 = new Event__c(EV_Title__c = 'testEvent1', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 5392 Name badges', EventDiversityValues__c = 'Reception;monday pass');
     insert event1;
     AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'testmyth@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
     insert attendee;
     
     AttendeeSummary__c attendeefordelete = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'mythili3.nagandla@gmail.com', AS_Company__c = 'Global Nest');
     insert attendeefordelete;
     
     AttendeeSummary__c attendeedummy = new AttendeeSummary__c(AS_FirstName__c = 'myt>hily', AS_LastName__c = 'Nag,andla',
         AS_Email__c = 'mythili245.nagandla@gmail.com', AS_Company__c = 'Glo"bal Nest');
     insert attendeedummy;
     
     AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
         AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',
         AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
         AS_Email__c = 'test12356789@noemail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
         AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',
         AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode_1__c = '524621',
         AS_NAICSCode_2__c = '524421', AS_NAICSCode_3__c = '524671', AS_NAICSCode_4__c = '523621', AS_NAICSCode_5__c = '528921', AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',
         AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',
         AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
         AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',
         AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',
         Registration_type__c = 'kdsmkas');
     insert att;
 
     Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = attendee.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM;
     
     Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = event1.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
     
     List < Event_Attendee_Mapping__c > listOfEvent = new List < Event_Attendee_Mapping__c > ();
     listOfEvent.add(EAM);
     
     List < Event_Attendee_Mapping__c > listOfEvent1 = new List < Event_Attendee_Mapping__c > ();
     listOfEvent1.add(EAM1);
    test.stopTest();  
     SecurityControls__c sc = new SecurityControls__c(EV_Req_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_id__c = event.id);
     insert sc;
     
     List < id > listid = new List < id > ();
     listid.add(EAM.id);
     
     List < id > listid1 = new List < id > ();
     listid.add(EAM1.id);
     
     User_Profile_Event__c UPE = new User_Profile_Event__c (EV_id__c=event.id,User_id__c=u.id);
     
     system.runAs(u) {
     
        BL_EventAdmin_AttendeesCon testCon = new BL_EventAdmin_AttendeesCon();
 
         testCon.eventSelected = event.id;
         
         testCon.userId = u.id;
         //string[] ss1 =listid;
         testCon.eventName1 = EAM.id;
         testCon.eventName1 = EAM1.id;
         testcon.eventSelected = event.id;
         testCon.escapeSpecialCharacters('my>th#ly/');
         testCon.escapeSpecialCharacters('my"thly/');
         testCon.escapeSpecialCharacters('my<thly/');
         testCon.escapeSpecialCharacters('my.thly/');
         testCon.getevents();
         testCon.CreateAttendee();
         testCon.backaction();
         testCon.getfields();
         ApexPages.currentPage().getParameters().put('alphabit', 'T');
         testCon.alphasorting();
         testcon.statusvalue  = 'Printed';      
         testcon.event1=EAM;
         testcon.changingprintstatus();
         testCon.attendeeid = eam.id;
         testcon.getprintingstatus();
         testcon.statusvalue  = 'Not Printed';
         testcon.changingprintstatus();
               
         testcon.getemailstatus();
         testCon.attendeeid = eam.id;      
         testcon.getprintingstatus();       
         testCon.popup();
         testCon.getvalues();
         testcon.saveandprint();
         testCon.attid = listid;
         testCon.checkUserId();
         testCon.mycheck=eam.id;
         testCon.attendeedetail();
         testCon.ImportAttendee();
         
         testCon.ProfileSettings();
         testCon.escapeSpecialCharacters('phani"kumar<c.,\\h');
         testCon.attid = listid;
         testCon.selectedbdtemname='badge1';
         testCon.genpdf();
         ApexPages.currentPage().getParameters().put('mycheck',EAM.id );
         testCon.editAttendee();
         testCon.eventIdVar = attendee.id;
         testcon.saveandprintforedit();       
          
         testCon.EventAttendee_Email =EAM;
         testCon.UpdateAttendee();
         testCon.eventselected=null;
         
         testCon.UpdateAttendee();
         testCon.eventselected=event.id;
         testCon.newattendee.AS_Email__c='donthave@gmail.com';
         testCon.UpdateAttendee();
         AttendeeSummary__c UpdateAttendee = new AttendeeSummary__c();
         
         testCon.selectedvalues ='Avery 22806 easy peal square Badges';
         testCon.genpdf();
         //testCon.deleteAdminRecord();
         testCon.deleteallattendees();
         //testCon.attbadge();
         testCon.escape('mythi,ly');
         testcon.exportAll();
         testCon.cancel();
         testCon.serarchstringvalue = 'mythily';
         testCon.search();
         //testCon.CheckDuplicate(attendee.id);
         testCon.ShowPreviousList();
         //testCon.singledymobadge();
         PageReference pp = page.bl_eventadmin_attendees;
         Test.setCurrentPage(pp);
         AttendeeSummary__c newAttendee = new AttendeeSummary__c();
         newAttendee.AS_Email__c = 'admintest@gmail.com';
         newAttendee.AS_LastName__c = 'Admin';
         newAttendee.AS_FirstName__c = 'BoothLeads';
         testCon.newAttendee = newAttendee;
        // test.startTest();
         //testCon.SaveAttendee();
         //test.stopTest();
         testcon.getcolors();
         testcon.getface();
         //testcon.printfromsaveandprint();
      
       
         newAttendee = new AttendeeSummary__c();
         newAttendee.AS_Email__c = 'mythili.nagandla@gmail.com';
         newAttendee.AS_LastName__c = 'mythily';
         newAttendee.AS_FirstName__c = 'Nagandla';
         testCon.newAttendee = newAttendee;
        // testCon.SaveAttendee();
           
         testcon.emailbadge();
         testcon.selectedvalues = 'Avery 5392 Name badges';
         testcon.selfieldvalue = 'AS_FirstName__c';
         testcon.selectedcolor = 'Black';
         testcon.selectedsize = '32pt';
         testcon.selectedfaceFir = 'Times New Roman';
         testcon.selLvalue = 'AS_LastName__c';
         testcon.selectedcolorS = 'Black';
         testcon.selectedsizeS = '24pt';
         testcon.selectedfaceSec = 'Times New Roman';
         testcon.selTvalue = 'AS_Company__c';
         testcon.selectedcolorT = 'Black';
         testcon.selectedsizeT = '18pt';
         testcon.selectedfaceThr = 'Times New Roman';
                
         //testcon.selectedprint();
         
         testcon.selectedvalues = 'Avery 22806 easy peal square Badges';
         testcon.selfieldvalue = 'AS_FirstName__c,AS_LastName__c';
         testcon.selectedcolor = 'Black';
         testcon.selectedsize = '20pt';
         testcon.selectedfaceFir = 'Times New Roman';
        testcon.selLvalue = 'AS_Company__c';
         testcon.selectedcolorS = 'Black';
         testcon.selectedsizeS = '15pt';
         testcon.selectedfaceSec = 'Times New Roman';
      //   testcon.selectedprint();
         testcon.selectedvalues = 'Dymo Label(30856,Single Label)';
//         testcon.selectedprint();
         //testcon.genpdf();
         testcon.selectedvalues = 'Zebra Label';
//         testcon.selectedprint();
         //testcon.genpdf();
         testcon.eventselected = event1.id;
         //testcon.selectedprint();
         testcon.profileUpdateNotification();
         testcon.desiredTemplate();
    
       
         testCon.allrecords = true;
         testcon.attendeeslist.add(EAM);
         testcon.selfieldvalue='AS_FirstName__c';
         testcon.selLvalue=  'AS_LastName__c';
         testcon.selTvalue = 'AS_Company__c';
//         testcon.PrintBadge();
      //   testcon.PrintBadgeforthree();
         testcon.eventSelected = event1.id;
         
      // testCon.SaveAttendee();
         testcon.emailbadge();
        // testcon.selectedprint();
         testcon.profileUpdateNotification(); 
       
         testcon.dummy1();
   testcon.dummy2();
   testcon.dummy3();
    ApexPages.currentPage().getParameters().put('eamid',EAM.id );
    testcon.sendBadge();
    testCon.sendBadgeMutiple();
         
    BL_EventAdmin_AttendeesCon.checkattendee('testmyth@gmail.com',event1.id);
    BL_EventAdmin_AttendeesCon.Badge b=new BL_EventAdmin_AttendeesCon.Badge('','','');
    BL_EventAdmin_AttendeesCon.Style c=new BL_EventAdmin_AttendeesCon.Style('','','','','','','','','','','','','','','','','','','','','','','');
    
     }
 }


}