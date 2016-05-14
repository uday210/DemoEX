@isTest(SeeAllData=true)
public  class Test_MM_Eventadmin_attendeesdirectory{
    public static testMethod void myUnitTest() {
     Profile p1 = [select id from profile where name='Standard User'];
        account aa=new account(name='govtnm');
        insert aa;
        
         contact con=new contact(lastname='n',accountid = aa.id);
            insert con;
         contact con1=new contact(lastname='n',accountid = aa.id);
            insert con1;
         Profile p = [select id from profile where name='Attendee'];
         
    
    User u = new User(alias = 'test223', email='test223890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles',username='test223890@noemail.com');
                  insert u;
    
    
    User u1 = new User(alias = 'test223', email='test223890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con1.id,
                  timezonesidkey='America/Los_Angeles',username='mythili245.nagandla@gmail.com');
                  insert u1;
    
    
    Event__c event = new Event__c(ownerid=u.id,EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event;
     Event__c ev_nt= [select owner.username from Event__c where id=:event.id];
     Event__c event1 = new Event__c(EV_Title__c = 'testEvent1', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 5392 Name badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event1;
     
     
    
     
     
     AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'test1237777@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
     insert attendee;
     
     AttendeeSummary__c attendeefordelete = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'mythili3.nagandla@gmail.com', AS_Company__c = 'Global Nest');
     insert attendeefordelete;
     
     AttendeeSummary__c attendeedummy = new AttendeeSummary__c(AS_FirstName__c = 'myt>hily', AS_LastName__c = 'Nag,andla',
         AS_Email__c = 'mythili245.nagandla@gmail.com', AS_Company__c = 'Glo"bal Nest');
     insert attendeedummy;
     
     AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.glob,alnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
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
     AttendeeSummary__c att2 = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
         AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',
         AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
         AS_Email__c = 'test123567892@noemail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
         AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',
         AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode_1__c = '524621',
         AS_NAICSCode_2__c = '524421', AS_NAICSCode_3__c = '524671', AS_NAICSCode_4__c = '523621', AS_NAICSCode_5__c = '528921',   AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',
         AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',
         AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
         AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',
         AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',
         Registration_type__c = 'kdsmkas',Commodity_1__c='fdwe',Commodity_2__c='fdwe',Commodity_3__c='fdwe',Commodity_4__c='fdwe',Commodity_5__c='fdwe',Commodity_6__c='fdwe',Commodity_7__c='fdwe',Commodity_8__c='fdwe',Commodity_9__c='fdwe'
);
         
         
         
         //Commodity_1__c='fdwe',Commodity_2__c='fdwe',Commodity_3__c='fdwe',Commodity_4__c='fdwe',Commodity_5__c='fdwe',Commodity_6__c='fdwe',Commodity_7__c='fdwe',Commodity_8__c='fdwe',Commodity_9__c='fdwe'
     insert att2;
     
     Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = attendee.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM;
     
     Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = event1.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
    // Event_Attendee_Mapping__c EAM2 = new Event_Attendee_Mapping__c(EV_id__c = event.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
    // insert EAM2;
     List < Event_Attendee_Mapping__c > listOfEvent = new List < Event_Attendee_Mapping__c > ();
     listOfEvent.add(EAM);
     
     List < Event_Attendee_Mapping__c > listOfEvent1 = new List < Event_Attendee_Mapping__c > ();
     listOfEvent1.add(EAM1);
     
     SecurityControls__c sc = new SecurityControls__c(EV_Req_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_id__c = event.id);
     insert sc;
     
     List<Folder> lstFolder = [Select Id From Folder Where Name = 'Logos' ];
      Document document;         
               if(lstFolder.size() > 0)
               {
                   document = new Document(FolderId = lstFolder.get(0).Id, Name='Test Name',Keywords = 'Test');
                   insert document;
                 }
     
      
     List < id > listid = new List < id > ();
     listid.add(EAM.id);
     
     List < id > listid1 = new List < id > ();
     listid.add(EAM1.id);
     
     User_Profile_Event__c UPE = new User_Profile_Event__c (EV_id__c=event.id,User_id__c=u.id);
     MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/05/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/06/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays1;
             Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks;   
           
           NAICS_Code__c naicscode1= new NAICS_Code__c();
              naicscode1.Name='1234';
              naicscode1.Description__c='Naics Sample1';
              insert naicscode1;
              
               NAICS_Code__c naicscode2= new NAICS_Code__c();
              naicscode2.Name='2345';
              naicscode2.Description__c='Naics Sample2';
              insert naicscode2;
           
           
            NAICS_Code__c naicscode3= new NAICS_Code__c();
              naicscode3.Name='3456';
              naicscode3.Description__c='Naics Sample3';
              insert naicscode3;
           
           
           
           Commodities__c C = new Commodities__c();
          C.Description__C = 'Test';
              insert C;
              
               Profile_Settings__c pse = new Profile_Settings__c(Business_Description__c = true,Company_Name__c= true,
                                  Title__c= true,Mobile__c= true,Email_Id__c= true,First_Name__c= true,
                                  KeyWords__c= true,Last_Name__c= true,NAICS_Codes__c= true,Work_Address__c= true,
                                  Work_phone__c= true , Event__c = event.id );
                                  
                  insert pse; 
                  
                   MBE_Profile__c a=new MBE_Profile__c();    
        a.As_prefixNew__c='Mr';
        a.As_SuffixNew__c='Mrs';
        a.As_Shipping_Country__c='India';
        a.As_Shipping_States__c='TS';
        //a.SystemModstamp='AAA'; 
       // a.OwnerId=u.id; 
        a.Name='Vineel'; 
        //a.LastModifiedDate='22-10-1987'; 
        //a.LastModifiedById=23-10-1987;
        //a.LastActivityDate=24-10-1987; 
        //a.IsDeleted=Del; 
        //a.Id='u.id'; 
        //a.CreatedDate=25-10-1987; 
        //'testadm@gmail.com'
        //test1237777@noemail.com
        a.AS_Email__c ='test1237777@noemail.com';
        a.Event_Organizer_Id__c = ev_nt.owner.username;
        system.debug('@@'+ev_nt.owner.username);
        //a.CreatedById=26-10-1987; 
        a.Exhibitor_company_imageUrl__c='www.globalnest.com';
        a.AS_WorkZipCode__c=44322;
        a.AS_WorkPhone__c='(732) 333 4808'; 
        a.AS_WorkCity__c='Hyderabad';  
        //a.AttendeeSummary__c=att.id;
       a.AttendeeSummary__c = attendee.id;
        a.Commodity_1__c ='Accounting';
        a.Commodity_2__c ='Advertising';
        a.Commodity_3__c ='Aerospace';
        a.Commodity_4__c ='Aircraft Repair';
        a.Commodity_5__c ='Architectural Design';
        a.Commodity_6__c ='Artistic Development';
        a.Commodity_7__c ='Assembly';
        a.Commodity_8__c ='Automobiles';
        a.Commodity_9__c ='Automotive';
    insert a;                
     Attachment attmt=new Attachment(Description='test description',name='test file',ContentType='text',parentId = a.id,Body=Blob.valueOf('test body'));
     insert attmt;
    
        cookie  counter = new Cookie('counter',event.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
     
       system.runAs(u) {
        MM_Eventadmin_AttendeesdirectoryCon.EventWrapper evWWW=new MM_Eventadmin_AttendeesdirectoryCon.EventWrapper(EAM1);
        
        MM_Eventadmin_AttendeesdirectoryCon.inn evWWW1=new MM_Eventadmin_AttendeesdirectoryCon.inn('test',new List<string>(),new List<selectOption>(),new List<selectOption>(),null,new List<string>());
       // string s,List<string> l1,List<selectOption> l2,List<selectOption> l3,id i,List<string> l4
        MM_Eventadmin_AttendeesdirectoryCon mme = new MM_Eventadmin_AttendeesdirectoryCon();
        
        
        
        
        // variables initialization
        
         mme.SelectValAs = 'test121';
         mme.mycheck = 'test122';
         mme.statusvalue = 'test123';
         mme.selectedfaceFir = 'test124';
         mme.selectedfaceSec = 'test125';
         mme.selectedfaceThr = 'test126';
         mme.selfieldvalue = 'test127';
         mme.fordel = 'test128';
         mme.selectedcolor = 'test129';
         mme.selectedsize = 'test130';
         mme.selectedcolorT = 'test1201';
         mme.selectedsizeT = 'test1210';
         mme.selectedsizesecond = 'test1211';
         mme.selFvalue = 'test1212';
         mme.selTvalue = 'test1213';
         mme.selectedsizeS = 'test1214';
         mme.selectedcolorS = 'test1215';
         mme.selLvalue = 'test1216';
         mme.Brevenue = 'test1217';
         mme.attendeeNameAfterEdit = 'test1218';
         mme.BDnBId = 'test1219';
         mme.BwebSite = 'test0121';
         mme.BDescription = 'test1121';
         mme.wAddress = 'test2121';
         mme.WPhone = 'test3121';
         mme.WPOBox = 'test4121';
         mme.SAddress = 'test5121';
         mme.SPOBox = 'test6121';
         mme.SBlogURL = 'tes7t121';
         mme.Diversity = 'te7st121';
         mme.wstate = 'test1721';
         mme.wcity = 'test1821';
         mme.wAdd2 = 'test1821';
         mme.Scity = 't1est121';
         mme.Sstate = 'tesrt121';
         mme.Homeaddress1 = 'tewst121';
         mme.Homecity = 'test1w21';
         mme.Homestate = 'terst121';
         mme.HPOBox = 'test12tv1';
         mme.SAddress2 = 'tevst121';
         mme.duplicateAttendee = 'tcest121';
         mme.duplicateAttendee = 'test12f1';
         mme.eventIdVar = 'tests121';
         mme.FirstName = 'test12b1';
         mme.LastName = 'test1a21';
         mme.CompanyName = 'temst1a1';
         mme.EmailId = 'test16621';
         mme.EventReqString1 = 'tess2t121';
         mme.selectedvalues = 'te23st121';
         mme.attendeeName = 'tes32t121';
         mme.Successbool = Boolean.valueOf('true');
         mme.totalselectlist = Boolean.valueOf('true');
         mme.custombadge1 = Boolean.valueOf('true');
         mme.print = Boolean.valueOf('true');
         mme.checked = Boolean.valueOf('true');
         mme.foundHistoryBool = Boolean.valueOf('true');
         mme.Shippinginfo = Boolean.valueOf('true');
         mme.workinfo = Boolean.valueOf('true');
         mme.ReqFields = Boolean.valueOf('true');
         mme.onclickback = Boolean.valueOf('true');
         mme.Ebool = Boolean.valueOf('true');
         mme.EventEditpopup = Boolean.valueOf('true');
         mme.pdfbool = Boolean.valueOf('true');
         mme.cus12 = new List<Event_Attendee_Mapping__c>();
         mme.attendees1234 = new list<Event_Attendee_Mapping__c>();
         mme.Event = new AttendeeSummary__c();
         mme.slectedvalues = 'test35r';
         mme.states = new LIST<selectoption>();
         mme.attid = new List<id>();
         mme.attendeeslist = new list<Event_Attendee_Mapping__c>();
         mme.str = new List<Event_Attendee_Mapping__c>();
         mme.event1 = new Event_Attendee_Mapping__c();
         mme.checkedbadge = new List<Event_Attendee_Mapping__c>();
         mme.checkedbadge1 = new List<Event_Attendee_Mapping__c>();
         mme.checkedbadge2 = new List<Event_Attendee_Mapping__c>();
         mme.message = 'testerwecd';
         mme.attendeeSetting123 = new BL_AttendeeSettingsCon();
         mme.Items = new LIST<SelectOption>();
         mme.ImportHistory = new LIST<DataImport_SavePoint__c>();
         mme.RegValu0 = Boolean.valueOf('true');
         mme.RegValu1 = Boolean.valueOf('true');
         mme.RegValu2 = Boolean.valueOf('true');
         mme.RegTypeList = new List<String>();
         mme.RegTypeValues = 'tdfwystv34';
         mme.ShowError = 'tedvyteu';
         mme.attfilesize = 32;
         mme.ev_att_jun = 45;
         mme.selectedNAICS1 = 'testvsgvdwe';
         mme.selectedNAICS2 = 'testvsgvdwe1';
         mme.selecteddelnaic = 'testvsgvdwe2';
         mme.selectednaicscodeslist = new NAICS_Code__c();
         mme.selectednacslist = new List<String>();
         mme.selecteddelnaicsplit = new List<String>();
         mme.naicsset = new set<string>();
         mme.naicsdellist = new NAICS_Code__c();
         mme.naicsalertbool = Boolean.valueOf('true');
         mme.delbool = Boolean.valueOf('true');
         mme.TicTypesforedit = new Event_Attendee_Mapping__c();
         mme.AttTypesforedit = new Event_Attendee_Mapping__c();
         mme.imageerrormsg = 'test4ytdfyt';
         
         //*******************variable initialization******
         
         mme.attachmentval= Blob.valueOf('test body');
         Document document1;         
               if(lstFolder.size() > 0)
               {
                   document1 = new Document(FolderId = lstFolder.get(0).Id, Name='Test Name',Keywords = 'Test');
                   insert document1;
                   
                 }
         mme.myimage= document1;
         mme.attendeeImageEdit= Blob.valueOf('test body');
         mme.b= Blob.valueOf('test body');
         mme.pdf= Page.BL_Eventadmin_signup;          
         Test.setCurrentPage(mme.pdf);
         mme.attendeeevent= event.id;
         mme.mallikImage= Blob.valueOf('test body');
         mme.SelectedValuesfortwoprinters= new LIST < selectoption >();         
         
         //********************      
         
        mme.getSmallschedulescount();
        mme.sortDir = null;
           
         PageReference pageRef123 = Page.BL_Eventadmin_signup;
         Test.setCurrentPage(pageRef123);
           mme.checkUserId();
           
         mme.userId = u.id;
         mme.eventName1 = EAM.id;
         mme.eventName1 = EAM1.id;
         mme.eventSelected = event.id;
         mme.escapeSpecialCharacters('my>,.th#ly/');
         mme.escapeSpecialCharacters('my",.thly/');
         mme.escapeSpecialCharacters('my<,.thly/');
         mme.escapeSpecialCharacters('my.,.thly/');
         mme.toggleSort();
         mme.getevents();
         Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
         MM_Eventadmin_AttendeesdirectoryCon.getLocalDateTime(myDateTime);
         mme.escapeSpecialCharacters('sai');
         mme.escapeSpecialCharacters('<');
         mme.escapeSpecialCharacters(',');
         mme.escapeSpecialCharacters('.'); 
         
         
         mme.getevents();
         ApexPages.currentPage().getParameters().put('alphabit', 'T');
         mme.Alphasorting();
         
         
         mme.CreateAttendee();
         mme.eventSelected = null;
         try{
         mme.CreateAttendee();
         }catch(Exception e){}
         event.Is_Webank_event__c = true;
         update event;
         mme.eventSelected = event.id;
         mme.CreateAttendee();
         event.Is_Webank_event__c = false;
         update event;
         mme.eventSelected = event.id;
         mme.ImportAttendee();
         AttendeeSummary__c newAttendee = new AttendeeSummary__c();
        
         newAttendee.AS_Email__c = 'admintest@gmail.com';
         newAttendee.AS_LastName__c = 'Admin';
         newAttendee.AS_FirstName__c = 'BoothLeads';
         mme.newAttendee = newAttendee;
          mme.attmap = new Event_Attendee_Mapping__c();
          ApexPages.currentPage().getParameters().put('mycheck',EAM.id );
          
          //AttendeeSummary__c newAttendee1 = new AttendeeSummary__c();
          mme.newAttendee=att;
         mme.editAttendee();
         // mme.UpdateAttendee();
         try{
       event.Is_Webank_event__c=true;
        update event;
        mme.editAttendee();
        }catch(Exception e){}
          newAttendee = new AttendeeSummary__c();
         newAttendee.AS_Email__c = 'mythili.nagandla@gmail.com';
         newAttendee.AS_LastName__c = 'mythily';
         newAttendee.AS_FirstName__c = 'Nagandla';
         newAttendee.As_NAICSCode_1__c=naicscode1.id;
         mme.newAttendee = newAttendee;
        String myString = 'StringToBlob';
        mme.attendeeImage=Blob.valueof(myString);
        mme.myImageName='sunny';
        mme.mydoc = document;
        //mme.savembepro();       
             
        try{
        mme.editAttendee();
        mme.myimageName='Vinny';
        
     
        mme.Cancel();
        mme.ClosePopUp();
        mme.attendeedetail();
        mme.deleteallattendees();
        
        mme.escape('ram,kumar');
        mme.serarchstringvalue = 'mythily';
        mme.search();
        mme.fortrancy();
        mme.next() ;
        mme.prev();
        mme.pageno= 1;
        mme.prev();
        mme.Last();
        mme.First();
         }catch(Exception e){}
        test.starttest();
        mme.viewschedule();
        mme.schedulesOnStatus();
        mme.printschedule();
        mme.emailalertsh=true;
        mme.eamid = EAM1.Id;
        mme.emailschedule();
        mme.eamid = EAM.Id;
        mme.emailschedule();
        
        mme.exhibitorListToMatch();
        mme.matchSelectedExhibitor();
        mme.closeExhibitorPopup();
        mme.ExhibitorsFromBL();
        mme.saveExhibitors();
        mme.Printattendeedetail();
        mme.CheckUser();
        mme.naicscodesfun();
        mme.commodityfun();
        mme.delimage();
        mme.delvideo();
        mme.delattachment();
        mme.prosettings();
        mme.savesettings();
        mme.blockschedules();
       
        mme.Blockedaction();
        try{
        mme.massemailschedules();
        }catch(Exception ep1){}
        
      
       try{
       MM_Eventadmin_AttendeesdirectoryCon.checkMbe('testadm@gmail.com',event.id);
        }catch(Exception e){}
        
        MM_Eventadmin_AttendeesdirectoryCon.inn einn = new MM_Eventadmin_AttendeesdirectoryCon.inn('testabc',new List<string>(),new List<selectOption>(),new List<selectOption>(),null,new List<string>());
        MM_Eventadmin_AttendeesdirectoryCon.innercl eincl = new MM_Eventadmin_AttendeesdirectoryCon.innercl('testfdfs23',true);
        MM_Eventadmin_AttendeesdirectoryCon.checkattendee('test1237777@noemail.com',event.id);
        try{
        MM_Eventadmin_AttendeesdirectoryCon.updateexistingid('test1237777@noemail.com','mythili245.nagandla@gmail.com',event.id,eam.id);
        }catch(exception e){}
       
        try{
        MM_Eventadmin_AttendeesdirectoryCon.updateexstdemail('test12377773@noemail.com','mythili245.nagandla@gmail.com',event.id,eam.id);
        }catch(exception e){}
        try{
        MM_Eventadmin_AttendeesdirectoryCon.updatenewstdemail('test12377777@noemail.com','mythili245.nagandla@gmail.com',event.id,eam.id);
        }catch(exception e){}
        
        
        
         mme.allrecords=true;
        mme.deleteallattendees();
       // mme.attendeedetail();
        test.stoptest();
        
        
    }
 }
 
  public static testMethod void myUnitTest2() {
     Profile p1 = [select id from profile where name='Standard User'];
        account aa=new account(name='govtnm');
        insert aa;
        
         contact con=new contact(lastname='n',accountid = aa.id);
            insert con;
         Profile p = [select id from profile where name='Attendee'];
         
    
    User u = new User(alias = 'test223', email='test223890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles',username='test223890@noemail.com');
                  insert u;
    
    Event__c event = new Event__c(ownerid=u.id,EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event;
     Event__c ev_nt= [select owner.username from Event__c where id=:event.id];
     Event__c event1 = new Event__c(EV_Title__c = 'testEvent1', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 5392 Name badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event1;
     
     
    
     
     
     AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'test1237777@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
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
     
     Widget__c wdg = new Widget__c();
     wdg.Name = 'testAtnd';
     wdg.AttendeeSummary__c = att.id;
     wdg.YouTubeId_c__c = 'testUrl';
     insert wdg;
     
     
     
     Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = attendee.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM;
     
     Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = event1.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
     
     List < Event_Attendee_Mapping__c > listOfEvent = new List < Event_Attendee_Mapping__c > ();
     listOfEvent.add(EAM);
     
     List < Event_Attendee_Mapping__c > listOfEvent1 = new List < Event_Attendee_Mapping__c > ();
     listOfEvent1.add(EAM1);
     
     SecurityControls__c sc = new SecurityControls__c(EV_Req_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_id__c = event.id);
     insert sc;
     
     List<Folder> lstFolder = [Select Id From Folder Where Name = 'Logos' ];
      Document document;         
               if(lstFolder.size() > 0)
               {
                   document = new Document(FolderId = lstFolder.get(0).Id, Name='Test Name',Keywords = 'Test');
                   insert document;
                 }
      
     
      
     List < id > listid = new List < id > ();
     listid.add(EAM.id);
     
     List < id > listid1 = new List < id > ();
     listid.add(EAM1.id);
     
     User_Profile_Event__c UPE = new User_Profile_Event__c (EV_id__c=event.id,User_id__c=u.id);
     MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/05/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/06/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays1;
             Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks;   
           
           NAICS_Code__c naicscode1= new NAICS_Code__c();
              naicscode1.Name='1234';
              naicscode1.Description__c='Naics Sample1';
              insert naicscode1;
              
               NAICS_Code__c naicscode2= new NAICS_Code__c();
              naicscode2.Name='2345';
              naicscode2.Description__c='Naics Sample2';
              insert naicscode2;
           
           
            NAICS_Code__c naicscode3= new NAICS_Code__c();
              naicscode3.Name='3456';
              naicscode3.Description__c='Naics Sample3';
              insert naicscode3;
           
           
           
           Commodities__c C = new Commodities__c();
      C.Description__C = 'Test';
      insert C;
              
               Profile_Settings__c pse = new Profile_Settings__c(Business_Description__c = true,Company_Name__c= true,
                                  Title__c= true,Mobile__c= true,Email_Id__c= true,First_Name__c= true,
                                  KeyWords__c= true,Last_Name__c= true,NAICS_Codes__c= true,Work_Address__c= true,
                                  Work_phone__c= true , Event__c = event.id );
                                  
                  insert pse; 
                  
                   MBE_Profile__c a=new MBE_Profile__c();    
        a.As_prefixNew__c='Mr';
        a.As_SuffixNew__c='Mrs';
        a.As_Shipping_Country__c='India';
        a.As_Shipping_States__c='TS';
        //a.SystemModstamp='AAA'; 
       // a.OwnerId=u.id; 
        a.Name='Vineel'; 
        //a.LastModifiedDate='22-10-1987'; 
        //a.LastModifiedById=23-10-1987;
        //a.LastActivityDate=24-10-1987; 
        //a.IsDeleted=Del; 
        //a.Id='u.id'; 
        //a.CreatedDate=25-10-1987; 
        a.AS_Email__c = 'testadm@gmail.com';
        a.Event_Organizer_Id__c = ev_nt.owner.username;
        system.debug('@@'+ev_nt.owner.username);
        //a.CreatedById=26-10-1987; 
        a.Exhibitor_company_imageUrl__c='www.globalnest.com';
        a.AS_WorkZipCode__c=44322;
        a.AS_WorkPhone__c='(732) 333 4808'; 
        a.AS_WorkCity__c='Hyderabad';  
        //a.AttendeeSummary__c=att.id;
       a.AttendeeSummary__c = attendee.id;
        a.Commodity_1__c ='Accounting';
        a.Commodity_2__c ='Advertising';
        a.Commodity_3__c ='Aerospace';
        a.Commodity_4__c ='Aircraft Repair';
        a.Commodity_5__c ='Architectural Design';
        a.Commodity_6__c ='Artistic Development';
        a.Commodity_7__c ='Assembly';
        a.Commodity_8__c ='Automobiles';
        a.Commodity_9__c ='Automotive';
    insert a;                
     Attachment attmt=new Attachment(Description='test description',name='test file',ContentType='text',parentId = a.id,Body=Blob.valueOf('test body'));
     insert attmt;
    
        cookie  counter = new Cookie('counter',event.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
     
       system.runAs(u) {
       test.starttest();
        MM_Eventadmin_AttendeesdirectoryCon.EventWrapper evWWW=new MM_Eventadmin_AttendeesdirectoryCon.EventWrapper(EAM1);    
        MM_Eventadmin_AttendeesdirectoryCon mme2 = new MM_Eventadmin_AttendeesdirectoryCon();
         ApexPages.currentPage().getParameters().put('mycheck',EAM.id );
         AttendeeSummary__c newAttendee1 = new AttendeeSummary__c();
         newAttendee1.AS_Email__c = 'mythili.nagandla@gmail.com';
         newAttendee1.AS_LastName__c = 'mythily';
         newAttendee1.AS_FirstName__c = 'Nagandla';
         newAttendee1.As_NAICSCode_1__c=naicscode1.id;
         mme2.newAttendee = newAttendee1;
        String myString = 'StringToBlob';
        mme2.attendeeImage=Blob.valueof(myString);
        mme2.myImageName='sunny';
        
        /*
        String exp= 'StringToBlob';
        mme2.DiversityTypes  =new String[]{};
        mme2.selectedTicTypes =new String[]{};
        mme2.DiversityTypesforfirstLine=new String[]{};
        mme2.DiversityTypesforsecondLine=new String[]{};
        mme2.DiversityTypesforfirstLine.add(exp);       
        mme2.DiversityTypesforsecondLine.add(exp);
        mme2.DiversityTypes.add(exp);       
        mme2.selectedTicTypes.add(exp);
        mme2.Divoptionsforsecondline= new List<SelectOption>();
        mme2.Divoptionsforsecondline.add(new SelectOption('US','US'));
        mme2.Divoptionsforsecondline.add(new SelectOption('CANADA','Canada'));
        mme2.Divoptionsforsecondline.add(new SelectOption('MEXICO','Mexico'));
        mme2.Divoptions= new List<SelectOption>();
        mme2.Divoptions.add(new SelectOption('US','US'));
        mme2.Divoptions.add(new SelectOption('CANADA','Canada'));
        mme2.Divoptions.add(new SelectOption('MEXICO','Mexico'));
        mme2.eventDIVS= new Event__c();
        mme2.eventDIVS=event;
        mme2.SelectedValuesfortwoprinters= new List<SelectOption>();
        mme2.SelectedValuesfortwoprinters.add(new SelectOption('US','US'));
        mme2.SelectedValuesfortwoprinters.add(new SelectOption('CANADA','Canada'));
        mme2.SelectedValuesfortwoprinters.add(new SelectOption('MEXICO','Mexico'));
        
        */
         
       
       
       
        
        ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf');
        
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf';
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf';
        
        try{
        mme2.savembepro();
        }catch(Exception ep3){}
        
         ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        try{
        mme2.savembepro();
        }catch(Exception ep4){}
        
        ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.savembepro();
        }catch(Exception ep5){}
       ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
         mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.savembepro();
        }catch(Exception ep6){}
        
         ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre'; 
         try{
        mme2.savembepro();
        }catch(Exception ep7){}
        
         ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.savembepro();
        }catch(Exception ep8){}
        
         ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.savembepro();
        }catch(Exception ep9){}
         ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.savembepro();
        }catch(Exception ep10){}
         ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
      
        try{
        mme2.savembepro();
        }catch(Exception ep11){}
        
        
        
        
        
        /*AttendeeSummary__c newAttendee2 = new AttendeeSummary__c();
         newAttendee2.AS_Email__c = 'test12356789@noemail.com';
         newAttendee2.AS_LastName__c = 'mythily';
         newAttendee2.AS_FirstName__c = 'Nagandla';
         newAttendee2.As_NAICSCode_1__c=naicscode1.id;
         mme2.newAttendee = newAttendee2;
         */
         
       
       
        
         try{
       mme2.ExportMBE();
       
       }catch(Exception e){}
       event.Is_Webank_event__c=false;
       update event;
       
       try{
       mme2.ExportMBE();
       
       }catch(Exception e){}
       
        try{
        mme2.UpdateAttendee();
        }catch(Exception e){}
        
        
        String exp= 'StringToBlob';
        mme2.DiversityTypes  =new String[]{};
        mme2.selectedTicTypes =new String[]{};
        mme2.DiversityTypesforfirstLine=new String[]{};
        mme2.DiversityTypesforsecondLine=new String[]{};
        mme2.DiversityTypesforfirstLine.add(exp);       
        mme2.DiversityTypesforsecondLine.add(exp);
        mme2.youtubevideo=new Widget__c();
       mme2.youtubevideo.YouTubeId_c__c = 'src="http://www.youtube.com/watch?v=u8nQa1cJyX8&a=GxdCwVVULXctT2lYDEPllDR0LRTutYfW"';
        try{
        mme2.savembepro();
        }catch(Exception ep11){}
        mme2.eventSelected=event1.Id; 
        
               
         try{
        MM_Eventadmin_AttendeesdirectoryCon.updatenewid('test1237777@noemail.com','',event.id,eam.id);
        }catch(exception e){}
         try{
        MM_Eventadmin_AttendeesdirectoryCon.updatenewid('test1237777@noemail.com','mythili245.nagandla@gmail.com',event.id,eam.id);
        }catch(exception e){}
        
        mme2.Cancel();

    //MM_Eventadmin_AttendeesdirectoryCon.updateexstdemail('test12356789@noemail.com','anil@gnst.com',event.id,eam.id);
    test.stoptest();
    }
   }
     public static testMethod void myUnitTest3() {
     Profile p1 = [select id from profile where name='Standard User'];
        account aa=new account(name='govtnm');
        insert aa;
        
         contact con=new contact(lastname='n',accountid = aa.id);
            insert con;
         Profile p = [select id from profile where name='Attendee'];
         
    
    User u = new User(alias = 'test223', email='test223890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles',username='test223890@noemail.com');
                  insert u;
    
    Event__c event = new Event__c(ownerid=u.id,EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event;
     Event__c ev_nt= [select owner.username from Event__c where id=:event.id];
     Event__c event1 = new Event__c(EV_Title__c = 'testEvent1', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 5392 Name badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event1;
     
     
    
     
     
     AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'test1237777@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
     insert attendee;
     
     AttendeeSummary__c attendeefordelete = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'mythili3.nagandla@gmail.com', AS_Company__c = 'Global Nest');
     insert attendeefordelete;
     
     AttendeeSummary__c attendeedummy = new AttendeeSummary__c(AS_FirstName__c = 'myt>hily', AS_LastName__c = 'Nag,andla',
         AS_Email__c = 'mythili245.nagandla@gmail.com', AS_Company__c = 'Glo"bal Nest');
     insert attendeedummy;
     
      AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.glob,alnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
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
     AttendeeSummary__c att2 = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
         AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',
         AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
         AS_Email__c = 'test123567892@noemail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
         AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',
         AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode_1__c = '524621',
         AS_NAICSCode_2__c = '524421', AS_NAICSCode_3__c = '524671', AS_NAICSCode_4__c = '523621', AS_NAICSCode_5__c = '528921',   AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',
         AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',
         AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
         AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',
         AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',
         Registration_type__c = 'kdsmkas',Commodity_1__c='fdwe',Commodity_2__c='fdwe',Commodity_3__c='fdwe',Commodity_4__c='fdwe',Commodity_5__c='fdwe',Commodity_6__c='fdwe',Commodity_7__c='fdwe',Commodity_8__c='fdwe',Commodity_9__c='fdwe'
);
         
         
         
         //Commodity_1__c='fdwe',Commodity_2__c='fdwe',Commodity_3__c='fdwe',Commodity_4__c='fdwe',Commodity_5__c='fdwe',Commodity_6__c='fdwe',Commodity_7__c='fdwe',Commodity_8__c='fdwe',Commodity_9__c='fdwe'
     insert att2;
     
     Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = attendee.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM;
     
     Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = event1.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
     //Event_Attendee_Mapping__c EAM2 = new Event_Attendee_Mapping__c(EV_id__c = att.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     //insert EAM2;
     
     List < Event_Attendee_Mapping__c > listOfEvent = new List < Event_Attendee_Mapping__c > ();
     listOfEvent.add(EAM);
     
     List < Event_Attendee_Mapping__c > listOfEvent1 = new List < Event_Attendee_Mapping__c > ();
     listOfEvent1.add(EAM1);
     
     SecurityControls__c sc = new SecurityControls__c(EV_Req_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_id__c = event.id);
     insert sc;
     
     List<Folder> lstFolder = [Select Id From Folder Where Name = 'Logos' ];
      Document document;         
               if(lstFolder.size() > 0)
               {
                   document = new Document(FolderId = lstFolder.get(0).Id, Name='Test Name',Keywords = 'Test');
                   insert document;
                 }
     
      
     List < id > listid = new List < id > ();
     listid.add(EAM.id);
     
     List < id > listid1 = new List < id > ();
     listid.add(EAM1.id);
     
     User_Profile_Event__c UPE = new User_Profile_Event__c (EV_id__c=event.id,User_id__c=u.id);
     MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/05/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/06/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays1;
             Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks;   
           
           NAICS_Code__c naicscode1= new NAICS_Code__c();
              naicscode1.Name='1234';
              naicscode1.Description__c='Naics Sample1';
              insert naicscode1;
              
               NAICS_Code__c naicscode2= new NAICS_Code__c();
              naicscode2.Name='2345';
              naicscode2.Description__c='Naics Sample2';
              insert naicscode2;
           
           
            NAICS_Code__c naicscode3= new NAICS_Code__c();
              naicscode3.Name='3456';
              naicscode3.Description__c='Naics Sample3';
              insert naicscode3;
           
           
           
           Commodities__c C = new Commodities__c();
      C.Description__C = 'Test';
      insert C;
              
               Profile_Settings__c pse = new Profile_Settings__c(Business_Description__c = true,Company_Name__c= true,
                                  Title__c= true,Mobile__c= true,Email_Id__c= true,First_Name__c= true,
                                  KeyWords__c= true,Last_Name__c= true,NAICS_Codes__c= true,Work_Address__c= true,
                                  Work_phone__c= true , Event__c = event.id );
                                  
                  insert pse; 
                  
                   MBE_Profile__c a=new MBE_Profile__c();    
        a.As_prefixNew__c='Mr';
        a.As_SuffixNew__c='Mrs';
        a.As_Shipping_Country__c='India';
        a.As_Shipping_States__c='TS';
        //a.SystemModstamp='AAA'; 
       // a.OwnerId=u.id; 
        a.Name='Vineel'; 
        //a.LastModifiedDate='22-10-1987'; 
        //a.LastModifiedById=23-10-1987;
        //a.LastActivityDate=24-10-1987; 
        //a.IsDeleted=Del; 
        //a.Id='u.id'; 
        //a.CreatedDate=25-10-1987; 
       // a.AS_Email__c = 'testadm@gmail.com';
         a.AS_Email__c = 'test1237777@noemail.com';
        
        a.Event_Organizer_Id__c = ev_nt.owner.username;
        system.debug('@@'+ev_nt.owner.username);
        //a.CreatedById=26-10-1987; 
        a.Exhibitor_company_imageUrl__c='www.globalnest.com';
        a.AS_WorkZipCode__c=44322;
        a.AS_WorkPhone__c='(732) 333 4808'; 
        a.AS_WorkCity__c='Hyderabad';  
        //a.AttendeeSummary__c=att.id;
       a.AttendeeSummary__c = attendee.id;
        a.Commodity_1__c ='Accounting';
        a.Commodity_2__c ='Advertising';
        a.Commodity_3__c ='Aerospace';
        a.Commodity_4__c ='Aircraft Repair';
        a.Commodity_5__c ='Architectural Design';
        a.Commodity_6__c ='Artistic Development';
        a.Commodity_7__c ='Assembly';
        a.Commodity_8__c ='Automobiles';
        a.Commodity_9__c ='Automotive';
        a.As_NAICSCode_1__c='Accounting';
        a.As_NAICSCode_2__c='Advertising';
        a.As_NAICSCode_3__c='Aerospace';
        a.As_NAICSCode_4__c='Aircraft Repair';
        a.As_NAICSCode_5__c='Architectural Design';
        a.As_NAICSCode6__c='Artistic Development';       
        a.As_NAICSCode7__c='Assembly';
        a.As_NAICSCode8__c='Automobiles';
        a.As_NAICSCode9__c='Automotive';
    insert a;                
     Attachment attmt=new Attachment(Description='test description',name='test file',ContentType='text',parentId = a.id,Body=Blob.valueOf('test body'));
     insert attmt;
    
        cookie  counter = new Cookie('counter',event.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
     
       system.runAs(u) {
        MM_Eventadmin_AttendeesdirectoryCon.EventWrapper evWWW=new MM_Eventadmin_AttendeesdirectoryCon.EventWrapper(EAM1);    
        MM_Eventadmin_AttendeesdirectoryCon mme2 = new MM_Eventadmin_AttendeesdirectoryCon();
         ApexPages.currentPage().getParameters().put('mycheck',EAM.id );
         AttendeeSummary__c newAttendee1 = new AttendeeSummary__c();
         newAttendee1.AS_Email__c = 'mythili.nagandla@gmail.com';
         newAttendee1.AS_LastName__c = 'mythily';
         newAttendee1.AS_FirstName__c = 'Nagandla';
         newAttendee1.As_NAICSCode_1__c=naicscode1.id;
         mme2.newAttendee = newAttendee1;
        String myString = 'StringToBlob';
        mme2.attendeeImage=Blob.valueof(myString);
        mme2.myImageName='sunny';
        
        String exp = 'abc';
          
        mme2.DiversityTypes  =new String[]{};
        mme2.selectedTicTypes =new String[]{};
        mme2.DiversityTypesforfirstLine=new String[]{};
        mme2.DiversityTypesforsecondLine=new String[]{};
        mme2.DiversityTypesforfirstLine.add(exp);       
        mme2.DiversityTypesforsecondLine.add(exp);
        mme2.DiversityTypes.add(exp);       
        mme2.selectedTicTypes.add(exp);
        mme2.Divoptionsforsecondline= new List<SelectOption>();
        mme2.Divoptionsforsecondline.add(new SelectOption('US','US'));
        mme2.Divoptionsforsecondline.add(new SelectOption('CANADA','Canada'));
        mme2.Divoptionsforsecondline.add(new SelectOption('MEXICO','Mexico'));
        mme2.Divoptions= new List<SelectOption>();
        mme2.Divoptions.add(new SelectOption('US','US'));
        mme2.Divoptions.add(new SelectOption('CANADA','Canada'));
        mme2.Divoptions.add(new SelectOption('MEXICO','Mexico'));
        mme2.eventDIVS= new Event__c();
        mme2.eventDIVS=event;
        mme2.SelectedValuesfortwoprinters= new List<SelectOption>();
        mme2.SelectedValuesfortwoprinters.add(new SelectOption('US','US'));
        mme2.SelectedValuesfortwoprinters.add(new SelectOption('CANADA','Canada'));
        mme2.SelectedValuesfortwoprinters.add(new SelectOption('MEXICO','Mexico'));
        
        
        
         
        ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf');
        
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf';
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf';
        mme2.mydoc = document;
        try{
        mme2.mydoc = document;
        mme2.SaveAttendee();
        }catch(Exception ep3){}
        
         ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        try{
        mme2.SaveAttendee();
        }catch(Exception ep4){}
        
        ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SaveAttendee();
        }catch(Exception ep5){}
       ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
         mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SaveAttendee();
        }catch(Exception ep6){}
        
         ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre'; 
         try{
        mme2.SaveAttendee();
        }catch(Exception ep7){}
        
         ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SaveAttendee();
        }catch(Exception ep8){}
        
         ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SaveAttendee();
        }catch(Exception ep9){}

       mme2.eventName1 = EAM.id;
        mme2.newAttendee =att;
        mme2.eventSelected=event.id;
       mme2.attachmentval= Blob.valueOf('test body');
        mme2.cyoutubevideo=new Custom_Widget__c();
       
       mme2.cyoutubevideo.YouTubeId_c__c = 'src="http://www.youtube.com/watch?v=u8nQa1cJyX8&a=GxdCwVVULXctT2lYDEPllDR0LRTutYfW"';
       mme2.mbepro=new list<MBE_Profile__c>();
       mme2.myimageName='Vinny';
       String myString4 = 'StringToBlob';
        mme2.attendeeImage=Blob.valueof(myString4);
        mme2.selectedregions=new List<string>();
        mme2.selectedregions.add('gn');
        mme2.myImageName='sunny';
        
       mme2.mbepro.add(a);
       
      
         Test.startTest();
         
          try{
        mme2.SaveAttendee();
        }catch(Exception ep11){}
         
          ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SaveAttendee();
        }catch(Exception ep10){}
         ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
      
        try{
        mme2.SaveAttendee();
        }catch(Exception ep11){}
        
        
        try{
        MM_Eventadmin_AttendeesdirectoryCon.updatenewid('test1237777@noemail.com','',event.id,eam.id);
        }catch(exception e){}
         try{
        MM_Eventadmin_AttendeesdirectoryCon.updatenewid('test1237777@noemail.com','mythili245.nagandla@gmail.com',event.id,eam.id);
        }catch(exception e){}
        
     
       
       
       
         
       try{
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf';
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf'; 
        mme2.SavecustAttendee();
        }catch(Exception e){}
        // ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        try{
        mme2.SavecustAttendee();
        }catch(Exception ep4){}
       
       // ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SavecustAttendee();
        }catch(Exception ep5){}
      // ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
         mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SavecustAttendee();
        }catch(Exception ep6){}
        
         //ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre'; 
         try{
        mme2.SavecustAttendee();
        }catch(Exception ep7){}
        
         //ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SavecustAttendee();
        }catch(Exception ep8){}
        
         ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SavecustAttendee();
        }catch(Exception ep9){}
        // ApexPages.currentPage().getParameters().put('choose','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.SavecustAttendee();
        }catch(Exception ep10){}
         //ApexPages.currentPage().getParameters().put('choose','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
      
        try{
        mme2.SavecustAttendee();
        }catch(Exception ep11){}
        
        
        
        //***********************************************************************************************************************
         
         mme2.attachmentval= Blob.valueOf('test body');
        mme2.youtubevideo=new Widget__c();
       
       mme2.youtubevideo.YouTubeId_c__c = 'src="http://www.youtube.com/watch?v=u8nQa1cJyX8&a=GxdCwVVULXctT2lYDEPllDR0LRTutYfW"';
       mme2.mbepro=new list<MBE_Profile__c>();
       mme2.myimageName='Vinny';
       mme2.mbepro.add(a);
        mme2.eventName1 = EAM.id;
        mme2.newAttendee = attendee;
        mme2.eventSelected= event.id;
        String myString2 = 'StringToBlob';
        mme2.attendeeImage=Blob.valueof(myString2);
        mme2.myImageName='sunny'; 
        
        try{
        ApexPages.currentPage().getParameters().put('updateatt','ewrfe-wgrw&egwrf');
        mme2.commchangeselctdids='ewwrgre-wgr&wegwrf';
        mme2.naicschangeselctdids='ewewrgre-wgr&wegwrf';
        mme2.UpdateAttendee();
        }catch(Exception ep12){}
        
         ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre';
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep13){}
        
       
        ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep14){}
       ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
         mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep15){}
        
         ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre'; 
         try{
        mme2.UpdateAttendee();
        }catch(Exception ep16){}
        
        
        
        
        
        AttendeeSummary__c newAttendee = new AttendeeSummary__c();
        
         newAttendee.AS_Email__c = 'adminpppppp@gmail.com';
         newAttendee.AS_LastName__c = 'Admin';
         newAttendee.AS_FirstName__c = 'BoothLeads';
         mme2.newAttendee = newAttendee;
         mme2.UpdateAttendee();
          
         mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
         
          mme2.Cancel();
          mme2.escapeSpecialCharacters('testString,,""<,>.');
          
        Test.stopTest();
        
        
   }
   }
 
 public static testmethod void myunitest4(){
 
 Profile p1 = [select id from profile where name='Standard User'];
        account aa=new account(name='govtnm');
        insert aa;
        
         contact con=new contact(lastname='n',accountid = aa.id);
            insert con;
         contact con1=new contact(lastname='n',accountid = aa.id);
            insert con1;
         Profile p = [select id from profile where name='Attendee'];
         
    
    User u = new User(alias = 'tesatn', email='test1237777@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con.id,
                  timezonesidkey='America/Los_Angeles',username='test1237777@noemail.com');
                  insert u;
    
    
    User u1 = new User(alias = 'test223', email='test223890@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',contactId=con1.id,
                  timezonesidkey='America/Los_Angeles',username='mythili245.nagandla@gmail.com');
                  insert u1;
    
    
    Event__c event = new Event__c(ownerid=u.id,EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event;
     Event__c ev_nt= [select owner.username from Event__c where id=:event.id];
     Event__c event1 = new Event__c(EV_Title__c = 'testEvent1', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 5392 Name badges', EventDiversityValues__c = 'Reception;monday pass',Is_MatchMaking_Event__c=true);
     insert event1;
     
     
    
     
     
     AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'test1237777@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765');
     insert attendee;
     
     AttendeeSummary__c attendeefordelete = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'mythili3.nagandla@gmail.com', AS_Company__c = 'Global Nest');
     insert attendeefordelete;
     
     AttendeeSummary__c attendeedummy = new AttendeeSummary__c(AS_FirstName__c = 'myt>hily', AS_LastName__c = 'Nag,andla',
         AS_Email__c = 'mythili245.nagandla@gmail.com', AS_Company__c = 'Glo"bal Nest');
     insert attendeedummy;
     
     AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.glob,alnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
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
     AttendeeSummary__c att2 = new AttendeeSummary__c(AS_Age__c = 20, AS_BirthDate__c = date.valueOf('1995-05-05'), AS_BlogUrl__c = 'www.globalnest.com', AS_BusinessDescription__c = 'fgsdamnabfbhsd', AS_BusinessDunsNumber__c = '2450153',
         AS_BusinessEstablishedDate__c = date.valueOf('1995-05-06'), AS_BusinessRevenue__c = 324533, AS_BusinessTaxId__c = 'hngsdvdvf', AS_CellPhone__c = '9858590231',
         AS_Company__c = 'testattendeecompany', AS_DiversityType__c = 'Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
         AS_Email__c = 'test123567892@noemail.com', AS_FaxNumber__c = '9858985032', AS_FirstName__c = 'testattendeesummaryfirstname', AS_Gender__c = 'Male',
         AS_HomeAddress1__c = 'mjbfnmf', AS_HomeAddress2__c = 'nbdfhj', AS_HomeCity__c = 'mhsdfgfd', As_Home_Country__c = 'India', AS_HomePhone__c = '6998878422',
         AS_HomePoBox__c = 22125, AS_HomePoboxNo__c = '84367', As_Home_State__c = 'Goa', AS_HomeZipcode__c = 32121, AS_ImageUrl__c = 'www.globalnest.com', AS_LastName__c = 'testattendeelastname', AS_NAICSCode_1__c = '524621',
         AS_NAICSCode_2__c = '524421', AS_NAICSCode_3__c = '524671', AS_NAICSCode_4__c = '523621', AS_NAICSCode_5__c = '528921',   AS_NumberOfEmployees__c = 200, AS_prefixNew__c = 'mr',
         AS_PrimaryBusinessCategory1__c = 'Accounting', AS_SecondaryBusinessCategory1__c = 'Animation', AS_ShippingAddress1__c = 'dfdf', AS_ShippingAddress2__c = 'dsyhg',
         AS_ShippingCity__c = 'asfdsf', As_Shipping_Country__c = 'India', AS_ShippingPhone__c = '3554353132', AS_ShippingPoBox__c = 32224, AS_Shippingpoboxno__c = '35521', As_Shipping_States__c = 'Goa',
         AS_shippingzip__c = '32122', AS_ShippingZipcode__c = 89524, AS_SuffixNew__c = 'dr', AS_ThroughEventBrite__c = true, AS_Title__c = 'hmjnhgh', AS_WebsiteUrl__c = 'hasdas.com', AS_WorkAddress1__c = 'dsag',
         AS_WorkAddress2__c = 'fdwe', AS_WorkCity__c = 'ewqrwd', AS_Work_Country__c = 'India', AS_WorkPhone__c = '3554353132', AS_WorkPoBox__c = 52346, AS_Workpoboxno__c = '85231', AS_Work_States__c = 'Goa', AS_WorkZipCode__c = 85246, AS_WorkZip__c = '89523',
         Registration_type__c = 'kdsmkas',Commodity_1__c='fdwe',Commodity_2__c='fdwe',Commodity_3__c='fdwe',Commodity_4__c='fdwe',Commodity_5__c='fdwe',Commodity_6__c='fdwe',Commodity_7__c='fdwe',Commodity_8__c='fdwe',Commodity_9__c='fdwe'
);
         
         
         
         //Commodity_1__c='fdwe',Commodity_2__c='fdwe',Commodity_3__c='fdwe',Commodity_4__c='fdwe',Commodity_5__c='fdwe',Commodity_6__c='fdwe',Commodity_7__c='fdwe',Commodity_8__c='fdwe',Commodity_9__c='fdwe'
     insert att2;
     
     Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = attendee.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM;
     
     Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = event1.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
     insert EAM1;
    // Event_Attendee_Mapping__c EAM2 = new Event_Attendee_Mapping__c(EV_id__c = event.id, AS_id__c = att.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
    // insert EAM2;
     List < Event_Attendee_Mapping__c > listOfEvent = new List < Event_Attendee_Mapping__c > ();
     listOfEvent.add(EAM);
     
     List < Event_Attendee_Mapping__c > listOfEvent1 = new List < Event_Attendee_Mapping__c > ();
     listOfEvent1.add(EAM1);
     
     SecurityControls__c sc = new SecurityControls__c(EV_Req_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_Fields__c = 'AS_FirstName__c,AS_LastName__c', EV_id__c = event.id);
     insert sc;
     
     List<Folder> lstFolder = [Select Id From Folder Where Name = 'Logos' ];
      Document document;         
               if(lstFolder.size() > 0)
               {
                   document = new Document(FolderId = lstFolder.get(0).Id, Name='Test Name',Keywords = 'Test');
                   insert document;
                 }
     
      
     List < id > listid = new List < id > ();
     listid.add(EAM.id);
     
     List < id > listid1 = new List < id > ();
     listid.add(EAM1.id);
     
     User_Profile_Event__c UPE = new User_Profile_Event__c (EV_id__c=event.id,User_id__c=u.id);
     MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/05/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                         MatchLeads_Date__c = Date.Parse('11/06/2012'),
                                                         Slot_Time_period__c = '10',
                                                         Start_time__c = '07:30 AM',
                                                         End_Time__c = '07:00 PM',
                                                         Event__c = event.id,
                                                         MAX_noOf_appontments__c=5);  
           insert mdays1;
             Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                        Break_Start_Time__c = ('1:30 PM'),
                                                        Break_Title__c = 'Lunch',
                                                        MatchLeads_Days__c = mdays.id);
           insert breaks;   
           
           NAICS_Code__c naicscode1= new NAICS_Code__c();
              naicscode1.Name='1234';
              naicscode1.Description__c='Naics Sample1';
              insert naicscode1;
              
               NAICS_Code__c naicscode2= new NAICS_Code__c();
              naicscode2.Name='2345';
              naicscode2.Description__c='Naics Sample2';
              insert naicscode2;
           
           
            NAICS_Code__c naicscode3= new NAICS_Code__c();
              naicscode3.Name='3456';
              naicscode3.Description__c='Naics Sample3';
              insert naicscode3;
           
           
           
           Commodities__c C = new Commodities__c();
          C.Description__C = 'Test';
              insert C;
              
               Profile_Settings__c pse = new Profile_Settings__c(Business_Description__c = true,Company_Name__c= true,
                                  Title__c= true,Mobile__c= true,Email_Id__c= true,First_Name__c= true,
                                  KeyWords__c= true,Last_Name__c= true,NAICS_Codes__c= true,Work_Address__c= true,
                                  Work_phone__c= true , Event__c = event.id );
                                  
                  insert pse; 
                  
                   MBE_Profile__c a=new MBE_Profile__c();    
        a.As_prefixNew__c='Mr';
        a.As_SuffixNew__c='Mrs';
        a.As_Shipping_Country__c='India';
        a.As_Shipping_States__c='TS';
        //a.SystemModstamp='AAA'; 
       // a.OwnerId=u.id; 
        a.Name='Vineel'; 
        //a.LastModifiedDate='22-10-1987'; 
        //a.LastModifiedById=23-10-1987;
        //a.LastActivityDate=24-10-1987; 
        //a.IsDeleted=Del; 
        //a.Id='u.id'; 
        //a.CreatedDate=25-10-1987; 
        //'testadm@gmail.com'
        //test1237777@noemail.com
        a.AS_Email__c ='test1237777@noemail.com';
        a.Event_Organizer_Id__c = ev_nt.owner.username;
        system.debug('@@'+ev_nt.owner.username);
        //a.CreatedById=26-10-1987; 
        a.Exhibitor_company_imageUrl__c='www.globalnest.com';
        a.AS_WorkZipCode__c=44322;
        a.AS_WorkPhone__c='(732) 333 4808'; 
        a.AS_WorkCity__c='Hyderabad';  
        //a.AttendeeSummary__c=att.id;
       a.AttendeeSummary__c = attendee.id;
        a.Commodity_1__c ='Accounting';
        a.Commodity_2__c ='Advertising';
        a.Commodity_3__c ='Aerospace';
        a.Commodity_4__c ='Aircraft Repair';
        a.Commodity_5__c ='Architectural Design';
        a.Commodity_6__c ='Artistic Development';
        a.Commodity_7__c ='Assembly';
        a.Commodity_8__c ='Automobiles';
        a.Commodity_9__c ='Automotive';
    insert a;                
     Attachment attmt=new Attachment(Description='test description',name='test file',ContentType='text',parentId = a.id,Body=Blob.valueOf('test body'));
     insert attmt;
    
        cookie  counter = new Cookie('counter',event.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
 
 
  system.runAs(u) {
 test.starttest();
 MM_Eventadmin_AttendeesdirectoryCon mme2 = new MM_Eventadmin_AttendeesdirectoryCon();
 mme2.dummycall();
 //mme2.dummycall2();
 
 
  ApexPages.currentPage().getParameters().put('updateatt','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep17){}
        
        ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf';
        try{
        mme2.UpdateAttendee();
        }catch(Exception epp13){}
 
         ApexPages.currentPage().getParameters().put('updateatt','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep18){}
         ApexPages.currentPage().getParameters().put('updateatt','ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep19){}
         ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
      
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep20){}
        
        
        ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
      
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep22){}
        
        
        ApexPages.currentPage().getParameters().put('updateatt','ewrfe&wrgre-wgrw&egwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre');
        mme2.commchangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
        mme2.naicschangeselctdids='ewr&fewrgre-wgr&wegwrf-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre-ewrfe&wrgre';
      
        try{
        mme2.UpdateAttendee();
        }catch(Exception ep23){}
        
        try{
        mme2.naicschangeids=null;
        mme2.UpdateAttendee();
        }catch(Exception ep21){}
 
 
 MM_Eventadmin_AttendeesdirectoryCon.updatenewstdemail('test1237777@noemail.com','mythili245.nagandla@gmail.com',event.id,eam.id);
 
 test.stoptest();
 }
 }
 
  
 

}