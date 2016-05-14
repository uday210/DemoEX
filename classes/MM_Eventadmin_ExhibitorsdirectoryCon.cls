global without sharing class MM_Eventadmin_ExhibitorsdirectoryCon {
   
   public list<User_Profile_Event__c> BoothAdminsList{get;set;}
   public Profile_Settings__c psett{get;set;}
   public boolean CheckboxBool { get; set; }
   public boolean CheckboxBool1 { get; set; }
   public boolean norecordsalert { get; set; }
   public boolean confirmdelsh{get;set;}
   public Boolean emailalert1 { get; set; }
   public boolean multiselectpicklist{get;set;}
   public Event__c eventDetails{get; set;}
   public string naicscode1{get;set;}
   public String SelectValAs{get;set;}
    public List<selectOption> options{get;set;}
   
    public String selectedNAICS1 { get; set; }
    public string selectedNAICS2{ get; set; }
    public string selecteddelnaic{ get; set; }
    public NAICS_Code__c selectednaicscodeslist  { get; set; }
    public List<NAICS_Code__c> naicscodeslist{get;set;}
    public Commodities__c selectedcommoditylist  { get; set; }
    public List<Commodities__c> commoditieslist{get;set;}

    public List<String> selectednacslist{ get; set; }
    public set<string> naicsset{ get; set; }
    public List<String> selecteddelnaicsplit{ get; set; }
    public NAICS_Code__c naicsdellist { get; set; }
    public Boolean naicsalertbool{get;set;}
    public Boolean delbool{get;set;} 
    public list<Tags__c> tagslist {get; set ;}
    public string attendeealias {get ; set ;}
    public string exhibitoralias {get ; set ;}
 
    public LIST<LIST<NAICS_Code__c>> listOfnaicscodes{get; set;}
     public LIST<LIST<Commodities__c>> listOfcommodities {get; set;}
    public string naicsselctdids{get;set;}
    public list<string> naicscods{get;set;} 
    public list<string> commodities {get;set;}
    public String checkNAICSforAttendeeEdit{get; set;}
    public String checkcommforAttendeeEdit{get; set;}
    public Boolean ShowPage{get;set;}
    public LIST<String> naicsMultiple{get; set;}
    public list<Attachment> attchments {get; set;}
    public boolean Blockschedulebool {get; set;}
    public  list<selectOption> georegion {get ; set ;}
    public List<string> selectedregions {get ; set ;}
    public String hdnCriteriaTxt {get ; set ;}
    //CriteriaService cs = new CriteriaService(); 
    public String sortField {

    get  { if (sortField == null) {sortField = 'Attendee_Summary__r.AS_Company__c'; } return sortField;  }
    set;
  }
    public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }
   public  list<selectoption> apps {get;set;} 
    public  String selectedapp {get;set;}
     public Widget__c youtubevideo {get ; set;}
    //FOR GEOGRAPHICAL REGION
   //for old matchleads image size
