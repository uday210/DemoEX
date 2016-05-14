public class BL_EA_renderdashboardcon {

    public pagereference gotoRegistration(){
        pagereference pf = new pagereference('/apex/BL_Registrations_Information?id='+eventString);
        return pf;
    }
    
    public pagereference gotoregistrationattendees(){
        pagereference pf = new pagereference('/apex/Report_on_Registration_Attendees?id='+eventString);
        return pf;
    }

    public String getBoothadminslist() {
        return null;
    }


    public PageReference exportBoothScans() {
   try{
    pagereference pg =page.BL_export_booth_scans;
     return pg;
   }catch(exception e){return null;}
    }


public integer TotalRec{get; set;}
public boolean showboothreport{get; set;}
public boolean GNEMSDCCheck{get; set;}



public integer SCount{get; set;}
     public string BoothName{get; set;}
     public List<PieDataForScans> Scans{get; set;}     

     public List<PieDataForScans > getBoothAdminScanData() {
        
        Scans= new List<PieDataForScans >();

 list<sObject> sob=[select count(id) C,UPE_id__r.BT_id__r.BT_Name__c N from User_Event_BVS__c where EV_id__c =: EventString 
                                    and UPE_id__r.BT_id__r.BT_Name__c != null group by  UPE_id__r.BT_id__r.BT_Name__c
                                    ORDER By count(id) DESC];
  system.debug('11111111111111111111111111111111'+ sob);
for(sobject U:sob)
{
system.debug('222222222222222222222222222222222'+ U);
SCount=(integer)U.get('C');
BoothName=(string)U.get('N');
Scans.add(new PieDataForScans (BoothName,SCount)); 
system.debug('222222hhhhhhhhhhhhhhhhh222222222'+ Scans);
}
TotalRec =  Scans.size();

        return Scans;
       
    }
    
     public class PieDataForScans {

        public string Bname { get; set; }
        public Integer data { get; set; }
       
        public PieDataForScans (string Bname, Integer data) {
       
            this.Bname = escape1(Bname);
            this.data = data;
        }
        
        
    public string escape1(string s){
    if(s != null && s.contains(',')){  
    s=s.replaceAll('"','');
    s=s.replaceAll(',',' ');
    } 
    return s;
    }
        
        
    }
  



//------------------------------------ Variable Declarations Start  ---------------------------------------
public Boolean selecteventList{ get; set; }
public Boolean Choosedreportsbool { get; set; }
public Boolean GeographyReportBool {get;set;}
public Boolean IndustryReportBool {get;set;}
public Boolean RevenueReportBool {get;set;}
public Boolean ticketReportBool{get;set;}
public Boolean DiversityReportBool{get;set;}
public Boolean RegReportBool{get;set;}
public Boolean PageReportBool {get;set;}
public Boolean EditReportBool {get;set;}
public LIST<Reports__c> reportTypes {get;set;}
public LIST<Reports__c> evntReports{get;set;}
public LIST<User_Profile_Event__c> events{get;set;}
public Reports__c editRep  {get;set;}
public String eventName {get;set;}
public String Eventstring{get;set;}
public String t{get;set;}
public String s{get;set;}
public String strNamesmult {get;set;}
public String gridtitle { get; set; }
public LIST<SelectOption> Items{get; set;}
public LIST<LIST<Event_Attendee_Mapping__c>> customers{get;set;}
public transient  LIST<Event_Attendee_Mapping__c> IndustryRecords{get;set;}
public LIST<Event_Attendee_Mapping__c> GeographyRecords{get;set;}
public LIST<Event_Attendee_Mapping__c> regRecords{get;set;}
public LIST<Event_Attendee_Mapping__c> revRecords{get;set;}
public LIST<Event_Attendee_Mapping__c> divRecords{get;set;}
public LIST<Event_Attendee_Mapping__c> tktRecords{get;set;}
public LIST<LIST<Event_Attendee_Mapping__c>> an{get;set;}
public LIST<LIST<Event_Attendee_Mapping__c>> attforexport{get;set;}
public LIST<Event_Attendee_Mapping__c> query2{get;set;}
public LIST<Event_Attendee_Mapping__c> query3{get;set;}
public LIST<Event_Attendee_Mapping__c> query4{get;set;}
public LIST<Event_Attendee_Mapping__c> query5{get;set;}
public LIST<Event_Attendee_Mapping__c> bn{get;set;}
public LIST<Event_Attendee_Mapping__c> eventList{get;set;}
public string[] displayAlfabets{get;set;}
public string Workstates{get;set;}
public Event_Attendee_Mapping__c atnd {get;set;}
public boolean ShowIndustryRecords{get;set;}
public boolean renscans{get;set;}
public boolean ShowGeographyRecords{get;set;}
public boolean ShowregRecords{get;set;}
public boolean ShowrevRecords{get;set;}
public boolean ShowdivRecords{get;set;}
public boolean ShowtktRecords{get;set;}
public String ReportName{get;set;}
public String SelectedEventId {get;set;}
public boolean display{get;set;}
public boolean backren{get;set;}
public string paramname{get;set;}
public boolean expren{get;set;}
public boolean display1{get;set;}
public string ReportAssinged{get;set;}
public boolean c{get;set;}
public boolean i{get;set;}
public boolean st{get;set;}
public boolean d{get;set;}
public boolean br{get;set;}
public boolean div{get;set;}
public boolean tt{get;set;}

public boolean ShowScanReport{get;set;}

//  -------------------- Booleans for Columns -------------
public Boolean Hidestates{get;set;}
public Boolean HideRegisteredDate{get;set;}
public Boolean HideCompany{get;set;}
public Boolean HideRevenue{get;set;}
public Boolean HideDiversity{get;set;}
public Boolean HideRTickettypes{get;set;}
public Boolean HideIndustry{get;set;}



// ------------- For Pagination -----
public MAP<ID, Boolean> forPaginationIds{get; set;}
public MAP<ID, Boolean> forPaginationIdnext{get; set;}
public List<Event_Attendee_Mapping__c> ForPagination {get;set;}
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
public boolean page1{get;set;}

//------------------------------------- Variable Declarations End ----------------------------------------

//------------------------------------------ Constructor Start -------------------------------------------
public BL_EA_renderdashboardcon()
{
 URLEvent();
 getvalues();
 getevents();  
 system.debug('~~~~~~~~~~~~~~~~~~~~~~~~~~'+Eventstring);
 PageReportBool=TRUE;
 selecteventList=TRUE;
 display=true; 
 
 displayAlfabets =new string[]{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};   
 GNEMSDCCheck=false;
 if(userInfo.getUserName()=='jclarke@gnemsdc.org'){
  GNEMSDCCheck=true;
 }
// viewreportboothslist  = false;
}
//------------------------------------------- Constructor End --------------------------------------------

//------------------------------------------- Methods Start  ---------------------------------------------

//----------------------------------------- Events Fetch Start  ------------------------------------------
public void getevents() 
{ 
 // viewreportboothslist  = false;
 BackAction();
 //URLEvent();
 //getvalues() ;
 string tt = userInfo.getUserName(); 
 system.debug('0000000000000000 '+Eventstring);
 evntReports = new LIST<Reports__c>();
 system.debug( ' DDDDDDDDDDDDDDDDDDDDDDDDD '+evntReports);
 if(Eventstring!= null || Eventstring!='')
 {

 ShowIndustryRecords=false; 
       //  renscans=false;
  evntReports = [SELECT id,RE_Description__c,RE_Name__c 
                 FROM Reports__c 
                 WHERE  UPE_id__r.EV_id__c =: Eventstring
                 AND UPE_id__r.EV_id__c != null 
                 AND UPE_id__r.BoothAdmin_id__c=null
                 AND (UPE_id__r.EventAdmin_Id__c=: UserInfo.getUserId() OR UPE_id__r.User_Id__c=: UserInfo.getUserId())
                 AND UPE_id__r.user_Id__c=: UserInfo.getUserId()
                 AND RE_Name__c != 'Report By Booth Admin Scans'
                 AND RE_Name__c != 'Report By Ticket Types'
                 ];   
 } 
} 

public void getvalues() 
{

 events = new LIST<User_Profile_Event__c>();
 string ss = userInfo.getUserName();
 Items = new LIST<selectoption>();        
 events = [SELECT id,EV_id__c, EV_id__r.EV_Title__c,EV_id__r.Is_MatchMaking_Event__c FROM User_Profile_Event__c WHERE User_id__r.UserName =: ss ORDER BY CreatedDate DESC];
 MAP<id, String> eventsCheckMap = new MAP<id, String>();     
 //if(!events.isEmpty())
 //{     
  for(User_Profile_Event__c Even: events)
  {         
   if(Even.EV_id__c != null)
   {
    Items.add(new SelectOption(Even.EV_id__c, Even.EV_id__r.EV_Title__c));
    
    if(null == id || '' == id)
    
    Eventstring=Even.EV_id__c; 
     
  }
  
 }  
  getevents();
  display=true;
 
 //} 
}
//------------------------------------------ Events Fetch End  --------------------------------------------

//---------------------------------------- Choose Report Start --------------------------------------------
public integer TotalRecords{get; set;}
 public PageReference ChooseReport() 
 {

 system.debug( ' EEEEEEEEE VVVVVVVVVVV EEEEEEEEEEE NNNNNNNN TTTTTTTTTT'+Eventstring);
 try{
    IndustryRecords =  new LIST<Event_Attendee_Mapping__c>();
    GeographyRecords = new LIST<Event_Attendee_Mapping__c>();
    regRecords = new LIST<Event_Attendee_Mapping__c>();
    revRecords = new LIST<Event_Attendee_Mapping__c>();
    divRecords = new LIST<Event_Attendee_Mapping__c>();
    tktRecords = new LIST<Event_Attendee_Mapping__c>();
    an= new LIST<LIST<Event_Attendee_Mapping__c>>(); 
   display=true;
   display1=false; 
   showboothreport=false;
   system.debug( ' BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB '+ReportAssinged);
   ReportName = ReportAssinged; 
   system.debug( ' SSSSSSSSSSSSSSSSSSSSSSSS HHHHHHHHHHHHHHHHHHHH'+ReportName);
   display=true;
   PageReportBool=false;
   selecteventList=true;
   Choosedreportsbool =false;
   system.debug('hhhhhhhhhhhhhhhhhh '+ReportName);
   if(ReportName !=null && ReportName == 'Report By Industry')
  {
    c=true;
    i=true;
    st=false;
    d=false;
    br=false;
    div=false;
    tt=false;
    HideIndustry = True;
    ShowIndustryRecords=true;
    Hidestates = false;
    HideRevenue = false;
    HideRTickettypes = false;
    HideDiversity = false;
    HideRegisteredDate = false;
//    viewreportboothslist  = false;
    HideCompany=true;  
    display=false;
    display1=true;
    backren=true;
    expren=true;
  gridtitle='Report by Industry';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  IndustryRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                      AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                      Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                      FROM Event_Attendee_Mapping__c 
                      WHERE EV_id__c =: Eventstring
                      ORDER BY AS_id__r.AS_PrimaryBusinessCategory1__c DESC];
              system.debug('iiiiiiiiiiiiiiiiiiiiiiiiii '+IndustryRecords);
              
              TotalRecords=IndustryRecords.size();
              system.debug('222222rrrrrrrrrrrrrrrrrr2222222'+ TotalRecords);
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:IndustryRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
 else if(ReportName !=null && ReportName == 'Report By Geography')
 {
    c=true;
    st=true;
    i=false;  
    d=false;
    br=false;
    div=false;
    tt=false;
    HideIndustry = false;
    Hidestates = True;
    HideRevenue = false;
    HideRTickettypes = false;
    HideDiversity = false;
    HideRegisteredDate = false;
   // viewreportboothslist  = false;
    HideCompany=true;
    expren=true;
    ShowIndustryRecords=true;
    display1=true;
    display=false;
    backren=true;
  gridtitle='Report by Geography';               
  customers= new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;           
  GeographyRecords=[SELECT id,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,
                           AS_id__r.AS_CellPhone__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_PrimaryBusinessCategory1__c,
                           TicketTypes__c,DiversityType__c,Update_With_CreatedDate__c,AS_id__r.AS_BusinessRevenue__c
                           FROM Event_Attendee_Mapping__c 
                           WHERE EV_id__c=:Eventstring
                           ORDER BY AS_id__r.AS_Work_States__c DESC];
 
        TotalRecords=GeographyRecords.size();
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:GeographyRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
 
  }
  
 else if(ReportName !=null && ReportName == 'Report By Business Revenue')
  {
    c=true;
    br=true; 
    i=false;
    st=false;
    d=false; 
    div=false;
    tt=false;
    HideCompany=true;
    HideRevenue = True;
    Hidestates = false;
    HideIndustry = false;
    HideRTickettypes = false;
    HideDiversity = false;
    HideRegisteredDate = false;
   // viewreportboothslist  = false;
    display=false;
    backren=true;
    expren=true;
    display1=true;
    ShowIndustryRecords=true;
  gridtitle='Report by Business Revenue';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  revRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                       AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                       Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                       FROM Event_Attendee_Mapping__c 
                       WHERE EV_id__c =: Eventstring
                       ORDER BY AS_id__r.AS_BusinessRevenue__c DESC];
       system.debug('yyyyyyyyyyyyyyyyyy '+revRecords);
      TotalRecords=revRecords.size();
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:revRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
  
   else if(ReportName !=null && ReportName == 'Report By Ticket Types')
  {
    c=true;
    tt=true; 
    i=false;
    st=false;
    d=false;
    br=false;
    div=false;  
    HideRTickettypes = True;
    Hidestates = false;
    HideRevenue = false;
    HideCompany=true;
    HideDiversity = false;
    HideIndustry = false;
    HideRegisteredDate = false;
  //  viewreportboothslist  = false;
    display=false;
    backren=true;
    expren=true;
    display1=true;
    ShowIndustryRecords=true;
  gridtitle='Report by Ticket Types';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  tktRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                       AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                       Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                       FROM Event_Attendee_Mapping__c 
                       WHERE EV_id__c =: Eventstring
                       //ORDER BY TicketTypes__c
                        ];
                        TotalRecords=tktRecords.size();
     system.debug('zzzzzzzzzzzzzzzzzzzz'+tktRecords);
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:tktRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
  
  
  
   else if(ReportName !=null && ReportName == 'Report By Diversity Certification')
  {
    c=true;
    i=false;
    st=false;
    d=false;
    br=false; 
    tt=false; 
    div=true;
    HideDiversity = True;
    Hidestates = false;
    HideRevenue = false;
    HideRTickettypes = false;
    HideIndustry = false;
    HideRegisteredDate = false;
  //  viewreportboothslist  = false;
    HideCompany=true;
    display=false;
    backren=true;
    expren=true;
    display1=true;
    ShowIndustryRecords=true;
  gridtitle='Report by Diversity Certification';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  divRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                       AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                       Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                       FROM Event_Attendee_Mapping__c 
                       WHERE EV_id__c =: Eventstring
            //ORDER BY DiversityType__c ASC NULLS LAST
               ];
        TotalRecords=  divRecords.size();        
             system.debug('&&&&&&&&&&&&'+divRecords);
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:divRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
 

 
   else if(ReportName != null && ReportName == 'Report By Registartions by Date')
  {
    c=true;
    d=true;
    i=false;
    st=false; 
    br=false;
    div=false;
    tt=false;
    HideRegisteredDate = True;
    Hidestates = false;
    HideIndustry = false;
    HideRevenue = false;
    HideRTickettypes = false;
   // viewreportboothslist  = false;
    HideDiversity = false;
    HideCompany=true;
    display=false;
    backren=true;
    expren=true;
    display1=true; 
    ShowIndustryRecords=True;
  gridtitle='Report By Registrations by Date';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  regRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                      AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                      Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c,createddate
                      FROM Event_Attendee_Mapping__c 
                      WHERE EV_id__c =: Eventstring 
                      AND AS_id__r.AS_Email__c!=null 
                      ORDER BY createddate DESC        
              ];
              TotalRecords=  regRecords.size();      
             system.debug('uuuuuuuuuuuu222222222uuuuuuuuuuuuuuuuuu'+regRecords);
   an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:regRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
 }  

  /*if(ReportName != null && ReportName == 'Report By Booth Admin Scans')
{
system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@'+ReportName );
showboothreport=true;
 display=false;
backren=true;
    expren=true;
renscans=true;
getBoothAdminScanData();

system.debug('(((((((((((((((((((((((((((((((((((((((((((((((((((('+Scans);
}

  
 ForPagination = new List<Event_Attendee_Mapping__c>();
 system.debug( ' AAAAAAAAAAAAAAAAAAAA BBBBBBBBBBBBBBBBBB'+IndustryRecords );                
 if(an.size()>0)
        {
            conlst=true;
            
            count=an.size();
            
            pageno=1;
            page1=true;
            if(math.mod(an.size(),50)==0)
            {    
            system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
            pgno=an.size()/50;
            }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(an.size()/50) +1; 
            system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            
            for(integer i=0; i<50;i++)
            {
            system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ForPagination);
            
            ForPagination.add(an[i]);
            if(an.size() < 50){
            hasLast = false;
            hasNext=false;
            page1=true;
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
            page1=true;
       }
        
        }
        } 
        if(Scans.size()>0)
        {
        conlst=true;
        
         count=Scans.size();
       
         pageno=1;
         page1=true;
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
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ForPagination);
        
        ForScans.add(Scans[i]);
        if(Scans.size() < 50){
        hasLast = false;
        hasNext=false;
        page1=true;
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
       page1=true;
       }
        
        }
        
        }*/
       
     //   } 
     }catch(Exception e){} 
 return null;
 
 
}

