public without sharing class  BLN_AttendeeDetailReportCon{
    
/***********************************************************************************************
*   Controller Name : BLN_AttendeeDetailReportCon
*   Date            : 10/31/2014
*   Author          : Manasa Gandham
*   Purpose         : This class is to display the Attendee Detail Report
*   Change History  : 10/31/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  10/31/2014            Manasa Gandham                  To Create Page
*  12/15/2015            Vineel                          Server Side Pagination
**************************************************************************************************/

public date edte{get;set;}
    public List<Reg_Setting__c> RegList{get;set;}
    public date sdte{get;set;}
    public date edte1{get;set;}
    public date sdte1{get;set;}
    public string contentHiding {get;set;}
    public BLN_Ticket_DAO ticketdaoforattendee {get;set;}
    public String selectedTicketName{get; set;}
    public LIST<SelectOption> ticketNames{get; set;}
    //Process to show union of attendee settings columns for report
    Public BLN_AttendeesController attendeeCon{get;set;}
      public List<Reg_Setting__c> rgListForReport{get;set;}
      
      public transient Map<Id,String> tagsmap1{get;set;}
     public transient Map<Id,String> tickettagsmap1{get;set;}
    
    public BLN_Reg_Settings_DAO regSetClass{get;set;} 
    
    public Map<String,String> participantmap{get;set;}         
    public List<ticket__c> Tlist{get;set;}     
        
    public BLN_AttendeeDetailReportCon(){
    try{
       EventDates= new BLN_Event__c();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){ 
            selectedEvent= k.getValue();
            //displayAttendeesInDetail(); 
            
        }
         ticksList=new LIST < Ticket__c >();
        TList=new List<ticket__c>();
          TList=[select id,name,item_pool__r.item_type__r.name,item_pool__r.item_type__c,item_pool__r.item_pool_name__c,item_pool__c from Ticket__c where event__c= : selectedEvent and Ticket_Status__c='Booked'];
            
        ticketNames= new LIST<SelectOption>();
        ticketNames.add(new SelectOption('All','All'));
        string tic='';
        for(ticket__c t : TList){
            if(!tic.contains(t.item_pool__c)){
            tic+=t.item_pool__c;
            ticketNames.add(new SelectOption(t.item_pool__r.item_pool_name__c, t.item_pool__r.item_pool_name__c));
            } 
        }
        selectedTicketName= 'All';
        
        BLN_TicketTypeLabelCon label=new BLN_TicketTypeLabelCon();
          RegList=new List<Reg_Setting__c>();
          RegList=label.ticketTypeLabelNames(selectedEvent);
        
        displayAttendeesInDetail();
      //  showColumns();
        
         participantmap=new Map<String,String>();
            for(BLN_Participant_Role__c participantrole:[select id,name,Participant_Name__c,Participant_Name__r.BLN_TKT_profile__r.BLN_GN_User__c from BLN_Participant_Role__c where BLN_Events__c=:selectedEvent and Participant_Name__r.BLN_TKT_profile__r.BLN_GN_User__c != null]){
            HoldParticpantRole(participantrole);        
            }
            }catch(exception ex){}
    }
    
    //Counting no.of exhibitors
    public integer trackedAttendees{get;set;}
    
    //Counting no.of exhibitors
    public integer trackedExhibitors{get;set;}
    
    //Counting no.of Sponsors
    public integer trackedSponsors{get;set;}

    //Counting no.of Speakers
    public integer trackedSpeakers{get;set;}

    //Storing total badges printed
    public integer totalBadgePrint{get;set;}
    
    //Storing total checkedIn attendees
    public integer totalCheckIns{get;set;}
    
    public integer matchLeadBuyerCount{get;set;}
    public integer matchLeadSellerCount{get;set;}
    public integer totalCheckOuts{get;set;}
    public integer totalBadgeNotPrint{get;set;}
   
    
    @Readonly
    @RemoteAction
     public static BLN_RegDashBoardInfo allstats(String eventid){
         //Statistics
          BLN_RegDashBoardInfo stats=new BLN_RegDashBoardInfo(eventid);
          
          return stats;
    }
    
    public void HoldParticpantRole(BLN_Participant_Role__c participantrole){
        
        if(participantmap.containsKey(participantrole.Participant_Name__r.BLN_TKT_profile__r.BLN_GN_User__c)){
        String text=participantmap.get(participantrole.Participant_Name__r.BLN_TKT_profile__r.BLN_GN_User__c);
        if(text!=participantrole.name)
        participantmap.put(participantrole.Participant_Name__r.BLN_TKT_profile__r.BLN_GN_User__c,text+','+participantrole.name);
        }
        else{
        participantmap.put(participantrole.Participant_Name__r.BLN_TKT_profile__r.BLN_GN_User__c,participantrole.name);
        }   
        
        
    }   
    
    
    
    //Display company name wrt uc role
    public String pCompName{get; set;}   
    
    public BLN_Event__c EventDates{get; set;}   
    public BLN_UtillDisplayLinks   myticket { get; set; }
    public BLN_AttendeeDetailReport_BAL attendeeDetailReportBAL{get; set;}
    public Integer questionNumber{get; set;}
    public Integer answerNumber{get; set;}
    
    public void displayAttendeesInDetail(){
    //system.debug('tttttt');
    //process of showing company name based on uc role
        //BLN_MyticketsCon myTicBal=new BLN_MyticketsCon();
        //pCompName=myTicBal.pcompanies;
        
        attendeeDetailReportBAL= new BLN_AttendeeDetailReport_BAL();
        listOfListTickets= new LIST<LIST<BLN_AttendeeDetailReport_BAL.AttendeeDetailInner>>();
        datetime enddate;
        if(edte!=null){
        //edte1=Date.newInstance(edte.year(),edte.month(),edte.day());
        edte1=date.valueof(edte);
        }
        if(sdte!=null){
        //sdte1=Date.newInstance(sdte.year(),sdte.month(),sdte.day());
        sdte1=date.valueof(sdte);
        }
       
        //system.debug('tttttgggg'+edte);
        // system.debug('tttttgggg'+sdte); 
        
        //EventDates.End_Date__c=edte ;
       // EventDates.Start_Date__c = sdte;
        //enddate=EventDates.End_Date__c;
        if(edte1 != null){
        
        enddate=edte1.addDays(1);
        }
        //listOfListTickets= attendeeDetailReportBAL.ticketsListForEvent(selectedEvent, sdte1,enddate, SearchString);
        
        tagsmap1=new Map<Id,String>();
     tickettagsmap1=new  Map<Id,String>();
        
        //get all tags
         for(Hash_Tag__c itptj:[select id,name,RowId__c,Tag_Text__c,Event__c,Table_Name__c from Hash_Tag__c where Event__c=:selectedEvent and Table_Name__c='Item_Pool__c']){
            HoldHashTagPool(itptj);
         }
         //
         //get all tickets tag map
         for(Hash_Tag__c itptj:[select id,name,RowId__c,Tag_Text__c,Event__c,Table_Name__c from Hash_Tag__c where Event__c=:selectedEvent and Table_Name__c='Ticket__c']){
          HoldHashTagTicket(itptj);  
         }
    }
    public void HoldHashTagPool(Hash_Tag__c itptj){
        
            if(tagsmap1.containsKey(itptj.RowId__c)){
            String text=tagsmap1.get(itptj.RowId__c);
            if(text!=itptj.Tag_Text__c)
            tagsmap1.put(itptj.RowId__c,text+' '+itptj.Tag_Text__c);
            }
            else{
            tagsmap1.put(itptj.RowId__c,itptj.Tag_Text__c); }
        
    }
    
    public void HoldHashTagTicket(Hash_Tag__c itptj){
    if(tickettagsmap1.containsKey(itptj.RowId__c)){
            String text=tickettagsmap1.get(itptj.RowId__c);
            tickettagsmap1.put(itptj.RowId__c,text+' '+itptj.Tag_Text__c);
            }
            else{
            tickettagsmap1.put(itptj.RowId__c,itptj.Tag_Text__c); }   
        
    }
     //method to display report columns based on attendee settings
 public LIST<BLN_Attendees_BAL.inncls> getTickets{get;set;}
  public BLN_Attendees_BAL attBal {get;set;}
  public List<Reg_Setting__c> attendeeSettingList {get;set;}
    public transient List<Reg_Setting__c> regsetTickType {get;set;}
  public string checkUnionForAttRep{get;set;}
 
  
  public void showColumns(){
     getTickets= new LIST<BLN_Attendees_BAL.inncls>();
        regSetClass=new BLN_Reg_Settings_DAO();
         attBal = new BLN_Attendees_BAL();
        getTickets =  attBal.getAllTickets(userInfo.getUserid(),selectedEvent);
        System.debug('CCCCCCCCCCC::::'+getTickets);
            
        Set<Id> bookedItm=new set<id>();
        Set<Id> bookedItmPool=new set<id>();
        for(BLN_Attendees_BAL.inncls tc1 :getTickets){
            bookedItm.add(tc1.ticket.item__r.id);
            bookedItmPool.add(tc1.ticket.item_pool__r.id);
        }
        set<id> allids=new set<id>();
        allids.addAll(bookedItm);
        allids.addAll(bookedItmPool);        
        
        List<Reg_Setting__c> attSetUpDataList =new List<Reg_Setting__c>();
            attSetUpDataList= regSetClass.bookedRegSettingList(allids,selectedEvent);
             
        BLN_Displaysettings_BAL   blnregsetbal = NEW BLN_Displaysettings_BAL  ();
            regsetTickType=new List<Reg_Setting__c>();
            regsetTickType=blnregsetbal.attendeeSetUpList(selectedEvent);
            
             
            
            for(BLN_Attendees_BAL.inncls tc :getTickets){ 
                //Code for reports columns based on attendee settings
                List<BLN_Attendees_BAL.inncls>  attendeeList = new List<BLN_Attendees_BAL.inncls>();
                Map<Id,List<Reg_Setting__c>> attsetMap=new Map<Id,List<Reg_Setting__c>>();
               
                attendeeList.add(tc);
                
                //getting required attendee settings            
                if(attendeeList.size()>0){
                    attsetMap.put(tc.ticket.Event__c,attSetUpDataList);
                    if(attsetMap.containsKey(tc.ticket.Event__c)){                        
                        attendeeSettingList=new List<Reg_Setting__c>();
                        attendeeSettingList=attsetMap.get(tc.ticket.Event__c); }            
                }
                 System.debug('AAAAAAAA:'+attendeeSettingList);
           
                //restricting columns of report
                checkUnionForAttRep='';
            for(Reg_Setting__c rgs : attendeeSettingList){
                if(rgs.Included__c==true){
                    checkUnionForAttRep+=rgs.Table_Name__c+rgs.Column_Name__c+','; }
            }
            System.debug('BBBBBBBBBBBB:'+checkUnionForAttRep);
         
                          
        }
 }
    
    public transient List<Ticket__c> xportList{get;set;}
    public pagereference exportAttendeesInDetail(){       
        
        //Getting max no. of rows for questions and answers
        integer i=0;
        integer j=0;
        integer max=0;
        
        i=attendeeDetailReportBAL.maxQuestionItem;
        j=attendeeDetailReportBAL.maxQuestionItemPool;
        System.debug('uuuuuuu'+i);
        System.debug('vvvvvvv'+j);
        
        if(max<i){
            max=i;
        }
        
        if(max<j){
            max=j;
        }
                
        xportList=new List<Ticket__c>();
        xportList=[select id,name from Ticket__c limit :(max)];
        
        System.debug('wwwwwwwwwwww'+max);
        System.debug('xxxxxxxxxxxxx'+xportList.size());
        
       // showColumns();
       // displayAttendeesInDetail();
        pageReference pg = page.BLN_ExportAttendeeDetail;
        pg.setRedirect(true);
        return pg;

}
 public BLN_EventDetails eventInfo{get; set;}
