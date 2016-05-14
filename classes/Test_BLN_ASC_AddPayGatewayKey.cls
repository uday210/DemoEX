@isTest
/*
*   Author                  : Rajendra y
*   Purpose                 : This is Test class for BLN_ASC_AddPayGatewayKey.*/

public class Test_BLN_ASC_AddPayGatewayKey
{
 static testmethod void Testmethod_BLN_ASC_AddPayGatewayKey(){
 
 User U= new User();
            globalForTestClass globalTest= new globalForTestClass();
            U= globalTest.createUser();
             system.runas(U)
    {
    //User userForGN= new User();
            //userForGN= globalTest.createUserForGNUser();
             User userInfo= new User();
            userInfo= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userInfo,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            //eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id,); 
            
             eventInfo.Name= 'Default Event(Boothleads)';
        eventInfo.Start_Date__c= system.today();
        eventInfo.End_Date__c= system.today()+4; 
        //eventInfo.Start_Time__c= '7:00 AM';
        //eventInfo.End_Time__c= '4:00 PM'; 
        eventInfo.venue_name__c= 'Hyderabad';
        eventInfo.Organizer_Email__c= 'manasatest@gmail.com';
        eventInfo.organizer_id__c= companyInfo.id;
        eventInfo.BLN_State__c= stateInfo.id;
        eventInfo.BLN_Country__c= countryInfo.id;
       // eventInfo.Logo_URL__c = '015c0000000IAj8';
        eventInfo.Event_Ticket_Options__c='Collect info from Buyers only';
        eventInfo.Service_Fee__c='75.0';
        
        insert eventInfo;      
            
            
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userInfo);
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);
            
            Item_Question__c itemQue = new Item_Question__c();
            itemQue =globalTest.createItemQuestion(eventInfo.id,item.Id,que.Id);
            
           BLN_Answer__c ans = new BLN_Answer__c();
            ans=globalTest.createAnswer(que.Id);
            
            User_Answer__c  usrAns = new User_Answer__c();
            usrAns=globalTest.createUserAnswer(gnUser.id,itemQue.Id, ans.Id);
            
            Hash_Tag__c hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'thirumala', 'globalnest');
            
            //Ticket__c ticket= new Ticket__c();
            //ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            PGateway_Type__c pgt = new PGateway_Type__c(Name='PayPal');
            insert pgt;
            
            
            Pay_Gateway__c pw= new Pay_Gateway__c(Company__c=companyInfo.id,Paygateway_name__c='PayPal',Service_Fee__c='Include',PGateway_Type__c=pgt.id,PG_Email_Id__c='test@gmail.com',PP_Payment_Type__c='Chained',PG_User_Key__c='test2wee',PP_Fee_Payer__c='EACHRECEIVER');
            insert pw;
            
            Event_Pay_Gateway__c epg = new Event_Pay_Gateway__c(Events__c=eventInfo.id,Pay_Gateway__c=pw.id,Registration_Type__c='Online');
              insert epg;
    
           System.RestContext.request = new RestRequest();
           
           RestContext.request.requestURI ='/GlobalnestEM/BLN_ASC_AddPayGatewayKey';
     
           RestContext.request.addParameter('Event_Id',eventInfo.id);
           RestContext.request.addParameter('Module',epg.id);
           RestContext.request.addParameter('Paygatewaykeyname',pw.id);
           RestContext.request.addParameter('Paygatewayid',pw.id);
         
           RestContext.request.requestBody  = blob.valueOf('{"pgopt": "PayPal", "firstparam":"success","secondparam":null}');
           RestContext.request.httpMethod = 'POST';
    
 
          
          BLN_ASC_AddPayGatewayKey.doPost();
         
    
     
 }
 }
 
 }