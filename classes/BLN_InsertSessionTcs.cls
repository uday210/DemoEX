public with sharing class BLN_InsertSessionTcs {
    /*   Service Name : BLN_ASC_ScannedTickets
    *   Date            : 03/03/2016
    *   Author          : Phani Kumar Ch
    *   Purpose         : This class is for Inserting session tickets
    *   Reused class    :
    ************************************************************************************************/
    public void checkUserBuyInfo(String eveId, String obcId, String itemPoolId) {
        BLN_Event_DAO evdao = new BLN_Event_DAO();
        LIST<BLN_Event__c> eventdetails = evdao.getEventDetails(eveId);
        System.debug(' eveId ' + eveId+' obcId  '+obcId +' itemPoolId '+itemPoolId);
        if (eventdetails.size() > 0) {
            if (eventdetails[0].AllowNoticketSessions__c) {
                //Checking Weather user buy ticket or Not
                Savepoint sp = Database.setSavepoint();
                try {
                    BLN_Item__c blnItem = new BLN_Item__c();
                    blnItem = getItem(itemPoolId);
                    Item_Pool__c itemPool = new Item_Pool__c();
                    itemPool =getItempool(itemPoolId);

                    System.debug(' Item Details ' + blnItem);
                    if (blnItem.item_type__r.Name == 'Seminars' && (blnItem.Payment__c == 'Free' || blnItem.price__c == 0)) { // Only seminar and free tickets We are adding to Order
                        List<Ticket__c> tcs = [SELECT id, Item__r.Item_type__r.Name,Order__r.Id, Order__c,tkt_profile__r.Email__c from Ticket__c Where Event__c = :eveId AND (Custom_Barcode__c = :obcId OR Badge_ID__c = :obcId)];
                        System.debug(' Tickets ' + tcs);
                        String ordId = '';
                        String userName =''; 
                        for (Ticket__c tkts : tcs) {
                            if (null != tkts.Order__c){
                                ordId = tkts.Order__c;
                               //if(tkts.Item__r.Item_type__r.Name == 'Admissions')
                                userName = tkts.tkt_profile__r.Email__c;
                            }
                        }
                       SET<String> removeDup = new SET<String>();
                        List<Ticket__c> ticketsToInsert = new List<Ticket__c>();
                        List<Order_Item__c> orderItems = new List<Order_Item__c>();
                        SET<String> tktProfiles = new SET<String>();
                        SET<String> userNamesAll = new SET<String>();
                        // Getting Order to create tickets
                        Order__c ord = [SELECT Id, (SELECT id, Item__r.Item_type__r.Name, Item__r.Item_type__c,  Badge_Label__c, tkt_profile__c, Event__c, Item__c, Item_Pool__c, Item_Type__c, Note__c, Order__c, Order_Item__c, Parent_ID__c, Praentidworkflowfill__c, RSVP__c, Tag_No__c, Ticket_Display_Order__c, Ticket_Status__c, tkt_profile__r.Email__c FROM Tickets__r WHERE tkt_profile__r.Email__c=:userName and Item_Pool__r.Badgable__c='B - Badge') FROM Order__c WHERE Id = :ordId];
                        for (Ticket__c tt : ord.Tickets__r) {
                            userNamesAll.add(tt.tkt_profile__r.Email__c);
                        }

                       Integer seminarTccnt =0; 
                        for (Ticket__c tp : [select Item__r.Item_type__c, id, tkt_profile__r.Email__c FROM Ticket__c Where tkt_profile__r.Email__c IN :userNamesAll AND Item__r.Item_Pool__c = :itemPoolId and Order__r.id = :ordId]) {
                            //removeDup.add(tp.tkt_profile__r.Email__c);
                            seminarTccnt++;
                        }

                        BLN_Currency_DAO CurDAO = new BLN_Currency_DAO();
                        Currency__c cur = CurDAO.getCurrencyDetails('id,name', 'name=\'USD\' LIMIT 1');
                        for (Ticket__c tcTemp : ord.Tickets__r) {
                            System.debug('  Ticket Detail 22222222 ' + removeDup);
                            System.debug(' Ticket Details ' + tcTemp.tkt_profile__r.Email__c + '    ' + tcTemp.Item__r.Item_type__r.Name);
                            if (seminarTccnt< ord.Tickets__r.size()) {
                                System.debug('  000000000000000000 ' + tcTemp.tkt_profile__r.Email__c);
                                Ticket__c newTic = new Ticket__c();
                                tktProfiles.add(tcTemp.tkt_profile__c);
                                newTic = tcTemp.clone(false, true, false, false);
                                newTic.Item_type__c = blnItem.Item_type__c;
                                newTic.Item__c = blnItem.id;
                                newTic.Item_Pool__c = itemPoolId;
                                newTic.Order__c = ord.id;
                                ticketsToInsert.add(newTic);
                                removeDup.add(tcTemp.tkt_profile__r.Email__c);
                                // Inserting Order Items
                                Order_Item__c ordIt = new Order_Item__c();
                                ordIt.Item__c = blnItem.id;
                                ordIt.Item_Quantity__c = 1;
                                ordIt.Order__c = ord.id;
                                ordIt.Currency__c = cur.id;
                                ordIt.Item_Total__c = 0;
                                ordIt.Item_Discount__c   = 0;
                                orderItems.add(ordIt);
                                seminarTccnt++;
                            }
                        }
                        //Inserting Order Items
                        DataBase.saveResult[] savRes = Database.Insert(orderItems, false);
                        System.debug(' Order Items Result ' + savRes);
                        Integer cnt = 0;
                        for (DataBase.saveResult sav : savRes) {
                            if (sav.isSuccess()) {
                                ticketsToInsert[cnt].Order_Item__c = sav.getId();
                                cnt++;
                            }
                        }
                        List<Tkt_profile__c> tktListToInsert = new List<Tkt_profile__c>();
                        //Getting and Inserting Tkt profiles
                        for (Tkt_profile__c  tktPro : [SELECT id, Age__c, Billing_Address__c, Biography__c, BLN_GN_User__c, Blogger__c, Blog_URL__c, Company_Description__c, Company_Logo__c, Company_Website_URL__c, DOB__c, Duns_Number__c, Email__c, Established_Date__c, Exceptional_Keywords__c, FaceBookId__c, First_Name__c, FourSquareId__c, Gender__c, Home_Address__c, Home_Phone__c, Keywords__c, Last_Name__c, LinkedInId__c, Mobile__c, Number_Of_Employees__c, Prefix__c, Primary_Business_Category__c, Revenue__c, Secondary_Business_Category__c, Shipping_Address__c, Suffix__c, Tax_Id__c, TKT_Company__c, TKT_Job_Title__c, TwitterId__c, User_Pic__c, Video__c, Work_Address__c, Work_Phone__c FROM Tkt_profile__c Where Id IN :tktProfiles]) {
                            Tkt_profile__c tktTemp = new Tkt_profile__c();
                            tktTemp = tktPro.clone(false, true, false, false);
                            tktListToInsert.add(tktTemp);
                        }
                        Database.SaveResult[] saveItemPl =  Database.Insert(tktListToInsert, false);
                        System.debug(' Tkt Profiles Result ' + saveItemPl);
                        Integer itcnt = 0;
                        for (Database.SaveResult sv : saveItemPl) {
                            if (sv.isSuccess())
                                ticketsToInsert[itcnt].tkt_profile__c = sv.getId();
                            itcnt++;
                        }
                        DataBase.SaveResult[] ticketsSave = Database.Insert(ticketsToInsert, false);
                        System.debug(' Tickets Result ' + ticketsSave);
                       List<id> tcids = new List<id>();
                        for (DataBase.SaveResult tsv : ticketsSave) {
                            if (tsv.isSuccess()){
                                blnItem.item_count__c += 1;
                                itemPool.item_count__c += 1;
                                tcids.add(tsv.getId());
                            }
                        }
                        DataBase.saveResult upRes = Database.update(blnItem, false);
                        DataBase.saveResult upResPool = Database.update(itemPool, false);
                         List<Ticket__c> ticsList = new  List<Ticket__c>();
                         ticsList = [SELECT ID,NAME,Ticket_Status__c,Event__c,Uniq__c,Scan_Id__c from Ticket__c Where Id IN :tcids];
                        // -------------------------------Inserting Scan ids--------------------------------------------
                        BLN_generateScanId createScanId = new BLN_generateScanId();
                        createScanId.isScanedTc = true;
                        createScanId.insertScanId(ticsList); // Tickets will be updated in this list and also this will give scan id
                    }
                } catch (exception ed) {

                    Database.rollback( sp );
                }
                //}
            }
        }
    }

    public Item_Pool__c getItempool(String itempoolId) {
        return [SELECT Id,item_count__c from Item_Pool__c where id = :itemPoolId];
    }

    public BLN_Item__c getItem(String itempoolId) {
        return [SELECT item_type__r.Name, Id, Item_type__c, item_count__c, Payment__c, Price__c, Available_Tickets__c from BLN_Item__c where Item_Pool__c = :itemPoolId and price__c = 0];
    }
}