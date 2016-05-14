public with sharing class BLN_BoothAdminSetup_BAL {

    public Static BLN_UCRole_DAO ucrdao = new BLN_UCRole_DAO();
    public Static BLN_Group_DAO gnDao = new BLN_Group_DAO();
    public Static BLN_Ticket_DAO tcDao = new BLN_Ticket_DAO();
    public Static BLN_ItemType_DAO itemtypeDao = new BLN_ItemType_DAO();
    public BLN_BoothAdminSetup_BAL() {

    }

    //User profile for this event
    public Boolean  getUserProfile(String eventId) {
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        BLN_Event__c eventslist = blneventdetailbal.eventdetails(eventId);
        boolean isEventAdmin = false;
        for (UC_Role__c ucs : ucrdao.getRolesOfuser(userinfo.getUserName(), eventslist.organizer_id__c)) {
            if (ucs.RoleId__r.Name == 'Company Admin' || ((ucs.RoleId__r.Name == 'Event Admin' && ucs.Event__c == eventId) || (ucs.RoleId__r.Name == 'Full Admin' && ucs.Event__c == eventId))) {
                isEventAdmin = true;
            }
        }
        return isEventAdmin;
    }

// To get groups and respected users
    public groupUsersAndLeadTcs getGpsAndusrs(String eventId) {
        List<GroupAndUsers> gpusers = new List<GroupAndUsers>();
        SET<String> extUsers = new SET<String>();
        boolean isEveAdmin = getUserProfile(eventId);
        LIst<BLN_Group__c> groups = new LIst<BLN_Group__c>();
        List<Ticket__c> tkts = new List<Ticket__c>();
        groups = gnDao.geteventGroups(eventId);
         SET<id> grpIds = new SET<id>();

         if(!isEveAdmin){
           for (UC_Role__c ucr : ucrdao.getUcrolesWithgrps(eventId)) {
                grpIds.add(ucr.BLN_Group__c);
            }
          }
        for (BLN_Group__c gp : groups) {
            Boolean  isEditpermission = false;
            for (UC_Role__c uc : gp.BLN_UC_Role__r ) {
                extUsers.add(uc.GN_User__r.Email__c);
                if (uc.GN_User__r.Email__c == userinfo.getUserName() && uc.RoleId__r.Name == 'BoothLeads Admin')
                    isEditpermission = true;
            }
            System.debug(' Login user Name : ' + userInfo.getUserName() + ' Group Owner : ' + gp.Owner.Username);
            if (isEveAdmin || (gp.Owner.Username == userInfo.getUserName()) )
                gpusers.add(new GroupAndUsers(gp, gp.BLN_UC_Role__r, true));
            else{
                if(grpIds.contains(gp.id))
                  gpusers.add(new GroupAndUsers(gp, gp.BLN_UC_Role__r, isEditpermission));
            }
        }

        if (isEveAdmin)
            tkts = tcDao.getTickets(extUsers, eventId, 'Lead Retrieval');
         else
             tkts = tcDao.getuserTickets(extUsers, eventId, 'Lead Retrieval'); 
         
        groupUsersAndLeadTcs gpu = new groupUsersAndLeadTcs(gpusers, tkts);
        return gpu;
    }

//Saving Group
    public  GroupAndUsers saveGroupName(String grpName, String eveId,String productType) {
        System.debug(' Group Name : ' + grpName);
        BLN_Group__c groupObj = new BLN_Group__c();
        groupObj.Name = grpName;
        groupObj.Event__c = eveId;
        try{
          groupObj.Product_Type__c = itemtypeDao.getItemtype(productType).id;
        }catch(exception uy){}

        Database.SaveResult savR = Database.insert(groupObj, false);
        if (savR.isSuccess()) {
            try {
                BLN_Group__c gp = gnDao.getGroup(savR.getId());
                GroupAndUsers gpUser = new  GroupAndUsers(gp, new List<UC_Role__c>(), true);
                gpUser.message = 'Success';
                return  gpUser;
            } catch (exception er) {
                GroupAndUsers gpUser = new  GroupAndUsers(new BLN_Group__c(), new List<UC_Role__c>(), true);
                gpUser.message = 'Error';
                return null;
            }
        } else {
            GroupAndUsers gpUser = new  GroupAndUsers(new BLN_Group__c(), new List<UC_Role__c>(), true);
            gpUser.message = 'Error';
            return gpUser;
        }
    }
 
//To Update Group Name
    public String updateGroupName(String gnpId, String gpnName) {
        try {
            BLN_Group__c gpr = gnDao.getGroup(gnpId);
            if (gpnName != null && gpnName != '')
                gpr.Name = gpnName;
            Database.update(gpr, false);
        } catch (exception er) {
            return 'Update Failed';
        }
        return 'Success' ;
    }

//Delete Group
    public String deleteGroup(String groupId) {
        BLN_Group__c gpFordelete = new BLN_Group__c();
        try {
            gpFordelete = gnDao.getGroupWithucrole(groupId);
            if (gpFordelete.BLN_UC_Role__r.size() > 0)
                Database.delete(gpFordelete.BLN_UC_Role__r, false);
            Database.DeleteResult dltres =  Database.delete(gpFordelete, false);
            System.debug('  Delete Result : ' + dltres);
            return 'Success';
        } Catch(Exception er) {
            return 'error';
        }
    }

//Inserting group users
    public String insertUcRoles(String eveId, String gpId, List<String> gnuId,String isGroupmerge) {
      List<UC_Role__c> ucrolesins = new List<UC_Role__c>();
      System.debug('isGroupmerge : '+isGroupmerge);
      if(isGroupmerge!='groupTogroup'){ 
        GN_User__c gnuOwner = new GN_User__c();
        try {
            gnuOwner = [SELECT ID FROM GN_User__c where User__c = :userInfo.getUserId()];
        } catch (exception rt) {}
        List<GN_User__c> gnus = new List<GN_User__c>();
        gnus = [select id, Default_Company_ID__c, Email__c from GN_User__c Where id IN :gnuId];

        MAP<id, UC_Role__c> existingusrs = new MAP<id, UC_Role__c>();
        for (UC_Role__c ucrl : [SELECT Id, GN_User__r.Email__c, GN_User__c FROM UC_Role__c WHere Event__c = : eveId AND GN_User__c IN : gnuId AND BLN_Group__c != null]) {
            existingusrs.put(ucrl.GN_User__c, ucrl);
        }
        MAP<String, Id> ridWitrl = new  MAP<String, Id>();
        ridWitrl = getRoles();
        for (GN_User__c gnu : gnus) {
            if (!existingusrs.keySet().contains(gnu.id)) {
                if (null != gnu.Default_Company_ID__c) {
                    UC_Role__c ucr = new UC_Role__c();
                    ucr.BLN_Group__c = gpId;
                    ucr.Accepted_date__c = System.today();
                    ucr.Company__c = gnu.Default_Company_ID__c;
                    ucr.Event__c = eveId;
                    if (null != gnuOwner)
                        ucr.Invited_by__c = gnuOwner.id;
                    ucr.Invited_date__c = System.today();
                    ucr.RoleId__c = ridWitrl.get('BoothLeads Staff');
                    ucr.GN_User__c = gnu.id;
                    ucrolesins.add(ucr);
                }
            } 
        }
        if (ucrolesins.size() > 0) {
            Database.SaveResult[] upres = Database.insert(ucrolesins, false);
            System.debug(' Upsert UCROLE  ' + upres);
        }
      }else{
        try {
              for(UC_Role__c ucr : [SELECT ID, BLN_Group__c from UC_Role__c Where Id IN :gnuId]){
                ucr.BLN_Group__c = gpId ;
                ucrolesins.add(ucr);
               }
               if(ucrolesins.size()>0)
                Database.update(ucrolesins, false);
            } catch (exception er) {}
      } 
        return 'Success';
    }

public MAP<String, Id> getRoles(){
    MAP<String, Id> ridWitrl = new  MAP<String, Id>();
    for (Role__c roles : [SELECT id, Name, Role_Type__c, Role_ShortName__c FROM Role__c]) {
        ridWitrl.put(roles.Name, roles.Id);
    }
  return ridWitrl;  
}
// Assigning Roles
    public String UpdateRole(String ucrId, String role) {
        try {
            Role__c rl = [select id from Role__c Where Name = :role];
            UC_Role__c ucrole = [select Id, RoleId__c from UC_Role__c Where Id = :ucrId];
            ucrole.RoleId__c = rl.id;
            Database.update(ucrole, false);
        } catch (exception er) {
            return 'Update Failed';
        }

        return 'Success' ;
    }

// Assigning Roles
    public  String deleteUcrole(String ucrId) {
     try{ 
      UC_Role__c ucrole = [select Id, RoleId__c from UC_Role__c Where Id = :ucrId];
      Database.delete(ucrole,false);
     }catch(exception rt){
        return 'Error';
     } 
      return 'Success';
    }


    public class groupUsersAndLeadTcs {
        public List<GroupAndUsers> extUcRoles {get; set;}
        public List<Ticket__c> tcs {get; set;}
        public groupUsersAndLeadTcs(List<GroupAndUsers> extUc, List<Ticket__c> tc) {
            extUcRoles = new List<GroupAndUsers>();
            if (extUc.size() > 0)
                extUcRoles = extUc;
            tcs = new List<Ticket__c>();
            if (tc.size() > 0)
                tcs = tc;
        }
    }

    public class GroupAndUsers {
        public BLN_Group__c gp {get; set;}
        public List<UC_Role__c> ucRoles {get; set;}
        public String message {get; set;}
        public boolean isEditPermission {get; set;}

        public GroupAndUsers(BLN_Group__c gpN, List<UC_Role__c> ucR, boolean permissionType) {
            ucRoles = new List<UC_Role__c>();
            isEditPermission = false;
            if (permissionType)
                isEditPermission = permissionType;

            if (ucR.size() > 0)
                ucRoles = ucR;
            gp = new BLN_Group__c();
            if (null != gpN)
                gp = gpN;
        }
    }
}