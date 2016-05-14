public with sharing class  BLN_BoothAdminSetupCon {
    public BLN_UtillDisplayLinks leadRetrieval { get; set; }
    public String selectedeventid {get; set;}
    public BLN_Event__c  eventslist {get; set;}
    public Static BLN_BoothAdminSetup_BAL basbal= new BLN_BoothAdminSetup_BAL();

    public BLN_BoothAdminSetupCon() {
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
        if (k != null) {
            selectedeventid = k.getValue();
        }
        if (selectedeventid != null && selectedeventid != '') {
            displayPermissions();
        }
    }

//Displaying all groups and users in that groups
    @RemoteAction
    public Static BLN_BoothAdminSetup_BAL.groupUsersAndLeadTcs getGpsAndusrs(String eventId) {
        return basbal.getGpsAndusrs(eventId);
    }

    // Inserting Group
    @RemoteAction
    public Static BLN_BoothAdminSetup_BAL.GroupAndUsers saveGroupName(String grpName, String eveId,String product) {
        return basbal.saveGroupName(grpName,eveId,product);
    }

    //Update Group Name
    @RemoteAction
    public Static String updateGroupName(String gnpId, String gpnName) {
        return basbal.updateGroupName(gnpId,gpnName);
    }

    //Delete Group
    @RemoteAction
    public Static String deleteGroup(String groupId) {
      return basbal.deleteGroup(groupId);   
    }

    //Inserting group users
    @RemoteAction
    public Static String insertUcRoles(String eveId, String gpId, List<String> gnuId,String isGroupmerge) {
        return basbal.insertUcRoles(eveId,gpId,gnuId,isGroupmerge);
    }

// Assigning Roles
    @RemoteAction
    public Static String UpdateRole(String ucrId, String role) {
      return basbal.UpdateRole(ucrId,role);
    }

// delete UC Roles
    @RemoteAction
    public Static String deleteUcrole(String ucrId) {
      return basbal.deleteUcrole(ucrId);
    }

    public void displayPermissions() {
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        eventslist = new BLN_Event__c  ();

        try {
            eventslist = blneventdetailbal.eventdetails(selectedeventid);
        } catch (exception e) {}
        LeadRetrieval = new BLN_UtillDisplayLinks();
        LeadRetrieval.tablabel = 'Lead Retrival Admin';
        LeadRetrieval.iseventsExpand = '';
        LeadRetrieval.isLRAdminAct = 'active';
        LeadRetrieval.isLeadExpand = 'expand';
        try {
            LeadRetrieval.eventName = eventslist.Name;
        } catch (exception e) {}
        LeadRetrieval.EventId = selectedeventid;
        System.debug(' EVent Name ' + eventslist.Name);
        LeadRetrieval.userPermissions(userInfo.getUserId(), selectedeventid);
    }
}