public class BLN_PromoCodeReportCon {
    public List<Reg_Setting__c> RegList{get;set;}
    public String bypromosummtype {get;set;}
    public String bypromodetailtype {get;set;}
    public String eventcurrency {get;set;}
    public String byticketsummtype {get;set;}
    public String byticketdetailtype {get;set;}
    public String promocodeSelectedType {get;set;}
    public String ticketSelectedType {get;set;}
    
    public Date psFromDate {get;set;}
    public Date psToDate {get;set;}
    public Date pdFromDate {get;set;}
    public Date pdToDate {get;set;}
    public Date tsFromDate {get;set;}
    public Date tsToDate {get;set;}
    public Date tdFromDate {get;set;}
    public Date tdToDate {get;set;}
    
    public transient LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner> promoCodeInnerList {get; set;}   
    public BLN_Event__c EventDates {get; set;} 
    public String SearchString {get; set;}
    public BLN_EventDetails eventInfo {get; set;}
    
    public string jsonDataPromoCodeDetails {get;set;}
    public string jsonDataPromoCodeSummary {get;set;}
    public string jsonDataTicketDetails {get;set;}
    public string jsonDataTicketSummary {get;set;}
    
    public transient LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner1> promoCodeInnerListbypromdetail {get; set;}
    public transient LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner12> promoCodeInnerListbyticketdetail {get; set;}
    public transient LIST<BLN_PromoCodeReportCon_BAL.promocodebyticket> promoCodeInnerListbyticket {get; set;}
    public BLN_PromoCodeReportCon_BAL balToGetPromocodes;
    
    public BLN_UtillDisplayLinks   myticket { get; set; }
    public ApexPages.StandardSetController setCon {get;set;}
    
    public String SelectedEvent {get; set;}
    public boolean isEventAdmin {get;set;}
    public boolean isBoothadmin {get;set;}
    public LIST<Promotion__c> promoProcessList{get;set;}
    public LIST<Item_Promotion__c> ItmPromoProcessList{get;set;}
     
