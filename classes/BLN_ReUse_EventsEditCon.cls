global without sharing class BLN_ReUse_EventsEditCon { 
    public PageReference updateComponent() {
        return null;
    }


   public String modules{get;set;}
 public String componenteventid{get;set;}
 public String PGAuthlastfour{get;set;}
 public String PGAuthCardType{get;set;} 
 public String PGAuthKey{get;set;}
 public boolean creditcardoverwrite{get;set;}  
    public PageReference Refresh() {
   
    System.debug('module '+modules);
    paygtype=new Map<String,boolean>();
         
         paygtype=BLN_Event_UtilityCon.paygatewaytypes(modules);
         
         //Added on 19march2015
          try{
         try{
         Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
            selectedEvent = k.getValue();
        }}catch(Exception e){}
        if(selectedEvent==null)
        selectedEvent=ApexPages.currentPage().getParaMeters().get('id');
        if(selectedEvent==null)
        selectedEvent=componenteventid;
        System.debug('selectedEvent just'+selectedEvent+' '+componenteventid);
         BLN_Event__c bleorgid= new BLN_Event__c(); 
       bleorgid=[select id,name,organizer_id__c,organizer_id__r.PG_Credit_Card_Overwrite__c,organizer_id__r.PG_Authorization_Key__c,organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,organizer_id__r.PG_Authorization_Card_Type__c,Organizer_Email__c,createdby.username from BLN_Event__c where id=:selectedEvent];
       PGAuthKey=bleorgid.organizer_id__r.PG_Authorization_Key__c;
       PGAuthlastfour=bleorgid.organizer_id__r.PG_Authorization_CC_Last_four_Digit__c;
       PGAuthCardType=bleorgid.organizer_id__r.PG_Authorization_Card_Type__c;
       creditcardoverwrite=bleorgid.organizer_id__r.PG_Credit_Card_Overwrite__c;
       System.debug('#######'+bleorgid);
       //added on 17 march 2015
       BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
string uid = userInfo.getUserId();
defaultgn=new GN_User__c();
defaultgn=gndao.gettinggnuser(uid);
       paygateways=new Map<String,List<Pay_Gateway__c>>();
         for(string pname:paygtype.keySet())
         {
         List<String> parts=pname.split(',');
         paygateways.put(pname,[select Id,Name,Active_Paygateway__c,Use_Host_Page__c,(select Events__c,Registration_Type__c from Event_Pay_Gateway__r where Events__c=:selectedEvent and Registration_Type__c=:modules),Company__c,Paygateway_name__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c from  Pay_Gateway__c where BLN_GN_User__c=:defaultgn.id  and PGateway_Type__r.Name=:parts[0] and PGateway_Type__r.Adaptive_Type__c=:parts[1]]);
         }
        //
       
        
       }catch(Exception e){}
         
         //
         
       
        return null;
    }
    
    


/***********************************************************************************************
*   Controller Name : BLN_EventsConTest
*   Date            : 30/08/2014
*   Author          : Arindam Sarkar
*   Purpose         : This class is for Create Event
*   Change History  : 12/12/2014 
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*   12/12/2014          Arindam Sarkar                  Unless he makes the payment while adding the BL products if he click on cancel or myevent link now to go back,I am restricting and showing a message "Please complete Payment"
**************************************************************************************************/
    
    public LIST<eventOptionsWrapper> eventSelectOptions{get; set;}
    public LIST<Event_Price__c> eventOptions{get; set;}
    public BLN_Event__c newEvent {get ; set ;}
    public String defaulteventduration{get;set;}
     public String defaultnooftickets{get;set;}
     private final BLN_Event__c event_object; 
     public DateTime eventEndDate{get;set;}
    public Boolean isEventCompleted{get;set;}
     
     
     
     public BLN_UtillDisplayLinks Ticket{get;set;}
    public static Id selectedEvent{get;set;}
    
    global class eventOptionsWrapper{
        
        public Boolean eventOptionsBoolean{get; set;}
        public Event_Price__c eventOptionItemType{get; set;}
        
        public eventOptionsWrapper(Boolean b, Event_Price__c ite){
                eventOptionsBoolean = b;
                eventOptionItemType = new Event_Price__c();
                eventOptionItemType = ite;
                
        }
    }
    
    //builds a picklist of values based upon the passed information
    public List<selectOption> getPickValues(Sobject object_name, String field_name, String first_val) {
        System.debug('111111111111111:'+object_name);
        System.debug('222222222222222222:'+field_name);
        System.debug('333333333333333:'+first_val);
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
    public List<selectOption> getUserTimeZones() {
    User u=new User();
        return getPickValues(u,'TimeZoneSidKey', null);
    }
    
    //return the picklist options for event type
    public List<selectOption> getEventTypes() {
        return getPickValues(event_object, 'Event_Type__c', null);
    }
    
    //return the picklist options for event type
    public List<selectOption> getEventStatus() {
        return getPickValues(event_object, 'Event_Status__c', null);
    }
    
    
    public List<selectOption> getLanguageSetting() {
        //return getPickValues(event_object, 'Language_Settings__c', null);
        User u=new User();
        return getPickValues(u,'LocaleSidKey', null);
    }
    public List<selectOption> getVisibility() {
       return getPickValues(new BLN_Item__c(), 'Visibility__c', null);
    }
    
    public List<selectOption> getPaymentType() {
        return getPickValues(new BLN_Item__c(), 'Payment__c', null);
    }
    
    
    
   public String defaultcountryid{get;set;}
    public List<selectOption> getCountry(){
      
        LIST<SelectOption> countryOptions= new LIST<SelectOption>();
     
        for(Country__c c: [SELECT ID, NAME, Short_Name__c, Long_Name__c FROM Country__c order by Long_Name__c asc]){
            countryOptions.add(new SelectOption(c.id, c.Long_Name__c));
            if(c.Long_Name__c=='United States Of America')
            defaultcountryid=c.id;
        }
         
       return countryOptions;
      
    }
    
    public List<SelectOption> itemtypesaddon{get;set;}
    public List<SelectOption> itemtypes{get;set;}
      public void getAddOnItemTypes(){
      
        itemtypesaddon= new LIST<SelectOption>();
        //itemtypesaddon.addAll(individualTicketsSelectOptions);
     
        for(Item_Type__c c: [SELECT ID, NAME,Order__c FROM Item_Type__c where Add_On__c=true order by Order__c]){
            itemtypesaddon.add(new SelectOption(c.id, c.name));
        }
         
       
      
    }  
    
    //get package item type
     public List<SelectOption> itemtypespackage{get;set;}
    public void getPackageItemTypes(){
      
        itemtypespackage= new LIST<SelectOption>();
     
        for(Item_Type__c c: [SELECT ID, NAME FROM Item_Type__c where Item_Type_Number__c='IT-000005']){
            itemtypespackage.add(new SelectOption(c.id, c.name));
        }
         
     
      
    } 
    
    
   
     @RemoteAction
    global static List<SObject> statesBasedOnCountry(String country){
         //eventCurrency =  Currencies;
        return [SELECT ID, NAME, Short_Name__c,Long_Name__c, Country__c FROM State__c WHERE Country__c =: country];
 
    }
    
    @RemoteAction
    global static List<SObject> currencyBasedOnCountry(String country){
        Country__c coun = [SELECT id,Name,Currency__c,Currency__r.Currency_Name__c,Currency__r.Currency_Symbol__c from Country__c where id =: country];
         
         //eventCurrency =  Currencies;
        return [SELECT id,Name,Currency_Name__c, Currency_Symbol__c FROM Currency__c WHERE id =: coun.Currency__c];
 
    }
    
    public LIST<selectOption> paymentSelectOptions{get; set;}
    public LIST<selectOption> individualTicketsSelectOptions{get; set;}
    public LIST<selectOption> BLPRODTicketsSelectOptions{get; set;}
    public LIST<Registration_Template__c> regTemplates{get; set;}
     public String itemdefaultmaxqty{get;set;}
     public String itemdefaultminqty{get;set;}
    public GN_User__c  defaultgn{get;set;}
    public UC_Role__c defaultucrole{get;set;}
    public boolean isowner{get;set;}
    
    public BLN_Event__c bleorgid{get; set;}
    public string currentdate{get;set;}
 
    //---------------------
    public BLN_ReUse_EventsEditCon(){
    //paygtype=new Map<String,boolean>();
   // dateTime dttoday=system.now();
    
     try{    
     IsUploadEventLogo = false;
         //paygtype=BLN_Event_UtilityCon.paygatewaytypes(ApexPages.currentPage().getParaMeters().get('tab')==null?'Online':ApexPages.currentPage().getParaMeters().get('tab'));
       paygtype=new Map<String,boolean>();
         if(modules==null)
         modules='Online';
         paygtype=BLN_Event_UtilityCon.paygatewaytypes(modules);  
     String strurl = ApexPages.currentPage().getUrl();
     strurl = strurl.split('apex/')[1];
     if(strurl.contains('BLN_PaymentNewSettings')){
      
         Ticket= new BLN_UtillDisplayLinks(); 
       
      Ticket.isEventsettingsExpand = 'expand';
      Ticket.ispaymentSettingsPage=  'active';
      Ticket.isEventAdmin =true;
     
      Ticket.tablabel ='Payment Settings';
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
            selectedEvent = k.getValue();
        }
        
         LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
         BLN_Event_DAO evDAO = new BLN_Event_DAO();
         eventsList =  evDAO.getEventDetails(selectedEvent);
         
   if(eventsList.size() > 0){
          Ticket.EventName =eventsList[0].Name;
         
                
         }
          try{
          Ticket.userPermissions(userInfo.getUserId(),selectedEvent);
          }catch(Exception e){}
        } 
        
          //for stripe
        authCode = ApexPages.currentPage().getParameters().get('code');
        List<Pay_Gateway__c> pg=[SELECT Id,Name,Company__c,Paygateway_name__c,PGateway_Type__c,PGateway_Type__r.Name,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c FROM Pay_Gateway__c where Company__r.Name='EventdexLive' and PGateway_Type__r.Name='Stripe' and PG_User_Key__c!=null];
        if(strurl.contains('BLN_PaymentNewSettings')){
        authorizationCodeURI = 'https://connect.stripe.com/oauth/authorize?response_type=code&client_id='+pg[0].PG_User_Key__c+'&scope=read_write&redirect_uri='+Label.SiteURL+'/apex/BLN_PaymentNewSettings';
        }
        else if(strurl.contains('BLN_TicketsNew')){
        authorizationCodeURI = 'https://connect.stripe.com/oauth/authorize?response_type=code&client_id='+pg[0].PG_User_Key__c+'&scope=read_write&redirect_uri='+Label.SiteURL+'/apex/BLN_TicketsNew';
        }
        else
        authorizationCodeURI = 'https://connect.stripe.com/oauth/authorize?response_type=code&client_id='+pg[0].PG_User_Key__c+'&scope=read_write&redirect_uri='+Label.SiteURL+'/apex/BLN_EventNew';
        
        /*if(authCode != NULL){
        
            Http hToken = new Http();
            HttpRequest reqToken = new HttpRequest();
            reqToken.setEndpoint('https://connect.stripe.com/oauth/token?grant_type=authorization_code&code='+authCode+'&client_secret=sk_test_SEppbKiXBACmm9tRsJZkpB8l');
            reqToken.setMethod('POST');
            resToken = hToken.send(reqToken);
            body = resToken.getBody();
           
            jsonWrapObj = (JSONWrapper)JSON.deserialize(body, JSONWrapper.class);
            
            system.debug('********* '+jsonWrapObj.access_token);
        }*/
       //
     }catch(Exception e){}
    }
    
    
    
    
    public PageReference getStripeAccessToken() {
    HttpResponse resToken;
    authCode = ApexPages.currentPage().getParameters().get('code');
     List<Pay_Gateway__c> pg=[SELECT Id,Name,Company__c,Paygateway_name__c,PGateway_Type__c,PGateway_Type__r.Name,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c FROM Pay_Gateway__c where Company__r.Name='EventdexLive' and PGateway_Type__r.Name='Stripe' and PG_User_Key__c!=null];
        
       
       if(authCode != NULL){
        
            Http hToken = new Http();
            HttpRequest reqToken = new HttpRequest();
            reqToken.setEndpoint('https://connect.stripe.com/oauth/token?grant_type=authorization_code&code='+authCode+'&client_secret='+pg[0].PG_Pass_Secret__c);
            reqToken.setMethod('POST');
            resToken = hToken.send(reqToken);
            body = resToken.getBody();
           
            jsonWrapObj = (JSONWrapper)JSON.deserialize(body, JSONWrapper.class);
            
            //return jsonWrapObj.access_token;
        }
        return null;
    }
    
    
    //-----------------------------------
    public Map<String,boolean> paygtype{get;set;}
     public Map<String,List<Pay_Gateway__c>> paygateways{get;set;}
    public BLN_ReUse_EventsEditCon(ApexPages.StandardController controller) {
    try{
    if(modules==null)
         modules='Online';
    IsUploadEventLogo = false;
    this.event_object = (BLN_Event__c)controller.getRecord();
    if(ApexPages.currentPage().getParaMeters().get('id')!=null)
    selectedEvent =ApexPages.currentPage().getParaMeters().get('id');
    //for ticket controller
    try{
    Cookie k = ApexPages.currentPage().getCookies().get('counter');
         if(k!=null){ 
             selectedEvent = k.getValue();
             ApexPages.currentPage().getParaMeters().put('id',selectedEvent);
         }
         Ticket= new BLN_UtillDisplayLinks();
         Ticket.isTicketsPage='active';
         Ticket.isTicketsPageExpand='expand';
         Ticket.tablabel='Tickets';
         Ticket.eventId=selectedEvent;
    //
    LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
         BLN_Event_DAO evDAO = new BLN_Event_DAO();
         eventsList =  evDAO.getEventDetails(selectedEvent);
         
   if(eventsList.size() > 0){
          Ticket.EventName =eventsList[0].Name;
          eventEndDate = eventsList[0].End_Date__c;
         if(eventEndDate < DateTime.now()){
           isEventCompleted = true;
       }
       else{
           isEventCompleted = false;
       }
        try{
    defaultnooftickets=String.valueOf(eventsList[0].Max_Num_Tickets__c);
    }catch(Exception e){defaultnooftickets=(String)BLN_Event__c.Max_Num_Tickets__c.getDescribe().getDefaultValueFormula();}  
                
         }
         try{
          Ticket.userPermissions(userInfo.getUserId(),selectedEvent);
          }catch(Exception e){}
         //end of for ticket controller
    }catch(Exception e){}
         //store all the ptype in map
         paygtype=new Map<String,boolean>();
         
         paygtype=BLN_Event_UtilityCon.paygatewaytypes('Online');
         //
    
    try{
    itemdefaultmaxqty=(String)BLN_Item__c.max_per_order__c.getDescribe().getDefaultValueFormula();
    itemdefaultminqty=(String)BLN_Item__c.min_per_order__c.getDescribe().getDefaultValueFormula();
    }catch(Exception e){}
    defaulteventduration=(String)BLN_Event__c.Default_Event_Duration__c.getDescribe().getDefaultValueFormula();
    try{
    if(defaultnooftickets==''||defaultnooftickets==null)
    defaultnooftickets=(String)BLN_Event__c.Max_Num_Tickets__c.getDescribe().getDefaultValueFormula();
    }catch(Exception e){}
        eventOptions = new LIST<Event_Price__c>();
       
        
         eventOptions.addAll(BLN_ItemType_DAO.eventOptionItemTypes(BLN_Event_UtilityCon.displayEventOptions(),ApexPages.currentPage().getParaMeters().get('id'))); 
         eventSelectOptions = new LIST<eventOptionsWrapper>();
         
         for(Event_Price__c itp: eventOptions){
                eventSelectOptions.add(new eventOptionsWrapper(FALSE, itp ));
         }
         
         
         //geting individual ticket standard item types
          individualTicketsSelectOptions = new LIST<selectOption>();
          BLPRODTicketsSelectOptions=new LIST<selectOption>();
         SET<String> eventOptionsItemTypes = new SET<String>();
        BLN_Event_UtilityCon eventUtility = new BLN_Event_UtilityCon();
         eventOptionsItemTypes.addAll(eventUtility.allMainItemType());
        LIST<Event_Price__c> individualTicketsItemTypess = new LIST<Event_Price__c>();
        individualTicketsItemTypess = BLN_ItemType_DAO.itemTypesforIndividualTickets(eventOptionsItemTypes,ApexPages.currentPage().getParaMeters().get('id'));
        
         individualTicketsSelectOptions = BLN_ItemType_BAL.itemTypeSelectOptions(individualTicketsItemTypess);
         //Adding event option types
         for(Event_Price__c itemtpe:[select item_type__r.id,item_type__r.name,item_type__r.Item_Type_Number__c from Event_Price__c where (item_type__r.Item_Type_Number__c='IT-000010' or item_type__r.Item_Type_Number__c='IT-000004' or item_type__r.Item_Type_Number__c='IT-000003' or item_type__r.Item_Type_Number__c='IT-000007') and Active_Flag__c=true and Event__c=:ApexPages.currentPage().getParaMeters().get('id') order by item_type__r.Order__c])
         BLPRODTicketsSelectOptions.add(new SelectOption(itemtpe.item_type__r.id,itemtpe.item_type__r.name));
         //
          //get all the Add On item types
         getAddOnItemTypes();
         //
         
         //get package item type
         getPackageItemTypes();
         //
         
         //get payment types for Item
         paymentSelectOptions=getPaymentType();
         //
          //update gnuser company,phoneno and name
       //get gnuser
       
       if(ApexPages.currentPage().getParaMeters().get('id')!=null)
       {
       
       bleorgid= new BLN_Event__c(); 
       bleorgid=[select id,name,organizer_id__c,Organizer_Email__c,createdby.username from BLN_Event__c where id=:ApexPages.currentPage().getParaMeters().get('id') ];
       System.debug('#######'+bleorgid);
       if(userInfo.getusername()==bleorgid.createdby.username)
       isowner=true;
       else
       isowner=false;
       BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
              
                     string uid = userInfo.getUserId();
                
                     Company__c companyId=null;
                     try{
                     defaultgn=new GN_User__c();
                     defaultgn=gndao.existingGnuser(bleorgid.Organizer_Email__c);
                     defaultucrole=new UC_Role__c();
                     defaultucrole=[select id,name,User_Type__c,Company__c,Company__r.Name,GN_User__c from UC_Role__c where Company__c=:bleorgid.organizer_id__c and GN_User__c=:defaultgn.id];
                    
                     }catch(Exception e){}
                     }
                     else
                     {
                        isowner=true; 
                        BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
              
                     string uid = userInfo.getUserId();
                
                     Company__c companyId=null;
                     try{
                     defaultgn=new GN_User__c();
                     defaultgn=gndao.gettinggnuser(uid);
                     defaultucrole=new UC_Role__c();
                     defaultucrole=[select id,name,User_Type__c,Company__c,Company__r.Name,GN_User__c from UC_Role__c where Company__c=:defaultgn.Default_Company_ID__c and GN_User__c=:defaultgn.id];
                    
                     }catch(Exception e){}   
                     }
         
         regTemplates = new LIST<Registration_Template__c>();
       
       
       regTemplates = [SELECT ID, NAME, Template_Image_URL__c,Order__c,BLN_Events__r.Name   FROM Registration_Template__c WHERE BLN_Events__r.Name='Default Event(Boothleads)' ORDER BY Order__c ];
       
       jsonWrapObj=new JSONWrapper();
       
       //for stripe
        /*authCode = ApexPages.currentPage().getParameters().get('code');
        authorizationCodeURI = 'https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_3jL4mUKJtvfExOYL8WrumSxkX7yh8P5m&scope=read_write';
        HttpResponse resToken;
        if(authCode != NULL){
        
            Http hToken = new Http();
            HttpRequest reqToken = new HttpRequest();
            reqToken.setEndpoint('https://connect.stripe.com/oauth/token?grant_type=authorization_code&code='+authCode+'&client_secret=sk_test_SEppbKiXBACmm9tRsJZkpB8l');
            reqToken.setMethod('POST');
            resToken = hToken.send(reqToken);
            body = resToken.getBody();
           
            jsonWrapObj = (JSONWrapper)JSON.deserialize(body, JSONWrapper.class);
            
            system.debug('********* '+jsonWrapObj.access_token);
        }*/
       //
       try
       {
       bleorgid=[select id,name,organizer_id__c,organizer_id__r.PG_Credit_Card_Overwrite__c,organizer_id__r.PG_Authorization_Key__c,organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,organizer_id__r.PG_Authorization_Card_Type__c,Organizer_Email__c,createdby.username from BLN_Event__c where id=:selectedEvent];
       creditcardoverwrite=bleorgid.organizer_id__r.PG_Credit_Card_Overwrite__c;
       }catch(Exception e){}
       }catch(exception ex){}
    }
    
    
    @RemoteAction
    global static BLN_Event__c getcreditcarddetails(String eventid)
    {
        BLN_Event__c bleorgid= new BLN_Event__c(); 
       try{
      
       bleorgid=[select id,name,organizer_id__c,organizer_id__r.PG_Credit_Card_Overwrite__c,organizer_id__r.PG_Authorization_Key__c,organizer_id__r.PG_Authorization_CC_Last_four_Digit__c,organizer_id__r.PG_Authorization_Card_Type__c,Organizer_Email__c,createdby.username from BLN_Event__c where id=:eventid and organizer_id__r.PG_Authorization_Key__c!=null and organizer_id__r.PG_Authorization_Key__c!='Check'];
       
       }catch(Exception e){}
       return bleorgid;
    }

