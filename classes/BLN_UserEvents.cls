public without sharing class BLN_UserEvents {
/******************************************************************************
Page:BLN_UserEvents
Purpos         : For showing all events.This is the first page to show the User as soon as he logs in
Developer Name : Mythily Nagandla
Email Id       : mythilyn@globalnest.com
Start Date     : July 3,2014
static values  : i) noevent(), systemadmin profile id
                 ii)UpdateEvent() ,Shared document folder id
********************************************************************************/

//------------------------VARIALBEL DECLARATION-----------------------
public string panelbool{get;set;}
public list<UC_Role__c> UCRoles {get ; set ;}
public User Userid {get ; set ;}
public list<BLN_Event__c> EventsList {get ; set ;}
public BLN_Event__c Eventedit {get ; set ;}
public list<Eventwrapper> wrapperEventList {get ; set ;}
public string SelectedEvent {get ; set ;}
public boolean editpopup {get ; set ;}
public string eventImageName {get ; set ;}
public blob eventImage {get ; set ;}
public document mydoc {get ; set ;}
public LIST<Country__c> country {get ; set ;}
public LIST<SelectOption> countryOptions {get ; set ;}
public LIST<SelectOption> stateOptions{get; set;}
public string selectedCountry {get ; set ;}
public string serchEvent{get;set;}
public string fullUrl{get;set;}
public GN_User__c gnuserinfo{get;set;}
public string LoginUserId{get;set;}
public boolean gridview{get;set;}
public boolean listview{get;set;}


    //CONSTRUCTOR
    public BLN_UserEvents(){
    try{
    notdeletestatus='';
    panelbool = 'false';
    gridview=true;
    listview=false;
      fullUrl =  Site.getBaseUrl();
        // Clear cookie on pageload
           Cookie counter = ApexPages.currentPage().getCookies().get('counter');
            if (counter == null) {
               counter = new Cookie('counter', '',null,-1,false);
             }
            else{
               counter = new Cookie('counter','',null,-1,false);
               system.debug('@@@@@@@@@@@@@@@@@@ ');
            }
         ApexPages.currentPage().setCookies(new Cookie[]{counter});    
        listOfEvents();
    }catch(Exception e){}
    
        try{
        LoginUserId = Userinfo.getUserId();
        system.debug('@@@LoginUserId'+[select First_Name__c, Last_Name__c from GN_User__c WHERE User__r.id=: LoginUserId]);
       gnuserinfo= [select First_Name__c, Last_Name__c from GN_User__c WHERE User__r.id=: LoginUserId];
       }catch(exception ex){}
       try{
        if(wrapperEventList.size() == 1 ){
        panelbool = 'true';
        }
        }catch(Exception e){}
    }
    
    public void listvw() {
        listview=true;
        gridview=false;
         system.debug('listview'+listview);   
    }


    public void gridvw() {
        listview=false;
        gridview=true;
    }
  public pagereference noevent(){
    
             Cookie counter = ApexPages.currentPage().getCookies().get('counter');
             //Cookie usercookie = ApexPages.currentPage().getCookies().get('userid');
          
            if (counter == null) {
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
               
            }
            else{
             system.debug('UUUUUUUUUUUU '+SelectedEvent );
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
            }
            //usercookie = new Cookie('userid', userInfo.getUserId(),null,-1,false); 
            
             //ApexPages.currentPage().setCookies(new Cookie[]{usercookie });
             ApexPages.currentPage().setCookies(new Cookie[]{counter});
    
       Profile pro = [select id from Profile Where profile.Name =: 'System Administrator'];
      if(EventsList.size() == 0 && Userinfo.getProfileId() != pro.id){
        
        pagereference pg = new pagereference('/apex/BL_Event');
        pg.setredirect(True);
        return pg;
      }else
            return null;
    
    }
    
    public id uid {get ; set ;}
    public string uemailid  {get ; set ;}
    
    
    
    public void listOfEvents(){
        UCRoles = new list<UC_Role__c> ();
        EventsList = new list<BLN_Event__c> ();
        wrapperEventList = new List<Eventwrapper>();
        uid = Userinfo.getUserid();
        uemailid = Userinfo.getUserEmail();
        BLN_Events_BAL eventsBAL = new BLN_Events_BAL();
        BLN_Events_DAO evntsda = new BLN_Events_DAO();
        EventsList = eventsBAL.listOfEvents(uid);
         /************************************** Search Functionality Start ************************ */
        string evntnme=''; 
        string locations='';
        string sdt='';
        string edt=''; 
        
        if(ApexPages.currentPage().getParameters().get('eName')!=null && ApexPages.currentPage().getParameters().get('eName')!='Event Name'){
        evntnme = ApexPages.currentPage().getParameters().get('eName');
        }
       if(ApexPages.currentPage().getParameters().get('varLocal')!=null && ApexPages.currentPage().getParameters().get('varLocal')!='Location'){
        locations = ApexPages.currentPage().getParameters().get('varLocal'); 
        }
        
         if(ApexPages.currentPage().getParameters().get('sDate')!=null){
        sdt= ApexPages.currentPage().getParameters().get('sDate');
        }
        if(ApexPages.currentPage().getParameters().get('eDate')!=null){
        edt= ApexPages.currentPage().getParameters().get('eDate');
        }
        
        
        system.debug('--Event name--in list of events---@nil ---'+evntnme);
        system.debug('--locations name--in list of events---@nil ---'+locations); 
        system.debug('--sdt-in list of events---@tp ---'+sdt);
        system.debug('--edt name--in list of events---@tp ---'+edt);
        /*********************************Search end ********************************************* */ 
        
        
        if((evntnme!=null && evntnme!='') || (locations!=null && locations!='') || (sdt!=null && sdt!='' && sdt != 'Start Date') || (edt!=null && edt!='' && edt!= 'End Date')){
        EventsList =evntsda.listofUserEvents(uid,evntnme,locations,sdt,edt);  
        }else{
            EventsList = eventsBAL.listOfEvents(uid);
        }  
        
        Map<string,BLN_Event__c> EventsMap = new Map<string,BLN_Event__c>();
        SET<BLN_Event__c> EventsSet = new SET<BLN_Event__c> ();
        BLN_Gnuser_DAO GNDAO = new BLN_Gnuser_DAO ();
        GN_User__c GNUSER = GNDAO.existingGnuser(uemailid);
        LIST<Ticket__c> tics = [SELECT id,Event__c FROM Ticket__c WHERE (TKT_Profile__r.BLN_GN_User__c =: GNUSER.id  OR Order__r.BLN_TKT_profile__r.BLN_GN_User__c =: GNUSER.id) AND Ticket_Status__c = 'Booked'];
       
        for(BLN_Event__c BLS : EventsList ){
              EventsSet.add(BLS);
         }
        
        LIST<id> ids = new LIST<id> ();
        SET<id> idset = new SET<id>();
       for(Ticket__c GNTICS : tics){
         if(idset.add(GNTICS.Event__c)){
              ids.add(GNTICS.Event__c);}
        }
        
        if((evntnme!=null && evntnme!='') || (locations!=null && locations!='') || (sdt!=null && sdt!='' && sdt != 'Start Date') || (edt!=null && edt!='' && edt!= 'End Date')){
            LIST<BLN_Event__c> ListofEvents = new LIST<BLN_Event__c>();
            evntnme = '%'+evntnme+'%';
            locations = '%'+locations+'%';
            if(sdt!=null && sdt!='' && sdt!='Start Date' && edt!=null && edt!='' && edt!='End Date'){
                ListofEvents=[SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                     Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                     Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                     PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                     Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                     Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                     BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                     Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                FROM BLN_Event__c WHERE id IN : ids And Event_Status__c != 'Deleted' 
                                 AND (name like: evntnme AND Venue_Name__c like: locations AND DAY_ONLY(start_date__c) >= : date.parse(sdt) AND DAY_ONLY(end_date__c) <= : date.parse(edt))];
                            system.debug('llllllllllllllllll'+ listOfEvents);       
             }else if(sdt!=null && sdt!='' && sdt!='Start Date' && (edt==null || edt=='' || edt=='End Date')){
                 ListofEvents=[SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                     Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                     Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                     PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                     Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                     Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                     BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                     Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                FROM BLN_Event__c WHERE id IN : ids And Event_Status__c != 'Deleted' 
                                 AND (name like: evntnme AND Venue_Name__c like: locations AND DAY_ONLY(start_date__c) >= : date.parse(sdt))];
             }else if((sdt==null || sdt=='' || sdt=='Start Date') && edt!=null && edt!='' && edt!='End Date'){
                 ListofEvents=[SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                     Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                     Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                     PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                     Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                     Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                     BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                     Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                FROM BLN_Event__c WHERE id IN : ids And Event_Status__c != 'Deleted' 
                                 AND  (name like: evntnme AND Venue_Name__c like: locations AND DAY_ONLY(end_date__c) <= : date.parse(edt)) ];
             }else{
                 ListofEvents=[SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                     Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                     Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                     PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                     Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                     Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                     BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                     Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                FROM BLN_Event__c WHERE id IN : ids And Event_Status__c != 'Deleted' 
                                 AND  (name like: evntnme AND Venue_Name__c like: locations) ];
             }
         for(BLN_Event__c event : ListofEvents ){
            EventsSet.add(event);
         
         }
        }else{
        LIST<BLN_Event__c> ListofEvents = [SELECT is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                         Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId,owner.email, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,  End_Date__c, 
                                         Description__c,BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,CreatedBy.Name ,
                                        BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                        Tax_Rate__c,Accept_Tax_Rate__c,organizer_id__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                   FROM BLN_Event__c WHERE id IN : ids And Event_Status__c != 'Deleted' ];
                            system.debug('llllllllllllllllll'+ listOfEvents);       
         for(BLN_Event__c event : ListofEvents ){
            EventsSet.add(event);
         
         }
         }
        UCRoles    = eventsBAL.roles(uid);
        system.debug('mmmmmmmmmmmmmmmmmmmmmmmm'+UCRoles.size());
        
        // By Phani
          SET<id> removeDupEve = new SET<id>();
          BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
            for(BLN_Event__c evs : EventsSet){
               for(UC_Role__c uu: UCRoles){
                 if( (evs.organizer_id__c == uu.Company__c && uu.RoleId__r.Name=='Company Admin') || (uu.RoleId__r.Name=='Event Admin' && uu.GN_User__r.Email__c==userInfo.getUsername() && evs.id==uu.Event__c ) ){ // For company admin 
                   if(!removeDupEve.contains(evs.id)){   
                      string sdate='';
                      string edate='';
                      
                         tz.tZone=evs.Time_Zone__c;
                         tz.format='MM/dd/yyyy hh:mm a';
                         tz.dateTimeValue=evs.start_date__c;
                         if(evs.start_date__c != null){
                         sdate=tz.getTimeZoneValue();
                         }else{
                         sdate=null;
                         }
                         
                     /*BLN_timeConToEvzoneCon tz1=new BLN_timeConToEvzoneCon();
                         tz1.tZone=evs.Time_Zone__c;
                         tz1.format='MM/dd/yyyy hh:mm a';*/
                         tz.dateTimeValue=evs.end_date__c;
                         if(evs.end_date__c != null){
                         edate=tz.getTimeZoneValue();
                         }else{
                         edate=null;
                         }
                     
                     wrapperEventList.add(new Eventwrapper(uu,evs,sdate,edate));
                   }
                    removeDupEve.add(evs.id); 
                 }               
               }  
            }
       // BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
        // Ticket events for display
       for(BLN_Event__c evs : EventsSet){
         if(!removeDupEve.contains(evs.id)){
             string sdate='';
                      string edate='';
                      
                         tz.tZone=evs.Time_Zone__c;
                         tz.format='MM/dd/yyyy hh:mm a';
                         tz.dateTimeValue=evs.start_date__c;
                         if(evs.start_date__c != null){
                         sdate=tz.getTimeZoneValue();
                         }else{
                         sdate=null;
                         }
                         
                    /* BLN_timeConToEvzoneCon tz1=new BLN_timeConToEvzoneCon();
                         tz1.tZone=evs.Time_Zone__c;
                         tz1.format='MM/dd/yyyy hh:mm a';*/
                         tz.dateTimeValue=evs.end_date__c;
                         if(evs.end_date__c != null){
                         edate=tz.getTimeZoneValue();
                         }else{
                         edate=null;
                         }
             
             wrapperEventList.add(new Eventwrapper(new UC_Role__c(),evs,sdate,edate));
          }
        }
          
         /*for(BLN_Event__c evs : EventsSet){
           SET<ID> UCREVID = new SET<ID>();
            for(UC_Role__c uu: UCRoles ){
              if(UCREVID.add(uu.Event__r.id)){ 
                if((uu.Event__r.id == evs.id && uu.RoleId__r.Name=='Event Admin') || (uu.RoleId__r.Name=='Company Admin') ){
                    //if(uu.Company__c == evs.organizer_id__c){
                    wrapperEventList.add(new Eventwrapper(uu,evs));
                 }
               }  
            }       
        }*/
      
    }
    
    public boolean IsLeadTabAvailable {get ; set ;}
    public BLN_Ticket_DAO ticDAO{get;set;}
    
    
    public pagereference manageEvent(){
        SelectedEvent = ApexPages.CurrentPage().getParameters().get('EventName');
            system.debug('  EVNT NAME  '+SelectedEvent );
            Cookie counter = ApexPages.currentPage().getCookies().get('counter');
            if (counter == null) {
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
            }
            else{
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
            }
    
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            Pagereference Pg;
            BLN_Event__c eve=[select id,name,Organizer_Email__c,owner.email from BLN_Event__c where id=:SelectedEvent];
            
            ticDAO= new BLN_Ticket_DAO();
                LIST<ticket__c> ticTemp=new list<ticket__c>(); 
                string s1='Lead Retrieval';
                string temp=' WHERE event__r.id = \''+SelectedEvent+'\''+' AND Item_Pool__r.Item_Type__r.Name ='+'\''+s1+'\''+'AND Ticket_Status__c!=\'Cancelled\' AND Ticket_Status__c = \'Booked\''+' AND tkt_profile__r.bln_gn_user__r.User__c = '+'\''+uid+'\'';
                ticTemp = ticDAO.userOrderAndTickets(temp);
                if(ticTemp.size()>0){
                    IsLeadTabAvailable = true;
                }
          
           //scan attendee app checking
                List<BLN_Scanusr_item__c> sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:eve.id and BLN_Item_Pool__c !=null limit 1];
              
            if(eve.Organizer_Email__c==UserInfo.getUserEmail()||eve.owner.email==UserInfo.getUserEmail()){
         Pg = new Pagereference('/apex/BLN_Dashboard'); 
         } else if(IsLeadTabAvailable == true){
         Pg = new Pagereference('/apex/BLN_BLDashboard'); 
         }
         else if(sc.size()>0){
         Pg = new Pagereference('/apex/BLN_SADashboard'); 
         } 
         else{
         Pg = new Pagereference('/apex/BLN_Mytickets');                
         }              
         return Pg ;
    
    }
    
    //Inner class for hiding the edit button of an Event based on Role
    public class Eventwrapper{
        public BLN_Event__c eventwrap {get ; set ;}
        public UC_Role__c UCRole {get ; set ;}
        public string sdate{get;set;}
        public string edate{get;set;}
        public Eventwrapper(UC_Role__c ss,BLN_Event__c ev,string sdate1,string edate1)
        {
            eventwrap = ev;
            UCRole = ss;
            sdate=sdate1;
            edate=edate1;
        }
    }
    //Edit EVENT
    public PageReference Editevent(){ 
    Eventedit  =new BLN_Event__c(); 
    SelectedEvent = ApexPages.CurrentPage().getParameters().get('EventName');
     for(BLN_Event__c evs : EventsList ){
                if(SelectedEvent == evs.id){
                Eventedit  = evs;
                }
    
    }
     //countryStates();
      countryOptions= new LIST<SelectOption>();
     BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
     countryOptions = bcd.countryStates(Eventedit.id);
     stateOptions= new LIST<SelectOption> ();  
     stateOptions = bcd.statesBasedOnCountry(countryOptions); 
     
    editpopup = TRUE;
    return new pagereference('/apex/BLN_EventNew?id='+Eventedit.id);
    }
    
    
    //Delete Event
     public PageReference deleteparamval(){
      notdeletestatus='';
     Eventedit  =new BLN_Event__c(); 
    SelectedEvent = ApexPages.CurrentPage().getParameters().get('EventName');
     
     system.debug(SelectedEvent+'  SELECTED EVENT '+EventsList);
     for(BLN_Event__c evs : EventsList ){
                if(SelectedEvent == evs.id){
                Eventedit  = evs;
                }
    
    }
      
      BLN_Event__c e=deleteEvent(Eventedit.id);
     
      if(e.Event_Status__c!='Deleted')
      notdeletestatus='true';
      else
      notdeletestatus='false';
      
         
    listOfEvents();
    
    
    //return new pagereference('/apex/BLN_UserEvents');
    return null;
     
     }
     
     public String notdeletestatus{get;set;}
    public BLN_Event__c deleteEvent(id evid){ 
    
    system.debug('  EDITED EVENT '+evid);
    BLN_Events_DAO edao=new BLN_Events_DAO ();
    BLN_Event__c ble=edao.getEventDetails(evid);
    //system.debug('ssssssss'+Eventedit.id);
    List<Ticket__c> bookticket=[select  id,name,Ticket_Status__c,Event__c from Ticket__c where Ticket_Status__c='Booked' and Event__c=:ble.id];
    //
    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
    tz.tZone=ble.time_zone__c;
    tz.format='MM/dd/yyyy hh:mm a';
    tz.dateTimeValue=ble.End_Date__c;
    DateTime enddate= tz.getDateBasedOnEventTimeZone(tz.getTimeZoneValue(),ble.id);
    //
    //
    String currDtTm = system.now().format('MM/dd/yyyy hh:mm a',ble.time_zone__c);             
        DateTime currentDateTime = tz.getDateBasedOnEventTimeZone(currDtTm,ble.id);
      System.debug('currentDateTime '+currentDateTime );
       System.debug('enddate '+enddate);
    //
      if(bookticket.size()!=0&&currentDateTime<=enddate){
   return ble;
    }
    else
    {
     ble.Event_Status__c='Deleted';
    update ble;
    }
    return ble;
     
    }
    
    //For closing popups
    public void cancel(){
    editpopup = FALSE;
    }
  
    //For Update the values of an event on Edit
    public void UpdateEvent(){
        List<folder> folderList =new List<folder>();
        folderList = [select id from folder where Name =: 'Shared Documents']; 
        system.debug('ffffffffffffffff'+folderList );
         if (eventImage != NULL && (eventImageName != '' || eventImageName != NULL)) {    
         system.debug('imagesize'+eventImage.size());
             if (eventImage.size() != null) {
                 if (eventImage.size() <= 1024000) {
                     mydoc = new document();
                     mydoc.body = eventImage;
                     //if(folderList.size()>0){
                       mydoc.folderid =userInfo.getUserId();
                       //}
                     mydoc.ispublic = true;
                     mydoc.Name = eventImageName;
                     insert mydoc;
                     Eventedit.Logo_URL__c = mydoc.id;
                 } else {
                     
                 }
             }
         }
    
        update Eventedit;
        editpopup = FALSE;
        listOfEvents( );
    }
    public pagereference myTickets(){
    SelectedEvent = ApexPages.CurrentPage().getParameters().get('EventName');
            system.debug('  EVNT NAME  '+SelectedEvent );
            Cookie counter = ApexPages.currentPage().getCookies().get('counter');
            if (counter == null) {
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
            }
            else{
                counter = new Cookie('counter', SelectedEvent ,null,-1,false);
            }
    
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            Pagereference Pg;
         Pg = new Pagereference('/apex/BLN_mytickets');                
         return Pg ;
    
    }
    

 }