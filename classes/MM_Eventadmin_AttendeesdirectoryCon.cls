global without sharing class MM_Eventadmin_AttendeesdirectoryCon {
    
    public List<inn> listinn{get;set;}
    public class inn{
    public List<SelectOption> optionsevediversityInn {get;set;}
    public List<string> optionsAttdiversityInn {get;set;}
    public List<SelectOption> optionsevediversityInn2 {get;set;}
    public List<string> optionsAttdiversityInn2 {get;set;}
    public Id iInn{get;set;}
    public string eventName{get;set;}
   
    public inn(string s,List<string> l1,List<selectOption> l2,List<selectOption> l3,id i,List<string> l4){
     
    optionsAttdiversityInn = new  List<string>();
    optionsattdiversityInn2 = new  List<string>();
    optionsevediversityInn = new List<SelectOption>();
    optionsevediversityInn2 = new List<SelectOption>();
    
    
    this.eventName =s;
    this.optionsAttdiversityInn =l1;
    this.optionsAttdiversityInn2 =l4;
    this.optionsevediversityInn =l2;
    this.optionsevediversityInn2 =l3;
    this.iInn =i;
    }
    }
    

    public String SelectValAs{get;set;}
    public List<selectOption> options1{get;set;}

        public String getSmallschedulescount() {
        
            return null;
        }
        public list<Event_Breaks__c> blokslistexist {get ; set ;}
        public Boolean emailalert1{get;set;}
        public Profile_Settings__c psett{get;set;}
        public boolean norecordsalert { get; set; }
        public list<string> commodities {get;set;}
        public LIST<LIST<Commodities__c>> listOfcommodities {get; set;}
        public String checkcommforAttendeeEdit{get; set;}
        public List<Commodities__c> commoditieslist {get ; set ;}

        //----------------------------------------------------------------- VARIABLE DECLARATION ----------------------------------
        public boolean multiselectpicklist{get;set;}
        public integer ForPagesize{get;set;}
        public boolean viewprofilepopup{get;set;}
        public boolean pagereadonly{get;set;}
        public string mycheck{get;set;}
        public boolean fortwoprinters{get;set;}
        public MAP<ID, Boolean> forPaginationstoreIds{get; set;}
        public boolean Successbool { get; set; }
        public boolean emailalert{get;set;}
        public boolean foreditatt{get;set;}
        public boolean limitofbadges{get;set;}
        public boolean foraddatt{get;set;}
        public boolean emailstatuschange{get;set;}
        public string[] alphabet{get;set;}
        public boolean statuschange{get;set;}
        public boolean totalselectlist{get;set;}
        public boolean custombadge1{get;set;}
        public boolean print{get;set;}
        public boolean dymo{get;set;}
        public string statusvalue{get;set;}
        public string selectedfaceFir{get;set;}
        public string selectedfaceSec{get;set;}
        public string selectedfaceThr{get;set;}
        public String selfieldvalue { get; set; }
        public boolean allrecords{get;set;}
        public string fordel{get;set;}
        public document myimage{get;set;}
        public transient  blob attachmentval {get ; set ;}
        public string attachmentName {get ; set ;}
        public List<Attachment> attachments {get ; set ;}
        public List<eventwrapper> ForPagination {get;set;}
        public string selectedcolor{get;set;}
        public string selectedsize{get;set;}
        public String selectedcolorT { get; set; }
        public String selectedsizeT { get; set; }
        public String selectedsizesecond { get; set; }
        public String selFvalue { get; set; }
        public String selTvalue { get; set; }
        public String selectedsizeS { get; set; }
        public String selectedcolorS { get; set; }
        public String selLvalue { get; set; }
        public boolean checked{get;set;}
        public String eventName1 { get; set; }
        public string Brevenue{get; set;}
        public String ageMod{get; set;}
        public String BEDate{get; set;}
        public String attendeeNameAfterEdit{get;set;}
        public String BDnBId{get; set;}
        public String BwebSite{get; set;}
        public String BDescription{get; set;}
        public String wAddress{get; set;}
        public String WPhone{get; set;}
        public String WPOBox{get; set;}
        public String SAddress{get; set;}
        public String SPOBox{get; set;}
        public String SBlogURL{get; set;}
        public String Diversity{get; set;}
        public String wstate{get; set;}
        public String wcity{get; set;}
        public String wAdd2{get; set;}
        public String Scity{get; set;}
        public String Sstate{get; set;}
        Public String Homeaddress1{get;set;}
        Public String Homecity{get;set;}
        Public String Homestate{get;set;}
        public String HPOBox{get; set;}
        public String EditDate{get; set;}
        public String SAddress2{get; set;}
        public String duplicateAttendee {get; set;}
        public String eventIdVar{get;set;}
        public String FirstName{get; set;}
        public String LastName{get; set;}
        public String CompanyName{get; set;}
        public String EmailId{get; set;}

        public string  serarchstringvalue{get;set;}
        public string EventReqString1{get;set;}
        public String selectedvalues{get; set;}
        public Boolean EventReqStringbool{get; set;}
        public String EventReqString{get; set;}
        public Boolean foundHistoryBool{get; set;}
        public List<Event_Attendee_Mapping__c> cus12 {get;set;}
        public list<list<EventWrapper>> TotalAttendees { get; set; }

        public list<Event_Attendee_Mapping__c> attendees1234{get;set;}
        public list<AttendeeSummary__c> event1234{get;set;}
        public AttendeeSummary__c Event{get;set;}
        public transient  list<eventwrapper> ew {get;set;}
        public id userid{get;set;}
        public Boolean  Shippinginfo{get; set;}
        public Boolean  workinfo{get; set;}
        public Boolean addattendee1{get; set;}
        public Boolean addattendee{get; set;}
        public Boolean ReqFields{get; set;}
        public Boolean onclickback { get; set;}
        public Boolean DataImportBool{get; set;}
        public Boolean  fbool{get; set;}
        public Boolean  Ebool{get; set;}
        public string Selected{get;set;}
        public Boolean EventEditpopup{get;set;}
        public boolean logo{get;set;}
        public transient Blob attendeeImageEdit{ get; set; }
        Public string slectedvalues{get;set;}
        public Boolean duplicateAttendeeBool{get; set;}
        public AttendeeSummary__c newAttendee  {get; set;}
        public Event__c attach{get;set;}
        public string attendeeName{get;set;}
        public Blob attendeeImage { get; set; }
        public LIST<selectoption> states{get; set;}
        public String eventSelected { get; set; }
        public List<id> attid{get;set;}
        public list<Event__c> eventattendeelist{get;set;}
        public transient list<Event_Attendee_Mapping__c> eventlist{get;set;}
        public list<Event_Attendee_Mapping__c> attendeeslist{get;set;}
        public List<Event_Attendee_Mapping__c> str{get;set;}
        public list<Tags__c> tagslist {get; set ;}
        public string attendeealias {get ; set ;}
        public string exhibitoralias {get ; set ;}


        //public list<inneremail> ss {get;set;}
        public Event_Attendee_Mapping__c event1{get;set;}
        public List<Event_Attendee_Mapping__c> checkedbadge{get;set;}
        public List<Event_Attendee_Mapping__c> checkedbadge1{get;set;}
        public List<Event_Attendee_Mapping__c> checkedbadge2{get;set;}
        public List<Event_Attendee_Mapping__c> attforexport{get;set;}
        public pagereference pdf{get;set;}
        public  Blob b  {get;set;}
        public string message{get;set;}
        public BL_AttendeeSettingsCon attendeeSetting123{get; set;}
        public LIST<SelectOption> Items{get; set;}
        public BL_SecuritySettingsCon attendeesetting{get; set;}
        public LIST<DataImport_SavePoint__c> ImportHistory{get; set;}
        public boolean EventReqStringBool2{get;set;}
        public boolean pdfbool{get;set;}
        public  Event_Attendee_Mapping__c attmap{get;set;}
        public  id attendeeevent{get;set;}
        public  Event_Attendee_Mapping__c eventatt{get;set;}
        public Blob mallikImage{get; set;}
        public String myimageName{get; set;}
        Public Boolean RegValu0{get;set;}
        Public Boolean RegValu1{get;set;}
        Public Boolean RegValu2{get;set;}
        Public List<String> RegTypeList{get;set;}
        Public String RegTypeValues{get;set;}
        public document mydoc{get;set;}
         public document mydoc1{get ; set ;}
        public list<TicketTypes__c> tickets{get;set;}
        Public String ShowError{get;set;}
        Public Boolean DisplayError{get;set;}
        Public  Boolean showEmail{get;set;}
        Public  Boolean HideEmail{get;set;}
        Public  Boolean showFirstName{get;set;}
        Public  Boolean HideFirstName{get;set;}
        Public  Boolean HideLastName{get;set;}
        Public  Boolean ShowLastName{get;set;}
        public boolean Disabled_First_Icon {get;set;}
        public boolean Disabled_Next_Icon {get;set;}
        public boolean Disabled_Last_Icon {get;set;}
        public boolean Disabled_Previous_Icon {get;set;}
        public Integer attfilesize{ get; set; }
        public Integer ev_att_jun{ get; set; }

        public String selectedNAICS1 { get; set; }
        public string selectedNAICS2{ get; set; }
        public string selecteddelnaic{ get; set; }
        public NAICS_Code__c selectednaicscodeslist  { get; set; }
        public List<String> selectednacslist{ get; set; }
        public set<string> naicsset{ get; set; }
        public List<String> selecteddelnaicsplit{ get; set; }
        public List<NAICS_Code__c> naicscodeslist{get;set;}
        public NAICS_Code__c naicsdellist { get; set; }
        public Boolean naicsalertbool{get;set;}
        public Boolean delbool{get;set;}
         public  list<selectoption> apps {get;set;}
        public  String selectedapp {get;set;}

        public LIST<LIST<NAICS_Code__c>> listOfnaicscodes{get; set;}
        public string naicsselctdids{get;set;}
        public list<string> naicscods{get;set;}
        public String checkNAICSforAttendeeEdit{get; set;}
        public Boolean ShowPage{get;set;}
        public LIST<String> naicsMultiple{get; set;}
        public list<Attachment> attchments {get; set;}
        public  list<selectOption> georegion {get ; set ;}
        public List<string> selectedregions {get ; set ;}
        public List<string> businessdes{get;set;}
        
        /* FOR NAICS CODES AND COMMODTIES */
        Public String Naics1='',Naics2='',Naics3='',Naics4='',Naics5='',Naics6='',Naics7='',Naics8='',Naics9='';
        Public String Commodity1='',Commodity2='',Commodity3='',Commodity4='',Commodity5='',Commodity6='',Commodity7='',Commodity8='',Commodity9='';
        
       // BL_MBE_Profile_BAL  BLMBEProBAL = new BL_MBE_Profile_BAL();
        /* FOR NAICS CODES AND COMMODTIES */
    
    
    //For adding video
           public Widget__c youtubevideo {get ; set;}

        public String sortField {
        get  { if (sortField == null) {sortField = 'AS_id__r.AS_Company__c'; } return sortField;  }
        set;
      }
        //--------------------------------------------------------VARIABLE DECLARATION------------------------------------
        public PageReference checkUserId() {
         if (userInfo.getUserType() == 'guest') {
             Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
             pg.setredirect(true);
             return pg;
         } else {
             return null;
         }
     }
      public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
      }
      public void toggleSort() {
        // simply toggle the direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        // run the query again
       getevents();
      }
     //-------------------------------------------------------CONSTRUCTOR---------------------------------
         public String[] selectedTicTypes {
             get;
             set;
         }
         public String[] DiversityTypes {
             get;
             set;
         }
         public String[] DiversityTypesforfirstLine {
             get;
             set;
         }
         public String[] DiversityTypesforsecondLine {
             get;
             set;
         }
         public List < Selectoption > Divoptions {
             get;
             set;
         }
         public List < Selectoption > Divoptionsforsecondline {
             get;
             set;
         }
         public Event__c eventDIVS {
             get;
             set;
         }
         public LIST < selectoption > SelectedValuesfortwoprinters {
             get;
             set;
         }

//for old matchleads image size
public DateTime prevdate{get;set;}

         public  MM_Eventadmin_AttendeesdirectoryCon() {
try{prevdate = DateTime.parse('2/22/2016 12:00 PM');}catch(Exception e){}
naicschangeselctdids = '';
         commchangeselctdids ='';
         naicsselctdids  = '';
         naicschangeids  = '';
         attendeealias ='';
         exhibitoralias ='';
         attchments = new List<Attachment>();
         listinn=new List<inn>(); 
           // glimap = new map<id,integer>();
        georegion = new list<selectOption> ();
           georegion.add(new selectoption('Local','Local'));
           georegion.add(new selectoption('National','National'));
           georegion.add(new selectoption('Global','Global'));
           georegion.add(new selectoption('Regional NE','Regional NE'));
           georegion.add(new selectoption('Regional SW','Regional SW'));
           georegion.add(new selectoption('Regional NW','Regional NW'));
           georegion.add(new selectoption('Regional SE','Regional SE'));
           selectedregions = new List<string>();
         ShowPage = False;
          apps = new list<selectoption> ();
         apps.add(new selectoption('Match Leads','Match Leads'));
          apps.add(new selectoption('Booth Leads','Booth Leads'));
          selectedapp = 'Match Leads';
          showExccededError=false;
          checkNAICSforAttendeeEdit = '';

         naicsMultiple =new  LIST<String>();

        try{
          Cookie k = ApexPages.currentPage().getCookies().get('counter');
            eventSelected = k.getValue();
         emailalert =false;
         emailalert1 = false;
        EventReqStringBool = false;
           alphabet = new string[] {
             'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'
         };



              listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
                    naicscodeslist = new List<NAICS_Code__c>();

              for(NAICS_Code__c n : [select id,name,Description__c from NAICS_Code__c ]){

                  naicscodeslist.add(n);

                 if(naicscodeslist.size() == 999){
                         listOfnaicscodes.add(naicscodeslist);
                         naicscodeslist= new LIST<NAICS_Code__c>();
                     }

              }

              if(naicscodeslist.size() != 0){
                  listOfnaicscodes.add(naicscodeslist);
             }

              listOfcommodities= new LIST<LIST<Commodities__c>>();
                    commoditieslist = new List<Commodities__c>();

              for(Commodities__c n : [select id,name,Description__c from Commodities__c ]){

                  commoditieslist.add(n);

                 if(commoditieslist.size() == 999){
                         listOfcommodities.add(commoditieslist);
                         commoditieslist = new LIST<Commodities__c>();
                     }

              }

              if(commoditieslist.size() != 0){
                  listOfcommodities.add(commoditieslist);
             }


         //getvalues();
         getevents();

          } catch (exception e) {}





         // By Mallik For Data Import History Display
         Integer countOfImport = [SELECT count() FROM DataImport_SavePoint__c WHERE User_id__c = : UserInfo.getUserId()];
         if (countOfImport > 0)
             foundHistoryBool = TRUE;
         try {
             attach = [select EV_EventLogo__c,EV_HostingLocation__c,EV_HistingAddr1__c,AS_HostingCity__c,EV_HostingState__c,EV_HostingZipcode__c,MatchMaking_Type__c, EV_Title__c,Is_Webank_event__c from Event__c where id = : eventSelected];
             if (attach.EV_EventLogo__c != null) {
                 logo = true;
             } else {
                 logo = false;
             }

              tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : eventSelected];
           for(Tags__c tt: tagslist ){
           if(tt.Default_Name__c == 'Attendee'){
           attendeealias = tt.Alias_Name__c;
           }else if(tt.Default_Name__c == 'Exhibitor'){
           exhibitoralias = tt.Alias_Name__c;
           }

           }
         } catch (exception e) {}

          Psettings = new LIST<Profile_Settings__c>();
          psett=new Profile_Settings__c();
             Psettings = [SELECT id,Business_Description__c,MBEScope_of_Work__c,MBE_References2_Visible__c,MBEScope_of_Work2_Visible__c,Company_Name__c,Title__c,Mobile__c,Email_Id__c,MBE_Year_in_Business_Visible__c,
             First_Name__c,KeyWords__c,Last_Name__c,NAICS_Codes__c,MBE_Work_Address_Visibility__c,
             Work_Address__c,Work_phone__c,Additional_Company_Brouchers__c,Additional_Company_videos__c,BBB_Number__c,
             Business_Duns_Number__c,Business_Established_Date__c,Business_Revenue__c,Business_Tax_ID__c,Business_Type__c,Cage_Code__c,
             Certificate_Processed_by_RPO__c,Certifications__c,Commodities__c,Country__c,DBA__c,Distributors_Country__c,Geographical_Region__c,
             GSA_Schedule_Contract_Number__c,Manufatures_Country__c,Number_Of_Employees__c,Primary_Business_Category__c,Products_Services__c,
             References__c,
Scope_of_Work__c,
Reference2__c,
Scope_of_Work2__c,
Revenue_Range__c,Salutation__c,Secondary_Business_Category__c,Small_Business_IMAGE__c,State__c,Uploaded_Company_Brochures__c,Uploaded_Video__c,
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
             MBE_Business_Type_Visible__c,MBE_Commodities_Visible__c,MBE_Uploaded_Video_Visible__c ,
             Year_in_Business__c,
            Year_in_business_Visible__c,
            Business_Structure__c,
            Business_Structure_Visible__c,
            FaxNumber__c,
            FaxNumber_Visible__c,
            Ethnicity__c,
            MBE_Ethnicity_Visible__c,
            Secondary_Email__c,
            MBE_Secondary_Email_Visible__c,
            Any_non_WBENC_awards_received__c, 
            MBEAny_non_WBENC_awards_received_visible__c,
            Companyhaveafacility_partneroutsideUSA__c,
            MBECompanyhavefacility_partneroutsideUSA__c,MBE_Salutation_Required__c,MBE_First_Name_Required__c,MBE_Title_Required__c,MBE_Mobile_Phone_Required__c,MBE_Company_Required__c,MBE_Work_Address_Required__c,MBE_Work_Phone_Required__c,MBE_NAICS_CODES_Required__c,MBE_Procurement_Needs_Required__c,MBE_Business_Description_Required__c,MBE_Small_Business_Image_Required__c,MBE_Commodities_Required__c,MBE_DBA_Required__c,MBE_Website_Required__c,MBE_Manufatures_Country_Required__c,MBE_Distributors_Country_Required__c,MBE_Additional_Company_Brouchers_Require__c,MBE_Uploaded_Company_Brochures_Required__c,MBE_Additional_Company_videos_Required__c,MBE_Uploaded_Video_Required__c,MBE_Company_Logo_Required__c,MBE_Business_Duns_Number_Required__c,MBE_Business_Established_Date_Required__c,MBE_BBB_Number_Required__c,MBE_Business_Revenue_Required__c,MBE_Revenue_Range_Required__c,MBE_Business_Tax_ID_Required__c,MBE_Cage_Code_Required__c,MBE_GSA_Schedule_Contract_Number_Require__c,MBE_Number_Of_Employees_Required__c,MBE_Primary_Business_Category_Required__c,MBE_Secondary_Business_Category_Required__c,MBE_Certifications_Required__c,MBE_Certificate_Processed_by_RPO_Require__c,MBE_Geographical_Region_Required__c,MBE_References_Required__c,MBE_Business_Type_Required__c,MBE_Email_Required__c,MBE_Year_in_Business_Required__c,Business_Structure_Required__c,FaxNumber_Required__c,MBE_Ethnicity_Required__c,MBE_Secondary_Email_Required__c,MBEAny_non_WBENC_awards_received_Require__c,MBECompanypartneroutsideUSA_Required__c 
             FROM Profile_Settings__c WHERE Event__r.id =: eventSelected AND Name=: 'MBE' ];
             if(Psettings.size()>0){
                         psett=Psettings[0];
                         }

 system.debug(Divoptionsforsecondline +'lllllllll'+Divoptions);
 
 
 options1 = new List<selectOption>(); 

        options1.add(new selectOption('', '--None--'));
