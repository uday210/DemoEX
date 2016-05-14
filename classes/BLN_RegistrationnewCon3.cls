/*Author-Arindam
Date:10/03/2016
Purporse:This is the new rgistration controller for dnamic html*/
global  without sharing class BLN_RegistrationnewCon3 {

    

    public PageReference go() {
         PageReference pg=new PageReference('/apex/BLN_FinalPage');
      pg.setRedirect(false);
      
       return pg;
    }

  /***************************************************************************************************************************************************************************************************
  *   Author                  : Mahesh Sakunala
  *   Date                    : 02/06/2014
  *   Purpose                 : This class is for Registration i.e. User buys tickets through payment gateway, User can also apply promo codes and fill surveys based on the event organizer settings.
  *   Last Modified           : Mahesh Sakunala - 10/09/2014
  *   Last modified           : Phani 27/10/2014 - Reason : He has to check discount value in Promotion table, Actually he has to check on item promotion table
  *   Last Modified           : Phani 22/12/2014 - reconstructine entire page
  *****************************************************************************************************************************************************************************************************/
//------------------------------------------------------------------------ Variables Declaration Start ---------------------------------------------------------------------------------
  public String itqnty {get; set;}
  public String itoldqnty {get; set;}
  public String itpoolid {get; set;}
  public String itlabel {get; set;}
  public string selectedcompany {get ; set ;}
  public String checkNAICSforEdit {get; set;}
  public Integer EventDaysRemaining {get; set;} // To Calculate Event Days Remaining
  public dateTime EventDaysRemainingDT {get; set;} // To Calculate Event Days Remaining
  public boolean isDt {get; set;}
  public BLN_Event__c registrationEvent {get; set;} // To fetch event details
  public Registration_Template__c registrationTemplate {get; set;} // To fetch template details
  public LIST<TicketInnerClass> TicketList {get; set;} // To display forms after selection of items
  public LIST<BLN_Item__c> EventItems {get; set;} // To fetch list of items
  public LIST<ItemInnerClass> ItemList {get; set;} // To display list of items
  public LIST<ItemInnerClass> CalcItemList {get; set;}
  public List<RegItemInnerClass> RegItemList {get; set;} // To display list of items
  public List<RegItemInnerClass> CalcList {get; set;}
  public Company_Ext__c  comextnew {get; set;}
  public LIST<Company_Ext__c> comext {get ; set ;}
  public Company__c compdetails {get ; set ;}
  public boolean isTest = false;
  public MAP<String, LIST<ItemInnerClass>> RegistrationItemList {get; set;} // To display list of items based on Tab Settings
  public Boolean ShowSecondPage {get; set;} // To Show & Hide forms
  public Boolean HideLogin {get; set;} // To Show & Hide Login
  public String Promocode {get; set;} //To input promo code
  public Decimal TotalAmount {get; set;} // To calculate total amount
  public Decimal TotalAmountWithTaxes {get; set;} // To calculate total amount with taxes
  public Decimal TaxAmount {get; set;} // To calculate tax amount
  public Decimal FeeAmount {get; set;} // To calculate boothleads fee amount
  public Decimal DiscountAmount {get; set;} // To calculate discount amount i.e. Promo Discount
  public Decimal DiscountedAmount {get; set;} // To calculate differnce i.e. Sub total
  public String EmailAddress {get; set;} // Boothleads User Email
  public String Password {get; set;} // Boothleads User Password
  public Company_Ext__c companydetails {get; set;} // Company_ext Details
  public Company__c comp {get; set;} // Company Details
  public GN_User__c IndUser {get; set;} // Each Individual User
  public User LoggedInUser {get; set;} // Logged In Boothleads User
  public GN_User__c LoggedInGNUser {get; set;} // Logged In Boothleads User
  public MAP<Id, Id> PromotionIdMap {get; set;} // To Map Promotion & Item
  public Integer PromotionCount {get; set;} // To Map Promotion & Item
  public String PaymentAddress1 {get; set;} // For Payment Address
  public BLN_UtillDisplayLinks RegistrationLinks {get; set;} // Initialzing Utility class to display menu and side bar in the portal
  public MAP<id, LIST<Reg_Setting__c>> RegSettingsMap {get; set;} // To store registration settings for tickets
  public MAP<id, LIST<Question__c>> QuestionsMap {get; set;} // To store survey questions for each ticket selected
  public MAP<id, LIST<Item_Question__c>> QuestionsItemMap {get; set;}
  public MAP<id, Question__c> mapQueIdQithQue {get; set;}
  public LIST<Item_Question__c> EventQuestions {get; set;} // To fetch all event questions
  public LIST<UserAnswerInnerClass> UserEventAnswer {get; set;} // Inner Class Instance for Event Survey Questions & Answers
  public SET<Id> ItemsSet {get; set;}
  public LIST<Ticket__c> RegTickets {get; set;}
  public LIST<Reg_Setting__c> DisplaySettings {get; set;}
  public boolean showtickettab {get; set;}
  public Integer SessionTime {get; set;}
  public Company_Ext__c CheckAddress {get; set;}
  public String PackageInfo {get; set;}
  public string selectedCountry {get; set;}
  public String selectedState {get; set;}
  public LIST<Country__c> country {get; set;}
  public LIST<State__c> states {get; set;}
  public LIST<SelectOption> countryOptions {get; set;}
  public LIST<SelectOption> stateOptions {get; set;}
 //public String selectedevent{get;set;}
 public List<BLN_ASC_Utillcls.TicketInfo> speakerList {get; set;}         //public String selectedevent{get;set;}
    public List<BLN_ASC_Utillcls.TicketInfo> sponsorList {get; set;}

  public String naics1 {get ; set ;}
  public String naics2 {get ; set ;}
  public LIST<NAICS_Code__c> naicscodeslist {get ; set ;}
  public LIST<LIST<NAICS_Code__c>> listOfnaicscodes {get; set;}
  public LIST<SelectOption> NaicsList { get ; set ;}//To collect all naics codes from naics object
  public LIST<LIST<SelectOption>> NaicsListOfList { get ; set ;}//To collect all naics codes from naics object

// Payment Related Fields
  public LIST<SelectOption> PaymentGateways {get; set;} // To show payment gateways
  public String SelectedPaymentGateway {get; set;} // To store selected payment gateway
  public String CreditCardNumber {get; set;}
  public String SelectedCardType {get; set;}
  public String SelectedMonth {get; set;}
  public String SelectedYear {get; set;}
  public String CheckNumber {get; set;}
  public String CVVNumber {get; set;}
  public String ChargeId {get; set;}
  public LIST<SelectOption> CreditCardType {get; set;}
  public LIST<SelectOption> MonthsList {get; set;}
  public LIST<SelectOption> YearsList {get; set;}
  public Boolean ShowPaymentError {get; set;} // Represents boolean to show payment errors
  public String PaymentErrorString {get; set;} // To Store the error in the payment
  public Boolean HideLayout {get; set;} // Represents boolean to switch between registration pages
  public String StripeSecret {get; set;} // To store Stripe Secret
  public String StripeRefreshToken {get; set;} // To store Stripe Refresh Token
  public String ANLoginId {get; set;} // To store Authorize .Net Login Id
  public String ANTransactionKey {get; set;} // To store Authorize .Net Transaction Key
  public String PayGatewayMode {get; set;} // To store pay gateway mode

//PayPal Parameters
  public string ApiUserName {get; set;}
  public string Apipassword {get; set;}
  public string Apisignature {get; set;}
  public string ApiapplicationId {get; set;}
  public string Apiipaddress {get; set;}
  public string paypalUrl {get; set;}
  public String ActionType {get; set;}
  public String PaymentType {get; set;}
  public String FeesPayer {get; set;}
  public String PayeeEmail {get; set;}
  public String BoothLeadsEmail {get; set;}
  public Boolean FundingTypeEcheck {get; set;}
  public Boolean FundingTypeBalance {get; set;}
  public Boolean FundingTypeCreditCard {get; set;}
  public Boolean IsDisplay {get; set;}
  public String APICredentialObjName {get; set;}
  public PPPayResponse PayResponse {get; set;}
  public PPResponseEnvelope RespEnvp {get; set;}
  public string SuccessMessage {get; set;}
  public String CommonParametersObjName {get; set;}
  public string SenderEmail {get; set;}
  public string EventType {get; set;}
  public boolean displayButton {get; set;}
  public boolean istestmethod {get; set;}
  public string Mainmessage {get; set;}
  public Decimal eventadminChangedAmount {get; set;}
  public string CommnetsByEventadmin {get; set;}
  public MAP<id, Event_Price__c> mapItemWithPrice {get; set;}
  public MAP<id, Event_Price__c> mapItemWithPriceforpkg {get; set;}
  public ID EventId;
  public Integer  timerValue {get; set;}

  public List<Diversity__c> diversityList {get; set;}
  public Static List<BLN_Commodities__c> CommoditiesOuter = BLN_CompCommodity_DAO.getCommodities();
  public string gnbuyercomp {get; set;}
  public string errorvalidateion {get; set;}
  public String orderidForSc {get; set;}
  public Integer SessionAbn = 0; // This is time to fire scheduler to check paid or not.
  public boolean isPaypaladvaptive = false;
  BLN_Quick_Registration_BAL3 Quickbal = new BLN_Quick_Registration_BAL3();
  
  public BLN_Reg_Main_Template__c template {get;set;}
  public string selectedevent {get;set;}
  public BLN_Event__c ee{get;set;}

  public list<BLN_Template__c> widgets{get;set;}
//public Attachment at{get;set;}
  public String templatescript{get;set;}
  string eventIdasParameter='';
  String   urlCheck =  '';

//------------------------------------------------------------------------ Variables Declaration End -------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------- Constructor Start -----------------------------------------------------------------------------------
  public BLN_RegistrationnewCon3() {
  speakerList = new List<BLN_ASC_Utillcls.TicketInfo>();        
    sponsorList = new List<BLN_ASC_Utillcls.TicketInfo>();
    isOrderCreated = false;
    timerValue = 0;
    orderidForSc = '';
    try {
        urlCheck =  ApexPages.currentPage().getUrl();
      if((urlCheck.toLowerCase()).contains('BLN_Success'.toLowerCase())){
                    
                string eveidBeforedecode= apexpages.currentpage().getparameters().get('id');
                if(eveidBeforedecode!=null && eveidBeforedecode!=''){
                eventIdasParameter= EncodingUtil.base64Decode(eveidBeforedecode).toString();
            }
            }
            else{
                    eventIdasParameter = apexpages.currentpage().getparameters().get('id');
                }
                
        selectedevent = eventIdasParameter;
                
                if (eventIdasParameter != null && eventIdasParameter != '') {

                    onloadmethod(eventIdasParameter);
                }
    } catch (exception es) {

    }
//fetchNAICSCodes();
    listOfnaicscodes =  BLN_NaicsCodes_Dao.getNaicscodes();
    diversityList = new List<Diversity__c>();
    diversityList = BLN_Diversity_DAO.getDiversities();
    pageurl = ApexPages.currentPage().getUrl();
    pageurl = pageurl.split('apex/')[1];
    
    //uday code
       try{
    template = new BLN_Reg_Main_Template__c ();
template =[select id,name,Data__c,Theme_Name__c from BLN_Reg_Main_Template__c where BLN_Events__c=:selectedevent AND InUse__c=true AND structure_type__c='Welcome Page'];
widgets = new list<BLN_Template__c>();
ee=[SELECT Registration_Template__r.id,BLN_Country__r.Currency__r.Name, BLN_Country__r.Currency__r.Currency_Symbol__c, BLN_Country__r.Short_Name__c, organizer_id__c, owner.Name, owner.userName, Event_Ticket_Options__c, is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c, Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c, State__c, Start_Date__c, End_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, Registration_Template__c, Description__c, Country__c, City__c, CreatedBy.Name, BLN_State__c, BLN_State__r.Long_Name__c, BLN_State__r.Short_Name__c, BLN_State__r.Country__c, BLN_State__r.Country__r.Long_Name__c, BLN_State__r.Country__r.Short_Name__c, Show_Terms_Checkbox__c, Tax_Rate__c, Accept_Tax_Rate__c, Terms_Conditions__c, Accept_Terms_Conditions__c, Accept_Refund_Policy__c, Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c, Event_Blog_URL__c, (SELECT Registration_Type__c, Pay_Gateway__r.use_host_page__c, Pay_Gateway__r.PGateway_Type__r.Name, Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c, Pay_Gateway__r.PG_Email_Id__c, Pay_Gateway__r.PG_Pass_Secret__c, Pay_Gateway__r.PG_Signature__c, Pay_Gateway__r.PG_User_Key__c FROM Event_Pay_Gateway__r), organizer_id__r.owner.id FROM BLN_Event__c WHERE id = :selectedevent];
widgets=[select id,HTML__c,Template_Name__c from BLN_Template__c where BLN_Reg_Main_Template__c=:template.id];
}catch(Exception e){

//System.debug('}}}}}} '+e);
}
  }
  public String pageurl {get; set;}
  public Decimal maxBlfee {get; set;}
  public String visib {get; set;}
    public GN_User__c GNUSRSDETAILS {get ; set ;}
  public void onloadmethod(string eventIdasParameter) {
    HideLogin = FALSE;
    boolean isMinQanmore = false;
GNUSRSDETAILS = new GN_User__c();
    ShowSecondPage = FALSE;
    TicketList = new LIST<TicketInnerClass>();
    ItemList = new List<ItemInnerClass>();
    CalcItemList = new List<ItemInnerClass>();
    RegItemList = new List<RegItemInnerClass>();
    CalcList = new List<RegItemInnerClass>();
    comextnew  = new Company_Ext__c  ();
    comext = new LIST<Company_Ext__c>();
    compdetails = new Company__c ();
    RegistrationItemList = new MAP<String, LIST<ItemInnerClass>>();
    EventItems = new LIST<BLN_Item__c>();
    comp = new Company__c();
    companydetails = new Company_Ext__c();
    PromotionIdMap = new MAP<Id, Id>();
    RegTickets = new LIST<Ticket__c>();
    CheckAddress = new Company_Ext__c();
    IndUser = new GN_User__c();
    TotalAmount = 0.00;
    DiscountAmount = 0.00;
    DiscountedAmount = 0.00;
    TaxAmount = 0.00;
    TotalAmountWithTaxes = 0.00;
    PromotionCount = 0;
    FeeAmount = 0.00;
    actualAmount = 0.00;
    istestmethod = true;
    maxBlfee = 10.00;
    HideLayout = TRUE;
    // Fetching EventId from the page URL i.e. from regular registration
    EventId = eventIdasParameter;
    // Fetching EventId from the cookie value i.e. from backdoor registration
    try {
      Cookie k = ApexPages.currentPage().getCookies().get('counter');

      if (k != null && EventId == NULL) {
        EventId = k.getValue();
        HideLayout = FALSE;
      }
    } catch (exception rt) {


    }
    // Initializing Quick Registration BAL to perform business logic
    BLN_Quick_Registration_BAL3 QuickRegBAL = new BLN_Quick_Registration_BAL3();
    string adminssionid = '';
    if (EventId != NULL) {
      // Getting Event Details from Event DAO
      registrationEvent = QuickRegBAL.getEventDetails(EventId);
      // Getting List of items selected from Item DAO
       BLN_Gnuser_DAO GNDAO = new BLN_Gnuser_DAO();
        GNUSRSDETAILS = GNDAO.existingGnuser(registrationEvent.Organizer_Email__c);
      mapItemWithPrice = new MAP<id, Event_Price__c>();
      List<Event_Price__c> listOfeventprices = [SELECT Max_bl_fee__c, Event_Price__c.Item_type__r.Name, id, Active_Flag__c, BL_Fee_Amount__c, BL_Fee_Level__c, BL_Fee_Percentage__c, Item_Count__c, Item_type__c, Event__c from Event_Price__c where Event__c = :EventId ];
      if (listOfeventprices.size() > 0) {
        for (Event_Price__c ep : listOfeventprices) {
        //  //System.debug('Bl Feeeeeeeeeee  ' + ep.Max_bl_fee__c);
          if (ep.Max_bl_fee__c != NULL && ep.Max_bl_fee__c > 0 ) {
            maxBlfee = ep.Max_bl_fee__c;
            break;
          }
        }
      }
      for (Event_Price__c evp : listOfeventprices  ) {
        if (evp.Item_type__r.Name == 'Admissions') {
          adminssionid = evp.Item_type__c;
        }
        mapItemWithPrice.put(evp.Item_type__c, evp);
      }
      for (Event_Price__c evp1 : listOfeventprices  ) {
        if (evp1.Item_type__r.Name == 'Lead Retrieval' || evp1.Item_type__r.Name == 'MatchLeads Buyer' || evp1.Item_type__r.Name == 'MatchLeads Seller') {
          mapItemWithPrice.put(evp1.Item_type__c, mapItemWithPrice.get(adminssionid));
        }
      }
      EventItems = QuickRegBAL.getEventItems(EventId);
      EventDaysRemaining =   date.today().daysBetween(date.valueof(registrationEvent.End_Date__c));
      eventdateTodatetimeformat evedate = new eventdateTodatetimeformat();
      EventDaysRemainingDT = registrationEvent.End_Date__c;
    }

    // Getting Registration Template from Registration Template DAO
    if (registrationEvent.Registration_Template__c != NULL) {
      registrationTemplate = QuickRegBAL.getRegTempDetails(registrationEvent.Registration_Template__c);
    } else {
      List<Registration_Template__c> regtemp = [SELECT id From Registration_Template__c Where Owner.profile.Name = : 'System Administrator'];
      registrationTemplate = QuickRegBAL.getRegTempDetails(regtemp[0].id);
    }
    ////System.debug(' EVENT ITEMS ' + EventItems);
    if (EventItems.size() > 0) {
      //Fetching Display Settings
      DisplaySettings = new LIST<Reg_Setting__c>();
      BLN_DisplaySettings_BAL DisplaySettingsBAL = new BLN_DisplaySettings_BAL();
      //System.debug('   EVENT ID ' + RegistrationEvent.id);
      DisplaySettings = DisplaySettingsBAL.getregsettingslist(RegistrationEvent.id);
     // //System.debug(' DISPLAY SETTINGS ' + DisplaySettings);
      for (Reg_Setting__c rs : DisplaySettings) {
        if (rs.Column_Name__c == 'Time Out' && rs.Included__c == TRUE && rs.Order__c != NULL) {
          SessionTime = Integer.ValueOf(rs.Order__c);
        }
        if (rs.Column_Name__c == 'Tickets' && rs.Included__c == TRUE ) {
          showtickettab = true;
        }
      }
      // Caluculating fee for package
      mapItemWithPriceforpkg    = new MAP<id, Event_Price__c>();
      for (Item_Pool__c itp : [select id, (select id, Addon_Count__c, Item_Pool_Name__c, Item_Type__r.Name, Item_Type__c, Item_Type__r.Add_On__c from Item_Pools__r), Item_Type__c from Item_Pool__c  where Addon_Parent__c = null and Item_Type__r.Name = 'Package' and Event__c = :EventId ]) {
        decimal dfee = 0.0;
        decimal dper = 0.0;

        for (Item_Pool__c itpline : itp.Item_Pools__r ) {
          IF(!itpline.Item_Type__r.Add_On__c ) {
            dper = dper +  (itpline.Addon_Count__c) * mapItemWithPrice.get(itpline.Item_Type__c).BL_Fee_Percentage__c ;
            dfee = dfee + (itpline.Addon_Count__c) * mapItemWithPrice.get(itpline.Item_Type__c).BL_Fee_Amount__c;
          }
        }
    //    //System.debug('111111111111111 ' + adminssionid );
        if (dper <= 0 && dfee <= 0) {
          dper  = mapItemWithPrice.get(adminssionid ).BL_Fee_Percentage__c ;
          dfee  = mapItemWithPrice.get(adminssionid ).BL_Fee_Amount__c;
        }
        Event_Price__c eveprice = new Event_Price__c();
        eveprice.BL_Fee_Percentage__c = dper ;
        eveprice.BL_Fee_Amount__c = dfee;
        mapItemWithPriceforpkg.put(itp.id , eveprice);
        Item_type__c itemType = new Item_type__c();
        try {
          itemType = [select id from Item_type__c where Name = 'Package' limit 1];
          mapItemWithPrice.put(itemType.id, eveprice);
        } catch (exception er) {}
      }
      visib = Apexpages.currentPage().getParameters().get('Visib');
      if (visib == null)
        visib = 'Public';
      //Fetching all Registration tabs enabled in display settings
      MAP<Id, Reg_Setting__c> TagSettingMap = new MAP<Id, Reg_Setting__c>([SELECT ID, Item__c,Defaullt_Label__c, Table_Name__c, Column_Name__c, Order__c, Included__c,Required__c FROM Reg_Setting__c WHERE Event__c = :RegistrationEvent.id AND Setting_Type__c = :'Registration Tab' AND Included__c =true ORDER BY Order__c]);
     // //System.debug('Tag setting Map ' + TagSettingMap);
      List<BLN_Item__c> evItems = new List<BLN_Item__c>();
      String isTab = '';
      try {
        isTab = Apexpages.currentPage().getParameters().get('Tab');
       // //System.debug('=======> '+isTab);
      } catch (exception er) {}
      if (null != isTab && '' != isTab) {
        SET<id> itemIds = new SET<id>();
        for (Id forTcids : TagSettingMap.keySet()) {
       // //System.debug('>>>>>>> '+TagSettingMap.get(forTcids).Table_Name__c);
          if (null != TagSettingMap.get(forTcids).Table_Name__c) {
            if (isTab.toLowerCase() == TagSettingMap.get(forTcids).Table_Name__c.tolowercase())
              itemIds.add(TagSettingMap.get(forTcids).Item__c);
          }
        }
        for (BLN_Item__c itm : EventItems ) {
          if (itemIds.contains(itm.id))
            evItems.add(itm);
        }

      } else {
        evItems.addAll(EventItems);
      }
      // Looping through Event Items to filter them and limit maximum and minimum selection
      for (BLN_Item__c ite : evItems) {
        if ((visib.contains(ite.Visibility__c) && ite.item_count__c >= 1)) {
          LIST<Selectoption> itemWiseCount = new LIST<Selectoption>();
          integer minSelection = 0;
          integer maxSelection = 0;
          if (ite.max_per_order__c != null && ite.max_per_order__c != 0) {
            if ( ite.Available_Tickets__c >  ite.max_per_order__c) {
              maxSelection = Integer.valueOf( ite.max_per_order__c);
            } else {
              maxSelection = Integer.valueOf( ite.Available_Tickets__c);
            }
          } else {
            maxSelection = Integer.valueOf( ite.Available_Tickets__c);
          }
          if (ite.min_per_order__c != null && ite.min_per_order__c != 0 && ite.sale_start__c <= System.now() ) {
            if ( ite.Available_Tickets__c >  ite.min_per_order__c) {
              minSelection = Integer.valueOf( ite.min_per_order__c);
            } else {
              minSelection = Integer.valueOf(ite.Available_Tickets__c);
            }
          } else {
            minSelection = 0;
          }
          for (integer i = minSelection; i <= maxSelection ; i++ ) {
            itemWiseCount.add(new Selectoption(string.valueOf(i), string.valueOf(i) ));
          }
          //Calculating Package Fee
          Decimal FeeAmount = 0.0;
          if (ite.Item_Pool__r.Item_Type__r.Name == 'Package') {
            //Fetching AddOnParent ItemPools
            LIST<String> IPStrings = new LIST<String>();
            IPStrings.add(ite.Item_Pool__r.Id);
            BLN_ItemPool_DAO ItemPoolDAO = new BLN_ItemPool_DAO();
            LIST<Item_Pool__c> IPList = ItemPoolDAO.getPackageItemPools(IPStrings);
            PackageInfo = '';
            for (Item_Pool__c IP : IPList) {
              if (IP.Item_Type__r.BL_Fee_Amt_per_res__c != NULL) {
                //System.debug('Fee Amount For Item Type:' + IP.Addon_Count__c * IP.Item_Type__r.BL_Fee_Amt_per_res__c);
                FeeAmount += IP.Addon_Count__c * IP.Item_Type__r.BL_Fee_Amt_per_res__c;
              }
              PackageInfo += IP.Addon_Count__c + ' ' + IP.Item_Pool_Name__c + ',';
              //System.debug('Each Package Detail' + PackageInfo );
            }
            //System.debug('Total Package Detail' + PackageInfo );
            try {
              PackageInfo = PackageInfo.substring(0, PackageInfo.length() - 1);
            } catch (Exception e) {}

          }
          //System.debug('Package Fee: ' + FeeAmount);
          if (minSelection != null && minSelection > 0) {

          } else {
            minSelection = 0;
          }
          ItemList.add(new ItemInnerClass(ite, itemWiseCount, String.valueOf(minSelection), FeeAmount, PackageInfo));
        }

      }
      //Fetching Event Tags & Registration Tabs
      BLN_Hash_Tag_BAL TagBAL = new BLN_Hash_Tag_BAL();
      LIST<Hash_Tag__c> TagList = TagBAL.getEventTags(registrationEvent.Id);
      //If registration tabs are availble to this event,
      if (TagSettingMap.values().size() > 0) {
        LIST<ItemInnerClass> otherList = new LIST<ItemInnerClass>();
        Integer remainingFlag = 0;
        //Dividing Items into different registration tabs
        Map<BLN_Item__c, ItemInnerClass> blnitem = new Map<BLN_Item__c, ItemInnerClass>();
        for (ItemInnerClass iic : ItemList) {
          for (Reg_Setting__c rs : TagSettingMap.values()) {
            LIST<ItemInnerClass> ItemInnerList = new LIST<ItemInnerClass>();

            // Checking if the item is having any event tags at all. Enters the loop if it have any.
            if (rs.item__c == iic.items.id) {
              if (RegistrationItemList.containsKey(rs.Table_Name__c)) {

                ItemInnerList =  RegistrationItemList.get(rs.Table_Name__c);
                ItemInnerList.add(iic);
                RegistrationItemList.put(rs.Table_Name__c, ItemInnerList);
                for (RegItemInnerClass ric : RegItemList) {
                  if (ric.TabLabel == rs.Table_Name__c) {
                    ric.ItemsList = ItemInnerList;
                    }
                }
              } else {
                ItemInnerList.add(iic);
                RegistrationItemList.put(rs.Table_Name__c, ItemInnerList);
                RegItemList.add(new RegItemInnerClass(rs.Table_Name__c, rs.Order__c,rs.Required__c, ItemInnerList));
              }
            } else {
              blnitem.put(iic.items, iic);
            }
          }//end if reg tab loop
        }
        integer otherflag = 0;
        for (ItemInnerClass iic : blnitem.values()) {
          remainingFlag = 0;
          for (List<ItemInnerClass> iiclist : RegistrationItemList.values()) {
            for (ItemInnerClass innicc : iiclist) {
              if (innicc == iic)
                remainingFlag = 1;
            }
          }
          if (remainingFlag == 0) {
            otherList.add(iic);
            otherflag = 1;
          }
        }
        if (otherflag == 1) {
          RegItemList.add(new RegItemInnerClass('Other', RegistrationItemList.size() + 1,true, otherList));
        }
      }
      // If there are no registration tabs available for the event
      else {
        RegItemList.add(new RegItemInnerClass('All', 0,true, ItemList));
      }
      //Sort RegItemInnerclass by Order column
      RegItemInnerClass temp;
      for (integer i = 1; i < RegItemList.size(); i++) {
        for (integer j = 0; j < i; j++) {
          if (RegItemList[j].TabOrder > RegItemList[i].TabOrder) {
            temp = RegItemList[j];
            RegItemList[j] = RegItemList[i];
            RegItemList[i] = temp;
          }

        }
      }
      //Fetching Default State and Country
      countryStates();
      statesBasedOnCountry();
      //Getting List of payment gateways available for an event
      PaymentGateways = new LIST<SelectOption>();
      LIST<Event_Pay_Gateway__c> EventPayGateWays = new LIST<Event_Pay_Gateway__c>();
      for (Event_Pay_Gateway__c egp  :  QuickRegBAL.getEventPayGateWays(EventId)) {
        if (egp.Registration_Type__c == 'Online') {
          if (egp.Pay_Gateway__r.PGateway_Type__r.Name != 'Free') {
            EventPayGateWays.add(egp  );
          }
        }
      }
      if (EventPayGateWays.size() > 0) {
        for (Event_Pay_Gateway__c epg : EventPayGateWays) {
          //System.debug('Payment Gateway type: ' + epg.Pay_Gateway__r.PGateway_Type__r.Name);
          if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Stripe' || epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Authorize.Net') {
            PaymentGateways.add(new SelectOption('Credit Card', 'Credit Card'));
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Check') {
            PaymentGateways.add(new SelectOption(epg.Pay_Gateway__r.PGateway_Type__r.Name, epg.Pay_Gateway__r.PGateway_Type__r.Name));
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'PayPal' && epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct') {
            //System.debug('PPPPPPPPPPPPPPPPPPPPP  ' + epg.Pay_Gateway__r.PGateway_Type__r.Name + 'WWWWWWWWW ' + epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct');
            PaymentGateways.add(new SelectOption('CreditCardPayPalDirect', 'Credit Card'));
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'TrustCommerce' && epg.Pay_Gateway__r.Use_Host_Page__c == false) {
            //System.debug('PPPPPPPPPPPPPPPPPPPPP  ' + epg.Pay_Gateway__r.PGateway_Type__r.Name + 'WWWWWWWWW ' + epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct');
            PaymentGateways.add(new SelectOption('CreditCardTrustCommerceDirect', 'Credit Card'));
          } else {
            //System.debug('PPPPPPPPPPPPPPPPPPPPP  3333 ' + epg.Pay_Gateway__r.PGateway_Type__r.Name + 'WWWWWWWWW 333 ' + epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct');
            PaymentGateways.add(new SelectOption(epg.Pay_Gateway__r.PGateway_Type__r.Name, epg.Pay_Gateway__r.PGateway_Type__r.Name));
          }
          List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
          boothleadspaygate = [SELECT id, Company__c, Min_amount_to_accept__c, PGateway_Type__c, PGateway_Type__r.Name, PG_Email_Id__c, PG_Pass_Secret__c, PG_Signature__c, PG_User_Key__c, PP_Fee_Payer__c, PP_Payment_Type__c, Service_Fee__c from Pay_Gateway__c where Company__r.Name = 'EventdexLive'];
          if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'PayPal') {
            if (epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Adaptive') {
              PaymentType = epg.Pay_Gateway__r.PP_Payment_Type__c;
              feesPayer = epg.Pay_Gateway__r.PP_Fee_Payer__c;
              PayeeEmail = epg.Pay_Gateway__r.PG_Email_Id__c;
              if (boothleadspaygate.size() > 0) {
                for (Pay_Gateway__c pgat : boothleadspaygate) {
                  if (pgat.PGateway_Type__r.Name == 'PayPal') {
                    BoothLeadsEmail = pgat.PG_Email_Id__c;
                  }
                }
              }
              //System.debug('AAAAAAAA BoothLeadsEmail ' + BoothLeadsEmail );
              PayGatewayMode = 'PayPal';
            } else if (epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct') {
              BoothLeadsEmail = epg.Pay_Gateway__r.PG_User_Key__c;
              ANLoginId = epg.Pay_Gateway__r.PG_Pass_Secret__c;
              ANTransactionKey = epg.Pay_Gateway__r.PG_Signature__c;
              PayGatewayMode = 'PayPal';
            }
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Stripe') {
            if (epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct')
              StripeRefreshToken = epg.Pay_Gateway__r.PG_Pass_Secret__c;
            else
              StripeRefreshToken = epg.Pay_Gateway__r.PG_User_Key__c;
            if (boothleadspaygate.size() > 0) {
              //StripeSecret = epg.Pay_Gateway__r.PGateway_Type__r.BoothLeads_Stripe_Secret__c;
              StripeSecret = boothleadspaygate[0].PG_Pass_Secret__c;
            }
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Authorize.Net') {
            ANLoginId = epg.Pay_Gateway__r.PG_User_Key__c;
            ANTransactionKey = epg.Pay_Gateway__r.PG_Signature__c;
            // PayGatewayMode = 'Authorize.Net';
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'TrustCommerce') {
            ANLoginId = epg.Pay_Gateway__r.PG_User_Key__c;
            ANTransactionKey = epg.Pay_Gateway__r.PG_Signature__c;
            // PayGatewayMode = 'TrustCommerce';
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Check') {
            // PayGatewayMode = 'Check';
          }
        }
      }
      //Fetching CheckAddress
      BLN_UCRole_DAO UCRDAO = new BLN_UCRole_DAO();
      BLN_Company_DAO ComDAO = new BLN_Company_DAO();
      if (registrationEvent.organizer_id__c != NULL) {
        Company__c CheckCompany = ComDAO.queryCompany(registrationEvent.organizer_id__c);
        for (Company_Ext__c ce : CheckCompany.Company_Ext__r) {
          CheckAddress = ce;
        }
      }
      //Getting Stripe Related Information
      MonthsList = new LIST<SelectOption>();
      YearsList = new LIST<SelectOption>();
      CreditCardType = new LIST<SelectOption>();
      LIST<String> monthstring = new LIST<String> {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'};
      LIST<String> yearstring = new LIST<String> {'2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030'};
      LIST<String> cardtypestring = new LIST<String> {'Visa', 'MasterCard', 'American Express', 'Discover'};
      SelectedYear = String.valueOf(system.today().year());
      YearsList.add(new SelectOption(SelectedYear, SelectedYear));
      String y = SelectedYear;
      for (integer l = 0; l <= 15; l++) {
        y = String.valueof(integer.valueOf(y) + 1);
        YearsList.add(new SelectOption(y, y));
      }
      for (String m : monthstring) {
        MonthsList.add(new SelectOption(m, m));
      }
      for (String c : cardtypestring) {
        CreditCardType.add(new SelectOption(c, c));
      }
    }
    //System.debug('Onload checkerrrrrrrrrrrrrrrrrrrrrr ' + isMinQanmore );
    // fee calculate default selected ticket values
    for (RegItemInnerClass rInn : RegItemList) {
      for (ItemInnerClass itc : ItemList) {
        itqnty = '0'; itlabel = ''; itpoolid = null;
        if (Integer.valueOf(itc.selectedItemQuantity) > 0 ) {
          itqnty = itc.selectedItemQuantity;
          itlabel = rInn.TabLabel;
          itoldqnty = '0';
          itpoolid = itc.items.Id;
          applypromocode();
        }
      }
    }
      List<BLN_Item__c> paiditemlist=[select id,name,Event__c,Visibility__c,price__c,Payment__c from BLN_Item__c where Event__c=: EventId and Payment__c!='Free' limit 1];
          List<Event_Pay_Gateway__c> epgonlinelist=[select id,name,Registration_Type__c,Events__c from Event_Pay_Gateway__c where Registration_Type__c='Online' and Events__c=:EventId limit 1];
          if(paiditemlist.size()!=0&&epgonlinelist.size()==0)
          onlinepayment=true;
  }
   public boolean onlinepayment{get;set;}
//------------------------------------------------------------------------------------ Constructor End ----------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------- Reg Item Inner Class Start --------------------------------------------------------------------------------
  public class RegItemInnerClass {
    public String TabLabel {get; set;}
    public Decimal TabOrder {get; set;}
    public LIST<ItemInnerClass> ItemsList {get; set;}
    public boolean displayTabName{get;set;}
    public RegItemInnerClass(String TabLabel1, Decimal TabOrder1, LIST<ItemInnerClass> ItemsList1) {
      TabLabel = TabLabel1;
      TabOrder = TabOrder1;
      ItemsList = ItemsList1;
    }
    public RegItemInnerClass(String TabLabel1, Decimal TabOrder1,boolean displayTabName, LIST<ItemInnerClass> ItemsList1) {
      TabLabel = TabLabel1;
      TabOrder = TabOrder1;
      ItemsList = ItemsList1;
      this.displayTabName=displayTabName;
    }
  }
// -------------------------------------------------------------------------------- Reg Item Inner Class End ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------- Item Inner Class Start ---------------------------------------------------------------------------------
// This Inner Class is used for displaying filtered items
  public class ItemInnerClass {
    public BLN_Item__c items {get; set;}
    public LIST<Selectoption> itemSelectOptions {get; set;}
    public String selectedItemQuantity {get; set;}
    public Decimal PackageFee {get; set;}
    public String PackageInfo {get; set;}
    public Integer availableQuan {get; set;}
    public ItemInnerClass(BLN_Item__c ite, LIST<Selectoption> itemWiseOptions, String qty, Decimal PkgFee, String PkgInfo) {
      If(ite.Available_Tickets__c != null)
      availableQuan = Integer.valueOf(ite.Available_Tickets__c);
      items = new BLN_Item__c();
      itemSelectOptions = new LIST<Selectoption>();
      //selectedItemQuantity = '0';
      PackageFee = PkgFee;
      PackageInfo = PkgInfo;
      items = ite;
      itemSelectOptions = itemWiseOptions;
      if (null != qty )
        selectedItemQuantity = qty;
      else
        selectedItemQuantity = String.valueOf(0);
      PackageFee = PkgFee;
      PackageInfo = PkgInfo;
    }
  }
// ----------------------------------------------------------------------------------- Item Inner Class End ------------------------------------------------------------------------------------
  public Set<Id> selectedTicketIds {get; set;}
  public MAP<id, integer> mapTicWithQuan {get; set;}
  public MAP<id, integer> mapItemWithQuan {get; set;}
  public MAP<id, ItemInnerClass> napIdwithObj {get; set;}
  public decimal eventdexamount {get; set;}
  public boolean disablepromobutton {get; set;}
  public MAP<id, decimal> mapitemWithFee {get; set;}
  public MAP<id, decimal> mapitemWithDiscount {get; set;}
  public decimal actualAmount {get; set;}
  public  MAP<id, BLN_Item__c> mapItemobjWithQua {get; set;}
  public Decimal dnTcPrice {get; set;}
// ------------------------------------------------------------------------------- Apply Promo Code Method Start ----------------------------------------------------------------------------------
// This method is fired when user clicks on apply promo code / when user picks quantity for an item
  public PageReference applyPromocode() {
    errorpromo = '';
    disablepromobutton = false;
    mapitemWithFee = new MAP<id, decimal>();
    napIdwithObj = new MAP<id, ItemInnerClass>();
    actualAmount = 0.00;
    //System.debug('***' + itqnty + ';' + itpoolid + ';' + itlabel + 'itoldqnty ' + itoldqnty + 'Donation Ticket Price ' + dnTcPrice);
    mapItemWithQuan = new MAP<id, integer>();
    for (Integer i = 0; i < RegItemList.size(); i++) {
      if (RegItemList[i].TabLabel == itlabel) {
        if (RegItemList[i].ItemsList.size() > 0) {
          // iterate selected tickets
          for (Integer j = 0; j < RegItemList[i].ItemsList.size(); j++) {
            if (RegItemList[i].ItemsList[j].items.id == itpoolid) { // Previous itpoolid has it pool id i(phani) changed it to item id if error comes change back to itempool id
              if (RegItemList[i].ItemsList[j].items.Payment__c == 'Donation')
                RegItemList[i].ItemsList[j].items.price__c = dnTcPrice;
              //System.debug('Donation ticket Price ' + RegItemList[i].ItemsList[j].items.price__c);
              integer flag = 0;
              for (integer k = 0; k < CalcItemList.size(); k++) {
                if (CalcItemList[k].items.id == itpoolid) {
                  flag = 1;
                  CalcItemList[k].selectedItemQuantity = String.valueOf(Integer.valueOf(CalcItemList[k].selectedItemQuantity) + Integer.valueOf(itqnty) - Integer.valueOf(itoldqnty));
                  //CalcItemList[k].selectedItemQuantity=String.valueOf(Integer.valueOf(CalcItemList[k].selectedItemQuantity)+Integer.valueOf(itqnty)-Integer.valueOf(itoldqnty))
                  //System.debug('Selected Quantity ' + CalcItemList[k].selectedItemQuantity);
                  break;
                }
              }
              if (flag == 0) {
                RegItemList[i].ItemsList[j].selectedItemQuantity = itqnty;
                CalcItemList.add(RegItemList[i].ItemsList[j]);
              }
            }
          }
        }// checking selected list End
      }
    }
    //System.debug('CalcItemList ' + CalcItemList);
    // Intialising Promo code BAL
    BLN_PromoCode_BAL PromotionBAL = new BLN_PromoCode_BAL();
    mapTicWithQuan = new MAP<id, integer>();
    mapItemobjWithQua = new MAP<id, BLN_Item__c>();
    selectedTicketIds = new Set<id>();
    for (ItemInnerClass iic : CalcItemList) {
      integer ih = 0;
      if (null != iic.selectedItemQuantity) {
        ih = Integer.valueOf(iic.selectedItemQuantity);
        if (ih > 0) {
          actualAmount  += ih * (iic.items.price__c);
        }
      }
      mapItemWithQuan.put(iic.items.id, ih);
      mapItemobjWithQua.put(iic.items.id, iic.items);
      napIdwithObj.put(iic.items.id, iic);
    }
    calculateFee(mapItemWithQuan);
    dnTcPrice = 0;
    return null;
  }
// -------------------------------------------------------------------------------- Apply Promo Code Method End -----------------------------------------------------------------------------------
  public string errorpromo {get; set;}
  public Promotion__c PromotionOb {get; set;}
  public string ResCrashfordis {get; set;}
  public decimal amountdollertypeitem {get; set;}
  public pageReference applyPromocodenew() {
    DiscountedAmount = 0.00;
    ResCrashfordis = '';
    errorpromo = '';
    amountdollertypeitem = 0.00;
    PromotionOb = new Promotion__c();
    BLN_PromoCode_BAL PromotionBAL = new BLN_PromoCode_BAL();
    mapitemWithDiscount = new MAP<id, decimal>();
    // Checking Promo Code details in Promotions table
    List<Promotion__c> Promotion = new List<Promotion__c>();
    if (mapItemWithQuan != null) {
      try {
        Promotion  = PromotionBAL.getPromotionDetails(registrationEvent.Id, promocode);
        //System.debug('Promotion Details are: ' + Promotion);
        if (Promotion.size() > 0) {
          PromotionOb = Promotion[0];
        } else {
          errorpromo = 'Invalid promocode!';
          return null;
        }
      } catch (exception ed) {
        errorpromo = 'Invalid promocode!';
        return null;
      }
      errorpromo = '';
      if (Promotion == null ) {
        errorpromo = 'Invalid promocode!';
        return null;
      }
      //Checking validate promotion
      for (Promotion__c  pro : Promotion) {
        //System.debug('Promocode Exp ' + pro.Exp_TimeStamp__c + ' System now ' + system.now());
        if (pro.Exp_TimeStamp__c < system.now()) {
          errorpromo = 'Promo code expired';
          return null;
        } else if (pro.Status__c != 'Active and Enable for online registrations') {
          errorpromo = 'Promo code is not for portal users';
          return null;
        }
      }
      MAP<Id, Item_Promotion__c> ItemMap = new MAP<Id, Item_Promotion__c >();
      // If promo code is Basic info
      if (Promotion != NULL) {
        if (Promotion[0].T_Used_Count__c < Promotion[0].T_Max_Count__c) {
          LIST<Item_Promotion__c> ItemPromotions = PromotionBAL.getItemPromotions(Promotion[0].Id);
          if (ItemPromotions.size() > 0) {
            for (Item_Promotion__c IP : ItemPromotions) {
              if (IP.Buy_Item__c != null) {
                ItemMap.put(IP.Buy_Item__c, IP);
              }
            }
          }
        }
      }
      TotalAmount = 0.0;    DiscountAmount = 0.00; FeeAmount = 0.00; TaxAmount = 0.00;
      TotalAmountwithTaxes = 0.00;
      //Iterating Item innclass
      for (id itq : mapItemWithQuan.keySet()) {
        if (mapItemWithQuan.get(itq) != null) {
          Integer itqQuan = mapItemWithQuan.get(itq);
          if (itqQuan >= 1) {
            Decimal blfeeDoller = 0.00;
            Decimal blfeePercent = 0.00;
            BLN_Item__c itm = new BLN_Item__c();
            itm = mapItemobjWithQua.get(itq);
            Decimal discountindval = 0.00;
            Decimal feableAmount = 0.00;
            TotalAmount += itqQuan * (itm.price__c);
            // Calculating bl fee for doller type
            if (itm.Payment__c != 'Free' && itm.price__c > 0 && (itm.service_fee__c == 'Add Eventdex fee on top of the total ticket price')) {
              if (mapItemWithPrice.get(itm.Item_Type__r.id).BL_Fee_Amount__c > 0) {
                if (itm.Item_Type__r.Name != 'Package')
                  blfeeDoller = itqQuan * mapItemWithPrice.get(itm.Item_Type__r.id).BL_Fee_Amount__c;
                else
                  blfeeDoller = itqQuan * mapItemWithPriceforpkg.get(itm.Item_Pool__c).BL_Fee_Amount__c;
              }
            }
            //System.debug('Bl fee as Dollers  ' + blfeeDoller);
            if (ItemMap.keySet().contains(itq)) {
              Item_Promotion__c iptemp = new Item_Promotion__c();
              iptemp = ItemMap.get(itq);
              if ( itqQuan >= iptemp.Buy_Item_Quantity__c) { // Selected Quantity is more than promo required Quantity
                if (iptemp.Item_Discount_Type__c == 'Percent') {
                  DiscountedAmount += itqQuan * ((itm.price__c) * (iptemp.Item_Discount_Value__c / 100));
                  discountindval = itqQuan * ((itm.price__c) * (iptemp.Item_Discount_Value__c / 100));
                  feableAmount = (itqQuan * itm.price__c) - itqQuan * ((itm.price__c) * (iptemp.Item_Discount_Value__c / 100));
                } else {
                  //Calculating fee for 1 ticket
                  Decimal SingleTicDis = iptemp.Item_Discount_Value__c / iptemp.Buy_Item_Quantity__c;
                  DiscountedAmount += (itqQuan * SingleTicDis);
                  discountindval = (itqQuan * SingleTicDis);
                  amountdollertypeitem += (itqQuan * SingleTicDis);
                  feableAmount = (itqQuan * itm.price__c) - (itqQuan * SingleTicDis);
                }
              } else {
                feableAmount = (itqQuan * itm.price__c);
              }
              ResCrashfordis += itm.id + '';
            } else {
              feableAmount = (itqQuan * itm.price__c);
            }
            //System.debug('Feable amount ' + feableAmount);
            // Applying Tax
            if (registrationEvent.Accept_Tax_Rate__c == TRUE && registrationEvent.Tax_Rate__c != NULL) {
              if (itm.Taxable__c == true) {
                TaxAmount += (feableAmount) * (registrationEvent.Tax_Rate__c) / 100;
              }
            }
            //Getting fee as percentage
            if (itm.Payment__c != 'Free' && itm.price__c > 0 && (itm.service_fee__c == 'Add Eventdex fee on top of the total ticket price')) {
              if (mapItemWithPrice.get(itm.Item_Type__r.id).BL_Fee_Percentage__c > 0) {
                blfeePercent =   feableAmount * mapItemWithPrice.get(itm.Item_Type__r.id).BL_Fee_Percentage__c / 100;
              }
            }
            //System.debug('blfeePercent  amount ' + blfeePercent);
            //FeeAmount+= blfeePercent+blfeeDoller;
            decimal feeTemp = (blfeePercent + blfeeDoller).setScale(2);
            if (feeTemp > maxBlfee ) {
              feeTemp = maxBlfee;
              FeeAmount += maxBlfee;
            } else {
              FeeAmount += blfeePercent + blfeeDoller;
            }
            mapitemWithFee.put(itm.id, feeTemp);
            //discountindval = (blfeePercent+blfeeDoller).setScale(2);
            mapitemWithDiscount.put(itm.id, discountindval);
            // Holds individual item and its discount
          }
        }
      }
      TotalAmount = TotalAmount.setScale(2);
      //System.debug('Total Amount ppppppppppp ' + TotalAmount );
      if (TotalAmount - DiscountedAmount <= 0) {
        FeeAmount = 0;
        TaxAmount = 0;
      }
      FeeAmount = FeeAmount.setScale(2);
      TaxAmount = TaxAmount.setScale(2);
      DiscountedAmount = DiscountedAmount.setScale(2);
      //calculateFee(mapItemWithQuan);
      TotalAmountwithTaxes =  TotalAmount + FeeAmount + TaxAmount - DiscountedAmount;
      TotalAmountwithTaxes = TotalAmountwithTaxes.setScale(2);
      return null;
    } else {
      errorpromo = 'Please Select Tickets To Apply Promocode !';
      return null;
    }
  }
// Fee and tax calculation after promo code applied
  public decimal Taxbleamount {get; set;}

// Caluculate fee
  public void calculateFee(MAP<Id, integer> ItemandQuan) {
    decimal TotalamountBefore = 0.0;
    //TotalamountBefore = TotalAmount-DiscountAmount;
    TotalAmount = 0.0;    DiscountAmount = 0.00;
    eventadminChangedAmount = 0.00;  FeeAmount = 0.00;
    TaxAmount = 0.00;  TotalAmountwithTaxes = 0.00;    eventdexamount = 0.0;
    Taxbleamount = 0.00; DiscountedAmount = 0.00;
    //System.debug('ItemandQuan Map Values ' + mapItemWithQuan);
    // Calculate Eventdex fee amount
    for (Id itemids : ItemandQuan.keySet()) {
      decimal feecalind = 0;
      BLN_Item__c iterateItems = new BLN_Item__c();
      iterateItems = mapItemobjWithQua.get(itemids);
      if (null != mapItemobjWithQua.get(itemids)) {
        integer ItSelectedQuan = mapItemWithQuan.get(itemids);
        if (ItSelectedQuan >= 1) { // if selected Quantity is more than 0
          //System.debug('ItemandQuan Map Values 22' + ItSelectedQuan + 'DDDDDDDD 22' + iterateItems.price__c);
          TotalAmount += ItSelectedQuan * (iterateItems.price__c);
          // Calculating tax on tickets
          if (iterateItems.Payment__c != 'Free' && iterateItems.price__c > 0) {
            if (registrationEvent.Accept_Tax_Rate__c == TRUE && registrationEvent.Tax_Rate__c != NULL) {
              if (iterateItems.Taxable__c == true) {
                //Taxbleamount +=iterateItems.price__c;
                TaxAmount += ItSelectedQuan * (iterateItems.price__c * (registrationEvent.Tax_Rate__c) / 100);
              }
            }
          }
          // If Eventdex  fee is on Item price
          if (iterateItems.Payment__c != 'Free' && iterateItems.price__c > 0 && (iterateItems.service_fee__c == 'Add Eventdex fee on top of the total ticket price')) {
            if (mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Amount__c > 0) {
              if (iterateItems.Item_Type__r.Name != 'Package') {
                //FeeAmount+=ItSelectedQuan*( mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Amount__c);
                feecalind += ItSelectedQuan * ( mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Amount__c);
              } else {
                // FeeAmount+=ItSelectedQuan*( mapItemWithPriceforpkg.get(iterateItems.Item_Pool__c).BL_Fee_Amount__c);
                feecalind += ItSelectedQuan * (mapItemWithPriceforpkg.get(iterateItems.Item_Pool__c).BL_Fee_Amount__c);
              }
            }
            if (mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Percentage__c > 0) {
              if (iterateItems.Item_Type__r.Name == 'Package') {
                //  FeeAmount+=  ItSelectedQuan*(iterateItems.price__c*(mapItemWithPriceforpkg.get(iterateItems.Item_Pool__c).BL_Fee_Percentage__c/100));
                feecalind += ItSelectedQuan * (iterateItems.price__c * (mapItemWithPriceforpkg.get(iterateItems.Item_Pool__c).BL_Fee_Percentage__c / 100));
              } else {
                feecalind +=  ItSelectedQuan * (iterateItems.price__c * (mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Percentage__c / 100));
              }
            }
            //System.debug('Fee Amount 22  ' + feecalind + 'Bl Fee  ' + maxBlfee);
            if (feecalind > maxBlfee) {
              feecalind = maxBlfee;
            }
            //System.debug('Fee cal ind values ' + feecalind );
            FeeAmount += feecalind;
            mapitemWithFee.put(iterateItems.id, feecalind);
          } // If End
          // If Eventdex fee is include
          else if (iterateItems.price__c > 0 && iterateItems.service_fee__c == 'Include the Eventdex fee in to the total ticket price') {
            //System.debug('Fee Amount values 2' + iterateItems.service_fee__c);
            if (mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Amount__c > 0) {
              if (iterateItems.Item_Type__r.Name == 'Package') {
                eventdexamount += ItSelectedQuan * ( mapItemWithPriceforpkg.get(iterateItems.Item_Pool__c).BL_Fee_Amount__c);
              } else {
                eventdexamount += ItSelectedQuan * mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Amount__c;
              }
            }
            if (mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Percentage__c > 0) {
              if (iterateItems.Item_Type__r.Name == 'Package') {
                eventdexamount += ItSelectedQuan * (iterateItems.price__c * (mapItemWithPriceforpkg.get(iterateItems.Item_Pool__c).BL_Fee_Percentage__c / 100));
              } else {
                eventdexamount += ItSelectedQuan * (iterateItems.price__c * (mapItemWithPrice.get(iterateItems.Item_Type__r.id).BL_Fee_Percentage__c / 100));
              }
            }
            decimal des = 0.00;
            mapitemWithFee.put(iterateItems.id, des );
         //   //System.debug('mapitemWithFee 2' + mapitemWithFee);
          } else {
            decimal des = 0.00;
            mapitemWithFee.put(iterateItems.id, des );
          } // Else End
        }
      }
    }
    //System.debug('Fee Amount values 3' + eventdexamount);
    //  eventdexamount=FeeAmount;
    if (TotalAmount - DiscountedAmount <= 0) {
      TaxAmount = 0;
      FeeAmount = 0;
    }
    FeeAmount = FeeAmount.setScale(2);
    DiscountedAmount = DiscountedAmount.setScale(2);
    TaxAmount = TaxAmount.setScale(2);
    TotalAmount = TotalAmount.setScale(2);
    eventdexamount = eventdexamount.setScale(2);
    TotalAmountwithTaxes = (actualAmount + FeeAmount + TaxAmount - DiscountedAmount).setScale(2);
    //System.debug('Total Amount' + TotalAmount + '  Fee Amount ' + FeeAmount + ' Discounted Amount ' + DiscountedAmount + ' Tax Amount  ' + TaxAmount + 'eventdex Amount ' + eventdexamount);
  }
  public List<Reg_Setting__c> settingsForbuyer {get; set;}
// Using existing inner class for Buyer User
  public TicketInnerClass buyerTicketInn {get; set;}
//----------------------------------------------------------------------------------- Order Now Method Start -----------------------------------------------------------------------------------
// This method is fired when user clicks on Order Now button
public String css{get;set;}
  public List<id> TciketsIdsFrScduler {get; set;}
  public String SchedulerIdToAbart {get; set;}
  //buyer template
public BLN_Template__c bt{get;set;}
//attendee template
public BLN_Template__c att{get;set;}
public Map<String,String> tickettemplatemap{get;set;}
//public Attachment at{get;set;}
public Map<String,String> fieldmap{get;set;}
public Map<String,List<String>> itemfieldmap{get;set;}
  public Pagereference orderNow() {
  
   BLN_Quick_Registration_BAL3 QuickRegBAL = new BLN_Quick_Registration_BAL3();
  //start of payment logic
  //Getting List of payment gateways available for an event
      PaymentGateways = new LIST<SelectOption>();
       LIST<Event_Pay_Gateway__c> TempEventPayGateWays = new LIST<Event_Pay_Gateway__c>();
      LIST<Event_Pay_Gateway__c> EventPayGateWays = new LIST<Event_Pay_Gateway__c>();
      LIST<Event_Pay_Gateway__c> AcceptRangePayGateWays = new LIST<Event_Pay_Gateway__c>();
      for (Event_Pay_Gateway__c egp  :  QuickRegBAL.getEventPayGateWays(EventId)) {
        if (egp.Registration_Type__c == 'Online') {
          if (egp.Pay_Gateway__r.PGateway_Type__r.Name != 'Free') {
            TempEventPayGateWays.add(egp  );
          }
        }
      }
      
      if(TempEventPayGateWays.size() > 0) {
      for (Event_Pay_Gateway__c epg : TempEventPayGateWays ) {
      if(epg.Accept_Min_Max_Range__c==true&&TotalAmountwithTaxes>=epg.Min_amount_to_accept__c)
      AcceptRangePayGateWays.add(epg);
      else
       EventPayGateWays.add(epg);
      }
        if(AcceptRangePayGateWays.size()>0)
        EventPayGateWays=AcceptRangePayGateWays;
      }
      if (EventPayGateWays.size() > 0) {
        for (Event_Pay_Gateway__c epg : EventPayGateWays) {
          //System.debug('Payment Gateway type: ' + epg.Pay_Gateway__r.PGateway_Type__r.Name);
          if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Stripe' || epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Authorize.Net') {
            PaymentGateways.add(new SelectOption('Credit Card', 'Credit Card'));
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Check') {
            PaymentGateways.add(new SelectOption(epg.Pay_Gateway__r.PGateway_Type__r.Name, epg.Pay_Gateway__r.PGateway_Type__r.Name));
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'PayPal' && epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct') {
            //System.debug('PPPPPPPPPPPPPPPPPPPPP  ' + epg.Pay_Gateway__r.PGateway_Type__r.Name + 'WWWWWWWWW ' + epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct');
            PaymentGateways.add(new SelectOption('CreditCardPayPalDirect', 'Credit Card'));
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'TrustCommerce' && epg.Pay_Gateway__r.Use_Host_Page__c == false) {
            //System.debug('PPPPPPPPPPPPPPPPPPPPP  ' + epg.Pay_Gateway__r.PGateway_Type__r.Name + 'WWWWWWWWW ' + epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct');
            PaymentGateways.add(new SelectOption('CreditCardTrustCommerceDirect', 'Credit Card'));
          } else {
            //System.debug('PPPPPPPPPPPPPPPPPPPPP  3333 ' + epg.Pay_Gateway__r.PGateway_Type__r.Name + 'WWWWWWWWW 333 ' + epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct');
            PaymentGateways.add(new SelectOption(epg.Pay_Gateway__r.PGateway_Type__r.Name, epg.Pay_Gateway__r.PGateway_Type__r.Name));
          }
          List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
          boothleadspaygate = [SELECT id, Company__c, Min_amount_to_accept__c, PGateway_Type__c, PGateway_Type__r.Name, PG_Email_Id__c, PG_Pass_Secret__c, PG_Signature__c, PG_User_Key__c, PP_Fee_Payer__c, PP_Payment_Type__c, Service_Fee__c from Pay_Gateway__c where Company__r.Name = 'EventdexLive'];
          if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'PayPal') {
            if (epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Adaptive') {
              PaymentType = epg.Pay_Gateway__r.PP_Payment_Type__c;
              feesPayer = epg.Pay_Gateway__r.PP_Fee_Payer__c;
              PayeeEmail = epg.Pay_Gateway__r.PG_Email_Id__c;
              if (boothleadspaygate.size() > 0) {
                for (Pay_Gateway__c pgat : boothleadspaygate) {
                  if (pgat.PGateway_Type__r.Name == 'PayPal') {
                    BoothLeadsEmail = pgat.PG_Email_Id__c;
                  }
                }
              }
              //System.debug('AAAAAAAA BoothLeadsEmail ' + BoothLeadsEmail );
              PayGatewayMode = 'PayPal';
            } else if (epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct') {
              BoothLeadsEmail = epg.Pay_Gateway__r.PG_User_Key__c;
              ANLoginId = epg.Pay_Gateway__r.PG_Pass_Secret__c;
              ANTransactionKey = epg.Pay_Gateway__r.PG_Signature__c;
              PayGatewayMode = 'PayPal';
            }
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Stripe') {
            if (epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c == 'Direct')
              StripeRefreshToken = epg.Pay_Gateway__r.PG_Pass_Secret__c;
            else
              StripeRefreshToken = epg.Pay_Gateway__r.PG_User_Key__c;
            if (boothleadspaygate.size() > 0) {
              //StripeSecret = epg.Pay_Gateway__r.PGateway_Type__r.BoothLeads_Stripe_Secret__c;
              StripeSecret = boothleadspaygate[0].PG_Pass_Secret__c;
            }
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Authorize.Net') {
            ANLoginId = epg.Pay_Gateway__r.PG_User_Key__c;
            ANTransactionKey = epg.Pay_Gateway__r.PG_Signature__c;
            // PayGatewayMode = 'Authorize.Net';
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'TrustCommerce') {
            ANLoginId = epg.Pay_Gateway__r.PG_User_Key__c;
            ANTransactionKey = epg.Pay_Gateway__r.PG_Signature__c;
            // PayGatewayMode = 'TrustCommerce';
          } else if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Check') {
            // PayGatewayMode = 'Check';
          }
        }
      }
      //Fetching CheckAddress
      BLN_UCRole_DAO UCRDAO = new BLN_UCRole_DAO();
      BLN_Company_DAO ComDAO = new BLN_Company_DAO();
      if (registrationEvent.organizer_id__c != NULL) {
        Company__c CheckCompany = ComDAO.queryCompany(registrationEvent.organizer_id__c);
        for (Company_Ext__c ce : CheckCompany.Company_Ext__r) {
          CheckAddress = ce;
        }
      }
      //Getting Stripe Related Information
      MonthsList = new LIST<SelectOption>();
      YearsList = new LIST<SelectOption>();
      CreditCardType = new LIST<SelectOption>();
      LIST<String> monthstring = new LIST<String> {'01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'};
      LIST<String> yearstring = new LIST<String> {'2014', '2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028', '2029', '2030'};
      LIST<String> cardtypestring = new LIST<String> {'Visa', 'MasterCard', 'American Express', 'Discover'};
      SelectedYear = String.valueOf(system.today().year());
      YearsList.add(new SelectOption(SelectedYear, SelectedYear));
      String y = SelectedYear;
      for (integer l = 0; l <= 15; l++) {
        y = String.valueof(integer.valueOf(y) + 1);
        YearsList.add(new SelectOption(y, y));
      }
      for (String m : monthstring) {
        MonthsList.add(new SelectOption(m, m));
      }
      for (String c : cardtypestring) {
        CreditCardType.add(new SelectOption(c, c));
      }
  //end of payment logic
    //System.debug(' BLN_CompCommodity_DAO.getCommodities(); ' + CommoditiesOuter);
    isDt = false;
    ShowSecondPage = TRUE;
    HideLogin = FALSE;
    integer i = 1;
    
    breakBlockticketsLoop.bvalue = false;
    buyerTicketInn = new TicketInnerClass();
    //System.debug(' rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ' + CommoditiesOuter);
    //System.debug('Item list Size: ' + ItemList.size());
    //For fetching Registration & Survey settings
    fetchSettings();
    SET<id> ticketsWithBuyerinfo = new SET<id>();
    Integer ItemQuantity;
    List<Ticket__c> abandonedList = new List<Ticket__c>();
    SET<id> buyeridsdup = new SET<id>();
    TciketsIdsFrScduler = new List<id>();
    // Iterating through items seleceted
    for (ItemInnerClass iic : ItemList) {
      if (iic.selectedItemQuantity != null) {
        if (Integer.valueOf(iic.selectedItemQuantity) >= 1 ) {
          BLN_Item__c BLNItem = new BLN_Item__c();
          BLNItem = iic.items;
          if (iic.items.Ticket_Settings__c == 'Collect info from Buyers only' || iic.items.Ticket_Settings__c == 'Do not collect Attendee info') {
            if (iic.items.Item_Type__r.Name != 'Package') {
              RegTickets = QuickRegBAL.getTicketDetail(iic.items, Integer.valueOf(iic.selectedItemQuantity));
            } else {
              iic.items.Ticket_Settings__c = 'Collect info from All Attendees';
              RegTickets = QuickRegBAL.getTicketDetail(iic.items, Integer.valueOf(iic.selectedItemQuantity));
            }
            ItemQuantity = Integer.valueOf(iic.selectedItemQuantity);
             } else if (iic.items.Ticket_Settings__c == 'Collect info from All Attendees') {
            //fetchNAICSCodes();
            RegTickets = QuickRegBAL.getTicketDetail(iic.items, Integer.valueOf(iic.selectedItemQuantity));
            //System.debug('Fetched Tickets:' + RegTickets);
            ItemQuantity = 1;
          }
          MAP<id, SET<id>> mapPidWithPoolId = new MAP<id, SET<id>>();
          SET<id> removeDupQue = new SET<id>();
          // For Loop Start
          for (Ticket__c t : RegTickets) {
            t.Ticket_Status__c = 'Reserved';
            TciketsIdsFrScduler.add(t.id);
            abandonedList.add(t);
            // For non package tickets we are appending survey Questions and Settings
            if (t.Item_Type__r.Name != 'Package') {
              if (t.Item__r.Ticket_Settings__c == 'Collect info from All Attendees') {
                TicketList.add(new TicketInnerClass(t, i++, ItemQuantity, BLNItem, RegSettingsMap, QuestionsItemMap, SelectedCountry, true, listOfnaicscodes, diversityList, new SET<id>()));
              } else {
                MAP<id, LIST<Item_Question__c>> QuestionsMapTemp = new MAP<id, LIST<Item_Question__c>>();
                boolean tcvalueQuestions = true;
                if (ticketsWithBuyerinfo.contains(iic.items.id)) {
                  QuestionsMapTemp = new MAP<id, LIST<Item_Question__c>>();
                  tcvalueQuestions = false;
                } else {
                  QuestionsMapTemp = QuestionsItemMap;
                  ticketsWithBuyerinfo.add(t.Item__r.id);
                }
                TicketList.add(new TicketInnerClass(t, 0, ItemQuantity, BLNItem, RegSettingsMap, QuestionsMapTemp, SelectedCountry, tcvalueQuestions, listOfnaicscodes, diversityList, new SET<id>()));
              }
            } else {
              MAP<id, LIST<Item_Question__c>> QuestionsMapTemp = new MAP<id, LIST<Item_Question__c>>();
              if (t.Item__r.Ticket_Settings__c == 'Do not collect Attendee info') { // If Settings are at pool Level
                if (t.Item_Pool__r.Ticket_Settings__c == 'Collect info from All Attendees') {
                  TicketList.add(new TicketInnerClass(t, i++, ItemQuantity, BLNItem, RegSettingsMap, QuestionsItemMap, SelectedCountry, true, listOfnaicscodes, diversityList, new SET<id>()));
                } else if (t.Item_Pool__r.Ticket_Settings__c == 'Collect info from Buyers only') {
                  if (!buyeridsdup.contains(t.Item_pool__r.id)) {
                    QuestionsMapTemp = QuestionsItemMap;
                    buyeridsdup.add(t.Item_pool__r.id);
                  }
                  //System.debug('Survey Questionsssssssssss  ' + QuestionsItemMap);
                  TicketList.add(new TicketInnerClass(t, 0, ItemQuantity, BLNItem, RegSettingsMap, QuestionsMapTemp, SelectedCountry, true, listOfnaicscodes, diversityList, new SET<id>()));
                } else {
                  TicketList.add(new TicketInnerClass(t, 0, ItemQuantity, BLNItem, RegSettingsMap, new MAP<id, LIST<Item_Question__c>>(), SelectedCountry, true, listOfnaicscodes, diversityList, new SET<id>()));
                }
              } else { // If Setting is at Package Level
                if (t.Item__r.Ticket_Settings__c == 'Collect info from Buyers only') {
                  if (!buyeridsdup.contains(t.Item_pool__r.id)) {
                    if (t.Parent_ID__c == null ) { //For Package level survey questions display
                      QuestionsMapTemp = QuestionsItemMap;
                    } else {
                      SET<id> plIds = new SET<id>();
                      if (null != mapPidWithPoolId.get(t.Parent_ID__c)) {
                        plIds = mapPidWithPoolId.get(t.Parent_ID__c);
                      }
                      plIds.add(t.Item_pool__r.id);
                      mapPidWithPoolId.put(t.Parent_ID__c, plIds);
                    }
                    buyeridsdup.add(t.Item_pool__r.id);
                  }
                  //System.debug('NNNNNNNNNNN ' + mapPidWithPoolId.get(t.Parent_ID__c));
                  TicketList.add(new TicketInnerClass(t, 0, ItemQuantity, BLNItem, RegSettingsMap, QuestionsMapTemp, SelectedCountry, true, listOfnaicscodes, diversityList, mapPidWithPoolId.get(t.id)));
                } else if (t.Item__r.Ticket_Settings__c == 'Collect info from All Attendees') {
                  if (t.Parent_ID__c == null ) { //For Package level survey questions display
                    QuestionsMapTemp = QuestionsItemMap;
                  } else {
                    SET<id> plIds = new SET<id>();
                    if (null != mapPidWithPoolId.get(t.Parent_ID__c)) {
                      plIds = mapPidWithPoolId.get(t.Parent_ID__c);
                    }
                    plIds.add(t.Item_pool__r.id);
                    mapPidWithPoolId.put(t.Parent_ID__c, plIds);
                  }
                  //  TicketList.add(new TicketInnerClass(t,0,new GN_User__c(),ItemQuantity,BLNItem,RegSettingsMap,QuestionsMap,SelectedCountry,false));
                  TicketList.add(new TicketInnerClass(t, i++, ItemQuantity, BLNItem, RegSettingsMap, QuestionsMapTemp, SelectedCountry, true, listOfnaicscodes, diversityList, mapPidWithPoolId.get(t.id)));
                } else {
                  TicketList.add(new TicketInnerClass(t, 0, ItemQuantity, BLNItem, RegSettingsMap, new MAP<id, LIST<Item_Question__c>>(), SelectedCountry, true, listOfnaicscodes, diversityList, new SET<id>()));
                }
              }
            }
          }// for End
          //System.debug('TicketList With User Anwsers ' + TicketList);
        }
      } else {
        iic.selectedItemQuantity = '0';
      }
    }
    //DataBase.update(abandonedList, false);
    BLN_generateScanId createScanId = new BLN_generateScanId();
    createScanId.insertScanId(abandonedList); // Tickets will be updated in this list and also this will give scan id

    //This class will create new Scheduler for releasing tickets
    Bln_Scheduler_ticketStatus scCls = new Bln_Scheduler_ticketStatus();
    SchedulerIdToAbart = scCls.Bln_Scheduler(SessionTime, TciketsIdsFrScduler);
    //System.debug('XXXXXXXXXXXXXXXX ' + SchedulerIdToAbart);
    //Fetching Event Level Survey Questions
    //UserEventAnswer = new LIST<UserAnswerInnerClass>();
    LIST<SelectOption> Answers;
    //System.debug('Event Level Questions' + EventQuestions);
    for (Item_Question__c  q1 : EventQuestions) {
      Question__c q = new Question__c();
      q = BLN_SurveyQuestions_DAO.mapQidWitQue.get(q1.Question__c);
      Boolean isRequired;
      Answers = new LIST<SelectOption>();
      //System.debug('UUUUUUUUUUU ' + q.Answer_Type__c);
      if (q.Answer_Type__c == 'Choose from a list' || q.Answer_Type__c == 'Single Selection' || q.Answer_Type__c == 'Checkboxes' || q.Answer_Type__c == 'Scale') {
        for (BLN_Answer__c a : q.BLN_Answers__r) {
          Answers.add(new SelectOption(a.id, a.Answer_Text__c));
        }
        //System.debug('GGGGGGG KKKKKKKKK  ' + Answers);
      }
      for (Item_Question__c iq : q.Item_Question__r) {
        if (iq.isRequired__c == TRUE) {
          isRequired = TRUE;
        }
      }
      buyerTicketInn.UserAnswer.add(new UserAnswerInnerClass(q, q.BLN_Answers__r, Answers, isRequired, q1));
      //System.debug('lllllllllllll' + buyerTicketInn.UserAnswer);
    }
    buyerTicketInn.naicsList = listOfnaicscodes;
    buyerTicketInn.diversList = diversityList;
    buyerTicketInn.CommoditiesList.addAll(CommoditiesOuter);
    //System.debug('PPPPPPPPPPP ' + CommoditiesOuter);
    //System.debug('QQQQQQQQQQQQQQQQQQQ ' + buyerTicketInn.CommoditiesList);
    maintemplate=[select id,name,Data__c,bln_events__c,InUse__c,structure_type__c from BLN_Reg_Main_Template__c where bln_events__c=:RegistrationEvent.id and structure_type__c='Registration Page' and InUse__c=true limit 1];
