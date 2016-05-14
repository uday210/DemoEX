@istest
public class Test_BLN_ASC_EventRefresh {
    static testmethod void Test_BLN_ASC_EventRefresh (){
       
        globalForTestClass globalTest= new globalForTestClass();
        
        Account acc= new Account(Name='Globalnest');
         insert acc;
    
        contact con = new contact(firstname='gnwe',lastname='usser',AccountId=acc.id);
        insert con;
        Profile p = [select id from profile where name='Event Admin1'];
        
        
         User U= new User(alias = 'gnes', email='refresh@noemail.com', firstname= 'fngn', Phone= '9875654345',ContactId= con.Id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='gnuser', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNest',
                                  timezonesidkey='America/Los_Angeles', username='refresh@noemail.com', Title= 'SFDC Developer');
        database.insert(U,false);
        
       
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
            gnUser = globalTest.createGNUser(U,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
        //Order__c insertOrder1= new Order__c();
        //insertOrder1= globalTest.createOrder(gnUser.Id, U.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
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
            
              Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion1.id, currenyInfo.Id);
            
        Hash_Tag__c tagInfo1= new Hash_Tag__c();
        tagInfo1= globalTest.createTag(eventInfo.Id);
       
        list<Hash_Tag__c> taglst= new list<Hash_Tag__c>();
        taglst.add(tagInfo1);
          
             system.runas(U){
            //ItemPool_Tag_Junction__c itemPJ = new ItemPool_Tag_Junction__c ();
            //itemPJ=globalTest.createtagjunction(itemPool.Id, hashT.Id);
            
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            RestRequest req = new RestRequest(); 
            req.addParameter('Event_id', eventInfo.id);
            req.addParameter('LastModifiedDate','2015-05-05 20:03:20');
            req.addParameter('User_id',U.id);
            req.addParameter('appname','eventdex');
            req.addParameter('Request_Flag','Event');
            
            req.requestURI = '/BLN_ASC_EventRefresh';  
            req.httpMethod = 'POST';
            RestContext.request = req;
           system.debug('@@req'+req);
       
try{
             BLN_ASC_EventRefresh.doPost();
             
             }catch(Exception e){}
            
            
              RestRequest req1 = new RestRequest(); 
            req1.addParameter('Event_id', eventInfo.id);
            req1.addParameter('LastModifiedDate','2015-05-05 20:03:20');
            req1.addParameter('User_id',U.id);
            req1.addParameter('appname','eventdex');
            req1.addParameter('Request_Flag','Itemandattendees');
            
            req1.requestURI = '/BLN_ASC_EventRefresh';  
            req1.httpMethod = 'POST';
            RestContext.request = req1;
            
          system.debug('@@req1'+req1);
           // try {
             BLN_ASC_EventRefresh.doPost();
           // } catch (Exception e) {}
             
 }
 }
 }