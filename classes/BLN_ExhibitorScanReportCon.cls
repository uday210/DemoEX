/***********************************************************************************************
*   Controller Name : BLN_ExhibitorScanReportCon
*   Author          : Deepthi Kollu
*   Purpose         : This class is to display the Exhibitor Scan Report 
*       Date                 Programmer                     Reason
    --------------      -------------------           -------------------------
*      02/02/2065            Vineel Ragula                  Implemented Server Side Pagination 
**************************************************************************************************/

public class BLN_ExhibitorScanReportCon {
  
    public string selectedeventid{get;set;}
    public transient LIST<Lead_Scan__c> detailList{get;set;}
    public BLN_UtillDisplayLinks   myticket{ get; set; }
    public transient AggregateResult[] leadlist {get;set;}
    public BLN_Event__c event{get;set;}
    public string scnId{get;set;}
    public boolean selectAll{get;set;}
    public String email { get; set; }
    public String cmpny { get; set; }
    public String lastNm { get; set; }
    public String frstNm { get; set; }
    
    public BLN_ExhibitorScanReportCon(){
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
             if(k!=null){
             selectedeventid = k.getValue();
             }
             leadsExport=new LIST<Lead_Scan__c>();
             event= [SELECT start_date__c, end_date__c,Organizer_Email__c,owner.email,Time_Zone__c from BLN_Event__c where id=:selectedeventid]; 
             BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
            eventInfo= new BLN_EventDetails();
            eventInfo.eventDetailsToDisplay(selectedeventid);
    
    }

    public void mainMethod(){
        if(event.Organizer_Email__c==UserInfo.getUserEmail()||event.owner.email==UserInfo.getUserEmail()){
        leadlist= [SELECT count(id) cnt,MAX(Scanner_Company__r.Name) company,MAX(Scanner_User__r.First_Name__c) fname,MAX(Scanner_User__r.Last_Name__c) lname,MAX(Scanner_User__r.Email__c) email,Scanner_User__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid group by Scanner_User__c ORDER BY count(id) DESC];
        }else{
        leadlist= [SELECT count(id) cnt,MAX(Scanner_Company__r.Name) company,MAX(Scanner_User__r.First_Name__c) fname,MAX(Scanner_User__r.Last_Name__c) lname,MAX(Scanner_User__r.Email__c) email,Scanner_User__c i from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scanner_User__r.User__c=:UserInfo.getUserId() group by Scanner_User__c ORDER BY count(id) DESC];
        }
    }
    
    public BLN_Event__c  eventslist{get;set;}
    public void displayPermissions(){
      BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
      eventslist = new BLN_Event__c  ();
      try{
        eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }catch(exception e){}

         myticket = new BLN_UtillDisplayLinks();
         myticket.isLeadExpand='expand';
          myticket.isLeadExbReport='active';
          myticket.tablabel='Exhibitor Scan Report';
          myticket.iseventsExpand ='';
         try{
         myticket.eventName = eventslist.Name;
         }catch(exception e){}
         myticket.EventId= selectedeventid;
         myticket.userPermissions(userInfo.getUserId(),selectedeventid);
        mainMethod();
    }
    
    public void displayPermissions1(){
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        eventslist = new BLN_Event__c  ();
        try{
        eventslist = blneventdetailbal.eventdetails(selectedeventid);
        }catch(exception e){}
        
        myticket = new BLN_UtillDisplayLinks();
        myticket.isLeadExpand='expand';
        myticket.isLeadExbReport='active';
        myticket.tablabel='Exhibitor Scan Report';
        myticket.iseventsExpand ='';
        try{
        myticket.eventName = eventslist.Name;
        }catch(exception e){}
        myticket.EventId= selectedeventid;
        myticket.userPermissions(userInfo.getUserId(),selectedeventid);
    }
    

    public PageReference scanDetails() {
        //string scanerID = Apexpages.currentPage().getParameters().get('scaner');
        //detailLeads=[SELECT first_name__c,last_name__c,title__c,Cell_Phone__c,Scan_Time__c,Company__c,Lead_Email__c from Lead_Scan__c WHERE Scanner_User__c = :scanerID AND Lead_Status__c!='Deleted' and event__c  = :selectedeventid];
        return null;
    }
    
