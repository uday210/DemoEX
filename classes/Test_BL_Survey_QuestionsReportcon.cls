@isTest
public class Test_BL_Survey_QuestionsReportcon {
static testMethod void UnitTest(){
      Event__c ev = new Event__c(EV_Title__c = 'Test Event', EV_EndDate__c =  Date.Parse('01/18/2014'), EV_StartDate__c = Date.Parse('01/16/2014'),
       EV_HostingState__c ='Test State', EV_HostingLocation__c='281 Test Location', 
       EV_HostingTimeZone__c = 'Eastern Time(USA)', Status__c = 'Event Progres', EV_Publish__c = TRUE,
       Event_Printer__c = 'Dymo Label(30856,Single Label)');
  
       insert ev; 
      
      TicketTypes__c tic = new TicketTypes__c(TT_Name__c='Test Tic', TT_TicketType__c='Free',TT_Amount__c=50,   TT_Available__c=1000,EV_id__c=ev.id);
       insert tic;
       
      Survey_Questions__c SQ = new Survey_Questions__c(Question__c = 'what is your name',Type__c = 'Text',Options__c = 'Yesmy#No',Agreed_Not__c=true);
        insert SQ;
        
        
       Ticket_Mapswith_Survey__c TMS= new Ticket_Mapswith_Survey__c(Survey_Questions__c = SQ.id,TicketTypes__c = tic.id,order__c=0);
        insert TMS;
        
        
        AttendeeSummary__c attSummary = new AttendeeSummary__c(As_prefixNew__c='Mr',AS_FirstName__c='te\"st',AS_LastName__c='boothadmin',AS_Email__c='testboothadmin@noemail.com');
        insert attSummary;
          string attendeeEvent= string.valueOf(attSummary.Id)+string.valueOf(ev.id);   
      
         Event_Attendee_Mapping__c event_att_map = new Event_Attendee_Mapping__c(EV_id__c=ev.id,AS_id__c=attSummary.Id,Attendee_Event_IDs__c=attendeeEvent);
        insert event_att_map ;      
        
        
        Survey__c sur = new Survey__c();
        sur.Answers__c = '1234';
         sur.AttendeeSummary__c= attSummary.id;
           sur.Event__c= ev.id;
          sur.Survey_Questions__c= SQ.id; 
         insert sur;
        
         PageReference pd = page.BL_Survey_QuestionsReport;  
         test.setCurrentPage(pd);
         ApexPages.currentPage().getParameters().put('id', ev.id);
         BL_Survey_QuestionsReportcon  conr = new BL_Survey_QuestionsReportcon ();
         
        
    }
}