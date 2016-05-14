@isTest
public class Test_BLN_SurveyQuestionsReportCon_BAL{
    static testmethod void Testmethod_BLN_SurveyQuestionsReportCon_BAL(){
    
     User U= new User();
    globalForTestClass globalTest= new globalForTestClass();
    U= globalTest.createUser();
    
    system.runas(U){
        User userForGN= new User();
        userForGN= globalTest.createUserForGNUser();
        
        Company__c companyInfo= new Company__c();
        companyInfo= globalTest.createCompany(u.Companyname);
        
        Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
        
        Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
        
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
        
        GN_User__c  gnUser= new GN_User__c();
        gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
        
        BLN_Event__c eventInfo= new  BLN_Event__c();
        eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
        
        Order__c insertOrder1= new Order__c();
        Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof =globalTest.createTktprofile(userForGN);

        insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
        
        Item_Type__c itemType= new Item_Type__c();
        itemType= globalTest.createItemType();
        
        BLN_Track__c trck=new BLN_Track__c();
        trck=globalTest.createTrack(eventInfo.Id);
        
        Item_Pool__c ItemPool= new Item_Pool__c();
        ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
        
        Item_Pool__c ItemPool2= new Item_Pool__c();
        ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
        
        list<Item_Pool__c> listitempool = new list<Item_Pool__c>();
        listitempool.add(ItemPool);
        listitempool.add(ItemPool2);
        
        BLN_Item__c item= new BLN_Item__c();
        item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
                   
        Order_Item__c orderItem= new Order_Item__c();
        orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
        
        
        Question__c que = new Question__c();
        que=globalTest.createQuestion(eventInfo.id);
        que.Answer_Type__c='Checkboxes' ;
        update que;
        
        Item_Question__c itemQue = new Item_Question__c();
        itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
        
        list<Item_Question__c> listitemques = new list<Item_Question__c>();
        listitemques.add(itemQue);
        
        BLN_Answer__c ans = new BLN_Answer__c();
        ans=globalTest.createAnswer(que.Id);
        
        Ticket__c ticket= new Ticket__c();
        ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
        
        list<Ticket__c> lticket = new list<Ticket__c>();
        lticket.add(ticket);
        
        User_Answer__c  usrAns = new User_Answer__c();
        usrAns=globalTest.createUserAnswer(ticket.id,itemQue.Id, ans.Id);
        
        list<User_Answer__c> luserans = new list<User_Answer__c>();
        luserans.add(usrAns);
        
        cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter});  
        
        BLN_SurveyQuestionsReportCon_BAL blnsqrcb = new BLN_SurveyQuestionsReportCon_BAL();
        
        blnsqrcb.surveyQuestionsForEvent(eventInfo.id);
        blnsqrcb.bookedTicketsForEventForPrintXport(eventInfo.id);
        blnsqrcb.bookedTicketsForEvent(eventInfo.id);
        blnsqrcb.bookedTickets(item.id);
        blnsqrcb.bookedTicketsForItemPool(ItemPool.id);
        blnsqrcb.allUserAnswers(itemQue.id);
        blnsqrcb.allUserAnswersForPrintXport(eventInfo.id);
        blnsqrcb.userAnswersQuestionWise(que.id);
        blnsqrcb.userAnswersQuestionWiseXprint(new set<id>());
        blnsqrcb.userAnswersForItemQuestion(itemQue.id);
        blnsqrcb.userAnswersForItemPoolQuestion('');
        blnsqrcb.userAnswersListForItemQuestion(itemQue.id);
        blnsqrcb.userChkboxQueAns(eventInfo.id,itemQue.id);
        
        BLN_SurveyQuestionsReportCon_BAL.surveyQuestionChbxAnsInnr sqci = new BLN_SurveyQuestionsReportCon_BAL.surveyQuestionChbxAnsInnr('testans',luserans);
        
        blnsqrcb.gnUsersForSurvey1(itemQue.id);
        //blnsqrcb.gnUsersForSurvey1(itemQue.id,luserans);
        
        BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1 sai1 = new BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1(luserans);
        
        blnsqrcb.userAnswersListForItemPoolQuestion(itemQue.id);
        blnsqrcb.surveyQuestionsForItem(eventInfo.id);
        blnsqrcb.dataForItemSurvey(item.id);
        
        BLN_SurveyQuestionsReportCon_BAL.itemLevelSurvey ils = new BLN_SurveyQuestionsReportCon_BAL.itemLevelSurvey(item,lticket);
        
        blnsqrcb.gnUsersForSurvey(eventInfo.id);
        blnsqrcb.gnUsersForSurvey(eventInfo.id,lticket);
        
        BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner sai = new BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner(lticket);
        
        BLN_SurveyQuestionsReportCon_BAL.itemPoolQuestionInnr ipqi = new BLN_SurveyQuestionsReportCon_BAL.itemPoolQuestionInnr('poolqname',ItemPool,listitemques);
        list<BLN_SurveyQuestionsReportCon_BAL.itemPoolQuestionInnr> lipqi = new list<BLN_SurveyQuestionsReportCon_BAL.itemPoolQuestionInnr>();
        lipqi.add(ipqi);
        
        BLN_SurveyQuestionsReportCon_BAL.itemQuestionsInner iqi = new BLN_SurveyQuestionsReportCon_BAL.itemQuestionsInner('qname','ltype',item,listitempool,listitemques,lipqi,luserans );
        
        blnsqrcb.allTypeQuestions(eventInfo.id);
        blnsqrcb.itemQuestionsForItem(item.id);
        blnsqrcb.itemQuestionsForItemPool(ItemPool.id);
        blnsqrcb.eventLevelQuestions(eventInfo.id);
        blnsqrcb.exportPrintQueAns(eventInfo.id,'test');
        blnsqrcb.userAnswersForItemQuestionForExportPrint(eventInfo.id,new set<id>());
        blnsqrcb.gnUsersForSurveyForPrint1(eventInfo.id);
        blnsqrcb.itemQuestionsBooked(eventInfo.id);
        try{
        blnsqrcb.sendingSurveyInfoByQuestion(eventInfo.id,que.id);
        blnsqrcb.sendingSurveyInfoByQuestion(eventInfo.id,que.id,'search');
         blnsqrcb.sendingSurveyInfoByQuestion(lticket);
        
        }catch(exception e){}
        blnsqrcb.sendingSurveyInfoByQuestionXprint(eventInfo.id,new set<id>());
        blnsqrcb.gnUsersForSurvey_agg(itemQue.id);
        blnsqrcb.gnUsersForSurvey2(itemQue.id,luserans);
        try{
        blnsqrcb.gnUsersForSurvey1(itemQue.id,luserans);
        }catch(exception e){}
        

        }
    
    }
}