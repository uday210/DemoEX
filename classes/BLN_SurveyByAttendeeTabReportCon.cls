public class  BLN_SurveyByAttendeeTabReportCon{ 
    public BLN_UtillDisplayLinks myticket{get;set;}
    public PageReference hideEventsTab() {
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
     if(k!=null){
      selectedEvent = k.getValue();
       }
       

     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     BLN_Event__c  se = new BLN_Event__c  ();
      try{
    se = blneventdetailbal.eventdetails(selectedEvent );
     }catch(exception e){}

     myticket = new BLN_UtillDisplayLinks();

        myticket.isReportsPageExpand='expand';
     myticket.isSurveyQuestionReportsPageExpand='expand';
        myticket.isSurveyByAttendeeReportPage='active';
        myticket.tablabel='Survey Question Report';
        myticket.EventId = selectedEvent ; 

   try{
     myticket.eventName=se.NAme;
     myticket.userPermissions(userInfo.getUserId(),selectedEvent);
    }catch(exception e){}


        return null;
    }


    public BLN_SurveyByAttendeeTabReportCon() {
    EventDates= new BLN_Event__c();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){
            selectedEvent= k.getValue();
        }
        ticketsList= new LIST<Ticket__c>();
    }


public BLN_Event__c EventDates{get;set;}
public string selectedEvent{get;set;}
public BLN_SurveyQuestionsReportCon_BAL surveyQuestionBAL {get;set;} 
  
