/**************************************************
* @author :Arindam Sarkar
* @date 10/03/2016
* @ This class is used for inserting total order for dynamic registration(replica of old class BLN_Quick_Registration_BAL)
****************************************************/

public without sharing class BLN_Quick_Registration_BAL3 {
    public string orderId {get; set;}

//Check user availability
    public String checkUser(User newu) {
        BLN_User_DAO blnuserDao = new BLN_User_DAO();
        user user = new user();
        user = blnuserDao.CheckUser(newu.email);
        return user.id != null ? user.id : null;
    }

//GetExistingUSerInformation for Ajax call
    public User getExistingUser(String email) {
        BLN_User_DAO blnuserDao = new BLN_User_DAO();
        user user = new user();
        user = blnuserDao.CheckUser(email);
        return user;
    }

//Check Company Availability
    public String checkCompany(Company__c newcomp) {
        BLN_Company_DAO blncmpDao = new BLN_Company_DAO();
        Company__c comp = new Company__c ();
        comp = blncmpDao.checkCompany(newcomp.name);
        return comp.id != null ? comp.id : null;
    }

//Check User Email
    public String checkUserEmail(String Email) {
        BLN_User_DAO blnuserDao = new BLN_User_DAO();
        user user = new user();
        user = blnuserDao.CheckUser(Email);
        return user.id != null ? user.id : null;
    }


// Inserting GN User
    public BLN_StatusMessage insertGNUser(GN_User__c NewUser) {

        BLN_User_DAO UserDAO = new BLN_User_DAO();

        User SFUser = new User();

        String UserEmail;
        if (checkUserEmail(NewUser.Email__c) != NULL) {
            UserEmail = checkUserEmail(NewUser.Email__c);
        } else {
            SFUser.FirstName = NewUser.First_Name__c;
            SFUser.LastName = NewUser.Last_Name__c;
            SFUser.Email = NewUser.Email__c;
            // SFUser.Title= NewUser.Title__c;
            SFUser.Phone = NewUser.Home_Phone__c;
            /* if(newUser.Company_Name__c != NULL && newUser.Company_Name__c !=''){
                 SFUser.Companyname= NewUser.Company_name__c;
             }else{
                 SFUser.Companyname= NewUser.First_Name__c + NewUser.Last_Name__c;
             }
             */
            BLN_StatusMessage userMsg = insertUser(SFUser);
            if (userMsg.successBool) {
                UserEmail = userMsg.successId;
            }
        }
        NewUser.User__c = UserEmail;

        BLN_StatusMessage StatusMessage = UserDAO.insertGNUser(NewUser);
        return StatusMessage;
    }


//Inserting User
    public BLN_StatusMessage insertUser(user newu) {
        BLN_User_DAO blnuserDao = new BLN_User_DAO();

        //Insert Contact
        contact Con = new Contact();
        Con.Lastname = newu.Lastname ;
        Con.Firstname = newu.Firstname ;
        con.email = newu.email;

        string contactId = blnuserDao.account_Contact(con);
        //Get Profile
        Profile P = [SELECT Id, Name FROM Profile WHERE Name = 'Attendee'];
        user u = new user();
        U.ContactID = contactId;
        U.Username = newu.email;
        U.Email = newu.email;
        U.LastName = newu.LastName;
        U.FirstName = newu.FirstName;
        U.CompanyName = newu.CompanyName;
        U.phone = newu.phone;
        U.title = newu.title;
        U.Alias = 'EAdmin';
        U.ProfileID = P.id;
        U.Eff_Date__c = system.today();
        U.LocaleSidKey = 'en_US';
        U.LanguageLocaleKey = 'en_US';
        U.TimeZoneSidKey = 'GMT';
        U.EmailEncodingKey = 'UTF-8';
        U.CommunityNickname = String.valueOf(math.random());
        BLN_StatusMessage userMsg = blnuserDAO.createUser(u);

        return userMsg ;
    }

//Updating User
    public String updateUser(User U) {
        BLN_User_DAO blnuserDao = new BLN_User_DAO();
        String userMsg = blnuserDAO.updateUser(u);
        return userMsg;
    }

//Inserting Company
    public BLN_StatusMessage insertCompany(Company__c newcomp, Company_Ext__c comext) {
        BLN_Company_DAO blnCompanyDAO = new BLN_Company_DAO();
        BLN_StatusMessage companyMsg = blnCompanyDAO.insertCompany(newcomp);
        if (companyMsg.successBool)
            if (comext != null) {
                blnCompanyDAO.insertcompdetails(companyMsg.successId, comext);
            }
        return companyMsg;
    }

//Inserting UCRole
    public BLN_StatusMessage insertUCRole(String userId, String comId, String eventId, String role) {
        BLN_UCRole_DAO companyRole = new BLN_UCRole_DAO();
        system.debug('UserID in BAL:' + userId + ' CompanyID in BAL:' + comId);
        UC_Role__c uRole = new UC_Role__c();
        uRole.Company__c = comId;
        uRole.GN_User__c = userId;
        if (eventId != '') {
            uRole.Event__c = eventId;
        }
        BLN_User_DAO UserDAO = new BLN_User_DAO();
        GN_User__c GU = UserDAO.getGNUser(UserId);
        //uRole.User__c = GU.User__c;

        BLN_StatusMessage ucRoleMsg = companyRole.insertUCRole(uRole, role);
        system.debug('Inserted UC Role Id in BAL:' + ucRoleMsg);
        return ucRoleMsg;
    }


//Inserting UCRole
    public BLN_StatusMessage insertUCRolewithUtype(String userId, String comId, String eventId, String role, string utype) {
        BLN_UCRole_DAO companyRole = new BLN_UCRole_DAO();
        system.debug('UserID in BAL:' + userId + ' CompanyID in BAL:' + comId);
        UC_Role__c uRole = new UC_Role__c();
        uRole.Company__c = comId;
        uRole.GN_User__c = userId;
        if (eventId != null && eventId != '') {
            uRole.Event__c = eventId;
        }
        uRole.user_type__c = utype;

        BLN_User_DAO UserDAO = new BLN_User_DAO();
        GN_User__c GU = UserDAO.getGNUser(UserId);
        //uRole.User__c = GU.User__c;

        BLN_StatusMessage ucRoleMsg = companyRole.insertUCRole(uRole, role);
        system.debug('Inserted UC Role Id in BAL:' + ucRoleMsg);
        return ucRoleMsg;
    }



//Inserting UCRole
    public BLN_StatusMessage insertUCRolewithTitle(String userId, String comId, String eventId, String role, String utype, String desig) {
        BLN_UCRole_DAO companyRole = new BLN_UCRole_DAO();
        system.debug('UserID in BAL:' + userId + ' CompanyID in BAL:' + comId);
        UC_Role__c uRole = new UC_Role__c();
        uRole.Company__c = comId;
        uRole.GN_User__c = userId;
        if (desig != '') {
            uRole.Title__c = desig;
        }

        if (eventId != null && eventId != '') {
            uRole.Event__c = eventId;
        }
        uRole.user_type__c = utype;

        BLN_User_DAO UserDAO = new BLN_User_DAO();
        GN_User__c GU = UserDAO.getGNUser(UserId);
        //uRole.User__c = GU.User__c;

        BLN_StatusMessage ucRoleMsg = companyRole.insertUCRole(uRole, role);
        system.debug('Inserted UC Role Id in BAL:' + ucRoleMsg);
        return ucRoleMsg;
    }


    //Get Available Tickets
    public LIST<selectOption> getAvailableTickets(LIST<BLN_Item__c> items) {
        System.debug('ITEMSSSS ' + items);
        BLN_Ticket_DAO tcdao = new BLN_Ticket_DAO();
        LIST<selectOption> myitems = new LIST<selectOption>();
        myitems.add(new selectOption('', 'Select One'));
        LIST<Ticket__c> tckt;
        for (BLN_Item__c item : items) {


            // tckt = tcdao.getTickets('id,name,Event__c,Item__r.Payment__c,Item__r.Event__c,Item__r.price__c,Item__r.item_name__c,Item_Type__r.name,item__r.Ticket_Settings__c,Ticket_Status__c,Parent_ID__c,Item_Pool__r.Badgable__c','Event__c=\''+item.Event__c +'\' and Item__r.id=\''+item.id+'\' and Ticket_Status__c=\'Available\' and Parent_ID__c=null order by name limit 1');
            tckt = tcdao.getTickets('id,name,Event__c,Item__r.visibility__c,Item__r.Payment__c,Item__r.Event__c,Item__r.price__c,Item__r.item_name__c,Item_Type__r.name,item__r.Ticket_Settings__c,Ticket_Status__c,Parent_ID__c,Item_Pool__r.Badgable__c', 'Event__c=\'' + item.Event__c + '\' and Item__r.id=\'' + item.id + '\' and Ticket_Status__c=\'Available\' and Parent_ID__c=null and Item__r.visibility__c=\'Public\' order by name limit 1');
            if (tckt.size() > 0) {
                //myitems.add(new selectOption(tckt[0].id,item.item_name__c));
                myitems.add(new selectOption(item.id, item.item_name__c));
            }
        }
        return myitems;
    }

    //Get Event Details based on Id
    public BLN_Event__c geteventDetails(string eventId) {
        BLN_Event_DAO evdao = new BLN_Event_DAO();
        LIST<BLN_Event__c> eventdetails = evdao.getEventDetails(eventId);
        if (eventdetails.size() > 0)
            return eventdetails[0];
        else
            return new BLN_Event__c();
    }

    //Get Items For an Event
    public LIST<BLN_Item__c> getEventItems(String eventId) {
        BLNUtility bl = new BLNUtility();
        BLNUtility.ItemMap im = bl.pendingpaymentbl(eventId);
        BLN_Item_DAO itmdao = new BLN_Item_DAO();
        LIST<BLN_Item__c> items = itmdao.getEventItems(eventId);
        if (items.size() > 0) {
            if (im.duepayment == true) {
                for (integer i = 0; i < items.size(); i++) {
                    if (items[i].Item_Pool__r.Item_Type__r.Name == 'Package') {
                        //Fetching AddOnParent ItemPools
                        LIST<String> IPStrings = new LIST<String>();
                        IPStrings.add(items[i].Item_Pool__r.Id);
                        BLN_ItemPool_DAO ItemPoolDAO = new BLN_ItemPool_DAO();
                        for (Item_Pool__c IP : ItemPoolDAO.getPackageItemPools(IPStrings)) {
                            if (im.buyitemmap.get(IP.Item_Type__c) != null) {
                                Decimal orditem = im.orditemmap.get(IP.Item_Type__c) == null ? 0 : im.orditemmap.get(IP.Item_Type__c);
                                if (im.buyitemmap.get(IP.Item_Type__c) > orditem) {
                                    items.remove(i);
                                    i--;
                                    break;
                                }
                            }
                        }
                    } else {

                        if (im.buyitemmap.get(items[i].Item_Pool__r.Item_Type__r.Id) != null) {
                            if (im.buyitemmap.get(items[i].Item_Pool__r.Item_Type__r.Id) != null) {
                                Decimal orditem = im.orditemmap.get(items[i].Item_Pool__r.Item_Type__r.Id) == null ? 0 : im.orditemmap.get(items[i].Item_Pool__r.Item_Type__r.Id);
                                if (im.buyitemmap.get(items[i].Item_Pool__r.Item_Type__r.Id) > orditem) {
                                    items.remove(i);
                                    i--;
                                }
                            }
                        }
                    }
                }
                return items;
            } else
                return items;
        } else
            return new LIST<BLN_Item__c>();
    }



// ------------------------------------------------------ Edit for Regular Registration start by Mahesh Sakunala ----------------------------------------------------------------


    //Get Registration Template Details For an Event
    public Registration_Template__c getRegTempDetails(String RegTemplateId) {
        BLN_RegTemplate_DAO regTempDAO = new BLN_RegTemplate_DAO();
        Registration_Template__c registrationTemplate = regTempDAO.getRegTempDetails(RegTemplateId);
        return registrationTemplate;
    }

    //Get Ticket Details
    public LIST<Ticket__c> getTicketDetail(BLN_Item__c Item, Integer RecordCount) {
        // Getting Ticket Details from Ticket DAO
        BLN_Ticket_DAO TicketDAO = new BLN_Ticket_DAO();
        LIST<Ticket__c> TicketList = new LIST<Ticket__c>();
        LIST<Ticket__c> PackageTickets = new LIST<Ticket__c>();

        //Getting Package Tickets from Ticket DAO
        if (Item.Item_Type__r.Name == 'Package' && Item.Ticket_Settings__c == 'Collect info from All Attendees') {
            List<Ticket__c> tckt = TicketDAO.getTickets('id,name,Item__r.item_type__r.Name,Item__r.item_type__r.id,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Parent_ID__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.Badgable__c', 'Event__c=\'' + item.Event__c + '\' AND Item__c=\'' + item.id + '\' AND Ticket_Status__c=\'Available\' AND Parent_ID__c=null  ORDER BY Name LIMIT ' + RecordCount);
            //AND Parent_ID__c=null
            system.debug('Package Single Ticket: ' + tckt);
            for (Ticket__c tc : tckt) {
                if (tc.Item_Pool__r.Package_Flag__c == 'P - Package item pool') {
                    PackageTickets.addAll(TicketDAO.getTickets('id,name,Event__c,Item__r.item_type__r.Name,Item_Pool__r.Item_Pool_Name__c,Item__r.item_name__c,Item_Pool__r.Ticket_Settings__c,Order__c,Order_Item__c,item__r.Ticket_Settings__c,Item_Type__r.name,Parent_ID__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.Badgable__c,Ticket_Status__c', 'Ticket_Status__c=\'Available\' and  Parent_ID__c=\'' + tc.id + '\''));
                    PackageTickets.add(tc);
                    system.debug('Package Tickets: ' + PackageTickets);
                }
            }
        } else {
            if (Item.Item_Type__r.Name == 'Package') {
                //TicketList = TicketDAO.getTickets('id,Item__r.item_type__r.Name,name,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Item_Pool__r.Package_Flag__c,Parent_ID__c,Item_Pool__r.Badgable__c','Event__c=\''+item.Event__c +'\' AND Item__r.item_name__c=\''+item.item_name__c+'\' AND Ticket_Status__c=\'Available\' AND Parent_ID__c=null AND Item_Pool__r.Badgable__c=\'N - No Badge\' ORDER BY Name LIMIT '+ RecordCount);
                TicketList = TicketDAO.getTickets('id,Item__r.item_type__r.Name,name,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Item_Pool__r.Package_Flag__c,Parent_ID__c,Item_Pool__r.Badgable__c', 'Event__c=\'' + item.Event__c + '\' AND Item__c=\'' + item.id + '\' AND Ticket_Status__c=\'Available\' AND Parent_ID__c=null ORDER BY Name LIMIT ' + RecordCount);
            } else {
                //  TicketList = TicketDAO.getTickets('id,name,Item__r.item_type__r.Name,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Item_Pool__r.Package_Flag__c,Parent_ID__c,Item_Pool__r.Badgable__c','Event__c=\''+item.Event__c +'\' AND Item__r.item_name__c=\''+item.item_name__c+'\' AND Ticket_Status__c=\'Available\' AND Parent_ID__c=null AND Item_Pool__r.Badgable__c=\'B - Badge\' ORDER BY Name LIMIT '+ RecordCount);
                TicketList = TicketDAO.getTickets('id,name,Item__r.item_type__r.Name,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Item_Pool__r.Package_Flag__c,Parent_ID__c,Item_Pool__r.Badgable__c', 'Event__c=\'' + item.Event__c + '\' AND Item__c=\'' + item.id + '\' AND Ticket_Status__c=\'Available\' AND Parent_ID__c=null ORDER BY Name LIMIT ' + RecordCount);

            }
        }
        TicketList.addAll(PackageTickets);
        return TicketList;
    }
    // Get Event Payment Gateways
    public LIST<Event_Pay_Gateway__c> getEventPayGateWays(String EventId) {
        // Get Event Payment Gateways from Event PayGateway DAO
        BLN_EventPayGateway_DAO EventPayGatewayDAO = new BLN_EventPayGateway_DAO();
        LIST<Event_Pay_Gateway__c> EventPayGateWays = EventPayGatewayDAO.getEventPayGateWays(EventId);

        return EventPayGateWays;
    }

    public List<Ticket__c> ticketsForupdatePkg {get; set;}
    // Update Ticket Details
    /* public BLN_StatusMessage updateTickets(LIST<String> UserIds,LIST<String> CompanyIds,LIST<String> TicketIds,String EventId,String OrderUserId, Decimal SubTotal, Decimal DiscountAmount, Decimal FeeAmount,Decimal TaxAmount, Decimal AmountPaid, MAP<Id,Id> PromotionIdMap,Integer PromotionCount,String PromoCode, String PayAddress, String ChargeType, String PGatewayType,String ChargeId, String PGatewayMode,String Module){
         ticketsForupdatePkg = new List<Ticket__c>();
         BLN_StatusMessage TicketUpdateMessage;



         //Buying Tickets
         BLN_Ticket_DAO TicketDAO = new BLN_Ticket_DAO();

         //Get Currency
         BLN_Currency_DAO CurDAO =new BLN_Currency_DAO();
         Currency__c cur = CurDAO.getCurrencyDetails('id,name','name=\'USD\' LIMIT 1');

         //Get PGateway Type
         BLN_PGateway_Type_DAO PGatewayDAO = new BLN_PGateway_Type_DAO();
         if(PGatewayMode == 'Stripe'){
             PGatewayType = 'Stripe';
         }else if(PGatewayMode == 'Authorize .Net'){
             PGatewayType = 'Authorize.Net';
         }else{

               PGatewayType = PGatewayType;
            //}
         }

          Event_Pay_Gateway__c  PGateway = new Event_Pay_Gateway__c  ();

          try{
             PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(eventId,PGatewayType,Module);
           }catch(exception er){}
         //Get User Details
         BLN_User_DAO UserDAO = new BLN_User_DAO();
         GN_User__c UserDetails = UserDAO.getGNUser(OrderUserId);

         //Insert Order
         BLN_Order_DAO OrderDAO =new BLN_Order_DAO();
         Order__c   Order = new Order__c();
         if(CompanyIds.size()>0){
             Order = new Order__c(Events__c=eventId,Amount_Paid__c=AmountPaid,Client_GN_User__c=OrderUserId,Client_Company__c=CompanyIds[0],Order_Total__c=AmountPaid,Order_Sub_Total__c=SubTotal,Order_Discount__c=DiscountAmount,Order_Status__c='Fully Paid',Currency_Code__c=cur.id,Fee_Amount__c=FeeAmount,Order_Taxes__c=TaxAmount);
        }else{
            Order = new Order__c(Events__c=eventId,Amount_Paid__c=AmountPaid,Client_GN_User__c=OrderUserId,Order_Total__c=AmountPaid,Order_Sub_Total__c=SubTotal,Order_Discount__c=DiscountAmount,Order_Status__c='Fully Paid',Currency_Code__c=cur.id,Fee_Amount__c=FeeAmount,Order_Taxes__c=TaxAmount);

        }
        System.debug('tttttttt'+Order.Order_Status__c);
         BLN_StatusMessage OrderMessage  =OrderDAO.insertorder(Order);
         try{
              orderId =OrderMessage.successId;
             }catch(exception er){}



         //Insert Payment
         BLN_payment_DAO PaymentDAO = new BLN_payment_DAO();
         Payment__c Payment = new Payment__c(Payment_Amount__c=AmountPaid,Order__c=OrderMessage.successId,Currency_Code__c=cur.id,credit_card_type__c=ChargeType,BLN_Pay_Gateway__c=PGateway.Pay_Gateway__r.Id,Pay_Address__c=PayAddress,Payment_Ref_Number__c=ChargeId);
         BLN_StatusMessage PaymentMessage = PaymentDAO.insertPayment(Payment);

         //Update Promotion
         BLN_PromoCode_BAL PromotionBAL = new BLN_PromoCode_BAL();
         BLN_Promotion_DAO PromotionDAO = new BLN_Promotion_DAO();

         LIST<Promotion__c> promotionlist  = new LIST<Promotion__c>();
         system.debug('Promo Code: '+PromoCode);
         if(PromoCode !=''){
             promotionlist = PromotionBAL.getPromotionDetails(eventId,PromoCode);
             if(promotionlist.size()>0){
                 for(Promotion__c p:promotionlist){
                     p.T_Used_Count__c += PromotionCount;
                 }
                 PromotionDAO.UpsertPromotion(promotionlist);
             }
         }

         MAP<ID, ID> findDuplicateItems = new MAP<ID, ID>(); // Map to find out duplicate order items

          system.debug('TTTTTTTTTTTTTTtt  '+TicketIds.size());

         // Looping through Users, Companies and Tickets
         for(integer i=0; i< TicketIds.size();i++){
             system.debug('AAAAAAAAAAAAAAAAAAA '+TicketIds[i]);
             //Getting Ticket Details to update
             LIST<Ticket__c> TicketsList = [select Parent_ID__c,id,name,First_Name__c,Last_Name__c,Company__c,Client_GN_User__c,item__r.Id,item__r.Ticket_Settings__c,Order__c,Order_Item__c,Item_Pool__r.Package_Flag__c,Item__c,Item__r.price__c,Event__c,Item_Type__r.name,Ticket_Status__c from Ticket__c where id=:TicketIds[i] ];
             //TicketDAO.getTickets('Parent_ID__c,id,name,First_Name__c,Last_Name__c,Company__c,Client_GN_User__c,item__r.Id,item__r.Ticket_Settings__c,Client_Company__c,Order__c,Order_Item__c,Item_Pool__r.Package_Flag__c,Item__c,Item__r.price__c,Event__c,Item_Type__r.name,Ticket_Status__c','id=\''+TicketIds[i]+'\' LIMIT 1');
             system.debug('AAAAAAAAAAAAAAAAAAA '+TicketsList);

             //Insert & Update Order Item
             BLN_StatusMessage OrderItemMessage;
             Id OrderItemId;
             Order_Item__c insertedOrderItem = new Order_Item__c();

             BLN_OrderItem_DAO OrderItemDAO = new BLN_OrderItem_DAO();
             if(!findDuplicateItems.containsKey(TicketsList[0].item__r.Id)){
                 findDuplicateItems.put(TicketsList[0].item__r.Id,TicketsList[0].item__r.Id);
                 Order_Item__c OrderItem = new Order_Item__c(Currency__c=Cur.id,Item_Quantity__c=1,Item_Total__c=TicketsList[0].Item__r.price__c,Item__c = TicketsList[0].item__c,Item_Discount__c=DiscountAmount,Order__c=OrderMessage.successId,Promotion__c=PromotionIdMap.get(TicketsList[0].item__r.Id));
                 OrderItemMessage = OrderItemDAO.insertorder(OrderItem);
                 OrderItemId = OrderItemMessage.successId;

             }
             else{
               if(TicketsList[0].Parent_ID__c==null){
                     insertedOrderItem = OrderItemDAO.getOrderItem(OrderMessage.successId,TicketsList[0].item__r.Id);
                     insertedOrderItem.Item_Quantity__c = insertedOrderItem.Item_Quantity__c+1;
                     insertedOrderItem.Item_Total__c = insertedOrderItem.Item_Total__c+insertedOrderItem.Item__r.price__c;
                     LIST<Order_Item__c> insertedOrderItems = new LIST<Order_Item__c>();
                     insertedOrderItems.add(insertedOrderItem);
                     OrderItemMessage = OrderItemDAO.updateOrder(insertedOrderItems);
                     OrderItemId = OrderItemMessage.successId;
               }
             }

             // Update Ticket
             if(TicketsList[0].Item_Pool__r.Package_Flag__c=='P - Package item pool'){

                //List<Ticket__c> PackageTicket = new List<Ticket__c>();

                 //Get all Package Tickets
                 List<Ticket__c> PackageTicket = TicketDAO.getTickets('id,name,Order__c,item__r.Ticket_Settings__c,Order_Item__c,Ticket_Status__c','Parent_ID__c=\''+TicketsList[0].id+'\'');
                 List<Ticket__c> PackageTicket2 = new List<Ticket__c>(TicketDAO.getTickets('id,name,Order__c,item__r.Ticket_Settings__c,Order_Item__c,Ticket_Status__c','id=\''+TicketsList[0].id+'\''));
                  for(Ticket__c tc :PackageTicket2  ){
                    tc.Ticket_Status__c = 'Abandoned';
                  }


                 for(integer j=0;j<PackageTicket.size();j++){

                     ticketsForupdatePkg.add(PackageTicket[j]);
                     PackageTicket[j].Client_GN_User__c= UserIds[i];


                     try{
                     PackageTicket[j].Client_Company__c = CompanyIds[i];

                     }catch(exception e){}

                     PackageTicket[j].Order__c = OrderMessage.successId;
                     if(OrderItemId != NULL){
                         PackageTicket[j].Order_Item__c = OrderItemId;
                     }else{
                         PackageTicket[j].Order_Item__c = insertedOrderItem.Id;
                     }
                     PackageTicket[j].Ticket_Status__c = 'Abandoned';

                 }


               //Update Package Ticket
                 TicketsList[0].Client_GN_User__c= UserIds[i];

                  try{
                     TicketsList[0].Client_Company__c = CompanyIds[i];

                  }catch(exception ex){}
                 TicketsList[0].Order__c = OrderMessage.successId;
                 if(OrderItemId != NULL){
                     TicketsList[0].Order_Item__c = OrderItemId;
                 }else{
                     TicketsList[0].Order_Item__c = insertedOrderItem.Id;
                 }
                 TicketsList[0].Ticket_Status__c='Abandoned';
                 PackageTicket.add(TicketsList[0]);
                 TicketUpdateMessage = TicketDAO.updateTicket(PackageTicket);
             }
             else{
                 //Update Individual Ticket
                 system.debug('Ticket Details are : '+TicketsList[0]);
                 TicketsList[0].Ticket_Status__c='Abandoned';
                 try{
                 TicketsList[0].Client_GN_User__c= UserIds[i];
                 }catch(exception er){}
                  try{
                   TicketsList[0].Client_Company__c = CompanyIds[i];

                 }catch(exception ey){}
                 TicketsList[0].Order__c = OrderMessage.successId;
                 if(OrderItemId != NULL){
                     TicketsList[0].Order_Item__c = OrderItemId;
                 }else{
                     TicketsList[0].Order_Item__c = insertedOrderItem.Id;
                 }

                 TicketUpdateMessage = TicketDAO.updateTicket(TicketsList[0]);
                 system.debug('Updated Ticket Response: '+TicketUpdateMessage);
             }
         }
         return TicketUpdateMessage;
     }
     */
    // ----------------------------------------------------- Edit for Regular Registration by Mahesh Sakunala --------------------- END ------------------------------------------------------


    //Get Badge For Ticket
    public String getBadgeForTicket(String ticketId) {
        BLN_Badge_DAO badgedao = new BLN_Badge_DAO();
        String badgeid = badgedao.getBadgeForTicket(ticketId);

        //For tickets having the same badge
        if (badgeid == '') {
            BLN_Ticket_DAO tcktdao = new BLN_Ticket_DAO();
            List<Ticket__c> tc = tcktdao.getTickets('id,name,Badge_Label__c,Badge_ID__c', 'id=\'' + ticketId + '\'');
            if (tc.size() != 0)
                badgeid = tc[0].Badge_ID__c;
        }
        return badgeid;
    }


    //Get all the booked tickets for showing in picklist
    public List<Ticket__c> getBookedTickets(String event) {
        BLN_Ticket_DAO tcktdao = new BLN_Ticket_DAO();
        return tcktdao.getTickets('id,name,Order_Item__r.Item__r.item_name__c,Order__r.Name,item__r.Ticket_Settings__c', 'Event__c=\'' + event + '\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'N - No Badge\' order by Order__r.Name');
    }



//*******************************************************************
//Get Details to fill the form for updateprnt
    public Ticket__c getItemInfoFrmTicket(String ticketId) {
        BLN_Ticket_DAO tcktdao = new BLN_Ticket_DAO();
        List<Ticket__c> tckt = tcktdao.getTickets('id,name,Custom_Barcode__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.name,Badge_ID__r.badge_label__c,(select id,name,badge_label__c from badges__r where cancel_time__c=null and Exp_time__c=null),Order__c,Order__r.id,Order_Item__c,Order_Item__r.Item__r.id,Order_Item__r.Item__r.item_name__c,tkt_profile__c,tkt_profile__r.First_Name__c,tkt_profile__r.BLN_GN_User__c,tkt_profile__r.Last_Name__c,tkt_profile__r.TKT_Company__c,tkt_profile__r.Email__c,tkt_profile__r.TKT_Job_Title__c,tkt_profile__r.Mobile__c', 'id=\'' + ticketId + '\'');
        return tckt[0];
    }
//**********************************************************************


    //Update Existing Ticket Information

    public void updateExistingBadge(String reason, String oldbadgelabel, String badgelabel, String oldASTitle , String ASTitle , String oldASPhone , String ASPhone, String oldASFirstName, String ASFirstName, String oldASLastName, String ASLastName, String oldASUserEmail, String ASUserEmail, String oldASCompanyName, String ASCompanyName, String ticketitems ) {

//update badge
        String[] ticketidandclientids = ticketitems.split(';');
        String ticketids = ticketidandclientids [0];
        generateBadge(badgelabel, ticketids, reason);
        BLN_Ticket_DAO tcktdao = new BLN_Ticket_DAO();
        List<Ticket__c> tc = tcktdao.getTickets('tkt_profile__c,Order__c,Order__r.id,Order_Item__c,item__r.Ticket_Settings__c,Order_Item__r.Item__r.id,Order_Item__r.Item__r.item_name__c', 'id=\'' + ticketids + '\'');
        BLN_MyticketsCon ordercon = new BLN_MyticketsCon('load');

        ordercon.isOrderEdit = true;
        ordercon.settingsForbuyer = new List<Reg_Setting__c>();
        ordercon.addGuest = new Ticket__c();
        Gn_User__c gnu1 = new Gn_User__c();
        User newu = new User();
        ordercon.comp = new Company__c();
        ordercon.compext = new Company_Ext__c();
        ordercon.billingaddr = new Pay_Address__c();
        ordercon.mapguIdWithGNU = new MAP<id, GN_User__c>();
        ordercon.tktprofile = [select First_Name__c,Video__c, Email__c, Last_Name__c, TKT_Company__c, TKT_Job_Title__c, Mobile__c from  Tkt_profile__c where id = :tc[0].tkt_profile__c];
        try{
        ordercon.iframelink=ordercon.tktprofile.Video__c;
        ordercon.imageData='';
        ordercon.AttData='';
        }catch(Exception e){}
        
        ordercon.hAddress = new BLN_Address__c();
        ordercon.wAddress = new BLN_Address__c();
        ordercon.bAddress = new BLN_Address__c();
        ordercon.sAddress = new BLN_Address__c();
//update user information
        if (oldASFirstName != ASFirstName) {
            ordercon.tktprofile.put('First_Name__c', ASFirstName);
        }
        if (oldASLastName != ASLastName) {
            ordercon.tktprofile.put('Last_Name__c', ASLastName);

        }
        if (oldASCompanyName != ASCompanyName) {
            ordercon.tktprofile.put('TKT_Company__c', ASCompanyName);
        }
        if (oldASTitle != ASTitle) {
            ordercon.tktprofile.put('TKT_Job_Title__c', ASTitle);
        }
        if (oldASPhone != ASPhone) {
            ordercon.tktprofile.put('Mobile__c', ASPhone);
        }
        if (oldASUserEmail != ASUserEmail) {
            ordercon.tktprofile.put('Email__c', ASUserEmail);


        }
        ordercon.beforeEditEmail = oldASUserEmail;
        ordercon.SaveGuests();

    }
    //Get Tickets based on orderno or email
    //************************************************************************
    public List<Ticket__c > getClientTicketsbasedonOrderOrEmail(String eventId, String ordernoOremail) {
        BLN_Ticket_DAO tcktdao = new BLN_Ticket_DAO();
        List<Ticket__c > tckts = tcktdao.getTickets('id,name,Custom_Barcode__c,Badge_Label__c,Badge_ID__c,Badge_ID__r.Badge_Label__c,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null),Order__r.Name,Event__c,Order__c,Order__r.id,Order_Item__c,Order_Item__r.Item__r.id,Order_Item__r.Item__r.item_name__c,Ticket_Status__c,Item_Pool__r.Badgable__c,tkt_profile__c,tkt_profile__r.First_Name__c,tkt_profile__r.BLN_GN_User__c,tkt_profile__r.Last_Name__c,tkt_profile__r.TKT_Company__c,tkt_profile__r.Email__c', 'Event__c=\'' + eventId + '\' and Ticket_Status__c=\'Booked\' and Item_Pool__r.Badgable__c=\'B - Badge\' and (tkt_profile__r.Email__c=\'' + ordernoOremail + '\' or Order__r.name=\'' + ordernoOremail + '\' or tkt_profile__r.First_Name__c=\'' + ordernoOremail + '\' or tkt_profile__r.Last_Name__c=\'' + ordernoOremail + '\' or tkt_profile__r.TKT_Company__c=\'' + ordernoOremail + '\' or Custom_Barcode__c=\'' + ordernoOremail + '\') order by Order__r.Name');
        if (tckts.size() > 0)
            return tckts;
        else
            return new List<Ticket__c>();
    }
//****************************************************************

    //Generate Badge while printing
    public void generateBadgeMultiple(Map<String, String> ticketbadgemap) {

        List<Badge__c> bglist = new List<Badge__c>();
        for (String ticketid : ticketbadgemap.keySet()) {
            bglist.add(new Badge__c(Badge_Label__c = ticketbadgemap.get(ticketid), ticket_id__c = ticketid));
            autosplitpackage(ticketid);
        }

        List<Database.SaveResult> res = Database.insert(bglist, false);

        List<Ticket__c> uplist = new List<Ticket__c>();
        for (Integer i = 0; i < bglist.size(); i++) {
            Database.SaveResult s = res[i];
            if (s.isSuccess()) {
                uplist.add(new Ticket__c(id = bglist[i].ticket_id__c, badge_label__c = bglist[i].Badge_Label__c, badge_id__c = s.getId()));
            }
        }
        List<Database.SaveResult> uptckt = Database.update(uplist, false);
        
        
        
    }
    //used for attendees page portal
    public String generateBadge(String badgelabel, String ticketid, String Reason) {
    //split package
    autosplitpackage(ticketid);
        //get the badge for ticket if exists which is not cancelled
        try {
            String q = 'select id,name,badge_label__c,cancel_time__c,Cancel_Reason__c from Badge__c where ticket_id__c=\'' + ticketid + '\' and cancel_time__c=null and Exp_time__c=null limit 1';
            Badge__c badge = Database.query(q);
            badge.cancel_time__c = System.now();
            badge.Cancel_Reason__c = Reason;
            update badge;
        } catch (Exception e) {}


        //generate badge for single ticket
        Badge__c bg = new Badge__c();
        bg.Badge_Label__c = badgelabel;
        bg.ticket_id__c = ticketid;
        BLN_Badge_DAO bdgdao = new BLN_Badge_DAO();

        BLN_StatusMessage userMsg =  bdgdao.insertbadge(bg);

        if (userMsg.successBool) {
            //update badgeid in ticket
            Ticket__c up = new Ticket__c();
            up.id = ticketid;
            up.badge_label__c = badgelabel;
            up.badge_id__c = userMsg.successId;
            update up;
            return userMsg.successId;

        } else {
            return userMsg.errors ;
        }
        
        
        

    }
    
   
    public void autosplitpackage(String ticketid)
    {
    try{
    //only excutes if it is not splitted
    List<Ticket__c> existingtc=[select id,name,Parent_ID__c,Item_Pool__c,badgeparentid__c from Ticket__c where badgeparentid__c=:ticketid and Parent_ID__c!=null limit 1];
    if(existingtc.size()==0)
    {
        List<Ticket__c> tc=[select id,name,Parent_ID__c,Item_Pool__c,Parent_ID__r.Item_Pool__c from Ticket__c where id=:ticketid and Parent_ID__c!=null limit 1];
        //logic executes only when package
        if(tc.size()>0){
                //Get all the admission tickets
    List<Ticket__c> admticket=[select id,name,Badge_Label__c,Item_Pool__c,Item_Pool__r.Item_type__r.name,Parent_ID__c from Ticket__c where Parent_ID__c=:tc[0].Parent_ID__c and Item_Pool__r.Item_type__r.name='Admissions'];
    //Get all the line items pool except admission
    List<Item_Pool__c> otherpool=[select id,name,Addon_Parent__c,Item_Count__c,Item_type__r.name from Item_Pool__c where Addon_Parent__c=:tc[0].Parent_ID__r.Item_Pool__c and Item_type__r.name!='Admissions'];
    try{
    for(integer i=0;i<otherpool.size();i++)
           {
                //get addontickets for that pool
                List<Ticket__c> child=[select id,name,badgeparentid__c,Parent_ID__c,Item_Pool__c from Ticket__c where Parent_ID__c=:tc[0].Parent_ID__c and Item_Pool__c=:otherpool[i].id];
                Integer j=0;
                for(;j<child.size();j++)
                {
                    if(j==admticket.size())
                    break;
                   child[j].badgeparentid__c=admticket[j].id;
                   
                }
                for(Integer rem=j;rem<child.size();rem++)
                {
                   child[rem].badgeparentid__c=admticket[admticket.size()-1].id;
                }
                  update child;
               
               }
               }catch(Exception e){}
               }
   }
        }catch(Exception e){}
        
    }


    //------------------------------------------------------------------------- Registration start --------------------------


    public static BLN_User_DAO usrdao = new BLN_User_DAO();
    BLN_Gnuser_DAO blnusersdao = new BLN_Gnuser_DAO();

//################ Deleting Previous  Data ################## 
 public void deleteDT(String ordId){
   SET<id> tktProfileIds =new SET<id>(); 
   SET<id> tcIds = new SET<id>();
   // Order deletion 
   try{
     Order__c ordDel = [select BLN_TKT_profile__c,id,(select id from Payments__r),(select id from Order_Items__r) from Order__c where id=:ordId];
     //(select id,tkt_profile__c from Tickets__r)   
      for(Ticket__c tc : [select id,tkt_profile__c from Ticket__c where Order__c =:ordId]){
        tktProfileIds.add(tc.tkt_profile__c);
        tcIds.add(tc.id);
    }

    tktProfileIds.add(ordDel.BLN_TKT_profile__c);
    List<Company_Naicscodes__c> compNaics = [SELECT id from Company_Naicscodes__c where BLN_TKT_profile__c In :tktProfileIds];
    List<Company_Diversity__c> compDivs = [SELECT id from Company_Diversity__c where BLN_TKT_profile__c In :tktProfileIds];
    List<BLN_Company_Commoditie__c> compCommo = [SELECT id from BLN_Company_Commoditie__c where BLN_TKT_profile__c In :tktProfileIds];
    SET<id> addressList = new SET<id>();
    List<Tkt_profile__c> tktPList12 =new List<Tkt_profile__c>();
    tktPList12= [select id,Home_Address__c,Work_Address__c,Billing_Address__c,Shipping_Address__c from Tkt_profile__c where Id In :tktProfileIds]; 
    for(Tkt_profile__c forAdd : tktPList12){
       addressList.add(forAdd.Home_Address__c);
       addressList.add(forAdd.Work_Address__c);
       addressList.add(forAdd.Billing_Address__c);
       addressList.add(forAdd.Shipping_Address__c);  
    }
    List<BLN_Address__c> addList = [SELECT id from BLN_Address__c where Id In :addressList];
    List<User_Answer__c> uns =[SELECT id,Ticket__c from User_Answer__c where Ticket__c IN :tcIds];  
   
    System.debug('tcIds   One   '+tcIds);
    Database.delete(compNaics,false);
    Database.delete(compDivs,false);
    Database.delete(compCommo,false); 
    DataBase.delete(addList,false);
    DataBase.DeleteResult[] dtRes = DataBase.delete(tktPList12,false);
    System.debug('tcIds   TWO   '+tcIds);
    List<Ticket__c> tctempList = [select id,isDeleted from Ticket__c where id in : tcIds all rows];
    System.debug('Tc temp List values   '+tctempList);
    Database.delete(ordDel.Payments__r,false);  
    Database.delete(ordDel.Order_Items__r,false);
    DataBase.delete(uns,false);
    DataBase.delete(ordDel,false);
   System.debug('tcIds   Three   '+tcIds);
    List<Ticket__c> tctempList1 = [select id,isDeleted from Ticket__c where id in : tcIds all rows];
    System.debug('Tc temp List values  Three '+tctempList1);}catch(Exception e){}
 } 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Ragistration insertion start ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    public String  insertingTotalorder(List<BLN_RegistrationnewCon3.ItemInnerClass> itemsListInn, List<BLN_RegistrationnewCon3.TicketInnerClass> regInn1, BLN_RegistrationnewCon3.TicketInnerClass buyerInfo, Decimal SubTotal, Decimal DiscountAmount, Decimal FeeAmount, Decimal TaxAmount, Decimal AmountPaid, MAP<id, decimal> mapitemWithFee, MAP<id, decimal> mapitemWithDiscount, Promotion__c PromotionOb, String ChargeType, String PGatewayType, String ChargeId, String PGatewayMode, String module, String crdno, String keyName) {
       SavePoint dtSave =  Database.setSavepoint();
          If(OrderId!=null && OrderId!='')// deleting previous order
            deleteDT(OrderId);

        string  orderStatus = 'Success';
        System.debug('Bln Quick registration invoked ' + regInn1.size());
//============================== Variable start ==============================================================
        SET<String> userEmails = new SET<String>();  //All emails for sending and checking esiting or not
        MAP<String, id> exitingUserList  = new MAP<String, id>(); // hold exiting users
        List<BLN_RegistrationnewCon3.TicketInnerClass> parentIdFirstTolist = new List<BLN_RegistrationnewCon3.TicketInnerClass>(); // Adding all parent items first
        List<BLN_RegistrationnewCon3.TicketInnerClass> poolIdLastlist = new List<BLN_RegistrationnewCon3.TicketInnerClass>(); // Adding package line items Last
        List<BLN_RegistrationnewCon3.TicketInnerClass> regInn = new List<BLN_RegistrationnewCon3.TicketInnerClass>();
        List<GN_User__c> gnuserToinsert = new List<GN_User__c>();// List of users to insert
        LIst<surveyQuestions> surveysListToinsert = new List<surveyQuestions>();
        List<Attachment> attchMentsList = new List<Attachment>();
        MAP<String, BLN_RegistrationnewCon3.TicketInnerClass> mapParentRecWithItsName = new MAP<String, BLN_RegistrationnewCon3.TicketInnerClass>();
        Ticket__c  tIdforevQuestions = new Ticket__c();// We will assign all event level  questions to this ticket i
        List<Company_Naicscodes__c> sObjForna = new List<Company_Naicscodes__c>();
        List<BLN_Company_Commoditie__c> sObjForcomm = new List<BLN_Company_Commoditie__c>();
        List<Company_Diversity__c> sObjForDiv = new List<Company_Diversity__c>();
        List<Company_Ext__c> comExtList = new  List<Company_Ext__c>();
        List<Uc_role__c> ucRoleList = new List<Uc_role__c>();
        List<Ticket__c> tcListUpStatus = new List<Ticket__c>();
        // ---------------------------------- End ------------------------------------



        // Iterating Rating inner class to separate email address
        if (regInn1.size() <= 0) {
            return 'No tickets found';
        } else {
             userEmails.add(buyerInfo.tktProfileObject.Email__c);// Addign buyer user values to List
             if(regInn1[0].tktProfileObject.Email__c==null){ // Assign buyer values to first Ticket
              regInn1[0].SpeakerPic1 =buyerInfo.SpeakerPic1;
              regInn1[0].SpeakerImageName1 =buyerInfo.SpeakerImageName1;
               regInn1[0].CompanyPic1 =buyerInfo.CompanyPic1;
              regInn1[0].CompanyImageName1=buyerInfo.CompanyImageName1;
              regInn1[0].myfile1=buyerInfo.myfile1;
              regInn1[0].myfilename1 =buyerInfo.myfilename1;

             /*  regInn1[0].tktProfileObject =buyerInfo.tktProfileObject;
               regInn1[0].homeAddress =buyerInfo.homeAddress;
               regInn1[0].workAddress =buyerInfo.workAddress;
               regInn1[0].shippingAddress =buyerInfo.shippingAddress;
               regInn1[0].billingAddress =buyerInfo.billingAddress;
               regInn1[0].customBarcode =buyerInfo.customBarcode;
               regInn1[0].SpeakerPic1 =buyerInfo.SpeakerPic1;
               regInn1[0].SpeakerImageName1 =buyerInfo.SpeakerImageName1;
               regInn1[0].selectedNaicsCodes =buyerInfo.selectedNaicsCodes;
               regInn1[0].selecteddivers =buyerInfo.selecteddivers;
               regInn1[0].selectedCommodities = buyerInfo.selectedCommodities;*/
             }

            // ------------------------------Adding info gnusers to insert if not exist End ----------------------
            for (BLN_RegistrationnewCon3.TicketInnerClass tinn1 : regInn1) {
                 tinn1.Ticket.Ticket_Status__c='Abandoned'; 
                 tcListUpStatus.add(tinn1.Ticket);

                // ------------------------------Adding info gnusers to insert if not exist End ----------------------
                if (null != tinn1.tktProfileObject.Email__c) { // checking user provide email or not
                    userEmails.add(tinn1.tktProfileObject.Email__c);
                } else {
                    tinn1 = tcValAssignment(tinn1, buyerInfo);
                    System.debug('Assigning buyer value to tickets   ' + tinn1);
                }
                // -------------- i am mapping package parent id with parent ticket. Advantage with this is in reg page if setting is at package level i am collection info to paent record -------------
                if (tinn1.Ticket.Item_Type__r.name == 'Package' && tinn1.Ticket.Item__r.Ticket_Settings__c == 'Collect info from All Attendees' && tinn1.Ticket.Parent_ID__c == null) {
                    mapParentRecWithItsName.put(tinn1.Ticket.id, tinn1);
                }

                // Differentiating item and package line item
                if (tinn1.Ticket.Parent_ID__c == null)
                    parentIdFirstTolist.add(tinn1);
                else
                    poolIdLastlist.add(tinn1);
            }
        }
        regInn.addAll(parentIdFirstTolist);
        regInn.addAll(poolIdLastlist);
        System.debug('regInn Values After buyer info added  ' + regInn);
        
        // -------------------------------Inserting Scan ids--------------------------------------------
           BLN_generateScanId createScanId = new BLN_generateScanId();
           createScanId.insertScanId(tcListUpStatus); // Tickets will be updated in this list and also this will give scan id
        // ------------------------------- User existence checking start --------------------------
        for (Gn_User__c gnu : blnusersdao.existingGnusers(userEmails)) {
            exitingUserList.put(gnu.Email__c, gnu.id);
        }

        SET<String> DupEmail = new SET<String>();
        if (!exitingUserList.keyset().contains(buyerInfo.tktProfileObject.Email__c)) {
            DupEmail.add(buyerInfo.tktProfileObject.Email__c);
            Gn_User__c gnubuyerInd = new Gn_User__c();
            gnubuyerInd = AssignGnuserValues(gnubuyerInd, buyerInfo.tktProfileObject);
            gnuserToinsert.add(gnubuyerInd);
        }

        for (BLN_RegistrationnewCon3.TicketInnerClass tinnForUser : regInn1) {
            if (!exitingUserList.keyset().contains(tinnForUser.tktProfileObject.Email__c)  && !DupEmail.contains(tinnForUser.tktProfileObject.Email__c) ) {
                DupEmail.add(tinnForUser.tktProfileObject.Email__c);
                Gn_User__c gnuAttendee = new Gn_User__c();
                gnuAttendee = AssignGnuserValues(gnuAttendee, tinnForUser.tktProfileObject);
                gnuserToinsert.add(gnuAttendee);
            }
        }

//================================   INSERTING GN USERS =====================================
        system.debug('nnnnnnnnnnnnn'+gnuserToinsert);
        MAP<String, GN_User__c> mapEmWithUid = new MAP<String, GN_User__c>();
        mapEmWithUid = insertingusers(gnuserToinsert);// This will insert and return all user ids

// ===============    buyer info insertion start ================================
        SET<String> buyerSet = new SET<String>();
        for (Reg_Setting__c bSet : buyerInfo.settingsForbuyer) {
            if (bset.Group_Name__c == 'Address Information') {
                if (bSet.Included__c == true)
                    buyerSet.add(bset.Column_Name__c);
            }
        }
        System.debug('Buyer info need to collect ========  ' + buyerSet);
        // ------------------ Inserting buyer tkt profile -------------------------------------
        buyerInfo.tktProfileObject =  AssignAddressProfileStuff(buyerInfo, mapEmWithUid, buyerSet);
        System.debug('Buyer info After Address Inserted ========  ' + buyerInfo);
        if (mapEmWithUid.keyset().contains(buyerInfo.tktProfileObject.Email__c)) {
            buyerInfo.tktProfileObject.BLN_GN_user__c = mapEmWithUid.get(buyerInfo.tktProfileObject.Email__c).id;
        } else {
            buyerInfo.tktProfileObject.BLN_GN_user__c = exitingUserList.get(buyerInfo.tktProfileObject.Email__c);
        }
        system.debug('spknotmap'+buyerInfo.SpeakerPic1);
        buyerInfo.tktProfileObject.User_Pic__c = userPicInsert1(buyerInfo.SpeakerPic1, buyerInfo.SpeakerImageName1);
        system.debug('assignspknotmap'+buyerInfo.tktProfileObject.User_Pic__c);
        system.debug('compnotmap'+buyerInfo.CompanyPic1);
        //Company Logo
        buyerInfo.tktProfileObject.Company_Logo__c = compPicInsert1(buyerInfo.CompanyPic1, buyerInfo.CompanyImageName1);
        system.debug('assigncompnotmap'+buyerInfo.tktProfileObject.Company_Logo__c);

        DataBase.SaveResult buyertktProfileres = Database.insert(buyerInfo.tktProfileObject, false);
        System.debug('Buyer Ticket profile '+buyertktProfileres);
        String buyerTktProfileInfo ;
        if (buyertktProfileres.isSuccess()) {
            buyerTktProfileInfo = buyertktProfileres.getId();
            //Adding naics values to list
            if (buyerInfo.selectedNaicsCodes != null && buyerInfo.selectedNaicsCodes != '') {
                if (compNaics(buyerInfo.selectedNaicsCodes, buyerTktProfileInfo, '', '').size() > 0) {
                    sObjForna.addAll(compNaics(buyerInfo.selectedNaicsCodes, buyerTktProfileInfo, '', ''));
                }
            }
            //Adding Diversities values to list
            if (buyerInfo.selecteddivers != null  && buyerInfo.selecteddivers != '') {
                if (compDivesity(buyerInfo.selecteddivers, buyerTktProfileInfo, '', '').size() > 0) {
                    sObjForDiv.addAll(compDivesity(buyerInfo.selecteddivers, buyerTktProfileInfo, '', ''));
                }
            }

            //Adding Diversities values to list
            if (buyerInfo.selectedCommodities != null && buyerInfo.selectedCommodities != '') {
                if (compCommodity(buyerInfo.selectedCommodities, buyerTktProfileInfo, '', '').size() > 0) {
                    sObjForcomm.addAll(compCommodity(buyerInfo.selectedCommodities, buyerTktProfileInfo, '', ''));
                }
            }
            System.debug('Buyer tkt profile Id ========  ' + buyerTktProfileInfo);
            if (null != buyerInfo.myfile1 && buyerInfo.myfile1 != '' ) {
                if (buyerInfo.myfile1.length() <= 4024000) {
                    Attachment buyerattach = new Attachment(parentId = buyerTktProfileInfo, name = buyerInfo.myfilename1, body = EncodingUtil.base64Decode(buyerInfo.myfile1));
                    attchMentsList.add(buyerattach);
                }
            }
        }

// ======================== Order insertion and Order item insertion start ===============================
        // ------------------------- Inserting order Start ---------------------------------
        String eventid = '';
        if (regInn.size() > 0) {
            eventid = regInn[0].Ticket.Event__c;
        }
        BLN_Currency_DAO CurDAO = new BLN_Currency_DAO();
        Currency__c cur = CurDAO.getCurrencyDetails('id,name', 'name=\'USD\' LIMIT 1');
        Order__c  Order = new Order__c();
        Order.Events__c = eventid;
        Order.Amount_Paid__c = AmountPaid + FeeAmount + TaxAmount - DiscountAmount;
        Order.Order_Total__c = SubTotal + FeeAmount + TaxAmount - DiscountAmount;
        Order.Order_Sub_Total__c = SubTotal;
        Order.Order_Discount__c = DiscountAmount;
        Order.Order_Status__c = 'Abandoned';
        Order.Currency_Code__c = cur.id;
        Order.Fee_Amount__c = FeeAmount;
        Order.Order_Taxes__c = TaxAmount;
        Order.BLN_TKT_profile__c = buyerTktProfileInfo;
        database.saveresult dsave =  DataBase.insert(order, false);
        if (dsave.Issuccess()) {
            orderId = Order.id;
           // DataBase.saveresult[] Upr = Database.update(tcListUpStatus,false);
            System.debug('Order Id ========  ' + orderId);
        } else {
            for (Database.Error err : dsave.getErrors()) { // Operation failed, so get all errors
                 Database.Rollback(dtSave);
                System.debug('The following error has occurred.');
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
                return err.getMessage();
            }
        }

        // ------------------------ Insrting order Items ---------------
        BLN_OrderItem_DAO OrderItemDAO = new BLN_OrderItem_DAO();
        List<Order_Item__c> orderItemList = new List<Order_Item__c>();
        MAP<id, id> maoitemWithorderItem = new MAP<id, id>();
        for (BLN_RegistrationnewCon3.ItemInnerClass iicQuick : itemsListInn) {
            if (Decimal.valueOf(iicQuick.selectedItemQuantity) > 0) {
                Order_Item__c  ordIt = new Order_Item__c();
                ordIt.Item__c = iicQuick.items.id;
                ordIt.Item_Quantity__c = Decimal.valueOf(iicQuick.selectedItemQuantity);
                ordIt.Order__c = Order.id;
                ordIt.Currency__c = Cur.id;
                ordIt.Item_Total__c  = iicQuick.items.price__c * Decimal.valueOf(iicQuick.selectedItemQuantity);
                if (null != mapitemWithDiscount) {
                    if (mapitemWithDiscount.keySet().contains(iicQuick.items.id)) {
                        ordIt.Item_Discount__c = mapitemWithDiscount.get(iicQuick.items.id);
                        ordIt.Promotion__c  = PromotionOb.id;
                    }
                }
                if (null != mapitemWithFee) {
                    if (mapitemWithFee.keySet().contains(iicQuick.items.id)) {
                        if (FeeAmount > 0)
                            ordIt.Item_Fee__c = mapitemWithFee.get(iicQuick.items.id);
                        else
                            ordIt.Item_Fee__c = 0.0;
                    }
                }

                orderItemList.add(ordIt);
            }
        }
        BLN_StatusMessage blOrderItems = OrderItemDAO.insertOrderitem1(orderItemList);
        for (Order_Item__c ordit : OrderItemDAO.getTicketsOfperticularOItem(blOrderItems.successIds)) {
            maoitemWithorderItem.put(ordit.item__c, ordit.id);
        }
//=================================== Payment information insert start=============================
    patmentInsert(order,PGatewayType,PGatewayMode,Module,AmountPaid,ChargeType,ChargeId,crdno,cur.id);
 
       /* string paymodeTemp = ''; string paygatewayType = '';
        //Get PGateway Type
        BLN_PGateway_Type_DAO PGatewayDAO = new BLN_PGateway_Type_DAO();
        Event_Pay_Gateway__c  PGateway = new Event_Pay_Gateway__c  ();
        try {
            PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(eventId, PGatewayMode, Module);
        } catch (exception er) {}
        if (PGateway.Pay_Gateway__c == null) {
            if (PGatewayMode == 'Free') {
                BLN_Event_DAO evDao = new BLN_Event_DAO();
                BLN_Event__c  eves = new BLN_Event__c ();
                eves = evDao.getEventDetails(eventId)[0];
                PGateway_Type__c  freeGtype = new PGateway_Type__c();
                try {
                    freeGtype = [select id from PGateway_Type__c where Name = 'Free' ];
                } catch (exception e) {}
                if (null != freeGtype ) {
                    Pay_Gateway__c FreepgGate = new Pay_Gateway__c();
                    FreepgGate.Company__c = eves.organizer_id__c;
                    FreepgGate.PGateway_Type__c = freeGtype.id;
                    DataBase.SaveResult svRest = Database.insert(FreepgGate, false);
                    System.debug(' FreepgGate   res' + svRest );
                    if (svRest.Issuccess()) {
                        Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c();
                        epg.Registration_Type__c  = Module ;
                        epg.Events__c = eventId;
                        epg.Pay_Gateway__c = svRest.getId();
                        Database.SaveResult Sv = Database.insert(epg, false);
                        System.debug(' Event Pay gateway res' + Sv );
                        if (Sv.isSuccess()) {
                            System.debug('BHBHBHBBHHBHHBHBHBBHHBHBBHHBHB ' + eventId + '  ' + PGatewayMode + '  ' + Module);
                            try {
                                PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(eventId, PGatewayMode, Module);
                                System.debug(' PaymentGateway id  ' + PGateway );
                            } catch (exception er) {}
                        }
                    }
                }
            }
        }

        //------------------------------------- Payment object ---------------------------------
        if (PGatewayType != 'Cash' && PGatewayType != 'Check' &&  PGatewayType != 'External Pay Gateway' ) {
            if (PGatewayType == '') {
                paymodeTemp = 'Credit Card';
            } else if (PGatewayType == 'TrustCommerce' || PGatewayType == 'CreditCardPayPalDirect' || PGatewayType == 'Authorize.Net' || PGatewayType == 'Paypal') {
                paymodeTemp = 'Credit Card';
            } else {
                paymodeTemp =  PGatewayType;
            }
        } else if (PGatewayType == 'External Pay Gateway') {
            paymodeTemp = 'External Pay Gateway';
        } else {
            paymodeTemp = PGatewayType;
        }

        //Insert Payment
        BLN_payment_DAO PaymentDAO = new BLN_payment_DAO();
        Payment__c Payment = new Payment__c( Payment_Mode__c = paymodeTemp, Registration_Type__c = module, Payment_Amount__c = AmountPaid, Order__c = order.id, Currency_Code__c = cur.id, credit_card_type__c = ChargeType, BLN_Pay_Gateway__c = PGateway.Pay_Gateway__r.Id, Payment_Ref_Number__c = ChargeId, credit_card_last_4digits__c = crdno);
        BLN_StatusMessage PaymentMessage = PaymentDAO.insertPayment(Payment);*/
//============================================ Attendee Information insert Start =======================================
        // ---------------------  general info Settings -----------------------------------
        System.debug('Registration settings---------- ' + regInn[0].RegSettingMap);
        MAP<id, Set<String>> mapItemIdWithGName = new MAP<id, Set<String>>();
        try{
        for (Id regIds : regInn[0].RegSettingMap.keyset()) {
            SET<String> gpName = new SET<String>();
            for (Reg_Setting__c reg : regInn[0].RegSettingMap.get(regIds)) {
                if (reg.Group_Name__c == 'Address Information') {
                    if (reg.Included__c == true)
                        gpName.add(reg.Column_Name__c);
                }
            }
            mapItemIdWithGName.put(regIds, gpName);
            System.debug('Registration groups Attendee ---------- ' + gpName);
        }
        } catch (Exception e) {}


        //---------------- Assigning values to pools and normal tickets-----------------------
        for (BLN_RegistrationnewCon3.TicketInnerClass tinnupdate : regInn ) {
            if (tinnupdate.Ticket.Item_Type__r.Name == 'Package') {
                if (tinnupdate.Ticket.item__r.Ticket_Settings__c != 'Do not collect Attendee info') {
                    if (tinnupdate.Ticket.item__r.Ticket_Settings__c == 'Collect info from All Attendees') {
                        BLN_RegistrationnewCon3.TicketInnerClass tempPkg = new BLN_RegistrationnewCon3.TicketInnerClass();
                        if (tinnupdate.ticket.Parent_ID__c != null) { // Assigning parent record values to pool items
                            tempPkg = mapParentRecWithItsName.get(tinnupdate.ticket.Parent_ID__c);
                            tinnupdate = tcValAssignment(tinnupdate, tempPkg);
                        }
                    } else {
                        tinnupdate = tcValAssignment(tinnupdate, buyerInfo);
                    }
                } else { // Setting is at pool level
                    if (tinnupdate.Ticket.Item_Pool__r.Ticket_Settings__c != 'Collect info from All Attendees') { // Pool level setting is ciB(collect info from buyer)
                        tinnupdate = tcValAssignment(tinnupdate, buyerInfo);
                    }
                }
            }
        }

        //------------------------------------------ Inserting address and tkt profile for attendees -----------------------------------
        map<String, BLN_Address__c> homeAddressMap = new map<String, BLN_Address__c>();
        map<String, BLN_Address__c> workAddressMap = new map<String, BLN_Address__c>();
        map<String, BLN_Address__c> billingAddressMap = new map<String, BLN_Address__c>();
        map<String, BLN_Address__c> shippingAddressMap = new map<String, BLN_Address__c>();
        MAP<String, Document> userPicMap = new MAP<String, Document>(); // to Hold user pics
        MAP<String, Document> compPicMap = new MAP<String, Document>();
        List<tkt_profile__c> tktProfileToInsert = new List<tkt_profile__c>();
        MAP<String, Company__c> companyMap = new MAP<String, Company__c>();
        SET<String> dupRemover = new SET<String>();


        dupRemover.add(buyerInfo.tktProfileObject.Email__c);
        List<Hash_Tag__c> hashTagList = new List<Hash_Tag__c>();
        // Step 1  : Inserting tktPorfile and use id of it is as key in MAP
        for (BLN_RegistrationnewCon3.TicketInnerClass tp : regInn ) {
            SET<String> gpNameTemp = new SET<String>();
            if (null != mapItemIdWithGName.get(tp.Ticket.item__r.id)) {
                gpNameTemp = mapItemIdWithGName.get(tp.Ticket.item__r.id);
            } else if (null != mapItemIdWithGName.get(tp.Ticket.item__r.Item_Pool__r.id)) {
                gpNameTemp = mapItemIdWithGName.get(tp.Ticket.item__r.Item_Pool__r.id);
            }
            
            if(null!=mapEmWithUid.get(tp.tktProfileObject.Email__c)){
                  tp.tktProfileObject.BLN_GN_User__c = mapEmWithUid.get(tp.tktProfileObject.Email__c).id;
                }else{
                   tp.tktProfileObject.BLN_GN_User__c = exitingUserList.get(tp.tktProfileObject.Email__c);
               
                }
            tp.tktProfileObject.id=null; 
            tp.tktProfileObject.Home_Address__c =null;
            tp.tktProfileObject.Work_Address__c =null;
            tp.tktProfileObject.billing_Address__c =null;
            tp.tktProfileObject.shipping_Address__c =null;
            tktProfileToInsert.add(tp.tktProfileObject);
            //if(tktProfileres.isSuccess()){
            String tktPId = tp.Ticket.id;
            if (gpNameTemp.contains('Home Address'))
                homeAddressMap.put(tktPId, tp.homeAddress);
            if (gpNameTemp.contains('Work Address'))
                workAddressMap.put(tktPId, tp.workAddress);
            if (gpNameTemp.contains('Billing Address'))
                billingAddressMap.put(tktPId, tp.billingAddress);
            if (gpNameTemp.contains('Shipping Address'))
                shippingAddressMap.put(tktPId, tp.shippingAddress);
            if (tp.SpeakerPic1 != '' && tp.SpeakerImageName1 != '') {
                if (null != userPicInsert(tp.SpeakerPic1, tp.SpeakerImageName1)) {
                    userPicMap.put(tktPId, userPicInsert(tp.SpeakerPic1, tp.SpeakerImageName1));
                }
            }
             if (tp.CompanyPic1 != '' && tp.CompanyImageName1 != '') {
             system.debug('compmap'+tp.CompanyImageName1);
                if (null != compPicInsert(tp.CompanyPic1, tp.CompanyImageName1)) {
                    compPicMap.put(tktPId, compPicInsert(tp.CompanyPic1, tp.CompanyImageName1));
                }
            }
            // }
            if (!exitingUserList.keyset().contains(tp.tktProfileObject.Email__c) && !dupRemover.contains(tp.tktProfileObject.Email__c)) {
                Company__c newComp = new Company__c();
                if (tp.tktProfileObject.TKT_Company__c != null && tp.tktProfileObject.TKT_Company__c != '') {
                    newComp.Name = tp.tktProfileObject.TKT_Company__c;
                } else {
                    newComp.Name = tp.tktProfileObject.First_Name__c + tp.tktProfileObject.Last_Name__c;
                }
                companyMap.put(tp.Ticket.id, newComp);
                dupRemover.add(tp.tktProfileObject.Email__c);

            }
        }

        if (tktProfileToInsert.size() > 0 ){
            System.debug(' tktProfileToInsert '+tktProfileToInsert);
            Database.SaveResult[] savtkt = Database.insert(tktProfileToInsert, false);
            System.debug('TKT Profile for ticket '+savtkt);
        }

        if (homeAddressMap.values().size() > 0)
            Database.SaveResult[] savhadd = Database.insert(homeAddressMap.values(), false);
        if (workAddressMap.values().size() > 0){
            Database.SaveResult[] savwadd = Database.insert(workAddressMap.values(), false);
            System.debug(' Work address  '+savwadd);
        }

        if (billingAddressMap.values().size() > 0)
            Database.SaveResult[] savbadd = Database.insert(billingAddressMap.values(), false);
        if (shippingAddressMap.values().size() > 0)
            Database.SaveResult[] savsadd = Database.insert(shippingAddressMap.values(), false);
        if (userPicMap.values().size() > 0)
            Database.SaveResult[] savuPic = Database.insert(userPicMap.values(), false);
              if (compPicMap.values().size() > 0)
            Database.SaveResult[] savuPic1 = Database.insert(compPicMap.values(), false);
        if (companyMap.values().size() > 0)
            Database.SaveResult[] savuComp = Database.insert(companyMap.values(), false);


//------------------------------------ Assigning address ,pic, Company Logo to tkt profiles Start------------------------------------
        List<Tkt_profile__c> tktlistToUpdate = new List<Tkt_profile__c>();
        for (BLN_RegistrationnewCon3.TicketInnerClass tp : regInn ) {
            if (tp.tktProfileObject.id != null) {
                if (homeAddressMap.keyset().contains(tp.Ticket.id))
                    tp.tktProfileObject.Home_Address__c = (null != homeAddressMap.get(tp.Ticket.id)) ? homeAddressMap.get(tp.Ticket.id).id : null;
                if (workAddressMap.keyset().contains(tp.Ticket.id))
                    tp.tktProfileObject.Work_Address__c = (null != workAddressMap.get(tp.Ticket.id)) ? workAddressMap.get(tp.Ticket.id).id : null;
                if (billingAddressMap.keyset().contains(tp.Ticket.id))
                    tp.tktProfileObject.Billing_Address__c = (null != billingAddressMap.get(tp.Ticket.id)) ? billingAddressMap.get(tp.Ticket.id).id : null;
                if (ShippingAddressMap.keyset().contains(tp.Ticket.id))
                    tp.tktProfileObject.Home_Address__c = (null != shippingAddressMap.get(tp.Ticket.id)) ? shippingAddressMap.get(tp.Ticket.id).id : null;
                if (userPicMap.keyset().contains(tp.Ticket.id))
                    tp.tktProfileObject.User_Pic__c =  (null != userPicMap.get(tp.Ticket.id)) ? userPicMap.get(tp.Ticket.id).id : null ;
                    system.debug('1173tktuserpic'+tp.tktProfileObject.User_Pic__c);
                if (compPicMap.keyset().contains(tp.Ticket.id)) //Company Logo
                    tp.tktProfileObject.Company_logo__c=  (null != compPicMap.get(tp.Ticket.id)) ? compPicMap.get(tp.Ticket.id).id : null ;
                    system.debug('1176tktcompanylogo'+tp.tktProfileObject.Company_logo__c);
                tktlistToUpdate.add(tp.tktProfileObject);
                if (tp.tktProfileObject.id != null) {
                     System.debug('tp.tktProfileObject.id '+tp.tktProfileObject.id);
                    String tempId = tp.tktProfileObject.Id;
                    //Adding naics values to list
                    if (tp.selectedNaicsCodes != null && tp.selectedNaicsCodes != '') {
                        if (compNaics(tp.selectedNaicsCodes, tempId, '', '').size() > 0) {
                            sObjForna.addAll(compNaics(tp.selectedNaicsCodes, tempId, '', ''));
                        }
                    }
                    System.debug('Diversities   ' + tp.selecteddivers);
                    //Adding Diversities values to list
                    if (tp.selecteddivers != null && tp.selecteddivers != '') {
                        if (compDivesity(tp.selecteddivers, tempId, '', '').size() > 0) {
                            sObjForDiv.addAll(compDivesity(tp.selecteddivers, tempId, '', ''));
                        }
                    }
                    //Adding Diversities values to list
                    if (tp.selectedCommodities != null && tp.selectedCommodities != '') {
                        if (compCommodity(tp.selectedCommodities, tempId, '', '').size() > 0) {
                            sObjForcomm.addAll(compCommodity(tp.selectedCommodities, tempId, '', ''));
                        }
                    }
                    If(tp.Tag != null && tp.Tag != '') {
                        for (string tagStr : tp.Tag.split(',')) {
                            Hash_Tag__c hstag = new Hash_Tag__c();
                            hstag.Event__c = eventId;
                            hstag.Table_Name__c = 'Ticket__c';
                            hstag.RowId__c = tp.ticket.id;
                            hstag.Tag_Text__c = tagStr;
                            hashTagList.add(hstag);
                        }
                    }
                    System.debug(' tp.Ticket '+ tp.Ticket.isDeleted);
                    tp.Ticket.tkt_profile__c = tempId;
                    tp.Ticket.Order__c = orderId;
                    tp.Ticket.Order_Item__c = maoitemWithorderItem.get(tp.Ticket.item__c);
                   System.debug('New Values  '+orderId+' Order item Id '+maoitemWithorderItem.get(tp.Ticket.item__c) +'TKT Profile Id '+tempId); 
                   Database.SaveResult TiicketsUpres =  Database.update(tp.Ticket,false);
                   System.debug('TiicketsUpres  '+TiicketsUpres);
                    If(tp.surveys == true) {
                        if (tp.QuestionMap != null) {
                            try {
                                //mapEmWithUid.get(tp.tktProfileObject.Email__c).id
                                surveysListToinsert.add(new surveyQuestions(tp.UserAnswer, tp.BLNItem, tp.ticket, false, eventid));
                            } catch (exception re) {}
                        }
                    }
                    //------------------------- Inserting attachments -------------------
                    if (null != tp.myfile1 && tp.myfile1 != '' ) {
                        if (tp.myfile1.length() <= 4024000) {
                            Attachment a = new Attachment(parentId = tempId, name = tp.myfilename1, body = EncodingUtil.base64Decode(tp.myfile1));
                            attchMentsList.add(a);
                        }
                    }
                }
            }
        }

        if (tktlistToUpdate.size() > 0) {
            Database.saveresult[] uprestkt =  DataBase.update(tktlistToUpdate, false);
        }
        if (hashTagList.size() > 0) {
            Database.saveresult[] savres =  DataBase.insert(hashTagList, false);
        }
        if (attchMentsList.size() > 0) {
            Database.saveresult[] Attachmentsavres =  DataBase.insert(attchMentsList, false);
        }

        //--------------------- Assigning address and pic to tkt profiles End------------------------------------


//--------------------- Inserting addresses and companies for new users -----------------------------
        BLN_Role_DAO  roledao = new BLN_Role_DAO();
        MAP<String, id> maproleWithId = new MAP<String, id>();
        List<Company_Ext__c> companyExtList = new List<Company_Ext__c>();
        List<Gn_User__c> gnusersList = new List<Gn_User__c>();
        List<tkt_profile__c> tktPfToCompUpdata = new List<tkt_profile__c>();
        SET<String> ignoreDuplicate = new SET<String>();


        // Getting available roles for UC role Obj
        for (Role__c r : roledao.userRole()) {
            maproleWithId.put(r.Name, r.id);
        }
        System.debug('Exiting users List--------------------- ' + exitingUserList);
        System.debug('!exitingUserList.keyset().contains(buyerInfo.tktProfileObject.Email__c)---------- ' + !exitingUserList.keyset().contains(buyerInfo.tktProfileObject.Email__c));
        //----------------------- For buyer Default values saving -------------------------------------
        if (!exitingUserList.keyset().contains(buyerInfo.tktProfileObject.Email__c)) {
            System.debug('Buyer Information-------------- ' + buyerInfo.ticket);
            ignoreDuplicate.add(buyerInfo.tktProfileObject.Email__c);
            GN_User__c gnUserForUpdate = new GN_User__c();
            gnUserForUpdate = mapEmWithUid.get(buyerInfo.tktProfileObject.Email__c);
            if (null!=buyerInfo.tktProfileObject.User_Pic__c|| buyerInfo.tktProfileObject.User_Pic__c == ''){
            gnUserForUpdate.User_Pic__c = buyerInfo.tktProfileObject.User_Pic__c;
            }
            // buyerInfo.tktProfileObject.BLN_GN_User__c = gnUserForUpdate.id;
            if (buyerSet.contains('Home Address')) {
                gnUserForUpdate.Home_Address__c = InsertHomeAdd(buyerInfo.homeAddress);
            }
            boolean isPersonal = false;
            if (buyerInfo.tktProfileObject.TKT_Company__c == null || buyerInfo.tktProfileObject.TKT_Company__c == '') {
                isPersonal = true;
            }
            String companyId = InsertCompanyNew(buyerInfo.tktProfileObject);
            if (companyId != null && companyId != '') {
            try{
                //------------------ Default naics codes inserting -----------------------
                String uIdTemp = gnUserForUpdate.id;
                //Adding naics values to list
                if (buyerInfo.selectedNaicsCodes != '' && buyerInfo.selectedNaicsCodes != '') {
                    if (compNaics(buyerInfo.selectedNaicsCodes, '', companyId, uIdTemp).size() > 0) {
                        sObjForna.addAll(compNaics(buyerInfo.selectedNaicsCodes, '', companyId, uIdTemp));
                    }
                }
                //Adding Diversities values to list
                if (buyerInfo.selecteddivers != '' && buyerInfo.selecteddivers != '') {
                    if (compDivesity(buyerInfo.selecteddivers, '', companyId, uIdTemp).size() > 0) {
                        sObjForDiv.addAll(compDivesity(buyerInfo.selecteddivers, '', companyId, uIdTemp));
                    }
                }

                //Adding Diversities values to list
                if (buyerInfo.selectedCommodities != '' && buyerInfo.selectedCommodities != '') {
                    if (compCommodity(buyerInfo.selectedCommodities, '', companyId, uIdTemp).size() > 0) {
                        sObjForcomm.addAll(compCommodity(buyerInfo.selectedCommodities, '', companyId, uIdTemp));
                    }
                }
                }catch(Exception e){}
                gnUserForUpdate.Default_Company_ID__c = companyId;
                buyerInfo.tktProfileObject.BLN_Company__c =  companyId;
                System.debug('Buyer Information-------------- ' + buyerInfo.tktProfileObject);
                tktPfToCompUpdata.add(buyerInfo.tktProfileObject);
                companyExtList.add(insertCompanyExtNew(buyerInfo, companyId)); // Company ext List
                ucRoleList.add(inserUcroleNew(companyId, mapEmWithUid.get(buyerInfo.tktProfileObject.Email__c).id, isPersonal, maproleWithId.get('Company Admin')));
            }
            gnusersList.add(gnUserForUpdate);
        }

        //-------------------------- For Attendees -----------------------------------
        for (BLN_RegistrationnewCon3.TicketInnerClass proFileupdate : regInn ) {
            System.debug('Iterating Inner classt to Assign values to tc ' + proFileupdate.Ticket);
            if (!exitingUserList.keyset().contains(proFileupdate.tktProfileObject.Email__c) && !ignoreDuplicate.contains(proFileupdate.tktProfileObject.Email__c)) {
                if (proFileupdate.Ticket.Parent_ID__c != NULL && proFileupdate.Ticket.Item_Type__r.Name == 'Package' || proFileupdate.Ticket.Item_Type__r.Name != 'Package' && proFileupdate.Ticket.Parent_ID__c == null) {
                    System.debug('Attendee Information-------------- ' + proFileupdate.ticket);
                    ignoreDuplicate.add(proFileupdate.tktProfileObject.Email__c);
                    SET<String> gpNameTemp1 = new SET<String>();
                    if (null != mapItemIdWithGName.get(proFileupdate.Ticket.item__r.id)) {
                        gpNameTemp1 = mapItemIdWithGName.get(proFileupdate.Ticket.item__r.id);
                    } else if (null != mapItemIdWithGName.get(proFileupdate.Ticket.item__r.Item_Pool__r.id)) {
                        gpNameTemp1 = mapItemIdWithGName.get(proFileupdate.Ticket.item__r.Item_Pool__r.id);
                    }
                    GN_User__c gnUserup = new GN_User__c();
                    gnUserup = mapEmWithUid.get(proFileupdate.tktProfileObject.Email__c);
                    gnUserup.User_Pic__c = proFileupdate.tktProfileObject.User_Pic__c;
                     //proFileupdate.tktProfileObject.BLN_GN_User__c= gnUserup.id;
                    if (gpNameTemp1.contains('Home Address')) {
                        gnUserup.Home_Address__c = InsertHomeAdd(proFileupdate.homeAddress);
                    }
                    boolean isPersonalAtt = false;
                    if (proFileupdate.tktProfileObject.TKT_Company__c == null || proFileupdate.tktProfileObject.TKT_Company__c == '') {
                        isPersonalAtt = true;
                    }
                    // String companyIdAtt = InsertCompanyNew(proFileupdate.tktProfileObject);
                    String companyIdAtt = '';
                    if (companyMap.keyset().contains(proFileupdate.Ticket.id))
                        companyIdAtt =  (null != companyMap.get(proFileupdate.Ticket.id)) ? companyMap.get(proFileupdate.Ticket.id).id : null ;


                    if (companyIdAtt != null && companyIdAtt != '') {
                        String uIdTempAtt = gnUserup.id;
                        //Adding naics values to list
                        if (proFileupdate.selectedNaicsCodes != '' && proFileupdate.selectedNaicsCodes != '') {
                            if (compNaics(proFileupdate.selectedNaicsCodes, '', companyIdAtt, uIdTempAtt).size() > 0) {
                                sObjForna.addAll(compNaics(proFileupdate.selectedNaicsCodes, '', companyIdAtt, uIdTempAtt));
                            }
                        }
                        //Adding Diversities values to list
                        if (proFileupdate.selecteddivers != '' && proFileupdate.selecteddivers != '') {
                            if (compDivesity(proFileupdate.selecteddivers, '', companyIdAtt, uIdTempAtt).size() > 0) {
                                sObjForDiv.addAll(compDivesity(proFileupdate.selecteddivers, '', companyIdAtt, uIdTempAtt));
                            }
                        }

                        //Adding Diversities values to list
                        if (proFileupdate.selectedCommodities != '' && proFileupdate.selectedCommodities != '') {
                            if (compCommodity(proFileupdate.selectedCommodities, '', companyIdAtt, uIdTempAtt).size() > 0) {
                                sObjForcomm.addAll(compCommodity(proFileupdate.selectedCommodities, '', companyIdAtt, uIdTempAtt));
                            }
                        }
                        gnUserup.Default_Company_ID__c = companyIdAtt;
                        proFileupdate.tktProfileObject.BLN_Company__c =  companyIdAtt;
                        tktPfToCompUpdata.add(proFileupdate.tktProfileObject);
                        companyExtList.add(insertCompanyExtNew(proFileupdate, companyIdAtt)); // Company ext List
                        ucRoleList.add(inserUcroleNew(companyIdAtt, mapEmWithUid.get(proFileupdate.tktProfileObject.Email__c).id, isPersonalAtt, maproleWithId.get('Company Admin')));
                    }
                    gnusersList.add(gnUserup);
                }
            } else {
                if (mapEmWithUid.keyset().contains(proFileupdate.tktProfileObject.Email__c)) {
                    proFileupdate.tktProfileObject.BLN_GN_user__c = mapEmWithUid.get(proFileupdate.tktProfileObject.Email__c).id;
                } else {
                    proFileupdate.tktProfileObject.BLN_GN_user__c = exitingUserList.get(proFileupdate.tktProfileObject.Email__c);
                }

                tktPfToCompUpdata.add(proFileupdate.tktProfileObject);
            }
        }

        if (sObjForna.size() > 0) {
            Database.saveresult[] Naicssavres =  DataBase.insert(sObjForna, false);
            System.debug('Naics codes insertion ---------- ' + Naicssavres);
        }
        if (sObjForDiv.size() > 0) {
            Database.saveresult[] divsssavres =  DataBase.insert(sObjForDiv, false);
            System.debug('Diversities insertion ---------- ' + divsssavres);
        }
        if (sObjForcomm.size() > 0) {
            Database.saveresult[] Commssavres =  DataBase.insert(sObjForcomm, false);
            System.debug('Commodities insertion ---------- ' + Commssavres);
        }

        if (gnusersList.size() > 0) {
            Database.saveresult[] usrUpWithHaddRes = Database.update(gnusersList, false);
            System.debug(' User update with homeAddress ' + usrUpWithHaddRes);
        }
        if (companyExtList.size() > 0) {
            Database.SaveResult[] compExtresult = Database.insert(companyExtList, false);
            System.debug(' Inserting compan extention ' + compExtresult);
        }
        if (tktPfToCompUpdata.size() > 0) {
            System.debug('tktPfToCompUpdata Valuessssssssss ' + tktPfToCompUpdata);
            Database.SaveResult[]  upres = Database.update(tktPfToCompUpdata,false);
            System.debug('Tkt profile after company update ' + upres);
        }
        if (ucRoleList.size() > 0) {
            Database.saveresult[] insertUrole = database.insert(ucRoleList, false);
        }

        //======================= Inseritng survey Questions start =======================================
        if (regInn1.size() > 0) {
            if (regInn1[0].Ticket.item_type__r.Name == 'Package')
                tIdforevQuestions = poolIdLastlist[0].ticket;
            else
                tIdforevQuestions = parentIdFirstTolist[0].ticket;
        }

       List<Ticket__c> tcListTpUp = new List<Ticket__c>();
      // SET<id> tIdForMatchleads = new SET<id>();
       // This for will assign Custom barcode value to Frist ticket in loop 
       for(BLN_RegistrationnewCon3.TicketInnerClass tcupDt : regInn ) {
        /* if(tcupDt.Ticket.Item_Type__r.Name=='MatchLeads Buyer' || tcupDt.Ticket.Item_Type__r.Name=='MatchLeads Seller'){
            tIdForMatchleads.add(tcupDt.Ticket.id);
         }
        */
         System.debug(' tcupDt.customBarcode 222222 '+ tcupDt.customBarcode);
             
         if(tIdforevQuestions.id==tcupDt.ticket.id){
           if(tcupDt.customBarcode!=null && tcupDt.customBarcode!=''){  
              tcupDt.Ticket.Custom_Barcode__c = tcupDt.customBarcode;
              tcListTpUp.add(tcupDt.Ticket);    
           }else{
             tcupDt.Ticket.Custom_Barcode__c = buyerInfo.customBarcode;
             tcListTpUp.add(tcupDt.Ticket);
           }
         }else{
             tcupDt.Ticket.Custom_Barcode__c = tcupDt.customBarcode;
             System.debug(' tcupDt.customBarcode '+ tcupDt.customBarcode);
             tcListTpUp.add(tcupDt.Ticket);
         } 
       }  
       System.debug('Tickets List To Update '+tcListTpUp);
       if(tcListTpUp.size()>0){ 
          Database.saveresult[] updateTcRes = Database.update(tcListTpUp,false);
          System.debug('Save result for updating tickets '+updateTcRes);
           for(Database.saveresult dSv :updateTcRes ){
              if(!dSv.isSuccess()){
                 for(Database.Error err : dSv.getErrors()) {
                  orderStatus= 'Duplicate barcode Found!';
                  //err.getMessage();
                  System.debug('orderStatus  '+orderStatus);
                  DataBase.Rollback(dtSave);
                   return orderStatus;
                }
              }
            }
          }

        // If it is event level question we should put first ticket details to that
        if (regInn.size() > 0) {
            // inserting event level Questions
            // if(buyerInfo.UserAnswer.size()>0){
            /*String buyerId ='';
             if(mapEmWithUid.keySet().contains(buyerInfo.tktProfileObject.Email__c)){
                 buyerId = mapEmWithUid.get(buyerInfo.tktProfileObject.Email__c).id;
             }else if(exitingUserList.keySet().contains(buyerInfo.tktProfileObject.Email__c)){
                buyerId = exitingUserList.get(buyerInfo.tktProfileObject.Email__c);
             }
             if(buyerId!=null && buyerId!=''){*/
            surveysListToinsert.add(new surveyQuestions(buyerInfo.UserAnswer, new BLN_Item__c(), tIdforevQuestions, true, eventid));
            // }
            //}
        }

        // Inserting ticekt level Questions
        if (surveysListToinsert.size() > 0) {
            System.debug('Survey ' + surveysListToinsert);
            //batch class is replaced with this method
            surveyAnswersInsertion(surveysListToinsert);
            //BatchexeforSurveys barchex = new BatchexeforSurveys();
            //barchex.iterateSurveys(surveysListToinsert);
            //database.executeBatch(barchex, 99);
        }
      //Inseritng attendee summary
      insertAttSum(tktProfileToInsert);
      // Inserting Match leads Data
      //System.debug('tIdForMatchleads  Data '+tIdForMatchleads);
      //insertMlData(tIdForMatchleads);

        return orderStatus;
    }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Method End ~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Inserting Matchleads Data
public Void insertMlData(SET<id> ids){
 try{   
  BLN_Insertmldata insMldt = new BLN_Insertmldata();
  insMldt.insertMLData(ids);
  }catch(exception ex){}
}
//Inserting Attendees from Gn user
public Void insertAttSum(List<Tkt_profile__c> gnu){
    BLN_GNUser_BAL blnDao = new BLN_GNUser_BAL();
    blnDao.inserTingAtt(gnu);
}


 //=================================  Inserting payment gateway =====================================
 public Void patmentInsert(Order__c ordvalue,String PGatewayType,String PGatewayMode,String Module,Decimal AmountPaid,String ChargeType,String ChargeId,String crdno,id currencyId ){
        string paymodeTemp = '';
        String EventId =  ordvalue.Events__c;
         //Get PGateway Type
        BLN_PGateway_Type_DAO PGatewayDAO = new BLN_PGateway_Type_DAO();
        Event_Pay_Gateway__c  PGateway = new Event_Pay_Gateway__c  ();
        try {
            PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(EventId, PGatewayMode, Module);
        } catch (exception er) {}
        if (PGateway.Pay_Gateway__c == null) {
            if (PGatewayMode == 'Free') {
                BLN_Event_DAO evDao = new BLN_Event_DAO();
                BLN_Event__c  eves = new BLN_Event__c ();
                eves = evDao.getEventDetails(EventId)[0];
                PGateway_Type__c  freeGtype = new PGateway_Type__c();
                try {
                    freeGtype = [select id from PGateway_Type__c where Name = 'Free' ];
                } catch (exception e) {}
                if (null != freeGtype ) {
                    Pay_Gateway__c FreepgGate = new Pay_Gateway__c();
                    FreepgGate.Company__c = eves.organizer_id__c;
                    FreepgGate.PGateway_Type__c = freeGtype.id;
                    DataBase.SaveResult svRest = Database.insert(FreepgGate, false);
                    System.debug(' FreepgGate   res' + svRest );
                    if (svRest.Issuccess()) {
                        Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c();
                        epg.Registration_Type__c  = Module ;
                        epg.Events__c = EventId;
                        epg.Pay_Gateway__c = svRest.getId();
                        Database.SaveResult Sv = Database.insert(epg, false);
                        System.debug(' Event Pay gateway res' + Sv );
                        if (Sv.isSuccess()) {
                            System.debug('BHBHBHBBHHBHHBHBHBBHHBHBBHHBHB ' + EventId + '  ' + PGatewayMode + '  ' + Module);
                            try {
                                PGateway = BLN_EventPayGateway_DAO.getEventPayGateWay(EventId, PGatewayMode, Module);
                                System.debug(' PaymentGateway id  ' + PGateway );
                            } catch (exception er) {}
                        }
                    }
                }
            }
        }


        if (PGatewayType != 'Cash' && PGatewayType != 'Check' &&  PGatewayType != 'External Pay Gateway' ) {
            if (PGatewayType == '') {
                paymodeTemp = 'Credit Card';
            } else if (PGatewayType == 'TrustCommerce' || PGatewayType == 'CreditCardPayPalDirect' || PGatewayType == 'Authorize.Net' || PGatewayType == 'Paypal') {
                paymodeTemp = 'Credit Card';
            } else {
                paymodeTemp =  PGatewayType;
            }
        } else if (PGatewayType == 'External Pay Gateway') {
            paymodeTemp = 'External Pay Gateway';
        } else {
            paymodeTemp = PGatewayType;
        }


       //Insert Payment
        BLN_payment_DAO PaymentDAO = new BLN_payment_DAO();
        Payment__c Payment = new Payment__c( Payment_Mode__c = paymodeTemp, Registration_Type__c = module, Payment_Amount__c = AmountPaid, Order__c =ordvalue.id, Currency_Code__c =currencyId, credit_card_type__c = ChargeType, BLN_Pay_Gateway__c = PGateway.Pay_Gateway__r.Id, Payment_Ref_Number__c = ChargeId, credit_card_last_4digits__c = crdno);
        BLN_StatusMessage PaymentMessage = PaymentDAO.insertPayment(Payment);

 }





//================================= Inserting payment gateway End =====================================
    //Method to insert survey question's answers to respective tickets
      public void surveyAnswersInsertion(LIst<surveyQuestions> surveysListToinsertTemp){
        // Inserting Survey Questions 
       BLN_SurveyQuestions_BAL SQBal = new BLN_SurveyQuestions_BAL();
           MAP<id,List<Ticket__c>> MapPidWithchilds = new MAP<id,List<Ticket__c>>();
       
           for(surveyQuestions sur : surveysListToinsertTemp){

               // filling buyer info to perticular tickets
               System.debug('Anydatatype_msg '+sur.ticket.Name);
               if(sur.ticket.Parent_Id__c==null && sur.ticket.Item_Type__r.Name=='Package'){
                  //try{
                    Ticket__c tcList=new Ticket__c();
                    tcList = [select id,(SELECT id,Item__c,Item_pool__c from Tickets__r Order By Name) from Ticket__c where id=:sur.ticket.id];
                     MapPidWithchilds.put(tcList.id,tcList.Tickets__r);
                  //'' }catch(exception r){}
                 }
               
                System.debug('Survey Questions Size   '+sur.listinn);
                System.debug('Survey Questions Item   '+sur.tick);
                System.debug('Survey Questions Level   '+sur.iseventlevel);
              

                for(BLN_RegistrationnewCon3.UserAnswerInnerClass UAnswer : sur.listinn){
                  System.debug('Survey Records '+UAnswer);
                  Id ItemQuestionId;
                   id tcis ;
                   if(sur.iseventlevel){
                     // ItemQuestionId = UAnswer.itq.id;
                      // SQBal.geteventQuestion(sur.eventid,UAnswer.Question.id);
                         tcis  = sur.ticket.id;
                     }else{
                         System.debug(' Ticket '+sur.ticket+'  User Ans Item  '+UAnswer.itq.Item__c);
                         if(sur.ticket.Item_Type__r.Name=='Package'){ // It is Package
                           if(sur.ticket.Parent_Id__c==null){ // If parent ticket come
                             if(UAnswer.itq.Item__c==null ){ // Checking item question is at parent or child level
                               for(Ticket__c tv : MapPidWithchilds.get(sur.ticket.id)){ // If not parent level assign value to first ticket of perticular item type
                                 if(UAnswer.itq.item_pool__c==tv.item_pool__c){
                                  tcis  = tv.id;  
                                  System.debug('checking inserttiong '+tv.id); 
                                 }
                              } 
                      }else{
                               if(null != MapPidWithchilds.get(sur.ticket.id)){ // Assign values to first ticket of Item
                                  tcis  = MapPidWithchilds.get(sur.ticket.id)[0].id;
                                }    
                      }
                           }else{
                      tcis  = sur.ticket.id;
                   }
                   
                         }else{
                             tcis = sur.ticket.id;
                         }
                     }  
                    ItemQuestionId  = UAnswer.itq.id; 
                   if(UAnswer.Question.Answer_Type__c=='Checkboxes'){
                         for(String s: UAnswer.SelectedAnswerCheck){
                           BLN_StatusMessage UAMsg = SQBal.insertUserAnswer(s,ItemQuestionId,tcis);    
                     }    
                    }else if(UAnswer.Question.Answer_Type__c!='Checkboxes' && UAnswer.SelectedAnswer!=null && UAnswer.itq.question__r.Answer_Type__c!='Text' && UAnswer.itq.question__r.Answer_Type__c!='Paragraph text'){
                        BLN_StatusMessage UAMsg = SQBal.insertUserAnswer(UAnswer.SelectedAnswer,ItemQuestionId,tcis);
                    }else if((UAnswer.itq.question__r.Answer_Type__c=='Text' || UAnswer.itq.question__r.Answer_Type__c=='Paragraph text') && UAnswer.SelectedAnswer!=''){
                         BLN_StatusMessage UAMsg = SQBal.insertUserAnswerTxtPara(UAnswer.SelectedAnswer,ItemQuestionId,tcis);    
                    }
                }
          }
    }

    public GN_User__c AssignGnuserValues(GN_User__c gnuValues, tkt_profile__c tktPro) {
        gnuValues.First_Name__c = tktPro.First_Name__c;
        gnuValues.Last_Name__c = tktPro.Last_Name__c;
        gnuValues.Email__c = tktPro.Email__c;
        gnuValues.Prefix__c = tktPro.Prefix__c;
        gnuValues.Suffix__c = tktPro.Suffix__c;
        gnuValues.Video__c = tktPro.Video__c;
        gnuValues.Mobile__c = tktPro.Mobile__c;
        gnuValues.Home_Phone__c = tktPro.Home_Phone__c;
        gnuValues.LinkedInId__c = tktPro.LinkedInId__c;
        gnuValues.Gender__c = tktPro.Gender__c;
        gnuValues.FourSquareId__c = tktPro.FourSquareId__c;
        gnuValues.FaceBookId__c = tktPro.FaceBookId__c;
        gnuValues.DOB__c = tktPro.DOB__c;
        gnuValues.Blogger__c = tktPro.Blogger__c;
        gnuValues.Biography__c = tktPro.Biography__c;
        gnuValues.Age__c = tktPro.Age__c;
        gnuValues.TwitterId__c = tktPro.TwitterId__c;
        gnuValues.User_Pic__c = tktPro.User_Pic__c;
        gnuValues.Video__c = tktPro.Video__c;
        return gnuValues;
    }

    public Uc_role__c inserUcroleNew(String compId, String Uid, Boolean isPersonal, String roleId) {
        uc_role__c ucnew = new uc_role__c();
        ucnew.Company__c = compId;
        ucnew.GN_User__c = Uid;
        if (isPersonal) {
            ucnew.User_Type__c = 'Personal';
        } else {
            ucnew.User_Type__c = 'Business';
        }
        ucnew.RoleId__c = roleId;
        return ucnew;
    }

    public Company_Ext__c insertCompanyExtNew(BLN_RegistrationnewCon3.TicketInnerClass forCExt , String compId) {
        Company_Ext__c comext = new Company_Ext__c();
        comext.Company__c = compId;
        comext =  AssignWInfo(forCExt.tktProfileObject, comext);
        comext =  AssignWadd(forCExt.workAddress, comext);
        return comext;
    }
    public Company_Ext__c AssignWInfo(tkt_profile__c tktObj , Company_Ext__c comext) {
        comext.Blog_URL__c =  tktObj.Company_Website_URL__c;
        comext.Established_Date__c = tktObj.Established_Date__c;
        comext.Duns_Number__c = tktObj.Duns_Number__c;
        comext.Keywords__c = tktObj.Keywords__c;
        comext.Number_Of_Employees__c =  tktObj.Number_Of_Employees__c;
        comext.Primary_Business_Category__c = tktObj.Primary_Business_Category__c;
        comext.Revenue__c = tktObj.Revenue__c;
        comext.Secondary_Business_Category__c = tktObj.Secondary_Business_Category__c;
        comext.Tax_Id__c = tktObj.Tax_Id__c;
        comext.Work_Phone__c = tktObj.Work_Phone__c;
        return comext;
    }
    public Company_Ext__c AssignWadd(BLN_Address__c wAdd, Company_Ext__c comext) {
        comext.Business_Address1__c = wAdd.Address1__c;
        comext.Business_Address2__c = wAdd.Address2__c;
        comext.Business_City__c = wAdd.City__c;
        comext.BLN_Business_Country__c = wAdd.Country__c;
        comext.BLN_Business_State__c = wAdd.State__c;
        comext.Business_Zipcode__c = wAdd.Zipcode__c;
        return comext;
    }

    public String InsertCompanyNew(tkt_profile__c tPro) {
        Company__c Comptemp = new Company__c();
        Boolean isPersonal = false;
        if (tPro.TKT_Company__c != null && tPro.TKT_Company__c != '') {
            Comptemp.Name = tPro.TKT_Company__c;
        } else {
            isPersonal = true;
            Comptemp.Name = tPro.First_Name__c + tPro.Last_Name__c;
        }
        Comptemp.Description__c = tPro.Company_Description__c;
        Comptemp.Website_URL__c = tPro.Company_Website_URL__c;
        Database.SaveResult saveres = Database.insert(Comptemp, false);
        System.debug('Company Insert --------------------- ' + saveres);
        if (saveres.isSuccess())
            return saveres.getId();
        else
            return null;
    }

//----------------------------- Inserting company -----------------------------------
    public String InsertHomeAdd(BLN_Address__c hAdd) {
        hAdd.id = null;
        Database.SaveResult hddRes = Database.insert(hAdd);
        if (hddRes.isSuccess())
            return hddres.getId();
        else
            return null;
    }

//------------------------ Naics List ---------------------------------
    public List<Company_Naicscodes__c> compNaics(String nac, String tktpId, String compId, String uId) {
        LIST<Company_Naicscodes__c> cpmnaList = new List<Company_Naicscodes__c>();
        if (null != nac && '' != nac) {
            for (String naicsind : nac.split('-')) {
                Company_Naicscodes__c comnc = new Company_Naicscodes__c();
                if (tktpId != '')
                    comnc.BLN_TKT_profile__c = tktpId;
                comnc.BLN_NAICS_Code__c = naicsind;
                if (compId != '')
                    comnc.BLN_Company__c = compId;
                if (uId != '')
                    comnc.BLN_GN_User__c = uId;
                cpmnaList.add(comnc);
            }
        }
        return cpmnaList;
    }

//------------------------ Naics List ---------------------------------
    public List<Company_Diversity__c> compDivesity(String nac, String tktpId, String compId, String uId) {
        LIST<Company_Diversity__c> cpmnaList = new List<Company_Diversity__c>();
        if (null != nac && '' != nac) {
            for (String naicsind : nac.split('-')) {
                Company_Diversity__c comnc = new Company_Diversity__c();
                if (tktpId != '')
                    comnc.BLN_TKT_profile__c = tktpId;
                comnc.Diversity__c = naicsind;
                if (compId != '')
                    comnc.Company__c = compId;
                if (uId != '')
                    comnc.BLN_GN_User__c = uId;

                cpmnaList.add(comnc);
            }
        }
        return cpmnaList;
    }

//------------------------ Naics List ---------------------------------
    public List<BLN_Company_Commoditie__c> compCommodity(String nac, String tktpId, String compId, String uId) {
        LIST<BLN_Company_Commoditie__c> cpmnaList = new List<BLN_Company_Commoditie__c>();
        if (null != nac && '' != nac) {
            for (String naicsind : nac.split('-')) {
                BLN_Company_Commoditie__c comnc = new BLN_Company_Commoditie__c();
                if (tktpId != '')
                    comnc.BLN_TKT_profile__c = tktpId;
                comnc.BLN_Commodities__c = naicsind;
                if (compId != '')
                    comnc.BLN_Company__c = compId;
                if (uId != '')
                    comnc.BLN_GN_User__c = uId;

                cpmnaList.add(comnc);
            }
        }
        return cpmnaList;
    }

    public document userPicInsert(String tPic, String pName) {
        if (null != tPic && tPic != '') {
            if (tPic.length() <= 4024000) {
                document mydoc = new document();
                mydoc.body = EncodingUtil.base64Decode(tPic);
                mydoc.folderid = userInfo.getUserId();
                mydoc.ispublic = true;
                mydoc.Name = pName;
                return mydoc;
                //DataBase.saveresult svRe = Database.insert(mydoc,false);
                //System.debug('Picture ----------- '+svRe);
                /*if(svRe.isSuccess()){
                  return svre.getId();
                }else{
                return null;
                } */
            }
        }
        return null;
    }

    public document compPicInsert(String tPic, String pName) {
        if (null != tPic && tPic != '') {
            if (tPic.length() <= 4024000) {
                document mydoc = new document();
                mydoc.body = EncodingUtil.base64Decode(tPic);
                mydoc.folderid = userInfo.getUserId();
                mydoc.ispublic = true;
                mydoc.Name = pName;
                return mydoc;
                //DataBase.saveresult svRe = Database.insert(mydoc,false);
                //System.debug('Picture ----------- '+svRe);
                /*if(svRe.isSuccess()){
                  return svre.getId();
                }else{
                return null;
                } */
            }
        }
        return null;
    }
    
    public String userPicInsert1(String tPic, String pName) {
        if (null != tPic && tPic != '') {
            if (tPic.length() <= 4024000) {
                document mydoc = new document();
                mydoc.body = EncodingUtil.base64Decode(tPic);
                mydoc.folderid = userInfo.getUserId();
                mydoc.ispublic = true;
                mydoc.Name = pName;
                DataBase.saveresult svRe = Database.insert(mydoc, false);
                System.debug('Picture ----------- ' + svRe);
                if (svRe.isSuccess()) {
                    return svre.getId();
                } else {
                    return null;
                }
            }
        }
        return null;
    }

public String compPicInsert1(String tPic, String pName) {
        if (null != tPic && tPic != '') {
            if (tPic.length() <= 4024000) {
                document mydoc = new document();
                mydoc.body = EncodingUtil.base64Decode(tPic);
                mydoc.folderid = userInfo.getUserId();
                mydoc.ispublic = true;
                mydoc.Name = pName;
                DataBase.saveresult svRe = Database.insert(mydoc, false);
                System.debug('Picture ----------- ' + svRe);
                if (svRe.isSuccess()) {
                    return svre.getId();
                } else {
                    return null;
                }
            }
        }
        return null;
    }
    //-------------------------------------- Assign values to MAP -----------------------------------



    public tkt_profile__c AssignAddressProfileStuff(BLN_RegistrationnewCon3.TicketInnerClass tp, MAP<String, GN_User__c> uIds ,  Set<String> gpNameTemp) {
        // ---------------------------- inserting Address Information ---------------------
        tp.homeAddress.id = null;
        tp.workAddress.id = null;
        tp.billingAddress.id = null;
        tp.shippingAddress.id = null;
        if (gpNameTemp.contains('Home Address')) {
            Database.SaveResult hddRes = Database.insert(tp.homeAddress);
            if (hddRes.isSuccess())
                tp.tktProfileObject.Home_Address__c = hddRes.getId();
        }
        if (gpNameTemp.contains('Work Address')) {
            Database.SaveResult hddRes = Database.insert(tp.workAddress);
            if (hddRes.isSuccess())
                tp.tktProfileObject.work_Address__c = hddRes.getId();
        }
        if (gpNameTemp.contains('Billing Address')) {
            Database.SaveResult hddRes = Database.insert(tp.billingAddress);
            if (hddRes.isSuccess())
                tp.tktProfileObject.billing_Address__c = hddRes.getId();
        }
        if (gpNameTemp.contains('Shipping Address')) {
            Database.SaveResult hddRes = Database.insert(tp.shippingAddress);
            if (hddRes.isSuccess())
                tp.tktProfileObject.shipping_Address__c = hddRes.getId();
        }
        //------------------------------ Assigning user ------------------------------------------
        if (null != uIds.get(tp.tktProfileObject.Email__c)) {
            tp.tktProfileObject.BLN_GN_User__c = uIds.get(tp.tktProfileObject.Email__c).id;
        }
        tp.tktProfileObject.id = null;
        return tp.tktProfileObject;
    }



    public BLN_RegistrationnewCon3.TicketInnerClass tcValAssignment(BLN_RegistrationnewCon3.TicketInnerClass leftObj, BLN_RegistrationnewCon3.TicketInnerClass rightObj) {
        Map<String, Schema.SObjectField> M = Schema.SObjectType.tkt_profile__c.fields.getMap();
        tkt_profile__c lobj = new tkt_profile__c();
        For(string fName : M.keySet()) {
            if (fName != 'Name' && fName.contains('__c'))
                lobj.put(fName, rightObj.tktProfileObject.get(fName));
        }
        leftObj.tktProfileObject = lobj;

        //-------------------- Home address ----------------------
        Map<String, Schema.SObjectField> addFields = Schema.SObjectType.BLN_Address__c.fields.getMap();
        BLN_Address__c hAddress = new BLN_Address__c();
        For(string fName : addFields.keySet()) {
            if (fName != 'Name' && fName.contains('__c'))
                hAddress.put(fName, rightObj.homeAddress.get(fName));
        }
        leftObj.homeAddress = hAddress;
        //-------------------- Work address ----------------------
        BLN_Address__c wAddress = new BLN_Address__c();
        For(string fName : addFields.keySet()) {
            if (fName != 'Name' && fName.contains('__c'))
                wAddress.put(fName, rightObj.workAddress.get(fName));
        }
        leftObj.workAddress = wAddress;
        //-------------------- Billing address ----------------------
        BLN_Address__c bAddress = new BLN_Address__c();
        For(string fName : addFields.keySet()) {
            if (fName != 'Name' && fName.contains('__c'))
                bAddress.put(fName, rightObj.billingAddress.get(fName));
        }
        leftObj.billingAddress = bAddress;
        //-------------------- shipping address ----------------------
        BLN_Address__c sAddress = new BLN_Address__c();
        For(string fName : addFields.keySet()) {
            if (fName != 'Name'  && fName.contains('__c'))
                sAddress.put(fName, rightObj.shippingAddress.get(fName));
        }
        leftObj.shippingAddress = sAddress;

        leftObj.selectedNaicsCodes =  rightObj.selectedNaicsCodes;
        leftObj.selecteddivers =  rightObj.selecteddivers;
        leftObj.selectedCommodities =  rightObj.selectedCommodities;
        return leftObj;
    }



    /*
      public Gn_user__c insertIngupicUatt(BLN_RegistrationnewCon3.TicketInnerClass tinnupdate){
             string uid = mapEmailWithUid.get(tinnupdate.EachUser.Email__c).id;
              BLN_CompDiversity_DAO compDivDao = new BLN_CompDiversity_DAO();
              system.debug('ZZZZZZZZZZ  '+tinnupdate.Eachuser);

             // Inserting Naics codes and Diversity types
               if(tinnupdate.selectedNaicsCodes!=null && tinnupdate.selectedNaicsCodes!=''){
                for(String naic : tinnupdate.selectedNaicsCodes.split('-')){
                    Company_Naicscodes__c compNaic = new Company_Naicscodes__c();
                    compNaic.BLN_GN_User__c= uid;
                    compNaic.BLN_Company__c =  mapcompWithcid.get(tinnupdate.EachCompany.Name);
                    compNaic.BLN_NAICS_Code__c = naic;
                    compNaic.Uniqncu__c = uid+mapcompWithcid.get(tinnupdate.EachCompany.Name)+naic;
                    comNaicList.add(compNaic);
                  }
               }
              // Inserting Naics codes and Diversity types
               if(tinnupdate.selecteddivers!=null && tinnupdate.selecteddivers!=''){
                 // compDivDao.DiversityHandle(mapcompWithcid.get(tinnupdate.EachCompany.Name),uid,tinnupdate.selecteddivers);
              for(String ncs : tinnupdate.selectedNaicsCodes.split('-')){
                    Company_Diversity__c nind = new Company_Diversity__c();
                    nind.BLN_GN_User__c = uId;
                    nind.Company__c = mapcompWithcid.get(tinnupdate.EachCompany.Name);
                   system.debug('dddddddddddddddddddddddddd'+ncs);
                    nind.Diversity__c = ncs;
                    nind.Uniqncu__c= uId+''+mapcompWithcid.get(tinnupdate.EachCompany.Name)+''+ncs;
                    comDivList.add(nind);
              }

              }

              system.debug('uuuuuuuuuuuuuuuuuu'+uid);
               if (null != tinnupdate.SpeakerPic1 && tinnupdate.SpeakerPic1!='') {
                 if (tinnupdate.SpeakerPic1.length() <= 4024000) {
                     document mydoc = new document();
                     mydoc.body = EncodingUtil.base64Decode(tinnupdate.SpeakerPic1);
                     mydoc.folderid = userInfo.getUserId();
                      mydoc.ispublic = true;
                      mydoc.Name = tinnupdate.SpeakerImageName1;
                     insert mydoc;
                     system.debug('dddddddddddd'+mydoc.id);
                     tinnupdate.EachUser.Id=uid;
                     tinnupdate.EachUser.User_Pic__c = mydoc.id;
                    System.debug('WWWWWWWW '+tinnupdate.EachUser);
                    }
                 }

                 if (null != tinnupdate.myfile1 && tinnupdate.myfile1!='' ) {
                   if (tinnupdate.myfile1.length() <= 4024000) {
                       Attachment a = new Attachment(parentId = uid, name=tinnupdate.myfilename1, body = EncodingUtil.base64Decode(tinnupdate.myfile1));
                        DataBase.insert(a,false);
                    }
                }
             tinnupdate.myfile1 =null;
             tinnupdate.SpeakerPic1 =null;
             return tinnupdate.EachUser;
       }
    */



    // For inserting Survey Questions
    public class surveyQuestions {
        public string userid {get; set;}
        public Ticket__C ticket {get; set;}
        public BLN_Item__c tick {get; set;}
        public boolean iseventlevel {get; set;}
        public string eventid {get; set;}
        public List<BLN_RegistrationnewCon3.UserAnswerInnerClass> listinn {get; set;}
        //string userid,
        public surveyQuestions(List<BLN_RegistrationnewCon3.UserAnswerInnerClass> inn, BLN_Item__c tc, Ticket__c ticketinn, boolean elevel, string eventid) {
            // this.userid = userid;
            this.listinn = inn;
            this.ticket  = ticketinn;
            this.tick = tc;
            this.iseventlevel  = elevel;
            this.eventid = eventid;
        }

    }





    //Insert orders and tickets for registrationpage By Phani On 22/12/2014
    public MAP<string, Gn_user__c> insertingusers(List<Gn_user__c> userslist) {
        SET<string> duplicateremove = new SET<string>();
        List<contact> insertingCon = new List<contact>();
        MAP<string, Gn_user__c> existingusers = new MAP<string, Gn_user__c>();
        List<user> sfuserList = new List<user>();
        MAP<string, Gn_user__c> emails = new MAP<string, Gn_user__c>();
        List<Gn_user__c> gnusersList = new List<Gn_user__c>();
        List<Profile> profileList = new  List<Profile>();
        profileList = [SELECT Id, Name FROM Profile WHERE Name = 'Attendee'];
        profile p = new profile();
        if (profileList.size() > 0) {
            P = profileList[0];
        }
        for (Gn_user__c users : userslist) {
            emails.put(users.Email__c, users);
        }

        List<Gn_User__c> forUpdateExisting = new list<Gn_user__c>();
        // Getting users who are existed
        for (Gn_user__c  em : blnusersdao.existingGnusers(emails.keyset()) ) {
            existingusers.put(em.Email__c, em);

        }


        //If user is existed in Users and not existed in Gn user
        // for that i am inserting gn user
        List<id> successids  = new List<id>();
        
        for (user exusers : usrdao.checkUsersWExists(emails.keySet())) {
            if(!existingusers.keySEt().contains(exusers.userName)){
              successIds.add(exusers.id);
            }
        }
       
       

        // Inserting Contacts for inserting user
        for (Gn_user__c usersid : userslist) {
            if ((!existingusers.keyset().contains(usersid.Email__c)) && (!duplicateremove.contains(usersid.Email__c))) {
                contact Con = new Contact();
                Con.Lastname = usersid.Last_name__c ;
                Con.Firstname = usersid.First_name__c ;
                con.email = usersid.email__c;
                insertingCon.add(con);
                duplicateremove.add(usersid.email__c);
                // contactId = blnuserDao.account_Contact(con);
            }
        }
        BLN_StatusMessage blnmsg ;
        //Mapping contactEmail with conid
        If(insertingCon.size() > 0) {
            List<contact> contactslistnew = new List<Contact>();
            contactslistnew = usrdao.conList(usrdao.account_Contact(insertingCon));
            for (contact conids : contactslistnew ) {
                user sfuser = new user();
                sfuser.ContactID = conids.id;
                sfuser.Username = conids.email;
                sfuser.Email = conids.email;
                sfuser.LastName = conids.LastName;
                sfuser.FirstName = conids.FirstName;
                sfuser.Alias = 'EAdmin';
                sfuser.ProfileID = P.id;
                sfuser.Eff_Date__c = system.today();
                sfuser.LocaleSidKey = 'en_US';
                sfuser.LanguageLocaleKey = 'en_US';
                sfuser.TimeZoneSidKey = 'GMT';
                sfuser.EmailEncodingKey = 'UTF-8';
                sfuser.CommunityNickname = String.valueOf(math.random());
                sfuserList.add(sfuser);
            }
            // Inserting users
            if (sfuserList.size() > 0) {
                blnmsg = usrdao.insertUserBulk(sfuserList);
            }
        }
        system.debug('Inserted Userssssss ' + blnmsg );
        //  system.debug('Inserted Userssssss '+blnmsg.successIds);
        
        if (blnmsg != null) {
            // Iterating for inserting gn user
            successIds.addAll(blnmsg.successIds);
           
            for (user uy : usrdao.getusers(successIds)) {
                Gn_user__c gn =  emails.get(uy.username);
                system.debug('uy.id'+uy.id);
                gn.User__c = uy.id;

                gnusersList.add(gn);
            }
            
            if (gnusersList.size() > 0) {
                blnusersdao.InsertGNUser(gnusersList);
            }

        }
        MAP<String, GN_User__c> mapEmailWithUid = new MAP<String, Gn_User__c>();
        for (Gn_user__c gnu : blnusersdao.existingGnusers(emails.keyset())) {
            mapEmailWithUid.put(gnu.Email__c, gnu);
        }
        return  mapEmailWithUid;
    }
    /*
      // Inserting companies for guests if he picks company from existing we are not passing here
      public static BLN_Company_DAO compdao = new BLN_Company_DAO();
      public static BLN_UCRole_DAO ucroledao = new BLN_UCRole_DAO();

       public Void insertingCompanies(SET<string> companies){
         // MAP<string,Company__c> mapcompWithcid12 = new MAP<string,Company__c>();
          compdao = new BLN_Company_DAO();
         //mapCompidWithcomp
          SET<Company__c> colist = new SET<Company__c>();
           for(string cname :companies){
              Company__c Co = new Company__c();
               try{
                Company__c Comptemp = new Company__c();
                 if(null!= mapCompidWithcomp.get(cname)){
                   Comptemp  = mapCompidWithcomp.get(cname);
                   co.Description__c = Comptemp.Description__c;
                   co.Website_URL__c = Comptemp.Website_URL__c;

                 }

               }catch(exception ed){}

              co.Name = cname;
              colist.add(co);
           }
           BLN_StatusMessage blnmsg = compdao.insertCompanyBulk(colist);
            for(company__c co : compdao.companiesForEvent(blnmsg.successIds)){
                mapcompWithcid.put(co.Name,co.id);
            }
         // return mapcompWithcid;
       }


      //  Getting personal companies
       public void  getpersonalCompanies(List<GN_user__c> gnusp){
          SET<string> strEmails = new SET<string>();
            for(GN_user__c gn : gnusp){
                strEmails.add(gn.Email__c);
            }

         MAP<string,string> existedEmails = new MAP<string,string>();
         for(UC_Role__c rt :[select id,GN_User__r.Email__c,company__c from UC_Role__c where GN_User__r.Email__c in :strEmails and User_Type__c='Personal'] ){
            existedEmails.put(rt.GN_User__r.Email__c,rt.company__c);
            system.debug('QQQQQQQQQQQQ '+existedEmails);
         }

          SET<company__c> compList = new SET<company__c>();
          MAP<string,Gn_user__c> mapEmailWithGnusers = new MAP<string,Gn_user__c>();

           for(GN_user__c gn : gnusp){

             IF(!existedEmails.keySet().contains(gn.Email__c)){
                 Company__c comp = new Company__c();
                 comp.Name = gn.Email__c;
                 //gn.First_Name__c+gn.Last_Name__c+gn.Email__c;
                 System.debug('Namesssssssssssss     '+mapEmailWithUid.get(gn.Email__c));
                 mapEmailWithGnusers.put((gn.Email__c).trim(),mapEmailWithUid.get(gn.Email__c));
                 compList.add(comp);
             }
           }


          compdao = new BLN_Company_DAO();
          List<Uc_role__c> uList = new List<Uc_role__c>();
          BLN_StatusMessage blnmsg = compdao.insertCompanyBulk(compList);
          System.debug('WWWWWWWWWWWWW     '+mapEmailWithGnusers+' Companies Success   '+blnmsg);

           for(company__c co : compdao.companiesForEvent(blnmsg.successIds)){
              Uc_role__c ucnew = new uc_role__c();
              ucnew.Company__c = co.id;
              System.debug('Comany Name '+co.id+ co.Name);
              ucnew.GN_User__c = mapEmailWithGnusers.get(co.Name).id;
              ucnew.User_Type__c = 'Personal';
              ucnew.RoleId__c= maproleWithId.get('Company Admin');
              uList.add(ucnew);
           }

          BLN_StatusMessage blucroledao = ucroledao.saveUserCompanyRole(uList);
         MAP<string,string> emailwithcomp = new MAP<string,string>();
            for(UC_role__c ucr : [select id,GN_User__r.Email__c,company__c from UC_Role__c where GN_User__r.Email__c in :strEmails and User_Type__c='Personal']){
                mapemailsWithcId.put(ucr.GN_User__r.Email__c,ucr.Company__c);
            }
       }
    */

}