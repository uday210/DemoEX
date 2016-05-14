trigger updateDummyField on Constomer__c (before update, after update) {

List<Dummay__c> dummylist = new List<Dummay__c>();
List<Dummay__c> dummylist1 = new List<Dummay__c>();
SET<String> TicketSet = new SET<String>();
MAP<ID, id> findDuplicateDummy = new MAP<ID, id>();
Set<Id> ids = trigger.newMap.keySet();

dummylist=[select id,Email__c,customer_key__r.Email__c,Primary_Attendee__c from Dummay__c where customer_key__r.id IN :ids];

if(trigger.isAfter){
    for(Dummay__c dummy:dummylist)
    {       
     if(dummy.Email__c == dummy.customer_key__r.Email__c && !findDuplicateDummy.containsKey(dummy.customer_key__c) ){
         dummy.Primary_Attendee__c = true;   
         findDuplicateDummy.put(dummy.customer_key__c , dummy.Id);
     }
    }  
    update dummylist;
}

else{
    for(Constomer__c c : trigger.new){   
        dummylist1=[SELECT ID,Email__c,customer_key__r.Email__c,TicketTypes__r.TT_Name__c FROM Dummay__c WHERE customer_key__r.id =: c.id];
        for(Dummay__c d:dummylist1){
            String ticketvalue = d.TicketTypes__r.TT_Name__c;      
            Ticketset.add(ticketvalue);
        }
        String ticketString = '';
        for(String s:Ticketset) {
            ticketString += (ticketString==''?'':',')+s;
        }   
        c.Ticket_Types__c = ticketString;
    }
}

}