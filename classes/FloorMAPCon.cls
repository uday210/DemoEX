public without sharing class FloorMAPCon {

    public FloorMAPCon(ApexPages.StandardController controller) {
        ShowList();
        showingEventMethod();
        SearchBooth = '';
       SowingListofBoothAdmins();
    }

     
    public Floor_Map__c Sample{get;set;}
    public String valueOne{get;set;}
    public List<Floor_Map__c> SampleList{get;set;}
    public String items {get;set;}
    public String eventInfo {get;set;}
    public List<Event__c> Event{get;set;}
    public Event__c ShowEvent{get;set;}
    public Boolean ShowMap{get;set;}
    public transient blob BlobFile{get;set;}
    public transient  Document AttachFile{get;set;}
    public String SoldColor{get;set;}
    public List<User_Profile_Event__c> BoothAdminsList{get;set;}
    public String SearchBooth{get;set;}
    public String SelectedCompany{get;set;}
    public List<selectOption> Option{get;set;}
    public String boothAdminListJson {get;set;}
    public List<Floor_Map__c> ListtoCreate{get;set;} 
    public List<Floor_Map__c> ListToUpdate{get;set;}
    public MAP<ID,String> ToUpdateFloorMapObj{get;set;}
    public set<ID> SetOfId{get;set;}
    public List<Booth__c> UpdateBoothLocation{get;set;}
    
   
    
    
    public Pagereference TogetTheValues(){
       
        valueOne = Apexpages.currentPage().getParameters().get('x');
        
        List<Floor_Map__c> items = (List<Floor_Map__c>) JSON.deserialize(valueOne, List<Floor_Map__c>.class);
        
        ToUpdateFloorMapObj = new MAP<ID,String>();
        Floor_Map__c ToUpdate = new  Floor_Map__c(); 
        SetOfId = new set<ID>();
         
        
        for(Floor_Map__c item: items){
           item.Event__c = Apexpages.currentPage().getParameters().get('eventId');
        }
              
         Database.UpsertResult[] MySaveResult2 = Database.upsert(items,false);
         
         for(Database.UpsertResult resp: MySaveResult2){
              
               SetOfId.add(resp.getId());
         }
         
         
         
         
          if(SetOfId.size() > 0){
          List<Floor_Map__c> ToUpdateBoothNumber = new List<Floor_Map__c>();
          
          ToUpdateBoothNumber = [select Id,Booth_Location__c,Booth__c from Floor_Map__c WHERE ID IN : SetOfId 
         
                                AND Booth__c != NULL ];
         
          SetOfId = new set<ID>();
          
          for(Floor_Map__c M : ToUpdateBoothNumber ){  
             SetOfId.add(M.Booth__c);           
             ToUpdateFloorMapObj.put(M.Booth__c,M.Booth_Location__c);             
         }
         
         
         List<Booth__c> Booths = new List<Booth__c>();
         
        
         
         Booths = [select Id,BT_Location__c from Booth__c WHERE ID IN : SetOfId];
         
         UpdateBoothLocation = new List<Booth__c>();
         
         
         for(Booth__c BB : Booths ){
         
             if(ToUpdateFloorMapObj.containsKey(BB.id)){
                 
                   BB.BT_Location__c = ToUpdateFloorMapObj.get(BB.id); 
                   
                   UpdateBoothLocation.add(BB); 
                 
             }
         
         } 
         
         Database.Update(UpdateBoothLocation,FALSE);
         
        } 
         
       
        //PageReference pageRef = new PageReference('/apex/FloorMap?eventId='+Apexpages.currentPage().getParameters().get('eventId'));
        //pageRef.setRedirect(true);
        //return pageRef;
        return null;
    }
    
    
    public void ShowList(){
        
        SampleList = new List<Floor_Map__c>();
    
        SampleList = [select id,Name,Parameters__c,Booth_Location__c,Booth_Price__c,Booth_Size__c,By_Default__c ,Type__c,
                      on_select__c,On_Hover__c,Reserved__c,Sold__c,Available__c,Booth__r.BT_Name__c,
                      Event__r.Available__c,Event__r.Sold__c,Event__r.Reserved__c,Booth_Area__c 
                      from Floor_Map__c where Event__c =: Apexpages.currentPage().getParameters().get('eventId')];
        
        items = JSON.serializePretty(SampleList);
        
        

    }
    
    public Pagereference ToDeleteTheShape(){
        
      
       
        Floor_Map__c ToDelete = [select id,Booth__c  from Floor_Map__c where 
                                id =:Apexpages.currentPage().getParameters().get('DelId')];
        
        
        If(ToDelete.Booth__c != null){
        
            Booth__c B = new Booth__c();
            B = [select id,BT_Location__c from Booth__c Where Id =:ToDelete.Booth__c ];
            B.BT_Location__c = '';
            Database.Update(B,False);        
        }
        
        Database.Delete(ToDelete );
        
        
        
     
        PageReference pageRef = new PageReference('/apex/FloorMap?eventId='+Apexpages.currentPage().getParameters().get('eventId'));
        pageRef.setRedirect(true);
        return pageRef;
        
        //ShowList();
        
    }
    
     
   public void showingEventMethod(){
        
        
        Event = new List<Event__c >();
        
        Event = [select id,Floor_Map_Image__c,Sold__c,Reserved__c,Available__c from Event__c where 
                Id=: ApexPages.CurrentPage().getParameters().get('eventId')];                
        
   
        
        
        if(Event.size()>0  ){
        
        if(Event[0].Floor_Map_Image__c != null){
            eventInfo= JSON.serializePretty(Event[0]);
        ShowEvent = Event[0];
        ShowMap = True;
        }else if(Event[0].Floor_Map_Image__c == null){        
        ShowMap = False;
        }
        }
        if (eventInfo == null) {
            eventInfo = '{}';
        }
    }
    
    public Pagereference SaveFloorMap(){
     if(BlobFile != null){
        if(BlobFile.size()!= null){
   
        AttachFile=new document();
        AttachFile.body = BlobFile;
        AttachFile.folderid = '00lF0000001VI7Y';
        
        AttachFile.IsPublic = True;
        AttachFile.Name = 'Floor Map';
        DataBase.saveResult docSaveResult = DataBase.insert(AttachFile, false);
        
        

    
    if(docSaveResult.isSuccess()){
    
            Event[0].Floor_Map_Image__c = docSaveResult.getId();
            update Event[0];
            
            
    }
    }
    }
    
    
      PageReference pageRef = new PageReference('/apex/FloorMap?eventId='+Apexpages.currentPage().getParameters().get('eventId'));
        pageRef.setRedirect(true);
        return pageRef;
  
 }
 
 public Pagereference  ForSavingColors(){
     
     ShowEvent.Available__c = Apexpages.currentPage().getParameters().get('A');
     ShowEvent.Sold__c = Apexpages.currentPage().getParameters().get('S');
     ShowEvent.Reserved__c = Apexpages.currentPage().getParameters().get('R');
     Update ShowEvent;
     
     PageReference pageRef = new PageReference('/apex/FloorMap?eventId='+Apexpages.currentPage().getParameters().get('eventId'));
     pageRef.setRedirect(true);
     return pageRef;
     //ShowList();
 }
 
     public void SowingListofBoothAdmins(){
     
   try{
     
     BoothAdminsList = new List<User_Profile_Event__c>();
     
    
     
     BoothAdminsList = [SELECT UEP_isActive__c,Name,Id,BT_id__r.BT_Name__c,BT_id__r.Table_Room_No__c,
                        BoothAdmin_id__r.FirstName,BoothAdmin_id__r.LastName,BT_id__r.BT_isBoothActive__c,
                        BT_id__c,BT_id__r.BT_Location__c,BoothAdmin_id__r.Username,BoothAdmin_id__r.Country__c,BoothAdmin_id__r.CompanyName,
                        BoothAdmin_id__r.States__c,BoothAdmin_id__r.Email,BoothAdmin_id__r.Companyphone__c,
                        BoothAdmin_id__r.LastLoginDate,BoothAdmin_id__r.CompanyAddr1__c,BT_id__r.BT_Description__c,BT_id__r.BT_WebsiteURL__c
                        FROM User_Profile_Event__c WHERE EV_id__c =:Apexpages.currentPage().getParameters().get('eventId')
                        AND Profile_id__r.PR_Name__c ='BoothAdmin' ];
                        
                        
   
    boothAdminListJson = JSON.serializePretty(BoothAdminsList);         

    
   if(BoothAdminsList.size() > 0){
    
    Option = new List<selectoption>();
    
    Option.add(new selectOption('--Select--','--Select--'));
    for(User_Profile_Event__c Company: BoothAdminsList ){
    
    Option.add(new selectOption(Company.BT_id__c,Company.BT_id__r.BT_Name__c));
    
    
    }
    }
    }catch (Exception Ex){
    
    }
    }
     
     public pagereference ForSavingBooths(){
       
        List<Floor_Map__c> CheckBoothsAlreadyAssigned = new   List<Floor_Map__c>();
        
        CheckBoothsAlreadyAssigned = [select id,Booth__c from Floor_Map__c WHERE                                     
                                      Booth__c =: Apexpages.currentPage().getParameters().get('BoothID')];
                                      
        
        if(CheckBoothsAlreadyAssigned.size() > 0){
            CheckBoothsAlreadyAssigned[0].Booth__c = null;
          
            CheckBoothsAlreadyAssigned[0].Available__c = True;
          
            CheckBoothsAlreadyAssigned[0].Sold__c = False;
           
            Database.Update(CheckBoothsAlreadyAssigned[0],false);
        
        }
        
        Floor_Map__c ToAssign = [select id,Booth__c,Name,Booth_Location__c,Parameters__c,Booth_Price__c,Booth_Size__c,on_Hover__c ,on_Select__c ,By_Default__c,
                                 Reserved__c from Floor_Map__c 
                                 where id =:Apexpages.currentPage().getParameters().get('FloorID')];
        
                 
        ToAssign.Booth__c = Apexpages.currentPage().getParameters().get('BoothID');
        ToAssign.Sold__c = True;
        ToAssign.Available__c = False;
        ToAssign.Reserved__c = False;
        
        
        Database.Update(ToAssign,false);
        
       
        Booth__c B = new Booth__c();
        
        Booth__c OldBooth = new Booth__c();
        
        
       
        B = [select Id,BT_Location__c from Booth__c Where Id =: Apexpages.currentPage().getParameters().get('BoothID')];
       
        B.BT_Location__c = ToAssign.Booth_Location__c;        
        
        Database.Update(B,False);
        
        
        
        if(Apexpages.currentPage().getParameters().get('OldBoothId') != ''){ 
               
        OldBooth  = [select Id,BT_Location__c from Booth__c Where Id =: Apexpages.currentPage().getParameters().get('OldBoothId')];
        
        OldBooth.BT_Location__c = ''; 
        
        Database.Update(OldBooth,False);
         
        }
     
         
        PageReference pageRef = new PageReference('/apex/FloorMap?eventId='+Apexpages.currentPage().getParameters().get('eventId'));
        pageRef.setRedirect(true);
        return pageRef; 
        
     }

}