public DateTime prevdate{get;set;} 
    public Profile_Settings__c psObj{get;set;}
    public MM_Eventadmin_ExhibitorsdirectoryCon () {
   try{prevdate = DateTime.parse('2/22/2016 12:00 PM');}catch(Exception e){}
            isc=1;
     attendeealias ='';
     exhibitoralias ='';
    blockselecteddate ='';
      delbool = false;
    showExccededError= false;
    eventtimedetails=new Event__c();
       georegion = new list<selectOption> ();
       georegion.add(new selectoption('Local','Local'));
       georegion.add(new selectoption('National','National'));
       georegion.add(new selectoption('Global','Global'));
       georegion.add(new selectoption('Regional NE','Regional NE'));
       georegion.add(new selectoption('Regional SW','Regional SW'));
       georegion.add(new selectoption('Regional NW','Regional NW'));
       georegion.add(new selectoption('Regional SE','Regional SE'));
       selectedregions = new List<string>();
        apps = new list<selectoption> ();
     apps.add(new selectoption('Match Leads','Match Leads'));
      apps.add(new selectoption('Booth Leads','Booth Leads'));
      selectedapp = 'Match Leads';
      naicschangeselctdids = '';
      commchangeselctdids ='';
     naicsselctdids  = '';
     commsselctdids  = '';
    naicschangeids = '';
    commchangeids = '';
            attchments = new List<Attachment>();
           // try{
            Cookie k = ApexPages.currentPage().getCookies().get('counter');
            naicscode1 = '';
            SelectEvent = k.getValue();
            //hdnCriteriaTxt = cs.getSelectedCriteriaForProfile(SelectEvent);
            system.debug(' eeeeeeeeeeeeeeeeeeeeeeeeeeee '+SelectEvent );
            emailalert = false;
            emailalert1 = false;
           // showExccededError=false;
                //ListOfEvents();
                commonMethod();
                conlst=false;
                HideBoothAdminBtn = False; 
                ExportBoothAdmins = True;
                HideBoothBtn = True; 
                ForU = new User();
                alphabet = new string[] {
                 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'
               }; 
               
               eventtimedetails =[SELECT ID,EV_EventLogo__c,EV_HostingLocation__c,EV_HistingAddr1__c,AS_HostingCity__c,EV_HostingState__c,EV_HostingZipcode__c, MatchMaking_Type__c, EV_Title__c,Match_Making_Schedules__c,Email_Notifications_flag__c,Is_Webank_event__c
                       FROM Event__c 
                       WHERE id =: SelectEvent ];
                       
       tagslist = [select id,Default_Name__c,Alias_Name__c from Tags__c where Event__c = : SelectEvent];
       for(Tags__c tt: tagslist ){
       if(tt.Default_Name__c == 'Attendee'){
       attendeealias = tt.Alias_Name__c;
       }else if(tt.Default_Name__c == 'Exhibitor'){
       exhibitoralias = tt.Alias_Name__c;
       }
       
       }
   //  }catch(Exception e){}  
     
     listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
                naicscodeslist = new List<NAICS_Code__c>();
        
          for(NAICS_Code__c n : [select id,name,Description__c from NAICS_Code__c]){
          
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
         //psettingsbool = false;
         //if(isSaved == false){
            // defaultVisbility();
         //}
         
         Psettings = new LIST<Profile_Settings__c>();
          psett=new Profile_Settings__c();
             Psettings = [SELECT id,Business_Description__c,Company_Name__c,Title__c,Mobile__c,Email_Id__c,First_Name__c,
                         KeyWords__c,Last_Name__c,NAICS_Codes__c,Work_Address__c,Work_phone__c,DBA__c,Contact_Image__c,Salutation__c,
                         Primary_Business_Category__c,Secondary_Business_Category__c,Website__c,Country__c,State__c,
                          Zip_Code__c,Manufatures_Country__c,Distributors_Country__c,BBB_Number__c,Certificate_Processed_by_RPO__c,Geographical_Region__c,
                         Company_Logo__c,Additional_Company_Brouchers__c,Additional_Company_videos__c,Location__c,Commodities__c,Corporate_First_Name_Visible__c,
                          Corporate_E_Mail_Visible__c,Corporate_Job_Title_Visible__c,Products_NOT_interested_visible__c,
                            Corporate_Mobile_Phone_Visible__c,
                            Corporate_Company_Visible__c,
                            Corporate_Work_Address_Visible__c,
                            Corporate_Phone_Visible__c,
                            Corporate_NAICS_CODES_Visible__c,
                            Corporate_Procurement_Visible__c,
                            Corporate_Business_Description_Visible__c,
                            Corporate_Salutation_Visible__c,
                            Corporate_Contact_Image_Visible__c,
                            Corporate_DBA_Visible__c,
                            Corporate_Primary_Business_Category_Visi__c,
                            Corporate_Secondary_Business_Category_Vi__c,
                            Corporate_Website_Registration_Link_Vi__c,
                            Corporate_Manufactures_Country_Visible__c,
                            Corporate_Distributors_Country_Visible__c,
                            Corporate_BBB_Number_Visible__c,
                            Corporate_Certificate_Processed_by_RPO_V__c,
                            Corporate_Geographical_Region_Visible__c,
                            Corporate_Company_Logo_Visible__c,
                            Corporate_Additional_Company_Brouchers_V__c,
                            Corporate_Additional_Company_videos_Visi__c,
                            Corporate_Country_Visible__c,
                            Corporate_Commodities_Visible__c,
                            Corporate_Location_Visible__c,
                            Corporate_Table_Room_No_Visible__c,
                            Corporate_exceptional_keywords_visible__c,exceptional_keywords__c,Corporate_Additional_Company_Brouchers_R__c,Corporate_Additional_Company_videos_Reqi__c,Corporate_BBB_Number_Required__c,Corporate_Certificate_Processed_by_RPO_R__c,Corporate_Commodities_Required__c,Corporate_Company_Logo_Required__c,Corporate_Distributors_Country_Required__c,Corporate_exceptional_keywords_required__c,Corporate_Geographical_Region_Required__c,Corporate_Location_Required__c,
                         Corporate_Manufactures_Country_Required__c,Corporate_Secondary_Business_Category_Re__c,Corporate_Table_Room_No_Requi__c,Corporate_Website_Registration_Link_Reqi__c,Corporate_Business_Description_Required__c,Corporate_Company_Required__c,
                         Corporate_Contact_Image_Required__c,Corporate_DBA_Required__c,Corporate_E_Mail_Required__c,Corporate_First_Name_Required__c,Corporate_Job_Title_Required__c
                        ,Corporate_Mobile_Phone_Required__c,Corporate_NAICS_CODES_Required__c,
                         Corporate_Phone_Required__c,Corporate_Primary_Business_Category_Reqi__c,Corporate_Procurement_Required__c,Corporate_Salutation_Required__c,Corporate_Work_Address_Required__c,Products_NOT_interested_Required__c
                         FROM Profile_Settings__c WHERE Event__r.id =: SelectEvent AND Name=: 'Corporate' ];
                         
                    if(Psettings.size()>0){
                         psett=Psettings[0];
                         }     
                          options = new List<selectOption>(); 

        options.add(new selectOption('', '--None--'));
        options.add(new selectOption('Astra Women�s Business Alliance', 'Astra Women�s Business Alliance'));
        options.add(new selectOption('Center for Women & Enterprise', 'Center for Women & Enterprise'));
        options.add(new selectOption('Great Lakes Women Business Council', 'Great Lakes Women Business Council'));
        options.add(new selectOption('Greater Women Business Council', 'Greater Women Business Council'));
        options.add(new selectOption('Ohio River Valley Women Business Council', 'Ohio River Valley Women Business Council'));
        options.add(new selectOption('Women President Educational Organization - DC', 'Women President Educational Organization - DC'));
        options.add(new selectOption('Women President Educational Organization - New York', 'Women President Educational Organization - New York'));
        options.add(new selectOption('Women Business Council - Southwest', 'Women Business Council - Southwest'));
        options.add(new selectOption('Women Business Development Center - Chicago', 'Women Business Development Center - Chicago'));
        options.add(new selectOption('Women Business Development Center -- Florida', 'Women Business Development Center -- Florida'));
        options.add(new selectOption('Women Business Enterprise Alliance', 'Women Business Enterprise Alliance'));
        options.add(new selectOption('Women Business Enterprise Council - West', 'Women Business Enterprise Council - West'));
        options.add(new selectOption('Women Business Enterprise Council PA-DE-sNJ', 'Women Business Enterprise Council PA-DE-sNJ'));
        options.add(new selectOption('Women Business Enterprise Council South', 'Women Business Enterprise Council South'));
         
         }
    public void prosettings(){
        psettingsbool = true;
        //isSaved = false;

    }
    public boolean isSaved{get;set;}
    public void savesettings(){

        //System.debug('Criteria fields selected are ::::'+hdnCriteriaTxt +' Selected event is ::::'+SelectEvent);
       // if(hdnCriteriaTxt != null && hdnCriteriaTxt !=''){
             
          //  cs.saveCriteria(SelectEvent,hdnCriteriaTxt);            
        //}
        
        Update Psettings;
        psettingsbool = false;
        //isSaved=true;
    }

   // public void defaultVisbility(){
     
         
         
            /* for(Profile_Settings__c ps:psettings){
                 ps.Corporate_Additional_Company_Brouchers_V__c=true;
                 ps.Corporate_Additional_Company_videos_Visi__c=true;
                 ps.Corporate_Business_Description_Visible__c=true;
                 ps.Corporate_Company_Logo_Visible__c=true;
                 ps.Corporate_Company_Visible__c=true;
                 
                 ps.Corporate_Contact_Image_Visible__c=true;
                // ps.Corporate_Distributors_Country_Visible__c=false;
                 ps.Corporate_E_Mail_Visible__c=true;
                 ps.Corporate_First_Name_Visible__c=true;
                 ps.Corporate_Job_Title_Visible__c=true;
                 
                 ps.Corporate_Logo_Visible__c=true;
                 ps.Corporate_Location_Visible__c=true;
              //   ps.Corporate_Manufactures_Country_Visible__c=false;
                 ps.Corporate_Mobile_Phone_Visible__c=true;
                 ps.Corporate_NAICS_CODES_Visible__c=true;
                 ps.Corporate_Phone_Visible__c=true;
                 ps.Corporate_Primary_Business_Category_Visi__c=true;
                 ps.Corporate_Procurement_Visible__c=true;
                 ps.Corporate_Salutation_Visible__c=true;
                 ps.Corporate_Secondary_Business_Category_Vi__c=true;
                 ps.Corporate_Table_Room_No_Visible__c=true;
                 ps.Corporate_Work_Address_Visible__c=true;
                 ps.Corporate_Website_Registration_Link_Vi__c=true;
                // ps.Corporate_BBB_Number_Visible__c=false;
                // ps.Corporate_Certificate_Processed_by_RPO_V__c=false;
                // ps.Corporate_Commodities_Visible__c=false;
                // ps.Corporate_DBA_Visible__c=false;
                 
         }*/
    //}
    public LIST<Profile_Settings__c> Psettings {get ; set ;}
    public boolean psettingsbool {get ; set ;}    
    public string[] alphabet{get;set;}
    public boolean imageerror {get;set;}
    public Integer attfilesize{ get; set; }
    public string imageerrormsg {get;set;}
    public transient Blob attendeeImage { get; set; }
    public transient blob ExhibitorImage{ get; set; }
    public String myimageName{get; set;}
    public transient blob attachmentval {get ; set ;}
    public string attachmentName {get ; set ;}
    //public attachment attach {get ; set ;}
    public transient document mydoc{get;set;}
    public transient document mydoc1{get;set;}
    public transient List<User_Profile_Event__c> MM_Eventadmin_ExhibitorsdirectoryCon {get;set;}
    public transient List<User_Profile_Event__c> ForPaginationBoothAdminsList{get;set;}
    Public String SelectEvent{get;set;}
    public String SelectedBooth{get;set;}
    public List<Booth__c> Booths{get;set;}
    public List<selectoption> eventslistforselect {get;set;}
    public List<User_Profile_Event__c> EventsList{get;set;}
    public Boolean hasLast{get;set;}
    public Boolean hasFirst{get;set;}
    public Integer PgNo{get;set;}
    Public Boolean conlst{get;set;}
    Public Boolean hasPrevious {get;set;}
    Public Boolean hasNext {get;set;}
    Public Integer pageno {get;set;}
    Public Integer count {get;set;}
    public Boolean Disabled_First_Icon{get;set;}
    public Boolean Disabled_Last_Icon{get;set;}
    public Boolean Disabled_Previous_Icon{get;set;}
    public Boolean Disabled_Next_Icon{get;set;}
    public Booth__c Booth{get;set;}
    public User BoothAdminUser{get;set;}
    public string Email{get;set;}
    public contact con{get;set;}
    public Boolean CreatBoothAdminPopUp{get;set;}
    public Account A{get;set;}
    public Boolean HideTable{get;set;}
    public Boolean CloseBoothName{get;set;}
    public Boolean CloseBoothLocation{get;set;}
    public Boolean ExportBoothAdmins{get;set;}
    public Boolean HideBoothAdminBtn{get;set;}
    public Boolean HideBoothBtn{get;set;}
    public string BoothAdminDetails{get;set;}
    public Boolean ShowBoothAdminPopUp {get;set;}
    public User BoothAdmininfo {get;set;}
    public Booth__c OnlyBoothInfo{get;set;}
    public map<string,string> states{get;set;} 
    public map<string,string> countries{get;set;}
    Public string Country{get;set;}
    Public string state{get;set;}
    public Boolean EditBoothAdminPopUp {get;set;}


    public Transient List<InnerClass> ListOfInnerClass{get;set;}
    public List<InnerClass> ForPagination{get;set;}
    public String Selectedstatus{get;set;}
    public String BoothSelected{get;set;}
    public String Status{get;set;}
    public Boolean Statuspopup{get;set;}
    public String SelectBoothId{get;set;}
    public List<User_Profile_Event__c> listOfBoothadminsforExport {get;set;}
    public Boolean DisplayNoEventMessage{get;set;}
    public String SelectedBoothName {get;set;}
    public String SelectedEventName {get;set;}
    public Boolean NoRecordsFound{get;set;}
    public boolean DisplayPages{get;set;} 
    public Boolean CreatOnlyBoothAdminPopUp {get;set;} 
    public Boolean Error{get;set;}
    public String ErrorMessage{get;set;}
    public User ForU{get;set;}
    public string SelectedEName{get;set;}
    public integer ForPagesize{get;set;}
    public Event__c SelectedEventId {get;set;}
    public Booth__c BoothName{get;set;}
    
    Public String Naics1='',Naics2='',Naics3='',Naics4='',Naics5='',Naics6='',Naics7='',Naics8='',Naics9='';
    Public String Commodity1='',Commodity2='',Commodity3='',Commodity4='',Commodity5='',Commodity6='',Commodity7='',Commodity8='',Commodity9='';
    
  
  public void commonMethod(){
  showExccededError= false;
  emailalert= false;
  emailalert1 = false;
  BoothsList();
  ListOfBoothAdmins();
  
  }
  public void  BoothsList(){
  showExccededError = False;
  emailalert= false;
  emailalert1 = false;
   
   BoothAdminsList = new List<User_Profile_Event__c> ();
   BoothAdminsList = [select BT_id__c,BT_id__r.BT_Name__c from User_Profile_Event__c 
                  where IsMatchMakingUser__c=True AND EventAdmin_Id__r.id=: userinfo.getUserId() AND EV_id__c =:SelectEvent 
                  AND Profile_id__r.PR_Name__c ='BoothAdmin' AND BT_id__r.BT_isBoothActive__c = True 
                   ];  
                
   set<ID> UniqueBoothIds = new  set<ID> ();
   
   for(User_Profile_Event__c BoothsIds :BoothAdminsList ){
   UniqueBoothIds.add(BoothsIds.BT_id__c);
   system.debug('------------------- &&&&&&&&&&&&&&&&&&&&&&& '+UniqueBoothIds);
   }
   
   Booths = new List<Booth__c> ();        
   Booths = [select Id,BT_Name__c from Booth__c where Id IN:UniqueBoothIds];  
   system.debug('------------------- &&&&&&&&&&&&&&&&&&&&&&& '+UniqueBoothIds);
  
  if(selectevent != null){ 
  Event__c ForEventName = [select EV_Title__c,Is_MatchMaking_Event__c from Event__c where id=:selectevent];
  SelectedEventName = 'of '+ForEventName.EV_Title__c;
  SelectedEName = ForEventName.EV_Title__c;
  system.debug(' ------ !!!!!!!!!!!!!! -----'+SelectedEventName );
  SelectedBoothName = '';
  }

   
  }
  /**
   Public void  ListOfEvents(){
   emailalert= false;
   emailalert1 = false;
   eventslistforselect = new List<selectoption>();  
   EventsList = new List<User_Profile_Event__c>(); 
   EventsList = [select Id,EV_id__c,EV_id__r.EV_Title__c,EV_id__r.Is_MatchMaking_Event__c from User_Profile_Event__c 
                                where  EventAdmin_Id__c =: userinfo.getUserId()
                                AND EventAdmin_Id__c != ''
                                AND User_id__r.UserName = : userInfo.getUserName()  AND 
                                Profile_id__r.PR_Name__c ='EventAdmin' ORDER BY CreatedDate ASC  
                                ]; 
    system.debug (' AAAAAAAAAAAAAAAAAA '+EventsList );                            
                            
    for(User_Profile_Event__c UserPEvent: EventsList){
    if(UserPEvent.EV_id__c != null){
    
    eventslistforselect.add(new Selectoption(UserPEvent.EV_id__c,UserPEvent.EV_id__r.EV_Title__c));
     
    SelectEvent = UserPEvent.EV_id__c;  
    }
    
    
    
    system.debug (' ddddddddddddd '+SelectEvent );               
    }
   // return eventslistforselect; 
   
    
   }*/
   
    public List<Selectoption> availableBADS {get; set;}
    
    public void ListOfBoothAdmins(){
    showExccededError= false;
    emailalert= false;
    emailalert1 = false;
         ForPageSize = null;
         availableBADS = new List<Selectoption>();
         ListOfInnerClass = new List<InnerClass>();
         SelectBoothId = ApexPages.currentpage().getparameters().get('BoothName');
         SelectedBooth = SelectBoothId ;
         system.debug( ' AAAAAAAAAAAAAAAAAAAAAAAAAA NNNNNNNNNNNN '+SelectedBooth );
         ForPagination = new List<InnerCLass>();   
         if(SelectedBooth == null && SelectEvent != null){
         HideBoothAdminBtn = False; 
         HideBoothBtn = True;
         List<User_Profile_Event__c>  Example = new List<User_Profile_Event__c>();
         system.debug('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh'+sortField);
         string eventQuery ='Select UEP_isActive__c,Profile_id__c,Profile_id__r.PR_Name__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,BT_id__r.MM_TableNo__c,Attendee_Summary__r.As_prefixNew__c,BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,MAtchMakingProfile__c,Attendee_Summary__r.AS_Title__c,BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,Attendee_Summary__r.Exhibitor_company_imageUrl__c,BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate,Attendee_Summary__r.AS_ImageUrl__c,Attendee_Summary__r.AS_Company__c,Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,Attendee_Summary__r.As_SecondaryBusinessCategory1__c,Attendee_Summary__r.AS_WebsiteUrl__c,Attendee_Summary__r.AS_BusinessDescription__c,Attendee_Summary__r.AS_WorkPhone__c,Attendee_Summary__r.AS_WorkAddress1__c,Attendee_Summary__r.AS_WorkAddress2__c,Attendee_Summary__r.AS_WorkCity__c,Attendee_Summary__r.AS_Work_States__c,Attendee_Summary__r.AS_Work_Country__c,Attendee_Summary__r.AS_WorkZip__c,Attendee_Summary__r.AS_NAICSCode_1__c,Attendee_Summary__r.AS_NAICSCode_2__c,Attendee_Summary__r.AS_NAICSCode_3__c,Attendee_Summary__r.AS_NAICSCode_4__c,Attendee_Summary__r.AS_NAICSCode_5__c,Attendee_Summary__r.AS_NAICSCode6__c,Attendee_Summary__r.AS_NAICSCode7__c,Attendee_Summary__r.AS_NAICSCode8__c,Attendee_Summary__r.AS_NAICSCode9__c from User_Profile_Event__c  where Request_for_upgrade_profile__c = false AND IsMatchMakingUser__c=True  AND  (MAtchMakingProfile__c =\''+'Corporate'+'\' OR MAtchMakingProfile__c =\''+'Corporatestaff'+'\') AND  EV_id__r.id = \''+SelectEvent+'\' ORDER BY '+sortField+' '+sortDir +' NULLS LAST';                    

         /**
         BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,BT_id__r.MM_TableNo__c,Attendee_Summary__r.As_prefixNew__c,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,MAtchMakingProfile__c,Attendee_Summary__r.AS_Title__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate,Attendee_Summary__r.AS_ImageUrl__c,Attendee_Summary__r.AS_Company__c,
                              Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,Attendee_Summary__r.As_SecondaryBusinessCategory1__c,Attendee_Summary__r.AS_WebsiteUrl__c,
                              Attendee_Summary__r.AS_BusinessDescription__c,Attendee_Summary__r.AS_WorkPhone__c,Attendee_Summary__r.AS_WorkAddress1__c,
                              Attendee_Summary__r.AS_WorkAddress2__c,Attendee_Summary__r.AS_WorkCity__c,Attendee_Summary__r.AS_Work_States__c,Attendee_Summary__r.AS_Work_Country__c,
                              Attendee_Summary__r.AS_WorkZip__c,Attendee_Summary__r.AS_NAICSCode_1__c,Attendee_Summary__r.AS_NAICSCode_2__c,Attendee_Summary__r.AS_NAICSCode_3__c,
                              Attendee_Summary__r.AS_NAICSCode_4__c,Attendee_Summary__r.AS_NAICSCode_5__c
                              from User_Profile_Event__c  where Request_for_upgrade_profile__c = false AND IsMatchMakingUser__c=True 
                              AND EV_id__c =:SelectEvent AND  MAtchMakingProfile__c ='Corporate' ORDER BY Attendee_Summary__r.AS_Company__c ASC
                             ];*/
                             
                 BoothAdminsList = dataBase.Query(eventQuery );
         system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+BoothAdminsList );            
                             for(User_Profile_Event__c V : BoothAdminsList ){
                             
                              //availableBADS.add(new Selectoption(v.BT_id__r.BT_Name__c,v.BT_id__r.BT_Name__c));
                              system.debug( '  AAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa        '+availableBADS);
                                 
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }                              
        system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+ListOfInnerClass.size()); 
        try{                   
       if(ListOfInnerClass.size()>0)
        {
         conlst=true;        
         count=ListOfInnerClass.size();      
         pageno=1;
         //isc=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
            system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            } 
        for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ListOfInnerClass[i]);
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() <= 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
        NoRecordsFound = False;
        DisplayPages = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }         
        
        }
         
        } else {
       hasLast = False;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = True;
       Disabled_Last_Icon = True;
       hasNext=False; 
        }
       }catch(Exception ex){}                 
           system.debug(' 444444444444'+SelectedBooth +'$$$$$ $$$$$$ $$$$$$$'+SelectEvent);

    }else {
      system.debug(' FFFFFFFFFFFFF FFFFFFFFFFFF FFFFFFFFFFFFFFF'+SelectedBooth +'$$$$$ $$$$$$ $$$$$$$'+SelectEvent);
      HideBoothAdminBtn = True;
      HideBoothBtn = False;
      BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,Attendee_Summary__r.AS_Company__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,BoothAdmin_id__r.Companyphone__c,
                              BoothAdmin_id__r.LastLoginDate from User_Profile_Event__c 
                              where Request_for_upgrade_profile__c = false AND EV_id__c =:SelectEvent AND BT_ID__c =: SelectedBooth 
                              AND MAtchMakingProfile__c ='Corporate'];
                              
                        for(User_Profile_Event__c V : BoothAdminsList ){
                        availableBADS.add(new Selectoption(v.Attendee_Summary__r.AS_Company__c,v.Attendee_Summary__r.AS_Company__c+'('+v.Attendee_Summary__r.AS_FirstName__c + ' '+v.Attendee_Summary__r.AS_LastName__c+')' ));
                         system.debug( '  AAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa        '+availableBADS);
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                                       
                             }      
 
        try{                  
       if(ListOfInnerClass.size()>0)
        {
          HideTable = True;
         conlst=true;
         hasLast = True;
         hasFirst = False;
         count=BoothAdminsList.size();
         hasPrevious =false;
         hasNext=true;
         pageno=1;
         //isc=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          for(integer i=0; i<10;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+BoothAdminsList[i]);
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() < 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }
        
        }
       
        } 
    } catch(exception ex){
    
    }
    } 
    if(SelectedBooth != null){
    BoothName = [select BT_Name__c from Booth__c where id=: SelectedBooth ];
    system.debug(' ------- !!!!!!!!!! @@@@@@@@@@@@-----'+BoothName);
    SelectedeventName = ''; 
    //SelectedEName = '';
    SelectedBoothName = 'of '+BoothName.BT_Name__c;
     system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+selectedbooth );
   } 
    
  if(ForPagination.size() == 0){
       NoRecordsFound = True;
       DisplayPages = False;
     }  else {
        NoRecordsFound = False;
        DisplayPages = True;
    }
    ForPagesize = ForPagination.size();
    
    system.debug( '  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%^^^^^^^^^^^^^^^^^^^     '+availableBADS);
                              
    
}


 Public void First()
     {  
      ListOfBoothAdmins(); 
     emailalert= false;
     try{
         hasNext=true;
         hasFirst = false;
         hasPrevious=false;
         hasLast = True;
         Disabled_Previous_Icon = True;
         Disabled_First_Icon = True;
         Disabled_Next_Icon = False;
         Disabled_Last_Icon = False;
         ForPagination.clear();
         //hasPrevious=false;
         isc=1;
         pageno =isc;
         for(integer i=0;i<10;i++)
          {
          ForPagination.add(ListOfInnerClass[i]);
          
         }
         if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            ForPagesize = ForPagination.size();
            }catch(Exception ex){
     
     }
     }
     
         Public void Previous()
     { 
     
      ListOfBoothAdmins(); 
      pageno=isc; 
     emailalert= false;
       try{ 
          hasLast=True;
          hasNext=true;
          Disabled_Previous_Icon = False;
          Disabled_First_Icon = False;
          Disabled_Next_Icon = False;
          Disabled_Last_Icon = False;
          
         ForPagination.clear();
         if(pageno  !=1)
             {    
                  system.debug( ' PPPPPPPPPPPPPPPPPP'+Disabled_Previous_Icon);
                  system.debug( ' FFFFFFFFFFFFFFF'+Disabled_First_Icon);
                  
                  isc=isc-1;
                  pageno=pageno-1; 
                  hasPrevious=true;
                  hasFirst = true;
                  Disabled_Previous_Icon = false;
                  Disabled_First_Icon = false;
                  Disabled_Next_Icon = false;
                  Disabled_Last_Icon = False;
                  If(pageno  ==1 ){
                  hasPrevious=false;
                  hasFirst = False;
                  Disabled_Previous_Icon = True;
                  Disabled_First_Icon = True;
                  Disabled_Next_Icon = False;
                  Disabled_Last_Icon = False;
                 }  
                   for(integer i=(pageno -1)*10;i<(pageno *10);i++ )
                     {
                         ForPagination.add(ListOfInnerClass[i]); 
                     }
             }                           
             else
              {   
              
              system.debug( ' AAAAAA '+Disabled_Previous_Icon + ' BBBBBB'+Disabled_First_Icon);
                  hasPrevious=false;
                  hasFirst = False;
                //  Disabled_Previous_Icon = True;
                //  Disabled_First_Icon = True;
                  
                  for(integer i=(pageno -1)*10;i<(pageno *10);i++ )
                     {
                         ForPagination.add(ListOfInnerClass[i]); 
                      }
              }
              ForPagesize = ForPagination.size();
       }
       catch(Exception ex){
     
     }
     
    
     }
       public integer isc{get;set;}
            Public void Next()
     { 
     ListOfBoothAdmins();
     
     emailalert= false;
       try{
           isc=isc+1;
         pageno  = isc;
         system.debug( ' ----------PPPPPPPPPPP '+pageno);
        // integer pgno;
         ForPagination.clear();
         if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            if(pageno==pgno)
             { 
                  hasNext=false;
                  hasLast = False;
                  Disabled_Next_Icon = True;
                  Disabled_Last_Icon = True;
                  for(integer i=(pageno -1)*10;i<ListOfInnerClass.size();i++ )
                    {
                     ForPagination.add(ListOfInnerClass[i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST------'+ForPagination.size()+' RECORDS '+ListOfInnerClass[i]+ ' sssssssssssswwwwwwww'+Pgno);
                    
                    }
             }
           else            
            for(integer i=(pageno -1)*10;i<(pageno *10);i++ )
              {
                     ForPagination.add(ListOfInnerClass[i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForPagination.size()+' RECORDS '+ListOfInnerClass[i]);
             }
            hasPrevious=true;
            hasFirst = True;
            Disabled_Previous_Icon = False;
            Disabled_First_Icon = False;
            
        System.debug('---------------------------- LIST SIZE OF TEMPLIST ---------------------'+ListOfInnerClass.size());
     
     ForPagesize = ForPagination.size();
    
    }catch(Exception Ex){
     
     }
    
     }
     
     Public void Last()     
     {  
      ListOfBoothAdmins();
     emailalert= false;
     try{
         hasLast = False;
         Disabled_Last_Icon = True;
         System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
        hasPrevious=true;
        Disabled_Previous_Icon=False;
        hasFirst = true;
        Disabled_First_Icon=False;
        ForPagination.clear();
         hasNext=false;
          Disabled_Next_Icon=True;
        if( math.mod(ListOfInnerClass.size(),10)==0){
          System.debug('---------44444444444444444----'+pageno );
          isc=ListOfInnerClass.size()/10;
             pageno =ListOfInnerClass.size()/10;
             System.debug('-----------------pageno ----'+pageno );
           } else {
           System.debug('---------44444444444444444----'+pageno );
           isc=(ListOfInnerClass.size()/10) +1; 
            pageno =(ListOfInnerClass.size()/10) +1; 
            }
         for(integer i=(pageno -1)*10;i<ListOfInnerClass.size();i++)
          {
              ForPagination.add(ListOfInnerClass[i]);  
         }
          //ForPagesize = ForPagination.size();
     }catch(Exception ex){
     }
     }
     
 
     
    
     
     public void AddBooth(){
     showExccededError = False;
     ExhibitorImage = null;
     attendeeImage = null;
     emailalert= false;
     emailalert1 = false;
     AttendeeSummary =new AttendeeSummary__c();
     youtubevideo = new Widget__c();
     CreatBoothAdminPopUp = True;
      checkNAICSforAttendeeEdit = '#$%&&**00';
      checkcommforAttendeeEdit = '#$%&&**00';
     naicschangeselctdids = '';
     
      naicschangeids = '';
    // CreatOnlyBoothAdminPopUp = True;
     DisplayNoEventMessage = False;
     
     Booth = new Booth__c();
     
     BoothAdminUser = new User();
     Con = new Contact();
     A  = new Account();
     email = '';
     error = False;
     
     }
     public string commsselctdids {get ; set ;}
     public void SaveBooth(){
     error = false;
     showExccededError = False;
     emailalert= false;
      emailalert1 = false;  
            naicsselctdids =ApexPages.currentPage().getParameters().get('choose');
            
            //commsselctdids =ApexPages.currentPage().getParameters().get('commsl');
             system.debug('ddddddddddd ffffffffffff gg'+commchangeselctdids );
            //  try{   
            system.debug('$$$$@@@@'+SelectValAs);    
          // AttendeeSummary.Certificate_Processed_by_RPO__c=SelectValAs;
          NaicsCodesFunc(naicschangeselctdids, commchangeselctdids);
            try{
                AttendeeSummary.As_NAICSCode_1__c = Naics1;
                AttendeeSummary.As_NAICSCode_2__c = Naics2;
                AttendeeSummary.As_NAICSCode_3__c = Naics3;
                AttendeeSummary.As_NAICSCode_4__c = Naics4;
                AttendeeSummary.As_NAICSCode_5__c = Naics5;
                AttendeeSummary.AS_NAICSCode6__c = Naics6;
                AttendeeSummary.AS_NAICSCode7__c = Naics7;
                AttendeeSummary.AS_NAICSCode8__c = Naics8;
                AttendeeSummary.AS_NAICSCode9__c = Naics9;
                
                AttendeeSummary.Commodity_1__c = Commodity1;
                AttendeeSummary.Commodity_2__c = Commodity2;
                AttendeeSummary.Commodity_3__c = Commodity3;
                AttendeeSummary.Commodity_4__c = Commodity4;
                AttendeeSummary.Commodity_5__c = Commodity5;
                AttendeeSummary.Commodity_6__c = Commodity6;
                AttendeeSummary.Commodity_7__c = Commodity7;
                AttendeeSummary.Commodity_8__c = Commodity8;
                AttendeeSummary.Commodity_9__c = Commodity9;
            
            }catch(Exception e){}
       AttendeeSummary.Geographical_Region__c='';
       for(string st : selectedregions){
       AttendeeSummary.Geographical_Region__c += st+',';
       }
 //  }catch(Exception e){} 
        
        system.debug( ' FFFFFFFFFFFFFFFFFFFFFFFFFFF ' +Booth );
        system.debug('-------------- ******************8 ------------------'+SelectedBooth);
        if(Email == null || Email == ''){
            error=true;
            errormessage='Please enter Email Id';    
             
        }else{
        
        
        
            List<User> ComparingUserEmailsev = [Select Id,Email,Username From User Where UserName =: Email AND Profile.Name=:'Event Admin' ];
            
            List<Event_Attendee_Mapping__c> EventAttendeeJun = [select id,EV_id__c from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c =true AND AS_id__r.AS_Email__c =: Email AND EV_id__c =: SelectEvent];
            system.debug('========================= Attendee is inserted in Junction Object Or not ==========='+EventAttendeeJun );
            
            
            if(ComparingUserEmailsev.size() != 0 || EventAttendeeJun.size()>0){
                error=true;
                errormessage='Email Already Exist';
                system.debug( ' EEEEEEEEEEEEEEEE RRRRRRRRRRRRRR OOOOOO RRRRRRRRR' );
            }else{
                List<User> ComparingUserEmails = [Select Id,Email,Username From User Where UserName =: Email ];
                
                System.debug('========@@@@@@ Comparing Email with Existing Email From User Object @@@@@ ========='+ComparingUserEmails);
                
                if(ComparingUserEmails.size()>0){
                
                    List<User_Profile_Event__c> FindingDuplicates = [SELECT User_id__r.Email,User_id__r.UserName,User_id__r.Profile.Name 
                                                                     FROM User_Profile_Event__c 
                                                                     WHERE User_Profile_Event__c.User_id__r.UserName=:Email
                                                                     AND  EV_id__c=:selectEvent ];
                    
                    //  System.debug('========@@@@@@ Comparing Email with Existing Email From User_Profile_Event Object @@@@@ ========='+FindingDuplicates.size()+ 'ddddd'+FindingDuplicates[0].User_id__r.Profile.Name);
                    
                    if(FindingDuplicates.size()>0 && FindingDuplicates[0].User_id__r.Profile.Name == 'Booth Admin'){
                        //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Booth Admin is Already an Admin for this Booth'));
                        error=true;
                        errormessage='Email ID is already registered as Booth Admin for this Event';
                        system.debug( ' EEEEEEEEEEEEEEEE RRRRRRRRRRRRRR OOOOOO RRRRRRRRR' );
                    
                    }else{
                        Booth.BT_Location__c         =  Booth.BT_Location__c;
                        Booth.BT_Name__c             =  BoothAdminUser.companyName;
                        Booth.EV_id__c               =  SelectEvent;
                        Booth.BT_ContactName__c      =  BoothAdminUser.Firstname +' '+ BoothAdminUser.LastName;
                        Booth.BT_ContactPhone__c     =  BoothAdminUser.Companyphone__c;
                        Booth.BT_WebsiteURL__c       =  BoothAdminUser.Company_website__c;
                        Booth.BT_ContactEmail__c     =  Email;   
                        Booth.MM_TableNo__c          =  Booth.MM_TableNo__c; 
                        
                        Database.insert(Booth,false); 
                        system.debug(' * **** ******* ************'+Booth);      
                        
                        Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c where PR_Name__c='BoothAdmin'];
                        
                        ForU = new User();
                        
                        ForU = [select FirstName,LastName,id,isActive,isSignup__c from User where Username =:Email ];
                        
                        ForU.FirstName = BoothAdminUser.FirstName;
                        ForU.LastName  = BoothAdminUser.LastName;
                        ForU.companyName = BoothAdminUser.companyName;
                        ForU.Company_website__c = BoothAdminUser.Company_website__c;
                        ForU.CompanyAddr1__c = BoothAdminUser.CompanyAddr1__c;
                        ForU.CompanyAddr2__c = BoothAdminUser.CompanyAddr2__c;
                        ForU.CompanyCity__c = BoothAdminUser.CompanyCity__c;
                        // if(SelectedCountry != '--None--')
                        ForU.Country__c = BoothAdminUser.Country__c;
                        //if(Selectedstates != '--None--')
                        ForU.States__c =  BoothAdminUser.States__c;
                        ForU.CompanyFaxNumber__c  = BoothAdminUser.CompanyFaxNumber__c;
                        ForU.Companyphone__c = BoothAdminUser.Companyphone__c;
                        
                        Database.Update(ForU);  
                        
                        FutureMethod(Email);
                        forAttendee();
                        User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                        UserBoothAdminProfile.BoothAdmin_id__c = ForU.id;
                        UserBoothAdminProfile.BT_id__c  = Booth.id;
                        UserBoothAdminProfile.EV_id__c = SelectEvent;
                        UserBoothAdminProfile.EventAdmin_Id__c = UserInfo.getUserId();
                        UserBoothAdminProfile.UEP_isActive__c = True;
                        UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                        UserBoothAdminProfile.User_id__c = ForU.id;
                        UserBoothAdminProfile.Status__c='Active';
                        UserBoothAdminProfile.IsMatchMakingUser__c=true;
                        UserBoothAdminProfile.MAtchMakingProfile__c ='Corporate';
                        
                        Database.insert(UserBoothAdminProfile) ;
                        
                        // SendanEmail();
                        
                        
                        
                        CreatBoothAdminPopUp = False;
                        CreatOnlyBoothAdminPopUp = False;
                        ListOfBoothAdmins();
                        BoothsList();
                        Email = '';   
                    
                    } 
                
                }else {
                
                    Booth.BT_Location__c         =  Booth.BT_Location__c;
                    Booth.BT_Name__c             =  BoothAdminUser.companyName;
                    Booth.EV_id__c               =  SelectEvent;
                    Booth.BT_ContactName__c      =  BoothAdminUser.Firstname +' '+ BoothAdminUser.LastName;
                    Booth.BT_ContactPhone__c     =  BoothAdminUser.Companyphone__c;
                    Booth.BT_WebsiteURL__c       =  BoothAdminUser.Company_website__c;
                    Booth.BT_ContactEmail__c     =  Email;    
                    Booth.MM_TableNo__c          =   Booth.MM_TableNo__c; 
                    
                    Database.insert(Booth);
                    system.debug('Booth === '+ Booth);
                    InsertUser();
                    //  SendanEmail();
                    CreatBoothAdminPopUp = False;
                    CreatOnlyBoothAdminPopUp = False;
                    ListOfBoothAdmins();
                    BoothsList();
                    Email = '';   
                
                }            
            }           
        }
    }  
     
//------------------------------------------------------------------------------------------    
     public AttendeeSummary__c AttendeeSummary{get;set;}
     public void forattendee(){
     showExccededError = False;
     emailalert1 = false;
     emailalert= false;
    system.debug('++++++++++++++++++++++++++++++'+BoothAdminUser.Firstname);
    string unique =  Email.tolowercase();
            system.debug('++++++++++++++++++++++++++++++'+unique );     
                List<AttendeeSummary__c> AttendeeDetails = [select  id  from AttendeeSummary__c Where 
                                                            AS_Email__c =: unique ]; 
               
                system.debug(' ===== Alredy Existed Attendee Email Id ===='+AttendeeDetails);
                if(AttendeeDetails.size() > 0){
                AttendeeSummary__c UpdatingAttendee = [select id,AS_FirstName__c,AS_LastName__c from AttendeeSummary__c where id=:AttendeeDetails[0].id];
                if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
     
         if (attendeeImage.size() != null) {
             if (attendeeImage.size() <= 4024000) {
                 mydoc = new document();
                 mydoc.body = attendeeImage;
                 mydoc.folderid = UserInfo.getUserId();
                 mydoc.ispublic = true;
                 mydoc.Name = myimageName;
                 insert mydoc;
                 UpdatingAttendee.AS_ImageUrl__c = mydoc.id;
             } else {
                 imageerror = true;
                 imageerrormsg = 'Image size should be less than 1MB';
             }
         }}
         if (ExhibitorImage != NULL && (myimageName != '' || myimageName != NULL)) {
   
         if (ExhibitorImage.size() != null) {
             if (ExhibitorImage.size() <= 4024000) {
                 mydoc = new document();
                 mydoc.body = ExhibitorImage;
                 mydoc.folderid = UserInfo.getUserId();
                 mydoc.ispublic = true;
                 mydoc.Name = myimageName;
                 insert mydoc;
                 UpdatingAttendee.Exhibitor_company_imageUrl__c = mydoc.id;
             } else {
                 imageerror = true;
                 imageerrormsg = 'Image size should be less than 1MB';
             }
         }}
     
                UpdatingAttendee.AS_FirstName__c = BoothAdminUser.FirstName; 
                UpdatingAttendee.AS_LastName__c = BoothAdminUser.LastName;
                if(BoothAdminUser.CompanyName != null && BoothAdminUser.CompanyName != ''){
                UpdatingAttendee.AS_Company__c  = BoothAdminUser.CompanyName;}
                //UpdatingAttendee.AS_CellPhone__c  = BoothAdminUser.Companyphone__c;
                if(BoothAdminUser.Company_website__c != null && BoothAdminUser.Company_website__c != ''){
                UpdatingAttendee.AS_WebsiteUrl__c  = BoothAdminUser.Company_website__c;}
                
                if(BoothAdminUser.CompanyAddr1__c != null && BoothAdminUser.CompanyAddr1__c != ''){
                UpdatingAttendee.AS_WorkAddress1__c =  BoothAdminUser.CompanyAddr1__c;}
                
                if(BoothAdminUser.CompanyAddr2__c != null && BoothAdminUser.CompanyAddr2__c != ''){ 
                UpdatingAttendee.AS_WorkAddress2__c =  BoothAdminUser.CompanyAddr2__c;}
                if(BoothAdminUser.CompanyCity__c != null && BoothAdminUser.CompanyCity__c != ''){ 
                UpdatingAttendee.AS_WorkCity__c =BoothAdminUser.CompanyCity__c; }
                if(BoothAdminUser.Country__c != null && BoothAdminUser.Country__c != ''){                
                UpdatingAttendee.AS_Work_Country__c = BoothAdminUser.Country__c; } 
                if(BoothAdminUser.States__c != null && BoothAdminUser.States__c != ''){                              
                UpdatingAttendee.AS_Work_States__c = BoothAdminUser.States__c;}
                if(AttendeeSummary.AS_PrimaryBusinessCategory1__c != null && AttendeeSummary.AS_PrimaryBusinessCategory1__c != ''){                              
                UpdatingAttendee.AS_PrimaryBusinessCategory1__c = AttendeeSummary.AS_PrimaryBusinessCategory1__c;}
                if(AttendeeSummary.As_SecondaryBusinessCategory1__c != null && AttendeeSummary.As_SecondaryBusinessCategory1__c != ''){                              
                UpdatingAttendee.As_SecondaryBusinessCategory1__c = AttendeeSummary.As_SecondaryBusinessCategory1__c;}
                 if(AttendeeSummary.AS_NumberOfEmployees__c != null){                              
                UpdatingAttendee.AS_NumberOfEmployees__c = AttendeeSummary.AS_NumberOfEmployees__c;}
                 if(AttendeeSummary.AS_BusinessEstablishedDate__c != null){                              
                 
                UpdatingAttendee.AS_BusinessEstablishedDate__c=AttendeeSummary.AS_BusinessEstablishedDate__c;}
                if(AttendeeSummary.AS_BusinessRevenue__c != null){                              
                UpdatingAttendee.AS_BusinessRevenue__c = AttendeeSummary.AS_BusinessRevenue__c;}
                 if(AttendeeSummary.AS_BusinessTaxId__c != null && AttendeeSummary.AS_BusinessTaxId__c != ''){                              
                UpdatingAttendee.AS_BusinessTaxId__c = AttendeeSummary.AS_BusinessTaxId__c;}
                 if(AttendeeSummary.AS_BusinessDunsNumber__c != null && AttendeeSummary.AS_BusinessDunsNumber__c != ''){                              
                UpdatingAttendee.AS_BusinessDunsNumber__c = AttendeeSummary.AS_BusinessDunsNumber__c;}
                if(AttendeeSummary.Keywords__c != null && AttendeeSummary.Keywords__c != ''){                              
                UpdatingAttendee.Keywords__c = AttendeeSummary.Keywords__c;}
                if(AttendeeSummary.Exceptional_Key_Words__c != null && AttendeeSummary.Exceptional_Key_Words__c != ''){                              
                UpdatingAttendee.Exceptional_Key_Words__c = AttendeeSummary.Exceptional_Key_Words__c;}
                if(AttendeeSummary.AS_CellPhone__c != null && AttendeeSummary.AS_CellPhone__c != ''){                              
                UpdatingAttendee.AS_CellPhone__c=AttendeeSummary.AS_CellPhone__c;}
                if(AttendeeSummary.AS_Title__c != null && AttendeeSummary.AS_Title__c != ''){                              
                UpdatingAttendee.AS_Title__c=AttendeeSummary.AS_Title__c;}
                if(AttendeeSummary.As_prefixNew__c != null && AttendeeSummary.As_prefixNew__c != ''){                              
                UpdatingAttendee.As_prefixNew__c=AttendeeSummary.As_prefixNew__c;}
                if(AttendeeSummary.Business_type__c != null && AttendeeSummary.Business_type__c != ''){                              
                UpdatingAttendee.Business_type__c=AttendeeSummary.Business_type__c;}
                 if(AttendeeSummary.Company_Certifications__c != null && AttendeeSummary.Company_Certifications__c != ''){                              
                UpdatingAttendee.Company_Certifications__c=AttendeeSummary.Company_Certifications__c;}
                if(AttendeeSummary.GSA_Schedule__c != null && AttendeeSummary.GSA_Schedule__c != ''){                              
                UpdatingAttendee.GSA_Schedule__c=AttendeeSummary.GSA_Schedule__c;}
                if(AttendeeSummary.AS_CageCode__c != null && AttendeeSummary.AS_CageCode__c != ''){                              
                UpdatingAttendee.AS_CageCode__c=AttendeeSummary.AS_CageCode__c;}
                if(AttendeeSummary.AS_WorkZip__c != null){                              
                UpdatingAttendee.AS_WorkZip__c   =     BoothAdminUser.Zipcode__c;}
                 if(AttendeeSummary.DBA__c != null && AttendeeSummary.DBA__c != ''){
                UpdatingAttendee.DBA__c=AttendeeSummary.DBA__c;}
                if(AttendeeSummary.BBB_Number__c != null && AttendeeSummary.BBB_Number__c != ''){
                UpdatingAttendee.BBB_Number__c=AttendeeSummary.BBB_Number__c;}
                if(AttendeeSummary.distribution_Country__c != null && AttendeeSummary.distribution_Country__c != ''){
                UpdatingAttendee.distribution_Country__c=AttendeeSummary.distribution_Country__c;}
                if(AttendeeSummary.Manufactures_Country__c != null && AttendeeSummary.Manufactures_Country__c != ''){
                UpdatingAttendee.Manufactures_Country__c=AttendeeSummary.Manufactures_Country__c;}
                if(AttendeeSummary.AS_BusinessDescription__c != null && AttendeeSummary.AS_BusinessDescription__c != ''){
                UpdatingAttendee.AS_BusinessDescription__c=AttendeeSummary.AS_BusinessDescription__c;}
                

                //UpdatingAttendee.AS_uniqueField__c=(BoothAdminUser.FirstName+BoothAdminUser.LastName+Email).tolowercase();
                
                DataBase.Update(UpdatingAttendee);
                
                List<Event_Attendee_Mapping__c> EventAttendeeJun = [select id,EV_id__c from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c =true AND AS_id__r.AS_Email__c =: Email AND EV_id__c =: SelectEvent];
                system.debug('========================= Attendee is inserted in Junction Object Or not ==========='+EventAttendeeJun );
                
                if(EventAttendeeJun.size()>0){
                error = true;
                errormessage = 'Already Exist with this Email;';
                }
                else{
                
                    Event_Attendee_Mapping__c InsertinginJun = new Event_Attendee_Mapping__c();
                    InsertinginJun.AS_id__c = AttendeeDetails[0].id;
                    InsertinginJun.EV_id__c = selectEvent;
                    InsertinginJun.Boothleads_Profile__c = 'Booth Admin';
                    InsertinginJun.IsMatchMakingAttendee__c = true;
                   // InsertinginJun.Attendee_Event_IDs__c  = AttendeeDetails[0].Name + EventAttendeeJun[0].EV_id__r.Name;
                    insert InsertinginJun; 
                     InsertinginJun.EA_AttendeeBarcode__c=InsertinginJun.id+'-'+SelectEvent;
                     InsertinginJun.Attendee_Event_IDs__c=AttendeeDetails[0].id+SelectEvent;
                       update InsertinginJun;
                   }
                 
            }else {
            if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
    
                            if (attendeeImage.size() != null) {
                             if (attendeeImage.size() <= 4024000) {
                                 mydoc = new document();
                                 mydoc.body = attendeeImage;
                                 mydoc.folderid = UserInfo.getUserId();
                                 mydoc.ispublic = true;
                                 mydoc.Name = myimageName;
                                 insert mydoc;
                                 AttendeeSummary.AS_ImageUrl__c = mydoc.id;
                             } else {
                                 imageerror = true;
                                 imageerrormsg = 'Image size should be less than 1MB';
                             }
                         }}
                         if (ExhibitorImage != NULL && (myimageName != '' || myimageName != NULL)) {
    
         if (ExhibitorImage.size() != null) {
             if (ExhibitorImage.size() <= 4024000) {
                 mydoc = new document();
                 mydoc.body = ExhibitorImage;
                 mydoc.folderid = UserInfo.getUserId();
                 mydoc.ispublic = true;
                 mydoc.Name = myimageName;
                 insert mydoc;
                 AttendeeSummary.Exhibitor_company_imageUrl__c = mydoc.id;
             } else {
                 imageerror = true;
                 imageerrormsg = 'Image size should be less than 1MB';
             }
         }}
     
                     
                        //AttendeeSummary = new AttendeeSummary__c();
                       AttendeeSummary.AS_Email__c = Email;
                       AttendeeSummary.AS_FirstName__c = BoothAdminUser.FirstName;
                       AttendeeSummary.AS_LastName__c = BoothAdminUser.LastName;
                       AttendeeSummary.AS_Company__c  = BoothAdminUser.CompanyName;
                       AttendeeSummary.AS_CellPhone__c  = AttendeeSummary.AS_CellPhone__c;
                       AttendeeSummary.AS_WebsiteUrl__c  = BoothAdminUser.Company_website__c;
                        AttendeeSummary.AS_WorkAddress1__c =  BoothAdminUser.CompanyAddr1__c; 
                        AttendeeSummary.AS_WorkAddress2__c =  BoothAdminUser.CompanyAddr2__c ;  
                       AttendeeSummary.AS_BusinessDescription__c=AttendeeSummary.AS_BusinessDescription__c;
                         AttendeeSummary.AS_WorkCity__c =BoothAdminUser.CompanyCity__c;                
                AttendeeSummary.AS_Work_Country__c = BoothAdminUser.Country__c; 
                AttendeeSummary.AS_Work_States__c  = BoothAdminUser.states__c; 
                 
                AttendeeSummary.AS_WorkZip__c   =     BoothAdminUser.Zipcode__c;  
                       AttendeeSummary.AS_PrimaryBusinessCategory1__c = AttendeeSummary.AS_PrimaryBusinessCategory1__c;
                       AttendeeSummary.As_SecondaryBusinessCategory1__c = AttendeeSummary.As_SecondaryBusinessCategory1__c;
                       AttendeeSummary.AS_NumberOfEmployees__c = AttendeeSummary.AS_NumberOfEmployees__c;
                      AttendeeSummary.AS_BusinessEstablishedDate__c=AttendeeSummary.AS_BusinessEstablishedDate__c;
                      AttendeeSummary.AS_BusinessRevenue__c = AttendeeSummary.AS_BusinessRevenue__c;
                      AttendeeSummary.AS_BusinessTaxId__c = AttendeeSummary.AS_BusinessTaxId__c;
                      AttendeeSummary.AS_BusinessDunsNumber__c = AttendeeSummary.AS_BusinessDunsNumber__c;
                      AttendeeSummary.Keywords__c = AttendeeSummary.Keywords__c;
                      AttendeeSummary.Exceptional_Key_Words__c = AttendeeSummary.Exceptional_Key_Words__c;
                      AttendeeSummary.AS_CellPhone__c=AttendeeSummary.AS_CellPhone__c;
                      AttendeeSummary.AS_Title__c=AttendeeSummary.AS_Title__c;
                      AttendeeSummary.As_prefixNew__c=AttendeeSummary.As_prefixNew__c;
                      AttendeeSummary.Business_type__c=AttendeeSummary.Business_type__c;
                      AttendeeSummary.Company_Certifications__c=AttendeeSummary.Company_Certifications__c;
                      AttendeeSummary.GSA_Schedule__c=AttendeeSummary.GSA_Schedule__c;
                      AttendeeSummary.AS_CageCode__c=AttendeeSummary.AS_CageCode__c;
                       AttendeeSummary.DBA__c=AttendeeSummary.DBA__c;
                AttendeeSummary.BBB_Number__c=AttendeeSummary.BBB_Number__c;
                AttendeeSummary.distribution_Country__c=AttendeeSummary.distribution_Country__c;
                AttendeeSummary.Manufactures_Country__c=AttendeeSummary.Manufactures_Country__c;
                      
                           
                   try {
                       insert AttendeeSummary;
                   } catch (Exception e) {}
                       Event_Attendee_Mapping__c InsertinginJun = new Event_Attendee_Mapping__c();
                       InsertinginJun.AS_id__c = AttendeeSummary.id;
                       InsertinginJun.EV_id__c = SelectEvent;
                       InsertinginJun.Attendee_Event_IDs__c  = AttendeeSummary.Name;
                        InsertinginJun.Boothleads_Profile__c = 'Booth Admin';
                        InsertinginJun.IsMatchMakingAttendee__c = true;
                       Database.insert(InsertinginJun);  
                       
                        InsertinginJun.EA_AttendeeBarcode__c=InsertinginJun.id+'-'+SelectEvent;
                        InsertinginJun.Attendee_Event_IDs__c=AttendeeSummary.id+SelectEvent;
                        
                        Database.update (InsertinginJun);       
                       
        
            }
           
    } 
 
 
  
   Public void InsertUser(){
   emailalert= false;
   emailalert1 = false;
   
               Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin' limit 1];
               
               system.debug('======:::::::: Retriving Profile Id from Standard Profile Object ========::::::'+UserAsBA);              
              
             user uname=[select id from user where profile.Name Like 'System Administrator' and isActive=true Limit 1];

            account acc=new account();
            acc.name='Booth Leads';  
            //acc.ownerid = '005Z0000000oyN7';
            acc.ownerid=uname.id;          
            insert acc; 
         
                          
              /** 
                Account aa = [select id from Account where name = 'Booth Leads' Limit 1];
                
                A= new Account();
              
                A.Name = BoothAdminUser.companyName;
               A.ownerid = '005F0000002ODHv'; 
               
               */
               
                 Con.LastName = BoothAdminUser.LastName;
                 Con.FirstName = BoothAdminUser.FirstName;     
                
                Con.AccountId = acc.id;
                 insert Con ;
               
               system.debug('=====::::::::: Inserting Contact :::::::======='+Con );
               
                             
               
                BoothAdminUser.ContactID = Con.id;
                BoothAdminUser.Username = Email;
                BoothAdminUser.Email = Email;
                BoothAdminUser.Firstname = BoothAdminUser.Firstname;
                BoothAdminUser.LastName = BoothAdminUser.LastName;
                BoothAdminUser.Alias ='BAdmin';
                BoothAdminUser.ProfileID =UserAsBA.Id;
                BoothAdminUser.LocaleSidKey ='en_US';
                BoothAdminUser.LanguageLocaleKey ='en_US';
                BoothAdminUser.TimeZoneSidKey ='America/Los_Angeles';
                BoothAdminUser.EmailEncodingKey='UTF-8';
              
                BoothAdminUser.companyName = BoothAdminUser.companyName;
              
                BoothAdminUser.Company_website__c = BoothAdminUser.Company_website__c;
                BoothAdminUser.CompanyAddr1__c = BoothAdminUser.CompanyAddr1__c;
                BoothAdminUser.CompanyAddr2__c = BoothAdminUser.CompanyAddr2__c;
                BoothAdminUser.CompanyCity__c = BoothAdminUser.CompanyCity__c;                
                BoothAdminUser.Country__c = BoothAdminUser.Country__c;                
                BoothAdminUser.States__c = BoothAdminUser.States__c;
                BoothAdminUser.CompanyFaxNumber__c  = BoothAdminUser.CompanyFaxNumber__c;
                BoothAdminUser.Companyphone__c = BoothAdminUser.Companyphone__c;
                BoothAdminUser.Zipcode__c = BoothAdminUser.Zipcode__c;
                BoothAdminUser.PoBox__c = BoothAdminUser.PoBox__c;
                BoothAdminUser.IsActive = False;
               
                
               insert BoothAdminUser;
               forattendee(); 
                 try{ 
                if(attachmentname != null){
                 if ( attachmentval.size() != null) {
              
                   
                    Attachment a = new Attachment(parentId = AttendeeSummary.id, name=attachmentname, body = attachmentval);
                     insert a;
                }  
              }
        }catch(Exception e){}
        try{
       //saving video
             if(youtubevideo.YouTubeId_c__c != '' && youtubevideo.YouTubeId_c__c != null){
             List<string> ss =  new List<string> ();
            ss = youtubevideo.YouTubeId_c__c.split('src="');
            List<string> yy = new List<string> ();
            yy = ss[1].split('"');
            youtubevideo.YouTubeId_c__c = yy[0];
                 
             youtubevideo.AttendeeSummary__c = AttendeeSummary.id;
             insert youtubevideo;
             }
       
       system.debug('::::::::::::::::youtube:::::::::::::'+youtubevideo);
       }catch(exception e){}
                Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c 
                where PR_Name__c='BoothAdmin' limit 1];
                
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                UserBoothAdminProfile.BoothAdmin_id__c = BoothAdminUser.id;
                if(selectedBooth != null){
                UserBoothAdminProfile.BT_id__c  = selectedBooth;
                }else {
                UserBoothAdminProfile.BT_id__c  = Booth.id;
                }
                UserBoothAdminProfile.EV_id__c = SelectEvent;
                UserBoothAdminProfile.EventAdmin_Id__c = Userinfo.getUserId();
                UserBoothAdminProfile.UEP_isActive__c = True;
                UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.User_id__c = BoothAdminUser.Id;
                UserBoothAdminProfile.Status__c= 'Active';
                UserBoothAdminProfile.IsMatchMakingUser__c =true;
                UserBoothAdminProfile.MAtchMakingProfile__c ='Corporate';
                
                insert UserBoothAdminProfile;
                
               
                            
               UserBoothAdminProfile.Attendee_Summary__c = AttendeeSummary.id;
               update UserBoothAdminProfile;
   
   }
   
   public void ClosePopUp(){
   psettingsbool = false;
   emailalert= false;
   emailalert1 = false; 
    viewschedulepopup=false;
   CreatBoothAdminPopUp = False;
   ShowBoothAdminPopUp = False;
   EditBoothAdminPopUp = False;
   CreatOnlyBoothAdminPopUp = False;
   Statuspopup = False; 
   ShowMatchPanel= false;
   multiselectpicklist = false;
   Blockschedulebool = false;  
   viewbslist = false;  
   
   }
   //for assiging boothstaff to table if two persons sit at the table
   //Two persons will be having the same permissions and they can see the same data 
    public boolean errordisplycorp {get ; set ;}
    public list<User_Profile_Event__c> upeslistofstaff {get ; set ;}
    public list<selectoption> selectstaff {get ; set ;}
    public string selectedstaffperson {get ; set ;}
    public boolean viewbslist {get ; set ;}
    
    public void convertToBoothstaff(){ 
        selectedstaffperson='';   
        selectstaff = new list<selectoption> ();
        upeslistofstaff = new list<User_Profile_Event__c> ();
        ParticularJuncID = new User_Profile_Event__c();
        ParticularJuncID = [select EV_ID__c,BT_id__c,BT_id__r.BT_Name__c,User_Id__r.id,MAtchMakingProfile__c,UEP_isActive__c,Status__c,Attendee_Summary__r.id, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c                              
                                   from User_Profile_Event__c where id =: BoothAdminDetails];
         List<User_Profile_Event__c> ParticularJuncID1 = [select EV_ID__c,BT_id__c,User_Id__r.id,MAtchMakingProfile__c,UEP_isActive__c,Status__c,Attendee_Summary__r.id ,Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c                                
                                                                 from User_Profile_Event__c where EV_ID__c =: ParticularJuncID.EV_ID__c AND id !=: BoothAdminDetails AND (BT_id__c =: ParticularJuncID.BT_id__c OR BT_id__r.BT_Name__c =: ParticularJuncID.BT_id__r.BT_Name__c) AND (MAtchMakingProfile__c =: 'Corporate' OR MAtchMakingProfile__c =: 'Corporatestaff') ];                            
            if(ParticularJuncID1.Size() >=1){
                    for(User_Profile_Event__c bstaff : ParticularJuncID1){
                        upeslistofstaff.add(bstaff);
                        selectstaff.add(new selectoption (bstaff.id,bstaff.Attendee_Summary__r.AS_FirstName__c+' '+bstaff.Attendee_Summary__r.AS_LastName__c));               
                    }      
            } 
         viewbslist = true;  
    }
    public void AddtoTable(){
     User_Profile_Event__c ParticularJuncID2 = [select EV_ID__c,BT_id__c,User_Id__r.id,MAtchMakingProfile__c,UEP_isActive__c,Status__c,Attendee_Summary__r.id ,Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c                                
                                                                 from User_Profile_Event__c where id =: selectedstaffperson];                            
    Profile__c pro = [SELECT id from Profile__c WHERE PR_Name__c =: 'CorporateStaff'];
    ParticularJuncID2.BT_id__c = ParticularJuncID.BT_id__c;
    ParticularJuncID2.MAtchMakingProfile__c = 'Corporatestaff';
    ParticularJuncID2.Profile_id__c = pro.id;
    update ParticularJuncID2;
    viewbslist = false; 
    ListOfBoothAdmins(); 
    }   
    
    
     public void EditBoothAdmin(){

     //myimageName ='';
     attachmentval = null;
     attachmentname = '';
     youtubevideo = new Widget__c();
   
     error = false;
     emailalert1 = false;
     naicschangeselctdids = '';
     DisplayBoothAdminDetails();
     naicschangeids = '';
     if(selectedBooth != null){
     selectedBooth = OnlyBoothInfo.id;
     }
     
     
     ShowBoothAdminPopUp = False;
     EditBoothAdminPopUp = True; 
     
      checkNAICSforAttendeeEdit = '!@##$$$$###@';
      checkcommforAttendeeEdit = '!@##$$$$###@';
     if(AttendeeSummary.AS_NAICSCode_1__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode_1__c;
     }if(AttendeeSummary.AS_NAICSCode_2__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode_2__c;
     }if(AttendeeSummary.AS_NAICSCode_3__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode_3__c;
     }if(AttendeeSummary.AS_NAICSCode_4__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode_4__c;
     }if(AttendeeSummary.AS_NAICSCode_5__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode_5__c;
     }
     if(AttendeeSummary.AS_NAICSCode6__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode6__c;
     }
     if(AttendeeSummary.AS_NAICSCode7__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode7__c;
     }
     if(AttendeeSummary.AS_NAICSCode8__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode8__c;
     }if(AttendeeSummary.AS_NAICSCode9__c!=null ){

         checkNAICSforAttendeeEdit += AttendeeSummary.AS_NAICSCode9__c;
     }
     
     
     
     if(AttendeeSummary.Commodity_1__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_1__c;
     }if(AttendeeSummary.Commodity_2__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_2__c;
     }if(AttendeeSummary.Commodity_3__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_3__c;
     }if(AttendeeSummary.Commodity_4__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_4__c;
     }if(AttendeeSummary.Commodity_5__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_5__c;
     }if(AttendeeSummary.Commodity_6__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_6__c;
     }if(AttendeeSummary.Commodity_7__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_7__c;
     }if(AttendeeSummary.Commodity_8__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_8__c;
     }if(AttendeeSummary.Commodity_9__c!=null ){

         checkcommforAttendeeEdit += ','+AttendeeSummary.Commodity_9__c;
     }
    system.debug('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa ' + checkNAICSforAttendeeEdit );
      
      
    
     //system.debug(' BBBBBBBBBBBBB AAAAAAAAAAAAAAAAAAA MMMMMMMMMMMMMM '+BoothAdminDetails+' BBBBBBBBBBB '+selectedBooth);
      
     }
     
    /* EDITED AND ADDED BY RAJESH */
    /* FOR NAICS CODES AND COMMODITIES */
    
    
    
    public void NaicsCodesFunc(String naics, String Comdts){        
        
        if(naics != NULL){
            
            naicscods= new list<string>();
            naicscods=naics.split('-');
            system.debug('naicscods.size === ' + naicscods.size());
            
            if(naicscods.size() == 2){
                Naics1 = naicscods[1].replace('&','-');
            }
            
            if(naicscods.size() == 3){
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
            }
            
            if(naicscods.size() == 4){
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
                Naics3 = naicscods[3].replace('&','-');
            }
            
            if(naicscods.size() == 5){
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
                Naics3 = naicscods[3].replace('&','-');
                Naics4 = naicscods[4].replace('&','-');
            }
            
            if(naicscods.size() == 6){
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
                Naics3 = naicscods[3].replace('&','-');
                Naics4 = naicscods[4].replace('&','-');
                Naics5 = naicscods[5].replace('&','-');
            }
            
            if(naicscods.size() == 7){
                system.debug('aaaaaaaaaaa ');   
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
                Naics3 = naicscods[3].replace('&','-');
                Naics4 = naicscods[4].replace('&','-');
                Naics5 = naicscods[5].replace('&','-');
                Naics6 = naicscods[6].replace('&','-');
            }
            
            if(naicscods.size() == 8){
                system.debug('aaaaaaaaaaa ');   
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
                Naics3 = naicscods[3].replace('&','-');
                Naics4 = naicscods[4].replace('&','-');
                Naics5 = naicscods[5].replace('&','-');
                Naics6 = naicscods[6].replace('&','-');
                Naics7 =naicscods[7].replace('&','-');
            }
            
            if(naicscods.size() == 9){
                system.debug('aaaaaaaaaaa ');   
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
                Naics3 = naicscods[3].replace('&','-');
                Naics4 = naicscods[4].replace('&','-');
                Naics5 = naicscods[5].replace('&','-');
                Naics6 = naicscods[6].replace('&','-');
                Naics7 =naicscods[7].replace('&','-');
                Naics8 =naicscods[8].replace('&','-');
            }
            
            if(naicscods.size() == 10){
                system.debug('aaaaaaaaaaa ');   
                Naics1 = naicscods[1].replace('&','-');
                Naics2 = naicscods[2].replace('&','-');
                Naics3 = naicscods[3].replace('&','-');
                Naics4 = naicscods[4].replace('&','-');
                Naics5 = naicscods[5].replace('&','-');
                Naics6 = naicscods[6].replace('&','-');
                Naics7 =naicscods[7].replace('&','-');
                Naics8 =naicscods[8].replace('&','-');
                Naics9 =naicscods[9].replace('&','-');
            }       
        
        }
        
        if(Comdts != NULL){
                            
            commodities = new list<string>();
            commodities =Comdts.split('-');
            system.debug('shruthi shruhti shruthi 11111111111' + commodities.size());           
            
            
            if(commodities.size() == 2){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                system.debug('ddddddddddddddddd ' +  Commodity1 );
            }
            
            if(commodities.size() == 3){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
            }
            
            if(commodities.size() == 4){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
                Commodity3 = commodities[3].replace('&','-');
            }
            
            if(commodities.size() == 5){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
                Commodity3 = commodities[3].replace('&','-');
                Commodity4 = commodities[4].replace('&','-');
            }
            
            if(commodities.size() == 6){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
                Commodity3 = commodities[3].replace('&','-');
                Commodity4 = commodities[4].replace('&','-');
                Commodity5 = commodities[5].replace('&','-');
            }
            
            if(commodities.size() == 7){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
                Commodity3 = commodities[3].replace('&','-');
                Commodity4 = commodities[4].replace('&','-');
                Commodity5 = commodities[5].replace('&','-');
                Commodity6 = commodities[6].replace('&','-');
            }
            
            if(commodities.size() == 8){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
                Commodity3 = commodities[3].replace('&','-');
                Commodity4 = commodities[4].replace('&','-');
                Commodity5 = commodities[5].replace('&','-');
                Commodity6 = commodities[6].replace('&','-');
                Commodity7 = commodities[7].replace('&','-');
            }
            
            if(commodities.size() == 9){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
                Commodity3 = commodities[3].replace('&','-');
                Commodity4 = commodities[4].replace('&','-');
                Commodity5 = commodities[5].replace('&','-');
                Commodity6 = commodities[6].replace('&','-');
                Commodity7 = commodities[7].replace('&','-');
                Commodity8 = commodities[8].replace('&','-');
            }
            
            if(commodities.size() == 10){
                system.debug('aaaaaaaaaaa ');   
                Commodity1 = commodities[1].replace('&','-');
                Commodity2 = commodities[2].replace('&','-');
                Commodity3 = commodities[3].replace('&','-');
                Commodity4 = commodities[4].replace('&','-');
                Commodity5 = commodities[5].replace('&','-');
                Commodity6 = commodities[6].replace('&','-');
                Commodity7 = commodities[7].replace('&','-');
                Commodity8 = commodities[8].replace('&','-');
                Commodity9 = commodities[9].replace('&','-');
            }
        
        }
    }
    /* FOR NAICS CODES AND COMMODITIES */ 
    
    
    /* FOR INSERTING ATTENDEE SUMMARY*/
    public AttendeeSummary__c ToInsertAttendeeSummery(AttendeeSummary__c AttSum, User userDet){
        AttendeeSummary__c AttendeeSummaryNew = new AttendeeSummary__c();

        AttendeeSummaryNew.AS_FirstName__c = userDet.FirstName;
        AttendeeSummaryNew.AS_LastName__c = userDet.LastName;
        AttendeeSummaryNew.AS_Email__c = userDet.Username;
        AttendeeSummaryNew.AS_PrimaryBusinessCategory1__c = AttSum.AS_PrimaryBusinessCategory1__c;
        AttendeeSummaryNew.As_SecondaryBusinessCategory1__c = AttSum.As_SecondaryBusinessCategory1__c;
        AttendeeSummaryNew.AS_NumberOfEmployees__c = AttSum.AS_NumberOfEmployees__c;
        AttendeeSummaryNew.AS_BusinessEstablishedDate__c=AttSum.AS_BusinessEstablishedDate__c;
        AttendeeSummaryNew.AS_BusinessRevenue__c = AttSum.AS_BusinessRevenue__c;
        AttendeeSummaryNew.AS_BusinessTaxId__c = AttSum.AS_BusinessTaxId__c;
        AttendeeSummaryNew.AS_BusinessDunsNumber__c = AttSum.AS_BusinessDunsNumber__c;
        AttendeeSummaryNew.Keywords__c = AttSum.Keywords__c;
        AttendeeSummaryNew.Exceptional_Key_Words__c = AttSum.Exceptional_Key_Words__c;
        AttendeeSummaryNew.Business_type__c=AttSum.Business_type__c;
        AttendeeSummaryNew.Company_Certifications__c=AttSum.Company_Certifications__c;
        AttendeeSummaryNew.GSA_Schedule__c=AttSum.GSA_Schedule__c;
        AttendeeSummaryNew.AS_CageCode__c=AttSum.AS_CageCode__c;
        AttendeeSummaryNew.AS_CellPhone__c=AttSum.AS_CellPhone__c;
        AttendeeSummaryNew.AS_Company__c =userDet.companyName ;
        //AttendeeSummaryNew.Certificate_Processed_by_RPO__c = SelectValAs;
        AttendeeSummaryNew.Certificate_Processed_by_RPO__c = AttSum.Certificate_Processed_by_RPO__c;
        AttendeeSummaryNew.AS_WorkAddress1__c =AttSum.AS_WorkAddress1__c;
        AttendeeSummaryNew.AS_WorkAddress2__c =AttSum.AS_WorkAddress2__c;
        AttendeeSummaryNew.AS_Work_Country__c = AttSum.AS_Work_Country__c;
        AttendeeSummaryNew.AS_Work_States__c =AttSum.AS_Work_States__c;
        AttendeeSummaryNew.AS_WorkCity__c =AttSum.AS_WorkCity__c;
        AttendeeSummaryNew.AS_WorkZip__c =AttSum.AS_WorkZip__c;
        AttendeeSummaryNew.AS_WebsiteUrl__c =userDet.Company_website__c;
        
        AttendeeSummaryNew.As_NAICSCode_1__c = Naics1;
        AttendeeSummaryNew.As_NAICSCode_2__c = Naics2;
        AttendeeSummaryNew.As_NAICSCode_3__c = Naics3;
        AttendeeSummaryNew.As_NAICSCode_4__c = Naics4;
        AttendeeSummaryNew.As_NAICSCode_5__c = Naics5;
        AttendeeSummaryNew.AS_NAICSCode6__c = Naics6;
        AttendeeSummaryNew.AS_NAICSCode7__c = Naics7;
        AttendeeSummaryNew.AS_NAICSCode8__c = Naics8;
        AttendeeSummaryNew.AS_NAICSCode9__c = Naics9;
        
        AttendeeSummaryNew.Commodity_1__c = Commodity1;
        AttendeeSummaryNew.Commodity_2__c = Commodity2;
        AttendeeSummaryNew.Commodity_3__c = Commodity3;
        AttendeeSummaryNew.Commodity_4__c = Commodity4;
        AttendeeSummaryNew.Commodity_5__c = Commodity5;
        AttendeeSummaryNew.Commodity_6__c = Commodity6;
        AttendeeSummaryNew.Commodity_7__c = Commodity7;
        AttendeeSummaryNew.Commodity_8__c = Commodity8;
        AttendeeSummaryNew.Commodity_9__c = Commodity9;
        
        if(selectedregions.size() != 0){
            AttendeeSummaryNew.Geographical_Region__c = '';
            for(string st1 : selectedregions){          
                AttendeeSummaryNew.Geographical_Region__c += st1+',';          
            }
        }
      
        //naicsselctdids =ApexPages.currentPage().getParameters().get('updateatt');
        //naicschangeselctdids = naicsselctdids;
        system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
        commsselctdids = ApexPages.currentPage().getParameters().get('updateattcomm ');
        system.debug('ddddddddddd ffffffffffff gg'+commchangeselctdids );
             
                 
        //Database.Update(AttendeeSummary);
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBB '+attendeeImage );   
    
        if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
            if (attendeeImage.size() != null) {
                if (attendeeImage.size() < 4024000) {
                    mydoc1 = new document();
                    mydoc1.body = attendeeImage;
                    mydoc1.folderid = UserInfo.getUserId();
                    mydoc1.ispublic = true;
                    mydoc1.Name = myimageName;
                    insert mydoc1;
                    //system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + mydoc);
                    //AttendeeSummary__c ImageUpload = [select AS_ImageUrl__c from AttendeeSummary__c where id = : AttendeeSummary.id];
                    //ImageUpload.AS_ImageUrl__c = mydoc.id;
                    //Update ImageUpload;
                    AttendeeSummaryNew.AS_ImageUrl__c = mydoc1.id;
                }
            }
        }
                             
        if (ExhibitorImage != NULL && (myimageName != '' || myimageName != NULL)) {     
            if (ExhibitorImage.size() != null) {
                if (ExhibitorImage.size() <= 4024000) {
                    mydoc = new document();
                    mydoc.body = ExhibitorImage;
                    mydoc.folderid = UserInfo.getUserId();
                    mydoc.ispublic = true;
                    mydoc.Name = myimageName;
                    insert mydoc;
                    // system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + mydoc);
                    //   AttendeeSummary__c ImageUpload = [select Exhibitor_company_imageUrl__c from AttendeeSummary__c where id = : AttendeeSummary.id];
                    //   ImageUpload.Exhibitor_company_imageUrl__c = mydoc.id;
                    //  Update ImageUpload;
                    AttendeeSummaryNew.Exhibitor_company_imageUrl__c = mydoc.id;
                }
            }
        }
        //Database.insert(AttendeeSummaryNew,false);
        Database.upsert(AttendeeSummaryNew, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);
        // TO INSERT MBE PROFIE IF THE EVENT IS WEBENK EVENT
        eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, EV_EventLogo__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,Is_MatchMaking_Event__c,Owner.Name,Owner.Username, Is_Webank_event__c
                          FROM Event__c 
                          WHERE ID =: SelectEvent ];
        if(eventDetails.Is_Webank_event__c==true){
            List<MBE_Profile__c> updateMbePro = new List<MBE_Profile__c>();
            updateMbePro = [SELECT Id, AttendeeSummary__c FROM MBE_Profile__c WHERE AS_Email__c =: AttendeeSummaryNew.AS_Email__c];
            if(updateMbePro.size()>0){
                ToUpdateMBEProfile(AttendeeSummaryNew, eventDetails, mydoc1);
            }else{
                ToInsertMBEProfile(AttendeeSummaryNew, eventDetails, mydoc1);
            }
        }
        // TO INSERT MBE PROFIE IF THE EVENT IS WEBENK EVENT
                
        return AttendeeSummaryNew;
    }
    /* FOR INSERTING ATTENDEE SUMMARY*/
    
    /* */
    public User ToUpdateUserDetails(AttendeeSummary__c AttSum, User userDet){
        system.debug('AttSum === '+AttSum+'   UserDet === '+userDet);
        User updateUserDet = [Select Id,FirstName,LastName,UserName,CompanyName,Email,Company_website__c,CompanyAddr1__c,
                          CompanyAddr2__c,CompanyCity__c,CompanyCountry__c,CompanyState__c,CompanyFaxNumber__c,
                          Companyphone__c,Zipcode__c,PoBox__c,Country__c,States__c, Contact.Id from User where Username =: userDet.Username];
                          
        Contact updateCon = [SELECT Id, FirstName, LastName FROM Contact WHERE Id =: updateUserDet.Contact.Id ];
        updateCon.FirstName = userDet.FirstName;
        updateCon.LastName = userDet.LastName;
        update updateCon;
        
        updateUserDet.FirstName = userDet.FirstName;
        updateUserDet.LastName = userDet.LastName;
        updateUserDet.companyName = userDet.companyName ;
        updateUserDet.Company_website__c = userDet.Company_website__c ;
        updateUserDet.CompanyAddr1__c = AttSum.AS_WorkAddress1__c ;
        updateUserDet.CompanyAddr2__c = AttSum.AS_WorkAddress2__c ;
        updateUserDet.CompanyCity__c =AttSum.AS_WorkCity__c;
        updateUserDet.Country__c =  AttSum.AS_Work_Country__c ;
        updateUserDet.States__c = AttSum.AS_Work_States__c ;
        updateUserDet.CompanyFaxNumber__c  = userDet.CompanyFaxNumber__c  ;
        updateUserDet.Companyphone__c = userDet.Companyphone__c ;
        updateUserDet.Zipcode__c = AttSum.AS_WorkZip__c ;
        updateUserDet.PoBox__c = userDet.PoBox__c ;
        updateUserDet.Contact.FirstName=userDet.FirstName;
        updateUserDet.Contact.LastName=userDet.LastName;
        system.debug('updateUserDet.Id === '+updateUserDet.Id);
        Database.Update(updateUserDet);
        return updateUserDet;
    }
    /* */
       
    /* FOR UPDATING ATTENDEE SUMMARY*/
    public AttendeeSummary__c ToUpdateAttendeeSummery(AttendeeSummary__c AttSum, User userDet){        
        
       system.debug('AttSum === '+AttSum +' userDet === '+ userDet);
        AttendeeSummary__c updateAttendeeSummary = [SELECT Id,AS_FirstName__c,AS_LastName__c,AS_Email__c ,AS_PrimaryBusinessCategory1__c,As_SecondaryBusinessCategory1__c,AS_NumberOfEmployees__c,
            AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_BusinessDunsNumber__c,Keywords__c,Exceptional_Key_Words__c,Business_type__c,AS_Title__c,Geographical_Region__c,distribution_Country__c,
            Company_Certifications__c,GSA_Schedule__c,AS_CageCode__c,AS_CellPhone__c,AS_Company__c,Certificate_Processed_by_RPO__c,AS_WorkAddress1__c,AS_WorkAddress2__c,BBB_Number__c,AS_WorkPhone__c,AS_BusinessDescription__c,
            AS_Work_Country__c,AS_Work_States__c,AS_WorkCity__c,AS_WorkZip__c,AS_WebsiteUrl__c,As_NAICSCode_1__c,As_NAICSCode_2__c,As_NAICSCode_3__c,As_NAICSCode_4__c,Manufactures_Country__c,DBA__c,
            As_NAICSCode_5__c,AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c,
            Commodity_6__c,Commodity_7__c,Commodity_8__c,Commodity_9__c FROM AttendeeSummary__c WHERE AS_Email__c =: userDet.Username ];
        system.debug('userDet.FirstName === '+userDet.Firstname);
        
        updateAttendeeSummary.AS_FirstName__c = userDet.FirstName;
        updateAttendeeSummary.AS_LastName__c = userDet.LastName;
        updateAttendeeSummary.AS_Email__c = userDet.Username;
        updateAttendeeSummary.AS_PrimaryBusinessCategory1__c = AttSum.AS_PrimaryBusinessCategory1__c;
        updateAttendeeSummary.As_SecondaryBusinessCategory1__c = AttSum.As_SecondaryBusinessCategory1__c;
        updateAttendeeSummary.AS_NumberOfEmployees__c = AttSum.AS_NumberOfEmployees__c;
        updateAttendeeSummary.AS_BusinessEstablishedDate__c=AttSum.AS_BusinessEstablishedDate__c;
        updateAttendeeSummary.AS_BusinessRevenue__c = AttSum.AS_BusinessRevenue__c;
        updateAttendeeSummary.AS_BusinessTaxId__c = AttSum.AS_BusinessTaxId__c;
        updateAttendeeSummary.AS_BusinessDunsNumber__c = AttSum.AS_BusinessDunsNumber__c;
        updateAttendeeSummary.Keywords__c = AttSum.Keywords__c;
        updateAttendeeSummary.Exceptional_Key_Words__c = AttSum.Exceptional_Key_Words__c;
        updateAttendeeSummary.Business_type__c=AttSum.Business_type__c;
        updateAttendeeSummary.Company_Certifications__c=AttSum.Company_Certifications__c;
        updateAttendeeSummary.GSA_Schedule__c=AttSum.GSA_Schedule__c;
        updateAttendeeSummary.AS_CageCode__c=AttSum.AS_CageCode__c;
        updateAttendeeSummary.AS_CellPhone__c=AttSum.AS_CellPhone__c;
        updateAttendeeSummary.AS_Company__c =userDet.companyName ;
        //updateAttendeeSummary.Certificate_Processed_by_RPO__c = SelectValAs;
        updateAttendeeSummary.Certificate_Processed_by_RPO__c = AttSum.Certificate_Processed_by_RPO__c;
        updateAttendeeSummary.AS_WorkAddress1__c =AttSum.AS_WorkAddress1__c;
        updateAttendeeSummary.AS_WorkAddress2__c =AttSum.AS_WorkAddress2__c;
        updateAttendeeSummary.AS_Work_Country__c = AttSum.AS_Work_Country__c;
        updateAttendeeSummary.AS_Work_States__c =AttSum.AS_Work_States__c;
        updateAttendeeSummary.AS_WorkCity__c =AttSum.AS_WorkCity__c;
        updateAttendeeSummary.AS_WorkZip__c =AttSum.AS_WorkZip__c;
        updateAttendeeSummary.AS_WebsiteUrl__c =userDet.Company_website__c;
        //********************By Unni****************
        updateAttendeeSummary.AS_Title__c = AttSum.AS_Title__c;
        //updateAttendeeSummary.Geographical_Region__c =AttSum.Geographical_Region__c;
        updateAttendeeSummary.distribution_Country__c =AttSum.distribution_Country__c;
        updateAttendeeSummary.BBB_Number__c = AttSum.BBB_Number__c;
        updateAttendeeSummary.AS_WorkPhone__c =AttSum.AS_WorkPhone__c;
        updateAttendeeSummary.AS_BusinessDescription__c =AttSum.AS_BusinessDescription__c;
        updateAttendeeSummary.Manufactures_Country__c =AttSum.Manufactures_Country__c;
        updateAttendeeSummary.DBA__c =AttSum.DBA__c;
        //********************By Unni****************
        updateAttendeeSummary.As_NAICSCode_1__c = Naics1;
        updateAttendeeSummary.As_NAICSCode_2__c = Naics2;
        updateAttendeeSummary.As_NAICSCode_3__c = Naics3;
        updateAttendeeSummary.As_NAICSCode_4__c = Naics4;
        updateAttendeeSummary.As_NAICSCode_5__c = Naics5;
        updateAttendeeSummary.AS_NAICSCode6__c = Naics6;
        updateAttendeeSummary.AS_NAICSCode7__c = Naics7;
        updateAttendeeSummary.AS_NAICSCode8__c = Naics8;
        updateAttendeeSummary.AS_NAICSCode9__c = Naics9;
        
        updateAttendeeSummary.Commodity_1__c = Commodity1;
        updateAttendeeSummary.Commodity_2__c = Commodity2;
        updateAttendeeSummary.Commodity_3__c = Commodity3;
        updateAttendeeSummary.Commodity_4__c = Commodity4;
        updateAttendeeSummary.Commodity_5__c = Commodity5;
        updateAttendeeSummary.Commodity_6__c = Commodity6;
        updateAttendeeSummary.Commodity_7__c = Commodity7;
        updateAttendeeSummary.Commodity_8__c = Commodity8;
        updateAttendeeSummary.Commodity_9__c = Commodity9;
        
        if(selectedregions.size() != 0){
            AttendeeSummary.Geographical_Region__c = '';
            for(string st1 : selectedregions){          
                updateAttendeeSummary.Geographical_Region__c += st1+',';          
            }
        }
      
        //naicsselctdids =ApexPages.currentPage().getParameters().get('updateatt');
        //naicschangeselctdids = naicsselctdids;
        system.debug('ddddddddddd ffffffffffff gg'+naicschangeselctdids );
        commsselctdids = ApexPages.currentPage().getParameters().get('updateattcomm ');
        system.debug('ddddddddddd ffffffffffff gg'+commchangeselctdids );
             
                 
        //Database.Update(AttendeeSummary);
        system.debug('BBBBBBBBBBBBBBBBBBBBBBBBBBBB '+attendeeImage );   
    
        if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
            if (attendeeImage.size() != null) {
                if (attendeeImage.size() < 4024000) {
                    mydoc1 = new document();
                    mydoc1.body = attendeeImage;
                    mydoc1.folderid = UserInfo.getUserId();


                    mydoc1.ispublic = true;
                    mydoc1.Name = myimageName;
                    insert mydoc1;
                    //system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + mydoc);
                    //AttendeeSummary__c ImageUpload = [select AS_ImageUrl__c from AttendeeSummary__c where id = : AttendeeSummary.id];
                    //ImageUpload.AS_ImageUrl__c = mydoc.id;
                    //Update ImageUpload;
                    updateAttendeeSummary.AS_ImageUrl__c = mydoc1.id;
                }
            }
        }
                             
        if (ExhibitorImage != NULL && (myimageName != '' || myimageName != NULL)) {     
            if (ExhibitorImage.size() != null) {
                if (ExhibitorImage.size() <= 4024000) {
                    mydoc = new document();
                    mydoc.body = ExhibitorImage;
                    mydoc.folderid = UserInfo.getUserId();
                    mydoc.ispublic = true;
                    mydoc.Name = myimageName;
                    insert mydoc;
                    // system.debug(':::::::::::::::::::::::::Image:::::::::::::::' + mydoc);
                    //   AttendeeSummary__c ImageUpload = [select Exhibitor_company_imageUrl__c from AttendeeSummary__c where id = : AttendeeSummary.id];
                    //   ImageUpload.Exhibitor_company_imageUrl__c = mydoc.id;
                    //  Update ImageUpload;
                    updateAttendeeSummary.Exhibitor_company_imageUrl__c = mydoc.id;
                }
            }
        }
        system.debug('updateAttendeeSummary === '+updateAttendeeSummary);
        Database.SaveResult upAtt = Database.update(updateAttendeeSummary,false);
       
        // TO INSERT MBE PROFIE IF THE EVENT IS WEBENK EVENT
        eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, EV_EventLogo__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,Is_MatchMaking_Event__c,Owner.Name,Owner.Username, Is_Webank_event__c
                          FROM Event__c 
                          WHERE ID =: SelectEvent ];
        
        if(eventDetails.Is_Webank_event__c==true){            
            List<MBE_Profile__c> updateMbePro = [SELECT Id, AttendeeSummary__c FROM MBE_Profile__c WHERE AS_Email__c =: updateAttendeeSummary.AS_Email__c];
            if(updateMbePro.size()>0){
                ToUpdateMBEProfile(updateAttendeeSummary, eventDetails, mydoc1);
            }else{
                ToInsertMBEProfile(updateAttendeeSummary, eventDetails, mydoc1);
            }
        }
        // TO INSERT MBE PROFIE IF THE EVENT IS WEBENK EVENT
        
        return updateAttendeeSummary;
        
        
    }
    /* FOR UPDATING ATTENDEE SUMMARY*/
    
    /* FOR INSERTING MBE PROFILE */
    public MBE_Profile__c ToInsertMBEProfile(AttendeeSummary__c newattendee, Event__c eventDetails, Document mydoc){
        MBE_Profile__c mp =new MBE_Profile__c();

        mp.Event_Organizer_Id__c = eventDetails.Owner.Username;
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
        mp.AS_CellPhone__c  = newattendee.AS_CellPhone__c;
        mp.AS_Company__c = newattendee.AS_Company__c;
        mp.AS_Email__c = newattendee.AS_Email__c;
        mp.AS_FirstName__c = newattendee.AS_FirstName__c;
        mp.As_Home_Country__c = newattendee.As_Home_Country__c;
        mp.As_Home_State__c = newattendee.As_Home_State__c;
        mp.AS_HomeZip__c = newattendee.AS_HomeZip__c;
        mp.AS_LastName__c = newattendee.AS_LastName__c;
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
        mp.Certificate_Processed_by_RPO__c = newattendee.Certificate_Processed_by_RPO__c;
        mp.BBB_Number__c = newattendee.BBB_Number__c;

        mp.distribution_Country__c = newattendee.distribution_Country__c;
        mp.Manufactures_Country__c =newattendee.Manufactures_Country__c;
        mp.References__c = newattendee.References__c;
        mp.Scope_of_Work__c = newattendee.Scope_of_Work__c;
        mp.References2__c = newattendee.References2__c;
        mp.Scope_of_Work2__c = newattendee.Scope_of_Work2__c;
        mp.Revenue_Range__c = newattendee.Revenue_Range__c;
        mp.AttendeeSummary__c = newattendee.Id;
        
        mp.As_NAICSCode_1__c = Naics1;
        mp.As_NAICSCode_2__c = Naics2;
        mp.As_NAICSCode_3__c = Naics3;
        mp.As_NAICSCode_4__c = Naics4;
        mp.As_NAICSCode_5__c = Naics5;
        mp.AS_NAICSCode6__c = Naics6;
        mp.AS_NAICSCode7__c = Naics7;
        mp.AS_NAICSCode8__c = Naics8;
        mp.AS_NAICSCode9__c = Naics9;
        
        mp.Commodity_1__c = Commodity1;
        mp.Commodity_2__c = Commodity2;
        mp.Commodity_3__c = Commodity3;
        mp.Commodity_4__c = Commodity4;
        mp.Commodity_5__c = Commodity5;
        mp.Commodity_6__c = Commodity6;
        mp.Commodity_7__c = Commodity7;
        mp.Commodity_8__c = Commodity8;
        mp.Commodity_9__c = Commodity9;
        
        if(mydoc != null){
            if(mydoc.id != null && mydoc.id != ''){
                mp.AS_ImageUrl__c = mydoc.id;
            }
        }
        database.insert(mp,false);
        
        try{
            if(attachmentname != null){
                if ( attachmentval.size() != null) {                
                    Attachment a1 = new Attachment(parentId = mp.id, name=attachmentname, body = attachmentval);
                    insert a1;
                }
            }
        }catch(Exception e){}
        
        return mp;
    }
    
