@istest(seeAllData=true)
public class Test_BLN_ASC_Seminar{
    static testmethod void Test_BLN_ASC_Seminar(){

        globalForTestClass globalTest = new globalForTestClass();
        Profile p = [select id from profile where name = 'System Administrator'];
        userRole r = [SELECT ID FROM userRole WHERE name = : 'CEO'];
         User u = new User(alias = 'Test', email = 'testcode123vb@noemail.com',
            emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'codeTesting', Firstname = 'codeTesting', languagelocalekey = 'en_US',
            localesidkey = 'en_US', country = 'United States Of America', userRoleId = r.id, CompanyName = 'GlobalNest',
            timezonesidkey = 'America/Los_Angeles', username = 'testcode123vbc@noemail.com');
        insert u;
        
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
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
  tktprof =globalTest.createTktprofile(userForGN);

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
            
            BLN_Track__c track = new BLN_Track__c();
            track =globalTest.createTrack(eventInfo.id);
            
           
            
            Agenda__c agd = new Agenda__c();
            agd = globalTest.createAgenda(eventInfo.id,track.id);
            
            BLN_Room__c  blroomsinfo = new BLN_Room__c ();
            blroomsinfo = globalTest.createRoom(eventInfo.id);
            
            Time_Slots__c timeslotinfo = new Time_Slots__c();
            timeslotinfo = globalTest.createTimeSlot(agd.id,blroomsinfo.id);
 
            
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
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
            
            Participant__c pccpant = new Participant__c();
            pccpant=globalTest.createParticipant(gnUser.Id, timeslotinfo.Id);
            
            
            //ItemPool_Tag_Junction__c itemPJ = new ItemPool_Tag_Junction__c ();
            //itemPJ=globalTest.createtagjunction(itemPool.Id, hashT.Id);
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'thirumala', 'globalnest');
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            RestRequest req = new RestRequest(); 
            req.addParameter('Event_id',eventInfo.id);
            /*string currentdate='11/21/2014 9:00 PM';
            string Enddate='11/28/2014 9:00 PM';
            string ticopt='test';
            string feeopt='test1';
            req.addParameter('Event_id',eventInfo.id);
            req.addParameter('Start_date',currentdate);
            req.addParameter('End_date',Enddate);
            req.addParameter('ticketopt',ticopt);
            req.addParameter('feeopt',feeopt);
            req.requestURI = sfbaseURL+'/services/apexrest/BLN_ASC_EditTickets';  
            req.httpMethod = 'POST';*/
            //string bodys= '[{"tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "a0tc0000002coCMAAY","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}]';
           
            //string bodys = '{"poolid" : "","trowid":"1", "tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
           //blob b = blob.valueOf(bodys);
            //req.requestBody  = b;
            BLN_Seminars_updCon bsu= new BLN_Seminars_updCon();
            list<agenda__c> a= new list<agenda__c>();
            a.add(agd);
           // bsu.seminarInn.add(new groupBySeminars(blroomsinfo,a));
            BLN_Seminars_updCon.groupBySeminars testn= new BLN_Seminars_updCon.groupBySeminars(blroomsinfo,a); 
            
            
            RestContext.request = req;
            
          
            BLN_Participant_Role__c partcip = new BLN_Participant_Role__c();
            partcip.Name = 'partcip1';
            insert partcip;
            
           //BLN_ASC_Seminar.Container wrap = new BLN_ASC_Seminar.Container();
           //BLN_ASC_Seminar.GNUSER wrap1 = new BLN_ASC_Seminar.GNUSER();
           //BLN_ASC_Seminar.ROOM  wrap2 = new BLN_ASC_Seminar.ROOM();
           
          // req.addParameter('Event_id',eventInfo.id);
          // req.httpMethod = 'POST';
          // RestContext.request = new RestContext.request;
         req.requestURI ='/GlobalnestEM/BLN_ASC_Seminar';
           
          // BLN_ASC_Seminar BLNObj = new BLN_ASC_Seminar();
            req.addParameter('Event_Id',eventInfo.id );
             BLN_ASC_Seminar.Container con = new BLN_ASC_Seminar.Container();
            con.AgendaID = '123q';
            con.ProgrammeName = 'sda';
            con.ProgrammeDate = 'eqweqwe';
            con.StartTime = 'dasfvf';
            con.EndTime = 'lpol';
            //public List<GNUSER> GNUSERS{get;set;}
            // public List<ROOM> ROOMS{get;set;}
            con.TrackName = 'asffdf';
            con.TrackDescription = 'loasdksa';
            
