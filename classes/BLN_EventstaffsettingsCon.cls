public without sharing class BLN_EventstaffsettingsCon {
    
    public BLN_UtillDisplayLinks Eventstaffsettings {get ; set ;}
    public LIST<selectoption> roles {get ; set ;}
    public string selectedRole {get ; set ;}
    public LIST<Reg_Setting__c> RegSettings {get ; set ;}
    public LIST<LIST<Reg_Setting__c>> saveres {get ; set ;}
    public string selectedeventId {get ; set ;}
    public LIST<Reg_Setting__c> settings {get ; set ;} 
    public LIST<string> roleslist {get ; set ;}
    public BLN_EventstaffsettingsCon(){
    try{
        saveres = new LIST<LIST<Reg_Setting__c>> ();
        settings = new LIST<Reg_Setting__c> ();
        roleslist = new LIST<string> ();
        Eventstaffsettings = new BLN_UtillDisplayLinks();
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
            if(k!=null){
                selectedeventid = k.getValue();
            }        
        
        BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
        BLN_Event__c  se = new BLN_Event__c  ();
        try{
            se = blneventdetailbal.eventdetails(selectedeventid);
        }catch(exception e){}
        
        Eventstaffsettings.isEventstaffsettingsPage ='active';
        Eventstaffsettings.isEventsettingsExpand = 'expand';
        Eventstaffsettings.tablabel='Event Staff Settings'; 
         Eventstaffsettings.EventId = selectedeventid ;
         Eventstaffsettings.eventName=se.NAme;
        Eventstaffsettings.userPermissions(userInfo.getUserId(),selectedeventid );
      
        
        
            
        roles = new  LIST<selectoption> ();
        roles.add(new selectoption('Full Admin','Full Admin'));
        roles.add(new selectoption('Onsite Staff','Onsite Staff'));
        roles.add(new selectoption('Registration User','Registration User'));
        roleslist.add('Full Admin');
        roleslist.add('Onsite Staff');
        roleslist.add('Registration User');
        selectedRole = 'Full Admin';
        BLN_Eventstaffsettings_BAL settingsBAL = new BLN_Eventstaffsettings_BAL ();
        settings = settingsBAL.getdefaultsettings(selectedeventid);
        getsettings();      
        }catch(exception ex){}
    } 
     public void getsettings(){
     //selectedRole = Apexpages.Currentpage().getparameters().get('selectedRole');
           RegSettings  = new LIST<Reg_Setting__c> ();   
             for(Reg_Setting__c reg : settings ){
                  Reg_Setting__c rec = new Reg_Setting__c ();
                     IF(reg.Column_Name__c == selectedRole){
                         rec = reg;                                                                       
                         RegSettings.Add(rec); 
                     } 
                 system.debug('ccccccccccccccccccccccccccccccccccc'+saveres);
             }
     }
    public void Savesettings(){
    BLN_Eventstaffsettings_BAL settingsBALsave = new BLN_Eventstaffsettings_BAL ();
    system.debug('sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+RegSettings);
    settingsBALsave.savesettings(RegSettings);
    }
}