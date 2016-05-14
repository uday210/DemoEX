@isTest(seeAllData=true)
public class Test_BLN_UpdateSchedulerRecordCon {

static testmethod void Testmethod_BLN_UpdateSchedulerRecordCon(){
        
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
         Id eventAdminId=u.id;
        
        
        
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
            
            
        Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
        EV_EndDate__c = system.today()+10,
        EV_StartDate__c = system.today(),
        EV_EndTime__c='06:00 PM',
        StartTime__c='09:00 AM');
        insert eve;
        Id EventId=eve.Id;
        
        AttendeeSummary__c att = new AttendeeSummary__c();
        att.AS_FirstName__c='re';
        att.AS_LastName__c ='lo';
        att.AS_Email__c ='buser2@badmin.com';
        att.AS_Company__c ='global';
        insert att;  
        
        Event_Attendee_Mapping__c eam = new Event_Attendee_Mapping__c(AS_id__c=att.id,EV_id__c=eve.id); 
        insert eam;
        
        User_Profile_Event__c upe = new User_Profile_Event__c(Attendee_Summary__c=att.id,EV_id__c=EventId,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true,IsMatchMakingUser__c=true,MAtchMakingProfile__c='Corporate');         
        insert upe; 
        
        EventSchedule__c es= new EventSchedule__c(MM_To_UPE__c= upe.id,MM_Slot_Status__c='Cancelled');
        insert es;
        
        User_Profile_Event__c upe1 = new User_Profile_Event__c(Attendee_Summary__c=att.id,EV_id__c=EventId,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true,IsMatchMakingUser__c=true,MAtchMakingProfile__c='MBE');         
        insert upe1; 
        EventSchedule__c es1= new EventSchedule__c(MM_To_EAM__c= eam.id,MM_Slot_Status__c='Cancelled');
        insert es1;
        
        BLN_ExceptionCountryState__c blnexcconst = new BLN_ExceptionCountryState__c();
        blnexcconst.InputCountry__c =countryInfo.id;
        blnexcconst.InputState__c = stateInfo.id;
        blnexcconst.BLN_Events__c = eventInfo.id;
        blnexcconst.BLN_Events__c=eventInfo.id;
        blnexcconst.BLN_Ticket__c=ticket.id;
        blnexcconst.schedulerupdated__c=false;
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
       ApexPages.currentpage().getParameters().put('id',eventInfo.Id);  
      BLN_UpdateSchedulerRecordCon blnuschrcon = new BLN_UpdateSchedulerRecordCon();
        
      BLN_UpdateSchedulerRecordCon.ExceptionCountryState blnhdrn1 = new BLN_UpdateSchedulerRecordCon.ExceptionCountryState();
            blnhdrn1.InputCountry=countryInfo.id;
            blnhdrn1.InputState=stateInfo.id;
            blnhdrn1.OutputCountry=countryInfo.id;
            blnhdrn1.OutputState=stateInfo.id;
            blnhdrn1.ticketids=ticket.id;
            blnhdrn1.excepids=blnexcconst.id;
            blnhdrn1.outputstatenotneeded=true;
            
            
            
            
       BLN_UpdateSchedulerRecordCon.ExceptionCountryState blnhdrn2= new BLN_UpdateSchedulerRecordCon.ExceptionCountryState();
            blnhdrn2.InputCountry=countryInfo.id;
            blnhdrn2.InputState=stateInfo.id;
            blnhdrn2.OutputCountry=countryInfo.id;
            blnhdrn2.OutputState=stateInfo.id;
            blnhdrn2.ticketids=ticket.id;
            blnhdrn2.excepids=blnexcconst.id;
            blnhdrn2.outputstatenotneeded=true;
        
      blnuschrcon.ecslist = new list<BLN_UpdateSchedulerRecordCon.ExceptionCountryState>();
      blnuschrcon.ecslist.add(blnhdrn1);
      //blnuschrcon.ecslist.add(blnhdrn2);
      blnuschrcon.save();
      BLN_UpdateSchedulerRecordCon.statesBasedOnCountry('India');  
        
        }
        
     }
     
     
 }