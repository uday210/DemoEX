trigger insertemailcampaigns on BLN_Event__c (after insert) {


 List<EmailCampaign__c> emailcampslist = new  List<EmailCampaign__c>([select NAME,Product_Type__c,Event__r.Name,CampEmailTemplate__c,System_Template_Type__c,CampFromEmailId__c, CampFromName__c, Owner.Name, CampSubject__c, CampType__c, Event__c, ToList__c, ToListType__c from EmailCampaign__c WHERE Event__r.Name='Default Event(Boothleads)']);
 system.debug(' EMAIL CAMPAIGNS '+emailcampslist.Size());
  List<EmailCampaign__c> nwemailcamplist = new  List<EmailCampaign__c>();

    for(BLN_Event__c eve :trigger.new){
        system.debug(' EVENT DETAILS '+eve);
         for(EmailCampaign__c et : emailcampslist )
         {
            EmailCampaign__c emailcamp = new EmailCampaign__c();
            emailcamp.Name =  et.Name;
            emailcamp.CampEmailTemplate__c= et.CampEmailTemplate__c;
            emailcamp.CampFromEmailId__c =eve.Organizer_Email__c;
            emailcamp.CampSubject__c  = et.CampSubject__c;
            emailcamp.Event__c=eve.id;
            emailcamp.Available_to_Use__c = true;
            emailcamp.Template_Type__c = 'Standard';
            emailcamp.CampType__c = et.CampType__c;
            emailcamp.ToListType__c='Selected Contacts';
            emailcamp.System_Template_Type__c=et.System_Template_Type__c;
            emailcamp.Product_Type__c = et.Product_Type__c;
           // emailcamp.ToList__c ='Attendee'; 
            nwemailcamplist.add(emailcamp); 
         }
    }
     
     Database.insert(nwemailcamplist,false); 
     
     
     
     

}