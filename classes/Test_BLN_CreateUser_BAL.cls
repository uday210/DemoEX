@istest
public class Test_BLN_CreateUser_BAL{
    static testmethod void Testmethod_BLN_CreateUser_BAL(){
    User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        U= globalTest.createUser();
        
               Profile pq = [select id from profile where name='System Administrator'];
               userRole rs=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
               User u_s = new User(alias = 'Test', email='vstestv@noemail.com',
                           emailencodingkey='UTF-8',profileid = pq.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                           localesidkey='en_US',country='United States Of America', userRoleId= rs.id, CompanyName= 'GlobalNest',
                           timezonesidkey='America/Los_Angeles', username='vstestv@noemail.com');
       
        system.runas(U){
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            NAICS_Code__c naicsCodeInfo1= new NAICS_Code__c();
            naicsCodeInfo1= globalTest.createNaicsCode();

            NAICS_Code__c naicsCodeInfo2= new NAICS_Code__c();
            naicsCodeInfo2= globalTest.createNaicsCode();
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
               BLN_User_DAO blnuserDao = new BLN_User_DAO();
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();  
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);  
            
            Company_Ext__c cec = new Company_Ext__c(); 
            cec = globalTest.createCompanyExt(companyInfo.Id, naicsCodeInfo1.Id, naicsCodeInfo2.Id, countryInfo.Id, stateInfo.Id);
            
            contact Con = new Contact();
            Con.Lastname = u.FirstName;
            Con.Firstname =u.LastName; 
            con.email = u.email;
                      
            Profile P = [SELECT Id,Name FROM Profile WHERE Name = 'Event Admin1'];
            U.Alias = 'EAdmin';
            U.ProfileID = P.id;
            
            U.CommunityNickname = String.valueOf(math.random());
            U.LocaleSidKey = 'en_US';
            U.LanguageLocaleKey = 'en_US';
            U.TimeZoneSidKey = 'America/Los_Angeles';
            U.EmailEncodingKey='UTF-8';
            U.Username = u.email;
            U.Email = u.Email;
             
            
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(U,countryInfo.Id,stateInfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);   
                     
            Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
           
            UC_Role__c ucRoleInfo= new UC_Role__c();
            ucRoleInfo= globalTest.createUCRole(companyInfo.Id, eventInfo.Id, gnUserInfo.id, u.Id, roleInfo.Id);    
            
            BLN_CreateUser_BAL bl = new BLN_CreateUser_BAL();  
                BLN_CreateUser_BAL.updateUserStatus(u.Id,'aaaaa');
                bl.CheckUserEmailExists(U,companyInfo,cec);
                 bl.CheckUserEmailExists(u_s ,companyInfo,cec);
            }
            }
            }