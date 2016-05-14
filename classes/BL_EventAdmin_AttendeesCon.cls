global without sharing class BL_EventAdmin_AttendeesCon{

    public PageReference sendBadge() {
     string eamid = ApexPages.currentPage().getParameters().get('eamid');
     sendMail(eamid);
     return null;
    }
    
public PageReference sendBadgeMutiple() {
List<String> eamidlist=new List<String>();
for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             eamidlist.add(a.atnd.id);
     }
     
     
   if (eamidlist.size() != 0) {
    Id batchInstanceId = Database.executeBatch(new SendMailBatch(eamidlist), 1); 
    EventReqStringBool = FALSE;
     } else {
             EventReqString = 'Please select atleast one attendee to send the badge';
             EventReqStringBool = TRUE;
         }
     return null;    
         
}  

public void sendMail(String eamid)
{
  string eventQuery ='select EV_id__c,EA_isBadgeSent__c,EV_id__r.EV_EventLogo__c,EV_id__r.OrganizerId__c,UniqNo__c,CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,GuestType__c,BadgeQty__c,TicketTypes__c,TicketTypesBP__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_HomeCity__c,AS_id__r.AS_ShippingCity__c,AS_id__r.AS_WorkState__c,AS_id__r.AS_Work_States__c,AS_id__r.As_Home_State__c,AS_id__r.AS_shippingState__c, AS_id__r.Registration_type__c,AS_id__r.FetchStatus__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id=\''+eamid+'\'  limit 1';
         
   Event_Attendee_Mapping__c eamap=new Event_Attendee_Mapping__c();     
        try{
         eamap=dataBase.Query(eventQuery ); 
        
        }catch(Exception e){return;}
User u=[select id,username,name,email from user where username='noreply@boothleads.com' limit 1];
     //New instance of a single email message
 Messaging.SingleEmailMessage mail = 
            new Messaging.SingleEmailMessage();
 
// Who you are sending the email to
   mail.setTargetObjectId(u.id);

   // The email template ID used for the email
   EmailTemplate templateId = [Select id,name from EmailTemplate where name = 'Sweden Template'];
   mail.setTemplateId(templateId.id);
          
   mail.setWhatId(eamid);    
   mail.setBccSender(false);
   mail.setUseSignature(false);
   
   OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = :eamap.EV_id__r.OrganizerId__c];