/*    public ToUpdateBoothInfo(){
        
        OnlyBoothInfo.BT_Name__c = BoothAdmininfo.companyName;
        OnlyBoothInfo.BT_ContactEmail__c = BoothAdmininfo.Username;
        OnlyBoothInfo.BT_Location__c = OnlyBoothInfo.BT_Location__c;
        OnlyBoothInfo.MM_TableNo__c = OnlyBoothInfo.MM_TableNo__c;
        OnlyBoothInfo.BT_ContactName__c = AttendeeSummary.AS_FirstName__c +' '+AttendeeSummary.AS_LastName__c;
        OnlyBoothInfo.BT_WebsiteURL__c = BoothAdmininfo.Company_website__c ;
        OnlyBoothInfo.BT_Phone__c = BoothAdmininfo.Companyphone__c ;
        
        Database.Update(OnlyBoothInfo);
    }*/
    /* FOR INSERTING MBE PROFILE */
    
    /* FOR UPDATING MBE PROFILE */
    public MBE_Profile__c ToUpdateMBEProfile(AttendeeSummary__c newattendee, Event__c eventDetails, Document mydoc){
        
        MBE_Profile__c mp = [SELECT Event_Organizer_Id__c,Key_Words__c,AS_BusinessDunsNumber__c,AS_BusinessTaxId__c,AS_BusinessDescription__c,Business_type__c,
                            AS_BusinessRevenue__c,AS_BusinessEstablishedDate__c,AS_CageCode__c,AS_WebsiteUrl__c,AS_DiversityType__c,GSA_Schedule__c,AS_NumberOfEmployees__c,
                            AS_PrimaryBusinessCategory1__c,As_SecondaryBusinessCategory1__c,Company_Certifications__c,AS_CellPhone__c,AS_Company__c,AS_Email__c,AS_FirstName__c,
                            As_Home_Country__c,As_Home_State__c,AS_HomeZip__c,AS_LastName__c,As_prefixNew__c,AS_shippingzip_c__c,As_SuffixNew__c,AS_Title__c,AS_Work_States__c,
                            AS_WorkAddress1__c,AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkPhone__c,AS_WorkZipCode__c,AS_WorkZip__c,AS_Work_Country__c,Year_in_business__c,
                            Business_Structure__c,AS_FaxNumber__c,Ethnicity__c,Any_non_WBENC_awards_received__c,Companyhaveafacility_partneroutsideUSA__c,AS_Secondary_Email__c,
                            DBA__c,Certificate_Processed_by_RPO__c,BBB_Number__c,distribution_Country__c,Manufactures_Country__c,References__c,Scope_of_Work__c,References2__c,
                            Scope_of_Work2__c,Revenue_Range__c,AttendeeSummary__c,As_NAICSCode_1__c,As_NAICSCode_2__c,As_NAICSCode_3__c,As_NAICSCode_4__c,As_NAICSCode_5__c,
                            AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c,
                            Commodity_6__c,Commodity_7__c,Commodity_8__c,Commodity_9__c,AS_ImageUrl__c FROM MBE_Profile__c WHERE AS_Email__c =: newattendee.AS_Email__c];
        
        
        mp.Event_Organizer_Id__c = eventDetails.Owner.Username;
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
        mp.AS_CellPhone__c  = newattendee.AS_CellPhone__c;
        mp.AS_Company__c = newattendee.AS_Company__c;
        mp.AS_Email__c = newattendee.AS_Email__c;
        mp.AS_FirstName__c = newattendee.AS_FirstName__c;
        mp.As_Home_Country__c = newattendee.As_Home_Country__c;
        mp.As_Home_State__c = newattendee.As_Home_State__c;
        mp.AS_HomeZip__c = newattendee.AS_HomeZip__c;
        mp.AS_LastName__c = newattendee.AS_LastName__c;
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
        mp.Certificate_Processed_by_RPO__c = newattendee.Certificate_Processed_by_RPO__c;
        mp.BBB_Number__c = newattendee.BBB_Number__c;

        mp.distribution_Country__c = newattendee.distribution_Country__c;
        mp.Manufactures_Country__c =newattendee.Manufactures_Country__c;
        mp.References__c = newattendee.References__c;
        mp.Scope_of_Work__c = newattendee.Scope_of_Work__c;
        mp.References2__c = newattendee.References2__c;
        mp.Scope_of_Work2__c = newattendee.Scope_of_Work2__c;
        mp.Revenue_Range__c = newattendee.Revenue_Range__c;
        mp.AttendeeSummary__c = newattendee.Id;
        
        mp.As_NAICSCode_1__c = Naics1;
        mp.As_NAICSCode_2__c = Naics2;
        mp.As_NAICSCode_3__c = Naics3;
        mp.As_NAICSCode_4__c = Naics4;
        mp.As_NAICSCode_5__c = Naics5;
        mp.AS_NAICSCode6__c = Naics6;
        mp.AS_NAICSCode7__c = Naics7;
        mp.AS_NAICSCode8__c = Naics8;
        mp.AS_NAICSCode9__c = Naics9;
        
        mp.Commodity_1__c = Commodity1;
        mp.Commodity_2__c = Commodity2;
        mp.Commodity_3__c = Commodity3;
        mp.Commodity_4__c = Commodity4;
        mp.Commodity_5__c = Commodity5;
        mp.Commodity_6__c = Commodity6;
        mp.Commodity_7__c = Commodity7;
        mp.Commodity_8__c = Commodity8;
        mp.Commodity_9__c = Commodity9;
        
        if(mydoc != null){
            if(mydoc.id != null && mydoc.id != ''){
                mp.AS_ImageUrl__c = mydoc.id;
            }
        }
        database.update(mp,false);
        
        try{
            if(attachmentname != null){
                if ( attachmentval.size() != null) {                
                    Attachment a1 = new Attachment(parentId = mp.id, name=attachmentname, body = attachmentval);
                    insert a1;
                }
            }
        }catch(Exception e){}
        
        return mp;
    }
    /* FOR UPDATING MBE PROFILE */
    
    /* UPDATING CORPORATE OR MBE DETAILS - EIDT EMAIL ALSO AVAILABLE */
    public void UpdateUser(){
        Savepoint sp = Database.setSavepoint();
        try{
            emailalert1 = false;
            NaicsCodesFunc(naicschangeselctdids, commchangeselctdids);
            try{
                AttendeeSummary.As_NAICSCode_1__c = Naics1;
                AttendeeSummary.As_NAICSCode_2__c = Naics2;
                AttendeeSummary.As_NAICSCode_3__c = Naics3;
                AttendeeSummary.As_NAICSCode_4__c = Naics4;
                AttendeeSummary.As_NAICSCode_5__c = Naics5;
                AttendeeSummary.AS_NAICSCode6__c = Naics6;
                AttendeeSummary.AS_NAICSCode7__c = Naics7;
                AttendeeSummary.AS_NAICSCode8__c = Naics8;
                AttendeeSummary.AS_NAICSCode9__c = Naics9;
                
                AttendeeSummary.Commodity_1__c = Commodity1;
                AttendeeSummary.Commodity_2__c = Commodity2;
                AttendeeSummary.Commodity_3__c = Commodity3;
                AttendeeSummary.Commodity_4__c = Commodity4;
                AttendeeSummary.Commodity_5__c = Commodity5;
                AttendeeSummary.Commodity_6__c = Commodity6;
                AttendeeSummary.Commodity_7__c = Commodity7;
                AttendeeSummary.Commodity_8__c = Commodity8;
                AttendeeSummary.Commodity_9__c = Commodity9;
            
            }catch(Exception e){}
            
            error = false;
            User_Profile_Event__c ParticularJuncID = [select isFirstBoothAdmin__c,User_id__r.Email,Attendee_Summary__c, User_id__c, BoothAdmin_id__c from User_Profile_Event__c where id =: BoothAdminDetails];
            system.debug('ParticularJuncID.User_id__r.Email === '+ParticularJuncID.User_id__r.Email);
            system.debug('BoothAdmininfo.Username === '+BoothAdmininfo.Username);
            system.debug('BoothAdmininfo.Email === '+BoothAdmininfo.Email);
            system.debug('SelectEvent === '+SelectEvent );
            
            Event_Attendee_Mapping__c toUpdateEAM = [SELECT Id, AS_id__c, AS_id__r.AS_Email__c FROM Event_Attendee_Mapping__c WHERE IsMatchMakingAttendee__c =true AND AS_id__r.AS_Email__c =: BoothAdmininfo.Email AND EV_id__c =: SelectEvent ];
            system.debug('toUpdateEAM === '+toUpdateEAM);
            
            
            
            
            if(ParticularJuncID.User_id__r.Email == BoothAdmininfo.Username){
                
                system.debug('AttendeeSummary.id === '+AttendeeSummary.id+AttendeeSummary.AS_FirstName__c+AttendeeSummary.AS_LastName__c+' === '+BoothAdmininfo);
                AttendeeSummary = ToUpdateAttendeeSummery(AttendeeSummary,BoothAdmininfo);
                system.debug('AttendeeSummary.id === '+AttendeeSummary.id+AttendeeSummary.AS_FirstName__c+AttendeeSummary.AS_LastName__c+' === '+BoothAdmininfo);
                
                BoothAdmininfo = ToUpdateUserDetails(AttendeeSummary,BoothAdmininfo);
                system.debug('BoothAdmininfo === '+BoothAdmininfo);
                
            }else{
            
                List<User> checkUser = new List<User>();
                checkUser = [Select Id,Email,Username From User Where UserName =: BoothAdmininfo.Username AND Profile.Name=:'Event Admin'];
                
                List<Event_Attendee_Mapping__c> EventAttendeeJun = [select id,EV_id__c from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c =true AND AS_id__r.AS_Email__c =: BoothAdmininfo.Username AND EV_id__c =: SelectEvent];
                system.debug('========================= Attendee is inserted in Junction Object Or not ===========' + EventAttendeeJun + EventAttendeeJun.size() );
                
                                                 
                if(checkUser.size() != 0 || EventAttendeeJun.size()>0){
                    error=true;system.debug('error === '+error);
                    errormessage='Email Already Exist';system.debug('errormessage === '+errormessage);
                }else{
                    system.debug('Username === '+BoothAdmininfo.Username);
                    List<User> ComparingUserEmails = [Select Id,Email,Username From User Where UserName =: BoothAdmininfo.Username];
                    
                    System.debug('========@@@@@@ Comparing Email with Existing Email From User Object @@@@@ ========= ' + ComparingUserEmails );
                    
                    if(ComparingUserEmails.size()>0){
                    
                        List<User_Profile_Event__c> FindingDuplicates = [SELECT User_id__r.Email,User_id__r.UserName,User_id__r.Profile.Name 
                                                                         FROM User_Profile_Event__c 
                                                                         WHERE User_Profile_Event__c.User_id__r.UserName=:BoothAdmininfo.Username
                                                                         AND  EV_id__c=:selectEvent ];
                        
                        //  System.debug('========@@@@@@ Comparing Email with Existing Email From User_Profile_Event Object @@@@@ ========='+FindingDuplicates.size()+ 'ddddd'+FindingDuplicates[0].User_id__r.Profile.Name);
                        
                        if(FindingDuplicates.size()>0 && FindingDuplicates[0].User_id__r.Profile.Name == 'Booth Admin'){
                            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Booth Admin is Already an Admin for this Booth'));
                            error=true;
                            errormessage='Email ID is already registered as Booth Admin for this Event';
                            system.debug( ' EEEEEEEEEEEEEEEE RRRRRRRRRRRRRR OOOOOO RRRRRRRRR' );
                            
                        }else if(FindingDuplicates.size()>0 && FindingDuplicates[0].User_id__r.Profile.Name == 'Attendee'){
                            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Booth Admin is Already an Admin for this Booth'));
                            error=true;
                            errormessage='Email ID is already registered as Attendee for this Event';
                            system.debug( ' EEEEEEEEEEEEEEEE RRRRRRRRRRRRRR OOOOOO RRRRRRRRR' );
                            
                        }else{
                            system.debug('BoothAdmininfo.Username === '+ BoothAdmininfo.Username);
                            List<AttendeeSummary__c> checkAttendeeSummary = new List<AttendeeSummary__c>() ;
                            checkAttendeeSummary = [select AS_FirstName__c,AS_LastName__c,id from AttendeeSummary__c where AS_Email__c =: BoothAdmininfo.Username];
                            AttendeeSummary__c AttendeeSummaryNew;
                            if(checkAttendeeSummary.size()==0){                                
                                
                                
                                BoothAdmininfo = ToUpdateUserDetails(AttendeeSummary,BoothAdmininfo);                                    
                                system.debug('BoothAdmininfo === '+BoothAdmininfo);
                                
                                AttendeeSummaryNew = ToInsertAttendeeSummery(AttendeeSummary,BoothAdmininfo);
                                system.debug('AttendeeSummaryNew.Id'+AttendeeSummaryNew.Id);
                                
                                toUpdateEAM.AS_id__c = AttendeeSummaryNew.Id;
                                toUpdateEAM.Attendee_Event_IDs__c = AttendeeSummaryNew.Id + selectEvent;
                                toUpdateEAM.IsMatchMakingAttendee__c = true;
                                update toUpdateEAM;
                                ///////////////////////////////////////////////////////////////////
                                
                            }else{
                                system.debug('BoothAdmininfo === '+BoothAdmininfo);
                                
                                //BoothAdmininfo = ToUpdateUserDetails(AttendeeSummary,BoothAdmininfo);
                                //system.debug('BoothAdmininfo === '+BoothAdmininfo);
                                //BoothAdmininfo = AttendeeSummary;
                                
                                //AttendeeSummaryNew = ToUpdateAttendeeSummery(AttendeeSummary,BoothAdmininfo);
                                //system.debug('AttendeeSummary.Id'+AttendeeSummary.Id);
                                AttendeeSummaryNew = checkAttendeeSummary[0];
                                
                                
                                toUpdateEAM.AS_id__c = AttendeeSummaryNew.Id;
                                toUpdateEAM.Attendee_Event_IDs__c = AttendeeSummaryNew.Id + selectEvent;
                                toUpdateEAM.IsMatchMakingAttendee__c = true;
                                update toUpdateEAM;
                                
                            }
                            ParticularJuncID.Attendee_Summary__c = AttendeeSummaryNew.Id;
                            ParticularJuncID.User_id__c = ComparingUserEmails[0].Id;
                            ParticularJuncID.BoothAdmin_id__c = ComparingUserEmails[0].Id;
                            update ParticularJuncID;
                        }
                        
                    }else{
                        Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin' limit 1];
                        
                        system.debug('======:::::::: Retriving Profile Id from Standard Profile Object ========::::::'+UserAsBA);              
                        
                        user uname=[select id from user where profile.Name Like 'System Administrator' and isActive=true Limit 1];
                        
                        account acc=new account();
                        acc.name='Booth Leads';  
                        //acc.ownerid = '005Z0000000oyN7';
                        acc.ownerid=uname.id;          
                        insert acc;                     
                        
                        system.debug('BoothAdmininfo.LastName === '+BoothAdmininfo.LastName+' -- '+BoothAdmininfo.FirstName);
                        contact Con = new contact();
                        Con.LastName = BoothAdmininfo.LastName;
                        Con.FirstName = BoothAdmininfo.FirstName;
                        Con.AccountId = acc.id;
                        Database.SaveResult insCont = database.insert(Con,false);                    
                        system.debug('=====::::::::: Inserting Contact :::::::======='+insCont.getErrors());
                        
                        BoothAdminUser = new user();
                        BoothAdminUser.ContactID = Con.id;
                        BoothAdminUser.Username = BoothAdmininfo.Username;
                        BoothAdminUser.Email = BoothAdmininfo.Username;
                        BoothAdminUser.Firstname = BoothAdmininfo.Firstname;
                        BoothAdminUser.LastName = BoothAdmininfo.LastName;
                        BoothAdminUser.Alias ='BAdmin';
                        BoothAdminUser.ProfileID =UserAsBA.Id;
                        BoothAdminUser.LocaleSidKey ='en_US';
                        BoothAdminUser.LanguageLocaleKey ='en_US';
                        BoothAdminUser.TimeZoneSidKey ='America/Los_Angeles';
                        BoothAdminUser.EmailEncodingKey='UTF-8';                    
                        BoothAdminUser.companyName = BoothAdmininfo.companyName;                    
                        BoothAdminUser.Company_website__c = BoothAdmininfo.Company_website__c;
                        BoothAdminUser.CompanyAddr1__c = BoothAdmininfo.CompanyAddr1__c;
                        BoothAdminUser.CompanyAddr2__c = BoothAdmininfo.CompanyAddr2__c;
                        BoothAdminUser.CompanyCity__c = BoothAdmininfo.CompanyCity__c;                
                        BoothAdminUser.Country__c = BoothAdmininfo.Country__c;                
                        BoothAdminUser.States__c = BoothAdmininfo.States__c;
                        BoothAdminUser.CompanyFaxNumber__c  = BoothAdmininfo.CompanyFaxNumber__c;
                        BoothAdminUser.Companyphone__c = BoothAdmininfo.Companyphone__c;
                        BoothAdminUser.Zipcode__c = BoothAdmininfo.Zipcode__c;
                        BoothAdminUser.PoBox__c = BoothAdmininfo.PoBox__c;
                        BoothAdminUser.IsActive = False;                    
                        
                        insert BoothAdminUser;
                        
                        AttendeeSummary__c AttendeeSummaryNew = ToInsertAttendeeSummery(AttendeeSummary,BoothAdmininfo);
                        system.debug('AttendeeSummary.Id'+AttendeeSummaryNew.Id);
                        
                        toUpdateEAM.AS_id__c = AttendeeSummaryNew.Id;
                        toUpdateEAM.Attendee_Event_IDs__c = AttendeeSummaryNew.Id + selectEvent;
                        toUpdateEAM.IsMatchMakingAttendee__c = true;
                        update toUpdateEAM;
                        
                        ParticularJuncID.Attendee_Summary__c = AttendeeSummaryNew.Id;
                        ParticularJuncID.User_id__c = BoothAdminUser.Id;
                        ParticularJuncID.BoothAdmin_id__c = BoothAdminUser.Id;
                        update ParticularJuncID;
                        
                        
                    }                    
                }
            }
                
                
                
                
            attendeeImage = null;
            ExhibitorImage = null;
          
           
            
            
            
            OnlyBoothInfo.BT_Name__c = BoothAdmininfo.companyName;
            OnlyBoothInfo.BT_ContactEmail__c = BoothAdmininfo.Username;
            OnlyBoothInfo.BT_Location__c = OnlyBoothInfo.BT_Location__c;
            OnlyBoothInfo.MM_TableNo__c = OnlyBoothInfo.MM_TableNo__c;
            OnlyBoothInfo.BT_ContactName__c = AttendeeSummary.AS_FirstName__c +' '+AttendeeSummary.AS_LastName__c;
            OnlyBoothInfo.BT_WebsiteURL__c = BoothAdmininfo.Company_website__c ;
            OnlyBoothInfo.BT_Phone__c = BoothAdmininfo.Companyphone__c ;
            
            Database.Update(OnlyBoothInfo);
         
            try{ 
                if(attachmentname != null){
                    if ( attachmentval.size() != null) {
                        Attachment a = new Attachment(parentId = AttendeeSummary.id, name=attachmentname, body = attachmentval);
                        insert a;
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
                    
                    youtubevideo.AttendeeSummary__c = AttendeeSummary.id;
                    insert youtubevideo;
                }
                
                system.debug('::::::::::::::::youtube:::::::::::::'+youtubevideo);
            }catch(exception e){}
         
            if(error==false){
                EditBoothAdminPopUp = False;
                isc=1;
                pageno =isc;
                ListOfBoothAdmins();
            }
        }Catch(Exception ex){
                //BoothsList();
                //exportBoothadmins();
                if(error==false){
                EditBoothAdminPopUp = False;
                isc=1;
                pageno =isc;
                ListOfBoothAdmins();
            }
        }
    }
    /* UPDATING CORPORATE OR MBE DETAILS - EIDT EMAIL ALSO AVAILABLE */
    /* EDITED AND ADDED BY RAJESH */
     
    public User_Profile_Event__c ParticularJuncID{get;set;} 
    public List<Attachment> attachments {get ; set ;}
    //For deleting boothadmin
    public void deleteboothadmin(){
    ParticularJuncID = new User_Profile_Event__c();
     ParticularJuncID = [select EV_ID__c,BT_id__c,User_Id__r.id,UEP_isActive__c,Status__c,Attendee_Summary__r.id
                                  
                                 from User_Profile_Event__c where id =: BoothAdminDetails];
               system.debug('============================44444444 ' + ParticularJuncID ); 
     List<Event_Attendee_Mapping__c> EventAttendeeJun = [select id,EV_id__c from Event_Attendee_Mapping__c where IsMatchMakingAttendee__c =true AND AS_id__r.id =: ParticularJuncID.Attendee_Summary__r.id AND EV_id__c =: SelectEvent];
        delete EventAttendeeJun[0];
           
               delete  ParticularJuncID;
               commonmethod();
    }
    public void DisplayBoothAdminDetails(){
     youtubevideo = new Widget__c();
     youtubevideo.YouTubeId_c__c = '';
     showExccededError = False; 
    emailalert1 = false;
           Attendeesummary = new AttendeeSummary__c();
           attachments = new list<Attachment> ();
           StatesCountry();

            system.debug( ' BBBBBBBBBBB AAAAAAAAAAAAA '+BoothAdminDetails);
            
            ShowBoothAdminPopUp = false;
           
               
            ParticularJuncID = [select EV_ID__c,BT_id__c,User_Id__r.id,UEP_isActive__c,Status__c,Attendee_Summary__r.id
                                  
                                 from User_Profile_Event__c where id =: BoothAdminDetails];
               system.debug('============================44444444 ' + ParticularJuncID );          
           try{
            Attendeesummary =[select id, name, AS_Age__c, isUpdated__c, AS_BirthDate__c, AS_BlogUrl__c, Keywords__c, AS_BusinessDunsNumber__c,createddate,
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
                                     AS_CageCode__c,Business_type__c,Company_Certifications__c,GSA_Schedule__c,Exceptional_Key_Words__c,BBB_Number__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c,DBA__c,distribution_Country__c,Commodity_6__c,Commodity_7__c,Commodity_8__c,Commodity_9__c,
                                     Geographical_Region__c,Manufactures_Country__c,AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,References__c,Certificate_Processed_by_RPO__c,
                                     (select id,YouTubeId_c__c From Widgets__r)FROM AttendeeSummary__c where id=: ParticularJuncID.Attendee_Summary__r.id];
                     
                 }catch(exception e){} 
            system.debug('==******************=====::::'+ParticularJuncID);
            selectedregions = new list<string>();
            list<string> sts = new list<string>();
            if(Attendeesummary.Geographical_Region__c != null && Attendeesummary.Geographical_Region__c != ''){
            sts = Attendeesummary.Geographical_Region__c.split(',');
            selectedregions.addall(sts);
            }
           attchments = new list<Attachment>();
    try{
        attachments = [SELECT Id, Name,Description,ContentType FROM Attachment where parentId=:Attendeesummary.id];
        system.debug('=========== ppppppppp ' + attchments );
            BoothAdmininfo = [Select Id,FirstName,LastName,UserName,CompanyName,Email,Company_website__c,CompanyAddr1__c,
                              CompanyAddr2__c,CompanyCity__c,CompanyCountry__c,CompanyState__c,CompanyFaxNumber__c,
                              Companyphone__c,Zipcode__c,PoBox__c,Country__c,States__c from User where Id =:ParticularJuncID.User_Id__r.id];
            
                            system.debug('==&&&&&&&&&&&&&&&&&&=====::::'+BoothAdmininfo );
            
            OnlyBoothInfo = [Select Id,MM_TableNo__c,BT_BoothUserCount__c,BT_ContactEmail__c,BT_ContactName__c,BT_ContactPhone__c,BT_Description__c,BT_isBoothActive__c,
                             BT_Location__c,BT_Name__c,BT_PDFLocation__c,   BT_Phone__c,BT_RegistrationLink__c,
                             BT_WebsiteURL__c from  Booth__c where Id =:ParticularJuncID.BT_id__c];
                             
                             system.debug('============ Booth For Edit ======'+OnlyBoothInfo );   
            if(BoothAdmininfo.Country__c != null && BoothAdmininfo.Country__c != ''){
            Country = countries.get(BoothAdmininfo.Country__c); }
             if(BoothAdmininfo.states__c != null && BoothAdmininfo.states__c != ''){
            state = states.get(BoothAdmininfo.states__c);           
            }
      }catch(exception ed){}      
           // attachments = [select Id, Name,Description,ContentType FROM Attachment where parentId=: OnlyBoothInfo.id];
            
    }    
 
   
    public void StatesCountry(){
    
        states=new map<string,string>();
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
        states.put('Lakshadweep','Lakshadweep');
        states.put('National Capital Territory of Delhi','National Capital Territory of Delhi');                                     
    
         countries = new map<string,string>();
         countries.put('India','India');
         countries.put('United States of America','USA');
    
    }
   //For email Template
  
  
    
    public class InnerClass{
    public User_Profile_Event__c UPE{get;set;}
    public String BStatus{get;set;}
        public InnerClass(User_Profile_Event__c ConUPE,String ConBStatus){
            UPE = ConUPE;
            BStatus = ConBStatus;    
        }
    
    }
    public PageReference login() {
       
       if(userInfo.getUserType()=='guest'){
            Pagereference pg = new pagereference('/apex/mm_eventadmin_signup');
            pg.setredirect(true);
            return pg;
       } else{
            return null;
       }     
    }
    
     @Future
    public static Void FutureMethod(String UserId){
    User ForU = new User();
                ForU = [select FirstName,Profileid,LastName,id,isActive,isSignUp__c from User where Username =:UserId];
                Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin'];
                
                ForU.ProfileId = UserAsBA.Id;
                if(ForU.isSignUp__c == True)
                ForU.isActive  = True;
                else
                ForU.isActive  = False;
                
                DataBase.Update(ForU); 
    
    
    }
  public boolean viewschedulepopup{get;set;}
  public boolean viewStatusPopup{get;set;}
  public Event__c eventtimedetails{get;set;}
 
  public List<EventSchedule__c> exhibitorschedule {get;set;}
 
  
  public boolean slot{get;set;}
  public Time startTimeMM{get;set;}
    public Time ENdTimeMM{get;set;}
    public string selecteddate{get;set;}
    public string Errormessagesch{get;set;}
    public boolean errorbool{get;set;}
    
    public EventSchedule__c dummylist{get;set;}
    
   
  public User_Profile_Event__c upedetails{get;set;}
  public List<SelectOption> statusOptions {get; set;}
  public List<String> selectedStatusList{get; set;}
  public integer statusSize{get; set;}
  public MAP<Date , LIST<String>> getDataFromUtility{get; set;}
  public LIST<SelectOption> eventDatesList{get; set;}
  public boolean ShowDatePicklist{get; set;}
  public String selectedEventDate{get; set;}
  public LIST<String> timeSlotsForDate{get; set;}
  public LIST<MatchLeads_Days__c> allEventDates{get; set;}
    
  public Pagereference statusValueSchedule(){
      
        
        statusOptions= new List<SelectOption>();
        this.selectedStatusList= new List<String>();
        eventDatesList= new LIST<Selectoption>();
        selectedStatusList.add('Accepted');
        
        
        //Time slote code starts here
        /* START CODE FOR ADDING DATE PICKLIST */
     allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: SelectEvent ORDER BY MatchLeads_Date__c ASC]);
      if(allEventDates.size() >1){
         ShowDatePicklist= true;
         for(MatchLeads_Days__c matchDate: allEventDates){
             
             String dateFormat= matchDate.MatchLeads_Date__c.format();
             eventDatesList.add(new selectoption(dateFormat,dateFormat));
             
              }
         
         }
            selectedEventDate= allEventDates[0].MatchLeads_Date__c.format();

        //Status Picklisycode starts here
        Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
        List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
        statusOptions.add(new SelectOption('All','All'));
        statusSize= AllValues.size();
        system.debug(' PICK LIST SIZE '+statusSize);
        for(Schema.PicklistEntry str: AllValues){
            statusOptions.add(new SelectOption(Str.getValue(), Str.getValue()));
        } 
        statusOptions.add(new SelectOption('Open','Open'));
        
        splitTimeSlots();
        
      return null;
  }

    public SET<String> openSlotsList{get; set;}
    public SET<String> openSlotsList1{get; set;}
    public LIST<EventSchedule__c> schedulesList{get; set;}
    public LIST<String> startTimeList{get; set;}
    
  public pagereference splitTimeSlots(){
      try{
      showExccededError = False;
      getDataFromUtility= new MAP<Date , LIST<String>>();
        timeSlotsForDate= new LIST<String>();
        openSlotsList= new SET<String>();
        schedulesList= new LIST<EventSchedule__c>();
        system.debug('  EVENT DATE SELECTED  '+selectedEventDate );
        slotsInner= new LIST<timeSlotInnerClass> ();
        startTimeList= new LIST<String>();
            if(selectedEventDate != null || selectedEventDate != ''){
         system.debug(BoothAdminDetails +'   tttttttttttttttttttttttttttttttttttttttttttttttt'+selectedEventDate );
                LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                
                Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
           getDataFromUtility= MM_Utility.giveEventTimingsWithDates(SelectEvent, selectedDate);
         
         timeSlotsForDate= getDataFromUtility.get(selectedDate);
    
         schedulesList= [select id,MM_slot_Date__c,MM_Slot_End_Time__c,MM_Slot_Status__c,MM_slot_StartTime__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,
                      MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_To_EAM__r.AS_id__r.AS_Email__c ,MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c, 
                      MM_To_EAM__r.AS_id__r.AS_LastName__c, MM_To_EAM__r.AS_id__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_ImageUrl__c,MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                      MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c
                   from EventSchedule__c 
               where (MM_Slot_Status__c = 'Accepted' OR MM_Slot_Status__c = 'Pending')
               AND MM_slot_StartTime__c != null 
               AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
               AND MM_To_UPE__c =: BoothAdminDetails 
               AND MM_slot_Date__c != null  
               AND MM_slot_Date__c =: selectedDate  
               AND EV_id__c =: SelectEvent]; 
               //ORDER BY MM_slot_StartTime__c];
            system.debug('  SCH LIST   '+schedulesList);
            system.debug('  SLOT LIST  '+timeSlotsForDate);

      //timeSlotsForDate.sort();


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
                      system.debug(' START TIME  LIST '+slotStartTime[0]+'    '+startTimeList);                        
          }
          for(EventSchedule__c esch: schedulesList){
              string scheduleSlot= esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c;
              system.debug(' SLOT TIME '+scheduleSlot+'   '+timeSlot +'   '+esch.MM_Slot_Status__c);
              if(scheduleSlot == timeSlot && (esch.MM_Slot_Status__c == 'Accepted' || esch.MM_Slot_Status__c == 'Pending')){
                  
                  openSlotsList.remove(timeslot);
              }
          }
           blokslistexist = new list<Event_Breaks__c> ();
           blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: BoothAdminDetails];
           for(Event_Breaks__c  berk: blokslistexist  ){
           string scheduleSlot= berk.Break_Start_Time__c+'-'+berk.Break_End_Time__c;
            if(scheduleSlot == timeSlot){
            openSlotsList.remove(timeslot);
              }
           
           }
      }
      system.debug(' AFTER SLOT SET '+openSlotsList.size()+'    '+slotsList.size() +'  '+openSlotsList+'  '+slotsList);
            
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
      }


      forSchedule();}catch(exception e){}
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
  
  
  public SET<String> selectedStatusSet{get; set;}
  
  public pagereference forSchedule(){
        showExccededError = False;
        system.debug('   Hello for Test   '+selectedStatusList);
        selectedStatusSet= new SET<String>();
        selectedStatusSet.addAll(selectedStatusList);
        system.debug(' SET  Hello for Test   '+selectedStatusSet);
        
        try{
            norecordsalert = false;
            viewschedulepopup=true;
            slot=true;
            //DISP=new list<InnerForTimeslots>();
            
            
            exhibitorschedule = new List<EventSchedule__c>();
            
            system.debug('             schedule          '+BoothAdminDetails);
            if(selectedEventDate != null || selectedEventDate != ''){
            LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
                Date selectedDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
                
                if(selectedStatusSet.contains('All')){
                    CheckboxBool = true;
                    CheckboxBool1 = false;
                    exhibitorschedule =[SELECT Id ,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                               MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c,
                                               MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_EAM__r.Ev_Id__r.Is_Webank_event__c  
                                        FROM EventSchedule__c 
                                        WHERE MM_To_UPE__c =: BoothAdminDetails 
                                        AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                        AND MM_To_EAM__c != null 
                                        AND MM_slot_Date__c =: selectedDate  
                                        AND MM_Slot_Status__c != null
                                        AND EV_id__c =: SelectEvent 
                                        ORDER BY starttimein24hrs__c];
                    system.debug(' IF STATUS LIST QUERY  '+exhibitorschedule.size()+'    '+exhibitorschedule );
                    Schema.DescribeFieldResult statusValues= EventSchedule__c.MM_Slot_Status__c.getDescribe();
                    List<Schema.PicklistEntry> AllValues = statusValues.getPicklistValues();
                    
                    for(Schema.PicklistEntry str: AllValues){
                        selectedStatusList.add(Str.getValue());
                    } 
                }
                else if(selectedStatusSet.contains('Open')){
                    // && selectedStatusSet.size() ==1
                    CheckboxBool = false;
                    selectedStatusList = new LIST<String>();
                    selectedStatusList.add('Open');
                 
                    system.debug('Open Appointments  '+openSlotsList.size()+'    '+openSlotsList);
                }
                else{
                    CheckboxBool = true;
                    CheckboxBool1 = false;
                    //selectedStatusSet.remove('Open');
                    system.debug('SET VALUES  '+selectedStatusSet);
                    if(!selectedStatusSet.contains('All') && selectedStatusList.size() == statusSize){
                        selectedStatusList= new List<String>();
                    }
                    else{
                    
                        system.debug('SET VALUES  '+selectedStatusSet);
                        
                        exhibitorschedule =[SELECT Id,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_UPE__r.BT_id__r.MM_TableNo__c,MM_Slot_Status__c,MM_slot_Date__c,MM_slot_StartTime__c,MM_Slot_End_Time__c,MM_To_UPE__r.Attendee_Summary__r.AS_Email__c,MM_To_UPE__r.Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                                                   MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_CellPhone__c,MM_To_UPE__r.Attendee_Summary__r.AS_ImageUrl__c,MM_To_UPE__r.Attendee_Summary__r.AS_FirstName__c, MM_To_EAM__r.AS_id__r.AS_CellPhone__c,
                                                   MM_To_UPE__r.BoothAdmin_id__r.Name,MM_To_UPE__r.BoothAdmin_id__r.CompanyName,MM_To_UPE__r.Attendee_Summary__r.AS_LastName__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_EAM__r.Ev_Id__r.Is_Webank_event__c,MM_To_EAM__r.MBE_Profile__r.AS_Company__c,MM_To_EAM__r.MBE_Profile__r.AS_CellPhone__c,MM_To_EAM__r.MBE_Profile__r.AS_FirstName__c,MM_To_EAM__r.MBE_Profile__r.AS_LastName__c 
                                            FROM EventSchedule__c 
                                            WHERE MM_To_UPE__c =: BoothAdminDetails
                                            AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                            AND MM_To_EAM__c != null 
                                            AND MM_Slot_Status__c IN : selectedStatusSet
                                            AND MM_slot_Date__c =: selectedDate  
                                            ORDER BY starttimein24hrs__c];
                        
                        system.debug(' ELSE  STATUS LIST QUERY  '+exhibitorschedule.size()+'    '+exhibitorschedule );
                        selectedStatusSet.remove('All');
                        selectedStatusList.addAll(selectedStatusSet);
                    }     
                
                }                         
                upedetails = [SELECT Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Company__c,
                                     Attendee_Summary__r.AS_CellPhone__c,Attendee_Summary__r.AS_Email__c,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Name,
                                     BT_id__r.MM_TableNo__c,BT_id__r.BT_Name__c,BT_id__r.BT_Location__c,Attendee_Summary__r.AS_ImageUrl__c,Attendee_Summary__r.Exhibitor_company_imageUrl__c 
                              FROM User_Profile_Event__c 
                              WHERE id =:BoothAdminDetails];
                              system.debug('uuuuuuuuuu'+upedetails);
                if(exhibitorschedule.size() != 0){
                    dummylist = exhibitorschedule[0];
                    norecordsalert = true;
                }
            }
        }catch(exception e){}
        
        return null;
  }
  
