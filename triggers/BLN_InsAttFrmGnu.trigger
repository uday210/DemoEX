trigger BLN_InsAttFrmGnu  on Gn_user__c (after insert) {
   // Checking Attendees already esited or Not
    AttendeeSummary_Dao attDao = new AttendeeSummary_Dao();
    BLN_GNUser_BAL blnDao = new BLN_GNUser_BAL();
    SET<String> exitingAttList = new SET<String>();
    List<AttendeeSummary__c> attList = new List<AttendeeSummary__c>();
    List<String> userNames = new List<String>();
   
    //if (Trigger.isAfter) {
        for (Gn_user__c gnu : trigger.new) {
            if (gnu.Email__c != null && gnu.Email__c != '') {
                userNames.add(gnu.Email__c);
            }
        }
        exitingAttList = attDao.getExistingAtt(userNames); // Getting Exiting Attendee Summaries
         System.debug('Trigger BLN_InsAttFrmGnu   '+userNames);
         SET<String> dupRemove = new SET<String>();
        for (Gn_user__c gnUser : trigger.new) {
            if (!exitingAttList.contains(gnUser.Email__c) && !dupRemove.contains(gnUser.Email__c)) { // If not exist in system
                //attList.add(blnDao.assIgnGnv(gnUser)); // Assigning gn user values to Attendee Summary
                dupRemove.add(gnUser.Email__c); // Avoiding Duplicates
            }
        }
          System.debug('attList  '+attList);
        if (attList.size() > 0)
            Database.insert(attList, false); // Inserting attendee Summaries
    //}

}