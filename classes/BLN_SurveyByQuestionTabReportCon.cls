public class  BLN_SurveyByQuestionTabReportCon{ 
     //Downloading two sheets in exporting
    public String xlsHeader{
        get {
            return '<?xml version="1.0"?> <?mso-application progid="Excel.Sheet"?>';
         }
    }
    
    public integer utotalListTemp{get;set;}
    public pageReference questionsGrid(){
        utotalListTemp=0; 
        utotalListTemp=[select count() from user_answer__c where ticket__r.event__c= : selectedEvent and ticket__r.ticket_status__c='Booked' and ticket__r.order__r.order_status__c!='Cancelled' and ticket__r.order__r.Order_status__c!='Abandoned'  and item_question__r.question_level__c != 'Lead Retrieval'];
        return null;
    }
    
    
    public String selectedEvent{get; set;}
    public BLN_UtillDisplayLinks myticket{get;set;}
    public boolean showItemDetails{get;set;}
    public String selectedItemName{get; set;}   
    
    public BLN_SurveyByQuestionTabReportCon(){ 
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){
            selectedEvent = k.getValue();
        }
        showItemDetails = false;
        answerList=new List<user_answer__c>();
        utotalListTemp=0; 
        
    }
    
    public PageReference hideEventsTab() {
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){
            selectedEvent = k.getValue();
        }
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        BLN_Event__c  se = new BLN_Event__c  ();
        try{
            se = blneventdetailbal.eventdetails(selectedEvent);
        }catch(exception e){}
        
        myticket = new BLN_UtillDisplayLinks();        
        myticket.isReportsPageExpand='expand';
        myticket.isSurveyQuestionReportsPageExpand='expand';
        myticket.isSurveyByQuestionReportPage='active';
        myticket.tablabel='Survey By Question Report';
        myticket.EventId = selectedEvent ; 
        try{
            myticket.eventName=se.NAme;
            myticket.userPermissions(userInfo.getUserId(),selectedEvent);
        }catch(exception e){}
        showAllAnsweredQuestions();
        return null;
    }
    
    public  list<ticket__c> ticketlist{get;set;}
    public pagereference showAllAnsweredQuestions(){
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        answedItemQuestionList=new List<Item_question__c>();

        //removing unwanted rows/data for page nation
        List<Item_question__c> questionPGNList=new List<Item_question__c>();
        questionPGNList=surveyQuestionBAL.itemQuestionsBooked(selectedEvent);

        String uniqQuestions='';
        for(Item_question__c pgn1 : questionPGNList){
            if(uniqQuestions.contains(pgn1.question__r.id)==false){
                uniqQuestions+=pgn1.question__r.id+',';
                answedItemQuestionList.add(pgn1);
            }
        }  
        return null;
    }
    
    //Server Side Pagination starting:
    public ApexPages.StandardSetController setCon {get;set;}
    public List<Item_Question__c> RecList{get;set;}
    public string dataTableJson {get;set;}

        
        public  list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> showeachQueSurveList{get;set;}
        public string queName{get;set;}
        public string answerOption{get;set;}
        public integer totalQueWiseCount{get;set;}
        public integer totalQueWiseCountEvent{get;set;}
        public string islevel{get;set;}
        public string isTicketLevel{get;set;}
        public list<item_question__c> checkBoxQA{get;set;}
        public  LIST<responsesInner> responsesInnerListForQuestions{get; set;}
        public BLN_SurveyQuestionsReportCon_BAL surveyQuestionBAL{get; set;}
        public string questionID{get;set;}
        public integer responseSurveyByQuestion{get;set;}
        public BLN_Ticket_Dao ticketDAOClass {get;set;}
        public LIST<user_answer__c> allUAs{get;set;}
        public list<User_Answer__c > ulistone{get;set;}
        
    public PageReference showSurveyInfoForQuestion(){
        system.debug(' QUESTION ID FOR IQ '+questionID+'    selectedEvent '+selectedEvent);
        questionID= ApexPages.currentPage().getParameters().get('questionID');
        string search = apexpages.currentpage().getparameters().get('search');
        System.debug('QQQQQIIIIII:::'+questionID);
        queName='';
        if(questionID!=null && questionID!=''){
        question__c q=[select id,name,Question_Text__c from question__c where id= : questionID and event__c = : selectedEvent limit 1 ];
        queName=q.Question_Text__c ;
        system.debug('queName'+queName);

        answerOption='';
        item_question__c iq=[select id,name,question__r.answer_type__c,question_level__c,item__c,item_pool__c,item__r.item_type__r.name,item_pool__r.item_type__r.name from item_question__c where question__c = : questionID and question__r.event__c = : selectedEvent  limit 1];
        answerOption=iq.question__r.answer_type__c ;
        
        
        List<item_question__c> iqListSize=[select id,name,question__r.answer_type__c,question_level__c,item__c,item_pool__c,item__r.item_type__r.name,item_pool__r.item_type__r.name from item_question__c where question__c = : questionID and question__r.event__c = : selectedEvent];
        System.debug('FFFF11111::'+iqListSize.size());
        totalQueWiseCount=0;
        //List<item_question__c> iqList=new List<item_question__c>();
        //iqList=[select id,name,question_level__c,item__r.id,item__c,item_pool__c,item_pool__r.id,question__c,question__r.id,(select id,name,ticket__r.ticket_status__c,ticket__r.id,uanswer_text__c,item_question__r.question_level__c,ticket__r.parent_id__c from user_answers__r where ticket__r.ticket_status__c='Booked') from item_question__c where question__c = : questionID];

        //totalQueWiseCount=[select count() from user_answer__c where item_question__r.question__c = : questionID and ticket__r.ticket_status__c='Booked'];
        
        Integer UAagg=1;
        UAagg = [Select count() from User_Answer__c where ticket__r.event__c= : selectedEvent and item_question__r.question__c = : questionID and ticket__r.order__r.order_status__c!='Cancelled' and ticket__r.order__r.Order_status__c!='Abandoned' and ticket__r.ticket_status__c='Booked' and item_Question__r.question_level__C!='Lead Retrieval'];
        //for(aggregateResult a:UAagg){
            totalQueWiseCount=UAagg;
        //}
        system.debug('totalQueWiseCount'+totalQueWiseCount);
        totalQueWiseCountEvent=0;
        
        for(item_question__c iqs : iqListSize){
            if(iqs.question_level__c=='Event Level'){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from order__c where events__c = : selectedEvent and order_status__c!='Cancelled' and Order_status__c!='Abandoned'];
            }else if(iqs.question_level__c=='Ticket Level' && iqs.Item__c!=null && iqs.item__r.item_type__r.name!='Package'){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from ticket__c where item__c = : iqs.item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent  and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }else if(iqs.question_level__c=='Ticket Level' && iqs.Item__c!=null && iqs.item__r.item_type__r.name=='Package'){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from ticket__c where item__c = : iqs.item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null  and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }else if(iqs.question_level__c=='Ticket Level' && iqs.Item_pool__c!=null){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from ticket__c where Item_pool__c= : iqs.Item_pool__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null  and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }
        }

        checkBoxQA=new list<item_question__c>();
        checkBoxQA=[select id,name,question_level__c,question__r.id,(select id,name,uanswer_text__c,Item_Question__r.question__r.id,Item_Question__r.question__r.Answer_Type__c from user_answers__r where ticket__r.ticket_status__c='Booked') from item_question__c where question__c= : questionID and question__r.event__c = : selectedEvent];

         showeachQueSurveList= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner>();
        surveyQuestionBAL = new BLN_SurveyQuestionsReportCon_BAL(); 
        
        //getting response
        ticketDAOClass= new BLN_Ticket_DAO();       
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        
        responseSurveyByQuestion=1;
        
        /*string usransstring='';
        ulistone=new list<User_Answer__c >();
        allUAs= new LIST<user_answer__c>();
        allUAs=  [Select id,ticket__r.id from User_Answer__c where ticket__r.event__c= : selectedEvent and item_question__r.question__c = : questionID];
        for(User_Answer__c u :allUAs){
            if(!usransstring.contains(u.ticket__r.id)){
            usransstring+=u.ticket__r.id;
                ulistone.add(u);
            }
        }*/
        
        
        
        
        //responseSurveyByQuestion=ulistone.size(); 
        responseSurveyByQuestion=UAagg ;
        system.debug('UAagg.size()'+UAagg );
        
        surveyQuestionBAL = new BLN_SurveyQuestionsReportCon_BAL();
        responsesInnerListForQuestions=new LIST<responsesInner>();
        //LIST<user_answer__c> userAnswersResponsesForQuestionWise= new LIST<user_answer__c>();
        LIST<aggregateResult> userAnswersResponsesForQuestionWise=new LIST<aggregateResult>();
        //userAnswersResponsesForQuestionWise=[select id,name from user_answer__c limit 10000];
        userAnswersResponsesForQuestionWise= [SELECT COUNT(Id) selCount,UAnswer_Text_Update__c ansType FROM User_Answer__c WHERE Item_Question__r.question__c= : questionID and Item_Question__r.question__r.answer_type__c!='Text' AND Item_Question__r.question__r.answer_type__c!='Paragraph text' AND ticket__r.ticket_status__c='Booked' and ticket__r.order__r.order_status__c!='Cancelled' and ticket__r.order__r.Order_status__c!='Abandoned' GROUP BY UAnswer_Text_Update__c limit 50000];
         
        
        //surveyQuestionBAL.userAnswersQuestionWise(questionID);  

         for(AggregateResult agg: userAnswersResponsesForQuestionWise){
            String ansType= String.valueOf(agg.get('ansType'));
            String countString= String.valueOf(agg.get('selCount'));
            Integer ansCount= Integer.valueOf(countString);
            Decimal percent=0; 
            responsesInnerListForQuestions.add(new responsesInner(ansType,ansCount,percent));
        } 
        showItemDetails= TRUE;
        }
        
        return null;
    }  
    
     public Class responsesInner{
        public String answerType{get; set;} 
        public Integer answerCount{get; set;}
        public Decimal answerPercentage{get; set;}

        public responsesInner(String answerType, Integer answerCount, Decimal answerPercentage){
            this.answerType= answerType; 
            this.answerCount= answerCount;
            this.answerPercentage= answerPercentage;
        }
    }
    
     public pageReference backtoSurveyByQue(){
        showItemDetails=false;
        PageReference pg=new PageReference('/apex/BLN_SurveyByQuestionTab');
        pg.setRedirect(true);
        return pg;
    }
    
   
        
    //Exporting survey By attendee tab
  public  List<Ticket__c> ticCountList{get;set;}
  /*  public PageReference  displaySurveyRepAttendeeData(){

        //Counting question and answers columns
        integer totalColumns=0;
        String eLevel='';
        integer eCount=0;
        for(user_answer__c u : [select id,name,item_question__r.question__r.id from user_answer__c where item_question__r.question__r.event__c = :selectedEvent and item_question__r.Question_level__c='Event Level']){
            if(eLevel.contains(u.item_question__r.question__r.id)==false){
                eLevel=eLevel+u.item_question__r.question__r.id;
                eCount=eCount+1;
            }
        }

        String tLevel='';
        integer tCount=0;
        for(user_answer__c ua : [select id,name,item_question__r.question__r.id,item_question__r.question__r.name from user_answer__c where item_question__r.question__r.event__c = :selectedEvent and item_question__r.Question_level__c='Ticket Level']){
            System.debug('QQQQ:::TTT:::'+ua.item_question__r.question__r.name);
            if(!tLevel.contains(ua.item_question__r.question__r.name)){
                tLevel=tLevel+ua.item_question__r.question__r.name;
                tCount=tCount+1;
            }
        }

        if(eCount>tCount){
            totalColumns=eCount;
        }else{
            totalColumns=tCount;
        }
        System.debug('totalColumns:'+totalColumns);
        System.debug('eCount:'+eCount);
        System.debug('tCount:'+tCount);

        ticCountList=new List<Ticket__c>();
        ticCountList=[select id,name from Ticket__c limit :(totalColumns)];
        return Null;
    }   */ 
        
  /***********************************************************************
  
  QUESTION EXPORT
  
  ***********************************************************************/      
    public Decimal notGivenResponses{get; set;}   
    public Integer totalorders{get;set;}
    public String itemAnswerType{get; set;}
    public string qname{get;set;}
    public String itemId{get; set;}
    public MAP<Id, Item_Question__c> questionsForItemMAP{get; set;}
    public Decimal responseGivenPercent{get; set;}
    public Decimal responseNotGivenPercent{get; set;}
           //For Items
    public  LIST<responsesInner> responsesInnerList{get; set;}
       
    // ========================================base for getting print and export===============================
    public pagereference summaryResponseData(){
        System.debug(selectedQuestion+'::WWWWW::'+selectedQuestion);

        showAttendeeLevelSurvey= FALSE;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();

        responsesInnerList= new LIST<responsesInner>();
        userAnswersList= new LIST<User_Answer__c>();

        LIST<AggregateResult> userAnswersResponses= new LIST<AggregateResult>();
                allResponses= 0;
        bookedTickets= 0;
        notGivenResponses=0;

        totalOrders=1;
        //user answers for single question
        if(string.IsEmpty(selectedQuestion)==false){
        userAnswersResponses= surveyQuestionBAL.userAnswersForItemQuestion(selectedQuestion);
        if(questionsForItemMAP!=null && questionsForItemMAP.get(selectedQuestion)!=null){
        itemAnswerType= questionsForItemMAP.get(selectedQuestion).Question__r.Answer_Type__c;

        //if(selectedQuestion!= null || selectedQuestion!='')
        selectedItemName= questionsForItemMAP.get(selectedQuestion).item__r.item_name__c;
        id itmOfid=questionsForItemMAP.get(selectedQuestion).item__r.id;
        qname=questionsForItemMAP.get(selectedQuestion).Question__r.Question_Text__c;

        System.debug('IIIIIIII:'+questionsForItemMAP.get(selectedQuestion).question__r.id);

        if(questionsForItemMAP.get(selectedQuestion).question__r.id!=Null){
            if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Event Level'){
                totalOrders=[select count() from order__c where events__c = : selectedEvent and order_status__c!='Cancelled' and Order_status__c!='Abandoned'];
            }else if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Ticket Level' && questionsForItemMAP.get(selectedQuestion).Item__c!=null && questionsForItemMAP.get(selectedQuestion).item__r.item_type__r.name!='Package'){
                totalOrders=[select count() from ticket__c where item__c = : questionsForItemMAP.get(selectedQuestion).item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent];
            }else if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Ticket Level' && questionsForItemMAP.get(selectedQuestion).Item__c!=null && questionsForItemMAP.get(selectedQuestion).item__r.item_type__r.name=='Package'){
                totalOrders=[select count() from ticket__c where item__c = : questionsForItemMAP.get(selectedQuestion).item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null ];
            }else if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Ticket Level' && questionsForItemMAP.get(selectedQuestion).Item_pool__c!=null){
                totalOrders=[select count() from ticket__c where Item_pool__c= : questionsForItemMAP.get(selectedQuestion).Item_pool__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null ];
            }
        }


        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        MAP<String, Decimal> BookedTicketsMAP= new MAP<String, Decimal>();
        if(questionsForItemMAP.get(selectedQuestion).Question_Level__c == 'Ticket Level'){
            BookedTicketsMAP= surveyQuestionBAL.bookedTickets(itemId);
            bookedTickets= BookedTicketsMAP.get('BookedCount');
            allResponses= BookedTicketsMAP.get('ResponsesCount');
        }

        if(questionsForItemMAP.get(selectedQuestion).Question_Level__c == 'Event Level'){
            BookedTicketsMAP= surveyQuestionBAL.bookedTicketsForEvent(selectedEvent);
            bookedTickets= BookedTicketsMAP.get('BookedCount');
            allResponses=BookedTicketsMAP.get('ResponsesCount');//surveyQuestionBAL.allUserAnswers(selectedQuestion);
        }
        System.debug('AAAAAAAAAAAAAAAAARRRRRR######:'+allResponses);
        notGivenResponses= BookedTicketsMAP.get('NotGivenResponsesCount');
       // System.debug('@@@111@@@:'+bookedTickets);
       // System.debug('@@@222@@@:'+notGivenResponses);
        }
     }
       // system.debug(selectedQuestion+'  SELECTED QUESTION  '+allResponses+' BOOKED TICKETS  '+bookedTickets);
        if(allResponses != 0 && bookedTickets !=0){//
            responseGivenPercent= (allResponses*100)/ bookedTickets;
        }else{
            responseGivenPercent= 0;
        }


        responseNotGivenPercent= 100- responseGivenPercent;
        system.debug(responseGivenPercent+' RESPONSE NOT GIVEN PERCENTAGE  '+responseNotGivenPercent);
        system.debug('  ALL RESPONSES '+allResponses);
        for(AggregateResult agg: userAnswersResponses){
            String ansType= String.valueOf(agg.get('ansType'));
            String countString= String.valueOf(agg.get('selCount'));
            Integer ansCount= Integer.valueOf(countString);
            Decimal percent=0;
            System.debug('AAAAAAAAAAAAAAAAARRRRRRTTPTPTPT:'+allResponses);
            if(ansCount != 0 && allResponses != 0){
                percent= ((ansCount*100)/allResponses);
            }
            system.debug(ansCount+'   ANS STRING  '+allResponses+'   '+'   '+percent);
            responsesInnerList.add(new responsesInner(ansType,ansCount, percent));
        }
        detailResponseData();
        return null;
    } 
    
    public integer totalOrdersPrint{get;set;}
    public integer totalOrdersPrintTic{get;set;}
     
    
    public integer totalTicXport{get;set;}
    public integer totalEveXport{get;set;}
 
    
 
 public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyQuestionChbxAnsInnr> surveyQuestionChbxAnsInnrList{get; set;}
 public pagereference detailResponseData(){
        showAttendeeLevelSurvey= FALSE;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();

        userAnswersList= new LIST<User_Answer__c>();
        surveyQuestionChbxAnsInnrList= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyQuestionChbxAnsInnr>();
        userAnswersList= surveyQuestionBAL.userAnswersListForItemQuestion(selectedQuestion);
        surveyQuestionChbxAnsInnrList=surveyQuestionBAL.userChkboxQueAns(selectedEvent,selectedQuestion);
        System.debug('KKKKKKKKKKKKKKK:'+surveyQuestionChbxAnsInnrList+'LLLLLLLLLLLLLLL:'+surveyQuestionChbxAnsInnrList.size());

        surveyAttendeeInnerList1= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1>();
        surveyAttendeeInnerList1=surveyQuestionBAL.gnUsersForSurvey1(selectedQuestion);

        return null;
    }
 
     
   
    //method to Print responses by question
     public BLN_EventDetails eventInfo{get; set;}  

        //method to export responses by question
     public pageReference exportResponses(){
        //showSurveyInfoForQuestion();
        PageReference pg=new PageReference('/apex/BLN_SurveyByQuestionTabResponseExport');
        pg.setRedirect(true);
       // pg.getParameters().put('search',apexpages.currentpage().getparameters().get('search'));
        pg.getParameters().put('questionID',apexpages.currentpage().getparameters().get('questionID'));
        
        return pg;
    }
    
    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1> surveyAttendeeInnerListForPrint1{get; set;}
    public  LIST<responsesInnerQUEANS> respXportPrintList2{get; set;}
    public  LIST<responsesInnerQUEANS> respXportPrintList{get; set;}
    public String selectedQuestion{get; set;}
    public Decimal bookedTickets{get; set;}
    public Decimal bookedTicketsForItemPool{get; set;}
    public Decimal allResponses{get; set;}
    public integer totatTicketLevelOrders {get;set;}
    public  List<Item_Question__c> usrAnsList{get;set;}
    public String xportQA{get;set;}//storing questions whose has answers
    public Set<id> xportQATemp2{get;set;}
    public Set<id> xportQATemp{get;set;}//storing questions whose has answers
       
        
        
          //Inner class for printing purpose
     public Class responsesInnerQUEANS{
        public String answerType{get; set;}
        public String queType{get; set;}
        public Integer answerCount{get; set;}
        public Decimal answerPercentage{get; set;}

        public responsesInnerQUEANS(String answerType, string queType,Integer answerCount, Decimal answerPercentage){
            this.answerType= answerType;
            this.queType= queType;
            this.answerCount= answerCount;
            this.answerPercentage= answerPercentage;
        }
    }  
        
        
        
        
    public Boolean showQuestionDetails{get; set;}
    public Boolean showQuestionLevelSurvey{get; set;}
    public Boolean showItemLevelSurvey{get; set;}
    public Boolean showAttendeeLevelSurvey{get; set;}
    public Boolean isSurveyQuestionExportPrint{get;set;}
    public Boolean isSurveyByAttendeeExport{get;set;}
    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1> surveyAttendeeInnerList1{get; set;}
    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> surveyAttendeeInnerList{get; set;}
    public LIST<User_Answer__c> userAnswersList{get; set;}
   
        
        
        
        //print and export functionality building for survey by question tab
    public  LIST<responsesInner> responsesInnerListForQuestionsXport{get;set;}
    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> showeachQueSurveListXprint{get;set;}
    public  List<Item_question__c> answedItemQuestionList{get;set;}
    public integer totalOrdersXport{get;set;}
    public integer evCount{get;set;}
    public integer ticCount{get;set;}
    public integer evCountXport{get;set;}
    public integer ticCountXport{get;set;}
 
    
    //Exporting functionality for survey by questions tab
    public pagereference surveyByQuestionTabExport(){    
        //showSurveyInfoForQuestion();
        pageReference pg ;
        pg = page.BLN_SurveyByQuestionsTabExport;
        //PageReference pg=new PageReference('/apex/BLN_SurveyByQuestionsTabExport');
        pg.setRedirect(true);
        return pg;
    }
    
    
    //Exporting batch ie, above 10000 records of Global Export(Survey by Questions tab)
    public list<user_answer__c> utotalList{get;set;}
    public MAP<string,LIST<user_answer__c>> uTotalMAp{get;set;}
    public pagereference surveyByQuestionTabExportBatch(){
        utotalList=new list<user_answer__c> ();
        string querystring='SELECT Id, ticket__r.order__r.name,ticket__r.tkt_profile__r.email__c,ticket__r.item_pool__r.Item_Pool_Name__c,item_question__r.item__c,item_question__r.item_pool__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__r.item_pool_name__c,Uanswer_text_update__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c'
                              +' FROM User_Answer__c '
                              +'WHERE ticket__r.event__c= \''+selectedEvent+'\'' 
                              +' AND ticket__r.ticket_status__c=\'Booked\''
                              +' and ticket__r.order__r.order_status__c!=\'Cancelled\' and ticket__r.order__r.Order_status__c!=\'Abandoned\''
                              +' and item_question__r.question_level__c != \'Lead Retrieval\''
                              +' ORDER BY item_question__r.question__r.Question_Order__c ASC';
        utotalList=database.query(querystring);
        uTotalMAp=new MAP<string,LIST<user_answer__c>>();
        
        for(user_answer__c u:utotalList){
            list<user_answer__c> uaListTemp= new list<user_answer__c>();
            if(uTotalMAp.containskey(u.item_question__r.question__r.Question_Text__c)){
                uaListTemp=uTotalMAp.get(u.item_question__r.question__r.Question_Text__c);
                uaListTemp.add(u);
                uTotalMAp.put(u.item_question__r.question__r.Question_Text__c,uaListTemp);
            }else{
                uaListTemp.add(u);
                uTotalMAp.put(u.item_question__r.question__r.Question_Text__c,uaListTemp);
            }
        }
        
        if(utotalList.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportSurveyByQuestionBatchTemplate(querystring,selectedEvent ), 1000);
            return new Pagereference('/BLN_SurveyByAttendeeReportCheckEmail');
        }
        else {
            return null; 
        }    
    }

    
    //Exporting batch ie, above 10000 records of current view(Survey by Questions tab)
    public List<ticket__c> ticUAlist{get;set;}
    public string searchByQueId{get;set;}
    public List<user_answer__c> ulist{get;set;}
    public LIST<Ticket__c> ticketsList{get;set;}
    public string myQuestionId{get;set;}
    public integer noOfUAns{get;set;}
    public list<User_Answer__c > UAforCount{get;set;}
    public pagereference surveyByQuestionTabExportBatchForCurrentView(){
       string queid=apexpages.currentpage().getparameters().get('questionID');
       system.debug('aaaaaaaaaaaa'+queid);
       showSurveyInfoForQuestion();
                    string querystring='SELECT Id,ticket__r.order__r.name,ticket__r.tkt_profile__r.Email__c,item_question__r.item__c,item_question__r.item_pool__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__r.item_pool_name__c,Uanswer_text_update__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c'
                              +' FROM User_Answer__c '
                              +'WHERE ticket__r.event__c= \''+selectedEvent+'\''
                              +' AND item_question__r.question__c = \''+queid+'\''
                              +' AND ticket__r.ticket_status__c=\'Booked\''
                              +'and ticket__r.order__r.order_status__c!=\'Cancelled\' and ticket__r.order__r.Order_status__c!=\'Abandoned\''
                              +' ORDER BY item_question__r.question__r.Question_Order__c ASC ';
                          
                    UAforCount = new list<User_Answer__c >();
                    UAforCount = database.query(querystring);

                   if(UAforCount.size()>1000){
                    system.debug('TRTRTRTRTR:');
                        Id batchInstanceId = Database.executeBatch(new BLN_ExportSurveyByQuestionResponseBatch(querystring, queid,totalQueWiseCountEvent,responsesInnerList,queName,responseSurveyByQuestion), 1000);//showeachQueSurveList
                        return new Pagereference('/BLN_SurveyByAttendeeReportCheckEmail');
                    }else{
                        
                        return null;
                    }
                    
                    /* ---------------------------old code start End ------------------------------------------ */                    
                           
                           
                           
    }  
    
     public String dataTableJson_surveyByQuestionreport_tab2 { get; set; }
    public ApexPages.StandardSetController setCon1 {get;set;}
    public List<Ticket__c> RecList1{get;set;} 
    public List<user_answer__c> answerList{get;set;}
    public void processData_surveyByQuestionreport_tab2() {
        
        String searchKey = ApexPages.currentPage().getParameters().get('searchKeySBQ');
        System.debug('SBSBSBSBS:::'+searchKey); 
        string questionID=ApexPages.currentPage().getParameters().get('questionID');
        system.debug('questionIDTTTTTTTTTTTTTTTTTTTTTT:'+questionID);  
        answerList=new List<user_answer__c>();         
        string querystring='select id,ticket__r.tkt_profile__r.email__c,ticket__r.name,ticket__r.order__r.name,name,uanswer_text__c,Ticket__r.tkt_profile__r.First_Name__c,UAnswer_Text_Update__c,Ticket__r.tkt_profile__r.Last_Name__c,Item_Question__r.Event__c,Item_Question__r.Item__c,Item_Question__r.Item__r.item_name__c,Item_Question__r.Item_Pool__c,Item_Question__r.Item_Pool__r.Item_Pool_Name__c,Item_Question__r.Question__r.Answer_Type__c from user_answer__c where item_question__r.question__c= \''+questionID+'\' and ticket__r.order__r.order_status__c!=\'Cancelled\' and ticket__r.order__r.Order_status__c!=\'Abandoned\' and ticket__r.ticket_status__c=\'Booked\' ';
        
        /* ------------- Search logic start --------------------- */
        if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){ 
        String[] tokens = searchKey.split(' '); 
        if(tokens.size()==2){
            queryString+='and ((ticket__r.tkt_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and ticket__r.tkt_profile__r.Last_Name__c  like \'%'+tokens[1]+'%\') ';  
        }
        else{
            queryString+='and (ticket__r.tkt_profile__r.First_Name__c   like \'%'+searchKey+'%\' or ticket__r.tkt_profile__r.Last_Name__c  like \'%'+searchKey+'%\' '; 
        } 
            queryString += '  or item_question__r.item__r.item_name__c  like \'%'+searchKey+'%\' or item_question__r.item_pool__r.item_pool_name__c  like \'%'+searchKey+'%\' or ticket__r.name  like \'%'+searchKey+'%\' or ticket__r.order__r.name  like \'%'+searchKey+'%\' or ticket__r.tkt_profile__r.Email__c  like \'%'+searchKey+'%\' or uanswer_text_update__c  like \'%'+searchKey+'%\') ';
        }
        
        /* ---------------Search Logic End ---------------------- */
        
        /* ---------------sorting column logic start ------------------------------- */   
        List<String> ColName = New List<String>();
        ColName.add('ticket__r.tkt_profile__r.First_Name__c');//1 column
        ColName.add('ticket__r.item__r.item_name__c');//2 column
        ColName.add('UAnswer_Text_Update__c');//3 column   
        
        integer i = 0;
        integer v ;
        
        String str;

        String col = ApexPages.currentPage().getParameters().get('rownumber');//Column to which ordering should be applied 
        System.debug('sorting order is  '+col);
        String sortord = ApexPages.currentPage().getParameters().get('roworder');//Get The direction of Sorting ASC or DESC 
        
        /****check user sorting on any column on not *****/
        /****use First Column as default sorting column*****/
        
        if(col!=null){ 
            v=integer.valueof(col); 
            str=ColName.get(v); 
            queryString += ' order by ' + str ;
        }else{
            str='ticket__r.Order__r.createddate'; 
            queryString += ' order by ' + str ;
        } 
        
        /*******Take Default Sorting Order as 'desc'***/
        if(sortord==null){
            sortord='desc';
        } 
        
        /****Append Sorting order to The Query String***/            
        queryString+= ' '+sortord; 
        
        //final query
        System.debug('====>query '+queryString );
        /* -------------------------sorting column ending ------------------------------ */
        
        
        answerList=database.query(querystring+' limit 10000');
        setcon1=new ApexPages.StandardSetController(answerList);
        
        //fetch starting record number for current display, this parametter will be send by jQuery Datatable
        Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
    
        //current number of records per page, it is also send by send by jQuery Datatable
        Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
        setCon1.setPageSize(3);
        
        Integer noOfRecords= setCon1.getResultSize();
        if(size==-1){
        size=noOfRecords;
        }
        setCon1.setPageSize(size);            
    
        //set pagenumber
        setCon1.setPageNumber((start/size)+1);
        list<user_answer__c> answerList1=new list<user_answer__c>();            
        answerList1= setCon1.getRecords(); 
        system.debug('questionID'+questionID);
        
        List<SubWrapper> answclsList= new List<SubWrapper>();
        
        for(user_answer__c ua : answerList1){
            answclsList.add(new SubWrapper(ua));    
        }
        
        DataTableWrapper1 datawrap = new DataTableWrapper1(0,noOfRecords,noOfRecords,answclsList);            
        dataTableJson_surveyByQuestionreport_tab2 = JSON.serialize(datawrap);

        showItemDetails= TRUE;
    }
    
    /***********************sub wrapper****/
    // inner class
    public class SubWrapper{ 
    public user_answer__c usrans{get; set;}     
    public SubWrapper(user_answer__c usrans){
        this.usrans= usrans; 
    }
    
    }
        
    public class DataTableWrapper1
        {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public List<SubWrapper> data;
            public DataTableWrapper1(Integer draw,Integer recordsTotal,Integer recordsFiltered,List<SubWrapper> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data= data;
            }
        }
        
        
        
}