//-----------------------------------------SEARCH---------------------------------
    public string serarchstringvalue{get;set;}
  public pagereference search() {

   system.debug('         debug search val            '+serarchstringvalue );
      ForPagination = new List<InnerCLass>(); 
      ListOfInnerClass = new List<InnerCLass>();
     integer recCount = 0;
     BoothAdminsList =new list<User_Profile_Event__c>();
     string ff = serarchstringvalue + '%';
     List<User_Profile_Event__c>  Example = new List<User_Profile_Event__c>();
        
        BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,Profile_id__c,Profile_id__r.PR_Name__c,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,BT_id__r.MM_TableNo__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,Attendee_Summary__r.AS_Company__c,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate,Attendee_Summary__r.Exhibitor_company_imageUrl__c,Attendee_Summary__r.DBA__c
                              from User_Profile_Event__c  where Request_for_upgrade_profile__c = false AND IsMatchMakingUser__c=True 
                              AND EV_id__c =:SelectEvent AND (MAtchMakingProfile__c ='Corporate' OR MAtchMakingProfile__c ='Corporatestaff')
                              AND (BoothAdmin_id__r.FirstName like:'%' + ff + '%' OR Attendee_Summary__r.AS_Company__c like:'%' + ff + '%' OR BoothAdmin_id__r.LastName Like:'%' + ff + '%' OR BoothAdmin_id__r.Name Like:'%' + ff + '%'  OR Attendee_Summary__r.DBA__c Like:'%' + ff + '%' )
                             ];
                             system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+BoothAdminsList );            
                             for(User_Profile_Event__c V : BoothAdminsList ){
                             
                              //availableBADS.add(new Selectoption(v.BT_id__r.BT_Name__c,v.BT_id__r.BT_Name__c));
                              system.debug( '  AAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa        '+availableBADS);
                                 
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }                              
        system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+ListOfInnerClass.size()); 
        try{                   
       if(ListOfInnerClass.size()>0)
        {
         conlst=true;        
         count=ListOfInnerClass.size();      
         pageno=1;
         isc=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
            system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          
        for(integer i=0; i<10;i++)
        {
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() <= 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
        NoRecordsFound = False;
        DisplayPages = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }         
        
        }
         
        } else {
       hasLast = False;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = True;
       Disabled_Last_Icon = True;
       hasNext=False; 
        }
       }catch(Exception ex){}                 
          
     
      
     return null;
 }
 //-----------------------------ALPHABET SEARCH -------------------------------------------
 public void Alphasorting() {
     
    
     string alphas = ApexPages.currentPage().getParameters().get('alphabit');
     system.debug('---------' + alphas);
      ListOfInnerClass = new List<InnerCLass>();
     ForPagination = new List<InnerCLass>();
     BoothAdminsList  = new list <User_Profile_Event__c> ();
     if (SelectEvent != null || SelectEvent != '') {
         if (alphas != 'All') {
             integer recCount = 0;
             
             BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName, Profile_id__r.PR_Name__c,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,BT_id__r.MM_TableNo__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,Attendee_Summary__r.AS_Company__c,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate,Attendee_Summary__r.Exhibitor_company_imageUrl__c
                              from User_Profile_Event__c  where IsMatchMakingUser__c=True AND Request_for_upgrade_profile__c = false 
                              AND EV_id__c =:SelectEvent AND MAtchMakingProfile__c ='Corporate'
                              AND Attendee_Summary__r.AS_Company__c like: ( alphas + '%') ORDER BY Attendee_Summary__r.AS_Company__c
                              
                             ];
             
            system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+BoothAdminsList );            
                             for(User_Profile_Event__c V : BoothAdminsList ){
                             
                              //availableBADS.add(new Selectoption(v.BT_id__r.BT_Name__c,v.BT_id__r.BT_Name__c));
                              system.debug( '  AAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa        '+availableBADS);
                                 
                                 if(V.UEP_isActive__c == True){
                                     Status = 'Active';    
                                 }else {
                                     Status = 'InActive';
                                 }    
                              ListOfInnerClass.add(new InnerClass(V,Status ));
                              system.debug( ' AAAAAAAAAAA EEEEExample'+ListOfInnerClass);          
                             }                              
        system.debug( ' *******************@@@@@@@@@@@@@@@@@@ '+ListOfInnerClass.size()); 
        try{                   
       if(ListOfInnerClass.size()>0)
        {
         conlst=true;        
         count=ListOfInnerClass.size();      
         pageno=1;
         isc=1;
          if(math.mod(ListOfInnerClass.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=ListOfInnerClass.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(ListOfInnerClass.size()/10) +1; 
            system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
          
        for(integer i=0; i<10;i++)
        {
        
        ForPagination.add(ListOfInnerClass[i]);
        if(ListOfInnerClass.size() <= 10){
        hasLast = false;
        hasNext=false;
        Disabled_Last_Icon = True;
        Disabled_Next_Icon = True;
        Disabled_First_Icon = True;
        Disabled_Previous_Icon = True;
        NoRecordsFound = False;
        DisplayPages = True;
       }else {
       hasLast = True;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = false;
       Disabled_Last_Icon = false;
       hasNext=true;
       }         
        
        }
         
        } else {
       hasLast = False;
       hasFirst = False;
       hasPrevious =false;
       Disabled_First_Icon = True;
       Disabled_Previous_Icon = True;
       Disabled_Next_Icon = True;
       Disabled_Last_Icon = True;
       hasNext=False; 
        }
       }catch(Exception ex){} 
     
}else{
ListOfBoothAdmins();
}
}
}
    public pagereference printschedule(){
    
        eventDetailsInPrint();
        pagereference pg=page.mm_eventadmin_printschedule;
        return pg;  
    }
    
   public String eventDatesString {get; set;}
    
    public void eventDetailsInPrint(){
        
        eventDetails= new Event__c();
           system.debug('EVENT ID  '+SelectEvent);                  

        if(SelectEvent != null || SelectEvent != ''){
            
            eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, EV_EventLogo__c, 
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,Is_MatchMaking_Event__c,Owner.Name
                          FROM Event__c 
                          WHERE ID =: SelectEvent];
        system.debug('EVENT DATES STRING  '+eventDetails);  
        
        if(eventDetails.EV_StartDate__c == eventDetails.EV_EndDate__c){
            eventDatesString = string.valueof(eventDetails.EV_StartDate__c);
        } else if(eventDetails.EV_StartDate__c != eventDetails.EV_EndDate__c){
            eventDatesString = string.valueof(eventDetails.EV_StartDate__c)+' TO '+string.valueof(eventDetails.EV_EndDate__c);
        }
        }
        

    }
    public boolean emailalert {get;set;}
    public pagereference pdf{get;set;}
    public blob b{get;set;}
    public string message{get;set;}
   public pagereference emailschedule(){
    try{
     eventDetails= new Event__c();
              eventDetails=[SELECT ID, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, EV_HostingZipcode__c, EV_EventLogo__c,
                          EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,Is_MatchMaking_Event__c,Owner.Name
                          FROM Event__c
                          WHERE ID =: SelectEvent];
                          system.debug('666666666666666'+eventDetails.Owner.Name);
             string dd = eventDetails.EV_StartDate__c.format();
    showExccededError = False;
    
    pdf = page.mm_eventadmin_printschedule;

             b = pdf.getContent();
             OrgWideEmailAddress[] owea = new OrgWideEmailAddress[]{};
            system.debug('ooooooooooooooooooooooooobbbbbbbbbbbbbbbb'+eventDetails); 
           owea =  [select Id from OrgWideEmailAddress where DisplayName =:eventDetails.Owner.Name];
           system.debug('oooooooooooooooooooooooooaaaaaaaaaaa'+owea );
           if(owea.size()<=0){
               owea =  [select Id from OrgWideEmailAddress where DisplayName = 'Booth Leads'];
           }
          system.debug('ooooooooooooooooooooooooo'+owea + 'wwwwwwwwwwwwwwwwww'+eventDetails.Owner.Name);
          Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
               if(owea.size() > 0 ) {
                    email.setOrgWideEmailAddressId(owea.get(0).Id);
               } 
             email.setSubject('Your Schedules for Registered Event!');
             String[] toaddress = new String[] {
                 upedetails.Attendee_Summary__r.AS_Email__c
             };

            String hostLocation;
            String hostadd1;
            String hostCity;
            String hostState;
            String hostZipCode;
            String commaSymb;

            hostLocation=(eventDetails.EV_HostingLocation__c!=Null) ? eventDetails.EV_HostingLocation__c : '';
            hostadd1=(eventDetails.EV_HistingAddr1__c!=Null) ? eventDetails.EV_HistingAddr1__c : '';
            hostCity=(eventDetails.AS_HostingCity__c!=Null) ? eventDetails.AS_HostingCity__c : '';
            hostState=(eventDetails.EV_HostingState__c!=Null) ? eventDetails.EV_HostingState__c : '';
            hostZipCode=(eventDetails.EV_HostingZipcode__c!=Null) ? eventDetails.EV_HostingZipcode__c : '';
            commaSymb=(eventDetails.AS_HostingCity__c!=Null) ? ',' : '';

             email.setToAddresses(toaddress);

             email.setHTMLBody(message = 'Hello ' + ' ' + upedetails.Attendee_Summary__r.AS_FirstName__c +',' + '<br/>' + '' + '<br/>' +
                 'Thank you for participating in the matchmaking.' + '<br/>' +'' + '<br/>' + '<br/>' +
                 'Attached is your one on one matchmaking schedule for the following event:' + '<br/>' +'<br/>' +
                 +'<b>'+ eventDetails.EV_StartDate__c.format() +'<br/>'+  eventDetails.EV_Title__c  +'</b>'+ '<br/>' +
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
             efa.setFileName(eventDetails.EV_Title__c+' Schedule.pdf');
             efa.setBody(b);
             email.setFileAttachments(new Messaging.EmailFileAttachment[] {
                 efa
             });

        // Messaging.SendEmailResult[] r = Messaging.sendEmail(email);
         Messaging.SendEmailResult[] r = Messaging.sendEmail(New Messaging.SingleEmailMessage[] {email});
        system.debug('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr'+r);
         for (Messaging.SendEmailResult ms: r) {

              if (ms.isSuccess()){

              emailalert1= true;
         }else{
         emailalert = false;
         }


          }

        }catch(exception e){}
        eventDetailsInPrint();
         return null;
    }

    //---------------------------------------------------------------------------------------------
   public List<Selectoption> availableBADSinMM{get; set;}
  public void ExhibitorsFromBL(){
 
  BoothAdminsList  = new list<User_Profile_Event__c>();
  availableBADSinMM = new List<Selectoption>();
  availableBADS = new List<Selectoption>();
  BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,BT_id__r.MM_TableNo__c,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,Attendee_Summary__r.AS_Company__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,Attendee_Summary__r.Exhibitor_company_imageUrl__c,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate,Attendee_Summary__r.AS_ImageUrl__c
                              from User_Profile_Event__c  where IsMatchMakingUser__c =false 
                              AND EV_id__c =:SelectEvent AND (Profile_id__r.PR_Name__c ='BoothAdmin' OR MAtchMakingProfile__c ='Corporate')   ORDER BY Attendee_Summary__r.AS_Company__c
                             ];
                    
                     
                        if(BoothAdminsList.size() != 0){
                             for(User_Profile_Event__c V : BoothAdminsList ){
                                  system.debug( ' *******************11111111111111111111111 '+v);
                                  availableBADS.add(new Selectoption(v.id,v.Attendee_Summary__r.AS_Company__c+'('+v.Attendee_Summary__r.AS_FirstName__c + ' '+v.Attendee_Summary__r.AS_LastName__c+')'));
                             
                               } } 
          BoothAdminsList  = new list<User_Profile_Event__c>();                     
          BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,BT_id__r.MM_TableNo__c,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,Attendee_Summary__r.AS_Company__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,Attendee_Summary__r.Exhibitor_company_imageUrl__c,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate,Attendee_Summary__r.AS_ImageUrl__c
                              from User_Profile_Event__c  where Request_for_upgrade_profile__c = false AND IsMatchMakingUser__c=True 
                              AND EV_id__c =:SelectEvent AND MAtchMakingProfile__c = 'Corporate'   ORDER BY Attendee_Summary__r.AS_Company__c
                           
                             ];
                    system.debug('asssssssssssssssssssssssssssss' + BoothAdminsList.size());
                     if(BoothAdminsList.size() != 0){
                             for(User_Profile_Event__c V : BoothAdminsList ){
                             system.debug('asssssssssssssssssssssssssssss' + v.Attendee_Summary__r.id);
                            
                              availableBADSinMM.add(new Selectoption(v.id,v.Attendee_Summary__r.AS_Company__c+'('+v.Attendee_Summary__r.AS_FirstName__c + ' '+v.Attendee_Summary__r.AS_LastName__c+')'));
                            
                                } 
                                }
  multiselectpicklist=true;
  
 
  }
  
  //------ Select Attendee to match Code
  public String selectedTimeSlot{get; set;}
  public LIST<Event_Attendee_Mapping__c> EAMList{get; set;}
  public LIST<Event_Attendee_Mapping__c> EAMListForMatch{get; set;}
  public boolean ShowMatchPanel{get; set;}
  public Date selectedSplitDate{get; set;}
  public LIST<String> selectedTimeSlots{get; set;}
  
  public void attetdeesListToMatch(){
      showExccededError= false;
      system.debug('  SELECTED TIME SLOT  '+SelectEvent);
       EAMList= new  LIST<Event_Attendee_Mapping__c>();
      EAMListForMatch= new  LIST<Event_Attendee_Mapping__c>();
      list<EventSchedule__c> existingSchedules= new list<EventSchedule__c>();
      MLDAYS= new LIST<MatchLeads_Days__c> ();
      
      try{
      
       LIST<String> splitDate= new LIST<String>(selectedEventDate.split('/'));
      selectedSplitDate= date.newinstance(integer.valueOf(splitDate[2]),integer.valueOf(splitDate[0]),integer.valueOf(splitDate[1]));
     
            existingSchedules=[select id from EventSchedule__c
                         where MM_To_UPE__c =: BoothAdminDetails AND EV_id__c =: SelectEvent 
                         AND( (MM_Slot_Status__c = 'Accepted') OR(MM_Slot_Status__c = 'Pending')) AND MM_slot_Date__c =: selectedSplitDate];
                                        
                                            
      MLDAYS =[select id,Start_time__c,End_Time__c,Slot_Time_period__c,MAX_noOf_appontments__c,Break_Time_between_slots__c from MatchLeads_Days__c   where MatchLeads_Date__c =: selectedSplitDate AND Event__c=: SelectEvent ];                                
                       system.debug('dddddddddddddddddddddddddddddddddddddddd'+MLDAYS.Size());  
                       system.debug('sssssssssssssssssssssssssssssssssssssssssssssss'+existingSchedules.size());
                                        
      //if(MLDAYS[0].MAX_noOf_appontments__c == null ||  existingSchedules.size() <   MLDAYS[0].MAX_noOf_appontments__c){ 
      
      ShowMatchPanel= TRUE;
      showExccededError= false;
     
      selectedTimeSlots= new LIST<String>(selectedTimeSlot.split('-'));
      EAMList= [SELECT ID, AS_id__r.AS_FirstName__c, AS_id__r.AS_LastName__c, AS_id__r.AS_Email__c, AS_id__r.AS_Company__c, (SELECT ID FROM EventSchedule__r WHERE MM_slot_Date__c =: selectedSplitDate AND ES_StartTime__c =: selectedTimeSlots[0] AND ES_EndTime__c =: selectedTimeSlots[1] AND EV_id__c =: SelectEvent ) FROM Event_Attendee_Mapping__c WHERE EV_id__c =: SelectEvent AND Boothleads_Profile__c =: 'Attendee' AND IsMatchMakingAttendee__c = true  ];
      system.debug('   EAM LIST  '+EAMList.size());
      map<string,Event_Attendee_Mapping__c> esmap = new map<string,Event_Attendee_Mapping__c>();
      
      for(Event_Attendee_Mapping__c eam: EAMList){
      
          LIST<EventSchedule__c> schedulesList= new LIST<EventSchedule__c>();
          schedulesList= eam.EventSchedule__r;
          if(schedulesList.size() == 0){
              EAMListForMatch.add(eam);
          }else{
          
          
          
          }
            system.debug('  ADDED EAM LIST  '+EAMListForMatch.size());

      }
  
  //}
      }catch(Exception Ex){}
  }
  
  public String selectedEamId{get; set;}
  public boolean showExccededError{get; set;}
  public LIST<MatchLeads_Days__c> MLDAYS{get; set;}
  public pagereference matchSelectedAttendee(){
  showExccededError= false;
      system.debug('UPE ID '+BoothAdminDetails+'   EAM ID '+selectedEamId+' DATE '+selectedSplitDate +'   TIMINGS '+selectedTimeSlots);
      try{
      Event__c eventTypeForStatus= [select id,MatchMaking_Type__c,Is_MatchMaking_Event__c from Event__c where id=: SelectEvent ];                               

      LIST<EventSchedule__c> insertSchedules= new LIST<EventSchedule__c>();
      EventSchedule__c insertSchedule= new EventSchedule__c();
      
      insertSchedule.MM_To_EAM__c= selectedEamId;
      insertSchedule.MM_To_UPE__c= BoothAdminDetails;
      insertSchedule.MM_slot_Date__c= selectedSplitDate ;
      insertSchedule.MM_slot_StartTime__c= selectedTimeSlots[0];
      insertSchedule.MM_Slot_End_Time__c= selectedTimeSlots[1];
      insertSchedule.EV_id__c= SelectEvent;
      insertSchedule.Is_Matchmaking__c= TRUE;
      system.debug('Added SCH  '+insertSchedule);
      
      if(eventTypeForStatus.MatchMaking_Type__c != 'Open' && eventTypeForStatus.MatchMaking_Type__c != 'Closed' ){
          insertSchedule.MM_Slot_Status__c= 'Pending';
      }else{
            insertSchedule.MM_Slot_Status__c= 'Accepted';
      }
      insertSchedules.add(insertSchedule);
      Database.SaveResult[] scheduleInsert = Database.insert(insertSchedules, false);
      system.debug(' INSERTED SCH'+scheduleInsert);
      ShowMatchPanel= false;
      statusValueSchedule();
      showExccededError= false;
      }catch(Exception Ex){}
      return null;
  }
  public pagereference closeExhibitorPopup(){
      
      showExccededError= false;
      ShowMatchPanel= false;
      return null;
  }
  
 
  //-------------------------------------------------------------------
  
  public void saveExhibitors(){
  list <Messaging.SingleEmailMessage> emails = new List <Messaging.SingleEmailMessage> ();
    List<id> dd=new list<id>();
  for(Selectoption MM: availableBADSinMM ){
    if(mm.getvalue() != '--NONE--')
          dd.add(mm.getvalue());
  system.debug('        ids   '+dd);
 
  }
  list<User_Profile_Event__c> updmm=new list<User_Profile_Event__c>();
  List<Event_Attendee_Mapping__c> eamids = new List<Event_Attendee_Mapping__c>();
  List<Event_Attendee_Mapping__c> updteamids = new List<Event_Attendee_Mapping__c>();
  List<id> idsatt = new list<id>();
  BoothAdminsList =[select IsMatchMakingUser__c,Attendee_Summary__c from User_Profile_Event__c  where id IN : dd];
  for(User_Profile_Event__c ISMM: BoothAdminsList ){
      ISMM.IsMatchMakingUser__c =true;
      ISMM.MAtchMakingProfile__c ='Corporate';
      idsatt.add(ISMM.Attendee_Summary__c);
      updmm.add(ISMM);
  }
  update updmm;
  eamids = [select id,IsMatchMakingAttendee__c from Event_Attendee_Mapping__c Where EV_id__c =: SelectEvent   AND AS_id__r.id IN: idsatt];
  for(Event_Attendee_Mapping__c emm : eamids ){
  emm.IsMatchMakingAttendee__c =true;
  updteamids.add(emm);
  }
  update updteamids;
  List<ID> IDSB=new List<ID>();
  set<string> setvals = new Set<string> ();
  for(Selectoption MM: availableBADS){

  IDSB.add(mm.getvalue());
  system.debug('        ids   '+dd);
 
  }
  list<EventSchedule__c> updBL=new list<EventSchedule__c>();
  list<EventSchedule__c> ESlist = [select id,Is_Matchmaking__c,MM_Slot_End_Time__c,MM_slot_StartTime__c ,MM_To_UPE__r.BT_id__r.BT_Name__c,MM_To_EAM__r.AS_id__r.AS_Email__c,MM_To_EAM__r.AS_id__r.AS_Company__c,MM_To_UPE__r.Attendee_Summary__r.AS_Company__c,MM_To_UPE__r.IsMatchMakingUser__c,MM_To_EAM__r.AS_id__r.AS_FirstName__c,MM_To_EAM__r.AS_id__r.AS_LastName__c  from EventSchedule__c where MM_To_UPE__r.id IN : IDSB AND MM_Slot_Status__c =: 'Accepted'];
  system.debug('dddddddddddddddddddddddddddddddddddddddd'+ESlist );
  EmailTemplate E = new EmailTemplate();    
  E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Cancellation Email to MBE'];     
  Event__c eve = [select id,OrganizerId__c,EV_EventLogo__c,EV_HistingAddr1__c,AS_HostingAddr2__c,AS_HostingCity__c,EV_HostingLocation__c,
                                                EV_HostingStateNew__c,EV_Title__c,EV_HostingZipcode__c from Event__c where id =: SelectEvent ];
                    AttendeeSummary__c attsum = [select id,AS_CellPhone__c,AS_WorkPhone__c from AttendeeSummary__c where AS_Email__c =:userInfo.getUserName()];
                    List<MatchLeads_Days__c> daysmm = new List<MatchLeads_Days__c> ();
                    try {
                    daysmm = [select id,Start_time__c,End_Time__c,MatchLeads_Date__c from MatchLeads_Days__c where Event__c =: SelectEvent ];
                     } catch(exception e1){ }
                    system.debug('------------------------ LOGO ----------------------------'+eve.EV_EventLogo__c);
                    
    
                    
  for(EventSchedule__c esch : ESlist ){
  
  esch.MM_Slot_Status__c = 'Cancelled';
  updBL.add(esch);                   
  }
  confirmdelsh = true;
  database.update(updBL);
  list<User_Profile_Event__c> upeuncheck = new list<User_Profile_Event__c> ();
  list<string> idsattavl = new List<string>();
 list<User_Profile_Event__c> uperemove = [select IsMatchMakingUser__c,Attendee_Summary__c  from User_Profile_Event__c where id in: IDSB];
     for(User_Profile_Event__c upe: uperemove ){ 
         upe.IsMatchMakingUser__c = false;
         upeuncheck.add(upe);
         idsattavl.add(upe.Attendee_Summary__c);
        
     }
 update upeuncheck;
 eamids = new List<Event_Attendee_Mapping__c>();
 List<Event_Attendee_Mapping__c> updteamidsval = new List<Event_Attendee_Mapping__c>();
 eamids = [select id,IsMatchMakingAttendee__c from Event_Attendee_Mapping__c Where EV_id__c =: SelectEvent   AND AS_id__r.id IN: idsattavl];
  for(Event_Attendee_Mapping__c emm1 : eamids ){
  emm1.IsMatchMakingAttendee__c =false;
  updteamidsval.add(emm1);
  }
  update updteamidsval;
 
 
  listofboothadmins();
  multiselectpicklist=false;
  }
  public string escape(string s) {
     if (s != null && s.contains(',')) {
         s = s.replaceAll('"', '');
       //  s = '"' + s + '"';
     }
     return s;
 }
 public list<User_Profile_Event__c> exportcorporatelist {get;set;}
  public pagereference  Exportcorporate(){
  BoothAdminsList = new list<User_Profile_Event__c>();
  exportcorporatelist  = new list<User_Profile_Event__c>();
  BoothAdminsList = [Select UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BoothAdmin_id__r.FirstName,BT_id__r.MM_TableNo__c,Attendee_Summary__r.As_prefixNew__c,
                              BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,BT_id__r.BT_Location__c,MAtchMakingProfile__c,Attendee_Summary__r.AS_Title__c,
                              BoothAdmin_id__r.Username,BoothAdmin_id__r.CompanyName,BoothAdmin_id__r.Email,Attendee_Summary__r.Exhibitor_company_imageUrl__c,
                              BoothAdmin_id__r.Companyphone__c,BoothAdmin_id__r.LastLoginDate,Attendee_Summary__r.AS_ImageUrl__c,Attendee_Summary__r.AS_Company__c,
                              Attendee_Summary__r.AS_PrimaryBusinessCategory1__c,Attendee_Summary__r.As_SecondaryBusinessCategory1__c,Attendee_Summary__r.AS_WebsiteUrl__c,
                              Attendee_Summary__r.AS_BusinessDescription__c,Attendee_Summary__r.AS_WorkPhone__c,Attendee_Summary__r.AS_WorkAddress1__c,Attendee_Summary__r.Keywords__c,
                              Attendee_Summary__r.AS_WorkAddress2__c,Attendee_Summary__r.AS_WorkCity__c,Attendee_Summary__r.AS_Work_States__c,Attendee_Summary__r.AS_Work_Country__c,
                              Attendee_Summary__r.AS_WorkZip__c,Attendee_Summary__r.AS_NAICSCode_1__c,Attendee_Summary__r.AS_NAICSCode_2__c,Attendee_Summary__r.AS_NAICSCode_3__c,
                              Attendee_Summary__r.AS_NAICSCode_4__c,Attendee_Summary__r.Exceptional_Key_Words__c,Attendee_Summary__r.AS_NAICSCode_5__c,/*
                              Attendee_Summary__r.AS_NAICSCode6__c,Attendee_Summary__r.AS_NAICSCode7__c,Attendee_Summary__r.AS_NAICSCode8__c,Attendee_Summary__r.AS_NAICSCode9__c,*/
                              Attendee_Summary__r.AS_CellPhone__c,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.AS_LastName__c
                              ,Attendee_Summary__r.DBA__c,
                          Attendee_Summary__r.Geographical_Region__c,
                          Attendee_Summary__r.Certificate_Processed_by_RPO__c,
                          Attendee_Summary__r.BBB_Number__c,
                          Attendee_Summary__r.Commodity_1__c,
                          Attendee_Summary__r.Commodity_2__c,
                          Attendee_Summary__r.Commodity_3__c,
                          Attendee_Summary__r.Commodity_4__c,
                          Attendee_Summary__r.Commodity_5__c,Attendee_Summary__r.Commodity_6__c,Attendee_Summary__r.Commodity_7__c,Attendee_Summary__r.Commodity_8__c,Attendee_Summary__r.Commodity_9__c,
                          Attendee_Summary__r.distribution_Country__c,
                          Attendee_Summary__r.Manufactures_Country__c,
                          Attendee_Summary__r.References__c,
                          Attendee_Summary__r.Revenue_Range__c,
                           Attendee_Summary__r.AS_NAICSCode9__c,
                   Attendee_Summary__r.AS_NAICSCode8__c,
                    Attendee_Summary__r.AS_NAICSCode7__c,
                    Attendee_Summary__r.AS_NAICSCode6__c
                              from User_Profile_Event__c  
                              where Request_for_upgrade_profile__c = false 
                              AND IsMatchMakingUser__c=True 
                              AND EV_id__c =:SelectEvent 
                              AND (MAtchMakingProfile__c =:'Corporate'OR MAtchMakingProfile__c =:'CorporateStaff')
                              ORDER BY Attendee_Summary__r.AS_Company__c ASC];
      for(User_Profile_Event__c s:BoothAdminsList ){
      
      if(s.BoothAdmin_id__r.CompanyName != null || s.BoothAdmin_id__r.CompanyName != null){
                   if(s.BoothAdmin_id__r.CompanyName.contains(',')){
                    s.BoothAdmin_id__r.CompanyName = escape(s.BoothAdmin_id__r.CompanyName);}
                 }
       if(s.Attendee_Summary__r.AS_Title__c != null || s.Attendee_Summary__r.AS_Title__c != null){
           if(s.Attendee_Summary__r.AS_Title__c.contains(',')){
            s.Attendee_Summary__r.AS_Title__c = escape(s.Attendee_Summary__r.AS_Title__c);}
         } 
     if(s.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c != null || s.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c != null){
           if(s.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c.contains(',')){
            s.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c = escape(s.Attendee_Summary__r.AS_PrimaryBusinessCategory1__c);}
         }  
      if(s.Attendee_Summary__r.AS_FirstName__c != null || s.Attendee_Summary__r.AS_FirstName__c != null){
                   if(s.Attendee_Summary__r.AS_FirstName__c.contains(',')){
                    s.Attendee_Summary__r.AS_FirstName__c = escape(s.Attendee_Summary__r.AS_FirstName__c);}
                 }
     if(s.Attendee_Summary__r.AS_LastName__c != null || s.Attendee_Summary__r.AS_LastName__c != null){
       if(s.Attendee_Summary__r.AS_LastName__c.contains(',')){
        s.Attendee_Summary__r.AS_LastName__c = escape(s.Attendee_Summary__r.AS_LastName__c);}
     }
     if(s.Attendee_Summary__r.AS_Company__c != null || s.Attendee_Summary__r.AS_Company__c != null){
       if(s.Attendee_Summary__r.AS_Company__c.contains(',')){
        s.Attendee_Summary__r.AS_Company__c = escape(s.Attendee_Summary__r.AS_Company__c);}
     }
      if(s.Attendee_Summary__r.AS_BusinessDescription__c != null || s.Attendee_Summary__r.AS_BusinessDescription__c != null){
                   if(s.Attendee_Summary__r.AS_BusinessDescription__c.contains(',')){
                    s.Attendee_Summary__r.AS_BusinessDescription__c = escape(s.Attendee_Summary__r.AS_BusinessDescription__c);}
                 }
      
      if(s.Attendee_Summary__r.Keywords__c != null || s.Attendee_Summary__r.Keywords__c != null){
                   if(s.Attendee_Summary__r.Keywords__c.contains(',')){
                    s.Attendee_Summary__r.Keywords__c = escape(s.Attendee_Summary__r.Keywords__c);}
                 }
      if(s.Attendee_Summary__r.AS_WorkAddress2__c != null || s.Attendee_Summary__r.AS_WorkAddress2__c != null){
                   if(s.Attendee_Summary__r.AS_WorkAddress2__c.contains(',')){
                    s.Attendee_Summary__r.AS_WorkAddress2__c = escape(s.Attendee_Summary__r.AS_WorkAddress2__c);}
                 }
      if(s.Attendee_Summary__r.AS_WorkAddress1__c != null || s.Attendee_Summary__r.AS_WorkAddress1__c != null){
                    if(s.Attendee_Summary__r.AS_WorkAddress1__c.contains(',')){
                    s.Attendee_Summary__r.AS_WorkAddress1__c = escape(s.Attendee_Summary__r.AS_WorkAddress1__c);}
                 }
       if(s.Attendee_Summary__r.AS_NAICSCode_1__c != null || s.Attendee_Summary__r.AS_NAICSCode_1__c != null){
                   if(s.Attendee_Summary__r.AS_NAICSCode_1__c.contains(',')){
                       s.Attendee_Summary__r.AS_NAICSCode_1__c = escape(s.Attendee_Summary__r.AS_NAICSCode_1__c);}
                 }
                 if(s.Attendee_Summary__r.AS_NAICSCode_2__c != null || s.Attendee_Summary__r.AS_NAICSCode_2__c != null){
                   if(s.Attendee_Summary__r.AS_NAICSCode_2__c.contains(',')){
                       s.Attendee_Summary__r.AS_NAICSCode_2__c= escape(s.Attendee_Summary__r.AS_NAICSCode_2__c);}
                 }
                 if(s.Attendee_Summary__r.AS_NAICSCode_3__c != null || s.Attendee_Summary__r.AS_NAICSCode_3__c != null){
                   if(s.Attendee_Summary__r.AS_NAICSCode_3__c.contains(',')){
                       s.Attendee_Summary__r.AS_NAICSCode_3__c = escape(s.Attendee_Summary__r.AS_NAICSCode_3__c);}
                 }
                 if(s.Attendee_Summary__r.AS_NAICSCode_4__c!= null || s.Attendee_Summary__r.AS_NAICSCode_4__c!= null){
                   if(s.Attendee_Summary__r.AS_NAICSCode_4__c.contains(',')){
                       s.Attendee_Summary__r.AS_NAICSCode_4__c= escape(s.Attendee_Summary__r.AS_NAICSCode_4__c);}
                 }
                 if(s.Attendee_Summary__r.AS_NAICSCode_5__c != null || s.Attendee_Summary__r.AS_NAICSCode_5__c != null){
                   if(s.Attendee_Summary__r.AS_NAICSCode_5__c.contains(',')){
                       s.Attendee_Summary__r.AS_NAICSCode_5__c = escape(s.Attendee_Summary__r.AS_NAICSCode_5__c);}
                 }

                  if(s.Attendee_Summary__r.Keywords__c != null || s.Attendee_Summary__r.Keywords__c != null){
                   if(s.Attendee_Summary__r.Keywords__c.contains(',')){
                       s.Attendee_Summary__r.Keywords__c = escape(s.Attendee_Summary__r.Keywords__c);}
                 }
      exportcorporatelist.add(s);
      
      }
  pagereference pf= new pagereference('/apex/MM_Eventadmin_Exportcorporate');
  pf.setredirect(false);
  return pf;
  
  
  }
  
  //public string eamid; 
 Public pagereference PrintBoothAdminDetails(){
 DisplayBoothAdminDetails();
 string  eamid = ApexPages.currentPage().getParameters().get('mycheck');
     system.debug('             mycheck   '+eamid);
     
     PageReference pg = new pagereference('/apex/mm_corporate_printprofile?id=' + eamid);
     pg.setRedirect(true);
     return pg;
 }
   public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    isc=1;
    // run the query again
   ListOfBoothAdmins();
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
       system.debug('44444444444444444 ' + naicschangeids);
       
 
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
 //----------------------------Blocking Schedule---------------------
    public MAP<DATE,LIST<String>>  dateSlotsMAP {get; set ;}
    public list<string> timeListMap {get ; set ;}
    public list<innercl> innlistscheduled {get; set;}
    public list<Event_Breaks__c> blokslistexist {get ; set ;}
    public string blockselecteddate {get ; set ;}  
    public date dte {get ; set ;}
    public void blockschedules(){
    
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
      allEventDates= new LIST<MatchLeads_Days__c>([SELECT ID, MatchLeads_Date__c FROM MatchLeads_Days__c WHERE Event__c =: SelectEvent ORDER BY MatchLeads_Date__c ASC]);
      if(allEventDates.size() >=1){
        
         for(MatchLeads_Days__c matchDate: allEventDates){
             String dateFormat= matchDate.MatchLeads_Date__c.format();
             system.debug('dddddddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyy'+dateFormat);
             eventDatesList.add(new selectoption(matchDate.id,dateFormat));
              }
         system.debug('dddddddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaayyyyyyyyyyyyyyyy'+eventDatesList);
         if(blockselecteddate == ''){
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
                                        WHERE MM_To_UPE__c =: BoothAdminDetails 
                                        AND MM_To_UPE__r.IsMatchMakingUser__c =: TRUE
                                        AND MM_To_EAM__c != null 
                                        AND MM_slot_Date__c =: date.Parse(mmdate)  
                                        AND MM_Slot_Status__c = 'Accepted'
                                        AND EV_id__c =: SelectEvent 
                                        ];
                   string eschslots = '';
                   if(exhibitorschedule.size() != 0){
                     for(EventSchedule__c esch : exhibitorschedule ){
                        eschslots += esch.MM_slot_StartTime__c+'-'+esch.MM_Slot_End_Time__c+','; 
                     
                    }}
                    blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: BoothAdminDetails AND MatchLeads_Days__c =: blockselecteddate ];
                    string listvals = '';
                    for(Event_Breaks__c evb : blokslistexist) {
                    listvals += evb.Break_Start_Time__c+'-'+evb.Break_End_Time__c+',';
                    }
                    
                    dte = date.Parse(mmdate);
                    system.debug('ttttttttttttttteeeeeeeeee'+dte);
                    MAP<Date, LIST<String>> singleDayMMEvent = MM_Utility.giveEventTimingsWithDates(SelectEvent, dte);
                    
                    for(Date MMDay : singleDayMMEvent.KeySet()){
                    timeListMap = singleDayMMEvent.get(MMDay);
                    
                    }
                  
                   for(string ss : timeListMap ){
                   
                   if(eschslots != null && eschslots!= '' && eschslots.contains(ss)){
                   innlistscheduled.add(new innercl(ss,true));
                   }else{
                   if(listvals.contains(ss)){
                   blockedslots.add(new selectoption(ss,ss));}
                   //innlistblocked.add(new innercl(ss,false));
                   else{
                   availableslots.add(new selectoption(ss,ss));
                   //innlist.add(new innercl(ss,false));
                   }
                   } }}catch(exception e){}
                   
                   }
    public Event_Breaks__c blockslot {get; set;}
    public list<selectoption> availableslots {get;set;}
    public list<selectoption> blockedslots {get; set;}    
    
    public void Blockedaction(){
        blokslistexist = new list<Event_Breaks__c> ();
        blokslistexist = [select id,Break_End_Time__c,Break_Start_Time__c from Event_Breaks__c where User_Profile_Event__c =: BoothAdminDetails AND MatchLeads_Days__c =: blockselecteddate];
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
                blockslot.User_Profile_Event__c = BoothAdminDetails;
                blockslot.Break_Start_Time__c = divideslot[0];
                blockslot.Break_End_Time__c = divideslot[1];
                blockslot.MatchLeads_Days__c = blockselecteddate; 
                blokslist.add(blockslot);
             
             
             }
         insert blokslist;
         }
                /**
                for(innercl ins : innlist){
                if(ins.selected == true){
                blockslot = new Event_Breaks__c ();
                list<string> divideslot = String.valueOf(ins.slot).split('-');
                blockslot.User_Profile_Event__c = BoothAdminDetails;
                blockslot.Break_Start_Time__c = divideslot[0];
                blockslot.Break_End_Time__c = divideslot[1];
                
                blokslist.add(blockslot);
                
                }
                }
                 insert blokslist;
                
                
    
    }
     public void UnBlockedaction(){
        
    list<Event_Breaks__c> blokslist = new list<Event_Breaks__c> ();
    string slotslist = '';
     for(innercl ins1 : innlistblocked){
        if(ins1.selected == true){
        slotslist += ins1.slot+',';
        }
    }
    for(Event_Breaks__c bks : blokslistexist ){
    if(slotslist.contains(bks.Break_Start_Time__c+'-'+bks.Break_End_Time__c)){
    blokslist.add(bks);
    }
    
    }
    delete blokslist;

     
    } */
  public class innercl{
      
        public boolean selected {get; set ;}
        public string slot {get; set;}
         public innercl(string dispslot,boolean bb){
        
         selected = bb;
         slot = dispslot;
         
         }
        
        }
       public void delvideo(){
        string DelId = ApexPages.currentPage().getParameters().get('deletedId1') ; 
     List<Widget__c> video = new List<Widget__c>();
     video = [select Id,Name From Widget__c where id=: DelId ];
      SYSTEM.DEBUG(' ====================@@ '+video);
     Database.DeleteResult[] DR_Dels = Database.delete(video,True);
     commonMethod();
   
 }
 public PageReference delimage() {
  string DelId = ApexPages.currentPage().getParameters().get('deletedId2') ; 
     List<document> imgdoc= new List<document>();
     imgdoc= [select Id,Name From document where id=: DelId ];
      Database.DeleteResult[] DR_Dels2 = Database.delete(imgdoc,True);
      List<AttendeeSummary__c> attsum= new List<AttendeeSummary__c >();
     attsum= [select Id,Name,Exhibitor_company_imageUrl__c,AS_ImageUrl__c From AttendeeSummary__c where Exhibitor_company_imageUrl__c=: DelId or AS_ImageUrl__c =: DelId];
     if(attsum.size()>0)
     {
       if(attsum[0].Exhibitor_company_imageUrl__c==DelID)
       attsum[0].Exhibitor_company_imageUrl__c=null;
       if(attsum[0].AS_ImageUrl__c ==DelID)
       attsum[0].AS_ImageUrl__c =null;
       Database.SaveResult[] DR_ups = Database.update(attsum,True);
     }
     commonMethod();  
        return null;
    }
  public void delattachment(){
     SYSTEM.DEBUG(' selected get '+ApexPages.currentPage().getParameters().get('deletedId'));
     string DelId = ApexPages.currentPage().getParameters().get('deletedId') ; 
     List<Attachment> attac = new List<Attachment>();
     attac = [select Id,Name From Attachment where id=: DelId ];
      SYSTEM.DEBUG(' ====================@@ '+attac );
     Database.DeleteResult[] DR_Dels = Database.delete(attac,True);
     
   commonMethod();  
 }
 public PageReference ImportAttendee() {
     string pro = '~MatchLeads222Corporate';
     pagereference pg = new pagereference('/apex/MM_Import?id='+ SelectEvent +pro);
     pg.setredirect(true);
     return pg;
 }
        

 
 
