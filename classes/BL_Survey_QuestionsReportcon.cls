public with sharing class BL_Survey_QuestionsReportcon {
  public string selectedEvent {get;set;}
  public List<Survey__c> surveys {get;set;}
  public List<inncls> innclslist{get;set;}
  
       public BL_Survey_QuestionsReportcon(){
          List<Event_Attendee_Mapping__c> eventAttendee = new List<Event_Attendee_Mapping__c>();
          List<Survey__c> surveys  = new List<Survey__c>();
          innclslist = new List<inncls>();
          selectedEvent = Apexpages.CurrentPage().getParameters().get('id');
          
          surveys   = [select id,Answers__c,AttendeeSummary__c,customer_key__c,Event__c,Survey_Questions__r.Agreed_Not__c,Survey_Questions__r.Options__c,Survey_Questions__r.order__c,Survey_Questions__r.Question__c,  Survey_Questions__r.Type__c,Survey_Questions__r.Waivers__c from Survey__c where Event__c=:selectedEvent];
           for(Event_Attendee_Mapping__c attendee : [select id,AS_id__r.AS_FirstName__c,AS_id__r.AS_LastName__c,AS_id__r.AS_Email__c,AS_id__r.AS_Company__c,AS_id__r.AS_WorkPhone__c from Event_Attendee_Mapping__c where Ev_Id__c =:selectedEvent]){
              List<Survey__c>  surList = new List<Survey__c>();
              for(Survey__c su :surveys){
                 if(su.AttendeeSummary__c == attendee.AS_id__c){
                    surList.add(su); 
                 }
              }
            innclslist.add(new inncls(attendee,surList));  
           }    
         
       }  
       
   public class inncls{
    public Event_Attendee_Mapping__c eam {get;set;}
     public List<Survey__c> surveys {get;set;}
       public inncls(Event_Attendee_Mapping__c ea,List<Survey__c> surveys1 ){
         eam  = new Event_Attendee_Mapping__c();
         surveys  = new List<Survey__c>();
          this.eam  = ea;
          this.surveys  = surveys1 ; 
       }
   
     }       
  }