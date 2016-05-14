@isTest
public class Test_insertDefaultSettings{
    static testmethod void Testmethod_insertDefaultSettings(){
        
        User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
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
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id); 
                       
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();

            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
           
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            
            Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.id, NULL, NULL, 'Display', 'Sales Message');
                        
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, ItemPool.Id, item.id, NULL, NULL, 'Event Staff','Sales Message');
            
            BLN_Event__c insertEvent= new BLN_Event__c();
            insertEvent.Name= 'Sample Event(Boothleads)';
            //insertEvent.Start_Date__c= system.today();
            //insertEvent.End_Date__c= system.today()+4; 
            //insertEvent.Start_Time__c= '7:00 AM';
            //insertEvent.End_Time__c= '4:00 PM'; 
            insertEvent.venue_name__c= 'Hyderabad';
            insertEvent.Organizer_Email__c= 'manasatest@gmail.com';
            insertEvent.organizer_id__c= companyInfo.Id;
            insertEvent.BLN_State__c= stateInfo.Id;
            insertEvent.BLN_Country__c= countryInfo.Id;
            insertEvent.Description__c= 'Sample Description';
        
            database.insert(insertEvent, FALSE);
       }
       }
       
}