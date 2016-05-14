@isTest(seeAllData=True)
public class Test_BLN_ASC_WS_SellTickets{
    static testmethod void mySellTcktTestMethod(){
        Test_BLN_ASC_AddEvents addEventTest = new Test_BLN_ASC_AddEvents();
        Test_BLN_ASC_AddEvents.Test_BLN_ASC_AddEvents();
        BLN_ASC_WS_SellTickets sellTck=new BLN_ASC_WS_SellTickets();
        
            
        BLN_ASC_WS_SellTickets.BuyerInfo st4 = new BLN_ASC_WS_SellTickets.BuyerInfo();
      st4.FirstName = 'Test';
       st4.LastName= 'Test';
       st4.EMailId= 'Test';
       st4.Company= 'Test';
       st4.PaymentType= 'Test';
       st4.PhoneNumber= 'Test';
       st4.PayKey= 'Test';
        st4.OrderTotal= 'Test';
        st4.AfterDiscountPrice= 'Test';
       st4.DiscountedPrice= 'Test';
        st4.FeeAmount= '12345';
       st4.OrderTaxes= 'Test';
       st4.AmountPayable= 'Test';
       st4.OrderStatus= 'Test';
       st4.CurrencyCode= 'Test';
       st4.TransactionStatus= 'Test';
       st4.ChargeType= 'Test';
       st4.cardno= 'Test';
       st4.keyname= 'Test';
       st4.PaygateWayType= 'Test';
       st4.customBarcode='009889';
        
        
                
        BLN_ASC_WS_SellTickets.OrderLineItem st6 = new BLN_ASC_WS_SellTickets.OrderLineItem();
        
         st6.BadgeLabel='test';
        st6.Seatno='test';
        st6.Designation='test';
        st6.Tag='test';
        st6.Company='test';
        st6.Phoneno='test';
      st6.BadgeLabel='test';
      st6.Tag='test';
      st6.Seatno='test';
      st6.Designation='test';
      st6.Note='test';
      st6.customBarcode ='555555';
        
            //testOrderList.add( new Order__c(Client_GN_User__c=gnUser.id,Client_Company__c=companyInfo.id,Events__c=eventInfo.id,Order_Total__c=2,Transaction_Status__c='Completed',Amount_Paid__c=30.6,Fee_Amount__c=6.7,Currency_Code__c=currenyInfo.id));
        List<BLN_ASC_WS_SellTickets.OrderLineItem> stList = new List<BLN_ASC_WS_SellTickets.OrderLineItem>{st6};
        //stList.add(new BLN_ASC_WS_SellTickets.OrderLineItem());
        //stList[0].FirstName='thiru';
        //stList[0].LastName='pattipaka';
        //stList[0].EmailId='thiru@abc.com';
        //stList[0].Company='globalnest';
        BLN_ASC_WS_SellTickets.Orders st5 = new BLN_ASC_WS_SellTickets.Orders('1234', Test_BLN_ASC_AddEvents.item.id, 'ticket', 'admission', Test_BLN_ASC_AddEvents.itempool2.id, '200', 'good', '20', '1', stList);
        list<BLN_ASC_WS_SellTickets.Orders> ordl = new list<BLN_ASC_WS_SellTickets.Orders>{st5};
        BLN_ASC_WS_SellTickets.SellTickets st1 = new BLN_ASC_WS_SellTickets.SellTickets();
        BLN_ASC_WS_SellTickets.NoTicketItems st2 = new BLN_ASC_WS_SellTickets.NoTicketItems();
        BLN_ASC_WS_SellTickets.TotalOrderInfo st3 = new BLN_ASC_WS_SellTickets.TotalOrderInfo();
        st3.BuyerInfo = st4;
        st3.Orders = ordl;
        st3.SessionAbntime = 5;
        


        BLN_ASC_WS_SellTickets.BuyerInfo by1 = new BLN_ASC_WS_SellTickets.BuyerInfo();
        BLN_ASC_WS_SellTickets.maincontainer  st7 = new BLN_ASC_WS_SellTickets.maincontainer (); 
        BLN_ASC_WS_SellTickets.Ordersonly st8 = new BLN_ASC_WS_SellTickets.Ordersonly ();
        BLN_ASC_WS_SellTickets.TotalList st9 = new BLN_ASC_WS_SellTickets.TotalList();
                

        st7.orderInn=null;
        st7.dt=null;
        st7.ticketsInn=new List<Ticket__c>();
        st7.cancelledTickets=new List<Ticket__c>();
        st7.paymentInn=null;
        st7.orderItemInn =new List<order_Item__c>();
        st7.orderPrice=7.3;
        st7.ticketTags=new List<Hash_Tag__c>();
        
        st8.OrdersList_info=null;
        st9.isorder =true;
        

       
    
      
                
        RestContext.request.addParameter('eveid',Test_BLN_ASC_AddEvents.eventInfo.id);
        RestContext.request.addParameter('userid',Test_BLN_ASC_AddEvents.u.id);
        test.startTest();
        string bodys='{"BuyerInfo":{"FirstName":"rajesh","LastName":"Kumar","EMailId":"rajeshc@globalnest.com","Company":"Globalnest","PaymentType":"Paypal","PayKey":"12345","OrderTotal":"400","AfterDiscountPrice":"360","DiscountedPrice":"40","FeeAmount":"10","OrderTaxes":"15","AmountPayable":"360","OrderStatus":"Fully Paid","CurrencyCode":"USD","TransactionStatus":"Completed", "customBarcode": 123456},"Orders":[{"ItemId":"'+Test_BLN_ASC_AddEvents.item.id+'","ItemName":"Full conference","ItemPoolId":"'+Test_BLN_ASC_AddEvents.ItemPool2.id+'","ItemPrice":"50","ItemDiscount":"20","ItemTotal":"30","ItemQuantity":"2","FeeAmount": "10","OrderLineItems":[{"FirstName":"Sravan","LastName":"Kumar","EmailId":"sravan@globalnest.com","Company":"Gster", "BadgeLabel":"Attendee","Designation":"dev","Note":"test","Phoneno":"(900) 000-0000","Seatno":"12","Tag":"test", "customBarcode": 124456,"TicketId":"'+Test_BLN_ASC_AddEvents.ticket.name+'"}]}],"cardno":4242,"keyname" : ""}';
        blob b = blob.valueOf(bodys);
		RestContext.request.requestBody  = b;
        test.stopTest();
        
        BLN_ASC_WS_SellTickets sellTckTemp= new BLN_ASC_WS_SellTickets ();
        BLN_RegistrationnewCon.TicketInnerClass regTick = new BLN_RegistrationnewCon.TicketInnerClass();
            try{
            BLN_ASC_WS_SellTickets.dopost();    
         
            }
            catch(Exception e){}
        
    }
}