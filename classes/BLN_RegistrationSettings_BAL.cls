/***********************************************************************************************
*   Controller Name : BLN_Registration_Settings_BAL
*   Date            : 06/10/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is for add and edit ticket settings
*   Change History  : 05/19/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  06/10/2014          Phani Kumar ch                   To Create Page
*  
**************************************************************************************************/

public with sharing class BLN_RegistrationSettings_BAL {
public boolean isregistrationPage{get;set;} 
  public BLN_RegistrationSettings_BAL(){
    isregistrationPage = false;
  }
  
  
  public List<Reg_Setting__c>  CurrentEventSettings(string eventId) {
   List<Reg_Setting__c> regList = new List<Reg_Setting__c>(); 
   regList = [select Group_Label__c,id,Column_Name__c,Event__c,order__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,item_pool__r.Ticket_Settings__c  from Reg_Setting__c where event__c=:eventId and item__c =null  and item_pool__c =null and Setting_Type__c='Regular' order by Group_Order__c,order__c ASC];
   return regList ;
  }
 
public List<innserForchk>  ticketchkInn{get;set;}
public BLN_Reg_Settings_DAO regSettingsdel{get;set;}

 public List<innserForchk> getTickets(List<BLN_Item__c> tcList,string eventId ){
    ticketchkInn = new List<innserForchk>();
    SET<id> poolIdsIds = new SET<id>();
    MAP<id,List<Item_Pool__c>> mapPkgidWithLineitems = new MAP<id,List<Item_Pool__c>>();
    List<Item_Pool__c> listOfItempools = new List<Item_Pool__c>();
    
    listOfItempools =[select id,Item_Pool_Name__c,Item_Type__c,Ticket_Settings__c,Package_Flag__c,Addon_Parent__c,Event__c from Item_Pool__c where Event__c=:eventId and Addon_Parent__c!=null order By Ticket_Settings__c ];
   
    for(Item_Pool__c ip :listOfItempools ){
        poolIdsIds.add(ip.Addon_Parent__c);
    }  
    
    for(id itempoolId : poolIdsIds){ 
        List<Item_Pool__c> itp = new List<Item_Pool__c>();
      for(Item_Pool__c ip1 :listOfItempools){
        itp.add(ip1);
       }
        mapPkgidWithLineitems.put(itempoolId,itp);
    }
    
    
    for(BLN_Item__c blnTc : tcList){
        if(mapPkgidWithLineitems.get(blnTc.Item_Pool__c)!=null){
             ticketchkInn.add(new innserForchk(blnTc,mapPkgidWithLineitems.get(blnTc.Item_Pool__c)));
            
        }else{
             ticketchkInn.add(new innserForchk(blnTc,new List<Item_Pool__c>()));
        }
     
    }
    return ticketchkInn;
 }
 
  
  
 // Send only group atleast on include or required selecetd 
  public MAP<id,List<Reg_Setting__c>> regsettings(SET<id> ticIds,string eventId){
      isregistrationPage =true;
     return  getTicketSettings(ticIds,eventId);
  }
  
 
  // Get registration settings event level means when we select collect info from each attendee
  public MAP<id,List<Reg_Setting__c>> getTicketSettings(SET<id> ticIds,string eventId){
    MAP<id,MAP<string,Reg_Setting__c>> mapidWithMap = new MAP<id,MAP<string,Reg_Setting__c>>();
    List<Reg_Setting__c> regs = new List<Reg_Setting__c>();
    SET<id> tcIdsLocal = new SET<id>();
    tcIdsLocal.AddAll(ticIds);
    SET<id> itpids = new SET<id>()
    ;
   for(BLN_Item__c blnitem : [select id,Item_Pool__c from BLN_Item__c where Id in :ticIds ]){
    itpids.add(blnitem.Item_Pool__c);
   }
   
    for(Item_Pool__c blnitem1 : [select id,Addon_Parent__c  from Item_Pool__c where Addon_Parent__c in :itpids ]){
     tcIdsLocal.add(blnitem1.id);
     ticIds.add(blnitem1.id);
   }
   
   MAP<id,List<Reg_Setting__c>> mapFinalListSettings = new  MAP<id,List<Reg_Setting__c>>();
   MAP<id,List<Reg_Setting__c>> mapFinalListSettingstogive = new  MAP<id,List<Reg_Setting__c>>();
   BLN_Reg_Settings_DAO regDao=new BLN_Reg_Settings_DAO();
   List<Reg_Setting__c> regSettingsmain =regDao.setsResDefaultEvent('Regular');
   
   
    regs = [select Group_Label__c,id,Defaullt_Label__c,Column_Name__c,Event__c,Included__c,Update_Access__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,order__c,item_pool__r.Ticket_Settings__c  from Reg_Setting__c where (item__c In :ticIds or Item_Pool__c IN :ticIds) and event__c=:eventId order by Group_Order__c,order__c ASC];
    for(id tcid :tcIdsLocal){
        //MAP<string,Reg_Setting__c> mapFieldNameWithbj = new MAP<string,Reg_Setting__c>();
        List<Reg_Setting__c> listres = new List<Reg_Setting__c>();
         for(Reg_Setting__c reg :regs){
            if(reg.Item__c==tcid || reg.item_pool__c ==tcid){
             
             /* if(isregistrationPage){
                 if(reg.Included__c==true || reg.Required__c==true){
                    listres.add(reg);
                 }
               }else{*/
                 listres.add(reg);
               //}
            }
        }
        mapFinalListSettings.put(tcid,listres);
    }
    
    
    for (Id key : mapFinalListSettings.keySet()) {
    List<Reg_Setting__c> regsettingsticket=new List<Reg_Setting__c>(mapFinalListSettings.get(key));
    List<Reg_Setting__c> regSettings=new List<Reg_Setting__c>(regSettingsmain);
    
     
                 for(integer j=0;j<regsettingsticket.size();j++)
                 {
                 for(integer i=0;i<regSettings.size();i++)
                 {
                   if(regsettingsticket[j].Defaullt_Label__c==regSettings[i].Defaullt_Label__c)
                   {
                     regSettings[i]=regsettingsticket[j];
                   }
                 }
                 }
                 
                 
                 List<Reg_Setting__c> regstogive=new List<Reg_Setting__c>();
     for(integer i=0;i<regSettings.size();i++)
                 {
                 if(isregistrationPage){
                 if(regSettings[i].Included__c==true ){
                   regstogive.add(regSettings[i]);
                   }}
                   else{
                 regstogive.add(regSettings[i]);
               }
                 }  
           mapFinalListSettingstogive.put(key,regstogive);      
                 
}
   
  /** List<Reg_Setting__c> regList = new List<Reg_Setting__c>(); 
  regList = [select id,Column_Name__c,Event__c,order__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,item_pool__r.Ticket_Settings__c  from Reg_Setting__c where event__c=:eventId and item__c =null  and item_pool__c =null and Setting_Type__c='Regular' order by Group_Order__c,order__c ASC];
  
  MAP<id,List<Reg_Setting__c>> mapFinalListSettings = new  MAP<id,List<Reg_Setting__c>>();
   //To Assingning values to default event
   for(id tcid :tcIdsLocal){ 
    MAP<string,Reg_Setting__c> mapId = new MAP<string,Reg_Setting__c>();
    mapId=mapidWithMap.get(tcid);
    List<Reg_Setting__c> listres = new List<Reg_Setting__c>();
        for(Reg_Setting__c res :regList){
                if(mapId.get(res.Column_Name__c)!=null){
               listres.add(mapId.get(res.Column_Name__c));
            }else{
            Reg_Setting__c rest = new Reg_Setting__c();
             rest.Column_Name__c = res.Column_Name__c;
              if(rest.Column_Name__c != 'First_Name__c' && rest.Column_Name__c!='Last_Name__c' && rest.Column_Name__c!='Email__c'){
                 rest.Included__c = false;
                 rest.Required__c = false;
               }
             
             rest.Order__c = res.Order__c;
             rest.Event__c = res.Event__c;
             rest.Group_Name__c  = res.Group_Name__c;
             rest.Table_Name__c = res.Table_Name__c;
             rest.Label_Name__c = res.Label_Name__c;
             listres.add(rest);
            }           
        }
       mapFinalListSettings.put(tcid,listres); 
     } 
   **/  
   return mapFinalListSettingstogive;
  
 }
 
 
  public List<Reg_Setting__c> AllticketSettings(string eventId, string typeOfGroup){
    return [select Group_Label__c,id,Group_Name__c,Column_Name__c,Event__c,order__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,item_pool__r.Ticket_Settings__c from Reg_Setting__c where event__c =:eventId and item__c=null and item_pool__c=null and Setting_Type__c = :typeOfGroup order by Group_Order__c,order__c ASC];
 }
 
 
  
 public void deletedeseletedValues(SET<string> delIds,string eveId){
    regSettingsdel = new BLN_Reg_Settings_DAO();
    regSettingsdel.deleteRegset([select Group_Label__c,id,Column_Name__c,Event__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,item_pool__r.Ticket_Settings__c from Reg_Setting__c where Event__c =:eveId and Group_Name__c in :delIds]);
 }
  
  // get Global event settings and group name to diaply in visulforce page
  public MAP<string,List<Reg_Setting__c>> getDefaultglobalEventSett(){
    List<Reg_Setting__c> rgList = new List<Reg_Setting__c>(); 
    SET<string> groups = new SET<string>();
    MAP<string,List<Reg_Setting__c>> mapGpWithRegs = new MAP<string,List<Reg_Setting__c>>();
    rgList = [select Group_Label__c,id,Group_Name__c,Column_Name__c,Event__c,Table_Name__c,Label_Name__c,order__c,Included__c,Required__c,item_pool__r.Ticket_Settings__c from Reg_Setting__c where event__r.Name='Default Event(Boothleads)' and Setting_Type__c='Regular' and item__c =null  and item_pool__c =null order By Group_Order__c];
    for(Reg_Setting__c rg :rgList ){
        groups.add(rg.Group_Name__c);
    }
   for(string gpName :groups){ 
    List<Reg_Setting__c> tempList = new List<Reg_Setting__c>(); 
     for(Reg_Setting__c rgq :rgList ){
      if(gpName ==rgq.Group_Name__c){       
        tempList.add(rgq);
      }
    }
    mapGpWithRegs.put(gpName,tempList);
   } 
   return mapGpWithRegs;
  }
  
  
 
    public class innserForchk{
        public boolean selectedchk{get;set;}  
        public BLN_Item__c  ticket{get;set;}
        public List<Item_Pool__c> itemPools{get;set;}
        
        public innserForchk(BLN_Item__c tc,List<Item_Pool__c> itemPoolsInn){
            ticket = new BLN_Item__c();
            selectedchk =false;
            itemPools = new List<Item_Pool__c>();
            this.ticket = tc;
            this.itemPools=itemPoolsInn;
        }
    } 
    
    
    public MAP<id,List<Item_Pool__c>> ItemsPoolsAndSettings(SET<id> poolIdsIds,string eventId ){
       
    MAP<id,List<Item_Pool__c>> mapPkgidWithLineitems = new MAP<id,List<Item_Pool__c>>();
    List<Item_Pool__c> listOfItempools = new List<Item_Pool__c>();
    listOfItempools =[select id,Item_Pool_Name__c,Item_Type__c,Ticket_Settings__c,Package_Flag__c,Addon_Parent__c,Event__c from Item_Pool__c where Event__c=:eventId and Addon_Parent__c!=null and Badgable__c='B - Badge' order By Ticket_Settings__c ];
      
      SET<id> poolIds = new SET<id>();
      for(Item_Pool__c itemPoolV:listOfItempools ){
         poolIds.add(itemPoolV.Addon_Parent__c);
      }
    
      for(id itempoolId : poolIds){ 
        List<Item_Pool__c> itp = new List<Item_Pool__c>();
            for(Item_Pool__c ip1 :listOfItempools){
            system.debug('11111111111 '+ip1.Addon_Parent__c +' 222222222222 '+itempoolId );
              if(ip1.Addon_Parent__c==itempoolId ){ 
                 itp.add(ip1);
             }
           }
          mapPkgidWithLineitems.put(itempoolId,itp);
       }
       
        MAP<id,List<Item_Pool__c>> mapPkgidWithLineitems1 = new MAP<id,List<Item_Pool__c>>();
       for(BLN_item__c ite:[select id,item_pool__c from BLN_item__c  where ID In :poolIdsIds]){
          mapPkgidWithLineitems1.put(ite.id,mapPkgidWithLineitems.get(ite.item_pool__c));
       }
       
       
       return mapPkgidWithLineitems1;
    }
     
 
}