@RemoteAction
    global static String createupdateuser(String eventorgfname,String eventorglname,String EventOrgEmail)
    {   
           String OrderUserId;
        BLN_StatusMessage OrderUserMsg = new BLN_StatusMessage();
           BLN_Quick_Registration_BAL blsignupbal=new BLN_Quick_Registration_BAL();
        //String usermsg=blsignupbal.CheckUserEmailExists(eventorgfname,eventorglname,EventOrgEmail,'','123456');
        //return usermsg;
            /*GN_User__c GNUser = new GN_User__c();
            GNUser.First_Name__c = eventorgfname;
            GNUser.Last_Name__c = eventorglname;
            GNUser.Email__c = EventOrgEmail;*/
          //  GNUser.Company_name__c = eventorgfname + eventorglname;
        
        /*if(blsignupbal.checkUserEmail(EventOrgEmail)==null){
         OrderUserMsg =blsignupbal.insertGNUser(GNUser);
         if(OrderUserMsg.successBool){
                 OrderUserId = OrderUserMsg.successId; 
                 }
        }*/
        BLN_Gnuser_DAO gndao=new BLN_Gnuser_DAO();
        OrderUserId=gndao.insertGnUserprocess(eventorgfname,eventorglname,EventOrgEmail,'','','','','','','','');
        if(OrderUserId==null)
        return '';
        else
        return OrderUserId;
    }
   
    @RemoteAction
    global static String savesEventInfo(String eventjsonInput,String eventlogourl,String defaultcompany,String companyid,String eventorgfname,String eventorglname,String newgnuserid,String lguserid,String includecountry) {
    System.debug('========>>>>1'+eventjsonInput);
    System.debug('========>>>>2'+eventlogourl);
    System.debug('========>>>>3'+defaultcompany);
    System.debug('========>>>>4'+companyid);
    System.debug('========>>>>5'+eventorgfname);
    System.debug('========>>>>6'+eventorglname);
    System.debug('========>>>>7'+newgnuserid);
    System.debug('========>>>>8'+lguserid);
    //System.debug('========>>>>1'+eventjsonInput);
    BLN_Event__c ble=new BLN_Event__c();
   
       
    
    //Event object
    EventInfo eveinfo;
   
    // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(eventjsonInput);
    while (parser.nextToken() != null) {
        
                    eveinfo= (EventInfo)parser.readValueAs(EventInfo.class);
                   

       } 
       System.debug('QQQQQQQ'+eveinfo.EventOrgEmail);
       if(eveinfo.EventOrgEmail==null)
        eveinfo.EventOrgEmail=userinfo.getuseremail();
       //put your update code
     User u1=[select id,name,TimeZoneSidKey,LocaleSidKey,email from User where id=:lguserid];
        //System.debug('RRRRRRRR:'+u1);
        //System.debug('iiiiiiiii:'+lguserid);
        //u1.TimeZoneSidKey =eveinfo.HostingTimeZone; 
        //u1.TimeZoneSidKey='GMT';
        //u1.LocaleSidKey=eveinfo.LanguageSetting;
        //update u1;

     
     
     User u=[select id,name,username,TimeZoneSidKey,LocaleSidKey,email from User where username=:eveinfo.EventOrgEmail];
     
     
     
        
       ID eventID;
        BLN_Event__c newEvent  = new BLN_Event__c ();
        DataBase.saveResult docSaveResult;
                
        newEvent.Logo_URL__c=eventlogourl;                
       newEvent.Name = eveinfo.EventName;
       newEvent.City__c =eveinfo.EventCity;
       newEvent.BLN_Country__c  =eveinfo.EventCountry;
       newEvent.Description__c = eveinfo.EventDesc;
       //LIST<string> Edatetimeval = eveinfo.EventEDate.split(' ');
       //date dd = date.parse(Edatetimeval[0]);
       //string ddval = dd.month()+'-'+dd.date()+'-'+dd.year();
       
          
         // newEvent.End_Date__c =Datetime.parse(eveinfo.EventEDate);
          
       //newEvent.End_Date__c =  dd;
       if(eveinfo.EventState!='')
       newEvent.BLN_State__c =eveinfo.EventState;
        newEvent.Street1__c =eveinfo.HostingAddress1;
        newEvent.Street2__c =eveinfo.HostingAddress2;
        //LIST<string> Sdatetimeval = eveinfo.EventSDate.split(' ');
       // newEvent.Start_Date__c = date.parse(Sdatetimeval[0]);      
          
        newEvent.Time_Zone__c =eveinfo.HostingTimeZone;
        newEvent.Twitter_Hash_Tag__c =eveinfo.EventHashTag;
        newEvent.Twitter_URL__c = eveinfo.TwitterUrl;
        newEvent.Venue_Name__c  = eveinfo.EventLocation;
        newEvent.Website_Url__c =eveinfo.WebUrl;
        newEvent.ZipCode__c =eveinfo.ZipCode;
        newEvent.Phone_Number__c =eveinfo.PhoneNo;
        //newEvent.PO_Box__c =eveinfo.PoBox;
        newEvent.Facebook_URL__c =eveinfo.FacebookUrl;
                newEvent.LinkedIn_URL__c =eveinfo.LinkedInUrl;
        newEvent.Organizer_Email__c =eveinfo.EventOrgEmail;
       // newEvent.End_Time__c = Edatetimeval[1]+' '+Edatetimeval[2];
       // newEvent.Start_Time__c = Sdatetimeval[1]+' '+Sdatetimeval[2];
        newEvent.Language_Settings__c = eveinfo.LanguageSetting;
        newevent.Event_Status__c= eveinfo.EventStatus;
        if(eveinfo.EventCategory!='')
        newEvent.Event_Type__c=eveinfo.EventCategory;

        //newEvent.Event_Blog_URL__c
        //newEvent.Event_Topic__c
        //newEvent.Event_Type__c 
        //newEvent.is_Corporate__c
        //newEvent.LinkedIn_URL__c
        //newEvent.Logo_URL__c
        //newEvent.Password__c
        //newEvent.Accept_Refund_Policy__c =
       //newEvent.Accept_Tax_Rate__c
       //newEvent.Accept_Terms_Conditions__c   
        //newEvent.Refund_Policy__c
        //newEvent.Registration_Template__c
        //newEvent.Service_Fee__c
        //newEvent.Show_Map__c
        //newEvent.Social_Hashtag__c
        //newEvent.Terms_Conditions__c
        
        //newEvent.Tax_Rate__c
        //newEvent.User_Company__c
        //newEvent.Waitlist__c
        system.debug('aaaa');
       IF(eveinfo.EventID == null){
       
       BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
       newEvent.Start_Date__c = timezonecl.getDateBasedOnEventTimeZone(eveinfo.EventSDate,eveinfo.HostingTimeZone);
          
       BLN_timeConToEvzoneCon timezonecls=new BLN_timeConToEvzoneCon();
       newEvent.End_Date__c = timezonecls.getDateBasedOnEventTimeZone(eveinfo.EventEDate,eveinfo.HostingTimeZone); 
       
         LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
                        eventsList.add(newEvent);
                        
                        BLN_Events_BAL createEventBAL = new BLN_Events_BAL();
                         eventId = createEventBAL.createEvent(eventsList,eveinfo.OrgName,companyid,u.id,u1.id);
       }      
       else{//FOR EVENT UPDATE
       
       BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
       newEvent.Start_Date__c = timezonecl.getDateBasedOnEventTimeZone(eveinfo.EventSDate,eveinfo.EventID);
          
       BLN_timeConToEvzoneCon timezonecls=new BLN_timeConToEvzoneCon();
       newEvent.End_Date__c = timezonecls.getDateBasedOnEventTimeZone(eveinfo.EventEDate,eveinfo.EventID); 
       
       //eveinfo.EventID = EventID;
       newEvent.id=eveinfo.EventID;
        LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
                        eventsList.add(newEvent);
                        
                        BLN_Events_BAL createEventBAL = new BLN_Events_BAL();
                         eventId = createEventBAL.createEvent(eventsList,eveinfo.OrgName,companyid,u.id,u1.id);
       
       
       }
       
        //update gnuser company,phoneno and name
       //get gnuser
       BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
              
                     string uid = u.id;

                     try{
                     GN_User__c  GN = gndao.gettinggnuser(uid);
                     
            BLN_Event__c bleorgid=[select id,name,organizer_id__c from BLN_Event__c where id=:eventId];          
           if(defaultcompany=='true')
           {
                GN.Default_Company_ID__c=bleorgid.organizer_id__c;
           }
          
           
         GN.Home_Phone__c=eveinfo.PhoneNo;
          GN.First_Name__c=eventorgfname;
          GN.Last_Name__c=eventorglname;
        update GN;
                    }catch(Exception e){}
       //return the eventId
       system.debug('::::::::::::::::EVENT ID :::::::::::::'+eventId );
       try{
       //dont execute for mobile
       if(includecountry!='M')
       {
         List<BLN_Event_Countries_Include__c> becdellist=[select id,name,BLN_Event__c,BLN_Country__c from BLN_Event_Countries_Include__c where BLN_Event__c=:eventId];
         delete becdellist;
         if(includecountry!=''&&includecountry!=null)
       {
         List<BLN_Event_Countries_Include__c> beclist=new List<BLN_Event_Countries_Include__c>();
         List<String> includecountryarr=includecountry.split(',');
         for(integer i=0;i<includecountryarr.size();i++)
         {
           BLN_Event_Countries_Include__c bec=new BLN_Event_Countries_Include__c();
           bec.BLN_Event__c=eventId;
           bec.BLN_Country__c=includecountryarr[i];
           beclist.add(bec);
         }
         insert beclist;
         }
       }
       }catch(Exception e){}
    return eventId ;
   
    }
    
    
    global class EventInfo {
    public String EventName{get;set;}
    public String EventSDate{get;set;}
    public String EventEDate{get;set;}
    public String EventLocation{get;set;}
    public String EventOrgEmail{get;set;}
    public String EventID{get;set;}
     public String AttendeeReg{get;set;}
    public String CurrencySetting{get;set;}
    public String EventCategory{get;set;}
    public String EventCity{get;set;}
    public String EventCountry{get;set;}
    public String EventDesc{get;set;}
    public String EventHashTag{get;set;}
    public String EventState{get;set;}
    public String EventStatus{get;set;}
    public String FacebookUrl{get;set;}
    public String LinkedInUrl{get;set;}
    public String HostingAddress1{get;set;}
    public String HostingAddress2{get;set;}
    public String HostingTimeZone{get;set;}
    public String LanguageSetting{get;set;}
    public String OrgName{get;set;}
    public String PhoneNo{get;set;}
    //public String PoBox{get;set;}
    public String TwitterUrl{get;set;}
    public String WebUrl{get;set;}
    public String ZipCode{get;set;}
    
    
    
    public EventInfo(String EventName,String EventSDate,String EventEDate,String EventLocation,String EventOrgEmail,String EventID,String AttendeeReg,String CurrencySetting,String EventCategory,String EventCity,String EventCountry,String EventDesc,String EventHashTag,
    String EventState,String EventStatus,String FacebookUrl,String LinkedInUrl, String HostingAddress1,String HostingAddress2,String HostingTimeZone,
    String LanguageSetting,String OrgName,String PhoneNo,String TwitterUrl,String WebUrl,String ZipCode) {
    this.EventName=EventName;
    this.EventSDate=EventSDate;
    this.EventEDate=EventEDate;
    this.EventLocation=EventLocation;
    this.EventOrgEmail=EventOrgEmail;
    this.EventID=EventID;
    this.AttendeeReg=AttendeeReg;
    this.CurrencySetting=CurrencySetting;
    this.EventCategory=EventCategory;
    this.EventCity=EventCity;
    this.EventCountry=EventCountry;
    this.EventDesc=EventDesc;
    this.EventHashTag=EventHashTag;
    this.EventState=EventState;
    this.FacebookUrl=FacebookUrl;
        this.LinkedInUrl=LinkedInUrl;
    this.HostingAddress1=HostingAddress1;
    this.HostingAddress2=HostingAddress2;
    this.HostingTimeZone=HostingTimeZone;
    this.LanguageSetting=LanguageSetting;
    this.OrgName=OrgName;
    this.PhoneNo=PhoneNo;
    //this.PoBox=PoBox;
    this.TwitterUrl=TwitterUrl;
    this.WebUrl=WebUrl;
    this.ZipCode=ZipCode;
    
    }
}  
    
   //tickets
   public static MAP<String, Boolean> TicketsDisplayInEventsPageBasedOnItemTypes{get; set;}
    public static MAP<ID, Event_Price__c> EventOptionsMAP{get; set;}
     public static MAP<String,  Item_Type__c> itemTypeMap{get; set;}  
     public static LIST<Item_Type__c> ItemTypes{get; set;}
   
    @RemoteAction
    global static List<TicketCreateInfo> getAllBLProduct(String eventid) {
    List<TicketCreateInfo> tcinfo=new List<TicketCreateInfo>();
       
      for(Event_Price__c ep:[select id,name,Active_Flag__c,Item_Type__r.Name,Item_Type__r.Id,BL_Fee_Amount__c from Event_Price__c where Event__c=:eventid and Item_type__r.Item_Type_Number__c in('IT-000003','IT-000004','IT-000007','IT-000010','IT-000008','IT-000009') and Active_Flag__c=true])
      {
          TicketCreateInfo tcinfo1=new TicketCreateInfo();
        tcinfo1.ticketName=ep.Item_Type__r.Name;
        tcinfo1.ticketId=ep.Item_Type__r.Id;
        tcinfo1.ticketPrice=String.valueOf(ep.BL_Fee_Amount__c);
        
         tcinfo.add(tcinfo1);
        }
        
    return tcinfo;
    }
    
     @RemoteAction
     global static List<TicketCreateInfo> getEventproducerpaiditems(String eventid) {
    List<TicketCreateInfo> tcinfo=new List<TicketCreateInfo>();
       
      
     for(Order_Item__c orditem:[select id,name,Item__r.Event__c,Item__c,Order__r.Events__c,Order__r.order_type__c,Item_Type__c,Item_Quantity__c from Order_Item__c where Item__r.Event__c=:eventid and Order__r.order_type__c='EVENT PRODUCER' and (Order__r.Order_Status__c != 'Cancelled' AND Order__r.Order_Status__c != 'Abandoned' AND Order__r.Order_Status__c != 'Not Paid' )])
        {
         TicketCreateInfo tcinfo1=new TicketCreateInfo();
        tcinfo1.ticketQty=String.valueOf(orditem.Item_Quantity__c);
        tcinfo1.itemId=orditem.Item__c;
        tcinfo1.ticketId=orditem.Item_Type__c;
         tcinfo.add(tcinfo1);
        }
        
    return tcinfo;
    }
   
  @RemoteAction
    global static List<TicketCreateInfo> getTickets(String ittypenumber,String id,String eventid) {
    
    //if(TicketsDisplayInEventsPageBasedOnItemTypes.get(ittypenumber))
    //{
    system.debug(id+'  TICKET NUMBER  '+ittypenumber);
    TicketsDisplayInEventsPageBasedOnItemTypes = BLN_Event_UtilityCon.itemTypesDisplayInEventsPage();
     BLN_EventOptions_DAO evo = new BLN_EventOptions_DAO();
         EventOptionsMAP = evo.queryEventOptions(eventid);
         Event_Price__c ep = new Event_Price__c();
         ep = EventOptionsMAP.get(id);
         
    
   
    
      String x=String.valueOf(TicketsDisplayInEventsPageBasedOnItemTypes.get(ittypenumber));
      ItemTypes = new LIST<Item_Type__c>();
      ItemTypes.addAll( BLN_ItemType_DAO.AllItemTypes(new LIST<String>()));
       itemTypeMap = new MAP<String,  Item_Type__c> ();
      for(Item_Type__c itt : ItemTypes ){
            itemTypeMap.put(itt.Item_Type_Number__c, itt);
        }
      Item_Type__c  itemType = ItemTypeMap.get(ittypenumber);
    String y=String.valueOf(ep.BL_Fee_Amount__c);
    
    
     // }
        //return itemType.Name+';'+x+';'+y;
        
        TicketCreateInfo tcinfo1=new TicketCreateInfo();
        tcinfo1.ticketName=itemType.Name;
        tcinfo1.ticketId=itemType.id;
        tcinfo1.ticketPrice=y;
       
        tcinfo1.show=true;//TicketsDisplayInEventsPageBasedOnItemTypes.get(ittypenumber);
        
        List<TicketCreateInfo> tcinfo=new List<TicketCreateInfo>();
        tcinfo.add(tcinfo1);
        
        /*if(ittypenumber=='IT-000003')
        {
          itemType = ItemTypeMap.get('IT-000004');
          ep = EventOptionsMAP.get([select id,name from Event_Price__c where Event__c=:eventid and Item_type__r.Item_Type_Number__c='IT-000004'].id);
          TicketCreateInfo tcinfo2=new TicketCreateInfo();
        tcinfo2.ticketName=itemType.Name;
        tcinfo2.ticketId=itemType.id;
        tcinfo2.ticketPrice=String.valueOf(ep.BL_Fee_Amount__c);
        
        tcinfo2.show=TicketsDisplayInEventsPageBasedOnItemTypes.get('IT-000004');
        
         tcinfo.add(tcinfo2);
        }*/
        return tcinfo;
    } 
    
   global class TicketCreateInfo
    {
     public String ticketName{get;set;}
     public String ticketPrice{get;set;}
     public String ticketQty{get;set;}
     public String ticketId{get;set;}
     public boolean show{get;set;}
      public String itemId{get;set;}
        
    } 
  
  
  
  @RemoteAction
    global static void savesEventsTaxRateRefundPolicy(String eventID,String acceptrefund,String refundpolicy,String acceptterm,String termcond,String accepttaxrate,String taxrate) {
    BLN_Event__c ble=new BLN_Event__c(id=eventID,Accept_Refund_Policy__c=boolean.valueOf(acceptrefund),Refund_Policy__c=refundpolicy,Accept_Terms_Conditions__c=boolean.valueOf(acceptterm),Terms_Conditions__c=termcond,Accept_Tax_Rate__c=boolean.valueOf(accepttaxrate),Tax_Rate__c=Decimal.valueOf(taxrate));
    update ble;
    }
  
  
  public static String totcountinner;
  @RemoteAction
    global static String savesTicketInfo(String tcktjsonInput,String eventID,String currentdate,String EventEDate,String totcount) {
    System.debug('==========123'+tcktjsonInput);
    totcountinner=totcount;
    String usertimezone=UserInfo.getTimeZone().getID();
    BLN_Event__c eve=[select id,name,Time_Zone__c,Service_Fee__c  from BLN_Event__c where id=:eventID];
  String eventtimezone= eve.Time_Zone__c ;
    BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
      String message='';
    //Remove existing records for update
    /*List<BLN_Item__c> delitems=[select id,name from BLN_Item__c where Event__c=:eventID];
    delete delitems;
    List<Item_Pool__c> delitemspool=[select id,name from Item_Pool__c where Event__c=:eventID];
    delete delitemspool;*/
    Savepoint sp = Database.setSavepoint();
    try{
     
    //Ticket object
    List<ticket> tcinfo;
    tcinfo = new List<ticket>(); 
    // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(tcktjsonInput);
    while (parser != null && parser.nextToken() != null) {
        
                    tcinfo= (List<ticket>)parser.readValueAs(List<ticket>.class);
                   

       } 
       
       System.debug('My Ticket Info '+tcinfo);
       //check for item updation
                
         
           for(integer i=0;i<tcinfo.size();i++)
    {
        
        if(tcinfo[i].grouptickets.size()!=0){
        
         for(integer j=0;j<tcinfo[i].grouptickets.size();j++){
         if(tcinfo[i].grouptickets[j].itemid.length()!=0)
        {
         for( BLN_Item__c olditem:[Select id,min_per_order__c,max_per_order__c, 
                        item_type__c, item_name__c, item_count__c,Item_Pool__c,Item_Pool__r.Item_Pool_Name__c,Available_Tickets__c From BLN_Item__c where Event__c=:eventID])
                        { 
             if(tcinfo[i].grouptickets[j].itemid==olditem.id&&olditem.Item_Pool__c==tcinfo[i].poolid&&Decimal.valueOf(tcinfo[i].grouptickets[j].qty)<olditem.item_count__c)
             {
                   Decimal minusquantity=(olditem.item_count__c-Decimal.valueOf(tcinfo[i].grouptickets[j].qty));  
                   if(minusquantity>olditem.Available_Tickets__c)    
                   {
                      
                      message=' Your total tickets for '+tcinfo[i].grouptickets[j].tname+' are '+olditem.item_count__c+'  and  sold/booked tickets are  '+(olditem.item_count__c-olditem.Available_Tickets__c)+'. So you can�t reduce the tickets to less than '+(olditem.item_count__c-olditem.Available_Tickets__c)+' tickets ';
                      return message;
                   }
                   
                    break; 
             }
            
             }//old item loop
             }
         }//group tickets loop
         
         }  
         
       }      
           
                        
      System.debug('tcinfo*** '+tcinfo);                  
      
       
     //create db objects
     List<Item_Pool__c> itpool=new List<Item_Pool__c>(); 
    //First Insert into Item Pool
    for(integer i=0;i<tcinfo.size();i++)
    {
        if(tcinfo[i].tname!=''){
        itpool.add(new Item_Pool__c());
        itpool[i].Item_Pool_Name__c=tcinfo[i].tname;
        itpool[i].Item_Count__c=Integer.valueOf(tcinfo[i].tqty);
        if(tcinfo[i].ispackage=='false'||tcinfo[i].ispackage=='')
        itpool[i].Package_Flag__c='I - Individual Item pool';
        else
        itpool[i].Package_Flag__c='P - Package item pool';
        itpool[i].Event__c=eventID;
        if(tcinfo[i].itemtype=='')
        {
        Item_Type__c itc;
        if(tcinfo[i].ispackage=='false'||tcinfo[i].ispackage=='')
        itc=[select id,Item_Type_Number__c from Item_Type__c where Item_Type_Number__c='IT-000001'];
        else
        itc=[select id,Item_Type_Number__c from Item_Type__c where Item_Type_Number__c='IT-000005'];
        
        itpool[i].Item_Type__c=itc.id;
        }
        else
        itpool[i].Item_Type__c=tcinfo[i].itemtype;
        itpool[i].Badge_Label__c=tcinfo[i].tbdglabel;
        itpool[i].Badgable__c=tcinfo[i].tbadgable;
        System.debug('tcinfo[i].poolid '+tcinfo[i].poolid.length());
        if(tcinfo[i].poolid.length()!=0)
        itpool[i].id=tcinfo[i].poolid;
        try{
        itpool[i].Ticketed_Sessions__c=boolean.valueOf(tcinfo[i].ticketedsession);
        }catch(Exception e){}
        itpool[i].Ordering__c=Integer.valueOf(tcinfo[i].trowid);
          }
    
    }
    
    upsert itpool;
    
    //Insertion of Package Line Items/Addon Into Pool
    List<Item_Pool__c> pklineitpool=new List<Item_Pool__c>(); 
     for(integer i=0,k=0;i<tcinfo.size();i++)
    {
        if(tcinfo[i].tname!=''){
        if(tcinfo[i].subpackagegroup.size()!=0){
         for(integer j=0;j<tcinfo[i].subpackagegroup.size();j++){
        pklineitpool.add(new Item_Pool__c());
        pklineitpool[k].Item_Pool_Name__c=tcinfo[i].subpackagegroup[j].pkgitemname;
        pklineitpool[k].Addon_Count__c=Integer.valueOf(tcinfo[i].subpackagegroup[j].pkgitemqty);
        pklineitpool[k].Item_Count__c=Integer.valueOf(tcinfo[i].subpackagegroup[j].pkgitemqty)*Integer.valueOf(itpool[i].Item_Count__c);
        pklineitpool[k].Package_Flag__c='A - Addon Item pool';
        pklineitpool[k].Event__c=eventID;
        pklineitpool[k].Item_Type__c=tcinfo[i].subpackagegroup[j].ttype;
        pklineitpool[k].Addon_Parent__c=itpool[i].id;
        pklineitpool[k].Badge_Label__c=tcinfo[i].subpackagegroup[j].badgelabel;
        pklineitpool[k].Badgable__c=tcinfo[i].subpackagegroup[j].badgable;
        if(tcinfo[i].subpackagegroup[j].addonid.length()!=0)
        pklineitpool[k].id=tcinfo[i].subpackagegroup[j].addonid;
      
        
        k++;
        }
        }
          }
    
    }
    
    upsert pklineitpool;
    String itemdefaultmaxqty=(String)BLN_Item__c.max_per_order__c.getDescribe().getDefaultValueFormula();
    String itemdefaultminqty=(String)BLN_Item__c.min_per_order__c.getDescribe().getDefaultValueFormula();
    
    
    
    //Second insert into item table the group tickets
     List<BLN_Item__c> item=new List<BLN_Item__c>(); 
    for(integer i=0,k=0;i<tcinfo.size();i++)
    {
        if(tcinfo[i].tname!=''){
        if(tcinfo[i].grouptickets.size()!=0){
             for(integer j=0;j<tcinfo[i].grouptickets.size();j++){
             
             if(tcinfo[i].grouptickets[j].tname!=''){
             item.add(new BLN_Item__c());
        item[k].item_name__c=tcinfo[i].grouptickets[j].tname;
        item[k].item_count__c=Integer.valueOf(tcinfo[i].grouptickets[j].qty);
        item[k].sale_start__c=timezonecl.getDateBasedOnEventTimeZone(tcinfo[i].grouptickets[j].sdate,usertimezone,eventtimezone);
        item[k].sale_end__c=timezonecl.getDateBasedOnEventTimeZone(tcinfo[i].grouptickets[j].edate,usertimezone,eventtimezone);
        item[k].price__c=tcinfo[i].grouptickets[j].tprice==''?0:Decimal.valueOf(tcinfo[i].grouptickets[j].tprice);
         item[k].min_per_order__c=tcinfo[i].grouptickets[j].minqty==''?Integer.valueOf(itemdefaultminqty):Integer.valueOf(tcinfo[i].grouptickets[j].minqty);
        item[k].max_per_order__c=tcinfo[i].grouptickets[j].maxqty==''?Integer.valueOf(tcinfo[i].grouptickets[j].qty)>=Integer.valueOf(itemdefaultmaxqty)?Integer.valueOf(itemdefaultmaxqty):Integer.valueOf(tcinfo[i].grouptickets[j].qty):Integer.valueOf(tcinfo[i].grouptickets[j].maxqty);
       item[k].Item_Pool__c=itpool[i].id;
        item[k].Event__c=eventID;
        if(tcinfo[i].itemtype=='')
        {
        Item_Type__c itc=[select id,Item_Type_Number__c from Item_Type__c where Item_Type_Number__c='IT-000001'];
        item[k].item_type__c=itc.id;
       
        
        }
        else
        item[k].item_type__c=tcinfo[i].itemtype;
        item[k].Payment__c=tcinfo[i].tpaytype;
        item[k].Visibility__c=tcinfo[i].tvisib;
        item[k].Taxable__c=tcinfo[i].taxrateflag==''?false:Boolean.valueOf(tcinfo[i].taxrateflag);
        item[k].Early_Bird_Pricing_Display_Flag__c=tcinfo[i].tebudprcflag==''?true:Boolean.valueOf(tcinfo[i].tebudprcflag);
        item[k].Description__c=tcinfo[i].tdesc;
        item[k].image_url__c=tcinfo[i].tcketlogo;
          
        if(tcinfo[i].grouptickets[j].itemid.length()!=0)
        item[k].id=tcinfo[i].grouptickets[j].itemid;
        else
        item[k].service_fee__c=eve.Service_Fee__c;
        
        item[k].Ordering__c=Integer.valueOf(tcinfo[i].trowid);
        k++;
        }
       
        }
          }
          else
          {
           item.add(new BLN_Item__c());
        item[k].service_fee__c=eve.Service_Fee__c;   
        item[k].item_name__c=tcinfo[i].tname;
        item[k].item_count__c=Integer.valueOf(tcinfo[i].tqty);
        item[k].sale_start__c=timezonecl.getDateBasedOnEventTimeZone(currentdate,usertimezone,eventtimezone);
        item[k].sale_end__c=timezonecl.getDateBasedOnEventTimeZone(EventEDate,usertimezone,eventtimezone);
        item[k].price__c=tcinfo[i].tprice==''?0:Decimal.valueOf(tcinfo[i].tprice);
        item[k].min_per_order__c=Integer.valueOf(itemdefaultminqty);
        item[k].max_per_order__c=Integer.valueOf(tcinfo[i].tqty)>=Integer.valueOf(itemdefaultmaxqty)?Integer.valueOf(itemdefaultmaxqty):Integer.valueOf(tcinfo[i].tqty);
        item[k].Item_Pool__c=itpool[i].id;
        item[k].Event__c=eventID;
        if(tcinfo[i].itemtype=='')
        {
        Item_Type__c itc=[select id,Item_Type_Number__c from Item_Type__c where Item_Type_Number__c='IT-000001'];
        item[k].item_type__c=itc.id;
        }
        else
        item[k].item_type__c=tcinfo[i].itemtype;
        if(tcinfo[i].tpaytype=='')
        item[k].Payment__c='Paid';
        else
        item[k].Payment__c=tcinfo[i].tpaytype;
        item[k].Visibility__c='Public';
        item[k].Taxable__c=tcinfo[i].taxrateflag==''?false:Boolean.valueOf(tcinfo[i].taxrateflag);
        item[k].Early_Bird_Pricing_Display_Flag__c=tcinfo[i].tebudprcflag==''?true:Boolean.valueOf(tcinfo[i].tebudprcflag);
        item[k].Ordering__c=Integer.valueOf(tcinfo[i].trowid);
        k++;
          }
          
          
          }
    
    }
    
    upsert item;
    
    
    Map<Id,String> maptag=new Map<Id,String>();
    //Map to store all main tags
    for(Hash_Tag__c mt:[select id,Tag_Text__c,Event__c,RowId__c from Hash_Tag__c where Event__c=:eventID and Table_Name__c='Item_Pool__c' and RowId__c=null])
    {
       maptag.put(mt.id,mt.Tag_Text__c);
    }
   
     //insert tags into ItemPool_Tag_Junction Object
     List<String> deleteipds=new List<String>();
     List<Hash_Tag__c> hitpltag=new List<Hash_Tag__c>();
     for(integer m=0,l=0,pkline=0;m<tcinfo.size();m++)
    {
        if(tcinfo[m].tname!=''){
        if(tcinfo[m].subpackagegroup.size()!=0){
         for(integer j=0;j<tcinfo[m].subpackagegroup.size();j++){
        deleteipds.add(pklineitpool[pkline].id);
         for(integer k=0;k<tcinfo[m].subpackagegroup[j].tags.size();k++){
         if(tcinfo[m].subpackagegroup[j].tags[k].tagname!=''){
         if(maptag.get(tcinfo[m].subpackagegroup[j].tags[k].tagname)!=null){
           hitpltag.add(new Hash_Tag__c());
       //Item_Pool__c ipc=[select id,name from Item_Pool__c where id=:pklineitpool[pkline].id];
              hitpltag[l].RowId__c=pklineitpool[pkline].id;
              
              hitpltag[l].BLN_Item_Pool__c=pklineitpool[pkline].id;
              hitpltag[l].Tag_Text__c=maptag.get(tcinfo[m].subpackagegroup[j].tags[k].tagname);
              hitpltag[l].Table_Name__c='Item_Pool__c';
              hitpltag[l].Event__c=eventID;
              hitpltag[l].ParentId__c=tcinfo[m].subpackagegroup[j].tags[k].tagname;
              l++;
              }
              }
            }
            pkline++;
        }
     }
     }
     }
     try{
     if(deleteipds.size()>0){
    List<Hash_Tag__c> delhashtags=[select id,name,Event__c,Table_Name__c from Hash_Tag__c where Event__c=:eventID and rowid__c in:deleteipds and Table_Name__c!='Ticket__c'];
    delete delhashtags;
    } 
    }catch(Exception e){}
     insert hitpltag;
     
     
     
     deleteipds=new List<String>();
      List<Hash_Tag__c> htag=new List<Hash_Tag__c>();
       for(integer i=0,k=0;i<tcinfo.size();i++)
    {
        if(tcinfo[i].tname!=''){
        deleteipds.add(itpool[i].id);
         for(integer j=0;j<tcinfo[i].tags.size();j++){
         if(maptag.get(tcinfo[i].tags[j].tagname)!=null){
           htag.add(new Hash_Tag__c());
           //Item_Pool__c ipc=[select id,name from Item_Pool__c where id=:itpool[i].id];
           htag[k].RowId__c=itpool[i].id;
           htag[k].BLN_Item_Pool__c=itpool[i].id;
           htag[k].Table_Name__c='Item_Pool__c';
           htag[k].Tag_Text__c=maptag.get(tcinfo[i].tags[j].tagname);
           htag[k].Event__c=eventID;
           htag[k].ParentId__c=tcinfo[i].tags[j].tagname;
           k++;
           }
         }
        
        }
     }   
     try{
     if(deleteipds.size()>0){
    List<Hash_Tag__c> delhashtags=[select id,name,Event__c,Table_Name__c from Hash_Tag__c where Event__c=:eventID and rowid__c in:deleteipds and Table_Name__c!='Ticket__c'];
    delete delhashtags;
    } 
    }catch(Exception e){}
     insert htag;
    }
    catch (System.DmlException e) {
        Database.rollback(sp);
    for (Integer i = 0; i < e.getNumDml(); i++) {
        // Process exception here 
    
        message=e.getDmlMessage(i); 
         if(message.contains('The max tickets you can insert'))
         message='The max tickets you can insert in single transaction is limited to 9,000 tickets. Please select or reduce the quantity to less than 9k and try again!';
         if(message.contains('The max tickets you can delete'))
         message='The max tickets you can insert in single transaction is limited to 9,000 tickets. Please select or reduce the quantity to less than 9k and try again!';
    }
     }
    catch(Exception e)
    {
        Database.rollback(sp);
        message=e.getMessage();
        
    }
      return message; 
  
  }
  
     global class ticket {
    public String tname{get;set;}
    public String tpaytype{get;set;}
    public String tqty{get;set;}
    public String tprice{get;set;}
    public String tvisib{get;set;}
    public String tdesc{get;set;}
    public String tcketlogo{get;set;}
    public String tbdglabel{get;set;}
    public String tbadgable{get;set;}
    public String trowid{get;set;}
    public List<grouptickets> grouptickets{get;set;}
    public String ticketcount{get;set;}
    public List<tags> tags{get;set;}
    public List<subpackagegroup> subpackagegroup{get;set;}
    public String ispackage{get;set;}
    public String itemtype{get;set;}
    public String taxrateflag{get;set;}
    public String tebudprcflag{get;set;}
    public String poolid{get;set;}
    public String ticketedsession{get;set;}
    
        
    
    public ticket(String poolid,String tname,String tpaytype,String tqty,String tprice,String tvisib,String tdesc,String tcketlogo,String tbdglabel,String tbadgable,String trowid,List<grouptickets> grouptickets,String ticketcount,List<tags> tags,List<subpackagegroup> subpackagegroup,String ispackage,String itemtype,String taxrateflag,String tebudprcflag) {
    this.poolid=poolid;
    this.tname=tname;
    this.tpaytype=tpaytype;
    this.tqty=tqty;
    this.tprice=tprice;
    this.tvisib=tvisib;
    this.tdesc=tdesc;
    this.tcketlogo=tcketlogo;
    this.tbdglabel=tbdglabel;
    this.tbadgable=tbadgable;
    this.trowid=trowid;
    this.grouptickets=grouptickets;
    this.ticketcount=ticketcount;
    this.tags=tags;
    this.subpackagegroup=subpackagegroup;
    this.ispackage=ispackage;
    this.itemtype=itemtype;
    this.taxrateflag=taxrateflag;
    this.tebudprcflag=tebudprcflag;
    }
}

