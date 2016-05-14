public with sharing class BLN_ticketfeesettings_BAL {

    public LIST<BLN_Item__c> savetickchange(LIST<BLN_Item__c> Items,string selectedopt,string ticfee){
        LIST<BLN_Item__c> itemsbl = new LIST<BLN_Item__c> ();
        system.debug('::::::::::ITEMS222222::::::::::::::'+Items );
        for(BLN_Item__c BLS1 : Items ){
               BLS1.service_fee__c = selectedopt;
               
               if(ticfee != null && ticfee != ' '){
               BLS1.Ticket_Settings__c = ticfee;
               }
               itemsbl.add(BLS1);
                system.debug('::::::::::ITEMS222222::::::::::::::'+itemsbl); 
               }
         update itemsbl;
        return itemsbl;
    
    
    }
    
     






}