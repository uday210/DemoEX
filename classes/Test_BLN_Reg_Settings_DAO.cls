@isTest
public class Test_BLN_Reg_Settings_DAO{

 static testmethod void Testmethod_BLN_Reg_Settings_DAO(){
 
  
    //User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
     //   U= globalTest.createUser();        
        
            Profile p = [select id from profile where name='System Administrator'];
            userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         

            User u = new User(alias = 'Test', email='testcode1235689@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1235689@noemail.com');
            Database.insert(u);
        
        
        
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
            
            BLN_BadgeTemplate_Styles__c badTStyleInfo=new BLN_BadgeTemplate_Styles__c();
            badTStyleInfo=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            
            
            
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            Order__c insertOrder1= new Order__c();
            insertOrder1= globalTest.createOrder(null, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);
            
            Item_Pool__c ItemPool2= new Item_Pool__c();
            ItemPool2= globalTest.createItemPool(eventInfo.id, itemType.Id, ItemPool.Id, trackInfo.Id);
           
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Ticket__c ticket= new Ticket__c();
                
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id,null);
            Ticket__c insertTicket  = [select id,Name,Badge_Label__c,Tag_No__c,tkt_profile__r.BLN_GN_User__c,Item__c,Event__c
                                       from Ticket__c where id =:ticket.id];
                
            Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id,null);
                
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
                       
            
            
            
            BLN_BadgeTemplate_Styles__c badTempStyl=new BLN_BadgeTemplate_Styles__c ();
            badTempStyl=globalTest.createBadgeTemplateStyle(eventInfo.id);
            
            Badge__c bdg= new Badge__c();
            bdg=globalTest.createBadge(insertTicket.id);
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            Reg_Setting__c regSettingsInfo4= new Reg_Setting__c();
            regSettingsInfo4= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, NULL,'Regular', 'AS_Last_Name__c');
            
            
                
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool2.Id, item.Id, companyInfo.Id, NULL, 'Regular', 'AS_Last_Name__c');
            
            list<Reg_Setting__c> regsettinginfo3 = new list<Reg_Setting__c>();
            regsettinginfo3.add(regSettingsInfo1);
            regsettinginfo3.add(regSettingsInfo2);
            
            
            set<id> setid = new set<id>();
             setid.add(item.id);   
                      
            list<id> listid = new list<id>();
            listid.add(item.id);
             
            list<id> lstid = new list<id>();
            
            lstid.add(ItemPool.id);          
           lstid.add(ItemPool2.id); 
            
            BLN_Reg_Settings_DAO regsettings = new BLN_Reg_Settings_DAO();
            
            regsettings.deleteRegset(regsettinginfo3);
            regsettings.insRegset(regsettinginfo3);
            regsettings.updateSet(regsettinginfo3);
            regsettings.getregsetlist(eventInfo.Id);
            
            //try{
            regsettings.itemSettings(lstid);
           // }
           // catch (exception eee) 
           // {}
            
            regsettings.getregsettingslist(eventInfo.Id);
            regsettings.attendeeSettingsSetUp(eventInfo.Id);
            regsettings.setsResitem('all',item.id);
            regsettings.setsResevent('all',item.id);
            regsettings.bookedRegSettingList(setid,eventInfo.Id); 
             regsettings.getMobileSettings(eventInfo.Id);
              regsettings.getMobileSettings(eventInfo.Id,null);
 
             regsettings.getMobileSettings(eventInfo.Id, system.now());
             regsettings.getItemtypeRegSetList(eventInfo.Id);
             regsettings.getrestrationlinksettings(eventInfo.Id);
             regsettings.getEventdexAppDefaultSettings();
 
  }
 }
}