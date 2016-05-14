public without sharing class MM_BA_Matches {



  //Author : Naga Mallikarjuna Rao
  //Date  12/07/2013

  //Variables
  public Boolean matchBool {get; set;}
  public string comments {get; set;}
  public string schedulestartTime {get; set;}
  public string scheduleendTime {get; set;}
  public string scheduledate {get ; set ;}
  public list<MBE_Profile__c>  mbepro {get; set;}
  public boolean dispaySuccessPopup {get ; set ;}
  public boolean dispaySuccessPopup21 {get ; set ;}
  public string loginuserEmail {get; set;}
  public id loginUserId {get; set;}

  public string searchStringTemp;
  public string searchall {get; set;}
  public List<Event_Attendee_Mapping__c> searchlist {get; set;}
  //Keywords.............
  public String BAkeywords {get; set;}

  //revenue range
  public string revRangeValues {get; set;}

  //NAICS Codes.........
  public String NaicsCode1 {get; set;}
  public String NaicsCode2 {get; set;}
  public String NaicsCode3 {get; set;}
  public string mdeid {get; set;}

  //Commodities code.........
  public String Commodity1 {get; set;}
  public String Commodity2 {get; set;}
  public String Commodity3 {get; set;}
  public String Commodity4 {get; set;}
  public String Commodity5 {get; set;}
  public String Commodity6 {get; set;}
  public String Commodity7 {get; set;}
  public String Commodity8 {get; set;}
  public String Commodity9 {get; set;}

  //2 nd Business Types variables
  public String[] SelectedBusinessTypes {get; set;}
  public List<SelectOption> BusinessTypeItems {get; set;}

  //3rd GSA Schedule
  public String GSASchedule {get; set;}

  //4th Revenue
  public String[] SelectedRevenueAmount {get; set;}
  public List<SelectOption> revenueItems {get; set;}
  //revenue ranges
  public String[] SelectedRevenueRangeAmount {get; set;}
  public List<SelectOption> revenueRangeItems {get; set;}

  //5th Revenue
  public String[] SelectednoOfEmployees {get; set;}
  public List<SelectOption> noOfEmployeesItems {get; set;}

  //6th Revenue
  public String[] Selectedstatess {get; set;}
  public List<SelectOption> states {get; set;}

  //7th Revenue
  public String[] Selectedyearss {get; set;}
  public List<SelectOption> years {get; set;}

  //8th Revenue
  public String[] SelectedcompanyCertificationss {get; set;}
  public List<SelectOption> companyCertifications {get; set;}

  //9th Revenue
  public String[] Selectedprimarybusinesscategories {get; set;}
  public List<SelectOption> primarybusinesscategory {get; set;}

  //10th Revenue
  public String[] SelectedmatchedPeers {get; set;}
  public List<SelectOption> matchedPeers {get; set;}

  //11th Revenue
  public Integer zipCode {get; set;}
  public String phoneArea {get; set;}

  //12th Name Search
  public String attName {get; set;}
  public String companyName {get; set;}

  //2 nd Business Types variables
  public String[] SelectedyearsOfbusiness {get; set;}
  public List<SelectOption> yearsOfbusiness {get; set;}



  //Wbenc Revenue
  //  public String[] SelectedRevenueAmount2{get; set;}
  //  public List<SelectOption> revenueItems2{get; set;}

  // Commodities
  public string[] Selectedcommodities {get; set;}

  public transient LIST<innerEAM> innerValuesToPassAnotherInner {get; set;}
  public AttendeeSummary__c attendeeNaics {get; set;}
  public LIST<string> attNaicsDecimal {get; set;}
  public MAP<id, User_Profile_Event__c> upe_map {get; set;}
  public String eventType {get; set;}
  public list<Attachment> attchments {get; set;}
  public List<Widget__c> videos {get ; set ;}
  public string Mtype {get ; set ;}
  public list<Tags__c> tagslist {get; set ;}
  public string attendeealias {get ; set ;}
  public string exhibitoralias {get ; set ;}
  public Profile_Settings__c pfsett {get; set;}
  public list<Custom_Widget__c> cvideos {get ; set ;}
  public string selectedEventId {get; set;}
  public string globalSearchStr {get; set;}
  public boolean isCustomevent {get; set;}
  public List<id>  mbeids {get; set;}
  public List<selectOption> commodityOpt {get; set;}

  public LIST<InnerClass> toDisplayValues {get; set;}
  public Boolean eventTypeBool {get; set;}



  public Event__c scheduleEvent {get; set;}
  public LIST<EventSchedule__c> boothAdminSchedules {get; set;}
  public LIST<EventSchedule__c> attendeeSchedule {get; set;}
  public Boolean viewScheduleBool {get; set;}
  public ID scheduleProfileId {get; set;}
  public Event_Attendee_Mapping__c evs {get; set;}
  public LIST<MatchLeads_Days__c> allEventDates {get; set;}
  public LIST<String> eventTimeSlots {get; set;}
  public LIST<SelectOption> dateList {get; set;}
  public String selectedEventDate {get; set;}
  public MAP<Date , LIST<String>> getDataFromUtility {get; set;}
  public boolean ShowDatePicklist {get; set;}
  public string listvalsmbe {get ; set ;}



  public LIST<SelectOption> listofEvents {get; set;}
  public String selectedEvent {get; set;}
  public transient LIST<User_Profile_Event__c> mm_Upe {get; set;}
  //public transient MAP<ID, Event_Attendee_Mapping__c> EventAttendeeMappingMAP {get; set;}
  //public transient LIST<ID> eventAttendeesMAPIDs {get; set;}
  //public transient LIST<Event_Attendee_Mapping__c> displayAttendeeSummaries {get; set;}


  public transient  LIST<innerEAM>  InnerEAMValuesTodispaly {get; set;}
  //public transient LIST<innerEAMColums> finalInnerEAMValuesTodispaly {get; set;}
  public Boolean ismatchSearch {get; set;}
  public Integer columnsTodisplay {get; set;}
  Public Event__c eveObj {get; set;}



//Pagination variables
  public List<innerEAMColums> AccountRecsdup {get; set;}
  Public Integer TotalAccRecords {get; set;}

  public Integer NextCountAcc = 0;
  Public Boolean hasFirstAcc {get; set;}
  Public Boolean hasPrevAcc {get; set;}
  Public Boolean hasNextAcc {get; set;}
  Public Boolean hasLastAcc {get; set;}

  Public Integer StartRecAcc {get; set;}
  Public Integer EndRecAcc {get; set;}
  Public Integer Startcount {get; set;}
  Public Integer Endcount {get; set;}
  Public Integer Totalcount {get; set;}
  public Integer countRec {get; set;}

  public Event_Attendee_Mapping__c vewProfileEAM {get; set;}
  public Boolean vieProfileBool {get; set;}
  public Event__c eventone {get ; set ;}
  public List<id> attsumids {get; set;}
  public List<innerEAMColums> innListToDisplay {get; set;}
  public List<id> globalSearchAttids {get; set;}
  public  List<Event_Attendee_Mapping__c> queryParentObject;
  public String searchString;
  public string upenames {get ; set ;}
  public list<Event_Breaks__c> blokslistexist {get ; set ;}
  public list<id> upidsnew {get ; set ;}
  public string listvals {get ; set ;}
  public transient List<Event_Attendee_Mapping__c> eamsListForthisEve {get; set;}

//constructor
  public MM_BA_Matches() {
    attendeealias = '';
    exhibitoralias = '';
    errormsg =false;
    cookie counter =   ApexPages.currentPage().getCookies().get('counter');
    pfsett = new Profile_Settings__c();
    try {
      selectedEvent = counter.getValue();
    } Catch(Exception e) {}
    try {
      if (null != Apexpages.currentPage().getPArameters().get('eventId')) {
        selectedEvent = Apexpages.currentPage().getPArameters().get('eventId');
      }
    } catch (exception rt) {}
    SelectedyearsOfbusiness =  new String[] {};
    BusinessTypeItems = new List<SelectOption>();
    globalSearchAttids = new List<id>();
    revenueItems = new List<SelectOption>();
    revenueRangeItems = new List<SelectOption>();
    noOfEmployeesItems = new List<SelectOption>();
    videos = new List<Widget__c>();
    states = new List<SelectOption>();
    Years = new List<SelectOption>();
    companyCertifications = new List<SelectOption>();
    primarybusinesscategory = new List<SelectOption>();
    matchedPeers = new List<SelectOption>();
    attNaicsDecimal = new LIST<string>();
    attendeeNaics = new AttendeeSummary__c();
    upe_map = new MAP<id, User_Profile_Event__c>();
    SelectedmatchedPeers = new String[] {};
    Selectedprimarybusinesscategories = new String[] {};
    SelectedcompanyCertificationss = new String[] {};
    Selectedyearss = new String[] {};
    Selectedstatess = new String[] {};
    SelectednoOfEmployees = new String[] {};
    SelectedRevenueAmount = new String[] {};
    Selectedcommodities = new string[] {};
    SelectedRevenueRangeAmount = new String[] {};
    SelectedBusinessTypes = new String[] {};
    attchments = new List<Attachment>();
    matchBool = TRUE;
    vieProfileBool = FALSE;
    Selectedstatess = new LIST<String>();
    try {
      if (apexpages.currentpage().getparameters().get('id') == 'Directory' ) {
        matchBool = FALSE;
      }
    } catch (Exception e) {
    }
    string abd = '((MBE_Profile__r.AS_BusinessRevenue__c > 0 AND MBE_Profile__r.AS_BusinessRevenue__c <= 1000000) OR  MBE_Profile__r.Revenue_Range__c =\'Under 1 Million\')';
    revenueItems.add(new SelectOption(abd, 'Under 1 million'));
    string abd1 = '((MBE_Profile__r.AS_BusinessRevenue__c > 1000000 AND MBE_Profile__r.AS_BusinessRevenue__c <= 5000000) OR  MBE_Profile__r.Revenue_Range__c =\'1-5 Million\')';
    revenueItems.add(new SelectOption(abd1, '1-5 Million'));
    string abd10 = '((MBE_Profile__r.AS_BusinessRevenue__c > 5000001 AND MBE_Profile__r.AS_BusinessRevenue__c <= 10000000) OR  MBE_Profile__r.Revenue_Range__c =\'5-10 Million\')';
    revenueItems.add(new SelectOption(abd10, '5-10 Million'));
    string abd2 = '((MBE_Profile__r.AS_BusinessRevenue__c > 10000001 AND MBE_Profile__r.AS_BusinessRevenue__c <= 25000000) OR  MBE_Profile__r.Revenue_Range__c =\'10-25 Million\') ';
    revenueItems.add(new SelectOption(abd2, '10-25 Million'));
    string abd3 = '((MBE_Profile__r.AS_BusinessRevenue__c > 25000001  AND MBE_Profile__r.AS_BusinessRevenue__c <= 50000000) OR  MBE_Profile__r.Revenue_Range__c =\'25-50 Million\') ';
    revenueItems.add(new SelectOption(abd3, '25-50 Million'));
    string abd4 = '((MBE_Profile__r.AS_BusinessRevenue__c > 50000001   AND MBE_Profile__r.AS_BusinessRevenue__c <= 100000000) OR  MBE_Profile__r.Revenue_Range__c =\'50-100 Million\') ';
    revenueItems.add(new SelectOption(abd4, '50-100 Million'));
    string abd5 = '((MBE_Profile__r.AS_BusinessRevenue__c > 100000001    AND MBE_Profile__r.AS_BusinessRevenue__c <= 500000000) OR  MBE_Profile__r.Revenue_Range__c =\'Above 100 Million\') ';
    revenueItems.add(new SelectOption(abd5, 'Above 100 Millions'));
    string abd6 = '((MBE_Profile__r.AS_BusinessRevenue__c > 500000001 AND MBE_Profile__r.AS_BusinessRevenue__c <= 1000000000) OR  MBE_Profile__r.Revenue_Range__c =\'Above 500 Million\') ';
    revenueItems.add(new SelectOption(abd6, 'Above 500 Millions'));
    string abd7 = '((MBE_Profile__r.AS_BusinessRevenue__c > 1000000001) OR  MBE_Profile__r.Revenue_Range__c =\'Above 1 Billion\') ';
    revenueItems.add(new SelectOption(abd7, 'Above 1 Billion'));
    noOfEmployeesItems.add(new SelectOption('(MBE_Profile__r.AS_NumberOfEmployees__c > 0 AND MBE_Profile__r.AS_NumberOfEmployees__c <= 50)', '0-50'));
    noOfEmployeesItems.add(new SelectOption('(MBE_Profile__r.AS_NumberOfEmployees__c > 50 AND MBE_Profile__r.AS_NumberOfEmployees__c <= 100)', '51-100'));
    noOfEmployeesItems.add(new SelectOption('(MBE_Profile__r.AS_NumberOfEmployees__c > 100 AND MBE_Profile__r.AS_NumberOfEmployees__c <= 150)', '101-150'));
    noOfEmployeesItems.add(new SelectOption('(MBE_Profile__r.AS_NumberOfEmployees__c > 150 AND MBE_Profile__r.AS_NumberOfEmployees__c <= 200)', '151-200'));
    noOfEmployeesItems.add(new SelectOption('(MBE_Profile__r.AS_NumberOfEmployees__c > 200) ', '> 200'));
    yearsOfbusiness = new List<SelectOption>();
    Schema.DescribeFieldResult fieldResultbBu = AttendeeSummary__c.Year_in_business__c.getDescribe();
    List<Schema.PicklistEntry> plebusiness = fieldResultbBu.getPicklistValues();
    for ( Schema.PicklistEntry f : plebusiness ) {
      yearsOfbusiness.add(new SelectOption(f.getLabel(), f.getValue()));
    }
    years.add(new SelectOption('1950', '<1950'));
    years.add(new SelectOption('1951-1960', '1951-1960'));
    years.add(new SelectOption('1961-1970', '1961-1970'));
    years.add(new SelectOption('1971-1980', '1971-1980'));
    years.add(new SelectOption('1981-1990', '1981-1990'));
    years.add(new SelectOption('1991-2000', '1991-2000'));
    years.add(new SelectOption('2001-2010', '2001-2010'));
    years.add(new SelectOption('2011 Later', '2011 Later'));
    matchedPeers.add(new SelectOption('AA', 'AA'));
    matchedPeers.add(new SelectOption('AB', 'AB'));
    matchedPeers.add(new SelectOption('AC', 'AC'));
    matchedPeers.add(new SelectOption('AD', 'AD'));
    mm_Upe = new LIST<User_Profile_Event__c>();
    listofEvents = new LIST<SelectOption>();
    ID loginUserId = UserInfo.getUserId();
    //  loginUserId = '005Z000000192S5';
    mm_Upe = [SELECT ID, NAME, EV_id__c, EV_id__r.Partner_scheduling__c, MAtchMakingProfile__c , EV_id__r.EV_Title__c, EV_id__r.MM_End_Date__c, EV_id__r.MM_Start_Date__c, EV_id__r.MM_Slot_Timeperiod__c, EV_id__r.MatchMaking_Type__c,
              EV_id__r.BreakTime_Between_Appointments__c, EV_id__r.MM_Firstaday_startTime__c, EV_id__r.MM_Firstaday_EndTime__c, EV_id__r.MM_Secondaday_startTime__c,
              EV_id__r.MM_Secondaday_EndTime__c, EV_id__r.Match_Making_Schedules__c , EV_id__r.Is_MatchMaking_Event__c  FROM User_Profile_Event__c WHERE (BoothAdmin_id__c = : UserInfo.getUserId() AND IsMatchMakingUser__c = TRUE) AND EV_id__c = : selectedEvent ORDER BY createdDate];
    Mtype = '';
    for (User_Profile_Event__c upe : mm_Upe) {
      listofEvents.add(new SelectOption(String.valueOf(upe.EV_id__c) , upe.EV_id__r.EV_Title__c));
      // selectedEvent = upe.EV_id__c;
      upe_map.put(upe.EV_id__c, upe);
      eventType = upe.EV_id__r.MatchMaking_Type__c;
      Mtype = upe.EV_id__r.Match_Making_Schedules__c;
    }
    columnsTodisplay = 2;
    attNaicsDecimal = new LIST<string>();
    attendeeNaics = new AttendeeSummary__c();
    profileDao pfdao = new profileDao();
    if (selectedEvent != '' && selectedEvent != null ) {
      for (Profile_Settings__c ps : pfdao.getSettings(selectedEvent , 'MBE')) {
        pfsett = ps ;
        break;
      }
    }
    tagslist = [select id, Default_Name__c, Alias_Name__c from Tags__c where Event__c = : selectedEvent];
    for (Tags__c tt : tagslist ) {
      if (tt.Default_Name__c == 'Attendee') {
        attendeealias = tt.Alias_Name__c;
      } else if (tt.Default_Name__c == 'Exhibitor') {
        exhibitoralias = tt.Alias_Name__c;
      }
    }

    commodityOpt = new List<selectOption>();
    eveObj = new Event__c();
    eveObj = [select id, Name, numberOfrows__c, EventDiversityValues__c, MatchMaking_Type__c, Match_Making_Schedules__c, Is_Webank_event__c from Event__c where Id = :selectedEvent];
    selectedEventId = eveObj.id;
    isCustomevent = eveObj.Is_Webank_event__c;
    BusinessTypeItems = new List<SelectOption>();
    states = new List<SelectOption>();
    companyCertifications = new List<SelectOption>();
    primarybusinesscategory = new List<SelectOption>();
    String Div = eveObj.EventDiversityValues__c;
    string[] DiversityTypes1 = Div.split(';');
    for (String Diversty : DiversityTypes1) {
      BusinessTypeItems.add(new SelectOption(Diversty, Diversty));
    }
    //Commodities
    Schema.DescribeFieldResult fieldResults1 = AttendeeSummary__c.Commodity_1__c.getDescribe();
    List<Schema.PicklistEntry> ples1 = fieldResults1.getPicklistValues();

    for ( Schema.PicklistEntry f : ples1) {
      commodityOpt.add(new SelectOption(f.getLabel(), f.getValue()));
    }
    if (isCustomevent) {
      Schema.DescribeFieldResult fieldResults = MBE_Profile__c.AS_Work_States__c.getDescribe();
      List<Schema.PicklistEntry> ples = fieldResults.getPicklistValues();
      states.add(new SelectOption('Local', 'Local'));
      states.add(new SelectOption('National', 'National'));
      states.add(new SelectOption('Global', 'Global'));
      states.add(new SelectOption('Regional NE', 'Regional NE'));
      states.add(new SelectOption('Regional SW', 'Regional SW'));
      states.add(new SelectOption('Regional NW', 'Regional NW'));
      states.add(new SelectOption('Regional SE', 'Regional SE'));
      for ( Schema.PicklistEntry f : ples) {
        states.add(new SelectOption(f.getLabel(), f.getValue()));
      }
      Schema.DescribeFieldResult fieldResultc = MBE_Profile__c.Company_Certifications__c.getDescribe();
      List<Schema.PicklistEntry> plec = fieldResultc.getPicklistValues();
      for ( Schema.PicklistEntry f : plec) {
        companyCertifications.add(new SelectOption(f.getLabel(), f.getValue()));
      }
      Schema.DescribeFieldResult fieldResultp = MBE_Profile__c.AS_PrimaryBusinessCategory1__c.getDescribe();
      List<Schema.PicklistEntry> plep = fieldResultp.getPicklistValues();
      for ( Schema.PicklistEntry f : plep) {
        primarybusinesscategory.add(new SelectOption(f.getLabel(), f.getValue()));
      }

    } else {
      Schema.DescribeFieldResult fieldResults = AttendeeSummary__c.AS_Work_States__c.getDescribe();
      List<Schema.PicklistEntry> ples = fieldResults.getPicklistValues();
      for ( Schema.PicklistEntry f : ples) {
        states.add(new SelectOption(f.getLabel(), f.getValue()));
      }
      Schema.DescribeFieldResult fieldResultc = AttendeeSummary__c.Company_Certifications__c.getDescribe();
      List<Schema.PicklistEntry> plec = fieldResultc.getPicklistValues();
      for ( Schema.PicklistEntry f : plec) {
        companyCertifications.add(new SelectOption(f.getLabel(), f.getValue()));
      }
      Schema.DescribeFieldResult fieldResultp = AttendeeSummary__c.AS_PrimaryBusinessCategory1__c.getDescribe();
      List<Schema.PicklistEntry> plep = fieldResultp.getPicklistValues();
      for ( Schema.PicklistEntry f : plep) {
        primarybusinesscategory.add(new SelectOption(f.getLabel(), f.getValue()));
      }
    }

    Startcount = 0;
    if (Startcount == 0) {
      hasPrevAcc = false;
    }
    hasNextAcc = true;
    countRec = 20;
    if (null != eveObj.numberOfrows__c) {
      countRec = Integer.valueOf(eveObj.numberOfrows__c);
    }
    Endcount = countRec;
    StartRecAcc = 1;
    //Loading WBES
    if (isCustomevent)
      searchCustomEventAttendees();
    else
      SearchAttendees();
  }


// Search Will start here
  public void searchCustomEventAttendees() {
  try{
    boolean isDiverApplied = false;
    boolean iskeyWorkApplied = false;
    System.debug('globalSearchStr ClearAll   ' + BAkeywords);
    if (globalSearchStr != null && globalSearchStr != '') {
      if (globalSearchAttids.size() > 0) {
        searchString = 'SELECT Name, Id,DiversityType__c, MBE_Profile__r.Key_Words__c, MBE_Profile__r.AS_ImageUrl__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE Id In  :globalSearchAttids  AND ';
      } else {
        globalSearchStr = '';
      }
    } else {
      searchString = 'SELECT Name, Id,DiversityType__c, MBE_Profile__r.Key_Words__c, MBE_Profile__r.AS_ImageUrl__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=' + '\'' + eveObj.Id + '\'' + ' AND IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = \'Attendee\'  AND ';
    }
    SET<ID> mbeProfIDskeyword = new SEt<ID>();//MBE_Profile__r.
    LIST<ID> mbeProfIDs = new LIST<ID>();
    System.debug('  Event Id ' + eveObj.id);
    String keyWordstring = '';
    List<MBE_Profile__c> getMbeProfiles = new List<MBE_Profile__c>();
    if (BAkeywords != null && BAkeywords != '' ) {
      for (String Bkeys : BAkeywords.split(',')) {
        iskeyWorkApplied = true;
        //System.debug('AAAAAAAAAA   '+Bkeys);
        for (Event_Attendee_Mapping__c mb : [select id, MBE_Profile__r.Key_Words__c, MBE_Profile__r.AS_DiversityType__c from Event_Attendee_Mapping__c where EV_id__c = :eveObj.id and IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = 'Attendee']) {
          if (null != mb.MBE_Profile__r.Key_Words__c) {
            if ((mb.MBE_Profile__r.Key_Words__c.TolowerCase()).contains(Bkeys.TolowerCase())) {
              mbeProfIDskeyword.add(mb.id);
              System.debug('AAAAAAAAAA   ' + mbeProfIDskeyword);
            }
          }
        }
      }
    }
    String attNameString = '';
    if (attName != null && attName != '' ) {
      if (globalSearchAttids.size() > 0)
        searchString = 'SELECT Name, Id,DiversityType__c, MBE_Profile__r.Key_Words__c, MBE_Profile__r.AS_ImageUrl__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=' + '\'' + eveObj.Id + '\'' + ' AND  IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = \'Attendee\'  AND ID IN :globalSearchAttids AND ';
      else
        searchString = 'SELECT Name, Id,DiversityType__c, MBE_Profile__r.Key_Words__c, MBE_Profile__r.AS_ImageUrl__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=' + '\'' + eveObj.Id + '\'' + ' AND  IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = \'Attendee\'  AND ';

      attNameString = '( MBE_Profile__r.AS_FirstName__c LIKE \'%' + attName.trim() + '%\' OR MBE_Profile__r.AS_LastName__c LIKE \'%' + attName.trim() + '%\' OR MBE_Profile__r.FullName__c LIKE \'%' + attName.trim() + '%\' OR MBE_Profile__r.Total_Name__c LIKE \'%' + attName.trim() + '%\')';
      searchString +=  attNameString + ' AND ';
      system.debug('RRRRRRR:::' + searchString );
    }
    String companyNameString = '';
    if (companyName != null && companyName != '' ) {
      companyNameString = ' ( MBE_Profile__r.AS_Company__c LIKE \'%' + companyName.trim() + '%\')';
      searchString +=  companyNameString + ' AND ';
    }
    String NaicsCodeString = '( ';
    if (NaicsCode1 != null && NaicsCode1 != '') {
      String naics1 = NaicsCode1;
      NaicsCodeString += '(MBE_Profile__r.AS_NAICSCode_1__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode_2__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode_3__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode_4__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode6__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode7__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode8__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode9__c Like \'%' + naics1.trim() + '%\'' + ' OR MBE_Profile__r.AS_NAICSCode_5__c Like \'%' + naics1.trim() + '%\'' + ')' + 'OR' ;
    }
    if ( NaicsCodeString.contains( 'OR')) {
      searchString +=  NaicsCodeString.subString(0, NaicsCodeString.LastIndexOf('OR')) + ' ) AND ';
    }
    if (Selectedcommodities.size() > 0) {
      searchString +=  '(MBE_Profile__r.Commodity_1__c IN :Selectedcommodities OR MBE_Profile__r.Commodity_2__c IN :Selectedcommodities OR MBE_Profile__r.Commodity_3__c  IN :Selectedcommodities OR MBE_Profile__r.Commodity_4__c IN :Selectedcommodities OR MBE_Profile__r.Commodity_5__c IN :Selectedcommodities OR MBE_Profile__r.Commodity_6__c IN :Selectedcommodities OR MBE_Profile__r.Commodity_7__c IN :Selectedcommodities OR MBE_Profile__r.Commodity_8__c IN :Selectedcommodities OR MBE_Profile__r.Commodity_9__c IN :Selectedcommodities) AND ';
    }
    // GSA Schedule GSASchedule
    String GSAScheduleString = '';
    if (GSASchedule != null) {
      if (GSASchedule != 'Yes')
        GSAScheduleString = 'MBE_Profile__r.GSA_Schedule__c != null ';
      else if (GSASchedule != 'No')
        GSAScheduleString = 'MBE_Profile__r.GSA_Schedule__c = null ';
      searchString +=  GSAScheduleString + ' AND ';
    }

    // Revenue
    String RevenueString = '( ';
    if (!SelectedRevenueAmount.isEmpty()) {

      for (String str : SelectedRevenueAmount) {
        RevenueString += (str + ' OR ');
      }
      RevenueString = RevenueString.subString(0, RevenueString.LastIndexOf('OR'));
      searchString += RevenueString + ')  ' + ' AND ';
    }

    //noOfEmployeesItems
    String noOfEmployeesString = '( ';
    if (!SelectednoOfEmployees.isEmpty()) {
      for (String str : SelectednoOfEmployees) {
        noOfEmployeesString += (str + ' OR ');
      }
      noOfEmployeesString = noOfEmployeesString.subString(0, noOfEmployeesString.lastIndexOf('OR'));
      searchString += noOfEmployeesString + ') ' + ' AND ';
    }
    // States Parsing
    if (!Selectedstatess.isEmpty()) {
      String statesString = ' ( ';
      //' AS_CellPhone__c LIKE \'%'+ phoneArea+'%\' '
      for (String str : Selectedstatess) {
        statesString +=  'MBE_Profile__r.AS_Work_States__c = \'' + str + '\' OR ' + 'MBE_Profile__r.Geographical_Region__c LIKE \'%' + str + '%\' OR ';
      }
      statesString = statesString.subString(0, statesString.lastIndexOf('OR'));
      searchString += statesString + ') ' + ' AND ';
    }
    system.debug('++++++++++++=== ' + searchString );
    //Years in Business
    if (!SelectedyearsOfbusiness.isEmpty()) {
      System.debug('PPPPPPPPPPPPPPPQQQQQQQQQ ' + SelectedyearsOfbusiness);
      String yearsString1 = '(';
      for (String str : SelectedyearsOfbusiness) {
        System.debug('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP ' + str);
        yearsString1 += ('MBE_Profile__r.Year_in_business__c =\'' + str + '\' OR ');
      }
      yearsString1 = yearsString1.subString(0, yearsString1.lastIndexOf('OR'));
      searchString += yearsString1 + ')' + ' AND ';
    }

    // yearss
    if (!Selectedyearss.isEmpty()) {
      String yearsString = '(';
      for (String str : Selectedyearss) {
        if (str == '1950') {
          Date dt = Date.parse('01/01/1951');
          str = '(MBE_Profile__r.AS_BusinessEstablishedDate__c<:dt)';
        } else if (str == '1951-1960') {
          Date Dt1 = Date.parse('01/01/1951');
          Date Dt2 = Date.parse('01/01/1960');
          str = '((MBE_Profile__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (MBE_Profile__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1961-1970') {
          Date Dt1 = Date.parse('01/01/1961');
          Date Dt2 = Date.parse('01/01/1970');
          str = '((MBE_Profile__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (MBE_Profile__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1971-1980') {
          Date Dt1 = Date.parse('01/01/1971');
          Date Dt2 = Date.parse('01/01/1980');
          str = '((MBE_Profile__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (MBE_Profile__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1981-1990') {
          Date Dt1 = Date.parse('01/01/1981');
          Date Dt2 = Date.parse('01/01/1990');
          str = '((MBE_Profile__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (MBE_Profile__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1991-2000') {
          Date Dt1 = Date.parse('01/01/1991');
          Date Dt2 = Date.parse('01/01/2000');
          str = '((MBE_Profile__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (MBE_Profile__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '2001-2010') {
          Date Dt1 = Date.parse('01/01/2001');
          Date Dt2 = Date.parse('01/01/2010');
          str = '((MBE_Profile__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (MBE_Profile__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '2011 Later') {
          Date Dt1 = Date.parse('01/01/2011');
          str = '(MBE_Profile__r.AS_BusinessEstablishedDate__c>=:Dt1)';
        }
        yearsString += (str + ' OR ');
      }
      yearsString = yearsString.subString(0, yearsString.lastIndexOf('OR'));
      searchString += yearsString + ')' + ' AND ';
    }

    //company Certifications
   if (!SelectedcompanyCertificationss.isEmpty()) {
      String companyCertificationsString = '( ';
      for (String str : SelectedcompanyCertificationss) {
        companyCertificationsString +=  '  MBE_Profile__r.company_Certifications__c = \'' + str + '\' OR ';
      }
      companyCertificationsString = companyCertificationsString.subString(0, companyCertificationsString.lastIndexOf('OR'));
      searchString += companyCertificationsString + ') ' + ' AND ';
    }


    //primarybusinesscategory
    if (!SelectedprimaryBusinesscategories.isEmpty()) {
      String primaryBusinesscategoryString = ' ( ';
      for (String str : SelectedprimaryBusinesscategories) {
        primaryBusinesscategoryString +=  '  MBE_Profile__r.AS_PrimaryBusinessCategory1__c = \'' + str + '\' OR ';
      }
      primaryBusinesscategoryString = primaryBusinesscategoryString.subString(0, primaryBusinesscategoryString.lastIndexOf('OR'));
      searchString += primaryBusinesscategoryString + ') '  + ' AND ';
    }


    //matchedPeers
    if (!SelectedmatchedPeers.isEmpty()) {
      String matchedPeersString = '( ';
      for (String str : SelectedmatchedPeers) {
        matchedPeersString +=  '  MBE_Profile__r.AS_PrimaryBusinessCategory1__c = \'' + str + '\' OR ';
      }
      matchedPeersString = matchedPeersString.subString(0, matchedPeersString.lastIndexOf('OR'));
      searchString += matchedPeersString + ') ' + ' AND ';
    }
    // Zip Code
    String ZipcodeString = '';
    if (zipCode != null) {
      ZipcodeString = ' MBE_Profile__r.AS_WorkZip__c = \'' + zipCode + '\' ';
      searchString += ZipcodeString + ' AND ';
    }
    //Phone Number
    String phoneString = '';
    if (phoneArea != null && phoneArea != '') {
      phoneString = ' MBE_Profile__r.AS_CellPhone__c LIKE \'%' + phoneArea + '%\' ';
      searchString += phoneString + ' AND ';
    }
    if (iskeyWorkApplied) {
      string idquery = ' Id in :mbeProfIDskeyword ';
      searchString += idquery + ' AND ';
    }
    //  LIST<AttendeeSummary__c> as = DataBase.QueryString(searchString);
    //String strForQuery =searchString;
    //searchString=basicQuery+searchString;

    if (searchString.endsWith('AND ')) {
      searchString = searchString.subString(0, searchString.lastIndexOf('AND '));
    } else If(searchString.endsWith('WHERE  ')) {
      searchString = searchString.subString(0, searchString.lastIndexOf('WHERE '));
    }

    String strForQuery = 'SELECT count(id) cnt FROM Event_Attendee_Mapping__c';
    if (searchString != '') {
      strForQuery += ' WHERE ' + searchString.split('WHERE')[1];
    }
    if(SelectedBusinessTypes.size() == 0){
    searchString += ' Limit ' + countRec + ' offset ' + Startcount;
    }
    system.debug('  String Query   ' + searchString );
    queryParentObject = new List<Event_Attendee_Mapping__c>();

    queryParentObject = Database.query(searchString);
    System.debug(' Where Condition ' + strForQuery);

    system.debug(' strForQuery ' + strForQuery);
    for (aggregateResult aggr : Database.Query(strForQuery)) {
      Totalcount = Integer.valueOf(aggr.get('cnt'));
      system.debug(':::::::::::::;;;;;;;;;Totalcount:::'+Totalcount);
      if (Totalcount < Endcount)
        Endcount = Totalcount;
      if (Totalcount == Endcount)
        hasNextAcc = false;
    }
    if(Totalcount <20){
    hasprevAcc=false;
    }
    if(Totalcount >20){
    
    hasNextAcc = true;
    }
    
    system.debug('      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     ' + queryParentObject );
    EventScheduleShow1(queryParentObject); // This will construct lisfor front end
    }catch(exception e){}
  }

//method to search MBE profiles
  public void EventScheduleShow1(LIST<Event_Attendee_Mapping__c> eamsvalues) {
  try{
    // displayAttendeeSummaries = new LIST<Event_Attendee_Mapping__c>();
    InnerEAMValuesTodispaly = new LIST<innerEAM>();
    //Main list used in vf page
    innerValuesToPassAnotherInner  = new LIST<innerEAM>();
    innListToDisplay = new List<innerEAMColums>();
    system.debug('      rrrrrrrrr    ' + eamsvalues.size() );
    for (Event_Attendee_Mapping__c eam  : eamsvalues ) {
      if (!SelectedBusinessTypes.isEmpty()) {
        for (String str : SelectedBusinessTypes) {
        system.debug('::::::::::::::div::::::'+eam.DiversityType__c);
          if (null != eam.DiversityType__c) {
            if (eam.DiversityType__c.contains(str))
              InnerEAMValuesTodispaly.add(new innerEAM(eam , 'S' ));
          }
        }
        system.debug('::::::::::::::div::::::'+InnerEAMValuesTodispaly);
      } else {
        InnerEAMValuesTodispaly.add(new innerEAM(eam , 'S' ));
      }
    }
    Integer countColumns = 0;
    System.debug(' Totalcount ' + Totalcount);
    for (innerEAM inn :  InnerEAMValuesTodispaly ) {
      innerValuesToPassAnotherInner.add(inn);
      ++countColumns;
      if (innerValuesToPassAnotherInner.size() == columnsTodisplay) {
        innListToDisplay.add(new innerEAMColums(innerValuesToPassAnotherInner));
        innerValuesToPassAnotherInner  = new LIST<innerEAM>();
        countColumns = 0;
      }
      
    }
    if (! innerValuesToPassAnotherInner.isEmpty()) {
      innListToDisplay.add(new innerEAMColums(innerValuesToPassAnotherInner));
       if(innListToDisplay.size() < 20){
            hasprevAcc=false;
            hasNextAcc =false;
            }
        if(innListToDisplay.size()>20){
    
            hasNextAcc = true;
        }
    }
    }catch(exception e){}
  }

//method to search attendee summary
  public void EventScheduleShow(LIST<ID> AttIds ) {

  }

//Method to search attendees for standard event
  public void SearchAttendees() {
     boolean isDiverApplied = false;
    boolean iskeyWorkApplied = false;
    System.debug('globalSearchStr ClearAll   ' + BAkeywords);
    if (globalSearchStr != null && globalSearchStr != '') {
      if (globalSearchAttids.size() > 0) {
        searchString = 'SELECT Name, Id,DiversityType__c, AS_Id__r.KeyWords__c, AS_Id__r.AS_ImageUrl__c, AS_Id__r.AS_FirstName__c, AS_Id__r.AS_LastName__c, AS_Id__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE Id In  :globalSearchAttids  AND ';
      } else {
        globalSearchStr = '';
      }
    } else {
      searchString = 'SELECT Name, Id,DiversityType__c, AS_Id__r.KeyWords__c, AS_Id__r.AS_ImageUrl__c, AS_Id__r.AS_FirstName__c, AS_Id__r.AS_LastName__c, AS_Id__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=' + '\'' + eveObj.Id + '\'' + ' AND IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = \'Attendee\'  AND ';
    }
    SET<ID> mbeProfIDskeyword = new SEt<ID>();//AS_Id__r.
    LIST<ID> mbeProfIDs = new LIST<ID>();
    System.debug('  Event Id ' + eveObj.id);
    String keyWordstring = '';
    List<MBE_Profile__c> getMbeProfiles = new List<MBE_Profile__c>();
    if (BAkeywords != null && BAkeywords != '' ) {
      for (String Bkeys : BAkeywords.split(',')) {
        iskeyWorkApplied = true;
        //System.debug('AAAAAAAAAA   '+Bkeys);
        for (Event_Attendee_Mapping__c mb : [select id, AS_Id__r.KeyWords__c, AS_Id__r.AS_DiversityType__c from Event_Attendee_Mapping__c where EV_id__c = :eveObj.id and IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = 'Attendee']) {
          if (null != mb.AS_Id__r.KeyWords__c) {
            if ((mb.AS_Id__r.KeyWords__c.TolowerCase()).contains(Bkeys.TolowerCase())) {
              mbeProfIDskeyword.add(mb.id);
              System.debug('AAAAAAAAAA   ' + mbeProfIDskeyword);
            }
          }
        }
      }
    }
    String attNameString = '';
    if (attName != null && attName != '' ) {
      if (globalSearchAttids.size() > 0)
        searchString = 'SELECT Name, Id,DiversityType__c, AS_Id__r.Keywords__c, AS_Id__r.AS_ImageUrl__c, AS_Id__r.AS_FirstName__c, AS_Id__r.AS_LastName__c, AS_Id__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=' + '\'' + eveObj.Id + '\'' + ' AND  IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = \'Attendee\'  AND ID IN :globalSearchAttids AND ';
      else
        searchString = 'SELECT Name, Id,DiversityType__c, AS_Id__r.Keywords__c, AS_Id__r.AS_ImageUrl__c, AS_Id__r.AS_FirstName__c, AS_Id__r.AS_LastName__c, AS_Id__r.AS_Company__c, EV_id__r.Is_Webank_event__c FROM Event_Attendee_Mapping__c WHERE EV_id__c=' + '\'' + eveObj.Id + '\'' + ' AND  IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = \'Attendee\'  AND ';

      attNameString = '( AS_Id__r.AS_FirstName__c LIKE \'%' + attName.trim() + '%\' OR AS_Id__r.AS_LastName__c LIKE \'%' + attName.trim() + '%\' OR AS_Id__r.FullName__c LIKE \'%' + attName.trim() + '%\' OR AS_Id__r.Total_Name__c LIKE \'%' + attName.trim() + '%\')';
      searchString +=  attNameString + ' AND ';
      system.debug('RRRRRRR:::' + searchString );
    }
    String companyNameString = '';
    if (companyName != null && companyName != '' ) {
      companyNameString = ' ( AS_Id__r.AS_Company__c LIKE \'%' + companyName.trim() + '%\')';
      searchString +=  companyNameString + ' AND ';
    }
    String NaicsCodeString = '( ';
    if (NaicsCode1 != null && NaicsCode1 != '') {
      String naics1 = NaicsCode1;
      NaicsCodeString += '(AS_Id__r.AS_NAICSCode_1__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode_2__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode_3__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode_4__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode6__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode7__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode8__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode9__c Like \'%' + naics1.trim() + '%\'' + ' OR AS_Id__r.AS_NAICSCode_5__c Like \'%' + naics1.trim() + '%\'' + ')' + 'OR' ;
    }
    if ( NaicsCodeString.contains( 'OR')) {
      searchString +=  NaicsCodeString.subString(0, NaicsCodeString.LastIndexOf('OR')) + ' ) AND ';
    }
    if (Selectedcommodities.size() > 0) {
      searchString +=  '(AS_Id__r.Commodity_1__c IN :Selectedcommodities OR AS_Id__r.Commodity_2__c IN :Selectedcommodities OR AS_Id__r.Commodity_3__c  IN :Selectedcommodities OR AS_Id__r.Commodity_4__c IN :Selectedcommodities OR AS_Id__r.Commodity_5__c IN :Selectedcommodities OR AS_Id__r.Commodity_6__c IN :Selectedcommodities OR AS_Id__r.Commodity_7__c IN :Selectedcommodities OR AS_Id__r.Commodity_8__c IN :Selectedcommodities OR AS_Id__r.Commodity_9__c IN :Selectedcommodities) AND ';
    }
    // GSA Schedule GSASchedule
    String GSAScheduleString = '';
    if (GSASchedule != null) {
      if (GSASchedule != 'Yes')
        GSAScheduleString = 'AS_Id__r.GSA_Schedule__c != null ';
      else if (GSASchedule != 'No')
        GSAScheduleString = 'AS_Id__r.GSA_Schedule__c = null ';
      searchString +=  GSAScheduleString + ' AND ';
    }

    // Revenue
    String RevenueString = '( ';
    if (!SelectedRevenueAmount.isEmpty()) {

      for (String str : SelectedRevenueAmount) {
        RevenueString += (str + ' OR ');
      }
      RevenueString = RevenueString.subString(0, RevenueString.LastIndexOf('OR'));
      searchString += RevenueString + ')  ' + ' AND ';
    }

    //noOfEmployeesItems
    String noOfEmployeesString = '( ';
    if (!SelectednoOfEmployees.isEmpty()) {
      for (String str : SelectednoOfEmployees) {
        noOfEmployeesString += (str + ' OR ');
      }
      noOfEmployeesString = noOfEmployeesString.subString(0, noOfEmployeesString.lastIndexOf('OR'));
      searchString += noOfEmployeesString + ') ' + ' AND ';
    }
    // States Parsing
    if (!Selectedstatess.isEmpty()) {
      String statesString = ' ( ';
      //' AS_CellPhone__c LIKE \'%'+ phoneArea+'%\' '
      for (String str : Selectedstatess) {
        statesString +=  'AS_Id__r.AS_Work_States__c = \'' + str + '\' OR ' + 'AS_Id__r.Geographical_Region__c LIKE \'%' + str + '%\' OR ';
      }
      statesString = statesString.subString(0, statesString.lastIndexOf('OR'));
      searchString += statesString + ') ' + ' AND ';
    }
    system.debug('++++++++++++=== ' + searchString );
    //Years in Business
    if (!SelectedyearsOfbusiness.isEmpty()) {
      System.debug('PPPPPPPPPPPPPPPQQQQQQQQQ ' + SelectedyearsOfbusiness);
      String yearsString1 = '(';
      for (String str : SelectedyearsOfbusiness) {
        System.debug('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP ' + str);
        yearsString1 += ('AS_Id__r.Year_in_business__c =\'' + str + '\' OR ');
      }
      yearsString1 = yearsString1.subString(0, yearsString1.lastIndexOf('OR'));
      searchString += yearsString1 + ')' + ' AND ';
    }

    // yearss
    if (!Selectedyearss.isEmpty()) {
      String yearsString = '(';
      for (String str : Selectedyearss) {
        if (str == '1950') {
          Date dt = Date.parse('01/01/1951');
          str = '(AS_Id__r.AS_BusinessEstablishedDate__c<:dt)';
        } else if (str == '1951-1960') {
          Date Dt1 = Date.parse('01/01/1951');
          Date Dt2 = Date.parse('01/01/1960');
          str = '((AS_Id__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (AS_Id__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1961-1970') {
          Date Dt1 = Date.parse('01/01/1961');
          Date Dt2 = Date.parse('01/01/1970');
          str = '((AS_Id__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (AS_Id__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1971-1980') {
          Date Dt1 = Date.parse('01/01/1971');
          Date Dt2 = Date.parse('01/01/1980');
          str = '((AS_Id__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (AS_Id__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1981-1990') {
          Date Dt1 = Date.parse('01/01/1981');
          Date Dt2 = Date.parse('01/01/1990');
          str = '((AS_Id__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (AS_Id__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '1991-2000') {
          Date Dt1 = Date.parse('01/01/1991');
          Date Dt2 = Date.parse('01/01/2000');
          str = '((AS_Id__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (AS_Id__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '2001-2010') {
          Date Dt1 = Date.parse('01/01/2001');
          Date Dt2 = Date.parse('01/01/2010');
          str = '((AS_Id__r.AS_BusinessEstablishedDate__c>=:Dt1) AND (AS_Id__r.AS_BusinessEstablishedDate__c>=: Dt2))';
        } else if (str == '2011 Later') {
          Date Dt1 = Date.parse('01/01/2011');
          str = '(AS_Id__r.AS_BusinessEstablishedDate__c>=:Dt1)';
        }
        yearsString += (str + ' OR ');
      }
      yearsString = yearsString.subString(0, yearsString.lastIndexOf('OR'));
      searchString += yearsString + ')' + ' AND ';
    }

    //company Certifications
    if (!SelectedcompanyCertificationss.isEmpty()) {
      String companyCertificationsString = '( ';
      for (String str : SelectedcompanyCertificationss) {
        companyCertificationsString +=  '  AS_Id__r.company_Certifications__c = \'' + str + '\' OR ';
      }
      companyCertificationsString = companyCertificationsString.subString(0, companyCertificationsString.lastIndexOf('OR'));
      searchString += companyCertificationsString + ') ' + ' AND ';
    }

    //primarybusinesscategory
    if (!SelectedprimaryBusinesscategories.isEmpty()) {
      String primaryBusinesscategoryString = ' ( ';
      for (String str : SelectedprimaryBusinesscategories) {
        primaryBusinesscategoryString +=  '  AS_Id__r.AS_PrimaryBusinessCategory1__c = \'' + str + '\' OR ';
      }
      primaryBusinesscategoryString = primaryBusinesscategoryString.subString(0, primaryBusinesscategoryString.lastIndexOf('OR'));
      searchString += primaryBusinesscategoryString + ') '  + ' AND ';
    }


    //matchedPeers
    if (!SelectedmatchedPeers.isEmpty()) {
      String matchedPeersString = '( ';
      for (String str : SelectedmatchedPeers) {
        matchedPeersString +=  '  AS_Id__r.AS_PrimaryBusinessCategory1__c = \'' + str + '\' OR ';
      }
      matchedPeersString = matchedPeersString.subString(0, matchedPeersString.lastIndexOf('OR'));
      searchString += matchedPeersString + ') ' + ' AND ';
    }
    // Zip Code
    String ZipcodeString = '';
    if (zipCode != null) {
      ZipcodeString = ' AS_Id__r.AS_WorkZip__c = \'' + zipCode + '\' ';
      searchString += ZipcodeString + ' AND ';
    }
    //Phone Number
    String phoneString = '';
    if (phoneArea != null && phoneArea != '') {
      phoneString = ' AS_Id__r.AS_CellPhone__c LIKE \'%' + phoneArea + '%\' ';
      searchString += phoneString + ' AND ';
    }
    if (iskeyWorkApplied) {
      string idquery = ' Id in :mbeProfIDskeyword ';
      searchString += idquery + ' AND ';
    }
    //  LIST<AttendeeSummary__c> as = DataBase.QueryString(searchString);
    //String strForQuery =searchString;
    //searchString=basicQuery+searchString;

    if (searchString.endsWith('AND ')) {
      searchString = searchString.subString(0, searchString.lastIndexOf('AND '));
    } else If(searchString.endsWith('WHERE  ')) {
      searchString = searchString.subString(0, searchString.lastIndexOf('WHERE '));
    }

    String strForQuery = 'SELECT count(id) cnt FROM Event_Attendee_Mapping__c';
    if (searchString != '') {
      strForQuery += ' WHERE ' + searchString.split('WHERE')[1];
    }

    searchString += ' Limit ' + countRec + ' offset ' + Startcount;
    system.debug('  String Query   ' + searchString );
    queryParentObject = new List<Event_Attendee_Mapping__c>();

    queryParentObject = Database.query(searchString);
    System.debug(' Where Condition ' + strForQuery);

    system.debug(' strForQuery ' + strForQuery);
    for (aggregateResult aggr : Database.Query(strForQuery)) {
      Totalcount = Integer.valueOf(aggr.get('cnt'));
      if (Totalcount < Endcount)
        Endcount = Totalcount;
      if (Totalcount == Endcount)
        hasNextAcc = false;
    }
    system.debug('      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     ' + queryParentObject );
    EventScheduleShow1(queryParentObject); // This will construct lisfor front end
  }

  public void globalSearchMbe() {
    Startcount = 0;
    StartRecAcc = 1;
    Endcount = countRec;
    globalSearchAttids = new List<id>();
    if (globalSearchStr != null && globalSearchStr != '') {
      MM_GlobalSearch gnsearch = new MM_GlobalSearch();
      InnerEAMValuesTodispaly = new LIST<innerEAM>();
      //Main list used in vf page
      innListToDisplay = new LIST<innerEAMColums>();
      innerValuesToPassAnotherInner  = new LIST<innerEAM>();
      if (globalSearchStr != null && globalSearchStr != '') {
        globalSearchStr = globalSearchStr.trim();
        globalSearchStr = globalSearchStr.TolowerCase();
      }
      transient List<Event_Attendee_Mapping__c> tempEam = new List<Event_Attendee_Mapping__c>();
      if (isCustomevent) {
        tempEam = [select MBE_Profile__r.Revenue_Range__c, MBE_Profile__r.Scope_of_Work2__c, MBE_Profile__r.Scope_of_Work__c, MBE_Profile__r.References2__c, MBE_Profile__r.References__c, MBE_Profile__r.Year_in_business__c, MBE_Profile__r.AS_NAICSCode9__c, MBE_Profile__r.AS_NAICSCode8__c, MBE_Profile__r.AS_NAICSCode7__c, MBE_Profile__r.AS_NAICSCode6__c, MBE_Profile__r.AS_Work_States__c, AS_Id__r.AS_ImageUrl__c, MBE_Profile__r.AS_ImageUrl__c, Ev_id__r.Is_Webank_event__c, id, DiversityType__c, MBE_Profile__c, As_id__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.FullName__c, MBE_Profile__r.AS_Email__c, MBE_Profile__r.AS_Company__c, MBE_Profile__r.Key_Words__c, MBE_Profile__r.As_NAICSCode_1__c, MBE_Profile__r.As_NAICSCode_2__c, MBE_Profile__r.As_NAICSCode_3__c, MBE_Profile__r.As_NAICSCode_4__c, MBE_Profile__r.As_NAICSCode_5__c, MBE_Profile__r.Commodity_1__c, MBE_Profile__r.Commodity_2__c, MBE_Profile__r.Commodity_3__c, MBE_Profile__r.Commodity_4__c, MBE_Profile__r.Commodity_5__c, MBE_Profile__r.Commodity_6__c, MBE_Profile__r.Commodity_7__c, MBE_Profile__r.Commodity_8__c, MBE_Profile__r.Commodity_9__c, MBE_Profile__r.GSA_Schedule__c, MBE_Profile__r.AS_BusinessRevenue__c, MBE_Profile__r.AS_NumberOfEmployees__c, MBE_Profile__r.Geographical_Region__c, MBE_Profile__r.Company_Certifications__c, MBE_Profile__r.AS_PrimaryBusinessCategory1__c, MBE_Profile__r.AS_CellPhone__c
                   from Event_Attendee_Mapping__c where EV_id__c = :selectedEventId  and IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = 'Attendee' and EV_id__c != null ];
      } else {
        tempEam = [select AS_Id__r.Revenue_Range__c, AS_Id__r.Scope_of_Work2__c, AS_Id__r.Scope_of_Work__c, AS_Id__r.References2__c, AS_Id__r.References__c, AS_Id__r.Year_in_business__c, AS_Id__r.AS_NAICSCode9__c, AS_Id__r.AS_NAICSCode8__c, AS_Id__r.AS_NAICSCode7__c, AS_Id__r.AS_NAICSCode6__c, AS_Id__r.AS_Work_States__c, AS_Id__r.AS_ImageUrl__c, Ev_id__r.Is_Webank_event__c, id, DiversityType__c, AS_Id__r.AS_FirstName__c, AS_Id__r.AS_LastName__c, AS_Id__r.FullName__c, AS_Id__r.AS_Email__c, AS_Id__r.AS_Company__c, AS_Id__r.As_NAICSCode_1__c, AS_Id__r.As_NAICSCode_2__c, AS_Id__r.As_NAICSCode_3__c, AS_Id__r.As_NAICSCode_4__c, AS_Id__r.As_NAICSCode_5__c, AS_Id__r.Commodity_1__c, AS_Id__r.Commodity_2__c, AS_Id__r.Commodity_3__c, AS_Id__r.Commodity_4__c, AS_Id__r.Commodity_5__c, AS_Id__r.Commodity_6__c, AS_Id__r.Commodity_7__c, AS_Id__r.Commodity_8__c, AS_Id__r.Commodity_9__c, AS_Id__r.GSA_Schedule__c, AS_Id__r.AS_BusinessRevenue__c, AS_Id__r.AS_NumberOfEmployees__c, AS_Id__r.Geographical_Region__c, AS_Id__r.Company_Certifications__c, AS_Id__r.AS_PrimaryBusinessCategory1__c, AS_Id__r.AS_CellPhone__c
                   from Event_Attendee_Mapping__c where EV_id__c = :selectedEventId  and IsMatchMakingAttendee__c = true AND  Boothleads_Profile__c = 'Attendee' and EV_id__c != null];
      }

      for (Event_Attendee_Mapping__c eam : tempEam ) {
        string findStrInrec = gnsearch.Gnsearch(eam, eam.Ev_id__r.Is_Webank_event__c);
        if (findStrInrec.contains(globalSearchStr)) {
          globalSearchAttids.add(eam.id);
        }
      }
      hasprevAcc=false;
      if (isCustomevent)
        searchCustomEventAttendees();
      else
        SearchAttendees();
    } else {
      if (isCustomevent)
        searchCustomEventAttendees();
      else
        SearchAttendees();
    }
  }


  //Search functionality for both Standard and Custom Events
  public void seachEventWiseAttendees() {
    Startcount = 0;
    StartRecAcc = 1;
    if (isCustomevent)
      searchCustomEventAttendees();
    else
      SearchAttendees();
  }

  public void viewProfile() {
    Commanforstates cd12121 = new Commanforstates ();
    ID eamId = apexpages.currentpage().getparameters().get('viewProfileId');
    eventone = new Event__c();
    errormsg =false;
    eventone = [SELECT id, Is_Webank_event__c, owner.username from Event__c WHERE id = :selectedEvent];
    vewProfileEAM = new  Event_Attendee_Mapping__c();
    attchments = new list<Attachment>();
    if (eventone.Is_Webank_event__c == false) {
      system.debug('111111111111111111111111111111111111111111111111           ' + eamId);
      vewProfileEAM = [SELECT  DiversityType__c,  AS_id__r.Id,
                       AS_id__r.AS_WorkZipCode__c,
                       AS_id__r.AS_WorkState__c,
                       AS_id__r.AS_WorkPoBox__c,
                       AS_id__r.AS_WorkPhone__c,
                       AS_id__r.As_prefixNew__c,
                       AS_id__r.AS_WorkCountry__c,
                       AS_id__r.AS_WorkCity__c,
                       AS_id__r.AS_WorkAddress2__c,
                       AS_id__r.AS_WorkAddress1__c,
                       AS_id__r.AS_WebsiteUrl__c,
                       AS_id__r.AS_Title__c,
                       AS_id__r.AS_ThroughEventBrite__c,
                       AS_id__r.AS_Suffix__c,
                       AS_id__r.AS_ShippingZipcode__c,
                       AS_id__r.AS_ShippingState__c,
                       AS_id__r.AS_ShippingPoBox__c,
                       AS_id__r.AS_ShippingPhone__c,
                       AS_id__r.AS_ShippingCountry__c,
                       AS_id__r.AS_ShippingCity__c,
                       AS_id__r.AS_CageCode__c,
                       AS_id__r.GSA_Schedule__c,
                       AS_id__r.Business_type__c,
                       AS_id__r.DBA__c,
                       AS_id__r.Geographical_Region__c,
                       AS_id__r.Certificate_Processed_by_RPO__c,
                       AS_id__r.BBB_Number__c,
                       AS_id__r.Commodity_1__c,
                       AS_id__r.Commodity_2__c,
                       AS_id__r.Commodity_3__c,
                       AS_id__r.Commodity_4__c,
                       AS_id__r.Commodity_5__c, AS_id__r.Commodity_6__c,
                       AS_id__r.Commodity_7__c,
                       AS_id__r.Commodity_8__c,
                       AS_id__r.Commodity_9__c,
                       AS_id__r.distribution_Country__c,
                       AS_id__r.Manufactures_Country__c,
                       AS_id__r.References__c,
                       AS_id__r.References2__c,
                       AS_id__r.Scope_of_Work__c,
                       AS_id__r.Scope_of_Work2__c,
                       AS_id__r.Any_non_WBENC_awards_received__c,
                       AS_id__r.Companyhaveafacility_partneroutsideUSA__c,
                       AS_id__r.Revenue_Range__c,
                       AS_id__r.AS_NAICSCode9__c,
                       AS_id__r.AS_NAICSCode8__c,
                       AS_id__r.AS_NAICSCode7__c,
                       AS_id__r.AS_NAICSCode6__c,
                       AS_id__r.Company_Certifications__c,
                       AS_id__r.AS_ShippingAddress2__c, AS_id__r.AS_ShippingAddress1__c,
                       AS_id__r.AS_SecondaryBusinessCategory1__c, AS_id__r.AS_PrimaryBusinessCategory1__c, AS_id__r.AS_Prefix__c,
                       AS_id__r.Exhibitor_company_imageUrl__c, AS_id__r.AS_NumberOfEmployees__c, AS_id__r.AS_NAICSCode_5__c, AS_id__r.AS_NAICSCode_4__c, AS_id__r.AS_NAICSCode_3__c,
                       AS_id__r.AS_NAICSCode_2__c, AS_id__r.AS_NAICSCode_1__c, AS_id__r.AS_LastName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_HomeZipcode__c,
                       AS_id__r.AS_HomeState__c, AS_id__r.AS_HomePoBox__c, AS_id__r.AS_HomePhone__c, AS_id__r.AS_HomeCountry__c, AS_id__r.AS_HomeCity__c,
                       AS_id__r.AS_HomeAddress2__c, AS_id__r.AS_HomeAddress1__c, AS_id__r.AS_Gender__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_FaxNumber__c,
                       AS_id__r.Ethnicity__c, AS_id__r.AS_Secondary_Email__c,
                       AS_id__r.Business_Structure__c, AS_id__r.Year_in_business__c,
                       AS_id__r.AS_Email__c, AS_id__r.AS_DiversityType__c, AS_id__r.AS_Company__c, AS_id__r.AS_CellPhone__c,
                       AS_id__r.AS_BusinessRevenue__c, AS_id__r.AS_BusinessEstablishedDate__c, AS_id__r.AS_BusinessDescription__c,
                       AS_id__r.AS_BlogUrl__c, AS_id__r.AS_BirthDate__c, AS_id__r.AS_Age__c, AS_id__r.AS_Work_Country__c, AS_id__r.AS_Work_States__c, AS_id__r.As_Home_Country__c, AS_id__r.As_Home_State__c, AS_id__r.AS_BusinessTaxId__c, AS_id__r.AS_WorkZip__c, AS_id__r.AS_HomeZip__c, AS_id__r.AS_shippingzip__c,
                       AS_id__r.AS_BusinessDunsNumber__c, AS_id__r.Keywords__c  FROM Event_Attendee_Mapping__c WHERE ID = : eamId  ];
      attchments = [SELECT Id, Name, Description, ContentType FROM Attachment where parentId = : vewProfileEAM.AS_id__c];
      videos = [Select id, YouTubeId_c__c From Widget__c Where AttendeeSummary__r.id = : vewProfileEAM.AS_id__c];
      if (vewProfileEAM.AS_id__r.AS_Work_States__c != null && vewProfileEAM.AS_id__r.AS_Work_States__c != '') {
        vewProfileEAM.AS_id__r.AS_Work_States__c = cd12121.mapstate(vewProfileEAM.AS_id__r.AS_Work_States__c);
      }
    } else {
      vewProfileEAM = [Select  AS_id__c, MBE_Profile__r.As_prefixNew__c , MBE_Profile__r.As_SuffixNew__c, MBE_Profile__r.As_Shipping_Country__c, MBE_Profile__r.As_Shipping_States__c, MBE_Profile__r.SystemModstamp, MBE_Profile__r.OwnerId, MBE_Profile__r.Name, MBE_Profile__r.LastModifiedDate, MBE_Profile__r.LastModifiedById,
                       MBE_Profile__r.LastActivityDate, MBE_Profile__r.IsDeleted, MBE_Profile__r.Id, MBE_Profile__r.CreatedDate, MBE_Profile__r.CreatedById, MBE_Profile__r.Exhibitor_company_imageUrl__c,
                       MBE_Profile__r.AS_WorkZipCode__c, MBE_Profile__r.AS_WorkPhone__c,
                       MBE_Profile__r.AS_WorkCity__c, MBE_Profile__r.AS_WorkAddress2__c, MBE_Profile__r.AS_WorkAddress1__c, MBE_Profile__r.Key_Words__c,
                       MBE_Profile__r.AS_WebsiteUrl__c, MBE_Profile__r.AS_Title__c,
                       MBE_Profile__r.AS_ShippingZipcode__c, MBE_Profile__r.AS_ShippingState__c, MBE_Profile__r.AS_ShippingPoBox__c, MBE_Profile__r.AS_ShippingPhone__c,
                       MBE_Profile__r.AS_ShippingCity__c, MBE_Profile__r.AS_ShippingAddress2__c, MBE_Profile__r.AS_ShippingAddress1__c,
                       MBE_Profile__r.AS_SecondaryBusinessCategory1__c, MBE_Profile__r.AS_PrimaryBusinessCategory1__c,
                       MBE_Profile__r.AS_NumberOfEmployees__c, MBE_Profile__r.AS_NAICSCode_5__c, MBE_Profile__r.AS_NAICSCode_4__c, MBE_Profile__r.AS_NAICSCode_3__c,
                       MBE_Profile__r.AS_NAICSCode_2__c, MBE_Profile__r.AS_NAICSCode_1__c, MBE_Profile__r.AS_LastName__c, MBE_Profile__r.AS_ImageUrl__c,
                       MBE_Profile__r.AS_HomePhone__c, MBE_Profile__r.AS_HomeCity__c,
                       MBE_Profile__r.DBA__c,
                       MBE_Profile__r.Geographical_Region__c,
                       MBE_Profile__r.Certificate_Processed_by_RPO__c,
                       MBE_Profile__r.BBB_Number__c,
                       MBE_Profile__r.Commodity_1__c,
                       MBE_Profile__r.Commodity_2__c,
                       MBE_Profile__r.Commodity_3__c,
                       MBE_Profile__r.Commodity_4__c,
                       MBE_Profile__r.Commodity_5__c,
                       MBE_Profile__r.distribution_Country__c,
                       MBE_Profile__r.Manufactures_Country__c,
                       MBE_Profile__r.References__c,
                       MBE_Profile__r.References2__c,
                       MBE_Profile__r.Scope_of_Work__c,
                       MBE_Profile__r.Scope_of_Work2__c,
                       MBE_Profile__r.Companyhaveafacility_partneroutsideUSA__c,
                       MBE_Profile__r.Any_non_WBENC_awards_received__c,
                       MBE_Profile__r.Revenue_Range__c,
                       MBE_Profile__r.AS_NAICSCode9__c,
                       MBE_Profile__r.AS_NAICSCode8__c,
                       MBE_Profile__r.AS_NAICSCode7__c,
                       MBE_Profile__r.AS_NAICSCode6__c, MBE_Profile__r.Commodity_6__c,
                       MBE_Profile__r.Commodity_7__c,
                       MBE_Profile__r.Commodity_8__c,
                       MBE_Profile__r.Commodity_9__c,
                       MBE_Profile__r.Ethnicity__c, MBE_Profile__r.AS_Secondary_Email__c,
                       MBE_Profile__r.AS_HomeAddress2__c, MBE_Profile__r.AS_HomeAddress1__c, MBE_Profile__r.AS_Gender__c, MBE_Profile__r.AS_FirstName__c, MBE_Profile__r.AS_FaxNumber__c,
                       MBE_Profile__r.AS_Email__c, MBE_Profile__r.AS_DiversityType__c, MBE_Profile__r.AS_Company__c, MBE_Profile__r.AS_CellPhone__c, MBE_Profile__r.AS_CageCode__c, MBE_Profile__r.GSA_Schedule__c,
                       MBE_Profile__r.AS_BusinessRevenue__c, MBE_Profile__r.AS_BusinessEstablishedDate__c, MBE_Profile__r.AS_BusinessDescription__c, MBE_Profile__r.Business_type__c, MBE_Profile__r.Exceptional_Key_Words__c,
                       MBE_Profile__r.AS_BlogUrl__c, MBE_Profile__r.AS_BirthDate__c, MBE_Profile__r.AS_Age__c, MBE_Profile__r.AS_Work_Country__c, MBE_Profile__r.AS_Work_States__c, MBE_Profile__r.As_Home_Country__c, MBE_Profile__r.As_Home_State__c, MBE_Profile__r.AS_WorkZip__c, MBE_Profile__r.AS_HomeZip__c, DiversityType__c,
                       MBE_Profile__r.Business_Structure__c, MBE_Profile__r.Year_in_business__c,
                       MBE_Profile__r.AS_BusinessDunsNumber__c, MBE_Profile__r.AS_BusinessTaxId__c, MBE_Profile__r.Company_Certifications__c from Event_Attendee_Mapping__c WHERE ID = : eamId];
      system.debug(':::::::::::::;;mythily:::::::::::::::' + vewProfileEAM);
      system.debug('nnnnnnnn' + vewProfileEAM.MBE_Profile__r.References2__c);
      if (vewProfileEAM.MBE_Profile__r.AS_Work_States__c != null && vewProfileEAM.MBE_Profile__r.AS_Work_States__c != '') {
        vewProfileEAM.MBE_Profile__r.AS_Work_States__c = cd12121.mapstate(vewProfileEAM.MBE_Profile__r.AS_Work_States__c);
      }
      attchments = [SELECT Id, Name, Description, ContentType FROM Attachment where parentId = : vewProfileEAM.MBE_Profile__r.id];
      cvideos = new list<Custom_Widget__c>();
      cvideos = [Select id, YouTubeId_c__c From Custom_Widget__c Where MBE_Profile__r.id = : vewProfileEAM.MBE_Profile__r.id];
      system.debug('ooooooooo' + vewProfileEAM.MBE_Profile__r.References2__c);
    }
    system.debug('llllllllll' + vewProfileEAM);
    vieProfileBool = false;
    mdeid = vewProfileEAM.id;
  }

  public void viewSchedule() {
    upenames = '';
    errormsg =false;
    //this query is to get boothadmin booth
    User_Profile_Event__c upeid = [select id from User_Profile_Event__c where User_id__r.UserNAme = :userInfo.getUserName() AND EV_id__c = :selectedEvent AND IsMatchMakingUser__c = : true ];
    //this query is to collect all staff who are assigned to booth from above query
    LIST<User_Profile_Event__c> upeidboothid = [select id , BT_id__c, MAtchMakingProfile__c from User_Profile_Event__c where  User_id__c = : UserInfo.getUserId() AND    EV_id__c = : selectedEvent];
    upidsnew = new list<id> ();
    if (upeidboothid.size() != 0) {
      id boothid = upeidboothid[0].BT_id__c;
      list<User_Profile_Event__c> upeowners = [select id, User_id__r.userName from User_Profile_Event__c where User_id__c != : UserInfo.getUserId() AND BT_id__r.id = : boothid ];
      system.debug('nnnnnnnnnnnnnnnnnnnn' + upeowners);
      if (upeowners.size() != 0) {
        for (User_Profile_Event__c up1 : upeowners) {
          if (upeidboothid[0].MAtchMakingProfile__c == 'Corporatestaff' || upeidboothid[0].MAtchMakingProfile__c == 'Corporate') {
            upidsnew.add(up1.id);
            upenames += up1.User_id__r.userName;
          }
        }
      }
    }
    upenames += Userinfo.getusername();
    upidsnew.add(upeid.id);
    system.debug('EVENT TYPE  ' + eventType );
    if (eventType == 'Closed' ) {
      ID eamId = apexpages.currentpage().getparameters().get('viewScheduleId');
      scheduleProfileId = eamId ;
      scheduleEvent = new Event__c();
      boothAdminSchedules = new LIST<EventSchedule__c>();
      attendeeSchedule = new LIST<EventSchedule__c>();
      MAP<String, EventSchedule__c> attendeeScheduleMAP = new MAP<String, EventSchedule__c>();
      MAP<String, EventSchedule__c> exibitorScheduleMAP = new MAP<String, EventSchedule__c>();
      getDataFromUtility = new MAP<Date, LIST<String>>();
      eventTimeSlots = new LIST<String>();
      dateList = new LIST<SelectOption>();
      scheduleEvent = [SELECT ID, NAME, EV_Title__c, MM_End_Date__c, MM_Start_Date__c, MM_Slot_Timeperiod__c,Is_Webank_event__c,
                       BreakTime_Between_Appointments__c, MM_Firstaday_startTime__c, MM_Firstaday_EndTime__c, MM_Secondaday_startTime__c,
                       MM_Secondaday_EndTime__c, Is_MatchMaking_Event__c  FROM Event__c WHERE ID = : selectedEvent];
      allEventDates = new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c = : selectedEvent ORDER BY MatchLeads_Date__c ASC]);
      system.debug('EVENT TYPE 222222222222 ' + allEventDates);
      toDisplayValues = new LIST<InnerClass>();
      if (allEventDates.size() > 0) {
        system.debug('::::::::::::upidsnew :::::::::::::::' + upidsnew );
        MAP<Date, MAP<String, EventSchedule__c>> attendeeScheduleDatesMAP = new MAP<Date, MAP<String, EventSchedule__c>> ();
        MAP<Date, MAP<String, EventSchedule__c>> corporateScheduleDatesMAP = new MAP<Date, MAP<String, EventSchedule__c>> ();
        LIST<EventSchedule__c> attendeeScheduleDates = new LIST<EventSchedule__c>([SELECT  MM_To_EAM__r.AS_id__r.AS_Company__c , MM_To_EAM__r.AS_id__r.AS_CellPhone__c, MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c,
            MM_To_EAM__r.AS_id__r.AS_ImageUrl__c, MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c, MM_To_EAM__r.AS_id__r.AS_WorkAddress2__c, MM_To_EAM__r.AS_id__r.AS_WorkCity__c,
            MM_To_EAM__r.AS_id__r.AS_Work_States__c, MM_To_EAM__r.AS_id__r.AS_WorkZipCode__c, MM_To_EAM__r.AS_id__r.AS_Work_Country__c,
            Owner.Name, Owner.Email, ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
            MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c WHERE EV_id__c = : selectedEvent AND  Is_Matchmaking__c = TRUE AND MM_To_EAM__c = : eamId AND MM_Slot_Status__c != 'Rejected']);
        system.debug('::::::::::::::::::::::::::attendeeScheduleDates:::::::::::::::' + attendeeScheduleDates);
        LIST<EventSchedule__c> exhibitorScheduleDates = new LIST<EventSchedule__c>([SELECT  MM_To_EAM__r.AS_id__r.AS_Company__c , MM_To_EAM__r.AS_id__r.AS_CellPhone__c, MM_To_EAM__r.AS_id__r.AS_Email__c, MM_To_UPE__r.MM_TableNo__c,
            MM_To_EAM__r.AS_id__r.AS_ImageUrl__c, MM_To_EAM__r.AS_id__r.AS_WorkAddress1__c, MM_To_EAM__r.AS_id__r.AS_WorkAddress2__c, MM_To_EAM__r.AS_id__r.AS_WorkCity__c,
            MM_To_EAM__r.AS_id__r.AS_Work_States__c, MM_To_EAM__r.AS_id__r.AS_WorkZipCode__c, MM_To_EAM__r.AS_id__r.AS_Work_Country__c,
            Owner.Name, Owner.Email, ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
            MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c WHERE EV_id__c = : selectedEvent AND Is_Matchmaking__c = TRUE AND  MM_To_UPE__r.id IN: upidsnew AND MM_Slot_Status__c != 'Rejected']);
        system.debug('1111111111111111111' + exhibitorScheduleDates);
        evs = new Event_Attendee_Mapping__c();

        evs = [SELECT AS_id__r.AS_Company__c , AS_id__r.AS_CellPhone__c, AS_id__r.AS_Email__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_WorkAddress1__c,
               AS_id__r.AS_WorkAddress2__c, AS_id__r.AS_WorkCity__c, AS_id__r.AS_Work_States__c,  AS_id__r.AS_WorkZipCode__c,
               MBE_Profile__r.AS_FirstName__c,MBE_Profile__r.AS_LastName__c,MBE_Profile__r.AS_WorkAddress1__c,MBE_Profile__r.AS_WorkAddress2__c,MBE_Profile__r.AS_WorkCity__c,
                    MBE_Profile__r.AS_Work_States__c,MBE_Profile__r.AS_WorkZipCode__c,MBE_Profile__r.AS_Company__c,
               AS_id__r.AS_Work_Country__c, Owner.Name, Owner.Email, ID, NAME, AS_id__r.AS_FirstName__c,  AS_id__r.AS_LastName__c FROM Event_Attendee_Mapping__c WHERE Id = : eamId ];
        for (MatchLeads_Days__c match : allEventDates) {
          attendeeScheduleMAP = new MAP<String, EventSchedule__c>();
          exibitorScheduleMAP = new MAP<String, EventSchedule__c>();
          for (EventSchedule__c aes : attendeeScheduleDates ) {
            if (aes.MM_slot_Date__c == match.MatchLeads_Date__c && aes.MM_Slot_Status__c != 'Cancelled') {
              attendeeScheduleMAP.put(aes.MM_slot_StartTime__c,  aes);
            }
          }
          attendeeScheduleDatesMAP.put(match.MatchLeads_Date__c, attendeeScheduleMAP);
          blokslistexist = [select id, Break_End_Time__c, Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c = : upidsnew];
          listvals = '';
          system.debug('-----------------blocklist--------------' + listvals);
          for (Event_Breaks__c evb : blokslistexist ) {
            listvals += evb.Break_Start_Time__c + '-' + evb.Break_End_Time__c + ',';
          }
          system.debug('-----------------blocklist--------------' + listvals);
          //for(Event_Breaks__c eb : blokslistexist ){
          for (EventSchedule__c ees : exhibitorScheduleDates) {
            if (ees.MM_slot_Date__c == match.MatchLeads_Date__c && ees.MM_Slot_Status__c != 'Cancelled') {
              exibitorScheduleMAP.put(ees.MM_slot_StartTime__c,  ees);
            }
          }
          listvalsmbe = '';
          list<Event_Breaks__c> blokslistexistmbe = new list<Event_Breaks__c>();
          blokslistexistmbe = [select id, Break_End_Time__c, Break_Start_Time__c from Event_Breaks__c where Event_Attendee_Mapping__c = : eamId ];
          system.debug('-----------------blocklist--------------' + listvalsmbe );
          for (Event_Breaks__c evb1 : blokslistexistmbe ) {
            listvalsmbe += evb1.Break_Start_Time__c + '-' + evb1.Break_End_Time__c + ',';
          }
          system.debug('-----------------blocklist--------------' + listvalsmbe );
          corporateScheduleDatesMAP.put(match.MatchLeads_Date__c, exibitorScheduleMAP);
        }

        for (MatchLeads_Days__c matchDate : allEventDates) {
          LIST<bookedSchedule> singleVal = new LIST<bookedSchedule>();
          MAP<String, EventSchedule__c> selectedDateAttendeeScheduleMAP = new MAP<String, EventSchedule__c>();
          MAP<String, EventSchedule__c> selectedDateExhibitorScheduleMAP = new MAP<String, EventSchedule__c>();
          getDataFromUtility = new MAP<Date, LIST<String>>();
          eventTimeSlots = new LIST<String>();

          getDataFromUtility = MM_Utility.giveEventTimingsWithDates(selectedEvent, matchDate.MatchLeads_Date__c);
          eventTimeSlots = getDataFromUtility.get(matchDate.MatchLeads_Date__c);
          selectedDateAttendeeScheduleMAP = attendeeScheduleDatesMAP.get(matchDate.MatchLeads_Date__c);
          selectedDateExhibitorScheduleMAP = corporateScheduleDatesMAP.get(matchDate.MatchLeads_Date__c);

          for (String ss : eventTimeSlots) {
            system.debug( '1 ST SLOT TIME LIST  ' + ss);
            system.debug(ss.substring(0, ss.lastIndexOf('-')).trim() + 'Attendee Having Schedule' + ss + '     ' + exibitorScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim()));
            if (selectedDateAttendeeScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim())) {
              singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), TRUE, FALSE, attendeeScheduleMAP.get(ss.substring(0, ss.lastIndexOf('-')).trim()), ss));
              system.debug('Attendee Having Schedule' + ss.substring(0, ss.lastIndexOf('-')).trim());
            } else if (selectedDateExhibitorScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim())) {
              system.debug('1111111111111111111' + ss.substring(0, ss.lastIndexOf('-')).trim());
              singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), FALSE, TRUE, exibitorScheduleMAP.get(ss.substring(0, ss.lastIndexOf('-')).trim()), ss));
              system.debug('BoothAdmin Having Schedule' + ss.substring(0, ss.lastIndexOf('-')).trim());
            } else {
              singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), FALSE, FALSE,  new EventSchedule__c(), ss ) );
              system.debug('No Schedule');
            }
          }
          toDisplayValues.add(new InnerClass(matchDate.MatchLeads_Date__c, singleVal));
          system.debug( '2 ND SLOT TIME LIST  ' + toDisplayValues);
        }
      }// End Of FirstDay Event Schedule

      boothAdminSchedules = new LIST<EventSchedule__c>();
      attendeeSchedule = new LIST<EventSchedule__c>();
      attendeeScheduleMAP = new MAP<String, EventSchedule__c>();
      exibitorScheduleMAP = new MAP<String, EventSchedule__c>();
      //START Of 2nd day Event Schedule
      if (scheduleEvent.MM_Secondaday_startTime__c != null && scheduleEvent.MM_End_Date__c != null && scheduleEvent.MM_Secondaday_EndTime__c != null && scheduleEvent.MM_Slot_Timeperiod__c != null ) {
        if (scheduleEvent.BreakTime_Between_Appointments__c == null) {
          scheduleEvent.BreakTime_Between_Appointments__c = '0';
        }
        attendeeSchedule = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                            MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c WHERE EV_id__c = : selectedEvent AND MM_To_EAM__c = : eamId AND Is_Matchmaking__c = TRUE AND MM_slot_Date__c = : scheduleEvent.MM_End_Date__c ];
        for (EventSchedule__c es : attendeeSchedule) {
          attendeeScheduleMAP.put(es.MM_slot_StartTime__c,  es);
        }
        //Exibitor Booked Times........................................
        boothAdminSchedules = [SELECT ID, NAME, MM_To_EAM__c, EV_id__c, Is_Matchmaking__c, MM_slot_Date__c, MM_Slot_Status__c, MM_slot_StartTime__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_UPE__r.BoothAdmin_id__r.Name,
                               MM_Slot_End_Time__c, MM_To_UPE__c FROM EventSchedule__c
                               WHERE EV_id__c = : selectedEvent AND MM_To_UPE__r.id IN: upidsnew AND Is_Matchmaking__c = TRUE AND MM_slot_Date__c = : scheduleEvent.MM_End_Date__c];
        system.debug(':::::::::::::::::::::upidsnew ::::::::::::::::::;' + upidsnew );
        for (EventSchedule__c es : boothAdminSchedules) {
          exibitorScheduleMAP.put(es.MM_slot_StartTime__c,  es);
        }
        LIST<bookedSchedule> singleVal = new LIST<bookedSchedule>();
        for (String ss : MM_Utility.givesSlotTimings(scheduleEvent.MM_Firstaday_startTime__c, scheduleEvent.MM_Firstaday_EndTime__c , scheduleEvent.MM_Slot_Timeperiod__c , scheduleEvent.BreakTime_Between_Appointments__c  )) {
          if (attendeeScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim())) {
            singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), TRUE, FALSE, attendeeScheduleMAP.get(ss.substring(0, ss.lastIndexOf('-')).trim()), ss));
          } else if (exibitorScheduleMAP.containsKey(ss.substring(0, ss.lastIndexOf('-')).trim())) {
            singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), FALSE, TRUE, exibitorScheduleMAP.get(ss.substring(0, ss.lastIndexOf('-')).trim()), ss));
          } else {
            singleVal.add(new bookedSchedule(ss.substring(0, ss.lastIndexOf('-')).trim(), FALSE, FALSE,  new EventSchedule__c(), ss ) );
          }
        }
      } //End of 2nd day Event Schedule
      viewScheduleBool = TRUE;
      eventTypeBool = FALSE;

    } else {
      viewScheduleBool = TRUE;
      eventTypeBool = TRUE;
    }
  }


  public PageReference schedules() {
    Event_Attendee_Mapping__c EAMid = new Event_Attendee_Mapping__c();
    EAMId = [SELECT id from Event_Attendee_Mapping__c where id = : scheduleProfileId ];
    scheduledate =  apexpages.currentpage().getparameters().get('scheduleDate');
    List<EventSchedule__c> escdulewe = new List<EventSchedule__c>();
    escdulewe = [select id, MM_To_EAM__c, MM_To_UPE__c from EventSchedule__c where MM_To_UPE__r.id IN: upidsnew  and MM_To_EAM__r.id = : EAMid.id and EV_id__c = :selectedEvent and (MM_Slot_Status__c != 'cancelled' AND MM_Slot_Status__c != 'Rejected' AND MM_Slot_Status__c != 'Missed') and (MM_slot_StartTime__c != null and MM_Slot_End_Time__c != null)];
    if (escdulewe.size() <= 0) {
      system.debug(escdulewe.size() + '444444444444  ' + escdulewe );
      String scheduleTime =  apexpages.currentpage().getparameters().get('scheduleTime');
      system.debug('    AAAAAAAAAAAAAAAAAAAAA  ' + scheduleTime);
      ScheduleDate =  apexpages.currentpage().getparameters().get('scheduleDate');

      LIST<String> timings = new LIST<String>();
      timings.addAll((scheduleTime).split('-'));
      schedulestartTime = timings[0];
      scheduleendTime = timings[1];
      comments = '';
      viewScheduleBool = False;
      dispaySuccessPopup = true;
    } else {
      viewScheduleBool = False;
      dispaySuccessPopup21 = true;
    }
    return null;
  }

