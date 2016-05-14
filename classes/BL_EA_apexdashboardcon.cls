public without sharing class BL_EA_apexdashboardcon
{

public Integer TotalAttendees{get; set;}
public Integer TotalWalkinsAttendees{get;set;}
public Integer TotalRegisteredAttendees{get;set;}
public Integer TotalVisitedAttendees{get; set;}
public Integer TotalMobileUsers{get; set;}
public Integer TotalScansNum{get; set;}
public integer registerAttendeecount{get; set;}
public integer totalregisterAttendeecount{get; set;}
public LIST<ID> allEventsIds{get; set;}
public LIST<ID> eventIds {get; set;}
public String LoginUserId{get;set;}
public String EventString{get;set;}
public Boolean PageReportBool{get;set;} 
public LIST<SelectOption> events{get; set;}
public AggregateResult[] graphy {get;set;}  
public AggregateResult[] Fordiv1{get;set;}
public AggregateResult[] induchrt{get;set;}
public AggregateResult[] rchrt{get;set;}
public AggregateResult[] revchrt{get;set;}
public AggregateResult[] divchrt{get;set;}
public AggregateResult[] devicechart{get;set;} 
public AggregateResult[] scanchart{get;set;}
public AggregateResult[] attsourcechart{get;set;}
public LIST<LIST<Event_Attendee_Mapping__c>> indusreport{get;set;} 
public LIST<LIST<Event_Attendee_Mapping__c>> indusgridreport{get;set;}
public LIST<Event_Attendee_Mapping__c> query{get;set;} 
public LIST<Event_Attendee_Mapping__c> query1{get;set;}
public LIST<Event_Attendee_Mapping__c> an{get;set;}
public LIST<Event_Attendee_Mapping__c> gn{get;set;}
public LIST<Event_Attendee_Mapping__c> splitchart{get;set;}
public LIST<Event_Attendee_Mapping__c> Forticket{get;set;}
//public LIST<GeographyInner> grphy{get;set;}   
public LIST<IndustryInner> indus{get;set;}  
public LIST<regInner> reg{get;set;}
public LIST<revInner> rev{get;set;}
public LIST<divInner> diversity{get;set;}
public LIST<tktInner> tkttypes{get;set;}

public String SelectedEventId {get;set;}
//public LIST<hourlyscansinner> hourlyscans{get;set;}
//public LIST<iosdeviceinner> iosdevice{get;set;}
//public LIST<attsourceinner> attsource{get;set;}
public Integer maxValueHourly{get; set;}
public Integer maxValueIndustry{get; set;}
public Integer maxValueAttendee { get; set; }
public LIST<SelectOption> EventDate{get; set;} 
public String EventDates{get; set;}
public Boolean checkeventdates{ get; set; }
public String eventnameforDashboard{get; set; }
public Boolean noevents{get;set;}
public String noeventmessage{get;set;}
public LIST<User_Profile_Event__c> Events2{get;set;}
public boolean showchart{get;set;}
public boolean showdb{get;set;}
public boolean regdb{get;set;}
public Boolean revenuedb{get;set;}
public boolean divdb{get;set;}
public boolean ttdb{get;set;}
public list<Reports__c > ReportIds{get; set;}
public decimal capa{get;set;} 
public string ticketcategoryName{get;set;}
public Integer countontaketcategory{get;set;} 




public BL_EA_apexdashboardcon()
{
 
 URLEvent();
 
 try{
 allEventsIds= new LIST<ID>();
 LoginUserId = Userinfo.getUserId();
 LIST<User_Profile_Event__c> Events2 = [SELECT id,Ev_id__r.Ev_Title__c,Ev_Id__c 
                                        FROM User_Profile_Event__c
                                        WHERE User_id__c =: LoginUserId 
                                        AND Ev_id__r.Ev_Title__c!=NUll ORDER BY CreatedDate DESC];   
                                              
 eventIds = new LIST<ID>();
 Events = new LIST<SelectOption>();   
 for(User_Profile_Event__c EventFromJun : Events2)
 {  
  if(EventFromJun.Ev_Id__c != null)
  {      
   Events.add(new SelectOption(EventFromJun.Ev_Id__c, EventFromJun.Ev_id__r.Ev_Title__c)); 
   eventIds.add(EventFromJun.Ev_Id__c);   
  }   
 }
 if(Events2.size()==0)
 {
   noevents=false;
 }
 else if(Events2.size()>0)
 {
      noevents=true;
    system.debug( ' GGGGGGG GGGGGGGGGGGG'+URLEventid);  
      if(URLEventid == null || URLEventid == ''){
      EventString =Events2[0].Ev_Id__c;
      eventnameforDashboard=Events2[0].Ev_id__r.Ev_Title__c;
      }
      getdashboard();
  
 }
        totalregisterAttendeecount=regAttendeecount();
        TotalAttendees = Attendeecount();
        TotalVisitedAttendees = Visitedattendeecount();
        TotalMobileUsers = Mobileusers();
        TotalScansNum = Totalscans();
        TotalWalkinsAttendees = walkinsAttendeeCount();
        TotalRegisteredAttendees = registeredAttendeeCount();
        RegistrationAttendeescount();
        system.debug('Event String @@@' + EventString );
              system.debug('@@@@@@@@@@@@ ' + Innerproductivity);
        
      /*  Schema.DescribeFieldResult ticketcategoryvalues = TicketTypes__c.Ticket_Category__c.getDescribe();
        List<Schema.PicklistEntry> Allticketcategoryvalues = ticketcategoryvalues.getPicklistValues();
        system.debug('SSSSSSSSSSSSSSS GGGGGG DD ' + Allticketcategoryvalues ); */

      //for(Schema.PicklistEntry a : Allticketcategoryvalues)
        
            
         }  
 catch(exception e){}
 
 }
 
public integer getCurrentevent() 
{
LIST<User_Profile_Event__c> Events = [SELECT id,Ev_id__r.Ev_Title__c,Ev_Id__c 
                                        FROM User_Profile_Event__c
                                        WHERE User_id__c =: LoginUserId 
                                        AND Ev_id__r.Ev_Title__c!=NUll ];
                          
  integer eventCount=Events.size();
  return eventCount;
}

public void getdashboard()
 {
 ReportIds=[select id,RE_Name__c,UPE_id__r.EV_id__c from Reports__c where UPE_id__r.EV_id__c =: EventString 
            and UPE_id__r.EventAdmin_Id__c=:UserInfo.getUserId() ];

      getIndustryAdminChart();
      getPieData();
      getregChart();
      getrevChart();
      getdivChart() ;
      gettktChart();
      getcapacityChart();
      getBoothAdminScanData();
      totalregisterAttendeecount=regAttendeecount();
      TotalAttendees = Attendeecount();
      TotalVisitedAttendees = Visitedattendeecount();
      TotalMobileUsers = Mobileusers();
      TotalScansNum = Totalscans();
      TotalWalkinsAttendees = walkinsAttendeeCount();
      TotalRegisteredAttendees = registeredAttendeeCount();
      RegistrationAttendeescount();
      system.debug('@@@@@@@@@@@@ ' + Innerproductivity);
  //return null;
 }

//--------------------------------------- Overview Section Start --------------------------------------------------------------------------------------------
 public Integer Attendeecount() 
{
    system.debug('Mahesh111 '+EventString);
    
    LIST<Event_Attendee_Mapping__c> attendeeCount = [SELECT AS_id__c
                                                     FROM Event_Attendee_Mapping__c
                                                     WHERE Ev_id__c =: EventString 
                                                     AND Ev_id__c != null
                                                     AND AS_id__c!=null];
    integer attendeesCount=attendeeCount.size();
    system.debug('Mahesh222 '+attendeeCount);
    return attendeesCount;
    
}

public integer regAttendeecount()
{

 LIST<Dummay__c> regisAttendeecount = [SELECT id FROM Dummay__c
                                                     WHERE Event__c =: EventString 
                                                     AND Event__c != null
                                                     AND customer_key__r.Isinserted__c=True];
    integer registerAttendeecount=regisAttendeecount.size();
    system.debug('Mahesh222 '+regisAttendeecount);
    return registerAttendeecount;

}

public Integer walkinsAttendeeCount() 
{
    LIST<Event_Attendee_Mapping__c> WalkinsAttendeeCount = [SELECT AS_id__c
                                                     FROM Event_Attendee_Mapping__c
                                                     WHERE Ev_id__c =: EventString
                                                     AND Attendee_Source__c = 'Walk Ins' 
                                                     AND Ev_id__c != null
                                                     AND AS_id__c!=null];
    integer attendeesCount1=WalkinsAttendeeCount.size();
    return attendeesCount1;
}

public Integer registeredAttendeeCount() 
{
    LIST<Event_Attendee_Mapping__c> RegisteredAttendeeCount = [SELECT AS_id__c
                                                     FROM Event_Attendee_Mapping__c
                                                     WHERE Ev_id__c =: EventString
                                                     AND Attendee_Source__c = 'Pre Registered' 
                                                     AND Ev_id__c != null
                                                     AND AS_id__c!=null];
    integer attendeesCount2=RegisteredAttendeeCount.size();
    return attendeesCount2;
}

public Integer Visitedattendeecount() 
{
    Aggregateresult[] vistedattCount = [SELECT BVS_id__c
                                        FROM User_Event_BVS__c
                                        WHERE Ev_id__c =: EventString 
                                        AND Ev_id__c != null
                                        AND BVS_id__c!=null
                                        GROUP BY BVS_id__c ];
    integer vistedAttendees=vistedattCount.size();
    return vistedAttendees;
}

public Integer getBoothcount() 
{
    Aggregateresult[] boothCount =[SELECT BoothAdmin_id__c
                                   FROM User_Profile_Event__c
                                   WHERE EventAdmin_Id__c =: LoginUserId 
                                   AND Ev_id__c =: EventString                          
                                   AND UEP_isActive__c=true      
                                   AND Bt_Id__r.BT_isBoothActive__c=true                  
                                   AND Bt_Id__c!=null 
                                   AND Ev_id__c != null
                                   AND Profile_id__r.PR_Name__c='BoothAdmin'
                                   GROUP BY BoothAdmin_id__c];
    integer boothsCount=boothCount.size();
    return boothsCount;
} 
 
public Integer Mobileusers() 
{
    LIST<DeviceUsage__c> mobileusersCount =[SELECT IMEI__c
                                            FROM DeviceUsage__c
                                            WHERE Ev_id__c =: EventString                                 
                                            AND IMEI__c!=null];
    integer mobileCount=mobileusersCount.size();
    return mobileCount;
}

public Integer Totalscans() 
{
    Aggregateresult[] totalscans = [SELECT BVS_id__c
                                    FROM User_Event_BVS__c
                                    WHERE Ev_id__c =: EventString 
                                    AND BVS_id__c!=null
                                    GROUP BY BVS_id__c ];
    integer totalscancount=totalscans.size();
    return totalscancount;
}

public void RegistrationAttendeescount() 
{    
            countontaketcategory = 0;
           ticketcategoryName = '';
            Innerproductivity = new LIST<innerSalesProductivity>();                      
    Aggregateresult[] res = [SELECT count(Id),TicketTypes__r.Ticket_Category__c
                                    FROM Dummay__c
                                    WHERE customer_key__r.Isinserted__c =:True And Event__c =: EventString 
                                    GROUP BY TicketTypes__r.Ticket_Category__c];
                                    
      system.debug(' Aggregate res !!!!!    ' + res );  
       for(AggregateResult r : res){
               integer countontaketcategory = Integer.valueOf(r.get('expr0'));
               string ticketcategoryName= (string)r.get('Ticket_Category__c');
              Innerproductivity.add(new innerSalesProductivity(ticketcategoryName,countontaketcategory)); 
     }
                            
 }

 public LIST<innerSalesProductivity> Innerproductivity{get; set;} 
   public class innerSalesProductivity{
   
            public integer regatendeecount{get; set;}
            public string ticketcategory {get; set;}
             public innerSalesProductivity(string s1,integer i1){
                   regatendeecount= i1; 
                   ticketcategory = s1;
           system.debug(' Aggregate sssssssssss     ' + regatendeecount + '111111 ' + ticketcategory );  
  } 
    }






//---------------------------------------- Overview Section End ------------------------------------------------------------------------------------



//********************* Dashboard for Report by industry starts

 public integer IndustryCount{get; set;}
 public string IndustryName{get; set;}
 public LIST<industryinner> getIndustryAdminChart() 
 {  
      ShowChart=true;
     
      induchrt= [SELECT AS_id__r.AS_PrimaryBusinessCategory1__c p,count(id) c
                 FROM Event_Attendee_Mapping__c 
                 WHERE Ev_id__C =: EventString
                 AND AS_id__r.AS_PrimaryBusinessCategory1__c!=null 
                 AND AS_id__r.AS_PrimaryBusinessCategory1__c!= 'None'
                 GROUP BY AS_id__r.AS_PrimaryBusinessCategory1__c]; 
    
      indus = new LIST<industryinner>();
      
      for(AggregateResult iat : induchrt)     
      {
           IndustryCount=(Integer)iat.get('c');
           IndustryName=(String)iat.get('p');
           indus.add(new industryinner(IndustryName,IndustryCount));
      }
      return indus;  
 } 
 
 
 
 //inner class
 public class IndustryInner 
{
     public integer deci{get;set;} 
     public String industry{get;set;} 
     public IndustryInner(String industry, Integer deci)  
     { 
         this.deci= deci;
         this.industry= industry;      
     }
}

 //report view
 public list<Event_Attendee_Mapping__c> IndustryRecords{get; set;} 
 public boolean ShowIndustryRecords{get; set;}
 public PageReference pg{get; set;} 
  
  public pagereference IndustryReport()
  {
      ShowIndustryRecords=true;
      showchart=false;
      
        ReportIds=[select id,UPE_id__r.EV_id__c,RE_Name__c from Reports__c where (UPE_id__r.EV_id__c =:EventString)                                             
                            and UPE_id__r.EventAdmin_id__c=:userinfo.getUserId()];     
                  
      for(Reports__c  R:ReportIds)
      {
        
          if(R.RE_Name__c == 'Report By Industry') 
          {
            pg= new PageReference ('/apex/BL_EA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );          
          }
         
      }
          return pg;
  }

//Dashboard for Report by industry ends*****************



//****************************dashboard for Report by Geography

      public integer StateCount{get; set;}
      public string StateName{get; set;}
      public LIST<AggregateResult> GeographyCount {get; set;}
      public List<PieData> grpy{get;set;}
      public List<PieData> getPieData() {
      Showdb=true;
        grpy = new List<PieData>();
        GeographyCount =[SELECT AS_id__r.AS_Work_States__c w,count(id) c
                          FROM Event_Attendee_Mapping__c 
                          WHERE Ev_id__C =: EventString 
                          AND AS_id__r.AS_Work_States__c!=null
                          AND AS_id__r.AS_Work_States__c!= 'None'  
                          GROUP BY AS_id__r.AS_Work_States__c]; 
        
  
        for(AggregateResult S:GeographyCount)
       {
        StateCount=(Integer)S.get('c');
        StateName=(String)S.get('w');
        
        grpy.add(new PieData (StateName,StateCount));
        }
       
        return grpy ;
       
    }

    // Inner class begins
    
     public class PieData {

        public String name { get; set; }
        public Integer data { get; set; }

        public PieData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
    
    //report view
    
    public list<Event_Attendee_Mapping__c> GeographyRecords{get; set;} 
    public boolean ShowGeographyRecords{get; set;}
    public PageReference GeoReport() {
    ShowGeographyRecords= true;
   Showdb=false;
   
   ReportIds=[select id,UPE_id__r.EV_id__c,RE_Name__c from Reports__c where (UPE_id__r.EV_id__c =:EventString)                                             
              and UPE_id__r.EventAdmin_id__c=:userinfo.getUserId()];     
               
   
    
       
  for(Reports__c  R:ReportIds)
  {
    
  if(R.RE_Name__c == 'Report By Geography') 
  {
   pg= new PageReference ('/apex/BL_EA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );
    
  }
     
  }
      return pg;          
    
       
    }
    
    //dashboard for Report by Geography ends ******************************
    
    //Dashboard for registrations by date
    
 public integer RegCount{get; set;}
 public Date Regdate{get; set;}
 public string ForDate{get;set;}
 public LIST<regInner> getregChart() 
 {  

 
 regdb=true;
  rchrt= [SELECT Update_With_CreatedDate__c d,count(id) c
             FROM Event_Attendee_Mapping__c 
             WHERE Ev_id__C =: EventString
             AND Update_With_CreatedDate__c!=null 
             GROUP BY Update_With_CreatedDate__c
             ORDER By count(id) DESC LIMIT 5
             ]; 
 
  reg= new LIST<regInner>();
  
  for(AggregateResult re : rchrt)     
  {
   RegCount=(Integer)re.get('c');
   Date d = (Date)re.get('d');
   forDate= d.format();
  // Regdate = Date.valueOf(forDate);
    reg.add(new regInner (RegCount,forDate));
    
  }
 
  return reg;  
 } 
 
 
 
 //inner class
 public class regInner 
{
 public integer deci{get;set;} 
 //public Date date1{get;set;} 
 public  String DateString{get;set;}
 public regInner(Integer deci,String s)  
 { 
 this.deci= deci;
//this.date1= date2;
  this.DateString = s;
  
 }
}

public boolean ShowregRecords{get;set;}
public list<Event_Attendee_Mapping__c> regRecords{get; set;} 

public pagereference RegReport(){
ShowregRecords=true;
regdb=false;
   ReportIds=[select id,UPE_id__r.EV_id__c,RE_Name__c from Reports__c where (UPE_id__r.EV_id__c =:EventString)                                             
              and UPE_id__r.EventAdmin_id__c=:userinfo.getUserId()  ];     
                
   
    
       
  for(Reports__c  R:ReportIds)
  {
    
  if(R.RE_Name__c == 'Report By Registartions by Date') 
  {
   pg= new PageReference ('/apex/BL_EA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );
     
  }
     
  }
      return pg; 
 
  }




 // dashboard for business revenue
 
 public integer RevCount{get; set;}
 public  string busrev{get; set;}
 public LIST<revInner> getrevChart() 
 {  
  revenuedb=true;
  revchrt= [SELECT AS_id__r.updateRevenue__c r,count(id) c
             FROM Event_Attendee_Mapping__c 
             WHERE Ev_id__C =: EventString
             AND AS_id__r.updateRevenue__c!=null 
             GROUP BY AS_id__r.updateRevenue__c
             ]; 
 
  rev= new LIST<revInner>();
  
  for(AggregateResult re : revchrt)     
  {
   RevCount=(Integer)re.get('c');
   busrev=(String)re.get('r');
   if(busrev== '0')
   {
   
   rev.add(new revInner ('< Million',RevCount));
   }
   else if(busrev== '1')
   {
   rev.add(new revInner ('1-5 Million',RevCount));
     
   }
   else if(busrev== '2')
   {
   rev.add(new revInner ('5-10 Million',RevCount));
      
   }
   else if(busrev== '3')
   {
   rev.add(new revInner ('10-50 Million',RevCount));
      
   }
   else if(busrev== '4')
   {
   rev.add(new revInner ('50-100 Million',RevCount));
      
   }
    else if(busrev== '5')
   {
   rev.add(new revInner ('>100 Million',RevCount));
      
   }
  // rev.add(new revInner (busrev,RevCount));
  }
 
  return rev;  
 } 
 
 
 
 //inner class
 public class revInner 
{
 public integer deci{get;set;} 
 public string Revenue{get;set;} 
 public revInner(string Revenue, Integer deci)  
 { 
 this.deci= deci;
 this.Revenue= Revenue;
  
 }
}

 //report
  public boolean ShowrevRecords{get;set;}
  public list<Event_Attendee_Mapping__c> revRecords{get; set;} 

    public pagereference RevenueReport(){
        ShowrevRecords=true;
        revenuedb=false;
       ReportIds=[select id,UPE_id__r.EV_id__c,RE_Name__c from Reports__c where (UPE_id__r.EV_id__c =:EventString)                                             
              and UPE_id__r.EventAdmin_id__c=:userinfo.getUserId()];     
             
   
    
       
  for(Reports__c  R:ReportIds)
  {
    
  if(R.RE_Name__c == 'Report By Business Revenue') 
  {
   pg= new PageReference ('/apex/BL_EA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );
    
  }
     
  }
      return pg; 
        
        
    }

  
  
  
  //dashboard for diversity
 public Event__c eve{get;set;}
  public string divcerID{get; set;}
  public list<string> divcerIds{get; set;}
  public integer divCount{get; set;}
  public string divcer{get; set;} 
  public string val{get; set;} 
  public list<string> SS{get;set;}
  public integer count1{get;set;}
  public string fordiv{get;set;}
  public list<string> fordivst{get;set;}
  public  List<Event_Attendee_Mapping__c>  ForDiversity{get;set;} 
  
  public LIST<divInner> getdivChart() 
  {
  divdb=true;
  
   ForDiversity = new List<Event_Attendee_Mapping__c>();
   diversity = new LIST<divInner>();
   eve = [SELECT id,EventDiversityValues__c
             FROM Event__c
             WHERE id =: EventString                     
             ]; 
             
         if(eve.EventDiversityValues__c != null)
         {
           divcerID=eve.EventDiversityValues__c;
           divcerIds= divcerID.split(';');  
           
         }  
           
     
   ForDiversity  = [SELECT id,DiversityType__c
                     FROM Event_Attendee_Mapping__c 
                     WHERE Ev_id__C =: EventString ]; 
                     
                     for(String SplitDiversity :divcerIds ){ 
                       Integer selectedDiversity =0;
                      
                          for(Event_Attendee_Mapping__c EEEE : ForDiversity ){
                              
                               fordiv=EEEE.DiversityType__c;
                               
                                 if(EEEE.DiversityType__c != null ){ 
                                      
                                     if( fordiv.contains(SplitDiversity) ){                 
                                    
                                       selectedDiversity ++;
                                   }
                               }      
                           }
                              if(selectedDiversity>0){
                               diversity.add(new divInner(SplitDiversity ,selectedDiversity) ); 
                             }
                       }
                   
   
    
   
  return diversity;  
 } 
 
 
 
 //inner class
 public class divInner 
{
 public integer deci{get;set;} 
 public string divcert{get;set;} 
 public divInner(string divcert, Integer deci)  
 { 
 this.deci= deci;
 this.divcert= divcert;
 
 }
 
}

//report

public pagereference diversityrep(){        
      divdb=false;
      ReportIds=[select id,UPE_id__r.EV_id__c,RE_Name__c from Reports__c where (UPE_id__r.EV_id__c =:EventString)                                             
                   and UPE_id__r.EventAdmin_id__c=:userinfo.getUserId()];     
   
    
       
  for(Reports__c  R:ReportIds)
  {
    
  if(R.RE_Name__c == 'Report By Diversity Certification') 
  {
   pg= new PageReference ('/apex/BL_EA_Reports?eventid='+R.UPE_id__r.EV_id__c+'&ReportName='+R.RE_Name__c );

  }
     
  }
      return pg; 
        
        
    }


  //dashboard for ticket types
    public list<TicketTypes__c> tc{get;set;}
    public List<Dummay__c> dummys{get;set;}
    //public list<Ticket_Eam__c> team {get;set;}
    public string ticID{get; set;}
    public list<string> tickIds{get; set;}
    public integer tktCount{get; set;}
    public string tktname{get; set;}
    public string fortkt{get;set;}
    public list<string> splittickIds{get; set;}
    public boolean showtktchrt{get;set;}
    public LIST<AggregateResult> ticketcount {get; set;}
    
 public LIST<tktInner> gettktChart() 
 { 
    ttdb=true;
    showtktchrt=true;
    ticketcount = new List<AggregateResult>();
    tkttypes= new list<tktInner>();
    ticketcount =[Select TicketTypes__r.id,TicketTypes__r.TT_Name__c tids,SUM(Tickets_Quantty__c) ticsold  FROM Dummay__c
                    WHERE Event__r.id =:EventString 
                    AND customer_key__c != Null
                    AND TicketTypes__c!=null 
                    AND Primary_Attendee__c=TRUE
                    AND TicketTypes__r.forMobile__c=: FALSE
                    AND customer_key__r.Isinserted__c =: true  group By TicketTypes__r.id,TicketTypes__r.TT_Name__c  ];
    
    system.debug('GGGGGMMMMM  '+ticketcount );
    
    
        for(AggregateResult S:ticketcount )
        {
            system.debug('FFFFFFF   '+S);    
            Decimal ticcountdec =(Decimal)S.get('ticsold');
            ticcountdec = ticcountdec.round();
            tktname=(String)S.get('tids');
            system.debug('FFFTTT  '+ticcountdec +'   DDDDDD   '+tktname);    
            tkttypes.add(new tktInner(tktname,ticcountdec ));
        }
        
        system.debug('TTTTTTTTTTTT   '+tkttypes);
   
    return tkttypes;  
 }
 
 
 //inner class
 public class tktInner 
 {
     public Decimal deci{get;set;} 
     public string tic{get;set;} 
     public tktInner(string tic, decimal deci)  
     { 
     this.deci= deci;
     this.tic= tic;  
      }
}
  
        public pagereference tickdb()
        {        
            pagereference pf = new pagereference('/apex/tickettypereport?id='+URLEventid);
          return pf;
        
        }
  
  //*************Capacity Report
   public decimal quantity{get;set;}
   public decimal sold{get;set;}
   public AggregateResult[] capchrt{get;set;}
   public capInner[] capacity{ get; set; }
   public boolean showcap{get;set;}
   public integer soldtickets{get;set;}
  
  public void getcapacityChart() 
  {  
   
   capchrt= [SELECT sum(TT_Available__c) a,sum(TT_Sold__c) s
              FROM TicketTypes__c 
              WHERE Ev_id__c =: EventString
             // Group by id
            ]; 
           
    // integer soldtickets =capchrt.size();      
           // soldtickets = sum(TT_Sold__c);
            if(capchrt != null)
            {
              showcap=true;
              
              capacity = new List<capInner>();
      
         for (AggregateResult ar : capchrt ) {
        capacity.add(new capInner(ar));
         
    }
            }
            else {
            showcap=false;
  
  } 
 
 }
 
 //inner class
 public class capInner 
{
     public Decimal tot{ get; private set; }
     public Decimal deci{ get; private set; }

     public capInner(AggregateResult ar) {
            tot= (Decimal)ar.get('a');
            deci= (Decimal)ar.get('s');
     }
}


// dashboard for total scans


     public LIST<AggregateResult> ScanCount {get; set;}
     public integer SCount{get; set;}
     public string BoothName{get; set;}
     public List<PieDataForScans> Scans{get; set;}     

     public List<PieDataForScans > getBoothAdminScanData() {
        ShowChart=true;
        Scans= new List<PieDataForScans >();

 list<sObject> sob=[select count(id) C,UPE_id__r.BT_id__r.BT_Name__c N from User_Event_BVS__c
                                    where  EV_id__c =: EventString
                                    and UPE_id__r.BT_id__r.BT_Name__c != null 
                                    group by  UPE_id__r.BT_id__r.BT_Name__c
                                    ORDER By count(id) DESC LIMIT 5 ];
                             system.debug('222222uuuuuuuuuuuuuuuuu222222222'+ sob);       
for(sobject U:sob)
{

SCount=(integer)U.get('C');
BoothName=(string)U.get('N');
Scans.add(new PieDataForScans (BoothName,SCount)); 
system.debug('222222hhhhhhhhhhhhhhhhh222222222'+ Scans);
}

        return Scans;
       
    }
    
     public class PieDataForScans {

        public string Bname { get; set; }
        public Integer data { get; set; }

        public PieDataForScans (string Bname, Integer data) {
            this.Bname = Bname;
            this.data = data;
        }
    }
  

  public pagereference ShowScans(){
   pagereference pf = new pagereference('/apex/Boothadmin_Scan_tracking?event='+URLEventid);
          return pf;
  }
 
 //*****************back methods(not used)********************
 
    
     
    public void BackToChart(){
    getIndustryAdminChart();
    ShowIndustryRecords=false;
    getPieData();
    }
    
    public void BackTodb()
    {
    getIndustryAdminChart();
    ShowGeographyRecords=false;
    getPieData();
    }
    public void BackTodashboard()
    {
    getregChart();
    ShowregRecords=false;
  
    }
    public void BackTorevdb()
    {
    getrevChart() ;
    ShowrevRecords=false;
     
    }
    
    // Added by Shruthi to populate selected Event in the before Tab on November 18th 
   
    public string URLEventid{get;set;}
    
    public void URLEvent(){  
    
    
      
    URLEventid = apexpages.currentpage().getparameters().get('id');          
   
    if(URLEventid != '' && URLEventid != null){ 
   
    Event__c E = new Event__c();
    E = [select id,EV_Title__c from Event__c where id =: URLEventid];
    eventString = E.id;
    eventnameforDashboard = E.EV_Title__c ;
    
   } 
 }
 
 // Metrics con
  public pagereference metrics()
  {
        pagereference pg= new pagereference('/apex/metrics?id='+EventString);    
        pg.setRedirect(true); 
        return pg;
  }
  
}
    //***************************Controller ends***********