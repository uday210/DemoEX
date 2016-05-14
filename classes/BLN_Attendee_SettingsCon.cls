/***********************************************************************************************
*   Controller Name : BLN_Registration_Settings
*   Date            : 08/11/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is for add and edit ticket settings
*   Change History  : 08/11/2014(mm/dd/yyyy)
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  08/11/2014          Phani Kumar ch                     To Create Page
**************************************************************************************************/

public with sharing class BLN_Attendee_SettingsCon {

    public String selectedOPtion { get; set; }
public String selectedTicket { get; set; } // This is input hidden value for holding selected ticket id
public BLN_UtillDisplayLinks myticket {get;set;} // This is the variable for Component
public BLN_Event__c event{get;set;} // Event Instance for event details
public MAP<string,List<Reg_Setting__c>> MapTicWithSettings{get;set;} // variable to hold item and its settings
public List<BLN_Item__c> itemList {get;set;} // Items Belongs to this event
public MAP<id,List<Reg_Setting__c>> recSetMap{get;set;}
public List<inncls> inn{get;set;}
public MAP<string,List<Reg_Setting__c>> grupWithReg{get;set;} // To holding groupNAme and its settings of default Event 
public List<innForGroups> inngp{get;set;}
public List<BLN_Item__c> defaultTickets{get;set;} // for displaying default settings of event
public string defTciketId{get;set;}
public List<inncls> innclsListPool{get;set;} // It holds all the settings of itempool
public MAP<id,List<Reg_Setting__c>> mapPoolWithRegset{get;set;} // To hold itempool and its settings
public MAP<id,item_pool__c> mapItempoolWithId {get;set;} // to hold item pool id with itempool
public MAP<id,BLN_Item__c> mapPoolParentIdwithItem{get;set;} // MApping parent Itempool id with item for update with new value in savepool method  
public MAP<string,Reg_Setting__c>  mapLabelWithRs{get;set;}
public string eveType {get;set;}
   
   
 // Contructor
 public BLN_Attendee_SettingsCon(){
  try{
    // apply values to componet to heighlight perticular tab
     string k ='' ;
     Cookie counterval = ApexPages.currentPage().getCookies().get('counter');
    if(counterval !=null){
        k= counterval.getValue();
     }
     
     myticket = new BLN_UtillDisplayLinks();
     myticket.isAttendeeSettingsPage='active'; // To height light Link
     //myticket.isAttendeesPageExpand ='expand'; // To expand parent link
     myticket.isEventsettingsExpand ='expand';
     
     myticket.tablabel='Attendee Settings';  // Tab label
     myticket.eventId = k;
     myticket.userPermissions(userInfo.getUserId(),k);  // Getting Permissions as per login user role
       
     event = new BLN_Event__c  ();
     BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     event= blneventdetailbal.eventdetails(k); // getting event details
     myticket.EventName=event.Name; // to display event Name in component
      // ------------------- End component values ------------------------------------------
      getItems(); //gettting all settinga and tickets at a time
      getItemPools();
      
      BLN_RegistrationSettings_BAL regsetBal1 = new BLN_RegistrationSettings_BAL();
      grupWithReg = new MAP<string,List<Reg_Setting__c>>();
      grupWithReg =regsetBal1.getDefaultglobalEventSett(); // Getting default event and its settings
    
      displayGroups();
   }catch(exception ty){}   
      
    }
  public MAP<id,List<Item_pool__c>> mapIdwithPools{get;set;}
  public List<inncls> innFordefaultTc{get;set;}
  
  
    public List<inncls> getItems(){
      BLN_RegistrationSettings_BAL regsetBal =new BLN_RegistrationSettings_BAL();
      BLN_Quick_Registration_BAL quickBal= new BLN_Quick_Registration_BAL();  
      itemList = new List<BLN_Item__c>(); 
      recSetMap =new MAP<id,List<Reg_Setting__c>>();
      mapPoolParentIdwithItem = new  MAP<id,BLN_Item__c>();
      innFordefaultTc = new List<inncls>();
      
      mapIdwithPools= new MAP<id,List<Item_pool__c>>();
      inn = new List<inncls>();
      try{ 
      defaultTickets = [select id,Ticket_Settings__c,item_name__c,(select id,Name from Items__r) from BLN_Item__c where Event__r.Name='Default Event(Boothleads)'   limit 1];
    List<Reg_Setting__c> regSetList12 = new List<Reg_Setting__c>();
     
       if(defaultTickets.size()>0){
           List<Reg_Setting__c> regSetList13 =new List<Reg_Setting__c>();
           regSetList13 = regsetBal.CurrentEventSettings(event.id);
           selectedOPtion = event.Event_Ticket_Options__c ;
           innFordefaultTc.add(new inncls(defaultTickets[0],regSetList13,new List<item_pool__c>() ));  
           
        }
     
   
       itemList  =  quickBal.getEventItems(event.Id); // Getting tickets of selected Event
        SET<id> ticketIds = new SEt<id>();
        SET<id> ticketIdsForpool = new SEt<id>();
       
          for(BLN_Item__c fortcId : itemList){
            ticketIds.add(fortcId.id); 
              if(fortcId.Item_type__r.Name=='Package'){
                ticketIdsForpool.add(fortcId.id); 
                mapPoolParentIdwithItem.put(fortcId.Item_Pool__c ,fortcId);
            }
          }
        recSetMap = tcSettings(ticketIds,event.id); // Getting tickets ,its settings and assign to map 
        recSetMap.put(defaultTickets[0].id,regSetList12 );
         mapIdwithPools =  regsetBal.ItemsPoolsAndSettings(ticketIdsForpool,event.id); 
      
      
       for(BLN_Item__c blnItem : itemList){
          List<Reg_Setting__c> regSetList = new List<Reg_Setting__c>();
          regSetList= recSetMap.get(blnItem.id);
          inn.add(new inncls(blnItem,regSetList,mapIdwithPools.get(blnItem.id))); // Passing vales to inner class
       }  
     system.debug('OOOOOOOOOOOOOOOOOo '+inn[0].strNAme);
    return inn;  
    }catch(exception er){return null;}  
  }
  
  //Method to get all item pools related to package
   public List<inncls> getItemPools(){
      List<id> listOfpools = new List<id>();
      List<Item_Pool__c> aggPools = new List<Item_Pool__c >();
      mapPoolWithRegset = new MAP<id,List<Reg_Setting__c>>();
      mapItempoolWithId = new MAP<id,item_pool__c>();
      innclsListPool = new List<inncls>();
      List<Reg_Setting__c> agg = new List<Reg_Setting__c>();
        
     try{
      for(Id idsOfitem :mapIdwithPools.keySet() ){
        if(mapIdwithPools.get(idsOfitem)!=null){
           aggPools.addAll(mapIdwithPools.get(idsOfitem));
        }
      }
    
      for(Item_Pool__c itp :aggPools){
        listOfpools.add(itp.id);
     }
   
       agg = [select id,Column_Name__c,Event__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,order__c,item_pool__r.Ticket_Settings__c  from Reg_Setting__c where (item_pool__c In :listOfpools) and event__c=:event.id and Setting_Type__c='Regular' order by Group_Order__c,order__c ASC];
          for(item_pool__c itp :aggPools){
           List<Reg_Setting__c> aggTemp = new List<Reg_Setting__c>();
           for(Reg_Setting__c se :agg ){
             if(se.item_pool__c  == itp.id){
               aggTemp.add(se); 
             }
           }
           innclsListPool.add(new inncls(itp,aggTemp)); 
           mapPoolWithRegset.put(itp.id,aggTemp); 
           mapItempoolWithId.put(itp.id,itp);
         }
         
         return innclsListPool;
       } catch(exception rt){
         return null;
       }
    }
  
   
  
  
    
 // this will return ticket and its settings 
 public MAP<Id,LIST<Reg_Setting__c>> tcSettings(SET<id> ticIds,string eventId){
   List<Reg_Setting__c> regs = new List<Reg_Setting__c>();
   regs = [select id,Column_Name__c,Event__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,order__c,item_pool__r.Ticket_Settings__c  from Reg_Setting__c where (item__c In :ticIds ) and event__c=:eventId and Setting_Type__c='Regular' order by Group_Order__c,order__c ASC];
   MAP<id,List<Reg_Setting__c>> mapFinalListSettings = new  MAP<id,List<Reg_Setting__c>>();
     for(id tick :ticIds){
       List<Reg_Setting__c> reginterNal = new List<Reg_Setting__c>();
        for(Reg_Setting__c reg :regs ){
          if(reg.Item__c == tick){
           reginterNal.add(reg); 
         }
        }
        mapFinalListSettings.put(tick,reginterNal);
      }
   return mapFinalListSettings;
 }
 
 
 // For inserting regs 
    public void AddAccordian(){
    string gpnameVal = Apexpages.currentPAge().getParameters().get('gn');
    List<Reg_Setting__c> regse = new List<Reg_Setting__c>();
    List<Reg_Setting__c> regse1 = new List<Reg_Setting__c>();
    regse1 = grupWithReg.get(gpnameVal);
    
     system.debug('AAAAAAAAAAAAA '+regse1.size() );
    inn[0].strName.add(gpnameVal );
    
    List<Reg_Setting__c> regs3 = new List<Reg_Setting__c>();
        for(Reg_Setting__c tdc :regse1 ){
          Reg_Setting__c tempreg = new Reg_Setting__c();
          tempreg = tdc.clone(false,false,false,false);
          tdc.Event__c  = event.id;
          tdc.id=null;
          tdc.Item__c =null;
          tdc.Item_pool__c =null;
          regs3.add(tdc);  
        }
      dataBAse.saveResult[] ref1 = dataBase.insert(regs3,false);   
      system.debug('WWWWWWWWWWWWWWWWWW '+ref1 );
      
     for(inncls inc : inn){
        for(Reg_Setting__c tdc :regse1 ){
              Reg_Setting__c tempreg = new Reg_Setting__c();
              tempreg = tdc.clone(false,false,false,false);   
              tempreg.id=null;
              system.debug('AAAAAAAAAAAAA '+tempreg );
              if(defTciketId!=inc.iteminn.id){
                tempreg.Item__c = inc.iteminn.id;
              }else{
                 tempreg.Item__c =null;
              }
              tempreg.event__c = event.id;
              regse.add(tempreg);
         }     
      }
      
      for(inncls incpool : innclsListPool  ){
         for(Reg_Setting__c tdc :regse1 ){
              Reg_Setting__c tempreg1 = new Reg_Setting__c();
              tempreg1 = tdc.clone(false,false,false,false);   
              tempreg1.id=null;
              tempreg1.Item_pool__c = incpool.itpool.id;
              tempreg1.event__c = event.id;
              regse.add(tempreg1);
         } 
      }
      
            
     dataBAse.saveResult[] ref = dataBase.insert(regse,false);
     displayGroups();
   // system.debug('Accordian insert Result     '+ref );
  }
   
   
 // For deleting regs  
   public void deleteAccordian(){
      string gpnameVal = Apexpages.currentPAge().getParameters().get('gn');
     
       List<Reg_Setting__c> regse = new List<Reg_Setting__c>();
          for(inncls inc : inn){
            for( InnclsForGroup inng : inc.gpinnList ){
             if(gpnameVal==inng.groupName){
                regse.addAll(inng.regList);
               }
             }
           } 
           
            for(inncls incpool : innclsListPool){
            for( InnclsForGroup inng : incpool.gpinnList ){
             if(gpnameVal==inng.groupName){
                regse.addAll(inng.regList);
               }
             }
           } 
           
           inn[0].strName.remove(gpnameVal); 
        // deleting default ticket settings
        for(inncls ing:innFordefaultTc ){
          for(InnclsForGroup tg :ing.gpinnList){
            if(gpnameVal==tg.groupName){
                regse.addAll(tg.regList);
               }
             }
         }
        
               
       dataBase.delete(regse,false);   
      displayGroups();
      }
 
   

  
  public void saveDefultTicketSet(){
    eveType =selectedOPtion;  
     
       List<Reg_Setting__c> regToUpdate = new List<Reg_Setting__c>();
        for(inncls ing:innFordefaultTc ){
          for(InnclsForGroup tg :ing.gpinnList){
            regToUpdate.addALL(tg.regList); 
          }
        }
        database.update(regToUpdate ,false);
         event.Event_Ticket_Options__c = eveType;
         database.update(event,false); 
      // inn.addAll(innFordefaultTc);
    
  }
  
  // string has error message while we are saving item or item pool settings
  public string errorwhilesaving{get;set;} 
  
  // Save values after editing
    public PageReference Save() {
    try{ 
     //eveType = ApexPages.CurrentPage().getParameters().get('eveType');
     mapLabelWithRs = new MAp<string,Reg_Setting__c>(); // Mapping label with object to avoid for in for
     // Adding values  to map
      for(Reg_Setting__c rs : recSetMap.get(selectedTicket)){
          mapLabelWithRs.put(rs.Label_Name__c,rs);
      }  
 
   
     List<BLN_Item__c> itemsToUpdate = new List<BLN_Item__c>();
    SET<id> setOfids = new SET<id>(); 
     system.debug('PPPPPPPPPPPPPPPPP '+inn);
    
    // Getting selected tickets  
     for(inncls innSingle : inn){
        if(innSingle.selecetdValueInn){
           setOfids.add(innSingle.iteminn.id);
           innSingle.iteminn.Ticket_Settings__c = eveType;
               if(innSingle.iteminn.item_type__r.Name=='Package'){
                   for(Item_pool__c itp : innSingle.itemPoolsInn){
                      if(itp.Package_Flag__c!='P - Package item pool'){
                       itp.Ticket_Settings__c = eveType;
                     }
                   }
                 dataBase.update(innSingle.itemPoolsInn);
               }
           itemsToUpdate.add(innSingle.iteminn);
          }
     } 
     
      updateTicketsreg(setOfids);
      // List Of tickets to Update
        dataBase.saveResult[] sd =  dataBase.update(itemsToUpdate,false);
        system.debug('XXXXXXXXXXXXXXXXXXXXXXXXX '+sd );
      // dataBAse.update(event,false);
      }catch(exception er){ 
         errorwhilesaving = er.getMessage();
        } 
     return null;
    }
    
        public void savePool(){
      try{
       string idval= ApexPages.CurrentPage().getParameters().get('gnp');
       string eveType = ApexPages.CurrentPage().getParameters().get('eveTypePool');
       LIST<Reg_Setting__c> rsettUp = new List<Reg_Setting__c>();
    
       //Update item pool with new setting type   
       Item_pool__c itp = new Item_pool__c ();
       itp = mapItempoolWithId.get(idval);
       itp.Ticket_Settings__c = eveType;
       dataBase.update(itp);
       
       // updating regsettings with new values
       rsettUp.addAll(mapPoolWithRegset.get(idval));       
       dataBase.Update(rsettUp,false); 
       
         BLN_item__c  ite = new BLN_item__c();
         ite = mapPoolParentIdwithItem.get(itp.Addon_Parent__c); 
         ite.Ticket_Settings__c ='Collect info from All Attendees';
        dataBase.update(ite);
       }catch(exception er) {
          errorwhilesaving = er.getMessage();
        } 
   }
    
    
    
    
    
  
  
  // Update tickets and registration Settings 
     public void updateTicketsreg(SET<id> setOfids){
      LIST<Reg_Setting__c> toUpdate = new List<Reg_Setting__c>();  
      for(id tcId : setOfids){ // Iterating selected Ticket
       for(Reg_Setting__c rsForUp : recSetMap.get(tcId) ){ // Getting selected ticket id settings for update
          Reg_Setting__c rsforAdd = new Reg_Setting__c();
          rsforAdd =  mapLabelWithRs.get(rsForUp.Label_Name__c); // getting object for settings
          if(defTciketId ==tcId ){
             rsForUp.item__c =null;
          }
          rsForUp.Included__c = rsforAdd.Included__c  ;
          rsForUp.Required__c= rsforAdd.Required__c ;
          toUpdate.add(rsForUp);
       }    
     }  
    
    dataBase.update(toUpdate,false);  
       
 }
  
  
  
  
  
  
  
  public class innForGroups{
    public boolean selectChe{get;set;}
    public string groupNa{get;set;}
    public innForGroups(boolean b,string Name ){
     this.selectChe = b;
     this.groupna = Name;
    }
   }
  
  
  
   
 // Inner class for checkbox and ticket  
  public class inncls{
    public boolean selecetdValueInn {get;set;}
    public BLN_Item__c iteminn{get;set;}
    public List<InnclsForGroup> gpinnList{get;set;}
    public SEt<string> strName {get;set;}
    public List<Item_pool__c> itemPoolsInn{get;set;}
    public item_pool__c itpool{get;set;}
    
    public inncls(BLN_Item__c it,List<Reg_Setting__c> rsList,List<Item_pool__c> pool){
       iteminn = new BLN_Item__c();
       gpinnList= new List<InnclsForGroup>();
        itemPoolsInn = new  List<Item_pool__c>();
        this.itemPoolsInn  = pool;
        iteminn = it;
         gpinnList = utillForpoolAndItem(rsList); 
       
     }   
     
     public inncls(Item_pool__c it,List<Reg_Setting__c> rsList1){
      gpinnList= new List<InnclsForGroup>();
       gpinnList=utillForpoolAndItem(rsList1);
       itpool = new item_pool__c();
       itpool =it;
     }
     
     
   //Constructing Groups   
     public  List<InnclsForGroup> utillForpoolAndItem(List<Reg_Setting__c> rsList ){
        strName = new SET<string>(); // For uniqGroupNAmes
         List<string> strListName = new List<string>(); // For uniqGroupNAmes and order
       
         for(Reg_Setting__c rd:rsList){
          if(!strName.contains(rd.Group_Name__c)){
             strName.add(rd.Group_Name__c);
             strListName.add(rd.Group_Name__c);
          }
      }  
        List<InnclsForGroup> gpinnList1 = new List<InnclsForGroup>();
    // Passing Values  to Inner class  
       for(string gName:strListName){
         List<Reg_Setting__c> ListForInn = new List<Reg_Setting__c>();
          for(Reg_Setting__c rd1:rsList){
           if(rd1.Group_Name__c == gName){
              ListForInn.add(rd1);
           } 
          }
         gpinnList1.add(new InnclsForGroup(gName,ListForInn));
       }
     
     return gpinnList1;
     }
   }
   
   
   
  // Add group Names
  public void displayGroups(){
  SET<string> strgpName = new Set<string>();
  List<string> defgp = new List<string>();
  inngp = new List<innForGroups>();
      
  // getting default event settings
    for(Reg_Setting__c resDef : [select id,Group_Name__c,order__c,event__r.Name from Reg_Setting__c  where event__r.Name='Default Event(Boothleads)' and Setting_Type__c='Regular' order by order__c]){
         if(!strgpName.contains(resDef.Group_Name__c)){
         // system.debug('JJJJJJJJJJJJJJJJJJJJJJJ '+resDef.Group_Name__c);
             defgp.add(resDef.Group_Name__c);
             strgpName.add(resDef.Group_Name__c);
         }
    }
    system.debug('JJJJJJJJJJJJJJJJJJJJJJJ '+inn);
    
     if(inn.size()>0){
      for(string gpn :defgp){
       if(inn[0].strName.contains(gpn)){
          if(gpn!= 'Diversity Type Information'){
           inngp.add(new innForGroups(true,gpn));
          }
        }else{
          if(gpn!='Diversity Type Information'){
            inngp.add(new innForGroups(false,gpn));
          }
        }
      } 
    }
   
 }
  
  
 public class InnclsForGroup{
   public string groupName{get;set;}
   public List<Reg_Setting__c> regList{get;set;}
   public InnclsForGroup(string gpName,List<Reg_Setting__c> regs){
     regList = New List<Reg_Setting__c>();
     this.regList = regs;
     this.groupName = gpName;
   }
   
 } 
 
}