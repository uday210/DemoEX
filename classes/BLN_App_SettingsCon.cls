public without sharing class BLN_App_SettingsCon {

  public boolean pushNotifInclude { get; set; }
  public BLN_UtillDisplayLinks myticket {get; set;} // This is the variable for Component
  public String selectedeventid {get; set;}
  public LIST<Reg_Setting__c> regsetList {get; set;}
  public LIST<Reg_Setting__c> updateregsetList {get; set;}
  public BLN_Reg_Settings_DAO RegDAO {get; set;}
  public List<inncls> eventdexinn {get; set;}
  public List<inncls> boothleadsinn{get;set;}
  public MAP<string, Reg_Setting__c> regMap {get; set;}
  public Boolean isBoothleadsEnable{get;set;}
  public MAP<String,Boolean> mapTypeWithBool{get;set;}
  public boolean eventdexTab{get;set;}
  public boolean boothleadstab{get;set;}
  public boolean scanattendeerab{get;set;}
 
  //Scan Attendee variables
    public List<BLN_Scanusr_Settings_BAL.itemWithbuyquan> scanattBuyers {get; set;}
    public BLN_Scanusr_Settings_BAL scanBal {get; set;}
    public Integer maxcntsel {get; set;}
    public String selectedGnId{get;set;}
    public List<BLN_Scanusr_Settings_BAL.ItemWithChk> itemsWithset{get;set;}
    public String error {get;set;}
    public BLN_Event__c  eventslist {get;set;}

  public BLN_App_SettingsCon() {
     RegDAO = new BLN_Reg_Settings_DAO();
     eventdexinn = new List<inncls>();
     boothleadsinn= new List<inncls>();
     mapTypeWithBool = new MAP<String,Boolean>();
     isBoothleadsEnable =false;
     
     try {
      Cookie counterval = ApexPages.currentPage().getCookies().get('counter');
      if (counterval != null) {
        selectedeventid = counterval.getValue();
      }
      bln_app_settings_BAL bal = new bln_app_settings_BAL();
      mapTypeWithBool = bal.checkticdetails(selectedeventid);
      scanattendeerab = bal.Scanattendeeflag;
      System.debug(' AAAAAAAAAAAA '+mapTypeWithBool);
      regsetList = RegDAO.getMobileSettings(selectedeventid);
      for (Reg_Setting__c  reg : regsetList) {
         if(reg.Defaullt_Label__c =='Eventdex Tab')
           eventdexTab = reg.Included__c;
          if(reg.Defaullt_Label__c =='Boothleads Tab') 
            boothleadstab =reg.Included__c;
        if((reg.Defaullt_Label__c == 'Lead Retrieval' || reg.Defaullt_Label__c == 'Boothleads Tab' || reg.Defaullt_Label__c == 'With QR Code' || reg.Defaullt_Label__c == 'With Push Notification')){
           boothleadsinn.add(new inncls(reg));
          if(bal.LeadRetrivalflag)
           isBoothleadsEnable =true;
          
        }else{
          if(null!=mapTypeWithBool.get(reg.Defaullt_Label__c) ){
            System.debug('  PPPPPPPPP '+mapTypeWithBool.get(reg.Defaullt_Label__c) +'  Value '+reg.Defaullt_Label__c);
            if(mapTypeWithBool.get(reg.Defaullt_Label__c)) 
             eventdexinn.add(new inncls(reg));
          }else
            eventdexinn.add(new inncls(reg)); 
        }
      }
     System.debug('OOOOOOOOOOOOOOOOOO '+eventdexinn); 
     System.debug('PPPPPPPPPPPPp  '+boothleadsinn); 
      BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
      eventslist = new BLN_Event__c  ();
      try {
        eventslist = blneventdetailbal.eventdetails(selectedeventid);
      } catch (exception e) {}
      myticket = new BLN_UtillDisplayLinks();
      myticket.isAppSettingsPage = 'active'; // To height light Link
      myticket.isEventsettingsExpand = 'expand';
      myticket.tablabel = 'App Settings';
      myticket.eventName = eventslist.Name;
      myticket.eventId = selectedeventid;
      myticket.userPermissions(userInfo.getUserId(), selectedeventid);
    } catch (exception ex) {}
  
   //Scan Attendee Code
    scanattBuyers = new List<BLN_Scanusr_Settings_BAL.itemWithbuyquan>();
    scanBal = new BLN_Scanusr_Settings_BAL(selectedeventid);
            scanattBuyers = scanBal.getScanattBuyers(selectedeventid);//Fetching all Scan Attendee Byers
            if (scanattBuyers.size() > 0) {
                selectedGnId = scanattBuyers[0].gnuser.id;
                getUsrScandetails();
           }
  }
  
  //Scan Attendee Metods Start 
  // This method will fire when ever user click on His Name or Email
    public void selectAct() {
        error='';
        if (selectedGnId != null && selectedGnId != '')
            getUsrScandetails();
    }
   

   // This will return all settings
    public void  getUsrScandetails() {
        maxcntsel = 0;
        itemsWithset = new List<BLN_Scanusr_Settings_BAL.ItemWithChk>();
        itemsWithset =scanBal.showItemsToEa(selectedGnId, selectedeventid);
        maxcntsel = scanBal.usrMaxselcnt;
     }
    
    public pageReference saveSettings(){
      error ='';
     error = scanBal.saveSettings(selectedGnId,selectedeventid,itemsWithset);
      if(error=='Success'){
       getUsrScandetails();
      }
       return null;  
    }
  

  // Tab 1 Save Eventdex Settings Save
  public pageReference saveAppSettings() {
   System.debug(' YYYYYYYYY '+eventdexinn);
    savingSetts(eventdexinn);
    return null;
  }
// Scan Attendee Methods End 

 // Boothleads save Settings
 public pageReference saveBlsettigs(){
   savingSetts(boothleadsinn);
    return null;
 }

  public void savingSetts(List<inncls> ins) {
    BLN_Reg_Settings_DAO RegDAO = new BLN_Reg_Settings_DAO();
    List<Reg_Setting__c> regList = new List<Reg_Setting__c>();
    List<Reg_Setting__c> oldregsetList = RegDAO.getMobileSettings(selectedeventid);
    List<Reg_Setting__c> objDefaultList = RegDAO.getEventdexAppDefaultSettings();    
    MAP<string,Reg_Setting__c> objDefaultMap =  new MAP<string,Reg_Setting__c>();
    
    for(Reg_Setting__c r: objDefaultList){
        objDefaultMap.put(r.Defaullt_Label__c,r);
    }
    
    regMap = new MAP<string,Reg_Setting__c>();
    for(Reg_Setting__c r: oldregsetList){
        regMap.put(r.Defaullt_Label__c,r);
    }
    
    for (inncls reg : ins) {
       if(reg.regset.Defaullt_Label__c=='Eventdex Tab')
          reg.regset.Included__c = eventdexTab;
        if(reg.regset.Defaullt_Label__c=='Boothleads Tab')
          reg.regset.Included__c = boothleadstab;   

       if (!reg.isImageRemoved) {
       if (reg.imageName != null && reg.imageName != '') {
          document mydoc = new document();
          mydoc.body = EncodingUtil.base64Decode(reg.imageBody);
          mydoc.folderid = userInfo.getUserId();
          mydoc.ispublic = true;
          mydoc.Name = reg.imageName;
          DataBase.saveresult svRe = Database.insert(mydoc, false);
          if (svRe.isSuccess()) {
            reg.regset.Images__c = svRe.getId();
          }
        }
      }
      else{
          Reg_Setting__c objDefault = objDefaultMap.get(reg.regset.Defaullt_Label__c);
          if(null!=objDefault)
          reg.regset.Images__c = objDefault.Images__c;
      }

      Reg_Setting__c oldReg = regMap.get(reg.regset.Defaullt_Label__c);
      boolean changed = false;
      if (oldReg.Label_Name__c != reg.regset.Label_Name__c) {
        changed = true;
      }
      if (oldReg.Images__c != reg.regset.Images__c) {
        changed = true;
      }
      system.debug('reg.regset.Included__c' + reg.regset.Included__c);
      if (oldReg.Included__c != reg.regset.Included__c) {
        system.debug('ssssssss');
        changed = true;
      }
      if (changed == true) {
        regList.add(reg.regset);
      }
    }
    DataBase.update(regList, false);
  }
   public void saveSessonSett(){		
    DataBase.update(eventslist,false);		
  }

  public PageReference cancelAppSettings() {
    pagereference pg = new pagereference('/apex/BLN_App_Settings');
    pg.setRedirect(true);
    return pg;
  }

  public Class inncls {
    public String imageName{get; set;}
    public String imageBody{get; set;}
    public Boolean isImageRemoved{get; set;}
    public Reg_Setting__c regset{get; set;}
    public inncls(Reg_Setting__c reg) {
      //imageBody = new Blob();
      regset = new Reg_Setting__c();
      regset = reg;
      isImageRemoved =true;
    }
  }
}