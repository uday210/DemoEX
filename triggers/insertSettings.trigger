trigger insertSettings on Event__c (After insert) {
   
  for(Event__c eve:trigger.new){ 
   Event_Registration_jun__c Ers = new Event_Registration_jun__c();
    ers.Event__c =eve.id;
    ers.Setting_Type__c = 'Collect information below for the ticket buyer only';
    Insert ers;
    
    
    Registration_Settings__c rs = new Registration_Settings__c();
    rs.EventRegistration__c =ers.id;
    insert rs;
    Profile_Settings__c Ps = new Profile_Settings__c();
    ps.Event__c = eve.id;
    ps.Name = 'Corporate';
    Insert ps;
    Profile_Settings__c Ps1 = new Profile_Settings__c();
    ps1.Event__c = eve.id;
    ps1.Name = 'MBE';
    Insert ps1;    
    
   }


}