@istest(seeAlldata=true)
public class Test_BLN_ASC_Checkin{
    static testmethod void Test_BLN_ASC_Checkin(){
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
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
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            BLN_Room__c roomInfo= new BLN_Room__c();
            roomInfo= globalTest.createRoom(eventInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            Agenda__c agendaInfo= new Agenda__c();
            agendaInfo= globalTest.createAgenda(eventInfo.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
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
            
            //ItemPool_Tag_Junction__c itemPJ = new ItemPool_Tag_Junction__c ();
            //itemPJ=globalTest.createtagjunction(itemPool.Id, hashT.Id);
            
            Reg_Setting__c rSet= new Reg_Setting__c();
            rSet=globalTest.createRegSettings(eventInfo.id,itemPool.Id, item.id, companyInfo.id, hashT.id, 'gnest', 'globalnest');
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            Time_Slots__c tlslot = new Time_Slots__c();
            tlslot = globalTest.createTimeSlot(agendaInfo.Id, roomInfo.Id);
            
           // BLN_Participant_Role__c patricipnt = new BLN_Participant_Role__c();
            
            Participant__c pcpant = new Participant__c();
            pcpant = globalTest.createParticipant(gnUser.Id, tlslot.Id);
            
            booth_map__c btmap = new booth_map__c();
            btmap = globalTest.createBoothmap(ticket.Id);
            
            BLN_Room__c rm=new BLN_Room__c();
            rm=globalTest.createRoom(eventInfo.id);
            
          RestRequest req = new RestRequest(); 
          String sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            req.addParameter('Event_id',eventInfo.id);
            req.addParameter('LastModifiedDate',string.valueof(system.now().addHours(-10)));
            req.addParameter('Start_date',string.valueof(date.today()));
            req.addParameter('End_date',string.valueof(date.today()+4));
           //req.addParameter('ticketopt',ticopt);
            //req.addParameter('feeopt',feeopt);
             req.addParameter('User_id',u.id);
             req.requestURI =  sfbaseURL+'/services/apexrest/BLN_ASC_Checkin';  
            req.httpMethod = 'POST';
     
           
            string bodys = '{"poolid" : "","trowid":"1", "tprice" : 150,"tags" : [],"tqty" : 30,"tname" : "iPad air ticket","subpackagegroup" : [],"ispackage" : false,"tdesc" : "","tvisib" : true,"tpaytype" : "Paid","itemtype" : "a1Ac0000000cNTAEA2","grouptickets" : [{"edate" : "12/09/2014 07:30 pm","sdate" : "12/06/2014 07:30 pm","tprice" : 150,"minqty" : "1","maxqty" : 20,"tname" : "iPad air ticket","itemid" : "","poolid" : "a18c0000000WS0zAAG","qty" : 30}],"ticketcount" : "1"}';
            blob b = blob.valueOf(bodys);
            req.requestBody  = b;
            RestContext.request = req;
            
         
           BLN_ASC_Checkin.maincontainer wrap = new BLN_ASC_Checkin.maincontainer();
           BLN_ASC_Checkin.Ordersonly wrap1 = new BLN_ASC_Checkin.Ordersonly();
            wrap1.OrdersList_info = insertOrder1;
           BLN_ASC_Checkin.TotalList wrap2 = new BLN_ASC_Checkin.TotalList();
            wrap2.siteurl = 'wrap21';
            wrap2.isorder = true;
           
        
        
            BLN_ASC_Checkin.ROOM chkrom = new BLN_ASC_Checkin.ROOM();
            chkrom.ROOMNAME = 'ckhrom1';
            chkrom.ROOMNUMBER = 'chkrom2';
            
            /*BLN_ASC_Checkin.GNUSER chkgn = new BLN_ASC_Checkin.GNUSER();
            chkgn.GNUSERID = 'ckhusr';
            List<string> lt = new List<string> {'test1','test2'};
                chkgn.ParticipantRole = lt;  */          
            
            BLN_ASC_Checkin.Container1 chkcon = new  BLN_ASC_Checkin.Container1();
            chkcon.AgendaID = 'chkcon1';
            chkcon.ProgrammeName = 'chkcon2';
            chkcon.ProgrammeDate = 'chkcon3';
            chkcon.StartTime = 'chkcon4';
            chkcon.EndTime = 'chkcon5';
            
            List<BLN_ASC_Checkin.ROOM> ckkroom = new List<BLN_ASC_Checkin.ROOM> ();
            ckkroom.add(chkrom);
            chkcon.ROOMS = ckkroom;
            
          /*  List<BLN_ASC_Checkin.GNUSER> ckkusr = new List<BLN_ASC_Checkin.GNUSER>();
            ckkusr.add(chkgn)  ;
            chkcon.GNUSERS = ckkusr;
            */
            
            
            chkcon.TrackName = 'chkcon5';
            chkcon.TrackDescription = 'chkcon6';
            
            BLN_ASC_Checkin.boothContainer chkbootcon = new BLN_ASC_Checkin.boothContainer();
            chkbootcon.BoothName = 'chkbootcon1';
            chkbootcon.BoothArea = 'chkbootcon2';
            chkbootcon.BoothNumber = 'chkbootcon3';
            chkbootcon.Room = 'chkbootcon4';
            
            BLN_ASC_Checkin.container chkcont = new BLN_ASC_Checkin.container();
            chkcont.AgendaID='chkcont1';
            chkcont.ProgrammeName = 'chkcont2';
            chkcont.ProgrammeDate = 'chkcont3';
            chkcont.StartTime = 'chkcont4';
            chkcont.EndTime = 'chkcont5';
            chkcont.TrackDescription = 'chkcont6';
            
            List<BLN_ASC_Checkin.ROOM> ckkroom1 = new List<BLN_ASC_Checkin.ROOM> ();
            ckkroom1.add(chkrom);
            chkcont.ROOMS = ckkroom1;
            
           /* List<BLN_ASC_Checkin.GNUSER> ckkusr1 = new List<BLN_ASC_Checkin.GNUSER>();
            ckkusr1.add(chkgn)  ;
            chkcont.GNUSERS = ckkusr1;*/
            
            BLN_ASC_Checkin.Container2 chkcon2 = new BLN_ASC_Checkin.Container2();
            List<BLN_ASC_Checkin.boothContainer> lttboo = new List<BLN_ASC_Checkin.boothContainer> ();
            lttboo.add(chkbootcon);
            chkcon2.BoothDetails =  lttboo;           
           // chkcon2.GnuserID = 'chkcon21';
           
            BLN_ASC_Checkin.moddate = datetime.newInstance(2014, 9, 15, 13, 30, 0);

           
           BLN_ASC_Checkin BLNObj = new BLN_ASC_Checkin();
            try{
                BLN_ASC_Checkin.dopost();    
            }catch(Exception Ex){ }  
           BLN_ASC_Checkin.maincontainer mc=new BLN_ASC_Checkin.maincontainer();
           mc.dt = datetime.newInstance(2014, 9, 15, 13, 30, 0); 
           
           List<BLN_ASC_Checkin.tktprofile> ltp = new List<BLN_ASC_Checkin.tktprofile>();
           BLN_ASC_Checkin.tktprofile tktprof1 = new BLN_ASC_Checkin.tktprofile();
 
           BLN_ASC_Checkin.container cntnr = new BLN_ASC_Checkin.container();
           cntnr.tktprofiles = new List<BLN_ASC_Checkin.tktprofile>();
           
            BLN_ASC_Checkin.container1 cntnr1 = new BLN_ASC_Checkin.container1();
           cntnr1.tktprofiles = new List<BLN_ASC_Checkin.tktprofile>();
           
           BLN_ASC_Checkin.tktprofile ctp = new BLN_ASC_Checkin.tktprofile();
           ctp.tktprofileID = 'test111';
           ctp.ParticipantRole = new LIST<String>();
           
           BLN_ASC_Checkin.boothContainer cbc = new BLN_ASC_Checkin.boothContainer();
           cbc.BoothId = 'test222';
           cbc.BoothTicketId = 'test122';
        
           BLN_ASC_Checkin.Container2 cc2 = new BLN_ASC_Checkin.Container2();
           cc2.tktprofileID = 'test31451';
           
           req.addParameter('LastModifiedDate',null);
           try{
                BLN_ASC_Checkin.dopost();    
            }catch(Exception Ee){ }
        }
    }
}