bt=[select id,name,Template_Name__c,Order__c,HTML__c,BLN_Reg_Main_Template__c from BLN_Template__c where BLN_Reg_Main_Template__c=:maintemplate[0].id and Template_Name__c='BuyerTemplate' limit 1];

 //System.debug('==========> '+maintemplate[0].id);
 //System.debug('==========> '+maintemplate[0].id);
att=[select id,name,Template_Name__c,Order__c,HTML__c,BLN_Reg_Main_Template__c from BLN_Template__c where BLN_Reg_Main_Template__c=:maintemplate[0].id and Template_Name__c='AttendeeTemplate' limit 1];
tickettemplatemap=new Map<String,String>();
String templateitemids='';
//BLN_Template__c    att1=[select id,name,HTML__c,BLN_Events__r.name from BLN_Template__c where BLN_Events__r.name='Default Event(Boothleads)' and Template_Name__c='AttendeeTemplate' and BLN_Reg_Main_Template__c='' limit 1]; 
String templatedefaulthtml='';
BLN_Template__c    att1=[select id,name,HTML__c,BLN_Events__r.name from BLN_Template__c where BLN_Events__r.name='Default Event(Boothleads)' and Template_Name__c='AttendeeTemplate' and BLN_Reg_Main_Template__c=''limit 1]; 
 templatedefaulthtml=att1.HTML__c;   
