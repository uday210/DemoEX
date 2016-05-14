@RestResource(urlMapping='/BLN_ASC_AddEvents/*')
global class BLN_ASC_AddEvents{

global static maincontainer MC  {get ; set ;}
global static List<BLN_Event__c> EventsList {get ; set ;}
global static  BLN_Events_BAL Eventclass {get ; set ;}
global static BLN_Event__c Event {get ; set ;}
global static BLN_Events_BAL Eventsbal {get ; set ;}
global static string companyName {get ; set ;}
@HttpPost  

    global static maincontainer  doPost(){ 
     
        String siteurl=Label.SiteURL;
        RestRequest req = RestContext.Request;
         //Blob jSONRequestBody=req.requestBody; 
         string eventjsonInput = req.requestBody.tostring();
          EventInfo eveinfo;
           JSONParser parser = JSON.createParser(eventjsonInput);
    system.debug('EVENT JSON PARSER VALUES222222222  '+parser );
    while (parser.nextToken() != null) {
        
                    eveinfo= (EventInfo)parser.readValueAs(EventInfo.class);
                       system.debug('EVENT JSON PARSER VALUES3333333333  '+eveinfo);

       } 
       
       
       Blob jSONRequestBody = EncodingUtil.base64Decode(eveinfo.Image);
       
         string uid = req.params.get('Userid');
          string companyid = req.params.get('CompanyId');
          //string fromcountries=req.params.get('ATCnty');
        EventsList = new  List<BLN_Event__c>();
        Eventclass =  new BLN_Events_BAL ();
        Eventsbal = new BLN_Events_BAL ();
        Event= new BLN_Event__c ();
        mc = new maincontainer ();
        Date EventStartDate,EventEndDate;
        BLN_Gnuser_DAO gndao = new BLN_Gnuser_DAO ();
        string Encodeval =  EncodingUtil.base64Encode(jSONRequestBody);
        BLN_ReUse_EventsEditCon mainclass = new BLN_ReUse_EventsEditCon ();
        mainclass.imageData = Encodeval ;
        if(Encodeval !=''){
        mainclass.IsUploadEventLogo = true;
        }
        mainclass.saveEventLogo();
        string EvUrl = mainclass.eventlogourl;
        system.debug('::::::::::::URL::::::::::::'+EvUrl );
        BLN_User_DAO Ude = new BLN_User_DAO();
        User US = Ude.getUser(uid);
        string GNID = BLN_ReUse_EventsEditCon.createupdateuser(US.FirstName,US.LastName,US.Email);
        //String jSONRequestBody1=req.requestBody.tostring();
        String evid ='';
        //system.runAs(US){
        
        evid = BLN_ReUse_EventsEditCon.savesEventInfo(JSON.serialize(eveinfo),EvUrl,companyName,companyid,US.FirstName,US.LastName,GNID,uid,eveinfo.EventCountry);
       // }
     
        GN_User__c  GNUID = gndao.gettinggnuser(uid);
        
        companyName='';
        //companyName = GNUID.Company_Name__c;
       
         
        BLN_Event__c Ev = new BLN_Event__c();
         Ev = [SELECT  AllowNoticketSessions__c,scan_attendee_limit__c,Name, Venue_Name__c,(Select id,Name,BL_Fee_Percentage__c,BL_Fee_Amount__c,Max_bl_fee__c,Eventdex_Product__c,Item_type__c from Event_Price__r),ZipCode__c, Website_Url__c,  User_Company__r.Company__r.Name,User_Company__r.RoleId__r.Name,organizer_id__r.Name,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, Street2__c, Street1__c,  
                                         Start_Date__c, Social_Hashtag__c,Phone_Number__c, Password__c, 
                                        PO_Box__c, Organizer_Email__c,Logo_URL__c, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, End_Date__c, 
                                         Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Name,BLN_Country__r.Long_Name__c,City__c ,
                                        BLN_State__c,BLN_State__r.Name,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c,Event_Blog_URL__c 
                                       FROM BLN_Event__c WHERE id =: evid];
                                       
                                       
         List<Country__c> coun = [SELECT id, Long_Name__c from Country__c where  Long_Name__c =: Ev.BLN_Country__r.Long_Name__c];
        List<State__c> st = [select id,Long_Name__c from State__c Where Long_Name__c =: Ev.BLN_State__r.Long_Name__c AND Country__r.id =: Ev.BLN_State__c];
        
          string orgid = UserInfo.getOrganizationId();       
         Mc.Events=Ev;
         Mc.company = Ev.User_Company__r.Company__r.Name;
         Mc.roles=Ev.User_Company__r.RoleId__r.Name;
         MC.image =  siteurl+'/servlet/servlet.ImageServer?id='+ev.Logo_URL__c+'&oid='+orgid;
         MC.RegistrationLink=Label.SiteURL+'/BLN_Registration_Eventdex?id='+ev.id;
          try{
     Pay_Gateway__c pg=[select id,name,PG_User_Key__c,PG_Pass_Secret__c,Company__c,PGateway_Type__c,Company__r.name,PGateway_Type__r.name,PGateway_Type__r.Adaptive_Type__c from Pay_Gateway__c where PGateway_Type__r.name='Stripe' and Company__r.name='EventdexLive' limit 1];
     mc.StripeEventdexClientID=pg.PG_User_Key__c;
     mc.StripeEventdexSecretKey=pg.PG_Pass_Secret__c;
     MAP<id,integer> mapEvIdWithSessionTime = new MAP<id,integer>();
     list<Reg_Setting__c> regseting_sestime =  [select id,Event__c,Order__c FROM Reg_Setting__c WHERE (Setting_Type__c =: 'Display' AND Column_Name__c =: 'Time Out' AND Included__c =: TRUE AND Order__c != NULL) AND  Event__r.ID =: Ev.id];
      for(Reg_Setting__c rge:regseting_sestime){
            mapEvIdWithSessionTime.put(rge.Event__c,integer.valueof(rge.Order__c));
      }
     
      if(null !=mapEvIdWithSessionTime.get(ev.id)){
        mc.sessiontime = mapEvIdWithSessionTime.get(ev.id);
      }
     }catch(Exception e){}
    return Mc;
    }
    
    global class maincontainer{
    
    //public string Success {get ; set ;}
    public BLN_Event__c Events{get ; set ;}
    public string roles {get ; set ;}
    public string company {get ; set ;}
    public string image {get ; set ;}
    public String RegistrationLink{get;set;}
    public String lastRefreshDate{get;set;}
     public String StripeEventdexClientID{get;set;}
     public String StripeEventdexSecretKey{get;set;}
      public integer sessiontime =30;
    public maincontainer(){ 
    lastRefreshDate = system.now().formatGMT('yyyy-MM-dd hh:mm:ss a');
    }
    }
    
     global class EventInfo {
    public string Image {get ; set ;}
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
    public String EventCountry{get;
    set
    {
    try{EventCountry=[select id,name from Country__c where name=:value].id;}catch(Exception e){EventCountry=value;}
    }}
    public String EventDesc{get;set;}
    public String EventHashTag{get;set;}
    public String EventState{get;
    set
    {
    try{EventState=[select id,name from State__c where name=:value].id;}catch(Exception e){EventState=value;}
    }}
    public String EventStatus{get;set;}
    public String FacebookUrl{get;set;}
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

    
    
    
    public EventInfo(String Image,String EventName,String EventSDate,String EventEDate,String EventLocation,String EventOrgEmail,String EventID,String AttendeeReg,String CurrencySetting,String EventCategory,String EventCity,String EventCountry,String EventDesc,String EventHashTag,
    String EventState,String EventStatus,String FacebookUrl,String HostingAddress1,String HostingAddress2,String HostingTimeZone,
    String LanguageSetting,String OrgName,String PhoneNo,String TwitterUrl,String WebUrl,String ZipCode) {
    this.Image = Image;
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
    
    }
    
    
                                  
                                       /*
            Document document = new document();
                String imageurl ='';
                document.Name=ev.id;
                document.isPublic=true;
                document.ContentType='image/png';
                document.type='png';
                document.IsInternalUseOnly =false;
                document.body=jSONRequestBody;
                document.folderId='00lF0000001VI7Y';
                DataBase.saveResult docSaveResult = DataBase.insert(document, false);
                if(docSaveResult.isSuccess()){
                    system.debug('#### '+docSaveResult.getId());
                    ev.Logo_URL__c= docSaveResult.getId();
                } 
                Database.update(ev);
                */
                
                
        
       /**
        Event.Name = Ename;
        system.debug('dddddddddddddddddddddddate'+EventEndDate );
        Event.End_Date__c = EventEndDate ;
        Event.Start_Date__c = EventStartDate ;
        Event.Venue_Name__c = Location;
        //Event.End_Time__c = Etime;
        //Event.Start_Time__c = Stime;
        Event.BLN_Country__c = coun[0].id;
        Event.BLN_State__c = st[0].id;
        Event.City__c = city;
        Event.Description__c = description;
        Event.Street1__c = Street1;
        Event.ZipCode__c = Zip;
        EventsList.add(Event);
        */
        //string evid = Eventsbal.createEventnew(EventsList,companyName,uid);
        
          /**         
        if(status == 'Edit'){
        string Evid = req.params.get('Event_id');
        Event.id = Evid;
        }
        */
        
        
        
        /** String Ename = req.params.get('EventName');
        EventStartDate = date.valueOf(req.params.get('Start_date'));
        EventEndDate = date.valueOf(req.params.get('End_date'));
        string Stime = req.params.get('Start_time');
        string Etime = req.params.get('End_time');
        string country = req.params.get('country');
        string State = req.params.get('State');
        string Location = req.params.get('Location');
        
        String city=req.params.get('City');
        string description = req.params.get('description');
        string Street1 = req.params.get('Address1');
        string zip = req.params.get('Zip'); 
        string status = req.params.get('Status');
        */