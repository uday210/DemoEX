/*************************************************************************
 * Developer: Vineel 
 * Date: 4 Sep' 2015
 * Purpose: New Test Class

**************************************************************************/
@isTest(SeeAllData = true)
public class Test_BLN_Ticket_DAO {

    
    public static testMethod void  TestMethod_BLN_Ticket_DAO() {
        
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        System.runAs(U){
            
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
            
            GN_User__c  gnUser1= new GN_User__c();
            gnUser1= globalTest.createGNUser(U,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof =globalTest.createTktprofile(userForGN);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Type__c itemTypelr= new Item_Type__c();
            itemTypelr= globalTest.createItemType13();
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            
            Item_Pool__c ItemPoollr= new Item_Pool__c();
            ItemPoollr= globalTest.createItemPool(eventInfo.id, itemTypelr.Id, NULL,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            BLN_Item__c itemlr= new BLN_Item__c();
            itemlr= globalTest.createItem(ItemPoollr.Id, itemTypelr.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket.note__c = 'abcd';
            update ticket; 
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, itemlr.Id, itemPoollr.Id, itemTypelr.Id, insertOrder1.Id, tktprof.Id);
            
            Event_Price__c evntpr = new Event_Price__c();
            evntpr= globalTest.createEventPrice(eventInfo.Id, itemTypelr.Id);
            
            Question__c que = new Question__c();
            que=globalTest.createQuestion(eventInfo.id);            
            tstatus__c tstat = new tstatus__c();
            tstat = globalTest.createTstatus(ticket.Id);
            
            list<device_usage__c> dscs =  new list<device_usage__c>();
            device_usage__c dsc =  new device_usage__c();
            dsc.Device_OS__c = 'ios';
            dsc.Event__c = eventInfo.Id;
           // dsc.User__c = gnUser.Id;
            dscs.add(dsc);
            
            device_usage__c dscd =  new device_usage__c();
            dscd.Device_OS__c = 'Android';
            dscd.Event__c = eventInfo.Id;
           // dscd.User__c = gnUser1.Id;
            dscs.add(dscd);
            
            insert dscs;
            
            Lead_Scan__c ls=new Lead_Scan__c();
            ls.Event__c=eventInfo.id;
            ls.first_name__c='testa';
            ls.Last_Name__c='testb';
            //ls.Scanee_User__c=gnUser1.id;
            ls.Scanner_Company__c=companyInfo.id;
            ls.Scanner_User__c=gnUser.id;
            ls.Rating__c=4;
            insert ls;
        
            
            BLN_Ticket_DAO blnticdao =new BLN_Ticket_DAO(); //Constructor Initialization  
            
             
            
            SET<id> stt = new SET<id>();
            stt.add(tstat.id);
            List<Tstatus__c> tkk1 = new List<Tstatus__c>();
            tkk1=blnticdao.checkinStatus(stt);
            
            List<Ticket__c> tkk2 = new List<Ticket__c>();
            tkk2.add(ticket1);
            BLN_StatusMessage bstat = new BLN_StatusMessage();
            bstat = blnticdao.updateTicket(tkk2);
            bstat = blnticdao.insertTicket(tkk2);
            bstat = blnticdao.updateTicket(ticket);
            
            tkk2 = blnticdao.userOrderAndTickets('');
            
            SET<id> stt1 = new SET<id>();
            stt1.add(tstat.id);
            tkk2 = blnticdao.userOrderAndTickets(stt1,'uide','evide');
           try {
            tkk2 = blnticdao.getTickets('field','fields');
            } catch (exception ee) {}
            
            LIST<Id> ltt = new LIST<Id>();
            ltt.add(item.id);
            
            tkk2 = blnticdao.getSelectedTickets(ltt);
            tkk2 = blnticdao.getTicketsforItem(item.Id);
            
            SET<id> stt3 = new SET<id>();
            stt3.add(item.id);
            tkk2 = blnticdao.getSelectedTickets(stt3);
            tkk2 = blnticdao.ticketsListForEvent(eventinfo.id, system.today(),system.today()+2,'srch');
            tkk2 = blnticdao.eventBookedTickets('eves');
            tkk2 = blnticdao.eventBookedTickets(eventInfo.Id,'eveide');
            tkk2 = blnticdao.SupplySurveyInfoForEachQuestion('eveide1','eveide2');
            
            SET<id> stt2 = new SET<id>();
            stt2.add(que.id);
            
            tkk2 = blnticdao.SupplySurveyInfoForEachQuestionForXprint('eveide3',stt2);
            tkk2 = blnticdao.eventBookedTicketsForTicketLevelQuestions('eveide4');
            tkk2 = blnticdao.ticketsListWithDates('eveide5','eveide6',null,null);
            tkk2 = blnticdao.bookedTicketsForEvent('eveide7');
            tkk2 = blnticdao.bookedTicketsForEventForPrintExport('eveide8');
            tkk2 = blnticdao.bookedTicketsForItem(itemType.Id);
            tkk2 = blnticdao.bookedTicketsForItemPool(ItemPool.id);
            tkk2 = blnticdao.gettlist('eveide9');
            
            
            List<Ticket__c> tkk3 = new List<Ticket__c>();
            tkk3.add(ticket);
            //tkk3 = blnticdao.getTicketdetails(eventInfo.id,system.today(),system.today()+2,'');
            tkk3 = blnticdao.getTicketdetails(eventInfo.id,system.today(),system.today()+2);
            tkk3 = blnticdao.orderedtickets('eveide11');
            
            blnticdao.eventBookedlistoftics(eventinfo.id,stt2);
            blnticdao.getTcFromPid(insertOrder1.id);
            blnticdao.getevntid(item.id);
            blnticdao.tcWithTktPid(ticket.id);
            
            blnticdao.checkTicketEventMapping(eventinfo.id,ticket1.id);
            
            
            List<Ticket__c> tkk4 = new List<Ticket__c>();
            tkk4.add(ticket);
            tkk4 = blnticdao.getUserTracks('U.id');
            tkk4 = blnticdao.eventSeminarTickets('eventinfo.id');
            Datetime myDateTime1 = Datetime.newInstance(1960, 2, 17);
            Datetime newDateTime2 = myDateTime1.addDays(2);
            
             try{
            blnticdao.tcWithTktPid(eventinfo.id);
             }catch(exception e){}
            blnticdao.SupplySurveyInfoForEachQuestion(eventinfo.id,'test','eventlever');
            blnticdao.ticketsListForEvent(eventinfo.id,myDateTime1,newDateTime2);
            
           
            
        }
        
    }
    
}