//----------------------------------------- Choose Report End ---------------------------------------------

//------------------------------------ Edit and Update Report Start ---------------------------------------
public PageReference EditReport()  
{
 //try{
 EditReportBool=TRUE;
 //EditRep = new Reports__c ();
 editrep= [select id,RE_Description__c ,RE_Name__c from Reports__c where ID =:paramname];   
 //}

 //catch(exception e){}  
 return null;
}

public PageReference UpdateReport()  
{
 //try{
 editrep.RE_Description__c = editrep.RE_Description__c;
 editrep.RE_Name__c = editrep.RE_Name__c;
 update editrep;
 Pagereference pg = new Pagereference('/apex/BL_EA_Reports');
 pg.setRedirect(true);
 return pg; 
 //}
 //catch(exception e){}  
 //return null;
}
//------------------------------------- Edit and Update Report End ----------------------------------------

//------------------------------------ Back and Cancel Report Start ---------------------------------------
public void BackAction() 
{
//getEvents();
//ChooseReport();
 backren=false;
  expren=false;
 //selecteventList=true;
 display=true;
 display1=false;
showboothreport=false;
 ShowIndustryRecords=false; 
 //Hidestates = true;
 //HideRevenue = true;
 //HideRTickettypes = true;
 //HideDiversity = true;
 //HideRegisteredDate = true;
 hasFirst=false;
 Disabled_First_Icon=false;
 hasPrevious=false;
 Disabled_Previous_Icon=false;
 Disabled_Next_Icon=false;
 Disabled_Last_Icon=false;
 hasNext =false;
 hasLast=false;
 conlst=false;
 page1=false;
 
 
}

