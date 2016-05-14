global without sharing class BLN_event_documentsCon {
  public BLN_Event_Document__c eventDoc {get; set;}
  public BLN_UtillDisplayLinks myticket {get; set;} // This is the variable for Component
  public String selectedeventid {get; set;}
  public String orgId {get; set;}
  public Boolean displaytablebool {get; set;}
  public Boolean displayType {get; set;}
  public MAP<id, BLN_Event_Document__c> mapIdWithRec {get; set;}
  public MAP<id, Attachment> mapdocIdWithRec {get; set;}
  public String imageBody {get; set;}
  public String fileType {get; set;}
  public String imageName {get; set;}
  public String fileName {get; set;}

  public BLN_event_documentsCon() {
    Cookie k = ApexPages.currentPage().getCookies().get('counter');
    if (k != null) {
      selectedeventid = k.getValue();
    }
    myticket = new BLN_UtillDisplayLinks();
    String urlCheck =  ApexPages.currentPage().getUrl();
    if (urlCheck != '') { // checking url for knowing about currentpage
      if ((urlCheck.toLowerCase()).contains('BLN_Gallery'.toLowerCase())) {
        myticket.isgalleryPage = 'active';
        myticket.tablabel = 'Gallery';
      } else {
        myticket.isdocumentsPage = 'active';
        myticket.tablabel = 'Documents';
      }
    }
    // To height light Link
    myticket.isSeminorsPageExpand = 'expand';
    //myticket.isdocumentsPage =true;
    myticket.eventId = selectedeventid;
    myticket.userPermissions(userInfo.getUserId(), selectedeventid);
    LIST<BLN_Event__c> eventsList = new LIST<BLN_Event__c>();
    BLN_Event_DAO evDAO = new BLN_Event_DAO();
    eventsList =  evDAO.getEventDetails(selectedeventid);
    if (eventsList.size() > 0) {
      myticket.EventName = eventsList[0].Name;
      myticket.EventTimeZone = eventsList[0].Time_Zone__c;
    }
    fileType = 'Document';
    myticket.isEventAdmin = true;
    displaytablebool = true;
    displayType = true;
    orgId = UserInfo.getOrganizationId();
  }

//public List<BLN_Event_Document__c> AllDocuments;
  public List<BLN_Event_Document__c> getAllDocuments() {
    List<BLN_Event_Document__c> docs = new List<BLN_Event_Document__c>();
    mapdocIdWithRec = new MAP<id, Attachment>();
    mapIdWithRec = new MAP<id, BLN_Event_Document__c>();
    docs = [select Type__c, Name, Url__c, Image__c, Address__c, id, (SELECT name, id FROM Attachments) from BLN_Event_Document__c where BLN_Events__c = :selectedeventid and type__c = :fileType ];
    for (BLN_Event_Document__c dc : docs ) {
      mapIdWithRec.put(dc.id, dc);
      for (Attachment dms : dc.Attachments ) {
        mapdocIdWithRec.put(dms.id, dms);
      }
    }
    return docs ;
  }

  public List<SelectOption> getItems() {
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('Document', 'Documents'));
    options.add(new SelectOption('Location', 'Location'));
    return options;
  }

  public PageReference addDocument() {
    eventDoc = new BLN_Event_Document__c();
    eventDoc.type__c = fileType;
    eventDoc.BLN_Events__c = selectedeventid;
    displaytablebool = false;
    deFaultVal(eventDoc.type__c);
    return null;
  }
  public Void cancelmethod() {
    displaytablebool = true;
  }

  public Void saveMethod() {
    System.debug('UUUUUUUUU ' + imageName);
    list<String> ls = (List<String>)JSON.deserialize( Apexpages.currentPage().getParameters().get('bvs'), List<string>.class ) ;
    List<String> lsNames = (List<String>)JSON.deserialize( Apexpages.currentPage().getParameters().get('fns'), List<string>.class ) ;
    List<String> lsTypes = (List<String>)JSON.deserialize( Apexpages.currentPage().getParameters().get('fts'), List<string>.class ) ;
    String parentId = '';
    DataBase.upsertResult upres = Database.upsert(eventDoc, false);
    if (upres.isSuccess()) {
      parentId  = upres.getId();
    }
    if (eventDoc.type__c == 'Document') {
      eventDoc.Address__c = '';
      if (ls.size() > 0) {
        eventDoc.Url__c = null;
        List<Attachment> attaches = new List<Attachment>();
        for (integer ite = 0; ite < ls.size(); ite++) {
          Attachment atm = new Attachment();
          atm.name = lsNames[ite];
          atm.parentId = parentId;
          
         //atm.contentType = lsTypes[ite];
          atm.body = EncodingUtil.base64Decode(ls[ite]);
          
           atm.IsPrivate = false;
          attaches.add(atm);
        }
        Database.saveResult[] docSaveResult = DataBase.insert(attaches, false);
        System.debug('YYYYYYYYYYYYYY ' + docSaveResult );
      } else if (eventDoc.Url__c != null) {
        List<Attachment> dcs = [SELECT id from Attachment where parentId = :parentId];
        DataBase.delete(dcs, false);
      }
    } else {
      List<Attachment> dcs = [SELECT id from Attachment where parentId = :parentId];
      DataBase.delete(dcs, false);
      eventDoc.Url__c = '';
    }
    if (imageBody != null && imageBody != '') {
      List<Folder> listFolders = new List<Folder>();
       listFolders = [Select Id, Name, AccessType, Type, IsReadOnly, DeveloperName From Folder  Where Name = 'EventDocuments'];
      if(listFolders.size()<=0){
      	listFolders = [Select Id, Name, AccessType, Type, IsReadOnly, DeveloperName From Folder  Where Name = 'Shared Documents'];
      }
      
      Blob bdy = EncodingUtil.base64Decode(imageBody);
      if (bdy.size() <= 200000) {
        document mydoc = new document();
        mydoc.body = bdy ;
        if (listFolders.size() > 0)
          mydoc.folderid = listFolders[0].id;
        mydoc.IsPublic = True;
        mydoc.Name = imageName;
        mydoc.contentType = 'image/jpeg';
        DataBase.saveResult docSaveResult = DataBase.insert(mydoc, false);
        System.debug('PPPPPPPPPPPPPP ' + docSaveResult);
        if (docSaveResult.isSuccess()) {
          List<Document> dms = [select id from Document where id = :eventDoc.Image__c];
          Database.Delete(dms, false);
          eventDoc.Image__c = docSaveResult.getId();
        }
      }
    }
    System.debug('eventDoc ' + eventDoc);
    DataBase.update(eventDoc, false);
    displaytablebool = true;
  }


  public Void deFaultVal(String selval) {
    if (selval == 'Location')
      displayType = false;
    else
      displayType = true;
  }

  public void onchAct() {
    fileType = Apexpages.currentpage().getParameters().get('globalStr');
  }

  public void onChangeAct() {
    String selectedStr = Apexpages.currentpage().getParameters().get('selectedStr');
    System.debug('selectedStr  ' + selectedStr );
    deFaultVal(selectedStr );
  }

  public PageReference editDocument() {
    String eventdocEdit = Apexpages.currentpage().getParameters().get('eventDocEdit');
    eventDoc = new BLN_Event_Document__c();
    eventDoc = mapIdWithRec.get(eventDocEdit);
    deFaultVal(eventDoc.type__c);
    displaytablebool = false;
    return null;
  }

   public void deleteRec() {
      String delrec = Apexpages.currentpage().getParameters().get('delId');
      Database.delete(mapIdWithRec.get(delrec), false);
  }

  public void deleteDoc() {
    String delrec = Apexpages.currentpage().getParameters().get('docId');
    Database.delete(mapdocIdWithRec.get(delrec), false);
  }

}