    public BLN_EventDetails eventInfo{get; set;}
    public PageReference printReport() {
            
            BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
            eventInfo= new BLN_EventDetails();
            eventInfo.eventDetailsToDisplay(selectedeventid);
           
       String selectedck=apexpages.currentpage().getparameters().get('selectedck');
       String uncheckedIds=apexpages.currentpage().getparameters().get('unchecked');
       String type=apexpages.currentpage().getparameters().get('type');
       string searchkey=apexpages.currentpage().getparameters().get('searchkey');
       
            pageReference pg =  page.BLN_printExhibitorScan;
            system.debug('ssssssssssssssssssssssssssss'+pg);
            pg.setredirect(true);
            pg.getParameters().put('selectedck',selectedck);
             pg.getParameters().put('unchecked',uncheckedIds);
             pg.getParameters().put('type',type);
             pg.getParameters().put('selectAll',string.valueOf(selectAll));
              pg.getParameters().put('searchkey',searchkey);
            return pg;
    }

    public transient AggregateResult[] exportlist{get;set;}
    public PageReference exportReport() {
        String selectedck=apexpages.currentpage().getparameters().get('selectedck');
       String uncheckedIds=apexpages.currentpage().getparameters().get('unchecked');
       String type=apexpages.currentpage().getparameters().get('type');
       string searchkey=apexpages.currentpage().getparameters().get('searchkey');

       if(type== 'Summary'){ 
        pageReference pg =  new pagereference('/apex/BLN_exportExhibitorScan');
            pg.setredirect(true);
             pg.getParameters().put('selectedck',selectedck);
             pg.getParameters().put('unchecked',uncheckedIds);
             pg.getParameters().put('type',type);
             pg.getParameters().put('selectAll',string.valueOf(selectAll));
              pg.getParameters().put('searchkey',searchkey);
            return pg;
      }else{
          pageReference pg =  new pagereference('/apex/BLN_exportExhibitorScan1');
            pg.setredirect(true);
             pg.getParameters().put('selectedck',selectedck);
             pg.getParameters().put('unchecked',uncheckedIds);
             pg.getParameters().put('type',type);
             pg.getParameters().put('selectAll',string.valueOf(selectAll));
              pg.getParameters().put('searchkey',searchkey);
            return pg;
    }
    }
    
    public transient list<detailInn> detailInner{get;set;}
    public class detailInn{
        public Lead_Scan__c LeadScan{get;set;}
        public string scantime{get;set;}
        
        
    }


