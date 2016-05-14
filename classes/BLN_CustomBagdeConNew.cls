public without sharing class BLN_CustomBagdeConNew {
public string orgid {get;set;}

    
   static String selectedevent {get ; set ;}
     public list<string> jsonstr {get;set;}
   static BLN_Event__c EventName{get;set;}
     
      public static String getEvid() {
       return JSON.serialize(selectedevent);
   }
  public static String getEvname() {
       //return JSON.serialize(EventName.Name);
       return EventName.Name;
   }
    
     
    //Constructor
    public BLN_CustomBagdeConNew(){
    try{
    orgid = UserInfo.getOrganizationId();    
   
  //  foradd = false;
  //  foredit = false;
   // jsonstr = new list<string> ();
   
    selectedevent = '' ;
    Cookie k = ApexPages.currentPage().getCookies().get('counter');
         if(k!=null){ 
             selectedevent = k.getValue();
         }
         EventName=[SELECT Name FROM BLN_Event__c Where id=: selectedevent ];
  }catch(exception ex){
  EventName = new BLN_Event__c();
  }
  
    
   
    }
        

    
    

   
 
 
    
    /***new code*****/
        public class BadgeWithLayers {
        public BLN_Badge_Style__c badge {get; set;}
        public List<BLN_Badge_Layer__c> layers {get; set;}
        
        public BadgeWithLayers(BLN_Badge_Style__c badge, List<BLN_Badge_Layer__c> layers) {
        try{
            this.badge = badge;
            this.layers = layers;
        }catch(exception ex){}
        }
    }

  
    
    @RemoteAction
    public static List<BadgeWithLayers> getStyles(String EventId) {
        List<BadgeWithLayers> badges = new List<BadgeWithLayers>();
        List<BLN_Badge_Style__c> styles = [SELECT Name,Description__c,DefaultOnsiteBadge__c,Data__c,Module__c FROM BLN_Badge_Style__c WHERE  Event__c=:EventId];
        for (BLN_Badge_Style__c style: styles) {
            badges.add(new BadgeWithLayers(
                style,
                [SELECT Data__c FROM BLN_Badge_Layer__c WHERE BLN_Badge_Style_ID__c= :style.Name]
            ));
        }
        return badges;
    }
    
    
    
    
    @RemoteAction
    public static List<BadgeWithLayers> getAllStyles(String EventId) {
        List<BadgeWithLayers> badges = new List<BadgeWithLayers>();
        List<BLN_Badge_Style__c> styles = [SELECT Name,Description__c,Data__c,Event__c,Module__c,DefaultOnsiteBadge__c  FROM BLN_Badge_Style__c WHERE  Event__c !=:EventId];
        System.debug('**********************'+styles);
        for (BLN_Badge_Style__c style: styles) {
            badges.add(new BadgeWithLayers(
                style,
                [SELECT Data__c FROM BLN_Badge_Layer__c WHERE BLN_Badge_Style_ID__c= :style.Name]
            ));
        }
        return badges;
    }
    
    
    @RemoteAction
    public static BadgeWithLayers getStyle(String badgeId) {
    System.debug('{}{}{} '+badgeId);
        return new BadgeWithLayers(
            [SELECT Name,Description__c,Data__c FROM BLN_Badge_Style__c WHERE Name=:badgeId  LIMIT 1],
            [SELECT Data__c FROM BLN_Badge_Layer__c WHERE BLN_Badge_Style_ID__c = :badgeId]
        );
    }
    
    @RemoteAction
    public static String saveStyle(String badgeId, String description, String data, List<BLN_Badge_Layer__c> layers,String value,String module,String Printer,String Defaultonsitebadge) {
      
      
         
        Integer count = [SELECT count() FROM BLN_Badge_Style__c WHERE Name=:badgeId AND Event__c =:value];
        String realBadgeId = '-1';
        if (count == 1) {
            BLN_Badge_Style__c existingStyle = [SELECT Description__c,Data__c,Name FROM BLN_Badge_Style__c WHERE Name=:badgeId AND Event__c =:value];
            existingStyle.Description__c = description;
            existingStyle.Data__c = data;
            existingStyle.Module__c=module;
            existingStyle.Printer__c=Printer;
           if(Defaultonsitebadge == 'true')
           {
           existingStyle.DefaultOnsiteBadge__c=true;
           }else{
           existingStyle.DefaultOnsiteBadge__c=false;
           
           }
            update existingStyle;
            realBadgeId = badgeId;
        } else {
            BLN_Badge_Style__c newStyle = new BLN_Badge_Style__c();
            newStyle.Description__c = description;
            newStyle.Data__c = data;
            newStyle.Event__c = value;
            newStyle.Module__c=module;
            newStyle.Printer__c=Printer;
            if(Defaultonsitebadge == 'true')
           {
           newStyle.DefaultOnsiteBadge__c=true;
           }else{
           newStyle.DefaultOnsiteBadge__c=false;
           
           }
           
            
            
            insert newStyle;
            realBadgeId = [SELECT Name FROM BLN_Badge_Style__c WHERE Id=:newStyle.Id AND Event__c =:value LIMIT 1].Name;
        }
        
        List<BLN_Badge_Layer__c> allCurrentSavedLayers = [SELECT Name FROM BLN_Badge_Layer__c WHERE BLN_Badge_Style_ID__c = :realBadgeId];
        for (BLN_Badge_Layer__c currentSavedLayer: allCurrentSavedLayers) {
            Boolean layerIsInUpdateData = false;
            for (BLN_Badge_Layer__c updateLayer: layers) {
                if (updateLayer.Name == currentSavedLayer.Name) {
                    layerIsInUpdateData = true;
                }
            }
            if (!layerIsInUpdateData) {
                delete currentSavedLayer;
            }
        }
        
        for (BLN_Badge_Layer__c layer: layers) {
            count = [SELECT count() FROM BLN_Badge_Layer__c WHERE Name=:badgeId ];
            if (count == 1) {
                BLN_Badge_Layer__c existingLayer = [SELECT Data__c FROM BLN_Badge_Layer__c WHERE Name=:badgeId ];
                existingLayer.Data__c = layer.Data__c;
                update existingLayer;
            } else {
                BLN_Badge_Layer__c newLayer = new BLN_Badge_Layer__c();
                newLayer.Data__c = layer.Data__c;
                newLayer.BLN_Badge_Style_ID__c = realBadgeId;
                insert newLayer;
            }
        }
        return realBadgeId;
    }
    
    @RemoteAction
    public static Boolean renameStyle(String badgeId, String description) {
            BLN_Badge_Style__c existingStyle = [SELECT Description__c,Data__c FROM BLN_Badge_Style__c WHERE Name=:badgeId AND OwnerID = :UserInfo.getUserId()];
            existingStyle.Description__c = description;
            update existingStyle;
            return true;
    }
    
    @RemoteAction
    public static Boolean deleteStyle(String badgeId) {
        BLN_Badge_Style__c currentStyle = [SELECT Name FROM BLN_Badge_Style__c WHERE Name = :badgeId  LIMIT 1];
        Database.delete(currentStyle);
        return true;
    }
    
    @RemoteAction
    public static string regsettings() {
      //  BLN_Badge_Style__c currentStyle = [SELECT Name FROM BLN_Badge_Style__c WHERE Name = :badgeId  LIMIT 1];
       // Database.delete(currentStyle);
      //  return '["test","test"]';
      String test = 'test';
      return test;
    }
    
     
    @RemoteAction
    public static String uploadImage(String fileData, String styleId) {
    System.debug('filedate is '+fileData);
    
     List<folder> folderList =new List<folder>();
        folderList = [select id from folder where Name =: 'Shared Documents'];
        
        
        System.debug('123456 Just entered'+ folderList );
       String user = UserInfo.getUserID();
        if(fileData==null)
            return 'ERROR';
            
        String base64 = fileData.substring(fileData.indexOf(',')+1);
       // System.debug('123456 After Base 64'+);
        Blob actualdata = EncodingUtil.base64Decode(base64);
        if(actualdata.size()<=0)
            return String.valueOf('ERROR');
        //document att = new document(ParentId=styleId, Body=actualdata);
        
         
                    
        
        document att = new document();
       
         att.body = actualdata;
         
         att.folderid =folderList[0].id;
         
         att.ispublic = true;
     att.Name =  String.valueOf(Datetime.now().getTime());
    att.contentType='image/png';
        
      
        insert(att);
   
        return att.Id;
    }
  
    }