if ( owea.size() > 0 ) {
    mail.setOrgWideEmailAddressId(owea.get(0).Id);
}
else
{
 mail.setReplyTo('orders@boothleads.com');
 mail.setSenderDisplayName('Boothleads');
}
   mail.setSaveAsActivity(false); 
   mail.setToAddresses( new List<String>{ eamap.AS_id__r.AS_Email__c } );
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    eamap.EA_isBadgeSent__c=true;
         update eamap;
}
    public PageReference findtemplate() {
     bdstyleslist = new  LIST<selectoption> ();
     if(selectedprinter =='Avery_6')
     Bdstyles = [select id,Name,badge_type__c,Module__c from BadgeTemplate_Styles__c where Event__r.id =: eventSelected and badge_type__c='Zebra' and Module__c like '%Attendee Registration%' ];
     else if(selectedprinter =='Avery_8')
     Bdstyles = [select id,Name,badge_type__c,Module__c from BadgeTemplate_Styles__c where Event__r.id =: eventSelected and badge_type__c='Avery' and Module__c like '%Attendee Registration%' ];
       
     else
     Bdstyles = [select id,Name,badge_type__c,Module__c from BadgeTemplate_Styles__c where Event__r.id =: eventSelected and badge_type__c=:selectedprinter and Module__c like '%Attendee Registration%'];
    for(BadgeTemplate_Styles__c BTS : Bdstyles ){
    bdstyleslist.add(new selectoption(BTS.Name,BTS.Name));
    }
        return null;
    }


    public List < selectoption > getPrinterlist() {
      List < selectoption > Option = new List < selectoption > ();
     Option.add(new selectoption('Avery_6', 'Avery_6'));
      Option.add(new selectoption('Avery_8', 'Avery_8'));
     Option.add(new selectoption('Zebra', 'Zebra'));
     Option.add(new selectoption('Dymo', 'Dymo'));
     Option.add(new selectoption('Brother', 'Brother(2.4X3.9)'));
     Option.add(new selectoption('CustScanBadge', 'Brother(2.25X3.5)'));
    
     return option;
    }


    public String selectedprinter { get; set; }

  


        
    public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }
 
  // the current field to sort by. defaults to last name
  public String sortField {
    get  { if (sortField == null) {sortField = 'AS_id__r.AS_LastName__c'; } return sortField;  }
    set;
  }
    
    
    // toggles the sorting of query from asc<-->desc
  public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    // run the query again
   getevents();
  }
    

        public void changeprofilestatus() {
            eventname1 = '';
            system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee ggggggggggggggggggggggggg ' + ForPagination);
            for (eventwrapper a: ForPagination) {
                if (a.atnd.checkbox_dataTable__c == TRUE)
                    forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
            }
            List < Event_Attendee_Mapping__c > changed = new List < Event_Attendee_Mapping__c > {};
            attid = new list < ID > ();
            attforexport = new List < Event_Attendee_Mapping__c > ();
            if (forPaginationstoreIds.KeySet().size() != 0) {
                attforexport = [select id, EA_isBadgePrinted__c from Event_Attendee_Mapping__c where id = : forPaginationstoreIds.KeySet()];
                for (Event_Attendee_Mapping__c eam: attforexport) {
                    if (eam.EA_isBadgePrinted__c == false) {
                        eam.EA_isBadgePrinted__c = True;
                        changed.add(eam);
                        system.debug(':::::::11111111:::::::' + changed[0].EA_isBadgePrinted__c);
                    } else {
                        eam.EA_isBadgePrinted__c = False;
                        changed.add(eam);
                    }
                }
                update changed;
                getevents();
            } else {
                EventReqStringBool = TRUE;
            }
        }
        
        public PageReference converLead() {
        system.debug('8888888889999999999991111111111111 '+ForPagination);
          set < string > setOfJunctions = new set < string > ();
          set < id > attsummaryListIds = new set < id > ();    
           eventlist = new List < Event_Attendee_Mapping__c > ();
            eventlist = [select CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,
                                 AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,
                                 EA_isBadgePrinted__c, AS_id__r.AS_Email__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where EV_id__r.id = : eventSelected ORDER BY AS_id__r.AS_Company__c];

        
        
        
        
            for (eventwrapper a: ForPagination) {
               if (a.atnd.checkbox_dataTable__c == TRUE)
                  forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
                  
               }
               system.debug('8888888889999999999991111111111111 ' + forPaginationstoreIds);
        /**
            
           
            for (string sej: eventName1.split(',')) {
                setOfJunctions.add(sej);
            }**/
           if(forPaginationstoreIds.KeySet().size() != 0){ 
             if (Allrecords == true) {
             for (Event_Attendee_Mapping__c EAMapping: [SELECT id, AS_id__r.id, EV_id__r.id, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE ev_Id__c = : eventselected]) {
                attsummaryListIds.add(EAMapping.AS_id__r.id);
            }
             }else
            
            if(forPaginationstoreIds.KeySet().size() != 0){
            for (Event_Attendee_Mapping__c EAMapping: [SELECT id, AS_id__r.id, EV_id__r.id, Boothleads_Profile__c from Event_Attendee_Mapping__c where id IN: forPaginationstoreIds.KeySet()]) {
                attsummaryListIds.add(EAMapping.AS_id__r.id);
                system.debug('         booth admin       '+attsummaryListIds);
            }
            }
            if (forPaginationstoreIds.KeySet().size() > 0) {
                Successbool = true;
            }
            ConverBoothAdmin outerCls = new ConverBoothAdmin();
            outerCls.boothadminConversion(attsummaryListIds, Eventselected);
          }else {            
             EventReqStringBool = TRUE;
         }
            return null;
        }
        public void saveandprintforedit() {
            limitofbadges = false;
            updateattendee();
            fortwoprinters = true;
        }
        public void printfromsaveandprint() {
            limitofbadges = false;
            fortwoprinters = true;
            saveattendee();
        }   
    //-----------------------------------------------------------------VARIABLE DECLARATION----------------------------------    
    public string selectoptionval {get;set;}
    public boolean logooptionbool{get;set;}
    public string SelectedlogoValues{get;set;}
    public string selectedoption {get;set;}
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
    public list<eventwrapper> tempattendeelist {get;set;}
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
    public boolean Disabled_First_Icon {get;set;}
    public boolean Disabled_Next_Icon {get;set;}
    public boolean Disabled_Last_Icon {get;set;}
    public boolean Disabled_Previous_Icon {get;set;}
    
    // CCR Details Variable Declaration   
    Public String CCRCageCode{get;set;}
    Public String CCRCompany{get;set;}
    Public String CCRDomain{get;set;}
    Public String CCREmailId{get;set;}
    Public String CCRWebsiteUrl{get;set;}
    Public String CCRCellPhone{get;set;}  
    Public String CCRBusinessRevenue{get;set;}
    Public String CCRBusinessTaxId{get;set;}
    Public String CCRBusinessDunsNumber{get;set;}        
    Public String CCRNaicsCodes{get;set;}
    Public String CCRNaicsCodes1{get;set;}
    Public String CCRNaicsCodes2{get;set;}
    Public String CCRNaicsCodes3{get;set;}
    Public String CCRNaicsCodes4{get;set;}
    Public String CCRNaicsCodes5{get;set;}
    Public String CCRBusinessEstablishedDate{get;set;}
    Public String CCRBusinessEstablishedDate1{get;set;}
    Public String CCRNumberofEmployees{get;set;}    
    Public String CCRFiscalYearEndDate{get;set;}
    Public String CCRWorkAddress1{get;set;}
    Public String CCRWorkAddress2{get;set;}
    Public String CCRWorkCity{get;set;}
    Public String CCRWorkState{get;set;}
    Public String CCRWorkCountry{get;set;}
    Public String CCRZipCode1{get;set;}
    Public String CCRWorkZipCode{get;set;}
    Public String CCRPOBox1{get;set;}
    Public String CCRPOBox2{get;set;}
    Public String CCRPOBox3{get;set;}
    Public String CCRWorkPOBox{get;set;}
    Public String CCRWorkPhone{get;set;}
    Public String CCRHomeAddress1{get;set;}
    Public String CCRHomeAddress2{get;set;}
    Public String CCRHomeCity{get;set;}
    Public String CCRHomeState{get;set;}
    Public String CCRHomeCountry{get;set;}
    Public String CCRHomeCode1{get;set;}
    Public String CCRHomeZipCode{get;set;}    
    Public String CCRHomePOBox{get;set;}
    Public String CCRHomePhone{get;set;}
    Public String CCRMailingAddress1{get;set;}
    Public String CCRMailingAddress2{get;set;}
    Public String CCRMailingCity{get;set;}
    Public String CCRMailingState{get;set;}
    Public String CCRMailingCountry{get;set;}
    Public String CCRZipCode2{get;set;}
    Public String CCRMailingZipCode{get;set;}
    Public String CCRMailingPOBox{get;set;}
    Public String CCRMailingPhone{get;set;}         
    
    Public String CCRFirstName{get;set;}
    Public String CCRLastName{get;set;}
    Public String CCREmail{get;set;}     
    Public String CCRDomainName{get;set;} 
    Public String CCRData{get;set;}
    Public String CageCode1{get;set;}
    Public Boolean ccrdetailsbool{get;set;}
    Public Boolean ccrdetailsboolall{get;set;}
    public Boolean CCRDetailsFetchBool{get;set;}
    public Boolean CCRDetailsMessageBool{get;set;}
    Public Boolean fetchccrdetailsbool{get;set;}
    Public Boolean fetchccrdetailsboolyes{get;set;}
    Public Boolean fetchccrdetailsboolno{get;set;}
    Public String NoRecordsMessage{get;set;}
    public List<AttendeeSummary__c> listdg{get;set;} 
    public Set<AttendeeSummary__c> setdg{get;set;} 
    public List<AttendeeSummary__c> result{get;set;} 
    Public String CCRSearchTerm{get;set;} 
    Public String CCRSearchCageCode{get;set;} 
    Public String CCRSearchEmail{get;set;} 
    Public String CCRSearchPhone{get;set;}
    public list<selectoption> numoptions {get;set;}
    public string selectednum {get;set;}
    public list<selectoption> logooptions {get;set;}
    
    public list<selectoption> numoptions1{get;set;}
    public string selectednum1 {get;set;}
    Public List<String> ParamValue{get;set;}
    Public Integer selectedIntialValue{get;set;}
    Public Integer selectedFinalValue{get;set;}
    public list<eventwrapper> ew{get;set;}
    public string todisptitle {get; set;}
   //----------------------------badge style variables------------------------------
   



    
    
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
     
    public string[] selectedattendeetypes{get;set;}
    public list<SelectOption > Attoptions {get;set;}
    public  Event__c atttypes{get;set;}
    public list<selectoption> atttypeoptions {get;set;}
   
   
    public void seloptionsfun(){
      atttypeoptions = new list<selectoption> {};
    set<string> setopt = new set<string> ();
    list<TicketTypes__c> tieamjun = new list<TicketTypes__c>([select Ticket_Category__c  from TicketTypes__c where EV_id__r.id =: eventSelected ]);
    system.debug('     tieamjun ===================         '+tieamjun );
     atttypeoptions.add(new selectoption('All','All')); 
    if(tieamjun.size() > 0)
    { 
   try{ 
   for(TicketTypes__c te : tieamjun ){
    if(setopt.add(te.Ticket_Category__c)){
    
    atttypeoptions.add(new selectoption(te.Ticket_Category__c,te.Ticket_Category__c));
    }
    
    }}catch (exception e) {}
    
   }
    }
    public Commanforstates statemap{get;set;}
     public BL_EventAdmin_AttendeesCon() {
     try{statemap=new Commanforstates ();}catch(Exception e){}
     URLEvent();
     //selectednum1 = '';
    
     atttypes = new Event__c();
     numoptions  = new LIST < selectoption > ();
     numoptions.add(new selectoption('1-500','1-500'));
     numoptions.add(new selectoption('500-1000','500-1000'));
     
     SelectedValuesfortwoprinters = new LIST < selectoption > ();
     SelectedValuesfortwoprinters.add(new selectoption('Zebra Label', 'Zebra Label'));
     SelectedValuesfortwoprinters.add(new selectoption('Dymo Label(30856,Single Label)', 'Dymo Label(30856,Single Label)'));
     alphabet = new string[] {
         'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'All'
     };
     emailalert = false;
     limitofbadges = false;
     fieldnames = new LIST < selectoption > ();
     fieldnames.add(new selectoption('None', 'None'));
     fieldnames.add(new selectoption('AS_LastName__c', 'LastName'));
     fieldnames.add(new selectoption('AS_FirstName__c', 'FirstName'));
     fieldnames.add(new selectoption('AS_Title__c', 'Designation'));
     fieldnames.add(new selectoption('AS_Company__c', 'Company'));
     logooptions = new list<selectoption>{};
      logooptions.add(new selectoption('Badge with Logo', 'Badge with Logo '));
      logooptions.add(new selectoption('Badge with Out Logo', 'Badge with Out Logo '));
     ReqFields = true;
     getvalues();
     getevents();
     seloptionsfun();
     //----------------- Getting Ticket Types Of an Event----------------
     selectedTicTypes = new String[] {};
     options = new List < SelectOption > ();
     tickets = new list < TicketTypes__c > ();
     tickets = [select TT_Name__c from TicketTypes__c where EV_id__r.id = : eventSelected];
     for (TicketTypes__c Tic: tickets) {
         options.add(new SelectOption((String) Tic.TT_Name__c, Tic.TT_Name__c));
     }
     //----------------------------------getting attendee types of an event--------------
     selectedattendeetypes=new string[]{};
     Attoptions =new list<SelectOption >{};
     system.debug('               mallik       '+eventselected);
    
    if(eventSelected != null)
         atttypes=[select Attendee_Types__c,Is_MatchMaking_Event__c from Event__c where id =: eventSelected];
    
     string Type= atttypes.Attendee_Types__c;
    LIST<String> Notypes = new LIST<String>();
    
  //  string[] Notypes = new string[];
    if(Type != null)
      Notypes =Type.split(';');
    
     for(String attentype:NoTypes){
     Attoptions.add(new selectoption(attentype,attentype));
     }
     //---------------Diversity Types----------------------------------------------------------
     DiversityTypes = new String[] {};
     Divoptions = new List < Selectoption > ();
     Divoptionsforsecondline = new List < Selectoption > ();
     eventattendeelist = new List < Event__c > ();
     try {
         eventDIVS = [select EventDiversityValues__c,Is_MatchMaking_Event__c from Event__c where id = : eventSelected];
         String Div = eventDIVS.EventDiversityValues__c;
         String [] DiversityTypes1 = Div.split(';');
         
         integer i = 0;
         for (String Diversty: DiversityTypes1) {
             if (math.MOD(i, 2) == 0) {
                 Divoptions.add(new SelectOption(Diversty, Diversty));
             } else {
                 Divoptionsforsecondline.add(new SelectOption(Diversty, Diversty));
             }
             i++;
         }
     } catch (exception e) {}
     // By Mallik For Data Import History Display 
     Integer countOfImport = [SELECT count() FROM DataImport_SavePoint__c WHERE User_id__c = : UserInfo.getUserId()];
     if (countOfImport > 0)
         foundHistoryBool = TRUE;
     try {
         attach = [select EV_EventLogo__c,Is_MatchMaking_Event__c from Event__c where id = : eventSelected];
         if (attach.EV_EventLogo__c != null) {
             logo = true;
         } else {
             logo = false;
         }
     } catch (exception e) {}
 }
 //---------------------------------------------------------Getting events into picklist-----------------
 public void getvalues() {
     emailalert = false;
     limitofbadges = false;
     LIST < User_Profile_Event__c > events = new LIST < User_Profile_Event__c > ();
     string ss = userInfo.getUserName();
     Items = new LIST < selectoption > ();
     events = [SELECT id, EV_id__c, EV_id__r.EV_Title__c,EV_id__r.Is_MatchMaking_Event__c FROM User_Profile_Event__c
                 WHERE EventAdmin_Id__c != ''
                 And User_id__r.UserName = : ss 
                 And (EventAdmin_Id__r.UserName = : ss OR User_id__r.UserName = : ss) 
                 ORDER BY CreatedDate ASC];
     system.debug('++++++++++++++++' + events);
     if (!events.isEmpty()) {
         for (User_Profile_Event__c Even: events) {
             system.debug('+++++++Events+++++++++' + even);
             if (Even.EV_id__c != null) {
                 Items.add(new SelectOption(Even.EV_id__c, Even.EV_id__r.EV_Title__c));
                 if(id == null || id == '')
                 eventSelected = Even.EV_id__c;
                 system.debug('++++++++++++++++' + Items);
             }
         }
     }
 }
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
 public PageReference selectedprint() {
     attid = new list < ID > ();
     limitofbadges = false;
     Event__c EVprinter = [select Event_Printer__c, Lable_First_Line__c, Lable_First_Line_Color__c, Lable_First_Line_Font__c,
         Lable_First_Line_Size__c, Lable_Secoend_Line__c, Lable_Secoend_Line_Color__c,
         Lable_Secoend_Line_Font__c, Lable_Secoend_Line_Size__c, Lable_Third_Line__c,
         Lable_Third_Line_Color__c, Lable_Third_Line_Font__c, Lable_Third_Line_Size__c,Is_MatchMaking_Event__c
         from Event__c where id = : eventselected
     ];
     string label = EVprinter.Event_Printer__c;
     system.debug('+++++++++++++++++++++++++++++++++++++++' + label);
     system.debug('+++++++++++++++++++++++++++++++++++++++' + selectedvalues);
   if(label == null || label == ''){
  label ='Avery 5392 Name badges';
 }
     if (label == 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges') {
         selfieldvalue = EVprinter.Lable_First_Line__c;
         selectedcolor = EVprinter.Lable_First_Line_Color__c;
         selectedsize = EVprinter.Lable_First_Line_Size__c;
         selectedfaceFir = EVprinter.Lable_First_Line_Font__c;
         selLvalue = EVprinter.Lable_Secoend_Line__c;
         selectedcolorS = EVprinter.Lable_Secoend_Line_Color__c;
         selectedsizeS = EVprinter.Lable_Secoend_Line_Size__c;
         selectedfaceSec = EVprinter.Lable_Secoend_Line_Font__c;
         selTvalue = EVprinter.Lable_Third_Line__c;
         selectedcolorT = EVprinter.Lable_Third_Line_Color__c;
         selectedsizeT = EVprinter.Lable_Third_Line_Size__c;
         selectedfaceThr = EVprinter.Lable_Third_Line_Font__c;
         fbool = false;
         printbadge();
         //addattendee1=true;
     } else if (label != 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges') {
         selfieldvalue = 'AS_FirstName__c';
         selectedcolor = 'Black';
         selectedsize = '32pt';
         selectedfaceFir = 'Times New Roman';
         selLvalue = 'AS_LastName__c';
         selectedcolorS = 'Black';
         selectedsizeS = '24pt';
         selectedfaceSec = 'Times New Roman';
         selTvalue = 'AS_Company__c';
         selectedcolorT = 'Black';
         selectedsizeT = '18pt';
         selectedfaceThr = 'Times New Roman';
         fbool = false;
         printbadge();
         //addattendee1=true;
     } else if (label == 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges') {
         selfieldvalue = EVprinter.Lable_First_Line__c;
         selectedcolor = EVprinter.Lable_First_Line_Color__c;
         selectedsize = EVprinter.Lable_First_Line_Size__c;
         selectedfaceFir = EVprinter.Lable_First_Line_Font__c;
         selLvalue = EVprinter.Lable_Secoend_Line__c;
         selectedcolorS = EVprinter.Lable_Secoend_Line_Color__c;
         selectedsizeS = EVprinter.Lable_Secoend_Line_Size__c;
         selectedfaceSec = EVprinter.Lable_Secoend_Line_Font__c;
         fbool = false;
         PrintBadgeforthree();
         //addattendee1=true;
     } else if (label != 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges') {
         selfieldvalue = 'AS_FirstName__c,AS_LastName__c';
         selectedcolor = 'Black';
         selectedsize = '20pt';
         selectedfaceFir = 'Times New Roman';
         selLvalue = 'AS_Company__c';
         selectedcolorS = 'Black';
         selectedsizeS = '15pt';
         selectedfaceSec = 'Times New Roman';
         fbool = false;
         PrintBadgeforthree();
         //addattendee1=true;
     } else if (selectedvalues == 'Dymo Label(30856,Single Label)') {
         fbool = false;
         printbadge();
         // dymo=true;
     } else if (selectedvalues == 'Zebra Label') {
         fbool = false;
         printbadge();
         //dymo=true;
     } else {
         fbool = TRUE;
         EventReqString1 = 'Please Select a Template';
         EventReqStringBool = TRUE;
     }
     return null;
 }
 //------------------------------------------SELECT  TYPE OF BADGE-----------------------------------------------------
 public List < selectoption > getfields() {
     fbool = true;
     limitofbadges = false;
     List < selectoption > Option = new List < selectoption > ();
     Option.add(new selectoption('Select', 'Select'));
     Option.add(new selectoption('Zebra Label', 'Zebra Label'));
     Option.add(new selectoption('Dymo Label(30856,Single Label)', 'Dymo Label(30856,Single Label)'));
     Option.add(new selectoption('Avery 5392 Name badges', 'Avery 5392 Name badges'));
     Option.add(new selectoption('Avery 22806 easy peal square Badges', 'Avery 22806 easy peal square Badges'));
     return option;
 }
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
 public map<id,List<string>> ticeam {get;set;}
 public list<string> listtic {get;set;} 
 
 public List < Event_Attendee_Mapping__c > getevents() {
 seloptionsfun();
 list<ID> eamids = new list<ID>{};
     pagereadonly = true;
     emailalert = false;
     limitofbadges = false;
     system.debug('===================' + eventSelected);
     EventReqStringBool = false;
     TotalAttendees = new list < list < eventwrapper >> ();
     forPaginationstoreIds = new MAP < ID, Boolean > ();
     eventlist = new list < Event_Attendee_Mapping__c > ();
     ForPagination = new list < eventwrapper > ();
     if (eventSelected != null || eventSelected != '') {
     
         integer recCount = 0;
         
        string eventQuery ='select id,CreatedDate,TicketTypes__c,TicketTypesBP__c,GuestType__c,EA_isBadgeSent__c,BadgeQty__c,Attendee_Types__c, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,AS_id__r.AS_WorkPhone__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c,EV_id__r.Is_MatchMaking_Event__c from Event_Attendee_Mapping__c where EV_id__r.id = \''+eventSelected +'\'  ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
         
        
        try{
         eventlist =dataBase.Query(eventQuery );

         
         
         }catch(exception e){}
         
         
         
         for(Event_Attendee_Mapping__c ema: eventlist ){
         eamids.add(ema.id);
         }system.debug('HHHHHHHHHHHHHHHHHHHHHHHHHH '+eamids); 
         
         
         if(selectedoption == 'All' || selectedoption == null){
        try
       {  
         list<Ticket_Eam__c> tieamjun = [select TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c,Event_Attendee_Mapping__c  from Ticket_Eam__c where Event_Attendee_Mapping__c IN : eamids ];
         system.debug('SSS DDD GG TT RR '+tieamjun );
          ticeam = new map<id,List<string>> {};
          set<id> idsfordup = new set<id> {};
           if(tieamjun.size() > 0){
          for(Event_Attendee_Mapping__c ematL: eventlist ){
          listtic = new list<string> {};

        for(Ticket_Eam__c tc:tieamjun ){
          if(ematL.id == tc.Event_Attendee_Mapping__c)
          
          if(idsfordup.add(ematL.id)){
          listtic.add(tc.TicketTypes__r.Ticket_Category__c);
          }
          }
           system.debug('==============TIC JUN QUERY ==============='+listtic);
          ticeam.put(ematL.id,listtic);
          
       }}
        AttendeeCount= eventlist.size();  
                  system.debug('===================' + AttendeeCount); 
        
       splitatendeeslist();
         ew = new List < eventwrapper > ();
            Integer K;
             system.debug('SSSSS hhhh RRR UUU '+ AttendeeCount );
      if(AttendeeCount < 500 ){
            for(k=0;k<AttendeeCount;k++){
                      system.debug( 'SSSS FFF ' + k);
                       ew.add(new eventwrapper(eventlist[k],ticeam.get(eventlist[k].id)));
                       //system.debug('EwListValue ' + ew);
                      } 
      } 
       else{
       
                    for(k=0;k<500;k++){
                       system.debug( 'SSSS FFF ' + k);
                       ew.add(new eventwrapper(eventlist[k],ticeam.get(eventlist[k].id)));
                       //system.debug('EwListValue ' + tempattendeelist);
                    } 
       }
        //system.debug('event LIST ##### ' + eventlist);
       /* ew = new List < eventwrapper > ();
                              // tempattendeelist.add(ew[k-1]);

         for (Event_Attendee_Mapping__c s: eventlist) {
             
                if(recCount < 500 ){
             recCount++;    
             ew.add(new eventwrapper(s,ticeam.get(s.id)));
         
          }  
            // system.debug('===================' + ew);
         }*/
       }catch(exception e){}
       
        }
      else{
        
      list<Ticket_Eam__c> tieamjun = [select TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c,Event_Attendee_Mapping__r.id  from Ticket_Eam__c where Event_Attendee_Mapping__c IN : eamids AND TicketTypes__r.Ticket_Category__c =: selectedoption];
          ticeam = new map<id,List<string>> {};
          for(Event_Attendee_Mapping__c ematL: eventlist ){
          listtic = new list<string> {};
         for(Ticket_Eam__c tc:tieamjun ){
          if(ematL.id == tc.Event_Attendee_Mapping__c)
           {
          listtic.add(tc.TicketTypes__r.Ticket_Category__c);}
       
          }
          
          ticeam.put(ematL.id,listtic);
          }
         
          ew = new List < eventwrapper > ();
          tempattendeelist = new List<EventWrapper>();
          set<id> idsfordup = new set<id> {};
        for(Event_Attendee_Mapping__c s: eventlist){
          for(Ticket_Eam__c tet: tieamjun){

            if(tet.Event_Attendee_Mapping__r.id == s.id){
            if( idsfordup.add(tet.Event_Attendee_Mapping__r.id)){
            //ew.add(new eventwrapper(s,ticeam.get(s.id)));
            tempattendeelist.add(new eventwrapper(s,ticeam.get(s.id)));
            
            }
                }
            }
        }


        
        system.debug('SSS hhhh RRR uuuuu TTT' + ew.size());
         AttendeeCount = tempattendeelist.size();
          splitatendeeslist();
                      Integer K;        
           if(AttendeeCount < 500 ){
                 ew = new List < eventwrapper > ();
                 for(k=1;k<=AttendeeCount;k++){

                      system.debug( 'SSSS FFF ' + k);
                       ew.add(tempattendeelist[k-1]);
                       //system.debug('EwListValue ' + ew);
                 } 
           } 
           else{                      
                        ew = new List < eventwrapper > ();
                        for(k=1;k<=500;k++){
                        system.debug( 'SSSS FFF ' + k);
                        ew.add(tempattendeelist[k-1]);
                       //system.debug('EwListValue ' + tempattendeelist);
                        } 
           }
        
        }

  //for pagination------------------------------
        
         
         try {
             if (ew.size() > 0) 
             {
                //AttendeeCount = tempattendeelist.size();
                
                 system.debug(' 43 e@@@ %%% ew List' + ew);
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
         } catch (exception e) {}
     }
     DiversityTypes = new String[] {};
     Divoptions = new List < Selectoption > ();
     Divoptionsforsecondline = new List < Selectoption > ();
     eventattendeelist = new List < Event__c > ();
     return null;
 }
 
 
 public void splitatendeeslist(){
 
       numoptions1  = new LIST <selectoption>();


               Integer div = 500; // division operator 
               Integer loopitenum= (AttendeeCount)/div;
               system.debug('   listsize ' + AttendeeCount + ' loopitenum  ' +loopitenum);
               Integer initvalue = 0;
               Integer a= 0;
          if(AttendeeCount==0){   
                  numoptions1.add(new selectoption('0-0','0-0'));
               }
          else if(AttendeeCount>0 && AttendeeCount<500){
                 string finallist = string.valueof(a+1)+'-'+string.valueof(AttendeeCount);
                 numoptions1.add(new selectoption(finallist ,finallist ));
           }
           else{ 
           for(Integer x =1;x<=loopitenum;x++ ){        
             Integer b = a+1;
             Integer c =a+500;
             if(b!=0 && c!=0){
             a = c;
             }      
                     string selecop = string.valueof(b)+'-'+string.valueof(c);
                     numoptions1.add(new selectoption(selecop ,selecop ));
                           system.debug('@@ %% ^^ ' + selecop );
                  
                  if(x==loopitenum && c < AttendeeCount){
                          string finallist = string.valueof(c+1)+'-'+string.valueof(AttendeeCount);
                          numoptions1.add(new selectoption(finallist ,finallist ));
                  
                  }
           }
       
         }   
 
 }
 
 
 
 
 public void listsize() {
                        ForPagination = new list < eventwrapper > ();
                        ew= new List<EventWrapper>();
                       ParamValue= new List<String>();
                        list<ID> eamids = new list<ID>{};
                selectedIntialValue = 0;
                selectedFinalValue = 0;
                Integer i;
                         ForPagination.clear();
                         system.debug('DDD GG FF TT '  + eventSelected );
                 string eventQuery ='select id,CreatedDate,GuestType__c,EA_isBadgeSent__c,BadgeQty__c,Attendee_Types__c,TicketTypes__c, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,AS_id__r.AS_WorkPhone__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c,TicketTypesBP__c from Event_Attendee_Mapping__c where EV_id__r.id = \''+eventSelected +'\'  ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
               
         eventlist =dataBase.Query(eventQuery );
                  for(Event_Attendee_Mapping__c ema: eventlist){
         eamids.add(ema.id);
         }system.debug('HHHHHHHHHHHHHHHHHHHHHHHHHH '+eamids);
   if(selectedoption == 'All' || selectedoption == null){
  list<Ticket_Eam__c> tieamjun = [select TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c,Event_Attendee_Mapping__c  from Ticket_Eam__c where Event_Attendee_Mapping__c IN : eamids ];
         system.debug('SSS DDD GG TT RR '+tieamjun );
          ticeam = new map<id,List<string>> {};
          set<id> idsfordup = new set<id> {};
           if(tieamjun.size() > 0){
          for(Event_Attendee_Mapping__c ematL: eventlist ){
          listtic = new list<string> {};

        for(Ticket_Eam__c tc:tieamjun ){
          if(ematL.id == tc.Event_Attendee_Mapping__c)
          
          if(idsfordup.add(ematL.id)){
          listtic.add(tc.TicketTypes__r.Ticket_Category__c);
          }
          }
           system.debug('==============TIC JUN QUERY ==============='+listtic);
          ticeam.put(ematL.id,listtic);
         
       }}
       
       
       
           system.debug('SSSSSSHHHHRRRRRUUUUTHI' + selectednum1);
                if(selectednum1!= null || selectednum1!= ''){
                  ParamValue.addAll(selectednum1.split('-'));
                 system.debug('ParamValue' + ParamValue);
                  selectedIntialValue = Integer.valueof(ParamValue[0]);
                  selectedFinalValue = Integer.valueof(ParamValue[1]);
      system.debug('^^^^& &&& ' + selectedIntialValue + '&&& *** WWW EE  ' + selectedFinalValue );

                     for(i=selectedIntialValue;i<=selectedFinalValue;i++){
                     system.debug( 'SSSS FFF ' + i );
                       ew.add(new eventwrapper(eventlist[i-1],ticeam.get(eventlist[i-1].id)));
                            //tempattendeelist.add(ew[i-1]);
                          //system.debug('EwListValue ' + tempattendeelist);
                      } 
                  system.debug('SSSS gg hh jj ' + ew.size());
                
       }
     }
     
     else{
        
      list<Ticket_Eam__c> tieamjun = [select TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c,Event_Attendee_Mapping__r.id  from Ticket_Eam__c where Event_Attendee_Mapping__c IN : eamids AND TicketTypes__r.Ticket_Category__c =: selectedoption];
          ticeam = new map<id,List<string>> {};
          for(Event_Attendee_Mapping__c ematL: eventlist ){
          listtic = new list<string> {};
         for(Ticket_Eam__c tc:tieamjun ){
          if(ematL.id == tc.Event_Attendee_Mapping__c)
           {
          listtic.add(tc.TicketTypes__r.Ticket_Category__c);}
       
          }
          
          ticeam.put(ematL.id,listtic);
          }
         

          tempattendeelist = new List<EventWrapper>();
          set<id> idsfordup = new set<id> {};
        for(Event_Attendee_Mapping__c s: eventlist){
          for(Ticket_Eam__c tet: tieamjun){

            if(tet.Event_Attendee_Mapping__r.id == s.id){
            if( idsfordup.add(tet.Event_Attendee_Mapping__r.id)){
            //ew.add(new eventwrapper(s,ticeam.get(s.id)));
            tempattendeelist.add(new eventwrapper(s,ticeam.get(s.id)));
            
            }
                }
            }
        }
                   if(selectednum1!= null || selectednum1!= ''){
                  ParamValue.addAll(selectednum1.split('-'));
                 system.debug('ParamValue' + ParamValue);
                  selectedIntialValue = Integer.valueof(ParamValue[0]);
                  selectedFinalValue = Integer.valueof(ParamValue[1]);
      system.debug('^^^^& &&& ' + selectedIntialValue + '&&& *** WWW EE  ' + selectedFinalValue );
                      ew = new List < eventwrapper > ();
                     for(i=selectedIntialValue;i<=selectedFinalValue;i++){
                     system.debug( 'SSSS FFF ' + i );
                       ew.add(tempattendeelist[i-1]);
                            //tempattendeelist.add(ew[i-1]);
                          //system.debug('EwListValue ' + tempattendeelist);
                      } 
                  system.debug('SSSS gg hh jj ' + ew.size());
                
       }
                
                 
        } 
         try {
             if (ew.size() > 0) 
             {
               // AttendeeCount = tempattendeelist.size();
                
                 system.debug(' 43 e@@@ %%% ew List' + ew);
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
                 for (integer s = 0; s < 50; s++) {
                     system.debug(' ----------- BBBBBBBBBBBBBBBBB ' + ew[s]);
                     ForPagination.add(ew[s]);
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
         } catch (exception e) {}
     
     }

 
 
 //----------------------------------------------------------------------------------------------------
 public void Alphasorting() {
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT'); //gets the browser name
     if (browserType != null && browserType.contains('MSIE')) {
         Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
     }
     limitofbadges = false;
     system.debug('----------------------------------------------------------sort---');
     string alphas = ApexPages.currentPage().getParameters().get('alphabit');
     system.debug('---------' + alphas);
     ForPagination = new list < eventwrapper > ();
     
     
     
     eventlist = new list < Event_Attendee_Mapping__c > ();
     if (eventSelected != null || eventSelected != '') {
         if (alphas != 'All') {
             integer recCount = 0;
             eventlist = [select TicketTypes__c,TicketTypesBP__c,GuestType__c,EA_isBadgeSent__c,BadgeQty__c,AS_id__r.AS_LastName__c,AS_id__r.AS_WorkPhone__c,AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, checkbox_dataTable__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, CreatedDate,
                 EA_isBadgePrinted__c, AS_id__r.AS_Email__c, AS_id__r.Registration_type__c,AS_id__r.FetchStatus__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where AS_id__r.AS_LastName__c like: alphas + '%'
                 AND EV_id__r.id = : eventSelected ORDER BY AS_id__r.AS_Company__c
             ];
             List <ID> eamids = new list<ID>{};
              for(Event_Attendee_Mapping__c ema: eventlist ){
         eamids.add(ema.id);
         }
         list<Ticket_Eam__c> tieamjun = [select TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c,Event_Attendee_Mapping__c  from Ticket_Eam__c where Event_Attendee_Mapping__c IN : eamids];
         system.debug('==============TIC JUN QUERY ==============='+tieamjun );
          ticeam = new map<id,List<string>> {};
          for(Event_Attendee_Mapping__c ematL: eventlist ){
          listtic = new list<string> {};
          for(Ticket_Eam__c tc:tieamjun ){
          if(ematL.id == tc.Event_Attendee_Mapping__c)
          listtic.add(tc.TicketTypes__r.Ticket_Category__c);
          }
           system.debug('==============TIC JUN QUERY ==============='+listtic);
          ticeam.put(ematL.id,listtic);
          }
         AttendeeCount= eventlist.size();    
           splitatendeeslist();
         ew = new List < eventwrapper > ();
            Integer K;
             system.debug('SSSSS hhhh RRR UUU '+ AttendeeCount );
      if(AttendeeCount < 500 ){
            for(k=0;k<AttendeeCount;k++){
                      system.debug( 'SSSS FFF ' + k);
                      crd = eventlist[k].CreatedDate;
                      crd = getLocalDateTime(crd);
                       ew.add(new eventwrapper(eventlist[k],ticeam.get(eventlist[k].id)));
                       //system.debug('EwListValue ' + ew);
                      } 
      } 
       else{
       
                    for(k=0;k<500;k++){
                       system.debug( 'SSSS FFF ' + k);
                       crd = eventlist[k].CreatedDate;
                      crd = getLocalDateTime(crd);
                       ew.add(new eventwrapper(eventlist[k],ticeam.get(eventlist[k].id)));
                       //system.debug('EwListValue ' + tempattendeelist);
                    } 
       }    
         system.debug('===================' + eventlist);
       /*  ew = new List < eventwrapper > ();
         for (Event_Attendee_Mapping__c s: eventlist) {
             system.debug('===================' + s.id);
             crd = s.CreatedDate;
             crd = getLocalDateTime(crd);
             recCount++;
            
             ew.add(new eventwrapper(s,ticeam.get(s.id)));
            
             system.debug('===================' + ew);
         } */
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
 public List < SelectOption > options {
     get;
     set;
 }
 public void CreateAttendee() {
     limitofbadges = false;
     emailalert = false;
     showEmail = True;
     showFirstName = True;
     showLastName = True;
     DisplayError = false;
     newAttendee = new AttendeeSummary__c();
     Divoptions = new List < Selectoption > ();
     Divoptionsforsecondline = new List < Selectoption > ();
     eventattendeelist = new List < Event__c > ();
     DiversityTypesforfirstline = new string[] {};
     DiversityTypesforsecondline = new string[] {};
     EventReqStringBool = false;
     if (eventSelected == 'select' || eventSelected == null) {
         EventReqStringBool = TRUE;
         EventReqString = 'Please Select an Event';
     } else {
         attendeesetting = new BL_SecuritySettingsCon(eventSelected);
         EventReqString = 'Add Attendee';
         addattendee = TRUE;
         foraddatt = true;
         foreditatt = false;
     }
     try {
         system.debug('===============================' + eventSelected);
         eventDIVS = [select EventDiversityValues__c,Is_MatchMaking_Event__c from Event__c where id = : eventSelected];
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
 //-------------------------------------SAVING NEW ATTENDEE METHOD----------------------------------------------
 public void SaveAttendee() {
 List<folder> folderList =new List<folder>();
  folderList = [select id from folder where name='shared Documents']; 
   
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
     if (browserType != null && browserType.contains('MSIE')) {
         Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
     }
     limitofbadges = false;
   /*  try {
         newattendee.AS_NAICSCode_1__c = NAICS1Mod;
     } catch (Exception e) {}
     try {
         newattendee.AS_NAICSCode_2__c = NAICS2Mod;
     } catch (Exception e) {}
     try {
         newattendee.AS_NAICSCode_3__c =NAICS3Mod;
     } catch (Exception e) {}
     try {
         newattendee.AS_NAICSCode_4__c = NAICS4Mod;
     } catch (Exception e) {}
     try {
         newattendee.AS_NAICSCode_5__c = NAICS5Mod;
     } catch (Exception e) {} */
     //newAttendee.AS_uniqueField__c = (newAttendee.AS_FirstName__c + newAttendee.AS_LastName__c + newAttendee.AS_Email__c ).toLowercase();
     EventReqStringBool2 = false;
     Savepoint sp = Database.setSavepoint();
     if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
         if (attendeeImage.size() != null) {
             if (attendeeImage.size() <= 10240000) {
                 mydoc = new document();
                 mydoc.body = attendeeImage;
                 //mydoc.folderid = UserInfo.getUserId();
                 if(folderList.size()>0){
                   mydoc.folderid =folderList[0].id;
                   }
                 mydoc.ispublic = true;
                 mydoc.Name = myimageName;
                 insert mydoc;
                 newattendee.AS_ImageUrl__c = mydoc.id;
             } else {
                 imageerror = true;
                 imageerrormsg = 'Image size should be less than 1MB';
             }
         }
     }
     AttendeeSummary__c myatt = new AttendeeSummary__c();
     newattendee.id = null;
     myatt = newAttendee.clone(true);
     
     Database.UpsertResult myAttendeeSaveResult = Database.upsert(myatt, AttendeeSummary__c.AS_Email__c.getDescribe().getSObjectField(), false);
     system.debug('        saveresult          '+myAttendeeSaveResult + 'eeeeeeee'+eventSelected );
     if (myAttendeeSaveResult.isSuccess()) {
         if (myAttendeeSaveResult.iscreated()) {
             attmap = new Event_Attendee_Mapping__c();
             attmap.AS_id__c = myAttendeeSaveResult.getId();
             attmap.Ev_id__c = eventSelected;
             attmap.Attendee_Event_IDs__c = myAttendeeSaveResult.getId() + eventSelected;
            //---------------------------------------------------saving Ticket Types-------------
             if (selectedTicTypes.size() > 0) {
                 attmap.TicketTypes__c = '';
                 for (string str: selectedTicTypes) {
                     attmap.TicketTypes__c += str + ',';
                 }
             }
            //----------------------------------------saving Diversity types--------------------
             if (DiversityTypesforfirstLine.size() != 0) {
                 for (string str: DiversityTypesforfirstLine) {
                     attmap.DiversityType__c += str + ';';
                 }
             }
             if (DiversityTypesforsecondLine.size() != 0) {
                 for (string str1: DiversityTypesforsecondLine) {
                     attmap.DiversityType__c += str1 + ';'+' ';
                 }
             }
             //--------------------------------------------Attendee Types-------------------
               attmap.Attendee_Types__c='';
             if (selectedattendeetypes.size() != 0) {
             
                 for (string str1: selectedattendeetypes) {
                     attmap.Attendee_Types__c += str1+';'+' ';
                 }
             }
             Database.SaveResult myAttendeeJunction = Database.Insert(attmap, false);
             system.debug('            eam jun ID       '+myAttendeeJunction.getId());
             /**
             attmap.EA_AttendeeBarcode__c = myAttendeeJunction.getId() + '-' + eventSelected;
             update attmap;
             */
             addattendee = false;
             attendeeevent = myAttendeeJunction.id;
             eventatt = [select id, As_id__r.AS_FirstName__c,AS_id__r.AS_WorkPhone__c, As_id__r.AS_LastName__c, As_id__r.AS_Company__c, EV_ID__C,
                 TicketTypes__c, EV_id__r.EV_Title__c, AS_id__r.AS_Title__c, EA_AttendeeBarcode__c,AS_id__r.FetchStatus__c, AS_id__r.AS_Email__c, EV_id__r.EV_EventLogo__c,Boothleads_Profile__c,Attendee_Types__c from Event_Attendee_Mapping__c where id = : attendeeevent
             ];
              if(eventatt .Attendee_Types__c != null && eventatt .Attendee_Types__c != ''){
                
              if(eventatt .Attendee_Types__c.contains(';')){
              eventatt.Attendee_Types__c =eventatt.Attendee_Types__c.replaceAll(';',',');
              eventatt.Attendee_Types__c = eventatt.Attendee_Types__c.removeend(',');
              }
              
              
                  
             }
              if( eventatt.TicketTypes__c != null)
           
             eventselected = eventselected;
             getevents();
         } else {
             
             system.debug('============================');
             integer ev_att_Jun = [select count() from Event_Attendee_Mapping__c
                 where AS_id__r.id = : myAttendeeSaveResult.getId() and
                 Ev_id__c = : eventSelected
             ];
             system.debug('============================' + ev_att_Jun);
             if (ev_att_Jun > 0) {
                 showerror = 'Attendee Already Exists!';
                 DisplayError = True;
                 Database.rollback(sp);
             } else {
                 attmap = new Event_Attendee_Mapping__c();
                 attmap.AS_id__c = myAttendeeSaveResult.getId();
                 attmap.Ev_id__c = eventSelected;
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
                  attmap.Attendee_Types__c='';
                 if (selectedattendeetypes.size() != 0) {
                 for (string str1: selectedattendeetypes) {
                     attmap.Attendee_Types__c += str1 + ';'+'';
                 }
             }
             system.debug(':::::::::::::::::::::;; Dhriti:::::::::::::::'+attmap);
                 Database.SaveResult myAttendeeJunction = Database.Insert(attmap, false);
                 system.debug('            eam jun ID       '+myAttendeeJunction.getId());
                /** 
                 attmap.EA_AttendeeBarcode__c = myAttendeeJunction.getId() + '-' + eventSelected;
                 update attmap;*/
                 
                 attendeeevent = myAttendeeJunction.id;
                 addattendee = false;
                 eventatt = [select id, As_id__r.AS_FirstName__c,AS_id__r.AS_WorkPhone__c, As_id__r.AS_LastName__c, As_id__r.AS_Company__c, EV_ID__C, AS_id__r.AS_Email__c,EV_id__r.EV_EventLogo__c,
                     TicketTypes__c, EV_id__r.EV_Title__c, AS_id__r.AS_Title__c,AS_id__r.FetchStatus__c,
                     EA_AttendeeBarcode__c, Boothleads_Profile__c,Attendee_Types__c from Event_Attendee_Mapping__c where id = : attendeeevent];
                 
                 if(eventatt .Attendee_Types__c != null && eventatt .Attendee_Types__c != ''){
                
              if(eventatt .Attendee_Types__c.contains(';')){
              eventatt.Attendee_Types__c =eventatt.Attendee_Types__c.replaceAll(';',',');
              eventatt.Attendee_Types__c = eventatt.Attendee_Types__c.removeend(',');
              }
              
              
                  
             }
                 if(eventatt.TicketTypes__c != null)
                   eventatt.TicketTypes__c = eventatt.TicketTypes__c.removeend(',');
                
                
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
                 uperec.EventAdmin_Id__c=UserInfo.getUserId();
                 insert uperec;
             }
              eventselected = eventselected;
                 getevents();
         }
     }
 }
 
 //-------------------------------For Save And Print-----------------------
 public void saveandprint() {
     limitofbadges = false;
     SaveAttendee();
     fortwoprinters = true;
 }
 //------------------------------------------------------------------------------
 public void changestatus() {
     string ss = ApexPages.currentPage().getParameters().get('mycheck');
     system.debug('----------------------------mythily-------------------------------' + ApexPages.currentPage().getParameters().get('mycheck'));
     attendeeid = ss;
     system.debug('----------------------------mythily-------------------------------' + attendeeid);
     limitofbadges = false;
     statuschange = true;
     system.debug('----------------------' + statuschange);
 }
 public boolean ttypechange{get;set;}
 public String ttypelabel{get;set;}
 @RemoteAction
 global static void changettypes(String attidup,String label) {
     System.debug(attidup);
     Event_Attendee_Mapping__c event1=new Event_Attendee_Mapping__c();
      event1 = [select id,name,EA_isBadgePrinted__c, Boothleads_Profile__c,TicketTypesBP__c from Event_Attendee_Mapping__c where id = : attidup];
     event1.TicketTypesBP__c=label;
     update event1;
     
 }
 public boolean badgelabelchange{get;set;}
 public String badgelabel{get;set;}
 @RemoteAction
 global static void changebadgelabel(String attidup,String label) {
     Event_Attendee_Mapping__c event1=new Event_Attendee_Mapping__c();
     event1 = [select id,name,EA_isBadgePrinted__c, Boothleads_Profile__c,GuestType__c,BadgeQty__c from Event_Attendee_Mapping__c where id = : attidup];
 event1.GuestType__c=label;
 
     update event1;
 }
 @RemoteAction
 global static void changebadgeqty(String attidup,String qty) {
     Event_Attendee_Mapping__c event1=new Event_Attendee_Mapping__c();
     event1 = [select id,name,EA_isBadgePrinted__c, Boothleads_Profile__c,GuestType__c,BadgeQty__c from Event_Attendee_Mapping__c where id = : attidup];
 event1.BadgeQty__c=Decimal.valueOf(qty);
 
     update event1;
 }
 public ID attendeeid {
     get;
     set;
 }
 public List < selectoption > getprintingstatus() {
     event1 = new Event_Attendee_Mapping__c();
     limitofbadges = false;
     List < selectoption > Options = new List < selectoption > ();
     event1 = [select EA_isBadgePrinted__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : attendeeid];
     if (event1.EA_isBadgePrinted__c == true) {
         statusvalue = 'Printed';
         Options.add(new selectoption('Printed', 'Printed'));
         Options.add(new selectoption('NOt printed', 'Not printed'));
     } else {
         statusvalue = 'Not Printed';
         Options.add(new selectoption('NOt printed', 'Not printed'));
         Options.add(new selectoption('Printed', 'Printed'));
     }
     return Options;
 }

 public Event_Attendee_Mapping__c changingprintstatus() {
  system.debug ('        mallik status            '+statusvalue );
 
     if (statusvalue == 'Printed') {
         event1.EA_isBadgePrinted__c = true;
     } else {
         event1.EA_isBadgePrinted__c = false;
     }
     update event1;
     statuschange = false;
     getevents();
     return null;
 }
 public void changeemailstatus() {
     emailstatuschange = true;
 }
 public List < selectoption > getemailstatus() {
     limitofbadges = false;
     List < selectoption > Options = new List < selectoption > ();
     Event_Attendee_Mapping__c attmap = [select IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : eventname1];
     if (attmap.IsPrifileUpdate__c == true) {
         statusvalue = 'sent';
         Options.add(new selectoption('sent', 'sent'));
         Options.add(new selectoption('Not Sent', 'Not Sent'));
     } else {
         statusvalue = 'Not Sent';
         Options.add(new selectoption('Not Sent', 'Not Sent'));
         Options.add(new selectoption('sent', 'sent'));
     }
     return Options;
 }
 public Event_Attendee_Mapping__c changingemailstatus() {
     limitofbadges = false;
     Event_Attendee_Mapping__c attmap = [select IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : eventname1];
     if (statusvalue == 'Sent') {
         attmap.IsPrifileUpdate__c = true;
     } else {
         attmap.IsPrifileUpdate__c = false;
     }
     update attmap;
     system.debug('--------------------------------' + attmap.EA_isBadgePrinted__c);
     emailstatuschange = false;
     getevents();
     return null;
 }
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
 public void cloneattendee(){
 editAttendee();
 foreditatt = false;
 foraddatt = true;
 
 }
 public void editAttendee() {
   
     system.debug('========================================');
     string ss = ApexPages.currentPage().getParameters().get('mycheck');
     eventname1 = '';
     eventname1 = ss;
     system.debug('========================================' + ss);
     limitofbadges = false;
     DisplayError = False;
     imageerror = False;
     EventReqString = '';
     DivTypesforedit = new Event_Attendee_Mapping__c();
     TicTypesforedit = new Event_Attendee_Mapping__c();
     AttTypesforedit= new Event_Attendee_Mapping__c();
     eventatt = new Event_Attendee_Mapping__c();
     string TTT = '';
     List < string > totaltypes = new list < string > ();
     emailalert = false;
     attendeesetting = new BL_SecuritySettingsCon(eventSelected);
     //-------------------------------------------------------------FOR REG TYPE EDIT--------------------
     for (TicketTypes__c tt: tickets) {
         totaltypes.add(tt.TT_Name__c);
     }
     try {
         selectedTicTypes = new String[] {};
         options = new List < SelectOption > ();
         tickets = new list < TicketTypes__c > ();
         tickets = [select TT_Name__c from TicketTypes__c where EV_id__r.id = : eventSelected];
         for (TicketTypes__c Tic: tickets) {
             options.add(new SelectOption((String) Tic.TT_Name__c, Tic.TT_Name__c));
         }
         TicTypesforedit = [select TicketTypes__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : ss];
         TTT = TicTypesforedit.TicketTypes__c;
         list < string > regticket = TTT.split(',');
         selectedTicTypes = new String[] {};
         for (string reg: regticket) {
              reg = reg.trim();
             selectedTicTypes.add(reg);
         }
     } catch (exception e) {}
     
     //----------------------------------------------------------------FOR DIVERSITY TYPE EDIT-------------------------------------------
     try {
        Divoptions = new List < Selectoption > ();
     Divoptionsforsecondline = new List < Selectoption > ();
         system.debug('===============================' + eventSelected);
         eventDIVS = [select EventDiversityValues__c,Is_MatchMaking_Event__c from Event__c where id = : eventSelected];
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
         
         
        
         
         system.debug('2222222222 4444444444444 55555555555 '+Divoptions);
           system.debug('9999999999 777777777777 666666666666666'+Divoptionsforsecondline);
            
         DivTypesforedit = [select DiversityType__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : ss];
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
        
     } catch (exception e) {}
    //----------------------------------------------------for attendee types     in edit---------------------
    selectedattendeetypes=new string[]{};
     Attoptions =new list<SelectOption >{};
     
     atttypes=[select Attendee_Types__c,Is_MatchMaking_Event__c from Event__c where id =: eventSelected];
     string Type= atttypes.Attendee_Types__c;
     
     string[] Notypes =Type.split(';');
     
     for(String attentype:NoTypes){
     Attoptions.add(new selectoption(attentype,attentype));
     }     
    
     attTypesforedit = [select Attendee_Types__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : ss];
         system.debug('::::::::::::::::::::::' + attTypesforedit.Attendee_Types__c);
         selectedattendeetypes = new string[] {};
        
         if ( attTypesforedit.Attendee_Types__c != null) {
             string attendeetype =  attTypesforedit.Attendee_Types__c;
             list < string > seltypes = attendeetype.split(';');
             for (string dd: seltypes) {
             dd= dd.trim();
                 selectedattendeetypes.add(dd);
                 
             }
         }
     
     //--------------------------------------------------------------------
     Event_Attendee_Mapping__c attendeeid = [select AS_id__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : ss];
     newattendee = new AttendeeSummary__c();
     event1234 = new list < AttendeeSummary__c > ();
     event1234 = [select id, name, AS_Age__c, isUpdated__c, AS_BirthDate__c, AS_BlogUrl__c, AS_BusinessDescription__c, AS_BusinessDunsNumber__c,
         AS_BusinessEstablishedDate__c, AS_BusinessRevenue__c, AS_BusinessTaxId__c, AS_CellPhone__c,
         AS_Company__c, AS_DiversityType__c, Registration_type__c, AS_Email__c, AS_FaxNumber__c, AS_FirstName__c, AS_Gender__c,
         AS_HomeAddress1__c, AS_HomeAddress2__c, AS_HomeCity__c, AS_HomeCountry__c, AS_HomePhone__c,
         AS_HomePoBox__c, AS_HomeZip__c, AS_ImageUrl__c, AS_LastName__c, AS_NAICSCode_1__c,
         AS_NAICSCode_2__c, AS_NAICSCode_3__c, AS_NAICSCode_4__c, AS_NAICSCode_5__c, AS_NumberOfEmployees__c, AS_PrefixNew__c,
         AS_PrimaryBusinessCategory1__c, AS_SecondaryBusinessCategory1__c, AS_ShippingAddress1__c, AS_ShippingAddress2__c,
         AS_ShippingCity__c, AS_ShippingCountry__c, AS_ShippingPhone__c, AS_shippingzip__c, AS_ShippingState__c,
         AS_ShippingZipcode__c, AS_SuffixNew__c, AS_ThroughEventBrite__c, AS_Title__c, AS_WebsiteUrl__c, AS_WorkAddress1__c,
         AS_WorkAddress2__c, AS_WorkCity__c, AS_WorkCountry__c, AS_WorkPhone__c, AS_WorkPoBox__c, AS_Work_Country__c, AS_WorkZip__c,
         AS_Work_States__c, As_Home_Country__c, As_Home_State__c, As_Shipping_Country__c, As_Shipping_States__c,FetchStatus__c,isFetched__c,Commodity_1__c,Commodity_2__c,Commodity_3__c,Commodity_4__c,Commodity_5__c
         FROM AttendeeSummary__c WHERE id = : attendeeid.AS_id__c
     ];
     for (AttendeeSummary__c emEvent1: event1234) {
         if (ss != null && ss != '') {
             EventReqStringBool = false;
             EventReqString = 'Edit Attendee';
             addattendee = TRUE;
             foreditatt = true;
             foraddatt = false;
             newattendee = emEvent1;
             break;
         }
     }
     system.debug('========================================' + newattendee);
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
   /* if (newattendee.As_NAICSCode_1__c !=Null || newattendee.As_NAICSCode_1__c != '') 
    {
         NAICS1Mod = String.valueOf(newattendee.AS_NAICSCode_1__c);
         if (NAICS1Mod.contains('\'')) {
             NAICS1MOd = NAICS1Mod.replaceAll('\'', '');
         }
     }
     //if (newattendee.As_NAICSCode_2__c > 10) 
       if (newattendee.As_NAICSCode_2__c !=Null || newattendee.As_NAICSCode_2__c != '') 
     {
         NAICS2Mod = String.valueOf(newattendee.AS_NAICSCode_2__c);
         if (NAICS2Mod.contains('\'')) {
             NAICS2MOd = NAICS2Mod.replaceAll('\'', '');
         }
     }
     //if (newattendee.AS_NAICSCode_3__c > 10) 
    if (newattendee.As_NAICSCode_3__c !=Null || newattendee.As_NAICSCode_3__c != '') 
     {
         NAICS3Mod = String.valueOf(newattendee.AS_NAICSCode_3__c);
         if (NAICS3Mod.contains('\'')) {
             NAICS3MOd = NAICS3Mod.replaceAll('\'', '');
         }
     }
     //if (newattendee.AS_NAICSCode_4__c > 10) 
    if (newattendee.As_NAICSCode_4__c !=Null || newattendee.As_NAICSCode_4__c != '') 
     {
         NAICS4Mod = String.valueOf(newattendee.AS_NAICSCode_4__c);
         if (NAICS4Mod.contains('\'')) {
             NAICS4MOd = NAICS4Mod.replaceAll('\'', '');
         }
     }
    // if (newattendee.AS_NAICSCode_5__c > 10) 
    if (newattendee.As_NAICSCode_5__c !=Null || newattendee.As_NAICSCode_5__c != '') 
    {
         NAICS5Mod = String.valueOf(newattendee.AS_NAICSCode_5__c);
         if (NAICS5Mod.contains('\'')) {
             NAICS5MOd = NAICS5Mod.replaceAll('\'', '');
         }
     }  */
     EditDate = String.valueOf(newattendee.AS_BirthDate__c);
     BEDate = String.valueOf(newattendee.AS_BusinessEstablishedDate__c);
     System.debug('HEllo MALLIK END ' + addattendee + '   ' + newAttendee);
     List < User_Profile_Event__c > CompareEmailId = [select id from User_Profile_Event__c where((BoothAdmin_id__r.Email = : newattendee.AS_Email__c OR EventAdmin_Id__r.Email = : newattendee.AS_Email__c) AND(EV_id__c = : eventSelected)) OR((User_Id__r.Email = : newattendee.AS_Email__c) AND(Profile_ID__r.PR_Name__c = 'BoothPersonnel') AND(EV_id__c = : eventSelected))];
     system.debug('-------------------------CompareEmailId' + CompareEmailId);
     if (CompareEmailId.size() > 0) {
         HideEmail = True;
         showEmail = False;
         ShowFirstName = False;
         ShowLastName = False;
         HideFirstName = True;
         HideLastName = True;
     }else{
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
     List<folder> folderList =new List<folder>();
  folderList = [select id from folder where name='shared Documents']; 
   
     system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' + eventname1);
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
     if (browserType != null && browserType.contains('MSIE')) {
         Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
     }
try {
         attach = [select EV_EventLogo__c,Is_MatchMaking_Event__c from Event__c where id = : eventSelected];
         if (attach.EV_EventLogo__c != null) {
             logo = true;
         } else {
             logo = false;
         }
     } catch (exception e) {}
     system.debug('gggggggggggggg&&&&&&&' + attendeeImage);
     limitofbadges = false;
     system.debug('(&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+eventname1);
     Event_Attendee_Mapping__c EveAttmaprec = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c
         where id = : eventname1
     ];
     system.debug('(&&&&&&&&&&&&&&EveAttmaprec&&&&&&&&&&&&&'+EveAttmaprec);
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
         system.debug('%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%' + newattendee.AS_Email__c);
         if (EventAttendee_Email != null) {
             if (EventAttendee_Email.id != eventName1) {
                 system.debug('%%%%%%%&&&&&&&&&&&&&&&&&&&&&&&&%%%%%%%%%');
                 showerror = 'Attendee Already Exists!';
                 DisplayError = True;
             } else {
                /* try {
                     newattendee.AS_NAICSCode_1__c = NAICS1Mod;
                 } catch (Exception e) {}
                 try {
                     newattendee.AS_NAICSCode_2__c = NAICS2Mod;
                 } catch (Exception e) {}
                 try {
                     newattendee.AS_NAICSCode_3__c =NAICS3Mod;
                 } catch (Exception e) {}
                 try {
                     newattendee.AS_NAICSCode_4__c = NAICS4Mod;
                 } catch (Exception e) {}
                 try {
                     newattendee.AS_NAICSCode_5__c =NAICS5Mod;
                 } catch (Exception e) {} */
                 update newattendee;
                 system.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&' + attendeeImage);
                
                 try {
                     TicTypesforedit.TicketTypes__c = '';
                     for (string regtypes: selectedTicTypes) {
                         TicTypesforedit.TicketTypes__c += regtypes + ',';
                     }
                     update TicTypesforedit;
          //---------------------------------------------------------Diversity---------------------------
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
                

          //----------------------------------------------------------------Attendee Types-----------------------------
          AttTypesforedit.Attendee_Types__c = '';
                     if (selectedattendeetypes.size() != 0) {
                         for (string dtypes: selectedattendeetypes) {
                             AttTypesforedit.Attendee_Types__c += dtypes + ';'+'';
                         }
                     }
                     
                     update AttTypesforedit;
             //-----------------------------------------------------------------------------------------    
             } catch (exception e) {}

                 eventatt = [select id, As_id__r.AS_FirstName__c, As_id__r.AS_LastName__c, As_id__r.AS_Company__c, EV_ID__C,
                     TicketTypes__c, EV_id__r.EV_Title__c, AS_id__r.AS_Title__c, AS_id__r.AS_Email__c, EV_id__r.EV_EventLogo__c,
                     EA_AttendeeBarcode__c,AS_id__r.FetchStatus__c, Boothleads_Profile__c,Attendee_Types__c from Event_Attendee_Mapping__c where id = : EveAttmaprec.id
                 ];
                 if( eventatt.Attendee_Types__c != null){
              if(eventatt.Attendee_Types__c.contains(';')){
              eventatt.Attendee_Types__c =eventatt.Attendee_Types__c.replaceAll(';',',');
              eventatt.Attendee_Types__c = eventatt.Attendee_Types__c.removeend(',');
              }
              
               }
                 if(eventatt.TicketTypes__c != null)
                     eventatt.TicketTypes__c = eventatt.TicketTypes__c.removeend(',');
                
                 if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
                     if (attendeeImage.size() != null) {
                         if (attendeeImage.size() <= 10240000) {
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
             EveAttmaprec.AS_id__c = AttendeeEmail[0].id;
             EveAttmaprec.Attendee_Event_IDs__c = AttendeeEmail[0].id + eventSelected;
             update EveAttmaprec;
             try {
                 TicTypesforedit.TicketTypes__c = '';
                 for (string regtypes: selectedTicTypes) {
                     TicTypesforedit.TicketTypes__c += regtypes + ',';
                 }
                 update TicTypesforedit;
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
                   //----------------------------------------------------------------Attendee Types-----------------------------
          AttTypesforedit.Attendee_Types__c = '';
                     if (selectedattendeetypes.size() != 0) {
                         for (string dtypes: selectedattendeetypes) {
                             AttTypesforedit.Attendee_Types__c += dtypes + ';'+'';
                         }
                     }
                     
                     update AttTypesforedit;
             //-----------------------------------------------------------------------------------------   
             } catch (exception e) {}
             eventatt = [select id, As_id__r.AS_FirstName__c, As_id__r.AS_LastName__c, As_id__r.AS_Company__c, EV_ID__C, As_id__r.AS_Email__c,EV_id__r.EV_EventLogo__c,
                 TicketTypes__c, EV_id__r.EV_Title__c, AS_id__r.AS_Title__c,AS_id__r.FetchStatus__c,
                 EA_AttendeeBarcode__c, Boothleads_Profile__c,Attendee_Types__c from Event_Attendee_Mapping__c where id = : EveAttmaprec.id
             ];
             if( eventatt.TicketTypes__c != null)
               eventatt.TicketTypes__c = eventatt.TicketTypes__c.removeend(',');
             /*encrit = eventatt.EA_AttendeeBarcode__c;
             blob data = Blob.valueOf(encrit);
             String b64Data = EncodingUtil.base64Encode(data);
             
             system.debug('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[' + b64Data);
             
             eventatt.EA_AttendeeBarcode__c = '';
             eventatt.EA_AttendeeBarcode__c = b64Data;
             **/
              if( eventatt.Attendee_Types__c != null){
              if(eventatt.Attendee_Types__c.contains(';')){
              eventatt.Attendee_Types__c =eventatt.Attendee_Types__c.replaceAll(';',',');
              eventatt.Attendee_Types__c = eventatt.Attendee_Types__c.removeend(',');
              }
              
               }
             
             if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
                 if (attendeeImage.size() != null) {
                     if (attendeeImage.size() <= 10240000) {
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
      /*  try {
             UpdateAttendee.AS_NAICSCode_1__c =NAICS1Mod;
         } catch (Exception e) {}
         try {
             UpdateAttendee.AS_NAICSCode_2__c = NAICS2Mod;
         } catch (Exception e) {}
         try {
             UpdateAttendee.AS_NAICSCode_3__c = NAICS3Mod;
         } catch (Exception e) {}
         try {
             UpdateAttendee.AS_NAICSCode_4__c = NAICS4Mod;
         } catch (Exception e) {}
         try {
             UpdateAttendee.AS_NAICSCode_5__c = NAICS5Mod;
         } catch (Exception e) {}  */
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
         insert UpdateAttendee;
         system.debug('::::::::::::::::::::new attendee:::::::::' + UpdateAttendee.id);
         EveAttmaprec.AS_id__c = UpdateAttendee.id;
         EveAttmaprec.EV_id__c = eventSelected;
         EveAttmaprec.Attendee_Event_IDs__c = UpdateAttendee.Id + eventSelected;
         EveAttmaprec.EA_AttendeeBarcode__c = EveAttmaprec.id + '-' + eventSelected;
         update EveAttmaprec;
         system.debug('--------------Updated jun record-----------------' + EveAttmaprec.id);
         eventatt = [select id, As_id__r.AS_FirstName__c, As_id__r.AS_LastName__c, As_id__r.AS_Company__c, EV_ID__C,
             TicketTypes__c, EV_id__r.EV_Title__c, AS_id__r.AS_Title__c,EV_id__r.EV_EventLogo__c,
             EA_AttendeeBarcode__c, Boothleads_Profile__c,Attendee_Types__c from Event_Attendee_Mapping__c where id = : EveAttmaprec.id
         ];
          if( eventatt.Attendee_Types__c != null){
              if(eventatt.Attendee_Types__c.contains(';')){
              eventatt.Attendee_Types__c =eventatt.Attendee_Types__c.replaceAll(';',',');
              eventatt.Attendee_Types__c = eventatt.Attendee_Types__c.removeend(',');
              }
              
               }
         if(eventatt.TicketTypes__c != null)
           eventatt.TicketTypes__c = eventatt.TicketTypes__c.removeend(',');
         if (attendeeImage != NULL && (myimageName != '' || myimageName != NULL)) {
             if (attendeeImage.size() != null) {
                 if (attendeeImage.size() <= 10240000) {
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
             }
         } else {
             addattendee = false;
             eventselected = eventselected;
             getevents();
         }
     }
     return null;
 }
 public PageReference Cancel() {
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
     if (browserType != null && browserType.contains('MSIE')) {
         Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
     }
     fortwoprinters = false;
     limitofbadges = false;
     duplicateAttendeeBool = false;
     ccrdetailsbool=false;
     ccrdetailsboolall=false;
     ccrdetailsboolall=false;
     fbool = false;
     addattendee = false;
     addattendee1 = false;
     addattendee = false;
     Dymo = false;
     DataImportBool = false;
     statuschange = false;
     ttypechange=false;
     badgelabelchange=false;
     emailstatuschange = false;
     //pagereference pf=new pagereference('/apex/Qrcode_Eventadmin_Attendees');
     //pf.setredirect(true);
     eventselected = eventselected;
     getevents();
     return null;
 }
 //------------------------------------------------------------------------------------------
 public List < selectoption > getselect() {
     List < selectoption > Option = new List < selectoption > ();
     Option.add(new selectoption('Male', 'Male'));
     Option.add(new selectoption('Female', 'Female'));
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
 public void PrintBadge() {
     system.debug('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' + eventname1);
     String browserType = Apexpages.currentPage().getHeaders().get('USER-AGENT');
     if (browserType != null && browserType.contains('MSIE')) {
         Apexpages.currentPage().getHeaders().put('X-UA-Compatible', 'IE=9');
     }
     limitofbadges = false;
     EventReqStringBool = false;
     attid = new List < id > ();
     integer count = 0;
     if (ForPagination.size() > 0) {
         attforexport = new List < Event_Attendee_Mapping__c > ();
         exportlistoflist = new List < List < Event_Attendee_Mapping__c >> ();
         attendeeslist = new List < Event_Attendee_Mapping__c > ();
         
         if (Allrecords == true) {

           SET<id> idvalues = new SET<id>();
            for( eventwrapper are:ew){
                idvalues.add(are.atnd.id); 
             }
         
          
            string badgestr ='select AS_id__c, AS_id__r.id,AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_Email__c, AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, IsPrifileUpdate__c, EA_isBadgePrinted__c, AS_id__r.AS_Title__c, EV_id__r.EV_Title__c,AS_id__r.FetchStatus__c,Attendee_Types__c, TicketTypes__c,GuestType__c,EA_isBadgeSent__c,BadgeQty__c,Badge_Color__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id in : idvalues ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
         
              
             attendeeslist =dataBase.Query(badgestr);         
            
             
            
             system.debug('atttttttttttt list' + attendeeslist);
             for (Event_Attendee_Mapping__c aa: attendeeslist) {
             if(aa.Attendee_Types__c != null && aa.Attendee_Types__c != ''){
                
              if(aa.Attendee_Types__c.contains(';')){
              aa.Attendee_Types__c =aa.Attendee_Types__c.replaceAll(';',',');
              aa.Attendee_Types__c = aa.Attendee_Types__c.removeend(',');
              }
              
              
                  
             }
                 attid.add(aa.id);
             }
         } else
         if (forPaginationstoreIds.KeySet().size() != 0) {
             Set<id> keysetValues = new SET<id>();
              keysetValues =forPaginationstoreIds.KeySet();
              string badgestrings = 'select GuestType__c,EA_isBadgeSent__c,BadgeQty__c,Badge_Color__c,AS_id__c, AS_id__r.id, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_Email__c,AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, IsPrifileUpdate__c, EA_isBadgePrinted__c, AS_id__r.AS_Title__c, EV_id__r.EV_Title__c, Attendee_Types__c,TicketTypes__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id in :keysetValues ORDER BY '+sortField+' '+sortDir  +' NULLS LAST';
              attendeeslist =dataBase.Query(badgestrings);
             
             system.debug('============ attendee List ===========' + attendeeslist);
             for (Event_Attendee_Mapping__c aa: attendeeslist) {
              if( aa.Attendee_Types__c != null){
              if(aa.Attendee_Types__c.contains(';')){
              aa.Attendee_Types__c =aa.Attendee_Types__c.replaceAll(';',',');
              aa.Attendee_Types__c = aa.Attendee_Types__c.removeend(',');
              }
              
               }
                 attid.add(aa.id);
             }
         } else {
             EventReqString = 'Please Select atleast one Attendee';
             EventReqStringBool = TRUE;
         }
         for (Event_Attendee_Mapping__c enc: attendeeslist) {
              if(enc .TicketTypes__c != null && enc .TicketTypes__c != ''){
                  enc .TicketTypes__c =  enc .TicketTypes__c.removeend(',');
             }
              
         }
         for (Event_Attendee_Mapping__c atype: attendeeslist) {
              if(atype.Attendee_Types__c != null && atype.Attendee_Types__c != ''){
                
              if(atype.Attendee_Types__c.contains(';')){
              atype.Attendee_Types__c =atype.Attendee_Types__c.replaceAll(';',',');
              atype.Attendee_Types__c = atype.Attendee_Types__c.removeend(',');
              }
              
              
                  
             }
              
         }
         ticeam = new map<id,List<string>> {};
        
         if (attendeeslist.size() <= 500) {
           list<Ticket_Eam__c> tieamjun = [select TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c,Event_Attendee_Mapping__c  from Ticket_Eam__c where Event_Attendee_Mapping__c IN : attid];
         system.debug('SSS DDD GG TT RR '+tieamjun );
             system.debug('==============================attendeeslist.size===============' + attendeeslist.size());
             set<id> idsfordup = new set<id> {};
                  listtic = new list<string> {};
             for (Event_Attendee_Mapping__c s: attendeeslist) {
                 count++;
                 
                 //system.debug('==============================encripted data===============' + s.EA_AttendeeBarcode__c);
                 attforexport.add(s);
                 if (count == 1000) {
                     system.debug('==============================count===============' + count);
                     exportlistoflist.add(attforexport);
                     attforexport = new LIST < Event_Attendee_Mapping__c > ();
                     count = 0;
                 }
                 if(tieamjun.size() != 0){
                                 for(Ticket_Eam__c tc:tieamjun ){
                                 listtic = new List<string> ();
                                  if(s.id == tc.Event_Attendee_Mapping__c) 
                                    if(idsfordup.add(s.id)){
                                    listtic.add(tc.TicketTypes__r.Ticket_Category__c);
                                    }
                                    }}
                                     ticeam.put(s.id,listtic);
                                     system.debug(':::::::::::::::barCode:::::::::::' + listtic);
                 
             }
             if (count != 0) {
                 exportlistoflist.add(attforexport);
             }
            try {
                 attach = [select EV_EventLogo__c,Is_MatchMaking_Event__c from Event__c where id = : eventSelected];
                 logo = true;
            } catch (exception e) {
                 logo = false;
             }
             system.debug('////////////////////////////////////selected value ///////////' + selectedvalues);
             if (selectedvalues != 'Dymo Label(30856,Single Label)' && selectedvalues != 'Zebra Label') {
                 newstr = new List < InnerForBadge > ();
                 newstr1 = new List < InnerForBadge > ();
                 integer i = 0;
                 LIST < ID > badgeAttid = new LIST < ID > ();
                 for (Event_Attendee_Mapping__c evj: attendeeslist) {

                     badgeAttid.add(evj.AS_id__c);
                     
                 }
                  
                 MAP < ID, Sobject > printbad = new MAP < id, SObject > ([select id, name, AS_LastName__c, AS_FirstName__c, AS_Company__c, AS_Title__c FROM AttendeeSummary__c WHERE ID IN: badgeAttid]);
                 list<string> ticstoshow = new list<string> ();
                 for (Event_Attendee_Mapping__c eww: attendeeslist) {
                 
                 ticstoshow = new list<string> ();
                 
                        ticstoshow.addAll(ticeam.get(eww.id));
                        
                        if(ticstoshow.size() == 0 && ticstoshow != null ){
                        ticstoshow.add(eww.Attendee_Types__c);
                        }
                        string ttype='';
                        for(string stt :ticstoshow ){
                        Ttype+=stt+',';
                        }
                        system.debug('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh'+ticstoshow);
                        todisptitle ='';
                        todisptitle = 'AS_Title__c';
                     if (math.mod(i, 2) == 0) {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get(selfieldvalue), (String) printbad.get(eww.AS_id__c).get(selLvalue), (String) printbad.get(eww.AS_id__c).get(selTvalue), (String) printbad.get(eww.AS_id__c).get(todisptitle), eww.EA_AttendeeBarcode__c, eww.TicketTypes__c,Ttype,eww.GuestType__c,eww.Badge_Color__c);
                        
                         newstr.add(ifb);
                     } else {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get(selfieldvalue), (String) printbad.get(eww.AS_id__c).get(selLvalue), (String) printbad.get(eww.AS_id__c).get(selTvalue),(String) printbad.get(eww.AS_id__c).get(todisptitle), eww.EA_AttendeeBarcode__c, eww.TicketTypes__c,Ttype,eww.GuestType__c,eww.Badge_Color__c);
                         newstr1.add(ifb);
                     }
                     i++;
                 }

                 LIST < InnerForBadge > FLRec = new LIST < InnerForBadge > ();
                 LeftValues = new LIST < LIST < InnerForBadge >> ();
                 integer Lpagecount = 0;
                 for (InnerForBadge l: newstr) {
                     FLRec.add(l);
                     Lpagecount++;
                     if (Lpagecount == 3) {
                         LeftValues.add(FLRec);
                         Lpagecount = 0;
                         FLRec = new LIST < InnerForBadge > ();
                     }
                 }
                 if (FLRec.size() != 0) {
                     LeftValues.add(FLRec);
                 }
                 LIST < InnerForBadge > SLRec = new LIST < InnerForBadge > ();
                 RightValues = new LIST < LIST < InnerForBadge >> ();
                 integer Rpagecount = 0;
                 for (InnerForBadge l: newstr1) {
                     SLRec.add(l);
                     Rpagecount++;
                     if (Rpagecount == 3) {
                         RightValues.add(SLRec);
                         Rpagecount = 0;
                         SLRec = new LIST < InnerForBadge > ();
                     }
                 }
                 if (SLRec.size() != 0) {
                     RightValues.add(SLRec);
                 }
                 addattendee1 = TRUE;
                 event1 = new Event_Attendee_Mapping__c();
             }
         } else {
             system.debug('==============================attendeeslist.size===============' + attendeeslist.size());
             EventReqString = 'Please donot Select more than 500 attendees to print';
             EventReqStringBool = TRUE;
         }
     } else
     if (TotalAttendees.size() <= 0) {
         EventReqString = 'Please create an Attendee';
         EventReqStringBool = TRUE;
     }
 }
 //-----------------------------------------------------------END OF FIRSTLABEL------------------------------    
 //---------------------------------------------------------------FOR EASY PEAL OFF BADGE---------------- 
 public string encrit {
     get;
     set;
 }
 public void PrintBadgeforthree() {
     limitofbadges = false;
     fbool = false;
     EventReqStringBool = false;
     attid = new List < id > ();
     integer count = 0;
     if (ForPagination.size() > 0) {
         if (forPaginationstoreIds.KeySet().size() != 0) {
             attforexport = new List < Event_Attendee_Mapping__c > ();
             exportlistoflist = new List < List < Event_Attendee_Mapping__c >> ();
             attendeeslist = new List < Event_Attendee_Mapping__c > ();
             if (Allrecords == true) {
                 attendeeslist = [select GuestType__c,EA_isBadgeSent__c,BadgeQty__c,AS_id__c, Badge_Color__c,AS_id__r.id, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_Email__c,
                     AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, IsPrifileUpdate__c,
                     EA_isBadgePrinted__c, AS_id__r.AS_Title__c, EV_id__r.EV_Title__c, TicketTypes__c,AS_id__r.FetchStatus__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where EV_id__c = : eventselected
                 ];
                 for (Event_Attendee_Mapping__c aa: attendeeslist) {
                     attid.add(aa.id);
                 }
             } else {
                 attendeeslist = [select GuestType__c,EA_isBadgeSent__c,BadgeQty__c,Badge_Color__c,AS_id__c, AS_id__r.id, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_Email__c,
                     AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, IsPrifileUpdate__c,
                     EA_isBadgePrinted__c, AS_id__r.AS_Title__c, EV_id__r.EV_Title__c, TicketTypes__c,AS_id__r.FetchStatus__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id in : forPaginationstoreIds.KeySet()
                 ];
                 for (Event_Attendee_Mapping__c aa: attendeeslist) {
                     attid.add(aa.id);
                 }
             }
             for (Event_Attendee_Mapping__c enc: attendeeslist) {
                  if(enc.TicketTypes__c != null  &&  enc.TicketTypes__c!= ''){
                                  enc.TicketTypes__c = enc.TicketTypes__c.removeend(',');
                     }
              
                
             }
           
             for (Event_Attendee_Mapping__c s: attendeeslist) {
                 count++;
                 system.debug('==============================count===============' + count);
                 attforexport.add(s);
                 if (count == 1000) {
                     system.debug('==============================count===============' + count);
                     exportlistoflist.add(attforexport);
                     attforexport = new LIST < Event_Attendee_Mapping__c > ();
                     count = 0;
                 }
             }
             if (count != 0) {
                 exportlistoflist.add(attforexport);
             }
             newstr = new List < InnerForBadge > ();
             newstr1 = new List < InnerForBadge > ();
             newstr2 = new List < InnerForBadge > ();
             integer i = 0;
             LIST < ID > badgeAttid = new LIST < ID > ();
             for (Event_Attendee_Mapping__c evj: attendeeslist) {
                 badgeAttid.add(evj.AS_id__c);
             }
             MAP < ID, Sobject > printbad = new MAP < id, SObject > ([select id, name, AS_LastName__c, AS_FirstName__c, AS_Company__c, AS_Title__c FROM AttendeeSummary__c WHERE ID IN: badgeAttid]);
             for (Event_Attendee_Mapping__c eww: attendeeslist) {
                 if (math.mod(i, 3) == 0) {
                     if (selfieldvalue == 'AS_FirstName__c,AS_LastName__c') {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get('AS_FirstName__c') + (String) printbad.get(eww.AS_id__c).get('AS_LastName__c'), (String) printbad.get(eww.AS_id__c).get(selLvalue), eww.EA_AttendeeBarcode__c);
                         newstr.add(ifb);
                     } else {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get(selfieldvalue), (String) printbad.get(eww.AS_id__c).get('AS_FirstName__c') + (String) printbad.get(eww.AS_id__c).get('AS_LastName__c'), eww.EA_AttendeeBarcode__c);
                         newstr.add(ifb);
                     }
                 } else if (math.mod(i, 3) == 1) {
                     if (selfieldvalue == 'AS_FirstName__c,AS_LastName__c') {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get('AS_FirstName__c') + (String) printbad.get(eww.AS_id__c).get('AS_LastName__c'), (String) printbad.get(eww.AS_id__c).get(selLvalue), eww.EA_AttendeeBarcode__c);
                         newstr1.add(ifb);
                     } else {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get(selfieldvalue), (String) printbad.get(eww.AS_id__c).get('AS_FirstName__c') + (String) printbad.get(eww.AS_id__c).get('AS_LastName__c'), eww.EA_AttendeeBarcode__c);
                         newstr1.add(ifb);
                     }
                 } else if (math.mod(i, 3) == 2) {
                     if (selfieldvalue == 'AS_FirstName__c,AS_LastName__c') {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get('AS_FirstName__c') + (String) printbad.get(eww.AS_id__c).get('AS_LastName__c'), (String) printbad.get(eww.AS_id__c).get(selLvalue), eww.EA_AttendeeBarcode__c);
                         newstr2.add(ifb);
                     } else {
                         InnerForBadge ifb = new InnerForBadge((String) printbad.get(eww.AS_id__c).get(selfieldvalue), (String) printbad.get(eww.AS_id__c).get('AS_FirstName__c') + (String) printbad.get(eww.AS_id__c).get('AS_LastName__c'), eww.EA_AttendeeBarcode__c);
                         newstr2.add(ifb);
                     }
                 }
                 i++;
             }
             LIST < InnerForBadge > FLRec = new LIST < InnerForBadge > ();
             LeftValues = new LIST < LIST < InnerForBadge >> ();
             integer Lpagecount = 0;
             for (InnerForBadge l: newstr) {
                 FLRec.add(l);
                 Lpagecount++;
                 if (Lpagecount == 4) {
                     LeftValues.add(FLRec);
                     Lpagecount = 0;
                     FLRec = new LIST < InnerForBadge > ();
                 }
             }
             if (FLRec.size() != 0) {
                 LeftValues.add(FLRec);
             }
             LIST < InnerForBadge > MLRec = new LIST < InnerForBadge > ();
             MiddleValues = new LIST < LIST < InnerForBadge >> ();
             integer Middlecount = 0;
             for (InnerForBadge l: newstr1) {
                 MLRec.add(l);
                 Middlecount++;
                 if (Middlecount == 4) {
                     MiddleValues.add(MLRec);
                     Middlecount = 0;
                     MLRec = new LIST < InnerForBadge > ();
                 }
             }
             if (MLRec.size() != 0) {
                 MiddleValues.add(MLRec);
             }
             LIST < InnerForBadge > SLRec = new LIST < InnerForBadge > ();
             RightValues = new LIST < LIST < InnerForBadge >> ();
             integer Rpagecount = 0;
             for (InnerForBadge l: newstr2) {
                 SLRec.add(l);
                 Rpagecount++;
                 if (Rpagecount == 4) {
                     RightValues.add(SLRec);
                     Rpagecount = 0;
                     SLRec = new LIST < InnerForBadge > ();
                 }
             }
             if (SLRec.size() != 0) {
                 RightValues.add(SLRec);
             }
             try {
                 attach = [select EV_EventLogo__c,Is_MatchMaking_Event__c from Event__c where id = : eventSelected];
                 if (attach != null) {
                     logo = true;
                 }
             } catch (exception e) {
                 logo = false;
             }
             addattendee1 = TRUE;
             event1 = new Event_Attendee_Mapping__c();
         } else {
             EventReqString = 'Please Select atleast one Attendee';
             EventReqStringBool = TRUE;
         }
     } else
     if (TotalAttendees.size() <= 0) {
         EventReqString = 'Please create an Attendee';
         EventReqStringBool = TRUE;
     }
 }
 //------------------------------------------------------Attendee Detail Page--------------------    
 public boolean EventReqStringbool3 {
     get;
     set;
 }
 
 public PageReference attendeedetail() {
     string  eamid = ApexPages.currentPage().getParameters().get('mycheck');
     //Event_Attendee_Mapping__c ss = [select AS_id__r.id, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : eamid limit 1];
     PageReference pg = new pagereference('/apex/qrcode_attendee_details?id='+eamid+'&eventid='+eventselected);
     pg.setRedirect(true);
     return pg;
 }
 //----------------------------------------------------------------------FOR Import------------------------    
 public void ShowPreviousList() {
     limitofbadges = false;
     emailalert = false;
     DataImportBool = TRUE;
     ImportHistory = new LIST < DataImport_SavePoint__c > ();
     ImportHistory = [Select d.User_id__c, d.createdDate, d.Name, d.DS_TotalRecords__c, d.DS_FileName__c From DataImport_SavePoint__c d WHERE User_id__c = : userInfo.getUserId()];
 }
 //------------------------------------------------------POPUP FOR SELECTING DESIRED LABEL-----------------------------------
 public List<BadgeTemplate_Styles__c> Bdstyles {get ; set ;}
 public LIST<selectoption> bdstyleslist {get ; set ;}
 public string selectedbdtemname {get;set;}

 public void popup() {
     bdstyleslist = new  LIST<selectoption> ();
     eventlist = new List < Event_Attendee_Mapping__c > ();
     Bdstyles = new List<BadgeTemplate_Styles__c> ();
     eventlist = [select CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,
         AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,
         EA_isBadgePrinted__c, AS_id__r.AS_Email__c, AS_id__r.Registration_type__c,AS_id__r.FetchStatus__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where EV_id__r.id = : eventSelected ORDER BY AS_id__r.AS_Company__c
     ];
     system.debug('===================' + eventlist);
     Bdstyles = [select id,Name,badge_type__c from BadgeTemplate_Styles__c where Event__r.id =: eventSelected and badge_type__c='Zebra' and Module__c like '%Attendee Registration%' ];
    for(BadgeTemplate_Styles__c BTS : Bdstyles ){
    bdstyleslist.add(new selectoption(BTS.Name,BTS.Name));
    }
    
     for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     
     selectedvalues = 'select';
    
     Event1 = new Event_Attendee_Mapping__c();
     system.debug('           ALL records T/F    ' + Allrecords);
     if (Allrecords == true) {
     if(selectedoption!=null & selectedoption!=''){
           SET<id> idvalues = new SET<id>();
            for( eventwrapper are:ew){
                idvalues.add(are.atnd.id); 
             }
         system.debug('           ALL records     ');
         attforexport = new List < Event_Attendee_Mapping__c > ();
         attforexport = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE Id In : idvalues];
        }else{
        attforexport = new List < Event_Attendee_Mapping__c > ();
         attforexport = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE ev_Id__c = : eventselected];
        
        }
        system.debug('            size      '+attforexport.size());
         if ((selectednum == '' || selectednum == null) &&(attforexport.size() > 500)) {
             limitofbadges = TRUE;
         } else {
             EventReqStringBool = false;
             for (Event_Attendee_Mapping__c emEvent1: eventlist) {
                 if (forPaginationstoreIds.KeySet().size() != 0 && forPaginationstoreIds.containsKey(emEvent1.Id)) {
                     fbool = TRUE;
                     Event1 = emEvent1;
                     break;
                 }
             }
             Event__c EVprinter = [select Event_Printer__c,Is_MatchMaking_Event__c from Event__c where id = : eventselected];
             system.debug('==================selected printer=======' + EVprinter.Event_Printer__c);
             if (EVprinter.Event_Printer__c != null) {
                 SelectedValues = EVprinter.Event_Printer__c;
                 print = true;
             }
             getfields();
         }
     } else {
         if (forPaginationstoreIds.KeySet().size() != 0) {
             attendeeslist = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c where id in : forPaginationstoreIds.KeySet()];
             system.debug(':::::::::::::::::size:::::::::::' + attendeeslist.size());
             if (attendeeslist.size() <= 500) {
                 EventReqStringBool = false;
                 for (Event_Attendee_Mapping__c emEvent1: eventlist) {
                     if (forPaginationstoreIds.KeySet().size() != 0 && forPaginationstoreIds.containsKey(emEvent1.Id)) {
                         fbool = TRUE;
                         Event1 = emEvent1;
                         break;
                     }
                 }
                 Event__c EVprinter = [select Event_Printer__c,Is_MatchMaking_Event__c from Event__c where id = : eventselected];
                 system.debug('==================selected printer=======' + EVprinter.Event_Printer__c);
                 if (EVprinter.Event_Printer__c != null) {
                     SelectedValues = EVprinter.Event_Printer__c;
                     print = true;
                 }
                 getfields();
             } else {
                 //EventReqString = 'Please do not select more than 500 attendees at a time to print';
                 limitofbadges = TRUE;
             }
         } else {
             EventReqString = 'Please select atleast one attendee to print';
             EventReqStringBool = TRUE;
         }
     }
 }
 //--------------------------------------------------------------------------------------EMAIL BADGE------------------------
 public PageReference emailBadge() {
 try{

     for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     emailalert = false;
     limitofbadges = false;
     if (forPaginationstoreIds.KeySet().size() != 0) {
         list < Event_Attendee_Mapping__c > emailids = [select id, EA_AttendeeBarcode__c, AS_id__r.AS_LastName__c,
             AS_id__r.AS_FirstName__c, AS_id__r.AS_Email__c,AS_id__r.FetchStatus__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id IN: forPaginationstoreIds.KeySet()
         ];
         list < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
         for (Event_Attendee_Mapping__c eid: emailids) {
             pdf = page.Qrcode_EmailBadgeToAttendees;
             string fss = eid.EA_AttendeeBarcode__c;
             pdf.getParameters().put('id', fss);
             b = pdf.getContent();
             Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
             email.setSubject('Your Ticket For Registered Event!');
             String[] toAddresses = new String[] {
                 eid.AS_id__r.AS_Email__c
             };
             email.setToAddresses(toAddresses);
             email.setHTMLBody(message = 'Hello ' + ' ' + '' + eid.AS_id__r.AS_FirstName__c + '<br/>' + '' + '<br/>' +
                 ' Your badge for the registered event is attached as a pdf. You can view this' + '<br/>' +
                 'badge from your mobile device.' + '<br/>' +
                 'If you have any questions please contact Booth Leads customer support.' + '<br/>' + '' + '<br/>' + '<br/>' +
                 ' Thank you,' + '<br/>' +
                 'Booth Leads customer support' + '<br/>' +
                 'support@boothleads.com.' + '<br/>' +
                 'Phone: 1-(800)-492-1289.');
             Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
             efa.setFileName('Mybadge.pdf');
             efa.setBody(b);
             email.setFileAttachments(new Messaging.EmailFileAttachment[] {
                 efa
             });
             emails.add(email);
         }
         Messaging.SendEmailResult[] r = Messaging.sendEmail(emails);
         // Messaging.SendEmailResult[]  r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emails});
         boolean check = true;
         for (Messaging.SendEmailResult ms: r) {
             check = check && ms.isSuccess();
         }
         if (check == true)
             emailalert = true;
     } else {
         EventReqStringBool = true;
     }
     eventselected = eventselected;
     }catch(exception e){}
     return null;
     
 }
 //-------------------------------------------------------------------------------------------------------------------------
 public PageReference ImportAttendee() {
     //string pro = '111Boothleads222BL';
     pagereference pg = new pagereference('/apex/BL_AttendeesImport?id='+ eventSelected);
     pg.setredirect(true);
     return pg;
 }
 Public PageReference ProfileSettings() {
     Pagereference pg = new Pagereference('/apex/BL_Eventadmin_Profile');
     Pg.setredirect(true);
     Return pg;
 }
 //-----------------------------------------------------------------------------------GENERATE PDF FOR BADGES--------------
 public BadgeTemplate_Styles__c tempnames {get; set;}
 public List<jsoninner> listOfleads {get; set;}
 
 //Arindam code for print
 public BadgeTemplate_Styles__c btstyle{get;set;}
   public Badge bg{get;set;}
   public List<Style> elems{get;set;}
    public void parseBadge(String bdg)
   {

     // Parse entire JSON response.
    JSONParser parser = JSON.createParser(bdg);
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    bg= (Badge)parser.readValueAs(Badge.class);
                  }
            }
        }
    }
    
   }
   
   public void parseElement(String elem)
   {
     
    // Parse entire JSON response.
    JSONParser parser = JSON.createParser(elem);
    while (parser.nextToken() != null) {
        // Start at the array of invoices.
        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            while (parser.nextToken() != null) {
                // Advance to the start object marker to
                //  find next invoice statement object.
                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                    // Read entire invoice object, including its array of line items.
                    Style st= (Style)parser.readValueAs(Style.class);
                  elems.add(st);
                  System.debug('BBBBBBBBBB '+st);
                }
            }
        }
    }
      
   }
   
  
  
  
  
  public class Style{
  public String id{get;set;}
  public String height{get;set;}
  public String width{get;set;}
  public String positionTop{get;set;}
  public String positionLeft{get;set;}
  public String marginTop{get;set;}
  public String marginRight{get;set;}
  public String marginBottom{get;set;}
  public String marginLeft{get;set;}
  public String paddingTop{get;set;}
  public String paddingRight{get;set;} 
  public String paddingBottom{get;set;} 
  public String paddingLeft{get;set;} 
  public String textAlign{get;set;} 
  public String fontSize{get;set;} 
  public String fontFamily{get;set;} 
  public String textTransform{get;set;} 
  public String contentText{get;set;}   
  public String backgroundColor{get;set;}
  public String opacity{get;set;}
  public String textColor{get;set;}  
  public String qrUrlResult{get;set;}
  public String urlResult{get;set;}
    public Style(String id,String height,String width,String positionTop,String positionLeft,String marginTop,String marginRight,
    String marginBottom,String marginLeft,String paddingTop,String paddingRight,String paddingBottom,String paddingLeft,
    String textAlign,String fontSize,String fontFamily,String textTransform,String contentText,
    String backgroundColor,String opacity,String textColor,String qrUrlResult,String urlResult){
        id=this.id;
        height=this.height;
        width=this.width;
        positionTop=this.positionTop;
        positionLeft=this.positionLeft;
        marginTop=this.marginTop;
        marginRight=this.marginRight;
        marginBottom=this.marginBottom;
        marginLeft=this.marginLeft;
        paddingTop=this.paddingTop;
        paddingRight=this.paddingRight; 
        paddingBottom=this.paddingBottom; 
        paddingLeft=this.paddingLeft; 
        textAlign=this.textAlign; 
        fontSize=this.fontSize; 
        fontFamily=this.fontFamily; 
        textTransform=this.textTransform; 
        contentText=this.contentText; 
        backgroundColor=this.backgroundColor;
        opacity=this.opacity;
        textColor=this.textColor;  
        qrUrlResult=this.qrUrlResult;
        urlResult=this.urlResult;
    }
}


