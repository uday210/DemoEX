public with sharing class BLN_DashboardConBAL {
/***************************************************************
    *   Controller Name         : BLN_Dashboards
    *   Date                    : 30/10/2014 
    *   Author                  : Mythily Nagandla(mythilyn@globalnest.com)
    *   Purpose                 : This class is for Creating Dashboards.
******************************************************************/
public BLN_DashboardConBAL(){}
public AggregateResult[] paywithtics {get ; set ;}
public AggregateResult[] paymentwithticket(string selectedevent ){
  paywithtics = [SELECT count(id) c,SUM(Order__r.Order_Total__c) s,Item__r.item_name__c t FROM Order_Item__c WHERE  Item__r.Event__c =: selectedevent  AND (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' ) GROUP BY Item__r.item_name__c,Item__c ];//WHERE  Item__r.Event__c =: selectedevent
 return paywithtics ; 
}


public LIST<soldticketsinn> soldinn {get ; set ;}  
    public decimal booked {get ; set ;}
    public decimal Available {get ; set ;}
    public decimal totalticsNo {get ; set ;}
    public decimal soldtics {get ; set ;}
    public decimal attendeesreig {get ; set ;}
    
    public LIST<soldticketsinn> TotalTics(string selectedevent){
        soldtics =0;
        attendeesreig =0;
        soldinn  = new LIST<soldticketsinn> ();
          
           LIST<Ticket__c> tics = [SELECT (select id,Ticket__c,Tstatus_name__c from Tstatus__r ORDER BY CreatedDate),id,Item__r.id,Ticket_Status__c,Item_Type__r.Name FROM Ticket__c WHERE  Item__r.Event__c =: selectedEvent  AND (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' ) ];
         MAP<id,integer> countChkWithTic = new MAP<id,integer>();
           for(Ticket__c tcs : tics ){
           integer tChIncount = 0; integer  tChoutcount = 0;
               for(Tstatus__c ts :tcs.Tstatus__r){
                  if(ts.Tstatus_name__c){
                    tChIncount++; 
                  }else{
                    tChoutcount++;
                  }
              }
              countChkWithTic.put(tcs.id,(tChIncount-tChoutcount));     
           }
          
          
          LIST<BLN_Item__c> items = [SELECT (SELECT id,tkt_profile__r.First_Name__c from Item__r),id,Name,item_type__r.Name,item_name__c,price__c,item_count__c FROM BLN_Item__c WHERE Event__c =: selectedEvent ];
            MAP<string,decimal> itemsmapcount = new MAP<string,decimal> ();
           MAP<id,integer> itemWithQuan = new MAP<id,integer>(); 
            
            for(BLN_Item__c its : items){        
                itemsmapcount.put (its.id,its.item_count__c);
                integer chkCount = 0;
                for(Ticket__c tcp : its.Item__r){
                 if(null != countChkWithTic.get(tcp.id)){
                   chkCount+=countChkWithTic.get(tcp.id); 
            }
                }
                itemWithQuan.put(its.id,chkCount);
            }
            //system.debug('::::::::::::;;;ex:::::::::;'+expected);      
         
         
         booked =0;
         available = 0;
         for(BLN_Item__c item : items){
         booked =0;
         available = 0;
             for(Ticket__c tt : tics){
                 if(tt.Item__r.id == item.id && tt.Ticket_Status__c == 'Booked' ){
                    booked ++; 
         
                 }else if(tt.Item__r.id == item.id && tt.Ticket_Status__c != 'Booked' ){
                     //available ++;
                 }        
             }
                 
             available = available + (item.item_count__c - booked);
             string typename = item.item_name__c;
             soldinn.add(new soldticketsinn(booked,available,typename,itemWithQuan.get(item.id),item.price__c));
              soldtics= soldtics+booked;   
             }
             return soldinn;
     }
     //---------------------------------------------------------
     public  AggregateResult[] paymentsresult {get ; set ;}
     public  AggregateResult[]  paymenttype( string selectedEvent){
        paymentsresult = [SELECT Payment_Mode__c p,SUM(Order__r.Order_Total__c) s FROM Payment__c WHERE Order__r.Events__c =:selectedEvent  AND (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' ) GROUP BY Payment_Mode__c];
     return paymentsresult;
     }
 
    
//INNER CLASS FOR TOTAL NO OF TICKETS Vs SOLD TICKETS REPORT 
    public class soldticketsinn {
        public String TIC {get;set;} 
        public decimal SOLD{get;set;} 
        public decimal Available{get;set;} 
        public Integer CheckinQuan {get;set;}
        public Decimal tcPrice{get;set;}
        public soldticketsinn(decimal SOLD ,decimal Available,String TIC,integer chQ,Decimal tcp)  { 
            this.SOLD =SOLD ;
            this.Available=Available;
            this.TIC  =TIC  ;
            this.CheckinQuan =chQ;
            this.tcPrice = tcp;
        }
    }
    
    
  public LIST<Checkin> TotalCheckIn(string selectedevent){
       
       List<Checkin> chklist=new List<Checkin>();
       LIST<BLN_Item__c> items = [SELECT id,Name,item_type__r.Name,item_name__c,price__c,item_count__c FROM BLN_Item__c WHERE Event__c =: selectedEvent ];
            
       LIST<Ticket__c> tics = [SELECT id,Tstatus_Id__r.Tstatus_name__c,Item__r.id,Ticket_Status__c,Item_Type__r.Name FROM Ticket__c WHERE  Item__r.Event__c =: selectedEvent  AND (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' )];
         decimal checkincount=0;
         decimal TicketSold=0;
       for(BLN_Item__c item : items){
        checkincount=0;
        set<id> tid = new set<id>();
            for(Ticket__c tt : tics){
                 if(tt.Item__r.id == item.id && tt.Ticket_Status__c == 'Booked'&& tt.Tstatus_Id__r.Tstatus_name__c==true ){
                   checkincount++; 
                 }  
                  if(tt.Item__r.id == item.id && tt.Ticket_Status__c == 'Booked'&& tt.Ticket_Status__c!='Cancelled'){
                   //TicketSold++; 
                   tid.add(tt.id);
                 }
                 
             }
                 
             Checkin chk=new Checkin();
                chk.TotalTicketSold= tid.size();
                chk.TotalTicketCount=item.item_count__c ;
                chk.TotalCheckInCount=checkincount++;
                chk.ItemName=item.item_name__c;
                chk.ItemId=item.Id;
                 chklist.add(chk);   
             }
             return chklist;
     }  
    
public class Checkin
    {  public Decimal TotalTicketSold{get;set;}
       public Decimal TotalTicketCount{get;set;}
       public String ItemName{get;set;}
       public String ItemId{get;set;}
       public Decimal TotalCheckInCount{get;set;}
    }


}