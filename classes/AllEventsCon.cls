//Demo
public with sharing class AllEventsCon {

    
     
    public LIST<Event__c> AllEves{ get; set; } 
    public LIST<Event__c> upcomingEvents{ get; set; }
    public LIST<Event__c> pastEvents{ get; set; }
    
    // Match Making Events List
    public LIST<Event__c> MMAllEves{ get; set; } 
    public LIST<Event__c> MMupcomingEvents{ get; set; }
    public LIST<Event__c> MMpastEvents{ get; set; }
    
    
    public AllEventsCon(){
        AllEvents();
    }
    
    Public void AllEvents(){
         
         BL_EventsList_DAO EventsDAO = new BL_EventsList_DAO();
         AllEves = EventsDAO.GetAllEvents();
         pastEvents= new LIST<Event__c>();
         upcomingEvents= new LIST<Event__c>();
         MMAllEves = EventsDAO.GetAllEvents();
         MMpastEvents= new LIST<Event__c>();
         MMupcomingEvents= new LIST<Event__c>();
         
         for(Event__c event: AllEves){
             // To get Up coming events 
             if(event.EV_StartDate__c >= system.today()){
                 upcomingEvents.add(event);
                 // To get Match Making Up coming events 
                 if(event.Is_MatchMaking_Event__c==true){
                     MMupcomingEvents.add(event);
                 }
             }else if(event.EV_EndDate__c < system.today()) { // To get past events 
                 pastEvents.add(event);
                 // To get Match Making Up coming events 
                 if(event.Is_MatchMaking_Event__c==true){
                     MMpastEvents.add(event);
                 }
             }
             // to get all match making events
             if(event.Is_MatchMaking_Event__c==true){
                     MMAllEves.add(event);
             }
         }
         system.debug('AllEves---'+AllEves );         

    }


}