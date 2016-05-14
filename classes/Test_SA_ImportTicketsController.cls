@istest(SeeAllData= true)

public class Test_SA_ImportTicketsController{
    
    static testmethod void Testmethod_SA_ImportTicketsController(){
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
     SA_ImportTicketsController importTickets= new SA_ImportTicketsController();
     
     string TicketFields= 'TT_Name__c, TT_Amount__c, TT_Available__c, TT_TicketType__c';
     //importTickets.dataFromJavaScript= String.valueOf('Ticket Name,Ticket Price,Quantity,Ticket Type(Paid;Free;Donation) \r ticket1, 150.00, 50, Paid????:::::******&&&&&&%%%%;;;;'); 
     importTickets.importedFile= blob.valueOf('Ticket Name,Ticket Price,Quantity,Ticket Type(Paid;Free;Donation)'); 
    ApexPages.currentPage().getparameters().put('one','Name","Ticket Price","Quantity,Ticket Type(Paid;Free;Donation)aazz11ttt222gggd,500,",donationaazz11ttt222gggpas,400,50,freeaazz11ttt222gggpass212w,0,50,freeaazz11ttt222ggg????:::::******&&&&&&%%%%;;;;SA_Ticket_Template (100).csv');
     importTickets.showTicketMapping();
     importTickets.importTicketValues();
     
     importTickets.closeTicket();
     importTickets.exportTicketToCSV();
     importTickets.close();
     
    }
    }
    }