/*************************************************************************************************

                    SERVER SIDER PAGINATION FOR "Survey By Attendees" 
                    
**************************************************************************************************/
    public BLN_Ticket_DAO ticketDAOClass{get;set;}
    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> surveyAttendeeInnerList{get; set;}
    Public ApexPages.StandardSetController setCon {get;set;}
    public List<Ticket__c> RecList{get;set;}
    public string dataTableJson3 {get;set;} 
    public LIST<Ticket__c> ticketsList{get;set;}
    public void processData3() {
        String searchKey = ApexPages.currentPage().getParameters().get('searchKeySBA');   
        ticketDAOClass= new BLN_Ticket_DAO();        
        ticketsList= new LIST<Ticket__c>(); 
        ticketsList= ticketDAOClass.eventBookedTickets(selectedEvent,searchKey);
        system.debug ('surveyslist'+ticketsList.size()); 
        setcon=new ApexPages.StandardSetController(ticketsList);

        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start = Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        System.debug('start value: ' + start);

        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        System.debug('size value : ' + size);
        setCon.setPageSize(10);

        Integer noOfRecords = setCon.getResultSize();
        if (size == -1) {
            size = noOfRecords;
        }
        setCon.setPageSize(size);
        //set pagenumber
        setCon.setPageNumber((start / size) + 1);
        RecList = setCon.getRecords();
        system.debug('sssssss:::'+RecList.size());

        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        surveyAttendeeInnerList= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner>();

        surveyAttendeeInnerList= surveyQuestionBAL.gnUsersForSurvey(selectedEvent,RecList);
        system.debug ('zzzzzzzzzz::'+surveyAttendeeInnerList.size());
        DataTableWrapper3 datawrap = new DataTableWrapper3(0, noOfRecords, noOfRecords, surveyAttendeeInnerList);
        dataTableJson3 = JSON.serialize(datawrap);
         
    }
        
        
        /***********************sub wrapper****/
        
        public class DataTableWrapper3 {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
        public boolean selected {get;set;}
        public Integer draw;
        public Integer recordsTotal;
        public Integer recordsFiltered;
        public List <BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> data;
        //  public List<Contact> allids;
        
            public DataTableWrapper3(Integer draw, Integer recordsTotal, Integer recordsFiltered, list < BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner > data) {
            this.draw = draw;
            this.recordsTotal = recordsTotal;
            this.recordsFiltered = recordsFiltered;
            this.data = data;
        
            } 
       }  
         
        public List<Ticket__c>  exportsurvey3{get;set;}
            public Pagereference exportselected3(){
            return null; 
        } 
        
        public pagereference exportSurveyQuestions2(){ 
            pageReference pg =  new PageReference ('/apex/BLN_SurveyByAttendeeTabExport');
            pg.setRedirect(true);
            pg.getParameters().put('search',apexpages.currentpage().getparameters().get('search'));
            return pg;
        } 
         
        public LIST<user_answer__c> ticketsListUSR{get;set;}
        public list<item_question__c> questionsList{get;set;}
        public pagereference exportSurveyQuestions2batch(){
            String searchKey =  ApexPages.currentPage().getParameters().get('search'); 
            System.debug('sssskkkk:::'+searchKey );  
            ticketsListUSR= new LIST<user_answer__c>();
            questionsList=new list<item_question__c>();
            String wherecondition='';
            if(searchKey!=Null && searchKey!=''){
                wherecondition+=' AND (ticket__r.tkt_profile__r.first_name__c like \'%'+searchKey+'%\' OR ticket__r.tkt_profile__r.last_name__c like \'%'+searchKey+'%\' OR ticket__r.tkt_profile__r.Email__c like \'%'+searchKey+'%\' OR ticket__r.tkt_profile__r.Mobile__c like \'%'+searchKey+'%\' OR  ticket__r.item_pool__r.item_pool_name__c like \'%'+searchKey+'%\' OR uanswer_text_update__c like \'%'+searchKey+'%\' OR item_question__r.question__r.question_text__c like \'%'+searchKey+'%\'  OR item_question__r.question_level__c like \'%'+searchKey+'%\' ) ';
            } 
                          
        string bookedlist='select ticket__r.event__c,ticket__r.item__c,ticket__r.item_pool__c, ticket__r.name,ticket__r.order__r.name, ticket__r.tkt_profile__r.first_name__c,ticket__r.tkt_profile__r.last_name__c,ticket__r.tkt_profile__r.Email__c,ticket__r.tkt_profile__r.Mobile__c,'              
                          +'item_question__r.question_level__c,item_question__r.event__c,item_question__r.item__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__c,item_question__r.item_pool__r.item_pool_name__c,'
                          +'item_question__r.question__c,item_question__r.question__r.id,item_question__r.question__r.answer_type__c,uanswer_text__c,uanswer_text_update__c,'
                          +'item_question__r.question__r.question_text__c,ticket__r.item_pool__r.item_pool_name__c '
                          +' from user_answer__c where ticket__r.event__c= \'' +selectedEvent+'\' and ticket__r.ticket_status__c=\'Booked\' and item_question__r.question_level__c != \'Lead Retrieval\' '
                          +' and Ticket__r.Order__r.Order_Status__c != \'Abandoned\' and Ticket__r.Order__r.Order_Status__c != \'Cancelled\''
                          +wherecondition +' order by ticket__r.order__r.createddate desc limit 50000';
        ticketsListUSR=database.query(bookedlist);
        system.debug ('Sizezzzzzzzzzzz:::'+ticketsListUSR.size());
      
      
         string itmQuestion='select id,name,event__c,item__c,item_pool__c,question_level__c,question__c,question__r.event__c,question__r.question_text__c,question__r.answer_type__c '
                            +'from item_question__c where question__r.Event__c= \'' +selectedEvent+'\' order By question__r.Question_Order__c asc ';
                questionsList=database.query(itmQuestion);
         if(ticketsListUSR.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportSurveyByAttendeeBatch(bookedlist, selectedEvent), 1000);
            return new Pagereference('/BLN_SurveyByAttendeeReportCheckEmail');
         
        } else {
        return null;         

        } 
    }
        
     /*************************************************END PAGINATION*********************************************************/
    public String xlsHeader {
        get {
            String strHeader = '';
            strHeader += '<?xml version="1.0"?>';
            strHeader += '<?mso-application progid="Excel.Sheet"?>';
            return strHeader;
        }
        }   
   
    
}