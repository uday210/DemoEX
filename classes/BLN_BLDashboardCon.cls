global class BLN_BLDashboardCon {

/***************************************************************
    *   Controller Name         : BLN_BLDashboardCon
    *   Date                    : 16March 2016 
    *   Author                  : Deepthi Kollu
    *   Purpose                 : This class is for Creating Boothleads Dashboards.
******************************************************************/
    public BLN_UtillDisplayLinks   myticket { get; set; }
    public string selectedEventId{get;set;}
    public Boolean EAbool{get; set;} 
    
    //for lead retrival dashboard
    public BLN_LeadScan_DAO lsDAO{get;set;}
    public BLN_Device_Usage_DAO deviceusage{get;set;}
    public Device_Usage__c device{get;set;}
    public transient list<Lead_Scan__c> leadlist{get;set;}
    public list<device_usage__c> devicelist{get;set;}
    public integer iOScount{get;set;}
    public integer Androidcount{get;set;}
    public BLN_Ticket_DAO ticDAO{get;set;}
    public BLN_Ticket_DAO ticDAO1{get;set;}
    public transient list<ticket__c> ticTemp{get;set;}
    public transient list<leadratinginner> leadRating{get; set;}
    public transient list<boothreportInner> boothreport{get;set;}
    public string na{get;set;}
    
    //constructor
    public BLN_BLDashboardCon(){ 
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
            if(k!=null){ 
                selectedEventId = k.getValue();
            }
            BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        BLN_Event__c  se = new BLN_Event__c  ();
        try{
        se = blneventdetailbal.eventdetails(selectedEventId );
        
           }catch(exception e){}
        
        myticket = new BLN_UtillDisplayLinks();
        myticket.isBLDashboardPage='active';
        myticket.isLeadExpand='expand';
        myticket.tablabel='Lead Retrieval Dashboard';
        myticket.eventId=selectedEventId;
        myticket.iseventsExpand ='';
        try{
        myticket.eventName=se.NAme;
        }catch(exception e){}
        myticket.userPermissions(userInfo.getUserId(),selectedEventId);
        
        id id1 = userinfo.getProfileId();
     system.debug('ProfileId'+id1);
     profile p1=[select Name from profile where id = :id1];
     
    if(se.Organizer_Email__c ==userInfo.getUserName()||se.OwnerId==userinfo.getuserid()) 
         EAbool=true;
    }
    public Pagereference restoftheQueries()
    {

        //for scanned leads
    lsDAO =new BLN_LeadScan_DAO();
    leadlist = lsDAO.getLeadScan_dashboard(selectedEventId,'');
    system.debug('leadlist=============='+leadlist); 
    
    set<id> ursDivId=new set<id>();
    for(Lead_Scan__c ls : leadlist){
        ursDivId.add(ls.Scanner_User__r.User__c);
    } 
   String allids='';
   for(String s:ursDivId)
   allids+=s+',';
   
    // for ios and android users
    iOScount = 0;
    Androidcount = 0; 
    Set<string> uqusr=new Set<String>();
    for(LoginHistory du:[Select Id,UserId,LoginTime,LoginType,SourceIp,LoginUrl,AuthenticationServiceId,LoginGeoId,Browser,Platform,Status,Application,ClientVersion,ApiType,ApiVersion from LoginHistory  where UserId in : ursDivId]){// where UserId in : ursDivId
    //userid and platform combination is unique
        if(!uqusr.contains(du.UserId+du.Platform)){ 
            uqusr.add(du.UserId+du.Platform);
            if(du.Platform.contains('iPhone') ||  du.Platform.contains('iPad') ){
                iOScount++;
            }else if(du.Platform.contains('Android')){
                Androidcount++;
            }  
        }

    } 
    
    //for boothleads users
     ticDAO= new BLN_Ticket_DAO();
    ticTemp=new list<ticket__c>(); 
    string s1='Lead Retrieval';
    BLN_Event__c eve=[select Organizer_Email__c from BLN_Event__c where id= :selectedEventId];
    string userid=userinfo.getuserid();
    string temp='';
    
    if(eve.Organizer_Email__c == UserInfo.getUserEmail()){
    temp=' WHERE event__r.id = \''+selectedEventId+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\'';
    }else{
      //temp=' WHERE event__r.id = \''+selectedEventId+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\' AND tkt_profile__r.BLN_GN_User__r.User__c =  \''+userid+'\'';
     String idInClause=''; 
     if(ursDivId.size()>0){
             idInClause = '(\'';
            for(String orderid:ursDivId)  {
              idInClause += orderid+ '\',\'';
            }
           idInClause  = idInClause.substring(0,idInClause.length()-2);
           idInClause += ')'; 
            }
            else{
             idInClause = '(\'';
            idInClause += '\')';
          }   
      temp=' WHERE event__r.id = \''+selectedEventId+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\' AND tkt_profile__r.BLN_GN_User__r.User__c IN '+idInClause;
       System.debug(' wherecondition '+temp);
    }
    
    ticTemp = ticDAO.userOrderAndTickets(temp);
    system.debug('aaaaaaaaaaaaaaaaaa'+ticDAO.userOrderAndTickets(temp));
    //for lead rating report
    leadRating= new LIST<leadratinginner>();
    
    for(integer i=0;i<=5;i++){
        integer leadcount=0;
        for(lead_scan__c l:leadlist){
            if(l.rating__c==null)
            l.rating__c=0;
            
            if(l.rating__c==i)
            leadcount++;
        }
       if(leadcount!=0)
       leadRating.add(new leadratinginner(i,leadcount));     
    } 
    
    //for Report by Booth Admin and Booth User Scans
       list<string> names = new list<string>();
       set<string> nameset = new set<string>();      
      for(lead_scan__c ls1:leadlist){
          if(!nameset.contains(ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c+' '+ls1.Scanner_User__r.email__c))
          names.add(ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c+' '+ls1.Scanner_User__r.email__c);
          nameset.add(ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c+' '+ls1.Scanner_User__r.email__c.tolowercase());
      }
      boothreport =new list<boothreportInner>();   
       for (Integer n = 0; n <= names.size()-1; n++)
       {
           integer lcnt=0;
           string namedisplay='';
           for(lead_scan__c ls1:leadlist){
               if(names[n].tolowercase()==ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c+' '+ls1.Scanner_User__r.email__c.tolowercase()){
                   namedisplay=ls1.Scanner_User__r.first_name__c+' '+ls1.Scanner_User__r.Last_name__c;
                   lcnt++;
               }
           }
           namedisplay = (namedisplay.length()>15) ? namedisplay.subString(0,15) : namedisplay;
           boothreport.add(new boothreportInner(namedisplay, lcnt));
       }
       
       boothreport.sort();
       
       integer i =1;
       boothreportfordisplay = new list<boothreportInner>();
       for(boothreportInner b:boothreport){
           if(boothreportfordisplay.size() <10){
           boothreportfordisplay.add(b);
           }
           i++;
       }
      return null; 
    }   
    
    public transient list<boothreportInner> boothreportfordisplay{get;set;}
    //for Report by Booth Admin and Booth User Scans dashboard graph
    /*public with sharing class boothreportInner{
    public string BLusers{get;set;}
    public string ScanNo{get;set;}
        public boothreportInner(string BLusers, integer ScanNo){
            this.BLusers= BLusers;
            this.ScanNo= string.valueof(ScanNo);
        }
    }*/
    global class boothreportInner implements Comparable{
    public string BLusers{get;set;}
    public integer ScanNo{get;set;}
        public boothreportInner(string BLusers1, integer ScanNo1){
            BLusers= BLusers1;
            ScanNo= ScanNo1;
        }
    
        global Integer compareTo(Object compareTo) {
            boothreportInner compareToEmp = (boothreportInner)compareTo;
            if (ScanNo == compareToEmp.ScanNo) return 0;
            if (ScanNo < compareToEmp.ScanNo) return 1;
            return -1;   
        }
    }
    
    //for lead rating dashboard graph
    public with sharing class leadratinginner{
    public string leadrat{get;set;}
    public integer leadNo{get;set;}
        public leadratinginner(integer leadrat, integer leadNo){
            this.leadrat= string.valueof(leadrat);
            this.leadNo= leadNo;
    
        }
    }
}