public with sharing class testgroupingCon {

   

    public list<DummyInner> dummylist{get;set;}
    public map<string, DummyInner> mapDummys{get;set;}
    public list<CompleteDummyInner> completedummylist{get;set;}
    public map<string, completeDummyInner> completemapDummys{get; set;}
    public list<DummyInner1> dummylist1{get;set;}
    public map<string, DummyInner1> mapDummys1= new map<string, DummyInner1>();    
    public List<Dummay__c> dummyforexport{get; set;} 
    public list<DummyInner2> dummylist2{get;set;}
    public map<string, DummyInner2> mapDummys2= new map<string, DummyInner2>();    
    public List<Dummay__c> dummyforexportAll{get; set;} 
    public string eventid {get;set;}
    public boolean completegrid{get;set;}
    public boolean primarygrid{get;set;}
    public boolean statuschange{get;set;}
    public Integer TotalAmount{get;set;}
    public Integer TotalccAmount{get;set;}
    public Integer TotalCheckAmount{get;set;}
    public Integer TotalInvoiceAmount{get;set;}
    public Integer TicketCategoryWiseAmount{get;set;} 
    public Integer TotalRegistrations{get;set;}   
    public Integer TotalAttendeeRegistrations{get;set;}
    public id LoginUserID{get;set;}
    public AggregateResult[] results{get;set;}
    public List<Dummay__c> customerkeys {get; set;}
    public List<Dummay__c> dummyvalues {get; set;}
    public LIST<AttendeeSummary__c> attendeeids{get; set;}
    public LIST<AttendeeSummary__c> attendeelist{get; set;}
    public Event_Attendee_Mapping__c eamid{get; set;}
    public List<Event_Attendee_Mapping__c> eamids{get; set;} 
     
    public boolean Totalregistrationsbool{get;set;}
    public boolean summaryfieldbool{get;set;}
    public Dummay__c Dummy{get; set;}
    public ID dummyid {get;set;}
    public String statusvalue{get;set;} 
    public String CSVContentType{get;set;}
    public Decimal checkamount{get;set;}
    public String checknumber{get;set;}
    public Dummay__c dt{get;set;}
    
    /**
    public String sortDir{
        get{ if (sortDir == null){  sortDir = 'asc'; } return sortDir;}
        set;
    }
 
    // the current field to sort by. defaults to last name
    public String sortField{
        get{ if (sortField == null) {sortField = 'Company__c'; } return sortField;}
        set;
    }
    */
   private String sortDir = 'ASC';
   private String sortExp = 'Company__c';

   public String sortField
   {
     get
     {
        return sortExp;
     }
     set
     {
       //if the column is clicked on then switch between Ascending and Descending modes
       if (value == sortExp)
         sortDir = (sortDir == 'ASC')? 'DESC' : 'ASC';
       else
         sortDir = 'ASC';
       sortExp = value;
     }
   }

 public String getSortDir()
 {
    //if not column is selected 
    if (sortField == null || sortField == '')
      return 'ASC';
    else
     return SortDir;
 }

 public void setSortDir(String value)
 {  
   SortDir = value;
 }
     
    // toggles the sorting of query from asc <-->desc
    public void toggleSort(){
     //   sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        customerreport();
    }
    
    public testgroupingCon(){
      dt = new Dummay__c();
    // dt.Start_Date__c = system.Today().toStartOfMonth();
    // dt.End_Date__c = system.Today().toStartOfMonth().addDays(45).TostartOfMonth().addDays(-1);
    
    dt.Start_Date__c= Date.valueof(dt.Event__r.CreatedDate);
    dt.End_Date__c= dt.Event__r.EV_EndDate__c;
    
        eventid = Apexpages.currentpage().getparameters().get('id');
        dt.Start_Date__c= Date.valueof(dt.Event__r.CreatedDate);
        dt.End_Date__c= dt.Event__r.EV_EndDate__c;
        selectedoption  = 'ALL';
        oncons=true;
        mapDummys = new  map<string, DummyInner> ();
        Totalregistrationsbool=true;
        summaryfieldbool= true;
        completegrid=true;
        primarygrid=false;
        //LoginUserID ='005Z0000001JSIB';
        LoginUserID = UserInfo.getUserId(); 

       customerreport();
      //amountgenerated();
        AggregateResult[] results = [SELECT SUM(IndividualAmount__c) total 
                                     FROM Dummay__c 
                                     WHERE Event__r.id =: eventid 
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount = results[0].get('total');
        TotalAmount=Integer.ValueOf(sumAmount);
        
        AggregateResult[] results1 = [SELECT SUM(IndividualAmount__c) total1 FROM Dummay__c 
                                     WHERE Event__r.id =: eventid 
                                     AND Payment_Type__c = 'Credit Card' 
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount1 = results1[0].get('total1');
        TotalCCAmount=Integer.ValueOf(sumAmount1);
        
        AggregateResult[] results2 = [SELECT SUM(IndividualAmount__c) total2 FROM Dummay__c 
                                     WHERE Event__r.id =: eventid 
                                     AND Payment_Type__c = 'Check'
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount2 = results2[0].get('total2');
        TotalCheckAmount=Integer.ValueOf(sumAmount2);
        
        AggregateResult[] results3 = [SELECT SUM(IndividualAmount__c) total3 FROM Dummay__c 
                                     WHERE Event__r.id =: eventid 
                                     AND Payment_Type__c = 'Invoice'  
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount3 = results3[0].get('total3');
        TotalInvoiceAmount=Integer.ValueOf(sumAmount3);
        
               
    }     
    
    public list<selectoption> atttypeoption {get;set;}
    public string selectedoption {get;set;}
    public integer attendeecount {get;set;}
    public integer  bacount {get;set;}
    public boolean oncons{get;set;}
    public boolean onsel{get;set;}
    public string dyquery{get;set;}
    
  //  dyquery= 'select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.TT_TicketType__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c,Update_with_created_date__c, LastModifiedDate,IndividualAmount__c FROM  Dummay__c WHERE Event__r.id = \''+eventid+ '\' AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
    
    
    public void customerreport(){ 
    
      Date startdate= dt.Start_Date__c;
      Date enddate= dt.End_Date__c;
        mapDummys = new map<string, DummyInner> {};
        atttypeoption = new list<selectoption> {};
        completegrid=true;
        primarygrid=false;
        summaryfieldbool=true;
        customerkeys = new List<Dummay__c>();
        string listQuery;
        
        if(oncons==true){
        listQuery = 'select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.TT_TicketType__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c,Update_with_created_date__c, LastModifiedDate,IndividualAmount__c FROM  Dummay__c WHERE Event__r.id = \''+eventid+ '\' AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
     
      /**  
        customerkeys = [SELECT id,customer_key__r.Name,customer_key__r.Total_Amount__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate
                        FROM Dummay__c 
                        WHERE Event__r.id =: eventid 
                        AND customer_key__c != Null 
                        AND TicketTypes__c != Null
                        AND customer_key__r.Isinserted__c = true 
                        ORDER BY Company__c];  
    */
       }
       if(onsel==true){
       listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.TT_TicketType__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c,Update_with_created_date__c, LastModifiedDate,IndividualAmount__c FROM  Dummay__c WHERE Update_with_created_date__c >=:  startdate AND Update_with_created_date__c <=: enddate AND Event__r.id = \''+eventid+ '\' AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
       }
            system.debug('@@@@@@111 '+listQuery);
            try{
            customerkeys = dataBase.Query(listQuery);
            system.debug('@@@@@@222 '+customerkeys); 
            }catch (exception e){}  
      
        dummylist = new list<DummyInner>();
        atttypeoption.add(new selectoption('ALL','ALL'));
        try{
            LIST<Event__c> ev = [Select id,Attendee_Types__c from Event__c WHERE id =: eventid];
            list<string> types = ev[0].Attendee_Types__c.split(';');
        
            for(string ss : types ){
                atttypeoption.add(new selectoption(ss,ss));
            }
        }
        catch(exception e){}
        
        for(Dummay__c dummy : customerkeys)
        {
            if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
                if(mapDummys.get(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c) == null)
                {
                    mapDummys.put(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c,new Dummyinner(dummy));    
                    dummylist.add(mapDummys.get(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c));
                                  
                }
                else
                {
                    mapDummys.get(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c).liDummys.add(dummy);              
                }
            }

            else{
                if(mapDummys.get(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c) == null)
                {
                    if(dummy.TicketTypes__r.Ticket_Category__c == selectedoption ){
                        mapDummys.put(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c,new Dummyinner(dummy)); 
                        system.debug('**** '+mapDummys);       
                        dummylist.add(mapDummys.get(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c));
                    }               
                }
                else{
                    mapDummys.get(dummy.Company__c+dummy.TicketTypes__r.Ticket_Category__c).liDummys.add(dummy);              
                }
          }
        }
       getTotalAmount();

        attendeecount =0;
        bacount =0;
        bacount = dummylist.size();
        for(DummyInner dum:dummylist){
          attendeecount +=dum.liDummys.size();
        }
    } 
    
    public class DummyInner
    {
        public list<Dummay__c> liDummys{get;set;}
        public string dummyCompany{get;set;}
        public string dummyUsertype{get;set;}
        
        public DummyInner(Dummay__c dummy)
        {
            dummyCompany = dummy.Company__c;
            dummyUsertype = dummy.TicketTypes__r.User_Type__c; 
            liDummys = new list<Dummay__c>{dummy};
        }
    }
    
    public void getTotalAmount(){
    
    Date startdate=dt.Start_Date__c;
    Date enddate=dt.End_Date__c;
     
        if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
            AggregateResult[] results = [SELECT SUM(IndividualAmount__c) total FROM Dummay__c 
                                         WHERE(Update_with_created_date__c >=: startdate  
                                         AND Update_with_created_date__c <=: enddate) 
                                         AND Event__r.id =: eventid 
                                         AND customer_key__c != Null 
                                         AND TicketTypes__c != Null 
                                         AND Payment_Status__c != 'Cancelled'
                                         AND customer_key__r.Isinserted__c = true ];
            Object sumAmount = results[0].get('total');
            TotalAmount=Integer.ValueOf(sumAmount);
            
            AggregateResult[] results1 = [SELECT SUM(IndividualAmount__c) total1 FROM Dummay__c 
                                     WHERE (Update_with_created_date__c >=: startdate  
                                     AND Update_with_created_date__c <=: enddate) 
                                     AND Event__r.id =: eventid 
                                     AND Payment_Type__c = 'Credit Card' 
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null 
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
            Object sumAmount1 = results1[0].get('total1');
            TotalCCAmount=Integer.ValueOf(sumAmount1);
            
            AggregateResult[] results2 = [SELECT SUM(IndividualAmount__c) total2 FROM Dummay__c 
                                         WHERE (Update_with_created_date__c >=: startdate  
                                         AND Update_with_created_date__c <=: enddate)  
                                         AND Event__r.id =: eventid 
                                         AND Payment_Type__c = 'Check'
                                         AND customer_key__c != Null 
                                         AND TicketTypes__c != Null 
                                         AND Payment_Status__c != 'Cancelled'
                                         AND customer_key__r.Isinserted__c = true ];
            Object sumAmount2 = results2[0].get('total2');
            TotalCheckAmount=Integer.ValueOf(sumAmount2);
            
            AggregateResult[] results3 = [SELECT SUM(IndividualAmount__c) total3 FROM Dummay__c 
                                         WHERE (Update_with_created_date__c >=: startdate  
                                         AND Update_with_created_date__c <=: enddate)  
                                         AND Event__r.id =: eventid 
                                         AND Payment_Type__c = 'Invoice'  
                                         AND customer_key__c != Null 
                                         AND TicketTypes__c != Null 
                                         AND Payment_Status__c != 'Cancelled'
                                         AND customer_key__r.Isinserted__c = true ];
            Object sumAmount3 = results3[0].get('total3');
            TotalInvoiceAmount=Integer.ValueOf(sumAmount3);
        }
        else{
            AggregateResult[] results = [SELECT SUM(IndividualAmount__c) total FROM Dummay__c 
                                         WHERE (Update_with_created_date__c >=: startdate  
                                         AND Update_with_created_date__c <=: enddate)
                                         AND Event__r.id =: eventid 
                                         AND customer_key__c != Null 
                                         AND TicketTypes__c != Null 
                                         AND Payment_Status__c != 'Cancelled'
                                         AND TicketTypes__r.Ticket_Category__c =: selectedoption
                                         AND customer_key__r.Isinserted__c = true ];
            Object sumAmount = results[0].get('total');
            TotalAmount=Integer.ValueOf(sumAmount);
            
            AggregateResult[] results1 = [SELECT SUM(IndividualAmount__c) total1 FROM Dummay__c 
                                     WHERE (Update_with_created_date__c >=: startdate  
                                         AND Update_with_created_date__c <=: enddate)
                                         AND Event__r.id =: eventid  
                                     AND Payment_Type__c = 'Credit Card' 
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null 
                                     AND Payment_Status__c != 'Cancelled'
                                     AND TicketTypes__r.Ticket_Category__c =: selectedoption
                                     AND customer_key__r.Isinserted__c = true ];
            Object sumAmount1 = results1[0].get('total1');
            TotalCCAmount=Integer.ValueOf(sumAmount1);
            
            AggregateResult[] results2 = [SELECT SUM(IndividualAmount__c) total2 FROM Dummay__c 
                                         WHERE (Update_with_created_date__c >=: startdate  
                                         AND Update_with_created_date__c <=: enddate)
                                         AND Event__r.id =: eventid  
                                         AND Payment_Type__c = 'Check'
                                         AND customer_key__c != Null 
                                         AND TicketTypes__c != Null 
                                         AND Payment_Status__c != 'Cancelled'
                                         AND TicketTypes__r.Ticket_Category__c =: selectedoption
                                         AND customer_key__r.Isinserted__c = true ];
            Object sumAmount2 = results2[0].get('total2');
            TotalCheckAmount=Integer.ValueOf(sumAmount2);
            
            AggregateResult[] results3 = [SELECT SUM(IndividualAmount__c) total3 FROM Dummay__c 
                                         WHERE (Update_with_created_date__c >=: startdate  
                                         AND Update_with_created_date__c <=: enddate)
                                         AND Event__r.id =: eventid 
                                         AND Payment_Type__c = 'Invoice'  
                                         AND customer_key__c != Null 
                                         AND TicketTypes__c != Null 
                                         AND Payment_Status__c != 'Cancelled'
                                         AND TicketTypes__r.Ticket_Category__c =: selectedoption
                                         AND customer_key__r.Isinserted__c = true ];
            Object sumAmount3 = results3[0].get('total3');
            TotalInvoiceAmount=Integer.ValueOf(sumAmount3);
        
        }       
    }
    
    
    public void detailedreport(){ 
    completemapDummys = new map<string, completeDummyInner> {};
    atttypeoption = new list<selectoption> {};
        completegrid = false;
        primarygrid = true;
        dummyvalues = new List<Dummay__c>();
        dummyvalues = [SELECT customer_key__r.Total_Amount__c,customer_key__r.Ticket_Types__c,Check_number__c,Phone__c,TicketTypes__r.User_Type__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c, LastModifiedDate, Company__c,DiscountValue__c,Promocode__c,Ticket_Amount__c,Event__r.EV_HostingOrgName__c,customer_key__r.Name,ID, Event__r.owner.Email,Event__r.owner.Name,Event__r.owner.userName,NAME, Last_Name__c, First_Name__c,Email__c,TicketAmount__c,  Event__r.AS_HostingAddr2__c, Event__r.EV_HistingAddr1__c,Event__r.EV_HostingZipcode__c,Event__r.EV_HostingStateNew__c,Event__r.AS_HostingCity__c,Event__r.EV_HostingLocation__c,Event__c,Event__r.EV_Title__c,Event__r.EV_StartDate__c,
                              TicketTypes__r.TT_TicketType__c, Event__r.StartTime__c,Event__r.EV_EndDate__c,Event__r.EV_EndTime__c,CreatedDate, TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_Name__c,TicketTypes__r.Section_Name__c, TicketTypes__r.TT_Amount__c,Payment_Type__c ,Event__r.TwitterId__c,Event__r.FacebookId__c,Event__r.OrganizerId__c ,IndividualAmount__c
                        FROM Dummay__c  
                        WHERE Event__r.id =: eventid 
                        AND customer_key__c != Null 
                        AND TicketTypes__c != Null
                        AND customer_key__r.Isinserted__c = true 
                        ORDER BY Company__c];  
             
        completedummylist = new list<CompleteDummyinner>();
        
        atttypeoption.add(new selectoption('ALL','ALL'));
        try{
            LIST<Event__c> ev = [Select id,Attendee_Types__c from Event__c WHERE id =: eventid];
            list<string> types = ev[0].Attendee_Types__c.split(';');
              
            for(string ss : types){
                atttypeoption.add(new selectoption(ss,ss));
            }
        }
        catch(exception e){}
        
        for(Dummay__c dummyval : dummyvalues)        
        {
         if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
            if(completemapDummys.get(dummyval.Company__c+dummyval .TicketTypes__r.Ticket_Category__c) == null){
                completemapDummys.put(dummyval.Company__c+dummyval .TicketTypes__r.Ticket_Category__c,new CompleteDummyinner(dummyval));   
                completedummylist.add(completemapDummys.get(dummyval.Company__c+dummyval.TicketTypes__r.Ticket_Category__c));               
            }
            else{
                completemapDummys.get(dummyval.Company__c+dummyval .TicketTypes__r.Ticket_Category__c).completeliDummys.add(dummyval);              
            }  
            }else{
            
            if(completemapDummys.get(dummyval.Company__c+dummyval.TicketTypes__r.Ticket_Category__c) == null)
            {
             
            
            if(dummyval.TicketTypes__r.Ticket_Category__c == selectedoption){
                completemapDummys.put(dummyval.Company__c+dummyval.TicketTypes__r.Ticket_Category__c,new CompleteDummyinner(dummyval));        
                completedummylist.add(completemapDummys.get(dummyval.Company__c+dummyval.TicketTypes__r.Ticket_Category__c));
                }               
            }
            else{
                completemapDummys.get(dummyval.Company__c+dummyval.TicketTypes__r.Ticket_Category__c).completeliDummys.add(dummyval);              
            } 
            
            }        
        }  
        getTotalAmount();    
    }
        
    
    public class CompleteDummyinner
    {
        public list<Dummay__c> completeliDummys{get;set;}
        public string completedummyCompany {get;set;}
        public string completedummyUsertype{get;set;}
        public boolean summaryfieldbool1{get;set;}
        
        public CompleteDummyinner(Dummay__c dummyval)
        {
            completedummyCompany = dummyval.Company__c;
            completedummyUsertype = dummyval.TicketTypes__r.User_Type__c; 
            completeliDummys = new list<Dummay__c>{dummyval};
            if(dummyval.Primary_Attendee__c == false){
                summaryfieldbool1=false;
            }
            else{
                summaryfieldbool1 = true;
            }
        }
    }

    
        
    public PageReference export(){ 
        dummyforexport = new List<Dummay__c>();
        string listQuery;
         Date startdate=dt.Start_Date__c;
         Date enddate=dt.End_Date__c;
        
        if(dt.Start_Date__c ==Null && dt.End_Date__c ==Null)
        {
            if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
                listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,TicketTypes__r.TT_TicketType__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,IndividualAmount__c FROM Dummay__c WHERE Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
                
              
            }
            else{
                listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,IndividualAmount__c FROM Dummay__c WHERE Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true AND TicketTypes__r.Ticket_Category__c = \''+selectedoption+ '\'ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
               
            }
        }else{
            if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
                listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,TicketTypes__r.TT_TicketType__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,Update_with_created_date__c,IndividualAmount__c FROM Dummay__c WHERE  Update_with_created_date__c >=: startdate  AND Update_with_created_date__c <=: enddate AND Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
               }
              // system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@'+listQuery);
            else{
                listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,Update_with_created_date__c,IndividualAmount__c FROM Dummay__c WHERE Update_with_created_date__c >=: startdate  AND Update_with_created_date__c <=: enddate AND Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true AND TicketTypes__r.Ticket_Category__c = \''+selectedoption+ '\'ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
              } 
                
        }
        system.debug('###################'+listQuery);  
        try{
            dummyforexport = dataBase.Query(listQuery); 
        }
        catch(exception e){}
        dummylist1 = new list<DummyInner1>();
        for(Dummay__c dummy1 : dummyforexport)
        {
            if(mapDummys1.get(dummy1.Company__c+dummy1.TicketTypes__r.Ticket_Category__c) == null)
            {
                mapDummys1.put(dummy1.Company__c+dummy1.TicketTypes__r.Ticket_Category__c,new Dummyinner1(dummy1));       
                dummylist1.add(mapDummys1.get(dummy1.Company__c+dummy1.TicketTypes__r.Ticket_Category__c));               
            }
            else
            {
                mapDummys1.get(dummy1.Company__c+dummy1.TicketTypes__r.Ticket_Category__c).liDummys1.add(dummy1);              
            }
        }   
        if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
            Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=Registration_Details.pdf');
        }
        else{
         String PDFContentType = selectedoption + '_Registration_Details.pdf';
            Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+PDFContentType );
        }
        pagereference pg =page.ExportasPdf;
        return pg;
    }


      
    
    public class DummyInner1
    {
        public list<Dummay__c> liDummys1{get;set;}
        public string dummyCompany1{get;set;}
        public string dummyUsertype1{get;set;}
        
        public DummyInner1(Dummay__c dummy1)
        {
            dummyUsertype1 = dummy1.TicketTypes__r.User_Type__c; 
            dummyCompany1 = dummy1.Company__c;
            liDummys1 = new list<Dummay__c>{dummy1};
        }
    }
    
    public PageReference exportAll(){
        dummyforexportAll = new List<Dummay__c>();
        string listQuery;
        if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
            listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,IndividualAmount__c FROM Dummay__c WHERE Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
            
          /**  dummyforexportAll = [SELECT id,customer_key__r.Name,Primary_Attendee__c,TicketTypes__r.User_Type__c,customer_key__r.Total_Amount__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,DiscountValue__c
                            FROM Dummay__c 
                            WHERE Event__r.id =: eventid 
                            AND customer_key__c != Null 
                            AND TicketTypes__c != Null
                            AND customer_key__r.Isinserted__c = true 
                            ORDER BY Company__c];  */
        }
        else{
            listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate FROM Dummay__c WHERE Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true AND TicketTypes__r.Ticket_Category__c = \''+selectedoption+ '\'ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
           /** 
            dummyforexportAll = [SELECT id,customer_key__r.Name,Primary_Attendee__c,TicketTypes__r.User_Type__c,customer_key__r.Total_Amount__c,customer_key__r.Ticket_Types__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,DiscountValue__c
                            FROM Dummay__c 
                            WHERE Event__r.id =: eventid 
                            AND customer_key__c != Null 
                            AND TicketTypes__c != Null
                            AND customer_key__r.Isinserted__c = true 
                            AND TicketTypes__r.Ticket_Category__c =: selectedoption
                            ORDER BY Company__c];  */
        }
        try{
            dummyforexportAll = dataBase.Query(listQuery); 
        }
        catch(exception e){}
        
        dummylist2 = new list<DummyInner2>();
        for(Dummay__c dummy2 : dummyforexportAll)
        {
            if(mapDummys2.get(dummy2.Company__c+dummy2.TicketTypes__r.Ticket_Category__c) == null)
            {
                mapDummys2.put(dummy2.Company__c+dummy2.TicketTypes__r.Ticket_Category__c,new Dummyinner2(dummy2));       
                dummylist2.add(mapDummys2.get(dummy2.Company__c+dummy2.TicketTypes__r.Ticket_Category__c));               
            }
            else
            {
                mapDummys2.get(dummy2.Company__c+dummy2.TicketTypes__r.Ticket_Category__c).liDummys2.add(dummy2);              
            }
        }   
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment;');
        pagereference pg =page.ExportAllasPdf;
        return pg;
    }
    
    
    public class DummyInner2
    {
        public list<Dummay__c> liDummys2{get;set;}
        public string dummyCompany2{get;set;}
        public string dummyUsertype2{get;set;}
        
        public DummyInner2(Dummay__c dummy2)
        {
            dummyUsertype2 = dummy2.TicketTypes__r.User_Type__c; 
            dummyCompany2 = dummy2.Company__c;
            liDummys2 = new list<Dummay__c>{dummy2};
        }
    }
    
    public void changestatus(){
        string ss = ApexPages.currentPage().getParameters().get('mycheck');
        dummyid=ss;
        statuschange = true;
    }


    public List<SelectOption> getpaymentstatus(){     
        Dummy= new Dummay__c();       
        List<selectoption> Options = new List<selectoption>();
        Dummy=[SELECT customer_key__r.Total_Amount__c,customer_key__r.Ticket_Types__c,Check_number__c,Phone__c,TicketTypes__r.User_Type__c,TicketTypes__r.TT_TicketType__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c, LastModifiedDate, Company__c,DiscountValue__c,Promocode__c,Ticket_Amount__c,Event__r.EV_HostingOrgName__c,customer_key__r.Name,ID, Event__r.owner.Email,Event__r.owner.Name,Event__r.owner.userName,NAME, Last_Name__c, First_Name__c,Email__c,TicketAmount__c,  Event__r.AS_HostingAddr2__c, Event__r.EV_HistingAddr1__c,Event__r.EV_HostingZipcode__c,Event__r.EV_HostingStateNew__c,Event__r.AS_HostingCity__c,Event__r.EV_HostingLocation__c,Event__c,Event__r.EV_Title__c,Event__r.EV_StartDate__c,
                      Event__r.StartTime__c,Event__r.EV_EndDate__c,Event__r.EV_EndTime__c,CreatedDate, TicketTypes__r.Ticket_Category__c,TicketTypes__r.TT_Name__c,TicketTypes__r.Section_Name__c, TicketTypes__r.TT_Amount__c,Payment_Type__c ,Event__r.TwitterId__c,Event__r.FacebookId__c,Event__r.OrganizerId__c,IndividualAmount__c 
               FROM Dummay__c 
               WHERE Event__c != Null 
               AND customer_key__c != Null 
               AND TicketTypes__c != Null
               AND customer_key__r.Isinserted__c = true 
               AND ID =: dummyid]; 
        checkamount = Dummy.TicketAmount__c;
        checknumber = Dummy.Check_number__c;  
        if(Dummy.Payment_Status__c == 'Paid'){
            statusvalue = 'Paid';
            Options.add(new selectoption('Paid', 'Paid'));
            Options.add(new selectoption('Not Paid', 'Not Paid'));
            Options.add(new selectoption('Cancelled', 'Cancelled'));
        }
        else if(Dummy.Payment_Status__c == 'Not Paid'){
            statusvalue = 'Not Paid';
            Options.add(new selectoption('Not Paid', 'Not Paid'));
            Options.add(new selectoption('Paid', 'Paid'));
            Options.add(new selectoption('Cancelled', 'Cancelled'));
        }   
        else{
            statusvalue = 'Cancelled';
            Options.add(new selectoption('Cancelled', 'Cancelled'));
            Options.add(new selectoption('Paid', 'Paid'));
            Options.add(new selectoption('Not Paid', 'Not Paid'));
        }  
       return Options;
    }


    public pagereference changingpaymentstatus(){
    try{
       attendeeids= new LIST<AttendeeSummary__c>();  
        eamids= new List<Event_Attendee_Mapping__c>();      
       // Event__c evname = new Event__c();
      //  evname = [SELECT Id,Ev_title__c FROM Event__c WHERE id =: eventid ];
       // attendeeids = [SELECT Id FROM AttendeeSummary__c WHERE AS_Email__c =: dummy.Email__c];
        eamids =[SELECT Id,AS_id__c,AS_id__r.AS_Email__c,EV_id__c,EV_id__r.ev_title__c FROM Event_Attendee_Mapping__c WHERE AS_id__c IN : attendeeids AND EV_id__c =: eventid];       
                            
        if(statusvalue=='Paid'){
            Dummy.Payment_Status__c = 'Paid';
            Dummy.TicketAmount__c = checkamount;
            Dummy.Check_number__c = checknumber;
            for(Event_Attendee_Mapping__c eamid:eamids){
                eamid.Paid__c = true;                 
            } 
            if(Dummy.Payment_Type__c == 'Check'){
                 List<Messaging.SingleEmailMessage> EmailsList = new List<Messaging.SingleEmailMessage>();
                 List<Messaging.SingleEmailMessage> EmailsList2 = new List<Messaging.SingleEmailMessage>();
                 Commanforstates  con = new Commanforstates();
                 string questionpeople;
                 string partiattendPeople;
                try{
                 
                     OrgWideEmailAddress Org;
                
                     try{
                      if(dummy.Event__r.EV_Title__c=='Long Island Commercial Real Estate Expo'){
                          Org = [select id from OrgWideEmailAddress WHERE DisplayNAME=:'Licree'];
                      }else if(dummy.Event__r.EV_Title__c=='Special Needs Expos Long Island'){
                          Org = [select id from OrgWideEmailAddress WHERE DisplayNAME=:'Special Needs Expo'];
                      }
                      else{
                        if(dummy.Event__r.OrganizerId__c!=null){
                          Org = [select id from OrgWideEmailAddress WHERE address=: dummy.Event__r.OrganizerId__c];
                        }
                        else{
                            Org = [select id from OrgWideEmailAddress WHERE address='support@boothleads.com'];
                        } 
                      }
                      }
                      catch(Exception e){}
                       
                       if(dummy.TicketTypes__r.Ticket_Category__c=='Attendee'){
                         List<Survey__c> survey = new List<Survey__c>();
                         survey =[SELECT id,customer_key__c,Survey_Questions__c,Answers__c,Survey_Questions__r.Question__c from Survey__c where customer_key__c=: dummy.customer_key__c  and Survey_Questions__r.Question__c='My party will total ___ people(Enter number).'];
                         if(survey.size()>0){
                           partiattendPeople=survey[0].Answers__c;
                           questionpeople =survey[0].Survey_Questions__r.Question__c;
                         }
                       }
                   
                       dummy.Event__r.EV_HostingStateNew__c=  con.mapstate(dummy.Event__r.EV_HostingStateNew__c);
                       Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                       email.setSubject('Order Payment Approved for '+ dummy.Event__r.EV_Title__c);
                       if(Org != null){  
                           email.setOrgWideEmailAddressId(Org.id); 
                       }
                     
                       LIST<String> ccAddresses = new LIST<String>();  
                       ccAddresses.add(dummy.Event__r.OrganizerId__c);
                       // ccAddresses.add('mahesh.sakunala@gmail.com');
                       ccAddresses.add('durga@globalnest.com');
                      
                      email.setToAddresses(ccAddresses);
                      
                      EmailTemplate E = new EmailTemplate();    
                      E = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Check Approved Template'];  
                     
                      String ReplaceContactName = E.HtmlValue;
                      String replacedname ;
                      
                      try{
                      replacedname = ReplaceContactName.Replace('{!userName}',dummy.First_Name__c +' '+dummy.Last_Name__c);
                      }catch(exception ed){
                          replacedname = ReplaceContactName.Replace('{!userName}','' +' '+'');
                      }
                      
                     try{
                       replacedname = replacedname.Replace('{!userEmail}',dummy.Email__c);
                      }catch(exception ed){
                       replacedname = replacedname.Replace('{!userEmail}','');
                      }
                     
                   try{  
                     replacedname = replacedname.Replace('{!orderNumber}',dummy.customer_key__r.Name);
                      }catch(exception ed){
                       replacedname = replacedname.Replace('{!orderNumber}','');
                     }
                     
                      try{ 
                       replacedname = replacedname.Replace('{!eventName}',dummy.Event__r.EV_Title__c);
                       }catch(exception ed){
                        replacedname = replacedname.Replace('{!eventName}','');
                       }
                     
                      try{ 
                     replacedname = replacedname.Replace('{!eventOrgName}',dummy.Event__r.EV_HostingOrgName__c);
                    }catch(exception ed){
                      replacedname = replacedname.Replace('{!eventOrgName}','');
                    }
                    
                      try{ 
                       replacedname = replacedname.Replace('{!company}',dummy.company__c);
                       } catch(exception ed){
                       replacedname = replacedname.Replace('{!company}','');
                     }
                     
                      try{ 
                       replacedname = replacedname.Replace('{!type}',dummy.TicketTypes__r.Ticket_Category__c);
                       } catch(exception ed){
                       replacedname = replacedname.Replace('{!type}','');
                     }
                     
                     try{ 
                       replacedname = replacedname.Replace('{!discount}',dummy.DiscountValue__c);
                       } catch(exception ed){
                       replacedname = replacedname.Replace('{!discount}','');
                     }
                       
                      try{ 
                       replacedname = replacedname.Replace('{!promo}',dummy.Promocode__c);
                       } catch(exception ed){
                       replacedname = replacedname.Replace('{!promo}','');
                     }
                        
                      try{ 
                       replacedname = replacedname.Replace('{!originolant}',string.valueOf(dummy.Ticket_Amount__c));
                       } catch(exception ed){
                       replacedname = replacedname.Replace('{!originolant}','');
                     }
                               
                    try{ 
                       replacedname = replacedname.Replace('{!afterdis}',string.valueOf(dummy.TicketAmount__c));
                       } catch(exception ed){
                       replacedname = replacedname.Replace('{!afterdis}','');
                     }
        
                     
                     try{ 
                      replacedname = replacedname.Replace('{!organizerName}',dummy.Event__r.OrganizerId__c);
                    } catch(exception ed){
                       replacedname = replacedname.Replace('{!organizerName}','');
                     }
                    
                     try{ 
                       replacedname = replacedname.Replace('{!ticketName}',dummy.TicketTypes__r.TT_Name__c);
                     }catch(exception ed){ 
                      replacedname = replacedname.Replace('{!ticketName}','');
                     }
                     
                      try{ 
                      replacedname = replacedname.Replace('{!eventLocation}',dummy.Event__r.EV_HostingLocation__c);
                      }catch(exception ed){
                       replacedname = replacedname.Replace('{!eventLocation}','');
                      }
                     
                      try{ 
                       replacedname = replacedname.Replace('{!ordertype}',dummy.Payment_Type__c);
                       } catch(exception ed){
                       replacedname = replacedname.Replace('{!ordertype}','');
                     }
                     
                     
                     
                     
                      try{ 
                      replacedname = replacedname.Replace('{!eventAdd1}',dummy.Event__r.EV_HistingAddr1__c);
                     }catch(exception ed){
                      replacedname = replacedname.Replace('{!eventAdd1}','');
                     }
                    
                     try{ 
                     replacedname = replacedname.Replace('{!eventCity}',dummy.Event__r.AS_HostingCity__c);
                      }catch(exception ed){
                      replacedname = replacedname.Replace('{!eventCity}','');
                      }
                     
                     
                      try{ 
                      replacedname = replacedname.Replace('{!eventState}',dummy.Event__r.EV_HostingStateNew__c);
                      }catch(exception ed){
                       replacedname = replacedname.Replace('{!eventState}','');
                      }
                     
                     
                     
                      try{ 
                      replacedname = replacedname.Replace('{!EventZip}',dummy.Event__r.EV_HostingZipcode__c);
                      }catch(exception ed){
                       replacedname = replacedname.Replace('{!EventZip}','');
                      }
                      
                      
                     try{ 
                       replacedname = replacedname.Replace('{!peoplenumber}',partiattendPeople);
                    
                     }catch(exception ed){
                      replacedname = replacedname.Replace('{!peoplenumber}','');
                     }
                    
                     try{ 
                      replacedname = replacedname.Replace('{!question}',questionpeople);
                      }catch(exception ed){
                       replacedname = replacedname.Replace('{!question}','');
                      }
                     
                     Datetime myDatetime = dummy.createddate;
                     String myDatetimeStr = myDatetime.format('MM-dd-yyyy hh:mm a');
                     
                     try{  
                        replacedname = replacedname.Replace('{!orderDate}',myDatetimeStr );
                     }
                     catch(exception ed){
                        replacedname = replacedname.Replace('{!orderDate}','');
                     }
                     
                     
                     
                     Date myDatetime1 = dummy.Event__r.EV_StartDate__c;
                     String myDatetimeStr1 = myDatetime1.format();
                     
                     Date myDatetime2 = dummy.Event__r.EV_EndDate__c;
                     String myDatetimeStr2 = myDatetime2.format();
                    
                     try{ 
                        replacedname = replacedname.Replace('{!eventDate}',myDatetimeStr1 +' '+dummy.Event__r.StartTime__c+'-'+myDatetimeStr2 +' '+dummy.Event__r.EV_EndTime__c);
                     } 
                     catch(exception ed){
                        replacedname = replacedname.Replace('{!eventDate}','');
                     }
                     
                     email.setHtmlBody(replacedname);  
                     system.debug('111111111 '+replacedname);          
                     EmailsList.add(email); 
                     system.debug('222222222 '+EmailsList);
  
                     EmailTemplate E1 = new EmailTemplate();    
                     E1 = [select Body,Subject,HtmlValue,Markup from EmailTemplate Where Name = 'Check Approved Template to User'];  
                     
                     String ReplaceContactName1 = E1.HtmlValue;
                     String replacedname1;
                     
                     try{ 
                     replacedname1 = ReplaceContactName1.Replace('{!userName}',dummy.First_Name__c +' '+dummy.Last_Name__c);
                     } catch(exception ed){
                      replacedname1 = ReplaceContactName1.Replace('{!userName}','');
                    }
                    
                    
                     try{ 
                       replacedname1 = replacedname1.Replace('{!eventOrgName}',dummy.Event__r.EV_HostingOrgName__c);
                       } catch(exception ed){
                        replacedname1 = replacedname1.Replace('{!eventOrgName}','');
                     }
                     
                     
                      try{ 
                       replacedname1 = replacedname1.Replace('{!company}',dummy.company__c);
                       } catch(exception ed){
                       replacedname1 = replacedname1.Replace('{!company}','');
                     }
                     
                     
                      try{ 
                       replacedname1 = replacedname1.Replace('{!type}',dummy.TicketTypes__r.Ticket_Category__c);
                       } catch(exception ed){
                       replacedname1 = replacedname1.Replace('{!type}','');
                     }
                     
                     
                     
                     
                      try{ 
                       replacedname1 = replacedname1.Replace('{!ordertype}',dummy.Payment_Type__c);
                       } catch(exception ed){
                       replacedname1 = replacedname1.Replace('{!ordertype}','');
                     }
                     
                       try{ 
                       replacedname1 = replacedname1.Replace('{!discount}',dummy.DiscountValue__c);
                       } catch(exception ed){
                       replacedname1= replacedname1.Replace('{!discount}','');
                     }
                     
                     
                      try{ 
                       replacedname1= replacedname1.Replace('{!promo}',dummy.Promocode__c);
                       } catch(exception ed){
                       replacedname1= replacedname1.Replace('{!promo}','');
                     }
                     
                     
                      try{ 
                       replacedname1= replacedname1.Replace('{!originolant}',string.valueOf(dummy.Ticket_Amount__c));
                       } catch(exception ed){
                       replacedname1= replacedname1.Replace('{!originolant}','');
                     }
                    
                    
                    try{ 
                       replacedname1= replacedname1.Replace('{!afterdis}',string.valueOf(dummy.TicketAmount__c));
                       } catch(exception ed){
                       replacedname1= replacedname1.Replace('{!afterdis}','');
                     }
                    
                    
                     
                     
                      try{ 
                       replacedname1 = replacedname1.Replace('{!organizerName}',dummy.Event__r.OrganizerId__c);
                     } catch(exception ed){
                     replacedname1 = replacedname1.Replace('{!organizerName}','');
                     }
                     
                    try{ 
                     replacedname1 = replacedname1.Replace('{!ticketName}',dummy.TicketTypes__r.TT_Name__c);
                     } catch(exception ed){
                     replacedname1 = replacedname1.Replace('{!ticketName}','');
                     }
                     
                      try{ 
                      replacedname1 = replacedname1.Replace('{!eventLocation}',dummy.Event__r.EV_HostingLocation__c);
                      } catch(exception ed){
                         replacedname1 = replacedname1.Replace('{!eventLocation}','');
                      }
                     
                     
                     try{ 
                      replacedname1 = replacedname1.Replace('{!eventAdd1}',dummy.Event__r.EV_HistingAddr1__c);
                      } catch(exception ed){
                      replacedname1 = replacedname1.Replace('{!eventAdd1}','');
                      }
                     try{ 
                     replacedname1 = replacedname1.Replace('{!eventCity}',dummy.Event__r.AS_HostingCity__c);
                     } catch(exception ed){
                      replacedname1 = replacedname1.Replace('{!eventCity}','');
                     }
                     
                     try{ 
                     replacedname1 = replacedname1.Replace('{!eventState}',dummy.Event__r.EV_HostingStateNew__c);
                     } catch(exception ed){
                        replacedname1 = replacedname1.Replace('{!eventState}','');
                     }
                     
                     try{ 
                      replacedname1 = replacedname1.Replace('{!EventZip}',dummy.Event__r.EV_HostingZipcode__c);
                    } catch(exception ed){
                      replacedname1 = replacedname1.Replace('{!EventZip}','');
                    }
                    
                    try{ 
                     replacedname1 = replacedname1.Replace('{!userEmail}',dummy.Email__c);
                     } catch(exception ed){
                     replacedname1 = replacedname1.Replace('{!userEmail}','');
                     }
                     
                     try{ 
                     replacedname1 = replacedname1.Replace('{!eventName}',dummy.Event__r.EV_Title__c);
                     } catch(exception ed){
                     replacedname1 = replacedname1.Replace('{!eventName}','');
                     }
                     
                     try{ 
                     replacedname1 = replacedname1.Replace('{!orderNumber}',dummy.customer_key__r.Name);
                     } catch(exception ed){
                      replacedname1 = replacedname1.Replace('{!orderNumber}','');
                     
                     }
                     try{
                       replacedname1 = replacedname1.Replace('{!peoplenumber}',partiattendPeople);
                     }catch(exception exb){
                      replacedname1 = replacedname1.Replace('{!peoplenumber}','');
                     }
                     
                     try{
                      replacedname1 = replacedname1.Replace('{!question}',questionpeople);
                     }catch(exception exb){
                      
                       replacedname1 = replacedname1.Replace('{!question}','');
                     }
                     
                     Datetime myDatetime10 = dummy.createddate;
                     String myDatetimeStr10 = myDatetime10.format('MM-dd-yyyy hh:mm a');
                     try{
                      replacedname1 = replacedname1.Replace('{!orderDate}',myDatetimeStr10 );
                     }
                     catch(exception exb){
                      replacedname1 = replacedname1.Replace('{!orderDate}','');
                     }
                     
                     Date myDatetime12 = dummy.Event__r.EV_StartDate__c;
                     String myDatetimeStr12 = myDatetime12.format();
                     
                     Date myDatetime13 = dummy.Event__r.EV_EndDate__c;
                     String myDatetimeStr13 = myDatetime13.format();
                     try{
                      replacedname1 = replacedname1.Replace('{!eventDate}',myDatetimeStr12 +' '+dummy.Event__r.StartTime__c+'-'+myDatetimeStr13 +' '+dummy.Event__r.EV_EndTime__c);
                     }
                     catch(exception exb){
                      replacedname1 = replacedname1.Replace('{!eventDate}','');
                     }
                     
                     
                    LIST<String> toAddresses = new LIST<String>();  
                      
                     toAddresses.add(dummy.Email__c);
                     //  toAddresses.add('phanich8@gmail.com');
                     // ccAddresses.add(dummy.Event__r.owner.userName);
                     //ccAddresses.add(toAddresses);
                      
                     
                     Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
                     email1.setSubject('Order Payment Approved for '+dummy.Email__c);
                     if( Org != null){  
                       email1.setOrgWideEmailAddressId(Org.id);
                     }
                     // Set Attachment 
                     
                      PageReference pdf = Page.tickettemplate;
                      pdf.getParameters().put('id',dummy.id);   
        
                      Blob body;
                      
                      body = pdf.getContent();
                          
                    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                    attach.setContentType('application/pdf');
                    attach.setFileName('Ticket.pdf');
                    attach.setInline(false);
                    attach.Body = body;
                    email1.setFileAttachments(new Messaging.EmailFileAttachment[]{attach}); 
                    email1.setHtmlBody(replacedname1);    
                    email1.setToAddresses(toAddresses); 
                      

                    system.debug('111111111 '+replacedname1);          
                    EmailsList2.add(email1);
                    system.debug('222222222 '+EmailsList2);
                }
                catch(exception ex){}
                if(EmailsList.size()>0){  
                    Messaging.sendEmail(EmailsList);
                    Messaging.sendEmail(EmailsList2);
                }
            }      
            database.update(eamids,false);    
        }
        else if(statusvalue=='Not Paid'){
            Dummy.Payment_Status__c = 'Not Paid';
            Dummy.TicketAmount__c = checkamount;
            Dummy.Check_number__c = checknumber;
            for(Event_Attendee_Mapping__c eamid:eamids)
            {
             eamid.Paid__c = false;                 
            }       
            database.update(eamids,false);            
        }
        else{
            Dummy.Payment_Status__c = 'Cancelled';
           // database.delete(eamids);  
        }
        update Dummy;
        statuschange=false;
        customerreport();
        pagereference pg= new pagereference('/apex/BL_Registrations_Information?id='+eventid);    
        pg.setRedirect(true);   
       }
       catch(exception ex){}
        return null; 
    }    
    
     public PageReference cancel(){
        completegrid=true;
        primarygrid=false;
        statuschange=false;
        pagereference pg= new pagereference('/apex/BL_Registrations_Information?id='+eventid);
       
        return pg;
    }
    
    public List<Dummay__c> dummieslist {get;set;}
    
    public PageReference ExportSummaryReportasCSV(){
    try{
     dummyforexport = new List<Dummay__c>();
     dummieslist = new List<Dummay__c>();  
     string listQuery;
      Date startdate=dt.Start_Date__c;
      Date enddate=dt.End_Date__c;
     if(dt.Start_Date__c ==Null && dt.End_Date__c ==Null){
     if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
        listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,IndividualAmount__c FROM Dummay__c WHERE Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
        CSVContentType = 'text/csv#Registration_Details.csv';  
      
     }
     else{
        listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,IndividualAmount__c FROM Dummay__c WHERE Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true AND TicketTypes__r.Ticket_Category__c = \''+selectedoption+ '\'ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
        CSVContentType = 'text/csv#' + selectedoption + '_Registration_Details.csv';   
       
     }
     }else{
        if(selectedoption  == 'ALL' || selectedoption  == '' || selectedoption  == null){
        listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,IndividualAmount__c FROM Dummay__c WHERE Update_with_created_date__c >=: startdate  AND Update_with_created_date__c <=: enddate AND Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
        CSVContentType = 'text/csv#Registration_Details.csv';  
      
     }
     else{
        listQuery ='select id,customer_key__r.Name,customer_key__r.Total_Amount__c,Check_number__c,customer_key__r.Ticket_Types__c,TicketTypes__r.TT_TicketType__c,First_Name__c,Last_Name__c,Email__c,Company__c,Phone__c,Payment_Type__c,TicketTypes__r.TT_Name__c,TicketTypes__r.User_Type__c,TicketAmount__c,Payment_Status__c,Registered_Date__c,TicketTypes__r.EV_id__r.Attendee_Types__c,TicketTypes__r.Ticket_Category__c, CreatedDate, DiscountValue__c, Ticket_Amount__c, LastModifiedDate,IndividualAmount__c FROM Dummay__c WHERE Update_with_created_date__c >=: startdate  AND Update_with_created_date__c <=: enddate AND Event__r.id = \''+eventid+ '\'AND customer_key__c != Null AND TicketTypes__c != Null AND customer_key__r.Isinserted__c = true AND TicketTypes__r.Ticket_Category__c = \''+selectedoption+ '\'ORDER BY '+sortField+' '+sortDir +' NULLS LAST';
        CSVContentType = 'text/csv#' + selectedoption + '_Registration_Details.csv';   
       
     }
     }
     try{
        dummyforexport = dataBase.Query(listQuery); 
     }
     catch(exception e){}                 
     list<Dummay__c> bn = new list<Dummay__c>();
     for(Dummay__c s: dummyforexport)
     {    
      s.First_Name__c = escape(s.First_Name__c);
      s.Last_Name__c = escape(s.Last_Name__c);
      s.Company__c = escape(s.Company__c);
      s.TicketTypes__r.TT_Name__c = escape(s.TicketTypes__r.TT_Name__c);
      s.customer_key__r.Ticket_Types__c = escape(s.customer_key__r.Ticket_Types__c);
      s.Phone__c = escape(s.Phone__c);
      s.DiscountValue__c = escape(s.DiscountValue__c);
      s.Check_number__c = escape(s.Check_number__c);
      bn.add(s);
     }
     dummieslist.addAll(bn);       
     }catch(exception ex){}            
     pagereference pg = page.ExportRegistrationsasCSV;
     return pg;
    }
    
    
    
    
    
    
    
    public PageReference ExportReportasCSV(){
      return null;
    }
    
    public string escape(string s){
        if(s != null && s.contains(',')){  
            s=s.replaceAll(',','');
        } 
        return s;
    }  
    
    
    
    public AggregateResult[] res{get;set;}
    public Integer TotalAmountg{get;set;}
    public Integer TotalccAmountg{get;set;}
    public Integer TotalCheckAmountg{get;set;}
    public Integer TotalInvoiceAmountg{get;set;}
    
    public void amountgenerated()
    {
     Date startdate=dt.Start_Date__c;
     Date enddate=dt.End_Date__c;
     onsel=true;
     oncons=false;
     AggregateResult[] res1 = [SELECT SUM(IndividualAmount__c) total 
                                     FROM Dummay__c 
                                     WHERE (Update_with_created_date__c >=: startdate 
                                     AND Update_with_created_date__c <=: enddate) 
                                     AND Event__r.id =: eventid 
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
          Object sumAmount = res1[0].get('total');
          TotalAmount=Integer.ValueOf(sumAmount);   
          system.debug('bbbbbbbbbbbbbbbbbbbbbb'+TotalAmount);
                                     
      AggregateResult[] res2 = [SELECT SUM(IndividualAmount__c) total1 FROM Dummay__c 
                                     WHERE (Update_with_created_date__c >=: startdate  
                                     AND Update_with_created_date__c <=: enddate) 
                                     AND Event__r.id =: eventid
                                     AND Payment_Type__c = 'Credit Card' 
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount1 = res2[0].get('total1');
        TotalCCAmount=Integer.ValueOf(sumAmount1);
        system.debug('aaaaaaaaaaaaaaaaaaaaa'+TotalCCAmount);
        
      AggregateResult[] res3 = [SELECT SUM(IndividualAmount__c) total2 FROM Dummay__c 
                                     WHERE (Update_with_created_date__c >=: startdate  
                                     AND Update_with_created_date__c <=: enddate) 
                                     AND Event__r.id =: eventid
                                     AND Payment_Type__c = 'Check'
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount2 = res3[0].get('total2');
        TotalCheckAmount=Integer.ValueOf(sumAmount2);
        system.debug('cccccccccccc'+TotalCheckAmount);
        
     AggregateResult[] res4 = [SELECT SUM(IndividualAmount__c) total3 FROM Dummay__c 
                                      WHERE (Update_with_created_date__c >=: startdate  
                                     AND Update_with_created_date__c <=: enddate) 
                                     AND Event__r.id =: eventid 
                                     AND Payment_Type__c = 'Invoice'  
                                     AND customer_key__c != Null 
                                     AND TicketTypes__c != Null
                                     AND Payment_Status__c != 'Cancelled'
                                     AND customer_key__r.Isinserted__c = true ];
        Object sumAmount3 = res4[0].get('total3');
        TotalInvoiceAmount=Integer.ValueOf(sumAmount3);
         system.debug('dddddddddddddddd'+TotalInvoiceAmount);
       customerreport();      
       // ExportSummaryReportasCSV();
       // export();
    }
    
}