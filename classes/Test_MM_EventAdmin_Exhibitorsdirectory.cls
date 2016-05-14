@istest

public class Test_MM_EventAdmin_Exhibitorsdirectory
{static testmethod void Testmethod_MM_EventAdmin_Exhibitorsdirectory(){

            user uname=[select createdby.id from user where profile.Name Like 'system Administrator' AND Isactive = true Limit 1];
            
            account acc=new account();
            acc.name='Booth Leads';  
            
            acc.ownerid=uname.id;          
            insert acc;
            contact con = new contact(firstname='testcontactfn',lastname='testcontactln',accountId=acc.id);
            insert con;
            
            account acc1=new account();
            acc1.name='Eve Adm';  
            
            acc1.ownerid=uname.id;          
            insert acc1;
            contact con1 = new contact(firstname='testcontactfname',lastname='testcontactlstnm',accountId=acc1.id);
            insert con1;

            contact con2 = new contact(firstname='testconnme',lastname='tesTestnm',accountId=acc1.id);
            insert con2;
            
            Profile p = [select id from profile where name='Booth Admin' limit 1];
             Profile pevAdm = [select id from profile where name='Event Admin' limit 1];
            User u = new User(alias = 'test123', email='ttestt123890@noemail.com',contactId=con.Id,
                              emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                              localesidkey='en_US',country='United States',
                              timezonesidkey='America/Los_Angeles', username='ttestt123890@noemail.com');
            insert u;
            
            Id eventAdminId=u.id;   
            
            User uAd = new User(alias = 'test1234', email='ttestt1238@noemail.com',
                              emailencodingkey='UTF-8',profileid = pevAdm.Id,lastname='Testing11', languagelocalekey='en_US',
                              localesidkey='en_US',country='United States',
                              timezonesidkey='America/Los_Angeles', username='ttestt1238@noemail.com',contactId=con1.id);
            insert uAd;
            
            Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
            insert  customProfileBooth;

            
            Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                                        EV_EndDate__c =  Date.Parse('01/18/2014'),
                                        EV_StartDate__c = Date.Parse('01/19/2014'),
                                        EV_EndTime__c='09:00 AM',
                                        StartTime__c='11:00 AM',Is_MatchMaking_Event__c=true);
            insert eve;
            
            Event__c eve2 = new Event__c(EV_Title__c='Global Event11',EV_HostingTimeZone__c='Eastern Time(USA)',
                                        EV_EndDate__c =  Date.Parse('01/19/2014'),
                                        EV_StartDate__c = Date.Parse('01/20/2014'),
                                        EV_EndTime__c='09:00 AM',
                                        StartTime__c='11:00 AM',Is_MatchMaking_Event__c=true);
            insert eve2;
            
            
            
