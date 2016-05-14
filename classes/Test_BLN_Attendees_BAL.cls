@istest
public class Test_BLN_Attendees_BAL {
    static testmethod void Testmethod_BLN_BLN_Attendees_BAL(){
    
    
    //User U= new User();
    globalForTestClass globalTest= new globalForTestClass();
    //U= globalTest.createUser();
    
    Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];
        // ------------------ Eventadmin Insert ---------------------
        
        User u = new User(alias = 'Test', email='testcofvsgsde@noemail.com',
        emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
        localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
        timezonesidkey='America/Los_Angeles', username='testcofvsgsde@noemail.com');
       database.insert(u);

    
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
            
            list<BLN_Event__c> sce = new list<BLN_Event__c>();
            sce.add(eventInfo);
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            GN_User__c  gnUser= new GN_User__c();
            gnUser= globalTest.createGNUser(u,countryInfo.Id, Stateinfo.Id);          
       
                       
            Item_Type__c itemType= new Item_Type__c();
            itemType= globalTest.createItemType();
            
            BLN_Track__c trackInfo= new BLN_Track__c();
            trackInfo= globalTest.createTrack(eventInfo.id);
          
          
            Item_Pool__c ItemPool= new Item_Pool__c();
            ItemPool= globalTest.createItemPool(eventInfo.id, itemType.Id, NULL,trackInfo.Id);
            
            BLN_Item__c item= new BLN_Item__c();
            item= globalTest.createItem(ItemPool.Id, itemType.Id, eventInfo.id);
            
            Order__c insertOrder1= new Order__c();
             Tkt_profile__c  tktprof = new Tkt_profile__c();
  tktprof =globalTest.createTktprofile(userForGN);

            insertOrder1= globalTest.createOrder(tktprof.Id, userForGN.id, companyInfo.Id, eventInfo.Id, currenyInfo.Id);
            
            Ticket__c ticket= new Ticket__c();
            ticket= globalTest.createTicket(eventInfo.id, item.Id, itemPool.Id, itemType.Id,insertOrder1.Id,tktprof.id);
            
            Hash_Tag__c HTag = new Hash_Tag__c ();
            HTag = globalTest.createHashTag(eventInfo.id);
            
            BLN_Attendees_BAL  bab = new BLN_Attendees_BAL();
            try{
            bab.getAllTickets(u.id,eventInfo.id);
            BLN_MyticketsCon.surveyCls bbb= new BLN_MyticketsCon.surveyCls();
            bab.modifySurveyAnswers(ticket.id,eventInfo.id,bbb,'test');
            //bab.surveyAnswersUpsertion();
            }catch(exception e){}
     
        
    }
    
   } 
     
   }