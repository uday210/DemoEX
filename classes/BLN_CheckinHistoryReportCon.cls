global class BLN_CheckinHistoryReportCon{

     
     public BLN_UtillDisplayLinks   myticket { get; set; }
    
    public String SelectedEvent{get; set;}
    
    //public LIST<BLN_CheckInHistoryDetails> ticClas{get; set;}
    public transient List<BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails> ticClas{get; set;}
    public LIST<SelectOption> filterTypes{get; set;}
    public String selectedFilterType{get; set;}
    public LIST<SelectOption> paymentfilterTypes{get; set;}
    public String selectedpaymentFilterType{get; set;}
    public Boolean ShowCHForAttendee{get; set;}
    public Boolean ShowCHForTicket{get; set;}
    public LIST<BLN_CheckinCheckoutDetails> cc{get; set;}
    public BLN_CheckinHistoryReportService chrService{get;set;}
    public BLN_Event__c se {get; set;}
    
    public void checkInHistory(){
         
           if(selectedFilterType== 'Attendee'){   
                ShowCHForAttendee= TRUE;
                ShowCHForTicket= FALSE;
           }else{
                ShowCHForAttendee= FALSE;
                ShowCHForTicket= TRUE;
           }
  
    }
    
    public BLN_CheckinHistoryReportCon(){
    try{
    Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){ 
      selectedEvent = k.getValue();
       }
       ShowticketDetail=new LIST<Ticket__c> ();
      // selectedEvent ='a1954000000Cebs';
       filterTypes= new LIST<SelectOption>();
        filterTypes.add(new SelectOption('Attendee','Attendee'));
        filterTypes.add(new SelectOption('Ticket','Ticket'));
        
        selectedFilterType= 'Attendee';
        selectedTicketName= 'Ticket Name';
        
        
        selectedpaymentFilterType='Registration Type';

        checkInHistory();
        
       // statistics();
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        BLN_Event__c  se = new BLN_Event__c  ();
        try{
          se = blneventdetailbal.eventdetails(selectedEvent );
        }catch(exception e){}
        
          myticket=new BLN_UtillDisplayLinks(); 
          myticket.isSAExpand='expand';
          myticket.isSAreportExpand='expand';
          myticket.isCheckinHistoryReportPage='active';
          myticket.tablabel='Check-In History Report';
          myticket.eventName = se.Name;
          myticket.EventId = selectedEvent ;
          myticket.userPermissions(userInfo.getUserId(),selectedEvent);
          }catch(exception ex){}
          filterticketname();
          filterScannedBy();
          filterRegType();
       }
       
     public LIST<Ticket__c> ShowticketDetail{get;set;}  
     public integer inTotal{get;set;}
     public integer allTotal{get;set;}
     @RemoteAction
     public static LIST<CheckInInner> statistics(string selectedEvent){

        BLN_Ticket_DAO ticDAO =new BLN_Ticket_DAO();
        string s1='N - No Badge';
        string temp=' WHERE event__r.id = \''+selectedEvent+'\''+' AND Ticket_Status__c=\'Booked\'  ';//AND (Item_Type__r.Badgable__c !='+'\''+s1+'\' OR Item_pool__r.Item_Type__r.Badgable__c !='+'\''+s1+'\')' ;
        BLN_Event__c se = new BLN_Event__c();
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        
        try{
           se = blneventdetailbal.eventdetails(selectedEvent );
            }catch(Exception e){}
            if(se.ownerid!=userInfo.getUserId()&&se.organizer_email__c!=userInfo.getUserEmail()){
            List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:SelectedEvent and BLN_Item_Pool__c!=null];
        if(sc.size()>0)
        {
          String idInClause = '(\'';
          for(BLN_Scanusr_item__c s:sc)
          idInClause += s.BLN_Item_Pool__c + '\',\'';
          idInClause  = idInClause.substring(0,idInClause.length()-2);
          idInClause += ')';
           temp=' WHERE event__r.id = \''+selectedEvent+'\''+' AND Ticket_Status__c=\'Booked\'  and item_pool__c in'+idInClause ;
              
        }
            }
        LIST<Ticket__c> ShowticketDetail = ticDAO.userOrderAndTickets(temp);
        
        set<string> tname= new set<string>();
        
        for(ticket__c tic : ShowticketDetail){
            if(!tname.contains(tic.Item_Pool__r.Item_Pool_Name__c)){
                tname.add(tic.Item_Pool__r.Item_Pool_Name__c);
            }
        }
        LIST<CheckInInner> CheckInInnerList= new LIST<CheckInInner>();
        integer inTotal = 0;
        integer allTotal = 0;
        for(string t:tname){
            Integer checkIn= 0;
            Integer notCheckIn= 0;
            for(ticket__c tic:ShowticketDetail){//&& tic.tstatus_id__c != null
            // && tic.tstatus_id__c != null
                if(t==tic.Item_Pool__r.Item_Pool_Name__c){
                        if(tic.tstatus_id__r.Tstatus_name__c == true){
                        //system.debug('tic.Item_Pool__r.Item_Pool_Name__c'+tic+' ci '+checkIN);
                            checkIn++;
                            inTotal++;
                        }else{
                       // system.debug('tic.Item_Pool__r.Item_Pool_Name__c'+tic+' nci '+notcheckIN);
       
                        }
                        notCheckIn++;
                        allTotal++;
                }
            }
           
            CheckInInnerList.add(new CheckInInner(t, checkIn, notCheckIn));
        
        }
        return CheckInInnerList;
     }
     
     public transient LIST<CheckInInner> CheckInInnerList{get; set;}
    public class CheckInInner{
    
        public String ticName{get; set;}
        public Integer CheckInCount{get; set;}
        public Integer NotCheckInCount{get; set;}    
            
        public CheckInInner(String ticName, Integer CheckInCount, Integer NotCheckInCount){
            
            this.ticName= ticName;
            this.CheckInCount= CheckInCount;
            this.NotCheckInCount= NotCheckInCount;
            system.debug(ticName+' INNER CLASS '+CheckInCount);
        
        }
    
    } 
      
     public ApexPages.StandardSetController setCon {get;set;}
     public List<Ticket__c> RecList{get;set;}
     public string dataTableJson {get;set;} 
     public void processData(){
        dataTableJson ='';
       // selectedEvent ='a1954000000Cebs';
        String filterKey = ApexPages.currentPage().getParameters().get('filterKey');
        String searchKey = ApexPages.currentPage().getParameters().get('searchKey');
        String ticketname = ApexPages.currentPage().getParameters().get('ticketname');
        string regtype = ApexPages.currentPage().getParameters().get('regtype');
        string scannedby = ApexPages.currentPage().getParameters().get('scannedby');
        
        system.debug('scannedby'+scannedby);
        ShowticketDetail=new LIST<Ticket__c>(); 
       
        BLN_Ticket_DAO ticDAO =new BLN_Ticket_DAO();
        string s1='N - No Badge';
         
        
        string temp=' WHERE event__r.id = \''+selectedEvent+'\''+' and Tstatus_Id__r.ID != null ';//AND (Item_Type__r.Badgable__c !='+'\''+s1+'\' OR Item_pool__r.Item_Type__r.Badgable__c !='+'\''+s1+'\')' ;
         BLN_Event__c se = new BLN_Event__c();
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        
        try{
           se = blneventdetailbal.eventdetails(selectedEvent );
            }catch(Exception e){}
            if(se.ownerid!=userInfo.getUserId()&&se.organizer_email__c!=userInfo.getUserEmail()){
            List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:SelectedEvent and BLN_Item_Pool__c!=null];
        if(sc.size()>0)
        {
          String idInClause = '(\'';
          for(BLN_Scanusr_item__c s:sc)
          idInClause += s.BLN_Item_Pool__c + '\',\'';
          idInClause  = idInClause.substring(0,idInClause.length()-2);
          idInClause += ')';
           temp=' WHERE event__r.id = \''+selectedEvent+'\''+' and Tstatus_Id__r.ID != null and item_pool__c in'+idInClause ;
              
        }
            }else{
            
            }
        
        if(searchKey != '' && searchKey != null){
        temp+='AND (tkt_profile__r.First_Name__c like \'%'+searchKey+'%\' OR Tkt_profile__r.Last_Name__c like \'%'+searchKey+'%\' OR Item_Pool__r.Item_Pool_Name__c like \'%'+searchKey+'%\' OR Name like \'%'+searchKey+'%\' OR Tstatus_Id__r.Owner.Name like \'%'+searchKey+'%\' OR Tstatus_Id__r.Device_Name__c like \'%'+searchKey+'%\')';
        }

        if(ticketname != 'Ticket Name'){
        temp+=' AND (Item_Pool__r.Item_Pool_Name__c like \'%'+ticketname+'%\')';
        }

        ShowticketDetail = ticDAO.userOrderAndTickets(temp);
                    
        setcon=new ApexPages.StandardSetController(ShowticketDetail);
      
        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
    
        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        setCon.setPageSize(3);
            
        Integer noOfRecords= setCon.getResultSize();
        if(size==-1){
        size=noOfRecords;
        }
        setCon.setPageSize(size);
        
    
        //set pagenumber
        setCon.setPageNumber((start/size)+1);
        
        RecList = setCon.getRecords(); 
        
        chrService = new BLN_CheckinHistoryReportService();
        ticClas = chrService.TicketCheckInHistory(RecList,filterKey,regtype,selectedEvent,scannedby);
      system.debug('ticClas'+ticClas);
        DataTableWrapper datawrap = new DataTableWrapper(0,noOfRecords,noOfRecords,ticClas);
        dataTableJson = JSON.serialize(datawrap);
    }
    
     public class DataTableWrapper{
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
            public boolean selected{get; set;}
            public Integer draw;
            public Integer recordsTotal;
            public Integer recordsFiltered;
            //public LIST<BLN_CheckInHistoryDetails> data;
            public LIST<BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails> data;
  
            public DataTableWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,LIST<BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails> data){
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data = data;
            }
        } 
       
      public BLN_EventDetails eventInfo{get; set;}
      
      /*public PageReference printCheckinHistory() {
        BLN_Ticket_DAO ticDAO =new BLN_Ticket_DAO();
        string s1='N - No Badge';
        string temp=' WHERE event__r.id = \''+selectedEvent+'\''+' and Tstatus_Id__r.ID != null AND Item_Type__r.Badgable__c !='+'\''+s1+'\'';
        
        LIST<ticket__c> ticketDetail = new LIST<ticket__c>();
        ticketDetail = ticDAO.userOrderAndTickets(temp);
        chrService = new BLN_CheckinHistoryReportService();
        ticClas = chrService.TicketCheckInHistory(ticketDetail,selectedFilterType);
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
        eventInfo= new BLN_EventDetails();
        eventInfo.eventDetailsToDisplay(selectedEvent);
        pageReference pg =  new pagereference('/apex/BLN_printCheckinHistory');
        return pg;
      }*/
      
     /* public PageReference exportCheckinHistory() {
        return new Pagereference('/apex/BLN_exportCheckinHistory');
    }*/
     public pageReference  userSelectPerticularToExport(){
       pageReference pg = new PageReference ('/apex/BLN_exportCheckinHistory');
        
        pg.setRedirect(true);
       
        pg.getParameters().put('filter',apexpages.currentpage().getparameters().get('filter'));
        pg.getParameters().put('search',apexpages.currentpage().getparameters().get('search'));
        pg.getParameters().put('ShowCHForAttendee',apexpages.currentpage().getparameters().get('ShowCHForAttendee'));
        pg.getParameters().put('ShowCHForTicket',apexpages.currentpage().getparameters().get('ShowCHForTicket'));
        pg.getParameters().put('ticketname',apexpages.currentpage().getparameters().get('ticketname'));
        pg.getParameters().put('regtype',apexpages.currentpage().getparameters().get('regtype'));
        pg.getParameters().put('scannedby',apexpages.currentpage().getparameters().get('scannedby'));
        
        return pg; 
    } 
    
     public List<Ticket__c>  exportTickets1{get;set;}
    public pagereference exportselected(){

        String filter=apexpages.currentpage().getparameters().get('filter');
        String searchKey=apexpages.currentpage().getparameters().get('search');
        string att= apexpages.currentpage().getparameters().get('ShowCHForAttendee');
        string shtic= apexpages.currentpage().getparameters().get('ShowCHForTicket');
        string regtype = apexpages.currentpage().getparameters().get('regtype');
        string scannedby = apexpages.currentpage().getparameters().get('scannedby');
        
        if(att == 'true'){
        ShowCHForAttendee = true;
        }else{
        ShowCHForAttendee = false;
        }
        
        if(shtic == 'true'){
        ShowCHForTicket = true;
        }else{
        ShowCHForTicket = false;
        }
        
        BLN_Ticket_DAO ticDAO =new BLN_Ticket_DAO();
        string s1='N - No Badge';
        
        string temp=' WHERE event__r.id = \''+selectedEvent+'\''+' and Tstatus_Id__r.ID != null '; //AND (Item_Type__r.Badgable__c !='+'\''+s1+'\' OR Item_pool__r.Item_Type__r.Badgable__c !='+'\''+s1+'\')' ;

         BLN_Event__c se = new BLN_Event__c();
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        
        try{
           se = blneventdetailbal.eventdetails(selectedEvent );
        }catch(Exception e){}
            
        if(se.ownerid!=userInfo.getUserId()&&se.organizer_email__c!=userInfo.getUserEmail()){
            List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:SelectedEvent and BLN_Item_Pool__c!=null];
        if(sc.size()>0)
        {
          String idInClause = '(\'';
          for(BLN_Scanusr_item__c s:sc)
          idInClause += s.BLN_Item_Pool__c + '\',\'';
          idInClause  = idInClause.substring(0,idInClause.length()-2);
          idInClause += ')';
           temp=' WHERE event__r.id = \''+selectedEvent+'\''+' and Tstatus_Id__r.ID != null and item_pool__c in'+idInClause ;

        }
            }
        
        String ticketname = ApexPages.currentPage().getParameters().get('ticketname');
        system.debug('ticketname'+ticketname);
         if(ticketname != 'Ticket Name'){
        temp+=' AND (Item_Pool__r.Item_Pool_Name__c like \'%'+ticketname+'%\') ';
        }

        LIST<ticket__c> ticketDetail = new LIST<ticket__c>();
        ticketDetail = ticDAO.userOrderAndTickets(temp);
        system.debug('ticketDetail'+ticketDetail.size());
        
        /*chrService = new BLN_CheckinHistoryReportService();
        ticClas=new LIST<BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails>();
        ticClas = chrService.TicketCheckInHistory(ticketDetail,filter);*/
        
        string query='Select Event__r.Time_Zone__c,Ticket_Status__c,Badge_ID__r.Print_status__c,Tstatus_id__r.Owner.Name,tstatus_id__r.Device_Name__c,'
            +'tstatus_id__r.LastModifiedDate,Item_Type__r.Badgable__c,Item_Pool__r.Badgable__c,Item_Pool__r.Item_Pool_Name__c,'
            +'order_item__r.Item_Quantity__c,Order__r.BLN_TKT_Profile__r.Mobile__c,Order__r.BLN_TKT_Profile__c,'
            +'Order__r.BLN_TKT_Profile__r.Email__c,Order__r.BLN_TKT_Profile__r.First_Name__c,Order__r.BLN_TKT_Profile__r.Last_Name__c,'
            +'(select id,name,Tstatus_name__c,scan_time__c,Ticket__r.Item_type__r.Name,Ticket__r.tkt_profile__r.First_Name__c,Ticket__r.tkt_profile__r.Last_Name__c,LastModifiedDate,Owner.Name,'
            +'Device_Name__c  from Tstatus__r ORDER BY LastModifiedDate DESC),Tstatus_Id__r.Tstatus_name__c,Tag_No__c,'
            +'item_pool__c,badgeparentid__c,(select id,name,item__r.item_Name__c from badgeparentids__r),Tstatus_Id__c,order__r.id,item__r.item_Name__c,'
            +'Badge_Label__c,Badge_ID__c,Badge_ID__r.name,(select id,name,Badge_Label__c from badges__r where cancel_time__c=null and Exp_time__c=null limit 1),'
            +'order__r.Name,Name,Item_Type__r.Name ,Order_Item__c,event__c,Parent_ID__c,item_pool__r.item_type__r.Name,'
          
            //TKT_Profile Fields
             +'tkt_Profile__r.Age__c,tkt_Profile__r.Biography__c,tkt_Profile__r.Blogger__c,tkt_Profile__r.Blog_URL__c,tkt_Profile__r.Company_Description__c,tkt_Profile__r.Company_Logo__c,'
              +'tkt_Profile__r.Company_Website_URL__c,tkt_Profile__r.DOB__c,tkt_Profile__r.Duns_Number__c,tkt_Profile__r.Email__c,tkt_Profile__r.Established_Date__c,tkt_Profile__r.FaceBookId__c,'
              +'tkt_Profile__r.First_Name__c,tkt_Profile__r.FourSquareId__c,tkt_Profile__r.Gender__c,tkt_Profile__r.Home_Address__c,tkt_Profile__r.Home_Phone__c,tkt_Profile__r.Keywords__c,'
              +'tkt_Profile__r.Last_Name__c,tkt_Profile__r.LinkedInId__c,tkt_Profile__r.Mobile__c,tkt_Profile__r.Number_Of_Employees__c,tkt_Profile__r.Prefix__c,tkt_Profile__r.Primary_Business_Category__c,'
              +'tkt_Profile__r.Revenue__c,tkt_Profile__r.Secondary_Business_Category__c,tkt_Profile__r.Shipping_Address__c,tkt_Profile__r.Suffix__c,tkt_Profile__r.Tax_Id__c,'
              +'tkt_Profile__r.TKT_Company__c,tkt_Profile__r.TKT_Job_Title__c,tkt_Profile__r.TwitterId__c,tkt_Profile__r.User_Pic__c,tkt_Profile__r.Video__c,'
              +'tkt_Profile__r.Work_Address__c,tkt_Profile__r.Work_Phone__c,'
              //Home Address Fields
              +'tkt_Profile__r.Home_Address__r.Address1__c,tkt_Profile__r.Home_Address__r.Address2__c,tkt_Profile__r.Home_Address__r.City__c,'
              +'tkt_Profile__r.Home_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Home_Address__r.PoBox__c,tkt_Profile__r.Home_Address__r.State__r.Long_Name__c,tkt_Profile__r.Home_Address__r.ZipCode__c,'
              //Work Address Fields
              +'tkt_Profile__r.Work_Address__r.Address1__c,tkt_Profile__r.Work_Address__r.Address2__c,tkt_Profile__r.Work_Address__r.City__c,'
              +'tkt_Profile__r.Work_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Work_Address__r.PoBox__c,tkt_Profile__r.Work_Address__r.State__r.Long_Name__c,tkt_Profile__r.Work_Address__r.ZipCode__c,'
              //Shipping Address Fields
              +'tkt_Profile__r.Shipping_Address__r.Address1__c,tkt_Profile__r.Shipping_Address__r.Address2__c,tkt_Profile__r.Shipping_Address__r.City__c,'
              +'tkt_Profile__r.Shipping_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.PoBox__c,tkt_Profile__r.Shipping_Address__r.State__r.Long_Name__c,tkt_Profile__r.Shipping_Address__r.ZipCode__c,'
              //Billing Address Fields
              +'tkt_Profile__r.Billing_Address__r.Address1__c,tkt_Profile__r.Billing_Address__r.Address2__c,tkt_Profile__r.Billing_Address__r.City__c,'
              +'tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c,tkt_profile__r.BLN_GN_User__c'
            
            +'  From Ticket__c t '+temp;
        
        BLN_Event__c eve =[select time_zone__c from BLN_Event__c where id =:selectedEvent];
        
        if(ticketDetail.size()>400){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportCheckins (query,filter,eve.time_zone__c,regtype,selectedEvent,scannedby), 1000);
            return new Pagereference('/BLN_CheckinReportCheckEmail');
        }
        
        else {
        chrService = new BLN_CheckinHistoryReportService();
        ticClas=new LIST<BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails>();
        ticClas = chrService.TicketCheckInHistory(ticketDetail,filter,regtype,selectedEvent,scannedby);
            return null;
      }
      
    }
   
    public LIST<SelectOption> Ticketnamefilter{get; set;}
    public String selectedTicketName{get; set;}
    
    public list<SelectOption> filterticketname(){
          set<string> ticset = new set<string>();
          list<Ticket__c> ticlis = new list<Ticket__c>();
          string temp='';
          BLN_Event__c se = new BLN_Event__c();
            BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
            
            try{
               se = blneventdetailbal.eventdetails(selectedEvent );
            }catch(Exception e){}
          if(se.ownerid!=userInfo.getUserId()&&se.organizer_email__c!=userInfo.getUserEmail()){
            List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:SelectedEvent and BLN_Item_Pool__c!=null];
            if(sc.size()>0)
            {
              String idInClause = '(\'';
              for(BLN_Scanusr_item__c s:sc)
              idInClause += s.BLN_Item_Pool__c + '\',\'';
              idInClause  = idInClause.substring(0,idInClause.length()-2);
              idInClause += ')';
               temp=' and item_pool__c in'+idInClause ;
    
            }
            }
          ticlis = database.query('select id,item_pool__c,name,Item_Pool__r.Item_Pool_Name__c from Ticket__c where Event__c =\''+selectedEvent+'\' AND Tstatus_Id__c!= null AND Ticket_Status__c = \'Booked\' '+temp);
          for(Ticket__c tic : ticlis){
              ticset.add(tic.Item_Pool__r.Item_Pool_Name__c);
          }
          Ticketnamefilter = new list<SelectOption>();
          Ticketnamefilter.add(new SelectOption('Ticket Name','Ticket Name'));
            for(string tc: ticset)
            {
               Ticketnamefilter.add(new SelectOption(tc,tc));
            }
            
            return Ticketnamefilter;
    }
   
    public LIST<SelectOption> ScannedByfilter{get; set;}
    public String selectedScannedBy{get; set;}
    
    public list<SelectOption> filterScannedBy(){
          set<string> ScannedByset = new set<string>();
          list<Ticket__c> ticlis = new list<Ticket__c>();
          ScannedByfilter = new list<SelectOption>();
          ScannedByfilter.add(new SelectOption('','ScannedBy'));
          string temp='';
          BLN_Event__c se = new BLN_Event__c();
            BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
            
            try{
               se = blneventdetailbal.eventdetails(selectedEvent );
            }catch(Exception e){}
          if(se.ownerid!=userInfo.getUserId()&&se.organizer_email__c!=userInfo.getUserEmail()){
            List<BLN_Scanusr_item__c > sc=[select id,name,BLN_GN_User__c,BLN_GN_User__r.User__r.email,BLN_Event__c,BLN_Item_Pool__c from BLN_Scanusr_item__c where BLN_GN_User__r.User__r.email=:UserInfo.getUserEmail() and BLN_Event__c=:SelectedEvent and BLN_Item_Pool__c!=null];
            if(sc.size()>0)
            {
              String idInClause = '(\'';
              for(BLN_Scanusr_item__c s:sc)
              idInClause += s.BLN_Item_Pool__c + '\',\'';
              idInClause  = idInClause.substring(0,idInClause.length()-2);
              idInClause += ')';
               temp=' and item_pool__c in'+idInClause ;
    
            }
            }
      ticlis = database.query('select id,item_pool__c,name,(select Owner.Name,Owner.ID from tstatus__r),Tstatus_Id__r.Owner.Name from Ticket__c where Event__c =\''+selectedEvent+'\' AND Tstatus_Id__c!= null AND Ticket_Status__c = \'Booked\''+temp);
          for(Ticket__c tic : ticlis){
          for(tstatus__c ts:tic.tstatus__r){
          if(!ScannedByset.contains(ts.Owner.Name)){
          ScannedByset.add(ts.Owner.Name);
          ScannedByfilter.add(new SelectOption(ts.Owner.ID,ts.Owner.Name));
          }
              }
          }
          
           
            return ScannedByfilter;
    }
   
    public list<SelectOption> filterRegType(){
          set<string> RegTypeset = new set<string>();
          //list<Payment__c> paylis = new list<Payment__c>();
          list<AggregateResult> paylis = new list<AggregateResult>();
          paymentfilterTypes= new LIST<SelectOption>();
        paymentfilterTypes.add(new SelectOption('Registration Type','Registration Type'));

          /*paylis = [select id,Registration_Type__c from Payment__c where order__r.Events__c =:selectedEvent AND order__r.Order_Status__c != 'Cancelled' AND order__r.Order_Status__c != 'Abandoned'];
          for(Payment__c pay : paylis){
              if(!RegTypeset.contains(pay.Registration_Type__c)){
              RegTypeset.add(pay.Registration_Type__c);
              if(pay.Registration_Type__c != 'Mobile')
              paymentfilterTypes.add(new SelectOption(pay.Registration_Type__c,pay.Registration_Type__c));
              if(pay.Registration_Type__c == 'Mobile')
              paymentfilterTypes.add(new SelectOption(pay.Registration_Type__c,'Scan Attendee'));
              }
          }*/
          
          paylis=[select Registration_Type__c reg from Payment__c where order__r.Events__c =:selectedEvent AND order__r.Order_Status__c != 'Cancelled' AND order__r.Order_Status__c != 'Abandoned' group by Registration_Type__c];
          for(AggregateResult pay : paylis){
              //if(!RegTypeset.contains(pay.Registration_Type__c)){
             // RegTypeset.add(pay.Registration_Type__c);
              if(string.valueof(pay.get('reg')) != 'Mobile')
              paymentfilterTypes.add(new SelectOption(string.valueof(pay.get('reg')),string.valueof(pay.get('reg'))));
              if(string.valueof(pay.get('reg')) == 'Mobile')
              paymentfilterTypes.add(new SelectOption(string.valueof(pay.get('reg')),'Scan Attendee'));
             // }
          }
          
           
            return paymentfilterTypes;
    }
   
   }