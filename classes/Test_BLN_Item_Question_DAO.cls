@isTest
public class Test_BLN_Item_Question_DAO{
    static testmethod void Testmethod_BLN_Item_Question_DAO(){
    
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
        
        
        Question__c que = new Question__c();
        que=globalTest.createQuestion(eventInfo.id);
        
        Item_Question__c itemQue = new Item_Question__c();
        itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
        
        list<Item_Question__c> listitemque = new list<Item_Question__c>();
        listitemque.add(itemQue);
        
      BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
             
        User_Answer__c  usrAns = new User_Answer__c();
        usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
        
        Ticket__c ticket= new Ticket__c();
        ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
        
         cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{counter});  
        
        BLN_Item_Question_DAO itmqueDAO=new BLN_Item_Question_DAO();
        itmqueDAO.querySuveyByQuestions('test');
        itmqueDAO.eventItemQueAns(eventInfo.id,itemQue.id);
        itmqueDAO.itmquestionslist(eventInfo.id,listitemque);
        itmqueDAO.questionsForAnItem(item.id);
        itmqueDAO.questionsForAnItemPool(ItemPool.id);
        itmqueDAO.questionsForTicketLevelEvent(eventInfo.id);
        itmqueDAO.questionsForEvent(eventInfo.id);
        itmqueDAO.UpsertItemQuestion(listitemque);
        itmqueDAO.deleteitmque(listitemque);
        itmqueDAO.questionsforLeads(eventInfo.id);
        itmqueDAO.itemQuestionswithuseranswers(eventInfo.id);
        itmqueDAO.itemQuestionsForTickets(new SET<Id>(),eventInfo.id);
         
    }
 }
 }