@isTest
public class Test_BLN_SurveyByQuestionTabReportCon{
    static testmethod void Testmethod_BLN_SurveyByQuestionTabReportCon(){
    
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
        
        BLN_SurveyByQuestionTabReportCon blnbsqtrc = new BLN_SurveyByQuestionTabReportCon();
        
        blnbsqtrc.selectedQuestion = que.id;
        MAP<Id, Item_Question__c> mapiq = new MAP<Id, Item_Question__c>();
        mapiq.put(itemQue.id,itemQue);
        blnbsqtrc.questionsForItemMAP = mapiq;
        
        blnbsqtrc.hideEventsTab();
        blnbsqtrc.showAllAnsweredQuestions();
        ApexPages.currentPage().getParameters().put('questionID',que.id);
        blnbsqtrc.showSurveyInfoForQuestion();
        
        BLN_SurveyByQuestionTabReportCon.responsesInner respinn = new BLN_SurveyByQuestionTabReportCon.responsesInner('Text',4,5.5);
        blnbsqtrc.backtoSurveyByQue();
        //blnbsqtrc.displaySurveyRepAttendeeData();
        blnbsqtrc.summaryResponseData();
        blnbsqtrc.detailResponseData();
        blnbsqtrc.exportResponses();
        
        BLN_SurveyByQuestionTabReportCon.responsesInnerQUEANS respinnque = new BLN_SurveyByQuestionTabReportCon.responsesInnerQUEANS('Text','testw',4,50);
        
        blnbsqtrc.surveyByQuestionTabExport();
        ApexPages.currentPage().getParameters().put('searchKey','searchkey');
        blnbsqtrc.surveyByQuestionTabExportBatch();
        blnbsqtrc.surveyByQuestionTabExportBatchForCurrentView();
        ApexPages.currentPage().getParameters().put('start','4');
        ApexPages.currentPage().getParameters().put('length','5');
        ApexPages.currentPage().getParameters().put('searchKeySBQ','searchkey');
        blnbsqtrc.processData_surveyByQuestionreport_tab2();
        
        BLN_SurveyByQuestionTabReportCon.SubWrapper subwap = new BLN_SurveyByQuestionTabReportCon.SubWrapper(usrAns);
        list<BLN_SurveyByQuestionTabReportCon.SubWrapper> listsubwrap = new list<BLN_SurveyByQuestionTabReportCon.SubWrapper>();
        listsubwrap.add(subwap);
        BLN_SurveyByQuestionTabReportCon.DataTableWrapper1 subwap1 = new BLN_SurveyByQuestionTabReportCon.DataTableWrapper1(4,10,5,listsubwrap);
        
        blnbsqtrc.showQuestionDetails= true;
        blnbsqtrc.showQuestionLevelSurvey = true;
        blnbsqtrc.showItemLevelSurvey = true;
        blnbsqtrc.isSurveyQuestionExportPrint = true;
        blnbsqtrc.isSurveyByAttendeeExport= true;
        blnbsqtrc.totalOrdersXport=5;
        blnbsqtrc.evCount = 4;
        blnbsqtrc.ticCount = 10;
        blnbsqtrc.evCountXport = 5;
        blnbsqtrc.ticCountXport = 3;
        blnbsqtrc.selectedItemName = item.id;
        blnbsqtrc.ticketlist = lticket;
        blnbsqtrc.dataTableJson = 'testjson';
        blnbsqtrc.islevel = 'islevel';
        blnbsqtrc.isTicketLevel = 'isTicketLevel';
        blnbsqtrc.itemAnswerType = 'text';
        blnbsqtrc.qname = 'testq';
        blnbsqtrc.itemId = item.id;
        blnbsqtrc.totalOrdersPrint = 20;
        blnbsqtrc.totalOrdersPrintTic = 10;
        blnbsqtrc.totalTicXport = 5;
        blnbsqtrc.totalEveXport = 4;
        blnbsqtrc.totatTicketLevelOrders = 22;
        blnbsqtrc.bookedTicketsForItemPool= 25;
        blnbsqtrc.xportQA = 'testxport';
        blnbsqtrc.searchByQueId = 'qid';
        blnbsqtrc.RecList1 = lticket;
        blnbsqtrc.ticUAlist = lticket;
        blnbsqtrc.ticketsList = lticket;
        blnbsqtrc.ulist = luserans ;
        blnbsqtrc.myQuestionId = que.id;
        blnbsqtrc.noOfUAns = 10;
        
        
        
        

        }
    
    }
}