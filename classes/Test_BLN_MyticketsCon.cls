@isTest(SeeAllData = true)
public class Test_BLN_MyticketsCon {

    static testMethod void myUnitTest() {
        //Test_BLN_ReUse_EventsEditCon tcon = new Test_BLN_ReUse_EventsEditCon();
        //Test_BLN_ReUse_EventsEditCon.Testmethod_BLN_ReUse_EventsEditCon();
        system.debug('AAAAAAAAAAAAAAAAAAAAa ' + Test_BLN_ReUse_EventsEditCon.eventid);
        //string eventid =  Test_BLN_ReUse_EventsEditCon.eventid;
        User U = new User();
        globalForTestClass globalTest = new globalForTestClass();
        U = globalTest.createUser();
        system.runas(U) {

            user userForGN = new user();
            userForGN = globalTest.createUserForGNUser();


            Company__c companyInfo = new Company__c();
            companyInfo = globalTest.createCompany(userForGN.Companyname);

            Tkt_profile__c tktProf = new Tkt_profile__c();
            tktProf = globalTest.createTktprofile(userForGN);

            Currency__c currenyInfo = new Currency__c();
            currenyInfo = globalTest.createCurrency();

            Country__c countryInfo = new Country__c();
            countryInfo = globalTest.createCountry(currenyInfo.Id);

            State__c stateInfo = new State__c();
            stateInfo = globalTest.createState(countryInfo.Id);

            // GN_User__c  gnUser= new GN_User__c();
            // gnUser= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);

            BLN_Event__c eventInfo = new BLN_Event__c();
            eventInfo = globalTest.createEvent(countryInfo.Id, Stateinfo.Id, CompanyInfo.id);

            cookie counter = new Cookie('counter', eventInfo.id, null, -1, false);
            ApexPages.currentPage().setCookies(new Cookie[] {
                counter
            });

            NAICS_Code__c naicsCodeInfo1 = new NAICS_Code__c();
            naicsCodeInfo1 = globalTest.createNaicsCode();

            NAICS_Code__c naicsCodeInfo2 = new NAICS_Code__c();
            naicsCodeInfo2 = globalTest.createNaicsCode();

            Order__c OrdrInfo = new Order__c();
            OrdrInfo = globalTest.createOrder(tktProf.Id, userForGN.Id, companyInfo.Id, EventInfo.Id, currenyInfo.Id);

            Apexpages.currentPage().getParameters().put('edform', OrdrInfo.ID);

            BLN_MyticketsCon MyTktsCon = new BLN_MyticketsCon();

            //BLN_AttendeesController bAttendeCon= new BLN_AttendeesController();
            //BLN_MyticketsCon  bMyCon1= new BLN_MyticketsCon(bAttendeCon);

            LIST < BLN_RegistrationnewCon.ItemInnerClass > itmInnList = new LIST < BLN_RegistrationnewCon.ItemInnerClass > ();
            BLN_RegistrationnewCon.RegItemInnerClass regItemInner = new BLN_RegistrationnewCon.RegItemInnerClass('NewLabel', 2.0, itmInnList);

            BLN_MyticketsCon MyTktsCon2 = new BLN_MyticketsCon('test');
            try {
                MyTktsCon.displayPermissions();
            } catch (Exception ee1111) {}
            try {
                MyTktsCon.displayPermissions1();
                MyTktsCon.displayorderEditform();
                MyTktsCon.renderDetailsfororder();
            } catch (Exception ee) {}
            MyTktsCon.setRecordsForExport('test');
            MyTktsCon.onchangeEvent();

            MyTktsCon.exorders();
            apexpages.currentpage().getparameters().put('guestindex', '0');
            try {
                MyTktsCon.renderDetails();
            } catch (Exception e1) {}

            MyTktsCon.CloseGuests();
            //MyTktsCon.cancelledStr(List<BLN_Mytickets_BAL.inncls> inc);
            try {
                MyTktsCon.EdTicket();
            } catch (Exception ey) {}



            try {
                MyTktsCon.Saveord();
            } catch (Exception e2) {}


            //MyTktsCon.setSelectedAnswerCheck(String[] SelectedAnswerCheck);
          //  MyTktsCon.countryStates();
         //   MyTktsCon.statesBasedOnCountry();
            try {
              //  MyTktsCon.statesBasedOnCountry1();
            } catch (Exception ex) {}
            MyTktsCon.closeCan();
            try {
                MyTktsCon.speakerDataInfo();

                MyTktsCon.delattachment();
                MyTktsCon.updateSpeakerOrder();
               // MyTktsCon.processData();
                MyTktsCon.prepareorder(OrdrInfo.Id);
                MyTktsCon.exporsed();
            } catch (Exception ex1) {}

            Test.StartTest();
            MyTktsCon.exportOrders();
            apexpages.currentpage().getparameters().put('arr', 'test');
            MyTktsCon.userSelectPerticularToExport();
            Test.stopTest();
            // Apexpages.currentPage().getPArameters().put('guestindex12',OrdrInfo.Id);
            // MyTktsCon.cancelTotalorder();


        }
    }

