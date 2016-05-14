@istest
public class Test_BLN_SeminarsCon{
    public static BLN_Event__c eventInfo{get;set;}
    public static testmethod void Testmethod_BLN_SeminarsCon(){
        
        //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUser();
          Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

         User u = new User(alias = 'Test', email='testcode123vb@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode123vbc@noemail.com');
        insert u;
        
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
                    
            eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);        
            
            BLN_Room__c roomInfo= new BLN_Room__c();
            roomInfo= globalTest.createRoom(eventInfo.Id);
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            Agenda__c agendaInfo= new Agenda__c();
            agendaInfo= globalTest.createAgenda(eventInfo.Id, trackInfo.Id);
            
            Agenda__c agendaInfo2= new Agenda__c();
            agendaInfo2= globalTest.createAgenda(eventInfo.Id, trackInfo.Id);
            
            Agenda__c agendaInfo3= new Agenda__c();
            agendaInfo3= globalTest.createAgenda(eventInfo.Id, trackInfo.Id);
            
            LIST<Agenda__c> agendaList= new LIST<Agenda__c>();
            agendaList.add(agendaInfo2);
            agendaList.add(agendaInfo3);
            
            Time_Slots__c timeSlotInfo= new Time_Slots__c();
            timeSlotInfo= globalTest.createTimeSlot(agendaInfo.Id,roomInfo.Id);
           
            Time_Slots__c timeSlotInfo2= new Time_Slots__c();
            timeSlotInfo= globalTest.createTimeSlot(agendaInfo2.Id,roomInfo.Id);
           
            Time_Slots__c timeSlotInfo3= new Time_Slots__c();
            timeSlotInfo= globalTest.createTimeSlot(agendaInfo3.Id,roomInfo.Id);
            
            User userForGN = new User();
            userForGN = globalTest.createUserForGNUser();
                        
           // userForGN 
            
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(userForGN , countryInfo.Id, stateInfo.Id);
            
             
        
            Participant__c participantInfo= new Participant__c();
            participantInfo= globalTest.createParticipant(GNUserInfo.Id,timeSlotInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
           Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
             
            PageReference pageRef1 = Page.BLN_agenda;
            Test.setCurrentPage(pageRef1);
            
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            BLN_SeminarsCon semData1= new BLN_SeminarsCon();
            semData1.gaterFields();
            semData1.groupByoption='Name';
            semData1.onchangeAct();
            semData1.segrigateSchedules(agendaList);
            semData1.createNewSeminar();
            semData1.createNewSeminar(agendaInfo);
            semData1.cancelAgenda();
            semData1.newRoom.Name= 'New Room';
            semData1.saveRoom();
            semData1.newTrack.Name= 'New Track';
            semData1.saveTrack();
            semData1.groupByoption='Room';
            semData1.onchangeAct();
            semData1.groupByoption='Track';
            semData1.onchangeAct();
            semData1.seminarStartTime='sstime';
            semData1.seminarEndTime='setime';
            semData1.selectedRoomId='ssroomi';
            semData1.selectedTrackId='sstracki';
            ApexPages.CurrentPage().getParameters().put('editAgendaId',agendaInfo.Id);
            semData1.editSeminar();
            Datetime sdate=system.today();
            Datetime edate=system.today()+2;
            semData1.eventStartDate= string.valueof(sdate.format());
            semData1.eventEndDate= string.valueof(edate.format());
            semData1.saveAgenda();
            
            ApexPages.CurrentPage().getParameters().put('deleteAgendaId',agendaInfo.Id);
            semData1.deleteAgenda();
              
           PageReference pageRef2 = Page.BLN_EventSchedule;
            Test.setCurrentPage(pageRef2);   
            
            //BLN_SeminarsCon.attendeesList blnattls = new BLN_SeminarsCon.attendeesList();
            
            BLN_SeminarsCon.groupBySeminars blnsem = new BLN_SeminarsCon.groupBySeminars(roomInfo,agendaList);
            Date d= system.today();
            BLN_SeminarsCon.groupBySeminars blnsem1 = new BLN_SeminarsCon.groupBySeminars(d,agendaList);
            
         /*    BLN_SeminarsCon semData2= new BLN_SeminarsCon();
            semData2.gaterFields();
            semData2.groupByoption='Room';
            semData2.onchangeAct();
            semData2.segrigateSchedules(agendaList);
            semData2.createNewSeminar();
            semData2.createNewSeminar(agendaInfo2);
            semData2.cancelAgenda();
            semData2.newRoom.Name= 'New Room';
            semData2.saveRoom();
            semData2.newTrack.Name= 'New Track';
            semData2.saveTrack();
            
             ApexPages.CurrentPage().getParameters().put('editAgendaId',agendaInfo.Id);
            semData2.editSeminar();
            Datetime sdate2=system.today();
            Datetime edate2=system.today()+2;
            semData2.eventStartDate= string.valueof(sdate2.format());
            semData2.eventEndDate= string.valueof(edate2.format());
            semData2.saveAgenda();
            
            ApexPages.CurrentPage().getParameters().put('deleteAgendaId',agendaInfo.Id);
            semData2.deleteAgenda();
            */
            
            BLN_SeminarsCon semData2= new BLN_SeminarsCon();
                  semData2.selectedeventid= eventInfo.Id; 
            semData2.gaterFields();
        }
    }
}