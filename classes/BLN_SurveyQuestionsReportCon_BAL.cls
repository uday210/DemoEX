/***********************************************************************************************
*   Controller Name : BLN_SurveyQuestionsReportCon_BAL
*   Date            : 01/12/2015
*   Author          : Manasa Gandham
*   Purpose         : This class is to get the list of Survey Questions
*   Change History  : 01/12/2015
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*    01/12/2015             Manasa Gandham                 To Create Page
*  
**************************************************************************************************/

public without sharing class BLN_SurveyQuestionsReportCon_BAL{

    public BLN_SurveyQuestionsReportCon_BAL(){
    
    }
    
    public BLN_Question_DAO questionDAOClass{get; set;}
    public BLN_Item_Question_DAO itemQuestionDAOClass{get; set;}
    public BLN_Item_DAO itemDAOClass{get; set;}
    
    public LIST<Item_Question__c> surveyQuestionsForEvent(String eventId){
    
        questionDAOClass= new BLN_Question_DAO();
        itemQuestionDAOClass= new BLN_Item_Question_DAO();
        LIST<Item_Question__c> itemQuestionsListDummy= new LIST<Item_Question__c>();
        LIST<Item_Question__c> itemQuestionsList= new LIST<Item_Question__c>();
        LIST<Question__c> questionsList= new LIST<Question__c>();
        MAP<Id, LIST<BLN_Answer__c>> answersListMAP= new MAP<Id, LIST<BLN_Answer__c>>();
        
        // To get Questions list along with User Answers
        itemQuestionsList= itemQuestionDAOClass.itmquestionslist(eventId, itemQuestionsListDummy);        
        system.debug(itemQuestionsList.size()+'  ITEM QUESTIONS LIST '+itemQuestionsList);
        // To get Questions list along with Answers
        questionsList= questionDAOClass.questionsForEvent(eventId);
        for(Question__c question: questionsList){
            LIST<BLN_Answer__c> ansList= new LIST<BLN_Answer__c>();
            ansList= question.BLN_Answers__r;
            answersListMAP.put(question.Id, ansList);
        }
        
        return itemQuestionsList;
    }
    
    //Method to calculate % for print and export
     public MAP<String, Decimal> bookedTicketsForEventForPrintXport(String selectedEvent){
        Decimal bookedCount=0;
        Decimal responsesCount= 0;
        Decimal notGivenResponsesCount= 0;
        
        Decimal responsesCountDuplicate= 0;
        
        ticketDAOClass= new BLN_Ticket_DAO();
        MAP<String, Decimal> BookedTicketsMAP= new MAP<String, Decimal>();
        LIST<Ticket__c> bookedTickets= new LIST<Ticket__c>();
        bookedTickets= ticketDAOClass.bookedTicketsForEventForPrintExport(selectedEvent);
        bookedCount= bookedTickets.size();
        System.debug('BCBCBCBCQQQQQQQQQQQQQQQQQ:'+bookedCount);
        for(Ticket__c tic: bookedTickets){
        
            string rcount='';
            string nonRcount='';
            //Answer type is checkboxes
            if(tic.User_Answers__r.size() >0){
                responsesCount = responsesCount+1; 
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        responsesCount = responsesCount+1;        
                    }else{
                        rcount+=tic.id+',';
                    }
                }*/
            }
            if(tic.User_Answers__r.size() <=0){
                notGivenResponsesCount = notGivenResponsesCount+1; 
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        notGivenResponsesCount = notGivenResponsesCount+1;      
                    }else{
                        nonRcount+=tic.id+',';
                    }
                }*/
                
            }
            
            //Answer type is other than checkboxes
            if(rcount.contains(tic.id)){
                //responsesCount = responsesCount+1; 
            }
            if(nonRcount.contains(tic.id)){
                //notGivenResponsesCount = notGivenResponsesCount +1; 
            }
            
        
        }
        BookedTicketsMAP.put('BookedCount', bookedCount);
        BookedTicketsMAP.put('ResponsesCount', responsesCount);
        BookedTicketsMAP.put('NotGivenResponsesCount', notGivenResponsesCount); 
        return BookedTicketsMAP;
    }
    
    //For an Event map
    public MAP<String, Decimal> bookedTicketsForEvent(String selectedEvent){
        Decimal bookedCount=0;
        Decimal responsesCount= 0;
        Decimal notGivenResponsesCount= 0;
        
        Decimal responsesCountDuplicate= 0;
        
        ticketDAOClass= new BLN_Ticket_DAO();
        MAP<String, Decimal> BookedTicketsMAP= new MAP<String, Decimal>();
        LIST<Ticket__c> bookedTickets= new LIST<Ticket__c>();
        bookedTickets= ticketDAOClass.bookedTicketsForEvent(selectedEvent);
        bookedCount= bookedTickets.size();
        System.debug('BCBCBCBC:'+bookedCount);
        for(Ticket__c tic: bookedTickets){
        
            string rcount='';
            string nonRcount='';
            //Answer type is checkboxes
            if(tic.User_Answers__r.size() >0){
                //rcount+= tic.id+',';
                responsesCount = responsesCount+1; 
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        responsesCount = responsesCount+1;        
                    }else{
                        rcount+=tic.id+',';
                    }
                }*/
            }
            if(tic.User_Answers__r.size() <=0){
                notGivenResponsesCount = notGivenResponsesCount+1; 
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        notGivenResponsesCount = notGivenResponsesCount+1;      
                    }else{
                        nonRcount+=tic.id+',';
                    }
                }*/
                
            }
            
            //Answer type is other than checkboxes
            if(rcount.contains(tic.id)){
                //responsesCount = responsesCount+1; 
            }
            if(nonRcount.contains(tic.id)){
                //notGivenResponsesCount = notGivenResponsesCount +1; 
            }            
        
        }
        BookedTicketsMAP.put('BookedCount', bookedCount);
        BookedTicketsMAP.put('ResponsesCount', responsesCount);
        BookedTicketsMAP.put('NotGivenResponsesCount', notGivenResponsesCount); 
        return BookedTicketsMAP;
    }
    
    
    //For item map
    public MAP<String, Decimal> bookedTickets(String itemId){
        Decimal bookedCount=0;
        Decimal responsesCount= 0;
        Decimal notGivenResponsesCount= 0;
        
        Decimal responsesCountDuplicate= 0;
        
        ticketDAOClass= new BLN_Ticket_DAO();
        MAP<String, Decimal> BookedTicketsMAP= new MAP<String, Decimal>();
        LIST<Ticket__c> bookedTickets= new LIST<Ticket__c>();
        bookedTickets= ticketDAOClass.bookedTicketsForItem(itemId);
        bookedCount= bookedTickets.size();
        System.debug('BCBCBCBC:'+bookedCount);
        for(Ticket__c tic: bookedTickets){
        
            string rcount='';
            string nonRcount='';
            //Answer type is checkboxes
            if(tic.User_Answers__r.size() >0){
                //responsesCount = responsesCount+1;
                rcount+=tic.id+','; 
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        responsesCount = responsesCount+1;        
                    }else{
                        rcount+=tic.id+',';
                    }
                }*/
            }
            if(tic.User_Answers__r.size() <=0){
                //notGivenResponsesCount = notGivenResponsesCount+1; 
                nonRcount+=tic.id+',';
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        notGivenResponsesCount = notGivenResponsesCount+1;      
                    }else{
                        nonRcount+=tic.id+',';
                    }
                }*/
                
            }
            
            //Answer type is other than checkboxes
            if(rcount.contains(tic.id)){
                responsesCount = responsesCount+1; 
            }
            if(nonRcount.contains(tic.id)){
                notGivenResponsesCount = notGivenResponsesCount +1; 
            }
            
        
        }
        BookedTicketsMAP.put('BookedCount', bookedCount);
        BookedTicketsMAP.put('ResponsesCount', responsesCount);
        BookedTicketsMAP.put('NotGivenResponsesCount', notGivenResponsesCount); 
        return BookedTicketsMAP;
    }
    
    //For item pool map
    public MAP<String, Decimal> bookedTicketsForItemPool(String itemPoolId){
        Decimal bookedCountForItemPool=0;
        Decimal responsesCountForItemPool= 0;
        Decimal notGivenResponsesCountForItemPool= 0;
        
        Decimal responsesCountDuplicateForItemPool= 0;
        
        ticketDAOClass= new BLN_Ticket_DAO();
        MAP<String, Decimal> BookedTicketsMAPForItemPool= new MAP<String, Decimal>();
        LIST<Ticket__c> bookedTicketsForItemPool= new LIST<Ticket__c>();
        bookedTicketsForItemPool= ticketDAOClass.bookedTicketsForItemPool(itemPoolId);
        bookedCountForItemPool= bookedTicketsForItemPool.size();
        System.debug('BFBFBFBFCCC:::'+bookedCountForItemPool);
        for(Ticket__c tic: bookedTicketsForItemPool){
        
            string rcount='';
            string nonRcount='';
            //Answer type is checkboxes
            if(tic.User_Answers__r.size() >0){
                responsesCountForItemPool = responsesCountForItemPool+1; 
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        responsesCountForItemPool = responsesCountForItemPool+1;        
                    }else{
                        rcount+=tic.id+',';
                    }
                }*/
            }
            if(tic.User_Answers__r.size() <=0){
                notGivenResponsesCountForItemPool = notGivenResponsesCountForItemPool+1; 
                /*for(User_Answer__c ua : tic.User_Answers__r){
                    
                    if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                        notGivenResponsesCountForItemPool = notGivenResponsesCountForItemPool+1;      
                    }else{
                        nonRcount+=tic.id+',';
                    }
                }*/
                
            }
            
            //Answer type is other than checkboxes
            if(rcount.contains(tic.id)){
                //responsesCountForItemPool = responsesCountForItemPool+1; 
            }
            if(nonRcount.contains(tic.id)){
                //notGivenResponsesCountForItemPool = notGivenResponsesCountForItemPool +1; 
            }
            
        
        }
        BookedTicketsMAPForItemPool.put('BookedCountForItemPool', bookedCountForItemPool);
        BookedTicketsMAPForItemPool.put('ResponsesCountForItemPool', responsesCountForItemPool);
        BookedTicketsMAPForItemPool.put('NotGivenResponsesCountForItemPool', notGivenResponsesCountForItemPool); 
        return BookedTicketsMAPForItemPool;
    }
    
    
    public BLN_UserAnswers_DAO userAnswerDAOClass{get; set;}
    public LIST<AggregateResult> questionsResponses{get; set;}
    
    public Integer allUserAnswers(String itemQuestionId){
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        Integer allResponses= 0;
        allResponses= userAnswerDAOClass.allUserAnswersForItemQuestion(itemQuestionId);
        System.debug('ALALALALA:::'+allResponses);
        return allResponses;
    
    }
    //For Print & Xport 
    public Integer allUserAnswersForPrintXport(String eventId){
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        Integer allResponses= 0;
        allResponses= userAnswerDAOClass.allUserAnswersForItemQuestionPrintXport(eventId);
        System.debug('ALALALALA:::'+allResponses);
        return allResponses;
    
    }
    
    //getting count for question wise responses    
    public LIST<AggregateResult> userAnswersQuestionWise(String questionID){
        questionsResponses= new LIST<AggregateResult>();
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        questionsResponses= userAnswerDAOClass.questionWiseResp(questionID);
        return questionsResponses;
    }
    
    //getting count for question wise responses  for xport  
    public LIST<AggregateResult> userAnswersQuestionWiseXprint(set<id> questionID){
        questionsResponses= new LIST<AggregateResult>();
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        questionsResponses= userAnswerDAOClass.questionWiseRespXprint(questionID);
        return questionsResponses;
    }
    
    //getting count for items    
    public LIST<AggregateResult> userAnswersForItemQuestion(String itemQuestionId){
        questionsResponses= new LIST<AggregateResult>();
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        questionsResponses= userAnswerDAOClass.userAnswersForItemQuestion(itemQuestionId);
        return questionsResponses;
    } 
    
    //getting count for items pool
    public LIST<AggregateResult> questionsResponsesForItemPool{get; set;}
    public LIST<AggregateResult> userAnswersForItemPoolQuestion(String SelectedItempoolQuestion){
        questionsResponsesForItemPool= new LIST<AggregateResult>();
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        questionsResponsesForItemPool= userAnswerDAOClass.userAnswersForItemPoolQuestion(SelectedItempoolQuestion);
        return questionsResponsesForItemPool;
    }    
    
    //For item Question    
    public LIST<User_Answer__c> userAnswersListForItemQuestion(String itemQuestionId){
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
        userAnswersList= userAnswerDAOClass.userAnswersList(itemQuestionId);        
        
        /*surveyQuestionChbxAnsInnrList= new LIST<surveyQuestionChbxAnsInnr>();
        for(User_Answer__c ua : userAnswersList){
            if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                strCh+=strCh+',';        
            }
            surveyQuestionChbxAnsInnrList.add(new surveyQuestionChbxAnsInnr(strCh,ua,userAnswersList));    
        }*/
        
        return userAnswersList;
    }
    
    //Dummy function to show checkbox ans   
    public LIST<surveyQuestionChbxAnsInnr> userChkboxQueAns(String selectedeventid, String itemQuestionId){
        itemQuestionDAOClass= new BLN_Item_Question_DAO();
        LIST<Item_Question__c> userItmQueAnsList= new LIST<Item_Question__c>();
        userItmQueAnsList= itemQuestionDAOClass.eventItemQueAns(selectedeventid,itemQuestionId);        
        
        surveyQuestionChbxAnsInnrList= new LIST<surveyQuestionChbxAnsInnr>();
        for(Item_Question__c iq : userItmQueAnsList){
            String strCh='';
            for(User_Answer__c ua : iq.User_Answers__r){               
                if(ua.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes' && iq.Question__r.Answer_Type__c == 'Checkboxes'){
                    strCh+=ua.uanswer_text__c+',';        
                }
            }
            surveyQuestionChbxAnsInnrList.add(new surveyQuestionChbxAnsInnr(strCh,iq.User_Answers__r));  
        }
        System.debug(surveyQuestionChbxAnsInnrList.size()+':@@@@@@@@@@***@@@@@@@:'+surveyQuestionChbxAnsInnrList);
        return surveyQuestionChbxAnsInnrList;
    }
    
    //Inner class for item question checkbox answrs for event and ticket level
    public LIST<surveyQuestionChbxAnsInnr> surveyQuestionChbxAnsInnrList{get; set;}
    public class surveyQuestionChbxAnsInnr{
        public String checkbxAns{get;set;}
        //public User_Answer__c usrAns{get;set;}
        public LIST<User_Answer__c> usrAnsData{get; set;}
        
        public surveyQuestionChbxAnsInnr(String checkbxAns,LIST<User_Answer__c> usrAnsData){
            this.checkbxAns= checkbxAns;
            //this.usrAns= usrAns;
            this.usrAnsData= usrAnsData;
        }
    }
    
    
    public LIST<surveyAttendeeInner1> gnUsersForSurvey1(String itemQuestionId){
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
        userAnswersList= userAnswerDAOClass.userAnswersList(itemQuestionId);               
        MAP<Id, LIST<User_Answer__c>> ticketsMAP= new MAP<Id, LIST<User_Answer__c>>();
        System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());   
        for(User_Answer__c tic : userAnswersList){
                LIST<User_Answer__c> ticketsListToAdd= new LIST<User_Answer__c>();
                if(ticketsMAP.containsKey(tic.ticket__c)){
                    ticketsListToAdd= ticketsMAP.get(tic.ticket__c);
                    ticketsListToAdd.add(tic);
                    ticketsMAP.put(tic.ticket__c, ticketsListToAdd);
                }else if(! ticketsMAP.containsKey(tic.ticket__c)){
                    ticketsListToAdd.add(tic);
                    ticketsMAP.put(tic.ticket__c, ticketsListToAdd);
                }
        }
        System.debug(LoggingLevel.ERROR, 'Heap Size: ' + Limits.getHeapSize() + '/' + Limits.getLimitHeapSize());
        surveyAttendeeInnerList1= new LIST<surveyAttendeeInner1>();
        string username='';
        for(User_Answer__c tic1 : userAnswersList){
            LIST<User_Answer__c> ticketsListToAdd= new LIST<User_Answer__c>();            
            ticketsListToAdd= ticketsMAP.get(tic1.ticket__r.Id);
            ticketsMAP.remove(tic1.ticket__r.Id);
            if(ticketsListToAdd.size() > 0 && username.contains(tic1.Ticket__r.id)==false){
                username+=tic1.Ticket__r.id+',';
                surveyAttendeeInnerList1.add(new surveyAttendeeInner1(ticketsListToAdd));
            }
        }
        return surveyAttendeeInnerList1;
    }
    
    public LIST<AggregateResult> gnUsersForSurvey_agg(String itemQuestionId){
        LIST<AggregateResult> userAnswersList= new LIST<AggregateResult>();
        userAnswersList = [Select count(id) c,MIN(item_question__r.question__r.Question_Text__c) que,ticket__r.id from User_Answer__c where  Item_Question__c =: itemQuestionId and ticket__r.order__r.order_status__c!='Abandoned' and ticket__r.order__r.order_status__c!='Cancelled' GROUP BY ticket__r.id];
        return userAnswersList;
    }
    
    public LIST<user_answer__c> gnUsersForSurvey2(String itemQuestionId,LIST<User_Answer__c> userAnswersList1){
        LIST<user_answer__c> gnUsersForSurveytemp=new LIST<user_answer__c> ();
        gnUsersForSurveytemp=userAnswersList1;
        return gnUsersForSurveytemp;
    }
    
    public LIST<surveyAttendeeInner1> gnUsersForSurvey1(String itemQuestionId,LIST<User_Answer__c> userAnswersList1){
        //userAnswerDAOClass= new BLN_UserAnswers_DAO();
        LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
        userAnswersList= userAnswersList1; //userAnswerDAOClass.userAnswersList(itemQuestionId);               
        MAP<Id, LIST<User_Answer__c>> ticketsMAP= new MAP<Id, LIST<User_Answer__c>>();
             
        for(User_Answer__c tic : userAnswersList){
           
                LIST<User_Answer__c> ticketsListToAdd= new LIST<User_Answer__c>();
                if(ticketsMAP.containsKey(tic.ticket__c)){
                    ticketsListToAdd= ticketsMAP.get(tic.ticket__c);
                    ticketsListToAdd.add(tic);
                    ticketsMAP.put(tic.ticket__c, ticketsListToAdd);
                }else if(! ticketsMAP.containsKey(tic.ticket__c)){
                    ticketsListToAdd.add(tic);
                    ticketsMAP.put(tic.ticket__c, ticketsListToAdd);
                }
            
        }
        
        surveyAttendeeInnerList1= new LIST<surveyAttendeeInner1>();
        string username='';
        for(User_Answer__c tic1 : userAnswersList){
            LIST<User_Answer__c> ticketsListToAdd= new LIST<User_Answer__c>();            
            ticketsListToAdd= ticketsMAP.get(tic1.ticket__r.Id);
            
            if(ticketsListToAdd.size() > 0 && username.contains(tic1.Ticket__r.id)==false){
                username+=tic1.Ticket__r.id+',';
                surveyAttendeeInnerList1.add(new surveyAttendeeInner1(ticketsListToAdd));
            }
        }
        return surveyAttendeeInnerList1;
    }
    
    
    public LIST<surveyAttendeeInner1> surveyAttendeeInnerList1{get; set;}
    public class surveyAttendeeInner1{
        public LIST<User_Answer__c> ticketsData1{get; set;}
                
        public List<User_Answer__c> EventlevelList1{get;set;}
        public List<User_Answer__c> TicketlevelList1{get;set;}
        
        public String checkboxValues1 {get;set;}
        
        public surveyAttendeeInner1(LIST<User_Answer__c> ticketsData1){
            this.ticketsData1= ticketsData1;
           
            EventlevelList1=new List<User_Answer__c>();
            TicketlevelList1=new List<User_Answer__c>();
            
            checkboxValues1 ='';
            
            //for(Ticket__c t : ticketsData){
                for(User_Answer__c uaObj : ticketsData1){
                    if(uaObj.Item_Question__r.Question_Level__c == 'Event Level'){
                        if(uaObj.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                            checkboxValues1+=uaObj.uanswer_text_update__c+', ';
                        }
                        EventlevelList1.add(uaObj);
                    }else if(uaObj.Item_Question__r.Question_Level__c == 'Ticket Level'){
                        if(uaObj.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                            checkboxValues1+=uaObj.uanswer_text_update__c+', ';
                        }          
                        TicketlevelList1.add(uaObj);
                    }               
                }
                if(checkboxValues1 != Null || checkboxValues1 != '')
                checkboxValues1=checkboxValues1.removeEnd(', ');
           // }
        }
    
    }
    
    //For itempool Question
    public LIST<User_Answer__c> userAnswersListForItemPoolQuestion(String SelectedItempoolQuestion){
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        LIST<User_Answer__c> userAnswersListForItemPool= new LIST<User_Answer__c>();
        userAnswersListForItemPool= userAnswerDAOClass.userAnswersListForItemPool(SelectedItempoolQuestion);
        return userAnswersListForItemPool;
    }
    
    public String bookedItems{get;set;}
    
    public LIST<BLN_Item__c> surveyQuestionsForItem(String eventId){
        itemDAOClass= new BLN_Item_DAO();
        LIST<BLN_Item__c> itemQuestionsList= new LIST<BLN_Item__c>();
        itemQuestionsList= itemDAOClass.getEventItems(eventId);
        LIST<BLN_Item__c> itemQuestionsListAdd= new LIST<BLN_Item__c>();
        
        ticketDAOClass=new BLN_Ticket_Dao ();
        bookedItems='';
        
        List<Ticket__c> bookedTList=new List<Ticket__c>();
        bookedTList=ticketDaoClass.eventBookedTickets(eventId);
        for(Ticket__c tt : bookedTList){
            bookedItems+=tt.Item__r.Id+',';   
        } 
        
        for(BLN_Item__c i : itemQuestionsList){
            if(bookedItems.contains(i.id)){
                itemQuestionsListAdd.add(i);
            }
        }  
        
        return itemQuestionsListAdd; 
    }
    
    public string eventlevel{get;set;}
    public string ticketlevel{get;set;}
    
    //public integer ticketNo{get;set;}
    
    public BLN_Ticket_DAO ticketDAOClass{get; set;}
    
    public LIST<itemLevelSurvey> dataForItemSurvey(String itemId){
    
        itemDAOClass= new BLN_Item_DAO();
        ticketDAOClass= new BLN_Ticket_DAO();
        LIST<itemLevelSurvey> itemLevelSurveyList= new LIST<itemLevelSurvey>();
        LIST<BLN_Item__c> itemDetails= new LIST<BLN_Item__c>();
        itemDetails= itemDAOClass.itemDetailsForSurvey(itemId);
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        LIST<Ticket__c> ticketsListToAdd= new LIST<Ticket__c>();
        ticketsList= ticketDAOClass.getTicketsforItem(itemId);            
            for(Ticket__c ticket: ticketsList){
               LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
               userAnswersList= ticket.User_Answers__r;
               eventlevel='';
               ticketlevel='';
               
               for(User_Answer__c ua : userAnswersList){
                   if(ua.Item_Question__r.Question_Level__c == 'Event Level')
                   eventlevel+=ua.id;
                   
                   if(ua.Item_Question__r.Question_Level__c == 'Ticket Level'){
                       ticketlevel+=ua.id;
                       //ticketNo=1;
                   }
               }
               
               if(userAnswersList.size() != 0){
                   ticketsListToAdd.add(ticket);
               }
            }
        itemLevelSurveyList.add(new itemLevelSurvey(itemDetails[0], ticketsListToAdd));
        return itemLevelSurveyList;
    }
    
       public class itemLevelSurvey{
        public BLN_Item__c itemData{get; set;}
        public LIST<Ticket__c> ticketsData{get; set;}
        
        public List<User_Answer__c> eventLevelQueList{get;set;}
        public List<User_Answer__c> ticketLevelQueList{get;set;}
        
        public String checkboxList{get;set;}
        
        public itemLevelSurvey(BLN_Item__c itemData, LIST<Ticket__c> ticketsData){
            this.itemData= itemData;
            this.ticketsData= ticketsData;
            
            eventLevelQueList=new List<User_Answer__c>();
            ticketLevelQueList=new List<User_Answer__c>();
            
            checkboxList='';
            
            for(Ticket__c tt : ticketsData){
                for(User_Answer__c usa : tt.User_Answers__r){
                    if(usa.Item_Question__r.Question_Level__c == 'Event Level'){
                        if(usa.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                            checkboxList+=usa.uanswer_text__c+',';
                        }
                        eventLevelQueList.add(usa);
                    }else if(usa.Item_Question__r.Question_Level__c == 'Ticket Level'){
                        if(usa.Item_Question__r.Question__r.Answer_Type__c == 'Checkboxes'){
                            checkboxList+=usa.uanswer_text__c+', ';
                        }          
                        ticketLevelQueList.add(usa);
                    }     
                }
                if(checkboxList != Null || checkboxList != ''    )
                checkboxList=checkboxList.removeEnd(', ');
            }
        }
    }
    
    
    // Code For Survey By Attendee Tab    
    public LIST<surveyAttendeeInner> gnUsersForSurvey(String eventId){
        ticketDAOClass= new BLN_Ticket_DAO();        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        ticketsList= ticketDAOClass.eventBookedTickets(eventId);        
        LIST<Ticket__c> ticketsListWithUA= new LIST<Ticket__c>();
        Set<Id> tid=new Set<Id>();
        for(Ticket__c tic: ticketsList){            
            tid.add(tic.id);             
        }
        
        Set<Id> UAticId=new Set<Id>();
         for(User_Answer__c ua : [SELECT Id,Item_Question__r.Item_Pool__c,uanswer_text_update__c, Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name FROM User_Answer__c where ticket__c in :tid ORDER BY Item_Question__r.Question__r.Question_Order__c asc]){
                UAticId.add(ua.ticket__r.id);    
            }  
        
        for(Ticket__c tic: ticketsList){            
           if(UAticId.contains(tic.Id))
           ticketsListWithUA.add(tic);           
        }
        
        surveyAttendeeInnerList= new LIST<surveyAttendeeInner>();
        if(ticketsListWithUA.size() > 0){
            surveyAttendeeInnerList.add(new surveyAttendeeInner(ticketsListWithUA));
        }
        return surveyAttendeeInnerList;
    }
    
    public LIST<surveyAttendeeInner> surveyAttendeeInnerList{get; set;}
    public class surveyAttendeeInner{
        
        public LIST<Ticket__c> ticketsData{get; set;}
                
        public List<User_Answer__c> EventlevelList{get;set;}
        public List<User_Answer__c> TicketlevelList{get;set;}
        public List<User_Answer__c> AllLevelList{get;set;}
        
        public surveyAttendeeInner(LIST<Ticket__c> ticketsData){
            this.ticketsData= ticketsData;
           
            EventlevelList=new List<User_Answer__c>();
            TicketlevelList=new List<User_Answer__c>();
            AllLevelList=new List<User_Answer__c>();
            set<id> tid=new set<id>();
            for(Ticket__c t : ticketsData){                
                tid.add(t.id);    
            }
            
            for(User_Answer__c uaObj : [SELECT Id,Item_Question__r.Item_Pool__c,uanswer_text_update__c, Item_Question__c,Ticket__r.Item__r.Item_Type__r.Name,Ticket__r.Item__r.Id,Item_Question__r.Question__r.Answer_Type__c ,Ticket__r.Item__r.Item_Name__c,Item_Question__r.item_pool__r.item_type__r.name, Item_Question__r.Question_Level__c, Item_Question__r.Item__c,Item_Question__r.item_pool__r.Item_Pool_Name__c,Item_Question__r.item__r.item_Type__r.name, Item_Question__r.Question__r.Question_Text__c, UAnswer_Text__c, BLN_Answer__c, BLN_Answer__r.Answer_Text__c, Item_Question__r.Item__r.item_Name__c,Ticket__r.Name,Item_Question__r.Question__r.Question_Order__c,item_question__r.item__r.id,item_question__r.item__r.name,item_question__r.item_pool__r.id,item_question__r.item_pool__r.name FROM User_Answer__c where ticket__c in :tid and ticket__r.order__r.order_status__c!='Abandoned' and ticket__r.order__r.order_status__c!='Cancelled' ORDER BY Item_Question__r.Question__r.Question_Order__c asc]){              
                if(uaObj.Item_Question__r.Question_Level__c == 'Event Level'){
                    EventlevelList.add(uaObj);                                                
                }else if(uaObj.Item_Question__r.Question_Level__c == 'Ticket Level'){
                    TicketlevelList.add(uaObj);
                }
                AllLevelList.add(uaObj);               
            }
        }
    
    } 
    
    //Method to get list of quetions for selected item
    public LIST<Item_Question__c> itemQuestionsForItem(String itemId){
    
        itemQuestionDAOClass= new BLN_Item_Question_DAO();
        LIST<Item_Question__c> questionsList= new LIST<Item_Question__c>();
        questionsList= itemQuestionDAOClass.questionsForAnItem(itemId);
        
        return questionsList;
    }
    
    //Method to get list of quetions for selected itemPool
    public LIST<Item_Question__c> itemQuestionsForItemPool(String itemPoolId){
    
        itemQuestionDAOClass= new BLN_Item_Question_DAO();
        LIST<Item_Question__c> questionsPoolList= new LIST<Item_Question__c>();
        questionsPoolList= itemQuestionDAOClass.questionsForAnItemPool(itemPoolId);
        
        return questionsPoolList;
    }
    
    public LIST<Item_Question__c> eventLevelQuestions(String eventId){
        system.debug('  EVENT IN BAL '+eventId);
        itemQuestionDAOClass= new BLN_Item_Question_DAO();
        LIST<Item_Question__c> questionsList= new LIST<Item_Question__c>();
        questionsList= itemQuestionDAOClass.questionsForEvent(eventId);
        system.debug(questionsList.size()+'  QUESTION IN BAL '+questionsList);
        return questionsList;
    }
    
     public class itemQuestionsInner{
        public String questionName{get;set;}
        public String levelType{get; set;}
        public BLN_Item__c itemData{get; set;}
        public List<Item_Pool__c> itemPoolData{get;set;}
        public LIST<Item_Question__c> itemQuestionsData{get; set;}
        public List<itemPoolQuestionInnr> itemPoolQuestionInnrList{get;set;}
        public LIST<User_Answer__c> itemAnsExportPrint{get; set;}
        
        public itemQuestionsInner(String questionName,String levelType, BLN_Item__c itemData, List<Item_Pool__c> itemPoolData,LIST<Item_Question__c> itemQuestionsData,List<itemPoolQuestionInnr> itemPoolQuestionInnrList,List<User_Answer__c> itemAnsExportPrint){
            this.questionName= questionName;
            this.levelType= levelType;
            this.itemData= itemData;
            this.itemPoolData= itemPoolData;
            this.itemQuestionsData= itemQuestionsData;
            this.itemPoolQuestionInnrList=itemPoolQuestionInnrList;
            this.itemAnsExportPrint=itemAnsExportPrint;
        }
    
    }
    
    public list<itemPoolQuestionInnr> itemPoolQuestionInnrList{get;set;}
    public class itemPoolQuestionInnr{
        public string poolQueName{get;set;}
        public Item_Pool__c itemPoolInfo{get;set;}
        public List<Item_Question__c> itmPlQuestionsListInfo{get;set;}
        
        public itemPoolQuestionInnr(string poolQueName,Item_Pool__c itemPoolInfo, List<Item_Question__c> itmPlQuestionsListInfo){
            this.poolQueName=poolQueName;
            this.itemPoolInfo=itemPoolInfo;
            this.itmPlQuestionsListInfo=itmPlQuestionsListInfo;
        }
    }
    
    //Survey By ticket Tab Print & Export
    public List<Item_Question__c> exportPrintQueAns(String selectedeventid,string searchkey){
        List<Item_Question__c> itmQueAnsList = new List<Item_Question__c>();                  
        itmQueAnsList = [Select Id,Name,event__c,Item__c,Item_Pool__c,Question_level__c,item__r.item_type__r.name,question__r.event__c,
                        (Select Id,ticket__r.item_pool__c,Name,UAnswer_Text__c,item_question__r.item__r.item_type__r.name,item_question__r.Event__c, 
                          ticket__r.tkt_profile__r.First_Name__c,ticket__r.tkt_profile__r.Last_Name__c,ticket__r.tkt_profile__r.Email__c,
                          Ticket__r.Ticket_Status__c,Ticket__r.Item__r.Item_Name__c,Item_Question__r.Question__r.Name,
                          Item_Question__r.Question_Level__c,Item_Question__r.Item__c,Item_Question__r.Item_Pool__c,Item_Question__r.Question__c,
                          Item_Question__r.Question__r.Event__c,Item_Question__r.Question__r.Question_Text__c,Item_Question__r.Question__r.Answer_Type__c,
                          Item_Question__r.Item__r.Item_Name__c,Item_Question__r.Item_Pool__r.Item_Pool_Name__c
                          FROM 
                          User_Answers__r
                          WHERE 
                         ticket__r.ticket_status__c='Booked'
                          Order By ticket__r.tkt_profile__r.First_Name__c,ticket__r.tkt_profile__r.Last_Name__c),
                        Item__r.item_Name__c, Item_Pool__r.Item_Pool_Name__c,
                        Question__r.Answer_Type__c,Question__r.Question_Text__c,Question__r.Name
                        FROM
                        Item_Question__c
                        WHERE
                        Question__r.Event__c = : selectedeventid AND (item_pool__r.item_pool_name__c like : '%'+searchkey+'%' OR item__r.item_name__c like : '%'+searchkey+'%') Order By question__r.question_order__c asc]; 
        return itmQueAnsList ;
    }
    
    //for batch
    public List<user_answer__c> exportPrintQueAns(list<user_answer__c> lst){
        List<user_answer__c> itmQueAnsList = lst;
        return lst;  
    }
    
    //Method to get responses for print and export
    //Method to get count of item answrs
    public LIST<AggregateResult> userAnswersForItemQuestionForExportPrint(String selectedeventid,set<id> questionID){//string questionID
        LIST<AggregateResult> answersAggregateResult= new LIST<AggregateResult>();
        answersAggregateResult= [SELECT COUNT(Id) selCount,UAnswer_Text_Update__c ansType, Item_Question__r.Question__r.Id QueID
                                 FROM User_Answer__c 
                                 WHERE Item_Question__r.Question__c in : questionID 
                                 AND ticket__r.ticket_status__c='Booked'
                                 GROUP BY UAnswer_Text_Update__c,Item_Question__r.Question__r.id];
        return answersAggregateResult;
    }
    
    //Printing checkbox answers by comma seperated
    public LIST<surveyAttendeeInner1> gnUsersForSurveyForPrint1(String eventId){
        userAnswerDAOClass= new BLN_UserAnswers_DAO();
        LIST<User_Answer__c> userAnswersList= new LIST<User_Answer__c>();
        userAnswersList= userAnswerDAOClass.userAnswersListForPrint(eventId);         
        MAP<Id, LIST<User_Answer__c>> ticketsMAP= new MAP<Id, LIST<User_Answer__c>>(); 
            
        for(User_Answer__c tic : userAnswersList){           
            LIST<User_Answer__c> ticketsListToAdd= new LIST<User_Answer__c>();
            if(ticketsMAP.containsKey(tic.ticket__c)){
                ticketsListToAdd= ticketsMAP.get(tic.ticket__c);
                ticketsListToAdd.add(tic);
                ticketsMAP.put(tic.ticket__c, ticketsListToAdd);
            }else if(! ticketsMAP.containsKey(tic.ticket__c)){
                ticketsListToAdd.add(tic);
                ticketsMAP.put(tic.ticket__c, ticketsListToAdd);
            }
            
        }
        surveyAttendeeInnerListForPrint1= new LIST<surveyAttendeeInner1>();    
        
        string username1='';
        for(User_Answer__c tic1 : userAnswersList){
            LIST<User_Answer__c> ticketsListToAdd= new LIST<User_Answer__c>();            
            ticketsListToAdd= ticketsMAP.get(tic1.ticket__c);
            
            if(ticketsListToAdd.size() > 0 && username1.contains(tic1.ticket__c)==false){
                username1+=tic1.Ticket__r.id+',';
                surveyAttendeeInnerListForPrint1.add(new surveyAttendeeInner1(ticketsListToAdd));
            }
        }
        
        return surveyAttendeeInnerListForPrint1;
    }
    
    
    public LIST<surveyAttendeeInner1> surveyAttendeeInnerListForPrint1{get; set;}
    
    //Survey By Question Tab functionality
    public List<item_question__c> itemQuestionsBooked(string selectedEvent ){
        itemQuestionDAOClass=new BLN_Item_Question_DAO();
        list<item_question__c> itmquestionlist=new list<item_question__c>();
        itmquestionlist= itemQuestionDAOClass.itemQuestionswithuseranswers(selectedEvent);  
        return itmquestionlist;
    }
    
    public LIST<surveyAttendeeInner> sendingSurveyInfoByQuestion(String eventID, String questionID){
        ticketDAOClass= new BLN_Ticket_DAO();       
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        ticketsList= ticketDAOClass.SupplySurveyInfoForEachQuestion(eventID,questionID);
        SET<ID> itcUAID=new SET<ID>();
        for(Ticket__c tic: ticketsList){
            itcUAID.add(tic.id);           
        }
        set<id> myans=new set<id>();
        for(User_Answer__c ua : [select id,name,ticket__r.id,uanswer_text__c from user_answer__c where ticket__c in : itcUAID]){ 
                myans.add(ua.ticket__r.Id);
            } 
        
        LIST<Ticket__c> ticketsListUA= new LIST<Ticket__c>();
        for(Ticket__c tic: ticketsList){
            if(myans.contains(tic.id))
            ticketsListUA.add(tic);
        }
        
        surveyAttendeeInnerList= new LIST<surveyAttendeeInner>();        
        if(ticketsListUA.size() > 0){
            surveyAttendeeInnerList.add(new surveyAttendeeInner(ticketsListUA));
        }
        return surveyAttendeeInnerList;
    } 
    
    public LIST<surveyAttendeeInner> sendingSurveyInfoByQuestion(String eventID, String questionID,string searchkey){
        ticketDAOClass= new BLN_Ticket_DAO();       
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        ticketsList= ticketDAOClass.SupplySurveyInfoForEachQuestion(eventID,questionID,searchkey);
        SET<ID> itcUAID=new SET<ID>();
        for(Ticket__c tic: ticketsList){
            itcUAID.add(tic.id);           
        }
        set<id> myans=new set<id>();
        for(User_Answer__c ua : [select id,name,ticket__r.id,uanswer_text__c from user_answer__c where ticket__c in : itcUAID]){ 
                myans.add(ua.ticket__r.Id);
            } 
        
        LIST<Ticket__c> ticketsListUA= new LIST<Ticket__c>();
        for(Ticket__c tic: ticketsList){
            if(myans.contains(tic.id))
            ticketsListUA.add(tic);
        }
        
        surveyAttendeeInnerList= new LIST<surveyAttendeeInner>();        
        if(ticketsListUA.size() > 0){
            surveyAttendeeInnerList.add(new surveyAttendeeInner(ticketsListUA));
        }
        return surveyAttendeeInnerList;
    } 
    
     public LIST<surveyAttendeeInner> sendingSurveyInfoByQuestion(LIST<Ticket__c> ticketsList1){
       
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        ticketsList= ticketsList1;
        System.debug('TLTLTLTL1111:::'+ticketsList.size());
        SET<ID> itcUAID=new SET<ID>();       
               
        for(ticket__c t : ticketsList){           
            itcUAID.add(t.id); 
        }
        List<user_answer__c> ulist=[select id,name,ticket__r.id from user_answer__C where ticket__r.id in : itcUAID];        
       set<id> bookedid=new set<id>();
       for(user_answer__c u : ulist){ 
          bookedid.add(u.ticket__r.id);   
        }
        
        LIST<Ticket__c> ticketsListUA= new LIST<Ticket__c>(); 
        for(ticket__c t1 : ticketsList){
            if(bookedid.contains(t1.id))
            ticketsListUA.add(t1);
        }
        
         
        
        System.debug('TLTLTLTL:::'+ticketsListUA.size());
        surveyAttendeeInnerList= new LIST<surveyAttendeeInner>();        
        if(ticketsListUA.size() > 0){
        system.debug('aaa');
            surveyAttendeeInnerList.add(new surveyAttendeeInner(ticketsListUA));
        }
        system.debug('surveyAttendeeInnerList'+surveyAttendeeInnerList);
        return surveyAttendeeInnerList;
    }
    
    //xport and print functionality
    public LIST<surveyAttendeeInner> sendingSurveyInfoByQuestionXprint(String eventID, set<id> questionID){
        ticketDAOClass= new BLN_Ticket_DAO();
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
                
        ticketsList= ticketDAOClass.SupplySurveyInfoForEachQuestionForXprint(eventID,questionID);
        SET<ID> itmQueId=new SET<ID>();
        for(Ticket__c tic: ticketsList){
            //for(User_Answer__c ua : tic.user_answers__r){
                itmQueId.add(tic.id);//(ua.Item_Question__r.Id);
            //}            
        }        
        surveyAttendeeInnerList= new LIST<surveyAttendeeInner>();       
            
        if(ticketsList.size() > 0){
            surveyAttendeeInnerList.add(new surveyAttendeeInner(ticketsList));
        }
        
        return surveyAttendeeInnerList;
    }
    
    // Code For Survey By Attendee Tab    
    public LIST<surveyAttendeeInner> gnUsersForSurvey(String eventId, LIST<Ticket__c> ticketsList3){
        
        LIST<Ticket__c> ticketsList= new LIST<Ticket__c>();
        ticketsList= ticketsList3;        
        LIST<Ticket__c> ticketsListWithUA= new LIST<Ticket__c>();
        Set<Id> UAticId=new Set<Id>();
        for(Ticket__c tic: ticketsList){            
            for(User_Answer__c ua : tic.user_answers__r){
                if(ua.Uanswer_text__c!=Null && ua.item_question__r.question_level__c != 'Lead Retrieval')
                UAticId.add(ua.ticket__r.id);    
            }            
        }
        
        for(Ticket__c tic: ticketsList){            
           if(UAticId.contains(tic.Id))
           ticketsListWithUA.add(tic);           
        }
        
        surveyAttendeeInnerList= new LIST<surveyAttendeeInner>();
        if(ticketsListWithUA.size() > 0){
            surveyAttendeeInnerList.add(new surveyAttendeeInner(ticketsListWithUA));
        }
        return surveyAttendeeInnerList;
    }
    
    public LIST<user_answer__c> gnUsersForSurveyTemp(String eventId, LIST<user_answer__c> ticketsList3){
        
        LIST<user_answer__c> ticketsList= new LIST<user_answer__c>();
        ticketsList= ticketsList3;  
        return ticketsList;
    }
    
    //Survey By ticket Tab method to get item and line items questions
    public LIST<itemQuestionsInner> allTypeQuestions(string eventId){        
        LIST<itemQuestionsInner> itemQuestionsInnerList= new LIST<itemQuestionsInner>();
        integer bookies=0;
        ticketDAOClass=new BLN_Ticket_Dao();
        bookedItems='';  
        for(Ticket__c tt : [select id,name, item__r.id,(select id,name from user_answers__r limit 1) FROM Ticket__c WHERE Event__c =: EventId AND Ticket_Status__c =: 'Booked' order by order__r.createddate desc]){
            bookedItems+=tt.Item__r.Id+','; 
            for(user_answer__c u :tt.user_answers__r){
                bookies++;
            }  
        } 
        
        itemDAOClass= new BLN_Item_DAO();
        LIST<BLN_Item__c> itemQuestionsList= new LIST<BLN_Item__c>();
        itemQuestionsList= itemDAOClass.getEventItems(eventId);
                 
        set<id> iqids=new set<id>();      
        for(BLN_Item__c it:itemQuestionsList){
            for( Item_Question__c q:it.Item_Question__r){
                iqids.add(q.id);
            }
        }
        
        LIST<Item_Question__c> iqList11= new LIST<Item_Question__c>();
        iqList11=[select id,(select id from user_answers__r limit 2) from Item_Question__c where id in : iqids];
        
        iqids=new set<id>();
        for(Item_Question__c iq1 :iqList11){
            if(iq1.user_Answers__r.size() > 0){
            iqids.add(iq1.id);
            }
        }
        
        itemDAOClass= new BLN_Item_DAO();
        itemQuestionsList= new LIST<BLN_Item__c>();
        itemQuestionsList= itemDAOClass.getEventItems(eventId,iqids);
        
        LIST<Item_Question__c> questionsList= new LIST<Item_Question__c>(); 
        String iqString='';
        String ansEvent=''; 
        for(Item_Question__c iq : [select id,name,question__r.id,question__c,question_level__c,Question__r.Name,Question__r.Question_Text__c,Question__r.answer_type__c,(select id from user_Answers__r limit 2) FROM Item_Question__c WHERE Event__c =: eventId AND Question_Level__c =: 'Event Level' Order By Question_Level__c,question__r.question_order__c ASC]){
            if(iqString.contains(iq.question__r.id)==false && iq.question_level__c=='Event Level'){
                if(iq.user_Answers__r.size() > 0 ){
                iqString+=iq.question__r.id+',';
                questionsList.add(iq);
                ansEvent+=iq.Question__r.Name; 
            }
        } 
        } 
        
        if(ansEvent!='' && bookies>0)
        itemQuestionsInnerList.add(new itemQuestionsInner(ansEvent,'Event Level', new BLN_Item__c(), new List<Item_Pool__c>(),  questionsList,new List<itemPoolQuestionInnr>(), new List<User_Answer__c>())); 
        
        // --------------------------------------- ticket level here ------------------------------------
        
      
        //MAP to get item pools for item(package) ======start
        MAP<ID, List<Item_Pool__c>> poolMap=new MAP<ID, List<Item_Pool__c>>();        
        SET<ID> parentID=new SET<ID>();
        
        for(BLN_Item__c item : itemQuestionsList){
            if(item.Item_Type__r.Name=='Package'){
                parentID.add(item.Item_Pool__r.Id);
            }            
        } 
        
        SET<ID> itmplIdset=new SET<ID>();
        for(Item_Pool__c ip : [select id, Name, Addon_Parent__c,(SELECT ID, NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                             Addon_Parent__c,Addon_Count__c                                                             
                                                      FROM Item_Pools__r),
                                                      (Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c,Question_Level__c FROM Item_Question__r Order By Question_Level__c)
                                                       From Item_Pool__c Where ID IN : parentID]){
             
            itmplIdset.add(ip.id); 
        }
        
        MAP<ID, List<Item_Question__c>> poolMapQUEMap=new MAP<ID, List<Item_Question__c>>();
        List<Item_Pool__c> itemPoolFinal=[SELECT ID, NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                             Addon_Parent__c,Addon_Count__c,(SELECT ID, NAME, uniqueNumber__c,Item_Type__c, Event__c, Item_Pool_Name__c,Item_Count__c ,Item_Type__r.BL_Fee_Amt_per_res__c,Item_Type__r.BL_Fee_Pct_per_res__c,
                                                             Addon_Parent__c,Addon_Count__c                                                             
                                                      FROM Item_Pools__r),
                                                             (Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c,Question_Level__c FROM Item_Question__r Order By Question_Level__c)
                                                      FROM Item_Pool__c where ID IN : itmplIdset]; 
         
        for(Item_Pool__c ipTemp : itemPoolFinal){
            
            poolMap.put(ipTemp.id, ipTemp.Item_Pools__r);
            
            poolMapQUEMap.put(ipTemp.id, ipTemp.Item_Question__r); 
        }        
        

        //MAP to get item pools for item(package) ======End
        
        
        //logic to get inner item pool questions list====start
        Set<ID> QID=new Set<ID>();
        for(BLN_Item__c item : itemQuestionsList){
            List<Item_Pool__c> poolListRequired1=new List<Item_Pool__c>();
            if(poolMap.get(item.Item_Pool__r.id) != null){
                poolListRequired1=poolMap.get(item.Item_Pool__r.id);                
            }
            for(Item_Pool__c itpl : poolListRequired1){ 
                QID.add(itpl.id);
            }
        }
        List<Item_Question__c> itmPoolQList2=new List<Item_Question__c>();
        itmPoolQList2=[Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c,Question_Level__c FROM Item_Question__c where Item_Pool__r.id IN :QID Order By Question_Level__c]; 
        //logic to get inner item pool questions list=====end
        
        
        //Getting itemQuestion list for itempools===start
        SET<ID> checkID1=new SET<ID>();
        SET<ID> checkID2=new SET<ID>();
        for(BLN_Item__c item : itemQuestionsList){
            checkID1.add(item.Item_Pool__r.Id);
            
            
            List<Item_Pool__c> poollistCheck=new List<Item_Pool__c>();
            if(poolMap.get(item.Item_Pool__r.id) != null){
                poollistCheck=poolMap.get(item.Item_Pool__r.id); 
            }
            if(poollistCheck.size()>0){
                for(Item_Pool__c itpl : poollistCheck){
                        checkID2.add(itpl.Id); 
                }     
            }
        } 
        List<Item_Question__c> itmPoolQListTemp1=new List<Item_Question__c>(); 
        itmPoolQListTemp1=[Select Id,Item_Pool__r.id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c,Question_Level__c,(select id,Name,Item_Question__r.Question__r.Name,Item_Question__c,uanswer_text__c,Item_Question__r.Item_Pool__r.id From User_Answers__r where ticket__r.ticket_status__c='Booked') FROM Item_Question__c where Item_Pool__r.id IN :checkID2 Order By Question_Level__c];
        
        MAP<Id,List<Item_Question__c>> poolistcheckMap=new MAP<Id,List<Item_Question__c>>();
        for(BLN_Item__c item : itemQuestionsList){
            List<Item_Pool__c> poollistCheck=new List<Item_Pool__c>();
            if(poolMap.get(item.Item_Pool__r.id) != null){
                poollistCheck=poolMap.get(item.Item_Pool__r.id);
            }
            if(poolMap.get(item.Item_Pool__r.id) != null){
                for(Item_Pool__c itpl : poollistCheck){                    
                    poolistcheckMap.put(itpl.Id,itmPoolQListTemp1); 
                }     
            }
        }
        
        //for non answered items
        set<id> answrid=new set<id>();
        string itmstring='';
        set<id> itmstringpool=new set<id>(); 
        for(BLN_Item__c item : itemQuestionsList){
            for(item_question__c iq : item.item_question__r){ 
                answrid.add(iq.id);
                itmstring+=iq.item__r.id+',';
                itmstringpool.add(iq.item_pool__r.id);
            }
        }
        
         
        
        //Putting query out side of loop
        Set<id> listOfItmpoolIds=new set<id>();
        for(BLN_Item__c item1 : itemQuestionsList){
            //Getting user answer fro item level======End            
            List<Item_Pool__c> poolListRequired=new List<Item_Pool__c>();
            if(poolMap.get(item1.Item_Pool__r.id) != null){
                poolListRequired=poolMap.get(item1.Item_Pool__r.id);
            }
            
            if(poolMap.get(item1.Item_Pool__r.id) != null){
                for(Item_Pool__c itpl1 : poolListRequired){ 
                    listOfItmpoolIds.add(itpl1.id);
                }
            }
        }
        
         /*Map<id,List<Item_Question__c>> listofitmpoolsFrmItmMap=new map<id,list<Item_Question__c>>();
        list<Item_Question__c> listItmplListundrItm=[Select Id,item__r.id,item__c,Item_Pool__r.id,question__r.question_order__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c,Question_Level__c,(select id,Name,Item_Question__r.Question__r.Name,Item_Question__c,uanswer_text__c From User_Answers__r where ticket__r.ticket_status__c='Booked') FROM  Item_Question__c  where question__r.event__c= : eventId  Order By question__r.question_order__c asc];
        for(Item_Question__c iq : listItmplListundrItm){
            list<item_question__c> iqlist=new list<item_question__c>();
            if(listOfItmpoolIds.contains(iq.item_pool__r.id)){
                if(listofitmpoolsFrmItmMap.containsKey(iq.item_pool__r.id)){
                   iqlist=listofitmpoolsFrmItmMap.get(iq.item_pool__r.id);
                   iqlist.add(iq);
                   listofitmpoolsFrmItmMap.put(iq.item_pool__r.id,iqlist);
                }else{
                    iqlist.add(iq);
                    listofitmpoolsFrmItmMap.put(iq.item_pool__r.id,iqlist);
                }
            }
            
        } */
        
        //Getting itemQuestion list for itempools===End 
        
        //Getting booked questions(item questions/questions) for both item and item poool--------start
         /*set<id> BookedItemsIdSet=new set<id>();
            set<id> BookedItemPoolsIdSet=new set<id>();
            for(user_answer__c u : [select id,ticket__r.item__c,ticket__r.item_pool__c,item_question__r.question__r.id from user_answer__c where ticket__r.event__c= : eventId and ticket__r.ticket_status__c='Booked'  ]){
                BookedItemsIdSet.add(u.item_question__r.question__r.id );//(u.ticket__r.Item__c);
                BookedItemPoolsIdSet.add(u.ticket__r.Item_Pool__c);
            }*/ 
        //Getting booked questions(item questions/questions) for both item and item poool--------start
        
        
        //Main for loop
        for(BLN_Item__c item : itemQuestionsList){
            String ans='';          
            
            //Getting user answer fro item level======start
            for(Item_Question__c iq : item.Item_Question__r){               
                    //if(BookedItemsIdSet.contains(iq.question__r.id))
                    ans+=iq.Question__r.Name+',';
            }
            //Getting user answer fro item level======End            
            
            List<Item_Pool__c> poolListRequired=new List<Item_Pool__c>();
            if(poolMap.get(item.Item_Pool__r.id) != null){
                poolListRequired=poolMap.get(item.Item_Pool__r.id);
            }
            
            itemPoolQuestionInnrList=new List<itemPoolQuestionInnr>();
            Map<Id,List<Item_Question__c>> queMap=new Map<Id,List<Item_Question__c>>();
            if(poolMap.get(item.Item_Pool__r.id) != null){
                for(Item_Pool__c itpl : poolListRequired){ 
                    
                    List<Item_Question__c> itmPoolQList1=new List<Item_Question__c>();
                    List<Item_Question__c> itmPoolQList22=new List<Item_Question__c>();
                    List<Item_Question__c> itmPoolQList3=new List<Item_Question__c>();
                    itmPoolQList3= [Select Id,item__r.id,item_pool__r.id,item__c,question__r.question_order__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c,Question_Level__c,(select id,Name,Item_Question__r.Question__r.Name,Item_Question__c,uanswer_text__c From User_Answers__r where ticket__r.ticket_status__c='Booked') FROM Item_Question__c where Item_Pool__r.id= :itpl.id Order By question__r.question_order__c asc];
                    //itmPoolQList3=listofitmpoolsFrmItmMap.get(itpl.id);                   
                    // Query from loutMapoop
                    itmPoolQList1=poolistcheckMap.get(itpl.Id);//[Select Id,item__c,Question__c,Question__r.Event__c,IQ_Order__c,Question__r.Id, Question__r.Name, Question__r.Question_Text__c, Question__r.Answer_Type__c,Question_Level__c,(select id,Name,Item_Question__r.Question__r.Name,Item_Question__c,uanswer_text__c From User_Answers__r) FROM Item_Question__c where Item_Pool__r.id= :itpl.id Order By Question_Level__c];
                     
                    String poolAns='';
                    SET<ID> allPoolId=new SET<ID>();
                    string uniqQuestion='';
                    for(Item_Question__c iqq : itmPoolQList3){
                        for(User_Answer__c uaa : iqq.User_Answers__r){
                            if(uaa.Item_Question__r.Question__r.Name==iqq.Question__r.Name && uaa.uanswer_text__c!=Null){// && uaa.Item_Question__r.Item_Pool__r.id==itpl.Id
                                poolAns+=iqq.Question__r.id+',';
                            }    
                        }
                    }                    
                    if(poolAns!='')
                    itemPoolQuestionInnrList.add(new itemPoolQuestionInnr(poolAns,itpl,itmPoolQList3));
                }
            }              
            
            String iqString1='';
            list<Item_Question__c> iqlist=new list<Item_Question__c>();
            for(Item_Question__c iq : item.Item_Question__r){
                if(iqString1.contains(iq.question__r.id)==false && iq.question_level__c=='Ticket Level'){
                    iqString1+=iq.question__r.id+',';
                    iqlist.add(iq);
                }
            }
            
            if(bookies>0 && iqlist.size() >0){
                if((item.Item_Question__r.size() >0 || poolListRequired.size()>0) && bookedItems.contains(item.id) && itmstring.contains(item.id) && item.item_type__r.name!='Package'){
                    itemQuestionsInnerList.add(new itemQuestionsInner(ans,'Ticket Level', item, poolListRequired, iqlist,itemPoolQuestionInnrList,null));    
                }else if((item.Item_Question__r.size() >0 || poolListRequired.size()>0) && bookedItems.contains(item.id) && item.item_type__r.name=='Package'){
                    itemQuestionsInnerList.add(new itemQuestionsInner(ans,'Ticket Level', item, poolListRequired, iqlist,itemPoolQuestionInnrList,null));
                }
            }
        }      
        
        return itemQuestionsInnerList;
    } 
   
   
}