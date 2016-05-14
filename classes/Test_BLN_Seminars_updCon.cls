@istest(SeeAllData = true)

public class Test_BLN_Seminars_updCon {
    public static BLN_Event__c eventInfo {
        get;
        set;
    }
    public static testmethod void Testmethod_BLN_Seminars_updCon() {

        //User U= new User();
        globalForTestClass globalTest = new globalForTestClass();
        //U= globalTest.createUser();
        Profile p = [select id from profile where name = 'System Administrator'];
        userRole r = [SELECT ID FROM userRole WHERE name = : 'CEO'];


        User u = new User(alias = 'Test', email = 'testcode123vb@noemail.com',
            emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'codeTesting', Firstname = 'codeTesting', languagelocalekey = 'en_US',
            localesidkey = 'en_US', country = 'United States Of America', userRoleId = r.id, CompanyName = 'GlobalNest',
            timezonesidkey = 'America/Los_Angeles', username = 'testcode123vbc@noemail.com');
        insert u;

        system.runas(U) {

            NAICS_Code__c naicsCodeInfo1 = new NAICS_Code__c();
            naicsCodeInfo1 = globalTest.createNaicsCode();

            NAICS_Code__c naicsCodeInfo2 = new NAICS_Code__c();
            naicsCodeInfo2 = globalTest.createNaicsCode();

            Currency__c currenyInfo = new Currency__c();
            currenyInfo = globalTest.createCurrency();

            Country__c countryInfo = new Country__c();
            countryInfo = globalTest.createCountry(currenyInfo.Id);

            State__c stateInfo = new State__c();
            stateInfo = globalTest.createState(countryInfo.Id);

            Company__c companyInfo = new Company__c();
            companyInfo = globalTest.createCompany(u.Companyname);

            Company_Ext__c companyExtInfo = new Company_Ext__c();
            companyExtInfo = globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id);

            eventInfo = new BLN_Event__c();
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

            Agenda__c agendaInfo = new Agenda__c();
            agendaInfo = globalTest.createAgenda(eventInfo.Id, trackInfo.Id);

            Agenda__c agendaInfo2 = new Agenda__c();
            agendaInfo2 = globalTest.createAgenda(eventInfo.Id, trackInfo.Id);

            Agenda__c agendaInfo3 = new Agenda__c();
            agendaInfo3 = globalTest.createAgenda(eventInfo.Id, trackInfo.Id);

            LIST < Agenda__c > agendaList = new LIST < Agenda__c > ();
            agendaList.add(agendaInfo2);
            agendaList.add(agendaInfo3);

            Time_Slots__c timeSlotInfo = new Time_Slots__c();
            timeSlotInfo = globalTest.createTimeSlot(agendaInfo.Id, roomInfo.Id);

            Time_Slots__c timeSlotInfo2 = new Time_Slots__c();
            timeSlotInfo = globalTest.createTimeSlot(agendaInfo2.Id, roomInfo.Id);

            Time_Slots__c timeSlotInfo3 = new Time_Slots__c();
            timeSlotInfo = globalTest.createTimeSlot(agendaInfo3.Id, roomInfo.Id);

            User userForGN = new User();
            userForGN = globalTest.createUserForGNUser();

            // userForGN 


            GN_User__c gnUserInfo = new GN_User__c();
            gnUserInfo = globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);



            Participant__c participantInfo = new Participant__c();
            participantInfo = globalTest.createParticipant(GNUserInfo.Id, timeSlotInfo.Id);

