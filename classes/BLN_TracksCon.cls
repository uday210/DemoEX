public with sharing class BLN_TracksCon {
    
    /***********************************************************************************************
    *   Controller Name         : BLN_TracksCon
    *   Date                    : 23/07/2014 
    *   Author                  : Shruthi Reddy Gone
    *   Purpose                 : This class is for Creating Tracks.
    *
    *   Last Modified By           Date                    Purpose
    *   =============================================================================================
    *    Mallikarjuna Rao          29/07/2014            Continue After Shruthi's work(Edit, Delete)
    **************************************************************************************************/
     
    Public ID selectedeventid{get;set;}
    public List<BLN_Track__c> trackslist{get;set;}
    public MAP<ID,BLN_Track__c> trackslistMap{get;set;}
    public BLN_Track__c addEditTrack{get; set;}     // This variable will use for Create and Update Tracks object.
    public Boolean addEditTrackBool{get; set;}  
    public BLN_UtillDisplayLinks tracksComponent{get; set;}  
    
     public BLN_TracksCon(){
        
        trackslist = new  List<BLN_Track__c>();
        addEditTrack = new BLN_Track__c();
        addEditTrackBool = FALSE;
        
        system.debug('  COOKIE VALUE '+ApexPages.currentPage().getCookies().get('counter'));       
        Cookie k = ApexPages.currentPage().getCookies().get('counter');
            if(k!=null){
                selectedeventid = k.getValue();
                gettrackslist();
            }
            system.debug('  COOKIE VALUE '+k);
            system.debug('EVent Id  '+selectedeventid );     
         tracksComponent = new BLN_UtillDisplayLinks();
          BLN_Event_DAO evDAO = new BLN_Event_DAO();
          List<BLN_Event__c> eventsList =  evDAO.getEventDetails(selectedeventid);
          if(eventsList.size() > 0){
             tracksComponent.EventName =eventsList[0].Name;
        }
     
       tracksComponent.isTracksPage = 'active';
         tracksComponent.isSeminorsPageExpand = 'expand';
         tracksComponent.tablabel='Tracks';
         tracksComponent.eventId = selectedeventid ;
         tracksComponent.userPermissions(userInfo.getUserId(),selectedeventid);
     }
     
     Public void gettrackslist(){
        trackslistMap = new MAP<ID,BLN_Track__c>([SELECT ID,NAME, Event__c FROM BLN_Track__c WHERE Event__c =: selectedeventid]);
        
        trackslist = new  List<BLN_Track__c>();
        trackslist = trackslistMap.values();  
  
    }
 
   public string beforeEdit{get; set;}
   public void editTrack(){
    
        String editedTrackRecord = apexPages.currentPage().getParameters().get('editedTrackId');
        
        if(editedTrackRecord != null){
            if(trackslistMap.containsKey(editedTrackRecord)){
                 addEditTrack = new BLN_Track__c();
                 
                addEditTrack = trackslistMap.get(editedTrackRecord);
                beforeEdit = addEditTrack.Name;
                addEditTrackBool  = TRUE;
            }
        }else{
                addEditTrackBool  = TRUE;
            addEditTrack = new BLN_Track__c();
        }

   }
   
    public void removetrack(){
        String removedTrackRecord = apexPages.currentPage().getParameters().get('removedTrackId');
        database.delete(removedTrackRecord);
        gettrackslist();
    }
   
   public void saveTrack(){
        
        if(addEditTrack.Event__c == null){
            addEditTrack.Event__c = selectedeventid;
        }
        
        DataBase.Upsertresult tarackRes = Database.upsert(addEditTrack);
        if(tarackRes.isSuccess()){
            trackslistMap.put(tarackRes.getId(),  addEditTrack);
            
            trackslist = new  List<BLN_Track__c>();
            trackslist = trackslistMap.values();  
        }
        addEditTrackBool  = FALSE;
   }
   
   public void cancelTrack(){
     addEditTrack = new BLN_Track__c();
    addEditTrackBool  = FALSE;
   }
   
   
}