//att1.html__c;
for(BLN_Template_Child__c temchild:[select id,name,BLN_Item__c,BLN_Item_Pool__c,BLN_Template__r.Template_Name__c,HTML__c,BLN_Template__r.BLN_Reg_Main_Template__c from BLN_Template_Child__c where BLN_Template__r.BLN_Reg_Main_Template__c=:maintemplate[0].id and BLN_Template__r.Template_Name__c='AttendeeTemplate'])
{
if(temchild.BLN_Item__c!=null){
tickettemplatemap.put(temchild.BLN_Item__c,temchild.HTML__c);
templateitemids+=temchild.BLN_Item__c+',';
}
else{
tickettemplatemap.put(temchild.BLN_Item_Pool__c,temchild.HTML__c);
templateitemids+=temchild.BLN_Item_Pool__c+',';
}


}
//if no template for that item

//at=[SELECT Id,Name,ContentType,body FROM Attachment where ParentId =:att.id];
//css=at.body.toString();
List<BLN_Template_Mapping__c> getmaplist=[select id,name,DB_Field_Name__c,Html_Field_Name__c,BLN_Template__c,BLN_Events__c,BLN_Item__c from BLN_Template_Mapping__c where BLN_Events__c=:RegistrationEvent.id and BLN_Template__c=:att.id and BLN_Item__c!=null order by BLN_Item__c];
 
  itemfieldmap=new Map<String,List<String>>();
  
  for(BLN_Template_Mapping__c btmap:getmaplist)
  {
    if(itemfieldmap.containskey(btmap.BLN_Item__c))
    {
      List<String> newlist=itemfieldmap.get(btmap.BLN_Item__c);
      newlist.add(btmap.DB_Field_Name__c+'^^'+btmap.Html_Field_Name__c);
    itemfieldmap.put(btmap.BLN_Item__c,newlist);
    }
    else
    {
     List<String> newlist=new List<String>();
     newlist.add(btmap.DB_Field_Name__c+'^^'+btmap.Html_Field_Name__c);
    itemfieldmap.put(btmap.BLN_Item__c,newlist);
    }
  }
  
  buyerfieldmapstring=new List<String>();
  List<BLN_Template_Mapping__c> buyergetmaplist=[select id,name,DB_Field_Name__c,Html_Field_Name__c,BLN_Template__c,BLN_Events__c,BLN_Item__c from BLN_Template_Mapping__c where BLN_Events__c=:RegistrationEvent.id and BLN_Template__c=:bt.id and BLN_Item__c=null ];
