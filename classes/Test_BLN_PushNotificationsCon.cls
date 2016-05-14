@isTest

global class Test_BLN_PushNotificationsCon {

    static testMethod void TestMethod_BLN_PushNotificationsCon() {

        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
                      

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
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                     
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);  
            eventInfo.time_zone__c= 'America/New_York';
            update eventInfo;
            
            BLN_Event__c insertEvent= new BLN_Event__c();
            insertEvent.Name= 'Default Event(Boothleads)';
            insertEvent.Start_Date__c= system.today();
            insertEvent.End_Date__c= system.today()+4; 
            insertEvent.time_zone__c= 'America/New_York';
            insertEvent.venue_name__c= 'Hyderabad';
            insertEvent.Organizer_Email__c= 'manasatest@gmail.com';
            insertEvent.organizer_id__c= CompanyInfo.id;
            insertEvent.BLN_State__c= Stateinfo.Id;
            insertEvent.BLN_Country__c= countryInfo.Id;
            insert insertEvent; 

            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
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
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            if(ticket.Tkt_profile__r.Email__c!=null){
             ticket.Tkt_profile__r.Email__c='gn@gnps.com';
             }

            EmailCampaign__c nwemailcamp1 = new EmailCampaign__c();
            nwemailcamp1.Name = 'Test Notification';
            nwemailcamp1.CampSubject__c = 'Hello';
            nwemailcamp1.Feature_Type__c= 'Notifications';
            nwemailcamp1.Event__c=eventInfo.id;
            nwemailcamp1.Template_Status__c = 'Active';
            nwemailcamp1.ToList__c = 'SPONSOR';
            nwemailcamp1.Email_Send_Date__c=system.now();
            nwemailcamp1.Email_Status__c ='Sent';
            insert nwemailcamp1;  
            
            Reg_Setting__c  rsett = new Reg_Setting__c();
            rsett = globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.Id, companyInfo.Id, null, 'Attendee', 'Attendee');
            rsett.Table_Name__c='Item_Type__c';
            rsett.Setting_Type__c='Display';
            update rsett;

            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            BLN_PushNotificationsCon pn=new BLN_PushNotificationsCon();
            
             ApexPages.currentPage().getParameters().put('pnName','hi');
             ApexPages.currentPage().getParameters().put('pnMsg','hi');
             ApexPages.currentPage().getParameters().put('ActStatus','Active');
             ApexPages.currentPage().getParameters().put('SentStatus','Sent');
             ApexPages.currentPage().getParameters().put('sendDate', system.now().format('MM/dd/yyyy hh:mm a'));
            
             pn.itype='Attendee,';
             pn.sendnotification();
            
             ApexPages.currentPage().getParameters().put('pnName','hi');
             ApexPages.currentPage().getParameters().put('pnMsg','hi');
             ApexPages.currentPage().getParameters().put('ActStatus','Active');
             ApexPages.currentPage().getParameters().put('SentStatus','Scheduled');
             ApexPages.currentPage().getParameters().put('sendDate', (system.now()+1).format('MM/dd/yyyy hh:mm a'));
            
             pn.itype='Attendee,';
             pn.sendnotification();
            
             ApexPages.currentPage().getParameters().put('cloneEcId',nwemailcamp1.id);
             pn.cloneNotification();
             
             pn.displayPermissions();
             
             ApexPages.currentPage().getParameters().put('delEcId',nwemailcamp1.id);
             pn.delnotification();
            
            
             BLN_PushNotificationsCon.viewDetails(nwemailcamp1.id,eventInfo.time_zone__c);
             BLN_PushNotificationsCon.saveEditNotif(nwemailcamp1.id,'hi','hi','Attendee,','Active','Sent',system.now().format('MM/dd/yyyy hh:mm a'),eventInfo.id,eventInfo.time_zone__c);
            
            BLN_AppMenuItem_DAO ami = new BLN_AppMenuItem_DAO();
            ami.getConnectedAppDetails();
            
            set<string> users=new set<string>();
            users.add(ticket.tkt_profile__r.BLN_GN_User__r.User__c);
            
            Test.StartTest();
            BLN_PushNotificationSc sc=new BLN_PushNotificationSc(users,'hi',nwemailcamp1.id,nwemailcamp1.Name);
          
            String sch = '0  00 1 3 * ?';
           system.schedule('Test', sch, sc);
         
            Test.stopTest();
            
        }
    }
}