/***********************************************************************************************
*   Controller Name : BLN_TicketSalesReportCon
*   Date            : 10/30/2014
*   Author          : Manasa Gandham
*   Purpose         : This class is to display the Ticket Sales Report
*   Change History  : 10/28/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  10/30/2014            Manasa Gandham                  To Create Page
*  16 Jul 2015           Vineel Ragula                   To Create new Tab for "Ticket Details Report"   
  
**************************************************************************************************/

public with sharing class BLN_TicketSalesReportCon { 
public List<Reg_Setting__c> RegList{get;set;}
Public String currencySymbol{get;set;}
public BLN_Event__c EventDates{get; set;}
public BLN_Event__c EventDates1{get; set;}
public BLN_Event__c se{get;set;}
public String selectedEvent {get; set;}
public BLN_TicketSalesReportCon_BAL balToGetTickets{get; set;}
//public BLN_TicketSalesReportCon_BAL balToGetDetailTickets{get; set;}
public Transient LIST<BLN_TicketSalesReportCon_BAL.Item> TicketsInnerList{get; set;}
//public LIST<BLN_TicketSalesReportCon_BAL.ticketSalesInner> TicketsdetailInnerList{get; set;}
public String SearchString{get; set;}
public Transient List<Ticket__c> ShowticketDetail{get;set;}// For Ticket Detail Report By Vineel
public BLN_Ticket_DAO ticketdaodetail{get;set;} // For Ticket Detail Report By Vineel
public  BLN_Event__c  seventdet{get;set;}
public Date stdates{get;set;}
public Date eddates{get;set;}
public date edte{get;set;}
public date sdte{get;set;}
public date edte1{get;set;}
public date sdte1{get;set;}
public date edtesm{get;set;}
public date sdtesm{get;set;}
public list<String> TicketNameset{get;set;}
public list<Item_Type__c> TTypeList{get;set;}
public List<ticket__c> TList{get;set;}




    public BLN_TicketSalesReportCon(){
    try{
    totalTiclist=new List<BLN_Item__c>();
        ShowticketDetail=new List<Ticket__c>();
        EventDates= new BLN_Event__c();
       EventDates1= new BLN_Event__c();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
            system.debug('aaaaaaaaaaaaaaa'+k);
        if(k!=null){ 
            selectedEvent= k.getValue();
            System.debug('selectedEvent '+selectedEvent );
            
            
            BLN_PromoCode_BAL blneventdetail_bl = New BLN_PromoCode_BAL();
           seventdet = new BLN_Event__c  ();
             seventdet = blneventdetail_bl.eventdetails(selectedEvent);
           //  EventDates= blneventdetail_bl.eventdetails(selectedEvent);
             currencySymbol = seventdet.BLN_Country__r.Currency__r.Currency_Symbol__c;
            
     displayTicketSalesReport();
           // ShowDetailsReport();// For Ticket Detail Report By Vineel
           
        }  
        BLN_TicketTypeLabelCon label=new BLN_TicketTypeLabelCon();
        RegList=new List<Reg_Setting__c>();
        RegList=label.ticketTypeLabelNames(selectedEvent);
        
        }catch(exception ex){}
    }
      
       
     
    
        
      public Pagereference displayTicketSalesReport(){
       /* balToGetTickets= new BLN_TicketSalesReportCon_BAL();
        TicketsInnerList= new LIST<BLN_TicketSalesReportCon_BAL.Item>();
        datetime enddate;
       if(edte!=null){
        //edte1=Date.newInstance(edte.year(),edte.month(),edte.day());
        edte1=date.valueof(edte);
        }
        if(sdte!=null){
        //sdte1=Date.newInstance(sdte.year(),sdte.month(),sdte.day());
        sdte1=date.valueof(sdte);
        }
       
        
        if(edte1 != null){
        
        enddate=edte1.addDays(1);
        }
        //TicketsInnerList= balToGetTickets.ticketsSalesForEvent(selectedEvent, sdte1, enddate);
        TicketsInnerList= balToGetTickets.getTicketSalesReport([select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent]);
        */
        return null;
    }
    
    
     // Exporting PromoCodes
    public pageReference exportTicketSales(){
    system.debug('bbbbbbbbbbbbbb');
        //displayTicketSalesReport();
        balToGetTickets= new BLN_TicketSalesReportCon_BAL();
        TicketsInnerList= new LIST<BLN_TicketSalesReportCon_BAL.Item>();
         String fdate1=    ApexPages.currentPage().getParameters().get('fromdate1');
        String tdate1=    ApexPages.currentPage().getParameters().get('todate1');
        String searchKey1 = ApexPages.currentPage().getParameters().get('search1');
        
        
        if(fdate1!=null&&fdate1!=''&&tdate1!=null&&tdate1!=''){
            Date FromDate1=Date.parse(fdate1);
            Date ToDate1=Date.parse(tdate1);
            ToDate1 = ToDate1.adddays(1);
            TicketsInnerList= balToGetTickets.getTicketSalesReport([select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent and (item_name__c LIKE : '%'+searchKey1+'%' or item_type__r.name LIKE : '%'+searchKey1+'%') AND CreatedDate >=: FromDate1 AND CreatedDate <=: ToDate1]);
       }else if(searchKey1 != null && searchKey1 != '')
       {
           system.debug('aaaaaaaaaasearchKey1  '+searchKey1);
           TicketsInnerList= balToGetTickets.getTicketSalesReport([select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent and (item_name__c LIKE : '%'+searchKey1+'%' or item_type__r.name LIKE : '%'+searchKey1+'%')]);
       }else{
            TicketsInnerList= balToGetTickets.getTicketSalesReport([select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent]);
       }
        pageReference pg = page.BLN_ExportTicketSales;
        pg.setRedirect(true);
       
        pg.getParameters().put('fromdate1',apexpages.currentpage().getparameters().get('fromdate1'));
        pg.getParameters().put('todate1',apexpages.currentpage().getparameters().get('todate1'));
        pg.getParameters().put('search1',apexpages.currentpage().getparameters().get('search1'));
        return pg;
        }
        
    public pagereference exportTicketSalesBatch(){
        balToGetTickets= new BLN_TicketSalesReportCon_BAL();
        LIST<BLN_TicketSalesReportCon_BAL.Item> TicketsInnerList= new LIST<BLN_TicketSalesReportCon_BAL.Item>();
        TicketsInnerList= balToGetTickets.getTicketSalesReport([select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent]);
       
        if(TicketsInnerList.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportTicketSalesBatch ('select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=\''+selectedEvent+'\'',currencySymbol), 1000);
            return new Pagereference('/BLN_TicketReportCheckEmail');
        }else{
            exportTicketSales();
            return null;
        }
    
    }
    
    public BLN_EventDetails eventInfo{get; set;}
    public PageReference printTicketSales() {
        
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
        eventInfo= new BLN_EventDetails();
        eventInfo.eventDetailsToDisplay(selectedEvent);
        
        displayTicketSalesReport();
        pageReference pg = page.BLN_PrintTicketSales;
        return pg;
    }


    public PageReference exportTotalTicketSales() {
        showtotalsales();
        pageReference pg = page.BLN_exportTotalTicketSales;
        return pg;
    }

    //Print Ticket Detail Report - Vineel 
    public PageReference BLN_printdetailsTicketSales() {
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
        eventInfo= new BLN_EventDetails();
        eventInfo.eventDetailsToDisplay(selectedEvent);
        
        displayTicketSalesReport();
        pageReference pg = page.BLN_printdetailsTicketSales;
        return pg;
    }

    
    public LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner> promoCodeInnerList{get; set;}
    
    
    public BLN_UtillDisplayLinks   myticket { get; set; }
    

    public boolean isEventAdmin{get;set;}
    public boolean isBoothadmin{get;set;}

    public PageReference hideEventsTab() {
    try{
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){ 
      selectedEvent = k.getValue();
       }
   
     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     se = new BLN_Event__c();
      try{
    se = blneventdetailbal.eventdetails(selectedEvent );
     }catch(exception e){}
      
     myticket = new BLN_UtillDisplayLinks();


    myticket.isReportsPageExpand='expand';
    myticket.isTicketReportPage='active';
    myticket.tablabel='Ticket Sales Report';
    myticket.EventId = selectedEvent ;
    
   try{
     myticket.eventName=se.NAme;
    }catch(exception e){}
     myticket.userPermissions(userInfo.getUserId(),selectedEvent);
     }catch(exception ex){}
        return null;
    }
    public ApexPages.StandardSetController setCon {get;set;}
    public List<BLN_Item__c> RecList{get;set;}
     public string dataTableJson {get;set;}
     public list<BLN_Item__c> totalTiclist{get;set;}
