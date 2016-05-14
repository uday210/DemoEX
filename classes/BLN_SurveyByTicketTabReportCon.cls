public class  BLN_SurveyByTicketTabReportCon{ 
     public BLN_SurveyByTicketTabReportCon(){

        EventDates= new BLN_Event__c();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if(k!=null){
            selectedEvent= k.getValue();
        }
        isDetailItem=false;
        iqAgg = new LIST<AggregateResult>();
       // iqAgg = [select count(id) cnt,item_question__r.question__c i from user_answer__C where ticket__r.event__c = :selectedEvent and ticket__r.order__r.Order_status__c!='Abandoned' and ticket__r.order__r.Order_status__c!='Cancelled' group by item_question__r.question__c];

    }
    
    public String dataTableJson2_detailresptktpool { get; set; }
    public ApexPages.StandardSetController setCon_detailresptktpool {get;set;}
    public List<User_Answer__c> RecList_detailresptktpool{get;set;}
    public String myItmQuePoolId{get;set;}
    
    public PageReference processData2_detailresptktpool() { 
        itemPoolId=ApexPages.currentPage().getParameters().get('itemPoolId');
        system.debug('itemPoolId'+itemPoolId);
        string poolquestionId=ApexPages.currentPage().getParameters().get('myItmQuePoolId');
        string searchKey =ApexPages.currentPage().getParameters().get('searchKeySBT');
        surveyDataForItemPoolQuestion();
        
        BLN_UserAnswers_DAO userAnswerDAOClass= new BLN_UserAnswers_DAO();
        LIST<User_Answer__c> userAnswersList2= new LIST<User_Answer__c>();
        
        string queryString ='select id,name,Ticket__r.name,Ticket__r.order__r.name,Ticket__r.tkt_profile__r.email__c,uanswer_text__c,Ticket__r.tkt_profile__r.First_Name__c,UAnswer_Text_Update__c,Ticket__r.tkt_profile__r.Last_Name__c,Item_Question__r.Event__c,Item_Question__r.Item__c,Item_Question__r.Item__r.item_name__c,Item_Question__r.Item_Pool__c,Item_Question__r.Item_Pool__r.Item_Pool_Name__c,Item_Question__r.Question__r.Answer_Type__c from user_answer__c where  ticket__r.order__r.order_status__c!=\'Abandoned\' and ticket__r.order__r.order_status__c!=\'Cancelled\' and ';
        
        if(poolquestionId!=Null && poolquestionId!=''){ 
            queryString+=' item_question__c = \''+poolquestionId+'\' '; 
        }else{ 
            queryString+=' item_question__r.question__r.event__c = \''+SelectedItempoolQuestion+'\' '; 
        }
        
        /* ------------- Search logic start --------------------- */
        if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){
        system.debug('skskskks222::'+searchKey ); 
        String[] tokens = searchKey.split(' '); 
        if(tokens.size()==2){
            queryString+='and ((ticket__r.tkt_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and ticket__r.tkt_profile__r.Last_Name__c  like \'%'+tokens[1]+'%\') ';  
        }
        else{
            queryString+='and (ticket__r.tkt_profile__r.First_Name__c   like \'%'+searchKey+'%\' or ticket__r.tkt_profile__r.Last_Name__c  like \'%'+searchKey+'%\' '; 
        } 
            queryString += ' or ticket__r.name  like \'%'+searchKey+'%\' or ticket__r.tkt_profile__r.email__c like \'%'+searchKey+'%\' or ticket__r.order__r.name like \'%'+searchKey+'%\' or uanswer_text_update__c  like \'%'+searchKey+'%\') ';
        }
        
        /* ---------------Search Logic End ---------------------- */
        
        /* ---------------sorting column logic start ------------------------------- */   
        List<String> ColName = New List<String>();
        ColName.add('ticket__r.tkt_profile__r.First_Name__c');//1 column
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
              
        
        userAnswersList2=database.query(queryString+' limit 10000');
        system.debug('userAnswersList2'+userAnswersList2.size());
        setcon_detailresptktpool=new ApexPages.StandardSetController(userAnswersList2);
        
      
      //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            setCon_detailresptktpool.setPageSize(3);
            
            Integer noOfRecords= setCon_detailresptktpool.getResultSize();
            if(size==-1){
            size=noOfRecords;
            }
            setCon_detailresptktpool.setPageSize(size);
            system.debug('noOfRecords'+noOfRecords);
        
            //set pagenumber
            setCon_detailresptktpool.setPageNumber((start/size)+1);
            
            RecList_detailresptktpool = setCon_detailresptktpool.getRecords();
        
        system.debug('RecList_detailresptktpool'+RecList_detailresptktpool);
        
             List<SubWrapperpool> answclsList= new List<SubWrapperpool>(); 
            for(user_answer__c ua : RecList_detailresptktpool ){
                answclsList.add(new SubWrapperpool(ua));    
            }
        
            DataTableWrapper_detailresptktpool datawrap = new DataTableWrapper_detailresptktpool(0,noOfRecords,noOfRecords,answclsList);
            dataTableJson2_detailresptktpool = JSON.serialize(datawrap);
        
        return null;
    }
  
    
    // inner class
    public class SubWrapperpool{ 
    public user_answer__c usrans{get; set;}     
    public SubWrapperpool(user_answer__c usrans){
        this.usrans= usrans; 
    }
    
    }
        
    public class DataTableWrapper_detailresptktpool
        {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public List<SubWrapperpool> data;
            public DataTableWrapper_detailresptktpool(Integer draw,Integer recordsTotal,Integer recordsFiltered,List<SubWrapperpool> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data= data;
            }
        }


    public String dataTableJson2_detailresptkt { get; set; }
    public ApexPages.StandardSetController setCon_detailresptkt {get;set;}
    public List<User_Answer__c> RecList_detailresptkt{get;set;}
    public LIST<User_Answer__c> userAnswersList{get;set;} 
    public string myItmQueId{get;set;}
    public boolean isDetailItem{get;set;}
    public PageReference processData2_detailresptkt(){
        isDetailItem=true;
        itemId=ApexPages.currentPage().getParameters().get('itemId');
        System.debug(itemId + ':iiiiiiiiiiiiiiiiii:' + ApexPages.currentPage().getParameters().get('itemId'));
        
        string itmQueId=ApexPages.currentPage().getParameters().get('myItmQueId');
        System.debug('MQMQMQMMQMQMQMQM::'+itmQueId);
        
        string searchKey =ApexPages.currentPage().getParameters().get('searchKeySBT');
        system.debug('skskskks11::'+searchKey );
        
        //surveyDataForQuestion();
        //summaryResponseData();
         
        showAttendeeLevelSurvey= FALSE;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();

        BLN_UserAnswers_DAO userAnswerDAOClass= new BLN_UserAnswers_DAO();
        LIST<User_Answer__c> userAnswersList1= new LIST<User_Answer__c>();
        
        string queryString ='select id,Ticket__r.tkt_profile__r.email__c,Ticket__r.order__r.name,Ticket__r.name,name,uanswer_text__c,Ticket__r.tkt_profile__r.First_Name__c,UAnswer_Text_Update__c,Ticket__r.tkt_profile__r.Last_Name__c,Item_Question__r.Event__c,Item_Question__r.Item__c,Item_Question__r.Item__r.item_name__c,Item_Question__r.Item_Pool__c,Item_Question__r.Item_Pool__r.Item_Pool_Name__c,Item_Question__r.Question__r.Answer_Type__c from user_answer__c  where Ticket__r.Order__r.Order_Status__c != \'Abandoned\' and Ticket__r.Order__r.Order_Status__c != \'Cancelled\' and  ';
        
        if(itmQueId!=Null && itmQueId!=''){
            queryString+=' item_question__c = \''+itmQueId+'\' ';
        }else{
            queryString+=' item_question__r.question__r.event__c = \''+selectedEvent+'\' ';
        }
        
         /* ------------- Search logic start --------------------- */
        if(searchKey != null && searchKey != '' && searchKey.trim().length() > 0){
        system.debug('skskskks222::'+searchKey ); 
        String[] tokens = searchKey.split(' '); 
        if(tokens.size()==2){
            queryString+='and ((ticket__r.tkt_profile__r.First_Name__c  like \'%'+tokens[0]+'%\' and ticket__r.tkt_profile__r.Last_Name__c  like \'%'+tokens[1]+'%\') ';  
        }
        else{
            queryString+='and (ticket__r.tkt_profile__r.First_Name__c   like \'%'+searchKey+'%\' or ticket__r.tkt_profile__r.Last_Name__c  like \'%'+searchKey+'%\' '; 
        } 
            queryString += ' or ticket__r.name  like \'%'+searchKey+'%\' or ticket__r.order__r.name  like \'%'+searchKey+'%\' or ticket__r.tkt_profile__r.email__c  like \'%'+searchKey+'%\' or uanswer_text_update__c  like \'%'+searchKey+'%\') ';
        }
        
        /* ---------------Search Logic End ---------------------- */
        
        /* ---------------sorting column logic start ------------------------------- */   
        List<String> ColName = New List<String>();
        ColName.add('ticket__r.tkt_profile__r.First_Name__c');//1 column
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
        
          
        userAnswersList1=database.query(queryString+' limit 10000');
        
        System.debug('UUUUUSSSSS:::'+userAnswersList1.size());
        setcon_detailresptkt=new ApexPages.StandardSetController(userAnswersList1);
        
      
      //fetch starting record number for current display, this parametter will be send by jQuery Datatable
            Integer start= Integer.valueOf(ApexPages.currentPage().getParameters().get('start'));
            System.debug('start value: '+start);
        
            //current number of records per page, it is also send by send by jQuery Datatable
            Integer size = Integer.valueOf(ApexPages.currentPage().getParameters().get('length'));
            System.debug('size value : '+size);
            setCon_detailresptkt.setPageSize(3);
            
            Integer noOfRecords= setCon_detailresptkt.getResultSize();
            if(size==-1){
            size=noOfRecords;
            }
            setCon_detailresptkt.setPageSize(size);
            
        
            //set pagenumber
            setCon_detailresptkt.setPageNumber((start/size)+1);
            
            RecList_detailresptkt = setCon_detailresptkt.getRecords(); 
            
            List<SubWrapper> answclsList= new List<SubWrapper>(); 
            for(user_answer__c ua : RecList_detailresptkt){
                answclsList.add(new SubWrapper(ua));    
            }
        
            DataTableWrapper_detailresptkt datawrap = new DataTableWrapper_detailresptkt(0,noOfRecords,noOfRecords,answclsList);
            dataTableJson2_detailresptkt = JSON.serialize(datawrap);
        
        return null;
    }
    
   
    // inner class
    public class SubWrapper{ 
    public user_answer__c usransItm{get; set;}     
    public SubWrapper(user_answer__c usransItm){
        this.usransItm= usransItm; 
    }
    
    }
        
    public class DataTableWrapper_detailresptkt
        {
        //these parameters Datatable expects from server , those are[draw,recordTotal,recordFiltered,data(this is a array))]
                public boolean selected{get; set;}
                public Integer draw;
                public Integer recordsTotal;
                public Integer recordsFiltered;
                public List<SubWrapper> data;
            public DataTableWrapper_detailresptkt(Integer draw,Integer recordsTotal,Integer recordsFiltered,List<SubWrapper> data)
            {
                this.draw = draw;
                this.recordsTotal = recordsTotal;
                this.recordsFiltered = recordsFiltered ;
                this.data= data;
            }
        }
 

    public Decimal allResponses{get; set;}
    public Decimal notGivenResponses{get; set;}
    public Decimal bookedTickets{get; set;}
    public String itemQuestionId{get; set;}
    public String itemId{get; set;}
    public String itemAnswerType{get; set;}
    public Integer summaryCount{get;set;}
    public Decimal responseGivenPercent{get; set;}
    public Decimal responseNotGivenPercent{get; set;}
    public MAP<Id, Item_Question__c> questionsForItemMAP{get; set;}
    public Integer attendeeNumber{get; set;}
    public String selectedItemName{get; set;}
    public String itemPoolId{get;set;}

    public string tickettabType{get;set;}
    public string questiontabType{get;set;}
    public string attendeetabType{get;set;}

    public BLN_EventDetails eventInfo{get; set;}

    public PageReference surveyDataForQuestion(){

        showQuestionLevelSurvey= FALSE;
        showQuestionDetails= TRUE;
        detailInf=TRUE;
        showQuestionDetailsForItemPool= False;
        showItemLevelSurvey= FALSE;
        showItemDetails= FALSE;
        showAttendeeLevelSurvey= FALSE;

        responsesInnerList= new LIST<responsesInner>();
        userAnswersList= new LIST<User_Answer__c>();

        itemId= ApexPages.currentPage().getParameters().get('itemId');
        system.debug('ITEM ID FROM LIST  '+itemId);

        LIST<Item_Question__c> questions= new LIST<Item_Question__c>();
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        if((itemId != NULL && itemId != '')){ 
            questions= surveyQuestionBAL.itemQuestionsForItem(itemId);  
        }else if((itemId == NULL || itemId == '')){
            questions= surveyQuestionBAL.eventLevelQuestions(selectedEvent);
        }
        
         questionsForItem= new LIST<selectoption>();
        questionsForItemMAP= new MAP<Id, Item_Question__c>();
        Set<id> IIQQID=new Set<id>();
        
         for(Item_Question__c itemQuestion1 : questions){ 
             IIQQID.add(itemQuestion1.id);
         } 
              
             String ansEvent='';
             string uniqueQuestion='';
             for(User_Answer__c ua : [SELECT ID,NAME,Item_Question__c,BLN_Answer__c,UAnswer_Text_Update__c,UAnswer_Text__c,Item_Question__r.Question__r.Name FROM User_Answer__c where ticket__r.ticket_status__c='Booked' 
                                         and item_question__c in : IIQQID]){
                if(uniqueQuestion.contains(ua.Item_Question__r.Question__r.Name)==false){
                    uniqueQuestion=uniqueQuestion+ua.Item_Question__r.Question__r.Name;
                    ansEvent+=ua.Item_Question__r.Question__r.Name+',';
                }
            }
            for(Item_Question__c itemQuestion : questions){ 
            if(ansEvent.contains(itemQuestion.Question__r.Name)){
                if(itemQuestion.User_Answers__r.size() >0){
                questionsForItem.add(new SelectOption(itemQuestion.Id, itemQuestion.Question__r.Question_Text__c));
                questionsForItemMAP.put(itemQuestion.Id, itemQuestion);
                selectedQuestion= itemQuestion.Id;
            }
        } 
        } 
        System.debug('QQQQQQQQQSSSS!!!!:'+selectedQuestion);
        summaryResponseData();
        return null;
    }

    public LIST<SelectOption> questionsForItem{get; set;}
    public String selectedQuestion{get; set;}
    public Integer totalorders{get;set;}
    public integer totalbookedtickets{get;set;}
    public Integer totalorderpools{get;set;}
    public List<Ticket__c> allAttTicList {get;set;}
    public integer collectFromAllAttendees{get;set;}
    public List<Order__c> ordset1 {get;set;}
    public string qname{get;set;}
    public Id onchangeQueId{get;set;}
     public String QueAutoName{get;set;}
    

    // ========================================base for getting print and export===============================
    public integer respondedItemAttendees{get;set;}
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

        totalOrders=0;
        //user answers for single question
        if(string.IsEmpty(selectedQuestion)==false){
        userAnswersResponses= surveyQuestionBAL.userAnswersForItemQuestion(selectedQuestion);
        
        if(questionsForItemMAP!=null && questionsForItemMAP.get(selectedQuestion)!=null){
        itemAnswerType= questionsForItemMAP.get(selectedQuestion).Question__r.Answer_Type__c;
        //onchangeQueId='a1z560000009LYz';//questionsForItemMAP.get(selectedQuestion).Question__r.id;

        //if(selectedQuestion!= null || selectedQuestion!='')
        selectedItemName= questionsForItemMAP.get(selectedQuestion).item__r.item_name__c;
        id itmOfid=questionsForItemMAP.get(selectedQuestion).item__r.id;
        qname=questionsForItemMAP.get(selectedQuestion).Question__r.Question_Text__c;
        QueAutoName=questionsForItemMAP.get(selectedQuestion).Question__r.Id;
        System.debug('NNNNNNQQQQQ:::'+QueAutoName);

        System.debug('IIIIIIII:'+questionsForItemMAP.get(selectedQuestion).question__r.id);

        if(questionsForItemMAP.get(selectedQuestion).question__r.id!=Null){
            if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Event Level'){
                totalOrders=[select count() from order__c where events__c = : selectedEvent and order_status__c!='Cancelled' and Order_status__c!='Abandoned'];
            }else if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Ticket Level' && questionsForItemMAP.get(selectedQuestion).Item__c!=null && questionsForItemMAP.get(selectedQuestion).item__r.item_type__r.name!='Package'){
                totalOrders=[select count() from ticket__c where item__c = : questionsForItemMAP.get(selectedQuestion).item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent  and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }else if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Ticket Level' && questionsForItemMAP.get(selectedQuestion).Item__c!=null && questionsForItemMAP.get(selectedQuestion).item__r.item_type__r.name=='Package'){
                totalOrders=[select count() from ticket__c where item__c = : questionsForItemMAP.get(selectedQuestion).item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }else if(questionsForItemMAP.get(selectedQuestion).question_level__c=='Ticket Level' && questionsForItemMAP.get(selectedQuestion).Item_pool__c!=null){
                totalOrders=[select count() from ticket__c where Item_pool__c= : questionsForItemMAP.get(selectedQuestion).Item_pool__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null  and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }
        }

        /*
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
        notGivenResponses= BookedTicketsMAP.get('NotGivenResponsesCount'); */
        }
     } 
        /*if(allResponses != 0 && bookedTickets !=0){//
            responseGivenPercent= (allResponses*100)/ bookedTickets;
        }else{
            responseGivenPercent= 0;
        }


        responseNotGivenPercent= 100- responseGivenPercent;
        system.debug(responseGivenPercent+' RESPONSE NOT GIVEN PERCENTAGE  '+responseNotGivenPercent);
        system.debug('  ALL RESPONSES '+allResponses);*/
        for(AggregateResult agg: userAnswersResponses){
            String ansType= String.valueOf(agg.get('ansType'));
            String countString= String.valueOf(agg.get('selCount'));
            Integer ansCount= Integer.valueOf(countString);
            Decimal percent=0;
            if(ansCount != 0 && allResponses != 0){
                percent= ((ansCount*100)/allResponses);
            }
            responsesInnerList.add(new responsesInner(ansType,null, ansCount, percent));
        }
        
        System.debug('RESPPPPP::'+responsesInnerList.size());
        //detailResponseData();
        respondedItemAttendees=1;
        List<user_answer__c> usrAnsList=new List<user_answer__c>();
        string uansString='';
        for(user_answer__c u : [select id,name,ticket__r.id from user_answer__c where ticket__r.event__c =: selectedEvent and item_question__c= : selectedQuestion and  item_question__r.item__c = : itemId and Ticket__r.Order__r.Order_Status__c != 'Abandoned' and Ticket__r.Order__r.Order_Status__c != 'Cancelled']){
            if(!uansString.contains(u.ticket__r.id)){
                uansString+=u.ticket__r.id;
                usrAnsList.add(u);
            }
        }
        respondedItemAttendees=usrAnsList.size();
        return null;
    }

   // public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyQuestionChbxAnsInnr> surveyQuestionChbxAnsInnrList{get; set;}
   // public transient LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1> surveyAttendeeInnerList1{get; set;}
    public LIST<AggregateResult> surveyAttendeeInnerList1{get; set;}
    public pagereference detailResponseData(){
        showAttendeeLevelSurvey= FALSE;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();

        //userAnswersList= new LIST<User_Answer__c>(); 
        //userAnswersList= surveyQuestionBAL.userAnswersListForItemQuestion(selectedQuestion); 
        /*surveyAttendeeInnerList1= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1>();
        surveyAttendeeInnerList1=surveyQuestionBAL.gnUsersForSurvey1(selectedQuestion); */
        surveyAttendeeInnerList1= new LIST<AggregateResult>();
        surveyAttendeeInnerList1=surveyQuestionBAL.gnUsersForSurvey_agg(selectedQuestion);
        return null;
    }


    public PageReference surveyDataForItem() {

        system.debug('  ITEM ID FOR SURVEY  '+ApexPages.currentPage().getParameters().get('itemId'));
        String itemId= ApexPages.currentPage().getParameters().get('itemId');
        itemLevelSurveyList= new LIST<BLN_SurveyQuestionsReportCon_BAL.itemLevelSurvey>();


        itemLevelSurveyList= surveyQuestionBAL.dataForItemSurvey(itemId);

        showQuestionLevelSurvey= FALSE;
        showQuestionDetails= FALSE;
        showItemLevelSurvey= FALSE;
        showItemDetails= TRUE;
        showAttendeeLevelSurvey= FALSE;
        return null;
    }

   

    //method to show/restrict items which doesnt have answers
    public integer packageDisplay{get;set;}
    public integer itemDisplay{get;set;}
    public integer itemDisplay1{get;set;}
    public string itemDisplay2{get;set;}
    public void showitemsQA(){
        list<Ticket__c> tlist1=new list<Ticket__c>();
        tlist1=ticketDAOClass.eventBookedTickets(selectedEvent);
        packageDisplay=0;
        itemDisplay=0;
        itemDisplay1=0;
        itemDisplay2='';
        for(Ticket__c tic: tlist1){

            for(user_answer__c ua : tic.User_Answers__r){
                if(ua.UAnswer_text__c!=null && ua.Item_question__r.question_level__c=='Ticket Level'){
                    itemDisplay2+=ua.item_question__r.question__r.id+',';
                }
            }


            itemDisplay+=tic.User_Answers__r.size();

            if(tic.item_type__r.name=='Package'){
                packageDisplay+=tic.User_Answers__r.size();
            }

            if(tic.parent_id__c!=null){
                itemDisplay1+=tic.User_Answers__r.size();
            }

        }
    }

    public Boolean showQuestionLevelSurvey{get; set;}
    public Boolean showQuestionDetails{get; set;}
    public Boolean showQuestionDetailsForItemPool{get; set;}
    public Boolean showItemLevelSurvey{get; set;}
    public Boolean showItemDetails{get; set;}
    public BLN_Event__c EventDates{get; set;}
    public String selectedEvent{get; set;}
    public LIST<Item_Question__c> questionsList{get; set;}
    public LIST<BLN_Item__c> itemQuestionsList{get; set;}
    public BLN_SurveyQuestionsReportCon_BAL surveyQuestionBAL{get; set;}
    public LIST<BLN_SurveyQuestionsReportCon_BAL.itemLevelSurvey> itemLevelSurveyList{get; set;}
    public boolean detailInf{get;set;}

    public pagereference surveyQuestionsList(){

        showQuestionLevelSurvey= TRUE;
        showQuestionDetails= FALSE;
        showItemLevelSurvey= FALSE;
        showItemDetails= FALSE;
        showAttendeeLevelSurvey= FALSE;
        detailInf=true;

        isSurveyByAttendeeExport=false;
        isSurveyQuestionExportPrint=false;

        //tickettabType=Apexpages.currentPage().getParameters().get('tickettab');

        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        itemQuestionsList= new LIST<BLN_Item__c>();
        system.debug('  SELECTED EVENT ID '+selectedEvent);
        itemQuestionsList= surveyQuestionBAL.surveyQuestionsForItem(selectedEvent);
        system.debug(itemQuestionsList.size()+'  QUESTIONS LIST '+itemQuestionsList);

        return null;
    }

    public  LIST<BLN_SurveyQuestionsReportCon_BAL.itemQuestionsInner> itemQuestionsInnerList{get; set;}

    public Boolean isSurveyQuestionExportPrint{get;set;}

     public pagereference backsurveybytic(){
         /*showQuestionDetails=FALSE; 
         detailInf=false; 
         return null;*/ 
         pageReference pg =  new PageReference ('/apex/BLN_surveyByTicketTab');
            pg.setRedirect(true); 
            return pg;
         }

    public LIST<AggregateResult> iqAgg{get;set;}
    public pagereference surveyQuestionsListWithItem(){ 
        showQuestionLevelSurvey= TRUE; 
        showItemLevelSurvey= TRUE; 
        showAttendeeLevelSurvey= FALSE; 
        isSurveyByAttendeeExport=false;
        isSurveyQuestionExportPrint=true;

        itemQuestionsInnerList= new LIST<BLN_SurveyQuestionsReportCon_BAL.itemQuestionsInner>();
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL(); 
        system.debug('  SELECTED EVENT ID '+selectedEvent);
        itemQuestionsInnerList= surveyQuestionBAL.allTypeQuestions(selectedEvent); 
        showItemLevelSurvey= TRUE;
        showItemDetails= FALSE; 
        return null;
    }

    public pagereference surveyQuestionsListWithItemPool(){

        showItemPoolQuestionLevelSurvey= TRUE;
        showQuestionDetailsForItemPool=False;
        showItemPoolItemLevelSurvey= TRUE;
        showItemPoolItemDetails= FALSE;
        showItemPoolAttendeeLevelSurvey= FALSE;
        showQuestionDetails=false;

        itemQuestionsInnerList= new LIST<BLN_SurveyQuestionsReportCon_BAL.itemQuestionsInner>();
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        //itemQuestionsList= new LIST<BLN_Item__c>();
        system.debug('  SELECTED EVENT ID '+selectedEvent);
        itemQuestionsInnerList= surveyQuestionBAL.allTypeQuestions(selectedEvent);
        system.debug(itemQuestionsInnerList.size()+' @@@@@@@@123 '+itemQuestionsInnerList);

        showItemPoolItemLevelSurvey= TRUE;
        showItemPoolItemDetails= FALSE;

        return null;
    }

    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> surveyAttendeeInnerList{get; set;}
    public Boolean showAttendeeLevelSurvey{get; set;}

    public Boolean isSurveyByAttendeeExport{get;set;}

    public pagereference surveyQuestionsWithAttendee(){

        showQuestionLevelSurvey= TRUE;
        showQuestionDetails= FALSE;
        showQuestionDetailsForItemPool=true;
        showItemLevelSurvey= FALSE;
        showItemDetails= FALSE;
        showAttendeeLevelSurvey= TRUE;

        //Export functionality
        isSurveyByAttendeeExport=True;
        isSurveyQuestionExportPrint=false;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        surveyAttendeeInnerList= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner>();

        userAnswersList= new LIST<User_Answer__c>();

        surveyAttendeeInnerList= surveyQuestionBAL.gnUsersForSurvey(selectedEvent);
        System.debug('XXXXXXX::'+surveyAttendeeInnerList.size());
        return null;
    }



    public BLN_UtillDisplayLinks   myticket { get; set; }
    public boolean isEventAdmin{get;set;}
    public boolean isBoothadmin{get;set;}

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
        myticket.isSurveyByTicketReportPage='active';
        myticket.tablabel='Survey By Ticket Report';
        myticket.EventId = selectedEvent ; 
    
        surveyQuestionsListWithItem();
        //surveyQuestionsListWithItemPool(); 

   try{
     myticket.eventName=se.NAme;
     myticket.userPermissions(userInfo.getUserId(),selectedEvent);
    }catch(exception e){}


        return null;
    }

    //For Question wise
    public  LIST<responsesInner> responsesInnerListForQuestions{get; set;}

    //For Items
    public  LIST<responsesInner> responsesInnerList{get; set;}
    public Class responsesInner{
        public String answerType{get; set;}
        public String questionType{get; set;}
        public Integer answerCount{get; set;}
        public Decimal answerPercentage{get; set;}

        public responsesInner(String answerType,String questionType, Integer answerCount, Decimal answerPercentage){
            this.answerType= answerType;
            this.questionType= questionType;
            this.answerCount= answerCount;
            this.answerPercentage= answerPercentage;
        }
    }

    //For Items print and export
    public LIST<responsesItemPoolInner> ItemPoolExportPrintList{get; set;}

    //For Item Pools
    public  LIST<responsesItemPoolInner> responsesItemPoolInnerList{get; set;}
    public Class responsesItemPoolInner{
        public String itemPoolanswerType{get; set;}
        public Integer itemPoolanswerCount{get; set;}
        public Decimal itemPoolanswerPercentage{get; set;}

        public responsesItemPoolInner(String itemPoolanswerType, Integer itemPoolanswerCount, Decimal itemPoolanswerPercentage){
            this.itemPoolanswerType= itemPoolanswerType;
            this.itemPoolanswerCount= itemPoolanswerCount;
            this.itemPoolanswerPercentage= itemPoolanswerPercentage;
        }
    }

    //print and export functionality building for survey by question tab
    public integer totalOrdersXport{get;set;}
    public integer evCount{get;set;}
    public integer ticCount{get;set;}
    public integer evCountXport{get;set;}
    public integer ticCountXport{get;set;}


    public integer totalTicXport{get;set;}
     public integer totalEveXport{get;set;}
    public pagereference exportSurveyQuestions(){
        totalOrdersXport=0;
         totalTicXport=1;
       totalEveXport=1;
        totalEveXport=[select count() from order__c where events__c = : selectedEvent and order_status__c!='Cancelled' and Order_status__c!='Abandoned'];
        totalTicXport=[select count() from ticket__c where ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent];
        
        //printXportCountsForSurveyByTicket();//method for calucluation stats
        //surveyQuestionsWithAttendee();
        //exportingPrintingQA();
        //displaySurveyRepAttendeeData();         
        
         pageReference pg =  new PageReference ('/apex/BLN_SurveyByTicketTabExport');
            pg.setRedirect(true);
            pg.getParameters().put('searchTicket',apexpages.currentpage().getparameters().get('searchTicket'));
            return pg;
        
    }
    
   public list<user_answer__c> unsBatchList{get;set;} 
    public pagereference surveyByTicketBatchTemplate(){
       String searchKey = ApexPages.currentPage().getParameters().get('searchTicket');
       system.debug('sssssssMMM>>'+searchKey);
           
            unsBatchList=new list<user_answer__c> ();
            string querystring= 'SELECT Id,Uanswer_text_update__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__r.item_pool_name__c,item_question__r.item__c,item_question__r.item_pool__c,item_question__r.question__r.answer_type__c,item_question__r.question_level__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,   UAnswer_Text__c,Ticket__r.order__r.name,Ticket__r.name, Ticket__r.tkt_profile__r.email__c,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c'
                              +' FROM User_Answer__c '
                              +'WHERE ticket__r.event__c = \''+selectedEvent+'\''
                              +' AND ticket__r.ticket_status__c=\'Booked\''
                              +' and Ticket__r.Order__r.Order_Status__c != \'Abandoned\' and Ticket__r.Order__r.Order_Status__c != \'Cancelled\''
                              +' and item_question__r.question_level__c != \'Lead Retrieval\''
                              +' ORDER BY ticket__r.order__r.createdDate ASC limit 50000';
                              //'SELECT Id,Uanswer_text_update__c,item_question__r.item__c,item_question__r.item_pool__c,item_question__r.question__r.answer_type__c,item_question__r.question_level__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c'
                              
            unsBatchList=database.query(querystring); 
            
            if(unsBatchList.size()>1000){
               Id batchInstanceId = Database.executeBatch(new BLN_ExportSurveyByTicketBatchTemplate(querystring, selectedQuestion), 1000);
            return new Pagereference('/BLN_SurveyByAttendeeReportCheckEmail');
              }else{
                  return null;
              } 
    }
      

    public integer totalOrdersPrint{get;set;}
   //printing functionality for survey by questions tab
   public  LIST<responsesInner> responsesInnerListForQuestionsXport{get;set;}
   public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> showeachQueSurveListXprint{get;set;}

    
    
   public integer totalOrdersPrintTic{get;set;}
  

    //Methods to show item pool summary and details
    public Boolean showItemPoolQuestionLevelSurvey{get;set;}
    public Boolean showItemPoolQuestionDetails{get;set;}
    public Boolean showItemPoolItemLevelSurvey{get;set;}
    public Boolean showItemPoolItemDetails{get;set;}
    public Boolean showItemPoolAttendeeLevelSurvey{get;set;}
    public LIST<User_Answer__c> itemPooluserAnswersList{get;set;}

    public List<SelectOption> questionsForItemPool{get;set;}
    public Map<ID, Item_Question__c> questionsForItemPoolMap{get;set;}
    public String SelectedItempoolQuestion{get;set;}

    public String itemPoolitemAnswerType{get; set;}
    //public Integer summaryCount{get;set;}
    public Decimal responseGivenPercentForItemPool{get; set;}
    public Decimal responseNotGivenPercentForItemPool{get; set;}
    public String selectedItemPoolName{get; set;}

    public Decimal allResponsesForItemPool{get; set;}
    public Decimal notGivenResponsesForItemPool{get; set;}
    public Decimal bookedTicketsForItemPool{get; set;}

    public PageReference surveyDataForItemPoolQuestion(){
        showQuestionLevelSurvey= FALSE;
        showQuestionDetails= true;
        showItemLevelSurvey= FALSE;
        showItemDetails= FALSE;
        showAttendeeLevelSurvey= FALSE;
        detailInf=false;


        showItemPoolQuestionLevelSurvey= FALSE;
        showItemPoolQuestionDetails= TRUE;
        showItemPoolItemLevelSurvey= FALSE;
        showItemPoolItemDetails= FALSE;
        showItemPoolAttendeeLevelSurvey= FALSE;

        
        showQuestionDetailsForItemPool=true;

        responsesItemPoolInnerList= new LIST<responsesItemPoolInner>();
        itemPooluserAnswersList= new LIST<User_Answer__c>();

        itemPoolId=ApexPages.currentPage().getParameters().get('itemPoolId');
        system.debug('   ITEMPOOL ID FROM LIST  '+itemPoolId);

        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        LIST<Item_Question__c> questionsPool= new LIST<Item_Question__c>();
        if(itemPoolId != NULL || itemPoolId != ''){
            questionsPool=surveyQuestionBAL.itemQuestionsForItemPool(itemPoolId);
        }else if(itemPoolId == NULL || itemPoolId == ''){
            questionsPool= surveyQuestionBAL.eventLevelQuestions(selectedEvent);
        }
        System.debug('QPQPQPQPQ::::::%%'+questionsPool.size());
        system.debug('  QUESTIONSPOOOOOL SIZE '+questionsPool.size());
        questionsForItemPool= new LIST<selectoption>();
        questionsForItemPoolMAP= new MAP<Id, Item_Question__c>();
        set<id> iqset1=new set<id>();
        for(Item_Question__c itemQuestionPool : questionsPool){
        iqset1.add(itemQuestionPool.id);
            String ansPool='';
             //for(User_Answer__c ua : itemQuestionPool.User_Answers__r){
                    //if(ua.Item_Question__r.Question__r.Name==itemQuestionPool.Question__r.Name ){
                        ansPool+=itemQuestionPool.Question__r.Name+',';
                    //}
              //  }
                if(ansPool.contains(itemQuestionPool.Question__r.Name)){
                    if(itemQuestionPool.User_Answers__r.size() >0){
                    questionsForItemPool.add(new SelectOption(itemQuestionPool.Id, itemQuestionPool.Question__r.Question_Text__c));
                    questionsForItemPoolMAP.put(itemQuestionPool.Id, itemQuestionPool);
                    SelectedItempoolQuestion= itemQuestionPool.Id;
                }
        }
        }
         
        
        
        System.debug('QQQQQQQQQSSSS:'+SelectedItempoolQuestion);
         
        summaryResponseDataForItemPool();

        return null;
    }
    
    public integer respondedItemPoolAttendees{get;set;}
     public pagereference summaryResponseDataForItemPool(){
         
         itemPoolId= ApexPages.currentPage().getParameters().get('itemPoolId');
        
        system.debug('itemPoolId'+itemPoolId+'    SelectedItempoolQuestion'+SelectedItempoolQuestion);
        
        showItemPoolAttendeeLevelSurvey= FALSE;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();

        responsesItemPoolInnerList= new LIST<responsesItemPoolInner>();
        itemPooluserAnswersList= new LIST<User_Answer__c>();

        totalOrderpools=0;
        
        if(questionsForItemPoolMAP.get(SelectedItempoolQuestion).question__r.id!=Null){
            if(questionsForItemPoolMAP.get(SelectedItempoolQuestion).question_level__c=='Event Level'){
                totalOrderpools=[select count() from order__c where events__c = : selectedEvent and order_status__c!='Cancelled' and Order_status__c!='Abandoned'];
            }else if(questionsForItemPoolMAP.get(SelectedItempoolQuestion).question_level__c=='Ticket Level' && questionsForItemPoolMAP.get(SelectedItempoolQuestion).Item__c!=null && questionsForItemPoolMAP.get(SelectedItempoolQuestion).item__r.item_type__r.name!='Package'){
                totalOrderpools=[select count() from ticket__c where item__c = : questionsForItemPoolMAP.get(SelectedItempoolQuestion).item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }else if(questionsForItemPoolMAP.get(SelectedItempoolQuestion).question_level__c=='Ticket Level' && questionsForItemPoolMAP.get(SelectedItempoolQuestion).Item__c!=null && questionsForItemPoolMAP.get(SelectedItempoolQuestion).item__r.item_type__r.name=='Package'){
                totalOrderpools=[select count() from ticket__c where item__c = : questionsForItemPoolMAP.get(SelectedItempoolQuestion).item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null  and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }else if(questionsForItemPoolMAP.get(SelectedItempoolQuestion).question_level__c=='Ticket Level' && questionsForItemPoolMAP.get(SelectedItempoolQuestion).Item_pool__c!=null){
                totalOrderpools=[select count() from ticket__c where Item_pool__c= : questionsForItemPoolMAP.get(SelectedItempoolQuestion).Item_pool__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null  and order__r.order_status__c!='Cancelled' and order__r.Order_status__c!='Abandoned'];
            }
        }
        //response count
        respondedItemPoolAttendees=1;
        List<user_answer__c> usrAnsList=new List<user_answer__c>();
        string uansString='';
        for(user_answer__c u : [select id,name,ticket__r.id from user_answer__c where ticket__r.event__c =: selectedEvent and item_question__c= : SelectedItempoolQuestion and  (item_question__r.item__c = : itemPoolId OR item_question__r.Item_pool__c = : itemPoolId) and ticket__r.order__r.order_status__c!='Cancelled' and ticket__r.order__r.Order_status__c!='Abandoned']){
            if(!uansString.contains(u.ticket__r.id)){
                uansString+=u.ticket__r.id;
                usrAnsList.add(u);
            }
        }
        respondedItemPoolAttendees=usrAnsList.size();
        
        system.debug('QPQPQPQ::::'+questionsForItemPoolMAP.get(SelectedItempoolQuestion).question__r.id);

        LIST<AggregateResult> userAnswersResponsesForItemPool= new LIST<AggregateResult>();
        userAnswersResponsesForItemPool= surveyQuestionBAL.userAnswersForItemPoolQuestion(SelectedItempoolQuestion);
        System.debug('MSMSMSMSMSMSMS:::'+questionsForItemPoolMAP.get(SelectedItempoolQuestion).Question__r.Answer_Type__c);
        //if(Null != questionsForItemPoolMAP.get(SelectedItempoolQuestion).Question__r.Answer_Type__c)
        itemPoolitemAnswerType= questionsForItemPoolMAP.get(SelectedItempoolQuestion).Question__r.Answer_Type__c;
        //if(Null != questionsForItemPoolMAP.get(SelectedItempoolQuestion).item__r.item_name__c)
        selectedItemPoolName= questionsForItemPoolMAP.get(SelectedItempoolQuestion).item_Pool__r.item_pool_name__c;
        allResponsesForItemPool= 0;
        bookedTicketsForItemPool= 0;
        notGivenResponsesForItemPool=0;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        MAP<String, Decimal> BookedTicketsForItemPoolMAP= new MAP<String, Decimal>();
        BookedTicketsForItemPoolMAP= surveyQuestionBAL.bookedTicketsForItemPool(itemPoolId);
        bookedTicketsForItemPool= BookedTicketsForItemPoolMAP.get('BookedCountForItemPool');
        allResponsesForItemPool= BookedTicketsForItemPoolMAP.get('ResponsesCountForItemPool');
        System.debug('AAAAAAAAAAAAAAAAARRRRRR######:'+allResponsesForItemPool);
        notGivenResponsesForItemPool= BookedTicketsForItemPoolMAP.get('NotGivenResponsesCountForItemPool');

        system.debug(SelectedItempoolQuestion+'  SELECTED QUESTIONPOOOOOOOOO:::  '+allResponsesForItemPool+' BOOKED TICKETSPOOOLLLLL:  '+bookedTicketsForItemPool);
        if(allResponsesForItemPool != 0 && bookedTicketsForItemPool !=0){
            responseGivenPercentForItemPool= (allResponsesForItemPool*100)/ bookedTicketsForItemPool;
        }else{
            responseGivenPercentForItemPool= 0;
        }


        responseNotGivenPercentForItemPool= 100- responseGivenPercentForItemPool;
        system.debug(responseGivenPercentForItemPool+' RESPONSE NOT GIVEN PERCENTAGEWWWWWW  '+responseNotGivenPercentForItemPool);
        system.debug('  ALL RESPONSES '+allResponsesForItemPool);
        for(AggregateResult agg: userAnswersResponsesForItemPool){
            
            String ansType= String.valueOf(agg.get('ansType'));
            String countString= String.valueOf(agg.get('selCount'));
            Integer ansCount= Integer.valueOf(countString);
            Decimal percent=0;
            System.debug('AAAAAAAAAAAAAAAAARRRRRR:'+allResponsesForItemPool);
            if(ansCount != 0 && allResponsesForItemPool != 0){
                percent= ((ansCount*100)/allResponsesForItemPool);
            }
            system.debug(ansCount+'   ANS STRING  '+allResponsesForItemPool+'   '+'   '+percent);
            responsesItemPoolInnerList.add(new responsesItemPoolInner(ansType, ansCount, percent));
        }
        
        
        //detailResponseDataForItemPool();
        return null;
    }
    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1> surveyAttendeeInnerList2{get; set;}
    public pagereference detailResponseDataForItemPool(){
        showItemPoolAttendeeLevelSurvey= FALSE;
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        //itemPooluserAnswersList= new LIST<User_Answer__c>();
        //itemPooluserAnswersList= surveyQuestionBAL.userAnswersListForItemPoolQuestion(SelectedItempoolQuestion);

        surveyAttendeeInnerList2= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1>();
        surveyAttendeeInnerList2=surveyQuestionBAL.gnUsersForSurvey1(SelectedItempoolQuestion);
        return null;
    }

    //Method to export and print 'Survey By Question Tab'
    public  List<Item_Question__c> usrAnsList{get;set;}
    public String xportQA{get;set;}//storing questions whose has answers
    public Set<id> xportQATemp2{get;set;}
    public Set<id> xportQATemp{get;set;}//storing questions whose has answers
    public  LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1> surveyAttendeeInnerListForPrint1{get; set;}

    public  LIST<responsesInnerQUEANS> respXportPrintList{get; set;}
    public  LIST<responsesInnerQUEANS> respXportPrintList2{get; set;}

    public integer totatTicketLevelOrders {get;set;}

    public PageReference exportingPrintingQA(){
    String searchKey = ApexPages.currentPage().getParameters().get('searchTicket'); 
        usrAnsList = new List<Item_Question__c>();
        surveyQuestionBAL= new BLN_SurveyQuestionsReportCon_BAL();
        usrAnsList = surveyQuestionBAL.exportPrintQueAns(selectedEvent,searchkey);
        //Getting quetions list those have answers in print
        xportQA='';
        xportQATemp=new Set<id>();
        xportQATemp2=new Set<id>();
        Set<id> xportQATemp3=new Set<id>();
        List<AggregateResult> respForExpPrint=new List<AggregateResult>();
         List<AggregateResult> respForExpPrint2=new List<AggregateResult>();
        for(Item_Question__c iqqq : usrAnsList){
            for(User_Answer__c uaaa : iqqq.User_Answers__r){
                if((uaaa.Item_Question__r.Question__r.Name==iqqq.Question__r.Name) && uaaa.uanswer_text__c != Null){
                    xportQA+=uaaa.Item_Question__r.Question__r.Name+',';
                    xportQATemp.add(iqqq.Question__r.Id);
                }
            }

            if(iqqq.question_level__c=='Ticket Level'){
                for(User_Answer__c uaaa : iqqq.User_Answers__r){
                    if(uaaa.Item_Question__r.Question__r.Name==iqqq.Question__r.Name && uaaa.uanswer_text__c == Null && uaaa.item_question__r.question_level__c=='Ticket Level')
                    xportQATemp2.add(uaaa.ticket__r.Id);
                    if((uaaa.Item_Question__r.Question__r.Name==iqqq.Question__r.Name) && uaaa.uanswer_text__c != Null){
                        xportQA+=uaaa.Item_Question__r.Question__r.Name+',';
                        //xportQATemp2.add(iqqq.item__r.Id);

                        xportQATemp3.add(iqqq.item_pool__r.Id);
                    }
                }
            }

        }
        totatTicketLevelOrders=0;
        totatTicketLevelOrders=[select count() from ticket__c where id in : xportQATemp2 and ticket_status__c='Booked' and Event__c= :  selectedEvent and parent_id__c =null]+1;

        respForExpPrint.addAll(surveyQuestionBAL.userAnswersForItemQuestionForExportPrint(selectedEvent,xportQATemp));
        respForExpPrint2= [SELECT COUNT(Id) selCount2,UAnswer_Text_Update__c ansType2, Item_Question__r.Question__r.Id QueID2
                                 FROM User_Answer__c
                                 WHERE (Item_Question__r.item__C in : xportQATemp2 and Item_Question__r.item_pool__c in : xportQATemp3) // OR Item_Question__r.item_pool__c in : xportQATemp3
                                 and ticket__r.ticket_status__c='Booked'
                                 GROUP BY UAnswer_Text_Update__c,Item_Question__r.Question__r.Id];

        allResponses=0;
        bookedTickets=0;
        MAP<String,Decimal> BookedTicketsMAP=new MAP<String,Decimal>();

        BookedTicketsMAP= surveyQuestionBAL.bookedTicketsForEvent(selectedEvent);
            bookedTickets= BookedTicketsMAP.get('BookedCount');
            allResponses=surveyQuestionBAL.allUserAnswers(selectedQuestion);

        respXportPrintList=new LIST<responsesInnerQUEANS>();
        System.debug('XXXXXX:'+respForExpPrint.size());
        for(AggregateResult aagg : respForExpPrint){
             String ansType= String.valueOf(aagg.get('ansType'));
             System.debug('WWWWW:'+ansType);
             String queType= String.valueOf(aagg.get('QueID'));
            String countString= String.valueOf(aagg.get('selCount'));
            Integer ansCount= Integer.valueOf(countString);
            Decimal percent=0;
                respXportPrintList.add(new responsesInnerQUEANS(ansType,queType, ansCount, percent));
        }

         respXportPrintList2=new LIST<responsesInnerQUEANS>();
         string uniqueans='';
        for(AggregateResult aagg2 : respForExpPrint2){
            if(String.valueOf(aagg2.get('ansType2')) !=Null){

                 String ansType2= String.valueOf(aagg2.get('ansType2'));
                 String queType2= String.valueOf(aagg2.get('QueID2'));
                String countString2= String.valueOf(aagg2.get('selCount2'));
                Integer ansCount2= Integer.valueOf(countString2);
                Decimal percent2=0;

                    respXportPrintList2.add(new responsesInnerQUEANS(ansType2,queType2, ansCount2, percent2));
            }
        }

        surveyAttendeeInnerListForPrint1=new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1>();
        surveyAttendeeInnerListForPrint1=surveyQuestionBAL.gnUsersForSurveyForPrint1(selectedEvent);

        return null;
    }

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
    //Downloading two sheets in exporting
    public String xlsHeader{
        get {
            return '<?xml version="1.0"?> <?mso-application progid="Excel.Sheet"?>';
         }
    }

    //Survey Questions for nested questins
    public class surveyCls{
    public Item_Question__c question{get;set;}
    public List<user_Answer__c> answers{get;set;}
    public surveyCls(Item_Question__c question1,List<user_Answer__c> answers1){
        question = new Item_Question__c();
        answers = new List<user_Answer__c>();
        if(question1!=null){
        this.question =question1;
        }
        if(answers1.size()>0){
        this.answers = answers1;
        }
    }
  }

  //returning event and ticket level question answers for nested question answers
  public BLN_Ticket_Dao ticketDAOClass{get;set;}
  public List<surveyCls> ticketLevelQuestions {get;set;}
  public List<surveyCls> eventLevelQuestions {get;set;}
  public void nestedQueAns(){
      ticketLevelQuestions = new  List<surveyCls>();
   eventLevelQuestions = new  List<surveyCls>();
   SET<id> iteml  = new SET<Id>();
   ticketDAOClass=new BLN_Ticket_Dao ();
        List<Ticket__c> bookedTList=new List<Ticket__c>();
        bookedTList=ticketDaoClass.eventBookedTickets(selectedEvent);
   SET<id> ticketID= new SET<Id>();

       for(Ticket__c tkt : bookedTList){
           if(tkt.Parent_ID__c!=null){
           iteml.add(tkt.Item_pool__c);
        }else{
           iteml.add(tkt.Item__c);
        }
       ticketID.add(tkt.id);
       }

    System.debug('BBBBBBBBBBB '+iteml);

    Map<ID, Item_Question__c> itemQue = new Map<ID, Item_Question__c>([select Question__r.Answer_Type__c,Question__r.Question_Text__c,id,Question_Level__c,Event__c,Question__c,Question__r.Question_Order__c,Question__r.BLN_Parent_Answer__c,Question__r.Name from Item_Question__c where (Item__c In :iteml OR item_pool__c in :iteml  ) OR Event__c=:selectedEvent order by Question__r.Question_Order__c ]);
    Map<ID, User_Answer__c> itemans = new Map<ID, User_Answer__c>([select BLN_Answer__r.Answer_Text__c,BLN_Answer__c,Item_Question__c,Item_Question__r.Question__r.Name,UAnswer_Text__c,Ticket__c from User_Answer__c where Item_Question__c IN :itemQue.keySET() and ticket__c in : ticketID and ticket__r.ticket_status__c='Booked']);

    for(Item_Question__c iq:itemQue.values()){
      List<User_Answer__c> unsList = new List<User_Answer__c>();
      boolean addflag=false;
      for(User_Answer__c uns:itemans.values()){
         if(iq.id == uns.Item_Question__c){
           unsList.add(uns);
           if(iq.Question__r.BLN_Parent_Answer__c==null)
            addflag=true;
            else if(iq.Question__r.BLN_Parent_Answer__c!=null&& uns.BLN_Answer__r.Answer_Text__c!=null)
            addflag=true;
            else
            addflag=false;
         }
       }
         if(addflag==true)
         if(iq.Question_Level__c!='Ticket Level'){
                eventLevelQuestions.add(new surveyCls(iq,unsList));
            }else{
                ticketLevelQuestions.add(new surveyCls(iq,unsList));
            }
    }
    system.debug('EEEEEE::'+eventLevelQuestions.size());
    system.debug('TTTTTT::'+ticketLevelQuestions.size());
  }

  //Exporting survey By attendee tab
  public  List<Ticket__c> ticCountList{get;set;}
    public PageReference  displaySurveyRepAttendeeData(){

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
    }

     
        public  list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> showeachQueSurveList{get;set;}
        public string queName{get;set;}
        public string answerOption{get;set;}
        public integer totalQueWiseCount{get;set;}
        public integer totalQueWiseCountEvent{get;set;}
        public string islevel{get;set;}
        public string isTicketLevel{get;set;}
        public list<item_question__c> checkBoxQA{get;set;}
        
        public string questionID{get;set;}
        public PageReference showSurveyInfoForQuestion(){

        system.debug(' QUESTION ID FOR IQ '+ApexPages.currentPage().getParameters().get('questionID'));
        questionID= ApexPages.currentPage().getParameters().get('questionID');
        queName='';
        question__c q=[select id,name,Question_Text__c from question__c where id= : questionID and event__c = : selectedEvent limit 1 ];
        queName=q.Question_Text__c ;

        answerOption='';
        item_question__c iq=[select id,name,question__r.answer_type__c,question_level__c,item__c,item_pool__c,item__r.item_type__r.name,item_pool__r.item_type__r.name from item_question__c where question__c = : questionID and question__r.event__c = : selectedEvent  limit 1];
        answerOption=iq.question__r.answer_type__c ;
        
        
        List<item_question__c> iqListSize=[select id,name,question__r.answer_type__c,question_level__c,item__c,item_pool__c,item__r.item_type__r.name,item_pool__r.item_type__r.name from item_question__c where question__c = : questionID and question__r.event__c = : selectedEvent];
        System.debug('FFFF11111::'+iqListSize.size());
        totalQueWiseCount=0;
        List<item_question__c> iqList=new List<item_question__c>();
        iqList=[select id,name,question_level__c,item__r.id,item__c,item_pool__c,item_pool__r.id,question__c,question__r.id,(select id,name,ticket__r.ticket_status__c,ticket__r.id,uanswer_text__c,item_question__r.question_level__c,ticket__r.parent_id__c from user_answers__r where ticket__r.ticket_status__c='Booked') from item_question__c where question__c = : questionID];
        System.debug('FFFF22222::'+iqListSize.size());
        set<id> sid1=new set<id>();
        set<id> sid2=new set<id>();
        set<id> sid3=new set<id>();
        islevel='';
        for(item_question__c iq1 : iqList){
                for(user_answer__c ua : iq1.user_answers__r){
                        if(ua.item_question__r.question_level__c=='Event Level'){
                                sid1.add(ua.ticket__r.id);
                                islevel+='Event Level';
                        }
                        if(ua.item_question__r.question_level__c=='Ticket Level'){
                                sid2.add(ua.ticket__r.id);
                                isTicketLevel+='Ticket Level';
                        }
                }
        }
        totalQueWiseCount=[select count() from user_answer__c where item_question__r.question__c = : questionID and ticket__r.ticket_status__c='Booked'];
        totalQueWiseCountEvent=0;
        System.debug('rrrrrrrrrrr1');
        for(item_question__c iqs : iqListSize){
         System.debug('rrrrrrrrrrr222');
            if(iqs.question_level__c=='Event Level'){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from order__c where events__c = : selectedEvent and order_status__c!='Cancelled' and Order_status__c!='Abandoned'];
                //System.debug('CCCCCCC-Event::'+[select count() from order__c where events__c = : selectedEvent and order_status__c!='Cancelled' and Order_status__c!='Abandoned']); 
            }else if(iqs.question_level__c=='Ticket Level' && iqs.Item__c!=null && iqs.item__r.item_type__r.name!='Package'){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from ticket__c where item__c = : iqs.item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent];
            //System.debug('CCCCCCC-Admin Tic::'+[select count() from ticket__c where item__c = : iqs.item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent]);
            }else if(iqs.question_level__c=='Ticket Level' && iqs.Item__c!=null && iqs.item__r.item_type__r.name=='Package'){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from ticket__c where item__c = : iqs.item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null ];
            //System.debug('CCCCCCC-Package Tic::'+[select count() from ticket__c where item__c = : iq.item__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null ]);
            }else if(iqs.question_level__c=='Ticket Level' && iqs.Item_pool__c!=null){
                totalQueWiseCountEvent=totalQueWiseCountEvent+[select count() from ticket__c where Item_pool__c= : iqs.Item_pool__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null ];
            //System.debug('CCCCCCC-Line Item::'+[select count() from ticket__c where Item_pool__c= : iq.Item_pool__c and ticket_status__c='Booked' and ticket_status__c!='Cancelled'  and event__c = : selectedEvent and parent_id__c!=null ]);
            }
        }
        


        checkBoxQA=new list<item_question__c>();
        checkBoxQA=[select id,name,question_level__c,question__r.id,(select id,name,uanswer_text__c,Item_Question__r.question__r.id,Item_Question__r.question__r.Answer_Type__c from user_answers__r where ticket__r.ticket_status__c='Booked') from item_question__c where question__c= : questionID and question__r.event__c = : selectedEvent];

        showeachQueSurveList= new LIST<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner>();
        //showeachQueSurveList= surveyQuestionBAL.sendingSurveyInfoByQuestion(selectedEvent,questionID);

        //calculating responses
        responsesInnerListForQuestions=new LIST<responsesInner>();
        LIST<AggregateResult> userAnswersResponsesForQuestionWise= new LIST<AggregateResult>();
        userAnswersResponsesForQuestionWise=surveyQuestionBAL.userAnswersQuestionWise(questionID);

        for(AggregateResult agg: userAnswersResponsesForQuestionWise){
            String ansType= String.valueOf(agg.get('ansType'));
            String countString= String.valueOf(agg.get('selCount'));
            Integer ansCount= Integer.valueOf(countString);
            Decimal percent=0;

            responsesInnerListForQuestions.add(new responsesInner(ansType,null, ansCount, percent));
        }

        showQuestionLevelSurvey= FALSE;
        showQuestionDetails= FALSE;
        showItemLevelSurvey= FALSE;
        showItemDetails= TRUE;
        showAttendeeLevelSurvey= FALSE;
        return null;
    }

    public pageReference backtoSurveyByQue(){
        showItemDetails=false;
        PageReference pg=new PageReference('/apex/BLN_SurveyQuestionsReport');
        pg.setRedirect(true);
        return pg;
    }
    
        //method to export responses by Ticket
     public pageReference exportResponsesByTicket(){
        detailResponseData();
        PageReference pg=new PageReference('/apex/BLN_SurveyByTicketTabItemResponseExport');
        //pg.getParameters().put('myItmQueId',apexpages.currentpage().getparameters().get('myItmQueId'));
        return pg;
    }
    
    public list<User_Answer__c> unsRespList{get;set;}
    public pageReference exportResponsesByTicketBatch(){
        
        //myItmQueId=apexpages.currentpage().getparameters().get('myItmQueId');
        //System.debug('QQQQQIIIIIDDDD::'+myItmQueId);
        unsRespList= new list<User_Answer__c> (); 
        string querystring='SELECT Id,ticket__r.tkt_profile__r.Email__c,Uanswer_text_update__c,item_question__r.item__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__c,item_question__r.item_pool__r.item_pool_name__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c,Ticket__r.order__r.name, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c'
                              +' FROM User_Answer__c '
                              +'WHERE Item_Question__c = \''+selectedQuestion+'\''
                              +' AND ticket__r.ticket_status__c=\'Booked\''
                              +' AND Ticket__r.Order__r.Order_Status__c != \'Abandoned\' and Ticket__r.Order__r.Order_Status__c != \'Cancelled\''
                               //+' AND item_question__r.question__c=\''+myItmQueId+'\''
                              +' ORDER BY ticket__r.order__r.createdDate ASC limit 50000'; 
        unsRespList=database.query(querystring);                      
      System.debug('$$$$$$$:'+unsRespList.size());
      integer responded=surveyAttendeeInnerList1.size();
      string ques=string.valueof(surveyAttendeeInnerList1[0].get('que'));
      
      if(unsRespList.size()>1000){
            Id batchInstanceId = Database.executeBatch(new BLN_ExportSurveyByTicketBatch(querystring, selectedQuestion, selectedItemName,totalOrders,unsRespList,itemAnswerType,responded,ques,responsesInnerList), 1000);
            return new Pagereference('/BLN_SurveyByAttendeeReportCheckEmail');
      }else{
          return null;
      }
    }
 
    
        //method to export responses by package lines
 public string ques{get;set;}
     public pageReference exportResponsesByPoolLines(){
        //detailResponseDataForItemPool();
        ques = questionsForItemPoolMAP.get(SelectedItempoolQuestion).Question__r.Question_Text__c;
        system.debug('itemPoolId111'+itemPoolId);
        //summaryResponseDataForItemPool();
        PageReference pg=new PageReference('/apex/BLN_SurveyByTicketPoolLineResponseExport');
        return pg; 
    }
    
    public list<user_answer__c> unsRespPoolList{get;set;}
    public pageReference exportResponsesByPoolLinesBatch(){
         unsRespPoolList=new list<user_answer__c> ();
        summaryResponseDataForItemPool();
        //detailResponseDataForItemPool();
        string querystring='SELECT Id,ticket__r.tkt_profile__r.Email__c,Uanswer_text_update__c,item_question__r.item__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__c,item_question__r.item_pool__r.item_pool_name__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c,Ticket__r.order__r.name, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c'
                              +' FROM User_Answer__c '
                              +'WHERE Item_Question__c = \''+SelectedItempoolQuestion+'\''
                              +' AND ticket__r.ticket_status__c=\'Booked\''
                              +' AND Ticket__r.Order__r.Order_Status__c != \'Abandoned\' and Ticket__r.Order__r.Order_Status__c != \'Cancelled\''
                               //+' AND item_question__r.question__c=\''+myItmQueId+'\''
                              +' ORDER BY ticket__r.order__r.createdDate ASC limit 50000'; 
                              
      unsRespPoolList=database.query(querystring);
      integer responded=respondedItemPoolAttendees;//surveyAttendeeInnerList2.size();
      //string ques=questionsForItemPoolMAP.get(SelectedItempoolQuestion).Question__r.Question_Text__c;
      if(unsRespPoolList.size()>1000){
      system.debug('sssssssssss');
            Id batchInstanceId = Database.executeBatch(new BLN_ExportSurveyByPoolLineResponseBatch(querystring, SelectedItempoolQuestion,selectedItemPoolName,totalOrderpools,unsRespPoolList,itemPoolitemAnswerType,responded,ques,responsesItemPoolInnerList), 1000);
            return new Pagereference('/BLN_SurveyByAttendeeReportCheckEmail');
      }else{
      system.debug('nnnnnnnn');
          return null;
      }
    
    
    }
    public pageReference surveyByQuestionTabExport(){
        return null;
    }
 
    
}