public without sharing class BL_BA_ChartsCon {

    public boolean ShowHourlyScanChart { get; set; }
    public PageReference  pg1{get;set;}
    public String ScanString{get;set;}

   

  public PageReference HourlyScanReport() {
    
    for(Reports__c  R:ReportIds)
   {
   if(R.RE_Name__c == 'Report By Hourly Scans') 
    {
    system.debug('@@@@@@@@@@@##############$$$$$$$$$$$'+EventDates);
     pg= new PageReference ('/apex/BL_BA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c+'&EventDate='+EventDates);
    
   }
    }
    return pg;
        
    }
    public PageReference BoothAdminScanReport() {
    
    for(Reports__c  R:ReportIds)
   {
   system.debug(' FFFFFFFFFFFFFFFFFFF '+R.RE_Name__c);
     
     if((R.RE_Name__c == 'Report By Booth Admin and Booth User Scans') || (R.RE_Name__c == 'Report By Booth User Scans')) 
    {    
    pg1 = new PageReference ('/apex/BL_BA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c);
   }
    }
    return pg1;
        
    }


    

    public boolean ShowIndustryChart { get; set; }

    public boolean ShowGeographyChart { get; set; }

     public boolean ShowLeadRatingChart{ get; set; }

public boolean booleanforDisplayBoothadminTab {get; set;}

   



    public list<User_Event_BVS__c> GeograpyRecords{get; set;} 
    public boolean ShowGeographyRecords{get; set;}
    public PageReference pg{get; set;}
    
    public PageReference GeographyReport() {
   for(Reports__c  R:ReportIds)
   {
   system.debug(' FFFFFFFFFFFFFFFFFFF '+R.RE_Name__c);
     
     if(R.RE_Name__c == 'Report By Geography') 
    {    
    
     pg= new PageReference ('/apex/BL_BA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );
    
    }
     
     }
    
        return pg;
    }
    
    public list<User_Event_BVS__c> IndustryRecords{get; set;} 
    public boolean ShowIndustryRecords{get; set;}
    
    public PageReference IndustryReport() {
    
   
    for(Reports__c  R:ReportIds)
    {
    if(R.RE_Name__c == 'Report By Industry') 
    {
     pg= new PageReference ('/apex/BL_BA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );
    
    }
     
     }
    
    
        return pg;
   
    }
    
    public PageReference LeadRatingReport() {
    
   
    for(Reports__c  R:ReportIds)
    {
    if(R.RE_Name__c == 'Report By Lead Rating') 
    {
     pg= new PageReference ('/apex/BL_BA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );
    
    }
    }
    return pg;
        
    }
    


    public PageReference ChartDisplay() {
    
    ReportIds=[select id,RE_Name__c,UPE_id__r.EV_id__c from Reports__c 
               where (( UPE_id__r.EV_id__c =: eventselected and 
               UPE_id__r.BoothAdmin_id__c =:UserInfo.getUserId()) OR (UPE_id__r.EV_id__c =: eventselected and 
               UPE_id__r.User_id__c =:UserInfo.getUserId()))];
              
    system.debug(' RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR '+ReportIds);
    ShowChart=true;
    //ShowGeographyChart =true;
   // ShowIndustryChart =true;
   // ShowLeadRatingChart=true;
    //ShowHourlyScanChart =true;
    getPieData();
    getIndustryData();
    getLeadRatingData();
    getBoothAdminScanData();
    getBoothusers();
        getInactiveboothusers();
        getMobileboothusers();
        getMpboothusers();
        getScannedusers();
        getMobileusers();
        getBlackberryMobileusers();
        getApplemobileusers();   
    hourlyscanchart();
     
    
        return null;
    }
    
        public list<Reports__c> ReportIds{get;set;}
        
        
        public BL_BA_ChartsCon ()
        {
        URLEvent();
        ShowChart=true;
        getselectEvents();
        ChartDisplay();
        //hourlyscanchart();
        
     List<User_Profile_Event__c> BoolforDisplayBoothadminTab = new List<User_Profile_Event__c>();
     List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
     BoolforDisplayBoothadminTab = [select Profile_id__c,Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:UserInfo.getUserNAme() and status__c!='Inactive' and status__c!='Mobile only access'];
    
     for(User_Profile_Event__c ty:BoolforDisplayBoothadminTab )
     {
     if(ty.Profile_id__r.PR_Name__c =='BoothAdmin')
     {
       booleanforDisplayBoothadminTab =true;
     } 
     }
     
    /* ReportIds=[select id,RE_Name__c,UPE_id__r.EV_id__c 
                from Reports__c where UPE_id__r.EV_id__c =: eventselected 
                and UPE_id__r.BoothAdmin_id__c =:UserInfo.getUserId()  ]; */
                system.debug('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'+ReportIds);
         getBoothusers();
        getInactiveboothusers();
        getMobileboothusers();
        getMpboothusers();
        getScannedusers();
        getMobileusers();
        getBlackberryMobileusers();
        getApplemobileusers();   
        }
    //--------------------------------------- Page Reference Start ------------------------------------------   
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
  }  
  List<User_Profile_Event__c> upelist1=new  List<User_Profile_Event__c>();
   upelist1=[select Profile_id__r.PR_Name__c from User_Profile_Event__c where User_id__r.Email=:userInfo.getUserName() And Profile_id__r.PR_Name__c='BoothAdmin' ];
 
   if(upelist1.size()>0){
    return null;
   }
   else{
    Pagereference pg = new pagereference('/apex/bl_eventadmin_events');
    pg.setredirect(true); 
    return pg;
   } 
}
//---------------------------------------- Page Reference End -------------------------------------------

    public String eventSelected { get; set; }
    public List<Event__c> EvntsForPicklist{get;set;}
    public string defaultEvent{get;set;}
    public List<Reports__c> boothPerReports{get;set;}
    public set<Id> EventIds {get; set;}
    public List<SelectOption>  Options{get;set;}
    
    public PageReference getEvents() {
    
     boothPerReports = new List<Reports__c> ();
     
     if(eventSelected !=null && eventSelected !=''){
     
     boothPerReports =[Select id,r.RE_Name__c, r.RE_Description__c From Reports__c r 
                       where r.UPE_id__r.User_id__r.Email=:UserInfo.getUserName() and 
                       UPE_id__r.EV_id__c=:eventSelected];
     
                       }
     return null;
    }
    
    
    public void getselectEvents() {
       List<User_Profile_Event__c> upeForEvents = new List<User_Profile_Event__c>();
       EvntsForPicklist = new List<Event__c>();
       upeForEvents = [Select u.User_id__c,u.Profile_id__r.PR_Name__c,u.User_id__r.Name, u.UEP_isActive__c, u.SystemModstamp, u.Profile_id__c, u.OwnerId, u.Name, u.LastModifiedDate, u.LastModifiedById, u.LastActivityDate, u.IsDeleted, u.Id, u.EventAdmin_Id__c, u.EV_id__c, u.CreatedDate, u.CreatedById, u.BoothAdmin_id__c, u.BT_id__c, u.BLP_id__c From User_Profile_Event__c u where u.User_id__r.Email=:UserInfo.getUserName() and (Status__c!='Mobile only access' And Status__c!='InActive') ];
     
     
     
       set<Id> setOfEventIds = new set<Id>();
           for(User_Profile_Event__c rotatinnFor:upeForEvents){
           setOfEventIds.add(rotatinnFor.EV_id__c);
           }
 
       EvntsForPicklist =[select  id,EV_Title__c from Event__c where id in :setOfEventIds order by EV_StartDate__c];
           if(EvntsForPicklist.size()>0){
           defaultEvent =EvntsForPicklist[0].id;
           }
          options = new List<SelectOption>();
          EventIds = new set<Id>();
           for(Event__c Event:EvntsForPicklist ){
           options.add(new SelectOption(Event.id,Event.EV_Title__c));
           EventIds.add(Event.id);
           if(id == '')
           eventselected = Event.id;
            if(id == null)
           eventselected = Event.id;
           system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@'+eventselected );
           }
         
     }
     
      // Code for getting States
     
      public integer StateCount{get; set;}
      public string StateName{get; set;}
      public LIST<AggregateResult> GeographyCount {get; set;}
      public List<PieData> grpy{get;set;}
      public boolean ShowChart{get; set;}
      
    public List<PieData> getPieData() {
        ShowChart=true;
        grpy = new List<PieData>();
       // for(Reports__c  R:ReportIds)
         //  {
   // if(R.RE_Name__c == 'Report By Geography') 
         //  {
         system.debug('~~~~~~~~~~~~~~~~~~~~~~~'+eventSelected );
        GeographyCount =[SELECT BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c  w,count(id) c 
             FROM User_Event_BVS__c 
             WHERE ((UPE_id__r.UEP_isActive__c =true and EV_id__c  =: eventSelected AND 
             UPE_id__r.BoothAdmin_id__c=:userinfo.getUserId() and BVS_id__r.EA_AttendeeBarcode__c!=null 
             and BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c !=null AND  
             BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c != '--None--') OR (UPE_id__r.UEP_isActive__c =true and EV_id__c  =: eventSelected AND 
             UPE_id__r.User_id__c=:userinfo.getUserId() and BVS_id__r.EA_AttendeeBarcode__c!=null 
             and BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c !=null AND  
             BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c != '--None--'))
             GROUP BY BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c
             ]; 
       
   system.debug('~~~~~~~~~~~~~~~~~~~~~~~'+GeographyCount);     
        for(AggregateResult S:GeographyCount)
       {
        StateCount=(Integer)S.get('c');
        StateName=(String)S.get('w');
        //string GName= S.u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c;
        grpy.add(new PieData (StateName,StateCount));
        }
        system.debug(' AAAAAAAAAAAAAAAAAAAAAAAAAAAA '+grpy);
       // }
        //}
        return grpy ;
       
    }
    
    // Code for getting Industry
    
     public LIST<AggregateResult> IndustryCount {get; set;}
     public integer ICount{get; set;}
     public string IName{get; set;}
     public List<PieDataForIndustry> Indstry{get; set;}
     
    public List<PieDataForIndustry> getIndustryData() {
        ShowChart=true;
        Indstry= new List<PieDataForIndustry >();
        // for(Reports__c  R:ReportIds)
          // {
   // if(R.RE_Name__c == 'Report By Industry') 
          // {
        IndustryCount =[SELECT BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c  I,count(id) c
                FROM User_Event_BVS__c 
                WHERE ((EV_id__c  =: eventselected 
                AND UPE_id__r.BoothAdmin_id__c=:userinfo.getUserId() 
                AND BVS_id__r.EA_AttendeeBarcode__c!=null 
                AND  BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c !=null 
                AND  BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c != '--None--') OR
                (EV_id__c  =: eventselected 
                AND UPE_id__r.User_id__c=:userinfo.getUserId() 
                AND BVS_id__r.EA_AttendeeBarcode__c!=null 
                AND  BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c !=null 
                AND  BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c != '--None--')) 
                GROUP BY BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_PrimaryBusinessCategory1__c]; 
        
     
        for(AggregateResult S:IndustryCount )
       {
        ICount=(Integer)S.get('c');
        IName=(String)S.get('I');
        //string GName= S.u.BVS_id__r.EA_AttendeeBarcode__r.AS_id__r.AS_Work_States__c;
        Indstry.add(new PieDataForIndustry (IName,ICount));
        }
        
       // }
      //  }
        return Indstry;
       
    }

     // Code for getting Lead Rating
     
     public LIST<AggregateResult> RatingCount {get; set;}
     public integer RCount{get; set;}
     public string RName{get; set;}
     public List<PieDataForLeadRating> LeadRating{get; set;}
     public List<integer> maxcount{get; set;}
     public integer maxvalue {get; set;} 
    public List<PieDataForLeadRating> getLeadRatingData() {
        
        LeadRating = new List<PieDataForLeadRating>();
        
        RatingCount =[Select count(id) c ,BVS_id__r.Lead_Rating__c r
                     From User_Event_BVS__c  
                     where ((UPE_id__r.BoothAdmin_id__r.Email=:userInfo.getUserName() 
                     and UPE_id__r.UEP_isActive__c =true and BVS_id__c!=null and EV_id__c=:eventSelected)
                     OR (UPE_id__r.User_id__c=:UserInfo.getUserId() and UPE_id__r.UEP_isActive__c=true 
                     and EV_id__c=:eventSelected 
                     and BVS_id__c!=null)) and  (BVS_id__r.EA_AttendeeBarcode__c!=null) 
                     group by BVS_id__r.Lead_Rating__c];  
         
        system.debug('#########################'+RatingCount );
  
      try
      {
      maxcount= new list<integer>();
        for(AggregateResult S:RatingCount)
       {
       
        RCount=(Integer)S.get('c');
        RName= (String)S.get('r');
        
        maxcount.add(RCount);
        
        maxvalue = maxcount[0];
        LeadRating.add(new PieDataForLeadRating (RName,RCount));
        }
        
       
        
        For (integer i =0;i<maxcount.size();i++)
        {
            
            if( maxcount[i] > maxvalue)
                maxvalue = maxcount[i];    
            system.debug('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'+maxvalue );   
            
            if(maxvalue <10){
              maxvalue =10;
              system.debug('VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV'+maxvalue ); 
               }  
            /*   else {
                maxvalue =maxvalue +1;
                system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+maxvalue );   
                } */
        } 
        
        }
        catch(Exception E){}
           
        system.debug('LLLLLLLLLLLLLLLLLLLLLLLLEEEEEEEEEEEEEEEAAAAAAAAAAAAAADDDDDDDDDD'+LeadRating);
      
        return LeadRating;
       
    }
    
     // Code for getting Industry
    
     public LIST<AggregateResult> ScanCount {get; set;}
     public integer SCount{get; set;}
     public string UserName{get; set;}
     public List<PieDataForScans > Scans{get; set;}
     public List<integer> scanmaxcount{get; set;}
     public integer scanmaxvalue {get; set;} 
     public boolean ShowBoothAdminReport{get; set;}
      public boolean ShowBoothUserReport {get; set;}
      
      
    public List<PieDataForScans > getBoothAdminScanData() {
        ShowChart=true;
        Scans= new List<PieDataForScans >();
        
        
        set<id> setOfBvs = new set<id>();   
        for(Reports__c  R:ReportIds)
    {
    
       if(R.RE_Name__c== 'Report By Booth Admin and Booth User Scans')
 {
 ScanString = 'Booth Users';
 ShowBoothAdminReport= true;
 ShowBoothUserReport =false;
 for(User_Event_BVS__c lusres:[select BVS_id__r.id,BVS_id__c from User_Event_BVS__c 
                               where EV_id__r.Id=: eventSelected and UPE_id__r.BoothAdmin_id__c =: userinfo.getuserid()]){
  setOfBvs.add(lusres.BVS_id__r.id); 
   system.debug('*********************!!!!!!!!!!!'+setOfBvs);     
 }
 }
 
 if(R.RE_Name__c == 'Report By Booth User Scans')
 {
 ScanString = 'Attendee ';
 ShowBoothUserReport =true;
 ShowBoothAdminReport=false;
 for(User_Event_BVS__c lusres:[select BVS_id__r.id,BVS_id__c from User_Event_BVS__c 
                               where EV_id__r.Id=: eventSelected and UPE_id__r.User_id__c=: userinfo.getuserid()]){
  setOfBvs.add(lusres.BVS_id__r.id);
 }
 }
  }
 /**
 for(User_Event_BVS__c lusres:[select BVS_id__r.id,BVS_id__c from User_Event_BVS__c where EV_id__r.Id=: eventSelected  
                              and UPE_id__r.BoothAdmin_id__c =: userinfo.getuserid()  ]){
                 system.debug('WWWWWWWWWWWWWWWWWWWWWWWWWWW'+setOfBvs);             
  setOfBvs.add(lusres.BVS_id__r.id);    
 }
 **/
system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+setOfBvs); 
     scanmaxcount= new list<integer>();
  for(sObject listOfobj:[select count(id) re,User_id__r.FirstName f,User_id__r.LastName l,User_id__r.id c,User_id__c from BoothVisitSummary__c where EA_AttendeeBarcode__c!=null and ID IN :setOfBvs  group BY User_id__c,User_id__r.FirstName,User_id__r.LastName,User_id__r.id order by count(id) DESC]){ 
      system.debug('RRRRRRRRRRRRRRRRRRRRRRRRR'+listOfobj);
      string lName=(string)listOfobj.get('l');
      string fName =(string)listOfobj.get('f');
      SCount=(integer)listOfobj.get('re');
      UserName=fName +' ' + lName ;
      
      scanmaxcount.add(SCount);
      scanmaxvalue = scanmaxcount[0];
 
   Scans.add(new PieDataForScans (UserName,SCount)); 
   system.debug('BBBBBBBBBBBBBBBBBBBB'+Scans);
  }
        For (integer i =0;i<scanmaxcount.size();i++)
        {
            
            if( scanmaxcount[i] > scanmaxvalue)
                scanmaxvalue = scanmaxcount[i];    
            system.debug('MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'+scanmaxvalue );   
            
            if(scanmaxvalue <10)
               scanmaxvalue =10;  
             /*  else
               scanmaxvalue = scanmaxvalue +2;   */
        } 
        
      
        return Scans;
       
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
    public Integer lastScanTime{get; set;} 
    public Integer firstScanTime{get; set;}
    
public void hourlyscanchart()
{ 
           ShowChart =true;
         //  ShowHourPickList=False;
 //try{
 hourlyscans = new list<hourlyscansinner>();
 EventDate = new LIST<SelectOption>();
 lastScanTime = 0;
  system.debug('EEEEEEEEEEEEEEEEEEEE'+eventselected);
 eventtime = [SELECT id, EV_EndTime__c, StartTime__c,EV_StartDate__c,EV_EndDate__c FROM Event__c WHERE ID =: eventselected];
            system.debug('!!!!!!!!!!!!!!!!!!!!'+eventtime );
 eventStartTime = Integer.ValueOf(eventtime.StartTime__c.SubString(0,eventtime.StartTime__c.lastIndexOf(':')));
     if(String.valueOf(eventtime.StartTime__c).contains('PM')){
         eventStartTime +=12;
     }
 
 
 
  
  system.debug('****************'+eventStartTime );
 
 EventDates=String.valueOf(eventtime.EV_StartDate__c);                 
 Integer eventdays = eventtime.EV_StartDate__c.daysBetween(eventtime.EV_EndDate__c);
 
 if(eventdays >0)
 {  
  checkeventdates=true;
  date startdate=eventtime.EV_StartDate__c; 
  for(Integer i=0; i<=eventdays ; i++ )
  {
   EventDate.add(new SelectOption(String.valueOf(startdate),String.valueOf(startdate)));
   startdate+=1; 
  }     
 }
 else if(eventdays==0)
 {
  checkeventdates=false;
 }
 scannedChartByDate();
 }
//catch(exception e){}  
// }
 


public void scannedChartByDate()
{
 system.debug('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW');
//try{
 String ssss =  eventtime.StartTime__c.SubString(0,eventtime.StartTime__c.lastIndexOf(':'));
 scanchart= new AggregateResult[]{};
 scanchart= [SELECT HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)),count(id)
             FROM User_Event_BVS__c 
             WHERE ((Ev_id__c =: eventselected
             AND DAY_ONLY(convertTimezone(BVS_id__r.ScanTime__c))=:Date.ValueOf(EventDates)
             AND UPE_id__r.BoothAdmin_id__c=:userinfo.getUserId() 
             AND HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)) != NULL 
             and BVS_id__r.EA_AttendeeBarcode__c!=null)OR
             (Ev_id__c =: eventselected
             AND DAY_ONLY(convertTimezone(BVS_id__r.ScanTime__c))=:Date.ValueOf(EventDates)
             AND UPE_id__r.User_id__c=:userinfo.getUserId() 
             AND HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)) != NULL 
             and BVS_id__r.EA_AttendeeBarcode__c!=null))
             GROUP BY HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c)) 
             ORDER BY HOUR_IN_DAY(convertTimezone(BVS_id__r.ScanTime__c))];
            
            
            
    system.debug('+++++++++++++++++++++++++++++++++++++'+scanchart.size());
             
 if(scanchart.size() > 0)
     ShowHourPickList = True;
 
             
 if(eventtime.EV_EndTime__c.contains('PM'))
 {
  eventEndTime = Integer.ValueOf(eventtime.EV_EndTime__c.SubString(0,eventtime.EV_EndTime__c.lastIndexOf(':')))+12;
 }
 else 
  eventEndTime = Integer.ValueOf(eventtime.EV_EndTime__c.SubString(0,eventtime.EV_EndTime__c.lastIndexOf(':')));
 
 MAP<Integer, Integer> scanTimes = new MAP<Integer, Integer>();
 
 maxValueHourly = 0;
 lastScanTime = 0;
 
 for(AggregateResult iq : scanchart){ 
  scanTimes.put((integer)iq.get('expr0'), (integer)iq.get('expr1'));
 } 
 
 Boolean temVar= TRUE;
 
 for(Integer ii=01; ii<= 24; ii++ ){
     
     if(temVar && scanTimes.containsKey(ii)){
         firstScanTime = ii;
         temVar = FALSE;
     }else if(scanTimes.containsKey(ii))
         lastScanTime= ii;
      
      
 }
 
 if(firstScanTime >= eventStartTime )
     firstScanTime = eventStartTime ;
 if(lastScanTime <= eventEndTime )
     lastScanTime = eventEndTime ;    
 
 for(Integer ii=firstScanTime; ii<= lastScanTime; ii++ ){
    
     system.debug('    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCalender  2222222 '+ firstScanTime);
     
      system.debug('    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCalender  33333333 '+ lastScanTime);
    
    
     if(scanTimes.containsKey(ii)){
          String s12 = (ii>12)?(ii-12)+':00 PM': ii+':00 AM';
          hourlyscans.add(new hourlyscansinner(ii, scanTimes.get(ii),(ii>12)?(ii-12)+'PM': ii+'AM'));
          
          if(maxValueHourly  < scanTimes.get(ii))
          maxValueHourly = scanTimes.get(ii); 
     }else{
          
         // system.debug('    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCalender 11111111 '+ ii);
          
         // if(ii >= eventStartTime && ii <= eventEndTime ){
               system.debug('    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCalender  2222222 '+ ii);
               hourlyscans.add(new hourlyscansinner(ii, 0,(ii>12)?(ii-12)+'PM': ii+'AM'));
         /* }else if(ii <= eventStartTime || ii >= eventEndTime  ){
                 system.debug('    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCalender 33333333333333333 '+ ii);
                if(scanTimes.containsKey(ii-1) != null && scanTimes.containsKey(ii+1) != null ){
                    // hourlyscans.add(new hourlyscansinner(ii, 0,(ii>12)?(ii-12)+'PM': ii+'AM'));
                    
                     system.debug('    CCCCCCCCCCCCCCCCCCCCCCCCCCCCCalender 444444444444444444 '+ ii);
                }    
          }
          */
        //  hourlyscans.add(new hourlyscansinner(ii, 0,(ii>12)?(ii-12)+'PM': ii+'AM'));
           
        // if(scanTimes.size() > 0)
       //      ShowHourPickList = True;
       //  else
       //      ShowHourPickList = False;
     }  
       
 }  



 if(maxValueHourly == null){
  maxValueHourly =0;
 // ShowChart = False;
  
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
 //}
// catch(exception e){}         
}

