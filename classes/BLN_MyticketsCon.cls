/***********************************************************************************************
*   Controller Name : BLN_MyticketsCon
*   Date            : 05/19/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is for show and edit tickets
*   Change History  : 05/19/2014
*   Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  05/19/2014          Phani Kumar ch                   To Create Page
*   06/30/2014          Phani Kumar ch                  Allowing Duplicates in GN user Table
**************************************************************************************************/
//BLN_AttendeesController
global without sharing class BLN_MyticketsCon {

public String naicsCodesString{get; set;}
public String  diverCodesString {get; set;}
public String commditiesStr{get;set;}
public String orgId{get;set;}
public string uname{get;set;}
public string eventcurrency{get;set;}
public Boolean isMove {get;set;}
public List<Order__c> RecList{get;set;}
public List<Order__c> RecListorders{get;set;}
public List<BLN_Mytickets_BAL.inncls> exorder{get;set;}
public List<String> PayOrderids;
public list<String> PayOrderids1;
public  Boolean IsUploadProfilePic {get;set;}
public Boolean IsUploadComLogo {get;set;}
    public BLN_MyticketsCon(BLN_AttendeesController controller) {
    try{
    orgId = UserInfo.getOrganizationId();
     uname = UserInfo.getUserName();
     IsUploadProfilePic = false;
IsUploadComLogo = false;
    isBuyer=false;
    isMove =false;
isOrderEdit = false;
         displayandhideIdes = new SET<id>();
        ShowCurrentTickets = true;
        displayTicForCancel = false;
        blnMyticketsBal = new BLN_Mytickets_BAL();
        ticketLevelQuestions = new surveyCls();
   eventLevelQuestions = new  surveyCls();
    string pgname = getVFPageName();
        if(pgname  =='BLN_Mytickets'){
        mypagebool = true;
        }else{
        mypagebool = false;
        }
        system.debug('#####'+pgname );
        fullUrl =  Site.getBaseUrl(); 
        ticketLevelQuestions = new  surveyCls();
   eventLevelQuestions = new  surveyCls();
         selectedOrderType= 'All';
        isOrderEdit = false; displayandhideIdes = new SET<id>();
        ShowCurrentTickets = true;
        displayTicForCancel = false;
        blnMyticketsBal = new BLN_Mytickets_BAL();
         try{
        urlCheck =  ApexPages.currentPage().getUrl();
        }catch(exception f){
          urlCheck='BLN_Orders';
        }
        
        if(urlCheck !=''){  // checking url for knowing about currentpage
            if((urlCheck.toLowerCase()).contains('BLN_Mytickets'.toLowerCase())){
                urlCheck ='BLN_Mytickets';
            }
            else if((urlCheck.toLowerCase()).contains('BLN_Speakers'.toLowerCase())){
                urlCheck ='BLN_Speakers';
            }
             else if((urlCheck.toLowerCase()).contains('BLN_Attendees'.toLowerCase())){
                urlCheck ='BLN_Attendees';
            }
            else{
                urlCheck ='BLN_Orders';
            }
        }
        
            
        loginUserId = userInfo.getUserId();  // To know login user Id
        //loginUserId = '005c00000013uMx';
        
        
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
       
         if(k!=null){ 
            if(k.getValue()!=''){
               selectedEvent = k.getValue();
               
            }else{
            selectedEvent ='All';
            
            }
            
            
         }else{
            selectedEvent ='All';
            
         }
         
        
        
        try{
        
            if(selectedEvent ==null  ){
                selectedEvent ='All'; 
            }
        }catch(exception er){
            selectedEvent ='All'; // default selected event
        }
        
        // selectedEvent  = Apexpages.CurrentPage().GetParameters().get('id');
        se = new BLN_Event__c();
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        try{
           se = blneventdetailbal.eventdetails(selectedEvent );
           //executes when the eventownerid and organizerid is different
           if(userinfo.getuserid()!=se.ownerid)
            loginUserId=se.ownerid;
            }catch(Exception e){}
        
        system.debug('MMMMMMMMMMMMMMMM '+selectedEvent );
        
       // countryStates();
       // statesBasedOnCountry();
       countryOptions= new LIST<SelectOption>();
     BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
     countryOptions = bcd.countryStates(selectedEvent);
     stateOptions= new LIST<SelectOption> ();  
     stateOptions = bcd.statesBasedOnCountry(countryOptions); 
        pcompanies='';
        
       }catch(exception e){}
    }

   
    public BLN_UtillDisplayLinks  myticket { get; set; }
    public String datename {get; set;}
    public boolean displyAddGuest{get;set;}
    public Boolean ShowCurrentTickets{get; set;} 
    public boolean displayTicForCancel{get;set;}
    public boolean isOrderEdit{get;set;} 
    public boolean orddetailbool{get;set;}
    public string selectedEvent{get;set;}
    public string loginUserId{get;set;}
    public string companyName {get;set;}
    public integer rowNum{get;set;}
    public string selectedOrder {get;set;}
    public  string isAttendeesPAge{get;set;}
    public List<Ticket__c> currentEventTickets{get;set;}
    public List<BLN_Mytickets_BAL.inncls> inncurrentTickets {get;set;} 
    public List<BLN_Mytickets_BAL.Bondbetweenchkandobj> innLineItems {get;set;}
    public List<Order_Item__c> ordIt{get;set;}
    public set<Id> displayandhideIdes {get;set;} // to display orderdetails again
    public  SET<id>  orid{get;set;}
    public List<Order__C>  exportOrders1{get;set;}
    public List<Order__C>  printOrders1{get;set;}
    public List<BLN_Mytickets_BAL.inncls>  exportOrders{get;set;}
    public List<BLN_Mytickets_BAL.inncls>  printOrders{get;set;}
    public List<BLN_Mytickets_BAL.inncls>  ValuesOfseletedorder{get;set;}
    public BLN_RegDashBoardInfo allStaticstics ;
    public list<BLN_RegDashBoardInfo.InnForPgateways> paytype_allStaticstics{get;set;} 
    public string listfeildtoShow {get;set;}
    public boolean mypagebool{get;set;}
    
    public BLN_Debug blndebug {get;set;}
    public BLN_Mytickets_BAL blnMyticketsBal {get;set;}
    public BLN_Mytickets_BAL.inncls editOrdRec{get;set;}   
    public Ticket__c addGuest{get;set;}  
    public BLN_Event__c   se{get;set;}
    public MAP<id,ticket__c> mapticWithId {get;set;}
    public MAP<id,order_item__c> mapitemWithId {get;set;}
    public MAP<id,BLN_Mytickets_BAL.inncls> mapOrdIsWithInner{get;set;}
    public MAP<id,GN_User__c> mapguIdWithGNU {get;set;}
    public string urlCheck {get;set;}
    public string RecordsForExport;
    public LIST<BLN_Event_Countries_Include__c> country{get; set;}
   public LIST<State__c> states{get; set;}
   public LIST<SelectOption> countryOptions{get; set;}
   public LIST<SelectOption> stateOptions{get; set;}
   public string selectedCountry{get; set;}
   public String selectedState{get; set;}
   public LIST<LIST<NAICS_Code__c>> listOfnaicscodes{get; set;}
   public String checkNAICSforEdit{get; set;}
    public string selectedOrd{get;set;}
    public String fullUrl{get;set;}
    public boolean isPopUp{get;set;}
    public void displayPermissions(){
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        //system.debug('CCCCCCCCCCCCCCCCCC '+ k.getValue());
        if(k!=null){ 
            selectedEvent = k.getValue();
        }
        myticket = new BLN_UtillDisplayLinks();
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        se = new BLN_Event__c();
        try{
            se = blneventdetailbal.eventdetails(selectedEvent );
             myticket.EventName=se.Name;
             myticket.EventTimeZone=se.Time_Zone__c;
         }catch(exception e){}
         if(urlCheck =='BLN_Attendees')
         {
         myticket.isAttendeesPage='active';
         myticket.tablabel='Attendees';
         myticket.isEventAdmin =true;
         myticket.isAttendeesPageExpand ='expand';
         }
         else if(urlCheck =='BLN_Mytickets'){
         myticket.tablabel='My Tickets';
         }
         else
         {
        myticket.isTicketsPageExpand='expand';
        myticket.isOrdersPage='active';
       myticket.tablabel='Orders';
       //myticket.isregistrationpage ='active';
       }
        myticket.EventId = selectedEvent ;
        
       
         myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        system.debug('selectedEvent'+selectedEvent);
        
      if(selectedEvent!= 'ALL'){
        myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        
       }
       
    }
  
    public void displayPermissions1(){
    try{
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        //system.debug('CCCCCCCCCCCCCCCCCC '+ k.getValue());
        if(k!=null){ 
            selectedEvent = k.getValue();
        }
        myticket = new BLN_UtillDisplayLinks();
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        se = new BLN_Event__c();
        try{
            se = blneventdetailbal.eventdetails(selectedEvent );
             myticket.EventName=se.Name;
         }catch(exception e){}
        
        myticket.isSpeackersPage='active';
        myticket.isSeminorsPageExpand = 'expand';
         myticket.tablabel='Speakers';
         myticket.eventId = selectedEvent;
         myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        
        
      if(selectedEvent!= 'ALL'){
        myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        
       }
       speakerDataInfo();
       isPopUp=true;
       }catch(exception ex){}
    }
  
   public String getRecordsForExport() {
        return RecordsForExport;
    }
                        
    public void setRecordsForExport(String s) {
        this.RecordsForExport = s;
    }
    public List<selectOption> getVisibility() {
    BLN_ReUse_EventsEditCon bre = new BLN_ReUse_EventsEditCon();
    
       return bre.getPickValues(new Payment__c(), 'Registration_Type__c', null);
    }
    public List<selectOption> getVisibility1() {
    BLN_ReUse_EventsEditCon bre = new BLN_ReUse_EventsEditCon();
    
       return bre.getPickValues(new Payment__c(), 'Payment_Mode__c', null);
    }
     public List<selectOption> getVisibility2() {
    BLN_ReUse_EventsEditCon bre = new BLN_ReUse_EventsEditCon();
  
       return bre.getPickValues(new Order__c(), 'Order_Status__c', null);
    }
  
  
    public LIST<SelectOption> orderTypes{get; set;}
    public String selectedOrderType{get; set;}
    
    public BLN_MyticketsCon(string d){
    try{
    IsUploadProfilePic = false;
IsUploadComLogo = false;
     orgId = UserInfo.getOrganizationId();
     uname = UserInfo.getUserName();
    naicsCodesString='';
    diverCodesString ='';
    commditiesStr='';
    isBuyer=false;
    isOrderEdit = false;
         displayandhideIdes = new SET<id>();
        ShowCurrentTickets = true;
        displayTicForCancel = false;
        blnMyticketsBal = new BLN_Mytickets_BAL();
        ticketLevelQuestions = new  surveyCls();
   eventLevelQuestions = new  surveyCls();
     }    
   catch(exception ex){}
     }    

    // This is constructor for this class in this i am getting event
    public BLN_MyticketsCon(){
    try{
     orgId = UserInfo.getOrganizationId();
     uname = UserInfo.getUserName();
     IsUploadProfilePic = false;
IsUploadComLogo = false;
   isBuyer=false;
    naicsCodesString='';
    diverCodesString ='';
    commditiesStr='';
         string pgname = getVFPageName();
        if(pgname  =='BLN_Mytickets'){
        mypagebool = true;
        }else{
        mypagebool = false;
        }
        system.debug('#####'+pgname );
        fullUrl =  Site.getBaseUrl(); 
        ticketLevelQuestions = new  surveyCls();
   eventLevelQuestions = new  surveyCls();
        orderTypes= new LIST<SelectOption>();
        orderTypes.add(new SelectOption('All', 'All'));
        orderTypes.add(new SelectOption('Fully Paid', 'Fully Paid'));
        orderTypes.add(new SelectOption('Not Paid', 'Not Paid'));
        orderTypes.add(new SelectOption('Cancelled', 'Cancelled'));
        orderTypes.add(new SelectOption('Abandoned', 'Abandoned'));
        orderTypes.add(new SelectOption('Check Not Received', 'Check Not Received'));
        selectedOrderType= 'All';
        isOrderEdit = false; displayandhideIdes = new SET<id>();
        ShowCurrentTickets = true;
        displayTicForCancel = false;
        blnMyticketsBal = new BLN_Mytickets_BAL();
        
        
            
        loginUserId =userInfo.getUserId();  // To know login user Id
        //loginUserId = '005c00000013uMx';
        blndebug = new BLN_Debug();
        try{
        urlCheck =  ApexPages.currentPage().getUrl();
        }catch(exception f){
          urlCheck='BLN_Orders';
        }
        if(Test.IsRunningTest()){
         urlCheck='BLN_Orders';
        }
        if(urlCheck !=''){  // checking url for knowing about currentpage
            if((urlCheck.toLowerCase()).contains('BLN_Mytickets'.toLowerCase())){
                urlCheck ='BLN_Mytickets';
            }
            else if((urlCheck.toLowerCase()).contains('BLN_Speakers'.toLowerCase())){
                urlCheck ='BLN_Speakers';
            }
              else if((urlCheck.toLowerCase()).contains('BLN_Attendees'.toLowerCase())){
                urlCheck ='BLN_Attendees';
                 selectedOrderType= 'All';
            }
            
           else{
                urlCheck ='BLN_Orders';
            }
        }
        
        Cookie k = null;
        try{
         k = ApexPages.currentPage().getCookies().get('counter');
       }catch(exception e){}
         if(k!=null){ 
            if(k.getValue()!=''){
               selectedEvent = k.getValue();
               //if(urlCheck !='BLN_Attendees')
               //statistics();
            }else{
            selectedEvent ='All';
            
            }
            
            
         }else{
            selectedEvent ='All';
            
         }
        
        try{
        
            if(selectedEvent ==null  ){
                selectedEvent ='All'; 
            }
        }catch(exception er){
            selectedEvent ='All'; // default selected event
        }
        
        // selectedEvent  = Apexpages.CurrentPage().GetParameters().get('id');
        se = new BLN_Event__c();
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        try{
           se = blneventdetailbal.eventdetails(selectedEvent );
           //executes when the eventownerid and organizerid is different
            //dont execute if the page is mytickets
           if(urlCheck !='BLN_Mytickets')
           if(userinfo.getuserid()!=se.ownerid)
            loginUserId=se.ownerid;
            }catch(Exception e){}
        
        
        system.debug('MMMMMMMMMMMMMMMM '+selectedEvent );
        if(selectedEvent !=null && selectedEvent !='All')
        {
         BLN_Event_DAO blneventsdao= NEW BLN_Event_DAO();
         List<BLN_Event__c> eventslist = blneventsdao.getEventDetails(selectedEvent);
         eventcurrency = eventslist[0].BLN_Country__r.Currency__r.Currency_Symbol__c;
        }
        else
            eventcurrency ='';
         system.debug('@eventcurrency'+eventcurrency  ); 
     
        try{  
          
            onchangeEvent(); // Calling this method for getting all the order,tickets and orderitems of events
        }catch(exception es){}
       // countryStates();
       // statesBasedOnCountry();
       countryOptions= new LIST<SelectOption>();
     BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
     countryOptions = bcd.countryStates(selectedEvent);
     stateOptions= new LIST<SelectOption> ();  
     stateOptions = bcd.statesBasedOnCountry(countryOptions); 
     
     //when mytickets is opened irrespective of event
     if(selectedEvent=='All'||selectedEvent==''||selectedEvent==null)
     {
        if( urlCheck =='BLN_Mytickets'){
        try{       
     Cookie myticketseventid = ApexPages.currentPage().getCookies().get('myticketseventid');
     
      countryOptions = bcd.countryStates(myticketseventid.getValue().substring(0,myticketseventid.getValue().length()-3));
     stateOptions= new LIST<SelectOption> ();  
     stateOptions = bcd.statesBasedOnCountry(countryOptions);
     
      }catch(Exception e){}}
      }
      //when mytickets is opened irrespective of event  
        listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
        listOfnaicscodes = BLN_NaicsCodes_Dao.getNaicscodes(); 
        diversityList = new List<Diversity__c>();
        diversityList=BLN_Diversity_DAO.getDiversities();

        commoditiesList = new List<BLN_Commodities__c>();
        commoditiesList=BLN_CompCommodity_DAO.getCommodities();

        rset = new  Reg_Setting__c();        
       regesettings  = new LIST<Reg_Setting__c>();  
       regesettings  =[select Defaullt_Label__c,Column_Name__c,Event__c,Group_Name__c,Included__c,Item__c,Item_Pool__c,Order__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Group_Order__c,Sales_Message__c from Reg_Setting__c where  Event__r.id= :selectedEvent];
         if(regesettings.size()>0){
               rset = regesettings[0];
           }  
           }catch(exception ex){}
          
    }
 
 public string getVFPageName()  {
String pageName='BLN_Mytickets'; // Dafault for Test Excution
try{
if(!Test.IsRunningTest()){
pageName=null; // reset to null
pageName = ApexPages.CurrentPage().getUrl();    
pageName = pageName.replaceFirst('/apex/','');          
pageName = EncodingUtil.urlEncode(pageName, 'UTF-8');   
string[] pageNameExtra = pageName.split('%3F',0);  
pageName = pageNameExtra[0]; 
}                           
}catch(exception e ) {}                   
return pageName;                                      
}

 // this method is getting all the order,orderItem and tickets of user respect to event.
 // This controller is same for BLN_MyTickets and BLN_orders so i am checking the page in this method.
 // according to that page we will get order and all
 
 public List<List<BLN_Mytickets_BAL.inncls>> listOfListOrders{get;set;}
 

  public string pcompanies{get;set;}
 
       public void onchangeEvent(){
       
       try{
        //if(urlCheck !='BLN_Attendees')
        //statistics();
        }catch(Exception e){}
        mapticWithId  = new MAP<id,ticket__c>(); 
        mapitemWithId = new MAP<id,order_item__c>();
        mapguIdWithGNU = new MAP<id,GN_User__c>();
        inncurrentTickets= new List<BLN_Mytickets_BAL.inncls>();
        List<Ticket__c> ticketsList = new List<Ticket__c>();
        BLN_Gnuser_DAO guDAO = new BLN_Gnuser_DAO();
        listOfListOrders = new List<List<BLN_Mytickets_BAL.inncls>>();
         pcompanies ='';
        mapOrdIsWithInner = new MAP<id,BLN_Mytickets_BAL.inncls>();
     
          SET<id> GnuserList = new  SET<id>();
        //Getting all tickets and orders of perticular user
        
        system.debug('PPPPPPPPPPPPPPPPP '+selectedEvent+'WWWWWWWWWWWW '+urlCheck +' PPPP '+loginUserId);
        integer k =0;
           SET<Id> companyIds  = new SET<Id>();
           //this list we are not using from order and attendees,bcoz from now we are passing ids and getting the particular order in prepareorder() method
      if(urlCheck=='BLN_Mytickets' ){
      system.debug('test');
        for(BLN_Mytickets_BAL.inncls innTotal : blnMyticketsBal.userTickets(loginUserId,selectedEvent,urlCheck, selectedOrderType)){
            //Restricting abandoned orders
            system.debug('abceee2'+innTotal);
             companyIds.add(innTotal.orderInn.BLN_TKT_profile__r.BLN_Company__c);
             mapOrdIsWithInner.put(innTotal.orderInn.id,innTotal);
            GnuserList.add(innTotal.orderInn.BLN_TKT_profile__r.BLN_GN_User__c); 
              if(displayandhideIdes.size()>0){ 
               if(displayandhideIdes.contains(innTotal.orderInn.id)){
                   innTotal.displayOrderItems =true;
               }  
             }  
            
          k++;
          if(urlCheck !='BLN_Attendees'){
          System.debug('intotal===== '+innTotal);
            inncurrentTickets.add(innTotal);}
            
            if(k==1000){
            if(urlCheck !='BLN_Attendees')
              listOfListOrders.add(inncurrentTickets);
              inncurrentTickets= new List<BLN_Mytickets_BAL.inncls>();
              k=0;
            }
            ticketsList.addAll(innTotal.ticketsInn);
             for(order_item__c orditem : innTotal.orderItemInn){
                 mapitemWithId.put(orditem.id,orditem ); // map orderItem with its id
              }
        
        
        } 
        
        for(UC_Role__c ucr : [select id,User_Type__c,Company__c  from UC_Role__c where Company__c in :companyIds]){
          if(ucr.User_Type__c =='Personal'){
             pcompanies+= ucr.Company__c;  
          } 
       }   
        if(urlCheck !='BLN_Attendees') 
       listOfListOrders.add(inncurrentTickets);
       
         for(Ticket__c tc :ticketsList){
           mapticWithId.put(tc.id,tc); // Map tickets with its id  
           GnuserList.add(tc.TKT_profile__r.BLN_GN_User__c);
         } 
         
         for(GN_User__c gnu : guDAO.getGnuserList(GnuserList)){
            mapguIdWithGNU.put(gnu.id,gnu); 
         }
         }
         
     }
 
    //  This method is to diplay selected order details popup in Mytickets Page
    public PageReference renderDetails() {
        rowNum= Integer.valueOf(apexpages.currentpage().getparameters().get('guestindex'));
        if(inncurrentTickets[rowNum].displayOrderItems ==true){
            inncurrentTickets[rowNum].displayOrderItems =false;
            displayandhideIdes.remove(inncurrentTickets[rowNum].orderInn.id);
        }else{
            inncurrentTickets[rowNum].displayOrderItems=true;
            selectedOrder =inncurrentTickets[rowNum].orderInn.id;
            displayandhideIdes.add(inncurrentTickets[rowNum].orderInn.id);
        }
        try{
        
        } catch(exception re){}
        
        return null;
    }
 
 
   // -------------------------------------------  Actions on orders page  ----------------------------------- --> 
 
    // Open edit popup with selected record values
    /*public void displayorderEditform(){
        editOrdRec =new  BLN_Mytickets_BAL.inncls();
        gnUser  = new GN_User__c();
        ucrole = new UC_Role__c();
        string editableOrder = Apexpages.currentPage().getParameters().get('edform');
        prepareorder(editableOrder );
        try{
            editOrdRec = mapOrdIsWithInner.get(editableOrder);
            gnUser = mapguIdWithGNU.get(editOrdRec.orderInn.Client_GN_User__c);
              beforeEditEmail = gnUser.Email__c;
        }catch(exception ex){}
    try{ 
        ucrole  = [select id,Company__c,Event__c,Invited_by__c,Invited_date__c,RoleId__c,GN_User__c,User_Type__c from UC_Role__c where company__c =:editOrdRec.orderInn.Client_Company__c and GN_User__c=:editOrdRec.orderInn.Client_GN_User__c];
     }catch(exception rt){}
         if(ucrole!=null){
            if(ucrole.User_Type__c!='Personal'){
        companyName = editOrdRec.orderInn.Client_Company__r.Name;
        compidchanged = editOrdRec.orderInn.Client_Company__c;
            } 
         }
         beforecompany =editOrdRec.orderInn.Client_Company__r.Name;
        compext =new Company_ext__c();
        comp =new Company__c ();
        isOrderEdit = true;
        isPopUp=true;
    }*/
    public void displayorderEditform(){
       System.debug('Edit orderrrrrrrrrrrrrrrr ');
       BLN_TKTProfile_DAO tktProfileDao = new BLN_TKTProfile_DAO();
       BLN_Address_DAO addressDao = new BLN_Address_DAO();
        isOrderEdit = true;
         orddetailbool = false; 
        tktProfile = new TKT_profile__c();
         hAddress = new BLN_Address__c();
         wAddress = new BLN_Address__c();
         bAddress = new BLN_Address__c();
         sAddress = new BLN_Address__c();
          settingsForbuyer=new List<Reg_Setting__c>();
         string editableOrder = Apexpages.currentPage().getParameters().get('edform');
           BLN_Order_DAO ordDaoTemp = new BLN_Order_DAO();
           Order__c ordEditTemp =new  Order__c();
           prepareorder(editableOrder );
             ordEditTemp = ordDaoTemp.getTktProfile(editableOrder);
             if(ordEditTemp.BLN_Tkt_profile__c!=null){
                tktProfile= tktProfileDao.getTktpFormTkt(ordEditTemp.BLN_Tkt_profile__c);
               if(tktProfile.Home_Address__c!=null)
                  hAddress = addressDao.getAddress(tktProfile.Home_Address__c); 
               if(tktProfile.Work_Address__c!=null)
                  wAddress = addressDao.getAddress(tktProfile.Work_Address__c);        
               if(tktProfile.Billing_Address__c!=null)
                  bAddress = addressDao.getAddress(tktProfile.Billing_Address__c);
               if(tktProfile.Shipping_Address__c!=null)
                  sAddress = addressDao.getAddress(tktProfile.Shipping_Address__c);   
           } 
          isOrderEdit = true;
        isPopUp=true;
     }

     
    // saving user info after editing record
    public PageReference Saveord() {
       /* user newu = new user();
        newu.firstName = gnUser.First_Name__c;
        newu.lastName = gnUser.Last_Name__c ;
        newu.Email = gnUser.Email__c;
        newu.userName = gnUser.Email__c;
        
        saveLogic(newu,new Ticket__c(),editOrdRec.orderInn,gnUser);// In this method user Insertion,company insertion and user role will be done
        isOrderEdit = false; // close order edit popup
        onchangeEvent();
        PageReference  pg = new PageReference ('/apex/BLN_Orders');
        pg.setredirect(true);
        return pg;*/
        SaveGuests();
        return null;
    }
 
    // This is method is for closing edit popup of both tickets and orders
    public PageReference CloseGuests() {
        displyAddGuest = false; //close add guest popup
        if(isOrderEdit){
            isOrderEdit =false; // close order edit popup
        }
        return null;
    } 
    
    
    // cancel total order 
    public PageReference cancelTotalorder() {
        
        orid = new SET<id>();
        System.debug(' Selected Order Id '+Apexpages.currentPage().getPArameters().get('guestindex12'));
        
          orid.add(Apexpages.currentPage().getPArameters().get('guestindex12'));
    
           splitcaceltotalorder(orid);
              //Refreshing page after cancel
              PageReference pageTemp = new Pagereference('/apex/BLN_orders');
              pageTemp.setRedirect(true);
        return pageTemp ;
          }
          
  public void splitcaceltotalorder(set<id> orsetid){
         BLN_Mytickets_BAL bal = new BLN_Mytickets_BAL();
         String orderstatus;
        
        for(order__c od : bal.getOrdersOrdItems(orsetid)){
         orderstatus = od.Order_Status__c;
        if(od.Order_Status__c !='Cancelled'){
            SET<id>  oridItemsuniq = new SET<id>();
            for(Order_Item__c orditem: od.Order_Items__r){
                bal.cancelOrderItemValues(bal.orderItemWithlineItem(orditem.id));
            }
            } 
        }
          
      
       if(orderstatus != 'Cancelled' ){
        bal.uypdateOrderStatus(orsetid); // updating order Status
        onchangeEvent(); // To refresh the grid
        }
        
    }
    //Export Individual & More than 1000 Records  
 public  pagereference exorders(){
 BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
   String wherecondition='';
            wherecondition = ' where Events__c = \''+selectedEvent+'\' and order_type__c !=\'EVENT PRODUCER\' and Order_Status__c !=\'Abandoned\' ';  // 
            RecListorders = new LIST<Order__c>();
            RecListorders=blnOrderDao.orderQuery(wherecondition);
             BLN_Event__c eve =[select time_zone__c,BLN_Country__r.Currency__r.Currency_Symbol__c from BLN_Event__c where id =:selectedEvent];
            if(RecListorders.size()>1000){
   Id batchInstanceId = Database.executeBatch(new BLN_Exportordersbatch('Select (Select Item__r.Event__r.End_Date__c,Each_Ticket_Price__c,item__r.event__r.Name ,Promotion__c,Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c,order__r.BLN_TKT_profile__r.BLN_GN_User__c, order__r.BLN_TKT_profile__r.Email__c,Item_Quantity__c, Item_Price__c, Item_Discount__c, Id,item__r.item_name__c,Status__c,Promotion__r.Promo_Code__c,Currency__c,Item_Fee__c,Tax__c,item__r.item_type__r.Name,lastmodifieddate,Order__r.Events__r.BLN_Country__r.Currency__r.Currency_Symbol__c  From Order_Items__r ), (select id,name,Payment_Mode__c from Payments__r),EVent_Admin_Comments__c,createdDate,Events__r.Time_Zone__c,Events__r.Name,Events__r.Start_Date__c,Events__r.Venue_Name__c,Events__r.End_Date__c,Events__c, o.Fee_Amount__c, o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__r.BLN_Company__c, BLN_TKT_profile__r.Mobile__c,o.Amount_Paid__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.BLN_GN_User__r.User__r.id,BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName, BLN_TKT_profile__r.TKT_Company__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Last_Name__c From Order__c o ' + wherecondition,eve.time_zone__c,eve.BLN_Country__r.Currency__r.Currency_Symbol__c), 1000);
            return new Pagereference('/BLN_OrdersCheckEmail');
   }else
        {
        return null;
  }
 }
   
     //Print Individual & More than 1000 Records  
 public  pagereference prinorders(){
 BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
   String wherecondition='';
            wherecondition = ' where Events__c = \''+selectedEvent+'\' and order_type__c !=\'EVENT PRODUCER\' and Order_Status__c !=\'Abandoned\' ';  //
            RecListorders = new LIST<Order__c>();
            RecListorders=blnOrderDao.orderQuery(wherecondition);
             BLN_Event__c eve =[select time_zone__c,BLN_Country__r.Currency__r.Currency_Symbol__c from BLN_Event__c where id =:selectedEvent];
            if(RecListorders.size()>1000){
 //  Id batchInstanceId = Database.executeBatch(new BLN_Exportordersbatch('Select (Select Item__r.Event__r.End_Date__c,Each_Ticket_Price__c,item__r.event__r.Name ,Promotion__c,Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c,order__r.BLN_TKT_profile__r.BLN_GN_User__c, order__r.BLN_TKT_profile__r.Email__c,Item_Quantity__c, Item_Price__c, Item_Discount__c, Id,item__r.item_name__c,Status__c,Promotion__r.Promo_Code__c,Currency__c,Item_Fee__c,Tax__c,item__r.item_type__r.Name,lastmodifieddate,Order__r.Events__r.BLN_Country__r.Currency__r.Currency_Symbol__c  From Order_Items__r ), (select id,name,Payment_Mode__c from Payments__r),EVent_Admin_Comments__c,createdDate,Events__r.Time_Zone__c,Events__r.Name,Events__r.Start_Date__c,Events__r.Venue_Name__c,Events__r.End_Date__c,Events__c, o.Fee_Amount__c, o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__r.BLN_Company__c, BLN_TKT_profile__r.Mobile__c,o.Amount_Paid__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.BLN_GN_User__r.User__r.id,BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName, BLN_TKT_profile__r.TKT_Company__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Last_Name__c From Order__c o ' + wherecondition,eve.time_zone__c,eve.BLN_Country__r.Currency__r.Currency_Symbol__c), 1000);
            return new Pagereference('/apex/BLN_PrintOrderBulk');
   }else
        {
        return null;
  }    
 }
   
    // Exporting All pages orders
    public pageReference exportOrders(){
       //exorders();
    
        pageReference pg = page.BLN_ExportordersAll;
        return pg;
    }
    
    // Print All pages orders 
        public pageReference printOrders(){
       
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
           eventInfo1= new BLN_EventDetails();
           eventInfo1.eventDetailsToDisplay(selectedEvent);
        pageReference pg = new PageReference ('/apex/BLN_PrintordersAll'); 
        return pg;
    }
    
   public string selectedck{get;set;}
    // export only Selected orders
    public pageReference  userSelectPerticularToExport(){
     system.debug('kkkkkkkkkkkkkkkkkkkkkkkkkkk'+apexpages.currentpage().getparameters().get('arr'));
     selectedck=apexpages.currentpage().getparameters().get('arr');
        pageReference pg = new PageReference ('/apex/bln_exportorders');
        
        pg.setRedirect(true);
       
        pg.getParameters().put('MyName',selectedck);
        return pg; 
    } 
    
      // print only Selected orders
    public pageReference  userSelectParticularToprint(){
     system.debug('kkkkkkkkkkkkkkkkkkkkkkkkkkk'+apexpages.currentpage().getparameters().get('arr'));
     selectedck=apexpages.currentpage().getparameters().get('arr');
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
           eventInfo1= new BLN_EventDetails();
           eventInfo1.eventDetailsToDisplay(selectedEvent);
        pageReference pg = new PageReference ('/apex/BLN_Printorders');
  
        pg.setRedirect(true);
       
        pg.getParameters().put('MyName',selectedck);
        return pg; 
    } 
   
   
    
    // Display order details pop up in orders page
    // This will fire when we click on order name
     public boolean isBuyer{get;set;}
    public String orderItemIdsCan{get;set;}
    public void renderDetailsfororder() {
        
        ValuesOfseletedorder = new List<BLN_Mytickets_BAL.inncls>();
        selectedOrd = apexpages.currentpage().getparameters().get('selectedordId');
        System.debug('selectedOrd '+selectedOrd);
        prepareorder(selectedOrd);
        isBuyer=false;
        
        if(mapOrdIsWithInner.get(selectedOrd).orderInn.BLN_TKT_profile__r.Email__c == userinfo.getusername())
        isBuyer=true;
        
        try{
          ValuesOfseletedorder.add(mapOrdIsWithInner.get(selectedOrd));
         cancelledStr(ValuesOfseletedorder);
        }catch(exception e){}
       
        
         System.debug('Orderrrrrrrrrrrrrrrr '+selectedOrd);
        orddetailbool = true;
        
    }
    
   public void cancelledStr(List<BLN_Mytickets_BAL.inncls> inc){
    orderItemIdsCan ='';
     for(BLN_Mytickets_BAL.inncls inind :inc){ 
        for(order_Item__c itq: inind.orderItemInn){
            if(itq.Status__c =='Cancelled'){
              orderItemIdsCan+=','+itq.Item__c; 
         }
      }
    }
  }     
    
    // Closing order detail popup
    public PageReference cancelOrdDetail(){
        orddetailbool = false;
         PageReference pageTemp2 ;
        if( urlCheck =='BLN_Mytickets'){
           pageTemp2 = new Pagereference('/apex/BLN_Mytickets');
        }else{
          pageTemp2 = new Pagereference('/apex/BLN_orders');
        }
        pageTemp2.setRedirect(true);
        return pageTemp2 ;
    }
 
  // -------------------------------------------  Actions on orders page  End -----------------------------------  
 
  
  
 // ----------------------------------------- Actions on order details popup --------------------------------------   
 Public GN_User__c gnUser{get;set;}
  //public TKT_profile__c gnUser{get;set;}
  Public Company__c comp {get;set;}
  Public Company_Ext__c compext {get;set;}
  Public MAP<id,List<Reg_Setting__c>> settingsForbuyerMAp{get;set;}
  Public  List<Reg_Setting__c> settingsForbuyer{get;set;} //To display buyer settings
  public transient Reg_Setting__c rset{get;set;}
   public transient List<Reg_Setting__c> regesettings {get ; set ;}
  Public UC_Role__c ucrole{get;set;}
  Public surveyCls ticketLevelQuestions {get;set;}
  Public  surveyCls eventLevelQuestions {get;set;}
  Public String groupnamesForUi{get;set;}
  Public String compid {get;set;}
  Public String beforeEditEmail {get;set;}
  Public String beforecompany{get;set;}
  Public String ticketId {get;set;}
  Public String tagsStr{get;set;}
  public List<Hash_Tag__c> tagsList{get;set;}
  public transient Attachment att{get;set;}
  public transient List<Attachment> attlist{get;set;}
  public transient List<String> videoyoutube{get;set;}
  public String diversities{get;set;}
  public List<Diversity__c> diversityList{get;set;}
  public List<BLN_Commodities__c> commoditiesList{get;set;}
  public String checkDiversforEdit{get;set;}
  public boolean orderticket{get;set;}
    // disply edit guest  pop up
    Public PageReference editTicket(){
    naicsCodesString ='';
   diverCodesString ='';
   commditiesStr='';
   orddetailbool = false;
   /* diversityList = new List<Diversity__c>();
    
    listOfnaicscodes= new LIST<LIST<NAICS_Code__c>>();
        List<NAICS_Code__c> naicscodeslist = new List<NAICS_Code__c>();
        for(NAICS_Code__c naics : [SELECT id,Name,Description__c FROM NAICS_Code__c]){
            naicscodeslist.add(naics); 
            if(naicscodeslist.size() == 999){
                listOfnaicscodes.add(naicscodeslist);                
                naicscodeslist= new LIST<NAICS_Code__c>();
            }
        }
       
       if(naicscodeslist.size() != 0){
            listOfnaicscodes.add(naicscodeslist);
        }
        
      diversityList =[SELECT id,Name,Order__c from Diversity__c order by order__c ];  
     */ 
       orderticket=false; 
       if(urlcheck!='BLN_Attendees'||Apexpages.currentPage().getParameters().get('TicketIdparam')!=null) 
       {
           ticketId = Apexpages.currentPage().getParameters().get('TicketIdparam');
            orddetailbool = true;
            orderticket=true;
       }
      
      try{
         Ticket__c tc=[select id,name,Order__c from Ticket__c where id=:ticketId limit 1];
         prepareorder(tc.Order__c );
       }catch(Exception e){}
       
      EdTicket();
      viewticket=false;
      displyAddGuest=true;
      return null;
    }
    
    
    
    public boolean viewticket{get;set;}
    public ticket__c Tictktprof{get;set;}
    Public PageReference viewTicket(){
     ticketId = Apexpages.currentPage().getParameters().get('TicketIdparam');
     
     Tictktprof= [SELECT Tkt_profile__r.User_Pic__c,Tkt_profile__r.First_Name__c,Tkt_profile__r.Last_Name__c,Tkt_profile__r.TKT_Job_Title__c,Tkt_profile__r.FaceBookId__c,Tkt_profile__r.TwitterId__c,Tkt_profile__r.LinkedInId__c,Tkt_profile__r.Blogger__c,Tkt_profile__r.Biography__c,Tkt_profile__r.Video__c from ticket__c where id =:ticketId ];
     try{
     EdTicket();
     }catch(exception ee){}
     try{
     //attlist=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:gnuser.id];
     attlist=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:Tictktprof.Tkt_profile__r.id];
     }catch(Exception e){}
     try{
     //videoyoutube=gnuser.video__c.split(',');}catch(Exception e){}
     videoyoutube=Tictktprof.Tkt_profile__r.video__c.split(',');}catch(Exception e){}
     viewticket=true;
     displyAddGuest=false;
       return null;
    }
   public ticket__c tic{get;set;} 
   public Pay_Address__c billingaddr{get;set;}
   public String chkCCmforEdit{get;set;}
