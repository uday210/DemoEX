/*
Author: Anil Devarapu
Pupose: test methods for BLN_AttendeeDetailReportCon
Last Modified: 07-Oct-15

*/

@isTest(SeeAllData=true)
public class Test_BLN_AttendeeDetailReportCon{
   static testmethod void Testmethod_BLN_AttendeeDetailReportCon(){
        
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
              
           /***************** Constructor Instance Start********************************  */
            /*---------------------
            HoldParticpantRole
            
            HoldHashTagPool(HTag)
            HoldHashTagTicket(HTag)
            BLN_AttendeeDetailReport_BAL balToGetTickets
            ----------------------- */
            
            Agenda__c agnda =new Agenda__c(Agenda_Name__c='test Seminar',Agenda_Type__c='Event level Agenda',Event__c=eventInfo.id);
            insert agnda;
            
            Time_Slots__c tslot =new Time_Slots__c(name='a1wM0000000owA6',Slot_Start_date__c=system.today(),Slot_End_date__c=system.today()+2,Agenda__c=agnda.Id);
            insert tslot;
           
            Participant__c pspnt = new Participant__c(name='Test pspnt',Time_Slot__c=tslot.Id,Participant_Role__c='speaker',BLN_TKT_profile__c = tktprof.Id);
            Insert pspnt;
            
            BLN_Participant_Role__c pRole = new BLN_Participant_Role__c(name='Test p role',Participant_Name__c=pspnt.Id,BLN_Events__c=eventInfo.Id);
            insert pRole;
            
            BLN_Attendees_BAL.inncls BlnAttnd = new BLN_Attendees_BAL.inncls(ticket);
            

    
    
    
    
    BLN_AttendeeDetailReportCon attrptcon = new BLN_AttendeeDetailReportCon();
        
            //attrptcon.displayAttendeesInDetail();
            
            
            attrptcon.attendeeCon = new BLN_AttendeesController();
            attrptcon.rgListForReport = new List<Reg_Setting__c>();
            attrptcon.attendeeSettingList = new List<Reg_Setting__c>();
            //attrptcon.balToGetTickets = new BLN_AttendeeDetailReport_BAL();
            
            BLN_Attendees_BAL attBal = new BLN_Attendees_BAL();
            List<BLN_Attendees_BAL.inncls> incls = new LIST<BLN_Attendees_BAL.inncls>();
            incls  =  attBal.getAllTickets(userForGN.id,eventInfo.Id);
            
            attrptcon.getTickets = incls;
            List<BLN_Attendees_BAL.inncls>  attendeeList = new List<BLN_Attendees_BAL.inncls>();
            Map<Id,List<Reg_Setting__c>> attsetMap=new Map<Id,List<Reg_Setting__c>>();  
        attrptcon.showColumns();
            attrptcon.HoldParticpantRole(pRole);
            attrptcon.HoldHashTagPool(HTag);
            attrptcon.HoldHashTagTicket(HTag);
            attrptcon.exportAttendeesInDetail(); 
            attrptcon.printAttendeesInDetail(); 
            attrptcon.questionNumber=1;
            attrptcon.pCompName = '';
            attrptcon.checkUnionForAttRep = '';
            attrptcon.answerNumber=1;
            attrptcon.isEventAdmin=true;
            attrptcon.isBoothadmin=true;
            attrptcon.hideEventsTab(); 
            ApexPages.currentPage().getParameters().put('start','12344');
            ApexPages.currentPage().getParameters().put('length','1');
            attrptcon.processData();
            
            BLN_AttendeeDetailReportCon.DataTableWrapper wrappdataatt = new BLN_AttendeeDetailReportCon.DataTableWrapper(123,222,222,null);
         //   wrappdataatt.draw= 123;
         //   wrappdataatt.recordsTotal = 233;
         //   wrappdataatt.recordsFiltered = 990;
            
            attrptcon.exportselected();
            
            test.stopTest();
        
        
        
            String stng =attrptcon.xlsHeader ;
    
    
            }
        }
        
 
       
    
    }