/***********************************************************************************************
*   Controller Name : BLN_ReportsCon
*   Date            : 10/14/2014
*   Author          : Manasa Gandham
*   Purpose         : This class is to display the Reports
*   Change History  : 12/03/2015

*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  10/14/2014            Manasa Gandham                  To Create Page
   12/03/2015            Arindam Sarkar                  Implemented Pagination and Export In Batches
*  
**************************************************************************************************/

public class BLN_ReportsCon {
    
    
    public LIST<SelectOption> orderTypes{get; set;}
    public String selectedOrderType{get; set;}
    public BLN_RegDashBoardInfo All_staticstics{get;set;}
    public transient list<BLN_RegDashBoardInfo.InnForPgateways> paymenttyperev {get;set;}
    Public String currencySymbol{get;set;}
    public date  edte{get;set;}
    public date sdte{get;set;}
    public date edte1{get;set;}
    public date sdte1{get;set;}
    public BLN_ReportsCon(){
    
    try{
        ordExlist=new list<order__c>();
        orderTypes= new LIST<SelectOption>();
        orderTypes.add(new SelectOption('All', 'All'));
        orderTypes.add(new SelectOption('Successed', 'Successed'));
        orderTypes.add(new SelectOption('Cancelled', 'Cancelled'));
        selectedOrderType= 'All';
        
        balToGetOrders= new BLN_ReportsCon_BAL();
        EventDates= new BLN_Event__c();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
            selectedEvent= k.getValue();
            BLN_PromoCode_BAL blneventdetail_bl = New BLN_PromoCode_BAL();
             BLN_Event__c  seventdet = new BLN_Event__c  ();
             seventdet = blneventdetail_bl.eventdetails(selectedEvent);
             currencySymbol = seventdet.BLN_Country__r.Currency__r.Currency_Symbol__c;
            //All_staticstics = new BLN_RegDashBoardInfo(selectedEvent);
            //displayOrders();
        }  
        
        //selectedEvent ='a0sc0000002rKZD';
        //displayOrders();
        }catch(exception ex){}
    }
    
    
    
    public String SelectedEvent{get; set;}
    
    // Statistics Variable Declaration
    public Integer TotalTransactions{get; set;}
    public Integer TotalAttendeesRegistered{get; set;}
    public Decimal AmountThroughCheck{get; set;}
    public Decimal AmountThroughCredit{get; set;}
    public Decimal AmountThroughCash{get; set;}
    public Decimal TotalAmount{get; set;}

    public BLN_Event__c EventDates{get; set;}
    public String SearchString{get; set;}
    public transient LIST<LIST<Order__c>> ListOfListOrders{get; set;}    
    public BLN_ReportsCon_BAL balToGetOrders{get;set;}
    
    //public Integer OrderNumber{get; set;}
    public Integer AttendeeNumber{get; set;}
    
    public String pCompName{get; set;}  
   @Readonly
    @RemoteAction    
        public static BLN_RegDashBoardInfo loadstatictics(String eventid){
        //Statistics
         BLN_RegDashBoardInfo stats=new BLN_RegDashBoardInfo(eventid);
         return stats;
        }
    
    public Pagereference displayOrders(){
    
       
        return null;
    }
    
    // Export Orders list
    
    
   
    
    public BLN_EventDetails eventInfo{get; set;}
    public pagereference printOrders(){
        
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
        eventInfo= new BLN_EventDetails();
        eventInfo.eventDetailsToDisplay(selectedEvent);
        //displayOrders();
        pageReference pg = page.BLN_OrdersPrint;    
        return pg;
    
    }
    // CODE TO GET HEADER SIDE BAR AND FOOTER
    
    public BLN_UtillDisplayLinks   myticket { get; set; }
  
    public boolean isEventAdmin{get;set;}
    public boolean isBoothadmin{get;set;}
    public BLN_Event__c  se{get;set;}
  
    public PageReference hideEventsTab() {
    try{
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){ 
      selectedEvent = k.getValue();
       }
   
     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     se = new BLN_Event__c  ();
      try{
     se = blneventdetailbal.eventdetails(selectedEvent );
     }catch(exception e){}
      
     myticket = new BLN_UtillDisplayLinks();
    myticket.isReportsPageExpand='expand';
    myticket.isOrderReportPage='active';
    myticket.tablabel='Order Sales Report';
    myticket.EventId = selectedEvent ;
    
    
   try{
     myticket.eventName=se.NAme;
    }catch(exception e){}
     myticket.userPermissions(userInfo.getUserId(),selectedEvent);
     }catch(exception ex){}
        return null;
     
    }
    
    public transient LIST<paymentTypeInner> paymentTypeInnerList{get; set;}
    public Class paymentTypeInner{
        
        public String paymentType{get; set;}
        public Decimal paymentAmount{get; set;}
        
        public paymentTypeInner(String paymentType, Decimal paymentAmount){
            this.paymentType= paymentType;
            this.paymentAmount= paymentAmount;
        }
    
    }
    
    
    
    
    public ApexPages.StandardSetController setCon {get;set;}
    public List<Order__c> RecList{get;set;}
     public string dataTableJson {get;set;}
     public list<order__c> ordExlist{get;set;}
