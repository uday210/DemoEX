@isTest
public class Test_UtillForInsertUser{

 public static TestMethod void UtillForInsertUser(){
 
 Profile p= new Profile();
 p = [select id from profile where name='System Administrator'];
 
 Profile__c pro = new Profile__c();
 pro.PR_Name__c = 'Attendee';
 insert pro;
 
 Profile__c pro1 = new Profile__c();
 pro1.PR_Name__c = 'BoothAdmin';
 insert pro1;
 
//Profile__c attendeeProfile= [Select Id from Profile__c where PR_Name__c ='Attendee' ];
//Profile p = [select id from profile where name='system Administrator'];
//Profile__c boothAdminProfile= [Select Id from Profile__c where PR_Name__c ='BoothAdmin' ]; 
 
 User u = new User(alias = 'test123', email='test567@salesforce.com',
                 emailencodingkey='UTF-8',profileid =p.id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test567@salesforce.com');
 insert u;
 
  Event__c eve = new Event__c(EV_Title__c='TestEvent',EV_WebsiteURL__c='https://www.globalnest.com');
  insert eve;
  
  AttendeeSummary__c  att= new AttendeeSummary__c ();
  att.AS_Email__c='test567@salesforce.com';
  att.AS_FirstName__c='sName';
  att.AS_LastName__c='Sag';    
  att.AS_Company__c ='Globalnest';
   insert att;
   
   Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
    eam.AS_id__c= att.id;
    eam.Boothleads_Profile__c= 'Attendee';
    eam.EV_id__c= eve.id;
    eam.IsBoothLeadsAttendee__c= TRUE;
    eam.checkbox_dataTable__c= TRUE;
    insert eam;
    
    
    AttendeeSummary__c  att1= new AttendeeSummary__c ();
  att1.AS_Email__c='test5671@salesforce.com';
  att1.AS_FirstName__c='sName';
  att1.AS_LastName__c='Sag';    
  att1.AS_Company__c ='Globalnest';
   insert att1;
   
   Event_Attendee_Mapping__c eam1= new Event_Attendee_Mapping__c();
    eam1.AS_id__c= att1.id;
    eam1.Boothleads_Profile__c= 'BoothAdmin';
    eam1.EV_id__c= eve.id;
    eam1.IsBoothLeadsAttendee__c= TRUE;
    eam1.checkbox_dataTable__c= TRUE;
    insert eam1;
    
    
    list<Event_Attendee_Mapping__c> liema= new list<Event_Attendee_Mapping__c>();
    liema =[select Owner.Name,GuestType__c,TicketTypes__c,id,as_id__c,EV_id__c,as_id__r.AS_FirstName__c,as_id__r.AS_LastName__c,as_id__r.AS_Email__c,as_id__r.AS_company__c from Event_Attendee_Mapping__c where EV_id__c =:eve.id and as_id__c!=null];
    
    
    liema.add(eam);
    system.runas(u){
     UtillForInsertUser ui= new UtillForInsertUser();
     ui.insertUsers(liema,True,eve.id,true,'unni1123');
     
     
    
     
    }  
 }
 
}