public PageReference cancel()
{ 
 EditReportBool=False;
 return null;
}
//------------------------------------- Back and Cancel Report End ----------------------------------------

//-------------------------------------------- Export Start -----------------------------------------------
public PageReference seltoexport()
{
try{
attforexport= new LIST<LIST<Event_Attendee_Mapping__c>>();
integer recCount=0;  
IndustryRecords=[SELECT id,TicketTypes__c,AS_id__r.AS_Age__c,AS_id__r.AS_BirthDate__c,AS_id__r.AS_BlogUrl__c,AS_id__r.AS_BusinessDescription__c,AS_id__r.AS_BusinessDunsNumber__c,
                 AS_id__r.AS_BusinessEstablishedDate__c,AS_id__r.AS_BusinessRevenue__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_CellPhone__c,
                 AS_id__r.AS_Company__c,DiversityType__c,AS_id__r.AS_Email__c,AS_id__r.AS_FaxNumber__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Gender__c,
                 AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_Country__c,AS_id__r.AS_HomePhone__c,
                 AS_id__r.AS_HomePoboxNo__c,AS_id__r.As_Home_State__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_LastName__c,AS_id__r.AS_NAICSCode_1__c,
                 AS_id__r.AS_NAICSCode_2__c,AS_id__r.AS_NAICSCode_3__c,AS_id__r.AS_NAICSCode_4__c,AS_id__r.AS_NAICSCode_5__c,AS_id__r.AS_NumberOfEmployees__c,AS_id__r.As_prefixNew__c,
                 AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.AS_SecondaryBusinessCategory1__c,AS_id__r.AS_ShippingAddress1__c,AS_id__r.AS_ShippingAddress2__c,
                 AS_id__r.AS_ShippingCity__c,AS_id__r.As_Shipping_Country__c,AS_id__r.AS_ShippingPhone__c,AS_id__r.AS_Shippingpoboxno__c,AS_id__r.As_Shipping_States__c,
                 AS_id__r.AS_shippingzip__c,AS_id__r.As_SuffixNew__c,AS_id__r.AS_ThroughEventBrite__c,AS_id__r.AS_Title__c,AS_id__r.AS_WebsiteUrl__c,AS_id__r.AS_WorkAddress1__c,
                 AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Workpoboxno__c,AS_id__r.AS_Work_States__c,
                 AS_id__r.AS_WorkZip__c,CreatedDate,AS_id__r.Registration_type__c
               FROM Event_Attendee_Mapping__c 
               WHERE EV_id__c=:Eventstring ];
bn=new LIST<Event_Attendee_Mapping__c>(); 
for(Event_Attendee_Mapping__c s:IndustryRecords)
{
     s.AS_id__r.AS_BlogUrl__c = escape(s.AS_id__r.AS_BlogUrl__c);
     s.AS_id__r.AS_BusinessDescription__c = escape(s.AS_id__r.AS_BusinessDescription__c);
     s.AS_id__r.AS_Company__c = escape(s.AS_id__r.AS_Company__c);
     s.AS_id__r.AS_DiversityType__c = escape(s.AS_id__r.AS_DiversityType__c);
     s.AS_id__r.AS_Email__c = escape(s.AS_id__r.AS_Email__c);
     s.AS_id__r.AS_FirstName__c = escape(s.AS_id__r.AS_FirstName__c);
     s.AS_id__r.AS_HomeAddress1__c = escape(s.AS_id__r.AS_HomeAddress1__c);
     s.AS_id__r.AS_HomeAddress2__c = escape(s.AS_id__r.AS_HomeAddress2__c);
     s.AS_id__r.AS_HomeCity__c = escape(s.AS_id__r.AS_HomeCity__c);
     s.AS_id__r.AS_HomeCountry__c = escape(s.AS_id__r.AS_HomeCountry__c);
     s.AS_id__r.AS_HomePhone__c = escape(s.AS_id__r.AS_HomePhone__c);
     s.AS_id__r.AS_LastName__c = escape(s.AS_id__r.AS_LastName__c);
     s.AS_id__r.AS_ShippingAddress1__c = escape(s.AS_id__r.AS_ShippingAddress1__c);
     s.AS_id__r.AS_ShippingAddress2__c = escape(s.AS_id__r.AS_ShippingAddress2__c);
     s.AS_id__r.AS_ShippingCity__c = escape(s.AS_id__r.AS_ShippingCity__c);
     s.AS_id__r.AS_Title__c = escape(s.AS_id__r.AS_Title__c);
     s.AS_id__r.AS_WebsiteUrl__c = escape(s.AS_id__r.AS_WebsiteUrl__c);
     s.AS_id__r.AS_WorkAddress1__c = escape(s.AS_id__r.AS_WorkAddress1__c);
     s.AS_id__r.AS_WorkAddress2__c = escape(s.AS_id__r.AS_WorkAddress2__c);
     s.AS_id__r.AS_WorkCity__c = escape(s.AS_id__r.AS_WorkCity__c);
     s.AS_id__r.AS_PrimaryBusinessCategory1__c = escape(s.AS_id__r.AS_PrimaryBusinessCategory1__c);    
     s.As_id__r.Registration_type__c = escape(s.As_id__r.Registration_type__c); 
     s.AS_id__r.AS_SecondaryBusinessCategory1__c = escape(s.AS_id__r.AS_SecondaryBusinessCategory1__c);
     s.AS_id__r.AS_NAICSCode_1__c = escape(s.AS_id__r.AS_NAICSCode_1__c);
     s.AS_id__r.AS_NAICSCode_2__c = escape(s.AS_id__r.AS_NAICSCode_2__c);
     s.AS_id__r.AS_NAICSCode_3__c = escape(s.AS_id__r.AS_NAICSCode_3__c); 
     s.AS_id__r.AS_NAICSCode_4__c = escape(s.AS_id__r.AS_NAICSCode_4__c);
     s.AS_id__r.AS_NAICSCode_5__c = escape(s.AS_id__r.AS_NAICSCode_5__c);
     recCount++;
     bn.add(s);
     if(recCount==1000)
     {
      attforexport.add(bn);
      bn = new LIST<Event_Attendee_Mapping__c>();
      recCount=0;
     }      
    }
  if(recCount !=0)
  attforexport.add(bn);       
  pagereference pg =page.BL_EA_ExportReports;
  return pg;
 }
 catch(exception e){}  
return null;
}
//-------------------------------------------- Export End -----------------------------------------------

