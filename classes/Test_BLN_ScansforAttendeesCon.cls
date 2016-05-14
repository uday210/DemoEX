@istest
public class Test_BLN_ScansforAttendeesCon{
    public static testmethod void Testmethod_BLN_ScansforAttendeesCon(){
    
    globalForTestClass globalTest= new globalForTestClass();
    
     Profile p = [select id from profile where name='System Administrator'];
     userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
     

     User u = new User(alias = 'Test', email='testcode123vb@noemail.com',
                       emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                       localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                       timezonesidkey='America/Los_Angeles', username='testcode123vbc@noemail.com');
    insert u;
    
    
    
    
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
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id); 
                    
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            
        User userInfo= new User();
            userInfo= globalTest.createUserForGNUser();
                        
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(userInfo, countryInfo.Id, stateInfo.Id);
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u,countryInfo.Id, stateInfo.Id);
            
            BLN_Room__c roomInfo= new BLN_Room__c();
            roomInfo= globalTest.createRoom(eventInfo.Id);
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
  tktprof =globalTest.createTktprofile(userInfo);
             tktprof.BLN_GN_User__c = gnUserInfo.id;
             update tktprof;

            insertOrder1= globalTest.createOrder(tktprof.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            ticket.ticket_status__c = 'Booked';
            update ticket;
            
            BLN_Room__c broom=new BLN_Room__c ();
            broom = globalTest.createRoom(eventInfo.id);     
            
            Booth_Map__c    BoothMap=new Booth_Map__c(Name = 'Public Booth',BLN_Room__c = broom.id ,Ticket_id__c = ticket.id,Booth_Size__c = '5'  );
            insert BoothMap; 
            
            Lead_Scan__c ls=new Lead_Scan__c();
            ls.First_Name__c='testa';
            ls.Last_Name__c='testb';
            ls.Event__c=eventInfo.id;
            ls.Scanner_Company__c=companyInfo.id;
            ls.Scanner_User__c=gnUserInfo.id;
            ls.BLN_TKT_profile__c = tktprof.Id;
            ls.Lead_Email__c = tktprof.email__c;
            ls.Title__c ='assa';
            ls.Cell_Phone__c = '1234567890';
            ls.Company__c = 'dsdsf';
            ls.Lead_Status__c = 'Active';
            ls.Scan_Time__c = system.now();
            insert ls;
            
            PageReference pageRef1 = Page.BLN_ScansforAttendees;
            Test.setCurrentPage(pageRef1);
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
        
            BLN_ScansforAttendeesCon sfaCon=new BLN_ScansforAttendeesCon(); 
            sfaCon.fromVal=Datetime.parse('11/11/2014 03:15 AM');
            sfaCon.toVal=Datetime.parse('11/11/2015 06:15 PM');
            sfaCon.go();
            sfaCon.mainMethod();
            Apexpages.currentPage().getParameters().put('scanee',ls.BLN_TKT_profile__c);
            sfaCon.scanDetails();
            sfaCon.displayPermissions();
            sfaCon.displayPermissions1();
            
            
            apexpages.currentpage().getparameters().put('selectedck',ls.BLN_TKT_profile__c+'\"\'[]');
            apexpages.currentpage().getparameters().put('unchecked','[\"\'\'\"]');
            apexpages.currentpage().getparameters().put('type','Summary');
            apexpages.currentpage().getparameters().put('searchkey','');
            apexpages.currentpage().getparameters().put('fromVal',null);
            apexpages.currentpage().getparameters().put('selectAll','false');
            apexpages.currentpage().getparameters().put('toVal',null);
            sfaCon.exportMethod();
            sfaCon.printReport();
            sfaCon.exportReport();
            apexpages.currentpage().getparameters().put('type','Detail');
            sfaCon.exportMethod();
            apexpages.currentpage().getparameters().put('selectAll','true');
            sfaCon.exportMethod();
            sfaCon.printReport();
            sfaCon.exportReport();
            apexpages.currentpage().getparameters().put('type','Summary');
            sfaCon.exportMethod();
            sfaCon.exportAll();
            sfaCon.exportallmethod();
   }
}
}