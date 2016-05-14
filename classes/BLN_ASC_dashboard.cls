/******************************************************
*   Author                  : Mythily Nagandla
*   Date                    : 14/12/2014 
*   Purpose                 : This is Web Service class for getting statistics and dash board values.
********************************************************/
@RestResource(urlMapping='/BLN_ASC_dashboard/*')
global class BLN_ASC_dashboard{
global static maincontainer  Mc {get;set;}
global static  BLN_DashboardConBAL Dashboardcon {get ; set ;}
@HttpPost  
  global static maincontainer  doPost(){ //Post Mthod
   RestRequest req = RestContext.Request;
   string Eventid = req.params.get('Event_id');
   Mc = new maincontainer();
  //cookie  counter = new Cookie('counter',Eventid ,null,-1,false);
  //ApexPages.currentPage().setCookies(new Cookie[]{counter});
  Dashboardcon = new BLN_DashboardConBAL();
  
   BLN_DashboardCon Dashboardcon1 = new BLN_DashboardCon(Eventid);
  //Dashboardcon.selectedEvent = Eventid ;
  //List<BLN_DashboardCon.ticetpaymentinner> ticketList = Dashboardcon.getpaymentwithtickettype(Eventid);
  stats sts = new stats();
  sts.TotalTickets = Dashboardcon1.totalticsNo;
  sts.TotalTicketsSold = Dashboardcon1.soldtics;
  sts.RevenueGenerated = Dashboardcon1.generated;
  sts.TotalOrders = Dashboardcon1.registeredatt;
  sts.TotalAttendeesRegistered = Dashboardcon1.attendeesreig;
  sts.TotalCheckInCount = Dashboardcon1.Totalnoofcheckinsevent;
  MC.Statistics = sts;
  
  List<payvstype> PTs = new List<payvstype> ();
  Map<String,Decimal> payedamountmap=new Map<String,Decimal>();
  AggregateResult[] aggvalues =  Dashboardcon.paymentwithticket(Eventid);
  for(AggregateResult ag  : aggvalues ){
  payvstype PT = new payvstype ();
  PT.tictype = (String)ag.get('t');
  PT.payment = (decimal)ag.get('s');
  payedamountmap.put(PT.tictype,PT.payment);
  PTs.add(PT);
  }
  Mc.PaymentVsTicketTypes = PTs;
  
  //--------------------------------------
  List<soldvsavl> SLS = new List<soldvsavl> ();
  List<BLN_DashboardConBAL.soldticketsinn> soldVsavltics = Dashboardcon.TotalTics(Eventid);
  for(BLN_DashboardConBAL.soldticketsinn SA : soldVsavltics){
   Decimal payed=payedamountmap.get(SA.TIC)==null?0:payedamountmap.get(SA.TIC);
   SLS.add(new soldvsavl (SA.SOLD,SA.Available,SA.TIC,SA.CheckinQuan,SA.tcPrice,payed ));
  }
  Mc.Soldtics = SLS;
  
  //-----------------------------------------
  
  
  //-----------------------------------------
  //-------------------------------------------------
  List<Payments> paymenstypes = new List<Payments> ();
  decimal payedamount =0;
  string paytype='';
  AggregateResult[] payvals =  Dashboardcon.paymenttype(Eventid);
  for(AggregateResult pay : payvals )     
          {
           payedamount =(decimal)pay.get('s');
           paytype=(String)pay.get('p');
           paymenstypes.add(new Payments(paytype,payedamount ));
           system.debug('::::::::::::::PAY INNER:::::::::::::;'+paymenstypes);
          }
     Mc.PaymentVsPaymentTypes = paymenstypes;
     Mc.Checkins=new List<BLN_DashboardConBAL.Checkin>();
     Mc.Checkins= Dashboardcon.TotalCheckIn(Eventid);
  
  return Mc;
   
  }
  
  global class maincontainer  {
  public List<Payments> PaymentVsPaymentTypes {get ; set ;}
  public List<payvstype> PaymentVsTicketTypes {get ; set ;}
  public List<soldvsavl> Soldtics {get ; set ;}
  public List<BLN_DashboardConBAL.Checkin> Checkins{get;set;}
  public stats Statistics{get;set;}
  }
  global class payvstype{
    public string tictype {get ; set ;}
    public decimal payment {get ; set ;}

  }
    global class stats{
    public decimal  TotalTickets{get ; set ;}
    public decimal  TotalTicketsSold{get ; set ;}
    public decimal  RevenueGenerated{get ; set ;}
    public integer  TotalOrders{get ; set ;}
    public decimal  TotalAttendeesRegistered{get ; set ;}
    public decimal  TotalCheckInCount{get ; set ;}
  
  }
  global class soldvsavl{
   public String TIC {get;set;} 
        public decimal SOLD{get;set;} 
        public decimal Available{get;set;} 
        public Integer CheckinQuan {get;set;}
        public Decimal ticketPrice{get;set;}
        
        public Decimal PayedAmount{get;set;}
        
        public soldvsavl(decimal SOLD ,decimal Available,String TIC,integer chkQu,Decimal tcp,Decimal PayedAmount)  { 
            this.SOLD =SOLD ;
            this.Available=Available;
            this.TIC  =TIC  ;
            this.CheckinQuan = chkQu;
            this.ticketPrice = tcp;
            this.PayedAmount=PayedAmount;
            
        }
        public soldvsavl(){}
  
  
  }
  //INNER CLASS FOR PAYMENT Vs PAYMENT TYPE REPORT 
    public class Payments
{
     public decimal amount{get;set;} 
     public String paytype{get;set;} 
     public Payments(String paytype, decimal amount)  
     { 
         this.amount= amount;
         this.paytype= paytype;      
     }
}




  
}