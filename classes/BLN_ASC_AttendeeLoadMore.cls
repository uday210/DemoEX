@RestResource(urlMapping='/BLN_ASC_AttendeeLoadMore/*')

global class BLN_ASC_AttendeeLoadMore{


global static BLN_Mytickets_BAL ordersList {get ; set ;}
//global static BLN_Item_DAO itemsDao {get; set ;}
//global static List<Ordersonly> ord {get ; set ;}
 //global static List<Itemscls_info> ct1 {get ; set ;}
 global static TotalList  TL {get ; set ;}
  @HttpPost  
    global static TotalList doPost(){ 
    //itemsDao = new BLN_Item_DAO ();
    RestRequest req = RestContext.request;
   List<maincontainer> Mc = new List<maincontainer> ();
   TL = new TotalList ();
   //ord = new Ordersonly ();
    string eventid = req.params.get('Event_id');
    string Userid = req.params.get('User_id'); 
      System.debug(' H HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH '+Userid);
    BLN_PromoCode_BAL promo =new BLN_PromoCode_BAL();
    BLN_Event__c se = new BLN_Event__c(); 
    se = promo.eventdetails(eventid);
    integer limitval =0;
     if(se.scan_attendee_limit__c!=null){
       limitval =integer.valueOf(se.scan_attendee_limit__c);
      } 
      
     // integer offsetp=Integer.valueOf(req.params.get('offset'));
      String offsetp=req.params.get('offset');
     // integer limitsp=Integer.valueOf(req.params.get('limit')==null?'0':req.params.get('limit'));
         integer limitsp=limitval;
    ordersList = new BLN_Mytickets_BAL();
    Map<id,string> mapdemo  = new Map<id,string>();
    ordersList.offset=offsetp;
    ordersList.limits=limitsp;
    try{
    //if(Userid!=se.ownerid)
      //      Userid=se.ownerid;
            }catch(Exception e){}
   LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets(Userid,eventid,'BLN_ASC_AttendeeLoadMore','');
   TL.ticketTags=new List<Hash_Tag__c>();
    for(BLN_Mytickets_BAL.inncls cls : inlists){
         maincontainer nemain= new maincontainer();
         nemain.orderInn =cls.orderInn;
         nemain.dt=cls.dt;
         nemain.ticketsInn =cls.ticketsInn ;
         nemain.cancelledTickets=cls.cancelledTickets;
          nemain.paymentInn=cls.paymentInn;
         nemain.orderItemInn =cls.orderItemInn ;
         nemain.orderPrice= cls.orderPrice;
         nemain.compListInner =cls.compListInner ;
          TL.ticketTags = cls.ticketTags;
         Mc.add(nemain);
    }
    
    
     
     
     TL.TotalLists= Mc;
      return TL;
    
    }
    
   global class maincontainer {
        public order__c orderInn{get;set;}
        public dateTime dt{get;set;}
        public List<Ticket__c> ticketsInn{get;set;}
        public List<Ticket__c> cancelledTickets{get;set;}
        public payment__c paymentInn{get;set;}
        public List<order_Item__c>  orderItemInn {get;set;}
        public decimal orderPrice{get;set;}
        public List<company__c> compListInner {get;set;}
         //public List<Hash_Tag__c> ticketTags{get;set;}
        public maincontainer (){
       
        }
       
   
   } 
   global class Ordersonly{
   public Order__c OrdersList_info {get ; set ;}
   public Ordersonly(){}
   
   }
   
   global class TotalList{
   public List<maincontainer> TotalLists{get ; set ;}
   public List<Hash_Tag__c> ticketTags{get;set;}
   public boolean isorder{get;set;}
   
   public TotalList(){
    TotalLists= new List<maincontainer> ();
    
   }
   
   }
    
}