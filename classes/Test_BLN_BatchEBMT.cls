@isTest
public class Test_BLN_BatchEBMT{
public static testmethod void Test_BLN_BatchEBMT(){
 globalForTestClass globalTest= new globalForTestClass();
 Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
        
  
         User u = new User(alias = 'Tes6t', email='batestcbar6ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTersting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='batestc6ode123x1@noemail.com');
                           
                            system.runas(U){
                            
                            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            Company__c companyInfo= new Company__c();
            
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();   
            
             Currency__c currenyInd= new Currency__c();
            currenyInd.Name = 'INR';
             currenyInd.Currency_Name__c  = 'Indian Rupee';   
             currenyInd.Currency_Symbol__c  = 'Rs';
             insert currenyInd;
             system.debug('-------Currency--Ind- '+currenyInd);
         
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
                Country__c Ind = new Country__c(); 
              
                
                Ind.Long_Name__c = 'India';
                Ind.Short_Name__c= 'IN';
                Ind.Currency__c= currenyInd.Id;
                Ind.Order__c= 97;
                insert Ind;
                
                Country__c shortcntry = new Country__c(); 
                shortcntry.Long_Name__c = 'India';
                shortcntry.Short_Name__c= 'India';
                shortcntry.Currency__c= currenyInd.Id;
                shortcntry.Order__c= 97;
                insert shortcntry;
       //Currency__c, Long_Name__c, Short_Name__c
    
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);
            
            
            State__c statebngl = new state__c();
            
            statebngl.Country__c= Ind.Id;
            statebngl.Long_Name__c= 'West Bengal';
            statebngl.Order__c= 123;
            statebngl.Short_Name__c= 'WB';
            insert statebngl;

            
            GN_User__c  gnUser= new GN_User__c();
            gnUser = globalTest.createGNUser(userForGN,countryInfo.Id, Stateinfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
              Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
  tktprof =globalTest.createTktprofile(userForGN);
             
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            itemType.Item_Type_Number__c='IT-000010';
            update itemType;
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.Id);
            
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL, trackInfo.Id);

            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Event_Price__c itmprc = new Event_Price__c();
             itmprc = globalTest.createEventPrice(eventInfo.Id, itemType.Id);
            
            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
             bln_event__c bec=[select id,name,last_refreshed_time__c from bln_event__c where id=:eventInfo.id];
             bec.last_refreshed_time__c = string.valueof(system.now());
             update bec; 
             Ticket__c ticket1= new Ticket__c();
            ticket1= globalTest.createTicket(eventInfo.id, item.Id, ItemPool.Id, itemType.Id, insertOrder1.Id, tktprof.Id);
            Ticket__c ticketupd= [select id from Ticket__c where id=:ticket1.id];
            ticketupd.Ticket_Status__c = 'Available';
            update ticketupd;
             string dt =  string.valueof('2016-03-21 08:47:01');
           
               try{
              
             Test.startTest() ;
            
             
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseBatchEBMTGenerator());
            Id batchinstanceid = database.executeBatch(new BLN_BatchEBMT ('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX',dt,item.id,eventInfo.id)  ,2);    
           BLN_BatchEBMT b=new BLN_BatchEBMT ('00D280000017J30!AQ0AQDDm9biJkw4c.Jk35xiSm9a6stN.bEVP0SE4unFZQFuW9RiOVIDAZ4nSLOS.zDqz3cbF0tLvnFTFmSAD7..oTZVYB9oX',dt,item.id,eventInfo.id);
           List<Participant> plist=new List<Participant>();
            Participant g=new Participant();
            g.identifier='1';
            g.FirstName='abc';
            g.LastName='Def';
            g.email='test@noemail.com';
            g.statusCode='Confirmed';
            g.Country='India';
            g.State='West Bengal';
            g.City='Kolkata';
            g.ZipCode='700001';
            g.Title='';
            g.CompanyName='G';
            
            Participant gn=new Participant();
            gn.identifier='1';
            gn.FirstName='abc';
            gn.LastName='Def';
            gn.email='test@email.com';
            gn.statusCode='Confirmed';
            gn.Country='India';
            gn.State='WB';
            gn.City='Kolkata';
            gn.ZipCode='700001';
            gn.Title='';
            gn.CompanyName='G';
            
            plist.add(g);
            plist.add(gn);
            Database.BatchableContext t;
           b.execute(t,plist);
           b.finish(t);
            Test.stopTest() ;
              }catch(Exception e){}
             }
            }
            
           }