    public BLN_PromoCodeReportCon(){
    try{
        EventDates = new BLN_Event__c();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        
        if(k!=null){ 
            selectedEvent = k.getValue();
        }
        
        ItmPromoProcessList=new LIST<Item_Promotion__c>();
        promoProcessList=new LIST<Promotion__c>();
        BLN_TicketTypeLabelCon label=new BLN_TicketTypeLabelCon();
        RegList=new List<Reg_Setting__c>();
        RegList=label.ticketTypeLabelNames(selectedEvent);
        
        bypromosummrymethod();
        bypromosummtype ='bypromosummarytab';
        byticketsummarymethod();
        byticketsummtype = 'byticketsummarytab';
        
        promocodeSelectedType = 'bypromosummarytab';
        ticketSelectedType = 'byticketsummarytab';
        
        BLN_PromoCode_BAL blneventdetail_bl = New BLN_PromoCode_BAL();
        BLN_Event__c  seventdet = new BLN_Event__c  ();
        seventdet = blneventdetail_bl.eventdetails(selectedEvent);
        eventcurrency = seventdet.BLN_Country__r.Currency__r.Currency_Symbol__c;
    }catch(exception ex){}
    }
    
    
    public void processPromoCodeSummary(){
        promoProcessList=new LIST<Promotion__c>();
        LIST<Promotion__c> promoOrderList = new LIST<Promotion__c>();
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
                
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');

        String queryString = ' T_Used_Count__c > 0 AND Event__c = \''+ selectedEvent +'\'';       
        
        if(fdate != NULL && fdate != ''){
            Date FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 

        if(tdate != NULL && tdate != ''){
            Date ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
         
        }
        promoProcessList=blnPromotionDAO.promotionslist(queryString);
        setcon = new ApexPages.StandardSetController(promoProcessList);

        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start = Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        
        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        
        setCon.setPageSize(3);
        
        Integer noOfRecords= setCon.getResultSize();
        if(size == -1){
            size = noOfRecords;
        }
        setCon.setPageSize(size);          
        
        //set pagenumber
        setCon.setPageNumber((start/size)+1);
        
        promoOrderList = setCon.getRecords();
        promoCodeInnerList = new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner>();
        balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerList = balToGetPromocodes.promotionsListForEvent(promoOrderList);                
        PromoCodeSummaryWrapper dtWrapper = new PromoCodeSummaryWrapper(0, noOfRecords, noOfRecords, promoCodeInnerList);        
        jsonDataPromoCodeSummary = JSON.serialize(dtWrapper);        
    }
    
    
    public void processPromoCodeDetails(){
        promoProcessList=new LIST<Promotion__c>();
        LIST<Promotion__c> promoOrderList = new LIST<Promotion__c>();
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
        
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');
        
        String queryString = ' T_Used_Count__c > 0 AND Event__c = \''+ selectedEvent +'\'';       
        
        if(fdate != NULL && fdate != ''){
            Date FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 

        if(tdate != NULL && tdate != ''){
            Date ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
         
        }
    
        promoProcessList=blnPromotionDAO.promotionslist(queryString);
        setcon = new ApexPages.StandardSetController(promoProcessList);
        
        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start = Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        
        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        setCon.setPageSize(3);
            
        Integer noOfRecords= setCon.getResultSize();
        if(size == -1){
            size=noOfRecords;
        }
        setCon.setPageSize(size);          
        
        //set pagenumber
        setCon.setPageNumber((start/size)+1);
        
        promoOrderList = setCon.getRecords();

        balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerListbypromdetail= new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner1>();        
        promoCodeInnerListbypromdetail = balToGetPromocodes.promotionsListForEventbypromocode(promoOrderList);
        PromoCodeDetailsWrapper dtDetailsWrapper = new PromoCodeDetailsWrapper(0, noOfRecords, noOfRecords, promoCodeInnerListbypromdetail);
        jsonDataPromoCodeDetails = JSON.serialize(dtDetailsWrapper);     
    }
    
    
    public void processTicketSummary(){
        promoProcessList=new LIST<Promotion__c>();
        LIST<Promotion__c> promoOrderList = new LIST<Promotion__c>();
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');
        
        String queryString = ' T_Used_Count__c > 0 AND Event__c = \''+ selectedEvent +'\''; 
        Date FromDate;
        Date ToDate;     
        
        if(fdate != NULL && fdate != ''){
            FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 

        if(tdate != NULL && tdate != ''){
            ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
         
        }
            
        promoProcessList=blnPromotionDAO.promotionslist(queryString);
        setcon = new ApexPages.StandardSetController(promoProcessList);
        
        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start = Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        
        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        setCon.setPageSize(3);
            
        Integer noOfRecords= setCon.getResultSize();
        if(size == -1){
            size=noOfRecords;
        }
        setCon.setPageSize(size);          
        //set pagenumber
        setCon.setPageNumber((start/size)+1);
        
        promoOrderList = setCon.getRecords();
        balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerListbyticket = new  LIST<BLN_PromoCodeReportCon_BAL.promocodebyticket>(); 
        promoCodeInnerList = new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner>();
        promoCodeInnerList = balToGetPromocodes.promotionsListForEvent(promoOrderList);
        promoCodeInnerListbyticket = balToGetPromocodes.promobyticket(selectedEvent, FromDate, ToDate, searchString, promoOrderList);
        
        TicketSummaryWrapper dtSummaryWrapper = new TicketSummaryWrapper(0, noOfRecords, noOfRecords, promoCodeInnerListbyticket);
        jsonDataTicketSummary = JSON.serialize(dtSummaryWrapper); 
            
    }
    
    
    public void processTicketDetails(){
        ItmPromoProcessList=new LIST<Item_Promotion__c>();
        LIST<Promotion__c> promoOrderList = new LIST<Promotion__c>();
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');
        
        String queryString = ' AND Promotion__r.T_Used_Count__c > 0 AND Promotion__r.Event__c = \''+ selectedEvent +'\''; 
        Date FromDate;
        Date ToDate;     
        
        if(fdate != NULL && fdate != ''){
            FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(tdate != NULL && tdate != ''){
            ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
        }
        
        ItmPromoProcessList=Database.query('SELECT id,Promotion__r.id,Promotion__r.T_Used_Count__c,Promotion__r.T_Max_Count__c,Buy_Item__r.id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Name,Promotion__r.Status__c,Promotion__r.Event__c from Item_Promotion__c WHERE Promotion__c!=null' + queryString ); 
        setcon = new ApexPages.StandardSetController(ItmPromoProcessList);
        
        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start = Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        
        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        setCon.setPageSize(3);
            
        Integer noOfRecords= setCon.getResultSize();
        if(size == -1){
            size=noOfRecords;
        }
        setCon.setPageSize(size);          
        
        //set pagenumber
        setCon.setPageNumber((start/size)+1);
        
        List<Item_Promotion__c> itemPromotions = setCon.getRecords();

        balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
        promoCodeInnerListbyticketdetail= new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner12>();        
        promoCodeInnerListbyticketdetail= balToGetPromocodes.promotionsListForEventbyticketdetail(selectedEvent,FromDate,ToDate,SearchString, itemPromotions );
        
        TicketDetailsWrapper dtDetailsWrapper = new TicketDetailsWrapper(0, noOfRecords, noOfRecords, promoCodeInnerListbyticketdetail);
        jsonDataTicketDetails = JSON.serialize(dtDetailsWrapper);     
    }
    
    //Exporting PromoCodes
    public void bypromosummrymethod(){
        bypromodetailtype = '';
        bypromosummtype=Apexpages.currentPage().getParameters().get('bypromosumm');
        promocodeSelectedType = bypromosummtype;
    }
    
    
    public void bypromodetailmethod(){
        bypromosummtype='';
        bypromodetailtype = Apexpages.currentPage().getParameters().get('bypromodetail');
        promocodeSelectedType = bypromodetailtype;
    }
    
    public void byticketsummarymethod(){
        byticketdetailtype='';
        byticketsummtype=Apexpages.currentPage().getParameters().get('bytickesumm');
        ticketSelectedType = byticketsummtype;
    }
    
    public void byticketdetailmethod(){
        byticketsummtype='';
        byticketdetailtype=Apexpages.currentPage().getParameters().get('byticketdetail');
        ticketSelectedType = byticketdetailtype;
    }


    public pageReference exportPCSummary(){
        LIST<Promotion__c> promoOrderList = new LIST<Promotion__c>();
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
        
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');

        String queryString = ' T_Used_Count__c > 0 AND Event__c = \''+ selectedEvent +'\'';       
        
        if(fdate != NULL && fdate != ''){
            Date FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 

        if(tdate != NULL && tdate != ''){
            Date ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
         
        }
        
        promoOrderList = blnPromotionDAO.promotionslist(queryString);
        if(promoOrderList.size()<1000){
        
            promoCodeInnerList = new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner>();
            balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
            promoCodeInnerList = balToGetPromocodes.promotionsListForEvent(promoOrderList); 
        }
        
        if(promoOrderList.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportPromocodeSummaryBatch('SELECT ID,Name,Promo_Code__c,Promotion_Type__c,Exp_TimeStamp__c,Eff_TimeStamp__c,Discount_Value__c,Discount_Type__c,Event__c,Exclusive__c,I_Max_Count__c,T_Max_Count__c,T_Used_Count__c,Status__c,Type__C,Condition_Min_No__c ,Condition_Max_No__c,Daily_Start_Time__c,Daily_End_Time__c,(select id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Promotion__r.Event__c  from Item_Promotions__r), (SELECT ID, Item_Discount__c, Item_Price__c, Item_Quantity__c, Item_Total__c, Order__c,Order__r.Name,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.Order_Discount__c,Promotion__r.Discount_Type__c,Item__r.item_type__r.Name,Item__r.item_name__c ,Promotion__r.Name,Status__c,Order__r.Order_Status__c FROM Order_Items__r where Order__r.Order_Status__c!=\'Abandoned\' AND Order__r.Order_Status__c!=\'Cancelled\') FROM  Promotion__c WHERE ' + queryString, eventcurrency), 1000);
            return new Pagereference('/BLN_PromocodeReportCheckEmail');
        }
           return null;  
    }

    public pageReference exportPromocodeSummary(){
        pageReference pg = page.BLN_Export_Promocode_Summary;
        pg.setRedirect(true);
        
        pg.getParameters().put('fdate',apexpages.currentpage().getparameters().get('fdate'));
        pg.getParameters().put('tdate',apexpages.currentpage().getparameters().get('tdate'));
        pg.getParameters().put('searchKey',apexpages.currentpage().getparameters().get('searchKey'));
        return pg;
    }


    public pageReference exportPCDetails(){
        LIST<Promotion__c> promoOrderList = new LIST<Promotion__c>();
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
        
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');
        
        String queryString = ' T_Used_Count__c > 0 AND Event__c = \''+ selectedEvent +'\'';       
        
        if(fdate != NULL && fdate != ''){
            Date FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 

        if(tdate != NULL && tdate != ''){
            Date ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
        }
        
        promoOrderList = blnPromotionDAO.promotionslist(queryString);
        
        if(promoOrderList.size()<1000){
            balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
            promoCodeInnerListbypromdetail= new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner1>();
            promoCodeInnerListbypromdetail = balToGetPromocodes.promotionsListForEventbypromocode(promoOrderList);
            
        }
        
        if(promoOrderList.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportPromocodeDetailsBatch('SELECT ID,Name,Promo_Code__c,Promotion_Type__c,Exp_TimeStamp__c,Eff_TimeStamp__c,Discount_Value__c,Discount_Type__c,Event__c,Exclusive__c,I_Max_Count__c,T_Max_Count__c,T_Used_Count__c,Status__c,Type__C,Condition_Min_No__c ,Condition_Max_No__c,Daily_Start_Time__c,Daily_End_Time__c,(select id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Promotion__r.Event__c  from Item_Promotions__r), (SELECT ID, Item_Discount__c, Item_Price__c, Item_Quantity__c, Item_Total__c, Order__c,Order__r.Name,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.Order_Discount__c,Promotion__r.Discount_Type__c,Item__r.item_type__r.Name,Item__r.item_name__c ,Promotion__r.Name,Status__c,Order__r.Order_Status__c FROM Order_Items__r where Order__r.Order_Status__c!=\'Abandoned\' AND Order__r.Order_Status__c!=\'Cancelled\') FROM  Promotion__c WHERE ' + queryString), 1000);
            return new Pagereference('/BLN_PromocodeReportCheckEmail');
        }
        
        return null;  
    }

    public pageReference exportPromocodeDetails(){
        pageReference pg = page.BLN_Export_Promocode_Details;
        pg.setRedirect(true);
        
        pg.getParameters().put('fdate',apexpages.currentpage().getparameters().get('fdate'));
        pg.getParameters().put('tdate',apexpages.currentpage().getparameters().get('tdate'));
        pg.getParameters().put('searchKey',apexpages.currentpage().getparameters().get('searchKey'));
        return pg;
    }
    
    
    public pageReference exportTSummary(){
        LIST<Promotion__c> promoOrderList = new LIST<Promotion__c>();
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');
        
        String queryString = ' T_Used_Count__c > 0 AND Event__c = \''+ selectedEvent +'\''; 
        Date FromDate;
        Date ToDate;     
        
        if(fdate != NULL && fdate != ''){
            FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(tdate != NULL && tdate != ''){
            ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
        }
        
        promoOrderList = blnPromotionDAO.promotionslist(queryString);
        
        if(promoOrderList.size() < 1000){
            promoCodeInnerListbyticket = new  LIST<BLN_PromoCodeReportCon_BAL.promocodebyticket>(); 
            balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
            promoCodeInnerList = balToGetPromocodes.promotionsListForEvent(promoOrderList);
            promoCodeInnerListbyticket = balToGetPromocodes.promobyticket(selectedEvent, FromDate, ToDate, searchString, promoOrderList);
        }
        
        if(promoOrderList.size()> 1000){            
            Id batchInstanceId = Database.executeBatch(new BLN_ExportTicketSummaryBatch('SELECT ID,Name,Promo_Code__c,Promotion_Type__c,Exp_TimeStamp__c,Eff_TimeStamp__c,Discount_Value__c,Discount_Type__c,Event__c,Exclusive__c,I_Max_Count__c,T_Max_Count__c,T_Used_Count__c,Status__c,Type__C,Condition_Min_No__c ,Condition_Max_No__c,Daily_Start_Time__c,Daily_End_Time__c,(select id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Promotion__r.Event__c  from Item_Promotions__r), (SELECT ID, Item_Discount__c, Item_Price__c, Item_Quantity__c, Item_Total__c, Order__c,Order__r.Name,Order__r.BLN_TKT_profile__r.First_Name__c,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.Order_Discount__c,Promotion__r.Discount_Type__c,Item__r.item_type__r.Name,Item__r.item_name__c ,Promotion__r.Name,Status__c,Order__r.Order_Status__c FROM Order_Items__r where Order__r.Order_Status__c!=\'Abandoned\' AND Order__r.Order_Status__c!=\'Cancelled\') FROM  Promotion__c WHERE ' + queryString, FromDate, ToDate, selectedEvent, searchString, eventcurrency), 1000);
            return new Pagereference('/BLN_PromocodeReportCheckEmail');
        }
        return null;  
    }


    public pageReference exportTicketSummary(){
        pageReference pg = page.BLN_Export_Ticket_Summary;
        pg.setRedirect(true);
        
        pg.getParameters().put('fdate',apexpages.currentpage().getparameters().get('fdate'));
        pg.getParameters().put('tdate',apexpages.currentpage().getparameters().get('tdate'));
        pg.getParameters().put('searchKey',apexpages.currentpage().getparameters().get('searchKey'));
        return pg;
    }
   
    public pageReference exportTDetails(){
        BLN_Promotion_DAO blnPromotionDAO = new BLN_Promotion_DAO();
        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchString = ApexPages.currentPage().getParameters().get('searchKey');
        
        String queryString = ' AND Promotion__r.T_Used_Count__c > 0 AND Promotion__r.Event__c = \''+ selectedEvent +'\''; 
        Date FromDate;
        Date ToDate;     
        
        if(fdate != NULL && fdate != ''){
            FromDate = Date.parse(fdate);
            queryString += ' AND CreatedDate >= ' + String.valueOf(FromDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(tdate != NULL && tdate != ''){
            ToDate = Date.parse(tdate);
            queryString += ' AND CreatedDate <= ' + String.valueOf(ToDate).substring(0,10)+'T00:00:00Z';
        } 
        
        if(searchString != NULL && searchString != ''){
            queryString += ' AND (Name Like \'%'+ searchString +'%\''+' OR Promo_Code__c Like \'%'+ searchString +'%\''+' OR Promotion_Type__c Like \'%'+ searchString +'%\''+' OR Discount_Type__c Like \'%'+ searchString +'%\''+')'; 
        }
        
        List<Item_Promotion__c> itemPromotions = new List<Item_Promotion__c>();
        itemPromotions = Database.query('SELECT id,Promotion__r.id,Promotion__r.T_Used_Count__c,Promotion__r.T_Max_Count__c,Buy_Item__r.id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Name,Promotion__r.Status__c,Promotion__r.Event__c from Item_Promotion__c WHERE Promotion__c!=null' + queryString );
        
        if(itemPromotions.size()<1000){
        
            balToGetPromocodes = new BLN_PromoCodeReportCon_BAL();
            promoCodeInnerListbyticketdetail= new LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner12>();        
            promoCodeInnerListbyticketdetail= balToGetPromocodes.promotionsListForEventbyticketdetail(selectedEvent,FromDate,ToDate,SearchString, itemPromotions );
        }
        
        if(itemPromotions.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportTicketDetailsBatch('SELECT id,Promotion__r.id,Promotion__r.T_Used_Count__c,Promotion__r.T_Max_Count__c,Buy_Item__r.id,Item_Discount_Type__c,Item_Discount_Value__c,Free_Item_Quantity__c,Free_Item__c,Buy_Item_Quantity__c,Buy_Item__c, Buy_Item__r.item_name__c, Buy_Item__r.price__c, Buy_Item__r.item_type__r.Name, Free_Item__r.item_name__c, Free_Item__r.item_type__r.Name, Free_Item__r.price__c,Name,Promotion__r.Status__c,Promotion__r.Event__c from Item_Promotion__c WHERE Promotion__c!=null' + queryString , FromDate, ToDate, selectedEvent, searchString), 1000);
            return new Pagereference('/BLN_PromocodeReportCheckEmail');
        }
           return null;  
    }

    public pageReference exportTicketDetails(){
        pageReference pg = page.BLN_Export_Ticket_Details;
        pg.setRedirect(true);
        
        pg.getParameters().put('fdate',apexpages.currentpage().getparameters().get('fdate'));
        pg.getParameters().put('tdate',apexpages.currentpage().getparameters().get('tdate'));
        pg.getParameters().put('searchKey',apexpages.currentpage().getparameters().get('searchKey'));
        return pg;
    }
    
  
    public PageReference hideEventsTab() {
    try{
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        
        if(k!=null){ 
            selectedEvent = k.getValue();
        }
        
        BLN_Event__c  se = new BLN_Event__c  ();
        
        try{
            se = blneventdetailbal.eventdetails(selectedEvent );
        }catch(exception e){}
        
        myticket = new BLN_UtillDisplayLinks();
        myticket.isReportsPageExpand='expand';
        myticket.isPromocodeReportPage='active';
        myticket.tablabel='PromoCode Report';
        myticket.EventId = selectedEvent;
        
        try{
            myticket.eventName=se.NAme;
        }catch(exception e){}
        myticket.userPermissions(userInfo.getUserId(),selectedEvent);
       }catch(exception ex){} 
        return null;
    }
    
    public class PromoCodeSummaryWrapper{
        public boolean selected{get; set;}
        public Integer draw;
        public Integer recordsTotal;
        public Integer recordsFiltered;
        public LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner> data;
        
        public PromoCodeSummaryWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner> data){
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered ;
            this.data = data;
        }
    }
        
    public class PromoCodeDetailsWrapper{
        public boolean selected{get; set;}
        public Integer draw;
        public Integer recordsTotal;
        public Integer recordsFiltered;
        public LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner1> data;
        
        public PromoCodeDetailsWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner1> data){
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered ;
            this.data = data;
        }
    }
    
    public class TicketSummaryWrapper{
        public boolean selected{get; set;}
        public Integer draw;
        public Integer recordsTotal;
        public Integer recordsFiltered;
        public LIST<BLN_PromoCodeReportCon_BAL.promocodebyticket> data;
        
        public TicketSummaryWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,LIST<BLN_PromoCodeReportCon_BAL.promocodebyticket> data){
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered ;
            this.data = data;
        }
    }
    
    public class TicketDetailsWrapper{
        public boolean selected{get; set;}
        public Integer draw;
        public Integer recordsTotal;
        public Integer recordsFiltered;
        public LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner12> data;
        
        public TicketDetailsWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,LIST<BLN_PromoCodeReportCon_BAL.promoCodeInner12> data){
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered ;
            this.data = data;
        }
    } 
}