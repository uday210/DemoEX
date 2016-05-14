@isTest
public class Test_BLN_SurveyByAttendeeTabReportCon{
    static testmethod void Testmethod_BLN_SurveyByAttendeeTabReportCon(){
    
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
        
        BLN_SurveyByAttendeeTabReportCon blnbsqtrc = new BLN_SurveyByAttendeeTabReportCon();
        
        blnbsqtrc.hideEventsTab();
        ApexPages.currentPage().getParameters().put('searchKeySBA','searchkey');
        ApexPages.currentPage().getParameters().put('start','5');
        ApexPages.currentPage().getParameters().put('length','10');
        blnbsqtrc.processData3();
        BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner sqrc = new BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner(lticket);
        //sqrc.surveyAttendeeInner(lticket);
        list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner> lsqrc = new list<BLN_SurveyQuestionsReportCon_BAL.surveyAttendeeInner>();
        lsqrc.add(sqrc);
        BLN_SurveyByAttendeeTabReportCon.DataTableWrapper3 dtw3 = new BLN_SurveyByAttendeeTabReportCon.DataTableWrapper3(3,10,5,lsqrc);
        blnbsqtrc.exportselected3();
        blnbsqtrc.exportSurveyQuestions2();
        blnbsqtrc.exportSurveyQuestions2batch();
        

        
        
        

        }
    
    }
}