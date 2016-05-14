@isTest(SeeAllData=true)
public class Test_BLN_ASC_DeleteEvents
{
 
    static testmethod void Testmethod_BLN_ASC_DeleteEvents()
        {

            // User U= new User();
             globalForTestClass globalTest= new globalForTestClass();
            // U= globalTest.createUser();
            
             Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         // ------------------ Eventadmin Insert ---------------------

         User u = new User(alias = 'Test', email='testcode1235@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='testcode1235@noemail.com');
         database.insert(u,false);
        
           
            
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
                
                system.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD '+u);
                GN_User__c  gnUser= new GN_User__c();
                gnUser= globalTest.createGNUser(U,countryInfo.Id, Stateinfo.Id);
                
                
                
                    BLN_Event__c eventInfo= new  BLN_Event__c();
                    eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
                    Role__c role = new Role__c();
                    role.Name = 'Company Admin';
                    insert(role) ;   
                    
                  UC_Role__c ucro = new UC_Role__c();
                  ucro.GN_User__c= gnUser.id;
                  ucro.event__c = eventInfo.id;
                  ucro.RoleId__c= role.id;
                  ucro.company__c = companyInfo.id;
                  insert ucro;
                    
                           System.RestContext.request = new RestRequest();
                     
                                    string Eventid = eventInfo.id;
                                    string Eventstatus='draft';
                                    
                                     RestContext.request.requestURI ='/GlobalnestEM/BLN_ASC_DeleteEvents';
                                      RestContext.request.addParameter('Event_id',Eventid );
                                       RestContext.request.addParameter('Eventstatus','Deleted');

                                      BLN_ASC_DeleteEvents.doPost();
                                      
                                }
         }

}