    public transient MAP<ID,LIST<detailInn>> detailInnMAp{get;set;}
    public void exportMethod(){
        String selectedck=apexpages.currentpage().getparameters().get('selectedck');
        System.debug('hi seconf page '+selectedck);
        String tok1 = selectedck.replace('\"','');
        String tok2 = tok1.replace(']','');
        String tok4 = tok2.replace('\'','');
        String tok3 = tok4.replace('[','');

        List<String> allIds= tok3.split(',');
        system.debug('iiii'+allIds[0]);

        String uncheckedIds=apexpages.currentpage().getparameters().get('unchecked');
        System.debug('hi unchecked '+uncheckedIds);
        String tok5 = uncheckedIds.replace('\"','');
        String tok6 = tok5.replace(']','');
        String tok7 = tok6.replace('\'','');
        String tok8 = tok7.replace('[','');
          
        List<String> uncheckedIdList= tok8.split(',');
        system.debug('uuuuu'+uncheckedIdList.size());
        
        String selectAll=apexpages.currentpage().getparameters().get('selectAll');
        String type=apexpages.currentpage().getparameters().get('type');
        string searchkey=apexpages.currentpage().getparameters().get('searchkey');
        
        set<id> sidSet=new set<id>();
        if(selectAll == 'true'){
            exportlist= [SELECT count(id) cnt,MAX(Scanner_Company__r.Name) company,MAX(Scanner_User__r.First_Name__c) fname,MAX(Scanner_User__r.Last_Name__c) lname,MAX(Scanner_User__r.Email__c) email,Scanner_User__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scanner_User__c  NOT IN :uncheckedIdList 
                           AND (Scanner_User__r.First_Name__c like : '%'+searchkey+'%' OR Scanner_User__r.Last_Name__c like : '%'+searchkey+'%' OR Scanner_User__r.Email__c like : '%'+searchkey+'%')
                          group by Scanner_User__c ORDER BY count(id) DESC];
            
            if(type == 'Detail'){
                for(AggregateResult el:exportlist){
                    sidSet.add(string.valueof(el.get('i')));
                }
                detailList=[SELECT first_name__c,Scanner_User__c,last_name__c,title__c,Cell_Phone__c,Scan_Time__c,Company__c,Lead_Email__c from Lead_Scan__c WHERE Scanner_User__c IN :sidSet AND Lead_Status__c!='Deleted' and event__c  = :selectedeventid];
                list<ID> scaner=new list<ID>();
                
                detailInnMAp = new MAP<ID,LIST<detailInn>>();
                for(Lead_Scan__c l:detailList){
                    detailInn Inn=new detailInn();
                    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                    tz.tZone=Event.Time_Zone__c;
                    tz.format='MM/dd/yyyy hh:mm a';
                    tz.dateTimeValue=l.Scan_Time__c;
                    inn.scantime=tz.getTimeZoneValue();
                    inn.LeadScan=l;
                    LIST<detailInn> inns=new LIST<detailInn>();
                    if(detailInnMAp.containsKey(l.Scanner_User__c)){
                        inns = detailInnMAp.get(l.Scanner_User__c);
                        inns.add(inn);
                        detailInnMAp.put(l.Scanner_User__c,inns);
                    }else{
                        inns.add(inn);
                        detailInnMAp.put(l.Scanner_User__c,inns);
                    }
                }
            }
        }else{
            
                exportlist= [SELECT count(id) cnt,MAX(Scanner_Company__r.Name) company,MAX(Scanner_User__r.First_Name__c) fname,MAX(Scanner_User__r.Last_Name__c) lname,MAX(Scanner_User__r.Email__c) email,Scanner_User__c i  from Lead_Scan__c where Lead_Status__c!='Deleted' AND Event__c =:selectedeventid AND Scanner_User__c IN :allIds 
                                AND (Scanner_User__r.First_Name__c like : '%'+searchkey+'%' OR Scanner_User__r.Last_Name__c like : '%'+searchkey+'%' OR Scanner_User__r.Email__c like : '%'+searchkey+'%')
                              group by Scanner_User__c ORDER BY count(id) DESC]; 
            if(type == 'Detail'){
                for(AggregateResult el:exportlist){
                    sidSet.add(string.valueof(el.get('i')));
                }
                detailList=[SELECT first_name__c,Scanner_User__c,last_name__c,title__c,Cell_Phone__c,Scan_Time__c,Company__c,Lead_Email__c from Lead_Scan__c WHERE Scanner_User__c IN :sidSet AND Lead_Status__c!='Deleted' and event__c  = :selectedeventid order by scan_time__c desc];
                list<ID> scaner=new list<ID>();
                
                detailInnMAp = new MAP<ID,LIST<detailInn>>();
                for(Lead_Scan__c l:detailList){
                    
                    detailInn Inn=new detailInn();
                    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
                    tz.tZone=Event.Time_Zone__c;
                    tz.format='MM/dd/yyyy hh:mm a';
                    tz.dateTimeValue=l.Scan_Time__c;
                    inn.scantime=tz.getTimeZoneValue();
                    inn.LeadScan=l;
                    LIST<detailInn> inns=new LIST<detailInn>();
                    if(detailInnMAp.containsKey(l.Scanner_User__c)){
                        inns = detailInnMAp.get(l.Scanner_User__c);
                        inns.add(inn);
                        detailInnMAp.put(l.Scanner_User__c,inns);
                    }else{
                        inns.add(inn);
                        detailInnMAp.put(l.Scanner_User__c,inns);
                    }
                }
            }
        }
    }

/**************************************************************************************************
                         - SERVER SIDE PAGINATION START - 
***************************************************************************************************/
//Process Data
    public List<Lead_Scan__c> RecList{get;set;}
    public ApexPages.StandardSetController setCon {get;set;}
    public LIST<Lead_Scan__c>  detailLeads{get;set;}
    public string dataTableJson {get;set;}
    public void processData(){
            
            string scanerID = Apexpages.currentPage().getParameters().get('scaner');
            frstNm = Apexpages.currentPage().getParameters().get('fnm');
            lastNm = Apexpages.currentPage().getParameters().get('lnm');
            cmpny = Apexpages.currentPage().getParameters().get('cmp');
            email = Apexpages.currentPage().getParameters().get('eml');

           detailLeads=[SELECT first_name__c,last_name__c,title__c,Cell_Phone__c,Scan_Time__c,Company__c,Lead_Email__c,Event__r.Time_Zone__c from Lead_Scan__c WHERE Scanner_User__c = :scanerID AND Lead_Status__c!='Deleted' and event__c  = :selectedeventid order by scan_time__c desc];
         setcon=new ApexPages.StandardSetController(detailLeads);
          
                    
           
            //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            
            setCon.setPageSize(3);
            
        Integer noOfRecords= setCon.getResultSize();
            if(size==-1){
            size=noOfRecords;
            }
            setCon.setPageSize(size);
            
        
            //set pagenumber
            setCon.setPageNumber((start/size)+1);
            
            RecList = setCon.getRecords(); 
            
            
              List<SubWrapper> newReclist= new List<SubWrapper>();
            
            // create a sub wrapper
      for(Lead_Scan__c ac: RecList){
          Id val=ac.id;
          newReclist.add(new SubWrapper(ac, val));
      }
      
            //create wrapper
            DataTableWrapper datawrap = new DataTableWrapper(0,noOfRecords,noOfRecords,newReclist);
            
            dataTableJson = JSON.serialize(datawrap);

    }
    
    
    
// Subwrapper     
public class SubWrapper{

