@istest
public class Test_BLN_Displaysettingscon{
    static testmethod void Testmethod_BLN_Displaysettingscon(){
        
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
              
            Hash_Tag__c tagInfo1= new Hash_Tag__c();
            tagInfo1= globalTest.createTag(eventInfo.Id);
            
            Hash_Tag__c tagInfo2= new Hash_Tag__c();
            tagInfo2= globalTest.createTag(eventInfo.Id);
            
             
           
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN, countryInfo.Id, stateInfo.Id);
            
            
            //Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
           Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            
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
                       
              Reg_Setting__c regSettingsInfo1= new Reg_Setting__c();
            regSettingsInfo1= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, tagInfo1.Id, 'Registration Tab', 'GN_Fist_name__c');
            
             
            Reg_Setting__c regSettingsInfo2= new Reg_Setting__c();
            regSettingsInfo2= globalTest.createRegSettings(eventInfo.Id, NULL, NULL, NULL, tagInfo2.Id, 'Registration Tab','GN_Last_name__c');
                       
            Order_Item__c orderItem= new Order_Item__c();
            orderItem= globalTest.createOrderItem(item.Id, insertOrder1.Id, null, currenyInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            
           
           
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
             regSettingsInfo1.Table_Name__c='Item_Type__c';
            BLN_Displaysettingscon displaySettingsCon= new BLN_Displaysettingscon();
            displaySettingsCon.displayPermissions();
            displaySettingsCon.cancelmethod();
            ApexPages.CurrentPage().getParameters().put('chkArray','Att Tab1!@#'+tagInfo1.id+'123543-Corp Tab1!@#'+tagInfo2.Id);
            ApexPages.CurrentPage().getParameters().put('tabschkdval','TRUE');
            displaySettingsCon.savemethod();
            ApexPages.CurrentPage().getParameters().put('addrow','0');
            displaySettingsCon.addrow();
            ApexPages.CurrentPage().getParameters().put('inputval','1');
            ApexPages.CurrentPage().getParameters().put('deleterow','1');
            displaySettingsCon.deleterec();
            //displaySettingsCon.TicketTypeSetting tcc = new BLN_Displaysettingscon.TicketTypeSetting('attendee','attendee',true,true);
           // ApexPages.CurrentPage().getParameters().put('gn','Basic Information');            
            
        }            
   }
}