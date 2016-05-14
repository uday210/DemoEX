public without sharing class BLN_Item_DAO {


  //Getting Items for an Event
  public List<BLN_Item__c> getEventItems(String eventId) {
    List<BLN_Item__c> items = [select id, lastmodifieddate, item_name__c, item_pool__r.Addon_Parent__c, Item_Type__r.name, Item_Pool__c, Item_Pool__r.Name, Item_Pool__r.Item_Pool_Name__c, Item_Pool__r.Package_Flag__c, Item_Pool__r.id, Item_Pool__r.Item_Count__c, Item_Pool__r.Item_Type__r.Id, Item_Pool__r.Item_Type__r.Name, Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c, Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c, sale_start__c, sale_end__c, Early_Bird_Pricing_Display_Flag__c, Visibility__c,
                               Taxable__c, service_fee__c , item_count__c , image_url__c, item_type__c, Payment__c, Description__c, Event__c, price__c, Item_Type__r.BL_Fee_Amt_per_res__c, Item_Type__r.BL_Fee_Pct_per_res__c, Available_Tickets__c, Currency_Code__c, Ticket_Settings__c, (Select Id, item__c, Question__c, Question__r.Event__c, IQ_Order__c, Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c, Question_Level__c,item__r.id, Item_Pool__r.Id FROM Item_Question__r Order By question__r.question_order__c asc), (select id, Name, Item_Type__c, Ticket_Settings__c from Items__r)  FROM BLN_Item__c where Event__c = :eventId and Item_Pool__r.Item_Count__c > 0 order by Ordering__c, sale_start__c];
    if (items.size() > 0) {
      return items;
    } else {
      return new LIST<BLN_Item__c>();
    }
  }

//Getting Items for an Event
  public List<BLN_Item__c> getEventItems(String eventId,set<id> iqIds) {
    List<BLN_Item__c> items = [select id, lastmodifieddate, item_name__c, item_pool__r.Addon_Parent__c, Item_Type__r.name, Item_Pool__c, Item_Pool__r.Name, Item_Pool__r.Item_Pool_Name__c, Item_Pool__r.Package_Flag__c, Item_Pool__r.id, Item_Pool__r.Item_Count__c, Item_Pool__r.Item_Type__r.Id, Item_Pool__r.Item_Type__r.Name, Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c, Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c, sale_start__c, sale_end__c, Early_Bird_Pricing_Display_Flag__c, Visibility__c,
                               Taxable__c, service_fee__c , item_count__c , image_url__c, item_type__c, Payment__c, Description__c, Event__c, price__c, Item_Type__r.BL_Fee_Amt_per_res__c, Item_Type__r.BL_Fee_Pct_per_res__c, Available_Tickets__c, Currency_Code__c, Ticket_Settings__c, (Select Id, item__c, Question__c, Question__r.Event__c, IQ_Order__c, Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c, Question_Level__c,item__r.id, Item_Pool__r.Id FROM Item_Question__r where id in :iqIds Order By question__r.question_order__c asc), (select id, Name, Item_Type__c, Ticket_Settings__c from Items__r)  FROM BLN_Item__c where Event__c = :eventId and Item_Pool__r.Item_Count__c > 0 order by Ordering__c, sale_start__c];
    if (items.size() > 0) {
      return items;
    } else {
      return new LIST<BLN_Item__c>();
    }
  }

//Getting Items for an Event
  public List<BLN_Item__c> getEventItemsForMobile(String eventId) {
    List<BLN_Item__c> items = [select (SELECT id,Column_Name__c,Defaullt_Label__c,Included__c,Label_Name__c,Required__c from Reg_Settings__r where (Column_Name__c='Work Address' AND Included__c=true) OR (Column_Name__c='Home Address' AND Included__c=true) OR (Column_Name__c='Work_Phone__c' AND Included__c=true) OR (Column_Name__c='Home_Phone__c' AND Included__c=true)),id, lastmodifieddate, item_name__c, item_pool__r.Addon_Parent__c, Item_Type__r.name, Item_Pool__c, Item_Pool__r.Name, Item_Pool__r.Item_Pool_Name__c, Item_Pool__r.Package_Flag__c, Item_Pool__r.id, Item_Pool__r.Item_Count__c, Item_Pool__r.Item_Type__r.Id, Item_Pool__r.Item_Type__r.Name, Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c, Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c, sale_start__c, sale_end__c, Early_Bird_Pricing_Display_Flag__c, Visibility__c,
                               Taxable__c, service_fee__c , item_count__c , image_url__c, item_type__c, Payment__c, Description__c, Event__c, price__c, Item_Type__r.BL_Fee_Amt_per_res__c, Item_Type__r.BL_Fee_Pct_per_res__c, Available_Tickets__c, Currency_Code__c, Ticket_Settings__c, (Select Id, item__c, Question__c, Question__r.Event__c, IQ_Order__c, Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c, Question_Level__c, Item_Pool__r.Id FROM Item_Question__r Order By question__r.question_order__c asc), (select id, Name, Item_Type__c, Ticket_Settings__c from Items__r)  FROM BLN_Item__c where Event__c = :eventId and Item_Pool__r.Item_Count__c > 0 order by Ordering__c, sale_start__c];
    if (items.size() > 0) {
      return items;
    } else {
      return new LIST<BLN_Item__c>();
    }
  }



  //Getting Items pools for an selected Event
  public List<Item_Pool__c> getEventItemPools(String eventId) {
    List<Item_Pool__c> itemPools = [select id, Addon_Count__c, Addon_Parent__c, Badgable__c, Badge_Label__c, Event__c, Item_Count__c, Item_Pool_Name__c, Item_Type__c,
                                    Ordering__c, Package_Flag__c, Row_End__c, Row_Start__c, Ticket_Settings__c, Track__c, uniqueNumber__c, Unit_End__c,
                                    Addon_Parent__r.Item_type__r.name, Unit_Start__c, Zone_End__c, Zone_Start__c, Item_Type__r.name, Addon_Parent__r.Item_Pool_Name__c, //Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.id,Item_Pool__r.Item_Count__c,Item_Pool__r.Item_Type__r.Id,Item_Pool__r.Item_Type__r.Name,
                                    (Select Id, item__c, Question__c, Question__r.Event__c, IQ_Order__c, Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c, Question_Level__c FROM Item_Question__r), (select id, Item_Pool_Name__c, Item_Type__c, Addon_Parent__c, Ordering__c, Item_Type__r.Add_On__c from Item_Pools__r), Item_Type__r.Add_On__c  FROM Item_Pool__c where Event__c = :eventId and Item_Count__c > 0  order by Ordering__c];
    if (itemPools.size() > 0) {
      return itemPools;
    } else {
      return new LIST<Item_Pool__c>();
    }
  }

  //Getting particular Item Data based in Item Id
  public List<BLN_Item__c> itemDetailsForSurvey(String itemId) {
    List<BLN_Item__c> items = [select id, item_name__c, Item_Type__r.name, Item_Pool__c, Item_Pool__r.Name, Item_Pool__r.Item_Pool_Name__c, Item_Pool__r.Package_Flag__c, Item_Pool__r.id, Item_Pool__r.Item_Count__c, Item_Pool__r.Item_Type__r.Id, Item_Pool__r.Item_Type__r.Name, Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c, Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c, sale_start__c, sale_end__c, Early_Bird_Pricing_Display_Flag__c, Visibility__c,
                               (Select Id, item__c, Question__c, Question__r.Event__c, IQ_Order__c, Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c, Question_Level__c FROM Item_Question__r), (select id, tkt_profile__c, tkt_profile__r.First_Name__c, tkt_profile__r.Last_Name__c, tkt_profile__r.Email__c,  tkt_profile__r.TKT_Job_Title__c, tkt_profile__r.Mobile__c from Item__r WHERE Ticket_Status__c != : 'Available')  FROM BLN_Item__c where Id = : itemId];
    if (items.size() > 0) {
      return items;
    } else {
      return new LIST<BLN_Item__c>();
    }
  }



  //Insert Items................................
  public LIST<Database.Upsertresult> upsertItems(LIST<BLN_Item__c> items) {

    LIST<Database.Upsertresult> itemsResult = Database.upsert(items, false);

    return itemsResult;
  }



  //update Items................................
  public void  updateItems(LIST<BLN_Item__c> items) {

    LIST<Database.saveResult> itemsResult = Database.update(items, false);

  }

  //Getting Items belongs to an Event Written by Manasa Gandham
  public List<BLN_Item__c> itemsListForEvent(String EventId, Date FromDate, Date ToDate) {

    List<BLN_Item__c> items = new LIST<BLN_Item__c>();
    //string queryString= 'select id,item_name__c,Item_Type__r.name,Item_Pool__c,Item_Pool__r.Name,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.Item_Count__c,Item_Pool__r.Item_Type__r.Id,Item_Pool__r.Item_Type__r.Name,Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c,Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c,sale_start__c,sale_end__c,Early_Bird_Pricing_Display_Flag__c,Visibility__c, service_fee__c ,item_count__c ,image_url__c,item_type__c,Payment__c,Description__c,Event__c,price__c,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,Available_Tickets__c,Currency_Code__c,Ticket_Settings__c,(Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id  FROM Item_Question__r),(select id,Name,Item_Type__c,Ticket_Settings__c from Items__r)  FROM BLN_Item__c'+ QueryStr;
    items = [select id, item_name__c, Item_Type__r.name, Item_Pool__c, Item_Pool__r.Name, Item_Pool__r.Item_Pool_Name__c,
             Item_Pool__r.Package_Flag__c, Item_Pool__r.Item_Count__c, Item_Pool__r.Item_Type__r.Id, Item_Pool__r.Item_Type__r.Name,
             Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c, Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c,
             min_per_order__c, sale_start__c, sale_end__c, Early_Bird_Pricing_Display_Flag__c, Visibility__c, service_fee__c ,
             item_count__c , image_url__c, item_type__c, Payment__c, Description__c, Event__c, price__c, Item_Type__r.BL_Fee_Amt_per_res__c,
             Item_Type__r.BL_Fee_Pct_per_res__c, Available_Tickets__c, Currency_Code__c, Ticket_Settings__c,
             (Select Id, item__c, Question__c, Question__r.Event__c, IQ_Order__c, Question__r.Id  FROM Item_Question__r),
             (select id, Name, Item_Type__c, Ticket_Settings__c from Items__r)
             FROM BLN_Item__c
             WHERE Event__c = : EventId
                              AND CreatedDate >= : FromDate
                              AND CreatedDate <= : ToDate];

    system.debug(items.size() + '   QUERY STRING ' + items);
    //items= dataBase.query(queryString);
    return items;
  }

  //Written by thirupathi on 06/05/2015
  public List<Item_Pool__c> getEventItemPools1(String EventId, Datetime FromDate, Datetime ToDate) {
    List<Item_Pool__c> itemPools = new List<Item_Pool__c>();
    itemPools = [select id, Addon_Count__c, Addon_Parent__c, Badgable__c, Badge_Label__c, Event__c, Item_Count__c, Item_Pool_Name__c, Item_Type__c,
                 Ordering__c, Package_Flag__c, Row_End__c, Row_Start__c, Ticket_Settings__c, Track__c, uniqueNumber__c, Unit_End__c,
                 Addon_Parent__r.Item_type__r.name, Unit_Start__c, Zone_End__c, Zone_Start__c, Item_Type__r.name, Addon_Parent__r.Item_Pool_Name__c, //Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.id,Item_Pool__r.Item_Count__c,Item_Pool__r.Item_Type__r.Id,Item_Pool__r.Item_Type__r.Name,
                 (Select Id, item__c, Question__c, Question__r.Event__c, IQ_Order__c, Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c, Question_Level__c FROM Item_Question__r), (select id, Item_Pool_Name__c, Item_Type__c, Addon_Parent__c, Ordering__c, Item_Type__r.Add_On__c from Item_Pools__r), Item_Type__r.Add_On__c  FROM Item_Pool__c WHERE Event__c = : EventId
                     AND CreatedDate >= : FromDate
                     AND CreatedDate <= : ToDate AND Addon_Parent__c != null AND Badgable__c != 'No Badge' ];
    return itemPools;
  }

  // Edit by Rajesh on 22/12/2014
  //Get Item Details based on ItemId
  public BLN_Item__c GetItemDetails(String WhereCondition) {

    BLN_Item__c itemDetails = new BLN_Item__c();
    string queryString = 'select id,item_name__c,Item_Type__r.name,Item_Pool__c,Item_Pool__r.Name,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.Item_Count__c,Item_Pool__r.Item_Type__r.Id,Item_Pool__r.Item_Type__r.Name,Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c,Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c,sale_start__c,sale_end__c,Early_Bird_Pricing_Display_Flag__c,Visibility__c, service_fee__c ,item_count__c ,image_url__c,item_type__c,Payment__c,Description__c,Event__c,price__c,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,Available_Tickets__c,Currency_Code__c,Ticket_Settings__c,(Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id  FROM Item_Question__r),(select id,Name,Item_Type__c,Ticket_Settings__c from Items__r)  FROM BLN_Item__c' + WhereCondition;
    system.debug('   QUERY STRING ' + queryString);
    itemDetails = dataBase.query(queryString);
    return itemDetails;

  }

  public List<BLN_Item__c> ItemDetails(SET<string> itemids) {
    return  [select id, item_name__c, Item_Type__r.Name, Name, Item_Pool__c, Item_Pool__r.Name, Item_Pool__r.Item_Pool_Name__c, Item_Pool__r.Package_Flag__c, Item_Pool__r.Item_Count__c, Item_Pool__r.Item_Type__r.Id, Item_Pool__r.Item_Type__r.Name, Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c, Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c, sale_start__c, sale_end__c, Early_Bird_Pricing_Display_Flag__c, Visibility__c, service_fee__c , item_count__c , image_url__c, item_type__c, Payment__c, Description__c, Event__c, price__c, Item_Type__r.BL_Fee_Amt_per_res__c, Item_Type__r.BL_Fee_Pct_per_res__c, Available_Tickets__c, Currency_Code__c, Ticket_Settings__c from  BLN_Item__c where id in :itemids];
  }

}