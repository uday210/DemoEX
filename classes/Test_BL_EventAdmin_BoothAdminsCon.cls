@istest

public class Test_BL_EventAdmin_BoothAdminsCon
{
  static testmethod void Testmethod_BL_EventAdmin_BoothAdminsCon(){

  Account Acc = new Account();
  Acc.Name = 'Booth Leads';
 insert Acc;

 Contact C = new Contact();
 C.LastName = 'Test';
 C.Accountid = Acc.id;
 insert C;

 Profile p = [select id from profile where name='Standard User'];

User u = new User(alias = 'test123', email='test123ttt@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='abc1209ttt@noemail.com');
                  insert u;

                  Id eventAdminId=u.id;   

Profile__c customProfileBooth= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
       insert  customProfileBooth;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  Date.Parse('01/18/2014'),
                             EV_StartDate__c = Date.Parse('01/18/2014'),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert eve;
      Id EventId=eve.Id;

User_Profile_Event__c upeEA = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,
Profile_id__c=customProfileBooth.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upeEA;   
    

// ------------------ Boothtadmin Insert ---------------------
         
       user bAdmin =  new User(alias = 'testboot', email='testboothadminttt@noemail.com',firstName='phani',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testboothadminttt@noemail.com',CompanyAddr1__c ='global"//',CompanyAddr2__c='global"//',CompanyName='Globalnest',Zipcode__c='02345',PoBox__c='02345');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
         
                  
       Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
       insert  customProfile;
       
       
       
       
       Booth__c booth = new Booth__c(BT_Name__c='TestBooth',BT_BoothUserCount__c=100.0,EV_id__c=EventId);
      insert booth; 
      string boothId =booth.Id;
      
      User_Profile_Event__c upebooth = new User_Profile_Event__c(BoothAdmin_id__c=boothAdminId,BT_id__c=boothId ,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfile.id,Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true,isFirstBoothAdmin__c=true);         
      insert upebooth;   
     
                  
 AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadminttt@noemail.com');
     insert attSummary;


system.runAs(u){

BL_Eventadmin_BoothAdminsCon BoothAdminsCon = new BL_Eventadmin_BoothAdminsCon();
    

    
   
    BoothAdminsCon.selectEvent=EventId;
    BoothAdminsCon.SelectedBooth=boothId ;
    BoothAdminsCon.exportBoothadmins();
    BoothAdminsCon.AddBoothAdmin();
    BoothAdminsCon.AddBooth();
    BoothAdminsCon.getStatuslist(); 
    BoothAdminsCon.selectevent = EventId;
   BoothAdminsCon.ListOfBoothAdmins();
   BoothAdminsCon.selectedBooth =boothId;
   PageReference pageRef = Page.BL_EventAdmin_BoothAdmins;
  Test.setCurrentPage(pageRef);
  ApexPages.currentPage().getParameters().put('BoothName',boothId);
   BoothAdminsCon.ListOfBoothAdmins();
     
   BoothAdminsCon.First();
   BoothAdminsCon.Previous();
   BoothAdminsCon.Last();
   BoothAdminsCon.Next();
   BoothAdminsCon.AddBooth();
  BoothAdminsCon.BoothAdminDetails=upebooth.id;   
  BoothAdminsCon.ParticularJuncID=upebooth;
   BoothAdminsCon.DisplayBoothAdminDetails();
   BoothAdminsCon.EditBoothAdmin();
  BoothAdminsCon.selectedBooth = null; 
  //BoothAdminsCon.UpdateUser();
  BoothAdminsCon.selectedBooth = boothId; 
  // BoothAdminsCon.UpdateUser();
  BoothAdminsCon.selectedBooth = null; 
   BoothAdminsCon.SelectedStatus ='Active';
   BoothAdminsCon.SaveStatus();
   BoothAdminsCon.selectedBooth = boothId; 
   BoothAdminsCon.SelectedStatus ='InActive';
   BoothAdminsCon.SaveStatus();
  BoothAdminsCon.selectedBooth =boothId; 
   BoothAdminsCon.ChangeStatus();
   BoothAdminsCon.ClosePopUp();
   BoothAdminsCon.Booth.BT_Name__c ='Sample Booth ';
    BoothAdminsCon.selectevent =EventId;
    BoothAdminsCon.BoothAdminUser = new User();
   BoothAdminsCon.BoothAdminUser.LastName ='Shruthi';
   BoothAdminsCon.BoothAdminUser.FirstName='R';
   BoothAdminsCon.Email='48745rrrr@mn.com'; 
   BoothAdminsCon.BoothAdminUser.CompanyName='IBM'; 
   BoothAdminsCon.A = new Account();
   BoothAdminsCon.A.Name =BoothAdminsCon.BoothAdminUser.CompanyName; 
   BoothAdminsCon.Con = new Contact();
   BoothAdminsCon.Con.LastName =BoothAdminsCon.BoothAdminUser.LastName; 
   BoothAdminsCon.Con.Accountid= BoothAdminsCon.A.id;
   BoothAdminsCon.InsertUser();
   BoothAdminsCon.forattendee();
  

   //BoothAdminsCon.SaveBooth();
  BoothAdminsCon.selectedBooth =null; 
   BoothAdminsCon.forattendee();
  
   //BoothAdminsCon.SaveBooth();
   

   BoothAdminsCon.exportBoothadmins();
   BoothAdminsCon.ClosePopUp();
   BoothAdminsCon.Con=new contact();
   BoothAdminsCon.BoothAdminUser= new user();
   BoothAdminsCon.BoothAdminUser.LastName ='Goud';
   BoothAdminsCon.BoothAdminUser.FirstName='S';
   BoothAdminsCon.Email ='testtttt@globalnest.com';
   BoothAdminsCon.BoothAdminUser.companyName ='Globalnest';
   BoothAdminsCon.BoothAdminUser.Company_website__c ='www.boothleads.com';
   BoothAdminsCon.BoothAdminUser.CompanyAddr1__c ='Madhapur';
   BoothAdminsCon.BoothAdminUser.CompanyAddr2__c ='Hyderabad';
   BoothAdminsCon.BoothAdminUser.CompanyFaxNumber__c='9999999999';
   BoothAdminsCon.BoothAdminUser.Companyphone__c ='9999999999';
   BoothAdminsCon.BoothAdminUser.Zipcode__c='511112';
   BoothAdminsCon.BoothAdminUser.PoBox__c ='511112';
   BoothAdminsCon.selectedBooth =boothId ; 
   BoothAdminsCon.InsertUser();
   BoothAdminsCon.forattendee();

   BoothAdminsCon.SaveBooth();
   BoothAdminsCon.login() ;


  
  }

}
}