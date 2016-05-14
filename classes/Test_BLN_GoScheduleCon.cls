@isTest
public class Test_BLN_GoScheduleCon{
public static testmethod void Test_BLN_GoScheduleCon(){
 globalForTestClass globalTest= new globalForTestClass();
 Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
  
         User u = new User(alias = 'Tes6t', email='testcbar6ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTersting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='testc6ode123x1@noemail.com');
                           
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
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
              Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
  tktprof =globalTest.createTktprofile(userForGN);
             
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);

            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             bln_event__c bec=[select id,name,last_refreshed_time__c from bln_event__c where id=:eventInfo.id];
             bec.last_refreshed_time__c = string.valueof(system.now());
             update bec;
            BLN_GoScheduleCon gosc =new BLN_GoScheduleCon();
            gosc.itemName ='testItem';
            gosc.eventName = 'myevent';
            gosc.lsttime  = string.valueof(system.now());
            
             try{
     Test.startTest() ;
             Test.setMock(HttpCalloutMock.class, new MockHttpResponseGoScheduleConGenerator());
            gosc.GoSchedule();
            
     Test.stopTest() ; 
     }catch(Exception e){}
     
     try{
     gosc.UnSchedule();
     }catch(Exception e){}
     try{
     BLN_GoScheduleCon.IsLegalWindows1252(338);
     BLN_GoScheduleCon.IsLegalWindows1252(339 );
     BLN_GoScheduleCon.IsLegalWindows1252(352);
     BLN_GoScheduleCon.IsLegalWindows1252(353);
     BLN_GoScheduleCon.IsLegalWindows1252(376);
     BLN_GoScheduleCon.IsLegalWindows1252(381);
     BLN_GoScheduleCon.IsLegalWindows1252(382);
     BLN_GoScheduleCon.IsLegalWindows1252(402);
     BLN_GoScheduleCon.IsLegalWindows1252(710);
     BLN_GoScheduleCon.IsLegalWindows1252(732);
     BLN_GoScheduleCon.IsLegalWindows1252(8211);
     
     BLN_GoScheduleCon.IsLegalWindows1252(8212);
     BLN_GoScheduleCon.IsLegalWindows1252(8216);
     BLN_GoScheduleCon.IsLegalWindows1252(8217);
     
     BLN_GoScheduleCon.IsLegalWindows1252(8218);
     BLN_GoScheduleCon.IsLegalWindows1252(8220);
     BLN_GoScheduleCon.IsLegalWindows1252(8221);
     BLN_GoScheduleCon.IsLegalWindows1252(8222);
     BLN_GoScheduleCon.IsLegalWindows1252(8224);
     BLN_GoScheduleCon.IsLegalWindows1252(8225);
     
     BLN_GoScheduleCon.IsLegalWindows1252(8226);
     BLN_GoScheduleCon.IsLegalWindows1252(8230);
     BLN_GoScheduleCon.IsLegalWindows1252(8240);
     BLN_GoScheduleCon.IsLegalWindows1252(8249);
     BLN_GoScheduleCon.IsLegalXmlChar(57344 );
     BLN_GoScheduleCon.IsLegalXmlChar(1114111);
     
      BLN_GoScheduleCon.IsLegalWindows1252(8250); BLN_GoScheduleCon.IsLegalWindows1252(8364); BLN_GoScheduleCon.IsLegalWindows1252(8482);
     }catch(Exception e){}
     
     try{
   BLN_GoScheduleCon.stringToCodePoint('99999999999999999999999999999999999999999999999999999999999999999999');
   BLN_GoScheduleCon.stringToCodePoint('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF');
     }catch(Exception e){}
     
     try{
     BLN_GoScheduleCon aa = new BLN_GoScheduleCon();
     aa.opt='aaaaa';
     aa.no='ddd';
     }catch(Exception e){}
    
         }
        }
     }