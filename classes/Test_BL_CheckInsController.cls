@isTest
public with sharing class Test_BL_CheckInsController{
    static testMethod void Test_BL_CheckInsController(){
         
         Profile p = [select id FROM profile where name = 'System Administrator'];
         
         User u = new User(alias = 'test123', email = 'testmyth123@gmail.com',emailencodingkey = 'UTF-8', profileid = p.Id, lastname = 'Testing', languagelocalekey = 'en_US',localesidkey = 'en_US', country = 'United States',timezonesidkey = 'America/Los_Angeles', username = 'testmyth123@gmail.com',Password__c='123',isactive=true);
         insert u;
         
         Event__c event = new Event__c(EV_Title__c = 'testEvent', EV_HostingTimeZone__c = 'Eastern Time(USA)', EV_EndDate__c = date.valueOf('2012-05-15 00:00:00'), EV_StartDate__c = date.valueOf('2012-05-11 00:00:00'), Event_Printer__c = 'Avery 22806 easy peal square Badges', EventDiversityValues__c = 'Reception;monday pass',ownerid=u.id);
         insert event;
         
         AttendeeSummary__c att= new AttendeeSummary__c(AS_FirstName__c = 'mythily', AS_LastName__c = 'Nagandla',
         AS_Email__c = 'testmyth@gmail.com', AS_Company__c = 'Global Nest', As_Home_Country__c = 'None', As_Home_State__c = 'None', As_Shipping_Country__c = 'None', As_Shipping_States__c = 'None', AS_NAICSCode_1__c = '987654', AS_NAICSCode_2__c = '123456', AS_NAICSCode_3__c = '898765',AS_ImageUrl__c='testurl');
         insert att;
         
         Event_Attendee_Mapping__c EAM = new Event_Attendee_Mapping__c(EV_id__c = event.id,checkbox_dataTable__c=True, AS_id__c = att.id, DiversityType__c = 'xxxxxxx', TicketTypes__c = 'Reception', EA_AttendeeBarcode__c = 'a0nvwsdwkde', EA_isBadgePrinted__c = true, IsPrifileUpdate__c = true,Attendee_Types__c='volunteer');
         insert EAM;
         
         //Adding Ticket
         TicketTypes__c tckt=new TicketTypes__c(TT_Name__c='Test Ticket',EV_id__c=Event.ID,TT_Available__c=100,TT_Amount__c=200,TT_TicketType__c='Paid');
         insert tckt;  
         
         //Adding PaymentInfo
         Constomer__c cust=new Constomer__c(Customer_Name__c=att.AS_FirstName__c,Email__c=att.AS_Email__c,Total_Amount__c=1000);
         insert cust; 
         
         Dummay__c dm=new Dummay__c(First_Name__c=att.AS_FirstName__c,Last_Name__c=att.AS_LastName__c,Email__c=att.AS_Email__c,TicketTypes__c=tckt.id,Event__c=Event.ID,
         TicketAmount__c=200,Payment_Status__c='Paid',Payment_Type__c='Cash',Tickets_Quantty__c=2,Check_number__c='1',Seat_Number__c='1',Promocode__c='1',customer_key__c=cust.id,AttendeeSummary__c=att.id,Event_Attendee_Mapping__c=EAM.id);
         insert dm;
         
         Individual_Ticket_Info__c iti = new Individual_Ticket_Info__c(Registration_Info__c=dm.id,Seat__c='A1',IsCheckedIn__c=true,Scanned_by__c=u.id);
         insert iti;
         
         system.runAs(u){
             BL_CheckInsController CC = new BL_CheckInsController();
             CC.CheckinList();
             CC.ExportCheckinList();
             CC.escape('mahesh"kumar<c.,\\h');
         }
    
    }
}