    static testMethod void myUnitTest1() {

        User U = new User();
        globalForTestClass globalTest = new globalForTestClass();
        U = globalTest.createUser();
        system.runas(U) {

            user userForGN = new user();
            userForGN = globalTest.createUserForGNUser();


            Company__c companyInfo = new Company__c();
            companyInfo = globalTest.createCompany(u.Companyname);

            Tkt_profile__c tktProf = new Tkt_profile__c();
            tktProf = globalTest.createTktprofile(u);

            Currency__c currenyInfo = new Currency__c();
            currenyInfo = globalTest.createCurrency();

            Country__c countryInfo = new Country__c();
            countryInfo = globalTest.createCountry(currenyInfo.Id);

            State__c stateInfo = new State__c();
            stateInfo = globalTest.createState(countryInfo.Id);

            BLN_Event__c eventInfo = new BLN_Event__c();
            eventInfo = globalTest.createEvent(countryInfo.Id, Stateinfo.Id, CompanyInfo.id);

            BLN_Room__c roomInfo = new BLN_Room__c();
            roomInfo = globalTest.createRoom(eventInfo.Id);

            BLN_Track__c trackInfo = new BLN_Track__c();
            trackInfo = globalTest.createTrack(eventInfo.Id);

            Item_Type__c itemType = new Item_Type__c();
            itemType = globalTest.createItemType();

            Item_Pool__c ItemPool = new Item_Pool__c();
            ItemPool = globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);

            Item_Pool__c ItemPool2 = new Item_Pool__c();
            ItemPool2 = globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);