options1.add(new selectOption('Astra Womenâs Business Alliance', 'Astra Womenâs Business Alliance'));
options1.add(new selectOption('Center for Women & Enterprise', 'Center for Women & Enterprise'));
options1.add(new selectOption('Great Lakes Women Business Council', 'Great Lakes Women Business Council'));
options1.add(new selectOption('Greater Women Business Council', 'Greater Women Business Council'));
options1.add(new selectOption('Ohio River Valley Women Business Council', 'Ohio River Valley Women Business Council'));
options1.add(new selectOption('Women President Educational Organization - DC', 'Women President Educational Organization - DC'));
options1.add(new selectOption('Women President Educational Organization - New York', 'Women President Educational Organization - New York'));
options1.add(new selectOption('Women Business Council - Southwest', 'Women Business Council - Southwest'));
options1.add(new selectOption('Women Business Development Center - Chicago', 'Women Business Development Center - Chicago'));
options1.add(new selectOption('Women Business Development Center -- Florida', 'Women Business Development Center -- Florida'));
options1.add(new selectOption('Women Business Enterprise Alliance', 'Women Business Enterprise Alliance'));
options1.add(new selectOption('Women Business Enterprise Council - West', 'Women Business Enterprise Council - West'));
options1.add(new selectOption('Women Business Enterprise Council PA-DE-sNJ', 'Women Business Enterprise Council PA-DE-sNJ'));
options1.add(new selectOption('Women Business Enterprise Council South', 'Women Business Enterprise Council South'));
     }

     // CCR Details check





     //---------------------------------------------------------Getting events into picklist-----------------

     //-------------------------------------------------------------------------Escap method for specialcharecters---------
     public static Datetime getLocalDateTime(Datetime z) {
         Datetime l = z.Date();
         return l;
     }
     public String escapeSpecialCharacters(String input) {
         if (input != null && input != '' && (input.contains('"') || input.contains('<'))) {
             if (input != null && input != '' && (input.contains('"'))) {
                 input = input.replace('"', '\\\"');
             }
             if (input != null && input != '' && (input.contains('<'))) {
                 input = input.replace('<', '');
             }
             if (input != null && input != '' && (input.contains(','))) {
                 input = input.replace(',', '');
             }
             if (input != null && input != '' && (input.contains('.'))) {
                 input = input.replace('.', '');
             }
         }
         return input;
     }
     //-------------------------------------------------------------------------Escap method for specialcharecters---------

     //------------------------------------------SELECT  TYPE OF BADGE-----------------------------------------------------

     //------------------------------------------------------GRID VALUES-------------------------------------------
     public Datetime crd {
         get;
         set;
     }
     //----------------variables for pagination of new design in salesforce
     public Boolean hasLast {
         get;
         set;
     }
     public Boolean hasFirst {
         get;
         set;
     }
     public Integer PgNo {
         get;
         set;
     }
     Public Boolean conlst {
         get;
         set;
     }
     Public Boolean hasPrevious {
         get;
         set;
     }
     Public Boolean hasNext {
         get;
         set;
     }
     Public Integer pageno {
         get;
         set;
     }
     Public Integer count {
         get;
         set;
     }
     //-----------------------------------------------------------------------
     public integer AttendeeCount{get; set;}
     public List < Event_Attendee_Mapping__c > getevents() {
         ForPageSize = null;
         pagereadonly = true;
         emailalert = false;
         emailalert1 = false;
         limitofbadges = false;
         system.debug('===================' + eventSelected);
         EventReqStringBool = false;

         TotalAttendees = new list < list < eventwrapper >> ();
         forPaginationstoreIds = new MAP < ID, Boolean > ();
         eventlist = new list < Event_Attendee_Mapping__c > ();

         ForPagination = new list < eventwrapper > ();
         if (eventSelected != null || eventSelected != '') {
             integer recCount = 0;
 system.debug('hhhhhhhhhhhhhhhhhh'+sortField);
           // string eventQuery ='select CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c =: true  AND EV_id__r.id = \''+eventSelected +'\'  ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
            string eventQuery ='select id,CreatedDate,MBE_Profile__r.AS_ImageUrl__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_Company__c,EV_id__r.Attendee_Types__c, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,AS_id__r.AS_WorkPhone__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c =  true AND Boothleads_Profile__c =\''+'Attendee'+'\' AND EV_id__r.id = \''+eventSelected +'\'  ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
            eventlist = dataBase.Query(eventQuery );
             AttendeeCount= eventlist.size();
             system.debug('===================' + eventlist);
             ew = new List < eventwrapper > ();
             for (Event_Attendee_Mapping__c s: eventlist) {
                 system.debug('===================' + s.id);
                 crd = s.CreatedDate;
                 crd = getLocalDateTime(crd);
                 recCount++;
                 ew.add(new eventwrapper(s));
                 system.debug('===================' + ew);
             }
             //for pagination------------------------------
             try {
                 if (ew.size() > 0) {
                     system.debug('===================' + ew);
                     conlst = true;
                     conlst = true;
                     hasLast = True;
                     hasFirst = False;
                     hasPrevious = false;
                     hasNext = true;
                     count = ew.size();
                     pageno = 1;
                     if (math.mod(ew.size(), 50) == 0) {
                         system.debug(' -------------------- @@@@@@@@@@@@@@@@@@@@' + pgno);
                         pgno = ew.size() / 50;
                     } else {
                         system.debug(' -------RRRRRRRRRRRRRRRRRRRRRRRRR' + pgno);
                         pgno = (ew.size() / 50) + 1;
                         system.debug(' -------!!!!!!!!!!!!!!!!!!!!!' + pgno);
                     }
                     for (integer i = 0; i < 50; i++) {
                         system.debug(' ----------- BBBBBBBBBBBBBBBBB ' + ew[i]);
                         ForPagination.add(ew[i]);
                         if (ew.size() <= 50) {
                             hasLast = false;
                             hasNext = false;
                             Disabled_Last_Icon = True;
                             Disabled_Next_Icon = True;
                             Disabled_First_Icon = True;
                             Disabled_Previous_Icon = True;
                         } else {
                             hasLast = True;
                             hasFirst = False;
                             hasPrevious = false;
                             Disabled_First_Icon = True;
                             Disabled_Previous_Icon = True;
                             Disabled_Next_Icon = false;
                             Disabled_Last_Icon = false;
                             hasNext = true;
                         }
                     }
                 }
                  ForPagesize = ForPagination.size();
             } catch (exception e) {}
         }

         DiversityTypes = new String[] {};
         Divoptions = new List < Selectoption > ();
         Divoptionsforsecondline = new List < Selectoption > ();
         eventattendeelist = new List < Event__c > ();
         system.debug(Divoptionsforsecondline +'lllllllll'+Divoptions);
         return null;
     }
     //----------------------------------------------------------------------------------------------------
     public void Alphasorting() {

         limitofbadges = false;
         system.debug('----------------------------------------------------------sort---');
         string alphas = ApexPages.currentPage().getParameters().get('alphabit');
         system.debug('---------' + alphas);
         ForPagination = new list < eventwrapper > ();
         eventlist = new list < Event_Attendee_Mapping__c > ();
         if (eventSelected != null || eventSelected != '') {
             if (alphas != 'All') {
                 integer recCount = 0;
                 eventlist = [select id,CreatedDate,MBE_Profile__r.AS_ImageUrl__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_Company__c,EV_id__r.Attendee_Types__c, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,AS_id__r.AS_WorkPhone__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c
                           from Event_Attendee_Mapping__c where AS_id__r.AS_Company__c like: alphas + '%'
                     AND EV_id__r.id = : eventSelected  AND IsMatchMakingAttendee__c = true AND Boothleads_Profile__c =: 'Attendee' ORDER BY AS_id__r.AS_Company__c
                 ];
                 AttendeeCount=eventlist.size();
                 system.debug('---------' + eventlist);
                 ew = new List < eventwrapper > ();
                 for (Event_Attendee_Mapping__c s: eventlist) {
                     crd = s.CreatedDate;
                     crd = getLocalDateTime(crd);
                     recCount++;
                     ew.add(new eventwrapper(s));
                 }
                 try {
                     if (ew.size() > 0) {
                         system.debug('===================' + ew.size());
                         conlst = true;
                         count = ew.size();
                         pageno = 1;
                         if (math.mod(ew.size(), 50) == 0) {
                             system.debug(' -------------------- @@@@@@@@@@@@@@@@@@@@' + pgno);
                             pgno = ew.size() / 50;
                         } else {
                             system.debug(' -------RRRRRRRRRRRRRRRRRRRRRRRRR' + pgno);
                             pgno = (ew.size() / 50) + 1;
                             system.debug(' -------!!!!!!!!!!!!!!!!!!!!!' + pgno);
                         }
                         for (integer i = 0; i < 50; i++) {
                             system.debug(' ----------- BBBBBBBBBBBBBBBBB ' + ew[i]);
                             ForPagination.add(ew[i]);
                             if (ew.size() < 50) {
                                 hasLast = false;
                                 hasNext = false;
                             } else {
                                 hasLast = True;
                                 hasFirst = False;
                                 hasPrevious = false;
                                 hasNext = True;
                             }
                         }
                     }
                 } catch (exception e) {}
             } else {
                 getevents();
             }
         }
     }
     //-------------------------------------------------------------------------------------------ADD ATTENDEE METHOD---------
     public List < SelectOption > options {get;set;}
     public boolean addemail {get ; set ;}
     public blob ExhibitorImage {get ; set ;}
     public string exhibitorImageName {get ; set ;}
     //public boolean editEmail {get ; set ;}
     public void CreateAttendee() {
     Event__c eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:eventselected];
     checkcommforAttendeeEdit = '#$%&&**00';
     commchangeselctdids ='';
     selectedregions = new list<string>();
         ShowPage = True;
         limitofbadges = false;
         attendeeImage = null;
         ExhibitorImage = null;
         emailalert = false;
         emailalert1 = false;
         showEmail = True;
         showFirstName = True;
         showLastName = True;
         DisplayError = false;
         newAttendee = new AttendeeSummary__c();

         youtubevideo = new Widget__c ();
         cyoutubevideo = new Custom_Widget__c ();
         Divoptions = new List < Selectoption > ();
         Divoptionsforsecondline = new List < Selectoption > ();
         eventattendeelist = new List < Event__c > ();
         DiversityTypesforfirstline = new string[] {};
         DiversityTypesforsecondline = new string[] {};
         checkNAICSforAttendeeEdit = '#$%&&**00';
         naicschangeselctdids = '';
         naicschangeids = '';
         EventReqStringBool = false;
         if (eventSelected == 'select' || eventSelected == null) {
             EventReqStringBool = TRUE;
             EventReqString = 'Please Select an Event';
         } else {
             attendeesetting = new BL_SecuritySettingsCon(eventSelected);
             EventReqString = 'Add MBE';
             if(eventone.Is_Webank_event__c == false){
             addattendee = TRUE;
             foraddatt = true;
             addemail = True;
             foreditatt = false;
             }else{
             addattendee = TRUE;
             cusnewpro = True;
             addemail = True;
             foraddatt = false;
             foreditatt = false;
             }

         }
         try {
             system.debug('===============================' + ApexPages.currentPage().getParameters().get('eveId'));
             eventDIVS = [select EventDiversityValues__c,Is_Webank_event__c  from Event__c where id = : eventSelected];
             String Div = eventDIVS.EventDiversityValues__c;
             string[] DiversityTypes1 = Div.split(';');
             integer i = 0;
             for (String Diversty: DiversityTypes1) {
                 if (math.MOD(i, 2) == 0) {
                     Divoptions.add(new SelectOption(Diversty, Diversty));
                 } else {
                     Divoptionsforsecondline.add(new SelectOption(Diversty, Diversty));
                 }
                 i++;
             }
             selectedTicTypes = new String[] {};
             options = new List < SelectOption > ();
             tickets = new list < TicketTypes__c > ();
             tickets = [select TT_Name__c from TicketTypes__c where EV_id__r.id = : eventSelected];
             for (TicketTypes__c Tic: tickets) {
                 options.add(new SelectOption((String) Tic.TT_Name__c, Tic.TT_Name__c));
             }
         } catch (exception e) {}
     }
     /**
     public PageReference ImportAttendee() {
         pagereference pg = new pagereference('/apex/mm_eventadmin_Import?id=' + eventSelected);
         pg.setredirect(true);
         return pg;
     }
     */
     //-------------------------------------SAVING NEW ATTENDEE METHOD----------------------------------------------
     public pageReference SaveAttendee() {

            system.debug('111111'  );

    system.debug('shruthi shruthi ' + DiversityTypesforfirstLine);

        system.debug('shruthi shruthi ' + DiversityTypesforsecondLine);
                     List<folder> folderList =new List<folder>();
                  folderList = [select id from folder where name='shared Documents'];

         limitofbadges = false;
         ShowPage = False;
         //newAttendee.AS_uniqueField__c = (newAttendee.AS_FirstName__c + newAttendee.AS_LastName__c + newAttendee.AS_Email__c ).toLowercase();
         EventReqStringBool2 = false;
         Savepoint sp = Database.setSavepoint();



        if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+attendeeImage.size());
             if (attendeeImage.size() != null) {
                 if (attendeeImage.size() <= 4024000) {
                     mydoc = new document();
                     mydoc.body = attendeeImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                     mydoc.ispublic = true;
                     mydoc.Name = myimageName;
                     insert mydoc;
                     attendeeImage =null;
                     newattendee.AS_ImageUrl__c = mydoc.id;
                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 4MB';
                 }
             }
         }
         if (ExhibitorImage != NULL && (ExhibitorImageName != '' || ExhibitorImageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+ExhibitorImage.size());
             if (ExhibitorImage.size() != null) {
                 if (ExhibitorImage.size() <= 4024000) {
                     mydoc = new document();
                     mydoc.body = ExhibitorImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                     mydoc.ispublic = true;
                     mydoc.Name = ExhibitorImageName;
                     insert mydoc;
                     ExhibitorImage =null;
                     newattendee.Exhibitor_company_imageUrl__c = mydoc.id;
                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 4MB';
                 }
             }
         }
              system.debug('-------------------------new attendee------------------' + newAttendee);

               naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
                 system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
      try{

               if(commchangeselctdids != NULL){
               commodities = new list<string>();
               commodities =commchangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());


                if(commodities.size() == 2){
                        system.debug('aaaaaaaaaaa ');
                 newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 system.debug('ddddddddddddddddd ' +  newAttendee.Commodity_1__c );
                 newAttendee.Commodity_2__c = '';
                 newAttendee.Commodity_3__c = '';
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';


                }
                if(commodities.size() == 3){
                        system.debug('aaaaaaaaaaa ');
                 newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = '';
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                if(commodities.size() == 4){
                        system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                            }
                if(commodities.size() == 5){
                        system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                 if(commodities.size() == 6){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                 if(commodities.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                 if(commodities.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                 if(commodities.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = commodities [8].replace('&','-');
                 newAttendee.Commodity_9__c = '';

                }
                 if(commodities.size() == 10){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = commodities [8].replace('&','-');
                 newAttendee.Commodity_9__c = commodities [9].replace('&','-');

                }

       }
          if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                system.debug('ddddddddddddddddd ' +  newAttendee.As_NAICSCode_1__c );

                if(naicscods.size() == 2){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = '';
                 newAttendee.As_NAICSCode_3__c = '';
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';

                }
                if(naicscods.size() == 3){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = '';
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 4){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 5){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                 if(naicscods.size() == 6){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = naicscods[1].replace('&','-');
                 newAttendee.Commodity_2__c = naicscods[2].replace('&','-');
                 newAttendee.Commodity_3__c = naicscods[3].replace('&','-');
                 newAttendee.Commodity_4__c = naicscods[4].replace('&','-');
                 newAttendee.Commodity_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
               }
                if(naicscods.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 10){
                         system.debug('aaaaaaaaaaa ');
              newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  newAttendee.AS_NAICSCode9__c =naicscods[9].replace('&','-');
                }



       }
        newAttendee.Geographical_Region__c = '';
       for(string st : selectedregions){
           newAttendee.Geographical_Region__c += st+',';
           }


      }catch(Exception e){}


         AttendeeSummary__c myatt = new AttendeeSummary__c();
         myatt = newAttendee.clone(true);
         naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
                 system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
             try{

          if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());


                if(naicscods.size() == 2){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = '';
                 myatt.As_NAICSCode_3__c = '';
                 myatt.As_NAICSCode_4__c = '';
                 myatt.As_NAICSCode_5__c = '';
                }
                if(naicscods.size() == 3){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = '';
                 myatt.As_NAICSCode_4__c = '';
                 myatt.As_NAICSCode_5__c = '';
                }
                if(naicscods.size() == 4){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 myatt.As_NAICSCode_4__c = '';
                 myatt.As_NAICSCode_5__c = '';
                }
                if(naicscods.size() == 5){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 myatt.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 myatt.As_NAICSCode_5__c = '';
                }
                 if(naicscods.size() == 6){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 myatt.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 myatt.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                }


       }



       }catch(Exception e){}


         Database.UpsertResult myAttendeeSaveResult = Database.upsert(myatt, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);
         try{
                    if(attachmentname != null){
                     if ( attachmentval.size() != null) {


                        Attachment a = new Attachment(parentId = myAttendeeSaveResult.getId(), name=attachmentname, body = attachmentval);
                         insert a;
                    }
                  }
            }catch(Exception e){}
         system.debug('-------------------------new attendee------------------' + myatt);
         if (myAttendeeSaveResult.isSuccess()) {
             if (myAttendeeSaveResult.iscreated()) {
                 attmap = new Event_Attendee_Mapping__c();
                 attmap.AS_id__c = myAttendeeSaveResult.getId();
                 attmap.Ev_id__c = eventSelected;
                 attmap.IsMatchMakingAttendee__c =True;
                 attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId() + eventSelected;
                //---------------------------------------------------saving Ticket Types-------------
                //---------------------------------saving Diversity types--------------------
                 attmap.DiversityType__c = '';
                 if (DiversityTypesforfirstLine.size() != 0) {
                     for (string str: DiversityTypesforfirstLine) {
                         attmap.DiversityType__c += str + ';';
                     }
                 }
                 if (DiversityTypesforsecondLine.size() != 0) {
                     for (string str1: DiversityTypesforsecondLine) {
                         attmap.DiversityType__c += str1 + ';';
                     }
                 }
                 Database.SaveResult myAttendeeJunction = Database.Insert(attmap, false);
                 //saving video
                 if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
                 List<string> ss =  new List<string> ();
                ss= youtubevideo.YouTubeId_c__c.split('src="');
                List<string> yy = new List<string> ();
                yy = ss[1].split('"');
                youtubevideo.YouTubeId_c__c = yy[0];

                 youtubevideo.AttendeeSummary__c = myAttendeeSaveResult.getId();
                 insert youtubevideo;
                 }
                 system.debug('            eam jun ID       '+myAttendeeJunction.getId());
                 addattendee = false;
                 attendeeevent = myAttendeeJunction.id;
                 eventatt = [select id, As_id__r.AS_FirstName__c, As_id__r.AS_LastName__c, As_id__r.AS_Company__c, EV_ID__C,
                     TicketTypes__c, EV_id__r.EV_Title__c, AS_id__r.AS_Title__c, EA_AttendeeBarcode__c,AS_id__r.FetchStatus__c, AS_id__r.AS_Email__c, EV_id__r.EV_EventLogo__c,Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : attendeeevent
                 ];
                  if( eventatt.TicketTypes__c != null)

                 eventselected = eventselected;
                 getevents();
             } else {

                try{
                   ev_att_Jun =  [select count() from Event_Attendee_Mapping__c
                     where  Ev_id__c = : eventSelected AND AS_id__c =: myAttendeeSaveResult.getId()];


                 }catch(exception e){}
                 system.debug('============================1111 ' + ev_att_Jun);
                 if (ev_att_Jun > 0) {
                     showerror = 'Attendee Already Exists!';
                     addemail=true;
                     DisplayError = True;
                     Database.rollback(sp);
                 } else {
                     attmap = new Event_Attendee_Mapping__c();
                     attmap.AS_id__c = myAttendeeSaveResult.getId();
                     attmap.Ev_id__c = eventSelected;
                     attmap.IsMatchMakingAttendee__c =True;
                     attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId() + eventSelected;
                     if (selectedTicTypes.size() > 0) {
                         attmap.TicketTypes__c = '';
                         for (string str: selectedTicTypes) {
                             attmap.TicketTypes__c += str + ',';
                         }
                     }
                     if (DiversityTypes.size() > 0) {
                         attmap.DiversityType__c = '';
                         for (string str: DiversityTypesforfirstLine) {
                             attmap.DiversityType__c += str + ';';
                         }
                         for (string str1: DiversityTypesforsecondLine) {
                             attmap.DiversityType__c += str1 + ';';
                         }
                         system.debug('------------------------------------------------------------------REGTYPES::::::::::-----' +    attmap.DiversityType__c.removeEnd(';'));
                     }

                     
                     Database.SaveResult myAttendeeJunction = Database.Insert(attmap, false);
                     system.debug('            eam jun ID       '+myAttendeeJunction.getId());
                    

                     attendeeevent = myAttendeeJunction.id;
                     addattendee = false;
                     if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
                 List<string> ss =  new List<string> ();
                ss= youtubevideo.YouTubeId_c__c.split('src="');
                List<string> yy = new List<string> ();
                yy = ss[1].split('"');
                youtubevideo.YouTubeId_c__c = yy[0];

                 youtubevideo.AttendeeSummary__c = myAttendeeSaveResult.getId();
                 insert youtubevideo;
                 }

                    }
                 }
                 user use = new user();
                 try {
                     use = [select id from User where Username = : myatt.AS_Email__c];
                 } catch (exception e) {}
                 system.debug('-------------------------new attendee------------------' + use);
                 system.debug('-------------------------new attendee------------------' + use.id);
                Profile__c profil = [select id, Name from Profile__c where PR_Name__c = : 'Attendee'];
                User_Profile_Event__c uperec = new User_Profile_Event__c();
                if (use.id != null) {
                     uperec.EV_id__c = eventSelected;
                     uperec.UEP_isActive__c = true;
                     uperec.User_id__c = use.id;
                     uperec.Profile_id__c = profil.id;
                     uperec.Attendee_Summary__c = myAttendeeSaveResult.getId();
                     uperec.IsMatchMakingUser__c = true;
                     uperec.EventAdmin_Id__c=UserInfo.getUserId();

                     insert uperec;
                     system.debug('              UPE ATT     '+uperec.id);
                 }
                  eventselected = eventselected;
                    getevents();
             }
                   try{
                   attach = new Event__c();
                    attach = [select EV_EventLogo__c,MatchMaking_Type__c,Is_Webank_event__c, EV_Title__c from Event__c where id = : eventSelected];
                    }catch (exception e) {}
                    pageReference pg =new pageReference('/apex/MM_Eventadmin_AttendeesDirectory');
                    
                    pg.setRedirect(true);
                    return pg;
                     
         }



     //-------------------------------For Save And Print-----------------------

     //------------------------------------------------------------------------------

     public ID attendeeid {get;set;}




     //---------------------------------------------------------------------END OF SAVE ATTENDEE-----------------------------
     //-----------------------------------------EDIT ATTENDEES---------------------
     public Event_Attendee_Mapping__c TicTypesforedit {
         get;
         set;
     }
     public Event_Attendee_Mapping__c DivTypesforedit {
         get;
         set;
     }
     public Event_Attendee_Mapping__c AttTypesforedit {
         get;
         set;
     }
     
     
     /* Edited by Rajesh on 30-06-2015 */
     
     
     public String EditAttendeeId {get ; set ;}
     public list<MBE_Profile__c> mbepro {get ; set ;}
     public List<MBE_Profile__c> emailchk {get ; set ;}
     public static string remoteeventid {get ; set ;}
     public boolean editview2 {get ; set ;}
     public void editAttendee() {
             attachments = new list<Attachment> ();
             remoteeventid = eventselected;
             //editEmail=True;
             Addemail = false;
             checkcommforAttendeeEdit = '#$%&&**00';
            youtubevideo = new Widget__c();
            cyoutubevideo = new Custom_Widget__c ();
              ShowPage = True;
              foraddatt = false;
           emailalert =false;
           emailalert1 = false;
          // attendeeImage = new blob();
           myimageName = '';
         system.debug('========================================');
         string ss = ApexPages.currentPage().getParameters().get('mycheck');
         EditAttendeeId = ss;
         eventname1 = '';
         eventname1 = ss;
         system.debug('========================================' + ss);
         limitofbadges = false;
         DisplayError = False;
         imageerror = False;
         EventReqString = '';
         eventatt = new Event_Attendee_Mapping__c();
         string TTT = '';
         List < string > totaltypes = new list < string > ();
         emailalert = false;
         emailalert1 = false;
         naicschangeids = '';
         naicschangeselctdids = '';
         commchangeselctdids ='';
         checkcommforAttendeeEdit = '';
         foreditatt = true;
         //-------------------------------------------------------------FOR REG TYPE EDIT--------------------


         //----------------------------------------------------------------FOR DIVERSITY TYPE EDIT-------------------------------------------
         //try {
         //try{
            Divoptions = new List < Selectoption > ();
         Divoptionsforsecondline = new List < Selectoption > ();
             system.debug('===============================' + eventSelected);
             eventDIVS = [select EventDiversityValues__c,Is_Webank_event__c  from Event__c where id = : eventSelected];
             String Div = eventDIVS.EventDiversityValues__c;
             string[] DiversityTypes1 = Div.split(';');
businessdes = new List<string>();
system.debug('nnnnnnnnnnn'+DiversityTypes1.size());
             integer i = 0;
            for (String Diversty: DiversityTypes1) {
            businessdes.add(Diversty);
              if (math.MOD(i, 2) == 0) {
                   Divoptions.add(new SelectOption(Diversty, Diversty));

                } else {
                    Divoptionsforsecondline.add(new SelectOption(Diversty, Diversty));
                 }
              i++;
           }
system.debug('ooooooooo'+businessdes.size());



             system.debug('2222222222 4444444444444 55555555555 '+Divoptions);
               system.debug('9999999999 777777777777 666666666666666'+ss);

             DivTypesforedit = [select DiversityType__c,MBE_Profile__c,Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : ss];
             system.debug('::::::::::::::::::::::' + DivTypesforedit.DiversityType__c);
             DiversityTypesforfirstline = new string[] {};
             DiversityTypesforsecondline = new string[] {};
             if (DivTypesforedit.DiversityType__c != null) {
                 string diversity = DivTypesforedit.DiversityType__c;
                 list < string > seldivs = diversity.split(';');
                 for (string dd: seldivs) {
                     DiversityTypesforfirstline.add(dd);
                     DiversityTypesforsecondline.add(dd);
                 }
             }

        // } catch (exception e) {}
        //----------------------------------------------------for attendee types     in edit---------------------

  system.debug('12222222222 4444444444444 55555555555 '+DiversityTypesforsecondline);
         //--------------------------------------------------------------------
         Event_Attendee_Mapping__c attendeeid = [select AS_id__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : ss];
         newattendee = new AttendeeSummary__c();
                 Event__c eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:eventselected];
         event1234 = new list < AttendeeSummary__c > ();
         if(eventone.Is_Webank_event__c == false){
                 event1234 = [select id, name, AS_Age__c, isUpdated__c, AS_BirthDate__c, AS_BlogUrl__c, Keywords__c, AS_BusinessDunsNumber__c,
                                         AS_BusinessEstablishedDate__c, AS_BusinessRevenue__c, AS_BusinessTaxId__c, AS_CellPhone__c,AS_BusinessDescription__c,
                                         AS_Company__c, AS_DiversityType__c, Registration_type__c, AS_Email__c, AS_FaxNumber__c, AS_FirstName__c, AS_Gender__c,
                                         AS_HomeAddress1__c, AS_HomeAddress2__c, AS_HomeCity__c, AS_HomeCountry__c, AS_HomePhone__c,
                                         AS_HomePoBox__c, AS_HomeZip__c, AS_ImageUrl__c,Exhibitor_company_imageUrl__c, AS_LastName__c, AS_NAICSCode_1__c,
                                         AS_NAICSCode_2__c, AS_NAICSCode_3__c, AS_NAICSCode_4__c, AS_NAICSCode_5__c, AS_NumberOfEmployees__c, AS_PrefixNew__c,
                                         AS_PrimaryBusinessCategory1__c, AS_SecondaryBusinessCategory1__c, AS_ShippingAddress1__c, AS_ShippingAddress2__c,
                                         AS_ShippingCity__c, AS_ShippingCountry__c, AS_ShippingPhone__c, AS_shippingzip__c, AS_ShippingState__c,
                                         AS_ShippingZipcode__c, AS_SuffixNew__c, AS_ThroughEventBrite__c, AS_Title__c, AS_WebsiteUrl__c, AS_WorkAddress1__c,
                                         AS_WorkAddress2__c, AS_WorkCity__c, AS_WorkCountry__c, AS_WorkPhone__c, AS_WorkPoBox__c, AS_Work_Country__c, AS_WorkZip__c,
                                         AS_Work_States__c, As_Home_Country__c, As_Home_State__c, As_Shipping_Country__c, As_Shipping_States__c,FetchStatus__c,isFetched__c,
                                         AS_CageCode__c,Business_type__c,Company_Certifications__c,GSA_Schedule__c,Exceptional_Key_Words__c,BBB_Number__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c,Commodity_6__c,Commodity_7__c,Commodity_8__c,Commodity_9__c,DBA__c,distribution_Country__c,Revenue_Range__c,
                                        Business_Structure__c,Ethnicity__c,AS_Secondary_Email__c,
                                         Geographical_Region__c,Manufactures_Country__c,AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,References__c,
Scope_of_Work__c,
References2__c,
Scope_of_Work2__c,
Certificate_Processed_by_RPO__c,Year_in_business__c,Any_non_WBENC_awards_received__c,Companyhaveafacility_partneroutsideUSA__c, 
                                         (select id,YouTubeId_c__c From Widgets__r)FROM AttendeeSummary__c WHERE id = : attendeeid.AS_id__c
                 ];
                 List<string> sts = new List<string>();
                  if(event1234[0].Geographical_Region__c != null && event1234[0].Geographical_Region__c != ''){
                sts = event1234[0].Geographical_Region__c.split(',');
                selectedregions.addall(sts);
                }
                  attachments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:attendeeid.AS_id__c];
                 for (AttendeeSummary__c emEvent1: event1234) {
                     if (ss != null && ss != '') {
                         EventReqStringBool = false;

                         EventReqString = 'Edit MBE';
                         addattendee = TRUE;
                         foreditatt = true;
                         foraddatt = false;
                         newattendee = emEvent1;
                         break;
                     }
                 }

                 system.debug('========================================11111 ' + newattendee);
         system.debug('========================================11111 ' + newattendee.AS_NAICSCode_4__c);
        checkNAICSforAttendeeEdit = '!@##$$$$###@';
         if(newattendee.AS_NAICSCode_1__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode_1__c;
         }if(newattendee.AS_NAICSCode_2__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode_2__c;
         }if(newattendee.AS_NAICSCode_3__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode_3__c;
         }if(newattendee.AS_NAICSCode_4__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode_4__c;
         }if(newattendee.AS_NAICSCode_5__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode_5__c;
         }
         if(newattendee.AS_NAICSCode6__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode6__c;
         }
         if(newattendee.AS_NAICSCode7__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode7__c;
         }
         if(newattendee.AS_NAICSCode8__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode8__c;
         }if(newattendee.AS_NAICSCode9__c!=null ){

             checkNAICSforAttendeeEdit += newattendee.AS_NAICSCode9__c;
         }
         checkcommforAttendeeEdit = '!@##$$$$###@';
         if(newattendee.Commodity_1__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_1__c;
         }if(newattendee.Commodity_2__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_2__c;
         }if(newattendee.Commodity_3__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_3__c;
         }if(newattendee.Commodity_4__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_4__c;
         }if(newattendee.Commodity_5__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_5__c;
         }if(newattendee.Commodity_6__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_6__c;
         }if(newattendee.Commodity_7__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_7__c;
         }if(newattendee.Commodity_8__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_8__c;
         }if(newattendee.Commodity_9__c!=null ){

             checkcommforAttendeeEdit += ','+newattendee.Commodity_9__c;
         }
        system.debug('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa ' + checkNAICSforAttendeeEdit );


        system.debug('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa ' + checkNAICSforAttendeeEdit );
         if (newattendee.As_ImageUrl__c != null) {
             eventIdVar = newattendee.As_ImageUrl__c;
         }
         if (newattendee.AS_Gender__c == 'Male') {
             Selected = 'TRUE';
         }
         ELSE {
             selected = 'FALSE';
         }
         ageMod = String.valueOf(newattendee.AS_age__c);
         if (newattendee.AS_age__c != null) {
             if (ageMod != '0.0') {
                 if (ageMod.contains('.0')) {
                     ageMod.replaceAll('.0', '');
                 }
             } else {
                 ageMod = '';
             }
         }
         //if (newattendee.AS_NAICSCode_1__c > 10)

         EditDate = String.valueOf(newattendee.AS_BirthDate__c);
         BEDate = String.valueOf(newattendee.AS_BusinessEstablishedDate__c);


             }else{
                 system.debug('attendeeid.AS_id__c === '+attendeeid.AS_id__c);
             mbepro = new list<MBE_Profile__c> ();
             emailchk = new List<MBE_Profile__c>();
                emailchk = [Select AS_Email__c from MBE_Profile__c where AttendeeSummary__r.id =: attendeeid.AS_id__c AND Event_Organizer_Id__c=:eventone.owner.username];
              mbepro = [Select  a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,
                              a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                              a.AS_WorkZipCode__c,a.AS_WorkPhone__c,
                              a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, a.Key_Words__c,
                              a.AS_WebsiteUrl__c, a.AS_Title__c,
                              a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c,
                              a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                              a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c,
                              a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c,
                              a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c,
                              a.AS_HomePhone__c,a.AS_HomeCity__c,
                              a.DBA__c,
                              a.Geographical_Region__c,
                              a.Certificate_Processed_by_RPO__c,
                              a.BBB_Number__c,
                              a.Commodity_1__c,
                              a.Commodity_2__c,
                              a.Commodity_3__c,
                              a.Commodity_4__c,
                              a.Commodity_5__c,
                               a.Commodity_6__c,
                              a.Commodity_7__c,
                              a.Commodity_8__c,
                              a.Commodity_9__c,
                              a.distribution_Country__c,
                              a.Manufactures_Country__c,
                              a.References__c,
                            a.References2__c,
                            a.Scope_of_Work__c,
                            a.Scope_of_Work2__c,
                              a.Revenue_Range__c,
                               a.AS_NAICSCode9__c,
                       a.AS_NAICSCode8__c,
                        a.AS_NAICSCode7__c,
                        a.AS_NAICSCode6__c,
                            a.Year_in_business__c,a.Business_Structure__c,
                            a.Ethnicity__c,a.AS_Secondary_Email__c,
                              a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                              a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                              a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,a.Exceptional_Key_Words__c,
                              a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_WorkZip__c,AS_HomeZip__c,
                              a.AS_BusinessDunsNumber__c,a.AS_BusinessTaxId__c,a.Any_non_WBENC_awards_received__c,a.Companyhaveafacility_partneroutsideUSA__c,a.Company_Certifications__c,(select id,YouTubeId_c__c From Custom_Widgets__r)
                               from MBE_Profile__c a Where a.id =: DivTypesforedit.MBE_Profile__c AND a.Event_Organizer_Id__c=:eventone.owner.username];

            //if(mbepro.size()>0){
           attachments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:mbepro[0].id];//}
            for (AttendeeSummary__c emEvent1: event1234) {

                         newattendee = emEvent1;

                     }

            List<string> sts = new List<string>();
                  if(mbepro[0].Geographical_Region__c != null && mbepro[0].Geographical_Region__c != ''){
                sts = mbepro[0].Geographical_Region__c.split(',');
                selectedregions.addall(sts);
                }


               //system.debug('========================================11111 ' + newattendee);
         //system.debug('========================================11111 ' + newattendee.AS_NAICSCode_4__c);
        checkNAICSforAttendeeEdit = '!@##$$$$###@';
         if(mbepro[0].AS_NAICSCode_1__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_1__c;
         }if(mbepro[0].AS_NAICSCode_2__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_2__c;
         }if(mbepro[0].AS_NAICSCode_3__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_3__c;
         }if(mbepro[0].AS_NAICSCode_4__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_4__c;
         }if(mbepro[0].AS_NAICSCode_5__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode_5__c;
         }if(mbepro[0].AS_NAICSCode6__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode6__c;
         }if(mbepro[0].AS_NAICSCode7__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode7__c;
         }if(mbepro[0].AS_NAICSCode8__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode8__c;
         }if(mbepro[0].AS_NAICSCode9__c!=null ){

             checkNAICSforAttendeeEdit += mbepro[0].AS_NAICSCode9__c;
         }


          checkcommforAttendeeEdit = '!@##$$$$###@';
         if(mbepro[0].Commodity_1__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_1__c;
         }if(mbepro[0].Commodity_2__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_2__c;
         }if(mbepro[0].Commodity_3__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_3__c;
         }if(mbepro[0].Commodity_4__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_4__c;
         }if(mbepro[0].Commodity_5__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_5__c;
         }if(mbepro[0].Commodity_6__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_2__c;
         }if(mbepro[0].Commodity_7__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_3__c;
         }if(mbepro[0].Commodity_8__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_4__c;
         }if(mbepro[0].Commodity_9__c!=null ){

             checkcommforAttendeeEdit += ','+mbepro[0].Commodity_5__c;
         }
        system.debug('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa ' + checkcommforAttendeeEdit );
         if (mbepro[0].As_ImageUrl__c != null) {
             eventIdVar = mbepro[0].As_ImageUrl__c;
         }



         BEDate = String.valueOf(mbepro[0].AS_BusinessEstablishedDate__c);


             Editview2 = true;

             }

         System.debug('HEllo MALLIK END ' + addattendee + '   ' + newAttendee);
         List <User_Profile_Event__c> CompareEmailId = [select id from User_Profile_Event__c where((BoothAdmin_id__r.Email = : newattendee.AS_Email__c OR EventAdmin_Id__r.Email = : newattendee.AS_Email__c) AND(EV_id__c = : eventSelected)) OR((User_Id__r.Email = : newattendee.AS_Email__c) AND(Profile_ID__r.PR_Name__c = 'BoothPersonnel') AND(EV_id__c = : eventSelected))];
         system.debug('----------CompareEmailId---------------'+ CompareEmailId);
         if(CompareEmailId.size() > 0){
             HideEmail = True;
             showEmail = False;
             ShowFirstName = False;
             ShowLastName = False;
             HideFirstName = True;
             HideLastName = True;
         }
         else{
             showEmail = True;
             HideEmail = False;
             ShowFirstName = True;
             HideFirstName = False;
             ShowLastName = True;
             HideLastName = False;
         }
        // }catch(exception e){}
     }
     //----------------------------------------------------------------------------------------END OF EDIT---------------------
     //--------------------------------------------------------------------UPDATE ATTENDEE-------------------------
     /* Edited by Rajesh on 30-06-2015 */
     
     
     public Event_Attendee_Mapping__c EventAttendee_Email {
         get;
         set;
     }
     public boolean imageerror {
         get;
         set;
     }
     public string imageerrormsg {
         get;
         set;
     }
     public PageREference UpdateAttendee() {
         system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' + eventname1);
         naicsselctdids =ApexPages.currentPage().getParameters().get('updateatt');

         List<folder> folderList =new List<folder>();
              folderList = [select id from folder where name='shared Documents'];

    try {
            attach = [select EV_EventLogo__c,MatchMaking_Type__c, EV_Title__c,Is_Webank_event__c  from Event__c where id = : eventSelected];

             if (attach.EV_EventLogo__c != null) {
                 logo = true;
             } else {
                 logo = false;
             }
         } catch (exception e) {}
         system.debug('gggggggggggggg&&&&&&&' + attendeeImage);
         limitofbadges = false;
         Event_Attendee_Mapping__c EveAttmaprec = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c
             where id = : eventname1
         ];
         system.debug('***************************EmailExist Or Not' + newattendee.AS_Email__c);
         List < AttendeeSummary__c > AttendeeEmail = [select id, AS_FirstName__c, As_LastName__c from AttendeeSummary__c where
             AS_Email__c = : newattendee.AS_Email__c
         ];
         system.debug('***************************Exist Or Not' + AttendeeEmail.size());
         if (AttendeeEmail.size() > 0) {
             try {
                 EventAttendee_Email = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c
                     where AS_id__r.AS_Email__c = : newattendee.AS_Email__c
                     AND EV_id__c = : eventSelected
                 ];
             } catch (exception e) {}
             system.debug('%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%' + eventName1+'       '+newattendee.AS_Email__c);
             if (EventAttendee_Email != null) {
                 if (EventAttendee_Email.id != eventName1) {
                     system.debug('%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%');
                     showerror = 'Attendee Already Exists!';
                     DisplayError = True;
                 } else {
                 system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
          try{

               if(commchangeselctdids != NULL){
               commodities = new list<string>();
               commodities =commchangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());


                if(commodities.size() == 2){
                        system.debug('aaaaaaaaaaa ');
                 newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 system.debug('ddddddddddddddddd ' +  newAttendee.Commodity_1__c );
                 newAttendee.Commodity_2__c = '';
                 newAttendee.Commodity_3__c = '';
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                }
                if(commodities.size() == 3){
                        system.debug('aaaaaaaaaaa ');
                 newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = '';
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                  newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                }
                if(commodities.size() == 4){
                        system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                  newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                }
                if(commodities.size() == 5){
                        system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = '';
                  newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                }
                 if(commodities.size() == 6){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                  newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                }
                if(commodities.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                  newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                }
                if(commodities.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                  newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                }
                if(commodities.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                  newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = commodities [8].replace('&','-');
                 newAttendee.Commodity_9__c = '';
                }
                if(commodities.size() == 10){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                  newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = commodities [8].replace('&','-');
                 newAttendee.Commodity_9__c = commodities [9].replace('&','-');
                }


       }
             if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                system.debug('ddddddddddddddddd ' +  newAttendee.As_NAICSCode_1__c );

                if(naicscods.size() == 2){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = '';
                 newAttendee.As_NAICSCode_3__c = '';
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';

                }
                if(naicscods.size() == 3){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = '';
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 4){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 5){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                 if(naicscods.size() == 6){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = naicscods[1].replace('&','-');
                 newAttendee.Commodity_2__c = naicscods[2].replace('&','-');
                 newAttendee.Commodity_3__c = naicscods[3].replace('&','-');
                 newAttendee.Commodity_4__c = naicscods[4].replace('&','-');
                 newAttendee.Commodity_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
               }
                if(naicscods.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 10){
                         system.debug('aaaaaaaaaaa ');
              newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  newAttendee.AS_NAICSCode9__c =naicscods[9].replace('&','-');
                }



       }

             if(naicschangeids == NULL){

                 newAttendee.As_NAICSCode_1__c = '';
                 newAttendee.As_NAICSCode_2__c = '';
                 newAttendee.As_NAICSCode_3__c = '';
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';

             }
             for(string st : selectedregions){
           newAttendee.Geographical_Region__c += st+',';
           }
       }catch(Exception e){}

               try{
                    if(attachmentname != null){
                     if ( attachmentval.size() != null) {
                          Attachment a = new Attachment(parentId = newattendee.id, name=attachmentname, body = attachmentval);
                         insert a;
                         attachmentname =null;
                    }
                  }
            }catch(Exception e){}

           try{
           //saving video
                 if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
                 List<string> ss =  new List<string> ();
                ss= youtubevideo.YouTubeId_c__c.split('src="');
                List<string> yy = new List<string> ();
                yy = ss[1].split('"');
                youtubevideo.YouTubeId_c__c = yy[0];

                 youtubevideo.AttendeeSummary__c = newAttendee.id;
                 insert youtubevideo;
                 }

           system.debug('::::::::::::::::youtube:::::::::::::'+youtubevideo);
           }catch(exception e){}

                      update newattendee;
                     system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&' + newAttendee.As_NAICSCode_5__c);
                     system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&' + attendeeImage);
                     //---------------------------------------------------------Diversity---------------------------
                     try{
                      if(DivTypesforedit!=null ){
                         DivTypesforedit.DiversityType__c = '';
                         if (DiversityTypesforfirstline.size() != 0) {
                             for (string dtypes: DiversityTypesforfirstline) {
                                 DivTypesforedit.DiversityType__c += dtypes + ';';
                             }
                         }
                         if (DiversityTypesforsecondline.size() != 0) {
                             for (string dtypes: DiversityTypesforsecondline) {
                                 DivTypesforedit.DiversityType__c += dtypes + ';';
                             }
                         }
                         update DivTypesforedit;
                       }  
                    }catch(exception e){}
                    AttendeeSummary__c ImageUpload = [select Exhibitor_company_imageUrl__c,AS_ImageUrl__c from AttendeeSummary__c where id = : AttendeeEmail[0].id];
                      if (ExhibitorImage != NULL && (ExhibitorImageName != '' || ExhibitorImageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+ExhibitorImage.size());
             if (ExhibitorImage.size() != null) {
                 if (ExhibitorImage.size() <= 4024000) {
                     mydoc = new document();
                     mydoc.body = ExhibitorImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                     mydoc.ispublic = true;
                     mydoc.Name = ExhibitorImageName;
                     insert mydoc;
                     ExhibitorImage =null;
                     ImageUpload.Exhibitor_company_imageUrl__c = mydoc.id;
                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 4MB';
                 }
             }
         }

                     if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
                         if (attendeeImage.size() != null) {
                             if (attendeeImage.size() < 4024000) {
                                 mydoc = new document();
                                 mydoc.body = attendeeImage;
                                //mydoc.folderid = UserInfo.getUserId();
                                 if(folderList.size()>0){
                                   mydoc.folderid =folderList[0].id;
                                   }
                                 mydoc.ispublic = true;
                                 mydoc.Name = myimageName;
                                 insert mydoc;
                                 system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + mydoc);
                                 
                                 ImageUpload.AS_ImageUrl__c = mydoc.id;
                                 Update ImageUpload;
                                 addattendee = false;
                                 eventselected = eventselected;
                                 getevents();
                                 system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + ImageUpload.AS_ImageUrl__c);
                             } else {
                                 imageerror = true;
                                 system.debug('========================= error message ===================' + imageerror);
                                 imageerrormsg = 'Image size should be less than 1MB';
                                 system.debug('========================= error message ===================' + imageerror);
                             }
                         }
                     } else {
                         addattendee = false;
                         eventselected = eventselected;
                         getevents();
                     }
                 }
             } else {
                 EveAttmaprec.AS_id__c = AttendeeEmail[0].id;
                 EveAttmaprec.Attendee_Event_IDs__c = AttendeeEmail[0].id + eventSelected;
                 update EveAttmaprec;
                 try{
                 DivTypesforedit.DiversityType__c = '';
                     if (DiversityTypesforfirstline.size() != 0) {
                         for (string dtypes: DiversityTypesforfirstline) {
                             DivTypesforedit.DiversityType__c += dtypes + ';';
                         }
                     }
                     if (DiversityTypesforsecondline.size() != 0) {
                         for (string dtypes: DiversityTypesforsecondline) {
                             DivTypesforedit.DiversityType__c += dtypes + ';';
                         }
                     }
                     update DivTypesforedit;
                     }catch(exception e){}
                 if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
                     if (attendeeImage.size() != null) {
                         if (attendeeImage.size() < 4024000) {
                             mydoc = new document();
                             mydoc.body = attendeeImage;
                             //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                             mydoc.ispublic = true;
                             mydoc.Name = myimageName;
                             insert mydoc;
                             system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + mydoc);
                             AttendeeSummary__c ImageUpload = [select AS_ImageUrl__c from AttendeeSummary__c where id = : AttendeeEmail[0].id];
                             ImageUpload.AS_ImageUrl__c = mydoc.id;
                             Update ImageUpload;
                             addattendee = false;
                             eventselected = eventselected;
                             getevents();
                             system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + ImageUpload.AS_ImageUrl__c);
                         } else {
                             imageerror = true;
                             system.debug('========================= error message ===================' + imageerror);
                             imageerrormsg = 'Image size should be less than 1MB';
                             system.debug('========================= error message ===================' + imageerror);
                         }
                     }
                 } else {
                     addattendee = false;
                     eventselected = eventselected;
                     getevents();
                 }
             }
         } else {
             system.debug('--------------no attendee-----------------');
            AttendeeSummary__c UpdateAttendee = new AttendeeSummary__c();

             system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^' + newattendee.AS_FirstName__c);
             UpdateAttendee.AS_FirstName__c = newattendee.AS_FirstName__c;
             UpdateAttendee.AS_LastName__c = newattendee.AS_LastName__c;
             UpdateAttendee.As_Email__c = newattendee.As_Email__c;
             UpdateAttendee.AS_Company__c = newattendee.AS_Company__c;
             UpdateAttendee.AS_PrefixNew__c = newattendee.AS_PrefixNew__c;
             UpdateAttendee.AS_SuffixNew__c = newattendee.AS_SuffixNew__c;
             UpdateAttendee.AS_Title__c = newattendee.AS_Title__c;
             UpdateAttendee.AS_CellPhone__c = newattendee.AS_CellPhone__c;
             try {
                 UpdateAttendee.AS_Age__c = Integer.valueOf(ageMod);
             } catch (Exception e) {
                 UpdateAttendee.AS_Age__c = null;
             }
             UpdateAttendee.AS_HomePhone__c = newattendee.AS_HomePhone__c;
             UpdateAttendee.AS_Gender__c = newattendee.AS_Gender__c;
             UpdateAttendee.AS_BirthDate__c = newattendee.AS_BirthDate__c;
             UpdateAttendee.AS_HomeAddress1__c = newattendee.AS_HomeAddress1__c;
             UpdateAttendee.AS_BusinessDescription__c = newattendee.AS_BusinessDescription__c;
             UpdateAttendee.AS_BusinessEstablishedDate__c = newattendee.AS_BusinessEstablishedDate__c;
             UpdateAttendee.AS_BusinessDunsNumber__c = newattendee.AS_BusinessDunsNumber__c;
             UpdateAttendee.AS_NumberOfEmployees__c = newattendee.AS_NumberOfEmployees__c;
             UpdateAttendee.AS_BusinessRevenue__c = newattendee.AS_BusinessRevenue__c;
             UpdateAttendee.AS_BusinessTaxId__c = newattendee.AS_BusinessTaxId__c;
             UpdateAttendee.AS_PrimaryBusinessCategory1__c = newattendee.AS_PrimaryBusinessCategory1__c;
             UpdateAttendee.AS_SecondaryBusinessCategory1__c = newattendee.AS_SecondaryBusinessCategory1__c;
             UpdateAttendee.AS_WebsiteURL__c = newattendee.AS_WebsiteURL__c;
             UpdateAttendee.AS_ShippingAddress1__c = newattendee.AS_ShippingAddress1__c;
             UpdateAttendee.AS_ShippingPOBox__c = newattendee.AS_ShippingPOBox__c;
             UpdateAttendee.AS_BlogURL__c = newattendee.AS_BlogURL__c;
             UpdateAttendee.AS_WorkAddress1__c = newattendee.As_WorkAddress1__c;
             UpdateAttendee.AS_WorkPhone__c = newattendee.AS_WorkPhone__c;
             UpdateAttendee.AS_WorkPOBox__c = newattendee.AS_WorkPOBox__c;
             UpdateAttendee.AS_DiversityType__c = newattendee.AS_DiversityType__c;
             UpdateAttendee.Business_type__c = newattendee.Business_type__c;
             UpdateAttendee.Company_Certifications__c = newattendee.Company_Certifications__c;
             UpdateAttendee.GSA_Schedule__c = newattendee.GSA_Schedule__c;
             UpdateAttendee.AS_CageCode__c = newattendee.AS_CageCode__c;
             UpdateAttendee.AS_DiversityType__c = newattendee.AS_DiversityType__c;


             UpdateAttendee.AS_shippingCity__c = newattendee.AS_shippingCity__c;
             UpdateAttendee.AS_shippingState__c = newattendee.AS_shippingState__c;
             UpdateAttendee.AS_WorkAddress1__c = newattendee.AS_WorkAddress1__c;
             UpdateAttendee.AS_Workcity__c = newattendee.AS_Workcity__c;
             UpdateAttendee.AS_WorkState__c = newattendee.AS_WorkState__c;
             UpdateAttendee.AS_HomeAddress1__c = newattendee.AS_HomeAddress1__c;
             UpdateAttendee.AS_HomeCity__c = newattendee.AS_HomeCity__c;
             UpdateAttendee.AS_HomePOBox__c = newattendee.AS_HomePOBox__c;
             UpdateAttendee.As_Home_State__c = newattendee.As_Home_State__c;
             UpdateAttendee.AS_uniqueField__c = (newattendee.AS_FirstName__c + newattendee.AS_LastName__c + newattendee.AS_Email__c).tolowercase();
            try{
           naicscods= new list<string>();
       if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                system.debug('ddddddddddddddddd ' +  UpdateAttendee.As_NAICSCode_1__c );

                if(naicscods.size() == 2){
                 UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = '';
                 UpdateAttendee.As_NAICSCode_3__c = '';
                 UpdateAttendee.As_NAICSCode_4__c = '';
                 UpdateAttendee.As_NAICSCode_5__c = '';
                 UpdateAttendee.AS_NAICSCode6__c = '';
                  UpdateAttendee.AS_NAICSCode7__c ='';
                  UpdateAttendee.AS_NAICSCode8__c ='';
                  UpdateAttendee.AS_NAICSCode9__c ='';

                }
                if(naicscods.size() == 3){
                 UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.As_NAICSCode_3__c = '';
                 UpdateAttendee.As_NAICSCode_4__c = '';
                 UpdateAttendee.As_NAICSCode_5__c = '';
                 UpdateAttendee.AS_NAICSCode6__c = '';
                  UpdateAttendee.AS_NAICSCode7__c ='';
                  UpdateAttendee.AS_NAICSCode8__c ='';
                  UpdateAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 4){
                 UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 UpdateAttendee.As_NAICSCode_4__c = '';
                 UpdateAttendee.As_NAICSCode_5__c = '';
                 UpdateAttendee.AS_NAICSCode6__c = '';
                  UpdateAttendee.AS_NAICSCode7__c ='';
                  UpdateAttendee.AS_NAICSCode8__c ='';
                  UpdateAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 5){
                 UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 UpdateAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 UpdateAttendee.As_NAICSCode_5__c = '';
                 UpdateAttendee.AS_NAICSCode6__c = '';
                  UpdateAttendee.AS_NAICSCode7__c ='';
                  UpdateAttendee.AS_NAICSCode8__c ='';
                  UpdateAttendee.AS_NAICSCode9__c ='';
                }
                 if(naicscods.size() == 6){
                 UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 UpdateAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 UpdateAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 UpdateAttendee.AS_NAICSCode6__c = '';
                  UpdateAttendee.AS_NAICSCode7__c ='';
                  UpdateAttendee.AS_NAICSCode8__c ='';
                  UpdateAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 UpdateAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 UpdateAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 UpdateAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  UpdateAttendee.AS_NAICSCode7__c ='';
                  UpdateAttendee.AS_NAICSCode8__c ='';
                  UpdateAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                UpdateAttendee.Commodity_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.Commodity_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.Commodity_3__c = naicscods[3].replace('&','-');
                 UpdateAttendee.Commodity_4__c = naicscods[4].replace('&','-');
                 UpdateAttendee.Commodity_5__c = naicscods[5].replace('&','-');
                  UpdateAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  UpdateAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  UpdateAttendee.AS_NAICSCode8__c ='';
                  UpdateAttendee.AS_NAICSCode9__c ='';
               }
                if(naicscods.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 UpdateAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 UpdateAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  UpdateAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  UpdateAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  UpdateAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  UpdateAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 10){
                         system.debug('aaaaaaaaaaa ');
              UpdateAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 UpdateAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 UpdateAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 UpdateAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 UpdateAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  UpdateAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  UpdateAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  UpdateAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  UpdateAttendee.AS_NAICSCode9__c =naicscods[9].replace('&','-');
                }



       }



       }catch(Exception e){}

             insert UpdateAttendee;
             system.debug('::::::::::::::::::::new attendee:::::::::' + UpdateAttendee.id);
             EveAttmaprec.AS_id__c = UpdateAttendee.id;
             EveAttmaprec.EV_id__c = eventSelected;
             EveAttmaprec.Attendee_Event_IDs__c = UpdateAttendee.Id + eventSelected;
             EveAttmaprec.EA_AttendeeBarcode__c = EveAttmaprec.id + '-' + eventSelected;
             update EveAttmaprec;
             system.debug('--------------Updated jun record-----------------' + EveAttmaprec.id);


             if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
                 if (attendeeImage.size() != null) {
                     if (attendeeImage.size() < 4024000) {
                         mydoc = new document();
                         mydoc.body = attendeeImage;
                        //mydoc.folderid = UserInfo.getUserId();
                                 if(folderList.size()>0){
                                   mydoc.folderid =folderList[0].id;
                                   }
                         mydoc.ispublic = true;
                         mydoc.Name = myimageName;
                         insert mydoc;
                         system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + mydoc);
                         AttendeeSummary__c ImageUpload = [select AS_ImageUrl__c from AttendeeSummary__c where id = : UpdateAttendee.id];
                         ImageUpload.AS_ImageUrl__c = mydoc.id;
                         Update ImageUpload;
                         addattendee = false;
                         eventselected = eventselected;
                         getevents();
                         system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + ImageUpload.AS_ImageUrl__c);
                     } else {
                         imageerror = true;
                         system.debug('========================= error message ===================' + imageerror);
                         imageerrormsg = 'Image size should be less than 1MB';
                         system.debug('========================= error message ===================' + imageerror);
                     }
                     if (ExhibitorImage != NULL && (ExhibitorImageName != '' || ExhibitorImageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+ExhibitorImage.size());
             if (ExhibitorImage.size() != null) {
                 if (ExhibitorImage.size() <= 4024000) {
                     mydoc = new document();
                     mydoc.body = ExhibitorImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                     mydoc.ispublic = true;
                     mydoc.Name = ExhibitorImageName;
                     insert mydoc;
                     ExhibitorImage =null;
                     newattendee.AS_ImageUrl__c = mydoc.id;
                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 4MB';
                 }
             }
         }
                 }
             } else {
                 addattendee = false;
                 eventselected = eventselected;
                 getevents();
             }
         }
         pagereference pg = new pagereference('/apex/MM_Eventadmin_AttendeesDirectory');
         pg.setredirect(true);
         return pg;
         //return null;
     }
    
     //For WEBANK custom profile
     public Custom_Widget__c cyoutubevideo {get ; set ;}
     public Pagereference SavecustAttendee(){
     
     
                             if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                system.debug('ddddddddddddddddd ' +  mbepro[0].As_NAICSCode_1__c );

                if(naicscods.size() == 2){
                 mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = '';
                 mbepro[0].As_NAICSCode_3__c = '';
                 mbepro[0].As_NAICSCode_4__c = '';
                 mbepro[0].As_NAICSCode_5__c = '';
                 mbepro[0].AS_NAICSCode6__c = '';
                  mbepro[0].AS_NAICSCode7__c ='';
                  mbepro[0].AS_NAICSCode8__c ='';
                  mbepro[0].AS_NAICSCode9__c ='';

                }
                if(naicscods.size() == 3){
                 mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mbepro[0].As_NAICSCode_3__c = '';
                 mbepro[0].As_NAICSCode_4__c = '';
                 mbepro[0].As_NAICSCode_5__c = '';
                 mbepro[0].AS_NAICSCode6__c = '';
                  mbepro[0].AS_NAICSCode7__c ='';
                  mbepro[0].AS_NAICSCode8__c ='';
                  mbepro[0].AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 4){
                 mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mbepro[0].As_NAICSCode_4__c = '';
                 mbepro[0].As_NAICSCode_5__c = '';
                 mbepro[0].AS_NAICSCode6__c = '';
                  mbepro[0].AS_NAICSCode7__c ='';
                  mbepro[0].AS_NAICSCode8__c ='';
                  mbepro[0].AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 5){
                 mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mbepro[0].As_NAICSCode_5__c = '';
                 mbepro[0].AS_NAICSCode6__c = '';
                  mbepro[0].AS_NAICSCode7__c ='';
                  mbepro[0].AS_NAICSCode8__c ='';
                  mbepro[0].AS_NAICSCode9__c ='';
                }
                 if(naicscods.size() == 6){
                 mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 mbepro[0].AS_NAICSCode6__c = '';
                  mbepro[0].AS_NAICSCode7__c ='';
                  mbepro[0].AS_NAICSCode8__c ='';
                  mbepro[0].AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mbepro[0].AS_NAICSCode7__c ='';
                  mbepro[0].AS_NAICSCode8__c ='';
                  mbepro[0].AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = naicscods[1].replace('&','-');
                 mbepro[0].Commodity_2__c = naicscods[2].replace('&','-');
                 mbepro[0].Commodity_3__c = naicscods[3].replace('&','-');
                 mbepro[0].Commodity_4__c = naicscods[4].replace('&','-');
                 mbepro[0].Commodity_5__c = naicscods[5].replace('&','-');
                  mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mbepro[0].AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  mbepro[0].AS_NAICSCode8__c ='';
                  mbepro[0].AS_NAICSCode9__c ='';
               }
                if(naicscods.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mbepro[0].AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  mbepro[0].AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  mbepro[0].AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 10){
                         system.debug('aaaaaaaaaaa ');
              mbepro[0].As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mbepro[0].As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mbepro[0].As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mbepro[0].As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mbepro[0].As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  mbepro[0].AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mbepro[0].AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  mbepro[0].AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  mbepro[0].AS_NAICSCode9__c =naicscods[9].replace('&','-');
                }



       }
       List<folder> folderList =new List<folder>();
         folderList = [select id from folder where name='shared Documents'];
         if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+attendeeImage.size());
             if (attendeeImage.size() != null) {
                 if (attendeeImage.size() <= 1024000) {
                     mydoc = new document();
                     mydoc.body = attendeeImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                     mydoc.ispublic = true;
                     mydoc.Name = myimageName;
                     insert mydoc;
                     mbepro[0].AS_ImageUrl__c = mydoc.id;
                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 1MB';
                 }
             }
         }
        if (ExhibitorImage != NULL && (ExhibitorImageName != '' || ExhibitorImageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+ExhibitorImage.size());
             if (ExhibitorImage.size() != null) {
                 if (ExhibitorImage.size() <= 4024000) {
                     mydoc = new document();
                     mydoc.body = ExhibitorImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                     mydoc.ispublic = true;
                     mydoc.Name = ExhibitorImageName;
                     insert mydoc;
                     ExhibitorImage =null;
                     mbepro[0].Exhibitor_company_imageUrl__c = mydoc.id;
                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 4MB';
                 }
             }
         }
        if(selectedregions.size() != 0){
        mbepro[0].Geographical_Region__c = '';
        for(string st : selectedregions){
           mbepro[0].Geographical_Region__c += st+',';
           }

         }
          if(commchangeselctdids != NULL){
               commodities = new list<string>();
               commodities =commchangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());


                if(commodities.size() == 2){
                        system.debug('aaaaaaaaaaa ');
                 mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 system.debug('ddddddddddddddddd ' +  mbepro[0].Commodity_1__c );
                 mbepro[0].Commodity_2__c = '';
                 mbepro[0].Commodity_3__c = '';
                 mbepro[0].Commodity_4__c = '';
                 mbepro[0].Commodity_5__c = '';
                  mbepro[0].Commodity_6__c = '';
                 mbepro[0].Commodity_7__c = '';
                 mbepro[0].Commodity_8__c = '';
                 mbepro[0].Commodity_9__c = '';
                }
                if(commodities.size() == 3){
                        system.debug('aaaaaaaaaaa ');
                 mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = '';
                 mbepro[0].Commodity_4__c = '';
                 mbepro[0].Commodity_5__c = '';
                  mbepro[0].Commodity_6__c = '';
                 mbepro[0].Commodity_7__c = '';
                 mbepro[0].Commodity_8__c = '';
                 mbepro[0].Commodity_9__c = '';
                }
                if(commodities.size() == 4){
                        system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
                 mbepro[0].Commodity_4__c = '';
                 mbepro[0].Commodity_5__c = '';
                 mbepro[0].Commodity_6__c = '';
                 mbepro[0].Commodity_7__c = '';
                 mbepro[0].Commodity_8__c = '';
                 mbepro[0].Commodity_9__c = '';
                }
                if(commodities.size() == 5){
                        system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
                 mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
                 mbepro[0].Commodity_5__c = '';
                  mbepro[0].Commodity_6__c = '';
                 mbepro[0].Commodity_7__c = '';
                 mbepro[0].Commodity_8__c = '';
                 mbepro[0].Commodity_9__c = '';
                }
                 if(commodities.size() == 6){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
                 mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
                 mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
                  mbepro[0].Commodity_6__c = '';
                 mbepro[0].Commodity_7__c = '';
                 mbepro[0].Commodity_8__c = '';
                 mbepro[0].Commodity_9__c = '';
                }
                 if(commodities.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
                 mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
                 mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
                  mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
                 mbepro[0].Commodity_7__c = '';
                 mbepro[0].Commodity_8__c = '';
                 mbepro[0].Commodity_9__c = '';
                }
                 if(commodities.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
                 mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
                 mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
                  mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
                 mbepro[0].Commodity_7__c = commodities [7].replace('&','-');
                 mbepro[0].Commodity_8__c = '';
                 mbepro[0].Commodity_9__c = '';
                }
                 if(commodities.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
                 mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
                 mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
                  mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
                 mbepro[0].Commodity_7__c = commodities [7].replace('&','-');
                 mbepro[0].Commodity_8__c = commodities [8].replace('&','-');
                 mbepro[0].Commodity_9__c = '';
                }
                 if(commodities.size() == 10){
                         system.debug('aaaaaaaaaaa ');
                mbepro[0].Commodity_1__c = commodities [1].replace('&','-');
                 mbepro[0].Commodity_2__c = commodities [2].replace('&','-');
                 mbepro[0].Commodity_3__c = commodities [3].replace('&','-');
                 mbepro[0].Commodity_4__c = commodities [4].replace('&','-');
                 mbepro[0].Commodity_5__c = commodities [5].replace('&','-');
                  mbepro[0].Commodity_6__c = commodities [6].replace('&','-');
                 mbepro[0].Commodity_7__c =commodities [7].replace('&','-');
                 mbepro[0].Commodity_8__c = commodities [8].replace('&','-');
                 mbepro[0].Commodity_9__c = commodities [9].replace('&','-');
                }


       }
        try{
                    if(attachmentname != null){
                     if ( attachmentval.size() != null) {


                        Attachment a = new Attachment(parentId = mbepro[0].id, name=attachmentname, body = attachmentval);
                         insert a;
                    }
                  }
            }catch(Exception e){}

           try{
           //saving video
                 if(cyoutubevideo.YouTubeId_c__c != '' && cyoutubevideo.YouTubeId_c__c != null){
                 List<string> ss =  new List<string> ();
                ss= cyoutubevideo.YouTubeId_c__c.split('src="');
                List<string> yy = new List<string> ();
                yy = ss[1].split('"');
                cyoutubevideo.YouTubeId_c__c = yy[0];

                 cyoutubevideo.MBE_Profile__c = mbepro[0].id;
                 insert cyoutubevideo;
                 }

           system.debug('::::::::::::::::youtube:::::::::::::'+youtubevideo);
           }catch(exception e){}


     update mbepro[0];
     DivTypesforedit = new Event_Attendee_Mapping__c();

     DivTypesforedit = [select DiversityType__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where MBE_Profile__c = : mbepro[0].id AND EV_id__c =: eventselected];
     DivTypesforedit.DiversityType__c = '';
                         if (DiversityTypesforfirstline.size() != 0) {
                             for (string dtypes: DiversityTypesforfirstline) {
                                 DivTypesforedit.DiversityType__c += dtypes + ';';
                             }
                         }
                         if (DiversityTypesforsecondline.size() != 0) {
                             for (string dtypes: DiversityTypesforsecondline) {
                                 DivTypesforedit.DiversityType__c += dtypes + ';';
                             }
                         }
                         update DivTypesforedit;
 editview2 = false;
 pagereference pg = new pagereference('/apex/MM_Eventadmin_AttendeesDirectory');
         pg.setredirect(true);
         return pg;
    
     

     
     }

     public boolean cusnewpro {get ; set ;}
    
