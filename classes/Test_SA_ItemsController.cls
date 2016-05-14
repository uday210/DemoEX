@istest

public class Test_SA_ItemsController 
{
  static testmethod void Testmethod_SA_ItemsController(){
  
  contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='System Administrator'];
       
 // ------------------ Eventadmin Insert ---------------------

 User u = new User(alias = 'test123', email='test123111@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='test123111@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='1.5');        
       insert  EventAdminProfile;
       
      Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM',
                             EV_EventLogo__c ='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones');
      insert eve;
      Id EventId=eve.Id;
      
            
      Item__c item1= new Item__c();
      
      item1.Item_name__c='item1';
      item1.Event__c= eve.Id;
      insert item1;
      
       Item__c item2= new Item__c();
      
      item2.Item_name__c='item2';
      item2.Event__c= eve.Id;
      insert item2;
                           
        cookie  counter = new Cookie('counter',eve.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
     
     SA_ItemsController item= new SA_ItemsController();

     ApexPages.CurrentPage().getParameters().put('ItemIdParam',item1.id);
     item.LogoName='Unit Test Attachment';
     item.Logo=Blob.valueOf('Unit Test Attachment Body');
            
     item.editItem();
     item.addItem();
     item.createItem();
     item.viewItem();
     item.deleteItem();
     item.closeItem();
     item.SaveSalesTax();
     item.UpdateSalesTax();
     item.validateSalesTax();
     item.checkUserId();
   }
}