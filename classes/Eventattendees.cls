public with sharing class Eventattendees{

    public void changeprofilestatus() {
    system.debug('====================================='+eventname1 );
    List<Event_Attendee_Mapping__c> changed=new List<Event_Attendee_Mapping__c>{};
    attid=new list<ID>();
    attforexport = new List<Event_Attendee_Mapping__c>(); 
    if(eventname1 != ''){
    List<string> listeventname=eventname1.split(',');
     for(string  aa: listeventname)
     {
     attid.add((id)aa);
     }
     attforexport  = [select id,EA_isBadgePrinted__c from Event_Attendee_Mapping__c where id =:attid];
    
     for(Event_Attendee_Mapping__c eam: attforexport  ){
     system.debug('::::::::::::::'+eam.EA_isBadgePrinted__c);
     if(eam.EA_isBadgePrinted__c == false){
     eam.EA_isBadgePrinted__c = True;
     system.debug('::::::::::::::'+eam.EA_isBadgePrinted__c);
     changed.add(eam);
     system.debug(':::::::11111111:::::::'+changed[0].EA_isBadgePrinted__c);
     }else
     {
     eam.EA_isBadgePrinted__c = False;
     changed.add(eam);
     }
     
     }
     update changed;
      system.debug(':::::::222222222:::::::'+changed);
     }else{
     EventReqString = 'Please select an attendee';
     EventReqStringBool = TRUE;
     
     }
     getevents();
        //return null;
    }



public boolean Successbool { get; set; }

 public PageReference movetoBoothpage() {
 pageReference pg = new pageReference('/apex/BL_eventadmin_samplebooth');
 return pg;
 }



    public PageReference converLead() {
    system.debug('8888888889999999999991111111111111 '+eventName1);
    set<string> setOfJunctions = new  set<string>();
   
    for(string sej:eventName1.split(',')){
    setOfJunctions.add(sej);
    }
    
    
    
    set<id> attsummaryListIds = new set<id>();
    for(Event_Attendee_Mapping__c EAMapping :[SELECT id,AS_id__r.id, EV_id__r.id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id IN :setOfJunctions] ){
     attsummaryListIds.add(EAMapping.AS_id__r.id);
    }
     if(setOfJunctions.size()>0){
     Successbool = true;
     }
    ConverBoothAdmin outerCls = new ConverBoothAdmin();
    outerCls.boothadminConversion(attsummaryListIds,Eventselected);
        return null;
    }


    public boolean fortwoprinters{get;set;}
    public void saveandprintforedit() {
    limitofbadges=false;
    updateattendee();
    fortwoprinters=true;   
    }
    public void printfromsaveandprint(){
     limitofbadges=false;
     fortwoprinters=false;
    pdfbool=true;
    
    }
//-----------------------------------------------------------------VARIABLE DECLARATION----------------------------------    
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
    public String NAICS1Mod{get; set;}
    public String NAICS2Mod{get; set;}
    public String NAICS3Mod{get; set;}
    public String NAICS4Mod{get; set;}
    public String NAICS5Mod{get; set;}
    public string  serarchstringvalue{get;set;}
    public string EventReqString1{get;set;}
    public String selectedvalues{get; set;}
    public Boolean EventReqStringbool{get; set;}
    public String EventReqString{get; set;}
    public Boolean foundHistoryBool{get; set;}
    public List<Event_Attendee_Mapping__c> cus12 {get;set;}
    public list<list<EventWrapper>> TotalAttendees { get; set; }
    public list<InnerForBadge> newstr{get;set;}
    public list<Event_Attendee_Mapping__c> attendees1234{get;set;}
    public list<AttendeeSummary__c> event1234{get;set;}
    public AttendeeSummary__c Event{get;set;}
    public list<eventwrapper> ew {get;set;}
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
    public list<Event_Attendee_Mapping__c> eventlist{get;set;}
    public list<Event_Attendee_Mapping__c> attendeeslist{get;set;}
    public LIST<LIST<InnerForBadge>> LeftValues{get; set;}
    public LIST<LIST<InnerForBadge>> RightValues{get; set;} 
    public LIST<LIST<InnerForBadge>> MiddleValues{get; set;}
    public List<Event_Attendee_Mapping__c> str{get;set;}
    public List<InnerForBadge> newstr1{get;set;}
    public List<InnerForBadge> newstr2{get;set;}
    public list<inneremail> ss {get;set;}
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
    public Event_Attendee_Mapping__c deleterec{get;set;}
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
     public list<TicketTypes__c> tickets{get;set;}
     Public String ShowError{get;set;}
     Public Boolean DisplayError{get;set;}
     Public  Boolean showEmail{get;set;}
     Public  Boolean HideEmail{get;set;}
     Public  Boolean showFirstName{get;set;}
     Public  Boolean HideFirstName{get;set;}
     Public  Boolean HideLastName{get;set;}
     Public  Boolean ShowLastName{get;set;}
    
//--------------------------------------------------------VARIABLE DECLARATION------------------------------------
public PageReference checkUserId() {
       
       if(userInfo.getUserType()=='guest'){
            Pagereference pg = new pagereference('/apex/BL_Eventadmin_signup');
            pg.setredirect(true);
            return pg;
       } else{
            return null;
       }     
  }
//-------------------------------------------------------CONSTRUCTOR---------------------------------
   
   public pagereference PrintBadge1(){
   
   return null;
   }
   
   public String[] selectedTicTypes{get;set;}
   public String[] DiversityTypes{get;set;}
   public String[] DiversityTypesforfirstLine{get;set;}
   public String[] DiversityTypesforsecondLine{get;set;}
   public List<Selectoption> Divoptions {get;set;}
   public List<Selectoption> Divoptionsforsecondline {get;set;}
   public Event__c eventDIVS{get;set;}
   public LIST<selectoption> SelectedValuesfortwoprinters{get;set;}
    public Eventattendees()
    {   
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
    SelectedValuesfortwoprinters=new LIST<selectoption>();
    SelectedValuesfortwoprinters.add(new selectoption('Zebra Label','Zebra Label'));
    SelectedValuesfortwoprinters.add(new selectoption('Dymo Label(30856,Single Label)','Dymo Label(30856,Single Label)'));
     

        alphabet=new string[]{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
        emailalert=false;
        limitofbadges=false;
        fieldnames=new LIST<selectoption>();
        fieldnames.add(new selectoption('None','None'));
        fieldnames.add(new selectoption('AS_LastName__c','LastName'));
        fieldnames.add(new selectoption('AS_FirstName__c','FirstName'));
        fieldnames.add(new selectoption('AS_Title__c','Designation'));
        fieldnames.add(new selectoption('AS_Company__c','Company'));
        ReqFields=true;
        
        getvalues();
        getevents();
  //----------------- Getting Ticket Types Of an Event----------------
       selectedTicTypes=new String[]{};
       options = new List<SelectOption>();
       tickets=new list<TicketTypes__c>();
        tickets=[select TT_Name__c from TicketTypes__c where   EV_id__r.id =: eventSelected];
        for(TicketTypes__c Tic:tickets){
        options.add(new SelectOption((String)Tic.TT_Name__c, Tic.TT_Name__c));
        }
    //---------------Diversity Types----------------------------------------------------------
        DiversityTypes=new String[]{};
        Divoptions = new List<Selectoption>();
        Divoptionsforsecondline=new List<Selectoption>();
        eventattendeelist=new List<Event__c>();
      try{
         eventDIVS=[select EventDiversityValues__c from Event__c where id=:eventSelected];
        String Div=eventDIVS.EventDiversityValues__c;
       
       string[] DiversityTypes1=Div.split(';');
       integer i=0;
         for(String Diversty : DiversityTypes1 ){
         if(math.MOD(i,2)==0){
        Divoptions.add(new SelectOption(Diversty ,Diversty ));
        }else{
         Divoptionsforsecondline.add(new SelectOption(Diversty ,Diversty ));
        }      
    i++;
    }}
    catch(exception e){}
    // By Mallik For Data Import History Display 
       Integer countOfImport = [SELECT count() FROM DataImport_SavePoint__c WHERE User_id__c =: UserInfo.getUserId()]; 
       if(countOfImport > 0)
       foundHistoryBool = TRUE;
       try
    {
     attach=[select EV_EventLogo__c from Event__c where id =:eventSelected];
     if(attach.EV_EventLogo__c != null){
     logo=true;
    }else
    {
    logo=false;
    } 
    }catch(exception e){} 
    }
    //---------------------------------------------------------Getting events into picklist-----------------
    public void getvalues()
    {
     emailalert=false;
     limitofbadges=false;
       LIST<User_Profile_Event__c> events = new LIST<User_Profile_Event__c>();
       string ss = userInfo.getUserName();
       Items = new LIST<selectoption>();
       events = [SELECT id,EV_id__c, EV_id__r.EV_Title__c  FROM  User_Profile_Event__c 
                                                           WHERE  EventAdmin_Id__c != '' And
                                                           User_id__r.UserName =: ss And
                                                           EventAdmin_Id__r.UserName =: ss ORDER BY CreatedDate ASC];
         system.debug('++++++++++++++++'+events );
       if(!events.isEmpty())
       {
           
           for(User_Profile_Event__c Even: events)
           {
            system.debug('+++++++Events+++++++++'+even );
               if(Even.EV_id__c != null){
               Items.add(new SelectOption(Even.EV_id__c, Even.EV_id__r.EV_Title__c));
               eventSelected =Even.EV_id__c;
               system.debug('++++++++++++++++'+Items);
               }
           }
       }            
   }
    
    //-------------------------------------------------------------------------Escap method for specialcharecters---------
   
   
    public static Datetime getLocalDateTime(Datetime z)
    {    
        Datetime l = z.Date();
      
        return l;
    }
   
   
    public String escapeSpecialCharacters(String input)
    {
      
       if(input!= null && input != '' && (input.contains('"')  || input.contains('<')))
       {
        if(input!= null && input != '' && (input.contains('"') ))
        {
         input = input.replace('"','\\\"');
       
        }if(input!= null && input != '' && (input.contains('<') ))
        {
         input = input.replace('<','');
         
        }
        if(input!= null && input != '' && (input.contains(',') ))
        {
         input = input.replace(',','');
         
        }
        if(input!= null && input != '' && (input.contains('.') ))
        {
         input = input.replace('.','');
         
        }
      }  
    return input;
    
    }
    //-------------------------------------------------------------------------Escap method for specialcharecters---------
    public PageReference selectedprint() 
   {
   limitofbadges=false;
    Event__c EVprinter=[select Event_Printer__c, Lable_First_Line__c,Lable_First_Line_Color__c,Lable_First_Line_Font__c,
                                   Lable_First_Line_Size__c,Lable_Secoend_Line__c,Lable_Secoend_Line_Color__c,
                                   Lable_Secoend_Line_Font__c,Lable_Secoend_Line_Size__c,Lable_Third_Line__c,
                                   Lable_Third_Line_Color__c,Lable_Third_Line_Font__c, Lable_Third_Line_Size__c
                                   from Event__c where id =:eventselected];
          string label=EVprinter.Event_Printer__c;
          system.debug('+++++++++++++++++++++++++++++++++++++++'+label);
          system.debug('+++++++++++++++++++++++++++++++++++++++'+selectedvalues);
  if(label == 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges')
   {
        selfieldvalue=EVprinter.Lable_First_Line__c;
        selectedcolor=EVprinter.Lable_First_Line_Color__c;
        selectedsize=EVprinter.Lable_First_Line_Size__c;
        selectedfaceFir=EVprinter.Lable_First_Line_Font__c;
        selLvalue=EVprinter.Lable_Secoend_Line__c;
        selectedcolorS=EVprinter.Lable_Secoend_Line_Color__c;
        selectedsizeS=EVprinter.Lable_Secoend_Line_Size__c;
        selectedfaceSec=EVprinter.Lable_Secoend_Line_Font__c;
        selTvalue=EVprinter.Lable_Third_Line__c;
        selectedcolorT=EVprinter.Lable_Third_Line_Color__c;
        selectedsizeT=EVprinter.Lable_Third_Line_Size__c;
        selectedfaceThr=EVprinter.Lable_Third_Line_Font__c;
         fbool=false;
        printbadge();
        //addattendee1=true;
      }else if(label != 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges'){
      selfieldvalue='AS_FirstName__c';
        selectedcolor='Black';
        selectedsize='32pt';
        selectedfaceFir='Times New Roman';
        selLvalue='AS_LastName__c';
        selectedcolorS='Black';
        selectedsizeS='24pt';
        selectedfaceSec='Times New Roman';
        selTvalue='AS_Company__c';
        selectedcolorT='Black';
        selectedsizeT='18pt';
        selectedfaceThr='Times New Roman';
         fbool=false;
        printbadge();
        //addattendee1=true;
      }
  else if(label == 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges')
       {
        selfieldvalue=EVprinter.Lable_First_Line__c;
        selectedcolor=EVprinter.Lable_First_Line_Color__c;
        selectedsize=EVprinter.Lable_First_Line_Size__c;
        selectedfaceFir=EVprinter.Lable_First_Line_Font__c;
        selLvalue=EVprinter.Lable_Secoend_Line__c;
        selectedcolorS=EVprinter.Lable_Secoend_Line_Color__c;
        selectedsizeS=EVprinter.Lable_Secoend_Line_Size__c;
        selectedfaceSec=EVprinter.Lable_Secoend_Line_Font__c;
   fbool=false;
   PrintBadgeforthree();
   //addattendee1=true;
   }else if(label != 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges'){
        selfieldvalue='AS_FirstName__c,AS_LastName__c';
        selectedcolor='Black';
        selectedsize='20pt';
        selectedfaceFir='Times New Roman';
        selLvalue='AS_Company__c';
        selectedcolorS='Black';
        selectedsizeS='15pt';
        selectedfaceSec='Times New Roman';
        fbool=false;
        PrintBadgeforthree();
        //addattendee1=true;
        }
   else if(selectedvalues == 'Dymo Label(30856,Single Label)')
   {
   fbool=false;
   printbadge();
  // dymo=true;
   }
   else if(selectedvalues == 'Zebra Label')
   {
   fbool=false;
   printbadge();
   //dymo=true;
   }
   else
   {
   fbool=TRUE;
   EventReqString1 = 'Please Select a Template';
              EventReqStringBool = TRUE;
            
   }
        return null;
    }
    //------------------------------------------SELECT  TYPE OF BADGE-----------------------------------------------------
    public List<selectoption> getfields()
      { 
          fbool=true;
          limitofbadges=false;
          List<selectoption> Option = new List<selectoption>();
          Option.add(new selectoption('Select','Select'));
          Option.add(new selectoption('Zebra Label','Zebra Label'));
          Option.add(new selectoption('Dymo Label(30856,Single Label)','Dymo Label(30856,Single Label)'));
          Option.add(new selectoption('Avery 5392 Name badges','Avery 5392 Name badges'));
        
          Option.add(new selectoption('Avery 22806 easy peal square Badges','Avery 22806 easy peal square Badges'));
          return option;
       } 
    //------------------------------------------------------GRID VALUES-------------------------------------------  
   public Datetime crd{get;set;}
    public List<Event_Attendee_Mapping__c> getevents()
    {
    emailalert=false;
    limitofbadges=false;
    system.debug('==================='+eventSelected);
     EventReqStringBool=false;
     TotalAttendees=new list<list<eventwrapper>>();
     eventlist=new list<Event_Attendee_Mapping__c>();
     if(eventSelected != null || eventSelected != '')
     {
     integer recCount=0;
     eventlist=[select CreatedDate,AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_ImageUrl__c,
                      AS_id__r.AS_Company__c,EA_AttendeeBarcode__c,AS_id__r.AS_CellPhone__c,
                      EA_isBadgePrinted__c,AS_id__r.AS_Email__c,AS_id__r.Registration_type__c,IsPrifileUpdate__c
                      ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where EV_id__r.id =: eventSelected  ORDER BY AS_id__r.AS_Company__c Limit 2300];
        system.debug('==================='+eventlist);                 
     ew=new List<eventwrapper>();
     for(Event_Attendee_Mapping__c s:eventlist)
     {      
     system.debug('==================='+s.id);  
         crd=s.CreatedDate;
         
         crd = getLocalDateTime(crd);
         s.AS_id__r.AS_FirstName__c = escapeSpecialCharacters(s.AS_id__r.AS_FirstName__c);
         s.AS_id__r.AS_LastName__c = escapeSpecialCharacters(s.AS_id__r.AS_LastName__c);
         s.AS_id__r.AS_CellPhone__c = escapeSpecialCharacters(s.AS_id__r.AS_CellPhone__c);
         s.AS_id__r.AS_Email__c = escapeSpecialCharacters(s.AS_id__r.AS_Email__c);
         s.AS_id__r.AS_Company__c = escapeSpecialCharacters(s.AS_id__r.AS_Company__c);
         s.AS_id__r.Registration_type__c=escapeSpecialCharacters(s.AS_id__r.Registration_type__c);
         
         recCount++;
         ew.add(new eventwrapper(s));
         if(recCount==1000)
         {
         TotalAttendees.add(ew);
         ew = new LIST<EventWrapper>();
         recCount=0;
          }
      
       }
       if(recCount !=0)
       TotalAttendees.add(ew);                          
                              
    }
        DiversityTypes=new String[]{};
        Divoptions = new List<Selectoption>();
        Divoptionsforsecondline=new List<Selectoption>();
        eventattendeelist=new List<Event__c>();
      
    return null;
    }      
   //----------------------------------------------------------------------------------------------------
   public void Alphasorting() {
   String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
   limitofbadges=false;
    system.debug('----------------------------------------------------------sort---');
    string alphas=ApexPages.currentPage().getParameters().get('alphabit');
   system.debug('---------'+alphas);
   
    TotalAttendees=new list<list<eventwrapper>>();
     eventlist=new list<Event_Attendee_Mapping__c>();
     if(eventSelected != null || eventSelected != '')
     {
     if(alphas != 'All'){
     integer recCount=0;
     eventlist=[select AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_ImageUrl__c,
                      AS_id__r.AS_Company__c,EA_AttendeeBarcode__c,AS_id__r.AS_CellPhone__c,CreatedDate,
                      EA_isBadgePrinted__c,AS_id__r.AS_Email__c,AS_id__r.Registration_type__c,IsPrifileUpdate__c
                      ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where AS_id__r.AS_LastName__c like: alphas+'%'
                        AND EV_id__r.id =: eventSelected ORDER BY AS_id__r.AS_Company__c];      
    system.debug('---------'+eventlist);
     ew=new List<eventwrapper>();
     for(Event_Attendee_Mapping__c s:eventlist)
     {      
     crd=s.CreatedDate;
         
         crd = getLocalDateTime(crd);
         s.AS_id__r.AS_FirstName__c = escapeSpecialCharacters(s.AS_id__r.AS_FirstName__c);
         s.AS_id__r.AS_LastName__c = escapeSpecialCharacters(s.AS_id__r.AS_LastName__c);
         s.AS_id__r.AS_CellPhone__c = escapeSpecialCharacters(s.AS_id__r.AS_CellPhone__c);
         s.AS_id__r.AS_Email__c = escapeSpecialCharacters(s.AS_id__r.AS_Email__c);
         s.AS_id__r.AS_Company__c = escapeSpecialCharacters(s.AS_id__r.AS_Company__c);
         s.AS_id__r.Registration_type__c=escapeSpecialCharacters(s.AS_id__r.Registration_type__c);
         
         recCount++;
         ew.add(new eventwrapper(s));
         if(recCount==1000)
         {
         TotalAttendees.add(ew);
         ew = new LIST<EventWrapper>();
         recCount=0;
          }
      
       }
       if(recCount !=0)
       TotalAttendees.add(ew);                          
      }
      else
      {
      getevents();
      }                        
    }
       
    }    
    //-------------------------------------------------------------------------------------------ADD ATTENDEE METHOD---------       
         
    public  List<SelectOption> options{get;set;}
    
    public void CreateAttendee() {
    limitofbadges=false;
    emailalert=false;
    showEmail  =True;
    showFirstName  = True;
    showLastName  = True;
    DisplayError=false;
    newAttendee = new AttendeeSummary__c();
      Divoptions = new List<Selectoption>();
        Divoptionsforsecondline=new List<Selectoption>();
        eventattendeelist=new List<Event__c>();
         DiversityTypesforfirstline=new string[]{};
     DiversityTypesforsecondline=new string[]{};
      
   EventReqStringBool=false;
   if(eventSelected == 'select' || eventSelected==null)
   {
    EventReqStringBool = TRUE;
    EventReqString = 'Please Select an Event';
   }
   else
   {
   attendeesetting = new BL_SecuritySettingsCon(eventSelected); 
   EventReqString='Add Attendee'; 
   addattendee = TRUE;
   foraddatt=true;
   foreditatt=false;
               
   }
   try{
         system.debug('==============================='+eventSelected);
         eventDIVS=[select EventDiversityValues__c from Event__c where id=:eventSelected];
        String Div=eventDIVS.EventDiversityValues__c;
       
       string[] DiversityTypes1=Div.split(';');
       integer i=0;
         for(String Diversty : DiversityTypes1 ){
         if(math.MOD(i,2)==0){
        Divoptions.add(new SelectOption(Diversty ,Diversty ));
        }else{
         Divoptionsforsecondline.add(new SelectOption(Diversty ,Diversty ));
        }      
    i++;
    }
     selectedTicTypes=new String[]{};
       options = new List<SelectOption>();
       tickets=new list<TicketTypes__c>();
        tickets=[select TT_Name__c from TicketTypes__c where   EV_id__r.id =: eventSelected];
        for(TicketTypes__c Tic:tickets){
        options.add(new SelectOption((String)Tic.TT_Name__c, Tic.TT_Name__c));
        }}catch(exception e){}
   }
//-------------------------------------SAVING NEW ATTENDEE METHOD----------------------------------------------
   public void SaveAttendee() 
   {
   String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
   if(browserType != null && browserType.contains('MSIE')){
    Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
   } 
   limitofbadges=false;
    try
        {
        newattendee.AS_NAICSCode1__c =Integer.valueOf(NAICS1Mod);
        } catch(Exception e){}
        try{   
        newattendee.AS_NAICSCode2__c =Integer.valueOf(NAICS2Mod);
         }catch(Exception e){}
        try{
        newattendee.AS_NAICSCode3__c =Integer.valueOf(NAICS3Mod);
        } catch(Exception e){}
         try{
        newattendee.AS_NAICSCode4__c =Integer.valueOf(NAICS4Mod);
        }catch(Exception e){}
         try{
        newattendee.AS_NAICSCode5__c =Integer.valueOf(NAICS5Mod);
        }catch(Exception e){}
   
 
   
   //newAttendee.AS_uniqueField__c = (newAttendee.AS_FirstName__c + newAttendee.AS_LastName__c + newAttendee.AS_Email__c ).toLowercase();
   EventReqStringBool2=false;
   Savepoint sp = Database.setSavepoint();  
   if(attendeeImage != NULL && ( myimageName != '' || myimageName != NULL )){
   
   if(attendeeImage.size() != null)
   {
     if(attendeeImage.size() <= 10240000){
      mydoc =new document();
      mydoc.body = attendeeImage;
      mydoc.folderid = UserInfo.getUserId();
      mydoc.ispublic=true;
      mydoc.Name = myimageName;
      insert mydoc; 
      newattendee.AS_ImageUrl__c= mydoc.id;
     }else{
    imageerror=true;
    imageerrormsg='Image size should be less than 1MB';   
    }
    }
    }
     AttendeeSummary__c myatt = new AttendeeSummary__c();
     myatt = newAttendee.clone(true);
     Database.UpsertResult myAttendeeSaveResult = Database.upsert(myatt,AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);
     system.debug('-------------------------new attendee------------------'+myatt);
     if(myAttendeeSaveResult.isSuccess() )
     {
     if(myAttendeeSaveResult.iscreated())
     {
     
      attmap = new Event_Attendee_Mapping__c();
      attmap.AS_id__c = myAttendeeSaveResult.getId(); 
      attmap.Ev_id__c = eventSelected;
       
     if(selectedTicTypes.size()>0)
     {
      attmap.TicketTypes__c='';
      for(string str:selectedTicTypes){
      attmap.TicketTypes__c+=str+',';
      }
    
     }
       if(DiversityTypesforfirstLine.size() != 0)
     {
    
     for(string str:DiversityTypesforfirstLine){
     attmap.DiversityType__c+=str+';';
     }
     }
     if(DiversityTypesforsecondLine.size()!= 0){
     for(string str1:DiversityTypesforsecondLine){
     attmap.DiversityType__c+=str1+';';
     
     }

     }
     
      Database.SaveResult myAttendeeJunction = Database.Insert(attmap ,false);
      
      attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ eventSelected;
      attmap.EA_AttendeeBarcode__c = myAttendeeJunction .getId()+'-'+eventSelected;
    
      
      update attmap;
      
      addattendee=false;
      attendeeevent=myAttendeeJunction.id;
      eventatt=[select id,As_id__r.AS_FirstName__c,As_id__r.AS_LastName__c,As_id__r.AS_Company__c,EV_ID__C,
                        TicketTypes__c,EV_id__r.EV_Title__c,AS_id__r.AS_Title__c,EA_AttendeeBarcode__c 
                       ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:attendeeevent]; 
     eventselected=eventselected;
     getevents();
     
      }else{
      system.debug('============================');
      integer ev_att_Jun=[select count() from  Event_Attendee_Mapping__c 
                                             where  AS_id__r.id =: myAttendeeSaveResult.getId() and
                                             Ev_id__c   =: eventSelected];
     system.debug('============================'+ev_att_Jun);
    if(ev_att_Jun > 0)
    {
      showerror = 'Attendee Already Exists!'; 
          DisplayError = True;
     Database.rollback(sp);
    }else{
      attmap = new Event_Attendee_Mapping__c();
      attmap.AS_id__c = myAttendeeSaveResult.getId(); 
      attmap.Ev_id__c = eventSelected;
      attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ eventSelected;
     
     if(selectedTicTypes.size()>0)
     {
      attmap.TicketTypes__c='';
      for(string str:selectedTicTypes){
      attmap.TicketTypes__c+=str+',';
      }
    
     }
     if(DiversityTypes.size()>0)
     {
     attmap.DiversityType__c='';
     for(string str:DiversityTypesforfirstLine){
     attmap.DiversityType__c+=str+';';
     }
     for(string str1:DiversityTypesforsecondLine){
     attmap.DiversityType__c+=str1+';';
     
     }
     
     system.debug('------------------------------------------------------------------REGTYPES::::::::::-----'+attmap.DiversityType__c.removeEnd(';'));   
     }
      Database.SaveResult myAttendeeJunction = Database.Insert(attmap ,false);
      
      attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId()+ eventSelected;
      attmap.EA_AttendeeBarcode__c = myAttendeeJunction .getId()+'-'+eventSelected;
      update attmap;
      attendeeevent=myAttendeeJunction.id;
      addattendee=false;
      eventatt=[select id,As_id__r.AS_FirstName__c,As_id__r.AS_LastName__c,As_id__r.AS_Company__c,EV_ID__C,
                        TicketTypes__c,EV_id__r.EV_Title__c,AS_id__r.AS_Title__c,
                       EA_AttendeeBarcode__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:attendeeevent];
     
     eventselected=eventselected;
     getevents();
     }  
                
     }
     }
      
    }
//-------------------------------For Save And Print-----------------------
    public void saveandprint()
    {
    limitofbadges=false;
    SaveAttendee();
    fortwoprinters=true;
    }   
//------------------------------------------------------------------------------
    public void changestatus()
    {
    limitofbadges=false;
    statuschange=true;
    system.debug('----------------------'+statuschange);
    }
    public List<selectoption> getprintingstatus()
    {
    limitofbadges=false;
    List<selectoption> Options = new List<selectoption>(); 
    Event_Attendee_Mapping__c attmap=[select EA_isBadgePrinted__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=:eventname1];
    if(attmap.EA_isBadgePrinted__c == true)
    {               
     statusvalue='Printed';
     Options.add(new selectoption('Printed','Printed'));
     Options.add(new selectoption('NOt printed','Not printed'));
    }
    else
    {
    statusvalue='Not Printed';               
    Options.add(new selectoption('NOt printed','Not printed'));
    Options.add(new selectoption('Printed','Printed'));
    }       
    return Options;
    }
    public Event_Attendee_Mapping__c changingprintstatus()
    {
    Event_Attendee_Mapping__c attmap=[select EA_isBadgePrinted__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=:eventname1];
    if(statusvalue == 'Printed')
    {
    attmap.EA_isBadgePrinted__c=true;
    
    }
    else
    {
    attmap.EA_isBadgePrinted__c=false;
    }
    update attmap;
    statuschange=false;
    getevents();
    return null;
    }         
    public void changeemailstatus()
    {
    emailstatuschange=true;    
    }
    public List<selectoption> getemailstatus()
    {
    limitofbadges=false;
     List<selectoption> Options = new List<selectoption>(); 
     Event_Attendee_Mapping__c attmap=[select IsPrifileUpdate__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=:eventname1];
     if(attmap.IsPrifileUpdate__c == true)
     {               
     statusvalue='sent';
     Options.add(new selectoption('sent','sent'));
     Options.add(new selectoption('Not Sent','Not Sent'));
      }
      else
     {
     statusvalue='Not Sent';  
     Options.add(new selectoption('Not Sent','Not Sent'));             
     Options.add(new selectoption('sent','sent'));
     }
     return Options;
     }
    public Event_Attendee_Mapping__c changingemailstatus()
    {
    limitofbadges=false;
    Event_Attendee_Mapping__c attmap=[select IsPrifileUpdate__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=:eventname1];
    if(statusvalue == 'Sent')
    {
    attmap.IsPrifileUpdate__c=true;
    
    }
    else
    {
    attmap.IsPrifileUpdate__c=false;
    }
    update attmap;
    
    system.debug('--------------------------------'+attmap.EA_isBadgePrinted__c);
    emailstatuschange=false;
    getevents();
    return null;
    }      
//---------------------------------------------------------------------END OF SAVE ATTENDEE-----------------------------       
 
    //-----------------------------------------EDIT ATTENDEES---------------------
   public Event_Attendee_Mapping__c TicTypesforedit{get;set;}
   public Event_Attendee_Mapping__c DivTypesforedit{get;set;}
    public void editAttendee() 
    {
    limitofbadges=false;
    DisplayError = False;
    imageerror=False;
    EventReqString='';       
    DivTypesforedit=new Event_Attendee_Mapping__c();
    TicTypesforedit=new Event_Attendee_Mapping__c();
     eventatt=new Event_Attendee_Mapping__c();
    string TTT='';
    List<string> totaltypes=new list<string>();
    emailalert=false;
    attendeesetting=new BL_SecuritySettingsCon(eventSelected);
    //-------------------------------------------------------------FOR REG TYPE EDIT--------------------
    for(TicketTypes__c tt:tickets){
    totaltypes.add(tt.TT_Name__c);
    }
   try{
   selectedTicTypes=new String[]{};
       options = new List<SelectOption>();
       tickets=new list<TicketTypes__c>();
        tickets=[select TT_Name__c from TicketTypes__c where   EV_id__r.id =: eventSelected];
        for(TicketTypes__c Tic:tickets){
        options.add(new SelectOption((String)Tic.TT_Name__c, Tic.TT_Name__c));
        }
    TicTypesforedit=[select TicketTypes__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=:eventName1];
    
    TTT=TicTypesforedit.TicketTypes__c;
    list<string> regticket=TTT.split(',');
    selectedTicTypes=new String[]{};
    for(string reg:regticket){
    selectedTicTypes.add(reg);
    }
    }catch(exception e){}
    //----------------------------------------------------------------FOR DIVERSITY TYPE EDIT-------------------------------------------
      try{
         system.debug('==============================='+eventSelected);
         eventDIVS=[select EventDiversityValues__c from Event__c where id=:eventSelected];
        String Div=eventDIVS.EventDiversityValues__c;
       
       string[] DiversityTypes1=Div.split(';');
       integer i=0;
         for(String Diversty : DiversityTypes1 ){
         if(math.MOD(i,2)==0){
        Divoptions.add(new SelectOption(Diversty ,Diversty ));
        }else{
         Divoptionsforsecondline.add(new SelectOption(Diversty ,Diversty ));
        }      
    i++;
    }
    DivTypesforedit=[select DiversityType__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=:eventName1];
    system.debug('::::::::::::::::::::::'+DivTypesforedit.DiversityType__c);
     DiversityTypesforfirstline=new string[]{};
     DiversityTypesforsecondline=new string[]{};
     if(DivTypesforedit.DiversityType__c != null){
    string diversity=DivTypesforedit.DiversityType__c;
    list<string> seldivs=diversity.split(';');
  
    for(string dd:seldivs){
    
    DiversityTypesforfirstline.add(dd);
    DiversityTypesforsecondline.add(dd);
    }
    }
  
   }catch(exception e){}
    
    
    
    Event_Attendee_Mapping__c attendeeid = [select AS_id__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=:eventName1];
    newattendee = new AttendeeSummary__c ();
    event1234=new list<AttendeeSummary__c>();
    event1234= [select id,name,AS_Age__c,isUpdated__c,AS_BirthDate__c,AS_BlogUrl__c,AS_BusinessDescription__c,AS_BusinessDunsNumber__c,
                                 AS_BusinessEstablishedDate__c,AS_BusinessRevenue__c,AS_BusinessTaxId__c,AS_CellPhone__c,
                                 AS_Company__c,AS_DiversityType__c,Registration_type__c,AS_Email__c,AS_FaxNumber__c,AS_FirstName__c,AS_Gender__c,
                                 AS_HomeAddress1__c,AS_HomeAddress2__c,AS_HomeCity__c,AS_HomeCountry__c,AS_HomePhone__c,
                                 AS_HomePoBox__c,AS_HomeZip__c,AS_ImageUrl__c,AS_LastName__c,AS_NAICSCode1__c,
                                 AS_NAICSCode2__c,AS_NAICSCode3__c,AS_NAICSCode4__c,AS_NAICSCode5__c,AS_NumberOfEmployees__c,AS_PrefixNew__c,
                                 AS_PrimaryBusinessCategory1__c,AS_SecondaryBusinessCategory1__c,AS_ShippingAddress1__c,AS_ShippingAddress2__c,
                                 AS_ShippingCity__c,AS_ShippingCountry__c,AS_ShippingPhone__c,AS_shippingzip__c,AS_ShippingState__c,
                                 AS_ShippingZipcode__c,AS_SuffixNew__c,AS_ThroughEventBrite__c,AS_Title__c,AS_WebsiteUrl__c,AS_WorkAddress1__c,
                                 AS_WorkAddress2__c,AS_WorkCity__c,AS_WorkCountry__c,AS_WorkPhone__c,AS_WorkPoBox__c,AS_Work_Country__c,AS_WorkZip__c,
                                 AS_Work_States__c,As_Home_Country__c,As_Home_State__c,As_Shipping_Country__c,As_Shipping_States__c                                 
                                 FROM AttendeeSummary__c WHERE id=:attendeeid.AS_id__c];     
                                                          
        for(AttendeeSummary__c emEvent1 :event1234)
        {
            if(eventName1!= null && eventName1 !='')
            {
                EventReqStringBool=false;
                EventReqString='Edit Attendee';
                addattendee= TRUE;
                foreditatt=true;
                foraddatt=false;
                newattendee= emEvent1;
                break;   
            } 
        }
        system.debug('========================================'+newattendee);
        if(newattendee.As_ImageUrl__c != null)
        {
        eventIdVar=newattendee.As_ImageUrl__c;
        }
         if(newattendee.AS_Gender__c =='Male')
        {
            Selected= 'TRUE';
        }ELSE
        {
            selected = 'FALSE';
        }
       ageMod = String.valueOf(newattendee.AS_age__c);
        if(newattendee.AS_age__c != null)
        {
            if(ageMod != '0.0')
            {
                if(ageMod.contains('.0'))
                {
                ageMod.replaceAll('.0', '');
                }
            }else
            {
                ageMod = '';
            }
        }
       if(newattendee.AS_NAICSCode1__c > 10)
        {
            NAICS1Mod = String.valueOf(newattendee.AS_NAICSCode1__c);
            if(NAICS1Mod.contains('\''))
            {
                NAICS1MOd=NAICS1Mod.replaceAll('\'','');                    
            }
        }
        
        if(newattendee.As_NAICSCode2__c > 10)
        {
            NAICS2Mod = String.valueOf(newattendee.AS_NAICSCode2__c);
            if(NAICS2Mod.contains('\''))
            {
                NAICS2MOd=NAICS2Mod.replaceAll('\'','');                    
            }
        }
        if(newattendee.AS_NAICSCode3__c > 10)
        {
            NAICS3Mod = String.valueOf(newattendee.AS_NAICSCode3__c);
            if(NAICS3Mod.contains('\''))
            {
                NAICS3MOd=NAICS3Mod.replaceAll('\'','');                    
            }
        }
        if(newattendee.AS_NAICSCode4__c > 10)
        {
            NAICS4Mod = String.valueOf(newattendee.AS_NAICSCode4__c);
            if(NAICS4Mod.contains('\''))
            {
                NAICS4MOd=NAICS4Mod.replaceAll('\'','');                    
            }
        }
          if(newattendee.AS_NAICSCode5__c > 10)
        {
            NAICS5Mod = String.valueOf(newattendee.AS_NAICSCode5__c);
            if(NAICS5Mod.contains('\''))
            {
                NAICS5MOd=NAICS5Mod.replaceAll('\'','');                    
            }
        }
        EditDate =String.valueOf(newattendee.AS_BirthDate__c); 
        BEDate=String.valueOf(newattendee.AS_BusinessEstablishedDate__c);
        
         System.debug('HEllo MALLIK END '+addattendee+'   '+ newAttendee);
         List<User_Profile_Event__c> CompareEmailId = [select id from User_Profile_Event__c where 
                                                    ((BoothAdmin_id__r.Email =: newattendee.AS_Email__c OR 
                                                    EventAdmin_Id__r.Email =: newattendee.AS_Email__c) AND (EV_id__c =:eventSelected ))  OR ((User_Id__r.Email =:newattendee.AS_Email__c) AND (Profile_ID__r.PR_Name__c = 'BoothPersonnel') AND (EV_id__c =:eventSelected ))
                                                    ]; 
      system.debug('-------------------------CompareEmailId'+CompareEmailId );
      
       if(CompareEmailId.size() >0){
           HideEmail = True;
           showEmail = False;
           ShowFirstName = False;
           ShowLastName = False;
           HideFirstName = True;
           HideLastName = True;
       }else {
         showEmail = True;
         HideEmail = False; 
         ShowFirstName = True;
         HideFirstName = False;
         ShowLastName = True;
         HideLastName = False;   
       }
    }

    //----------------------------------------------------------------------------------------END OF EDIT---------------------
//--------------------------------------------------------------------UPDATE ATTENDEE-------------------------
    public Event_Attendee_Mapping__c EventAttendee_Email{get;set;}
    public boolean imageerror{get;set;}
    public string imageerrormsg{get;set;}
    public PageREference UpdateAttendee() {
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
  system.debug('gggggggggggggg&&&&&&&'+attendeeImage);
  limitofbadges=false;
     Event_Attendee_Mapping__c EveAttmaprec = [select id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c 
                                                             where id=:eventname1];

    system.debug('***************************EmailExist Or Not'+newattendee.AS_Email__c);
   List<AttendeeSummary__c> AttendeeEmail = [select id,AS_FirstName__c,As_LastName__c from AttendeeSummary__c where 
                                                 AS_Email__c=:newattendee.AS_Email__c]; 
   system.debug('***************************Exist Or Not'+AttendeeEmail.size());
   if(AttendeeEmail.size()>0)
   {
       try{
       EventAttendee_Email = [select id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c 
                                                             where AS_id__r.AS_Email__c =:newattendee.AS_Email__c 
                                                             AND EV_id__c=:eventSelected ];
    }catch(exception e){}
      system.debug('%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%'+newattendee.AS_Email__c );

       if( EventAttendee_Email != null){
         
         if(EventAttendee_Email.id != eventName1){
          system.debug('%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%');  
          showerror = 'Attendee Already Exists!'; 
          DisplayError = True;
          } else
          {
           try
        {
        newattendee.AS_NAICSCode1__c =Integer.valueOf(NAICS1Mod);
        } catch(Exception e){}
        try{   
        newattendee.AS_NAICSCode2__c =Integer.valueOf(NAICS2Mod);
         }catch(Exception e){}
        try{
        newattendee.AS_NAICSCode3__c =Integer.valueOf(NAICS3Mod);
        } catch(Exception e){}
         try{
        newattendee.AS_NAICSCode4__c =Integer.valueOf(NAICS4Mod);
        }catch(Exception e){}
         try{
        newattendee.AS_NAICSCode5__c =Integer.valueOf(NAICS5Mod);
        }catch(Exception e){}
        update newattendee;
        system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+attendeeImage);
      
            eventatt=[select id,As_id__r.AS_FirstName__c,As_id__r.AS_LastName__c,As_id__r.AS_Company__c,EV_ID__C,
                       TicketTypes__c,EV_id__r.EV_Title__c,AS_id__r.AS_Title__c,
                       EA_AttendeeBarcode__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:EveAttmaprec.id]; 
            
           try{
          TicTypesforedit.TicketTypes__c='';
           for(string regtypes:selectedTicTypes){
           TicTypesforedit.TicketTypes__c+=regtypes+',';
           }
           update TicTypesforedit;      
           DivTypesforedit.DiversityType__c='';
           if(DiversityTypesforfirstline.size() != 0){
           for(string dtypes:DiversityTypesforfirstline){
           DivTypesforedit.DiversityType__c+=dtypes+';';
           }
           }
           if(DiversityTypesforsecondline.size() != 0){
           for(string dtypes:DiversityTypesforsecondline){
           DivTypesforedit.DiversityType__c+=dtypes+';';
           }
           }
            update DivTypesforedit; 
            }catch(exception e){}
             eventatt=[select id,As_id__r.AS_FirstName__c,As_id__r.AS_LastName__c,As_id__r.AS_Company__c,EV_ID__C,
                       TicketTypes__c,EV_id__r.EV_Title__c,AS_id__r.AS_Title__c,
                       EA_AttendeeBarcode__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:EveAttmaprec.id]; 
              
      if(attendeeImage != NULL && ( myimageName != '' || myimageName != NULL )){   
        if(attendeeImage.size() != null )
      {
      if(attendeeImage.size() <= 10240000){
      mydoc =new document();
      mydoc.body = attendeeImage;
      mydoc.folderid = UserInfo.getUserId();
      mydoc.ispublic=true;
      mydoc.Name = myimageName;
      insert mydoc; 
      system.debug(':::::::::::::::::::::::::Image:::::::::::::::'+mydoc);
      AttendeeSummary__c ImageUpload = [select AS_ImageUrl__c from AttendeeSummary__c where id=:AttendeeEmail[0].id];
      
      ImageUpload.AS_ImageUrl__c =mydoc.id;
      
      Update ImageUpload ; 
      addattendee=false;
             eventselected=eventselected; 
             getevents();
     system.debug(':::::::::::::::::::::::::Image:::::::::::::::'+ImageUpload.AS_ImageUrl__c);
    }else{
    imageerror=true;
    system.debug('========================= error message ==================='+imageerror);
    imageerrormsg='Image size should be less than 1MB';
    system.debug('========================= error message ==================='+imageerror);
    }
    }
    }else{addattendee=false; 
    eventselected=eventselected;
       getevents();
       }
          
          
            }  
           
        }
        else {
            
            
            EveAttmaprec.AS_id__c = AttendeeEmail[0].id;
            EveAttmaprec.Attendee_Event_IDs__c = AttendeeEmail[0].id+eventSelected; 
            update EveAttmaprec; 
             try{
          TicTypesforedit.TicketTypes__c='';
           for(string regtypes:selectedTicTypes){
           TicTypesforedit.TicketTypes__c+=regtypes+',';
           }
           update TicTypesforedit;      
           DivTypesforedit.DiversityType__c='';
           if(DiversityTypesforfirstline.size() != 0){
           for(string dtypes:DiversityTypesforfirstline){
           DivTypesforedit.DiversityType__c+=dtypes+';';
           }
           }
           if(DiversityTypesforsecondline.size() != 0){
           for(string dtypes:DiversityTypesforsecondline){
           DivTypesforedit.DiversityType__c+=dtypes+';';
           }
           }
            update DivTypesforedit; 
            }catch(exception e){}
             eventatt=[select id,As_id__r.AS_FirstName__c,As_id__r.AS_LastName__c,As_id__r.AS_Company__c,EV_ID__C,
                       TicketTypes__c,EV_id__r.EV_Title__c,AS_id__r.AS_Title__c,
                       EA_AttendeeBarcode__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:EveAttmaprec.id]; 
              
      if(attendeeImage != NULL && ( myimageName != '' || myimageName != NULL )){   
        if(attendeeImage.size() != null )
      {
      if(attendeeImage.size() <= 10240000){
      mydoc =new document();
      mydoc.body = attendeeImage;
      mydoc.folderid = UserInfo.getUserId();
      mydoc.ispublic=true;
      mydoc.Name = myimageName;
      insert mydoc; 
      system.debug(':::::::::::::::::::::::::Image:::::::::::::::'+mydoc);
      AttendeeSummary__c ImageUpload = [select AS_ImageUrl__c from AttendeeSummary__c where id=:AttendeeEmail[0].id];
      
      ImageUpload.AS_ImageUrl__c =mydoc.id;
      
      Update ImageUpload ; 
      addattendee=false;
             eventselected=eventselected; 
             getevents();
     system.debug(':::::::::::::::::::::::::Image:::::::::::::::'+ImageUpload.AS_ImageUrl__c);
    }else{
    imageerror=true;
    system.debug('========================= error message ==================='+imageerror);
    imageerrormsg='Image size should be less than 1MB';
    system.debug('========================= error message ==================='+imageerror);
    }
    }
    }else{addattendee=false; 
    eventselected=eventselected;
       getevents();
       }  
            }  
           
           
   }                                                          
     else{
        system.debug('--------------no attendee-----------------');
       AttendeeSummary__c UpdateAttendee = new AttendeeSummary__c();  
       system.debug('^^^^^^^^^^^^^^^^^^^^^^^^^'+newattendee.AS_FirstName__c);
        UpdateAttendee.AS_FirstName__c =newattendee.AS_FirstName__c;
        UpdateAttendee.AS_LastName__c =newattendee.AS_LastName__c; 
        UpdateAttendee.As_Email__c = newattendee.As_Email__c; 
        UpdateAttendee.AS_Company__c=newattendee.AS_Company__c;
        UpdateAttendee.AS_PrefixNew__c =newattendee.AS_PrefixNew__c ;
        UpdateAttendee.AS_SuffixNew__c =newattendee.AS_SuffixNew__c ;
        UpdateAttendee.AS_Title__c =newattendee.AS_Title__c ;
        UpdateAttendee.AS_CellPhone__c =newattendee.AS_CellPhone__c ;
        try{
       UpdateAttendee.AS_Age__c =Integer.valueOf(ageMod);
        } catch(Exception e)
        {
       UpdateAttendee.AS_Age__c = null;
        }
        UpdateAttendee.AS_HomePhone__c =newattendee.AS_HomePhone__c ;
        UpdateAttendee.AS_Gender__c =newattendee.AS_Gender__c;
        UpdateAttendee.AS_BirthDate__c = newattendee.AS_BirthDate__c;
        UpdateAttendee.AS_HomeAddress1__c =newattendee.AS_HomeAddress1__c ;
        UpdateAttendee.AS_BusinessDescription__c =newattendee.AS_BusinessDescription__c ;
        UpdateAttendee.AS_BusinessEstablishedDate__c =newattendee.AS_BusinessEstablishedDate__c;
        UpdateAttendee.AS_BusinessDunsNumber__c =newattendee.AS_BusinessDunsNumber__c;
        UpdateAttendee.AS_NumberOfEmployees__c =newattendee.AS_NumberOfEmployees__c ;
        UpdateAttendee.AS_BusinessRevenue__c =newattendee.AS_BusinessRevenue__c ;
        UpdateAttendee.AS_BusinessTaxId__c =newattendee.AS_BusinessTaxId__c ;
        UpdateAttendee.AS_PrimaryBusinessCategory1__c =newattendee.AS_PrimaryBusinessCategory1__c ;
        UpdateAttendee.AS_SecondaryBusinessCategory1__c =newattendee.AS_SecondaryBusinessCategory1__c ;
        UpdateAttendee.AS_WebsiteURL__c =newattendee.AS_WebsiteURL__c ;
        UpdateAttendee.AS_ShippingAddress1__c =newattendee.AS_ShippingAddress1__c ;
        UpdateAttendee.AS_ShippingPOBox__c =newattendee.AS_ShippingPOBox__c ;
        UpdateAttendee.AS_BlogURL__c =newattendee.AS_BlogURL__c ;
        UpdateAttendee.AS_WorkAddress1__c =newattendee.As_WorkAddress1__c ;
        UpdateAttendee.AS_WorkPhone__c =newattendee.AS_WorkPhone__c ;
        UpdateAttendee.AS_WorkPOBox__c =newattendee.AS_WorkPOBox__c ;
        UpdateAttendee.AS_DiversityType__c =newattendee.AS_DiversityType__c ;
        try
        {
        UpdateAttendee.AS_NAICSCode1__c =Integer.valueOf(NAICS1Mod);
        } catch(Exception e){}
        try{   
        UpdateAttendee.AS_NAICSCode2__c =Integer.valueOf(NAICS2Mod);
         }catch(Exception e){}
        try{
        UpdateAttendee.AS_NAICSCode3__c =Integer.valueOf(NAICS3Mod);
        } catch(Exception e){}
         try{
        UpdateAttendee.AS_NAICSCode4__c =Integer.valueOf(NAICS4Mod);
        }catch(Exception e){}
         try{
        UpdateAttendee.AS_NAICSCode5__c =Integer.valueOf(NAICS5Mod);
        }catch(Exception e){}
        UpdateAttendee.AS_shippingCity__c =newattendee.AS_shippingCity__c;
        UpdateAttendee.AS_shippingState__c = newattendee.AS_shippingState__c; 
        UpdateAttendee.AS_WorkAddress1__c = newattendee.AS_WorkAddress1__c;
        UpdateAttendee.AS_Workcity__c = newattendee.AS_Workcity__c;
        UpdateAttendee.AS_WorkState__c = newattendee.AS_WorkState__c;
        UpdateAttendee.AS_HomeAddress1__c = newattendee.AS_HomeAddress1__c;
        UpdateAttendee.AS_HomeCity__c =newattendee.AS_HomeCity__c;
        UpdateAttendee.AS_HomePOBox__c =newattendee.AS_HomePOBox__c;
        UpdateAttendee.As_Home_State__c =newattendee.As_Home_State__c;
        UpdateAttendee.AS_uniqueField__c=(newattendee.AS_FirstName__c + newattendee.AS_LastName__c + newattendee.AS_Email__c).tolowercase();
        insert UpdateAttendee; 
        system.debug('::::::::::::::::::::new attendee:::::::::'+UpdateAttendee.id);

       EveAttmaprec.AS_id__c = UpdateAttendee.id;
       EveAttmaprec.EV_id__c = eventSelected;
       EveAttmaprec.Attendee_Event_IDs__c = UpdateAttendee.Id+eventSelected;      
       EveAttmaprec.EA_AttendeeBarcode__c = EveAttmaprec.id+ '-'+eventSelected; 
        update EveAttmaprec;  
          system.debug('--------------Updated jun record-----------------'+EveAttmaprec.id);
        eventatt=[select id,As_id__r.AS_FirstName__c,As_id__r.AS_LastName__c,As_id__r.AS_Company__c,EV_ID__C,
                       TicketTypes__c,EV_id__r.EV_Title__c,AS_id__r.AS_Title__c,
                       EA_AttendeeBarcode__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:EveAttmaprec.id];
       if(attendeeImage != NULL && ( myimageName != '' || myimageName != NULL )){   
        if(attendeeImage.size() != null )
      {
      if(attendeeImage.size() <= 10240000){
      mydoc =new document();
      mydoc.body = attendeeImage;
      mydoc.folderid = UserInfo.getUserId();
      mydoc.ispublic=true;
      mydoc.Name = myimageName;
      insert mydoc; 
      system.debug(':::::::::::::::::::::::::Image:::::::::::::::'+mydoc);
      AttendeeSummary__c ImageUpload = [select AS_ImageUrl__c from AttendeeSummary__c where id=:UpdateAttendee.id];
      ImageUpload.AS_ImageUrl__c =mydoc.id; 
      Update ImageUpload ; 
       addattendee=false; 
       eventselected=eventselected;
       getevents();   
     system.debug(':::::::::::::::::::::::::Image:::::::::::::::'+ImageUpload.AS_ImageUrl__c);
    }else{
    imageerror=true;
    system.debug('========================= error message ==================='+imageerror);
    imageerrormsg='Image size should be less than 1MB';
    system.debug('========================= error message ==================='+imageerror);
    }
    }
    } else{
     addattendee=false; 
    eventselected=eventselected;
       getevents();
    }                                                          
     }
 
  return null; 
  }

    public PageReference Cancel()
     {
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); 
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
     fortwoprinters=false;
     limitofbadges=false;
    duplicateAttendeeBool=false;
    fbool=false;
    pdfbool=false;
    addattendee=false;
    addattendee1=false;
    addattendee=false;
     Dymo=false;
    DataImportBool = false;
    statuschange=false;
    emailstatuschange=false;
   //pagereference pf=new pagereference('/apex/Qrcode_Eventadmin_Attendees');
    //pf.setredirect(true);
        eventselected=eventselected;
     getevents();
        return null;
    }
    //------------------------------------------------------------------------------------------
     public List<selectoption> getselect()
    {
        List<selectoption> Option = new List<selectoption>();
        Option.add(new selectoption('Male','Male'));
        Option.add(new selectoption('Female','Female'));
        return option;
    }
    //----------------------------------------------------------------------
    public PageReference backaction() {
    addattendee1 = FALSE;
    pagereference pg = new pagereference('/apex/Qrcode_Eventadmin_Attendees');
        pg.setRedirect(true);
        return pg; 
    }

    //----------------------------------------------------------------------FOR 5392 LABEL----------------------------------------
         
    public void PrintBadge()
     {
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
     limitofbadges=false;
      EventReqStringBool =false;
      attid=new List<id>();
      integer count=0;
      if(TotalAttendees.size()>0)
      {
      if(eventname1 != '')
      {
      attforexport=new List<Event_Attendee_Mapping__c>();
      exportlistoflist=new List<List<Event_Attendee_Mapping__c>>();
      attendeeslist=new List<Event_Attendee_Mapping__c>();
        if(Allrecords == true)
      {
     
      attendeeslist = [select AS_id__c,AS_id__r.id, AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,
                              AS_id__r.AS_Company__c,EA_AttendeeBarcode__c,AS_id__r.AS_CellPhone__c,IsPrifileUpdate__c,
                              EA_isBadgePrinted__c,AS_id__r.AS_Title__c,EV_id__r.EV_Title__c,TicketTypes__c    
                              ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where EV_id__c =: eventselected];
      system.debug('atttttttttttt list'+attendeeslist);           
      for( Event_Attendee_Mapping__c  aa: attendeeslist)
     {
     attid.add(aa.id);
     }            
     }else
     {
     
     List<string> listeventname=eventname1.split(',');
     for(string  aa: listeventname)
     {
     attid.add((id)aa);
     }
     
     attendeeslist=[select AS_id__c,AS_id__r.id, AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,
                              AS_id__r.AS_Company__c,EA_AttendeeBarcode__c,AS_id__r.AS_CellPhone__c,IsPrifileUpdate__c,
                              EA_isBadgePrinted__c,AS_id__r.AS_Title__c,EV_id__r.EV_Title__c,TicketTypes__c     
                              ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where  id in:attid];
     }
     if(attendeeslist.size() <=500){
     system.debug('==============================attendeeslist.size==============='+attendeeslist.size());
      for(Event_Attendee_Mapping__c s:attendeeslist){
      count++;
      system.debug('==============================count==============='+count);
         attforexport.add(s);
         if(count==1000)
         {
          system.debug('==============================count==============='+count);
         exportlistoflist.add(attforexport);
         attforexport = new LIST<Event_Attendee_Mapping__c>();
         count=0;
          }
            
      
      }
      if(count!=0){
       exportlistoflist.add(attforexport); 
       }     
    try
    {
     attach=[select EV_EventLogo__c from Event__c where id =:eventSelected];
     logo=true;
    }catch(exception e)
    {
    logo=false;
    }
    system.debug('////////////////////////////////////selected value ///////////'+selectedvalues);
 
    if(selectedvalues != 'Dymo Label(30856,Single Label)' && selectedvalues != 'Zebra Label' )
     {
      
        newstr=new List<InnerForBadge >();
        newstr1=new List<InnerForBadge >();        
        integer i=0;
        LIST<ID> badgeAttid = new LIST<ID>();
         
        for(Event_Attendee_Mapping__c evj: attendeeslist)
        {
            badgeAttid.add(evj.AS_id__c);
        }
     
     MAP<ID, Sobject> printbad = new MAP<id, SObject>([select id, name,AS_LastName__c,AS_FirstName__c,AS_Company__c, AS_Title__c FROM AttendeeSummary__c WHERE ID IN: badgeAttid ]);  
   
     for(Event_Attendee_Mapping__c eww: attendeeslist)
    {
    if(math.mod(i,2)==0)
    {
     InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get(selfieldvalue) ,(String)printbad.get(eww.AS_id__c).get(selLvalue) ,(String)printbad.get(eww.AS_id__c).get(selTvalue), eww.EA_AttendeeBarcode__c,eww.TicketTypes__c);
    system.debug(':::::::::::::::barCode:::::::::::'+eww.TicketTypes__c);
     newstr.add(ifb);
    }
      else
      {
        InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get(selfieldvalue) ,(String)printbad.get(eww.AS_id__c).get(selLvalue) ,(String)printbad.get(eww.AS_id__c).get(selTvalue),eww.EA_AttendeeBarcode__c,eww.TicketTypes__c);
        newstr1.add(ifb);
      }
       i++;
    }
    
     LIST<InnerForBadge > FLRec = new LIST<InnerForBadge>();
     LeftValues = new LIST<LIST<InnerForBadge>>();
     integer Lpagecount=0;
     for(InnerForBadge  l: newstr)
     {
        FLRec.add(l);
        Lpagecount++;
        if(Lpagecount==3)
     {
        LeftValues.add(FLRec);
        Lpagecount=0;
        FLRec = new LIST<InnerForBadge >();
     }
    }
      if(FLRec.size() != 0)
      {
       LeftValues.add(FLRec);
      }
      LIST<InnerForBadge > SLRec = new LIST<InnerForBadge >();
      RightValues = new LIST<LIST<InnerForBadge >>();
      integer Rpagecount=0;
      for(InnerForBadge  l: newstr1)
      {
        SLRec.add(l);
        Rpagecount++;
        if(Rpagecount==3)
      {
        RightValues.add(SLRec);
        Rpagecount=0;
        SLRec = new LIST<InnerForBadge >();
      }
      }
      if(SLRec.size() != 0)
        {
        RightValues.add(SLRec);
        }  
        addattendee1 = TRUE;
        event1= new Event_Attendee_Mapping__c();        
        }
        }else{
         system.debug('==============================attendeeslist.size==============='+attendeeslist.size());
          EventReqString = 'Please donot Select more than 500 attendees to print';
              EventReqStringBool = TRUE;
        }
        }
        else
        {
        EventReqString = 'Please Select atleast one Attendee';
              EventReqStringBool = TRUE;
        }
        }
        
        else
        if(TotalAttendees.size()<=0)
        {
        EventReqString = 'Please create an Attendee';
              EventReqStringBool = TRUE;
        }
        
        }