for(BLN_Template_Mapping__c btmap:buyergetmaplist)
  {
    buyerfieldmapstring.add(btmap.DB_Field_Name__c+'^^'+btmap.Html_Field_Name__c);
    
  }
  
  
  fieldmap=new Map<String,String>();
  
  for(BLN_Template_Mapping__c btmap:getmaplist)
  {
    fieldmap.put(btmap.DB_Field_Name__c,btmap.Html_Field_Name__c);
  }
  /*Set<id> ItemsSet=new Set<id>();
  ItemsSet.add('a1B8A0000004OiQ');
  BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
        RegSettingsMap = RegSettingsBAL.getTicketSettings(ItemsSet,'a198A0000000BR5');*/
tktcopyoptions = new List<SelectOption>();
tktcopyoptions.add(new SelectOption('','Select (Optional)'));
tktcopyoptions.add(new SelectOption('htmldivbuyer','Buyer Info'));
integer p=0;
for(integer t=0;t<TicketList.size();t++){
if((TicketList[t].Ticket.Item_Pool__r.Ticket_Settings__c == 'Collect info from All Attendees' && TicketList[t].Ticket.Item_Type__r.name == 'Package' && TicketList[t].Ticket.Parent_ID__c!=null) || (TicketList[t].Ticket.Item__r.Ticket_Settings__c == 'Collect info from All Attendees' && TicketList[t].Ticket.Item_Type__r.name != 'Package') || (TicketList[t].Ticket.Item__r.Ticket_Settings__c == 'Collect info from All Attendees' && TicketList[t].Ticket.Item_Type__r.name == 'Package' && TicketList[t].Ticket.Parent_ID__c==null))
{
if(templateitemids.indexOf(TicketList[t].Ticket.Item__c)==-1)
tickettemplatemap.put(TicketList[t].Ticket.Item__c,templatedefaulthtml);
if(templateitemids.indexOf(TicketList[t].Ticket.Item_pool__r.id)==-1)
tickettemplatemap.put(TicketList[t].Ticket.Item_pool__r.id,templatedefaulthtml);
tktcopyoptions.add(new SelectOption(p+':holdticket','Ticket #'+(p+1)));
p++;
}
}

