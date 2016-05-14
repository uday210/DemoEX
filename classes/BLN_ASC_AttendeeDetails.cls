/***********************************************************************************************
*   Controller Name : BLN_ASC_AttendeeDetails
*   Date            : 09/04/2015
*   Author          : Phani Kumar Ch
*   Purpose         : This class is Web service Class to Update ticket info
                       (Means blocking tickets for some time)
**************************************************************************************************/

@RestResource(urlMapping='/BLN_ASC_AttendeeDetails')
global class BLN_ASC_AttendeeDetails{
   @HttpPost
   global static TotalList  doPost(){  
 
    RestRequest req = RestContext.Request;
    String eventId =  req.params.get('eventId');
    // Fetching json body form request 
    String JsonString = req.requestBody.toString(); 
    system.debug('@@'+JsonString);
    JSONParser parser = JSON.createParser(JsonString);
    System.debug('parser string:'+parser);
   TotalList TL = new TotalList ();
     innforParser itp= new innforParser();
    
      while (parser.nextToken() != null){     
        if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
            itp = (innforParser)parser.readValueAs(innforParser.class);// typecasting to object type
           
           }
        }
     
        System.debug('   itq ===    '+ itp);
        BLN_MyticketsCon  myticcon = new BLN_MyticketsCon('');
         myticcon.selectedEvent =eventId;
         BLN_Event__c EventsLidt = [Select id,owner.id from BLN_Event__c where id=:eventId];
         myticcon.loginUserId = EventsLidt.owner.id;
         myticcon.urlCheck='BLN_ASC_ScannedTickets';
         myticcon.selectedOrderType='';
         String OrderId = '';
         //myticcon.onchangeEvent();
         try{
          ticket__c tcTmp = [select id,order__c from Ticket__c where id=:itp.tid];
            OrderId = tcTmp.order__c;
            /* Order__c order = new Order__c();
             order = [select id,Order_Status__c,(SELECT id,Payment_Ref_Number__c from Payments__r limit 1) from Order__c where id=:OrderId] ;
            if(itp.OrderStatus!=null && itp.OrderStatus!='') { 
               order.Order_Status__c = itp.OrderStatus;
              for(payment__c py : order.Payments__r){
                if(itp.checkNumber!=null && itp.checkNumber!=''){
                  py.Payment_Ref_Number__c =itp.checkNumber;
                  Database.update(py,false); 
               }
             }
             Database.update(order,false);
            } 
          */

          }catch(exception er){}
           myticcon.prepareorder(OrderId);
          myticcon.ticketId = itp.tid;
        
         myticcon.EdTicket();
         myticcon.tktProfile.First_Name__c = itp.fn;
         myticcon.tktProfile.Last_Name__c = itp.ln;
         myticcon.tktProfile.Email__c = itp.email;
         myticcon.addGuest.Note__c =itp.note;
         myticcon.addGuest.Tag_No__c = itp.seatno;
         myticcon.addGuest.Custom_Barcode__c = itp.customBarcode;
         myticcon.addGuest.Badge_Label__c = itp.badgelabel;
         myticcon.tktProfile.TKT_Company__c = itp.comp;
         myticcon.tktProfile.TKT_Job_Title__c =itp.title;
         myticcon.compidchanged  = itp.compid;
         myticcon.tktProfile.Home_Phone__c= itp.phone;
         myticcon.tktProfile.Mobile__c =itp.mobile;
         myticcon.isOrderEdit = false;
         // Adding values to Work address
         myticcon.wAddress.Address1__c = itp.BAddress1;
         myticcon.wAddress.Address2__c = itp.BAddress2;
         myticcon.wAddress.City__c = itp.BCity;
         myticcon.wAddress.ZipCode__c = itp.BZipcode;
         myticcon.wAddress.State__c = itp.BState;
         myticcon.wAddress.Country__c = itp.BCountry;
         // Adding values to Home address
         myticcon.hAddress.Address1__c = itp.add1;
         myticcon.hAddress.Address2__c = itp.add2;
         myticcon.hAddress.City__c = itp.city;
         myticcon.hAddress.ZipCode__c = itp.zipcode;
         myticcon.hAddress.State__c = itp.state;
         myticcon.hAddress.Country__c = itp.country;



        /*//if(itp.state != null && itp.state != '')
         myticcon.addGuest.tkt_profile__r.Billing_Address__r.State__c = itp.state;
         myticcon.addGuest.tkt_profile__r.Billing_Address__r.Country__c = itp.country; */
         myticcon.tktProfile.Work_Phone__c =  itp.BPhone;
         myticcon.tagsStr = itp.tag;
         myticcon.SaveGuests();  // This is Ckass we are reusing
         if(myticcon.errorTcUpdate!='Success'){
             TL.errorMsg ='Duplicate barcode Found!!';
             //myticcon.errorTcUpdate;
             return TL;
         }


        String selectedOrder =  myticcon.selectedOrder;
        String selectedEvent = myticcon.selectedEvent;
         List<maincontainer> Mc = new List<maincontainer> ();
        
         BLN_Mytickets_BAL ordersList = new BLN_Mytickets_BAL();
       
      // for(BLN_Event__c EventsLidt :[Select id,owner.id from BLN_Event__c where id=:selectedEvent]){
            ordersList.orderId = selectedOrder ;
            LIST<BLN_Mytickets_BAL.inncls>  inlists = ordersList.userTickets(EventsLidt.owner.id ,eventId,'BLN_ASC_ScannedTickets','');
             for(BLN_Mytickets_BAL.inncls cls : inlists){
                if(cls.orderInn.id==selectedOrder){
                     maincontainer nemain= new maincontainer();
                     nemain.orderInn =cls.orderInn;
                     nemain.dt=cls.dt;
                     nemain.ticketsInn =cls.ticketsInn ;
                     nemain.cancelledTickets=cls.cancelledTickets;
                     nemain.paymentInn=cls.paymentInn;
                     nemain.orderItemInn =cls.orderItemInn ;
                     nemain.compListInner =cls.compListInner ;
                     nemain.orderPrice= cls.orderPrice;
                     nemain.ticketTags = cls.ticketTags;
                     Mc.add(nemain);
             }
          }
      //}
    
      TL.TotalLists= Mc;
      return TL;   
   }
   
    // Inner class to hold items and its quantities
     global class innforParser{
        Public String fn{get;set;}
        Public String ln{get;set;}   
        Public String email{get;set;}
        Public String comp{get;set;}
        Public String compid{get;set;}
        Public String mobile{get;set;}
        Public String title{get;set;} 
        Public String badgelabel{get;set;}
        Public String tag{get;set;} 
        Public String seatno{get;set;}   
        Public String tid{get;set;}

        Public String phone{get;set;}
        Public String add1{get;set;}
        Public String add2{get;set;}
        Public String city{get;set;}
        Public String state{get;
        set{
        try{state=[select id,name from State__c where name=:value].id;}catch(Exception e){state=value;}
        }}
        Public String country{get;
        set{
        try{country=[select id,name from Country__c where name=:value].id;}catch(Exception e){country=value;}
        }} 
        Public String zipcode{get;set;}
        
        Public String BAddress1{get;set;}
        Public String BAddress2{get;set;}
        Public String BCity{get;set;}
        Public String BState{get;
        set{
        try{BState=[select id,name from State__c where name=:value].id;}catch(Exception e){BState=value;}
        }}
        Public String BCountry{get;
        set{
        try{BCountry=[select id,name from Country__c where name=:value].id;}catch(Exception e){BCountry=value;}
        }} 
        Public String BZipcode{get;set;}
        
       public String customBarcode {get;set;}
        Public String BPhone{get;set;}
        Public String note{get;set;}
     }  


      global class maincontainer {
        public order__c orderInn{get;set;}
        public dateTime dt{get;set;}
        public List<Ticket__c> ticketsInn{get;set;}
        public List<Ticket__c> cancelledTickets{get;set;}
        public payment__c paymentInn{get;set;}
        public List<order_Item__c>  orderItemInn {get;set;}
        public List<company__c> compListInner {get;set;}
        public decimal orderPrice{get;set;}
        public List<Hash_Tag__c> ticketTags{get;set;}
        public maincontainer (){
       
        }
      }

       global class TotalList{
           public List<maincontainer> TotalLists{get ; set ;}
           public boolean isorder{get;set;}
           public String errorMsg{get;set;}
           public TotalList(){
            TotalLists= new List<maincontainer> ();
        }
     }
   }