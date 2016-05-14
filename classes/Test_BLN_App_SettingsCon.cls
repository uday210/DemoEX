@isTest(seeAllData=true)

public class Test_BLN_App_SettingsCon {
    
    static testMethod void testMethod_BLN_App_SettingsCon(){
        
        // User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        // U= globalTest.createUser();
        
        Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
        
        
        User u = new User(alias = 'appsett', email='appsett12@noemail.com',
                          emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                          localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                          timezonesidkey='America/Los_Angeles', username='appsett12@noemail.com');
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
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id,Order_Status__c='Fully Paid');
            //insertOrder1.Client_GN_User__c = gnUser.Id;
            //insertOrder1.Client_Company__c= companyInfo.Id;
            //insertOrder.Client_User__c= userId;
            insertOrder1.Events__c= eventInfo.Id;
            insertOrder1.Order_Total__c= 2;
           
            insertOrder1.Amount_Paid__c= 25.12;
            insertOrder1.Fee_Amount__c= 23.29;
            insertOrder1.Currency_Code__c= currenyInfo.Id;
            insertOrder1.Order_Status__c='Fully Paid';
            insert insertOrder1;      
            
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
            
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            // ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, gnUser.Id);
            
            ticket.Event__c = eventInfo.id;
            ticket.Item__c = item.Id;
            ticket.Item_Pool__c = itemPool.Id;
            ticket.Item_Type__c = itemType.Id;                    
            ticket.Badge_Label__c =  'badgeLabel';
            ticket.Order__c= insertOrder1.Id;
            ticket.Ticket_Status__c= 'Available';
            //ticket.Client_GN_User__c = gnUser.Id;
            insert ticket;
            
            Reg_Setting__c rsett = new Reg_Setting__c();
            rsett.Column_Name__c = 'MatchLeads Buyer';
            rsett.Event__c = eventInfo.id;
            rsett.Label_Name__c = 'Speakers';
            rsett.Included__c =true;
            rsett.Setting_Type__c='Eventdexapp';
            insert rsett;
            
            Reg_Setting__c rsett1 = new Reg_Setting__c();
            rsett1.Event__c = eventInfo.id;
            rsett1.Label_Name__c = 'Lead Retrieval';
            rsett1.Defaullt_Label__c = 'Lead Retrieval';
            rsett1.Included__c =true;
            rsett1.Setting_Type__c='Eventdexapp';
            insert rsett1;
            
            Reg_Setting__c rsett2 = new Reg_Setting__c();
            rsett2.Event__c = eventInfo.id;
            rsett2.Label_Name__c = 'With Push Notification';
            rsett2.Defaullt_Label__c = 'With Push Notification';
            rsett2.Included__c =true;
            rsett2.Setting_Type__c='Eventdexapp';
            insert rsett2;
            
            Reg_Setting__c rsett3 = new Reg_Setting__c();
            rsett3.Event__c = eventInfo.id;
            rsett3.Label_Name__c = 'With QR Code';
            rsett3.Defaullt_Label__c = 'With QR Code';
            rsett3.Included__c =true;
            rsett3.Setting_Type__c='Eventdexapp';
            insert rsett3;
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            boolean MMBuyerflag=true;
            BLN_App_SettingsCon blnappsett = new BLN_App_SettingsCon();
            blnappsett.selectedGnId=gnUser.id;
            blnappsett.selectAct();
            blnappsett.saveSettings();
            blnappsett.saveAppSettings();
            blnappsett.saveBlsettigs();
            BLN_App_SettingsCon.inncls ins = new BLN_App_SettingsCon.inncls(rsett);
            BLN_App_SettingsCon.inncls ins1 = new BLN_App_SettingsCon.inncls(rsett1);
            
            list<BLN_App_SettingsCon.inncls> listins = new list<BLN_App_SettingsCon.inncls>();
            listins.add(ins);
            listins.add(ins1);
            blnappsett.savingSetts(listins);
            blnappsett.cancelAppSettings();
            
            BLN_Scanusr_Settings_BAL scbal = new BLN_Scanusr_Settings_BAL();
            //scbal.getEventItems(eventInfo.id);
    }

}
}