//Inserting Schedule Record to DataBase
    public boolean errormsg {get ; set ;}
  public pagereference makeSchedule(){
        
       try{
        EventSchedule__c es = new EventSchedule__c();
         
        es.EV_id__c = selectedEvent;
        es.Is_Matchmaking__c = TRUE;
        es.MM_slot_Date__c = Date.valueOf(scheduledate);
        es.MM_slot_StartTime__c = schedulestartTime ;
        es.MM_Slot_End_Time__c =  scheduleendTime;
        es.MM_To_EAM__c = scheduleProfileId;
        if(upe_map.containsKey(selectedEvent) ){
            es.MM_To_UPE__c = upe_map.get(selectedEvent).id;
        if(comments!=null && comments!=''){
             es.Comments__c= comments;
    
        }
        
        if(upe_map.get(selectedEvent).EV_id__r.MatchMaking_Type__c != 'Open' && upe_map.get(selectedEvent).EV_id__r.MatchMaking_Type__c != 'Closed'){
          es.MM_Slot_Status__c= 'Pending';
        }else{
            es.MM_Slot_Status__c= 'Accepted';
        }}
        
        es.MBE_Corp_Combination__c = scheduleProfileId+'-'+upe_map.get(selectedEvent).id+'-'+es.MM_Slot_Status__c;
        es.MBE_Timeslot__c = scheduleProfileId+'-'+Date.valueOf(scheduledate)+'-'+schedulestartTime +es.MM_Slot_Status__c;
        es.UPE_Timeslot__c = upe_map.get(selectedEvent).id+'-'+Date.valueOf(scheduledate)+'-'+schedulestartTime +es.MM_Slot_Status__c;
        Database.insert(es);
        dispaySuccessPopup21 =false;
        dispaySuccessPopup = false;
        
       }catch(Exception ex){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'why not working here?'+ex));
        errormsg = true; 
        return null;
       }
       return null; 
    }

  public void CloseSuccessPopup21() {
    viewScheduleBool = False;
    dispaySuccessPopup21 = false;
  }

  public PageReference CloseSuccessPopup() {
    dispaySuccessPopup = false;
    return null;
  }

  public void cancel() {
    viewScheduleBool = FALSE;
    vieProfileBool = FALSE;
  }

  public PageReference ClearAll() {
    BAkeywords = null;
    attName = null;
    companyName = null;
    NaicsCode1 = null; NaicsCode2 = null;   NaicsCode3 = null;
    Selectedcommodities = new string[] {};
    Commodity1 = null; Commodity2 = null; Commodity3 = null; Commodity4 = null;
    Commodity5 = null;    Commodity6 = null;    Commodity7 = null;    Commodity8 = null;
    Commodity9 = null;
    SelectedBusinessTypes = new String[] {};
    GSASchedule = null;
    SelectedRevenueAmount = new String[] {};
    SelectedRevenueRangeAmount = new String[] {};
    SelectednoOfEmployees = new String[] {};
    Selectedstatess = new String[] {};
    SelectedcompanyCertificationss = new String[] {};
    Selectedprimarybusinesscategories = new String[] {};
    SelectedyearsOfbusiness = new String[] {};
    hasprevAcc= false;
    phoneArea = null;
    Startcount = 0;
    Endcount = countRec;
    StartRecAcc = 1;
    seachEventWiseAttendees();
    return null;
  }
  public void cancelAll() {
    viewScheduleBool = FALSE;
    vieProfileBool = FALSE;
    dispaySuccessPopup = False;
  }

