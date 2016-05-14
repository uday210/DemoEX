public with sharing class BLN_EventsListCon {

    public LIST<BLN_Event__c> pastEvents{ get; set; }
    public LIST<BLN_Event__c> upcomingEvents{ get; set; } 
    public LIST<BLN_Event__c> AllEves{ get; set; }      
      
    public BLN_EventsListCon(){
        AllEvents();
    }
    
    Public void AllEvents(){
         
         BLN_EventsList_DAO EventsDAO = new BLN_EventsList_DAO();
         AllEves = EventsDAO.GetAllEvents();
         pastEvents= new LIST<BLN_Event__c>();
         upcomingEvents= new LIST<BLN_Event__c>();
         for(BLN_Event__c event: AllEves){
             if(event.Start_Date__c >= system.today()){
                 upcomingEvents.add(event);
             }else if(event.End_Date__c < system.today()) {
                 pastEvents.add(event);
             }
         }
         system.debug('AllEves---'+AllEves );         

    }
    

}