public void processData(){
        totalTiclist =new list<BLN_Item__c>(); 
        String searchKey1 = ApexPages.currentPage().getParameters().get('searchKey1');
        if(searchKey1 == '' || searchKey1 ==null){
          totalTiclist=[select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent];
          setcon=new ApexPages.StandardSetController(totalTiclist);
        }else{
            totalTiclist=[select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent and (item_name__c LIKE : '%'+searchKey1+'%' or item_type__r.name LIKE : '%'+searchKey1+'%')];
            setcon=new ApexPages.StandardSetController(totalTiclist);
        }
          
          
                    
           
             //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            System.debug('start value: '+start);
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            System.debug('size value : '+size);
            setCon.setPageSize(5);
            
        Integer noOfRecords= setCon.getResultSize();
            if(size==-1){
            size=noOfRecords;
            }
            setCon.setPageSize(size);
            
        
            //set pagenumber
            setCon.setPageNumber((start/size)+1);
                  
           
            
            RecList = setCon.getRecords();  
            
       BLN_TicketSalesReportCon_BAL rpconbal=new BLN_TicketSalesReportCon_BAL();
      LIST<BLN_TicketSalesReportCon_BAL.Item> TicketsInnerListtemp=new LIST<BLN_TicketSalesReportCon_BAL.Item>();
      TicketsInnerListtemp=rpconbal.getTicketSalesReport(RecList);
            DataTableWrapper datawrap = new DataTableWrapper(0,noOfRecords,noOfRecords,TicketsInnerListtemp);
            
            dataTableJson = JSON.serialize(datawrap);
            

}