public void pickdate()
{

 hourlyscans = new LIST<hourlyscansinner>();

 scannedChartByDate();
  
 }
 
 

//--------------------------------------- Hourly Scan Chart End ------------------------------------------
 
    
    // Inner class for Geography
    
     public class PieData {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
    
    // Inner class for Industry
    
    public class PieDataForIndustry {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieDataForIndustry (String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
    
    // Inner class for Lead Rating
    
    public class PieDataForLeadRating {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieDataForLeadRating (String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
    
    // Inner class for Booth Admin Scans
    
  public class PieDataForScans {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieDataForScans (String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
    // Inner class for Booth Admin Scans
    
  public class PieDataForBoothUserScans {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieDataForBoothUserScans (String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
    //inner class for HourlyScans
    public class hourlyscansinner
      {
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
    
   
   //--------------------------------------- Overview Section Start -----------------------------------------
public Integer getBoothusers() 
{
LIST<User_Profile_Event__c> boothusers = [SELECT id 
                                          FROM User_Profile_Event__c 
                                          WHERE Profile_id__r.PR_Name__c = 'BoothPersonnel'  
                                          AND EV_id__c =: eventselected
                                          AND BoothAdmin_id__c=: Userinfo.getUserId()];
integer boothuser=boothusers.size()+1;
return boothuser;
}

public Integer getInactiveboothusers() 
{
LIST<User_Profile_Event__c> ibusers = [SELECT id 
                                       FROM User_Profile_Event__c 
                                       WHERE Profile_id__r.PR_Name__c = 'BoothPersonnel' 
                                       AND EV_id__c =: eventselected
                                       AND BoothAdmin_id__c=: Userinfo.getUserId()
                                       AND Status__c='Inactive'];

integer ibuser=ibusers.size();
return ibuser;
}


public Integer getMobileboothusers() 
{
LIST<User_Profile_Event__c> mbusers = [SELECT id 
                                       FROM User_Profile_Event__c 
                                       WHERE Profile_id__r.PR_Name__c = 'BoothPersonnel' 
                                       AND EV_id__c =: eventselected
                                       AND BoothAdmin_id__c=: Userinfo.getUserId()
                                       AND Status__c='Mobile only access'];
integer mbuser=mbusers.size();
return mbuser;
}

public Integer getMpboothusers() 
{
LIST<User_Profile_Event__c> mpbusers = [SELECT id 
                                        FROM User_Profile_Event__c 
                                        WHERE Profile_id__r.PR_Name__c = 'BoothPersonnel' 
                                        AND EV_id__c =: eventselected
                                        AND BoothAdmin_id__c=: Userinfo.getUserId()
                                        AND Status__c='Mobile and Portal Access'];
integer mpbuser=mpbusers.size();
return mpbuser;
}

public Integer getScannedusers() 
{

LIST<User_Event_BVS__c> totalscans = [SELECT BVS_id__c
                                      FROM User_Event_BVS__c                                      
                                      WHERE (UPE_id__r.BoothAdmin_id__c=: Userinfo.getUserId() 
                                      OR BVS_id__r.User_id__c=: UserInfo.getUserId()) 
                                      AND UPE_id__r.EV_id__c =: eventselected
                                      AND BVS_id__r.EA_AttendeeBarcode__c!=null
                                      AND UPE_id__r.UEP_isActive__c=true
                                      AND BVS_id__c!=null
]; 
   
/**
LIST<BoothVisitSummary__c> totalscans = [SELECT id 
                                         FROM BoothVisitSummary__c  
                                         WHERE EA_AttendeeBarcode__c!=null 
                                         AND User_id__c=: UserInfo.getUserId()
                                         ];   **/         
integer totalscancount=totalscans.size(); 
return totalscancount;
}

public Integer getMobileusers() 
{
List<DeviceUsage__c> androidusers =[SELECT IMEI__c
                                    FROM DeviceUsage__c
                                    WHERE Ev_id__c =: eventselected
                                    AND User__c=: Userinfo.getUserId()
                                    AND OsVersion__c='Android'
                                    AND IMEI__c!=null];
integer androiduser=androidusers.size();
return androiduser;
}

public Integer getBlackberryMobileusers() 
{
List<DeviceUsage__c> blackberryusers =[SELECT IMEI__c
                                       FROM DeviceUsage__c
                                       WHERE Ev_id__c =: eventselected
                                       AND User__c=: Userinfo.getUserId()
                                       AND OsVersion__c='Blackberry'
                                       AND IMEI__c!=null];
integer blackberryuser=blackberryusers.size();
return blackberryuser;
}

public Integer getApplemobileusers() 
{
List<DeviceUsage__c> appleusers=[SELECT IMEI__c
                                 FROM DeviceUsage__c
                                 WHERE Ev_id__c =: eventselected
                                 AND User__c=: Userinfo.getUserId()
                                 AND OsVersion__c='iOS'
                                 AND IMEI__c!=null ];
                                 system.debug('AAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBB'+appleusers);
integer appleuser=appleusers.size();
return appleuser;
}
//---------------------------------------- Overview Section End ------------------------------------------
  // Added by Shruthi to populate selected Event in the before Tab on November 18th
    public string id{get;set;}     
    public void URLEvent(){  
      
    id = apexpages.currentpage().getparameters().get('id');     
   
    if(id != null && id != ''){ 
  
    eventSelected = id;
   } 
 }
}