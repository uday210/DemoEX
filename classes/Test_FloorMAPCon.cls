@istest
public class Test_FloorMAPCon
{
  static testmethod void Testmethod_FloorMAPCon(){

  Account Acc = new Account();
  Acc.Name = 'Booth Leads';
 insert Acc;

 Contact C = new Contact();
 C.LastName = 'Test';
 C.Accountid = Acc.id;
 insert C;

 Profile p = [select id from profile where name='Standard User'];

User u = new User(alias = 'test123', email='BoothMap@noemail.com',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='BoothMap@noemail.com');
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
         
       user bAdmin =  new User(alias = 'testboot', email='testboothMap@noemail.com',firstName='phani',
                 emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='testboothMap@noemail.com',CompanyAddr1__c ='global"//',CompanyAddr2__c='global"//',CompanyName='Globalnest',Zipcode__c='02345',PoBox__c='02345');
                  insert bAdmin ;
                  Id boothAdminId=bAdmin.id;
         
                  
       Profile__c customProfile= new Profile__c (PR_Name__c='BoothAdmin',PR_Version__c='3.0');        
       insert  customProfile;
       
       
       
       
       Booth__c booth = new Booth__c(BT_Name__c='TestBooth',BT_BoothUserCount__c=100.0,EV_id__c=EventId);
      insert booth; 
      string boothId =booth.Id;
      
      User_Profile_Event__c upebooth = new User_Profile_Event__c(BoothAdmin_id__c=boothAdminId,BT_id__c=boothId ,EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=customProfile.id,Status__c='Active',User_id__c=boothAdminId,UEP_isActive__c=true,isFirstBoothAdmin__c=true);         
      insert upebooth;   
     
                  
 AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
     insert attSummary;
    
     
   
    
    Apexpages.Currentpage().getParameters().put('eventId',eve.id);
    
    Floor_Map__c toCreate = new Floor_Map__c();  
                       
                toCreate.Name = '';
                toCreate.Parameters__c  = '{"type":"rectangle","params":{"x":133,"y":394,"width":121,"height":49}}';
                toCreate.Booth_Size__c = '100x100';
                toCreate.Booth_Price__c = 200 ;
                toCreate.Booth_Location__c = '123';               
                toCreate.Event__c = EventId ;
                toCreate.Reserved__c = FALSE ;
                toCreate.Booth_Area__c = '200 sq ft.';
               // if(item.Type__c == null)
               // toCreate.Type__c = 'Booth';
               // else
                toCreate.Type__c = 'Booth';
                toCreate.Description__c = '';
                
    Insert  toCreate ; 
    
     Apexpages.Currentpage().getParameters().put('DelId',toCreate.id);
     Apexpages.Currentpage().getParameters().put('BoothID',booth.ID);
     Apexpages.Currentpage().getParameters().put('FloorID',toCreate.ID);
     Apexpages.Currentpage().getParameters().put('OldBoothId','');
     Apexpages.Currentpage().getParameters().put('A','');
     Apexpages.Currentpage().getParameters().put('S','');
     Apexpages.Currentpage().getParameters().put('R','');

system.runAs(u){
    
    ApexPages.StandardController controller = new ApexPages.StandardController(eve);
    
    FloorMAPCon BoothMap = new FloorMAPCon(controller);
    
     
    BoothMap.ShowEvent = eve;
    BoothMap.ShowList(); 
    BoothMap.showingEventMethod(); 
    BoothMap.SowingListofBoothAdmins();    
    BoothMap.ForSavingBooths();    
    BoothMap.ToDeleteTheShape();
    BoothMap.ForSavingColors(); 
}

}

}