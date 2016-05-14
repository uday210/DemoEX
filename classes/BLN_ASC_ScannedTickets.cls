@RestResource(urlMapping='/BLN_ASC_ScannedTickets/*')
/***********************************************************************************************
*   Service Name : BLN_ASC_ScannedTickets
*   Date            : 26/12/2014
*   Author          : Arindam Sarkar
*   Purpose         : This class is for getting all tickets,payment,order items based on order id
*   Reused class    : BLN_ASC_Checkin,BLN_Mytickets_BAL
************************************************************************************************/
  

    global with sharing class BLN_ASC_ScannedTickets{
    global static BLN_Mytickets_BAL ordersList {get ; set ;}
    global static BLN_ASC_Checkin.TotalList  TL {get ; set ;}
    
    
    @HttpPost  
    global static BLN_ASC_Checkin.TotalList doPost(){
        RestRequest req = RestContext.request;  
        String OrderID = req.params.get('Order_Id');
        RestResponse response = RestContext.response; 
        List<BLN_ASC_Checkin.maincontainer> Mc = new List<BLN_ASC_Checkin.maincontainer> ();
   TL = new BLN_ASC_Checkin.TotalList ();
   //ord = new Ordersonly ();
    string eventid = req.params.get('Event_id');
    string Userid = req.params.get('User_id'); 
    String itemPoolId = req.params.get('itemId');

     if(null!=itemPoolId){
       BLN_InsertSessionTcs inst = new BLN_InsertSessionTcs();
       inst.checkUserBuyInfo(eventid, OrderID, itemPoolId) ;  
     }

    String tics = '';
    ordersList = new BLN_Mytickets_BAL();
    Map<id,string> mapdemo  = new Map<id,string>();
    ordersList.orderId=OrderID;
    
   LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets(Userid,eventid,'BLN_ASC_ScannedTickets','');
   
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