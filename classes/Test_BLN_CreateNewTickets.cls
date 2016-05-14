@istest
global class Test_BLN_CreateNewTickets{
     static testmethod void Test_BLN_CreateNewTickets(){
     
      
    globalForTestClass globalTest= new globalForTestClass();
    
   Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
  
         User u = new User(alias = 'Tes6t', email='atestc6ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='testc6ode123x1@noemail.com');
                           
                            system.runas(U){
                            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
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
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Cash');
            insert ptype;
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Cash',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
            
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
            Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,BLN_Pay_Gateway__c = paygateway.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id);
            insert payobj;
            ControllerPayDetailApi pdapi = new ControllerPayDetailApi();
            
            try{
            Test.startTest();
                    String CRON_EXP = '0 0 0 1 1 ? 2025';  
                    String jobId = System.schedule('testScheduledApex', CRON_EXP, new BLN_CreateNewTickets(insertOrder1.id) );

                    CronTrigger ct = [select id, CronExpression, TimesTriggered, NextFireTime from CronTrigger where id = :jobId];

                    System.assertEquals(CRON_EXP, ct.CronExpression); 
                    System.assertEquals(0, ct.TimesTriggered);
                    System.assertEquals('2025-01-01 00:00:00', String.valueOf(ct.NextFireTime));

            Test.stopTest();
            }catch(Exception e){}
            }
            }
            }