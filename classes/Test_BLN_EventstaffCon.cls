@istest
public class Test_BLN_EventstaffCon{
    static testmethod void Testmethod_BLN_EventstaffCon(){
    
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
            
            Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
            
            Company_Ext__c companyExtInfo= new Company_Ext__c();
            companyExtInfo= globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id);             
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);  
             
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);              
             
             
            Role__c roleid = new Role__c();
            roleid.Name = 'Full Admin';
            
            insert roleid;
           
           
            UC_Role__c UCR = new UC_Role__c();
            UCR.Company__c = companyInfo.id;
            UCR.RoleId__c = roleid.id;
            UCR.GN_User__c = gnUser.id;
            UCR.Event__c = eventInfo.id;
            
            insert UCR;
            
            
                     
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
           // Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUser.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             Tkt_profile__c  tktprof = new Tkt_profile__c();
            tktprof=globalTest.createTktprofile(userForGN);
            
            Order__c insertOrder1= new Order__c();
            //insertOrder1= globalTest.createOrder(gnUserInfo.Id, userInfo.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            //insertOrder1.BLN_tkt_profile__c= tktprof.id;
            //update insertOrder1;
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id,insertOrder1.Id,tktprof.id);
            
            Hash_Tag__c HTag = new Hash_Tag__c ();
            HTag = globalTest.createHashTag(eventInfo.id);
            
            //ItemPool_Tag_Junction__c Tagjun = new ItemPool_Tag_Junction__c ();
            //Tagjun = globalTest.createtagjunction(itemPool.Id,HTag.id);
            
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter});
            
            ApexPages.Currentpage().getparameters().put('UCID',UCR.id);
            
            BLN_EventstaffCon Eventstaff = new BLN_EventstaffCon();
            Eventstaff.AddStaff();
            Eventstaff.selectedItem=item.id;
            try{
            Eventstaff.saveStaff();
            }catch(Exception e){}
            Eventstaff.cancel();
            Eventstaff.editstaff();
             //Eventstaff.saveStaff();
           // Eventstaff.AddStaff();
            //Eventstaff.selecteditem = item.id;
           // Eventstaff.saveStaff();
           // Eventstaff.cancel();
           // Eventstaff.editstaff();
            
            
            
            
            
            
            
            }
        }
    }