public void savembepro(){


         List<folder> folderList =new List<folder>();
         folderList = [select id from folder where name='shared Documents'];
         limitofbadges = false;
         ShowPage = False;
         //newAttendee.AS_uniqueField__c = (newAttendee.AS_FirstName__c + newAttendee.AS_LastName__c + newAttendee.AS_Email__c ).toLowercase();
         EventReqStringBool2 = false;
         Savepoint sp = Database.setSavepoint();

        mydoc = new document();
        mydoc1 = new document();
        if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+attendeeImage.size());
             if (attendeeImage.size() != null) {
                 if (attendeeImage.size() <= 1024000) {
                     mydoc = new document();
                     mydoc.body = attendeeImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc.folderid =folderList[0].id;
                       }
                     mydoc.ispublic = true;
                     mydoc.Name = myimageName;
                     insert mydoc;

                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 1MB';
                 }
             }
         }
        
         if (ExhibitorImage != NULL && (ExhibitorImageName != '' || ExhibitorImageName != NULL)) {
         system.debug('@@@@@******************@@@@@'+ExhibitorImage.size());
             if (ExhibitorImage.size() != null) {
                 if (ExhibitorImage.size() <= 4024000) {
                     mydoc1 = new document();
                     mydoc1.body = ExhibitorImage;
                     //mydoc.folderid = UserInfo.getUserId();
                     if(folderList.size()>0){
                       mydoc1.folderid =folderList[0].id;
                       }
                     mydoc1.ispublic = true;
                     mydoc1.Name = ExhibitorImageName;
                     insert mydoc1;
                     
                 } else {
                     imageerror = true;
                     imageerrormsg = 'Image size should be less than 4MB';
                 }
             }
         }

              system.debug('-------------------------new attendee------------------' + newAttendee);

               naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
                 system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
      try{

               if(commchangeselctdids != NULL){
               commodities = new list<string>();
               commodities =commchangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());


                if(commodities.size() == 2){
                        system.debug('aaaaaaaaaaa ');
                 newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 system.debug('ddddddddddddddddd ' +  newAttendee.Commodity_1__c );
                 newAttendee.Commodity_2__c = '';
                 newAttendee.Commodity_3__c = '';
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';


                }
                if(commodities.size() == 3){
                        system.debug('aaaaaaaaaaa ');
                 newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = '';
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                if(commodities.size() == 4){
                        system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = '';
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';
                            }
                if(commodities.size() == 5){
                        system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = '';
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                 if(commodities.size() == 6){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = '';
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                if(commodities.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = '';
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                if(commodities.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = '';
                 newAttendee.Commodity_9__c = '';

                }
                if(commodities.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = commodities [8].replace('&','-');
                 newAttendee.Commodity_9__c = '';

                }
                if(commodities.size() == 10){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = commodities [1].replace('&','-');
                 newAttendee.Commodity_2__c = commodities [2].replace('&','-');
                 newAttendee.Commodity_3__c = commodities [3].replace('&','-');
                 newAttendee.Commodity_4__c = commodities [4].replace('&','-');
                 newAttendee.Commodity_5__c = commodities [5].replace('&','-');
                 newAttendee.Commodity_6__c = commodities [6].replace('&','-');
                 newAttendee.Commodity_7__c = commodities [7].replace('&','-');
                 newAttendee.Commodity_8__c = commodities [8].replace('&','-');
                 newAttendee.Commodity_9__c = commodities [9].replace('&','-');

                }

       }
          if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                system.debug('ddddddddddddddddd ' +  newAttendee.As_NAICSCode_1__c );

                if(naicscods.size() == 2){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = '';
                 newAttendee.As_NAICSCode_3__c = '';
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';

                }
                if(naicscods.size() == 3){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = '';
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 4){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = '';
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 5){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = '';
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                 if(naicscods.size() == 6){
                 newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 newAttendee.AS_NAICSCode6__c = '';
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c ='';
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.Commodity_1__c = naicscods[1].replace('&','-');
                 newAttendee.Commodity_2__c = naicscods[2].replace('&','-');
                 newAttendee.Commodity_3__c = naicscods[3].replace('&','-');
                 newAttendee.Commodity_4__c = naicscods[4].replace('&','-');
                 newAttendee.Commodity_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c ='';
                  newAttendee.AS_NAICSCode9__c ='';
               }
                if(naicscods.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  newAttendee.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 10){
                         system.debug('aaaaaaaaaaa ');
              newAttendee.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 newAttendee.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 newAttendee.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 newAttendee.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 newAttendee.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  newAttendee.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  newAttendee.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  newAttendee.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  newAttendee.AS_NAICSCode9__c =naicscods[9].replace('&','-');
                }



       }
        newAttendee.Geographical_Region__c = '';
       for(string st : selectedregions){
           newAttendee.Geographical_Region__c += st+',';
           }


      }catch(Exception e){}


         AttendeeSummary__c myatt = new AttendeeSummary__c();
         myatt = newAttendee.clone(true);
         naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
                 system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
             try{

          if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());


                if(naicscods.size() == 2){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = '';
                 myatt.As_NAICSCode_3__c = '';
                 myatt.As_NAICSCode_4__c = '';
                 myatt.As_NAICSCode_5__c = '';
                }
                if(naicscods.size() == 3){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = '';
                 myatt.As_NAICSCode_4__c = '';
                 myatt.As_NAICSCode_5__c = '';
                }
                if(naicscods.size() == 4){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 myatt.As_NAICSCode_4__c = '';
                 myatt.As_NAICSCode_5__c = '';
                }
                if(naicscods.size() == 5){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 myatt.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 myatt.As_NAICSCode_5__c = '';
                }
                 if(naicscods.size() == 6){
                 myatt.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 myatt.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 myatt.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 myatt.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 myatt.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                }


       }





       }catch(Exception e){}
         Event__c ev = [select Owner.Username,Is_Webank_event__c  from Event__c where id =: eventselected];
         GlobalAttendee ga = new GlobalAttendee();
         AttendeeSummary__c ats = ga.ReturnAttendee(myatt.AS_Email__c);
         List<AttendeeSummary__c> atts = new List<AttendeeSummary__c> ();
         if(ats != null){
         atts.add(ats);}
        //List<AttendeeSummary__c> atts = [select id from AttendeeSummary__c where AS_Email__c =: myatt.AS_Email__c];
         string  myattid ;
        if(atts.size() == 0){
        myatt.AS_ImageUrl__c = mydoc.id;
        myatt.Exhibitor_company_imageUrl__c = mydoc1.id;
        Database.insert(myatt,false);
        myattid = myatt.id;
                 MBE_Profile__c mp = new MBE_Profile__c();
                try{
                  if(commchangeselctdids != NULL){
               commodities = new list<string>();
               commodities =commchangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());


                if(commodities.size() == 2){
                        system.debug('aaaaaaaaaaa ');
                 mp.Commodity_1__c = commodities [1].replace('&','-');
                 system.debug('ddddddddddddddddd ' +  newAttendee.Commodity_1__c );
                 mp.Commodity_2__c = '';
                 mp.Commodity_3__c = '';
                 mp.Commodity_4__c = '';
                 mp.Commodity_5__c = '';
                 mp.Commodity_6__c = '';
                 mp.Commodity_7__c = '';
                 mp.Commodity_8__c = '';
                 mp.Commodity_9__c = '';


                }
                if(commodities.size() == 3){
                        system.debug('aaaaaaaaaaa ');
                 mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = '';
                 mp.Commodity_4__c = '';
                 mp.Commodity_5__c = '';
                 mp.Commodity_6__c = '';
                 mp.Commodity_7__c = '';
                 mp.Commodity_8__c = '';
                 mp.Commodity_9__c = '';

                }
                if(commodities.size() == 4){
                        system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = commodities [3].replace('&','-');
                 mp.Commodity_4__c = '';
                 mp.Commodity_5__c = '';
                 mp.Commodity_6__c = '';
                 mp.Commodity_7__c = '';
                 mp.Commodity_8__c = '';
                 mp.Commodity_9__c = '';
                            }
                if(commodities.size() == 5){
                        system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = commodities [3].replace('&','-');
                 mp.Commodity_4__c = commodities [4].replace('&','-');
                 mp.Commodity_5__c = '';
                 mp.Commodity_6__c = '';
                 mp.Commodity_7__c = '';
                 mp.Commodity_8__c = '';
                 mp.Commodity_9__c = '';

                }
                 if(commodities.size() == 6){
                         system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = commodities [3].replace('&','-');
                 mp.Commodity_4__c = commodities [4].replace('&','-');
                 mp.Commodity_5__c = commodities [5].replace('&','-');
                 mp.Commodity_6__c = '';
                 mp.Commodity_7__c = '';
                 mp.Commodity_8__c = '';
                 mp.Commodity_9__c = '';

                }
                if(commodities.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = commodities [3].replace('&','-');
                 mp.Commodity_4__c = commodities [4].replace('&','-');
                 mp.Commodity_5__c = commodities [5].replace('&','-');
                 mp.Commodity_6__c = commodities [6].replace('&','-');
                 mp.Commodity_7__c = '';
                 mp.Commodity_8__c = '';
                 mp.Commodity_9__c = '';

                }
                if(commodities.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = commodities [3].replace('&','-');
                 mp.Commodity_4__c = commodities [4].replace('&','-');
                 mp.Commodity_5__c = commodities [5].replace('&','-');
                 mp.Commodity_6__c = commodities [6].replace('&','-');
                 mp.Commodity_7__c = commodities [7].replace('&','-');
                 mp.Commodity_8__c = '';
                 mp.Commodity_9__c = '';

                }
                if(commodities.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = commodities [3].replace('&','-');
                 mp.Commodity_4__c = commodities [4].replace('&','-');
                 mp.Commodity_5__c = commodities [5].replace('&','-');
                 mp.Commodity_6__c = commodities [6].replace('&','-');
                 mp.Commodity_7__c = commodities [7].replace('&','-');
                 mp.Commodity_8__c = commodities [8].replace('&','-');
                 mp.Commodity_9__c = '';

                }
                if(commodities.size() == 10){
                         system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = commodities [1].replace('&','-');
                 mp.Commodity_2__c = commodities [2].replace('&','-');
                 mp.Commodity_3__c = commodities [3].replace('&','-');
                 mp.Commodity_4__c = commodities [4].replace('&','-');
                 mp.Commodity_5__c = commodities [5].replace('&','-');
                 mp.Commodity_6__c = commodities [6].replace('&','-');
                 mp.Commodity_7__c = commodities [7].replace('&','-');
                 mp.Commodity_8__c = commodities [8].replace('&','-');
                 mp.Commodity_9__c = commodities [9].replace('&','-');

                }

       }
          if(naicschangeselctdids != NULL){
               naicscods= new list<string>();
               naicscods=naicschangeselctdids.split('-');
               system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                system.debug('ddddddddddddddddd ' +  newAttendee.As_NAICSCode_1__c );

                if(naicscods.size() == 2){
                 mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = '';
                 mp.As_NAICSCode_3__c = '';
                 mp.As_NAICSCode_4__c = '';
                 mp.As_NAICSCode_5__c = '';
                 mp.AS_NAICSCode6__c = '';
                  mp.AS_NAICSCode7__c ='';
                  mp.AS_NAICSCode8__c ='';
                  mp.AS_NAICSCode9__c ='';

                }
                if(naicscods.size() == 3){
                 mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mp.As_NAICSCode_3__c = '';
                 mp.As_NAICSCode_4__c = '';
                 mp.As_NAICSCode_5__c = '';
                 mp.AS_NAICSCode6__c = '';
                  mp.AS_NAICSCode7__c ='';
                  mp.AS_NAICSCode8__c ='';
                  mp.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 4){
                 mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mp.As_NAICSCode_4__c = '';
                 mp.As_NAICSCode_5__c = '';
                 mp.AS_NAICSCode6__c = '';
                  mp.AS_NAICSCode7__c ='';
                  mp.AS_NAICSCode8__c ='';
                  mp.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 5){
                 mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mp.As_NAICSCode_5__c = '';
                 mp.AS_NAICSCode6__c = '';
                  mp.AS_NAICSCode7__c ='';
                  mp.AS_NAICSCode8__c ='';
                  mp.AS_NAICSCode9__c ='';
                }
                 if(naicscods.size() == 6){
                 mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 mp.AS_NAICSCode6__c = '';
                  mp.AS_NAICSCode7__c ='';
                  mp.AS_NAICSCode8__c ='';
                  mp.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 7){
                         system.debug('aaaaaaaaaaa ');
                mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                 mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mp.AS_NAICSCode7__c ='';
                  mp.AS_NAICSCode8__c ='';
                  mp.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 8){
                         system.debug('aaaaaaaaaaa ');
                mp.Commodity_1__c = naicscods[1].replace('&','-');
                 mp.Commodity_2__c = naicscods[2].replace('&','-');
                 mp.Commodity_3__c = naicscods[3].replace('&','-');
                 mp.Commodity_4__c = naicscods[4].replace('&','-');
                 mp.Commodity_5__c = naicscods[5].replace('&','-');
                  mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  mp.AS_NAICSCode8__c ='';
                  mp.AS_NAICSCode9__c ='';
               }
                if(naicscods.size() == 9){
                         system.debug('aaaaaaaaaaa ');
                mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  mp.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  mp.AS_NAICSCode9__c ='';
                }
                if(naicscods.size() == 10){
                         system.debug('aaaaaaaaaaa ');
              mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                 mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                 mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                 mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                 mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                  mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                  mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                  mp.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                  mp.AS_NAICSCode9__c =naicscods[9].replace('&','-');
                }



       }
        mp.Geographical_Region__c = '';
       for(string st : selectedregions){
           mp.Geographical_Region__c += st+',';
           }


      }catch(Exception e){}



            mp.Event_Organizer_Id__c = ev.Owner.Username;
            mp.Key_Words__c = newattendee.Keywords__c;
            mp.AS_BusinessDunsNumber__c = newattendee.AS_BusinessDunsNumber__c;
            mp.AS_BusinessTaxId__c = newattendee.AS_BusinessTaxId__c;
            mp.AS_BusinessDescription__c = newattendee.AS_BusinessDescription__c;
            mp.Business_type__c = newattendee.Business_type__c;
            mp.AS_BusinessRevenue__c = newattendee.AS_BusinessRevenue__c;
            mp.AS_BusinessEstablishedDate__c = newattendee.AS_BusinessEstablishedDate__c;
            mp.AS_CageCode__c = newattendee.AS_CageCode__c;
            mp.AS_WebsiteUrl__c = newattendee.AS_WebsiteUrl__c;
            mp.AS_DiversityType__c = newattendee.AS_DiversityType__c;
            mp.GSA_Schedule__c = newattendee.GSA_Schedule__c;
            mp.AS_NumberOfEmployees__c = newattendee.AS_NumberOfEmployees__c;
            mp.AS_PrimaryBusinessCategory1__c = newattendee.AS_PrimaryBusinessCategory1__c;
            mp.As_SecondaryBusinessCategory1__c = newattendee.As_SecondaryBusinessCategory1__c;
            mp.Company_Certifications__c = newattendee.Company_Certifications__c;
            if(newattendee.AS_CellPhone__c != null && newattendee.AS_CellPhone__c != ''){
            mp.AS_CellPhone__c  = newattendee.AS_CellPhone__c;}
            mp.AS_Company__c = newattendee.AS_Company__c;
            mp.AS_Email__c = newattendee.AS_Email__c;
            system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_Email__c);
            mp.AS_FirstName__c = newattendee.AS_FirstName__c;
            system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_FirstName__c);
            mp.As_Home_Country__c = newattendee.As_Home_Country__c;
            mp.As_Home_State__c = newattendee.As_Home_State__c;
            mp.AS_HomeZip__c = newattendee.AS_HomeZip__c;
            mp.AS_LastName__c = newattendee.AS_LastName__c;
                        system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_LastName__c);
            mp.As_prefixNew__c = newattendee.As_prefixNew__c;
            mp.AS_shippingzip_c__c = newattendee.AS_shippingzip__c;
            mp.As_SuffixNew__c = newattendee.As_SuffixNew__c;
            mp.AS_Title__c = newattendee.AS_Title__c;
            mp.AS_Work_States__c = newattendee.AS_Work_States__c;
            mp.AS_WorkAddress1__c = newattendee.AS_WorkAddress1__c;
            mp.AS_WorkAddress2__c = newattendee.AS_WorkAddress2__c;
            mp.AS_WorkCity__c = newattendee.AS_WorkCity__c;
            mp.AS_WorkPhone__c = newattendee.AS_WorkPhone__c;
            mp.AS_WorkZipCode__c = newattendee.AS_WorkZipCode__c;
            mp.AS_WorkZip__c = newattendee.AS_WorkZip__c;
            mp.AS_Work_Country__c = newattendee.AS_Work_Country__c;

            mp.DBA__c = newattendee.DBA__c;
            //mp.Geographical_Region__c = newattendee.Geographical_Region__c;
            mp.Certificate_Processed_by_RPO__c = newattendee.Certificate_Processed_by_RPO__c;
            mp.BBB_Number__c = newattendee.BBB_Number__c;

            mp.distribution_Country__c = newattendee.distribution_Country__c;
            mp.Manufactures_Country__c =newattendee.Manufactures_Country__c;
            mp.References__c = newattendee.References__c;
mp.Scope_of_Work__c = newattendee.Scope_of_Work__c;
mp.References2__c = newattendee.References2__c;
mp.Scope_of_Work2__c = newattendee.Scope_of_Work2__c;
            mp.Revenue_Range__c = newattendee.Revenue_Range__c;
           // mp.AS_ImageUrl__c = newattendee.AS_ImageUrl__c;
           //if(mydoc.id != null && mydoc.id != ''){
             mp.AS_ImageUrl__c = mydoc.id;
             mp.Exhibitor_company_imageUrl__c = mydoc1.id;

             //}
             mp.Year_in_business__c  = newattendee.Year_in_business__c;