PageReference pd=new PageReference('/apex/BLN_SecondPage');
pd.setRedirect(false);
return pd;
}
  public List<SelectOption> tktcopyoptions{get;set;}
  public List<BLN_Reg_Main_Template__c> maintemplate{get;set;}
  public List<String> buyerfieldmapstring{get;set;}
//----------------------------------------------------------------------------------- Order Now Method End --------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------- Ticket Inner Class Start --------------------------------------------------------------------------------
// This Inner Class is used for Showing Input forms based on item selection

  public class TicketInnerClass {
    public Integer OrderNo {get; set;}
    public Ticket__c Ticket {get; set;}
    //public GN_User__c EachUser{get;set;}
    public String Tag {get; set;}
    public Tkt_Profile__c tktProfileObject {get; set;} // to hold user info
    public BLN_Address__c homeAddress {get; set;} // to hold home address
    public BLN_Address__c workAddress {get; set;} // to hold work address
    public BLN_Address__c shippingAddress {get; set;} // to hold Shipping address
    public BLN_Address__c billingAddress {get; set;} // to hold Billing address
    public String customBarcode {get; set;}
    public Integer selectedQuantity {get; set;}
    public BLN_Item__c BLNItem {get; set;}
    public MAP<Id, LIST<Reg_Setting__c>> RegSettingMap {get; set;} // MAP containing Registration Settings i.e. Key as Item Id and Values are List of Registration Settings
    public MAP<Id, LIST<Item_Question__c>> QuestionMap {get; set;} // MAP containing Survey Questions i.e. Key as Item Id and Values are List of Questions
    public LIST<UserAnswerInnerClass> UserAnswer {get; set;} // Inner Class Instance for Item Survey Questions & Answers
    public string selectedCompnay {get; set;} //It holds value if user picks existing Company
    public boolean surveys {get; set;} // This will decide survey display or not
    // public string designationComp{get;set;}
    // For Naics codes
    public String selectedNaicsCodes {get; set;}
    public List<List<NAICS_Code__c>> naicsList {get; set;}
    // For Diversities
    public String selecteddivers {get; set;}
    public List<Diversity__c> diversList {get; set;}
    //For Commodities
    public String selectedCommodities {get; set;}
    public List<BLN_Commodities__c> CommoditiesList {get; set;}
    //For Speaker Information
    public String  SpeakerPic1 {get; set;}
    public string SpeakerImageName1 {get; set;}
    //For Company Logo      
    public String  CompanyPic1  {get; set;}       
    public string CompanyImageName1 {get; set;}
    public String myfile1 {get; set;}
    public string myfilename1 {get; set;}
    // RegSettings for Buyer
    public List<Reg_Setting__c> settingsForbuyer {get; set;}
    public TicketInnerClass() {
      tktProfileObject = new Tkt_Profile__c();
      homeAddress = new BLN_Address__c();
      workAddress = new BLN_Address__c();
      shippingAddress = new BLN_Address__c();
      billingAddress = new BLN_Address__c();
      settingsForbuyer = new List<Reg_Setting__c>();
      naicsList = new List<List<NAICS_Code__c>>();
      UserAnswer = new List<UserAnswerInnerClass>();
      diversList = new List<Diversity__c>();
      CommoditiesList = new List<BLN_Commodities__c>();
    }
    public TicketInnerClass(Ticket__c Tkt, Integer ONo, Integer sQuantity, BLN_Item__c Item, MAP<Id, LIST<Reg_Setting__c>> RSMap, MAP<Id, LIST<Item_Question__c>> QMap, String selectedCountry, boolean surveys, List<List<NAICS_Code__c>> naic , List<Diversity__c> divers, SET<id> poolIds) {
      Ticket = Tkt;
      OrderNo = ONo;
      settingsForbuyer = new List<Reg_Setting__c>();
      naicsList = new List<List<NAICS_Code__c>>();
      diversList = new List<Diversity__c>();
      CommoditiesList = new List<BLN_Commodities__c>();
      CommoditiesList = CommoditiesOuter;
      if (naic.size() > 0)
        naicsList = naic;
      if (divers.size() > 0)
        diversList = divers;
      tktProfileObject = new Tkt_Profile__c();
      homeAddress = new BLN_Address__c();
      homeAddress.Country__c = selectedCountry;
      workAddress = new BLN_Address__c();
      workAddress.Country__c = selectedCountry;
      shippingAddress = new BLN_Address__c();
      shippingAddress.Country__c = selectedCountry;
      billingAddress = new BLN_Address__c();
      billingAddress.Country__c = selectedCountry;
      selectedQuantity = sQuantity;
      BLNItem = Item;
      RegSettingMap = RSMap;
      QuestionMap = QMap;
      this.surveys = surveys;
      UserAnswer = new LIST<UserAnswerInnerClass>();
      LIST<SelectOption> AnswerOptions;
      try {
        List<Item_Question__c> tempQue = new List<Item_Question__c>();
        if (Tkt.Parent_ID__c != null || Tkt.Item_Type__r.Name == 'Package') {
          //System.debug(' ITEMSSSSSSSS   ' + QMap);
          tempQue.addAll(QuestionMap.get(BLNItem.Id));
          tempQue.addAll(QuestionMap.get(Tkt.Item_Pool__c));
          //System.debug('Pool Ids Item Pool ' + poolIds);
          for (id plids : poolIds) {
            tempQue.addAll(QuestionMap.get(plids));
          }
        } else {
          tempQue = QuestionMap.get(BLNItem.Id);
        }
        for (Item_Question__c q1 : tempQue  ) {
          Question__c  q = new Question__c();
          // qItem_Question__c
          q = BLN_SurveyQuestions_DAO.mapQidWitQue.get(q1.Question__c);
          Boolean isRequired;
          AnswerOptions = new LIST<SelectOption>();
          if (q.Answer_Type__c == 'Single Selection' || q.Answer_Type__c == 'Choose from a list' ||  q.Answer_Type__c == 'Checkboxes' || q.Answer_Type__c == 'Scale') {
            for (BLN_Answer__c a : q.BLN_Answers__r) {
              AnswerOptions.add(new SelectOption(a.id, a.Answer_Text__c));
            }
          }
          for (Item_Question__c iq : q.Item_Question__r) {
            if (Tkt.Parent_ID__c == null) {
              if ( (iq.Item__r.Id == BLNItem.Id && iq.isRequired__c == TRUE) ) {
                isRequired = TRUE;
              }
            } else {
              if ( iq.isRequired__c == TRUE && iq.Item_pool__c == Tkt.Item_pool__c) {
                isRequired = TRUE;
              }
            }
          }
          UserAnswer.add(new UserAnswerInnerClass(q, q.BLN_Answers__r, AnswerOptions, isRequired, q1));
        }
      } catch (exception e) {}
      //System.debug('UserAnswerInnerClass 123c ' + UserAnswer + ' Tciket   ' + tkt.Name);
    }
  }