public pagereference printAttendeesInDetail(){
BLN_Event_DAO eventDAOClass= new BLN_Event_DAO();
        eventInfo= new BLN_EventDetails();
        eventInfo.eventDetailsToDisplay(selectedEvent);
        
       // showColumns();
         displayAttendeesInDetail();
         pageReference pg = page.BLN_PrintAttendeeDetail;
        return pg;
}  


    public transient LIST<LIST<BLN_AttendeeDetailReport_BAL.AttendeeDetailInner>> listOfListTickets{get; set;}
    
    public String SearchString{get; set;}

    public String SelectedEvent{get; set;}
    public boolean isEventAdmin{get;set;}
    public boolean isBoothadmin{get;set;}
    public BLN_Event__c se {get;set;}   
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
    myticket.isAttendeeDetailReportPage='active';
    myticket.tablabel='Attendee Detail Report';
    myticket.EventId = selectedEvent ;
     
   try{
     myticket.eventName=se.NAme;
    }catch(exception e){}
     myticket.userPermissions(userInfo.getUserId(),selectedEvent);
     
     try{
   //  showColumns();
     }catch(exception e){}
     
     }catch(exception ex){}
        return null;
    }
   
    //Downloading two sheets in exporting
    public String xlsHeader {
        get { return '<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?>';}
     } 
     
     
     
   
