/*
Author : Phani Kumar Ch
Date   : 08/06/2015
*/
public with sharing class BLN_attendee_settingsNewCon {

public BLN_UtillDisplayLinks myticket { get; set; }
public List<BLN_Item__c> itemList {get;set;} // Items Belongs to this event
public BLN_Quick_Registration_BAL quickBal{get;set;} 
public String selectedEvent{get;set;}
public List<inncls> ItemsList{get;set;}
public String selectedTicket{get;set;}
public List<Reg_Setting__c> regSettings {get;set;}
public String[] headerValues{get;set;}
public MAP<string,BLN_Item__c> mapTcidWithObj{get;set;}
public MAP<string,Item_Pool__c> mapitpoolidWithObj{get;set;}
public String setApplyItems{get;set;}
public String selectedInfoType{get;set;}
public BLN_Event__c event{get;set;}
public String statusRec {get;set;}
public String selectedGroups{get;set;}
public String seletedItemName{get;set;}
public String defaultTicketId{get;set;}
public inncls defaultTicketInn{get;set;}

// String to heighlight 
public string selectedInfoValue{get;set;}
public List<innHeaderWithSettList> innSetList {get;set;}
public Static BLN_Event_DAO eveDetails= new BLN_Event_DAO(); 
        //Contructor
        public BLN_attendee_settingsNewCon(){
        try{
            /*selectedEvent =  ApexPages.currentPage().getParameters().get('id');*/
            Cookie counterval = ApexPages.currentPage().getCookies().get('counter');
                if(counterval !=null){
                    selectedEvent = counterval.getValue();
                 }
                 
              defaultTicketInn = new inncls();
               
             myticket = new BLN_UtillDisplayLinks();
             myticket.isAttendeeSettingsPage='active'; // To height light Link
             //myticket.isAttendeesPageExpand ='expand'; // To expand parent link
             myticket.isEventsettingsExpand ='expand';
           if(selectedEvent!='' && selectedEvent!=null ){  
             myticket.tablabel='Attendee Settings';  // Tab label
             myticket.eventId = selectedEvent;
             myticket.userPermissions(userInfo.getUserId(),selectedEvent);  // Getting Permissions as per login user role
               
             event = new BLN_Event__c  ();
             BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
             event= blneventdetailbal.eventdetails(selectedEvent); // getting event details
             myticket.EventName=event.Name; // to display event Name in component
           }
           
           
            statusRec ='';
           //Adding header values to Display IN Order 
            headerValues = new String[]{'Basic Information','Work Information','Address Information','Naics Code Information','Diversity Type Information','Commodities Information','Speaker Information'};
            event = new BLN_Event__c();
            event =eveDetails.getEventDetails(selectedEvent)[0]; 
            getTickets();
            getDefaultEventSettings();
            }catch(exception ex){
            defSettings = new List<innHeaderWithSettList>();
            ItemsList = new List<inncls>();
            innSetList= new List<innHeaderWithSettList>();
            }
        }
        
        public List<innHeaderWithSettList> defSettings{get;set;} 
        public void getDefaultEventSettings(){
            defSettings = new List<innHeaderWithSettList>();
            defSettings = settingrec('');
        }


        
        public void getTickets(){
            quickBal = new BLN_Quick_Registration_BAL();
            SET<id> parentIds = new SET<id>();
            ItemsList = new List<inncls>();
            mapitpoolidWithObj = new MAP<string,Item_Pool__c>();
            mapTcidWithObj = new MAP<string,BLN_Item__c>();
            MAP<id,List<Item_Pool__c>> mappIdWithChRec = new MAP<id,List<Item_Pool__c>>();
             //Fetching Package Parent Item Pool
            for(BLN_Item__c itemPkgs : [SELECT id,Item_Pool__c,Ticket_Settings__c from BLN_Item__c where item_type__r.Name='Package' and Event__c=:selectedEvent]){
              parentIds.add(itemPkgs.Item_Pool__c);
            }
            //Getitng parent Ids and Its childs  
            for(Item_Pool__c itemPool : [SELECT id,(SELECT id,Name,Item_Pool_Name__c,Badgable__c,Ticket_Settings__c  from Item_Pools__r) from Item_Pool__c where id IN :parentIds]){
              mappIdWithChRec.put(itemPool.id,itemPool.Item_Pools__r);
              for(Item_Pool__c  itpm : itemPool.Item_Pools__r){
                mapitpoolidWithObj.put(itpm.id,itpm);
              }
            }
            SET<id> duplicateRemoveItems =New SET<id>();
            for(BLN_Item__c item : quickBal.getEventItems(selectedEvent)){
             if(item.Item_type__r.Name=='Package'){
               if(null != mappIdWithChRec.get(item.Item_Pool__c)){
                  if(!duplicateRemoveItems.contains(item.Item_Pool__c))
                   ItemsList.add(new inncls(item,mappIdWithChRec.get(item.Item_Pool__c)));
                }else{
                  if(!duplicateRemoveItems.contains(item.Item_Pool__c))
                    ItemsList.add(new inncls(item,new List<Item_Pool__c>()));
                }
              }else{
                 if(!duplicateRemoveItems.contains(item.Item_Pool__c))
                  ItemsList.add(new inncls(item,new List<Item_Pool__c>()));
                } 
                 mapTcidWithObj.put(item.id,item);                  
                 duplicateRemoveItems.add(item.Item_Pool__c); 
            }
              
            innSetList  = new List<innHeaderWithSettList>();  
            if(ItemsList.size()>0){  
              if(selectedInfoValue==null){ 
                defaultTicketInn  = ItemsList[0];
                selectedInfoValue =ItemsList[0].itemInn.Ticket_Settings__c ;
                innSetList  = settingrec(ItemsList[0].itemInn.id); 
                seletedItemName= ItemsList[0].itemInn.item_name__c;
                defaultTicketId= ItemsList[0].itemInn.id;
              }
            } 
           
         }

       
       public Static BLN_Reg_Settings_DAO regDao=new BLN_Reg_Settings_DAO();

        
        public PageReference fetchSettings() {
               try{
              selectedTicket = Apexpages.currentPage().getParameters().get('pmValue');
              getSetting(selectedTicket );
              }catch(Exception e){}
            
             return null;
        }
        
        public void getSetting(String tId){
            statusRec ='';
             innSetList= new List<innHeaderWithSettList>();
             
              if(selectedTicket!=null && selectedTicket!=''){
                  innSetList = settingrec(tId);
             }
        }
        
        
        
       //This method will get All settings related to Item ot Item pool and Make inner clss with Group Name and its Settings
          public List<innHeaderWithSettList> settingrec(String sValue){

            regSettings = new List<Reg_Setting__c>();
            List<innHeaderWithSettList>  innSetListTemp = new List<innHeaderWithSettList>();

          if(sValue!=null && sValue!=''){
                regSettings = regDao.setsResitem('Regular',sValue); 
                if(null != mapTcidWithObj.get(selectedTicket)){
                  seletedItemName= mapTcidWithObj.get(selectedTicket).item_name__c;
                 System.debug('AAAAAAAAAAAA '+mapTcidWithObj.get(selectedTicket).Ticket_Settings__c);
                   selectedInfoValue = mapTcidWithObj.get(selectedTicket).Ticket_Settings__c ;
               }else if(null != mapitpoolidWithObj.get(selectedTicket)){
                  seletedItemName= mapitpoolidWithObj.get(selectedTicket).Item_Pool_Name__c;
                  selectedInfoValue = mapitpoolidWithObj.get(selectedTicket).Ticket_Settings__c;
               }
            }else{
                regSettings =regDao.setsResevent('Regular',selectedEvent);
               }   
               
               for(String gpValues :headerValues){
                  List<Reg_Setting__c> rsTemp = new List<Reg_Setting__c>();
                  Boolean isSelectedValues = false;   
                   for(Reg_Setting__c rs :regSettings ){
                     System.debug('BBBBBBBBBB '+rs.Group_Name__c +'gpValues  '+gpValues);
                      if(rs.Group_Name__c.toLowercase() == gpValues.toLowercase()){
                        rsTemp.add(rs);
                        if(rs.Included__c ==true){
                            isSelectedValues = true;
                        }
                     }
                  }
                innSetListTemp.add(new innHeaderWithSettList(gpValues,rsTemp,isSelectedValues)); 
              }
            return innSetListTemp;
          }
        
       public class innHeaderWithSettList{
         public String headerValue {get;set;}
         public List<Reg_Setting__c> regSet{get;set;}
         public boolean isSelected{get;set;}

         public innHeaderWithSettList(String hValue,List<Reg_Setting__c> rSet,Boolean isDisplay){
              isSelected = isDisplay;
              headerValue = hValue;
              regSet = new List<Reg_Setting__c>();
             if(rSet.size()>0){
              regSet  = rSet;
             }
             system.debug('regSet===='+regSet);
          } 
      }   
  
     
      // Saving Values 
     public void Save(){
        statusRec ='';
        MAP<id,List<Reg_Setting__c>> recSetMap =new MAP<id,List<Reg_Setting__c>>();
        System.debug('PPPPPPPPPPPP '+setApplyItems +'   QQQQQQQQQ '+selectedInfoType);
        if(setApplyItems!=null && selectedInfoType!=null){
           MAP<String,Reg_Setting__c> holdClWithrec = new MAP<String,Reg_Setting__c>();
           
           for(innHeaderWithSettList disInn : innSetList){
             for(Reg_Setting__c rs: disInn.regSet){
                if(!selectedGroups.tolowercase().contains(disInn.headerValue.tolowercase())){
                   rs.Included__c =false; 
                   rs.Required__c = false;
                   rs.Update_Access__c= false;   // Using column Name as Uniq to Each recored in Reg Settigs
                } 
                holdClWithrec.put(rs.Column_Name__c,rs);
              }
            }
           
           List<id> itIds = new List<id>();
           itIds  = setApplyItems.split(',');
           recSetMap = regDao.itemSettings(itIds);
           List<Reg_Setting__c> regsForupdate = new List<Reg_Setting__c>();
           
           //Updating Selected Items with selected settings 
           for(id iids : itIds){
             for(Reg_Setting__c rsi : recSetMap.get(iids)){
               if(null != holdClWithrec.get(rsi.Column_Name__c)){ 
                    Reg_Setting__c tempRes = new Reg_Setting__c();
                    tempRes = holdClWithrec.get(rsi.Column_Name__c);  
                    System.debug('LLLLLLLLLL '+tempRes +'   '+rsi.Column_Name__c); 
                    rsi.Included__c =tempRes.Included__c; 
                    rsi.Required__c = tempRes.Required__c;
                    rsi.Update_Access__c= tempRes.Update_Access__c;
                    rsi.Label_Name__c = tempRes.Label_Name__c;
                    regsForupdate.add(rsi); 
                 } 
              }
           }
          DataBase.saveResult[] upRes =  DataBase.update(regsForupdate,false); 
          resultOfrecs(upRes);
        // ---------------- Updating Items Info type  With Selected Type---------------------------- 
           SET<id> setOfsel = new SET<id>();
           setOfsel.addAll(itIds);
           LIst<BLN_Item__c> itemsForUpdate = new LIst<BLN_Item__c>();
           LIst<Item_Pool__c> itemspoolForUpdate = new LIst<Item_Pool__c>();
                      for(inncls inc :ItemsList){
              If(setOfsel.contains(inc.itemInn.id)){ 
                 if(inc.itemInn.item_type__r.Name!='Package'){
                     inc.itemInn.Ticket_Settings__c = selectedInfoType;
                     itemsForUpdate.add(inc.itemInn); 
                 }else{
                    inc.itemInn.Ticket_Settings__c = selectedInfoType;
                    itemsForUpdate.add(inc.itemInn); 
                    for( Item_Pool__c ip :inc.packageLineItems ){
                       ip.Ticket_Settings__c ='Do not collect Attendee info';
                       itemspoolForUpdate.add(ip); 
                    }               
                 }
               }else{
                   boolean IsparentAlredyAdd = true; 
                   for( Item_Pool__c ip :inc.packageLineItems ){
                      if(setOfsel.contains(ip.id)){
                          ip.Ticket_Settings__c =selectedInfoType;
                          itemspoolForUpdate.add(ip); 
                          if(IsparentAlredyAdd){
                             IsparentAlredyAdd  =false;
                             inc.itemInn.Ticket_Settings__c = 'Do not collect Attendee info';
                             itemsForUpdate.add(inc.itemInn);
                           } 
                       } 
                    }
               }
            }
          if(itemsForUpdate.size() > 0){
            database.saveResult[] uitemRes =  DataBase.update(itemsForUpdate,false);
             resultOfrecs(uitemRes);
          }  
          if(itemspoolForUpdate.size()  > 0){
              database.saveResult[] upoolRes = DataBase.update(itemspoolForUpdate,false);
              resultOfrecs(upoolRes);
          } 
         settingrec(selectedTicket); 
        }
        
       if(statusRec !='' && statusRec !=null){
         
       }else{
           statusRec ='Your settings are saved successfully!';
       } 
        
     }
     
     public void cancelAct(){
        statusRec =''; 
     }
     
     // ----------------------------------------------------------------------- Default ticket settings save ---------------------------------------------
       public void savedefAction(){
          statusRec =''; 
          System.debug('PPPPPPPPPPPPPP '+selectedInfoType);
            List<Reg_Setting__c> regsForupdate = new List<Reg_Setting__c>();
           if(selectedInfoType!=null){
              for(innHeaderWithSettList def : defSettings){
                  System.debug('AAAAAAAAAAAA '+def );
                 for(Reg_Setting__c rs: def.regSet){
                   if(!selectedGroups.tolowercase().contains(def.headerValue.tolowercase())){
                      rs.Included__c =false; 
                      rs.Required__c = false;   // Using column Name as Uniq to Each recored in Reg Settigs
                      rs.Update_Access__c= false;
                   } 
                  System.debug('AAAAAAAAAAAA '+rs);   
                  regsForupdate.add(rs);   
                }
              }
           
           }
         database.saveResult[] resDef = DataBase.update(regsForupdate,false);
         resultOfrecs(resDef);
         if(statusRec !='' && statusRec !=null){
           
          }else{
           statusRec ='Your settings are successfully!';
         } 
         
       }
      
     
     public void resultOfrecs(List<dataBase.saveResult> upRes){
          for(dataBase.saveResult sr: upRes){
              if(!sr.isSuccess()){
                   for(Database.Error err : sr.getErrors()) {
                       StatusRec+=err.getStatusCode() + ': ' + err.getMessage();  
                   }
               }
           }  
      }
      
     
   public void SaveGpName(){
     String tTempIdgp = Apexpages.currentPage().getParameters().get('gpItemid');
     String tTempgpname = Apexpages.currentPage().getParameters().get('gpname');
     String tTempgpnamenew = Apexpages.currentPage().getParameters().get('gpnamenew');
     System.debug('Ticket Id : '+tTempIdgp +'  Group Name '+tTempgpname  +' New Group Name '+tTempgpnamenew );
          List<id> itIds = new List<id>();
          itIds.add(tTempIdgp);
           
          MAP<id,List<Reg_Setting__c>> recSetMap = new MAP<id,List<Reg_Setting__c>>();
          recSetMap  = regDao.itemSettings(itIds);
     
      List<Reg_Setting__c> regsForupdate = new List<Reg_Setting__c>();
        for(Reg_Setting__c rsi : recSetMap.get(tTempIdgp )){
           if(tTempgpname == rsi.group_Name__c){ 
                rsi.Group_label__c = tTempgpnamenew;
                regsForupdate.add(rsi); 
           }
         }  
       if(regsForupdate.size()>0){
         DataBase.update(regsForupdate,false); 
         getSetting(selectedTicket );
       }  
         
   }  
     
     
     
     
     
   // Inner class to Map Item with Item line items  
    public  class inncls{
       public BLN_Item__c itemInn{get;set;}
       public List<Item_Pool__c> packageLineItems{get;set;}
        public inncls(){
           packageLineItems = new List<Item_Pool__c>();
           itemInn = new BLN_Item__c ();
        }
       
       public inncls(BLN_Item__c itm,List<Item_Pool__c> PoolList1){
           this.itemInn= new BLN_Item__c();
           this.packageLineItems= new List<Item_Pool__c>();
           if(null!=itm){
              itemInn =itm;
           }
           if(null!=PoolList1){
             this.packageLineItems= PoolList1;
           }
       }
    }

}