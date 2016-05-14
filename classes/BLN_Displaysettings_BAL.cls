public without sharing class BLN_Displaysettings_BAL {


   /***********************************************************************************************
    *   Controller Name         : BLN_Displaysettings_BAL
    *   Date                    : 05/08/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for display settings in registration form.
    **************************************************************************************************/

    Public SET<STRING> failuremessageset {get;set;}
    
    public List<Reg_Setting__c> getregsettingslist(String selectedeventid){
        List<Reg_Setting__c> regsettingslist  = new List<Reg_Setting__c>();        
        BLN_Reg_Settings_DAO  blnregsetdao= NEW BLN_Reg_Settings_DAO ();        
        regsettingslist  = blnregsetdao.getregsettingslist(selectedeventid);        
        return regsettingslist;   
    }
    
    public List<Reg_Setting__c> attendeeSetUpList(String selectedeventid){
        List<Reg_Setting__c> regsettingslist  = new List<Reg_Setting__c>();        
        BLN_Reg_Settings_DAO  blnregsetdao= NEW BLN_Reg_Settings_DAO ();        
        regsettingslist  = blnregsetdao.attendeeSettingsSetUp(selectedeventid);        
        return regsettingslist;   
    }
    
    Public void updateregsettings(List<Reg_Setting__c> regsettingslist){
    
        BLN_Reg_Settings_DAO  blnupdateSet= NEW BLN_Reg_Settings_DAO ();
        blnupdateSet.updateSet(regsettingslist);
    }
    
    
}