//-------------------------------------- Alphabet Sorting Start -----------------------------------------
/**
public void valuesOfeventswithselectedvalue() {
alphasorting= new LIST<Event_Attendee_Mapping__c>();
string str=  ApexPages.currentpage().getparameters().get('t');
if(Eventstring!= null || Eventstring!= ''){ 
if(str!='All'){
alphasorting = [SELECT id,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,AS_id__r.AS_Work_States__c  
                 FROM Event_Attendee_Mapping__c 
                 WHERE EV_id__c=:Eventstring
                 AND AS_id__r.AS_PrimaryBusinessCategory1__c like: str+'%' 
                 ORDER BY AS_id__r.AS_PrimaryBusinessCategory1__c];  
}
else{
alphasorting = [SELECT id,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,AS_id__r.AS_Work_States__c  
                 FROM Event_Attendee_Mapping__c 
                 WHERE EV_id__c=:eventSelected
                 ORDER BY AS_id__r.AS_PrimaryBusinessCategory1__c]; 
}
}
}
**/
//--------------------------------------- Alphabet Sorting End ------------------------------------------
//------------------------------------------- Methods End  ----------------------------------------------

//--------------------------------------- Page Reference Start ------------------------------------------
public PageReference login() {
 if(userInfo.getUserType()=='guest'){
  Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
  pg.setredirect(true);
  return pg;  
 } 
 else{
  return null;
 }             
}
//---------------------------------------- Page Reference End -------------------------------------------

