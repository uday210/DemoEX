@istest

public class Test_BL_Event_TicketTypesCon
{
  static testmethod void Testmethod_BL_Event_TicketTypesCon()
  {
    contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
    insert con;
    
    Profile p = [select id from profile where name='Standard User'];
    
    User u = new User(alias = 'test12f', email='test12f3@noemail.com',
                    emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                    localesidkey='en_US',country='United States',
                    timezonesidkey='America/Los_Angeles', username='test12f3@noemail.com');
    insert u;
    Id eventAdminId=u.id;    
    
    Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
    insert  EventAdminProfile;
    
    Event__c eve = new Event__c(EV_Title__c='Global Event1',EV_HostingTimeZone__c='Eastern Time(USA)',
                                EV_EndDate__c = system.today()+10,
                                EV_StartDate__c = system.today(),
                                EV_EndTime__c='06:00 PM',
                                StartTime__c='09:00 AM',IsRegistration__c=false,Attendee_Types__c='Non-Attendee;Attendee;Exhibitor');
    insert eve;
    Id EventId=eve.Id;
    system.debug('############'+EventId);
    
    TicketTypes__c tic = new TicketTypes__c(Ticket_Image_URL__c='wwww.image120.com',TT_Name__c='Test Tic', TT_TicketType__c='Free',TT_Amount__c=50, order__c=2,  TT_Available__c=1000,EV_id__c=eve.id,forMobile__c=false);
    insert tic;
    Id TicketId=tic.Id;
    
    Promocodes__c pr= new Promocodes__c(Name='test',Discount_Type__c ='$',Discount_Value__c=100,Expiredate__c=system.today()+10);
    insert pr;
    
    Tickets_Mapswith_Promocode__c tp = new Tickets_Mapswith_Promocode__c(Max_number_Of_usage__c=3,Tickets__c=tic.id,Promocodes__c=pr.id);
    insert tp;
    
    User_Profile_Event__c upebooth = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=true);         
    insert upebooth; 
    
    PageReference pageRef = Page.BL_Event_TicketTypes;
    Test.setCurrentPage(pageRef);

    system.runAs(u){

        String eid = ApexPages.currentPage().getParameters().put('event', EventId);
        String tid = ApexPages.currentPage().getParameters().put('upPhani', TicketId);
        system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$'+eid);
        BL_Event_TicketTypesCon ticket= new BL_Event_TicketTypesCon();
        blob b;
        ticket.SelectedEvent = eid;
        ticket.getTicketTypeValues();
        ticket.getTicketcategoryValues();
        ticket.getTicketServiceFee();
        ticket.getAccountTypeValues();
        ticket.TicketTypes.TT_TicketType__c = 'Free';
        ticket.ForSelectedTicketTypes();
        ticket.TicketTypes.TT_TicketType__c = 'Paid';
        ticket.ForSelectedTicketTypes();
        ticket.cancel();
        ticket.Paymentsdiv();
        ticket.PayPalAccount.Account_types__c = 'PayPal Account';
        ticket.SavePaypal();
        ticket.Cancelpopup();
        ticket.TicketTypes = new TicketTypes__c();
        ticket.TicketTypes.TT_Name__c = 'FullConf';
        ticket.TicketTypes.EV_id__c = ticket.SelectedEvent ;
        ticket.TicketTypes.TT_Sold__c = 0;
        ticket.TicketTypes.TT_TicketType__c = 'Free';
        Database.upsert(ticket.TicketTypes); 
        ticket.TicketTypeID = ticket.TicketTypes.id;
        ticket.EditTicket();
        ticket.TicketDetails();
        ticket.DeleteTicket();
        ticket.TicketList();
        
        ticket.Accountype = ApexPages.currentPage().getParameters().put('AccountTypes',ticket.PayPalAccount.Account_types__c);
        
        if(ticket.Accountype  == 'PayPal Account'){
            ticket.PayPalAccountre = False;
            ticket.DotNetre = True;
        }
        ticket.SelectedAccounttype();
        
        ticket.PayPalAccount.Account_types__c = 'Authorize.Net';
        
        ticket.Accountype = ApexPages.currentPage().getParameters().put('AccountTypes',ticket.PayPalAccount.Account_types__c);
        
        if(ticket.Accountype  == 'Authorize.Net') {
            ticket.PayPalAccountre = True;
            ticket.DotNetre = False;
        }
        ticket.SelectedAccounttype();
        ticket.getListOfTickectNames();
        ticket.dummyMeth();
        
        ticket.upPhani=tid;
     
        ticket.getValues();
        ticket.Cancelclone();
   ticket.selectedcheckforCopySurvey=true;
   ticket.cloneId=tic.id;
   ticket.cloneTicket();
       ticket.saveCloneTicket(); 
              //ticket.cloneId=tid;

        
        //ticket.saveCloneTicket();
        ticket.onchnageCheckbox();
        Apexpages.currentPage().getParameters().put('upPhani',TicketId);
        ticket.down();
       
       Apexpages.currentPage().getParameters().put('upPhani',TicketId);
       ticket.DeleteRec();
       
       ticket.AddTicket();
       ticket.cloneId=tic.id;
       ticket.TicketFileName='test';
       ticket.TicketImage=Blob.valueOf('test.jpg');
       tic.Ticket_Image_URL__c='wwww.image.com';
       ticket.save();
       //ticket.Paymentsett();
        ticket.SaveReg();
        ticket.renderTicbool();
        ticket.renderTicboolcancel();
        ticket.innvaluesSave();
       // ticket.cloneTicket();
        //ticket.saveCloneTicket();
       // ticket.DeleteRec();
               //BL_Event_TicketTypesCon ticket1= new BL_Event_TicketTypesCon();

        //Apexpages.currentPage().getParameters().put('upPhani',TicketId);
        //tic.order__c=0;
       //ticket1.up();
        //Database.upsert(ticket.TicketTypes); 
    }
    }
}