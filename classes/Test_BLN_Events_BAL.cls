@isTest(seeAllData=True)
public class Test_BLN_Events_BAL{

static testmethod void Test_BLN_Events_BAL(){

   User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
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
            
           
           
            BLN_Event__c insertEvent= new BLN_Event__c();
                    insertEvent.Name= 'testevent';
                    //insertEvent.Start_Date__c= system.today();
                    //insertEvent.End_Date__c= system.today()+4; 
                    //insertEvent.Start_Time__c= '7:00 AM';
                    //insertEvent.End_Time__c= '4:00 PM'; 
                    insertEvent.venue_name__c= 'Hyderabad';
                    insertEvent.Organizer_Email__c= 'testmk@gmail.com';
                    insertEvent.organizer_id__c= companyInfo.id;
                    insertEvent.BLN_State__c= stateInfo.id;
                    insertEvent.BLN_Country__c= countryInfo.id;
                    insertEvent.Logo_URL__c = '015c0000000IAj8';
                    insertEvent.Event_Ticket_Options__c='Collect info from Buyers only';
           
            list<BLN_Event__c> eventInfo = new list<BLN_Event__c>();
            eventInfo.add(insertEvent);
                  BLN_Events_BAL  event= new BLN_Events_BAL ();  
                        try{
                        event.createEvent(eventInfo,'testcomp',string.valueof(companyInfo.id),userForGN.id,gnUser.id);
                        }catch (Exception e){}
                        event.listOfEvents(userForGN.ID);
                        event.roles(userForGN.ID);
                        try{
                        event.createEvent(eventInfo,'testcomp','',userForGN.id,gnUser.id);
                        }catch (Exception e){}
                         try{
                        event.createEvent(eventInfo,'','',userForGN.id,gnUser.id);
                        }catch (Exception e){}
    }
    }
    }