/***********************************************************************************************
*   Service Name : BLN_ASC_EventRefresh
*   Date            : 30/12/2014
*   Author          : Arindam Sarkar
*   Purpose         : This class is Web service Class to get the the refreshed data for events,ticket,attendees
**************************************************************************************************/

@RestResource(urlMapping='/BLN_ASC_EventRefresh')

global class BLN_ASC_EventRefresh{

 @HttpPost  
    global static Main doPost(){
    RestRequest req = RestContext.request; 
    system.debug('req === '+req);
        String EventId= req.params.get('Event_id'); 
        String LastModifiedDate= req.params.get('LastModifiedDate');
        String UserId= req.params.get('User_id');
         String appname = req.params.get('appname');
         String requestflag=req.params.get('Request_Flag');
         
        system.debug('EventId === '+EventId);
        system.debug('LastModifiedDate === '+LastModifiedDate);
         GN_User__c gnuser =new GN_User__c();
        gnuser =  [select id from GN_User__c where User__c=:UserId];
        DateTime modupdate;
        try{
        modupdate=DateTime.valueOfgmt(LastModifiedDate);
        }catch(Exception e){}
        
        BLN_ASC_EventRefresh.Main m=new BLN_ASC_EventRefresh.Main();
        if(requestflag.equalsIgnoreCase('Event')){
        BLN_ASC_Events.refresheventid=EventId;
        try{
        BLN_ASC_Events.formatedDt = modupdate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'','GMT');
        System.debug(' UUUUUUUUUUUUU '+BLN_ASC_Events.formatedDt);
        }catch(Exception e){BLN_ASC_Events.formatedDt=null;}
        BLN_ASC_Events.maincontainer ascEve=BLN_ASC_Events.doPost();
        m.BLN_ASC_EventsOUTPUT=ascEve;
        }
        if(requestflag.equalsIgnoreCase('Itemandattendees')){
        system.debug('@@eveid'+EventId);
        //for getting last edited orders from order
        Set<String> orderids=new Set<String>();
        
         BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
        system.debug(' LLLLLLLLLLLLLL '+modupdate);
        String formatedDt = modupdate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'','GMT');
        system.debug(' KKKKKKKKKKKKKK '+formatedDt);
        Boolean isAttendee =true;
        BLN_Quick_Registration_BAL QuickRegBAL = new BLN_Quick_Registration_BAL();
        BLN_EVent__c  evedetails = new BLN_EVent__c ();
        evedetails = QuickRegBAL.getEventDetails(EventId);
        List<UC_Role__c> ucroles =new List<UC_Role__c>(); 
        // Checing user profile to send orders
       
        try{
           
          ucroles = [select id,Event__c,RoleId__r.Name,GN_User__c from UC_Role__c Where Company__c=:evedetails.organizer_id__c AND GN_User__c=:gnuser.id];
          System.debug(' MMMMMMMMMMMMMMMMM '+ucroles);
           if(ucroles.size()>0){
               isAttendee=false;
           }
        }catch(Exception yt){

        }
    System.debug(' UUUUUUUUUUUUUUUc Role '+isAttendee);
      if(!isAttendee){  
     String wherecondition ='where order_type__c !=\'EVENT PRODUCER\'';
       wherecondition += ' and Order_Status__c != \''+'Abandoned'+'\'';
       wherecondition += ' and Events__c = \''+EventId+'\'';
      wherecondition += ' and (lastmodifieddate>='+formatedDt +')';
      List<Order__c> ordlist= blnOrderDao.orderQuery(wherecondition); 
      for(Order__c ord:ordlist)
      {
        orderids.add(ord.id);
      }
      //for getting last edited order from order items
      wherecondition =' where Order__r.order_type__c !=\'EVENT PRODUCER\'';
       wherecondition += ' and Order__r.Order_Status__c != \''+'Abandoned'+'\'';
       wherecondition += ' and Order__r.Events__c = \''+EventId+'\'';
      wherecondition += ' and (lastmodifieddate>='+formatedDt +')';
      String querystring='select id,name,lastmodifieddate,Order__c,Order__r.Order_Status__c,Order__r.Events__c,Order__r.order_type__c  from Order_Item__c ';
      List<Order_Item__c> orditemlist=dataBase.query(querystring+wherecondition);
      for(Order_Item__c orditem:orditemlist)
      {
        orderids.add(orditem.Order__c);
      }
      
           
      //for getting last edited order from payments
      wherecondition =' where Order__r.order_type__c !=\'EVENT PRODUCER\'';
       wherecondition += ' and Order__r.Order_Status__c != \''+'Abandoned'+'\'';
       wherecondition += ' and Order__r.Events__c = \''+EventId+'\'';
      wherecondition += ' and (lastmodifieddate>='+formatedDt +')';
      querystring='select id,name,lastmodifieddate,Order__c,Order__r.Order_Status__c,Order__r.Events__c,Order__r.order_type__c  from Payment__c ';
      List<Payment__c> paylist=dataBase.query(querystring+wherecondition);
      for(Payment__c pay:paylist)
      {
        orderids.add(pay.Order__c);
      }
      
      //for getting last edited order from tickets
      wherecondition =' where Order__r.order_type__c !=\'EVENT PRODUCER\'';
       wherecondition += ' and Order__r.Order_Status__c != \''+'Abandoned'+'\'';
       wherecondition += ' and Order__r.Events__c = \''+EventId+'\'';
       wherecondition += ' and Order__c != null';
      wherecondition += ' and (lastmodifieddate>='+formatedDt +')';
      querystring='select id,name,lastmodifieddate,Order__c,Order__r.Order_Status__c,Order__r.Events__c,Order__r.order_type__c  from Ticket__c';
      List<Ticket__c> tclist=dataBase.query(querystring+wherecondition);
      for(Ticket__c tc:tclist){
        orderids.add(tc.Order__c);
      }
      try{
        BLN_ASC_ItemsList.moddate=DateTime.valueOfGmt(LastModifiedDate);
        List<BLN_ASC_ItemsList.Itemscls_info> ascItemlist=BLN_ASC_ItemsList.doPost();
        m.BLN_ASC_ItemsListOUTPUT=ascItemlist;
      }catch(exception tr){}

    }else{
      //Gettign user scanble items    
       BLN_Scanusr_item_DAO scanitemDao = new BLN_Scanusr_item_DAO();
       SET<id> scanPoolIds = new SET<id>(); 
       for(BLN_Scanusr_item__c  scanItem: scanitemDao.getUsrScanItms(userId,EventId)){
         scanPoolIds.add(scanItem.BLN_Item_Pool__c);
       }
       System.debug(' KKKKKKKKKKKKKKKK '+formatedDt);
       String qry ='Select id,Order__c,Order__r.lastmodifieddate,lastmodifieddate,tkt_profile__r.lastmodifieddate from Ticket__c where Item_Pool__c IN :scanPoolIds AND tkt_profile__r.BLN_GN_User__r.User__c!=:UserId AND Ticket_Status__c=\'Booked\' AND Order__r.Events__c =:EventId  AND Order__r.order_type__c!=\'EVENT PRODUCER\' AND Order__r.Order_Status__c !=\'Abandoned\' AND (lastmodifieddate>='+formatedDt+' OR Order__r.lastmodifieddate>='+formatedDt+' OR tkt_profile__r.lastmodifieddate>='+formatedDt+')';
       System.debug('  '+qry);
       
        for (Ticket__c tc:Database.query(qry)){
           System.debug('   vvvvvvvvvv '+tc.tkt_profile__r.lastmodifieddate);
        orderids.add(tc.Order__c);
      }
     }  
System.debug('HHHHHHHHHHHHHHH '+orderids);
      String idInClause = '(\'';
      if(orderids.size()>0)
      {
         for(String orderid:orderids)  {
          
               idInClause += orderid+ '\',\'';
           }
         idInClause  = idInClause.substring(0,idInClause.length()-2);
         idInClause += ')';
         
        BLN_Mytickets_BAL ordersList = new BLN_Mytickets_BAL();
        ordersList.orderId=idInClause;
        
       LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets(Userid,eventid,'BLN_ASC_EventRefresh','');
       List<BLN_ASC_AttendeeLoadMore.maincontainer> Mc = new List<BLN_ASC_AttendeeLoadMore.maincontainer> ();
      m.ticketTags=new List<Hash_Tag__c>();
      for(BLN_Mytickets_BAL.inncls cls : inlists){
         BLN_ASC_AttendeeLoadMore.maincontainer nemain= new BLN_ASC_AttendeeLoadMore.maincontainer();
         nemain.orderInn =cls.orderInn;
         nemain.dt=cls.dt;
         nemain.ticketsInn =cls.ticketsInn ;
         nemain.cancelledTickets=cls.cancelledTickets;
          nemain.paymentInn=cls.paymentInn;
         nemain.orderItemInn =cls.orderItemInn ;
         nemain.orderPrice= cls.orderPrice;
         nemain.compListInner =cls.compListInner ;
         m.ticketTags = cls.ticketTags;
         Mc.add(nemain);
    }
    
    
     m.TotalLists= Mc;
      }
        }
        m.LastRefreshedDate=system.now().formatGMT('yyyy-MM-dd HH:mm:ss');
        return m;
    
    }
    
    
    global class Main
    {
       BLN_ASC_Events.maincontainer BLN_ASC_EventsOUTPUT{get;set;}
       public List<BLN_ASC_AttendeeLoadMore.maincontainer> TotalLists{get ; set ;}
       public List<Hash_Tag__c> ticketTags{get;set;}
       List<BLN_ASC_ItemsList.Itemscls_info> BLN_ASC_ItemsListOUTPUT{get;set;}
       public String LastRefreshedDate{get;set;}
    }
    
    
    
    
    
 }