/*******************************Added for server side pagination *******************************/
    
       
    public ApexPages.StandardSetController setCon {get;set;}
    public List<Ticket__c> RecList{get;set;}
     public string dataTableJson {get;set;}
     public list<ticket__c>  ticksList{get;set;}
     public LIST < BLN_AttendeeDetailReport_BAL.AttendeeDetailInner > ListTickets{get;set;}
     public void processData() {

        String fdate = ApexPages.currentPage().getParameters().get('fdate');
        String tdate = ApexPages.currentPage().getParameters().get('tdate');
        String searchKey = ApexPages.currentPage().getParameters().get('searchKey');
        String selectticket=    ApexPages.currentPage().getParameters().get('selectticket');

        Date FromDate = null;
        Date ToDate = null;
        if (fdate != null && fdate != '' && tdate != null && tdate != '') {
            FromDate = Date.parse(fdate);
            ToDate = Date.parse(tdate);
            ToDate = ToDate.AddDays(1); 
        }

        BLN_Ticket_DAO ticketsDAOClass = new BLN_Ticket_DAO();
        ticksList = new LIST < Ticket__c > ();
        if(selectticket==null || selectticket=='' || selectticket=='All'){
        ticksList = ticketsDAOClass.ticketsListForEvent(SelectedEvent, FromDate, ToDate, searchKey);
        }else{
        ticksList = ticketsDAOClass.ticketsListForEvent(SelectedEvent, FromDate, ToDate, searchKey,selectticket);
        }
        setcon = new ApexPages.StandardSetController(ticksList);

        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start = Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        System.debug('start value: ' + start);

        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        System.debug('size value : ' + size);
        setCon.setPageSize(3);

        Integer noOfRecords = setCon.getResultSize();
        if (size == -1) {
            size = noOfRecords;
        }
        setCon.setPageSize(size);
        //set pagenumber
        setCon.setPageNumber((start / size) + 1);
        RecList = setCon.getRecords();
        //  List<SubWrapper> TicketList1 = new List<SubWrapper>();
        // create a sub wrapper
        //for(Ticket__c ac: RecList){
        attendeeDetailReportBAL = new BLN_AttendeeDetailReport_BAL();
        ListTickets = new LIST < BLN_AttendeeDetailReport_BAL.AttendeeDetailInner > ();
        System.debug('AAAAAAAA:' + ListTickets.size());
        ListTickets = attendeeDetailReportBAL.ticketsListForEvent(RecList, selectedEvent, FromDate, ToDate, SearchString);
        //TicketList1.add(new SubWrapper(ac));
        //}
        DataTableWrapper datawrap = new DataTableWrapper(0, noOfRecords, noOfRecords, ListTickets);
        dataTableJson = JSON.serialize(datawrap);
    }


    /***********************sub wrapper****/


 public class DataTableWrapper {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
        public boolean selected {get;set;}
        public Integer draw;
        public Integer recordsTotal;
        public Integer recordsFiltered;
        public List < BLN_AttendeeDetailReport_BAL.AttendeeDetailInner > data;
        //  public List<Contact> allids;

        public DataTableWrapper(Integer draw, Integer recordsTotal, Integer recordsFiltered, list < BLN_AttendeeDetailReport_BAL.AttendeeDetailInner > data) {
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered;
            this.data = data;
          
        }
     
    } 
    
    
    public List<Ticket__c>  exportTickets1{get;set;}
  public Pagereference exportselected(){
        ticketdaoforattendee = new BLN_Ticket_DAO();
        
        String fdate=apexpages.currentpage().getparameters().get('fromdate');
        String tdate=apexpages.currentpage().getparameters().get('todate');
        String searchKey=apexpages.currentpage().getparameters().get('search');

         Date FromDate=null;
         Date ToDate=null;
         if(fdate!=null&&fdate!=''&&tdate!=null&&tdate!=''){
            FromDate=Date.parse(fdate);
            ToDate=Date.parse(tdate);
            ToDate = ToDate.AddDays(1);
         }
        
             
        BLN_Ticket_DAO ticketsDAOClass = new BLN_Ticket_DAO();
        LIST < Ticket__c > ticksList = new LIST < Ticket__c > ();
        ticksList = ticketsDAOClass.ticketsListForEvent(SelectedEvent, FromDate, ToDate, '');
        attendeeDetailReportBAL = new BLN_AttendeeDetailReport_BAL();
        ListTickets = new LIST < BLN_AttendeeDetailReport_BAL.AttendeeDetailInner > ();
        ListTickets = attendeeDetailReportBAL.ticketsListForEvent(ticksList, selectedEvent, FromDate, ToDate, '');
        
        string attdetquery =  'SELECT ID,Custom_Barcode__c,item_pool__c,Event__r.Time_Zone__c,event__c,(select id,name from Attachments),item__r.payment__c,order__r.createdDate,order__r.NAME,Order__r.BLN_TKT_profile__r.Last_Name__c,Order__r.BLN_TKT_profile__r.First_Name__c,Badge_ID__c,Item_Pool__r.Item_Pool_Name__c,Item_Pool__r.Item_Type__r.name,Item_Type__r.Badgable__c, Name,Tstatus_Id__r.Tstatus_name__c,Tstatus_Id__c, Tag_No__c, order__c, item__c, item__r.item_Name__c , Item_Type__r.name, Ticket_Status__c, Parent_ID__c, Item_Pool__r.Badgable__c, Badge_Label__c,item__r.Ticket_Settings__c, item__r.Item_Pool__r.Item_Pool_Name__c, item__r.item_type__r.Name,'    
                          +'(SELECT Id,ticket__r.TKT_profile__r.id,Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,UAnswer_Text_Update__c,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c, Item_Question__r.item_pool__r.item_type__r.name,Item_Question__r.Question_Level__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name FROM User_Answers__r order by item_question__r.question__r.question_order__c asc),'
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
                          +'tkt_Profile__r.Billing_Address__r.Country__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.PoBox__c,tkt_Profile__r.Billing_Address__r.State__r.Long_Name__c,tkt_Profile__r.Billing_Address__r.ZipCode__c'
                                          
                          +' FROM Ticket__c' 
                          +' WHERE Event__c =\''+ SelectedEvent+'\''
                          +' AND Ticket_Status__c = \'Booked\''
                          +' AND (Item_Type__r.Badgable__c != \'N - No Badge\' OR Item_Pool__r.Badgable__c != \'N - No Badge\')';
               if(fdate!=null&&fdate!=''&&tdate!=null&&tdate!=''){           
                   attdetquery+=' AND Order__r.CreatedDate >=\''+ FromDate+'\''
                          +' AND Order__r.CreatedDate <=\''+ ToDate+'\'';
                }            
                          attdetquery+=' Order By Order__r.CreatedDate ASC';
        
        BLN_Event__c eve =[select time_zone__c from BLN_Event__c where id =:selectedEvent];
        
         if(ListTickets.size()>1000){
       
            Id batchInstanceId = Database.executeBatch(new BLN_ExportAttendeereport(attdetquery,eve.time_zone__c,selectedEvent,FromDate,ToDate), 1000);
            return new Pagereference('/BLN_AttendeeReportCheckEmail');
         }
    else {
        return null; 
    }
        
        }
        
     //*******************************Added for server side pagination *******************************//   
       
}