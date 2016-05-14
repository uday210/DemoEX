/***********************************************************************************************
*   Controller Name : BLN_ASC_Blocktickets
*   Date            : 10/02/2015
*   Author          : Phani Kumar Ch
*   Purpose         : This class is Web service Class to hold tickets using tickets status changed.
                       (Means blocking tickets for some time)
**************************************************************************************************/

@RestResource(urlMapping='/BLN_ASC_Blocktickets')
global class BLN_ASC_Blocktickets {
   
 @HttpPost
 global static List<ItemWithTickets> doPost(){  
    RestRequest req = RestContext.Request;
    // Fetching json body form request 
    integer sessiontime = Integer.valueof(req.params.get('sessiontime'));
    String JsonString = req.requestBody.toString(); 
    System.debug('parser string www:'+JsonString);
    ItemsWithQuan itq = new ItemsWithQuan();
    List<ItemsWithQuan> itqList = new List<ItemsWithQuan>();
    MAP<string,integer> mapIdwithint = new MAP<string,integer>();
    BLN_Item_DAO itemDao = new BLN_Item_DAO();
    List<ItemWithTickets> itemTickets = new  List<ItemWithTickets>();
    List<id> TciketsIdsFrScduler;
    
    JSONParser parser = JSON.createParser(JsonString);
    System.debug('parser string:'+parser);
      while (parser.nextToken() != null){     
        if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
           itq = (ItemsWithQuan)parser.readValueAs(ItemsWithQuan.class);// typecasting to object type
           mapIdwithint.put(itq.ItemId,integer.valueOf(itq.Qty));
           system.debug('itq ==='+ itq);
          }
       }
    BLN_Quick_Registration_BAL QuickRegBAL = new BLN_Quick_Registration_BAL();
     List<Ticket__c> listOfabandonedTics  = new List<Ticket__c>();
     boolean isAllticketsAvailble = true;
     //Fetching items for getting tickets
      
        BLN_Ticket_DAO TicketDAO = new BLN_Ticket_DAO();
       
         
     for(BLN_Item__c item :itemDao.ItemDetails(mapIdwithint.keySet())){
        /* Integer RecordCount = mapIdwithint.get(item.id);
         LIST<Ticket__c> TicketList = new LIST<Ticket__c>();
         LIST<Ticket__c> PackageTickets = new LIST<Ticket__c>();
        
         if(item.Item_Type__r.Name!='Package'){
            TicketList = TicketDAO.getTickets('id,Item__r.item_type__r.Name,name,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Item_Pool__r.Package_Flag__c,Parent_ID__c,Item_Pool__r.Badgable__c','Event__c=\''+item.Event__c +'\' AND Item__r.item_name__c=\''+item.item_name__c+'\' AND Ticket_Status__c=\'Available\' AND Parent_ID__c=null ORDER BY Name LIMIT '+ RecordCount);     
         }else{
              TicketList = TicketDAO.getTickets('id,Item__r.item_type__r.Name,name,Event__c,Item__r.item_name__c,Item_Pool__r.Item_Pool_Name__c,item__r.Ticket_Settings__c,Item_Pool__r.Ticket_Settings__c,Item_Type__r.name,Ticket_Status__c,Item_Pool__r.Package_Flag__c,Parent_ID__c,Item_Pool__r.Badgable__c','Event__c=\''+item.Event__c +'\' AND Item__r.item_name__c=\''+item.item_name__c+'\' AND Ticket_Status__c=\'Available\' AND Parent_ID__c=null ORDER BY Name LIMIT '+ RecordCount);     
              for(Ticket__c tc : TicketList ){
                   PackageTickets.addAll(TicketDAO.getTickets('id,name,Event__c,Item__r.item_type__r.Name,Item_Pool__r.Item_Pool_Name__c,Item__r.item_name__c,Item_Pool__r.Ticket_Settings__c,Client_GN_User__c,Client_Company__c,Order__c,Order_Item__c,item__r.Ticket_Settings__c,Item_Type__r.name,Parent_ID__c,Item_Pool__r.Package_Flag__c,Item_Pool__r.Badgable__c,Ticket_Status__c','Ticket_Status__c=\'Available\' and  Parent_ID__c=\''+tc.id+'\'')); 
                }
             }
          listOfabandonedTics.addAll(TicketList);  
          listOfabandonedTics.addAll(PackageTickets);  
         }    */
         List<Ticket__c> tcList = new List<Ticket__c>();
          if(item.Item_Type__r.Name!='Package'){
            tcList = QuickRegBAL.getTicketDetail(item, mapIdwithint.get(item.id)); 
           }else{
              Item.Ticket_Settings__c = 'Collect info from All Attendees' ;
               tcList = QuickRegBAL.getTicketDetail(item, mapIdwithint.get(item.id));  
           } 
            
                
             if(tcList.size() >= mapIdwithint.get(item.id)){
                 itemTickets.add(new ItemWithTickets(item.id,tcList,tcList.size()));
                 listOfabandonedTics.addAll(tcList);
             }else{
                  itemTickets.add(new ItemWithTickets(item.id,new List<Ticket__c>(),tcList.size()));
                  isAllticketsAvailble = false;
              }
           }
         
           breakBlockticketsLoop.bvalue =false; // This is for not fire triggers on Item Object
         
           List<Ticket__c> listOfabandonedupd  = new List<Ticket__c>();
            TciketsIdsFrScduler = new List<id>();
             if(isAllticketsAvailble){
               for(Ticket__c tc :listOfabandonedTics){
                tc.Ticket_Status__c  ='Reserved';
                listOfabandonedupd.add(tc);
                 TciketsIdsFrScduler.add(tc.id);
               }
               BLN_generateScanId createScanId = new BLN_generateScanId();
               createScanId.insertScanId(listOfabandonedupd);
            }
   
    //Bln_Scheduler_ticketStatus scCls =new Bln_Scheduler_ticketStatus(sessiontime,TciketsIdsFrScduler);
     Bln_Scheduler_ticketStatus scCls = new Bln_Scheduler_ticketStatus();
    String SchedulerIdToAbart = scCls.Bln_Scheduler(SessionTime, TciketsIdsFrScduler);
   
     return itemTickets;
   }// Do post Method end 
    
   // Inner class to hold items and its quantities
     global class ItemsWithQuan{
        public string ItemId{get;set;}
        public string Qty{get;set;}     
          
     }
   
   // inner calss for responce 
   global class ItemWithTickets{
     public id  ItemId{get;set;}    
     public List<Ticket__c> ticketsList{get;set;}
     public integer tickesAvilable{get;set;}
     public  ItemWithTickets(string itid,List<Ticket__c> ticketsList1,integer tickesAvilable1){
        ticketsList = new List<Ticket__c>();
        tickesAvilable = 0;
        this.ItemId = itid;
        this.ticketsList = ticketsList1;
        this.tickesAvilable =tickesAvilable1;
        
     }    
  }
   
   
}