//-----------------------------------------------------------END OF FIRSTLABEL------------------------------    
//---------------------------------------------------------------FOR EASY PEAL OFF BADGE----------------    
     public void PrintBadgeforthree()
    {
    limitofbadges=false;
        fbool=false;
        EventReqStringBool =false;
      attid=new List<id>();
      integer count=0;
      if(TotalAttendees.size()>0)
      {
      if(eventname1 != '')
      {
      attforexport=new List<Event_Attendee_Mapping__c>();
      exportlistoflist=new List<List<Event_Attendee_Mapping__c>>();
      attendeeslist=new List<Event_Attendee_Mapping__c>();
        if(Allrecords == true)
      {
     
      attendeeslist = [select AS_id__c,AS_id__r.id, AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,
                              AS_id__r.AS_Company__c,EA_AttendeeBarcode__c,AS_id__r.AS_CellPhone__c,IsPrifileUpdate__c,
                              EA_isBadgePrinted__c,AS_id__r.AS_Title__c,EV_id__r.EV_Title__c,TicketTypes__c     
                              ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where EV_id__c =: eventselected];
                 
      for( Event_Attendee_Mapping__c  aa: attendeeslist)
     {
     attid.add(aa.id);
     }            
     }else
     {
     
     List<string> listeventname=eventname1.split(',');
     for(string  aa: listeventname)
     {
     attid.add((id)aa);
     }
     
     attendeeslist=[select AS_id__c,AS_id__r.id, AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,
                              AS_id__r.AS_Company__c,EA_AttendeeBarcode__c,AS_id__r.AS_CellPhone__c,IsPrifileUpdate__c,
                              EA_isBadgePrinted__c,AS_id__r.AS_Title__c,EV_id__r.EV_Title__c,TicketTypes__c     
                              ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where  id in:attid];
     }
      for(Event_Attendee_Mapping__c s:attendeeslist){
      count++;
      system.debug('==============================count==============='+count);
         attforexport.add(s);
         if(count==1000)
         {
          system.debug('==============================count==============='+count);
         exportlistoflist.add(attforexport);
         attforexport = new LIST<Event_Attendee_Mapping__c>();
         count=0;
          }
            
      
      }
      if(count!=0){
       exportlistoflist.add(attforexport); 
       }     
   
        newstr=new List<InnerForBadge >();
        newstr1=new List<InnerForBadge >();
        newstr2=new List<InnerForBadge >();      
       integer i=0;
       LIST<ID> badgeAttid = new LIST<ID>();
         
        for(Event_Attendee_Mapping__c evj: attendeeslist)
        {
        badgeAttid .add(evj.AS_id__c);
        }
       MAP<ID, Sobject> printbad = new MAP<id, SObject>([select id, name,AS_LastName__c,AS_FirstName__c,AS_Company__c, AS_Title__c FROM AttendeeSummary__c WHERE ID IN: badgeAttid]);  
       for(Event_Attendee_Mapping__c eww: attendeeslist)
       {
       if(math.mod(i,3)==0)
      {
        if(selfieldvalue == 'AS_FirstName__c,AS_LastName__c'){
        InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get('AS_FirstName__c')+(String)printbad.get(eww.AS_id__c).get('AS_LastName__c') ,(String)printbad.get(eww.AS_id__c).get(selLvalue),eww.EA_AttendeeBarcode__c);
        newstr.add(ifb);
        }else{
        InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get(selfieldvalue ) ,(String)printbad.get(eww.AS_id__c).get('AS_FirstName__c')+(String)printbad.get(eww.AS_id__c).get('AS_LastName__c'),eww.EA_AttendeeBarcode__c);
        newstr.add(ifb);
        }
      }
      else if(math.mod(i,3)==1)
      {
        if(selfieldvalue == 'AS_FirstName__c,AS_LastName__c'){
        InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get('AS_FirstName__c')+(String)printbad.get(eww.AS_id__c).get('AS_LastName__c') ,(String)printbad.get(eww.AS_id__c).get(selLvalue) ,eww.EA_AttendeeBarcode__c);
        newstr1.add(ifb);
        }else{
        InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get(selfieldvalue) ,(String)printbad.get(eww.AS_id__c).get('AS_FirstName__c')+(String)printbad.get(eww.AS_id__c).get('AS_LastName__c') ,eww.EA_AttendeeBarcode__c);
        newstr1.add(ifb);
        }
      }
      else if(math.mod(i,3)==2)
      {
       if(selfieldvalue == 'AS_FirstName__c,AS_LastName__c'){
       InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get('AS_FirstName__c')+(String)printbad.get(eww.AS_id__c).get('AS_LastName__c') ,(String)printbad.get(eww.AS_id__c).get(selLvalue) ,eww.EA_AttendeeBarcode__c);
       newstr2.add(ifb);
       }else {
       InnerForBadge ifb = new InnerForBadge( (String)printbad.get(eww.AS_id__c).get(selfieldvalue),(String)printbad.get(eww.AS_id__c).get('AS_FirstName__c')+(String)printbad.get(eww.AS_id__c).get('AS_LastName__c') ,eww.EA_AttendeeBarcode__c);
       newstr2.add(ifb);
        }
      }
       i++;
    }
    LIST<InnerForBadge > FLRec = new LIST<InnerForBadge >();
    LeftValues = new LIST<LIST<InnerForBadge >>();
    integer Lpagecount=0;
    for(InnerForBadge  l: newstr)
    {
        FLRec.add(l);
        Lpagecount++;
    if(Lpagecount==4)
    {
        LeftValues.add(FLRec);
        Lpagecount=0;
        FLRec = new LIST<InnerForBadge >();
     }
     }
     if(FLRec.size() != 0)
     {  
     LeftValues.add(FLRec);
     }
     LIST<InnerForBadge > MLRec = new LIST<InnerForBadge >();
     MiddleValues = new LIST<LIST<InnerForBadge >>();
     integer Middlecount=0;
     for(InnerForBadge  l: newstr1)
     {
     MLRec.add(l);
     Middlecount++;
     if(Middlecount==4)
     {
     MiddleValues.add(MLRec);
     Middlecount=0;
     MLRec = new LIST<InnerForBadge >();
     }
    }
    if(MLRec.size() != 0)
    {    
    MiddleValues.add(MLRec);
    }
    LIST<InnerForBadge > SLRec = new LIST<InnerForBadge >();
    RightValues = new LIST<LIST<InnerForBadge >>();
    integer Rpagecount=0;
    for(InnerForBadge  l: newstr2)
    {
     SLRec.add(l);
     Rpagecount++;
    if(Rpagecount==4)
    {
     RightValues.add(SLRec);
     Rpagecount=0;
     SLRec = new LIST<InnerForBadge >();
    }  
    }
    if(SLRec.size() != 0)
    {
     RightValues.add(SLRec);
    }
    try
    { 
    attach=[select EV_EventLogo__c from Event__c where id =:eventSelected];          
    if(attach != null)
    {
     logo=true;
    }
    }catch(exception e){

        logo=false;
        }
        addattendee1 = TRUE;
        event1= new Event_Attendee_Mapping__c();
        }
        else
        {
        EventReqString = 'Please Select atleast one Attendee';
        EventReqStringBool = TRUE;
        }
        }
        
        else
        if(TotalAttendees.size()<=0)
        {
        EventReqString = 'Please create an Attendee';
              EventReqStringBool = TRUE;
        }
        
    }
    //------------------------------------------------------FOR ATTENDEE DELETE--------------------
    public void deleteAdminRecord() {
    limitofbadges=false;
    emailalert=false;    
    if(eventName1 != null || eventName1 !=''){
    Event_Attendee_Mapping__c delrec =[select id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id=: eventName1];
    Delete delrec ;
    getevents();
    }     
    }
    
    public boolean  EventReqStringbool3{get;set;}
    public PageReference attendeedetail() {
    Event_Attendee_Mapping__c ss=[select AS_id__r.id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c  where id =:eventname1 limit 1];
    PageReference pg = new pagereference('/apex/qrcode_attendee_details?id='+eventname1 );
    pg.setRedirect(true);
    return pg;  
    }
    //----------------------------------------------------------------------FOR Import------------------------    
    public void ShowPreviousList() {
    limitofbadges=false;
    emailalert=false;
    DataImportBool = TRUE;
    ImportHistory = new LIST<DataImport_SavePoint__c>();    
    ImportHistory = [Select d.User_id__c,d.createdDate, d.Name, d.DS_TotalRecords__c, d.DS_FileName__c From DataImport_SavePoint__c d WHERE User_id__c =: userInfo.getUserId()];
    }
    //------------------------------------------------------POPUP FOR SELECTING DESIRED LABEL-----------------------------------
    public void popup() {
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
    if(browserType != null && browserType.contains('MSIE')){
    Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
    }
    attid=new List<id>();
    limitofbadges=false;
    emailalert=false;
    custombadge1=false;
    totalselectlist=false;
    print=false;
    selectedvalues ='select';
    EventReqStringBool = false;
    Event1 = new Event_Attendee_Mapping__c();
    if(Allrecords == true)
   {
    attforexport=new List<Event_Attendee_Mapping__c>(); 
    attforexport=[select id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c WHERE ev_Id__c =: eventselected];
    if(attforexport.size()>500)
    {
      limitofbadges = TRUE;
    } else
     {
    EventReqStringBool =false;
    for(Event_Attendee_Mapping__c emEvent1 :eventlist)
    {
    if(eventname1!= null && eventname1!='' && eventname1.equals(emEvent1.Id))
    {
    fbool= TRUE;
    Event1 = emEvent1;
    break;
    }
    }
    Event__c EVprinter=[select Event_Printer__c from Event__c where id =:eventselected];
   system.debug('==================selected printer======='+EVprinter.Event_Printer__c);
   if(EVprinter.Event_Printer__c != null){
   SelectedValues=EVprinter.Event_Printer__c;
   print=true;
   }
    getfields();
    }
    
    }
    
  
    else
    
    if(eventname1 != '' && eventname1 != null)
    {
     List<string> listeventname=eventname1.split(',');
     for(string  aa: listeventname)
     {
     attid.add((id)aa);
     }
     
     attendeeslist=[select id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where  id in:attid];
   

    system.debug(':::::::::::::::::size:::::::::::'+attendeeslist.size());
    if(attendeeslist.size() <=500 ){
    system.debug('lllllllllllllllllllllllllllll'+listeventname.size());
    EventReqStringBool =false;
    for(Event_Attendee_Mapping__c emEvent1 :eventlist)
    {
    if(eventname1!= null && eventname1!='' && eventname1.equals(emEvent1.Id))
    {
    fbool= TRUE;
    Event1 = emEvent1;
    break;
    }
    }
    Event__c EVprinter=[select Event_Printer__c from Event__c where id =:eventselected];
   system.debug('==================selected printer======='+EVprinter.Event_Printer__c);
   if(EVprinter.Event_Printer__c != null){
   SelectedValues=EVprinter.Event_Printer__c;
   print=true;
   }
    getfields();
    }else{
    //EventReqString = 'Please do not select more than 500 attendees at a time to print';
    limitofbadges= TRUE;
    }
    }
    else
    {
    EventReqString = 'Please select atleast one attendee to print';
    EventReqStringBool = TRUE;
    }
    } 
   //--------------------------------------------------------------------------------------EMAIL BADGE------------------------
     public PageReference emailBadge() {
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
    if(browserType != null && browserType.contains('MSIE')){
    Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
    }
     emailalert=false;
     limitofbadges=false;
     if(eventname1 != '')
        {
        EventReqStringBool = false;
        List<string> listeventname=eventname1.split(',');
        attid=new List<id>();
        for(string  aa: listeventname)
        {
        attid.add((id)aa);
        } 
    list<Event_Attendee_Mapping__c> emailids=[select id,EA_AttendeeBarcode__c,AS_id__r.AS_LastName__c,
                                                       AS_id__r.AS_FirstName__c, AS_id__r.AS_Email__c
                                                      ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id IN : attid];
    list<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    for(Event_Attendee_Mapping__c eid: emailids)
     { 
     pdf=page.Qrcode_EmailBadgeToAttendees; 
     string fss =eid.EA_AttendeeBarcode__c;
     pdf.getParameters().put('id',fss);
     b = pdf.getContent();
     Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
     email.setSubject('Your Ticket For Registered Event!');
     String [] toAddresses = new String[] {eid.AS_id__r.AS_Email__c};
     email.setToAddresses(toAddresses);
     email.setHTMLBody(message='Hello '+' '+''+ eid.AS_id__r.AS_FirstName__c +'<br/>'+''+'<br/>'+
     ' Your badge for the registered event is attached as a pdf. You can view this'+'<br/>'+ 
          'badge from your mobile device.'+'<br/>'+
          'If you have any questions please contact Booth Leads customer support.'+'<br/>'+''+'<br/>'+'<br/>'+
          
          ' Thank you,' +'<br/>'+
          'Booth Leads customer support'+'<br/>'+
          'support@boothleads.com.'+'<br/>'+
          'Phone: 1-(800)-492-1289.' 
          
          );
                                                                                               
     Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
     efa.setFileName('Mybadge.pdf');                                                        
     efa.setBody(b);                                                                          
     email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
     emails.add(email);                                                                           
    } 
    Messaging.SendEmailResult[]  r = Messaging.sendEmail(emails);
   // Messaging.SendEmailResult[]  r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emails});
    boolean check=true;
    for(Messaging.SendEmailResult ms: r){
       check=check && ms.isSuccess();
    }
    if(check == true)
    {
    emailalert=true;
    }
    }
    else
    {
      EventReqStringBool = true;
      EventReqString = 'Please Select an attendee to send a mail';
    }
    eventselected=eventselected;
  
    return null;
    }
    //-------------------------------------------------------------------------------------------------------------------------
    public PageReference ImportAttendee() {
    pagereference pg = new pagereference('/apex/BL_AttendeesImport?id='+eventSelected );
    pg.setredirect(true);
    return pg;
    }
    Public PageReference ProfileSettings()
    {
    Pagereference pg = new Pagereference('/apex/BL_Eventadmin_Profile');
    Pg.setredirect(true);
    Return pg;
    }    
