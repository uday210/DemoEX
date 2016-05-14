@isTest
//Test class for BLN_ExportSurveyByQuestionResponseBatch                               
private class Test_BLN_ExportSurveyByQuestionRespbatch {

    static testmethod void test_BLN_ExportSurveyByQuestionResponseBatch() {
    
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
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            
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
            list<BLN_Item__c>  itemli = new list<BLN_Item__c>();   
            itemli.add(item);
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            
            Question__c que1 = new Question__c();
            que1=globalTest.createQuestion(eventInfo.id);
            que1.Answer_Type__c='Checkboxes' ;
            update que1;
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
            
            Item_Question__c itemQue1 = new Item_Question__c();
            itemQue1 =globalTest.createItemQuestion(eventInfo.id,item.Id,que1.Id);
            
            BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
            
            BLN_Answer__c ans1 = new BLN_Answer__c();
            ans1=globalTest.createAnswer(que1.Id);
            
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            
            User_Answer__c  usrAns1 = new User_Answer__c();
            usrAns1=globalTest.createUserAnswer(gnUser.id,itemQue1.Id, ans1.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
           // string query = 'SELECT ticket__r.tkt_profile__r.First_Name__c,ticket__r.tkt_profile__r.Last_Name__c,ticket__r.tkt_profile__r.Email__c,ticket__r.tkt_profile__r.Mobile__c,item_question__r.question_level__c,ticket__r.item_pool__r.item_pool_name__c,Item_Question__r.Question__r.Question_Text__c,UAnswer_Text_Update__c,item_question__r.question__r.answer_type__c,item_question__r.item__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__r.Item_Pool_Name__c from user_answer__c';
            string query ='SELECT Id,ticket__r.item_pool__r.Item_Pool_Name__c,item_question__r.item__c,item_question__r.item_pool__c,item_question__r.item__r.item_name__c,item_question__r.item_pool__r.item_pool_name__c,Uanswer_text_update__c,ticket__r.item__r.item_name__c,item_question__r.question__r.question_text__c,ticket__r.item__r.ticket_settings__c,Item_Question__r.Question__r.Answer_Type__c,Item_Question__r.Question_Level__c, UAnswer_Text__c, Ticket__r.name,Ticket__r.tkt_profile__r.first_name__c,Ticket__r.tkt_profile__r.last_name__c FROM User_Answer__c ';

            
             BLN_ExportSurveyByQuestionResponseBatch esqrb = new  BLN_ExportSurveyByQuestionResponseBatch(query, que.id,10,new LIST<BLN_SurveyByQuestionTabReportCon.responsesInner>(),'question name',20);
             Database.QueryLocator QL;
             Database.BatchableContext BC;
             Database.executebatch(esqrb ,90);
           
        } 

    }
    
    }