public with sharing class SA_ItemsController {

    public PageReference SaveSalesTax() {
    
        Database.Update(SelectedEvent, FALSE);
        Event__c updateEvent= new Event__c();
        updateEvent= [SELECT ID, Sales_Tax__c FROM Event__c WHERE ID =: SelectedEvent.Id];
        if(updateEvent.Sales_Tax__c != NULL || updateEvent.Sales_Tax__c != 0){
            LIST<Item__c> ItemsList= new LIST<Item__c>();
            LIST<Item__c> updateItemsList= new LIST<Item__c>();                
            ItemsList= [SELECT ID, Sales_Tax__c FROM Item__c WHERE Event__c =: updateEvent.Id AND isTaxable__c =: TRUE];
            if(ItemsList.size() >0){
                for(Item__c item: ItemsList){
                    item.Sales_Tax__c= updateEvent.Sales_Tax__c;
                    updateItemsList.add(item);     
                }
                Database.Update(updateItemsList, FALSE);
           }
        
        } 
        itemsList();   
        ShowSalesTax= FALSE;
        ItemPopUp= TRUE;
        return null;
    }


    public PageReference UpdateSalesTax() {
        ShowSalesTax= TRUE;
        ItemPopUp= FALSE;
        return null;
    }

    
    public Boolean ShowSalesTax{get; set;}
    // Item Variables
    public String SelectedEventId{get;set;}
    public Event__c SelectedEvent{get;set;}
    public LIST<Item__c> Items{get; set;}
    public Item__c Item{get; set;}
    public Boolean ItemPopUp{get;set;}
    public Boolean AddItemPopUp{get;set;}
    public Boolean SelectedItemMode{get;set;}
    public String TableHeading{get;set;}
    public String ItemIdParam{get;set;}
    public Id SelectedItemId{get;set;}
    public transient Blob Logo{get;set;}
    public String LogoName{get;set;}
    public Boolean myDocBool{get; set;}
    public Document mydoc{get;set;}
    public Boolean isPastEvent{get; set;}     
    public Boolean isEventAdminStaffUser{get; set;}   
    
    public SA_ItemsController(){ 
        ShowSalesTax= FALSE; 
        ItemPopUp= true;
        AddItemPopUp= false;
        myDocBool = FALSE;  
        SelectedItemMode = FALSE;
        Cookie counter = ApexPages.currentPage().getCookies().get('counter');
        if(counter !=null){
            SelectedEventId  = counter.getValue(); 
            SelectedEvent= [SELECT  ID, Sales_Tax__c, EV_Title__c, EV_HostingLocation__c, EV_HistingAddr1__c, AS_HostingCity__c, 
                            EV_HostingZipcode__c, EV_EventLogo__c, EV_StartDate__c, EV_EndDate__c, EV_HostingState__c,
                            (SELECT ID FROM MatchLeads_Days__r) 
                            FROM Event__c 
                            Where Id=:SelectedEventId];

            isPastEvent= FALSE;
            if(SelectedEvent.EV_EndDate__c < system.today()){
                isPastEvent= TRUE;                
            }
            List<User_Profile_Event__c> loginUserProfile= new LIST<User_Profile_Event__c>();
            loginUserProfile= [SELECT ID, Profile_id__r.PR_Name__c 
                               FROM User_Profile_Event__c 
                               WHERE EV_id__c =: SelectedEventId AND 
                               UEP_isActive__c =: TRUE AND
                               User_id__c =: UserInfo.getUserId()];
            
            isEventAdminStaffUser= FALSE;                               
            if(loginUserProfile.size() >0){
                for(User_Profile_Event__c prof: loginUserProfile){
                    if(prof.Profile_id__r.PR_Name__c == 'EventAdmin Staff'){
                        isEventAdminStaffUser= TRUE;
                    }
                }
            }  
            itemsList();
        }
        system.debug(' EVENT ID '+SelectedEventId  );
        
        

    }
    
     public PageReference itemsList(){
     try{
        ItemPopUp = true;
        AddItemPopUp= false;
        system.debug('****** '+SelectedEventId);
        ShowItemError= FALSE;               
        Items = [SELECT ID,Name,Cost__c,Description__c,isTaxable__c,Item_Image__c,Item_name__c,
                 Item_Quantity__c,Sales_Tax__c,Sold_Quantity__c,type__c, Available_Quantity__c 
                 FROM Item__c 
                 WHERE Event__c =:SelectedEventId];
                 
       system.debug(Items.size()+' ITEMS LIST '+Items );          
       }catch(exception ex){}
        return null;    
    }
    
    public Boolean ShowItemError{get; set;}
    
    public void deleteItem(){
    
        ShowItemError= FALSE;
       SelectedItemId = ApexPages.currentpage().getparameters().get('ItemIdParam');
       if(SelectedItemId != NULL){
           Item = [SELECT ID,Name,Cost__c,Description__c,isTaxable__c,Item_Image__c,Item_name__c,Item_Quantity__c,
                   Sales_Tax__c,Sold_Quantity__c,type__c, (SELECT ID FROM Registration_Info__r WHERE Event__c =: SelectedEventId
                   AND Event_Attendee_Mapping__c != NULL) 
                   FROM Item__c 
                   WHERE Id =: SelectedItemId];
           LIST<Dummay__c>  RegInfoList= new LIST<Dummay__c>(); 
           RegInfoList=Item.Registration_Info__r;
           if(RegInfoList.size() >0){
            ShowItemError= TRUE;               
           }else{
               database.delete(Item);
               ItemPopUp = true;
               AddItemPopUp= false;
               itemsList();
           }
      
       }        
       
    }

    public void editItem(){
        TableHeading='Edit Item';
        SelectedItemMode = true;
        ShowItemError= FALSE;
        ItemPopUp = false;
        AddItemPopUp= true;

        SelectedItemId = ApexPages.currentpage().getparameters().get('ItemIdParam');
        Item= [SELECT ID,Name,Cost__c,Description__c,isTaxable__c,Item_Image__c,Item_name__c,Item_Quantity__c,
                Sales_Tax__c, Sold_Quantity__c,type__c  
                FROM Item__c 
                WHERE Id =: SelectedItemId];
                
             
    }

    public void addItem(){
        TableHeading='Add Item';
        SelectedItemMode = true;
        ItemPopUp = false;
        AddItemPopUp= true;
        Item = new Item__c();
        Item.Cost__c=0;
    }
    
    public boolean salesTaxError{get; set;}
    
    public void  validateSalesTax(){
        system.debug(Item.isTaxable__c+' ITEM IS TAXABLE '+Item.Sales_Tax__c);
        if((Item.isTaxable__c == TRUE && (Item.Sales_Tax__c == NULL)) || (Item.isTaxable__c == FALSE && Item.Sales_Tax__c != NULL)){
            salesTaxError= TRUE;
        }else{
            salesTaxError= FALSE;
            system.debug(' SALES TAX '+Item.Sales_Tax__c );
           /* if(Item.Sales_Tax__c != NULL){
                Item.Cost__c= Item.Cost__c+ ((Item.Sales_Tax__c*Item.Cost__c)/100);            
              }
            */
            createItem();
        }
    }
    
      
    public void createItem(){
        myDocBool = TRUE;       
        if(Item.isTaxable__c == TRUE){
            Item.Sales_Tax__c= SelectedEvent.Sales_Tax__c;
        }else{
            Item.Sales_Tax__c= 0;
        }
           if(Logo != null && ( LogoName != '' || LogoName != NULL )){
               if(Logo.size()!= null){
                 
               if(Logo.size() < 1048576 ){
                    mydoc = new document();
                    mydoc.body = Logo;
                    mydoc.folderid = '00lF0000001VI7Y';
                    
                    mydoc.IsPublic = True;
                    mydoc.Name = LogoName;
                    DataBase.saveResult docSaveResult = DataBase.insert(mydoc, false);
        
                    String eventold;
        
                    if(docSaveResult.isSuccess()){
                        if(Item.Item_Image__c != null){
                            try{ 
                                eventold = Item.Item_Image__c;          
                                document dd = [SELECT ID, NAME FROM document WHERE id=: eventold];
                                Database.delete(dd);
                             }catch(exception ex){}
                        }
                        String imageURL='';
                        string urlbase =URL.getSalesforceBaseUrl().getHost();
                        string orgId = UserInfo.getOrganizationId();
                    
                        imageURL= 'https://'+urlbase+'/servlet/servlet.ImageServer?oid='+orgId+'&id='+docSaveResult.getId();
                        Item.Item_Image__c = docSaveResult.getId();
                    }
                    else{
                        myDocBool = FALSE;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, String.valueOf(docSaveResult.getErrors()))); 
                    } 
                }
                else{
                    myDocBool = FALSE; 
                }
               }            
         }
         Item.Event__c = SelectedEventId;   
         system.debug('&&&& '+Item);
         Database.UpsertResult EventupsertResult = DataBase.Upsert(Item, false);
         
         
         ItemPopUp = true;
         AddItemPopUp= false;
         itemsList();
    }
    
    public void viewItem(){
        TableHeading='Item Information';
        SelectedItemMode = false;
        ItemPopUp = false;
        AddItemPopUp= true;
        SelectedItemId = ApexPages.currentpage().getparameters().get('ItemIdParam');
        Item = [SELECT ID,Name,Cost__c,Description__c,isTaxable__c,Item_Image__c,Item_name__c,Item_Quantity__c,Sales_Tax__c,Sold_Quantity__c,type__c 
                FROM Item__c 
                WHERE Id =: SelectedItemId];
    }
    
    public void closeItem(){
        ItemPopUp = true;
        ShowSalesTax= FALSE;
        AddItemPopUp= false;
        itemslist();
    }
    
    
    public PageReference checkUserId() {
        if (userInfo.getUserType() == 'guest') {
            Pagereference pg = new pagereference('/SA_Signup');
            pg.setredirect(true);
            return pg;
        }else {
            return null;
        }
    }
    
}