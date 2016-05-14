@isTest(seeAllData=true)
public class Test_BLN_ImportAttendeesCon {

static testmethod void Testmethod_BLN_ImportAttendeesCon(){
        
      //  User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUser();
        
          Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User u = new User(alias = 'Test', email='testcode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1231c@noemail.com');
         Database.insert(u);
        
        
        
        
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
            
            /*Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);*/
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Type__c itemType2= new Item_Type__c();
            itemType2= globalTest.createItemType12();
            
            Item_Type__c itemType3= new Item_Type__c();
            itemType3= globalTest.createItemType13();
            
            Item_Type__c itemType4= new Item_Type__c();
            itemType4= globalTest.createItemType15();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            BLN_Item__c item2= new BLN_Item__c();
            item2= globalTest.createItem(ItemPool.Id, itemType2.Id, eventInfo.id);
            
            BLN_Item__c item3= new BLN_Item__c();
            item3= globalTest.createItem(ItemPool.Id, itemType3.Id, eventInfo.id);
            
            BLN_Item__c item4= new BLN_Item__c();
            item4= globalTest.createItem(ItemPool.Id, itemType4.Id, eventInfo.id);
               
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            Promotion__c promotion2= new Promotion__c();
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo1', 'Multi-Items Discount', 'Percent');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo2', 'Multi-Items Discount', 'Amount');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo3', 'Multi-Items Discount', 'Quantity');
            
