@istest
public class Test_BLN_CheckinHistoryReportService {
    static testmethod void Testmethod_BLN_BLN_CheckinHistoryReportService(){
    
    
    //User U= new User();
    globalForTestClass globalTest= new globalForTestClass();
    //U= globalTest.createUser();
    
    Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];
        // ------------------ Eventadmin Insert ---------------------
        
        User u = new User(alias = 'Test', email='testcofvsgsde@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
        localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
        timezonesidkey='America/Los_Angeles', username='testcofvsgsde@noemail.com');
       database.insert(u);

    
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
            
            Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id);             
            
             BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);        
            
            list<BLN_Event__c> sce = new list<BLN_Event__c>();
            sce.add(eventInfo);
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);          
       
                       
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
          
          
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
  tktprof =globalTest.createTktprofile(userForGN);

            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id,insertOrder1.Id,tktprof.id);
            
            tstatus__c tstat=new tstatus__c ();
             tstat = globalTest.createTstatus(ticket.id);
             tstat.scan_time__c = system.now();
            update tstat;
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id,insertOrder1.Id,tktprof.id);
            
            ticket1.Tstatus_Id__c = tstat.id;
            update ticket1;
            
            list<Ticket__c> ls = new list<Ticket__c>();
            ls.add(ticket);
            ls.add(ticket1);
            
            BLN_Paytype__c ptype=new BLN_Paytype__c(paytype_name__c = 'Check');
            insert ptype;
            
            PGateway_Type__c pggatewaytype=new PGateway_Type__c(Name='Check',Display_Type__c='Checkbox',Onsite_Flag__c=true,ScanAttendee_Flag__c=true,Online_Flag__c = true,Adaptive_Type__c='Direct',paytype_id__c = ptype.id);
            insert pggatewaytype;
        
            Pay_Gateway__c paygateway=new Pay_Gateway__c(Company__c = companyInfo.id,PGateway_Type__c = pggatewaytype.id,BLN_GN_User__c =gnUser.id);
            insert paygateway;
            Payment__c payobj=new Payment__c(Order__c = insertOrder1.id,Payment_Amount__c=20.0,Currency_Code__c = currenyInfo.id,BLN_Pay_Gateway__c = paygateway.id);
            insert payobj;
            
            list<Payment__c> lpayment = new list<Payment__c>();
            lpayment.add(payobj);
            
            Hash_Tag__c HTag = new Hash_Tag__c ();
            HTag = globalTest.createHashTag(eventInfo.id);
            
            BLN_Ticket_DAO ticdao = new BLN_Ticket_DAO();
            
            BLN_CheckinHistoryReportService  bchr =  new BLN_CheckinHistoryReportService();
            bchr.ticDAO = ticdao; 
            bchr.ticketDetails = ls;
            try{
           bchr.TicketCheckInHistory(ls,'Ticket', 'Registration Type',eventInfo.id,tstat.owner.id);
           bchr.TicketCheckInHistory(ls,'Attendee', 'Registration Type',eventInfo.id,tstat.owner.id);
           }catch(exception e){}
           BLN_CheckinHistoryReportService.grouptics grptics = new BLN_CheckinHistoryReportService.grouptics();
           list<BLN_CheckinHistoryReportService.grouptics> lgrptics = new list<BLN_CheckinHistoryReportService.grouptics>();
           lgrptics.add(grptics);
           BLN_CheckinHistoryReportService.tstatDetails tsatdet = new BLN_CheckinHistoryReportService.tstatDetails();
           tsatdet.lastmoddate = '';
           tsatdet.device = '';
           tsatdet.scanBy = '';
           tsatdet.tstatName = true;
           BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails chkinhisdet = new BLN_CheckinHistoryReportService.BLN_CheckInHistoryDetails(ticket,lgrptics);
           
           
           
     
        
    }
    
   } 
     
   }