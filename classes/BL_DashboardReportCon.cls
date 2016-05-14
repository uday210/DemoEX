public without sharing class BL_DashboardReportCon {

   public PageReference closePopup()
    {
      
        EditReportPanel=false;
        ShowReportList=true;
        return null;
   }

    public PageReference Back() {
    
    ShowReport=false;
    ShowScanReport=false;
    ShowReportList=true;
    ShowHourlyScansReport=false;
        return null;
    }


    public PageReference SaveReport() {
    
    update EditReport;
    ShowReportsList();
    EditReportPanel = false;
     ShowReportList=true;
        return null;
    }


    public void EditReport() {
    EditReportPanel = true;
    EditReport=[Select id,RE_Name__c,RE_Description__c From Reports__c where id =: EditId ];
    ShowReportList=false;
    
    system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEE'+EditId +' JJJJJJJJJJJJJJJJJJJJ'+EditPanel);
   // return null;
    }
    public Boolean EditPanel{get; set;}
    public Boolean EditReportPanel{get; set;}
    public Reports__c EditReport{get; set;}
    public string  EditId{get; set;}
    public boolean ShowPickList{get; set;}
    public boolean ShowIndustryReport { get; set; }
    public boolean ShowReportList { get; set; }
    public boolean ShowGeographyReport{ get; set; }
    public boolean ShowRatingReport{ get; set; }
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
    public List<PieDataForScans> BoothScans{get; set;}
public boolean booleanforDisplayBoothadminTab {get; set;}


public BL_DashboardReportCon (){
URLEvent();
EditPanel = false;

ShowReportList=true;
ShowPickList=true;
ShowReport= false;
//EventReportName();
forPaginationIds= new MAP<ID, Boolean> ();
     List<User_Profile_Event__c> BoolforDisplayBoothadminTab = new List<User_Profile_Event__c>();
     List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
     BoolforDisplayBoothadminTab = [select Profile_id__c,Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:UserInfo.getUserNAme() and status__c!='Inactive' and status__c!='Mobile only access'];
     system.debug('nnnnnnnnnnnnnnnnnnnnn '+BoolforDisplayBoothadminTab );
     for(User_Profile_Event__c ty:BoolforDisplayBoothadminTab )
     {
     if(ty.Profile_id__r.PR_Name__c =='BoothAdmin')
     {
       booleanforDisplayBoothadminTab =true;
     } 
     }
   
    Events();
      ShowReportsList();
     
}

   
    
    public string EventId{get; set;}
    public string ReportId{get; set;}
    public list<User_Event_BVS__c> GeograpyRecords{get; set;}
    public list<User_Event_BVS__c> IndustryRecords{get; set;} 
    public Reports__c ReportName{get; set;}
    public List<User_Event_BVS__c > ForPaginationBoothAdminsList{get;set;} 
    
    
    public PageReference login() {
   if(userInfo.getUserType()=='guest'){
    Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
    pg.setredirect(true);
        return pg;
   
   }
   
   List<User_Profile_Event__c> ty =new  List<User_Profile_Event__c>();
      ty=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() and Profile_id__r.PR_Name__c='eventadmin'];
       if(ty.size()>0){
       Pagereference pg = new pagereference('/apex/BL_EA_Dashboard');
       pg.setredirect(true);
        return pg;
       
       }else{
       return null;
       }   
      
  }
  public String SelectedDate { get; set; }
    public void EventReportName()
      {
     login();
     EventId=ApexPages.currentPage().getparameters().get('EventId');
     ReportId=ApexPages.currentPage().getparameters().get('ReportName');
     SelectedDate =ApexPages.currentPage().getparameters().get('EventDate');
     system.debug('!!!!!!!!!!!!!!!!!!!!!'+EventId+ReportId+SelectedDate );
     
       if((EventId != null) && (ReportId != null))
       {
       eventselected= EventId;
       Report = ReportId; 
       DisplayReport();  
      /** if(Report == 'Report By Hourly Scans' && SelectedDate!= '' )  
       {
       
       DisplayReport(); 
       EventDates = SelectedDate; 
       system.debug('XXXXXXXXXXXXXXXXXXXXXXXx'+EventDates);
       }
       else{
       DisplayReport();  
     }  **/
      }
      else
      {
      //eventselected=defaultEvent;
      ShowReportList=true;
       Events();
      ShowReportsList();
      }
      }
      
      
      public String eventSelected { get; set; }
      public List<Event__c> EvntsForPicklist {get; set;}
      public string defaultEvent {get; set;}
      public List<selectOption> getselectEvents{get;set;}
      
      public void Events(){
       List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
       EvntsForPicklist = new List<Event__c>();
       upeForEvents = [Select u.User_id__c,u.Profile_id__r.PR_Name__c,
                       u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, 
                       u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, 
                       u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, 
                       u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, 
                       u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c 
                       u where u.User_id__r.Email=:UserInfo.getUserName() and (Status__c!='Mobile only access' 
                       And Status__c!='InActive') ];
     
     
     
       set<Id> setOfEventIds = new set<Id>();
           for(User_Profile_Event__c rotatinnFor:upeForEvents){
           setOfEventIds.add(rotatinnFor.EV_id__c);
           }
 
       EvntsForPicklist =[select  id,EV_Title__c from Event__c where id in :setOfEventIds order by EV_StartDate__c];
         //  if(EvntsForPicklist.size()>0){
          // defaultEvent =EvntsForPicklist[0].id;
          // }
         getselectEvents = new List<selectOption>();
           for(Event__c Event:EvntsForPicklist ){
           getselectEvents.add(new SelectOption(Event.id,Event.EV_Title__c));
           if(Id == null || id == '')
           eventSelected = Event.id;
           }
           ShowReportsList();
       
     }
     
     
     
     public List<Reports__c> boothPerReports {get; set;}
    
     
     
     public PageReference ShowReportsList() {
     ShowReport=false;
     ShowReportList=true;
     showScanReport = False;
     ShowHourlyScansReport = False;
     system.debug('hi chinna  '+eventSelected);
      system.debug('XXXXXXXXXXXXXXXXXXXXXXX'+eventselected);
     boothPerReports = new List<Reports__c> ();
    if(eventSelected !=null && eventSelected !=''){
     boothPerReports =[Select id,r.RE_Name__c, r.RE_Description__c From Reports__c 
                        r where r.UPE_id__r.User_id__r.Email=:UserInfo.getUserName() 
                        and UPE_id__r.EV_id__c=:eventSelected order by createdDate];
     system.debug('~~~~~~~~~~~~~~~~~'+boothPerReports );
     /** for(Reports__c tt:boothPerReports){
      tt.RE_Name__c =escapeSpecialCharacters(tt.RE_Name__c);
      tt.RE_Description__c=escape(escapeSpecialCharacters(tt.RE_Description__c));
     }
    */
    
    }
     return null;
    }
  
    
   
    public transient list<User_Event_BVS__c > Records{get; set;}
    public boolean ShowReport{get; set;}
    public string Report{get; set;}
    public integer SCount{get; set;}
    public string UserFirstName{get; set;}
    public string UserLastName{get; set;}
    public List<PieDataForScans > Scans{get; set;}
    public LIST<AggregateResult> ScanCount {get; set;}
    public boolean ShowScanReport{get; set;} 
    public boolean ShowHourlyScansReport {get; set;}
    public String UserId {get;set;}
    public Boolean CheckBox{get;set;}
    
    public void ForPagnation(){
    Records= new list<User_Event_BVS__c >();
    //ShowGeographyReport=true;
   
    system.debug('***********************'+Report);
    ShowReport=true;
    ShowReportList=false;
    if(Report=='Report By Geography')
    {
    system.debug('$$$$$$$$$$$$$$$$$$$$$$'+Report);
    ShowGeographyReport=true;
    ShowIndustryReport =false;
    ShowRatingReport=false;
    Records=[SELECT BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c,BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c,
             BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c,BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, 
             BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c,Checkbox_For_Report__c,BVS_id__r.BVS_LeadRating__c 
             FROM User_Event_BVS__c 
             WHERE ((EV_id__c  =: eventselected AND UPE_id__r.BoothAdmin_id__c=:userinfo.getUserId() and 
             BVS_id__r.EA_AttendeeBarcode__c!=null  ) OR
             (EV_id__c  =: eventselected AND UPE_id__r.User_id__c =:userinfo.getUserId() and 
             BVS_id__r.EA_AttendeeBarcode__c!=null )) ORDER BY BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c ASC
              ];
             system.debug('####################'+Records);
    } 
     if(Report=='Report By Industry')
    {
    system.debug(')))))))))))))))))))))))'+Report);
      ShowIndustryReport =true;
       ShowGeographyReport=false;
       ShowRatingReport=false;
      Records= [SELECT BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c,BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c,
                        BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c,BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, 
                        BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c,Checkbox_For_Report__c,
                        BVS_id__r.BVS_LeadRating__c
                        FROM User_Event_BVS__c 
                        WHERE ((EV_id__c  =: eventselected AND UPE_id__r.BoothAdmin_id__c=:userinfo.getUserId() AND BVS_id__r.EA_AttendeeBarcode__c!=null ) OR
                        (EV_id__c  =: eventselected AND UPE_id__r.User_id__c=:userinfo.getUserId() AND BVS_id__r.EA_AttendeeBarcode__c!=null 
                        ))  ORDER BY BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c ASC
                         ];
                     system.debug('&&&&&&&&&&&&&&&&&&&&&'+Records);
    
    } 
     if(Report== 'Report By Lead Rating')
     {
     ShowRatingReport= true;
     ShowIndustryReport =false;
       ShowGeographyReport=false;
     Records=[ Select id,BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c,BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c,
              BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, 
               BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c,u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, 
               u.BVS_id__r.BVS_FollowUps__c, u.BVS_id__r.User_id__c, u.BVS_id__r.EA_AttendeeBarcode__c, 
               u.BVS_id__r.BVS_SurveyAnswer4__c, u.BVS_id__r.BVS_SurveyAnswer3__c, u.BVS_id__r.BVS_SurveyAnswer2__c,
               u.BVS_id__r.BVS_SurveyAnswer1__c, u.BVS_id__r.BVS_SurveyQuestion4__c, u.BVS_id__r.BVS_SurveyQuestion3__c,
               u.BVS_id__r.BVS_SurveyQuestion2__c, u.BVS_id__r.BVS_SurveyQuestion1__c, u.BVS_id__r.BVS_Tags__c,
               u.BVS_id__r.BVS_LeadType__c, u.BVS_id__r.BVS_LeadRating__c, u.BVS_id__r.BVS_Budget__c, 
               u.BVS_id__r.BVS_Notes__c, u.BVS_id__r.BVS_City__c, u.BVS_id__r.BVS_State__c, u.BVS_id__r.BVS_Title__c,
               u.BVS_id__r.BVS_Email__c, u.BVS_id__r.BVS_PhoneNumber__c, u.BVS_id__r.BVS_LeadCategory__c, 
               u.BVS_id__r.BVS_Company__c, u.BVS_id__r.BVS_LastName__c, u.BVS_id__r.BVS_FirstName__c, 
               u.BVS_id__r.LastActivityDate, u.BVS_id__r.SystemModstamp, u.BVS_id__r.LastModifiedById, 
               u.BVS_id__r.LastModifiedDate, u.BVS_id__r.CreatedById, u.BVS_id__r.CreatedDate, u.BVS_id__r.Name,
               u.BVS_id__r.IsDeleted, u.BVS_id__r.OwnerId, u.BVS_id__r.Id, u.BVS_id__c ,Checkbox_For_Report__c
               From User_Event_BVS__c u 
               where ((u.UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() and 
               u.UPE_id__r.UEP_isActive__c =true and BVS_id__c!=null and u.EV_id__c=:eventSelected) 
               OR (u.UPE_id__r.User_id__c=:UserInfo.getUserId() and u.UPE_id__r.UEP_isActive__c=true and
               u.EV_id__c=:eventSelected and BVS_id__c!=null)) and  (BVS_id__r.EA_AttendeeBarcode__c!=null) 
               order by u.BVS_id__r.BVS_LeadRating__c];   
       
     }
         if(Report == 'Report By Booth Admin and Booth User Scans') 
           {
           ShowScanReport= true;
           showReport= false;
           ShowRatingReport= false;
           ShowIndustryReport =false;
           ShowGeographyReport=false;
           BoothAdminScanMethod();
           system.debug( ' AAAAAAAAAAAAAAAAAAA BBBBBBBBBBBBBBBBBBBB CCCCCCCCCCCCCCCCCCCC'+Scans);  
        
        }
        
        if(Report == 'Report By Booth User Scans') 
           {
           ShowScanReport= true;
           showReport= false;
           ShowRatingReport= false;
           ShowIndustryReport =false;
           ShowGeographyReport=false;
           BoothAdminScanMethod();
           system.debug( ' AAAAAAAAAAAAAAAAAAA BBBBBBBBBBBBBBBBBBBB CCCCCCCCCCCCCCCCCCCC'+Scans);  
        
        }
        if(Report == 'Report By Hourly Scans')
        {
        system.debug('###############@@@@@@@@@@@@@@!!!!!!!!!!!!');
           ShowScanReport= false;
           showReport= false;
           ShowRatingReport= false;
           ShowIndustryReport =false;
           ShowGeographyReport=false;
           ShowHourlyScansReport=true;
           pickdate();
           hourlyscanchart();
           
        }
    
    }
    
    public boolean ShowBoothAdminReport {get; set;}
    public boolean ShowBoothUserReport {get; set;}
    public void BoothAdminScanMethod()
    {
    Scans= new List<PieDataForScans >();
        
 set<id> setOfBvs = new set<id>();
 
 if(Report == 'Report By Booth Admin and Booth User Scans')
 {
 ShowBoothAdminReport= true;
 for(User_Event_BVS__c lusres:[select BVS_id__r.id,BVS_id__c from User_Event_BVS__c 
                               where EV_id__r.Id=: eventSelected and UPE_id__r.BoothAdmin_id__c =: userinfo.getuserid()]){
  setOfBvs.add(lusres.BVS_id__r.id); 
   system.debug('*********************!!!!!!!!!!!'+setOfBvs);     
 }
 }
 
 if(Report == 'Report By Booth User Scans')
 {
 ShowBoothUserReport =true;
 for(User_Event_BVS__c lusres:[select BVS_id__r.id,BVS_id__c from User_Event_BVS__c 
                               where EV_id__r.Id=: eventSelected and UPE_id__r.User_id__c=: userinfo.getuserid()]){
  setOfBvs.add(lusres.BVS_id__r.id);
 }
 }
  
  for(SObject listOfobj:[select count(id) re,User_id__r.FirstName f,User_id__r.LastName l,
                         User_id__r.id c,User_id__c from BoothVisitSummary__c where EA_AttendeeBarcode__c!=null and ID IN :setOfBvs  group BY User_id__c,User_id__r.FirstName,User_id__r.LastName,User_id__r.id order by count(id) DESC]){ 
      
      
      SCount=(integer)listOfobj.get('re');
     
      UserFirstName=(string)listOfobj.get('f');
     
      UserLastName=(string)listOfobj.get('l');
      
      //UserId = (id)listOfobj.get('c');
     // CheckBox = (Boolean)listOfobj.get('cb');
 
   Scans.add(new PieDataForScans (UserFirstName,UserLastName,SCount)); 
   system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+Scans); 
  }
    }
    
    public Integer RecordsCount{get; set;}
    public Integer Record{get; set;}
    public PageReference DisplayReport() {
    
    ForPagnation();
    
        try{
        ForPaginationBoothAdminsList= new List<User_Event_BVS__c >(); 
         
        if(Records.size() != 0){ 
        system.debug( ' IIIIIIIIIIIIIIIIIIIIIIIIII ');                     
       if(Records.size()>0)
        {
        RecordsCount= Records.size();
        //  HideTable = True;
        // system.debug( ' ---------------------------- @@@@@@@@@@@@@@@@@@ '+HideTable);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=Records.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(Records.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=Records.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(Records.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<50;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+Records[i]);
        
        ForPaginationBoothAdminsList.add(Records[i]);
        if(Records.size() < 50){
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
        Record=i+1;
        }
        
        } 
        } else if(Scans.size()>0)
        {
        RecordsCount=Scans.size();
        BoothScans = new List<PieDataForScans>();
        //  HideTable = True;
        // system.debug( ' ---------------------------- @@@@@@@@@@@@@@@@@@ '+HideTable);
         conlst=true;
        // hasLast = True;
       //  hasFirst = False;
         count=Scans.size();
       //  hasPrevious =false;
       //  hasNext=true;
         pageno=1;
          if(math.mod(Scans.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=Scans.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(Scans.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<50;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+scans);
        
        BoothScans.add(Scans[i]);
        system.debug( ' ----------- SSSSSSSSSSSSSSSSSSs '+BoothScans);
        if(Scans.size() < 50){
     
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
        Record=i+1;
        }
        } 
        
        
    }catch(Exception ex){
    
    }    
         
    return null;
}

    // Code for Exporting the leads 
    public string ExportBVSId{get; set;}
    public pagereference pg {get; set;}
    public List<User_Event_BVS__c > BVSList {get; set;}
    public List<PieDataForScans> BVScanlist {get; set;}
    public boolean ShowUserEventCSV {get; set;}
    public boolean ShowBoothScanCSV{get; set;}
    public boolean ShowHourlyScanCSV{get; set;}
    
    public PageReference seltoexport() {
    
   system.debug('QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ'+Report);
        if(Report == '' || Report  == null){
     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Select at least one lead'));
    return null;
    }else if ((null != Report && ''!= Report) ){
    BVSList = new List<User_Event_BVS__c >();
    
    if(Report== 'Report By Booth User Scans')
    {
    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!' );
      // BVScanlist= new List<PieDataForScans> ();
      // BVScanlist=checkBVSListForBoothAdminScans(Report);
      BoothAdminScanMethod();
      pg =page.BL_ExportToCsvReport; 
      ShowUserEventCSV=false;
      ShowBoothScanCSV=true;
      ShowHourlyScanCSV=false;
    } 
    
    if(Report== 'Report By Booth Admin and Booth User Scans')
    {
    system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@!!!!!!!!!!!!!!!!!!' );
      // BVScanlist= new List<PieDataForScans> ();
      // BVScanlist=checkBVSListForBoothAdminScans(Report);
      BoothAdminScanMethod();
      pg =page.BL_ExportToCsvReport; 
      ShowUserEventCSV=false;
      ShowBoothScanCSV=true;
      ShowHourlyScanCSV=false;
    } 
    
     if(Report == 'Report By Hourly Scans')
    {
    hourlyscanchart();
     pg =page.BL_ExportToCsvReport; 
    ShowUserEventCSV=false;
    ShowBoothScanCSV=false;
    ShowHourlyScanCSV=true;
   
    
    }
    if((Report == 'Report By Industry') || (Report == 'Report By Geography') || (Report == 'Report By Lead Rating'))
     {
    BVSList = checkBVSList(Report);  
    system.debug('@@@@@@@@@@@@@@@@@@*****************!!!!!!!!!!'+BVSList );
    system.debug('Ramaaaaaaaaaaaaaaaaaaaa '+BVSList);  ShowReport=false;
    pg =page.BL_ExportToCsvReport;
    ShowUserEventCSV=true;
    ShowBoothScanCSV=false;
    
    }
    return pg;
 }else{
  
 return null;
 }
 
    }
    
    
    
     public List<User_Event_BVS__c > checkBVSList(String listOfBVS){
                // integer ph;
       List<User_Event_BVS__c >  localBVSListSelected = new List<User_Event_BVS__c > ();
  
     
  for(User_Event_BVS__c U:ForPaginationBoothAdminsList){
          
          if(U.Checkbox_For_Report__c == TRUE)
          
               forPaginationIds.put(U.id, U.Checkbox_For_Report__c);
               system.debug('&&&&&&&&&&&&&&&&&&&'+forPaginationIds);
       }   
  List<ID> selectedBVSList = new List<ID>();
  
 
         localBVSListSelected = [Select id,u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_CellPhone__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c, 
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c, 
                                u.BVS_id__r.BVS_FollowUps__c, u.BVS_id__r.User_id__c,
                                 u.BVS_id__r.EA_AttendeeBarcode__c,u.BVS_id__r.BVS_SurveyAnswer4__c, 
                                 u.BVS_id__r.BVS_SurveyAnswer3__c, u.BVS_id__r.BVS_SurveyAnswer2__c,
                                u.BVS_id__r.BVS_SurveyAnswer1__c, u.BVS_id__r.BVS_SurveyQuestion4__c,
                                 u.BVS_id__r.BVS_SurveyQuestion3__c,u.BVS_id__r.BVS_SurveyQuestion2__c,
                                  u.BVS_id__r.BVS_SurveyQuestion1__c, u.BVS_id__r.BVS_Tags__c,
                                  u.BVS_id__r.Follow_Update__c,
                               u.BVS_id__r.BVS_LeadType__c, u.BVS_id__r.BVS_LeadRating__c, u.BVS_id__r.BVS_Budget__c, 
               u.BVS_id__r.BVS_Notes__c, u.BVS_id__r.BVS_City__c, u.BVS_id__r.BVS_State__c, u.BVS_id__r.BVS_Title__c,
               u.BVS_id__r.BVS_Email__c, u.BVS_id__r.BVS_PhoneNumber__c, u.BVS_id__r.BVS_LeadCategory__c, 
               u.BVS_id__r.BVS_Company__c, u.BVS_id__r.BVS_LastName__c, u.BVS_id__r.BVS_FirstName__c, 
               u.BVS_id__r.LastActivityDate, u.BVS_id__r.SystemModstamp, u.BVS_id__r.LastModifiedById, 
               u.BVS_id__r.LastModifiedDate, u.BVS_id__r.CreatedById, u.BVS_id__r.CreatedDate, u.BVS_id__r.Name,
               u.BVS_id__r.IsDeleted, u.BVS_id__r.OwnerId, u.BVS_id__r.Id, u.BVS_id__c ,Checkbox_For_Report__c
               From User_Event_BVS__c u 
               where id in :forPaginationIds.KeySet() ];
         
        if(localBVSListSelected.size()>0){
            for(User_Event_BVS__c rt : localBVSListSelected ){
                if(rt.BVS_id__r.Follow_Update__c !=null){
                    rt.BVS_id__r.Follow_Update__c =getLocalDateTime(rt.BVS_id__r.Follow_Update__c);
                }
                if(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c != null && rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c!=''){
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c=escape(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.As_prefixNew__c);
                }
                if(rt.BVS_id__r.BVS_FirstName__c != null && rt.BVS_id__r.BVS_FirstName__c!=''){
                system.debug('777777777777777777 '+rt.BVS_id__r.BVS_FirstName__c);
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =escape(rt.BVS_id__r.BVS_FirstName__c); 
                }else{
              rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c =escape(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_FirstName__c); 
                }
                
                if(rt.BVS_id__r.BVS_lastName__c != null && rt.BVS_id__r.BVS_LastName__c!=''){
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =escape(rt.BVS_id__r.BVS_LastName__c); 
                }   else{
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c =escape(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_LastName__c); 
                }    
                
                if(rt.BVS_id__r.BVS_Title__c != null && rt.BVS_id__r.BVS_Title__c!=''){
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.BVS_id__r.BVS_Title__c); 
                } else{
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c); 
                }
                
                if(rt.BVS_id__r.BVS_Email__c!= null && rt.BVS_id__r.BVS_Email__c!=''){
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c=escape(rt.BVS_id__r.BVS_Email__c); 
                } else{
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Title__c =escape(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Email__c); 
                }
                
                
                
                if(rt.BVS_id__r.BVS_Company__c != null && rt.BVS_id__r.BVS_Company__c !=''){
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =escape(rt.BVS_id__r.BVS_Company__c); 
                } else{
               rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c =escape( rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Company__c); 
                }
                
                
                if(rt.BVS_id__r.BVS_PhoneNumber__c != null && rt.BVS_id__r.BVS_PhoneNumber__c !=''){
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =escape(rt.BVS_id__r.BVS_PhoneNumber__c); 
                }  else{
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c =escape(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_WorkPhone__c); 
                }
                
             
                
                
                if(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c!=null && string.ValueOf(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c).startswith('0')){
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c ='"=TEXT('+rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c+','+'\""00000\"")"';
                }else if(rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c !=null){
                
                rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c =rt.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_HomeZip__c;
                }
                
            
            }
        } 
    
       return localBVSListSelected;
  }
  
  public string escape(string s){
  if(s != null && s.contains(',')){
     s=s.replaceAll('"','');
     s='"'+s+'"';
   } 
    return s;
 }
    
    
   public String escapeSpecialCharacters(String input){
    if(input!= null && input != '' && (input.contains('\\') )){
       input = input.replace('\\','\\\\');
       }
       if(input!= null && input != '' && (input.contains('"') )){
       input = input.replace('"','');
       }
      
      return input;
    }
  
  public static Datetime getLocalDateTime(Datetime z){    
        Datetime l = z.Date();
        l = l.addHours(z.hour());
        l = l.addMinutes(z.minute());
        l = l.addSeconds(z.second());
        
        return l;
    }
  // Export Method for Booth Admin Scans
  
     
  
    // Inner class for Booth Admin Scans
    
  public class PieDataForScans {
  
       // public Boolean UserId{get;set;}
      //  public Id BoothSummaryUserId{get;set;}
        public String fname { get; set; }
        public String lname { get; set; }
        public Integer data { get; set; }

        public PieDataForScans (String fname,String lname,Integer data) {
            this.fname = fname;
            this.lname = lname;
            this.data = data;
           // this.UserId = BUserId;
           // this.BoothSummaryUserId = BSUserId;
           
        }
    }
    
    Public void First()
     {  
     
     for(User_Event_BVS__c U:ForPaginationBoothAdminsList){
          
          if(U.Checkbox_For_Report__c == TRUE)
               forPaginationIds.put(U.id, U.Checkbox_For_Report__c);
               system.debug('&&&&&&&&&&&&&&&&&&&'+forPaginationIds);
       }
       
        
     try{
     ForPagnation();
         hasNext=true;
         hasFirst = false;
         hasPrevious=false;
         hasLast = True;
         Disabled_Previous_Icon = True;
         Disabled_First_Icon = True;
         Disabled_Next_Icon = False;
         Disabled_Last_Icon = False;
         ForPaginationBoothAdminsList.clear();
         //hasPrevious=false;
         pageno =1;
         for(integer i=0;i<10;i++)
          {
          
          if(forPaginationIds.containsKey(Records[i].id)){
                        
                            User_Event_BVS__c checkedAcc = Records[i];
                            checkedAcc.Checkbox_For_Report__c=  forPaginationIds.get(Records[i].id);
                            ForPaginationBoothAdminsList.add(checkedAcc);
                        }
                        else{
                     ForPaginationBoothAdminsList.add(Records[i]);
                     }
          //ForPaginationBoothAdminsList.add(Records[i]);
          
         }
         if(math.mod(Records.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=Records.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(Records.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            }catch(Exception ex){
     
     }
     }
     
     public set<ID> setids{get;set;}
      public string UPEid{get;set;}
      public MAP<ID, Boolean> forPaginationIds{get; set;}
      
         Public void Previous()
              {   
     
     for(User_Event_BVS__c U:ForPaginationBoothAdminsList){
          
          if(U.Checkbox_For_Report__c == TRUE)
               forPaginationIds.put(U.id, U.Checkbox_For_Report__c);
       }
     
       try{ 
       ForPagnation();
          hasLast=True;
          hasNext=true;
          Disabled_Previous_Icon = False;
          Disabled_First_Icon = False;
          Disabled_Next_Icon = False;
          Disabled_Last_Icon = False;
          
         ForPaginationBoothAdminsList.clear();
         if(pageno  !=1)
             {    
                  system.debug( ' PPPPPPPPPPPPPPPPPP'+Disabled_Previous_Icon);
                  system.debug( ' FFFFFFFFFFFFFFF'+Disabled_First_Icon);
                  
                  pageno  = pageno  - 1;
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
                     
                     if(forPaginationIds.containsKey(Records[i].id)){
                        
                            User_Event_BVS__c checkedAcc = Records[i];
                            checkedAcc.Checkbox_For_Report__c=  forPaginationIds.get(Records[i].id);
                            
                            
                            ForPaginationBoothAdminsList.add(checkedAcc);
                        }
                        else{
                     ForPaginationBoothAdminsList.add(Records[i]);
                     }
                     
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
                     
                     if(forPaginationIds.containsKey(Records[i].id)){
                        
                            User_Event_BVS__c checkedAcc = Records[i];
                            checkedAcc.Checkbox_For_Report__c=  forPaginationIds.get(Records[i].id);
                            ForPaginationBoothAdminsList.add(checkedAcc);
                        }
                        else{
                     ForPaginationBoothAdminsList.add(Records[i]);
                     } 
                         //ForPaginationBoothAdminsList.add(Records[i]); 
                      }
              }
       }
       catch(Exception ex){
     
     }
     }
       
            Public void Next()
                  {   
                 
     for(User_Event_BVS__c U:ForPaginationBoothAdminsList){
          
          if(U.Checkbox_For_Report__c == TRUE)
               forPaginationIds.put(U.id, U.Checkbox_For_Report__c);
       }
                  
                  try{
         ForPagnation();
         pageno  = pageno +1;
        // integer pgno;
         ForPaginationBoothAdminsList.clear();
         if(math.mod(Records.size(),10)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=Records.size()/10;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(Records.size()/10) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            if(pageno==pgno)
             { 
                  hasNext=false;
                  hasLast = False;
                  Disabled_Next_Icon = True;
                  Disabled_Last_Icon = True;
                  for(integer i=(pageno -1)*10;i<Records.size();i++ )
                    {
                    if(forPaginationIds.containsKey(Records[i].id)){
                        
                            User_Event_BVS__c checkedAcc = Records[i];
                            checkedAcc.Checkbox_For_Report__c=  forPaginationIds.get(Records[i].id);
                            ForPaginationBoothAdminsList.add(checkedAcc);
                        }
                        else{
                     ForPaginationBoothAdminsList.add(Records[i]);
                     } 
                    
                    }
             }
           else            
            for(integer i=(pageno -1)*10;i<(pageno *10);i++ )
              {
                    if(forPaginationIds.containsKey(Records[i].id)){
                        
                            User_Event_BVS__c checkedAcc = Records[i];
                            checkedAcc.Checkbox_For_Report__c=  forPaginationIds.get(Records[i].id);
                            ForPaginationBoothAdminsList.add(checkedAcc);
                        }
                        else{
                     ForPaginationBoothAdminsList.add(Records[i]);
                     } 
             }
            hasPrevious=true;
            hasFirst = True;
            Disabled_Previous_Icon = False;
            Disabled_First_Icon = False;
            
       
     }catch(Exception Ex){
     
     }
     
     }
     
     Public void Last()     
     {  
     
     for(User_Event_BVS__c U:ForPaginationBoothAdminsList){
          
          if(U.Checkbox_For_Report__c == TRUE)
               forPaginationIds.put(U.id, U.Checkbox_For_Report__c);
       }
     
     try{
     ForPagnation();
         hasLast = False;
         Disabled_Last_Icon = True;
         System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
        hasPrevious=true;
        Disabled_Previous_Icon=False;
        hasFirst = true;
        Disabled_First_Icon=False;
        ForPaginationBoothAdminsList.clear();
         hasNext=false;
          Disabled_Next_Icon=True;
        if( math.mod(Records.size(),10)==0){
          System.debug('---------44444444444444444----'+pageno );
             pageno =Records.size()/10;
             System.debug('-----------------pageno ----'+pageno );
           } else {
           System.debug('---------44444444444444444----'+pageno );
            pageno =(Records.size()/10) +1; 
            }
         for(integer i=(pageno -1)*10;i<Records.size();i++)
          {
              if(forPaginationIds.containsKey(Records[i].id)){
                        
                            User_Event_BVS__c checkedAcc = Records[i];
                            checkedAcc.Checkbox_For_Report__c=  forPaginationIds.get(Records[i].id);
                            ForPaginationBoothAdminsList.add(checkedAcc);
                        }
                        else{
                     ForPaginationBoothAdminsList.add(Records[i]);
                     }  
         }
     }catch(Exception ex){
     }
     }
     
     
     
      //-------------------------------------- Hourly Scan Chart Start -----------------------------------------
    public list<hourlyscansinner> hourlyscans{get;set;}  
    public LIST<SelectOption> EventDate{get; set;} 
    public  Event__c eventtime{get; set;}  
    public Integer eventStartTime{get; set;}
    public Integer eventEndTime{get; set;} 
    public String EventDates { get; set; }
    public Boolean checkeventdates{get;set;}
    public AggregateResult[] scanchart{get;set;}
    public LIST<ID> eventsList{get; set;}
    public Integer maxValueHourly{get; set;}
    public boolean ShowHourPickList{get; set;}
    public Integer eventdays {get; set;}
    
public void hourlyscanchart()
{ 


   hourlyscans = new LIST<hourlyscansinner>();
           //ShowReport=true;
           ShowHourPickList=true;
 try{
 
 EventDate = new LIST<SelectOption>();
  system.debug('EEEEEEEEEEEEEEEEEEEE'+eventselected);
 eventtime = [SELECT id, EV_EndTime__c, StartTime__c,EV_StartDate__c,EV_EndDate__c FROM Event__c WHERE ID =: eventselected];
     system.debug('SSSSSSSSSSSSSSSSSSSSSSSSSSSSS'+eventtime );        
 eventStartTime = Integer.ValueOf(eventtime.StartTime__c.SubString(0,eventtime.StartTime__c.lastIndexOf(':')));
  system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+eventStartTime );  
  if(SelectedDate == null || SelectedDate == '')
  {
   EventDates=String.valueOf(eventtime.EV_StartDate__c);                 
   eventdays = eventtime.EV_StartDate__c.daysBetween(eventtime.EV_EndDate__c);
   }
   else{
   EventDates= SelectedDate ;
   eventdays = eventtime.EV_StartDate__c.daysBetween(eventtime.EV_EndDate__c);
   }
 
 
 if(eventdays >0)
 {  
  //checkeventdates=true;
  date startdate=eventtime.EV_StartDate__c; 
  for(Integer i=0; i<=eventdays ; i++ )
  {
  
   EventDate.add(new SelectOption(String.valueOf(startdate),String.valueOf(startdate)));
   startdate+=1; 
   
   system.debug('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'+EventDate); 
    
  }     
 }
 else if(eventdays==0)
 {
 system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+eventdays);  
  checkeventdates=false;
 }
 scannedChartByDate();
 }
 catch(exception e){}  
 }
 public void scannedChartByDate()
{
 system.debug('^^^^^^6'+EventDates);
try{
 String ssss =  eventtime.StartTime__c.SubString(0,eventtime.StartTime__c.lastIndexOf(':'));
 scanchart= new AggregateResult[]{};
 scanchart= [SELECT HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)),count(id)
             FROM User_Event_BVS__c 
             WHERE ((Ev_id__c =: eventselected
             AND DAY_ONLY(convertTimezone(BVS_id__r.ScanTime__c))=:Date.ValueOf(EventDates)
             AND UPE_id__r.BoothAdmin_id__c=:userinfo.getUserId() 
             AND HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)) != NULL 
             and BVS_id__r.EA_AttendeeBarcode__c!=null) OR (Ev_id__c =: eventselected
             AND DAY_ONLY(convertTimezone(BVS_id__r.ScanTime__c))=:Date.ValueOf(EventDates)
             AND UPE_id__r.User_id__c=:userinfo.getUserId() 
             AND HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)) != NULL 
             and BVS_id__r.EA_AttendeeBarcode__c!=null))
             GROUP BY HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)) 
             ORDER BY HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c))];
             system.debug('+++++++++++++++++++++++++++++++++++++'+scanchart);
             
  RecordsCount=scanchart.size();
 if(eventtime.EV_EndTime__c.contains('PM'))
 {
  eventEndTime = Integer.ValueOf(eventtime.EV_EndTime__c.SubString(0,eventtime.EV_EndTime__c.lastIndexOf(':')))+12;
 }
 else 
  eventEndTime = Integer.ValueOf(eventtime.EV_EndTime__c.SubString(0,eventtime.EV_EndTime__c.lastIndexOf(':')));
 
 MAP<Integer, Integer> scanTimes = new MAP<Integer, Integer>();
 
 maxValueHourly = 0;
 
 for(AggregateResult iq : scanchart)
 { 
  scanTimes.put((integer)iq.get('expr0'), (integer)iq.get('expr1'));
 } 
 
 for(Integer ii=eventStartTime; ii<= eventEndTime; ii++ )
 {
  system.debug('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqq '+scanTimes);
 if(scanTimes.containsKey(ii))
 {
 system.debug('dddddddddddddddddddddddddddd '+scanTimes);
  String s12 = (ii>12)?(ii-12)+':00 PM': ii+':00 AM';
  hourlyscans.add(new hourlyscansinner(ii, scanTimes.get(ii), (ii>12)?(ii-12)+'PM': ii+'AM' ));
  system.debug('^^^^^^^^^^^^^^^^^^^^^^^^'+hourlyscans);
  
  if(maxValueHourly  < scanTimes.get(ii))
  maxValueHourly = scanTimes.get(ii); 
 }
 else
 {
  system.debug('dddddddddddddddddddddddddddd '+scanTimes);
  hourlyscans.add(new hourlyscansinner(ii, 0,(ii>12)?(ii-12)+'PM': ii+'AM'));
  system.debug('VVVVVVVVVVVVVVVVVVVVVVVV'+hourlyscans);
 }    
 }  

 if(maxValueHourly == null){
  maxValueHourly =0;
 }
 else if(maxValueHourly <= 10){ 
  maxValueHourly =10;
 }
 else if(maxValueHourly <= 30){
  maxValueHourly = 30;
 } 
 else if(maxValueHourly <= 50){
  maxValueHourly = 50;
 } 
 else{
  Integer modmod = maxValueHourly / 100;    
  maxValueHourly = 100 *(modmod+1);    
 }
 }
 catch(exception e){}         
}

public void pickdate()
{

 hourlyscans = new LIST<hourlyscansinner>();
  
 scannedChartByDate();
 
}
//--------------------------------------- Hourly Scan Chart End ------------------------------------------
 //inner class for HourlyScans
    public class hourlyscansinner
      {
 
 
 public User_Event_BVS__c  bvs{get; set;} 
 public integer scanrecords{get;set;}
 public integer scantime{get;set;}
 public string sTime{get; set;}
 public hourlyscansinner(Integer i1, Integer i2, String stime)
 {
  scanrecords= i2; 
  scantime= i1;  
  if(sTime.contains('12'))
  {
    
    this.sTime = sTime;
   //this.sTime = sTime.subString(0, sTime.lastIndexOf('AM'))+ 'AM';
  }
  else
  {
   this.sTime = sTime;
  }   
 }
}

 // Added by Shruthi to populate selected Event in the before Tab on November 18th 
   
    public string id{get;set;}
    
    public void URLEvent(){  
      
    id = apexpages.currentpage().getparameters().get('id');  
        
   
    if(id != null && ( Apexpages.currentPage().getParameters().get('EventId') == null ||  Apexpages.currentPage().getParameters().get('EventId') == '')){ 
    
    eventSelected = id;
   } 
 }
   
}