global class grouptickets {
    public String tname{get;set;}
    public String sdate{get;set;}
    public String edate{get;set;}
    public String qty{get;set;}
    public String minqty{get;set;}
    public String maxqty{get;set;}
    public String tprice{get;set;}
     public String itemid{get;set;}
     public String availabletickets{get;set;}   
    
    public grouptickets(String itemid,String tname,String sdate,String edate,String qty,String minqty,String maxqty,String tprice,String availabletickets) {
    this.itemid=itemid;
    this.tname=tname;
    this.sdate=sdate;
    this.edate=edate;
    this.qty=qty;
    this.minqty=minqty;
    this.maxqty=maxqty;
    this.tprice=tprice;
    this.availabletickets=availabletickets;
    }
} 

global class subpackagegroup {
    public String pkgitemname{get;set;}
    public String pkgitemqty{get;set;}
    public String ttype{get;set;}
    public String badgelabel{get;set;}
    public String badgable{get;set;}
      public String addonid{get;set;} 
       public List<tags> tags{get;set;}  
    
    public subpackagegroup(String addonid,String pkgitemname,String pkgitemqty,String ttype,String badgelabel,String badgable,List<tags> tags) {
    this.addonid=addonid;
    this.pkgitemname=pkgitemname;
    this.pkgitemqty=pkgitemqty;
    this.ttype=ttype;
    this.badgelabel=badgelabel;
    this.badgable=badgable;
    this.tags=tags;
    }
}  