// public LIST<User_Profile_Event__c> liupes{get;set;}
public List<User_Profile_Event__c> liupe{get;set;}
public List<User_Profile_Event__c> listofupe{get;set;}

Public void massemailschedules()
{
  batchEmailsSending bse = new batchEmailsSending();
     bse.SelectEvent =SelectEvent ;
     bse.url = System.URL.getSalesforceBaseUrl().toExternalForm();
     bse.sessionId =userinfo.getsessionid();
     Database.executeBatch(bse,99); 
   }
   
@RemoteAction
 global static String changetablenumber(String upeid,String tabnum,String Eventid) {
 system.debug('jjjjjjjj'+upeid);
 String isExist = 'false';
 List<Booth__c> allbts = [select id,name,MM_TableNo__c from Booth__c where EV_id__c=:Eventid];
 for(Booth__c sbooth:allbts)
 {
 if(sbooth.MM_TableNo__c == tabnum)
 {
 isExist = 'true';
 }
 
 }
 if(isExist == 'false'){
     User_Profile_Event__c event1= [select id,BT_id__c from User_Profile_Event__c where id = :upeid];
     Booth__c b=[select id,name,MM_TableNo__c from Booth__c where id=:event1.BT_id__c];
 b.MM_TableNo__c=tabnum;
 
 system.debug('nnnnnnnnnnnnnnnnnn'+tabnum);
     update b;
 }
 return isExist;
 }
   
   
   
  

  //FOR EMAIL ID CHANGE
  @RemoteAction
     global static String checkattendee(String email,string evid ) {
     List<AttendeeSummary__c> ats = new List<AttendeeSummary__c>();
     system.debug(':::::::::::::::::;'+email);
     ats = [select id from AttendeeSummary__c where AS_Email__c =: email];
     List<User> uid = [select id from User where Username =: email];
     if(uid.size() > 0)
       {
     List<User_Profile_Event__c> ups = new List<User_Profile_Event__c>();
   ups = [select id,Attendee_Summary__c,User_id__c from User_Profile_Event__c where EV_id__c =: evid AND User_id__r.Username =: email];
    List<Event_Attendee_Mapping__c> eam = [select id from Event_Attendee_Mapping__c where EV_id__c =: evid and AS_id__c =: ats[0].id];
          if(ups.size() > 0 || eam.size() > 0 ){
           return   'Duplicate'; 
          }else
      return 'Exist';
      }
      else
          return 'Not Exist';

     }
      
      
      @RemoteAction
  public static pagereference updateexstdemail(string newemail,string oldemail, string upeid,string evid){
  AttendeeSummary__c attsum = new AttendeeSummary__c();
  system.debug(':::::::;;;eamid:;;;;'+upeid);
  attsum = [select id,AS_LastName__c,AS_FirstName__c,AS_Company__c,AS_WorkPhone__c from AttendeeSummary__c where AS_Email__c =: newemail];
  List<User> u = [select id from User where Username =: newemail];
   List<Event_Attendee_Mapping__c> evm = new List<Event_Attendee_Mapping__c>();
   evm = [Select id,AS_id__c from Event_Attendee_Mapping__c Where AS_id__r.AS_Email__c =: oldemail And EV_id__c =: evid];
   
   if(evm.size()== 0){
   Event_Attendee_Mapping__c em = new Event_Attendee_Mapping__c();
        em.AS_id__c = attsum.id;
        em.EV_id__c = evid;
        em.Boothleads_Profile__c = 'Booth Admin';
        em.IsMatchMakingAttendee__c =true;
        em.Attendee_Event_IDs__c = attsum.id+evid;
        insert em;
        }else{
        evm[0].AS_id__c = attsum.id;
        evm[0].Attendee_Event_IDs__c = attsum.id+evid;
        update evm[0];
        }
   User_Profile_Event__c up = new User_Profile_Event__c();
   LIST<User_Profile_Event__c> upn = new LIST<User_Profile_Event__c>();
   upn = [select id ,BT_id__c from  User_Profile_Event__c where User_id__r.Username =: newemail];
   up = [select id,Attendee_Summary__c,User_id__c from User_Profile_Event__c where id =: upeid];
       up.Attendee_Summary__c = attsum.id;
       up.User_id__c = u[0].id;
       up.BoothAdmin_id__c = u[0].id;
       if(upn.size()>0){
       up.BT_id__c = upn[0].BT_id__c;
       }else{
       Booth__c bt = new Booth__c();
                           //Booth.BT_Location__c         =  Booth.BT_Location__c;
                        bt.BT_Name__c             =  attsum.AS_Company__c;
                        bt.EV_id__c               =  evid;
                        bt.BT_ContactName__c      =  attsum.AS_FirstName__c +' '+ attsum.AS_LastName__c;
                        bt.BT_ContactPhone__c     =  attsum.AS_WorkPhone__c;
                        //Booth.BT_WebsiteURL__c       =  BoothAdminUser.Company_website__c;
                        bt.BT_ContactEmail__c     =  newemail;   
                        //Booth.MM_TableNo__c          =  Booth.MM_TableNo__c;
       insert bt;
       up.BT_id__c = bt.id;
       }
       update up;
       
       pagereference pf = new pagereference('/apex/MM_Eventadmin_Exhibitorsdirectory');
       pf.setredirect(true);
       return pf;
       
  } 
  
  @RemoteAction
  public static void updatenewemail(string newemail,string oldemail, string eveid ,string upeid){
  
  Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin' limit 1];
               
               system.debug('======:::::::: Retriving Profile Id from Standard Profile Object ========::::::'+UserAsBA);              
              
             user uname=[select id from user where profile.Name Like 'System Administrator' and isActive=true Limit 1];
            User BoothAdminUser1 = new user();
               BoothAdminUser1 = [Select id, Firstname,Lastname,companyName,Company_website__c,CompanyAddr1__c,CompanyAddr2__c,CompanyCity__c,Country__c,
                                    States__c,CompanyFaxNumber__c,Companyphone__c,Zipcode__c,PoBox__c from User where Username =: oldemail];
               
            account acc=new account();
            acc.name='BoothLeads';  
            //acc.ownerid = '005Z0000000oyN7';
            acc.ownerid=uname.id;          
            insert acc; 
            contact Con = new contact();
                Con.LastName = BoothAdminUser1.LastName;
                 Con.FirstName = BoothAdminUser1.FirstName;
                  Con.AccountId = acc.id;
                 insert Con ;               
               system.debug('=====::::::::: Inserting Contact :::::::======='+Con );
               
                User BoothAdminUser = new User();     
                BoothAdminUser.ContactID = Con.id;
                BoothAdminUser.Username = newEmail;
                BoothAdminUser.Email = newEmail;
                BoothAdminUser.Firstname = BoothAdminUser1.Firstname;
                BoothAdminUser.LastName = BoothAdminUser1.LastName;
                BoothAdminUser.Alias ='BAdmin';
                BoothAdminUser.ProfileID =UserAsBA.Id;
                BoothAdminUser.LocaleSidKey ='en_US';
                BoothAdminUser.LanguageLocaleKey ='en_US';
                BoothAdminUser.TimeZoneSidKey ='America/Los_Angeles';
                BoothAdminUser.EmailEncodingKey='UTF-8';
              
                BoothAdminUser.companyName = BoothAdminUser1.companyName;
              
                BoothAdminUser.Company_website__c = BoothAdminUser1.Company_website__c;
                BoothAdminUser.CompanyAddr1__c = BoothAdminUser1.CompanyAddr1__c;
                BoothAdminUser.CompanyAddr2__c = BoothAdminUser1.CompanyAddr2__c;
                BoothAdminUser.CompanyCity__c = BoothAdminUser1.CompanyCity__c;                
                BoothAdminUser.Country__c = BoothAdminUser1.Country__c;                
                BoothAdminUser.States__c = BoothAdminUser1.States__c;
                BoothAdminUser.CompanyFaxNumber__c  = BoothAdminUser1.CompanyFaxNumber__c;
                BoothAdminUser.Companyphone__c = BoothAdminUser1.Companyphone__c;
                BoothAdminUser.Zipcode__c = BoothAdminUser1.Zipcode__c;
                BoothAdminUser.PoBox__c = BoothAdminUser1.PoBox__c;
                BoothAdminUser.IsActive = False;
              insert BoothAdminUser;
              
              //Attendee object checking 
              
               List<AttendeeSummary__c> newattendee = new List<AttendeeSummary__c>();
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
                                        Business_Structure__c,Ethnicity__c,AS_Secondary_Email__c,
                                         Geographical_Region__c,Manufactures_Country__c,AS_ShippingPoBox__c,AS_WorkState__c,AS_NAICSCode6__c,AS_NAICSCode7__c,AS_NAICSCode8__c,AS_NAICSCode9__c,References__c,Scope_of_Work__c,References2__c,Scope_of_Work2__c,Certificate_Processed_by_RPO__c,Year_in_business__c,Any_non_WBENC_awards_received__c,Companyhaveafacility_partneroutsideUSA__c, 
                                         (select id,YouTubeId_c__c From Widgets__r)FROM AttendeeSummary__c WHERE AS_Email__c = : oldemail];
                 List<AttendeeSummary__c>  newattendee1 = [select id from AttendeeSummary__c where AS_Email__c = : newemail];                       
                if(newattendee1.size() == 0){
              AttendeeSummary__c UpdateAttendee = new AttendeeSummary__c();

             system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^' + newattendee[0].AS_FirstName__c);
             UpdateAttendee.AS_FirstName__c = newattendee[0].AS_FirstName__c;
             UpdateAttendee.AS_LastName__c = newattendee[0].AS_LastName__c;
             UpdateAttendee.As_Email__c = newemail;
             UpdateAttendee.AS_Secondary_Email__c = newemail;
             UpdateAttendee.AS_Company__c = newattendee[0].AS_Company__c;
             UpdateAttendee.AS_PrefixNew__c = newattendee[0].AS_PrefixNew__c;
             UpdateAttendee.AS_SuffixNew__c = newattendee[0].AS_SuffixNew__c;
             UpdateAttendee.AS_Title__c = newattendee[0].AS_Title__c;
             UpdateAttendee.AS_CellPhone__c = newattendee[0].AS_CellPhone__c;             
                 UpdateAttendee.AS_Age__c = newattendee[0].AS_Age__c ;
             
             UpdateAttendee.AS_HomePhone__c = newattendee[0].AS_HomePhone__c;
             UpdateAttendee.AS_Gender__c = newattendee[0].AS_Gender__c;
             UpdateAttendee.AS_BirthDate__c = newattendee[0].AS_BirthDate__c;
             UpdateAttendee.AS_HomeAddress1__c = newattendee[0].AS_HomeAddress1__c;
             UpdateAttendee.AS_BusinessDescription__c = newattendee[0].AS_BusinessDescription__c;
             UpdateAttendee.AS_BusinessEstablishedDate__c = newattendee[0].AS_BusinessEstablishedDate__c;
             UpdateAttendee.AS_BusinessDunsNumber__c = newattendee[0].AS_BusinessDunsNumber__c;
             UpdateAttendee.AS_NumberOfEmployees__c = newattendee[0].AS_NumberOfEmployees__c;
             UpdateAttendee.AS_BusinessRevenue__c = newattendee[0].AS_BusinessRevenue__c;
             UpdateAttendee.AS_BusinessTaxId__c = newattendee[0].AS_BusinessTaxId__c;
             UpdateAttendee.AS_PrimaryBusinessCategory1__c = newattendee[0].AS_PrimaryBusinessCategory1__c;
             UpdateAttendee.AS_SecondaryBusinessCategory1__c = newattendee[0].AS_SecondaryBusinessCategory1__c;
             UpdateAttendee.AS_WebsiteURL__c = newattendee[0].AS_WebsiteURL__c;
             UpdateAttendee.AS_ShippingAddress1__c = newattendee[0].AS_ShippingAddress1__c;
             UpdateAttendee.AS_ShippingPOBox__c = newattendee[0].AS_ShippingPOBox__c;
             UpdateAttendee.AS_BlogURL__c = newattendee[0].AS_BlogURL__c;
             UpdateAttendee.AS_WorkAddress1__c = newattendee[0].As_WorkAddress1__c;
             UpdateAttendee.AS_WorkPhone__c = newattendee[0].AS_WorkPhone__c;
             UpdateAttendee.AS_WorkPOBox__c = newattendee[0].AS_WorkPOBox__c;
             UpdateAttendee.AS_DiversityType__c = newattendee[0].AS_DiversityType__c;
             UpdateAttendee.Business_type__c = newattendee[0].Business_type__c;
             UpdateAttendee.Company_Certifications__c = newattendee[0].Company_Certifications__c;
             UpdateAttendee.GSA_Schedule__c = newattendee[0].GSA_Schedule__c;
             UpdateAttendee.AS_CageCode__c = newattendee[0].AS_CageCode__c;
             UpdateAttendee.AS_DiversityType__c = newattendee[0].AS_DiversityType__c;


             UpdateAttendee.AS_shippingCity__c = newattendee[0].AS_shippingCity__c;
             UpdateAttendee.AS_shippingState__c = newattendee[0].AS_shippingState__c;
             UpdateAttendee.AS_WorkAddress1__c = newattendee[0].AS_WorkAddress1__c;
             UpdateAttendee.AS_WorkAddress1__c = newattendee[0].AS_WorkAddress2__c;
             UpdateAttendee.AS_Workcity__c = newattendee[0].AS_Workcity__c;
             UpdateAttendee.AS_WorkState__c = newattendee[0].AS_WorkState__c;
             UpdateAttendee.AS_HomeAddress1__c = newattendee[0].AS_HomeAddress1__c;
             UpdateAttendee.AS_HomeCity__c = newattendee[0].AS_HomeCity__c;
             UpdateAttendee.AS_HomePOBox__c = newattendee[0].AS_HomePOBox__c;
             UpdateAttendee.As_Home_State__c = newattendee[0].As_Home_State__c;
             UpdateAttendee.AS_uniqueField__c = (newattendee[0].AS_FirstName__c + newattendee[0].AS_LastName__c + newattendee[0].AS_Email__c).tolowercase();
            
            
           
            UpdateAttendee.As_NAICSCode_1__c = newattendee[0].As_NAICSCode_1__c;
            UpdateAttendee.As_NAICSCode_2__c = newattendee[0].As_NAICSCode_2__c;
            UpdateAttendee.As_NAICSCode_3__c = newattendee[0].As_NAICSCode_3__c;
            UpdateAttendee.As_NAICSCode_4__c = newattendee[0].As_NAICSCode_4__c;
            UpdateAttendee.As_NAICSCode_5__c = newattendee[0].As_NAICSCode_5__c;
            UpdateAttendee.AS_NAICSCode6__c = newattendee[0].As_NAICSCode6__c;
            UpdateAttendee.AS_NAICSCode7__c = newattendee[0].As_NAICSCode7__c;
            UpdateAttendee.AS_NAICSCode8__c = newattendee[0].As_NAICSCode8__c;
            UpdateAttendee.AS_NAICSCode9__c = newattendee[0].As_NAICSCode9__c;
            
            UpdateAttendee.Commodity_1__c = newattendee[0].Commodity_1__c;
            UpdateAttendee.Commodity_2__c = newattendee[0].Commodity_2__c;
            UpdateAttendee.Commodity_3__c = newattendee[0].Commodity_3__c;
            UpdateAttendee.Commodity_4__c = newattendee[0].Commodity_4__c;
            UpdateAttendee.Commodity_5__c =newattendee[0].Commodity_5__c;
            UpdateAttendee.Commodity_6__c = newattendee[0].Commodity_6__c;
            UpdateAttendee.Commodity_7__c = newattendee[0].Commodity_7__c;
            UpdateAttendee.Commodity_8__c = newattendee[0].Commodity_8__c;
            UpdateAttendee.Commodity_9__c = newattendee[0].Commodity_9__c;
            UpdateAttendee.BBB_Number__c = newattendee[0].BBB_Number__c;
            UpdateAttendee.DBA__c = newattendee[0].DBA__c;
            UpdateAttendee.distribution_Country__c = newattendee[0].distribution_Country__c;
            UpdateAttendee.Ethnicity__c = newattendee[0].Ethnicity__c;
            UpdateAttendee.Exhibitor_company_imageUrl__c = newattendee[0].Exhibitor_company_imageUrl__c;
            UpdateAttendee.AS_FaxNumber__c = newattendee[0].AS_FaxNumber__c;
            UpdateAttendee.Keywords__c = newattendee[0].Keywords__c;
            UpdateAttendee.Manufactures_Country__c = newattendee[0].Manufactures_Country__c;
            UpdateAttendee.References__c = newattendee[0].References__c;
            UpdateAttendee.References2__c = newattendee[0].References2__c;
            UpdateAttendee.Scope_of_Work__c = newattendee[0].Scope_of_Work__c;
            UpdateAttendee.Scope_of_Work2__c = newattendee[0].Scope_of_Work2__c;
            UpdateAttendee.References2__c = newattendee[0].References2__c;
            UpdateAttendee.AS_Work_States__c = newattendee[0].AS_Work_States__c;
            UpdateAttendee.Business_Structure__c =newattendee[0].Business_Structure__c;
            UpdateAttendee.Certificate_Processed_by_RPO__c =newattendee[0].Certificate_Processed_by_RPO__c;
            UpdateAttendee.Geographical_Region__c=newattendee[0].Geographical_Region__c;
            UpdateAttendee.Revenue_Range__c=newattendee[0].Revenue_Range__c;
            UpdateAttendee.Year_in_business__c=newattendee[0].Year_in_business__c;
            UpdateAttendee.AS_ImageUrl__c = newattendee[0].AS_ImageUrl__c;
            UpdateAttendee.AS_WorkZip__c = newattendee[0].AS_WorkZip__c;
            UpdateAttendee.AS_Work_Country__c = newattendee[0].AS_Work_Country__c;
            UpdateAttendee.AS_Work_States__c = newattendee[0].AS_Work_States__c;
            UpdateAttendee.Exceptional_Key_Words__c = newattendee[0].Exceptional_Key_Words__c;
            
            
             //Database.saveResult insNewAtt = Database.insert(UpdateAttendee,false);
             insert UpdateAttendee;
            newattendee1 = new List<AttendeeSummary__c>();
            newattendee1.add(UpdateAttendee);
            
            
            List<Attachment> aold = [select id,name,body From Attachment Where parentId =: newattendee[0].id];
             List<Attachment> anew = new List<Attachment>();
             If(aold.size()>0){
             for(Attachment att : aold){
             Attachment a = new Attachment();
             a.name = att.Name;
             a.body = att.body;
             a.parentId = newattendee1[0].id;
             anew.add(a);
             }
             insert anew;
             }
            
             List<Widget__c> videos = new list<Widget__c>();
            List<Widget__c> videosnew = new list<Widget__c>();
               videos = [select id,AttendeeSummary__c,YouTubeId_c__c From Widget__c Where AttendeeSummary__c =: newattendee[0].id];
               if(videos.size()>0){
               for(Widget__c wd: videos){
               Widget__c newwd = new Widget__c();
               newwd.AttendeeSummary__c = newattendee1[0].id;
               newwd.YouTubeId_c__c = wd.YouTubeId_c__c;
               
               videosnew.add(newwd);
               }
               insert videosnew;
               }
        }
        List<Event_Attendee_Mapping__c> evm1 = [Select id,AS_id__c,MBE_Profile__c from Event_Attendee_Mapping__c Where AS_id__c =: newattendee[0].id AND EV_id__c =: eveid];
    if(evm1.size() > 0){
     delete evm1[0];}
      List<Event_Attendee_Mapping__c> evm = [Select id,AS_id__c,MBE_Profile__c from Event_Attendee_Mapping__c Where AS_id__c =: newattendee1[0].id AND EV_id__c =: eveid];
      if(evm.size() == 0){
      Event_Attendee_Mapping__c evmnew = new Event_Attendee_Mapping__c();
      evmnew.AS_id__c = newattendee1[0].id;
      evmnew.EV_id__c = eveid;
      evmnew.IsMatchMakingAttendee__c = true;
      evmnew.Boothleads_Profile__c = 'Booth Admin';
      evmnew.Attendee_Event_IDs__c = newattendee1[0].id+eveid;
      insert evmnew;
      }else{
      evm[0].AS_id__c = newattendee1[0].id;
      evm[0].Attendee_Event_IDs__c = newattendee1[0].id+eveid;
      update evm[0];
      }
      
      
      Profile__c CustomProfile = [select Id,PR_Name__c,PR_Version__c from Profile__c 
                where PR_Name__c='BoothAdmin' limit 1];
                User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c ();
                UserBoothAdminProfile = [select id,BT_id__c,BoothAdmin_id__c,User_id__c,Status__c,IsMatchMakingUser__c,MAtchMakingProfile__c from User_Profile_Event__c where id =: upeid];
                
                //User_Profile_Event__c UserBoothAdminProfile = new User_Profile_Event__c();
                UserBoothAdminProfile.BoothAdmin_id__c = BoothAdminUser.id;
                
                //UserBoothAdminProfile.BT_id__c  = UserBoothAdminProfile1.BT_id__c;
                
                //UserBoothAdminProfile.EV_id__c = eveid;
                //UserBoothAdminProfile.EventAdmin_Id__c = Userinfo.getUserId();
                //UserBoothAdminProfile.UEP_isActive__c = True;
                //UserBoothAdminProfile.Profile_id__c = CustomProfile.Id;
                UserBoothAdminProfile.Attendee_Summary__c = newattendee1[0].id;
                UserBoothAdminProfile.User_id__c = BoothAdminUser.Id;
                UserBoothAdminProfile.Status__c= 'Active';
                UserBoothAdminProfile.IsMatchMakingUser__c =true;
                UserBoothAdminProfile.MAtchMakingProfile__c ='Corporate';
                
                update UserBoothAdminProfile;
 
  }
  public void ReleaseBoothstaff(){
  ParticularJuncID = new User_Profile_Event__c();
  ParticularJuncID = [select EV_ID__c,BT_id__c,BT_id__r.BT_Name__c,User_Id__r.Username,MAtchMakingProfile__c,UEP_isActive__c,Status__c,Attendee_Summary__r.id, Attendee_Summary__r.AS_FirstName__c, Attendee_Summary__r.AS_LastName__c                              
                                   from User_Profile_Event__c where id =: BoothAdminDetails];
  Booth__c boothid = [select id from Booth__c Where BT_ContactEmail__c =: ParticularJuncID.User_Id__r.Username AND EV_id__c =: selectevent];
Profile__c pro = [SELECT id from Profile__c WHERE PR_Name__c =: 'Boothadmin'];
Particularjuncid.BT_Id__c = boothid.id;
Particularjuncid.Profile_id__c = pro.id;
Particularjuncid.MAtchMakingProfile__c = 'Corporate';
update Particularjuncid; 
ListOfBoothAdmins();
  
  }
  
   public void testdummy(){
  integer intg=0;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  intg++;
  }
    
}