// For fetching the next set of records
  Public void getNextAcc() {
    Startcount = Endcount;
    StartRecAcc = Startcount + 1;
    Endcount += countRec ;
    hasPrevAcc = true;
    if (isCustomevent)
      searchCustomEventAttendees();
    else
      SearchAttendees();
  }

  // For Fetching the previous set of Accounts
  Public void getPrevAcc() {
    if (Endcount == Totalcount) {
      Decimal tempDec = Math.mod(Totalcount, countRec);
      Endcount = tempDec == 0 ? Totalcount : integer.valueOf(Totalcount - tempDec);
    } else {
      Endcount -= countRec;
    }
    Startcount = (Endcount - countRec);
    StartRecAcc = Startcount + 1;
    if (Startcount == 0)
      hasPrevAcc = false;
    hasNextAcc = true;
    if (isCustomevent)
      searchCustomEventAttendees();
    else
      SearchAttendees();
  }

  public class bookedSchedule {
    public String timeSlot {get; set;}
    public String actualSlot {get; set;}
    public Boolean attendeeBooked {get; set;}
    public Boolean exibitorBooked {get; set;}
    public EventSchedule__c es {get; set;}
    public bookedSchedule(String Slot, Boolean attb, Boolean exib, EventSchedule__c e, String act) {
      timeSlot = slot;
      attendeeBooked = attb;
      es = e;
      exibitorBooked = exib;
      actualSlot = act;
    }
  }

  public class InnerClass {
    public Date scheduledate {get; set;}
    public LIST<bookedSchedule> schedules {get; set;}
    public InnerClass(Date d, LIST<bookedSchedule> sch ) {
      scheduledate =  d;
      schedules = sch;
    }
  }

  public class innerEAM {
    public Event_Attendee_Mapping__c eam {get; set;}
    public String whereItFrom {get; set;}
    public innerEAM(Event_Attendee_Mapping__c e, String s) {
      eam = e;
      whereItFrom = s;
    }
  }

  public class innerEAMColums {
    public LIST<innerEAM> innerEAMs {get; set;}
    public innerEAMColums(LIST<innerEAM> lieam) {
      innerEAMs = lieam;
    }
  }

  public Pagereference CheckUser() {
    Pagereference pg = MM_Utility.checkLogInservice();
    return pg;
  }

  public PageReference PrintViewProfile() {
    system.debug('iiiiiiiiiiiiiii' + attendeeNaics.id);
    PageReference pg = new pagereference('/apex/mm_MBE_Details?id=' + mdeid);
    pg.setRedirect(true);
    return pg;
  }

  public PageReference SurveyQuestions() {
    pagereference page1 = new pagereference('/apex/MM_SurveyQuetions1');
    page1.setredirect(true);
    return page1;
  }
}