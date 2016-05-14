public class BLN_EventDetails{
    
    public LIST<BLN_Event__c> eventDetails{get; set;}
    public String eventDatesString {get; set;}
    
    public pagereference eventDetailsToDisplay(string EventId){
        BLN_Event_DAO eventDAO= new BLN_Event_DAO();
        eventDetails= eventDAO.getEventDetails(EventId);     
        if(eventDetails.size() >0){
            if(eventDetails[0].Start_Date__c == eventDetails[0].End_Date__c){
            eventDatesString = string.valueof(eventDetails[0].Start_Date__c);
        } else if(eventDetails[0].Start_Date__c != eventDetails[0].End_Date__c){
            eventDatesString = string.valueof(eventDetails[0].Start_Date__c)+' TO '+string.valueof(eventDetails[0].End_Date__c);
        }
        }   
        return null;
    }
}