public without sharing class BLN_Eventstaffsettings_BAL {
    public LIST<Reg_Setting__c> Regs {get ; set ;}
    
    public LIST<Reg_Setting__c> getdefaultsettings(string eveid){

        Regs = new LIST<Reg_Setting__c> ();
        Regs = [SELECT id,Label_Name__c,Included__c,Read_Access__c,Create_Access__c,Column_Name__c,
                       Update_Access__c,Delete_Access__c FROM Reg_Setting__c where Setting_Type__c =: 'Event Staff' AND Event__c =: eveid];                  
   
        return Regs;
    }
    public void savesettings(LIST<Reg_Setting__c> saverecs){  
    database.update(saverecs);
    }
   

}