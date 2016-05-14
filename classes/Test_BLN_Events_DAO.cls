@istest
public class Test_BLN_Events_DAO{
    static testmethod void Testmethod_BLN_Events_DAO(){
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
            
           
           Event_Pay_Gateway__c eww=new Event_Pay_Gateway__c();
           
                PGateway_Type__c pgt = new PGateway_Type__c();
               // pgg.Pay_Gateway__c=pg.id;
               // pgg.Events__c=eventinfo.id;
                  pgt.name='PayPal';
                  insert pgt;
                
                //dd.updatepgemail(eventInfo.id,'global@nest.com');
            Pay_Gateway__c pg=new Pay_Gateway__c();
                 pg.PGateway_Type__c=pgt.id;
                   pg.PG_Email_Id__c='global@nest.com';
                   pg.PP_Payment_Type__c='Chained';
                   pg.PP_Fee_Payer__c='EACHRECEIVER';
                   pg.Company__c=eventinfo.organizer_id__c ;
                   insert pg;
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
            Badge__c  Badge=new Badge__c ();
            Badge= globalTest.createBadge(ticket.Id);
           
                BLN_Events_DAO dd = new BLN_Events_DAO();
    
               
               dd.getEventDetails(eventInfo.id);
               
               BLN_Event__c eventInfo1= new  BLN_Event__c();
               eventInfo1.Name = 'test1';
               eventInfo1.Organizer_Email__c = 'test@test.com';
               
               LIST<BLN_Event__c> evelist=new LIST<BLN_Event__c>();
               evelist.add(eventInfo1);
               
               dd.createEvent(evelist);

               //try{
                dd.gettingAllEvents(u.Id);
               
                dd.TogetRoleofanEvent(u.Id);
                dd.updateBadge(eventInfo.id, 'test');
                Decimal num = 10.22;
                boolean app = true;
                dd.updateSalesTax(eventInfo.id,num,app);
                dd.updatepgemail(eventInfo.id,pg.PG_Email_Id__c);
               // }catch(exception e){}
                 dd.updateBadgeNew(eventInfo.id,Badge.id);
    }
    }
    }