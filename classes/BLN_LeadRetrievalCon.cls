public class BLN_LeadRetrievalCon {

    public String followupdate { get; set; }
    public boolean isdelete{get;set;}
    public Boolean editPopUp { get; set; }
    public Boolean displayPopup {get;set;}
    Public string selectedeventid{get;set;}
    public Lead_Scan__c showlead{get;set;}
    public Lead_Scan__c leadeditlist{get;set;}
    public Device_Usage__c devicelist{get;set;}
    public Blob leadPic{ get; set; }
    public String leadImageName{get; set;}
    public BLN_UtillDisplayLinks LeadRetrieval{ get; set; }
    public transient  BLN_Device_Usage_DAO deviceusage{get;set;}
    public boolean diaplayLogin{get;set;}
    public transient  LIST<User_Answer__c> anslist;
    public List<String> listOfintegers1{get;set;}
    public integer selectedRating{get;set;}
    public transient  BLN_Company_Ext_DAO compExtDAO{get;set;}
    public transient list<BLN_LeadRetrieval_BAL.qaclass> qacls{get;set;}
    public list<BLN_LeadRetrieval_BAL.editqaclass> editqacls{get;set;}
    public list<BLN_LeadRetrieval_BAL.leaddetails> leaddetailscls{get;set;}
    public transient  LIST<Item_Question__c> qlist;
    public transient MAP<ID,Lead_Scan__c> showleadMap;
    public BLN_LeadRetrieval_BAL lrBAL{get;set;} 
    public transient list<Reg_Setting__c> reg; 
    public String checkUnion{get;set;}
    public string orgId{get;set;}

    public BLN_LeadRetrievalCon (){
    orgId = UserInfo.getOrganizationId();
    displayPopup = false;
    editPopUp = false;
    diaplayLogin = false;
    isdelete=false;
        listSize= 0;
         selectedeventid = Apexpages.currentPage().getParameters().get('id');
         if(selectedeventid ==null){
               Cookie k = ApexPages.currentPage().getCookies().get('counter');
             if(k!=null){
             selectedeventid = k.getValue();
             }
             
             }
       displayPermissions();
    }

    public PageReference deleteLead() {
        String delLeadId= apexpages.currentpage().getparameters().get('deleteLead');
        system.debug('delLeadId'+delLeadId);
        lrBAL = new BLN_LeadRetrieval_BAL();
        lrBAL.deleteLead(delLeadId);
        
        pagereference pg1=new pagereference('/apex/BLN_LeadRetrieval');
        pg1.setRedirect(true);
        return pg1;
    }
    
    public map<Question__c,User_Answer__c> editqaMap{get;set;}
    public LIST<SelectOption> countryOptions{get; set;}
    public LIST<SelectOption> stateOptions{get; set;}
    public void editLead() {
        editPopUp = true;
        String showEditLeadID = apexpages.currentpage().getparameters().get('editLead');
        lrBAL = new BLN_LeadRetrieval_BAL();
        lrBAL.editLeadMethod(selectedeventid,showEditLeadID);
        leadeditlist=lrBAL.leadeditlist[0];
        editqaMap=lrBAL.editqaMap;
        editqacls=lrBAL.editqacls;   
        
       
        countryStates();
        statesBasedOnCountry();
        
       /*countryOptions= new LIST<SelectOption>();
     BLN_CountryState_DAO bcd = new BLN_CountryState_DAO();
     countryOptions = bcd.countryStates(selectedeventid);
     stateOptions= new LIST<SelectOption> ();  
     stateOptions = bcd.statesBasedOnCountry(countryOptions); */
     editPopUp = true;
    }

    public PageReference SavePopup() {
       lrBAL.savemethod(selectedRating,leadPic,leadImageName,selectedeventid,followupdate,isdelete);
       editPopUp = false;
        pagereference pg=new pagereference('/apex/BLN_LeadRetrieval');
        pg.setRedirect(true);
        return pg;
         
    }
    
    public PageReference closePopup() {
        displayPopup = false;
        editPopUp = false;
        pagereference pg=new pagereference('/apex/BLN_LeadRetrieval');
        pg.setRedirect(true);
        return pg;
    }
    
    public map<string,string> qaMap{get;set;}
    public list<Item_Question__c> qlst{get;set;}
    public LIST<Company_Ext__c> compext {get;set;}
    
    public void showpopup() {
        displayPopup = true;
        try{
        String showLeadID = apexpages.currentpage().getparameters().get('showId');
        
        lrBAL = new BLN_LeadRetrieval_BAL();
        lrBAL.showleaddetails(showLeadID,selectedeventid);
        showlead = new Lead_Scan__c();
        showlead=lrBAL.showlead;
        listOfintegers1=new List<String>();
        listOfintegers1=lrBAL.listOfintegers1;
        qacls= new list<BLN_LeadRetrieval_BAL.qaclass>();
        qacls=lrBAL.qacls;
        compext= new LIST<Company_Ext__c>();
        try{
        compext=lrBAL.compext;
        }catch(exception e){}
        set<string> e1= new set<string>();
        e1=lrBAL.mailid;
        lrBAL.getreg(e1,selectedeventid);
        
        reg=lrBAL.reg; 
        }catch(exception e){}
    }

    public BLN_Event__c  eventslist{get;set;}
    public void displayPermissions(){
      BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
      eventslist = new BLN_Event__c  ();
      try{
        eventslist = blneventdetailbal.eventdetails(selectedeventid);
      }catch(exception e){}

         LeadRetrieval = new BLN_UtillDisplayLinks();
         LeadRetrieval.isLeadRetrieval='active';
         LeadRetrieval.isLeadExpand='expand';
         LeadRetrieval.tablabel='Leads';
         LeadRetrieval.iseventsExpand ='';
         try{
         LeadRetrieval.eventName = eventslist.Name;
         }catch(exception e){}
         LeadRetrieval.EventId= selectedeventid;
         LeadRetrieval.userPermissions(userInfo.getUserId(),selectedeventid);
    }
    
    public BLN_EventDetails eventInfo{get; set;}
    public PageReference printLeads() {
        BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
        eventInfo= new BLN_EventDetails();
        eventInfo.eventDetailsToDisplay(selectedeventid);
        return new Pagereference('/apex/BLN_printLeads');
    }
    
    public PageReference exportLeads() {
        pageReference pg = new Pagereference('/apex/BLN_exportLeads');
        pg.setRedirect(true);
        pg.getParameters().put('search',apexpages.currentpage().getparameters().get('search'));
        return pg;
    }
    
    public pagereference expLeadAction(){
        BLN_LeadScan_DAO lsDAO = new BLN_LeadScan_DAO();
        String searchKey = ApexPages.currentPage().getParameters().get('search');
        system.debug('searchKey '+searchKey );
        string subwhere='';
        if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){
        String[] tokens = searchKey.split(' ');
        
        if(tokens.size()==2){
            subwhere+=' and ((First_Name__c  like \'%'+tokens[0]+'%\' and Last_Name__c like \'%'+tokens[1]+'%\') '; 
            subwhere+=' or (First_Name__c  like \'%'+tokens[1]+'%\' and Last_Name__c like \'%'+tokens[0]+'%\') ';
        }else{
            subwhere+=' and (First_Name__c  like \'%'+tokens[0]+'%\' or Last_Name__c  like \'%'+searchKey+'%\' ';
        }
        subwhere+= ' or  Prefix__c like \'%'+searchKey+'%\' or Suffix__c like \'%'+searchKey+'%\' or Company__c like \'%'+searchKey+'%\' or Title__c like \'%'+searchKey+'%\' or Lead_Email__c like \'%'+searchKey+'%\' or Street1__c like \'%'+searchKey+'%\' or Street2__c like \'%'+searchKey+'%\'or City__c like \'%'+searchKey+'%\' or BLN_State__r.Long_Name__c like \'%'+searchKey+'%\' or BLN_Country__r.Long_Name__c like \'%'+searchKey+'%\' or zip__c like \'%'+searchKey+'%\' or Work_Phone__c like \'%'+searchKey+'%\' or Home_Phone__c like \'%'+searchKey+'%\')';
        }
        LIST<Lead_Scan__c> leadlist = lsDAO.getLeadScan(selectedeventid,subwhere+' order by scan_time__c Desc');
        if(leadlist.size() < 1000){
            lrBAL = new BLN_LeadRetrieval_BAL();
            lrBAL.maintableVals(selectedeventid,leadlist);
            leaddetailscls= new list<BLN_LeadRetrieval_BAL.leaddetails>();
            leaddetailscls=lrBAL.leaddetailscls;
            return null;
        }else{
        string querystring = 'SELECT Event__r.Time_Zone__c,BLN_TKT_profile__r.Email__c,First_Name__c,Lead_Email__c,title__c,Last_Name__c,Name,Scanner_User__r.Email__c,Prefix__c,followup_date__c,notes__c,Rating__c,Suffix__c,Company__c,Work_Phone__c,City__c,BLN_Country__c,BLN_Country__r.Long_Name__c, BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_Country__r.Short_Name__c,user_pic__c,zip__c,Home_Phone__c,Street1__c,Street2__c,Scanner_Company__r.Name,Scanner_User__r.Name,Scanner_User__r.First_Name__c,Scanner_User__r.Last_Name__c,Cell_Phone__c,Scan_Time__c,Event__r.Name FROM Lead_Scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \'' + selectedeventid + '\' AND Scanner_User__r.User__c=\'' + UserInfo.getUserId() + '\'' +subwhere+ ' order by scan_time__c Desc';
            Id batchInstanceId = Database.executeBatch(new BLN_ExportLeadsBatch(querystring,selectedeventid), 1000);
            return new Pagereference('/BLN_MyLeadsCheckEmail');
        }
    }

    public PageReference salesorgExport() {
        diaplayLogin = true;
        return null;
    }
   
    public String dataTableJson { get; set; }
    public ApexPages.StandardSetController setCon {get;set;}
    public List<Lead_Scan__c> RecList{get;set;}
    public integer listSize{get;set;}
    public PageReference processData() {
        BLN_LeadScan_DAO lsDAO = new BLN_LeadScan_DAO();
        String searchKey = ApexPages.currentPage().getParameters().get('search[value]');
        
        string subwhere='';
        if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){
        String[] tokens = searchKey.split(' ');
        
        if(tokens.size()==2){
            subwhere+=' and ((First_Name__c  like \'%'+tokens[0]+'%\' and Last_Name__c like \'%'+tokens[1]+'%\') '; 
            subwhere+=' or (First_Name__c  like \'%'+tokens[1]+'%\' and Last_Name__c like \'%'+tokens[0]+'%\') ';
        }else{
            subwhere+=' and (First_Name__c  like \'%'+tokens[0]+'%\' or Last_Name__c  like \'%'+searchKey+'%\' ';
        }
        subwhere+= ' or  Prefix__c like \'%'+searchKey+'%\' or Suffix__c like \'%'+searchKey+'%\' or Company__c like \'%'+searchKey+'%\' or Title__c like \'%'+searchKey+'%\' or Lead_Email__c like \'%'+searchKey+'%\' or Street1__c like \'%'+searchKey+'%\' or Street2__c like \'%'+searchKey+'%\'or City__c like \'%'+searchKey+'%\' or BLN_State__r.Long_Name__c like \'%'+searchKey+'%\' or BLN_Country__r.Long_Name__c like \'%'+searchKey+'%\' or zip__c like \'%'+searchKey+'%\' or Work_Phone__c like \'%'+searchKey+'%\' or Home_Phone__c like \'%'+searchKey+'%\')';
        }
        
        
        
        /**********Sorting***/
                    
                    List<String>ColName = New List<String>();
                            ColName.add('');//1 column
                             ColName.add('');//2 column
                            ColName.add('Prefix__c');//3 column
                            ColName.add('First_Name__c');//4 column
                            ColName.add('Suffix__c');//5 column
                            ColName.add('Company__c');//6 column
                            ColName.add('Title__c');//7 
                          ColName.add('Lead_Email__c');//8 date
                          ColName.add('');//9 paytype
                            ColName.add('Rating__c');//order status
                            ColName.add('Scanner_User__r.First_Name__c');
                            ColName.add('scan_time__c');
                            ColName.add('');
                            ColName.add('followup_date__c');
                            ColName.add('Street1__c');
                            ColName.add('Street2__c');
                            ColName.add('City__c');
                            ColName.add('BLN_State__r.Long_Name__c');
                            ColName.add('BLN_Country__r.Long_Name__c');
                            ColName.add('zip__c');
                            ColName.add('');
                            ColName.add('');
                            ColName.add('');
            
            
                    integer i = 0;
                    integer v ;
                    
                    String str;
            
                    String col = ApexPages.currentPage().getParameters().get('order[0][column]');//Column to which ordering should be applied 
                    
                    if(col == ''){
                    col = '11';
                    }
                    
                    String sortord = ApexPages.currentPage().getParameters().get('order[0][dir]');//Get The direction of Sorting ASC or DESC
                    
                    if(sortord  == ''){
                    sortord = 'Desc';
                    }
               
            /****check user sorting on any column on not *****/
            /****use First Column as default sorting column*****/
                string wherecondition ='';
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
                    
                    wherecondition += ' '+sortord + ' NULLS LAST '; 
    
                    /****Sorting end**/
        
        
        
        
        LIST<Lead_Scan__c> leadlist = lsDAO.getLeadScan(selectedeventid,subwhere+wherecondition );//' order by scan_time__c Desc');
        listSize= leadlist.size();
        setcon=new ApexPages.StandardSetController(leadlist );
        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        
        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        setCon.setPageSize(10);
        
        Integer noOfRecords= setCon.getResultSize();
        if(size==-1){
            size=noOfRecords;
        }
        setCon.setPageSize(size);

        //set pagenumber
        setCon.setPageNumber((start/size)+1);
        
        RecList = setCon.getRecords(); 
        
        lrBAL = new BLN_LeadRetrieval_BAL();
        lrBAL.maintableVals(selectedeventid,RecList);
        qlist= new LIST<Item_Question__c>();
        qlist=lrBAL.qlist;
        set<string> ti1= new set<string>();
        ti1=lrBAL.ti;
        leaddetailscls= new list<BLN_LeadRetrieval_BAL.leaddetails>();
        leaddetailscls=lrBAL.leaddetailscls;
        
        //currently not using but need this
        //lrBAL.getreg(ti1,selectedeventid);
        //checkUnion='';
        //checkUnion=lrBAL.checkUnion;
        
        //create wrapper
        DataTableWrapper datawrap = new DataTableWrapper(0,noOfRecords,noOfRecords,leaddetailscls);
        dataTableJson = JSON.serialize(datawrap);
        return null;
    }

    public class DataTableWrapper{
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
        public boolean selected{get; set;}
        public Integer draw;
        public Integer recordsTotal;
        public Integer recordsFiltered;
        public List<BLN_LeadRetrieval_BAL.leaddetails> data;
   
        public DataTableWrapper(Integer draw,Integer recordsTotal,Integer recordsFiltered,list<BLN_LeadRetrieval_BAL.leaddetails> data)
        {
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered ;
            this.data = data;
        }
    } 
    
    public pageReference allstats(){
        BLN_LeadScan_DAO lsDAO = new BLN_LeadScan_DAO();
        String searchKey = ApexPages.currentPage().getParameters().get('search[value]');
        
        string subwhere='';
        if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){
        String[] tokens = searchKey.split(' ');
        
        if(tokens.size()==2){
            subwhere+=' and ((First_Name__c  like \'%'+tokens[0]+'%\' and Last_Name__c like \'%'+tokens[1]+'%\') '; 
            subwhere+=' or (First_Name__c  like \'%'+tokens[1]+'%\' and Last_Name__c like \'%'+tokens[0]+'%\') ';
        }else{
            subwhere+=' and (First_Name__c  like \'%'+tokens[0]+'%\' or Last_Name__c  like \'%'+searchKey+'%\' ';
        }
        subwhere+= ' or  Prefix__c like \'%'+searchKey+'%\' or Suffix__c like \'%'+searchKey+'%\' or Company__c like \'%'+searchKey+'%\' or Title__c like \'%'+searchKey+'%\' or Lead_Email__c like \'%'+searchKey+'%\' or Street1__c like \'%'+searchKey+'%\' or Street2__c like \'%'+searchKey+'%\'or City__c like \'%'+searchKey+'%\' or BLN_State__r.Long_Name__c like \'%'+searchKey+'%\' or BLN_Country__r.Long_Name__c like \'%'+searchKey+'%\' or zip__c like \'%'+searchKey+'%\' or Work_Phone__c like \'%'+searchKey+'%\' or Home_Phone__c like \'%'+searchKey+'%\')';
        }

        listSize=  database.countQuery('select count() from lead_scan__c WHERE  Lead_Status__c!=\'Deleted\' AND Event__c = \'' + selectedeventid+ '\' AND Scanner_User__r.User__c=\'' + UserInfo.getUserId()+ '\'' + subwhere);//leadlist.size();
        return null;
    }


        public void countryStates(){ 
            countryOptions= new LIST<SelectOption>();
            countryOptions.add(new SelectOption('','None'));
            for(BLN_Event_Countries_Include__c c: [SELECT ID, NAME, BLN_Country__c, BLN_Country__r.Short_Name__c, BLN_Country__r.Long_Name__c, BLN_Country__r.Order__c,BLN_Event__c FROM BLN_Event_Countries_Include__c where BLN_Event__c=:selectedeventid ORDER BY BLN_Country__r.Order__c]){
                countryOptions.add(new SelectOption(c.BLN_Country__c, c.BLN_Country__r.Long_Name__c));
                
            }     
        }
    
        public void statesBasedOnCountry(){
            stateOptions= new LIST<SelectOption> ();   
            stateOptions.add(new SelectOption('','None'));
            if(leadeditlist.BLN_country__c != null && string.valueof(leadeditlist.BLN_country__c) != ''){
            for(State__c s: [SELECT ID, NAME, Short_Name__c,Long_Name__c, Country__c, Order__c FROM State__c WHERE Country__c =: leadeditlist.BLN_country__c]){
                if(s.Short_Name__c != null)
                stateOptions.add(new SelectOption(s.id,s.Short_Name__c+'-'+s.Long_Name__c));
                else
                stateOptions.add(new SelectOption(s.id,s.Long_Name__c));
            }
            }
        }

}