            Promotion__c promotion3= new Promotion__c();
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo1', 'Buy Something Get Something', 'Percent');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo2', 'Buy Something Get Something', 'Amount');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo3', 'Buy Something Get Something', 'Quantity');
            
            Promotion__c promotion4= new Promotion__c();
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo1', 'Spend More Save More', 'Percent');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo2', 'Spend More Save More', 'Amount');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo3', 'Spend More Save More', 'Quantity');
            
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
            
            /*Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id); */
            
            Reg_Setting__c  rsett = new Reg_Setting__c();
            rsett = globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.Id, companyInfo.Id, hashT.id, 'Vineel', 'globalneXt');
            
            
             Hash_Tag__c Htag = new Hash_Tag__c();
            Htag = globalTest.createHashTag(eventInfo.Id);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
             tktprof=globalTest.createTktprofile(userForGN);
             tktprof.BLN_GN_User__c = gnUser.id;
             Update tktprof;
             
              Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             
              Ticket__c ticket= new Ticket__c();
             ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
             
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            List<Reg_Setting__c>  rsett1 = new List<Reg_Setting__c>();
            rsett1.add(rsett);
            
            test.startTest();
            
            PageReference pageRef = Page.BLN_Mytickets;
            Test.setCurrentPage(pageRef);
            String nextPage =  ApexPages.currentPage().getUrl();
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            
            Agenda__c agnda =new Agenda__c(Agenda_Name__c='test Seminar',Agenda_Type__c='Event level Agenda',Event__c=eventInfo.id);
            insert agnda;
            
            Time_Slots__c tslot =new Time_Slots__c(name='a1wM0000000owA6',Slot_Start_date__c=system.today(),Slot_End_date__c=system.today()+2,Agenda__c=agnda.Id);
            insert tslot;
           
            Participant__c pspnt = new Participant__c(name='Test pspnt',Time_Slot__c=tslot.Id,Participant_Role__c='speaker',BLN_TKT_profile__c = tktprof.Id);
            Insert pspnt;
            
            BLN_Participant_Role__c pRole = new BLN_Participant_Role__c(name='Test p role',Participant_Name__c=pspnt.Id,BLN_Events__c=eventInfo.Id);
            insert pRole;
            
            BLN_ExceptionCountryState__c blnexcconst = new BLN_ExceptionCountryState__c();
            blnexcconst.InputCountry__c =countryInfo.id;
            blnexcconst.InputState__c = stateInfo.id;
            blnexcconst.BLN_Events__c = eventInfo.id;
            insert blnexcconst;
            
            BLN_ExceptionCountryState__c blnexcconst2 = new BLN_ExceptionCountryState__c();
            blnexcconst.InputCountry__c = countryInfo.id;
            //blnexcconst2.InputState__c = stateInfo.id;
            blnexcconst2.BLN_Events__c = eventInfo.id;
            insert blnexcconst2;
            
            BLN_ExceptionCountryState__c blnexcconst3 = new BLN_ExceptionCountryState__c();
            //blnexcconst.InputCountry__c = 'India';
            blnexcconst3.InputState__c = stateInfo.id;
            blnexcconst3.BLN_Events__c = eventInfo.id;
            insert blnexcconst3;
            
            BLN_UtillDisplayLinks udl = new BLN_UtillDisplayLinks();  
             ApexPages.currentpage().getParameters().put('id',eventInfo.Id);  
            
            BLN_ImportAttendeesCon.header blnhdr1 = new BLN_ImportAttendeesCon.header();
            blnhdr1.csvheader = 'Email';
            blnhdr1.field= 'Email__c'; 
            BLN_ImportAttendeesCon.header blnhdr2 = new BLN_ImportAttendeesCon.header();
            blnhdr2.csvheader = 'First_Name';
            blnhdr2.field= 'First_Name__c';  
            BLN_ImportAttendeesCon.header blnhdr3= new BLN_ImportAttendeesCon.header();
            blnhdr3.csvheader = 'Last_Name';
            blnhdr3.field= 'Last_Name__c'; 
            
            BLN_ImportAttendeesCon.header blnhdr4 = new BLN_ImportAttendeesCon.header();
            blnhdr4.csvheader = 'WorkCountry';
            blnhdr4.field= 'WorkCountry__c';  
            
            BLN_ImportAttendeesCon.header blnhdr5 = new BLN_ImportAttendeesCon.header();
            blnhdr5.csvheader = 'WorkState';
            blnhdr5.field= 'WorkState__c';  
            
            BLN_ImportAttendeesCon.header blnhdr6 = new BLN_ImportAttendeesCon.header();
            blnhdr6.csvheader = 'HomeCountry';
            blnhdr6.field= 'HomeCountry__c';  
            BLN_ImportAttendeesCon.header blnhdr7 = new BLN_ImportAttendeesCon.header();
            blnhdr7.csvheader = 'HomeState';
            blnhdr7.field= 'HomeState__c';  
            
            list<BLN_ImportAttendeesCon.header> listblnhdr = new list<BLN_ImportAttendeesCon.header>();
            
            listblnhdr.add(blnhdr2);   
            listblnhdr.add(blnhdr3); 
            listblnhdr.add(blnhdr1); 
            listblnhdr.add(blnhdr4); 
            listblnhdr.add(blnhdr5); 
            listblnhdr.add(blnhdr6); 
            listblnhdr.add(blnhdr7); 
       
            
            List<string> listallfields = new List<string>();
            listallfields.add('FirstName__c');
            listallfields.add('LastName__c');
            listallfields.add('Email__c');
            listallfields.add('WorkCountry__c');
            listallfields.add('WorkState__c');
           // listallfields.add('Email__c');
            listallfields.add('HomeCountry__c');
            listallfields.add('HomeState__c');  
            
           BLN_ImportAttendeesCon impattcon = new BLN_ImportAttendeesCon();   
           impattcon.ecslist = new list<BLN_ImportAttendeesCon.ExceptionCountryState>();
           BLN_ImportAttendeesCon.ExceptionCountryState ecslist0 = new BLN_ImportAttendeesCon.ExceptionCountryState();
           ecslist0.InputCountry = countryInfo.id;
           ecslist0.InputState = stateInfo.id;
           ecslist0.OutputCountry = countryInfo.id;
           ecslist0.OutputState = stateInfo.id;
           ecslist0.outputstatenotneeded = true;
           
           BLN_ImportAttendeesCon.ExceptionCountryState ecslist1 = new BLN_ImportAttendeesCon.ExceptionCountryState();
           ecslist1.InputCountry = countryInfo.id;
           ecslist1.InputState = stateInfo.id;
           ecslist1.OutputCountry =countryInfo.id;
           ecslist1.OutputState = stateInfo.id;
           ecslist1.outputstatenotneeded = true;
           impattcon.ecslist.add(ecslist0);
           impattcon.ecslist.add(ecslist1);
           impattcon.selecteditem = item.id;
           impattcon.gridrows= listblnhdr ;
           
           impattcon.fieldsoptions = new List<SelectOption>();  
           impattcon.fieldsoptions.add(new SelectOption('First_Name','First_Name'));
           impattcon.fieldsoptions.add(new SelectOption('Last_Name','Last_Name'));
           impattcon.fieldsoptions.add(new SelectOption('Email','Email'));
           impattcon.fieldsoptions.add(new SelectOption('Phone','Phone'));
           impattcon.fieldsoptions.add(new SelectOption('WorkCountry','WorkCountry'));
           impattcon.fieldsoptions.add(new SelectOption('WorkState','WorkState'));
           impattcon.fieldsoptions.add(new SelectOption('HomeCountry','HomeCountry'));
           impattcon.fieldsoptions.add(new SelectOption('HomeState','HomeState'));
           
           
            
            //new code added by purna
            //Attachemnts
             string csvContent  = ''
                + '"First_Name","Last_Name","Email","Phone","WorkCountry","WorkState","HomeCountry","HomeState"\n'
                + '"Jane","Doe","abc2@def.com","","India","Mizoram","India","Mizoram"\n'
                + '"John","Smith","ab3c@def.com","222 444 55555","India","Mizoram","India","Mizoram"\n'
                +'"John","Smith","abc4@def.com","222 444 55555","India","Mizoram","India","Mizoram"\n'
                +'"John","Smith","abc5@def.com","222 444 55555","India","Mizoram","India","Mizoram"\n'
                ;
            impattcon.csvFileName='SampleCSV';
            
            Blob b = Blob.valueOf(csvContent);        
            Attachment attachment = new Attachment();  
            attachment.ParentId = eventInfo.id;  
            attachment.Name = 'SampleCSV';  
            attachment.Body = b;
            insert(attachment);  
           // String myString = '"Email__c"",""First_Name__c""Last_Name__c"""""""StringToBlob"""""""""""""u"i0,""""';            
           // impattcon.csvFileBody = Blob.valueof(myString);
           
           
           string csvLine1 ='"First_Name","Last_Name","Email","Phone","WorkCountry","WorkState","HomeCountry","HomeState"\r\n';
           string csvLine2 ='"John","Smith","abc@def.com","222 444 55555","India","Mizoram","India","Mizoram"\r\n';
           string csvLine3 ='"John","Smith","abc2@def.com","222 444 55555","India","Mizoram","India","Mizoram"\r\n';
           string csvLine4 ='"John","Smith","abc3@def.com","222 444 55555","India","Mizoram","India","Mizoram"\r\n';
           string csvLine5 ='"John","Smith","abc4@def.com","222 444 55555","India","Mizoram","India","Mizoram"\r\n';
           
           
            
            String myString = csvLine1 +  csvLine2 + csvLine3 + csvLine4 + csvLine5 ;        

           // String myString = csvLine1 + '\r\n' + csvLine2 + '\r\n' + csvLine3 + '\r\n + csvLine4 + '\r\n' + csvLine5 + '\r\n' + csvLine6 + '\r\n' + csvLine7 ;

           // String myString = '"Email__c"",""First_Name__c""Last_Name__c"""""""StringToBlob"""""""""""""u"i0,""""';            
            impattcon.csvFileBody = Blob.valueof(myString);
            
            //variables
            List<String> allfieldssub = new List<String>();
            allfieldssub.add('Email__c');
            allfieldssub.add('First_Name__c');
            allfieldssub.add('Last_Name__c');
            allfieldssub.add('WorkCountry__c');
            allfieldssub.add('WorkState__c');
            allfieldssub.add('HomeCountry__c');
            allfieldssub.add('HomeState__c');
            List<String> allfieldssub2 = new List<String>();
            allfieldssub2.add('adsf@gmail.com');
            allfieldssub2.add('siva');
            allfieldssub2.add('s');
            allfieldssub2.add('India');
            allfieldssub2.add('Mizoram');
            allfieldssub2.add('India');
            allfieldssub2.add('Mizoram');
            List<String> allfieldssub3 = new List<String>();
            allfieldssub3.add('ssss@gmail.com');
            allfieldssub3.add('pavan');
            allfieldssub3.add('p');
            allfieldssub3.add('India');
            allfieldssub3.add('Mizoram');
            allfieldssub3.add('India');
            allfieldssub3.add('Mizoram');
            List<String> allfieldssub4= new List<String>();
            allfieldssub4.add('ssss4@gmail.com');
            allfieldssub4.add('pavan');
            allfieldssub4.add('p');
            allfieldssub4.add('India');
            allfieldssub4.add('Mizoram');
            allfieldssub4.add('India');
            allfieldssub4.add('Mizoram');
            
            impattcon.allFields = new List<List<String>>();
            impattcon.allFields.add(allfieldssub);
            impattcon.allFields.add(allfieldssub2);
            impattcon.allFields.add(allfieldssub3);
            impattcon.allFields.add(allfieldssub4);
            //page parameters
            ApexPages.currentpage().getParameters().put('id',eventInfo.Id);
            Apexpages.currentPage().getParameters().put('countryid',countryInfo.id);
            ApexPages.currentpage().getParameters().put('id',eventInfo.id);
            //classes covered
            
            BLN_ImportAttendeesCon.ExceptionCountryState blnhdrn1 = new BLN_ImportAttendeesCon.ExceptionCountryState();
            blnhdrn1.InputCountry=countryInfo.id;
            blnhdrn1.InputState=stateInfo.id;
            blnhdrn1.OutputCountry=countryInfo.id;
            blnhdrn1.OutputState=stateInfo.id;
            blnhdrn1.outputstatenotneeded=true;
            //methods 
            
            impattcon.callFinalImport();
            impattcon.getstates();
            BLN_ImportAttendeesCon.statesBasedOnCountry(countryInfo.id);
            BLN_ImportAttendeesCon.getusacountryid(eventInfo.id);
            
            BLN_ImportAttendeesCon.validatemd(item.id,eventInfo.id,listblnhdr,'SampleCSV',listblnhdr,listallfields);
            //BLN_ImportAttendeesCon.validatemd(item.id,eventInfo.id,,,,,);
            BLN_ImportAttendeesCon.parseCSV(csvContent,false);
            impattcon.importCSVFile();
            impattcon.Import();   
            impattcon.exportToCSV();
                        
            
            impattcon.workadd=true;
            impattcon.homeadd=true;
            impattcon.callFinalImport();
            test.stopTest();
        

    
    
            }
        }
        
        static testmethod void Testmethod_BLN_ImportAttendeesCon2(){
        
      //  User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUser();
        
          Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User u = new User(alias = 'Test', email='testcode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1231c@noemail.com');
         Database.insert(u);
        
        
        
        
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
            
            /*Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);*/
            
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
               
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo2', 'Basic Promo codes', 'Amount');
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo3', 'Basic Promo codes', 'Quantity');
            
            Promotion__c promotion2= new Promotion__c();
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo1', 'Multi-Items Discount', 'Percent');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo2', 'Multi-Items Discount', 'Amount');
            promotion2= globalTest.createPromotion(eventInfo.id, 'Multi-Items Discount Promo3', 'Multi-Items Discount', 'Quantity');
            
            Promotion__c promotion3= new Promotion__c();
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo1', 'Buy Something Get Something', 'Percent');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo2', 'Buy Something Get Something', 'Amount');
            promotion3= globalTest.createPromotion(eventInfo.id, 'Buy Something Get Something Promo3', 'Buy Something Get Something', 'Quantity');
            
            Promotion__c promotion4= new Promotion__c();
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo1', 'Spend More Save More', 'Percent');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo2', 'Spend More Save More', 'Amount');
            promotion4= globalTest.createPromotion(eventInfo.id, 'Spend More Save More Promo3', 'Spend More Save More', 'Quantity');
            
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
            
            /*Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id); */
            
            Reg_Setting__c  rsett = new Reg_Setting__c();
            rsett = globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.Id, companyInfo.Id, hashT.id, 'Vineel', 'globalneXt');            
            
            
            Reg_Setting__c  rsett2 = new Reg_Setting__c();
            rsett2 = globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.Id, companyInfo.Id, hashT.id, 'Regular', 'globalneXt');
            rsett2.Defaullt_Label__c='Work Address';
            update rsett2;
            
            Reg_Setting__c  rsett3= new Reg_Setting__c();
            rsett3 = globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.Id, companyInfo.Id, hashT.id, 'Regular', 'globalneXt');
            rsett3.Defaullt_Label__c='Home Address';
            update rsett3;
            
             Hash_Tag__c Htag = new Hash_Tag__c();
            Htag = globalTest.createHashTag(eventInfo.Id);
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
             tktprof=globalTest.createTktprofile(userForGN);
             tktprof.BLN_GN_User__c = gnUser.id;
             Update tktprof;
             
              Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             
              Ticket__c ticket= new Ticket__c();
             ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
             
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            List<Reg_Setting__c>  rsett1 = new List<Reg_Setting__c>();
            rsett1.add(rsett);
            
            test.startTest();
            
            PageReference pageRef = Page.BLN_Mytickets;
            Test.setCurrentPage(pageRef);
            String nextPage =  ApexPages.currentPage().getUrl();
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            
            Agenda__c agnda =new Agenda__c(Agenda_Name__c='test Seminar',Agenda_Type__c='Event level Agenda',Event__c=eventInfo.id);
            insert agnda;
            
            Time_Slots__c tslot =new Time_Slots__c(name='a1wM0000000owA6',Slot_Start_date__c=system.today(),Slot_End_date__c=system.today()+2,Agenda__c=agnda.Id);
            insert tslot;
           
            Participant__c pspnt = new Participant__c(name='Test pspnt',Time_Slot__c=tslot.Id,Participant_Role__c='speaker',BLN_TKT_profile__c = tktprof.Id);
            Insert pspnt;
            
            BLN_Participant_Role__c pRole = new BLN_Participant_Role__c(name='Test p role',Participant_Name__c=pspnt.Id,BLN_Events__c=eventInfo.Id);
            insert pRole;
            
               
            ApexPages.currentpage().getParameters().put('id',eventInfo.Id);
           /* BLN_ImportAttendeesCon impattcon = new BLN_ImportAttendeesCon();
            string csvContent  = ''
                + '"First Name","Last Name","Birthdate","Email","Phone"\n'
                + '"Jane","Doe","","",""\n'
                + '"John","Smith","2/3/1985","abc@def.com","222 444 55555"\n'
                ;
                
            impattcon.csvFileName='SampleCSV';
            
            Blob b = Blob.valueOf(csvContent);        
            Attachment attachment = new Attachment();  
            attachment.ParentId = 'a19290000003kAM';  
            attachment.Name = 'SampleCSV';  
            attachment.Body = b;
            insert(attachment);  
            
            String myString = '"Email__c"",""First_Name__c""Last_Name__c"""""""StringToBlob"""""""""""""u"i0,""""';            
            impattcon.csvFileBody = null;
            BLN_ImportAttendeesCon.parseCSV(csvContent,false);
            impattcon.importCSVFile();
            try{
            impattcon.Import();   
            }catch(Exception e){}
            impattcon.exportToCSV();
            */
            
             BLN_ExceptionCountryState__c blnexcconst = new BLN_ExceptionCountryState__c();
            blnexcconst.InputCountry__c =countryInfo.id;
            blnexcconst.InputState__c = stateInfo.id;
            blnexcconst.BLN_Events__c = eventInfo.id;
            insert blnexcconst;
            
            BLN_ExceptionCountryState__c blnexcconst2 = new BLN_ExceptionCountryState__c();
            blnexcconst.InputCountry__c = countryInfo.id;
            //blnexcconst2.InputState__c = stateInfo.id;
            blnexcconst2.BLN_Events__c = eventInfo.id;
            insert blnexcconst2;
            
            BLN_ExceptionCountryState__c blnexcconst3 = new BLN_ExceptionCountryState__c();
            //blnexcconst.InputCountry__c = 'India';
            blnexcconst3.InputState__c = stateInfo.id;
            blnexcconst3.BLN_Events__c = eventInfo.id;
            insert blnexcconst3;
            
            BLN_UtillDisplayLinks udl = new BLN_UtillDisplayLinks();  
             ApexPages.currentpage().getParameters().put('id',eventInfo.Id);  
            
            BLN_ImportAttendeesCon.header blnhdr1 = new BLN_ImportAttendeesCon.header();
            blnhdr1.csvheader = 'Email';
            blnhdr1.field= 'Email__c'; 
            BLN_ImportAttendeesCon.header blnhdr2 = new BLN_ImportAttendeesCon.header();
            blnhdr2.csvheader = 'First_Name';
            blnhdr2.field= 'First_Name__c';  
            BLN_ImportAttendeesCon.header blnhdr3= new BLN_ImportAttendeesCon.header();
            blnhdr3.csvheader = 'Last_Name';
            blnhdr3.field= 'Last_Name__c'; 
            
            BLN_ImportAttendeesCon.header blnhdr4 = new BLN_ImportAttendeesCon.header();
            blnhdr4.csvheader = 'WorkCountry';
            blnhdr4.field= 'WorkCountry__c';  
            
            BLN_ImportAttendeesCon.header blnhdr5 = new BLN_ImportAttendeesCon.header();
            blnhdr5.csvheader = 'WorkState';
            blnhdr5.field= 'WorkState__c';  
            
            BLN_ImportAttendeesCon.header blnhdr6 = new BLN_ImportAttendeesCon.header();
            blnhdr6.csvheader = 'HomeCountry';
            blnhdr6.field= 'HomeCountry__c';  
            BLN_ImportAttendeesCon.header blnhdr7 = new BLN_ImportAttendeesCon.header();
            blnhdr7.csvheader = 'HomeState';
            blnhdr7.field= 'HomeState__c';  
            
            list<BLN_ImportAttendeesCon.header> listblnhdr = new list<BLN_ImportAttendeesCon.header>();
            
            listblnhdr.add(blnhdr2);   
            listblnhdr.add(blnhdr3); 
            listblnhdr.add(blnhdr1); 
            listblnhdr.add(blnhdr4); 
            listblnhdr.add(blnhdr5); 
            listblnhdr.add(blnhdr6); 
            listblnhdr.add(blnhdr7); 
       
            
            List<string> listallfields = new List<string>();
            listallfields.add('FirstName__c');
            listallfields.add('LastName__c');
            listallfields.add('Email__c');
            listallfields.add('WorkCountry__c');
            listallfields.add('WorkState__c');
           // listallfields.add('Email__c');
            listallfields.add('HomeCountry__c');
            listallfields.add('HomeState__c');  
            
           BLN_ImportAttendeesCon impattcon = new BLN_ImportAttendeesCon();   
           impattcon.ecslist = new list<BLN_ImportAttendeesCon.ExceptionCountryState>();
           BLN_ImportAttendeesCon.ExceptionCountryState ecslist0 = new BLN_ImportAttendeesCon.ExceptionCountryState();
           ecslist0.InputCountry = countryInfo.id;
           ecslist0.InputState = stateInfo.id;
           ecslist0.OutputCountry = countryInfo.id;
           ecslist0.OutputState = stateInfo.id;
           ecslist0.outputstatenotneeded = true;
           
           BLN_ImportAttendeesCon.ExceptionCountryState ecslist1 = new BLN_ImportAttendeesCon.ExceptionCountryState();
           ecslist1.InputCountry = countryInfo.id;
           ecslist1.InputState = stateInfo.id;
           ecslist1.OutputCountry =countryInfo.id;
           ecslist1.OutputState = stateInfo.id;
           ecslist1.outputstatenotneeded = true;
           impattcon.ecslist.add(ecslist0);
           impattcon.ecslist.add(ecslist1);
           impattcon.selecteditem = item.id;
           impattcon.gridrows= listblnhdr ;
           
           impattcon.fieldsoptions = new List<SelectOption>();  
           impattcon.fieldsoptions.add(new SelectOption('First_Name','First_Name'));
           impattcon.fieldsoptions.add(new SelectOption('Last_Name','Last_Name'));
           impattcon.fieldsoptions.add(new SelectOption('Email','Email'));
           impattcon.fieldsoptions.add(new SelectOption('Phone','Phone'));
           impattcon.fieldsoptions.add(new SelectOption('WorkCountry','WorkCountry'));
           impattcon.fieldsoptions.add(new SelectOption('WorkState','WorkState'));
           impattcon.fieldsoptions.add(new SelectOption('HomeCountry','HomeCountry'));
           impattcon.fieldsoptions.add(new SelectOption('HomeState','HomeState'));
           
           
            
            //new code added by purna
            //Attachemnts
             string csvContent  = ''
                + '"First_Name","Last_Name","Email","Phone","WorkCountry","WorkState","HomeCountry","HomeState"\n'
                + '"Jane","Doe","abc2@def.com","","India","Mizoram","India","Mizoram"\n'
                + '"John","Smith","ab3c@def.com","222 444 55555","~~IndiaAlliswell","","~~IndiaAlliswell",""\n'
                +'"John","Smith","abc4@def.com","222 444 55555","","~~Mizoram","","~~Mizoram"\n'
                +'"John","Smith","abc5@def.com","222 444 55555","India","ALASLA","India","ALASKA"\n'
                +'"John","Smith","abc6@def.com","222 444 55555","India","ALASLA","India","ALASKA"\n'
                ;
            impattcon.csvFileName='SampleCSV';
            
            Blob b = Blob.valueOf(csvContent);        
            Attachment attachment = new Attachment();  
            attachment.ParentId = eventInfo.id;  
            attachment.Name = 'SampleCSV';  
            attachment.Body = b;
            insert(attachment);  
           // String myString = '"Email__c"",""First_Name__c""Last_Name__c"""""""StringToBlob"""""""""""""u"i0,""""';            
           // impattcon.csvFileBody = Blob.valueof(myString);
           
           
           string csvLine1 ='"First_Name","Last_Name","Email","Phone","WorkCountry","WorkState","HomeCountry","HomeState"\r\n';
           string csvLine2 ='"John","Smith","abc@def.com","222 444 55555","India","Mizoram","India","Mizoram"\r\n';
           string csvLine3 ='"John","Smith","abc2@def.com","222 444 55555","~~IndiaAlliswell","","~~IndiaAlliswell",""\r\n';
           string csvLine4 ='"John","Smith","abc3@def.com","222 444 55555","","~~Mizoram","","~~Mizoram"\r\n';
           string csvLine5 ='"John","Smith","abc4@def.com","222 444 55555","India","ALASLA","India","ALASKA"\r\n';
           
           
            
            String myString = csvLine1 +  csvLine2 + csvLine3 + csvLine4 + csvLine5 ;        

           // String myString = csvLine1 + '\r\n' + csvLine2 + '\r\n' + csvLine3 + '\r\n + csvLine4 + '\r\n' + csvLine5 + '\r\n' + csvLine6 + '\r\n' + csvLine7 ;

           // String myString = '"Email__c"",""First_Name__c""Last_Name__c"""""""StringToBlob"""""""""""""u"i0,""""';            
            impattcon.csvFileBody = Blob.valueof(myString);
            
            //variables
            List<String> allfieldssub = new List<String>();
            allfieldssub.add('Email__c');
            allfieldssub.add('First_Name__c');
            allfieldssub.add('Last_Name__c');
            allfieldssub.add('WorkCountry__c');
            allfieldssub.add('WorkState__c');
            allfieldssub.add('HomeCountry__c');
            allfieldssub.add('HomeState__c');
            List<String> allfieldssub2 = new List<String>();
            allfieldssub2.add('adsf@gmail.com');
            allfieldssub2.add('siva');
            allfieldssub2.add('s');
            allfieldssub2.add('~~IndiaAlliswell');
            allfieldssub2.add('');
            allfieldssub2.add('~~IndiaAlliswell');
            allfieldssub2.add('');
            List<String> allfieldssub3 = new List<String>();
            allfieldssub3.add('ssss@gmail.com');
            allfieldssub3.add('pavan');
            allfieldssub3.add('p');
            allfieldssub3.add('');
            allfieldssub3.add('~~Mizoram');
            allfieldssub3.add('India');
            allfieldssub3.add('Mizoram');
            List<String> allfieldssub4= new List<String>();
            allfieldssub4.add('ssss4@gmail.com');
            allfieldssub4.add('pavan');
            allfieldssub4.add('p');
            allfieldssub4.add('');
            allfieldssub4.add('~~Mizoram');
            allfieldssub4.add('');
            allfieldssub4.add('~~Mizoram');
            
            
            impattcon.allFields = new List<List<String>>();
            impattcon.allFields.add(allfieldssub);
            impattcon.allFields.add(allfieldssub2);
            impattcon.allFields.add(allfieldssub3);
            impattcon.allFields.add(allfieldssub4);
            //page parameters
            ApexPages.currentpage().getParameters().put('id',eventInfo.Id);
            Apexpages.currentPage().getParameters().put('countryid',countryInfo.id);
            ApexPages.currentpage().getParameters().put('id',eventInfo.id);
            //classes covered
            
            BLN_ImportAttendeesCon.ExceptionCountryState blnhdrn1 = new BLN_ImportAttendeesCon.ExceptionCountryState();
            blnhdrn1.InputCountry=countryInfo.id;
            blnhdrn1.InputState=stateInfo.id;
            blnhdrn1.OutputCountry=countryInfo.id;
            blnhdrn1.OutputState=stateInfo.id;
            blnhdrn1.outputstatenotneeded=true;
            //methods 
            
            
            impattcon.getstates();
            BLN_ImportAttendeesCon.statesBasedOnCountry(countryInfo.id);
            BLN_ImportAttendeesCon.getusacountryid(eventInfo.id);            
            BLN_ImportAttendeesCon.validatemd(item.id,eventInfo.id,listblnhdr,'SampleCSV',listblnhdr,listallfields);
            //BLN_ImportAttendeesCon.validatemd(item.id,eventInfo.id,,,,,);
            
             impattcon.importCSVFile();
           // impattcon.callFinalImport();
            BLN_ImportAttendeesCon.parseCSV(csvContent,false);            
            impattcon.Import();   
            impattcon.callFinalImport();
            impattcon.exportToCSV();
            
            
            impattcon.importCSVFile();
            impattcon.callFinalImport();
            BLN_ImportAttendeesCon.parseCSV(csvContent,false);            
            impattcon.Import();   
            //impattcon.callFinalImport();
            impattcon.exportToCSV();
            impattcon.workadd=true;
            impattcon.homeadd=true;
            impattcon.callFinalImport();
            
            
        }
    }
}