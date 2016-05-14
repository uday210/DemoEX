public without sharing class BLN_StaffCustomSettings{

    public Event_staff_settings__c getstaffsettings(string role){
    Event_staff_settings__c settings = new Event_staff_settings__c();
    List<Event_staff_settings__c> staffsettings = new List<Event_staff_settings__c>();
    staffsettings = Event_staff_settings__c.getall().values();
    for(Event_staff_settings__c ES: staffsettings){
        
     if(ES.Name == role){
         settings=ES;
     
     }   
    
    
    }
    
    
    system.debug('::::::::::::::settings:::::::::::'+settings );
    
    return settings ;
    
    }



}