// ----------------------------------------------------------------------------------- Ticket Inner Class End ----------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------- Survey Questions Inner Class Start ----------------------------------------------------------------------

//This inner class is for showing survey questions along with tickets
  global  class UserAnswerInnerClass {
    public Question__c Question {get; set;}
    public LIST<BLN_Answer__c> ItemAnswer {get; set;}
    public LIST<SelectOption> Answers {get; set;}
    public Boolean isRequired {get; set;}
    public String SelectedAnswer {get; set;}
    public Item_Question__c itq {get; set;}
    public String[] SelectedAnswerCheck = new String[] {};
    public String[] getSelectedAnswerCheck() {
      return SelectedAnswerCheck;
    }
    public void setSelectedAnswerCheck(String[] SelectedAnswerCheck) {
      this.SelectedAnswerCheck = SelectedAnswerCheck;
    }
    public UserAnswerInnerClass(Question__c Ques, LIST<BLN_Answer__c> IAnswer, LIST<SelectOption> Ans, Boolean RequiredBool, Item_Question__c itemQues) {
      Question = Ques;
      itq = itemQues;
      ItemAnswer = IAnswer;
      Answers = Ans;
      isRequired = RequiredBool;
    }
  }
// ----------------------------------------------------------------------------------- Survey Questions Inner Class End ----------------------------------------------------------------------

  public string encodedCipherText {get; set;}
  public string eventidAfterEncoding {get; set;}
  public string buyerTitle {get; set;}
  public String CardNo {get; set;}
  Public BLN_TrasactionStatus transactionStatus {get; set;}
  public String orderId {get; set;}
  public String sty {get; set;}
  public boolean isOrderCreated = false ;
  public String prevSelectedPaymentGateway {get; set;}
  public String abandonScJobId {get; set;}
//------------------------------------------------------------------------------- Validating Payment Method Start -------------------------------------------------------------------------------

  public pageReference validatePayment() {
    if (SelectedPaymentGateway != null && SelectedPaymentGateway != '')
      prevSelectedPaymentGateway = SelectedPaymentGateway;
    // try{
    isPaypaladvaptive = false;
    ChargeId = '';
    CardNo = '';
    pagereference pg;
    if (TotalAmount - DiscountedAmount <= 0) {
      transactionStatus = new BLN_TrasactionStatus();
      //System.debug('SSSSSSSSSSSSSSSSS  ' + isOrderCreated);
      IF(isOrderCreated) {
      } else {
        SelectedPaymentGateway = 'Free';
        PayGatewayMode = 'Free';
        transactionStatus = completeRegistration();
        if (transactionStatus.orderId != '' && transactionStatus.orderId != null) {
          orderId = transactionStatus.orderId;
          // isOrderCreated =true;
        }
      }
      //System.debug('SSSSSSSSSSSSSSSSS  ' + transactionStatus);
      return null;
    }
    if (SelectedPaymentGateway == 'Credit Card' && StripeRefreshToken != NULL) {
      PayGatewayMode = 'Stripe';
    } else if (SelectedPaymentGateway == 'Credit Card' && ANLoginId != NULL && ANTransactionKey != NULL) {
      PayGatewayMode = 'Authorize.Net';
    } else if (SelectedPaymentGateway == 'Check') {
      PayGatewayMode = 'Check';
    } else if (SelectedPaymentGateway == 'Cash') {
      PayGatewayMode = 'Cash';
    } else if (SelectedPaymentGateway == 'CreditCardPayPalDirect') {
      SelectedPaymentGateway = 'Credit Card';
      payGatewayMode = 'PayPal';
    } else if (SelectedPaymentGateway == 'CreditCardTrustCommerceDirect') {
      SelectedPaymentGateway = 'Credit Card';
      payGatewayMode = 'TrustCommerce';
    } else if (SelectedPaymentGateway == 'PayPal') { // PayPal Payment
      PayGatewayMode = 'PayPal';
    } else if (SelectedPaymentGateway == 'TrustCommerce') {
      PayGatewayMode = 'TrustCommerce';
    } else {
      transactionStatus = new BLN_TrasactionStatus();
      transactionStatus.errorMessage = 'Please select atleast one payment type';
      return null;
    }
    //System.debug('isOrderCreated   isOrderCreated   ' + isOrderCreated);
    if (isOrderCreated) {
    } else {
      transactionStatus = new BLN_TrasactionStatus();
      //System.debug('completeRegistration call    ');
      transactionStatus = completeRegistration();
      //System.debug('transactionStatus.errorMessage   ' + transactionStatus);
      if (transactionStatus.orderId != '' && transactionStatus.orderId != null) {
        orderId = transactionStatus.orderId;
        // isOrderCreated =true;
        BLN_SchedlerCallClass scCls1 = new BLN_SchedlerCallClass();
        SessionAbn = SessionTime - (SessionTime - timerValue);
        //System.debug(' SessionTime ' + SessionTime + ' timerValue ' + timerValue + ' SessionAbn ' + SessionAbn);
        if (abandonScJobId != null && abandonScJobId != '') {
          List<CronTrigger> ctList2 = [SELECT Id FROM CronTrigger where id = :abandonScJobId];
          //System.debug('SchedulerIdToAbart ' + ctList2.size());
          for (CronTrigger ct : ctList2) {
            system.abortJob(ct.id);
          }
        }
        if (transactionStatus.payGatewayName == 'trustcommerce')
          abandonScJobId = scCls1.BLN_SchedlerMethod(120, orderId);
        else
          abandonScJobId = scCls1.BLN_SchedlerMethod(SessionAbn, orderId);
        if (SchedulerIdToAbart != null && SchedulerIdToAbart != '') { // This will cancel reserve status change scheduler
          List<CronTrigger> ctList = [SELECT Id FROM CronTrigger where id = :SchedulerIdToAbart];
          //System.debug('SchedulerIdToAbart ' + ctList.size());
          for (CronTrigger ct : ctList) {
            system.abortJob(ct.id);
          }
        }

      }
    }
    return null;
  }

  public pagereference callingPaymentMethod() { //Api call not accepted to insert order and paymet call in sam emothod
    //System.debug('transactionStatus.errorMessage   ' + isOrderCreated);
    try {
      if (!isOrderCreated) {
        pagereference pg;
        transactionStatus = new BLN_TrasactionStatus();
        transactionStatus = PaymentCall();
        if ((transactionStatus.transactionId != null && transactionStatus.transactionId != '') || (transactionStatus.payKey != null && transactionStatus.payKey != '' ) ) {
         setCookieValues();//Setting Cookies for success Page
         Payment__c paymentObj = new Payment__c();
          paymentObj = [select id, credit_card_last_4digits__c, credit_card_type__c , BLN_Pay_Gateway__c, Currency_Code__c, Order__c, Payment_Amount__c, Pay_Address__c, Payment_Mode__c, Payment_Ref_Number__c, BLN_Pay_Gateway__r.PGateway_Type__r.Name, BLN_Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c from Payment__c where order__c = :orderId];
          if (transactionStatus.payGatewayName == 'paypaladaptive' || transactionStatus.payGatewayName == 'trustcommerce' ) {
            paymentObj.Payment_Ref_Number__c = transactionStatus.payKey;
            //System.debug('transactionStatus.errorMessage  2333333 ' + transactionStatus);
            DataBase.SaveResult upRes = Database.update(paymentObj, false);
            return transactionStatus.pgRef;
          } else {
            //Updating Payments Object
            //for(Payment__c pay :paymentObj){
            if (null != paymentObj.BLN_Pay_Gateway__c) {
              paymentObj.credit_card_last_4digits__c = transactionStatus.cardLastDigits;
              paymentObj.credit_card_type__c = transactionStatus.cardType;
              paymentObj.Payment_Ref_Number__c = transactionStatus.transactionId;
              paymentObj.Registration_Type__c = 'Online';
            }
            DataBase.SaveResult upRes = Database.update(paymentObj, false);
            ////System.debug('Payment Update '+upRes);
            //}
            pg = new PageReference('/apex/BLN_Success?id=' + sty + '&OrdId=' + encodedCipherText );
            return pg;
          }
        } else {
          if (prevSelectedPaymentGateway != null && prevSelectedPaymentGateway != '')
            SelectedPaymentGateway = prevSelectedPaymentGateway;
          return null;
        }
      }
    } catch (exception er) {
      transactionStatus = new BLN_TrasactionStatus();
      transactionStatus.errorMessage  = String.valueOf(er);
    }
    return null;
  }



