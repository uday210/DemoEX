@istest(SeeAllData=true)
public class Test_BLN_BLDashboardCon{
    static testmethod void Testmethod_BLN_BLDashboardCon(){
    
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
            
          // Order__c insertOrder1= new Order__c();
       //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
           //User userInfo= new User();
            //userInfo= globalTest.createUserForGNUser();
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
     
            
           Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            
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
            
            list<Ticket__c> ticketlist = new list<Ticket__c>();
            Ticket__c ticket2 = new Ticket__c();
            ticket2= globalTest.createTicket(eventInfo.id, itemlr.Id, itemPoollr.Id, itemTypelr.Id, insertOrder1.Id, tktprof.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket.note__c = 'abcd';
            update ticket; 
            
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, itemlr.Id, itemPoollr.Id, itemTypelr.Id, insertOrder1.Id, tktprof.Id);
            
            Event_Price__c evntpr = new Event_Price__c();
            evntpr= globalTest.createEventPrice(eventInfo.Id, itemTypelr.Id);
            
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
            //dscd.User__c = gnUser1.Id;
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
                
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            BLN_BLDashboardCon blndash= new BLN_BLDashboardCon();
            blndash.na = 'blndash1';

            blndash.restoftheQueries();
            
            BLN_BLDashboardCon.boothreportInner dashboothrep = new BLN_BLDashboardCon.boothreportInner('dashboothrep1',1234);
            dashboothrep.BLusers = 'dashboothrep2';
            dashboothrep.ScanNo = 5;
            
            BLN_BLDashboardCon.leadratinginner dashleadra = new BLN_BLDashboardCon.leadratinginner(123,234);
            dashleadra.leadrat = 'dashleadra1';
            dashleadra.leadNo = 1234;

            BLN_DashboardCon dshmyobj = new BLN_DashboardCon();
            
             dshmyobj.device = null;
             dshmyobj.SelectedEvent= null;

    
    }
    
    }
}