//----------------------------------- Escape Special Characters Start -----------------------------------
public String escapeSpecialCharacters(String input)
{   
 if(input!= null && input != '' && (input.contains('"')  || input.contains('<')))
 {
  if(input!= null && input != '' && (input.contains('"') ))
  {
   input = input.replace('"','\\\"');
  }
  if(input!= null && input != '' && (input.contains('<') ))
  {
   input = input.replace('<','');
  }
 }  
 return input;
}

public string escape(string s){
    if(s != null && s.contains(',')){  
    s=s.replaceAll('"','');
    s='"'+s+'"';
    } 
    return s;
    }
//----------------------------------- Pagination Methods --------------------------------------

/*Public void First()
     {   
     try{
     if(ForPagination.size()>0)
     {
         hasNext=true;
         hasFirst = false;
         hasPrevious=false;
         hasLast = True; 
         page1=true;
         Disabled_Previous_Icon = True;
         Disabled_First_Icon = True;
         Disabled_Next_Icon = False;
         Disabled_Last_Icon = False;        
         ForPagination.clear();
         //hasPrevious=false;
         pageno =1;
         for(integer i=0;i<50;i++)
          {
          ForPagination.add(an[i]);
          
         }
         if(math.mod(an.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=an.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(an.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            if(ForScans.size()>0)
     {
         hasNext=true;
         hasFirst = false;
         hasPrevious=false;
         hasLast = True; 
         page1=true;
         Disabled_Previous_Icon = True;
         Disabled_First_Icon = True;
         Disabled_Next_Icon = False;
         Disabled_Last_Icon = False;        
         ForScans.clear();
         //hasPrevious=false;
         pageno =1;
         for(integer i=0;i<50;i++)
          {
          ForScans.add(Scans[i]);
          
         }
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
            }
            }
            }catch(Exception ex){
     
     }
     }
     
         Public void Previous()
     {   
       try{ 
       if(ForPagination.size()>0)
       {
          hasLast=True;
          hasNext=true;
          page1=true;
          Disabled_Previous_Icon = False;
          Disabled_First_Icon = False;
          Disabled_Next_Icon = False;
          Disabled_Last_Icon = False;
          
         ForPagination.clear();
         if(pageno  !=1)
             {    
                  system.debug( ' PPPPPPPPPPPPPPPPPP'+Disabled_Previous_Icon);
                  system.debug( ' FFFFFFFFFFFFFFF'+Disabled_First_Icon);
                  
                  pageno  = pageno  - 1;
                  If(pageno  ==1 ){
                  hasPrevious=false;
                  hasFirst = False;
                  page1=true;
                  Disabled_Previous_Icon = True;
                  Disabled_First_Icon = True;
                  Disabled_Next_Icon = False;
                  Disabled_Last_Icon = False;
                 }  
                   for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                         ForPagination.add(an [i]); 
                           System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForPagination.size()+' RECORDS '+an [i]);
                     }
             }                           
             else
              {   
              
              system.debug( ' AAAAAA '+Disabled_Previous_Icon + ' BBBBBB'+Disabled_First_Icon);
                  hasPrevious=false;
                  hasFirst = False;
                  page1=true;
                //  Disabled_Previous_Icon = True;
                //  Disabled_First_Icon = True;
                  
                  for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                         ForPagination.add(an [i]); 
                         System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForPagination.size()+' RECORDS '+an [i]);         
                      }
              }
       }
       if(ForScans.size()>0)
       {
       hasLast=True;
          hasNext=true;
          page1=true;
          Disabled_Previous_Icon = False;
          Disabled_First_Icon = False;
          Disabled_Next_Icon = False;
          Disabled_Last_Icon = False;
          
         ForScans.clear();
         if(pageno  !=1)
             {    
                  system.debug( ' PPPPPPPPPPPPPPPPPP'+Disabled_Previous_Icon);
                  system.debug( ' FFFFFFFFFFFFFFF'+Disabled_First_Icon);
                  
                  pageno  = pageno  - 1;
                  If(pageno  ==1 ){
                  hasPrevious=false;
                  hasFirst = False;
                  page1=true;
                  Disabled_Previous_Icon = True;
                  Disabled_First_Icon = True;
                  Disabled_Next_Icon = False;
                  Disabled_Last_Icon = False;
                 }  
                   for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                         ForScans.add(Scans [i]); 
                           System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForPagination.size()+' RECORDS '+an [i]);
                     }
             }                           
             else
              {   
              
              system.debug( ' AAAAAA '+Disabled_Previous_Icon + ' BBBBBB'+Disabled_First_Icon);
                  hasPrevious=false;
                  hasFirst = False;
                  page1=true;
                //  Disabled_Previous_Icon = True;
                //  Disabled_First_Icon = True;
                  
                  for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
                     {
                         ForScans.add(Scans [i]); 
                         System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForScans.size()+' RECORDS '+Scans [i]);         
                      }
       
       
       }
       }
       }
       catch(Exception ex){
     
     }
     }
       
    Public void Next()
     {   
     try{
      if(ForPagination.size()>0)
      {
      
         pageno  = pageno +1;
        // integer pgno;
         ForPagination.clear();
         if(math.mod(an.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=an.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(an.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
            if(pageno==pgno)
             { 
                  hasNext=false;
                  hasLast = False;
                  page1=true;
                  Disabled_Next_Icon = True;
                  Disabled_Last_Icon = True;
                  for(integer i=(pageno -1)*50;i<an.size();i++ )
                    {
                     ForPagination.add(an[i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST------'+ForPagination.size()+' RECORDS '+an [i]+ ' sssssssssssswwwwwwww'+Pgno);
                    
                    }
             }
           else            
            for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
              {
                     ForPagination.add(an [i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForPagination.size()+' RECORDS '+an [i]);
             }
            hasPrevious=true;
            hasFirst = True;
            Disabled_Previous_Icon = False;
            Disabled_First_Icon = False;
            
        System.debug('---------------------------- LIST SIZE OF TEMPLIST ---------------------'+an .size());
        }
        if(ForScans.size()>0)        
       {
       
       pageno  = pageno +1;
        // integer pgno;
         ForScans.clear();
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
            if(pageno==pgno)
             { 
                  hasNext=false;
                  hasLast = False;
                  page1=true;
                  Disabled_Next_Icon = True;
                  Disabled_Last_Icon = True;
                  for(integer i=(pageno -1)*50;i<Scans.size();i++ )
                    {
                     ForScans.add(Scans[i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST------'+ForPagination.size()+' RECORDS '+an [i]+ ' sssssssssssswwwwwwww'+Pgno);
                    
                    }
             }
           else            
            for(integer i=(pageno -1)*50;i<(pageno *50);i++ )
              {
                     ForScans.add(Scans [i]); 
                     System.debug('--------------------SIZE OF PAGINATION LIST---------------------'+ForPagination.size()+' RECORDS '+an [i]);
             }
            hasPrevious=true;
            hasFirst = True;
            Disabled_Previous_Icon = False;
            Disabled_First_Icon = False;
        }
     }catch(Exception Ex){
     
     }
     
     }
     
     Public void Last()     
     {  
     
     try{
     if(ForPagination.size()>0)
     {
         hasLast = False;
         page1=true;
         Disabled_Last_Icon = True;
         System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
        hasPrevious=true;
        Disabled_Previous_Icon=False;
        hasFirst = true;
        Disabled_First_Icon=False;
        ForPagination.clear();
         hasNext=false;
          Disabled_Next_Icon=True;
        if( math.mod(an.size(),50)==0){
          System.debug('---------44444444444444444----'+pageno );
             pageno =an.size()/50;
             System.debug('-----------------pageno ----'+pageno );
           } else {
           System.debug('---------44444444444444444----'+pageno );
            pageno =(an.size()/50) +1; 
            }
         for(integer i=(pageno -1)*50;i<an .size();i++)
          {
              ForPagination.add(an [i]);  
         }
         }
         if(ForScans.size()>0)
         {
         hasLast = False;
         page1=true;
         Disabled_Last_Icon = True;
         System.debug('---------------------------------------------- LAST METHOD IS CALLING ----------------------');
        hasPrevious=true;
        Disabled_Previous_Icon=False;
        hasFirst = true;
        Disabled_First_Icon=False;
        ForScans.clear();
         hasNext=false;
          Disabled_Next_Icon=True;
        if( math.mod(Scans.size(),50)==0){
          System.debug('---------44444444444444444----'+pageno );
             pageno =Scans.size()/50;
             System.debug('-----------------pageno ----'+pageno );
           } else {
           System.debug('---------44444444444444444----'+pageno );
            pageno =(Scans.size()/50) +1; 
            }
         for(integer i=(pageno -1)*50;i<Scans.size();i++)
          {
              ForScans.add(Scans[i]);  
         }
         
         }
     }catch(Exception ex){
     }
     }
   */