//-------------------------------------------------------------------------------- Validating Payment Method End ---------------------------------------------------------------------------------
  public BLN_TrasactionStatus PaymentCall() {
    BLN_TrasactionStatus paymentStatus = new BLN_TrasactionStatus();
    try {
      BLN_Payments_BAL PaymentsBAL = new BLN_Payments_BAL();
      BLN_VariablesCls variablecls = new BLN_VariablesCls();
      if (TotalAmount - DiscountedAmount <= 0) {
        paymentStatus = PaymentsBAL.freePayment();
        //System.debug('Payment Status ' + paymentStatus);
      }
      //System.debug('TotalAmount ' + TotalAmount + 'FeeAmount ' + FeeAmount + 'TaxAmount ' + TaxAmount + 'DiscountedAmount ' + DiscountedAmount + 'eventdexAmount ' + eventdexAmount);
      variablecls.EventId = RegistrationEvent.id;
      variablecls.TotalAmount =  TotalAmount + FeeAmount + TaxAmount - DiscountedAmount;
      //-eventdexAmount;
      variablecls.eventAdminAmount = TotalAmount + TaxAmount - DiscountedAmount - eventdexAmount;
      variablecls.blFeeAmount = FeeAmount + eventdexamount;
      variablecls.buyerFirstname = buyerTicketInn.tktProfileObject.First_Name__c;
      variablecls.buyerLastname = buyerTicketInn.tktProfileObject.Last_Name__c;
      variablecls.Description = RegistrationEvent.Name;
      variablecls.receiverEventdex = BoothLeadsEmail;
      variablecls.CheckNumber = CheckNumber;
      variablecls.EventName = RegistrationEvent.Name;
      if (null != buyerTicketInn.tktProfileObject.TKT_Company__c) {
        variablecls.Company = buyerTicketInn.tktProfileObject.TKT_Company__c;
        if (null != buyerTicketInn.tktProfileObject) {
          variablecls.phone = buyerTicketInn.tktProfileObject.Work_Phone__c;
          variablecls.street1 = buyerTicketInn.workAddress.Address1__c;
          variablecls.street2 = buyerTicketInn.workAddress.Address2__c;
          variablecls.City = buyerTicketInn.workAddress.City__c;
          variablecls.State = buyerTicketInn.workAddress.State__c;
          variablecls.Country = buyerTicketInn.workAddress.Country__c;
          variablecls.Zip = buyerTicketInn.workAddress.Zipcode__c;
        }
      } else {
        variablecls.phone = buyerTicketInn.tktProfileObject.Mobile__c;
        variablecls.street1 = buyerTicketInn.homeAddress.Address1__c;
        variablecls.street2 = buyerTicketInn.homeAddress.Address2__c;
        variablecls.City = buyerTicketInn.homeAddress.City__c;
        variablecls.State = buyerTicketInn.homeAddress.State__c;
        variablecls.Country = buyerTicketInn.homeAddress.Country__c;
        variablecls.Zip = buyerTicketInn.homeAddress.ZipCode__c;
      }
      for (TicketInnerClass tclist : TicketList ) {
        if (tclist.tktProfileObject.Email__c == buyerTicketInn.tktProfileObject.Email__c) {
          if (tclist.workAddress.Address1__c != null && tclist.workAddress.Address1__c != '') {
            variablecls.phone = tclist.tktProfileObject.Work_Phone__c;
            variablecls.street1 = tclist.workAddress.Address1__c;
            variablecls.street2 = tclist.workAddress.Address2__c;
            variablecls.City = tclist.workAddress.City__c;
            variablecls.State = tclist.workAddress.State__c;
            variablecls.Country = tclist.workAddress.Country__c;
            variablecls.Zip = tclist.workAddress.Zipcode__c;
          } else {
            variablecls.phone = tclist.tktProfileObject.Mobile__c;
            variablecls.street1 = tclist.homeAddress.Address1__c;
            variablecls.street2 = tclist.homeAddress.Address2__c;
            variablecls.City = tclist.homeAddress.City__c;
            variablecls.State = tclist.homeAddress.State__c;
            variablecls.Country = tclist.homeAddress.Country__c;
            variablecls.Zip = tclist.homeAddress.ZipCode__c;
          }
          break;
        } else
          break;
      }
      if (SelectedPaymentGateway != 'paypal' ) {
        variablecls.CreditCardNumber = CreditCardNumber;
        variablecls.Selectedyear = Selectedyear;
        variablecls.SelectedMonth = SelectedMonth;
        variablecls.CVVNumber = CVVNumber;
        variablecls.Module = 'Online';
        variablecls.BoothleadsFee = false;
        variablecls.currencyCode = registrationEvent.BLN_Country__r.Currency__r.Name;
        variablecls.ANLoginId = ANLoginId;
        variablecls.ANTransactionKey = ANTransactionKey;
      } else {
        if (SelectedPaymentGateway == 'paypal') {
          variablecls.payKeyDuration = 'PT' + String.valueOF(SessionTime - (SessionTime - timerValue)) + 'M';
          variablecls.Memo = registrationEvent.Name;
          variablecls.receiverEventdex = BoothLeadsEmail;
          variablecls.receiverEventAdm = PayeeEmail;
          variablecls.FeesPayer = FeesPayer;
        }
      }
      // Stripe Payment
      if (SelectedPaymentGateway == 'Credit Card' && StripeRefreshToken != NULL) {
        //System.debug('Stripe' + CreditCardNumber);
        PayGatewayMode = 'Stripe';
        // Get Event Payment Gateways from Event PayGateway DAO
        BLN_EventPayGateway_DAO EventPayGatewayDAO = new BLN_EventPayGateway_DAO();
        LIST<Event_Pay_Gateway__c> EventPayGateWays = EventPayGatewayDAO.getEventPayGateWaysbasedonmodule(variablecls.EventId, 'Online');
        String adaptivetype = '';
        for (Event_Pay_Gateway__c epg : EventPayGateWays) {
          if (epg.Pay_Gateway__r.PGateway_Type__r.Name == 'Stripe') {
            adaptivetype = epg.Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c;
            variablecls.StripeRefreshToken = epg.Pay_Gateway__r.PG_Signature__c;
            variablecls.StripePaymentId = epg.Pay_Gateway__r.Id;
            variablecls.passsecret = epg.Pay_Gateway__r.PG_Pass_Secret__c;
            variablecls.StripeAccessToken = epg.Pay_Gateway__r.PG_User_Key__c;
          }
        }

        if (adaptivetype == 'Direct')
          paymentStatus = PaymentsBAL.stripeDirectCall(variablecls);
        else
          paymentStatus = PaymentsBAL.stripeAdaptiveCall(variablecls);
        //System.debug('paymentStatus   For Stripe ' + paymentStatus);

      } else if (SelectedPaymentGateway == 'Credit Card' && ANLoginId != NULL && ANTransactionKey != NULL) {
        paymentStatus = PaymentsBAL.authoriZationCall(variablecls);
        //System.debug('paymentStatus   For Stripe ' + paymentStatus);
      } else if (SelectedPaymentGateway == 'Check') { // Check Payment
        PayGatewayMode = 'Check';
        paymentStatus = PaymentsBAL.checkPayment(variablecls);

      } else if (SelectedPaymentGateway == 'Cash') {
        PayGatewayMode = 'Cash';
        paymentStatus = PaymentsBAL.cashPayment(variablecls);
      } else if (SelectedPaymentGateway == 'CreditCardPayPalDirect') {
        SelectedPaymentGateway = 'Credit Card';
        payGatewayMode = 'PayPal';
        paymentStatus = PaymentsBAL.paypalDirectCall(variablecls);
        return paymentStatus;
      } else if (SelectedPaymentGateway == 'CreditCardTrustCommerceDirect') {
        SelectedPaymentGateway = 'Credit Card';
        payGatewayMode = 'TrustCommerce';
        paymentStatus = PaymentsBAL.trustCommercewithoutHost(variablecls);
        return paymentStatus;
      } else if (SelectedPaymentGateway == 'PayPal') { // PayPal Payment
        PayGatewayMode = 'PayPal';
        blob eveuyE = Blob.valueOf(variablecls.EventId);
        String eventidAfterEncoding = EncodingUtil.base64Encode(eveuyE );
        variablecls.CancelUrl = Label.SiteURL + '/BLN_RegistrationDym?id=' + variablecls.EventId;
        variablecls.ReturnUrl = Label.SiteURL + '/BLN_Success?id=' + eventidAfterEncoding ;
        paymentStatus = PaymentsBAL.paypalAdaptive(variablecls);
      } else if (SelectedPaymentGateway == 'TrustCommerce') {
        PayGatewayMode = 'TrustCommerce';
        paymentStatus = PaymentsBAL.trustCommerce(variablecls);
      }
    } catch (exception er) {
    }
    return paymentStatus;
  }

//Setting cookie Values
  public Void setCookieValues() {
    // BLN_SchedlerCallClass scCls1 = new BLN_SchedlerCallClass();
    Blob key = Blob.valueOf(orderId);
    encodedCipherText = EncodingUtil.base64Encode(key);
    if (null != EventId) {
      blob eveuy = Blob.valueOf(EventId);
      sty = EncodingUtil.base64Encode(eveuy);
      Cookie trustcommerceeventnid = new Cookie('trustcommerceeventnid', EventId, null, -1, false);
      ApexPages.currentPage().setCookies(new Cookie[] {trustcommerceeventnid });
    }
    Cookie orderIdvalue = new Cookie('OrderId', encodedCipherText, null, -1, false);
    ApexPages.currentPage().setCookies(new Cookie[] {orderIdvalue });
    try {
      if (null != Visib) {
        Cookie visibleType = new Cookie('visibleType', Visib, null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {visibleType });
      } else {
        Cookie visibleType = new Cookie('visibleType', '', null, -1, false);
        ApexPages.currentPage().setCookies(new Cookie[] {visibleType });
      }
    } catch (exception rt ) {
      Cookie visibleType = new Cookie('visibleType', '', null, -1, false);
      ApexPages.currentPage().setCookies(new Cookie[] {visibleType });
    }
    // Setting job id to cookie
    if (abandonScJobId != null && abandonScJobId != '') {
      Cookie scCookie = new Cookie('abnJob', abandonScJobId, null, -1, false);
      ApexPages.currentPage().setCookies(new Cookie[] {scCookie});
    } else {
      Cookie scCookie = new Cookie('abnJob', '', null, -1, false);
      ApexPages.currentPage().setCookies(new Cookie[] {scCookie});
    }
   /* SessionAbn = SessionTime-(SessionTime-timerValue);
       if(transactionStatus.payGatewayName=='trustcommerce')
       scCls1.BLN_SchedlerMethod(120,orderId);
       else
     scCls1.BLN_SchedlerMethod(SessionAbn,orderId);*/
  }


//------------------------------------------------------------------------------ Complete Registration Method Start -----------------------------------------------------------------------------
// This method is fired when complete registration button is clicked
  public BLN_TrasactionStatus completeRegistration() {
    BLN_TrasactionStatus tStatus = new BLN_TrasactionStatus();
    //System.debug('Buyer Information ' + buyerTicketInn);
    // For buyer checking email format
    if (buyerTicketInn.tktProfileObject.Email__c != null) {
      tStatus.errorMessage = BLN_ValidateCreditcard.validateEmail(buyerTicketInn.tktProfileObject.Email__c);
      if ( tStatus.errorMessage == 'Invalid email address!') {
        return tStatus;
      }
    }
    // For attendee checking email format
    for (TicketInnerClass tclist : TicketList ) {
      if (tclist.tktProfileObject.Email__c != null) {
        tStatus.errorMessage = BLN_ValidateCreditcard.validateEmail(tclist.tktProfileObject.Email__c);
        if (tStatus.errorMessage == 'Invalid email address!') {
          return tStatus;
        }
      }
    }
    //System.debug('tktProfileObject   tktProfileObject Email ' + tStatus);

    String ordstatus=Quickbal.insertingTotalorder(ItemList, TicketList, buyerTicketInn, actualAmount, DiscountedAmount, FeeAmount, TaxAmount, totalAmount, mapitemWithFee, mapitemWithDiscount, PromotionOb, SelectedCardType, SelectedPaymentGateway, ChargeId, PayGatewayMode, 'Online', CardNo, '');
    // String ordstatus='';
    if (ordstatus == 'Success') {
      tStatus.orderId = Quickbal.orderId;
    } else {
      tStatus.errorMessage = ordstatus;
    }
    return tStatus;
  }


//------------------------------------------------------------------------------- Complete Registration Method End ------------------------------------------------------------------------------

// ---------------------------------------------------------------------------------- Login User Method Start -----------------------------------------------------------------------------------
  @RemoteAction
  global static GN_User__c login(String EmailAddress, String Password) {
    // Getting User Details from User DAO
    BLN_User_DAO UserDAO = new BLN_User_DAO();
    User LoggedInUser = new User();
    //System.debug('@@@@@@@@@@ ' + EmailAddress + '############### ' + Password);
    LoggedInUser = UserDAO.checkLoggedInUser(EmailAddress, Password);
    //System.debug('   EXISTTTTTTTTTTTTT   ' + LoggedInUser);
    GN_User__c GNUserforbuyer = new GN_User__c();
    if (LoggedInUser != NULL) {
      BLN_Gnuser_DAO  gnuserdao = new BLN_Gnuser_DAO();
      GNUserforbuyer = gnuserdao.existingGnuser(LoggedInUser.UserName);
      ////System.debug('Ticket List: '+GNUserforbuyer);
      if (GNUserforbuyer.Email__c != null && GNUserforbuyer.Default_Company_ID__c != null) {
        List<UC_Role__c> ucr = [SELECT id from UC_Role__c where GN_User__c = :GNUserforbuyer.id and Company__c = :GNUserforbuyer.Default_Company_ID__c and User_Type__c = 'Personal'];
        //System.debug('PPPPPPPPPPPP UCR ' + GNUserforbuyer.Default_Company_ID__c + '   UCR ID ' + ucr );
        if (ucr.size() > 0) {
          GNUserforbuyer.Default_Company_ID__c = null;
        }
      }
      return GNUserforbuyer;
    }
    //System.debug('UUUUUUUUU  ' + GNUserforbuyer);
    return GNUserforbuyer ;
  }