            /*BLN_ASC_Seminar.GNUSER gn = new BLN_ASC_Seminar.GNUSER();
            gn.GNUSERID = 'gn1';
            gn.FirstName = 'gn2';
            gn.LastName = 'gn3';
            gn.Email = ' gn4';
            gn.PhoneNumber = 'gn5 ';
            gn.Company = 'gn6 ';
            gn.User_Pic = 'gn7 ';
            // public LIST<String> ParticipantRole = 'gn8 ';
            gn.GNUSER_Youtube = ' gn9';
            gn.GNUSER_Twitter = ' gn10';
            gn.GNUSER_SpeakerBlog = 'gn11 ';
            gn.GNUSER_linkedin = ' gn12';
            gn.GNUSER_Facebook = 'gn13 ';
            gn.GNUSER_CompanyWebSite = 'gn14 ';
            gn.GNUSER_CompanyLogo = 'gn15 ';
            gn.GNUSER_Biography = 'gn16 ';
            gn.GNUSER_City = 'gn17 ';
            gn.GNUSER_State = 'gn18 ';
            gn.GNUSER_Country = 'gn19 ';*/
            
            /***  BLN_Seminars_updCon Class ***/
            BLN_Seminars_updCon semcon=new BLN_Seminars_updCon(eventInfo.Id);
            apexpages.currentpage().getparameters().put('editAgendaId',agd.Id);
            semcon.deleteAgenda();
            try {
                semcon.createNewSeminar(agd); 
            } catch (exception exe) {}
            
            apexpages.currentpage().getparameters().put('editAgendaId',agd.Id);
            try{
            semcon.editSeminar();
           }catch(Exception e){}
            //semcon.createNewSeminar(agd);
            
            
            //BLN_Seminars_updCon.attendeesList attlst = new BLN_Seminars_updCon.attendeesList(false,ticket,pccpant);
            //semcon.saveAgenda();
           
            
            BLN_Seminars_updCon.trackmapcls semtrkcls = new BLN_Seminars_updCon.trackmapcls(partcip.Id,'name3');
            
            BLN_Seminars_updCon.roommapcls semroom = new BLN_Seminars_updCon.roommapcls(blroomsinfo.Id,'name1','name2');
            
            list<string> lss = new list<string>{'lststt','lststtt'};
            BLN_Seminars_updCon.spkrndrole semspkr = new BLN_Seminars_updCon.spkrndrole('lstst',lss);
            
            
            List<agenda__c> agg = new List<agenda__c>();
            agg.add(agd);
            
            
              
            
            BLN_ASC_Seminar.ROOM rm = new BLN_ASC_Seminar.ROOM();
            BLN_ASC_Seminar.tktprofile tpf = new BLN_ASC_Seminar.tktprofile();
            tpf.tktprofileID = tktprof.Id;
            tpf.FirstName = tktprof.First_Name__c;
            tpf.LastName = tktprof.Last_Name__c;
            tpf.Email = tktprof.Email__c;
            tpf.PhoneNumber = '123456';
            tpf.Company = 'test';
            tpf.User_Pic= 'test'; 
            tpf.ParticipantRole = new list<string>{'Speaker'};
            tpf.tktprofile_Youtube= 'test';
            tpf.tktprofile_Twitter= 'test';
            tpf.tktprofile_SpeakerBlog= 'test';
            tpf.tktprofile_linkedin= 'test';
            tpf.tktprofile_Facebook= 'test';
            tpf.tktprofile_CompanyWebSite= 'test';
            tpf.tktprofile_CompanyLogo= 'test';
            tpf.tktprofile_Biography= 'test';
            tpf.tktprofile_City= 'test';
            tpf.tktprofile_State= 'test';
            tpf.tktprofile_Country= 'test';
            
            BLN_Room__c insertRm= new BLN_Room__c();
        insertRm.Name= 'New Room1';
        insertRm.Event__c= eventInfo.Id;
        insertRm.Room_Number__c= 'Room-0003';