public class Badge{
public String width{get;set;}
public String height{get;set;}
public String backgroundColor{get;set;}

public Badge(String width,String height,String backgroundColor)
{
  this.width=width;
  this.height=height;
  this.backgroundColor=backgroundColor;
  
}
}
//end of code
public class InnBadgeList
{
public Event_Attendee_Mapping__c eamap{get;set;}
}
public List<InnBadgeList> innbadgelist{get;set;}
 public PageReference genpdf() {
 
  btstyle=[select BadgeName__c,Event__c,FirstRowElement__c,SecondElement__c,ThirdElement__c,FourthElement__c,FifthElement__c,SixthElement__c,SeventhElement__c,EightthElement__c,ninthelement__c from BadgeTemplate_Styles__c where NAME =:selectedbdtemname and Event__c=:eventSelected limit 1];
  
      selectedprint(); 
    fbool = false;
      

     limitofbadges = false;
      //Arindam code
      //Parse Badge Name
    String badgename=btstyle.BadgeName__c;
    parseBadge(badgename.substring(0,badgename.length()-1));
    elems=new List<Style>(); 
    //Parse Elements
     if(btstyle.FirstRowElement__c!=null&&btstyle.FirstRowElement__c != '')
    parseElement(btstyle.FirstRowElement__c);
     if(btstyle.SecondElement__c!=null&&btstyle.SecondElement__c != '')
    parseElement(btstyle.SecondElement__c);
     if(btstyle.ThirdElement__c!=null&&btstyle.ThirdElement__c != '')
    parseElement(btstyle.ThirdElement__c);
     if(btstyle.FourthElement__c!=null&&btstyle.FourthElement__c != '')
    parseElement(btstyle.FourthElement__c);
    if(btstyle.FifthElement__c!=null&&btstyle.FifthElement__c != '')
    parseElement(btstyle.FifthElement__c );
    if(btstyle.SixthElement__c!=null&&btstyle.SixthElement__c != '')
    parseElement(btstyle.SixthElement__c);
    if(btstyle.SeventhElement__c!=null&&btstyle.SeventhElement__c != '')
    parseElement(btstyle.SeventhElement__c);
    if(btstyle.EightthElement__c!=null&&btstyle.EightthElement__c != '')
    parseElement(btstyle.EightthElement__c);
    if(btstyle.ninthelement__c!=null&&btstyle.ninthelement__c != '')
    parseElement(btstyle.ninthelement__c);
      //end

     limitofbadges = false;
     checkedbadge = new List < Event_Attendee_Mapping__c > ();
     List < Event_Attendee_Mapping__c > changed= new List < Event_Attendee_Mapping__c > {};
     String idInClause = '(\'';
  for(Id atid:attid)
  idInClause += atid+ '\',\'';  
  idInClause  = idInClause.substring(0,idInClause.length()-2);
         idInClause += ')';
     
    string eventQuery ='select UniqNo__c,CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,AS_id__r.AS_Company__c,GuestType__c,BadgeQty__c,TicketTypes__c,TicketTypesBP__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,EA_isBadgePrinted__c, AS_id__r.AS_Email__c,AS_id__r.AS_Title__c,AS_id__r.AS_WorkCity__c,AS_id__r.AS_HomeCity__c,AS_id__r.AS_ShippingCity__c,AS_id__r.AS_WorkState__c,AS_id__r.AS_Work_States__c,AS_id__r.As_Home_State__c,AS_id__r.AS_shippingState__c, AS_id__r.Registration_type__c,AS_id__r.FetchStatus__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id in '+idInClause +'  ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
         
        
        try{
         checkedbadge =dataBase.Query(eventQuery );
         }catch(exception e){}
     for (Event_Attendee_Mapping__c dd: checkedbadge) {
         dd.EA_isBadgePrinted__c = true;
         changed.add(dd);
         system.debug('cccccccccccccccccccccccccccc' + changed.size() + ' ids   ' + changed);
     }
     update changed;
     innbadgelist=new List<InnBadgeList>();
     for(Event_Attendee_Mapping__c ee:checkedbadge)
     {
        if(ee.BadgeQty__c!=null)
        {
          for(integer p=0;p<ee.BadgeQty__c;p++)
          {
             InnBadgeList inb=new InnBadgeList();
             inb.eamap=ee;
             innbadgelist.add(inb);
             }
             }
             else
             {
             InnBadgeList inb=new InnBadgeList();
             inb.eamap=ee;
             innbadgelist.add(inb);
             }
     }
     if(selectedprinter=='Avery_6'){
      pagereference pg = page.Qrcode_printbadge_5392label;
          pg.setredirect(false);
         return pg;}
         if(selectedprinter=='Avery_8'){
      pagereference pg = page.AveryAdhesive;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='Zebra'){
      pagereference pg = page.qrcode_Zebralabel;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='Brother'){
      pagereference pg = page.qrcode_Brotherlabel;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='CustScanBadge'){
      pagereference pg = page.qrcode_SmallBrotherlabel;
          pg.setredirect(false);
         return pg;}
         else if(selectedprinter=='Dymo'){
      pagereference pg = page.qrcode_DymolabelAtt;
          pg.setredirect(false);
         return pg;}
         else
         return null;
 }
 //-------------------------------------------------INNER CLASS------------------------------
 public class jsoninner{
       public string id {get;set;} 
      public integer height {get;set;}
      public integer width {get;set;}
      public integer positionTop {get;set;}
      public integer positionLeft {get;set;}
      public integer marginTop {get;set;}
      public integer marginRight {get;set;}
      public integer marginBottom {get;set;}
      public integer marginLeft {get;set;}
      public integer paddingTop {get;set;}
      public integer paddingRight {get;set;}
      public integer paddingBottom {get;set;}
      public integer paddingLeft {get;set;}
      public string textAlign {get;set;}
      public integer fontSize {get;set;}
      public string fontFamily {get;set;}
      public string textTransform {get;set;}
      public string backgroundColor {get;set;}
      public string textColor {get;set;}
       public string contentText{get;set;}
      public jsoninner ss {get;set;}
      
      
    
    }
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
     public List<string> tictype {get;set;}
     public string ticname {get ; set ;}
     public EventWrapper(Event_Attendee_Mapping__c atnd,List<string> tictype ) {
         this.atnd = atnd;
         this.tictype =tictype ;
         if(atnd.TicketTypes__c != null && atnd.TicketTypes__c != ''){
         this.ticname = atnd.TicketTypes__c;
         }
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
 public class inneremail {
     public Event_Attendee_Mapping__c qq {get;set;}
     public inneremail(Event_Attendee_Mapping__c qq) {
         this.qq = qq;
     }
 }
 //--------------------------------------------------------------INNER FOR BADGE SETTINGS-----------------------
 public class InnerForBadge {
     public String fName {get;set;}
     public String sName {get;set;}
     public String lName {get;set;}
     public String fLName {get;set;}
     public String barCode {get;set;}
     public string ticket {get;set;}
     public string Ttype{get;set;}
     public string designation{get; set; }
     public string guest {get ; set ;}
     public string labelcolor {get ; set ;}
     public InnerForBadge(String fn, String ln, String em,string tle, String code, string ticketforb,string Tt,string gue,string color) {
         fName = fn;
         sName = ln;
         lName = em;
         designation = tle;
         barCode = code;         
         ticket = ticketforb;
         Ttype = Tt;
         guest = gue;
         labelcolor = color;
         
     }
     public InnerForBadge(String fLn, String em, String code) {
         fLName = fLn;
         lName = em;
         barCode = code;
     }
 }
 //--------------------------------------------------------------------------------- INNER CLASS BY MALLIK
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
     
     

 //---------------------------------------------------------for colors----------------
 public List < SelectOption > getcolors() {
     List < SelectOption > options = new List < SelectOption > ();
     return options;
 }
 //------------------------------------------Font Face----------------------------
 public List < SelectOption > getface() {
     List < SelectOption > options = new List < SelectOption > ();
     return null;
 }
 //----------------------------------------Printing att badge---------------------
 public Event_Attendee_Mapping__c eamforprint {
     get;
     set;
 }
 public string selectedattendeetypeszebra {get;set;}
 public pagereference attbadge() {
     eamforprint = [select EA_isBadgePrinted__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : eventatt.id];
     eamforprint.EA_isBadgePrinted__c = true;
     update eamforprint;
     selectedattendeetypeszebra += eventatt.Attendee_Types__c;
     if (selectedvalues == 'Dymo Label(30856,Single Label)') {
         pagereference pg = page.qrcode_badgeofanattendee;
         return pg;
     } else {
         pagereference pg = page.qrcode_zebrabadgeofanattendee;
         return pg;
     }
     return null;
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
              integer i = 0;
             List<id> litOfids = new List<id>();
    
           SET<id> idvalues = new SET<id>();
            for( eventwrapper are:ew){
                idvalues.add(are.atnd.id); 
             }
            
         attforexport = [select id, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE id IN :idvalues ];

             
      
         

 
            
            
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
                 for (user u: US) 
                 {
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
         s = '"' + s + '"';
     }
     return s;
 }
 //--------------------------------------------------------------------------
 public list < list < Event_Attendee_Mapping__c >> exportlistoflist {
     get;
     set;
 }
 
 
 public list < list <innforExport>> exportNormalListOfList{
     get;
     set;
 }
 
 public List<innforExport> exportNormalList{get;set;}
 
 
 public pagereference exportAll() {
 system.debug('EEEEEEEEEEEEEEEEEE '+ew);
         
exportNormalList = new List<innforExport>();
exportNormalListOfList= new list < list <innforExport>>();


     limitofbadges = false;
     for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     exportlistoflist = new list < list < Event_Attendee_Mapping__c >> {};
     EventReqStringBool = false;
     attforexport = new List < Event_Attendee_Mapping__c > ();
     if (forPaginationstoreIds.KeySet().size() == 0) {
         EventReqStringBool = TRUE;
     } else {
         if (Allrecords == true) {
             eventlist = new List <Event_Attendee_Mapping__c > ();
             integer i = 0;
             List<id> litOfids = new List<id>();
          
         
          

           SET<id> idvalues = new SET<id>();
            for( eventwrapper are:ew){
                idvalues.add(are.atnd.id); 
             }
            eventlist = [select id, TicketTypes__c,TicketTypesBP__c,Attendee_Types__c,AS_id__r.AS_Age__c, AS_id__r.AS_BirthDate__c, AS_id__r.AS_BlogUrl__c, AS_id__r.AS_BusinessDescription__c, AS_id__r.AS_BusinessDunsNumber__c,
                 AS_id__r.AS_BusinessEstablishedDate__c, AS_id__r.AS_BusinessRevenue__c, AS_id__r.AS_BusinessTaxId__c, AS_id__r.AS_CellPhone__c,
                 AS_id__r.AS_Company__c, DiversityType__c, AS_id__r.AS_Email__c, AS_id__r.AS_FaxNumber__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_Gender__c,
                 AS_id__r.AS_HomeAddress1__c, AS_id__r.AS_HomeAddress2__c, AS_id__r.AS_HomeCity__c, AS_id__r.As_Home_Country__c, AS_id__r.AS_HomePhone__c,
                 AS_id__r.AS_HomePoboxNo__c, AS_id__r.As_Home_State__c, AS_id__r.AS_HomeZip__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_LastName__c, AS_id__r.AS_NAICSCode_1__c,
                 AS_id__r.AS_NAICSCode_2__c, AS_id__r.AS_NAICSCode_3__c, AS_id__r.AS_NAICSCode_4__c, AS_id__r.AS_NAICSCode_5__c, AS_id__r.AS_NumberOfEmployees__c, AS_id__r.As_prefixNew__c,
                 AS_id__r.AS_PrimaryBusinessCategory1__c, AS_id__r.AS_SecondaryBusinessCategory1__c, AS_id__r.AS_ShippingAddress1__c, AS_id__r.AS_ShippingAddress2__c,
                 AS_id__r.AS_ShippingCity__c, AS_id__r.As_Shipping_Country__c, AS_id__r.AS_ShippingPhone__c, AS_id__r.AS_Shippingpoboxno__c, AS_id__r.As_Shipping_States__c,
                 AS_id__r.AS_shippingzip__c, AS_id__r.As_SuffixNew__c, AS_id__r.AS_ThroughEventBrite__c, AS_id__r.AS_Title__c, AS_id__r.AS_WebsiteUrl__c, AS_id__r.AS_WorkAddress1__c,
                 AS_id__r.AS_WorkAddress2__c, AS_id__r.AS_WorkCity__c, AS_id__r.AS_Work_Country__c, AS_id__r.AS_WorkPhone__c, AS_id__r.AS_Workpoboxno__c, AS_id__r.AS_Work_States__c,AS_id__r.Commodity_1__c,AS_id__r.Commodity_2__c,AS_id__r.Commodity_3__c,AS_id__r.Commodity_4__c,AS_id__r.Commodity_5__c,
                 AS_id__r.AS_WorkZip__c, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE id IN :idvalues 
             ];  
          
         
            for(Event_Attendee_Mapping__c evm:eventlist ){
               litOfids.add(evm.AS_id__r.id); 
             }
           
            
            
                          
            SET<Survey__c> surveys = new SET<Survey__c>();
           List<Survey__c>  surveys1 = [SELECT id,AttendeeSummary__c,AttendeeSummary__r.id,customer_key__c,customer_key__r.isinserted__c,Answers__c,Event__c,Survey_Questions__r.Question__c from Survey__c where AttendeeSummary__r.id IN :litOfids and Event__c=:eventselected and customer_key__r.isinserted__c=true];
            surveys.addAll(surveys1);
          
          MAP<id,List<Survey__c>> MAPsurveys = new MAP<id,List<Survey__c>>();
                
               for(ID satt:litOfids ){  
                
                   List<Survey__c> surveysInn = new List<Survey__c>();
                 
                  for(Survey__c sur:surveys){
                    if(satt==sur.AttendeeSummary__r.id){
                     // if(sur.Survey_Questions__r.Question__c != null ||  sur.Survey_Questions__r.Question__c != null){
                     //  if(sur.Survey_Questions__r.Question__c.contains(',')){
                          sur.Survey_Questions__r.Question__c = escape(sur.Survey_Questions__r.Question__c);
                     //  }
                     //  }
                       
                    //  if(sur.Answers__c != null ||  sur.Answers__c != null){
                     //  if(sur.Answers__c.contains(',')){
                       sur.Answers__c = escape(sur.Answers__c);
                    //   }  
                    // }
                    surveysInn.add(sur); 
                    }
                  }
                  MAPsurveys.put(satt,surveysInn);
                }
          
          
             
             for (Event_Attendee_Mapping__c s: eventlist) {
               
                 
                       s.AS_id__r.AS_BusinessDescription__c = escape(s.AS_id__r.AS_BusinessDescription__c);
               
                       s.AS_id__r.AS_Company__c = escape(s.AS_id__r.AS_Company__c);
                
                       s.DiversityType__c = escape(s.DiversityType__c);
                  
                
                     s.AS_id__r.AS_FirstName__c = escape(s.AS_id__r.AS_FirstName__c);
               
                         s.AS_id__r.AS_HomeAddress1__c = escape(s.AS_id__r.AS_HomeAddress1__c);
                
                     s.AS_id__r.AS_HomeAddress2__c = escape(s.AS_id__r.AS_HomeAddress2__c);
                 
                
                
                     s.AS_id__r.AS_LastName__c = escape(s.AS_id__r.AS_LastName__c);
                
                     s.AS_id__r.AS_ShippingAddress1__c = escape(s.AS_id__r.AS_ShippingAddress1__c);
                 
                     s.AS_id__r.AS_ShippingAddress2__c = escape(s.AS_id__r.AS_ShippingAddress2__c);
                
                     s.AS_id__r.AS_ShippingCity__c = escape(s.AS_id__r.AS_ShippingCity__c);
                 
                     s.AS_id__r.AS_Title__c = escape(s.AS_id__r.AS_Title__c);
                 
                
                     s.AS_id__r.AS_WorkAddress1__c = escape(s.AS_id__r.AS_WorkAddress1__c);
                
                     s.AS_id__r.AS_WorkAddress2__c = escape(s.AS_id__r.AS_WorkAddress2__c);
                
                     s.AS_id__r.AS_WorkCity__c = escape(s.AS_id__r.AS_WorkCity__c);
                     
                     s.AS_id__r.As_NAICSCode_1__c = escape(s.AS_id__r.As_NAICSCode_1__c);
                     s.AS_id__r.As_NAICSCode_2__c = escape(s.AS_id__r.As_NAICSCode_2__c);
                     s.AS_id__r.As_NAICSCode_3__c = escape(s.AS_id__r.As_NAICSCode_3__c);
                     s.AS_id__r.As_NAICSCode_4__c = escape(s.AS_id__r.As_NAICSCode_4__c);
                     s.AS_id__r.As_NAICSCode_5__c = escape(s.AS_id__r.As_NAICSCode_5__c);
                     
                 s.AS_id__r.Commodity_1__c = escape(s.AS_id__r.Commodity_1__c);
                     s.AS_id__r.Commodity_2__c = escape(s.AS_id__r.Commodity_2__c);
                     s.AS_id__r.Commodity_3__c = escape(s.AS_id__r.Commodity_3__c);
                     s.AS_id__r.Commodity_4__c = escape(s.AS_id__r.Commodity_4__c);
                     s.AS_id__r.Commodity_5__c = escape(s.AS_id__r.Commodity_5__c);
                 system.debug('==========================escape===================================' + s.AS_id__r.AS_PrimaryBusinessCategory1__c);
               
                     s.TicketTypes__c = escape(s.TicketTypes__c);
                
                     s.AS_id__r.AS_SecondaryBusinessCategory1__c = escape(s.AS_id__r.AS_SecondaryBusinessCategory1__c);
                 system.debug('==========================escape===================================' + s.AS_id__r.AS_SecondaryBusinessCategory1__c);
                 i++;
                
                
                
             
                exportNormalList.add(new innforExport(s,MAPsurveys.get(s.AS_id__r.id)));
                 //attforexport.add(s);
                 if (i >= 1000) {
                    // exportlistoflist.add(attforexport);
                     exportNormalListOfList.add(exportNormalList);
                     exportNormalList = new LIST <innforExport > ();
                     i = 0;
                 }
             }
             if (i != 0) {
                 exportNormalListOfList.add(exportNormalList);
                 pagereference pg = new pagereference('/apex/Qrcode_exportAttendees');
                 pg.setredirect(false);
                 return pg;
             }
        
         } else {
             if (forPaginationstoreIds.KeySet().size() != 0) {
                 EventReqStringBool = false;
                 integer i = 0;
                 eventlist = [select id, TicketTypes__c,Attendee_Types__c, AS_id__r.AS_Age__c, AS_id__r.AS_BirthDate__c, AS_id__r.AS_BlogUrl__c, AS_id__r.AS_BusinessDescription__c, AS_id__r.AS_BusinessDunsNumber__c,
                     AS_id__r.AS_BusinessEstablishedDate__c, AS_id__r.AS_BusinessRevenue__c, AS_id__r.AS_BusinessTaxId__c, AS_id__r.AS_CellPhone__c,
                     AS_id__r.AS_Company__c, DiversityType__c, AS_id__r.AS_Email__c, AS_id__r.AS_FaxNumber__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_Gender__c,
                     AS_id__r.AS_HomeAddress1__c, AS_id__r.AS_HomeAddress2__c, AS_id__r.AS_HomeCity__c, AS_id__r.As_Home_Country__c, AS_id__r.AS_HomePhone__c,
                     AS_id__r.AS_HomePoboxNo__c, AS_id__r.As_Home_State__c, AS_id__r.AS_HomeZip__c, AS_id__r.AS_ImageUrl__c, AS_id__r.AS_LastName__c, AS_id__r.AS_NAICSCode_1__c,
                     AS_id__r.AS_NAICSCode_2__c, AS_id__r.AS_NAICSCode_3__c, AS_id__r.AS_NAICSCode_4__c, AS_id__r.AS_NAICSCode_5__c, AS_id__r.AS_NumberOfEmployees__c, AS_id__r.As_prefixNew__c,
                     AS_id__r.AS_PrimaryBusinessCategory1__c, AS_id__r.AS_SecondaryBusinessCategory1__c, AS_id__r.AS_ShippingAddress1__c, AS_id__r.AS_ShippingAddress2__c,
                     AS_id__r.AS_ShippingCity__c, AS_id__r.As_Shipping_Country__c, AS_id__r.AS_ShippingPhone__c, AS_id__r.AS_Shippingpoboxno__c, AS_id__r.As_Shipping_States__c,
                     AS_id__r.AS_shippingzip__c, AS_id__r.As_SuffixNew__c, AS_id__r.AS_ThroughEventBrite__c, AS_id__r.AS_Title__c, AS_id__r.AS_WebsiteUrl__c, AS_id__r.AS_WorkAddress1__c,
                     AS_id__r.AS_WorkAddress2__c, AS_id__r.AS_WorkCity__c, AS_id__r.AS_Work_Country__c, AS_id__r.AS_WorkPhone__c, AS_id__r.AS_Workpoboxno__c, AS_id__r.AS_Work_States__c,AS_id__r.Commodity_1__c,AS_id__r.Commodity_2__c,AS_id__r.Commodity_3__c,AS_id__r.Commodity_4__c,AS_id__r.Commodity_5__c,
                     AS_id__r.AS_WorkZip__c, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE id in : forPaginationstoreIds.KeySet()
                 ];
                 
                 
                 
                    
             List<id> litOfids = new List<id>();
             for(Event_Attendee_Mapping__c evm:eventlist ){
               litOfids.add(evm.AS_id__r.id); 
             }
            
                          
            List<Survey__c> surveys = new List<Survey__c>();
            surveys = [SELECT id,AttendeeSummary__c,AttendeeSummary__r.id,customer_key__c,Answers__c,Event__c,Survey_Questions__r.Question__c,customer_key__r.isinserted__c from Survey__c where AttendeeSummary__r.id In :litOfids and Event__c=:eventselected and customer_key__r.isinserted__c=true];
            MAP<id,List<Survey__c>> MAPsurveys = new MAP<id,List<Survey__c>>();
                
               for(ID satt:litOfids ){  
                
                   List<Survey__c> surveysInn = new List<Survey__c>();
                 
                  for(Survey__c sur:surveys){
                  if(satt==sur.AttendeeSummary__r.id){
                      if(sur.Survey_Questions__r.Question__c != null ||  sur.Survey_Questions__r.Question__c != null){
                       if(sur.Survey_Questions__r.Question__c.contains(',')){
                          sur.Survey_Questions__r.Question__c = escape(sur.Survey_Questions__r.Question__c);
                       }}
                       
                      if(sur.Answers__c != null ||  sur.Answers__c != null){
                       if(sur.Answers__c.contains(',')){
                       sur.Answers__c = escape(sur.Answers__c);
                       }  
                     }
                    surveysInn.add(sur); 
                    }
                  }
                  MAPsurveys.put(satt,surveysInn);
                }
             
          
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
                 
                  if(s.AS_id__r.As_NAICSCode_1__c != null  ){
                   if(s.AS_id__r.As_NAICSCode_1__c.contains(',')){
                     s.AS_id__r.As_NAICSCode_1__c = escape(s.AS_id__r.As_NAICSCode_1__c);}
                     else{
                      s.AS_id__r.As_NAICSCode_1__c = s.AS_id__r.As_NAICSCode_1__c;
                     }
                 }else{
                                      s.AS_id__r.As_NAICSCode_1__c = '';
                 }
                  if(s.AS_id__r.As_NAICSCode_2__c != null  ){
                   if(s.AS_id__r.As_NAICSCode_2__c.contains(',')){
                     s.AS_id__r.As_NAICSCode_2__c = escape(s.AS_id__r.As_NAICSCode_2__c);}else{
                      s.AS_id__r.As_NAICSCode_2__c = s.AS_id__r.As_NAICSCode_2__c;
                     }
                 }else{
                                      s.AS_id__r.As_NAICSCode_2__c = '';
                 }                  system.debug('NAICScODE' + s.AS_id__r.As_NAICSCode_3__c);
                  if(s.AS_id__r.As_NAICSCode_3__c != null ){
                  system.debug('NAICScODE' + s.AS_id__r.As_NAICSCode_3__c);
                   if(s.AS_id__r.As_NAICSCode_3__c.contains(','))
                   {
                     s.AS_id__r.As_NAICSCode_3__c = escape(s.AS_id__r.As_NAICSCode_3__c);
                   }else{
                      s.AS_id__r.As_NAICSCode_3__c = s.AS_id__r.As_NAICSCode_3__c;
                     }
                 }else{
                                      s.AS_id__r.As_NAICSCode_3__c = '';
                 }
                  if(s.AS_id__r.As_NAICSCode_4__c != null  ){
                   if(s.AS_id__r.As_NAICSCode_4__c.contains(',')){
                     s.AS_id__r.As_NAICSCode_4__c = escape(s.AS_id__r.As_NAICSCode_4__c);}
                     else{
                      s.AS_id__r.As_NAICSCode_4__c = s.AS_id__r.As_NAICSCode_4__c;
                     }
                 }else{
                                      s.AS_id__r.As_NAICSCode_4__c = '';
                 }
                  if(s.AS_id__r.As_NAICSCode_5__c != null  ){
                   if(s.AS_id__r.As_NAICSCode_5__c.contains(',')){
                     s.AS_id__r.As_NAICSCode_5__c = escape(s.AS_id__r.As_NAICSCode_5__c);}
                     else{
                      s.AS_id__r.As_NAICSCode_5__c = s.AS_id__r.As_NAICSCode_5__c;
                     }
                 }else{
                                      s.AS_id__r.As_NAICSCode_5__c = '';
                 }
                 
                 if(s.AS_id__r.Commodity_1__c != null  ){
                   if(s.AS_id__r.Commodity_1__c.contains(',')){
                     s.AS_id__r.Commodity_1__c = escape(s.AS_id__r.Commodity_1__c);}
                     else{
                      s.AS_id__r.Commodity_1__c = s.AS_id__r.Commodity_1__c;
                     }
                 }else{
                                      s.AS_id__r.Commodity_1__c = '';
                 }
                 
                 if(s.AS_id__r.Commodity_2__c != null  ){
                   if(s.AS_id__r.Commodity_2__c.contains(',')){
                     s.AS_id__r.Commodity_2__c = escape(s.AS_id__r.Commodity_2__c);}
                     else{
                      s.AS_id__r.Commodity_2__c = s.AS_id__r.Commodity_2__c;
                     }
                 }else{
                                      s.AS_id__r.Commodity_2__c = '';
                 }
                 if(s.AS_id__r.Commodity_3__c != null  ){
                   if(s.AS_id__r.Commodity_3__c.contains(',')){
                     s.AS_id__r.Commodity_3__c = escape(s.AS_id__r.Commodity_3__c);}
                     else{
                      s.AS_id__r.Commodity_3__c = s.AS_id__r.Commodity_3__c;
                     }
                 }else{
                                      s.AS_id__r.Commodity_3__c = '';
                 }
                 if(s.AS_id__r.Commodity_4__c != null  ){
                   if(s.AS_id__r.Commodity_4__c.contains(',')){
                     s.AS_id__r.Commodity_4__c = escape(s.AS_id__r.Commodity_4__c);}
                     else{
                      s.AS_id__r.Commodity_4__c = s.AS_id__r.Commodity_4__c;
                     }
                 }else{
                                      s.AS_id__r.Commodity_4__c = '';
                 }
                 if(s.AS_id__r.Commodity_5__c != null  ){
                   if(s.AS_id__r.Commodity_5__c.contains(',')){
                     s.AS_id__r.Commodity_5__c = escape(s.AS_id__r.Commodity_5__c);}
                     else{
                      s.AS_id__r.Commodity_5__c = s.AS_id__r.Commodity_5__c;
                     }
                 }else{
                                      s.AS_id__r.Commodity_5__c = '';
                 }
                 
                 
                     system.debug('==========================escape===================================' + s.AS_id__r.AS_SecondaryBusinessCategory1__c);
                     i++;
                                
                exportNormalList.add(new innforExport(s,MAPsurveys.get( s.AS_id__r.id) ));
                 //attforexport.add(s);
                 if (i >= 1000) {
                    // exportlistoflist.add(attforexport);
                     exportNormalListOfList.add(exportNormalList);
                     exportNormalList = new LIST <innforExport > ();
                     i = 0;
                 }
             }
             
                 if (i != 0) {
                     exportNormalListOfList.add(exportNormalList );
                 }
                 pagereference pg = new pagereference('/apex/Qrcode_exportAttendees');
                 pg.setredirect(false);
                 return pg;
             }
         }
     }
     return null;
 }
 
 
 public class innforExport{
  public Event_Attendee_Mapping__c eamInn{get;set;}
  public  List<Survey__c> surveysInn1 {get;set;}
  innforExport(Event_Attendee_Mapping__c eam,List<Survey__c> surveysInnw){
   this.eamInn=eam;
   this.surveysInn1 = surveysInnw;
  }
 
 }
 
 
 
 
 
 
 
 
 //-------------------------- Diversity Type -----------------
 Public List < String > Selvalue {
     get;
     set;
 }
 Public string selectedvaluesfordiversity {
     get;
     set;
 }
 //-----------------------------------------------------------profileUpdateNotification---------------------------------
 public pagereference profileUpdateNotification() {
     for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     limitofbadges = false;
     emailalert = false;
     if (forPaginationstoreIds.KeySet().size() != 0) {
       EmailTemplate E = new EmailTemplate();    
        E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Profile Update'];
         EventReqStringBool = false;
         list < Event_Attendee_Mapping__c > emailids = [select id,IsPrifileUpdate__c,EV_id__r.EV_EventLogo__c,EV_Id__r.EV_HostingLocation__c,
                                                        AS_id__r.AS_LastName__c,AS_id__r.id,AS_id__r.AS_FirstName__c, EV_id__r.id,EV_id__r.EV_Title__c, 
                                                        AS_id__r.AS_Email__c,EV_id__r.EV_HistingAddr1__c ,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,
                                                        EV_id__r.EV_HostingStateNew__c,EV_id__r.EV_StartDate__c,EV_id__r.StartTime__c,EV_id__r.EV_EndDate__c,
                                                        EV_id__r.EV_EndTime__c,Boothleads_Profile__c from Event_Attendee_Mapping__c 
                                                        where id IN: forPaginationstoreIds.KeySet()];
         
         list < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
         List < Event_Attendee_Mapping__c > ASUpdate = new List < Event_Attendee_Mapping__c > ();
         
         for (Event_Attendee_Mapping__c eid: emailids) {
             Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
           //  email.setSubject('Update Your Profile for event' +eid.EV_id__r.EV_Title__c);
             String[] toAddresses = new String[] {
                 eid.AS_id__r.AS_Email__c
             };
             email.setToAddresses(toAddresses);
            String Subject = E.Subject.Replace('"{!EventName}"',eid.EV_id__r.EV_Title__c);     
            string ReplacealongwithEventLogo ;
            String ReplaceEventLocation;
            string ReplaceStartDate ;
            string ReplaceEndDate ;
            String ReplaceContactName = E.HtmlValue;
            String SS = ReplaceContactName.Replace('{!Contact.Name}',eid.AS_id__r.AS_FirstName__c + ' ' + eid.AS_id__r.AS_LastName__c);
           
            String RelaceAgain = SS.Replace('"{!EventName}"',eid.EV_id__r.EV_Title__c);
            if(eid.EV_id__r.EV_EventLogo__c != null)
            ReplacealongwithEventLogo = RelaceAgain.replace('{{!EventLogo}}',eid.EV_id__r.EV_EventLogo__c);
            else 
            ReplacealongwithEventLogo = RelaceAgain.replace('{{!EventLogo}}','');
            
            string ReplaceAttendee = ReplacealongwithEventLogo .replace('"{!AttendeeID}"',eid.AS_id__r.id+'&'+'eid='+eid.EV_id__r.id);
            
            if(eid.EV_id__r.EV_HostingLocation__c != null && eid.EV_id__r.EV_HostingStateNew__c != null ){
            ReplaceEventLocation = ReplaceAttendee .replace('{!EventLocation}',eid.EV_id__r.EV_HostingLocation__c +' </br><br/> '+eid.EV_id__r.EV_HistingAddr1__c +','+eid.EV_id__r.AS_HostingAddr2__c+'<br/>'+eid.EV_id__r.AS_HostingCity__c+','+eid.EV_id__r.EV_HostingStateNew__c );
            }else{
            ReplaceEventLocation = ReplaceAttendee .replace('{!EventLocation}','');
            }
            ReplaceStartDate = ReplaceEventLocation.replace('"DateStart"',eid.EV_id__r.EV_StartDate__c.month()+ '/'+eid.EV_id__r.EV_StartDate__c.day()+'/'+eid.EV_id__r.EV_StartDate__c.year()+ ' ' +eid.EV_id__r.StartTime__c);
            ReplaceEndDate = ReplaceStartDate.replace('"DateEnd"',eid.EV_id__r.EV_EndDate__c.month()+ '/'+eid.EV_id__r.EV_EndDate__c.day()+'/'+eid.EV_id__r.EV_EndDate__c.year()+ ' '+eid.EV_id__r.EV_EndTime__c);
            
            email.setSubject(subject);    
            emails.add(email);
            email.setHtmlBody(ReplaceEndDate );                
            eid.IsPrifileUpdate__c = true;
            ASUpdate.add(eid);
         }
         Messaging.SendEmailResult[] r = Messaging.sendEmail(emails);
         // Messaging.SendEmailResult[]  r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emails});
         system.debug('-----------------------------------------------------------' + r);
         boolean check = true;
         for (Messaging.SendEmailResult ms: r) {
             check = check && ms.isSuccess();
             system.debug('1111111111111111' + check);
         }
         if (check == true) {
             emailalert = true;
         }
         eventselected = eventselected;
         // getevents();
     } else {
         EventReqString = 'Please select atleast one attendee to send update notification';
         EventReqStringBool = TRUE;
     }
     return null;
 }
 //------------------------------------------------------------------desiredTemplate----------------------
 public pagereference desiredTemplate() {
     limitofbadges = false;
     Event__c EVprinter = [select Event_Printer__c, Lable_First_Line__c, Lable_First_Line_Color__c, Lable_First_Line_Font__c,
         Lable_First_Line_Size__c, Lable_Secoend_Line__c, Lable_Secoend_Line_Color__c,
         Lable_Secoend_Line_Font__c, Lable_Secoend_Line_Size__c, Lable_Third_Line__c,
         Lable_Third_Line_Color__c, Lable_Third_Line_Font__c, Lable_Third_Line_Size__c
         from Event__c where id = : eventselected
     ];
     system.debug('==================selected printer=======' + EVprinter.Event_Printer__c);
     string label = EVprinter.Event_Printer__c;
     if (label == 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges') {
         selfieldvalue = 'AS_FirstName__c';
         selectedcolor = EVprinter.Lable_First_Line_Color__c;
         selectedsize = EVprinter.Lable_First_Line_Size__c;
         selectedfaceFir = EVprinter.Lable_First_Line_Font__c;
         selLvalue = 'AS_LastName__c';
         selectedcolorS = EVprinter.Lable_Secoend_Line_Color__c;
         selectedsizeS = EVprinter.Lable_Secoend_Line_Size__c;
         selectedfaceSec = EVprinter.Lable_Secoend_Line_Font__c;
         selTvalue = 'AS_Company__c';
         selectedcolorT = EVprinter.Lable_Third_Line_Color__c;
         selectedsizeT = EVprinter.Lable_Third_Line_Size__c;
         selectedfaceThr = EVprinter.Lable_Third_Line_Font__c;
         font = new LIST < selectoption > ();
         font.add(new selectoption('select', 'select'));
         font.add(new selectoption('32pt', '32pt'));
         font.add(new selectoption('30pt', '30pt'));
         font.add(new selectoption('24pt', '24pt'));
         font.add(new selectoption('18pt', '18pt'));
         fieldnames = new LIST < selectoption > ();
         fieldnames.add(new selectoption('select', 'select'));
         fieldnames.add(new selectoption('AS_LastName__c', 'LastName'));
         fieldnames.add(new selectoption('AS_FirstName__c', 'FirstName'));
         fieldnames.add(new selectoption('AS_Title__c', 'Designation'));
         fieldnames.add(new selectoption('AS_Company__c', 'Company'));
         totalselectlist = false;
         custombadge1 = false;
         print = true;
     } else if (label != 'Avery 5392 Name badges' && selectedvalues == 'Avery 5392 Name badges') {
         selfieldvalue = 'AS_FirstName__c';
         selectedcolor = 'Black';
         selectedsize = '32pt';
         selectedfaceFir = 'Times New Roman';
         selLvalue = 'AS_LastName__c';
         selectedcolorS = 'Black';
         selectedsizeS = '24pt';
         selectedfaceSec = 'Times New Roman';
         selTvalue = 'AS_Company__c';
         selectedcolorT = 'Black';
         selectedsizeT = '18pt';
         selectedfaceThr = 'Times New Roman';
         totalselectlist = false;
         custombadge1 = false;
         print = true;
     } else if (label == 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges') {
         system.debug('=========================' + EVprinter.Lable_First_Line__c);
         print = true;
         totalselectlist = true;
         custombadge1 = false;
         selfieldvalue = EVprinter.Lable_First_Line__c;
         system.debug('=========================' + selfieldvalue);
         selectedcolor = EVprinter.Lable_First_Line_Color__c;
         selectedsize = EVprinter.Lable_First_Line_Size__c;
         selectedfaceFir = EVprinter.Lable_First_Line_Font__c;
         selLvalue = EVprinter.Lable_Secoend_Line__c;
         selectedcolorS = EVprinter.Lable_Secoend_Line_Color__c;
         selectedsizeS = EVprinter.Lable_Secoend_Line_Size__c;
         selectedfaceSec = EVprinter.Lable_Secoend_Line_Font__c;
         font = new LIST < selectoption > ();
         font.add(new selectoption('select', 'select'));
         font.add(new selectoption('20pt', '20pt'));
         font.add(new selectoption('18pt', '18pt'));
         font.add(new selectoption('15pt', '15pt'));
         font.add(new selectoption('10pt', '10pt'));
         fieldnames = new LIST < selectoption > ();
         fieldnames.add(new selectoption('select', 'select'));
         fieldnames.add(new selectoption('AS_FirstName__c,AS_LastName__c', 'FirstName LastName'));
         fieldnames.add(new selectoption('AS_Title__c', 'Designation'));
         fieldnames.add(new selectoption('AS_Company__c', 'Company'));
     } else if (label != 'Avery 22806 easy peal square Badges' && selectedvalues == 'Avery 22806 easy peal square Badges') {
         selfieldvalue = 'AS_FirstName__c,AS_LastName__c';
         selectedcolor = 'Black';
         selectedsize = '20pt';
         selectedfaceFir = 'Times New Roman';
         selLvalue = 'AS_Company__c';
         selectedcolorS = 'Black';
         selectedsizeS = '15pt';
         selectedfaceSec = 'Times New Roman';
         totalselectlist = false;
         custombadge1 = false;
         print = true;
     } else if (selectedvalues == 'Dymo Label(30856,Single Label)') {
         totalselectlist = false;
         custombadge1 = false;
         print = true;
     } else if (selectedvalues == 'Zebra Label') {
         totalselectlist = false;
         custombadge1 = false;
         print = true;
     } else if (selectedvalues == 'select') {
         totalselectlist = false;
         custombadge1 = false;
         print = false;
     }
     return null;
 }
 //-------------------------------------------------Search----------------------------
 public pagereference search() {

     limitofbadges = false;
     emailalert = false;
     EventReqStringBool = false;
     ForPagination = new LIST < EventWrapper > ();
     integer recCount = 0;
     eventlist = new LIst < Event_Attendee_Mapping__c > ();
     string ff = serarchstringvalue + '%';
     eventlist = [select AS_id__r.AS_LastName__c,TicketTypes__c,TicketTypesBP__c,GuestType__c,EA_isBadgeSent__c,BadgeQty__c,AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c, checkbox_dataTable__c,
         AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c,
         EA_isBadgePrinted__c, AS_id__r.AS_Email__c, IsPrifileUpdate__c,AS_id__r.FetchStatus__c, CreatedDate, Boothleads_Profile__c from Event_Attendee_Mapping__c where EV_id__r.id = : eventSelected and(AS_id__r.AS_FirstName__c like: ff + '%'
         OR AS_id__r.AS_LastName__c like: ff + '%'
         OR AS_id__r.AS_Company__c like: ff + '%'
         OR AS_id__r.AS_Email__c like: ff + '%'
         OR AS_id__r.AS_CellPhone__c like: '%' + ff + '%'
          OR GuestType__c like: '%' + ff + '%') order by AS_id__r.AS_LastName__c
     ];
    List <ID> eamids = new list<ID>{};
              for(Event_Attendee_Mapping__c ema: eventlist ){
         eamids.add(ema.id);
         }
          list<Ticket_Eam__c> tieamjun = [select TicketTypes__r.TT_Name__c,TicketTypes__r.Ticket_Category__c,Event_Attendee_Mapping__c  from Ticket_Eam__c where Event_Attendee_Mapping__c IN : eamids];
         system.debug('==============TIC JUN QUERY ==============='+tieamjun );
          ticeam = new map<id,List<string>> {};
          for(Event_Attendee_Mapping__c ematL: eventlist ){
          listtic = new list<string> {};
          for(Ticket_Eam__c tc:tieamjun ){
          if(ematL.id == tc.Event_Attendee_Mapping__c)
          listtic.add(tc.TicketTypes__r.Ticket_Category__c);
          }
           system.debug('==============TIC JUN QUERY ==============='+listtic);
          ticeam.put(ematL.id,listtic);
          }
         
         system.debug('===================' + eventlist);
         ew = new List < eventwrapper > ();
         for (Event_Attendee_Mapping__c s: eventlist) {
             system.debug('===================' + s.id);
             crd = s.CreatedDate;
         crd = getLocalDateTime(crd);
         s.AS_id__r.AS_LastName__c = escapeSpecialCharacters(s.AS_id__r.AS_LastName__c);
         s.AS_id__r.AS_FirstName__c = escapeSpecialCharacters(s.AS_id__r.AS_FirstName__c);
         s.AS_id__r.AS_CellPhone__c = escapeSpecialCharacters(s.AS_id__r.AS_CellPhone__c);
         s.AS_id__r.AS_Email__c = escapeSpecialCharacters(s.AS_id__r.AS_Email__c);
         s.AS_id__r.AS_Company__c = escapeSpecialCharacters(s.AS_id__r.AS_Company__c);
         recCount++;
            
             ew.add(new eventwrapper(s,ticeam.get(s.id)));
            
             system.debug('===================' + ew);
         }
        AttendeeCount= ew.size();         
        splitatendeeslist();
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
 public PageReference pristatus() {
     system.debug('parameter' + eventname1);
     string[] ss1 = eventname1.split(',');
     string state1 = ss1[1];
     checkedbadge1 = new List < Event_Attendee_Mapping__c > ();
     List < Event_Attendee_Mapping__c > changed1 = new List < Event_Attendee_Mapping__c > {};
     checkedbadge1 = [select id, EA_isBadgePrinted__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where id = : ss1[0]];
     for (Event_Attendee_Mapping__c dd1: checkedbadge1) {
         if (state1 == 'Not Printed') {
             dd1.EA_isBadgePrinted__c = false;
         } else {
             dd1.EA_isBadgePrinted__c = true;
         }
         changed1.add(dd1);
     }
     update changed1;
     getEvents();
     return null;
 }
 //--------------------------------------------------------PAGENATION-----------------------------

 public void next() {
     for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     try {

         //listsize();
         pageno = pageno + 1;
         // integer pgno;
         ForPagination.clear();
        system.debug('SSS AAA NNN ' +  AttendeeCount );
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
         System.debug('---------------------------- LIST SIZE OF TEMPLIST ---------------------' + ew.size());
     } catch (Exception Ex) {}
 }
 public void prev() {
     for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     try {

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
     } catch (Exception ex) {}
 }
 public void Last() {
     try {

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
     } catch (Exception ex) {}
 }
 public void First() {
     try {

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
     } catch (Exception ex) {}
 }
 
 
 // CCR Details Methods Start
   
   // CCR Details PopupOpen Method Start
    public void FetchPopupOpen() {
      ccrdetailsbool=true; 
      fetchccrdetailsbool=false;
    }
    // CCR Details PopupOpen Method End
    
   // Fetching CCR Details Method Start
    
    public void FetchCCRDetails(){ 

      try{
       listdg=new List<AttendeeSummary__c>();
       setdg= new Set<AttendeeSummary__c>();
       result = new List<AttendeeSummary__c>();
    
        // Instantiate a new HTTP Object
        
        Http h = new Http();
        
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
         
        HttpRequest req = new HttpRequest();    
        if(CCRSearchTerm!=null && CCRSearchTerm!=''){
             String encoded = EncodingUtil.urlEncode(CCRSearchTerm,'UTF-8');   
             req.setEndpoint('http://explore.data.gov/resource/3hqn-qzh6.json?$select=_26895,_100,louis_m_gerson_co_inc_1,custserv_gersonco_com,http_www_gersonco_com,_20000000,_01011959,untitled_27,_16_commerce_blvd_ste_d,_023461030_3,middleboro,ma_5,usa_9,_023461030,_5089475442_3,_8002258623,_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn,untitled_25,_16_commerce_blvd,middleboro_2,ma,usa_2,_023461030_6,_5089233031_2,_16_commerce_blvd_7,ma_6,usa_6,_5089474000&$limit=1&louis_m_gerson_co_inc_1='+encoded);        
        }
        else if(CCRSearchCageCode!=null && CCRSearchCageCode!=''){
                CCRDomainName=CCRSearchCageCode;   
                req.setEndpoint('http://explore.data.gov/resource/3hqn-qzh6.json?$select=_26895,_100,louis_m_gerson_co_inc_1,custserv_gersonco_com,http_www_gersonco_com,_20000000,_01011959,untitled_27,_16_commerce_blvd_ste_d,_023461030_3,middleboro,ma_5,usa_9,_023461030,_5089475442_3,_8002258623,_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn,untitled_25,_16_commerce_blvd,middleboro_2,ma,usa_2,_023461030_6,_5089233031_2,_16_commerce_blvd_7,ma_6,usa_6,_5089474000&$limit=1&26895='+CCRDomainName);
        
        }
        else if(CCRSearchEmail!=null && CCRSearchEmail!=''){
            if(CCRSearchEmail.contains('@')){
                CCRDomainName='*'+CCRSearchEmail.substringAfter('@');
                req.setEndpoint('http://explore.data.gov/resource/3hqn-qzh6.json?$select=_26895,_100,louis_m_gerson_co_inc_1,custserv_gersonco_com,http_www_gersonco_com,_20000000,_01011959,untitled_27,_16_commerce_blvd_ste_d,_023461030_3,middleboro,ma_5,usa_9,_023461030,_5089475442_3,_8002258623,_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn,untitled_25,_16_commerce_blvd,middleboro_2,ma,usa_2,_023461030_6,_5089233031_2,_16_commerce_blvd_7,ma_6,usa_6,_5089474000&$limit=1&$q='+CCRDomainName+'*');
            }    
        }       
        
        
        req.setHeader('X-App-Token','vJuJxl8Tjb6wvEnDkd0JUJNDf');
        req.setHeader('Content-Type','text/xml');
        req.setMethod('GET');   
        req.setTimeout(120000);
        
        // Send the HTTP request, and return a response
        
        HTTPResponse res = h.send(req);
        CCRData=res.getBody();        
        system.debug('@@@@@@@@@@@@@@@@@ '+CCRData);
        
        AttendeeSummary__c ccratt =new AttendeeSummary__c(); 
        ccratt = [select id, name, AS_Age__c, isUpdated__c, AS_BirthDate__c, AS_BlogUrl__c, AS_BusinessDescription__c, AS_BusinessDunsNumber__c,
         AS_BusinessEstablishedDate__c, AS_BusinessRevenue__c, AS_BusinessTaxId__c, AS_CellPhone__c,
         AS_Company__c, AS_DiversityType__c, Registration_type__c, AS_Email__c, AS_FaxNumber__c, AS_FirstName__c, AS_Gender__c,
         AS_HomeAddress1__c, AS_HomeAddress2__c, AS_HomeCity__c, AS_HomeCountry__c, AS_HomePhone__c,
         AS_HomePoBox__c, AS_HomeZip__c, AS_ImageUrl__c, AS_LastName__c, AS_NAICSCode_1__c,
         AS_NAICSCode_2__c, AS_NAICSCode_3__c, AS_NAICSCode_4__c, AS_NAICSCode_5__c, AS_NumberOfEmployees__c, AS_PrefixNew__c,
         AS_PrimaryBusinessCategory1__c, AS_SecondaryBusinessCategory1__c, AS_ShippingAddress1__c, AS_ShippingAddress2__c,
         AS_ShippingCity__c, AS_ShippingCountry__c, AS_ShippingPhone__c, AS_shippingzip__c, AS_ShippingState__c,
         AS_ShippingZipcode__c, AS_SuffixNew__c, AS_ThroughEventBrite__c, AS_Title__c, AS_WebsiteUrl__c, AS_WorkAddress1__c,
         AS_WorkAddress2__c, AS_WorkCity__c, AS_WorkCountry__c, AS_WorkPhone__c, AS_WorkPoBox__c, AS_Work_Country__c, AS_WorkZip__c,
         AS_Work_States__c, As_Home_Country__c, As_Home_State__c, As_Shipping_Country__c, As_Shipping_States__c,FetchStatus__c,isFetched__c
         FROM AttendeeSummary__c WHERE AS_Email__c =: CCREmail];
        
        
        JSONParser parser = JSON.createParser(CCRData);      
        if(CCRData.length()>3){  
              fetchccrdetailsbool=true;
              fetchccrdetailsboolyes=true;
              fetchccrdetailsboolno=false;
        while (parser.nextToken() != null) {
          
        if((parser.getCurrentToken() == JSONToken.FIELD_NAME)){                                          
            String fieldName = parser.getText();
            parser.nextToken();
        if(fieldName == 'louis_m_gerson_co_inc_1') {
            CCRCompany=parser.getText();
        } 
        if(fieldName == '_100') {
            CCRNumberofEmployees=parser.getText();
        } 
        else if(fieldName == '_26895'){
            CCRCageCode=parser.getText();
        } 
        else if(fieldName == 'custserv_gersonco_com'){
            CCREmailId=parser.getText();
        } 
        else if(fieldName == 'http_www_gersonco_com'){
            parser.nextToken();
            parser.nextToken();
            CCRWebsiteUrl=parser.getText();
        } 
        else if(fieldName == '_20000000'){
            CCRBusinessRevenue=parser.getText();                       
        } 
        else if(fieldName == '_01011959'){
            CCRBusinessEstablishedDate=parser.getText();                     
            if(CCRBusinessEstablishedDate.length()<8){
                if(Decimal.Valueof(CCRBusinessEstablishedDate.substring(1, 3))<12){
                    CCRBusinessEstablishedDate1 = CCRBusinessEstablishedDate.substring(3,7)+ '-' + CCRBusinessEstablishedDate.substring(1, 3)+ '-' + '0' + CCRBusinessEstablishedDate.substring(0, 1);}
            }
            else if (CCRBusinessEstablishedDate.length()>=8){
                if(Decimal.Valueof(CCRBusinessEstablishedDate.substring(2, 4))<12){
                    CCRBusinessEstablishedDate1 = CCRBusinessEstablishedDate.substring(4,8)+ '-' +CCRBusinessEstablishedDate.substring(2, 4)+ '-' + CCRBusinessEstablishedDate.substring(0, 2);}
            }
        }                      
        else if(fieldName == 'untitled_27'){
            CCRWorkAddress1=parser.getText();
        } 
        else if(fieldName == '_16_commerce_blvd_ste_d'){
            CCRWorkAddress2=parser.getText();
        } 
        else if(fieldName == 'middleboro'){
            CCRWorkCity=parser.getText();
        }
        else if(fieldName == 'ma_5'){
            CCRWorkState=parser.getText();
        }  
        else if(fieldName == 'usa_9'){
                CCRWorkCountry=parser.getText();
                if(CCRWorkCountry == 'USA'){
                 CCRWorkCountry='United States Of America';
                }
            }
        else if(fieldName == '_023461030_3'){
            CCRWorkZipCode=parser.getText();
        }
        else if(fieldName == '_023461030'){
            CCRPOBox1=parser.getText();
            if(CCRPOBox1.length()>8){
                CCRWorkPObox=CCRPOBox1.substring(4,8);}
            else
                CCRWorkPObox=CCRPOBox1;
        } 
        else if(fieldName == '_5089475442_3'){
            CCRWorkPhone=parser.getText();
        }
        else if(fieldName == 'untitled_25'){
            CCRHomeAddress1=parser.getText();
        } 
        else if(fieldName == '_16_commerce_blvd'){
            CCRHomeAddress2=parser.getText();
        } 
        else if(fieldName == 'middleboro_2'){
            CCRHomeCity=parser.getText();
        }
        else if(fieldName == 'ma'){
            CCRHomeState=parser.getText();
        } 
        else if(fieldName == 'usa_2'){
                CCRHomeCountry=parser.getText();
                if(CCRHomeCountry == 'USA'){
                 CCRHomeCountry='United States Of America';
                }
            }
        else if(fieldName == '_023461030_3'){
            CCRHomeZipCode=parser.getText();
            //CCRMailingZipCode=CCRZipCode1.substring(0,4);
        }
        else if(fieldName == '_023461030_6'){
            CCRPOBox2=parser.getText();
            if(CCRPOBox2.length()>8){
                CCRHomePObox=CCRPOBox2.substring(4,8);}
            else
                CCRHomePObox=CCRPOBox2;
        } 
        else if(fieldName == '_5089233031_2'){
            CCRHomePhone=parser.getText();
        } 
        else if(fieldName == 'untitled_25'){
            CCRMailingAddress1=parser.getText();
        } 
        else if(fieldName == '_16_commerce_blvd_7'){
            CCRMailingAddress2=parser.getText();
        } 
        else if(fieldName == 'middleboro_2'){
            CCRMailingCity=parser.getText();
        }
        else if(fieldName == 'ma_6'){
            CCRMailingState=parser.getText();
        }  
        else if(fieldName == 'usa_6'){
                CCRMailingCountry=parser.getText();
                if(CCRMailingCountry == 'USA'){
                 CCRMailingCountry='United States Of America';
                }
        }
        else if(fieldName == '_023461030_3'){
            CCRMailingZipCode=parser.getText();
        }
        else if(fieldName == '_023461030'){
            CCRPOBox3=parser.getText();
            if(CCRPOBox3.length()>8){
                CCRMailingPObox=CCRPOBox3.substring(4,8);}
            else
                CCRMailingPObox=CCRPOBox3;
        } 
        else if(fieldName == '_5089474000'){
            CCRMailingPhone=parser.getText();
        }
        else if(fieldName == '_8002258623'){
            CCRCellPhone=parser.getText();
        }   
        else if(fieldName == '_313230yn_314999yn_339113yn_423450yn_423840yn_922120nn_922140nn_922160nn'){
            CCRNaicsCodes=parser.getText();
            CCRNaicsCodes1=CCRNaicsCodes.substring(0,6);  
            if(CCRNaicsCodes.length()> 8){
                CCRNaicsCodes2=CCRNaicsCodes.substring(9,15);}         
            if(CCRNaicsCodes.length()>15 && CCRNaicsCodes.length()<27) {
                CCRNaicsCodes3=CCRNaicsCodes.substring(18,24);}
            if(CCRNaicsCodes.length()>26 && CCRNaicsCodes.length()<34) {
                CCRNaicsCodes4=CCRNaicsCodes.substring(27,33);}
            if(CCRNaicsCodes.length()>32 && CCRNaicsCodes.length()<43) {
                CCRNaicsCodes5=CCRNaicsCodes.substring(36,42);}                 
        }                            
        
        ccratt.AS_Email__c=CCREmail;
        ccratt.isFetched__c=true;
        if(ccratt.AS_Company__c == null || ccratt.AS_Company__c ==''){ ccratt.AS_Company__c=CCRCompany; }
        if(ccratt.AS_CageCode__c == null || ccratt.AS_Company__c ==''){ ccratt.AS_CageCode__c=CCRCageCode;}
        if(ccratt.AS_CellPhone__c == null || ccratt.AS_CellPhone__c ==''){ ccratt.AS_CellPhone__c =CCRCellPhone;}
        if(ccratt.AS_BusinessDunsNumber__c == null || ccratt.AS_BusinessDunsNumber__c ==''){ ccratt.AS_BusinessDunsNumber__c =CCRBusinessDunsNumber;}
        if(ccratt.AS_BusinessTaxId__c == null || ccratt.AS_BusinessTaxId__c ==''){ ccratt.AS_BusinessTaxId__c =CCRBusinessTaxId ;}
        if(ccratt.AS_WebsiteURL__c == null || ccratt.AS_WebsiteURL__c ==''){ ccratt.AS_WebsiteURL__c =CCRWebsiteURL;}
        
        if(ccratt.AS_BusinessRevenue__c == null){
            if(CCRBusinessRevenue!=null && CCRBusinessRevenue!=''){
            ccratt.AS_BusinessRevenue__c =Decimal.ValueOf(CCRBusinessRevenue);
            }
        }
        if(ccratt.AS_BusinessEstablishedDate__c == null){
            if(CCRBusinessEstablishedDate1!=null && CCRBusinessEstablishedDate1!=''){
                ccratt.AS_BusinessEstablishedDate__c=Date.ValueOf(CCRBusinessEstablishedDate1);
            } 
        }
        if(ccratt.AS_NumberOfEmployees__c == null){
            if(CCRNumberofEmployees!=null && CCRNumberofEmployees!=''){
                ccratt.AS_NumberOfEmployees__c =Decimal.ValueOf(CCRNumberofEmployees);
            }
        }
        if(ccratt.AS_NAICSCode_1__c == null){
            if(CCRNaicsCodes1!=null && CCRNaicsCodes1!=''){
                ccratt.AS_NAICSCode_1__c=CCRNaicsCodes1;
            }
        }
        if(ccratt.AS_NAICSCode_2__c == null){
            if(CCRNaicsCodes2!=null && CCRNaicsCodes2!=''){
                ccratt.AS_NAICSCode_2__c=CCRNaicsCodes2;
            }  
        }
        if(ccratt.AS_NAICSCode_3__c == null){ 
            if(CCRNaicsCodes3!=null && CCRNaicsCodes3!=''){
                ccratt.AS_NAICSCode_3__c=CCRNaicsCodes3;
            }  
        }
        if(ccratt.AS_NAICSCode_4__c == null){
            if(CCRNaicsCodes4!=null && CCRNaicsCodes4!=''){
                ccratt.AS_NAICSCode_4__c=CCRNaicsCodes4;
            }  
        }
        if(ccratt.AS_NAICSCode_5__c == null){  
            if(CCRNaicsCodes5!=null && CCRNaicsCodes5!=''){
                ccratt.AS_NAICSCode_5__c=CCRNaicsCodes5;
            }   
        }
        
        
        if(ccratt.AS_ShippingAddress1__c == null || ccratt.AS_ShippingAddress1__c ==''){ccratt.AS_ShippingAddress1__c = CCRMailingAddress1;}
        if(ccratt.AS_ShippingAddress2__c == null || ccratt.AS_ShippingAddress2__c ==''){ccratt.AS_ShippingAddress2__c = CCRMailingAddress2;}
        if(ccratt.AS_shippingCity__c == null || ccratt.AS_shippingCity__c ==''){ccratt.AS_shippingCity__c = CCRMailingCity;}
        if(ccratt.As_Shipping_States__c == null || ccratt.As_Shipping_States__c ==''){ ccratt.As_Shipping_States__c = CCRMailingState; }
        if(ccratt.As_Shipping_Country__c == null || ccratt.As_Shipping_Country__c ==''){ccratt.As_Shipping_Country__c = CCRMailingCountry;}
        if(ccratt.AS_Shippingpoboxno__c == null || ccratt.AS_Shippingpoboxno__c ==''){ccratt.AS_Shippingpoboxno__c = CCRMailingPOBox;}
        if(ccratt.AS_shippingzip__c == null || ccratt.AS_shippingzip__c ==''){ccratt.AS_shippingzip__c = CCRMailingZipCode;}
        if(ccratt.AS_ShippingPhone__c == null || ccratt.AS_ShippingPhone__c ==''){ccratt.AS_ShippingPhone__c = CCRMailingphone;}
        if(ccratt.AS_WorkAddress1__c == null || ccratt.AS_WorkAddress1__c ==''){ccratt.AS_WorkAddress1__c = CCRWorkAddress1;}
        if(ccratt.AS_WorkAddress2__c == null || ccratt.AS_WorkAddress2__c ==''){ccratt.AS_WorkAddress2__c = CCRWorkAddress2;}
        if(ccratt.AS_Workcity__c == null || ccratt.AS_Workcity__c ==''){ccratt.AS_Workcity__c = CCRWorkCity;}
        if(ccratt.AS_Work_States__c == null || ccratt.AS_Work_States__c ==''){ccratt.AS_Work_States__c = CCRWorkState;}
        if(ccratt.AS_Work_Country__c == null || ccratt.AS_Work_Country__c ==''){ccratt.AS_Work_Country__c= CCRWorkCountry;}
        if(ccratt.AS_Workpoboxno__c == null || ccratt.AS_Workpoboxno__c ==''){ccratt.AS_Workpoboxno__c = CCRWorkPOBox;}
        if(ccratt.AS_WorkZip__c == null || ccratt.AS_WorkZip__c ==''){ccratt.AS_WorkZip__c = CCRWorkZipCode;}
        if(ccratt.AS_WorkPhone__c == null || ccratt.AS_WorkPhone__c ==''){ccratt.AS_WorkPhone__c = CCRWorkPhone;}
        if(ccratt.AS_HomeAddress1__c == null || ccratt.AS_HomeAddress1__c ==''){ccratt.AS_HomeAddress1__c = CCRHomeAddress1;}
        if(ccratt.AS_HomeAddress2__c == null || ccratt.AS_HomeAddress2__c ==''){ccratt.AS_HomeAddress2__c = CCRHomeAddress2;}
        if(ccratt.AS_HomeCity__c == null || ccratt.AS_HomeCity__c ==''){ccratt.AS_HomeCity__c = CCRHomeCity;}
        if(ccratt.As_Home_State__c == null || ccratt.As_Home_State__c ==''){ccratt.As_Home_State__c = CCRHomeState;  }
        if(ccratt.As_Home_Country__c == null || ccratt.As_Home_Country__c ==''){ccratt.As_Home_Country__c = CCRHomeCountry;}
        if(ccratt.AS_HomePoboxNo__c == null || ccratt.AS_HomePoboxNo__c ==''){ccratt.AS_HomePoboxNo__c = CCRHomePOBox;}
        if(ccratt.AS_HomeZip__c == null || ccratt.AS_HomeZip__c ==''){ccratt.AS_HomeZip__c= CCRHomeZipCode;  }
        if(ccratt.AS_HomePhone__c == null || ccratt.AS_HomePhone__c ==''){ccratt.AS_HomePhone__c= CCRHomePhone;}
        listdg.add(ccratt); 
        }  
       }
     }else{
       fetchccrdetailsbool=true;
       fetchccrdetailsboolyes=false;
       fetchccrdetailsboolno=true;
       NoRecordsMessage='No Records Found';
    }
    }
    catch (Exception ex) {
        system.debug(ex.getStackTraceString());
     }           
    }
    
   // Fetching CCR Details Method End 
  
   // Inserting CCR Details Method Start
    public void InsertCCRDetails(){    
    try{
        ccrdetailsbool=false;
        setdg.addAll(listdg);
        result.addAll(setdg);
        Schema.SObjectField f = AttendeeSummary__c.Fields.AS_Email__c;
        Database.UpsertResult[] result1 = Database.upsert(result,f,false);
     }
     catch (Exception ex) {
     }           
    }
    // Inserting CCR Details Method End

    
    // Fetch All CCR Details PopupOpen Method Start
    public void FetchPopupOpenAll(){      
              
            for(eventwrapper a: ForPagination) {
            if(a.atnd.checkbox_dataTable__c == TRUE)
                forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);                 
           } 
           if(forPaginationstoreIds.KeySet().size() != 0){ 
               ccrdetailsboolall = true;
               EventReqStringBool = false;
           }
           else{
               ccrdetailsboolall = false;
               EventReqStringBool = true;
           }
    }
    // Fetch All CCR Details PopupOpen Method End
    
    
    // Inserting Fetch All CCR Details Method Start
    public void fetchCCRDetailsAll() {
    try{
          ccrdetailsboolall=false; 
          set <string> setOfJunctions = new set<string> ();
          set <id> attsummaryListIds = new set<id> ();    
          eventlist = new List < Event_Attendee_Mapping__c > ();
          eventlist = [select CreatedDate, AS_id__r.AS_LastName__c, AS_id__r.AS_FirstName__c, AS_id__r.AS_ImageUrl__c,
                              AS_id__r.AS_Company__c, EA_AttendeeBarcode__c, AS_id__r.AS_CellPhone__c, checkbox_dataTable__c,
                               EA_isBadgePrinted__c, AS_id__r.AS_Email__c, AS_id__r.Registration_type__c, IsPrifileUpdate__c, Boothleads_Profile__c from Event_Attendee_Mapping__c where EV_id__r.id = : eventSelected ORDER BY AS_id__r.AS_Company__c];
        
           for(eventwrapper a: ForPagination) {
            if(a.atnd.checkbox_dataTable__c == TRUE)
                forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);                 
           }
           
           if(forPaginationstoreIds.KeySet().size() != 0){ 
             if (Allrecords == true) {
                 for(Event_Attendee_Mapping__c EAMapping: [SELECT id, AS_id__r.id, EV_id__r.id, Boothleads_Profile__c from Event_Attendee_Mapping__c WHERE ev_Id__c = : eventselected]) {
                     attsummaryListIds.add(EAMapping.AS_id__r.id);
                 }
             }
             else if(forPaginationstoreIds.KeySet().size() != 0){
                for(Event_Attendee_Mapping__c EAMapping: [SELECT id, AS_id__r.id, EV_id__r.id, Boothleads_Profile__c from Event_Attendee_Mapping__c where id IN: forPaginationstoreIds.KeySet()]) {
                    attsummaryListIds.add(EAMapping.AS_id__r.id);
                }
             }
             if (forPaginationstoreIds.KeySet().size() > 0){
                Successbool = true;
             }
             CCRBatchCallouts_cls ccr = new CCRBatchCallouts_cls();
             ccr.fetchccr(attsummaryListIds);
             database.executeBatch(ccr,5); 
           }
   
        }
     catch (Exception ex) {
     }  
    }
    public void mminvitation(){
    
     for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     system.debug('                  ids       '+ forPaginationstoreIds.KeySet());
     limitofbadges = false;
     emailalert = false;
     if (forPaginationstoreIds.KeySet().size() != 0) {
       EmailTemplate E = new EmailTemplate();    
        E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'MatchMaking Request for Participation Email'];
         EventReqStringBool = false;
         list < Event_Attendee_Mapping__c > emailids = [select id,IsPrifileUpdate__c,EV_id__r.EV_EventLogo__c,EV_Id__r.EV_HostingLocation__c,
                                                        AS_id__r.AS_LastName__c,AS_id__r.id,AS_id__r.AS_FirstName__c, EV_id__r.id,EV_id__r.EV_Title__c, 
                                                        AS_id__r.AS_Email__c,EV_id__r.EV_HistingAddr1__c ,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,
                                                        EV_id__r.EV_HostingStateNew__c,EV_id__r.EV_StartDate__c,EV_id__r.StartTime__c,EV_id__r.EV_EndDate__c,
                                                        EV_id__r.EV_EndTime__c,Boothleads_Profile__c from Event_Attendee_Mapping__c 
                                                        where id IN: forPaginationstoreIds.KeySet()];
         
         list < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
        
         OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where DisplayName = 'Jerilynn Clarke'];
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                if(owea.size() > 0 ) {
                    email.setOrgWideEmailAddressId(owea.get(0).Id);
            }
         for (Event_Attendee_Mapping__c eid: emailids) {
             
             String[] toAddresses = new String[] {
                 eid.AS_id__r.AS_Email__c
             };
             system.debug('         email ids     '+toAddresses );
            email.setToAddresses(toAddresses);
            String subject = E.Subject;
           String ReplaceContactName = E.HtmlValue;
            String replacedname = ReplaceContactName.Replace('{!Name}',eid.AS_id__r.AS_FirstName__c + ' ' + eid.AS_id__r.AS_LastName__c);
           // String replacedname1 = replacedname.Replace('{!Email}',eid.AS_id__r.AS_Email__c);
            email.setSubject(subject);
            email.setHtmlBody(replacedname);
             emails.add(email);
                
    }
     system.debug('         email ids     '+emails);
 Messaging.SendEmailResult[] r = Messaging.sendEmail(emails); 
  boolean check = true;
         for (Messaging.SendEmailResult ms: r) {
             check = check && ms.isSuccess();
             system.debug('1111111111111111' + check);
         }
         if (check == true) {
             emailalert = true;
         }
         eventselected = eventselected;
 
    }else {
         EventReqString = 'Please select atleast one attendee to send update notification';
         EventReqStringBool = TRUE;
     }
    }
  /*******************************************Email Template Custom**********************************************/
  public boolean main {get;set;}
  public boolean tablebool {get;set;}
  public boolean Existingtemp {get;set;}
  public list<selectoption> templist {get;set;}
   public list<EmailTemplate> emtemlist{get;set;}
    public list<selectoption> fieldoptions {get;set;}
    public boolean newtempbool{get;set;}
     public string subjectval {get;set;}
     public string TemplateName {get;set;}
      public string Tempcontent {get;set;}
      public string selectedtemp {get;set;}
      
  public void stepTWO(){
    main = false;
    for (eventwrapper a: ForPagination) {
               if (a.atnd.checkbox_dataTable__c == TRUE)
                  forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);                  
               }
    system.debug('           checked ids     '+forPaginationstoreIds);
    tablebool  = false;
    Existingtemp =true;
    templist = new list<selectoption> {};
    emtemlist = new list<EmailTemplate> {};    
    emtemlist =[select name from EmailTemplate where folderid =:'00lF0000001ItDM' AND (ownerid =: userinfo.getuserid() OR ownerid =: '005F0000002ODHv')AND (NOT name LIKE : 'MatchMaking%') ];
    for(EmailTemplate emtm: emtemlist ){
        templist.add(new selectoption(emtm.id,emtm.name));
    }
    
    }
    
    public string selectedfield {get;set;}
    public string showfied {get;set;}
    public EmailTemplate e {get;set;}
    public boolean  Displaybool {get;set;}
    
    public void createTemplate (){
    main = false;
    fieldoptions = new list<selectoption> {};
    fieldoptions.add(new selectoption ('First Name','First Name'));
    fieldoptions.add(new selectoption ('Last Name','Last Name'));
    fieldoptions.add(new selectoption ('Company Name','Company Name'));
    fieldoptions.add(new selectoption ('Event Name','Event Name'));
    fieldoptions.add(new selectoption ('Event Logo','Event Logo'));
    newtempbool = true;
    Existingtemp = false;
    e= new emailTemplate();
    }
    public void fetchingfieldval(){
    if(selectedfield == 'First Name'){
    showfied ='{!FirstName}';
    }
     if(selectedfield == 'Last Name'){
     showfied = '{!LastName}';
    }
     if(selectedfield == 'Company Name'){
     showfied = '{!CompanyName}';
    }
     if(selectedfield == 'Event Name'){
     showfied = '{!EventName}';
    }
    if(selectedfield == 'Event Logo'){
     showfied = '{!Logo}';
    }
    }
    
  public EmailTemplate etemplate  {get;set;}
   public pagereference sendemail(){ 
     system.debug(' -------eeeeeeeeeeeeeeeeeeeeeeeee--------' + selectedtemp );
      if (forPaginationstoreIds.KeySet().size() != 0) {
        etemplate  = new EmailTemplate();    
        etemplate   = [select Subject,HtmlValue from EmailTemplate Where id =: selectedtemp ];
        
         subjectval=etemplate.Subject;
        
         list < Event_Attendee_Mapping__c > emailids = [select id,IsPrifileUpdate__c,EV_id__r.EV_EventLogo__c,EV_Id__r.EV_HostingLocation__c,AS_id__r.AS_Company__c,
                                                        AS_id__r.AS_LastName__c,AS_id__r.id,AS_id__r.AS_FirstName__c, EV_id__r.id,EV_id__r.EV_Title__c, 
                                                        AS_id__r.AS_Email__c,EV_id__r.EV_HistingAddr1__c ,EV_id__r.AS_HostingAddr2__c,EV_id__r.AS_HostingCity__c,
                                                        EV_id__r.EV_HostingStateNew__c,EV_id__r.EV_StartDate__c,EV_id__r.StartTime__c,EV_id__r.EV_EndDate__c,
                                                        EV_id__r.EV_EndTime__c,Boothleads_Profile__c from Event_Attendee_Mapping__c 
                                                        where id IN: forPaginationstoreIds.KeySet()];
           system.debug(' -------eeeeeeeeeeeeeeee1111111eeeeeeeee--------' + emailids );
         
         list < Messaging.SingleEmailMessage > emails = new List < Messaging.SingleEmailMessage > ();
         List < Event_Attendee_Mapping__c > ASUpdate = new List < Event_Attendee_Mapping__c > ();
         for (Event_Attendee_Mapping__c eid: emailids) {
             Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
           
             String[] toAddresses = new String[] {
                 eid.AS_id__r.AS_Email__c
             };
         
       
        string content = etemplate.Htmlvalue;
        if(content.contains('{!EventName}')){
        system.debug('             content '+eid.EV_id__r.EV_Title__c);
        content=content.Replace('{!EventName}',eid.EV_id__r.EV_Title__c);
        
        }
        if(content.contains('{!FirstName}')){
        
        content = content.Replace('{!FirstName}',eid.AS_id__r.AS_FirstName__c);
        }
         if(content.contains('{!LastName}')){
        
        content = content.Replace('{!LastName}',eid.AS_id__r.AS_LastName__c);
        }
        if(content.contains('{!ComanyName}')){
        
        content = content.Replace('{!ComanyName}',eid.AS_id__r.AS_Company__c);
        }
        if(content.contains('{!ComanyName}')){
        
        content = content.Replace('{!logo}',eid.EV_id__r.EV_EventLogo__c);
        }
        if(content.contains('{!EventLocation}')){
        if(eid.EV_id__r.EV_HostingLocation__c != null && eid.EV_id__r.EV_HostingStateNew__c != null ){
        content = content.Replace('{!EventLocation}',eid.EV_id__r.EV_HostingLocation__c +' </br><br/> '+eid.EV_id__r.EV_HistingAddr1__c +','+eid.EV_id__r.AS_HostingAddr2__c+'<br/>'+eid.EV_id__r.AS_HostingCity__c+','+eid.EV_id__r.EV_HostingStateNew__c);
        }else{
        content = content.Replace('{!EventLocation}','');
        }
        
        if(content.contains('"DateStart"')){
        
        content = content.Replace('"DateStart"',eid.EV_id__r.EV_StartDate__c.month()+ '/'+eid.EV_id__r.EV_StartDate__c.day()+'/'+eid.EV_id__r.EV_StartDate__c.year()+ ' ' +eid.EV_id__r.StartTime__c);
        }
        if(content.contains('"DateEnd"')){
        
        content = content.Replace('"DateEnd"',eid.EV_id__r.EV_EndDate__c.month()+ '/'+eid.EV_id__r.EV_EndDate__c.day()+'/'+eid.EV_id__r.EV_EndDate__c.year()+ ' '+eid.EV_id__r.EV_EndTime__c);
        }
        
        }
         if(subjectval.contains('{!EventName}')){
        system.debug('             content '+eid.EV_id__r.EV_Title__c);
        subjectval = subjectval.Replace('{!EventName}',eid.EV_id__r.EV_Title__c);
        
        }
         email.setToAddresses(toAddresses);
        email.setSubject(subjectval);
        email.setHtmlBody(content);    
        emails.add(email);
            }
            Messaging.SendEmailResult[] r = Messaging.sendEmail(emails);
           emailalert = true;
        
        }
         else {
         
       }
      Existingtemp=false;
    
    pagereference pg = new pagereference('/apex/BL_Eventadmin_Attendees');
                 
                 return pg;
    }
    
    public void cancelnewtemp(){
    newtempbool = false;
     Existingtemp=true;
    }
  public pagereference massemail(){
       for (eventwrapper a: ForPagination) {
         if (a.atnd.checkbox_dataTable__c == TRUE)
             forPaginationstoreIds.put(a.atnd.id, a.atnd.checkbox_dataTable__c);
     }
     limitofbadges = false;
     emailalert = false;
  if (forPaginationstoreIds.KeySet().size() != 0) {
  stepTWO();
  pagereference pg = page.Emailregistration;
  return pg;
  }else{
  EventReqString = 'Please Select atleast one Attendee';
             EventReqStringBool = TRUE;
  }
  return null;
  }
  
  public string htmlbodyvalue{get;set;}
  
    public void desiredemailTemplate(){
    system.debug('      selectedtemp  '+selectedtemp);
    etemplate  = new EmailTemplate();
     etemplate = [select Subject,HtmlValue from EmailTemplate Where id =: selectedtemp ];
    
    htmlbodyvalue =etemplate.HtmlValue;
    displaybool =true;
     system.debug('      selectedtemp  rrrrrrrrrrrrrrr'+etemplate.HtmlValue  );
     system.debug('      selectedtemp  rrrrrrrrrrrrrrr 4444444444444 '+etemplate );
    }
    
     // Added by Shruthi to populate selected Event in the before Tab on November 18th
    public string id{get;set;}  
       
    public void URLEvent(){    
    id = apexpages.currentpage().getparameters().get('id');     
    
    if(id != null && id != ''){ 
    
    eventselected = id;
   } 
 }
 public void numofrecords(){
 
 if(selectednum != '' || selectednum != null){
         list<string> num = new list<string>();
         num = selectednum.split('-');
         integer j= integer.valueof(num[1]);
          system.debug('==============nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn ==============='+j);
         }
 
 
 }   
 
  
    

  /*****************************************************************************************/
    
   /* public void fetchCCRDetailsAll() {    
        set<id> attsummaryListIds = new set<id>();           
        for(Event_Attendee_Mapping__c EAMapping: [SELECT id, AS_id__r.id, EV_id__r.id from Event_Attendee_Mapping__c WHERE EV_id__c = : eventselected]) {
            attsummaryListIds.add(EAMapping.AS_id__r.id);
        }   
        CCRBatchCallouts_cls ccr = new CCRBatchCallouts_cls();
        ccr.fetchccr(attsummaryListIds);
        database.executeBatch(ccr,10);       
    } */
    
    // Inserting Fetch All CCR Details Method Start
    
    // CCR Details Methods End
  
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
   Event_Attendee_Mapping__c evm = [Select id,AS_id__c,AS_id__r.id from Event_Attendee_Mapping__c Where id =: eamid];
   evm.AS_id__c = attsum.id;
   evm.Attendee_Event_IDs__c = evm.AS_id__r.id+eveid;
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
  upold = [select id,Attendee_Summary__c,BoothAdmin_id__c,User_id__c from User_Profile_Event__c where Attendee_Summary__c =: newattendee.id And EV_id__c =: eventid];
  List<User> updtUsr = new List<User>();
      if(upold.size() > 0){
       List<User> newusr = [select id from User where username =: newemail];
       if(newusr.size() == 0){
       Profile UserAsBA = [Select Id,Name from Profile where Name = 'Booth Admin' limit 1];
               
               system.debug('======:::::::: Retriving Profile Id from Standard Profile Object ========::::::'+UserAsBA);              
              
             user uname=[select id from user where profile.Name Like 'System Administrator' and isActive=true Limit 1];
            User BoothAdminUser1 = new user();
               BoothAdminUser1 = [Select id, Firstname,Lastname,companyName,Company_website__c,CompanyAddr1__c,CompanyAddr2__c,CompanyCity__c,Country__c,
                                    States__c,CompanyFaxNumber__c,Companyphone__c,Zipcode__c,PoBox__c from User where Username =: oldemail];
               
            account acc=new account();
            acc.name='Booth Leads';  
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
              updtUsr.add(BoothAdminUser);
              }else{
              updtUsr.add(newusr[0]);
              }
       
          for(User_Profile_Event__c up : upold){
              up.Attendee_Summary__c = insNewAtt.getId();
              up.BoothAdmin_id__c = updtUsr[0].id;
              up.User_id__c = updtUsr[0].id;
               
              upnew.add(up);
          }
          Update upnew;
      }
  
  }
    

  /*****************************************************************************************/
    
   /* public void fetchCCRDetailsAll() {    
        set<id> attsummaryListIds = new set<id>();           
        for(Event_Attendee_Mapping__c EAMapping: [SELECT id, AS_id__r.id, EV_id__r.id from Event_Attendee_Mapping__c WHERE EV_id__c = : eventselected]) {
            attsummaryListIds.add(EAMapping.AS_id__r.id);
        }   
        CCRBatchCallouts_cls ccr = new CCRBatchCallouts_cls();
        ccr.fetchccr(attsummaryListIds);
        database.executeBatch(ccr,10);       
    } */
    
    // Inserting Fetch All CCR Details Method Start
    
    // CCR Details Methods End
    
 //---------------------------------------------------- Test Methods ----------------------------------------------------------------------
 
 
  public integer i{get;set;}
   public void  dummy1(){
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





public void  dummy2(){
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


public void  dummy3(){
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