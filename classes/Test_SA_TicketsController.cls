@istest

public class Test_SA_TicketsController 
{
  static testmethod void Testmethod_SA_TicketsController(){
  
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
      
       User_Profile_Event__c upeEA= new User_Profile_Event__c (EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c= TRUE);         
      insert upeEA; 
      
      
      TicketTypes__c TT1= new TicketTypes__c();
      
      TT1.TT_Name__c=' ticket type1';
      TT1.EV_id__c=eve.Id;
      TT1.TT_TicketType__c='Free';
      TT1.Ticket_Category__c='Non – Attendee';
      TT1.Ticket_Image_URL__c='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones';
      insert TT1;

      TicketTypes__c TT2= new TicketTypes__c();
      
      TT2.TT_Name__c=' ticket type2';
      TT2.EV_id__c=eve.Id;
      TT2.TT_TicketType__c='Free';
      TT2.Ticket_Category__c='Non – Attendee';
      TT2.Ticket_Image_URL__c='http://www.hiren.info/desktop-wallpapers/flowers-pictures/purple-and-green-flowers-in-stones';
     
      insert TT2;
      
       MatchLeads_Days__c Daysl=  new MatchLeads_Days__c(Event__c =EventId ,MatchLeads_Date__c = system.today(),End_Time__c='06:00 PM',Start_time__c='09:00 AM',Session_Name__c = 'aaa');
       insert Daysl; 
       Ticket_Session_Mapping__c tiksess = new Ticket_Session_Mapping__c(Is_Input__c = TRUE,Session__c =Daysl.ID,Ticket__c=TT1.iD,Unique_Ids__c ='1'); 
          insert tiksess ;          
        cookie  counter = new Cookie('counter',eve.id,null,-1,false);
         ApexPages.currentPage().setCookies(new Cookie[]{counter});
     
     SA_TicketsController ticket= new SA_TicketsController();

     ApexPages.CurrentPage().getParameters().put('TicketIdParam',TT1.id);
     ticket.LogoName='Unit Test Attachment';
     ticket.Logo=Blob.valueOf('Unit Test Attachment Body');
            
     ticket.editTicket();
     ticket.addTicket();
     ticket.createTicket();
     ticket.viewTicket();
     ticket.deleteTicket();
     ticket.closeticket();
     ticket.ticketTypeVal();
     ticket.checkUserId() ;
   }
}