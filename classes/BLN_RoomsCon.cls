public with sharing class BLN_RoomsCon {

         
    /***********************************************************************************************
    *   Controller Name         : BLN_TracksCon
    *   Date                    : 29/07/2014 
    *   Author                  : Mallikarjuna Rao
    *   Purpose                 : This class is for Creating Rooms.
    *
    *   Last Modified By           Date                    Purpose
    *   =============================================================================================
    *    Mallikarjuna Rao          29/07/2014            Create Page
    **************************************************************************************************/
     
    Public ID selectedeventid{get;set;}
    public List<BLN_Room__c> roomslist{get;set;}
    public MAP<ID,BLN_Room__c> roomsListMap{get;set;}
    public BLN_Room__c addEditRoom{get; set;}           // This variable will use for Create and Update Tracks object.
    public Boolean addEditRoomBool{get; set;}   
    public BLN_Event__c event{get;set;}
    public BLN_UtillDisplayLinks roomsComponent{get; set;}   
    
     public BLN_RoomsCon(){
                
                roomslist = new  List<BLN_Room__c>();
            addEditRoom = new BLN_Room__c();
                addEditRoomBool = FALSE;
                
                Cookie k = ApexPages.currentPage().getCookies().get('counter');
            if(k!=null){
                selectedeventid = k.getValue();
                gettrackslist();
            }
            
            BLN_PromoCode_BAL  blneventdetailbal = new BLN_PromoCode_BAL ();
           event = new BLN_Event__c();
           event = blneventdetailbal.eventdetails(selectedeventid); 
            roomsComponent = new  BLN_UtillDisplayLinks();
           
             
         roomsComponent.EventName = event.Name;
         roomsComponent.isroomsPage = 'active';
         roomsComponent.isSeminorsPageExpand = 'expand';
         roomsComponent.tablabel='Rooms';
         roomsComponent.eventId = selectedeventid ;
         roomsComponent.userPermissions(userInfo.getUserId(),selectedeventid);
            
            
     }
     
     
     Public void gettrackslist(){
        roomsListMap = new MAP<ID,BLN_Room__c>([SELECT ID,NAME, Event__c, Room_Number__c FROM BLN_Room__c WHERE Event__c =: selectedeventid]);
        
            roomslist = new  List<BLN_Room__c>();
            roomslist = roomsListMap.values();  
  
    }
 
   public string beforeEdit{get; set;}
   public void editRoom(){
        
                String editedRoomRecord = apexPages.currentPage().getParameters().get('editedRoomId');
                
                if(editedRoomRecord != null){
                        if(roomsListMap.containsKey(editedRoomRecord)){
                                 addEditRoom = new BLN_Room__c();
                             addEditRoom = roomsListMap.get(editedRoomRecord);
                            beforeEdit = addEditRoom.Name;
                         }
                }else{
                     //   addEditRoomBool  = TRUE;
                        addEditRoom = new BLN_Room__c();
                }
       addEditRoomBool  = TRUE;
   }
   
   public void removeRoom(){
        String removedRoomRecord = apexPages.currentPage().getParameters().get('removedRoomId');
        database.delete(removedRoomRecord);
        gettrackslist();
    }
    
   public void saveTrack(){
                
             /*    
                addEditRoom.Room_Number__c = apexpages.currentpage().getparameters().get('roomEntry');
                addEditRoom.Name = apexpages.currentpage().getparameters().get('roomNum');
      */           
                 system.debug('FFFFFFFFFFFFFRRRRRRRRRRRRRRR   '+ addEditRoom.Room_Number__c+'       '+ addEditRoom.Name);
                 
                if(addEditRoom.Event__c == null){
                        addEditRoom.Event__c = selectedeventid;
                }
                
                DataBase.Upsertresult roomsRes = Database.upsert(addEditRoom);
                if(roomsRes.isSuccess()){
                        roomsListMap.put(roomsRes.getId(),  addEditRoom);
                        
                        roomslist = new  List<BLN_Room__c>();
                roomslist = roomsListMap.values();  
                }
                addEditRoomBool  = FALSE;
   }
   
   public void cancelTrack(){
         addEditRoom = new BLN_Room__c();
        addEditRoomBool  = FALSE;
   }
   
   


}