//~~~~~~~~~~~~~~~~~~~~~~~~~~ Ticket Edit Start ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
        public TKT_profile__c tktProfile{get;set;}
        public BLN_Address__c hAddress {get;set;}
        public BLN_Address__c wAddress  {get;set;}
        public BLN_Address__c bAddress  {get;set;}
        public BLN_Address__c sAddress {get;set;}
    public void EdTicket(){
    system.debug('ticketId========'+ticketId);
        isPopUp=true;
        isOrderEdit =false;
         BLN_Hash_Tag_DAO hasTagDao = new BLN_Hash_Tag_DAO();
         BLN_TKTProfile_DAO tktProfileDao = new BLN_TKTProfile_DAO();
         BLN_Address_DAO addressDao = new BLN_Address_DAO();
         BLN_RegistrationSettings_BAL RegSettingsBAL = new BLN_RegistrationSettings_BAL();
         BLN_Company_Naicscodes_DAO compNaicDao = new BLN_Company_Naicscodes_DAO();
         BLN_CompDiversity_DAO compDivDao = new BLN_CompDiversity_DAO();
         BLN_CompCommodity_DAO compComDao = new BLN_CompCommodity_DAO();    


         tktProfile = new TKT_profile__c();
         hAddress = new BLN_Address__c();
         wAddress = new BLN_Address__c();
         bAddress = new BLN_Address__c();
         sAddress = new BLN_Address__c();
        addGuest = new Ticket__c (); 
        tagsList = new List<Hash_Tag__c>();
        addGuest=  mapticWithId.get(ticketId);
       system.debug('addGuest========'+addGuest);
        // Getting Existing Tags
        List<id> tcidsInn = new List<id>();
        tcidsInn.add(ticketId);
        Integer tagCount =0;
        tagsList = hasTagDao.getTags(tcidsInn);
         for(Hash_Tag__c ht :tagsList){ 
          tagsStr += (tagCount==0)?ht.Tag_Text__c:','+ht.Tag_Text__c;
         }
         //system.debug('addGuest.Tkt_profile__c======'+addGuest.Tkt_profile__c);
        //if(null != BLN_Ticket_DAO.tcWithTktPid(ticketId)){
           //slectedTicketObj =BLN_Ticket_DAO.tcWithTktPid(ticketId);
           if(addGuest.Tkt_profile__c!=null){
                tktProfile= tktProfileDao.getTktpFormTkt(addGuest.Tkt_profile__c);
               if(tktProfile.Home_Address__c!=null)
                  hAddress = addressDao.getAddress(tktProfile.Home_Address__c); 
               if(tktProfile.Work_Address__c!=null)
                  wAddress = addressDao.getAddress(tktProfile.Work_Address__c);        
               if(tktProfile.Billing_Address__c!=null)
                  bAddress = addressDao.getAddress(tktProfile.Billing_Address__c);
               if(tktProfile.Shipping_Address__c!=null)
                  sAddress = addressDao.getAddress(tktProfile.Shipping_Address__c);   
           }  
      // }
      
       
       try{
          tic= [select id,name,Tstatus_Id__c,(select tstatus_name__c,Owner.Name,Device_Name__c,LastModifiedDate from tstatus__r  order by LastModifiedDate DESC) from ticket__C where id = :addGuest.id];
       }catch(exception eee){}
        beforeEditEmail = tktProfile.Email__c; 
       if(selectedEvent == 'All' || urlCheck =='BLN_Mytickets'){
          selectedEvent = addGuest.Event__c;
       }
       //when mytickets is opened irrespective of event
        try{
               if( urlCheck =='BLN_Mytickets'){
       Cookie myticketseventid= ApexPages.currentPage().getCookies().get('myticketseventid');
    
        // If this is the first time the user is accessing the page, 
        // create a new cookie with name 'counter', an initial value of '1', 
        // path 'null', maxAge '-1', and isSecure 'false'. 
        if (myticketseventid== null) {
            myticketseventid= new Cookie('myticketseventid',addGuest.Event__c,null,-1,false);
        } else {
        // If this isn't the first time the user is accessing the page
        // create a new cookie, incrementing the value of the original count by 1
            myticketseventid= new Cookie('myticketseventid',addGuest.Event__c,null,-1,false);
        }
    
        // Set the new cookie for the page
        ApexPages.currentPage().setCookies(new Cookie[]{myticketseventid});
        BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
        countryOptions = bcd.countryStates(addGuest.Event__c);
        }}catch(Exception e){}
        //when mytickets is opened irrespective of event
       // ---------------------------------------- Buyer Settings -----------------------------
        settingsForbuyerMAp = new MAP<id,List<Reg_Setting__c>>();
        settingsForbuyer = new List<Reg_Setting__c>();
        SET<id> ticketIdsset = new SET<id>();
        ticketIdsset.add(addGuest.item__c);
        settingsForbuyerMAp= RegSettingsBAL.getTicketSettings(ticketIdsset,selectedEvent);
        system.debug('@@@@@@@#'+ticketIdsset);
          if(settingsForbuyerMap.size()>0){
              if(addGuest.Item_Type__r.Name=='Package' && addGuest.Item_Pool__r.Ticket_Settings__c=='Collect info from All Attendees')
               settingsForbuyer.addAll(settingsForbuyerMap.get(addGuest.Item_Pool__c));
              else
            settingsForbuyer.addAll(settingsForbuyerMap.get(addGuest.item__c));
           }
        //---------------- Adding all settings to string  -----------------\ listfeildtoShow =' ';
      checkDiversforEdit ='';groupnamesForUi='';
      for(Reg_Setting__c rs : settingsForbuyer){
        if(rs.Update_Access__c == true)
           listfeildtoShow += ','+rs.Column_Name__c;
        
        if(rs.Group_Name__c!='Billing Address'){
         if(rs.Included__c==true || rs.required__c==true)
            groupnamesForUi += ','+rs.Column_Name__c;
         }
       }
    //--------------------- Naics,Diversities and Commodities --------------------------------
    chkCCmforEdit ='';checkDiversforEdit='';checkNAICSforEdit='';
     checkNAICSforEdit= '$$$$';
       for(Company_Naicscodes__c cnu : compNaicDao.getCnsWithtktPid(tktProfile.id)){
          checkNAICSforEdit += cnu.BLN_NAICS_Code__c;
        }
       
        for(Company_Diversity__c cnu :compDivDao.getComDivs(tktProfile.id)){
         checkDiversforEdit += cnu.Diversity__c;
        }  
        
        for(BLN_Company_Commoditie__c cnu :compComDao.getComs(tktProfile.id)){
         chkCCmforEdit += cnu.BLN_Commodities__c;
        }  
      //------------------------- Assign roles -----------------------------
      try{
       roleselectid='';
       for(BLN_Participant_Role__c participantrole:[select id,name,Participant_Name__c,Participant_Name__r.BLN_TKT_profile__r.BLN_GN_User__c from BLN_Participant_Role__c where BLN_Events__c=:selectedEvent and Participant_Name__r.BLN_TKT_profile__c=:tktProfile.id]){
           roleselectid=roleselectid+participantrole.name+',';
         }
         if(roleselectid!='')
         roleselectid=roleselectid.substring(0,roleselectid.length()-1);
       }catch(Exception e){} 
     //------------------------------Survey Questions ---------------------------
     ticketLevelQuestions = new  surveyCls();
    eventLevelQuestions = new  surveyCls();
    SET<id> iteml  = new SET<Id>();
      iteml.add(addGuest.Item_pool__c);
      iteml.add(addGuest.Item__c);
   
   System.debug('BBBBBBBBBBB '+iteml);
   
   //Getting ticket level survey questions and answers
   
    Map<ID, Item_Question__c> itemQue = new Map<ID, Item_Question__c>([select isRequired__c,Question__r.Question_Text__c,id,name,Question_Level__c,Event__c,Question__c,Question__r.Question_Order__c,Question__r.BLN_Parent_Answer__c,Question__r.Name,question__r.answer_type__c,question__r.Max_Answer_count__c,question__r.id from Item_Question__c where ((Item__c In :iteml OR item_pool__c in :iteml) OR Event__c=:addGuest.Event__c) AND Question_Level__c='Ticket Level' order by Question__r.Question_Order__c asc]);
    Map<ID, User_Answer__c> itemans = new Map<ID, User_Answer__c>([select Name,item_question__r.question__r.BLN_Parent_Answer__c,ticket__r.id,BLN_Answer__r.id,BLN_Answer__r.Name,BLN_Answer__r.Answer_Text__c,BLN_Answer__c,Item_Question__c,Item_Question__r.Question__r.Name,Item_Question__r.Question__r.answer_type__c,Item_Question__r.Question__r.id,UAnswer_Text__c,Ticket__c from User_Answer__c where Item_Question__c IN :itemQue.keySET() and (Ticket__c=:ticketId) ]);
    
    System.debug('RRDD1:'+itemQue);
    
    //Getting answer optin for each question
    SET<ID> givenQId=new SET<ID>();
    for(Item_Question__c iq:itemQue.values()){
        givenQId.add(iq.question__c);    
    }
    Map<ID, List<BLN_Answer__c>> ansOptMap= new Map<ID, List<BLN_Answer__c>>();
    
    for(BLN_Answer__c a : [select id,bln_question__r.BLN_Parent_Answer__c,name,Answer_Text__c,BLN_Question__c,BLN_Question__r.id,BLN_Question__r.name,BLN_Question__r.answer_type__c from BLN_Answer__c Where BLN_Question__c in : givenQId ORDER BY Answer_Order__c]){//// in : givenQId ]
        List<BLN_Answer__c> ansOptList1=new List<BLN_Answer__c>();
        if(ansOptMap.containsKey(a.BLN_Question__c)){
            ansOptList1=ansOptMap.get(a.BLN_Question__c);
            ansOptList1.add(a);
            ansOptMap.put(a.BLN_Question__c,ansOptList1);
        }else{
            ansOptList1.add(a);
            ansOptMap.put(a.BLN_Question__c,ansOptList1);
        }
    }
    
    LIST<SelectOption> AnswersOpt;
    
    for(Item_Question__c iq:itemQue.values()){
      
      //list of answer options for each question
      User_Answer__c savedUAId=new User_Answer__c();
      List<BLN_Answer__c> ansOptList= new List<BLN_Answer__c>();
      if(iq.question__r.answer_type__c!='Text' || iq.question__r.answer_type__c!='Paragraph text'){
          ansOptList=ansOptMap.get(iq.question__c);       
      }
      String givenans='';
      String[] checkboxAns=new String[]{};
      AnswersOpt=new LIST<SelectOption>();
      
      String chooseAns='';
      String SSAns='';
      String scaleAns='';
      String ChAns='';
      
      if(iq.question__r.Answer_Type__c=='Choose from a list'){
        for(User_Answer__c uns:itemans.values()){
         if(iq.id == uns.Item_Question__c){
            chooseAns=chooseAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id; 
         }
        }
     }else if(iq.question__r.Answer_Type__c=='Single Selection'){
        for(User_Answer__c uns:itemans.values()){
         if(iq.id == uns.Item_Question__c){
            SSAns=SSAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id; 
         }
        }   
     }else if(iq.question__r.Answer_Type__c=='Scale'){
        for(User_Answer__c uns:itemans.values()){
         if(iq.id == uns.Item_Question__c){
            scaleAns=scaleAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id; 
         }
        }   
     }else if(iq.question__r.Answer_Type__c=='Checkboxes'){
        for(User_Answer__c uns:itemans.values()){
         //if(iq.id == uns.Item_Question__c){
         if(iq.question__c== uns.Item_Question__r.question__c && iq.question__r.BLN_Parent_Answer__c==uns.item_question__r.question__r.BLN_Parent_Answer__c){
            ChAns=ChAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id+uns.item_question__r.question__r.BLN_Parent_Answer__c; 
         }
        }   
     }
      
      if(iq.question__r.Answer_Type__c=='Choose from a list'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOpt.add(new SelectOption(a.id,a.Answer_Text__c));
            if(chooseAns.contains(a.name+a.BLN_Question__r.id))
            givenans=a.id;
        } 
     }else if(iq.question__r.Answer_Type__c=='Single Selection'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOpt.add(new SelectOption(a.id,a.Answer_Text__c));
            if(SSAns.contains(a.name+a.BLN_Question__r.id))
            givenans=a.id;
        }   
     }else if(iq.question__r.Answer_Type__c=='Scale'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOpt.add(new SelectOption(a.id,a.Answer_Text__c));
            if(scaleAns.contains(a.name+a.BLN_Question__r.id))
            givenans=a.id;
        }   
     }else if(iq.question__r.Answer_Type__c=='Checkboxes'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOpt.add(new SelectOption(a.id,a.Answer_Text__c));
            if(ChAns.contains(a.name+a.BLN_Question__r.id+a.BLN_Question__r.BLN_Parent_Answer__c)){
                if(a.BLN_question__r.BLN_Parent_Answer__c==iq.question__r.BLN_Parent_Answer__c)
            checkboxAns.add(a.id);
        }   
        }   
     }else{
        for(User_Answer__c uns:itemans.values()){
         if(iq.id == uns.Item_Question__c){
            if(uns.item_question__r.question__r.answer_type__c=='Text'){
                givenans=uns.uanswer_text__c;
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Paragraph text'){
                givenans=uns.uanswer_text__c;
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Single Selection'){//parent level answer
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Choose from a list'){
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Scale'){
                savedUAId.id=uns.id;
            }
         }
        }
     }
    Set<Id> setchbx=new set<Id>(); 
    for(User_Answer__c unsId :itemans.values()){
        if(iq.id == unsId.Item_Question__c){
            if(unsId.item_question__r.question__r.answer_type__c=='Checkboxes'){
                setchbx.add(unsId.id);
            }else{
                savedUAId.id=unsId.id;
            }           
        }
    }

           
       boolean isRequired=false;
       if(iq.isRequired__c==true){
        isRequired=true;
       }    
     ticketLevelQuestions.UserAnswer.add(new UserAnswerInnerClass(ansOptList,AnswersOpt,isRequired,iq,givenans,checkboxAns,savedUAId,setchbx));
         
    }
    
    //Getting Event level survey questions and answers
    Map<ID, Item_Question__c> itemQueEventLevel = new Map<ID, Item_Question__c>([select isRequired__c,Question__r.Question_Text__c,id,name,Question_Level__c,Event__c,Question__c,Question__r.Question_Order__c,Question__r.BLN_Parent_Answer__c,Question__r.Name,question__r.answer_type__c,question__r.Max_Answer_count__c,question__r.id from Item_Question__c where Event__c=:addGuest.Event__c AND Question_Level__c='Event Level' order by Question__r.Question_Order__c asc]);
    Map<ID, User_Answer__c> itemansEventLevel = new Map<ID, User_Answer__c>([select Name,ticket__r.id,BLN_Answer__r.id,BLN_Answer__r.Name,BLN_Answer__r.Answer_Text__c,BLN_Answer__c,Item_Question__c,Item_Question__r.Question__r.Name,Item_Question__r.Question__r.answer_type__c,Item_Question__r.Question__r.id,UAnswer_Text__c,Ticket__c from User_Answer__c where Item_Question__c IN :itemQueEventLevel.keySET() and (Ticket__c=:ticketId) ]);
    
    //Getting answer optin for each question
    SET<ID> givenQIdEventLevel=new SET<ID>();
    for(Item_Question__c iq:itemQueEventLevel.values()){
        givenQIdEventLevel.add(iq.question__c);    
    }
    Map<ID, List<BLN_Answer__c>> ansOptMapEventLevel= new Map<ID, List<BLN_Answer__c>>();
    
    for(BLN_Answer__c a : [select id,name,Answer_Text__c,BLN_Question__c,BLN_Question__r.id,BLN_Question__r.name,BLN_Question__r.answer_type__c from BLN_Answer__c Where BLN_Question__c in : givenQIdEventLevel]){//// in : givenQId ]
        List<BLN_Answer__c> ansOptList1=new List<BLN_Answer__c>();
        if(ansOptMapEventLevel.containsKey(a.BLN_Question__c)){
            ansOptList1=ansOptMapEventLevel.get(a.BLN_Question__c);
            ansOptList1.add(a);
            ansOptMapEventLevel.put(a.BLN_Question__c,ansOptList1);
        }else{
            ansOptList1.add(a);
            ansOptMapEventLevel.put(a.BLN_Question__c,ansOptList1);
        }
    }
    
    LIST<SelectOption> AnswersOptEventLevel;
    
    for(Item_Question__c iq:itemQueEventLevel.values()){
      
      //list of answer options for each question
      User_Answer__c savedUAId=new User_Answer__c();
      List<BLN_Answer__c> ansOptList= new List<BLN_Answer__c>();
      if(iq.question__r.answer_type__c!='Text' || iq.question__r.answer_type__c!='Paragraph text'){
          ansOptList=ansOptMapEventLevel.get(iq.question__c);       
      }
      String givenans='';
      String[] checkboxAns=new String[]{};
      AnswersOptEventLevel=new LIST<SelectOption>();
      
      String chooseAns='';
      String SSAns='';
      String scaleAns='';
      String ChAns='';
      
      if(iq.question__r.Answer_Type__c=='Choose from a list'){
        for(User_Answer__c uns:itemansEventLevel.values()){
         if(iq.id == uns.Item_Question__c){
            chooseAns=chooseAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id; 
         }
        }
     }else if(iq.question__r.Answer_Type__c=='Single Selection'){
        for(User_Answer__c uns:itemansEventLevel.values()){
         if(iq.id == uns.Item_Question__c){
            SSAns=SSAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id; 
         }
        }   
     }else if(iq.question__r.Answer_Type__c=='Scale'){
        for(User_Answer__c uns:itemansEventLevel.values()){
         if(iq.id == uns.Item_Question__c){
            scaleAns=scaleAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id; 
         }
        }   
     }else if(iq.question__r.Answer_Type__c=='Checkboxes'){
        for(User_Answer__c uns:itemansEventLevel.values()){
         if(iq.id == uns.Item_Question__c){
            ChAns=ChAns+uns.BLN_Answer__r.name+uns.item_question__r.question__r.id; 
         }
        }   
     }
      
      if(iq.question__r.Answer_Type__c=='Choose from a list'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOptEventLevel.add(new SelectOption(a.id,a.Answer_Text__c));
            if(chooseAns.contains(a.name+a.BLN_Question__r.id))
            givenans=a.id;
        } 
     }else if(iq.question__r.Answer_Type__c=='Single Selection'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOptEventLevel.add(new SelectOption(a.id,a.Answer_Text__c));
            if(SSAns.contains(a.name+a.BLN_Question__r.id))
            givenans=a.id;
        }   
     }else if(iq.question__r.Answer_Type__c=='Scale'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOptEventLevel.add(new SelectOption(a.id,a.Answer_Text__c));
            if(scaleAns.contains(a.name+a.BLN_Question__r.id))
            givenans=a.id;
        }   
     }else if(iq.question__r.Answer_Type__c=='Checkboxes'){
        for(BLN_Answer__c a: ansOptList){
            AnswersOptEventLevel.add(new SelectOption(a.id,a.Answer_Text__c));
            if(ChAns.contains(a.name+a.BLN_Question__r.id))
            checkboxAns.add(a.id);
        }   
     }else{
        /*for(User_Answer__c uns:itemansEventLevel.values()){
         if(iq.id == uns.Item_Question__c){
            givenans=uns.uanswer_text__c;
            savedUAId.Id=uns.id;
         }
        }*/
        for(User_Answer__c uns:itemansEventLevel.values()){
         if(iq.id == uns.Item_Question__c){
            if(uns.item_question__r.question__r.answer_type__c=='Text'){
                givenans=uns.uanswer_text__c;
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Paragraph text'){
                givenans=uns.uanswer_text__c;
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Single Selection'){//parent level answer
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Choose from a list'){//parent level answer
                savedUAId.id=uns.id;
            }else if(uns.item_question__r.question__r.answer_type__c=='Scale'){//parent level answer
                savedUAId.id=uns.id;
            }
         }
        }
     }
    Set<Id> setchbx=new set<Id>(); 
    for(User_Answer__c unsId :itemansEventLevel.values()){
        if(iq.id == unsId.Item_Question__c){
            if(unsId.item_question__r.question__r.answer_type__c=='Checkboxes'){
                setchbx.add(unsId.id);
            }else{
                savedUAId.id=unsId.id;
            }           
        }
    }
     
       boolean isRequired=false;
       if(iq.isRequired__c==true){
        isRequired=true;
       }
       List<Ticket__c> firstTicketList=new List<Ticket__c>();
       firstTicketList=[select id,name from ticket__c where order__r.id=: addGuest.Order__r.id and item_type__r.name!='Package']; 

       List<Ticket__c> firstTicketlineList=new List<Ticket__c>();
       firstTicketlineList=[select id,name from ticket__c where order__r.id=: addGuest.Order__r.id and item_type__r.name='Package' and parent_id__c!=Null];     
     
       if(firstTicketList.size()>0){
         if(firstTicketList[0].id==addGuest.id){
             eventLevelQuestions.UserAnswer.add(new UserAnswerInnerClass(ansOptList,AnswersOptEventLevel,isRequired,iq,givenans,checkboxAns,savedUAId,setchbx));
         }
       }
       
       if(firstTicketlineList.size()>0){
         if(firstTicketlineList[0].id==addGuest.id){
             eventLevelQuestions.UserAnswer.add(new UserAnswerInnerClass(ansOptList,AnswersOptEventLevel,isRequired,iq,givenans,checkboxAns,savedUAId,setchbx));
         }
       }
    }
    
   //get the attachements for clientgnuser
    attlist=new List<Attachment>();
    attlist=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:tktProfile.id];
     displyAddGuest= true;
    // statesBasedOnCountry1();
 }
  //~~~~~~~~~~~~~~~~~~~~~~~~~~ Ticket Edit Start ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   
   
   
   // survey Questions class      
  public class surveyCls{
    public LIST<UserAnswerInnerClass> UserAnswer{get;set;}  
    public surveyCls(){
        UserAnswer=new LIST<UserAnswerInnerClass>();
    }
    public surveyCls(LIST<UserAnswerInnerClass> UserAnswer1){
        this.UserAnswer=UserAnswer1;
    }
  }
 
  global  class UserAnswerInnerClass{
    public LIST<BLN_Answer__c> optionList{get;set;}
    public LIST<SelectOption> Answers{get;set;}
    public Boolean isRequired{get;set;}
    public String SelectedAnswer{get;set;}
    public Item_Question__c itq{get;set;}
    public String[] SelectedAnswerCheck = new String[]{};
    public String[] getSelectedAnswerCheck() {
        return SelectedAnswerCheck;
    }
    public void setSelectedAnswerCheck(String[] SelectedAnswerCheck) {
        this.SelectedAnswerCheck = SelectedAnswerCheck;
    }
    public user_answer__c uans {get;set;}
    public set<id> setchbxid{get;set;}
    
    public UserAnswerInnerClass(LIST<BLN_Answer__c> IAnswer,LIST<SelectOption> Ans,Boolean RequiredBool,Item_Question__c itemQues,String SelectedAnswer1,String[] SelectedAnswerCheck1,user_answer__c uans1,set<id> setchbxid1){       
        itq = itemQues;
        optionList = IAnswer; 
        Answers = Ans;  
        isRequired = RequiredBool;
        SelectedAnswer=SelectedAnswer1;
        SelectedAnswerCheck=SelectedAnswerCheck1;
        uans=uans1;
        setchbxid=setchbxid1;
    }
}
  
  //----------------Saving survey answers-------------------------------
  public string childansTemp{get;set;}   
  Public BLN_TrasactionStatus transactionStatus{get;set;}
  public pageReference upsertSurveyAnswers(){
    System.debug('TTTTTTTTRRRRRRRRUUUU:::'+childansTemp);
    transactionStatus = saveSurveyQuestionAnswers(childansTemp);  
    return null;
  }
  
  public BLN_Attendees_BAL attBal{get;set;}
  public BLN_TrasactionStatus saveSurveyQuestionAnswers(string oldvalref ){
        BLN_TrasactionStatus tStatus = new BLN_TrasactionStatus(); 
        attBal=new BLN_Attendees_BAL();
        System.debug('REFFFFFF:::'+oldvalref);  
        String ticketLevel =   attBal.modifySurveyAnswers(addGuest.Id,selectedEvent,ticketLevelQuestions,oldvalref);
        String eventLevel = attBal.modifySurveyAnswers(addGuest.Id,selectedEvent,eventLevelQuestions,oldvalref);
        if(ticketLevel=='Success'){
        //tStatus.orderId = Quickbal.orderId;
        }else{
        tStatus.errorMessage=ticketLevel;
        }
        return tStatus;
    }  

   
   
   
   public string compidchanged{get;set;}
   public transient String imageData {get;set;}
      public transient String comimageData {get;set;}
   public transient String AttData {get;set;}
   public transient String AttName {get;set;}
   public transient String iframelink{get;set;}
       // saving guest info after editing record
   /* public PageReference SaveGuests() {
   
    List<folder> folderList =new List<folder>();
        folderList = [select id from folder where Name =: 'Shared Documents'];
    try{ 
    if(imageData!=''){
    
                             document mydoc =new document();
                                 mydoc.body = EncodingUtil.base64Decode(imageData);
                                 //mydoc.folderid =  '00lF0000001VI7Y';
                                 mydoc.folderid =folderList[0].id;
                                 mydoc.IsPublic = True;
                                 mydoc.Name = 'attlogo.png';
                                 mydoc.contentType='image/png';
                                 DataBase.saveResult docSaveResult;
                                 docSaveResult = DataBase.insert(mydoc, false);
                                 
                                 if(docSaveResult.isSuccess()){
                                        gnUser.User_Pic__c=docSaveResult.getId();
                                 }
                         
                                }
         if(AttData!=''){                       
         Attachment a = new Attachment(parentId = gnUser.id, name=AttName , body =EncodingUtil.base64Decode(AttData));
         insert a;
       } 
       }catch(exception er){}                     
        gnUser.Video__c=iframelink;                    
        user newu = new user();
        newu.firstName = addGuest.First_Name__c;
        newu.lastName = addGuest.Last_Name__c ;
        newu.Email = gnUser.Email__c;
        newu.userName = gnUser.Email__c;
          System.debug('Orderrrrrrrrrrrrrrrr 22222222 '+addGuest.Client_company__c);
           System.debug('gnUser.Email__c '+gnUser.Email__c+newu.Email);
          selectedOrder = addGuest.order__c;
          // if(null==addGuest.Client_company__c){
             compidchanged =  addGuest.Client_company__c;
              System.debug('Orderrrrrrrrrrrrrrrr 3333333 '+compidchanged );
         //  }
          try{
          //when email changed and there is an existing gnuser with that email
          Gn_User__c gnu1 = [select first_Name__c,User__c,Last_Name__c,Email__c,id,User_Pic__c,Biography__c from Gn_User__c where Email__c=:newu.Email limit 1];
          gnUser.id= gnu1.id;
          gnUser.first_Name__c=addGuest.first_name__c;
          gnUser.last_Name__c=addGuest.last_name__c;
          gnUser.User__c = gnu1.User__c;
          update gnuser;
                }catch(Exception e){}
                
        
        saveLogic(newu,addGuest,new order__c(),gnUser); // In this method user Insertion,company insertion and user role will be done
        
           if(tagsStr !=null && tagsStr !=''){
                if(tagsList.size()>0){
                  DataBase.Delete(tagsList,false);
                }
                List<Hash_Tag__c> hashTagList = new List<Hash_Tag__c>();
                 for(string tagStr : tagsStr.split(',')){
                    Hash_Tag__c hstag = new Hash_Tag__c(); 
                    hstag.Event__c =selectedEvent; 
                    hstag.Table_Name__c ='Ticket__c';
                    hstag.RowId__c = ticketId;
                    hstag.Tag_Text__c = tagStr;
                    hashTagList.add(hstag);
                   }
                   Database.Insert(hashTagList,false);
           }
         if(isAttendeesPAge!='Attendee'&&urlCheck !='BLN_Attendees'){
           onchangeEvent();
           ValuesOfseletedorder= new List<BLN_Mytickets_BAL.inncls>();
           ValuesOfseletedorder.add(mapOrdIsWithInner.get(selectedOrder)); 
            cancelledStr(ValuesOfseletedorder);
           orddetailbool = true;
        } 
        
      //system.debug('JJJJJJJJJJ '+orddetailbool +'FFFFFFFFFFF ' +selectedOrder );
      //system.debug('EEEEEEEEEEE  '+ValuesOfseletedorder);   
       displyAddGuest= false; // closing pop up
       if(urlCheck =='BLN_Speakers')
       speakerDataInfo();
       return null;
    }
  */
  //------------------------------------------ Save logic ----------------------------
  public string childans{get;set;} 
  public string emptyans{get;set;} 
  public string errorTcUpdate{get;set;} 
 public PageReference SaveGuests() {
    BLN_Quick_Registration_BAL quickBal = new BLN_Quick_Registration_BAL(); 
    BLN_Role_DAO  roledao = new BLN_Role_DAO(); 
    errorTcUpdate ='Success';
   if(!isOrderEdit){ 
    System.debug('Add guest Values---------- '+addGuest);
    selectedOrder = addGuest.order__c;  
     DataBase.saveresult dSave = Database.update(addGuest,false);
    if(!dsave.Issuccess()){ 
     for (Database.Error err : dsave.getErrors()) { // Operation failed, so get all errors
                System.debug('The following error has occurred.');
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Account fields that affected this error: ' + err.getFields());
                errorTcUpdate = err.getMessage();
                return null;
            }
      }      
   }    
   //save image video attachment
     List<folder> folderList =new List<folder>();
        folderList = [select id from folder where Name =: 'Shared Documents'];
    try{ 
    
    if(IsUploadProfilePic){
    if(imageData!=''){
    
                             document mydoc =new document();
                                 mydoc.body = EncodingUtil.base64Decode(imageData);
                                 mydoc.folderid =folderList[0].id;
                                 mydoc.IsPublic = True;
                                 mydoc.Name = 'attlogo.png';
                                 mydoc.contentType='image/png';
                                 DataBase.saveResult docSaveResult;
                                 docSaveResult = DataBase.insert(mydoc, false);
                                 
                                 if(docSaveResult.isSuccess()){
                                        tktprofile.User_Pic__c=docSaveResult.getId();
                                 }
                         
                                }
                                 else{
                                tktprofile.User_Pic__c = null;
                                }
                                }
                                if(IsUploadComLogo){
                                if(comimageData !=''){
    
                             document mydoc =new document();
                                 mydoc.body = EncodingUtil.base64Decode(comimageData);
                                 mydoc.folderid =folderList[0].id;
                                 mydoc.IsPublic = True;
                                 mydoc.Name = 'attlogo.png';
                                 mydoc.contentType='image/png';
                                 DataBase.saveResult docSaveResult;
                                 docSaveResult = DataBase.insert(mydoc, false);
                                 
                                 if(docSaveResult.isSuccess()){
                                        tktprofile.Company_Logo__c=docSaveResult.getId();
                                 }
                         
                                }
                                else{
                                tktprofile.Company_Logo__c = null;
                                }
                                }
         if(AttData!=''){                       
         Attachment a = new Attachment(parentId = tktprofile.id, name=AttName , body =EncodingUtil.base64Decode(AttData));
         insert a;
       } 
       }catch(exception er){}                     
        tktprofile.Video__c=iframelink; 
   //
    if(beforeEditEmail==tktprofile.Email__c){
      
     }else{ // If we are inserting uer newly
         List<GN_User__c> listOfgnusers =  [select id from GN_User__c where Email__c=:tktprofile.Email__c];
        if(listOfgnusers.size()>0){
            tktprofile.BLN_GN_User__c = [select id from GN_User__c where Email__c=:tktprofile.Email__c].id;     
        }else{
         MAP<String,GN_User__c> mapEmWithUid = new MAP<String,GN_User__c>();
          List<GN_user__c> gnuserToinsert = new List<GN_user__c>(); 
         Gn_User__c gnubuyerInd = new Gn_User__c();
         gnubuyerInd =quickBal.AssignGnuserValues(gnubuyerInd,tktProfile);
         gnuserToinsert.add(gnubuyerInd);
         mapEmWithUid = quickBal.insertingusers(gnuserToinsert);// This will insert and return all user ids
        for(String GnuserIds : mapEmWithUid.keySet()){
          tktprofile.BLN_GN_User__c =mapEmWithUid.get(GnuserIds).id;
          try{
          if(AttData!=''){                       
         Attachment a = new Attachment(parentId = mapEmWithUid.get(GnuserIds).id, name=AttName , body =EncodingUtil.base64Decode(AttData));
         insert a;
           } 
          }catch(Exception e){}
        } 
        boolean isPersonalAtt=false;
         if(tktprofile.TKT_Company__c==null || tktprofile.TKT_Company__c==''){
            isPersonalAtt=true;
         }
        String companyIdAtt = quickBal.InsertCompanyNew(tktprofile);
        if(companyIdAtt!=null && companyIdAtt!=''){ // If company insert success fully
        try{
             String userIdTemp = mapEmWithUid.values()[0].id;
            //Adding naics values to list  
              if(naicsCodesString!=null && naicsCodesString!=''){
                 if(quickBal.compNaics(naicsCodesString,'',companyIdAtt,userIdTemp).size()>0){
                   Database.Insert(quickBal.compNaics(naicsCodesString,'',companyIdAtt,userIdTemp));
                 } 
               }  

             //Adding Divers values to list  
              if(diverCodesString !=null && diverCodesString!=''){
                 if(quickBal.compDivesity(diverCodesString,'',companyIdAtt,userIdTemp).size()>0){
                   Database.Insert(quickBal.compDivesity(diverCodesString,'',companyIdAtt,userIdTemp));
                 } 
               }

               //Adding naics values to list  
              if(commditiesStr!=null && commditiesStr!=''){
                 if(quickBal.compCommodity(commditiesStr,'',companyIdAtt,userIdTemp).size()>0){
                   Database.Insert(quickBal.compCommodity(commditiesStr,'',companyIdAtt,userIdTemp));
                 } 
               }


          GN_User__c gnUserup = new GN_User__c();
          SET<String> buyerSet = new SET<String>();        
            for(Reg_Setting__c bSet :settingsForbuyer){
                 if(bset.Group_Name__c=='Address Information'){
                  if(bSet.Included__c==true)   
                    buyerSet.add(bset.Column_Name__c);
                  }
               }
        if(buyerSet .contains('Home Address')){
          gnUserup.Home_Address__c =quickBal.InsertHomeAdd(hAddress);
        } 
        
          MAP<String,id> maproleWithId = new MAP<String,id>();
           // Getting available roles for UC role Obj
                for(Role__c r :roledao.userRole()){
                    maproleWithId.put(r.Name,r.id);
                }
          
          gnUserup.Default_Company_ID__c = companyIdAtt; //Assign default company
          tktprofile.BLN_Company__c =  companyIdAtt; // Assign compId
          Company_Ext__c compExt = new Company_Ext__c();
          compExt = quickBal.AssignWInfo(tktProfile,compExt);
          compExt = quickBal.AssignWadd(wAddress,compExt);
          DataBase.insert(compExt,false);
          UC_Role__c ucrole = new UC_Role__c();
          ucrole = quickBal.inserUcroleNew(companyIdAtt,mapEmWithUid.get(tktProfile.Email__c).id,isPersonalAtt,maproleWithId.get('Company Admin'));
          DataBase.insert(ucrole,false); 
          }catch(Exception e){}                  
         }
       } 
     }
     
     
    if(hAddress.Address1__c!=null){
       DataBase.upsertResult upSet =  DataBase.upsert(hAddress,false);
        if(upset.isCreated())
          tktprofile.Home_Address__c = upset.getId();
     }
    if(wAddress.Address1__c!=null){
      DataBase.upsertResult upSet =  DataBase.upsert(wAddress,false);
        if(upset.isCreated())
          tktprofile.Work_Address__c = upset.getId();
    }
    if(bAddress.Address1__c!=null){
       DataBase.upsertResult upSet =  DataBase.upsert(bAddress,false);
        if(upset.isCreated())
          tktprofile.Billing_Address__c = upset.getId(); 
    }
    if(sAddress.Address1__c!=null){
       DataBase.upsertResult upSet =  DataBase.upsert(sAddress,false);
        if(upset.isCreated())
          tktprofile.Shipping_Address__c = upset.getId(); 
    }
     DataBase.update(tktprofile); 

    //Handiling Naics divers and commodities   
     BLN_CompNaics_DAO compNaicsDao = new BLN_CompNaics_DAO();
     BLN_CompDiversity_DAO compDivsDao = new BLN_CompDiversity_DAO();
     BLN_CompCommodity_DAO compCommDao = new BLN_CompCommodity_DAO();
        if(naicsCodesString!=''){ 
          compNaicsDao.NaicsHandle(tktprofile.id,naicsCodesString);
        }
        if(diverCodesString!=''){
         compDivsDao.DiversityHandle(tktprofile.id,diverCodesString);
        }      
       if(commditiesStr!=''){
          compCommDao.CommoditiesHandle(tktprofile.id,commditiesStr);
       } 

        
     if(tagsStr !=null && tagsStr !=''){
                if(tagsList.size()>0){
                  DataBase.Delete(tagsList,false);
                }
                List<Hash_Tag__c> hashTagList = new List<Hash_Tag__c>();
                 for(string tagStr : tagsStr.split(',')){
                    Hash_Tag__c hstag = new Hash_Tag__c(); 
                    hstag.Event__c =selectedEvent; 
                    hstag.Table_Name__c ='Ticket__c';
                    hstag.RowId__c = ticketId;
                    hstag.Tag_Text__c = tagStr;
                    hashTagList.add(hstag);
                   }
                   Database.Insert(hashTagList,false);
           } 
           
           
          if(isAttendeesPAge!='Attendee'&&urlCheck !='BLN_Attendees'){
           //onchangeEvent();
          if(!isOrderEdit){
          ValuesOfseletedorder= new List<BLN_Mytickets_BAL.inncls>();
                if(selectedOrder!=null && selectedOrder!=''){
                try{
                    System.debug('mapOrdIsWithInner YYYYYYYYYY  '+mapOrdIsWithInner.keySet());
                   ValuesOfseletedorder.add(mapOrdIsWithInner.get(selectedOrder)); 
                   System.debug('ValuesOfseletedorder AAAAAAAAAa '+ValuesOfseletedorder);
                   cancelledStr(ValuesOfseletedorder); 
                   }catch(Exception e){}
                }
               orddetailbool = true;
          } 
        } 
     if(!isOrderEdit){
     if(selectedOrder!=null && selectedOrder!=''){
    try{
     apexpages.currentpage().getparameters().put('selectedordId',selectedOrder);
     
     renderDetailsfororder();
     if(urlcheck=='BLN_Attendees'&&orderticket==false) 
       {
           orddetailbool = false;
       }
    
     }catch(Exception e){}
     }
        displyAddGuest= false; // closing pop up
        if(urlCheck =='BLN_Speakers')
        speakerDataInfo();
    }else{
    
        onchangeEvent();
        
        PageReference  pg = new PageReference ('/apex/BLN_Orders');
        pg.setredirect(true);
        return pg;
    }
    system.debug('OLOLOLOLOLO:::'+childans);
    system.debug('ELELELELELELE:::'+emptyans);
    system.debug('TITITITITIT:::'+addGuest.id);
    
    //----------------------------Delete logic for old answers start-----------------------------------
    /*List<question__c> queObj=[select id,name from Question__c where BLN_Parent_Answer__c= : childans]; 
    Set<id> oldQuestionId=new Set<id>();
    for(question__c qq : [select id,name from Question__c where BLN_Parent_Answer__c= : childans]){
        oldQuestionId.add(qq.id);
    }
    
    Set<id> oldItemsQuestionId=new Set<id>();
    for(item_question__c iq : [select id,name from Item_question__c where question__c in :oldQuestionId]){
        oldItemsQuestionId.add(iq.id);
    }
    
    List<user_answer__c> oldUAnsList=new List<user_answer__c>();
    for(user_answer__c ua : [select id,name from user_answer__c where item_question__c in : oldItemsQuestionId and ticket__c = : addGuest.id]){
        oldUAnsList.add(ua);
    }
    
    if(oldUAnsList.size()>0)        
    database.delete(oldUAnsList,false); */   
    //----------------------------Delete logic for old answers End-----------------------------------
       
     return null; 
  } 
    

   // This function is for canceling tikcets in the order item level   
    public PageReference cancelDirectTicket() {
        BLN_Mytickets_BAL bal = new BLN_Mytickets_BAL();
        orid = new SET<id>();
        string orderIdTogetBack ='';
        List<Order_Item__c> ordIt = bal.orderItemWithlineItem(ApexPages.currentPage().getParameters().get('canordItemId'));
        system.debug('@@ordIt '+ordIt );
        bal.cancelOrderItemValues(ordIt);
         id orderIdforRefreshpop=ordIt[0].order__c;
        if(ordIt.size()>0 ){
        orderIdTogetBack =ordIt[0].order__r.id;
        orid.add(ordIt[0].order__c);
          
           bal.uypdateOrderStatus(orid);
        }
        //onchangeEvent();
          prepareorder(ordIt[0].order__c);
         ValuesOfseletedorder= new List<BLN_Mytickets_BAL.inncls>();
         System.debug('Order Values after Cancelled '+orderIdforRefreshpop);
         System.debug('Order mapOrdIsWithInner '+mapOrdIsWithInner);
         
         ValuesOfseletedorder.add(mapOrdIsWithInner.get(orderIdforRefreshpop));
          cancelledStr(ValuesOfseletedorder);
        return null;
    } 
 
     
      public void splitcancelDirectTicket(string orderitemid) {
        BLN_Mytickets_BAL bal = new BLN_Mytickets_BAL();
        orid = new SET<id>();
        string orderIdTogetBack ='';
        List<Order_Item__c> ordIt = bal.orderItemWithlineItem(orderitemid);
        system.debug('@@ordIt '+ordIt );
        bal.cancelOrderItemValues(ordIt);
         id orderIdforRefreshpop=ordIt[0].order__c;
        if(ordIt.size()>0 ){
        orderIdTogetBack =ordIt[0].order__r.id;
        orid.add(ordIt[0].order__c);
          
           bal.uypdateOrderStatus(orid);
        }
       
        
    } 
 
    
    
    
   // This function is for canceling tikcet  
     public PageReference  cancelPerticularGuestsTic(){
 string tid = ApexPages.currentPage().getParameters().get('canticId');
 system.debug('XXXXXXXXXXXXXXXQQQQQQQQQQQQ '+tid );
 splitcancelPerticularGuestsTic(tid);
 return null;
 }
 public void splitcancelPerticularGuestsTic(id ticktid){
        List<ticket__c> tickets = new List<ticket__c> ();
        BLN_Mytickets_BAL bal = new BLN_Mytickets_BAL();
        BLN_Ticket_DAO btd = new BLN_Ticket_DAO();
        innLineItems = new List<BLN_Mytickets_BAL.Bondbetweenchkandobj>();
        orid = new SET<id>();
        Order_Item__c ordItin = new Order_Item__c();
         BLN_OrderItem_DAO order_item = new BLN_OrderItem_DAO();
          Ticket__c tc = new ticket__c();
          tc = mapticWithId.get(ticktid);
          id orderIdforRefreshpop = null;
          if(tc == null){
            tc = btd.tcWithTktPid(ticktid);
            
          }else{
            orderIdforRefreshpop = tc.order__c;
          }
           if(tc.Parent_ID__c!=null){ // If this is package
              BLN_Ticket_DAO tDao = new BLN_Ticket_DAO();
              tickets.addAll(tDao.getTcFromPid(tc.Parent_ID__c)); 
              tickets.add(mapticWithId.get(tc.Parent_ID__c));               
           }else{
               tickets.add(tc);
           }
         System.debug('PPPPPPPPPPPPPPPPPPPPPPP '+tickets.size());
         
         orid.add(tc.order__c);
         
         ordItin = mapitemWithId.get(tc.order_item__c);
         if(ordItin == null){
            ordItin = order_item.getTicketsOfperticularOItem(tc.order_item__c)[0];
            system.debug('ordItin======'+ordItin);
          }
         bal.chengeItemOrderCount(ordItin ,tickets); // decresing amount and quantity of order Item
         bal.cancelTickets(tickets); // cancel selected Tickets
           if(tc.Parent_ID__c==null){
              bal.cloneTickets(tickets); // create new tickets
            }
         bal.uypdateOrderStatus(orid);
         
        if(isAttendeesPAge!='Attendee'){
         //onchangeEvent();
          prepareorder(tc.order__c);
         ValuesOfseletedorder= new List<BLN_Mytickets_BAL.inncls>();
         system.debug('orderIdforRefreshpop===='+orderIdforRefreshpop);
         if(orderIdforRefreshpop == null){
           BLN_Mytickets_BAL mybal = new BLN_Mytickets_BAL();
           mybal.serviceorderid = tc.order__c;
           ValuesOfseletedorder = mybal.userTickets('',tc.Event__c,'BLN_ASC_CancelTickets','');
        system.debug('ValuesOfseletedorder ======='+ValuesOfseletedorder+'=='+tc.Event__c);
         }else{
         ValuesOfseletedorder.add(mapOrdIsWithInner.get(orderIdforRefreshpop));
         }
        
          cancelledStr(ValuesOfseletedorder);
        }
      
   } 
    
    // hide cancel popup
    public void closeCan(){
     displayTicForCancel = false;
    }
    
    
 // ----------------------------------------------- popup actions End --------------------------------------------
  
  // This is utill for order edit and ticket edit
  // inserting user,company and uc role and update ticket or update order 
    /* public PAgereference saveLogic(user newu,Ticket__c addGuest,order__c saveord,GN_User__c gnUserEdit){
       try{
       update billingaddr;
       }catch(Exception e){}
       
       BLN_Quick_Registration_BAL quickbal= new BLN_Quick_Registration_BAL();
       String userid=quickbal.checkUser(newu); // Checking user already exists
       string compId ;
       BLN_StatusMessage userMsg;
       
      if(userid==null){ // if not exists calling insert user method
            userMsg=quickbal.insertUser(newu); // inserting user
                  if(userMsg.successBool){
                      userid=userMsg.successId;
                  }
                   gnUserEdit.First_Name__c= newu.firstName;
                   gnUserEdit.Last_Name__c = newu.lastName ;
                   gnUserEdit.Email__c= newu.Email;
                   gnUserEdit.User__c = userid;
                   gnUserEdit.id=null;
                   dataBase.saveResult saver =  DataBase.insert(gnUserEdit,false);
                   string abd = '';
                   if(saver.isSuccess()){
                      abd = saver.getId();
                   }
             
                 mapguIdWithGNU.put(gnUserEdit.id,gnUserEdit);
                 System.debug('ZZZZZZZZZZZZZ   '+compidchanged+' companyName  '+companyName);
                 if(!(compidchanged!=null && compidchanged!='')){ // If user picks existing Company
           
                        if(beforecompany == addGuest.company__c || beforecompany==companyName ){ // If your change email but not company 
                           
                         if((addGuest.company__c!=null && addGuest.company__c !='') || (companyName!=null && companyName!='') ){
                          if(ucrole!= null){
                            UC_Role__c urolenew = new UC_Role__c ();
                            urolenew = ucrole.clone(false,false,false,false);
                            urolenew.id=null;
                            urolenew.GN_User__c = gnUserEdit.id;
                            dataBase.insert(urolenew,false);
                          }
                        }else{
                            company__c comp1 = new company__c();
                            comp1.Name =  newu.firstName+ newu.lastName;  
                            BLN_StatusMessage CompanyMsg=quickbal.insertCompany(comp1 ,compext); // insert company   
                            if(CompanyMsg.Successbool){
                               compId = CompanyMsg.successId;
                               if(!isOrderEdit){
                               addGuest.Client_Company__c= compId ;
                                }else{
                                 saveord.Client_Company__c = compId;
                                }
                               //addGuest.company__c = '';
                            }
                           system.debug('Comp Id................ '+compId );
                           List<UC_Role__c> cd = [select id from UC_Role__c where GN_User__r.Email__c = :newu.Email];
                            if(cd.size()>0){
                                                             
                            }else{
                               UC_Role__c urolenew = new UC_Role__c ();
                               urolenew.GN_User__c= abd ;
                               urolenew.Company__c = compId ;
                               urolenew.User_Type__c = 'Personal';
                               urolenew.Role__c ='Company Admin';
                               dataBase.insert(urolenew,false);
                            }
                           
                        }                      
                            
                          
                      }else{ // If user changes email,company. 
                          company__c comp1 = new company__c();
                           if(!isOrderEdit){
                          comp1.Name = addGuest.company__c;
                            }else{
                               comp1.Name = companyName;
                            }
                          comp1.Description__c = comp.Description__c ;
                          comp1.Website_URL__c = comp.Website_URL__c ;
                          
                           BLN_StatusMessage CompanyMsg=quickbal.insertCompany(comp1 ,compext); // insert company
                             if(CompanyMsg.Successbool){
                               compId = CompanyMsg.successId;
                                //compext.company__c = compId;
                                //dataBase.insert(compext,false);
                              }
                              BLN_UCRole_DAO ucRoleDao = new BLN_UCRole_DAO();
                              system.debug('Uid '+userid +'  Comp id '+compId );
                              BLN_StatusMessage UCRoleMsg = quickbal.insertUCRolewithTitle(gnUserEdit.id,compId ,'' ,'Company Admin','',addGuest.TKT_Job_Title__c); // insert user company Role
                            
                             if(!isOrderEdit){      
                               addGuest.Client_Company__c = compId ;
                             }else{
                                saveord.Client_Company__c = compId;
                             }
                       }      
                   }else{
                       if(!isOrderEdit){    
                           addGuest.Client_Company__c = compidchanged;
                       }else{
                            saveord.Client_Company__c = compidchanged;
                         }
                     } 
             system.debug('QQQQQQQQQQ '+gnUserEdit.id +'qqqqqqqqqq '+isOrderEdit);
                if(!isOrderEdit ){
                   addGuest.Client_GN_User__c =gnUserEdit.id;
                }else{
                   saveord.Client_GN_User__c = gnUserEdit.id;
                }
        
            }else{
               // If user does not change his email address and company name
               System.debug('beforeEditEmail  '+beforeEditEmail  +' newu.Email '+  newu.Email +' isOrderEdit '+isOrderEdit);
                  if(beforeEditEmail == newu.Email){
                      if(!isOrderEdit){
                          companyName = addGuest.Company__c;
                       }else{
                          if(!(companyName!=null && companyName!=''))
                             companyName = editOrdRec.orderInn.Client_Company__r.Name;
                       }
                      if(companyName != beforecompany){ 
                         if(compidchanged!=null && compidchanged!=''){
                              if(!isOrderEdit ){
                                addGuest.Client_Company__c = compidchanged;
                               }else{
                                saveord.Client_Company__c = compidchanged;
                              }
                            
                             if(compext.id!=null){
                                 database.saveresult sres=  dataBase.update(compext,false);
                             }else{
                               compext.company__c  = comp.id;
                               database.saveresult sres=  dataBase.insert(compext,false);
                             }
                             
                              database.saveresult ures=  DataBase.update(comp,false); 
                              System.debug('sressres '+compext.id+'uresures '+ures);
                          }else{
                              company__c comp2 = new company__c();
                               if(!isorderEdit){
                                comp2.Name = addGuest.company__c;
                               }else{
                                comp2.Name = companyName;
                               }
                               comp2.Description__c = comp.Description__c;
                               comp2.Website_URL__c = comp.Website_URL__c;
                               BLN_StatusMessage CompanyMsg=quickbal.insertCompany(comp2 ,null); // insert company
                                compext.Company__c = CompanyMsg.successId;
                               database.Insert(compext,false); 
                                system.debug('Compnay Extensionnnnnnnnnnnn '+compext.id);
                                
                               if(CompanyMsg.Successbool){
                                  compId = CompanyMsg.successId;
                                     if(!isOrderEdit){
                                        addGuest.Client_Company__c = compId ;
                                       }else{
                                        saveord.Client_Company__c = compId;
                                      }
                                  Gn_User__c gnu = [select first_Name__c,Last_Name__c,Email__c,id,User_Pic__c,Biography__c from Gn_User__c where Email__c=:newu.Email limit 1];
                                  BLN_UCRole_DAO ucRoleDao = new BLN_UCRole_DAO();
                                  BLN_StatusMessage UCRoleMsg = quickbal.insertUCRolewithTitle(gnu.id,compId ,'' ,'Company Admin','Business',addGuest.TKT_Job_Title__c);
                                 addGuest.Client_Company__c = compId ;
                                addGuest.Client_GN_User__c = gnu.id;  
                                }
                                
                          }                     
                      }else{ // IF he changes company info
                        if(ucrole!=null){
                          try{
                             if(addGuest.TKT_Job_Title__c!=null && addGuest.TKT_Job_Title__c!=''){ 
                              ucrole.Title__c = addGuest.TKT_Job_Title__c;
                             }
                             dataBase.update(ucrole,false);
                          }catch(exception ed){}
                        
                        }
                        dataBase.update(compext,false);
                        DataBase.update(comp,false);
                      
                      }
                  }else{
                          boolean isCompanyPic= false;
                           if(compidchanged!=null && compidchanged!=''){
                            Company__c companyStr = [select id,Name from company__c where id=:compidchanged];
                            if(addGuest.Company__c==companyStr.Name || companyName==companyStr.Name){
                              isCompanyPic =true;
                            }
                          }
                          System.debug('Comdpais valuesssssssssss '+compidchanged+'************'+isCompanyPic);
                                 
                           if(compidchanged!=null && compidchanged!='' && isCompanyPic==true){
                              if(!isOrderEdit ){
                               Gn_User__c gnu = [select first_Name__c,Last_Name__c,Email__c,id,User_Pic__c,Biography__c from Gn_User__c where Email__c=:newu.Email limit 1];
                                addGuest.Client_GN_User__c = gnu.id;
                                addGuest.Client_Company__c = compidchanged;
                               }else{
                                 Gn_User__c gnu = [select first_Name__c,Last_Name__c,Email__c,id,User_Pic__c,Biography__c from Gn_User__c where Email__c=:newu.Email limit 1];
                                saveord.Client_GN_User__c = gnu.id;
                                saveord.Client_Company__c = compidchanged;
                              }
                       
                       
                          }else{
                               company__c comp3 = new company__c();
                               system.debug('UUUUUUUUUUUUUUUUUU '+isorderEdit +companyName);
                               if(!isorderEdit){
                               
                                if(addGuest.company__c !=null && addGuest.company__c!=''){
                                comp3.Name = addGuest.company__c;
                               }else{
                                    List<UC_Role__c> cd = [select id,Company__c from UC_Role__c where GN_User__r.Email__c = :newu.Email];
                                        if(cd.size()>0){
                                          Gn_User__c gnu = [select first_Name__c,Last_Name__c,Email__c,id,User_Pic__c,Biography__c from Gn_User__c where Email__c=:newu.Email limit 1];
                                           addGuest.Client_Company__c = cd[0].Company__c;
                                            addGuest.Client_GN_User__c = gnu.id;
                                            database.update(addGuest,false);
                                            try{
                                            database.update(gnUserEdit,false);}catch(Exception e){}
                                           return null;
                                        }else{
                                           comp3.Name = addGuest.first_Name__c + addGuest.Last_Name__c;
                                        }
                                 }
                                 
                               }else{
                                comp3.Name = companyName;
                               }
                               comp3.Description__c = comp.Description__c;
                               comp3.Website_URL__c = comp.Website_URL__c;
                               BLN_StatusMessage CompanyMsg=quickbal.insertCompany(comp3 ,null); // insert company
                               if(CompanyMsg.Successbool){
                                  compId = CompanyMsg.successId;
                                  compext.company__c =  compId;
                                  System.debug('Inserted Ectension Company 111111'+compId);
                                  Database.saveresult srd =  database.insert(compext,false); 
                                  System.debug('Inserted Ectension Company '+srd);
                                    Gn_User__c gnu = [select first_Name__c,Last_Name__c,Email__c,id,User_Pic__c,Biography__c from Gn_User__c where Email__c=:newu.Email limit 1];
                                
                                      if(!isOrderEdit){
                                         addGuest.Client_Company__c = compId ;
                                         addGuest.Client_GN_User__c = gnu.id;
                                       }else{
                                         saveord.Client_Company__c = compId;
                                         saveord.Client_GN_User__c = gnu.id;
                                      }
                                   BLN_UCRole_DAO ucRoleDao = new BLN_UCRole_DAO();
                                  BLN_StatusMessage UCRoleMsg = quickbal.insertUCRolewithTitle(gnu.id,compId ,'' ,'Company Admin','',addGuest.TKT_Job_Title__c);
                                }
                           }
                       }
                  }
             if(!isOrderEdit){
             try{
                Gn_User__c gnu1 = [select first_Name__c,Last_Name__c,Email__c,id,User_Pic__c,Biography__c from Gn_User__c where Email__c=:newu.Email limit 1]; 
                gnUserEdit.first_Name__c = gnu1.first_Name__c;
                gnUserEdit.Last_Name__c = gnu1.Last_Name__c;
                database.update(gnUserEdit,false);
                }catch(Exception e){}
                }
                 
             
             if(addGuest.first_Name__c!=null)
             {gnUserEdit.first_Name__c = addGuest.first_Name__c;}
              if(addGuest.last_Name__c!=null)
                gnUserEdit.Last_Name__c = addGuest.Last_Name__c;
                
                database.update(gnUserEdit,false); 
               
             List<Company_Naicscodes__c> naicsListToinsert = new List<Company_Naicscodes__c>();
             BLN_CompNaics_DAO compNaicsDao = new BLN_CompNaics_DAO();
             BLN_CompDiversity_DAO compDivsDao = new BLN_CompDiversity_DAO();
             if(!isOrderEdit){
              // Database.SavePoint();
               // First deleting Naics and then insert Naics newly
              if(naicsCodesString!=''){ 
               compNaicsDao.NaicsHandle(addGuest.Client_Company__c,addGuest.Client_GN_User__c,naicsCodesString);
               }
              if(diverCodesString!=''){
                  compDivsDao.DiversityHandle(addGuest.Client_Company__c,addGuest.Client_GN_User__c,diverCodesString);
              } 
               DataBase.update(addGuest,false);
             }else{
                if(naicsCodesString!=''){ 
                 compNaicsDao.NaicsHandle(Saveord.Client_Company__c,Saveord.Client_GN_User__c,naicsCodesString);
               }
              if(diverCodesString!=''){
                  compDivsDao.DiversityHandle(Saveord.Client_Company__c,Saveord.Client_GN_User__c,diverCodesString);
              }  DataBase.update(saveord,false);
            }
                
          return null;
        }
    */
    // TO DISPLAY THE STATISTICS OF AN EVENT
        public BLN_Mytickets_BAL myTicketsBAL{get; set;}
        public Integer totalTransactions{get; set;}
        public Integer totalAttendees{get; set;}
        public Decimal TotalAmount{get; set;}
        public Decimal AmountThroughCheck{get; set;}
        public Decimal AmountThroughCredit{get; set;}
        public Decimal AmountThroughCash{get; set;}
        public Decimal AmountThroughExtPay{get; set;}
        @Readonly
    @RemoteAction    
        public static BLN_RegDashBoardInfo statistics(String eventid){
        //Statistics
         BLN_RegDashBoardInfo stats=new BLN_RegDashBoardInfo(eventid);
         return stats;
        }
        
     // Get Company Names
  @RemoteAction
    public static List<Company__c> getCompanies(string searchstr,string emailid){
     SET<id> comids = new SEt<id>();
       for(UC_Role__c uc : [select id,Company__r.name,Company__c,RoleId__r.Name from UC_Role__c where User_Type__c!='Personal' and GN_User__r.email__c =:emailid and (RoleId__r.Name='Company Admin' OR RoleId__r.Name='Event Admin' )]){
            comids.add(uc.Company__c);
           
       }
      string v =  searchstr   + '%';  
      return [select id,name from Company__c where id In :comids and name like :v ] ;
   }   
   
    @RemoteAction
    public static List<Company__c> getCompanies1(string searchstr,string emailid){
     SET<id> comids = new SEt<id>();
       for(UC_Role__c uc : [select id,Company__r.name,Company__c,RoleId__r.Name from UC_Role__c where GN_User__r.email__c =:emailid and (RoleId__r.Name='Company Admin' OR RoleId__r.Name='Event Admin' )]){
            comids.add(uc.Company__c);
           
       }
      string v =  searchstr   + '%';  
      return [select id,name from Company__c where id In :comids and name like :v ] ;
   }   
   
    @RemoteAction
   public static List<Company_Ext__c> getCompaniesext(string searchstr){ 
   
    return [select id,company__c,Business_Address1__c,Business_Address2__c,Business_City__c,BLN_Business_Country__c,BLN_Business_State__c,Business_Zipcode__c from Company_Ext__c where Company__c  =:searchstr ] ;
   }
   
   
       
        
        
        public LIST<paymentTypeInner> paymentTypeInnerList{get; set;}
        public Class paymentTypeInner{
        
            public String paymentType{get; set;}
            public Decimal paymentAmount{get; set;}
            
            public paymentTypeInner(String paymentType, Decimal paymentAmount){
                this.paymentType= paymentType;
                this.paymentAmount= paymentAmount;
            }
    
        }
      //method to show speaker data on table
        public List<BLN_Speakers_BAL.inncls> speakBalList{get;set;}
        public Map<String,String> participantmap{get;set;}
        public BLN_Speakers_BAL spkBal{get;set;}
        public void speakerDataInfo(){
        
            spkBal=new BLN_Speakers_BAL ();
             
                 
            speakBalList=new List<BLN_Speakers_BAL.inncls>();
            speakBalList= spkBal.getAllTickets(userInfo.getUserid(),selectedEvent) ;
            participantmap=new Map<String,String>();
            for(Participant__c participant:[select id,name,BLN_TKT_profile__r.BLN_GN_User__c,BLN_Participant_Role__c,BLN_Participant_Role__r.BLN_Events__c,BLN_Participant_Role__r.name from Participant__c where BLN_Participant_Role__r.BLN_Events__c=:selectedEvent and BLN_TKT_profile__r.BLN_GN_User__c!= null])
            {
              if(participantmap.containsKey(participant.BLN_TKT_profile__r.BLN_GN_User__c)){
            String text=participantmap.get(participant.BLN_TKT_profile__r.BLN_GN_User__c);
            if(!text.contains(participant.BLN_Participant_Role__r.name))

                    participantmap.put(participant.BLN_TKT_profile__c,text+','+participant.BLN_Participant_Role__r.name);
            }
            else
            
             
            participantmap.put(participant.BLN_TKT_profile__c,participant.BLN_Participant_Role__r.name);
            
             
            }
           
            
        }
      
        public PageReference showInvoice() {
 
    PageReference pg=new PageReference(Label.siteurl+'/apex/BLN_InvoiceSchedulePage?ordid='+ApexPages.currentPage().getParameters().get('showinvoiceordid'));
     
 return pg;
       
    }

