@isTest
public class Test_SaveUserProfile3{

 static testMethod void testDoGet() {
      
      Profile w = [select id from profile where name='Standard User'];
   user bu2 =  new User(alias = 'busers', email='buser2@badmin.com',firstname='mythily',lastname='priya',
                 emailencodingkey='UTF-8',profileid = w.Id, languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='buser2@badmin.com',CompanyName='Nest',Title='dev');
                  insert bu2;
         AttendeeSummary__c attSummarybp = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='buser2@badmin.com');
     insert attSummarybp;
     
                  System.RestContext.request = new RestRequest();
       RestContext.request.requestURI = '/GlobalnestEM/SaveUserProfile3';
   
       RestContext.request.addParameter('UserID', bu2.Id);
       String JSONMsg = '[{"firstname":"mythily","Lastname":"Priya","company":"globalnest","City":"Hyderabad","State":"Andhara Pradesh","Phone":9705527647,"Country__c":"India"}]';
       RestContext.request.requestBody = Blob.valueof(JSONMsg);
      
      system.runas(bu2){
       SaveUserProfile3.doPost();
      }
      
      
 
     }
   }