public List<PieDataForScans> ForScans{get;set;}
 public void PageAction(){
 
URLEvent();
 
ReportName = Apexpages.currentPage().getParameters().get('ReportName');
 system.debug( ' AAAAAAAAAAAAAAA '+ReportName );
 
SelectedEventId =  Apexpages.currentPage().getParameters().get('eventid');
 system.debug( ' HHHHHHHHHHHHHHHHHHHH'+SelectedEventId);
 
 //if(SelectedEventId != null){
  //Eventstring =Even.EV_id__c;
 if(id == null || id == '') 
 Eventstring = SelectedEventId ;
 
  
 //display=true;
 //}
 system.debug('uuuuuuuuuuuuuuuuuuuu'+Eventstring );
 
 system.debug('uuuuDDDDDDDDDDDDDDDDDDDDuuuuu'+Eventstring );
 
  try{
    IndustryRecords =  new LIST<Event_Attendee_Mapping__c>();
    GeographyRecords = new LIST<Event_Attendee_Mapping__c>();
    regRecords = new LIST<Event_Attendee_Mapping__c>();
    revRecords = new LIST<Event_Attendee_Mapping__c>();
    divRecords = new LIST<Event_Attendee_Mapping__c>();
    tktRecords = new LIST<Event_Attendee_Mapping__c>();
     an= new LIST<LIST<Event_Attendee_Mapping__c>>();
 

  display=true;
  display1=false;
 // backren=false;
 
 // ReportName = ReportAssinged;
 
 //SelectedEventId =  Apexpages.currentPage().getParameters().get('eventid');
// eventname = Apexpages.currentPage().getParameters().get('eventid');
 //
 system.debug( ' SSSSSSSSSSSSSSSSSSSSSSSS HHHHHHHHHHHHHHHHHHHH'+ReportName);
  display=true;
  PageReportBool=false;
  selecteventList=true;
  Choosedreportsbool =false;
  system.debug('hhhhhhhhhhhhhhhhhh '+ReportName);
 if(ReportName !=null && ReportName == 'Report By Industry')
  {
    c=true;
    i=true;
    st=false;
    d=false;
    br=false;
    div=false;
    tt=false;
    HideIndustry = True;
    ShowIndustryRecords=true;
    Hidestates = false;
    HideRevenue = false;
    HideRTickettypes = false;
    HideDiversity = false;
    HideRegisteredDate = false;
//    viewreportboothslist  = false;
    HideCompany=true;  
    display=false;
    display1=true;
    backren=true;
    expren=true;
  gridtitle='Report by Industry';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  IndustryRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                      AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                      Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                      FROM Event_Attendee_Mapping__c 
                      WHERE EV_id__c =: Eventstring
                      ORDER BY AS_id__r.AS_PrimaryBusinessCategory1__c DESC];
              system.debug('iiiiiiiiiiiiiiiiiiiiiiiiii '+IndustryRecords);
              
              TotalRecords=IndustryRecords.size();
              system.debug('222222rrrrrrrrrrrrrrrrrr2222222'+ TotalRecords);
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:IndustryRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
 else if(ReportName !=null && ReportName == 'Report By Geography')
 {
    c=true;
    st=true;
    i=false;  
    d=false;
    br=false;
    div=false;
    tt=false;
    HideIndustry = false;
    Hidestates = True;
    HideRevenue = false;
    HideRTickettypes = false;
    HideDiversity = false;
    HideRegisteredDate = false;
   // viewreportboothslist  = false;
    HideCompany=true;
    expren=true;
    ShowIndustryRecords=true;
    display1=true;
    display=false;
    backren=true;
  gridtitle='Report by Geography';               
  customers= new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;           
  GeographyRecords=[SELECT id,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,
                           AS_id__r.AS_CellPhone__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_PrimaryBusinessCategory1__c,
                           TicketTypes__c,DiversityType__c,Update_With_CreatedDate__c,AS_id__r.AS_BusinessRevenue__c
                           FROM Event_Attendee_Mapping__c 
                           WHERE EV_id__c=:Eventstring
                           ORDER BY AS_id__r.AS_Work_States__c DESC];
 
        TotalRecords=GeographyRecords.size();
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:GeographyRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
 
  }
  
 else if(ReportName !=null && ReportName == 'Report By Business Revenue')
  {
    c=true;
    br=true; 
    i=false;
    st=false;
    d=false; 
    div=false;
    tt=false;
    HideCompany=true;
    HideRevenue = True;
    Hidestates = false;
    HideIndustry = false;
    HideRTickettypes = false;
    HideDiversity = false;
    HideRegisteredDate = false;
   // viewreportboothslist  = false;
    display=false;
    backren=true;
    expren=true;
    display1=true;
    ShowIndustryRecords=true;
  gridtitle='Report by Business Revenue';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  revRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                       AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                       Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                       FROM Event_Attendee_Mapping__c 
                       WHERE EV_id__c =: Eventstring
                       ORDER BY AS_id__r.AS_BusinessRevenue__c DESC];
       system.debug('yyyyyyyyyyyyyyyyyy '+revRecords);
      TotalRecords=revRecords.size();
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:revRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
  
   else if(ReportName !=null && ReportName == 'Report By Ticket Types')
  {
    c=true;
    tt=true; 
    i=false;
    st=false;
    d=false;
    br=false;
    div=false;  
    HideRTickettypes = True;
    Hidestates = false;
    HideRevenue = false;
    HideCompany=true;
    HideDiversity = false;
    HideIndustry = false;
    HideRegisteredDate = false;
  //  viewreportboothslist  = false;
    display=false;
    backren=true;
    expren=true;
    display1=true;
    ShowIndustryRecords=true;
  gridtitle='Report by Ticket Types';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  tktRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                       AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                       Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                       FROM Event_Attendee_Mapping__c 
                       WHERE EV_id__c =: Eventstring
                       //ORDER BY TicketTypes__c
                        ];
                        TotalRecords=tktRecords.size();
     system.debug('zzzzzzzzzzzzzzzzzzzz'+tktRecords);
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:tktRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
  
  
  
   else if(ReportName !=null && ReportName == 'Report By Diversity Certification')
  {
    c=true;
    i=false;
    st=false;
    d=false;
    br=false; 
    tt=false; 
    div=true;
    HideDiversity = True;
    Hidestates = false;
    HideRevenue = false;
    HideRTickettypes = false;
    HideIndustry = false;
    HideRegisteredDate = false;
  //  viewreportboothslist  = false;
    HideCompany=true;
    display=false;
    backren=true;
    expren=true;
    display1=true;
    ShowIndustryRecords=true;
  gridtitle='Report by Diversity Certification';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  divRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                       AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                       Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c
                       FROM Event_Attendee_Mapping__c 
                       WHERE EV_id__c =: Eventstring
            //ORDER BY DiversityType__c ASC NULLS LAST
               ];
        TotalRecords=  divRecords.size();        
             system.debug('&&&&&&&&&&&&'+divRecords);
  an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:divRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
  
 }  
 

 
   else if(ReportName != null && ReportName == 'Report By Registartions by Date')
  {
    c=true;
    d=true;
    i=false;
    st=false; 
    br=false;
    div=false;
    tt=false;
    HideRegisteredDate = True;
    Hidestates = false;
    HideIndustry = false;
    HideRevenue = false;
    HideRTickettypes = false;
   // viewreportboothslist  = false;
    HideDiversity = false;
    HideCompany=true;
    display=false;
    backren=true;
    expren=true;
    display1=true; 
    ShowIndustryRecords=True;
  gridtitle='Report By Registrations by Date';
  customers = new LIST<LIST<Event_Attendee_Mapping__c>> ();
  integer recCount=0;
  regRecords=  [SELECT id,AS_id__r.AS_FirstName__c ,AS_id__r.AS_LastName__c,AS_id__r.AS_PrimaryBusinessCategory1__c,
                      AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_CellPhone__c,TicketTypes__c,DiversityType__c,
                      Update_With_CreatedDate__c,AS_id__r.AS_Work_States__c ,AS_id__r.AS_BusinessRevenue__c,createddate
                      FROM Event_Attendee_Mapping__c 
                      WHERE EV_id__c =: Eventstring 
                      AND AS_id__r.AS_Email__c!=null 
                      ORDER BY createddate DESC        
              ];
              TotalRecords=  regRecords.size();      
             system.debug('uuuuuuuuuuuu222222222uuuuuuuuuuuuuuuuuu'+regRecords);
   an=new LIST<LIST<Event_Attendee_Mapping__c>>(); 
  LIST<Event_Attendee_Mapping__c> eam999= new LIST<Event_Attendee_Mapping__c>();     
  for(Event_Attendee_Mapping__c s:regRecords)     
  {
   eam999.add(s); 
   if(eam999.size() ==999){
       an.add(eam999);
       eam999= new LIST<Event_Attendee_Mapping__c>();
   }   
  }
  if(eam999.size() != 0){
      an.add(eam999);
  }
 }  

 /* if(ReportName != null && ReportName == 'Report By Booth Admin Scans')
{
getBoothAdminScanData();
showboothreport=true;
 display=false;
 backren=true;
     expren=true;
     renscans=true;

system.debug('??????????????????????????????????????????????????????????????????????????'+showboothreport);
}
 */ 
// }


/*
 ForPagination = new List<Event_Attendee_Mapping__c>();
 ForScans= new List<PieDataForScans>();
 system.debug( ' AAAAAAAAAAAAAAAAAAAA BBBBBBBBBBBBBBBBBB'+IndustryRecords ); 
                  
    if(an.size()>0)
        {
         conlst=true;
        
         count=an.size();
       
         pageno=1;
         page1=true;
          if(math.mod(an.size(),50)==0)
           {    
           system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+pgno);
                pgno=an.size()/50;
           }
            else{
            system.debug( ' -------RRRRRRRRRRRRRRRRRRRRRRRRR'+pgno);
            pgno=(an.size()/50) +1; 
             system.debug( ' -------!!!!!!!!!!!!!!!!!!!!!'+pgno);
            }
        
        for(integer i=0; i<50;i++)
        {
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ForPagination);
        
        ForPagination.add(an[i]);
        if(an.size() < 50){
        hasLast = false;
        hasNext=false;
        page1=true;
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
       page1=true;
       }
        
        }
        } 
        if(Scans.size()>0)
        {
        conlst=true;
        
         count=Scans.size();
       
         pageno=1;
         page1=true;
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
        system.debug( ' ----------- BBBBBBBBBBBBBBBBB '+ForPagination);
        
        ForScans.add(Scans[i]);
        if(Scans.size() < 50){
        hasLast = false;
        hasNext=false;
        page1=true;
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
       page1=true;
       }
        
        }
        
        }*/
        system.debug( ' -------------------- @@@@@@@@@@@@@@@@@@@@'+Scans); 
        
     //   } 
     }catch(Exception e){} 

 
 }



