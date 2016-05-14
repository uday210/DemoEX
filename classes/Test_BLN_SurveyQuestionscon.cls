@isTest
public class Test_BLN_SurveyQuestionscon{
    static testmethod void Testmethod_BLN_SurveyQuestionscon(){
    
    User U= new User();
    globalForTestClass globalTest= new globalForTestClass();
    U= globalTest.createUser();
    
    system.runas(U){
        User userForGN= new User();
        userForGN= globalTest.createUserForGNUser();
        
        Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof=globalTest.createTktprofile(userForGN);
        
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
        
        Promotion__c promotion1= new Promotion__c();
        promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
        promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
        promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
        
        Promotion__c promotion2= new Promotion__c();
        promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo1', 'Multi-Items Discount', 'Percent');
        promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo2', 'Multi-Items Discount', 'Amount');
        promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo3', 'Multi-Items Discount', 'Quantity');
        
        Promotion__c promotion3= new Promotion__c();
        promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo1', 'Buy Something Get Something', 'Percent');
        promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo2', 'Buy Something Get Something', 'Amount');
        promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo3', 'Buy Something Get Something', 'Quantity');
        
        Promotion__c promotion4= new Promotion__c();
        promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo1', 'Spend More Save More', 'Percent');
        promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo2', 'Spend More Save More', 'Amount');
        promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo3', 'Spend More Save More', 'Quantity');
        
        Question__c que = new Question__c();
        que=globalTest.createQuestion(eventInfo.id);
        
        Item_Question__c itemQue = new Item_Question__c();
        itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
        
        Item_Question__c itemQue1 = new Item_Question__c();
        itemQue1 =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
        
        BLN_Answer__c ans = new BLN_Answer__c();
        ans=globalTest.createAnswer(que.Id);
        
        User_Answer__c  usrAns = new User_Answer__c();
        usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
        
        Ticket__c ticket= new Ticket__c();
        ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
        
        cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter});          
        
        
        
        BLN_SurveyQuestionscon surveyQueTest=new BLN_SurveyQuestionscon();
        ApexPages.CurrentPage().getParameters().put('editquid',que.Id);
        
        surveyQueTest.questionslist.add(new Question__c(Question_Text__c='Who are you', Answer_Type__c='Text'));
        surveyQueTest.Itemquelist.add(new Item_Question__c(Question_Level__c='Event Level',isRequired__c= True, Visibility__c= True));
        Apexpages.Currentpage().getparameters().put('chkArray', item.Id+'-');
        Apexpages.Currentpage().getparameters().put('chkreqArray', item.Id+'-');
        Apexpages.Currentpage().getparameters().put('chkvisArray', item.Id+'-');
        
        surveyQueTest.savequestion();
        
        surveyQueTest.questionslist.add(new Question__c(Question_Text__c='working', Answer_Type__c='Text'));
        surveyQueTest.Itemquelist.add(new Item_Question__c(Question_Level__c='Event Level',isRequired__c= True, Visibility__c= True));
        surveyQueTest.editquestion();
        
        Apexpages.Currentpage().getparameters().put('answeroptorder',ans.id);
        surveyQueTest.updateanswerslist();
        
        itemQue.Question_Level__c='Lead Retrieval' ;
        update itemQue;
        
        BLN_Item_Question_DAO iqDAO=new BLN_Item_Question_DAO();
        
        iqDAO.questionsforLeads(eventinfo.id);
        
        Apexpages.Currentpage().getparameters().put('delquid',itemQue.id);
        Apexpages.Currentpage().getparameters().put('queanscount',string.valueOf(1));
        surveyQueTest.delquestion();
        surveyQueTest.selectedquelevl='Ticket Level';
        surveyQueTest.itemdisplay();
        
        surveyQueTest.displayPermissions();
        surveyQueTest.geteventdetails();
        surveyQueTest.getquestionslist();
        surveyQueTest.getitems();
        surveyQueTest.getquetyps();
        surveyQueTest.getquestionlevel();
        surveyQueTest.Addquestion();
        surveyQueTest.optionslabel();
        surveyQueTest.deleteoptionline();
        surveyQueTest.cancelmethod();
        surveyQueTest.getAnsList();
        BLN_SurveyQuestionscon surveyQueTest2=new BLN_SurveyQuestionscon();
        surveyQueTest2.selectedtype='Scale';
        surveyQueTest2.optionslabel();
        surveyQueTest2.editquestion();
        surveyQueTest2.showticketbasedonanswer();
        surveyQueTest2.selectedquelevl='Event Level';
        surveyQueTest2.itemdisplay();
        // Apexpages.Currentpage().getparameters().put('answeroptorder2',null);
        //surveyQueTest2.updateanswerslist2();
        
