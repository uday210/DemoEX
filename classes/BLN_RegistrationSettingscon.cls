/***********************************************************************************************
*   Controller Name : BLN_Registration_Settings
*   Date            : 06/10/2014
*   Author          : Phani Kumar Ch
*   Purpose         : This class is for add and edit ticket settings
*   Change History  : 05/19/2014
*       Date                 Programmer                     Reason
*   --------------      -------------------           -------------------------
*  06/10/2014          Phani Kumar ch                     To Create Page
   06/12/2014          Phani Kumar ch                      Ui changed and more senarios came in to picture. 
   06/13/2014          Phani Kumar ch                     Change has came for grouping fields and add more fields option has came.       
*  
**************************************************************************************************/

public with sharing class BLN_RegistrationSettingscon {
 public boolean ticketSettingsbool { get; set; }
 public LIST<Reg_Setting__c> regset{get;set;}
 public BLN_Quick_Registration_BAL quickBal{get;set;}
 public BLN_RegistrationSettings_BAL regsetBal{get;set;}
 public string eventId{get;set;}
 public List<BLN_RegistrationSettings_BAL.innserForchk> ticketsInn{get;set;}
 public List<Reg_Setting__c> SeletedTicSettinsg{get;set;}
 public string selectedTicket {get;set;}  
 public List<selectOption> options{get;set;}
 public string selectedOption{get;set;}
 public List<Reg_Setting__c> oldRec {get;set;}
 public BLN_Event__c  eve{get;set;}
 public BLN_Reg_Settings_DAO regSetDao{get;set;}
 public List<BLN_Item__c> items {get;set;}
 public MAP<id,BLN_Item__c> mapidWithItem {get;set;} 
 public List<Reg_Setting__c> newRec {get;set;}
 public List<BLN_item__c> listofItemsForUpdate{get;set;}
 public List<Item_Pool__c> listofItempoolsForUpdate{get;set;}
 public MAP<id,Item_Pool__c> mapOfidWithItpool {get;set;}
 public List<selectOption> accordOptions{get;set;}
 public string[] selectedAcc{get;set;} 
 MAP<string,List<Reg_Setting__c>> mapGpWithRegs {get;set;}
 public  MAP<id,List<Reg_Setting__c>> recSetMap{get;set;}
 public string ticketName {get;set;}
 public List<Reg_Setting__c>  listForGetNames {get;set;}
 public List<Reg_Setting__c> SeletedTicSettinsgTemp{get;set;}  
 public  SET<string> strTemp{get;set;} 
 public SET<id> ids{get;set;} 
  public BLN_UtillDisplayLinks myticket {get;set;}

 public boolean showTabs{get;set;}
  public boolean showTabs2{get;set;}
 
 public void show(){
   showTabs = true;
   showTabs2 = false;
 }

public void hide(){
   showTabs = false;
   showTabs2 = true;
 }


    public PageReference displayPermissions() {
    
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
    if(k!=null){
       eventId = k.getValue();
     }
     
     myticket = new BLN_UtillDisplayLinks();
      BLN_PromoCode_BAL blneventdetailbal = New BLN_PromoCode_BAL();
     BLN_Event__c  se = new BLN_Event__c  ();
    
      try{
      se = blneventdetailbal.eventdetails(eventId);
      myticket.EventName=se.Name;
     }catch(exception e){}
     
     
     myticket.isAttendeeSettingsPage='active';
     myticket.isAttendeesPageExpand ='expand';
     myticket.tablabel='Attendee Settings';
     myticket.eventId = eventId ;
     myticket.userPermissions(userInfo.getUserId(),eventId);
     return null;
    }
  
  
  
  public BLN_RegistrationSettingscon(){
  mapOfidWithItpool = new  MAP<id,Item_Pool__c> ();
  eve = new BLN_Event__c();
  mapidWithItem  = new MAP<id,BLN_Item__c>();
  items = new LIST<BLN_Item__c>(); 
  showTabs = true;
  accordOptions = new List<selectOption>();
  mapGpWithRegs = new MAP<string,List<Reg_Setting__c>>(); 
  quickBal= new BLN_Quick_Registration_BAL();  
  selectedTicket ='';
  ticketSettingsbool =false;
  regsetBal= new BLN_RegistrationSettings_BAL();
  ticketsInn= new List<BLN_RegistrationSettings_BAL.innserForchk>();
  LISt<Item_Pool__c> poolList = new List<Item_Pool__c>();
  SET<string> groupNamesExisted = new SET<string>();
    if(selectedTicket =='' ){
       selectedTicket='All Tickets';
    }
    
     //eventId = Apexpages.currentPage().getParameters().get('id');
     
     Cookie k = ApexPages.currentPage().getCookies().get('counter');
    if(k!=null){
       eventId = k.getValue();
     }
   
   try{
        eve =[select id,Event_Ticket_Options__c from BLN_Event__c where id =:eventId ];
     }catch(exception e){ }
     
     
   if(eventId !=null){  
     mapGpWithRegs=regsetBal.getDefaultglobalEventSett(); // get groups Names 
     List<Reg_Setting__c> listOfsettingsForOrder = new List<Reg_Setting__c>(); 
     
      for(string GpName : mapGpWithRegs.keyset()){
       if(GpName!=null){
         accordOptions.add(new selectOption(GpName,GpName)); 
        }
      }
    
    // Mapping item id with its record
     items = quickBal.getEventItems(eventId);
     
        for(BLN_Item__c it:items ){
           mapidWithItem.put(it.id,it);
        }
     ticketsInn = regsetBal.getTickets(items,eventId);
       
     // Mapping item pool id with its record
      for(BLN_RegistrationSettings_BAL.innserForchk df :ticketsInn ){
         poolList.AddAll(df.itemPools);      
       }
      for(Item_Pool__c tppool :poolList ){
         mapOfidWithItpool.put(tppool.id,tppool);
      }  
      
      ids = new SET<id>();   
       ids.addAll(mapidWithItem.keySet());       
       mainMethod();
      }  
     }
  
   
   
    public void mainMethod(){
   
    regsetBal= new BLN_RegistrationSettings_BAL();
    SeletedTicSettinsgTemp = new List<Reg_Setting__c>();
    selectedAcc = new string[]{};
     recSetMap =new MAP<id,List<Reg_Setting__c>>();
     recSetMap = regsetBal.getTicketSettings(ids,eventId);
      
     listForGetNames = new List<Reg_Setting__c> ();
     listForGetNames = regsetBal.AllticketSettings(eventId,'Regular'); 
     system.debug(' QQQQQQQQQQQQQQ PPPPPPPPPPPPPPp '+listForGetNames );
      strTemp = new SET<string>();
     for(Reg_Setting__c existedNames :listForGetNames){
       strTemp.add(existedNames.Group_Name__c);
     
     }
     selectedAcc.addAll(strTemp);
     showSettings();
    }
  
  
  
 public string CurrentSettingtype{get;set;} 
 public List<InnerClassForTc> inngroup{get;set;}
   
    public void showSettings() {
       regsetBal =new BLN_RegistrationSettings_BAL();
       options = new List<selectOption>();
       options.add(new selectOption('Collect info from All Attendees','Collect info from All Attendees'));
       options.add(new selectOption('Collect info from Buyers only','Collect info from Buyers only'));
       inngroup = new List<InnerClassForTc>();
       ticketSettingsbool =false;
     
      SeletedTicSettinsgTemp = new List<Reg_Setting__c>();
     if(selectedTicket!='All Tickets'){
       SeletedTicSettinsgTemp =  recSetMap.get(selectedTicket);
        if(mapidWithItem.keySet().contains(selectedTicket)){
          ticketName  = mapidWithItem.get(selectedTicket).item_name__c;
          selectedOption = mapidWithItem.get(selectedTicket).Ticket_Settings__c;
        }else{
          ticketSettingsbool =true;
          ticketName  = mapOfidWithItpool.get(selectedTicket).Item_Pool_Name__c;
          options.add(new selectOption('Do not collect Attendee info','Do not collect Attendee info'));
          selectedOption = mapOfidWithItpool.get(selectedTicket).Ticket_Settings__c;
          system.debug('SSSSSSSSSSSSSSSSs '+selectedOption);
        }
      } else{
         SeletedTicSettinsgTemp =listForGetNames ; 
         ticketName  = 'All Tickets';
         selectedOption  =eve.Event_Ticket_Options__c ;
     }
       
      
   
      for( string name : selectedAcc ){
        List<Reg_Setting__c> tempList = new List<Reg_Setting__c>();
        for(Reg_Setting__c res : SeletedTicSettinsgTemp){
          if(name == res.Group_Name__c){
            tempList.add(res); 
           }
         }
         inngroup.add(new InnerClassForTc(name,tempList));
      }
      system.debug('HHHHHHHHHHHHHHHHHHH '+inngroup); 
    }


   public class InnerClassForTc{
     public string groupName{get;set;}
     public List<Reg_Setting__c> SeletedTicSettinsgInn{get;set;}
     public InnerClassForTc(string nm,List<Reg_Setting__c> cfnm){
       SeletedTicSettinsgInn = new List<Reg_Setting__c>();
       this.SeletedTicSettinsgInn = cfnm;
       this.groupName = nm;
     }
   }

     
   public void addNewAccordian(){
      regSetDao = new BLN_Reg_Settings_DAO();
      regsetBal =new BLN_RegistrationSettings_BAL();
     SET<string> setIds = new SET<string>();
     system.debug('WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW   '+selectedAcc);
      for(string s :selectedAcc){
       setIds.add(s);
      }   
     
     if(strTemp.size()>setIds.size()){
        strTemp.RemoveAll(setIds);
        regsetBal.deletedeseletedValues(strTemp,eventId);
      }else{
         setIds.RemoveAll(strTemp);
         List<Reg_Setting__c> rstList = new List<Reg_Setting__c>();
         if(setIds.size()>0){
         List<string> nlist = new List<string>();
         nlist.addAll(setIds);
          string abc =nlist[0];
          system.debug('WWWWWWWWWWWWWWWWWWWWWWWWWW QQQQQQQQQQ '+abc +'GGGGGGGGGGG '+mapGpWithRegs.get(abc));
        
          for(Reg_Setting__c rst : mapGpWithRegs.get(abc)){
            system.debug('PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP '+rst);
             Reg_Setting__c rstinnForEvent = new Reg_Setting__c ();
               rstinnForEvent = rst.clone(false,false,false,false);
               rstinnForEvent .Event__c = eventId;
               rstList.add(rstinnForEvent);
            
            
             for(id tcid :recSetMap.keySet()){
             Reg_Setting__c rstinn = new Reg_Setting__c ();
             rstinn = rst.clone(false,false,false,false);
                rstinn.Event__c = eventId;
               if((mapidWithItem.keySet().contains(tcid))){
                  rstinn.Item__c= tcid ;
               }else if(mapOfidWithItpool.keySet().contains(tcid)){
                  rstinn.Item_Pool__c= tcid ;
               }
                rstList.add(rstinn);
             }  
             
           }
        
      regSetDao.insRegset(rstList);
        }
      }
     
     mainMethod();
  
   }

 
  



   // If selected ticket is "All tickets" and no check box is selected and on alert if he clicks no
   public void updateDefaultSett(){
   system.debug('UUUUUUUUUUUUUUUUUUUUUUUUUUU ');
    regSetDao = new BLN_Reg_Settings_DAO();
      BLN_Event_DAO  eveDao= new BLN_Event_DAO();
      
        SeletedTicSettinsg = new List<Reg_Setting__c>();
        for(InnerClassForTc inn :inngroup){
           SeletedTicSettinsg.addAll(inn.SeletedTicSettinsgInn);
        }
        
        regSetDao.updateSet(SeletedTicSettinsg);  // updating tickets with new values
        eve.Event_Ticket_Options__c = selectedOption ;
        eveDao.updateEve(eve);  
   }
    

      // If selected ticket is "All tickets" and no check box is selected and on alert if he clicks yes
        public void multiSacerecAlltic(){
        system.debug('YYYYYYYYYYYYYYYYYYYYYYYY  ');
        SET<id> conSet = new SET<id>();
            for(BLN_RegistrationSettings_BAL.innserForchk tinn :ticketsInn ){
             conSet.add(tinn.ticket.id); 
           }
            system.debug('Indivisual settings checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk '+conSet);
           
            if(conSet.size()>0){
              crudOnickets(conSet);
         } 
     }


  // Individual single ticket saving
    public void indsaveSettings() {
       SET<id> conSet = new SET<id>();
       conSet.add(selectedTicket); 
       crudOnickets(conSet);
    }
    
    // if multitickets selected and ticket is not "All ticket"
    public void multiSacerec(){
     system.debug('Indivisual settings checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk ');
    SET<id> conSet = new SET<id>();
        for(BLN_RegistrationSettings_BAL.innserForchk tinn :ticketsInn ){
         if(tinn.selectedchk){
            conSet.add(tinn.ticket.id); 
         }
       }
       
      if(conSet.size()>0){
        crudOnickets(conSet);
      } 
    }
    
    
     
    public void crudOnickets(SET<id> ids){
     
     List<Reg_Setting__c> ListOfSelectedTicSettings = new List<Reg_Setting__c>();
     List<Reg_Setting__c> updateTicSettings = new List<Reg_Setting__c>();
     SeletedTicSettinsg = new List<Reg_Setting__c>();
     listofItemsForUpdate = new List<BLN_item__c>();
     listofItempoolsForUpdate = new  List<Item_Pool__c>();
          for(InnerClassForTc inn :inngroup){
           SeletedTicSettinsg.addAll(inn.SeletedTicSettinsgInn);
        }
        system.debug('CCCCCCCCCCCC DDDDDDDDDDDDDD '+ListOfSelectedTicSettings);
        system.debug('CCCCCCCCCCCC DDDDDDDDDDDDDD 1111'+SeletedTicSettinsg);
      
      
         for(id idp :ids){
           for(Reg_Setting__c rs :recSetMap.get(idp)){
              ListOfSelectedTicSettings.add(rs);
          }
          
         
            if(mapidWithItem.get(idp)!=null){
               BLN_item__c ite = new BLN_item__c();
               ite = mapidWithItem.get(idp);
                system.debug('ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ  '+selectedOption);
               ite.Ticket_Settings__c =selectedOption;
               listofItemsForUpdate.add(ite);
             
          }else{
             Item_Pool__c itepool = new Item_Pool__c();
              itepool = mapOfidWithItpool.get(idp);
              itepool.Ticket_Settings__c =selectedOption;
             listofItempoolsForUpdate.add(itepool);
         }
          
     } 
      
      //Map label with rec to escape 1 for loop  
      MAP<string,Reg_Setting__c> MapLabelWithRec = new MAP<string,Reg_Setting__c>();
      for(Reg_Setting__c reg: SeletedTicSettinsg){
       MapLabelWithRec.put(reg.Label_Name__c ,reg); 
      } 
      
      
       for(Reg_Setting__c  rset:ListOfSelectedTicSettings){
              Reg_Setting__c  reg = MapLabelWithRec.get(rset.Label_Name__c );
              rset.Required__c =  reg.Required__c ;
              rset.Included__c = reg.Included__c;
              updateTicSettings.add(rset);
              system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@ '+rset);
         }
      
      DataBase.update(updateTicSettings,false);
      
      // Update Tickets
      if(listofItemsForUpdate.size()>0){
       DataBase.update(listofItemsForUpdate,false);
     }  
      
      //Update item pools
       if(listofItempoolsForUpdate.size()>0){
       DataBase.update(listofItempoolsForUpdate,false);
     }  
      
      
      
      
      
      
     mainMethod();
    }
      
      
      
      
  public void displaytcSet(){
     if(ticketSettingsbool ){
        ticketSettingsbool =false; 
     }else{
       ticketSettingsbool =true;
     }
  }
}