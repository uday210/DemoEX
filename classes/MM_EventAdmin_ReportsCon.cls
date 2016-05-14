public without sharing class MM_EventAdmin_ReportsCon{

// ---------------------------------------------- Variables Declaration Start ----------------------------------------------------------
    private final integer listLimit;
    public LIST<limitWrapper> totalmatcheslist1000{get;set;}  
    
    public id evscheduleid{get;set;}
    public AggregateResult[] utilizationchart{get;set;}
    public LIST<utilizationinner> pieData{get;set;} 
    public Integer slotstatusCount{get; set;}
    public String slotstatus{get; set;} 
    public String slotstatusinfo{get; set;} 
    public String reporttitle{get;set;}
    public string mycheck{get;set;}
    public Boolean viewreport1{get;set;}
    public Boolean viewreport2{get;set;}
    public Boolean viewreport3{get;set;}
    public Boolean viewreport4{get;set;}
    public Boolean piechartbool{get;set;}
    public Boolean viewreportboothslist{get;set;}  
    public Boolean totalmatchesbool{get;set;}
    public Boolean pendingbool{get;set;}
    public Boolean missedbool{get;set;}
    public Boolean cancelledbool{get;set;}
    public Boolean emailalert{get;set;}
    public Boolean assignalert{get; set;}
    public LIST<User_Profile_Event__c> events{get;set;}
    public LIST<Event_Attendee_Mapping__c> eventlist{get;set;}
    public LIST<EventSchedule__c> totalmatcheslist{get;set;}  
    public LIST<EventSchedule__c> totalmatchesexport{get;set;} 
    public LIST<LIST<EventSchedule__c>> matforexport {get;set;}
    public LIST<EventSchedule__c> Exhibitorslist{get;set;} 
    public LIST<EventSchedule__c> Attendeeslist{get;set;} 
    public EventSchedule__c eventschedule{get;set;}
    public LIST<EventSchedule__c> bn{get;set;} 
    public LIST<SelectOption> items{get;set;}
    public String eventSelected{get;set;}  
    public String selectedprint{get;set;}
    public LIST<ExhibitorInner> exhibitorlist{get;set;}
    public MAP<string, ExhibitorInner> mapExhibitors;
    public LIST<AttendeeInner> attendeelist{get;set;}
    public MAP<string, AttendeeInner> mapAttendees;
    public LIST<PendingAttendeeInner> pendingattendeelist{get;set;}
    public MAP<string, PendingAttendeeInner> mappendingAttendees;
    public LIST<PendingAttendeeInner1> pendingattendeelist1{get;set;}
    public MAP<string, PendingAttendeeInner1> mappendingAttendees1;
    public LIST<TotalAttendeeInner> totalattendeelist{get;set;}
    public LIST<MissedAttendeeInner> missedattendeelist{get;set;} 
     public  list<selectoption> apps {get;set;} 
    public  String selectedapp {get;set;}
    public Event__c attach{get;set;}
    public list<Tags__c> tagslist {get; set ;}
    public string attendeealias {get ; set ;}
    public string exhibitoralias {get ; set ;}
    public LIST<Profile_Settings__c> Psettings {get ; set ;} 
    public Profile_Settings__c PsettingMBE {get;set;}
    public Profile_Settings__c PsettingCorp {get;set;}
    public String selectedfilterInformation{get;set;}
    public LIST<SelectOption> filterInformation{get;set;}
    public String selectedcorpsignupInformation{get;set;}
    public LIST<SelectOption> corpsignupInformation{get;set;}
     public String selectedmbesignupInformation{get;set;}
    public LIST<SelectOption> mbesignupInformation{get;set;}
    public String selectedmbecountInformation{get;set;}
    public LIST<SelectOption> mbecountInformation{get;set;}
    public String selectedcorpcountInformation{get;set;}
    public LIST<SelectOption> corpcountInformation{get;set;}

    
    // ---------------------------------------------- Variables Declaration End ----------------------------------------------------------

    // ---------------------------------------------------- Constructor Start -------------------------------------------------------------
    public MM_EventAdmin_ReportsCon(){
    attendeealias ='';
    exhibitoralias ='';
    listLimit = 999;

    apps = new list<selectoption> ();
      apps.add(new selectoption('Match Leads','Match Leads'));
      apps.add(new selectoption('Booth Leads','Booth Leads'));
      selectedapp = 'Match Leads';
    
    
    try{
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
        eventSelected = k.getValue();
      
      piechartbool = false;
      viewreport1 = false;
      viewreport2 = false;
      viewreport3 = false;
      viewreport4 = false;
      totalmatchesbool = false;
      missedbool = false;
      cancelledbool = false;
      pendingbool = false;
      emailalert = false;
      assignalert = false;
      scheduleswithprof = false;

      getselectedfilterInformation();
      selectedFilterInformation='All Tables';
      
      selectedcorpsignupInformation='All';
      getselectedcorpsignupInformation(); 
     
      selectedmbesignupInformation='All';
      getselectedmbesignupInformation();
      
      selectedmbecountInformation='All';
      getselectedmbecountInformation();
      
      selectedcorpcountInformation='All';
      getselectedcorpcountInformation();

     // values();
     // getevents();
     
     Psettings = new LIST<Profile_Settings__c>();
             Psettings = [SELECT id,Name,Business_Description__c,Company_Name__c,Title__c,Mobile__c,Corporate_Company_Logo_Visible__c,Email_Id__c,MBE_Year_in_Business_Visible__c,Corporate_Location_Visible__c,
             First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,MBE_Work_Address_Visibility__c,Corporate_Logo_Visible__c,Corporate_Company_Visible__c,
             Work_Address__c,Work_phone__c,Additional_Company_Brouchers__c,Additional_Company_videos__c,BBB_Number__c,
             Business_Duns_Number__c,Business_Established_Date__c,Business_Revenue__c,Business_Tax_ID__c,Business_Type__c,Cage_Code__c,
             Certificate_Processed_by_RPO__c,Certifications__c,Commodities__c,Country__c,DBA__c,Distributors_Country__c,Geographical_Region__c,
             GSA_Schedule_Contract_Number__c,Job_Title__c,Manufatures_Country__c,Number_Of_Employees__c,Primary_Business_Category__c,Products_Services__c,
             References__c,Revenue_Range__c,Salutation__c,Secondary_Business_Category__c,Small_Business_IMAGE__c,State__c,Uploaded_Company_Brochures__c,Uploaded_Video__c,
             Website__c,Zip_Code__c,Company_Logo__c,MBE_Products_Services_Visible__c,MBE_LastName_Visible__c,MBE_Email_Visible__c,
             MBE_Job_Title_Visible__c,MBE_First_Name_Visible__c,MBE_Work_Phone_Visible__c,MBE_Procurement_Needs_Visible__c,MBE_Business_Description_Visible__c,
             MBE_NAICS_CODES_Visible__c,MBE_Small_Business_Image_Visible__c,MBE_Title_Visible__c,MBE_Mobile_Phone_Visible__c,
             MBE_Salutation_Visible__c,MBE_Company_Visible__c,MBE_DBA_Visible__c,MBE_Website_Visible__c,MBE_Address_1_Visible__c,MBE_Address_2_Visible__c,
             MBE_City_Visible__c,MBE_Country_Visible__c,MBE_Zip_Code_Visible__c,MBE_State_Visible__c,MBE_Additional_Company_Brouchers_Visible__c,
             MBE_Manufatures_Country_Visible__c,MBE_Distributors_Country_Visible__c,MBE_Uploaded_Company_Brochures_Visible__c,MBE_Company_Logo_Visible__c,
             MBE_Business_Duns_Number_Visible__c,MBE_Business_Established_Date_Visible__c,MBE_BBB_Number_Visible__c,MBE_Additional_Company_videos_Visible__c,
             MBE_Business_Revenue_Visible__c,MBE_Revenue_Range_Visible__c,MBE_Business_Tax_ID_Visible__c,MBE_Cage_Code_Visible__c,
             MBE_GSA_Schedule_Contract_Number_Visible__c,MBE_Number_Of_Employees_Visible__c,MBE_Primary_Business_Category_Visible__c,MBE_Certifications_Visible__c,
             MBE_Secondary_Business_Category_Visible__c,MBE_Certificate_Processed_by_RPO_Visible__c,MBE_Geographical_Region_Visible__c,MBE_References_Visible__c,
             MBE_Business_Type_Visible__c,MBE_Commodities_Visible__c,MBE_Uploaded_Video_Visible__c FROM Profile_Settings__c WHERE Event__r.id =: eventSelected];
        
                for(Profile_Settings__c ps : Psettings ){
            if(ps.Name == 'Corporate'){
                PsettingCorp = ps;
            }else if(ps.Name == 'MBE'){
                PsettingMBE = ps;
            }
        }
     attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c,EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, AS_HostingAddr2__c,
                          EV_StartDate__c, EV_EndDate__c,EV_HostingStateNew__c, EV_HostingState__c,Is_Webank_event__c from Event__c where id = : eventSelected];
                          
     tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventSelected];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
       
       } 
       
       
       
                          
     }catch(Exception e){}
    
    }
    // ---------------------------------------------------- Constructor End -------------------------------------------------------------
    public List<selectOption> getselectedfilterInformation() {
        //Getting filter info
        filterInformation= new List<selectOption>();
        filterInformation.add(new selectOption('All Tables', 'All Tables'));
        filterInformation.add(new selectOption('Tables with Schedules', 'Tables with Schedules'));
        filterInformation.add(new selectOption('Tables without schedules', 'Tables without schedules')); 
         return filterInformation;
     
    }
    
    //corporate signups picklist values
     public List<selectOption> getselectedcorpsignupInformation() {
        corpsignupInformation= new List<selectOption>();
        corpsignupInformation.add(new selectOption('All', 'All'));
        corpsignupInformation.add(new selectOption('True', 'True'));
        corpsignupInformation.add(new selectOption('False', 'False'));
         return corpsignupInformation;
     
    }
    
    //mbe signups picklist values
     public List<selectOption> getselectedmbesignupInformation() {
        mbesignupInformation= new List<selectOption>();
        mbesignupInformation.add(new selectOption('All', 'All'));
        mbesignupInformation.add(new selectOption('True', 'True'));
        mbesignupInformation.add(new selectOption('False', 'False'));
         return mbesignupInformation;
     
    }
    
    //mbe count picklist values
     public List<selectOption> getselectedmbecountInformation() {
        mbecountInformation= new List<selectOption>();
        mbecountInformation.add(new selectOption('All', 'All'));
        mbecountInformation.add(new selectOption('Count with Appointments', 'Count with Appointments'));
        mbecountInformation.add(new selectOption('Count without Appointments', 'Count without Appointments'));
         return mbecountInformation;
     
    }
    
    
    //corp count picklist values
     public List<selectOption> getselectedcorpcountInformation() {
        corpcountInformation= new List<selectOption>();
        corpcountInformation.add(new selectOption('All', 'All'));
        corpcountInformation.add(new selectOption('Count with Appointments', 'Count with Appointments'));
        corpcountInformation.add(new selectOption('Count without Appointments', 'Count without Appointments'));
         return corpcountInformation;
     
    }

    // ----------------------------------------------- Getting Events into Picklist Start -------------------------------------------------
     /**public void values(){
         piechartbool=false;
         viewreport1=false;
         viewreport2 = false;
         viewreport3 = false;
         viewreport4 = false;
         emailalert = false;
         assignalert = false;
         LIST<User_Profile_Event__c> events = new LIST <User_Profile_Event__c>();
         items = new LIST<selectoption>();
         events = [SELECT id, EV_id__c, EV_id__r.EV_Title__c FROM User_Profile_Event__c
                   WHERE EventAdmin_Id__r.UserName = : userInfo.getUserName() 
                   AND EventAdmin_Id__c != ''
                   AND User_id__r.UserName = : userInfo.getUserName()                     
                   ORDER BY CreatedDate ASC];  
         if(!events.isEmpty()) {
             for (User_Profile_Event__c Even: events) {
                 if(Even.EV_id__c != null){
                     Items.add(new SelectOption(Even.EV_id__c, Even.EV_id__r.EV_Title__c));
                     eventSelected = Even.EV_id__c;
                 }
             }
         }
        getevents();
     }
     */
     public void getevents() {    
         eventlist = new list<Event_Attendee_Mapping__c>();
         if (eventSelected != null || eventSelected != '') {
             integer recCount = 0;
                eventlist = [SELECT CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,
                EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c,EV_id__r.EV_StartDate__c,EV_id__r.EV_EndDate__c,
                EV_id__r.EV_Title__c,EV_id__r.MM_Slot_Timeperiod__c,EV_id__r.MM_Firstaday_startTime__c,EV_id__r.MM_Firstaday_EndTime__c, EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HistingAddr1__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingCountryNew__c,EV_id__r.EV_HostingStateNew__c,EV_id__r.EV_HostingZipcode__c
                FROM Event_Attendee_Mapping__c 
                where IsMatchMakingAttendee__c = true 
                AND EV_id__r.id = : eventSelected 
                ORDER BY AS_id__r.AS_Company__c];    
                }
     }
   // ---------------------------------------------------- Getting Events into Picklist End -----------------------------------------------------
   
   // ------------------------------------------------ Percent Utilization Dashboard Item Start --------------------------------------------------

   // ----------------------------------------------------- Print Exhibitors Schedule Method Start ----------------------------------------------
    public pagereference exhibitorschedules()
    {  
          scheduleswithprof = false;
    try{
        Exhibitorslist = new LIST<EventSchedule__c>();
        Exhibitorslist = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                            MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_EAM__r.AS_id__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                            MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,Owner.email,Owner.name,starttimein24hrs__c,
                            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_EAM__r.DiversityType__c,MM_To_EAM__r.AS_id__r.AS_Email__c,EV_id__r.EV_EventLogo__c,
                            MM_To_EAM__r.AS_id__r.As_prefixNew__c,MM_To_EAM__r.AS_id__r.AS_Title__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress2__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c,MM_To_EAM__r.AS_id__r.AS_WorkZip__c,MM_To_EAM__r.AS_id__r.AS_WorkPhone__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_2__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_3__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_4__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_5__c,MM_To_EAM__r.AS_id__r.As_NAICSCode6__c,MM_To_EAM__r.AS_id__r.As_NAICSCode7__c,MM_To_EAM__r.AS_id__r.As_NAICSCode8__c,MM_To_EAM__r.AS_id__r.As_NAICSCode9__c,MM_To_EAM__r.AS_id__r.Keywords__c,
                            MM_To_EAM__r.AS_id__r.AS_BusinessDescription__c,MM_To_EAM__r.AS_id__r.AS_BusinessDunsNumber__c,MM_To_EAM__r.AS_id__r.AS_BusinessEstablishedDate__c,MM_To_EAM__r.AS_id__r.AS_BusinessRevenue__c,MM_To_EAM__r.AS_id__r.AS_BusinessTaxId__c,MM_To_EAM__r.AS_id__r.AS_CageCode__c,MM_To_EAM__r.AS_id__r.AS_NumberOfEmployees__c,MM_To_EAM__r.AS_id__r.Company_Certifications__c,MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.AS_id__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                            MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                            FROM EventSchedule__c 
                            WHERE EV_id__c =: eventSelected  
                            AND Is_Matchmaking__c = true 
                            AND MM_To_EAM__c != null
                            AND MM_To_UPE__r.Attendee_Summary__c != null 
                            AND MM_Slot_Status__c = 'Accepted'
                            ORDER BY MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,starttimein24hrs__c];
                            
        exhibitorlist = new LIST<ExhibitorInner>();
        mapExhibitors = new MAP<string, ExhibitorInner>();
        for(EventSchedule__c exhibitor : exhibitorslist)
        {
        system.debug('=================== ' + mapExhibitors);
            if(mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c) == null)
            {
                mapExhibitors.put(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,new ExhibitorInner(exhibitor));      
                exhibitorlist.add(mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c));               
            }
            else
            {
                mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c).liExhibitors.add(exhibitor);              
            }
        } 
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Schedules.pdf');
        }catch(exception ex){}
        pagereference pg =page.ExhibitorsSchedulePDF;
        return pg;
    }
    
    
    //---------------------- Exhibitor schedule print page order by table no start
    public pagereference exhibitorschedulesOrderByTable()
    {  
          scheduleswithprof = false;
    try{
        Exhibitorslist = new LIST<EventSchedule__c>();
        Exhibitorslist = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                            MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_EAM__r.AS_id__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                            MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,Owner.email,Owner.name,starttimein24hrs__c,
                            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_EAM__r.DiversityType__c,MM_To_EAM__r.AS_id__r.AS_Email__c,EV_id__r.EV_EventLogo__c,
                            MM_To_EAM__r.AS_id__r.As_prefixNew__c,MM_To_EAM__r.AS_id__r.AS_Title__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress2__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c,MM_To_EAM__r.AS_id__r.AS_WorkZip__c,MM_To_EAM__r.AS_id__r.AS_WorkPhone__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_2__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_3__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_4__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_5__c,MM_To_EAM__r.AS_id__r.As_NAICSCode6__c,MM_To_EAM__r.AS_id__r.As_NAICSCode7__c,MM_To_EAM__r.AS_id__r.As_NAICSCode8__c,MM_To_EAM__r.AS_id__r.As_NAICSCode9__c,MM_To_EAM__r.AS_id__r.Keywords__c,
                            MM_To_EAM__r.AS_id__r.AS_BusinessDescription__c,MM_To_EAM__r.AS_id__r.AS_BusinessDunsNumber__c,MM_To_EAM__r.AS_id__r.AS_BusinessEstablishedDate__c,MM_To_EAM__r.AS_id__r.AS_BusinessRevenue__c,MM_To_EAM__r.AS_id__r.AS_BusinessTaxId__c,MM_To_EAM__r.AS_id__r.AS_CageCode__c,MM_To_EAM__r.AS_id__r.AS_NumberOfEmployees__c,MM_To_EAM__r.AS_id__r.Company_Certifications__c,MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.AS_id__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                            MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                            /*MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,*/
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                            FROM EventSchedule__c 
                            WHERE EV_id__c =: eventSelected  
                            AND Is_Matchmaking__c = true 
                            AND MM_To_EAM__c != null
                            AND MM_To_UPE__r.Attendee_Summary__c != null 
                            AND MM_Slot_Status__c = 'Accepted'
                            ORDER BY MM_To_UPE__r.BT_id__r.Formatedtableno__c,starttimein24hrs__c];
        
        exhibitorlist = new LIST<ExhibitorInner>();
        mapExhibitors = new MAP<string, ExhibitorInner>();
        for(EventSchedule__c exhibitor : exhibitorslist)
        {
        system.debug('=================== ' + mapExhibitors);
            if(mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c) == null)
            {
                mapExhibitors.put(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,new ExhibitorInner(exhibitor));      
                exhibitorlist.add(mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c));               
            }
            else
            {
                mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c).liExhibitors.add(exhibitor);              
            }
        } 
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Schedules.pdf');
        }catch(exception ex){}
        pagereference pg =page.ExhibitorsSchedulePDF;
        return pg;
    }
    
    
    // ---------------------------------------------------- Inner class ------------------------------------------------------------------
    public class ExhibitorInner
    {
        public LIST<EventSchedule__c> liExhibitors{get;set;}
        public string exhibitorCompany{get;set;}
        public string exhibitorName{get;set;}
        public string exhibitorTable{get;set;}
        public string exhibitorLogo{get;set;}
        public string exhibitorContact{get;set;}
        public string exhibitorlocation{get;set;}

        Public String EventLogo{get;set;}
        public List<string> dispopenslots {get ; set ;}
        public ExhibitorInner(EventSchedule__c exhibitor)
        {
            exhibitorCompany = exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c;
            exhibitorName = exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c;
            exhibitorTable = exhibitor.MM_To_UPE__r.BT_id__r.MM_TableNo__c;
            exhibitorLogo = exhibitor.MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c;
            exhibitorContact = exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c;
            exhibitorlocation = exhibitor.MM_To_UPE__r.BT_id__r.BT_Location__c;
            EventLogo = exhibitor.EV_id__r.EV_EventLogo__c;
            liExhibitors = new LIST<EventSchedule__c>{exhibitor};
        }
        public ExhibitorInner(list<string> openslotstodisp)
        {
        dispopenslots = openslotstodisp;
        
        }
    }
    // ----------------------------------------------------- Print Exhibitors Schedule Method End -----------------------------------------------
    public Boolean scheduleswithprof {get;set;}
    
     public pagereference exhibitorscheduleswithprofilesbycompany() {
        exhibitorschedules();
         
        scheduleswithprof = True;
        pagereference pg =page.ExhibitorsSchedulePDF;
        return pg;
    }
    
      public PageReference exhibitorscheduleswithprofilesbyTableNo() {
               scheduleswithprof = true;
    //try{
     /*   Exhibitorslist = new LIST<EventSchedule__c>();
       MatchLeads_Days__c matchLeadsDatesList=[SELECT id,Start_time__c,End_Time__c,MatchLeads_Date__c,Slot_Time_period__c,MAX_noOf_appontments__c,Break_Time_between_slots__c 
                                 FROM MatchLeads_Days__c
                                 WHERE Event__c=: eventSelected ]; 
        
          system.debug('--------slots----------'+matchLeadsDatesList[0].MatchLeads_Date__c);
        date selecteddate =matchLeadsDatesList[0].MatchLeads_Date__c ;
        
            MAP<Date , LIST<String>> getSlotsFromUtility = MM_Utility.giveEventTimingsWithDates(eventSelected ,selecteddate);
        system.debug(' SLOTS UTILITY  '+getSlotsFromUtility);
        list<String> timeSlotsForMatchDate= getSlotsFromUtility.get(matchLeadsDatesList[0].MatchLeads_Date__c);
        system.debug('--------slots----------'+timeSlotsForMatchDate);
        set<string> totalslots = new set<string> ();
        list<Event_Breaks__c> blokslistexist  = new list<Event_Breaks__c> ();

            totalslots.Addall(timeSlotsForMatchDate);
        
        list<EventSchedule__c> eschlistofprimes = [select id,MM_Slot_End_Time__c,MM_slot_StartTime__c,MM_To_UPE__c,MM_To_EAM__c from EventSchedule__c where EV_id__c =: eventSelected and MM_Slot_Status__c =: 'Accepted'AND MM_To_EAM__c != null AND MM_To_UPE__c != null];
        blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c,User_Profile_Event__c from Event_Breaks__c where User_Profile_Event__c != null];
        //listvals = '';
//for(Event_Breaks__c evb : blokslistexist) {
         //       listvals += evb.Break_Start_Time__c+'-'+evb.Break_End_Time__c+',';
         //   }
    //  totalslotsavailable.addAll(totalslots);
    *//*
        Exhibitorslist = new LIST<EventSchedule__c>();
        Exhibitorslist = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,
                            MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                            MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,Owner.email,Owner.name,MM_To_EAM__r.AS_id__r.Exhibitor_company_imageUrl__c,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,
                            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_EAM__r.DiversityType__c,MM_To_EAM__r.AS_id__r.AS_Email__c,starttimein24hrs__c,EV_id__r.EV_EventLogo__c,
                            MM_To_EAM__r.AS_id__r.As_prefixNew__c,MM_To_EAM__r.AS_id__r.AS_Title__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c,MM_To_EAM__r.AS_id__r.AS_WorkAddress2__c,MM_To_EAM__r.AS_id__r.AS_WorkCity__c,MM_To_EAM__r.AS_id__r.AS_Work_States__c,MM_To_EAM__r.AS_id__r.AS_WorkZip__c,MM_To_EAM__r.AS_id__r.AS_WorkPhone__c,MM_To_EAM__r.AS_id__r.AS_WebsiteUrl__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_1__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_2__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_3__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_4__c,MM_To_EAM__r.AS_id__r.As_NAICSCode_5__c,MM_To_EAM__r.AS_id__r.Keywords__c,
                            MM_To_EAM__r.AS_id__r.AS_BusinessDescription__c,MM_To_EAM__r.AS_id__r.AS_BusinessDunsNumber__c,MM_To_EAM__r.AS_id__r.AS_BusinessEstablishedDate__c,MM_To_EAM__r.AS_id__r.AS_BusinessRevenue__c,MM_To_EAM__r.AS_id__r.AS_BusinessTaxId__c,MM_To_EAM__r.AS_id__r.AS_CageCode__c,MM_To_EAM__r.AS_id__r.AS_NumberOfEmployees__c,MM_To_EAM__r.AS_id__r.Company_Certifications__c,MM_To_EAM__r.AS_id__r.AS_PrimaryBusinessCategory1__c,MM_To_EAM__r.AS_id__r.As_SecondaryBusinessCategory1__c,MM_To_UPE__r.BT_id__r.Formatedtableno__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c
                            MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c,
                            EV_id__r.Is_Webank_event__c 
                            FROM EventSchedule__c 
                            WHERE EV_id__c =: eventSelected  
                            AND Is_Matchmaking__c = true 
                            AND MM_To_EAM__c != null
                            AND MM_To_UPE__r.Attendee_Summary__c != null 
                            AND MM_Slot_Status__c = 'Accepted'
                            ORDER BY  MM_To_UPE__r.BT_id__r.Formatedtableno__c,starttimein24hrs__c];
        exhibitorlist = new LIST<ExhibitorInner>();
        mapExhibitors = new MAP<string, ExhibitorInner>();
        for(EventSchedule__c exhibitor : exhibitorslist)
        {
        system.debug('=================== ' + mapExhibitors);
            if(mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c) == null)
            {
                
                mapExhibitors.put(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,new ExhibitorInner(exhibitor));      
                exhibitorlist.add(mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c)); 
                              
            }
            else
            {
                mapExhibitors.get(exhibitor.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c).liExhibitors.add(exhibitor);              
            }
        } 
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Schedules.pdf');
        }catch(exception ex){}
        */
        exhibitorschedulesOrderByTable();
        
                
        scheduleswithprof = True;
        pagereference pg =page.ExhibitorsSchedulePDF;
        return pg;
    }
    
    
    
    
    // ------------------------------------------------------ Print Attendees Schedule Method Start ---------------------------------------------   
    public pagereference attendeeschedules(){
    try{
        Attendeeslist = new LIST<EventSchedule__c>();
        Attendeeslist = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_slot_Date__c,MM_To_UPE__r.BT_id__r.BT_Location__c,starttimein24hrs__c,
                            MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                            MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_Email__c,    
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                            MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                            FROM EventSchedule__c 
                            WHERE EV_id__c =: eventSelected  
                            AND Is_Matchmaking__c = true 
                            AND MM_To_EAM__c != null
                            AND MM_To_UPE__r.Attendee_Summary__c != null
                            AND MM_Slot_Status__c = 'Accepted'
                            ORDER BY MM_To_EAM__r.AS_id__r.AS_Company__c,starttimein24hrs__c];
        attendeelist = new LIST<AttendeeInner>();
        mapAttendees = new MAP<string, AttendeeInner>();
        for(EventSchedule__c attendee : Attendeeslist)
        {
            if(mapAttendees.get(attendee.MM_To_EAM__r.AS_id__r.AS_Email__c) == null)
            {
                mapAttendees.put(attendee.MM_To_EAM__r.AS_id__r.AS_Email__c,new AttendeeInner(attendee));      
                attendeelist.add(mapAttendees.get(attendee.MM_To_EAM__r.AS_id__r.AS_Email__c));               
            }
            else
            {
                mapAttendees.get(attendee.MM_To_EAM__r.AS_id__r.AS_Email__c).liAttendees.add(attendee);              
            }
        } 
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Schedules.pdf');
        }catch(exception ex){}
        pagereference pg =page.AttendeesSchedulePDF;
        return pg;
    }
    
    // ---------------------------------------------------- Inner class ------------------------------------------------------------------
    public class AttendeeInner
    {
        public LIST<EventSchedule__c> liAttendees{get;set;}
        public string attendeeCompany{get;set;}
        public string attendeeName{get;set;}
        public string attendeeLogo{get;set;}
        public string attendeeContact{get;set;}
        public string attendeeCompany1{get;set;}
        public string attendeeName1{get;set;}
        public string attendeeLogo1{get;set;}
        public string attendeeContact1{get;set;}
        public Boolean IsweBank{get;set;}
        public AttendeeInner(EventSchedule__c attendee)
        {
            attendeeCompany = attendee.MM_To_EAM__r.AS_id__r.AS_Company__c;
            attendeeName = attendee.MM_To_EAM__r.AS_id__r.AS_FirstName__c + ' ' + attendee.MM_To_EAM__r.AS_id__r.AS_LastName__c;
            attendeeLogo = attendee.MM_To_EAM__r.AS_id__r.AS_ImageUrl__c;
            attendeeContact = attendee.MM_To_EAM__r.AS_id__r.AS_CellPhone__c;
            attendeeCompany1 = attendee.MM_To_EAM__r.MBE_Profile__r.AS_Company__c;
            attendeeName1 = attendee.MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c + ' ' + attendee.MM_To_EAM__r.MBE_Profile__r.AS_LastName__c;
            attendeeLogo1 = attendee.MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c;
            attendeeContact1 =  attendee.MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c;
            IsweBank = attendee.EV_id__r.Is_Webank_event__c;
            liAttendees = new LIST<EventSchedule__c>{attendee};
            
        }
    }
  // --------------------------------------------- Print Attendees Schedule Method End -----------------------------------------------------
  
  // ----------------------------------------------- Total Matches Made Report Start -------------------------------------------------------
  //private LIST<limitWrapper> totalmatcheslist1000= new LIST<limitWrapper>();

  public void totalmatches(){ 
  
   viewreport1 = false;
   viewreport2 = false;
   viewreport3 = true;
   viewreport4 = false;
   piechartbool=false;
   totalmatchesbool = true;
   pendingbool = false;
   missedbool = false;
   cancelledbool = false;
   emailalert = false;
   assignalert = false; 
   totalappoints();
                       
  
  } 
  public List<limitWrapper> totalappoints(){
  reporttitle = 'Total Appointments Made';
   totalmatcheslist1000=new LIST<limitWrapper> ();
   integer counter = 0;
   integer loopCount = 0;
   string    dte='';
   list<EventSchedule__c> schListTemp = new list<EventSchedule__c>();
   EventSchedule__c schListTemp5 = new EventSchedule__c();  //added
   
   totalmatcheslist = new list<EventSchedule__c>();
   totalmatcheslist = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,LastModifiedDate,LastModifiedById,LastModifiedBy.userName,EV_id__r.EV_HostingTimeZone__c,
                        MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                        MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
                        MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c
                                  
                       FROM EventSchedule__c 
                       WHERE EV_id__c =: eventSelected  
                       AND Is_Matchmaking__c = true 
                       AND MM_To_EAM__c != null
                       AND MM_To_UPE__r.Attendee_Summary__c != null 
                       AND MM_Slot_Status__c = 'Accepted'
                       ORDER BY  starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];
                       
                     // dateconvertionmd(totalmatcheslist);
                        
                        for(EventSchedule__c a:totalmatcheslist)
                        
                        {
                            
                            if(a.LastModifiedDate !=NULL)
                             { 
                                             datetime   GSTe=a.LastModifiedDate;
                                                //system.debug('gmt'+GSTe);
                                                if(a.EV_id__r.EV_HostingTimeZone__c=='Eastern Time(USA)')
                                                {
                                                    dte= GSTe.format('MM/dd/yyyy h:mm a', 'America/New_York');  

                                                }else if(a.EV_id__r.EV_HostingTimeZone__c=='Central Time(USA)')
                                                {
                                                    dte = GSTe.format('MM/dd/yyyy h:mm a', 'America/Mexico_City');

                                                }
                                                 else if(a.EV_id__r.EV_HostingTimeZone__c=='Mountain Time(USA)')
                                                 {
                                                    dte = GSTe.format('MM/dd/yyyy h:mm a', 'America/Denver');

                                                }
                                                else if(a.EV_id__r.EV_HostingTimeZone__c=='Pacific Time(USA)')
                                                {
                                                    dte = GSTe.format('MM/dd/yyyy h:mm a', 'America/Tijuana');

                                                }
                                                else if(a.EV_id__r.EV_HostingTimeZone__c=='Indian Standard Time(IST)')
                                                {
                                                     dte = GSTe.format('MM/dd/yyyy h:mm a', 'Asia/Colombo');   

                                                }
                                            
                                                
                             } 
                            if((listLimit < counter) || (counter < totalmatcheslist.size()))
                            {
                            
                            schListTemp.add(a);
                            totalmatcheslist1000.add(new limitWrapper(a,loopCount,dte)); // added 
                            counter++;
                            }
                            
                        else{
                            
                            loopCount++;
                            totalmatcheslist1000.add(new limitWrapper(a,loopCount,dte));    //added
                            schListTemp = new list<EventSchedule__c>();
                            schListTemp.add(a);
                            counter = 0;
                            }            
                        }

                       if(totalmatcheslist1000.size() == 0)
                        {
                            loopCount++;
                            totalmatcheslist1000.add(new limitWrapper(schListTemp5 ,loopCount,dte));   //added 
                        }
                        
                       // dateconvertionmd(totalmatcheslist1000);
                        return totalmatcheslist1000;
                        
  }
  //inner class
                        public class limitWrapper
                        {
                        public EventSchedule__c schList {get;set;}   //Change from list to single single object type
                        public integer blockNumber {get;set;}
                        public string dt{get;set;}
                        public limitWrapper(EventSchedule__c  shchs, integer i,string LastModifiedD) // Changed from list to signle object type
                        {
                        schList = shchs;
                        blockNumber = i;
                        dt=LastModifiedD;
                        }

                        }
  
  
  // ------------------------------------------------ Total Matches Made Report End ----------------------------------------------------------
  
  // ---------------------------------------------- Pending Appointments Report Start -------------------------------------------------------
  public void pendingappointments(){  
  try{
   viewreport1 = false;
   viewreport2 = true;
   viewreport3 = false;
   viewreport4 = false;
   piechartbool = false;
   totalmatchesbool = false;
   pendingbool = true;
   missedbool = false;
   cancelledbool = false;
   emailalert = false;
   assignalert = false; 
   reporttitle = 'Pending Appointments';
   totalmatcheslist = new LIST<EventSchedule__c>();
   totalmatcheslist = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,LastModifiedBy.userName,Owner.userName,LastModifiedDate, MM_Slot_Status__c,
                        MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                        MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,CreatedDate,
                        MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c, 
                        /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                        MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                        MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                        MM_To_EAM__r.MBE_Profile__r.DBA__c,
                        MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                        MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                        MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                        MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                        MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                        MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                        MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.References__c,
                        MM_To_EAM__r.MBE_Profile__r.References2__c,
                        MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                        MM_To_EAM__r.MBE_Profile__r.Total_Name__c,*/
                        MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                       FROM EventSchedule__c 
                       WHERE EV_id__c =: eventSelected  
                       AND Is_Matchmaking__c = true 
                       AND MM_To_EAM__c != null
                       AND MM_To_UPE__r.Attendee_Summary__c != null
                       AND MM_Slot_Status__c = 'Pending'                      
                       ORDER BY starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];            
   pendingattendeelist = new LIST<PendingAttendeeInner>();
   mappendingAttendees = new MAP<string, PendingAttendeeInner>();
   for(EventSchedule__c pendingattendee : totalmatcheslist){  
     date lastmodified = Date.valueOf(pendingattendee.LastModifiedDate);
     date todaydate =Date.valueOf(Datetime.now());
     integer days = lastmodified.daysBetween(todaydate);   
     String strdays;
     if(days == 1){
         strdays = string.valueof(days) +' '+'day'+' ';
     }
     else if(days == 0){
         strdays = '';
     }
     else{
         strdays = string.valueof(days) +' '+'days'+' ';
     }
     Long ti = Datetime.now().getTime() - pendingattendee.LastModifiedDate.getTime();
     DateTime dt = DateTime.valueOf(ti);
     if(mappendingAttendees.get(pendingattendee.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c) == null)
     {
        mappendingAttendees.put(pendingattendee.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,new PendingAttendeeInner(pendingattendee,dt,strdays));      
        pendingattendeelist.add(mappendingAttendees.get(pendingattendee.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c));               
     }
     else
     {
        mappendingAttendees.get(pendingattendee.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c).listofAttendees.add(pendingattendee);              
     }
   }   
   }catch(exception ex){}      
  } 
  
    public string CEmail{get; set;}
  
    public pagereference changePendingStatus(){
        
        system.debug('  CORPORATE EMAIL  '+CEmail);
        if(CEmail != null){
            
            PendingAttendeeInner selectedCorp;
            selectedCorp= mappendingAttendees.get(CEmail);
  
            LIST<EventSchedule__c> updateScheduleStatus= new LIST<EventSchedule__c>();
            system.debug(' PENDING LIST  '+selectedCorp);
   
            system.debug(' INNER CLASS  '+selectedCorp.listofAttendees);
            for(EventSchedule__c esch: selectedCorp.listofAttendees){
            system.debug(' SCHEDULE  '+esch.MM_Slot_Status__c);
           
            esch.MM_Slot_Status__c= 'Accepted';
            system.debug(' AFTER UPDATE SCHEDULE  '+esch.MM_Slot_Status__c);
            updateScheduleStatus.add(esch);
            system.debug(' UPDATED SCHEDULE  '+updateScheduleStatus);

            }
   
  
            system.debug(' NEED TO UPDATE SCHEDULE  '+updateScheduleStatus);
 
           Database.update(updateScheduleStatus, False);
           pendingappointments();
      }
      return null;
  }
   
  public class PendingAttendeeInner
  {
      public LIST<EventSchedule__c> listofAttendees{get;set;}
      public DateTime PendingTime{get;set;}
      public String PendingDate{get;set;}
      public string dummyCompany{get;set;}
      public string CorporateName{get;set;}
      public string CorporateContact{get;set;}
      public String CorporateEmail{get; set;}
      
      
       public PendingAttendeeInner(EventSchedule__c es,DateTime pt,String dayss){
          dummyCompany = es.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c;
          CorporateName = es.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + es.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c ;
          CorporateContact = es.MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c;
          CorporateEmail= es.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c;
          PendingDate = dayss;
          PendingTime = pt;
          listofAttendees = new LIST<EventSchedule__c>{es};
      }  
  }
   
   public void assignAppointment(){    
        string ss = ApexPages.currentPage().getParameters().get('mycheck');
        evscheduleid = ss;     
        totalmatcheslist = new LIST<EventSchedule__c>();
        totalmatcheslist = [SELECT ID,MM_Slot_Status__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,LastModifiedBy.userName,Owner.userName,LastModifiedDate,
                            MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                            MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,CreatedDate,
                            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                            /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,*/
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c         
                            FROM EventSchedule__c 
                            WHERE id =: evscheduleid]; 
       for(EventSchedule__c es : totalmatcheslist )
       {
           es.MM_Slot_Status__c = 'Accepted';                            
       }       
       database.update(totalmatcheslist,false);         
       pendingappointments();
       assignalert = true;    
  }
  // ------------------------------------------------ Pending Appointments Report End ---------------------------------------------------------
  
  
  // --------------------------------------------- Cancelled Appointments Report Start --------------------------------------------------------
  public void cancelledappointments(){ 
  try{
   viewreport1=true;
   viewreport2=false;
   viewreport3 = false;
   viewreport4 = false;
   piechartbool=false;
   totalmatchesbool = false;
   pendingbool = false;
   missedbool = false;
   cancelledbool = true;   
   emailalert = false;
   assignalert = false; 
   reporttitle = 'Cancelled/Rejected Appointments';
   totalmatcheslist = new list<EventSchedule__c>();
   totalmatcheslist = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,Owner.userName,LastModifiedBy.userName,lastmodifieddate,
                        MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                        MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.BoothAdmin_id__r.username,
                        MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c, 
                        /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                        MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                        MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                        MM_To_EAM__r.MBE_Profile__r.DBA__c,
                        MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                        MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                        MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                        MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                        MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                        MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                        MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.References__c,
                        MM_To_EAM__r.MBE_Profile__r.References2__c,
                        MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Title__c,*/
                        MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                      FROM EventSchedule__c 
                      WHERE EV_id__c =: eventSelected  
                      AND Is_Matchmaking__c = true 
                      AND MM_To_EAM__c != null
                      AND MM_To_UPE__r.Attendee_Summary__c != null
                      AND (MM_Slot_Status__c = 'Rejected' OR MM_Slot_Status__c ='Rescheduled' OR MM_Slot_Status__c ='Cancelled')
                      ORDER BY starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];                 
   totalattendeelist = new LIST<TotalAttendeeInner>();
   string dte = '';
   for(EventSchedule__c totalattendee : totalmatcheslist){
                            
                            if(totalattendee.LastModifiedDate !=NULL)
                             { 
                                             datetime   GSTe=totalattendee.LastModifiedDate;
                                                //system.debug('gmt'+GSTe);
                                                if(totalattendee.EV_id__r.EV_HostingTimeZone__c=='Eastern Time(USA)')
                                                {
                                                    dte= GSTe.format('MM/dd/yyyy h:mm a', 'America/New_York');  

                                                }else if(totalattendee.EV_id__r.EV_HostingTimeZone__c=='Central Time(USA)')
                                                {
                                                    dte = GSTe.format('MM/dd/yyyy h:mm a', 'America/Mexico_City');

                                                }
                                                 else if(totalattendee.EV_id__r.EV_HostingTimeZone__c=='Mountain Time(USA)')
                                                 {
                                                    dte = GSTe.format('MM/dd/yyyy h:mm a', 'America/Denver');

                                                }
                                                else if(totalattendee.EV_id__r.EV_HostingTimeZone__c=='Pacific Time(USA)')
                                                {
                                                    dte = GSTe.format('MM/dd/yyyy h:mm a', 'America/Tijuana');

                                                }
                                                else if(totalattendee.EV_id__r.EV_HostingTimeZone__c=='Indian Standard Time(IST)')
                                                {
                                                     dte = GSTe.format('MM/dd/yyyy h:mm a', 'Asia/Colombo');   

                                                }
                                                
                                                
                                             }   
                                                
     totalattendeelist.add(new TotalAttendeeInner(totalattendee,dte));
   }    
   }catch(exception ex){} 
  } 
  // ---------------------------------------------- Cancelled Appointments Report End -------------------------------------------------------
  
  // ----------------------------------------------- Missed Appointments Report Start -------------------------------------------------------
  public pagereference missedappointments(){ 
  try{
   viewreport1 = false;
   viewreport2 = false;
   viewreport3 = false;
   viewreport4 = true;
   piechartbool=false;
   totalmatchesbool = false;
   pendingbool = false;
   missedbool = true;
   cancelledbool = false;
   emailalert = false;
   assignalert = false; 
   reporttitle = 'Missed Appointments';
   totalmatcheslist= new list<EventSchedule__c>();
   totalmatcheslist= [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.BoothAdmin_id__r.username,Owner.userName,
                        MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                        MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,LastModifiedDate,LastModifiedById,LastModifiedBy.userName,
                        MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,  
                        /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                        MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                        MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                        MM_To_EAM__r.MBE_Profile__r.DBA__c,
                        MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                        MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                        MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                        MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                        MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                        MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                        MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.References__c,
                        MM_To_EAM__r.MBE_Profile__r.References2__c,
                        MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                        MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                        MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                      FROM EventSchedule__c 
                      WHERE EV_id__c =: eventSelected  
                      AND Is_Matchmaking__c = true 
                      AND MM_To_EAM__c != null
                      AND MM_To_UPE__r.Attendee_Summary__c != null 
                      AND  MM_Slot_Status__c ='Missed'
                      ORDER BY MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_slot_StartTime__c];
   missedattendeelist = new LIST<MissedAttendeeInner>();
   for(EventSchedule__c totalattendee1 : totalmatcheslist){  
     missedattendeelist.add(new MissedAttendeeInner(totalattendee1));
   }    
   }catch(exception ex){}
   return null;
  } 
  // ----------------------------------------------- Missed Appointments Report End ---------------------------------------------------------
  
  // --------------------------------------------------- Attendee Inner Class Start -----------------------------------------------------
    
  public class MissedAttendeeInner
  {
      public LIST<EventSchedule__c> listofAttendees1{get;set;}
      public MissedAttendeeInner(EventSchedule__c es1){
          listofAttendees1 = new LIST<EventSchedule__c>{es1};
      }  
  }
  
  // --------------------------------------------------- Attendee Inner Class End -----------------------------------------------------
  
  // --------------------------------------------------- Attendee Inner Class Start -----------------------------------------------------
    
  public class TotalAttendeeInner
  {
      public EventSchedule__c listofAttendees{get;set;}
      public string ltmodified{get;set;}
      public TotalAttendeeInner(EventSchedule__c es,string lm){
          listofAttendees = es;
          ltmodified = lm;
      }  
  }
  
  // --------------------------------------------------- Attendee Inner Class End -----------------------------------------------------
  
  // -------------------------------------------------- Percent Utilization Chart Start ------------------------------------------------------
  public void PercentUtilizationChart() 
  {  
  try{
      viewreport1 = false;
      viewreport2 = false;
      viewreport3 = false;
      piechartbool = true;  
      emailalert = false;
      assignalert = false;   
      reporttitle = 'Appointment Chart';
      utilizationchart= [SELECT MM_Slot_Status__c s,count(id) c
                         FROM EventSchedule__c 
                         WHERE EV_id__c =: eventSelected  
                         AND Is_Matchmaking__c = true 
                         AND MM_To_EAM__c != null
                         AND MM_To_UPE__r.Attendee_Summary__c != null
                         GROUP BY MM_Slot_Status__c];    
      pieData = new LIST<utilizationinner>();   
      for(AggregateResult uc : utilizationchart)     
      {
           slotstatusCount=(Integer)uc.get('c');
           slotstatus=(String)uc.get('s');
           slotstatusinfo = (String)uc.get('s') + ' : '+ String.valueOf((Integer)uc.get('c'));
           pieData.add(new utilizationinner(slotstatus,slotstatusCount,slotstatusinfo));
      }
    }catch(exception ex){}
    }
    
    // ---------------------------------------------------- Inner class ------------------------------------------------------------------
    public class utilizationinner 
    {
        public integer totalmatchesvalue{get;set;} 
        public String utilization{get;set;} 
        public String utilizationinfo{get;set;} 
        public utilizationinner(String utilization, Integer totalmatchesvalue,String utilizationinfo)  
        { 
            this.totalmatchesvalue = totalmatchesvalue;
            this.utilization = utilization;  
            this.utilizationinfo = utilizationinfo;   
        }
    }
    // -------------------------------------------------- Percent Utilization Chart End ------------------------------------------------------
    
    // ---------------------------------------------------- Print Schedule Method Start ------------------------------------------------------
    public PageReference printschedule(){
   // try{
     eventDetailsInPrint();

     totalmatchesexport = new list<EventSchedule__c>();
     system.debug('   BOOLEAN VALUE   '+totalmatchesbool);
     if(totalmatchesbool == true){
         selectedprint = 'Total Appointments Made';
         totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,lastmodifieddate,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_Slot_Status__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c, 
                              /*  MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                              
                               FROM EventSchedule__c 
                               WHERE EV_id__c =: eventSelected  
                               AND Is_Matchmaking__c = true 
                               AND MM_To_EAM__c != null
                               AND MM_To_UPE__r.Attendee_Summary__c != null
                               AND MM_Slot_Status__c = 'Accepted'
                               ORDER BY starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];
         system.debug('   MATCHES LIST   '+totalmatchesexport);
                      
         Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Total_Appointments_Made.pdf');
     }
     else if(missedbool == true){
         selectedprint = 'Missed Appointments';
         totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,lastmodifieddate,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_Slot_Status__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                               FROM EventSchedule__c 
                               WHERE EV_id__c =: eventSelected  
                               AND Is_Matchmaking__c = true 
                               AND MM_To_EAM__c != null
                               AND MM_To_UPE__r.Attendee_Summary__c != null
                               AND MM_Slot_Status__c = 'Missed'
                               ORDER BY MM_To_UPE__r.Attendee_Summary__c,MM_slot_StartTime__c];
         Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Missed_Appointments.pdf');                     
     }else if(cancelledbool==true){
         selectedprint = 'Cancelled/Rejected Appointments';
         totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,lastmodifieddate,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_Slot_Status__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c       
                               FROM EventSchedule__c 
                               WHERE EV_id__c =: eventSelected  
                               AND Is_Matchmaking__c = true 
                               AND MM_To_EAM__c != null
                               AND MM_To_UPE__r.Attendee_Summary__c != null
                               AND (MM_Slot_Status__c = 'Rejected' OR MM_Slot_Status__c ='Rescheduled' OR MM_Slot_Status__c ='Cancelled')
                               ORDER BY MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_slot_StartTime__c];
         Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Cancelled/Rejected_Appointments.pdf');                 
     }
     else if(viewScheduleByTimeList2==true){
         selectedprint = 'Appointments by Group';
         totalmatchesexport = [SELECT ID,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,lastmodifieddate,
                                MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c,
                                MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_Slot_Status__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c 
                           FROM EventSchedule__c 
                           WHERE   EV_id__c =: eventSelected 
                           AND Is_Matchmaking__c = true 
                           AND MM_To_EAM__c != null
                           AND MM_To_UPE__r.Attendee_Summary__c != null                        
                           ORDER BY MM_Slot_Status__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];
         Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Appointments_by_Group.pdf');                 
     }
     //}catch(exception ex){}
     eventDetailsInPrint();
     pagereference pg =page.PrintSchedule;  
     return pg; 
    }
    // ---------------------------------------------------- Print Schedule Method End ------------------------------------------------------
    public PageReference printpendingschedule(){
    try{
     totalmatchesexport = new list<EventSchedule__c>();
     selectedprint = 'Pending Appointments';
     totalmatchesexport = [SELECT ID,MM_slot_StartTime__c,MM_Slot_End_Time__c,LastModifiedBy.userName,Owner.userName,LastModifiedDate,
                            MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c, 
                            MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,CreatedDate,
                            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                            /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c         
                           FROM EventSchedule__c 
                           WHERE EV_id__c =: eventSelected  
                           AND Is_Matchmaking__c = true 
                           AND MM_To_EAM__c != null
                           AND MM_To_UPE__r.Attendee_Summary__c != null
                           AND MM_Slot_Status__c = 'Pending'
                           ORDER BY MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_slot_StartTime__c];
    pendingattendeelist1 = new LIST<PendingAttendeeInner1>();
    mappendingAttendees1 = new MAP<string, PendingAttendeeInner1>();
    for(EventSchedule__c pendingattendee1 : totalmatchesexport){  
    date lastmodified = Date.valueOf(pendingattendee1.LastModifiedDate);
    date todaydate =Date.valueOf(Datetime.now());
     integer days = lastmodified.daysBetween(todaydate);     
     String strdays;
     if(days == 1){
         strdays = string.valueof(days) +' '+'day'+' ';
     }
     else if(days == 0){
         strdays = '';
     }
     else{
         strdays = string.valueof(days) +' '+'days'+' ';
     }
     Long ti = Datetime.now().getTime() - pendingattendee1.LastModifiedDate.getTime();
     DateTime dt = DateTime.valueOf(ti);
     if(mappendingAttendees1.get(pendingattendee1.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c) == null)
     {
        mappendingAttendees1.put(pendingattendee1.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,new PendingAttendeeInner1(pendingattendee1,dt,strdays));      
        pendingattendeelist1.add(mappendingAttendees1.get(pendingattendee1.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c));               
     }
     else
     {
        mappendingAttendees1.get(pendingattendee1.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c).listofAttendees1.add(pendingattendee1);              
     }
   }    
   }catch(exception ex){} 
    Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Pending_Appointments.pdf');
    eventDetailsInPrint();
    pagereference pg = page.PrintPendingSchedule;  
    return pg;
  } 
  
  public class PendingAttendeeInner1
  {
      public LIST<EventSchedule__c> listofAttendees1{get;set;}
      public DateTime PendingTime1{get;set;}
      public String PendingDate1{get;set;}
      public string dummyCompany1{get;set;}
      public string CorporateName1{get;set;}
      public string CorporateContact1{get;set;}
      public PendingAttendeeInner1(EventSchedule__c es,DateTime pt,String dayss){
          dummyCompany1 = es.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c;
          CorporateName1 = es.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + es.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c ;
          CorporateContact1 = es.MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c;
          PendingDate1 = dayss;
          PendingTime1 = pt;
          listofAttendees1 = new LIST<EventSchedule__c>{es};
      }  
  }
    
    
    
    
    // -------------------------------------------------- Export Schedule Method Start ------------------------------------------------------
    public PageReference exportschedule(){
    try{
     matforexport = new list<list<EventSchedule__c>>(); 
     if(totalmatchesbool == true){
         selectedprint = 'Total Appointments Made';
         totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c,
                                lastmodifieddate
                                FROM EventSchedule__c 
                                WHERE EV_id__c =: eventSelected  
                                AND Is_Matchmaking__c = true 
                                AND MM_To_EAM__c != null
                                AND MM_To_UPE__r.Attendee_Summary__c != null
                                AND MM_Slot_Status__c = 'Accepted'
                                ORDER BY starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];
     }
     else if(pendingbool == true){
         selectedprint = 'Pending Appointments';
         totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c,
                                lastmodifieddate
                                FROM EventSchedule__c 
                                WHERE EV_id__c =: eventSelected  
                                AND Is_Matchmaking__c = true 
                                AND MM_To_EAM__c != null
                                AND MM_To_UPE__r.Attendee_Summary__c != null
                                AND MM_Slot_Status__c = 'Pending'
                                ORDER BY starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];
                               system.debug('****** '+totalmatchesexport.size());                   
     }
     else if(missedbool == true){
         selectedprint = 'Missed Appointments';
         totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c,
                                lastmodifieddate
                                FROM EventSchedule__c 
                                WHERE EV_id__c =: eventSelected  
                                AND Is_Matchmaking__c = true 
                                AND MM_To_EAM__c != null
                                AND MM_To_UPE__r.Attendee_Summary__c != null
                                AND MM_Slot_Status__c = 'Missed'
                                ORDER BY starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];                  
     
     }
     else{
         selectedprint = 'Cancelled/Rejected Appointments';
         totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,lastmodifieddate,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,EV_id__r.EV_HostingTimeZone__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                                
                                FROM EventSchedule__c 
                                WHERE EV_id__c =: eventSelected  
                                AND Is_Matchmaking__c = true 
                                AND MM_To_EAM__c != null
                                AND MM_To_UPE__r.Attendee_Summary__c != null
                                AND (MM_Slot_Status__c = 'Rejected' OR MM_Slot_Status__c ='Rescheduled' OR MM_Slot_Status__c ='Cancelled')
                                ORDER BY starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];           
     }   
     bn = new list<EventSchedule__c>();
     system.debug('    EXPORT DATA '+totalmatchesexport );
     for(EventSchedule__c s: totalmatchesexport )
     {
      /*s.MM_To_UPE__r.BT_id__r.BT_Name__c = s.MM_To_UPE__r.BT_id__r.BT_Name__c;    
      s.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c = s.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c; 
      s.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c = s.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c; 
      s.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c = escape(s.MM_To_UPE__r.Attendee_Summary__r.AS_Company__c); 
      s.MM_To_UPE__r.BT_id__r.BT_ContactPhone__c = s.MM_To_UPE__r.BT_id__r.BT_ContactPhone__c;
      s.MM_To_UPE__r.BT_id__r.BT_ContactPhone__c = s.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c;
      s.MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c = s.MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c;
      s.MM_To_EAM__r.AS_id__r.AS_Company__c = s.MM_To_EAM__r.AS_id__r.AS_Company__c;
      s.MM_To_EAM__r.AS_id__r.AS_FirstName__c = s.MM_To_EAM__r.AS_id__r.AS_FirstName__c;
      s.MM_To_EAM__r.AS_id__r.AS_LastName__c = s.MM_To_EAM__r.AS_id__r.AS_LastName__c;
      s.MM_slot_StartTime__c = s.MM_slot_StartTime__c;
      s.MM_Slot_End_Time__c = s.MM_Slot_End_Time__c;
      s.MM_To_UPE__r.BT_id__r.MM_TableNo__c = s.MM_To_UPE__r.BT_id__r.MM_TableNo__c;*/
      bn.add(s);
     }
     matforexport.add(bn);      
     }catch(exception ex){}    
     pagereference pg =page.ExportSchedule;
     return pg; 
    }
    // -------------------------------------------------- Export Schedule Method End ------------------------------------------------------
    
    // ------------------------------------------------ Send Remainder Email Start --------------------------------------------------------
    public id eventscheduleid{get;set;}
    public PageReference sendRemainderEmail(){
    try{
       string ss = ApexPages.currentPage().getParameters().get('mycheck');
       eventscheduleid = ss;
       eventschedule = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,
                            MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c, 
                            MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
                            MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                            /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c     
                            FROM EventSchedule__c 
                            WHERE EV_id__c =: eventSelected  
                            AND Is_Matchmaking__c = true 
                            AND MM_To_EAM__c != null
                            AND MM_To_UPE__r.Attendee_Summary__c != null
                            AND MM_Slot_Status__c = 'Pending'
                            AND id =: eventscheduleid ];
       EmailTemplate E = new EmailTemplate();    
       E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Pending Invitations Reminder Email'];    
      OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'McMillen, Shelli'];
      Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
      if(owea.size() > 0 ) {
            email.setOrgWideEmailAddressId(owea.get(0).Id);
       }                  
       String[] toAddresses = new String[]{eventschedule.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c};
       email.setToAddresses(toAddresses);
       String subject = E.Subject;
       String ReplaceContactName = E.HtmlValue;
       String replacedname = ReplaceContactName.Replace('{!Name}',eventschedule.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + eventschedule.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c);
       email.setSubject(subject);    
       email.setHtmlBody(replacedname); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email}); 
        emailalert = true;
        }catch(exception ex){}
        return null;
    }
    // -------------------------------------------- Send Remainder Email End --------------------------------------------------------------
    
    // ---------------------------------------- Send Remainder Email to All Start ----------------------------------------------------------
    public MAP<String, String> findDuplicateEmail{get;set;}
    
    public PageReference sendRemainderEmailtoAll(){
    try{
        totalmatchesexport = new LIST<EventSchedule__c>();
        totalmatchesexport = [SELECT id,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c, 
                                MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.AS_id__r.AS_Email__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c     
                                FROM EventSchedule__c 
                                WHERE EV_id__c =: eventSelected  
                                AND Is_Matchmaking__c = true 
                                AND MM_To_EAM__c != null
                                AND MM_To_UPE__r.Attendee_Summary__c != null 
                                AND MM_Slot_Status__c = 'Pending'
                                ORDER BY MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c];
        findDuplicateEmail = new MAP<String, String>();               
        LIST<Messaging.SingleEmailMessage> emails = new LIST<Messaging.SingleEmailMessage>();
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'McMillen, Shelli'];       
        for(EventSchedule__c es : totalmatchesexport){
            if(!findDuplicateEmail.containsKey(es.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c)){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            if(owea.size() > 0) {
                email.setOrgWideEmailAddressId(owea.get(0).Id);
            } 
            EmailTemplate E = new EmailTemplate();    
            E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Pending Invitations Reminder Email'];                      
            String[] toAddresses = new String[]{es.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c};       
            email.setToAddresses(toAddresses);
            String subject = E.Subject;
            String ReplaceContactName = E.HtmlValue;
            String replacedname = ReplaceContactName.Replace('{!Name}',es.MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c + ' ' + es.MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c);
            email.setSubject(subject);    
            email.setHtmlBody(replacedname); 
            emails.add(email); 
            findDuplicateEmail.put(es.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,es.MM_To_UPE__r.Attendee_Summary__r.AS_Email__c);
            }
        }
        Messaging.SendEmailResult[] r = Messaging.sendEmail(emails);
        emailalert = true;
        }catch(exception ex){
        }
        return null;
    }
    // ---------------------------------------- Send Remainder Email to All End ------------------------------------------------------------
  
    // ------------------------------------------------------ Cancel Method Start ---------------------------------------------------------
    public pagereference cancel(){
     piechartbool = false;
     viewreport1 = false;
     viewreport2 = false;
     viewreport3 = false;
     viewreport4 = false;
     viewreportopen = false;
     emailalert = false;
     assignalert = false; 
     crpcountofapp=false;
     viewScheduleByTimeList= false;
     pagereference pg= new pagereference('/apex/MM_EventAdmin_Reports');      
     pg.setRedirect(true);  
     return pg; 
    }
    // ------------------------------------------------------ Cancel Method End ---------------------------------------------------------
    
    // -------------------------------------------------- Escape Special Characters Start -----------------------------------------------
    public string escape(string s){
       if(s != null && s.contains(',')){  
            s=s.replaceAll(',', ' ');
       } 
        return s;
   }
 
    // -------------------------------------------------- Escape Special Characters End -----------------------------------------------
    
 
     //----------------------------------------------------Open appointments report****mythily nagandla **------------------------
     public boolean viewreportopen{get;set;}
     public string slotsstring {get;set;}
     public list<User_Profile_Event__c> UPES {get;set;}
     public list<openappointments>  openlist {get;set;}
     public Event__c eventDetails{get; set;}

     public void Openappointments(){
     try{
      slotsstring ='';
      viewreportopen = true;
      reporttitle = 'Open Appointments';
      list<string> appointments=new list<string>();
      list<string> appointmentslist=new list<string>();
      openlist = new list<openappointments>();
      UPES = new List<User_Profile_Event__c>();
      UPES = [select id,User_id__r.name,User_id__r.CompanyName,(select MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c, 
                      /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,EV_id__r.Is_Webank_event__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                        MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                        MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                        MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                        MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                        MM_To_EAM__r.MBE_Profile__r.DBA__c,
                        MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                        MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                        MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                        MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                        MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                        MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                        MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                        MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                        MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.References__c,
                        MM_To_EAM__r.MBE_Profile__r.References2__c,
                        MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                        MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                        MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                        MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                        MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                        MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                        MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                        MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                        From EventSchedule__r where (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending') AND EV_id__c =: eventSelected) 
                        EV_id__r.MM_Start_Date__c,EV_id__r.MM_End_Date__c,EV_id__r.MM_Firstaday_startTime__c,EV_id__r.MM_Firstaday_EndTime__c,EV_id__r.MM_Slot_Timeperiod__c,EV_id__r.BreakTime_Between_Appointments__c,
                        Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_CellPhone__c,Attendee_Summary__r.AS_Company__c,EV_id__r.Is_Webank_event__c 
                        From User_Profile_Event__c 
                        Where EV_id__c =: eventSelected 
                        AND Attendee_Summary__c != null 
                        AND MAtchMakingProfile__c = 'Corporate'
                        AND IsMatchMakingUser__c = true 
                        AND Request_for_upgrade_profile__c = false 
                        ORDER BY Attendee_Summary__r.AS_Company__c];
       
     system.debug('        total appointments    '+UPES[0].EventSchedule__r );
      if(UPES[0].EV_id__r.BreakTime_Between_Appointments__c == null || UPES[0].EV_id__r.BreakTime_Between_Appointments__c == ''){
         UPES[0].EV_id__r.BreakTime_Between_Appointments__c ='0';
      }
      appointments = MM_Utility.givesSlotTimings(UPES[0].EV_id__r.MM_Firstaday_startTime__c,UPES[0].EV_id__r.MM_Firstaday_EndTime__c,UPES[0].EV_id__r.MM_Slot_Timeperiod__c,UPES[0].EV_id__r.BreakTime_Between_Appointments__c);
      system.debug('        total appointments    '+appointments);
      
      for(User_Profile_Event__c Unames1: UPES){
          unames1.Attendee_Summary__r.AS_FirstName__c = escape(unames1.Attendee_Summary__r.AS_FirstName__c);
          unames1.Attendee_Summary__r.AS_LastName__c = escape(unames1.Attendee_Summary__r.AS_LastName__c);
          unames1.Attendee_Summary__r.AS_Company__c = escape(unames1.Attendee_Summary__r.AS_Company__c);
      }
      database.update(UPES,false);
      
      for(User_Profile_Event__c Unames: UPES){
          list<string> slotlist=new list<string>();
          slotsstring = '';        
          for(EventSchedule__c es: Unames.EventSchedule__r){
              slotsstring += es.MM_slot_StartTime__c+',';              
          }
          for(string slot:appointments){
                  system.debug('         slots     '+slot + '     scheduled slot '+slotsstring );
                  list<string> slots= slot.split('-');
                  if(slotsstring.contains(slots[0])){ 
                                  
                  }else{
                  slotlist.add(slot);
                  }
                  //slotlist=escapelist(slotlist);
          } 
          openlist.add(new openappointments(Unames,slotlist));  
          }       
     }catch(exception ex){}
     }
     
     public class openappointments{
         public User_Profile_Event__c up {get;set;}
         public list<string> openapp {get;set;}
             public openappointments(User_Profile_Event__c up,list<string> openapp){
                 this.up        = up;
                 this.openapp   = openapp;
             }    
     }
     
     public pagereference printopen(){
         pagereference pg=page.openappointmentspdf;
         return pg;
     }
     public pagereference exportopen(){  
         pagereference pf=page.Exportopenappointments;
         return pf;     
     }
     //---------------------------------------** changed by mythily is completed------------------------
     
     // ---------------------------------------------------- Appointments by time Method Start --------------------------------------------
     
    public LIST<EventSchedule__c> schedulesByTime{get; set;}
    public boolean viewScheduleByTimeList{get; set;}
    public LIST<SelectOption> timeList{get; set;}
    public LIST<SelectOption> dateList{get; set;}
    public String selectedTime{get; set;}
    public String selectedEventDate{get; set;}
    public SET<String> timeSlotSET{get; set;}
    public LIST<String> eventDates{get; set;}
    public MAP<Date , LIST<String>> eventAllDates{get; set;}
    public LIST<String> timeSlotLIST {get; set;}
    public LIST<MatchLeads_Days__c> allEventDates{get; set;}
    public boolean ShowDatePicklist{get; set;}
    
    public void appointmentsByTime(){
         
         timeList= new LIST<SelectOption>();
         dateList= new LIST<SelectOption>();
         byTimeInnerList= new LIST<byTimeInner> ();
         schedulesByTime= new LIST<EventSchedule__c>();
         timeSlotLIST= new LIST<String>();
         
         timeList.add(new SelectOption('All','All'));
         selectedTime= 'All';
         viewScheduleByTimeList= true;
         system.debug('  EVENT SELECTED  '+eventSelected);
         slotsstring ='';
         reporttitle = 'Appointments By Time';
         
         eventAllDates= new MAP<Date, LIST<String>>();
         eventDates = new LIST<String>();
         
         
         allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: eventSelected ORDER BY MatchLeads_Date__c ASC]);
         //String dateToPass= String.valueOf(allEventDates[0].MatchLeads_Date__c);
         eventAllDates= MM_Utility.giveEventTimingsWithDates(eventSelected, allEventDates[0].MatchLeads_Date__c);
         
         system.debug('   EVENT DATES SPLIT '+eventAllDates);
         eventDates= eventAllDates.get(allEventDates[0].MatchLeads_Date__c);
         selectedEventDate= allEventDates[0].MatchLeads_Date__c.format();
         
         if(allEventDates.size() >1){
         ShowDatePicklist= true;
         for(MatchLeads_Days__c matchDate: allEventDates){
             
             String eventDate= matchDate.MatchLeads_Date__c.format() ;
             dateList.add(new selectoption(eventDate,eventDate));
         }
         
         }
         
        for(String slotStr: eventDates){
         
             timeList.add(new Selectoption(slotStr, slotStr));
             timeSlotLIST.add(slotStr);

         }
        scheduleRecords();
     }
     
     public void timesList(){
     
     schedulesByTime= new LIST<EventSchedule__c>();
     timeList= new LIST<SelectOption>();
     timeList.add(new SelectOption('All','All'));
     timeSlotLIST= new LIST<String>();
     timeSlotLIST= new LIST<String>();
     eventAllDates= new MAP<Date, LIST<String>>();
     selectedTime= 'All';
     if(selectedEventDate != null || selectedEventDate != 'All' || selectedEventDate != ''){
     
     system.debug('    DATE STRING  '+selectedEventDate );
     LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
     Date dateString= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
           
     system.debug(' DATE VALUE GET '+dateString);
     eventAllDates= MM_Utility.giveEventTimingsWithDates(eventSelected, dateString);

     eventDates= eventAllDates.get(dateString);
     //eventDates.sort();
     system.debug(' TIME LIST SELECTED  '+timeList);

         for(String slotStr: eventDates){
         
             timeList.add(new Selectoption(slotStr, slotStr));
             timeSlotLIST.add(slotStr);

         
         }
         
         }
     
     
     
       scheduleRecords();
     
     }
     
     
     public pagereference scheduleRecords(){
        try{  
        
         byTimeInnerList= new LIST<byTimeInner> ();
         schedulesByTime= new LIST<EventSchedule__c>();
         
         
         system.debug('  REDUCE THE CODE '+schedulesByTime+'   '+selectedTime +'    '+selectedEventDate );
              if(selectedEventDate != null &&  selectedTime == 'All'){
                 LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                 Date dateString= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
    
             schedulesByTime= [SELECT ID,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,
                                MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c,
                                MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_Slot_Status__c,MM_slot_Date__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c
                                FROM EventSchedule__c 
                                WHERE (MM_Slot_Status__c != null) AND
                                MM_Slot_Status__c =: 'Accepted' AND
                                EV_id__c =: eventSelected AND
                                MM_To_EAM__c != null AND
                                MM_To_UPE__r.MAtchMakingProfile__c = 'Corporate' AND 
                                MM_To_UPE__r.IsMatchMakingUser__c = true AND 
                                MM_To_UPE__r.Request_for_upgrade_profile__c = false AND
                                MM_slot_Date__c =: dateString
                                ORDER BY MM_slot_StartTime__c, MM_Slot_Status__c,MM_To_EAM__r.AS_id__r.AS_Company__c];
          timeSlotLIST= new LIST<String>();
          eventAllDates= new MAP<Date, LIST<String>>();
          eventAllDates= MM_Utility.giveEventTimingsWithDates(eventSelected, dateString);

          eventDates= eventAllDates.get(dateString);
          for(String slotStr: eventDates){
         
             timeSlotLIST.add(slotStr);

         
         }
          system.debug('SCHEDULE BY TIME  '+schedulesByTime);
         }else if(selectedEventDate != null &&  selectedTime != 'All'){
             List<String> splitTime= new LIST<String>(selectedTime.split('-'));
             LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
             Date dateString= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
                      timeSlotLIST= new LIST<String>();
             timeSlotLIST.add(selectedTime);

             schedulesByTime= [SELECT ID,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,
                                MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,
                                MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c,
                                MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,
                                MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_Slot_Status__c, MM_slot_Date__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                                /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                                MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                                MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                                MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                                MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                                MM_To_EAM__r.MBE_Profile__r.DBA__c,
                                MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                                MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                                MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                                MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                                MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                                MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                                MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                                MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                                MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.References__c,
                                MM_To_EAM__r.MBE_Profile__r.References2__c,
                                MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                                MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                                MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                                MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                                MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                                MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                                MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                                MM_To_EAM__r.MBE_Profile__r.Year_in_business__c 
                                FROM EventSchedule__c 
                                WHERE (MM_Slot_Status__c != null) AND
                                MM_Slot_Status__c =: 'Accepted' AND
                                EV_id__c =: eventSelected AND
                                MM_To_EAM__c != null AND
                                MM_To_UPE__r.MAtchMakingProfile__c = 'Corporate' AND 
                                MM_To_UPE__r.IsMatchMakingUser__c = true AND 
                                MM_To_UPE__r.Request_for_upgrade_profile__c = false AND
                                MM_slot_StartTime__c =: splitTime[0] AND 
                                MM_Slot_End_Time__c =: splitTime[1] AND
                                MM_slot_Date__c =: dateString
                                ORDER BY MM_slot_StartTime__c, MM_Slot_Status__c,MM_To_EAM__r.AS_id__r.AS_Company__c];
           system.debug('    LIST OF RECOREDS  '+schedulesByTime);
             //AND MM_slot_StartTime__c =: splitTime[0] AND MM_Slot_End_Time__c =: splitTime[1] 
         }
           
           // timeSlotLIST.sort();
               system.debug('   TIME SLOT LIST  '+timeSlotLIST);
       
           for(String timeSlot: timeSlotLIST){
           system.debug('   TIME SLOT '+timeSlot);
           
               LIST<EventSchedule__c> statusScheduleList= new LIST<EventSchedule__c>(); 
               String status= '';
                   for(EventSchedule__c es: schedulesByTime){
                   List<String> splitTime= new LIST<String>(timeSlot.split('-'));
                 system.debug(' SPLIT  TIME SLOT '+splitTime);

                       if(es.MM_slot_StartTime__c == splitTime[0] && es.MM_Slot_End_Time__c == splitTime[1]){
                 system.debug('IF   SPLIT  TIME SLOT '+splitTime+'   '+es.MM_Slot_End_Time__c);

                           statusScheduleList.add(es);

                       }

                   }  
                                   system.debug('INN TIME SLOT '+statusScheduleList.size());
                    
                if(statusScheduleList.size() != 0){
                //statusScheduleList.sort();
                //system.debug('@global'+statusScheduleList.size());
               // system.debug('@globalt'+timeSlot);
                    byTimeInnerList.add(new byTimeInner(timeSlot, statusScheduleList));
                                                       system.debug('INNER TIME SLOT '+statusScheduleList.size()+'   '+byTimeInnerList.size());

                  }

             }
       }catch(exception es){}
       return null;
     }
     
     public LIST<byTimeInner> byTimeInnerList{get; set;}
     public class byTimeInner{
         
         public string timeSlotString{get; set;}
         //public string statusString{get; set;}
         public LIST<EventSchedule__c> schedulesList{get; set;}
         
         public byTimeInner(string timeSlotStr, LIST<EventSchedule__c> sList){
             //,string statusStr
             schedulesList= new LIST<EventSchedule__c>();
             
             this.timeSlotString= timeSlotStr;
             //this.statusString= statusStr;
             this.schedulesList= sList;
             system.debug('   SCHEDULE LIST  INNER   '+'   '+schedulesList);
         }
     }
     
     public LIST<byTimeInner> byTimeExportInnerList{get; set;}
     
     public pagereference exportScheduleTime(){
     
         system.debug('    EXPORT DATA '+byTimeInnerList);
         byTimeExportInnerList= new LIST<byTimeInner>();
     for(byTimeInner sinn: byTimeInnerList){
         
         LIST<EventSchedule__c> schList= new LIST<EventSchedule__c >(); 
         for(EventSchedule__c esch: sinn.schedulesList){
              system.debug('  EXPORT   '+esch);
              esch.MM_To_UPE__r.BT_id__r.BT_Name__c = esch.MM_To_UPE__r.BT_id__r.BT_Name__c;    
              //esch.MM_To_UPE__r.BoothAdmin_id__r.Name = escape(esch.MM_To_UPE__r.BoothAdmin_id__r.Name); 
              esch.MM_To_UPE__r.BoothAdmin_id__r.Email = esch.MM_To_UPE__r.BoothAdmin_id__r.Email; 
              esch.MM_To_UPE__r.BT_id__r.BT_ContactPhone__c = esch.MM_To_UPE__r.BT_id__r.BT_ContactPhone__c;
              
               esch.MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c = esch.MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c;
               esch.MM_To_EAM__r.AS_id__r.AS_FirstName__c = esch.MM_To_EAM__r.AS_id__r.AS_FirstName__c;
              esch.MM_To_EAM__r.AS_id__r.AS_LastName__c = esch.MM_To_EAM__r.AS_id__r.AS_LastName__c;
             esch.MM_To_EAM__r.AS_id__r.AS_Company__c = esch.MM_To_EAM__r.AS_id__r.AS_Company__c;
             esch.MM_To_EAM__r.AS_id__r.AS_CellPhone__c = esch.MM_To_EAM__r.AS_id__r.AS_CellPhone__c;
             esch.MM_To_EAM__r.AS_id__r.AS_Email__c  = esch.MM_To_EAM__r.AS_id__r.AS_Email__c;
             esch.MM_slot_StartTime__c = esch.MM_slot_StartTime__c;
              esch.MM_Slot_End_Time__c = esch.MM_Slot_End_Time__c;
              esch.MM_To_UPE__r.BT_id__r.MM_TableNo__c = esch.MM_To_UPE__r.BT_id__r.MM_TableNo__c;
              schList.add(esch);
     }
         byTimeExportInnerList.add(new byTimeInner(sinn.timeSlotString, schList));
     }
     system.debug('  EXPORT SCHEDULE LIST  '+byTimeExportInnerList);
     pagereference pg =page.ExportScheduleByTime;
     return pg; 
         
     }
     
     
      public PageReference printscheduleTime(){
        eventDetailsInPrint();
        pagereference pg=page.printscheduleByTimelist;
        return pg;
    } 
    
     public String eventDatesString {get; set;}
    
    public void eventDetailsInPrint(){
        
        eventDetails= new Event__c();
           system.debug('EVENT ID  '+eventSelected );                  

        if(eventSelected != null || eventSelected != ''){
            
            eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, EV_EventLogo__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,EV_HostingStateNew__c,Is_Webank_event__c 
                          FROM Event__c 
                          WHERE ID =: eventSelected ];
        system.debug('EVENT DATES STRING  '+eventDetails);  
        
        if(eventDetails.EV_StartDate__c == eventDetails.EV_EndDate__c){
            eventDatesString = string.valueof(eventDetails.EV_StartDate__c);
        } else if(eventDetails.EV_StartDate__c != eventDetails.EV_EndDate__c){
            eventDatesString = string.valueof(eventDetails.EV_StartDate__c)+' TO '+string.valueof(eventDetails.EV_EndDate__c);
        }
        }
        

    }
     // ---------------------------------------------------- Appointments by time Method End--------------------------------------------
     
     // ---------------------------------------------------- Booth Admins List Method Start --------------------------------------------
    
     public LIST<User_Profile_Event__c> boothslist{get;set;}
     public LIST<User_Profile_Event__c> boothslist1{get;set;}
     public LIST<User_Profile_Event__c> boothslist2{get;set;}
    public void boothadminslist(){
     try{
         viewreportboothslist  = true;
         reporttitle = 'Corporates List';
         boothslist = new LIST<User_Profile_Event__c>();
         boothslist = [SELECT id,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.AS_CellPhone__c,Attendee_Summary__r.AS_Company__c,BT_id__r.MM_TableNo__c,BT_id__r.BT_Location__c,
                       (SELECT name from EventSchedule__r  where MM_Slot_Status__c= 'Accepted')
                       FROM User_Profile_Event__c
                       WHERE Ev_id__r.id =: eventselected
                       AND BT_id__c != NULL
                       AND Attendee_Summary__c != NULL 
                       AND MAtchMakingProfile__c = 'Corporate' 
                       and IsMatchMakingUser__c=TRUE
                       //AND User_id__r.isSignup__c = TRUE
                       AND Request_for_upgrade_profile__c = FALSE 
                       ORDER BY Attendee_Summary__r.AS_Company__c
                       ]; 
         system.debug('^^^^^^^ '+boothslist.size());
         boothslist1= new LIST<User_Profile_Event__c>();
         boothslist2= new LIST<User_Profile_Event__c>();
          
         for(User_Profile_Event__c booths: boothslist){
         /* booths.Attendee_Summary__r.AS_FirstName__c = escape(booths.Attendee_Summary__r.AS_FirstName__c);
          booths.Attendee_Summary__r.AS_LastName__c = escape(booths.Attendee_Summary__r.AS_LastName__c);
          booths.Attendee_Summary__r.AS_Company__c = escape(booths.Attendee_Summary__r.AS_Company__c);
          booths.Attendee_Summary__r.AS_Email__c = escape(booths.Attendee_Summary__r.AS_Email__c);
          booths.Attendee_Summary__r.AS_CellPhone__c = escape(booths.Attendee_Summary__r.AS_CellPhone__c);*/
          
          if(booths.EventSchedule__r.size() >0){
              boothslist1.add(booths);
          }else{
              boothslist2.add(booths);
          }
          
          
          if(selectedfilterInformation=='Tables with Schedules')
          {
              boothslist = boothslist1;
          }
          
          if(selectedfilterInformation=='Tables without schedules')
          {
              boothslist = boothslist2;
          }
      }
      //database.update(boothslist,false);
      }catch(exception ex){}
     }
     
    public PageReference printboothslist() {
        eventDetailsInPrint();
        pagereference pg=page.printcorporateslist;
        return pg;
    }


    public PageReference exportboothslist() {
        pagereference pg=page.corporateslist;
        return pg;
    }    
    // ----------------------------------------------------- Booth Admins List Method End ---------------------------------------------
    //----------------------------Appointments By Group STARTS---------
    public SET<string> selectedEventSlotList2{get; set;}
    public LIST<EventSchedule__c> schedulesByTime2{get; set;}
    public boolean viewScheduleByTimeList2{get; set;}
    
     public void appointmentsByTime2(){
         system.debug('        mythily 2222222222222 ');
         selectedEventSlotList2=new SET<string>();
         schedulesByTime2= new LIST<EventSchedule__c>();
         byTimeInnerList2= new List<byTimeInner2>();
         viewScheduleByTimeList2= true;
         system.debug('  EVENT SELECTED  '+eventSelected);
         slotsstring ='';
         reporttitle = 'Appointments By Group';
         schedulesByTime2= [SELECT ID,MM_To_UPE__r.MM_TableNo__c,MM_Slot_End_Time__c,MM_To_UPE__r.id,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_WorkPhone__c,
                            MM_slot_StartTime__c,MM_To_UPE__r.BT_id__r.BT_Name__c, MM_To_UPE__r.BT_id__r.BT_ContactPhone__c,MM_To_UPE__r.BoothAdmin_id__r.Email,
                            MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c,
                            MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                            MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,
                            MM_To_UPE__r.Attendee_Summary__r.AS_Company__c, MM_Slot_Status__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                            /*MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                            MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                            MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                            MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                            MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                            MM_To_EAM__r.MBE_Profile__r.DBA__c,
                            MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                            MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                            MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                            MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                            MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                            MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                            MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                            MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                            MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.References__c,
                            MM_To_EAM__r.MBE_Profile__r.References2__c,
                            MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                            MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                            MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                            MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,*/
                            MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                            MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                            MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                            MM_To_EAM__r.MBE_Profile__r.Year_in_business__c 
                           FROM EventSchedule__c 
                           WHERE   EV_id__c =: eventSelected 
                           AND Is_Matchmaking__c = true 
                           AND MM_To_EAM__c != null
                           AND MM_To_UPE__r.Attendee_Summary__c != null                        
                           ORDER BY MM_Slot_Status__c,starttimein24hrs__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c];
       
          system.debug('SCHEDULE BY group  '+schedulesByTime2);

       Schema.DescribeFieldResult StatusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
       List<Schema.PicklistEntry> AllStatusValues= StatusValues.getPicklistValues();
       
     
       for (Schema.PicklistEntry a : AllStatusValues){ 
           
           system.debug('  PICK VALUE  '+a.getvalue()+'   '+a);
           LIST<EventSchedule__c> statusScheduleList= new LIST<EventSchedule__c>(); 
           for(EventSchedule__c es: schedulesByTime2){
           system.debug('  EVENT SCHEDULE PICK VALUE  '+es);

               if(es.MM_Slot_Status__c == a.getValue()){
                          system.debug('  IF PICK VALUE  '+es.MM_Slot_Status__c+'   ' +a.getValue());

                   statusScheduleList.add(es);
                             system.debug('  LIST VALUES11111111 '+statusScheduleList);

               }
          system.debug('  LIST VALUES222222222 '+statusScheduleList);

          }  
          system.debug('  LIST VALUES3333333333 '+statusScheduleList.size());

          if(statusScheduleList.size() != 0){
              system.debug(' INNER LIST VALUES11111111111 '+statusScheduleList.size());
              byTimeInnerList2.add(new byTimeInner2(a.getValue(), statusScheduleList));
                            system.debug(' INNER LIST VALUES22222222222222 '+byTimeInnerList2.size());

          }
          system.debug(' INNER LIST VALUES '+byTimeInnerList2);

       }
          for(EventSchedule__c es: schedulesByTime2){
              /*slotsstring= es.MM_slot_StartTime__c+'-'+es.MM_Slot_End_Time__c;   
              system.debug(' SLOT STRING  '+slotsstring);
              if(! selectedEventSlotList.contains(slotsstring)){
                 system.debug(' IF SLOT STRING  '+slotsstring);

                 selectedEventSlotList.add(es.MM_slot_StartTime__c+'-'+es.MM_Slot_End_Time__c);      
                 system.debug('IF SLOT LIST  '+selectedEventSlotList);
      
              }
                        system.debug(' SLOT LIST  '+selectedEventSlotList);
                        */
          
          }       
     }
     
     public LIST<byTimeInner2> byTimeInnerList2{get; set;}
     public LIST<byTimeInner2> byGroupExportInnerList{get; set;}
     public class byTimeInner2{
        
         public string statusString{get; set;}
         public LIST<EventSchedule__c> schedulesList2{get; set;}
         
         public byTimeInner2(string str, LIST<EventSchedule__c> sList){
             
             schedulesList2= new LIST<EventSchedule__c>();
             this.statusString= str;
             this.schedulesList2= sList;
             system.debug('   SCHEDULE LIST  INNER   '+statusString+'   '+schedulesList2);
         }
     }
     
     public pagereference exportScheduleGroup(){
      system.debug('     mythily  333333333333333 ');
         system.debug('    EXPORT DATA '+byTimeInnerList);
         byGroupExportInnerList= new LIST<byTimeInner2>();
     for(byTimeInner2 sinn: byTimeInnerList2){
         
         LIST<EventSchedule__c> schList= new LIST<EventSchedule__c >(); 
         for(EventSchedule__c esch: sinn.schedulesList2){
              system.debug('  EXPORT   '+esch);
              esch.MM_To_UPE__r.BT_id__r.BT_Name__c = esch.MM_To_UPE__r.BT_id__r.BT_Name__c;    
              //esch.MM_To_UPE__r.BoothAdmin_id__r.Name = escape(esch.MM_To_UPE__r.BoothAdmin_id__r.Name); 
              esch.MM_To_UPE__r.BoothAdmin_id__r.Email = esch.MM_To_UPE__r.BoothAdmin_id__r.Email; 
              esch.MM_To_UPE__r.BT_id__r.BT_ContactPhone__c = esch.MM_To_UPE__r.BT_id__r.BT_ContactPhone__c; 
               esch.MM_To_EAM__r.AS_id__r.AS_FirstName__c = esch.MM_To_EAM__r.AS_id__r.AS_FirstName__c;
              esch.MM_To_EAM__r.AS_id__r.AS_LastName__c = esch.MM_To_EAM__r.AS_id__r.AS_LastName__c;
             esch.MM_To_EAM__r.AS_id__r.AS_Company__c = esch.MM_To_EAM__r.AS_id__r.AS_Company__c;
             esch.MM_To_EAM__r.AS_id__r.AS_CellPhone__c = esch.MM_To_EAM__r.AS_id__r.AS_CellPhone__c;
             esch.MM_To_EAM__r.AS_id__r.AS_Email__c  = esch.MM_To_EAM__r.AS_id__r.AS_Email__c;
             esch.MM_slot_StartTime__c = esch.MM_slot_StartTime__c;
              esch.MM_Slot_End_Time__c = esch.MM_Slot_End_Time__c;
              esch.MM_To_UPE__r.BT_id__r.MM_TableNo__c = esch.MM_To_UPE__r.BT_id__r.MM_TableNo__c;
              schList.add(esch);
     }
         byGroupExportInnerList.add(new byTimeInner2(sinn.statusString, schList));
     }
     system.debug('  EXPORT SCHEDULE LIST  '+byTimeExportInnerList);
     pagereference pg =page.ExportScheduleByTime;
     return pg; 
         
     }
     
     
      public PageReference printscheduleGroup(){     
        eventDetailsInPrint();
        pagereference pg=page.printscheduleByTimelist;
        system.debug(' PRINT PDF PAGE ');
        return pg;
    } 
     //--------------------------Appointments By Group ENDS---------
     
    public Pagereference CheckUser(){
       
       Pagereference pg = MM_Utility.checkLogInservice();
       
       return pg;
       
   } 
   
   //-----------Signup chart----------------------------------------
 //  public List<inncls> upelist{get;set;}
   public Event__c event {get;set;}
   public boolean signupreport {get;set;}
   public Integer MBESignups{get; set;}
   public Integer MBENotSignups{get; set;}
   Public LIST<User> us{get;set;}
   public LIST<Event_Attendee_Mapping__c> lieamap{get;set;}
   Transient  MAP<String, User> mapusers{get;set;}
   public List<innerclass> eaminner{get;set;}
   
   public void signups()
   {
   signupreport =true;
     eaminner= new List<innerclass>();
 List<innerclass>    eaminnersort= new List<innerclass>();
     mapusers= new MAP<String, User>();
     MAP<string,DateTime> mapEmailWithUser = new MAP<string,DateTime>();      
       
       for(User u:[Select id,Email,isSignup__c,userName,SIgnup_Date__c,LastLoginDate from User Where isSignup__c=:True]){
           mapusers.put(u.userName,u);
           mapEmailWithUser.put(u.userName,u.SIgnup_Date__c);
       }
       
       
       lieamap= new  LIST<Event_Attendee_Mapping__c>();
       lieamap=[select id,IsMatchMakingAttendee__c,AS_id__r.AS_Email__c,AS_id__r.AS_Secondary_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_HomePhone__c,AS_id__r.AS_WorkPhone__c, 
                        MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_CellPhone__c,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_Email__c,MBE_Profile__r.AS_HomePhone__c,MBE_Profile__r.AS_Secondary_Email__c,EV_id__r.Is_Webank_event__c,
                        /*MBE_Profile__r.Any_non_WBENC_awards_received__c,MBE_Profile__r.AS_Age__c,
                        MBE_Profile__r.AS_NAICSCode6__c,
                        MBE_Profile__r.AS_BirthDate__c,
                        MBE_Profile__r.AS_BlogUrl__c,
                        MBE_Profile__r.AS_BusinessDescription__c,
                        MBE_Profile__r.AS_BusinessDunsNumber__c,
                        MBE_Profile__r.AS_BusinessEstablishedDate__c,
                        MBE_Profile__r.AS_BusinessRevenue__c,
                        MBE_Profile__r.Business_Structure__c,
                        MBE_Profile__r.AS_BusinessTaxId__c,
                        MBE_Profile__r.AS_BusinessTaxId_c__c,
                        MBE_Profile__r.Business_type__c,
                        MBE_Profile__r.AS_CageCode__c,
                        MBE_Profile__r.Certificate_Processed_by_RPO__c,
                        MBE_Profile__r.Commodity_1__c,
                        MBE_Profile__r.Commodity_2__c,
                        MBE_Profile__r.Commodity_3__c,
                        MBE_Profile__r.Commodity_4__c,
                        MBE_Profile__r.Commodity_5__c,
                        MBE_Profile__r.Company_Certifications__c,
                        MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                        MBE_Profile__r.DBA__c,
                        MBE_Profile__r.distribution_Country__c,
                        MBE_Profile__r.AS_DiversityType__c,
                        MBE_Profile__r.Ethnicity__c,
                        MBE_Profile__r.Event_Organizer_Id__c,
                        MBE_Profile__r.Exceptional_Key_Words__c,
                        MBE_Profile__r.Exhibitor_company_imageUrl__c,
                        MBE_Profile__r.AS_FaxNumber__c,
                        MBE_Profile__r.FaxNumber__c,
                        MBE_Profile__r.AS_Gender__c,
                        MBE_Profile__r.Geographical_Region__c,
                        MBE_Profile__r.GSA_Schedule__c,
                        MBE_Profile__r.AS_HomeAddress1__c,
                        MBE_Profile__r.AS_HomeAddress2__c,
                        MBE_Profile__r.AS_HomeCity__c,
                        MBE_Profile__r.As_Home_Country__c,
                        MBE_Profile__r.AS_HomePoBox__c,
                        MBE_Profile__r.As_Home_State__c,
                        MBE_Profile__r.AS_HomeZip__c,
                        MBE_Profile__r.AS_ImageUrl__c,
                        MBE_Profile__r.Key_Words__c,
                        MBE_Profile__r.Manufactures_Country__c,
                        MBE_Profile__r.As_NAICSCode_1__c,
                        MBE_Profile__r.As_NAICSCode_2__c,
                        MBE_Profile__r.As_NAICSCode_3__c,
                        MBE_Profile__r.As_NAICSCode_4__c,
                        MBE_Profile__r.As_NAICSCode_5__c,
                        MBE_Profile__r.AS_NAICSCode7__c,
                        MBE_Profile__r.AS_NAICSCode8__c,
                        MBE_Profile__r.AS_NAICSCode9__c,
                        MBE_Profile__r.AS_NumberOfEmployees__c,
                        MBE_Profile__r.As_prefixNew__c,
                        MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                        MBE_Profile__r.References__c,
                        MBE_Profile__r.References2__c,
                        MBE_Profile__r.Revenue_Range__c,
                        MBE_Profile__r.Scope_of_Work__c,
                        MBE_Profile__r.Scope_of_Work2__c,
                        MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                        MBE_Profile__r.As_Shipping_States__c,
                        MBE_Profile__r.AS_ShippingAddress1__c,
                        MBE_Profile__r.AS_ShippingAddress2__c,
                        MBE_Profile__r.AS_ShippingCity__c,
                        MBE_Profile__r.As_Shipping_Country__c,
                        MBE_Profile__r.AS_ShippingPhone__c,
                        MBE_Profile__r.AS_ShippingPoBox__c,
                        MBE_Profile__r.AS_ShippingState__c,
                        MBE_Profile__r.AS_shippingzip_c__c,
                        MBE_Profile__r.AS_ShippingZipcode__c,
                        MBE_Profile__r.As_SuffixNew__c,*/
                        MBE_Profile__r.AS_Title__c,
                        MBE_Profile__r.Total_Name__c,
                        MBE_Profile__r.AS_WebsiteUrl__c,
                        MBE_Profile__r.AS_Work_Country__c,
                        MBE_Profile__r.AS_Work_States__c,
                        MBE_Profile__r.AS_WorkAddress1__c,
                        MBE_Profile__r.AS_WorkAddress2__c,
                        MBE_Profile__r.AS_WorkCity__c,
                        MBE_Profile__r.AS_WorkPhone__c,
                        MBE_Profile__r.AS_WorkZip__c,
                        MBE_Profile__r.AS_WorkZipCode__c,
                        MBE_Profile__r.Year_in_business__c
                        from Event_Attendee_Mapping__c 
                        Where EV_id__r.id =:eventSelected 
                       // AND AS_id__r.AS_Secondary_Email__c!= NULL
                        AND Boothleads_Profile__c='Attendee'
                        AND IsMatchMakingAttendee__c=TRUE
                        ];
                        system.debug('111111111111111111111'+lieamap.size());
                  for(Event_Attendee_Mapping__c mapeam:lieamap){
                       string dtstr ='';
                       system.debug('111111111111111111111'+mapeam.AS_id__r.AS_Email__c);
                       if(null != mapEmailWithUser.get(mapeam.AS_id__r.AS_Email__c)){
                            dtstr = mapEmailWithUser.get(mapeam.AS_id__r.AS_Email__c).format();
                            system.debug('2222222222222222222222'+dtstr );
                       }
                        //eaminnersort.add(new innerclass(mapeam,mapusers.get(mapeam.AS_id__r.AS_Email__c),dtstr ));  
                        
                        if(selectedmbesignupInformation=='All'){
                               if( mapusers.get(mapeam.AS_id__r.AS_Email__c)!= null){
                                
                                    eaminnersort.add(new innerclass(mapeam,True,dtstr,mapusers.get(mapeam.AS_id__r.AS_Email__c).LastLoginDate  ));  
                                
                               }else{
                                    eaminnersort.add(new innerclass(mapeam,False,dtstr,null ));  
                                 }
                                 
                            }else if(selectedmbesignupInformation=='True'){
                                if(mapusers.get(mapeam.AS_id__r.AS_Email__c) !=null){
                                if(mapusers.get(mapeam.AS_id__r.AS_Email__c).isSignup__c == true){
                                    eaminnersort.add(new innerclass(mapeam,True,dtstr,mapusers.get(mapeam.AS_id__r.AS_Email__c).LastLoginDate));  
                                }
                                }
                            }else if(selectedmbesignupInformation=='False'){
                            
                                if(mapusers.get(mapeam.AS_id__r.AS_Email__c) == null){
                                    eaminnersort.add(new innerclass(mapeam,False,dtstr,null ));  
                                 }
                        }   
                    }
                    system.debug('3333333333333333333333333333333'+eaminnersort);
                    
                    eaminnersort.sort();
                    for(Integer m = eaminnersort.size()-1; m>=0;m--)
                    {
                        eaminner.add(eaminnersort.get(m));
                        }
                    system.debug('3333333333333333333333333333333'+eaminner.size());
                    
             }  
    
         
                    public class innerclass implements Comparable {
                    public Event_Attendee_Mapping__c eam{get;set;}
                    public boolean b{get;set;}
                    public string signupDate {get;set;}
                    public DateTime lastlogin{get;set;}
                    public innerclass(Event_Attendee_Mapping__c e,boolean bool,string sndt,DateTime lastlogindates){
                    this.eam=e;
                    b=bool;
                    this.signupDate  = sndt;
                    if(null!=lastlogindates)
                    this.lastlogin = lastlogindates;
                    
                    }
                    public integer compareTo(Object ObjToCompare) {
                    innerclass compareTomember = (innerclass)ObjToCompare;
        Integer returnValue = 0;
         if(b==FALSE || b==null){
         returnValue = -1;
         }else if(b==TRUE){
          returnValue = 1;
         }
                     
          
             return returnValue;       
               }    
                    }   

  public LIST<LIST<Event_Attendee_Mapping__c>> signexpo{get;set;} 
     public LIST<Event_Attendee_Mapping__c> expo{get;set;} 
     public  LIST<Event_Attendee_Mapping__c> an{get;set;}

  public pagereference exportignup(){
    /* signexpo = new LIST<LIST<Event_Attendee_Mapping__c>>();
     expo=[select id,IsMatchMakingAttendee__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_HomePhone__c,
                         MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_CellPhone__c,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_Email__c
                        from Event_Attendee_Mapping__c 
                        Where EV_id__r.id =:eventSelected 
                        AND AS_id__r.AS_Email__c!= NULL
                        AND Boothleads_Profile__c='Attendee'
                        AND IsMatchMakingAttendee__c=TRUE
         ];
    
      an= new LIST<Event_Attendee_Mapping__c>();
      
      for(Event_Attendee_Mapping__c u: expo)
      {
      if(u.AS_id__r.AS_Company__c != null || u.AS_id__r.AS_Company__c != null){
                   if(u.AS_id__r.AS_Company__c.contains(',')){
                    u.AS_id__r.AS_Company__c = escape(u.AS_id__r.AS_Company__c);}
                 }
      an.add(u);
      }
      signexpo.add(an);
      */
      pagereference pg =page.Exportmbesignups;
     return pg;
    }
    
   public pagereference printsignup()
   {
   /* expo= new LIST<Event_Attendee_Mapping__c>();
    expo=[select id,IsMatchMakingAttendee__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_HomePhone__c,
                        MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_CellPhone__c,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_Email__c
                        from Event_Attendee_Mapping__c 
                        Where EV_id__r.id =:eventSelected 
                        AND AS_id__r.AS_Email__c!= NULL
                        AND Boothleads_Profile__c='Attendee'
                        AND IsMatchMakingAttendee__c=TRUE];*/ 
     Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Small_Business_Signups.pdf');                
  eventDetailsInPrint();
  pagereference pg =page.printmbesignups;
     return pg;
   } 
   
  public string email2{get;set;}
  public Event_Attendee_Mapping__c sendemailupembe{get;set;}
  public void sendemailmbe()
  {
  system.debug('eventSelected  '+eventSelected +'email2 '+email2);
  sendemailupembe=[select id,EV_id__r.OrganizerId__c,EV_id__r.EV_Title__c,IsMatchMakingAttendee__c,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Company__c,AS_id__r.AS_HomePhone__c,
                    EV_id__r.EV_HistingAddr1__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingState__c,EV_id__r.EV_HostingZipcode__c,EV_id__r.EV_EventLogo__c,
                    EV_id__r.MM_Start_Date__c,EV_id__r.EV_HostingStateNew__c,EV_id__r.MM_Start_Time__c,EV_id__r.MM_End_Time__c,EV_id__r.Owner.name,AS_id__r.AS_Secondary_Email__c,
                    MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_CellPhone__c,MBE_Profile__r.AS_Company__c,MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                    /*MBE_Profile__r.Any_non_WBENC_awards_received__c,MBE_Profile__r.AS_Age__c,
                    MBE_Profile__r.AS_NAICSCode6__c,
                    MBE_Profile__r.AS_BirthDate__c,
                    MBE_Profile__r.AS_BlogUrl__c,
                    MBE_Profile__r.AS_BusinessDescription__c,
                    MBE_Profile__r.AS_BusinessDunsNumber__c,
                    MBE_Profile__r.AS_BusinessEstablishedDate__c,
                    MBE_Profile__r.AS_BusinessRevenue__c,
                    MBE_Profile__r.Business_Structure__c,
                    MBE_Profile__r.AS_BusinessTaxId__c,
                    MBE_Profile__r.AS_BusinessTaxId_c__c,
                    MBE_Profile__r.Business_type__c,
                    MBE_Profile__r.AS_CageCode__c,
                    MBE_Profile__r.Certificate_Processed_by_RPO__c,
                    MBE_Profile__r.Commodity_1__c,
                    MBE_Profile__r.Commodity_2__c,
                    MBE_Profile__r.Commodity_3__c,
                    MBE_Profile__r.Commodity_4__c,
                    MBE_Profile__r.Commodity_5__c,
                    MBE_Profile__r.Company_Certifications__c,
                    MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                    MBE_Profile__r.DBA__c,
                    MBE_Profile__r.distribution_Country__c,
                    MBE_Profile__r.AS_DiversityType__c,
                    MBE_Profile__r.Ethnicity__c,
                    MBE_Profile__r.Event_Organizer_Id__c,
                    MBE_Profile__r.Exceptional_Key_Words__c,
                    MBE_Profile__r.Exhibitor_company_imageUrl__c,
                    MBE_Profile__r.AS_FaxNumber__c,
                    MBE_Profile__r.FaxNumber__c,
                    MBE_Profile__r.AS_Gender__c,
                    MBE_Profile__r.Geographical_Region__c,
                    MBE_Profile__r.GSA_Schedule__c,
                    MBE_Profile__r.AS_HomeAddress1__c,
                    MBE_Profile__r.AS_HomeAddress2__c,
                    MBE_Profile__r.AS_HomeCity__c,
                    MBE_Profile__r.As_Home_Country__c,
                    MBE_Profile__r.AS_HomePoBox__c,
                    MBE_Profile__r.As_Home_State__c,
                    MBE_Profile__r.AS_HomeZip__c,
                    MBE_Profile__r.AS_ImageUrl__c,
                    MBE_Profile__r.Key_Words__c,
                    MBE_Profile__r.Manufactures_Country__c,
                    MBE_Profile__r.As_NAICSCode_1__c,
                    MBE_Profile__r.As_NAICSCode_2__c,
                    MBE_Profile__r.As_NAICSCode_3__c,
                    MBE_Profile__r.As_NAICSCode_4__c,
                    MBE_Profile__r.As_NAICSCode_5__c,
                    MBE_Profile__r.AS_NAICSCode7__c,
                    MBE_Profile__r.AS_NAICSCode8__c,
                    MBE_Profile__r.AS_NAICSCode9__c,
                    MBE_Profile__r.AS_NumberOfEmployees__c,
                    MBE_Profile__r.As_prefixNew__c,
                    MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                    MBE_Profile__r.References__c,
                    MBE_Profile__r.References2__c,
                    MBE_Profile__r.Revenue_Range__c,
                    MBE_Profile__r.Scope_of_Work__c,
                    MBE_Profile__r.Scope_of_Work2__c,
                    MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                    MBE_Profile__r.As_Shipping_States__c,
                    MBE_Profile__r.AS_ShippingAddress1__c,
                    MBE_Profile__r.AS_ShippingAddress2__c,
                    MBE_Profile__r.AS_ShippingCity__c,
                    MBE_Profile__r.As_Shipping_Country__c,
                    MBE_Profile__r.AS_ShippingPhone__c,
                    MBE_Profile__r.AS_ShippingPoBox__c,
                    MBE_Profile__r.AS_ShippingState__c,
                    MBE_Profile__r.AS_shippingzip_c__c,
                    MBE_Profile__r.AS_ShippingZipcode__c,
                    MBE_Profile__r.As_SuffixNew__c,*/
                    MBE_Profile__r.AS_Title__c,
                    MBE_Profile__r.Total_Name__c,
                    MBE_Profile__r.AS_WebsiteUrl__c,
                    MBE_Profile__r.AS_Work_Country__c,
                    MBE_Profile__r.AS_Work_States__c,
                    MBE_Profile__r.AS_WorkAddress1__c,
                    MBE_Profile__r.AS_WorkAddress2__c,
                    MBE_Profile__r.AS_WorkCity__c,
                    MBE_Profile__r.AS_WorkPhone__c,
                    MBE_Profile__r.AS_WorkZip__c,
                    MBE_Profile__r.AS_WorkZipCode__c,
                    MBE_Profile__r.Year_in_business__c
                    from Event_Attendee_Mapping__c 
                    Where EV_id__r.id =:eventSelected 
                    //AND AS_id__r.AS_Secondary_Email__c!= NULL
                    AND Boothleads_Profile__c='Attendee'
                    AND IsMatchMakingAttendee__c=TRUE
                    AND id=:email2
                    ];
               system.debug('55555555555555555555555555'+sendemailupembe);
        LIST<String> ccAddresses = new LIST<String>();  
             
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    EmailTemplate template= new EmailTemplate();
   if(sendemailupembe.EV_id__r.EV_Title__c=='Connecticut Business Matchmaker 2015'){
   template = [select Id,Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Request for Participation Email']; 
    }else{
    template = [select Id,Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Request for Participation Email3']; 
    }   
    mail.setSubject('Sign up Reminder for '+sendemailupembe.EV_id__r.EV_Title__c  + ' Event! ');
    //mail.setReplyTo(new String[]{sendemailupe.EV_id__r.OrganizerId__c});
    mail.setToAddresses(new String[]{sendemailupembe.AS_id__r.AS_Secondary_Email__c});
    mail.setccAddresses(new String[]{sendemailupembe.EV_id__r.OrganizerId__c});
    //mail.setToAddresses(new String[]{sendemailupembe.Attendee_Summary__r.AS_Email__c});
    system.debug('ccccccccccccc'+mail);
    //ccAddresses.add('durga@globalnest.com');
    //mail.setSenderDisplayName('Jerilynn Clarke');
    //User us=[select id,name,Username from User];
    
    String ReplaceContactName = template.HtmlValue; 
        system.debug('gggggggggggg'+ReplaceContactName);
      string replacedname;
    
      replacedname =ReplaceContactName.Replace('{!Name}',sendemailupembe.AS_id__r.AS_FirstName__c );
              system.debug('AAAAAAAAAAAAA'+replacedname);
              
        /* string frd;  
              try{
              if(sendemailupe.EV_id__r.EV_EventLogo__c!=null){
                 frd ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id='+sendemailupembe.EV_id__r.EV_EventLogo__c+'&oid=00DF0000000BpyH';
              }else{
               frd ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id=015F0000002PvfM&oid=00DF0000000BpyH';
               }
               replacedname = replacedname.Replace('{!evelogo}',frd ); 
               system.debug('TTTTTTTTTT$$$$$$$$$$$$$$$$$$$$$'+sendemailupembe.EV_id__r.EV_EventLogo__c);
              }catch(exception rf){
             }   */
             
              
      
        replacedname = replacedname.Replace('{!EventName}',sendemailupembe.EV_id__r.EV_Title__c);
      system.debug('bbbbbbbbbbbbb'+replacedname);
     if(sendemailupembe.EV_id__r.EV_HistingAddr1__c!= NULL && sendemailupembe.EV_id__r.EV_HistingAddr1__c!=''){
      replacedname = replacedname.Replace('{!EventAdd1}',sendemailupembe.EV_id__r.EV_HistingAddr1__c);
      }else{
       replacedname = replacedname.Replace('{!EventAdd1}','');
      }
    
      if(sendemailupembe.EV_id__r.EV_EventLogo__c != null && sendemailupembe.EV_id__r.EV_EventLogo__c != '' ){
           
                    replacedname  = replacedname.Replace('{!evelogo}',sendemailupembe.EV_id__r.EV_EventLogo__c);
                    system.debug('AAAAAAAAAAAAAggggggggggggggggggg'+sendemailupembe.EV_id__r.EV_EventLogo__c);
                    }else{
                    replacedname = replacedname.Replace('{!evelogo}','');
                    }  
       
      
      if(sendemailupembe.EV_id__r.AS_HostingAddr2__c!= NULL && sendemailupembe.EV_id__r.AS_HostingAddr2__c!=''){
      
      replacedname = replacedname.Replace('{!EventAdd2}',sendemailupembe.EV_id__r.AS_HostingAddr2__c);
     
       }else{
       replacedname = replacedname.Replace('{!EventAdd2}','');
      }
      
      if(sendemailupembe.EV_id__r.AS_HostingCity__c!= NULL && sendemailupembe.EV_id__r.AS_HostingCity__c!=''){
      replacedname = replacedname.Replace('{!Eventcity}',sendemailupembe.EV_id__r.AS_HostingCity__c);
      system.debug('55555555555555555555'+replacedname);
       }
       else{
       replacedname = replacedname.Replace('{!Eventcity}','');
      }
      system.debug('44444444444444444444'+sendemailupembe.EV_id__r.AS_HostingCity__c);
      if(sendemailupembe.EV_id__r.EV_HostingStateNew__c!= NULL && sendemailupembe.EV_id__r.EV_HostingStateNew__c!=''){
      replacedname = replacedname.Replace('{!Eventstate}',sendemailupembe.EV_id__r.EV_HostingStateNew__c);
       }else{
       replacedname = replacedname.Replace('{!Eventstate}','');
      }
      
      if(sendemailupembe.EV_id__r.EV_HostingZipcode__c!= NULL && sendemailupembe.EV_id__r.EV_HostingZipcode__c!=''){
      replacedname = replacedname.Replace('{!Eventzip}',sendemailupembe.EV_id__r.EV_HostingZipcode__c);
       }else{
       replacedname = replacedname.Replace('{!Eventzip}','');
      }
      
      replacedname = replacedname.Replace('{!Eventdate}',string.valueOf(sendemailupembe.EV_id__r.MM_Start_Date__c));
      
     if(string.valueOf(sendemailupembe.EV_id__r.MM_Start_Time__c)!= NULL && string.valueOf(sendemailupembe.EV_id__r.MM_Start_Time__c)!=''){ 
     replacedname = replacedname.Replace('{!MMstartTime}',string.valueOf(sendemailupembe.EV_id__r.MM_Start_Time__c));
     }else{
       replacedname = replacedname.Replace('{!MMstartTime}','');
      }
      if(string.valueOf(sendemailupembe.EV_id__r.MM_End_Time__c)!= NULL && string.valueOf(sendemailupembe.EV_id__r.MM_End_Time__c)!=''){ 
      replacedname = replacedname.Replace('{!MMendtime}',string.valueOf(sendemailupembe.EV_id__r.MM_End_Time__c));
      }else{
       replacedname = replacedname.Replace('{!MMendtime}','');
      }
      
      replacedname = replacedname.Replace('{!EventAdminName}',string.valueOf(sendemailupembe.EV_id__r.Owner.name));
      /*replacedname = replacedname.Replace('{!EventAdminEmail}',string.valueOf(sendemailupembe.EventAdmin_Id__r.Email));
      replacedname = replacedname.Replace('{!EventAdminPhone1}',string.valueOf(sendemailupembe.EventAdmin_Id__r.MobilePhone));
      replacedname = replacedname.Replace('{!EventAdminPhone2}',string.valueOf(sendemailupembe.EventAdmin_Id__r.Phone));*/
      
      mail.sethtmlBody(replacedname);
    
     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
     
  }
   
   
  //-----------Signup chart ends ----------------------------------------
  //-------------Count of schedules by each MBE----------------------
    public LIST<Event_Attendee_Mapping__c> lieam{get;set;}
    public LIST<EventSchedule__c> lievsch{get;set;}
    public string eventsel{get;set;}
    public integer schcount{get;set;}
    public integer count{get;set;}
    public List<innercls> eamlist{get;set;}
    public boolean countofapp{get;set;}
    public list<innercls> eamcountlist {get ; set;}
   public void smallschedulescount()
   {
   try{
   eamcountlist = new list<innercls> ();
  // reporttitle = 'Report On Count of Appointments by Small Business';
   countofapp=true;
   
    lieam=[SELECT id,AS_id__r.AS_Email__c,AS_id__r.FullName__c,AS_id__r.AS_Company__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_Company__c,EV_id__r.Is_Webank_event__c 
                 /* MBE_Profile__r.AS_CellPhone__c,MBE_Profile__r.AS_Email__c,EV_id__r.Is_Webank_event__c,
                    MBE_Profile__r.Any_non_WBENC_awards_received__c,MBE_Profile__r.AS_Age__c,
                    MBE_Profile__r.AS_NAICSCode6__c,
                    MBE_Profile__r.AS_BirthDate__c,
                    MBE_Profile__r.AS_BlogUrl__c,
                    MBE_Profile__r.AS_BusinessDescription__c,
                    MBE_Profile__r.AS_BusinessDunsNumber__c,
                    MBE_Profile__r.AS_BusinessEstablishedDate__c,
                    MBE_Profile__r.AS_BusinessRevenue__c,
                    MBE_Profile__r.Business_Structure__c,
                    MBE_Profile__r.AS_BusinessTaxId__c,
                    MBE_Profile__r.AS_BusinessTaxId_c__c,
                    MBE_Profile__r.Business_type__c,
                    MBE_Profile__r.AS_CageCode__c,
                    MBE_Profile__r.Certificate_Processed_by_RPO__c,
                    MBE_Profile__r.Commodity_1__c,
                    MBE_Profile__r.Commodity_2__c,
                    MBE_Profile__r.Commodity_3__c,
                    MBE_Profile__r.Commodity_4__c,
                    MBE_Profile__r.Commodity_5__c,
                    MBE_Profile__r.Company_Certifications__c,
                    MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                    MBE_Profile__r.DBA__c,
                    MBE_Profile__r.distribution_Country__c,
                    MBE_Profile__r.AS_DiversityType__c,
                    MBE_Profile__r.Ethnicity__c,
                    MBE_Profile__r.Event_Organizer_Id__c,
                    MBE_Profile__r.Exceptional_Key_Words__c,
                    MBE_Profile__r.Exhibitor_company_imageUrl__c,
                    MBE_Profile__r.AS_FaxNumber__c,
                    MBE_Profile__r.FaxNumber__c,
                    MBE_Profile__r.AS_Gender__c,
                    MBE_Profile__r.Geographical_Region__c,
                    MBE_Profile__r.GSA_Schedule__c,
                    MBE_Profile__r.AS_HomeAddress1__c,
                    MBE_Profile__r.AS_HomeAddress2__c,
                    MBE_Profile__r.AS_HomeCity__c,
                    MBE_Profile__r.As_Home_Country__c,
                    MBE_Profile__r.AS_HomePoBox__c,
                    MBE_Profile__r.As_Home_State__c,
                    MBE_Profile__r.AS_HomeZip__c,
                    MBE_Profile__r.AS_ImageUrl__c,
                    MBE_Profile__r.Key_Words__c,
                    MBE_Profile__r.Manufactures_Country__c,
                    MBE_Profile__r.As_NAICSCode_1__c,
                    MBE_Profile__r.As_NAICSCode_2__c,
                    MBE_Profile__r.As_NAICSCode_3__c,
                    MBE_Profile__r.As_NAICSCode_4__c,
                    MBE_Profile__r.As_NAICSCode_5__c,
                    MBE_Profile__r.AS_NAICSCode7__c,
                    MBE_Profile__r.AS_NAICSCode8__c,
                    MBE_Profile__r.AS_NAICSCode9__c,
                    MBE_Profile__r.AS_NumberOfEmployees__c,
                    MBE_Profile__r.As_prefixNew__c,
                    MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                    MBE_Profile__r.References__c,
                    MBE_Profile__r.References2__c,
                    MBE_Profile__r.Revenue_Range__c,
                    MBE_Profile__r.Scope_of_Work__c,
                    MBE_Profile__r.Scope_of_Work2__c,
                    MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                    MBE_Profile__r.As_Shipping_States__c,
                    MBE_Profile__r.AS_ShippingAddress1__c,
                    MBE_Profile__r.AS_ShippingAddress2__c,
                    MBE_Profile__r.AS_ShippingCity__c,
                    MBE_Profile__r.As_Shipping_Country__c,
                    MBE_Profile__r.AS_ShippingPhone__c,
                    MBE_Profile__r.AS_ShippingPoBox__c,
                    MBE_Profile__r.AS_ShippingState__c,
                    MBE_Profile__r.AS_shippingzip_c__c,
                    MBE_Profile__r.AS_ShippingZipcode__c,
                    MBE_Profile__r.As_SuffixNew__c,
                    MBE_Profile__r.AS_Title__c,
                    MBE_Profile__r.Total_Name__c,
                    MBE_Profile__r.AS_WebsiteUrl__c,
                    MBE_Profile__r.AS_Work_Country__c,
                    MBE_Profile__r.AS_Work_States__c,
                    MBE_Profile__r.AS_WorkAddress1__c,
                    MBE_Profile__r.AS_WorkAddress2__c,
                    MBE_Profile__r.AS_WorkCity__c,
                    MBE_Profile__r.AS_WorkPhone__c,
                    MBE_Profile__r.AS_WorkZip__c,
                    MBE_Profile__r.AS_WorkZipCode__c,
                    MBE_Profile__r.Year_in_business__c*/
                    FROM Event_Attendee_Mapping__c 
                    Where EV_id__r.id =:eventSelected 
                    AND AS_id__r.AS_Email__c!= NULL
                    AND Boothleads_Profile__c='Attendee'
                    AND IsMatchMakingAttendee__c=TRUE];
    
    lievsch =[SELECT id,MM_To_EAM__r.id,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_Email__c
             /* MM_To_EAM__r.MBE_Profile__r.FullName__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c, EV_id__r.Is_Webank_event__c,
                    MM_To_EAM__r.MBE_Profile__r.Any_non_WBENC_awards_received__c,MM_To_EAM__r.MBE_Profile__r.AS_Age__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode6__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BirthDate__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BlogUrl__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BusinessDescription__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BusinessDunsNumber__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BusinessEstablishedDate__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BusinessRevenue__c,
                    MM_To_EAM__r.MBE_Profile__r.Business_Structure__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_BusinessTaxId_c__c,
                    MM_To_EAM__r.MBE_Profile__r.Business_type__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_CageCode__c,
                    MM_To_EAM__r.MBE_Profile__r.Certificate_Processed_by_RPO__c,
                    MM_To_EAM__r.MBE_Profile__r.Commodity_1__c,
                    MM_To_EAM__r.MBE_Profile__r.Commodity_2__c,
                    MM_To_EAM__r.MBE_Profile__r.Commodity_3__c,
                    MM_To_EAM__r.MBE_Profile__r.Commodity_4__c,
                    MM_To_EAM__r.MBE_Profile__r.Commodity_5__c,
                    MM_To_EAM__r.MBE_Profile__r.Company_Certifications__c,
                    MM_To_EAM__r.MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                    MM_To_EAM__r.MBE_Profile__r.DBA__c,
                    MM_To_EAM__r.MBE_Profile__r.distribution_Country__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_DiversityType__c,
                    MM_To_EAM__r.MBE_Profile__r.Ethnicity__c,
                    MM_To_EAM__r.MBE_Profile__r.Event_Organizer_Id__c,
                    MM_To_EAM__r.MBE_Profile__r.Exceptional_Key_Words__c,
                    MM_To_EAM__r.MBE_Profile__r.Exhibitor_company_imageUrl__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_FaxNumber__c,
                    MM_To_EAM__r.MBE_Profile__r.FaxNumber__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_Gender__c,
                    MM_To_EAM__r.MBE_Profile__r.Geographical_Region__c,
                    MM_To_EAM__r.MBE_Profile__r.GSA_Schedule__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress1__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_HomeAddress2__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_HomeCity__c,
                    MM_To_EAM__r.MBE_Profile__r.As_Home_Country__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_HomePoBox__c,
                    MM_To_EAM__r.MBE_Profile__r.As_Home_State__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_HomeZip__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ImageUrl__c,
                    MM_To_EAM__r.MBE_Profile__r.Key_Words__c,
                    MM_To_EAM__r.MBE_Profile__r.Manufactures_Country__c,
                    MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_1__c,
                    MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_2__c,
                    MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_3__c,
                    MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_4__c,
                    MM_To_EAM__r.MBE_Profile__r.As_NAICSCode_5__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode7__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode8__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_NAICSCode9__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_NumberOfEmployees__c,
                    MM_To_EAM__r.MBE_Profile__r.As_prefixNew__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                    MM_To_EAM__r.MBE_Profile__r.References__c,
                    MM_To_EAM__r.MBE_Profile__r.References2__c,
                    MM_To_EAM__r.MBE_Profile__r.Revenue_Range__c,
                    MM_To_EAM__r.MBE_Profile__r.Scope_of_Work__c,
                    MM_To_EAM__r.MBE_Profile__r.Scope_of_Work2__c,
                    MM_To_EAM__r.MBE_Profile__r.As_SecondaryBusinessCategory1__c,
                    MM_To_EAM__r.MBE_Profile__r.As_Shipping_States__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress1__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ShippingAddress2__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ShippingCity__c,
                    MM_To_EAM__r.MBE_Profile__r.As_Shipping_Country__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ShippingPhone__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ShippingPoBox__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ShippingState__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_shippingzip_c__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_ShippingZipcode__c,
                    MM_To_EAM__r.MBE_Profile__r.As_SuffixNew__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_Title__c,
                    MM_To_EAM__r.MBE_Profile__r.Total_Name__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_WebsiteUrl__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_Work_Country__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_Work_States__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress1__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_WorkAddress2__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_WorkCity__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_WorkPhone__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_WorkZip__c,
                    MM_To_EAM__r.MBE_Profile__r.AS_WorkZipCode__c,
                    MM_To_EAM__r.MBE_Profile__r.Year_in_business__c*/
                    FROM EventSchedule__c
                    WHERE MM_To_EAM__r.id IN :lieam
                    AND  EV_id__r.id =:eventSelected
                    AND MM_Slot_Status__c='Accepted'];   
   
   
   
   
    schcount=lievsch.size();              
    
    for(Event_Attendee_Mapping__c eam:lieam)  
    {
     count=0;
     for(EventSchedule__c es:lievsch)
     {
      if(es.MM_To_EAM__r.id==eam.id)
      {
      count++;
      }
     }
     
     //eamcountlist.add(new innercls (count,eam));
     if(selectedmbecountInformation=='All'){
         eamcountlist.add(new innercls (count,eam));
     }else if(selectedmbecountInformation=='Count with Appointments'){
         if(count!=0){
         eamcountlist.add(new innercls (count,eam));
         }
     }else if(selectedmbecountInformation=='Count without Appointments'){
         if(count == 0){
         eamcountlist.add(new innercls (count,eam));
         }
     }

    } 
    
        eamcountlist.sort();
        }catch(exception ex){}
   }
/*************************corporate count****************************************/
public list<crpinnerclss> crppcountlist {get;set;}
public boolean crpcountofapp{get;set;}
 public void corpschedulescount()
   {
   crppcountlist = new list<crpinnerclss> ();
  // reporttitle = 'Report On Count of Appointments by Small Business';
  crpcountofapp=true;
   list<User_Profile_Event__c> crplieam=new list<User_Profile_Event__c>();
    crplieam=[SELECT id,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.FullName__c,Attendee_Summary__r.AS_Company__c
           FROM User_Profile_Event__c
           Where EV_id__r.id =:eventSelected 
           AND Attendee_Summary__r.AS_Email__c!= NULL
           AND MAtchMakingProfile__c='Corporate'
           AND IsMatchMakingUser__c=TRUE];
    list<EventSchedule__c> crplievsch =new list<EventSchedule__c>();
    crplievsch =[SELECT id,MM_To_UPE__r.id 
              FROM EventSchedule__c
              WHERE MM_To_UPE__r.id IN :crplieam
              AND  EV_id__r.id =:eventSelected
               AND MM_Slot_Status__c='Accepted']; 
  
  integer  crpschcount=crplievsch.size();              
    
    for(User_Profile_Event__c upe:crplieam)  
    {
     count=0;
     for(EventSchedule__c cres:crplievsch)
     {
      if(cres.MM_To_UPE__r.id==upe.id)
      {
      count++;
      }
     }
     
     //crppcountlist.add(new crpinnerclss(count,upe));
     if(selectedcorpcountInformation=='All'){
         crppcountlist.add(new crpinnerclss(count,upe));
     }else if(selectedcorpcountInformation=='Count with Appointments'){
         if(count!=0){
         crppcountlist.add(new crpinnerclss(count,upe));
         }
     }else if(selectedcorpcountInformation=='Count without Appointments'){
         if(count == 0){
         crppcountlist.add(new crpinnerclss(count,upe));
         }
     }

    } 
    
       crppcountlist.sort(); 
   }



/***********************end*cout of corporates*****************************************/  
 /**********************count of corporate appointments export****************************/
 public list<crpinnerclss> expcrppcountlist {get;set;}

 public pagereference expcorpschedulescount()
   {
   expcrppcountlist = new list<crpinnerclss> ();
  // reporttitle = 'Report On Count of Appointments by Small Business';
  
   list<User_Profile_Event__c> expcrplieam=new list<User_Profile_Event__c>();
    expcrplieam=[SELECT id,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.FullName__c,Attendee_Summary__r.AS_Company__c
           FROM User_Profile_Event__c
           Where EV_id__r.id =:eventSelected 
           AND Attendee_Summary__r.AS_Email__c!= NULL
           AND MAtchMakingProfile__c='Corporate'
           AND IsMatchMakingUser__c=TRUE];
    list<EventSchedule__c> expcrplievsch =new list<EventSchedule__c>();
    expcrplievsch =[SELECT id,MM_To_UPE__r.id 
              FROM EventSchedule__c
              WHERE MM_To_UPE__r.id IN :expcrplieam
              AND  EV_id__r.id =:eventSelected
               AND MM_Slot_Status__c='Accepted']; 
     
  integer  expcrpschcount=expcrplievsch.size();              
    
    for(User_Profile_Event__c upe:expcrplieam)  
    {
     count=0;
     for(EventSchedule__c cres:expcrplievsch)
     {
      if(cres.MM_To_UPE__r.id==upe.id)
      {
      count++;
      }
     }
    
     //expcrppcountlist.add(new crpinnerclss(count,upe));
     if(selectedcorpcountInformation=='All'){
         expcrppcountlist.add(new crpinnerclss(count,upe));
     }else if(selectedcorpcountInformation=='Count with Appointments'){
         if(count!=0){
         expcrppcountlist.add(new crpinnerclss(count,upe));
         }
     }else if(selectedcorpcountInformation=='Count without Appointments'){
         if(count == 0){
         expcrppcountlist.add(new crpinnerclss(count,upe));
         }
     }

    } 
    expcrppcountlist.sort(); 
    pagereference pg= page.corporatecountofappexport;
    return pg;
        
   }


 /*****************************end count of corporates export**********************************************************/
 /****************************count of corporates pint***********************************************************/
 public list<crpinnerclss> prntcrppcountlist {get;set;}

 public pagereference prntcorpschedulescount()
   {
   prntcrppcountlist = new list<crpinnerclss> ();
  // reporttitle = 'Report On Count of Appointments by Small Business';
  
   list<User_Profile_Event__c> prntcrplieam=new list<User_Profile_Event__c>();
    prntcrplieam=[SELECT id,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.FullName__c,Attendee_Summary__r.AS_Company__c
           FROM User_Profile_Event__c
           Where EV_id__r.id =:eventSelected 
           AND Attendee_Summary__r.AS_Email__c!= NULL
           AND MAtchMakingProfile__c='Corporate'
           AND IsMatchMakingUser__c=TRUE];
    list<EventSchedule__c> prntcrplievsch =new list<EventSchedule__c>();
    prntcrplievsch =[SELECT id,MM_To_UPE__r.id 
              FROM EventSchedule__c
              WHERE MM_To_UPE__r.id IN :prntcrplieam
              AND  EV_id__r.id =:eventSelected
               AND MM_Slot_Status__c='Accepted']; 
    
  integer  prntcrpschcount=prntcrplievsch.size();              
    
    for(User_Profile_Event__c upe:prntcrplieam)  
    {
     count=0;
     for(EventSchedule__c cres:prntcrplievsch)
     {
      if(cres.MM_To_UPE__r.id==upe.id)
      {
      count++;
      }
     }
    
     //prntcrppcountlist.add(new crpinnerclss(count,upe));
     if(selectedcorpcountInformation=='All'){
         prntcrppcountlist.add(new crpinnerclss(count,upe));
     }else if(selectedcorpcountInformation=='Count with Appointments'){
         if(count!=0){
         prntcrppcountlist.add(new crpinnerclss(count,upe));
         }
     }else if(selectedcorpcountInformation=='Count without Appointments'){
         if(count == 0){
         prntcrppcountlist.add(new crpinnerclss(count,upe));
         }
     }
    } 
    prntcrppcountlist.sort(); 
    Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Corporate_Appointments.pdf');  
      eventDetailsInPrint(); 
    pagereference pg= page.corporatecountofappprint;
    return pg;
        
   }

 
 /*******************************end of count of corporates print***********************************************/
 //-------------Count of schedules by each MBE Start----------------------  
  public LIST<Event_Attendee_Mapping__c> expeam{get;set;}
  public LIST<EventSchedule__c> expevsch{get;set;}
  public LIST<EventSchedule__c> zn{get;set;}
  public LIST<LIST<EventSchedule__c>> expsch{get;set;}
  public list<innercls> eamcountlist1 {get ; set;}
  public integer count1{get;set;}
  
  public pagereference countappexpo()
  {
  try{
  eamcountlist1 = new list<innercls> ();
  expsch = new LIST<LIST<EventSchedule__c>>();
    lieam=[SELECT id,AS_id__r.AS_Email__c,AS_id__r.FullName__c,AS_id__r.AS_Company__c,EV_id__r.Is_Webank_event__c,MBE_Profile__r.AS_Email__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_Company__c
           FROM Event_Attendee_Mapping__c 
           Where EV_id__r.id =:eventSelected 
           AND AS_id__r.AS_Email__c!= NULL
           AND Boothleads_Profile__c='Attendee'
           AND IsMatchMakingAttendee__c=TRUE];
    
    lievsch =[SELECT id,MM_To_EAM__r.id,EV_id__r.Is_Webank_event__c 
              FROM EventSchedule__c
              WHERE MM_To_EAM__r.id IN :lieam 
               AND MM_Slot_Status__c='Accepted']; 
               
     
   
    schcount=lievsch.size();              
    
    for(Event_Attendee_Mapping__c eam:lieam)  
    {
     count=0;
     for(EventSchedule__c es:lievsch)
     {
      if(es.MM_To_EAM__r.id==eam.id)
      {
      count++;
      }
     }
    
     //eamcountlist1.add(new innercls (count,eam));
     if(selectedmbecountInformation=='All'){
         eamcountlist1.add(new innercls (count,eam));
     }else if(selectedmbecountInformation=='Count with Appointments'){
         if(count!=0){
         eamcountlist1.add(new innercls (count,eam));
         }
     }else if(selectedmbecountInformation=='Count without Appointments'){
         if(count == 0){
         eamcountlist1.add(new innercls (count,eam));
         }
     }

    } 
    eamcountlist1.sort(); 
     }catch(exception ex){}
    pagereference pg= page.countofappexport;
    return pg;
   
    }
  
  public list<innercls> eamcountlist2 {get ; set;}
  public pagereference countappprint()
  {
  eamcountlist2= new list<innercls> ();
  expsch = new LIST<LIST<EventSchedule__c>>();
    lieam=[SELECT id,AS_id__r.AS_Email__c,AS_id__r.FullName__c,AS_id__r.AS_Company__c,EV_id__r.Is_Webank_event__c,MBE_Profile__r.AS_Email__c,MBE_Profile__r.FullName__c,MBE_Profile__r.AS_Company__c
           FROM Event_Attendee_Mapping__c 
           Where EV_id__r.id =:eventSelected 
           AND AS_id__r.AS_Email__c!= NULL
           AND Boothleads_Profile__c='Attendee'
           AND IsMatchMakingAttendee__c=TRUE];
    
    lievsch =[SELECT id,MM_To_EAM__r.id, EV_id__r.Is_Webank_event__c
              FROM EventSchedule__c
              WHERE MM_To_EAM__r.id IN :lieam 
              AND MM_Slot_Status__c='Accepted'];   
              
   
   
    schcount=lievsch.size();              
    
    for(Event_Attendee_Mapping__c eam:lieam)  
    {
     count=0;
     for(EventSchedule__c es:lievsch)
     {
      if(es.MM_To_EAM__r.id==eam.id)
      {
      count++;
      }
     }
     
     //eamcountlist2.add(new innercls (count,eam));
     if(selectedmbecountInformation=='All'){
         eamcountlist2.add(new innercls (count,eam));
     }else if(selectedmbecountInformation=='Count with Appointments'){
         if(count!=0){
         eamcountlist2.add(new innercls (count,eam));
         }
     }else if(selectedmbecountInformation=='Count without Appointments'){
         if(count == 0){
         eamcountlist2.add(new innercls (count,eam));
         }
     }
    } 
    eamcountlist2.sort(); 
     Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Small_Business_Appointments.pdf');  
      eventDetailsInPrint();              
    pagereference pg= page.countappprint;
    return pg;
    }
  
  public class innercls implements Comparable
  {
     public Event_Attendee_Mapping__c inneam{get;set;}
     public integer i{get;set;}
     public innercls(integer n,Event_Attendee_Mapping__c kl)
     {
         i=n;
         this.inneam=kl;
     }
     
     /**************sort*******************/   
      public integer compareTo(Object ObjToCompare) {
             
            innercls compareTomember = (innercls)ObjToCompare;
            
            Integer returnValue = 0;
            if (i < compareTomember.i) {
                     returnValue = 1;
            } else if (i > compareTomember.i) {
                     returnValue = -1;
            }
                 return returnValue;       
         
        }
   /********************************/  
     
  }  
  
  //-------------Count of schedules by each MBE end---------------------- 
  //----------------Corporates Sign Up start-------------------------------------
  public List<innclsc> corpupelist{get;set;}
   public Event__c eve {get;set;}
   public boolean corpsignupreport {get;set;}
   public Integer corpSignups{get; set;}
   public Integer corpNotSignups{get; set;}
  
  public void signupscorp()
   {
   corpsignupreport =true;
   reporttitle = 'Report On Corporates Signups';
     corpupelist =new List<innclsc >();
    integer h =1;
    
    LIST<AggregateResult> signUpAggcorp= new LIST<AggregateResult> ();
    signUpAggcorp=[SELECT COUNT(ID) c 
                   FROM User_Profile_Event__c 
                   WHERE EV_id__r.id =:eventSelected AND 
                   MAtchMakingProfile__c='Corporate' AND 
                  IsMatchMakingUser__c=TRUE  AND 
                   EV_id__r.Is_MatchMaking_Event__c=TRUE AND
                   User_id__r.isSignup__c =: TRUE];
              
    for(Aggregateresult agg: signUpAggcorp){
        if(Integer.valueOf(agg.get('c')) != 0){
            corpSignups= Integer.valueOf(agg.get('c'));
            system.debug('SSSSSSSSSSSSSSSSSSSSSSSSSSS'+corpSignups);
        }else{
            corpSignups=0;
        }
    
    }     
    
    LIST<AggregateResult> notSignUpAggcorp= new LIST<AggregateResult> ();
    notSignUpAggcorp=[SELECT COUNT(ID) c 
               FROM User_Profile_Event__c 
              WHERE EV_id__r.id =:eventSelected AND 
              IsMatchMakingUser__c=TRUE  AND
              MAtchMakingProfile__c='Corporate' AND 
              EV_id__r.Is_MatchMaking_Event__c=TRUE AND
              User_id__r.isSignup__c =: FALSE];
              
    for(Aggregateresult agg: notSignUpAggcorp){
        if(Integer.valueOf(agg.get('c')) != 0){
            corpNotSignups= Integer.valueOf(agg.get('c'));
             system.debug('NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN'+corpNotSignups);
        }else{
            corpNotSignups=0;
        }
    
    }
   
              
    for(User_Profile_Event__c uyc: [Select User_id__r.lastloginDate,User_id__r.Password__c,id,User_id__r.Name,User_id__r.Email, User_id__r.isSignup__c,User_id__r.SIgnup_Date__c,Attendee_Summary__r.AS_Company__c, Attendee_Summary__r.AS_WorkPhone__c,User_id__r.Companyphone__c ,LastmodifiedDate
               from User_Profile_Event__c   
               where EV_id__r.id =:eventSelected 
               AND MAtchMakingProfile__c='Corporate'               
               AND EV_id__r.Is_MatchMaking_Event__c=TRUE
               AND IsMatchMakingUser__c=TRUE
               ORDER BY User_id__r.isSignup__c DESC  , User_id__r.SIgnup_Date__c NULLS LAST]){
           
               //corpupelist.add(new innclsc (h,uyc));
               //h++;
               
               if(selectedcorpsignupInformation=='All'){
                   corpupelist.add(new innclsc (h,uyc));
                   h++;
               }else if(selectedcorpsignupInformation=='True'){
                   if(uyc.User_id__r.isSignup__c == true){
                       corpupelist.add(new innclsc (h,uyc));
                       h++;
                   }
               }else if(selectedcorpsignupInformation=='False'){
                   if(uyc.User_id__r.isSignup__c == false){
                       corpupelist.add(new innclsc (h,uyc));
                       h++;
                   }
               }
               
               
              }
               
   }  
       public class innclsc {
     public User_Profile_Event__c up{get;set;}
     public integer i{get;set;}
     public innclsc(integer f,User_Profile_Event__c hg){
     this.i=f;
     this.up=hg;
     }
    }  
  /**************inner class for corporate count*************/
   public class crpinnerclss implements Comparable{
     public User_Profile_Event__c up{get;set;}
     public integer i{get;set;}
     public crpinnerclss(integer f,User_Profile_Event__c hg){
     i=f;
     up=hg;
     }
  /**************sort*******************/   
      public integer compareTo(Object ObjToCompare) {
             
            crpinnerclss  compareTomember = (crpinnerclss)ObjToCompare;
            
            Integer returnValue = 0;
            if (i < compareTomember.i) {
                     returnValue = 1;
            } else if (i > compareTomember.i) {
                     returnValue = -1;
            }
                 return returnValue;       
         
        }
   /********************************/  
  
    }  
  /***************************************************/
  public LIST<LIST<User_Profile_Event__c>> corpexpo{get;set;} 
     public LIST<User_Profile_Event__c> expoc{get;set;} 
     public  LIST<User_Profile_Event__c> dn{get;set;}

  public pagereference exportcorps(){
     corpexpo = new LIST<LIST<User_Profile_Event__c>>();
     expoc=[Select User_id__r.Password__c,id,User_id__r.Name,User_id__r.LastLoginDate,User_id__r.Email, User_id__r.isSignup__c,User_id__r.SIgnup_Date__c,Attendee_Summary__r.AS_Company__c,Attendee_Summary__r.AS_WorkPhone__c,User_id__r.Companyphone__c,LastmodifiedDate
               from User_Profile_Event__c   
               where EV_id__r.id =:eventSelected 
               AND MAtchMakingProfile__c='Corporate'
               AND IsMatchMakingUser__c=TRUE
               AND EV_id__r.Is_MatchMaking_Event__c=TRUE
               ORDER BY User_id__r.isSignup__c DESC  , User_id__r.SIgnup_Date__c NULLS LAST];
    
      dn= new LIST<User_Profile_Event__c>();
      
      for(User_Profile_Event__c u: expoc)
      {
      if(u.Attendee_Summary__r.AS_Company__c != null || u.Attendee_Summary__r.AS_Company__c != null){
                   if(u.Attendee_Summary__r.AS_Company__c.contains(',')){
                    u.Attendee_Summary__r.AS_Company__c = escape(u.Attendee_Summary__r.AS_Company__c);}
                 }
      
          
          if(selectedcorpsignupInformation=='All'){
                   dn.add(u);
               }else if(selectedcorpsignupInformation=='True'){
                   if(u.User_id__r.isSignup__c == true){
                       dn.add(u);
                   }
               }else if(selectedcorpsignupInformation=='False'){
                   if(u.User_id__r.isSignup__c == false){
                      dn.add(u);
                   }
               }
      }
      corpexpo.add(dn);
      pagereference pg =page.Exportcorpsignups;
     return pg;
    }
    
   public pagereference printcorpsignup()
   {
    expoc= new LIST<User_Profile_Event__c>();
    LIST<User_Profile_Event__c> expoc1= new LIST<User_Profile_Event__c>();
    LIST<User_Profile_Event__c> expoc2= new LIST<User_Profile_Event__c>();
    expoc=[Select User_id__r.Password__c,id,User_id__r.Name,User_id__r.Email, User_id__r.isSignup__c,User_id__r.SIgnup_Date__c,Attendee_Summary__r.AS_Company__c, Attendee_Summary__r.AS_WorkPhone__c, User_id__r.Companyphone__c ,LastmodifiedDate
               from User_Profile_Event__c   
               where EV_id__r.id =:eventSelected
               AND MAtchMakingProfile__c='Corporate'
               AND IsMatchMakingUser__c=TRUE
               AND EV_id__r.Is_MatchMaking_Event__c=TRUE
               ORDER BY User_id__r.isSignup__c DESC  , User_id__r.SIgnup_Date__c NULLS LAST];
     Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Corporates_Signups.pdf');                 
  eventDetailsInPrint();
  
      if(selectedcorpsignupInformation!='All'){
          for(User_Profile_Event__c u:expoc){
              if(u.User_id__r.isSignup__c ==true){
                  expoc1.add(u);
              }else if(u.User_id__r.isSignup__c==false){
                  expoc2.add(u);
              }
          }   
             if(selectedcorpsignupInformation=='True'){
                 expoc = expoc1;
             }else if(selectedcorpsignupInformation=='False'){
                 expoc = expoc2;
             }
      }
  pagereference pg =page.printcorpsignups;
     return pg;
   } 
  
  
  public string email{get;set;}
  public User_Profile_Event__c sendemailupe{get;set;}
  public void sendemail()
  {
  sendemailupe=[Select User_id__r.Password__c,id,User_id__r.Name,User_id__r.Email, User_id__r.isSignup__c,Attendee_Summary__r.AS_Company__c,EV_id__r.OrganizerId__c, User_id__r.Companyphone__c ,LastmodifiedDate,EV_id__r.EV_Title__c,
               EV_id__r.EV_HistingAddr1__c,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingState__c,EV_id__r.EV_HostingZipcode__c,EV_id__r.EV_EventLogo__c,
               EV_id__r.MM_Start_Date__c,EV_id__r.MM_Start_Time__c,EV_id__r.EV_HostingStateNew__c,EV_id__r.MM_End_Time__c,EventAdmin_Id__r.Name,EventAdmin_Id__r.Email,EventAdmin_Id__r.MobilePhone,EventAdmin_Id__r.Phone
               from User_Profile_Event__c   
               where EV_id__r.id =:eventSelected
               AND id=:email
               AND MAtchMakingProfile__c='Corporate'
               AND IsMatchMakingUser__c=TRUE
               AND EV_id__r.Is_MatchMaking_Event__c=TRUE
               ORDER BY User_id__r.isSignup__c DESC , LastmodifiedDate];
               
    LIST<String> ccAddresses = new LIST<String>();       
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    EmailTemplate template= new EmailTemplate();
    if(sendemailupe.EV_id__r.EV_Title__c=='Connecticut Business Matchmaker 2015'){
    template = [select Id,Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Request for Participation Email']; 
    }else{
    template = [select Id,Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Request for Participation Email3']; 
    }  
    mail.setSubject('Sign up Reminder for '+sendemailupe.EV_id__r.EV_Title__c  + ' Event! ');
    //mail.setReplyTo(new String[]{sendemailupe.EV_id__r.OrganizerId__c});
    mail.setToAddresses(new String[]{sendemailupe.User_id__r.Email});
    //mail.setccAddresses(new String[]{sendemailupe.EV_id__r.OrganizerId__c});
    //mail.setToAddresses(new String[]{sendemailupe.Attendee_Summary__r.AS_Email__c});
    system.debug('ccccccccccccc'+mail);
   // ccAddresses.add('durga@globalnest.com');
    //mail.setSenderDisplayName('Jerilynn Clarke');
    //User us=[select id,name,Username from User];
    
    String ReplaceContactName = template.HtmlValue; 
        system.debug('gggggggggggg'+ReplaceContactName);
      string replacedname;
      
     /* string frd;  
              try{
              if(sendemailupe.EV_id__r.EV_EventLogo__c!=null){
                 frd ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id='+sendemailupe.EV_id__r.EV_EventLogo__c+'&oid=00DF0000000BpyH';
              }else{
               frd ='https://c.na10.content.force.com/servlet/servlet.ImageServer?id=015F0000002PvfM&oid=00DF0000000BpyH';
               }
               replacedname = replacedname.Replace('{!evelogo}',frd ); 
               system.debug('TTTTTTTTTT$$$$$$$$$$$$$$$$$$$$$'+sendemailupe.EV_id__r.EV_EventLogo__c);
              }catch(exception rf){
             }*/
      // replacedname='';
           
      replacedname =ReplaceContactName.Replace('{!Name}',sendemailupe.User_id__r.Name );
              system.debug('AAAAAAAAAAAAA'+replacedname);
      try{
      replacedname = replacedname.Replace('{!EventName}',sendemailupe.EV_id__r.EV_Title__c);
      system.debug('bbbbbbbbbbbbb'+replacedname);
      
        if(sendemailupe.EV_id__r.EV_EventLogo__c != null && sendemailupe.EV_id__r.EV_EventLogo__c != '' ){
           
                    replacedname  = replacedname.Replace('{!evelogo}',sendemailupe.EV_id__r.EV_EventLogo__c);
                    system.debug('AAAAAAAAAAAAAggggggggggggggggggg'+sendemailupe.EV_id__r.EV_EventLogo__c);
                    }else{
                    replacedname = replacedname.Replace('{!evelogo}','');
                    }  
      
     if(sendemailupe.EV_id__r.EV_HistingAddr1__c!= NULL && sendemailupe.EV_id__r.EV_HistingAddr1__c!=''){
      replacedname = replacedname.Replace('{!EventAdd1}',sendemailupe.EV_id__r.EV_HistingAddr1__c);
      }else{
       replacedname = replacedname.Replace('{!EventAdd1}','');
      }
      if(sendemailupe.EV_id__r.AS_HostingAddr2__c!= NULL && sendemailupe.EV_id__r.AS_HostingAddr2__c!=''){
      
      replacedname = replacedname.Replace('{!EventAdd2}',sendemailupe.EV_id__r.AS_HostingAddr2__c);
       }else{
       replacedname = replacedname.Replace('{!EventAdd2}','');
      }
      if(sendemailupe.EV_id__r.AS_HostingCity__c!= NULL && sendemailupe.EV_id__r.AS_HostingCity__c!=''){
      replacedname = replacedname.Replace('{!Eventcity}',sendemailupe.EV_id__r.AS_HostingCity__c);
       }else{
       replacedname = replacedname.Replace('{!Eventcity}','');
      }
      if(sendemailupe.EV_id__r.EV_HostingStateNew__c!= NULL && sendemailupe.EV_id__r.EV_HostingStateNew__c!=''){
      replacedname = replacedname.Replace('{!Eventstate}',sendemailupe.EV_id__r.EV_HostingStateNew__c);
       }else{
       replacedname = replacedname.Replace('{!Eventstate}','');
      }
      if(sendemailupe.EV_id__r.EV_HostingZipcode__c!= NULL && sendemailupe.EV_id__r.EV_HostingZipcode__c!=''){
      replacedname = replacedname.Replace('{!Eventzip}',sendemailupe.EV_id__r.EV_HostingZipcode__c);
       }else{
       replacedname = replacedname.Replace('{!Eventzip}','');
      }
      
      replacedname = replacedname.Replace('{!Eventdate}',string.valueOf(sendemailupe.EV_id__r.MM_Start_Date__c));
      
     if(string.valueOf(sendemailupe.EV_id__r.MM_Start_Time__c)!= NULL && string.valueOf(sendemailupe.EV_id__r.MM_Start_Time__c)!=''){ 
     replacedname = replacedname.Replace('{!MMstartTime}',string.valueOf(sendemailupe.EV_id__r.MM_Start_Time__c));
     }else{
       replacedname = replacedname.Replace('{!MMstartTime}','');
      }
      if(string.valueOf(sendemailupe.EV_id__r.MM_End_Time__c)!= NULL && string.valueOf(sendemailupe.EV_id__r.MM_End_Time__c)!=''){ 
      replacedname = replacedname.Replace('{!MMendtime}',string.valueOf(sendemailupe.EV_id__r.MM_End_Time__c));
      }else{
       replacedname = replacedname.Replace('{!MMendtime}','');
      }
      
      replacedname = replacedname.Replace('{!EventAdminName}',string.valueOf(sendemailupe.EventAdmin_Id__r.Name));
    /*  replacedname = replacedname.Replace('{!EventAdminEmail}',string.valueOf(sendemailupe.EventAdmin_Id__r.Email));
      replacedname = replacedname.Replace('{!EventAdminPhone1}',string.valueOf(sendemailupe.EventAdmin_Id__r.MobilePhone));
      replacedname = replacedname.Replace('{!EventAdminPhone2}',string.valueOf(sendemailupe.EventAdmin_Id__r.Phone));
      */
      mail.sethtmlBody(replacedname);
    }catch(exception ex){}
     Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
  }
  //----------------Corporates Sign Up Ends-------------------------------------EV_StartDate__c
  public void sendemailnoschedule(){
      EmailTemplate E = new EmailTemplate(); //For shelli
      E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'No schedules Template'];
      string emid = Apexpages.Currentpage().getparameters().get('eamid');
      system.debug(':::::::::::::::::::::::::EAMID:::::::::::::::'+emid);
      Event_Attendee_Mapping__c eamrec = [select id,AS_id__r.AS_Email__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,EV_id__r.EV_Title__c,EV_id__r.EV_StartDate__c,
                                                      EV_id__r.StartTime__c, EV_id__r.EV_HostingLocation__c,EV_id__r.EV_HostingState__c,EV_id__r.EV_HostingStateNew__c,
                                                      EV_id__r.EV_EventLogo__c,EV_id__r.EV_HostingZipcode__c,EV_id__r.AS_HostingCity__c,EV_id__r.EV_HostingCountryNew__c,EV_id__r.EV_EndDate__c,EV_id__r.EV_EndTime__c  From Event_Attendee_Mapping__c Where id =: emid];
  
      Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
      String[] toAddresses1 = new String[]{};
       List<Messaging.singleEmailMessage> emails = new List<Messaging.singleEmailMessage>();
      OrgWideEmailAddress[] owea = new OrgWideEmailAddress[]{};     
      email.subject = E.subject;
      toAddresses1.add(eamrec.AS_id__r.AS_Email__c); 
      email.setToAddresses(toAddresses1); 
      String ReplaceContactName1 = E.HtmlValue;
      ReplaceContactName1 = ReplaceContactName1.Replace('{!name}',eamrec.AS_id__r.AS_FirstName__c);
      ReplaceContactName1 = ReplaceContactName1.Replace('{!Email}',eamrec.AS_id__r.AS_Email__c);
      
      ReplaceContactName1 = ReplaceContactName1.Replace('{!eventname}',eamrec.EV_id__r.EV_Title__c);
      if(eamrec.EV_id__r.EV_EventLogo__c != null){
      ReplaceContactName1 = ReplaceContactName1.Replace('{!eventlogo}',eamrec.EV_id__r.EV_EventLogo__c);}
      ReplaceContactName1 = ReplaceContactName1.Replace('{!eventlocation}',eamrec.EV_id__r.EV_HostingLocation__c);
      ReplaceContactName1 = ReplaceContactName1.Replace('{!eventcity}',eamrec.EV_id__r.AS_HostingCity__c);
      ReplaceContactName1 = ReplaceContactName1.Replace('{!eventstate}',eamrec.EV_id__r.EV_HostingStateNew__c);
      ReplaceContactName1 = ReplaceContactName1.Replace('{!eventzip}',eamrec.EV_id__r.EV_HostingZipcode__c);

       email.setHtmlBody(ReplaceContactName1);
       emails.add(email);
       Messaging.sendEmail(emails);
  
  
  }
 

  }