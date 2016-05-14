@RestResource(urlMapping='/BLN_ASC_CancelTickets/*')
global class BLN_ASC_CancelTickets{
global static BLN_Mytickets_BAL ordersList {get ; set ;}
global static BLN_ASC_Checkin.TotalList  TL {get ; set ;}

@HttpPost  
  global static BLN_ASC_Checkin.TotalList  doPost(){ //Post Mthod
  RestRequest req = RestContext.Request;
  List<BLN_ASC_Checkin.maincontainer> Mc = new List<BLN_ASC_Checkin.maincontainer> ();
   TL = new BLN_ASC_Checkin.TotalList ();
  ordersList = new BLN_Mytickets_BAL();
  //Getting ticket id from requsted parameter
  string tid = req.params.get('ticketid');
  //Getting orderitem id from requsted parameter
  string oid = req.params.get('orderitemid');
  //Getting order id from requsted parameter
  string orid = req.params.get('orderid');
  
  string eventid = req.params.get('Event_id');
 
   
  BLN_Ticket_DAO btd = new BLN_Ticket_DAO();
  BLN_OrderItem_DAO bod = new BLN_OrderItem_DAO();
  BLN_Mytickets_BAL bm = new BLN_Mytickets_BAL();
  BLN_Order_DAO bd = new BLN_Order_DAO();
  BLN_MyticketsCon bmc = new BLN_MyticketsCon();
    
  if (tid != null && tid != ''){
  ticket__c tkt = new ticket__c();
  tkt = btd.tcWithTktPid(tid);
  system.debug('tkt.id==============================='+tkt.id);
  bmc.splitcancelPerticularGuestsTic(tkt.id); 
  ordersList.serviceorderid = tkt.Order__c ;
  }else if ( oid != null && oid != ''){
  system.debug('oid================'+oid);
  List<Order_Item__c> olist = new List<Order_Item__c>();
  olist = bod.getTicketsOfperticularOItem(oid);
  //bm.cancelOrderItemValues(olist);
  bmc.splitcancelDirectTicket(oid);
  ordersList.serviceorderid = olist[0].Order__c ;
  }else if ( orid  != null && orid  != ''){
  set<id> orset = new set<id>();
  orset.add(orid);
  bmc.splitcaceltotalorder(orset);
  ordersList.serviceorderid = orid ;
  }
  
  
  LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets('',eventid,'BLN_ASC_CancelTickets','');
   
    for(BLN_Mytickets_BAL.inncls cls : inlists){
         BLN_ASC_Checkin.maincontainer nemain= new BLN_ASC_Checkin.maincontainer();
         nemain.orderInn =cls.orderInn;
         nemain.dt=cls.dt;
         nemain.ticketsInn =cls.ticketsInn ;
         nemain.cancelledTickets=cls.cancelledTickets;
          nemain.paymentInn=cls.paymentInn;
         nemain.orderItemInn =cls.orderItemInn ;
         nemain.orderPrice= cls.orderPrice;
         Mc.add(nemain);
    }
    
    
     
    

 TL.TotalLists= Mc;
     TL.isorder=ordersList.isorder;//to check from mobile wheteher it is a orderqrcode or badgeqrcode
      return TL;
  
  
  }
  



}