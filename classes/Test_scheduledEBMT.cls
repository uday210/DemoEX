@isTest
public class Test_scheduledEBMT{
public static testmethod void Test_scheduledEBMT(){
 globalForTestClass globalTest= new globalForTestClass();
 Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
  
         User u = new User(alias = 'Tes6t', email='atestcbar6ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTersting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='atestc6ode123x1@noemail.com');
                           
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
            
            string no='1';
            string opt='Day';
            
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             bln_event__c bec=[select id,name,last_refreshed_time__c from bln_event__c where id=:eventInfo.id];
             bec.last_refreshed_time__c = string.valueof(system.now());
             update bec;
             
             String schedule = '0 0 0 1 1 ? 2025';
             /*scheduledEBMT sc = new scheduledEBMT('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX',item.id,eventInfo.id,no,opt);
             system.schedule('scheduledEBMT', schedule, sc);
             
             string opt1='Hour';
             scheduledEBMT sc1 = new scheduledEBMT('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX',item.id,eventInfo.id,no,opt1);
             system.schedule('scheduledEBMT', schedule, sc1);
             
             string opt2='Minute';
             scheduledEBMT sc2 = new scheduledEBMT('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX',item.id,eventInfo.id,no,opt2);
             system.schedule('scheduledEBMT', schedule, sc2);*/
             
             string no3='59';
             string opt3='Second';
             scheduledEBMT sc3 = new scheduledEBMT('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX',item.id,eventInfo.id,no3,opt3);
             system.schedule('scheduledEBMT', schedule, sc3);

             }
            }
           }