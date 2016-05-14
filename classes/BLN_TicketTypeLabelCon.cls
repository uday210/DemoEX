public with sharing class BLN_TicketTypeLabelCon{
    public BLN_TicketTypeLabelCon(){
    }
    
    public List<Reg_Setting__c> RegList{get;set;}
    public List<Reg_Setting__c> ticketTypeLabelNames(string SelectedEvent){
        RegList=new List<Reg_Setting__c>();
        RegList=[select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c,Required__c from Reg_Setting__c where Event__c= : SelectedEvent and Table_Name__c='Item_Type__c' and Setting_Type__c='Display' and Included__c=true and (Column_Name__c= 'Attendee' OR Column_Name__c= 'Exhibitor' OR Column_Name__c= 'Speaker' OR Column_Name__c= 'Sponsor')];
        System.debug(RegList.size()+'<<KKKKK>>'+RegList); 
        return RegList;
    }
    
    
    public MAp<string,string> displaySettingsMap {get;set;}
    public MAp<string,string> displaySettingLabels(string SelectedEvent){ 
        displaySettingsMap=new MAp<string,string>();
        for(Reg_Setting__c r : [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c,Required__c from Reg_Setting__c where Event__c= : SelectedEvent and Table_Name__c='Item_Type__c' and Setting_Type__c='Display' and Included__c=true and (Column_Name__c= 'Attendee' OR Column_Name__c= 'Exhibitor' OR Column_Name__c= 'Speaker' OR Column_Name__c= 'Sponsor')]){
            string label='';
            if(displaySettingsMap.containsKey(r.Column_Name__c)){
                label=displaySettingsMap.get(r.label_Name__c);
                displaySettingsMap.put(r.label_Name__c,label);
            }else{
                displaySettingsMap.put(r.label_Name__c,r.Column_Name__c);
            }
        }
        return displaySettingsMap;   
    }
}