// ---------------------------------------------------- Booth Admins List Method Start --------------------------------------------
 /*
     public Boolean viewreportboothslist{get;set;}  
     public LIST<User_Profile_Event__c> boothslist{get;set;}
     public void boothadminslist(){
         viewreportboothslist  = true;
         boothslist = new LIST<User_Profile_Event__c>();
         boothslist = [SELECT id,Attendee_Summary__r.AS_FirstName__c,Attendee_Summary__r.AS_LastName__c,Attendee_Summary__r.AS_Email__c,Attendee_Summary__r.AS_CellPhone__c,Attendee_Summary__r.AS_Company__c,BT_id__r.MM_TableNo__c
                       FROM User_Profile_Event__c
                       WHERE Ev_id__r.id =: Eventstring 
                       AND Profile_id__r.PR_Name__c = 'BoothAdmin' 
                       AND UEP_isActive__c = true
                       AND Ev_id__c != NULL
                       AND BT_id__c != NULL 
                       AND Attendee_Summary__c != NULL
                       ORDER BY Attendee_Summary__r.AS_Company__c]; 
         system.debug('^^^^^^^ '+boothslist.size());
         for(User_Profile_Event__c booths: boothslist){
          booths.Attendee_Summary__r.AS_FirstName__c = escape(booths.Attendee_Summary__r.AS_FirstName__c);
          booths.Attendee_Summary__r.AS_LastName__c = escape(booths.Attendee_Summary__r.AS_LastName__c);
          booths.Attendee_Summary__r.AS_Company__c = escape(booths.Attendee_Summary__r.AS_Company__c);
          booths.Attendee_Summary__r.AS_Email__c = escape(booths.Attendee_Summary__r.AS_Email__c);
          booths.Attendee_Summary__r.AS_CellPhone__c = escape(booths.Attendee_Summary__r.AS_CellPhone__c);
      }
      database.update(boothslist,false);
     }
     
    public PageReference printboothslist(){
        pagereference pg=page.printcorporateslist;
         return pg;
    }

    public PageReference exportboothslist(){
        pagereference pg=page.corporateslist;
         return pg;
    }    
    
    public pagereference closereport(){
     viewreportboothslist  = false;
     pagereference pg= new pagereference('/apex/BL_EA_Reports');      
     pg.setRedirect(true);  
     return pg; 
    }
    // ----------------------------------------------------- Booth Admins List Method End ---------------------------------------------
  */
   // Added by Shruthi to populate selected Event in the before Tab on November 18th 
   
    public string id{get;set;}
    
    public void URLEvent(){  
      
    id = apexpages.currentpage().getparameters().get('id');  
        
   
    if(id != null && ( Apexpages.currentPage().getParameters().get('eventid') == null ||  Apexpages.currentPage().getParameters().get('eventid') == '')){ 
    
    eventString = id;
   } 
 }

}