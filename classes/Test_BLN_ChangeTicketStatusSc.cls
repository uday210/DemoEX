@istest
global class Test_BLN_ChangeTicketStatusSc{
     static testmethod void Test_BLN_ChangeTicketStatusSc(){
     
      
    globalForTestClass globalTest= new globalForTestClass();
    
   Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
  
         User u = new User(alias = 'Tes6tx', email='xatestc6ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='testc6ode123x1@noemail.com');
                           
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
             BLN_Track__c trackInfo= new BLN_Track__c();
        trackInfo= globalTest.createTrack(eventInfo.id);
        
         Item_Type__c itemType1= new Item_Type__c();
         itemType1= globalTest.createItemType();
         
         Item_Pool__c  ItemPool2= new Item_Pool__c();
         ItemPool2= globalTest.createItemPool(eventInfo.id, itemType1.Id, NULL, trackInfo.id);
            
      BLN_Item__c  item= new BLN_Item__c();
        item= globalTest.createItem(ItemPool2.Id, itemType1.Id, eventInfo.id);
        
       Tkt_profile__c  tktprof = new Tkt_profile__c();
        tktprof=globalTest.createTktprofile(userForGN);
        
        
         Order__c insertOrder1=new Order__c (Currency_Code__c = currenyInfo.id,Events__c = eventInfo.Id ,order_type__c = 'EVENT PRODUCER');
            insert insertOrder1;
         
          Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
        Order_Item__c  orderiteminfo =new Order_Item__c ();
            orderiteminfo = globalTest.createOrderItem(item.id, insertOrder1.id, promotion1.id, currenyInfo.id);
        
        
        Ticket__c ticketinfo = new Ticket__c();
        ticketinfo = globalTest.createTicket(eventInfo.id, item.Id, itemPool2.Id, itemType1.Id, insertOrder1.Id, tktprof.Id);
        list<id> tids= new list<id>();
        tids.add(ticketinfo.id);
        Test.startTest();
                    String CRON_EXP = '0 0 0 1 1 ? 2025';  
                    String jobId = System.schedule('testScheduledApex', CRON_EXP, new BLN_ChangeTicketStatusSc(tids) );

                    CronTrigger ct = [select id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where id = :jobId];

                    System.assertEquals(CRON_EXP, ct.CronExpression); 
                    System.assertEquals(0, ct.TimesTriggered);
                    System.assertEquals('2025-01-01 00:00:00', String.valueOf(ct.NextFireTime));

            Test.stopTest();
        
            }
            }
            }