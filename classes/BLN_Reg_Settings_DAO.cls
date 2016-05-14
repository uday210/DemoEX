/***********************************************************************************************
*   Controller Name : BLN_Reg_Settings_DAO
*   Date            : 06/10/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is for insert,delete,update tickets
*   Change History  : 05/19/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  06/10/2014          Phani Kumar ch                   To Create Page
*  
**************************************************************************************************/
  
public with sharing class BLN_Reg_Settings_DAO {
  
 // By Phani for delete set of settings
  public void deleteRegset(List<Reg_Setting__c> regs){
     dataBase.delete(regs,false);
  }
  
 // By Phani for delete set of settings
  public void insRegset(List<Reg_Setting__c> regs){
    dataBase.saveResult[] saveres = dataBase.insert(regs,false);
    system.debug('WWWWWWWWWWWW '+saveRes);
  }
  
  // By Phani for update set of settings
  public void updateSet(List<Reg_Setting__c> regs){
    dataBase.UpsertResult[] saveres = dataBase.upsert(regs,false);
    system.debug('WWWWWWWWWWWW '+saveRes);
  }
  
  //by deepthi for mobile app settings
 public List<Reg_Setting__c> getregsetlist(String selectedeventid )
   {
        List<Reg_Setting__c> regsetlist  = new List<Reg_Setting__c>();
       
      RETURN regsetlist  = [SELECT Group_label__c,Defaullt_Label__c,id,Order__c,Label_Name__c,Included__c FROM Reg_Setting__c WHERE Setting_Type__c='Eventdexapp' AND Event__c = :selectedeventid AND Defaullt_Label__c IN ('Event Schedule','My Schedule','My Tickets','Location','Floor Map','Social','Seminars','Attendees','Exhibitors','Sponsors','Speakers','Lead Retrieval','MatchLeads','Feedback','Push Notifications','With QR Code','With Push Notification') order by Order__c];
      
        
   }
   
   public MAP<id,List<Reg_Setting__c>> itemSettings(List<id> ids){
     MAP<id,List<Reg_Setting__c>> regMap = new MAP<id,List<Reg_Setting__c>>();
     SET<id> itIds = new SET<id>(); 
       for(Reg_Setting__c reg : [SELECT  Group_label__c,Defaullt_Label__c,ID,NAME,Column_Name__c,Tag_Id__c,Create_Access__c,Sales_Message__c,Order__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Label_Name__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c  FROM Reg_Setting__c WHERE  (Item__c IN : ids OR Item_Pool__c IN : ids)  AND Setting_Type__c =: 'Regular'  ORDER BY Order__c]){
          LIST<Reg_Setting__c> setOfregs = new LIST<Reg_Setting__c>();
         Id itIdval = ( reg.item__c == null ? reg.Item_Pool__c : reg.item__c);
           if(itIds.contains(itIdval)){
             setOfregs= regMap.get(itIdval);
             setOfregs.add(reg);
          }else{
             setOfregs.add(reg);
             itIds.add(itIdval);
     }
 
          regMap.put(itIdval,setOfregs); 
        }
       return  regMap;
  }       
  
   public List<Reg_Setting__c> setsResitem(String type , String tid){
      return  [select Group_label__c,Defaullt_Label__c,id,Column_Name__c,Event__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,order__c,item_pool__r.Ticket_Settings__c,Update_Access__c  from Reg_Setting__c where (Item__c =:tid OR Item_Pool__c=:tid)  AND Setting_Type__c=:type  order by Group_Order__c,order__c ASC];
   }
   
   public List<Reg_Setting__c> setsResevent(String type , String eid){
      return  [select Group_label__c,Defaullt_Label__c,id,Column_Name__c,Event__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,order__c,item_pool__r.Ticket_Settings__c,Update_Access__c  from Reg_Setting__c where (Item__c =null AND Item_Pool__c=null ) AND event__c =:eid AND Setting_Type__c=:type  order by Group_Order__c,order__c ASC];
  }
  
  public List<Reg_Setting__c> setsResDefaultEvent(String type){
      return  [select event__r.name,Group_label__c,Defaullt_Label__c,id,Column_Name__c,Event__c,Included__c,Item__c,Organizer__c,Required__c,Setting_Type__c,Table_Name__c,Label_Name__c,Item_Pool__c,Group_Name__c,order__c,item_pool__r.Ticket_Settings__c,Update_Access__c  from Reg_Setting__c where (Item__c =null AND Item_Pool__c=null ) AND event__r.name ='Default Event(Boothleads)' AND Setting_Type__c=:type  order by Group_Order__c,order__c ASC];
  }
  
  // By Shruthi for retrieving list of settings based on setting type
  
  public List<Reg_Setting__c> getregsettingslist(String selectedeventid )
    {
        List<Reg_Setting__c> regsettingslist  = new List<Reg_Setting__c>();
        
            RETURN regsettingslist  = [SELECT  Group_label__c,ID,NAME,Column_Name__c,Tag_Id__c,Create_Access__c,Sales_Message__c,Custom_Message__c,Order__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Label_Name__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c  FROM Reg_Setting__c WHERE   Event__r.ID =:selectedeventid AND (Setting_Type__c =: 'Display'OR Setting_Type__c =: 'Registration Tab') AND Item_Pool__c=:NULL ORDER BY Order__c];
        
       
       // RETURN regsettingslist  =database.query('SELECT '+'ID,NAME,Column_Name__c,Create_Access__c,Sales_Message__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Label_Name__c,Order__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c'+' FROM Reg_Setting__c WHERE '+condition);
        
    }
    
    //Retrieving Data for attendee based and reports and attendee screen 
   public List<Reg_Setting__c> attendeeSettingsSetUp(String selectedeventid)
    {
        List<Reg_Setting__c> regsettingslist  = new List<Reg_Setting__c>();
            RETURN regsettingslist  = [SELECT  Group_label__c,ID,NAME,Defaullt_Label__c,Column_Name__c,Tag_Id__c,Create_Access__c,Sales_Message__c,Order__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Label_Name__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c  FROM Reg_Setting__c WHERE   Event__r.ID =:selectedeventid];
       
    }
  
    //method to get list of reg_settisngs for booked tickets
    public List<Reg_Setting__c> bookedRegSettingList(set<id> allids,String selectedeventid)  {
        List<Reg_Setting__c> regsettingslist  = new List<Reg_Setting__c>();
        RETURN regsettingslist  = [SELECT  Group_label__c,ID,NAME,Defaullt_Label__c,Column_Name__c,Tag_Id__c,Create_Access__c,Sales_Message__c,Order__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Label_Name__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c  FROM Reg_Setting__c WHERE   Event__r.ID =:selectedeventid and (item__c in : allids OR item_pool__c in : allids)];
    }
  
  public List<Reg_Setting__c> getMobileSettings(String eventId){
  
   return [SELECT  Images__c,LastModifiedDate,Group_label__c,ID,NAME,Column_Name__c,Tag_Id__c,Create_Access__c,Sales_Message__c,Order__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Item_Pool__r.item_Type__r.Name ,Label_Name__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c,Defaullt_Label__c   FROM Reg_Setting__c WHERE   Event__r.ID =:eventId AND Setting_Type__c =: 'Eventdexapp' ORDER BY Order__c];
   
   
   
   }
       
    public List<Reg_Setting__c> getMobileSettings(String eventId,datetime lstdat){
  if(lstdat !=null){
   return [SELECT  Images__c,LastModifiedDate,Group_label__c,ID,NAME,Column_Name__c,Tag_Id__c,Create_Access__c,Sales_Message__c,Order__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Item_Pool__r.item_Type__r.Name ,Label_Name__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c,Defaullt_Label__c   FROM Reg_Setting__c WHERE   Event__r.ID =:eventId AND Setting_Type__c =: 'Eventdexapp' AND LastModifiedDate>:lstdat ORDER BY Order__c];
 
   
   }else{
   
      return [SELECT  Images__c,LastModifiedDate,Group_label__c,ID,NAME,Column_Name__c,Tag_Id__c,Create_Access__c,Sales_Message__c,Order__c,Delete_Access__c,Event__c,Group_Name__c,Group_Order__c,Included__c,Item__c,Item_Pool__c,Item_Pool__r.item_Type__r.Name ,Label_Name__c,Organizer__c,Read_Access__c,Required__c,Setting_Type__c,Table_Name__c,Update_Access__c,Defaullt_Label__c   FROM Reg_Setting__c WHERE   Event__r.ID =:eventId AND Setting_Type__c =: 'Eventdexapp' ORDER BY Order__c];
   }
           
   
   }   
       
           
    public List<Reg_Setting__c> getItemtypeRegSetList(string selectedeventid){
      return [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c from Reg_Setting__c where Event__c=: selectedeventid and Table_Name__c='Item_Type__c' and Setting_Type__c='Display'];
    }
   public Reg_Setting__c getrestrationlinksettings(string selectedEvent){
   list<Reg_Setting__c> rglist = new list<Reg_Setting__c>();
   rglist = [SELECT Label_Name__c FROM Reg_Setting__c WHERE Setting_Type__c=:'RegistrationLink' AND Defaullt_Label__c=:'PublicRegShortLink' AND  Event__c =: selectedEvent limit 1];
   if(rglist.size()>0){
   return rglist[0];
      }else{
   return null;
    }
    }
  
  //Created By Biswajeet For Default Eventdex App Settings Image 
  public List<Reg_Setting__c> getEventdexAppDefaultSettings(){
      return [select id,name,Event__c,Table_Name__c,Column_Name__c,Label_Name__c,Setting_Type__c,Included__c, Images__c, Defaullt_Label__c from Reg_Setting__c where Event__r.Name = 'Default Event(Boothleads)' and  Setting_Type__c='Eventdexapp'];
    }
}