// ------------------------------------------------------------------------------------ Login User Method End --------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------ Logout User Method Start -----------------------------------------------------------------------------------
  public void logout() {
    TicketList = new LIST<TicketInnerClass>();
    LoggedInGNUser = new GN_User__c();
    //buyerTicketInn.EachUser= new GN_User__c();
    LoggedInUser = new User();
    HideLogin = FALSE;
    EmailAddress = '';
    orderNow();

  }
// ------------------------------------------------------------------------------------ Logout User Method End -------------------------------------------------------------------------------------

// ------------------------------------------------------------------------------------ Fetch NAICS Codes Method Start ----------------------------------------------------------------------------
  public void fetchNAICSCodes() {
    NaicsList = new LIST<SelectOption> ();
    NaicsListOfList = new LIST<LIST<SelectOption>> ();
    listOfnaicscodes = new LIST<LIST<NAICS_Code__c>>();
    naicscodeslist = new List<NAICS_Code__c>();
    for (NAICS_Code__c naics : [SELECT id, Name, Description__c FROM NAICS_Code__c]) {
      naicscodeslist.add(naics);
      // NaicsList.add(new selectoption(naics.Name , naics.Name));
      if (naicscodeslist.size() == 999) {
        listOfnaicscodes.add(naicscodeslist);
        NaicsListOfList.add(NaicsList);
        naicscodeslist = new LIST<NAICS_Code__c>();
        NaicsList  = new LIST<selectoption> ();
      }
    }
    //System.debug('KKKKKOOOOOOOOOOPPPPPPP ' + listOfnaicscodes.size());
    if (naicscodeslist.size() > 0) {
      listOfnaicscodes.add(naicscodeslist);
    }
    checkNAICSforEdit = '$$$$';
    if (NaicsList.size() != 0) {
      NaicsListOfList.add(NaicsList);
    }
    //System.debug('KKKKKOOOOOOOOOOPPPPPPP ' + listOfnaicscodes.size());
  }
// ------------------------------------------------------------------------------------ Fetch NAICS Codes Method End ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------- States & Countries Start ----------------------------------------------------------------------------------
  public void countryStates() {
    country = new LIST<Country__c>();
    countryOptions = new LIST<SelectOption>();

    for (Country__c c : [SELECT ID, NAME, Short_Name__c, Long_Name__c, Order__c FROM Country__c ORDER BY Order__c]) {
      countryOptions.add(new SelectOption(c.id, c.Long_Name__c));
      if (c.Short_Name__c == 'US') {
        selectedCountry = c.id;
      }
    }
    //vals.Short_Name__c+'-'+vals.Long_Name__c
    //System.debug('CCCCCCCCC1' + countryOptions);
    stateOptions = new LIST<SelectOption> ();
  }
  public LIST<SelectOption> statesBasedOnCountry() {
    //System.debug('Selected Country ' + selectedCountry);
    stateOptions = new LIST<SelectOption> ();
    stateOptions.add(new SelectOption('', '--None--'));
    for (State__c s : [SELECT ID, NAME, Short_Name__c, Long_Name__c, Country__c, Order__c FROM State__c WHERE Country__c = : selectedCountry]) {
      stateOptions.add(new SelectOption(s.id, s.Short_Name__c + '-' + s.Long_Name__c));
    }
    return stateOptions;
  }
// --------------------------------------------------------------------------------------- States & Countries End ----------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------- Registration Settings Start ---------------------------------------------------------------------------
  public void fetchSettings() {
    LIST<Id> Itemslist = new LIST<Id>();
    ItemsSet = new SET<Id>();
    for (ItemInnerClass iic : ItemList) {
      if (iic.selectedItemQuantity != null) {
        if (Integer.valueOf(iic.selectedItemQuantity) >= 1) {
          Itemslist.add(iic.items.id);
          if (iic.items.Item_Type__r.name == 'Package') {
            Itemslist.add(iic.items.Item_Pool__c);
          }
        }
      }
    }
    ItemsSet.addAll(Itemslist);
    // Getting Registration Settings
    BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
    //Item Settings
    RegSettingsMap = RegSettingsBAL.regsettings(ItemsSet, RegistrationEvent.id);
    //Buyer Settings
    BLN_Reg_Settings_DAO regDao=new BLN_Reg_Settings_DAO();
    List<Reg_Setting__c> regSettingsover = regDao.setsResevent('Buyer',RegistrationEvent.id);
  
   List<Reg_Setting__c> regSettings =regDao.setsResDefaultEvent('Buyer');
                for(Reg_Setting__c reg:regSettingsover)
                 {
                 for(integer i=0;i<regSettings.size();i++)
                 {
                   if(reg.Defaullt_Label__c==regSettings[i].Defaullt_Label__c)
                   {
                     regSettings[i]=reg;
                   }
                 } 
                }
       List<Reg_Setting__c> regs=new List<Reg_Setting__c>();
     for(integer i=0;i<regSettings.size();i++)
                 {
                   if(regSettings[i].included__c==true)
                   regs.add(regSettings[i]);
                 }  
    buyerTicketInn.settingsForbuyer= regs;
     /*for (Id ItemReg : Itemslist) {
      LIST<Reg_Setting__c> RSList = RegSettingsMap.get(ItemReg);
    }*/

    // Getting Survey Questions
    BLN_SurveyQuestions_BAL SurveyBAL = new BLN_SurveyQuestions_BAL();
    BLN_SurveyQuestions_DAO surveyDao = new BLN_SurveyQuestions_DAO();
    QuestionsItemMap = surveyDao.getItemQ(ItemsSet, RegistrationEvent.id);
    BLN_SurveyQuestions_DAO.getQueIdWithQue(RegistrationEvent.id);
    // Getting Event Level Survey Questions
    EventQuestions = surveyDao.getEveQuestions(RegistrationEvent.id);
  }
// ----------------------------------------------------------------------------------------- Registration Settings End ----------------------------------------------------------------------------
// Get Company Names

  @RemoteAction
  global static List<Company__c> getCompanies(string searchstr, string emailid) {
    SET<id> comids = new SEt<id>();
    for (UC_Role__c uc : [select id, Company__r.name, Company__c, name from UC_Role__c where GN_User__r.email__c = :emailid and User_Type__c != 'Personal']) {
      comids.add(uc.Company__c);
    }
    string v =  searchstr   + '%';
    return [select id, name, Description__c, Website_URL__c from Company__c where id In :comids and name like :v ] ;
  }

  public string checkCompany(string cname) {
    LIST<Company__c> UCRoleList = new List<Company__c>();
    if (cname != '' && cname != null) {
      UCRoleList = [SELECT id from Company__c where id = :cname];
    }
    if (UCRoleList.size() > 0) {
      return UCRoleList[0].id;
    } else {
      return '';
    }

  }
  public string checkPersonalAccount(string uEmail) {
    LIST<UC_Role__c> UCRoleList = [SELECT id, Company__c, Company__r.id FROM UC_Role__c WHERE GN_User__r.Email__c = :uEmail and User_Type__c = 'Personal'];
    if (UCRoleList.size() > 0) {
      return UCRoleList[0].Company__r.id;
    } else {
      return '';
    }
  }


  public boolean detailsbool {get ; set ;}
  public void cpmdetails() {
    if (selectedcompany != 'none') {
      detailsbool =  true;
    } else {
      detailsbool =  false;
    }
    comextnew  = new Company_Ext__c  ();
    //System.debug('ssssssssssssssssssssssssssssss' + selectedcompany);
    comext = new LIST<Company_Ext__c>();
    compdetails = new Company__c ();
    comext = [SELECT ID, NAME, Business_Address1__c, Business_Address2__c, Business_City__c, BLN_Business_Country__c, BLN_Business_Country__r.Short_Name__c, BLN_Business_State__c, BLN_Business_State__r.Short_Name__c, Business_Zipcode__c, Work_Phone__c, Company__c, Duns_Number__c,
              Established_Date__c, Keywords__c, Number_Of_Employees__c, Primary_NAICS_Code__c, Revenue__c, Secondary_NAICS_Code__c, Tax_Id__c FROM Company_Ext__c where Company__c = : selectedcompany];
    if (comext.size() > 0) {
      comextnew  = comext[0];
      if (comext[0].Primary_NAICS_Code__c != NULL) {
        checkNAICSforEdit += comextnew.Primary_NAICS_Code__c;
      }
      if (comext[0].Secondary_NAICS_Code__c != NULL) {
        checkNAICSforEdit += comextnew.Secondary_NAICS_Code__c;
      }
      countryStates();
    }
    try {
      if (selectedcompany != null && selectedcompany != '') {
        compdetails = [select  ID, NAME, Website_URL__c, Description__c, Company_Logo__c from Company__c where id = : selectedcompany];
      } else {
        compdetails = new Company__c();
      }
    } catch (exception ex) {}
  }

  @RemoteAction
  global static Company_Ext__c getCompaniesext(string searchstr) {
    return [select Tax_Id__c, id, company__c, Blog_URL__c, Business_Address1__c, Business_Address2__c, Business_City__c, BLN_Business_Country__c, BLN_Business_State__c, Business_Zipcode__c, Work_Phone__c, Secondary_NAICS_Code__c, Revenue__c, Primary_NAICS_Code__c, Primary_Business_Category__c, Number_Of_Employees__c, Established_Date__c, Keywords__c, Duns_Number__c from Company_Ext__c where Company__c  = :searchstr limit 1 ] ;
  }

  @RemoteAction
  global  static List<Company__c> getCompanieswithid(string cid, string d) {
    //System.debug('AAAAAAAAAAAaa ' + cid);
    return [select id, name, Description__c, Website_URL__c from Company__c where id = :cid ] ;
  }

  @RemoteAction
  global static List<SObject> statesBasedOnCountry(String country) {
    //eventCurrency =  Currencies;
    return [SELECT ID, NAME, Short_Name__c, Long_Name__c, Country__c FROM State__c WHERE Country__c = : country];
  }
   
    //builds a picklist of values based upon the passed information
    public static List<selectOption> getPickValues(Sobject object_name, String field_name, String first_val) {
        //System.debug('111111111111111:'+object_name);
        //System.debug('222222222222222222:'+field_name);
        //System.debug('333333333333333:'+first_val);
        List<selectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
        if ( first_val != null ) { //if there is a first value being provided
            options.add(new selectOption(first_val, first_val)); //add the first option
        }
        Schema.sObjectType sobject_type = object_name.getSObjectType(); //grab the sobject that was passed
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        List<Schema.PicklistEntry> pick_list_values = field_map.get(field_name).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
            options.add(new selectOption(a.getLabel(), a.getValue()));  //add the value and label to our final list
        }
        return options; //return the List
    }
    
    
    //return the picklist options for users timezone
   @RemoteAction
    global static List<selectOption> getPrefixes() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Prefix__c', null);
    }
    @RemoteAction
    global static List<selectOption> getSuffixes() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Suffix__c', null);
    }
    @RemoteAction
    global static List<selectOption> getPrimaryBusinessCategory() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Primary_Business_Category__c', null);
    }
    @RemoteAction
    global static List<selectOption> getSecondaryBusinessCategory() {
    Tkt_Profile__c tktProfileObject = new Tkt_Profile__c();
        return getPickValues(tktProfileObject,'Secondary_Business_Category__c', null);
    }
     
   
   
   
   public PageReference  Complete_Registration()
   {
  BLN_AttendeeRegistration_Bean bean=new BLN_AttendeeRegistration_Bean();
   
   String buyerinform=apexpages.currentpage().getparameters().get('buyerinform');
   if(buyerinform!=null&&buyerinform!='')
   buyerTicketInn=bean.parseBuyer(buyerinform,buyerTicketInn);
   
   String attendeeinform=apexpages.currentpage().getparameters().get('attendeeinform');
   if(attendeeinform!=null&&attendeeinform!='')
   TicketList=bean.parseAttendee(attendeeinform,TicketList);
   
   validatePayment(); 
   return null;
   } 
   
  public boolean EnablePoller{get;set;}
  public BLN_RegistrationnewCon3 getController() {
        return this;
    }
    
    //uday code 
    
  @RemoteAction

global static list<BLN_Template__c> getIndividualwidgets(String evid,String maintemplateid)
{


list<BLN_Template__c> allwidgets = [select id,HTML__c,Template_Name__c from BLN_Template__c where BLN_Reg_Main_Template__c=:maintemplateid];

return allwidgets ;

}
@RemoteAction

global static BLN_Reg_Main_Template__c getsecondpagehtml(String selectedevent,String thename)
{
return [select id,name,Data__c from BLN_Reg_Main_Template__c where BLN_Events__c=:selectedevent AND Theme_Name__c=:thename AND structure_type__c='Registration Page'];
}


    public pagereference getSpeakerList(){
    
        //DateTime dt = DateTime.Now().AddDays(30);
        ////System.debug('EventId-' + EventId);
        speakerList = BLN_Utill_BAL.getSpeakers(selectedevent, null);
        //System.debug('SpeakerList-' + speakerList);
        return null;
    }

public pagereference getSponsorList(){
    
        //DateTime dt = DateTime.Now().AddDays(30);
        ////System.debug('EventId-' + EventId);
        sponsorList = BLN_Utill_BAL.getSponsors(selectedevent, null);
        //System.debug('SponsorList-' + sponsorList);
        return null;
    }
    
    @RemoteAction

global static String contactOrganiser(String orgemailid,String fname,String lname,String Emailadd,String Description)
{
 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
      // Step 2: Set list of people who should get the email
      List<String> sendTo = new List<String>();
      sendTo.add(orgemailid);
      mail.setToAddresses(sendTo);
    
      // Step 3: Set who the email is sent from
  
    
      // (Optional) Set list of people who should be CC'ed
     List<String> ccTo = new List<String>();
     ccTo.add('udaykiran.bussa@globalnest.com');
     mail.setCcAddresses(ccTo);

      // Step 4. Set email contents - you can use variables!
      mail.setSubject('Attendee Want to Contact you');
      String body = 'Hello organiser ';
      body+= 'Mr. '+fname+' '+lname;
      body+='Want to contact you';
      body +='<br/> '+Emailadd;
       body +='<br/> <br/> <br/> <br/> '+Description;
      body+= '<br/>Thank You';
      mail.setHtmlBody(body);
    
      // Step 5. Add your email to the master list
     // mails.add(mail);
   
  // Step 6: Send all emails in the master list
 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });


return 'success';
}
public list<Agenda__c> Allagenda{get;set;}

public void agendalist()
{
Allagenda = new list<Agenda__c>();

 BLN_Seminars_DAO semDAO = new BLN_Seminars_DAO();
        Allagenda=semDAO.allSemiorItemsList(selectedevent );
        //System.debug('Allagenda==='+Allagenda);

}

public String addwidgets {get;set;}
public void AddedWidgets()
{
addwidgets = '';
List<BLN_Template__c> selectedwidgets = [select id, Template_Name__c,BLN_Reg_Main_Template__r.Theme_Name__c from BLN_Template__c where BLN_Reg_Main_Template__r.Theme_Name__c =:template.Theme_Name__c AND BLN_Events__c=:selectedevent ];
for(BLN_Template__c bt:selectedwidgets)
{
addwidgets += bt.Template_Name__c+',';

}

}
@RemoteAction
global static void signupfromregpage(String fname,String lname,String company,String email,String password)
{

BLN_SignUpCon supcon = new BLN_SignUpCon();
    supcon.ASUserEmail = email;
    supcon.ASLastName = lname;
    supcon.ASFirstName = fname;
    if(company !='0668A000000090V'){
    supcon.ASCompanyName = company;}
    else{
    
    }
    supcon.password = password;
    supcon.BLS_SignUpUser();
}


}