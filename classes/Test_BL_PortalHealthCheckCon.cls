@isTest
public class Test_BL_PortalHealthCheckCon{

 public static TestMethod void BL_BL_PortalHealthCheckCon(){
  
   
 Profile__c pro = new Profile__c();
 pro.PR_Name__c = 'Attendee';
 insert pro;
 
 Profile__c pro1 = new Profile__c();
 pro1.PR_Name__c = 'BoothAdmin';
 insert pro1;
  
  
  Profile p = [select id from profile where name='Standard User'];

  User u = new User(alias = 'test123', email='test567@salesforce.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test567@salesforce.com');
  insert u;
  Id eventAdminId=u.id;  
                  
   Event__c eve = new Event__c(EV_Title__c='TestEvent',EV_WebsiteURL__c='https://www.globalnest.com');
   insert eve;
  
  Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
  insert  customProfileBooth;
   
    AttendeeSummary__c  att= new AttendeeSummary__c ();
      att.AS_Email__c='test567@salesforce.com';
      att.AS_FirstName__c='sName';
      att.AS_LastName__c='Sag';      
      insert att;
      
     
      
      Event_Attendee_Mapping__c eam= new Event_Attendee_Mapping__c();
      eam.AS_id__c= att.id;
      eam.Boothleads_Profile__c= 'Attendee';
      eam.EV_id__c= eve.id;
      eam.IsBoothLeadsAttendee__c= TRUE;
      eam.checkbox_dataTable__c= TRUE;
      //eam.GuestType__c=
      insert eam;
   
   
  
   User_Profile_Event__c upeEA = new User_Profile_Event__c(EV_id__c=eve.id,EventAdmin_Id__c=eventAdminId,
                                 Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId);         
      insert upeEA;          
  
  /*
   Profile__c profileBA = new Profile__c(PR_Name__c='BoothAdmin');
   insert profileBA;
  */
   Constomer__c cus2 = new  Constomer__c();
   cus2.Uniq_Number__c ='test';
   cus2.isinserted__c=true;
   insert cus2;
   
   Dummay__c com = new Dummay__c(Tickets_Quantty__c =100,Seat_Number__c = 'Seat-1',Profile__c='BoothAdmin',Phone__c='1234567899',Payment_Type__c='Invoice',Last_Name__c='Lame',InvoiceEmail__c='test567@salesforce.com',First_Name__c='FNnName',Event__c=eve.id,Email__c='test567@salesforce.com',Company__c='globa',Check_number__c='1234',customer_key__c=cus2.id);
  insert com;
   
   
     BL_PortalHealthCheckCon testcon = new BL_PortalHealthCheckCon();
     testcon.updateIndUpeValues();
     pageReference pf = page.BL_PortalHealthCheck;
     Test.setCurrentPage (pf);
     Apexpages.currentpage().getParameters().put('emValue','test567@salesforce.com');
      Apexpages.currentpage().getParameters().put('index','global123');
    testcon.updatePassword();
    
     testcon.userSignup();
     Apexpages.currentpage().getParameters().put('emValue','test567@salesforce.com');
      Apexpages.currentpage().getParameters().put('index','test56@salesforce.com');
     testcon.updateEmail();
     testcon.insertBooth();
     testcon.deleteUpe();
     testcon.showhidePanel2();
     testcon.showhidePanel();

 }
 
 
 }