//-----------------------------------------------------------------------------------GENERATE PDF FOR BADGES--------------
    public PageReference genpdf() {
    selectedprint();
    limitofbadges=false;
    checkedbadge= new List<Event_Attendee_Mapping__c>();
    List<Event_Attendee_Mapping__c> changed=new List<Event_Attendee_Mapping__c>{};
  
    checkedbadge=[select id, EA_isBadgePrinted__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id in:attid];
    for(Event_Attendee_Mapping__c dd:checkedbadge)
    {
    dd.EA_isBadgePrinted__c=true;
    changed.add(dd);
    }
    update changed;
    if(selectedvalues=='Avery 5392 Name badges')
    {
     pagereference pg =page.Qrcode_printbadge_5392label;
    
     return pg;   
    }
    else if(selectedvalues=='Avery 22806 easy peal square Badges')
    {
    pagereference pf =page.Qrcode_printbadge_PealoffLabel;
    return pf;    
    }
    if(selectedvalues=='Dymo Label(30856,Single Label)')
    {
    pagereference pf =page.qrcode_Dymolabel;
    return pf;  
   
    }
    if(selectedvalues=='Zebra Label')
    {
    pagereference pf =page.qrcode_Zebralabel;
    return pf;  
   
    }
    return null;     
    }   
    //-------------------------------------------------INNER CLASS------------------------------
    public class EventWrapper
    {
    public Event_Attendee_Mapping__c atnd {get;set;}
    public string z{get;set;} 
    public string status{get;set;}
    public string Estatus{get;set;}
    public string hover{get;set;}
    public EventWrapper(Event_Attendee_Mapping__c atnd)
    {
    this.atnd=atnd;
   
    if(atnd.EA_isBadgePrinted__c==true)
    {
    this.z='background-color:#e2e2e2;"';
      this.hover='Already Printed';
      this.status='Printed';
      }
      else
      {
      this.status='Not Printed';
      }
    if(atnd.IsPrifileUpdate__c == true)
    {
     this.Estatus='Sent';
    }
    else
    {
    this.Estatus='Not Sent';
    }
    }
    }
    //------------------------------------------------------IINER EMAIL----------------
   public class inneremail
   {
   public Event_Attendee_Mapping__c qq{get;set;}
   public inneremail(Event_Attendee_Mapping__c qq)
   {
   this.qq=qq;
   }
   } 
   //--------------------------------------------------------------INNER FOR BADGE SETTINGS-----------------------
   public class InnerForBadge{
   public String fName{get; set;}
   public String sName{get; set;}
   public String lName{get; set;}
   public String fLName{get; set;}
   public String barCode{get;set;}
   public string ticket{get;set;}
   public InnerForBadge(String fn, String ln ,String em, String code,string ticketforb){ 
            fName = fn;
            sName = ln;
            lName =em;
            barCode = code; 
            ticket=ticketforb;   
        }
        public InnerForBadge(String fLn,String em, String code ){
            
            fLName = fLn;
            lName =em;
            barCode = code;  
        }
    }
    //--------------------------------------------------------------------------------- INNER CLASS BY MALLIK
    public class InnerByMallik{
    
        public String barcode{get; set;}
        public AttendeeSummary__c AttSummary{get; set;}
        public InnerByMallik(String fn, AttendeeSummary__c at ){   
            AttSummary = new AttendeeSummary__c();
            barcode = fn;
            AttSummary = at;
            
            
        }
    
    }
     public list<selectoption> font{get;set;} 
    public list<selectoption> fieldnames{get;set;}