public PageReference sendOrdConfirmation() {
    BLN_SuccessController success=new BLN_SuccessController();
    success.isResend=true;
    string ordid=ApexPages.currentPage().getParameters().get('ordId');
    success.sendMail(ordid,selectedEvent);
    return null;
}


public PageReference sendInvoice() {

try {
BLN_Invoice_Utility bln=new BLN_Invoice_Utility();
string ordid=ApexPages.currentPage().getParameters().get('sendinvordid');
string mailId = ApexPages.currentPage().getParameters().get('sendinvemail');

if(mailId != '' && mailId != null){
bln.SendInvoice (ordid,mailId);
}else{
    order__c ord= [select id,bln_tkt_profile__r.email__c from order__c where id = :ordId];
    
        bln.SendInvoice (ord.id,ord.bln_tkt_profile__r.email__c);
}
} catch(Exception EE){}
return null;
} 

@RemoteAction
public static GN_User__c getGnuser(String email)
{

GN_User__c gnUser=new GN_User__c();
   if(email!=null&&email!=''){
   BLN_Quick_Registration_BAL quickbal= new BLN_Quick_Registration_BAL();
    user newu=new user();
    newu.email=email;
   String userid=quickbal.checkUser(newu);
   try{
 gnUser=[select id,First_Name__c,Last_Name__c,User__c,Age__c,DOB__c,Eff_Date__c,Email__c,Gender__c,Home_Phone__c,Is_Active__c,Mobile__c,User_Pic__c,Suffix__c,Prefix__c,Biography__c,Blogger__c,FaceBookId__c,LinkedInId__c,TwitterId__c,Video__c from GN_User__c where User__c=:userid];
 }catch(Exception e){}
  }
  return gnUser;
}    
    
    
public String roleselectid{get;set;}
 @RemoteAction
    global static String checkUser(String email) {
    BLN_Quick_Registration_BAL quickbal= new BLN_Quick_Registration_BAL();
    user newu=new user();
    newu.email=email;
   String userid=quickbal.checkUser(newu); // Checking user already exists
       string compId ;
       BLN_StatusMessage userMsg;
       
      if(userid==null)
      return 'Not Exist';
      else
      return 'Exist';
    }
   @RemoteAction
    global static String getTimeZoneValue(Long dateTimeValue) {
        
            DateTime dt=DateTime.newInstance(dateTimeValue);
            
            return dt.formatGMT('MM/dd/yyyy');
            
       
    }  
    public void delattachment(){
     List<Attachment> attac = new List<Attachment>();
     attac = [select Id,Name From Attachment where id=: ApexPages.currentPage().getParameters().get('deletedId') ];
      SYSTEM.DEBUG(' ====================@@ '+attac );
     Database.DeleteResult[] DR_Dels = Database.delete(attac,True); 
   //get the attachements for clientgnuser
    attlist=new List<Attachment>();
    attlist=[SELECT Id, Name,Description,ContentType FROM Attachment where parentid=:addGuest.tkt_profile__r.BLN_GN_User__c];
    //
 }
  @RemoteAction
    global static String saveChkInfo(String type,String recId,String recVal) {
    
        if(type=='Order'){
           Order__c ord = new Order__c ();
          try{ 
             ord = [select Order_Status__c,Id from Order__c where id=:recId];
           }catch(exception rt){
             return rt.getMessage();
           }
           ord.Order_Status__c=recVal; 
           DataBase.update(ord,false);
        }else{
           Payment__c pay = new Payment__c();
            System.debug('IIIIIIII '+recId);
           try{
              pay=[select id,Payment_Ref_Number__c from Payment__c where id=:recId];
           }catch(exception rt){
              return rt.getMessage();
           }
           pay.Payment_Ref_Number__c = recVal;
           DataBase.update(pay,false);
        }
       return 'Success';
            
       
    } 
    
    
    //By Vineel to Print Order Summary 
    public BLN_EventDetails eventInfo{get; set;}
    public pageReference printorderinvoice(){
    string eveid = Apexpages.currentPage().getParameters().get('eveid');
    eventInfo= new BLN_EventDetails();
    eventInfo.eventDetailsToDisplay(eveid);
        pageReference pg =new pageReference('/apex/BLN_Printorderinvoice');
        
        /*  */
        if(apexpages.currentpage().getparameters().get('isGridMytic')=='myTicketGridLevel'){
         ValuesOfseletedorder = new List<BLN_Mytickets_BAL.inncls>();
        selectedOrd = apexpages.currentpage().getparameters().get('selectedOrd');
        System.debug('selectedOrd '+selectedOrd);
        prepareorder(selectedOrd);
        isBuyer=false;
        
        if(mapOrdIsWithInner.get(selectedOrd).orderInn.BLN_TKT_profile__r.Email__c == userinfo.getusername())
        isBuyer=true;
        
        try{
          ValuesOfseletedorder.add(mapOrdIsWithInner.get(selectedOrd));
         cancelledStr(ValuesOfseletedorder);
        }catch(exception e){}
       
        
         System.debug('Orderrrrrrrrrrrrrrrr '+selectedOrd);
        orddetailbool = true;
        }
        
         
        
        
        return pg;
    } 
    
    //By Vineel to Print Order Summary 
    public BLN_EventDetails eventInfo1{get; set;}
    public pageReference printordersummary(){
    string eveid1 = Apexpages.currentPage().getParameters().get('eveid1');
    system.debug('eveid1===='+eveid1);
    eventInfo1= new BLN_EventDetails();
    eventInfo1.eventDetailsToDisplay(eveid1);
        pageReference pg =new pageReference('/apex/BLN_PrintOrderSummary');
        return pg;
    } 
    
    //By Vineel to Send Invoice 
    public PageReference disableoroderbool() {
    orddetailbool = false;
    return null;
    }
    
    //method for updating row order in drag and drop case by thirupathi pattipaka
    public String speakerOrder{get;set;}{speakerOrder='';}
    Public void updateSpeakerOrder(){
        isMove=true;
        //System.debug('MMMMMMMMMMMMMMMM'+isMove);
        speakerOrder= Apexpages.Currentpage().getparameters().get('speakerOrder');
        //System.debug('@@@@@@'+agendaOrder);
        string[] splitted = speakerOrder.split(' ');
        List<ticket__c> spkrList=new List<ticket__c>();
        for(integer i=0;i<splitted.size();i++)
        {
             string[] ordersplit = splitted[i].split(',');
             //System.debug('MY IDDDDD:'+ordersplit[0]);

             ticket__c q=new ticket__c(id=ordersplit[0],Ticket_Display_Order__c=Integer.valueOf(ordersplit[1]));
             spkrList.add(q);
             
        }
        update spkrList;
    }
 
    public ApexPages.StandardSetController setCon {get;set;}
     public string dataTableJson {get;set;}
