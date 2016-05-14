public without sharing class BLN_ParticipantRevisitReportCon {

/**************************************************************
Author: Mythily
Date:   09 MAR 2016
Purpose : Showing all participants who were Revisited


***************************************************************/
    //VARIABLE DECLARATION
    public BLN_UtillDisplayLinks myticket { get; set; }
    public BLN_Event__c  se{get;set;}
    public String SelectedEvent{get; set;}
    public string selectedEventid {get ; set ;}
    public BLN_ParticipantRevisitReport_BAL RevisitBAL {get ; set ;}// BAL CLASS INSTANCE
    public transient List<BLN_ParticipantRevisitReport_BAL.Totalinner> Totalinner{get ; set ;}
    public LIST<selectOption> datesfilter { get; set; }
    public String selectedDates { get; set; }
    public List<Date> Eventdates{get;set;}
    //CONSTRUCTOR
    public BLN_ParticipantRevisitReportCon(){
    Totalinner = new List<BLN_ParticipantRevisitReport_BAL.Totalinner> ();
    cookie counter =   ApexPages.currentPage().getCookies().get('counter');
        if(counter != null ){
            selectedEventid = counter.getValue();
        }


        BLN_Events_DAO Event = new BLN_Events_DAO ();
        BLN_Event__c SelectedEvent = Event.getEventDetails(selectedEventid);
         Eventdates = new List<Date>();
        //Getting All Dates of an Event is conducting
        integer eventdays=0;
            If(SelectedEvent.Start_Date__c != SelectedEvent.End_Date__c){
                eventdays = SelectedEvent.Start_Date__c.Date().daysBetween(SelectedEvent.End_Date__c.Date());
                }
            if(eventdays > 0){
            date startdate=SelectedEvent.Start_Date__c.Date();
                for(Integer i=0; i<=eventdays ; i++){
                Eventdates.add(startdate);

                startdate+=1; 
                }  
            }else{
            date startdate=SelectedEvent.Start_Date__c.Date();
            Eventdates.add(SelectedEvent.Start_Date__c.Date());

            }
            system.debug('qqqqq::'+Eventdates);
         system.debug('pppppp::'+seldates); 
    RevisitBAL = new BLN_ParticipantRevisitReport_BAL(); 
     
        Totalinner = RevisitBAL.RevistedParticipants(selectedEventid,Eventdates);
        
    
    }
    
    //DISPLAY PERMISSIONS METHOD
    public PageReference displayPermissions() {
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
            if(k!=null){
                selectedEvent = k.getValue();
            }    
  
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        se = new BLN_Event__c();
        try{
            se = blneventdetailbal.eventdetails(selectedEvent);
        }catch(exception e){ }        
        myticket = new BLN_UtillDisplayLinks( );
        myticket.isSAExpand='expand';
        myticket.isSAreportExpand='expand';
        myticket.isrevisitReportPage='active';
        myticket.tablabel='Revisit Report';
        myticket.EventId = selectedEvent ;        
        try{
            myticket.eventName=se.NAme;
        }catch(exception e){ }
        myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        return null;
        }
        public String xlsHeader {
        get {
            String strHeader = '';
            strHeader += '<?xml version="1.0"?>';
            strHeader += '<?mso-application progid="Excel.Sheet"?>';
            return strHeader;
        }
    }   
        
     @RemoteAction
    public static List<string> getDateFilters(String eventid){
        BLN_Events_DAO Event = new BLN_Events_DAO ();
        BLN_Event__c SelectedEvent = Event.getEventDetails(eventid);
        List<string> Eventdates = new List<string>();
        //Getting All Dates of an Event is conducting
        integer eventdays=0;
            If(SelectedEvent.Start_Date__c != SelectedEvent.End_Date__c){
                eventdays = SelectedEvent.Start_Date__c.Date().daysBetween(SelectedEvent.End_Date__c.Date());
                }
            if(eventdays > 0){
            date startdate=SelectedEvent.Start_Date__c.Date();
                for(Integer i=0; i<=eventdays ; i++){
                Eventdates.add(string.valueof(startdate));
                startdate+=1; 
                }  
            }else{
            date startdate=SelectedEvent.Start_Date__c.Date();
            Eventdates.add(string.valueof(startdate));
            }
            return Eventdates;
    }
    
    public void fncall() {
    string ttype=Apexpages.currentpage().getparameters().get('ttype');
    system.debug('ttype'+ttype);
    List<Date> Eventdates = new List<Date>();
    LIST<string> datestring=new LIST<string>();
    datestring=ttype.split(ttype);
    for(integer i=0;i<datestring.size();i++){
        Eventdates.add(date.valueof(datestring[i]));
    }
    system.debug('Eventdates'+Eventdates);
    Totalinner = new List<BLN_ParticipantRevisitReport_BAL.Totalinner> ();
    RevisitBAL = new BLN_ParticipantRevisitReport_BAL();    
    Totalinner = RevisitBAL.RevistedParticipants(selectedEventid,Eventdates);             

    }
    
    
    //Export Revisit Method
    public pagereference exportRevisit(){
    pagereference pf = page.BLN_ParticipantRevisitReportExport;
    pf.setredirect(true);
    pf.getParameters().put('seldates',apexpages.currentpage().getparameters().get('seldates'));
    return pf;
    } 
    
    public string seldates{get;set;}
    public PageReference expmethod() {
    RevisitBAL=new BLN_ParticipantRevisitReport_BAL ();
        seldates=apexpages.currentpage().getparameters().get('seldates');
        system.debug(apexpages.currentpage().getparameters().get('seldates')+'sssssssddddddd'+seldates);
        if(seldates!=null && seldates!=''){
        list<date> dlist=new list<date>(); 
        dlist.add(Eventdates[0]);  
        for(date d : Eventdates){
            Datetime dt = datetime.newInstance(d.year(), d.month(),d.day());
            system.debug('yyyyyy:'+dt);
            String dateOutput = dt.format('MM/dd/yyyy');
            system.debug('zzzzz:'+dateOutput );
            if(seldates.contains(dateOutput))
            dlist.add(d);    
        }
        system.debug('xxxxx:'+dlist);
        system.debug('1111111:'+Eventdates);
        Totalinner = RevisitBAL.RevistedParticipants(selectedEventid,dlist);
    }else{
        Totalinner = RevisitBAL.RevistedParticipants(selectedEventid,Eventdates);
    }  
    system.debug('1111111:'+Eventdates);
        return null;
    }   
}