global class tags {
    public String tagname{get;set;}
    
    public tags(String tagname) {
    this.tagname=tagname;
    }
}

@RemoteAction
    global static String savesRegTempl(String regtemp,String eventid) {
    BLN_Event__c ble=new BLN_Event__c(id=eventid,Registration_Template__c=regtemp);
    upsert ble;
    return 'success';
   }

 @RemoteAction
    global static String savesFinalEvent(String evestat,String eventid,String totalblprice,String cardnumber,String cardmonth,String cardyear,String cardcvv,String tcktjsonInput,String currencyid,String paymentusing,String ptype,String cardtype) {
    BLN_Event__c ble=new BLN_Event__c(id=eventid,Event_Status__c=evestat);
    String g='';
    try{
     if(evestat=='Live'&&totalblprice!='0'){
     if(ptype=='Credit Card'){
    if(paymentusing!='Pay Using Existing Credit Card'){
    //BLN_Payments_BAL pbal=new BLN_Payments_BAL();
    //g=pbal.stripePayments(eventid,cardnumber,cardmonth,cardyear,cardcvv,Decimal.valueOf(totalblprice),0,true);
    List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
 boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='Stripe'];
 String  Stripe_API_Key='';     
       if(boothleadspaygate.size()>0){
                 Stripe_API_Key = boothleadspaygate[0].PG_Pass_Secret__c;
                 }
                 String customerid; 
    Stripe StripeRequest = new Stripe(Stripe_API_Key);
  StripeResponseModel StripeResponse = StripeRequest.createCustomer(cardnumber,cardmonth,cardyear,cardcvv,'AB','AB','AB','123123','Rajasthan','India','gamer.sanjay@gmail.com','testing');
   if(StripeResponse.isError==true)
   g='Error';
   else
   {
      customerid=StripeResponse.id;
      Integer amount=Math.round(Decimal.valueOf(totalblprice)* 100); 
          BLN_Event__c eve=[select id,name,organizer_id__c,organizer_id__r.PG_Authorization_Key__c from BLN_Event__c where id=:eventid];
StripeResponse = StripeRequest.createCharge(customerid,String.valueOf(amount),'usd','Event fee');
if(StripeResponse.isError==true){
g='Error';
}
else
{

g=StripeResponse.id;
      Company__c comp=new Company__c();
      comp.id=eve.organizer_id__c;
      comp.PG_Authorization_Key__c =customerid;
       try{
       string[] split = cardtype.split(';');
       comp.PG_Authorization_Card_Type__c=split[0];
       comp.PG_Authorization_CC_Last_four_Digit__c=split[1];
       }catch(Exception e){}
       update comp;
}
   }
    }
    else
    {
       List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
 boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='Stripe'];
 String  Stripe_API_Key='';     
       if(boothleadspaygate.size()>0){
                 Stripe_API_Key = boothleadspaygate[0].PG_Pass_Secret__c;
                 } 
                 
                 System.debug('Stripe_API_Key'+Stripe_API_Key); 
                 Stripe StripeRequest = new Stripe(Stripe_API_Key); 
          Integer amount=Math.round(Decimal.valueOf(totalblprice)* 100); 
          BLN_Event__c eve=[select id,name,organizer_id__r.PG_Authorization_Key__c from BLN_Event__c where id=:eventid];
StripeResponseModel StripeResponse = StripeRequest.createCharge(eve.organizer_id__r.PG_Authorization_Key__c,String.valueOf(amount),'usd','Event fee');
if(StripeResponse.isError==true){
g='Error';
}
else
g=StripeResponse.id;
    }
    }
    else if(ptype=='Check')
    g='Check';
    else
    g='Error';
    
    if(g!='Error'){
      //parseblproduct
      List<TicketCreateInfo> tcinfo;
   
    // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(tcktjsonInput);
    while (parser.nextToken() != null) {
        
                    tcinfo= (List<TicketCreateInfo>)parser.readValueAs(List<TicketCreateInfo>.class);
                   

       } 
       
       //get gnuser
       BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
              
                     string uid = userInfo.getUserId();
                     string gnuid=null;
                     Company__c companyId=null;
                     try{
                     GN_User__c  GN = gndao.gettinggnuser(uid);
                    gnuid =GN.id;
                    }catch(Exception e){}
                    
         BLN_Event__c bleorgid=[select id,name,Organizer_Email__c,BLN_Country__r.Currency__c,Event_Ticket_Options__c,Service_Fee__c,organizer_id__c from BLN_Event__c where id=:eventid];
        //Insert Order
        BLN_Invoice_Utility bli=new BLN_Invoice_Utility();
        String ordid=bli.InsertOrder(bleorgid.id,Decimal.valueOf(totalblprice));
        //Insert orderItem
         List<Order_Item__c> orditems=new List<Order_Item__c>();
         for(integer l=0;l<tcinfo.size();l++)
         {
            Order_Item__c orditem=new Order_Item__c();
            orditem.Order__c=ordid;
            orditem.Currency__c=currencyid;
            orditem.Item_Quantity__c=Integer.valueOf(tcinfo[l].ticketQty);
            orditem.Item_Total__c=Decimal.valueOf(tcinfo[l].ticketPrice);
            orditem.Item_Price__c=Decimal.valueOf(tcinfo[l].ticketPrice);
            orditem.Item_Type__c=tcinfo[l].ticketId;
            orditem.Item__c=tcinfo[l].itemId;
            orditems.add(orditem);
         } 
         insert orditems; 
        
         
         
         //Create a payment record
         Payment__c p;
         if(ptype=='Check')
p=new Payment__c(Currency_Code__c=currencyid,Payment_Mode__c=ptype,Payment_Amount__c=Decimal.valueOf(totalblprice),Order__c=ordid,Payment_Ref_Number__c=g);
else
{
if(cardnumber!=null&&cardnumber!='')
p=new Payment__c(Currency_Code__c=currencyid,Payment_Mode__c=ptype,Payment_Amount__c=Decimal.valueOf(totalblprice),Order__c=ordid,credit_card_last_4digits__c=cardnumber.Substring(cardnumber.length()-4,cardnumber.length()),Payment_Ref_Number__c=g);
else
p=new Payment__c(Currency_Code__c=currencyid,Payment_Mode__c=ptype,Payment_Amount__c=Decimal.valueOf(totalblprice),Order__c=ordid,Payment_Ref_Number__c=g);
}
insert p;    
 Order__c ord=[select id,name,Amount_Paid__c,Order_Status__c from Order__c where id=:ordid];
         ord.Amount_Paid__c=Decimal.valueOf(totalblprice); 
        // ord.Transaction_Status__c='Completed';
         ord.Order_Status__c='Fully Paid'; 
         update ord;      
     upsert ble;
     return 'success';
     }
     else 
     return 'error';
     }
     else
     {
       upsert ble;
     return 'success'; 
     }
    
    }catch(Exception e){
    System.debug('errorm'+e);
    return 'error';
    }
    }
    
    
   
    public String eventlogourl{get;set;}
    public transient String imageData {get;set;}
    public Document file { get; set; }{ file = new Document(); }
          public Boolean IsUploadEventLogo{get;set;}
    public PageReference saveEventLogo() {
    system.debug('IsUploadEventLogo-' + IsUploadEventLogo);
        system.debug('imageData-' + imageData);
    if(IsUploadEventLogo){
    List<folder> folderList =new List<folder>();
        folderList = [select id from folder where Name =: 'Shared Documents'];
    if(imageData!=''){
    document mydoc =new document();
                                 mydoc.body = EncodingUtil.base64Decode(imageData);
                                 mydoc.folderid =folderList[0].id;
                                 mydoc.IsPublic = True;
                                 mydoc.Name = 'eventlogo.png';
                                 mydoc.contentType='image/png';
                                 DataBase.saveResult docSaveResult;
                                 docSaveResult = DataBase.insert(mydoc, false);
                                 
                                 if(docSaveResult.isSuccess()){
                                        eventlogourl=docSaveResult.getId();
                                 }
                                }
                                }
                                else
                                {
                                 eventlogourl='';
                                }
                                return null;
    }
   @RemoteAction
    global static void deletePaymentGateways(String paygatewayid) {
   Pay_Gateway__c pg=[select id,name from Pay_Gateway__c where id=:paygatewayid];
   delete pg;
    } 

   
 
 
 @RemoteAction
    global static PaymentOpt new_savesPaymentGateways(String payjsonInput,String eventID,String paygatewaykeyname,String paygatewayid,String module) {
   
    
    //
     BLN_Event__c ble=[select id,name,Event_Ticket_Options__c,Service_Fee__c,organizer_id__c,BLN_Country__r.Currency__r.Name from BLN_Event__c where id=:eventID];
     //Ticket object
    PaymentOpt pinfo;
     try{
   
   
    // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(payjsonInput);
    while (parser.nextToken() != null) {
        
                    pinfo= (PaymentOpt)parser.readValueAs(PaymentOpt.class);
                   

       } 
       //only used for portal
    //if(pinfo.pgopt=='StripeAdaptive')
    //pinfo.pgopt='Stripe';
       
       Pay_Gateway__c pg=new Pay_Gateway__c();
       BLN_Company_DAO company = new BLN_Company_DAO();
       
       Company__c companyId ;
       PGateway_Type__c pgt;
       if(pinfo.pgopt!='None')
       {
       pgt=[select id,name from PGateway_Type__c where name=:pinfo.pgopt and Adaptive_Type__c=:pinfo.thirdparam];
       pg.PGateway_Type__c=pgt.id;
       if(pinfo.pgopt=='PayPal'&&pinfo.thirdparam=='Adaptive')
       {
        string ApiUserName,Apipassword,Apisignature,ApiapplicationId,Apiipaddress,paypalUrl;
        PPPayResponse PayResponse;
        PPResponseEnvelope RespEnvp;
          pg.PG_Email_Id__c=pinfo.firstparam;
          pg.PP_Payment_Type__c='Chained';
          pg.PP_Fee_Payer__c='EACHRECEIVER';
          //validation code for paypal adaptive
          PPAdaptiveToolkit toolkit;
          String PaymentType = 'Chained';
          String FeesPayer = 'EACHRECEIVER';
          String PayeeEmail =pinfo.firstparam;
          List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
    boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='PayPal'];
      
   
       String CommonParametersObjName='MyRequestParams';
            String APICredentialObjName ='SandboxCert';
            
            toolkit = new PPAdaptiveToolkit(APICredentialObjName);
            
            String ActionType='PAY';
            PPPayRequest request;
            try{
                // create request envelope and set the common request parameters
                
                request = new PPPayRequest(CommonParametersObjName, null,ble.BLN_Country__r.Currency__r.Name);   
                
                // set actionType
                request.ActionType = ActionType;  
            }catch(exception ed){
            
                request = new PPPayRequest();
                request.CurrencyCode=ble.BLN_Country__r.Currency__r.Name;
            }
            
            
           
            
              request.CancelUrl = Label.SiteURL +'/apex/BLN_PaymentNewSettings?id='+ble.id+'&tab=staffwithpayment';          
             request.ReturnUrl = Label.SiteURL + '/BLN_Success?id='+ble.id ;
            
            // Set a note associated with the payment        
            request.Memo = ble.Name;  
            // set receiver info in the request
            List<PPReceiver> receiverList = new List<PPReceiver>();
            
            
            try{

                PPReceiver rv = new PPReceiver();
                
                rv.Email =PayeeEmail;
                
                if(PaymentType!='Simple'){
                    rv.Amount = 1.00;
                    rv.primary = TRUE;
                }else{
                    rv.Amount = 1.00;
                }

                ActionType ='PAY';
                receiverList.add(rv); 
                
                if(PaymentType!='Simple'){
                    PPReceiver rv1 = new PPReceiver();
                    if(boothleadspaygate.size()>0){
                
                rv1.Email = boothleadspaygate[0].PG_Email_Id__c;
                System.debug('boothleadspaygate[0].PG_Email_Id__c **'+boothleadspaygate[0].PG_Email_Id__c);
               }
                    
                    ActionType ='PAY'; 
                    rv1.Amount = 1.00;
                    receiverList.add(rv1);
                }
            
            }catch(exception e){}
            
            
            request.receiverList = receiverList;
            // set FeesPayer
            request.FeesPayer = FeesPayer;
            System.debug('receiverList '+receiverList);
           try{
           PayResponse = toolkit.Pay(request);
           }catch(Exception e)
           {
           pinfo.secondparam='Account '+pinfo.firstparam+' is not confirmed by PayPal';
               pinfo.firstparam='Error';
                 pinfo.thirdparam='';
          return pinfo;
           }
           System.debug('PayResponse '+PayResponse);
           
                    
                    
          //end of paypal adaptive validation
       }
       if(pinfo.pgopt=='PayPal'&&pinfo.thirdparam=='Direct')
       {
          pg.PG_User_Key__c=pinfo.firstparam;
          pg.PG_Pass_Secret__c=pinfo.secondparam;
          pg.PG_Signature__c=pinfo.fourthparam;
          //paypal direct validation
           BLN_PaypalProccessorDirect pro = new BLN_PaypalProccessorDirect();
         pro.username = pinfo.firstparam;
          pro.passWord = pinfo.secondparam;
          pro.Signature = pinfo.fourthparam;
          String message=pro.getBalanceRequest();
          if(message!='Success')
          {
           pinfo.secondparam='Credentials not correct';
               pinfo.firstparam='Error';
                 pinfo.thirdparam='';
          return pinfo;
          }
          //end of paypal direct validation
       }
       if(pinfo.pgopt=='Stripe'&&pinfo.thirdparam=='Direct')
       {
          pg.PG_Pass_Secret__c=pinfo.firstparam;
          pg.PG_User_Key__c=pinfo.secondparam;
          //Stripe validation
          HttpRequest http = new HttpRequest();
        http.setEndpoint('https://api.stripe.com/v1/customers');
        http.setMethod('POST');
        Blob headerValue = Blob.valueOf(pinfo.firstparam + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
        http.setBody('description=Test');    

        Http con = new Http();
            HttpResponse hs = con.send(http);
Integer statusCode;
    string response;
            response = hs.getBody();
            statusCode=hs.getStatusCode();
            if(statusCode!=200)
            {
               pinfo.secondparam='Invalid Secret Key provided';
               pinfo.firstparam='Error';
                 pinfo.thirdparam='';
             return pinfo;
            }
          //Stripe validation end
       }
       if(pinfo.pgopt=='Stripe'&&pinfo.thirdparam=='Adaptive')
       {
          pg.PG_Signature__c=pinfo.firstparam;
          pg.PG_User_Key__c=pinfo.secondparam;
          //Stripe ADaptive validation
          
          //
       }
       if(pinfo.pgopt=='Authorize.Net'&&pinfo.thirdparam=='Direct')
       {
          pg.PG_User_Key__c=pinfo.firstparam;
          pg.PG_Signature__c=pinfo.secondparam;
          //Authorize.net validation
          AuthorizeDotNet ath = new AuthorizeDotNet(true,pinfo.firstparam,pinfo.secondparam);
          try{
                ath.process(3);
            }catch(Exception ex){
              System.debug('ex.getMessage() '+ex.getMessage());
            }
            if(ath.response.contains('ID or password is invalid or the account is inactive'))
            {
               pinfo.secondparam='ID is invalid or the account is inactive';
               pinfo.firstparam='Error';
                 pinfo.thirdparam='';
             return pinfo;
            }
            if(ath.response.contains('This transaction cannot be accepted'))
            {
               pinfo.secondparam='Key is invalid or the account is inactive';
               pinfo.firstparam='Error';
                 pinfo.thirdparam='';
             return pinfo;
            }
          //Authorize.net validation end
       }
       if(pinfo.pgopt=='TrustCommerce'&&pinfo.thirdparam=='Direct')
       {
       Http h = new Http();
        HttpRequest req = new HttpRequest();
          pg.PG_User_Key__c=pinfo.firstparam;
          pg.PG_Signature__c=pinfo.secondparam;
           pg.Use_Host_Page__c=Boolean.valueOf(pinfo.fourthparam);
          String url = 'https://vault.trustcommerce.com/trustee/token.php?custid='+pinfo.firstparam+'&password='+pinfo.secondparam;
  
  
  req.setEndpoint(url);
  req.setMethod('POST');
 
  HttpResponse res = h.send(req);
  String xml = res.getBody();
  if(xml==null||xml=='')
            {
               pinfo.secondparam='ID or password is invalid or the account is inactive';
               pinfo.firstparam='Error';
                 pinfo.thirdparam='';
             return pinfo;
            }
       }
       
        
         pg.Company__c=ble.organizer_id__c ;
         BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
         string uid = userInfo.getUserId();
          GN_User__c defaultgn=new GN_User__c();
         defaultgn=gndao.gettinggnuser(uid);
         pg.BLN_GN_User__c=defaultgn.id;
         //duplicate checking for user
         
         
            List<Pay_Gateway__c> existpayg=[select id,name,BLN_GN_User__c,Paygateway_name__c,PGateway_Type__c from Pay_Gateway__c where Paygateway_name__c=:paygatewaykeyname and BLN_GN_User__c=:defaultgn.id  and id!=:paygatewayid];
            if(existpayg.size()>0)
            {
               pinfo.firstparam='Error';
         pinfo.secondparam='Duplicate Key Name';
         pinfo.thirdparam='';
          return pinfo;
            }
        
         //
         
         
         pg.Paygateway_name__c=paygatewaykeyname;
         if(paygatewayid!='on'&&paygatewayid!='')
         pg.id=paygatewayid;
       upsert pg;
       pinfo.firstparam='Success';
       pinfo.secondparam=pg.id;
       pinfo.thirdparam='';
      
       }
       return pinfo;
     }catch (System.DmlException e) {
        String message='';
        for (Integer i = 0; i < e.getNumDml(); i++) {
        // Process exception here 
        
        message= e.getDmlMessage(i); 
    }
    pinfo.firstparam='Error';
    pinfo.secondparam=message;
    pinfo.thirdparam='';
    return pinfo;
     }
    catch(Exception e)
    {
        pinfo.firstparam='Error';
         pinfo.secondparam=e.getMessage();
         pinfo.thirdparam='';
          return pinfo;
        
    }
    
    } 
    
    @RemoteAction
    global static String new_savesPaymentOption(String payjsonInput,String eventID,String cheque,String cash,String external,String cashcheckexternalcardcustomerid,String cashcheckexternalcarddetails,String tckopt,String feeopt,String module,String requestcomingfrom,String acceptrangeforgt,String mingt,String acceptrangeforcheck,String mincheck) {
    //Ticket object
    PaymentOpt pinfo;
    BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
         string uid = userInfo.getUserId();
          GN_User__c defaultgn=new GN_User__c();
         defaultgn=gndao.gettinggnuser(uid);
         
   
    // Parse entire JSON response for event mandatory fields.
    JSONParser parser = JSON.createParser(payjsonInput);
    while (parser.nextToken() != null) {
        
                    pinfo= (PaymentOpt)parser.readValueAs(PaymentOpt.class);
                   

       } 
      System.debug('pinfo'+pinfo); 
      boolean chargeflag=false;
      try{   
    if((pinfo.pgopt=='Stripe'||pinfo.pgopt=='Authorize.Net'||pinfo.pgopt=='TrustCommerce'||pinfo.pgopt=='PayPal')&&pinfo.thirdparam=='Direct')
    {
     chargeflag=true;
     BLN_Event__c eve=[select id,organizer_id__c,organizer_id__r.PG_Authorization_Key__c,ownerid from BLN_Event__c where id=:eventID];
      Company__c comp=[select id,name,PG_Authorization_Key__c from Company__c where id=:eve.organizer_id__c];
 
      if(requestcomingfrom!='M'){
     if(pinfo.secondparam=='Check')
     {
         try{
       comp.PG_Authorization_Key__c =pinfo.secondparam;
       comp.PG_Authorization_Card_Type__c='';
       comp.PG_Authorization_CC_Last_four_Digit__c='';
       }catch(Exception e){}
       update comp;
     }
     else{
     string[] splitted = pinfo.secondparam.split(';'); 
     List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
 boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='Stripe'];
 String  Stripe_API_Key='';     
       if(boothleadspaygate.size()>0){
                 Stripe_API_Key = boothleadspaygate[0].PG_Pass_Secret__c;
                 }         
   System.debug('splitted'+splitted);  
  Stripe StripeRequest = new Stripe(Stripe_API_Key);
  StripeResponseModel StripeResponse = StripeRequest.createCustomer(splitted[0],splitted[1],splitted[2],splitted[3],'AB','AB','AB','123123','Rajasthan','India','gamer.sanjay@gmail.com','testing');
   if(StripeResponse.isError==true)
   return StripeResponse.errorResponse.message;
   else
   {
       comp.PG_Authorization_Key__c =StripeResponse.id;
       try{
       string[] split = pinfo.fourthparam.split(';');
       comp.PG_Authorization_Card_Type__c=split[0];
       comp.PG_Authorization_CC_Last_four_Digit__c=split[1];
       }catch(Exception e){}
       update comp;
   }
   }
     }
     else
     {
         
        comp.PG_Authorization_Key__c =pinfo.secondparam;
         try{
       string[] split = pinfo.fourthparam.split(';');
        comp.PG_Authorization_Card_Type__c=split[0];
       comp.PG_Authorization_CC_Last_four_Digit__c=split[1];
       }catch(Exception e){}
       update comp;
     }
     
    }
    }catch(Exception e){}
    
    try{   
    if((cash=='true'||cheque=='true'||external=='true')&&chargeflag==false)
    {
     chargeflag=true;
     BLN_Event__c eve=[select id,organizer_id__c,organizer_id__r.PG_Authorization_Key__c,ownerid from BLN_Event__c where id=:eventID];
      Company__c comp=[select id,name,PG_Authorization_Key__c from Company__c where id=:eve.organizer_id__c];
 
      if(requestcomingfrom!='M'){
     if(cashcheckexternalcardcustomerid=='Check')
     {
         try{
       comp.PG_Authorization_Key__c =cashcheckexternalcardcustomerid;
       comp.PG_Authorization_Card_Type__c='';
       comp.PG_Authorization_CC_Last_four_Digit__c='';
       }catch(Exception e){}
       update comp;
     }
     else{
     string[] splitted = cashcheckexternalcardcustomerid.split(';'); 
     List<Pay_Gateway__c> boothleadspaygate = new List<Pay_Gateway__c>();
 boothleadspaygate = [SELECT id,Company__c,Min_amount_to_accept__c,PGateway_Type__c,PGateway_Type__r.Name,PGateway_Type__r.Adaptive_Type__c,PG_Email_Id__c,PG_Pass_Secret__c,PG_Signature__c,PG_User_Key__c,PP_Fee_Payer__c,PP_Payment_Type__c,Service_Fee__c from Pay_Gateway__c where Company__r.Name ='EventdexLive' and PGateway_Type__r.Name='Stripe'];
 String  Stripe_API_Key='';     
       if(boothleadspaygate.size()>0){
                 Stripe_API_Key = boothleadspaygate[0].PG_Pass_Secret__c;
                 }         
   System.debug('splitted'+splitted);  
  Stripe StripeRequest = new Stripe(Stripe_API_Key);
  StripeResponseModel StripeResponse = StripeRequest.createCustomer(splitted[0],splitted[1],splitted[2],splitted[3],'AB','AB','AB','123123','Rajasthan','India','gamer.sanjay@gmail.com','testing');
   if(StripeResponse.isError==true)
   return StripeResponse.errorResponse.message;
   else
   {
       comp.PG_Authorization_Key__c =StripeResponse.id;
       try{
       string[] split = cashcheckexternalcarddetails.split(';');
       comp.PG_Authorization_Card_Type__c=split[0];
       comp.PG_Authorization_CC_Last_four_Digit__c=split[1];
       }catch(Exception e){}
       update comp;
   }
   }
     }
     else
     {
        comp.PG_Authorization_Key__c =cashcheckexternalcardcustomerid;
         try{
       string[] split = cashcheckexternalcarddetails.split(';');
        comp.PG_Authorization_Card_Type__c=split[0];
       comp.PG_Authorization_CC_Last_four_Digit__c=split[1];
       }catch(Exception e){}
       update comp;
     }
    }
    }catch(Exception e){}
    List<Event_Pay_Gateway__c> delepg=[select id,name,Events__c,Pay_Gateway__c,Pay_Gateway__r.PGateway_Type__r.Name from Event_Pay_Gateway__c where Events__c=:eventID and Registration_Type__c=:module and Pay_Gateway__r.PGateway_Type__r.Name!='Free'];
    
    
    
    //for cash
    String cashpgid;
    Pay_Gateway__c cpg;
     List<Event_Pay_Gateway__c> cashpg=[select id,name,Events__c,Pay_Gateway__c,Pay_Gateway__r.PGateway_Type__r.Name from Event_Pay_Gateway__c where Events__c=:eventID and Registration_Type__c=:module and Pay_Gateway__r.PGateway_Type__r.Name='Cash' limit 1];
     if(cashpg.size()>0){
    cpg=[select id,name,PGateway_Type__c,PGateway_Type__r.Name from Pay_Gateway__c where id=:cashpg[0].Pay_Gateway__c];
    if(cash=='true')
       {
          cashpgid=cpg.id;
       }
       else
       {
        //delete cashpg;
       }
     }
    
    //
    //for check
    String checkpgid;
     List<Event_Pay_Gateway__c> checkpg=[select id,name,Events__c,Pay_Gateway__c,Pay_Gateway__r.PGateway_Type__r.Name from Event_Pay_Gateway__c where Events__c=:eventID and Registration_Type__c=:module and Pay_Gateway__r.PGateway_Type__r.Name='Check' limit 1];
     if(checkpg.size()>0){
    cpg=[select id,name,PGateway_Type__c,PGateway_Type__r.Name from Pay_Gateway__c where id=:checkpg[0].Pay_Gateway__c];
    if(cheque=='true')
       {
          checkpgid=cpg.id;
       }
       else
       {
        //delete checkpg;
       }
     }
    
    //
    
    //for external
    String externalpgid;
     List<Event_Pay_Gateway__c> externalpg=[select id,name,Events__c,Pay_Gateway__c,Pay_Gateway__r.PGateway_Type__r.Name from Event_Pay_Gateway__c where Events__c=:eventID and Registration_Type__c=:module and Pay_Gateway__r.PGateway_Type__r.Name='External Pay Gateway' limit 1];
     if(externalpg.size()>0){
    cpg=[select id,name,PGateway_Type__c,PGateway_Type__r.Name from Pay_Gateway__c where id=:externalpg[0].Pay_Gateway__c];
    if(external=='true')
       {
          externalpgid=cpg.id;
       }
       else
       {
        //delete externalpg;
       }
     }
    
    //
    
    delete delepg;
     BLN_Event__c ble=[select id,name,Event_Ticket_Options__c,Service_Fee__c,organizer_id__c from BLN_Event__c where id=:eventID];
     
     
    try{
    
  if(tckopt!=''&&feeopt!='')
  {
    ble.Event_Ticket_Options__c=tckopt;
    ble.Service_Fee__c=feeopt;
    update ble;
    }
    }catch(Exception e){}
    
    try{
    
       Pay_Gateway__c pg=new Pay_Gateway__c();
       BLN_Company_DAO company = new BLN_Company_DAO();
       Event_Pay_Gateway__c epg=new Event_Pay_Gateway__c();
       Company__c companyId ;
       PGateway_Type__c pgt;
       
      
       try{
       if(pinfo.pgopt!='None')
       {
      epg.Pay_Gateway__c=pinfo.firstparam;
      epg.Events__c=eventID;
      epg.Registration_Type__c=module;
      if(acceptrangeforgt=='true')
      {
        epg.Accept_Min_Max_Range__c=true;
         try{
         epg.Min_amount_to_accept__c=Decimal.valueOf(mingt);
         }catch(Exception e){}
      }
      else
      epg.Min_amount_to_accept__c=null;
      insert epg;
       }
       }catch(Exception e){}
       if(cheque=='true')
       {
           pgt=[select id,name from PGateway_Type__c where name='Check'];
       pg=new Pay_Gateway__c();
       pg.PGateway_Type__c=pgt.id;
            pg.Company__c=ble.organizer_id__c ;
            pg.BLN_GN_User__c=defaultgn.id;
            if(checkpgid!=null)
          pg.id=checkpgid;
       upsert pg;
      
      epg=new Event_Pay_Gateway__c();
      epg.Pay_Gateway__c=pg.id;
      epg.Events__c=eventID;
      epg.Registration_Type__c=module;
      if(acceptrangeforcheck=='true')
      {
        epg.Accept_Min_Max_Range__c=true;
         try{
         epg.Min_amount_to_accept__c=Decimal.valueOf(mincheck);
         }catch(Exception e){}
      }
      else
      epg.Min_amount_to_accept__c=null;
      insert epg;  
       }
        try{
    if(external=='true')
       {
          pgt=[select id,name from PGateway_Type__c where name='External Pay Gateway'];
       pg=new Pay_Gateway__c();
       pg.PGateway_Type__c=pgt.id;
          pg.Company__c=ble.organizer_id__c ; 
          pg.BLN_GN_User__c=defaultgn.id;
          if(externalpgid!=null)
          pg.id=externalpgid;
       upsert pg;
      
      epg=new Event_Pay_Gateway__c();
      epg.Pay_Gateway__c=pg.id;
      epg.Events__c=eventID;
      epg.Registration_Type__c=module;
       insert epg; 
      //return; 
       }
       }catch(Exception e){}
        if(cash=='true')
       {
           pgt=[select id,name from PGateway_Type__c where name='Cash'];
       pg=new Pay_Gateway__c();
       pg.PGateway_Type__c=pgt.id;
            pg.Company__c=ble.organizer_id__c ;
            pg.BLN_GN_User__c=defaultgn.id;
            if(cashpgid!=null)
          pg.id=cashpgid;
       upsert pg;
      
      epg=new Event_Pay_Gateway__c();
      epg.Pay_Gateway__c=pg.id;
      epg.Events__c=eventID;
      epg.Registration_Type__c=module;
      insert epg;  
       }
       
       
       }catch(Exception e){}
       
       //Active Paygateways logic
    try{
       Pay_Gateway__c activep=[select id,name,Company__c,Active_Paygateway__c,PGateway_Type__c from Pay_Gateway__c where id=:pinfo.firstparam];
       List<Pay_Gateway__c> activelist=[select id,name,Company__c,Active_Paygateway__c,PGateway_Type__c from Pay_Gateway__c where PGateway_Type__c=:activep.PGateway_Type__c and Company__c=:activep.Company__c];
      
        for(integer i=0;i<activelist.size();i++)
        {
           if(activelist[i].id==activep.id)
           activelist[i].Active_Paygateway__c=true;
           else
           activelist[i].Active_Paygateway__c=false;
        }
       update activelist;
       }catch(Exception e){}
       return 'success';
       }     
      global class PaymentOpt
       {
           public String pgopt{get;set;}
           public String firstparam{get;set;}
           public String secondparam{get;set;}
           public String thirdparam{get;set;}
           public String fourthparam{get;set;}
           
           public PaymentOpt(String pgopt,String firstparam,String secondparam,String thirdparam)
           {
              this.pgopt=pgopt;
              this.firstparam=firstparam;
              this.secondparam=secondparam;
              this.thirdparam=thirdparam;
           }
           public PaymentOpt(String pgopt,String firstparam,String secondparam,String thirdparam,String fourthparam)
           {
              this.pgopt=pgopt;
              this.firstparam=firstparam;
              this.secondparam=secondparam;
              this.thirdparam=thirdparam;
              this.fourthparam=fourthparam;
           } 
           
       }
    
    
    
    public String authCode{get;set;}
    public String authorizationCodeURI{get;set;}
    public String body{get;set;}
    public JSONWrapper jsonWrapObj{get;set;}
     global class JSONWrapper{    
        public Integer expires_in;
        public String access_token{get;set;}  
        public String refresh_token{get;set;}
    }
    
   //Get Event Data On Load
    @RemoteAction
    global static BLN_Event__c getEvents(String eventID) {
    return [select id,name,Accept_Refund_Policy__c,Refund_Policy__c,Accept_Terms_Conditions__c,Terms_Conditions__c,Accept_Tax_Rate__c,Tax_Rate__c,Registration_Template__c,Logo_URL__c,Event_Status__c,Event_Ticket_Options__c,Service_Fee__c,Start_Date__c,End_Date__c,Venue_Name__c,Organizer_Email__c,BLN_State__c,BLN_Country__c,City__c,Language_Settings__c,BLN_Country__r.Currency__c,Time_Zone__c,organizer_id__r.name,(select Company__r.name from User_Company__r),(select Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r),Event_Type__c,Description__c,Street1__c,Street2__c,Twitter_Hash_Tag__c,Twitter_URL__c,Facebook_URL__c,LinkedIn_URL__c,Website_Url__c,ZipCode__c,Phone_Number__c,PO_Box__c from BLN_Event__c where id=:eventID limit 1];
    }
    
    @RemoteAction
    global static Event getnewEvents(String eventID) {
    BLN_Event__c blevent=[select id,name,Accept_Refund_Policy__c,Refund_Policy__c,Accept_Terms_Conditions__c,Terms_Conditions__c,Accept_Tax_Rate__c,Tax_Rate__c,Registration_Template__c,Logo_URL__c,Event_Status__c,Event_Ticket_Options__c,Service_Fee__c,Start_Date__c,End_Date__c,Venue_Name__c,Organizer_Email__c,BLN_State__c,BLN_Country__c,City__c,Language_Settings__c,BLN_Country__r.Currency__c,Time_Zone__c,organizer_id__r.name,(select Company__r.name from User_Company__r),(select Registration_Type__c,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.Id,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PG_User_Key__c,Accept_Min_Max_Range__c,Min_amount_to_accept__c from Event_Pay_Gateway__r),(select id,name,BLN_Country__c,BLN_Event__c from BLN_Event_Counties_Include__r),Event_Type__c,Description__c,Street1__c,Street2__c,Twitter_Hash_Tag__c,Twitter_URL__c,Facebook_URL__c,LinkedIn_URL__c,Website_Url__c,ZipCode__c,Phone_Number__c,PO_Box__c from BLN_Event__c where id=:eventID limit 1];
    Event newe=new Event();
    newe.ble=blevent;
    
    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
    tz.tZone=blevent.time_zone__c;
    tz.format='MM/dd/yyyy hh:mm a';
    tz.dateTimeValue=blevent.Start_Date__c;
    newe.startdate=tz.getTimeZoneValue();
    
    tz.dateTimeValue=blevent.End_Date__c;
    newe.enddate=tz.getTimeZoneValue();
    
   
    //newe.enddate=edt.format('MM/dd/yyyy hh:mm a');
    //DateTime dt=blevent.Start_Date__c;
    //newe.startdate=blevent.Start_Date__c;//dt.formatGMT('MM/dd/yyyy');
    //dt=blevent.End_Date__c;
    //newe.enddate=blevent.End_Date__c;//dt.formatGMT('MM/dd/yyyy');
    return newe;
    }
    
    global class Event
    {
       public BLN_Event__c ble{get;set;}
       public string startdate{get;set;}
       public string enddate{get;set;}
    }
    //Get Ticket Data On Load
    @RemoteAction
    global static List<Item_Pool__c> getSavedTickets(String eventID) {
    return [select Id,Name,Item_Pool_Name__c,Ticketed_Sessions__c,Item_Count__c,Event__c,Package_Flag__c,Item_Type__c,Badge_Label__c,Badgable__c,Addon_Parent__c from  Item_Pool__c where Event__c=:eventID and Addon_Parent__c=null order by Ordering__c];
    }
    
    @RemoteAction
    global static List<BLN_Item__c> getItemsBasedOnPool(String poolId) {
    return [select id,item_name__c,Item_Type__r.name,Item_Pool__c,Item_Pool__r.Name,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.id,Item_Pool__r.Item_Count__c,Item_Pool__r.Item_Type__r.Id,Item_Pool__r.Item_Type__r.Name,Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c,Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c,sale_start__c,sale_end__c,Early_Bird_Pricing_Display_Flag__c,Visibility__c,Taxable__c,
                                    service_fee__c ,item_count__c ,image_url__c,item_type__c,Payment__c,Description__c,Event__c,price__c,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,Available_Tickets__c,Currency_Code__c,Ticket_Settings__c,(Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id  FROM Item_Question__r),(select id,Name,Item_Type__c,Ticket_Settings__c from Items__r),(SELECT id,Defaullt_Label__c,Label_Name__c,Included__c from Reg_Settings__r WHERE ((Column_Name__c='Home_Phone__c' AND Included__c=true) OR (Column_Name__c='Work_Phone__c' AND Included__c=true) OR (Column_Name__c='Work Address' AND Included__c=true) OR (Column_Name__c='Home Address' AND Included__c=true)) and  Setting_Type__c='Regular')  from  BLN_Item__c where Item_Pool__c=:poolId order by Ordering__c];
    }
    
     @RemoteAction
    global static List<Item> getnewItemsBasedOnPool(String poolId,String eventID) {
    List<BLN_Item__c> listit= [select  id,item_name__c,Item_Type__r.name,Item_Pool__c,Item_Pool__r.Name,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.id,Item_Pool__r.Item_Count__c,Item_Pool__r.Item_Type__r.Id,Item_Pool__r.Item_Type__r.Name,Item_Pool__r.Item_Type__r.BL_Fee_Amt_per_res__c,Item_Pool__r.Item_Type__r.BL_Fee_Pct_per_res__c, max_per_order__c, min_per_order__c,sale_start__c,sale_end__c,Early_Bird_Pricing_Display_Flag__c,Visibility__c,Taxable__c,
                                    service_fee__c ,item_count__c ,image_url__c,item_type__c,Payment__c,Description__c,Event__c,price__c,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,Available_Tickets__c,Currency_Code__c,Ticket_Settings__c,(Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id  FROM Item_Question__r),(select id,Name,Item_Type__c,Ticket_Settings__c from Items__r)  from  BLN_Item__c where Item_Pool__c=:poolId order by Ordering__c];
    BLN_Event__c  ble=[select id,name,Time_Zone__c from BLN_Event__c where id=:eventID limit 1];
    List<Item> litem=new List<Item>();
    for(BLN_Item__c newi:listit)
    {
       Item newitem=new Item();
       newitem.ite=newi;
       newitem.startdate=newi.sale_start__c.format('MM/dd/yyyy hh:mm a',ble.Time_Zone__c);
       newitem.enddate=newi.sale_end__c.format('MM/dd/yyyy hh:mm a',ble.Time_Zone__c);
       litem.add(newitem); 
    }
    
    return litem;
    }
    
    global class Item
    {
       public BLN_Item__c ite{get;set;}
       public String startdate{get;set;}
       public String enddate{get;set;}
    }
   
   
    @RemoteAction
    global static List<Item_Pool__c> getAddonPool(String poolId) {
    return [select Id,Name,Item_Pool_Name__c,Addon_Count__c,Addon_Parent__c,Package_Flag__c,Item_Type__c,Badge_Label__c,Badgable__c,(select id,name,ParentId__c,BLN_Item_Pool__c from BLN_Event_Tags__r) from  Item_Pool__c where Addon_Parent__c=:poolId order by lastmodifieddate];
    }
    
    //Get Tag Data On Load
    @RemoteAction
    global static List<Hash_Tag__c> getSavedTags(String eventID) {
    return [select Id,Event__c,Tag_Text__c,Table_Name__c,RowId__c,ParentId__c from  Hash_Tag__c where Event__c=:eventID and RowId__c!=null];
    //return [select Id,Pool_Id__c,Tag_Id__c,Tag_Id__r.Event__c from ItemPool_Tag_Junction__c where Tag_Id__r.Event__c=:eventID order by lastmodifieddate];
    
    }
    
    @RemoteAction
    global static Company_Ext__c getCompanyExtDetails(String eventID) {
    BLN_Event__c  e=[select id,name,organizer_id__c from BLN_Event__c where id=:eventID limit 1];
    
    return [select Id,Name,Business_Address1__c,Business_Address2__c,Business_City__c,BLN_Business_Country__c,BLN_Business_State__c,Business_Zipcode__c,Company__c from  Company_Ext__c where Company__c=:e.organizer_id__c limit 1];
    }
    
    @RemoteAction
    global static String createCompanyExtDetails(String eventID,String companyextid,String chqaddr1,String chqaddr2,String chqcity,String chqcountry,String chqstate,String chqZip) {
     BLN_Event__c ble=[select id,name,organizer_id__c from BLN_Event__c where id=:eventID];
   
    Company_Ext__c cxt=new Company_Ext__c(Company__c =ble.organizer_id__c,Business_Address1__c=chqaddr1,Business_Address2__c=chqaddr2,Business_City__c=chqcity,Business_Zipcode__c=chqZip);
    if(chqcountry!='')
    cxt.BLN_Business_Country__c=chqcountry;
    if(chqstate!='')
    cxt.BLN_Business_State__c=chqstate;
    if(companyextid=='')
    {
    
     insert cxt;
     return cxt.id;
    }
     else
     {
      cxt.id=companyextid;
      update cxt;
      return cxt.id;
     }
    
    }
    
    @RemoteAction
    //both using from attendee and ticket screen
    global static String createEventTag(String eventID,String tagText,String tagtype) {
    Hash_Tag__c htag;
    
    try{
    htag=[select id,Tag_Text__c,Event__c,Table_Name__c,RowId__c from Hash_Tag__c where Event__c=:eventID and Tag_Text__c=:tagText and RowId__c=null limit 1];
    return '';
    }catch(Exception e){
    //create if record not found
    htag=new Hash_Tag__c();
    htag.Tag_Text__c=tagText;
    htag.Table_Name__c=tagtype;
    htag.Event__c=eventID;
    insert htag;
    return htag.Id;
    
    }
    
    }
    
   
    
     @RemoteAction
     //fetch from both ticket and attendee screen
    global static List<Hash_Tag__c> getEventTag(String eventID,String tagtype) {
    return  [select id,Tag_Text__c,Event__c,RowId__c from Hash_Tag__c where Event__c=:eventID and Table_Name__c=:tagtype and RowId__c=null];
    }
    
    @RemoteAction
     global static String updateEventTag(String eventID,String oldtagtext,String newtagtext) {
    Hash_Tag__c htag=[select id,Tag_Text__c,Event__c,RowId__c from Hash_Tag__c where Event__c=:eventID and Tag_Text__c=:oldtagtext  and RowId__c=null limit 1];
    htag.Tag_Text__c=newtagtext;
    update htag;
    
    //update associated item pool records
    List<Hash_Tag__c> htaglist=[select id,Tag_Text__c,Event__c,RowId__c from Hash_Tag__c where Event__c=:eventID and Tag_Text__c=:oldtagtext];
    for(integer i=0;i<htaglist.size();i++)
    {
       htaglist[i].Tag_Text__c=newtagtext;
    }
    update htaglist;
    
    return htag.id;
    }
    @RemoteAction
     global static String updateEventTagwithId(String eventID,String Id,String newtagtext) {
    Hash_Tag__c htag=[select id,Tag_Text__c,Event__c,RowId__c from Hash_Tag__c where Event__c=:eventID and Id=:Id  and RowId__c=null limit 1];
    String oldtagtext=htag.Tag_Text__c;
    htag.Tag_Text__c=newtagtext;
    update htag;
    
    //update associated item pool records
    List<Hash_Tag__c> htaglist=[select id,Tag_Text__c,Event__c,RowId__c from Hash_Tag__c where Event__c=:eventID and Tag_Text__c=:oldtagtext];
    for(integer i=0;i<htaglist.size();i++)
    {
       htaglist[i].Tag_Text__c=newtagtext;
    }
    update htaglist;
    
    return htag.id;
    }
    
    @RemoteAction
    global static void deleteEventTag(String eventID,String tagtext) {
    List<Hash_Tag__c> htag=[select id,Tag_Text__c,RowId__c,Event__c from Hash_Tag__c where Event__c=:eventID and Tag_Text__c=:tagtext];
    //List<ItemPool_Tag_Junction__c> itjuns=[select id,Tag_Id__c,Tag_Id__r.Tag_Text__c from ItemPool_Tag_Junction__c where Tag_Id__c=:htag.Id];
    //delete itjuns;
    //List<Reg_Setting__c> tagregsetting=[select id,Tag_Id__c,Event__c,Tag_Id__r.Tag_Text__c from Reg_Setting__c where Tag_Id__c=:htag.Id and Event__c=:eventID];
    //delete tagregsetting;
    
    
    delete htag;
    } 
    
    @RemoteAction
    global static void deleteTicketLevelTag(String eventID,String tagtext,String ticketids) {
    List<string> selected_ticlistTemp=new List<string>();
    selected_ticlistTemp= ticketids.split(',');
    List<Hash_Tag__c> htag=[select id,Tag_Text__c,Event__c,RowId__c,table_name__c  from Hash_Tag__c where Event__c=:eventID and Tag_Text__c=:tagtext and RowId__c in:selected_ticlistTemp and table_name__c='Ticket__c'];
    delete htag;
    List<Hash_Tag__c> htagr=[select id,Tag_Text__c,Event__c,RowId__c,table_name__c  from Hash_Tag__c where Event__c=:eventID and Tag_Text__c=:tagtext];
    if(htagr.size()==1)
    delete htagr;
    
    } 
    
    @RemoteAction
    //only show ticket level tags
    global static String getAllSelectedTag(String eventID,String ticketids) {
    List<string> selected_ticlistTemp=new List<string>();
    selected_ticlistTemp= ticketids.split(',');
    
    List<Hash_Tag__c> htaglist=[select id,Tag_Text__c,Event__c,RowId__c,table_name__c  from Hash_Tag__c where Event__c=:eventID and RowId__c in:selected_ticlistTemp];
    String tagnames='';
    for(Hash_Tag__c htag:htaglist)
    {
       tagnames+=htag.Tag_Text__c+',';
    }
    return tagnames;
    
    
    }
    
    
    
    
    @RemoteAction
    global static void deleteItemPool(String poolid)
    {
   
     List<BLN_Item__c> delitems=[select id,name,event__c,Item_Pool__c,Available_Tickets__c,item_count__c from BLN_Item__c where Item_Pool__c=:poolid];
     String eventid='';
     try{
     eventid=delitems[0].event__c;}catch(Exception e){}
    delete delitems;
    List<Item_Pool__c> delchilditemspool=[select id,name,Addon_Parent__c from Item_Pool__c where Addon_Parent__c=:poolid];
    delete delchilditemspool;
    List<Item_Pool__c> delitemspool=[select id,name from Item_Pool__c where id=:poolid];
    delete delitemspool; 
    //update the order for all items
    try{
    List<Item_Pool__c> upitempoollist=new List<Item_Pool__c>();
    List<BLN_Item__c> upitems=[select id,name,event__c,Item_Pool__c,Available_Tickets__c,ordering__c,item_count__c from BLN_Item__c where event__c=:eventid order by ordering__c];
    Map<String,Decimal> exstpool = new Map<String,Decimal>();
    for(integer i=0,j=1;i<upitems.size();i++){
    if(exstpool.containsKey(upitems[i].Item_Pool__c)){
    upitems[i].ordering__c=exstpool.get(upitems[i].Item_Pool__c);
    }
    else
    {
    upitems[i].ordering__c=j;
    j=j+1;
    exstpool.put(upitems[i].Item_Pool__c,upitems[i].ordering__c);
    Item_Pool__c itpool=new Item_Pool__c(id=upitems[i].Item_Pool__c,ordering__c=upitems[i].ordering__c);
    upitempoollist.add(itpool);
    }
    }
    update upitems;
    update upitempoollist;
    }catch(Exception e){}
    
    
     
   
    }
    
    @RemoteAction
    global static void updateorderingitems(String sourceitemids,String sourcepoolid,String sourceorder,String destinationitemids,String destpoolid,String destinationorder)
    {
     List<BLN_Item__c> upitems=new List<BLN_Item__c>();
     List<Item_Pool__c> upitempool=new List<Item_Pool__c>();
      List<String> sourceitemlist= sourceitemids.Split(','); 
      for(String s:sourceitemlist)
      {
        BLN_Item__c upit=new BLN_Item__c();
        upit.id=s;
        upit.ordering__c=Integer.valueOf(sourceorder);
        upitems.add(upit);
      }
      
      List<String> destitemlist= destinationitemids.Split(','); 
      for(String s:destitemlist)
      {
        BLN_Item__c upit=new BLN_Item__c();
        upit.id=s;
        upit.ordering__c=Integer.valueOf(destinationorder);
        upitems.add(upit);
      }
      
      update upitems;
      Item_Pool__c it=new Item_Pool__c();
      it.id=sourcepoolid;
      it.ordering__c=Integer.valueOf(sourceorder);
      update it;
      Item_Pool__c dit=new Item_Pool__c();
      dit.id=destpoolid;
      dit.ordering__c=Integer.valueOf(destinationorder);
      update dit;
   }
    
    
    
    @RemoteAction
    global static void deleteaddonItemPool(String poolid)
    {
    List<String> split= poolid.Split(',');
   
    
     List<Ticket__c> tc=[select id,name,Item_Pool__c from Ticket__c where Item_Pool__c in:split];
     delete tc;
    List<Item_Pool__c> delitemspool=[select id,name from Item_Pool__c where id in:split];
    delete delitemspool;   
    }
    
    
    
     //autocomplete search code for company----Arindam Sarkar
    
    public Object selectValue{get; set;}
    public Company__c comp{get;set;}
     public String searchValue {get; set;}
    public Integer maxHeights {get; set;}
    public Integer height {get; set;}
    public List<SelectOption> results {get; set;}
    public Boolean showList {get; set;}
    Map<String,String> resultsMap;
 
    //This is our seach method that is called every time a character is entered
    public void search(){
    comp=new Company__c();
        showList = true;
        results = new List<SelectOption>();
        resultsMap = new Map<String,String>();
 
        //Using dynamic SOQL we pass the object and the search value
        if(searchValue.length() > 0){
            String entry = '%' + searchValue + '%';
            String queryString = 'Select GN_User__c,Company__c,Company__r.name,RoleId__r.name,event__c,User_Type__c from ' + 'UC_Role__c '+ ' where Company__r.name like :entry and GN_User__r.email__c=\''+UserInfo.getUserEmail()+'\' and RoleId__r.name=\'Company Admin\' and Event__c=null and User_Type__c!=\'Personal\' order by Company__r.name limit 1000';
            
          List<UC_Role__c > listc=Database.query(queryString);
          
            for(UC_Role__c o : listc){
                  
                   results.add(new SelectOption(o.Company__c,o.Company__r.name));
                resultsMap.put(o.Company__c,o.Company__r.name);          
            }
            
        }
 
        //Next we inspect the results to set the height and contents of the selectList
        if(searchValue.length() == 0){
            showList = false;
        }else if(results.size() == 0 && searchValue.length() != 0){
            results.add(new SelectOption('','No matches found'));
            height = 2;
        }else if(results.size() == 1){
            height = 2;
        }else if(results.size() > maxHeights){
            height = maxHeights;
        }else{
            height = results.size();
        }
    }
 
    //When a value is selected we will auto complete the searchValue
    public void selectValue(){
        showList = false;
        searchValue = resultsMap.get((string)comp.name);
        
    }
 
    //simply hides the list of results
    public void hideResults(){
        showList = false;
        
    }

    //end of autocomplete search code
    global class ItemType
    {
      public String badgable{get;set;}
      public String badgelabel{get;set;}
      public Integer arrindex{get;set;}
    }
    
    
    @RemoteAction
    global static ItemType getbadgeinfo(String itemtypeid,Integer arrindex) {
   
       
      Item_type__c ep=[select id,name,badge_label__c,badgable__c from Item_type__c where id=:itemtypeid limit 1];
      
          ItemType itinfo1=new ItemType();
        itinfo1.badgable=ep.badgable__c ;
        itinfo1.badgelabel=ep.badge_label__c;
        itinfo1.arrindex=arrindex;
        
        
       
    return itinfo1;
    }
    
     
     @RemoteAction
    global static String getTimeZoneValue(Long dateTimeValue) {
        
            DateTime dt=DateTime.newInstance(dateTimeValue);
            
            return dt.formatGMT('MM/dd/yyyy');
            
       
    }
    @RemoteAction
    global static itemdates getTimeZoneValueforitem(String eventID,Long dateTimeValue,Long dateTimeValue1,Integer l,Integer ik) {
        BLN_Event__c  ble=[select id,name,Time_Zone__c from BLN_Event__c where id=:eventID limit 1];
           
            itemdates itemdates=new itemdates();
            itemdates.l=l;
            itemdates.ik=ik;
             DateTime dt=DateTime.newInstance(dateTimeValue);
             DateTime dt1=DateTime.newInstance(dateTimeValue1);
            itemdates.itdate=dt.format('MM/dd/yyyy hh:mm a',ble.Time_Zone__c)+','+dt1.format('MM/dd/yyyy hh:mm a',ble.Time_Zone__c);
            return itemdates;
       
    }
    global class itemdates
    {
        public Integer l{get;set;}
         public Integer ik{get;set;}
          public String itdate{get;set;} 
    }
    
    public PageReference refreshAF()
    {
       
       System.debug('eventids '+ApexPages.currentPage().getParaMeters().get('eventids'));
       eventOptions = new LIST<Event_Price__c>();
       
        
         eventOptions.addAll(BLN_ItemType_DAO.eventOptionItemTypes(BLN_Event_UtilityCon.displayEventOptions(),ApexPages.currentPage().getParaMeters().get('eventids'))); 
         eventSelectOptions = new LIST<eventOptionsWrapper>();
         
         for(Event_Price__c itp: eventOptions){
                eventSelectOptions.add(new eventOptionsWrapper(FALSE, itp ));
         }
         try{
          LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
     BLN_Event_DAO evDAO = new BLN_Event_DAO();
         eventsList =  evDAO.getEventDetails(ApexPages.currentPage().getParaMeters().get('eventids'));
    defaultnooftickets=String.valueOf(eventsList[0].Max_Num_Tickets__c);
    }catch(Exception e){defaultnooftickets=(String)BLN_Event__c.Max_Num_Tickets__c.getDescribe().getDefaultValueFormula();} 
         
         //geting individual ticket standard item types
          individualTicketsSelectOptions = new LIST<selectOption>();
          BLPRODTicketsSelectOptions=new LIST<selectOption>();
         SET<String> eventOptionsItemTypes = new SET<String>();
        BLN_Event_UtilityCon eventUtility = new BLN_Event_UtilityCon();
         eventOptionsItemTypes.addAll(eventUtility.allMainItemType());
        LIST<Event_Price__c> individualTicketsItemTypess = new LIST<Event_Price__c>();
        individualTicketsItemTypess = BLN_ItemType_DAO.itemTypesforIndividualTickets(eventOptionsItemTypes,ApexPages.currentPage().getParaMeters().get('eventids'));
        
         individualTicketsSelectOptions = BLN_ItemType_BAL.itemTypeSelectOptions(individualTicketsItemTypess);
         //Adding event option types
         for(Event_Price__c itemtpe:[select item_type__r.id,item_type__r.name,item_type__r.Item_Type_Number__c from Event_Price__c where (item_type__r.Item_Type_Number__c='IT-000010' or item_type__r.Item_Type_Number__c='IT-000004' or item_type__r.Item_Type_Number__c='IT-000003' or item_type__r.Item_Type_Number__c='IT-000007') and Active_Flag__c=true and Event__c=:ApexPages.currentPage().getParaMeters().get('eventids') order by item_type__r.Order__c])
         BLPRODTicketsSelectOptions.add(new SelectOption(itemtpe.item_type__r.id,itemtpe.item_type__r.name));
         //
          //get all the Add On item types
         getAddOnItemTypes();
         //
         
         //get package item type
         getPackageItemTypes();
         //
       return null;
    }
    
    
    
    public static set<String> itemids=new set<String>();

    
     @RemoteAction
    global static string getcurrdate( string hosttzone){
    system.debug('hosttzone'+hosttzone);

    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
    tz.tZone=hosttzone;
    tz.format='MM/dd/yyyy hh:mm a';
    tz.dateTimeValue=System.now();
    string hosttzonetime=tz.getTimeZoneValue();
    return hosttzonetime;
    }
    
     @RemoteAction
    global static string paymentsetornot(string eventid){
    List<Event_Pay_Gateway__c> epglist=[select id,name,Events__c from Event_Pay_Gateway__c where Events__c=:eventid limit 1];
    if(epglist.size()==0)
    return 'no';
    else
    return 'yes';
    }
    public List<BLN_Item__c> refreshitemlist{get;set;}
    public boolean batchticketprocess{get;set;}
   public PageReference refreshItem() {
      refreshitemlist=new List<BLN_Item__c>();
      try{
      refreshitemlist=[select id,item_name__c,Event__c,Available_Tickets__c,Ordering__c  from  BLN_Item__c where Event__c=:ApexPages.currentPage().getParaMeters().get('eventid') order by Ordering__c];
      }catch(Exception e){}
  
        return null;
   }
public class applicationException extends Exception {}

}