public void processData(){
            string subwhere='';
           BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
            //blnMyticketsBal.userTickets('005M0000006pFLB','a17M0000003A3IO','BLN_Orders', 'All')
                      
            
            String wherecondition='';
            wherecondition = ' where Events__c = \''+selectedEvent+'\' and order_type__c !=\'EVENT PRODUCER\' ';
           
            String selectorder=    ApexPages.currentPage().getParameters().get('selectorder');
             String fdate=    ApexPages.currentPage().getParameters().get('fdate');
                    String tdate=    ApexPages.currentPage().getParameters().get('tdate');
            String colnum= ApexPages.currentPage().getParameters().get('colnum');
            String direction= ApexPages.currentPage().getParameters().get('dir');
                    
                    if(selectorder==null||selectorder==''||selectorder=='All')
                    wherecondition+=' AND Order_Status__c != \'Abandoned\'';
                    if(selectorder=='Successed')
                    wherecondition+=' AND Order_Status__c !=\'Cancelled\' AND Order_Status__c != \'Abandoned\' AND Order_Status__c !=\'Not Paid\'';
                    if(selectorder=='Cancelled')
                    wherecondition+=' AND Order_Status__c =\'Cancelled\'';
                    //wherecondition+=' ORDER BY createddate DESC';
                    
                    String searchKey = ApexPages.currentPage().getParameters().get('searchKey');
                 if(searchKey != null && searchKey != '')
              {
                               
                                subwhere+='and ((BLN_TKT_profile__r.First_Name__c  like \'%'+searchKey+'%\' and BLN_TKT_profile__r.Last_Name__c like \'%'+searchKey+'%\') '; 
                              subwhere+='or (BLN_TKT_profile__r.First_Name__c  like \'%'+searchKey+'%\' and BLN_TKT_profile__r.Last_Name__c like \'%'+searchKey+'%\') ';
                              
              subwhere+= ' or  Name like \'%'+searchKey+'%\' or BLN_TKT_profile__r.TKT_Company__c like \'%'+searchKey+'%\' or BLN_TKT_profile__r.Email__c like \'%'+searchKey+'%\' or    Order_Status__c like \'%'+searchKey+'%\')';// Payments__r.Payment_Mode__cor Payments__r.records[0].Payment_Mode__clike \'%'+searchKey+'%\ )'; 
              wherecondition= wherecondition+subwhere;
              }
                                     
                    
                    if(fdate!=null&&fdate!=''&&tdate!=null&&tdate!=''){
                    Date FromDate=Date.parse(fdate);
                    Date ToDate=Date.parse(tdate);
                    wherecondition+=' and CreatedDate >= '+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z  AND  CreatedDate <= '+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z';
                    }
                    else if(fdate!=null&&fdate!=''){
                    Date FromDate=Date.parse(fdate);
                    Date ToDate=Date.parse(fdate);
                    wherecondition+=' and CreatedDate >= '+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z  AND  CreatedDate <= '+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z';
                    }
                    else if(tdate!=null&&tdate!=''){
                    Date FromDate=Date.parse(tdate);
                    Date ToDate=Date.parse(tdate);
                    wherecondition+=' and CreatedDate >= '+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z  AND  CreatedDate <= '+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z';
                    }
            
            if(direction !='' && colnum !='' )
              {
              
              wherecondition+=' order by CreatedDate '+direction;
              }
          ordExlist  =new list<order__c>();
          ordExlist  = blnOrderDao.orderQuery(wherecondition );
          setcon=new ApexPages.StandardSetController(ordExlist);
            
                    
           
            //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            System.debug('start value: '+start);
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            System.debug('size value : '+size);
            setCon.setPageSize(3);
            
        Integer noOfRecords= setCon.getResultSize();
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
        
        
        public string selectedck{get;set;}
    // export only Selected orders
    public pageReference  userSelectPerticularToExport(){
       pageReference pg = new PageReference ('/apex/BLN_OrdersExport');
        
        pg.setRedirect(true);
       
        pg.getParameters().put('fromdate',apexpages.currentpage().getparameters().get('fromdate'));
        pg.getParameters().put('todate',apexpages.currentpage().getparameters().get('todate'));
        pg.getParameters().put('filter',apexpages.currentpage().getparameters().get('filter'));
        pg.getParameters().put('search',apexpages.currentpage().getparameters().get('search'));
        return pg; 
    } 
    public List<Order__C>  exportOrders1{get;set;}
    
    public Pagereference exportselected(){
          String fdate=apexpages.currentpage().getparameters().get('fromdate');
        String tdate=apexpages.currentpage().getparameters().get('todate');
       String selectorder=apexpages.currentpage().getparameters().get('filter');
       String searchKey=apexpages.currentpage().getparameters().get('search');
      System.debug('from date'+fdate);
      
      BLN_Order_DAO blnOrderDao = new BLN_Order_DAO();
            //blnMyticketsBal.userTickets('005M0000006pFLB','a17M0000003A3IO','BLN_Orders', 'All')
                      
            
            String wherecondition='';
             string subwhere='';
            wherecondition = ' where Events__c = \''+selectedEvent+'\' and order_type__c !=\'EVENT PRODUCER\' ';
           
                   if(selectorder==null||selectorder==''||selectorder=='All')
                    wherecondition+=' AND Order_Status__c != \'Abandoned\'';
                    if(selectorder=='Successed')
                    wherecondition+=' AND Order_Status__c !=\'Cancelled\' AND Order_Status__c != \'Abandoned\' AND Order_Status__c !=\'Not Paid\'';
                    if(selectorder=='Cancelled')
                    wherecondition+=' AND Order_Status__c =\'Cancelled\'';
                    
                    
                    if(searchKey != null && searchKey != '')
              {
                               
                                subwhere+='and ((BLN_TKT_profile__r.First_Name__c  like \'%'+searchKey+'%\' and BLN_TKT_profile__r.Last_Name__c like \'%'+searchKey+'%\') '; 
                              subwhere+='or (BLN_TKT_profile__r.First_Name__c  like \'%'+searchKey+'%\' and BLN_TKT_profile__r.Last_Name__c like \'%'+searchKey+'%\') ';
                              
              subwhere+= ' or  Name like \'%'+searchKey+'%\' or BLN_TKT_profile__r.TKT_Company__c like \'%'+searchKey+'%\' or BLN_TKT_profile__r.Email__c like \'%'+searchKey+'%\' or    Order_Status__c like \'%'+searchKey+'%\')';// Payments__r.Payment_Mode__cor Payments__r.records[0].Payment_Mode__clike \'%'+searchKey+'%\ )'; 
              wherecondition= wherecondition+subwhere;
              }
                                     
                    
                    if(fdate!=null&&fdate!=''&&tdate!=null&&tdate!=''){
                    Date FromDate=Date.parse(fdate);
                    Date ToDate=Date.parse(tdate);
                    wherecondition+=' and CreatedDate >= '+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z  AND  CreatedDate <= '+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z';
                    }
                    if(fdate!=null&&fdate!=''){
                    Date FromDate=Date.parse(fdate);
                    Date ToDate=Date.parse(fdate);
                    wherecondition+=' and CreatedDate >= '+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z  AND  CreatedDate <= '+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z';
                    }
                    if(tdate!=null&&tdate!=''){
                    Date FromDate=Date.parse(tdate);
                    Date ToDate=Date.parse(tdate);
                    wherecondition+=' and CreatedDate >= '+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z  AND  CreatedDate <= '+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z';
                    }
            
            
            exportOrders1= new List<Order__C>();
      
            
        exportOrders1=blnOrderDao.orderQuery(wherecondition );
        if(exportOrders1.size()>1000){
        Id batchInstanceId = Database.executeBatch(new BLN_ExportOrders ('Select (Select Order_Item__r.Each_Ticket_Price__c,Order__r.Order_Taxes__c,Item_Pool__c,Item_Type__c,item__r.item_name__c,id,tkt_profile__r.bln_gn_user__c,tkt_profile__r.tkt_company__c,tkt_profile__r.Email__c,tkt_profile__r.bln_gn_user__r.user__c,tkt_profile__r.bln_gn_user__r.user__r.userName,tkt_profile__r.bln_gn_user__r.user__r.email,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Mobile__c, Event__c,Order__c,Order_Item__c,Ticket_Status__c,Tstatus_Id__r.Tstatus_name__c,Badge_Label__c,NAme,Item_Type__r.Name,tkt_profile__r.bln_gn_user__r.user__r.MobilePhone,lastmodifiedDate,item_pool__r.addon_parent__r.id, Parent_ID__c,Item_Pool__r.Item_Type__r.Name, Order_Item__r.Item_Fee__c, Order_Item__r.Item_Discount__c, Order_Item__r.Item_Quantity__c,Item_Pool__r.Item_Pool_Name__c,order_item__r.tax__c from Tickets__r),(Select Item__r.Event__r.End_Date__c,Each_Ticket_Price__c,item__r.event__r.Name ,Promotion__c,Promotion__r.Name, Order__c, Name, Item__c, Item_Total__c,order__r.BLN_TKT_profile__r.BLN_GN_User__c, order__r.BLN_TKT_profile__r.Email__c,Item_Quantity__c, Item_Price__c, Item_Discount__c, Id,item__r.item_name__c,Status__c,Promotion__r.Promo_Code__c,Currency__c,Item_Fee__c,Tax__c,item__r.item_type__r.Name,lastmodifieddate,Order__r.Events__r.BLN_Country__r.Currency__r.Currency_Symbol__c  From Order_Items__r ), (select id,name,Payment_Mode__c,Payment_Ref_Number__c from Payments__r),EVent_Admin_Comments__c,createdDate,Events__r.Time_Zone__c,Events__r.Name,Events__r.Start_Date__c,Events__r.Venue_Name__c,Events__r.End_Date__c,Events__c, o.Fee_Amount__c, o.Order_Total__c, o.Order_Taxes__c, o.Order_Sub_Total__c, o.Order_Status__c, o.Order_Discount__c, o.Name, o.Id, o.Currency_Code__c, o.BLN_TKT_profile__r.BLN_Company__c, BLN_TKT_profile__r.Mobile__c,o.Amount_Paid__c,BLN_TKT_profile__r.Email__c,BLN_TKT_profile__r.BLN_GN_User__r.User__r.id,BLN_TKT_profile__r.BLN_GN_User__r.user__r.userName, BLN_TKT_profile__r.TKT_Company__c,BLN_TKT_profile__r.First_Name__c,BLN_TKT_profile__r.Last_Name__c From Order__c o ' +wherecondition), 1000);
        return new Pagereference('/BLN_ReportsCheckEmail');
        }
        else
        {
        return null;
        }
        
        
        
        }
        
       
       
}