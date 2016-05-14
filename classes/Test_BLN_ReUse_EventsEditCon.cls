@isTest(SeeAllData=true)
public class Test_BLN_ReUse_EventsEditCon{
    public static string eventid{get;set;}
    public static Item_Pool__c ItemPool2{get;set;}
    public static Item_Pool__c ItemPool3{get;set;}
    public static BLN_Item__c item{get;set;}
    public static BLN_Item__c item1{get;set;}
    public static BLN_Item__c item2{get;set;}
    public static Company__c CompanyInfo{get;set;}
    public static testmethod void Testmethod_BLN_ReUse_EventsEditCon(){
        
      //  User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUserForGNUser();        
        
         Account acc= new Account(Name='Globalnest');
         insert acc;
    
        contact con = new contact(firstname='gn',lastname='user',AccountId=acc.id);
        insert con;
        Profile p = [select id from profile where name='Event Admin1'];
        //userRole r=[SELECT ID FROM userRole WHERE name =: 'Custom Role'];   userRoleId= r.id,
        User U= new User(alias = 'gn', email='gnusersw@noemail.com', firstname= 'fngn', Phone= '9878654345',ContactId= con.Id,
                                  emailencodingkey='UTF-8',profileid = p.Id,lastname='gnuser', languagelocalekey='en_US',
                                  localesidkey='en_US',country='United States Of America', CompanyName= 'GlobalNest',
                                  timezonesidkey='America/Los_Angeles', username='gnusersw@noemail.com', Title= 'SFDC Developer');
        database.insert(U,false);
        
      /*   Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         // ------------------ Eventadmin Insert ---------------------

         User u = new User(alias = 'Test', email='testcode@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode@noemail.com');
         database.insert(u,false);
        */
        
        system.runas(u){
        Currency__c currenyInfo= new Currency__c();
        currenyInfo= globalTest.createCurrency();             
          
        Country__c countryInfo= new Country__c();
        countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
        State__c stateInfo= new State__c ();
        stateInfo= globalTest.createState(countryInfo.Id);
            
        GN_User__c  gnUserInfo= new GN_User__c();
        gnUserInfo= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);          
       
        
        system.runas(U){
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id);             
            
             BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);        
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof =globalTest.createTktprofile(u);
            insertOrder1= globalTest.createOrder(tktprof.Id, u.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
    
            
            Hash_Tag__c HashTagInfo = new Hash_Tag__c ();     
            HashTagInfo = globalTest.createHashTag(eventInfo.id); 
           
            
            UC_Role__c ucRoleInfo1= new UC_Role__c();
            ucRoleInfo1= globalTest.createUCRole(companyInfo.Id, eventInfo.Id, gnUserInfo.id, u.Id, roleInfo.Id);  
            
            UC_Role__c ucRoleInfo2= new UC_Role__c();
            ucRoleInfo2= globalTest.createUCRole(companyInfo.Id, NULL, gnUserInfo.id, u.Id, roleInfo.Id);  
            
            
            Item_Type__c itemType1= new Item_Type__c();
            itemType1= globalTest.createItemType();
            
            
            Item_Type__c itemType2= new Item_Type__c();
            itemType2= globalTest.createItemType();
            
            Item_Type__c itemType3= new Item_Type__c();
            itemType3= globalTest.createItemType();
            
            Item_Type__c itemType4= new Item_Type__c();
            itemType4= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c  ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType2.Id, NULL, trackInfo.id);
            
            ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType3.Id, ItemPool.Id, trackInfo.id);
            
            ItemPool3= new Item_Pool__c();
            ItemPool3= globalTest.createItemPool(eventInfo.id, itemType3.Id, ItemPool.Id, trackInfo.id);
            
            item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool2.Id, itemType4.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType1.Id, insertOrder1.Id, tktprof.Id);
            ticket.note__c = 'abcd';
            update ticket;
            
            Event_Price__c eventPriceInfo= new Event_Price__c();
            eventPriceInfo= globalTest.createEventPrice(eventInfo.Id, itemType1.Id);
            
             Event_Price__c eventPriceInfo2= new Event_Price__c();
            eventPriceInfo2= globalTest.createEventPrice(eventInfo.Id, itemType2.Id);
           
            Event_Price__c eventPriceInfo3= new Event_Price__c();
            eventPriceInfo3= globalTest.createEventPrice(eventInfo.Id, itemType3.Id);
         
             PGateway_Type__c ptype=new PGateway_Type__c(Name='paypal');
             insert ptype;
         
                     
                Pay_Gateway__c pgway = new Pay_Gateway__c(PGateway_Type__c=ptype.id,Company__c=companyInfo.id);
                insert pgway;
            Event_Pay_Gateway__c  eventpaygatway =new Event_Pay_Gateway__c(Events__c = eventInfo.id,Pay_Gateway__c = pgway.id,Registration_Type__c = 'Onsite' );
            insert eventpaygatway ;
            Event_Price__c eventPriceInfo4= new Event_Price__c();
            eventPriceInfo4= globalTest.createEventPrice(eventInfo.Id, itemType4.Id);
           
            Currency__c currencyInfo= new Currency__c();
            
            currencyInfo= globalTest.createCurrency();
            
            Registration_Template__c RegistrationTemplateInfo= new Registration_Template__c();
            RegistrationTemplateInfo= globalTest.createRegistrationTemplate();
            
            PageReference pageRef = Page.BLN_EventNew;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.standardController(eventInfo);
            ApexPages.currentPage().getParaMeters().put('id', eventInfo.Id); 
            //ApexPages.currentPage().getParaMeters().put('code',RegistrationTemplateInfo.id );         
           
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});

           
           
            BLN_ReUse_EventsEditCon eventTest= new BLN_ReUse_EventsEditCon(sc);
           
            BLN_ReUse_EventsEditCon eventTestTemp2=new BLN_ReUse_EventsEditCon();
            
            eventTest.getUserTimeZones();
            eventTest.getEventTypes();
            eventTest.getEventStatus();
            eventTest.getLanguageSetting();
            eventTest.getPaymentType();
            eventTest.getCountry();
            eventTest.getAddOnItemTypes();
            eventTest.getPackageItemTypes();
            eventTest.getPickValues(item, 'Payment__c','Paid');
            
           
            
            BLN_ReUse_EventsEditCon.statesBasedOnCountry(countryInfo.Id);
            BLN_ReUse_EventsEditCon.currencyBasedOnCountry(countryInfo.Id);
            BLN_ReUse_EventsEditCon.createupdateuser('thiru','pathi','test@gmail.com');
            string eventInf= '{"EventName":"Traditional Day Celebrations","EventSDate":"11/19/2014 7:00 AM","EventEDate":"11/26/2014 4:00 PM","EventLocation":"Hyderabad","EventOrgEmail":"phani.chimata@gmail.com","CurrencySetting":"a11c0000007oSK1AAM","LanguageSetting":"en_US","HostingTimeZone":"America/New_York","EventCategory":"Appearance or Signing","OrgName":"","EventStatus":"Draft","WebUrl":"www.boothleads.com","AttendeeReg":"By Global Nest","PhoneNo":"8756432123","EventDesc":"For conducting cultural activities","HostingAddress1":"Madhapur","HostingAddress2":"Hitech City","EventCity":"Hyderabad","EventState":"a1Oc00000026YQQEA2","EventCountry":"a10c0000004TO6IAAW","ZipCode":"45676","EventHashTag":"","TwitterUrl":"","FacebookUrl":""}';
            string ticketInf= '{"tname":"Solo Performance","tpaytype":"Check","tqty":"50","tprice":"150","tvisib":"TRUE","tdesc":"For solo performance","tcketlogo":"","grouptickets":"","tbdglabel":"Attendee","trowid":"0001","ticketcount":"2","tags":"","subpackagegroup":"","ispackage":"TRUE","itemtype":""}';            
            eventTest.imageData= '/9j/4QAYRXhpZgAASUkqAAgAAAAAAAAAAAAAAP/sABFEdWNreQABAAQAAAA8AAD/4QP7aHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MSA2NC4xNDA5NDksIDIwMTAvMTIvMDctMTA6NTc6MDEgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0idXVpZDo1QjIwODkyNDkzQkZEQjExOTE0QTg1OTBEMzE1MDhDOCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDowNkUyQ0Q4NzJEREYxMUU0QTUxRUY3RUVBQUE3N0I1RiIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDowNkUyQ0Q4NjJEREYxMUU0QTUxRUY3RUVBQUE3N0I1RiIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1LjEgV2luZG93cyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOjlFRjgzMzcwRDgyREU0MTFBODQ2RTc4M0U2Q0JBMTUwIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjY3OUY1NDQ2MDgyMDY4MTE4OEM2OEFEQjExNjhE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';
            eventTest.saveEventLogo();
            
            Promotion__c promotion1= new Promotion__c();
            promotion1= globalTest.createPromotion(eventInfo.id, 'Basic Promo1', 'Basic Promo codes', 'Percent');
            
            Order__c orderinfo=new Order__c (Currency_Code__c = currenyInfo.id, Events__c = eventInfo.Id ,order_type__c = 'EVENT PRODUCER');
            insert orderinfo;
           
            Order_Item__c  orderiteminfo =new Order_Item__c ();
            orderiteminfo = globalTest.createOrderItem(item.id, orderinfo.id, promotion1.id, currenyInfo.id);
          
            
           // BLN_ReUse_EventsEditCon.savesEventInfo('{"EventName":"Traditional Day Celebrations","EventSDate":"11/19/2014 7:00 AM","EventEDate":"11/26/2014 4:00 PM","EventLocation":"Hyderabad","EventOrgEmail":"phani.chimata@gmail.com","CurrencySetting":"a11c0000007oSK1AAM","LanguageSetting":"en_US","HostingTimeZone":"America/New_York","EventCategory":"Appearance or Signing","OrgName":"","EventStatus":"Draft","WebUrl":"www.boothleads.com","AttendeeReg":"By Global Nest","PhoneNo":"8756432123","EventDesc":"For conducting cultural activities","HostingAddress1":"Madhapur","HostingAddress2":"Hitech City","EventCity":"Hyderabad","EventState":"a1Oc00000026YQQEA2","EventCountry":"a10c0000004TO6IAAW","ZipCode":"45676","EventHashTag":"","TwitterUrl":"","FacebookUrl":""}', 'thirupathi','globalnest',companyInfo.id,'jhon','smith',gnUserInfo.id,U.id);
            test.starttest();
            
            BLN_ReUse_EventsEditCon.eventOptionsWrapper evOptWrp=new BLN_ReUse_EventsEditCon.eventOptionsWrapper(true, eventPriceInfo);
            BLN_ReUse_EventsEditCon.eventOptionsWrapper evOptWrp2=new BLN_ReUse_EventsEditCon.eventOptionsWrapper(true, eventPriceInfo2);
            BLN_ReUse_EventsEditCon.eventOptionsWrapper evOptWrp3=new BLN_ReUse_EventsEditCon.eventOptionsWrapper(true, eventPriceInfo3);
            BLN_ReUse_EventsEditCon.eventOptionsWrapper evOptWrp4=new BLN_ReUse_EventsEditCon.eventOptionsWrapper(true, eventPriceInfo4);
            BLN_ReUse_EventsEditCon.Event eventobj = new BLN_ReUse_EventsEditCon.Event();
            BLN_ReUse_EventsEditCon.EventInfo evInfCls=new BLN_ReUse_EventsEditCon.EventInfo('Sampleevent','12/12/2014 11:00 PM','12/12/2014 12:00 PM','madhapur','test@gmail.com',eventinfo.id,'thiru','rupees','indian','hyd','india','nothing','smpletag', 'ap','progress','www.fb.com','www.linkedin.com','pahse2','phase3','indiaasia','english','globalnest','8123423352','www.twwr.com','www.indiabix.com','500082');
    
            BLN_ReUse_EventsEditCon.grouptickets grptckTemp=new BLN_ReUse_EventsEditCon.grouptickets(item.id,'thiru','12/12/2014 10:00 PM','12/12/2014 11:00 PM','4','2','4','200','3');
            
            BLN_ReUse_EventsEditCon.subpackagegroup spg=new BLN_ReUse_EventsEditCon.subpackagegroup('thirumal','hollywood','5','western','uniq','strange',null);
            
            BLN_ReUse_EventsEditCon.tags tName=new BLN_ReUse_EventsEditCon.tags('pattipaka');
            BLN_ReUse_EventsEditCon.ticket tktTemp=new BLN_ReUse_EventsEditCon.ticket(ItemPool2.id,'pk','cash','4','200','hiii','2','india','warranty','hello','howu',null,'5',null,null,'yes','Admission',null,'taxx');
            BLN_ReUse_EventsEditCon.PaymentOpt pOpt=new BLN_ReUse_EventsEditCon.PaymentOpt('PayPal','pattipaka','indian','hyderabad','globalnest');
            BLN_ReUse_EventsEditCon.ItemType itemT=new BLN_ReUse_EventsEditCon.ItemType();
            BLN_ReUse_EventsEditCon.itemdates itemD=new BLN_ReUse_EventsEditCon.itemdates ();
            BLN_ReUse_EventsEditCon.Item itemTempObj=new BLN_ReUse_EventsEditCon.Item();
            BLN_ReUse_EventsEditCon.JSONWrapper wrapObj=new BLN_ReUse_EventsEditCon.JSONWrapper ();
            LIST<Item_Type__c> itemTypeExist= new LIST<Item_Type__c>();
            itemTypeExist = [SELECT ID, Item_Type_Number__c FROM Item_Type__c Limit 1];
            System.debug('=========PPPPP==='+itemTypeExist);
            System.debug('=========TTTTTT==='+itemTypeExist[0]);
            //string.valueof(itemTypeExist[0].Item_Type_Number__c)
            BLN_ReUse_EventsEditCon.getTickets('IT-000003', eventPriceInfo.Id, eventInfo.Id);
            //string b = '{"name":"BL-Template-4","width":360,"height":288,"backgroundColor":"rgb(255, 255, 255)","savedImageDataUrl":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAFA3PEY8MlBGQUZaVVBfeMiCeG5uePWvuZHI////////////////////////////////////////////////////2wBDAVVaWnhpeOuCguv/////////////////////////////////////////////////////////////////////////wAARCAEqAXIDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCzlUjBI7Cm+dH6H8qJf9QPwqvTSEWPOj9D+VHnR+h/Kq9OwBTsFybzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKOKLBcn86P0P5UedH6H8qg4o4osFyfzo/Q/lR50fofyqDijiiwXJ/Oj9D+VHnR+h/KoOKCKLAT+dH6H8qUSoTjH6VWpyffH1osFy3gegowPQUtFSMTA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUYHoKWigBMD0FGB6ClooATA9BRgegpaKAEwPQUY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"}';
            BLN_ReUse_EventsEditCon.TicketCreateInfo tcCreatinfo = new BLN_ReUse_EventsEditCon.TicketCreateInfo();
            
            BLN_ReUse_EventsEditCon.getnewEvents(eventInfo.id);
            BLN_ReUse_EventsEditCon.getAllBLProduct(eventInfo.Id);
            BLN_ReUse_EventsEditCon.getEventproducerpaiditems(eventInfo.Id);
            BLN_ReUse_EventsEditCon.getEvents(eventInfo.Id);
            BLN_ReUse_EventsEditCon.getSavedTickets(eventInfo.Id);
            BLN_ReUse_EventsEditCon.getItemsBasedOnPool(itemPool.Id);
            BLN_ReUse_EventsEditCon.getnewItemsBasedOnPool(itemPool2.Id,eventInfo.Id);
            BLN_ReUse_EventsEditCon.getAddonPool(itemPool.Id);
            BLN_ReUse_EventsEditCon.getSavedTags(eventInfo.Id);
            BLN_ReUse_EventsEditCon.getAddonPool(itemPool2.id);
            BLN_ReUse_EventsEditCon.getCompanyExtDetails(eventInfo.Id);
            BLN_ReUse_EventsEditCon.createCompanyExtDetails(eventInfo.id, companyExtInfo.id,'city','state','','','','');
            BLN_ReUse_EventsEditCon.createEventTag(eventInfo.Id, 'Attendee','Exhibitor');
            BLN_ReUse_EventsEditCon.getEventTag(eventInfo.Id,'Exhibitor');
            BLN_ReUse_EventsEditCon.updateEventTag(eventInfo.Id, 'Attendee', 'Exhibitor');
            BLN_ReUse_EventsEditCon.updateEventTagwithId(eventInfo.Id, HashTagInfo.id, 'Exhibitor');
            BLN_ReUse_EventsEditCon.deleteEventTag(eventInfo.Id, 'Exhibitor');
            BLN_ReUse_EventsEditCon.deleteTicketLevelTag(eventInfo.Id, 'Exhibitor',Ticket.id);
            BLN_ReUse_EventsEditCon.getAllSelectedTag(eventInfo.Id,Ticket.id);
            BLN_ReUse_EventsEditCon.getbadgeinfo(itemType1.id,2);
            DateTime dt = DateTime.newInstance(2007, 6, 23, 3, 3, 3);
            Long gettime = dt.getTime();
            BLN_ReUse_EventsEditCon.getTimeZoneValue(gettime);
            DateTime dtTemp = DateTime.newInstance(2007, 6, 24, 3, 3, 3);
            Long gettime2 = dtTemp.getTime();
            
            BLN_ReUse_EventsEditCon.getTimeZoneValueforitem(eventInfo.id,gettime,gettime2,4,5);
            eventTest.searchValue= 'Comp';
            eventTest.search();
            eventTest.selectValue();
            eventTest.hideResults();
            eventTest.refreshAF();
            eventTest.Refresh();
            eventTest.updateComponent();
            
            ApexPages.currentPage().getParaMeters().put('code', '12345');
            try{
            eventTest.getStripeAccessToken() ;
            }catch(Exception e){}
            eventTest.getVisibility();
            BLN_ReUse_EventsEditCon.savesRegTempl(RegistrationTemplateInfo.id,eventInfo.id);
            BLN_ReUse_EventsEditCon.savesEventsTaxRateRefundPolicy(eventInfo.id,'true','yes','true','yes','true','2');
            
            BLN_ReUse_EventsEditCon.savesTicketInfo('',eventInfo.id,'12/12/2016 11:00 PM','12/12/2016 12:00 PM','200');
          
            BLN_ReUse_EventsEditCon.savesFinalEvent('Live',eventInfo.id,'2.00','634786324','09','2016','234', '',currencyInfo.Id,'card','Credit Card','credit');

            BLN_ReUse_EventsEditCon.deleteItemPool(itemPool2.Id);
            BLN_ReUse_EventsEditCon.deleteaddonItemPool(itemPool.Id);
            BLN_ReUse_EventsEditCon.deletePaymentGateways(string.valueof(pgway.id));
            try{
            BLN_ReUse_EventsEditCon.new_savesPaymentGateways('',eventInfo.id,'paypal',pgway.id,'stripe');
            BLN_ReUse_EventsEditCon.new_savesPaymentOption('',eventInfo.id,'123452','5000','external','849302480','4521551652','tckoption','feeopt','module','requestcomingfrom','acceptrangeforgt','mingt','50000','100');
             }catch(exception e){}
            Test_BLN_ReUse_EventsEditCon.eventId=eventInfo.id;
            
            PageReference pageRef11 = Page.BLN_EventNew;
            Test.setCurrentPage(pageRef11);
            ApexPages.StandardController sc11 = new ApexPages.standardController(eventInfo);
            ApexPages.currentPage().getParaMeters().put('id', null);
            BLN_ReUse_EventsEditCon eventTestTemp22=new BLN_ReUse_EventsEditCon(sc11);
          
          try{ 
           BLN_ReUse_EventsEditCon.new_savesPaymentOption('{"pgopt":"PayPal","firstparam":"firstparam","secondparam":"secondparam","thirdparam":"Direct","fourthparam":""}',eventInfo.id,'true','5000','external','849302480','4521551652','tckoption','feeopt','module','requestcomingfrom','acceptrangeforgt','mingt','50000','100');
          }catch(Exception e){}
          test.stoptest(); 
          
          
          PageReference myVfPage = Page.BLN_PaymentNewSettings;
                    system.Test.setCurrentPage(myVfPage);
           ApexPages.StandardController sc_e = new ApexPages.standardController(eventInfo);
          BLN_ReUse_EventsEditCon eventTest_e= new BLN_ReUse_EventsEditCon(sc_e);
          BLN_ReUse_EventsEditCon eventTest_ee= new BLN_ReUse_EventsEditCon();
          
          
          ApexPages.currentPage().getParaMeters().put('counter', eventInfo.id);
          BLN_ReUse_EventsEditCon.paymentsetornot(eventInfo.id);
          eventTest_e.searchValue = u.Companyname;
          eventTest_e.search();
          UC_Role__c ucRoleInfo3= new UC_Role__c();
          ucRoleInfo3= ucRoleInfo2.clone(false, true);
          insert ucRoleInfo3;
          eventTest_e.search();
          item1= new BLN_Item__c();
          item1= globalTest.createItem(ItemPool3.Id, itemType3.Id, eventInfo.id);
          item2= new BLN_Item__c();
          item2= globalTest.createItem(ItemPool3.Id, itemType3.Id, eventInfo.id);
          
          string itmid = item2.id+',';
          string itmpoolid=ItemPool3.id;
          string ditmid = item1.id+',';
          string ditmpoolid = ItemPool3.id;
          string ordnum='22';
           string dordnum='23';
          
          BLN_ReUse_EventsEditCon.updateorderingitems(itmid ,itmpoolid,ordnum,ditmid,ditmpoolid,dordnum);
          BLN_ReUse_EventsEditCon.PaymentOpt poq=new BLN_ReUse_EventsEditCon.PaymentOpt('PayPal','firstparam','secondparam','Adaptive');
         try{ 
           BLN_ReUse_EventsEditCon.new_savesPaymentOption('{"pgopt":"PayPal","firstparam":"firstparam","secondparam":"secondparam","thirdparam":"Adaptive","fourthparam":""}',eventInfo.id,'123452','5000','external','849302480','4521551652','tckoption','feeopt','module','requestcomingfrom','acceptrangeforgt','mingt','50000','100');
          }catch(Exception e){}
          
           // eventTest_e.updateComponent();
           // eventTest_e.Refresh();
          
            
            
            
            
           try{ 
         //   eventTest_e.refreshAF();
            }catch(Exception e){}
            
            
          
            BLN_ReUse_EventsEditCon.getcreditcarddetails(eventInfo.id);
            try{ 
           // BLN_ReUse_EventsEditCon.savesEventInfo('{"EventName":"Traditional Day Celebrations","EventSDate":"11/19/2014 7:00 AM","EventEDate":"11/26/2014 4:00 PM","EventLocation":"Hyderabad","EventOrgEmail":"phani.chimata@gmail.com","CurrencySetting":"a11c0000007oSK1AAM","LanguageSetting":"en_US","HostingTimeZone":"America/New_York","EventCategory":"Appearance or Signing","OrgName":"","EventStatus":"Draft","WebUrl":"www.boothleads.com","AttendeeReg":"By Global Nest","PhoneNo":"8756432123","EventDesc":"For conducting cultural activities","HostingAddress1":"Madhapur","HostingAddress2":"Hitech City","EventCity":"Hyderabad","EventState":"a1Oc00000026YQQEA2","EventCountry":"a10c0000004TO6IAAW","ZipCode":"45676","EventHashTag":"","TwitterUrl":"","FacebookUrl":""}', 'thirupathi','globalnest',companyInfo.id,'jhon','smith',gnUserInfo.id,U.id,countryInfo.Id);
            }catch(Exception eee){}
            
            
            //BLN_ReUse_EventsEditCon.PaymentOpt po=new BLN_ReUse_EventsEditCon.PaymentOpt('PayPal','firstparam','secondparam','Adaptive','fourthparam');
            eventTestTemp2.refreshItem(); 
            BLN_ReUse_EventsEditCon.getcurrdate('America/New_York');
            eventTest_e.itemtypes = null;
            eventTest_e.newEvent =null;
            eventTest_e.currentdate = null;
            eventTest_e.body = null;
            eventTest_e.batchticketprocess = null;
            eventTest_e.selectValue = null;
            BLN_ReUse_EventsEditCon.JSONWrapper jse=new BLN_ReUse_EventsEditCon.JSONWrapper();
        }
       }
   }
    
}