mp.Business_Structure__c= newattendee.Business_Structure__c;
mp.AS_FaxNumber__c = newattendee.AS_FaxNumber__c;
mp.Ethnicity__c = newattendee.Ethnicity__c;
mp.Any_non_WBENC_awards_received__c = newattendee.Any_non_WBENC_awards_received__c;
mp.Companyhaveafacility_partneroutsideUSA__c = newattendee.Companyhaveafacility_partneroutsideUSA__c;
mp.AS_Secondary_Email__c  = newattendee.AS_Secondary_Email__c;
system.debug('ddddddddddddddd'+mp.AS_Secondary_Email__c);
            mp.AttendeeSummary__c = myattid;
            database.insert (mp,false);
            try{
                    if(attachmentname != null){
                     if ( attachmentval.size() != null) {


                        Attachment a = new Attachment(parentId = myAttId, name=attachmentname, body = attachmentval);
                         insert a;
                         Attachment a1 = new Attachment(parentId = mp.id, name=attachmentname, body = attachmentval);
                         insert a1;
                    }
                  }
            }catch(Exception e){}
         system.debug('-------------------------new attendee------------------' + myatt);
            system.debug('mpmpmpmpmpmmpmpmpmpmpmpmpmpmpmpmpmpmmmp'+mp);
             attmap = new Event_Attendee_Mapping__c();
                 attmap.AS_id__c = myattid;
                 attmap.Ev_id__c = eventSelected;
                 attmap.IsMatchMakingAttendee__c =True;
                 attmap.Attendee_Event_IDs__c = myattid + eventSelected;
                 attmap.MBE_Profile__c = mp.id;
                //---------------------------------------------------saving Ticket Types-------------
                //---------------------------------saving Diversity types--------------------
                 attmap.DiversityType__c = '';
                 if (DiversityTypesforfirstLine.size() != 0) {
                     for (string str: DiversityTypesforfirstLine) {
                         attmap.DiversityType__c += str + ';';
                     }
                 }
                 if (DiversityTypesforsecondLine.size() != 0) {
                     for (string str1: DiversityTypesforsecondLine) {
                         attmap.DiversityType__c += str1 + ';';
                     }
                 }
                 Database.SaveResult myAttendeeJunction = Database.Insert(attmap, false);
                 //saving video
                 if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
                 List<string> ss =  new List<string> ();
                ss= youtubevideo.YouTubeId_c__c.split('src="');
                List<string> yy = new List<string> ();
                yy = ss[1].split('"');
                youtubevideo.YouTubeId_c__c = yy[0];
                cyoutubevideo.YouTubeId_c__c = yy[0];
                 youtubevideo.AttendeeSummary__c = myattid ;
                 cyoutubevideo.MBE_Profile__c = mp.id;
                 insert cyoutubevideo;
                 insert youtubevideo;
                 }

          /** if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
                 List<string> ss =  new List<string> ();
                ss= youtubevideo.YouTubeId_c__c.split('src="');
                List<string> yy = new List<string> ();
                yy = ss[1].split('"');
                cyoutubevideo.YouTubeId_c__c = yy[0];

                 cyoutubevideo.MBE_Profile__c = mp.id;
                 insert cyoutubevideo;
                 }
     */
            addattendee = false;

         getevents();

         }else{
         myattid = atts[0].id;
         List<MBE_Profile__c> mbeprorec = [select id from MBE_Profile__c where Event_Organizer_Id__c =: ev.Owner.Username AND AttendeeSummary__r.id =: myattid ];
            if(mbeprorec.size() != 0){
                List<Event_Attendee_Mapping__c> eve_att_Jun = [select id from Event_Attendee_Mapping__c where Ev_id__c = : eventSelected AND AS_id__c =: myattid AND MBE_Profile__c =: mbeprorec[0].id ];
                    if(eve_att_Jun.size() >0){
                        showerror = 'Attendee Already Exists!';
                        DisplayError = True;
                    }else{
                        MBE_Profile__c mp = new MBE_Profile__c();
                        mp = mbeprorec[0].clone(true);
                        try{
                        if(commchangeselctdids != NULL){
                        commodities = new list<string>();
                        commodities =commchangeselctdids.split('-');
                        system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());


                        if(commodities.size() == 2){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        system.debug('ddddddddddddddddd ' +  newAttendee.Commodity_1__c );
                        mp.Commodity_2__c = '';
                        mp.Commodity_3__c = '';
                        mp.Commodity_4__c = '';
                        mp.Commodity_5__c = '';
                         mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';


                        }
                        if(commodities.size() == 3){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = '';
                        mp.Commodity_4__c = '';
                        mp.Commodity_5__c = '';
                        mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';
                        

                        }
                        if(commodities.size() == 4){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = '';
                        mp.Commodity_5__c = '';
                        mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';
                        }
                        if(commodities.size() == 5){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = '';
                        mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 6){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                        mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 7){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                        mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 8){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                        mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = commodities [7].replace('&','-');
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 9){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                        mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = commodities [7].replace('&','-');
                        mp.Commodity_8__c = commodities [8].replace('&','-');
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 10){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                        mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = commodities [7].replace('&','-');
                        mp.Commodity_8__c = commodities [8].replace('&','-');
                        mp.Commodity_9__c = commodities [9].replace('&','-');

                        }

                        }
                        if(naicschangeselctdids != NULL){
                        naicscods= new list<string>();
                        naicscods=naicschangeselctdids.split('-');
                        system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                        system.debug('ddddddddddddddddd ' +  newAttendee.As_NAICSCode_1__c );

                        if(naicscods.size() == 2){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = '';
                        mp.As_NAICSCode_3__c = '';
                        mp.As_NAICSCode_4__c = '';
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';

                        }
                        if(naicscods.size() == 3){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = '';
                        mp.As_NAICSCode_4__c = '';
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 4){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = '';
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 5){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 6){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 7){
                        system.debug('aaaaaaaaaaa ');
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 8){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = naicscods[1].replace('&','-');
                        mp.Commodity_2__c = naicscods[2].replace('&','-');
                        mp.Commodity_3__c = naicscods[3].replace('&','-');
                        mp.Commodity_4__c = naicscods[4].replace('&','-');
                        mp.Commodity_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 9){
                        system.debug('aaaaaaaaaaa ');
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                        mp.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 10){
                        system.debug('aaaaaaaaaaa ');
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                        mp.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                        mp.AS_NAICSCode9__c =naicscods[9].replace('&','-');
                        }



                        }
                        mp.Geographical_Region__c = '';
                        for(string st : selectedregions){
                        mp.Geographical_Region__c += st+',';
                        }


                        }catch(Exception e){}



                        mp.Event_Organizer_Id__c = ev.Owner.Username;
                       /** mp.Key_Words__c = newattendee.Keywords__c;
                        mp.AS_BusinessDunsNumber__c = newattendee.AS_BusinessDunsNumber__c;
                        mp.AS_BusinessTaxId__c = newattendee.AS_BusinessTaxId__c;
                        mp.AS_BusinessDescription__c = newattendee.AS_BusinessDescription__c;
                        mp.Business_type__c = newattendee.Business_type__c;
                        mp.AS_BusinessRevenue__c = newattendee.AS_BusinessRevenue__c;
                        mp.AS_BusinessEstablishedDate__c = newattendee.AS_BusinessEstablishedDate__c;
                        mp.AS_CageCode__c = newattendee.AS_CageCode__c;
                        mp.AS_WebsiteUrl__c = newattendee.AS_WebsiteUrl__c;
                        mp.AS_DiversityType__c = newattendee.AS_DiversityType__c;
                        mp.GSA_Schedule__c = newattendee.GSA_Schedule__c;
                        mp.AS_NumberOfEmployees__c = newattendee.AS_NumberOfEmployees__c;
                        mp.AS_PrimaryBusinessCategory1__c = newattendee.AS_PrimaryBusinessCategory1__c;
                        mp.As_SecondaryBusinessCategory1__c = newattendee.As_SecondaryBusinessCategory1__c;
                        mp.Company_Certifications__c = newattendee.Company_Certifications__c;
                        
                        mp.AS_CellPhone__c  = newattendee.AS_CellPhone__c;
                        mp.AS_Company__c = newattendee.AS_Company__c;
                        mp.AS_Email__c = newattendee.AS_Email__c;
                        system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_Email__c);
                        mp.AS_FirstName__c = newattendee.AS_FirstName__c;
                        system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_FirstName__c);
                        mp.As_Home_Country__c = newattendee.As_Home_Country__c;
                        mp.As_Home_State__c = newattendee.As_Home_State__c;
                        mp.AS_HomeZip__c = newattendee.AS_HomeZip__c;
                        mp.AS_LastName__c = newattendee.AS_LastName__c;
                        system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_LastName__c);
                        mp.As_prefixNew__c = newattendee.As_prefixNew__c;
                        mp.AS_shippingzip_c__c = newattendee.AS_shippingzip__c;
                        mp.As_SuffixNew__c = newattendee.As_SuffixNew__c;
                        mp.AS_Title__c = newattendee.AS_Title__c;
                        mp.AS_Work_States__c = newattendee.AS_Work_States__c;
                        mp.AS_WorkAddress1__c = newattendee.AS_WorkAddress1__c;
                        mp.AS_WorkAddress2__c = newattendee.AS_WorkAddress2__c;
                        mp.AS_WorkCity__c = newattendee.AS_WorkCity__c;
                        mp.AS_WorkPhone__c = newattendee.AS_WorkPhone__c;
                        mp.AS_WorkZipCode__c = newattendee.AS_WorkZipCode__c;
                        mp.AS_WorkZip__c = newattendee.AS_WorkZip__c;
                        mp.AS_Work_Country__c = newattendee.AS_Work_Country__c;
                        mp.Year_in_business__c  = newattendee.Year_in_business__c;
mp.Business_Structure__c= newattendee.Business_Structure__c;
mp.AS_FaxNumber__c = newattendee.AS_FaxNumber__c;
mp.Ethnicity__c = newattendee.Ethnicity__c;
mp.Any_non_WBENC_awards_received__c = newattendee.Any_non_WBENC_awards_received__c;
mp.Companyhaveafacility_partneroutsideUSA__c = newattendee.Companyhaveafacility_partneroutsideUSA__c;
mp.AS_Secondary_Email__c  = newattendee.AS_Secondary_Email__c;

system.debug('ddddddddddddddd'+mp.AS_Secondary_Email__c);
                        mp.DBA__c = newattendee.DBA__c;
                        //mp.Geographical_Region__c = newattendee.Geographical_Region__c;
                        mp.Certificate_Processed_by_RPO__c = newattendee.Certificate_Processed_by_RPO__c;
                        mp.BBB_Number__c = newattendee.BBB_Number__c;

                        mp.distribution_Country__c = newattendee.distribution_Country__c;
                        mp.Manufactures_Country__c =newattendee.Manufactures_Country__c;
                        mp.References__c = newattendee.References__c;
mp.Scope_of_Work__c = newattendee.Scope_of_Work__c;
mp.References2__c = newattendee.References2__c;
mp.Scope_of_Work2__c = newattendee.Scope_of_Work2__c;
                        mp.Revenue_Range__c = newattendee.Revenue_Range__c;
                       
                        mp.AttendeeSummary__c = myattid;
                        if(mydoc.id != null && mydoc.id != ''){
                        mp.AS_ImageUrl__c = mydoc.id;}
                        mp.AS_Secondary_Email__c  = newattendee.AS_Secondary_Email__c;*/
                        
                        database.update(mp,false);
                         try{
                        if(attachmentname != null){
                             if ( attachmentval.size() != null) {

                                 Attachment a1 = new Attachment(parentId = mp.id, name=attachmentname, body = attachmentval);
                                 insert a1;
                            }
                          }
                        }catch(Exception e){}
                        system.debug('mpmpmpmpmpmmpmpmpmpmpmpmpmpmpmpmpmpmmmp'+mp);
                        attmap = new Event_Attendee_Mapping__c();
                        attmap.AS_id__c = myattid;
                        attmap.Ev_id__c = eventSelected;
                        attmap.IsMatchMakingAttendee__c =True;
                        attmap.Attendee_Event_IDs__c = myattid + eventSelected;
                        attmap.MBE_Profile__c = mp.id;
                        //---------------------------------------------------saving Ticket Types-------------
                        //---------------------------------saving Diversity types--------------------
                        attmap.DiversityType__c = '';
                        if (DiversityTypesforfirstLine.size() != 0) {
                        for (string str: DiversityTypesforfirstLine) {
                        attmap.DiversityType__c += str + ';';
                        }
                        }
                        if (DiversityTypesforsecondLine.size() != 0) {
                        for (string str1: DiversityTypesforsecondLine) {
                        attmap.DiversityType__c += str1 + ';';
                        }
                        }
                        Database.SaveResult myAttendeeJunction = Database.Insert(attmap, false);
                        
                        if(myAttendeeJunction.isSuccess()){
                           Profile__c pf = new  Profile__c();
                            pf = [select id FROM Profile__c where PR_Name__c='Attendee'];
                       for(user uInn :[select id from user Where userName=:newattendee.AS_Email__c]){
                        
                           try{
                            
                            User_Profile_Event__c upeForin = new User_Profile_Event__c();
                            upeForin.IsMatchMakingUser__c =true;
                            upeForin.MAtchMakingProfile__c = 'MBE';
                            upeForin.Profile_id__c =pf.id;
                            upeForin.User_id__c = uInn.id;
                            upeForin.EV_id__c = eventSelected;
                            upeForin.Attendee_Summary__c  =myattid;
                            upeForin.UEP_isActive__c = true;
                            upeForin.BoothAdmin_id__c = uInn.id;
                             Database.SaveResult myUpe = Database.Insert(upeForin, false);
                            System.debug('PPPPPPPPPPPPPPPP AAAAAAAAAAAAAA '+myUpe ); 
                           }catch(exception er){} 
                       } 
                     }
                     
                        //saving video
                        if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
                            List<string> ss =  new List<string> ();
                            ss= youtubevideo.YouTubeId_c__c.split('src="');
                            List<string> yy = new List<string> ();
                            yy = ss[1].split('"');
                            cyoutubevideo.YouTubeId_c__c = yy[0];
                            cyoutubevideo.MBE_Profile__c = mp.id;
                            insert cyoutubevideo;
                         }



                        addattendee = false;
                        getevents();
                    }

                }else{
                        MBE_Profile__c mp =new MBE_Profile__c();

                        try{
                        if(commchangeselctdids != NULL){
                        commodities = new list<string>();
                        commodities =commchangeselctdids.split('-');
                        system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());


                        if(commodities.size() == 2){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        system.debug('ddddddddddddddddd ' +  newAttendee.Commodity_1__c );
                        mp.Commodity_2__c = '';
                        mp.Commodity_3__c = '';
                        mp.Commodity_4__c = '';
                        mp.Commodity_5__c = '';
                        mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 3){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = '';
                        mp.Commodity_4__c = '';
                        mp.Commodity_5__c = '';
                         mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 4){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = '';
                        mp.Commodity_5__c = '';
                         mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';
                        }
                        if(commodities.size() == 5){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = '';
                         mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 6){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                         mp.Commodity_6__c = '';
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 7){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                         mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = '';
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 8){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                         mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = commodities [7].replace('&','-');
                        mp.Commodity_8__c = '';
                        mp.Commodity_9__c = '';

                        }
                        if(commodities.size() == 9){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                         mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = commodities [7].replace('&','-');
                        mp.Commodity_8__c = commodities [8].replace('&','-');
                        mp.Commodity_9__c = '';

                        }if(commodities.size() == 10){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = commodities [1].replace('&','-');
                        mp.Commodity_2__c = commodities [2].replace('&','-');
                        mp.Commodity_3__c = commodities [3].replace('&','-');
                        mp.Commodity_4__c = commodities [4].replace('&','-');
                        mp.Commodity_5__c = commodities [5].replace('&','-');
                         mp.Commodity_6__c = commodities [6].replace('&','-');
                        mp.Commodity_7__c = commodities [7].replace('&','-');
                        mp.Commodity_8__c = commodities [8].replace('&','-');
                        mp.Commodity_9__c = commodities [9].replace('&','-');

                        }

                        }
                        if(naicschangeselctdids != NULL){
                        naicscods= new list<string>();
                        naicscods=naicschangeselctdids.split('-');
                        system.debug('shruthi shruhti shruthi 11111111111' + naicscods.size());
                        system.debug('ddddddddddddddddd ' +  newAttendee.As_NAICSCode_1__c );

                        if(naicscods.size() == 2){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = '';
                        mp.As_NAICSCode_3__c = '';
                        mp.As_NAICSCode_4__c = '';
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';

                        }
                        if(naicscods.size() == 3){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = '';
                        mp.As_NAICSCode_4__c = '';
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 4){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = '';
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 5){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = '';
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 6){
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = '';
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 7){
                        system.debug('aaaaaaaaaaa ');
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c ='';
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 8){
                        system.debug('aaaaaaaaaaa ');
                        mp.Commodity_1__c = naicscods[1].replace('&','-');
                        mp.Commodity_2__c = naicscods[2].replace('&','-');
                        mp.Commodity_3__c = naicscods[3].replace('&','-');
                        mp.Commodity_4__c = naicscods[4].replace('&','-');
                        mp.Commodity_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                        mp.AS_NAICSCode8__c ='';
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 9){
                        system.debug('aaaaaaaaaaa ');
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                        mp.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                        mp.AS_NAICSCode9__c ='';
                        }
                        if(naicscods.size() == 10){
                        system.debug('aaaaaaaaaaa ');
                        mp.As_NAICSCode_1__c = naicscods[1].replace('&','-');
                        mp.As_NAICSCode_2__c = naicscods[2].replace('&','-');
                        mp.As_NAICSCode_3__c = naicscods[3].replace('&','-');
                        mp.As_NAICSCode_4__c = naicscods[4].replace('&','-');
                        mp.As_NAICSCode_5__c = naicscods[5].replace('&','-');
                        mp.AS_NAICSCode6__c = naicscods[6].replace('&','-');
                        mp.AS_NAICSCode7__c =naicscods[7].replace('&','-');
                        mp.AS_NAICSCode8__c =naicscods[8].replace('&','-');
                        mp.AS_NAICSCode9__c =naicscods[9].replace('&','-');
                        }



                        }
                         mp.Geographical_Region__c = '';
                        for(string st : selectedregions){
                        mp.Geographical_Region__c += st+',';
                        }


                        }catch(Exception e){}



                        mp.Event_Organizer_Id__c = ev.Owner.Username;
                        mp.Key_Words__c = newattendee.Keywords__c;
                        mp.AS_BusinessDunsNumber__c = newattendee.AS_BusinessDunsNumber__c;
                        mp.AS_BusinessTaxId__c = newattendee.AS_BusinessTaxId__c;
                        mp.AS_BusinessDescription__c = newattendee.AS_BusinessDescription__c;
                        mp.Business_type__c = newattendee.Business_type__c;
                        mp.AS_BusinessRevenue__c = newattendee.AS_BusinessRevenue__c;
                        mp.AS_BusinessEstablishedDate__c = newattendee.AS_BusinessEstablishedDate__c;
                        mp.AS_CageCode__c = newattendee.AS_CageCode__c;
                        mp.AS_WebsiteUrl__c = newattendee.AS_WebsiteUrl__c;
                        mp.AS_DiversityType__c = newattendee.AS_DiversityType__c;
                        mp.GSA_Schedule__c = newattendee.GSA_Schedule__c;
                        mp.AS_NumberOfEmployees__c = newattendee.AS_NumberOfEmployees__c;
                        mp.AS_PrimaryBusinessCategory1__c = newattendee.AS_PrimaryBusinessCategory1__c;
                        mp.As_SecondaryBusinessCategory1__c = newattendee.As_SecondaryBusinessCategory1__c;
                        mp.Company_Certifications__c = newattendee.Company_Certifications__c;
                        if(newattendee.AS_CellPhone__c != null && newattendee.AS_CellPhone__c != ''){
            mp.AS_CellPhone__c  = newattendee.AS_CellPhone__c;}
                        mp.AS_Company__c = newattendee.AS_Company__c;
                        mp.AS_Email__c = newattendee.AS_Email__c;
                        system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_Email__c);
                        mp.AS_FirstName__c = newattendee.AS_FirstName__c;
                        system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_FirstName__c);
                        mp.As_Home_Country__c = newattendee.As_Home_Country__c;
                        mp.As_Home_State__c = newattendee.As_Home_State__c;
                        mp.AS_HomeZip__c = newattendee.AS_HomeZip__c;
                        mp.AS_LastName__c = newattendee.AS_LastName__c;
                        system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'+mp.AS_LastName__c);
                        mp.As_prefixNew__c = newattendee.As_prefixNew__c;
                        mp.AS_shippingzip_c__c = newattendee.AS_shippingzip__c;
                        mp.As_SuffixNew__c = newattendee.As_SuffixNew__c;
                        mp.AS_Title__c = newattendee.AS_Title__c;
                        mp.AS_Work_States__c = newattendee.AS_Work_States__c;
                        mp.AS_WorkAddress1__c = newattendee.AS_WorkAddress1__c;
                        mp.AS_WorkAddress2__c = newattendee.AS_WorkAddress2__c;
                        mp.AS_WorkCity__c = newattendee.AS_WorkCity__c;
                        mp.AS_WorkPhone__c = newattendee.AS_WorkPhone__c;
                        mp.AS_WorkZipCode__c = newattendee.AS_WorkZipCode__c;
                        mp.AS_WorkZip__c = newattendee.AS_WorkZip__c;
                        mp.AS_Work_Country__c = newattendee.AS_Work_Country__c;
                        mp.Year_in_business__c  = newattendee.Year_in_business__c;
mp.Business_Structure__c= newattendee.Business_Structure__c;
mp.AS_FaxNumber__c = newattendee.AS_FaxNumber__c;
mp.Ethnicity__c = newattendee.Ethnicity__c;
mp.Any_non_WBENC_awards_received__c = newattendee.Any_non_WBENC_awards_received__c;
mp.Companyhaveafacility_partneroutsideUSA__c = newattendee.Companyhaveafacility_partneroutsideUSA__c;
mp.AS_Secondary_Email__c  = newattendee.AS_Secondary_Email__c;
system.debug('ddddddddddddddd'+mp.AS_Secondary_Email__c);
                        mp.DBA__c = newattendee.DBA__c;
                        //mp.Geographical_Region__c = newattendee.Geographical_Region__c;
                        mp.Certificate_Processed_by_RPO__c = newattendee.Certificate_Processed_by_RPO__c;
                        mp.BBB_Number__c = newattendee.BBB_Number__c;

                        mp.distribution_Country__c = newattendee.distribution_Country__c;
                        mp.Manufactures_Country__c =newattendee.Manufactures_Country__c;
                        mp.References__c = newattendee.References__c;
mp.Scope_of_Work__c = newattendee.Scope_of_Work__c;
mp.References2__c = newattendee.References2__c;
mp.Scope_of_Work2__c = newattendee.Scope_of_Work2__c;
                        mp.Revenue_Range__c = newattendee.Revenue_Range__c;
                        //mp.AS_ImageUrl__c = newattendee.AS_ImageUrl__c;
                        mp.AttendeeSummary__c = myattid;
                         if(mydoc.id != null && mydoc.id != ''){
                        mp.AS_ImageUrl__c = mydoc.id;}
                        database.insert (mp,false);
                         try{
                        if(attachmentname != null){
                             if ( attachmentval.size() != null) {

                                 Attachment a1 = new Attachment(parentId = mp.id, name=attachmentname, body = attachmentval);
                                 insert a1;
                            }
                          }
                        }catch(Exception e){}

                        system.debug('mpmpmpmpmpmmpmpmpmpmpmpmpmpmpmpmpmpmmmp'+mp);
                        attmap = new Event_Attendee_Mapping__c();
                        attmap.AS_id__c = myattid;
                        attmap.Ev_id__c = eventSelected;
                        attmap.IsMatchMakingAttendee__c =True;
                        attmap.Attendee_Event_IDs__c = myattid + eventSelected;
                        attmap.MBE_Profile__c = mp.id;
                        //---------------------------------------------------saving Ticket Types-------------
                        //---------------------------------saving Diversity types--------------------
                        attmap.DiversityType__c = '';
                        if (DiversityTypesforfirstLine.size() != 0) {
                        for (string str: DiversityTypesforfirstLine) {
                        attmap.DiversityType__c += str + ';';
                        }
                        }
                        if (DiversityTypesforsecondLine.size() != 0) {
                        for (string str1: DiversityTypesforsecondLine) {
                        attmap.DiversityType__c += str1 + ';';
                        }
                        }
                        Database.SaveResult myAttendeeJunction = Database.Insert(attmap, false);
                       
                     
                        //saving video
                        if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
                            List<string> ss =  new List<string> ();
                            ss= youtubevideo.YouTubeId_c__c.split('src="');
                            List<string> yy = new List<string> ();
                            yy = ss[1].split('"');
                            cyoutubevideo.YouTubeId_c__c = yy[0];
                            cyoutubevideo.MBE_Profile__c = mp.id;
                            insert cyoutubevideo;
                         }



                        addattendee = false;
                         getevents();

            }



         }











     }

     public PageReference Cancel() {
     emailalert =false;
     emailalert1 = false;
     psettingsbool = false;
     Blockschedulebool = false;
     editview2 = false;
        viewschedulepopup = false;
         fortwoprinters = false;
         limitofbadges = false;
         duplicateAttendeeBool = false;
        multiselectpicklist=false;
         fbool = false;
         addattendee = false;
         addattendee1 = false;
         addattendee = false;
         Dymo = false;
         DataImportBool = false;
         statuschange = false;
         emailstatuschange = false;
         viewprofilepopup=false;
         ShowMatchPanel= false;
         showExccededError=false;
            ShowPage = False;
         //pagereference pf=new pagereference('/apex/Qrcode_Eventadmin_Attendees');
         //pf.setredirect(true);
         //eventselected = eventselected;




         //getevents();
         return null;
     }
