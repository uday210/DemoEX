@RestResource(urlMapping='/ED_WS_EventDetails')
global class ED_WS_EventDetails{

    static BLN_Events_DAO eventsDAO = new BLN_Events_DAO();
    global static BLN_Mytickets_BAL ordersList {get ; set ;}
    
   static container res = new container();
    
    @HttpPost
    global static AllOrders doPost(){
        
        AllOrders allOrds = new AllOrders();
        
        RestRequest req = RestContext.request;
        String EventId = req.params.get('eveid');
        String userid = req.params.get('userid');
        if(EventId==null || EventId==''){
            allOrds.ErrorMsg = 'Please send Valid Event Id';
            return allOrds;          
        }else{
            allOrds.EventDetails = eventsDAO.getEventDetails(EventId);           
        }
        
        ordersList = new BLN_Mytickets_BAL();
        LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets(userid,EventId,'BLN_Mytickets','');
         
        
        List<container> conlist = new List<container>();
        system.debug('inlists========='+inlists);    
        //system.debug('inlists =========='+inlists );
        if(inlists.size()>0){                
            for(BLN_Mytickets_BAL.inncls cls : inlists){
              container res1 = new container();
             //  system.debug('orderItemInn===='+cls.orderItemInn);
                //res.UserTickets = cls.ticketsInn;
                res1.orders= cls.orderInn;
                res1.paymentInn = cls.paymentInn;
                //res.UserOrderItems.addAll(cls.orderItemInn);               
              conlist.add(res1); 
            } 
            allOrds.AllOrdersList = conlist;
            
        }
      return allOrds;
    }
    
    global class container{
      //public BLN_Event__c EventDetails = new BLN_Event__c();
      //public List<Ticket__c> UserTickets{get;set;} 
      public Order__c orders{get;set;} 
      public  payment__c  paymentInn{get;set;}
      //public List<order_Item__c> UserOrderItems = new List<order_Item__c>();
      //public String ErrorMsg;      
    }
    
    global class AllOrders{
        List<container> AllOrdersList = new List<container>();
        public BLN_Event__c EventDetails = new BLN_Event__c();
        public String ErrorMsg; 
    }

}