     BLN_Seminars_updCon.groupBySeminars gropsem = new BLN_Seminars_updCon.groupBySeminars(insertRm,agg);
     BLN_Seminars_updCon.groupBySeminars gropsem1 = new BLN_Seminars_updCon.groupBySeminars(system.today(),agg);
     BLN_Seminars_updCon.groupBySeminars gropsem2 = new BLN_Seminars_updCon.groupBySeminars('tnstn',agg);
     

//  BLN_Seminars_updCon.groupBySeminars groupBySem1 = new BLN_Seminars_updCon.groupBySeminars(roomInfo, agendaList);
 //           BLN_Seminars_updCon.groupBySeminars groupBySem2 = new BLN_Seminars_updCon.groupBySeminars(Date.today(), agendaList);
  //          BLN_Seminars_updCon.groupBySeminars groupBySem3 = new BLN_Seminars_updCon.groupBySeminars('test', agendaList);
     
              PageReference pageRef = Page.BLN_agenda;
            Test.setCurrentPage(pageRef);
            BLN_Seminars_updCon semcons= new BLN_Seminars_updCon(eventInfo.id);
            semcons.seminarInn.add(gropsem );
            //semcons.seminarInn.add(gropsem1);
             //semcons.seminarInn.add(gropsem2);
            
            
            
            
                BLN_ASC_Seminar.dopost();    
            rm.ROOMNAME = 'rm1';
            rm.ROOMNUMBER = 'rm2';
           
            BLN_Seminars_updCon bas=new BLN_Seminars_updCon();
             semcons.selectedeventid=eventInfo.id;
        semcons.urlCheck = 'BLN_agenda';
        semcons.groupByoption='Seminargrp';
        bas.urlCheck = 'BLN_agenda';
       bas.groupByoption='Seminargrp';
       // ApexPages.currentPage().putUrl('BLN_agenda');
        semcons.allSeminars=a;
        semcons.gaterFields();
        semcons.onchangeAct();
        semcons.deleteAgenda();
        semcons.createNewSeminar();
        apexpages.currentpage().getparameters().put('editAgendaId',agd.id);
        Test.startTest();
      semcons.editSeminar();
       // Test.stopTest();
       
        BLN_timeConToEvzoneCon timezonecl=new BLN_timeConToEvzoneCon();
        
        ////String utcDt = eventinfo.Start_Date__c.formatGMT('MM-dd-yyyy hh:mm a');
          //String utcDt1 = eventinfo.End_Date__c.formatGMT('MM-dd-yyyy hh:mm a');
          //timeslotinfo.Slot_Start_date__c = timezonecl.getDateBasedOnEventTimeZone(utcDt,eventinfo.id);
        //timeslotinfo.Slot_End_date__c = timezonecl.getDateBasedOnEventTimeZone(utcDt1,eventinfo.id);
        semcons.eventStartDate='11/05/2015  5:43 PM';
        semcons.eventEndDate='11/06/2015  5:43 PM';
           // bas.createNewSeminar();
           BLN_Seminars_updCon.groupBySeminars gs= new BLN_Seminars_updCon.groupBySeminars(blroomsinfo,agg);
           bas.cancelAgenda();
           try{
           bas.saveAgenda();
           bas.saveRoom();
           bas.deleteroom();
           bas.savetrack();
            bas.deletetrack();
            bas.ADDroleMD();
           bas.roledelmd();
           bas.savespeakermd();
            string start_date=string.valueof(system.now());
           string end_date=string.valueof(system.now()+4);
           list<string> lst=new list<string>();
           lst.add('test1');
           lst.add('test2');
           boolean b=BLN_Seminars_updCon.getvalidationmethod(start_date,end_date,lst,'test seminar');
           bas.updateAgendaOrder();
           }catch(exception e){}
           
          // Test.StartTest();  
           BLN_Seminars_updCon ss = new BLN_Seminars_updCon();
            PageReference pageRef1 = Page.BLN_agenda;
            Test.setCurrentPage(pageRef1);
             try{
        ss.saveRoom();
        
       
        }catch(Exception e){}
       try{
         ss.deleteroom();
        }
        catch(Exception e){}
         
         try{
         ss.saveTrack();
         }catch(Exception e){}
         try{
         Apexpages.currentPage().getParameters().put('delRecid',trackInfo.id);
         ss.deleteTrack();
         }catch(Exception e){}
           
          
          try{
          ss.ADDroleMD();
          }
          catch(Exception e){}
          
           try{
           ss.updateAgendaOrder();
           }
           catch(Exception e){}
           
          Test.stopTest();  
        
        }
    }
}