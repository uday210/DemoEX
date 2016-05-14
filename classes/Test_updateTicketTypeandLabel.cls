@isTest
public class Test_updateTicketTypeandLabel{
    static testmethod void Testmethod_updateTicketTypeandLabel(){
        system.debug('EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE ');
       // User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
       // U= globalTest.createUser();
        
         // User u= new User();
         Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         // ------------------ Eventadmin Insert ---------------------

         User u = new User(alias = 'Test', email='testcode1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1@noemail.com');
         database.insert(u);
        
        
        system.runas(U){
              Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
           
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u, countryInfo.Id, stateInfo.Id);
          
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();
            
            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);               
            
                        
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
           
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
             
            Item_Pool__c ItemPool1= new Item_Pool__c();
            ItemPool1= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
            
          
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
           
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.id, NULL, NULL, 'Registration Tab', 'GN_Fist_name__c');
                        
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.id, NULL, NULL, 'Registration Tab','GN_Last_name__c');
            
            Reg_Setting__c regSettingsInfo3= new Reg_Setting__c();
            regSettingsInfo3= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL, 'Regular','GN_Last_name__c');
            
            Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(u);

            Hash_Tag__c hashT=new Hash_Tag__c();
            hashT=globalTest.createHashTag(eventInfo.id);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(tktprof.Id, u.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            BLN_Room__c roomInfo= new BLN_Room__c();
            roomInfo= globalTest.createRoom(eventInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.id);
           
            
            LIST<Item_Pool__c > insertItems= new LIST<Item_Pool__c >();
             
            Agenda__c agendaInfo= new Agenda__c();
            agendaInfo= globalTest.createAgenda(eventInfo.Id, trackInfo.Id);

            Time_Slots__c timeslotss = new Time_Slots__c();
            timeslotss = globalTest.createTimeSlot(agendaInfo.Id, roomInfo.Id);
           
           Test.startTest(); 
            
            
            Item_Pool__c insertItemPool= new Item_Pool__c();               
            insertItemPool.Event__c= eventinfo.id;
            insertItemPool.Item_Pool_Name__c= 'ItemPool';
            insertItemPool.item_type__c= itemType.Id;
            insertItemPool.Item_Count__c= 12;
            insertItemPool.Addon_Parent__c= ItemPool.Id;
            insertItemPool.Track__c= trackInfo.id;
            insertItemPool.Addon_Count__c= 4;
            
             Item_Pool__c insertItemPool2= new Item_Pool__c();               
            insertItemPool2.Event__c= eventinfo.id;
            insertItemPool2.Item_Pool_Name__c= 'ItemPool';
            insertItemPool2.item_type__c= itemType.Id;
            insertItemPool2.Item_Count__c= 12;
            insertItemPool2.Addon_Parent__c= ItemPool.Id;
            insertItemPool2.Track__c= trackInfo.id;
            insertItemPool2.Addon_Count__c= 4;
        
            insertItems.add(insertItemPool);
            insertItems.add(insertItemPool2);
            
             Item_Type__c insertItemType1= new Item_Type__c();
                insertItemType1.Name= 'Admissions';
                insertItemType1.Badge_Label__c= 'Attendee';
                insertItemType1.Order__c= 22.12;
                insertItemType1.Add_On__c= TRUE;
                insertItemType1.Unlimited__c=false;
        
        insert insertItemType1;
        

             
           dataBase.saveResult[] res =  Database.insert(insertItems, True);
           SET<id> ids  = new SET<id>();
             system.debug('QQQQQQQQQQQQQQ  '+insertItems);
            for(dataBase.saveResult re :res ){
              if(re.isSuccess()){
                ids.add(re.getId());
              }
            }
            
              try{
            
        Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, insertItemPool.id, itemType.Id, insertOrder1.Id, tktprof.id);
            
         Ticket__c ticket2= new Ticket__c();
            ticket2= globalTest.createTicket(eventInfo.id, item.Id, insertItemPool2.id, itemType.Id, insertOrder1.Id, tktprof.id);  
        
           
           
             list<Ticket__c> ticketslist = new list<Ticket__c>();
           
            ticketslist.add(ticket1);
             ticketslist.add(ticket2);
                  
           }catch(exception e){}
            
           List<Item_Pool__c> itemList = new List<Item_Pool__c>(); 
           for(Item_Pool__c  ite : [select id,item_type__c from Item_Pool__c where id In :ids ] ){
           ite.item_type__c  = insertItemType1.id;
            itemList.add(ite);
           } 
             
            //MAP<ID, BLN_Item__c> newitemsMAP = new MAP<ID, BLN_Item__c>();
            system.debug('EEEEEEEEEEE '+itemList);
           //BLN_ReUse_EventsEditCon.firstRun =true;
             Database.update(itemList, false);
             Test.stopTest();
            
            
            
            
            
            }
       }
}