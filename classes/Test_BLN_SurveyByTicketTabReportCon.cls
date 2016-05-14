@isTest
public class Test_BLN_SurveyByTicketTabReportCon{
    static testmethod void Testmethod_BLN_SurveyByTicketTabReportCon(){
    
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
        
        BLN_SurveyByTicketTabReportCon blnbsttrc = new BLN_SurveyByTicketTabReportCon();
        blnbsttrc.selectedEvent = eventInfo.id;
        blnbsttrc.selectedQuestion = itemque.id;
        //BLN_SurveyByQuestionTabReportCon sqtr = new BLN_SurveyByQuestionTabReportCon();
        //blnbsttrc.BLN_SurveyByTicketTabReportCon(sqtr);
        
        BLN_Ticket_DAO blntdao = new BLN_Ticket_DAO();
        blntdao.eventBookedTickets(eventInfo.id);
        
        ApexPages.currentPage().getParameters().put('start','5');
        ApexPages.currentPage().getParameters().put('length','10');
        blnbsttrc.processData2_detailresptktpool();
        
        BLN_SurveyQuestionsReportCon_BAL sqr = new BLN_SurveyQuestionsReportCon_BAL();
        BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1 sai1 = new BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1(luserans);
        list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1> lsai1 = new list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner1>();
        lsai1.add(sai1);
        
        BLN_SurveyByTicketTabReportCon.SubWrapperpool swp = new BLN_SurveyByTicketTabReportCon.SubWrapperpool(usrAns); 
        list<BLN_SurveyByTicketTabReportCon.SubWrapperpool> lswp = new list<BLN_SurveyByTicketTabReportCon.SubWrapperpool>();
        lswp.add(swp);
        
        BLN_SurveyByTicketTabReportCon.DataTableWrapper_detailresptktpool dtdsp = new BLN_SurveyByTicketTabReportCon.DataTableWrapper_detailresptktpool(10,20,30,lswp);
        
        ApexPages.currentPage().getParameters().put('itemId',item.id);
        ApexPages.currentPage().getParameters().put('myItmQueId',itemque.id);
        ApexPages.currentPage().getParameters().put('searchKeySBT','searchKey');
        blnbsttrc.processData2_detailresptkt();
        //BLN_SurveyByTicketTabReportCon.DataTableWrapper_detailresptkt dtds = new BLN_SurveyByTicketTabReportCon.DataTableWrapper_detailresptkt(10,20,30,lsai1);
        blnbsttrc.surveyDataForQuestion();
        blnbsttrc.summaryResponseData();
        blnbsttrc.detailResponseData();
        blnbsttrc.surveyDataForItem();
        //blnbsttrc.showitemsQA();
        blnbsttrc.surveyQuestionsList();
        blnbsttrc.backsurveybytic();
        blnbsttrc.surveyQuestionsListWithItemPool();
        blnbsttrc.surveyQuestionsWithAttendee();
        blnbsttrc.hideEventsTab();
        BLN_SurveyByTicketTabReportCon.responsesInner blnri = new BLN_SurveyByTicketTabReportCon.responsesInner('qtype','type',10,50);
        BLN_SurveyByTicketTabReportCon.responsesItemPoolInner blnripi = new BLN_SurveyByTicketTabReportCon.responsesItemPoolInner('qtype',10,50);
        blnbsttrc.exportSurveyQuestions();
        blnbsttrc.surveyByTicketBatchTemplate();
        blnbsttrc.surveyDataForItemPoolQuestion();
        blnbsttrc.summaryResponseDataForItemPool();
        blnbsttrc.detailResponseDataForItemPool();
        blnbsttrc.exportingPrintingQA();
        BLN_SurveyByTicketTabReportCon.responsesInnerQUEANS blnriq = new BLN_SurveyByTicketTabReportCon.responsesInnerQUEANS('qtype','type',10,50);
        BLN_SurveyByTicketTabReportCon.surveyCls surcls = new BLN_SurveyByTicketTabReportCon.surveyCls(itemQue,luserans);
        Test.starttest();
        blnbsttrc.nestedQueAns();
        blnbsttrc.displaySurveyRepAttendeeData();
        ApexPages.currentPage().getParameters().put('questionID',que.id);
        blnbsttrc.showSurveyInfoForQuestion();
        blnbsttrc.backtoSurveyByQue();
        blnbsttrc.exportResponsesByTicket();
        blnbsttrc.exportResponsesByTicketBatch();
        blnbsttrc.exportResponsesByPoolLines();
        blnbsttrc.exportResponsesByPoolLinesBatch();
        blnbsttrc.surveyByQuestionTabExport();
        blnbsttrc.showitemsQA();
        Test.stoptest();

        }
    
    }
}