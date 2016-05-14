@istest
public class Test_BLN_ls_Fetchleads{
     static testmethod void Test_BLN_ls_Fetchleads(){
     
    globalForTestClass globalTest= new globalForTestClass();
    
   Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
         User u = new User(alias = 'Tes8t', email='testc8ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='testc8ode123x1@noemail.com');
                           
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
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(u, countryInfo.Id, stateInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
          BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
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
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
           // ticket.Client_Company__c= companyInfo.id;
            update ticket;
            
            Lead_Scan__c ls=new Lead_Scan__c();
            ls.First_Name__c='testa';
            ls.Last_Name__c='testb';
            ls.Event__c=eventInfo.id;
            //ls.Scanee_User__c=gnUserInfo.id;
            ls.Scanner_Company__c=companyInfo.id;
            ls.Scanner_User__c=gnUser.id;
            ls.scan_time__c=system.today();
            insert ls;
            
            badge__c badge=new badge__c();
            badge.ticket_id__c=ticket.id;
            insert badge;
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            que.OwnerId=gnUserInfo.User__c;
            update que;
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
            
            BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
             
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            //usrAns.User__c=ls.Scanee_User__c;
            update usrAns;
            
            
            System.RestContext.request = new RestRequest();
            
            //RestRequest req = new RestRequest(); 
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestContext.request.addParameter('loginUserId',gnUserInfo.id);
            RestContext.request.addParameter('eventId',eventInfo.id);
            RestContext.request.addParameter('luCompId',companyInfo.id);
            RestContext.request.requestURI =  sfbaseURL+'/services/apexrest/BLN_ls_Fetchleads';  
            RestContext.request.httpMethod = 'POST';
            
            BLN_ls_Fetchleads blnascitem = new BLN_ls_Fetchleads();
            BLN_ls_Fetchleads.doPost();
            
        }
    }
}