public with sharing class BLN_Quick_registration_settingsCon {

   public string selectedstring{get;set;}
   public string eventId1{get;set;}
   public List<selectOption> accordOptions1{get;set;}
   public  SET<string> selectedAcc1{get;set;} 
   public List<InnerClassForTckets> inngroupnew{get;set;}
   public List<Reg_Setting__c> regsOfAlldf {get;set;}
   public MAP<string,List<Reg_Setting__c>> mapGpWithRegs1{get;set;} 
   public BLN_RegistrationSettings_BAL regsetBal1{get;set;}
   public List<innserForDivValues> innDivs{get;set;}
     public MAP<string,List<Reg_Setting__c>> mapGpWithRegsNew{get;set;}
   
   
    public PageReference addNewAccordiannew() {
     List<Reg_Setting__c> regsforInsert = new List<Reg_Setting__c>();
       for(Reg_Setting__c regsdef : mapGpWithRegs1.get(selectedstring)){
         Reg_Setting__c rsc = new Reg_Setting__c();
         rsc = regsdef.clone(false,false,false,false);
         rsc.event__c = eventid1;
         rsc.Setting_Type__c = 'Quick';
         regsforInsert.add(rsc);
       }
        
      dataBase.insert(regsforInsert,false);  
           
        return null;
    }
    
   public PageReference deleteUnchkValues() {
      List<Reg_Setting__c> regsforInsert = new List<Reg_Setting__c>();
      regsforInsert  = mapGpWithRegsNew.get(selectedstring);
      DataBase.delete(regsforInsert,false);
      return null;
    }




 
  public BLN_Quick_registration_settingsCon(){
   
    Cookie k1 = ApexPages.currentPage().getCookies().get('counter');
    if(k1!=null){
      eventId1 = k1.getValue();
    }
    regsetBal1= new BLN_RegistrationSettings_BAL();
   if(eventId1 !=null){
       mapGpWithRegs1 = new MAP<string,List<Reg_Setting__c>>();  
       mapGpWithRegs1=regsetBal1.getDefaultglobalEventSett(); // get groups Names  
       mapGpWithRegs1=regsetBal1.getDefaultglobalEventSett(); // get groups Names 
        accordOptions1 = new List<selectOption>();
        
      mainMethodNew();
    }  
   
  }
  
  
  public MAP<string , Reg_Setting__c > mapLabelWithRegSet{get;set;}
  
  public void mainMethodNew(){
   innDivs = new List<innserForDivValues>();
    inngroupnew  = new List<InnerClassForTckets>();
    mapGpWithRegsNew = new MAP<string , List<Reg_Setting__c> >();
   selectedAcc1 = new SET<string>();
    List<Reg_Setting__c> rsList = new List<Reg_Setting__c>();
    rsList  = [select id,Column_Name__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Label_Name__c,Order__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c from Reg_Setting__c where event__c=:eventId1 and Setting_Type__c='Quick' order by Order__c];
    
    for(Reg_Setting__c rsf: rsList){
       selectedAcc1.add(rsf.Group_Name__c); 
    }
    
    
     for(string GpName : mapGpWithRegs1.keyset()){
          if(selectedAcc1.contains(GpName)){
             innDivs.add(new innserForDivValues(true,GpName ));
           }else{
             innDivs.add(new innserForDivValues(false,GpName ));
           }
       
     }
    
    
   for(string str :selectedAcc1){ 
     List<Reg_Setting__c> rsListforInn = new List<Reg_Setting__c>();
        for(Reg_Setting__c rsfInn: rsList){
         if(str==rsfInn.Group_Name__c){
            rsListforInn.add(rsfInn);
          }
         }
         mapGpWithRegsNew.put(str,rsListforInn);
         inngroupnew.add(new InnerClassForTckets(str ,rsListforInn));  
       } 
  }
  
  
  
  public void save(){
   List<Reg_Setting__c> rsListforInn1 = new List<Reg_Setting__c>();
    for(InnerClassForTckets inn : inngroupnew){
        rsListforInn1.addAll(inn.SeletedTicSettinsgInn);
    }
    dataBAse.update(rsListforInn1,false);
  }
  
  
public class innserForDivValues{
 public boolean selected{get;set;}
 public string gpName{get;set;}
     public innserForDivValues(boolean b,string gp){
         this.gpName=gp;
         this.selected = b;
     }
}

 public class InnerClassForTckets{
     public string groupName{get;set;}
     public List<Reg_Setting__c> SeletedTicSettinsgInn{get;set;}
     public InnerClassForTckets(string nm,List<Reg_Setting__c> cfnm){
       SeletedTicSettinsgInn = new List<Reg_Setting__c>();
       this.SeletedTicSettinsgInn = cfnm;
       this.groupName = nm;
     }
   }



}