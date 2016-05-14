public without sharing class BLN_Event_DAO{
   
     
    //Getting EventDetails By Id
   public List<BLN_Event__c> getEventDetails(String eventId){
    List<BLN_Event__c> eventdetails =[SELECT Max_Num_Tickets__c,AllowedLRDevicescount__c,AllowNoticketSessions__c,AllowedDevicescount__c,scan_attendee_limit__c,BLN_Country__r.Currency__r.Name,organizer_id__c,owner.Name,Event_Ticket_Options__c, is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c, State__c, 
                                         Start_Date__c,End_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,Registration_Template__c,
                                         Description__c,Country__c, City__c ,CreatedBy.Name ,BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,
                                        BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c,BLN_Country__r.Short_Name__c,
                                        BLN_Country__r.Currency__r.Currency_Symbol__c,Tax_Rate__c,Accept_Tax_Rate__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,owner.userName,(select Registration_Type__c ,Pay_Gateway__r.use_host_page__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r) 
                                      ,organizer_id__r.owner.id FROM BLN_Event__c 
                                      WHERE id =: eventId];    
    return eventdetails;
   }

    //Getting EventDetails By Id
   public BLN_Event__c getEventInfo(String eventId){
   try{ 
    BLN_Event__c eventdetails =[SELECT AllowedLRDevicescount__c,AllowNoticketSessions__c,AllowedDevicescount__c,scan_attendee_limit__c,BLN_Country__r.Currency__r.Name,organizer_id__c,owner.Name,Event_Ticket_Options__c, is_Corporate__c, ZipCode__c, Website_Url__c, Waitlist__c, Venue_Name__c, User_Company__c,
                                        Twitter_URL__c, Twitter_Hash_Tag__c, Time_Zone__c, SystemModstamp, Street2__c, Street1__c, State__c, 
                                         Start_Date__c,End_Date__c, Social_Hashtag__c, Show_Map__c, Phone_Number__c, Password__c, 
                                        PO_Box__c, OwnerId, Organizer_Email__c, Name, Logo_URL__c, LastModifiedById, IsDeleted, Id, 
                                        Facebook_URL__c, Event_Type__c, Event_Topic__c, Event_Status__c, Event_Privacy__c,Registration_Template__c,
                                         Description__c,Country__c, City__c ,CreatedBy.Name ,BLN_State__c,BLN_State__r.Long_Name__c,BLN_State__r.Short_Name__c,
                                        BLN_State__r.Country__c,BLN_State__r.Country__r.Long_Name__c,BLN_State__r.Country__r.Short_Name__c,Show_Terms_Checkbox__c,BLN_Country__r.Short_Name__c,
                                        BLN_Country__r.Currency__r.Currency_Symbol__c,Tax_Rate__c,Accept_Tax_Rate__c,Terms_Conditions__c,Accept_Terms_Conditions__c,Accept_Refund_Policy__c,Refund_Policy__c, LinkedIn_URL__c, Language_Settings__c,Event_Blog_URL__c,owner.userName,(select Registration_Type__c ,Pay_Gateway__r.use_host_page__c,Pay_Gateway__r.PGateway_Type__r.Name,Pay_Gateway__r.PG_Email_Id__c,Pay_Gateway__r.PG_Pass_Secret__c,Pay_Gateway__r.PG_Signature__c,Pay_Gateway__r.PGateway_Type__r.Adaptive_Type__c,Pay_Gateway__r.PG_User_Key__c from Event_Pay_Gateway__r) 
                                      ,organizer_id__r.owner.id FROM BLN_Event__c 
                                      WHERE id =: eventId];    
    return eventdetails;
   }catch(exception we){
    return null;    
   } 
   }
    //Getting EventDetails By Id
   public List<BLN_Event__c> getevents(SET<id> ids){
    return [select City__c,Logo_URL__c ,Start_Date__c,id,Name  from BLN_Event__c where Id In :ids];    
   
   }
     
    //insert event by phani
   public void  updateEve(BLN_Event__c eve){
    //return [select City__c,Logo_URL__c ,Start_Date__c,id,Name  from BLN_Event__c where Id In :ids];  
    dataBase.update(eve,false);  
   }

}