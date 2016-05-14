@isTest
                                
private class TestReadAndPopulateDataBatchClass {

    static testmethod void test() {
    String s='Kris,Sorkowatz,kkk@gmail.com,HUBaazz11ttt222ggg';
 
List<String> records=new List<String>();
records.add(s);
Profile p = [select id from profile where name='Standard User'];   
            User u = new User(alias = 'test123', email='test123@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id, lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US',country='United States',
            timezonesidkey='America/Los_Angeles', username='tes98673@noemail.com');
            insert u;  
            
            account a=new account(name='govtnm');
            insert a;
            
            contact m = new contact(firstname='testcontactname',lastname='testcontactlastname');
            insert m;      
            
            user EAdmin =  new User(alias = 'testboot', email='testeventadmin@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US',country='United States',
            timezonesidkey='America/Los_Angeles', username='testeventadmin@noemail.com');
            
            insert EAdmin ;
            
            
            user bAdmin =  new User(alias = 'testboot', email='testboothadmin@noemail.com',
            emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
            localesidkey='en_US',country='United States',
            timezonesidkey='America/Los_Angeles', username='testboothadmin@noemail.com');
            
            insert bAdmin ;
            
            
            Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='1.5');        
            insert  customProfile;
            
            Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
            insert  customProfileBooth;  
            
            Profile__c customprofilebpl = new Profile__c (PR_Name__c='BoothPersonnel',PR_Version__c='1.5');
            insert customProfilebpl;
            
             Profile__c customAttendee = new Profile__c (PR_Name__c='Attendee',PR_Version__c='1.5');
            insert customAttendee;
          
            
            
            Event__c event = new Event__c(EV_Title__c = 'Test Event', StartTime__c = '09:00 AM', EV_EndTime__c='09:00 PM',EV_StartDate__c = Date.newInstance(2012,05,01),EV_EndDate__c = Date.newInstance(2012,05,01) );
            insert event;
            
            SecurityControls__c sc = new SecurityControls__c(EV_id__c = event.id, EV_Req_Fields__c= 'AS_FirstName__c' );
            insert sc;
            
            
             


List<String> column=new List<String>();
column.add('1');
column.add('2');
column.add('3');
List<String> dbfields=new List<String>();
dbfields.add('AS_FirstName__c');
dbfields.add('AS_LastName__c');
dbfields.add('AS_Email__c');
   
       Test.startTest();
       ReadAndPopulateDataBatch c = new ReadAndPopulateDataBatch (records,new List<String>(),new List<String>(),event.id,0,0,'',event.id,new List<String>());
       Database.executeBatch(c);
       ReadAndPopulateDataBatch.ValidatePhone('1234567890');
       // c.dummy1();
        //c.dummy2();
       // c.dummy3();
        //c.dummy4();
        //c.dummy5();
        //c.dummy6();
        //c.dummy7();
         //c.dummy8();
       Test.stopTest();

      }
      
      }