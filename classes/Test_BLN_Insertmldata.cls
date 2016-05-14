@istest
public class Test_BLN_Insertmldata {
static testmethod void Testmethod_Test_BLN_Insertmldata(){
User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        System.runAs(U){
            
            //User userForGN= new User();
            //userForGN= globalTest.createUserForGNUser();
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            //GN_User__c  gnUser= new GN_User__c();
            //gnUser= globalTest.createGNUser(U,countryInfo.Id, Stateinfo.Id);
            
            //GN_User__c  gnUser1= new GN_User__c();
           // gnUser1= globalTest.createGNUser(U,countryInfo.Id, Stateinfo.Id);

           
           BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);
            
           Event__c event = new Event__c(EV_Title__c = 'testEvent',Eventdex_Id__c =eventInfo.id,  EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass');
           event.Is_Webank_event__c = true;
           insert event;
            
              
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof =globalTest.createTktprofile(U);
            insertOrder1= globalTest.createOrder(tktprof.Id, U.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemtype.name =  'MatchLeads Buyer';
            update itemType;
            
            Item_Type__c itemTypelr= new Item_Type__c();
            itemTypelr= globalTest.createItemType13();
            itemTypelr.name = 'MatchLeads Seller';
            update itemTypelr;

            Item_Type__c itemTypelr1= new Item_Type__c();
            itemTypelr1= globalTest.createItemType13();
            itemTypelr1.name = 'Tst';
            update itemTypelr1;
            
            Item_Type__c itemTypelr2= new Item_Type__c();
            itemTypelr2= globalTest.createItemType13();
            itemTypelr2.name = 'package';
            update itemTypelr2;
            
            BLN_Track__c trck=new BLN_Track__c();
            trck=globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trck.id);
            //ItemPool.Addon_Parent__c = itemPool.Id;
            //update ItemPool;
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id,trck.id);
            ItemPool2.Addon_Parent__c = itemPool.Id;
            update ItemPool2;
            
            Item_Pool__c ItemPoollr= new Item_Pool__c();
            ItemPoollr= globalTest.createItemPool(eventInfo.id, itemTypelr.Id, NULL,trck.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            BLN_Item__c itemlr= new BLN_Item__c();
            itemlr= globalTest.createItem(ItemPoollr.Id, itemTypelr.Id, eventInfo.id);
            
           AttendeeSummary__c att = new AttendeeSummary__c(AS_Age__c=20,AS_BirthDate__c=date.valueOf('1995-05-05'),AS_BlogUrl__c='www.globalnest.com',AS_BusinessDescription__c='fgsdamnabfbhsd',AS_BusinessDunsNumber__c='2450153',
               AS_BusinessEstablishedDate__c=date.valueOf('1995-05-06'),AS_BusinessRevenue__c=324533,AS_BusinessTaxId__c='hngsdvdvf',AS_CellPhone__c='9858590231',
               AS_Company__c='testattendeecompany',AS_DiversityType__c='Minority Owned Business Enterprise;Disadvantaged Business Enterprise;Service Disabled Veteran Business Enterprise;Small Business Enterprise;Ability One;Woman Owned Business Enterprise;SBA 8(A) Program;Veteran Owned Business Enterprise;Lesbian Gay Bisexual Transgender Business;Alaskan Native Corporation Owned Firm;Small Disadvantaged Business;Historically Underutilized Business Zone;Disabled Business Enterprise;Historically Black Colleges And Universities;SELF-CERTIFIED SMALL DISADVANTAGED BUSINESS ',
               AS_Email__c='iamasalesforcedev401@noemail.com',AS_FaxNumber__c='9858985032',AS_FirstName__c='testattendeesummaryfirstname',AS_Gender__c='Male',
               AS_HomeAddress1__c='mjbfnmf',AS_HomeAddress2__c='nbdfhj',AS_HomeCity__c='mhsdfgfd',As_Home_Country__c='India',AS_HomePhone__c='6998878422',
               AS_HomePoBox__c=22125,AS_HomePoboxNo__c='84367',As_Home_State__c='Goa',AS_HomeZipcode__c=32121,AS_ImageUrl__c='www.globalnest.com',AS_LastName__c='testattendeelastname',AS_NAICSCode1__c=524621,
               AS_NAICSCode2__c=524421,AS_NAICSCode3__c=524671,AS_NAICSCode4__c=523621,AS_NAICSCode5__c=528921,AS_NumberOfEmployees__c=200,AS_prefixNew__c='mr',
               AS_PrimaryBusinessCategory1__c='Accounting',AS_SecondaryBusinessCategory1__c='Animation',AS_ShippingAddress1__c='dfdf',AS_ShippingAddress2__c='dsyhg',
               AS_ShippingCity__c='asfdsf',As_Shipping_Country__c='India',AS_ShippingPhone__c='3554353132',AS_ShippingPoBox__c=32224,AS_Shippingpoboxno__c='35521',As_Shipping_States__c='Goa',
               AS_shippingzip__c='32122',AS_ShippingZipcode__c=89524,AS_SuffixNew__c='dr',AS_ThroughEventBrite__c=true,AS_Title__c='hmjnhgh',AS_WebsiteUrl__c='hasdas.com',AS_WorkAddress1__c='dsag',
               AS_WorkAddress2__c='fdwe',AS_WorkCity__c='ewqrwd',AS_Work_Country__c='India',AS_WorkPhone__c='3554353132',AS_WorkPoBox__c=52346,AS_Workpoboxno__c='85231',AS_Work_States__c='Goa',AS_WorkZipCode__c=85246,AS_WorkZip__c='89523',
               Registration_type__c='kdsmkas');
           insert att; 
           
           //Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(AS_id__c=att.Id,Attendee_Types__c= 'Attendee',TicketTypes__c='Full Conference');
           //insert event_att_map ;
           
           Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
            eam.AS_id__c= att.id;
            eam.Boothleads_Profile__c= 'Attendee';
            //eam.EV_id__c= event.id;
            eam.IsBoothLeadsAttendee__c= TRUE;
            eam.checkbox_dataTable__c= TRUE;
            //insert eam;
          
             
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            //ticket.Item_Pool__c = ItemPool2.id;
            //update ticket;
            
            Ticket__c ticketSller= new Ticket__c();
            ticketSller= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemTypelr.Id, insertOrder1.Id, tktprof.Id);
            
            
             Ticket__c ticket2= new Ticket__c();
            ticket2= globalTest.createTicket(eventInfo.id, item.Id, itemPoollr.Id, itemTypelr.Id, insertOrder1.Id, tktprof.Id);
            //ticket.Item_Pool__c = ItemPool2.id;
            //update ticket;
            
            Ticket__c ticketSller2= new Ticket__c();
            ticketSller2= globalTest.createTicket(eventInfo.id, item.Id, itemPoollr.Id, itemTypelr1.Id, insertOrder1.Id, tktprof.Id);
            
            
            
            Ticket__c ticket4= new Ticket__c();
            ticket4= globalTest.createTicket(eventInfo.id, item.Id, itemPoollr.Id, itemTypelr2.Id, insertOrder1.Id, tktprof.Id);
            
            SET<id> tIds = new SET<id> {ticket.id};
            
           SET<id> tIds2 = new SET<id> {ticketSller.id};

           SET<id> tIds3 = new SET<id> {ticketSller2.id};
           
           SET<id> tIds4 = new SET<id> {ticket2.id};
           
           SET<id> tIds5 = new SET<id> {ticket4.id}; 
           
            SET<id> tIds6 = new SET<id> {ticket.id}; 
           
            
            Profile__c profnme = new Profile__c();
            profnme.PR_Name__c = 'Boothadmin';
            profnme.PR_Version__c = 'Anils';
            insert profnme;
            
            Profile__c profnme2 = new Profile__c();
            profnme2.PR_Name__c = 'Attendee';
            profnme2.PR_Version__c = 'Aniltst';
            insert profnme2;
            
            test.startTest();
            BLN_Insertmldata blnInsrtdta = new BLN_Insertmldata();
            
            blnInsrtdta.insertMLData(tIds );
           
            BLN_Insertmldata blnInsrtdta2 = new BLN_Insertmldata();
            try{
            blnInsrtdta2.insertMLData(tIds2 );
            }catch(Exception e){}
            
            blnInsrtdta.insertMLData(tIds3 );
            try {
              BLN_Insertmldata blnInsrtdta3 = new BLN_Insertmldata();
              blnInsrtdta3.insertMLData(tIds4 );
            }
            catch(Exception e){
              
            }
            try {
              BLN_Insertmldata blnInsrtdta4 = new BLN_Insertmldata();
              blnInsrtdta4.insertMLData(tIds5 );
            }
            catch(Exception e){
              
            }
            try {
                BLN_Insertmldata blnInsrtdta6 = new BLN_Insertmldata();
              blnInsrtdta6.insertMLData(tIds6 );
              blnInsrtdta6.dummy();
            }
            catch(Exception e){
              
            }
            test.stoptest();
}
}
}