  public Id DT_RowId{ get; set; }
  public Lead_Scan__c item { get; set;}
  public String createdon{get;set;}
  

  public SubWrapper(Lead_Scan__c item, Id counter) {
    this.item = item;
    this.DT_RowId= counter;
    DateTime dateTimeValue=item.Scan_Time__c;
       if(dateTimeValue != null){
    this.createdon=dateTimeValue.format('MM/dd/YYYY hh:mm a',item.Event__r.Time_Zone__c);
       }else{
           this.createdon=null;
       }
      }  
  }
  
  
  
    
    // DataTable Wrapper
      public class DataTableWrapper
        {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public List<subwrapper> data;
    
            public DataTableWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,list<subwrapper> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data = data;
    }
} 
              
public transient LIST<Lead_Scan__c> allLeads{get;set;}
public PageReference exportAll() {
    BLN_LeadScan_DAO lsDAo =new BLN_LeadScan_DAO();
    
    pageReference pg =  new pagereference('/apex/BLN_exportAllExhibitorScans');
    pg.setredirect(true);
    return pg;
            }
         
public PageReference exportallmethod() {
    allLeads=new LIST<Lead_Scan__c>();
    string querystring ='SELECT event__r.time_zone__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,user_pic__c,zip__c,Scanner_Company__r.Name,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c =\''+ selectedeventid+'\' Order By Scanner_User__r.First_name__c,Scanner_User__r.last_name__c';
    allLeads = [SELECT event__r.time_zone__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,user_pic__c,zip__c,Scanner_Company__r.Name,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!='Deleted' AND Event__c =: selectedeventid Order By Scanner_User__r.First_name__c,Scanner_User__r.last_name__c];
    if(allLeads.size()>5000){
        Id batchInstanceId = Database.executeBatch(new BLN_ExportExhibitorScansBatch(querystring,allLeads[0].event__r.time_zone__c), 5000);
        //return new Pagereference('/BLN_ExhibitorScanReportCheckEmail');
        return null;
    }else{
        return null;
        } 
}
public LIST<Lead_Scan__c> leadsExport{get;set;}
    public PageReference exportedMailData() {
        leadsExport=new LIST<Lead_Scan__c>();
        leadsExport=  [SELECT event__r.time_zone__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,user_pic__c,zip__c,Scanner_Company__r.Name,BLN_TKT_profile__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!='Deleted' AND Event__c =: selectedeventid Order By Scanner_User__r.First_name__c,Scanner_User__r.last_name__c];
        return null;
    }


    
            @RemoteAction
        public static boolean getCheckTypeOfExportForTotalExbtorscans(string evntid){
        boolean showbulkbtn = false;



        Integer totalResp = 0;

        string querystring='SELECT COUNT()'
          +' FROM Lead_Scan__c '
          +'WHERE Lead_Status__c!=\'Deleted\' AND Event__c= \''+evntid+'\' Limit 5001';
          
         

        totalResp = Database.countQuery(querystring);
        system.debug('---Count---'+totalResp );






        if(totalResp>5000){

        showbulkbtn = true;
        }


        return showbulkbtn;
        }



    


}