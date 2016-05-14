public class metricscon {

public LIST<ID> allEventsIds{get; set;}
public LIST<ID> eventIds {get; set;}
public String LoginUserId{get;set;}
public String EventString{get;set;}
public LIST<SelectOption> events{get; set;}
public Boolean noevents{get;set;}
public String noeventmessage{get;set;}
public LIST<User_Profile_Event__c> Events2{get;set;}
public String eventnameforDashboard{get; set; }
public boolean showdb{get;set;}
public boolean  showtypes {get;set;}
public boolean regdb{get;set;}

    public metricscon()
    {
    URLEvent();
    
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
       if(URLEventid == null || URLEventid == ''){
      EventString =Events2[0].Ev_Id__c;
      eventnameforDashboard=Events2[0].Ev_id__r.Ev_Title__c;
      }
      getdashboard();
    
    }
 
  }
 
 public pagereference getdashboard()
 {
  getpayData();
  getregChart();
  return null;
 }

      public integer paycount{get; set;}
      public string payName{get; set;}
      public LIST<AggregateResult> paymentcount {get; set;}
      public List<PieData> pay{get;set;}
      public List<PieData> getpayData(){
      
        Showdb=true;
        pay = new List<PieData>();
        paymentcount  =[SELECT Payment_Type__c w, SUM(TicketAmount__c) c,count(id)
                          FROM Dummay__c 
                          WHERE Event__r.id=: EventString 
                           AND customer_key__c != Null 
                           AND TicketTypes__c != Null
                          AND customer_key__r.Isinserted__c = true
                          GROUP BY Payment_Type__c]; 
        system.debug('&&**** '+ paymentcount);
  
        for(AggregateResult S:paymentcount)
        {
             Decimal paycountdec =(Decimal)S.get('c');
             payName =(String)S.get('w');
             paycount = Integer.valueof(paycountdec);
            pay.add(new PieData (payName,paycount));
       }
       
       
        return pay;  
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
    
    public pagereference registrationreport()
    {
       pagereference pg= new pagereference('/apex/BL_Registrations_Information?id='+EventString);    
        pg.setRedirect(true); 
        return pg;
    }
   // --------------------------------2nd chart begins----------------
   
 /** public integer totalcount{get; set;}
      public string attendeetypeName{get; set;}
      public LIST<AggregateResult> totpaymentcount {get; set;}
      public List<metricData > type{get;set;}
      public List<metricData > gettypesData(){
      
       showtypes=true;
        type = new List<metricData>();
        totpaymentcount  =[SELECT TicketTypes__r.EV_id__r.Attendee_Types__c w , SUM(customer_key__r.Total_Amount__c) c, count(id)
                          FROM Dummay__c 
                          WHERE Event__r.id=: EventString 
                          AND Payment_Type__c!= null
                          AND Payment_Type__c!= 'None' 
                          AND Primary_Attendee__c = true  
                          AND customer_key__r.Isinserted__c = true
                          GROUP BY TicketTypes__r.EV_id__r.Attendee_Types__c]; 
        system.debug('@@@@@@@@@@@@@@ '+ totpaymentcount);
  
        for(AggregateResult S:totpaymentcount)
        {
        totalcount=(Integer)S.get('c');
        attendeetypeName=(String)S.get('w');
            // Decimal paycountdecimal =(Decimal)S.get('c');
             //attendeetypeName=(String)S.get('w');
             //totalcount= Integer.valueof(paycountdecimal );
            type.add(new metricData(attendeetypeName,totalcount));
       }
        return type;  
    }

    // Inner class begins
    
     public class metricData {

        public String name { get; set; }
        public Integer data { get; set; }

        public metricData (String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }*/
  //-----------------------------------3 rd chart begins--------------  
 public integer RegCount1{get; set;}
  public integer RegCount2{get; set;}
   public integer RegCount3{get; set;}
    public integer RegCount4{get; set;}
 public Date Regdate{get; set;}
 public AggregateResult[] rchrt{get;set;}
 public string ForDate{get;set;}
 public LIST<regInner> reg{get;set;}
 public LIST<regInner> getregChart() 
 {  

 
 regdb=true;
  rchrt= [SELECT day_only(createddate) d,SUM(TicketAmount__c) c,count(id)
             FROM Dummay__c 
             WHERE Event__r.id=: EventString
             AND customer_key__c != Null 
             AND TicketTypes__c != Null 
             //AND Update_with_created_date__c != null
             AND customer_key__r.Isinserted__c = true 
             GROUP BY day_only(createddate)
             ORDER BY SUM(TicketAmount__c) DESC LIMIT 8
             ]; 
 system.debug('####################'+rchrt);
  reg= new LIST<regInner>();
  
  for(AggregateResult re : rchrt)     
  {
  //RegCount1 =0;
  //RegCount2 =0;
  //RegCount3 =0;
  //RegCount4 =0;
 // system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@'+re.get('p'));
  /**  if(re.get('p') == 'Paid'){
       
       Decimal typecountdec1 =(Decimal)re.get('c');
       RegCount1 = Integer.valueof(typecountdec1);  
       
   }

   else if(re.get('p') == 'Credit Card'){
      Decimal typecountdec2 =(Decimal)re.get('c');
      RegCount2  = Integer.valueof(typecountdec2);
   }
   else if(re.get('p') == 'Check'){
      Decimal typecountdec3 =(Decimal)re.get('c');
      RegCount3  = Integer.valueof(typecountdec3);
   }
   else if(re.get('p') == 'Invoice'){
      Decimal typecountdec4 =(Decimal)re.get('c');
      RegCount4  = Integer.valueof(typecountdec4);
   }
**/
     Decimal typecountdec1 =(Decimal)re.get('c');
       RegCount1 = Integer.valueof(typecountdec1); 
             Date d = (Date)re.get('d');
             forDate= d.format(); 
  
    // reg.add(new regInner (forDate,RegCount1,RegCount2,RegCount3,RegCount4));
    reg.add(new regInner (forDate,RegCount1));
  }
 system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%'+reg); 
  return reg; 
  
 } 
 
 
 
 //inner class
 public class regInner 
{
 public integer deci1{get;set;} 
// public integer deci2{get;set;} 
// public integer deci3{get;set;} 
// public integer deci4{get;set;} 
 //public Date date1{get;set;} 
 public  String DateString{get;set;}
 public regInner(String s, integer Deci1)  
 { 
 this.deci1 = deci1;
 //this.deci2 = deci2;
 //this.deci3 = deci3;
 //this.deci4 = deci4;
//this.date1= date2;
  this.DateString = s;
  
 }
}

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
 
}