public ApexPages.StandardSetController setCon1 {get;set;}
    public List<Ticket__c> RecList1{get;set;}
     public string dataTableJson1 {get;set;}
     
    public void processData1(){
        ticketdaodetail = new BLN_Ticket_DAO();
        
        String fdate=    ApexPages.currentPage().getParameters().get('fdate');
        String tdate=    ApexPages.currentPage().getParameters().get('tdate');
        String searchKey = ApexPages.currentPage().getParameters().get('searchValue');

            String fil1 =    ApexPages.currentPage().getParameters().get('tktName');
            String fil2 =    ApexPages.currentPage().getParameters().get('tktType');
            String fil3 =    ApexPages.currentPage().getParameters().get('tktStatus');
            String fil4 =    ApexPages.currentPage().getParameters().get('tktbadge');
            system.debug('@@@fil4 '+fil4 );
            string subwhere;
            if(fil1 != null)
            {
            subwhere='And (';
            fil1 = fil1.replace('(',',');
            fil1 = fil1.replace(')',',');
             list<String> tok4 = fil1.split(',');
             
             for(integer i=1;i<tok4.size();i++){
                       subwhere+= 'Item_Pool__r.Item_Pool_Name__c like \'%'+tok4[i-1]+'%\' ';  //append to base Query
                    
                    subwhere+=' or ';
                    }
                     subwhere+='Item_Pool__r.Item_Pool_Name__c like \'%'+tok4[tok4.size()-1]+'%\' )';
                     
            }
            
            if(fil2 != null)
            {
            subwhere+='And (';
             list<String> tok6 = fil2.split(',');
             for(integer i=1;i<tok6.size();i++){
                       subwhere+= 'Item_Pool__r.Item_Type__r.Name like \'%'+tok6[i-1]+'%\' ';  //append to base Query
                    
                    subwhere+=' or ';
                    }
                     subwhere+='Item_Pool__r.Item_Type__r.Name like \'%'+tok6[tok6.size()-1]+'%\' )';
            }
            
            
               if(fil3 != null)
            {
            subwhere+='And (';
             list<String> tok5 = fil3.split(',');
             for(integer i=1;i<tok5.size();i++){
                       subwhere+= 'Ticket_Status__c like \'%'+tok5[i-1]+'%\' ';  //append to base Query
                    
                    subwhere+=' or ';
                    }
                    subwhere+='Ticket_Status__c like \'%'+tok5[tok5.size()-1]+'%\' )';
            }
            
          if(fil4 != null)
            {
            subwhere+='And (';
             list<String> tok7 = fil4.split(',');
             for(integer i=1;i<tok7.size();i++){
                       subwhere+= 'Item_Pool__r.Badgable__c like \'%'+tok7[i-1]+'%\' ';  //append to base Query
                    
                    subwhere+=' or ';
                    }
                     subwhere+='Item_Pool__r.Badgable__c like \'%'+tok7[tok7.size()-1]+'%\' )';
            }
            System.debug('vvvvvvvvvvv '+fil1);
            System.debug('vvvvvvvvvvv1 '+fil3);
            System.debug('vvvvvvvvvvv2 '+fil2);
             System.debug('wwwwwwwwwwwwwwwxxxxxx '+subwhere);

        if(fdate!=null && fdate!='' && tdate!=null && tdate!='' && searchKey != null && searchKey != ''){
            Date FromDate=Date.parse(fdate);
            Date ToDate=Date.parse(tdate);
          //  ToDate = ToDate.AddDays(1); 
            ShowticketDetail = ticketdaodetail.getTicketdetails(selectedEvent,FromDate, ToDate,searchKey,subwhere);
       }else if(fdate!=null&&fdate!=''&&tdate!=null&&tdate!=''){
            Date FromDate=Date.parse(fdate);
            Date ToDate=Date.parse(tdate);
          //  ToDate = ToDate.AddDays(1); 
            ShowticketDetail = ticketdaodetail.getTicketdetails(selectedEvent,FromDate, ToDate,searchKey,subwhere);
       }else if(searchKey != null && searchKey != '')
       {
       //system.debug('searchKey'+searchKey);
           ShowticketDetail = ticketdaodetail.getTicketdetails(selectedEvent,null, null,searchKey,subwhere);
       }else{
            ShowticketDetail = ticketdaodetail.getTicketdetails(selectedEvent,null, null,'',subwhere);
       }

                    
      setcon1=new ApexPages.StandardSetController(ShowticketDetail);
      
      //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            System.debug('start value: '+start);
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            System.debug('size value : '+size);
            setCon1.setPageSize(3);
            
        Integer noOfRecords= setCon1.getResultSize();
            if(size==-1){
            size=noOfRecords;
            }
            setCon1.setPageSize(size);
            
        
            //set pagenumber
            try{
            setCon1.setPageNumber((start/size)+1);
            }catch(exception e){}
            RecList1 = setCon1.getRecords(); 
            
            
            List<SubWrapper1> TicketList1 = new List<SubWrapper1>();
            
            // create a sub wrapper
      for(Ticket__c ac: RecList1){
          Id val=ac.id;
          TicketList1.add(new SubWrapper1(ac, val));
      }
      
      DataTableWrapper1 datawrap = new DataTableWrapper1(0,noOfRecords,noOfRecords,TicketList1);
            
            dataTableJson1 = JSON.serialize(datawrap);
    }

 /***********************sub wrapper****/
