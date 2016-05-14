trigger insertDefaultSettings on BLN_Event__c (after insert) {
    List<Reg_Setting__c>  GlobalEventSettings = new List<Reg_Setting__c>();
    List<Reg_Setting__c>  GlobalEventSettingsnew = new List<Reg_Setting__c>();
   
    List<BLN_Participant_Role__c> prlist=new List<BLN_Participant_Role__c>();
    GlobalEventSettings =[select Images__c,Defaullt_Label__c,Column_Name__c,Event__c,Group_Name__c,Included__c,Item__c,Item_Pool__c,Order__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Group_Order__c,Sales_Message__c from Reg_Setting__c where Event__r.Name='Default Event(Boothleads)' and (Setting_Type__c ='Event Staff' OR Setting_Type__c ='Display' OR Setting_Type__c ='Quick' OR Setting_Type__c ='Eventdexapp' OR Setting_Type__c ='RegistrationLink')];
    for(BLN_Event__c eve : trigger.new){
        for(Reg_Setting__c regs:GlobalEventSettings){
            Reg_Setting__c  reg = new Reg_Setting__c ();
            reg = regs.clone();
           /* if(eve.Description__c != NULL && reg.Column_Name__c == 'Sales Message'){
                reg.Sales_Message__c = eve.Description__c;
            } */
            reg.event__c = eve.id;
            GlobalEventSettingsnew.add(reg);
        }
        
       for(Reg_Setting__c rg:[select Images__c,id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__r.Name='Default Event(Boothleads)' and Table_Name__c='Item_Type__c' and Setting_Type__c='Mobile'])
       {
          Reg_Setting__c  reg = new Reg_Setting__c ();
            reg = rg.clone();
            reg.event__c = eve.id;
            GlobalEventSettingsnew.add(reg);
       }  
         //Copy 4 default bln participant roles from default boothleads event
       for(BLN_Participant_Role__c pr:[select id,name,BLN_Events__c,BLN_Events__r.Name from BLN_Participant_Role__c where BLN_Events__r.Name='Default Event(Boothleads)'])
       {
          BLN_Participant_Role__c prnew= new BLN_Participant_Role__c();
            prnew= pr.clone();
            prnew.BLN_Events__c= eve.id;
            prlist.add(prnew);
       }   
        
    }
    DataBase.insert(GlobalEventSettingsnew,false);
    DataBase.insert(prlist,false);
    
    
   
    
    
}