            BLN_Item__c item = new BLN_Item__c();
            item = globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);

            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            Tkt_profile__c tktprof = new Tkt_profile__c();
            tktprof = globalTest.createTktprofile(userForGN);

            Order__c insertOrder1 = new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1 = globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;


            Ticket__c ticket = new Ticket__c();
            ticket = globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);

            PageReference pageRef1 = Page.BLN_agenda;
            Test.setCurrentPage(pageRef1);
            //updated codeTesting
            Case cse = new Case();
            insert cse;

            Attachment attach = new Attachment();
            attach.Name = 'Unit Test Attachment';
            Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
            attach.body = bodyBlob;
            attach.parentId = cse.id;
            insert attach;
            Attachment attachments = [select id, name from Attachment where parent.id = : cse.id limit 1];
            LIST < Agenda__c > allSeminars = new LIST < Agenda__c > ();
            allSeminars.add(agendaInfo);
            allSeminars.add(agendaInfo2);
            allSeminars.add(agendaInfo3);

            list < string > rls1 = new list < string > ();
            rls1.add('test1');
            rls1.add('test2');
            rls1.add('test3');
            //updated Ending

            cookie counter = new Cookie('counter', eventInfo.id, null, -1, false);
            ApexPages.currentPage().setCookies(new Cookie[] {
                counter
            });
            BLN_Seminars_updCon semUpdate1 = new BLN_Seminars_updCon();
            BLN_Seminars_updCon semUpdate2 = new BLN_Seminars_updCon('a1919000000HJLT');




            //-----Variable Initialization----------


            apexpages.currentpage().getparameters().put('deleteAgendaId', 'a0x19000000KtfC');
            ApexPages.currentPage().getParameters().put('deletedId', attachments.id);
            apexpages.currentpage().getparameters().put('editAgendaId', 'a0x19000000KtfC');
            Apexpages.currentPage().getParameters().put('roomname', 'Sample');
            Apexpages.currentPage().getParameters().put('roomnum', 'RUMNO234');
            Apexpages.currentPage().getParameters().put('xyid', 'a1E19000000LNBL');
            Apexpages.currentPage().getParameters().put('delrmRecid', 'a1E19000000LNBL');
            Apexpages.currentPage().getParameters().put('newtrackname', 'Track1');
            Apexpages.currentPage().getParameters().put('tdrecid', 'a1G190000003wwt');
            Apexpages.currentPage().getParameters().put('delRecid', 'a1G190000003wwt');

            Apexpages.currentPage().getParameters().put('roleName_i', 'SamplePRole');
            Apexpages.currentPage().getParameters().put('roleid_i', 'a1C19000000U7vs');
            Apexpages.currentPage().getParameters().put('delroleid', 'a1C19000000U7vs');
            Apexpages.currentPage().getParameters().put('str_v', 'speaker');
            Apexpages.Currentpage().getparameters().put('agendaOrder', 'sample sample sample ');



            //aga.id= 'a0x19000000KtfC';


            //-----Method calling----------
            //-----Normal methods
            semUpdate1.deleteAgenda();
            semUpdate1.getVisibility();
            semUpdate1.segrigateSchedules(agendaList);
            semUpdate1.gaterFields();
            semUpdate1.createNewSeminar();
            semUpdate1.editSeminar();
            semUpdate1.createNewSeminar(agendaInfo);
            semUpdate1.DelAttachment();

            try {
                semUpdate1.saveAgenda();
            } catch (exception e) {}
            semUpdate1.cancelAgenda();
            semUpdate1.saveRoom();
            semUpdate1.deleteroom();
            semUpdate1.saveTrack();
            semUpdate1.deleteTrack();
            semUpdate1.ADDroleMD();
            semUpdate1.roledelmd();
            try {
                semUpdate1.savespeakermd();
            } catch (exception e) {}
            semUpdate2.onchangeAct();
            try {
                semUpdate1.updateAgendaOrder();
            } catch (exception e) {}
            DateTime dt = DateTime.newInstance(2007, 6, 23, 3, 3, 3);
            Long getStartTime = dt.getTime();
            DateTime dt1 = DateTime.newInstance(2007, 6, 23, 3, 3, 33);
            Long getEndTime = dt1.getTime();
            string s1 = string.valueof(getStartTime);
            string s2 = string.valueof(getEndTime);
            BLN_Seminars_updCon.getvalidationmethod(s1, s2, rls1, 'SampleSeminar');



            semUpdate1.AttName = 'bilpal';
            semUpdate1.seminarStartTime = s1;
            semUpdate1.seminarEndTime = s2;
            semUpdate1.selectedRoomId = roomInfo.id;
            semUpdate1.selectedTrackId = trackInfo.id;
            semUpdate1.agendaComponent = new BLN_UtillDisplayLinks();
            semUpdate1.selecedRolesinpick = rls1;

            Double Sample = semUpdate1.offset;



            //semUpdate1.DelAttachment();
            //-----Static methods

            //-----Inner classes

            BLN_Seminars_updCon.NestedSpeakerRole blnAttdeList = new BLN_Seminars_updCon.NestedSpeakerRole();
            blnAttdeList.Speaker = 'test';
            blnAttdeList.Role = 'Attendee';
            BLN_Seminars_updCon.groupBySeminars groupBySem1 = new BLN_Seminars_updCon.groupBySeminars(roomInfo, agendaList);
            BLN_Seminars_updCon.spkrndrole spkrdrle = new BLN_Seminars_updCon.spkrndrole('test', rls1);
            BLN_Seminars_updCon.groupBySeminars groupBySem2 = new BLN_Seminars_updCon.groupBySeminars(Date.today(), agendaList);
            BLN_Seminars_updCon.groupBySeminars groupBySem3 = new BLN_Seminars_updCon.groupBySeminars('test', agendaList);

            PageReference pageRefp1 = Page.BLN_EventSchedule;
            Test.setCurrentPage(pageRefp1);
            BLN_Seminars_updCon semUpdate3 = new BLN_Seminars_updCon();
          //  BLN_Seminars_updCon.attendeesList attendeesListObj = new BLN_Seminars_updCon.attendeesList(true, ticket, participantInfo);

            semUpdate1.selectedeventid = eventInfo.Id;
            semUpdate1.eventStartDate = '01/29/2016  1:31 PM';
            semUpdate1.eventEndDate = '01/29/2016  2:32 PM';
            semUpdate1.AttData = 'Globalnest is a software company';
            semUpdate1.selectedItemPoolId = ItemPool.id;
            PageReference pageRefp2 = Page.BLN_agenda;
            Test.setCurrentPage(pageRefp2);
            semUpdate1.nsprole = new List<BLN_Seminars_updCon.NestedSpeakerRole>();
            semUpdate1.nsprole.add(blnAttdeList);
            try{
            semUpdate1.saveAgenda();
            }catch(Exception e){}
            semUpdate1.selectedeventid = eventInfo.Id;
            semUpdate1.gaterFields();



        }
    }
}