//---------------------------------------------------------for colors----------------
    public List<SelectOption> getcolors()
     {
            List<SelectOption> options = new List<SelectOption>();
            
            return options;
            
    }
    
    //------------------------------------------Font Face----------------------------
    public  List<SelectOption> getface() {
    List<SelectOption> options = new List<SelectOption>();
    return null;
    }
    //----------------------------------------Printing att badge---------------------
    public Event_Attendee_Mapping__c eamforprint{get;set;}
    public pagereference attbadge()
    {
    eamforprint=[select EA_isBadgePrinted__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =: eventatt.id];
    eamforprint.EA_isBadgePrinted__c = true;
    update eamforprint;
    
    pdfbool=false;
    if(selectedvalues == 'Dymo Label(30856,Single Label)'){
    pagereference pg=page.qrcode_badgeofanattendee;
     return pg;
    }else{
    pagereference pg=page.qrcode_zebrabadgeofanattendee;
     return pg;
    }
    return null;

    }
    //-------------------------for Delete All--------------------------------------------
    public pagereference deleteallattendees()
    {
    
    limitofbadges=false;
    EventReqStringBool=false;
    emailalert=false;
    if(eventname1 == '' || eventname1 == null)
    {
      EventReqStringBool = true;
      EventReqString = 'Please Select an attendee to Delete';
    }
    else{
    if(Allrecords == true)
    {
     attforexport=new List<Event_Attendee_Mapping__c>(); 
     attforexport=[select id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c WHERE ev_Id__c =: eventselected AND Boothleads_Profile__c =: 'Attendee'];
     
     delete attforexport;
    }
    else
    {
    if(eventname1 != '')
      {
       EventReqStringBool = false;
        List<string> listeventname=eventname1.split(',');
        attid=new List<id>();
        for(string  aa: listeventname)
        {
        attid.add((id)aa);
        system.debug('aaaannnnnnnn'+aa);
        }
      attforexport=[select id ,Boothleads_Profile__c  from Event_Attendee_Mapping__c WHERE id in: attid And Boothleads_Profile__c =: 'Attendee'];
      delete attforexport;
    }  
    }
    getevents();
    }
    return null;
    }
    //-------------------------for Esport All--------------------------------------------
    public string escape(string s){
      
     
      if(s != null && s.contains(',')){
          
         s=s.replaceAll('"','');
          
          s='"'+s+'"';
       } 
            
       return s;
      }
      

    //--------------------------------------------------------------------------
    public list<list<Event_Attendee_Mapping__c>> exportlistoflist{get;set;}
    public pagereference exportAll()
    {
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
    if(browserType != null && browserType.contains('MSIE')){
     Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
    }
    limitofbadges=false;
    exportlistoflist=new list<list<Event_Attendee_Mapping__c>>{};
    EventReqStringBool =false;
    attforexport=new List<Event_Attendee_Mapping__c>();
    if(eventname1 == '' || eventname1  == null){
    EventReqStringBool = TRUE;
    
    }
    else
    { 
    if(Allrecords == true)
    {
    eventlist=new List<Event_Attendee_Mapping__c>();
    
        integer i=0;
     eventlist=[select id,TicketTypes__c,AS_id__r.AS_Age__c,AS_id__r.AS_BirthDate__c,AS_id__r.AS_BlogUrl__c,AS_id__r.AS_BusinessDescription__c,AS_id__r.AS_BusinessDunsNumber__c,
                                 AS_id__r.AS_BusinessEstablishedDate__c,AS_id__r.AS_BusinessRevenue__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_CellPhone__c,
                                 AS_id__r.AS_Company__c,DiversityType__c,AS_id__r.AS_Email__c,AS_id__r.AS_FaxNumber__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Gender__c,
                                 AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_Country__c,AS_id__r.AS_HomePhone__c,
                                 AS_id__r.AS_HomePoboxNo__c,AS_id__r.As_Home_State__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_LastName__c,AS_id__r.AS_NAICSCode1__c,
                                 AS_id__r.AS_NAICSCode2__c,AS_id__r.AS_NAICSCode3__c,AS_id__r.AS_NAICSCode4__c,AS_id__r.AS_NAICSCode5__c,AS_id__r.AS_NumberOfEmployees__c,AS_id__r.As_prefixNew__c,
                                 AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.AS_SecondaryBusinessCategory1__c,AS_id__r.AS_ShippingAddress1__c,AS_id__r.AS_ShippingAddress2__c,
                                 AS_id__r.AS_ShippingCity__c,AS_id__r.As_Shipping_Country__c,AS_id__r.AS_ShippingPhone__c,AS_id__r.AS_Shippingpoboxno__c,AS_id__r.As_Shipping_States__c,
                                 AS_id__r.AS_shippingzip__c,AS_id__r.As_SuffixNew__c,AS_id__r.AS_ThroughEventBrite__c,AS_id__r.AS_Title__c,AS_id__r.AS_WebsiteUrl__c,AS_id__r.AS_WorkAddress1__c,
                                 AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Workpoboxno__c,AS_id__r.AS_Work_States__c,
                                 AS_id__r.AS_WorkZip__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c WHERE ev_Id__c =:eventselected];
 
    for(Event_Attendee_Mapping__c s:eventlist){
     s.AS_id__r.AS_BlogUrl__c             = escape(s.AS_id__r.AS_BlogUrl__c);
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
     system.debug('==========================escape==================================='+s.AS_id__r.AS_PrimaryBusinessCategory1__c);
     s.As_id__r.Registration_type__c = escape(s.As_id__r.Registration_type__c); 
       s.AS_id__r.AS_SecondaryBusinessCategory1__c = escape(s.AS_id__r.AS_SecondaryBusinessCategory1__c);
       system.debug('==========================escape==================================='+s.AS_id__r.AS_SecondaryBusinessCategory1__c);
     
     i++;
         attforexport.add(s);
         if(i==1000)
         {
         exportlistoflist.add(attforexport);
         attforexport = new LIST<Event_Attendee_Mapping__c>();
         i=0;
          }
      
       }
       
       if(i!=0){
       exportlistoflist.add(attforexport);
       pagereference pg=new pagereference('/apex/Qrcode_exportAttendees');
       pg.setredirect(false);
       return pg;
       }
       }
    else{
    if(eventname1 != '')
      {
         EventReqStringBool = false;
        List<string> listeventname=eventname1.split(',');
        attid=new List<id>();
        for(string  aa: listeventname)
        {
        attid.add((id)aa);
        system.debug('aaaannnnnnnn'+aa);
        }
        integer i=0;
     eventlist=[select id,TicketTypes__c,AS_id__r.AS_Age__c,AS_id__r.AS_BirthDate__c,AS_id__r.AS_BlogUrl__c,AS_id__r.AS_BusinessDescription__c,AS_id__r.AS_BusinessDunsNumber__c,
                                 AS_id__r.AS_BusinessEstablishedDate__c,AS_id__r.AS_BusinessRevenue__c,AS_id__r.AS_BusinessTaxId__c,AS_id__r.AS_CellPhone__c,
                                 AS_id__r.AS_Company__c,DiversityType__c,AS_id__r.AS_Email__c,AS_id__r.AS_FaxNumber__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_Gender__c,
                                 AS_id__r.AS_HomeAddress1__c,AS_id__r.AS_HomeAddress2__c,AS_id__r.AS_HomeCity__c,AS_id__r.As_Home_Country__c,AS_id__r.AS_HomePhone__c,
                                 AS_id__r.AS_HomePoboxNo__c,AS_id__r.As_Home_State__c,AS_id__r.AS_HomeZip__c,AS_id__r.AS_ImageUrl__c,AS_id__r.AS_LastName__c,AS_id__r.AS_NAICSCode1__c,
                                 AS_id__r.AS_NAICSCode2__c,AS_id__r.AS_NAICSCode3__c,AS_id__r.AS_NAICSCode4__c,AS_id__r.AS_NAICSCode5__c,AS_id__r.AS_NumberOfEmployees__c,AS_id__r.As_prefixNew__c,
                                 AS_id__r.AS_PrimaryBusinessCategory1__c,AS_id__r.AS_SecondaryBusinessCategory1__c,AS_id__r.AS_ShippingAddress1__c,AS_id__r.AS_ShippingAddress2__c,
                                 AS_id__r.AS_ShippingCity__c,AS_id__r.As_Shipping_Country__c,AS_id__r.AS_ShippingPhone__c,AS_id__r.AS_Shippingpoboxno__c,AS_id__r.As_Shipping_States__c,
                                 AS_id__r.AS_shippingzip__c,AS_id__r.As_SuffixNew__c,AS_id__r.AS_ThroughEventBrite__c,AS_id__r.AS_Title__c,AS_id__r.AS_WebsiteUrl__c,AS_id__r.AS_WorkAddress1__c,
                                 AS_id__r.AS_WorkAddress2__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_Work_Country__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_Workpoboxno__c,AS_id__r.AS_Work_States__c,
                                 AS_id__r.AS_WorkZip__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c WHERE id in: attid];
 
    for(Event_Attendee_Mapping__c s:eventlist){
     s.AS_id__r.AS_BlogUrl__c             = escape(s.AS_id__r.AS_BlogUrl__c);
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
     system.debug('==========================escape==================================='+s.AS_id__r.AS_PrimaryBusinessCategory1__c);
     s.As_id__r.Registration_type__c = escape(s.As_id__r.Registration_type__c); 
       s.AS_id__r.AS_SecondaryBusinessCategory1__c = escape(s.AS_id__r.AS_SecondaryBusinessCategory1__c);
       system.debug('==========================escape==================================='+s.AS_id__r.AS_SecondaryBusinessCategory1__c); 
     i++;
         attforexport.add(s);
         if(i==1000)
         {
         exportlistoflist.add(attforexport);
         attforexport = new LIST<Event_Attendee_Mapping__c>();
         i=0;
          }
      
       }
       if(i!=0){
       exportlistoflist.add(attforexport);                          
                              
    }   
     
    
   
     
     
    pagereference pg=new pagereference('/apex/Qrcode_exportAttendees');
       pg.setredirect(false);
       return pg;   
   }
 }
 }
   return null;
   
}
//-------------------------- Diversity Type -----------------
    Public List<String> Selvalue {get;set;}
    Public Boolean Select0{get;set;}
    Public Boolean Select1{get;set;}
    Public Boolean Select2{get;set;}
    Public Boolean Select3{get;set;}
    Public Boolean Select4{get;set;}
    Public Boolean Select5{get;set;}
    Public Boolean Select6{get;set;}
    Public Boolean Select7{get;set;}
    Public Boolean Select8{get;set;}
    Public Boolean Select9{get;set;}
    Public Boolean Select10{get;set;} 
    Public Boolean Select11{get;set;}
    Public Boolean Select12{get;set;}
    Public Boolean Select13{get;set;}
    Public Boolean Select14{get;set;}   
    Public string selectedvaluesfordiversity{get;set;}
    
    //-----------------------------------------------------------profileUpdateNotification---------------------------------
    public pagereference profileUpdateNotification()
    {
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
    limitofbadges=false;
    emailalert=false;
    if(eventname1 != '')
        {
        EventReqStringBool = false;
        List<string> listeventname=eventname1.split(',');
        attid=new List<id>();
        for(string  aa: listeventname)
        {
        attid.add((id)aa);
        }  
    list<Event_Attendee_Mapping__c> emailids=[select id,IsPrifileUpdate__c,AS_id__r.id,AS_id__r.AS_FirstName__c, EV_id__r.id,   EV_id__r.EV_Title__c, AS_id__r.AS_Email__c
                                                      ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id IN : attid];
    list<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    List<Event_Attendee_Mapping__c> ASUpdate=new List<Event_Attendee_Mapping__c>();
    for(Event_Attendee_Mapping__c eid: emailids)
     {   
     Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
     email.setSubject('Update Your Profile!');
     String [] toAddresses = new String[] {eid.AS_id__r.AS_Email__c};
     email.setToAddresses(toAddresses);
     email.setHTMLBody(message='Dear ' +' '+ eid.AS_id__r.AS_FirstName__c +'<br/>'+''+'<br/>'+ 
             +'Welcome to '+ eid.EV_id__r.EV_Title__c+'!'+''+'<br/><br/>'+
          'Please update your profile by clicking on the link at the end of this email.'+'<br/>'+
          'Your updated profile will provide your up to date contact details as well as your business information to the potential customers using boothleads at '+ eid.EV_id__r.EV_Title__c+'.'+'<br/>'+''+'<br/>'+
          'If you have any questions please contact Booth Leads customer support.'+'<br/>'+''+'<br/>'+
          'Thank you!'+'<br/>'+
          'BoothLeads customer support'+'<br/>'+
         +'<a>'+ 'support@boothleads.com' +'</a>'+''+'<br/>'+
         'Phone: 1-(800)-492-1289'+''+'<br/>'+''+'<br/>'+
         'Please update your profile by clicking the below link'+'<br/>'+
          'https://boothleads.bleadtest.cs5.force.com/attendeeselfregistration?id='+eid.AS_id__r.id+'&'+'eid='+eid.EV_id__r.id+'<br/>'
          );                                                                                                                                                      
    emails.add(email); 
    eid.IsPrifileUpdate__c=true;                                                                          
    ASUpdate.add(eid);
    }
    Messaging.SendEmailResult[]  r = Messaging.sendEmail(emails);
   // Messaging.SendEmailResult[]  r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emails});
    system.debug('-----------------------------------------------------------'+r);
    boolean check=true;
    for(Messaging.SendEmailResult ms: r){
       check=check && ms.isSuccess();
        
        system.debug('1111111111111111'+ check );
        
    }
    if(check == true)
    {
    emailalert=true;
    update(ASUpdate);
    }
    eventselected=eventselected;
    getevents();
    
    }
    else
    {
     EventReqString = 'Please select atleast one attendee to send update notification';
              EventReqStringBool = TRUE;
    }
    return null;
    }   
    //------------------------------------------------------------------desiredTemplate----------------------
    public pagereference desiredTemplate()
    {
    limitofbadges=false;
       Event__c EVprinter=[select Event_Printer__c, Lable_First_Line__c,Lable_First_Line_Color__c,Lable_First_Line_Font__c,
                                   Lable_First_Line_Size__c,Lable_Secoend_Line__c,Lable_Secoend_Line_Color__c,
                                   Lable_Secoend_Line_Font__c,Lable_Secoend_Line_Size__c,Lable_Third_Line__c,
                                   Lable_Third_Line_Color__c,Lable_Third_Line_Font__c, Lable_Third_Line_Size__c
                                   from Event__c where id =:eventselected];
       system.debug('==================selected printer======='+EVprinter.Event_Printer__c);
       string label=EVprinter.Event_Printer__c;
       
       if(label == 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges')
       {
         selfieldvalue=EVprinter.Lable_First_Line__c;
        selectedcolor=EVprinter.Lable_First_Line_Color__c;
        selectedsize=EVprinter.Lable_First_Line_Size__c;
        selectedfaceFir=EVprinter.Lable_First_Line_Font__c;
        selLvalue=EVprinter.Lable_Secoend_Line__c;
        selectedcolorS=EVprinter.Lable_Secoend_Line_Color__c;
        selectedsizeS=EVprinter.Lable_Secoend_Line_Size__c;
        selectedfaceSec=EVprinter.Lable_Secoend_Line_Font__c;
        selTvalue=EVprinter.Lable_Third_Line__c;
        selectedcolorT=EVprinter.Lable_Third_Line_Color__c;
        selectedsizeT=EVprinter.Lable_Third_Line_Size__c;
        selectedfaceThr=EVprinter.Lable_Third_Line_Font__c;  
        font=new LIST<selectoption>();
        font.add(new selectoption('select','select'));        
        font.add(new selectoption('32pt','32pt'));
        font.add(new selectoption('30pt','30pt'));
        font.add(new selectoption('24pt','24pt'));
        font.add(new selectoption('18pt','18pt'));
        fieldnames=new LIST<selectoption>();
        fieldnames.add(new selectoption('select','select'));        
        fieldnames.add(new selectoption('AS_LastName__c','LastName'));
        fieldnames.add(new selectoption('AS_FirstName__c','FirstName'));
        fieldnames.add(new selectoption('AS_Title__c','Designation'));
        fieldnames.add(new selectoption('AS_Company__c','Company'));
        totalselectlist=false;
        custombadge1=false;        
        print=true;
       }else if(label != 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges'){
       
        selfieldvalue='AS_FirstName__c';
        selectedcolor='Black';
        selectedsize='32pt';
        selectedfaceFir='Times New Roman';
        selLvalue='AS_LastName__c';
        selectedcolorS='Black';
        selectedsizeS='24pt';
        selectedfaceSec='Times New Roman';
        selTvalue='AS_Company__c';
        selectedcolorT='Black';
        selectedsizeT='18pt';
        selectedfaceThr='Times New Roman';  
       totalselectlist=false;
        custombadge1=false;        
        print=true;
       
       }
       else if(label == 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges')
       {
       system.debug('========================='+EVprinter.Lable_First_Line__c);
         print=true;
       totalselectlist=true;
       custombadge1=false;
        selfieldvalue=EVprinter.Lable_First_Line__c;
        system.debug('========================='+selfieldvalue);
        selectedcolor=EVprinter.Lable_First_Line_Color__c;
        selectedsize=EVprinter.Lable_First_Line_Size__c;
        selectedfaceFir=EVprinter.Lable_First_Line_Font__c;
        selLvalue=EVprinter.Lable_Secoend_Line__c;
        selectedcolorS=EVprinter.Lable_Secoend_Line_Color__c;
        selectedsizeS=EVprinter.Lable_Secoend_Line_Size__c;
        selectedfaceSec=EVprinter.Lable_Secoend_Line_Font__c;
       font=new LIST<selectoption>();
        font.add(new selectoption('select','select'));        
        font.add(new selectoption('20pt','20pt'));
        font.add(new selectoption('18pt','18pt'));
        font.add(new selectoption('15pt','15pt'));
        font.add(new selectoption('10pt','10pt'));
        fieldnames=new LIST<selectoption>();  
        fieldnames.add(new selectoption('select','select'));       
        fieldnames.add(new selectoption('AS_FirstName__c,AS_LastName__c','FirstName LastName'));        
        fieldnames.add(new selectoption('AS_Title__c','Designation'));
        fieldnames.add(new selectoption('AS_Company__c','Company'));
       }
       else if(label != 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges'){
        selfieldvalue='AS_FirstName__c,AS_LastName__c';
        selectedcolor='Black';
        selectedsize='20pt';
        selectedfaceFir='Times New Roman';
        selLvalue='AS_Company__c';
        selectedcolorS='Black';
        selectedsizeS='15pt';
        selectedfaceSec='Times New Roman';
       totalselectlist=false;
        custombadge1=false;        
        print=true;
       }
       else if(selectedvalues == 'Dymo Label(30856,Single Label)')
       {
       totalselectlist=false;
       custombadge1=false;
       print=true;
       }
       else if(selectedvalues == 'Zebra Label')
       {
       totalselectlist=false;
       custombadge1=false;
       print=true;
       }
       else if(selectedvalues == 'select')
       {
       totalselectlist=false;
       custombadge1=false;
       print=false;
       }
      return null; 
    }
    //-------------------------------------------------Search----------------------------
    public pagereference search(){
    String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
if(browserType != null && browserType.contains('MSIE')){
Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
}
    limitofbadges=false;
    emailalert=false;
    EventReqStringBool=false;
    TotalAttendees = new LIST<LIST<EventWrapper>>();
    integer recCount=0;
    eventlist = new LIst<Event_Attendee_Mapping__c>();
    string ff = serarchstringvalue+'%';
    eventlist= [select AS_id__r.AS_LastName__c,AS_id__r.AS_FirstName__c,AS_id__r.AS_ImageUrl__c,
                      AS_id__r.AS_Company__c,EA_AttendeeBarcode__c,AS_id__r.AS_CellPhone__c,
                      EA_isBadgePrinted__c,AS_id__r.AS_Email__c,IsPrifileUpdate__c,CreatedDate
                      ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where EV_id__r.id =: eventSelected and (AS_id__r.AS_FirstName__c like :ff+'%' OR AS_id__r.AS_LastName__c like :ff+'%' OR  AS_id__r.AS_Company__c like :ff+'%' OR AS_id__r.AS_Email__c like :ff+'%' OR AS_id__r.AS_CellPhone__c   like :'%'+ff+'%') order by AS_id__r.AS_LastName__c];                                                                        
     ew=new List<eventwrapper>();
    for(Event_Attendee_Mapping__c s:eventlist)
  {
           crd=s.CreatedDate;
         
         crd = getLocalDateTime(crd);
      s.AS_id__r.AS_LastName__c = escapeSpecialCharacters(s.AS_id__r.AS_LastName__c);
      s.AS_id__r.AS_FirstName__c = escapeSpecialCharacters(s.AS_id__r.AS_FirstName__c);
      s.AS_id__r.AS_CellPhone__c = escapeSpecialCharacters(s.AS_id__r.AS_CellPhone__c);
      s.AS_id__r.AS_Email__c = escapeSpecialCharacters(s.AS_id__r.AS_Email__c);
      s.AS_id__r.AS_Company__c = escapeSpecialCharacters(s.AS_id__r.AS_Company__c);
       recCount++;
       ew.add(new eventwrapper(s));
       if(recCount==1000){
       TotalAttendees.add(ew);
       ew = new LIST<EventWrapper>();
       recCount=0;
       }
      
    }
    if(recCount !=0)
    TotalAttendees.add(ew);
    return null;
    } 
    
  public pagereference status()
  {  
  limitofbadges=false;
   system.debug('parameter'+eventname1);   
    string[] ss1=eventname1.split(',');
    
    system.debug('============='+ss1[1] +'  '+ss1[0]);
    string state1=ss1[1];
    checkedbadge1= new List<Event_Attendee_Mapping__c>();
    List<Event_Attendee_Mapping__c> changed1=new List<Event_Attendee_Mapping__c>{};
    checkedbadge1=[select id, EA_isBadgePrinted__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:ss1[0]];
    for(Event_Attendee_Mapping__c dd1:checkedbadge1)
    {
    if(state1 == 'Not Printed'){
    dd1.EA_isBadgePrinted__c=false;
    }else{
    dd1.EA_isBadgePrinted__c=true;
    }
    changed1.add(dd1);
    }
    update changed1;
    getEvents();
   return null;
  }
  
  public pagereference prostatus()
  {  
   system.debug('parameter1'+eventname1);   
    string[] ss=eventname1.split(',');
    
    system.debug('============='+ss[1] +'  '+ss[0]);
    string state=ss[1];
    checkedbadge2= new List<Event_Attendee_Mapping__c>();
    List<Event_Attendee_Mapping__c> changed2=new List<Event_Attendee_Mapping__c>{};
    checkedbadge2=[select id,IsPrifileUpdate__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:ss[0]];
    for(Event_Attendee_Mapping__c dd2:checkedbadge2)
    {
    if(state == 'Not Sent'){
    dd2.IsPrifileUpdate__c=false;
    }else{
    dd2.IsPrifileUpdate__c=true;
    }
    changed2.add(dd2);
    }
    update changed2;
    getEvents();
   return null;
  }  
  
  
  public PageReference pristatus() {
      system.debug('parameter'+eventname1);   
    string[] ss1=eventname1.split(',');
    
   
    string state1=ss1[1];
    checkedbadge1= new List<Event_Attendee_Mapping__c>();
    List<Event_Attendee_Mapping__c> changed1=new List<Event_Attendee_Mapping__c>{};
    checkedbadge1=[select id, EA_isBadgePrinted__c ,Boothleads_Profile__c  from Event_Attendee_Mapping__c where id =:ss1[0]];
    for(Event_Attendee_Mapping__c dd1:checkedbadge1)
    {
    if(state1 == 'Not Printed'){
    dd1.EA_isBadgePrinted__c=false;
    }else{
    dd1.EA_isBadgePrinted__c=true;
    }
    changed1.add(dd1);
    }
    update changed1;
    getEvents();
   return null;
    }    
  
//----------------------------------------------------Test Methods------------------
 
}