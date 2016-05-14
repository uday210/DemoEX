@istest

public class Test_BL_registerAttendee
{
  static testmethod void Testmethod_BL_registerAttendee()
  {
contact con = new contact(firstname='testcontactfn',lastname='testcontactln');
           insert con;
 Profile p = [select id from profile where name='Standard User'];
       
 // ------------------ Eventadmin Insert ---------------------
 User u = new User(alias = 'test1tt', email='toest123@noemail.com',
                  emailencodingkey='UTF-8',profileid = p.Id,lastname='Testing', languagelocalekey='en_US',
                  localesidkey='en_US',country='United States',
                  timezonesidkey='America/Los_Angeles', username='toest123@noemail.com');
                  insert u;
                  Id eventAdminId=u.id;    
 
   Profile__c EventAdminProfile= new Profile__c (PR_Name__c='EventAdmin',PR_Version__c='3.0');        
   insert  EventAdminProfile;
   
   Event__c eve = new Event__c(EV_Title__c='Global Event',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c = system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='06:00 PM',
                             StartTime__c='09:00 AM');
      insert eve;
      Id EventId=eve.Id;
      
     
       
      User_Profile_Event__c upebooth = new User_Profile_Event__c(EV_id__c=EventId,EventAdmin_Id__c=eventAdminId,Profile_id__c=EventAdminProfile.id,Status__c='Active',User_id__c=eventAdminId,UEP_isActive__c=false);         
      insert upebooth; 

  Event__c event= new Event__c(EV_Title__c='Global event1',EV_HostingTimeZone__c='Eastern Time(USA)',
                             EV_EndDate__c =  system.today()+10,
                             EV_StartDate__c = system.today(),
                             EV_EndTime__c='09:00 AM',
                             StartTime__c='11:00 AM');
      insert event;

TicketTypes__c TT1= new TicketTypes__c();
TT1.TT_Name__c='type1';
TT1.EV_id__c=EventId;
TT1.TT_TicketType__c='donation';
TT1.Ticket_Category__c='Non – Attendee';
insert TT1;

system.debug('TTTTTTTTTT1111111111111111'+TT1);
TicketTypes__c TT2= new TicketTypes__c();
TT2.TT_Name__c=' ticket type2';
TT2.EV_id__c=EventId;
TT2.TT_TicketType__c='Paid';
TT2.Ticket_Category__c='Attendee';
TT2.Service_Fee__c='Include the Booth Leads fee in to the total ticket fee';
TT2.TT_Limit__c=34;
TT2.TT_Sold__c=4;
TT2.Min_Tickets_per_Order__c=10;
TT2.Max_Tickets_per_Order__c =20;
TT2.TT_Amount__c=500;
TT2.Sales_End_Date__c =system.today()+5;
TT2.TT_Amount__c=500;
TT2.TT_Available__c=500;
insert TT2;
system.debug('TTTTTTTTTT222222222222222222222'+TT2);

Pay_Pal_Account__c ppa1= new Pay_Pal_Account__c(Event__c=event.id,Email_Id__c='manasa1243@gmail.com');
insert ppa1;
Pay_Pal_Account__c ppa2= new Pay_Pal_Account__c(Event__c=event.id,Email_Id__c='gandham.manasa@gmail.com');
insert ppa2;



PageReference pagRef = page.BL_registerAttendee;
Test.setCurrentPage(pagRef); 

system.runas(u)
{
ApexPages.currentPage().getParameters().put('id', EventId);

BL_registerAttendee attendee= new  BL_registerAttendee ();
/*
 public TicketTypes__c tt{get;set;}
   public integer quantity{get;set;}
  public decimal donationValue{get;set;}
   public List<selectOption> opt{get;set;}
*/

 List<selectOption> options = new List<selectOption>();
 for(integer i =1;i<=5;i++){
    options.add(new selectOption(string.valueOf(i),string.valueOf(i)));
  } 
 
 
BL_registerAttendee.innerClass innerclassName = new BL_registerAttendee.innerClass(TT2,options);
innerclassName.quantity=1;
innerclassName.donationValue=100;
List<BL_registerAttendee.innerClass> inntest = new List<BL_registerAttendee.innerClass>();
inntest.add(innerclassName);
attendee.inn=inntest;

attendee.onchangeAct();
attendee.previous1();
attendee.previous2();
attendee.previous3();
attendee.enabletab4();
attendee.enabletab3();
attendee.enabletab2();
attendee.enabletab1();


attendee.getistab0disabled();
attendee.getistab1disabled();
attendee.getistab2disabled();
attendee.getistab3disabled();
attendee.getistab4disabled();
attendee.getselectedtab();


BL_registerAttendee.innforSecondButton innforSecondButtonTest= new BL_registerAttendee.innforSecondButton(TT2,100,1);
List<BL_registerAttendee.innforSecondButton> listOfinnforsec = new List<BL_registerAttendee.innforSecondButton>();

innforSecondButtonTest.totalPrice =0;
innforSecondButtonTest.Quan=1;

Dummay__c ddd = new Dummay__c();
List<Dummay__c> listOfddd = new List<Dummay__c>();

ddd.Company__c='boothleads';
ddd.Email__c ='abcd@gmail.com';
ddd.Event__c =EventId;
ddd.First_Name__c ='test';
ddd.Last_Name__c ='test';
ddd.Phone__c ='1111111111';
listOfddd.add(ddd);
innforSecondButtonTest.dom=listOfddd;
listOfinnforsec.add(innforSecondButtonTest);
attendee.eventAdminAmount=0;
attendee.seccls =listOfinnforsec;
attendee.pay();


}
}
}