            Profile_Settings__c pse = new Profile_Settings__c(Business_Description__c = true,Company_Name__c= true,
                                                              Title__c= true,Mobile__c= true,Email_Id__c= true,First_Name__c= true,
                                                              Event__c = eve.id ,
                                                              KeyWords__c= true,Last_Name__c= true,NAICS_Codes__c= true,Work_Address__c= true,
                                                              Work_phone__c= true,DBA__c= true,Contact_Image__c= true,Salutation__c= true,
                                                              Primary_Business_Category__c= true,Secondary_Business_Category__c= true,Website__c= true,
                                                              Country__c= true,State__c= true,Zip_Code__c= true,Manufatures_Country__c= true,
                                                              Distributors_Country__c= true,BBB_Number__c= true,Certificate_Processed_by_RPO__c= true,
                                                              Geographical_Region__c= true,Company_Logo__c= true,Additional_Company_Brouchers__c= true,
                                                              Additional_Company_videos__c= true,Location__c= true,Commodities__c= true,Corporate_First_Name_Visible__c= true,
                                                              Corporate_E_Mail_Visible__c= true,Corporate_Job_Title_Visible__c= true,Products_NOT_interested_visible__c= true,
                                                              Corporate_Mobile_Phone_Visible__c= true,
                                                              Corporate_Company_Visible__c= true,
                                                              Corporate_Work_Address_Visible__c= true,
                                                              Corporate_Phone_Visible__c= true,
                                                              Corporate_NAICS_CODES_Visible__c= true,
                                                              Corporate_Procurement_Visible__c= true,
                                                              Corporate_Business_Description_Visible__c= true,
                                                              Corporate_Salutation_Visible__c= true,
                                                              Corporate_Contact_Image_Visible__c= true,
                                                              Corporate_DBA_Visible__c= true,
                                                              Corporate_Primary_Business_Category_Visi__c= true,
                                                              Corporate_Secondary_Business_Category_Vi__c= true,
                                                              Corporate_Website_Registration_Link_Vi__c= true,
                                                              Corporate_Manufactures_Country_Visible__c= true,
                                                              Corporate_Distributors_Country_Visible__c= true,
                                                              Corporate_BBB_Number_Visible__c= true,
                                                              Corporate_Certificate_Processed_by_RPO_V__c= true,
                                                              Corporate_Geographical_Region_Visible__c= true,
                                                              Corporate_Company_Logo_Visible__c= true,
                                                              Corporate_Additional_Company_Brouchers_V__c= true,
                                                              Corporate_Additional_Company_videos_Visi__c= true,
                                                              Corporate_Country_Visible__c= true,
                                                              Corporate_Commodities_Visible__c= true,
                                                              Corporate_Location_Visible__c= true,
                                                              Corporate_Table_Room_No_Visible__c= true,
                                                              Corporate_exceptional_keywords_visible__c= true,exceptional_keywords__c= true,
                                                              Corporate_Additional_Company_Brouchers_R__c= true,Corporate_Additional_Company_videos_Reqi__c= true,
                                                              Corporate_BBB_Number_Required__c= true,Corporate_Certificate_Processed_by_RPO_R__c= true,
                                                              Corporate_Commodities_Required__c= true,Corporate_Company_Logo_Required__c= true,
                                                              Corporate_Distributors_Country_Required__c= true,Corporate_exceptional_keywords_required__c= true,
                                                              Corporate_Geographical_Region_Required__c= true,Corporate_Location_Required__c= true,
                                                              Corporate_Manufactures_Country_Required__c= true,Corporate_Secondary_Business_Category_Re__c= true,Corporate_Table_Room_No_Requi__c= true,
                                                              Corporate_Website_Registration_Link_Reqi__c= true,Corporate_Business_Description_Required__c= true,Corporate_Company_Required__c= true,
                                                              Corporate_Contact_Image_Required__c= true,Corporate_DBA_Required__c= true,Corporate_E_Mail_Required__c= true,
                                                              Corporate_First_Name_Required__c= true,Corporate_Job_Title_Required__c= true
                                                              ,Corporate_Mobile_Phone_Required__c= true,Corporate_NAICS_CODES_Required__c= true,
                                                              Corporate_Phone_Required__c= true,Corporate_Primary_Business_Category_Reqi__c= true,
                                                              Corporate_Procurement_Required__c= true,Corporate_Salutation_Required__c= true,Corporate_Work_Address_Required__c= true,Products_NOT_interested_Required__c= true,
                                                              name='Corporate');
            insert pse;   
            
            
            Id EventId=eve.Id;
            
            
            AttendeeSummary__c attSummary1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                                                    AS_Email__c = 'testt123890@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_NAICSCode_4__c = '898123',AS_NAICSCode_5__c = '123765',
                                                                    AS_NAICSCode6__c = '812365',AS_NAICSCode7__c = '891235',AS_NAICSCode8__c = '128763',AS_NAICSCode9__c = '192763',AS_ImageUrl__c = 'https://upload.wikimedia.org/wikipedia/en/3/34/SFDC_logo.png');
            insert attSummary1 ;
            update attSummary1 ;
            
            User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,
                                                                    Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
            insert upeEA;
            
            
            Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = eve.id, AS_id__c = attSummary1.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer',IsMatchMakingAttendee__c = true);
            insert EAM1;
            
            List<selectOption> buildingList =new List<selectOption>();
            buildingList.add(new selectOption(EAM1.id,EAM1.AS_id__r.AS_Company__c+'('+EAM1.AS_id__r.AS_FirstName__c+' '+EAM1.AS_id__r.AS_LastName__c+')') ); 
             
           
            
            
            EventSchedule__c es = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', MM_slot_Date__c = Date.Parse('01/18/2014'),
                                                       ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                       MM_To_EAM__c =EAM1.id, MM_slot_StartTime__c='09:30 AM',MM_Slot_End_Time__c='10:30 AM', ES_Location__c='Hello Loc', 
                                                       MM_To_UPE__c =upeEA.id, EV_id__c =eve.id,MM_Slot_Status__c = 'Pending' );
            
            insert es;
            
            
            EventSchedule__c es1 = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', ES_EndDate__c = Date.Parse('01/18/2014'),
                                                        ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                        MM_To_EAM__c =EAM1.id, ES_EndTime__c='09:30 AM', ES_Location__c='Hello Loc', 
                                                        MM_To_UPE__c =upeEA.id, EV_id__c =eve.id,MM_Slot_Status__c = 'Accepted' );
            
            // insert es1;
            
            
            // ------------------ Boothtadmin Insert ---------------------
            
            user bAdmin =  new User(alias = 'testboot', email='testboothadmin1@noemail.com',firstName='phani',
                                    emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                                    localesidkey='en_US',country='United States',ContactId=con2.id,
                                    timezonesidkey='America/Los_Angeles', username='testboothadmin1@noemail.com',CompanyAddr1__c ='global"//',CompanyAddr2__c='global"//',CompanyName='Globalnest',Zipcode__c='02345',PoBox__c='02345');
            insert bAdmin ;
            Id boothAdminId=bAdmin.id;
            
            
            Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
            insert  customProfile;
            
            Booth__c booth = new Booth__c(BT_Name__c='TestBooth',BT_BoothUserCount__c=100.0,EV_id__c=EventId);
            insert booth; 
            string boothId =booth.Id;
            
            AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                                                 AS_Email__c = 'testboothadmin1@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_NAICSCode_4__c = '898123',AS_NAICSCode_5__c = '123765',
                                                                 AS_NAICSCode6__c = '812365',AS_NAICSCode7__c = '891235',AS_NAICSCode8__c = '128763',AS_NAICSCode9__c = '192763',AS_ImageUrl__c = 'https://upload.wikimedia.org/wikipedia/en/3/34/SFDC_logo.png');
            insert attendee;

            
            User_Profile_Event__c upebooth = new User_Profile_Event__c(BoothAdmin_id__c=boothAdminId,BT_id__c=boothId ,EV_id__c=EventId,
                                                                       EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfile.id,
                                                                       Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true,
                                                                       Attendee_Summary__c =attendee.id, isFirstBoothAdmin__c=true,IsMatchMakingUser__c=true,
                                                                       Request_for_upgrade_profile__c = false);         
            insert upebooth;  
            
                       
             MBE_Profile__c a=new MBE_Profile__c();    
        a.As_prefixNew__c='Mr';
        a.As_SuffixNew__c='Mrs';
        a.As_Shipping_Country__c='India';
        a.As_Shipping_States__c='TS';
        a.Name='Vineel';
        a.AS_Email__c = 'testboothadmin1@noemail.com';
        a.Exhibitor_company_imageUrl__c='www.globalnest.com';
        a.AS_WorkZipCode__c=44322;
        a.AS_WorkPhone__c='(732) 333 4808'; 
        a.AS_WorkCity__c='Hyderabad';  
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
           
             
            system.debug('*************** a00Z000000J0QBgIAN ----'+upebooth.EV_id__c); 
            
            List < User_Profile_Event__c > listOfEam = new List < User_Profile_Event__c > ();
            listOfEam.add(upebooth);
            
            NAICS_Code__c N = new  NAICS_Code__c();
            N.Name = '123456';      
            insert N;
            
            Commodities__c C = new Commodities__c();
            C.Description__C = 'Test';
            insert C;
            
            MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                              MatchLeads_Date__c = Date.Parse('01/18/2014'),
                                                              Slot_Time_period__c = '10',
                                                              Start_time__c = '07:30 AM',
                                                              End_Time__c = '07:00 PM',
                                                              Event__c = EventId,
                                                              MAX_noOf_appontments__c=5);  
            insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                               MatchLeads_Date__c = Date.Parse('01/19/2014'),
                                                               Slot_Time_period__c = '10',
                                                               Start_time__c = '07:30 AM',
                                                               End_Time__c = '07:00 PM',
                                                               Event__c = EventId,
                                                               MAX_noOf_appontments__c=5);  
            insert mdays1;
            Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                         Break_Start_Time__c = ('1:30 PM'),
                                                         Break_Title__c = 'Lunch',
                                                         MatchLeads_Days__c = mdays.id);
            insert breaks; 
            
            Event_Breaks__c blokslistexist = new Event_Breaks__c(Break_End_Time__c = ('2:00 PM'),
                                                                 Break_Start_Time__c = ('1:00 PM'),
                                                                 User_Profile_Event__c = upebooth.id,
                                                                 
                                                                 MatchLeads_Days__c = mdays.id);
            
            cookie  counter = new Cookie('counter',EventId,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            
            system.runAs(u){
                
                EmailTemplate validEmailTemplate = new EmailTemplate();
            validEmailTemplate.isActive = true;
            validEmailTemplate.Name = 'MatchMaking Cancellation Email to MBE';
            validEmailTemplate.DeveloperName = 'CreatedByAnil';
            validEmailTemplate.TemplateType = 'text';
            validEmailTemplate.FolderId = UserInfo.getUserId();
                insert validEmailTemplate;
                
                MM_Eventadmin_ExhibitorsdirectoryCon BoothAdminsCon = new MM_Eventadmin_ExhibitorsdirectoryCon();
                
                BoothAdminsCon.selectedcommoditylist = C;
                set<string> str=new set<string>{'naics111','naics222'};
                BoothAdminsCon.naicsset=str;
                list<string> str1=new list<string>{'naics111','naics222'};
                BoothAdminsCon.selecteddelnaicsplit=str1;
                BoothAdminsCon.naicsdellist =n;
                BoothAdminsCon.naicsMultiple=str1;
                BoothAdminsCon.hdnCriteriaTxt='test11123';
                BoothAdminsCon.psObj=pse;
                BoothAdminsCon.CheckboxBool=true;
                BoothAdminsCon.CheckboxBool1=false;
                BoothAdminsCon.norecordsalert=true;
                BoothAdminsCon.confirmdelsh=false;
                BoothAdminsCon.multiselectpicklist=true;   
                BoothAdminsCon.selectedNAICS1='aaaa';
                BoothAdminsCon.selectedNAICS2='bbbb';
                BoothAdminsCon.selecteddelnaic='cccc';
                BoothAdminsCon.naicsalertbool=true;
                BoothAdminsCon.ShowPage=false;
                BoothAdminsCon.imageerror=true;
                BoothAdminsCon.attfilesize=1234;
                BoothAdminsCon.imageerrormsg='cccc';
                BoothAdminsCon.myimageName='dddd';
                BoothAdminsCon.HideTable=true;
                BoothAdminsCon.CloseBoothName=false;
                BoothAdminsCon.CloseBoothLocation=true;
                BoothAdminsCon.Country='India';
                BoothAdminsCon.state='TS';
                BoothAdminsCon.Selectedstatus='Active';
                BoothAdminsCon.BoothSelected='Booth1';
                BoothAdminsCon.errordisplycorp=true;
                BoothAdminsCon.Errormessagesch='Error, Give right values';
                BoothAdminsCon.errorbool=false;
                BoothAdminsCon.message='Convery';
                //BoothAdminsCon.selected=true;
                //BoothAdminsCon.slot='Dont Slot';
                BoothAdminsCon.viewStatusPopup=true;
                BoothAdminsCon.Blockschedulebool=false;
                BoothAdminsCon.pageno=2;
                BoothAdminsCon.commonMethod();
                BoothAdminsCon.selectEvent=counter.getvalue();
                BoothAdminsCon.CheckUser(); 
                BoothAdminsCon.selectedDate = string.valueOf(mdays.MatchLeads_Date__c);
                BoothAdminsCon.SelectedBooth=boothId ;
                BoothAdminsCon.AddBooth();
                BoothAdminsCon.selectevent = EventId;
                
                
                BoothAdminsCon.eventDetails = new Event__c();
                BoothAdminsCon.SelectValAs = 'tetst12';
                BoothAdminsCon.selectednaicscodeslist = new NAICS_Code__c();
                BoothAdminsCon.selectednacslist = new List<String>();
                BoothAdminsCon.naicscods = new list<string>();
                BoothAdminsCon.commodities = new list<string>();
                BoothAdminsCon.mydoc = new document();
                BoothAdminsCon.mydoc1 = new document();
                BoothAdminsCon.MM_Eventadmin_ExhibitorsdirectoryCon = new List<User_Profile_Event__c>();
                BoothAdminsCon.ForPaginationBoothAdminsList = new List<User_Profile_Event__c>();
                BoothAdminsCon.eventslistforselect = new List<selectoption>();
                BoothAdminsCon.EventsList = new List<User_Profile_Event__c>();
                BoothAdminsCon.listOfBoothadminsforExport = new List<User_Profile_Event__c>();
                BoothAdminsCon.SelectedEventId = new Event__c();
                //BoothAdminsCon.eschedules = new List<EventSchedule__c>();
                BoothAdminsCon.slot = Boolean.valueOf('true');
                BoothAdminsCon.startTimeMM = Time.newInstance(1, 2, 3, 4);
                BoothAdminsCon.ENdTimeMM = Time.newInstance(1, 3, 4, 4);
                BoothAdminsCon.dummylist = new EventSchedule__c();
                BoothAdminsCon.upedetails = new User_Profile_Event__c();
                BoothAdminsCon.statusOptions = new List<SelectOption>();
                BoothAdminsCon.statusSize = 5;
                BoothAdminsCon.ShowDatePicklist = Boolean.valueOf('true');
                BoothAdminsCon.openSlotsList1 = new SET<String>();
                BoothAdminsCon.selectedStatusSet = new SET<String>();
                BoothAdminsCon.eventDatesString = 'test45624';
                

                
  
                
                system.debug('************** selectevent ----'+BoothAdminsCon.selectevent );
                User_Profile_Event__c upebooth1 = new User_Profile_Event__c(BoothAdmin_id__c=boothAdminId,BT_id__c=boothId ,EV_id__c=EventId ,
                                                                            EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfile.id,
                                                                            Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true,MAtchMakingProfile__c ='Corporate',
                                                                            Attendee_Summary__c =attendee.id, isFirstBoothAdmin__c=true,IsMatchMakingUser__c=true,
                                                                            Request_for_upgrade_profile__c = false);         
                insert upebooth1; 
                system.debug('********* upebooth********'+attendee.AS_Company__c+'KKKKKKKKKk '+attendee.AS_FirstName__c+'*********'+attendee.AS_LastName__c);
                BoothAdminsCon.BoothAdminsList.add(upebooth1);
                
                BoothAdminsCon.prosettings(); 
                BoothAdminsCon.isSaved=true;    
                BoothAdminsCon.ListOfBoothAdmins();
                BoothAdminsCon.selectedBooth =boothId;
                PageReference pageRef = Page.BL_EventAdmin_BoothAdmins;
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('BoothName',boothId);
                User_Profile_Event__c upebooth2 = new User_Profile_Event__c(BoothAdmin_id__c=boothAdminId,BT_id__c=boothId ,EV_id__c=EventId ,
                                                                            EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfile.id,
                                                                            Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true,MAtchMakingProfile__c ='Corporate',
                                                                            Attendee_Summary__c =attendee.id, isFirstBoothAdmin__c=true,IsMatchMakingUser__c=true,
                                                                            Request_for_upgrade_profile__c = false);         
                insert upebooth2; 
                system.debug('********* upebooth********'+attendee.AS_Company__c+'KKKKKKKKKk '+attendee.AS_FirstName__c+'*********'+attendee.AS_LastName__c);
                BoothAdminsCon.BoothAdminsList.add(upebooth2);
                BoothAdminsCon.availableBADS.add(new Selectoption(attendee.AS_Company__c,attendee.AS_Company__c+'('+attendee.AS_FirstName__c + ' '+attendee.AS_LastName__c+')'));
                
                // BoothAdminsCon.ListOfBoothAdmins();
                
                BoothAdminsCon.Next();
                
                BoothAdminsCon.First();
                BoothAdminsCon.pageno=2;
                BoothAdminsCon.isc = 3;
                BoothAdminsCon.PgNo = 1;
                MM_Eventadmin_ExhibitorsdirectoryCon.InnerClass mmIc = new MM_Eventadmin_ExhibitorsdirectoryCon.InnerClass(upebooth1,'thisIstest');
                BoothAdminsCon.ListOfInnerClass = new list<MM_Eventadmin_ExhibitorsdirectoryCon.InnerClass>{mmIc};
                BoothAdminsCon.Previous();
                
                BoothAdminsCon.ListOfInnerClass = new list<MM_Eventadmin_ExhibitorsdirectoryCon.InnerClass>{mmIc};
                BoothAdminsCon.Next();
                BoothAdminsCon.ListOfInnerClass = new list<MM_Eventadmin_ExhibitorsdirectoryCon.InnerClass>{mmIc};
                BoothAdminsCon.Last();
                BoothAdminsCon.Previous();
                
                
                
                BoothAdminsCon.AddBooth();
                BoothAdminsCon.Email = 'test+123@gmail.com';
                
                BoothAdminsCon.BoothAdminDetails=upebooth.id;   
                BoothAdminsCon.ParticularJuncID=upebooth;
                BoothAdminsCon.DisplayBoothAdminDetails();
                
                BoothAdminsCon.EditBoothAdmin();
                // BoothAdminsCon.selectedBooth = null; 
                ApexPages.currentPage().getParameters().put('updateat','fffff');
                
                BoothAdminsCon.UpdateUser();
                BoothAdminsCon.selectedBooth = boothId; 
                ApexPages.currentPage().getParameters().put('updateat',attendee.id);
                BoothAdminsCon.UpdateUser();
                BoothAdminsCon.selectednacslist= new list<string>();
                ApexPages.currentPage().getParameters().put('updateat',attendee.id);
                BoothAdminsCon.UpdateUser();
                //BoothAdminsCon.deleteboothadmin();
                //BoothAdminsCon.StatesCountry();
                BoothAdminsCon.selectedBooth = null; 
                BoothAdminsCon.ClosePopUp();
                BoothAdminsCon.convertToBoothstaff();
                
                BoothAdminsCon.Booth.BT_Name__c ='Sample Booth ';
                BoothAdminsCon.selectevent =EventId;
                BoothAdminsCon.BoothAdminUser = new User();
                BoothAdminsCon.BoothAdminUser.LastName ='mythily';
                BoothAdminsCon.BoothAdminUser.FirstName='R';
                BoothAdminsCon.BoothAdminUser.Email =BoothAdminsCon.Email ;
                BoothAdminsCon.BoothAdminUser.Username =BoothAdminsCon.Email ;
                BoothAdminsCon.BoothAdminUser.TimeZoneSidKey ='America/Los_Angeles';
                BoothAdminsCon.BoothAdminUser.EmailEncodingKey='UTF-8'; 
                BoothAdminsCon.BoothAdminUser.CompanyName='IBM'; 
                BoothAdminsCon.BoothAdminUser.Alias ='BAdmin';
                Profile p1 = [select id from profile where name='Booth Admin'];
                BoothAdminsCon.BoothAdminUser.ProfileID =p1.Id;
                BoothAdminsCon.BoothAdminUser.LocaleSidKey ='en_US';
                BoothAdminsCon.BoothAdminUser.LanguageLocaleKey ='en_US';
                BoothAdminsCon.BoothAdminUser.CommunityNickname ='myth';
                BoothAdminsCon.A = new Account();
                BoothAdminsCon.A.Name =BoothAdminsCon.BoothAdminUser.CompanyName; 
                BoothAdminsCon.Con = new Contact();
                BoothAdminsCon.Con.LastName =BoothAdminsCon.BoothAdminUser.LastName; 
                BoothAdminsCon.Con.Accountid= BoothAdminsCon.A.id;
                
                BoothAdminsCon.liupe = new List<User_Profile_Event__c>();
                BoothAdminsCon.listofupe = new List<User_Profile_Event__c>();
                
                AttendeeSummary__c attendee1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                                                      AS_Email__c = 'test+123@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654-Naics Sample1', AS_NAICSCode_2__c = '123456-Naics Sample2', AS_NAICSCode_3__c = '898765-Naics Sample3',AS_NAICSCode_4__c = '324516-Naics Sample4',AS_NAICSCode_5__c = '908768-Naics Sample5',
                                                                      AS_NAICSCode6__c = '812365',AS_NAICSCode7__c = '891235',AS_NAICSCode8__c = '128763',AS_NAICSCode9__c = '192763');
                insert attendee1;
                
                AttendeeSummary__c attendee2 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                                                      AS_Email__c = 'test+12323@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654-Naics Sample1', AS_NAICSCode_2__c = '123456-Naics Sample2', AS_NAICSCode_3__c = '898765-Naics Sample3',AS_NAICSCode_4__c = '324516-Naics Sample4',AS_NAICSCode_5__c = '908765-Naics Sample5',AS_NAICSCode6__c = '812365',AS_NAICSCode7__c = '891235',AS_NAICSCode8__c = '128763',AS_NAICSCode9__c = '192763');
                insert attendee2;
                
                AttendeeSummary__c attendee3 = new AttendeeSummary__c(AS_FirstName__c = 'mythilyn', AS_LastName__c = 'Nagandla',
                                                                      AS_Email__c = 'test+1232345@gmail.com', AS_Company__c = 'GlobalNest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'Inida', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654-Naics Sample1', AS_NAICSCode_2__c = '123456-Naics Sample2', AS_NAICSCode_3__c = '898765-Naics Sample3',AS_NAICSCode_4__c = '324516-Naics Sample4',AS_NAICSCode_5__c = '908765-Naics Sample5',AS_NAICSCode6__c = '812365',AS_NAICSCode7__c = '891235',AS_NAICSCode8__c = '128763',AS_NAICSCode9__c = '192763');
                upsert attendee3;
                
                            
                Profile__c customProfileBooth1= new Profile__c (PR_Name__c='CorporateStaff',PR_Version__c='3.0');        
                insert  customProfileBooth1;
                
                BoothAdminsCon.Email = 'tt@gmai.com';
                BoothAdminsCon.Email = 'ttestt90@noemail.com';
                //BoothAdminsCon.SaveBooth();
                BoothAdminsCon.Email = 'ttestt123890@noemail.com';
                BoothAdminsCon.selectEvent = EventId;
                BoothAdminsCon.SaveBooth();
                
                try {/*
                BoothAdminsCon.email ='test+12323@gmail.com';
                BoothAdminsCon.attendeeImage = blob.valueOf('tewrtegdgrhfgh');
                BoothAdminsCon.myimageName = 'tewrtegdgdfg4h';*/
                BoothAdminsCon.SelectEvent = eve.id;
                BoothAdminsCon.forattendee();
                
                }
                catch(exception ev) { } 
                
                BoothAdminsCon.login() ;
                BoothAdminsCon.BoothAdminDetails = UpeEa.id;
                //BoothAdminsCon.viewschedule();
                //BoothAdminsCon.BoothAdminsList  = listOfEam ;
                BoothAdminsCon.selectEvent=counter.getvalue(); 
                
                BoothAdminsCon.selectedStatusList= new LIST<String>();
                BoothAdminsCon.selectedStatusList.add('Accepted');
                
                string s = string.valueOf(mdays1.MatchLeads_Date__c);
                BoothAdminsCon.selectedEventDate=s.replaceAll('-','/');
                //BoothAdminsCon.splitTimeSlots();
                BoothAdminsCon.selectedTimeSlot = '9:30 AM-9:40 AM';
                Test.startTest();
                BoothAdminsCon.attetdeesListToMatch();
                BoothAdminsCon.ExhibitorsFromBL();
                
                
                try {
                BoothAdminsCon.availableBADSinMM = buildingList;
                BoothAdminsCon.SelectEvent = eve.id;
                BoothAdminsCon.saveExhibitors();
                }
                catch(exception ex) { }
                //BoothAdminsCon.saveexhibitors();
                
                // BoothAdminsCon.matchselectedAttendee();
                //BoothAdminsCon.printschedule();
                //BoothAdminsCon.emailschedule();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                BoothAdminsCon.commsselctdids = ApexPages.currentPage().getParameters().put('updateattcomm ','test-test1');
                BoothAdminsCon.commchangeselctdids = BoothAdminsCon.commsselctdids ;
                //BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                /* BoothAdminsCon.SaveBooth();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                BoothAdminsCon.commsselctdids = ApexPages.currentPage().getParameters().put('updateattcomm ','test-test1-test2');
                BoothAdminsCon.commchangeselctdids = BoothAdminsCon.commsselctdids ;
                BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                BoothAdminsCon.SaveBooth();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                BoothAdminsCon.commsselctdids = ApexPages.currentPage().getParameters().put('updateattcomm ','test-test1-test2-test3');
                BoothAdminsCon.commchangeselctdids = BoothAdminsCon.commsselctdids ;
                // BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                BoothAdminsCon.SaveBooth();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3-test4');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                BoothAdminsCon.commsselctdids = ApexPages.currentPage().getParameters().put('updateattcomm ','test-test1-test2-test3-test4');
                BoothAdminsCon.commchangeselctdids = BoothAdminsCon.commsselctdids ;
                BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                BoothAdminsCon.SaveBooth();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3-test4');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                BoothAdminsCon.commsselctdids = ApexPages.currentPage().getParameters().put('updateattcomm ','test-test1');
                BoothAdminsCon.commchangeselctdids = BoothAdminsCon.commsselctdids ;
                BoothAdminsCon.UpdateUser();*/
                // BoothAdminsCon.Blockedacti
                //BoothAdminsCon.SaveBooth();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3-test4-test5');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                BoothAdminsCon.commsselctdids = ApexPages.currentPage().getParameters().put('updateattcomm ','test-test1-test2-test3-test4-test5');
                BoothAdminsCon.commchangeselctdids = BoothAdminsCon.commsselctdids ;
                
                BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                BoothAdminsCon.SaveBooth();
                /*BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3-test4-test5-test6');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                
                BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                BoothAdminsCon.SaveBooth();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3-test4-test5-test6-test7');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                
                BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                BoothAdminsCon.SaveBooth();
                BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3-test4-test5-test6-test7-test8');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                
                BoothAdminsCon.UpdateUser();
                // BoothAdminsCon.Blockedacti
                BoothAdminsCon.SaveBooth();
                //BoothAdminsCon.naicsselctdids =ApexPages.currentPage().getParameters().put('updateatt','test-test1-test2-test3-test4-test5-test6-test7-test8-test9');
                BoothAdminsCon.naicschangeselctdids = BoothAdminsCon.naicsselctdids ;
                
                BoothAdminsCon.UpdateUser();
                
                BoothAdminsCon.SaveBooth();*/
                
                BoothAdminsCon.escape('escapebooth');
                //BoothAdminsCon.printboothadmindetails();
                BoothAdminsCon.toggleSort();
                BoothAdminsCon.commchangeselctdids = ApexPages.currentPage().getParameters().put('comm','test-test1');
                BoothAdminsCon.commodityfun();
                MM_Eventadmin_ExhibitorsdirectoryCon.innercl inrl = new  MM_Eventadmin_ExhibitorsdirectoryCon.innercl('test',true);     
                BoothAdminsCon.delvideo();
                BoothAdminsCon.delattachment();
                BoothAdminsCon.ImportAttendee();
                // BoothdminsCon.BoothAdminsList.addAll(listOfEam);
                
                BoothAdminsCon.selectednaicscodeslist = N;   
                User_Profile_Event__c upebooth3 = new User_Profile_Event__c(BoothAdmin_id__c=boothAdminId,BT_id__c=boothId ,EV_id__c=EventId ,
                                                                            EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfile.id,
                                                                            Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true,MAtchMakingProfile__c ='Corporate',
                                                                            Attendee_Summary__c =attendee.id, isFirstBoothAdmin__c=true,IsMatchMakingUser__c=true,
                                                                            Request_for_upgrade_profile__c = false);         
                insert upebooth3; 
                system.debug('********* upebooth********'+attendee.AS_Company__c+'KKKKKKKKKk '+attendee.AS_FirstName__c+'*********'+attendee.AS_LastName__c);
                BoothAdminsCon.BoothAdminsList.add(upebooth3); 
                BoothAdminsCon.Exportcorporate();
                BoothAdminsCon.closeexhibitorpopup();
                // BoothAdminsCon.forSchedule();
                BoothAdminsCon.serarchstringvalue='mythily';
                BoothAdminsCon.search();
                Apexpages.currentpage().getparameters().put('alphabit','m');
                BoothAdminsCon.alphasorting();
                Apexpages.currentpage().getparameters().put('alphabit','All');
                BoothAdminsCon.alphasorting();
                BoothAdminsCon.naicscodesfun();
                BoothAdminsCon.CheckUser();
                BoothAdminsCon.prosettings();
                //BoothAdminsCon.savesettings();
                BoothAdminsCon.convertToBoothstaff();
                BoothAdminsCon.selectedstaffperson = upebooth2.id;
                
                // BoothAdminsCon.AddtoTable();  
                BoothAdminsCon.blockschedules();
                //BoothAdminsCon.pageno=0;  
                BoothAdminsCon.Next();
                //Event_Breaks__c Ev = new Event_Breaks__c(Break_End_Time__c ='01:00 PM', Break_Start_Time__c ='02:00 PM' ,User_Profile_Event__c =upebooth1.id,MatchLeads_Days__c =  '3' );
                //insert Ev;
                // BoothAdminsCon.blockselecteddate = '3';
                BoothAdminsCon.blockedslots.add(new selectoption('10-11','10-11'));
                BoothAdminsCon.Blockedaction();
                
                BoothAdminsCon.ToInsertAttendeeSummery(attSummary1,u);
                BoothAdminsCon.testdummy();
                try { 
                    BoothAdminsCon.InsertUser();
                } catch (exception ex) {}
                
                try { /*
                    BoothAdminsCon.
                    BoothAdminsCon.; */
                }catch (exception ex) {}
                
                //BoothAdminsCon.massemailschedules();
                try{
                MM_Eventadmin_ExhibitorsdirectoryCon.changetablenumber(upeEA.id,'test3yuh');
                }catch (exception e5){}
                try{
                MM_Eventadmin_ExhibitorsdirectoryCon.checkattendee('testboothadmin1@noemail.com',Eventid);
                }catch (exception e6){}
                //try{
                //MM_Eventadmin_ExhibitorsdirectoryCon.updatenewemail('ttestt123890@noemail.com','testt123890@noemail.com',EventId,upebooth.id);
               // }catch (exception e7){}
                try{
                MM_Eventadmin_ExhibitorsdirectoryCon.updateexstdemail('testboothadmin1@noemail.com','ttestt123890@noemail.com',EventId,upebooth.id);
                }catch (exception e7){}

                try{
                BoothAdminsCon.PrintBoothAdminDetails();
                }catch (exception e8){}
                try{
                BoothAdminsCon.delimage();
                }catch (exception e9){}  
                try{
                //BoothAdminsCon.ToUpdateMBEProfile(attSummary1, eve, new Document());  
                }catch (exception e9){} 
                try{
                BoothAdminsCon.savesettings();
                }catch (exception e9){}
                try{
                BoothAdminsCon.selectedregions = new list<string>{'Anil','Manoj'};
                BoothAdminsCon.ExhibitorImage = blob.valueOf('dfgdfgdfhdfgh');
                BoothAdminsCon.ToUpdateAttendeeSummery(attendee,bAdmin);
                BoothAdminsCon.myimageName = 'AnilTest';
                }catch (exception e9){}
                try{
                BoothAdminsCon.AddtoTable();
                }catch (exception e9){}
                try{
                BoothAdminsCon.ToUpdateUserDetails(attendee ,bAdmin );
                }catch (exception e9){}
                try{
                BoothAdminsCon.ToInsertMBEProfile(attendee ,Eve, new Document());
                }catch (exception e9){}
                try{
                BoothAdminsCon.deleteboothadmin();
                }catch (exception e9){}
                

                
               Test.stopTest();  
              

}

}

