public with sharing class BLN_Seminars_DAO {
 public Static boolean isMobile=false;
    public LIST<Agenda__c> allSemiorItemsList(ID eventId){
         LIST<Agenda__c> seminors;
        if(isMobile){
          seminors = [SELECT Video__c,IsDeleted,ID,BLN_Ticket__c,Agenda_Name__c,Agenda_Type__c, NAME, BLN_Track__c, BLN_Track__r.Name, BLN_Track__r.Event__c, Agenda_Description__c,lastmodifieddate,Agenda_Display_Order__c,
                        (SELECT ID, NAME, Agenda__c, Slot_End_date__c, Slot_Start_date__c,  Room__c, Room__r.NAME,room__r.Room_Number__c,Agenda__r.BLN_Track__c FROM Time_Slots__r ),(SELECT id,isDeleted,Name from Attachments),Visibility__c  FROM Agenda__c WHERE Event__c =: eventId  Order By Agenda_Display_Order__c DESC all rows]; 
          }else{
            seminors = [SELECT Video__c,IsDeleted,ID,BLN_Ticket__c,Agenda_Name__c,Agenda_Type__c, NAME, BLN_Track__c, BLN_Track__r.Name, BLN_Track__r.Event__c, Agenda_Description__c,lastmodifieddate,Agenda_Display_Order__c,
                        (SELECT ID, NAME, Agenda__c, Slot_End_date__c, Slot_Start_date__c,  Room__c, Room__r.NAME,room__r.Room_Number__c,Agenda__r.BLN_Track__c FROM Time_Slots__r ),(SELECT id,Name,isDeleted from Attachments),Visibility__c  FROM Agenda__c WHERE Event__c =: eventId  Order By Agenda_Display_Order__c DESC];
        
           }
        return seminors;
        
    }

}