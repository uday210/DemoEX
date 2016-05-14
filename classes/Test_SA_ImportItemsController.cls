@istest(SeeAllData= true)

public class Test_SA_ImportItemsController{
    
    static testmethod void Testmethod_SA_ImportItemsController(){
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
                           
     cookie  counter = new Cookie('counter',eve.id,null,-1,false);
     ApexPages.currentPage().setCookies(new Cookie[]{counter});
    system.runas(u){    
    SA_ImportItemsController importItems= new SA_ImportItemsController();
     
     string ItemsFields= 'Item_name__c, Cost__c, Item_Quantity__c, isTaxable__c,Sales_Tax__c';
     //importTickets.dataFromJavaScript= String.valueOf('Ticket Name,Ticket Price,Quantity,Ticket Type(Paid;Free;Donation) \r ticket1, 150.00, 50, Paid????:::::******&&&&&&%%%%;;;;'); 
     importItems.importedFile= blob.valueOf('Item Name,Item Price,Item Quantity,isTaxable(True;False),Sales Tax'); 
    ApexPages.currentPage().getparameters().put('one','Item Name","Item Price,"Item Quantity",isTaxable(True;False),Sales Taxaazz11ttt222gggas,23,3,TRUE,4aazz11ttt222gggqw,3,3,FALSE,aazz11ttt222ggger,5,5,TRUE,aazz11ttt222gggwr,",5,FALSE,3aazz11ttt222gggwea,5,,TRUE,aazz11ttt222gggww,,3,TRUE,aazz11ttt222ggg,5,5,TRUE,aazz11ttt222gggawe,5,5,,3aazz11ttt222gggasdf,3,3,FALSE,2aazz11ttt222gggqwe12,3,3,!#,4aazz11ttt222ggg12,1,1,TRUE,!A1212aazz11ttt222ggg????:::::******&&&&&&%%%%;;;;SA_Item_Template.csv');
     importItems.showItemMapping();
     importItems.importItemValues();
     
     importItems.closeItem();
     importItems.exportItemToCSV();
     importItems.close();
     importItems.CheckUserId();
    }
    }
    }