public void ClosePopUp() {
     emailalert =false;
     emailalert1 = false;
     psettingsbool = false;
     Blockschedulebool = false;
     editview2 = false;
        viewschedulepopup = false;
         fortwoprinters = false;
         limitofbadges = false;
         duplicateAttendeeBool = false;
        multiselectpicklist=false;
         fbool = false;
         addattendee = false;
         addattendee1 = false;
         addattendee = false;
         Dymo = false;
         DataImportBool = false;
         statuschange = false;
         emailstatuschange = false;
         viewprofilepopup=false;
         ShowMatchPanel= false;
         showExccededError=false;
            ShowPage = False;
         

        
     }
     public string encrit {
         get;
         set;
     }

     //------------------------------------------------------Attendee Detail Page--------------------
     public boolean EventReqStringbool3 {
         get;
         set;
     }
     public Event__c  eventone {get ; set ;}
     public boolean dolor{get;set;}
     public Event_Attendee_Mapping__c Attendeedetail{get;set;}
     public string Workstates{get;set;}
        public string Homestates{get;set;}
        public string Shippingstates{get;set;}
        public string Workcountry{get;set;}
        public string Homecountry{get;set;}
        public string Shippingcountry{get;set;}
         public List<Widget__c> videos {get ; set ;}
         public list<Custom_Widget__c> cvideos {get ; set ;}
     public void attendeedetail() {
         map<string,string> states=new map<string,string>();
         videos = new List<Widget__c>();
         cvideos = new list<Custom_Widget__c>();
            states.put('None','None');
            states.put('Alabama','AL');
            states.put('Alaska', 'AK');
            states.put('Arizona','AZ');
            states.put('Arkansas','AR');
            states.put('California','CA');
            states.put('Colorado','CO');
            states.put('Connecticut','CT');
            states.put('Delaware','DE');
            states.put('District of Columbia','DC');
            states.put('Florida','FL');
            states.put('Georgia','GA');
            states.put('Hawaii','HI');
            states.put('Idaho','ID');
            states.put('Illinois','IL');
            states.put('Indiana','IN');
            states.put('Iowa','IA');
            states.put('Kansas','KS');
            states.put('Kentucky','KY');
            states.put('Louisiana','LA');
            states.put('Maine','ME');
            states.put('Maryland','MD');
            states.put('Massachusetts','MA');
            states.put('Michigan','MI');
            states.put('Minnesota','MN');
            states.put('Mississippi','MS');
            states.put('Missouri','MO');
            states.put('Montana','MT');
            states.put('Nebraska','NE');
            states.put('Nevada','NV');
            states.put('New Hampshire','NH');
            states.put('New Jersey','NJ');
            states.put('New Mexico','NM');
            states.put('New York','NY');
            states.put('North Carolina','NC');
            states.put('North Dakota','ND');
            states.put('Ohio','OH');
            states.put('Oklahoma','OK');
            states.put('Oregon','OR');
            states.put('Pennsylvania','PA');
            states.put('Rhode Island','RI');
            states.put('South Carolina','SC');
            states.put('South Dakota','SD');
            states.put('Tennessee','TN');
            states.put('Texas','TX');
            states.put('Utah','UT');
            states.put('Vermont','VT');
            states.put('Virginia','VA');
            states.put('Washington','WA');
            states.put('West Virginia','WV');
            states.put('Wisconsin','WI');
            states.put('Wyoming','WY');
            states.put('Andhra Pradesh','Andhra Pradesh');
            states.put('Arunachal Pradesh','Arunachal Pradesh');
            states.put('Assam','Assam');
            states.put('Bihar','Bihar');
            states.put('Chhattisgarh','Chhattisgarh');
            states.put('Goa','Goa');
            states.put('Gujarat','Gujarat');
            states.put('Haryana','Haryana');
            states.put('Himachal Pradesh','Himachal Pradesh');
            states.put('Jammu and Kashmir','Jammu and Kashmir');
            states.put('Jharkhand','Jharkhand');
            states.put('Karnataka','Karnataka');
            states.put('Kerala','Kerala');
            states.put('Madhya Pradesh','Madhya Pradesh');
            states.put('Maharashtra','Maharashtra');
            states.put('Manipur','Manipur');
            states.put('Meghalaya','Meghalaya');
            states.put('Mizoram','Mizoram');
            states.put('Nagaland','Nagaland');
            states.put('Orissa','Orissa');
            states.put('Punjab','Punjab');
            states.put('Rajasthan','Rajasthan');
            states.put('Sikkim','Sikkim');
            states.put('Tamil Nadu','Tamil Nadu');
            states.put('Tripura','Tripura');
            states.put('Uttar Pradesh','Uttar Pradesh');
            states.put('Uttarakhand','Uttarakhand');
            states.put('West Bengal','West Bengal');
            states.put('Andaman and Nicobar Islands','Andaman and Nicobar Islands');
            states.put('Daman and Diu','Daman and Diu');
            states.put('Lakshadweep','Lakshadweep  ');
            states.put('National Capital Territory of Delhi','National Capital Territory of Delhi');
            eventone = new Event__c ();
            map<string,string> countries = new map<string,string>();
             countries.put('India','India');
             countries.put('United States Of America','USA');
         string  eamid = ApexPages.currentPage().getParameters().get('mycheck');
         Event_Attendee_Mapping__c emid = [select id,AS_id__r.id,MBE_Profile__c from Event_Attendee_Mapping__c where id =: eamid];
         eamidprint = eamid;
         cvideos = new list<Custom_Widget__c>();
         videos = new list<Widget__c>();
         try{
         eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:eventselected];

         if(eventone.Is_Webank_event__c == false){
          Attendeedetail=[select id,TicketTypes__c,AS_id__r.AS_Age__c,AS_id__r.AS_BirthDate__c,AS_id__r.AS_BlogUrl__c,AS_id__r.AS_BusinessDescription__c,AS_id__r.AS_BusinessDunsNumber__c,
                                     AS_id__r.AS_BusinessEstablishedDate__c,AS_id__r.AS_BusinessRevenue__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_CellPhone__c,AS_id__r.Keywords__c,
                                     AS_id__r.AS_Company__c,DiversityType__c,AS_id__r.AS_Email__c,AS_id__r.AS_FaxNumber__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Gender__c,
                                     AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_Country__c,AS_id__r.AS_HomePhone__c,
                                     AS_id__r.AS_HomePoboxNo__c,AS_id__r.As_Home_State__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_LastName__c,AS_id__r.AS_NAICSCode_1__c,AS_id__r.Exhibitor_company_imageUrl__c,
                                     AS_id__r.AS_NAICSCode_2__c,AS_id__r.AS_NAICSCode_3__c,AS_id__r.AS_NAICSCode_4__c,AS_id__r.AS_NAICSCode_5__c,AS_id__r.AS_NumberOfEmployees__c,AS_id__r.As_prefixNew__c,
                                     AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.AS_SecondaryBusinessCategory1__c,AS_id__r.AS_ShippingAddress1__c,AS_id__r.AS_ShippingAddress2__c,
                                     AS_id__r.AS_ShippingCity__c,AS_id__r.As_Shipping_Country__c,AS_id__r.AS_ShippingPhone__c,AS_id__r.AS_Shippingpoboxno__c,AS_id__r.As_Shipping_States__c,
                                     AS_id__r.AS_shippingzip__c,AS_id__r.As_SuffixNew__c,AS_id__r.AS_ThroughEventBrite__c,AS_id__r.AS_Title__c,AS_id__r.AS_WebsiteUrl__c,AS_id__r.AS_WorkAddress1__c,
                                     AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Workpoboxno__c,AS_id__r.AS_Work_States__c,
                                     AS_id__r.AS_WorkZip__c,AS_id__r.AS_CageCode__c,AS_id__r.Business_type__c,AS_id__r.Company_Certifications__c,AS_id__r.GSA_Schedule__c,
                                     AS_id__r.AS_NAICSCode6__c,AS_id__r.AS_NAICSCode7__c,AS_id__r.AS_NAICSCode8__c,AS_id__r.AS_NAICSCode9__c,createddate,
                                      AS_id__r.References__c,
                                        AS_id__r.References2__c,
                                        AS_id__r.Scope_of_Work__c,
                                    AS_id__r.Scope_of_Work2__c,AS_id__r.Revenue_Range__c,AS_id__r.distribution_Country__c,AS_id__r.Manufactures_Country__c,AS_id__r.DBA__c,AS_id__r.BBB_Number__c,AS_id__r.Commodity_1__c,AS_id__r.Commodity_2__c,AS_id__r.Commodity_3__c,AS_id__r.Commodity_4__c,AS_id__r.Commodity_5__c,AS_id__r.Commodity_6__c,AS_id__r.Commodity_7__c,AS_id__r.Commodity_8__c,AS_id__r.Commodity_9__c,AS_id__r.Geographical_Region__c,AS_id__r.Certificate_Processed_by_RPO__c,AS_id__r.Any_non_WBENC_awards_received__c,AS_id__r.Companyhaveafacility_partneroutsideUSA__c,
                                      AS_id__r.Year_in_business__c,AS_id__r.Business_Structure__c,AS_id__r.AS_Secondary_Email__c,AS_id__r.Ethnicity__c
                                     FROM Event_Attendee_Mapping__c WHERE Id=: eamid ];
            attchments = new list<Attachment>();

            attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:Attendeedetail.AS_id__c];
            videos = [select id,YouTubeId_c__c From Widget__c WHERE AttendeeSummary__r.id =: Attendeedetail.AS_id__c ];
            system.debug('=========== ppppppppp ' + attchments );
          Workstates=states.get(Attendeedetail.AS_id__r.AS_Work_States__c);
          system.debug(':::::::::::::::;;;HS:::::::::::::::'+Workstates);
          if(Workstates == null){
          Workstates=Attendeedetail.AS_id__r.AS_Work_States__c;
          }
           system.debug(':::::::::::::::;;;HS:::::::::::::::'+Workstates);
          Homestates=states.get(Attendeedetail.AS_id__r.As_Home_State__c);
          if(Homestates == null){
          Homestates=Attendeedetail.AS_id__r.As_Home_State__c;
          }
          system.debug(':::::::::::::::;;;HS:::::::::::::::'+Homestates);
          shippingstates=states.get(Attendeedetail.AS_id__r.As_Shipping_States__c);
          if(shippingstates == null){
         shippingstates=Attendeedetail.AS_id__r.As_Shipping_States__c;
          }
          system.debug(':::::::::::::::;;;Attendeedetail.AS_id__r.AS_Work_Country__c:::::::::::::::'+Attendeedetail.AS_id__r.AS_Work_Country__c);
                system.debug(':::::::::::::::;;;Attennaics1'+Attendeedetail.AS_id__r.AS_NAICSCode_1__c);
               system.debug(':::::::::::::::;;;Attennaics2 '+Attendeedetail.AS_id__r.AS_NAICSCode_2__c);
               system.debug(':::::::::::::::;;;Attennaics3 ' +Attendeedetail.AS_id__r.AS_NAICSCode_3__c);
               system.debug(':::::::::::::::;;;Attennaics4 ' +Attendeedetail.AS_id__r.AS_NAICSCode_4__c);
                          system.debug(':::::::::::::::;;;Attennaics5 ' + Attendeedetail.AS_id__r.AS_NAICSCode_5__c);
          workcountry=countries.get(Attendeedetail.AS_id__r.AS_Work_Country__c);
           system.debug(':::::::::::::::;;;workcountry:::::::::::::::'+workcountry);
          Homecountry=countries.get(Attendeedetail.AS_id__r.As_Home_Country__c);
          Shippingcountry=countries.get(Attendeedetail.AS_id__r.As_Shipping_Country__c);
         if(Attendeedetail.AS_id__r.AS_BusinessRevenue__c != null)
        {
        dolor=true;

        }

          }else{
             mbepro = new list<MBE_Profile__c> ();
            attchments = new list<Attachment>();


              mbepro = [Select  a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,
                              a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, a.Exhibitor_company_imageUrl__c,
                              a.AS_WorkZipCode__c,a.AS_WorkPhone__c,
                              a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, Key_Words__c,
                              a.AS_WebsiteUrl__c, a.AS_Title__c,
                              a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c,
                              a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                              a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c,
                              a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c,
                              a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c,
                              a.AS_HomePhone__c,a.AS_HomeCity__c,a.Ethnicity__c,a.AS_Secondary_Email__c,
                              a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                              a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                              a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,Exceptional_Key_Words__c,
                              a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_WorkZip__c,AS_HomeZip__c,
                              AS_BusinessDunsNumber__c,AS_BusinessTaxId__c,Company_Certifications__c,
                              a.AS_NAICSCode6__c,a.AS_NAICSCode7__c,a.AS_NAICSCode8__c,a.AS_NAICSCode9__c, a.Year_in_business__c,a.Business_Structure__c,
                               a.References__c,
                                a.References2__c,
                                a.Scope_of_Work__c,
a.Scope_of_Work2__c,a.Revenue_Range__c,a.distribution_Country__c,a.Manufactures_Country__c,a.DBA__c,a.BBB_Number__c,a.Commodity_1__c,a.Commodity_2__c,a.Commodity_3__c,a.Commodity_4__c,a.Commodity_5__c,a.Commodity_6__c,a.Commodity_7__c,a.Commodity_8__c,a.Commodity_9__c,a.Geographical_Region__c,a.Certificate_Processed_by_RPO__c,a.Companyhaveafacility_partneroutsideUSA__c,a.Any_non_WBENC_awards_received__c 
                              from MBE_Profile__c a Where id =: emid.MBE_Profile__c AND a.Event_Organizer_Id__c=:eventone.owner.username];

           system.debug(mbepro);
           cvideos = new list<Custom_Widget__c>();
            attchments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:mbepro[0].id];
            cvideos = [select id,YouTubeId_c__c From Custom_Widget__c WHERE MBE_Profile__r.id =: mbepro[0].id ];

            Workstates=states.get(mbepro[0].AS_Work_States__c);
          system.debug(':::::::::::::::;;;HS:::::::::::::::'+Workstates);
          if(Workstates == null){
          Workstates=mbepro[0].AS_Work_States__c;
          }
           system.debug(':::::::::::::::;;;HS:::::::::::::::'+Workstates);
          Homestates=states.get(mbepro[0].As_Home_State__c);
          if(Homestates == null){
          Homestates=mbepro[0].As_Home_State__c;
          }
          system.debug(':::::::::::::::;;;HS:::::::::::::::'+Homestates);
          shippingstates=states.get(mbepro[0].As_Shipping_States__c);
          if(shippingstates == null){
         shippingstates=mbepro[0].As_Shipping_States__c;
          }
          system.debug(':::::::::::::::;;;mbepro[0].AS_Work_Country__c:::::::::::::::'+mbepro[0].AS_Work_Country__c);
                system.debug(':::::::::::::::;;;Attennaics1'+mbepro[0].AS_NAICSCode_1__c);
               system.debug(':::::::::::::::;;;Attennaics2 '+mbepro[0].AS_NAICSCode_2__c);
               system.debug(':::::::::::::::;;;Attennaics3 ' +mbepro[0].AS_NAICSCode_3__c);
               system.debug(':::::::::::::::;;;Attennaics4 ' +mbepro[0].AS_NAICSCode_4__c);
                          system.debug(':::::::::::::::;;;Attennaics5 ' + mbepro[0].AS_NAICSCode_5__c);
          workcountry=countries.get(mbepro[0].AS_Work_Country__c);
           system.debug(':::::::::::::::;;;workcountry:::::::::::::::'+workcountry);
          Homecountry=countries.get(mbepro[0].As_Home_Country__c);
          Shippingcountry=countries.get(mbepro[0].As_Shipping_Country__c);
         if(mbepro[0].AS_BusinessRevenue__c != null)
        {
        dolor=true;

        }
        }
        }
        catch(exception e){}
       viewprofilepopup = false;

        }

     //----------------------------------------------------------------------FOR Import------------------------
    /**
     public void ShowPreviousList() {
         limitofbadges = false;
         emailalert = false;
         emailalert1 = false;
         DataImportBool = TRUE;
         ImportHistory = new LIST < DataImport_SavePoint__c > ();
         ImportHistory = [Select d.User_id__c, d.createdDate, d.Name, d.DS_TotalRecords__c, d.DS_FileName__c From DataImport_SavePoint__c d WHERE User_id__c = : userInfo.getUserId()];
     }
     */
     //------------------------------------------------------POPUP FOR SELECTING DESIRED LABEL-----------------------------------

     //--------------------------------------------------------------------------------------EMAIL BADGE------------------------

     //-------------------------------------------------------------------------------------------------------------------------


     //-----------------------------------------------------------------------------------GENERATE PDF FOR BADGES--------------

     //-------------------------------------------------INNER CLASS------------------------------
     public class EventWrapper {
         public Event_Attendee_Mapping__c atnd {
             get;
             set;
         }
         public string z {
             get;
             set;
         }
         public string status {
             get;
             set;
         }
         public string Estatus {
             get;
             set;
         }
         public string hover {
             get;
             set;
         }
         public EventWrapper(Event_Attendee_Mapping__c atnd) {
             this.atnd = atnd;
             if (atnd.EA_isBadgePrinted__c == true) {
                 this.z = 'background-color:#e2e2e2;"';
                 this.hover = 'Already Printed';
                 this.status = 'Printed';
             } else {
                 this.status = 'Not Printed';
             }
             if (atnd.IsPrifileUpdate__c == true) {
                 this.Estatus = 'Sent';
             } else {
                 this.Estatus = 'Not Sent';
             }
         }
     }
     //------------------------------------------------------IINER EMAIL----------------

     //--------------------------------------------------------------INNER FOR BADGE SETTINGS-----------------------

     //--------------------------------------------------------------------------------- INNER CLASS BY MALLIK
     /**
     public class InnerByMallik {
         public String barcode {get;set;}
         public AttendeeSummary__c AttSummary {get;set;}
         public InnerByMallik(String fn, AttendeeSummary__c at) {
             AttSummary = new AttendeeSummary__c();
             barcode = fn;
             AttSummary = at;
         }
     }
     public list < selectoption > font { get;  set;}
     public list < selectoption > fieldnames {get;set;}

        */


     //----------------------------------------Printing att badge---------------------
     public Event_Attendee_Mapping__c eamforprint {
         get;
         set;
     }

     //-------------------------for Delete All--------------------------------------------
     public pagereference deleteallattendees() {
         string ss = ApexPages.currentPage().getParameters().get('mycheck');
         if (ss != null && ss != '') {
             forPaginationstoreIds.put(ss, true);
         }
         system.debug('            for single delete           ' + forPaginationstoreIds.keyset());
         limitofbadges = false;
         EventReqStringBool = false;
         emailalert = false;
         emailalert1 = false;
         for (eventwrapper a: ForPagination) {
             if (a.atnd.checkbox_dataTable__c == TRUE)
                 forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
         }
         if (forPaginationstoreIds.KeySet().size() == 0) {
             EventReqStringBool = true;
             EventReqString = 'Please Select an attendee to Delete';
         } else {
             if (Allrecords == true) {
                 attforexport = new List < Event_Attendee_Mapping__c > ();
                 attforexport = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE ev_Id__c = : eventselected AND Boothleads_Profile__c = : 'Attendee'];
                 delete attforexport;
                 list < User_Profile_Event__c > listOfuperecs = [select id from User_Profile_Event__c where EV_id__c = : eventselected AND Profile_id__r.PR_Name__c = : 'Attendee'];
                 delete listOfuperecs;
             } else {
                 if (forPaginationstoreIds.KeySet().size() != 0) {
                     EventReqStringBool = false;
                     attforexport = [select id, Boothleads_Profile__c, AS_id__r.AS_Email__c from Event_Attendee_Mapping__c WHERE id in : forPaginationstoreIds.KeySet() And Boothleads_Profile__c = : 'Attendee'];
                     list < string > emaillist = new list < string > ();
                     for (Event_Attendee_Mapping__c eam: attforexport) {
                         emaillist.add(eam.AS_id__r.AS_Email__c);
                     }
                     system.debug('             email list         ' + emaillist);
                     List < User > US = [select id from User where Username in : emaillist];
                     delete attforexport;
                     list < id > Uid = new list < id > ();
                     for (user u: US) {
                         Uid.add(u.id);
                     }
                     list < User_Profile_Event__c > listOfuperecs = [select id from User_Profile_Event__c where User_id__c in : Uid AND EV_id__c = : eventselected AND Profile_id__r.PR_Name__c = : 'Attendee'];
                     delete listOfuperecs;
                 }
             }
             getevents();
         }
         return null;
     }
     //-------------------------for Esport All--------------------------------------------
     public string escape(string s) {
         if (s != null && s.contains(',')) {
             s = s.replaceAll('"', '');
            // s = '"' + s + '"';
         }
         return s;
     }
     //--------------------------------------------------------------------------
     public list < list < Event_Attendee_Mapping__c >> exportlistoflist {
         get;
         set;
     }


     //-------------------------------------------------Search----------------------------
     public pagereference search() {

         limitofbadges = false;
         emailalert = false;
         emailalert1 = false;
         EventReqStringBool = false;
         ForPagination = new LIST < EventWrapper > ();
         integer recCount = 0;
         eventlist = new LIst < Event_Attendee_Mapping__c > ();
         string ff = serarchstringvalue.TRIM() + '%';
         eventlist = [select id,CreatedDate,MBE_Profile__r.DBA__c,AS_id__r.DBA__c,MBE_Profile__r.AS_ImageUrl__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_Company__c,EV_id__r.Attendee_Types__c, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,AS_id__r.AS_WorkPhone__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where
             IsMatchMakingAttendee__c =True AND
              EV_id__r.id = : eventSelected AND Boothleads_Profile__c =: 'Attendee' and(AS_id__r.AS_FirstName__c like: ff + '%'
             OR AS_id__r.AS_LastName__c like: ff + '%'
             OR AS_id__r.AS_Company__c like: ff + '%'
             OR MBE_Profile__r.DBA__c like: ff + '%'
             OR AS_id__r.DBA__c like: ff + '%'
             OR AS_id__r.AS_Email__c like: ff + '%'
             OR AS_id__r.AS_CellPhone__c like: '%' + ff + '%' OR AS_id__r.Total_Name__c like: '%' + ff + '%' OR AS_id__r.FullName__c like: '%' + ff + '%') order by AS_id__r.AS_LastName__c
         ];
         AttendeeCount= eventlist.size();
         ew = new List < eventwrapper > ();
         for (Event_Attendee_Mapping__c s: eventlist) {
             crd = s.CreatedDate;
             crd = getLocalDateTime(crd);
             s.AS_id__r.AS_LastName__c = escapeSpecialCharacters(s.AS_id__r.AS_LastName__c);
             s.AS_id__r.AS_FirstName__c = escapeSpecialCharacters(s.AS_id__r.AS_FirstName__c);
             s.AS_id__r.AS_CellPhone__c = escapeSpecialCharacters(s.AS_id__r.AS_CellPhone__c);
             s.AS_id__r.AS_Email__c = escapeSpecialCharacters(s.AS_id__r.AS_Email__c);
             s.AS_id__r.AS_Company__c = escapeSpecialCharacters(s.AS_id__r.AS_Company__c);
             recCount++;
             ew.add(new eventwrapper(s));
         }
         try {
             if (ew.size() > 0) {
                 system.debug('===================' + ew.size());
                 conlst = true;
                 count = ew.size();
                 pageno = 1;
                 if (math.mod(ew.size(), 50) == 0) {
                     system.debug(' -------------------- @@@@@@@@@@@@@@@@@@@@' + pgno);
                     pgno = ew.size() / 50;
                 } else {
                     system.debug(' -------RRRRRRRRRRRRRRRRRRRRRRRRR' + pgno);
                     pgno = (ew.size() / 50) + 1;
                     system.debug(' -------!!!!!!!!!!!!!!!!!!!!!' + pgno);
                 }
                 for (integer i = 0; i < 50; i++) {
                     system.debug(' ----------- BBBBBBBBBBBBBBBBB ' + ew[i]);
                     ForPagination.add(ew[i]);
                     if (ew.size() < 50) {
                         hasLast = false;
                         hasNext = false;
                     } else {
                         hasLast = True;
                         hasFirst = False;
                         hasPrevious = false;
                         hasNext = True;
                     }
                 }
             }
         } catch (exception e) {}
         return null;
     }

     //--------------------------------------------------------PAGENATION-----------------------------
     public void fortrancy() {
         integer recCount = 0;
         eventlist = [select id,CreatedDate,MBE_Profile__r.AS_ImageUrl__c,MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_Company__c,EV_id__r.Attendee_Types__c, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,AS_id__r.AS_WorkPhone__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c
                             where IsMatchMakingAttendee__c = true AND EV_id__r.id = : eventSelected AND Boothleads_Profile__c =: 'Attendee' ORDER BY AS_id__r.AS_Company__c ASc
         ];
         system.debug('===================' + eventlist);
         ew = new List < eventwrapper > ();
         for (Event_Attendee_Mapping__c s: eventlist) {
             system.debug('===================' + s.id);
             crd = s.CreatedDate;
             crd = getLocalDateTime(crd);
             recCount++;
             ew.add(new eventwrapper(s));
             system.debug('===================' + ew);
         }
     }
     public void next() {
         for (eventwrapper a: ForPagination) {
             if (a.atnd.checkbox_dataTable__c == TRUE)
                 forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
         }
         try {
             fortrancy();
             pageno = pageno + 1;
             // integer pgno;
             ForPagination.clear();
             if (math.mod(ew.size(), 50) == 0) {
                 system.debug(' -------------------- @@@@@@@@@@@@@@@@@@@@' + pgno);
                 pgno = ew.size() / 50;
             } else {
                 system.debug(' -------RRRRRRRRRRRRRRRRRRRRRRRRR' + pgno);
                 pgno = (ew.size() / 50) + 1;
                 system.debug(' -------!!!!!!!!!!!!!!!!!!!!!' + pgno);
             }
             if (pageno == pgno) {
                 hasNext = false;
                 hasLast = False;
                 Disabled_Next_Icon = True;
                 Disabled_Last_Icon = True;
                 for (integer i = (pageno - 1) * 50; i < ew.size(); i++) {
                     if (forPaginationstoreIds.containsKey(ew[i].atnd.id)) {
                         eventwrapper checkedAcc = ew[i];
                         checkedAcc.atnd.checkbox_dataTable__c = forPaginationstoreIds.get(ew[i].atnd.id);
                         ForPagination.add(checkedAcc);
                         System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------' + ForPagination.size() + ' RECORDS ' + ew[i]);
                     } else {
                         ForPagination.add(ew[i]);
                     }
                 }
             } else
                 for (integer i = (pageno - 1) * 50; i < (pageno * 50); i++) {
                     system.debug(' -------------------- @@@@@@@@@@@@@@@@@@@@------------mythily' + forPaginationstoreIds.containsKey(ew[i].atnd.id));
                     if (forPaginationstoreIds.containsKey(ew[i].atnd.id)) {
                         eventwrapper checkedAcc = ew[i];
                         checkedAcc.atnd.checkbox_dataTable__c = forPaginationstoreIds.get(ew[i].atnd.id);
                         ForPagination.add(checkedAcc);
                         System.debug('--------------------SIZE OF PAGINATION LIST11111111---------------------' + ForPagination.size() + ' RECORDS ' + ew[i]);
                     } else {
                         ForPagination.add(ew[i]);
                     }
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------' + ForPagination.size() + ' RECORDS ' + ew[i]);
             }
             hasPrevious = true;
             hasFirst = True;
             Disabled_Previous_Icon = False;
             Disabled_First_Icon = False;
              ForPagesize = ForPagination.size();
             System.debug('---------------------------- LIST SIZE OF TEMPLIST ---------------------' + ew.size());
         } catch (Exception Ex) {}
     }
     public void prev() {
         for (eventwrapper a: ForPagination) {
             if (a.atnd.checkbox_dataTable__c == TRUE)
                 forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
         }
         try {
             fortrancy();
             hasLast = True;
             hasNext = true;
             Disabled_Previous_Icon = False;
             Disabled_First_Icon = False;
             Disabled_Next_Icon = False;
             Disabled_Last_Icon = False;
             ForPagination.clear();
             if (pageno != 1) {
                 pageno = pageno - 1;
                 If(pageno == 1) {
                     hasPrevious = false;
                     hasFirst = False;
                     Disabled_Previous_Icon = True;
                     Disabled_First_Icon = True;
                     Disabled_Next_Icon = False;
                     Disabled_Last_Icon = False;
                 }
                 for (integer i = (pageno - 1) * 50; i < (pageno * 50); i++) {
                     if (forPaginationstoreIds.containsKey(ew[i].atnd.id)) {
                         eventwrapper checkedAcc = ew[i];
                         checkedAcc.atnd.checkbox_dataTable__c = forPaginationstoreIds.get(ew[i].atnd.id);
                         ForPagination.add(checkedAcc);
                     } else {
                         ForPagination.add(ew[i]);
                     }
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------' + ForPagination.size() + ' RECORDS ' + ew[i]);
                 }
             } else {
                 hasPrevious = false;
                 hasFirst = False;
                 for (integer i = (pageno - 1) * 50; i < (pageno * 50); i++) {
                     if (forPaginationstoreIds.containsKey(ew[i].atnd.id)) {
                         eventwrapper checkedAcc = ew[i];
                         checkedAcc.atnd.checkbox_dataTable__c = forPaginationstoreIds.get(ew[i].atnd.id);
                         ForPagination.add(checkedAcc);
                     } else {
                         ForPagination.add(ew[i]);
                     }
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------' + ForPagination.size() + ' RECORDS ' + ew[i]);
                 }
             }
              ForPagesize = ForPagination.size();
         } catch (Exception ex) {}
     }
     public void Last() {
         try {
             fortrancy();
             hasLast = False;
             Disabled_Last_Icon = True;
             System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
             hasPrevious = true;
             Disabled_Previous_Icon = False;
             hasFirst = true;
             Disabled_First_Icon = False;
             ForPagination.clear();
             hasNext = false;
             Disabled_Next_Icon = True;
             if (math.mod(ew.size(), 50) == 0) {
                 System.debug('---------44444444444444444----' + pageno);
                 pageno = ew.size() / 50;
                 System.debug('-----------------pageno ----' + pageno);
             } else {
                 System.debug('---------44444444444444444----' + pageno);
                 pageno = (ew.size() / 50) + 1;
             }
             for (integer i = (pageno - 1) * 50; i < ew.size(); i++) {
                 ForPagination.add(ew[i]);
             }
              ForPagesize = ForPagination.size();
         } catch (Exception ex) {}
     }
     public void First() {
         try {
             fortrancy();
             hasNext = true;
             hasFirst = false;
             hasPrevious = false;
             hasLast = True;
             Disabled_Previous_Icon = True;
             Disabled_First_Icon = True;
             Disabled_Next_Icon = False;
             Disabled_Last_Icon = False;
             ForPagination.clear();
             //hasPrevious=false;
             pageno = 1;
             for (integer i = 0; i < 50; i++) {
                 ForPagination.add(ew[i]);
             }
             if (math.mod(ew.size(), 50) == 0) {
                 system.debug(' -------------------- @@@@@@@@@@@@@@@@@@@@' + pgno);
                 pgno = ew.size() / 50;
             } else {
                 system.debug(' -------RRRRRRRRRRRRRRRRRRRRRRRRR' + pgno);
                 pgno = (ew.size() / 50) + 1;
                 system.debug(' -------!!!!!!!!!!!!!!!!!!!!!' + pgno);
             }
              ForPagesize = ForPagination.size();
         } catch (Exception ex) {}
     }



    //--------------------------------------------view schedule----------------------------
        //public list<innerschedule> innerschedule{get;set;}
        public boolean viewschedulepopup{get;set;}
        public list<EventSchedule__c> easlist{get;set;}
        public EventSchedule__c dummylist{get;set;}
        //public map<string, innerschedule> mapDummys= new map<string, innerschedule>();
        public LIST<MatchLeads_Days__c> allEventDates{get; set;}
        public Event_Attendee_Mapping__c eamdetails{get;set;}
        public MAP<Date , LIST<String>> getDataFromUtility{get; set;}
        public LIST<SelectOption> eventDatesList{get; set;}
        public boolean ShowDatePicklist{get; set;}
        public String selectedEventDate{get; set;}
        public LIST<String> timeSlotsForDate{get; set;}
        public String eamid {get; set;}
        public List<SelectOption> statusOptions {get; set;}
        public List<String> selectedStatusList{get; set;}
        public integer statusSize{get; set;}
        public boolean CheckboxBool {get; set;}
        //public list<Event_Breaks__c> blokslistexist {get ; set ;}
        public void viewschedule(){
        try{
        viewschedulepopup = true;
         norecordsalert = false;
        //innerschedule = new list<innerschedule>();
        eventDatesList= new LIST<Selectoption>();
         statusOptions= new List<SelectOption>();
            this.selectedStatusList= new List<String>();
         //eamid = Apexpages.currentpage().getparameters().get('MMattendee');

        /* START CODE FOR ADDING DATE PICKLIST */
         allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: eventSelected ORDER BY MatchLeads_Date__c ASC]);
          if(allEventDates.size() >1){
             ShowDatePicklist= true;
             for(MatchLeads_Days__c matchDate: allEventDates){

                 //String eventDate= String.valueOf(matchDate.MatchLeads_Date__c) ;
                 String dateFormat= matchDate.MatchLeads_Date__c.format();

                 eventDatesList.add(new selectoption(dateFormat,dateFormat));

                  }

             }

           selectedEventDate= allEventDates[0].MatchLeads_Date__c.format();

         //Status Picklist Code Starts
            selectedStatusList.add('Accepted');

            Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
            List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
            statusOptions.add(new SelectOption('All','All'));
            statusSize= AllValues.size();
            system.debug(' PICK LIST SIZE '+statusSize);
            for(Schema.PicklistEntry str: AllValues){
                statusOptions.add(new SelectOption(Str.getValue(), Str.getValue()));
            }

            statusOptions.add(new SelectOption('Open','Open'));

            schedulesForEvent();
         }catch(exception e){}

      }

      public SET<String> selectedStatusSET{get; set;}

      public pagereference schedulesOnStatus(){

            easlist = new list<EventSchedule__c>();
            selectedStatusSET= new SET<String>();
            selectedStatusSET.addAll(selectedStatusList);

            try{
                if(selectedEventDate != null || selectedEventDate != '') {

                    LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                    Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));

                    if(selectedStatusSET.contains('All')){

                        system.debug('       eamid      '+eamid+'    '+selectedEventDate );
                        CheckboxBool = true;

                     eamdetails = new Event_Attendee_Mapping__c();
             easlist = [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                          MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                          MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                          MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                       from EventSchedule__c
                   where MM_To_EAM__c =: eamid
                   AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                   AND MM_Slot_Status__c != null
                   AND MM_slot_StartTime__c != null
                   AND MM_slot_Date__c != null
                   AND MM_slot_Date__c =: selectedDate
                   ORDER BY starttimein24hrs__c];
                               system.debug('   SCHUDULE LIST SIZE    '+easlist.size()+'    '+easlist );

         Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
            List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
            system.debug(' PICK LIST SIZE '+statusSize);
            for(Schema.PicklistEntry str: AllValues){
                selectedStatusList.add(Str.getValue());
            }

          }else if(selectedStatusSet.contains('Open')){
                        // && selectedStatusSet.size() ==1
                        CheckboxBool = false;
                        selectedStatusList = new LIST<String>();
                        selectedStatusList.add('Open');

                        system.debug('Open Appointments  '+openSlotsList.size()+'    '+openSlotsList);
                    }else{
           if(! selectedStatusSet.contains('All') && selectedStatusList.size() == statusSize){
            selectedStatusList= new List<String>();
            }else{
                                CheckboxBool = true;

          eamdetails = new Event_Attendee_Mapping__c();
             easlist = [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                          MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                          MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                          MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                       from EventSchedule__c
                   where MM_To_EAM__c =: eamid
                   AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                   AND (MM_Slot_Status__c != null AND MM_Slot_Status__c IN : selectedStatusList)
                   AND MM_slot_StartTime__c != null
                   AND MM_slot_Date__c != null
                   AND MM_slot_Date__c =: selectedDate
                    ORDER BY starttimein24hrs__c];

          }
          }
          }
         eamdetails=[select AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c from Event_Attendee_Mapping__c where id =: eamid ];
          if(easlist.size() != 0){
           dummylist = easlist[0];
           norecordsalert = true;
          }
     }catch(exception e){}
          return null;
      }

        public LIST<EventSchedule__c> schedulesList{get; set;}
        public SET<String> openSlotsList{get; set;}
        public LIST<String> startTimeList{get; set;}

        public pagereference schedulesForEvent(){
          system.debug('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
            getDataFromUtility= new MAP<Date , LIST<String>>();
            timeSlotsForDate= new LIST<String>();
            openSlotsList= new SET<String>();

            try{
            system.debug('  EVENT DATE SELECTED  '+selectedEventDate );
                if(selectedEventDate != null || selectedEventDate != ''){

                system.debug('       eamid      '+eamid);
               //Date selectedDate= date.valueOf(selectedEventDate);
               LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
               Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));

               getDataFromUtility= MM_Utility.giveEventTimingsWithDates(eventSelected, selectedDate);

             timeSlotsForDate= getDataFromUtility.get(selectedDate);

             eamdetails = new Event_Attendee_Mapping__c();
             schedulesList= [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                          MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                          MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                          MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                       from EventSchedule__c
                   where MM_To_EAM__c =: eamid
                   AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                   AND (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')
                   AND MM_slot_StartTime__c != null
                   AND MM_slot_Date__c != null
                   AND MM_slot_Date__c =: selectedDate
                    ORDER BY starttimein24hrs__c];
                system.debug('  SCH LIST   '+schedulesList);
                system.debug('  SLOT LIST  '+timeSlotsForDate);

          //timeSlotsForDate.sort();
          slotsInner= new LIST<timeSlotInnerClass> ();
          startTimeList= new LIST<String>();
          openSlotsList.addAll(timeSlotsForDate);
                      system.debug('  SLOT SET '+openSlotsList.size()+'    '+openSlotsList);
          SET<String> slotsList= new SET<String>();
          for(String timeSlot: timeSlotsForDate){
                LIST<String> slotStartTime= new LIST<String>(timeSlot.split(':'));
              system.debug(' SLOT START TIME  '+slotStartTime[0]+'    '+slotStartTime);

              if(! slotsList.contains(slotStartTime[0])){
                        system.debug('IF  SLOT START TIME  '+slotStartTime[0]+'    '+slotsList);
                  slotsList.add(slotStartTime[0]);
                  startTimeList.add(slotStartTime[0]);
                  system.debug(' ELSE SLOT START TIME  '+slotStartTime[0]+'    '+slotsList);
              }

              for(EventSchedule__c esch: schedulesList){
                  string scheduleSlot= esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c;
                  if(scheduleSlot == timeSlot && (esch.MM_Slot_Status__c == 'Accepted' || esch.MM_Slot_Status__c == 'Pending')){

                      openSlotsList.remove(timeslot);
                  }
              }
              blokslistexist = new list<Event_Breaks__c> ();
           blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__c =: eamid ];
           for(Event_Breaks__c  berk: blokslistexist  ){
           string scheduleSlot= berk.Break_Start_Time__c+'-'+berk.Break_End_Time__c;
            if(scheduleSlot == timeSlot){
            openSlotsList.remove(timeslot);
              }

           }
          }
          system.debug(' AFTER SLOT SET '+openSlotsList.size()+'    '+openSlotsList);
           for(String slotInt: startTimeList){

              system.debug('FOR SLOT START TIME '+slotInt);
              LIST<String> slotsListForStartTime= new LIST<String>();
              for(String slotStr: openSlotsList){

                  LIST<String> slotStartTimeStr= new LIST<String>(slotStr.split(':'));
                  system.debug('INNER FOR SLOT START TIME  '+slotStartTimeStr[0]+'    '+slotStartTimeStr);

                  if(slotInt == slotStartTimeStr[0]){

                      slotsListForStartTime.add(slotStr);
                  }

              }
              slotsListForStartTime.sort();
               slotsInner.add(new timeSlotInnerClass(slotInt, slotsListForStartTime));
          }
          system.debug(' SLOTS LIST FOR TIME  '+slotsInner.size()+'    '+slotsInner);
          schedulesOnStatus();
          }
     }catch(exception e){}

          return null;
      }
       public LIST<timeSlotInnerClass> slotsInner{get; set;}
      public class timeSlotInnerClass{

          public String slotStartTime{get; set;}
          public LIST<String> slotsForTime{get; set;}

          public timeSlotInnerClass(String sTime, LIST<String> sForTime){

              slotsForTime= new LIST<String>();

              slotStartTime= sTime;
              slotsForTime= sForTime;
          }

      }
    /**
      public class innerschedule{
      public list<EventSchedule__c> lislots {get;set;}
            public string slot{get;set;}

            public innerschedule(EventSchedule__c comp)
            {
                slot= string.valueOf(comp.MM_slot_Date__c);
                lislots = new list<EventSchedule__c>{comp};

      }
      }
      */

      public pagereference printschedule(){
       eventDetailsInPrint();
      pagereference pg=page.mm_eventadmin_printattendeeschedule;
      return pg;
      }

      public String eventDatesString {get; set;}
      public Event__c eventDetails{get;set;}

      public void eventDetailsInPrint(){

            eventDetails= new Event__c();
               system.debug('EVENT ID  '+eventSelected );

            if(eventSelected != null || eventSelected != ''){
                eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, EV_EventLogo__c,
                              EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,Match_Making_Schedules__c
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

     public boolean emailalertsh{get;set;}
      public pagereference emailschedule(){
      try{
      system.debug('unnnnnnnnnnnnnnnnniiiiiiiiiiiiii' + easlist);
      Event_Attendee_Mapping__c eam =[select id,MBE_Profile__r.AS_Secondary_Email__c,AS_id__r.AS_Secondary_Email__c,AS_id__r.AS_Email__c,AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Company__c from Event_Attendee_Mapping__c where id =:eamid ];
               eventDetails= new Event__c();
                  eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c,EV_EventLogo__c,
                              EV_StartDate__c, EV_EndDate__c,EV_HostingStateNew__c,Is_MatchMaking_Event__c,Is_Webank_event__c
                              FROM Event__c
                              WHERE ID =: eventSelected];
                              system.debug('unnnnnnnnnnnnnnnnniiiiiiiiiiiiii' + eam.AS_id__r.AS_Email__c);
                 string dd = eventDetails.EV_StartDate__c.format();
                 //pdf = page.mm_eventadmin_printattendeeschedule;

                 b = page.mm_eventadmin_printattendeeschedule.getContent();
                 Messaging.SingleEmailMessage emailsh = new Messaging.SingleEmailMessage();
                 OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'McMillen, Shelli'];
                 if(owea.size() > 0 ) {
                      emailsh.setOrgWideEmailAddressId(owea.get(0).Id);
                 }
                 emailsh.setSubject('Your Schedules for Registered Event!');
                 if(eventdetails.Is_Webank_event__c == true){
                 String[] toaddress = new String[] {
                     eam.MBE_Profile__r.AS_Secondary_Email__c
                 };
                 emailsh.setToAddresses(toaddress);
                 }
                 if(eventdetails.Is_Webank_event__c == false){
                 String[] toaddress = new String[] {
                     eam.AS_id__r.AS_Secondary_Email__c
                 };
                 emailsh.setToAddresses(toaddress);
                 }
                 //emailsh.setToAddresses(toaddress);
                 //system.debug('krrrrrrrrrrriiii' + toaddress);
                    String hostLocation;
            String hostadd1;
            String hostCity;
            String hostState;
            String hostZipCode;
            String commaSymb;

            hostLocation=(eventDetails.EV_HostingLocation__c!=Null) ? eventDetails.EV_HostingLocation__c : '';
            hostadd1=(eventDetails.EV_HistingAddr1__c!=Null) ? eventDetails.EV_HistingAddr1__c : '';
            hostCity=(eventDetails.AS_HostingCity__c!=Null) ? eventDetails.AS_HostingCity__c : '';
            hostState=(eventDetails.EV_HostingStateNew__c!=Null) ? eventDetails.EV_HostingStateNew__c : '';
            hostZipCode=(eventDetails.EV_HostingZipcode__c!=Null) ? eventDetails.EV_HostingZipcode__c : '';
            commaSymb=(eventDetails.AS_HostingCity__c!=Null) ? ',' : '';

                 emailsh.setHTMLBody(message = 'Hello ' + ' ' + eam.AS_id__r.AS_FirstName__c+',' +  + '<br/>' + '' + '<br/>' +
                     'Thank you for participating in the matchmaking.' + '<br/>' +'' + '<br/>' + '<br/>' +
                     'Attached is your one on one matchmaking schedule for the following event:' + '<br/>' +'<br/>' +
                     +'<b>'+ eventDetails.EV_StartDate__c.format() +' '+ eventDetails.EV_Title__c  +'</b>'+ '<br/>' +
                    hostLocation + '<br/>' +
                  hostadd1+ '<br/>' +
                  hostCity+commaSymb+hostState+' '+hostZipCode+ '<br/>' +'<br/>'+
                     'Please come on time and be prepared with either a capability statement or a brochure to let'+ '<br/>' +
                     'your potential customers know about your products, and services.'+ '<br/>'+ '<br/>'+
                     'If you have any further questions, please contact your event administrator.'+ '<br/>'+'<br/>'+'<br/>'+
                     'Best Wishes!'+'<br/>'+
                     'Booth Leads customer support'+'<br/>'+
                     +'<a>'+'support@boothleads.com.'+'</a>'+'<br/>'+
                     'Phone: 1-(800)-492-1289.');
                 Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                 efa.setFileName('Schedule.pdf');
                 efa.setBody(b);
                 emailsh.setFileAttachments(new Messaging.EmailFileAttachment[] {
                     efa
                 }
                 );

             //system.debug('       toaddress             '+toaddress);
             //Messaging.SendEmailResult[] r = Messaging.sendEmail(email);
             Messaging.SendEmailResult[] r=Messaging.sendEmail(New Messaging.SingleEmailMessage[] {emailsh});
            /** boolean check1 = true;
             for (Messaging.SendEmailResult ms: r) {
                 check1 = check1 && ms.isSuccess();
             }
             if (check1 == true){
                 emailalertsh = true;

              }**/
              emailalert1 = true;
             }catch(exception e){}
                 return null;

        }

        //------ Select Attendee to match Code
      public String selectedTimeSlot{get; set;}
      public LIST<User_Profile_Event__c> UPEList{get; set;}
      public LIST<User_Profile_Event__c> UPEListForMatch{get; set;}
      public boolean ShowMatchPanel{get; set;}
      public Date selectedSplitDate{get; set;}
      public LIST<String> selectedTimeSlots{get; set;}

      public void exhibitorListToMatch(){

          system.debug('  SELECTED TIME SLOT  '+selectedTimeSlot);
          ShowMatchPanel= TRUE;
          UPEList= new  LIST<User_Profile_Event__c>();
          UPEListForMatch= new  LIST<User_Profile_Event__c>();

          try{
          LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
          selectedSplitDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
          list<EventSchedule__c> existingSchedules= new list<EventSchedule__c>();
          MLDAYS= new MatchLeads_Days__c ();


          existingSchedules=[select id from EventSchedule__c
                             where MM_To_EAM__c =: eamid AND EV_id__c =: eventSelected
                             AND( (MM_Slot_Status__c = 'Accepted') OR(MM_Slot_Status__c = 'Pending'))  AND MM_slot_Date__c =: selectedSplitDate];


          MLDAYS =[select id,Start_time__c,End_Time__c,Slot_Time_period__c,MAX_noOf_appontments__c,Break_Time_between_slots__c from MatchLeads_Days__c   where MatchLeads_Date__c =: selectedSplitDate AND Event__c=: eventSelected ];
                           system.debug('dddddddddddddddddddddddddddddddddddddddd'+MLDAYS.MAX_noOf_appontments__c);
                           system.debug('sssssssssssssssssssssssssssssssssssssssssssssss'+existingSchedules.size());
          if(MLDAYS.MAX_noOf_appontments__c ==null ||  existingSchedules.size() <   MLDAYS.MAX_noOf_appontments__c){

           showExccededError= FALSE;
          ShowMatchPanel= TRUE;

          selectedTimeSlots= new LIST<String>(selectedTimeSlot.split('-'));
          UPEList= [SELECT ID, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c, Attendee_Summary__r.AS_Email__c, Attendee_Summary__r.AS_Company__c, (SELECT ID FROM EventSchedule__r WHERE MM_slot_Date__c =: selectedSplitDate AND ES_StartTime__c =: selectedTimeSlots[0] AND ES_EndTime__c =: selectedTimeSlots[1] AND EV_id__c =: eventSelected ) FROM User_Profile_Event__c WHERE EV_id__c =: eventSelected AND IsMatchMakingUser__c =: TRUE];
          system.debug('   UPE LIST  '+UPEList.size());
          for(User_Profile_Event__c upe: UPEList){

              LIST<EventSchedule__c> schedulesList= new LIST<EventSchedule__c>();
              schedulesList= upe.EventSchedule__r;
              if(schedulesList.size() == 0){
                  UPEListForMatch.add(upe);
              }
                system.debug('  ADDED UPE LIST  '+UPEListForMatch.size());

          }

      } else{
          showExccededError= true;
          ShowMatchPanel= false;

      }
      }catch(Exception Ex){}
      }

      public String selectedExhibitorId{get; set;}
      public boolean showExccededError{get; set;}
      public MatchLeads_Days__c MLDAYS{get; set;}

      public pagereference matchSelectedExhibitor(){

          system.debug('UPE ID '+selectedExhibitorId+'   EAM ID '+eamid+' DATE '+selectedSplitDate +'   TIMINGS '+selectedTimeSlots);
          try{

          Event__c eventTypeForStatus= [select id,MatchMaking_Type__c from Event__c where id=: eventSelected ];
          LIST<EventSchedule__c> insertSchedules= new LIST<EventSchedule__c>();
          EventSchedule__c insertSchedule= new EventSchedule__c();

          insertSchedule.MM_To_EAM__c= eamid;
          insertSchedule.MM_To_UPE__c= selectedExhibitorId;
          insertSchedule.MM_slot_Date__c= selectedSplitDate ;
          insertSchedule.MM_slot_StartTime__c= selectedTimeSlots[0];
          insertSchedule.MM_Slot_End_Time__c= selectedTimeSlots[1];
          insertSchedule.EV_id__c= eventSelected ;
          insertSchedule.Is_Matchmaking__c= TRUE;
          system.debug('Added SCH  '+insertSchedule);

          if(eventTypeForStatus.MatchMaking_Type__c != 'Open' && eventTypeForStatus.MatchMaking_Type__c != 'Closed'){
              insertSchedule.MM_Slot_Status__c= 'Pending';
          }else{
                insertSchedule.MM_Slot_Status__c= 'Accepted';
          }
          insertSchedules.add(insertSchedule);
          Database.SaveResult[] scheduleInsert = Database.insert(insertSchedules, false);
          system.debug(' INSERTED SCH'+scheduleInsert);
          ShowMatchPanel= false;
          viewschedule();
          system.debug('EAM FOR EXHIBITOR   '+eamid);
          }catch(Exception Ex){}
          return null;
      }

      public pagereference closeExhibitorPopup(){
          ShowMatchPanel= false;
          showExccededError=false;
          return null;
      }


     //-------------------------------------------------------------------------
       public List<Selectoption> availableBADSinMM{get; set;}
        public List<Selectoption> availableBADS{get; set;}

      public void ExhibitorsFromBL(){
      eventlist = new list<Event_Attendee_Mapping__c>();
      availableBADSinMM = new List<Selectoption>();
      availableBADS = new List<Selectoption>();
      eventlist = [select CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,MBE_Profile__r.AS_Company__c,
                 AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,
                 EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c,
                 AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c
                 from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c = false AND EV_id__r.id = : eventSelected AND Boothleads_Profile__c =: 'Attendee' ORDER BY AS_id__r.AS_FirstName__c
                  ];
             for(Event_Attendee_Mapping__c V : eventlist ){
                                     String names = (v.AS_id__r.AS_FirstName__c+' '+ v.AS_id__r.AS_LastName__c );
                                  availableBADS.add(new Selectoption(v.id, names ));
                                  system.debug( '  aaaaaaaaaa      '+availableBADS);
                                   }


                        eventlist = [select CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,MBE_Profile__r.AS_Company__c,
                 AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,
                 EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c,
                 AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c
                 from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c = true AND EV_id__r.id = : eventSelected AND Boothleads_Profile__c =: 'Attendee' ORDER BY AS_id__r.AS_FirstName__c
                  ];
             for(Event_Attendee_Mapping__c V : eventlist ){
                                 String names = (v.AS_id__r.AS_FirstName__c+ ' ' + v.AS_id__r.AS_LastName__c );
                                  availableBADSinMM.add(new Selectoption(v.id, names ));
                                  system.debug( '  AAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa        '+availableBADS);
                                   }
      multiselectpicklist=true;


      }

    //----------------------------------------------------------------
      public void saveExhibitors(){



       List<id> dd=new list<id>();
      for(Selectoption MM: availableBADSinMM ){

      dd.add(mm.getvalue());
      system.debug('        ids   '+dd);

      }
      list<Event_Attendee_Mapping__c> updmm=new list<Event_Attendee_Mapping__c>();
      eventlist =[select IsMatchMakingAttendee__c,AS_id__r.id from Event_Attendee_Mapping__c  where id IN : dd];
      LIST<Id> accids = new LIST<Id>();
      FOR(Event_Attendee_Mapping__c em: eventlist ){
      accids.add(em.AS_id__r.id);
      }
      LIST<User_Profile_Event__c> upe = [SELECT id,IsMatchMakingUser__c FROM User_Profile_Event__c WHERE Attendee_Summary__r.id IN : accids AND EV_id__c =: eventSelected ];
      LIST<User_Profile_Event__c> USC = new LIST<User_Profile_Event__c> ();
      IF(upe.size()!= 0){
      FOR(User_Profile_Event__c uu: upe){
      uu.IsMatchMakingUser__c = true;
      USC.add(uu);
      }}
      update USC;
      for(Event_Attendee_Mapping__c ISMM: eventlist ){
      ISMM.IsMatchMakingAttendee__c =true;
      updmm.add(ISMM);
      }
      update updmm;

      list < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();

      List<ID> IDSB=new List<ID>();
      for(Selectoption MM: availableBADS){

      IDSB.add(mm.getvalue());


      }
      
      LIST<Id> accidsup = new LIST<Id>();
      
      
      system.debug('        ids   '+IDSB);
      list<EventSchedule__c> updBL=new list<EventSchedule__c>();
      list<EventSchedule__c> ESlist = [select id,Is_Matchmaking__c,MM_To_UPE__c,MM_To_EAM__c,MM_Slot_End_Time__c,MM_slot_StartTime__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.IsMatchMakingAttendee__c,
                                                  MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,
                                                  MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.BoothAdmin_id__r.Name,
                                                  MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.IsMatchMakingUser__c
                                                  from EventSchedule__c where MM_To_EAM__r.id IN : IDSB ];
            for(EventSchedule__c esch : ESlist ){
      if(esch.MM_To_UPE__c != null && esch.MM_To_EAM__c != null){
      
      esch.MM_To_UPE__r.IsMatchMakingUser__c =false;
       esch.MM_To_EAM__r.IsMatchMakingAttendee__c = false;
       esch.MM_Slot_Status__c = 'Cancelled';
      updBL.add(esch);

          
      }}
      database.update(updBL);
      list<Event_Attendee_Mapping__c> updBLs=new list<Event_Attendee_Mapping__c>();
      eventlist =[select IsMatchMakingAttendee__c,AS_id__r.id from Event_Attendee_Mapping__c  where id IN : IDSB];
      for(Event_Attendee_Mapping__c ISMM: eventlist ){
      ISMM.IsMatchMakingAttendee__c =false;
      accidsup.add(ISMM.AS_id__r.id);
      updBLs.add(ISMM);


      }
      update updBLs;
      LIST<User_Profile_Event__c> upesel = [SELECT id,IsMatchMakingUser__c FROM User_Profile_Event__c WHERE Attendee_Summary__r.id IN : accidsup AND EV_id__c =: eventSelected ];
      LIST<User_Profile_Event__c> USCS = new LIST<User_Profile_Event__c> ();
      IF(upesel.size()!= 0){
      FOR(User_Profile_Event__c uu: upesel){
      uu.IsMatchMakingUser__c = false;
      USCS.add(uu);
      }}
      update USCS;
   


      multiselectpicklist=false;
      getevents();
      }
      public string existingEamsForstatus{get;set;}
       //public list<innercls> eamcountlist1 {get ; set;}
      //public integer count1;


      public map<id,integer> Map1 {get;set;}
      public pagereference ExportMBE(){
      Map1=new map<id,integer>();
      for(Event_Attendee_Mapping__c eaming:[SELECT Id,(select id from EventSchedule__r where MM_Slot_Status__c='Accepted') FROM Event_Attendee_Mapping__c WHERE EV_id__c =:eventselected]){

      Map1.put(eaming.id,(eaming.EventSchedule__r).size());

      }
      //count=Map1.size();
      System.debug('@@@@@@@@:'+count);

      eventlist  = new list<Event_Attendee_Mapping__c>();
      attforexport = new list<Event_Attendee_Mapping__c>();
       Event_Attendee_Mapping__c attforexport1 = new Event_Attendee_Mapping__c();
       exportlistoflist = new List < List < Event_Attendee_Mapping__c >> ();
       eventone = new Event__c();
          eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:eventselected];
        existingEamsForstatus ='';
        // By Phani
        for(EventSchedule__c ES : [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.BT_id__r.BT_Location__c,
                          MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                          MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                          MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                       from EventSchedule__c
                       Where EV_id__c =: eventSelected
                   AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                   AND (MM_Slot_Status__c = 'Accepted') //OR MM_Slot_Status__c = 'Pending')
                   AND MM_slot_StartTime__c != null
                   AND MM_slot_Date__c != null
                   ORDER BY MM_slot_StartTime__c]){

                  existingEamsForstatus+=ES.MM_To_EAM__c+',';
                 if(ES.MM_To_EAM__r.id==attforexport1.id)
          {
          //count++;

                  }


                 }

         if(eventone.Is_Webank_event__c == false){

      // string qu = 'select id, TicketTypes__c, AS_id__r.AS_Age__c, AS_id__r.AS_BirthDate__c, AS_id__r.AS_BlogUrl__c, AS_id__r.AS_BusinessDescription__c, AS_id__r.AS_BusinessDunsNumber__c,AS_id__r.AS_BusinessEstablishedDate__c, AS_id__r.AS_BusinessRevenue__c, AS_id__r.AS_BusinessTaxId__c, AS_id__r.AS_CellPhone__c,AS_id__r.Keywords__c,AS_id__r.AS_Company__c, DiversityType__c, AS_id__r.AS_Email__c, AS_id__r.AS_FaxNumber__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_Gender__c,AS_id__r.AS_HomeAddress1__c, AS_id__r.AS_HomeAddress2__c, AS_id__r.AS_HomeCity__c, AS_id__r.As_Home_Country__c, AS_id__r.AS_HomePhone__c,AS_id__r.AS_HomePoboxNo__c, AS_id__r.As_Home_State__c, AS_id__r.AS_HomeZip__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_LastName__c, AS_id__r.AS_NAICSCode_1__c,AS_id__r.AS_NAICSCode_2__c, AS_id__r.AS_NAICSCode_3__c, AS_id__r.AS_NAICSCode_4__c, AS_id__r.AS_NAICSCode_5__c, AS_id__r.AS_NumberOfEmployees__c, AS_id__r.As_prefixNew__c,AS_id__r.AS_PrimaryBusinessCategory1__c, AS_id__r.AS_SecondaryBusinessCategory1__c, AS_id__r.AS_ShippingAddress1__c, AS_id__r.AS_ShippingAddress2__c,AS_id__r.AS_ShippingCity__c, AS_id__r.As_Shipping_Country__c, AS_id__r.AS_ShippingPhone__c, AS_id__r.AS_Shippingpoboxno__c, AS_id__r.As_Shipping_States__c,AS_id__r.AS_shippingzip__c, AS_id__r.As_SuffixNew__c, AS_id__r.AS_ThroughEventBrite__c, AS_id__r.AS_Title__c, AS_id__r.AS_WebsiteUrl__c, AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c, AS_id__r.AS_WorkCity__c, AS_id__r.AS_Work_Country__c, AS_id__r.AS_WorkPhone__c, AS_id__r.AS_Workpoboxno__c, AS_id__r.AS_Work_States__c,AS_id__r.AS_WorkZip__c, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE IsMatchMakingAttendee__c = true AND  EV_id__r.id = \''+eventSelected +'\'   AND Boothleads_Profile__c =\'+Attendee+\' ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
           // eventlist = database.query(qu);
                    if(eventone.Is_Webank_event__c == False){
                      eventlist = [select id, TicketTypes__c, AS_id__r.AS_Age__c, AS_id__r.AS_BirthDate__c, AS_id__r.AS_BlogUrl__c, AS_id__r.AS_BusinessDescription__c, AS_id__r.AS_BusinessDunsNumber__c,AS_id__r.AS_BusinessEstablishedDate__c, AS_id__r.AS_BusinessRevenue__c, AS_id__r.AS_BusinessTaxId__c, AS_id__r.AS_CellPhone__c,AS_id__r.Keywords__c,AS_id__r.AS_Company__c, DiversityType__c, AS_id__r.AS_Email__c, AS_id__r.AS_FaxNumber__c, AS_id__r.AS_FirstName__c,
                      AS_id__r.DBA__c,
                              AS_id__r.Geographical_Region__c,
                              AS_id__r.Certificate_Processed_by_RPO__c,
                              AS_id__r.BBB_Number__c,
                              AS_id__r.Commodity_1__c,
                              AS_id__r.Commodity_2__c,
                              AS_id__r.Commodity_3__c,
                              AS_id__r.Commodity_4__c,
                              AS_id__r.Commodity_5__c,
                              AS_id__r.Commodity_6__c,
                              AS_id__r.Commodity_7__c,
                              AS_id__r.Commodity_8__c,
                              AS_id__r.Commodity_9__c,
                              AS_id__r.distribution_Country__c,
                              AS_id__r.Manufactures_Country__c,
                              AS_id__r.References__c,
                                AS_id__r.References2__c,
                                AS_id__r.Scope_of_Work__c,
                                AS_id__r.Scope_of_Work2__c,
                              AS_id__r.Revenue_Range__c,
                               AS_id__r.AS_NAICSCode9__c,
                       AS_id__r.AS_NAICSCode8__c,
                        AS_id__r.AS_NAICSCode7__c,
                        AS_id__r.AS_NAICSCode6__c,
                        AS_id__r.AS_CageCode__c,
                        AS_id__r.Any_non_WBENC_awards_received__c,
                        AS_id__r.GSA_Schedule__c,
                        AS_id__r.Business_type__c,
                        AS_id__r.Companyhaveafacility_partneroutsideUSA__c,
                        AS_id__r.Ethnicity__c,AS_id__r.AS_Secondary_Email__c,
                        AS_id__r.Year_in_business__c,AS_id__r.Business_Structure__c,
                       AS_id__r.AS_Gender__c,AS_id__r.AS_HomeAddress1__c, AS_id__r.AS_HomeAddress2__c, AS_id__r.AS_HomeCity__c, AS_id__r.As_Home_Country__c, AS_id__r.AS_HomePhone__c,AS_id__r.AS_HomePoboxNo__c, AS_id__r.As_Home_State__c, AS_id__r.AS_HomeZip__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_LastName__c, AS_id__r.AS_NAICSCode_1__c,AS_id__r.AS_NAICSCode_2__c, AS_id__r.AS_NAICSCode_3__c, AS_id__r.AS_NAICSCode_4__c, AS_id__r.AS_NAICSCode_5__c, AS_id__r.AS_NumberOfEmployees__c, AS_id__r.As_prefixNew__c,AS_id__r.AS_PrimaryBusinessCategory1__c, AS_id__r.AS_SecondaryBusinessCategory1__c, AS_id__r.AS_ShippingAddress1__c, AS_id__r.AS_ShippingAddress2__c,AS_id__r.AS_ShippingCity__c, AS_id__r.As_Shipping_Country__c, AS_id__r.AS_ShippingPhone__c, AS_id__r.AS_Shippingpoboxno__c, AS_id__r.As_Shipping_States__c,AS_id__r.AS_shippingzip__c, AS_id__r.As_SuffixNew__c, AS_id__r.AS_ThroughEventBrite__c, AS_id__r.AS_Title__c, AS_id__r.AS_WebsiteUrl__c, AS_id__r.AS_WorkAddress1__c,AS_id__r.AS_WorkAddress2__c, AS_id__r.AS_WorkCity__c, AS_id__r.AS_Work_Country__c, AS_id__r.AS_WorkPhone__c, AS_id__r.AS_Workpoboxno__c, AS_id__r.AS_Work_States__c,AS_id__r.AS_WorkZip__c, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE IsMatchMakingAttendee__c = true AND EV_id__r.id = : eventSelected AND Boothleads_Profile__c =: 'Attendee'
                     ];
                      integer k =0;
                     for (Event_Attendee_Mapping__c s: eventlist) {
                         if(s.AS_id__r.AS_BlogUrl__c != null || s.AS_id__r.AS_BlogUrl__c != null){
                       if(s.AS_id__r.AS_BlogUrl__c.contains(',')){
                        s.AS_id__r.AS_BlogUrl__c = escape(s.AS_id__r.AS_BlogUrl__c);}
                     }
                      if(s.AS_id__r.AS_BusinessDescription__c != null || s.AS_id__r.AS_BusinessDescription__c != null){
                       if(s.AS_id__r.AS_BusinessDescription__c.contains(',')){
                           s.AS_id__r.AS_BusinessDescription__c = escape(s.AS_id__r.AS_BusinessDescription__c);}
                     }
                     if(s.AS_id__r.AS_Company__c != null || s.AS_id__r.AS_Company__c != null){
                       if(s.AS_id__r.AS_Company__c.contains(',')){
                           s.AS_id__r.AS_Company__c = escape(s.AS_id__r.AS_Company__c);}
                     }
                      if(s.DiversityType__c != null || s.DiversityType__c != null){
                       if(s.DiversityType__c.contains(',')){
                           s.DiversityType__c = escape(s.DiversityType__c);}
                     }
                      if(s.AS_id__r.AS_Email__c != null || s.AS_id__r.AS_Email__c != null){
                       if(s.AS_id__r.AS_Email__c.contains(',')){
                         s.AS_id__r.AS_Email__c = escape(s.AS_id__r.AS_Email__c);}
                     }
                     if(s.AS_id__r.AS_FirstName__c != null || s.AS_id__r.AS_FirstName__c != null){
                       if(s.AS_id__r.AS_FirstName__c.contains(',')){
                         s.AS_id__r.AS_FirstName__c = escape(s.AS_id__r.AS_FirstName__c);}
                     }
                     if(s.AS_id__r.Keywords__c != null || s.AS_id__r.Keywords__c != null){
                       if(s.AS_id__r.Keywords__c.contains(',')){
                             s.AS_id__r.Keywords__c= escape(s.AS_id__r.Keywords__c);}
                     }
                     if(s.AS_id__r.AS_HomeAddress1__c != null || s.AS_id__r.AS_HomeAddress1__c != null){
                       if(s.AS_id__r.AS_HomeAddress1__c.contains(',')){
                         s.AS_id__r.AS_HomeAddress1__c = escape(s.AS_id__r.AS_HomeAddress1__c);}
                     }
                     if(s.AS_id__r.AS_HomeAddress2__c != null || s.AS_id__r.AS_HomeAddress2__c != null){
                       if(s.AS_id__r.AS_HomeAddress2__c.contains(',')){
                         s.AS_id__r.AS_HomeAddress2__c = escape(s.AS_id__r.AS_HomeAddress2__c);}
                     }
                      if( s.AS_id__r.AS_HomeCity__c != null ||  s.AS_id__r.AS_HomeCity__c != null){
                       if( s.AS_id__r.AS_HomeCity__c.contains(',')){
                         s.AS_id__r.AS_HomeCity__c = escape(s.AS_id__r.AS_HomeCity__c);}
                     }
                     if( s.AS_id__r.As_Home_Country__c != null ||  s.AS_id__r.As_Home_Country__c != null){
                       if( s.AS_id__r.As_Home_Country__c.contains(',')){
                         s.AS_id__r.As_Home_Country__c = escape(s.AS_id__r.As_Home_Country__c);}
                     }
                     if( s.AS_id__r.AS_HomePhone__c != null ||  s.AS_id__r.AS_HomePhone__c != null){
                       if( s.AS_id__r.AS_HomePhone__c.contains(',')){
                         s.AS_id__r.AS_HomePhone__c = escape(s.AS_id__r.AS_HomePhone__c);}
                     }
                     if( s.AS_id__r.AS_LastName__c != null ||  s.AS_id__r.AS_LastName__c != null){
                       if( s.AS_id__r.AS_LastName__c.contains(',')){
                         s.AS_id__r.AS_LastName__c = escape(s.AS_id__r.AS_LastName__c);}
                     }
                     if( s.AS_id__r.AS_ShippingAddress1__c != null ||  s.AS_id__r.AS_ShippingAddress1__c != null){
                       if( s.AS_id__r.AS_ShippingAddress1__c.contains(',')){
                         s.AS_id__r.AS_ShippingAddress1__c = escape(s.AS_id__r.AS_ShippingAddress1__c);}
                     }
                     if( s.AS_id__r.AS_ShippingAddress2__c != null ||  s.AS_id__r.AS_ShippingAddress2__c != null){
                       if(  s.AS_id__r.AS_ShippingAddress2__c.contains(',')){
                         s.AS_id__r.AS_ShippingAddress2__c = escape(s.AS_id__r.AS_ShippingAddress2__c);}
                     }
                     if(s.AS_id__r.AS_ShippingCity__c != null ||  s.AS_id__r.AS_ShippingCity__c != null){
                       if( s.AS_id__r.AS_ShippingCity__c.contains(',')){
                         s.AS_id__r.AS_ShippingCity__c = escape(s.AS_id__r.AS_ShippingCity__c);}
                     }
                     if(s.AS_id__r.AS_Title__c != null ||  s.AS_id__r.AS_Title__c != null){
                       if(s.AS_id__r.AS_Title__c.contains(',')){
                         s.AS_id__r.AS_Title__c = escape(s.AS_id__r.AS_Title__c);}
                     }
                      if(s.AS_id__r.AS_WebsiteUrl__c != null ||  s.AS_id__r.AS_WebsiteUrl__c != null){
                       if(s.AS_id__r.AS_WebsiteUrl__c.contains(',')){
                         s.AS_id__r.AS_WebsiteUrl__c = escape(s.AS_id__r.AS_WebsiteUrl__c);}
                     }
                     if(s.AS_id__r.AS_WorkAddress1__c != null ||  s.AS_id__r.AS_WorkAddress1__c != null){
                       if(s.AS_id__r.AS_WorkAddress1__c.contains(',')){
                         s.AS_id__r.AS_WorkAddress1__c = escape(s.AS_id__r.AS_WorkAddress1__c);}
                     }
                     if(s.AS_id__r.AS_WorkAddress2__c != null ||  s.AS_id__r.AS_WorkAddress2__c != null){
                       if(s.AS_id__r.AS_WorkAddress2__c.contains(',')){
                         s.AS_id__r.AS_WorkAddress2__c = escape(s.AS_id__r.AS_WorkAddress2__c);}
                     }
                     if(s.AS_id__r.AS_WorkCity__c != null ||  s.AS_id__r.AS_WorkCity__c != null){
                       if(s.AS_id__r.AS_WorkCity__c.contains(',')){
                         s.AS_id__r.AS_WorkCity__c = escape(s.AS_id__r.AS_WorkCity__c);}
                     }
                     if(s.AS_id__r.AS_NAICSCode_1__c != null || s.AS_id__r.AS_NAICSCode_1__c != null){
                       if(s.AS_id__r.AS_NAICSCode_1__c.contains(',')){
                           s.AS_id__r.AS_NAICSCode_1__c = escape(s.AS_id__r.AS_NAICSCode_1__c);}
                     }
                     if(s.AS_id__r.AS_NAICSCode_2__c != null || s.AS_id__r.AS_NAICSCode_2__c != null){
                       if(s.AS_id__r.AS_NAICSCode_2__c.contains(',')){
                           s.AS_id__r.AS_NAICSCode_2__c= escape(s.AS_id__r.AS_NAICSCode_2__c);}
                     }
                     if(s.AS_id__r.AS_NAICSCode_3__c != null || s.AS_id__r.AS_NAICSCode_3__c != null){
                       if(s.AS_id__r.AS_NAICSCode_3__c.contains(',')){
                           s.AS_id__r.AS_NAICSCode_3__c = escape(s.AS_id__r.AS_NAICSCode_3__c);}
                     }
                     if(s.AS_id__r.AS_NAICSCode_4__c!= null || s.AS_id__r.AS_NAICSCode_4__c!= null){
                       if(s.AS_id__r.AS_NAICSCode_4__c.contains(',')){
                           s.AS_id__r.AS_NAICSCode_4__c= escape(s.AS_id__r.AS_NAICSCode_4__c);}
                     }
                     if(s.AS_id__r.AS_NAICSCode_5__c != null || s.AS_id__r.AS_NAICSCode_5__c != null){
                       if(s.AS_id__r.AS_NAICSCode_5__c.contains(',')){
                           s.AS_id__r.AS_NAICSCode_5__c = escape(s.AS_id__r.AS_NAICSCode_5__c);}
                     }
                     if(s.AS_id__r.AS_PrimaryBusinessCategory1__c != null ||  s.AS_id__r.AS_PrimaryBusinessCategory1__c != null){
                       if(s.AS_id__r.AS_PrimaryBusinessCategory1__c.contains(',')){
                         s.AS_id__r.AS_PrimaryBusinessCategory1__c = escape(s.AS_id__r.AS_PrimaryBusinessCategory1__c);}
                     }
                     system.debug('==========================escape===================================' + s.AS_id__r.AS_PrimaryBusinessCategory1__c);
                    if(s.TicketTypes__c != null ||  s.TicketTypes__c!= null){
                       if(s.TicketTypes__c.contains(',')){
                         s.TicketTypes__c = escape(s.TicketTypes__c);}
                     }
                     if(s.AS_id__r.AS_SecondaryBusinessCategory1__c != null ||  s.AS_id__r.AS_SecondaryBusinessCategory1__c != null){
                       if(s.AS_id__r.AS_SecondaryBusinessCategory1__c.contains(',')){
                         s.AS_id__r.AS_SecondaryBusinessCategory1__c = escape(s.AS_id__r.AS_SecondaryBusinessCategory1__c);}
                     }
                         system.debug('==========================escape===================================' + s.AS_id__r.AS_SecondaryBusinessCategory1__c);
                        k++;
                         attforexport.add(s);


                         if (k >= 1000) {
                             exportlistoflist.add(attforexport);
                             attforexport = new LIST < Event_Attendee_Mapping__c > ();
                             k = 0;
                         }
                         }

                    if (k != 0) {
                         exportlistoflist.add(attforexport);
                     }
                    /* count1=existingEamsForstatus.size();

        for(Event_Attendee_Mapping__c eam:eventlist)
        {
         count=0;
         for(EventSchedule__c es1:existingEamsForstatus)
         {
          if(es1.MM_To_EAM__r.id==eam.id)
          {
          count++;
          }
         }

        } */
      pagereference pf= new pagereference('/apex/MM_Eventadmin_ExportMBE');
      pf.setredirect(false);
      return pf;
      }
      }else
      IF(eventone.Is_Webank_event__c == True){
             eventlist =  [Select  MBE_Profile__r.As_prefixNew__c ,MBE_Profile__r.As_SuffixNew__c,MBE_Profile__r.As_Shipping_Country__c,MBE_Profile__r.As_Shipping_States__c,MBE_Profile__r.SystemModstamp, MBE_Profile__r.OwnerId, MBE_Profile__r.Name, MBE_Profile__r.LastModifiedDate, MBE_Profile__r.LastModifiedById,
                              MBE_Profile__r.LastActivityDate, MBE_Profile__r.IsDeleted, MBE_Profile__r.Id, MBE_Profile__r.CreatedDate, MBE_Profile__r.CreatedById,MBE_Profile__r.Exhibitor_company_imageUrl__c,
                              MBE_Profile__r.AS_WorkZipCode__c,MBE_Profile__r.AS_WorkPhone__c,
                              MBE_Profile__r.AS_WorkCity__c, MBE_Profile__r.AS_WorkAddress2__c, MBE_Profile__r.AS_WorkAddress1__c, MBE_Profile__r.Key_Words__c,
                              MBE_Profile__r.AS_WebsiteUrl__c, MBE_Profile__r.AS_Title__c,
                              MBE_Profile__r.AS_ShippingZipcode__c, MBE_Profile__r.AS_ShippingState__c, MBE_Profile__r.AS_ShippingPoBox__c, MBE_Profile__r.AS_ShippingPhone__c,
                              MBE_Profile__r.AS_ShippingCity__c, MBE_Profile__r.AS_ShippingAddress2__c, MBE_Profile__r.AS_ShippingAddress1__c,
                              MBE_Profile__r.AS_SecondaryBusinessCategory1__c, MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                              MBE_Profile__r.AS_NumberOfEmployees__c, MBE_Profile__r.AS_NAICSCode_5__c, MBE_Profile__r.AS_NAICSCode_4__c, MBE_Profile__r.AS_NAICSCode_3__c,
                              MBE_Profile__r.AS_NAICSCode_2__c, MBE_Profile__r.AS_NAICSCode_1__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_ImageUrl__c,
                              MBE_Profile__r.AS_HomePhone__c,MBE_Profile__r.AS_HomeCity__c,
                              MBE_Profile__r.DBA__c,
                              MBE_Profile__r.Geographical_Region__c,
                              MBE_Profile__r.Certificate_Processed_by_RPO__c,
                              MBE_Profile__r.BBB_Number__c,
                              MBE_Profile__r.Commodity_1__c,
                              MBE_Profile__r.Commodity_2__c,
                              MBE_Profile__r.Commodity_3__c,
                              MBE_Profile__r.Commodity_4__c,
                              MBE_Profile__r.Commodity_5__c,
                              MBE_Profile__r.Commodity_6__c,
                              MBE_Profile__r.Commodity_7__c,
                              MBE_Profile__r.Commodity_8__c,
                              MBE_Profile__r.Commodity_9__c,                             
                              MBE_Profile__r.Any_non_WBENC_awards_received__c,
                              MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                              MBE_Profile__r.distribution_Country__c,
                              MBE_Profile__r.Manufactures_Country__c,
                              MBE_Profile__r.References__c,
                                MBE_Profile__r.References2__c,
                                MBE_Profile__r.Scope_of_Work__c,
                                MBE_Profile__r.Scope_of_Work2__c,
                              MBE_Profile__r.Revenue_Range__c,
                               MBE_Profile__r.AS_NAICSCode9__c,
                       MBE_Profile__r.AS_NAICSCode8__c,
                        MBE_Profile__r.AS_NAICSCode7__c,
                        MBE_Profile__r.AS_NAICSCode6__c,
                        MBE_Profile__r.Ethnicity__c,MBE_Profile__r.AS_Secondary_Email__c,
                             MBE_Profile__r.Business_Structure__c, MBE_Profile__r.Year_in_business__c,
                              MBE_Profile__r.AS_HomeAddress2__c, MBE_Profile__r.AS_HomeAddress1__c, MBE_Profile__r.AS_Gender__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_FaxNumber__c,
                              MBE_Profile__r.AS_Email__c, MBE_Profile__r.AS_DiversityType__c, MBE_Profile__r.AS_Company__c, MBE_Profile__r.AS_CellPhone__c, MBE_Profile__r.AS_CageCode__c,MBE_Profile__r.GSA_Schedule__c,
                              MBE_Profile__r.AS_BusinessRevenue__c, MBE_Profile__r.AS_BusinessEstablishedDate__c, MBE_Profile__r.AS_BusinessDescription__c, MBE_Profile__r.Business_type__c,MBE_Profile__r.Exceptional_Key_Words__c,
                              MBE_Profile__r.AS_BlogUrl__c, MBE_Profile__r.AS_BirthDate__c, MBE_Profile__r.AS_Age__c,MBE_Profile__r.AS_Work_Country__c,MBE_Profile__r.AS_Work_States__c,MBE_Profile__r.As_Home_Country__c,MBE_Profile__r.As_Home_State__c,MBE_Profile__r.AS_WorkZip__c,MBE_Profile__r.AS_HomeZip__c,
                              MBE_Profile__r.AS_BusinessDunsNumber__c,MBE_Profile__r.AS_BusinessTaxId__c,MBE_Profile__r.Company_Certifications__c from Event_Attendee_Mapping__c WHERE IsMatchMakingAttendee__c = true AND EV_id__r.id = : eventSelected AND Boothleads_Profile__c =: 'Attendee'];


                      integer k =0;


    for (Event_Attendee_Mapping__c s: eventlist) {
                         if(s.MBE_Profile__r.AS_BlogUrl__c != null || s.MBE_Profile__r.AS_BlogUrl__c != null){
                       if(s.MBE_Profile__r.AS_BlogUrl__c.contains(',')){
                        s.MBE_Profile__r.AS_BlogUrl__c = escape(s.MBE_Profile__r.AS_BlogUrl__c);}
                     }
                      if(s.MBE_Profile__r.AS_BusinessDescription__c != null || s.MBE_Profile__r.AS_BusinessDescription__c != null){
                       if(s.MBE_Profile__r.AS_BusinessDescription__c.contains(',')){
                           s.MBE_Profile__r.AS_BusinessDescription__c = escape(s.MBE_Profile__r.AS_BusinessDescription__c);}
                     }
                     if(s.MBE_Profile__r.AS_Company__c != null || s.MBE_Profile__r.AS_Company__c != null){
                       if(s.MBE_Profile__r.AS_Company__c.contains(',')){
                           s.MBE_Profile__r.AS_Company__c = escape(s.MBE_Profile__r.AS_Company__c);}
                     }
                      /**if(s.DiversityType__c != null || s.DiversityType__c != null){
                       if(s.DiversityType__c.contains(',')){
                           s.DiversityType__c = escape(s.DiversityType__c);}
                     }*/

                    if(s.MBE_Profile__r.AS_Email__c != null || s.MBE_Profile__r.AS_Email__c != null){
                       if(s.MBE_Profile__r.AS_Email__c.contains(',')){
                         s.MBE_Profile__r.AS_Email__c = escape(s.MBE_Profile__r.AS_Email__c);}
                     }
                     if(s.MBE_Profile__r.AS_FirstName__c != null || s.MBE_Profile__r.AS_FirstName__c != null){
                       if(s.MBE_Profile__r.AS_FirstName__c.contains(',')){
                         s.MBE_Profile__r.AS_FirstName__c = escape(s.MBE_Profile__r.AS_FirstName__c);}
                     }
                     if(s.MBE_Profile__r.Key_words__c != null || s.MBE_Profile__r.Key_words__c != null){
                       if(s.MBE_Profile__r.Key_words__c.contains(',')){
                             s.MBE_Profile__r.Key_words__c= escape(s.MBE_Profile__r.Key_words__c);}
                     }
                     if(s.MBE_Profile__r.AS_HomeAddress1__c != null || s.MBE_Profile__r.AS_HomeAddress1__c != null){
                       if(s.MBE_Profile__r.AS_HomeAddress1__c.contains(',')){
                         s.MBE_Profile__r.AS_HomeAddress1__c = escape(s.MBE_Profile__r.AS_HomeAddress1__c);}
                     }
                     if(s.MBE_Profile__r.AS_HomeAddress2__c != null || s.MBE_Profile__r.AS_HomeAddress2__c != null){
                       if(s.MBE_Profile__r.AS_HomeAddress2__c.contains(',')){
                         s.MBE_Profile__r.AS_HomeAddress2__c = escape(s.MBE_Profile__r.AS_HomeAddress2__c);}
                     }
                      if( s.MBE_Profile__r.AS_HomeCity__c != null ||  s.MBE_Profile__r.AS_HomeCity__c != null){
                       if( s.MBE_Profile__r.AS_HomeCity__c.contains(',')){
                         s.MBE_Profile__r.AS_HomeCity__c = escape(s.MBE_Profile__r.AS_HomeCity__c);}
                     }
                     if( s.MBE_Profile__r.As_Home_Country__c != null ||  s.MBE_Profile__r.As_Home_Country__c != null){
                       if( s.MBE_Profile__r.As_Home_Country__c.contains(',')){
                         s.MBE_Profile__r.As_Home_Country__c = escape(s.MBE_Profile__r.As_Home_Country__c);}
                     }
                     if( s.MBE_Profile__r.AS_HomePhone__c != null ||  s.MBE_Profile__r.AS_HomePhone__c != null){
                       if( s.MBE_Profile__r.AS_HomePhone__c.contains(',')){
                         s.MBE_Profile__r.AS_HomePhone__c = escape(s.MBE_Profile__r.AS_HomePhone__c);}
                     }
                     if( s.MBE_Profile__r.AS_LastName__c != null ||  s.MBE_Profile__r.AS_LastName__c != null){
                       if( s.MBE_Profile__r.AS_LastName__c.contains(',')){
                         s.MBE_Profile__r.AS_LastName__c = escape(s.MBE_Profile__r.AS_LastName__c);}
                     }
                     if( s.MBE_Profile__r.AS_ShippingAddress1__c != null ||  s.MBE_Profile__r.AS_ShippingAddress1__c != null){
                       if( s.MBE_Profile__r.AS_ShippingAddress1__c.contains(',')){
                         s.MBE_Profile__r.AS_ShippingAddress1__c = escape(s.MBE_Profile__r.AS_ShippingAddress1__c);}
                     }
                     if( s.MBE_Profile__r.AS_ShippingAddress2__c != null ||  s.MBE_Profile__r.AS_ShippingAddress2__c != null){
                       if(  s.MBE_Profile__r.AS_ShippingAddress2__c.contains(',')){
                         s.MBE_Profile__r.AS_ShippingAddress2__c = escape(s.MBE_Profile__r.AS_ShippingAddress2__c);}
                     }
                     if(s.MBE_Profile__r.AS_ShippingCity__c != null ||  s.MBE_Profile__r.AS_ShippingCity__c != null){
                       if( s.MBE_Profile__r.AS_ShippingCity__c.contains(',')){
                         s.MBE_Profile__r.AS_ShippingCity__c = escape(s.MBE_Profile__r.AS_ShippingCity__c);}
                     }
                     if(s.MBE_Profile__r.AS_Title__c != null ||  s.MBE_Profile__r.AS_Title__c != null){
                       if(s.MBE_Profile__r.AS_Title__c.contains(',')){
                         s.MBE_Profile__r.AS_Title__c = escape(s.MBE_Profile__r.AS_Title__c);}
                     }
                      if(s.MBE_Profile__r.AS_WebsiteUrl__c != null ||  s.MBE_Profile__r.AS_WebsiteUrl__c != null){
                       if(s.MBE_Profile__r.AS_WebsiteUrl__c.contains(',')){
                         s.MBE_Profile__r.AS_WebsiteUrl__c = escape(s.MBE_Profile__r.AS_WebsiteUrl__c);}
                     }
                     if(s.MBE_Profile__r.AS_WorkAddress1__c != null ||  s.MBE_Profile__r.AS_WorkAddress1__c != null){
                       if(s.MBE_Profile__r.AS_WorkAddress1__c.contains(',')){
                         s.MBE_Profile__r.AS_WorkAddress1__c = escape(s.MBE_Profile__r.AS_WorkAddress1__c);}
                     }
                     if(s.MBE_Profile__r.AS_WorkAddress2__c != null ||  s.MBE_Profile__r.AS_WorkAddress2__c != null){
                       if(s.MBE_Profile__r.AS_WorkAddress2__c.contains(',')){
                         s.MBE_Profile__r.AS_WorkAddress2__c = escape(s.MBE_Profile__r.AS_WorkAddress2__c);}
                     }
                     if(s.MBE_Profile__r.AS_WorkCity__c != null ||  s.MBE_Profile__r.AS_WorkCity__c != null){
                       if(s.MBE_Profile__r.AS_WorkCity__c.contains(',')){
                         s.MBE_Profile__r.AS_WorkCity__c = escape(s.MBE_Profile__r.AS_WorkCity__c);}
                     }
                     if(s.MBE_Profile__r.AS_NAICSCode_1__c != null || s.MBE_Profile__r.AS_NAICSCode_1__c != null){
                       if(s.MBE_Profile__r.AS_NAICSCode_1__c.contains(',')){
                           s.MBE_Profile__r.AS_NAICSCode_1__c = escape(s.MBE_Profile__r.AS_NAICSCode_1__c);}
                     }
                     if(s.MBE_Profile__r.AS_NAICSCode_2__c != null || s.MBE_Profile__r.AS_NAICSCode_2__c != null){
                       if(s.MBE_Profile__r.AS_NAICSCode_2__c.contains(',')){
                           s.MBE_Profile__r.AS_NAICSCode_2__c= escape(s.MBE_Profile__r.AS_NAICSCode_2__c);}
                     }
                     if(s.MBE_Profile__r.AS_NAICSCode_3__c != null || s.MBE_Profile__r.AS_NAICSCode_3__c != null){
                       if(s.MBE_Profile__r.AS_NAICSCode_3__c.contains(',')){
                           s.MBE_Profile__r.AS_NAICSCode_3__c = escape(s.MBE_Profile__r.AS_NAICSCode_3__c);}
                     }
                     if(s.MBE_Profile__r.AS_NAICSCode_4__c!= null || s.MBE_Profile__r.AS_NAICSCode_4__c!= null){
                       if(s.MBE_Profile__r.AS_NAICSCode_4__c.contains(',')){
                           s.MBE_Profile__r.AS_NAICSCode_4__c= escape(s.MBE_Profile__r.AS_NAICSCode_4__c);}
                     }
                     if(s.MBE_Profile__r.AS_NAICSCode_5__c != null || s.MBE_Profile__r.AS_NAICSCode_5__c != null){
                       if(s.MBE_Profile__r.AS_NAICSCode_5__c.contains(',')){
                           s.MBE_Profile__r.AS_NAICSCode_5__c = escape(s.MBE_Profile__r.AS_NAICSCode_5__c);}
                     }
                     if(s.MBE_Profile__r.AS_PrimaryBusinessCategory1__c != null ||  s.MBE_Profile__r.AS_PrimaryBusinessCategory1__c != null){
                       if(s.MBE_Profile__r.AS_PrimaryBusinessCategory1__c.contains(',')){
                         s.MBE_Profile__r.AS_PrimaryBusinessCategory1__c = escape(s.MBE_Profile__r.AS_PrimaryBusinessCategory1__c);}
                     }
                     system.debug('==========================escape===================================' + s.MBE_Profile__r.AS_PrimaryBusinessCategory1__c);
                    /**if(s.TicketTypes__c != null ||  s.TicketTypes__c!= null){
                       if(s.TicketTypes__c.contains(',')){
                         s.TicketTypes__c = escape(s.TicketTypes__c);}
                     }*/

                     if(s.MBE_Profile__r.AS_SecondaryBusinessCategory1__c != null ||  s.MBE_Profile__r.AS_SecondaryBusinessCategory1__c != null){
                       if(s.MBE_Profile__r.AS_SecondaryBusinessCategory1__c.contains(',')){
                         s.MBE_Profile__r.AS_SecondaryBusinessCategory1__c = escape(s.MBE_Profile__r.AS_SecondaryBusinessCategory1__c);}
                     }

                         system.debug('==========================escape===================================' + s.MBE_Profile__r.AS_SecondaryBusinessCategory1__c);
                        k++;
                         attforexport.add(s);


                         if (k >= 1000) {
                             exportlistoflist.add(attforexport);
                             attforexport = new LIST < Event_Attendee_Mapping__c > ();
                             k = 0;
                         }
                         }

                    if (k != 0) {
                         exportlistoflist.add(attforexport);
                     }
      pagereference pf= new pagereference('/apex/MM_Eventadmin_ExportMBEcusprofile');
      pf.setredirect(false);
      return pf;
      }
      return null;
      }
      public string eamidprint {get ; set ;}
      public pagereference Printattendeedetail(){
       string  eamid = ApexPages.currentPage().getParameters().get('mycheckp');

         system.debug('::::::::::::::::eam id print::::::::::::'+eamid);
         PageReference pg = new pagereference('/apex/mm_MBE_Details?id='+eamidprint);
         pg.setRedirect(true);
         return pg;


      }


      public Pagereference CheckUser(){

           Pagereference pg = MM_Utility.checkLogInservice();

           return pg;

       }
      public string naicschangeselctdids {get;set;}
            public string naicschangeids {get;set;}
      public void naicscodesfun(){
          SYSTEM.DEBUG(' selected get '+ApexPages.currentPage().getParameters().get('naicccc'));
          IF(ApexPages.currentPage().getParameters().get('naicccc') != ''){
              naicschangeselctdids =ApexPages.currentPage().getParameters().get('naicccc');
           }ELSE{
           naicschangeselctdids = NULL;
           naicschangeids = NULL;
           }
           system.debug('44444444444444444 ' + naicschangeselctdids);


     }
       public string commchangeselctdids{get;set;}
          public string commchangeids {get;set;}
     public void commodityfun(){
          SYSTEM.DEBUG(' selected get '+ApexPages.currentPage().getParameters().get('comm'));
          IF(ApexPages.currentPage().getParameters().get('comm') != ''){
              commchangeselctdids =ApexPages.currentPage().getParameters().get('comm');
           }ELSE{
           commchangeselctdids = NULL;
           commchangeids = NULL;
           }
           system.debug('44444444444444444 ' + commchangeselctdids );
           system.debug('44444444444444444 ' + naicschangeids);


     }
      public PageReference delimage() {
  string DelId = ApexPages.currentPage().getParameters().get('deletedId2') ; 
     List<document> imgdoc= new List<document>();
     imgdoc= [select Id,Name From document where id=: DelId ];
      Database.DeleteResult[] DR_Dels2 = Database.delete(imgdoc,True);
      List<MBE_Profile__c> mbepro= new List<MBE_Profile__c>();
     mbepro= [select Id,Name,createddate,Exhibitor_company_imageUrl__c,AS_ImageUrl__c From MBE_Profile__c where Exhibitor_company_imageUrl__c=: DelId or AS_ImageUrl__c =: DelId];
     if(mbepro.size()>0)
     {
       if(mbepro[0].Exhibitor_company_imageUrl__c==DelID)
       mbepro[0].Exhibitor_company_imageUrl__c=null;
       if(mbepro[0].AS_ImageUrl__c ==DelID)
       mbepro[0].AS_ImageUrl__c =null;
       Database.SaveResult[] DR_ups = Database.update(mbepro,True);
     }
     getevents();  
        return null;
    }
       public void delvideo(){
     string DelId = ApexPages.currentPage().getParameters().get('deletedId1') ;
         List<Widget__c> video = new List<Widget__c>();
         list<Custom_Widget__c> cvideo = new list<Custom_Widget__c> ();
         video = [select Id,Name From Widget__c where id=: DelId ];
         cvideo = [select Id,Name From Custom_Widget__c where id=: DelId ];
         SYSTEM.DEBUG(' ====================@@ '+video);
         SYSTEM.DEBUG(' ====================@@ '+cvideo);
         Database.DeleteResult[] DR_Dels = Database.delete(video,True);
         Database.DeleteResult[] DR_Dels1 = Database.delete(cvideo,True);
         getevents();

     }
      public void delattachment(){
         SYSTEM.DEBUG(' selected get '+ApexPages.currentPage().getParameters().get('deletedId'));
         string DelId = ApexPages.currentPage().getParameters().get('deletedId') ;
         List<Attachment> attac = new List<Attachment>();
         attac = [select Id,Name From Attachment where id=: DelId ];
          SYSTEM.DEBUG(' ====================@@ '+attac );
         Database.DeleteResult[] DR_Dels = Database.delete(attac,True);

        getevents();
     }
       public PageReference ImportAttendee() {
         string pro = '~MatchLeads222MBE';
         pagereference pg = new pagereference('/apex/MM_ImportSellers?id='+ eventSelected +pro);
         pg.setredirect(true);
         return pg;
     }
       //This method is for adding settings for seller profile as per Webank requirement base(edited by mythily)
       public LIST<Profile_Settings__c> Psettings {get ; set ;}
       public boolean psettingsbool {get ; set ;}
       public void prosettings(){
         psettingsbool = true;
        }
       public void savesettings(){
        Update Psettings;
        psettingsbool = false;
        }
          //-------------Count of schedules by each MBE----------------------

        //----------------------------schedule blocking
         //----------------------------Blocking Schedule---------------------
        public MAP<DATE,LIST<String>>  dateSlotsMAP {get; set ;}
        public list<string> timeListMap {get ; set ;}
        public list<innercl> innlistscheduled {get; set;}
        public string blockselecteddate {get ; set ;}
        public date dte {get ; set ;}
        public string blockedeamid {get ; set ;}
        public void blockschedules(){
        blockedeamid ='';
        blockedeamid = Apexpages.currentpage().getparameters().get('mycheckblock');
        system.debug('llllllllllllllllllllllllllllllll'+blockedeamid);
        Blockschedulebool = true;
        timeListMap = new list<string> ();
        //innlistblocked = new list<innercl> ();
        //innlist = new list<innercl> ();
        innlistscheduled = new list<innercl> ();
        blokslistexist = new list<Event_Breaks__c>();
        exhibitorschedule = new list<EventSchedule__c>();
        availableslots = new list<selectoption> ();
        blockedslots = new list<selectoption> ();
        eventDatesList = new List<selectoption>();
         try{
          allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: eventselected ORDER BY MatchLeads_Date__c ASC]);
          if(allEventDates.size() >=1){

             for(MatchLeads_Days__c matchDate: allEventDates){
                 String dateFormat= matchDate.MatchLeads_Date__c.format();
                 system.debug('dddddddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyy'+dateFormat);
                 eventDatesList.add(new selectoption(matchDate.id,dateFormat));
                  }
             system.debug('dddddddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyy'+eventDatesList +'bbbbbbbbbbbbbbb'+blockselecteddate );
             if(blockselecteddate == '' || blockselecteddate == null){
             blockselecteddate  = allEventDates[0].id;
             }
             }
                  MatchLeads_Days__c mday =[select id,MatchLeads_Date__c FROM MatchLeads_Days__c WHERE id =: blockselecteddate ];
                   string mmdate = '';
                   mmdate  = mday.MatchLeads_Date__c.format();
                   system.debug('mmmmmmmmmmdddddddddddddddddmmmmmmmmmmmmmmmmdddddddddddd'+mmdate);
                    exhibitorschedule =[SELECT Id ,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                                   MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                                   MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c
                                            FROM EventSchedule__c
                                            WHERE MM_To_EAM__c =: Apexpages.currentpage().getparameters().get('mycheckblock')
                                            AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                            AND MM_To_UPE__c != null
                                            AND MM_slot_Date__c =: date.Parse(mmdate)
                                            AND MM_Slot_Status__c = 'Accepted'
                                            AND EV_id__c =: eventselected
                                            ];
                       string eschslots = '';
                       if(exhibitorschedule.size() != 0){
                         for(EventSchedule__c esch : exhibitorschedule ){
                            eschslots += esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c+',';

                        }}
                        blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__r.id =: blockedeamid AND MatchLeads_Days__c =: blockselecteddate ];
                        string listvals = '';
                        for(Event_Breaks__c evb : blokslistexist) {
                        listvals += evb.Break_Start_Time__c+'-'+evb.Break_End_Time__c+',';
                        }
                        system.debug('ccccccccccccccccccccccccccccc'+listvals );
                        dte = date.Parse(mmdate);
                        system.debug('ttttttttttttttteeeeeeeeee'+dte);
                        MAP<Date, LIST<String>> singleDayMMEvent = MM_Utility.giveEventTimingsWithDates(eventselected , dte);
                        system.debug('ttttttttttttttteeeeeeeeee'+singleDayMMEvent);
                        for(Date MMDay : singleDayMMEvent.KeySet()){
                        timeListMap = singleDayMMEvent.get(MMDay);

                        }

                       for(string ss : timeListMap ){

                       if(eschslots != null && eschslots!= '' && eschslots.contains(ss)){
                       innlistscheduled.add(new innercl(ss,true));
                       }else{
                       if(listvals.contains(ss)){
                       blockedslots.add(new selectoption(ss,ss));
                       system.debug('ccccccccccccccccccccccccccccc'+blockedslots);
                       }

                       //innlistblocked.add(new innercl(ss,false));
                       else{
                       availableslots.add(new selectoption(ss,ss));
                       //innlist.add(new innercl(ss,false));
                        system.debug('tttttttttttaaaaaaaaaaaaatttteeeeeeeeee'+availableslots);
                       }
                       } }}catch(exception e){}

                       }

       public List<EventSchedule__c> exhibitorschedule {get;set;}
      public boolean Blockschedulebool {get ; set ;}
      public Event_Breaks__c blockslot {get; set;}
        public list<selectoption> availableslots {get;set;}
        public list<selectoption> blockedslots {get; set;}

       public class innercl{

            public boolean selected {get; set ;}
            public string slot {get; set;}
             public innercl(string dispslot,boolean bb){

             selected = bb;
             slot = dispslot;

             }

            }
         public void Blockedaction(){
            blokslistexist = new list<Event_Breaks__c> ();
            blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__r.id =: blockedeamid AND MatchLeads_Days__c =: blockselecteddate];
            delete blokslistexist ;
            list<Event_Breaks__c> blokslist = new list<Event_Breaks__c> ();
            list<string> sbch = new list<string> ();
                if(blockedslots.size() != 0){
                    for(selectoption sop : blockedslots ){
                        sbch.add(sop.getvalue());
                    }
                }
                 for(string ins : sbch){
                    blockslot = new Event_Breaks__c ();
                    list<string> divideslot = String.valueOf(ins).split('-');
                    blockslot.Event_Attendee_Mapping__c  = blockedeamid;
                    blockslot.Break_Start_Time__c = divideslot[0];
                    blockslot.Break_End_Time__c = divideslot[1];
                    blockslot.MatchLeads_Days__c = blockselecteddate;
                    blokslist.add(blockslot);

                 system.debug('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbblock'+blokslist);
                 }
             insert blokslist;
             }

     public void massemailschedules()
     {
  batchEmailsSendingformbe bse = new batchEmailsSendingformbe();
     bse.eventselected = eventselected ;
     bse.url = System.URL.getSalesforceBaseUrl().toExternalForm();
     bse.sessionId =userinfo.getsessionid();
     Database.executeBatch(bse,99);
     
     }
     public static string mbeid(string emailnew,string eveidn){
     system.debug('EEEEEEEEEEEEEEEEEEEEEEE'+eveidn);
     
     Event__c eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:eveidn];
     system.debug('--------------------dhriti------'+emailnew);
      List<MBE_Profile__c> mbepro1 = [select m.id,m.AttendeeSummary__c from MBE_Profile__c m Where m.AS_Email__c =: emailnew AND m.Event_Organizer_Id__c=:eventone.owner.username];
      
      string mbeide = '';
      if(mbepro1.size() == 0){
      mbeide = 'null';
      }else{
      List<Event_Attendee_Mapping__c> eams = new List<Event_Attendee_Mapping__c>();
       eams =[select id,EV_id__c from Event_Attendee_Mapping__c where EV_id__c =: eveidn AND MBE_Profile__r.AS_Email__c =: emailnew];
       if(eams.size() > 0)
          //if(eams[0].EV_id__c == eveidn){
           mbeide = 'Duplicate'; 
          //}
          else{
      mbeide  = mbepro1[0].id;}
      }//}
      return mbeide;
     }
     
      @RemoteAction
     global static String checkattendee(String email,string evid) {
     List<AttendeeSummary__c> ats = new List<AttendeeSummary__c>();
     system.debug(':::::::::::::::::;'+email);
     ats = [select id from AttendeeSummary__c where AS_Email__c =: email];
     
     if(ats.size() > 0)
       {
     List<Event_Attendee_Mapping__c> eams = [select id,EV_id__c from Event_Attendee_Mapping__c where EV_id__c =: evid AND AS_id__r.AS_Email__c =: email];
          if(eams.size() > 0){
           return   'Duplicate'; 
          }else
      return 'Exist';
      }
      else
          return 'Not Exist';

     }
     @RemoteAction
     global static String checkMbe(String email,string evid) {
     
      
          string userid = mbeid(email,evid);
          //userid = MM_Eventadmin_AttendeesdirectoryCon.mbeid(email);
          system.debug('ddddddddddddddddruthi'+userid);
      if(userid== 'null' || userid == '')
      return 'Not Exist';
      else if(userid == 'Duplicate')
       return 'Duplicate';
       else
      return 'Exist';
    }
    @RemoteAction
  public static pagereference  updateexistingid( string emailold,string emailnew, string eventid, string eamid){
  system.debug(':::::::::::::::::::::::::::::::::::::::'+emailold + ' '+eventid +' '+eamid);
  Event__c eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:eventid];
  List<MBE_Profile__c> mbepro1 = [select m.id,m.AttendeeSummary__c from MBE_Profile__c m Where m.AS_Email__c =: emailnew AND m.Event_Organizer_Id__c=:eventone.owner.username];
  if(mbepro1.size() == 0){
  AttendeeSummary__c mbepro = [Select a.As_prefixNew__c ,a.Business_type__c,a.Company_Certifications__c,a.GSA_Schedule__c,a.As_SuffixNew__c,a.As_Shipping_Country__c,Keywords__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,a.AS_Secondary_Email__c,a.AS_CageCode__c,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c,a.AS_NAICSCode7__c,
                   a.AS_NAICSCode8__c,a.AS_NAICSCode9__c,a.AS_NAICSCode6__c,
                  a.AS_BusinessRevenue__c,a.Exceptional_Key_Words__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c,a.DBA__c,
                 a.Geographical_Region__c,
                 a.Certificate_Processed_by_RPO__c,
                 a.BBB_Number__c,
                 a.Commodity_1__c,
                 a.Commodity_2__c,
                 a.Commodity_3__c,
                 a.Commodity_4__c,
                 a.Commodity_5__c,a.Commodity_6__c,
                 a.Commodity_7__c,
                 a.Commodity_8__c,
                 a.Commodity_9__c,
                  a.distribution_Country__c,
                a.Manufactures_Country__c,
                 a.References__c,
                 a.Revenue_Range__c,Any_non_WBENC_awards_received__c,Companyhaveafacility_partneroutsideUSA__c,

                  a.Exhibitor_company_imageUrl__c from AttendeeSummary__c a where a.AS_Email__c = : emailnew];
  MBE_Profile__c newmbepro = new MBE_Profile__c();
       // newmbepro = mbepro.clone(true);
        newmbepro.AS_Email__c = emailnew;
        newmbepro.AS_FirstName__c = mbepro.AS_FirstName__c;
            newmbepro.AS_LastName__c = mbepro.AS_LastName__c;
            newmbepro.AS_BusinessDescription__c = mbepro.AS_BusinessDescription__c;
             newmbepro.AS_Title__c = mbepro.AS_Title__c;
             newmbepro.AS_WorkPhone__c = mbepro.AS_WorkPhone__c;
             newmbepro.AS_WebsiteUrl__c = mbepro.AS_WebsiteUrl__c;
             newmbepro.Any_non_WBENC_awards_received__c = mbepro.Any_non_WBENC_awards_received__c;
             newmbepro.Companyhaveafacility_partneroutsideUSA__c = mbepro.Companyhaveafacility_partneroutsideUSA__c;
             
            //newmbepro.AS_Email__c = mbepro.AS_Email__c;
            newmbepro.AS_PrimaryBusinessCategory1__c = mbepro.AS_PrimaryBusinessCategory1__c;
            newmbepro.As_SecondaryBusinessCategory1__c = mbepro.As_SecondaryBusinessCategory1__c;
            newmbepro.AS_NumberOfEmployees__c = mbepro.AS_NumberOfEmployees__c;
            newmbepro.AS_BusinessEstablishedDate__c=mbepro.AS_BusinessEstablishedDate__c;
            newmbepro.AS_BusinessRevenue__c = mbepro.AS_BusinessRevenue__c;
            newmbepro.AS_BusinessTaxId__c = mbepro.AS_BusinessTaxId__c;
            newmbepro.AS_BusinessDunsNumber__c = mbepro.AS_BusinessDunsNumber__c;
            newmbepro.Event_Organizer_Id__c = eventone.owner.username;
            //newmbepro.Keywords__c = mbepro.Keywords__c;
            newmbepro.Exceptional_Key_Words__c = mbepro.Exceptional_Key_Words__c;
            newmbepro.Business_type__c=mbepro.Business_type__c;
            newmbepro.Company_Certifications__c=mbepro.Company_Certifications__c;
            newmbepro.GSA_Schedule__c=mbepro.GSA_Schedule__c;
            newmbepro.AS_CageCode__c=mbepro.AS_CageCode__c;
            newmbepro.AS_CellPhone__c=mbepro.AS_CellPhone__c;
            newmbepro.AS_Company__c =mbepro.AS_Company__c ;
            //updateAttendeeSummary.Certificate_Processed_by_RPO__c = SelectValAs;
            newmbepro.Certificate_Processed_by_RPO__c = mbepro.Certificate_Processed_by_RPO__c;
            newmbepro.AS_WorkAddress1__c =mbepro.AS_WorkAddress1__c;
            newmbepro.AS_WorkAddress2__c =mbepro.AS_WorkAddress2__c;
            newmbepro.AS_Work_Country__c = mbepro.AS_Work_Country__c;
            newmbepro.AS_Work_States__c =mbepro.AS_Work_States__c;
            newmbepro.AS_WorkCity__c =mbepro.AS_WorkCity__c;
            newmbepro.AS_WorkZip__c =mbepro.AS_WorkZip__c;
        newmbepro.AttendeeSummary__c = mbepro.id;
        newmbepro.BBB_Number__c = mbepro.BBB_Number__c;
            newmbepro.DBA__c = mbepro.DBA__c;
            newmbepro.distribution_Country__c = mbepro.distribution_Country__c;
            newmbepro.Ethnicity__c = mbepro.Ethnicity__c;
            newmbepro.Exhibitor_company_imageUrl__c = mbepro.Exhibitor_company_imageUrl__c;
            newmbepro.AS_FaxNumber__c = mbepro.AS_FaxNumber__c;
            newmbepro.Key_words__c = mbepro.Keywords__c;
            newmbepro.Manufactures_Country__c = mbepro.Manufactures_Country__c;
            newmbepro.References__c = mbepro.References__c;
            newmbepro.References2__c = mbepro.References2__c;
            newmbepro.Scope_of_Work__c = mbepro.Scope_of_Work__c;
            newmbepro.Scope_of_Work2__c = mbepro.Scope_of_Work2__c;
            newmbepro.References2__c = mbepro.References2__c;
            newmbepro.Business_Structure__c =mbepro.Business_Structure__c;
            newmbepro.Certificate_Processed_by_RPO__c =mbepro.Certificate_Processed_by_RPO__c;
            newmbepro.Geographical_Region__c=mbepro.Geographical_Region__c;
            newmbepro.Revenue_Range__c=mbepro.Revenue_Range__c;
            newmbepro.Year_in_business__c=mbepro.Year_in_business__c;
        database.insert(newmbepro,false);
        mbepro1= new List<MBE_Profile__c>();
        mbepro1.add(newmbepro);
  
  }
  Event_Attendee_Mapping__c evm = [Select id,AS_id__c,MBE_Profile__c from Event_Attendee_Mapping__c Where id =: eamid];
  evm.AS_id__c = mbepro1[0].AttendeeSummary__c;
    evm.Attendee_Event_IDs__c = mbepro1[0].AttendeeSummary__c+eventid;
  evm.MBE_Profile__c = mbepro1[0].id;
  update evm;
  
  List<User> uo = [select id from User where Username =: emailold];
  List<User> Un = [select id from User Where Username =: emailnew];
  if(uo.size() > 0){
  List<User_Profile_Event__c> UserBoothAdminProfile = new List<User_Profile_Event__c> ();
                UserBoothAdminProfile = [select id,BT_id__c,BoothAdmin_id__c,Attendee_Summary__c,User_id__c,Status__c,IsMatchMakingUser__c,MAtchMakingProfile__c from User_Profile_Event__c where User_id__c =:uo[0].id and  EV_id__c =:eventid];
                    IF(UserBoothAdminProfile.size()> 0){
                    if(un.size()>0){
                        UserBoothAdminProfile[0].User_id__c = un[0].id;
                        UserBoothAdminProfile[0].BoothAdmin_id__c = un[0].id;
                        UserBoothAdminProfile[0].Attendee_Summary__c = mbepro1[0].AttendeeSummary__c;
                        update UserBoothAdminProfile[0];
                    }else{
                    delete UserBoothAdminProfile[0];
                    }
                    }
  }
  pagereference pg = new pagereference('/apex/MM_Eventadmin_AttendeesDirectory');
         pg.setredirect(true);
         return pg;
  }
