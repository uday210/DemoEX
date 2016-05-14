@istest(seeAllData=true)
public class Test_BLN_SuccessController{
    static testmethod void TestSuccessController(){
//User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        
        Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];  
         User U = new User(alias = 'Test', email='testcode1z@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='testlast', Firstname='testname', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1z@noemail.com');
         Database.insert(U);             
        system.runas(U){
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();      
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            eventInfo.Organizer_Email__c = userForGN.email;
            update eventInfo;
            
            BLN_BadgeTemplate_Styles__c badTStyleInfo=new BLN_BadgeTemplate_Styles__c();
            badTStyleInfo=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1.Order_Status__c='Abandoned';
            update insertOrder1;
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Name='Booths /Tables';
            update itemType;
            
            Item_Type__c itemType1= new Item_Type__c();
            itemType1= globalTest.createItemType();
            itemType1.Name='Sponsorship';
            update itemType1;
            
            Item_Type__c itemType2= new Item_Type__c();
            itemType2= globalTest.createItemType();
            itemType2.Name='Lead Retrieval';
            update itemType2;
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType1.Id, ItemPool.Id, trackInfo.Id);
           
            Item_Pool__c ItemPool3= new Item_Pool__c();
            ItemPool3= globalTest.createItemPool(eventInfo.id, itemType2.Id, ItemPool.Id, trackInfo.Id);
           
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, itemPool2.Id, itemType1.Id, insertOrder1.Id, tktprof.Id);
            
            Ticket__c ticket2= new Ticket__c();
            ticket2= globalTest.createTicket(eventInfo.id, item.Id, itemPool3.Id, itemType2.Id, insertOrder1.Id, tktprof.Id);
            
            Promotion__c  promotion= new Promotion__c ();
              promotion  = globalTest.createPromotion(eventInfo.id, 'test promotion', 'Basic Promo codes', 'Percent')   ;
                       
            Item_Promotion__c itpormotion = new Item_Promotion__c();
            itpormotion =  globalTest.createItemPromotion(item.id,promotion.id ,'Percent');
                       
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion.id, currenyInfo.Id);
            
            
             BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            //PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='TrustCommerce',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
            
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
                       
            
            
            Payment__c payment= new Payment__c(Payment_Amount__c = 20.2,Currency_Code__c = currenyInfo.Id,Order__c = insertOrder1.Id,BLN_Pay_Gateway__c=paygateway.id,Payment_Ref_Number__c = '123');
            insert payment;
            
            Apexpages.currentpage().getparameters().put('transid',payment.Payment_Ref_Number__c);
            
            BLN_BadgeTemplate_Styles__c badTempStyl=new BLN_BadgeTemplate_Styles__c ();
            badTempStyl=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Badge__c bdg= new Badge__c();
            bdg=globalTest.createBadge(ticket.id);
            
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool2.Id, item.Id, companyInfo.Id, NULL, 'Regular', 'AS_Last_Name__c');
            
          /*  EmailCampaign__c emailCampaignInfo= new EmailCampaign__c();
            emailCampaignInfo= globalTest.createEmailCampaign(eventInfo);
            emailCampaignInfo.Template_Type__c = 'System';
            emailCampaignInfo.System_Template_Type__c= 'Order Confirmation';
            emailCampaignInfo.Template_Status__c = 'Active';
            update emailCampaignInfo; */
            
          string EventId=eventinfo.id;
          
          Cookie uLang = new Cookie('visibleType','userLanguage', null, -1, false);
            Cookie vtype=ApexPages.currentPage().getCookies().put('prcok',uLang);
  
            Cookie abnJob1= new Cookie('visibleType','userLanguage', null, -1, false);
            Cookie abnJob=ApexPages.currentPage().getCookies().put('abnJob',abnJob1);
  
            BLN_SuccessController suc= new BLN_SuccessController();
            suc.firstMethod();
            BLN_SuccessController suc1= new BLN_SuccessController('test342');
            
            
            
            Datetime myDatetime = insertOrder1.createddate;
               //String myDatetimeStr = myDatetime.format('MM-dd-yyyy hh:mm a');
            apexpages.currentpage().getparameters().put('id',EventId);
            //Apexpages.currentPage().getParameters().put('status','accept');
            apexpages.currentpage().getparameters().put('rid',regSettingsInfo2.id);
            suc.registrationTemplate= new Registration_Template__c();
            suc.error = null;
            suc.pgreturnforonsite= null;
            suc.firstMethod();
            //try{
            suc.sendMail(insertOrder1.id,EventId);
            //}catch(exception e){}
            
            pggatewaytype.Name='Check';
            update pggatewaytype;
            insertOrder1.Order_Status__c='Abandoned';
            update insertOrder1;
            suc.sendMail(insertOrder1.id,EventId);
            }
            }
            
            
            /*
    static testmethod void TestSuccessController2(){

        globalForTestClass globalTest= new globalForTestClass();
        
        Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];  
         User U = new User(alias = 'Test', email='testcode1z@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='testlast', Firstname='testname', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1z@noemail.com');
         Database.insert(U);             
        system.runas(U){
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();      
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            
            BLN_BadgeTemplate_Styles__c badTStyleInfo=new BLN_BadgeTemplate_Styles__c();
            badTStyleInfo=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1.Order_Status__c='Abandoned';
            update insertOrder1;
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
           
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            Promotion__c  promotion= new Promotion__c ();
              promotion  = globalTest.createPromotion(eventInfo.id, 'test promotion', 'Basic Promo codes', 'Percent')   ;
                       
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, promotion.id, currenyInfo.Id);
            
            
             BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
            
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
                
            
                      
            Payment__c payment= new Payment__c(Payment_Amount__c = 20.2,Currency_Code__c = currenyInfo.Id,Order__c = insertOrder1.Id,BLN_Pay_Gateway__c=paygateway.id);
            insert payment;
            
            BLN_BadgeTemplate_Styles__c badTempStyl=new BLN_BadgeTemplate_Styles__c ();
            badTempStyl=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Badge__c bdg= new Badge__c();
            bdg=globalTest.createBadge(ticket.id);
            
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool2.Id, item.Id, companyInfo.Id, NULL, 'Regular', 'AS_Last_Name__c');
            
            string EventId=eventinfo.id;
            
            BLN_SuccessController suc= new BLN_SuccessController();
             BLN_SuccessController suc1= new BLN_SuccessController('test');
            suc.registrationTemplate= new Registration_Template__c();
            suc.error = null;
            suc.pgreturnforonsite= null;
            apexpages.currentpage().getparameters().put('rid','');
         
            
            Cookie uLang = new Cookie('visibleType','userLanguage', null, -1, false);
            Cookie vtype=ApexPages.currentPage().getCookies().put('visibleType',uLang); 
            suc.firstMethod();
            
            apexpages.currentpage().getparameters().put('rid','test');
            Cookie vtype2=ApexPages.currentPage().getCookies().put('visibleType',uLang);
            suc.firstMethod();

            
            }
            }*/
            }