// inner class
  
public class DataTableWrapper{
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public LIST<BLN_TicketSalesReportCon_BAL.Item> data{get;set;}
            public DataTableWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,list<BLN_TicketSalesReportCon_BAL.Item> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data= data;
              
            }
         
        } 
        
    public class SubWrapper1{

  public Id DT_RowId{ get; set; }
  public Ticket__c item { get; set;}
  public String createdon{get;set;}
  

  public SubWrapper1(Ticket__c item, Id counter) {
    this.item = item;
    this.DT_RowId= counter;
    BLN_timeConToEvzoneCon tz=new BLN_timeConToEvzoneCon();
    tz.tZone=item.Event__r.Time_Zone__c;
    tz.format='MM/dd/yyyy hh:mm a';
    tz.dateTimeValue=item.Order__r.createddate;
    this.createdon=tz.getTimeZoneValue();
   
  }  
  }
  
public class DataTableWrapper1{
    //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
            public boolean selected{get; set;}
            public Integer draw;
            public Integer recordsTotal;
            public Integer recordsFiltered;
            public List<SubWrapper1> data;
        public DataTableWrapper1(Integer draw,Integer recordsTotal,Integer recordsFiltered,list<SubWrapper1> data)
        {
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered ;
            this.data = data;
          
        }
     
    } 
    
    
    // export only Selected orders
    public pageReference  userSelectPerticularToExport(){
       pageReference pg = new PageReference ('/apex/BLN_TicketExportNew');
        
        pg.setRedirect(true);
       
        pg.getParameters().put('fromdate',apexpages.currentpage().getparameters().get('fromdate'));
        pg.getParameters().put('todate',apexpages.currentpage().getparameters().get('todate'));
        
        pg.getParameters().put('search',apexpages.currentpage().getparameters().get('search'));
        pg.getParameters().put('tktName',apexpages.currentpage().getparameters().get('tktName'));
        pg.getParameters().put('tktType',apexpages.currentpage().getparameters().get('tktType'));
        pg.getParameters().put('tktStatus',apexpages.currentpage().getparameters().get('tktStatus'));
        pg.getParameters().put('tktbadge',apexpages.currentpage().getparameters().get('tktbadge'));
        return pg; 
    } 
    
    public List<Ticket__c>  exportTickets1{get;set;}
    public pagereference exportselected(){
        ticketdaodetail = new BLN_Ticket_DAO();
        
        String fdate=apexpages.currentpage().getparameters().get('fromdate');
        String tdate=apexpages.currentpage().getparameters().get('todate');
        String searchKey=apexpages.currentpage().getparameters().get('search');

         Date FromDate=null;
         Date ToDate=null;
        
         String fil1 =    ApexPages.currentPage().getParameters().get('tktName');
            String fil2 =    ApexPages.currentPage().getParameters().get('tktType');
            String fil3 =    ApexPages.currentPage().getParameters().get('tktStatus');
            String fil4 =    ApexPages.currentPage().getParameters().get('tktbadge');
            string subwhere;
            system.debug('tktName'+fil1);
            system.debug('tkttype'+fil2);
            system.debug('tktstatus'+fil3);
            if(fil1 != null)
            {
            subwhere='And (';
            fil1 = fil1.replace('(',',');
            fil1 = fil1.replace(')',',');
             list<String> tok4 = fil1.split(',');
             
             for(integer i=1;i<tok4.size();i++){
                       subwhere+= 'Item_Pool__r.Item_Pool_Name__c like \'%'+tok4[i-1]+'%\' ';  //append to base Query
                    
                    subwhere+=' or ';
                    }
                     subwhere+='Item_Pool__r.Item_Pool_Name__c like \'%'+tok4[tok4.size()-1]+'%\' )';
                     system.debug('subwhere  '+subwhere);
                     
            }
            
            if(fil2 != null)
            {
            subwhere+='And (';
             list<String> tok6 = fil2.split(',');
             for(integer i=1;i<tok6.size();i++){
                       subwhere+= 'Item_Pool__r.Item_Type__r.Name like \'%'+tok6[i-1]+'%\' ';  //append to base Query
                    
                    subwhere+=' or ';
                    }
                     subwhere+='Item_Pool__r.Item_Type__r.Name like \'%'+tok6[tok6.size()-1]+'%\' )';
                     system.debug('subwhere1  '+subwhere);
            }
            
            
               if(fil3 != null)
            {
            subwhere+='And (';
             list<String> tok5 = fil3.split(',');
             for(integer i=1;i<tok5.size();i++){
                       subwhere+= 'Ticket_Status__c like \'%'+tok5[i-1]+'%\' ';  //append to base Query
                    
                    subwhere+=' or ';
                    }
                    subwhere+='Ticket_Status__c like \'%'+tok5[tok5.size()-1]+'%\' )';
                    system.debug('subwhere2  '+subwhere);
            }
             if(fil4 != null)
            {
            subwhere+='And (';
             list<String> tok7 = fil4.split(',');
             for(integer i=1;i<tok7.size();i++){
                       subwhere+= 'Item_Pool__r.Badgable__c like \'%'+tok7[i-1]+'%\' ';  //append to base Query
            
                    subwhere+=' or ';
                    }
                    subwhere+='Item_Pool__r.Badgable__c like \'%'+tok7[tok7.size()-1]+'%\' )';
                    system.debug('subwhere2  '+subwhere);
            }
        
        string wherecondition='';
        if(fdate!=null&&fdate!=''&&tdate!=null&&tdate!=''){
            FromDate=Date.parse(fdate);
            ToDate=Date.parse(tdate);
            //ToDate = ToDate.adddays(1);
            wherecondition+=' and Order__r.CreatedDate >= '+String.valueOf(FromDate).substring(0,10)+'T00:00:00Z  AND  Order__r.CreatedDate <= '+String.valueOf(ToDate).substring(0,10)+'T23:59:59Z';
        }
         
        exportTickets1 = new List<Ticket__c>();
        
        
        if(subwhere!=''){
        
        exportTickets1 = ticketdaodetail.getTicketdetails(selectedEvent,FromDate, ToDate,searchKey,subwhere);
        }else{
        exportTickets1 = ticketdaodetail.getTicketdetails(selectedEvent,FromDate, ToDate,searchKey,'');
        }

        if(exportTickets1.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportTickets ('select Name,Event__r.Time_Zone__c,Item_Pool__r.Item_Pool_Name__c,Item_Type__r.Name,Item__r.Item_Pool__r.Item_Pool_Name__c,Order__r.Name,Item_Pool__r.Item_Type__r.Name,tkt_profile__r.First_Name__c,tkt_profile__r.Last_Name__c,tkt_profile__r.Email__c,tkt_profile__r.TKT_Job_Title__c,tkt_profile__r.TKT_Company__c,Ticket_Status__c,Order__r.createddate from Ticket__c WHERE Event__c =\''+selectedEvent+'\' AND (Ticket_Status__c != \'Available\' AND Ticket_Status__c != \'Deleted\' AND Ticket_Status__c != \'Abandoned\' AND Ticket_Status__c != \'Reserved\') AND (Item_Type__r.Name !=\'Package\' OR (Item_Type__r.Name =\'Package\' AND Parent_ID__c!=null)) '+wherecondition +' ORDER BY Order__r.CreatedDate DESC'), 1000);
            return new Pagereference('/BLN_TicketReportCheckEmail');
        }else{
            return null;
        }
        
        
        
        }
        
    
    public transient List<BLN_TicketSalesReportCon_BAL.PaymentClass> mainlistpayment{get;set;}
        public PageReference showtotalsales()
        {
        
        mainlistpayment=new List<BLN_TicketSalesReportCon_BAL.PaymentClass>();
        // create a sub wrapper
       BLN_TicketSalesReportCon_BAL rpconbal=new BLN_TicketSalesReportCon_BAL();
      LIST<BLN_TicketSalesReportCon_BAL.Item> TicketsInnerListtemp=new LIST<BLN_TicketSalesReportCon_BAL.Item>();
      TicketsInnerListtemp=rpconbal.getTicketSalesReport([select id,name,item_type__c,item_type__r.name,Available_Tickets__c,price__c,item_count__c,item_name__c,Event__c,Item_Pool__c,Item_Pool__r.Package_Flag__c from BLN_Item__c where Event__c=:selectedEvent]);
      Map<String,BLN_TicketSalesReportCon_BAL.PaymentClass> mainmap=new Map<String,BLN_TicketSalesReportCon_BAL.PaymentClass>();
      
      for(BLN_TicketSalesReportCon_BAL.Item it:TicketsInnerListtemp)
      {
         try{
         for(BLN_TicketSalesReportCon_BAL.PaymentClass pc:it.Payment)
         {
            if(mainmap.containskey(pc.PaymentType))
            {
              BLN_TicketSalesReportCon_BAL.PaymentClass temp=new BLN_TicketSalesReportCon_BAL.PaymentClass();
              temp=mainmap.get(pc.PaymentType);
              temp.Tax+=pc.Tax;
               temp.Quantity+=pc.Quantity;
                temp.Fee+=pc.Fee;
                 temp.Discount+=pc.Discount;
                 temp.Amount+=pc.Amount;
                 temp.Price+=pc.Price;
                 mainmap.put(pc.PaymentType,temp);
            }
          else
           {
            mainmap.put(pc.PaymentType,pc);
            }
         }
         }catch(Exception e){}
      }
      
     mainlistpayment=mainmap.values(); 
           return null;
        }
        
 public List<filterclass> TTFilterList{get;set;}       
        @RemoteAction
    public static List<filterclass> getTicketTypesForFilter(String eventid){
        set<id> itmSet=new set<id>();
        List<filterclass>  TTFilterList=new List<filterclass>();
        
        List<Item_pool__c> IPlist = new List<Item_pool__c>();
       // List<ticket__c>  TList=new List<ticket__c>();
        List<ticket__c>  TList=new List<ticket__c>();
         TList=[select id,name,item_pool__r.item_type__r.name,item_pool__r.item_type__c,item_pool__r.item_pool_name__c,item_pool__c from Ticket__c where event__c= : eventid AND (Item_Type__r.Name !='Package' OR (Item_Type__r.Name ='Package' AND Parent_ID__c!=null))];
         // IPlist = [select id, name,Item_Pool_Name__c from Item_pool__c where event__c= : eventid  ];   
            for(ticket__c t :TList){
                itmSet.add(t.item_pool__r.item_type__c);
                
            } 
            List<Item_Type__c> TTypeList=new List<Item_Type__c>();
            TTypeList = [select id,name from Item_Type__c where id in : itmSet ];
           IPlist = [select id, name,Item_Pool_Name__c,Addon_Count__c,Addon_Parent__r.Item_Pool_Name__c from Item_pool__c where event__c= : eventid and Item_Type__c in :itmSet ];
            TTFilterList.add(new filterclass(IPlist ,TTypeList));
        return TTFilterList;
    }
    
    public class filterclass{
        
        public List<Item_pool__c> getTicketNamesForFilter{get;set;}
        public list<item_type__c> ticketTypeFilterList{get;set;}
        public filterclass(List<Item_pool__c> getTicketNamesForFilter1,list<item_type__c> ticketTypeFilterList1){
        
            this.getTicketNamesForFilter=getTicketNamesForFilter1;
            this.ticketTypeFilterList=ticketTypeFilterList1;
        }
    }
 public List<Item_pool__c> TNList {get;set;}   
    
        
    }