        surveyQueTest2.editbool=true;
        surveyQueTest2.failuremessageset = new SET<String>();
        surveyQueTest2.failuremessageset.clear();
        surveyQueTest2.savequestion();
         Apexpages.Currentpage().getparameters().put('recordId',que.id);
         surveyQueTest2.myControllerMethod();
          Apexpages.Currentpage().getparameters().put('chkArray', item.Id);
        // surveyQueTest2.saveRefreshAction();
        surveyQueTest2.addOptionsOnchange();
        BLN_SurveyQuestionscon surveyQueTest3=new BLN_SurveyQuestionscon();
        surveyQueTest3.selectedtype='Checkboxes';
        surveyQueTest3.optionslabel();
        surveyQueTest3.editquestion();
        
        Apexpages.Currentpage().getparameters().put('editquid',que.id);
        surveyQueTest3.selectedtype='Scale';
         surveyQueTest3.selectedquelevl='Ticket Level';
        surveyQueTest3.editquestion();
        
        Apexpages.Currentpage().getparameters().put('delquid',que.id);
        Apexpages.Currentpage().getparameters().put('queanscount',string.valueOf(0));
        surveyQueTest3.delquestion();        
        
        BLN_SurveyAnswers_DAO  saDAO=new BLN_SurveyAnswers_DAO();
        List<BLN_Answer__c> anslst=new List<BLN_Answer__c>();
        anslst.add(ans);
        saDAO.Upsertanswers(anslst);
        
        BLN_SurveyQuestions_DAO sqDAO=new BLN_SurveyQuestions_DAO();
         SET<Id> itemidlst= new SET<Id>();
        itemidlst.add(item.id);
        sqDAO.getItemQuestions(itemidlst, eventinfo.id);
        sqDAO.getItemQ(itemidlst, eventinfo.id);
        try{
        sqDAO.getItemQuestion(Item.Id,que.Id);
        }catch(exception e){}
        sqDAO.getItemQuestion(Item.Id,que.Id,Item.Id);
        try{
        sqDAO.geteventQuestion(eventinfo.id, que.Id);
        }catch(exception ee){} 
        try{
        sqDAO.getEventQuestion(que.Id);
        }catch(exception ex){}
        sqDAO.getEventQuestions(eventinfo.id);
        sqDAO.getEveQuestions(eventinfo.id);
        
        BLN_SurveyQuestions_DAO.getQueIdWithQue(eventinfo.id);
         BLN_SurveyQuestions_BAL sqBAL=new BLN_SurveyQuestions_BAL();
        
        try{
        sqBAL.getEventQuestions(eventinfo.id);
        }catch(exception e1){}
        try{
        sqBAL.geteventQuestion(eventinfo.id,Que.Id);
        }catch(exception e1){}
        sqBAL.getItemQuestions(itemidlst, eventinfo.id);
        sqBAL.insertUserAnswer(String.valueOf(ans.Id),itemQue.Id,ticket.id);
        try{
        sqBAL.getItemQuestion(Item.Id, Que.Id);
        }catch(exception e2){}
        
        
        MAP<Decimal,BLN_Answer__c> answerMAP =new MAP<Decimal,BLN_Answer__c>();
        answerMAP.put(0,ans);
        answerMAP.put(2,ans);
        
        sqBAL.deleteanswerline('2',answerMAP);
        sqBAL.deleteanswerline('3',answerMAP);
        sqBAL.deleteanswerline('0',answerMAP);
        
        MAP<string,BLN_Answer__c> answerMAP1 =new MAP<string,BLN_Answer__c>();
        answerMAP1.put('0',ans);
        answerMAP1.put('2',ans);
        sqBAL.answeroptions('Scale','0','1',FALSE,anslst,answerMAP1);
        sqBAL.answeroptions('Scale','0','1',true,anslst,answerMAP1);
        sqBAL.answeroptions('Choose from a list','0','1',FALSE,anslst,answerMAP1);
        sqBAL.answeroptions('Choose from a list','0','1',true,anslst,answerMAP1);
        sqBAL.answeroptions('Single Selection','0','1',true,anslst,answerMAP1);
        
        sqBAL.deleteansmethod('Scale',anslst,answerMAP1,anslst);
        
       
        
        test.startTest();
        
        iqDAO.questionsForTicketLevelEvent(eventinfo.id);
        List<Item_Question__c> iqlist=new List<Item_Question__c>();
        iqlist.add(itemQue);
        iqDAO.UpsertItemQuestion(iqlist);
        iqDAO.eventItemQueAns(eventinfo.id,itemQue.id);
        iqDAO.questionsForAnItem(item.id);
        iqDAO.questionsForAnItemPool(ItemPool.id);
        iqDAO.questionsForEvent(eventinfo.id);
        iqDAO.itemQuestionswithuseranswers(eventinfo.id);
        
        MAP<String,Item_Question__C>  ismap=new MAP<String,Item_Question__C>();
        ismap.put(itemQue.id,itemQue);  
        ismap.put(itemQue1.id,itemQue1);      
        
        sqBAL.itemquestions(item.id,'test1-test','test1-test',true,iqlist,ismap);
        sqBAL.deletemethod(iqlist,ismap);
        test.stopTest();
        
        }       
        
    }
}