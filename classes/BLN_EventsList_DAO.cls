public with sharing class BLN_EventsList_DAO{    
    
    public LIST<BLN_Event__c> GetAllEvents(){
        list<BLN_Event__c> Events = [ SELECT Id, is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                      Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c,  
                                     Start_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                      PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, 
                                      Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c, 
                                       End_Date__c,Description__c,  BLN_Country__r.Short_Name__c,BLN_Country__r.Long_Name__c,City__c ,
                                      CreatedBy.Name, BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,BLN_State__r.Country__c,
                                      BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c, 
                                      Tax_Rate__c,Accept_Tax_Rate__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,
                                      Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c 
                                      FROM BLN_Event__c ];
                                      
        system.debug('Events-------------'+Events);
        return Events;
    }
}