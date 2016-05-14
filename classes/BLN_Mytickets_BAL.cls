/***********************************************************************************************
*   Controller Name : BLN_MyticketsCon
*   Date            : 05/19/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is for show and edit tickets
*   Change History  : 05/19/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  05/19/2014          Phani Kumar ch                   To Create Page
*  06/30/2014          Phani Kumar Ch                   New Feature was came it is allowing Duplicates
   07/02/2014          Phani Kumar ch                   Removing createTicketsWithNewOderitem (Durga said no need to linlk up tickets with new order item)
**************************************************************************************************/

global class BLN_Mytickets_BAL{
   public String orderId{get;set;}
   public boolean isorder{get;set;}//used for scanned service in mobile to check whether it is a orderqrcode or badgeqrcode
  public String searchstring{get;set;}
  //variables for attendee load more
  public String offset{get;set;}
  public integer limits{get;set;}
  public DateTime moddate{get; set ;}
  public String serviceorderid{get;set;}   
       
  //
   // to get all events of login user 
    public List<BLN_Event__c> getEvents(string userId){
     BLN_Ticket_DAO blnTdao = new BLN_Ticket_DAO();
     BLN_Event_DAO blnEdao = new BLN_Event_DAO();
     SET<id> eventids =new  SET<id>();
     string temp = ' where Client_GN_User__r.User__c = \''+userId+'\''+' or order__r.Client_GN_User__r.User__c = \''+userId+'\'';
      for(ticket__c tc : blnTdao.userOrderAndTickets(temp)){
          eventids.add(tc.event__c);
       }
       return  blnEdao.getevents(eventids);
     }
   
   // This Method is for getting the order,order items and tickets of users
   public List<BLN_Mytickets_BAL.inncls>  userTickets(string userId,string eveId,string page, String filterType){
    BLN_Ticket_DAO blnDao = new BLN_Ticket_DAO();
    BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
    BLN_OrderItem_DAO blnOrderItemDao = new BLN_OrderItem_DAO();
    List<inncls> inn = new List<inncls>();
    SET<id> orderIds = new SET<id>();
    MAP<id,List<ticket__c>>  mapOrdIdwithTic = new  MAP<id,List<ticket__c>>();
    string wherecondition ='';
       system.debug('wwwwwwwwwww '+eveId );
       BLN_Quick_Registration_BAL QuickRegBAL = new BLN_Quick_Registration_BAL();
         BLN_EVent__c  evedetails = new BLN_EVent__c ();
         evedetails = QuickRegBAL.getEventDetails(eveId);
       system.debug('SSSSSSSSSSSSS '+userId ); 
       system.debug('wwwwwwwwwww '+evedetails ); 
       system.debug('qqqqqqqqqqq '+page ); 
    
    string CompanyId = string.valueOf(evedetails.organizer_id__c);
    system.debug('----CompanyId ----- '+CompanyId );
     List<UC_Role__c> UcRolname = new list<UC_Role__c>();
       BLN_UCRole_DAO Ucrl = new BLN_UCRole_DAO();
        List<id> uids = new List<id>();
         boolean IsFullAdmin = false;
    if(userId != null && userId != ''){
    	
    	
   
    uids.add(Id.ValueOf(userId));
    
    UcRolname = Ucrl.UserRoleBasedOnGnUserAndCompany(uids,CompanyId);
    
   
    if(UcRolname.size()>0)
    {
        if(UcRolname[0].RoleId__r.name!=null){
        if(UcRolname[0].RoleId__r.name=='Full Admin'){
            IsFullAdmin = true;
        }
        }
        
    }
    }
    system.debug('--@nil-Is Full Admin---- '+IsFullAdmin);
   // system.debug('--Role Id name----- '+UcRolname.size());
    
     if(page=='BLN_Mytickets'){
          wherecondition = ' where BLN_TKT_profile__r.BLN_GN_User__r.user__c = \''+userId+'\'';
           wherecondition += ' and Order_Status__c != \''+'Abandoned'+'\'';
      system.debug('--@nil-Is Full Admin--mytkts-- ' + IsFullAdmin);
    } else if (page == 'BLN_ASC_ScannedTickets') {
          //for orderqrcode
         wherecondition = ' where id= \''+orderId+'\'';
    } else if (page == 'BLN_ASC_SearchAttendee' || page == 'BLN_ASC_ED_SearchAttendee') {
      // wherecondition = ' where BLN_TKT_profile__r.First_Name__c like \'%' + searchstring + '%\' or BLN_TKT_profile__r.Last_Name__c like \'%' + searchstring + '%\' or BLN_TKT_profile__r.Email__c like \'%' + searchstring + '%\' or BLN_TKT_profile__r.TKT_Company__c like \'%' + searchstring + '%\'';
       SET<id> scanPoolIds = new SET<id>();
       SET<String> odids = new SET<String>(); 
       String strsearch = '%' + searchstring + '%';
       System.debug(' Search String Value  '+searchstring);
       if (userId == evedetails.owner.id || IsFullAdmin == true ) {
         //Getting search string from Order owner
          for(Order__c ord : [SELECT id from Order__c Where Events__c =:eveId and order_type__c!='EVENT PRODUCER' and Order_Status__c !='Abandoned' AND (BLN_TKT_profile__r.First_Name__c like :strsearch OR BLN_TKT_profile__r.Last_Name__c like :strsearch  OR BLN_TKT_profile__r.Email__c like :strsearch  OR BLN_TKT_profile__r.TKT_Company__c like :strsearch) ]){
            odids.add(ord.id);
          }
          for(Ticket__c tc : [SELECT id,Order__c from Ticket__c Where (tkt_profile__r.First_Name__c like :strsearch OR tkt_profile__r.Last_Name__c like :strsearch  OR tkt_profile__r.Email__c like :strsearch  OR tkt_profile__r.TKT_Company__c like :strsearch) AND  Order__r.Events__c =:eveId and Order__r.order_type__c!='EVENT PRODUCER' and Order__r.Order_Status__c !='Abandoned' ]){
            odids.add(tc.Order__c);
          }
        }else{ // For scan attendee User 
        if (page != 'BLN_ASC_ED_SearchAttendee') {
          BLN_Scanusr_item_DAO scanitemDao = new BLN_Scanusr_item_DAO();
           for(BLN_Scanusr_item__c  scanItem: scanitemDao.getUsrScanItms(userId,eveId)){
             scanPoolIds.add(scanItem.BLN_Item_Pool__c);
           }
          for(Ticket__c tk:[select id,Order__c from Ticket__c where (tkt_profile__r.First_Name__c like :strsearch OR tkt_profile__r.Last_Name__c like :strsearch  OR tkt_profile__r.Email__c like :strsearch  OR tkt_profile__r.TKT_Company__c like :strsearch) AND Item_Pool__c IN :scanPoolIds AND Ticket_Status__c='Booked' AND  Order__r.Events__c =:eveId and Order__r.order_type__c!='EVENT PRODUCER' and Order__r.Order_Status__c !='Abandoned']){
            odids.add(tk.Order__c);
     }
        } else{
          for (Ticket__c tk : [select id, Order__c from Ticket__c where (tkt_profile__r.First_Name__c like :strsearch OR tkt_profile__r.Last_Name__c like :strsearch  OR tkt_profile__r.Email__c like :strsearch  OR tkt_profile__r.TKT_Company__c like :strsearch) AND  Ticket_Status__c = 'Booked' AND  Order__r.Events__c = :eveId and Order__r.order_type__c != 'EVENT PRODUCER' and Order__r.Order_Status__c != 'Abandoned']) {
            odids.add(tk.Order__c);
          }
        }
     }
       System.debug(' od ids valuesssss '+odids.size());
       String idInClause='';
        if(odids.size()>0){
             idInClause = '(\'';
            for(String orderid:odids)  {
              idInClause += orderid+ '\',\'';
            }
           idInClause  = idInClause.substring(0,idInClause.length()-2);
           idInClause += ')'; 
           System.debug(' wherecondition '+wherecondition);
        }else{
             idInClause = '(\'';
            idInClause += '\')';
          }   
           wherecondition = ' where order_type__c !=\'EVENT PRODUCER\'';
           wherecondition += ' and Order_Status__c != \'' + 'Abandoned' + '\'';
           wherecondition +=' And Id IN '+idInClause;
    } else if (page == 'BLN_ASC_CancelTickets') {
          //for orderqrcode
     wherecondition =' where id =\''+serviceorderid+'\'';
    } else if (page == 'BLN_ASC_EventRefresh') {
        wherecondition =' where id in '+orderId;
    } else if (page == 'BLN_Orders') { // for export orders add by rajendra
      wherecondition = 'where order_type__c !=\'EVENT PRODUCER\'';
      wherecondition += ' and Order_Status__c != \'' + 'Abandoned' + '\'';
      wherecondition += ' and Events__c = \'' + eveId + '\'';
    } else if (page == 'BLN_ASC_AttendeeLoadMore') { //By Phani
      if (userId == evedetails.owner.id || IsFullAdmin == true ) {
        wherecondition = ' where order_type__c !=\'EVENT PRODUCER\'';
        wherecondition += ' and  Events__c = \'' + eveId + '\'';
        if (orderId != null && orderId != '')
          wherecondition += ' and id= \'' + orderId + '\'';
        if (offset != '' && offset != null)
          wherecondition = wherecondition + ' and Id > \'' + offset + '\'';
        if (limits != null && limits != 0) //used only from attendeeloadmore
          wherecondition = wherecondition + ' Order By id ' + ' limit ' + limits ;
      } else {
        //getting items can scanned buy user
           BLN_Scanusr_item_DAO scanitemDao = new BLN_Scanusr_item_DAO();
           SET<id> scanPoolIds = new SET<id>(); 
            for(BLN_Scanusr_item__c  scanItem: scanitemDao.getUsrScanItms(userId,eveId)){
              scanPoolIds.add(scanItem.BLN_Item_Pool__c);
     }
      wherecondition ='where order_type__c !=\'EVENT PRODUCER\'';
            wherecondition += ' and  Events__c = \'' + eveId + '\'';
       wherecondition += ' and Order_Status__c != \''+'Abandoned'+'\'';
            String quryOnlyItems ='';
           SET<id> scanords = new SET<id>();  
           LIST<Order__c> tListOrd = new LIST<Order__c>();
            if (offset != '' && offset != null)
              tListOrd = [select id from Order__c where Id IN (select Order__c from Ticket__c where Order__c>:offset AND EVent__c=:eveId AND Ticket_Status__c='Booked' AND Item_Pool__c IN :scanPoolIds AND Order__r.Order_type__c !='EVENT PRODUCER' AND Order__r.Order_Status__c!='Abandoned') ORDER BY id limit :limits ];             
            else
               tListOrd = [select id from Order__c where Id IN (select Order__c from Ticket__c where EVent__c=:eveId AND Ticket_Status__c='Booked' AND Item_Pool__c IN :scanPoolIds AND Order__r.Order_type__c !='EVENT PRODUCER' AND Order__r.Order_Status__c!='Abandoned') ORDER BY id limit :limits ];             
           for(Order__c od :tListOrd){
              orderIds.add(od.id);
           }
            if(tListOrd.size()<=0){
                String idInClause = '(\'';
                idInClause  = idInClause.substring(0,idInClause.length()-2);
               idInClause += ')';
               wherecondition +=' And Id IN '+idInClause; 
            }

          
          /*    
           Transient List<Ticket__c>  tcTempList = new List<Ticket__c>();
           System.debug(' quryOnlyItems '+quryOnlyItems);
           tcTempList =Database.Query(quryOnlyItems);
           for(Ticket__c scantc :tcTempList ){
               scanords.add(scantc.Order__c);
                if(scanords.size()>=limits)
                 Break;
            }
          System.debug(' YYYYYYYYYYYYYYYYY '+scanords);
          String idInClause = '(\'';
            if(scanords.size()>0){
              for(String orderid:scanords)  {
                idInClause += orderid+ '\',\'';
              }
              idInClause  = idInClause.substring(0,idInClause.length()-2);
               idInClause += ')';
           }
            wherecondition +=' And Id IN '+idInClause;
           */   
          }
     }else{
          if(userId == evedetails.owner.id || IsFullAdmin==true ){
             wherecondition =' where order_type__c !=\'EVENT PRODUCER\'';
            wherecondition += ' and  Events__c = \''+eveId+'\'';
            if(orderId!=null&&orderId!='')
            wherecondition += ' and id= \''+orderId+'\'';

            if(offset!=''&&offset!=null)
               wherecondition=wherecondition+' and Id > \''+offset+'\'';
         
            if(limits!=null&&limits!=0)//used only from attendeeloadmore
              wherecondition=wherecondition+' Order By id '+' limit '+limits ;
          }else{
               wherecondition = ' where BLN_TKT_profile__r.BLN_GN_User__r.user__c = \''+userId+'\''+' and Events__c = \''+eveId+'\'';
                if(limits!=null&&offset!=null&&limits!=0)
            wherecondition=wherecondition+' limit '+limits+' offset '+offset;
          }
            
     }
     system.debug('  FILTER TYPE  '+filterType );
     if(filterType == 'Fully Paid'){
         wherecondition += ' and Order_Status__c = \''+'Fully Paid'+'\'';
     }else if(filterType == 'Not Paid'){
         wherecondition += ' and Order_Status__c = \''+'Not Paid'+'\'';
     }else if(filterType == 'Cancelled'){
         wherecondition += ' and Order_Status__c = \''+'Cancelled'+'\'';
     }else if(filterType == 'Abandoned'){
         wherecondition += ' and Order_Status__c = \''+'Abandoned'+'\'';
     }else if(filterType == 'Check Not Received'){
         wherecondition += ' and Order_Status__c = \''+'Check Not Received'+'\'';
     }
     
     if(moddate!=null){
     String formatedDt = moddate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
    
     wherecondition += ' and (lastmodifieddate>='+formatedDt +')';
     }
     
       system.debug('YYYYYYYYYYYYYYYYYYy '+wherecondition);
     
      List<order__c> order=new List<order__c>();
      try{
      if(orderIds.size()<=0)  
       order= blnOrderDao.orderQuery(wherecondition);  // Getting order of user puchased tickets
       isorder=true;
       }catch(Exception e){}
      system.debug(page+'  ORDERS SIZE '+order.size());
    if (order.size() == 0 && page == 'BLN_ASC_ScannedTickets') { //for badgeqrcode
        try{
        Ticket__c tc=[select id,order__r.id,name,Badge_ID__c,Order__c,badgeparentid__c,Custom_Barcode__c,Event__c from Ticket__c where Badge_ID__c=:orderId or (Custom_Barcode__c=:orderId and Event__c =:eveId) ];
         wherecondition = ' where id= \''+tc.Order__c+'\'';
         order = blnOrderDao.orderQuery(wherecondition);
         isorder=false;
         }catch(Exception e){}
     }
      system.debug('XXXXXXXXx '+order);
     
    if(orderIds.size()<=0)  { // If user is scan Attendee user we are already querying and assigning values
      for(order__c ore :order){
       orderIds.add(ore.id);
      }
    }  
   if (page != 'BLN_ASC_ScannedTickets' && page != 'BLN_ASC_SearchAttendee' && page!='BLN_ASC_EventRefresh' && page!='BLN_ASC_AttendeeLoadMore')
     for(Ticket__c myTic: blnDao.userOrderAndTickets(orderIds,userid,eveId)){  // This is Getting the order of user added by some else
        System.debug(' YYYYYYYYYY TTTTTTTTTTT '+myTic.id);
        orderIds.add(myTic.order__c);
     }
     
   for(order_Item__c ordersOnTickets : blnOrderItemDao.orderQueryTicketCh(orderIds)){ // Getting order Items
        mapOrdIdwithTic.put(ordersOnTickets.id,ordersOnTickets.Tickets__r); 
     }  
     
    List<id> compIdOftic =new List<id>(); 
    Transient List<id> ticketIds = new List<id>();
    // Looping Tickets to get Company and its details
      for( Order__c ordComp :blnOrderDao.orderQuery1(orderIds) ){
        System.debug('Company Values 111111 '+ordComp );
        for(Ticket__c tcomp :ordComp.Tickets__r ){
           if(tcomp.TKT_profile__r.BLN_company__c!=null){
             compIdOftic.add(tcomp.TKT_profile__r.BLN_company__c);
            }
            ticketIds.add(tcomp.id);
          }  
      }
    
   // Tcikets and its Tags
    List<Hash_Tag__c> ticTags = new List<Hash_Tag__c>();
    BLN_Hash_Tag_DAO hasTagDao = new BLN_Hash_Tag_DAO();
    ticTags =hasTagDao.getTags(ticketIds);

    // Mapping Company id with Its Company object
    BLN_Company_DAO cpDao = new BLN_Company_DAO();
    MAP<id,Company__c> mapIdwithCp = new MAP<id,Company__c>(); 
    for(Company__c cp : cpDao.ComapList(compIdOftic)){
      mapIdwithCp.put(cp.id,cp);
    }
   System.debug('Company Values '+mapIdwithCp);


    //Getting Payment type of orders
   BLN_payment_DAO blnPaymentDao = new BLN_payment_DAO();
   MAP<id,payment__c > mapOrderWithPayment = new MAP<id,payment__c>();
    for(payment__c pay : blnPaymentDao.paymentInfo(orderIds)){
        mapOrderWithPayment.put(pay.order__c,pay );
    }
    MAP<id,List<ticket__c>> mapOrdiDWithTicket = new MAP<id,List<ticket__c>>();
    MAP<id,List<Company__c>> mapOrdiDWithComps = new MAP<id,List<Company__c>>();
     /*if(page=='BLN_ASC_AttendeeLoadMore')
     ords=blnOrderDao.orderQueryBadgableChildTicket(orderIds);
     else*/
    for(order__c od : blnOrderDao.orderQueryChildTicket(orderIds)){  // This is Getting the order of user added by some else
        mapOrdiDWithTicket.put(od.id,od.tickets__r);
         List<Company__c> compListIn = new List<Company__c>();
             for(Ticket__c tkt : od.tickets__r){
                if(tkt.TKT_profile__r.BLN_company__c!=null) // Checking ticket comapny null or Not
                if(null != mapIdwithCp.get(tkt.TKT_profile__r.BLN_company__c))  // Checking company value in Company map
                 compListIn.add(mapIdwithCp.get(tkt.TKT_profile__r.BLN_company__c));
     }
        mapOrdiDWithComps.put(od.id,compListIn); 
     }

system.debug('###glst'+orderIds);


     // Get tickets that he booked as a owner     
       for(order__c ord : blnOrderDao.orderQueryChildOrditem(orderIds)){
         List<order_Item__c> addingordItem = new List<order_Item__c>(); 
          for(order_Item__c orderIteam : ord.Order_Items__r ){
           system.debug('@@@@@@@@@@@ 22222 '+eveId +'  333333  '+ord.id ); 
            if(eveId == 'All' || eveId == Null || eveId == ''){
               addingordItem.add(orderIteam);
             } else if(eveId == orderIteam.Item__r.Event__c){
                 addingordItem.add(orderIteam);
             } 
          }  
        dateTime dDate;
        if(addingordItem.size()>0){
           dDate= addingordItem[0].Item__r.Event__r.End_Date__c;
        }
       List<ticket__c> ticValues = new List<ticket__c>();
       ticValues = mapOrdiDWithTicket.get(ord.id);
       system.debug('$GLST'+addingordItem.size());
       if(addingordItem.size()>0){
            inn.add(new inncls(ord,addingordItem,dDate,mapOrderWithPayment.get(ord.id),ticValues,mapOrdiDWithComps.get(ord.id),ticTags)); 
         }
       }
     system.debug('INn value ppppppppp '+inn);  
    return inn; 
  }
  
  // Update ticket with new user and company
  public BLN_StatusMessage updateTickets(string uid,string comId,ticket__c tc){
    // tc.Client_User__c= uid ;
     tc.tkt_profile__r.BLN_Company__c= comId ;
     BLN_Ticket_DAO blnTcdao = new BLN_Ticket_DAO();
     return blnTcdao.updateTicket(tc); 
  }
  
  // Update order with new user and company
  public BLN_StatusMessage updateorder(string uid,string comId,order__c tc){
    //  tc.Client_User__c= uid ;
      tc.BLN_TKT_profile__r.BLN_Company__c= comId ;
       BLN_Order_DAO  blnordao = new BLN_Order_DAO();
       return blnordao.updateOrder(tc); 
  }
    
  // this method will return values of orderItem and tickets 
   public List<Order_Item__c> orderItemWithlineItem(string orderItemId){
     BLN_OrderItem_DAO blnOrderItemdaoSingle =new  BLN_OrderItem_DAO();
     List<Order_Item__c> ret = blnOrderItemdaoSingle.getTicketsOfperticularOItem(orderItemId);
     return ret;
   }
  
  
  
  // cancel order item if it has quatity 1
  public void cancelOrderItemValues(List<Order_Item__c> ordms){
     BLN_OrderItem_DAO blnOrderItemdaoSingle =new  BLN_OrderItem_DAO();
     List<Order_Item__c> orderForReduceBookedQuantity = new List<Order_Item__c>();
     BLN_Ticket_DAO blntic = new BLN_Ticket_DAO();
     
     
     for(Order_Item__c ord : ordms){
      List<Ticket__c> listOfTickets = new List<Ticket__c>();
      for(Ticket__c tc : ord.Tickets__r){
        if(tc.Ticket_Status__c!='Cancelled'){
         listOfTickets.Add(tc);  
        }
      }
       chengeItemOrderCount(ord,listOfTickets);
       cancelTickets(listOfTickets); //cancel tickets
       BLN_StatusMessage blstatus  = blnOrderItemdaoSingle.updateOrder(orderForReduceBookedQuantity);
       cloneTickets(listOfTickets);
      }
   } 
    
    // this method cancel the list of tickets
    public void cancelTickets(List<ticket__c> cancelTickets){
     BLN_Ticket_DAO blntic = new BLN_Ticket_DAO();
     List<Ticket__c> listOfTicketsForChangeStatus = new List<Ticket__c>();
      Ticket__c tid = new Ticket__c();
      for(Ticket__c  iterateTic : cancelTickets){
         iterateTic.Ticket_Status__c = 'Cancelled';
         listOfTicketsForChangeStatus.add(iterateTic);// for update tickets
      }
   BLN_StatusMessage blstatusTic =  blntic.updateTicket(listOfTicketsForChangeStatus); 
    }
    
    
    // cancel order items 
   public void cancelordtems(List<Order_Item__c> itemOrd){
     BLN_OrderItem_DAO blnOrderItemdaoSingle =new  BLN_OrderItem_DAO();
     List<Order_Item__c> orderForReduceBookedQuantity = new List<Order_Item__c>();
      for(Order_Item__c ord : itemOrd){
       ord.Item_Quantity__c = 0.0;
       ord.Item_Total__c = 0.0;
        orderForReduceBookedQuantity.add(ord); // for updating order Item
     }
       BLN_StatusMessage blstatus  = blnOrderItemdaoSingle.updateOrder(orderForReduceBookedQuantity);
  }
    
  // cloning tickets 
  public void cloneTickets(List<ticket__c> listOfTicketsForChangeStatus){
     BLN_Ticket_DAO blntic = new BLN_Ticket_DAO();
    List<ticket__c> forcloningTickets = new List<ticket__c>();
    for(Ticket__c tg :listOfTicketsForChangeStatus ){
        tg.id=null;
        tg.clone(false,true,false,false);
         tg.tkt_profile__r.BLN_Company__c=null;
         tg.Badge_ID__c =null;
         //tg.Client_User__c =null;
         tg.Order__c=null;
         tg.Order_Item__c = null;
         tg.Ticket_Status__c ='Available';
         forcloningTickets.add(tg);
     }
      
      BLN_StatusMessage blstatusTicclone = blntic.insertTicket(forcloningTickets);
     
  }
  
  public List<Bondbetweenchkandobj> bondObjChk{get;set;}
  //  this is for display ticket with check box
  public List<Bondbetweenchkandobj> mapchkandobj(List<Order_Item__c> ory){
    bondObjChk = new List<Bondbetweenchkandobj>();
     for(Order_Item__c iy : ory){
        for(Ticket__c tt :iy.Tickets__r ){
        bondObjChk.add(new Bondbetweenchkandobj(tt));
        }
     }
     return bondObjChk;
  }
   
   // decresing order item quantity after cancel the ticket
  public void chengeItemOrderCount(Order_Item__c orItem,List<Ticket__c> TicsCanQun){
    system.debug('11111111111111111  '+orItem+' ############## '+TicsCanQun);
    integer itemQuanToDes = 0;
    Decimal feeForSintic = 0.0;
    Decimal sinItemDiscount =0.0;
     Decimal taxforSingleTicket =0.0;
     
    for(Ticket__c tc :TicsCanQun ){
       if(tc.Parent_ID__c==null){
          itemQuanToDes++; 
       }
    }
    if(TicsCanQun.size()<=0){
       itemQuanToDes = Integer.valueOf(orItem.Item_Quantity__c);
     }
   System.debug('UUUUUUUUU '+itemQuanToDes);
     feeForSintic = orItem.Item_Fee__c/orItem.Item_Quantity__c;
     sinItemDiscount = orItem.Item_Discount__c/orItem.Item_Quantity__c;
     taxforSingleTicket = orItem.Tax__c/orItem.Item_Quantity__c;

    BLN_OrderItem_DAO blnOrderItemdaoSingle =new  BLN_OrderItem_DAO();
    List<Order_Item__c> orderForReduceBookedQuantity = new List<Order_Item__c>();
         Order_Item__c ordNewIn = new Order_Item__c();
        
        if(orItem.status__c!='Cancelled'){
         ordNewIn = orItem.clone(false,true,false,false);
        if(itemQuanToDes==ordNewIn.Item_Quantity__c  || ordNewIn.Item__r.Item_Type__r.name=='Package'){
          ordNewIn.Item_Quantity__c =(-itemQuanToDes);
          ordNewIn.Item_Total__c = (orItem.Each_Ticket_Price__c)*(ordNewIn.Item_Quantity__c);//+orItem.Item_Fee__c         
         }else{
           ordNewIn.Item_Quantity__c = (-itemQuanToDes);
           ordNewIn.Item_Total__c = (orItem.Each_Ticket_Price__c)*(-itemQuanToDes);//+orItem.Item_Fee__c
         }
         // system.debug('11111111111111111  '+(orItem.Item_Fee__c)/(-TicsCanQun.size()));
            ordNewIn.Item_Fee__c = -(feeForSintic*itemQuanToDes);
            ordNewIn.Item_Discount__c = (sinItemDiscount*itemQuanToDes);
             ordNewIn.Tax__c = -(taxforSingleTicket*itemQuanToDes);
           
            //-((orItem.Item_Fee__c)/(itemQuanToDes));
         ordNewIn.Status__c ='Cancelled';
         orderForReduceBookedQuantity.add(ordNewIn);
          system.debug('#########$'+ordNewIn);
           BLN_StatusMessage blstatus  = blnOrderItemdaoSingle.insertOrderitem1(orderForReduceBookedQuantity);
         }
         /*system.debug('SSSSSSSSSSSSSSS '+blstatus);
         for(id newOredItem : blstatus.successIds){
               createTicketsWithNewOderitem(newOredItem,TicsCanQun);            
         }*/
     } 
   
   // This will create new with new order item 
   public void createTicketsWithNewOderitem(id newordItem,List<Ticket__c> tcs){
    List<Ticket__c> tcListNewValues = new List<Ticket__c>();
      for(Ticket__c tic :tcs){
         Ticket__c tp = new Ticket__c();
         tp = tic.clone(false,true,false,false);
         tp.Order_Item__c = newordItem;
         tp.Ticket_Status__c = 'Cancelled';
        tcListNewValues.add(tp);
      }
     BLN_Ticket_DAO blnTcDaoval = new BLN_Ticket_DAO();
    BLN_StatusMessage blstatus1  = blnTcDaoval.insertTicket(tcListNewValues);
        
   }
   
   
   
   
   
    // This will return set of records for input orderIds
   public List<order__c> getOrdersOrdItems(Set<id> ordIds){
    BLN_Order_DAO bord = new BLN_Order_DAO();
     return  bord.orderQueryChildOrditem(ordIds);
   }
   
    // This will return set of records for input tickets
    public List<order__c> getOrderstickets(Set<id> ticIds){
        BLN_Order_DAO bord = new BLN_Order_DAO();
       return bord.orderQueryChildTicket(ticIds);
   }
   
    
     public List<ticket__c> getTicketDetails(string tcid){
        BLN_Ticket_DAO trf = new BLN_Ticket_DAO();
         string wherecondition = ' where id = \''+tcid+'\'' ;
         return trf.userOrderAndTickets(wherecondition);
    }
    
   
   // change the order status
    public void  uypdateOrderStatus(Set<id> ticIds){
        BLN_Order_DAO bord = new BLN_Order_DAO();
        boolean isOrdercancel = true;
        List<order__c> orderList = new List<order__c>();
        orderList =bord.orderQueryChildTicket(ticIds);
        for(order__c og :orderList){
            for(ticket__c tac :og.tickets__r){
              if(tac.Item_Type__r.Name!='Package'){
                if(tac.Ticket_Status__c !='Cancelled'){
                    isOrdercancel =false;
                }
              }else{
                  if(tac.Ticket_Status__c !='Cancelled' && tac.Parent_ID__c!=null){
                        isOrdercancel =false;
                    }
                } 
              }   
            }   
        
        system.debug('SSSSSSSSSSAAAAAAAAA W@@@@@@@@@@@'+isOrdercancel);
           if(isOrdercancel){
            if(orderList.size()>0){
               orderList[0].Order_Status__c='Cancelled';
               BLN_StatusMessage msg= bord.updateOrder(orderList[0]);
            }
            
        }
     }
 
 
 
 // innser calss for relate checkbox and ticket 
    public class Bondbetweenchkandobj{
      public boolean selectCheckbox{get;set;}
      public Ticket__c ticlineItems{get;set;}
      public Bondbetweenchkandobj(Ticket__c t){
        this.ticlineItems = t;
     }
  }
  
 // This class is for making bond with different objects
 global class inncls{
    public order__c orderInn{get;set;}
    public dateTime dt{get;set;}
    public List<Ticket__c> ticketsInn{get;set;}
    public List<Ticket__c> cancelledTickets{get;set;}
    public payment__c paymentInn{get;set;}
    public List<order_Item__c>  orderItemInn {get;set;}
    public boolean displayOrderItems {get;set;} 
    public boolean selectCheckBox {get;set;}  
    public decimal orderPrice{get;set;}
    public MAP<id,integer> orderItemsMapWithTc{get;set;}
    public List<Company__c> compListInner{get;set;}
    public List<Hash_Tag__c> ticketTags{get;set;}
    public inncls(){
            
    } 
     public inncls(order__c od,List<order_Item__c> orderit,dateTime d,payment__c paym,List<Ticket__c> ticin,List<Company__c> lComps,List<Hash_Tag__c> tTags){
        cancelledTickets = new List<Ticket__c>();
        orderItemsMapWithTc = new MAP<id,integer>();
        ticketsInn = new List<Ticket__c>();
        this.orderInn =od;
        this.orderPrice = od.Order_Total__c;
        this.orderItemInn =orderIt;
        this.dt=d;
        this.paymentInn = paym;
        this.ticketTags = tTags;
        compListInner = new List<Company__c>();
         if(null !=lComps){
           this.compListInner = lComps;
         }

        for(order_Item__c Oi :orderIt ){
         if(Oi.status__c =='Cancelled'){
            orderPrice-=Oi.Item_Total__c;//+Oi.Item_Fee__c
         }
         List<Ticket__c> ticOrd = new List<Ticket__c>();
        for(Ticket__c canTc : ticin){
          if(canTc.order_item__c == Oi.id){
             ticOrd.add(canTc);
          }
        }
        orderItemsMapWithTc.put(Oi.id,ticOrd.size());
      } 
        //this.ticketsInn = ticin;
        for(Ticket__c canTc : ticin){
            if(canTc.Ticket_Status__c =='Cancelled'){
               cancelledTickets.add(canTc);
              }else{
                ticketsInn.add(canTc);
            }
          }
                  
        }
   }
   
   // TO GET THE STATISTICS WRITTEN BY MANASA GANDHAM
   
   public BLN_Order_DAO  ordersDAOClass{get; set;}
   public BLN_Ticket_DAO  ticketsDAOClass{get; set;}
   public BLN_Payment_DAO  paymentDAOClass{get; set;}
   
   public LIST<Order__c> ordersListForSta(String EventId){
        ordersDAOClass= new BLN_Order_DAO();
        String queryString='';
        queryString= ' where Events__c = \''+EventId+'\'';
       // queryString += ' AND Transaction_Status__c = \''+'Completed'+'\'';
        queryString += ' AND Order_Status__c != \''+'Cancelled'+'\'';
         queryString += ' AND Order_Status__c != \''+'Abandoned'+'\'';
          queryString += ' AND Order_Status__c != \''+'Not Paid'+'\'';
        queryString += ' AND Order_Status__c = \''+'Fully Paid'+'\'';
         system.debug('  000000000000  '+queryString);
        LIST<Order__c> orderList= new LIST<Order__c>();
        orderList= ordersDAOClass.orderListForEvent(queryString);
        system.debug(orderList.size()+' ORDERS LIST '+orderList);
        return orderList;
     }
     
  
  public Integer attendeesListForEvent(String EventId){
        
        ticketsDAOClass= new BLN_Ticket_DAO();        
        LIST<Ticket__c> ticksList= new LIST<Ticket__c>();
       ticksList= ticketsDAOClass.ticketsListForEvent(EventId, NULL, NULL);        
        return ticksList.size();
    }
    
    
    public LIST<AggregateResult> PaymentsForEvent(String EventId){
    
        paymentDAOClass= new BLN_Payment_DAO();
        LIST<AggregateResult> PaymentAggregateList= new LIST<AggregateResult>(); 
        PaymentAggregateList= paymentDAOClass.paymentsForEvent(EventId);
        return PaymentAggregateList;
    }
}