            BLN_Item__c item = new BLN_Item__c();
            item = globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);

            cookie counter = new Cookie('counter', eventInfo.id, null, -1, false);
            ApexPages.currentPage().setCookies(new Cookie[] {
                counter
            });

            NAICS_Code__c naicsCodeInfo1 = new NAICS_Code__c();
            naicsCodeInfo1 = globalTest.createNaicsCode();

            NAICS_Code__c naicsCodeInfo2 = new NAICS_Code__c();
            naicsCodeInfo2 = globalTest.createNaicsCode();

            Order__c OrdrInfo = new Order__c();
            OrdrInfo = globalTest.createOrder(tktProf.Id, u.Id, companyInfo.Id, EventInfo.Id, currenyInfo.Id);

            Order_Item__c orderItem = new Order_Item__c();
            orderItem = globalTest.createOrderItem(item.Id, OrdrInfo.Id, null, currenyInfo.Id);

            list < Order_Item__c > listorderItem = new list < Order_Item__c > ();
            listorderItem.add(orderItem);

            Ticket__c ticket = new Ticket__c();
            ticket = globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, OrdrInfo.Id, tktprof.Id);
            ticket.Tkt_profile__c = tktprof.Id;
            update ticket;

            Question__c que = new Question__c();
            que = globalTest.createQuestion(eventInfo.id);

            Item_Question__c itemQue = new Item_Question__c();
            itemQue = globalTest.createItemQuestion(eventInfo.id, item.Id, que.Id);

            BLN_Answer__c ans = new BLN_Answer__c();
            ans = globalTest.createAnswer(que.Id);

            User_Answer__c usrAns = new User_Answer__c();
            usrAns = globalTest.createUserAnswer(tktprof.id, itemQue.Id, ans.Id);

            Apexpages.currentPage().getParameters().put('edform', OrdrInfo.ID);


            LIST < BLN_RegistrationnewCon.ItemInnerClass > itmInnList = new LIST < BLN_RegistrationnewCon.ItemInnerClass > ();
            BLN_RegistrationnewCon.RegItemInnerClass regItemInner = new BLN_RegistrationnewCon.RegItemInnerClass('NewLabel', 2.0, itmInnList);

            Test.StartTest();
            BLN_MyticketsCon MyTktsCon2 = new BLN_MyticketsCon();

            Apexpages.currentPage().getParameters().put('TicketIdparam', ticket.id);
            try {
                MyTktsCon2.editTicket();
            } catch (exception e5) {}
            MyTktsCon2.viewTicket();
            MyTktsCon2.cancelOrdDetail();
            try {
                BLN_MyticketsCon.SubWrapper sw = new BLN_MyticketsCon.SubWrapper(OrdrInfo, OrdrInfo.Id);
            } catch (exception e7) {}
            //sw.createdon='test';
            LIST < BLN_MyticketsCon.SubWrapper > swList = new LIST < BLN_MyticketsCon.SubWrapper > ();

            BLN_MyticketsCon.DataTableWrapper dtw = new BLN_MyticketsCon.DataTableWrapper(1, 1, 1, swList);
            dtw.selected=true;
            apexpages.currentpage().getparameters().put('MyName', OrdrInfo.Id + '"[],');
            MyTktsCon2.exporsed();

            ApexPages.currentPage().getParameters().put('search[value]', 'test');
            ApexPages.currentPage().getParameters().put('columns[9][search][value]', '|^()$\\;');
            ApexPages.currentPage().getParameters().put('order[0][column]', '1');
            ApexPages.currentPage().getParameters().put('order[0][dir]', 'asc');
            try {
                MyTktsCon2.processData();
            } catch (exception e8) {}


            BLN_MyticketsCon.saveChkInfo('Order', OrdrInfo.Id, 'testval');
            BLN_MyticketsCon.saveChkInfo('test', OrdrInfo.Id, 'testval');

            Apexpages.currentPage().getParameters().put('eveid', eventInfo.id);
            MyTktsCon2.printorderinvoice();

            Apexpages.currentPage().getPArameters().put('guestindex12', OrdrInfo.Id);
            MyTktsCon2.cancelTotalorder();
            try {
                MyTktsCon2.upsertSurveyAnswers();
            } catch (exception e6) {}
            String[] arrstrng = new list < String > (); //{'test1','test2','test3'};
            BLN_MyticketsCon.UserAnswerInnerClass uainn = new BLN_MyticketsCon.UserAnswerInnerClass(new LIST < BLN_Answer__c > (), new LIST < SelectOption > (), true, itemQue, 'test1', arrstrng, usrAns, new set < id > ());

            //MyTktsCon2.cancelDirectTicket();
            MyTktsCon2.splitcancelDirectTicket(orderItem.Id);
            try {
                MyTktsCon2.cancelPerticularGuestsTic();
            } catch (exception e4) {}
            try {
                MyTktsCon2.splitcancelPerticularGuestsTic(ticket.Id);
            } catch (exception e4) {}

           // BLN_AttendeesController bAttendeCon = new BLN_AttendeesController();
            
             //   BLN_MyticketsCon bMyCon1 = new BLN_MyticketsCon(bAttendeCon);
           

            Apexpages.Currentpage().getparameters().put('speakerOrder', 'dfds,vfdg dfsd,fhf');
            try {
                MyTktsCon2.updateSpeakerOrder();
            } catch (exception eee) {}
            MyTktsCon2.disableoroderbool();

            //constructors.......Object declaration.......
            BLN_MyticketsCon blnmyobj = new BLN_MyticketsCon();

            //Variable initialization.......

            //Method calling.............................
            //Normal method calling.............................
            Test.stopTest();
            ApexPages.currentPage().getParameters().put('canordItemId', orderItem.id);
            MyTktsCon2.cancelDirectTicket();

            MyTktsCon2.addGuest = new Ticket__c();
            MyTktsCon2.addGuest = ticket;
            MyTktsCon2.imageData = 'test test test test test';
            MyTktsCon2.AttData = 'test test test test test';
            try {
                MyTktsCon2.Saveord();
            } catch (Exception e2) {}
            MyTktsCon2.beforeEditEmail = 'myemail@gmail.com';
            BLN_Address__c sampblnaddress = new BLN_Address__c();
            sampblnaddress.Address1__c = 'hyd';
            insert sampblnaddress;
            MyTktsCon2.hAddress = sampblnaddress;
            MyTktsCon2.wAddress = sampblnaddress;
            MyTktsCon2.bAddress = sampblnaddress;
            MyTktsCon2.sAddress = sampblnaddress;
            //MyTktsCon2.naicsCodesString='test';
            // MyTktsCon2.diverCodesString='test';
            // MyTktsCon2.commditiesStr='test';
            MyTktsCon2.tagsStr = 'test test test test test';
            MyTktsCon2.tagsList = new List < Hash_Tag__c > ();
            //MyTktsCon2.tagsList.add(tagsStr);
            MyTktsCon2.selectedEvent = eventInfo.id;
            MyTktsCon2.urlCheck = '';
            MyTktsCon2.Saveord();
            MyTktsCon2.selectedOrder = null;
            MyTktsCon2.Saveord();
           
           List<account> accountList = [SELECT Name FROM Account LIMIT 20];
            ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(accountList);
           MyTktsCon2.setCon = ssc;
           MyTktsCon2.dataTableJson = 'test';
           /*
            PageReference pageRef = Page.BLN_Mytickets;
            Test.setCurrentPage(pageRef);
            BLN_AttendeesController bAttendeCon = new BLN_AttendeesController();
            BLN_MyticketsCon bMyCon1 = new BLN_MyticketsCon(bAttendeCon);
            */
            //Static method calling.............................

         //variable initialization
         


        }
    }
    static testMethod void myUnitTest2() {
        User U = new User();
        globalForTestClass globalTest = new globalForTestClass();
        U = globalTest.createUser();
        system.runas(U) {

            user userForGN = new user();
            userForGN = globalTest.createUserForGNUser();


            Company__c companyInfo = new Company__c();
            companyInfo = globalTest.createCompany(u.Companyname);

            Tkt_profile__c tktProf = new Tkt_profile__c();
            tktProf = globalTest.createTktprofile(u);

            Currency__c currenyInfo = new Currency__c();
            currenyInfo = globalTest.createCurrency();

            Country__c countryInfo = new Country__c();
            countryInfo = globalTest.createCountry(currenyInfo.Id);

            State__c stateInfo = new State__c();
            stateInfo = globalTest.createState(countryInfo.Id);

            BLN_Event__c eventInfo = new BLN_Event__c();
            eventInfo = globalTest.createEvent(countryInfo.Id, Stateinfo.Id, CompanyInfo.id);

            BLN_Room__c roomInfo = new BLN_Room__c();
            roomInfo = globalTest.createRoom(eventInfo.Id);

            BLN_Track__c trackInfo = new BLN_Track__c();
            trackInfo = globalTest.createTrack(eventInfo.Id);

            Item_Type__c itemType = new Item_Type__c();
            itemType = globalTest.createItemType();

            Item_Pool__c ItemPool = new Item_Pool__c();
            ItemPool = globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);

            Item_Pool__c ItemPool2 = new Item_Pool__c();
            ItemPool2 = globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);

            BLN_Item__c item = new BLN_Item__c();
            item = globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);

            cookie counter = new Cookie('counter', eventInfo.id, null, -1, false);
            ApexPages.currentPage().setCookies(new Cookie[] {
                counter
            });

            NAICS_Code__c naicsCodeInfo1 = new NAICS_Code__c();
            naicsCodeInfo1 = globalTest.createNaicsCode();

            NAICS_Code__c naicsCodeInfo2 = new NAICS_Code__c();
            naicsCodeInfo2 = globalTest.createNaicsCode();

            Order__c OrdrInfo = new Order__c();
            OrdrInfo = globalTest.createOrder(tktProf.Id, u.Id, companyInfo.Id, EventInfo.Id, currenyInfo.Id);

            Order_Item__c orderItem = new Order_Item__c();
            orderItem = globalTest.createOrderItem(item.Id, OrdrInfo.Id, null, currenyInfo.Id);

            list < Order_Item__c > listorderItem = new list < Order_Item__c > ();
            listorderItem.add(orderItem);

            Ticket__c ticket = new Ticket__c();
            ticket = globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, OrdrInfo.Id, tktprof.Id);
            ticket.Tkt_profile__c = tktprof.Id;
            update ticket;

            Question__c que = new Question__c();
            que = globalTest.createQuestion(eventInfo.id);

            Item_Question__c itemQue = new Item_Question__c();
            itemQue = globalTest.createItemQuestion(eventInfo.id, item.Id, que.Id);

            BLN_Answer__c ans = new BLN_Answer__c();
            ans = globalTest.createAnswer(que.Id);

            User_Answer__c usrAns = new User_Answer__c();
            usrAns = globalTest.createUserAnswer(tktprof.id, itemQue.Id, ans.Id);

            Apexpages.currentPage().getParameters().put('edform', OrdrInfo.ID);


            LIST < BLN_RegistrationnewCon.ItemInnerClass > itmInnList = new LIST < BLN_RegistrationnewCon.ItemInnerClass > ();
            BLN_RegistrationnewCon.RegItemInnerClass regItemInner = new BLN_RegistrationnewCon.RegItemInnerClass('NewLabel', 2.0, itmInnList);
            Test.StartTest();
            BLN_MyticketsCon MyTktsCon3 = new BLN_MyticketsCon();
           // MyTktsCon3.statistics();
             ApexPages.currentPage().getParameters().put('showinvoiceordid','test');
            ApexPages.currentPage().getParameters().put('sendinvordid','test');
            ApexPages.currentPage().getParameters().put('sendinvemail','test');
            
            MyTktsCon3.showInvoice();
            MyTktsCon3.sendInvoice();
            BLN_MyticketsCon.getGnuser('hegotthelogic@gfcforce.com');
            BLN_MyticketsCon.checkUser('hegotthelogic@gfcforce.com');
            
            /*
            Datetime dt = DateTime.newInstance(2012,12,28,10,0,0);
            string ldatetime = dt.formatLong();
            Long ldtme = Long.valueOf(ldatetime);
            BLN_MyticketsCon.getTimeZoneValue(ldtme);
            */
            BLN_MyticketsCon.getCompanies('gn','hegotthelogic@gfcforce.com');
            BLN_MyticketsCon.getCompanies1('gn','hegotthelogic@gfcforce.com');
            BLN_MyticketsCon.getCompaniesext('gn');
            
            
            ApexPages.currentPage().getParameters().put('search[value]', 'test test');
            ApexPages.currentPage().getParameters().put('columns[9][search][value]', '|^())$$\\|^())$$\\;|^())$\\');
            ApexPages.currentPage().getParameters().put('columns[8][search][value]', '|^())$$\\|^())$$\\;|^())$\\');
            
            ApexPages.currentPage().getParameters().put('order[0][column]', '1');
            ApexPages.currentPage().getParameters().put('order[0][dir]', 'asc');
            ApexPages.currentPage().getParameters().put('start','10');
            ApexPages.currentPage().getParameters().put('length','10');
            
           // MyTktsCon3.processData();
            PageReference pageRef = Page.BLN_Mytickets;
            Test.setCurrentPage(pageRef);
            BLN_AttendeesController bAttendeCon = new BLN_AttendeesController();
            BLN_MyticketsCon bMyCon1 = new BLN_MyticketsCon(bAttendeCon);
            PageReference pageRef1 = Page.BLN_Speakers;
            Test.setCurrentPage(pageRef1);
            BLN_AttendeesController bAttendeCon1 = new BLN_AttendeesController();
            BLN_MyticketsCon bMyCon2 = new BLN_MyticketsCon(bAttendeCon1);
            PageReference pageRef2 = Page.BLN_Attendees;
            Test.setCurrentPage(pageRef2);
            
            BLN_AttendeesController bAttendeCon2 = new BLN_AttendeesController();
            BLN_MyticketsCon bMyCon3 = new BLN_MyticketsCon(bAttendeCon2);
            
             try {
                 PageReference pageRefp1 = Page.BLN_Attendees;
                Test.setCurrentPage(pageRefp1);
                MyTktsCon3.displayPermissions();
            } catch (Exception ee1111) {}
            
            MyTktsCon3.datename = 'test';
            MyTktsCon3.companyName = 'test';
            MyTktsCon3.currentEventTickets =new List<Ticket__c>();
            MyTktsCon3.ordIt = new List<Order_Item__c>();
            MyTktsCon3.exportOrders =new List<BLN_Mytickets_BAL.inncls>();
            MyTktsCon3.editOrdRec = new BLN_Mytickets_BAL.inncls();
            MyTktsCon3.states = new LIST<State__c>();
            MyTktsCon3.selectedState = 'test';
            MyTktsCon3.exorder =new List<BLN_Mytickets_BAL.inncls>();
            MyTktsCon3.getRecordsForExport();
            
            
            MyTktsCon3.gnUser = new GN_User__c();           
            MyTktsCon3.ucrole = new UC_Role__c();
            MyTktsCon3.compid = 'test';
            MyTktsCon3.beforecompany = 'test';
            MyTktsCon3.diversities = 'test';            
            MyTktsCon3.videoyoutube =new List<String>();
            MyTktsCon3.att = new Attachment();
            
            
          
            Test.StopTest();
            
            
        }
    }

}