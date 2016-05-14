@istest
public class Test_BLN_ASC_ChangePassword{
    static testmethod void Test_BLN_ASC_ChangePassword(){
    globalForTestClass globalTest= new globalForTestClass();
   Profile p = [select id from profile where name='System Administrator'];
         userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
         
  
         User u = new User(alias = 'Tes3t', email='testc3ode123x1@noemail.com',
                           emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',password__c='rajendra',
                           timezonesidkey='America/Los_Angeles', username='testc3ode123x1@noemail.com');
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
            
            System.RestContext.request = new RestRequest();
            RestContext.request.addParameter('UserId',u.id);
             RestContext.request.addParameter('Password','123rajendra');
             BLN_ASC_ChangePassword ps= new BLN_ASC_ChangePassword();
             BLN_ASC_ChangePassword.doGet();
             RestContext.request.addParameter('UserId',u.id);
             RestContext.request.addParameter('Password','testc3ode123x1');
             try{
              BLN_ASC_ChangePassword.doGet();
              }
              catch(Exception e){}
            }
            }
            }