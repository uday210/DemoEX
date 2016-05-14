public with sharing class BL_Registration_LinksCon {
 
 public List<inncls> inn{get;set;}
 public string EventId {get;set;}
 public BL_Registration_LinksCon(){
   inn = new List<inncls>();
    EventId =Apexpages.currentPage().getParameters().get('id');
    string  sfdcBaseURL1 = URL.getSalesforceBaseUrl().toExternalForm();
     
      List<Event__c> Events = new list<Event__c>();
       inn.add(new Inncls('All',sfdcBaseURL1,EventId));
      for(Event__c eve :[SELECT id,Attendee_Types__c from Event__c where id=:EventId ]){
          
         for(string tcat :(eve.Attendee_Types__c).Split(';')){
           inn.add(new Inncls(tcat.trim(),sfdcBaseURL1,EventId)); 
         } 
          
      }   
     
    
 }

    public class inncls {
      public String TicketCategory{get;set;}
      public string Url{get;set;}
      public string eveid{get;set;}
      public string sfdcBaseURLInn{get;set;}
      
      public inncls(string tc,string sfdcBaseURL,string event){
          this.TicketCategory =tc;
          this.eveid =event;
          this.sfdcBaseURLInn =sfdcBaseURL;
           this.Url =sfdcBaseURL+'/apex/BL_Registration_Attendee?id='+event+'&tcat='+tc;
            
      }
      
      
    }


}