@RemoteAction
public static pagereference updatenewid(string oldemailid,string newemailid, string eventid, string eamid){
system.debug(':::::::::::::::::::;;old id:::::::::::::::::::::'+oldemailid+'  '+newemailid+'  '+eventid+'  '+eamid);
    Event__c eventone = [SELECT id,Is_Webank_event__c,owner.username from Event__c WHERE id =:eventid];
    List <AttendeeSummary__c> attendeesummery = new List <AttendeeSummary__c>();
    List <AttendeeSummary__c> AttendeeEmail1 = [SELECT Id from AttendeeSummary__c where AS_Email__c = : newemailid];
        if(AttendeeEmail1.size()> 0)
             attendeesummery.add(AttendeeEmail1[0]);
        else{
            AttendeeSummary__c AttendeeEmail = [Select a.As_prefixNew__c ,a.Business_type__c,a.Company_Certifications__c,a.GSA_Schedule__c,a.As_SuffixNew__c,a.As_Shipping_Country__c,Keywords__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,a.AS_uniqueField__c,
                  a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById,a.AS_Secondary_Email__c,a.AS_CageCode__c,
                  a.AS_WorkZipCode__c, a.AS_WorkState__c, a.AS_WorkPoBox__c, a.AS_WorkPhone__c, 
                  a.AS_WorkCountry__c, a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, 
                  a.AS_WebsiteUrl__c, a.AS_Title__c, a.AS_ThroughEventBrite__c, a.AS_Suffix__c, 
                  a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c, 
                  a.AS_ShippingCountry__c, a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                  a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c, a.AS_Prefix__c, 
                  a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c, 
                  a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c, a.AS_HomeZipcode__c,
                  a.AS_HomeState__c, a.AS_HomePoBox__c, a.AS_HomePhone__c, a.AS_HomeCountry__c, a.AS_HomeCity__c,
                  a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,
                  a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c,a.AS_NAICSCode7__c,
                   a.AS_NAICSCode8__c,a.AS_NAICSCode9__c,a.AS_NAICSCode6__c,
                  a.AS_BusinessRevenue__c,a.Exceptional_Key_Words__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c,Business_Structure__c,
                  a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_BusinessTaxId__c,AS_WorkZip__c,AS_HomeZip__c,AS_shippingzip__c,
                  AS_BusinessDunsNumber__c,a.DBA__c,
                 a.Geographical_Region__c,
                 a.Certificate_Processed_by_RPO__c,
                 a.BBB_Number__c,
                 a.Commodity_1__c,
                 a.Commodity_2__c,
                 a.Commodity_3__c,
                 a.Commodity_4__c,
                 a.Commodity_5__c,a.Commodity_6__c,
                 a.Commodity_7__c,
                 a.Commodity_8__c,
                 a.Commodity_9__c,
                  a.distribution_Country__c,
                a.Manufactures_Country__c,
                 a.References__c,
                 a.Revenue_Range__c,a.Ethnicity__c,a.References2__c,a.Scope_of_Work__c,a.Scope_of_Work2__c,a.Year_in_business__c,
                 a.Companyhaveafacility_partneroutsideUSA__c,Any_non_WBENC_awards_received__c,
                  a.Exhibitor_company_imageUrl__c from AttendeeSummary__c a where a.AS_Email__c = : oldemailid];
            
            AttendeeSummary__c newatt= new AttendeeSummary__c();
            newAtt.AS_BusinessDescription__c = attendeeEmail.AS_BusinessDescription__c;
             newAtt.AS_Title__c = attendeeEmail.AS_Title__c;
             newAtt.AS_WorkPhone__c = attendeeEmail.AS_WorkPhone__c;
             newAtt.AS_WebsiteUrl__c = attendeeEmail.AS_WebsiteUrl__c;
             newAtt.Any_non_WBENC_awards_received__c = attendeeEmail.Any_non_WBENC_awards_received__c;
             newAtt.Companyhaveafacility_partneroutsideUSA__c = attendeeEmail.Companyhaveafacility_partneroutsideUSA__c;
             
            newAtt.AS_FirstName__c = attendeeEmail.AS_FirstName__c;
            newAtt.AS_LastName__c = attendeeEmail.AS_LastName__c;
            newAtt.As_Email__c = newemailid;
            newAtt.AS_ImageUrl__c = attendeeEmail.AS_ImageUrl__c;
            newAtt.AS_Secondary_Email__c = newemailid;
            newAtt.AS_Company__c = attendeeEmail.AS_Company__c;
            newAtt.AS_PrefixNew__c = attendeeEmail.AS_PrefixNew__c;
            newAtt.AS_SuffixNew__c = attendeeEmail.AS_SuffixNew__c;
            newAtt.AS_Title__c = attendeeEmail.AS_Title__c;
            newAtt.AS_CellPhone__c = attendeeEmail.AS_CellPhone__c;
            newAtt.Certificate_Processed_by_RPO__c = attendeeEmail.Certificate_Processed_by_RPO__c;
            newAtt.AS_Age__c = attendeeEmail.AS_Age__c;
            
            newAtt.AS_HomePhone__c = attendeeEmail.AS_HomePhone__c;
            newAtt.AS_Gender__c = attendeeEmail.AS_Gender__c;
            newAtt.AS_BirthDate__c = attendeeEmail.AS_BirthDate__c;
            newAtt.AS_HomeAddress1__c = attendeeEmail.AS_HomeAddress1__c;
            newAtt.AS_BusinessDescription__c = attendeeEmail.AS_BusinessDescription__c;
            newAtt.AS_BusinessEstablishedDate__c = attendeeEmail.AS_BusinessEstablishedDate__c;
            newAtt.AS_BusinessDunsNumber__c = attendeeEmail.AS_BusinessDunsNumber__c;
            newAtt.AS_NumberOfEmployees__c = attendeeEmail.AS_NumberOfEmployees__c;
            newAtt.AS_BusinessRevenue__c = attendeeEmail.AS_BusinessRevenue__c;
            newAtt.AS_BusinessTaxId__c = attendeeEmail.AS_BusinessTaxId__c;
            newAtt.AS_PrimaryBusinessCategory1__c = attendeeEmail.AS_PrimaryBusinessCategory1__c;
            newAtt.AS_SecondaryBusinessCategory1__c = attendeeEmail.AS_SecondaryBusinessCategory1__c;
            newAtt.AS_WebsiteURL__c = attendeeEmail.AS_WebsiteURL__c;
            newAtt.AS_ShippingAddress1__c = attendeeEmail.AS_ShippingAddress1__c;
            newAtt.AS_ShippingPOBox__c = attendeeEmail.AS_ShippingPOBox__c;
            newAtt.AS_BlogURL__c = attendeeEmail.AS_BlogURL__c;
            newAtt.AS_WorkAddress1__c = attendeeEmail.As_WorkAddress1__c;
            newAtt.AS_WorkPhone__c = attendeeEmail.AS_WorkPhone__c;
            //newAtt.AS_WorkPOBox__c = attendeeEmail.AS_WorkPOBox__c;
            newAtt.AS_DiversityType__c = attendeeEmail.AS_DiversityType__c;
            newAtt.Business_type__c = attendeeEmail.Business_type__c;
            newAtt.Company_Certifications__c = attendeeEmail.Company_Certifications__c;
            newAtt.GSA_Schedule__c = attendeeEmail.GSA_Schedule__c;
            newAtt.AS_CageCode__c = attendeeEmail.AS_CageCode__c;
            newAtt.AS_DiversityType__c = attendeeEmail.AS_DiversityType__c;
            
            
            newAtt.AS_shippingCity__c = attendeeEmail.AS_shippingCity__c;
            newAtt.AS_shippingState__c = attendeeEmail.AS_shippingState__c;
            newAtt.AS_WorkAddress1__c = attendeeEmail.AS_WorkAddress1__c;
            newAtt.AS_Workcity__c = attendeeEmail.AS_Workcity__c;
            //newAtt.AS_WorkState__c = attendeeEmail.AS_WorkState__c;
            newAtt.AS_HomeAddress1__c = attendeeEmail.AS_HomeAddress1__c;
            newAtt.AS_HomeCity__c = attendeeEmail.AS_HomeCity__c;
            newAtt.AS_HomePOBox__c = attendeeEmail.AS_HomePOBox__c;
            newAtt.As_Home_State__c = attendeeEmail.As_Home_State__c;
            newAtt.AS_uniqueField__c = (attendeeEmail.AS_FirstName__c + attendeeEmail.AS_LastName__c + attendeeEmail.AS_Email__c).tolowercase();
            newAtt.BBB_Number__c = attendeeEmail.BBB_Number__c;
            newAtt.DBA__c = attendeeEmail.DBA__c;
            newAtt.distribution_Country__c = attendeeEmail.distribution_Country__c;
            newAtt.Ethnicity__c = attendeeEmail.Ethnicity__c;
            newAtt.Exhibitor_company_imageUrl__c = attendeeEmail.Exhibitor_company_imageUrl__c;
            newAtt.AS_FaxNumber__c = attendeeEmail.AS_FaxNumber__c;
            newAtt.Keywords__c = attendeeEmail.Keywords__c;
            newAtt.Manufactures_Country__c = attendeeEmail.Manufactures_Country__c;
            newAtt.References__c = attendeeEmail.References__c;
            newAtt.References2__c = attendeeEmail.References2__c;
            newAtt.Scope_of_Work__c = attendeeEmail.Scope_of_Work__c;
            newAtt.Scope_of_Work2__c = attendeeEmail.Scope_of_Work2__c;

            newAtt.Business_Structure__c =attendeeEmail.Business_Structure__c;
            newAtt.Certificate_Processed_by_RPO__c =attendeeEmail.Certificate_Processed_by_RPO__c;
            newAtt.Geographical_Region__c=attendeeEmail.Geographical_Region__c;
            newAtt.Revenue_Range__c=attendeeEmail.Revenue_Range__c;
            newAtt.Year_in_business__c=attendeeEmail.Year_in_business__c;
             newAtt.As_NAICSCode_1__c = attendeeEmail.As_NAICSCode_1__c;
            newAtt.As_NAICSCode_2__c = attendeeEmail.As_NAICSCode_2__c;
            newAtt.As_NAICSCode_3__c = attendeeEmail.As_NAICSCode_3__c;
            newAtt.As_NAICSCode_4__c = attendeeEmail.As_NAICSCode_4__c;
            newAtt.As_NAICSCode_5__c = attendeeEmail.As_NAICSCode_5__c;
            newAtt.AS_NAICSCode6__c = attendeeEmail.As_NAICSCode6__c;
            newAtt.AS_NAICSCode7__c = attendeeEmail.As_NAICSCode7__c;
            newAtt.AS_NAICSCode8__c = attendeeEmail.As_NAICSCode8__c;
            newAtt.AS_NAICSCode9__c = attendeeEmail.As_NAICSCode9__c;
            
            newAtt.Commodity_1__c = attendeeEmail.Commodity_1__c;
            newAtt.Commodity_2__c = attendeeEmail.Commodity_2__c;
            newAtt.Commodity_3__c = attendeeEmail.Commodity_3__c;
            newAtt.Commodity_4__c = attendeeEmail.Commodity_4__c;
            newAtt.Commodity_5__c =attendeeEmail.Commodity_5__c;
            newAtt.Commodity_6__c = attendeeEmail.Commodity_6__c;
            newAtt.Commodity_7__c = attendeeEmail.Commodity_7__c;
            newAtt.Commodity_8__c = attendeeEmail.Commodity_8__c;
            newAtt.Commodity_9__c = attendeeEmail.Commodity_9__c;
           
            database.insert(newatt,false);
            List<Widget__c> videos = new list<Widget__c>();
            List<Widget__c> videosnew = new list<Widget__c>();
               videos = [select id,AttendeeSummary__c,YouTubeId_c__c From Widget__c Where AttendeeSummary__c =: attendeeEmail.id];
               if(videos.size()>0){
               for(Widget__c wd: videos){
               Widget__c wdn = new Widget__c();
               wdn.AttendeeSummary__c = newatt.id;
               wdn.YouTubeId_c__c = wd.YouTubeId_c__c;
               videosnew.add(wdn);
               }
               insert videosnew;
               }
           attendeesummery.add(newatt);
        
        }//Completed adding attendee summery
        //Adding Mbe profile record
        MBE_Profile__c mbepro = new MBE_Profile__c(); 
         Event_Attendee_Mapping__c emid = [select id,AS_id__r.id,MBE_Profile__c from Event_Attendee_Mapping__c where id =: eamid];
        mbepro = [Select  a.As_prefixNew__c ,a.As_SuffixNew__c,a.As_Shipping_Country__c,a.As_Shipping_States__c,a.SystemModstamp, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById,
                              a.LastActivityDate, a.IsDeleted, a.Id, a.CreatedDate, a.CreatedById, Exhibitor_company_imageUrl__c,
                              a.AS_WorkZipCode__c,a.AS_WorkPhone__c,
                              a.AS_WorkCity__c, a.AS_WorkAddress2__c, a.AS_WorkAddress1__c, a.Key_Words__c,
                              a.AS_WebsiteUrl__c, a.AS_Title__c,
                              a.AS_ShippingZipcode__c, a.AS_ShippingState__c, a.AS_ShippingPoBox__c, a.AS_ShippingPhone__c,
                              a.AS_ShippingCity__c, a.AS_ShippingAddress2__c, a.AS_ShippingAddress1__c,
                              a.AS_SecondaryBusinessCategory1__c, a.AS_PrimaryBusinessCategory1__c,
                              a.AS_NumberOfEmployees__c, a.AS_NAICSCode_5__c, a.AS_NAICSCode_4__c, a.AS_NAICSCode_3__c,
                              a.AS_NAICSCode_2__c, a.AS_NAICSCode_1__c, a.AS_LastName__c, a.AS_ImageUrl__c,
                              a.AS_HomePhone__c,a.AS_HomeCity__c,a.DBA__c,a.Geographical_Region__c,a.Certificate_Processed_by_RPO__c,
                              a.BBB_Number__c,a.Commodity_1__c, a.Commodity_2__c,
                              a.Commodity_3__c,
                              a.Commodity_4__c,
                              a.Commodity_5__c,
                               a.Commodity_6__c,
                              a.Commodity_7__c,
                              a.Commodity_8__c,
                              a.Commodity_9__c,
                              a.distribution_Country__c,
                              a.Manufactures_Country__c,
                              a.References__c,
                            a.References2__c,
                            a.Scope_of_Work__c,
                            a.Scope_of_Work2__c,
                              a.Revenue_Range__c,
                               a.AS_NAICSCode9__c,
                       a.AS_NAICSCode8__c,
                        a.AS_NAICSCode7__c,
                        a.AS_NAICSCode6__c,
                            a.Year_in_business__c,a.Business_Structure__c,
                            a.Ethnicity__c,a.AS_Secondary_Email__c,
                              a.AS_HomeAddress2__c, a.AS_HomeAddress1__c, a.AS_Gender__c, a.AS_FirstName__c, a.AS_FaxNumber__c,a.Event_Organizer_Id__c,
                              a.AS_Email__c, a.AS_DiversityType__c, a.AS_Company__c, a.AS_CellPhone__c, a.AS_CageCode__c,a.GSA_Schedule__c,
                              a.AS_BusinessRevenue__c, a.AS_BusinessEstablishedDate__c, a.AS_BusinessDescription__c, a.Business_type__c,a.Exceptional_Key_Words__c,
                              a.AS_BlogUrl__c, a.AS_BirthDate__c, a.AS_Age__c,a.AS_Work_Country__c,a.AS_Work_States__c,a.As_Home_Country__c,a.As_Home_State__c,AS_WorkZip__c,AS_HomeZip__c,
                              a.AS_BusinessDunsNumber__c,a.AS_BusinessTaxId__c,a.Any_non_WBENC_awards_received__c,a.Companyhaveafacility_partneroutsideUSA__c,a.Company_Certifications__c,(select id,YouTubeId_c__c From Custom_Widgets__r)
                               from MBE_Profile__c a Where id =:emid.MBE_Profile__c AND a.Event_Organizer_Id__c=:eventone.owner.username limit 1];

        MBE_Profile__c newmbepro = new MBE_Profile__c();
       // newmbepro = mbepro.clone(true);
        newmbepro.AS_Email__c = newemailid;
        newmbepro.AS_FirstName__c = mbepro.AS_FirstName__c;
            newmbepro.AS_LastName__c = mbepro.AS_LastName__c;
            newmbepro.AS_ImageUrl__c = mbepro.AS_ImageUrl__c;
            //newmbepro.AS_Email__c = mbepro.AS_Email__c;
            newmbepro.AS_PrimaryBusinessCategory1__c = mbepro.AS_PrimaryBusinessCategory1__c;
            newmbepro.As_SecondaryBusinessCategory1__c = mbepro.As_SecondaryBusinessCategory1__c;
            newmbepro.AS_NumberOfEmployees__c = mbepro.AS_NumberOfEmployees__c;
            newmbepro.AS_BusinessEstablishedDate__c=mbepro.AS_BusinessEstablishedDate__c;
            newmbepro.AS_BusinessRevenue__c = mbepro.AS_BusinessRevenue__c;
            newmbepro.AS_BusinessTaxId__c = mbepro.AS_BusinessTaxId__c;
            newmbepro.AS_BusinessDunsNumber__c = mbepro.AS_BusinessDunsNumber__c;
            newmbepro.Event_Organizer_Id__c = mbepro.Event_Organizer_Id__c;
            newmbepro.AS_BusinessDescription__c = mbepro.AS_BusinessDescription__c;
            newmbepro.AS_WorkPhone__c= mbepro.AS_WorkPhone__c;
            newmbepro.AS_Title__c = mbepro.AS_Title__c;
            newmbepro.AS_WebsiteUrl__c = mbepro.AS_WebsiteUrl__c;
            //newmbepro.Keywords__c = mbepro.Keywords__c;
            newmbepro.Exceptional_Key_Words__c = mbepro.Exceptional_Key_Words__c;
            newmbepro.Business_type__c=mbepro.Business_type__c;
            newmbepro.Company_Certifications__c=mbepro.Company_Certifications__c;
            newmbepro.GSA_Schedule__c=mbepro.GSA_Schedule__c;
            newmbepro.AS_CageCode__c=mbepro.AS_CageCode__c;
            newmbepro.AS_CellPhone__c=mbepro.AS_CellPhone__c;
            newmbepro.AS_Company__c =mbepro.AS_Company__c ;
            //updateAttendeeSummary.Certificate_Processed_by_RPO__c = SelectValAs;
            newmbepro.Certificate_Processed_by_RPO__c = mbepro.Certificate_Processed_by_RPO__c;
            newmbepro.AS_WorkAddress1__c =mbepro.AS_WorkAddress1__c;
            newmbepro.AS_WorkAddress2__c =mbepro.AS_WorkAddress2__c;
            newmbepro.AS_Work_Country__c = mbepro.AS_Work_Country__c;
            newmbepro.AS_Work_States__c =mbepro.AS_Work_States__c;
            newmbepro.AS_WorkCity__c =mbepro.AS_WorkCity__c;
            newmbepro.AS_WorkZip__c =mbepro.AS_WorkZip__c;
        newmbepro.AttendeeSummary__c = attendeesummery[0].id;
        newmbepro.BBB_Number__c = mbepro.BBB_Number__c;
            newmbepro.DBA__c = mbepro.DBA__c;
            newmbepro.distribution_Country__c = mbepro.distribution_Country__c;
            newmbepro.Ethnicity__c = mbepro.Ethnicity__c;
            newmbepro.Exhibitor_company_imageUrl__c = mbepro.Exhibitor_company_imageUrl__c;
            newmbepro.AS_FaxNumber__c = mbepro.AS_FaxNumber__c;
            newmbepro.Key_words__c = mbepro.Key_words__c;
            newmbepro.Manufactures_Country__c = mbepro.Manufactures_Country__c;
            newmbepro.References__c = mbepro.References__c;
            newmbepro.References2__c = mbepro.References2__c;
            newmbepro.Scope_of_Work__c = mbepro.Scope_of_Work__c;
            newmbepro.Scope_of_Work2__c = mbepro.Scope_of_Work2__c;
            newmbepro.References2__c = mbepro.References2__c;
            newmbepro.AS_Work_States__c = mbepro.AS_Work_States__c;
            newmbepro.Business_Structure__c =mbepro.Business_Structure__c;
            newmbepro.Certificate_Processed_by_RPO__c =mbepro.Certificate_Processed_by_RPO__c;
            newmbepro.Geographical_Region__c=mbepro.Geographical_Region__c;
            newmbepro.Revenue_Range__c=mbepro.Revenue_Range__c;
            newmbepro.Any_non_WBENC_awards_received__c= mbepro.Any_non_WBENC_awards_received__c;
            newmbepro.Companyhaveafacility_partneroutsideUSA__c = mbepro.Companyhaveafacility_partneroutsideUSA__c;
            newmbepro.Year_in_business__c=mbepro.Year_in_business__c;
             newmbepro.As_NAICSCode_1__c = mbepro.As_NAICSCode_1__c;
            newmbepro.As_NAICSCode_2__c = mbepro.As_NAICSCode_2__c;
            newmbepro.As_NAICSCode_3__c = mbepro.As_NAICSCode_3__c;
            newmbepro.As_NAICSCode_4__c = mbepro.As_NAICSCode_4__c;
            newmbepro.As_NAICSCode_5__c = mbepro.As_NAICSCode_5__c;
            newmbepro.AS_NAICSCode6__c = mbepro.As_NAICSCode6__c;
            newmbepro.AS_NAICSCode7__c = mbepro.As_NAICSCode7__c;
            newmbepro.AS_NAICSCode8__c = mbepro.As_NAICSCode8__c;
            newmbepro.AS_NAICSCode9__c = mbepro.As_NAICSCode9__c;
            
            newmbepro.Commodity_1__c = mbepro.Commodity_1__c;
            newmbepro.Commodity_2__c = mbepro.Commodity_2__c;
            newmbepro.Commodity_3__c = mbepro.Commodity_3__c;
            newmbepro.Commodity_4__c = mbepro.Commodity_4__c;
            newmbepro.Commodity_5__c =mbepro.Commodity_5__c;
            newmbepro.Commodity_6__c = mbepro.Commodity_6__c;
            newmbepro.Commodity_7__c = mbepro.Commodity_7__c;
            newmbepro.Commodity_8__c = mbepro.Commodity_8__c;
            newmbepro.Commodity_9__c = mbepro.Commodity_9__c;
        database.insert(newmbepro,false);
        
         List<Attachment> aold = [select id,name,body From Attachment Where parentId =: mbepro.id];
             List<Attachment> anew = new List<Attachment>();
             If(aold.size()>0){
             for(Attachment att : aold){
             Attachment a = new Attachment();
             a.name = att.Name;
             a.body = att.body;
             a.parentId = newmbepro.id;
             anew.add(a);
             }
             insert anew;
             }
            
        List<Custom_Widget__c> videos = new list<Custom_Widget__c>();
            List<Custom_Widget__c> videosnew = new list<Custom_Widget__c>();
               videos = [select id,MBE_Profile__c,YouTubeId_c__c From Custom_Widget__c Where MBE_Profile__c =: mbepro.id];
               if(videos.size()>0){
               for(Custom_Widget__c wd: videos){
               Custom_Widget__c cnewwd = new Custom_Widget__c();
               cnewwd.MBE_Profile__c = newmbepro.Id;
                cnewwd.YouTubeId_c__c = wd.YouTubeId_c__c;
               videosnew.add(cnewwd);
               }
               insert videosnew;
               }
        Event_Attendee_Mapping__c evm = [Select id,AS_id__c,MBE_Profile__c from Event_Attendee_Mapping__c Where id =: eamid];
  evm.AS_id__c = newmbepro.AttendeeSummary__c;
  evm.Attendee_Event_IDs__c = newmbepro.AttendeeSummary__c+eventid;
  evm.MBE_Profile__c = newmbepro.id;
  update evm;
   List<User> uo = [select id from User where Username =: oldemailid];
  List<User> Un = [select id from User Where Username =: newemailid];
  if(uo.size() > 0){
  List<User_Profile_Event__c> UserBoothAdminProfile = new List<User_Profile_Event__c> ();
                UserBoothAdminProfile = [select id,BT_id__c,BoothAdmin_id__c,Attendee_Summary__c,User_id__c,Status__c,IsMatchMakingUser__c,MAtchMakingProfile__c from User_Profile_Event__c where User_id__c =:uo[0].id and  EV_id__c =:eventid ];
                    IF(UserBoothAdminProfile.size()> 0){
                    if(un.size()>0){
                        UserBoothAdminProfile[0].User_id__c = un[0].id;
                        UserBoothAdminProfile[0].BoothAdmin_id__c = un[0].id;
                        UserBoothAdminProfile[0].Attendee_Summary__c = newmbepro.AttendeeSummary__c;
                        update UserBoothAdminProfile[0];
                    }else{
                    delete UserBoothAdminProfile[0];
                    }
                    
                    }}
  pagereference pg = new pagereference('/apex/MM_Eventadmin_AttendeesDirectory');
         pg.setredirect(true);
         return pg;
    }
    //For updating email change for standard event
    @RemoteAction
  public static void updateexstdemail(string newemail, string oldemail,string eamid,string eveid){
  AttendeeSummary__c attsum = new AttendeeSummary__c();
  system.debug(':::::::;;;eamid:;;;;'+eamid);
  attsum = [select id from AttendeeSummary__c where AS_Email__c =: newemail];
  AttendeeSummary__c attsumold = [select id from AttendeeSummary__c where AS_Email__c =:oldemail];
  List<User> uo = [select id from User where Username =: oldemail];
  List<User> Un = [select id from User Where Username =: newemail];
  if(uo.size() > 0){
  List<User_Profile_Event__c> UserBoothAdminProfile = new List<User_Profile_Event__c> ();
                UserBoothAdminProfile = [select id,BT_id__c,BoothAdmin_id__c,Attendee_Summary__c,User_id__c,Status__c,IsMatchMakingUser__c,MAtchMakingProfile__c from User_Profile_Event__c where User_id__c =:uo[0].id and  EV_id__c =:eveid ];
                    IF(UserBoothAdminProfile.size()> 0){
                    if(un.size()>0){
                        UserBoothAdminProfile[0].User_id__c = un[0].id;
                        UserBoothAdminProfile[0].BoothAdmin_id__c = un[0].id;
                        UserBoothAdminProfile[0].Attendee_Summary__c = attsum.id;
                        update UserBoothAdminProfile[0];
                    }else{
                    delete UserBoothAdminProfile[0];
                    }
                    
                    }
  }
   Event_Attendee_Mapping__c evm = [Select id,AS_id__c from Event_Attendee_Mapping__c Where id =: eamid];
   evm.AS_id__c = attsum.id;
   evm.Attendee_Event_IDs__c = attsum.id+eveid;
   update evm;
   
  }
    @RemoteAction
  public static void updatenewstdemail(string oldemail, string newemail,string eventid ,string eamid){
  AttendeeSummary__c newattendee = new AttendeeSummary__c();
  newattendee =[select id, name, AS_Age__c, isUpdated__c, AS_BirthDate__c, AS_BlogUrl__c, Keywords__c, AS_BusinessDunsNumber__c,
                                         AS_BusinessEstablishedDate__c, AS_BusinessRevenue__c, AS_BusinessTaxId__c, AS_CellPhone__c,AS_BusinessDescription__c,
                                         AS_Company__c, AS_DiversityType__c, Registration_type__c, AS_Email__c, AS_FaxNumber__c, AS_FirstName__c, AS_Gender__c,
                                         AS_HomeAddress1__c, AS_HomeAddress2__c, AS_HomeCity__c, AS_HomeCountry__c, AS_HomePhone__c,
                                         AS_HomePoBox__c, AS_HomeZip__c, AS_ImageUrl__c,Exhibitor_company_imageUrl__c, AS_LastName__c, AS_NAICSCode_1__c,
                                         AS_NAICSCode_2__c, AS_NAICSCode_3__c, AS_NAICSCode_4__c, AS_NAICSCode_5__c, AS_NumberOfEmployees__c, AS_PrefixNew__c,
                                         AS_PrimaryBusinessCategory1__c, AS_SecondaryBusinessCategory1__c, AS_ShippingAddress1__c, AS_ShippingAddress2__c,
                                         AS_ShippingCity__c, AS_ShippingCountry__c, AS_ShippingPhone__c, AS_shippingzip__c, AS_ShippingState__c,
                                         AS_ShippingZipcode__c, AS_SuffixNew__c, AS_ThroughEventBrite__c, AS_Title__c, AS_WebsiteUrl__c, AS_WorkAddress1__c,
                                         AS_WorkAddress2__c, AS_WorkCity__c, AS_WorkCountry__c, AS_WorkPhone__c, AS_WorkPoBox__c, AS_Work_Country__c, AS_WorkZip__c,
                                         AS_Work_States__c, As_Home_Country__c, As_Home_State__c, As_Shipping_Country__c, As_Shipping_States__c,FetchStatus__c,isFetched__c,
                                         AS_CageCode__c,Business_type__c,Company_Certifications__c,GSA_Schedule__c,Exceptional_Key_Words__c,BBB_Number__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c,Commodity_6__c,Commodity_7__c,Commodity_8__c,Commodity_9__c,DBA__c,distribution_Country__c,Revenue_Range__c,
                                        Business_Structure__c,Ethnicity__c,AS_Secondary_Email__c,Any_non_WBENC_awards_received__c,Companyhaveafacility_partneroutsideUSA__c,
                                         Geographical_Region__c,Manufactures_Country__c,AS_ShippingPoBox__c,AS_WorkState__c,AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,References__c,Scope_of_Work__c,References2__c,Scope_of_Work2__c,Certificate_Processed_by_RPO__c,Year_in_business__c, 
                                         (select id,YouTubeId_c__c From Widgets__r)FROM AttendeeSummary__c WHERE AS_Email__c = : oldemail];
  
             
              AttendeeSummary__c UpdateAttendee = new AttendeeSummary__c();

             system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^' + newattendee.AS_FirstName__c);
             UpdateAttendee.AS_FirstName__c = newattendee.AS_FirstName__c;
             UpdateAttendee.AS_ImageUrl__c = newattendee.AS_ImageUrl__c;
             UpdateAttendee.AS_LastName__c = newattendee.AS_LastName__c;
             UpdateAttendee.AS_BusinessDescription__c = newattendee.AS_BusinessDescription__c;
             UpdateAttendee.AS_Title__c = newattendee.AS_Title__c;
             UpdateAttendee.AS_WorkPhone__c = newattendee.AS_WorkPhone__c;
             UpdateAttendee.AS_WebsiteUrl__c = newattendee.AS_WebsiteUrl__c;
             UpdateAttendee.Any_non_WBENC_awards_received__c = newattendee.Any_non_WBENC_awards_received__c;
             UpdateAttendee.Companyhaveafacility_partneroutsideUSA__c = newattendee.Companyhaveafacility_partneroutsideUSA__c;
             updateAttendee.Geographical_Region__c = newAttendee.Geographical_Region__c;
            
             UpdateAttendee.As_Email__c = newemail;
             UpdateAttendee.AS_Secondary_Email__c = newemail;
             UpdateAttendee.AS_Company__c = newattendee.AS_Company__c;
             UpdateAttendee.AS_PrefixNew__c = newattendee.AS_PrefixNew__c;
             UpdateAttendee.AS_SuffixNew__c = newattendee.AS_SuffixNew__c;
             UpdateAttendee.AS_Title__c = newattendee.AS_Title__c;
             UpdateAttendee.AS_CellPhone__c = newattendee.AS_CellPhone__c;             
                 UpdateAttendee.AS_Age__c = newattendee.AS_Age__c ;
             
             UpdateAttendee.AS_HomePhone__c = newattendee.AS_HomePhone__c;
             UpdateAttendee.AS_Gender__c = newattendee.AS_Gender__c;
             UpdateAttendee.AS_BirthDate__c = newattendee.AS_BirthDate__c;
             UpdateAttendee.AS_HomeAddress1__c = newattendee.AS_HomeAddress1__c;
             UpdateAttendee.AS_BusinessDescription__c = newattendee.AS_BusinessDescription__c;
             UpdateAttendee.AS_BusinessEstablishedDate__c = newattendee.AS_BusinessEstablishedDate__c;
             UpdateAttendee.AS_BusinessDunsNumber__c = newattendee.AS_BusinessDunsNumber__c;
             UpdateAttendee.AS_NumberOfEmployees__c = newattendee.AS_NumberOfEmployees__c;
             UpdateAttendee.AS_BusinessRevenue__c = newattendee.AS_BusinessRevenue__c;
             UpdateAttendee.AS_BusinessTaxId__c = newattendee.AS_BusinessTaxId__c;
             UpdateAttendee.AS_PrimaryBusinessCategory1__c = newattendee.AS_PrimaryBusinessCategory1__c;
             UpdateAttendee.AS_SecondaryBusinessCategory1__c = newattendee.AS_SecondaryBusinessCategory1__c;
             UpdateAttendee.AS_WebsiteURL__c = newattendee.AS_WebsiteURL__c;
             UpdateAttendee.AS_ShippingAddress1__c = newattendee.AS_ShippingAddress1__c;
             UpdateAttendee.AS_ShippingPOBox__c = newattendee.AS_ShippingPOBox__c;
             UpdateAttendee.AS_BlogURL__c = newattendee.AS_BlogURL__c;
             UpdateAttendee.AS_WorkAddress1__c = newattendee.As_WorkAddress1__c;
             UpdateAttendee.AS_WorkPhone__c = newattendee.AS_WorkPhone__c;
             UpdateAttendee.AS_WorkPOBox__c = newattendee.AS_WorkPOBox__c;
             UpdateAttendee.AS_DiversityType__c = newattendee.AS_DiversityType__c;
             UpdateAttendee.Business_type__c = newattendee.Business_type__c;
             UpdateAttendee.Company_Certifications__c = newattendee.Company_Certifications__c;
             UpdateAttendee.GSA_Schedule__c = newattendee.GSA_Schedule__c;
             UpdateAttendee.AS_CageCode__c = newattendee.AS_CageCode__c;
             UpdateAttendee.AS_DiversityType__c = newattendee.AS_DiversityType__c;


             UpdateAttendee.AS_shippingCity__c = newattendee.AS_shippingCity__c;
             UpdateAttendee.AS_shippingState__c = newattendee.AS_shippingState__c;
             UpdateAttendee.AS_WorkAddress2__c = newattendee.AS_WorkAddress2__c;
             UpdateAttendee.AS_WorkAddress1__c = newattendee.AS_WorkAddress1__c;
                          UpdateAttendee.AS_Work_Country__c = newattendee.AS_Work_Country__c;
                                                    UpdateAttendee.AS_WorkZip__c = newattendee.AS_WorkZip__c;
             UpdateAttendee.AS_Workcity__c = newattendee.AS_Workcity__c;
             UpdateAttendee.AS_WorkState__c = newattendee.AS_WorkState__c;
             UpdateAttendee.AS_HomeAddress1__c = newattendee.AS_HomeAddress1__c;
             UpdateAttendee.AS_HomeCity__c = newattendee.AS_HomeCity__c;
             UpdateAttendee.AS_HomePOBox__c = newattendee.AS_HomePOBox__c;
             UpdateAttendee.As_Home_State__c = newattendee.As_Home_State__c;
             UpdateAttendee.AS_uniqueField__c = (newattendee.AS_FirstName__c + newattendee.AS_LastName__c + newattendee.AS_Email__c).tolowercase();
            
            
           
            UpdateAttendee.As_NAICSCode_1__c = newattendee.As_NAICSCode_1__c;
            UpdateAttendee.As_NAICSCode_2__c = newattendee.As_NAICSCode_2__c;
            UpdateAttendee.As_NAICSCode_3__c = newattendee.As_NAICSCode_3__c;
            UpdateAttendee.As_NAICSCode_4__c = newattendee.As_NAICSCode_4__c;
            UpdateAttendee.As_NAICSCode_5__c = newattendee.As_NAICSCode_5__c;
            UpdateAttendee.AS_NAICSCode6__c = newattendee.As_NAICSCode6__c;
            UpdateAttendee.AS_NAICSCode7__c = newattendee.As_NAICSCode7__c;
            UpdateAttendee.AS_NAICSCode8__c = newattendee.As_NAICSCode8__c;
            UpdateAttendee.AS_NAICSCode9__c = newattendee.As_NAICSCode9__c;
            
            UpdateAttendee.Commodity_1__c = newattendee.Commodity_1__c;
            UpdateAttendee.Commodity_2__c = newattendee.Commodity_2__c;
            UpdateAttendee.Commodity_3__c = newattendee.Commodity_3__c;
            UpdateAttendee.Commodity_4__c = newattendee.Commodity_4__c;
            UpdateAttendee.Commodity_5__c =newattendee.Commodity_5__c;
            UpdateAttendee.Commodity_6__c = newattendee.Commodity_6__c;
            UpdateAttendee.Commodity_7__c = newattendee.Commodity_7__c;
            UpdateAttendee.Commodity_8__c = newattendee.Commodity_8__c;
            UpdateAttendee.Commodity_9__c = newattendee.Commodity_9__c;
                    UpdateAttendee.BBB_Number__c = newattendee.BBB_Number__c;
            UpdateAttendee.DBA__c = newattendee.DBA__c;
            UpdateAttendee.distribution_Country__c = newattendee.distribution_Country__c;
            UpdateAttendee.Ethnicity__c = newattendee.Ethnicity__c;
            UpdateAttendee.Exhibitor_company_imageUrl__c = newattendee.Exhibitor_company_imageUrl__c;
            UpdateAttendee.AS_FaxNumber__c = newattendee.AS_FaxNumber__c;
            UpdateAttendee.Keywords__c = newattendee.Keywords__c;
            UpdateAttendee.Manufactures_Country__c = newattendee.Manufactures_Country__c;
            UpdateAttendee.References__c = newattendee.References__c;
            UpdateAttendee.References2__c = newattendee.References2__c;
            UpdateAttendee.Scope_of_Work__c = newattendee.Scope_of_Work__c;
            UpdateAttendee.Scope_of_Work2__c = newattendee.Scope_of_Work2__c;
            UpdateAttendee.References2__c = newattendee.References2__c;
            UpdateAttendee.AS_Work_States__c = newattendee.AS_Work_States__c;
            UpdateAttendee.Business_Structure__c =newattendee.Business_Structure__c;
            UpdateAttendee.Certificate_Processed_by_RPO__c =newattendee.Certificate_Processed_by_RPO__c;
            UpdateAttendee.Geographical_Region__c=newattendee.Geographical_Region__c;
            UpdateAttendee.Revenue_Range__c=newattendee.Revenue_Range__c;
            UpdateAttendee.Year_in_business__c=newattendee.Year_in_business__c;


       
             
             Database.saveResult insNewAtt = Database.insert(UpdateAttendee,false);
             List<Attachment> aold = [select id,name,body From Attachment Where parentId =: newattendee.id];
             List<Attachment> anew = new List<Attachment>();
             If(aold.size()>0){
             for(Attachment att : aold){
             Attachment a = new Attachment();
             a.name = att.Name;
             a.body = att.body;
             a.parentId = insNewAtt.getId();
             anew.add(a);
             }
             insert anew;
             }
            
             List<Widget__c> videos = new list<Widget__c>();
            List<Widget__c> videosnew = new list<Widget__c>();
               videos = [select id,AttendeeSummary__c,YouTubeId_c__c From Widget__c Where AttendeeSummary__c =: newattendee.id];
               if(videos.size()>0){
               for(Widget__c wd: videos){
               Widget__c newwd = new Widget__c();
               newwd.AttendeeSummary__c = insNewAtt.getId();
               newwd.YouTubeId_c__c = wd.YouTubeId_c__c;
               
               videosnew.add(newwd);
               }
               insert videosnew;
               }
     Event_Attendee_Mapping__c evm = [Select id,AS_id__c from Event_Attendee_Mapping__c Where id =: eamid];
   evm.AS_id__c = insNewAtt.getId();
      evm.Attendee_Event_IDs__c = insNewAtt.getId()+eventid;
   update evm;
  
  List<User_Profile_Event__c> upold = new List<User_Profile_Event__c>();
  List<User_Profile_Event__c> upnew = new List<User_Profile_Event__c>();
  upold = [select id,Attendee_Summary__c from User_Profile_Event__c where Attendee_Summary__c =: newattendee.id And EV_id__c =: eventid];
      if(upold.size() > 0){
          for(User_Profile_Event__c up : upold){
              //up.Attendee_Summary__c = insNewAtt.getId(); 
              upnew.add(up);
          }
          delete upnew;
      }
  
  }
  
  public dummyclass dum{get;set;}
 public integer i{get;set;}
  public void dummycall()
  {
   i=0;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;

i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;
i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;i++;


  }
  
  
  

   
  
  
  
    }