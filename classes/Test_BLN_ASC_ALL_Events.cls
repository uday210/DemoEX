@istest(SeeAllData=true)
public class Test_BLN_ASC_ALL_Events {
    static testmethod void Test_BLN_ASC_ALL_Events (){
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
            string sfbaseURL = URL.getSalesforceBaseUrl().toExternalForm();
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id); 
            eventInfo.Event_Approved__c=true;
            eventInfo.Event_Status__c = 'Live';
            update eventInfo;
            System.RestContext.request = new RestRequest();
            string Eventid = eventInfo.id;
           // RestContext.request.requestURI ='/GlobalnestEM/BLN_ASC_ALL_Events';
            RestContext.request.requestURI = sfbaseURL+'/services/apexrest/BLN_ASC_ALL_Events';  
            RestContext.request.httpMethod = 'POST';
            RestContext.request.addParameter('appname','WEBSITE' );
            //RestContext.request.addParameter('User_id',userForGN.Id); 
            BLN_ASC_ALL_Events eves=new BLN_ASC_ALL_Events();
            BLN_ASC_ALL_Events.dopost();    
            
            }
          }
        }