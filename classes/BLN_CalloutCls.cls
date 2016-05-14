public with sharing class BLN_CalloutCls {
  public BLN_CalloutCls(String ordId) {
    futureMethod(ordId);
  }
  @Future(callout = true)
  public static void futureMethod(string orderId) {
    List<Ticket__c> tickets = new List<Ticket__c>();
    boolean isPaymentDone = false;
    for (Payment__c pay : [select id, Currency_Code__c, Order__c, Payment_Amount__c, Pay_Address__c, Payment_Mode__c, Payment_Ref_Number__c, BLN_Pay_Gateway__r.PGateway_Type__r.Name, BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c from Payment__c where order__c = :orderId]) {
      if (null != pay.BLN_Pay_Gateway__c) {
        System.debug('Payment Id ' + pay.id);
        if (pay.BLN_Pay_Gateway__r.PGateway_Type__r.Name == 'PayPal' && pay.BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Adaptive') {
          //Checking payment is done or Not
          ControllerPayDetailApi PaydetailCon = new ControllerPayDetailApi();
          PaydetailCon.CommonParametersObjName = 'MyRequestParams';
          PaydetailCon.APICredentialObjName = 'SandboxCert';
          PaydetailCon.payKey = pay.Payment_Ref_Number__c;
          PaydetailCon.PayDetail();
          System.debug('PaydetailCon  outParameterList' + PaydetailCon.outParameterList);
          for (PaymentDetailInfo pdInfo : PaydetailCon.outParameterList) {
            if (pdInfo.Trans != null && pdInfo.Trans != '' ) {
              System.debug('Payment Id ' + pay.id);
              isPaymentDone = true;
              pay.Payment_Ref_Number__c = pdInfo.Trans;
              Database.update(pay, false);
              break;
            }
          }
        } else if (pay.BLN_Pay_Gateway__r.PGateway_Type__r.Name == 'TrustCommerce') {
          isPaymentDone = false;
        } else {
          isPaymentDone = false;
        }
      }
    }
    System.debug('Order Id ' + OrderId);
    //If payment is done making tickets to booked
    Order__c ord = new Order__c();
    ord = [select Events__r.id, owner.Name, createdDate, Events__r.Name, Events__r.Start_Date__c, Events__r.Venue_Name__c, Events__r.End_Date__c, Events__r.Description__c, Events__c, o.Fee_Amount__c, o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__c, o.Amount_Paid__c, (Select Each_Ticket_Price__c, item__r.event__r.Name , Promotion__c, Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c, order__r.BLN_TKT_profile__c, order__r.BLN_TKT_profile__r.Email__c, Item_Quantity__c, Item_Price__c, Item_Discount__c, Id, Item__r.Event__r.End_Date__c, item__r.item_name__c, Status__c, Promotion__r.Promo_Code__c, Currency__c, item__r.price__c  From Order_Items__r ), (Select Item__c, Order_Item__r.Each_Ticket_Price__c, Item_Pool__c, Item_Type__c, item__r.item_name__c, id, tkt_profile__r.BLN_Company__c, tkt_profile__r.TKT_Company__c, tkt_profile__r.Email__c, tkt_profile__r.BLN_GN_User__r.user__c, tkt_profile__r.BLN_GN_User__r.user__r.userName, tkt_profile__r.BLN_GN_User__r.user__r.email, tkt_profile__r.First_Name__c, tkt_profile__r.Last_Name__c, Event__c, Order__c, Order_Item__c, Ticket_Status__c, Badge_Label__c, NAme, Item_Type__r.Name, tkt_profile__r.BLN_GN_User__r.user__r.MobilePhone, LastmodifiedDate, Parent_ID__c from Tickets__r), BLN_TKT_profile__r.BLN_GN_User__r.user__r.Name, BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName, BLN_TKT_profile__r.BLN_GN_User__r.user__r.MobilePhone, BLN_TKT_profile__r.TKT_Company__c, BLN_TKT_profile__r.Last_Name__c, BLN_TKT_profile__r.First_Name__c, BLN_TKT_profile__r.Email__c From Order__c o where Id = :orderId ];
    String Eventid = '';
    if (ord != null) {
      Eventid = ord.Events__r.id;
    }

    System.debug('isPaymentDone Status ' + isPaymentDone);
    System.debug('Tciket List  ' + ord.Tickets__r);

    if (isPaymentDone) {
      BLN_SuccessController successCon = new BLN_SuccessController('');
      successCon.sendMail(orderId, Eventid);
    } else {
      MAP<id, id> mapPidWithChIds = new MAP<id, id>();
      List<Ticket__c> childRecs = new List<Ticket__c>();
      for (Ticket__c tf : ord.Tickets__r) {
       if(tf.Ticket_Status__c=='Abandoned'){ 
        if (tf.Parent_ID__c == null ) {
          Ticket__c tfInd = new Ticket__c();
          tfInd = tf.clone(false, True, false, false);
          tfInd.id = null;
          tfInd.Ticket_Status__c = 'Available';
          tfInd.tkt_profile__c = null;
          tfInd.Order__c = null;
          tfInd.Order_Item__c = null;
          tfInd.tkt_profile__r.TKT_Company__c = null;
          tfInd.tkt_profile__r.TKT_Company__c = '';
          if (tf.Item_Type__r.Name != 'Package') {
            tickets.add(tfInd);
          } else { // For Package Parent
            Database.SaveResult svres = DataBase.insert(tfInd, false);
            if (svres.isSuccess()) {
              mapPidWithChIds.put(tf.id, svres.getId());
            }
          }
        } else { // Adding package child items to lost
          childRecs.add(tf);
        }
       } 
      }
      // Iterating Package child recods to fill new Parent Id
      for (Ticket__c tktCh : childRecs) {
        Ticket__c tfInd = new Ticket__c();
        tfInd = tktCh.clone(false, True, false, false);
        tfInd.id = null;
        tfInd.Ticket_Status__c = 'Available';
        tfInd.tkt_profile__c = null;
        tfInd.Order__c = null;
        tfInd.Order_Item__c = null;
        tfInd.tkt_profile__r.TKT_Company__c = null;
        tfInd.tkt_profile__r.TKT_Company__c = '';
        if (null != mapPidWithChIds.get(tktCh.Parent_ID__c)) {
          tfInd.Parent_ID__c = mapPidWithChIds.get(tktCh.Parent_ID__c);
        }
        tickets.add(tfInd);
      }
    }
    System.debug('tickets List  ' + tickets);
    if (tickets.size() > 0) {
      Database.SaveResult[] svres = DataBase.insert(tickets, false);
      System.debug('Save Result ' + svres);
    }
  }
}