public void processData(){
            string subwhere='';
           BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
            //blnMyticketsBal.userTickets('005M0000006pFLB','a17M0000003A3IO','BLN_Orders', 'All')
            String wherecondition='';
            wherecondition = ' where Events__c = \''+selectedEvent+'\' and order_type__c !=\'EVENT PRODUCER\' and Order_Status__c !=\'Abandoned\'';  //  
            
              String fdate = ApexPages.currentPage().getParameters().get('fdate');
            String tdate = ApexPages.currentPage().getParameters().get('tdate');
            String searchKey = ApexPages.currentPage().getParameters().get('search[value]');
             String fil1 =    ApexPages.currentPage().getParameters().get('columns[9][search][value]');
              String fil2 =    ApexPages.currentPage().getParameters().get('columns[8][search][value]');
                           String fil3 =    ApexPages.currentPage().getParameters().get('columns[11][search][value]');
               
        Date FromDate;
        Date ToDate;     
        
        if(fdate != NULL && fdate != ''){
            FromDate = Date.parse(fdate);
            wherecondition += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(tdate != NULL && tdate != ''){
            ToDate = Date.parse(tdate);
            wherecondition += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
               
              //Payments__r.Payment_Mode__c
              if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0)
              {
               String[] tokens = searchKey.split(' ');
              if(tokens.size()==2){
                                                     
                                subwhere+='and ((BLN_TKT_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and BLN_TKT_profile__r.Last_Name__c like \'%'+tokens[1]+'%\') '; 
                              subwhere+='or (BLN_TKT_profile__r.First_Name__c  like \'%'+tokens[1]+'%\' and BLN_TKT_profile__r.Last_Name__c like \'%'+tokens[0]+'%\') ';
                              
                                }
                                else{
                                
                                subwhere+='and ( BLN_TKT_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' or BLN_TKT_profile__r.Last_Name__c  like \'%'+searchKey+'%\' ';
                                } 
              subwhere+= ' or  Name like \'%'+searchKey+'%\' or BLN_TKT_profile__r.TKT_Company__c like \'%'+searchKey+'%\' or BLN_TKT_profile__r.Email__c like \'%'+searchKey+'%\' or    Order_Status__c like \'%'+searchKey+'%\')';// Payments__r.Payment_Mode__cor Payments__r.records[0].Payment_Mode__clike \'%'+searchKey+'%\ )'; 
              wherecondition= wherecondition+subwhere;
              }
            
              if(fil1!=''){
               
                        String tok = fil1.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                    String tok3 = tok2.replace('\\','');
                    list<String> tok4 = tok3.split(';');
                    wherecondition += ' and (';
                    
                        for(integer i=1;i<tok4.size();i++){
                    //System.debug(']]]]]'+tok4.get(i));
                    
                    wherecondition += ' Order_Status__c  like \'%'+tok4[i]+'%\' ';  //append to base Query
                    
                    wherecondition+=' or ';
                    }
                    wherecondition+='Order_Status__c like \'%'+tok4[tok4.size()-1]+'%\' )';

                    }
                    
                    
                    
                    
              if(fil2 !=''){
               String  wherecondition1='';
                        String tok = fil2.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                    String tok3 = tok2.replace('\\','');
                    list<String> tok4 = tok3.split(';');
                 
             
                  
                   Payment__c p;
                    String NewPayQuery = 'select Order__c from Payment__c p where Order__r.Events__c=:selectedEvent  and Order__r.Order_Status__c !=\'Abandoned\' and Order__r.order_type__c !=\'EVENT PRODUCER\' ';
                    
                     wherecondition1 +=' and (';
                    
                        for(integer i=1;i<tok4.size();i++){
                   
                    wherecondition1 += ' Payment_Mode__c  like \'%'+tok4[i]+'%\' ';  //append to base Query
                    
                    wherecondition1+=' or ';
                    }
                    wherecondition1+='Payment_Mode__c like \'%'+tok4[tok4.size()-1]+'%\' )';
    
                        List<Payment__c> plist= DataBAse.query(NewPayQuery+wherecondition1);
                    System.debug('final size is '+plist);
                   PayOrderids = new List<String>();
                   for(integer i=0;i<plist.size();i++){
                   System.debug('1111'+plist[i].Order__c);
                   PayOrderids.add(plist[i].Order__c);
                    }
                    System.debug('=======> '+PayOrderids);
                    }
                    
                     if(fil3 !=''){
               String  wherecondition2='';
                        String tok = fil3.replace('|', ';');
                    String tok1 = tok.replace('^(',';');
                    String tok2 = tok1.replace(')$',';');
                    String tok3 = tok2.replace('\\','');
                    list<String> tok4 = tok3.split(';');
                 
             
                  
                   Payment__c p;
                    String NewPayQuery = 'select Order__c from Payment__c p where Order__r.Events__c=:selectedEvent  and Order__r.Order_Status__c !=\'Abandoned\' and Order__r.order_type__c !=\'EVENT PRODUCER\' ';
                    
                     wherecondition2 +=' and (';
                    
                        for(integer i=1;i<tok4.size();i++){
                   
                    wherecondition2 += ' Registration_Type__c like \'%'+tok4[i]+'%\' ';  //append to base Query
                    
                    wherecondition2+=' or ';
                    }
                    wherecondition2+='Registration_Type__c like \'%'+tok4[tok4.size()-1]+'%\' )';
    
                        List<Payment__c> plist= DataBAse.query(NewPayQuery+wherecondition2);
                    System.debug('final size is '+plist);
                   PayOrderids1 = new List<String>();
                   for(integer i=0;i<plist.size();i++){
                   System.debug('1111'+plist[i].Order__c);
                   PayOrderids1.add(plist[i].Order__c);
                    }
                    System.debug('=======> '+PayOrderids1);
                    }
                    
                    /**********Sorting***/
                    
                    List<String>ColName = New List<String>();
                            ColName.add('');//1 column
                             ColName.add('');//2 column
                            ColName.add('Name');//3 column
                            ColName.add('BLN_TKT_profile__r.First_Name__c');//4 column
                            ColName.add('BLN_TKT_profile__r.Email__c');//5 column
                            ColName.add('BLN_TKT_profile__r.Mobile__c');//6 column
                            ColName.add('BLN_TKT_profile__r.TKT_Company__c');//7 
                          ColName.add('CreatedDate');//8 date
                          ColName.add('');//9 paytype
                            ColName.add('Order_Status__c');//order status
                            ColName.add('Amount_Paid__c');
                            ColName.add('');
            
            
                    integer i = 0;
                    integer v ;
                    
                    String str;
            
                    String col = ApexPages.currentPage().getParameters().get('order[0][column]');//Column to which ordering should be applied 
                    
                    String sortord = ApexPages.currentPage().getParameters().get('order[0][dir]');//Get The direction of Sorting ASC or DESC
                    
               
            /****check user sorting on any column on not *****/
            /****use First Column as default sorting column*****/
            
                    if(col!=null){
                        //System.debug('^^^^^^^ : '+col);
                        //We get column number as String convert it in to int and get element from Above ColName List With Index V
                        v=integer.valueof(col);
                
                        //str going to hold the filed name of the Sorting column
                    
                        str=ColName.get(v);
            
                    //  queryString += ' order by ' + str +' '+ApexPages.currentPage().getParameters().get('order[0][dir]');
                        wherecondition += ' order by ' + str ;
                        }else{
                            str='Name';
                            //System.debug('^^^^^ : Not entered');
                            wherecondition += ' order by ' + str ;
                            }
            
            
                /*******Take Default Sorting Order as 'desc'***/
                        if(sortord==null){
                                sortord='desc';
                        }
            
            
            /****Append Sorting order to The Query String***/
                    
                    wherecondition += ' '+sortord; 
    
                    /****Sorting end**/
            
           if(fil2==''){
            setcon=new ApexPages.StandardSetController(blnOrderDao.orderQuery(wherecondition ));
            } if(fil2!=''){
            setcon=new ApexPages.StandardSetController(blnOrderDao.ExorderQuery(PayOrderids));
            
            }
            //else if(fil3==''){
           // setcon=new ApexPages.StandardSetController(blnOrderDao.orderQuery(wherecondition ));
           // }
             if(fil3!=''){
            setcon=new ApexPages.StandardSetController(blnOrderDao.ExorderQuery(PayOrderids1));
            
            }
            //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            System.debug('start value: '+start);
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            System.debug('size value : '+size);
            setCon.setPageSize(10);
            
        Integer noOfRecords= setCon.getResultSize();
        System.debug('size value : '+noOfRecords);
            if(size==-1){
            size=noOfRecords;
            }
            setCon.setPageSize(size);
            
        
            //set pagenumber
            setCon.setPageNumber((start/size)+1);
            
            RecList = setCon.getRecords(); 
            
            
         //listOfListsobject.add( RecList);
            //List<sobject> contactList = setCon.getRecords();
       //List<SObject> contactList= setCon.getRecords(); 
       List<SubWrapper> orderList1 = new List<SubWrapper>();
       
       // create a sub wrapper
       
       for(Order__c ac: RecList){
       Id val=ac.id;
       
        orderList1.add(new SubWrapper(ac, val));
       
       }
       
            // totalAttendees=RecList.size();
              System.debug('&&&&&&&&&&&&&&&'+orderList1.size());
      
            //create wrapper
            System.debug('Records of order------------------------------------------------------------------'+orderList1);
            DataTableWrapper datawrap = new DataTableWrapper(0,noOfRecords,noOfRecords,orderList1);
            
            dataTableJson = JSON.serialize(datawrap);
            

}

public void prepareorder(String orderid)
{
  SET<id> GnuserList = new  SET<id>();
      SET<id> companyIds= new  SET<id>();
      pcompanies='';
      mapticWithId  = new MAP<id,ticket__c>(); 
      mapitemWithId = new MAP<id,order_item__c>(); 
      mapguIdWithGNU = new MAP<id,GN_User__c>();
      List<Ticket__c> ticketsList = new List<Ticket__c>();
      integer i=0;
      blnMyticketsBal = new BLN_Mytickets_BAL();
      blnMyticketsBal.orderId=orderid;
      mapOrdIsWithInner = new MAP<id,BLN_Mytickets_BAL.inncls>();
      integer k=0;
      
      List<BLN_Mytickets_BAL.inncls> innerInstanceForMytick = new List<BLN_Mytickets_BAL.inncls>();
       if(urlCheck=='BLN_Mytickets' ){
       
       innerInstanceForMytick = blnMyticketsBal.userTickets(loginUserId,'All',urlCheck, 'All') ;
       } else {
       innerInstanceForMytick = blnMyticketsBal.userTickets(loginUserId,selectedEvent,'BLN_Attendees', 'All') ;
       }
              
       
      
            
            for(BLN_Mytickets_BAL.inncls innTotal : innerInstanceForMytick ){
        //Restricting abandoned orders
            companyIds.add(innTotal.orderInn.BLN_TKT_profile__r.BLN_Company__c);
             mapOrdIsWithInner.put(innTotal.orderInn.id,innTotal);
            GnuserList.add(innTotal.orderInn.BLN_TKT_profile__r.BLN_GN_User__c); 
              if(displayandhideIdes.size()>0){ 
               if(displayandhideIdes.contains(innTotal.orderInn.id)){
                   innTotal.displayOrderItems =true;
               }  
             }  
            
          k++;
          //if(urlCheck !='BLN_Attendees')
            //inncurrentTickets.add(innTotal);
            if(k==1000){
            //if(urlCheck !='BLN_Attendees')
              //listOfListOrders.add(inncurrentTickets);
              inncurrentTickets= new List<BLN_Mytickets_BAL.inncls>();
              k=0;
            }
            ticketsList.addAll(innTotal.ticketsInn);
             for(order_item__c orditem : innTotal.orderItemInn){
                 mapitemWithId.put(orditem.id,orditem ); // map orderItem with its id
                
              }
        
            }
            system.debug('@@companyIds'+companyIds);
             for(Ticket__c tc :ticketsList){
           mapticWithId.put(tc.id,tc); // Map tickets with its id  
           GnuserList.add(tc.TKT_profile__r.BLN_Company__c);
         } 
         for(UC_Role__c ucr : [select id,User_Type__c,Company__c  from UC_Role__c where Company__c in :companyIds]){
          if(ucr.User_Type__c =='Personal'){
             pcompanies+= ucr.Company__c;  
          } 
       }   
         
         BLN_Gnuser_DAO guDAO = new BLN_Gnuser_DAO();
         for(GN_User__c gnu : guDAO.getGnuserList(GnuserList)){
            mapguIdWithGNU.put(gnu.id,gnu); 
         } 
}

  
  
  /***********************sub wrapper****/
// inner class
public class SubWrapper{

  public Id DT_RowId{ get; set; }
  public Order__c item { get; set;}
  public String createdon{get;set;}

  public SubWrapper(Order__c item, Id counter) {
    this.item = item;
    this.DT_RowId= counter;
    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
    tz.tZone=item.Events__r.Time_Zone__c;
    tz.format='MM/dd/yyyy hh:mm a';
    tz.dateTimeValue=item.createddate;
    this.createdon=tz.getTimeZoneValue();
  }  
  }
  
  public class DataTableWrapper
        {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public List<SubWrapper> data;
            //  public List<Contact> allids;
            public DataTableWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,list<SubWrapper> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data = data;
              
            }
         
        } 
       
        
        public void exporsed(){
         BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
       String selectedck=apexpages.currentpage().getparameters().get('MyName');
        System.debug('hi seconf page '+selectedck);
         String tok1 = selectedck.replace('\"','');
            String tok2 = tok1.replace(']','');
            String tok3 = tok2.replace('[','');
          
            
     List<String> allIds= tok3.split(',');
     system.debug('iiii'+allIds);
        exportOrders1 = new List<Order__C>();
      
            
        exportOrders1 =    blnOrderDao.ExorderQuery(allIds);
        system.debug('exportOrders==='+ exportOrders1);
    
        }
        
           public void printorsed(){
         BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
       String selectedck=apexpages.currentpage().getparameters().get('MyName');
        System.debug('hi seconf page '+selectedck);
         String tok1 = selectedck.replace('\"','');
            String tok2 = tok1.replace(']','');
            String tok3 = tok2.replace('[','');
          
             BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
           eventInfo1= new BLN_EventDetails();
           eventInfo1.eventDetailsToDisplay(selectedEvent);       
     List<String> allIds= tok3.split(',');
     system.debug('iiii'+allIds);
        printOrders1 = new List<Order__C>();
      
            
        printOrders1 =    blnOrderDao.ExorderQuery(allIds);
        system.debug('printOrders==='+ printOrders1);
    
        }     
  
        @RemoteAction
    global static boolean validateBarcode(string barcode,String eventid,string tid)
    {
        boolean isexists=false;
        BLN_Ticket_DAO ticDAO=new BLN_Ticket_DAO();
        LIST<ticket__c> ticLst=new LIST<ticket__c>();
        string wherecondition = ' Where ticket_status__c = \'Booked\' AND event__c =\''+eventid+'\' AND (Item_Type__r.Badgable__c != \'N - No Badge\' OR Item_Pool__r.Badgable__c != \'N - No Badge\') AND id != \''+tid+'\'';
        ticLst=ticDAO.userOrderAndTickets(wherecondition );
        for(ticket__c t:ticLst){
            if(t.custom_barcode__c ==barcode){
                isexists=true;
            }
        }
       return isexists;
    }
 
        
}