static testmethod void Testmethod_MM_EventAdmin_Exhibitorsdirectory1(){

            user uname=[select createdby.id from user where profile.Name Like 'system Administrator' AND Isactive = true Limit 1];
            
            account acc=new account();
            acc.name='Booth Leads';  
            
            acc.ownerid=uname.id;          
            insert acc;
            contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
            insert con;
            
            Profile p = [select id from profile where name='system Administrator'];
            
            User u = new User(alias = 'test123', email='ttestt123890@noemail.com',
                              emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                              localesidkey='en_US',country='United States',
                              timezonesidkey='America/Los_Angeles', username='ttestt123899@noemail.com');
            insert u;
            
            Id eventAdminId=u.id;   
            
            Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
            insert  customProfileBooth;

            
            Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                                        EV_EndDate__c =  Date.Parse('01/18/2014'),
                                        EV_StartDate__c = Date.Parse('01/19/2014'),
                                        EV_EndTime__c='09:00 AM',
                                        StartTime__c='11:00 AM',Is_MatchMaking_Event__c=true);
            insert eve;
            Profile_Settings__c pse = new Profile_Settings__c(Business_Description__c = true,Company_Name__c= true,
                                                              Title__c= true,Mobile__c= true,Email_Id__c= true,First_Name__c= true,
                                                              Event__c = eve.id ,
                                                              KeyWords__c= true,Last_Name__c= true,NAICS_Codes__c= true,Work_Address__c= true,
                                                              Work_phone__c= true,DBA__c= true,Contact_Image__c= true,Salutation__c= true,
                                                              Primary_Business_Category__c= true,Secondary_Business_Category__c= true,Website__c= true,
                                                              Country__c= true,State__c= true,Zip_Code__c= true,Manufatures_Country__c= true,
                                                              Distributors_Country__c= true,BBB_Number__c= true,Certificate_Processed_by_RPO__c= true,
                                                              Geographical_Region__c= true,Company_Logo__c= true,Additional_Company_Brouchers__c= true,
                                                              Additional_Company_videos__c= true,Location__c= true,Commodities__c= true,Corporate_First_Name_Visible__c= true,
                                                              Corporate_E_Mail_Visible__c= true,Corporate_Job_Title_Visible__c= true,Products_NOT_interested_visible__c= true,
                                                              Corporate_Mobile_Phone_Visible__c= true,
                                                              Corporate_Company_Visible__c= true,
                                                              Corporate_Work_Address_Visible__c= true,
                                                              Corporate_Phone_Visible__c= true,
                                                              Corporate_NAICS_CODES_Visible__c= true,
                                                              Corporate_Procurement_Visible__c= true,
                                                              Corporate_Business_Description_Visible__c= true,
                                                              Corporate_Salutation_Visible__c= true,
                                                              Corporate_Contact_Image_Visible__c= true,
                                                              Corporate_DBA_Visible__c= true,
                                                              Corporate_Primary_Business_Category_Visi__c= true,
                                                              Corporate_Secondary_Business_Category_Vi__c= true,
                                                              Corporate_Website_Registration_Link_Vi__c= true,
                                                              Corporate_Manufactures_Country_Visible__c= true,
                                                              Corporate_Distributors_Country_Visible__c= true,
                                                              Corporate_BBB_Number_Visible__c= true,
                                                              Corporate_Certificate_Processed_by_RPO_V__c= true,
                                                              Corporate_Geographical_Region_Visible__c= true,
                                                              Corporate_Company_Logo_Visible__c= true,
                                                              Corporate_Additional_Company_Brouchers_V__c= true,
                                                              Corporate_Additional_Company_videos_Visi__c= true,
                                                              Corporate_Country_Visible__c= true,
                                                              Corporate_Commodities_Visible__c= true,
                                                              Corporate_Location_Visible__c= true,
                                                              Corporate_Table_Room_No_Visible__c= true,
                                                              Corporate_exceptional_keywords_visible__c= true,exceptional_keywords__c= true,
                                                              Corporate_Additional_Company_Brouchers_R__c= true,Corporate_Additional_Company_videos_Reqi__c= true,
                                                              Corporate_BBB_Number_Required__c= true,Corporate_Certificate_Processed_by_RPO_R__c= true,
                                                              Corporate_Commodities_Required__c= true,Corporate_Company_Logo_Required__c= true,
                                                              Corporate_Distributors_Country_Required__c= true,Corporate_exceptional_keywords_required__c= true,
                                                              Corporate_Geographical_Region_Required__c= true,Corporate_Location_Required__c= true,
                                                              Corporate_Manufactures_Country_Required__c= true,Corporate_Secondary_Business_Category_Re__c= true,Corporate_Table_Room_No_Requi__c= true,
                                                              Corporate_Website_Registration_Link_Reqi__c= true,Corporate_Business_Description_Required__c= true,Corporate_Company_Required__c= true,
                                                              Corporate_Contact_Image_Required__c= true,Corporate_DBA_Required__c= true,Corporate_E_Mail_Required__c= true,
                                                              Corporate_First_Name_Required__c= true,Corporate_Job_Title_Required__c= true
                                                              ,Corporate_Mobile_Phone_Required__c= true,Corporate_NAICS_CODES_Required__c= true,
                                                              Corporate_Phone_Required__c= true,Corporate_Primary_Business_Category_Reqi__c= true,
                                                              Corporate_Procurement_Required__c= true,Corporate_Salutation_Required__c= true,Corporate_Work_Address_Required__c= true,Products_NOT_interested_Required__c= true,
                                                              name='Corporate');
            insert pse;   
            
            
            Id EventId=eve.Id;
            
            
            AttendeeSummary__c attSummary1 = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                                                    AS_Email__c = 'ttestt123899@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_NAICSCode_4__c = '898123',AS_NAICSCode_5__c = '123765',
                                                                    AS_NAICSCode6__c = '812365',AS_NAICSCode7__c = '891235',AS_NAICSCode8__c = '128763',AS_NAICSCode9__c = '192763',AS_ImageUrl__c = 'https://upload.wikimedia.org/wikipedia/en/3/34/SFDC_logo.png');
            insert attSummary1 ;
            update attSummary1 ;
            
            Event_Attendee_Mapping__c EAM1 = new Event_Attendee_Mapping__c(EV_id__c = eve.id, AS_id__c = attSummary1.id,checkbox_dataTable__c=true, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer',IsMatchMakingAttendee__c = true);
            insert EAM1;
            
            
            User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,
                                                                    Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
            insert upeEA; 
            
            
            EventSchedule__c es = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', MM_slot_Date__c = Date.Parse('01/18/2014'),
                                                       ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                       MM_To_EAM__c =EAM1.id, MM_slot_StartTime__c='09:30 AM',MM_Slot_End_Time__c='10:30 AM', ES_Location__c='Hello Loc', 
                                                       MM_To_UPE__c =upeEA.id, EV_id__c =eve.id,MM_Slot_Status__c = 'Pending' );
            
            insert es;
            
            
            EventSchedule__c es1 = new EventSchedule__c(ES_ProgramName__c = 'Test Schedule', ES_EndDate__c = Date.Parse('01/18/2014'),
                                                        ES_StartDate__c = Date.Parse('01/18/2014'),ES_StartTime__c='09:00 AM',
                                                        MM_To_EAM__c =EAM1.id, ES_EndTime__c='09:30 AM', ES_Location__c='Hello Loc', 
                                                        MM_To_UPE__c =upeEA.id, EV_id__c =eve.id,MM_Slot_Status__c = 'Accepted' );
            
            // insert es1;
            
            
            // ------------------ Boothtadmin Insert ---------------------
            
            user bAdmin =  new User(alias = 'testboot', email='testboothadmin1@noemail.com',firstName='phani',
                                    emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                                    localesidkey='en_US',country='United States',
                                    timezonesidkey='America/Los_Angeles', username='testboothadmin1@noemail.com',CompanyAddr1__c ='global"//',CompanyAddr2__c='global"//',CompanyName='Globalnest',Zipcode__c='02345',PoBox__c='02345');
            insert bAdmin ;
            Id boothAdminId=bAdmin.id;
            
            
            Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
            insert  customProfile;
            
            Booth__c booth = new Booth__c(BT_Name__c='TestBooth',BT_BoothUserCount__c=100.0,EV_id__c=EventId);
            insert booth; 
            string boothId =booth.Id;
            
            AttendeeSummary__c attendee = new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
                                                                 AS_Email__c = 'testboothadmin1@noemail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_NAICSCode_4__c = '898123',AS_NAICSCode_5__c = '123765',
                                                                 AS_NAICSCode6__c = '812365',AS_NAICSCode7__c = '891235',AS_NAICSCode8__c = '128763',AS_NAICSCode9__c = '192763',AS_ImageUrl__c = 'https://upload.wikimedia.org/wikipedia/en/3/34/SFDC_logo.png');
            insert attendee;

            
            User_Profile_Event__c upebooth = new User_Profile_Event__c(BoothAdmin_id__c=boothAdminId,BT_id__c=boothId ,EV_id__c=EventId,
                                                                       EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfile.id,
                                                                       Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true,
                                                                       Attendee_Summary__c =attendee.id, isFirstBoothAdmin__c=true,IsMatchMakingUser__c=true,
                                                                       Request_for_upgrade_profile__c = false);         
            insert upebooth;  
            
                        
             MBE_Profile__c a=new MBE_Profile__c();    
        a.As_prefixNew__c='Mr';
        a.As_SuffixNew__c='Mrs';
        a.As_Shipping_Country__c='India';
        a.As_Shipping_States__c='TS';
        a.Name='Vineel';
        a.AS_Email__c = 'testboothadmin1@noemail.com';
        a.Exhibitor_company_imageUrl__c='www.globalnest.com';
        a.AS_WorkZipCode__c=44322;
        a.AS_WorkPhone__c='(732) 333 4808'; 
        a.AS_WorkCity__c='Hyderabad';
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
           
             
            system.debug('*************** a00Z000000J0QBgIAN ----'+upebooth.EV_id__c); 
            
            List < User_Profile_Event__c > listOfEam = new List < User_Profile_Event__c > ();
            listOfEam.add(upebooth);
            
            NAICS_Code__c N = new  NAICS_Code__c();
            N.Name = '123456';      
            insert N;
            
            Commodities__c C = new Commodities__c();
            C.Description__C = 'Test';
            insert C;
            
            MatchLeads_Days__c mdays = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                              MatchLeads_Date__c = Date.Parse('01/18/2014'),
                                                              Slot_Time_period__c = '10',
                                                              Start_time__c = '07:30 AM',
                                                              End_Time__c = '07:00 PM',
                                                              Event__c = EventId,
                                                              MAX_noOf_appontments__c=5);  
            insert mdays;
            MatchLeads_Days__c mdays1 = new MatchLeads_Days__c(Break_Time_between_slots__c='10',
                                                               MatchLeads_Date__c = Date.Parse('01/19/2014'),
                                                               Slot_Time_period__c = '10',
                                                               Start_time__c = '07:30 AM',
                                                               End_Time__c = '07:00 PM',
                                                               Event__c = EventId,
                                                               MAX_noOf_appontments__c=5);  
            insert mdays1;
            Event_Breaks__c breaks = new Event_Breaks__c(Break_End_Time__c = ('2:30 PM'),
                                                         Break_Start_Time__c = ('1:30 PM'),
                                                         Break_Title__c = 'Lunch',
                                                         MatchLeads_Days__c = mdays.id);
            insert breaks; 
            
            Event_Breaks__c blokslistexist = new Event_Breaks__c(Break_End_Time__c = ('2:00 PM'),
                                                                 Break_Start_Time__c = ('1:00 PM'),
                                                                 User_Profile_Event__c = upebooth.id,
                                                                 
                                                                 MatchLeads_Days__c = mdays.id);
            
            cookie  counter = new Cookie('counter',EventId,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
             system.runAs(u){
             
             Test.startTest();
             
              Event__c eve2 = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                                        EV_EndDate__c =  Date.Parse('01/19/2014'),
                                        EV_StartDate__c = Date.Parse('01/20/2014'),
                                        EV_EndTime__c='09:00 AM',
                                        StartTime__c='11:00 AM',Is_MatchMaking_Event__c=true);
            insert eve2;
             
             
                //'ttestt1238@noemail.com'
                MM_Eventadmin_ExhibitorsdirectoryCon BoothAdminsCon1 = new MM_Eventadmin_ExhibitorsdirectoryCon();
                MM_Eventadmin_ExhibitorsdirectoryCon.updatenewemail('ttestt1238999@noemail.com','ttestt123899@noemail.com',EventId,upebooth.id);
                //MM_Eventadmin_ExhibitorsdirectoryCon.updateexstdemail('ttestt123890@noemail.com','ttestt123890@noemail.com',EventId,upebooth.id);
                try{
                BoothAdminsCon1.ToUpdateMBEProfile(attendee, eve, null);
                }catch (exception ee){}
                
                BoothAdminsCon1.b = Blob.valueOf('test body');
                //MM_Eventadmin_ExhibitorsdirectoryCon.FutureMethod('testboothadmin1@noemail.com');
                BoothAdminsCon1.statusValueSchedule();
                BoothAdminsCon1.SelectEvent = eve2.Id;
                BoothAdminsCon1.selectedTimeSlots = new list<string>{'Anil','Manoj','test'};
                BoothAdminsCon1.matchSelectedAttendee();
                BoothAdminsCon1.SelectEvent = eve2.Id;
                //BoothAdminsCon1.eventemailchk =  eve2;
                BoothAdminsCon1.massemailschedules();
                //BoothAdminsCon1.emailchkpopup();
                BoothAdminsCon1.forSchedule();
                BoothAdminsCon1.printschedule();
                BoothAdminsCon1.eventDetailsInPrint();
                BoothAdminsCon1.SelectEvent =eve2.id; 
                BoothAdminsCon1.emailschedule();
                BoothAdminsCon1.UpdateUser();
                //BoothAdminsCon1.ReleaseBoothstaff();
                
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr','ewr&-fewr');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre','ewr&-fewr&-gre');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre&-wgr','ewr&-fewr&-gre&-wgr');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre&-wgr&-wegwrf','ewr&-fewr&-gre&-wgr&-wegwrf');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe','ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre','ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre&-ewrfe','ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre&-ewrfe');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre&-ewrfe&-wrgre','ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre&-ewrfe&-wrgre');
                BoothAdminsCon1.NaicsCodesFunc('ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre&-ewrfe&-wrgre&-ewrfe','ewr&-fewr&-gre&-wgr&-wegwrf&-ewrfe&-wrgre&-ewrfe&-wrgre&-ewrfe');


            Test.stopTest();    
      }
    }            



}