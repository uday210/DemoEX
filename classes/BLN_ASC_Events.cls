/***********************************************************************************************
*   Service Name : BLN_ASC_Events
*   Date            :
*   Author          :
*   Purpose         :
*  Modified BY:ARINDAM,payment settings for scanattendee,16-02-2015
************************************************************************************************/



@RestResource(urlMapping = '/BLN_ASC_Events/*')

global class BLN_ASC_Events {
  global static List<Container> ct {get ; set ;}
  global static profile_info ct1 {get ; set ;}
  global static List<Currency__c> ct4 {get ; set;}
  global static List<UpcomingEvents> ct3 {get ; set ;}
  global static List<ItemType_info> ct2 {get ; set ;}
  global static maincontainer MC {get ; set ;}
  global static string uemailid {get ; set ;}
  global static DateTime moddate {get ; set ;}
  global Static MAP<id, Integer> mapEvIdWithSessionTime;
  global static String refresheventid {get; set;}
  global static String formatedDt {get; set;}
  global Static BLN_Session_BAL sesBal {get; set;}
//global static BLN_UserEvents EventsList {get ; set ;}
  @HttpPost
  global static maincontainer  doPost() {
    boolean IsFullAdmin = false;
    Boolean isScanattUser = false;
    String siteurl = Label.SiteURL;
    RestRequest req = RestContext.request;
    ct = new List<Container> ();
    ct3 = new List<UpcomingEvents> ();
    ct4 = new List<Currency__c> ();
    mc = new maincontainer ();
    sesBal = new BLN_Session_BAL();
    String Uid = req.params.get('User_id');
    String appname = req.params.get('appname').toUpperCase();
    
    system.debug(':::::::::::::::' + appname);
    User U = [select Email, Firstname, Lastname, CompanyName, Username from User where id = : uid];
    uemailid = U.Email;
   string currencycodes='';
   ct4=[select id, name, Currency_Name__c, Currency_Symbol__c from Currency__c];
    MAP<id,boolean> mapEventWithScan =new MAP<id,boolean>();   
   
   
    

    list<UC_Role__c> UCRoles = new list<UC_Role__c> ();
    list<UC_Role__c> UCRoles1 = new list<UC_Role__c> ();
    list<BLN_Event__c> EventsList = new list<BLN_Event__c> ();
    list<BLN_Event__c> EventsList1 = new list<BLN_Event__c> ();
    LIST<id> ids = new LIST<id> ();
    BLN_Events_BAL eventsBAL = new BLN_Events_BAL();
    system.debug('eventlist:' + EventsList + 'uid:' + Uid);
    Map<string, BLN_Event__c> EventsMap = new Map<string, BLN_Event__c>();
    SET<BLN_Event__c> EventsSet = new SET<BLN_Event__c> ();
    //Here it will add attendeesummery and GNUSER for Existing and new user for both apprun with out crash
    AttendeeSummary_BAL  AttBal = new AttendeeSummary_BAL ();
    AttendeeSummary_Dao  attDao = new AttendeeSummary_Dao ();
    BLN_Gnuser_DAO GNDAO = new BLN_Gnuser_DAO ();
    GN_User__c GNUSER = new GN_User__c();
    Set<Id> eventid = new Set<Id>();
    try {
      GNUSER = GNDAO.existingGnuser(uemailid);
    } catch (exception e) {
      AttBal.AssignValToGnu(attDao.attSum(uemailid)) ;
      GNUSER = GNDAO.existingGnuser(uemailid);
    }
    system.debug('::::::::::::::::::::::::GN USER::::::::::::' + GNUSER );
    if (refresheventid != null && refresheventid != '') { //used by asc_refresh service
      BLN_Event_dao evdao = new BLN_Event_DAO();
      String q = '';
      if (formatedDt != null && formatedDt != '')
        q = 'SELECT scan_attendee_limit__c,BLN_Country__r.Currency__r.Name,organizer_id__c,owner.Name,Event_Ticket_Options__c, is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c, State__c,Start_Date__c,End_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c,PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,Registration_Template__c,Description__c,Country__c, City__c ,CreatedBy.Name,BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Currency__r.Currency_Symbol__c,Tax_Rate__c,Accept_Tax_Rate__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c,Language_Settings__c,Event_Blog_URL__c,owner.userName,(select Registration_Type__c,Pay_Gateway__r.use_host_page__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r),organizer_id__r.owner.id,AllowNoticketSessions__c FROM BLN_Event__c WHERE id =\'' + refresheventid + '\' or lastmodifieddate>=' + formatedDt ;
      else
        q = 'SELECT scan_attendee_limit__c,BLN_Country__r.Currency__r.Name,organizer_id__c,owner.Name,Event_Ticket_Options__c, is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c, State__c,Start_Date__c,End_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c,PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,Registration_Template__c,Description__c,Country__c, City__c ,CreatedBy.Name,BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Currency__r.Currency_Symbol__c,Tax_Rate__c,Accept_Tax_Rate__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c,Language_Settings__c,Event_Blog_URL__c,owner.userName,(select Registration_Type__c,Pay_Gateway__r.use_host_page__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r),organizer_id__r.owner.id,AllowNoticketSessions__c FROM BLN_Event__c WHERE id =\'' + refresheventid + '\'';
      EventsList = database.query(q);
      for (BLN_Event__c BLS : EventsList) {
        ids.add(bls.id);
      }
     for(BLN_Scanusr_item__c scn : DataBase.query('select id,BLN_Event__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__c=:uid and lastmodifieddate>='+formatedDt +' AND BLN_Event__c=:refresheventid')){
       ids.add(scn.BLN_Event__c);
        mapEventWithScan.put(scn.BLN_Event__c,true);
      } 
    } else {
      EventsList = eventsBAL.listOfEvents(uid);
      for (BLN_Event__c BLS : EventsList) {
        ids.add(bls.id);
      }
    }  
    LIST<Ticket__c> tics = new LIST<Ticket__c>();
  //String tcQuery = SELECT id, Event__c, Item_type__r.Name FROM Ticket__c WHERE TKT_profile__r.BLN_GN_User__c '+ id =\'' + refresheventid + '\' or lastmodifieddate>=' + formatedDt
    if (refresheventid != null && refresheventid != '')
     tics= DataBase.Query('SELECT id, Event__c, Item_type__r.Name FROM Ticket__c WHERE TKT_profile__r.BLN_GN_User__c = \''+GNUSER.id+'\' AND Event__r.id =\'' + refresheventid + '\' AND Event__r.lastmodifieddate>=' + formatedDt);
   else
    tics= [SELECT id, Event__c, Item_type__r.Name FROM Ticket__c WHERE TKT_profile__r.BLN_GN_User__c = : GNUSER.id ];
  
     System.debug(' JJJJJJJJJJ '+tics.size());
      for (Ticket__c GNTICS : tics) {
        ids.add(GNTICS.Event__c);
        eventid.add(GNTICS.Event__c);
        System.debug(' HHHHHHHHHH HHHHHHH '+GNTICS.Item_type__r.Name +'  '+GNTICS.id);
        if (GNTICS.Item_type__r.Name == 'Scan Attendee')
           mapEventWithScan.put(GNTICS.Event__c,true);
      }
    //}

    System.debug('Idessssssssssssssssss ' + mapEventWithScan);
    LIST<BLN_Event__c> ListofEvents = [SELECT  AllowNoticketSessions__c,Name, Venue_Name__c, ZipCode__c, Website_Url__c,  User_Company__c, organizer_id__r.Name, organizer_id__r.PG_Authorization_Key__c, organizer_id__r.PG_Authorization_Card_Type__c, organizer_id__r.PG_Authorization_CC_Last_four_Digit__c, organizer_id__r.PG_Credit_Card_Overwrite__c,
                                       Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, Street2__c, Street1__c,
                                       Start_Date__c, Social_Hashtag__c, Phone_Number__c, Password__c,
                                       PO_Box__c, Organizer_Email__c, Logo_URL__c, IsDeleted, Id,
                                       Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c,
                                       Description__c, BLN_Country__r.Name, City__c ,
                                       BLN_State__r.Name, Show_Terms_Checkbox__c,
                                       Tax_Rate__c, Accept_Tax_Rate__c, organizer_id__c, Terms_Conditions__c, Accept_Terms_Conditions__c, Accept_Refund_Policy__c, Refund_Policy__c, LinkedIn_URL__c, Event_Blog_URL__c
                                       , (Select id, Name, BL_Fee_Percentage__c, BL_Fee_Amount__c, Max_bl_fee__c, Eventdex_Product__c, Item_type__c from Event_Price__r), (select  Name From BadgeTemplate_Styles__r Where Mobile_Default_Badge__c = true ), (select  Description__c From BLN_Badge_Styles__r Where Mobile_Default_Badge__c = true ), scan_attendee_limit__c, (select id, name, Event__c, Table_Name__c, Column_Name__c, Label_Name__c, Setting_Type__c, Order__c, Included__c from Reg_Settings__r where (Table_Name__c = 'Item_Type__c' and Included__c = true and Setting_Type__c = 'Mobile'))
                                       , (select id, name, Registration_Type__c, Pay_Gateway__r.PGateway_Type__r.Name, Pay_Gateway__r.PG_Email_Id__c, Pay_Gateway__r.PG_Pass_Secret__c, Pay_Gateway__r.PG_Signature__c, Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r), (select id, Ticket_Status__c from tickets__r where Ticket_Status__c = 'Booked')
                                       , (select id from orders__r), (SELECT BLN_GN_User__c, BLN_Item_Pool__c, Status__c, BLN_Event__c FROM BLN_Scanusr_items__r Where Status__c='Active' AND BLN_GN_User__c=:GNUSER.id ) FROM BLN_Event__c WHERE id IN : ids AND Event_Status__c != 'Deleted'];

    for (BLN_Event__c event : ListofEvents ) {
      EventsSet.add(event);
    }
    UCRoles    = eventsBAL.roles(uid);
    if (UCRoles.size() > 0) {
      if (UCRoles[0].RoleId__r.name != null) {
        if (UCRoles[0].RoleId__r.name == 'Full Admin') {
          IsFullAdmin = true;
        }
      }
    }
    SET<id> eidset = new set<id> ();
    for (UC_Role__c UR : UCRoles) {
      if (eidset.add(UR.Event__r.id)) {
        UCRoles1.add(UR);
      }
    }
    system.debug('mmmmmmmmmmmmmmmmmmmmmmmm' + ListofEvents );
    string orgid = UserInfo.getOrganizationId();
    system.debug('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn222');
    List<BLN_Event__c> evslist = new List<BLN_Event__c> ();
    mapEvIdWithSessionTime = new MAP<id, integer>();
    if (appname != 'EVENTDEX') {
      list<Reg_Setting__c> regseting_sestime =  [select id, Event__c, Order__c FROM Reg_Setting__c WHERE (Setting_Type__c = : 'Display' AND Column_Name__c = : 'Time Out' AND Included__c = : TRUE AND Order__c != NULL) AND  Event__r.ID IN:EventsSet];
      for (Reg_Setting__c rge : regseting_sestime) {
        mapEvIdWithSessionTime.put(rge.Event__c, integer.valueof(rge.Order__c));

      }
      Map<String,String> selcountrymap=new Map<String,String>();
      for(BLN_Event_Countries_Include__c beci:[select id,name,BLN_Country__r.name,BLN_Event__c from BLN_Event_Countries_Include__c where BLN_Event__c in:EventsSet])
      {
         if(selcountrymap.containsKey(beci.BLN_Event__c))
         {
           String existname=selcountrymap.get(beci.BLN_Event__c);
           existname+=','+beci.BLN_Country__r.name;
           selcountrymap.put(beci.BLN_Event__c ,existname);
         }
         else         
         selcountrymap.put(beci.BLN_Event__c ,beci.BLN_Country__r.name);
      }
      
      
      for (BLN_Event__c evs : EventsSet) {
        System.debug(' UUUUUUUUU '+evs+'  mapEventWithScan '+mapEventWithScan);
        string sdate = '';
        string edate = '';
        if (evs.Start_Date__c != null && evs.End_Date__c != null && evs.Time_Zone__c != null) {
          sdate = evs.Start_Date__c.format('yyyy-MM-dd hh:mm a', evs.Time_Zone__c);
          edate = evs.End_Date__c.format('yyyy-MM-dd hh:mm a', evs.Time_Zone__c);
        }
        SET<ID> UCREVID = new SET<ID>();
        for (UC_Role__c uu : UCRoles) {
          if (uu.Company__r.id == evs.organizer_id__r.id || IsFullAdmin == true || mapEventWithScan.containsKey(evs.id)) {
            if (UCREVID.add(uu.Event__c)) {
              evslist.add(evs);
              if(uu.Company__r.id == evs.organizer_id__r.id)
               ct.add(new Container(evs,selcountrymap.get(evs.id), uu.RoleId__r.Name, evs.organizer_id__r.Name, evs.BLN_Country__r.Name, evs.BLN_State__r.Name, siteurl + '/servlet/servlet.ImageServer?id=' + evs.Logo_URL__c + '&oid=' + orgid, siteurl + '/BLN_Registration_Eventdex?id=' + evs.id, sdate, edate)); //,sdate,edate
               else
                ct.add(new Container(evs,selcountrymap.get(evs.id), 'Attendee', evs.organizer_id__r.Name, evs.BLN_Country__r.Name, evs.BLN_State__r.Name, siteurl + '/servlet/servlet.ImageServer?id=' + evs.Logo_URL__c + '&oid=' + orgid, siteurl + '/BLN_Registration_Eventdex?id=' + evs.id, sdate, edate)); //,sdate,edate
              }
          }
        }
      }
      System.debug('BBBBBBBBBBBBB ' + ct.size());
      //only needed for scanattendee
      mc.PGatewaytypes = new List<PGateway_Type__c>();
      mc.PGatewaytypes = [SELECT Id, Name, Display_Type__c, Help_Text__c, Image_URL__c, Online_Flag__c, Onsite_Flag__c, ScanAttendee_Flag__c, Adaptive_Type__c FROM PGateway_Type__c where ScanAttendee_Flag__c = true];
      mc.PayGateways = new List<Pay_Gateway__c>();
      mc.PayGateways = [SELECT Id, Name, BLN_GN_User__c, Company__c, Company__r.Name, Paygateway_name__c, PGateway_Type__c, PGateway_Type__r.Name, PG_Email_Id__c, PG_Pass_Secret__c, PG_Signature__c, PG_User_Key__c, PP_Fee_Payer__c, PP_Payment_Type__c FROM Pay_Gateway__c where BLN_GN_User__c = :GNUSER.id order by Company__c];
    } else {
      //Sending MyTickets Event
      List<order__c> myorder = [select id, name, Events__c, BLN_TKT_profile__r.BLN_GN_User__r.User__c from Order__c where BLN_TKT_profile__r.BLN_GN_User__r.User__c = :uid AND order_type__c!='EVENT PRODUCER'];
      for (order__c o : myorder) {
        eventid.add(o.Events__c);
      }
      List<BLN_Event__c> myticketsevent = [SELECT  AllowNoticketSessions__c,Name, Venue_Name__c, ZipCode__c, Website_Url__c,  User_Company__c, organizer_id__r.Name, organizer_id__r.PG_Authorization_Key__c, organizer_id__r.PG_Authorization_Card_Type__c, organizer_id__r.PG_Authorization_CC_Last_four_Digit__c, organizer_id__r.PG_Credit_Card_Overwrite__c,
                                           Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, Street2__c, Street1__c,
                                           Start_Date__c, Social_Hashtag__c, Phone_Number__c, Password__c,
                                           PO_Box__c, Organizer_Email__c, Logo_URL__c, IsDeleted, Id,
                                           Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c,
                                           Description__c, BLN_Country__r.Name, City__c ,
                                           BLN_State__r.Name,Show_Terms_Checkbox__c,
                                           Tax_Rate__c, Accept_Tax_Rate__c, organizer_id__c, Terms_Conditions__c, Accept_Terms_Conditions__c, Accept_Refund_Policy__c, Refund_Policy__c, LinkedIn_URL__c, Event_Blog_URL__c
                                           , (Select id, Name, BL_Fee_Percentage__c, BL_Fee_Amount__c, Eventdex_Product__c, Max_bl_fee__c, Item_type__c from Event_Price__r), (select  Name From BadgeTemplate_Styles__r Where Mobile_Default_Badge__c = true ), (select  Description__c From BLN_Badge_Styles__r Where Mobile_Default_Badge__c = true ), scan_attendee_limit__c, (select id, name, Event__c, Table_Name__c, Column_Name__c, Label_Name__c, Setting_Type__c, Included__c from Reg_Settings__r where Table_Name__c = 'Item_Type__c' and Included__c = true and Setting_Type__c = 'Mobile')
                                           , (select id, name, Registration_Type__c, Pay_Gateway__r.PGateway_Type__r.Name, Pay_Gateway__r.PG_Email_Id__c, Pay_Gateway__r.PG_Pass_Secret__c, Pay_Gateway__r.PG_Signature__c, Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r), (SELECT BLN_GN_User__c, BLN_Item_Pool__c, Status__c, BLN_Event__c FROM BLN_Scanusr_items__r Where Status__c='Active'  AND BLN_GN_User__c=:GNUSER.id) FROM BLN_Event__c WHERE id IN : eventid AND Event_Status__c != 'Deleted'];
      System.debug('Other person buy tickets ' + myticketsevent);
      Map<String,String> selcountrymap=new Map<String,String>();
      for(BLN_Event_Countries_Include__c beci:[select id,name,BLN_Country__r.name,BLN_Event__c from BLN_Event_Countries_Include__c where BLN_Event__c in:eventid])
      {
         if(selcountrymap.containsKey(beci.BLN_Event__c))
         {
           String existname=selcountrymap.get(beci.BLN_Event__c);
           existname+=','+beci.BLN_Country__r.name;
           selcountrymap.put(beci.BLN_Event__c ,existname);
         }
         else         
         selcountrymap.put(beci.BLN_Event__c ,beci.BLN_Country__r.name);
      }
      for (BLN_Event__c evs : myticketsevent) {
        string sdate = '';
        string edate = '';
        if (evs.Start_Date__c != null && evs.End_Date__c != null && evs.Time_Zone__c != null) {
          sdate = evs.Start_Date__c.format('yyyy-MM-dd hh:mm a', evs.Time_Zone__c);
          edate = evs.End_Date__c.format('yyyy-MM-dd hh:mm a', evs.Time_Zone__c);
        }
        String rolename = '';
        for (UC_Role__c uu : UCRoles) {
          if (uu.Event__r.id == evs.id) {
            rolename = uu.RoleId__r.Name; //if other person buys the ticket
            break;
          } else if (uu.Company__r.id == evs.organizer_id__r.id || IsFullAdmin == true ) {
            rolename = uu.RoleId__r.Name; //if owner himself buys the ticket
          }
        }
        System.debug('YYYYYYYYYYYYYYYY ' + evs.id);
        ct.add(new Container(evs,selcountrymap.get(evs.id), rolename, evs.organizer_id__r.Name, evs.BLN_Country__r.Name, evs.BLN_State__r.Name, siteurl + '/servlet/servlet.ImageServer?id=' + evs.Logo_URL__c + '&oid=' + orgid, siteurl + '/BLN_Registration_Eventdex?id=' + evs.id, sdate, edate)); //,sdate,edate
      }
      LIST<BLN_Event__c> ListofEventsupcoming = new LIST<BLN_Event__c>();
      /* [SELECT  Name,Venue_Name__c,ZipCode__c, Website_Url__c,  User_Company__c,organizer_id__r.Name,organizer_id__r.PG_Authorization_Key__c,organizer_id__r.PG_Authorization_Card_Type__c,organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,organizer_id__r.PG_Credit_Card_Overwrite__c,
                                      Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, Street2__c, Street1__c,
                                      Start_Time__c, Start_Date__c, Social_Hashtag__c,Phone_Number__c, Password__c,
                                      PO_Box__c, Organizer_Email__c,Logo_URL__c, IsDeleted, Id,
                                      Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Time__c, End_Date__c,
                                       Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,
                                      BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c,
                                      Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c,Event_Blog_URL__c
                                     ,(Select id,Name,BL_Fee_Percentage__c,BL_Fee_Amount__c,Max_bl_fee__c,Item_type__c from Event_Price__r),(select  Name From BadgeTemplate_Styles__r ),scan_attendee_limit__c,(select id from orders__r),(select id,Ticket_Status__c from tickets__r where Ticket_Status__c='Booked'),(select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Settings__r where Table_Name__c='Item_Type__c' and Included__c=true and Setting_Type__c='Mobile')
      ,(select id,name,Registration_Type__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r  ) FROM BLN_Event__c WHERE id NOT IN : ids AND Event_Status__c != 'Deleted'];
       */
      //  for(BLN_Event__c evs: ListofEventsupcoming ){



      // ct3.add(new UpcomingEvents(evs,evs.BLN_Country__r.Long_Name__c,evs.BLN_State__r.Long_Name__c,siteurl+'/servlet/servlet.ImageServer?id='+evs.Logo_URL__c+'&oid='+orgid,siteurl+'/BLN_Registration_Eventdex?id='+evs.id));
      //  }
    }

    ct1 = new profile_info();
    GN_User__c gnuserpro = gndao.gettinggnuser(uid);
    String defComp = '';
    /****************************************/
    try {
      list<GN_User__c > gnUsrP = New list<GN_User__c >();
      gnUsrP.add(gnuserpro);
      string title;
      for (GN_User__c gnlist : gnUsrP) {
        for (UC_Role__c ucr : gnlist.UC_Role__r) {
          if (gnlist.Default_Company_ID__c == ucr.Company__c || IsFullAdmin == true ) {
            title = ucr.Title__c;
            defComp = gnlist.Default_Company_ID__c;
          }
        }

      }
      ct1.designation = title;
    } Catch (Exception e) {}
    /***************************************/
    ct1.profile = gnuserpro;
    ct1.profileimage = siteurl + '/servlet/servlet.ImageServer?id=' + gnuserpro.User_Pic__c + '&oid=' + orgid;
    try {
      Company_Ext__c cmpnyExt = gndao.gettingCmpnyExtData(defComp);
      System.debug('Company exception ' + cmpnyExt.BLN_Business_State__r.Long_Name__c + ' Company ' + defComp);
      //enabled on Nov 4th
      ct1.profilestate = cmpnyExt.BLN_Business_State__r.name;
      ct1.profilecountry = cmpnyExt.BLN_Business_Country__r.name;
      ct1.profileCity =  cmpnyExt.Business_City__c;
    } catch (exception ee) {}
    ct1.Userid = uid;
    //For geetting Item types of a default event
    ct2 = new List<ItemType_info>();
    List<Event_Price__c> Eprice = [Select id, Name, BL_Fee_Percentage__c, BL_Fee_Amount__c, Item_type__r.id, Item_type__r.name from Event_Price__c Where Event__r.name = : 'Default Event(Boothleads)'];
    for (Event_Price__c ep : Eprice) {
      ct2.add(new ItemType_info(ep.Item_type__r.name, ep.Item_type__r.id, ep.BL_Fee_Amount__c, ep.BL_Fee_Percentage__c));
    }
    //ct.add(ct1);
    mc.ItemTypes = ct2;
    mc.Events = ct;
    mc.Profile = ct1;
    mc.UpcomingEvents = ct3;
    mc.CurrencyList = ct4;
    try {
      Pay_Gateway__c pg = [select id, name, PG_User_Key__c, PG_Pass_Secret__c, Company__c, PGateway_Type__c, Company__r.name, PGateway_Type__r.name, PGateway_Type__r.Adaptive_Type__c from Pay_Gateway__c where PGateway_Type__r.name = 'Stripe' and Company__r.name = 'EventdexLive' limit 1];
      mc.StripeEventdexClientID = pg.PG_User_Key__c;
      mc.StripeEventdexSecretKey = pg.PG_Pass_Secret__c;
    } catch (Exception e) {}
    System.debug('BBBBBBBBBBBBB 22222222222' + mc.Events);
    //List of sessions to Cancel
    
    return mc;
  }


  global class Container {
    public BLN_Event__c Events {get ; set ;}
    public string roles {get ; set ;}
    public List<BLN_Event__c> ListofEvents {get ; set ;}
    public string state {get ; set ;}
    public string country {get ; set ;}
    public string image {get ; set ;}
    public string company {get ; set ;}
    /* public GN_User__c Profile {get ; set ;}
    public string profileimage{get ; set ;}
    public string profilestate{get ; set ;}
     public string profilecountry {get ; set ;}*/
    public String RegistrationLink {get; set;}
    public integer sessiontime = 30;
    public String lastRefreshDate {get; set;}
    public string startDate {get; set;}
    public string endDate {get; set;}
    public string countrycodes{get;set;}
    //public string BadgeName {get ; set ;}
    public Container(BLN_Event__c ev,String ccodes,string rl, string com, string cu, string st, string img, String reglink, string sdate, string edate) { //,string sdate,string edate
      Events = ev;
      countrycodes=ccodes!=null?ccodes:'';
      roles = rl;
      country = cu;
      state = st;
      image = img;
      company = com;
      this.RegistrationLink = reglink;
      this.startDate = sdate;
      this.endDate = edate;
      if (null != mapEvIdWithSessionTime.get(ev.id))
        this.sessiontime = mapEvIdWithSessionTime.get(ev.id);
      //BadgeName = Bname;
      lastRefreshDate = system.now().formatGMT('yyyy-MM-dd HH:mm:ss');
      //if(ev.Time_Zone__c != null){
      //lastRefreshDate = system.now().format('yyyy-MM-dd hh:mm:ss a',ev.Time_Zone__c);
      //}
    }
    public container() {}
  }

  global class profile_info {
    public GN_User__c Profile {get ; set ;}
    public string Userid {get ; set ;}
    public string profileimage {get ; set ;}
    public string profilestate {get ; set ;}
    public string profilecountry {get ; set ;}
    public string profileCity {get; set;}
    public string designation {get; set;}
  }
 
  global class ItemType_info {
    public string ItemType {get ; set ;}
    public string ItemType_Id {get ; set ;}
    public decimal BL_Fee_Amount {get; set;}
    public decimal BL_Fee_Percentage {get; set;}
    public ItemType_info(string ItemType1, string ItemType_Id1, decimal BL_Fee_Amount1, decimal BL_Fee_Percentage1) {
      ItemType = ItemType1;
      ItemType_Id = ItemType_Id1;
      this.BL_Fee_Amount = BL_Fee_Amount1;
      this.BL_Fee_Percentage = BL_Fee_Percentage1;

    }
    public ItemType_info() {}
  }

  global class UpcomingEvents {
    public BLN_Event__c Events {get ; set ;}
    public string roles {get ; set ;}
    public string state {get ; set ;}
    public string country {get ; set ;}
    public string image {get ; set ;}
    public string company {get ; set ;}
    public String RegistrationLink {get; set;}
    public UpcomingEvents(BLN_Event__c ev, string cu, string st, string img, String reglink) {
      Events = ev;
      country = cu;
      state = st;
      image = img;
      this.RegistrationLink = reglink;
    }
    public UpcomingEvents() {

    }
  }

  global class maincontainer {
    public list<container> Events {get ; set ;}
    public profile_info Profile {get ; set ;}
    public List<ItemType_info> ItemTypes {get ; set ;}
    public List<UpcomingEvents> UpcomingEvents {get ; set ;}
    public List<Currency__c> CurrencyList {get ; set ;}
    public LIST<PGateway_Type__c> PGatewaytypes {get; set;}
    public LIST<Pay_Gateway__c> PayGateways {get; set;}
    public String StripeEventdexClientID {get; set;}
    public String StripeEventdexSecretKey {get; set;}
    
    public maincontainer() {
      Events = new list<container>();
      ItemTypes = new List<ItemType_info>();
      UpcomingEvents = new List<UpcomingEvents>();
      CurrencyList = new List<Currency__c>();
      
    }
  }
}