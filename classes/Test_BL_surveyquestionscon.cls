@isTest
public class Test_BL_surveyquestionscon{
static testMethod void mytestClassForSurveyQuestions(){
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
        
        
        ApexPages.currentPage().getParameters().put('id', ev.id);
        ApexPages.currentPage().getParameters().put('upPhani', TMS.id);
       ApexPages.currentPage().getParameters().put('mycheck',TMS.id);
    surveyquestionsCon SQN = new surveyquestionsCon();
    
    SQN.firstCallMEthod();
    SQN.Up();
    SQN.down();
    SQN.DeleteRec();
    SQN.typesfun();
    SQN.surveyquestions();
    SQN.savequestions();
    SQN.selectedtype = 'CheckBox';
    SQN.optionslabel();
    SQN.saveandnewquestions();
    SQN.editSurvey();
    SQN.updatesurvey();
    SQN.Cancel();
    SQN.add();
    //SQN.Remove();
    
   
}
}