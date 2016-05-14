trigger CustomizeTabs on Event__c (after insert) {
 //For Adding two default matchleads tabs records for tab names customization
       LIST<Tags__c> ListOfTabs = new LIST<Tags__c> ();
        system.debug('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh'+Event.id);
               for(Event__c Event : Trigger.new ){
               Tags__c newTag1 = new Tags__c (); 
               newTag1.Default_Name__c = 'Attendee';
               newTag1.Alias_Name__c = 'Attendee Directory';
               newTag1.Event__c = Event.id;
               ListOfTabs.add(newTag1);
               //insert newTag1;
               system.debug('-----------------newTag1'+newTag1.id);
               Tags__c newTag2 = new Tags__c (); 
               newTag2.Default_Name__c = 'Exhibitor';
               newTag2.Alias_Name__c = 'Exhibitor Directory';
               newTag2.Event__c = Event.id;
               //insert newTag2;
               ListOfTabs.add(newTag2);
                system.debug('-----------------newTag2'+newTag2.id);
                }
                insert ListOfTabs;
}