@isTest
public class Test_BLN_UserEvents{
    static testmethod void Testmethod_BLN_UserEvents(){
        
        // User U= new User();
        globalForTestClass globalTest= new globalForTestClass();
        //U= globalTest.createUserForGNUser();        
        Profile p = [select id from profile where name='System Administrator'];
        userRole r=[SELECT ID FROM userRole WHERE name =: 'CEO'];   
        // ------------------ Eventadmin Insert ---------------------
        
        User u = new User(alias = 'Test', email='testcodefd@noemail.com',
                          emailencodingkey='UTF-8',profileid = p.Id,lastname='codeTesting', Firstname='codeTesting', languagelocalekey='en_US',
                          localesidkey='en_US',country='United States Of America', userRoleId= r.id, CompanyName= 'GlobalNest',
                          timezonesidkey='America/Los_Angeles', username='testcodefd@noemail.com');
        database.insert(u,false);
        
        system.runas(U){
            
            
            Company__c companyInfo= new Company__c();
            companyInfo= globalTest.createCompany(u.Companyname);
            
            Currency__c currenyInfo= new Currency__c();
            currenyInfo= globalTest.createCurrency();             
            
            Country__c countryInfo= new Country__c();
            countryInfo= globalTest.createCountry(currenyInfo.Id);  
            
            State__c stateInfo= new State__c ();
            stateInfo= globalTest.createState(countryInfo.Id);     
            
               
           
            
            
            
            User userForGN= new User();
            userForGN= globalTest.createUserForGNUser();
            
            User userInfo = new User();
            userInfo = globalTest.createUser();     
            
            GN_User__c  gnUserInfo= new GN_User__c();
            gnUserInfo= globalTest.createGNUser(u, countryInfo.Id, stateInfo.Id);
            
            BLN_Event__c eventInfo= new  BLN_Event__c();
            eventInfo= globalTest.createEvent(countryInfo.Id, Stateinfo.Id ,CompanyInfo.id);     
            
            Role__c roleInfo= new Role__c();
            roleInfo= globalTest.createRole();
            
            UC_Role__c ucRoleInfo= new UC_Role__c();
            ucRoleInfo= globalTest.createUCRole(companyInfo.Id, eventInfo.Id, gnUserInfo.id, u.Id, roleInfo.id);  
            
            folder fdd = new folder (id='00lF0000001VI7Y',Name='a1RM0000001hArnMAE.png');
            
            
            
            BLN_UserEvents userEvents= new BLN_UserEvents();
            
            userEvents.noevent();
            ApexPages.CurrentPage().getParameters().put('EventName',eventInfo.Id); 
            userEvents.manageEvent();
            
            ApexPages.CurrentPage().getParameters().put('EventName',eventInfo.Id);             
            userEvents.Editevent();
            
             //string test='mytest';
             document dd= new document();
             dd.name='gntest';
             dd.ispublic = true;
             dd.folderid ='00lF0000001VI7Y';
             insert dd;
             userEvents.mydoc =dd;
             String etest='globalnest';
             
             
            Blob myBlob = Blob.valueof(etest);
            userEvents.eventImage=myBlob;
            
            //userEvents.mydoc.body = eventImage;
                     //if(folderList.size()>0){
           // userEvents.mydoc.folderid ='00lF0000001VI7Y';
                       //}
            //userEvents.mydoc.ispublic = true;
            userEvents.eventImageName ='globalnest';
           // userEvents.mydoc.Name = userEvents.eventImageName;
           //insert mydoc;
           BLN_Event__c Eventedit  =new BLN_Event__c();
            userEvents.Eventedit.Logo_URL__c = dd.id;
             
            
            userEvents.UpdateEvent();
            userEvents.deleteparamval();
            ApexPages.CurrentPage().getParameters().put('EventName',eventInfo.Id);             
            userEvents.deleteEvent(eventInfo.Id);
            
            userEvents.cancel();
            ApexPages.CurrentPage().getParameters().put('EventName',eventInfo.Id);                         
            userEvents.myTickets();
            /*
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            */
            BLN_UserEvents userEvents1= new BLN_UserEvents();
            userEvents1.Userid=u;
            userEvents1.serchEvent='evtsrcE';
            userEvents1.eventImageName='evtimgN';
            userEvents1.EventsList.clear();
            //Userinfo.getProfileId() = '00eF000000146R4IAI';
            cookie  counter = new Cookie('counter',eventInfo.id,null,-1,false);
            ApexPages.currentPage().setCookies(new Cookie[]{counter}); 
            userEvents1.noevent();
            
              
         
        }
    }
    
}