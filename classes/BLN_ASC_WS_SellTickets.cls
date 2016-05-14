/***********************************************************************************************
*   Controller Name : BLN_ASC_WS_SellTickets
*   Date            : 08/12/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is Web service Class to sell tickets from Scan attendee mobile application. Registration from Mobile.
**************************************************************************************************/

@RestResource(urlMapping='/BLN_ASC_WS_SellTickets')
global class BLN_ASC_WS_SellTickets{  
  
  BLN_Quick_Registration_BAL RegistrationBAL = new BLN_Quick_Registration_BAL();  
  
    Static boolean isCompanyProvide =false;
    static String eveid;
    static String userid;
    
  
  @HttpPost
  global static BLN_ASC_Checkin.TotalList doPost(){  
    
    SellTickets res = new SellTickets();
    
    // Instance for the Orders inner class
    List<Orders> OrdItms = new List<Orders>();
   
    List<NoTicketItems> nti = new List<NoTicketItems>();
    
    RestRequest req = RestContext.Request;
    
    // get params from Request URL
    eveid = req.params.get('eveid');
    system.debug('eveid==============='+eveid);
    userid = req.params.get('userid');
    system.debug('userid==============='+userid);
    
    // getting body and cnverting blob body to string
    String JsonString = req.requestBody.toString();
    system.debug('JsonString from body==='+JsonString);
    
    // Instance for the BuyerInfo inner class
    BuyerInfo buyinf; 
    
    // MAP for Item based on the Item Id in the Request body
    MAP<id,BLN_Item__c > mapitemidwithItem = new MAP<id,BLN_Item__c >();
    
    // Instance for the BLN_Quick_Registration_BAL class
    BLN_Quick_Registration_BAL QuickRegBAL = new BLN_Quick_Registration_BAL();
    
    // Getting all items available for the event based eveid
    for( BLN_Item__c blitems : QuickRegBAL.getEventItems(eveid)){
        mapitemidwithItem.put(blitems.id,blitems); 
    }
    
    TotalOrderInfo to = new TotalOrderInfo();
    JSONParser parser = JSON.createParser(JsonString);
    System.debug('JJJJJJJJJJJ:'+parser);
    while (parser.nextToken() != null){     
        /*system.debug('parser.getCurrentToken()==='+ parser.getCurrentToken()+'   000parser.getText()=== '+parser.getText());
        system.debug('parser.nextToken()==='+ parser.nextToken()+'   111parser.getText()=== '+parser.getText());*/
         // Parsing json 
        if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
           to = (TotalOrderInfo)parser.readValueAs(TotalOrderInfo.class);
           system.debug('to ==='+ to);
        }
    }
      
      BLN_RegistrationnewCon.TicketInnerClass buyerInfo = new BLN_RegistrationnewCon.TicketInnerClass();
       buyerInfo.customBarcode = to.BuyerInfo.customBarcode; 
      // Creating GN User object to send it to BLN_Quick_Registration_BAL class
     // Gn_user__c buyerUser = new GN_User__c();
      //Company__c buyerCompweb = new Company__c();
      
      system.debug('buyinf.FirstName==========    '+to.Orders);
      /*buyerInfo.EachUser.First_Name__c =  to.BuyerInfo.FirstName;
      buyerInfo.EachUser.Last_Name__c = to.BuyerInfo.LastName;
      buyerInfo.EachUser.Email__c = to.BuyerInfo.EmailId;
      buyerInfo.EachCompany.Name =  to.BuyerInfo.Company;
      buyerInfo.EachUser.Mobile__c=  to.BuyerInfo.PhoneNumber;*/
      
      buyerInfo.tktProfileObject.First_Name__c =  to.BuyerInfo.FirstName;
      buyerInfo.tktProfileObject.Last_Name__c = to.BuyerInfo.LastName;
      buyerInfo.tktProfileObject.Email__c = to.BuyerInfo.EmailId;
      buyerInfo.tktProfileObject.TKT_Company__c =  to.BuyerInfo.Company;
      buyerInfo.tktProfileObject.Mobile__c=  to.BuyerInfo.PhoneNumber;
       buyerInfo.tktProfileObject.TKT_Job_Title__c=  to.BuyerInfo.Designation;
      
      // Instance for the BLN_RegistrationnewCon Items inner class
      List<BLN_RegistrationnewCon.ItemInnerClass> innItem = new List<BLN_RegistrationnewCon.ItemInnerClass>();
      
      // Instance for the BLN_RegistrationnewCon Tickets inner class
      List<BLN_RegistrationnewCon.TicketInnerClass> tcInn = new List<BLN_RegistrationnewCon.TicketInnerClass>();
      MAP<string,Ticket__c>  mapTicketWithId = new Map<string,Ticket__c>();
      List<string> tcids = new list<string>();
        // Getting all the tickets which are in request body
          for(orders iterateItems : to.Orders){
            for(OrderLineItem ordlineitem : iterateItems.OrderLineItems){
               tcids.add(ordlineitem.TicketId);
            }
          }
         
          List<Ticket__c>   tcList  = new List<Ticket__c>();
          tcList = [select id,name,Item__r.item_type__r.Name,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Item_Pool__r.Package_Flag__c,Parent_ID__c,Item_Pool__r.Badgable__c,item__r.Item_Pool__r.id from Ticket__c where Name In :tcids];
          for(Ticket__c tc : tcList){
             mapTicketWithId.put(tc.Name,tc);
          }
       
        MAP<id,Decimal> mapIdWithDec = new MAP<id,Decimal>();
        // Assigning values to Tickets and user 
       for(orders orditem : to.Orders){
           BLN_Item__c item = new BLN_Item__c();
            mapIdWithDec.put(orditem.ItemId,Decimal.valueOf(orditem.FeeAmount));
           item = mapitemidwithItem.get(orditem.ItemId);
          
           innItem.add(new BLN_RegistrationnewCon.ItemInnerClass(item,new list<Selectoption>(),orditem.ItemQuantity,0,''));
            //If(item.item_type__r.Name!='Package'){
                   for(OrderLineItem ordlineitem : orditem.OrderLineItems){
                     System.debug('uuuuuuuu '+ordlineitem );
                      BLN_RegistrationnewCon.TicketInnerClass regTick = new BLN_RegistrationnewCon.TicketInnerClass();
                       regTick.Ticket = mapTicketWithId.get(ordlineitem.TicketId);
                       /*regTick.EachUser.First_Name__c = ordlineitem.firstName;
                       regTick.EachUser.Last_Name__c =ordlineitem.lastName;
                       regTick.EachUser.Email__c =ordlineitem.EmailId;
                       regTick.EachUser.Mobile__c =ordlineitem.Phoneno;*/
                       regTick.tktProfileObject.First_Name__c = ordlineitem.firstName;
                       regTick.tktProfileObject.Last_Name__c =ordlineitem.lastName;
                       regTick.tktProfileObject.Email__c =ordlineitem.EmailId;
                       regTick.tktProfileObject.Mobile__c =ordlineitem.Phoneno;
                       //regTick.ticket.Custom_Barcode__c = ordlineitem.customBarcode;
                       regTick.customBarcode = ordlineitem.customBarcode;
                       system.debug('Custome Bar code Id ' +ordlineitem.customBarcode); 
                       system.debug('-------------Order Item Notes-------------'+ordlineitem.firstName+':'+ordlineitem.BadgeLabel);
                       if(ordlineitem.Note != null && ordlineitem.Note != ''){
                           regTick.ticket.Note__c =ordlineitem.Note;
                       }
                       if(ordlineitem.BadgeLabel != null && ordlineitem.BadgeLabel != ''){
                          regTick.ticket.Badge_Label__c =ordlineitem.BadgeLabel;
                       }
                       
                       if(ordlineitem.Seatno != null && ordlineitem.Seatno != ''){
                         regTick.ticket.Tag_No__c =ordlineitem.Seatno;
                       }
                       if(ordlineitem.Designation != ''){
                          regTick.tktProfileObject.TKT_Job_Title__c = ordlineitem.Designation;
                       }
                       if(ordlineitem.Tag != ''){
                          regTick.Tag = ordlineitem.Tag;
                       }
                       if(ordlineitem.company!=null){
                       /*regTick.EachCompany = new Company__c();
                          regTick.EachCompany.Name =ordlineitem.company;*/
                          
                          regTick.tktProfileObject.TKT_Company__c =ordlineitem.company;
                       }
                       system.debug('ordlineitem.company=== = '+ordlineitem.company);
                       regTick.BLNItem =  item; 
                       tcInn.add(regTick);
                    }     
              // }
                }
        
        
        // calling BLN_Quick_Registration_BAL insertingTotalorder method after construnting all required parametrs of the insertingTotalorder  method
        string msg = QuickRegBAL.insertingTotalorder(innItem,tcInn,buyerInfo,decimal.valueOf(to.BuyerInfo.OrderTotal),decimal.valueOf(to.BuyerInfo.DiscountedPrice),decimal.valueOf(to.BuyerInfo.FeeAmount),decimal.valueOf(to.BuyerInfo.OrderTaxes),decimal.valueOf(to.BuyerInfo.AmountPayable),mapIdWithDec,new MAP<id,decimal>(),new Promotion__c(),to.BuyerInfo.ChargeType,to.BuyerInfo.PaymentType,to.BuyerInfo.PayKey,to.BuyerInfo.PaygateWayType,'ScanAttendee',to.BuyerInfo.cardno,to.BuyerInfo.keyname);    
       
        system.debug('PPPPPPPPPPPPPPp '+msg);
        //string ordstatus =   Quickbal.insertingTotalorder(ItemList,TicketList,GNUserforbuyer,null,GNbuyerCompanyDetails,totalAmount + DiscountedAmount,DiscountedAmount,FeeAmount,TaxAmount,totalAmount,mapitemWithFee,mapitemWithDiscount,PromotionOb,SelectedCardType,SelectedPaymentGateway,ChargeId,PayGatewayMode);
        BLN_ASC_Checkin.TotalList TL = new BLN_ASC_Checkin.TotalList ();
        BLN_Mytickets_BAL ordersList = new BLN_Mytickets_BAL();
       
        // Sending email If order and order Items created then creating service response 
        if(msg=='Success'){
            List<BLN_ASC_Checkin.maincontainer> Mc = new List<BLN_ASC_Checkin.maincontainer> ();
            system.debug('QuickRegBAL.orderId====  '+QuickRegBAL.orderId);
           // BLN_SuccessController SuccessBal= new BLN_SuccessController();
           // SuccessBal.orderId =QuickRegBAL.orderid ;
           // SuccessBal.eventId=eveid;
           // SuccessBal.sendMail(QuickRegBAL.orderid,eveid);
            ordersList.orderId=QuickRegBAL.orderid;
            // For mobile app response 
            LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets(Userid,eveid,'BLN_ASC_ScannedTickets','');    
            for(BLN_Mytickets_BAL.inncls cls : inlists){
             BLN_ASC_Checkin.maincontainer nemain= new BLN_ASC_Checkin.maincontainer();
             nemain.orderInn =cls.orderInn;
             nemain.dt=cls.dt;
             nemain.ticketsInn =cls.ticketsInn ;
             nemain.cancelledTickets=cls.cancelledTickets;
             nemain.paymentInn=cls.paymentInn;
             nemain.orderItemInn =cls.orderItemInn ;
             nemain.orderPrice= cls.orderPrice;
             nemain.ticketTags = cls.ticketTags;
             Mc.add(nemain);
         }
         BLN_SchedlerCallClass scCls1 = new BLN_SchedlerCallClass();
         scCls1.BLN_SchedlerMethod(to.SessionAbntime,QuickRegBAL.orderid);
         TL.TotalLists= Mc;
         TL.isorder=ordersList.isorder;//to check from mobile wheteher it is a orderqrcode or badgeqrcode
         return TL; 
     }else{
        TL.errorMsg = msg;
       return TL;
     }
      
      return null;      
  }

  global class SellTickets{
      public string ErrorMsg;
      public Order__c OrderInfo;
      public List<NoTicketItems> ntis;
  }
  
  global class NoTicketItems{
      public Id ItemId;
      public String Msg;
  }
  
  global class TotalOrderInfo{
      public BuyerInfo BuyerInfo;
      public List<Orders> Orders;
      public integer SessionAbntime;
  }
  
  global class BuyerInfo{
      global string FirstName;
      global string LastName;
      global string EMailId;
      global string Company;
      global string PaymentType;
      global string PhoneNumber;
      global string PayKey;
      global string OrderTotal;
      global string AfterDiscountPrice;
      global string DiscountedPrice;
      global string FeeAmount;
      global string OrderTaxes;
      global string AmountPayable;
      global string OrderStatus;
      global string CurrencyCode;
      global string TransactionStatus;
      global string ChargeType;
      global string cardno; 
      global string keyname;
      global string PaygateWayType;
      global string customBarcode;
      global String Designation;
  }
  
  
  global class Orders{
      global Id ItemId;
      global String ItemName;
      global String ItemType;
      global String ItemPoolId;
      global String ItemPrice;
      global String ItemDiscount;
      global String ItemTotal;
      global String ItemQuantity;
      global string FeeAmount;
      LIST<OrderLineItem> OrderLineItems;      
      
      global Orders(String fAmount,Id itid, String itname, String ItTyp, String itemplid, String itprice, String itdisc, String ittotal, String itqnt, LIST<OrderLineItem> ords){
        //OrderLineItems = new LIST<OrderLineItem>();
          ItemId = itid;
          ItemName = itname;
          ItemType = ItTyp;
          ItemPoolId = itemplid;
          ItemPrice = itprice;
          ItemDiscount = itdisc;
          ItemTotal = ittotal;
          ItemQuantity = itqnt;
          FeeAmount = fAmount;
          OrderLineItems = ords.clone();      
      }      
  }
  
  global class OrderLineItem{
      public string TicketId;
      public String FirstName;
      public String LastName;
      public String EmailId;
      public String Company;
      public String Phoneno;
      public String BadgeLabel;
      public String Tag;
      public String Seatno;
      public String Designation;
      public String Note;
      public String customBarcode;     
   }
   
     global class maincontainer {
        public order__c orderInn{get;set;}
        public date dt{get;set;}
        public List<Ticket__c> ticketsInn{get;set;}
        public List<Ticket__c> cancelledTickets{get;set;}
        public payment__c paymentInn{get;set;}
        public List<order_Item__c>  orderItemInn {get;set;}
        public decimal orderPrice{get;set;}
         public List<Hash_Tag__c> ticketTags{get;set;}
        public maincontainer (){
           
        }
       
   
   } 
   global class Ordersonly{
   public Order__c OrdersList_info {get ; set ;}
   public Ordersonly(){}
   
   }
   
   global class TotalList{
   public List<maincontainer> TotalLists{get ; set ;}
   public boolean isorder{get;set;}
   
   public TotalList(){
    TotalLists= new List<maincontainer> ();
    
   }
   
   }
    
}