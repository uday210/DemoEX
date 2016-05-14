public with sharing class BLN_ticketfeesettingsCon {

    public BLN_UtillDisplayLinks mytickets { get; set; }
    public string eventId{get;set;}
    public BLN_Event__c event {get;set;}
    public LIST<BLN_Item__c> Items {get ; set ;} 
    public LIST<selectoption> options {get ; set ;}
    public string selectedoption {get ; set ;}
    public LIST<innerclass> innerlist {get ; set ;}
    public string checkval {get ; set ;}
    public string addstring {get ; set ;}
    public string includestring {get ; set ;}
    
    public BLN_ticketfeesettingsCon(){
    try{
    event  = new BLN_Event__c();
      Cookie k = ApexPages.currentPage().getCookies().get('counter');
          if(k!=null){
          eventId  = k.getValue();
          }
         
     options = new LIST<selectoption> ();
     options.add(new selectoption('Add Eventdex fee on top of the total ticket price','Add Eventdex fee on top of the total ticket price'));
     options.add(new selectoption('Include the Eventdex fee in to the total ticket price','Include the Eventdex fee in to the total ticket price'));
     BLN_Events_DAO eventDao = new BLN_Events_DAO();    
      mytickets = new BLN_UtillDisplayLinks(); 
      mytickets.isTicketFeeSettingsPage=  'active';
      mytickets.isEventsettingsExpand = 'expand';
      mytickets.isEventAdmin =true;
      
      mytickets.tablabel ='Ticket Fee Settings';
       mytickets.userPermissions(userInfo.getUserId(),eventId);
      event = eventDao.getEventDetails(eventId);
     
    Itemvals();
    }catch(exception ex){}
    }
    public void Itemvals(){
      innerlist  = new LIST<innerclass> ();
     Items = new LIST<BLN_Item__c> ();
      BLN_Events_DAO EVEDAO = new BLN_Events_DAO ();
      event  = EVEDAO.getEventDetails(eventId);
      selectedoption = event.Service_Fee__c;
       mytickets.eventName=event.Name;
      BLN_Item_DAO itendao = new BLN_Item_DAO();
       Items = itendao.getEventItems(eventId);
      system.debug('::::::::::ITEMS::::::::::::::'+Items );      
      For(BLN_Item__c BLS : Items ){
      system.debug('::::::::::ITEMS1111111::::::::::::::'+BLS); 
       
      innerlist.add(new innerclass (BLS,BLS.service_fee__c));
      system.debug('::::::::::ITEMS222222::::::::::::::'+BLS); 
      }
      
      // Cookie k = ApexPages.currentPage().getCookies().get('counter');
      
        //if(k!=null){ 
        //    eventId= k.getValue();
        //}
    }
    //FOR SAVING EVENT SETTING
    public void saveinventsetting(){
    system.debug('++++++++++'+checkval );
    BLN_Events_DAO EVEDAO = new BLN_Events_DAO ();
    event.Service_Fee__c = selectedoption ;
    list<BLN_Event__c> listeves = new LIST<BLN_Event__c>();
    listeves.add(event);
    EVEDAO.createEvent(listeves);
    
    
    
    }
    public void savetickchange(){
    innerlist = new LIST<innerclass> ();
    BLN_ticketfeesettings_BAL ticktbal = new BLN_ticketfeesettings_BAL();
   /** LIST<BLN_Item__c> itemsbl = new LIST<BLN_Item__c> ();
     system.debug('::::::::::ITEMS222222::::::::::::::'+Items );
        for(BLN_Item__c BLS1 : Items ){
               BLS1.service_fee__c = selectedoption;
               itemsbl.add(BLS1);
                system.debug('::::::::::ITEMS222222::::::::::::::'+itemsbl); 
               }
         update itemsbl;
         */
         LIST<BLN_Item__c> itemsbl = ticktbal.savetickchange(Items,selectedoption,null);
       for(BLN_Item__c BLS2 : itemsbl){
         innerlist.add(new innerclass (BLS2,BLS2.service_fee__c));
        
      }
    }
    //SVING ITEM VALS
    public void saveItemfeesettings(){
    
    system.debug('vvvvvvvvvvvvvvvvvvvvv1111111'+Apexpages.Currentpage().getparameters().get('includestring'));
    string ids = Apexpages.Currentpage().getparameters().get('includestring');
    system.debug('iiiiiiii'+ids);
    if(ids != null){
    LIST<string> idsinclude = new LIST<string> ();
    SET<string> setids = new SET<string> ();
       system.debug('iiiiiiii'+setids);
    idsinclude= ids.split(',');
    setids.addAll(idsinclude);
    List<BLN_Item__c> itemsb3 = new LIST<BLN_Item__c> ();
    for(BLN_Item__c BLS1 : Items ){
               if(setids.contains(BLS1.id))
               {
               BLS1.service_fee__c = 'Include the Eventdex fee in to the total ticket price';
               itemsb3.add(BLS1);
               }
               }
               update itemsb3;
               
    }
     system.debug('vvvvvvvvvvvvvvvvvvvvv222222'+Apexpages.Currentpage().getparameters().get('addstring') );
      string ids1 = Apexpages.Currentpage().getparameters().get('addstring');
    if(ids1 != null){
    LIST<string> idsinclude1 = new LIST<string> ();
    SET<string> setids1 = new SET<string> ();
    idsinclude1= ids1.split(',');
    setids1.addAll(idsinclude1);
    List<BLN_Item__c> itemsb4 = new LIST<BLN_Item__c> ();
    for(BLN_Item__c BLS1 : Items ){
               if(setids1.contains(BLS1.id))
               {
               BLS1.service_fee__c = 'Add Eventdex fee on top of the total ticket price';
               itemsb4.add(BLS1);
               }
               }
               update itemsb4;
               
   
    }
       Itemvals();
     
  
    }
    //INNER CLASS
    public class innerclass {
    public BLN_Item__c Itemvals {get ; set ;}
    public string selopt {get ; set ;}
    public string adds {get ; set ;}
    public string inserts {get ; set ;}
    public innerclass(BLN_Item__c Itemvals , string selopt ){
    this.Itemvals = Itemvals;
    this.selopt  = selopt ;
    adds= '';
    inserts ='';
    if(this.selopt == 'Add Eventdex fee on top of the total ticket price'){
    adds= 'checked';
    }else IF(this.selopt == 'Include the Eventdex fee in to the total ticket price'){
    inserts = 'checked';
    }
    }
    }
    
}