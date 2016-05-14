@isTest
public class Test_BLN_UserAnswers_DAO {
    static testMethod void testMethod_BLN_UserAnswers_DAO(){
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
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN); 
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c ticInfo= new Ticket__c();
            ticInfo= globalTest.createTicketwithtktProfile(eventInfo.id,item.id,ItemPool.Id, itemType.Id,insertOrder1.id,tktprof.id );
            
            question__c qInfo= new question__c();
            qInfo= globalTest.createQuestion(eventInfo.id);
            
            Bln_answer__c ansInfo= new Bln_answer__c();
            ansInfo= globalTest.createAnswer(qInfo.id);
            
            item_question__c iqInfo= new item_question__c();
            iqInfo= globalTest.createItemQuestion(eventInfo.id,item.id,qInfo.Id);
            
            user_answer__c usaInfo= new user_answer__c ();
            usaInfo= globalTest.createUserAnswer(gnUser.id,iqInfo.id,ansInfo.Id);
            
            BLN_UserAnswers_DAO usa=new BLN_UserAnswers_DAO();
            usa.userAnswersListForItemPool(qInfo.id);
            usa.userAnswersListForPrint(eventInfo.id);
            usa.userAnswersList(iqInfo.id);
            usa.allUserAnswersForItemQuestionPrintXport(eventInfo.id);
            usa.allUserAnswersForItemQuestion(iqInfo.id);
            
            usa.userAnswersForItemPoolQuestion(iqInfo.id);
            usa.userAnswersForItemQuestion(iqInfo.id);
            usa.userAnswersList(iqInfo.id);
            
            set<id> qid=new set<id>();
            List<question__c> qlist=[select id from question__c where event__c= : eventInfo.id];
            for(question__c q : qlist){
                qid.add(q.id);
            }
            
            usa.questionWiseRespXprint(qid);
            usa.questionWiseResp(qInfo.id);
            
            set<id> tid=new set<id>();
            set<id> itmid=new set<id>();
            set<id> usaid=new set<id>();
            string[] sans=new string[]{};
            List<ticket__c> tlist=[select id,Item__r.id from ticket__c where event__c= : eventInfo.id];
            for(ticket__c t : tlist){
                tid.add(t.id);
                itmid.add(t.Item__r.id);
                for(user_answer__c u1 : t.user_answers__r){
                    usaid.add(u1.id);
                }
            }
            
            //List<bln_answer__c> balist=[select id,name from bln_answer__c limit 3];
            //for(bln_answer__c a1 : balist){
                //sans.add(a1.id);
            //}
            
            usa.userAnswersForEventLevelSurveyQuestions(tid,eventInfo.id);
            usa.userAnswersForTickets(tid,itmid,eventInfo.id);
            usa.fetchUserAnswer(ticInfo.id);
             try{
                 usa.insertUserAnswer(ansInfo.id,iqInfo.id,ticInfo.id);
           }
           catch(Exception e){}
           try{
            usa.upsertSurveyUserAnswer(ansInfo.id,iqInfo.id,ticInfo.id,usaInfo.id,'test');
             }
           catch(Exception e){}
            
            
            usa.userAnswersList(iqInfo.id,'event');
            usa.insertUserAnswerTxtPara(ansInfo.id,iqInfo.id,ticInfo.id);
            usa.upsertSurveyUserAnswerTxtPara(ansInfo.id,iqInfo.id,ticInfo.id,usaInfo.id,'test');
            usa.deleteSurveyUserAnswerTxtPara(ansInfo.id,iqInfo.id,ticInfo.id,usaInfo.id);
            
          
          //  usa.upsertCheckboxSurveyUserAnswer(ansInfo.id,iqInfo.id,ticInfo.id,usaInfo.id,'test');
            
            
            qInfo.Answer_Type__c='Checkboxes' ;
            database.upsert(qInfo,false);
            /*
            Question__c insertQue1=new Question__c();
            insertQue1.Event__c= eventInfo.id;
            insertQue1.Question_Text__c= 'Who are you?' ;
            insertQue1.Answer_Type__c='PText' ;
            insertQue1.Question_Order__c=1 ;     
            insert insertQue1;
            */
             try{
            usa.upsertSurveyUserAnswer(ansInfo.id,iqInfo.id,ticInfo.id,usaInfo.id,'test');
             }
           catch(Exception e){}
           try{
                 usa.insertUserAnswer(ansInfo.id,iqInfo.id,ticInfo.id);
           }
           catch(Exception e){}
           
           sans.add('test');
           try{
           usa.upsertCheckboxSurveyUserAnswer(sans,iqInfo.id,ticInfo.id,usaid,usaInfo.id);
           }
           catch(Exception e1){}
           
           try{
           usa.upsertCheckboxSurveyUserAnswer(sans,iqInfo.id,ticInfo.id,usaid,'');
           }
           catch(Exception e1){}
            
        }
    }
}